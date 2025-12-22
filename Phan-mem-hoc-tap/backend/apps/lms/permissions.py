# apps/lms/permissions.py
from __future__ import annotations
from rest_framework import permissions
from typing import TYPE_CHECKING
from rest_framework.permissions import BasePermission, SAFE_METHODS
from django.contrib.auth import get_user_model

from .models import Course, Enrollment

# Runtime user model (không dùng trong type hint trực tiếp)
UserModel = get_user_model()

# Dùng forward-ref chỉ cho mục đích type checking
if TYPE_CHECKING:
    # Nếu bạn có users.User, import để Pylance biết kiểu
    from apps.users.models import User  # noqa: F401
else:
    # Khi runtime, chỉ cần alias string "User" để tránh Pylance báo lỗi
    User = "User"  # type: ignore

def _get_course_from_obj(obj):
    """Helper tìm Course từ các object con."""
    from .models import Course, DiscussionThread
    
    if isinstance(obj, Course): return obj
    if hasattr(obj, "course") and obj.course: return obj.course
    if hasattr(obj, "section") and obj.section: return obj.section.course
    if hasattr(obj, "lesson") and obj.lesson: return obj.lesson.section.course
    if hasattr(obj, "assignment") and obj.assignment: return obj.assignment.course
    if hasattr(obj, "quiz") and obj.quiz: return obj.quiz.course
    if hasattr(obj, "question") and obj.question: return obj.question.quiz.course
    
    # Logic cho thảo luận
    if hasattr(obj, "thread") and obj.thread: return obj.thread.course
    if isinstance(obj, DiscussionThread): return obj.course
        
    return None

def _is_course_teacher(user: "User", course: Course) -> bool:
    """
    Người dùng là 'teacher' trong course (theo Enrollment.role).
    """
    return Enrollment.objects.filter(course=course, user=user, role="teacher").exists()


class IsTeacherOrAdmin(BasePermission):
    """
    Quyền chung: user có 'role' == teacher/admin (nếu hệ thống user có field 'role')
    hoặc là staff/superuser.
    """
    def has_permission(self, request, view):
        u = getattr(request, "user", None)
        if not (u and u.is_authenticated):
            return False
        role = getattr(u, "role", "")
        return bool(u.is_staff or u.is_superuser or role in ("teacher", "admin"))


class IsOwnerTeacherOrAdmin(BasePermission):
    """
    WRITE: owner của course hoặc teacher (Enrollment.role='teacher') hoặc admin/staff.
    READ: cho phép (xử lý ở ViewSet với IsAuthenticated).
    """
    def has_object_permission(self, request, view, obj):
        if request.method in SAFE_METHODS:
            return True

        u = getattr(request, "user", None)
        if not (u and u.is_authenticated):
            return False

        if u.is_superuser or u.is_staff or getattr(u, "role", "") == "admin":
            return True

        course = _get_course_from_obj(obj)
        if not course:
            return False

        if course.owner_id == u.id:
            return True

        return _is_course_teacher(u, course)


class IsTeacherOfCourseOrReadOnly(BasePermission):
    """
    READ: all authenticated.
    WRITE: owner của course hoặc teacher của course.
    """
    def has_object_permission(self, request, view, obj):
        if request.method in SAFE_METHODS:
            return True

        u = getattr(request, "user", None)
        if not (u and u.is_authenticated):
            return False

        if u.is_superuser or u.is_staff or getattr(u, "role", "") == "admin":
            return True

        course = _get_course_from_obj(obj)
        if not course:
            return False

        if course.owner_id == u.id:
            return True

        return _is_course_teacher(u, course)


class IsThreadParticipantOrReadOnly(BasePermission):
    """
    READ: all authenticated.
    WRITE: tác giả thread, hoặc owner/teacher của course chứa thread.
    Áp dụng cho DiscussionThread & DiscussionPost.
    """
    def has_object_permission(self, request, view, obj):
        if request.method in SAFE_METHODS:
            return True

        u = getattr(request, "user", None)
        if not (u and u.is_authenticated):
            return False

        if u.is_superuser or u.is_staff or getattr(u, "role", "") == "admin":
            return True

        # obj có thể là thread hoặc post
        thread = getattr(obj, "thread", None) or obj
        course = _get_course_from_obj(thread)
        if not course:
            return False

        # owner/teacher
        if course.owner_id == u.id or _is_course_teacher(u, course):
            return True

        # tác giả thread
        author_id = getattr(thread, "author_id", None)
        return author_id == u.id
# --- THÊM ĐOẠN NÀY VÀO CUỐI FILE permissions.py ---

# --- THÊM VÀO CUỐI FILE backend/apps/lms/permissions.py ---

class IsSubmissionOwnerOrTeacher(BasePermission):
    """
    Dành riêng cho Submission:
    - Học sinh (Owner): Được xem, được sửa (nộp lại nếu chưa hết hạn).
    - Giáo viên: Được xem và SỬA (Chấm điểm).
    """
    def has_object_permission(self, request, view, obj):
        # Admin luôn được phép
        if request.user.is_superuser or getattr(request.user, 'role', '') == 'admin':
            return True

        # 1. Chủ sở hữu (Học sinh)
        if obj.owner == request.user:
            return True

        # 2. Giáo viên của khóa học chứa bài tập này
        # (Truy ngược: Submission -> Assignment -> Course -> Owner)
        # Cần kiểm tra xem obj.assignment.course có tồn tại không để tránh lỗi
        if hasattr(obj, 'assignment') and obj.assignment.course.owner == request.user:
            return True

        return False
# --- DÁN THÊM VÀO CUỐI FILE permissions.py ---

class IsOwnerOrTeacher(permissions.BasePermission):
    """
    - GET (Xem): Cho phép TẤT CẢ user đã đăng nhập (để Học sinh xem được nội dung).
    - Sửa/Xóa: Chỉ Admin, Giáo viên chủ nhiệm khóa học hoặc Chủ sở hữu.
    """
    def has_object_permission(self, request, view, obj):
        # 1. Cho phép xem (GET, HEAD, OPTIONS)
        if request.method in permissions.SAFE_METHODS:
            return True

        # 2. Admin tối cao luôn có quyền
        if request.user.is_superuser or getattr(request.user, 'role', '') == 'admin':
            return True

        # 3. Chủ sở hữu trực tiếp của object (ví dụ: người tạo khóa học)
        if hasattr(obj, 'owner') and obj.owner == request.user:
            return True
        if hasattr(obj, 'author') and obj.author == request.user:
            return True
            
        # 4. Giáo viên của khóa học chứa object này (check ngược lên Course)
        course = _get_course_from_obj(obj)
        if course and hasattr(course, 'owner') and course.owner == request.user:
            return True
            
        return False
class IsSubmissionOwnerOrTeacher(permissions.BasePermission):
    """
    - Học sinh chỉ xem/sửa được bài nộp của chính mình.
    - Giáo viên khóa học xem được tất cả bài nộp của học sinh.
    """
    def has_object_permission(self, request, view, obj):
        # Admin
        if request.user.is_superuser or getattr(request.user, 'role', '') == 'admin':
            return True
            
        # Giáo viên khóa học (chủ nhiệm)
        if hasattr(obj, 'assignment') and obj.assignment.course.owner == request.user:
            return True

        # Chính chủ bài nộp
        return obj.owner == request.user

# --- Helper function để tìm Course từ các object con ---
def _get_course_from_obj(obj):
    from .models import Course # Import trong hàm để tránh vòng lặp
    if isinstance(obj, Course):
        return obj
    if hasattr(obj, "course") and obj.course:
        return obj.course
    if hasattr(obj, "section") and obj.section:
        return obj.section.course
    if hasattr(obj, "lesson") and obj.lesson:
        return obj.lesson.section.course
    if hasattr(obj, "assignment") and obj.assignment:
        return obj.assignment.course
    if hasattr(obj, "quiz") and obj.quiz:
        return obj.quiz.course
    if hasattr(obj, "question") and obj.question:
        return obj.question.quiz.course
    return None
class IsCourseMember(permissions.BasePermission):
    """Cho phép thành viên trong lớp được Xem và Đăng bài thảo luận."""
    def has_object_permission(self, request, view, obj):
        if request.user.is_superuser or getattr(request.user, 'role', '') == 'admin': return True

        course = _get_course_from_obj(obj)
        if not course: return False

        if course.owner == request.user: return True

        # Check enrollment
        is_enrolled = course.enrollments.filter(user=request.user).exists()
        if not is_enrolled: return False 

        if request.method in permissions.SAFE_METHODS: return True
        
        # Sửa/Xóa thì phải là tác giả
        if hasattr(obj, 'author'): return obj.author == request.user
            
        return False