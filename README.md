# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

## 1.	Create two different VPCs.
> Создать два разных VPC.
## 2.	Must be connection over ssh betwin this two VPCs.
> Сделать так, чтобы между ними был коннекшен (один инстанс из одного VPC, смог достучаться до второго инстанса, который в другом VPC) по SSH.

# AWS using **Peering connections**

## 1.	Create two different VPCs.
- Create **VPC1** and **VPC2**.
  
  ![](/img/Screenshot_1.jpg)

  ![](/img/Screenshot_2.jpg)
- Create **two subnets**. Each subnet is in their own VPC.
  
  ![](/img/Screenshot_3.jpg)
  
  ![](/img/Screenshot_4.jpg)

## 2.	Must be connection over ssh betwin this two VPCs.
- Create **peering connection** and accept request (marked).

  ![](/img/Screenshot_5.jpg)
- In each VPC in default **route table add route** to neighbour VPC over peering.

  ![](/img/Screenshot_6.jpg)
  
  ![](/img/Screenshot_7.jpg)

- Create **security groups**.

  ![](/img/Screenshot_8.jpg)
  
  ![](/img/Screenshot_9.jpg)

- Create **internet gateway** for one VPC to connect to one instance from internet.

  ![](/img/Screenshot_10.jpg)

  ![](/img/Screenshot_11.jpg)
- **Add route** to the route table for this VPC.

  ![](/img/Screenshot_14.jpg)

- Create **two instances** in different VPCs.

  ![](/img/Screenshot_12.jpg)

  ![](/img/Screenshot_13.jpg)

## Check connection
### `$ssh ubuntu@3.216.31.22`

### `ubuntu@ip-10-11-11-100:~$ vi .ssh/id_rsa`

### `ubuntu@ip-10-11-11-100:~$ chmod 600 .ssh/id_rsa`

### `ubuntu@ip-10-11-11-100:~$ ping -c 2 google.com`

PING google.com (172.253.62.101) 56(84) bytes of data.

64 bytes from bc-in-f101.1e100.net (172.253.62.101): icmp_seq=1 ttl=52 time=16.0 ms

64 bytes from bc-in-f101.1e100.net (172.253.62.101): icmp_seq=2 ttl=52 time=16.0 ms

--- google.com ping statistics ---

2 packets transmitted, 2 received, 0% packet loss, time 1002ms

rtt min/avg/max/mdev = 16.019/16.022/16.025/0.003 ms

### `ubuntu@ip-10-11-11-100:~$ ping -c 2 10.22.22.174`

PING 10.22.22.174 (10.22.22.174) 56(84) bytes of data.

64 bytes from 10.22.22.174: icmp_seq=1 ttl=64 time=1.05 ms

64 bytes from 10.22.22.174: icmp_seq=2 ttl=64 time=0.684 ms

--- 10.22.22.174 ping statistics ---

2 packets transmitted, 2 received, 0% packet loss, time 1001ms

rtt min/avg/max/mdev = 0.684/0.866/1.048/0.182 ms

### `ubuntu@ip-10-11-11-100:~$ ssh ubuntu@10.22.22.174`

The authenticity of host '10.22.22.174 (10.22.22.174)' can't be established.

ED25519 key fingerprint is SHA256:FnKBgv1cZlIYIC3ybHmbke9URiR+bA7tS++DzylBzlE.

This key is not known by any other names

Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

Warning: Permanently added '10.22.22.174' (ED25519) to the list of known hosts.

*Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.19.0-1025-aws x86_64)*

. . .

### `ubuntu@ip-10-22-22-174:~$ ping -c 2 google.com`

PING google.com (172.253.62.102) 56(84) bytes of data.

--- google.com ping statistics ---

2 packets transmitted, 0 received, 100% packet loss, time 1003ms

### `ubuntu@ip-10-22-22-174:~$ ping -c 2 10.11.11.100`

PING 10.11.11.100 (10.11.11.100) 56(84) bytes of data.

64 bytes from 10.11.11.100: icmp_seq=1 ttl=64 time=0.453 ms

64 bytes from 10.11.11.100: icmp_seq=2 ttl=64 time=0.939 ms

--- 10.11.11.100 ping statistics ---

2 packets transmitted, 2 received, 0% packet loss, time 1008ms

rtt min/avg/max/mdev = 0.453/0.696/0.939/0.243 ms
