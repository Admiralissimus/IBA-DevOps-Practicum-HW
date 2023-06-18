#!/bin/bash
# This endless script prints head of top-command to log file
# every DELEAY seconds

DELAY=30
MAX_STRINGS=7000
LOG_FILE="/var/log/top_head.log"

# create temp file
tmpfile=$(mktemp)
# create autoremover of temp file
trap "rm -f $tmpfile" EXIT

while true 
do
    echo "-" >> "$LOG_FILE"
    echo `date` >> "$LOG_FILE"
    # -b: Starts top in Batch mode, which could be useful for sending 
    # output from top to other programs or to a file.
    # -n 1 : One iteration
    # head -n 5: Show first 5 strings
    top -b -n 1 | head -n 5 >> "$LOG_FILE"

    # Leave only MAX_STRINGS in log file
    tail -n "$MAX_STRINGS" "$LOG_FILE" > "$tmpfile"
    mv "$tmpfile" "$LOG_FILE"    

    sleep "$DELAY"
done