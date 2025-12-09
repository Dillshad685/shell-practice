#!/bin/bash

DISK_USAGE=$(df -hT | grep -v filesystem)
DISK_THRESHOLD=2
IP_address=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MESSAGE=""


while IFS= read -r line
do
    USAGE=$(echo $line | awk '{print$6}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print$7}')
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
        #MESSAGE+="High disk utilization on $PARTITON : $USAGE % </br>"
        echo "high usage on $PARTITION : $USAGE"
    fi
done <<<$DISK_USAGE

#echo -e "Message body: $MESSAGE"

#sh mail.sh "dillu945@gmail.com" "High disk usage alert" "High disk usage" "$MESSAGE" "$IP_address" "Devops team"

# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5



