// src/pages/Materials.jsx
import React, { useEffect, useState } from "react";
import api from "../api/api";
import MaterialUploadForm from "../components/MaterialUploadForm";
import MaterialList from "../components/MaterialList";
import { useAuth } from "../store/auth";

export default function Materials() {
  const { user } = useAuth();
  const isTeacherOrAdmin =
    user?.role === "teacher" || user?.role === "admin";

  const [courses, setCourses] = useState([]);
  const [materials, setMaterials] = useState([]);
  const [loading, setLoading] = useState(false);

  const loadCourses = async () => {
    try {
      const res = await api.get("courses/", { params: { mine: true } });
      const data = res.data?.results ?? res.data ?? [];
      setCourses(Array.isArray(data) ? data : []);
    } catch (e) {
      console.error(e);
      setCourses([]);
    }
  };

  const loadMaterials = async () => {
    setLoading(true);
    try {
      const res = await api.get("materials/");
      const data = res.data?.results ?? res.data ?? [];
      setMaterials(Array.isArray(data) ? data : []);
    } catch (e) {
      console.error(e);
      setMaterials([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadCourses();
    loadMaterials();
  }, []);

  return (
    <div className="max-w-6xl mx-auto px-4 py-6 space-y-6">
      <div>
        <h1 className="text-2xl font-semibold">Tài liệu</h1>
        <p className="mt-1 text-sm text-gray-500">
          Quản lý tất cả tài liệu đã gắn với bài học trong các khoá học của bạn.
        </p>
      </div>

      {/* Upload – chỉ teacher/admin */}
      {isTeacherOrAdmin && (
        <div className="rounded-2xl border bg-white p-4 shadow-sm">
          <h2 className="text-sm font-semibold text-gray-800 mb-3">
            Tải tài liệu lên
          </h2>
          <p className="text-xs text-gray-500 mb-3">
            Chọn khoá học → chương → bài học, sau đó chọn loại tài liệu (tệp,
            link, video, audio).
          </p>
          <MaterialUploadForm courses={courses} onUploaded={loadMaterials} />
        </div>
      )}

      {/* List */}
      <div className="rounded-2xl border bg-white p-4 shadow-sm">
        <div className="flex items-center justify-between mb-3">
          <h2 className="text-sm font-semibold text-gray-800">
            Danh sách tài liệu
          </h2>
          {loading && (
            <span className="text-xs text-gray-500">Đang tải…</span>
          )}
        </div>

        {loading ? (
          <div className="text-sm text-gray-500">Đang tải dữ liệu…</div>
        ) : (
          <MaterialList items={materials} canEdit={isTeacherOrAdmin} />
        )}
      </div>
    </div>
  );
}
