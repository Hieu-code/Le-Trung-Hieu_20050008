// src/components/CourseCard.jsx
import React from "react";
import { Link } from "react-router-dom";

/**
 * Card hiển thị thông tin khoá học.
 *
 * Props:
 * - course: object khoá học từ API (id, title, description, code, students_count, teachers_count, ...)
 * - to?: custom link, mặc định là `/courses/{id}`
 */
export default function CourseCard({ course, to }) {
  if (!course) return null;

  const href = to || `/courses/${course.id}`;

  return (
    <Link to={href} className="block">
      <div className="flex h-full flex-col rounded-2xl border border-gray-100 bg-white px-4 py-3 shadow-sm transition hover:-translate-y-0.5 hover:shadow-md">
        {/* Tiêu đề khoá học */}
        <div className="mb-1 text-sm font-semibold text-gray-900">
          {course.title || "Khoá học chưa đặt tên"}
        </div>

        {/* Mô tả ngắn */}
        {course.description && (
          <div className="mb-2 text-xs text-gray-500 line-clamp-2">
            {course.description}
          </div>
        )}

        {/* Thông tin mã + số lượng */}
        <div className="mt-auto flex items-center justify-between text-[11px] text-gray-500">
          <span>
            Mã:{" "}
            <strong className="font-mono tracking-wider">
              {course.code || "—"}
            </strong>
          </span>
          <span>
            {course.students_count ?? 0} học sinh ·{" "}
            {course.teachers_count ?? 0} giáo viên
          </span>
        </div>
      </div>
    </Link>
  );
}
