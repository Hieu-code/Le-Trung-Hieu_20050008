// src/components/MediaPlayer.jsx
import React from "react";

/**
 * MediaPlayer hiển thị file/URL từ Material.
 * - type từ backend: "file" | "link" | "video" | "audio"
 *   hoặc MIME thực tế: "video/mp4", "audio/mpeg", ...
 */
const MediaPlayer = ({ fileUrl, type }) => {
  if (!fileUrl) return null;

  const t = (type || "").toLowerCase();
  const isVideo = t === "video" || t.startsWith("video/");
  const isAudio = t === "audio" || t.startsWith("audio/");

  if (isVideo) {
    return (
      <video controls width="100%" className="rounded-lg shadow-md my-2">
        <source src={fileUrl} type={t.startsWith("video/") ? t : undefined} />
        Trình duyệt của bạn không hỗ trợ video.
      </video>
    );
  }

  if (isAudio) {
    return (
      <audio controls className="w-full my-2">
        <source src={fileUrl} type={t.startsWith("audio/") ? t : undefined} />
        Trình duyệt của bạn không hỗ trợ audio.
      </audio>
    );
  }

  // file/link bình thường
  return (
    <a
      href={fileUrl}
      target="_blank"
      rel="noopener noreferrer"
      className="text-blue-600 underline"
    >
      Xem tài liệu
    </a>
  );
};

export default MediaPlayer;
