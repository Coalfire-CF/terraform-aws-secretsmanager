variable "names" {
  type        = list(string)
  description = "Specifies the friendly name of the new secrets to be created"
}

variable "length" {
  type        = number
  description = "The length of the password to be generated"
  default = 15
}

variable "special" {
  type        = bool
  description = "Include special characters in random password string"
  default = true
}

variable "override_special" {
  type        = string
  description = "Provide your own list of special characters"
  default = "_%@!"
}

variable "kms_key_id" {
  type        = string
  description = "Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret."
}

variable "path" {
  type        = string
  description = "Path to organize secrets"
}

variable "min_lower" {
  type        = number
  description = "Minimum number of lower case characters"
  default = 1
}

variable "min_upper" {
  type        = number
  description = "Minimum number of upper case characters"
  default = 1
}

variable "min_numeric" {
  type        = number
  description = "Minimum number of numeric characters"
  default = 1
}

variable "min_special" {
  type        = number
  description = "Minimum number of special characters"
  default = 1
}

variable "partition" {
  type        = string
  description = "The AWS partition to use"
}

variable "cross_account_ids" {
  type        = list(string)
  description = "A list of strings containing the account IDs of AWS accounts that should have cross-account access to this secret"
  default = null
}

variable "empty_value" {
  type = bool
  description = "Whether the secret should be generated without a value"
  default = false
}
variable "shared_secrets" {
  type = list(string)
  description = "Secrets that should be shared across accounts."
  default = []
}

variable "PGSQL_RDS_Single_User_Secret_Rotation_Enabled" {
  description = "controls pgsql automatic secret rotation"
}

variable "PGSQL_RDS_Multi_User_Secret_Rotation_Enabled" {
  description = "controls pgsql automatic secret rotation"
}

variable "Other_Secret_Rotation_Enabled" {
  description = "controls other types of automatic secret rotation" #https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_available-rotation-templates.html#OTHER_rotation_templates
}
