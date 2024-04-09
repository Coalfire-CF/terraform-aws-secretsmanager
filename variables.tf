variable "secrets" {
  type        = list(map(string))
  description = "Specifies the friendly name of the new secrets to be created as key and an optional value field for descriptions"
}

variable "length" {
  type        = number
  description = "The length of the password to be generated"
  default     = 15
}

variable "special" {
  type        = bool
  description = "Include special characters in random password string"
  default     = true
}

variable "override_special" {
  type        = string
  description = "Provide your own list of special characters"
  default     = "_%@!" #this is the default as it the necessary special characters to prevent issues for PGSQL or other DB services we deploy
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
  default     = 1
}

variable "min_upper" {
  type        = number
  description = "Minimum number of upper case characters"
  default     = 1
}

variable "min_numeric" {
  type        = number
  description = "Minimum number of numeric characters"
  default     = 1
}

variable "min_special" {
  type        = number
  description = "Minimum number of special characters"
  default     = 1
}

variable "partition" {
  type        = string
  description = "The AWS partition to use"
}

variable "cross_account_ids" {
  type        = list(string)
  description = "A list of strings containing the account IDs of AWS accounts that should have cross-account access to this secret"
  default     = null
}

variable "empty_value" {
  type        = bool
  description = "Whether the secret should be generated without a value"
  default     = false
}
variable "shared" {
  type        = bool
  description = "Whether secrets should be shared across accounts."
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "regional_tags" {
  description = "a map of strings that contains regional level tags"
  type        = map(string)
  default     = {}
}

variable "global_tags" {
  description = "a map of strings that contains global level tags"
  type        = map(string)
  default     = {}
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret."
  type        = number
  default     = 30
}