data "terraform_remote_state" "fedramp_mgmt_account_setup" {
  backend   = "s3"
  workspace = "default"

  config = {
    bucket  = "${var.profile}-${var.aws_region}-tf-state"
    region  = var.aws_region
    key     = "${var.profile}/${var.aws_region}/account-setup.tfstate"
    profile = var.profile
  }
}