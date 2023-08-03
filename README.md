# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.


# Do with terraform.
## 1.	Find any SSM parameter module on the internet and try to deploy it. You can find it on github.
> 1.	Найти любой модуль SSM parameter в интернете и попытаться развернуть его. Можно на гитхабе найти.
## 2.	Deploy VPC with all networks using the module. Use the module from the Internet, not your own.
> 2.    Развернуть VPC со всеми сетями используя модуль. Модуль использовать из интернета, не свой.

## 1.	Find any SSM parameter module on the internet and try to deploy it. You can find it on github.

- Create random password.
```
// Generate Password
resource "random_password" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$&"

  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1

  keepers = {
    kepeer = var.change_pass
  }
}
```
> Parameter **keepers** is for changing the password. Just change var.change_pass and new password will be generated.

- Store Password in SSM Parameter Store using **module**.
```
module "secret" {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "1.1.0"

  name        = "ushakou-secret-token"
  value       = random_password.rds_password.result
  secure_type = true

  tags = local.tags_ssm-parameter_module
}
```
> It is a good practiсe to use a specific version of a module in order to avoid problems in the future when changing the version of a module. ***version = "1.1.0"***

![](/img/Screenshot_10.jpg)


## 2.	Deploy VPC with all networks using the module. Use the module from the Internet, not your own.

We are going to build the next VPC schema:

![](/img/Screenshot_1.jpg)

- Get information abaou AZs in the region.
```
data "aws_availability_zones" "available" {}
```

- Define some locals.
 
```
locals {
  vpc_name      = "ushakou_vpc_module"
  number_of_azs = 2 // Number of used AZs
  vpc_cidr      = "10.0.0.0/16"
  // Get a list of the required AZs
  azs           = slice(data.aws_availability_zones.available.names, 0, local.number_of_azs)

  tags_vpc_module = {
    owner      = var.owner
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}
```

### Use module for creating the infrastructure.
- It is a good practiсe to use a specific version of a module in order to avoid problems in the future when changing the version of a module. ***version = "5.1.1"***
- Declare some basic parameters:
```
name = local.vpc_name 
cidr = local.vpc_cidr // CIDR of created VPC
azs  = local.azs // List of created subnets
```

![](/img/Screenshot_2.jpg)

- Create **own acl, route tables, security groups** instead of using default.
```
manage_default_network_acl    = false
manage_default_route_table    = false
manage_default_security_group = false
```

![](/img/Screenshot_4.jpg)

![](/img/Screenshot_5.jpg)

![](/img/Screenshot_6.jpg)

![](/img/Screenshot_7.jpg)

- Subnets:

![](/img/Screenshot_3.jpg)

- Create **public subnets with Internet GW** and declare instances launched into the subnet should be assigned a public IP address
```
public_subnets          = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
map_public_ip_on_launch = true
```  

![](/img/Screenshot_8.jpg)

- Create **private subnets with NAT GW** in each AZ.
```
  private_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]
  enable_nat_gateway = true
  single_nat_gateway = false
```

![](/img/Screenshot_9.jpg)

- Resulted code:

```
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = local.vpc_name 
  cidr = local.vpc_cidr // CIDR of created VPC
  azs  = local.azs // List of created subnets

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
```
