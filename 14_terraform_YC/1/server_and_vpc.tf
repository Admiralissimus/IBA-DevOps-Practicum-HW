resource "yandex_vpc_network" "vpc" {
  name = "${var.common_tags["environment"]}-vpc"

  labels = merge(var.common_tags, {
    name = "${var.common_tags["environment"]}-vpc"
    }
  )
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.common_tags["environment"]}-subnet"
  v4_cidr_blocks = [var.cidr]
  zone           = var.az
  network_id     = yandex_vpc_network.vpc.id

  labels = merge(var.common_tags, {
    name = "${var.common_tags["environment"]}-subnet"
    }
  )
}

resource "yandex_compute_instance" "server" {
  name        = "${var.common_tags["environment"]}-server"
  platform_id = var.platform_id
  zone        = yandex_vpc_subnet.subnet.zone

  resources {
    cores         = var.vm_type.cores
    memory        = var.vm_type.memory
    core_fraction = var.vm_type.core_fraction
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      type     = "network-hdd"
      size     = data.yandex_compute_image.my_image.min_disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  labels = merge(var.common_tags, {
    name = "${var.common_tags["environment"]}-server"
    }
  )
}


