#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200725
# @UPDATE: 20200726

# Config Postgres
# create group
# set username / password
pip freeze > ${REQUIREMENT}
django-admin startproject $DIR
cp ./django/settings.pg.py ./$DIR/$DIR/settings.py