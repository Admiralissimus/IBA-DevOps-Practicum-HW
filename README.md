# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

# Do with Ansible

## 1. Write an ansible playbook that will copy a file from a local server to a remote one and delete it.
>	Написать ansible playbook, который скопирует файл с локального сервера на удаленный и удалит его.
## 2. Write an ansible playbook that will create a user with a home directory.
> Написать ansible playboоk, который создаст пользователя с домашней директорией.
## 3. Write an ansible playbook that will install docker and add the user from the second task to the docker group.
3.	Написать ansible playbook, который установит докер и добавит в группу докер пользователя из второго задания.

## During making this task I learnt:
- blocks:
- when: 
- loop:
- set_fact:
- yum and apt repos
- ansible variables
- tags:
- become_user:
- shell:
- creating user

## 0. Building file structure
First I will create 2 slave hosts with different OS types: **Debian** and **CentOS**.

Structure of files:

![](/img/Screenshot_1.jpg)

**ansible.cfg**:

```
[defaults]
host_key_checking = false
inventory         = ./hosts.txt
```

**hosts.txt**:

```
[docker]
ubuntu1 ansible_host=158.160.99.140
centos1 ansible_host=158.160.114.218
debian1 ansible_host=62.84.124.40
```

**group_vars/all.yml**

```
ansible_user: admiral
ansible_ssh_private_key_file: ./key1.pem
```

## 1. Write an ansible playbook that will copy a file from a local server to a remote one and delete it.
**Also added** checking creation and output the result.
**play1.yml**
```
---
- name: Copy file and remove it
  hosts: docker

  vars: 
    src: "hosts.txt"
    dest: "/home/{{ ansible_user }}/{{ src }}"

  tasks:
  
  - name: Copy file to destination host
    ansible.builtin.copy:
      src: "{{ src }}"
      dest: "{{ dest }}"

  - name: Read destination file
    ansible.builtin.shell: 
      cmd: "cat {{ dest }}"
      executable: /bin/bash
    register: output
  
  - name: Destination file contains
    debug:
      var: output.stdout_lines

  - name: Remove file
    ansible.builtin.file:
      path: "{{ dest }}"
      state: absent
```

**Result**

![](/img/Screenshot_3.jpg)

## 2. Write an ansible playbook that will create a user with a home directory.

- Create var-file **group_vars/all.yml**
```
docker_user: vasya
```

- **play_2.yml**

```
---
- name: Creating user with home dir
  hosts: docker

  tasks:

  - name: Create user 
    ansible.builtin.user:
      name: "{{ docker_user }}"
      state: present
      create_home: true
    become: true

  - name: Check creation
    ansible.builtin.shell: 
      cmd: "cat /etc/passwd | grep {{ docker_user }}; echo ------;ls /home"
      executable: /bin/bash
    register: output
  
  - name: Result is...
    debug:
      var: output.stdout_lines
```
- **Result**

![](/img/Screenshot_2.jpg)

## 3. Write an ansible playbook that will install docker and add the user from the second task to the docker group.



