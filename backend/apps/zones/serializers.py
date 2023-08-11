from .models import ZoneList, ZoneMergeList, Version, ZoneMove
from rest_framework import serializers


class ZoneListSerializer(serializers.ModelSerializer):
    class Meta:
        model = ZoneList
        fields = "__all__"


class MinionZoneIDSerializer(serializers.ModelSerializer):
    class Meta:
        model = ZoneList
        fields = (['id'])


class ZoneMergeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ZoneMergeList
        fields = "__all__"
        

class VersionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Version
        fields = "__all__"
        

class ZoneMoveSerializer(serializers.ModelSerializer):
    class Meta:
        model = ZoneMove
        fields = "__all__"      