terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.az
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

// Store Password in SSM Parameter Store
resource "yandex_lockbox_secret" "secret" {
  name = "lesson14_secret"
}

resource "yandex_lockbox_secret_version" "db_key_version" {
  secret_id = yandex_lockbox_secret.secret.id
  entries {
    key        = var.db_key
    text_value = random_password.rds_password.result
  }
}

// Get Password from Lockbox
data "yandex_lockbox_secret_version" "db_key_version" {
  secret_id  = yandex_lockbox_secret.secret.id
  version_id = yandex_lockbox_secret_version.db_key_version.id
}

output "my_secret_entries" {
  value = data.yandex_lockbox_secret_version.db_key_version.entries[0].text_value
}

