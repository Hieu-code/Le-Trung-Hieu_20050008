import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom"; // Nhớ thêm Navigate
import DashboardLayout from "../layouts/DashboardLayout.jsx";
import ProtectedRoute from "../components/ProtectedRoute.jsx";

// Public Pages
import Login from "../pages/Login.jsx";
import Register from "../pages/Register.jsx";
import Logout from "../pages/Logout.jsx";
import AuthCallbackHash from "../pages/AuthCallbackHash.jsx";

// Core Pages
import Dashboard from "../pages/Dashboard.jsx";
import Courses from "../pages/Courses.jsx";
import CourseDetail from "../pages/CourseDetail.jsx";
import CourseAnalytics from "../pages/CourseAnalytics.jsx";
import Assignments from "../pages/Assignments.jsx";
import AssignmentCreate from "../pages/AssignmentCreate.jsx";
import AssignmentDetail from "../pages/AssignmentDetail.jsx";
import Quizzes from "../pages/Quizzes.jsx";
import QuizCreate from "../pages/QuizCreate.jsx";
import QuizDetail from "../pages/QuizDetail.jsx";
import QuizAttemptForm from "../pages/QuizAttemptForm.jsx";
import ScheduleCalendar from "../pages/ScheduleCalendar.jsx";
import Profile from "../pages/Profile.jsx";
import Users from "../pages/Users.jsx";
import Materials from "../pages/Materials.jsx";
import TeacherDashboard from "../pages/teacher/TeacherDashboard.jsx";
import StudentDashboard from "../pages/student/StudentDashboard.jsx";

export default function AppRouter() {
  return (
    <Router>
      <Routes>
        {/* 👇 THAY ĐỔI Ở ĐÂY: Vào trang chủ "/" tự động nhảy sang "/login" */}
        <Route path="/" element={<Navigate to="/login" replace />} />

        {/* Public Routes */}
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/auth/callback" element={<AuthCallbackHash />} />
        <Route path="/logout" element={<Logout />} />

        {/* Protected Routes (Phần này giữ nguyên) */}
        <Route element={<ProtectedRoute><DashboardLayout /></ProtectedRoute>}>
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/teacher/dashboard" element={<TeacherDashboard />} />
            <Route path="/student/dashboard" element={<StudentDashboard />} />
            
            <Route path="/courses" element={<Courses />} />
            <Route path="/courses/:courseId" element={<CourseDetail />} />
            <Route path="/courses/:courseId/analytics" element={<CourseAnalytics />} />

            <Route path="/assignments" element={<Assignments />} />
            <Route path="/assignments/create" element={<AssignmentCreate />} />
            <Route path="/assignments/:assignmentId" element={<AssignmentDetail />} />

            <Route path="/quizzes" element={<Quizzes />} />
            <Route path="/quizzes/create" element={<QuizCreate />} />
            <Route path="/quizzes/:quizId" element={<QuizDetail />} />
            <Route path="/quizzes/:quizId/attempt" element={<QuizAttemptForm />} />

            <Route path="/materials" element={<Materials />} />
            <Route path="/schedule" element={<ScheduleCalendar />} />
            <Route path="/profile" element={<Profile />} />
            <Route path="/admin/users" element={<Users />} />
        </Route>

        {/* Nếu gõ link linh tinh thì về dashboard (hoặc login nếu chưa đăng nhập) */}
        <Route path="*" element={<Navigate to="/dashboard" replace />} />
      </Routes>
    </Router>
  );
}