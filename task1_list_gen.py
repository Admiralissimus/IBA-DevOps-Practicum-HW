#!/usr/bin/env python3
#1. Написать скрипт, пользователь вводит строку из букв в нижнем регистре 
#и верхнем регистре. Нужно посчитать, сколько в этой строке больших букв.
str = input("Enter a string: ")
#Generate string with only uppercase letters by using list generator
str_upper = ''.join([s for s in str if s.isupper()])
print (f"Number of uppercase letters is {len(str_upper)}.")
