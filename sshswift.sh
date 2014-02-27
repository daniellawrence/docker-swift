#!/bin/sh
# do not add Docker server to known_hosts, or next time auth will fail
# use sed to extract port from " xxxxx->22 " 
#ssh -o "UserKnownHostsFile /dev/null" -p `sudo docker ps | grep docker-swift | sed 's/.* \([0-9]*\)->22.*/\1/'` swift@localhost
DOCKER_ID=$(sudo docker ps | awk '$0 ~ /docker-swift/ {print $1}')
SSH_PORT=$(sudo docker port $DOCKER_ID 22 | cut -d: -f2)
ssh -o "UserKnownHostsFile /dev/null" -p $SSH_PORT swift@localhost
