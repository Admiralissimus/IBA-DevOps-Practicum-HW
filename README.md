# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

# Do with terraform.
## 1.	Using terraform, deploy two VPCs in two environments using workspaces.
> 1.	С помощью terraform развернуть два VPC в двух environment используя workspaces.
## 2.	Create an RDS and attach a password using random_password, the password must be stored in the parameter store.
> 2.	Создать RDS и прикрепить пароль с помощью random_password, пароль должен хранится в parameter store.


# 1.	Using terraform, deploy two VPCs in two environments using workspaces.

## The code is in folder **"1"**

> It is not good idea to use workspaces for making different environments. Usually people use it for making some tests. Imagine, that you want to test new OS in the prod environment. For this variant you use workspace **test**. If you want to test your environment uder pressure you use workspace **pressure**.

Each environment will be created with different AZ, instance types, tags and different prefixes in names.

***test.tfvar***

```
az = "ru-central1-b"

common_tags = {
  owner       = "ushakou"
  environment = "test"
}

vm_type = {
  cores         = 2
  memory        = 1
  core_fraction = 50
}

os_family_id = "ubuntu-2204-lts"

```

***pressure.tfvar***

```
az = "ru-central1-c"

common_tags = {
  owner       = "ushakou"
  environment = "pressure"
}

vm_type = {
  cores         = 2
  memory        = 1
  core_fraction = 5
}

```

`terraform init`

To create **prod** environment (our working environment):

`terraform apply`

To create **test** environment:

`terraform workspace new test`

`terraform apply -var-file test.tfvars`

To create **pressure** environment:

`terraform workspace new pressure`

`terraform apply -var-file pressure.tfvars`

Two additionals environments for tests will be created.

![](/1/img/Screenshot_1.jpg)

![](/1/img/Screenshot_2.jpg)

![](/1/img/Screenshot_3.jpg)

Don't forget to remove created environmnts for test.

`terraform workspace select pressure`

`terraform destroy`

`terraform workspace select test`

`terraform destroy`

`terraform workspace select default`

~~`terraform destroy`~~

## 2.	Create an RDS and attach a password using random_password, the password must be stored in the parameter store.

- Create random password.

```
resource "random_string" "rds_password" {
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

- Store Password in SSM Parameter Store using generated password by random_string

```
resource "aws_ssm_parameter" "rds_password" {
  name        = var.dev_db_ssm
  description = "Master Password for RDS"
  type        = "SecureString"
  value       = random_string.rds_password.result
}
```

- Get data from SSM

```
// Get Password from SSM Parameter Store
data "aws_ssm_parameter" "my_rds_password" {
  name = aws_ssm_parameter.rds_password.name
}
```

- Now we can use this credentials in different services, for example in DBs.

```
resource "aws_db_instance" "mysql" {
  identifier           = "dev-rds"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "main_db"
  username             = "administrator"
  password             = data.aws_ssm_parameter.my_rds_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
}

```
