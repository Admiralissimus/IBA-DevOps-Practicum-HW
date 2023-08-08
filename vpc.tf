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

