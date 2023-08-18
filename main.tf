data "aws_caller_identity" "current" {}

resource "aws_secretsmanager_secret" "this" {
  count      = length(var.names)
  name       = "${var.path}${var.names[count.index]}"
  kms_key_id = var.kms_key_id
  tags       = contains(var.shared_secrets, var.names[count.index]) ? { Shared = "yes" } : { Shared = "no" }
  policy     = contains(var.shared_secrets, var.names[count.index]) ? null : "{}"
}
resource "aws_secretsmanager_secret_policy" "shared" {
  for_each = length(var.shared_secrets) != 0 ? {
    for k, v in aws_secretsmanager_secret.this[*].tags : k => v
    if lookup(v,"Shared",null) == "yes"
  } : {}
  secret_arn = aws_secretsmanager_secret.this[each.key].arn

  policy = data.aws_iam_policy_document.resource_policy_MA.json
}

data "aws_iam_policy_document" "resource_policy_MA" {
  dynamic "statement" {
    for_each = var.cross_account_ids != null ? var.cross_account_ids : [""]
    content {
      effect = "Allow"
      actions = [
      "secretsmanager:GetSecretValue"]
      resources = [
      "*"]
      principals {
        identifiers = [
        "arn:${var.partition}:iam::${statement.value}:root"]
        type = "AWS"
      }
    }
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.empty_value ? 0 : length(var.names)
  secret_id     = aws_secretsmanager_secret.this[count.index].id
  secret_string = random_password.password[count.index].result

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

resource "random_password" "password" {
  count            = var.empty_value ? 0 : length(var.names)
  length           = var.length
  special          = var.special
  override_special = var.override_special
  min_lower        = var.min_lower
  min_upper        = var.min_upper
  min_numeric      = var.min_numeric
  min_special      = var.min_special
}

resource "aws_secretsmanager_secret_rotation" "pgsql_sec_rotation" {
  count = var.pgsql_auto_secret_rotation ? 1 * var.pgsql_auto_secret_rotation : 0
  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = aws_lambda_function.this.arn

  rotation_rules {
    automatically_after_days = 30
  }
}

resource "aws_secretsmanager_secret_rotation" "other_sec_rotation" {
  count = var.other_auto_secret_rotation ? 1 * var.other_auto_secret_rotation : 0
  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = aws_lambda_function.this.arn

  rotation_rules {
    automatically_after_days = 30
  }
}