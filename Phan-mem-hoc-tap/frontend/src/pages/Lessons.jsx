// src/pages/Lessons.jsx
import React, { useEffect, useState } from "react";
import api from "../api/api";
import Spinner from "../components/Spinner";
import MaterialList from "../components/MaterialList";
import LessonForm from "../components/LessonForm.jsx";

export default function Lessons({ courseId, sectionId, canEdit = false }) {
  const [lessons, setLessons] = useState([]);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(null); // lesson
  const [creating, setCreating] = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const params = {};
      if (courseId) params.course = courseId;
      if (sectionId) params.section = sectionId;
      const { data } = await api.get("lessons/", { params });
      setLessons(data?.results ?? data ?? []);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [courseId, sectionId]);

  const createLesson = async (form) => {
    try {
      const payload = { ...form };
      if (sectionId) payload.section = sectionId;
      const { data } = await api.post("lessons/", payload);
      setLessons((prev) => [data, ...prev]);
      setCreating(false);
    } catch (e) {
      console.error(e);
      alert("Tạo bài học thất bại");
    }
  };

  const saveLesson = async (id, form) => {
    try {
      const { data } = await api.patch(`lessons/${id}/`, form);
      setLessons((prev) => prev.map((l) => (l.id === id ? data : l)));
      setEditing(null);
    } catch (e) {
      console.error(e);
      alert("Lưu thất bại");
    }
  };

  const deleteLesson = async (id) => {
    if (!confirm("Xoá bài học này?")) return;
    try {
      await api.delete(`lessons/${id}/`);
      setLessons((prev) => prev.filter((l) => l.id !== id));
    } catch (e) {
      console.error(e);
      alert("Xoá thất bại");
    }
  };

  if (loading) return <Spinner />;

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h3 className="font-semibold">Bài học</h3>
        {canEdit && (
          <button
            onClick={() => setCreating((s) => !s)}
            className="px-3 py-2 rounded-full bg-green-600 text-white text-sm hover:bg-green-700"
          >
            {creating ? "Đóng" : "+ Thêm bài học"}
          </button>
        )}
      </div>

      {creating && (
        <div className="p-3 rounded-2xl border bg-white">
          <LessonForm
            onSubmit={createLesson}
            onCancel={() => setCreating(false)}
          />
        </div>
      )}

      {lessons.length === 0 ? (
        <p className="text-sm text-gray-500">Chưa có bài học.</p>
      ) : (
        <ul className="space-y-3">
          {lessons.map((l) => (
            <li key={l.id} className="p-3 rounded-2xl border bg-white">
              <div className="flex items-start justify-between gap-3">
                <div className="flex-1 min-w-0">
                  {editing?.id === l.id ? (
                    <LessonForm
                      initial={l}
                      onSubmit={(f) => saveLesson(l.id, f)}
                      onCancel={() => setEditing(null)}
                    />
                  ) : (
                    <>
                      <div className="flex items-center gap-2">
                        <h4 className="font-medium">{l.title}</h4>
                        <span className="text-xs text-gray-500">
                          #{l.order ?? l.id}
                        </span>
                      </div>
                      {l.content && (
                        <p className="text-sm text-gray-600 mt-1">
                          {l.content}
                        </p>
                      )}
                    </>
                  )}

                  {/* Tài liệu trong bài học */}
                  <div className="mt-3">
                    <MaterialList lessonId={l.id} canEdit={canEdit} />
                  </div>
                </div>
                {canEdit && editing?.id !== l.id && (
                  <div className="flex-shrink-0 flex gap-2">
                    <button
                      onClick={() => setEditing(l)}
                      className="px-3 py-1 rounded-lg border text-sm hover:bg-gray-50"
                    >
                      Sửa
                    </button>
                    <button
                      onClick={() => deleteLesson(l.id)}
                      className="px-3 py-1 rounded-lg text-sm bg-red-600 text-white hover:bg-red-700"
                    >
                      Xoá
                    </button>
                  </div>
                )}
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
