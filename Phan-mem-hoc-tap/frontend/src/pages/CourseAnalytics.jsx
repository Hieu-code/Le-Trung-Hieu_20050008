import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { getCourseAnalytics } from '../api/api';
// Thêm Legend vào import
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, CartesianGrid, Legend } from 'recharts';
import Spinner from '../components/Spinner';

export default function CourseAnalytics() {
    const { courseId } = useParams();
    const [data, setData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        getCourseAnalytics(courseId)
           .then(res => setData(res.data || res))
           .catch(err => setError("Không thể tải thống kê."))
           .finally(() => setLoading(false));
    }, [courseId]);

    if (loading) return <div className="p-10 flex justify-center"><Spinner /></div>;
    if (error) return <div className="p-8 text-center text-red-500">{error}</div>;
    if (!data) return <div className="p-4 text-center">Không có dữ liệu.</div>;

    return (
        <div className="max-w-5xl mx-auto p-6 space-y-8">
            <div className="flex items-center justify-between">
                <h2 className="text-2xl font-bold text-gray-800">📊 Thống kê Lớp học</h2>
                <Link to={`/courses/${courseId}`} className="text-sm text-blue-600 hover:underline font-medium">
                    &larr; Quay lại khóa học
                </Link>
            </div>
            
            {/* Các thẻ số liệu tổng quan */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col items-center">
                    <p className="text-gray-500 text-xs font-bold uppercase tracking-wide">Sĩ số lớp</p>
                    <p className="text-4xl font-extrabold text-blue-600 mt-2">{data.total_students}</p>
                </div>
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col items-center">
                    <p className="text-gray-500 text-xs font-bold uppercase tracking-wide">Số bài học</p>
                    <p className="text-4xl font-extrabold text-purple-600 mt-2">{data.total_lessons}</p>
                </div>
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col items-center">
                    <p className="text-gray-500 text-xs font-bold uppercase tracking-wide">Tổng lượt nộp bài</p>
                    <p className="text-4xl font-extrabold text-green-600 mt-2">{data.total_submissions}</p>
                </div>
            </div>

            {/* Biểu đồ cột ghép (Grouped Bar Chart) */}
            <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 h-[500px]">
                <h3 className="font-bold text-gray-800 mb-6 text-lg">Phân bố điểm số (So sánh Bài tập & Kiểm tra)</h3>
                <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={data.score_chart} margin={{ top: 20, right: 30, left: 20, bottom: 5 }}>
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                        <XAxis dataKey="name" axisLine={false} tickLine={false} dy={10} />
                        <YAxis allowDecimals={false} axisLine={false} tickLine={false} />
                        <Tooltip 
                            cursor={{fill: '#f3f4f6'}} 
                            contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)' }}
                        />
                        <Legend verticalAlign="top" height={36}/>
                        
                        {/* Cột 1: Điểm Bài tập (Assignment) - Màu Xanh */}
                        <Bar dataKey="assignment" name="Bài tập tự luận" fill="#3b82f6" radius={[4, 4, 0, 0]} barSize={30} />
                        
                        {/* Cột 2: Điểm Kiểm tra (Quiz) - Màu Đỏ/Cam */}
                        <Bar dataKey="quiz" name="Trắc nghiệm (Quiz)" fill="#f59e0b" radius={[4, 4, 0, 0]} barSize={30} />
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
}