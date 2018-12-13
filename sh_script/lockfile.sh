#!/bin/sh

lockfile="/path/to/file.lock"

if [ -e $lockfile ]; then
    if [[ $(find "$lockfile" -mtime +2 -print) ]]; then
        # delete lock file since lock file exists more than 2 hours
        rm $lockfile
    else
        # exit now since lock file was already created less than 2 hours ago
        exit;
    fi
fi

# create lock file
touch $lockfile
