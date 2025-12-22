// src/pages/Assignments.jsx
import React, { useEffect, useMemo, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { listAssignments, getMe } from "../api/api";
import Spinner from "../components/Spinner.jsx";
import Button from "../components/Button.jsx";

export default function Assignments() {
  const navigate = useNavigate();
  const [assignments, setAssignments] = useState([]);
  const [loading, setLoading] = useState(true);
  const [me, setMe] = useState(null);

  useEffect(() => {
    async function load() {
      try {
        const [u, asg] = await Promise.all([
            getMe(),
            listAssignments({})
        ]);
        setMe(u);
        setAssignments(asg?.results || asg || []);
      } catch (e) {
        console.error(e);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  const isTeacherLike = useMemo(() => {
    const role = (me?.role || "").toLowerCase();
    return role === "teacher" || role === "admin";
  }, [me]);

  const formatTime = (t) => t ? new Date(t).toLocaleDateString('vi-VN') : "Không thời hạn";

  if (loading) return <div className="p-10"><Spinner label="Đang tải danh sách..." /></div>;

  return (
    <div className="max-w-5xl mx-auto space-y-6">
      <div className="flex justify-between items-center">
        <div>
            <h1 className="text-2xl font-bold text-gray-900">Bài tập</h1>
            <p className="text-sm text-gray-500">Tất cả bài tập trong các khóa học của bạn</p>
        </div>
        {isTeacherLike && (
            <Button onClick={() => navigate("/assignments/create")} className="shadow-lg">
                + Tạo bài tập mới
            </Button>
        )}
      </div>

      {assignments.length === 0 ? (
        <div className="p-12 text-center bg-white rounded-2xl border border-dashed border-gray-300">
            <div className="text-4xl mb-3">📂</div>
            <p className="text-gray-500 font-medium">Chưa có bài tập nào.</p>
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2">
            {assignments.map(a => (
                <Link to={`/assignments/${a.id}`} key={a.id} className="block group">
                    <div className="bg-white p-5 rounded-xl border shadow-sm hover:shadow-md hover:border-blue-300 transition-all h-full flex flex-col">
                        <div className="flex justify-between items-start mb-2">
                            <h3 className="font-bold text-lg text-gray-800 group-hover:text-blue-600 transition-colors line-clamp-1">
                                {a.title}
                            </h3>
                            <span className="text-xs bg-gray-100 px-2 py-1 rounded text-gray-600 whitespace-nowrap">
                                {a.max_score} điểm
                            </span>
                        </div>
                        <p className="text-sm text-gray-500 line-clamp-2 mb-4 flex-1">
                            {a.description || "Không có mô tả."}
                        </p>
                        <div className="pt-3 border-t flex items-center justify-between text-xs text-gray-500">
                            <span>📅 Hạn: {formatTime(a.due_at)}</span>
                            <span className="text-blue-600 font-medium group-hover:translate-x-1 transition-transform">
                                Xem chi tiết →
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