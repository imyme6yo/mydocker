"""
WSGI config for myproj project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

PROJECT = os.getenv('PROJECT')
PROJECT_SETTINGS = '{}.settings'.format(PROJECT)
os.environ.setdefault('DJANGO_SETTINGS_MODULE', PROJECT_SETTINGS)

application = get_wsgi_application()
