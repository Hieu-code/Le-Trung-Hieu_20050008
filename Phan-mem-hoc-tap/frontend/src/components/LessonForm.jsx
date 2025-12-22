// src/components/LessonForm.jsx
import React, { useEffect, useState } from "react";

/**
 * LessonForm
 *
 * Props:
 *  - initial?: { title, content, order }
 *  - onSubmit: (payload) => Promise|void
 *  - onCancel?: () => void
 */
export default function LessonForm({ initial, onSubmit, onCancel }) {
  const [form, setForm] = useState({
    title: "",
    content: "",
    order: 0,
  });
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    setForm({
      title: initial?.title ?? "",
      content: initial?.content ?? "",
      order: initial?.order ?? 0,
    });
  }, [initial?.id]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((s) => ({
      ...s,
      [name]: name === "order" ? Number(value) || 0 : value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!form.title.trim()) return;
    try {
      setSaving(true);
      await onSubmit({
        title: form.title.trim(),
        content: form.content.trim(),
        order: form.order || 0,
      });
    } finally {
      setSaving(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-3">
        <div className="md:col-span-2 space-y-1">
          <label className="text-xs text-gray-600 font-medium">Tiêu đề</label>
          <input
            name="title"
            value={form.title}
            onChange={handleChange}
            className="w-full border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/80"
            placeholder="VD: Giới thiệu môn học"
            required
          />
        </div>

        <div className="space-y-1">
          <label className="text-xs text-gray-600 font-medium">Thứ tự</label>
          <input
            type="number"
            name="order"
            value={form.order}
            onChange={handleChange}
            className="w-full border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/80"
            placeholder="0"
          />
        </div>

        <div className="md:col-span-1 space-y-1">
          <label className="text-xs text-gray-600 font-medium">
            Nội dung ngắn (tuỳ chọn)
          </label>
          <input
            name="content"
            value={form.content}
            onChange={handleChange}
            className="w-full border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/80"
            placeholder="Mô tả ngắn..."
          />
        </div>
      </div>

      <div className="flex gap-2">
        {onCancel && (
          <button
            type="button"
            onClick={onCancel}
            className="px-3 py-1.5 text-sm rounded-lg border hover:bg-gray-50"
          >
            Hủy
          </button>
        )}
        <button
          type="submit"
          disabled={saving}
          className="px-3 py-1.5 text-sm rounded-lg bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-60"
        >
          {saving ? "Đang lưu..." : "Lưu bài học"}
        </button>
      </div>
    </form>
  );
}
