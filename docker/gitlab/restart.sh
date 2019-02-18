#!/bin/bash
. env.sh

docker stop $CONTAINER_NAME
copy gitlab.rb $GITLAB_BASE\config
docker start $CONTAINER_NAME
echo Run "docker logs --since 2m -f $CONTAINER_NAME" to tail container stdout (which is a combined tail of many internal logs files)
echo Run "docker ps -a" to see status of containers
echo Run "docker stop $CONTAINER_NAME" to stop the container