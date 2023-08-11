from rest_framework import serializers
from .models import SaltKeyList, MinionList, SaltCmdInfo


class SaltKeySerializer(serializers.ModelSerializer):
    class Meta:
        model = SaltKeyList
        fields = "__all__"


class SaltKeyFlushSerializer(serializers.Serializer):
    salt_key_tag = serializers.CharField(max_length=100, help_text='执行操作字段')

    def validate_salt_key_tag(self, value):
        if value != 'global_flush_salt_key':
            raise serializers.ValidationError('未知的参数')
        return value


class SaltKeyAcceptSerializer(serializers.Serializer):
    salt_key_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    minion_id = serializers.ListField(required=False, help_text='增删改需传递minion_id列表')

    def validate_salt_key_tag(self, value):
        if value != 'accept_salt_key':
            raise serializers.ValidationError('未知的参数')
        return value


class SaltKeyDeleteSerializer(serializers.Serializer):
    salt_key_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    minion_id = serializers.ListField(required=False, help_text='增删改需传递minion_id列表')

    def validate_salt_key_tag(self, value):
        if value != 'delete_salt_key':
            raise serializers.ValidationError('未知的参数')
        return value


class SaltKeyRejectSerializer(serializers.Serializer):
    salt_key_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    minion_id = serializers.ListField(required=False, help_text='增删改需传递minion_id列表')

    def validate_salt_key_tag(self, value):
        if value != 'reject_salt_key':
            raise serializers.ValidationError('未知的参数')
        return value


# SaltKey 删除denied操作序列化类
class SaltKeyDeleteDeniedSerializer(serializers.Serializer):
    salt_key_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    minion_id = serializers.ListField(required=False, help_text='增删改时需传递minion_id列表')

    def validate_salt_key_tag(self, value):
        if value != 'delete_denied_salt_key':
            raise serializers.ValidationError("未知的参数")
        return value


# Minion List操作序列化类
class SaltMinionSerializer(serializers.ModelSerializer):
    class Meta:
        # 设置继承的数据库
        model = MinionList
        # 设置显示的字段
        fields = "__all__"


# Minion 更新minion列表操作序列化类
class SaltMinionListUpdateSerializer(serializers.Serializer):
    salt_minion_tag = serializers.CharField(max_length=100, help_text='执行操作字段')

    def validate_salt_minion_tag(self, value):
        if value != 'global_update_salt_minion_list':
            raise serializers.ValidationError("未知的参数")
        return value


# Minion 更新minion状态操作序列化类
class SaltMinionStateUpdateSerializer(serializers.Serializer):
    salt_minion_tag = serializers.CharField(max_length=100, help_text='执行操作字段')

    def validate_salt_minion_tag(self, value):
        if value != 'global_update_salt_minion_status':
            raise serializers.ValidationError("未知的参数")
        return value


# Minion 更新单个minion操作序列化类
class SaltMinionUpdateSerializer(serializers.Serializer):
    salt_minion_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    minion_id = serializers.CharField(required=False, help_text='单个更新需传递minion_id')

    def validate_salt_minion_tag(self, value):
        if value != 'update_salt_minion':
            raise serializers.ValidationError("未知的参数")
        return value


class SaltCmdSerializer(serializers.ModelSerializer):
    class Meta:
        model = SaltCmdInfo
        fields = "__all__"


class SaltCmdPostSerializer(serializers.Serializer):
    salt_cmd_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    collection_style = serializers.CharField(required=False, help_text='需要收集的命令类型')
    minions = serializers.CharField(required=False, help_text='来源现在，可以是逗号隔开的多个minion_id字符串')

    def validate_salt_cmd_tag(self, value):
        if value != 'collection_info':
            raise serializers.ValidationError("未知的参数")
        return value


class SaltCmdDeleteSerializer(serializers.Serializer):
    salt_cmd_tag = serializers.CharField(max_length=100, help_text='执行操作字段')

    def validate_salt_cmd_tag(self, value):
        if value != 'salt_cmd_delete':
            raise serializers.ValidationError("未知的参数")
        return value


class SaltCmdModuleListSerializer(serializers.ModelSerializer):
    class Meta:
        model = SaltCmdInfo
        fields = ('salt_cmd_module', )


class SaltCmdCmdListSerializer(serializers.ModelSerializer):
    class Meta:
        model = SaltCmdInfo
        fields = ('salt_cmd',)


class SaltExeSerializer(serializers.Serializer):
    salt_exe_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    client = serializers.CharField(max_length=100, help_text='执行操作字段')
    tgt = serializers.CharField(required=False, help_text='执行操作字段')
    tgt_type = serializers.CharField(required=False, help_text='执行操作字段')
    fun = serializers.CharField(help_text='执行操作字段')
    arg = serializers.CharField(required=False, help_text='执行操作字段')

    def validate_salt_cmd_tag(self, value):
        if value != 'salt_exe':
            raise serializers.ValidationError("未知的参数")
        return value


class SaltToolJobStatusSerializer(serializers.Serializer):
    salt_tool_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    jid = serializers.CharField(max_length=100, help_text='jid')

    def validate_salt_cmd_tag(self, value):
        if value != 'search_jid_status':
            raise serializers.ValidationError("未知的参数")
        return value


class SaltToolJobResultSerializer(serializers.Serializer):
    salt_tool_tag = serializers.CharField(max_length=100, help_text='执行操作字段')
    jid = serializers.CharField(max_length=100, help_text='jid')

    def validate_salt_cmd_tag(self, value):
        if value != 'search_jid_result':
            raise serializers.ValidationError("未知的参数")
        return value


class SaltCreateTestSerializer(serializers.Serializer):
    zone_id = serializers.CharField(max_length=100, help_text='执行的区服id')

    def validate_salt_cmd_tag(self, value):
        if value != 'create_test':
            raise serializers.ValidationError("未知的参数")
        return value
