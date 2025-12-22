import React, { useState, useEffect } from "react";
import { listThreads, createThread, listPosts, createPost, getMe } from "../api/api";
import Button from "./Button";
import Spinner from "./Spinner";

export default function DiscussionBoard({ courseId }) {
  const [threads, setThreads] = useState([]);
  const [activeThread, setActiveThread] = useState(null);
  const [loading, setLoading] = useState(true);
  const [newThreadTitle, setNewThreadTitle] = useState("");
  const [isCreating, setIsCreating] = useState(false);
  const [posts, setPosts] = useState([]);
  const [newPost, setNewPost] = useState("");
  const [me, setMe] = useState(null);

  useEffect(() => {
    getMe().then(setMe);
    listThreads({ course: courseId }).then(res => {
        setThreads(res.results || res || []);
        setLoading(false);
    });
  }, [courseId]);

  useEffect(() => {
    if(activeThread) {
        listPosts({ thread: activeThread.id }).then(res => setPosts(res.results || res || []));
    }
  }, [activeThread]);

  const handleCreateThread = async (e) => {
      e.preventDefault();
      if(!newThreadTitle.trim()) return;
      const res = await createThread({ course: courseId, title: newThreadTitle });
      setThreads([res, ...threads]);
      setNewThreadTitle("");
      setIsCreating(false);
  };

  const handleCreatePost = async (e) => {
      e.preventDefault();
      if(!newPost.trim()) return;
      const res = await createPost({ thread: activeThread.id, body: newPost });
      setPosts([...posts, res]);
      setNewPost("");
  };

  if(loading) return <Spinner />;

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 min-h-[500px]">
        <div className="bg-white rounded-xl border p-4 flex flex-col">
            <div className="flex justify-between mb-4">
                <h3 className="font-bold">Chủ đề</h3>
                <button onClick={() => setIsCreating(!isCreating)} className="text-blue-600 text-sm">{isCreating ? "Hủy" : "+ Tạo"}</button>
            </div>
            {isCreating && (
                <form onSubmit={handleCreateThread} className="mb-4">
                    <input className="w-full border rounded px-2 py-1 text-sm mb-2" placeholder="Tiêu đề..." value={newThreadTitle} onChange={e => setNewThreadTitle(e.target.value)} />
                    <Button size="sm" type="submit" className="w-full">Lưu</Button>
                </form>
            )}
            <div className="space-y-2 overflow-y-auto flex-1">
                {threads.map(t => (
                    <div key={t.id} onClick={() => setActiveThread(t)} className={`p-3 rounded cursor-pointer text-sm ${activeThread?.id === t.id ? 'bg-blue-50 border-blue-200 border' : 'hover:bg-gray-50'}`}>
                        <p className="font-semibold">{t.title}</p>
                        <p className="text-xs text-gray-500">{t.author?.full_name || t.author?.email}</p>
                    </div>
                ))}
            </div>
        </div>
        <div className="md:col-span-2 bg-white rounded-xl border flex flex-col">
            {!activeThread ? <div className="flex-1 flex items-center justify-center text-gray-400 text-sm">Chọn chủ đề để xem.</div> : (
                <>
                    <div className="p-4 border-b bg-gray-50 font-bold">{activeThread.title}</div>
                    <div className="flex-1 overflow-y-auto p-4 space-y-4 max-h-[400px]">
                        {posts.map(p => {
                            const isMe = p.author?.id === me?.id;
                            return (
                                <div key={p.id} className={`flex ${isMe ? 'justify-end' : 'justify-start'}`}>
                                    <div className={`max-w-[80%] rounded-xl px-3 py-2 text-sm ${isMe ? 'bg-blue-600 text-white' : 'bg-gray-100'}`}>
                                        {!isMe && <p className="text-[10px] font-bold opacity-70">{p.author?.full_name || p.author?.email}</p>}
                                        <p className="mb-1">{p.body}</p>
                                        <p className={`text-[10px] text-right ${isMe?'text-blue-200':'text-gray-400'}`}>{new Date(p.created_at).toLocaleString('vi-VN')}</p>
                                    </div>
                                </div>
                            )
                        })}
                    </div>
                    <form onSubmit={handleCreatePost} className="p-4 border-t flex gap-2">
                        <input className="flex-1 border rounded-full px-4 py-2 text-sm outline-none" placeholder="Nhập tin nhắn..." value={newPost} onChange={e => setNewPost(e.target.value)} />
                        <Button type="submit" disabled={!newPost.trim()}>Gửi</Button>
                    </form>
                </>
            )}
        </div>
    </div>
  );
}