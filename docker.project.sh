# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200319

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
ENV PROJECT=${PROJECT}


# ARG REQUIREMENTS=requirements.txt

# Install Alpine Packages
RUN apk update && apk upgrade
RUN pip install --upgrade pip

# Create Project by Default Settings
RUN mkdir ${DIR}
WORKDIR ${DIR}
COPY . .
RUN pip install -r requirements.txt
WORKDIR ${PROJECT}

#
# docker build -t vue:$(echo "${PWD##*/}") --build-arg DIR_NAME=$(echo "${PWD##*/}") --build-arg PROJECT_NAME=$(echo "${PWD##*/}") .
#
# docker run --rm -it -v $(pwd)/:/$(echo "${PWD##*/}") vue:$(echo "${PWD##*/}") ash