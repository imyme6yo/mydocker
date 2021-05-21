# !/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210519
# python manage.py makemigrations myapp drf_chunked_upload
# python manage.py migrate
# python manage.py loaddata myapp/fixtures/*.json
# python manage.py loaddata myapp/fixtures/categories.json
# python manage.py loaddata myapp/fixtures/tags.json
# python manage.py loaddata myapp/fixtures/languages.json
# python manage.py loaddata fixtures/test_superuser.json
# python manage.py makemigrations myapp drf_chunked_upload --settings=myproj.settings
python manage.py makemigrations ${APP} drf_chunked_upload --settings=${PROJECT}.settings
python manage.py migrate --settings=${PROJECT}.settings
python manage.py loaddata ${APP}/fixtures/*.json
# python manage.py loaddata myapp/fixtures/categories.json
# python manage.py loaddata myapp/fixtures/tags.json
# python manage.py loaddata myapp/fixtures/languages.json
python manage.py loaddata fixtures/test_superuser.json
gunicorn  ${PROJECT}.wsgi 127.0.0.1:${PORT} --capture-output --log-level debug