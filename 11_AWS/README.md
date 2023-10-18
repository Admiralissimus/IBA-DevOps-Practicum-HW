# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

## 1.	Create a VPC and a network in it as shown in the figure.
> Создать VPC и сеть в ней как показано на рисунке. 

![](/img/11_AWS_task.jpg)
## 2.	Create EC2 ubuntu t2.micro in Public subnet and Private subnet.
> Создать EC2 ubuntu t2.micro в Public subnet и Private subnet. 
## 3.	It should be possible to ssh into ec2 which is in the Private Subnet from the ec2 Public Subnet.
> Должна быть возможность по ssh зайти на ec2 которая находится в Private Subnet из ec2 Public Subnet.

# AWS

## 1. Create a VPC and a network in it as shown in the figure.
- Create **VPC**.
  
  ![](/img/AWS_VPC_1.jpg)
- Create **two subnets** in the VPC.
  
  ![](/img/AWS_VPC_2.jpg)
  
  ![](/img/AWS_VPC_3.jpg)
- Create **Internet GW** and **attach it to the VPC**.

  ![](/img/AWS_VPC_4.jpg)
- Create **route table** for Public subnet and Privet subnet.

  ![](/img/AWS_VPC_5.jpg)
- **Add route** to the **Public subnet** for Internet connection and public IPs.

  ![](/img/AWS_VPC_6.jpg)

  ![](/img/AWS_VPC_7.jpg)

- **Associate route table** with the Public subnet.

  ![](/img/AWS_VPC_9.jpg)
- **Enable auto-assign public IPv4** address for the Public subnet.

  ![](/img/AWS_VPC_8.jpg)
- By default, new subnets use default raute table and for the Private subnet it's OK. But I want tu **use my route table  for the Private subnet.**
  
  ![](/img/AWS_VPC_10.jpg)

  ![](/img/AWS_VPC_11.jpg)
  
## 2.	Create EC2 ubuntu t2.micro in Public subnet and Private subnet.
- Create **Security group** for the VPC

  ![](/img/AWS_VPC_15.jpg)
- **Launch two instances** in different subnets.

  ![](/img/AWS_VPC_12.jpg)

  ![](/img/AWS_VPC_13.jpg)
  **Result**

  ![](/img/AWS_VPC_14.jpg)

## 3.	It should be possible to ssh into ec2 which is in the Private Subnet from the ec2 Public Subnet.
### `$ssh ubuntu@10.0.1.233`

### `ubuntu@ip-10-0-1-233:~$ echo "$DEVOPS1-KEY" > ~/.ssh/id_rsa`

### `ubuntu@ip-10-0-1-233:~$ chmod 600 ~/.ssh/id_rsa`

### `ubuntu@ip-10-0-1-233:~$ ping 10.0.2.145`

PING 10.0.2.145 (10.0.2.145) 56(84) bytes of data.

64 bytes from 10.0.2.145: icmp_seq=1 ttl=64 time=0.392 ms

64 bytes from 10.0.2.145: icmp_seq=2 ttl=64 time=0.433 ms

64 bytes from 10.0.2.145: icmp_seq=3 ttl=64 time=0.578 ms

64 bytes from 10.0.2.145: icmp_seq=4 ttl=64 time=0.502 ms

64 bytes from 10.0.2.145: icmp_seq=5 ttl=64 time=0.441 ms

64 bytes from 10.0.2.145: icmp_seq=6 ttl=64 time=0.421 ms

64 bytes from 10.0.2.145: icmp_seq=7 ttl=64 time=0.514 ms

^C

--- 10.0.2.145 ping statistics ---

7 packets transmitted, 7 received, 0% packet loss, time 6136ms

rtt min/avg/max/mdev = 0.392/0.468/0.578/0.060 ms

### `ubuntu@ip-10-0-1-233:~$ ssh ubuntu@10.0.2.145`

The authenticity of host '10.0.2.145 (10.0.2.145)' can't be established.

ED25519 key fingerprint is SHA256:TzFQK0OW8hWPkkrCSBp/fmhgSPrpboyscBjouw0BJOE.

This key is not known by any other names

Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

### `ubuntu@ip-10-0-1-233:~$ ssh ubuntu@10.0.2.145`

Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.19.0-1025-aws x86_64)


 * Documentation:  https://help.ubuntu.com
 
 * Management:     https://landscape.canonical.com

. . . 

### `ubuntu@ip-10-0-2-145:~$ ping google.com`

PING google.com (142.251.163.101) 56(84) bytes of data.

^C

--- google.com ping statistics ---

4 packets transmitted, 0 received, 100% packet loss, time 3060ms

### `ubuntu@ip-10-0-2-145:~$ ping 10.0.1.233`

PING 10.0.1.233 (10.0.1.233) 56(84) bytes of data.

64 bytes from 10.0.1.233: icmp_seq=1 ttl=64 time=0.326 ms

64 bytes from 10.0.1.233: icmp_seq=2 ttl=64 time=0.434 ms

64 bytes from 10.0.1.233: icmp_seq=3 ttl=64 time=0.953 ms

64 bytes from 10.0.1.233: icmp_seq=4 ttl=64 time=0.496 ms

^C

--- 10.0.1.233 ping statistics ---

4 packets transmitted, 4 received, 0% packet loss, time 3028ms

rtt min/avg/max/mdev = 0.326/0.552/0.953/0.239 ms

### `ubuntu@ip-10-0-2-145:~$ exit`

logout

Connection to 10.0.2.145 closed.

### `ubuntu@ip-10-0-1-233:~$ ping google.ru`

PING google.ru (142.251.167.94) 56(84) bytes of data.

64 bytes from ww-in-f94.1e100.net (142.251.167.94): icmp_seq=1 ttl=96 time=7.00 ms

64 bytes from ww-in-f94.1e100.net (142.251.167.94): icmp_seq=2 ttl=96 time=7.03 ms

64 bytes from ww-in-f94.1e100.net (142.251.167.94): icmp_seq=3 ttl=96 time=7.07 ms

^C

--- google.ru ping statistics ---

3 packets transmitted, 3 received, 0% packet loss, time 2004ms

rtt min/avg/max/mdev = 6.996/7.031/7.065/0.028 ms

