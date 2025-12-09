#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[34m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=$(3:-14) #IF $3 value is not there will consider as 14

LOGS_FOLDER=/var/log/shell-script
SCRIPT_NAME=$( echo $0 | cut -d "." f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

echo "script execution start time : $(date)"



if [ ! -d $1 ]; then
    echo "directory does not exist"
    exit 1
fi

USAGE(){
    echo -e "$R USAGE :: sudo sh backuplog.sh <SOURCE_DIR> <DEST_DIR> <DAYS> [optional, default 14 days] $N"
    exit 1
}



#Check if arugments are correctly passed

if [ $# -le 2]; then
    USAGE
fi

#check if source directory present or not

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R $SOURCE_DIR $N does not exit"
    exit 1
fi

#check if DEST directory present or not

if [ ! -d $DEST_DIR ]; then
    echo -e "$R $DEST_DIR $N does not exit"
    exit 1
fi

#FIND THE FILES

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ ! -z $"{FILES}" ]; then # -z checks if string is empty
    echo "files found: $FILES"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo "Zip file is " $ZIP_FILE_NAME"
    find $SOURCE_DIR  -name "*.log" -type -f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"
    echo "$ZIP_FILE_NAME"

#Check if zipped or not

    if [ -f $ZIP_FILE_NAME ]; then
        echo "files are zipped"

        while IFS = read -r filepath
        do
            echo "Deleting files : $filepath"
            rm -rf $filepath
            echo "Deleted files: $filepath"
        done <<< $FILES
    else
        echo "archival failure"
        exit 1
    fi
else
    echo "No files to archive $Y SKIPPING $N"
fi



