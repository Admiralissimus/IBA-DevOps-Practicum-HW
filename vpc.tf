data "aws_availability_zones" "available" {}

locals {
  vpc_name      = "ushakou_vpc_module"
  number_of_azs = 2
  vpc_cidr      = "10.0.0.0/16"
  azs           = slice(data.aws_availability_zones.available.names, 0, local.number_of_azs)

  tags_vpc_module = {
    owner      = var.owner
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = local.vpc_name
  cidr = local.vpc_cidr
  azs  = local.azs

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  public_subnets          = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  map_public_ip_on_launch = true

  private_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]
  enable_nat_gateway = true
  single_nat_gateway = false

  tags = local.tags_vpc_module
}
