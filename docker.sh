#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200522

MODE="jenkins-only"
PROJECT="myjenkins"
JENKINS_HOME="/var/jenkins_home"
SERVICE="myjenkins"
GIT_REPO=""

mkdir ${JENKINS_HOME}
sudo chown 1000 ${JENKINS_HOME}

# Set MODE
if [ -n "$1" ] ; then
    if ! [ "$1" = "jenkins-only" -o "$1" = "jenkins-gerrit" ]; then
        echo "Mode is `$1`\\n Mode should be either start or project."
        exit -1
    fi
    MODE=$1
fi

# Set PROJECT
if [ -n "$2" ] ; then
    PROJECT=$2
fi

# Set docker image tag and container name.
IMAGE="$SERVICE:dev"
CONTAINER="$SERVICE"

# Set docker network name
NETWORK="$PROJECT-network"

# stop docker container
docker stop $CONTAINER
# remove docker container
docker rm $CONTAINER
# remove docker image
docker rmi $IMAGE

# create network
docker network create $NETWORK
if [ "$MODE" = "jenkins-only" ]; then
    # build docker image
    docker build --force-rm \
        --build-arg JENKINS_HOME=$DIR \
        --build-arg PROJECT=$PROJECT \
        --build-arg SERVICE=$SERVICE \
        -t $IMAGE -f ./Dockerfile .
        
    # run docker container
    docker run -d \
        -v $JENKINS_HOME:$JENKINS_HOME \
        --net=$NETWORK -p 9213:8080 \
        --name $CONTAINER $IMAGE
        #--name $CONTAINER $IMAGE sh /${JENKINS_HOME}/startup.sh

elif [ "$MODE" = "jenkins-gerrit" ]; then
    # build docker image
    docker build --force-rm \
        --build-arg JENKINS_HOME=$JENKINS_HOME \
        --build-arg PROJECT=$PROJECT \
        --build-arg SERVICE=$SERVICE \
        -t $IMAGE -f ./Dockerfile.gerrit .
        
    # run docker container
    docker run --rm -it \
        -v $(pwd):/$DIR \
        --net=$NETWORK -p 9213:8080 \
        --name $CONTAINER $IMAGE sh /${DIR}/gerrit.sh
fi