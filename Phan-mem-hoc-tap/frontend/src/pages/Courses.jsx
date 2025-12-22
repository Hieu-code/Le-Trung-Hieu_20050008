// src/pages/Courses.jsx
import React, { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import { listCourses, joinCourse, createCourse, getMe } from "../api/api";
import Spinner from "../components/Spinner";
import CourseCard from "../components/CourseCard";
export default function Courses() {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);

  const [joinCode, setJoinCode] = useState("");
  const [newTitle, setNewTitle] = useState("");
  const [newDesc, setNewDesc] = useState("");

  const [me, setMe] = useState(null);
  const [meLoading, setMeLoading] = useState(true);

  // ---- Lấy thông tin user hiện tại ----
  useEffect(() => {
    let cancelled = false;

    const loadMe = async () => {
      try {
        const data = await getMe();
        if (!cancelled) setMe(data);
      } catch (err) {
        console.error("getMe error:", err);
      } finally {
        if (!cancelled) setMeLoading(false);
      }
    };

    loadMe();
    return () => {
      cancelled = true;
    };
  }, []);

  const isTeacherLike = useMemo(() => {
    if (!me) return false;
    return me.role === "teacher" || me.role === "admin";
  }, [me]);

  // ---- Lấy danh sách khoá học (của mình) ----
  const reload = async () => {
    setLoading(true);
    try {
      const data = await listCourses({ mine: true });
      setItems(Array.isArray(data) ? data : data.results || []);
    } catch (err) {
      console.error("listCourses error:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    reload();
  }, []);

  // ---- Tham gia bằng mã khoá học ----
  const handleJoin = async () => {
    const code = (joinCode || "").trim().toUpperCase();
    if (!code) return;
    try {
      await joinCourse({ code });
      setJoinCode("");
      await reload();
      alert("Tham gia khoá học thành công!");
    } catch (e) {
      console.error(e);
      const msg =
        e?.response?.data?.detail ||
        e?.response?.data?.non_field_errors?.[0] ||
        "Mã khoá học không hợp lệ hoặc bạn đã tham gia.";
      alert(msg);
    }
  };

  // ---- Tạo khoá học (teacher/admin) ----
  const handleCreate = async () => {
    if (!isTeacherLike) {
      alert("Chỉ giáo viên / admin được tạo khoá học");
      return;
    }
    if (!newTitle.trim()) {
      alert("Vui lòng nhập tiêu đề khoá học");
      return;
    }
    try {
      await createCourse({
        title: newTitle.trim(),
        description: newDesc || "",
      });
      setNewTitle("");
      setNewDesc("");
      await reload();
      alert("Tạo khoá học thành công!");
    } catch (err) {
      console.error(err);
      const msg =
        err?.response?.data?.detail ||
        JSON.stringify(err?.response?.data || err.message);
      alert(`Tạo khoá học thất bại: ${msg}`);
    }
  };

  return (
    <div className="max-w-6xl mx-auto px-4 py-6 space-y-6">
      <h1 className="text-2xl font-bold mb-1">Khoá học</h1>
      <p className="text-sm text-gray-500 mb-4">
        Danh sách các lớp bạn đang dạy hoặc tham gia.
      </p>

      {/* Join bằng mã khoá học (student + teacher đều dùng được) */}
      <div className="rounded-2xl border bg-white/90 p-4 shadow-sm">
        <h2 className="text-sm font-semibold mb-2">Tham gia bằng mã khoá học</h2>
        <div className="flex flex-col gap-3 sm:flex-row">
          <input
            className="flex-1 rounded-xl border border-gray-200 px-3 py-2 text-sm shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
            placeholder="Nhập mã khoá học (VD: AB3F9Z)"
            value={joinCode}
            onChange={(e) => setJoinCode(e.target.value)}
          />
          <button
            type="button"
            onClick={handleJoin}
            disabled={!joinCode.trim()}
            className="inline-flex items-center justify-center rounded-full bg-blue-600 px-4 py-2 text-sm font-semibold text-white shadow hover:bg-blue-700 disabled:opacity-50"
          >
            Tham gia
          </button>
        </div>
      </div>

      {/* Tạo khoá học (chỉ cho giáo viên / admin) */}
      {!meLoading && isTeacherLike && (
        <div className="rounded-2xl border bg-white/90 p-4 shadow-sm">
          <h2 className="text-sm font-semibold mb-3">Tạo khoá học mới</h2>
          <div className="grid grid-cols-1 gap-3 md:grid-cols-3">
            <input
              className="rounded-xl border border-gray-200 px-3 py-2 text-sm shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
              placeholder="Tiêu đề khoá học (bắt buộc)"
              value={newTitle}
              onChange={(e) => setNewTitle(e.target.value)}
            />
            <input
              className="rounded-xl border border-gray-200 px-3 py-2 text-sm shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
              placeholder="Mô tả (tuỳ chọn)"
              value={newDesc}
              onChange={(e) => setNewDesc(e.target.value)}
            />
            <div className="flex items-center">
              <button
                type="button"
                onClick={handleCreate}
                className="inline-flex w-full items-center justify-center rounded-full bg-blue-600 px-4 py-2 text-sm font-semibold text-white shadow hover:bg-blue-700"
              >
                Tạo khoá học
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Danh sách khoá học của mình */}
      <div className="rounded-2xl border bg-white/90 p-4 shadow-sm">
        <h2 className="text-sm font-semibold mb-3">Khoá học của tôi</h2>
        {loading ? (
          <div className="py-6">
            <Spinner />
          </div>
        ) : items.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-gray-200 px-4 py-8 text-center text-sm text-gray-500">
            Hiện tại bạn chưa có khoá học nào.
          </div>
        ) : (
          <div className="grid gap-4 md:grid-cols-2">
            {items.map((c) => (
                <CourseCard key={c.id} course={c} />
           ))}

          </div>
        )}
      </div>
    </div>
  );
}
