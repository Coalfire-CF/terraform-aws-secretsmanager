resource "aws_secretsmanager_secret" "this" {
  for_each                = local.secret_input
  name                    = "${var.path}${each.value}"
  description             = each.key ? null : ""
  kms_key_id              = var.kms_key_id
  tags                    = merge(var.tags, var.global_tags, var.regional_tags)
  policy                  = var.shared ? null : "{}"
  recovery_window_in_days = var.recovery_window_in_days
}
resource "aws_secretsmanager_secret_policy" "shared" {
  for_each = var.shared ? local.secret_input : []

  secret_arn = aws_secretsmanager_secret.this[each.key].arn

  policy = data.aws_iam_policy_document.resource_policy_MA.json
}

data "aws_iam_policy_document" "resource_policy_MA" {
  dynamic "statement" {
    for_each = var.cross_account_ids != null ? var.cross_account_ids : [""]
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
        identifiers = [
        "arn:${var.partition}:iam::${statement.value}:root"]
        type = "AWS"
      }
    }
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each      = var.empty_value ? [] : local.secret_input
  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = random_password.password[each.key].result

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

resource "random_password" "password" {
  for_each         = var.empty_value ? [] : local.secret_input
  length           = var.length
  special          = var.special
  override_special = var.override_special
  min_lower        = var.min_lower
  min_upper        = var.min_upper
  min_numeric      = var.min_numeric
  min_special      = var.min_special
}
