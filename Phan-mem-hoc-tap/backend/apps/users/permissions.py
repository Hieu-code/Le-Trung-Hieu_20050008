from rest_framework import permissions

class IsAdmin(permissions.BasePermission):
    def has_permission(self, request, view):
        u = request.user
        return bool(u.is_authenticated and (u.is_superuser or getattr(u, "role", "") == "admin"))

class IsTeacher(permissions.BasePermission):
    def has_permission(self, request, view):
        u = request.user
        return bool(u.is_authenticated and (u.is_superuser or getattr(u, "role", "") == "teacher"))

class IsStudent(permissions.BasePermission):
    def has_permission(self, request, view):
        u = request.user
        # superuser cũng pass mọi thứ nếu bạn muốn, hoặc bỏ is_superuser ở đây
        return bool(u.is_authenticated and (u.is_superuser or getattr(u, "role", "") == "student"))

class IsTeacherOrAdmin(permissions.BasePermission):
    def has_permission(self, request, view):
        u = request.user
        role = getattr(u, "role", "")
        return bool(u.is_authenticated and (u.is_superuser or role in ["teacher", "admin"]))
