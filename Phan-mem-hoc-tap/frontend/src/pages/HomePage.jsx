import React from "react";
import { Link } from "react-router-dom";
import Button from "../components/Button.jsx";
export default function HomePage() {
  return (
    <div className="space-y-16">
      <header className="text-center py-16">
        <h1 className="text-5xl font-bold mb-3">MiniLMS</h1>
        <p className="text-gray-600">Giải pháp LMS gọn nhẹ, dễ dùng và nhanh chóng triển khai.</p>
        <div className="mt-8">
          <Link to="/register"><Button>Đăng ký</Button></Link>
        </div>
      </header>
    </div>
  );
}
