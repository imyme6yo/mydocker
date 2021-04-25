#!/bin/bash
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210425
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

# Database
DATABASE_ENGINE=13.2-alpine
DATABASE_PATH="/usr/local/opt/${PROJECT}/data/${SERVICE}"
DATABASE_HOST="$PROJECT-$SERVICE-db"
DATABASE_PORT="5432"
DATABASE_CONTAINER_PORT="5432"
DATABASE_USER="admin"
DATABASE_PASSWORD="password"
DATABASE_DB=${SERVICE}

DATABASE_GUI=5.1
DATABASE_GUI_HOST="$PROJECT-pgadmin"
DATABASE_GUI_PORT="12111"
DATABASE_GUI_CONTAINER_PORT="80"
DATABASE_GUI_EMAIL="pgadmin4@pgadmin.org"
DATABASE_GUI_PASSWORD="admin"

# Clean previous docker images and containers
# stop docker container
docker stop ${DATABASE_HOST}
docker stop ${DATABASE_GUI_HOST}
# remove docker container
docker rm ${DATABASE_HOST}
docker rm ${DATABASE_GUI_HOST}


# run docker database container, postgres
docker run --restart=unless-stopped -d \
  -e POSTGRES_DB=${DATABASE_DB} \
  -e POSTGRES_USER=${DATABASE_USER} \
  -e POSTGRES_PASSWORD=${DATABASE_PASSWORD} \
  -v ${DATABASE_PATH}:/var/lib/postgresql/data \
  --network ${PROJECT_NETWORK} \
  --name ${DATABASE_HOST} postgres:${DATABASE_ENGINE}


# run docker pgadmin container, project-pg-admin
docker run -d \
  -e PGADMIN_DEFAULT_EMAIL=${DATABASE_GUI_EMAIL} \
  -e PGADMIN_DEFAULT_PASSWORD=${DATABASE_GUI_PASSWORD} \
  -p ${DATABASE_GUI_PORT}:${DATABASE_GUI_CONTAINER_PORT} \
  --network ${PROJECT_NETWORK} \
  --name ${DATABASE_GUI_HOST} dpage/pgadmin4:${DATABASE_GUI}