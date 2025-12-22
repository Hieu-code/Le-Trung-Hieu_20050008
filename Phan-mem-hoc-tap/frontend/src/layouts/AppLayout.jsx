// src/layouts/AppLayout.jsx
import React from "react";
import { Outlet } from "react-router-dom";
import Navbar from "../components/Navbar.jsx";

export default function AppLayout() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-slate-100 to-slate-50 text-gray-900">
      <Navbar />
      <main className="mx-auto max-w-6xl px-4 pb-8 pt-4 md:pt-6">
        <div className="rounded-3xl border border-white/60 bg-white/80 shadow-[0_18px_45px_rgba(15,23,42,0.08)] backdrop-blur">
          <div className="p-4 md:p-6 lg:p-8">
            <Outlet />
          </div>
        </div>
      </main>
    </div>
  );
}
