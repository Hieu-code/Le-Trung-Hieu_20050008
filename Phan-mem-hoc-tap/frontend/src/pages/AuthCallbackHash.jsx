import React, { useEffect, useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { useAuth } from "../store/auth";

function parseHash(hash) {
  const h = hash?.replace(/^#/, "") || "";
  const params = new URLSearchParams(h);

  return {
    access: params.get("access"),
    refresh: params.get("refresh"),
    email: params.get("email"),
    username: params.get("username"),
    state: params.get("state") || "/courses",
  };
}

export default function AuthCallbackHash() {
  const navigate = useNavigate();
  const location = useLocation();
  const { setAuthFromTokens } = useAuth();
  const [msg, setMsg] = useState("Đang xác thực Google...");

  useEffect(() => {
    (async () => {
      try {
        const { access, refresh, email, username, state } = parseHash(location.hash);

        if (!access || !refresh) {
          setMsg("Thiếu token trả về. Vui lòng đăng nhập lại.");
          return;
        }

        await setAuthFromTokens({
          access,
          refresh,
          user: email ? { email, username } : null,
        });

        setMsg("Thành công! Đang chuyển hướng...");
        navigate(state, { replace: true });
      } catch (err) {
        console.error(err);
        setMsg("Xác thực thất bại. Vui lòng đăng nhập lại.");
      }
    })();
  }, [location.hash, navigate, setAuthFromTokens]);

  return (
    <div className="min-h-screen flex items-center justify-center">
      <div className="rounded border bg-white px-4 py-3 shadow">{msg}</div>
    </div>
  );
}
