import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api, { 
  getQuiz, listQuestions, 
  createQuestion, deleteQuestion, 
  createChoice, deleteChoice
} from "../api/api";
import Spinner from "../components/Spinner";
import Button from "../components/Button";
import AiQuizModal from "../components/AiQuizModal"; 

export default function QuizDetail() {
  const { quizId } = useParams();
  const navigate = useNavigate();

  const [quiz, setQuiz] = useState(null);
  const [questions, setQuestions] = useState([]);
  const [submissions, setSubmissions] = useState([]); 
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState("questions");

  // State cho thêm câu hỏi thủ công
  const [newQText, setNewQText] = useState("");
  const [isAddingQ, setIsAddingQ] = useState(false);
  
  // State cho AI Modal
  const [showAi, setShowAi] = useState(false);
  const [isSavingAi, setIsSavingAi] = useState(false);

  useEffect(() => {
    loadData();
  }, [quizId]);

  const loadData = async () => {
    setLoading(true);
    try {
      const [qRes, qsRes, subRes] = await Promise.all([
        getQuiz(quizId),
        listQuestions({ quiz: quizId }),
        api.get(`quizzes/${quizId}/all_submissions/`).catch(() => ({ data: [] }))
      ]);
      setQuiz(qRes);
      setQuestions(qsRes.results || qsRes || []);
      setSubmissions(subRes.data || []);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  // --- LOGIC AI ---
  const handleAiSuccess = async (questionsFromAi) => {
      setIsSavingAi(true);
      try {
          for (const q of questionsFromAi) {
              const newQ = await createQuestion({
                  quiz: quizId,
                  text: q.text,
                  question_type: "single_choice",
                  points: 1,
              });
              if (q.choices && newQ.id) {
                  for (const c of q.choices) {
                      await createChoice({
                          question: newQ.id,
                          text: c.text,
                          is_correct: c.is_correct
                      });
                  }
              }
          }
          alert(`✅ Đã thêm thành công ${questionsFromAi.length} câu hỏi từ AI!`);
          loadData();
      } catch (e) {
          alert("Lỗi khi lưu câu hỏi AI: " + e.message);
      } finally {
          setIsSavingAi(false);
      }
  };

  // --- Logic Thêm/Xóa câu hỏi thủ công ---
  const handleAddQuestion = async () => {
      if (!newQText.trim()) return;
      try {
          await createQuestion({ quiz: quizId, text: newQText, question_type: "single_choice", points: 1, });
          setNewQText("");
          setIsAddingQ(false);
          loadData();
      } catch (e) { alert("Lỗi thêm câu hỏi"); }
  };

  const handleDeleteQuestion = async (id) => {
      if(!confirm("Xóa câu hỏi này?")) return;
      try { await deleteQuestion(id); loadData(); } catch(e) {}
  };

  const handleAddChoice = async (qId, text, isCorrect) => {
      try { await createChoice({ question: qId, text, is_correct: isCorrect }); loadData(); } catch(e){}
  };
  
  const handleDeleteChoice = async (cId) => {
      try { await deleteChoice(cId); loadData(); } catch(e){}
  };

  if (loading) return <div className="flex h-screen items-center justify-center"><Spinner /></div>;
  if (!quiz) return <div>Không tìm thấy bài kiểm tra.</div>;

  return (
    <div className="max-w-5xl mx-auto p-6 min-h-screen">
      <button onClick={() => navigate(-1)} className="mb-4 text-blue-600 hover:underline">← Quay lại danh sách</button>
      
      <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 mb-6">
        <div className="flex justify-between items-start">
            <div>
                <h1 className="text-2xl font-bold text-gray-800">{quiz.title}</h1>
                <p className="text-gray-600 mt-1">{quiz.description || "Chưa có mô tả"}</p>
            </div>
            <span className={`px-3 py-1 rounded-full text-xs font-bold ${quiz.is_published ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                {quiz.is_published ? "Đã xuất bản" : "Bản nháp"}
            </span>
        </div>
      </div>

      <div className="flex gap-6 border-b mb-6">
          <button onClick={() => setActiveTab("questions")} className={`pb-2 font-medium ${activeTab==="questions" ? "text-blue-600 border-b-2 border-blue-600" : "text-gray-500"}`}>
              Danh sách câu hỏi ({questions.length})
          </button>
          <button onClick={() => setActiveTab("submissions")} className={`pb-2 font-medium ${activeTab==="submissions" ? "text-blue-600 border-b-2 border-blue-600" : "text-gray-500"}`}>
              Kết quả làm bài ({submissions.length})
          </button>
      </div>

      {/* TAB 1: DANH SÁCH CÂU HỎI */}
      {activeTab === "questions" && (
        <div className="space-y-6">
            <div className="flex justify-between items-center">
                <h3 className="font-bold text-gray-700">Nội dung đề thi</h3>
                <div className="flex gap-2">
                    {/* NÚT MỞ GOOGLE FORMS */}
                    <button 
                        onClick={() => window.open("https://docs.google.com/forms/u/0/create", "_blank")}
                        className="bg-green-600 hover:bg-green-700 text-white px-3 py-2 rounded-lg text-sm font-bold shadow transition flex items-center gap-2"
                        title="Tạo đề thi trên Google Forms"
                    >
                         📝 Google Forms
                    </button>

                    {/* Nút AI */}
                    <button 
                        onClick={() => setShowAi(true)}
                        disabled={isSavingAi}
                        className="bg-gradient-to-r from-purple-600 to-indigo-600 text-white px-4 py-2 rounded-lg text-sm font-bold shadow hover:shadow-lg transition flex items-center gap-2"
                    >
                        {isSavingAi ? "Đang lưu..." : "✨ Tạo bằng AI"}
                    </button>
                    
                    <Button size="sm" onClick={() => setIsAddingQ(true)}>+ Thêm thủ công</Button>
                </div>
            </div>

            {isAddingQ && (
                <div className="bg-blue-50 p-4 rounded-xl border border-blue-100 animate-fade-in">
                    <input className="w-full border p-2 rounded mb-2" placeholder="Nhập nội dung câu hỏi..." value={newQText} onChange={e=>setNewQText(e.target.value)} autoFocus />
                    <div className="flex gap-2">
                        <Button size="sm" onClick={handleAddQuestion}>Lưu</Button>
                        <Button size="sm" variant="ghost" onClick={()=>setIsAddingQ(false)}>Hủy</Button>
                    </div>
                </div>
            )}

            <div className="space-y-4">
                {questions.length === 0 && <p className="text-gray-500 text-center py-10 italic">Chưa có câu hỏi nào.</p>}
                
                {questions.map((q, idx) => (
                    <div key={q.id} className="bg-white p-4 rounded-xl border shadow-sm group">
                        <div className="flex justify-between">
                            <h4 className="font-bold text-gray-800">Câu {idx + 1}: {q.text}</h4>
                            <button onClick={() => handleDeleteQuestion(q.id)} className="text-red-400 hover:text-red-600 opacity-0 group-hover:opacity-100">Xóa</button>
                        </div>
                        <div className="mt-3 space-y-2 pl-4 border-l-2 border-gray-100">
                            {q.choices.map(c => (
                                <div key={c.id} className={`flex justify-between items-center text-sm p-2 rounded ${c.is_correct ? 'bg-green-50 text-green-800 border border-green-100' : 'bg-gray-50'}`}>
                                    <span>{c.text} {c.is_correct && "✅"}</span>
                                    <button onClick={() => handleDeleteChoice(c.id)} className="text-gray-400 hover:text-red-500 text-xs">×</button>
                                </div>
                            ))}
                            <div className="flex gap-2 items-center mt-2">
                                <input id={`input-${q.id}`} className="border text-sm px-2 py-1 rounded" placeholder="Thêm đáp án..." onKeyDown={(e) => {if(e.key === 'Enter') handleAddChoice(q.id, e.target.value, false);}} />
                                <button onClick={() => {const val = document.getElementById(`input-${q.id}`).value; if(val) handleAddChoice(q.id, val, false);}} className="text-xs bg-gray-200 px-2 py-1 rounded">Thêm sai</button>
                                <button onClick={() => {const val = document.getElementById(`input-${q.id}`).value; if(val) handleAddChoice(q.id, val, true);}} className="text-xs bg-green-200 text-green-800 px-2 py-1 rounded">Thêm đúng</button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
      )}

      {/* TAB 2: KẾT QUẢ LÀM BÀI (Đã xóa nút Xuất Excel) */}
      {activeTab === "submissions" && (
        <div className="space-y-4">
            <div className="flex justify-between items-center">
                <h3 className="font-bold text-gray-700">Danh sách học sinh đã nộp bài</h3>
            </div>

            <div className="overflow-x-auto bg-white rounded-xl border">
                <table className="min-w-full divide-y divide-gray-200">
                    <thead className="bg-gray-50">
                        <tr>
                            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Học sinh</th>
                            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Điểm số</th>
                            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Số câu đúng</th>
                            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Thời gian nộp</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-200">
                        {submissions.length === 0 ? (
                            <tr><td colSpan={4} className="p-6 text-center text-gray-500">Chưa có ai làm bài.</td></tr>
                        ) : (
                            submissions.map(sub => (
                                <tr key={sub.id}>
                                    <td className="px-6 py-4 text-sm font-medium text-gray-900">
                                        {sub.student?.full_name || sub.student?.email}
                                    </td>
                                    <td className="px-6 py-4 text-sm font-bold text-blue-600">{sub.score}</td>
                                    <td className="px-6 py-4 text-sm text-gray-500">{sub.correct_count} / {sub.total_questions}</td>
                                    <td className="px-6 py-4 text-sm text-gray-500">{new Date(sub.submitted_at).toLocaleString('vi-VN')}</td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>
        </div>
      )}

      {/* Modal AI */}
      {showAi && (
          <AiQuizModal 
              onClose={() => setShowAi(false)} 
              onSuccess={handleAiSuccess} 
          />
      )}
    </div>
  );
}