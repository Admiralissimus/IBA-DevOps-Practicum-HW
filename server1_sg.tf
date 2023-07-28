data "yandex_vpc_subnet" "server1_az" {
  subnet_id = var.server1_subnet_id
}

resource "yandex_compute_instance" "server1" {
  name        = "server1"
  platform_id = var.platform_id
  zone        = data.yandex_vpc_subnet.server1_az.zone

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
    subnet_id          = var.server1_subnet_id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.sg_for_server1.id]
  }

  labels = {
    owner = var.owner
  }
}

# Create security group
resource "yandex_vpc_security_group" "sg_for_server1" {
  name        = "sg-server1"
  description = "Security group for server1"
  network_id  = data.yandex_vpc_subnet.server1_az.network_id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}
