<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

# Coalfire pak README Template

## ACE-AWS-SecretsManager

## Dependencies

List any dependencies here. E.g. security-core, region-setup

## Resource List

Insert a high-level list of resources created as a part of this module. E.g.

- Storage Account

## Code Updates

## Deployment Steps

This module can be called as outlined below.

- Change directories to the `reponame` directory.
- From the `terraform/azure/reponame` directory run `terraform init`.
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

ALLOW TERRAFORM MARKDOWN GITHUB ACTION TO POPULATE THE BELOW

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|

## Modules

| Name | Source | Version |
|------|--------|---------|

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

## Outputs

| Name | Description |
|------|-------------|

<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
