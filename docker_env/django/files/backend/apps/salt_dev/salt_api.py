import time
from django.conf import settings


class SaltAPI(object):
    def __init__(self, session, apiurl=settings.SITE_SALT_API_URL, username=settings.SITE_SALT_API_NAME,
                 password=settings.SITE_SALT_API_PWD, eauth='pam'):
        self.url = apiurl
        self.session = session
        self.username = username
        self.password = password
        self.eauth = eauth
        self.results = {'results': '', 'status': False}
        
    def get_token(self):
        count = 2
        connect_test = 1
        while count:
            try:
                token = self.session.post(self.url + '/login',
                                          json={'username': self.username, 'password': self.password,
                                                'eauth': self.eauth, }, timeout=10, verify=False)
                token.raise_for_status()
            except Exception as e:
                response_data = '第%s次尝试链接salt-api获取token失败：' % connect_test
                print(response_data + str(e))
                count -= 1
                connect_test += 1
                time.sleep(4)
                continue
            else:
                return token.json()['return'][0]['token']
        else:
            return False

    def public(self, data, message='public'):
        count = 2
        connect_test = 1
        status_code = 200
        while count:
            try:
                headers = {'X-Auth-Token': settings.SITE_SALT_API_TOKEN}
                response_data = self.session.post(self.url, json=data, headers=headers, verify=False)
                status_code = response_data.status_code
                response_data.raise_for_status()
            except Exception as e:
                response_data = '第%s次尝试SaltApi调用%s请求失败：' % (connect_test, message)
                print(response_data + str(e))
                if status_code == 401:
                    token = self.get_token()
                    if token:
                        settings.SITE_SALT_API_TOKEN = token
                    else:
                        return False
                count -= 1
                connect_test += 1
                time.sleep(4)
                continue
            else:
                return response_data.json()
        else:
            return False

    def test_api(self, client='local', tgt='*', tgt_type='glob', fun='test.ping', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'test_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        elif response_data['return'] != [{}]:
            data_source = response_data['return'][0]
            return {'results': data_source, 'status': True}
        else:
            return {'results': '检测失败，请确认minion是否存在', 'status': False}

    def cmd_run_api(self, client='local', tgt='*', tgt_type='glo', fun='cmd.run', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'cmd_run_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def async_cmd_run_api(self, client='local_async', tgt='*', tgt_type='glob', fun='cmd.run', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'async_cmd_run_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltutil_refresh_pillar_api(self, client='local', tgt='*', tgt_type='glob',
                                    fun='saltutil.refresh_pillar', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'saltutil_refresh_pillar_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def state_api(self, client='local', tgt='*', tgt_type='glob', fun='state.sls', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'state_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def async_state_api(self, client='local_async', tgt='*', tgt_type='glob', fun='state.sls', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'async_state_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def job_active_api(self, client='local', tgt='*', tgt_type='glob', fun='saltutil.find_job', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'job_active_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def job_exit_success_api(self, client='runner', fun='job.exit_success', jid=None):
        jid = [] if jid is None else jid
        data = {
            'client': client,
            'fun': fun,
            'jid': jid,
        }
        message = 'job_exit_success_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def jid_api(self, client='runner', fun='jobs.lookup_jid', jid=None):
        jid = [] if jid is None else jid
        data = {
            'client': client,
            'fun': fun,
            'jid': jid,
        }
        message = 'jid_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def archive_zip_api(self, client='local', tgt='*', tgt_type='glob', fun='archive.zip', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'archive_zip_api'
        return self.public(data, message)

    def archive_tar_api(self, client='local', tgt='*', tgt_type='glob', fun='archive.tar', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'archive_zip_api'
        return self.public(data, message)

    def cp_get_file_api(self, client='local', tgt='*', tgt_type='glob', fun='cp.get_file', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'cp_get_file_api'
        return self.public(data, message)

    def cp_get_dir_api(self, client='local', tgt='*', tgt_type='glob', fun='cp.get_dir', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg,
        }
        message = 'cp_get_dir_api'
        return self.public(data, message)

    def saltkey_listall_api(self, client='wheel', fun='key.list_all'):
        data = {
            'client': client,
            'fun': fun,
        }
        message = 'saltkey_listall_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltkey_delete_api(self, client='wheel', fun='key.delete', match=None):
        match = [] if match is None else match
        data = {
            'client': client,
            'fun': fun,
            'match': match
        }
        message = 'saltkey_delete_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltkey_accept_api(self, client='wheel', fun='key.accept', match=None, include_rejected=False, include_denied=False):
        match = [] if match is None else match
        data = {
            'client': client,
            'fun': fun,
            'include_rejected': include_rejected,
            'match': match,
            'include_denied': include_denied
        }
        message = 'saltkey_accept_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltkey_reject_api(self, client='wheel', fun='key.reject', match=None, include_accepted=False, include_denied=False):
        match = [] if match is None else match
        data = {
            'client': client,
            'fun': fun,
            'include_rejected': include_accepted,
            'match': match,
            'include_denied': include_denied
        }
        message = 'saltkey_reject_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltrun_manage_status_api(self, client='runner', fun='manage.status', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'fun': fun,
            'arg': arg
        }
        message = 'saltrun_manage_status_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltrun_manage_alive_api(self, client='runner', fun='manage.alived', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'fun': fun,
            'arg': arg
        }
        message = 'saltrun_manage_alive_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltrun_manage_notalive_api(self, client='runner', fun='manage.not_alive', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'fun': fun,
            'arg': arg
        }
        message = 'saltrun_manage_notalive_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def grains_items_api(self, client='local', tgt='*', tgt_type='glob', fun='grains.items', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'grains_items_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def service_available_api(self, client='local', tgt='*', tgt_type='glob', fun='service.available', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'service_available_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def service_status_api(self, client='local', tgt='*', tgt_type='glob', fun='service.status', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'service_status_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def service_start_api(self, client='local', tgt='*', tgt_type='glob', fun='service.start', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'service_start_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def service_stop_api(self, client='local', tgt='*', tgt_type='glob', fun='service.stop', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'service_stop_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def ps_pgrep_api(self, client='local', tgt='*', tgt_type='glob', fun='ps.pgrep', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'ps_pgrep_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def ps_proc_info_api(self, client='local', tgt='*', tgt_type='glob', fun='ps.proc_info', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'ps_proc_info_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def ps_kill_pid_api(self, client='local', tgt='*', tgt_type='glob', fun='ps.kill_pid', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'ps_kill_pid_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def task_create_api(self, client='local', tgt='*', tgt_type='glob', fun='task.create_task', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'task_create_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def task_run_api(self, client='local', tgt='*', tgt_type='glob', fun='task.run', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'task_run_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def task_stop_api(self, client='local', tgt='*', tgt_type='glob', fun='task.stop', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'task_stop_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_mkdir_api(self, client='local', tgt='*', tgt_type='glob', fun='file.mkdir', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_mkdir_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_makedirs_api(self, client='local', tgt='*', tgt_type='glob', fun='file.makedirs', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_makedirs_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_rename_api(self, client='local', tgt='*', tgt_type='glob', fun='file.rename', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_rename_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_exists_api(self, client='local', tgt='*', tgt_type='glob', fun='file.file_exists', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_exists_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_write_api(self, client='local', tgt='*', tgt_type='glob', fun='file.write', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_write_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_remove_api(self, client='local', tgt='*', tgt_type='glob', fun='file.remove', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_remove_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_directory_exists_api(self, client='local', tgt='*', tgt_type='glob', fun='file.directory_exists', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_directory_exists_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_symlink_api(self, client='local', tgt='*', tgt_type='glob', fun='file.symlink', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_symlink_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_diskusage_api(self, client='local', tgt='*', tgt_type='glob', fun='file.diskusage', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_diskusage_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def file_read_api(self, client='local', tgt='*', tgt_type='glob', fun='file.read', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'file_read_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def supervisord_status_api(self, client='local', tgt='*', tgt_type='glob', fun='supervisord.status', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'supervisord_status_api'
        return self.public(data, message)

    def supervisord_stop_api(self, client='local', tgt='*', tgt_type='glob', fun='supervisord.stop', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'supervisord_stop_api'
        return self.public(data, message)

    def supervisord_start_api(self, client='local', tgt='*', tgt_type='glob', fun='supervisord.start', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'supervisord_start_api'
        return self.public(data, message)

    def supervisord_update_api(self, client='local', tgt='*', tgt_type='glob', fun='supervisord.update', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'supervisord_update_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def rsync_rsync_api(self, client='local', tgt='*', tgt_type='glob', fun='rsync.rsync', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'rsync_rsync_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def async_rsync_rsync_api(self, client='local_async', tgt='*', tgt_type='glob', fun='rsync.rsync', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'async_rsync_rsync_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def sys_doc_api(self, client='local', tgt='*', tgt_type='glob', fun='sys.doc', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'sys_doc_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def sys_runner_doc_api(self, client='local', tgt='*', tgt_type='glob', fun='sys.runner_doc', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'sys_runner_doc_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def sys_state_doc_api(self, client='local', tgt='*', tgt_type='glob', fun='sys.state_doc', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'sys_state_doc_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def git_clone_api(self, client='local', tgt='*', tgt_type='glob', fun='git.clone', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'git_clone_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def git_pull_api(self, client='local', tgt='*', tgt_type='glob', fun='git.pull', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'git_pull_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def git_reset_api(self, client='local', tgt='*', tgt_type='glob', fun='git.reset', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'git_reset_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def saltrun_file_roots_api(self, client='runner', fun='config.get', arg='file_roots:base'):
        data = {
            'client': client,
            'fun': fun,
            'arg': arg
        }
        message = 'saltrun_file_roots_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}

    def find_find_api(self, client='local', tgt='*', tgt_type='glob', fun='file.find', arg=None):
        arg = [] if arg is None else arg
        data = {
            'client': client,
            'tgt': tgt,
            'tgt_type': tgt_type,
            'fun': fun,
            'arg': arg
        }
        message = 'find_find_api'
        response_data = self.public(data, message)
        if response_data is False:
            return {'results': 'SaltApi调用%s请求出错，请检查salt-api接口是否正常' % message, 'status': False}
        else:
            return {'results': response_data, 'status': True}