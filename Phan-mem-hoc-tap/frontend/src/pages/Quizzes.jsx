// src/pages/Quizzes.jsx
import React, { useEffect, useMemo, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { listQuizzes, deleteQuiz, getMe } from "../api/api";
import Spinner from "../components/Spinner";
import Button from "../components/Button";

export default function Quizzes() {
  const navigate = useNavigate();
  const [quizzes, setQuizzes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [me, setMe] = useState(null);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    setLoading(true);
    try {
        const [u, q] = await Promise.all([getMe(), listQuizzes({})]);
        setMe(u);
        setQuizzes(q?.results || q || []);
    } catch(e) {
        console.error(e);
    } finally {
        setLoading(false);
    }
  };

  const isTeacherLike = useMemo(() => {
    const role = (me?.role || "").toLowerCase();
    return role === "teacher" || role === "admin";
  }, [me]);

  const handleDelete = async (e, id) => {
    e.preventDefault(); // Chặn link click
    if(!confirm("Bạn chắc chắn muốn xóa bài kiểm tra này?")) return;
    try {
        await deleteQuiz(id);
        loadData();
    } catch(err) {
        alert("Lỗi xóa quiz");
    }
  };

  if (loading) return <div className="p-10"><Spinner label="Đang tải bài kiểm tra..." /></div>;

  return (
    <div className="max-w-5xl mx-auto space-y-6 pb-10">
      <div className="flex justify-between items-center">
        <div>
            <h1 className="text-2xl font-bold text-gray-900">Bài kiểm tra</h1>
            <p className="text-sm text-gray-500">Danh sách các bài trắc nghiệm trực tuyến</p>
        </div>
        {isTeacherLike && (
            <Button onClick={() => navigate("/quizzes/create")} className="bg-purple-600 hover:bg-purple-700 text-white shadow-lg">
                + Tạo đề thi mới
            </Button>
        )}
      </div>

      {quizzes.length === 0 ? (
        <div className="p-12 text-center bg-white rounded-2xl border border-dashed border-gray-300">
            <div className="text-4xl mb-3">📝</div>
            <p className="text-gray-500 font-medium">Chưa có bài kiểm tra nào.</p>
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {quizzes.map(q => (
                <Link 
                    to={isTeacherLike ? `/quizzes/${q.id}` : `/quizzes/${q.id}/attempt`} 
                    key={q.id} 
                    className="block group relative"
                >
                    <div className="bg-white p-5 rounded-xl border shadow-sm hover:shadow-lg hover:-translate-y-1 transition-all h-full flex flex-col">
                        {isTeacherLike && (
                            <button 
                                onClick={(e) => handleDelete(e, q.id)}
                                className="absolute top-3 right-3 text-gray-300 hover:text-red-500 p-1 z-10"
                            >
                                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                            </button>
                        )}
                        
                        <div className="mb-3">
                            <span className={`text-[10px] font-bold px-2 py-1 rounded uppercase tracking-wide ${
                                q.is_published ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'
                            }`}>
                                {q.is_published ? "Đang mở" : "Nháp"}
                            </span>
                        </div>
                        
                        <h3 className="font-bold text-lg text-gray-900 mb-2 line-clamp-1 group-hover:text-purple-600 transition-colors">
                            {q.title}
                        </h3>
                        <p className="text-sm text-gray-500 line-clamp-2 mb-4 flex-1">
                            {q.description || "Không có mô tả."}
                        </p>

                        <div className="pt-3 border-t text-center">
                            <span className="text-sm font-medium text-purple-600">
                                {isTeacherLike ? "⚙️ Quản lý câu hỏi" : "✍️ Làm bài ngay"}
                            </span>
                        </div>
                    </div>
                </Link>
            ))}
        </div>
      )}
    </div>
  );
}