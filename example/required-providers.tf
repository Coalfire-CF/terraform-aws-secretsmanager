terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.15.0, < 6.19"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }
  }
}