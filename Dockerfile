# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200317
# @UPDATE: 20200324

# ARGUMENTs
ARG NODE_VERSION=13.10.1
ARG ALPINE_VERSION=3.10

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION}

# Labels
# Maintainer
LABEL maintainer="imyme6yo"
LABEL email="imyme6yo@gmail.com"

# Arguments
ARG DIR=code
ARG PROJECT=myapp
ARG PORT=9213

# ENVs
ENV HOST 0.0.0.0
ENV PORT=${PORT}
ENV PROJECT=${PRJECT}

# Install Alpine Packages
RUN apk update && apk upgrade
RUN apk --no-cache add git

# Install create-react-app
RUN npm install -g create-react-app

RUN mkdir ${DIR}
WORKDIR ${DIR}
COPY . .