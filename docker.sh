#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200317
# @UPDATE: 20200319

# remove docker image
docker ps -a | grep myapp | awk '{print $1}'| xargs docker stop
# stop & rm docker container
docker ps -a | grep myapp | awk '{print $1}'| xargs docker rm
docker images | grep myapp | awk '{print $3}'| xargs docker rmi
# build image
docker build -t myapp:dev .
# run container
docker run --rm -it -v $(pwd):/code -p 9213:3000  myapp:dev sh /code/project.sh
# docker run --rm -it -v $(pwd):/code -p 9213:3000  myapp:dev ./startup.sh ash