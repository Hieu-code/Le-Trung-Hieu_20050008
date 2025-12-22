// src/pages/AssignmentCreate.jsx
import React, { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import http, { getMe, listCourses } from "../api/api";
import Button from "../components/Button.jsx";
import Spinner from "../components/Spinner.jsx";

export default function AssignmentCreate() {
  const navigate = useNavigate();

  const [me, setMe] = useState(null);
  const [meLoading, setMeLoading] = useState(true);
  const [courses, setCourses] = useState([]);
  const [loadingCourses, setLoadingCourses] = useState(true);

  const [form, setForm] = useState({
    course: "",
    title: "",
    description: "",
    due_at: "",
    max_score: 10,
  });
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    const boot = async () => {
      try {
        const data = await getMe();
        setMe(data);
        localStorage.setItem("me", JSON.stringify(data));
      } catch {
        const cached = JSON.parse(localStorage.getItem("me") || "null");
        setMe(cached);
      } finally {
        setMeLoading(false);
      }
    };
    boot();
  }, []);

  const isTeacherLike = useMemo(() => {
    const role = (me?.role || "").toString().toLowerCase();
    return role === "teacher" || role === "admin";
  }, [me]);

  useEffect(() => {
    const loadCourses = async () => {
      setLoadingCourses(true);
      try {
        const res = await listCourses({ mine: true, ordering: "title" });
        const data = res?.results || res || [];
        const arr = Array.isArray(data) ? data : [];
        setCourses(arr);
        if (arr.length && !form.course) {
          setForm((s) => ({ ...s, course: String(arr[0].id) }));
        }
      } catch (e) {
        console.error(e);
        setCourses([]);
      } finally {
        setLoadingCourses(false);
      }
    };
    loadCourses();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const change = (e) => {
    const { name, value } = e.target;
    setForm((s) => ({ ...s, [name]: value }));
  };

  const submit = async (e) => {
    e.preventDefault();
    setError("");

    if (!isTeacherLike) {
      alert("Chỉ giáo viên / admin mới được tạo bài tập.");
      return;
    }
    if (!form.course) {
      setError("Vui lòng chọn khoá học.");
      return;
    }
    if (!form.title.trim()) {
      setError("Vui lòng nhập tiêu đề bài tập.");
      return;
    }

    setSubmitting(true);
    try {
      const payload = {
        course: Number(form.course),
        title: form.title.trim(),
        description: form.description.trim(),
        max_score:
          form.max_score === "" || form.max_score == null
            ? null
            : Number(form.max_score),
      };

      if (form.due_at) {
        const local = new Date(form.due_at);
        if (!Number.isNaN(local.getTime())) {
          payload.due_at = local.toISOString();
        }
      }

      await http.post("assignments/", payload);
      alert("Tạo bài tập thành công!");
      navigate("/assignments", { replace: true });
    } catch (err) {
      console.error(err);
      const resp = err?.response?.data;
      let msg = "Tạo bài tập thất bại, vui lòng kiểm tra lại.";
      if (resp && typeof resp === "object") {
        const key = Object.keys(resp)[0];
        if (key) {
          const v = resp[key];
          if (Array.isArray(v) && v[0]) msg = String(v[0]);
          else if (typeof v === "string") msg = v;
        }
      }
      setError(msg);
    } finally {
      setSubmitting(false);
    }
  };

  if (meLoading || loadingCourses) {
    return (
      <div className="max-w-4xl mx-auto px-4 py-10">
        <Spinner />
      </div>
    );
  }

  if (!isTeacherLike) {
    return (
      <div className="max-w-4xl mx-auto px-4 py-10">
        <p className="text-sm text-gray-600">
          Bạn không có quyền tạo bài tập. Vui lòng đăng nhập bằng tài khoản
          giáo viên / admin.
        </p>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto px-4 py-6">
      <h1 className="text-2xl md:text-3xl font-bold mb-4">
        Tạo bài tập mới
      </h1>

      <div className="rounded-2xl border bg-white p-5 shadow-sm space-y-4">
        {error && (
          <div className="rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-700">
            {error}
          </div>
        )}

        <form onSubmit={submit} className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <div className="space-y-1">
              <label className="text-sm font-medium text-gray-700">
                Khoá học
              </label>
              <select
                name="course"
                value={form.course}
                onChange={change}
                className="w-full rounded-lg border px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/50"
              >
                <option value="">— Chọn khoá học —</option>
                {courses.map((c) => (
                  <option key={c.id} value={c.id}>
                    {c.title}
                  </option>
                ))}
              </select>
            </div>

            <div className="space-y-1">
              <label className="text-sm font-medium text-gray-700">
                Hạn nộp (tuỳ chọn)
              </label>
              <input
                type="datetime-local"
                name="due_at"
                value={form.due_at}
                onChange={change}
                className="w-full rounded-lg border px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/50"
              />
            </div>
          </div>

          <div className="space-y-1">
            <label className="text-sm font-medium text-gray-700">
              Tiêu đề bài tập
            </label>
            <input
              name="title"
              value={form.title}
              onChange={change}
              className="w-full rounded-lg border px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/50"
              placeholder="Ví dụ: Bài tập số 1: Ôn tập chương 1"
              required
            />
          </div>

          <div className="space-y-1">
            <label className="text-sm font-medium text-gray-700">
              Mô tả / Hướng dẫn
            </label>
            <textarea
              name="description"
              value={form.description}
              onChange={change}
              rows={5}
              className="w-full rounded-lg border px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/50"
              placeholder="Mô tả chi tiết yêu cầu bài tập, tài liệu tham khảo, cách tính điểm..."
            />
          </div>

          <div className="space-y-1 max-w-xs">
            <label className="text-sm font-medium text-gray-700">
              Điểm tối đa
            </label>
            <input
              type="number"
              name="max_score"
              min="0"
              value={form.max_score}
              onChange={change}
              className="w-full rounded-lg border px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/50"
            />
          </div>

          <div className="pt-2 flex items-center gap-3">
            <Button type="submit" disabled={submitting}>
              {submitting ? "Đang tạo..." : "Tạo bài tập"}
            </Button>
            <button
              type="button"
              className="text-sm text-gray-600 hover:text-blue-600"
              onClick={() => navigate(-1)}
            >
              Huỷ
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
