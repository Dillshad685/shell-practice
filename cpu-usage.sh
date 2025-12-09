#!/bin/bash

DISK_USAGE=$(df hT | grep -v filesystem)

while IFS= read -r line
do
    echo "Line: $line"
done <<<$DISK_USAGE

