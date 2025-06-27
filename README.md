![Coalfire](coalfire_logo.png)

# terraform-aws-secretsmanager

## Description

This repository contains a Terraform module to create and manage secrets in AWS Secrets Manager. It supports the creation of secrets with random or static values and secure access through IAM policies. The variable `names` is a list that will be used to create secrets for however many values are passed into the list.

## Dependencies

No dependencies.

## Resource List

- Secrets Manager Secret (e.g. username and/or password)
- Secret Policy
- Secret Version

## Usage

The below examples demonstrate how you can call the AWS Secrets Manager module to create secrets as needed. 


```hcl
data "aws_organizations_organization" "current" {
  provider = aws.mgmt
}

module "credentials" {
  source = "github.com/Coalfire-CF/terraform-aws-secretsmanager?ref=v2.0.5"
  providers = {
    aws = aws.mgmt
  }

  kms_key_id = data.terraform_remote_state.account-setup.outputs.sm_kms_key_arn 

  secrets = [
    {
      secret_name        = "svc_paktesting"
      secret_description = "Creating test credentials for Pak Parties."
    }
  ]

  path                    = "${var.path}credentials/"
  partition               = local.partition
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = local.global_tags

  # Random Password
  password_length = 20

  # Sharing
  shared = false #update to true and select utilize one of the options below
  #organization_ids  = [data.aws_organizations_organization.current.id] # Share with Organizations
  #cross_account_ids = [local.root_account_id]                          # Share across AWS Accounts, update local. to appropriate account ID
}
```

## Environment Setup

Establish a secure connection to the Management AWS account used for the build:

```hcl
IAM user authentication:

- Download and install the AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Log into the AWS Console and create AWS CLI Credentials (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- Configure the named profile used for the project, such as 'aws configure --profile example-mgmt'

SSO-based authentication (via IAM Identity Center SSO):

- Login to the AWS IAM Identity Center console, select the permission set for MGMT, and select the 'Access Keys' link.
- Choose the 'IAM Identity Center credentials' method to get the SSO Start URL and SSO Region values.
- Run the setup command 'aws configure sso --profile example-mgmt' and follow the prompts.
- Verify you can run AWS commands successfully, for example 'aws s3 ls --profile example-mgmt'.
- Run 'export AWS_PROFILE=example-mgmt' in your terminal to use the specific profile and avoid having to use '--profile' option.
```

## Deployment Steps

1. Navigate to the Terraform project and create a parent directory in the upper level code, for example:

    ```hcl
    ../aws/terraform/{REGION}/management-account/example
    ```

   If multi-account management plane:

    ```hcl
    ../aws/terraform/{REGION}/{ACCOUNT_TYPE}-mgmt-account/example
    ```

2. Create a new branch. The branch name should provide a high level overview of what you're working on.  

3. Create a properly defined main.tf file via the template found under 'Usage' while adjusting tfvars as needed. Note that many provided variables are outputs from other modules. Example parent directory:

   ```hcl
   ├── Example/
   │   ├── prefix.auto.tfvars   
   │   ├── locals.tf
   │   ├── main.tf
   │   ├── outputs.tf
   │   ├── providers.tf
   │   ├── README.md
   │   ├── remote-data.tf
   │   ├── required-providers.tf
   │   ├── variables.tf
   │   ├── ...
   ```

4. Change directories to the `secretsmanager` directory.

5. Ensure that the `prefix.auto.tfvars` variables are correct (especially the profile) or create a new tfvars file with the correct variables

6. Customize code to meet requirements

7. From the `secretsmanager` directory run, initialize the Terraform working directory:
   ```hcl
   terraform init
   ```

8. Standardized formatting in code:
   ```hcl
   terraform fmt
   ```

9. Optional: Ensure proper syntax and "spell check" your code:
   ```hcl
   terraform validate
   ```
   
10. Create an execution plan and verify everything looks correct:
      ```hcl
      terraform plan
      ```

11. Apply the configuration:
      ```hcl
      terraform apply
      ```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Contributing

[Start Here](CONTRIBUTING.md)

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)

## Contact Us

[Coalfire](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.