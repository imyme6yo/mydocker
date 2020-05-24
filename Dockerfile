# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200522
ARG JEKINKS=2.60.3
FROM jenkins:${JEKINKS}-alpine

# Lables
# matainer
LABEL matainer="imyme6yo"
LABEL email="imyme6yo@gmail"
# service
LABEL NAME="myjenkins"
LABEL VERSION="0.0.1"

# Arguments
ARG JENKINS_HOME=/var/lib/jenkins
ARG PROJECT=myjenkins
ARG SERVICE=${PROJECT}
ARG NETWORK=myproject
ARG HOST=${HOST}
ARG PORT=8080
ARG GIT_REPO=""

# Env
ENV HOST=${HOST}
ENV PORT=${PORT}
ARG JENKINS_HOME=${JENKINS_HOME}
ARG PROJECT={PROJECT}
ARG SERVICE=${SERVICE}}
ARG CONTAINER=${SERVICE}

# 
EXPOSE 8080
