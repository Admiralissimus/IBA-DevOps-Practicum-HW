#!/usr/bin/env python3
#3. Написать скрипт, который будет выводить текущую дату и время.

from datetime import datetime

now = datetime.now()

current_date = now.strftime("%d.%m.%Y") # format of date day.month.year
current_time = now.strftime("%H:%M:%S") # format of time hour:min:sec

print("Current date:", current_date)
print("Current time:", current_time)
