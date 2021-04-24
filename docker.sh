#!/bin/bash
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210424
git clone https://github.com/imyme6yo/fastapi-template.git -b @fastapi-template ${SERVICE}
rm -rf ./${SERVICE}/.git

MODE='DEV'
DEBUG='true'

OSNAME=$(uname)
echo $OSNAME

if [ "$OSNAME" = "Darwin" ];then
  IP_MAIN=$(ipconfig getifaddr en0)
else
  IP_MAIN=$(hostname -I | awk '{print $1}') # CentOS

fi
IP_DEV='localhost'

echo $IP_MAIN
echo $MODE
echo $DEBUG

PROJECT="myproj"
IMAGE_TAG="dev"

# Book service environment variables
SERVICE="myapp"
SERVICE_PORT=10111
SERVICE_CONTAINER_PORT=3000
DATABASE_HOST="$PROJECT-$SERVICE-db"
DATABASE_PORT="5432"
DATABASE_USER="admin"
DATABASE_PASSWORD="password"
DATABASE_DB=${SERVICE}

IMAGE="${PROJECT}-${SERVICE}:${IMAGE_TAG}"
CONTAINER="${PROJECT}-${SERVICE}"
# Clean previous docker images and containers
# stop docker container
docker stop ${CONTAINER}
# remove docker container
docker rm ${CONTAINER}
# remove docker image
docker rmi ${IMAGE}

# create docker network
docker build --force-rm \
  --build-arg MODE=${MODE} \
  --build-arg DEBUG="${DEBUG}" \
  --build-arg IP_MAIN=${IP_MAIN} \
  --build-arg IP_DEV=${IP_DEV} \
  --build-arg PROJECT=${PROJECT} \
  --build-arg SERVICE=${SERVICE} \
  --build-arg SERVICE_PORT=${SERVICE_PORT} \
  --build-arg SERVICE_CONTAINER_PORT=${SERVICE_CONTAINER_PORT} \
  --build-arg DATABASE_HOST=${DATABASE_HOST} \
  --build-arg DATABASE_PORT=${DATABASE_PORT} \
  --build-arg DATABASE_USER=${DATABASE_USER} \
  --build-arg DATABASE_PASSWORD=${DATABASE_PASSWORD} \
  --build-arg DATABASE_DB=${DATABASE_DB} \
  -t ${IMAGE} -f Dockerfile.start .

# run docker container
docker run --rm -it \
  -e MODE=${MODE} \
  -e DEBUG=${DEBUG} \
  -e IP_MAIN=${IP_MAIN} \
  -e IP_DEV=${IP_DEV} \
  -e PROJECT=${PROJECT} \
  -e SERVICE=${SERVICE} \
  -e SERVICE_PORT=${SERVICE_PORT} \
  -e SERVICE_CONTAINER_PORT=${SERVICE_CONTAINER_PORT} \
  -e DATABASE_HOST=${DATABASE_HOST} \
  -e DATABASE_PORT=${DATABASE_PORT} \
  -e DATABASE_USER=${DATABASE_USER} \
  -e DATABASE_PASSWORD=${DATABASE_PASSWORD} \
  -e DATABASE_DB=${DATABASE_DB} \
  -p ${SERVICE_PORT}:${SERVICE_CONTAINER_PORT} \
  -v $(PWD)/${SERVICE}:/opt/${PROJECT}/${SERVICE} \
  -v /var/log/${PROJECT}/${SERVICE}:/var/log \
  --name ${CONTAINER} ${IMAGE} ash