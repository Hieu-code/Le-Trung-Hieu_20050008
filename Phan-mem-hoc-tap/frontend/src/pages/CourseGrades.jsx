// src/pages/CourseGrades.jsx
import React, { useEffect, useState } from "react";
import { getCourseGrades } from "../api/api";
import Spinner from "../components/Spinner";

export default function CourseGrades({ courseId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    if (!courseId) return;
    setLoading(true);
    setError("");
    getCourseGrades(courseId)
      .then(setData)
      .catch((err) => {
        console.error("Failed to fetch grades", err);
        setError("Không thể tải bảng điểm.");
      })
      .finally(() => setLoading(false));
  }, [courseId]);

  if (loading) return <Spinner label="Đang tải bảng điểm..." />;
  if (error) return <p className="text-red-600">{error}</p>;
  if (!data || data.assignments.length === 0) {
    return <p className="text-gray-500">Chưa có bài tập nào trong khóa học.</p>;
  }

  const { assignments, grades } = data;

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full divide-y divide-gray-200">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Học sinh
            </th>
            {assignments.map((a) => (
              <th
                key={a.id}
                className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
              >
                {a.title} ({a.max_score || 10}đ)
              </th>
            ))}
          </tr>
        </thead>
        <tbody className="bg-white divide-y divide-gray-200">
          {grades.length === 0 && (
            <tr>
              <td
                colSpan={assignments.length + 1}
                className="p-4 text-center text-sm text-gray-500"
              >
                Chưa có học sinh nào trong lớp.
              </td>
            </tr>
          )}
          {grades.map((g) => (
            <tr key={g.user.id}>
              <td className="px-3 py-2 whitespace-nowrap text-sm font-medium text-gray-900">
                {g.user.email}
              </td>
              {assignments.map((a) => (
                <td
                  key={a.id}
                  className="px-3 py-2 whitespace-nowrap text-sm text-gray-500"
                >
                  {g.scores[a.id] != null ? (
                    <span className="font-semibold text-gray-800">
                      {g.scores[a.id]}
                    </span>
                  ) : (
                    "—"
                  )}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}