# @AUTHOR: jon "imyme6yo@gmail.com"
# @DRAFT: 20200317
# @UPDATE: 20200319

# ARGUMENTs
ARG NODE_VERSION=13.10.1
ARG ALPINE_VERSION=3.10

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION}

# Labels
# Maintainer
LABEL maintainer="imyme6yo"
LABEL email="imyme6yo@gmail.com"

# ENVs
ENV HOST 0.0.0.0
ENV PROJECT myapp

# Arguments
ARG DIR=code
ARG PORT=9213

# Install Alpine Packages
RUN apk update && apk upgrade
RUN apk --no-cache add git

# Create Project by Default Settings
RUN mkdir ${DIR}
WORKDIR ${DIR}
COPY . .
WORKDIR ${PROJECT}

RUN npm install

EXPOSE 9213

#
# docker build -t vue:$(echo "${PWD##*/}") --build-arg DIR_NAME=$(echo "${PWD##*/}") --build-arg PROJECT_NAME=$(echo "${PWD##*/}") .
#
# docker run --rm -it -v $(pwd)/:/$(echo "${PWD##*/}") vue:$(echo "${PWD##*/}") -p ${PORT}:${PORT} ash
# npm run serve -- --port ${PORT}