import django_filters
from .models import ZoneMergeList, ZoneList


class ZoneMergeFilter(django_filters.rest_framework.FilterSet):
    mzone = django_filters.CharFilter(field_name='mzone', lookup_expr='icontains')
    
    class Meta():
        model = ZoneMergeList
        fields = ['mzone', 'status']


class ZoneListFilter(django_filters.rest_framework.FilterSet):
    m_zone = django_filters.CharFilter(field_name='m_zone', lookup_expr='icontains')
    
    class Meta():
        model = ZoneList
        fields = ['m_zone', 'minion_id']