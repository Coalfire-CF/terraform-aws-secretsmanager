<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

# Coalfire pak README Template

## ACE-AWS-SecretsManager

## Dependencies


## Resource List

Insert a high-level list of resources created as a part of this module. E.g.

- Storage Account

## Code Updates

## Deployment Steps

This module can be called as outlined below.

- Change directories to the directory that requires secrets and source the module as shown below.
- From the directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

## Usage

Include example for how to call the module below with generic variables

```hcl
module "secrets" {
  source                    = "github.com/Coalfire-CF/ACE-AWS-SecretsManager?ref=vX.X.X"
  
  partition = var.partition
  names = [""]
  length = 15
  special = ""
  override_special = "$%&!"
  kms_key_id = data.terraform_remote_state.setup.sm_kms_key_id
  path = ""
  cross_account_ids = [""]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.resource_policy_MA](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_account_ids"></a> [cross\_account\_ids](#input\_cross\_account\_ids) | A list of strings containing the account IDs of AWS accounts that should have cross-account access to this secret | `list(string)` | `null` | no |
| <a name="input_empty_value"></a> [empty\_value](#input\_empty\_value) | Whether the secret should be generated without a value | `bool` | `false` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | a map of strings that contains global level tags | `map(string)` | n/a | yes |
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
| <a name="input_regional_tags"></a> [regional\_tags](#input\_regional\_tags) | a map of strings that contains regional level tags | `map(string)` | n/a | yes |
| <a name="input_shared_secrets"></a> [shared\_secrets](#input\_shared\_secrets) | Secrets that should be shared across accounts. | `list(string)` | `[]` | no |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in random password string | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_names"></a> [names](#output\_names) | Returns list of secret names to be created. |
| <a name="output_path"></a> [path](#output\_path) | Path to secret values |
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | The ARN values of the generated secrets |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Returns all secrets generated by the secrets manager module |
<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
