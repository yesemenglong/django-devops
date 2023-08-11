from rest_framework.routers import DefaultRouter
from rest_framework.urlpatterns import format_suffix_patterns
from apps.dashboard.views import DashboardViewSet

router = DefaultRouter()
router.register(r'dashboard', DashboardViewSet, basename='dashboard')

urlpatterns = [
]

urlpatterns = format_suffix_patterns(urlpatterns)
urlpatterns += router.urls
