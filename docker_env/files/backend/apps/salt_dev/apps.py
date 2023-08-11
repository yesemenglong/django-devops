from django.apps import AppConfig


class SaltDevConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.salt_dev'

    def ready(self):
        from .signals import create_minion_list, delete_minion_list
