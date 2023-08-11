from channels.generic.websocket import AsyncJsonWebsocketConsumer, WebsocketConsumer
from django.db import close_old_connections
from django_redis import get_redis_connection
from asgiref.sync import async_to_sync
import json

class LogConsumer(WebsocketConsumer):
    # def __init__(self, *args, **kwargs):
    #     super().__init__(args, kwargs)
    #     self.user = None
        # self.p = self.rds.pubsub(ignore_subscribe_messages=True)
        # self.p.subscribe([self.room_name])
        
    def connect(self):
        self.room_name = 'log_channel'
        # self.room_group_name = f"chat_{self.room_name}"
        self.rds = get_redis_connection()
        self.p = self.rds.pubsub(ignore_subscribe_messages=True)
        self.p.subscribe(self.room_name)
        self.accept()
        async_to_sync(self.channel_layer.group_add)(
            self.room_name,
            self.channel_name
        )
        
        print('connect')
        # close_old_connections()
        
    def disconnect(self, code):
        # self.p.unsubscribe(self.room_name)  # 取消订阅 Redis 频道
        async_to_sync(self.channel_layer.group_discard)(
            self.room_name,
            self.channel_name
        )
        print('disconnect')
        self.p.close()
        self.rds.close()
    
    def receive(self, text_data):
        response = self.p.get_message(timeout=10)
        print("receive",response)
        print("receive",text_data)
        while response:
            data = str_decode(response['data'])
            self.send(text_data=data)
            response = self.p.get_message(timeout=10)
        # self.send(text_data='pong')
    
    def log_message(self, event):
    #     response = self.p.get_message(timeout=10)
    #     while response:
    #         data = str_decode(response['data'])
    #         self.send(text_data=data)
    #         response = self.p.get_message(timeout=10)
    #     self.send(text_data='pong')
        
        log_data = event['text']
        print(log_data)
        self.send(text_data=json.dumps(log_data))


def str_decode(data):
    try:
        data = data.decode()
    except UnicodeDecodeError:
        try:
            data = data.decode(encoding='GBK')
        except UnicodeDecodeError:
            data = data.decode(errors='ignore')
    return data