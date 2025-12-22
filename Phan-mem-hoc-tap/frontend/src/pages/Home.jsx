// src/pages/Home.jsx
import React from "react";
import { Link } from "react-router-dom";
import Button from "../components/Button.jsx";
import { getAccessToken } from "../api/api";

export default function Home() {
  const access = getAccessToken();

  let user = null;
  try {
    user = JSON.parse(localStorage.getItem("me") || "null");
  } catch {
    user = null;
  }

  const role = (user?.role || "").toLowerCase();

  let dest = "/dashboard";
  if (role === "teacher" || role === "admin") {
    dest = "/teacher/dashboard";
  } else if (role === "student") {
    dest = "/student/dashboard";
  }

  return (
    <div className="space-y-12">
      <section className="text-center py-16 bg-gradient-to-b from-white to-blue-50 rounded-2xl border">
        <h1 className="text-4xl font-bold mb-3">
          Học tập thông minh hơn, dễ dàng hơn
        </h1>
        <p className="text-gray-600 mb-8 max-w-2xl mx-auto">
          MiniLMS – nền tảng gọn nhẹ để giáo viên tạo khóa học, giao bài tập,
          trắc nghiệm; học sinh tham gia và theo dõi tiến độ nhanh chóng.
        </p>
        <div className="flex gap-3 justify-center">
          {access ? (
            <Link to={dest}>
              <Button>Vào bảng điều khiển</Button>
            </Link>
          ) : (
            <>
              <Link to="/register">
                <Button>Bắt đầu miễn phí</Button>
              </Link>
              <Link
                to="/login"
                className="px-4 py-2 rounded-md border bg-white text-gray-700"
              >
                Tôi đã có tài khoản
              </Link>
            </>
          )}
        </div>
      </section>
    </div>
  );
}
