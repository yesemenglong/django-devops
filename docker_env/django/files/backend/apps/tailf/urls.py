from rest_framework.routers import DefaultRouter
from rest_framework.urlpatterns import format_suffix_patterns
from django.urls import re_path
from tailf.views import *

router = DefaultRouter()



urlpatterns = [
    re_path('tailf', TailfView.as_view(), name='tailf-url'),
]

urlpatterns = format_suffix_patterns(urlpatterns)
urlpatterns += router.urls
