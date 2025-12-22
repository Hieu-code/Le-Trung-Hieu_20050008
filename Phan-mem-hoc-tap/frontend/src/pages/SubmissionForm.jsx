import React, { useState, useEffect } from "react";
import api from "../api/api";
import Button from "../components/Button.jsx";

export default function SubmissionForm({ assignmentId, existingSubmission, onSubmitted }) {
  const [file, setFile] = useState(null);
  const [answer, setAnswer] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [isEditing, setIsEditing] = useState(false);

  // Load dữ liệu cũ nếu có (để sửa bài)
  useEffect(() => {
    if (existingSubmission) {
      setAnswer(existingSubmission.answer_text || "");
      setIsEditing(false);
      setFile(null);
    } else {
      setAnswer("");
      setIsEditing(true);
      setFile(null);
    }
  }, [existingSubmission]);

  const submit = async (e) => {
    e.preventDefault();
    if (!assignmentId) return;

    // 1. Validate Client
    if (!file && !answer.trim()) {
        alert("Vui lòng đính kèm file hoặc nhập nội dung trả lời.");
        return;
    }

    // 2. Chuẩn bị dữ liệu
    const form = new FormData();
    form.append("assignment", assignmentId);
    if (file) form.append("file", file);
    if (answer) form.append("answer_text", answer);

    setSubmitting(true);
    try {
      // 3. Gọi API (Tạo mới hoặc Cập nhật)
      if (existingSubmission?.id) {
        await api.patch(`submissions/${existingSubmission.id}/`, form, {
          headers: { "Content-Type": "multipart/form-data" },
        });
      } else {
        await api.post("submissions/", form, {
          headers: { "Content-Type": "multipart/form-data" },
        });
      }
      
      alert("Nộp bài thành công!");
      setFile(null);
      if (onSubmitted) onSubmitted(); // Refresh lại giao diện cha
      setIsEditing(false);

    } catch (err) {
      console.error(err);
      // 👇 QUAN TRỌNG: Hiển thị thông báo chặn từ Backend (VD: Quá hạn)
      const msg = err.response?.data?.detail || "Lỗi khi nộp bài. Vui lòng thử lại.";
      alert(msg);
    } finally {
      setSubmitting(false);
    }
  };

  // Giao diện khi ĐÃ nộp bài
  if (existingSubmission && !isEditing) {
    return (
      <div className="bg-green-50 border border-green-200 rounded-xl p-4 mt-4">
        <h3 className="text-green-800 font-bold text-sm mb-2">✅ Đã nộp bài</h3>
        <p className="text-sm text-gray-700 mb-1">
           <span className="font-semibold">Điểm:</span> {existingSubmission.score !== null ? existingSubmission.score : "Chưa chấm"}
        </p>
        <p className="text-sm text-gray-700 mb-1">
           <span className="font-semibold">Cập nhật:</span> {new Date(existingSubmission.updated_at).toLocaleString('vi-VN')}
        </p>
        {existingSubmission.file && (
            <p className="text-sm text-blue-600 underline mb-2">
                <a href={existingSubmission.file} target="_blank" rel="noreferrer">Xem file đính kèm</a>
            </p>
        )}
        <div className="text-sm text-gray-600 bg-white p-2 rounded border border-green-100 italic mb-3">
            "{existingSubmission.answer_text || "Không có lời nhắn"}"
        </div>
        
        <Button size="sm" variant="secondary" onClick={() => setIsEditing(true)}>
            Chỉnh sửa bài nộp
        </Button>
      </div>
    );
  }

  // Giao diện Form nộp bài
  return (
    <form onSubmit={submit} className="mt-4 space-y-4 bg-gray-50 p-4 rounded-xl border border-gray-100">
        <h3 className="font-bold text-gray-700">Nộp bài tập</h3>
        
        <div>
          <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Tệp đính kèm</label>
          <div className="flex items-center justify-center w-full">
            <label className="flex flex-col items-center justify-center w-full h-24 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-white hover:bg-gray-50 transition">
                <div className="flex flex-col items-center justify-center pt-5 pb-6">
                    <p className="text-sm text-gray-500"><span className="font-semibold">Nhấn để tải file</span></p>
                    <p className="text-xs text-gray-500 mt-1 px-2 text-center truncate w-64">
                        {file ? `📄 ${file.name}` : "Chưa chọn tệp (PDF, Docx, Zip...)"}
                    </p>
                </div>
                <input type="file" className="hidden" onChange={(e) => setFile(e.target.files[0])} />
            </label>
          </div>
        </div>

        <div>
          <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Lời nhắn / Link</label>
          <textarea
            className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 outline-none transition"
            rows={3}
            placeholder="Dán link Google Drive hoặc lời nhắn cho giáo viên..."
            value={answer}
            onChange={(e) => setAnswer(e.target.value)}
          />
        </div>

        <div className="flex gap-3 pt-2">
          <Button type="submit" disabled={submitting} className="flex-1 py-2 shadow-sm">
            {submitting ? "Đang tải lên..." : "Lưu & Nộp bài"}
          </Button>
          {existingSubmission && (
            <button 
                type="button" 
                onClick={() => setIsEditing(false)}
                className="px-4 py-2 text-sm text-gray-500 hover:text-gray-700 font-medium"
            >
                Hủy
            </button>
          )}
        </div>
    </form>
  );
}