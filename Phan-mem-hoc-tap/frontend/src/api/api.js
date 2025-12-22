import axios from "axios";

const API_ROOT = (import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/api").replace(/\/+$/, "");
export const API = API_ROOT;

const ACCESS_KEY = "accessToken";
const REFRESH_KEY = "refreshToken";

export function getAccessToken() { return localStorage.getItem(ACCESS_KEY); }
export function getRefreshToken() { return localStorage.getItem(REFRESH_KEY); }

// 👇 ĐÃ SỬA: Cập nhật Header ngay lập tức để tránh lỗi 401
export function setTokens({ access, refresh }) {
  if (access) {
    localStorage.setItem(ACCESS_KEY, access);
    http.defaults.headers.common["Authorization"] = `Bearer ${access}`;
  }
  if (refresh) {
    localStorage.setItem(REFRESH_KEY, refresh);
  }
}

export function clearTokens() {
  localStorage.removeItem(ACCESS_KEY);
  localStorage.removeItem(REFRESH_KEY);
  localStorage.removeItem("me");
  delete http.defaults.headers.common["Authorization"];
}

const http = axios.create({
  baseURL: API_ROOT,
  headers: { "Content-Type": "application/json" },
});

// Interceptor: Tự động gắn Token (Backup)
http.interceptors.request.use(
  (config) => {
    const token = getAccessToken();
    if (token) config.headers.Authorization = `Bearer ${token}`;
    return config;
  },
  (error) => Promise.reject(error)
);

// Interceptor: Refresh Token tự động
http.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    if (error.response?.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;
      try {
        const refreshToken = getRefreshToken();
        if (!refreshToken) throw new Error("No refresh token");
        
        const { data } = await axios.post(`${API_ROOT}/users/token/refresh/`, { refresh: refreshToken });
        setTokens({ access: data.access }); // Update header ngay
        return http(originalRequest);
      } catch (err) {
        clearTokens();
        // Không reload trang tự động để tránh vòng lặp vô tận nếu lỗi hệ thống
        window.location.href = "/login"; 
        return Promise.reject(err);
      }
    }
    return Promise.reject(error);
  }
);

export default http;

/* ================= API ENDPOINTS ================= */

export const login = (creds) => http.post("users/login/", creds).then(r => r.data);
export const register = (data) => http.post("users/register/", data).then(r => r.data);
export const getMe = () => http.get("users/me/").then(r => r.data);
export const logout = (refreshToken) => http.post("users/logout/", { refresh: refreshToken });

export const listCourses = (params) => http.get("courses/", { params }).then(r => r.data);
export const getCourse = (id) => http.get(`courses/${id}/`).then(r => r.data);
export const createCourse = (data) => http.post("courses/", data).then(r => r.data);
export const joinCourse = ({ code }) =>
  http.post("courses/join/", { code }).then((r) => r.data);


export const getCourseAnalytics = (id) => http.get(`courses/${id}/analytics/`).then(r => r.data);
export const getCourseGrades = (id) => http.get(`courses/${id}/grades/`).then(r => r.data);

export const listSections = (params) => http.get("sections/", { params }).then(r => r.data);
export const createSection = (data) => http.post("sections/", data).then(r => r.data);
export const updateSection = (id, data) => http.patch(`sections/${id}/`, data).then(r => r.data);
export const deleteSection = (id) => http.delete(`sections/${id}/`);

export const listLessons = (params) => http.get("lessons/", { params }).then(r => r.data);
export const createLesson = (data) => http.post("lessons/", data).then(r => r.data);
export const updateLesson = (id, data) => http.patch(`lessons/${id}/`, data).then(r => r.data);
export const deleteLesson = (id) => http.delete(`lessons/${id}/`);

export const listMaterials = (params) => http.get("materials/", { params }).then(r => r.data);
export const createMaterial = (data) => http.post("materials/", data, { headers: { "Content-Type": "multipart/form-data" } }).then(r => r.data);
export const deleteMaterial = (id) => http.delete(`materials/${id}/`);

export const listAssignments = (params) => http.get("assignments/", { params }).then(r => r.data);
export const getAssignment = (id) => http.get(`assignments/${id}/`).then(r => r.data);
export const createAssignment = (data) => http.post("assignments/", data).then(r => r.data);

export const listSubmissions = (params) => http.get("submissions/", { params }).then(r => r.data);
export const createSubmission = (data) => http.post("submissions/", data, { headers: { "Content-Type": "multipart/form-data" } }).then(r => r.data);
export const updateSubmission = (id, data) => http.patch(`submissions/${id}/`, data, { headers: { "Content-Type": "multipart/form-data" } }).then(r => r.data);
export const returnSubmission = (id) => http.post(`submissions/${id}/return_submission/`).then(r => r.data);

export const listQuizzes = (params) => http.get("quizzes/", { params }).then(r => r.data);
export const getQuiz = (id) => http.get(`quizzes/${id}/`).then(r => r.data);
export const createQuiz = (d) => http.post("quizzes/", d).then(r => r.data);
export const updateQuiz = (id, d) => http.patch(`quizzes/${id}/`, d).then(r => r.data);
export const deleteQuiz = (id) => http.delete(`quizzes/${id}/`);
export const submitQuiz = (id, answers) => http.post(`quizzes/${id}/attempt/`, { answers }).then(r => r.data);

export const listQuestions = (params) => http.get("questions/", { params }).then(r => r.data);
export const createQuestion = (d) => http.post("questions/", d).then(r => r.data);
export const deleteQuestion = (id) => http.delete(`questions/${id}/`);
export const createChoice = (d) => http.post("choices/", d).then(r => r.data);
export const deleteChoice = (id) => http.delete(`choices/${id}/`);

export const listAnnouncements = (params) => http.get("announcements/", { params }).then(r => r.data);
export const createAnnouncement = (d) => http.post("announcements/", d).then(r => r.data);
export const listComments = (params) => http.get("comments/", { params }).then(r => r.data);
export const createComment = (d) => http.post("comments/", d).then(r => r.data);

export const listSchedules = (params) => http.get("schedules/", { params }).then(r => r.data);
export const createSchedule = (d) => http.post("schedules/", d).then(r => r.data);
export const deleteSchedule = (id) => http.delete(`schedules/${id}/`);

export const listNotifications = (params) => http.get("notifications/", { params }).then(r => r.data);
export const markReadNotification = (id) => http.post(`notifications/${id}/mark_as_read/`).then(r => r.data);
export const markAllRead = () => http.post("notifications/mark_all_read/").then(r => r.data);

export const listThreads = (params) => http.get("discussions/", { params }).then(r => r.data);
export const createThread = (d) => http.post("discussions/", d).then(r => r.data);
export const listPosts = (params) => http.get("posts/", { params }).then(r => r.data);
export const createPost = (d) => http.post("posts/", d).then(r => r.data);
export const generateQuizAI = (data) => http.post("quizzes/generate-ai/", data).then(r => r.data);
