# Architecture — Lecturer GitHub Tracker

## 1. Overview

Lecturer GitHub Tracker adalah aplikasi full-stack yang digunakan oleh dosen untuk memantau aktivitas repository GitHub mahasiswa.

Aplikasi mengambil data commit dari repository GitHub mahasiswa ketika proses sinkronisasi dijalankan oleh dosen. Data commit yang diperoleh disimpan ke database MySQL dan digunakan untuk menampilkan ringkasan perkembangan mahasiswa pada dashboard.

Aplikasi menggunakan arsitektur monorepo dengan pemisahan frontend, backend, dan shared package.

---

## 2. Architecture

Arsitektur aplikasi terdiri dari tiga bagian utama:

```text
lecturer-github-tracker/
│
├── apps/
│   ├── web/                  # Frontend
│   └── api/                  # Backend
│
└── packages/
    └── shared/               # Shared types dan constants