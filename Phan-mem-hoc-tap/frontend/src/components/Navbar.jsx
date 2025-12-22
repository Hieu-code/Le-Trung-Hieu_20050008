// src/components/Navbar.jsx
import React from "react";
import { Link, NavLink, useLocation } from "react-router-dom";
import { useAuth } from "../store/auth.js";
import NotificationBell from "./NotificationBell.jsx"; // 🔹 ĐÃ THÊM DÒNG NÀY

export default function Navbar() {
  const { user, logout } = useAuth();
  const location = useLocation();

  const role = user?.role?.toLowerCase?.() || "";

  // 🔹 menu cơ bản
  const baseNavItems = [
    { to: "/dashboard", label: "Tổng quan" },
    { to: "/courses", label: "Khoá học" },
    { to: "/assignments", label: "Bài tập" },
    { to: "/quizzes", label: "Quizzes" },
    { to: "/materials", label: "Tài liệu" },
    { to: "/schedule", label: "Lịch học" },
  ];

  // 🔹 nếu là admin → thêm mục quản lý người dùng
  const navItems =
    role === "admin"
      ? [...baseNavItems, { to: "/admin/users", label: "Người dùng" }]
      : baseNavItems;

  const initials = React.useMemo(() => {
    if (!user) return "?";
    const name = user.full_name || user.username || user.email || "";
    const parts = name.split(" ").filter(Boolean);
    if (parts.length === 0) return name.charAt(0).toUpperCase();
    if (parts.length === 1) return parts[0].charAt(0).toUpperCase();
    return (
      parts[0].charAt(0).toUpperCase() +
      parts[parts.length - 1].charAt(0).toUpperCase()
    );
  }, [user]);

  return (
    <header className="sticky top-0 z-10 border-b border-gray-200 bg-white/80 backdrop-blur">
      <div className="mx-auto max-w-6xl px-4 py-2.5 flex items-center justify-between gap-3">
        {/* Logo */}
        <Link to="/" className="text-lg font-bold text-gray-900">
          MiniLMS
        </Link>

        {/* Nav (desktop) */}
        <nav className="hidden md:flex md:items-center md:gap-1">
          {user &&
            navItems.map((item) => {
              const active = location.pathname.startsWith(item.to);
              return (
                <NavLink
                  key={item.to}
                  to={item.to}
                  className={
                    "rounded-full px-3 py-1.5 text-sm font-medium transition-colors " +
                    (active
                      ? "bg-gray-900 text-white"
                      : "text-gray-600 hover:bg-gray-100 hover:text-gray-900")
                  }
                >
                  {item.label}
                </NavLink>
              );
            })}
        </nav>

        {/* User menu (Right) */}
        <div className="flex-shrink-0">
          {user ? (
            <div className="flex items-center gap-2">
              <NotificationBell /> {/* 🔹 ĐÃ THÊM DÒNG NÀY */}

              <Link
                to="/profile"
                className="flex items-center gap-2 text-sm font-medium text-gray-700"
              >
                <span className="inline-flex h-7 w-7 items-center justify-center rounded-full bg-gray-200 text-xs font-semibold text-gray-600">
                  {initials}
                </span>
                <span className="hidden md:inline">
                  {user.email || user.username}
                </span>
              </Link>
              <button
                onClick={logout}
                className="rounded-full border border-gray-200 px-3 py-1.5 text-xs font-medium text-gray-700 hover:bg-gray-100 hidden md:inline-flex"
              >
                Đăng xuất
              </button>
            </div>
          ) : (
            <div className="flex items-center gap-2 text-xs">
              <Link
                to="/login"
                className="rounded-full border border-gray-200 px-3 py-1.5 font-medium text-gray-700 hover:bg-gray-100"
              >
                Đăng nhập
              </Link>
              <Link
                to="/register"
                className="rounded-full bg-blue-600 px-3 py-1.5 font-medium text-white hover:bg-blue-700"
              >
                Đăng ký
              </Link>
            </div>
          )}
        </div>
      </div>

      {/* Nav mobile đơn giản */}
      <nav className="border-t border-gray-200 bg-white px-2 py-2 text-xs md:hidden">
        <div className="flex flex-wrap gap-1">
          {navItems.map((item) => {
            const active = location.pathname.startsWith(item.to);
            return (
              <NavLink
                key={item.to}
                to={item.to}
                className={
                  "rounded-full px-3 py-1 font-medium transition-colors " +
                  (active
                    ? "bg-gray-900 text-white"
                    : "text-gray-600 hover:bg-gray-100")
                }
              >
                {item.label}
              </NavLink>
            );
          })}
        </div>
      </nav>
    </header>
  );
}