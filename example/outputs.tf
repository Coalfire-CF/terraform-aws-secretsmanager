output "secret_arns" {
  description = "The ARN values of the generated secrets"
  value       = module.credentials.secret_arns
}

output "secrets" {
  description = "Returns all secrets generated by the secrets manager module"
  sensitive   = true
  value       = module.credentials.secret_arns
}

output "names" {
  description = "Returns list of secret names to be created."
  value       = module.credentials.secret_arns
}

output "path" {
  description = "Path to secret values"
  value       = module.credentials.path
}

output "secret_iam_policy_doc_json" {
  description = "JSON doc of the policy output to use on roles if desired"
  value       = module.credentials.secret_arns
}