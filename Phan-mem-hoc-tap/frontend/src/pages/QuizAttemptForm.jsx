// src/pages/QuizAttemptForm.jsx
import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { getQuiz, listQuestions, submitQuiz } from "../api/api";
import Spinner from "../components/Spinner";
import Button from "../components/Button";

export default function QuizAttemptForm() {
  const { quizId } = useParams();
  const navigate = useNavigate();
  const [quiz, setQuiz] = useState(null);
  const [questions, setQuestions] = useState([]); 
  const [loading, setLoading] = useState(true);
  const [answers, setAnswers] = useState({}); 
  const [result, setResult] = useState(null);

  useEffect(() => {
    async function load() {
      setLoading(true);
      try {
        const quizData = await getQuiz(quizId);
        setQuiz(quizData);
        const qData = await listQuestions({ quiz: quizId });
        const sortedQs = (qData.results || qData || []).sort((a, b) => a.id - b.id);
        setQuestions(sortedQs);
      } catch (e) {
        alert("Lỗi tải bài thi."); navigate("/quizzes");
      } finally { setLoading(false); }
    }
    load();
  }, [quizId, navigate]);

  const handleSelect = (qId, choiceId) => {
    setAnswers((prev) => ({
      ...prev,
      [qId]: [String(choiceId)] // Hiện tại chỉ hỗ trợ Single Choice cho đơn giản
    }));
  };

  const handleSubmit = async () => {
    // Kiểm tra xem đã làm hết chưa
    const answeredCount = Object.keys(answers).length;
    if (answeredCount < questions.length) {
        if (!window.confirm(`Bạn mới làm ${answeredCount}/${questions.length} câu. Nộp bài luôn?`)) return;
    } else {
        if (!window.confirm("Nộp bài ngay?")) return;
    }

    try {
      const res = await submitQuiz(quizId, answers);
      setResult(res); window.scrollTo(0, 0);
    } catch (e) { 
        alert("Lỗi nộp bài: " + (e.response?.data?.detail || "Thử lại sau")); 
    }
  };

  if (loading) return <div className="p-10"><Spinner label="Đang tải đề thi..." /></div>;
  if (!quiz) return null;

  // --- MÀN HÌNH KẾT QUẢ ---
  if (result) {
    return (
      <div className="max-w-2xl mx-auto mt-10">
        <div className="bg-white rounded-2xl shadow-xl overflow-hidden border border-gray-100">
            <div className="bg-green-600 p-8 text-center text-white">
                <div className="text-6xl mb-2">🏆</div>
                <h2 className="text-3xl font-bold">Hoàn thành xuất sắc!</h2>
                <p className="opacity-90 mt-2">Bạn đã nộp bài thành công.</p>
            </div>
            
            <div className="p-8">
                <div className="grid grid-cols-2 gap-6 mb-8">
                    <div className="bg-blue-50 p-6 rounded-2xl text-center border border-blue-100">
                        <div className="text-sm font-bold uppercase text-blue-800 mb-1 tracking-wider">Tổng điểm</div>
                        <div className="text-5xl font-bold text-blue-600">{result.score}</div>
                    </div>
                    <div className="bg-purple-50 p-6 rounded-2xl text-center border border-purple-100">
                        <div className="text-sm font-bold uppercase text-purple-800 mb-1 tracking-wider">Số câu đúng</div>
                        <div className="text-5xl font-bold text-purple-600">
                            {result.correct_count}<span className="text-2xl text-purple-400 font-medium">/{result.total_questions}</span>
                        </div>
                    </div>
                </div>
                
                <div className="flex flex-col gap-3">
                    <Button onClick={() => navigate("/quizzes")} className="w-full py-3 text-lg shadow-lg bg-gray-900 hover:bg-black text-white">
                        Quay lại danh sách bài thi
                    </Button>
                </div>
            </div>
        </div>
      </div>
    );
  }

  // --- MÀN HÌNH LÀM BÀI ---
  return (
    <div className="max-w-3xl mx-auto pb-20">
      {/* Header Quiz */}
      <div className="bg-white border-t-8 border-blue-600 rounded-xl shadow-md p-8 mb-8 relative overflow-hidden">
        <div className="relative z-10">
            <h1 className="text-4xl font-bold text-gray-900 mb-4">{quiz.title}</h1>
            <p className="text-gray-600 whitespace-pre-wrap leading-relaxed text-lg">{quiz.description}</p>
        </div>
        <div className="absolute top-0 right-0 p-4 opacity-10">
            <svg className="w-32 h-32" fill="currentColor" viewBox="0 0 20 20"><path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z" /><path fillRule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clipRule="evenodd" /></svg>
        </div>
      </div>

      {/* Danh sách câu hỏi */}
      <div className="space-y-6">
        {questions.length === 0 && (
            <div className="p-8 bg-white rounded-xl shadow text-center text-gray-500 border-2 border-dashed border-gray-200">
                <p className="text-lg">Đề thi này chưa có câu hỏi nào.</p>
            </div>
        )}

        {questions.map((q, idx) => (
          <div key={q.id} className="bg-white rounded-xl shadow-sm border border-gray-100 p-6 relative hover:shadow-md transition-shadow">
             <div className="flex justify-between items-start mb-4">
                 <h3 className="font-medium text-xl text-gray-900 pr-12 leading-snug">
                    <span className="text-gray-400 font-bold mr-3">#{idx + 1}</span>
                    {q.text}
                 </h3>
                 <span className="bg-blue-50 text-blue-700 text-xs font-bold px-3 py-1 rounded-full border border-blue-100">
                    {q.points} điểm
                 </span>
             </div>

             <div className="space-y-3 pl-2">
                {q.choices && q.choices.map((c) => {
                    const isSelected = (answers[q.id] || []).includes(String(c.id));
                    return (
                        <label 
                            key={c.id} 
                            className={`flex items-center gap-4 p-4 rounded-xl border-2 cursor-pointer transition-all duration-200 ${
                                isSelected 
                                ? "bg-blue-50 border-blue-500 shadow-md scale-[1.01]" 
                                : "border-gray-100 hover:bg-gray-50 hover:border-gray-200"
                            }`}
                        >
                            <div className={`w-6 h-6 rounded-full border-2 flex items-center justify-center transition-colors ${isSelected ? "border-blue-600" : "border-gray-400"}`}>
                                {isSelected && <div className="w-3 h-3 bg-blue-600 rounded-full"></div>}
                            </div>
                            <input 
                                type="radio"
                                name={`q-${q.id}`}
                                className="hidden"
                                checked={isSelected}
                                onChange={() => handleSelect(q.id, c.id)}
                            />
                            <span className={`text-base ${isSelected ? "text-blue-900 font-medium" : "text-gray-700"}`}>{c.text}</span>
                        </label>
                    );
                })}
             </div>
          </div>
        ))}
      </div>

      {/* Footer Sticky Nộp bài */}
      {questions.length > 0 && (
          <div className="fixed bottom-0 left-0 w-full bg-white border-t border-gray-200 p-4 shadow-[0_-4px_20px_rgba(0,0,0,0.1)] flex justify-between items-center z-50 md:pl-64">
            <div className="text-sm text-gray-500 hidden md:block">
                Đã làm: <b className="text-gray-900">{Object.keys(answers).length}</b> / {questions.length} câu
            </div>
            <div className="flex gap-4 ml-auto mr-4">
                <Button variant="ghost" onClick={() => navigate("/quizzes")}>Thoát</Button>
                <Button onClick={handleSubmit} className="px-8 py-3 text-base shadow-lg bg-blue-600 hover:bg-blue-700 transform hover:-translate-y-1 transition-all">
                    Nộp bài thi
                </Button>
            </div>
          </div>
      )}
    </div>
  );
}