output "server1_external_ip" {
  value = aws_instance.server1.public_ip
}

output "server2_external_ip" {
  value = aws_instance.server2.public_ip
}

output "server2_id" {
  value = aws_instance.server2.id
}

output "my_sg_ids" {
  value = data.aws_security_groups.my-sg.ids
}

output "available_azs" {
  value = data.aws_availability_zones.vpc-azs.names
}
