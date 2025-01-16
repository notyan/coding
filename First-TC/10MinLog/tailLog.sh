#!/bin/bash

#Get Latest Logs by modified date
LOG=$(ls -t Http-*.log | head -n 1)
#TIME=$(date "+%d/%b/%Y:%H:%M:%S %z")
TIME=$(date -u -d '10 minutes ago' +'%d/%b/%Y:%H:%M:%S')

OPT=":a"


if [[ $1 == "" ]]; then
    awk -v d1="$TIME" '{if (substr($4,2,20) > d1) print $9}' $LOG | grep "200" | uniq -c
    exit;
fi

while getopts $OPT option; do
    case $option in 
        a)
            awk -v d1="$TIME"  '{if (substr($4,2,20) > d1) print $9}' $LOG | sort -n | uniq -c 
            ;;
        *) 
            echo "Thoose Option are not available"
            ;;
        
    esac
done
