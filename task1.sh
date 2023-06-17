#!/bin/bash
echo "Enter path to file"
read FILE

if [ ! -f "$FILE" ]; then
    echo "File not found"
    exit 1
fi

if grep -qw "error" "$FILE"; then
    echo "Found word 'error' in $FILE"
    echo "Removing this file"
    rm "$FILE"
else
    echo "There is no word 'error' in $FILE"
    echo "Let it live!"
fi

