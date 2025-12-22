// src/pages/Users.jsx
import React, { useEffect, useState } from "react";
import api from "../api/api";
import EmptyState from "../components/EmptyState.jsx";
import Button from "../components/Button.jsx";

/**
 * Trang quản lý người dùng (Admin)
 * - Chỉ nên được truy cập qua ProtectedRoute requireRoles={["admin"]}
 */
export default function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [errText, setErrText] = useState("");
  const [savingId, setSavingId] = useState(null);

  const fetchUsers = async () => {
    setLoading(true);
    setErrText("");
    try {
      const res = await api.get("users/");
      const data = res?.data?.results ?? res?.data ?? [];
      setUsers(Array.isArray(data) ? data : []);
    } catch (e) {
      console.error("Users fetch error:", e);
      const msg =
        e?.response?.data?.detail ||
        e?.response?.data?.message ||
        e?.message ||
        "Không tải được danh sách người dùng.";
      setErrText(msg);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleChangeRole = async (userId, newRole) => {
    setSavingId(userId);
    try {
      await api.patch(`users/${userId}/`, { role: newRole });
      setUsers((prev) =>
        prev.map((u) =>
          u.id === userId ? { ...u, role: newRole } : u
        )
      );
    } catch (e) {
      console.error("Change role error:", e);
      const msg =
        e?.response?.data?.detail ||
        e?.response?.data?.message ||
        e?.message ||
        "Không thể cập nhật vai trò.";
      alert(msg);
    } finally {
      setSavingId(null);
    }
  };

  if (loading) {
    return (
      <div className="p-6">
        <div className="animate-pulse text-gray-500">
          Đang tải danh sách người dùng…
        </div>
      </div>
    );
  }

  if (errText) {
    return (
      <div className="p-6 space-y-4">
        <EmptyState title="Lỗi tải người dùng" hint={errText} />
        <Button onClick={fetchUsers}>Thử lại</Button>
      </div>
    );
  }

  if (!users.length) {
    return (
      <div className="p-6">
        <EmptyState
          title="Chưa có người dùng nào"
          hint="Hệ thống chưa có tài khoản, hãy đăng ký hoặc import người dùng."
        />
      </div>
    );
  }

  const roleOptions = [
    { value: "student", label: "Học sinh" },
    { value: "teacher", label: "Giáo viên" },
    { value: "admin", label: "Quản trị" },
  ];

  return (
    <div className="p-6 space-y-4">
      <header className="flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-semibold">
            Quản lý người dùng
          </h1>
          <p className="text-sm text-gray-500">
            Xem danh sách tài khoản, phân quyền giáo viên / học sinh / admin.
          </p>
        </div>
        <Button onClick={fetchUsers} size="sm">
          Làm mới
        </Button>
      </header>

      <div className="overflow-x-auto rounded-xl border bg-white">
        <table className="min-w-full text-sm">
          <thead className="bg-gray-50 text-xs uppercase text-gray-500">
            <tr>
              <th className="px-3 py-2 text-left">ID</th>
              <th className="px-3 py-2 text-left">Email</th>
              <th className="px-3 py-2 text-left">Tên</th>
              <th className="px-3 py-2 text-left">Vai trò</th>
              <th className="px-3 py-2 text-right">Hành động</th>
            </tr>
          </thead>
          <tbody>
            {users.map((u) => {
              const role = (u.role || "").toLowerCase();
              const badgeColor =
                role === "admin"
                  ? "bg-rose-100 text-rose-700"
                  : role === "teacher"
                  ? "bg-blue-100 text-blue-700"
                  : "bg-emerald-100 text-emerald-700";

              return (
                <tr
                  key={u.id}
                  className="border-t text-gray-700 hover:bg-gray-50"
                >
                  <td className="px-3 py-2">{u.id}</td>
                  <td className="px-3 py-2">{u.email}</td>
                  <td className="px-3 py-2">
                    {u.full_name || `${u.first_name || ""} ${u.last_name || ""}`.trim() ||
                      u.username ||
                      "—"}
                  </td>
                  <td className="px-3 py-2">
                    <span
                      className={
                        "inline-flex rounded-full px-2 py-0.5 text-xs font-medium " +
                        badgeColor
                      }
                    >
                      {u.role || "—"}
                    </span>
                  </td>
                  <td className="px-3 py-2 text-right">
                    <select
                      value={u.role || "student"}
                      disabled={savingId === u.id}
                      onChange={(e) =>
                        handleChangeRole(u.id, e.target.value)
                      }
                      className="rounded border border-gray-300 px-2 py-1 text-xs bg-white"
                    >
                      {roleOptions.map((opt) => (
                        <option key={opt.value} value={opt.value}>
                          {opt.label}
                        </option>
                      ))}
                    </select>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
}
