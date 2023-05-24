import datetime
import requests
from rest_framework.response import Response
from .models import SaltKeyList, MinionList, SaltCmdInfo
from . import serializers
from .filters import MinionListFilter
from .salt_api import SaltAPI
from .tasks import saltkey_list, minion_list
from rest_framework import mixins, viewsets
from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend
from utils.pagination import CustomPagination, StandardPagination


class SaltKeyUtils(object):
    """
    salt-key 管理公共类
    """
    @staticmethod
    def salt_key_action(minions, action, message):
        with requests.Session() as s:
            saltapi = SaltAPI(session=s)
            action_method = getattr(saltapi, action)
            response_data = action_method(match=minions)
            if response_data['status']:
                if saltkey_list():
                    response_data = {
                        'results': '%s成功' % message, 'status': True}
                    return response_data
                else:
                    print('%s在执行刷新salt-key操作即tasks.py里的方法时候出错了' % message)
                    response_data = {
                        'results': '%s失败' % message, 'status': False}
                    return response_data
            else:
                return response_data

# --- SaltKey管理 ---
class SaltKeyViewSet(SaltKeyUtils, mixins.CreateModelMixin, mixins.RetrieveModelMixin, mixins.ListModelMixin,
                     viewsets.GenericViewSet):
    """
    SaltKey管理：saltkey列表显示，刷新，和test.ping测试操作

    list: 
        SaltKey列表信息
    create: 
        刷新
            salt_key_tag值为global_flush_salt_key
    retrieve: 
        输入minion_id测试test.ping操作
    """
    queryset = SaltKeyList.objects.all()
    serializer_class = serializers.SaltKeySerializer
    filter_backends = (DjangoFilterBackend,
                       filters.SearchFilter, filters.OrderingFilter)
    filterset_fields = ["certification_status", "id"]
    lookup_field = 'minion_id'
    lookup_value_regex = '.+'

    pagination_class = CustomPagination

    search_fields = ('minion_id',)
    ordering_fields = ('id', 'create_date')

    def get_paginated_response(self, data):
        assert self.paginator is not None
        accepted_count = SaltKeyList.objects.filter(
            certification_status='accepted').count()
        unaccepted_count = SaltKeyList.objects.filter(
            certification_status='unaccepted').count()
        denied_count = SaltKeyList.objects.filter(
            certification_status='denied').count()
        rejected_count = SaltKeyList.objects.filter(
            certification_status='rejected').count()
        msg = {'accepted_count': accepted_count, 'unaccepted_count': unaccepted_count,
               'denied_count': denied_count, 'rejected_count': rejected_count}
        response_data = self.paginator.get_paginated_response(data)
        response_data.data['msg'] = msg
        return response_data

    def get_serializer_class(self):
        if self.action == 'list':
            return serializers.SaltKeySerializer
        elif self.action == 'create':
            return serializers.SaltKeyFlushSerializer
        return serializers.SaltKeySerializer

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        minion_id = instance.minion_id
        with requests.Session() as s:
            saltapi = SaltAPI(session=s)
            response_data = saltapi.test_api(tgt=minion_id)
            return Response(response_data)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return Response({'results': serializer.errors, 'status': False})
        if saltkey_list():
            return Response({'results': '刷新成功', 'status': True})
        else:
            return Response({'results': '刷新失败', 'status': False})


class SaltKeyAcceptViewSet(SaltKeyUtils, mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    SaltKey管理：接收认证

    create:
        接受key
            salt_key_tag值为accept_salt_key
            minion_id值为"minion_id1,minion_id2...." or "*"
    """
    serializer_class = serializers.SaltKeyAcceptSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return Response({'errors': serializer.errors, 'status': False})
        minions = request.data.get('minion_id')
        response_data = self.salt_key_action(
            minions, 'saltkey_accept_api', '接受认证key')
        return Response(response_data)


class SaltKeyDeleteViewSet(SaltKeyUtils, mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    SaltKey管理：删除认证

    create:
        删除key
            salt_key_tag值为delete_salt_key
            minion_id值为"minion_id1,minion_id2...." or "*"
    """
    serializer_class = serializers.SaltKeyDeleteSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return Response({'results': serializer.errors, 'status': False})
        minions = request.data.get('minion_id')
        response_data = self.salt_key_action(
            minions, 'saltkey_delete_api', '删除key')
        return Response(response_data)


class SaltKeyRejectViewSet(SaltKeyUtils, mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    SaltKey管理：拒绝认证

    create:
        拒绝key
            salt_key_tag值为reject_salt_key
            minion_id值为"minion_id1,minion_id2...." or "*"

    """
    serializer_class = serializers.SaltKeyRejectSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return Response({'results': serializer.errors, 'status': False})
        minions = request.data.get_serializer('minion_id')
        response_data = self.salt_key_action(
            minions, 'saltkey_reject_api', '拒绝key')
        return Response(response_data)


class SaltKeyDeleteDeniedViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    SaltKey管理：删除denied中的key操作

    create:
        删除denied的key
            salt_key_tag值为delete_denied_salt_key
            minion_id值为"minion_id1,minion_id2...." or "*"

    """
    serializer_class = serializers.SaltKeyDeleteDeniedSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return Response({'errors': serializer.errors, 'status': False})
        minions = request.data.get('minion_id')
        # 删除denied里的key比较特殊无法通过saltkey_delete_api来删除因为denied的产生是在已接受key中已经存在了同名的minion_id，然后原来
        # 应该存在于未认证列表中的key就会被salt存放到denied里，而通过salt-key -d删除key会把已接受的key一起删除，官方没有提出解决办法，所以
        # 只能通过命令行cmd的方式用rm删除实际存放的文件来销毁denied里的key
        minions = ' '.join(minions)
        with requests.Session() as s:
            saltapi = SaltAPI(session=s)
            # 注意master的minion_id没有设置错误一般删除没都问题
            response_data = saltapi.cmd_run_api(tgt='192.168.123.130-master',
                                                arg='cd /etc/salt/pki/master/minions_denied/ && rm -rf %s' % minions)
            if response_data['status'] is False:
                response_data = {'results': '删除key失败', 'status': False}
                return Response(response_data)
            else:
                if saltkey_list():
                    response_data = {'results': '删除key成功', 'status': True}
                    return Response(response_data)
                else:
                    print('删除denied的key在执行刷新saltkey操作即cron.py里的方法时候出错了')
                    response_data = {'results': '删除key失败', 'status': False}
                    return Response(response_data)


# --- minion管理 ---
class SaltMinionViewSet(mixins.CreateModelMixin, mixins.RetrieveModelMixin, mixins.ListModelMixin,
                        viewsets.GenericViewSet):
    """
    minion管理：列表显示，单独id字段列表显示，以及全局更新操作
    
    list:
        SaltMinion列表信息

    retrieve:
        返回Minion_id字段列表,lookup字段随便输入,
        默认返回所有minion id列表，可以传递sys参数(windows或linux)来单独输出系统为windows的minion id列表或者linux的

    create:
        更新列表
            salt_minion_tag值为global_update_salt_minion_list

    """
    queryset = MinionList.objects.all()
    serializer_class = serializers.SaltMinionSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter)
    filterset_class = MinionListFilter
    # 引入公共分页类
    pagination_class = CustomPagination
    # 自定义每页个数
    # pagination_class.page_size = 1

    # 可选的排序规则
    ordering_fields = ('minion_id', 'ip')

    # 动态选择serializer
    def get_serializer_class(self):
        if self.action == "list":
            return serializers.SaltMinionSerializer
        elif self.action == "create":
            return serializers.SaltMinionListUpdateSerializer
        return serializers.SaltMinionSerializer

    def retrieve(self, request, *args, **kwargs):
        # 注意数据库sys字段首字母是大写的
        if request.query_params.get('sys') == 'windows':
            minion_id_list = MinionList.objects.filter(sys='Windows').order_by('create_date').values_list('minion_id',
                                                                                                          flat=True)
        elif request.query_params.get('sys') == 'linux':
            minion_id_list = MinionList.objects.filter(sys='Linux').order_by('create_date').values_list('minion_id',
                                                                                                        flat=True)
        else:
            minion_id_list = MinionList.objects.all().order_by(
                'create_date').values_list('minion_id', flat=True)
        return Response({'results': list(minion_id_list), 'status': True})

    def create(self, request, *args, **kwargs):
        # 更新minion列表
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return Response({'results': serializer.errors, 'status': False})
        if minion_list():
            return Response({'results': '更新成功', 'status': True})
        else:
            return Response({'results': '更新失败', 'status': False})


class SaltMinionStateUpdateViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    minion管理：全局状态更新操作

    create:
        更新状态
            salt_minion_tag值为global_update_salt_minion_status

    """
    serializer_class = serializers.SaltMinionStateUpdateSerializer

    def create(self, request, *args, **kwargs):
        # 获取 serializer 实例
        serializer = self.get_serializer(data=request.data)

        # 验证 serializer
        if not serializer.is_valid():
            return Response({'results': serializer.errors, 'status': False})

        # 获取 MinionList 中的 minion_id
        minion_list = MinionList.objects.values_list('minion_id', flat=True)

        # 获取在线状态的 minion 的 ID 列表
        with requests.Session() as s:
            saltapi = SaltAPI(session=s)
            response_data = saltapi.saltrun_manage_status_api()
            if response_data['status'] is False:
                print(response_data)
                return Response(response_data)
            else:
                id_list = []
                # 获取在线状态的 minion 的 ID
                status_up = response_data['results']['return'][0]['up']
                # 更新在线状态的 minion
                for minion_id in status_up:
                    updated_values = {'minion_id': minion_id, 'minion_status': '在线',
                                      'update_time': datetime.datetime.now()}
                    MinionList.objects.update_or_create(
                        minion_id=minion_id, defaults=updated_values)

                # 获取离线状态的 minion 的 ID
                status_down = response_data['results']['return'][0]['down']
                # 更新离线状态的 minion
                for minion_id in status_down:
                    updated_values = {'minion_id': minion_id, 'minion_status': '离线',
                                      'update_time': datetime.datetime.now()}
                    MinionList.objects.update_or_create(
                        minion_id=minion_id, defaults=updated_values)

                # 合并在线状态和离线状态的 minion 的 ID
                id_list.extend(status_up)
                id_list.extend(status_down)

                # 删除不在 id_list 中的 minion
                for minion_id in minion_list:
                    if minion_id not in id_list:
                        MinionList.objects.filter(minion_id=minion_id).delete()

                # 返回更新成功的结果
                return Response({'results': '更新成功', 'status': True})


class SaltMinionUpdateViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    minion管理：单个minion更新操作

    create:
        更新单个minion
            salt_minion_tag值为update_salt_minion
            minion_id值为单个minion_id

    """
    serializer_class = serializers.SaltMinionUpdateSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return Response({'results': serializer.errors, 'status': False})
        minion_id = request.data.get('minion_id')
        with requests.Session() as s:
            saltapi = SaltAPI(session=s)
            response_data = saltapi.test_api(tgt=minion_id)
            if response_data['status'] is False:
                print(response_data)
                return Response(response_data)
            else:
                if response_data['results'][minion_id]:
                    try:
                        grains_data = saltapi.grains_items_api(tgt=minion_id)
                        value = grains_data['results']['return'][0][minion_id]
                        try:
                            value['ipv4'].remove('127.0.0.1')
                        except Exception as e:
                            pass
                        try:
                            MinionList.objects.filter(minion_id=minion_id).update(minion_status='在线',
                                                                                  ip=value.get(
                                                                                      'network')[0],
                                                                                  do_main=value.get(
                                                                                      'network')[1],
                                                                                  sn=value.get(
                                                                                      'serialnumber'),
                                                                                  cpu_num=value.get(
                                                                                      'num_cpus'),
                                                                                  cpu_model=value.get(
                                                                                      'cpu_model'),
                                                                                  sys=value.get(
                                                                                      'kernel'),
                                                                                  kernel=value.get(
                                                                                      'kernelrelease'),
                                                                                  product_name=value.get(
                                                                                      'productname'),
                                                                                  ipv4_address=value.get(
                                                                                      'ip4_interfaces'),
                                                                                  mac_address=value.get(
                                                                                      'hwaddr_interfaces'),
                                                                                  localhost=value.get(
                                                                                      'localhost'),
                                                                                  mem_total=value.get(
                                                                                      'mem_total'),
                                                                                  minion_version=value.get(
                                                                                      'saltversion'),
                                                                                  system_issue=value.get(
                                                                                      'os') + value.get('osrelease'),
                                                                                  update_time=datetime.datetime.now())
                        except Exception as e:
                            MinionList.objects.filter(minion_id=minion_id).update(minion_status='异常',
                                                                                  update_time=datetime.datetime.now())
                    except Exception as e:
                        print('单minion更新数据出错1，请检查' + str(e))
                        return Response({'results': '单minion更新数据出错1，请检查' + str(e), 'status': False})
                else:
                    try:
                        MinionList.objects.filter(minion_id=minion_id).update(minion_status='离线',
                                                                              update_time=datetime.datetime.now())
                    except Exception as e:
                        print('单minion更新数据出错2，请检查' + str(e))
                        return Response({'results': '单minion更新数据出错2，请检查' + str(e), 'status': False})
                return Response({'results': '更新成功', 'status': True})


# --- salt命令集管理 ---
class SaltCmdViewSet(mixins.CreateModelMixin, mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    salt命令集管理：列表显示，命令收集操作

    list:
        Salt命令集列表信息

    create:
        收集salt命令集操作
            salt_cmd_tag值为collection_info
            collection_style值为module、state、runner中的一个
            minions值为"minion_id1,minion_id2,....."
    """
    queryset = SaltCmdInfo.objects.all()
    serializer_class = serializers.SaltCmdSerializer
    filter_backends = (DjangoFilterBackend,
                       filters.OrderingFilter, filters.SearchFilter)
    filterset_fields = ('salt_cmd_type', 'salt_cmd_module', 'salt_cmd')

    pagination_class = CustomPagination

    search_fields = ('salt_cmd',)

    ordering_fields = ('id', 'salt_cmd', 'salt_cmd_type')

    def get_serializer_class(self):
        if self.action == "list":
            return serializers.SaltCmdSerializer
        elif self.action == "create":
            return serializers.SaltCmdPostSerializer
        return serializers.SaltCmdSerializer

    def create(self, request, *args, **kwargs):
        minions = request.data.get('minions')
        collection_style = request.data.get('collection_style')
        try:
            with requests.Session() as s:
                saltapi = SaltAPI(session=s)
                if collection_style == 'state':
                    response_data = saltapi.sys_state_doc_api(
                        tgt=minions, tgt_type='list')
                elif collection_style == 'runner':
                    response_data = saltapi.sys_runner_doc_api(
                        tgt=minions, tgt_type='list')
                else:
                    response_data = saltapi.sys_doc_api(
                        tgt=minions, tgt_type='list')
                print(collection_style)
                # 当调用api失败的时候会返回false
                if response_data['status'] is False:
                    print(response_data)
                    return Response(response_data)
                else:
                    response_data = response_data['results']['return'][0]
                    try:
                        info = ''
                        if collection_style == 'state':
                            a = {}
                            b = {}
                            for minion_id, cmd_dict in response_data.items():
                                if isinstance(cmd_dict, dict):
                                    for salt_cmd, salt_cmd_doc in cmd_dict.items():
                                        if len(salt_cmd.split('.')) == 1:
                                            a[salt_cmd] = salt_cmd_doc
                                        else:
                                            b[salt_cmd] = salt_cmd_doc
                                    for salt_cmd in b.keys():
                                        try:
                                            b[salt_cmd] = salt_cmd.split('.')[0] + ':\n' + \
                                                str(a[salt_cmd.split('.')[0]]).replace(
                                                    '\n', '\n    ') + '\n\n' + salt_cmd + ':\n' + str(b[salt_cmd])
                                        except Exception as e:
                                            print('state采集后台错误：' + str(e))
                                            return Response({'results': 'state采集后台错误：' + str(e), 'status': False})
                                        updated_values = {'salt_cmd': salt_cmd, 'salt_cmd_type': collection_style,
                                                          'salt_cmd_module': salt_cmd.split('.')[0], 'salt_cmd_source': minion_id,
                                                          'salt_cmd_doc': b[salt_cmd], 'update_time': datetime.datetime.now()}
                                        SaltCmdInfo.objects.update_or_create(
                                            salt_cmd=salt_cmd, salt_cmd_type=collection_style, defaults=updated_values)
                                elif isinstance(cmd_dict, bool):
                                    info += ' 不过minion_id:' + minion_id + '掉线了没有从它采集到数据'
                            return Response({'results': '采集完成' + info, 'status': True})
                        else:
                            for minion_id, cmd_dict in response_data.items():
                                if isinstance(cmd_dict, dict):
                                    for salt_cmd, salt_cmd_doc in cmd_dict.items():
                                        salt_cmd_doc = str(
                                            salt_cmd) + ':\n' + str(salt_cmd_doc)
                                        updated_values = {'salt_cmd': salt_cmd, 'salt_cmd_type': collection_style,
                                                          'salt_cmd_module': salt_cmd.split('.')[0], 'salt_cmd_source': minion_id,
                                                          'salt_cmd_doc': salt_cmd_doc, 'update_time': datetime.datetime.now()}
                                        SaltCmdInfo.objects.update_or_create(
                                            salt_cmd=salt_cmd, salt_cmd_type=collection_style, defaults=updated_values)
                                elif isinstance(cmd_dict, bool):
                                    info += ' 不过minion_id:' + minion_id + '掉线了没有从它采集到数据'
                            return Response({'results': '采集完成' + info, 'status': True})
                    except Exception as e:
                        print('采集后台错误：' + str(e))
                        return Response({'results': '采集后台错误：' + str(e), 'status': False})
        except Exception as e:
            print('采集信息出错：' + str(e))
            return Response({'results': '采集信息出错：' + str(e), 'status': False})


class SaltCmdDeleteViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    salt命令集管理：删除操作                                                                                                                        

    create:
        删除操作
            salt_cmd_tag值为salt_cmd_delete

    """
    serializer_class = serializers.SaltCmdDeleteSerializer

    def create(self, request, *args, **kwargs):
        result = {'results': None, 'status': False}
        try:
            SaltCmdInfo.objects.all().delete()
            result['results'] = "清除成功"
            result['status'] = True
        except Exception as e:
            message = '清除失败', str(e)
            print(message)
            result['results'] = message
        return Response(result)


class SaltCmdModuleListViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    salt命令集管理：返回salt命令集不同类型下的所有模块module去重列表

    list:
        返回salt命令集不同类型下的所有模块去重列表,必须带过滤条件
    """
    serializer_class = serializers.SaltCmdModuleListSerializer
    filter_backends = (DjangoFilterBackend,)
    filterset_fields = ('salt_cmd_type',)
    pagination_class = None

    def get_queryset(self):
        salt_cmd_type = self.request.GET.get('salt_cmd_type')
        queryset = SaltCmdInfo.objects.filter(salt_cmd_type=salt_cmd_type).values(
            'salt_cmd_module').distinct().order_by('salt_cmd_module')
        return queryset


class SaltCmdCmdleListViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    salt命令集管理：返回salt命令集不同类型不同模块下cmd命令的列表

    list:
        返回salt命令集不同类型不同模块下cmd命令的列表,必须带过滤条件

    """
    serializer_class = serializers.SaltCmdCmdListSerializer
    filter_backends = (DjangoFilterBackend,)
    filterset_fields = ('salt_cmd_type', 'salt_cmd_module',)
    pagination_class = None

    def get_queryset(self):
        salt_cmd_type = self.request.GET.get('salt_cmd_type')
        salt_cmd_module = self.request.GET.get('salt_cmd_module')
        queryset = SaltCmdInfo.objects.filter(salt_cmd_type=salt_cmd_type, salt_cmd_module=salt_cmd_module).\
            values('salt_cmd').order_by('salt_cmd')
        return queryset


# --- salt命令执行 ---
class SaltExeViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    salt命令执行操作

    create:
        执行salt命令操作
            salt_exe_tag值为salt_exe

    """
    serializer_class = serializers.SaltExeSerializer

    def create(self, request, *args, **kwargs):
        client = request.data.get('client')
        arg = request.data.get('arg')
        tgt = request.data.get('tgt')
        tgt_type = request.data.get('tgt_type')
        fun = request.data.get('fun')

        try:
            if client != 'runner':
                data = {'client': client, 'tgt': tgt,
                        'tgt_type': tgt_type, 'fun': fun, 'arg': arg}
            else:
                data = {'client': client, 'fun': fun, 'arg': arg}
            print(data)
            with requests.Session() as s:
                saltapi = SaltAPI(session=s)
                response_data = saltapi.public(data=data)

                if response_data is False:
                    return Response({'results': '\nsalt命令执行后台出错_error(1)，请联系管理员', 'status': False})
                else:
                    try:
                        response_data = response_data['return'][0]
                        return Response({'results': response_data, 'status': True})
                    except Exception as e:
                        return Response({'results': '\n' + 'salt命令执行失败_error(2):' + str(response_data), 'status': False})
        except Exception as e:
            print('salt命令执行后台出错_error(2)：' + str(e))
            return Response({'results': 'salt命令执行后台出错_error(2)：' + str(e), 'status': False})


# --- salt快捷工具
class SaltToolJobStatusViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    任务查询 状态查询操作

    create:
        任务查询 状态查询操作
            salt_tool_tag值为search_jid_status
            jid值为要查询的jid

    """
    serializer_class = serializers.SaltToolJobStatusSerializer

    def create(self, request, *args, **kwargs):
        jid = request.data.get('jid')
        try:
            with requests.Session() as s:
                saltapi = SaltAPI(session=s)
                response_data = saltapi.job_exit_success_api(jid=jid)
                if response_data['status'] is False:
                    print('response_data')
                    return Response(response_data)
                else:
                    try:
                        response_data = response_data['results']['return'][0]
                        return Response({'results': response_data, 'status': True})
                    except Exception as e:
                        return Response({'results': '\n' + 'salt快捷工具命令执行任务状态查询失败_error(1):' + str(response_data), 'status': False})
        except Exception as e:
            print('salt快捷工具命令执行任务状态查询后台出错_error(2)：' + str(e))
            return Response({'results': 'salt快捷工具命令执行任务状态查询后台出错_error(3)：' + str(e), 'status': False})


class SaltToolJobResultViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    任务查询 结果查询操作

    create:
        任务查询 结果查询操作
            salt_tool_tag值为search_jid_result
            jid值为要查询的jid

    """
    serializer_class = serializers.SaltToolJobResultSerializer

    def create(self, request, *args, **kwargs):
        jid = request.data.get('jid')
        try:
            with requests.Session() as s:
                saltapi = SaltAPI(session=s)
                response_data = saltapi.jid_api(jid=jid)

                if response_data['status'] is False:
                    return Response(response_data)
                else:
                    try:
                        response_data = response_data['results']['return'][0]
                        return Response({'results': response_data, 'status': True})
                    except Exception as e:
                        return Response({'results': '\n' + 'salt快捷工具命令执行任务结果查询失败_error(1):' + str(response_data), 'status': False})
        except Exception as e:
            print('salt快捷工具命令执行任务结果查询后台出错_error(2)：' + str(e))
            return Response({'results': 'salt快捷工具命令执行任务结果查询后台出错_error(3)：' + str(e), 'status': False})
