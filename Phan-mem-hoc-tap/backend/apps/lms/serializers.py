# backend/apps/lms/serializers.py
from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import (
    Course, Section, Lesson, Material,
    Assignment, Submission,
    Quiz, Question, Choice,
    Enrollment, Progress, Announcement, Comment, Schedule,
    DiscussionThread, DiscussionPost, Notification,QuizSubmission,
    AttendanceSession, AttendanceRecord
)

User = get_user_model()

# --- User Serializer (nhúng gọn) ---
class SimpleUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "email", "first_name", "last_name", "avatar", "role"]

# --- Notification ---
class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = ["id", "recipient", "course", "title", "body", "is_read", "created_at"]
        read_only_fields = ["id", "created_at"]

# --- Course & Enrollment ---
class EnrollmentSerializer(serializers.ModelSerializer):
    user = SimpleUserSerializer(read_only=True)
    class Meta:
        model = Enrollment
        fields = ["id", "course", "user", "role", "created_at", "updated_at"]
        read_only_fields = ["id", "created_at", "updated_at", "user"]

class CourseSerializer(serializers.ModelSerializer):
    owner = SimpleUserSerializer(read_only=True)
    # Các trường đếm (nếu có logic annotate trong viewset)
    students_count = serializers.IntegerField(read_only=True, required=False)
    teachers_count = serializers.IntegerField(read_only=True, required=False)
    enrollments = EnrollmentSerializer(many=True, read_only=True)

    class Meta:
        model = Course
        # --- CHỈ DÙNG 1 CLASS META DUY NHẤT NHƯ NÀY ---
        fields = [
            "id", "owner", "title", "description", 
            "code", "meeting_link",  # <--- ĐÃ CÓ TRƯỜNG NÀY
            "students_count", "teachers_count", "enrollments",
            "created_at", "updated_at"
        ]
        read_only_fields = ["owner", "code", "created_at", "updated_at"]
# --- Content ---
class MaterialSerializer(serializers.ModelSerializer):
    class Meta:
        model = Material
        fields = "__all__"

class LessonSerializer(serializers.ModelSerializer):
    materials = MaterialSerializer(many=True, read_only=True)
    class Meta:
        model = Lesson
        fields = "__all__"

class SectionSerializer(serializers.ModelSerializer):
    lessons = LessonSerializer(many=True, read_only=True)
    class Meta:
        model = Section
        fields = "__all__"

# --- Assignment & Submission ---
class SubmissionSerializer(serializers.ModelSerializer):
    owner = SimpleUserSerializer(read_only=True)
    
    class Meta:
        model = Submission
        fields = "__all__"
        # status và submitted_at do hệ thống tự tính, user không sửa trực tiếp
        read_only_fields = ["owner", "created_at", "updated_at"]
class AssignmentSerializer(serializers.ModelSerializer):
    course_title = serializers.CharField(source="course.title", read_only=True)
    class Meta:
        model = Assignment
        fields = ["id", "course", "course_title", "title", "description", "due_at", "max_score", "created_at"]

# --- Quiz ---
class ChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Choice
        fields = "__all__"

class QuestionSerializer(serializers.ModelSerializer):
    choices = ChoiceSerializer(many=True, read_only=True)
    class Meta:
        model = Question
        fields = "__all__"

class QuizSerializer(serializers.ModelSerializer):
    questions = QuestionSerializer(many=True, read_only=True)
    class Meta:
        model = Quiz
        fields = "__all__"
        read_only_fields = ["author", "created_at", "updated_at"]
# --- Communication ---
class AnnouncementSerializer(serializers.ModelSerializer):
    author = SimpleUserSerializer(read_only=True)
    class Meta:
        model = Announcement
        fields = ["id", "course", "author", "title", "body", "created_at"]
        read_only_fields = ["author", "created_at"]

class CommentSerializer(serializers.ModelSerializer):
    author = SimpleUserSerializer(read_only=True)
    class Meta:
        model = Comment
        fields = ["id", "course", "announcement", "author", "body", "created_at", "updated_at"]
        read_only_fields = ["author", "created_at"]

# --- Misc ---
class ScheduleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Schedule
        fields = "__all__"

class ProgressSerializer(serializers.ModelSerializer):
    course_title = serializers.CharField(source="course.title", read_only=True)
    class Meta:
        model = Progress
        fields = "__all__"

class DiscussionThreadSerializer(serializers.ModelSerializer):
    author = SimpleUserSerializer(read_only=True)
    class Meta:
        model = DiscussionThread
        fields = "__all__"

class DiscussionPostSerializer(serializers.ModelSerializer):
    author = SimpleUserSerializer(read_only=True)
    class Meta:
        model = DiscussionPost
        fields = "__all__"
# --- THÊM CLASS NÀY ---
class QuizSubmissionSerializer(serializers.ModelSerializer):
    student = SimpleUserSerializer(read_only=True)
    
    class Meta:  # Chữ M viết hoa, thụt lề đúng
        model = QuizSubmission
        fields = ["id", "quiz", "student", "score", "correct_count", "total_questions", "submitted_at"]
        read_only_fields = ["student", "score", "correct_count", "total_questions", "submitted_at"]

    class Meta:
        model = QuizSubmission
        fields = ["id", "quiz", "student", "score", "correct_count", "total_questions", "submitted_at"]
# --- Attendance ---
class AttendanceRecordSerializer(serializers.ModelSerializer):
    student_name = serializers.CharField(source='student.last_name', read_only=True)
    student_email = serializers.CharField(source='student.email', read_only=True)
    
    class Meta:
        model = AttendanceRecord
        fields = ['id', 'session', 'student', 'student_name', 'student_email', 'status', 'note']

class AttendanceSessionSerializer(serializers.ModelSerializer):
    records = AttendanceRecordSerializer(many=True, read_only=True)
    present_count = serializers.SerializerMethodField()
    
    class Meta:
        model = AttendanceSession
        fields = ['id', 'course', 'date', 'title', 'records', 'present_count']

    def get_present_count(self, obj):
        return obj.records.filter(status='present').count()