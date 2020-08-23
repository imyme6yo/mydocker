#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200320
# @UPDATE: 20200405
MODE="dev"
PROJECT="myapp"

# Set MODE
if [ -n "$1" ] ; then
  if ! [ "$1" = "dev" -o "$1" = "start" ] 
  then
    echo "Mode is `$1`\\n Mode should be either start or project."
    exit -1
  fi
  MODE=$1
fi

# Set NAME
if [ -n "$2" ] ; then
    PROJECT=$2
fi

# Set container name and image tag.
CONTAINER="$PROJECT"
IMAGE="$PROJECT:dev"

# stop docker container
docker stop $CONTAINER
# remove docker container
docker rm $CONTAINER
# remove docker image
docker rmi $IMAGE
if [ "$MODE" = "dev" ]; then
  # build image
  docker build --force-rm \
    --build-arg PROJECT=$PROJECT \
    -t $IMAGE -f ./Dockerfile.dev .
  # run container
  docker run --rm -it \
    -v $(pwd):/$PROJECT \
    --name $CONTAINER $IMAGE sh /$PROJECT/dev.sh
elif [ "$MODE" = "start" ]; then
  # build image
  docker build --force-rm \
    --build-arg PROJECT=$PROJECT \
    -t $IMAGE -f ./Dockerfile.start .
  # run container
  docker run --rm -it \
    -v $(pwd):/$PROJECT \
    --name $CONTAINER $IMAGE sh /$PROJECT/startup.sh
fi