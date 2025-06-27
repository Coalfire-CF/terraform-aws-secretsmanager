variable "secrets" {
  type        = list(map(string))
  description = "Specifies the friendly name of the new secrets to be created as key and an optional value field for descriptions"
}

variable "kms_key_id" {
  type        = string
  description = "Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret."
}

variable "path" {
  type        = string
  description = "Path to organize secrets"
}

variable "partition" {
  type        = string
  description = "The AWS partition to use"
}

variable "empty_value" {
  type        = bool
  description = "Whether the secret should be generated without a value"
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

# Sharing
variable "shared" {
  type        = bool
  description = "Whether secrets should be shared across accounts."
  default     = false
}

variable "cross_account_ids" {
  type        = list(string)
  description = "A list of strings containing the account IDs of AWS accounts that should have cross-account access to this secret"
  default     = []
}

variable "organization_ids" {
  type        = list(string)
  description = "The AWS Organization ID to share secrets with. If specified, cross_account_ids will be ignored"
  default     = []
}

variable "replicas" {
  type = list(object({
    region      = string
    kms_key_arn = optional(string)
  }))
  description = "List of regions to replicate the secret to. Each replica can optionally specify a KMS key"
  default     = []
}

# Random Password
variable "exclude_characters" {
  description = "String of the characters that you don't want in the password"
  type        = string
  default     = "\" # $ % & ' ( ) * + , . / : ; < = > ? @ [ \\ ] ^ ` { | } ~"
  # Permitted characters are: ! _ -
  # The defaults are intended to be generally safe for use in various RDS database types, Linux, and Windows.
}

variable "exclude_lowercase" {
  description = "Specifies whether to exclude lowercase letters from the password"
  type        = bool
  default     = false
}

variable "exclude_numbers" {
  description = "Specifies whether to exclude numbers from the password"
  type        = bool
  default     = false
}

variable "exclude_punctuation" {
  description = "Specifies whether to exclude punctuation characters from the password: ! \" # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \\ ] ^ _ ` { | } ~"
  type        = bool
  default     = false
}

variable "exclude_uppercase" {
  description = "Specifies whether to exclude uppercase letters from the password"
  type        = bool
  default     = false
}

variable "include_space" {
  description = "Specifies whether to include the space character"
  type        = bool
  default     = false
}

variable "password_length" {
  description = "Length of the password"
  type        = number
  default     = 15
}

variable "require_each_included_type" {
  description = "Specifies whether to include at least one upper and lowercase letter, one number, and one punctuation"
  type        = bool
  default     = true
}
