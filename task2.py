#!/usr/bin/env python3
#2. Написать скрипт, который будет делать ping google.com. 
#Если сервер отвечает, то выводить - success, если нет - doesn't work.

import platform # To check the OS
import subprocess # To run command

def ping(host):
    # Number of packets in windows is -n parameter
    # Number of packets in linux or mac is -c parameter
    param = "-n" if platform.system().lower() == "windows" else "-c"
    command = ["ping", param, "1", host]
   
    # Return True, if server answered, else - return False
    return subprocess.call(command, stdout=subprocess.DEVNULL, \
                           stderr=subprocess.DEVNULL) == 0

print("Success.") if ping("google.com") else print("Doesn't work.")

