resource "yandex_vpc_network" "vpc2" {
  name = "ushakou-vpc"

  labels = {
    owner = var.owner
  }
}

resource "yandex_vpc_subnet" "subnet2" {
  name           = "ushakou-subnet2"
  v4_cidr_blocks = [var.cidr2]
  zone           = var.az2
  network_id     = yandex_vpc_network.vpc2.id

  labels = {
    owner = var.owner
  }
}

resource "yandex_compute_instance" "server2" {
  name        = "server2"
  platform_id = var.platform_id
  zone        = yandex_vpc_subnet.subnet2.zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
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
    subnet_id = yandex_vpc_subnet.subnet2.id
    nat       = true
  }

  labels = {
    owner = var.owner
  }
}
