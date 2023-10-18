#!/bin/bash
#2. Написать скрипт, который будет создавать пользователя, имя пользователя 
#должно вводится с клавиатуры. Если пользователь существует, то вывести 
#сообщение об этом.

if [ $(id -u) != 0 ]; then
    echo "This script must be run as root" 
    exit 1
fi

echo "Enter username"
read USER

#Take first column with users and check if exists
if awk -F: '{print $1}' /etc/passwd | grep -qw "$USER"; then
    echo "User $USER is already exists"
    exit 1
else    
    useradd "$USER" && echo "User $USER created" || echo "Smth went wrong"
fi