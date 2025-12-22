// src/pages/Logout.jsx
import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../store/auth"; // ✅ Dùng useAuth thay vì api trực tiếp

export default function Logout() {
  const { logout } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    // Gọi hàm logout từ context
    logout();
    // Chuyển hướng
    navigate("/login");
  }, [logout, navigate]);

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-50">
      <div className="text-gray-500 font-medium">Đang đăng xuất...</div>
    </div>
  );
}