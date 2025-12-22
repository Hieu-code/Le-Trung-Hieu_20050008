# backend/apps/lms/admin.py
from django.contrib import admin
from .models import (
    Course, Enrollment, Section, Lesson, Material,
    Assignment, Submission,
    Quiz, Question, Choice,
    Announcement, Comment, Notification,
    Schedule, Progress,
    DiscussionThread, DiscussionPost
)

@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ("id", "title", "code", "owner", "created_at")
    search_fields = ("title", "code", "owner__email")

@admin.register(Enrollment)
class EnrollmentAdmin(admin.ModelAdmin):
    list_display = ("id", "course", "user", "role")
    list_filter = ("role",)

@admin.register(Assignment)
class AssignmentAdmin(admin.ModelAdmin):
    list_display = ("title", "course", "due_at", "max_score")

@admin.register(Submission)
class SubmissionAdmin(admin.ModelAdmin):
    list_display = ("assignment", "owner", "score", "updated_at")

@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ("recipient", "title", "is_read", "created_at")
    list_filter = ("is_read",)

admin.site.register(Section)
admin.site.register(Lesson)
admin.site.register(Material)
admin.site.register(Quiz)
admin.site.register(Question)
admin.site.register(Choice)
admin.site.register(Announcement)
admin.site.register(Comment)
admin.site.register(Schedule)
admin.site.register(Progress)
admin.site.register(DiscussionThread)
admin.site.register(DiscussionPost)