output "server_external_ip" {
  value = aws_instance.server.public_ip
}
