#!/bin/bash

#Variables 
LOG_FILE="/var/log/auth.log"
BLOCKLIST="/var/log/ip_block.txt"
if [[ $1 == "" ]]; then
    echo "Please give ip you want to unblock './securhSSH.sh [ip]'"
    exit 1;
fi

if grep -q "$1" "$BLOCKLIST"; then
    iptables -D INPUT -s "$1" -j DROP
    sed -i "/$1/d" "$BLOCKLIST"
    echo "$(date): Unblocking IP $1"
else 
    echo "This IP $1 are not in blocklist"
fi


