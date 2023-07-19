# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

## 1.	Create a VPC and a network in it as shown in the figure.
> Создать VPC и сеть в ней как показано на рисунке. 
 ![](/img/11_AWS_task.jpg)
## 2.	Create EC2 ubuntu t2.micro in Public subnet and Private subnet.
> Создать EC2 ubuntu t2.micro в Public subnet и Private subnet. 
## 3.	It should be possible to ssh into ec2 which is in the Private Subnet from the ec2 Public Subnet.
> Должна быть возможность по ssh зайти на ec2 которая находится в Private Subnet из ec2 Public Subnet.


- Create VPC.
  
  ![](/img/AWS_VPC_1.jpg)
- Create two subnets in the VPC.
  
  ![](/img/AWS_VPC_2.jpg)
  
  ![](/img/AWS_VPC_3.jpg)
- Create Internet GW and attach it to the VPC

  ![](/img/AWS_VPC_4.jpg)
- Create route table for Public subnet

  ![](/img/AWS_VPC_5.jpg)
- Add route to the Public subnet for Internet connection and public IPs

  ![](/img/AWS_VPC_6.jpg)
  ![](/img/AWS_VPC_7.jpg)
