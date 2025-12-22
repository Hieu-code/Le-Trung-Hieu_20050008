// src/components/GoogleLoginButton.jsx
import React from "react";

export default function GoogleLoginButton() {
  const start = () => {
    const clientId = import.meta.env.VITE_GOOGLE_CLIENT_ID;
    const redirectUri =
      (import.meta.env.VITE_GOOGLE_REDIRECT_URI ||
        "http://127.0.0.1:8000/api/users/google/").replace(/\/+$/, "/");

    if (!clientId) {
      alert("Thiếu VITE_GOOGLE_CLIENT_ID trong frontend/.env");
      return;
    }

    const auth = new URL("https://accounts.google.com/o/oauth2/v2/auth");
    auth.searchParams.set("client_id", clientId);
    auth.searchParams.set("redirect_uri", redirectUri);
    auth.searchParams.set("response_type", "code");
    auth.searchParams.set(
      "scope",
      "openid email profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile"
    );
    auth.searchParams.set("prompt", "consent"); // luôn hỏi để lấy code mới
    auth.searchParams.set("access_type", "online"); // đủ cho đổi code -> JWT ở BE

    // (Tuỳ chọn) mang theo 'state' để khi quay về FE có thể biết điều hướng đi đâu
    const from = window.location.pathname + window.location.search;
    auth.searchParams.set("state", from);

    window.location.href = auth.toString();
  };

  return (
    <button
      type="button"
      onClick={start}
      className="w-full border rounded-md py-2 flex items-center justify-center hover:bg-gray-50 transition"
      aria-label="Đăng nhập bằng Google"
    >
      <img
        alt="Google"
        src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg"
        className="h-5 mr-2"
      />
      <span>Đăng nhập bằng Google</span>
    </button>
  );
}
