import React, { useEffect, useState, useCallback } from "react";
import { useNavigate, useParams, Link, useSearchParams } from "react-router-dom";
import api, { getCourse, getMe, listSections, deleteSection } from "../api/api";
import SectionForm from "../components/SectionForm.jsx";
import Lessons from "./Lessons.jsx";
import Spinner from "../components/Spinner.jsx";
import AnnouncementList from "../components/AnnouncementList.jsx";
import CourseGrades from "./CourseGrades.jsx";
import DiscussionBoard from "../components/DiscussionBoard.jsx";

// Import các tính năng nâng cao
import UpcomingWidget from "../components/UpcomingWidget.jsx";
import AttendanceManager from "../components/AttendanceManager.jsx";
import AssignmentList from "../components/AssignmentList.jsx";

export default function CourseDetail() {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();

  const [me, setMe] = useState(null);
  const [course, setCourse] = useState(null);
  const [sections, setSections] = useState([]);
  
  const [activeSectionId, setActiveSectionId] = useState(null); 
  const activeTab = searchParams.get("tab") || "stream"; 
  
  const [loading, setLoading] = useState(true);
  const [refreshKey, setRefreshKey] = useState(0); 

  const [isEditingLink, setIsEditingLink] = useState(false);
  const [meetingLink, setMeetingLink] = useState("");
  const [bannerColor, setBannerColor] = useState("bg-blue-600");

  useEffect(() => {
    const colors = ["bg-blue-600", "bg-purple-600", "bg-teal-600", "bg-indigo-600", "bg-orange-600"];
    setBannerColor(colors[courseId % colors.length] || "bg-blue-600");
  }, [courseId]);

  // HÀM TẢI DỮ LIỆU (Auto-refresh)
  const fetchData = useCallback(async (isSilent = false) => {
    try {
      if (!isSilent) setLoading(true);
      
      const [u, c, s] = await Promise.all([
          getMe(),
          getCourse(courseId),
          listSections({ course: courseId })
      ]);

      setMe(u);
      setCourse(c);
      
      if (!isSilent) setMeetingLink(c.meeting_link || ""); 
      
      const sectionList = s.results || s || [];
      setSections(sectionList);
      
      setActiveSectionId(prev => {
          if (sectionList.length > 0 && !prev) return sectionList[0].id;
          return prev;
      });

    } catch (e) {
      if(e.response && e.response.status === 404) navigate("/dashboard");
    } finally {
      if (!isSilent) setLoading(false);
    }
  }, [courseId, navigate]);

  useEffect(() => {
    fetchData(false);
  }, [fetchData, refreshKey]);

  useEffect(() => {
    const interval = setInterval(() => {
        if (activeTab === 'classwork' || activeTab === 'stream') {
            fetchData(true);
        }
    }, 5000); 

    return () => clearInterval(interval); 
  }, [fetchData, activeTab]);


  const isTeacherLike = (me?.role === "teacher" || me?.role === "admin") && 
                        (course?.owner?.id === me?.id || me?.role === "admin");

  const handleSaveMeetingLink = async () => {
      try {
          await api.patch(`courses/${courseId}/`, { meeting_link: meetingLink });
          setCourse({...course, meeting_link: meetingLink});
          setIsEditingLink(false);
          alert("Đã lưu link!");
      } catch(e) { alert("Lỗi cập nhật link."); }
  };

  const handleDeleteSection = async (id) => {
      if(!confirm("Bạn có chắc muốn xóa chương này?")) return;
      try { await deleteSection(id); setRefreshKey(k => k+1); } catch(e) {}
  };

  const changeTab = (tab) => setSearchParams({ tab });

  if (loading) return <div className="flex h-screen items-center justify-center"><Spinner /></div>;
  if (!course) return <div className="text-center py-10">Không tìm thấy khoá học</div>;

  return (
    <div className="min-h-screen bg-gray-50 pb-20">
      
      {/* 1. NAVIGATION BAR (ĐÃ SỬA RESPONSIVE) */}
      <div className="bg-white border-b sticky top-0 z-20 shadow-sm pt-2 mb-6 w-full">
          {/* Thêm: overflow-x-auto, scrollbar-hide, flex-nowrap */}
          <div className="max-w-6xl mx-auto px-4 flex items-center gap-6 overflow-x-auto scrollbar-hide flex-nowrap">
              {['stream', 'classwork', 'assignments', 'discussion', 'attendance', 'grades'].map(tab => {
                  // Ẩn tab Grades với học sinh
                  if (tab === 'grades' && !isTeacherLike) return null;
                  
                  // Đặt tên hiển thị
                  const label = {
                      stream: "Bảng tin",
                      classwork: "Bài học",
                      assignments: "Bài tập",
                      discussion: "Thảo luận",
                      attendance: "Điểm danh",
                      grades: "Bảng điểm"
                  }[tab];

                  return (
                    <button 
                        key={tab}
                        onClick={() => changeTab(tab)}
                        // Thêm: whitespace-nowrap (không xuống dòng), flex-shrink-0 (không bị bóp méo)
                        className={`pb-3 px-2 border-b-4 transition whitespace-nowrap flex-shrink-0 text-sm font-medium ${
                            activeTab === tab 
                            ? 'border-blue-600 text-blue-600' 
                            : 'border-transparent text-gray-500 hover:text-gray-700 hover:bg-gray-50'
                        }`}
                    >
                        {label}
                    </button>
                  )
              })}
          </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 animate-fade-in">
        
        {/* --- TAB BẢNG TIN (STREAM) --- */}
        {activeTab === 'stream' && (
            <div>
                <div className={`${bannerColor} h-40 md:h-52 rounded-xl mb-6 relative overflow-hidden shadow-md flex items-end p-6`}>
                    <div className="relative z-10 text-white">
                        <h1 className="text-2xl md:text-3xl font-bold mb-1 line-clamp-1">{course.title}</h1>
                        <p className="text-white/90 font-medium text-sm md:text-base">Mã lớp: {course.code}</p>
                    </div>
                    <div className="absolute top-0 right-0 w-64 h-64 bg-white/10 rounded-full -translate-y-1/2 translate-x-1/4 blur-2xl"></div>
                </div>

                <div className="bg-white p-4 rounded-xl border shadow-sm mb-6 flex flex-col md:flex-row justify-between items-center gap-4">
                    <div className="flex items-center gap-3 w-full overflow-hidden">
                        <div className="bg-blue-100 p-2 rounded-lg flex-shrink-0">📹</div>
                        <div className="flex-1 min-w-0">
                            <div className="font-bold text-gray-700 text-sm uppercase truncate">Phòng học trực tuyến</div>
                            {isEditingLink ? (
                                <input className="border rounded px-2 py-1 text-sm w-full mt-1" value={meetingLink} onChange={e => setMeetingLink(e.target.value)} placeholder="Link Zoom/Meet..." />
                            ) : (
                                course.meeting_link ? 
                                <a href={course.meeting_link} target="_blank" rel="noreferrer" className="text-blue-600 hover:underline text-sm font-medium truncate block">{course.meeting_link}</a> 
                                : <span className="text-gray-400 text-sm italic">Chưa có link</span>
                            )}
                        </div>
                    </div>
                    {isTeacherLike && (
                        isEditingLink ? (
                            <div className="flex gap-2 flex-shrink-0">
                            <button
                                onClick={handleSaveMeetingLink}
                                className="bg-blue-600 text-white px-3 py-1 rounded text-sm"
                            >
                                Lưu
                            </button>
                            <button
                                onClick={() => setIsEditingLink(false)}
                                className="bg-gray-200 text-gray-700 px-3 py-1 rounded text-sm"
                            >
                                Hủy
                            </button>
                            </div>
                        ) : (
                            <div className="flex gap-3 flex-shrink-0 items-center">
                            <button
                                onClick={() => setIsEditingLink(true)}
                                className="text-blue-200 hover:text-white text-sm"
                            >
                                Sửa link
                            </button>

                            <Link
                                to={`/courses/${courseId}/analytics`}
                                className="text-blue-200 hover:text-white text-sm"
                            >
                                📊 Thống kê
                            </Link>
                            </div>
                        )
                        )}

                </div>

                <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                    <div className="hidden md:block col-span-1">
                        <UpcomingWidget courseId={courseId} />
                    </div>
                    <div className="col-span-1 md:col-span-3">
                        <AnnouncementList courseId={courseId} isTeacherLike={isTeacherLike} />
                    </div>
                </div>
            </div>
        )}

        {/* --- TAB BÀI HỌC (CLASSWORK) --- */}
        {activeTab === 'classwork' && (
            <div className="flex flex-col md:flex-row gap-6">
                <div className="w-full md:w-64 flex-shrink-0">
                    <div className="bg-white rounded-xl border shadow-sm p-3 sticky top-24">
                        {isTeacherLike && <SectionForm courseId={courseId} onSuccess={() => setRefreshKey(k => k + 1)} />}
                        
                        <h3 className="font-bold text-gray-400 text-xs uppercase tracking-wider mb-2 px-2 mt-4">Mục lục</h3>
                        <div className="space-y-1">
                            {sections.map(s => (
                                <div key={s.id} onClick={() => setActiveSectionId(s.id)} className={`group flex justify-between items-center px-3 py-2 rounded-lg text-sm cursor-pointer transition ${activeSectionId === s.id ? 'bg-blue-50 text-blue-700 font-medium' : 'text-gray-600 hover:bg-gray-50'}`}>
                                    <span className="truncate">{s.title}</span>
                                    {isTeacherLike && <button onClick={(e) => {e.stopPropagation(); handleDeleteSection(s.id)}} className="opacity-0 group-hover:opacity-100 text-gray-400 hover:text-red-500 p-1">×</button>}
                                </div>
                            ))}
                        </div>
                        {sections.length === 0 && <p className="text-sm text-gray-400 px-2 italic mt-2">Chưa có chương.</p>}
                    </div>
                </div>
                
                <div className="flex-1 bg-white p-4 md:p-6 rounded-xl border shadow-sm min-h-[500px] w-full min-w-0 overflow-hidden">
                    {sections.length > 0 ? (
                        <Lessons courseId={courseId} sectionId={activeSectionId} canEdit={isTeacherLike} />
                    ) : (
                        <div className="text-center py-20 text-gray-400">
                            {isTeacherLike ? "Hãy tạo chương mục đầu tiên (bên trái) để bắt đầu." : "Giáo viên chưa đăng bài học nào."}
                        </div>
                    )}
                </div>
            </div>
        )}

        {/* --- TAB BÀI TẬP (ASSIGNMENTS) --- */}
        {activeTab === 'assignments' && (
            <div className="max-w-4xl mx-auto">
                <button onClick={() => changeTab("stream")} className="mb-4 text-blue-600 hover:underline">← Quay lại Bảng tin</button>
                {(typeof AssignmentList !== 'undefined') ? 
                    <AssignmentList courseId={courseId} isTeacher={isTeacherLike} me={me} /> : 
                    <div className="text-center p-10">Loading...</div>
                }
            </div>
        )}

        {/* --- TAB THẢO LUẬN --- */}
        {activeTab === 'discussion' && <DiscussionBoard courseId={courseId} />}
        
        {/* --- TAB ĐIỂM DANH --- */}
        {activeTab === 'attendance' && (
             (typeof AttendanceManager !== 'undefined') ? 
             <AttendanceManager courseId={courseId} isTeacher={isTeacherLike} /> :
             <div className="text-center p-10 text-gray-500">Chức năng điểm danh đang bảo trì.</div>
        )}

        {/* --- TAB BẢNG ĐIỂM --- */}
        {activeTab === 'grades' && (
            isTeacherLike ? <CourseGrades courseId={courseId} /> : 
            <div className="text-center py-20 text-red-500 bg-white rounded-xl border">🚫 Bạn không có quyền truy cập.</div>
        )}

      </div>
    </div>
  );
}