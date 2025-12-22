import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import api from "../api/api";

export default function AssignmentList({ courseId, isTeacher, me }) {
  const [assignments, setAssignments] = useState([]);
  const [submittedIds, setSubmittedIds] = useState(new Set()); 
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!courseId) return;
    
    const fetchAll = async () => {
      try {
        setLoading(true);
        const resAsg = await api.get("assignments/", { params: { course: courseId } });
        const dataAsg = resAsg.data?.results || resAsg.data || [];
        
        dataAsg.sort((a, b) => new Date(a.due_at || '2099-12-31') - new Date(b.due_at || '2099-12-31'));
        setAssignments(dataAsg);

        // Chỉ tải bài nộp nếu là HỌC SINH
        if (!isTeacher && me?.id) {
            const resSub = await api.get("submissions/", { params: { course: courseId } });
            const dataSub = resSub.data?.results || resSub.data || [];
            const mySubmissions = dataSub.filter(s => s.owner === me.id || s.owner?.id === me.id);
            setSubmittedIds(new Set(mySubmissions.map(s => s.assignment)));
        }
      } catch (e) { console.error(e); } 
      finally { setLoading(false); }
    };
    fetchAll();
  }, [courseId, isTeacher, me]);

  if (loading) return <div className="p-6 text-center text-gray-500">⏳ Đang tải...</div>;

  return (
    <div className="bg-white rounded-xl border shadow-sm overflow-hidden animate-fade-in">
      <div className="p-4 border-b bg-gray-50 flex justify-between items-center">
        <h3 className="font-bold text-gray-800 text-lg">
            {isTeacher ? "📋 Quản lý Bài tập" : "📝 Bài tập cần làm"}
        </h3>
        <span className="bg-blue-100 text-blue-800 text-xs font-bold px-2 py-1 rounded-full">
            {assignments.length} bài
        </span>
      </div>
      
      {assignments.length === 0 ? (
        <div className="p-10 text-center text-gray-500 flex flex-col items-center">
            <span className="text-4xl mb-2">🎉</span>
            {isTeacher ? "Bạn chưa giao bài tập nào." : "Tuyệt vời, không có bài tập nào!"}
        </div>
      ) : (
        <div className="divide-y divide-gray-100">
          {assignments.map(a => {
            const now = new Date();
            const dueDate = a.due_at ? new Date(a.due_at) : null;
            
            // --- LOGIC TRẠNG THÁI MỚI (Đã sửa) ---
            const isSubmitted = submittedIds.has(a.id);
            const isExpired = dueDate && dueDate < now; // Chỉ là hết hạn thôi

            return (
              <div key={a.id} className="p-4 hover:bg-blue-50 transition flex justify-between items-center group">
                <div className="flex-1 pr-4">
                  <div className="flex items-center gap-2 mb-1">
                      <span className="text-xl">{isTeacher ? "📂" : "✍️"}</span>
                      <Link to={`/assignments/${a.id}`} className="font-bold text-gray-800 text-base group-hover:text-blue-600">
                        {a.title}
                      </Link>
                      
                      {/* Badge cho Học sinh: Đã nộp */}
                      {!isTeacher && isSubmitted && (
                          <span className="bg-green-100 text-green-700 text-[10px] px-2 py-0.5 rounded-full font-bold border border-green-200">
                              ✅ Đã nộp
                          </span>
                      )}
                  </div>
                  <div className="text-sm text-gray-500 line-clamp-1">{a.description || "Không có mô tả."}</div>
                </div>
                
                <div className="text-right min-w-[160px] flex flex-col items-end gap-2">
                   {/* --- HIỂN THỊ HẠN NỘP (Khác nhau giữa GV và HS) --- */}
                   {dueDate ? (
                       isTeacher ? (
                           // GIÁO VIÊN: Chỉ hiện Hết hạn (Đỏ) hoặc Đang mở (Xanh)
                           <div className={`text-xs font-bold px-2 py-1 rounded border ${isExpired ? 'bg-gray-100 text-gray-500 border-gray-200' : 'bg-green-50 text-green-600 border-green-100'}`}>
                               {isExpired ? "🔒 Đã hết hạn:" : "🟢 Đang mở:"} {dueDate.toLocaleDateString("vi-VN")}
                           </div>
                       ) : (
                           // HỌC SINH: Logic cũ (Đã đóng / Hạn nộp)
                           <div className={`text-xs font-bold px-2 py-1 rounded border ${
                               isSubmitted ? 'bg-gray-100 text-gray-600 border-gray-200' : 
                               isExpired ? 'bg-red-50 text-red-600 border-red-100' : 'bg-green-50 text-green-600 border-green-100'
                           }`}>
                               {isExpired && !isSubmitted ? "⚠️ Quá hạn:" : "⏰ Hạn:"} {dueDate.toLocaleDateString("vi-VN")}
                           </div>
                       )
                   ) : (
                       <span className="bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded border">Không giới hạn</span>
                   )}
                   
                   {/* Nút hành động */}
                   <Link to={`/assignments/${a.id}`} className={`text-xs border px-3 py-1.5 rounded transition font-bold flex items-center gap-1 ${
                       isTeacher 
                       ? 'bg-indigo-50 text-indigo-700 border-indigo-200 hover:bg-indigo-100' 
                       : (isSubmitted ? 'border-green-600 text-green-600 hover:bg-green-50' : 'border-blue-600 text-blue-600 hover:bg-blue-600 hover:text-white')
                   }`}>
                       {isTeacher ? "👁️ Xem bài nộp" : (isSubmitted ? "Xem lại bài" : "🚀 Vào làm bài")}
                   </Link>
                </div>
              </div>
            )
          })}
        </div>
      )}
    </div>
  );
}