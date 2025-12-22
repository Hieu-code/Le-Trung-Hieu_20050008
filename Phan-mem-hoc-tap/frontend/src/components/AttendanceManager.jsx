import React, { useEffect, useState } from "react";
import api from "../api/api";
import Button from "./Button";
import Spinner from "./Spinner";

export default function AttendanceManager({ courseId, isTeacher }) {
  const [sessions, setSessions] = useState([]);
  const [loading, setLoading] = useState(true);
  
  // State cho Modal điểm danh (Giáo viên)
  const [activeSession, setActiveSession] = useState(null);
  const [records, setRecords] = useState([]); // Danh sách sinh viên trong buổi đó
  const [isSaving, setIsSaving] = useState(false);

  // State thông tin User hiện tại (để học sinh biết mình là ai)
  const [me, setMe] = useState(null);

  useEffect(() => {
    loadData();
  }, [courseId]);

  const loadData = async () => {
    try {
      setLoading(true);
      const [resSessions, resMe] = await Promise.all([
          api.get("attendance/", { params: { course: courseId } }),
          api.get("users/me/")
      ]);
      
      setSessions(resSessions.data.results || resSessions.data || []);
      setMe(resMe.data);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  // --- LOGIC GIÁO VIÊN ---
  const handleCreateSession = async () => {
    const title = prompt("Nhập tên buổi học (VD: Bài 1 - Giới thiệu):");
    if (!title) return;
    try {
      // Mặc định lấy ngày hôm nay
      const today = new Date().toISOString().split('T')[0];
      await api.post("attendance/", { 
          course: courseId, 
          title: title, 
          date: today 
      });
      alert("Đã tạo buổi điểm danh!");
      loadData();
    } catch(e) { alert("Lỗi tạo buổi học: " + e.message); }
  };

  const openAttendanceModal = (session) => {
      setActiveSession(session);
      // Clone records ra để sửa đổi local
      setRecords(session.records || []);
  };

  const toggleStatus = (recordIndex, newStatus) => {
      const newRecords = [...records];
      newRecords[recordIndex].status = newStatus;
      setRecords(newRecords);
  };

  const saveAttendance = async () => {
    if (!activeSession) return;
    setIsSaving(true);
    try {
        // Chuẩn bị payload: List [{student_id: 1, status: 'present'}, ...]
        const payload = records.map(r => ({ 
            student_id: r.student, 
            status: r.status 
        }));
        
        await api.post(`attendance/${activeSession.id}/update_records/`, { records: payload });
        
        alert("Đã lưu điểm danh thành công!");
        setActiveSession(null);
        loadData(); // Reload để cập nhật số liệu
    } catch(e) { 
        alert("Lỗi lưu điểm danh"); 
    } finally {
        setIsSaving(false);
    }
  };

  const handleDeleteSession = async (e, sessionId) => {
      e.stopPropagation();
      if(!confirm("Bạn có chắc muốn xóa buổi điểm danh này?")) return;
      try {
          await api.delete(`attendance/${sessionId}/`);
          loadData();
      } catch(e) { alert("Lỗi xóa"); }
  }

  if (loading) return <div className="py-10 flex justify-center"><Spinner /></div>;

  // --- GIAO DIỆN HỌC SINH ---
  if (!isTeacher) {
      return (
          <div className="bg-white p-6 rounded-xl border shadow-sm">
              <h3 className="font-bold text-gray-800 mb-4 text-lg">Lịch sử chuyên cần của bạn</h3>
              {sessions.length === 0 ? (
                  <p className="text-gray-500 italic">Chưa có dữ liệu điểm danh.</p>
              ) : (
                  <div className="overflow-x-auto">
                    <table className="w-full text-sm text-left">
                        <thead className="bg-gray-50 text-gray-500 uppercase text-xs">
                            <tr>
                                <th className="p-3 rounded-l-lg">Ngày</th>
                                <th className="p-3">Nội dung</th>
                                <th className="p-3 rounded-r-lg text-center">Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y">
                            {sessions.map(s => {
                                // Tìm record của mình
                                const myRecord = s.records?.find(r => r.student === me?.id);
                                const status = myRecord ? myRecord.status : 'unknown';
                                
                                return (
                                    <tr key={s.id} className="hover:bg-gray-50">
                                        <td className="p-3 font-medium">{new Date(s.date).toLocaleDateString("vi-VN")}</td>
                                        <td className="p-3">{s.title}</td>
                                        <td className="p-3 text-center">
                                            {status === 'present' && <span className="bg-green-100 text-green-700 px-2 py-1 rounded text-xs font-bold">Có mặt</span>}
                                            {status === 'absent' && <span className="bg-red-100 text-red-700 px-2 py-1 rounded text-xs font-bold">Vắng</span>}
                                            {status === 'late' && <span className="bg-yellow-100 text-yellow-700 px-2 py-1 rounded text-xs font-bold">Muộn</span>}
                                            {status === 'unknown' && <span className="text-gray-400 text-xs">--</span>}
                                        </td> 
                                    </tr>
                                )
                            })}
                        </tbody>
                    </table>
                  </div>
              )}
          </div>
      )
  }

  // --- GIAO DIỆN GIÁO VIÊN ---
  return (
    <div className="space-y-6">
        <div className="flex justify-between items-center bg-white p-4 rounded-xl border shadow-sm">
            <div>
                <h3 className="font-bold text-lg text-gray-800">Quản lý Điểm danh</h3>
                <p className="text-sm text-gray-500">Tạo buổi học và kiểm tra sĩ số lớp</p>
            </div>
            <Button onClick={handleCreateSession}>+ Tạo buổi điểm danh</Button>
        </div>

        {sessions.length === 0 && (
            <div className="text-center py-10 text-gray-400 bg-gray-50 rounded-xl border border-dashed">
                Chưa có buổi điểm danh nào. Hãy tạo mới!
            </div>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {sessions.map(s => (
                <div 
                    key={s.id} 
                    onClick={() => openAttendanceModal(s)}
                    className="bg-white p-4 rounded-xl border shadow-sm hover:shadow-md transition cursor-pointer relative group"
                >
                    <div className="flex justify-between items-start mb-2">
                        <span className="font-bold text-blue-600 truncate pr-6">{s.title}</span>
                        <button onClick={(e)=>handleDeleteSession(e, s.id)} className="text-gray-300 hover:text-red-500 absolute top-4 right-4 opacity-0 group-hover:opacity-100 transition">🗑️</button>
                    </div>
                    <div className="text-xs text-gray-500 mb-3 flex items-center gap-1">
                        📅 {new Date(s.date).toLocaleDateString("vi-VN")}
                    </div>
                    
                    {/* Progress Bar mini */}
                    <div className="w-full bg-gray-100 rounded-full h-2 mb-2 overflow-hidden">
                         <div 
                            className="bg-green-500 h-2 rounded-full" 
                            style={{ width: `${(s.present_count / (s.records?.length || 1)) * 100}%` }}
                         ></div>
                    </div>
                    <div className="flex justify-between text-xs font-medium">
                        <span className="text-green-600">Hiện diện: {s.present_count}</span>
                        <span className="text-gray-400">Tổng: {s.records?.length || 0}</span>
                    </div>
                </div>
            ))}
        </div>

        {/* MODAL ĐIỂM DANH */}
        {activeSession && (
            <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4 backdrop-blur-sm">
                <div className="bg-white p-0 rounded-xl w-full max-w-4xl h-[85vh] flex flex-col shadow-2xl animate-fade-in-up overflow-hidden">
                    {/* Header Modal */}
                    <div className="p-4 border-b flex justify-between items-center bg-gray-50">
                        <div>
                            <h3 className="font-bold text-xl text-gray-800">{activeSession.title}</h3>
                            <p className="text-sm text-gray-500">{new Date(activeSession.date).toLocaleDateString("vi-VN")}</p>
                        </div>
                        <button onClick={() => setActiveSession(null)} className="text-gray-400 hover:text-gray-600 text-2xl px-2">×</button>
                    </div>

                    {/* Danh sách sinh viên */}
                    <div className="flex-1 overflow-y-auto p-4">
                        <table className="w-full text-sm text-left border-collapse">
                            <thead className="bg-white sticky top-0 z-10 shadow-sm">
                                <tr>
                                    <th className="p-3 border-b text-gray-500 font-medium">Sinh viên</th>
                                    <th className="p-3 border-b text-gray-500 font-medium">Email</th>
                                    <th className="p-3 border-b text-center text-gray-500 font-medium">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y">
                                {records.map((r, idx) => (
                                    <tr key={idx} className="hover:bg-blue-50/50 transition">
                                        <td className="p-3 font-medium text-gray-800">
                                            {r.student_name || "Unknown User"}
                                        </td>
                                        <td className="p-3 text-gray-500">{r.student_email}</td>
                                        <td className="p-3">
                                            <div className="flex justify-center gap-1">
                                                <button 
                                                    onClick={() => toggleStatus(idx, 'present')}
                                                    className={`px-3 py-1.5 rounded-l border transition font-medium ${r.status === 'present' ? 'bg-green-600 text-white border-green-600' : 'bg-white text-gray-600 hover:bg-gray-100'}`}
                                                >
                                                    Có mặt
                                                </button>
                                                <button 
                                                    onClick={() => toggleStatus(idx, 'late')}
                                                    className={`px-3 py-1.5 border-t border-b transition font-medium ${r.status === 'late' ? 'bg-yellow-500 text-white border-yellow-500' : 'bg-white text-gray-600 hover:bg-gray-100'}`}
                                                >
                                                    Muộn
                                                </button>
                                                <button 
                                                    onClick={() => toggleStatus(idx, 'absent')}
                                                    className={`px-3 py-1.5 rounded-r border transition font-medium ${r.status === 'absent' ? 'bg-red-600 text-white border-red-600' : 'bg-white text-gray-600 hover:bg-gray-100'}`}
                                                >
                                                    Vắng
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>

                    {/* Footer Modal */}
                    <div className="p-4 border-t bg-gray-50 flex justify-end gap-3">
                        <Button variant="ghost" onClick={() => setActiveSession(null)}>Đóng</Button>
                        <Button onClick={saveAttendance} disabled={isSaving}>
                            {isSaving ? "Đang lưu..." : "💾 Lưu Điểm Danh"}
                        </Button>
                    </div>
                </div>
            </div>
        )}
    </div>
  );
}