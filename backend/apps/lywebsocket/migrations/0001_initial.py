# Generated by Django 4.0.5 on 2022-07-17 17:05

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import utils.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='TerminalServer',
            fields=[
                ('id', models.CharField(default=utils.models.make_uuid, help_text='Id', max_length=100, primary_key=True, serialize=False, verbose_name='Id')),
                ('description', models.CharField(blank=True, help_text='描述', max_length=100, null=True, verbose_name='描述')),
                ('modifier', models.CharField(blank=True, help_text='修改人', max_length=100, null=True, verbose_name='修改人')),
                ('dept_belong_id', models.CharField(blank=True, help_text='数据归属部门', max_length=100, null=True, verbose_name='数据归属部门')),
                ('update_datetime', models.DateTimeField(auto_now=True, help_text='修改时间', null=True, verbose_name='修改时间')),
                ('create_datetime', models.DateTimeField(auto_now_add=True, help_text='创建时间', null=True, verbose_name='创建时间')),
                ('host', models.CharField(max_length=100, verbose_name='服务器IP/域名')),
                ('remark', models.CharField(blank=True, max_length=100, null=True, verbose_name='备注')),
                ('username', models.CharField(max_length=200, verbose_name='用户名')),
                ('password', models.CharField(blank=True, max_length=200, null=True, verbose_name='密码')),
                ('pkey', models.CharField(blank=True, max_length=255, null=True, verbose_name='私钥')),
                ('pkey_passwd', models.CharField(blank=True, max_length=255, null=True, verbose_name='私钥密码')),
                ('type', models.SmallIntegerField(choices=[(0, '密码验证'), (1, '私钥验证')], default=0, help_text='验证方式', verbose_name='验证方式')),
                ('creator', models.ForeignKey(db_constraint=False, help_text='创建人', null=True, on_delete=django.db.models.deletion.SET_NULL, related_query_name='creator_query', to=settings.AUTH_USER_MODEL, verbose_name='创建人')),
            ],
            options={
                'verbose_name': '终端服务器列表',
                'verbose_name_plural': '终端服务器列表',
                'db_table': 'tb_terminalserver',
            },
        ),
    ]