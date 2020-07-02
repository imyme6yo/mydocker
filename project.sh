!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200416
# @UPDATE: 20200703

# alter role root set client_encoding to 'utf-8';
# alter role root set timezone to 'Asia/Seoul';
# grant all privileges on database django_test to root;

python manage.py makemigrations
python manage.py migrate
# python manage.py runserver
# run test
# python manage.py test
# coverage html
ash