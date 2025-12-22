# apps/users/views_auth.py
import os
import requests

from django.conf import settings
from django.shortcuts import redirect
from django.contrib.auth import authenticate, get_user_model
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt

from rest_framework import generics, permissions
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework_simplejwt.tokens import RefreshToken

User = get_user_model()

# =========================
# Helpers
# =========================
def _jwt_for_user(user):
    refresh = RefreshToken.for_user(user)
    return str(refresh.access_token), str(refresh)

# =========================
# Health / Ping
# =========================
@api_view(["GET"])
@permission_classes([permissions.AllowAny])
def ping(_request):
    return Response({"ok": True}, status=200)

# =========================
# Register
# =========================
@method_decorator(csrf_exempt, name="dispatch")
class RegisterView(generics.CreateAPIView):
    permission_classes = [permissions.AllowAny]
    authentication_classes = []
    serializer_class = None

    def get_serializer_class(self):
        from .serializers import RegisterSerializer
        return RegisterSerializer

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        email = (data.get("email") or "").strip().lower()
        if email and not data.get("username"):
            data["username"] = email
        if not data.get("password"):
            p1 = data.get("password1") or data.get("password2")
            if p1:
                data["password"] = p1

        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        access, refresh = _jwt_for_user(user)
        return Response(
            {
                "user": {
                    "id": user.id,
                    "email": user.email,
                    "username": user.username,
                    "role": user.role,
                },
                "access": access,
                "refresh": refresh,
            },
            status=201,
        )

# =========================
# Login (email/password -> JWT)
# =========================
@method_decorator(csrf_exempt, name="dispatch")
class LoginView(APIView):
    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def post(self, request):
        email = (request.data.get("email") or "").strip().lower()
        password = request.data.get("password")
        if not email or not password:
            return Response({"detail": "Email & password required."}, status=400)

        # authenticate expects username; nếu username==email thì OK
        user = authenticate(request, username=email, password=password)
        if not user:
            # Fallback khi username khác email
            obj = User.objects.filter(email__iexact=email).first()
            if obj:
                user = authenticate(request, username=obj.username, password=password)
        if not user:
            return Response({"detail": "Sai thông tin đăng nhập."}, status=401)

        access, refresh = _jwt_for_user(user)
        return Response(
            {
                "user": {
                    "id": user.id,
                    "email": user.email,
                    "username": user.username,
                    "role": user.role,
                },
                "access": access,
                "refresh": refresh,
            },
            status=200,
        )

# =========================
# Google OAuth (Authorization Code) - Redirect về FE
# =========================
class GoogleOAuthRedirectView(APIView):
    """
    FE mở trang Google OAuth -> Google redirect về đây kèm ?code=...
    BE đổi code -> token, lấy userinfo, tạo/đăng nhập user,
    sinh JWT và redirect về FE (fragment #access=...&refresh=...).
    """

    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def get(self, request):
        code = request.query_params.get("code")
        if not code:
            return Response({"error": "Thiếu 'code' từ Google OAuth"}, status=400)

        client_id = getattr(settings, "GOOGLE_CLIENT_ID", None)
        client_secret = getattr(settings, "GOOGLE_CLIENT_SECRET", None)
        redirect_uri = getattr(settings, "GOOGLE_REDIRECT_URI", None)
        frontend_redirect = os.getenv("FRONTEND_REDIRECT_URL", "http://localhost:5173/auth/callback")

        if not all([client_id, client_secret, redirect_uri]):
            return Response(
                {"error": "Thiếu GOOGLE_CLIENT_ID/SECRET/REDIRECT_URI trong settings/.env"},
                status=500,
            )

        # 1) Đổi code -> tokens
        token_url = "https://oauth2.googleapis.com/token"
        data = {
            "code": code,
            "client_id": client_id,
            "client_secret": client_secret,
            "redirect_uri": redirect_uri,
            "grant_type": "authorization_code",
        }
        tok = requests.post(token_url, data=data, timeout=10)
        if tok.status_code != 200:
            return Response({"error": "Đổi code lấy token thất bại", "detail": tok.text}, status=400)
        tokens = tok.json()
        access_token = tokens.get("access_token")

        # 2) Lấy userinfo
        ui = requests.get(
            "https://www.googleapis.com/oauth2/v2/userinfo",
            headers={"Authorization": f"Bearer {access_token}"},
            timeout=10,
        )
        if ui.status_code != 200:
            return Response({"error": "Không lấy được thông tin người dùng từ Google"}, status=400)
        u = ui.json()
        email = (u.get("email") or "").strip().lower()
        name = u.get("name") or (email.split("@")[0] if email else "")
        if not email:
            return Response({"error": "Không có email từ Google"}, status=400)

        # 3) Tạo/đăng nhập user (mặc định role=student nếu chưa có)
        user, _created = User.objects.get_or_create(
            email=email,
            defaults={"username": name or email, "role": "student"},
        )
        # Đồng bộ username một lần nếu rỗng
        if not user.username and name:
            user.username = name
            user.save(update_fields=["username"])

        # 4) Tạo JWT
        access, refresh = _jwt_for_user(user)

        # 5) Redirect về FE và nhúng token vào fragment
        redirect_url = (
            f"{frontend_redirect}#access={access}&refresh={refresh}"
            f"&email={email}&username={name}"
        )
        return redirect(redirect_url)

# =========================
# Logout (blacklist refresh)
# =========================
@method_decorator(csrf_exempt, name="dispatch")
class LogoutView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        refresh_token = request.data.get("refresh")
        if not refresh_token:
            return Response({"detail": "Thiếu refresh token"}, status=400)
        try:
            token = RefreshToken(refresh_token)
            try:
                token.blacklist()
            except Exception:
                # Nếu chưa bật app token_blacklist, bỏ qua không crash
                pass
            return Response({"detail": "Đăng xuất thành công"}, status=205)
        except Exception:
            return Response({"detail": "Token không hợp lệ"}, status=400)

# =========================
# Current user
# =========================
class UserDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        return Response(
            {"id": request.user.id, "email": request.user.email, "role": request.user.role}
        )

# =========================
# Admin set role
# =========================
@api_view(["POST"])
@permission_classes([permissions.IsAdminUser])
def set_user_role(request, pk):
    user = User.objects.filter(pk=pk).first()
    if not user:
        return Response({"error": "User không tồn tại"}, status=404)
    role = (request.data.get("role") or "").strip().lower()
    if role not in {"admin", "teacher", "student"}:
        return Response({"error": "role phải là admin/teacher/student"}, status=400)
    user.role = role
    user.save(update_fields=["role"])
    return Response({"message": f"User {user.email} -> {role}"}, status=200)
