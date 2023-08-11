from rest_framework.routers import DefaultRouter
from rest_framework.urlpatterns import format_suffix_patterns

from apps.salt_dev.views import *

router = DefaultRouter()
router.register(r'saltstack/salt-key', SaltKeyViewSet, basename='salt-key')
router.register(r'saltstack/salt-key-opt/accept', SaltKeyAcceptViewSet, basename='salt-key-accept')
router.register(r'saltstack/salt-key-opt/delete', SaltKeyDeleteViewSet, basename='salt-key-delete')
router.register(r'saltstack/salt-key-opt/reject', SaltKeyRejectViewSet, basename='salt-key-reject')
router.register(r'saltstack/salt-key-opt/del-denied', SaltKeyDeleteDeniedViewSet, basename='salt-key-del-denied')
router.register(r'saltstack/salt-minion', SaltMinionViewSet, basename='salt-minion')
router.register(r'saltstack/salt-minion-opt/status-update', SaltMinionStateUpdateViewSet,
                basename='salt-minion-status-update')
router.register(r'saltstack/salt-minion-opt/update', SaltMinionUpdateViewSet, basename='salt-minion-update')
router.register(r'saltstack/salt-cmd', SaltCmdViewSet, basename='salt-cmd')
router.register(r'saltstack/salt-cmd-opt/delete', SaltCmdDeleteViewSet, basename='salt-cmd-delete')
router.register(r'saltstack/salt-cmd-opt/get-module', SaltCmdModuleListViewSet, basename='salt-cmd-get-module')
router.register(r'saltstack/salt-cmd-opt/get-cmd', SaltCmdCmdleListViewSet, basename='salt-cmd-get-cmd')
router.register(r'saltstack/salt-exe', SaltExeViewSet, basename='salt-exe')
router.register(r'saltstack/salt-tool/job-search/status', SaltToolJobStatusViewSet,
                basename='salt-tool-job-search-status')
router.register(r'saltstack/salt-tool/job-search/result', SaltToolJobResultViewSet,
                basename='salt-tool-job-search-result')

urlpatterns = [
]

urlpatterns = format_suffix_patterns(urlpatterns)
urlpatterns += router.urls
