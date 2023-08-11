from django.urls import re_path,path

from . import consumers

websocket_urlpatterns = [
    re_path(r'^ws/tailf/$', consumers.TailfConsumer.as_asgi()),
]