# apps/lms/apps.py
from django.apps import AppConfig

class LmsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "apps.lms"
    verbose_name = "LMS"

    def ready(self):
        # chỗ này bạn có thể gắn signal nếu cần
        pass
