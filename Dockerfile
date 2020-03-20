# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200320

# ARGUMENTs
ARG VER=3.8.2
ARG ALPINE=3.11

FROM python:${VER}-alpine${ALPINE}

# LABELs
LABEL maintainer="imyme6yo"
LABEL email="imyme6yo@gmail.com"

# ARGUMENTs
ARG DIR=code
ARG PROJECT=myapp

# ENV
ENV DIR=${DIR}
ENV PROJECT=${PROJECT}

# Install Alpine Packages
RUN apk update && apk upgrade
RUN pip install --upgrade pip

# Create Project by Default Settings
RUN mkdir ${DIR}
WORKDIR ${DIR}
COPY . .
RUN pip install -r requirements.txt
WORKDIR ${PROJECT}
