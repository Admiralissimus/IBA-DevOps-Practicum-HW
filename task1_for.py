#!/usr/bin/env python3
#1. Написать скрипт, пользователь вводит строку из букв в нижнем регистре 
#и верхнем регистре. Нужно посчитать, сколько в этой строке больших букв.
str = input("Enter a string: ")
count = 0
for i in str:
    if i.isupper():
        count += 1
print (f"Number of uppercase letters is {count}.")
