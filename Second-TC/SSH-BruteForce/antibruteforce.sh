#!/bin/bash

#Variables 
LOG_FILE="/var/log/auth.log"
BLOCKLIST="/var/log/ip_block.txt"
MAX_RETRY=5

#Block Ip on trying multiple time
block(){
    local ip="$1"
    if ! grep -q "$ip" "$BLOCKLIST"; then
        iptables -A INPUT -s "$ip" -j DROP
        echo "$ip" >> "$BLOCKLIST"
    fi
}

#Manually unblock Ip if requested
unblock() {
    iptables -D INPUT -s "$ip" -j DROP
    sed -i "/$ip/d" "$BLOCKLIST"
    echo "$(date): Unblocking IP $ip"
}

echo "Checking Auth.log for brute force attempt"
grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c | while read count ip; do
    if [[ "$count" -ge "$MAX_RETRY" ]]; then
        block "$ip"
        echo "IP $ip Is blocked"
    fi
done