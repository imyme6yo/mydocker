#!/bin/bash
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210424
# @UPDATE: 20210425
git clone -b @fastapi-template https://github.com/imyme6yo/fastapi-postgres-template.git ${SERVICE}
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
PROJECT_NETWORK="${PROJECT}-network"

IMAGE_TAG="dev"

# Service environment variables
SERVICE="myapp"
SERVICE_PORT=20111
SERVICE_CONTAINER_PORT=3000

# Database
DATABASE_PATH="/var/opt/${PROJECT}/data/${SERVICE}"
DATABASE_HOST="$PROJECT-$SERVICE-db"
DATABASE_PORT="5432"
DATABASE_USER="admin"
DATABASE_PASSWORD="password"
DATABASE_DB=${SERVICE}

IMAGE="${PROJECT}-${SERVICE}:${IMAGE_TAG}"
SERVICE_CONTAINER="${PROJECT}-${SERVICE}"
DATABASE_CONTAINER="${PROJECT}-${SERVICE}-postgres"
DATABASE_CONTAINER1="${PROJECT}-${SERVICE}-pgadmin"

# Clean previous docker images and containers
# stop docker container
docker stop ${SERVICE_CONTAINER}
# remove docker container
docker rm ${SERVICE_CONTAINER}
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


# run docker container, service
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
  -v $(PWD):/opt/${PROJECT} \
  -v /var/log/${PROJECT}/${SERVICE}:/var/log \
  --network ${PROJECT_NETWORK} \
  --name ${SERVICE_CONTAINER} ${IMAGE} ash