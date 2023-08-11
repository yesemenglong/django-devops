#!/bin/python
#coding: utf-8
# +-------------------------------------------------------------------
# | system: django-vue-lyadmin


# ------------------------------
# celery
# ------------------------------
# 官网
# https://docs.celeryproject.org/en/stable/index.html
# https://django-celery-beat.readthedocs.io/en/latest/
# http://django-celery-results.readthedocs.io/
# ------------------------------

import os
from django.conf import settings
from celery import platforms
from celery import Celery

# Set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'application.settings')

app = Celery("application")

# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#  should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings',namespace='CELERY')
app.conf.worker_lost_wait_timeout = 30
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)

platforms.C_FORCE_ROOT = True
