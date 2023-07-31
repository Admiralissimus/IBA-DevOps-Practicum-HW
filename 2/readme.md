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

- Get data from SSM.

```
// Get Password from SSM Parameter Store
data "aws_ssm_parameter" "my_rds_password" {
  name = aws_ssm_parameter.rds_password.name
}
```

- Now we can use this credentials in different services, for example in DBs. **data.aws_ssm_parameter.my_rds_password.value**

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
