#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200325
# stop docker container
docker ps -a | grep myapp | awk '{print $1}'| xargs docker stop
# remove docker container
docker ps -a | grep myapp | awk '{print $1}'| xargs docker rm
# remove docker image
docker images | grep myapp | awk '{print $3}'| xargs docker rmi
# build image
docker build -t myapp:dev .
# run container
docker run --rm -it -v $(pwd):/code -p 9128:3000 -p 9255:9009 myapp:dev sh /code/project.sh