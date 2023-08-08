locals {
  vpc_name = "ushakou-network"
  labels_vpc_module = {
    owner       = var.owner
    github_repo = "terraform-yandex-vpc"
    github_org  = "terraform-yacloud-modules"
  }


}

module "vpc" {
  source = "git::https://github.com/Admiralissimus/terraform-yandex-vpc?ref=v0.8.1"

  folder_id  = var.folder_id
  blank_name = local.vpc_name
  labels     = local.labels_vpc_module

  azs = var.azs

  create_vpc          = true
  create_subnets      = true
  create_route_tables = true
  create_nat          = true

  public_subnets  = var.subnets["public"]
  private_subnets = var.subnets["private"]
}

/*
data "aws_availability_zones" "available" {}

locals {
  vpc_name      = "ushakou_vpc_module"
  number_of_azs = 2 // Number of subnets
  vpc_cidr      = "10.0.0.0/16"
  // Get a list of the required AZs
  azs = slice(data.aws_availability_zones.available.names, 0, local.number_of_azs)

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
  cidr = local.vpc_cidr // CIDR of created VPC
  azs  = local.azs      // List of created subnets

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
*/
