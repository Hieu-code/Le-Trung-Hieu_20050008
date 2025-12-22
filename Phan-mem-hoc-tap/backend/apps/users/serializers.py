# apps/users/serializers.py
from django.contrib.auth import get_user_model
from rest_framework import serializers

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "email", "username", "first_name", "last_name", "role", "avatar"]
        read_only_fields = ["id", "email", "username", "role"]

class RegisterSerializer(serializers.ModelSerializer):
    """
    Cho phép client gửi:
      - email (bắt buộc), username (tùy chọn, auto từ email nếu thiếu)
      - password hoặc (password1 + password2)
      - role: student/teacher (mặc định student)
    """
    role = serializers.ChoiceField(choices=[("student", "student"), ("teacher", "teacher")], required=False)
    password = serializers.CharField(write_only=True, required=False, min_length=6)
    password1 = serializers.CharField(write_only=True, required=False, min_length=6)
    password2 = serializers.CharField(write_only=True, required=False, min_length=6)

    class Meta:
        model = User
        fields = ["email", "username", "first_name", "last_name", "password", "password1", "password2", "role"]

    def validate(self, attrs):
        email = (attrs.get("email") or "").strip().lower()
        if not email:
            raise serializers.ValidationError({"email": "Email là bắt buộc"})
        attrs["email"] = email

        # Auto username từ email nếu thiếu
        if not attrs.get("username"):
            attrs["username"] = email

        # password / password1 + password2
        p = attrs.get("password")
        p1 = attrs.get("password1")
        p2 = attrs.get("password2")
        if not p:
            if not (p1 and p2):
                raise serializers.ValidationError({"password": "Thiếu mật khẩu hoặc xác nhận (password1/password2)."})
            if p1 != p2:
                raise serializers.ValidationError({"password": "Hai mật khẩu không khớp."})
            attrs["password"] = p1

        if len(attrs["password"]) < 6:
            raise serializers.ValidationError({"password": "Mật khẩu phải >= 6 ký tự."})

        # role
        role = (attrs.get("role") or "student").strip().lower()
        if role not in {"student", "teacher"}:
            role = "student"
        attrs["role"] = role

        # unique email
        if User.objects.filter(email__iexact=email).exists():
            raise serializers.ValidationError({"email": "Email đã được sử dụng"})
        return attrs

    def create(self, validated_data):
        password = validated_data.pop("password")
        validated_data.pop("password1", None)
        validated_data.pop("password2", None)
        user = User(**validated_data)
        user.set_password(password)
        user.save()
        return user
