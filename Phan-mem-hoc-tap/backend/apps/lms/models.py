# backend/apps/lms/models.py
from __future__ import annotations
from django.conf import settings
from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
from django.apps import apps
from django.utils import timezone
import string
import random

def generate_course_code(length: int = 6) -> str:
    alphabet = string.ascii_uppercase + string.digits
    try:
        Course = apps.get_model("lms", "Course")
    except LookupError:
        return "XXXXXX"

    while True:
        code = "".join(random.choices(alphabet, k=length))
        if not Course.objects.filter(code=code).exists():
            return code

# --- Course & Content ---
class Course(models.Model):
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="owned_courses")
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, default="")
    code = models.CharField(max_length=16, unique=True, blank=True, default="")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    meeting_link = models.URLField(max_length=500, blank=True, default="", help_text="Link Zoom/Google Meet")
    def save(self, *args, **kwargs):
        if not self.code:
            self.code = generate_course_code()
        super().save(*args, **kwargs)
    
    def __str__(self):
        return self.title

class Enrollment(models.Model):
    ROLE_TEACHER = "teacher"
    ROLE_STUDENT = "student"
    ROLE_CHOICES = ((ROLE_TEACHER, "Teacher"), (ROLE_STUDENT, "Student"))

    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="enrollments")
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="enrollments")
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default=ROLE_STUDENT)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ("course", "user")

class Section(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="sections")
    title = models.CharField(max_length=255)
    order = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["order", "created_at"]

class Lesson(models.Model):
    section = models.ForeignKey(Section, on_delete=models.CASCADE, related_name="lessons")
    title = models.CharField(max_length=255)
    content = models.TextField(blank=True, default="")
    order = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["order", "created_at"]

class Material(models.Model):
    lesson = models.ForeignKey(Lesson, on_delete=models.CASCADE, related_name="materials")
    file = models.FileField(upload_to="materials/%Y/%m/", blank=True, null=True)
    url = models.URLField(blank=True, default="")
    type = models.CharField(max_length=50, default="file")
    created_at = models.DateTimeField(auto_now_add=True)

# --- Assignments ---
class Assignment(models.Model):
    course = models.ForeignKey("Course", on_delete=models.CASCADE, related_name="assignments")
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    due_at = models.DateTimeField(null=True, blank=True)
    max_score = models.FloatField(default=10)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title
class Submission(models.Model):
    STATUS_CHOICES = (
        ("DRAFT", "Lưu nháp"),
        ("SUBMITTED", "Đã nộp"),
        ("LATE", "Nộp muộn"),
        ("GRADED", "Đã chấm"),
        ("RETURNED", "Đã trả bài"),
    )

    assignment = models.ForeignKey(Assignment, on_delete=models.CASCADE, related_name="submissions")
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    
    file = models.FileField(upload_to="submissions/", blank=True, null=True)
    answer_text = models.TextField(blank=True, default="")
    
    score = models.FloatField(null=True, blank=True)
    feedback = models.TextField(blank=True, default="")
    
    # Fields Mới thêm
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="DRAFT")
    submitted_at = models.DateTimeField(null=True, blank=True) # Thời điểm nộp bài thực tế
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ("assignment", "owner")
# --- Quizzes ---
class Quiz(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="quizzes")
    
    # --- THÊM DÒNG NÀY ---
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    # ---------------------

    title = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    is_published = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title
class Question(models.Model):
    TYPE_SINGLE = "single"
    TYPE_MULTI = "multi"
    TYPE_TEXT = "text"
    TYPE_CHOICES = ((TYPE_SINGLE, "Single Choice"), (TYPE_MULTI, "Multiple Choice"), (TYPE_TEXT, "Text"))

    quiz = models.ForeignKey(Quiz, on_delete=models.CASCADE, related_name="questions")
    text = models.TextField()
    type = models.CharField(max_length=10, choices=TYPE_CHOICES, default=TYPE_SINGLE)
    points = models.IntegerField(default=1)
    order = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name="choices")
    text = models.CharField(max_length=255)
    is_correct = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

# --- Communication ---
class Announcement(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="announcements")
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    title = models.CharField(max_length=255, blank=True, default="")
    body = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

class Comment(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="comments")
    announcement = models.ForeignKey(Announcement, on_delete=models.CASCADE, related_name="comments", null=True, blank=True)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Notification(models.Model):
    recipient = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="notifications")
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="notifications", null=True, blank=True)
    title = models.CharField(max_length=255)
    body = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ["-created_at"]

# --- Misc ---
class Schedule(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="schedules")
    title = models.CharField(max_length=255)
    starts_at = models.DateTimeField()
    ends_at = models.DateTimeField()
    type = models.CharField(max_length=50, default="lesson")
    created_at = models.DateTimeField(auto_now_add=True)

class Progress(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="progresses")
    # Đã thêm validators vào đây để sửa lỗi Pylance
    percent = models.PositiveIntegerField(
        default=0, 
        validators=[MinValueValidator(0), MaxValueValidator(100)]
    )
    last_activity_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        unique_together = ("user", "course")

class DiscussionThread(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    title = models.CharField(max_length=255)
    updated_at = models.DateTimeField(auto_now=True)

class DiscussionPost(models.Model):
    thread = models.ForeignKey(DiscussionThread, on_delete=models.CASCADE)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
# --- THÊM VÀO CUỐI FILE models.py ---

class QuizSubmission(models.Model):
    quiz = models.ForeignKey(Quiz, on_delete=models.CASCADE, related_name="submissions")
    student = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="quiz_submissions")
    score = models.FloatField(default=0)
    correct_count = models.IntegerField(default=0)
    total_questions = models.IntegerField(default=0)
    submitted_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        # Ràng buộc: Mỗi học sinh chỉ được nộp 1 bài Quiz (chặn làm lại)
        unique_together = ("quiz", "student")
        ordering = ["-score"]
# --- QUẢN LÝ ĐIỂM DANH ---
class AttendanceSession(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="attendance_sessions")
    date = models.DateField(default=timezone.now)
    title = models.CharField(max_length=255, default="Buổi học")
    created_at = models.DateTimeField(auto_now_add=True)

class AttendanceRecord(models.Model):
    STATUS_CHOICES = (
        ('present', 'Có mặt'),
        ('absent', 'Vắng'),
        ('late', 'Muộn'),
    )
    session = models.ForeignKey(AttendanceSession, on_delete=models.CASCADE, related_name="records")
    student = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='absent')
    note = models.CharField(max_length=255, blank=True)

    class Meta:
        unique_together = ('session', 'student')

