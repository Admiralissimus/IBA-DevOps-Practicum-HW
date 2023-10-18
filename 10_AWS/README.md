# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

## 1. Set up autoscaling for the t2.micro server, if the CPU load on the server is more than 80%, then another instance should be raised.1. Set up autoscaling for the t2.micro server, if the CPU load on the server is more than 80%, then another instance should be raised.
> Настроить автоскейлинг для сервера t2.micro, если на сервере нагрузка на CPU больше 80% то должен подниматься еще один инстанс.Настроить автоскейлинг для сервера t2.micro, если на сервере нагрузка на CPU больше 80% то должен подниматься еще один инстанс.

- Create Launch template.
  
  ![](./img/AWS_ASG_1.jpg)
- with simple user-data.
  
  ![](./img/AWS_ASG_2.jpg)
- Create auto scaling group

  ![](./img/AWS_ASG_3.jpg)

- Configure Automatic scaling (2 variants)
  - **Target tracking scaling**
    
    ![](./img/AWS_ASG_4.jpg)

  - **Simple scaling**
    
    ![](./img/AWS_ASG_6.jpg)

    Configure CloudWatch

    ![](./img/AWS_ASG_7.jpg)

  
  
## 2. Create Linux EC2 t2.micro and attach second volume.2 to it. Create Linux EC2 t2.micro and attach a second volume to it.
> Создать Linux EC2 t2.micro и прикрепить к нему второй volume.2. Создать Linux EC2 t2.micro и прикрепить к нему второй volume.Создать Linux EC2 t2.micro и прикрепить к нему второй volume.2. Создать Linux EC2 t2.micro и прикрепить к нему второй volume.

It's too simple. 

![](./img/AWS_add_volume_8.jpg)

