// src/components/MaterialList.jsx
import React, { useEffect, useState } from "react";
import api from "../api/api";

const TYPE_LABELS = {
  file: "Tệp tải lên",
  link: "Đường dẫn",
  video: "Video",
  audio: "Âm thanh",
};

export default function MaterialList({ items, lessonId, canEdit = false }) {
  const [data, setData] = useState(Array.isArray(items) ? items : []);
  const [loading, setLoading] = useState(false);

  // Khi dùng kiểu global (trang /materials) -> sync với props.items
  useEffect(() => {
    if (!lessonId) {
      setData(Array.isArray(items) ? items : []);
    }
  }, [items, lessonId]);

  // Khi có lessonId -> tự fetch materials theo lesson đó
  useEffect(() => {
    if (!lessonId) return;

    let cancelled = false;
    async function fetchLessonMaterials() {
      setLoading(true);
      try {
        const res = await api.get("materials/", {
          params: { lesson: lessonId },
        });
        const raw = res.data?.results ?? res.data ?? [];
        if (!cancelled) {
          setData(Array.isArray(raw) ? raw : []);
        }
      } catch (e) {
        console.error(e);
        if (!cancelled) setData([]);
      } finally {
        if (!cancelled) setLoading(false);
      }
    }

    fetchLessonMaterials();
    return () => {
      cancelled = true;
    };
  }, [lessonId]);

  const removeItem = async (id) => {
    if (!canEdit) return;
    if (!window.confirm("Xoá tài liệu này?")) return;
    try {
      await api.delete(`materials/${id}/`);
      setData((prev) => prev.filter((m) => m.id !== id));
    } catch (e) {
      console.error(e);
      alert("Xoá tài liệu thất bại");
    }
  };

  if (loading) {
    return <div className="text-sm text-gray-500">Đang tải tài liệu…</div>;
  }

  if (!data || data.length === 0) {
    return <p className="text-sm text-gray-500">Chưa có tài liệu.</p>;
  }

  return (
    <ul className="space-y-2">
      {data.map((m) => {
        const isFile = m.type === "file";
        const href = isFile ? m.file : m.url;
        const label = TYPE_LABELS[m.type] || m.type;
        const created = m.created_at ? new Date(m.created_at).toLocaleString() : null;

        return (
          <li
            key={m.id}
            className="flex items-center justify-between gap-3 rounded-lg border bg-white px-3 py-2"
          >
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2">
                <span className="inline-flex items-center rounded-full border px-2 py-0.5 text-xs font-medium text-gray-700 bg-gray-50">
                  {label}
                </span>
                <span className="truncate text-sm text-gray-800">
                  {href || "Không có đường dẫn"}
                </span>
              </div>
              {created && (
                <div className="mt-0.5 text-xs text-gray-500">
                  Thêm lúc {created}
                  {m.lesson ? ` · Lesson #${m.lesson}` : ""}
                </div>
              )}
            </div>

            <div className="flex items-center gap-2">
              {href && (
                <a
                  href={href}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="rounded-full border px-3 py-1 text-xs font-medium hover:bg-gray-50"
                >
                  {isFile ? "Mở tệp" : "Mở liên kết"}
                </a>
              )}
              {canEdit && (
                <button
                  type="button"
                  onClick={() => removeItem(m.id)}
                  className="rounded-full border border-red-200 bg-red-50 px-2.5 py-1 text-xs font-medium text-red-600 hover:bg-red-100"
                >
                  Xoá
                </button>
              )}
            </div>
          </li>
        );
      })}
    </ul>
  );
}
