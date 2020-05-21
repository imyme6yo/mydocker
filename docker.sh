#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200414
# @UPDATED: 20200416
MODE="project"
DIR="code"
PROJECT="myapp"
SERVICE="$PROJECT"

# Set MODE
if [ -n "$1" ] ; then
  if ! [ "$1" = "project" -o "$1" = "start" ] ;
  then
    echo "Mode is `$1`\\n Mode should be either start or project."
    exit -1
  fi
  MODE=$1
fi

# Set PROJECT, which is project name
if [ -n "$2" ] ; then
  PROJECT=$2
fi

# Set container names and image tags.
CONTAINER="$SERVICE"
IMAGE="$PROJECT:dev"

TEST_DB_CONTAINER="$PROJECT-postgres-test"
DB_CONTAINER="$PROJECT-postgres"
DB_IMAGE="postgres:12.2-alpine"

# database environment variables
POSTGRES_USER=admin
POSTGRES_PASSWORD=password
POSTGRES_DB=$PROJECT

# Set network name
NETWORK="$PROJECT-network"
# stop docker containers
docker stop $CONTAINER $DB_CONTAINER
# remove docker containers
docker rm $CONTAINER $DB_CONTAINER
# remove docker images
docker rmi $IMAGE $DB_IMAGE

# create network
docker network create $NETWORK

if [ "$MODE" = "project" ]; then
  # run database container
  docker run -d \
    --net=$NETWORK -p 9120:5432 \
    -e POSTGRES_USER=$POSTGRES_USER \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -e POSTGRES_DB=$POSTGRES_DB \
    --name $DB_CONTAINER $DB_IMAGE
    
  # build image
  docker build --force-rm \
    --build-arg DIR=$DIR \
    --build-arg PROJECT=$PROJECT \
    --build-arg SERVICE=$SERVICE \
    --build-arg POSTGRES_USER=$POSTGRES_USER \
    --build-arg POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    --build-arg POSTGRES_DB=$POSTGRES_DB \
    -t $IMAGE -f ./Dockerfile.project .

  # run containers
  docker run --rm -it \
    -v $(pwd):/code \
    --net=$NETWORK -p 9119:8080 \
    --name $CONTAINER $IMAGE sh /${DIR}/project.sh

elif [ "$MODE" = "start" ]; then
  # run database container
  # docker run -d \ 
  #   --net=$NETWORK -p 9120:5432 \ 
  #   -e POSTGRES_USER=$POSTGRES_USER \ 
  #   -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \ 
  #   -e POSTGRES_DB=$POSTGRES_DB \ 
  #   --name $DB_CONTAINER $DB_IMAGE

  # build image
  docker build --force-rm \
    --build-arg DIR=$DIR \
    --build-arg PROJECT=$PROJECT \
    --build-arg SERVICE=$SERVICE \
    --build-arg POSTGRES_USER=$POSTGRES_USER \
    --build-arg POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    --build-arg POSTGRES_DB=$POSTGRES_DB \
    -t $IMAGE -f ./Dockerfile.startup .

  # run containers
  docker run --rm -it \
    -v $(pwd):/code \
    --net=$NETWORK -p 9119:8080 \
    --name $CONTAINER $IMAGE sh /${DIR}/startup.sh
fi