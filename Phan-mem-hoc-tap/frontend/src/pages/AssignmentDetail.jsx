import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api, { getMe, returnSubmission } from "../api/api"; // Giữ nguyên import
import SubmissionForm from "./SubmissionForm.jsx";
import Spinner from "../components/Spinner.jsx";
import Button from "../components/Button.jsx";

export default function AssignmentDetail() {
  const { assignmentId } = useParams();
  const navigate = useNavigate();

  const [me, setMe] = useState(null);
  const [assignment, setAssignment] = useState(null);
  const [submissions, setSubmissions] = useState([]); 
  const [mySubmission, setMySubmission] = useState(null);
  const [loading, setLoading] = useState(true);
  
  // State cho chấm điểm
  const [gradingId, setGradingId] = useState(null);
  const [score, setScore] = useState("");
  const [feedback, setFeedback] = useState("");

  // State cho chức năng Sửa (Edit)
  const [showEditModal, setShowEditModal] = useState(false);
  const [editForm, setEditForm] = useState({ title: "", description: "", max_score: 10, due_at: "" });
  const [isSaving, setIsSaving] = useState(false);

  // Hàm tải dữ liệu
  const fetchData = async (isRefresh = false) => {
    try {
      if (!assignment && !isRefresh) setLoading(true); 
      
      const user = await getMe();
      setMe(user);
      
      const resAsg = await api.get(`assignments/${assignmentId}/`);
      setAssignment(resAsg.data);

      if (user.role === "student") {
        const resSub = await api.get("submissions/", { params: { assignment: assignmentId, owner: user.id } });
        const data = resSub.data?.results ? resSub.data.results : (Array.isArray(resSub.data) ? resSub.data : []);
        setMySubmission(data[0] || null);
      } else {
        const resAll = await api.get("submissions/", { params: { assignment: assignmentId } });
        const data = resAll.data?.results ? resAll.data.results : (Array.isArray(resAll.data) ? resAll.data : []);
        setSubmissions(data);
      }
      
      if (isRefresh) alert("Đã cập nhật dữ liệu mới nhất!");

    } catch (e) { 
      console.error(e);
      if (e.response && e.response.status === 404) {
          alert("Bài tập không tồn tại hoặc đã bị xóa.");
          navigate(-1);
      }
    } finally { 
      setLoading(false); 
    }
  };

  useEffect(() => {
    fetchData();
  }, [assignmentId]);

  // --- LOGIC XÓA BÀI TẬP ---
  const handleDeleteAssignment = async () => {
    if (!confirm("CẢNH BÁO: Bạn có chắc chắn muốn xóa bài tập này không?\nTất cả bài nộp của học sinh cũng sẽ bị xóa vĩnh viễn.")) return;
    try {
      await api.delete(`assignments/${assignmentId}/`);
      alert("Đã xóa bài tập thành công.");
      navigate(-1); // Quay lại trang trước
    } catch (e) {
      alert("Lỗi khi xóa: " + (e.response?.data?.detail || e.message));
    }
  };

  // --- LOGIC SỬA BÀI TẬP (GIA HẠN) ---
  const openEditModal = () => {
    // Chuyển đổi định dạng ngày từ ISO sang định dạng input datetime-local (YYYY-MM-DDThh:mm)
    let formattedDate = "";
    if (assignment.due_at) {
        const d = new Date(assignment.due_at);
        // Trừ đi timezone offset để hiển thị đúng giờ địa phương trong input
        d.setMinutes(d.getMinutes() - d.getTimezoneOffset());
        formattedDate = d.toISOString().slice(0, 16);
    }

    setEditForm({
        title: assignment.title,
        description: assignment.description,
        max_score: assignment.max_score,
        due_at: formattedDate
    });
    setShowEditModal(true);
  };

  const handleUpdateAssignment = async () => {
      setIsSaving(true);
      try {
          // Chuẩn bị dữ liệu gửi đi (nếu ngày rỗng thì gửi null)
          const payload = {
              ...editForm,
              due_at: editForm.due_at ? new Date(editForm.due_at).toISOString() : null
          };
          
          await api.patch(`assignments/${assignmentId}/`, payload);
          alert("Cập nhật thành công!");
          setShowEditModal(false);
          fetchData(); // Load lại thông tin mới
      } catch (e) {
          alert("Lỗi cập nhật: " + (e.response?.data?.detail || e.message));
      } finally {
          setIsSaving(false);
      }
  };

  // --- LOGIC CHẤM ĐIỂM (Giữ nguyên) ---
  const saveGrade = async (subId) => {
      try {
          await api.patch(`submissions/${subId}/`, { score: parseFloat(score), feedback: feedback });
          alert("Đã lưu điểm thành công!");
          setGradingId(null);
          await fetchData(); 
      } catch(e) { 
          alert("Lỗi lưu điểm: " + (e.response?.data?.detail || e.message)); 
      }
  };

  const handleReturn = async (subId) => {
      if(!confirm("Bạn có chắc muốn trả bài này cho học sinh?")) return;
      try { 
          await returnSubmission(subId); 
          alert("Đã trả bài!"); 
          await fetchData();
      } catch(e) { 
          alert("Lỗi khi trả bài: " + (e.response?.data?.detail || e.message)); 
      }
  };

  if (loading) return <div className="p-10 flex justify-center"><Spinner /></div>;
  if (!assignment) return <div className="p-10 text-center">Không tìm thấy bài tập.</div>;

  const isTeacher = (me?.role === "teacher" || me?.role === "admin");

  return (
    <div className="max-w-5xl mx-auto p-6 min-h-screen">
      <button onClick={() => navigate(-1)} className="mb-4 text-blue-600 hover:underline flex items-center gap-1">
        <span>←</span> Quay lại
      </button>
      
      {/* KHUNG THÔNG TIN BÀI TẬP */}
      <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 mb-8 relative group">
        <div className="flex justify-between items-start">
            <h1 className="text-3xl font-bold text-gray-800 mb-2">{assignment.title}</h1>
            
            {/* CỤM NÚT CHO GIÁO VIÊN */}
            {isTeacher && (
                <div className="flex gap-2">
                     <button 
                        onClick={() => fetchData(true)}
                        className="text-sm font-medium text-gray-500 hover:text-blue-600 px-3 py-2 rounded-lg hover:bg-gray-100 transition flex items-center gap-1"
                    >
                        ↻ Làm mới
                    </button>
                    <button 
                        onClick={openEditModal}
                        className="bg-blue-100 hover:bg-blue-200 text-blue-700 px-4 py-2 rounded-lg text-sm font-bold transition flex items-center gap-2"
                    >
                        ✏️ Sửa / Gia hạn
                    </button>
                    <button 
                        onClick={handleDeleteAssignment}
                        className="bg-red-50 hover:bg-red-100 text-red-600 px-4 py-2 rounded-lg text-sm font-bold transition flex items-center gap-2"
                    >
                        🗑️ Xóa
                    </button>
                </div>
            )}
        </div>

        <div className="text-sm text-gray-500 flex flex-wrap gap-4 mb-4 mt-2">
            <span className="bg-gray-100 px-3 py-1 rounded-full">
                Điểm tối đa: <span className="font-bold text-gray-900">{assignment.max_score}</span>
            </span>
            <span className={`px-3 py-1 rounded-full border ${assignment.due_at && new Date(assignment.due_at) < new Date() ? 'bg-red-50 border-red-200 text-red-600' : 'bg-green-50 border-green-200 text-green-700'}`}>
                Hạn nộp: <span className="font-medium">{assignment.due_at ? new Date(assignment.due_at).toLocaleString("vi-VN") : "Không giới hạn"}</span>
            </span>
        </div>
        
        <div className="prose prose-sm max-w-none text-gray-600 border-t pt-4 whitespace-pre-wrap">
            {assignment.description || "Không có mô tả."}
        </div>
      </div>

      {/* GIAO DIỆN HỌC SINH */}
      {!isTeacher && (
        <div className="max-w-2xl">
           <SubmissionForm 
              assignmentId={assignment.id} 
              existingSubmission={mySubmission} 
              onSubmitted={() => fetchData(false)} 
           />
        </div>
      )}

      {/* GIAO DIỆN GIÁO VIÊN */}
      {isTeacher && (
        <div className="space-y-6">
            <div className="flex justify-between items-center border-b pb-2">
                <h2 className="text-xl font-bold text-gray-800">
                    Danh sách nộp bài ({submissions.length})
                </h2>
                <div className="flex gap-2">
                    <button onClick={() => fetchData(true)} className="text-sm text-blue-600 hover:underline font-normal px-2">
                        Cập nhật danh sách
                    </button>
                </div>
            </div>
            
            <div className="grid gap-4">
                {submissions.length === 0 && <p className="text-gray-500 italic py-4 text-center bg-gray-50 rounded-lg">Chưa có học sinh nào nộp bài.</p>}
                
                {submissions.map(sub => (
                    <div key={sub.id} className="bg-white p-4 rounded-xl border shadow-sm hover:shadow-md transition duration-200">
                        <div className="flex justify-between items-start mb-3">
                            <div>
                                <p className="font-bold text-gray-900 text-base">
                                    {sub.owner?.last_name || sub.owner?.email || `Học sinh #${sub.owner}`}
                                </p>
                                <p className="text-xs text-gray-500 mt-1">
                                    Nộp lúc: {new Date(sub.updated_at).toLocaleString("vi-VN")}
                                </p>
                            </div>
                            <div>
                                {sub.status === 'RETURNED' ? (
                                    <span className="px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full font-bold">Đã trả bài</span>
                                ) : sub.score !== null ? (
                                    <span className="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded-full font-bold">Đã chấm</span>
                                ) : (
                                    <span className="px-2 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full font-bold">Chờ chấm</span>
                                )}
                            </div>
                        </div>

                        {sub.file && (
                            <a href={sub.file} target="_blank" rel="noreferrer" className="inline-flex items-center gap-2 text-sm text-blue-600 hover:text-blue-800 hover:underline mb-3 bg-blue-50 px-3 py-2 rounded-lg border border-blue-100 transition">
                                📄 Xem file bài làm
                            </a>
                        )}
                        
                        <div className="bg-gray-50 p-3 rounded-lg text-sm text-gray-700 mb-3 border border-gray-100 italic">
                            "{sub.answer_text || "Học sinh không để lại lời nhắn."}"
                        </div>

                        {/* FORM CHẤM ĐIỂM */}
                        {gradingId === sub.id ? (
                            <div className="flex items-center gap-2 bg-blue-50 p-3 rounded-lg border border-blue-200 animate-fade-in">
                                <input 
                                    type="number" 
                                    className="border rounded-md px-3 py-2 w-24 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white" 
                                    placeholder="Điểm" 
                                    value={score} 
                                    onChange={e=>setScore(e.target.value)}
                                    autoFocus
                                />
                                <input 
                                    className="border rounded-md px-3 py-2 flex-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white" 
                                    placeholder="Nhận xét..." 
                                    value={feedback} 
                                    onChange={e=>setFeedback(e.target.value)}
                                />
                                <Button size="sm" onClick={()=>saveGrade(sub.id)}>Lưu</Button>
                                <Button size="sm" variant="ghost" onClick={()=>setGradingId(null)}>Huỷ</Button>
                            </div>
                        ) : (
                            <div className="flex justify-between items-center pt-3 border-t border-gray-100 mt-2">
                                <div className="text-sm">
                                    Điểm: <b className="text-lg text-gray-900 mx-1">{sub.score ?? "--"}</b> 
                                    <span className="text-gray-500 italic text-xs">{sub.feedback ? `(${sub.feedback})` : ""}</span>
                                </div>
                                <div className="flex gap-3">
                                    <button 
                                        onClick={()=>{setGradingId(sub.id); setScore(sub.score||""); setFeedback(sub.feedback||"")}} 
                                        className="text-blue-600 text-sm font-semibold hover:bg-blue-50 px-3 py-1 rounded transition"
                                    >
                                        {sub.score !== null ? "Sửa điểm" : "Chấm điểm"}
                                    </button>
                                    
                                    {sub.score != null && sub.status !== 'RETURNED' && (
                                        <button 
                                            onClick={()=>handleReturn(sub.id)} 
                                            className="text-green-600 text-sm font-semibold hover:bg-green-50 px-3 py-1 rounded transition"
                                        >
                                            Trả bài
                                        </button>
                                    )}
                                </div>
                            </div>
                        )}
                    </div>
                ))}
            </div>
        </div>
      )}

      {/* MODAL SỬA BÀI TẬP */}
      {showEditModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 backdrop-blur-sm p-4">
            <div className="bg-white rounded-xl shadow-xl w-full max-w-lg border overflow-hidden animate-fade-in-up">
                <div className="bg-blue-600 p-4 text-white flex justify-between items-center">
                    <h3 className="font-bold text-lg">Chỉnh sửa bài tập</h3>
                    <button onClick={() => setShowEditModal(false)} className="text-white/80 hover:text-white">✕</button>
                </div>
                <div className="p-6 space-y-4">
                    <div>
                        <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Tiêu đề</label>
                        <input 
                            className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 outline-none"
                            value={editForm.title}
                            onChange={e => setEditForm({...editForm, title: e.target.value})}
                        />
                    </div>
                    <div>
                        <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Mô tả</label>
                        <textarea 
                            className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 outline-none h-24"
                            value={editForm.description}
                            onChange={e => setEditForm({...editForm, description: e.target.value})}
                        />
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Điểm tối đa</label>
                            <input 
                                type="number"
                                className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 outline-none"
                                value={editForm.max_score}
                                onChange={e => setEditForm({...editForm, max_score: e.target.value})}
                            />
                        </div>
                        <div>
                            <label className="block text-xs font-bold text-red-500 uppercase mb-1">Hạn nộp (Gia hạn)</label>
                            <input 
                                type="datetime-local"
                                className="w-full border rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500 outline-none"
                                value={editForm.due_at}
                                onChange={e => setEditForm({...editForm, due_at: e.target.value})}
                            />
                            <p className="text-[10px] text-gray-400 mt-1">Để trống nếu không giới hạn.</p>
                        </div>
                    </div>
                </div>
                <div className="p-4 bg-gray-50 flex justify-end gap-3 border-t">
                    <Button variant="ghost" onClick={() => setShowEditModal(false)}>Hủy</Button>
                    <Button onClick={handleUpdateAssignment} disabled={isSaving}>
                        {isSaving ? "Đang lưu..." : "Lưu thay đổi"}
                    </Button>
                </div>
            </div>
        </div>
      )}
    </div>
  );
}