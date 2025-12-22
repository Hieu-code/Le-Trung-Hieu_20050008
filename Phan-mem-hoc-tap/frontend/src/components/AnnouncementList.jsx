// src/components/AnnouncementList.jsx
import React, { useEffect, useState } from "react";
import { listAnnouncements, createAnnouncement } from "../api/api";
import { useAuth } from "../store/auth";
import Button from "./Button";
import Discussion from "./Discussion.jsx";

export default function AnnouncementList({ courseId, isTeacherLike, isTeacher }) {
  const { user } = useAuth();
  const canPost = (typeof isTeacherLike === "boolean" ? isTeacherLike : undefined)
  ?? (typeof isTeacher === "boolean" ? isTeacher : undefined)
  ?? (user?.role === "teacher" || user?.role === "admin");
  const [announcements, setAnnouncements] = useState([]);
  const [newPost, setNewPost] = useState("");
  const [isPosting, setIsPosting] = useState(false); // Toggle mở rộng form đăng bài
  const [loading, setLoading] = useState(false);

  const fetchAnnouncements = async () => {
    if (!courseId) return;
    try {
      const data = await listAnnouncements({ course: courseId });
      setAnnouncements(data?.results || data || []);
    } catch (err) {
      console.error("Failed to fetch announcements", err);
    }
  };

  useEffect(() => {
    fetchAnnouncements();
  }, [courseId]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!newPost.trim() || !user || !canPost) return;


    setLoading(true);
    try {
      const payload = {
        course: courseId,
        title: "Thông báo", 
        body: newPost,
      };
      const created = await createAnnouncement(payload);
      setAnnouncements([created, ...announcements]); 
      setNewPost("");
      setIsPosting(false);
    } catch (err) {
      alert("Lỗi đăng bài: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-3xl mx-auto space-y-6">
      {/* Form tạo thông báo (Style Google Classroom) */}
      {canPost && (
        <div className="bg-white border rounded-lg shadow-sm p-4 transition-all">
          {!isPosting ? (
            <div 
                className="flex items-center gap-4 cursor-pointer"
                onClick={() => setIsPosting(true)}
            >
                <div className="w-10 h-10 rounded-full bg-blue-600 flex items-center justify-center text-white font-bold">
                    {(user?.email || "G")[0].toUpperCase()}
                </div>
                <div className="flex-1 text-sm text-gray-500 hover:text-gray-700 truncate">
                    Thông báo nội dung nào đó cho lớp học của bạn...
                </div>
            </div>
          ) : (
            <form onSubmit={handleSubmit}>
                <div className="mb-4">
                    <textarea
                        value={newPost}
                        onChange={(e) => setNewPost(e.target.value)}
                        placeholder="Thông báo nội dung nào đó cho lớp học của bạn..."
                        className="w-full border-none bg-gray-50 p-3 rounded-lg text-sm focus:ring-0 focus:bg-gray-100 min-h-[100px] resize-none"
                        autoFocus
                    />
                </div>
                <div className="flex justify-end gap-2 border-t pt-3">
                    <button 
                        type="button"
                        onClick={() => setIsPosting(false)}
                        className="px-4 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100 rounded"
                    >
                        Hủy
                    </button>
                    <Button type="submit" disabled={loading || !newPost.trim()}>
                        {loading ? "Đang đăng..." : "Đăng"}
                    </Button>
                </div>
            </form>
          )}
        </div>
      )}

      {/* Danh sách thông báo */}
      <div className="space-y-6">
        {announcements.length === 0 && (
          <div className="text-center py-10 border-2 border-dashed rounded-xl">
             <div className="text-4xl mb-2">💬</div>
             <p className="text-gray-500">Chưa có thông báo nào trong lớp học.</p>
          </div>
        )}
        
        {announcements.map((ann) => (
          <div key={ann.id} className="bg-white border rounded-lg shadow-sm overflow-hidden">
            {/* Header bài đăng */}
            <div className="p-4">
                <div className="flex items-center gap-3 mb-3">
                    <div className="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-blue-700 font-bold">
                        {(ann.author?.full_name || ann.author?.email || "G")[0].toUpperCase()}
                    </div>
                    <div>
                        <div className="font-semibold text-sm text-gray-900">
                            {ann.author?.full_name || ann.author?.email || "Giáo viên"}
                        </div>
                        <div className="text-xs text-gray-500">
                            {new Date(ann.created_at).toLocaleString("vi-VN", { dateStyle: 'medium', timeStyle: 'short' })}
                        </div>
                    </div>
                </div>
                
                {/* Nội dung bài đăng */}
                <div className="text-sm text-gray-800 whitespace-pre-wrap leading-relaxed">
                    {ann.body}
                </div>
            </div>

            {/* Phần bình luận */}
            <div className="px-4 pb-4">
                <Discussion courseId={courseId} announcementId={ann.id} />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}