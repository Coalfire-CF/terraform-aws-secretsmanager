locals {
  secret_input = [for k, v in var.secret_naming_descrip : v if length(k) > 0]
}