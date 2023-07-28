
resource "aws_instance" "server1" {
  ami           = data.aws_ami.ubuntu2204.id
  instance_type = var.instance_type
  key_name      = "devops1"

  vpc_security_group_ids = [aws_security_group.sg_default_vpc.id]

  tags = {
    Name  = "Ushakou-server-1"
    Owner = var.owner
  }
}

resource "aws_security_group" "sg_default_vpc" {
  name_prefix = "Ushakou_sg"

  dynamic "ingress" {
    for_each = ["80", "22", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  #Allow PING
  ingress {
    from_port   = 8 # любой тип icmp
    to_port     = 0 # любой код icmp
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # разрешить пинги от любого источника
  }

  tags = {
    Owner = var.owner
  }
}




