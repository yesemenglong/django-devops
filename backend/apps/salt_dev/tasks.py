import datetime
import time
import requests
import urllib3
from celery import shared_task, uuid, result
from .models import SaltKeyList, MinionList
from .salt_api import SaltAPI

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


# @shared_task(bind=True, name='saltkey状态检测入库')
def saltkey_list():
    salt_list = SaltKeyList.objects.values_list('minion_id', 'certification_status')
    minion_list = []
    with requests.Session() as s:
        slatapi = SaltAPI(session=s)
        response_data = slatapi.saltkey_listall_api()
        if not response_data['status']:
            print('saltkey_list调用api失败，请检查api接口状态')
            return False
        try:
            data_source = response_data['results']['return'][0]['data']['return']
            minions_pre = data_source['minions_pre']
            minions_denied = data_source['minions_denied']
            minions = data_source['minions']
            minions_rejected = data_source['minions_rejected']
            if minions_pre:
                for i in minions_pre:
                    minion_list.append((i, 'unaccepted'))
                    updated_values = {'minion_id': i, 'certification_status': 'unaccepted', 'update_time': datetime.datetime.now()}
                    SaltKeyList.objects.update_or_create(minion_id=i, certification_status='unaccepted', defaults=updated_values)
            if minions_denied:
                for i in minions_denied:
                    minion_list.append((i, 'denied'))
                    updated_values = {'minion_id': i, 'certification_status': 'denied', 'update_time': datetime.datetime.now()}
                    SaltKeyList.objects.update_or_create(minion_id=i, certification_status='denied', defaults=updated_values)
            if minions:
                for i in minions:
                    minion_list.append((i, 'accepted'))
                    updated_values = {'minion_id': i, 'certification_status': 'accepted', 'update_time': datetime.datetime.now()}
                    SaltKeyList.objects.update_or_create(minion_id=i, certification_status='accepted', defaults=updated_values)
            if minions_rejected:
                for i in minions_rejected:
                    minion_list.append((i, 'rejected'))
                    updated_values = {'minion_id': i, 'certification_status': 'rejected', 'update_time': datetime.datetime.now()}
                    SaltKeyList.objects.update_or_create(minion_id=i, certification_status='rejected', defaults=updated_values)

            for i in salt_list:
                if i not in minion_list:
                    SaltKeyList.objects.filter(minion_id=i[0], certification_status=i[1]).delete()
            print("saltkey_list")
            return True
        except Exception as e:
            print('saltkey_list在执行数据库操作时候出错了：' + str(e))
            return False


# @shared_task(bind=True, name='minion状态检测入库')
def minion_list():
    minion_list = MinionList.objects.values_list('minion_id', flat=True)
    id_list = []
    print('开始更新Minion列表' + time.strftime('%Y-%m-%d %X'))
    with requests.Session() as s:
        saltapi = SaltAPI(session=s)
        minion_data = saltapi.saltrun_manage_status_api()
        if minion_data['status'] is False:
            print(minion_data['results'])
            return False
        try:
            id_list.extend(minion_data['results']['return'][0]['up'])
            grains_data = saltapi.grains_items_api(tgt=id_list, tgt_type='list')
            for key, value in grains_data['results']['return'][0].items():
                minion_id = key
                try:
                    value['ipv4'].remove('127.0.0.1')
                except Exception as e:
                    pass
                try:
                    ip = value.get('network')[0]
                    os = value.get('os') + value.get('osrelease')
                    saltversion = value.get('saltversion')
                    sn = value.get('serialnumber')
                    cpu_num = value.get('num_cpus')
                    cpu_model = value.get('cpu_model')
                    sys = value.get('kernel')
                    kernel = value.get('kernelrelease')
                    productname = value.get('productname')
                    ipv4_addr = value.get('ip4_interfaces')
                    mac_addr = value.get('hwaddr_interfaces')
                    localhost = value.get('localhost')
                    mem_total = value.get('mem_total')
                    do_main = value.get('network')[1]
                except Exception as e:
                    updated_values = {'minion_id': key, 'minion_status': '异常',
                                      'update_time': datetime.datetime.now()}
                    MinionList.objects.update_or_create(minion_id=key, defaults=updated_values)
                else:
                    updated_values = {'minion_id': minion_id, 'minion_status': '在线', 'ip': ip, 'sn': sn,
                                      'cpu_num': cpu_num, 'cpu_model': cpu_model, 'sys': sys, 'kernel': kernel,
                                      'product_name': productname, 'ipv4_address': ipv4_addr,
                                      'mac_address': mac_addr, 'localhost': localhost,
                                      'mem_total': mem_total, 'minion_version': saltversion, 'system_issue': os,
                                      'do_main': do_main,
                                      'update_time': datetime.datetime.now()}
                    MinionList.objects.update_or_create(minion_id=key, defaults=updated_values)

        except Exception as e:
            print('minion列表更新在线数据出错1，请检查'+time.strftime('%Y-%m-%d %X'), e)
            return False
        try:
            for key in minion_data['results']['return'][0]['down']:
                id_list.append(key)
                updated_values = {'minion_id': key, 'minion_status': '离线', 'update_time': datetime.datetime.now()}
                MinionList.objects.update_or_create(minion_id=key, defaults=updated_values)
        except Exception as e:
            print('minion列表更新离线数据出错2，请检查' + time.strftime('%Y-%m-%d %X'), e)
            return False
        try:
            for i in minion_list:
                if i not in id_list:
                    MinionList.objects.filter(minion_id=i).delete()
            print('minion列表更新完成' + time.strftime('%Y-%m-%d %X'))
            return True
        except Exception as e:
            print('minion列表更新出错，请检查' + time.strftime('%Y-%m-%d %X'), e)
            return False


def minion_list_test():
    minion_list = MinionList.objects.values_list('minion_id', falt=True)
    id_list = []
    print('开始更新Minion列表' + time.strftime('%Y-%m-%d %X'))
    with requests.Session() as s:
        saltapi = SaltAPI(session=s)
        minion_data = saltapi.saltrun_manage_status_api()
        if minion_data['status'] is False:
            print(minion_data['results'])
            return False
        try:
            # 获取在线状态的 minion 的 ID 列表
            id_list.extend(minion_data['results']['return'][0]['up'])
            # 使用 saltapi 获取 minion 的信息
            grains_data = saltapi.grains_items_api(tgt=id_list, tgt_type='list')

            # 遍历获取到的 minion 信息
            for key, value in grains_data['results']['return'][0].items():
                try:
                    # 移除 127.0.0.1
                    value['ipv4'].remove('127.0.0.1')
                except Exception:
                    pass
                try:
                    updated_values = {
                        'minion_id': key,
                        'ip': value.get('ipv4'),
                        'sn': value.get('serialnumber'),
                        'cpu_num': value.get('num_cpus'),
                        'cpu_model': value.get('cpu_model'),
                        'sys': value.get('kernel'),
                        'kernel': value.get('kernelrelease'),
                        'product_name': value.get('productname'),
                        'ipv4_address': value.get('ip4_interfaces'),
                        'mac_address': value.get('hwaddr_interfaces'),
                        'localhost': value.get('localhost'),
                        'mem_total': value.get('mem_total'),
                        'minion_value': value.get('saltversion'),
                        'system_issue': value.get('os') + value.get('osrelease'),
                        'update_time': datetime.datetime.now(),
                    }
                except Exception as e:
                    updated_values.update({'minion_status': '异常'})
                    MinionList.objects.update_or_create(minion_id=key, defaults=updated_values)
                else:
                    updated_values.update({'minion_status': '在线'})
                    MinionList.objects.update_or_create(minion_id=key, defaults=updated_values)
        except Exception as e:
            # 打印错误信息并返回 False
            print('minion列表更新在线数据出错1，请检查' + time.strftime('%Y-%m-%d %X'), e)
            return False

        try:
            for i in minion_list:
                if i not in id_list:
                    MinionList.objects.filter(minion_id=i).delete()
            print('minion列表更新完成' + time.strftime('%Y-%m-%d %X'))
            return True
        except Exception as e:
            print('minion列表更新出错，请检查' + time.strftime('%Y-%m-%d %X'), e)
            return False


# @shared_task(name='执行sls文件')
def salt_sls(data):
    with requests.Session() as s:
        slatapi = SaltAPI(session=s)
        response_data = slatapi.public(data=data)
        if response_data is False:
            return False
        else:
            try:
                return response_data
            except Exception as e:
                return False
