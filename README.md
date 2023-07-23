# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

## 1.	Create two different VPCs.
> Создать два разных VPC.
## 2.	Must be connection over ssh betwin this two VPCs.
> Сделать так, чтобы между ними был коннекшен (один инстанс из одного VPC, смог достучаться до второго инстанса, который в другом VPC) по SSH.

# YC using **NAT-instance**

## 0. Create folders for dev and prod environment. And net-folder for **peering-instance**.

![](/img/Screenshot_1.jpg)

## 1.	Create two different VPCs.

- Create VPC **dev** with subnet **dev-subnet** in folder **dev**.

![](/img/Screenshot_2.jpg)

- Create VPC **prod** with subnet **prod-subnet** in folder **prod**.

![](/img/Screenshot_3.jpg)

- Create instance **router** with two network interfaces in each subnet with fixed internal IPs. No need external ip.
> By default you can't create more than one network interface. But if you choose image "NAT-instance" - you can do it.

![](/img/Screenshot_4.jpg)

- Create **route tables** for each subnet.

![](/img/Screenshot_5.jpg)

![](/img/Screenshot_6.jpg)


## 2.	Must be connection over ssh betwin this two VPCs.

- Run instances in each subnet.

![](/img/Screenshot_7.jpg)

![](/img/Screenshot_8.jpg)

- Connect to any instance via ssh.

- From this instance connect to router

`admiral@dev-vm:~$ vim .ssh/id_rsa`
> Add here secret key

`admiral@dev-vm:~$ chmod 600 .ssh/id_rsa`

`admiral@dev-vm:~$ ssh admiral@10.1.1.3`

- Activate the second network interface.

`admiral@router:~$ sudo vim /etc/netplan/02-netcfg.yaml` 

    network:
      version: 2
      renderer: networkd
      ethernets:
        eth1:
          dhcp4: yes
`admiral@router:~$ sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/51-cloud-init.yaml`

`admiral@router:~$ sudo vim /etc/netplan/51-cloud-init.yaml`
> Modify file for eth1

    network:
        ethernets:
            eth1:
                dhcp4: true
                dhcp6: false
                match:
                    macaddress: d0:1d:b2:0c:08:c3
                set-name: eth1
        version: 2

`admiral@router:~$ sudo netplan apply`

- Apply **masquarade** for eth0 and eth1.

`admiral@router:~$ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`

`admiral@router:~$ sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE`

`admiral@router:~$ sudo netfilter-persistent save`

- Check file **/etc/sysctl.conf**.

    net.ipv4.ip_forward=1


