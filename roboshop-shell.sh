#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f" #we get from existing instance
SG_ID="sg-00d0eb3bdf7ae9959"  #same as above

for instance in $@ #$@ refers to the variables we pass dynamically
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=$instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)  #to create EC2 instance using shell

    #to get private IP
    if [ instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
       
    else 
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
    fi
    ehco "$instance: $IP"
done