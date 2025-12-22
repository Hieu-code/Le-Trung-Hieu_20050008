import React, { createContext, useCallback, useContext, useEffect, useState } from "react";
import {
  getAccessToken,
  setTokens,
  clearTokens,
  getMe as apiGetMe,
  login as apiLogin,
  register as apiRegister,
  logout as apiLogout,
} from "../api/api";

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  const loadUserFromTokens = useCallback(async () => {
    setIsLoading(true);
    try {
      const access = getAccessToken();
      if (!access) {
        setUser(null);
        return;
      }
      const me = await apiGetMe();
      setUser(me);
    } catch (err) {
      clearTokens();
      setUser(null);
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    loadUserFromTokens();
  }, [loadUserFromTokens]);

  const login = useCallback(
    async (creds) => {
      setIsLoading(true);
      try {
        const data = await apiLogin(creds);
        if (data?.access) {
          setTokens({ access: data.access, refresh: data.refresh });
          // Đợi 1 nhịp để token “ăn” vào header/interceptor
          await new Promise((r) => setTimeout(r, 50));
          await loadUserFromTokens();
        }
      } catch (err) {
        console.error(err);
        setError(err.response?.data || { detail: "Đăng nhập thất bại" });
        throw err;
      } finally {
        setIsLoading(false);
      }
    },
    [loadUserFromTokens]
  );

  const register = useCallback(async (payload) => {
    setIsLoading(true);
    try {
      await apiRegister(payload);
    } catch (err) {
      setError(err.response?.data || { detail: "Đăng ký thất bại" });
      throw err;
    } finally {
      setIsLoading(false);
    }
  }, []);

  // ✅ BỔ SUNG: dùng cho Google OAuth callback (fix lỗi setAuthFromTokens is not a function)
  const setAuthFromTokens = useCallback(
    async ({ access, refresh, user: userHint = null }) => {
      setIsLoading(true);
      try {
        if (!access || !refresh) throw new Error("Missing tokens");

        setTokens({ access, refresh });

        // set tạm nếu có (không bắt buộc)
        if (userHint) setUser(userHint);

        // Đợi 1 nhịp rồi gọi /me để lấy user chuẩn
        await new Promise((r) => setTimeout(r, 50));
        await loadUserFromTokens();
      } finally {
        setIsLoading(false);
      }
    },
    [loadUserFromTokens]
  );

  const logout = useCallback(async () => {
    try {
      await apiLogout?.();
    } catch (e) {
      // bỏ qua lỗi server-side
    } finally {
      clearTokens();
      setUser(null);
    }
  }, []);

  return (
    <AuthContext.Provider
      value={{
        user,
        isLoading,
        initializing: isLoading, // ✅ alias để tương thích ProtectedRoute nếu đang dùng `initializing`
        error,
        login,
        register,
        logout,
        setAuthFromTokens,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  return useContext(AuthContext);
}
