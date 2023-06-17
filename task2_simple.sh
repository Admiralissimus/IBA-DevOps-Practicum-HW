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
# Program 'useradd' already write this message if user exists
useradd "$USER" && echo "User $USER created"