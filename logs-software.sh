#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

USERID=$(id -u)

#returns pwd user id if sudo it will be "0"

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run in sudo user $N" 
    exit 1
    #failure code is other than "0"
fi

VALIDATE(){ #function receives input as args
  if [ $1 -ne 0 ]; then
     echo -e " Installation failed .. $R FAILURE $N"
     exit 1
  else
     echo -e "installation $2 .. $G SUCCESS $N"
  fi
}

dnf list installed mysql
#lists the files of mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y 
    VALIDATE $? "MYSQL"
else 
    echo "mysql already isntalled .. $Y SKIPPING $N"
fi

dnf list installed nginx
#lists the files of nginx
if [ $? -ne 0 ]; then
    dnf install nginx -y 
    VALIDATE $? "NGINX"
else 
    echo -e "nginx already isntalled .. $Y SKIPPING $N"
fi




