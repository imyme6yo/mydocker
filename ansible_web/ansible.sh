# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200804
#!/bin/bash

# Common environment variables
CONTEXT=$(pwd)
DEBUG=$true
DIR="myproject"
PROJECT="myproject"
PROJECT_NETWORK="$PROJECT-network"
IMAGE_TAG="dev"

# Page service environment variables
MYAPP_SERVICE="myapp"
MYAPP_DIR="myapp"
MYAPP_PORT=3000
POSTGRES_USER="admin"
POSTGRES_PASSWORD="password"
POSTGRES_DB=${PROJECT}

# Frontent environment varialbes
WEB_SERVICE="web"
WEB_DIR="web"
WEB_PORT=8080

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
  --build-arg MYAPP_SERVICE=$MYAPP_SERVICE \
  --build-arg MYAPP_DIR=$MYAPP_DIR \
  --build-arg MYAPP_PORT=$MYAPP_PORT \
  --build-arg POSTGRES_USER=$POSTGRES_USER \
  --build-arg POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  --build-arg POSTGRES_DB=$POSTGRES_DB \
  --build-arg WEB_SERVICE=$WEB_SERVICE \
  --build-arg WEB_DIR=$WEB_DIR \
  --build-arg WEB_PORT=$WEB_PORT \
  -t $IMAGE -f Dockerfile.ansible .

# run docker container
docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  -v $PWD:/$PROJECT \
  --name $CONTAINER $IMAGE ash
  # --name $CONTAINER $IMAGE sh /$DIR/dev.sh
  # --name $CONTAINER $IMAGE sh /$DIR/prod.sh