// src/components/Discussion.jsx
import React, { useEffect, useState } from "react";
import { listComments, createComment } from "../api/api";
import { useAuth } from "../store/auth";
import { formatDistanceToNow } from "date-fns";
import { vi } from "date-fns/locale";

export default function Discussion({ courseId, announcementId }) {
  const { user } = useAuth();
  const [comments, setComments] = useState([]);
  const [newComment, setNewComment] = useState("");
  const [loading, setLoading] = useState(false);
  const [isExpanded, setIsExpanded] = useState(false);

  // Load comments
  const fetchComments = async () => {
    if (!announcementId) return;
    try {
      const params = { announcement: announcementId };
      const data = await listComments(params);
      setComments(data?.results || data || []);
    } catch (err) {
      console.error("Failed to fetch comments", err);
    }
  };

  useEffect(() => {
    fetchComments();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [announcementId]);

  // Submit comment
  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!newComment.trim() || !user) return;

    setLoading(true);
    try {
      const payload = {
        course: courseId,
        announcement: announcementId,
        body: newComment,
      };
      const created = await createComment(payload);
      // Thêm comment mới vào danh sách (hiển thị ngay)
      setComments((prev) => [...prev, created]); 
      setNewComment("");
    } catch (err) {
      alert("Lỗi gửi bình luận: " + (err.response?.data?.detail || err.message));
    } finally {
      setLoading(false);
    }
  };

  // Toggle hiển thị comment
  const commentCount = comments.length;
  
  // Google Classroom style: Luôn hiện input. Nếu có comment thì hiện nút "Xem nhận xét".
  return (
    <div className="mt-3 border-t pt-3">
      {/* Danh sách comment (Ẩn/Hiện) */}
      {commentCount > 0 && (
        <div className="mb-3">
            {!isExpanded && commentCount > 1 ? (
                <button 
                    onClick={() => setIsExpanded(true)}
                    className="text-xs font-semibold text-gray-500 hover:underline mb-2"
                >
                    Xem {commentCount} nhận xét lớp học
                </button>
            ) : null}

            <div className={`space-y-3 ${(!isExpanded && commentCount > 1) ? 'hidden' : 'block'}`}>
                 {/* Nếu chưa expand, có thể chỉ hiện comment cuối cùng (optional), 
                     nhưng Google Classroom thường hiện list hoặc ẩn. 
                     Ở đây ta hiện tất cả khi expand. 
                 */}
                 {comments.map((c) => (
                    <div key={c.id} className="flex gap-3 group">
                        {/* Avatar nhỏ */}
                        <div className="w-8 h-8 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-600 text-xs font-bold flex-shrink-0">
                            {(c.author?.full_name || c.author?.email || "U")[0].toUpperCase()}
                        </div>
                        <div className="flex-1">
                            <div className="flex items-baseline gap-2">
                                <span className="text-xs font-bold text-gray-900">
                                    {c.author?.full_name || c.author?.email}
                                </span>
                                <span className="text-[10px] text-gray-500">
                                    {c.created_at 
                                        ? formatDistanceToNow(new Date(c.created_at), { addSuffix: true, locale: vi }) 
                                        : ""}
                                </span>
                            </div>
                            <p className="text-sm text-gray-800 mt-0.5 break-words">{c.body}</p>
                        </div>
                    </div>
                 ))}
            </div>
            
            {/* Nếu đang đóng và có > 0 comment, hiện comment cuối cùng để preview (giống FB/Google) */}
            {!isExpanded && commentCount > 0 && (
                 <div className="flex gap-3 group mt-2">
                     {/* Lấy comment cuối */}
                     <div className="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center text-gray-500 text-xs font-bold flex-shrink-0">
                         {(comments[comments.length-1].author?.full_name || "U")[0].toUpperCase()}
                     </div>
                     <div className="flex-1">
                         <div className="flex items-baseline gap-2">
                             <span className="text-xs font-bold text-gray-900">
                                 {comments[comments.length-1].author?.full_name || "User"}
                             </span>
                             <span className="text-[10px] text-gray-500">
                                {formatDistanceToNow(new Date(comments[comments.length-1].created_at), { addSuffix: true, locale: vi })}
                             </span>
                         </div>
                         <p className="text-sm text-gray-800 mt-0.5 line-clamp-1">{comments[comments.length-1].body}</p>
                     </div>
                 </div>
            )}
        </div>
      )}

      {/* Input nhập liệu - Style giống Google Classroom */}
      <div className="flex gap-3 items-start mt-2">
         <div className="w-8 h-8 rounded-full bg-blue-600 flex items-center justify-center text-white text-xs font-bold flex-shrink-0">
            {(user?.email || "M")[0].toUpperCase()}
         </div>
         <form onSubmit={handleSubmit} className="flex-1 relative">
            <div className="relative rounded-full border border-gray-300 bg-gray-50 focus-within:bg-white focus-within:border-blue-500 focus-within:ring-1 focus-within:ring-blue-500 transition-all">
                <input
                    type="text"
                    value={newComment}
                    onChange={(e) => setNewComment(e.target.value)}
                    placeholder="Thêm nhận xét cho lớp học..."
                    className="w-full bg-transparent border-none px-4 py-2 text-sm focus:outline-none focus:ring-0 rounded-full pr-10"
                    disabled={loading}
                />
                <button
                    type="submit"
                    disabled={!newComment.trim() || loading}
                    className={`absolute right-1 top-1 p-1.5 rounded-full transition-colors ${
                        newComment.trim() 
                        ? "text-blue-600 hover:bg-blue-50" 
                        : "text-gray-300 cursor-not-allowed"
                    }`}
                >
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" className="w-5 h-5">
                        <path d="M3.478 2.405a.75.75 0 00-.926.94l2.432 7.905H13.5a.75.75 0 010 1.5H4.984l-2.432 7.905a.75.75 0 00.926.94 60.519 60.519 0 0018.445-8.986.75.75 0 000-1.218A60.517 60.517 0 003.478 2.405z" />
                    </svg>
                </button>
            </div>
         </form>
      </div>
    </div>
  );
}