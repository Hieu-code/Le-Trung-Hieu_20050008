// src/pages/student/StudentDashboard.jsx
import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { getMe, listAssignments, listCourses } from "../../api/api";

export default function StudentDashboard() {
  const navigate = useNavigate();
  const [assignments, setAssignments] = useState([]);
  const [courses, setCourses] = useState([]);
  const [me, setMe] = useState(null);

  useEffect(() => {
    async function load() {
      try {
        const [u, asg, crs] = await Promise.all([
            getMe(),
            listAssignments({}), 
            listCourses({ mine: true })
        ]);
        setMe(u);
        setAssignments(asg?.results || asg || []);
        setCourses(crs?.results || crs || []);
      } catch (e) {
        console.error(e);
      }
    }
    load();
  }, []);

  return (
    <div className="space-y-8 max-w-6xl mx-auto py-6">
      <header>
        <h1 className="text-2xl font-bold">Xin chào, {me?.last_name || "Bạn"}! 👋</h1>
        <p className="text-gray-500">Hôm nay bạn muốn học gì?</p>
      </header>

      {/* Bài tập cần làm */}
      <section>
        <div className="flex items-center justify-between mb-4">
             <h2 className="text-xl font-bold text-gray-800">Bài tập sắp đến hạn</h2>
             <button onClick={() => navigate("/assignments")} className="text-blue-600 text-sm hover:underline">Xem tất cả</button>
        </div>
        
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
           {assignments.slice(0, 6).map(a => (
               <div key={a.id} className="bg-white p-4 rounded-xl border hover:shadow-md transition cursor-pointer" onClick={() => navigate(`/assignments/${a.id}`)}>
                   {/* 🔹 SỬA LỖI: onClick ở trên đã điều hướng đúng ID */}
                   <div className="text-xs font-bold text-gray-400 uppercase mb-1">{a.course_title || "Khoá học"}</div>
                   <h3 className="font-bold text-gray-900 mb-2 line-clamp-1">{a.title}</h3>
                   <div className="text-sm text-gray-500 flex items-center gap-1">
                       📅 Hạn: {a.due_at ? new Date(a.due_at).toLocaleDateString('vi-VN') : "Không giới hạn"}
                   </div>
               </div>
           ))}
           {assignments.length === 0 && (
               <div className="col-span-full p-8 text-center border-2 border-dashed rounded-xl text-gray-400">
                   Không có bài tập nào cần làm. Tuyệt vời!
               </div>
           )}
        </div>
      </section>

      {/* Khoá học của tôi */}
      <section>
        <h2 className="text-xl font-bold text-gray-800 mb-4">Khoá học của tôi</h2>
        <div className="grid md:grid-cols-3 gap-4">
            {courses.map(c => (
                <div key={c.id} onClick={() => navigate(`/courses/${c.id}`)} className="bg-gradient-to-br from-blue-500 to-indigo-600 p-4 rounded-xl text-white cursor-pointer hover:opacity-90 transition h-32 flex flex-col justify-between relative overflow-hidden">
                    <h3 className="font-bold text-lg z-10">{c.title}</h3>
                    <span className="text-xs text-blue-100 z-10">{c.code}</span>
                    <div className="absolute -bottom-2 -right-2 text-8xl opacity-10">📚</div>
                </div>
            ))}
        </div>
      </section>
    </div>
  );
}