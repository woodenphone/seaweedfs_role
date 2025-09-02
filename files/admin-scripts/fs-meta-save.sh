#!/bin/bash
## fs-meta-save.sh
## Backup weed filer metadata.
## By: Ctrl-S, 2021-06-17 - 2025-08-18.

weed shell <<< "fs.meta.save -o $(date -u +%Y-%m-%dT%H-%M-%S%z).seaweedfs.filermeta"

# echo $p "Finished" "(at date=$(date) epoch=$(date +%s))" | tee -a $logf
## == NOTES ==
## https://github.com/chrislusf/seaweedfs/wiki/Filer-Stores
##
## Send string to STDIN
## LINK: https://stackoverflow.com/questions/6541109/send-string-to-stdin
##quote> `cat <<< "This is coming from the stdin"`
