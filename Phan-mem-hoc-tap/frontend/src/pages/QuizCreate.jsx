// src/pages/QuizCreate.jsx
import React, { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import { listCourses, listLessons, createQuiz } from "../api/api.js";
import Button from "../components/Button.jsx";

export default function QuizCreate() {
  const nav = useNavigate();
  const [sp] = useSearchParams();
  const lessonParam = sp.get("lesson") || "";

  const [courses, setCourses] = useState([]);
  const [lessons, setLessons] = useState([]);
  const [loading, setLoading] = useState(false);

  const [form, setForm] = useState({
    title: "",
    description: "",
    course: "",
    lesson: lessonParam,
    is_published: true, // Mặc định là Xuất bản để tránh quên
  });

  // Load danh sách khóa học của tôi
  useEffect(() => {
    (async () => {
      try {
        const c = await listCourses({ mine: true });
        setCourses(c?.results || c || []);
        
        // Nếu có lessonParam, load list lesson ngay
        if (lessonParam) {
          const ls = await listLessons({});
          setLessons(ls?.results || ls || []);
        }
      } catch (e) {
        console.error("Lỗi tải dữ liệu:", e);
      }
    })();
  }, [lessonParam]);

  // Khi chọn Course -> Load Lesson của Course đó
  useEffect(() => {
    if (form.course) {
      listLessons({ course: form.course }).then((res) => {
        setLessons(res?.results || res || []);
      });
    } else {
      setLessons([]);
    }
  }, [form.course]);

  const submit = async (e) => {
    e.preventDefault();
    if (!form.title || !form.course) {
      alert("Vui lòng nhập tiêu đề và chọn khóa học.");
      return;
    }
    
    setLoading(true);
    try {
      const res = await createQuiz(form);
      // Tạo xong -> Chuyển sang trang Chi tiết để thêm câu hỏi
      nav(`/quizzes/${res.id}`);
    } catch (e) {
      console.error(e);
      alert("Lỗi khi tạo bài kiểm tra. Vui lòng thử lại.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-2xl mx-auto bg-white p-8 rounded-2xl border border-gray-200 shadow-sm">
      <h1 className="text-2xl font-bold text-gray-900 mb-6">Tạo đề thi trắc nghiệm mới</h1>
      
      <form onSubmit={submit} className="space-y-5">
        {/* Tiêu đề */}
        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-1">Tiêu đề bài thi <span className="text-red-500">*</span></label>
          <input
            className="w-full rounded-lg border border-gray-300 px-4 py-2 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition"
            placeholder="Ví dụ: Kiểm tra giữa kỳ..."
            value={form.title}
            onChange={(e) => setForm({ ...form, title: e.target.value })}
            required
          />
        </div>

        {/* Mô tả */}
        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-1">Mô tả / Hướng dẫn</label>
          <textarea
            className="w-full rounded-lg border border-gray-300 px-4 py-2 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition"
            rows={3}
            placeholder="Nhập hướng dẫn làm bài..."
            value={form.description}
            onChange={(e) => setForm({ ...form, description: e.target.value })}
          />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
          {/* Chọn Khóa học */}
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-1">Khóa học <span className="text-red-500">*</span></label>
            <select
              className="w-full rounded-lg border border-gray-300 px-4 py-2 bg-white focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition"
              value={form.course}
              onChange={(e) => setForm({ ...form, course: e.target.value })}
              required
            >
              <option value="">-- Chọn khóa học --</option>
              {courses.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.title}
                </option>
              ))}
            </select>
          </div>

          {/* Chọn Bài học (Optional) */}
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-1">Gắn với bài học (Tuỳ chọn)</label>
            <select
              className="w-full rounded-lg border border-gray-300 px-4 py-2 bg-white focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition"
              value={form.lesson}
              onChange={(e) => setForm({ ...form, lesson: e.target.value })}
              disabled={!form.course && !lessonParam}
            >
              <option value="">-- Không gắn --</option>
              {lessons.map((l) => (
                <option key={l.id} value={l.id}>
                  {l.title}
                </option>
              ))}
            </select>
          </div>
        </div>

        {/* --- Ô TÍCH XUẤT BẢN (QUAN TRỌNG) --- */}
        <div className="bg-blue-50 p-4 rounded-xl border border-blue-100 flex items-start gap-3">
            <div className="flex h-6 items-center">
              <input
                id="published_check"
                type="checkbox"
                className="h-5 w-5 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                checked={form.is_published}
                onChange={(e) => setForm({ ...form, is_published: e.target.checked })}
              />
            </div>
            <div>
              <label htmlFor="published_check" className="text-sm font-bold text-blue-900 cursor-pointer">
                Xuất bản ngay
              </label>
              <p className="text-xs text-blue-700 mt-1">
                Nếu chọn, học sinh sẽ nhìn thấy và có thể làm bài ngay lập tức. Nếu bỏ chọn, bài thi sẽ ở trạng thái "Nháp".
              </p>
            </div>
        </div>

        <div className="flex justify-end gap-3 pt-4 border-t">
          <Button variant="ghost" onClick={() => nav(-1)}>
            Hủy bỏ
          </Button>
          <Button type="submit" disabled={loading}>
            {loading ? "Đang tạo..." : "Tiếp tục: Thêm câu hỏi →"}
          </Button>
        </div>
      </form>
    </div>
  );
}