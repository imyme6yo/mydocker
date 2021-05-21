# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200416
# @UPDATE: 20210519
# Arguments
ARG PYTHON=3.8.2
ARG ALPINE=3.10
ARG TAG=${PYTHON}-alpine${ALPINE}

# Base image
FROM python:${TAG}

# Labels
# Maintainer
LABEL maintainer="imyme6yo"
LABEL email="imyme6yo@gmail.com"
# Service
LABEL project=myproj
LABEL name=myproj-myapp
LABEL version=0.1.1

# Service
LABEL Name=myapp
LABEL Version=0.0.1

# Arguments
ARG MODE=DEV
ARG DEBUG="true"
ARG IP_MAIN=127.0.0.1
ARG IP_DEV=127.0.0.1
ARG PROJECT=myproj
ARG SERVICE=myapp
ARG PORT=8080
ARG DATABASE_HOST=${PROJECT}-${SERVICE}-db
ARG DATABASE_PORT=5432
ARG DATABASE_USER=admin
ARG DATABASE_PASSWORD=password
ARG DATABASE_DB=${PROJECT}
ARG REQUIREMENT=requirements.txt

# Envs
ENV MODE=${MODE}
ENV DEBUG=${DEBUG}
ENV IP_MAIN=${IP_MAIN}
ENV IP_DEV=${IP_DEV}
ENV PROJECT=${PROJECT}
ENV SERVICE=${SERVICE}
ENV PORT=${PORT}
ENV CONTAINER=${PROJECT}-${SERVICE}
ENV DATABASE_HOST=${DATABASE_HOST}
ENV DATABASE_PORT=${DATABASE_PORT}
ENV DATABASE_USER=${DATABASE_USER}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ENV DATABASE_DB=${DATABASE_DB}
ENV REQUIREMENT=${REQUIREMENT}

EXPOSE ${PORT}

# Install Alpine packages
RUN apk update && apk upgrade
RUN apk update && apk upgrade
RUN apk add --no-cache  --virtual .build-deps gcc python-dev musl-dev
RUN apk add postgresql-dev

# Install django dependencies
RUN pip install --upgrade pip
COPY ${REQUIREMENT} .
RUN pip install -r ${REQUIREMENT}

# Create Project by Default Settings
RUN mkdir -p /opt/${PROJECT}/${SERVICE}
COPY ${PROJECT} /opt/${PROJECT}/${SERVICE}/${PROJECT}
WORKDIR /opt/${PROJECT}/${SERVICE}/${PROJECT}
CMD ['sh', 'deploy.sh']