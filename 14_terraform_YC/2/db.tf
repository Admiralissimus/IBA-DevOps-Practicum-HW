resource "yandex_vpc_network" "db_vpc" {
  name = "db_vpc"
}

resource "yandex_vpc_subnet" "db_subnet" {
  zone           = var.az
  network_id     = yandex_vpc_network.db_vpc.id
  v4_cidr_blocks = ["10.77.7.0/24"]
}

resource "yandex_vpc_security_group" "pgsql-sg" {
  name       = "pgsql-sg"
  network_id = yandex_vpc_network.db_vpc.id

  ingress {
    description    = "PostgreSQL"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_mdb_postgresql_cluster" "pg_db" {
  name                = "pg_db"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.db_vpc.id
  security_group_ids  = [yandex_vpc_security_group.pgsql-sg.id]
  deletion_protection = false

  config {
    version = 15
    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-ssd"
      disk_size          = "20"
    }
  }

  host {
    zone      = var.az
    name      = "db_pg-host"
    subnet_id = yandex_vpc_subnet.db_subnet.id
  }
}

resource "yandex_mdb_postgresql_database" "db1" {
  cluster_id = yandex_mdb_postgresql_cluster.pg_db.id
  name       = "db1"
  owner      = "user1"
  depends_on = [yandex_mdb_postgresql_user.user1]
}

resource "yandex_mdb_postgresql_user" "user1" {
  cluster_id = yandex_mdb_postgresql_cluster.pg_db.id
  name       = "user1"
  password   = data.yandex_lockbox_secret_version.db_key_version.entries[0].text_value
}
