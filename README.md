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

**play_3.yml**
```
---
- name: Install docker and add user to docker group
  hosts: docker
  become: true

  tasks:

  - name: set mydistribution
    ansible.builtin.set_fact:
      mydistribution: "{{ 'rhel' if (ansible_distribution == 'Red Hat Enterprise Linux') else (ansible_distribution | lower) }}"

  - block: #Install docker on debian-based system
  
    - name: Install dependencies
      apt:
        name: "{{ item }}"
        state: present
        update_cache: yes
        cache_valid_time: 3600
      loop:
        - ca-certificates 
        - curl
        - gnupg
    
    - name: add GPG key
      apt_key:
        url: https://download.docker.com/linux/{{ mydistribution }}/gpg
        state: present
   
    - name: add docker repository to apt
      apt_repository:
        repo: deb https://download.docker.com/linux/{{ mydistribution }} {{ ansible_distribution_release }} stable
        state: present

    - name: Install docker
      apt:
        state: present
        update_cache: yes
        name:
          - docker-ce
          - docker-ce-cli
          - containerd.io
          - docker-buildx-plugin
          - docker-compose-plugin

    - name: Install dependecies in Ubuntu to become another user
      apt:
        name: "acl"
        state: present

    when: ansible_os_family == "Debian"

  - block: # RedHat-based systems

    - name: Install dependencies
      ansible.builtin.yum:
        name: yum-utils
        state: present      

    - name: Add Docker repo
      get_url:
        url: https://download.docker.com/linux/{{ mydistribution }}/docker-ce.repo
        dest: /etc/yum.repos.d/docer-ce.repo
      become: yes

    - name: Install docker with yum
      ansible.builtin.yum:
        state: present    
        update_cache: true
        name:
          - docker-ce
          - docker-ce-cli
          - containerd.io
          - docker-buildx-plugin
          - docker-compose-plugin
      when: mydistribution != "fedora"

    - name: Install docker with dnf
      ansible.builtin.dnf:
        state: present    
        update_cache: true
        name:
          - docker-ce
          - docker-ce-cli
          - containerd.io
          - docker-buildx-plugin
          - docker-compose-plugin
      when: mydistribution == "fedora"

    when: ansible_os_family == "RedHat"  

  - name: Ensure group "docker" exists
    ansible.builtin.group:
      name: docker
      state: present

  - name: Create user 
    ansible.builtin.user:
      name: "{{ docker_user }}"
      groups: docker
      append: yes
      state: present
      create_home: true

  - name: Check docker is active
    service:
      name: docker
      state: started
      enabled: yes

  - block: #test

    - name: Test working Docker under user
      shell:
        cmd: "docker run --rm hello-world"
        executable: /bin/bash
      register: output
      become_user: "{{ docker_user }}"

    
    - debug:
        var: output.stdout_lines
    
    tags:
      - test
```


