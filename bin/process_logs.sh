#!/bin/bash
# lamberty@UMMOSX-2KJR96KM bin % ./process_logs.sh ganesha_secure.tgz discovery_secure.tgz mylar_secure.tgz zeus_secure.tgz velcro_secure.tgz cscirepo_secure.tgz
# make a temp directory
SCRATCH=$(mktemp --directory SCRATCH-XXXXXX)

# Loop through each of the list of tar archives provided to the script
# Make folders for each one
for TAR_ARCHIVE in "$@"; do
    FOLDER_NAME=$(basename "../log_files/${TAR_ARCHIVE}" _secure.tgz)
    mkdir "$SCRATCH/$FOLDER_NAME"
    tar -xzf "../log_files/${TAR_ARCHIVE}" -C "./$SCRATCH/$FOLDER_NAME"
done


# seems to be running from where the tests want it to run, but need to figure out how to run this manually...
#for TAR_ARCHIVE in "$@"; do
#    FOLDER_NAME=$(basename "../log_files/${TAR_ARCHIVE}" _secure.tgz)
#    mkdir "$SCRATCH/$FOLDER_NAME"
#    tar -xzf "${TAR_ARCHIVE}" -C "./$SCRATCH/$FOLDER_NAME"
#done