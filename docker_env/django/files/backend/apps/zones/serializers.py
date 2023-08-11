from .models import ZoneList, ZoneMergeList
from rest_framework import serializers


class ZoneListSerializer(serializers.ModelSerializer):
    class Meta:
        model = ZoneList
        fields = "__all__"


class MinionZoneIDSerializer(serializers.ModelSerializer):
    # minion_id = serializers.CharField(max_length=100, help_text='minion_id')
    class Meta:
        model = ZoneList
        fields = (['id'])


class ZoneMergeSerializer(serializers.ModelSerializer):
    # zone = serializers.CharField(help_text='主区')
    # cozone = serializers.CharField(help_text='副区')
    class Meta:
        model = ZoneMergeList
        fields = "__all__"