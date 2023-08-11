from django.db import models


# 系统参数
class SystemConf(models.Model):
    name = models.CharField(max_length=200, verbose_name='参数名称', primary_key=True)
    key = models.CharField(max_length=200, verbose_name='参数键', unique=True)
    value = models.CharField(max_length=200, verbose_name='参数值', blank=True, null=True)
    description = models.TextField(verbose_name='描述', blank=True, null=True)

    class Meta:
        verbose_name = '系统参数表'
        verbose_name_plural = verbose_name
        ordering = ['name']

    def __str__(self):
        return str(self.key)
