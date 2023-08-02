provider "aws" {
  region = var.region
}

// Generate Password
resource "random_password" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$&"

  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1

  keepers = {
    kepeer = var.change_pass
  }
}


module "secret" {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "1.1.0"

  name        = "ushakou-secret-token"
  value       = random_password.rds_password.result
  secure_type = true
}


