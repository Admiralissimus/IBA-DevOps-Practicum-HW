# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.


# Do with terraform.
## 1.	Find any SSM parameter module on the internet and try to deploy it. You can find it on github.
> 1.	Найти любой модуль SSM parameter в интернете и попытаться развернуть его. Можно на гитхабе найти.
## 2.	Deploy VPC with all networks using the module. Use the module from the Internet, not your own.
> 2.    Развернуть VPC со всеми сетями используя модуль. Модуль использовать из интернета, не свой.

## 1.	Find any SSM parameter module on the internet and try to deploy it. You can find it on github.


## 2.	Deploy VPC with all networks using the module. Use the module from the Internet, not your own.

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


