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

The below examples are how you can call secrets manager module to create secrets as needed. 

### Shared Secrets
Set "shared = true" and provide the AWS Organization IDs that you want to share the secrets with:
```hcl
data "aws_organizations_organization" "current" {
  provider = aws.current
}

module "gitlab_ad_credentials" {
  source = "github.com/Coalfire-CF/terraform-aws-secretsmanager?ref=v2.1.0"
  providers = {
    aws = aws.current
  }

  kms_key_id = data.terraform_remote_state.account-setup.outputs.sm_kms_key_arn
  secrets = [
    {
      secret_name        = "svc_gitlab"
      secret_description = "Unprivileged AD user with read-only access intended to read LDAP."
    }
  ]
  path                    = "${var.ad_secrets_path}credentials/"
  partition               = data.aws_partition.current.partition
  recovery_window_in_days = var.recovery_window_in_days

  # Random Password
  password_length = 20

  # Sharing
  shared           = true
  organization_ids = [data.aws_organizations_organization.current.id]
}
```

OR

If secrets need to be shared between AWS accounts, set "shared = true" and also provide "cross_account_ids".
```hcl
module "gitlab_ad_credentials" {
  source = "github.com/Coalfire-CF/terraform-aws-secretsmanager?ref=v2.1.0"
  providers = {
    aws = aws.current
  }

  kms_key_id = data.terraform_remote_state.account-setup.outputs.sm_kms_key_arn
  secrets = [
    {
      secret_name        = "svc_gitlab"
      secret_description = "Unprivileged AD user with read-only access intended to read LDAP."
    }
  ]
  path                    = "${var.ad_secrets_path}credentials/"
  partition               = data.aws_partition.current.partition
  recovery_window_in_days = var.recovery_window_in_days

  # Random Password
  password_length = 20

  # Sharing
  shared            = true
  cross_account_ids = ["XXXXXXXXXXXX"]
}
```

### Cross-region Replication
This is more of an edge use-case.
Provide a list of maps to "replicas" which includes the AWS Region you want to replicate the secret to, as well as a KMS Key ARN for the key you want to use to encrypt the secret.
```hcl
module "gitlab_ad_credentials" {
  source = "github.com/Coalfire-CF/terraform-aws-secretsmanager?ref=v2.1.0"
  providers = {
    aws = aws.current
  }

  kms_key_id = data.terraform_remote_state.account-setup.outputs.sm_kms_key_arn
  secrets = [
    {
      secret_name        = "svc_gitlab"
      secret_description = "Unprivileged AD user with read-only access intended to read LDAP."
    }
  ]
  path                    = "${var.ad_secrets_path}credentials/"
  partition               = data.aws_partition.current.partition
  recovery_window_in_days = var.recovery_window_in_days

  # Random Password
  password_length = 20

  # Sharing
  shared           = true
  organization_ids = [data.aws_organizations_organization.current.id]

  # Replication
  replicas = [
    {
      region = "us-gov-east-1"
      kms_key_arn = var.replica_region_sm_kms_key_arn
    }
  ]
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.10.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.85.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.85.0, < 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_iam_policy_document.resource_policy_MA](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_secretsmanager_random_password.random_passwords](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_random_password) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_account_ids"></a> [cross\_account\_ids](#input\_cross\_account\_ids) | A list of strings containing the account IDs of AWS accounts that should have cross-account access to this secret | `list(string)` | `[]` | no |
| <a name="input_empty_value"></a> [empty\_value](#input\_empty\_value) | Whether the secret should be generated without a value | `bool` | `false` | no |
| <a name="input_exclude_characters"></a> [exclude\_characters](#input\_exclude\_characters) | String of the characters that you don't want in the password | `string` | `"\" # $ % & ' ( ) * + , . / : ; < = > ? @ [ \\ ] ^ ` { \| } ~" | no |
| <a name="input_exclude_lowercase"></a> [exclude\_lowercase](#input\_exclude\_lowercase) | Specifies whether to exclude lowercase letters from the password | `bool` | `false` | no |
| <a name="input_exclude_numbers"></a> [exclude\_numbers](#input\_exclude\_numbers) | Specifies whether to exclude numbers from the password | `bool` | `false` | no |
| <a name="input_exclude_punctuation"></a> [exclude\_punctuation](#input\_exclude\_punctuation) | Specifies whether to exclude punctuation characters from the password: ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ \_ ` { | } ~` | `bool` | `false` | no |
| <a name="input_exclude_uppercase"></a> [exclude\_uppercase](#input\_exclude\_uppercase) | Specifies whether to exclude uppercase letters from the password | `bool` | `false` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | a map of strings that contains global level tags | `map(string)` | `{}` | no |
| <a name="input_include_space"></a> [include\_space](#input\_include\_space) | Specifies whether to include the space character | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. | `string` | n/a | yes |
| <a name="input_organization_ids"></a> [organization\_ids](#input\_organization\_ids) | The AWS Organization ID to share secrets with. If specified, cross\_account\_ids will be ignored | `list(string)` | `[]` | no |
| <a name="input_partition"></a> [partition](#input\_partition) | The AWS partition to use | `string` | n/a | yes |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | Length of the password | `number` | `15` | no |
| <a name="input_path"></a> [path](#input\_path) | Path to organize secrets | `string` | n/a | yes |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that AWS Secrets Manager waits before it can delete the secret. | `number` | `30` | no |
| <a name="input_regional_tags"></a> [regional\_tags](#input\_regional\_tags) | a map of strings that contains regional level tags | `map(string)` | `{}` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | List of regions to replicate the secret to. Each replica can optionally specify a KMS key | <pre>list(object({<br/>    region = string<br/>    kms_key_arn = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_require_each_included_type"></a> [require\_each\_included\_type](#input\_require\_each\_included\_type) | Specifies whether to include at least one upper and lowercase letter, one number, and one punctuation | `bool` | `true` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Specifies the friendly name of the new secrets to be created as key and an optional value field for descriptions | `list(map(string))` | n/a | yes |
| <a name="input_shared"></a> [shared](#input\_shared) | Whether secrets should be shared across accounts. | `bool` | `false` | no |
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

Copyright © 2025 Coalfire Systems Inc.
