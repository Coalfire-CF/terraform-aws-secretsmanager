resource "aws_secretsmanager_secret" "this" {
  for_each                = toset([for k,v in var.secret_naming_descrip: k ])
  name                    = "${var.path}${(keys(var.secret_naming_descrip))}"
  description             = "${var.secret_naming_descrip[*].value}" ? null : ""
  kms_key_id              = var.kms_key_id
  tags                    = merge(var.tags, var.global_tags, var.regional_tags)
  policy                  = var.shared ? null : "{}"
  recovery_window_in_days = var.recovery_window_in_days
}
resource "aws_secretsmanager_secret_policy" "shared" {
  for_each = var.shared ? toset([for k,v in var.secret_naming_descrip: k ]) : {}

  secret_arn = aws_secretsmanager_secret.this["${(keys(var.secret_naming_descrip))}"].arn

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
  for_each      = var.empty_value ? {} : toset([for k,v in var.secret_naming_descrip: k ])
  secret_id     = aws_secretsmanager_secret.this["${(keys(var.secret_naming_descrip))}"].id
  secret_string = random_password.password["${(keys(var.secret_naming_descrip))}"].result

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

resource "random_password" "password" {
  for_each         = var.empty_value ? {} : toset([for k,v in var.secret_naming_descrip: k ])
  length           = var.length
  special          = var.special
  override_special = var.override_special
  min_lower        = var.min_lower
  min_upper        = var.min_upper
  min_numeric      = var.min_numeric
  min_special      = var.min_special
}
