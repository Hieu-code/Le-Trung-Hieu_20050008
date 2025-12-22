// src/pages/Dashboard.jsx
import React from "react";
import { Link } from "react-router-dom";
import { useAuth } from "../store/auth";

export default function Dashboard() {
  const { user } = useAuth();
  const role = user?.role?.toLowerCase?.() || "guest";

  return (
    <div className="space-y-6">
      <header className="flex flex-col gap-2 md:flex-row md:items-center md:justify-between">
        <div>
          <h1 className="text-2xl font-semibold">Bảng điều khiển</h1>
          <p className="text-sm text-gray-500">
            Xin chào{" "}
            <span className="font-medium text-gray-800">
              {user?.full_name || user?.username || user?.email || "bạn"}
            </span>
            {", "}
            bạn đang đăng nhập với vai trò{" "}
            <span className="font-semibold text-gray-800">
              {role}
            </span>
            .
          </p>
        </div>
      </header>

      <div className="grid gap-4 md:grid-cols-3">
        {/* Góc giáo viên */}
        {(role === "teacher" || role === "admin") && (
          <Link
            to="/teacher/dashboard"
            className="border rounded-2xl p-4 bg-white shadow-sm hover:shadow-md transition flex flex-col justify-between"
          >
            <div>
              <div className="text-xs font-semibold uppercase tracking-wide text-blue-500">
                Giáo viên
              </div>
              <div className="mt-1 text-lg font-semibold">
                Bảng điều khiển Giáo viên
              </div>
              <div className="text-gray-500 text-sm mt-1">
                Quản lý khoá học, bài giảng, bài tập và bài kiểm tra.
              </div>
            </div>
            <div className="mt-3 text-xs text-blue-600 font-medium">
              Vào góc giáo viên →
            </div>
          </Link>
        )}

        {/* Góc học sinh */}
        {(role === "student" || role === "admin") && (
          <Link
            to="/student/dashboard"
            className="border rounded-2xl p-4 bg-white shadow-sm hover:shadow-md transition flex flex-col justify-between"
          >
            <div>
              <div className="text-xs font-semibold uppercase tracking-wide text-emerald-500">
                Học sinh
              </div>
              <div className="mt-1 text-lg font-semibold">
                Bảng điều khiển Học sinh
              </div>
              <div className="text-gray-500 text-sm mt-1">
                Xem lịch học, tiến độ, bài tập và bài kiểm tra.
              </div>
            </div>
            <div className="mt-3 text-xs text-emerald-600 font-medium">
              Vào góc học sinh →
            </div>
          </Link>
        )}

        {/* Admin: quản trị hệ thống */}
        {role === "admin" && (
          <Link
            to="/admin/users"
            className="border rounded-2xl p-4 bg-white shadow-sm hover:shadow-md transition flex flex-col justify-between"
          >
            <div>
              <div className="text-xs font-semibold uppercase tracking-wide text-rose-500">
                Quản trị
              </div>
              <div className="mt-1 text-lg font-semibold">
                Quản lý người dùng
              </div>
              <div className="text-gray-500 text-sm mt-1">
                Xem danh sách tài khoản, phân quyền giáo viên và học sinh.
              </div>
            </div>
            <div className="mt-3 text-xs text-rose-600 font-medium">
              Mở trang quản trị →
            </div>
          </Link>
        )}

        {/* Lịch học & thi – dùng cho mọi role đã đăng nhập */}
        <Link
          to="/schedule"
          className="border rounded-2xl p-4 bg-white shadow-sm hover:shadow-md transition flex flex-col justify-between"
        >
          <div>
            <div className="text-xs font-semibold uppercase tracking-wide text-indigo-500">
              Lịch
            </div>
            <div className="mt-1 text-lg font-semibold">
              Lịch học & Lịch kiểm tra
            </div>
            <div className="text-gray-500 text-sm mt-1">
              Xem toàn bộ lịch dạy, lịch học và hạn bài tập trên calendar.
            </div>
          </div>
          <div className="mt-3 text-xs text-indigo-600 font-medium">
            Xem lịch →
          </div>
        </Link>
      </div>
    </div>
  );
}
