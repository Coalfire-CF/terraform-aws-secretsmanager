output "secret_arns" {
  description = "The ARN values of the generated secrets"
  value       = {
    for k, v in aws_secretsmanager_secret.this : k => v.arn
  }
}

output "names" {
  value       = values(aws_secretsmanager_secret.this)[*].name
  description = "Returns list of secret names to be created."
}

output "path" {
  value       = var.path
  description = "Path to secret values"
}

output "secret_iam_policy_doc_json" {
  value       = try(data.aws_iam_policy_document.resource_policy_MA[0].json, null)
  description = "JSON doc of the policy output to use on roles if desired"
}