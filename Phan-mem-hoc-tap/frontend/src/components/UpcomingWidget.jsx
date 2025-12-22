import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import api from "../api/api";

export default function UpcomingWidget({ courseId }) {
  const [assignments, setAssignments] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchDeadlines = async () => {
      try {
        const res = await api.get("assignments/", { params: { course: courseId } });
        const all = res.data?.results || res.data || [];
        const now = new Date();
        
        // Lấy bài chưa hết hạn
        const upcoming = all
          .filter(a => a.due_at && new Date(a.due_at) > now)
          .sort((a, b) => new Date(a.due_at) - new Date(b.due_at))
          .slice(0, 3);

        setAssignments(upcoming);
      } catch (e) { console.error(e); } 
      finally { setLoading(false); }
    };

    if (courseId) fetchDeadlines();
  }, [courseId]);

  if (loading) return <div className="h-24 bg-gray-50 rounded-lg animate-pulse"></div>;

  return (
    <div className="bg-white p-4 rounded-xl border border-gray-200 shadow-sm">
      <h3 className="text-sm font-semibold text-gray-600 mb-4 flex items-center gap-2">
          ⏰ Sắp đến hạn
      </h3>
      
      {assignments.length === 0 ? (
        <div className="text-gray-400 text-sm mb-4 italic text-center py-2">
            Không có bài tập nào sắp đến hạn.
        </div>
      ) : (
        <ul className="space-y-3 mb-3">
          {assignments.map(a => (
            <li key={a.id}>
              {/* 👇 ĐÃ SỬA: Link trỏ thẳng về trang chi tiết bài tập (/assignments/ID) */}
              <Link to={`/assignments/${a.id}`} className="block group bg-gray-50 hover:bg-blue-50 p-2 rounded-lg transition border border-transparent hover:border-blue-100">
                <div className="text-sm font-medium text-gray-800 group-hover:text-blue-600 truncate">
                    {a.title}
                </div>
                <div className="text-xs text-red-500 mt-1 font-medium">
                    Hạn: {new Date(a.due_at).toLocaleTimeString("vi-VN", {hour:'2-digit', minute:'2-digit'})} - {new Date(a.due_at).toLocaleDateString("vi-VN")}
                </div>
              </Link>
            </li>
          ))}
        </ul>
      )}
      
      <div className="text-right pt-2 border-t border-gray-100">
        {/* Link này vẫn trỏ về tab danh sách bài tập */}
        <Link to="?tab=assignments" className="text-xs font-bold text-blue-600 hover:underline uppercase">
            Xem tất cả
        </Link>
      </div>
    </div>
  );
}