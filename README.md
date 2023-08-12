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

ubuntu1 ansible_host=158.160.99.140

centos1 ansible_host=158.160.114.218

debian1 ansible_host=62.84.124.40

`

**group_vars/all.yml**

```
ansible_user: admiral
ansible_ssh_private_key_file: ./key1.pem
```

## 1. Write an ansible playbook that will copy a file from a local server to a remote one and delete it.

**play1.yml**

