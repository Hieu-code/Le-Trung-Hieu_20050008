// src/components/SectionForm.jsx
import React, { useEffect, useState } from "react";
import api from "../api/api"; // 👇 Import API để gọi Server

export default function SectionForm({ courseId, initial, onSuccess }) {
  const [open, setOpen] = useState(false);
  const [saving, setSaving] = useState(false);

  const [form, setForm] = useState({
    title: initial?.title ?? "",
    order: initial?.order ?? 0,
  });

  useEffect(() => {
    setForm({
      title: initial?.title ?? "",
      order: initial?.order ?? 0,
    });
  }, [initial?.id]);

  const isEdit = Boolean(initial);
  const triggerLabel = isEdit ? "Sửa" : "+ Chương mới"; // Đổi tên nút cho dễ hiểu

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((s) => ({
      ...s,
      [name]: name === "order" ? Number(value) || 0 : value,
    }));
  };

  // 👇 HÀM XỬ LÝ QUAN TRỌNG NHẤT (ĐÃ SỬA)
  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!form.title.trim()) return;

    // Kiểm tra: Nếu tạo mới thì bắt buộc phải có courseId
    if (!isEdit && !courseId) {
        alert("Lỗi: Không tìm thấy ID khóa học!");
        return;
    }

    try {
      setSaving(true);
      
      if (isEdit) {
          // Logic Sửa: Gọi API PATCH
          await api.patch(`sections/${initial.id}/`, {
              title: form.title.trim(),
              order: form.order
          });
      } else {
          // Logic Tạo mới: Gọi API POST
          await api.post(`sections/`, {
              title: form.title.trim(),
              order: form.order,
              course: courseId // Gắn vào khóa học hiện tại
          });
      }

      // Thông báo cho cha biết để load lại danh sách
      if (onSuccess) onSuccess();

      if (!isEdit) {
        // Reset form khi tạo mới thành công
        setForm({ title: "", order: 0 });
      }
      setOpen(false); // Đóng popup
    } catch (e) {
        alert("Lỗi: " + (e.response?.data?.detail || e.message));
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="relative inline-block">
      {/* Nút mở form */}
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className={
          isEdit
            ? "px-3 py-1.5 rounded-full border text-sm hover:bg-gray-50 transition"
            : "px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-bold hover:bg-blue-700 shadow-sm transition"
        }
      >
        {triggerLabel}
      </button>

      {/* Popup Form */}
      {open && (
        <div className="absolute left-0 mt-2 w-72 rounded-xl border bg-white shadow-xl z-50 animate-fade-in-up">
          <div className="bg-gray-50 px-4 py-2 rounded-t-xl border-b text-xs font-bold text-gray-500 uppercase">
              {isEdit ? "Cập nhật chương" : "Tạo chương mới"}
          </div>
          <form onSubmit={handleSubmit} className="p-4 space-y-3">
            <div className="space-y-1">
              <label className="text-xs font-medium text-gray-700">
                Tiêu đề chương <span className="text-red-500">*</span>
              </label>
              <input
                name="title"
                value={form.title}
                onChange={handleChange}
                className="w-full border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="VD: Chương 1 - Nhập môn..."
                autoFocus
                required
              />
            </div>

            <div className="space-y-1">
              <label className="text-xs font-medium text-gray-700">
                Thứ tự hiển thị
              </label>
              <input
                type="number"
                name="order"
                value={form.order}
                onChange={handleChange}
                className="w-full border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="0"
              />
            </div>

            <div className="flex justify-end gap-2 pt-2 border-t mt-2">
              <button
                type="button"
                onClick={() => setOpen(false)}
                className="px-3 py-1.5 text-sm rounded-lg text-gray-600 hover:bg-gray-100 font-medium"
              >
                Hủy
              </button>
              <button
                type="submit"
                disabled={saving}
                className="px-3 py-1.5 text-sm rounded-lg bg-blue-600 text-white hover:bg-blue-700 font-medium disabled:opacity-50"
              >
                {saving ? "Đang lưu..." : isEdit ? "Lưu lại" : "Tạo mới"}
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
}