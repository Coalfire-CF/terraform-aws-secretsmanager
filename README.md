![Coalfire](coalfire_logo.png)


# AWS Secrets Manager Terraform Module

## Description

This module creates secrets in AWS Secrets Manager. The varible `names` is a list that will be used to create secrets for however many values are passed into the list.

## Dependencies

No dependencies.

## Resource List

- Secrets Manager Secret
- Secret Policy
- Secret Version

## Deployment Steps

This module can be called as outlined below.

- Change directories to the directory that requires secrets and source the module as shown below.
- From the directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

## Usage

The below example is how you can call secrets manager module to create secrets as needed. One important note is ensuring you exclude any characters for systems such as PGSQL. As there can be issues with the characters accepted by it. It's best to exclude `#$/_%&"'=`

If secrets need to be shared between AWS accounts, set "shared = true" and also provide "cross_account_ids".

```hcl
locals{
  secrets = [
    {
    secret_name = "test123"
    secret_description = "test service account for the 123 service"
    }, 
    {
     secret_name = "svc_test456"
    secret_description = ""
    }
  ]
}


module "secrets" {
  source = "github.com/Coalfire-CF/terraform-aws-secretsmanager"
  
  partition = var.partition
  secrets = local.secrets
  length = 15
  special = true
  override_special = "$%&!"
  kms_key_id = data.terraform_remote_state.setup.sm_kms_key_id
  path = ""
  shared = false
  cross_account_ids = [""]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.resource_policy_MA](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_account_ids"></a> [cross\_account\_ids](#input\_cross\_account\_ids) | A list of strings containing the account IDs of AWS accounts that should have cross-account access to this secret | `list(string)` | `null` | no |
| <a name="input_empty_value"></a> [empty\_value](#input\_empty\_value) | Whether the secret should be generated without a value | `bool` | `false` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | a map of strings that contains global level tags | `map(string)` | `{}` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. | `string` | n/a | yes |
| <a name="input_length"></a> [length](#input\_length) | The length of the password to be generated | `number` | `15` | no |
| <a name="input_min_lower"></a> [min\_lower](#input\_min\_lower) | Minimum number of lower case characters | `number` | `1` | no |
| <a name="input_min_numeric"></a> [min\_numeric](#input\_min\_numeric) | Minimum number of numeric characters | `number` | `1` | no |
| <a name="input_min_special"></a> [min\_special](#input\_min\_special) | Minimum number of special characters | `number` | `1` | no |
| <a name="input_min_upper"></a> [min\_upper](#input\_min\_upper) | Minimum number of upper case characters | `number` | `1` | no |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | Provide your own list of special characters | `string` | `"_%@!"` | no |
| <a name="input_partition"></a> [partition](#input\_partition) | The AWS partition to use | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path to organize secrets | `string` | n/a | yes |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that AWS Secrets Manager waits before it can delete the secret. | `number` | `30` | no |
| <a name="input_regional_tags"></a> [regional\_tags](#input\_regional\_tags) | a map of strings that contains regional level tags | `map(string)` | `{}` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Specifies the friendly name of the new secrets to be created as key and an optional value field for descriptions | `list(map(string))` | n/a | yes |
| <a name="input_shared"></a> [shared](#input\_shared) | Whether secrets should be shared across accounts. | `bool` | `false` | no |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in random password string | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_names"></a> [names](#output\_names) | Returns list of secret names to be created. |
| <a name="output_path"></a> [path](#output\_path) | Path to secret values |
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | The ARN values of the generated secrets |
| <a name="output_secret_iam_policy_doc_json"></a> [secret\_iam\_policy\_doc\_json](#output\_secret\_iam\_policy\_doc\_json) | JSON doc of the policy output to use on roles if desired |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Returns all secrets generated by the secrets manager module |
<!-- END_TF_DOCS -->

## Contributing

If you're interested in contributing to our projects, please review the [Contributing Guidelines](CONTRIBUTING.md). And send an email to [our team](contributing@coalfire.com) to receive a copy of our CLA and start the onboarding process.

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.resource_policy_MA](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_account_ids"></a> [cross\_account\_ids](#input\_cross\_account\_ids) | A list of strings containing the account IDs of AWS accounts that should have cross-account access to this secret | `list(string)` | `null` | no |
| <a name="input_empty_value"></a> [empty\_value](#input\_empty\_value) | Whether the secret should be generated without a value | `bool` | `false` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | a map of strings that contains global level tags | `map(string)` | `{}` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. | `string` | n/a | yes |
| <a name="input_length"></a> [length](#input\_length) | The length of the password to be generated | `number` | `15` | no |
| <a name="input_min_lower"></a> [min\_lower](#input\_min\_lower) | Minimum number of lower case characters | `number` | `1` | no |
| <a name="input_min_numeric"></a> [min\_numeric](#input\_min\_numeric) | Minimum number of numeric characters | `number` | `1` | no |
| <a name="input_min_special"></a> [min\_special](#input\_min\_special) | Minimum number of special characters | `number` | `1` | no |
| <a name="input_min_upper"></a> [min\_upper](#input\_min\_upper) | Minimum number of upper case characters | `number` | `1` | no |
| <a name="input_names"></a> [names](#input\_names) | Specifies the friendly name of the new secrets to be created | `list(string)` | n/a | yes |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | Provide your own list of special characters | `string` | `"_%@!"` | no |
| <a name="input_partition"></a> [partition](#input\_partition) | The AWS partition to use | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path to organize secrets | `string` | n/a | yes |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that AWS Secrets Manager waits before it can delete the secret. | `number` | `30` | no |
| <a name="input_regional_tags"></a> [regional\_tags](#input\_regional\_tags) | a map of strings that contains regional level tags | `map(string)` | `{}` | no |
| <a name="input_shared"></a> [shared](#input\_shared) | Whether secrets should be shared across accounts. | `bool` | `false` | no |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in random password string | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_names"></a> [names](#output\_names) | Returns list of secret names to be created. |
| <a name="output_path"></a> [path](#output\_path) | Path to secret values |
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | The ARN values of the generated secrets |
| <a name="output_secret_iam_policy_doc_json"></a> [secret\_iam\_policy\_doc\_json](#output\_secret\_iam\_policy\_doc\_json) | JSON doc of the policy output to use on roles if desired |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Returns all secrets generated by the secrets manager module |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
