# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210424
# @UPDATE: 20210519
# Arguments
ARG PYTHON=3.8
ARG ALPINE=3.10
ARG TAG=python${PYTHON}-alpine${ALPINE}

# Base image
FROM tiangolo/uvicorn-gunicorn-fastapi:${TAG}

# Labels
# Maintainer
LABEL maintainer="imyme6yo"
LABEL email="imyme6yo@gmail.com"
# Service
LABEL project=myproj
LABEL name=myproj-myapp
LABEL version=0.1.1

ARG MODE=DEV
ARG DEBUG='true'
ARG IP_MAIN=127.0.0.1
ARG IP_DEV=localhost
ARG PROJECT=myproj
ARG PROJECT_NETWORK=${PROJECT}-network
ARG IMAGE_TAG=dev
ARG SERVICE=myapp
ARG PORT=3000
ARG DATABASE_HOST=${PROJECT}-${SERVICE}-db
ARG DATABASE_PORT=5432
ARG DATABASE_USER=admin
ARG DATABASE_PASSWORD=password
ARG DATABASE_DB=myapp

# Envs
ENV MODE=${MODE}
ENV DEBUG=${DEBUG}
ENV IP_MAIN=${IP_MAIN}
ENV IP_DEV=${IP_DEV}
ENV PROJECT=${PROJECT}
ENV IMAGE_TAG=${IMAGE_TAG}
ENV SERVICE=${SERVICE}
ENV PORT=${PORT}
ENV DATABASE_HOST=${DATABASE_HOST}
ENV DATABASE_PORT=${DATABASE_PORT}
ENV DATABASE_USER=${DATABASE_USER}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ENV DATABASE_DB=${DATABASE_DB}

# Install alpine dependancies
# RUN apk add postgresql
RUN apk update && apk upgrade
RUN apk add --no-cache --virtual .build-deps gcc libc-dev libffi-dev openssl-dev build-base bsd-compat-headers make python-dev postgresql-dev

# RUN apk add --no-cache --virtual .build-deps gcc libc-dev libffi-dev openssl-dev build-base bsd-compat-headers make \
#     && python3 -m pip install hypercorn hypercorn[uvloop] hypercorn[trio] trio aioquic hypercorn[h3] fastapi \
#     --no-cache-dir --no-color --no-python-version-warning --disable-pip-version-check \
#     && apk del .build-deps gcc libc-dev make

# Install python dependancies

RUN /usr/local/bin/python -m pip install --upgrade pip
# RUN pip install fastapi-sqlalchemy alembics psycopg2
RUN pip install fastapi-sqlalchemy alembic psycopg2-binary
RUN apk del .build-deps gcc libc-dev make
COPY . /opt/${PROJECT}
WORKDIR /opt/${PROJECT}
CMD ["ash"]

EXPOSE ${PORT}