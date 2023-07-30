# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

# Do with terraform.
## 1.	Using terraform, deploy two VPCs in two environments using workspaces.
> 1.	С помощью terraform развернуть два VPC в двух environment используя workspaces.
## 2.	Create an RDS and attach a password using random_password, the password must be stored in the parameter store.
> 2.	Создать RDS и прикрепить пароль с помощью random_password, пароль должен хранится в parameter store.


# 1.	Using terraform, deploy two VPCs in two environments using workspaces.

## The code is in folder **"1"**

> It is not good idea to use workspaces for making different environments. Usually people use it for making some tests. Imagine, that you want to test new code of your app in the prod environment. For this variant you use workspace **test**. If you want to test your environment uder pressure you use workspace **pressure**.

## Each environment will be created with **different AZ, instance types, tags and different prefixes in names**.

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

![](/1/img/Screenshot_4.jpg)

![](/1/img/Screenshot_3.jpg)

![](/1/img/Screenshot_2.jpg)

Don't forget to remove created environmnts for test.

`terraform workspace select pressure`

`terraform destroy`

`terraform workspace select test`

`terraform destroy`

`terraform workspace select default`

~~`terraform destroy`~~



