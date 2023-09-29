output "secret_arns" {
  value       = aws_secretsmanager_secret.this.*.arn
  description = "The ARN values of the generated secrets"
}

output "secrets" {
  sensitive   = true
  value       = aws_secretsmanager_secret_version.this.*.secret_string
  description = "Returns all secrets generated by the secrets manager module"
}

output "names" {
  value       = var.names
  description = "Returns list of secret names to be created."
}

output "path" {
  value       = var.path
  description = "Path to secret values"
}

output "secret_iam_policy_doc_json" {
  value = data.aws_iam_policy_document.resource_policy_MA.json
  description = "JSON doc of the policy output to use on roles if desired"
}