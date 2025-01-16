#!/bin/bash

#Problem will occur if the month is different
#awk -v d1="$(date -u -d '1 hours ago' +'%d/%b/%Y:%H:%M:%S')"  '{if (substr($4,2,20) > d1) print $9}' Http-04.log | sort -n | uniq -c 
awk -v d1="$(date -u -d '1 hours ago' +'%d/%b/%Y:%H:%M:%S')"  '{if (substr($4,2,20) > d1) print $4}' Http-04.log 
