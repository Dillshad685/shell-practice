#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
echo "$0"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) #$0 refers to the file which is running currently in
#the server which is logs-software.sh removes .sh and adds .log
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "$LOG_FILE"
echo "script execution start time: $(date)" | tee -a $LOG_FILE

USERID=$(id -u)

#returns pwd user id if sudo it will be "0"

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run in sudo user $N" | tee -a $LOG_FILE
    exit 1
    #failure code is other than "0"
fi

VALIDATE(){ #function receives input as args
  if [ $1 -ne 0 ]; then
     echo -e " Installation failed .. $R FAILURE $N" | tee -a $LOG_FILE
     exit 1
  else
     echo -e "installation $2 .. $G SUCCESS $N" 
  fi
}

#$@

for package in $@
do
    #check if packages are already installed
    dnf list installed packages &>>$LOG_FILE
    
    #if exit code is 0 then return to else
    if [ $? -ne 0 ]; then
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"

    else
        echo "software is already present .. $Y SKIPPING $N"
    fi    
done

