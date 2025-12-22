// src/components/MaterialUploadForm.jsx
import React, { useEffect, useState } from "react";
import api from "../api/api";
import Button from "./Button.jsx";

const TYPE_OPTIONS = [
  { value: "file", label: "Tệp tải lên" },
  { value: "link", label: "Đường dẫn (link)" },
  { value: "video", label: "Video" },
  { value: "audio", label: "Âm thanh" },
];

export default function MaterialUploadForm({ courses = [], lessonId, onUploaded }) {
  const [selectedCourse, setSelectedCourse] = useState("");
  const [sections, setSections] = useState([]);
  const [selectedSection, setSelectedSection] = useState("");
  const [lessons, setLessons] = useState([]);
  const [selectedLesson, setSelectedLesson] = useState("");

  const [type, setType] = useState("file");
  const [file, setFile] = useState(null);
  const [url, setUrl] = useState("");
  const [loading, setLoading] = useState(false);

  const hasLessonFromProp = !!lessonId;

  // Auto chọn khoá đầu tiên nếu đang ở trang Materials
  useEffect(() => {
    if (hasLessonFromProp) return;
    if (!selectedCourse && courses && courses.length > 0) {
      setSelectedCourse(String(courses[0].id));
    }
  }, [courses, selectedCourse, hasLessonFromProp]);

  // Load sections theo course
  useEffect(() => {
    if (hasLessonFromProp) return;
    if (!selectedCourse) {
      setSections([]);
      setSelectedSection("");
      return;
    }

    let cancelled = false;
    async function loadSections() {
      try {
        const res = await api.get("sections/", {
          params: { course: selectedCourse, ordering: "order" },
        });
        const data = res.data?.results ?? res.data ?? [];
        if (!cancelled) {
          const arr = Array.isArray(data) ? data : [];
          setSections(arr);
          setSelectedSection((prev) => {
            if (prev) return prev;
            return arr.length ? String(arr[0].id) : "";
          });
        }
      } catch (e) {
        console.error(e);
        if (!cancelled) {
          setSections([]);
          setSelectedSection("");
        }
      }
    }
    loadSections();
    return () => {
      cancelled = true;
    };
  }, [selectedCourse, hasLessonFromProp]);

  // Load lessons theo section
  useEffect(() => {
    if (hasLessonFromProp) return;
    if (!selectedSection) {
      setLessons([]);
      setSelectedLesson("");
      return;
    }

    let cancelled = false;
    async function loadLessons() {
      try {
        const res = await api.get("lessons/", {
          params: { section: selectedSection, ordering: "order" },
        });
        const data = res.data?.results ?? res.data ?? [];
        if (!cancelled) {
          const arr = Array.isArray(data) ? data : [];
          setLessons(arr);
          setSelectedLesson((prev) => {
            if (prev) return prev;
            return arr.length ? String(arr[0].id) : "";
          });
        }
      } catch (e) {
        console.error(e);
        if (!cancelled) {
          setLessons([]);
          setSelectedLesson("");
        }
      }
    }
    loadLessons();
    return () => {
      cancelled = true;
    };
  }, [selectedSection, hasLessonFromProp]);

  const onSubmit = async (e) => {
    e.preventDefault();

    const targetLessonId = lessonId || selectedLesson;
    if (!targetLessonId) {
      alert("Vui lòng chọn bài học mà tài liệu thuộc về.");
      return;
    }

    if (type === "file" && !file) {
      alert("Vui lòng chọn tệp cần tải lên.");
      return;
    }
    if (type !== "file" && !url.trim()) {
      alert("Vui lòng nhập URL tài liệu.");
      return;
    }

    const form = new FormData();
    form.append("lesson", targetLessonId);
    form.append("type", type);
    if (type === "file" && file) {
      form.append("file", file);
    } else if (type !== "file" && url.trim()) {
      form.append("url", url.trim());
    }

    try {
      setLoading(true);
      await api.post("materials/", form, {
        headers: { "Content-Type": "multipart/form-data" },
      });
      setFile(null);
      setUrl("");
      onUploaded?.();
      alert("Tải tài liệu thành công!");
    } catch (err) {
      console.error(err);
      const detail =
        err?.response?.data?.detail ||
        err?.response?.data?.non_field_errors?.[0] ||
        "Tải tài liệu thất bại, vui lòng thử lại.";
      alert(detail);
    } finally {
      setLoading(false);
    }
  };

  const renderLessonSelectors = () => {
    if (hasLessonFromProp) {
      return (
        <p className="text-xs text-gray-500">
          Tài liệu sẽ được gắn với bài học ID{" "}
          <span className="font-mono">#{lessonId}</span>.
        </p>
      );
    }

    return (
      <div className="grid grid-cols-1 md:grid-cols-3 gap-2 mb-3">
        <div>
          <label className="block text-xs font-medium text-gray-600">
            Khoá học
          </label>
          <select
            className="mt-1 w-full rounded border px-3 py-2 text-sm"
            value={selectedCourse}
            onChange={(e) => {
              setSelectedCourse(e.target.value);
              setSelectedSection("");
              setLessons([]);
              setSelectedLesson("");
            }}
          >
            <option value="">— Chọn khoá học —</option>
            {courses.map((c) => (
              <option key={c.id} value={c.id}>
                {c.title}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-xs font-medium text-gray-600">
            Chương (Section)
          </label>
          <select
            className="mt-1 w-full rounded border px-3 py-2 text-sm"
            value={selectedSection}
            onChange={(e) => {
              setSelectedSection(e.target.value);
              setLessons([]);
              setSelectedLesson("");
            }}
            disabled={!selectedCourse}
          >
            <option value="">— Chọn chương —</option>
            {sections.map((s) => (
              <option key={s.id} value={s.id}>
                {s.title}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-xs font-medium text-gray-600">
            Bài học
          </label>
          <select
            className="mt-1 w-full rounded border px-3 py-2 text-sm"
            value={selectedLesson}
            onChange={(e) => setSelectedLesson(e.target.value)}
            disabled={!selectedSection}
          >
            <option value="">— Chọn bài học —</option>
            {lessons.map((l) => (
              <option key={l.id} value={l.id}>
                {l.title}
              </option>
            ))}
          </select>
        </div>
      </div>
    );
  };

  return (
    <form onSubmit={onSubmit} className="space-y-3">
      {renderLessonSelectors()}

      <div className="grid grid-cols-1 md:grid-cols-3 gap-3 items-end">
        <div>
          <label className="block text-xs font-medium text-gray-600">
            Loại tài liệu
          </label>
          <select
            className="mt-1 w-full rounded border px-3 py-2 text-sm"
            value={type}
            onChange={(e) => {
              const v = e.target.value;
              setType(v);
              setFile(null);
              setUrl("");
            }}
          >
            {TYPE_OPTIONS.map((opt) => (
              <option key={opt.value} value={opt.value}>
                {opt.label}
              </option>
            ))}
          </select>
        </div>

        {type === "file" ? (
          <div className="md:col-span-2">
            <label className="block text-xs font-medium text-gray-600">
              Chọn tệp
            </label>
            <input
              type="file"
              className="mt-1 w-full rounded border px-3 py-2 text-sm bg-white"
              onChange={(e) => setFile(e.target.files?.[0] || null)}
            />
            <p className="mt-1 text-[11px] text-gray-500">
              Hỗ trợ PDF, DOCX, PPTX, MP4, MP3,… và các định dạng phổ biến khác.
            </p>
          </div>
        ) : (
          <div className="md:col-span-2">
            <label className="block text-xs font-medium text-gray-600">
              URL tài liệu
            </label>
            <input
              type="url"
              className="mt-1 w-full rounded border px-3 py-2 text-sm"
              placeholder="https://..."
              value={url}
              onChange={(e) => setUrl(e.target.value)}
            />
            <p className="mt-1 text-[11px] text-gray-500">
              Dán link Google Drive, YouTube hoặc trang tài liệu khác.
            </p>
          </div>
        )}
      </div>

      <div className="flex justify-end">
        <Button type="submit" disabled={loading}>
          {loading ? "Đang tải lên…" : "Lưu tài liệu"}
        </Button>
      </div>
    </form>
  );
}
