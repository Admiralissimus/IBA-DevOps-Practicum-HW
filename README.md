# IBA-DevOps-Practicum-HW
Each lesson's homework will be created in particular branch.

# Do with Ansible

## 1. Use one ansible playbook.
## - Create ec2 t2.micro using ansible playbook.
> Создать ес2 t2.micro с помощью ansible playbook.
## - Run a docker container there.
> Запустить там докер контейнер.
## - Remove the ec2
> Удалить этот инстанс.

- At the beginning we don't know ip of future ec2 instance, thats why we **don't use hosts file**.
Structure of playbook will be:
```
- hosts: localhost
  tasks:
    ... Creation ec2 instance with docker instance
- hosts: ec2_group
  tasks:
    ... starting nginx container
- hosts: localhost
  tasks:
    ... Checking and terminating ec2
```
- First part (creation ec2) **hosts:** will be **localhost**.
Name of instance we will declare in file **group_vars/all.yml**.
During creation ec2 we will use **user_data** to install docker engine and add ubuntu user to group docker:
```
user_data: |
  #!/bin/bash
  apt-get update -y
  apt-get install -y docker.io
  usermod -aG docker ubuntu
```
```
- name:  Create EC2
  amazon.aws.ec2_instance:
    name: "{{ ec2_name }}"
    key_name: "{{ ec2_key_pub }}"
    instance_type: "{{ instance_type }}"
    security_group: default
    network:
      assign_public_ip: true
    image_id: "{{ ec2_image }}"
    tags:
      Owner: Ushakou
    state: started
    wait: true
    wait_timeout: 120
    user_data: "{{ user_data }}"
  register: ec2
```
Here we use state **started** with timeout for waiting installation of docker engine.
Then we Add EC2 instance to docker_hosts group:
- 
