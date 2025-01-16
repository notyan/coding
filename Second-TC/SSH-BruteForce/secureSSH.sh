#!/bin/bash


OPT=":buh"

if [[ $1 == "" ]]; then
    echo "Use theese tree option to secure your ssh"
    echo "-b    block all bruteforce attempt"
    echo "-u    unblock ip"
    echo "-h    hardening the ssh"
fi

while getopts $OPT option; do
    case $option in 
        b)
            bash ./blockBruteForce.sh
            ;;
        u) 
            bash ./unblockIp.sh $2
            ;;
        h) 
            bash ./hardening.sh
            ;;
        
    esac
done
