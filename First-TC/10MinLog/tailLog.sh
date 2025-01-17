#!/bin/bash

#Get Latest Logs by modified date
LOG=$(ls -t Http-*.log | head -n 1)
#LOG=$(find ./ -maxdepth 1 -type f -mtime 0 -name "*HTTP-*.log" )

#Getting current time, 
TIME=$(date -u -d '10 minutes ago' +'%d/%b/%Y:%H:%M:%S')

OPT=":aief"

if [[ $1 == "" ]]; then
    echo "Log File Check"
    echo "-e        Count and show 500 Http Response Code"
    echo "-a        Count and show all Http Response Code"
    echo "-i        Get top 5 ip that sent the request"
    echo "-f        Analyze All log File"
fi

while getopts $OPT option; do
    case $option in 
        e)
            awk -v d1="$TIME" '{if (substr($4,2,20) > d1) print $9}' $LOG | grep "500" | uniq -c
            ;;
        a)
            awk -v d1="$TIME"  '{if (substr($4,2,20) > d1) print $9}' $LOG | sort -n | uniq -c 
            ;;
        i) 
            awk -v d1="$TIME" '{if (substr($4,2,20) > d1) print $1}' $LOG | uniq -c  | sort -n -r | head -n 5
            ;;
        f) 
            find ./ -maxdepth 1 -type f -mmin +0 -name "Http-*.log" -exec sh -c 'echo -n "{}  " ; awk -v d1="$TIME" '\''{if (substr($4,2,20) > d1) print $9}'\'' {} | grep "500" | sort -n | uniq -c' ';'
            ;;
        *) 
            echo "Thoose Option are not available"
            ;;
    esac
done
