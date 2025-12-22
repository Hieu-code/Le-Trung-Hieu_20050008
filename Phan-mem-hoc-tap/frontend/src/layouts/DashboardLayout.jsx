import React, { useState } from "react";
import { Outlet, Link, useLocation } from "react-router-dom";
import { useAuth } from "../store/auth";
import NotificationBell from "../components/NotificationBell";
import { 
  HomeIcon, BookOpenIcon, AcademicCapIcon, 
  ClipboardDocumentCheckIcon, CalendarDaysIcon, 
  FolderIcon, UsersIcon, Bars3Icon, XMarkIcon, ArrowRightOnRectangleIcon
} from "@heroicons/react/24/outline";

export default function DashboardLayout() {
  const { user, logout } = useAuth();
  const location = useLocation();
  const [sidebarOpen, setSidebarOpen] = useState(true);

  const role = user?.role?.toLowerCase() || "";

  // Menu cấu hình chuẩn với Icon xịn
  const menuItems = [
    { path: "/dashboard", label: "Tổng quan", icon: HomeIcon },
    { path: "/courses", label: "Lớp học", icon: BookOpenIcon },
    { path: "/assignments", label: "Bài tập", icon: ClipboardDocumentCheckIcon },
    { path: "/quizzes", label: "Bài kiểm tra", icon: AcademicCapIcon },
    { path: "/schedule", label: "Thời khóa biểu", icon: CalendarDaysIcon }, // Đã đổi tên
    { path: "/materials", label: "Tài liệu", icon: FolderIcon },
  ];

  if (role === "admin") {
    menuItems.push({ path: "/admin/users", label: "Quản lý User", icon: UsersIcon });
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col md:flex-row">
      
      {/* --- SIDEBAR --- */}
      <aside 
        className={`
          fixed inset-y-0 left-0 z-30 w-64 bg-white border-r border-gray-200 transform transition-transform duration-300 ease-in-out
          md:relative md:translate-x-0
          ${sidebarOpen ? "translate-x-0" : "-translate-x-full"}
        `}
      >
        {/* Logo Area */}
        <div className="h-16 flex items-center justify-center border-b border-gray-100">
          <Link to="/dashboard" className="text-2xl font-bold text-blue-600 flex items-center gap-2">
            <span>🎓</span> LMS Pro
          </Link>
        </div>

        {/* Navigation Links */}
        <nav className="p-4 space-y-1 overflow-y-auto h-[calc(100vh-4rem)]">
          <div className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2 px-4">Menu</div>
          {menuItems.map((item) => {
            const isActive = location.pathname.startsWith(item.path);
            const Icon = item.icon;
            return (
              <Link
                key={item.path}
                to={item.path}
                onClick={() => window.innerWidth < 768 && setSidebarOpen(false)} // Đóng menu trên mobile khi click
                className={`
                  flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all duration-200
                  ${isActive 
                    ? "bg-blue-50 text-blue-700 shadow-sm" 
                    : "text-gray-600 hover:bg-gray-50 hover:text-gray-900"}
                `}
              >
                <Icon className={`w-5 h-5 ${isActive ? "text-blue-600" : "text-gray-400"}`} />
                {item.label}
              </Link>
            );
          })}
        </nav>
      </aside>

      {/* --- MAIN CONTENT AREA --- */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
        
        {/* Top Header */}
        <header className="bg-white border-b border-gray-200 h-16 flex items-center justify-between px-4 sticky top-0 z-20 shadow-sm">
          <div className="flex items-center gap-4">
            <button 
              onClick={() => setSidebarOpen(!sidebarOpen)}
              className="p-2 rounded-lg text-gray-500 hover:bg-gray-100 focus:outline-none md:hidden"
            >
              {sidebarOpen ? <XMarkIcon className="w-6 h-6"/> : <Bars3Icon className="w-6 h-6"/>}
            </button>
            <h2 className="text-lg font-bold text-gray-800 hidden sm:block">
               {menuItems.find(i => location.pathname.startsWith(i.path))?.label || "Dashboard"}
            </h2>
          </div>

          <div className="flex items-center gap-4">
            <NotificationBell />
            
            <div className="h-8 w-px bg-gray-200 mx-1 hidden sm:block"></div>

            <div className="flex items-center gap-3">
              <div className="text-right hidden md:block">
                <p className="text-sm font-bold text-gray-700">{user?.last_name || "User"}</p>
                <p className="text-xs text-gray-500 capitalize">{user?.role || "Student"}</p>
              </div>
              <div className="w-9 h-9 rounded-full bg-blue-100 border border-blue-200 flex items-center justify-center text-blue-700 font-bold">
                {(user?.last_name || user?.email || "U")[0].toUpperCase()}
              </div>
              
              <button 
                onClick={logout} 
                title="Đăng xuất"
                className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-full transition"
              >
                <ArrowRightOnRectangleIcon className="w-5 h-5" />
              </button>
            </div>
          </div>
        </header>

        {/* Main Content Scrollable Area */}
        <main className="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 animate-fade-in">
          <Outlet />
        </main>
      </div>

      {/* Overlay cho Mobile khi menu mở */}
      {sidebarOpen && (
        <div 
          className="fixed inset-0 bg-black/20 z-20 md:hidden"
          onClick={() => setSidebarOpen(false)}
        ></div>
      )}
    </div>
  );
}