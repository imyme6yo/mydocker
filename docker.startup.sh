#!/bin/sh
# @AUTHOR: jon "imyme6yo@gmail.com"
# @DRAFT: 20200317
# rmi
docker ps -a | grep clfun | awk '{print $1}'| xargs docker stop
# stop & rm
docker ps -a | grep clfun | awk '{print $1}'| xargs docker rm
docker images | grep clfun | awk '{print $3}'| xargs docker rmi
# build image
docker build -t broccoli:dev .
# run container
docker run --rm -v $(pwd):/code -p 9213:3000  broccoli:dev sh /code/startup.sh
# docker run --rm -it -v $(pwd):/code -p 9213:3000  broccoli:dev ash