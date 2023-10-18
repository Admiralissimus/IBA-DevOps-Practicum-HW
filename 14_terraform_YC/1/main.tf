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

data "yandex_compute_image" "my_image" {
  family = var.os_family_id
}
