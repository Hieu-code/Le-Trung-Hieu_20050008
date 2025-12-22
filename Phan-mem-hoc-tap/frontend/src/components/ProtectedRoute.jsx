import React from "react";
import { Navigate, useLocation } from "react-router-dom";
import { useAuth } from "../store/auth";
import Spinner from "./Spinner.jsx";

export default function ProtectedRoute({ children, requireRoles = [] }) {
  const { user, initializing } = useAuth();
  const location = useLocation();

  // 1. Đang tải thông tin user? -> Hiện Loading, ĐỪNG redirect vội
  if (initializing) {
    return (
      <div className="flex h-screen w-full items-center justify-center bg-gray-50">
        <div className="text-center">
            <Spinner label="Đang kiểm tra đăng nhập..." />
        </div>
      </div>
    );
  }

  // 2. Tải xong mà không có user -> Về Login
  if (!user) {
    return <Navigate to="/login" replace state={{ from: location }} />;
  }

  // 3. Check quyền (nếu cần)
  if (requireRoles.length > 0) {
    const role = (user.role || "").toLowerCase();
    if (role !== 'admin' && !requireRoles.includes(role)) {
       // Sai quyền -> Về dashboard thay vì Home
       return <Navigate to="/dashboard" replace />;
    }
  }

  return children;
}