// src/components/EmptyState.jsx
import React from "react";

export default function EmptyState({ title = "Không có dữ liệu", hint }) {
  return (
    <div className="border border-dashed rounded-xl p-6 text-center bg-white">
      <div className="text-gray-800 font-medium">{title}</div>
      {hint && <div className="text-gray-500 text-sm mt-1">{hint}</div>}
    </div>
  );
}
