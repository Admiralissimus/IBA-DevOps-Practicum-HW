#!/bin/bash
set -e

NUM=10 # Number of folders
declare -a MAX_SIZE_ARRAY 
#######################################
# Search NUM maximum sized files or dirs
# Globals:
#   NUM
#   MAX_SIZE_ARRAY
# Arguments:
#   Path
# Return: 
#   MAX_SIZE_ARRAY[] : "$index\t$size\t$filetype\t$name\n"
#######################################
function searchMaxSizes() {
    echo "Start searching"
    MAX_SIZE_10=$(du -ha --max-depth=1 "$1" 2>/dev/null | sort -hr | head -n $NUM)
    # Split many strings to array, add number and type of file or dir at the end
    index=0
    while read size name; do
        test -d "$name" && filetype="dir" || filetype="file"
        MAX_SIZE_ARRAY["$index"]="$index\t$size\t$filetype\t$name\n"
        index=$((index+1))
    done <<< "$MAX_SIZE_10"
}

echo "Enter start dir, if empty - will be folder '/'"
read START_FOLDER
# if empty then assign "/" to the variable
START_FOLDER=${START_FOLDER:-"/"}

if [ ! -d "$START_FOLDER" ]; then
    echo "Folder doesn't exist!"
    exit 1
fi

searchMaxSizes "$START_FOLDER"

tput smcup

clear
echo -e "${MAX_SIZE_ARRAY[@]}"

# Получаем высоту терминала в строках
height=$(tput lines)
# Перемещаем курсор в нижнюю строку
tput cup $((height-1)) 0

read -n 1 input

tput rmcup