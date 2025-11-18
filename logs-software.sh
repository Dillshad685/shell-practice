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

dnf list installed mysql &>>$LOG_FILE #this cmd runs in background and appends in log file
#lists the files of mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "MYSQL"
else 
    echo -e "mysql already isntalled .. $Y SKIPPING $N" | tee -a $LOG_FILE  # appends in the log file
fi

dnf list installed nginx &>>$LOG_FILE
#lists the files of nginx
if [ $? -ne 0 ]; then
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "NGINX"
else 
    echo -e "nginx already isntalled .. $Y SKIPPING $N" | tee -a $LOG_FILE
fi




