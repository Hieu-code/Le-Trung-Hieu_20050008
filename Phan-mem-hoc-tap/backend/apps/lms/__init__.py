# apps/lms/apps.py
from django.apps import AppConfig

class LMSConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "apps.lms"
    label = "lms"
    verbose_name = "Learning Management System"
