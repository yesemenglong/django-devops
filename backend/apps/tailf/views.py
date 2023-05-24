from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from tailf.tasks import tailf


class TailfView(APIView):
    """
    websocket 视图
    """    
    def post(self, request):
        # file_path = request.data.get('/data/dev/django-vue-lyadmin/backend/logs/server.log')
        # tailf.delay(file_path)
        return Response({'message': 'tailf started'})
