#! /bin/bash

CONTAINER=`sudo docker ps | grep nginx |  awk -F'  +' '{print $7}'`
FILE=/home/ec2-user/resource.log
> $FILE

while true; do
    echo "===============================" >> $FILE

    DATE=`date "+%Y%m%d-%H%M%S"`
    DOCKER_STATUS=`sudo docker ps | sed '1d' | awk -F'  +' '{print $5}'`
    HTTP_STATUS=`curl -IsL http://localhost | grep "HTTP/1.1"`
    echo -e "$DATE\n$DOCKER_STATUS\t$HTTP_STATUS" >> $FILE

    RESOUECE_USAGE=`sudo docker stats $CONTAINER --no-stream`
    echo -e "$RESOUECE_USAGE" >> $FILE
    sleep 10

done