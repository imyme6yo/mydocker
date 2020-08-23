# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200824
#!/bin/bash

# Environment variables
CONTEXT=$(pwd)
DEBUG=$true
PROJECT="myproject"
PROJECT_NETWORK="$PROJECT-network"
IMAGE_TAG="dev"

# Ansible environment varialbes
# Set docker container name and image tag
IMAGE="$PROJECT-ansible:${IMAGE_TAG}"
CONTAINER="$PROJECT-ansible"

# Clean previous docker images and containers
# stop docker container
docker stop $CONTAINER
# remove docker container
docker rm $CONTAINER
# remove docker image
docker rmi $IMAGE

# create docker network
docker build --force-rm \
  --build-arg CONTEXT=$CONTEXT \
  --build-arg DEBUG=$DEBUG \
  --build-arg PROJECT=$PROJECT \
  --build-arg PROJECT_NETWORK=$PROJECT_NETWORK \
  --build-arg IMAGE_TAG=$IMAGE_TAG \
  -t $IMAGE -f Dockerfile.ansible .

# run docker container
docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  -v $PWD:/$PROJECT \
  --name $CONTAINER $IMAGE ash