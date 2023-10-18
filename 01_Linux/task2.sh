#!/bin/bash
# Создать пользователя и добавить его в группу sudo.

if [ $(id -u) != 0 ]; then
    echo "This script must be run as root" 
    exit 1
fi

echo "Enter username"
read USER
useradd $USER -G "sudo"