# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

# Do with Ansible

## 1. Write an ansible playbook that will copy a file from a local server to a remote one and delete it.
>	Написать ansible playbook, который скопирует файл с локального сервера на удаленный и удалит его.
## 2. Write an ansible playbook that will create a user with a home directory.
> Написать ansible playboоk, который создаст пользователя с домашней директорией.
## 3. Write an ansible playbook that will install docker and add the user from the second task to the docker group.
3.	Написать ansible playbook, который установит докер и добавит в группу докер пользователя из второго задания.

## 0. Building file structure
First I will create 2 slave hosts with different OS types: **Debian** and **CentOS**.

Structure of files:
![](/img/Screenshot_1.jpg)
**ansible.cfg**:
`
[defaults]
host_key_checking = false
inventory         = ./hosts.txt
`

**hosts.txt**:
`
[docker]
ansible1 ansible_host=51.250.66.59
ansible2 ansible_host=84.252.128.198
`

**group_vars/all.yml**
`
ansible_user: admiral
ansible_ssh_private_key_file: ./key1.pem
`

## 1. Write an ansible playbook that will copy a file from a local server to a remote one and delete it.

**play1.yml**

