provider "aws" {
  region = var.region
}

# Find the most recent ami of Ubuntu 22.04
data "aws_ami" "ubuntu2204" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Find SG with tag owner 
data "aws_security_groups" "my-sg" {
  tags = {
    Owner = var.owner
  }
}