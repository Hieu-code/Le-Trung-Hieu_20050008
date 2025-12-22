import React, { useEffect, useState } from "react";
import { Calendar, momentLocalizer } from "react-big-calendar";
import moment from "moment";
import "moment/locale/vi"; 
import "react-big-calendar/lib/css/react-big-calendar.css";
import api, { listSchedules, createSchedule, deleteSchedule } from "../api/api";
import { useAuth } from "../store/auth";
import Spinner from "../components/Spinner";

// 1. Cấu hình Tiếng Việt chuẩn
moment.locale("vi");
const localizer = momentLocalizer(moment);

// 2. Hàm viết hoa chữ cái đầu (thứ hai -> Thứ Hai)
const capitalizeFirstLetter = (string) => {
  return string.charAt(0).toUpperCase() + string.slice(1);
};

// 3. Cấu hình hiển thị Ngày/Giờ (Sửa lỗi hiển thị tại đây)
const formats = {
  // Header của cột ngày (VD: Thứ Hai 24/11)
  dayFormat: (date, culture, localizer) => {
    const dayName = localizer.format(date, "dddd", culture);
    const dateStr = localizer.format(date, "DD/MM", culture);
    return `${capitalizeFirstLetter(dayName)} ${dateStr}`;
  },
  // Header tháng (VD: Tháng 11 năm 2025)
  monthHeaderFormat: (date, culture, localizer) => {
    return `Tháng ${localizer.format(date, "MM", culture)} năm ${localizer.format(date, "YYYY", culture)}`;
  },
  // Header khoảng thời gian (VD: 24/11 - 30/11)
  dayRangeHeaderFormat: ({ start, end }, culture, localizer) => {
    return `${localizer.format(start, "DD/MM", culture)} - ${localizer.format(end, "DD/MM", culture)}`;
  },
  // Cột giờ bên trái (07:00)
  timeGutterFormat: (date, culture, localizer) => localizer.format(date, "HH:mm", culture),
};

const messages = {
  allDay: "Cả ngày",
  previous: "Trước",
  next: "Sau",
  today: "Hôm nay",
  month: "Tháng",
  week: "Tuần",
  day: "Ngày",
  agenda: "Danh sách",
  date: "Ngày",
  time: "Giờ",
  event: "Sự kiện",
  noEventsInRange: "Không có lịch nào.",
};

const EVENT_TYPES = {
  lesson: { label: "Buổi học", color: "#3b82f6" }, // Xanh
  exam: { label: "Thi cử", color: "#ef4444" },    // Đỏ
  deadline: { label: "Hạn nộp", color: "#f59e0b" }, // Cam
  event: { label: "Sự kiện", color: "#10b981" }    // Xanh lá
};

export default function ScheduleCalendar() {
  const { user } = useAuth();
  const isTeacher = user?.role === "teacher" || user?.role === "admin";

  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [courses, setCourses] = useState([]);
  const [showModal, setShowModal] = useState(false);
  
  const [newEvent, setNewEvent] = useState({
    title: "", course: "", type: "lesson", description: "",
    start: new Date(), end: new Date()
  });

  const fetchData = async () => {
    try {
      const [schedulesRes, coursesRes] = await Promise.all([
        listSchedules(),
        isTeacher ? api.get("courses/", { params: { mine: true } }) : { data: [] }
      ]);

      const scheduleList = schedulesRes.results || schedulesRes || [];
      const courseList = coursesRes.data?.results || coursesRes.data || [];

      const formattedEvents = scheduleList.map(s => ({
        id: s.id,
        title: `${s.title} (${s.course_title || "Chung"})`,
        start: new Date(s.starts_at),
        end: new Date(s.ends_at),
        type: s.type,
        desc: s.description,
      }));

      setEvents(formattedEvents);
      setCourses(courseList);
    } catch (e) { console.error(e); } finally { setLoading(false); }
  };

  useEffect(() => { fetchData(); }, [user]);

  const handleSelectSlot = ({ start, end }) => {
    if (!isTeacher) return;
    setNewEvent({ 
      ...newEvent, start, end, title: "", description: "", type: "lesson", 
      course: courses[0]?.id || "" 
    });
    setShowModal(true);
  };

  const handleSelectEvent = (event) => {
    if (!isTeacher) return alert(`📅 ${event.title}\n📝 ${event.desc}\n⏰ ${moment(event.start).format("HH:mm")} - ${moment(event.end).format("HH:mm")}`);
    if (confirm(`Xóa lịch: ${event.title}?`)) handleDelete(event.id);
  };

  const handleDelete = async (id) => {
      try { await deleteSchedule(id); setEvents(events.filter(e => e.id !== id)); } 
      catch(e) { alert("Lỗi xóa."); }
  };

  const handleSave = async () => {
      if (!newEvent.title || !newEvent.course) return alert("Thiếu tiêu đề hoặc khóa học!");
      if (new Date(newEvent.start) >= new Date(newEvent.end)) return alert("Giờ kết thúc phải sau giờ bắt đầu!");
      
      try {
          await createSchedule({
              course: newEvent.course, title: newEvent.title, description: newEvent.description, type: newEvent.type,
              starts_at: newEvent.start.toISOString(), ends_at: newEvent.end.toISOString()
          });
          setShowModal(false); 
          fetchData();
      } catch(e) { alert("Lỗi tạo lịch: " + (e.response?.data?.detail || e.message)); }
  };

  const eventStyleGetter = (event) => ({
    style: {
      backgroundColor: EVENT_TYPES[event.type]?.color || "#3b82f6",
      borderRadius: "6px", opacity: 0.9, color: "white", border: "0px", fontSize: "0.85rem"
    }
  });

  if (loading) return <div className="flex h-screen justify-center items-center"><Spinner /></div>;

  return (
    <div className="p-6 bg-gray-50 min-h-screen">
      <div className="flex flex-col md:flex-row justify-between items-center mb-6 bg-white p-4 rounded-xl shadow-sm border border-gray-100">
        <div>
            <h1 className="text-2xl font-bold text-gray-800">📅 Thời Khóa Biểu</h1>
            <p className="text-sm text-gray-500">Lịch học tập và giảng dạy.</p>
        </div>
        <div className="flex gap-3 mt-4 md:mt-0">
            {Object.entries(EVENT_TYPES).map(([key, val]) => (
                <div key={key} className="flex items-center gap-2 text-xs font-medium px-3 py-1 bg-gray-100 rounded-full text-gray-700">
                    <span className="w-3 h-3 rounded-full" style={{ backgroundColor: val.color }}></span>{val.label}
                </div>
            ))}
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-lg border border-gray-200 p-4">
        {/* 👇 ĐẶT HEIGHT CỐ ĐỊNH ĐỂ KHÔNG BỊ ĐÈ CHỮ */}
        <Calendar
          localizer={localizer}
          events={events}
          startAccessor="start"
          endAccessor="end"
          style={{ height: 650 }} 
          defaultView="week"
          views={['month', 'week', 'day', 'agenda']}
          step={30} // Mỗi ô 30 phút
          timeslots={2}
          selectable={isTeacher}
          onSelectSlot={handleSelectSlot}
          onSelectEvent={handleSelectEvent}
          eventPropGetter={eventStyleGetter}
          formats={formats} // Áp dụng format tiếng Việt chuẩn
          messages={messages}
          popup
        />
      </div>

      {showModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 backdrop-blur-sm p-4">
            <div className="bg-white p-6 rounded-2xl shadow-2xl w-full max-w-lg border animate-fade-in-up">
                <h3 className="text-lg font-bold mb-4 border-b pb-2 text-gray-800">Thêm Lịch Mới</h3>
                <div className="space-y-4">
                    <div>
                        <label className="text-xs font-bold text-gray-500 uppercase">Tiêu đề</label>
                        <input className="w-full border rounded-lg px-3 py-2 mt-1 focus:ring-2 focus:ring-blue-500 outline-none" 
                            value={newEvent.title} onChange={e => setNewEvent({...newEvent, title: e.target.value})} placeholder="Nhập tiêu đề..." autoFocus />
                    </div>
                    <div>
                        <label className="text-xs font-bold text-gray-500 uppercase">Khóa học</label>
                        <select className="w-full border rounded-lg px-3 py-2 mt-1 focus:ring-2 focus:ring-blue-500 outline-none bg-white" 
                            value={newEvent.course} onChange={e => setNewEvent({...newEvent, course: e.target.value})}>
                            <option value="">-- Chọn khóa học --</option>
                            {courses.map(c => <option key={c.id} value={c.id}>{c.title}</option>)}
                        </select>
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <label className="text-xs font-bold text-gray-500 uppercase">Bắt đầu</label>
                            <input type="datetime-local" className="w-full border rounded-lg px-2 py-2 mt-1 text-sm" 
                                value={moment(newEvent.start).format("YYYY-MM-DDTHH:mm")} 
                                onChange={(e) => setNewEvent({...newEvent, start: new Date(e.target.value)})} />
                        </div>
                        <div>
                            <label className="text-xs font-bold text-gray-500 uppercase">Kết thúc</label>
                            <input type="datetime-local" className="w-full border rounded-lg px-2 py-2 mt-1 text-sm" 
                                value={moment(newEvent.end).format("YYYY-MM-DDTHH:mm")} 
                                onChange={(e) => setNewEvent({...newEvent, end: new Date(e.target.value)})} />
                        </div>
                    </div>
                    <div>
                        <label className="text-xs font-bold text-gray-500 uppercase">Loại lịch</label>
                        <div className="flex gap-4 mt-2">
                            {Object.entries(EVENT_TYPES).map(([key, val]) => (
                                <label key={key} className="flex items-center gap-1 cursor-pointer">
                                    <input type="radio" name="type" value={key} checked={newEvent.type === key} onChange={() => setNewEvent({...newEvent, type: key})} className="text-blue-600 focus:ring-blue-500" /> 
                                    <span className="text-sm">{val.label}</span>
                                </label>
                            ))}
                        </div>
                    </div>
                    <div>
                        <label className="text-xs font-bold text-gray-500 uppercase">Mô tả</label>
                        <textarea className="w-full border rounded-lg px-3 py-2 mt-1 focus:ring-2 focus:ring-blue-500 outline-none" rows={2} 
                            value={newEvent.description} onChange={e => setNewEvent({...newEvent, description: e.target.value})} placeholder="Ghi chú chi tiết..."></textarea>
                    </div>
                </div>
                <div className="flex justify-end gap-2 mt-6 pt-4 border-t border-gray-100">
                    <button onClick={() => setShowModal(false)} className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg font-medium">Hủy</button>
                    <button onClick={handleSave} className="px-6 py-2 bg-blue-600 text-white rounded-lg font-bold hover:bg-blue-700 shadow-lg">Lưu Lịch</button>
                </div>
            </div>
        </div>
      )}
    </div>
  );
}