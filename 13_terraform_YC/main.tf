terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.az_default
}

data "yandex_compute_image" "my_image" {
  family = var.os_family_id
}
