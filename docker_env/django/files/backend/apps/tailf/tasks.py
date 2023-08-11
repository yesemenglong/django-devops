from __future__ import absolute_import
from celery import shared_task

import time
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
from django.conf import settings
from django.db import close_old_connections


@shared_task
def tailf(channel_name):
    channel_layer = get_channel_layer()
    filename = '/data/dev/django-vue-lyadmin/backend/logs/batch.log'

    try:
        with open(filename, 'r', encoding='utf-8') as f:
            f.seek(0, 2)
            while True:
                line = f.readline()
                if line:
                    async_to_sync(channel_layer.send)(
                        channel_name, {"type": "send.message", "message": line}
                    )
                else:
                    time.sleep(0.5)
    except Exception as e:
        print(e)
    finally:
        print("-----close_old_connections-----")
        close_old_connections()