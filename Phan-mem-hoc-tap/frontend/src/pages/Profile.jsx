// src/pages/Profile.jsx
import React, { useEffect, useState } from "react";
import api, { getMe } from "../api/api";

export default function Profile() {
  const [me, setMe] = useState(null);
  const [myProgress, setMyProgress] = useState([]);
  const [err, setErr] = useState("");

  useEffect(() => {
    (async () => {
      try {
        const u = await getMe();
        setMe(u);
        localStorage.setItem("me", JSON.stringify(u || null));
      } catch (e) {
        setErr("Không lấy được thông tin người dùng. Hãy đăng nhập lại.");
        console.error(e);
      }

      try {
        const resp = await api.get("progress/", {
          params: { mine: true },
        });
        const data = resp.data;
        setMyProgress(data?.results || data || []);
      } catch (e) {
        // API tiến độ có thể chưa có dữ liệu, không cần crash
        console.warn("Không lấy được tiến độ:", e);
      }
    })();
  }, []);

  return (
    <div className="p-4 space-y-4">
      <h1 className="text-2xl font-semibold">Hồ sơ cá nhân</h1>

      {err && <div className="text-sm text-red-600">{err}</div>}

      {me && (
        <div className="bg-white rounded-xl shadow p-4">
          <div className="grid md:grid-cols-2 gap-3">
            <div>
              <span className="text-gray-600">ID:</span>{" "}
              <b>{me.id}</b>
            </div>
            <div>
              <span className="text-gray-600">Email:</span>{" "}
              <b>{me.email}</b>
            </div>
            <div>
              <span className="text-gray-600">Vai trò:</span>{" "}
              <b>{me.role || "-"}</b>
            </div>
          </div>
        </div>
      )}

      <div className="bg-white rounded-xl shadow p-4">
        <h2 className="text-lg font-semibold mb-2">Tiến độ của tôi</h2>
        <div className="grid md:grid-cols-3 gap-3">
          {(myProgress || []).map((p) => (
            <div
              key={p.id || `${p.course}-${p.user || ""}`}
              className="border rounded p-3"
            >
              <div className="text-gray-600 text-sm">
                Khoá học #{p.course}
              </div>
              <div className="text-2xl font-semibold">
                {Number(p.percent) || 0}%
              </div>
              <div className="text-xs text-gray-500">
                Cập nhật: {p.last_activity_at || "-"}
              </div>
            </div>
          ))}

          {(!myProgress || myProgress.length === 0) && (
            <div className="text-gray-500">Chưa có dữ liệu tiến độ.</div>
          )}
        </div>
      </div>
    </div>
  );
}
