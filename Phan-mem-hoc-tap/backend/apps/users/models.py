# apps/users/models.py
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _

ROLE_CHOICES = (
    ("admin", "Admin"),
    ("teacher", "Teacher"),
    ("student", "Student"),
)

class User(AbstractUser):
    # Dùng email làm định danh đăng nhập
    email = models.EmailField(_("email address"), unique=True, db_index=True)
    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default="student")
    avatar = models.URLField(blank=True, null=True)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["username"]

    class Meta:
        ordering = ["-last_login", "-date_joined", "id"]
        verbose_name = "user"
        verbose_name_plural = "users"

    def __str__(self) -> str:
        return f"{self.email} ({self.role})"

    def save(self, *args, **kwargs):
        # Đồng bộ username theo email nếu thiếu (để tương thích auth backend)
        if not self.username and self.email:
            self.username = self.email.split("@")[0]
        super().save(*args, **kwargs)

    # Helpers phù hợp FE kiểm tra role
    @property
    def is_admin(self) -> bool:
        return self.role == "admin"

    @property
    def is_teacher(self) -> bool:
        return self.role == "teacher"

    @property
    def is_student(self) -> bool:
        return self.role == "student"
