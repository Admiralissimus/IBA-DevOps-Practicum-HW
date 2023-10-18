output "server1_ext_ip" {
  value = yandex_compute_instance.server1.*.network_interface.0.nat_ip_address
}

output "server2_ext_ip" {
  value = yandex_compute_instance.server2.*.network_interface.0.nat_ip_address
}

output "server2_id" {
  value = yandex_compute_instance.server2.id
}
