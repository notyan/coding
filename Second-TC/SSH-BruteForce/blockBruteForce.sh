#!/bin/bash

#Variables 
LOG_FILE="/var/log/auth.log"
BLOCKLIST="/var/log/ip_block.txt"
MAX_RETRY=5

# Check bloclist file 
[[ ! -f "$BLOCKLIST" ]] && touch "$BLOCKLIST"

#Block Ip on trying multiple time
block(){
    local ip="$1"
    if ! grep -q "$ip" "$BLOCKLIST"; then
        iptables -A INPUT -s "$ip" -j DROP
        echo "$ip" >> "$BLOCKLIST"
    fi
}

echo "Checking Auth.log for brute force attempt"
grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c | while read count ip; do
    if [[ "$count" -ge "$MAX_RETRY" ]]; then
        block "$ip"
        echo "IP $ip Is blocked"
    fi
done