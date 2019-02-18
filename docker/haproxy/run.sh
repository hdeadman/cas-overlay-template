#!/bin/bash

docker stop haproxy
docker rm haproxy
docker build --tag="cas/haproxy" .
docker run --detach -p 443:443 -p 1936:1936 --name haproxy cas/haproxy