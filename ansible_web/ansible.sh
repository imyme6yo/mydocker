# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200804
# @UPDATE: 20200810
#!/bin/bash

# Common environment variables
CONTEXT=$(pwd)
DEBUG=$true
PROJECT="myproject"
PROJECT_NETWORK="$PROJECT-network"
IMAGE_TAG="dev"

POSTGRES_USER="admin"
POSTGRES_PASSWORD="password"
POSTGRES_DB=${PROJECT}

# APP service environment variables
MYAPP_SERVICE="myapp"
MYAPP_PORT=9200
MYAPP_CONTAINER_PORT=3000

# Frontent environment varialbes
WEB_SERVICE="web"
WEB_PORT=9201
WEB_CONTAINER_PORT=8080
WEB_STORYBOOK_PORT=9114
WEB_STORYBOOK_CONTAINER_PORT=6006

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
  --build-arg MYAPP_PORT=$MYAPP_PORT \
  --build-arg MYAPP_CONTAINER_PORT=$MYAPP_CONTAINER_PORT \
  --build-arg POSTGRES_USER=$POSTGRES_USER \
  --build-arg POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  --build-arg POSTGRES_DB=$POSTGRES_DB \
  --build-arg WEB_SERVICE=$WEB_SERVICE \
  --build-arg WEB_PORT=$WEB_PORT \
  --build-arg WEB_CONTAINER_PORT=$WEB_CONTAINER_PORT \
  --build-arg WEB_STORYBOOK_PORT=$WEB_STORYBOOK_PORT \
  --build-arg WEB_STORYBOOK_CONTAINER_PORT=$WEB_STORYBOOK_CONTAINER_PORT \
  -t $IMAGE -f Dockerfile.ansible .

# run docker container
docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  -v $PWD:/$PROJECT \
  --name $CONTAINER $IMAGE ash
  # --name $CONTAINER $IMAGE sh /$DIR/dev.sh
  # --name $CONTAINER $IMAGE sh /$DIR/prod.sh