#!/bin/bash

TARGET_DIR=$1

# Loop through each of the list of tar archives provided to the script
# Make folders for each one
#for TAR_ARCHIVE in "$@"; do
#    FOLDER_NAME=$(basename "../log_files/${TAR_ARCHIVE}" _secure.tgz)
#    mkdir "$SCRATCH/$FOLDER_NAME"
#    tar -xzf "../log_files/${TAR_ARCHIVE}" -C "./$SCRATCH/$FOLDER_NAME"
#done

for file in "$TARGET_DIR"/var/log/*; do
    # Check if the current item is a regular file
    if [ -f "$file" ]; then
 
        # for non-existent/invalid users
        # https://regex101.com/r/aF053i/2
        { 
        sed -nE 's/([a-zA-Z]+)[ ]+([0-9]+) ([0-9][0-9]):[0-9][0-9]:[0-9][0-9] [a-zA-Z]+ sshd\[[0-9]+\]: Failed password for invalid user ([a-zA-Z0-9\_\-]+) from ([0-9.]+) [a-zA-Z0-9 ]+/\1 \2 \3 \4 \5/p' < "$file"; 
        } >> "${TARGET_DIR}/failed_login_data.txt"
        
        # for usernames on our system
        # https://regex101.com/r/yOWE6M/2
        { 
        sed -nE 's/([a-zA-Z]+)[ ]+([0-9]+) ([0-9][0-9]):[0-9][0-9]:[0-9][0-9] [a-zA-Z]+ sshd\[[0-9]+\]: Failed password for ((invalid user ([a-zA-Z0-9\_\-]+))^|([a-zA-Z0-9\_\-]+)) from ([0-9.]+) [a-zA-Z0-9 ]+/\1 \2 \3 \7 \8/p' < "$file"; 
        } >> "${TARGET_DIR}/failed_login_data.txt"
        fi
    done