# Generated by Django 4.0.5 on 2022-06-27 13:55

from django.db import migrations, models
import django.db.models.deletion
import utils.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='MyMessage',
            fields=[
                ('id', models.CharField(default=utils.models.make_uuid, help_text='Id', max_length=100, primary_key=True, serialize=False, verbose_name='Id')),
                ('description', models.CharField(blank=True, help_text='描述', max_length=100, null=True, verbose_name='描述')),
                ('modifier', models.CharField(blank=True, help_text='修改人', max_length=100, null=True, verbose_name='修改人')),
                ('dept_belong_id', models.CharField(blank=True, help_text='数据归属部门', max_length=100, null=True, verbose_name='数据归属部门')),
                ('update_datetime', models.DateTimeField(auto_now=True, help_text='修改时间', null=True, verbose_name='修改时间')),
                ('create_datetime', models.DateTimeField(auto_now_add=True, help_text='创建时间', null=True, verbose_name='创建时间')),
                ('msg_chanel', models.IntegerField(choices=[(1, '系统通知'), (2, '平台公告')], default=1, verbose_name='消息渠道')),
                ('public', models.BooleanField(default=False, verbose_name='是否公开')),
                ('msg_title', models.CharField(blank=True, max_length=100, null=True, verbose_name='消息标题')),
                ('msg_content', models.TextField(blank=True, null=True, verbose_name='消息内容')),
                ('to_path', models.CharField(blank=True, max_length=256, null=True, verbose_name='跳转路径')),
                ('status', models.BooleanField(default=True, verbose_name='通知状态')),
            ],
            options={
                'verbose_name': '消息中心',
                'verbose_name_plural': '消息中心',
                'db_table': 'tb_message',
            },
        ),
        migrations.CreateModel(
            name='MyMessageTemplate',
            fields=[
                ('id', models.CharField(default=utils.models.make_uuid, help_text='Id', max_length=100, primary_key=True, serialize=False, verbose_name='Id')),
                ('description', models.CharField(blank=True, help_text='描述', max_length=100, null=True, verbose_name='描述')),
                ('modifier', models.CharField(blank=True, help_text='修改人', max_length=100, null=True, verbose_name='修改人')),
                ('dept_belong_id', models.CharField(blank=True, help_text='数据归属部门', max_length=100, null=True, verbose_name='数据归属部门')),
                ('update_datetime', models.DateTimeField(auto_now=True, help_text='修改时间', null=True, verbose_name='修改时间')),
                ('create_datetime', models.DateTimeField(auto_now_add=True, help_text='创建时间', null=True, verbose_name='创建时间')),
                ('code', models.CharField(max_length=100, unique=True, verbose_name='模板code')),
                ('title', models.CharField(max_length=100, verbose_name='消息标题')),
                ('content', models.TextField(verbose_name='消息模板内容')),
            ],
            options={
                'verbose_name': '消息模板',
                'verbose_name_plural': '消息模板',
                'db_table': 'tb_message_template',
            },
        ),
        migrations.CreateModel(
            name='MyMessageUser',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('update_datetime', models.DateTimeField(auto_now=True, null=True, verbose_name='更新时间')),
                ('create_datetime', models.DateTimeField(auto_now_add=True, null=True, verbose_name='创建时间')),
                ('read_at', models.DateTimeField(blank=True, null=True, verbose_name='读取时间')),
                ('is_delete', models.BooleanField(default=False, verbose_name='是否删除')),
                ('is_read', models.BooleanField(default=False, verbose_name='是否已读')),
                ('messageid', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='lymessages.mymessage', verbose_name='消息ID')),
            ],
            options={
                'verbose_name': '用户消息',
                'verbose_name_plural': '用户消息',
                'db_table': 'tb_message_user',
            },
        ),
    ]
