#!/bin/bash
# Найти топ 7 директорий на сервере, 
# которые больше всего занимают память и записать их в файл.

NUM=7 # Number of folders

du -h --max-depth=1 / 2>/dev/null | sort -hr | head -n $NUM