locals {

  labels_lockbox_module = {
    owner       = var.owner
    github_repo = "terraform-yandex-lockbox"
    github_org  = "terraform-yacloud-modules"
  }
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


module "kms_key" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-lockbox.git?ref=v0.2.0"

  name      = "ushakou_secret"
  folder_id = var.folder_id


  labels = local.labels_lockbox_module

  entries = {
    "ushakou-secret-1" : random_password.rds_password.result
  }

  deletion_protection = false
}
