# backend/apps/lms/urls.py
from rest_framework.routers import DefaultRouter
from .viewsets import (
    CourseViewSet, SectionViewSet, LessonViewSet, MaterialViewSet,
    AssignmentViewSet, SubmissionViewSet,
    QuizViewSet, QuestionViewSet, ChoiceViewSet, EnrollmentViewSet,
    AnnouncementViewSet, CommentViewSet, ScheduleViewSet, ProgressViewSet,
    NotificationViewSet,DiscussionThreadViewSet,DiscussionPostViewSet,AttendanceSessionViewSet
)

router = DefaultRouter()
router.register(r"courses", CourseViewSet, basename="course")
router.register(r"sections", SectionViewSet, basename="section")
router.register(r"lessons", LessonViewSet, basename="lesson")
router.register(r"materials", MaterialViewSet, basename="material")
router.register(r"assignments", AssignmentViewSet, basename="assignment")
router.register(r"submissions", SubmissionViewSet, basename="submission")
router.register(r"quizzes", QuizViewSet, basename="quiz")
router.register(r"questions", QuestionViewSet, basename="question")
router.register(r"choices", ChoiceViewSet, basename="choice")
router.register(r"enrollments", EnrollmentViewSet, basename="enrollment")
router.register(r"announcements", AnnouncementViewSet, basename="announcement")
router.register(r"comments", CommentViewSet, basename="comment")
router.register(r"schedules", ScheduleViewSet, basename="schedule")
router.register(r"progress", ProgressViewSet, basename="progress")
router.register(r"notifications", NotificationViewSet, basename="notification")
router.register(r"discussions", DiscussionThreadViewSet, basename="discussion-thread")
router.register(r"posts", DiscussionPostViewSet, basename="discussion-post")
router.register(r"attendance", AttendanceSessionViewSet, basename="attendance")
urlpatterns = router.urls