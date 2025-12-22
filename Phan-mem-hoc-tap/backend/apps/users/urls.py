# apps/users/urls.py
from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views_auth import (
    ping,
    RegisterView,
    LoginView,
    LogoutView,
    UserDetailView,
    GoogleOAuthRedirectView,  # View xử lý redirect về FE
    set_user_role,
)

urlpatterns = [
    path("ping/", ping, name="ping"),
    path("register/", RegisterView.as_view(), name="register"),
    path("login/", LoginView.as_view(), name="login"),
    path("logout/", LogoutView.as_view(), name="logout"),
    path("me/", UserDetailView.as_view(), name="me"),

    # Google OAuth redirect endpoint (BE -> FE fragment tokens)
    path("google/", GoogleOAuthRedirectView.as_view(), name="google_oauth_redirect"),

    # Admin set role
    path("set-role/<int:pk>/", set_user_role, name="set-user-role"),

    # JWT (tùy chọn nếu FE cần)
    path("token/", TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
]
