import React, { useEffect, useState } from "react";
import { Menu, Transition } from "@headlessui/react";
import { BellIcon } from "@heroicons/react/24/outline";
import { Link } from "react-router-dom";
import { listNotifications, markReadNotification, markAllRead, getAccessToken } from "../api/api";
import { useAuth } from "../store/auth";

export default function NotificationBell() {
  const { user } = useAuth();
  const [notifications, setNotifications] = useState([]);
  const [unreadCount, setUnreadCount] = useState(0);

  const fetchNotifs = async () => {
    // 👇 CHẶN LỖI 401: Chỉ gọi khi đã có token
    if (!user || !getAccessToken()) return;

    try {
      const data = await listNotifications({ limit: 10 });
      const list = Array.isArray(data) ? data : (data.results || []);
      setNotifications(list);
      setUnreadCount(list.filter(n => !n.is_read).length);
    } catch (err) {
      // Ignore unauthorized errors quietly
    }
  };

  useEffect(() => {
    fetchNotifs();
    const interval = setInterval(fetchNotifs, 60000);
    return () => clearInterval(interval);
  }, [user]);

  const handleRead = async (noti) => {
    if (!noti.is_read) {
      try {
        // Cập nhật giao diện trước cho mượt
        setNotifications(prev => prev.map(n => n.id === noti.id ? { ...n, is_read: true } : n));
        setUnreadCount(c => Math.max(0, c - 1));
        // Gọi API sau
        await markReadNotification(noti.id);
      } catch (e) { console.error(e); }
    }
  };

  const handleMarkAll = async () => {
      try {
        setNotifications(prev => prev.map(n => ({ ...n, is_read: true })));
        setUnreadCount(0);
        await markAllRead();
      } catch(e) { console.error(e); }
  };

  return (
    <Menu as="div" className="relative">
      <Menu.Button className="relative p-2 text-gray-600 hover:bg-gray-100 rounded-full outline-none">
        <BellIcon className="h-6 w-6" />
        {unreadCount > 0 && (
          <span className="absolute top-1 right-1 inline-flex items-center justify-center px-1.5 py-0.5 text-xs font-bold leading-none text-white transform translate-x-1/4 -translate-y-1/4 bg-red-600 rounded-full">
            {unreadCount > 9 ? "9+" : unreadCount}
          </span>
        )}
      </Menu.Button>

      <Transition
        enter="transition ease-out duration-100"
        enterFrom="transform opacity-0 scale-95"
        enterTo="transform opacity-100 scale-100"
        leave="transition ease-in duration-75"
        leaveFrom="transform opacity-100 scale-100"
        leaveTo="transform opacity-0 scale-95"
      >
        <Menu.Items className="absolute right-0 z-50 mt-2 w-80 origin-top-right rounded-xl bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none overflow-hidden">
          <div className="px-4 py-3 border-b border-gray-100 flex justify-between items-center bg-gray-50">
            <h3 className="text-sm font-bold text-gray-700">Thông báo</h3>
            {unreadCount > 0 && (
              <button onClick={handleMarkAll} className="text-xs text-blue-600 hover:underline font-medium">
                Đọc tất cả
              </button>
            )}
          </div>

          <div className="max-h-80 overflow-y-auto">
            {notifications.length === 0 ? (
              <div className="p-6 text-center text-sm text-gray-500">
                Không có thông báo nào.
              </div>
            ) : (
              notifications.map((notif) => (
                <Menu.Item key={notif.id}>
                  {({ active }) => (
                    <div
                      onClick={() => handleRead(notif)}
                      className={`block px-4 py-3 text-sm cursor-pointer border-b border-gray-50 last:border-0 ${
                        active ? "bg-gray-50" : ""
                      } ${!notif.is_read ? "bg-blue-50/60" : ""}`}
                    >
                      <Link to={notif.course ? `/courses/${notif.course}` : "#"} className="block">
                        <div className="flex justify-between items-start mb-1">
                            <p className={`font-semibold line-clamp-1 ${notif.is_read ? "text-gray-600" : "text-gray-900"}`}>
                                {notif.title}
                            </p>
                            {!notif.is_read && <span className="h-2 w-2 bg-blue-500 rounded-full mt-1.5 flex-shrink-0"></span>}
                        </div>
                        <p className={`text-xs line-clamp-2 ${notif.is_read ? "text-gray-400" : "text-gray-600"}`}>
                            {notif.body}
                        </p>
                        <p className="text-[10px] text-gray-400 mt-1 text-right">
                            {new Date(notif.created_at).toLocaleString("vi-VN")}
                        </p>
                      </Link>
                    </div>
                  )}
                </Menu.Item>
              ))
            )}
          </div>
        </Menu.Items>
      </Transition>
    </Menu>
  );
}