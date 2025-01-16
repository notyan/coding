#!/bin/bash
#Set SSH login into Pubkey Only, change port
cat > /etc/ssh/sshd_config.d/hardening.conf<< EOF
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM yes
MaxAuthTries 3
Port 2020
EOF

#Add new ssh port trough firewall
iptables -I INPUT -m tcp -p tcp --dport 2020 -j ACCEPT
systemctl restart sshd