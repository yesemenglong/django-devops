import requests
import re
import logging
from django.conf import settings
from django.http import HttpResponse
from django.views import View
from django.db import IntegrityError
from rest_framework import mixins, viewsets, generics
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
from . import serializers
from .models import ZoneList, ZoneMergeList, Version, ZoneMove
from .filters import ZoneMergeFilter, ZoneListFilter
from apps.salt_dev.salt_api import SaltAPI
from apps.salt_dev.models import MinionList
from utils.pagination import CustomPagination
from utils import batchCreate, yamls


logger = logging.getLogger("salt")
logger1 = logging.getLogger("batch_cmd")

# m
def MinionIdList(minion_id):
    minion_id_list = ZoneList.objects.filter(m_zone=0).filter(minion_id=minion_id)
    id_list = []
    for i in minion_id_list:
        id_list.append(i.id)

    return id_list

# --- 区服管理 ---
class ZoneListViewSet(viewsets.ModelViewSet):
    """
    区服列表
    
    list: 
        区服列表信息
    create: 
        创建单个区服信息
    destroy: 
        删除
    update:
        更新
    retrieve:
        查询单个
    """
    queryset = ZoneList.objects.all()
    serializer_class = serializers.ZoneListSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter)
    filterset_fields = ('minion_id', 'zone_id', 'm_zone')
    # 引入公共分页类
    pagination_class = CustomPagination
    search_fields = ('zone_id',)
    # 可选的排序规则
    ordering_fields = ('minion_id', 'zone_id')

    def create(self, request, *args, **kwargs):
        minion_id = request.data.get("minion_id")
        ids = request.data.get("id")
        minionList = MinionList.objects.all()
        ip = minionList.get(minion_id=minion_id).ip
        domain = minionList.get(minion_id=minion_id).do_main
        request.data.update({"ip": ip, "db": settings.GAME_DATABASE_IP, "domain": domain})
        
        id_list = MinionIdList(minion_id)
        if ids in id_list:
            return Response({'results': "ID重复，添加失败", 'status': False})

        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            self.perform_create(serializer)
            return Response({'results': "添加成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)

        if serializer.is_valid():
            self.perform_update(serializer)
            if getattr(instance, '_prefetched_objects_cache', None):
                # If 'prefetch_related' has been applied to a queryset, we need to
                # forcibly invalidate the prefetch cache on the instance.
                instance._prefetched_objects_cache = {}
            return Response({'results': "更新成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        try: 
            self.perform_destroy(instance)
            return Response({'results': "删除成功", 'status': True})
        except Exception as e:
            logger.error(e)
            return Response({'results': '删除失败 ' + str(e), 'status': False})
    

# class ZoneListMinionViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
#     queryset = ZoneList.objects.all()
#     serializer_class = serializers.ZoneListSerializer

#     pagination_class = CustomPagination

#     # 可选的排序规则
#     ordering_fields = ('minion_id', 'zone_id')

#     def get_queryset(self):
#         minion_id = self.request.GET.get('minion_id')
#         queryset = ZoneList.objects.filter(minion_id=minion_id)
#         return queryset


class ZoneListBatchCreateViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    create:
        批量创建区服信息
    """
    queryset = ZoneList.objects.all()
    serializer_class = serializers.ZoneListSerializer

    def create(self, request, *args, **kwargs):
        start_id = request.data.get('start_id')
        if ZoneList.objects.filter(zone_id=start_id).exists():
            return Response({'results': "起始区服已存在", 'status': False})
        
        data = batchCreate.batch_create(start_id, request.data.get('login_num'),
                                        request.data.get('add_num'))
        if data is None:
            return Response({'results': "服务器空位不足", 'status': False})
        serializer = self.get_serializer(data=data["add_sql_datas"], many=True)

        if serializer.is_valid(raise_exception=True):
            self.perform_create(serializer)
            return Response({'results': "批量添加成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})


class ZoneListExportViewSet(View):
    def get(self, request, *args, **kwargs):
        datas = ZoneList.objects.all().values()
        data = yamls.sql_to_yaml(datas)
        response = HttpResponse(data, content_type='application/yaml')
        response['Content-Disposition'] = 'attachment; filename="exported_data.yaml"'

        return response


class ZoneMinionIDViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    list:
        minion已使用id
    """
    queryset = ZoneList.objects.all()
    serializer_class = serializers.MinionZoneIDSerializer
    pagination_class = None
    
    def get_queryset(self):
        minion_id = self.request.GET.get('minion_id')
        queryset = ZoneList.objects.filter(minion_id=minion_id).filter(m_zone=0).values('id')
        return queryset


class ZoneListStatusViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    list：
        获取未执行创区的区服信息
    """
    queryset = ZoneList.objects.all()
    serializer_class = serializers.ZoneListSerializer

    pagination_class = CustomPagination

    # 可选的排序规则
    ordering_fields = ('minion_id', 'zone_id')

    def get_queryset(self):
        queryset = ZoneList.objects.filter(status=0)
        return queryset
    
# 执行sls 
def salt_sls(data):
    with requests.Session() as s:
        slatapi = SaltAPI(session=s)
        response_data = slatapi.public(data=data)
        if response_data is False:
            print(response_data)
            return False
        else:
            try:
                return response_data
            except Exception as e:
                return False
            

class BeployZoneViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    create：
        创建单个区服
    """
    serializer_class = serializers.ZoneListSerializer
    
    def create(self, request, *args, **kwargs):
        zone_id = request.data.get('zone_id')
        minion_id = request.data.get('minion_id')
        if ZoneList.objects.get(zone_id=zone_id).status == 1:
            return Response({'results': '\n区服已创建，请检查配置文件', 'status': False})
        
        name = ZoneList.objects.get(zone_id=zone_id).name
        id = ZoneList.objects.get(zone_id=zone_id).id
        ip = MinionList.objects.get(minion_id=minion_id).ip
        domain = MinionList.objects.get(minion_id=minion_id).do_main
        try:
            # 写入pillar中的zones
            data = {'name': name, 'ip': ip, 'host': minion_id, 'db': settings.GAME_DATABASE_IP, 'id': id}
            yamls.update_yaml('create', zone_id, data)
        except Exception as e:
            yamls.update_yaml('delete', zone_id)
            logger.error(e)
            return Response({'results': '写入 zones 失败 ' + str(e), 'status': False})
        
        # 创建
        arg = ['game.create', 'pillar={"zone": "%s"}' % zone_id]
        tgt = '%s' % minion_id
        data = {'client': "local", 'fun': 'state.apply', 'arg': arg, 'tgt': tgt, 'tgt_type': 'glob'}
        response_data = salt_sls(data)
        logger.info(response_data)
        if response_data is False:
            return Response({'results': '\nsalt命令执行后台出错_error(create)，请联系管理员', 'status': False})
        else:
            response_data = response_data['return'][0]
        # 安装
        version = Version.objects.filter(id=1).get().version
        i_arg = ['game.install', 'pillar={"zone": "%s", "version": "%s", "env": "zones"}' % (zone_id, version)]
        i_data = {'client': "local", 'fun': 'state.apply', 'arg': i_arg, 'tgt': tgt, 'tgt_type': 'glob'}
        response_data2 = salt_sls(i_data)
        logger.info(response_data2)
        if response_data2 is False:
            return Response({'results': '\nsalt命令执行后台出错_error(install)，请联系管理员', 'status': False})
        else:
            response_data2 = response_data2['return'][0]
        
        ZoneList.objects.filter(zone_id=zone_id).update(status=1)
        # 备份    
        b_arg = ['game.start-backupdb', 'pillar={"zone": "%s"}' % zone_id]
        b_data = {'client': "local", 'fun': 'state.apply', 'arg': b_arg, 'tgt': tgt, 'tgt_type': 'glob'}
        response_data3 = salt_sls(b_data)
        logger.info(response_data3)
        try:
            # 移入pillar中的zones_wait
            yamls.move_yaml(zone_id)
            # 写入
            data = {'name': name, 'ip': ip, 'host': minion_id, 'db': settings.GAME_DATABASE_IP, 'id': id, 'domain': domain, 'zone_id': zone_id}
            yamls.extend_json("create", data)
        except Exception as e:
            logger.error(e)
            return Response({'results': '插入 zones_wait 失败 ' + str(e), 'status': False})
        if response_data3 is False:
            return Response({'results': '\nsalt命令执行后台出错_error(backupdb)，请联系管理员', 'status': False})
        else:
            response_data3 = response_data3['return'][0]
            return Response({'results': {"create":response_data, "install": response_data2, "backupdb": response_data3}, 'status': True})
        
        
class BatchBeployViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    create:
        批量创建区服
    """
    serializer_class = serializers.ZoneListSerializer
    
    def create(self, request, *args, **kwargs):
        zoneList = ZoneList.objects.all()
        zones = zoneList.filter(status=0)
        minionList = MinionList.objects.all()
        version = Version.objects.filter(id=1).get().version

        if zones:
            for i in zones:
                # 添加配置信息
                name = i.name
                id = i.id
                ip = minionList.get(minion_id=i.minion_id).ip
                domain = minionList.get(minion_id=i.minion_id).do_main
                try:
                    # 写入pillar中的zones
                    data = {'name': name, 'ip': ip, 'host': i.minion_id.minion_id, 'db': settings.GAME_DATABASE_IP, 'id': id}
                    yamls.update_yaml('create', i.zone_id, data)
                except Exception as e:
                    yamls.update_yaml('delete', i.zone_id)
                    logger1.error(e)
                    return Response({'results': '写入 zones 失败 ' + str(e), 'status': False})
                
                tgt = '%s' % i.minion_id.minion_id
                arg = ['game.create', 'pillar={"zone": "%s"}' % i.zone_id]
                data = {'client': "local", 'fun': 'state.apply', 'arg': arg, 'tgt': tgt, 'tgt_type': 'glob'}
                response_data = salt_sls(data)
                logger1.debug(response_data)
            
                # version = "0.7.98.22112103"
                i_arg = ['game.install', 'pillar={"zone": "%s", "version": "%s", "env": "zones"}' % (i.zone_id, version)]
                i_data = {'client': "local", 'fun': 'state.apply', 'arg': i_arg, 'tgt': tgt, 'tgt_type': 'glob'}
                response_data2 = salt_sls(i_data)
                logger1.debug(response_data2)
                
                zoneList.filter(zone_id=i.zone_id).update(status=1)
                
                b_arg = ['game.start-backupdb', 'pillar={"zone": "%s"}' % i.zone_id]
                b_data = {'client': "local", 'fun': 'state.apply', 'arg': b_arg, 'tgt': tgt, 'tgt_type': 'glob'}
                response_data3 = salt_sls(b_data)
                logger1.debug(response_data3)
                
                try:
                    # 移入pillar中的zones_wait
                    yamls.move_yaml(i.zone_id)
                    data = {'name': name, 'ip': ip, 'host': i.minion_id.minion_id, 'db': settings.GAME_DATABASE_IP, 'id': id, 'domain': domain, 'zone_id': i.zone_id}
                    yamls.extend_json("create", data)
                except Exception as e:
                    logger1.error(e)
                    return Response({'results': '插入 zones_wait 失败 ' + str(e), 'status': False})
        else:
            return Response({'results': "没有未创建的区服", 'status': False})
        return Response({'results': "批量创建成功", 'status': True})


class ZoneMergeViewSet(viewsets.ModelViewSet):
    """
    合服信息列表
    
    create：
        单条创建
    update：
        更新
    destroy：
        删除
    """
    queryset = ZoneMergeList.objects.all()
    serializer_class = serializers.ZoneMergeSerializer
    
    pagination_class = CustomPagination
    filterset_class = ZoneMergeFilter
    
    def create(self, request, *args, **kwargs):
        res = check(request)
        if res != None:
            return Response(res)
        
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            self.perform_create(serializer)
            return Response({'results': "添加成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})
    
    def update(self, request, *args, **kwargs):
        res = check(request)
        if res != None:
            return Response(res)
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)

        if serializer.is_valid():
            self.perform_update(serializer)
            if getattr(instance, '_prefetched_objects_cache', None):
                # If 'prefetch_related' has been applied to a queryset, we need to
                # forcibly invalidate the prefetch cache on the instance.
                instance._prefetched_objects_cache = {}
            return Response({'results': "更新成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})
    
    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        try: 
            self.perform_destroy(instance)
            return Response({'results': "删除成功", 'status': True})
        except Exception as e:
            logger.error(e)
            return Response({'results': '删除失败 ' + str(e), 'status': False})


def check(request):
    mzone = request.data.get('mzone')
    cozone = request.data.get('cozone')
    return checkInfo(mzone, cozone)
              
def checkInfo(mzone, cozone):
    try:
        cozone_list = [int(x) for x in cozone.split(',')]
    except Exception as e:
        return ({'results': "副区输入错误，请输入数字和英文符号", 'status': False})
    
    zones = ZoneList.objects.filter(m_zone=0).filter(status=1).values('zone_id')
    zone_ids = [item['zone_id'] for item in zones]
    if mzone not in zone_ids:
        return ({'results': "合服信息错误，主区 %s 不存在或已被合并" % mzone, 'status': False})
    
    for i in cozone_list:
        # 副区需大于主区
        if i <= int(mzone):
            return ({'results': "合服信息错误", 'status': False})
        # 副区中不能有重复区号
        if cozone_list.count(i) > 1:
            return ({'results': "合服信息错误，有重复区服", 'status': False})
        # 副区是否存在或已被合并
        if i not in zone_ids:
            return {'results': "合服信息错误，副区 %s 不存在或已被合并" % i, 'status': False}
    
    # 检查 pillar 文件
    msg, status = yamls.check_yaml(cozone_list)
    if status == False:
        return {'results': msg, 'status': False}  


            
class ZoneMergeExeViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    执行合服操作
    
    """
    serializer_class = serializers.ZoneMergeSerializer
    
    def create(self, request, *args, **kwargs):
        mzone = request.data.get('mzone')
        cozone = request.data.get('cozone')
        cozone_list = [int(x) for x in cozone.split(',')]
        
        res = checkInfo(mzone, cozone)
        if res != None:
            return Response(res)
        zoneList = ZoneList.objects.all()
        tgt = zoneList.filter(zone_id=int(mzone)).values('minion_id')[0]['minion_id']
        # tgt = '*'
        # stop_arg = ['game.stop', 'pillar={"zone": "%s"}' % mzone]
        # stop_data = {'client': "local", 'fun': 'state.apply', 'arg': stop_arg, 'tgt': tgt, 'tgt_type': 'glob'}
        # stop_response = salt_sls(stop_data)
        # logger1.debug(stop_response)
        
        b_arg = ['game.start-backupdb', 'pillar={"zone": "%s"}' % mzone]
        b_data = {'client': "local", 'fun': 'state.apply', 'arg': b_arg, 'tgt': tgt, 'tgt_type': 'glob'}
        backupdb_response = salt_sls(b_data)
        logger1.debug(backupdb_response)
        
        logs = []
        
        for i in cozone_list:                        
            # stop_arg = ['game.stop', 'pillar={"zone": "%s"}' % i]
            # stop_data = {'client': "local", 'fun': 'state.apply', 'arg': stop_arg, 'tgt': tgt, 'tgt_type': 'glob'}
            # stop_response = salt_sls(stop_data)
            # logger1.debug(stop_response)
            # zoneList.filter(m_zone=i)
            # merge_arg = ['game.merge', 'pillar={"szone": "%s", "sip": "%s", "zone": "%s", "cozones": "%s"}']
            merge_arg = ['game.merge', 'pillar={"szone": "%s", "tzone": "%s"}' % (i, mzone)]
            merge_data = {'client': "local", 'fun': 'state.apply', 'arg': merge_arg, 'tgt': tgt, 'tgt_type': 'glob'}
            merge_response = salt_sls(merge_data)
            logger1.debug(merge_response)
            logs.append(merge_response)
            key_name = list(merge_response['return'][0][tgt].keys())
            if merge_response['return'][0][tgt][key_name[0]]['changes']['retcode'] != 0:
                return Response({'results': {"backupdb": backupdb_response, "merge": logs}, 'status': 'failure'})
            
            # 修改历史被合区服
            old_cozone = zoneList.filter(m_zone=i).values('zone_id')
            if old_cozone != None:
                old_cozone_ids = [item['zone_id'] for item in old_cozone]
                yamls.update_json(mzone, old_cozone_ids)
            
            ZoneMergeList.objects.filter(id=request.data.get('id')).update(status=1)
            zoneList.filter(zone_id=i).update(m_zone=mzone)
            zoneList.filter(m_zone=i).update(m_zone=mzone)
            
        # 删除pillar中的被合区服
        yamls.delete_yaml(cozone_list) 
        # 修改区服入口
        yamls.update_json(mzone, cozone_list)
        return Response({'results': {"backupdb": backupdb_response, "merge": logs}, 'status': True})


class BatchZoneMergeViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    批量创建合服信息
    """
    queryset = ZoneMergeList.objects.all()
    serializer_class = serializers.ZoneMergeSerializer
    
    def create(self, request, *args, **kwargs):
        lists = request.data.get('info')
        lst = []

        last_id = ZoneMergeList.objects.values_list('id', flat=True).order_by('-id').first() or 0
        
        for line in lists.split("\n"):
            result = re.split(r'\s+', line, maxsplit=1)
            
            res = checkInfo(int(result[0]), result[1])
            if res != None:
                return Response(res)
            
            last_id = last_id + 1
            lst.append(ZoneMergeList(id=last_id, mzone=result[0], cozone=result[1]))
            
        try: 
            created_objs = ZoneMergeList.objects.bulk_create(lst)
            print(f'Successfully created {len(created_objs)} objects.')
            return Response({'results': "创建成功", 'status': True})
        except IntegrityError as e:
            print(f'Error occurred during bulk create: {str(e)}')
            return Response({'results': "创建失败, %s" % e, 'status': False})
        
        
class VersionViewSet(mixins.UpdateModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    """
    版本号
    """
    queryset = Version.objects.all()
    serializer_class = serializers.VersionSerializer
    
    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)

        if serializer.is_valid():
            self.perform_update(serializer)
            if getattr(instance, '_prefetched_objects_cache', None):
                # If 'prefetch_related' has been applied to a queryset, we need to
                # forcibly invalidate the prefetch cache on the instance.
                instance._prefetched_objects_cache = {}
            return Response({'results': "更新成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})
    
    
class ZoneMoveListViewSet(viewsets.ModelViewSet):
    queryset = ZoneMove.objects.all()
    serializer_class = serializers.ZoneMoveSerializer
    
    def create(self, request, *args, **kwargs):
        zone_id = request.data.get("zone_id")
        minion_id = request.data.get("tg_minion")
        id = request.data.get("port_id")
        # 判断是否被合并
        if ZoneList.objects.filter(zone_id=zone_id).get().m_zone == 1:
            return Response({'results': "已被合并", 'status': False})
        id_list = MinionIdList(minion_id)
        # 判断是否重复
        if id in id_list:
            return Response({'results': "ID重复", 'status': False})
        
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            self.perform_create(serializer)
            return Response({'results': "添加成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})
    
    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)

        if serializer.is_valid():
            self.perform_update(serializer)
            if getattr(instance, '_prefetched_objects_cache', None):
                # If 'prefetch_related' has been applied to a queryset, we need to
                # forcibly invalidate the prefetch cache on the instance.
                instance._prefetched_objects_cache = {}
            return Response({'results': "更新成功", 'status': True})
        else:
            return Response({'results': serializer.errors, 'status': False})
        
        
# class TestViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
#     """
#     """
#     queryset = ZoneMergeList.objects.all()
#     serializer_class = serializers.ZoneMergeSerializer
    
#     def create(self, request, *args, **kwargs):
#         from apps.salt_dev.tasks import cmd
#         r = cmd.delay(execute_cmd="sleep 30")
        
#         return Response({'results': "ok", 'status': True})
        

# class Test2ViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
#     queryset = ZoneMergeList.objects.all()
#     serializer_class = serializers.ZoneMergeSerializer
    
#     def create(self, request, *args, **kwargs):
#         import signal
#         from celery.result import AsyncResult
#         # from django.db import close_old_connections
#         # close_old_connections()
        
#         print("close_old_connections")
#         result = AsyncResult(request.data.get('task_id'))
#         result.revoke(terminate=True, signal=signal.SIGKILL)
#         from django.db import connection
#         connection.close()
#         return Response({'results': "ok", 'status': True})
        