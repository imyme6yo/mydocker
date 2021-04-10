#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210410
DOCKER_REPO_PORT="$1"

if [[ -z $DOCKER_REPO_PORT ]] ; then
    DOCKER_REPO_PORT=7788
fi

docker run -dit --name docker-registry -p ${DOCKER_REPO_PORT}:5000 registry
