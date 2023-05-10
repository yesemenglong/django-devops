from rest_framework import mixins, viewsets
from rest_framework.response import Response
from django.db.models import Count
from .serializers import DashboardSerializer
from ..salt_dev.models import SaltKeyList, MinionList
import psutil
import logging
logger = logging.getLogger(__name__)


class DashboardViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    serializer_class = DashboardSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            response_data = {'results': {}, 'status': False}
            # 统计saltkey的状态
            response_data['results']['saltkey_certification_count'] = SaltKeyList.objects.values(
                'certification_status').order_by('certification_status').annotate(Count('certification_status'))
            # 统计minion的状态
            response_data['results']['minion_status_count'] = MinionList.objects.values('minion_status').order_by(
                'minion_status').annotate(Count('minion_status'))
            sys_status = []
            cpu_use = str(100 - int(psutil.cpu_times_percent(interval=1, percpu=False).idle)) + '%'
            mem_use = str(psutil.virtual_memory().used // 1024 // 1024) + '/' + str(
                psutil.virtual_memory().total // 1024 // 1024) + 'M'
            sys_status.append({'name': 'CPU使用率', 'value': cpu_use})
            sys_status.append({'name': '内存使用率', 'value': mem_use})
            disk = psutil.disk_partitions()
            for i in disk:
                disk_use = psutil.disk_usage(i.mountpoint)
                # 判断一下磁盘是否已经存在列表中了，因为有时候一个磁盘挂载了好几个目录，disk里包含每个目录但其实都是同一个磁盘
                # 所以加过一次以后，如果一样的就不要加了
                if {'name': '磁盘 %s 使用率' % i.device, 'value': '%.1f%%' % disk_use.percent} not in sys_status:
                    sys_status.append({'name': '磁盘 %s 使用率' % i.device, 'value': '%.1f%%' % disk_use.percent})
            response_data['results']['sys_status'] = sys_status
        else:
            response_data = {'results': serializer.errors, 'status': False}
        return Response(response_data)
