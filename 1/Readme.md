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
