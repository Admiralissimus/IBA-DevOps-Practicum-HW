# Create VPC
resource "aws_vpc" "ushakou-vpc" {
  cidr_block = "10.99.0.0/16"

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["Environment"]}-vpc"
    }
  )
}

# Create subnet in the VPC
resource "aws_subnet" "ushakou-subnet" {
  vpc_id            = aws_vpc.ushakou-vpc.id
  cidr_block        = "10.99.77.0/24"
  availability_zone = data.aws_availability_zones.vpc-azs.names[var.az]

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["Environment"]}-subnet"
    }
  )
}

resource "aws_security_group" "sg_ushakou_vpc" {
  name_prefix = "${var.common_tags["Environment"]}-sg"

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
    from_port   = 8 # type of icmp
    to_port     = 0 # code of icmp
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["Environment"]}-sg"
    }
  )
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu2204.id
  instance_type = var.instance_type
  key_name      = "devops1"

  subnet_id              = aws_subnet.ushakou-subnet.id
  vpc_security_group_ids = [aws_security_group.sg_ushakou_vpc.id]

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["Environment"]}-server"
    }
  )
}



