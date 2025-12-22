import React, { useState } from "react";
import { generateQuizAI } from "../api/api";
import Button from "./Button";

// 👇 Biểu tượng Loading quay tròn (Tích hợp trực tiếp để không lỗi import)
const LoadingIcon = () => (
  <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
  </svg>
);

export default function AiQuizModal({ onClose, onSuccess }) {
  const [text, setText] = useState("");
  const [num, setNum] = useState(5);
  const [loading, setLoading] = useState(false);

  const handleGenerate = async () => {
    if (!text.trim()) return alert("Vui lòng nhập nội dung bài học!");
    
    setLoading(true);
    try {
      const questions = await generateQuizAI({ text, num });
      onSuccess(questions); // Trả kết quả về trang cha
      onClose(); // Đóng modal
    } catch (e) {
      alert("Lỗi AI: " + (e.response?.data?.detail || e.message));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-2xl border border-gray-100 overflow-hidden animate-fade-in-up">
        {/* Header */}
        <div className="bg-gradient-to-r from-purple-600 to-blue-600 p-4 text-white flex justify-between items-center">
            <h3 className="font-bold text-lg flex items-center gap-2">
                ✨ Trợ lý AI Tạo Đề Thi
            </h3>
            <button onClick={onClose} className="text-white/80 hover:text-white text-xl font-bold px-2">✕</button>
        </div>

        <div className="p-6 space-y-4">
            <p className="text-sm text-gray-600">Dán nội dung bài học, tài liệu hoặc chủ đề vào đây. AI sẽ tự động sinh câu hỏi cho bạn.</p>
            
            <div>
                <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Nội dung văn bản</label>
                <textarea 
                    className="w-full border rounded-xl px-4 py-3 text-sm focus:ring-2 focus:ring-purple-500 outline-none h-40"
                    placeholder="Ví dụ: Chiến tranh thế giới thứ hai bắt đầu vào năm 1939..."
                    value={text}
                    onChange={e => setText(e.target.value)}
                />
            </div>

            <div>
                <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Số lượng câu hỏi</label>
                <input 
                    type="number" 
                    className="w-full border rounded-xl px-4 py-2 text-sm focus:ring-2 focus:ring-purple-500 outline-none"
                    value={num}
                    onChange={e => setNum(e.target.value)}
                    min={1} max={10}
                />
            </div>
        </div>

        <div className="p-4 bg-gray-50 flex justify-end gap-3 border-t">
            <Button variant="ghost" onClick={onClose} disabled={loading}>Hủy</Button>
            <button 
                onClick={handleGenerate} 
                disabled={loading}
                className="bg-purple-600 hover:bg-purple-700 text-white px-6 py-2 rounded-lg font-bold shadow-md transition flex items-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
            >
                {/* 👇 Sử dụng LoadingIcon tại đây */}
                {loading ? <><LoadingIcon /> Đang suy nghĩ...</> : "⚡ Tạo câu hỏi ngay"}
            </button>
        </div>
      </div>
    </div>
  );
}