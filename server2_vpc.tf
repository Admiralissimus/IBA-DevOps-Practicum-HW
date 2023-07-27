# Create VPC
resource "aws_vpc" "ushakou-vpc" {
  cidr_block = "10.99.0.0/16"

  tags = {
    Name  = "Ushakou-vpc"
    Owner = var.owner
  }
}

# Create subnet in the VPC
resource "aws_subnet" "ushakou-subnet" {
  vpc_id            = aws_vpc.ushakou-vpc.id
  cidr_block        = "10.99.77.0/24"
  availability_zone = var.az

  tags = {
    Name  = "Ushakou-subnet"
    Owner = var.owner
  }
}

resource "aws_security_group" "sg_ushakou_vpc" {
  name_prefix = "Ushakou_sg"

  vpc_id = aws_vpc.ushakou-vpc.id

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

resource "aws_instance" "server2" {
  ami           = data.aws_ami.ubuntu2204.id
  instance_type = var.instance_type
  key_name      = "devops1"

  subnet_id              = aws_subnet.ushakou-subnet.id
  vpc_security_group_ids = [aws_security_group.sg_ushakou_vpc.id]

  tags = {
    Name  = "Ushakou-server-2"
    Owner = var.owner
  }
}



