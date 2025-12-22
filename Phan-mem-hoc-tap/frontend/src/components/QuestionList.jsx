import React from "react";

export default function QuestionList({ items, emptyText = "Không có dữ liệu" }) {
  if (!items?.length) return <div className="empty-box">{emptyText}</div>;
  return (
    <ul className="space-y-2">
      {items.map((q) => (
        <li key={q.id} className="p-3 rounded border bg-white">
          <div className="font-medium">{q.text}</div>
          {q.options?.length ? (
            <ul className="mt-2 grid sm:grid-cols-2 gap-2 text-sm text-gray-600">
              {q.options.map((o, i) => (
                <li key={i} className="px-3 py-2 rounded bg-gray-50">{o}</li>
              ))}
            </ul>
          ) : null}
        </li>
      ))}
    </ul>
  );
}
