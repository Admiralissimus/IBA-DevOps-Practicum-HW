provider "aws" {
  region = var.region
}

// Generate Password
resource "random_string" "rds_password" {
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

// Store Password in SSM Parameter Store
resource "aws_ssm_parameter" "rds_password" {
  name        = var.dev_db_ssm
  description = "Master Password for RDS"
  type        = "SecureString"
  value       = random_string.rds_password.result
}

// Get Password from SSM Parameter Store
data "aws_ssm_parameter" "my_rds_password" {
  name = aws_ssm_parameter.rds_password.name
}



