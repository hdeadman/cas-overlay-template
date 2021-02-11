#!/bin/bash
. env.sh
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
mkdir $GITLAB_BASE
mkdir $GITLAB_BASE
mkdir $GITLAB_BASE/config
mkdir $GITLAB_BASE/config/ssl
mkdir $GITLAB_BASE/logs
mkdir $GITLAB_BASE/data
cp gitlab.rb $GITLAB_BASE/config
cp $DOMAIN.key $GITLAB_BASE/config/ssl/gitlab.key
cp $DOMAIN.crt $GITLAB_BASE/config/ssl/gitlab.crt
docker run --detach --name $CONTAINER_NAME -p 8444:443 \
  --volume $GITLAB_BASE/config:/etc/gitlab \
  --volume $GITLAB_BASE/logs:/var/log/gitlab \
  --volume $GITLAB_BASE/data:/var/opt/gitlab \
  $IMAGE_NAME
echo "Run the following to tail the logs: "
echo docker logs $CONTAINER_NAME -f
