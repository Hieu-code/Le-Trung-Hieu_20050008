// src/components/CreateAssignmentForm.jsx
import React, { useEffect, useState } from "react";
import { createAssignment } from "../api/api";
import { listCourses, listLessons } from "../api/api";
import Spinner from "./Spinner";

export default function CreateAssignmentForm({ onCreated }) {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  // CHUẨN HOÁ: dùng due_at
  const [dueAt, setDueAt] = useState(""); // ISO string 'YYYY-MM-DDTHH:MM'
  const [courseId, setCourseId] = useState("");
  const [lessonId, setLessonId] = useState("");
  const [courses, setCourses] = useState([]);
  const [lessons, setLessons] = useState([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    let mounted = true;
    (async () => {
      try {
        setLoading(true);
        const res = await listCourses({ mine: true });
        if (!mounted) return;
        const items = res?.results || res || [];
        setCourses(items);
      } catch (e) {
        setError("Không tải được danh sách khoá học.");
      } finally {
        if (mounted) setLoading(false);
      }
    })();
    return () => (mounted = false);
  }, []);

  useEffect(() => {
    let mounted = true;
    (async () => {
      if (!courseId) {
        setLessons([]);
        setLessonId("");
        return;
      }
      try {
        const res = await listLessons({ course: courseId });
        const items = res?.results || res || [];
        if (!mounted) return;
        setLessons(items);
      } catch {
        setLessons([]);
      }
    })();
    return () => (mounted = false);
  }, [courseId]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    if (!title || !courseId) {
      setError("Vui lòng nhập tiêu đề và chọn khoá học.");
      return;
    }

    const payload = {
      title,
      description,
      course: Number(courseId),
      // FE chuẩn: gửi due_at cho BE
      due_at: dueAt ? new Date(dueAt).toISOString() : null,
    };
    if (lessonId) payload.lesson = Number(lessonId);

    try {
      setSaving(true);
      const created = await createAssignment(payload);
      setTitle("");
      setDescription("");
      setDueAt("");
      setLessonId("");
      if (onCreated) onCreated(created);
    } catch (err) {
      setError("Tạo bài tập thất bại.");
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div className="p-3">
        <Spinner />
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-3">
      {error && (
        <div className="rounded border border-red-300 bg-red-50 px-3 py-2 text-red-700">
          {error}
        </div>
      )}

      <div>
        <label className="block text-sm font-medium mb-1">Tiêu đề *</label>
        <input
          className="w-full rounded border px-3 py-2"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Nhập tiêu đề"
        />
      </div>

      <div>
        <label className="block text-sm font-medium mb-1">Mô tả</label>
        <textarea
          className="w-full rounded border px-3 py-2"
          rows={3}
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div>
          <label className="block text-sm font-medium mb-1">Khoá học *</label>
          <select
            className="w-full rounded border px-3 py-2"
            value={courseId}
            onChange={(e) => setCourseId(e.target.value)}
          >
            <option value="">— Chọn khoá học —</option>
            {courses.map((c) => (
              <option key={c.id} value={c.id}>
                {`#${c.id} — ${c.title}`}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-sm font-medium mb-1">Lesson (tuỳ chọn)</label>
          <select
            className="w-full rounded border px-3 py-2"
            value={lessonId}
            onChange={(e) => setLessonId(e.target.value)}
            disabled={!lessons.length}
          >
            <option value="">— Không gắn lesson —</option>
            {lessons.map((l) => (
              <option key={l.id} value={l.id}>
                {`#${l.id} — ${l.title || l.name || "Lesson"}`}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-sm font-medium mb-1">Hạn nộp (due_at)</label>
          <input
            type="datetime-local"
            className="w-full rounded border px-3 py-2"
            value={dueAt}
            onChange={(e) => setDueAt(e.target.value)}
          />
        </div>
      </div>

      <div className="pt-2">
        <button
          type="submit"
          disabled={saving}
          className="rounded bg-green-600 px-4 py-2 text-white hover:bg-green-700 disabled:opacity-60"
        >
          {saving ? "Đang tạo..." : "Tạo bài tập"}
        </button>
      </div>
    </form>
  );
}
