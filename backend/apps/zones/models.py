from django.db import models
from apps.salt_dev.models import MinionList


class ZoneList(models.Model):
    zone_id = models.IntegerField(verbose_name='ZoneID', primary_key=True)
    name = models.CharField(max_length=120, verbose_name='Name')
    ip = models.CharField(max_length=120, verbose_name='IP', blank=True)
    minion_id = models.ForeignKey(MinionList, on_delete=models.DO_NOTHING)
    id = models.CharField(max_length=120, verbose_name='ID')
    db = models.CharField(max_length=120, verbose_name='DB_IP', blank=True)
    create_date = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name='最近一次更新时间')
    status = models.IntegerField(default=0, verbose_name='状态')
    m_zone = models.IntegerField(default=0, verbose_name='主区')
    
    class Meta:
        verbose_name = 'Zone列表'
        verbose_name_plural = verbose_name
        ordering = ['zone_id']

    def __str__(self):
        return str(self.zone_id)


class ZoneMergeList(models.Model):
    id = models.AutoField(primary_key=True)
    mzone = models.IntegerField(verbose_name='主区')
    cozone = models.CharField(max_length=120, blank=True, verbose_name='副区')
    status = models.IntegerField(default=0, verbose_name='状态')
    create_date = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    