# backend/apps/lms/viewsets.py
from __future__ import annotations
from email.mime import text
from django.http import HttpResponse 
import json
import re
import requests
import os
import traceback
from rest_framework import status
from django.db.models import Count, Q, Prefetch
from rest_framework import viewsets, permissions, status, filters
from django.utils import timezone
from rest_framework.exceptions import ValidationError, PermissionDenied
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.exceptions import ValidationError
from rest_framework.exceptions import PermissionDenied
from .models import AttendanceSession, AttendanceRecord # <-- Thêm
from .serializers import AttendanceSessionSerializer, AttendanceRecordSerializer # <-- Thêm
from .permissions import IsOwnerOrTeacher, IsSubmissionOwnerOrTeacher, IsCourseMember
from .models import (
    Course, Section, Lesson, Material,
    Assignment, Submission,
    Quiz, Question, Choice,
    Enrollment, Progress, Announcement, Comment, Schedule,
    DiscussionThread, DiscussionPost, Notification,QuizSubmission,
)
from .serializers import (
    CourseSerializer, SectionSerializer, LessonSerializer, MaterialSerializer,
    AssignmentSerializer, SubmissionSerializer,
    QuizSerializer, QuestionSerializer, ChoiceSerializer,
    EnrollmentSerializer, ProgressSerializer,
    AnnouncementSerializer, CommentSerializer, ScheduleSerializer,
    DiscussionThreadSerializer, DiscussionPostSerializer, NotificationSerializer,
    SimpleUserSerializer,QuizSubmissionSerializer,
)
OLLAMA_URL = os.getenv("OLLAMA_URL", "http://127.0.0.1:11434").rstrip("/")
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "phi3:mini")
# --- HÀM HỖ TRỢ TẠO THÔNG BÁO (Dán vào đầu file viewsets.py) ---
def notify_course_users(course, title, body, exclude_user=None):
    """Gửi thông báo cho tất cả thành viên trong lớp"""
    enrollments = Enrollment.objects.filter(course=course).select_related('user')
    notifications = []
    for enr in enrollments:
        if exclude_user and enr.user == exclude_user:
            continue
        notifications.append(Notification(
            recipient=enr.user,
            course=course,
            title=title,
            body=body
        ))
    if notifications:
        Notification.objects.bulk_create(notifications)
# -------------------------------------------------------------------
# Permissions & Helpers
# -------------------------------------------------------------------
class IsOwnerOrTeacher(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.is_superuser: return True
        course = _get_course_from_obj(obj)
        if not course: return False
        if course.owner == request.user: return True
        return _is_course_teacher(request.user, course)

class IsEnrolledOrOwnerReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.is_superuser: return True
        course = _get_course_from_obj(obj)
        if not course: return False
        if request.method in permissions.SAFE_METHODS:
            if course.owner == request.user: return True
            return _is_course_enrolled(request.user, course)
        return IsOwnerOrTeacher().has_object_permission(request, view, obj)

def _get_course_from_obj(obj):
    if isinstance(obj, Course): return obj
    if hasattr(obj, "course"): return obj.course
    if hasattr(obj, "section"): return obj.section.course
    if hasattr(obj, "lesson"): return obj.lesson.section.course
    if hasattr(obj, "assignment"): return obj.assignment.course
    if hasattr(obj, "quiz"): return obj.quiz.course
    return None

def _is_course_teacher(user, course):
    return Enrollment.objects.filter(course=course, user=user, role=Enrollment.ROLE_TEACHER).exists()
def _is_course_enrolled(user, course):
    return Enrollment.objects.filter(course=course, user=user).exists()

# -------------------------------------------------------------------
# Viewsets
# -------------------------------------------------------------------
class CourseViewSet(viewsets.ModelViewSet):
    serializer_class = CourseSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter]
    filterset_fields = {"owner": ["exact"]}
    search_fields = ["title", "code"]
    ordering = ["-created_at"]

    def get_queryset(self):
        qs = Course.objects.annotate(
            students_count=Count("enrollments", filter=Q(enrollments__role="student"), distinct=True),
            teachers_count=Count("enrollments", filter=Q(enrollments__role="teacher"), distinct=True),
        )
        if self.request.user.is_superuser: return qs
        return qs.filter(Q(owner=self.request.user) | Q(enrollments__user=self.request.user)).distinct()

    def perform_create(self, serializer):
        course = serializer.save(owner=self.request.user)
        Enrollment.objects.get_or_create(course=course, user=self.request.user, defaults={"role": "teacher"})

    @action(detail=False, methods=['post'])
    def join(self, request):
        raw = request.data.get("code", "")

        # nếu FE lỡ gửi object
        if isinstance(raw, dict):
            raw = raw.get("code") or raw.get("value") or ""

        if not isinstance(raw, str):
            raise ValidationError({"code": "code phải là chuỗi."})

        code = raw.strip().upper()

        course = Course.objects.filter(code=code).first()
        if not course: return Response({"detail": "Mã không hợp lệ."}, status=404)
        if Enrollment.objects.filter(course=course, user=request.user).exists():
            return Response({"detail": "Đã tham gia.", "id": course.id})
        Enrollment.objects.create(course=course, user=request.user, role="student")
        return Response({"detail": "Tham gia thành công!", "id": course.id})

    @action(detail=True, methods=['get'])
    def analytics(self, request, pk=None):
        course = self.get_object()
        # Check quyền
        if request.user != course.owner and getattr(request.user, 'role', '') != 'admin':
            return Response({"detail": "Không có quyền truy cập."}, status=403)
        
        students = course.enrollments.filter(role='student').values_list('user', flat=True)
        
        # Hàm hỗ trợ tính phân phối
        def calculate_distribution(scores_list):
            dist = {"0-4": 0, "5-6": 0, "7-8": 0, "9-10": 0}
            for sc in scores_list:
                if sc < 5: dist["0-4"] += 1
                elif sc < 7: dist["5-6"] += 1
                elif sc < 9: dist["7-8"] += 1
                else: dist["9-10"] += 1
            return dist

        # 1. Lấy điểm Quiz
        quiz_scores = list(QuizSubmission.objects.filter(
            quiz__course=course, student__in=students
        ).values_list('score', flat=True))
        quiz_dist = calculate_distribution(quiz_scores)

        # 2. Lấy điểm Bài tập (Assignment) - Chỉ lấy bài đã chấm
        ass_scores = list(Submission.objects.filter(
            assignment__course=course, 
            owner__in=students, 
            score__isnull=False
        ).values_list('score', flat=True))
        ass_dist = calculate_distribution(ass_scores)

        # 3. Cấu trúc dữ liệu cho biểu đồ cột ghép (Grouped Bar Chart)
        chart_data = [
            {
                "name": "Yếu (<5)", 
                "quiz": quiz_dist["0-4"], 
                "assignment": ass_dist["0-4"]
            },
            {
                "name": "TB (5-6)", 
                "quiz": quiz_dist["5-6"], 
                "assignment": ass_dist["5-6"]
            },
            {
                "name": "Khá (7-8)", 
                "quiz": quiz_dist["7-8"], 
                "assignment": ass_dist["7-8"]
            },
            {
                "name": "Giỏi (9-10)", 
                "quiz": quiz_dist["9-10"], 
                "assignment": ass_dist["9-10"]
            },
        ]

        return Response({
            "total_students": len(students),
            "total_lessons": Lesson.objects.filter(section__course=course).count(),
            "total_submissions": len(quiz_scores) + len(ass_scores),
            "score_chart": chart_data
        })
    
    @action(detail=True, methods=['get'])
    def grades(self, request, pk=None):
        course = self.get_object()
        if request.user != course.owner and getattr(request.user, 'role', '') != 'admin':
             return Response({"detail": "Cấm truy cập."}, status=403)
             
        assignments = Assignment.objects.filter(course=course).order_by('due_at', 'id')
        enrollments = Enrollment.objects.filter(course=course, role="student").select_related('user')
        submissions = Submission.objects.filter(assignment__in=assignments).select_related('owner', 'assignment')
        
        sub_map = {(s.owner_id, s.assignment_id): s.score for s in submissions}
        
        data = []
        for enr in enrollments:
            scores = {a.id: sub_map.get((enr.user.id, a.id), None) for a in assignments}
            data.append({"user": SimpleUserSerializer(enr.user).data, "scores": scores})
            
        return Response({
            "assignments": [{"id": a.id, "title": a.title, "max_score": a.max_score} for a in assignments],
            "grades": data
        })
    
class SectionViewSet(viewsets.ModelViewSet):
    queryset = Section.objects.select_related("course").order_by("course", "order", "created_at")
    serializer_class = SectionSerializer
    permission_classes = [permissions.IsAuthenticated, IsEnrolledOrOwnerReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"]}

class LessonViewSet(viewsets.ModelViewSet):
    queryset = Lesson.objects.select_related("section", "section__course").order_by("section", "order", "created_at")
    serializer_class = LessonSerializer
    permission_classes = [permissions.IsAuthenticated, IsEnrolledOrOwnerReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"section": ["exact"], "section__course": ["exact"]}

class MaterialViewSet(viewsets.ModelViewSet):
    queryset = Material.objects.select_related("lesson", "lesson__section", "lesson__section__course").order_by("-created_at")
    serializer_class = MaterialSerializer
    permission_classes = [permissions.IsAuthenticated, IsEnrolledOrOwnerReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"lesson": ["exact"], "lesson__section": ["exact"]}

class AssignmentViewSet(viewsets.ModelViewSet):
    serializer_class = AssignmentSerializer
    # SỬA LỖI: Dùng IsEnrolledOrOwnerReadOnly để cho phép Học sinh xem (GET)
    permission_classes = [permissions.IsAuthenticated, IsEnrolledOrOwnerReadOnly] 
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"]}
    def get_queryset(self): 
        # Thêm order_by để hết cảnh báo
        return Assignment.objects.all().order_by('-created_at')

    def perform_create(self, serializer):
        assignment = serializer.save()
        # --- LOGIC MỚI: Gửi thông báo ---
        notify_course_users(
            course=assignment.course,
            title="Bài tập mới",
            body=f"Giáo viên đã giao bài tập: {assignment.title}",
            exclude_user=self.request.user
        )
    
class SubmissionViewSet(viewsets.ModelViewSet):
    serializer_class = SubmissionSerializer
    permission_classes = [permissions.IsAuthenticated, IsSubmissionOwnerOrTeacher]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"assignment": ["exact"], "owner": ["exact"]}

    def get_queryset(self):
        qs = Submission.objects.all().order_by('-created_at')
        if getattr(self.request.user, 'role', '') == 'student': return qs.filter(owner=self.request.user)
        return qs

    def perform_create(self, serializer):
        assignment = serializer.validated_data['assignment']
        if assignment.due_at and timezone.now() > assignment.due_at:
            raise ValidationError({"detail": "Đã quá hạn nộp bài."})
        if Submission.objects.filter(assignment=assignment, owner=self.request.user).exists():
             raise ValidationError({"detail": "Bạn đã nộp bài rồi."})
        serializer.save(owner=self.request.user)

    def perform_update(self, serializer):
        obj = serializer.instance
        user = self.request.user
        if (obj.assignment.course.owner == user) or (getattr(user, 'role', '') == 'admin'):
            if 'score' in serializer.validated_data:
                serializer.save(status="GRADED")
                Notification.objects.create(recipient=obj.owner, course=obj.assignment.course, title="Đã có điểm", body=f"Bài '{obj.assignment.title}' đã chấm.")
            else: serializer.save()
        else:
            serializer.save(status="SUBMITTED", submitted_at=timezone.now())

    @action(detail=True, methods=['post'])
    def return_submission(self, request, pk=None):
        sub = self.get_object()
        if sub.assignment.course.owner != request.user and getattr(request.user, 'role', '') != 'admin':
            return Response({"detail": "Không có quyền"}, status=403)
        sub.status = "RETURNED"
        sub.save()
        Notification.objects.create(recipient=sub.owner, course=sub.assignment.course, title="Đã trả bài", body=f"Bài '{sub.assignment.title}' đã được trả.")
        return Response({"status": "RETURNED"})
def _extract_json_array(text: str):
    """
    Cố gắng bóc JSON Array [...] từ chuỗi trả về của model.
    Tránh trường hợp model trả thêm chữ ngoài JSON.
    """
    if not text:
        raise ValueError("Empty AI response")

    # Loại bỏ markdown fence nếu có
    cleaned = re.sub(r"```(?:json)?|```", "", text).strip()

    # Tìm đoạn bắt đầu từ [ đến ] cuối cùng
    start = cleaned.find("[")
    end = cleaned.rfind("]")
    if start == -1 or end == -1 or end <= start:
        raise ValueError("AI response does not contain a JSON array.")

    json_part = cleaned[start:end + 1].strip()
    return json.loads(json_part)
class QuizViewSet(viewsets.ModelViewSet):
    serializer_class = QuizSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"]}

    # Mở quyền cho các API nộp bài và xem điểm
    def get_permissions(self):
    # AI generate: chỉ cần đăng nhập
        if self.action == 'generate_ai':
            return [permissions.IsAuthenticated()]

        if self.action in ['attempt', 'retrieve', 'list', 'my_result', 'all_submissions']:
            return [permissions.IsAuthenticated()]

        return [permissions.IsAuthenticated(), IsOwnerOrTeacher()]


    def get_queryset(self):
        return Quiz.objects.all().order_by('-created_at')

    def perform_create(self, serializer):
        quiz = serializer.save(author=self.request.user)
        if quiz.is_published:
            notify_course_users(
                course=quiz.course,
                title="Bài kiểm tra mới",
                body=f"Kiểm tra: {quiz.title}",
                exclude_user=self.request.user
            )

    # --- 1. API NỘP BÀI (Đã thêm logic lưu DB & Chặn làm lại) ---
    @action(detail=True, methods=['post'])
    def attempt(self, request, pk=None):
        quiz = self.get_object()
        user = request.user

        # Kiểm tra: Nếu đã có bài nộp trong DB -> Chặn
        if QuizSubmission.objects.filter(quiz=quiz, student=user).exists():
            return Response(
                {"detail": "Bạn đã nộp bài kiểm tra này rồi. Không thể làm lại."}, 
                status=400
            )

        answers = request.data.get("answers", {})
        score = 0
        correct_count = 0
        total_questions = quiz.questions.count()

        # Logic chấm điểm
        for question in quiz.questions.all():
            user_choices = answers.get(str(question.id))
            if not isinstance(user_choices, list): 
                user_choices = [str(user_choices)] if user_choices else []
            user_choices = set(map(str, user_choices))
            
            correct_choices = set(map(str, question.choices.filter(is_correct=True).values_list('id', flat=True)))

            if user_choices == correct_choices:
                score += question.points
                correct_count += 1
        
        # LƯU KẾT QUẢ VÀO DATABASE
        sub = QuizSubmission.objects.create(
            quiz=quiz,
            student=user,
            score=score,
            correct_count=correct_count,
            total_questions=total_questions
        )

        # Gửi thông báo cho Giáo viên
        Notification.objects.create(
            recipient=quiz.course.owner,
            course=quiz.course,
            title="Học sinh nộp bài",
            body=f"{user.last_name} đã nộp bài '{quiz.title}'. Điểm: {score}"
        )
        
        return Response({
            "quiz_title": quiz.title,
            "score": score,
            "correct_count": correct_count,
            "total_questions": total_questions,
            "submitted_at": timezone.now()
        })
    
    # --- 2. API CHO HỌC SINH XEM LẠI KẾT QUẢ ---
    @action(detail=True, methods=['get'])
    def my_result(self, request, pk=None):
        quiz = self.get_object()
        try:
            sub = QuizSubmission.objects.get(quiz=quiz, student=request.user)
            return Response(QuizSubmissionSerializer(sub).data)
        except QuizSubmission.DoesNotExist:
            return Response(None) # Chưa làm

    # --- 3. API CHO GIÁO VIÊN XEM DANH SÁCH ĐIỂM ---
    @action(detail=True, methods=['get'])
    def all_submissions(self, request, pk=None):
        quiz = self.get_object()
        # Check quyền GV
        if quiz.course.owner != request.user and getattr(request.user, 'role', '') != 'admin':
            return Response({"detail": "Không có quyền xem điểm."}, status=403)
            
        subs = QuizSubmission.objects.filter(quiz=quiz).order_by('-score')
        return Response(QuizSubmissionSerializer(subs, many=True).data)
    @action(detail=False, methods=["post"], url_path="generate-ai")
    def generate_ai(self, request):
        text = (request.data.get("text") or "").strip()

        # num an toàn
        try:
            num = int(request.data.get("num", 3))
        except Exception:
            num = 1
        num = max(1, min(num, 3))  # RAM 8GB: tối đa 3 câu cho đỡ lâu

        if not text:
            return Response(
                {"detail": "Thiếu nội dung văn bản"},
                status=status.HTTP_400_BAD_REQUEST
            )

        ollama_url = "http://127.0.0.1:11434/api/generate"
        prompt = f"""
Hãy tạo {num} câu hỏi trắc nghiệm tiếng Việt từ nội dung sau:

{text}

Yêu cầu:
- CHỈ trả về JSON ARRAY thuần (không markdown, không giải thích)
- Mỗi câu có đúng 1 đáp án đúng
- question_type = "single_choice"
- choices có đúng 4 lựa chọn
- choices[i].text PHẢI là nội dung đáp án (không được chỉ là "A"/"B"/"C"/"D")

Format:
[
  {{
    "text": "Câu hỏi?",
    "question_type": "single_choice",
    "choices": [
      {{ "text": "Nội dung đáp án 1", "is_correct": false }},
      {{ "text": "Nội dung đáp án 2", "is_correct": true }},
      {{ "text": "Nội dung đáp án 3", "is_correct": false }},
      {{ "text": "Nội dung đáp án 4", "is_correct": false }}
    ]
  }}
]
""".strip()
        payload = {
            "model": "qwen2.5:3b",
            "prompt": prompt,
            "stream": False,
            "keep_alive": "10m",
            "options": {
                "num_ctx": 1024,
                "temperature": 0.4
            # Bạn có thể thêm options để giảm nặng:
            # "options": {"num_ctx": 1024}
        }
    }
        try:
            r = requests.post(ollama_url, json=payload, timeout=600)

            # Nếu Ollama trả lỗi, trả nguyên văn để debug
            if r.status_code >= 400:
                return Response(
                    {
                        "detail": "Ollama trả lỗi",
                        "status_code": r.status_code,
                        "body": r.text[:2000],
                        "url": ollama_url
                    },
                    status=status.HTTP_503_SERVICE_UNAVAILABLE
                )

            data = r.json()
            raw = (data.get("response") or "").strip()

            # Log để bạn nhìn trực tiếp terminal
            print("=== OLLAMA RAW (first 1500 chars) ===")
            print(raw[:1500])

            # Bóc JSON array an toàn
            questions = _extract_json_array(raw)

            return Response(questions, status=status.HTTP_200_OK)

        except requests.exceptions.Timeout:
            return Response(
                {"detail": "Ollama chạy quá lâu. Hãy giảm num=1 hoặc prompt ngắn hơn."},
                status=status.HTTP_504_GATEWAY_TIMEOUT
            )


        except Exception as e:
            print("=== AI ERROR TRACEBACK ===")
            traceback.print_exc()

            return Response(
                {
                    "detail": "AI lỗi khi parse JSON hoặc gọi Ollama",
                    "error": str(e),
                },
                status=status.HTTP_400_BAD_REQUEST
            )
class QuestionViewSet(viewsets.ModelViewSet):
    queryset = Question.objects.select_related("quiz", "quiz__course").order_by("quiz", "order", "created_at")
    serializer_class = QuestionSerializer
    permission_classes = [permissions.IsAuthenticated, IsEnrolledOrOwnerReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"quiz": ["exact"]}

class ChoiceViewSet(viewsets.ModelViewSet):
    queryset = Choice.objects.select_related("question", "question__quiz").order_by("question", "created_at")
    serializer_class = ChoiceSerializer
    permission_classes = [permissions.IsAuthenticated, IsEnrolledOrOwnerReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"question": ["exact"]}

class EnrollmentViewSet(viewsets.ModelViewSet):
    queryset = Enrollment.objects.select_related("course", "user").order_by("-created_at")
    serializer_class = EnrollmentSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"], "user": ["exact"], "role": ["exact"]}

    def get_queryset(self):
        if self.request.user.is_superuser: return self.queryset
        return self.queryset.filter(
            Q(course__owner=self.request.user) |
            Q(course__enrollments__user=self.request.user, course__enrollments__role=Enrollment.ROLE_TEACHER)
        ).distinct()

    def perform_create(self, serializer):
        course = serializer.validated_data["course"]
        if not IsOwnerOrTeacher().has_object_permission(self.request, self, course):
            raise PermissionDenied("Chỉ giáo viên mới được thêm thành viên.")
        serializer.save()

class AnnouncementViewSet(viewsets.ModelViewSet):
    serializer_class = AnnouncementSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"]}
    
    def get_queryset(self): 
        return Announcement.objects.all().order_by('-created_at')
        
    def perform_create(self, serializer):
        # Lưu thông báo
        announcement = serializer.save(author=self.request.user)
        
        # Gửi thông báo cho cả lớp (Dùng hàm helper đã khai báo ở đầu file)
        notify_course_users(
            course=announcement.course,
            title="Thông báo mới",
            body=f"{announcement.author.last_name or 'GV'}: {announcement.title}",
            exclude_user=self.request.user
        )

class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.select_related("course", "author").order_by("created_at")
    serializer_class = CommentSerializer
    permission_classes = [permissions.IsAuthenticated] # 🔹 Sửa: Bỏ IsEnrolledOrOwnerReadOnly ở class level để xử lý tay
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_fields = {"course": ["exact"], "announcement": ["exact"]}
    ordering = ["created_at"]

    def get_queryset(self):
        # Ai cũng xem được comment của khoá học mình tham gia/sở hữu
        return self.queryset.filter(
            Q(course__owner=self.request.user) | 
            Q(course__enrollments__user=self.request.user)
        ).distinct()

    def perform_create(self, serializer):
        course = serializer.validated_data["course"]
        user = self.request.user
        
        # 🔹 Logic kiểm tra quyền chuẩn Google Classroom:
        # 1. Là chủ sở hữu (Giáo viên tạo khoá)
        # 2. HOẶC Là học sinh đã tham gia (Enrolled)
        is_owner = (course.owner == user)
        is_enrolled = Enrollment.objects.filter(course=course, user=user).exists()

        if not is_owner and not is_enrolled:
             raise PermissionDenied("Bạn phải tham gia khoá học này mới được bình luận.")
             
        serializer.save(author=user)
class ScheduleViewSet(viewsets.ModelViewSet):
    serializer_class = ScheduleSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_fields = {"course": ["exact"], "type": ["exact"]}
    ordering = ["starts_at"]

    def get_queryset(self):
        return Schedule.objects.filter(
            Q(course__owner=self.request.user) | Q(course__enrollments__user=self.request.user)
        ).distinct()

    def perform_create(self, serializer):
        course = serializer.validated_data['course']
        if course.owner != self.request.user and getattr(self.request.user, 'role', '') != 'admin':
             raise PermissionDenied("Chỉ giáo viên mới được tạo lịch.")
        serializer.save()
class ProgressViewSet(viewsets.ModelViewSet):
    # 🔹 ĐÃ SỬA: Đổi order_by("-updated_at") thành order_by("-last_activity_at")
    queryset = Progress.objects.select_related("course", "user").order_by("-last_activity_at")
    serializer_class = ProgressSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"], "user": ["exact"]}

    def get_queryset(self):
        if self.request.user.is_superuser: return self.queryset.filter(course__isnull=False)
        return self.queryset.filter(
            Q(user=self.request.user) |
            Q(course__owner=self.request.user) |
            Q(course__enrollments__user=self.request.user, course__enrollments__role=Enrollment.ROLE_TEACHER)
        ).distinct()

# Thay thế 2 class DiscussionThreadViewSet và DiscussionPostViewSet bằng đoạn này:

class DiscussionThreadViewSet(viewsets.ModelViewSet):
    serializer_class = DiscussionThreadSerializer
    # 👇 SỬA DÒNG NÀY: Dùng IsCourseMember
    permission_classes = [permissions.IsAuthenticated, IsCourseMember] 
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"]}

    def get_queryset(self):
        return DiscussionThread.objects.filter(
            Q(course__owner=self.request.user) | Q(course__enrollments__user=self.request.user)
        ).distinct().order_by('-updated_at')

    def perform_create(self, serializer):
        course = serializer.validated_data['course']
        # Kiểm tra quyền thủ công
        is_auth = (course.owner == self.request.user) or \
                  (course.enrollments.filter(user=self.request.user).exists()) or \
                  (getattr(self.request.user, 'role', '') == 'admin')
        if not is_auth: raise PermissionDenied("Bạn không phải thành viên lớp.")
        serializer.save(author=self.request.user)
class DiscussionPostViewSet(viewsets.ModelViewSet):
    serializer_class = DiscussionPostSerializer
    # 👇 SỬA DÒNG NÀY: Dùng IsCourseMember
    permission_classes = [permissions.IsAuthenticated, IsCourseMember]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"thread": ["exact"]}

    def get_queryset(self):
        return DiscussionPost.objects.select_related("thread", "thread__course", "author").filter(
            Q(thread__course__owner=self.request.user) | Q(thread__course__enrollments__user=self.request.user)
        ).distinct().order_by('created_at')

    def perform_create(self, serializer):
        thread = serializer.validated_data['thread']
        course = thread.course
        # Kiểm tra quyền thủ công
        is_auth = (course.owner == self.request.user) or \
                  (course.enrollments.filter(user=self.request.user).exists()) or \
                  (getattr(self.request.user, 'role', '') == 'admin')
        if not is_auth: raise PermissionDenied("Bạn không thể bình luận.")
        serializer.save(author=self.request.user)
class NotificationViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = NotificationSerializer
    permission_classes = [permissions.IsAuthenticated]
    queryset = Notification.objects.all().order_by('-created_at')
    
    def get_queryset(self): 
        return Notification.objects.filter(recipient=self.request.user)
    
    @action(detail=True, methods=['post'])
    def mark_as_read(self, request, pk=None):
        n = self.get_object()
        n.is_read = True
        n.save()
        return Response({"status": "ok"})
    
    # 👇 QUAN TRỌNG: Action này xử lý nút "Đọc tất cả"
    @action(detail=False, methods=['post'])
    def mark_all_read(self, request):
        Notification.objects.filter(recipient=request.user, is_read=False).update(is_read=True)
        return Response({"status": "ok"})
class AttendanceSessionViewSet(viewsets.ModelViewSet):
    serializer_class = AttendanceSessionSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {"course": ["exact"]}

    def get_queryset(self):
        return AttendanceSession.objects.all().order_by('-date')

    def perform_create(self, serializer):
        session = serializer.save()
        course = session.course
        # Tự động tạo record 'Vắng' cho tất cả học sinh trong lớp
        students = course.enrollments.filter(role='student').values_list('user', flat=True)
        records = [AttendanceRecord(session=session, student_id=uid, status='absent') for uid in students]
        AttendanceRecord.objects.bulk_create(records)

    @action(detail=True, methods=['post'])
    def update_records(self, request, pk=None):
        """Giáo viên gửi list điểm danh lên để cập nhật"""
        session = self.get_object()
        data = request.data.get('records', []) 
        
        for item in data:
            AttendanceRecord.objects.filter(session=session, student_id=item['student_id']).update(status=item['status'])
            
        return Response({"status": "updated"})