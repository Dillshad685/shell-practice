#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "script execution start time : $(date)" | tee -a $LOG_FILE

SOURCE_DIR=/home/ec2-user/app-logs

if [ ! -d $SOURCE_DIR ]; then
    echo -e "ERROR :: $SOURCE_DIR directory not exit"
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath
do 
    echo "Deleting file: $filepath"

done <<< $FILES_TO_DELETE


#create folder and directory
#check where source directory is present
#check if source directory is present or not
#while loop to check files using IFS 

