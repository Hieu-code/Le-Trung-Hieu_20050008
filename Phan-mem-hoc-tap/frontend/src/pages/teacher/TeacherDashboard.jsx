// src/pages/teacher/TeacherDashboard.jsx
import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import {
  getMe,
  listAssignments,
  listQuizzes,
  listMaterials,
} from "../../api/api";
import Button from "../../components/Button.jsx";

export default function TeacherDashboard() {
  const navigate = useNavigate();
  const [assignments, setAssignments] = useState([]);
  const [quizzes, setQuizzes] = useState([]);
  const [materials, setMaterials] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function boot() {
      try {
        const [asg, quiz, mat] = await Promise.all([
          listAssignments({ limit: 5 }),
          listQuizzes({ limit: 5 }),
          listMaterials({ limit: 5 }),
        ]);
        setAssignments(asg?.results || asg || []);
        setQuizzes(quiz?.results || quiz || []);
        setMaterials(mat?.results || mat || []);
      } catch (e) {
        console.error(e);
      } finally {
        setLoading(false);
      }
    }
    boot();
  }, []);

  if (loading) return <div className="p-6">Đang tải dữ liệu...</div>;

  return (
    <div className="space-y-8">
      <h1 className="text-2xl font-bold">Tổng quan Giáo viên</h1>
      
      <div className="grid md:grid-cols-2 gap-6">
        {/* Bài tập gần đây */}
        <div className="bg-white p-4 rounded-xl border shadow-sm">
          <h2 className="font-bold mb-4 flex justify-between items-center">
            Bài tập mới giao
            <Button size="sm" variant="ghost" onClick={() => navigate("/assignments")}>Tất cả</Button>
          </h2>
          <ul className="space-y-3">
            {assignments.map(a => (
              <li key={a.id} className="flex justify-between items-center p-2 hover:bg-gray-50 rounded-lg border">
                <div>
                  <div className="font-medium">{a.title}</div>
                  <div className="text-xs text-gray-500">Hạn: {a.due_at || "Không có"}</div>
                </div>
                {/* 🔹 SỬA LỖI: Điều hướng đúng ID */}
                <Button size="sm" onClick={() => navigate(`/assignments/${a.id}`)}>
                  Chấm bài
                </Button>
              </li>
            ))}
            {assignments.length === 0 && <p className="text-sm text-gray-500">Chưa có bài tập nào.</p>}
          </ul>
        </div>

        {/* Bài kiểm tra */}
        <div className="bg-white p-4 rounded-xl border shadow-sm">
          <h2 className="font-bold mb-4 flex justify-between items-center">
            Bài kiểm tra
            <Button size="sm" variant="ghost" onClick={() => navigate("/quizzes")}>Tất cả</Button>
          </h2>
          <ul className="space-y-3">
            {quizzes.map(q => (
              <li key={q.id} className="flex justify-between items-center p-2 hover:bg-gray-50 rounded-lg border">
                <span className="font-medium">{q.title}</span>
                {/* 🔹 SỬA LỖI: Điều hướng đúng ID */}
                <Button size="sm" onClick={() => navigate(`/quizzes/${q.id}`)}>
                  Quản lý
                </Button>
              </li>
            ))}
             {quizzes.length === 0 && <p className="text-sm text-gray-500">Chưa có bài kiểm tra nào.</p>}
          </ul>
        </div>
      </div>
    </div>
  );
}