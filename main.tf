resource "aws_secretsmanager_secret" "this" {
  for_each                = { for s in var.secrets : s.secret_name => s }
  name                    = "${var.path}${each.key}"
  description             = coalesce(each.value.secret_description, "secret for ${each.key}")
  kms_key_id              = var.kms_key_id
  tags                    = merge(var.tags, var.global_tags, var.regional_tags)
  policy                  = var.shared ? null : "{}"
  recovery_window_in_days = var.recovery_window_in_days

  # For rare edge-cases where cross-region secret replication is desired
  dynamic "replica" {
    for_each = var.replicas
    content {
      region     = replica.value.region
      kms_key_id = replica.value.kms_key_arn # ARN is preferred to avoid perpetual diff
    }
  }
}

resource "aws_secretsmanager_secret_policy" "shared" {
  for_each = var.shared ? { for s in var.secrets : s.secret_name => s } : {}

  secret_arn = aws_secretsmanager_secret.this[each.key].arn

  policy = data.aws_iam_policy_document.resource_policy_MA[0].json
}

data "aws_iam_policy_document" "resource_policy_MA" {
  count = var.shared ? 1 : 0

  # Regular cross-account secrets sharing (no AWS Organizations)
  dynamic "statement" {
    for_each = length(var.organization_ids) == 0 && length(var.cross_account_ids) > 0 ? var.cross_account_ids : []
    content {
      effect = "Allow"
      actions = [
        "secretsmanager:ListSecrets",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ]
      resources = values(aws_secretsmanager_secret.this)[*].arn
      principals {
        identifiers = ["arn:${var.partition}:iam::${statement.value}:root"]
        type        = "AWS"
      }
    }
  }

  # Using AWS Organizations
  dynamic "statement" {
    for_each = length(var.organization_ids) > 0 ? var.organization_ids : []
    content {
      effect = "Allow"
      actions = [
        "secretsmanager:ListSecrets",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ]
      resources = values(aws_secretsmanager_secret.this)[*].arn
      principals {
        type = "AWS"
        identifiers = ["*"]
      }
      condition {
        test     = "StringEquals"
        variable = "aws:PrincipalOrgID"
        values   = [statement.value]
      }
    }
  }
}

ephemeral "aws_secretsmanager_secret_version" "this" {
  for_each      = var.empty_value ? {} : { for s in var.secrets : s.secret_name => s }

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = data.aws_secretsmanager_random_password.random_passwords[each.key].random_password

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

data "aws_secretsmanager_random_password" "random_passwords" {
  for_each = var.empty_value ? {} : { for s in var.secrets : s.secret_name => s }

  exclude_characters         = var.exclude_characters
  exclude_lowercase          = var.exclude_lowercase
  exclude_numbers            = var.exclude_numbers
  exclude_punctuation        = var.exclude_punctuation
  exclude_uppercase          = var.exclude_uppercase
  include_space              = var.include_space
  password_length            = var.password_length
  require_each_included_type = var.require_each_included_type
}
