import json
from channels.generic.websocket import WebsocketConsumer
from tailf.tasks import tailf
from asgiref.sync import async_to_sync


class TailfConsumer(WebsocketConsumer):
    def connect(self):
        self.result = tailf.delay(self.channel_name)
        print('connect:', "channel_name: ",self.channel_name, "result.id:", self.result.id)
        self.accept()

    def disconnect(self, close_code):
        # 中止执行中的Task
        self.result.revoke(terminate=True)
        print('disconnect:', self.channel_name)

    def send_message(self, event):
        self.send(text_data=json.dumps({"message": event["message"]}, ensure_ascii=False))
