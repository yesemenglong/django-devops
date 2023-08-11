import django_filters
from .models import MinionList


class MinionListFilter(django_filters.rest_framework.FilterSet):
    minion_id = django_filters.CharFilter(field_name='minion_id', lookup_expr='icontains')
    ip = django_filters.CharFilter(field_name='ip', lookup_expr='icontains')

    class Meta:
        model = MinionList
        fields = ['minion_id', 'ip', 'sys', 'minion_status']
