from rest_framework.routers import DefaultRouter
from rest_framework.urlpatterns import format_suffix_patterns
from django.urls import re_path
from zones.views import *

router = DefaultRouter()
router.register(r'zonelist', ZoneListViewSet, basename='zones_list')
# router.register(r'zonelist_minion_id', ZoneListMinionViewSet, basename='zones_list_minion_id')
router.register(r'zonelist_batchCreate', ZoneListBatchCreateViewSet, basename='batchCreate')
router.register(r'minion_id_list', ZoneMinionIDViewSet, basename='minion_id_list')
router.register(r'zone_list_status', ZoneListStatusViewSet, basename='zone_list_status')
# router.register(r'zone_merge_status', ZoneListMergeStatusViewSet, basename='zone_merge_status')
router.register(r'deploy_zone', BeployZoneViewSet, basename='deploy_zone')
router.register(r'batch_deploy_zones', BatchBeployViewSet, basename='batch_deploy_zones')
router.register(r'zone_merge', ZoneMergeViewSet, basename='zone_merge')
router.register(r'zone_merge_exe', ZoneMergeExeViewSet, basename='zone_merge_exe')
router.register(r'batch_zone_merge', BatchZoneMergeViewSet, basename='batch_zone_merge')
router.register(r'version', VersionViewSet, basename='version')
router.register(r'zone_move', ZoneMoveListViewSet, basename='zone_move')


urlpatterns = [
    re_path(r'zones_list_export/', ZoneListExportViewSet.as_view(), name='zones_list_export')
    
]

urlpatterns = format_suffix_patterns(urlpatterns)
urlpatterns += router.urls
