// src/pages/Register.jsx
import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../store/auth";

export default function Register() {
  const { register, authLoading } = useAuth();
  const navigate = useNavigate();

  const [form, setForm] = useState({
    email: "",
    full_name: "",
    password: "",
    password2: "",
    role: "student", // Mặc định là học sinh
  });
  const [error, setError] = useState("");

  const onChange = (e) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  const onSubmit = async (e) => {
    e.preventDefault();
    setError("");

    if (form.password !== form.password2) {
      setError("Mật khẩu nhập lại không khớp.");
      return;
    }

    try {
      // Gửi role lên backend
      await register({
        email: form.email,
        full_name: form.full_name,
        password: form.password,
        role: form.role, 
      });
      // Đăng ký xong chuyển về Login hoặc Dashboard
      navigate("/dashboard");
    } catch (err) {
      console.error(err);
      const data = err?.response?.data || {};
      // Lấy lỗi chi tiết từ backend trả về
      const detail =
        data.detail ||
        data.email?.[0] ||
        data.password?.[0] ||
        "Đăng ký thất bại. Vui lòng kiểm tra lại.";
      setError(detail);
    }
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-gray-50 p-4">
      <div className="w-full max-w-md bg-white p-8 rounded-2xl shadow-lg">
        <h1 className="text-2xl font-bold text-center text-gray-900 mb-2">
          Đăng ký tài khoản
        </h1>
        <p className="text-center text-gray-500 text-sm mb-6">
          Tham gia hệ thống MiniLMS ngay hôm nay
        </p>

        {error && (
          <div className="mb-4 rounded-lg bg-red-50 p-3 text-sm text-red-600 border border-red-100">
            {error}
          </div>
        )}

        <form onSubmit={onSubmit} className="space-y-4">
          {/* Chọn vai trò */}
          <div>
            <label className="mb-1 block text-xs font-medium text-gray-700">
              Bạn là:
            </label>
            <div className="grid grid-cols-2 gap-3">
              <button
                type="button"
                className={`py-2 rounded-xl text-sm font-medium border ${
                  form.role === "student"
                    ? "bg-blue-50 border-blue-500 text-blue-700"
                    : "bg-white border-gray-200 text-gray-600 hover:bg-gray-50"
                }`}
                onClick={() => setForm({ ...form, role: "student" })}
              >
                👨‍🎓 Học sinh
              </button>
              <button
                type="button"
                className={`py-2 rounded-xl text-sm font-medium border ${
                  form.role === "teacher"
                    ? "bg-blue-50 border-blue-500 text-blue-700"
                    : "bg-white border-gray-200 text-gray-600 hover:bg-gray-50"
                }`}
                onClick={() => setForm({ ...form, role: "teacher" })}
              >
                👩‍🏫 Giáo viên
              </button>
            </div>
          </div>

          <div>
            <label className="mb-1 block text-xs font-medium text-gray-700">
              Họ và tên
            </label>
            <input
              type="text"
              name="full_name"
              required
              value={form.full_name}
              onChange={onChange}
              placeholder="Nguyễn Văn A"
              className="w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
            />
          </div>

          <div>
            <label className="mb-1 block text-xs font-medium text-gray-700">
              Email
            </label>
            <input
              type="email"
              name="email"
              required
              value={form.email}
              onChange={onChange}
              placeholder="email@example.com"
              className="w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="mb-1 block text-xs font-medium text-gray-700">
                Mật khẩu
              </label>
              <input
                type="password"
                name="password"
                required
                minLength={6}
                value={form.password}
                onChange={onChange}
                className="w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="mb-1 block text-xs font-medium text-gray-700">
                Nhập lại mật khẩu
              </label>
              <input
                type="password"
                name="password2"
                required
                minLength={6}
                value={form.password2}
                onChange={onChange}
                className="w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
              />
            </div>
          </div>

          <button
            type="submit"
            disabled={authLoading}
            className="mt-4 flex w-full items-center justify-center rounded-full bg-blue-600 px-4 py-2.5 text-sm font-bold text-white shadow hover:bg-blue-700 disabled:opacity-60 transition"
          >
            {authLoading ? "Đang xử lý..." : "Đăng ký ngay"}
          </button>
        </form>

        <p className="mt-6 text-center text-xs text-gray-600">
          Đã có tài khoản?{" "}
          <Link to="/login" className="font-medium text-blue-600 hover:underline">
            Đăng nhập
          </Link>
        </p>
      </div>
    </div>
  );
}