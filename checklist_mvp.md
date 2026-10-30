
# ROBSPACE Mobile — MVP Checklist

## A. Autentikasi
- [x] Login Firebase Authentication berhasil diuji.
- [ ] Login dengan password salah menampilkan pesan yang sesuai.
- [ ] Logout berhasil diuji.
- [ ] Akses pengguna yang belum login diuji.

## B. Event
- [x] Membaca daftar event dari Cloud Firestore.
- [x] Menampilkan event pada halaman aplikasi.
- [x] Menyediakan tampilan loading, error, dan data kosong.
- [ ] Tombol retry saat terjadi error diuji.
- [ ] Perubahan data event di Firebase diuji.

## C. Pendaftaran
- [x] Formulir pendaftaran tersedia.
- [x] Validasi nama dan email tersedia.
- [x] Pendaftaran berhasil disimpan ke Firestore.
- [x] UID pengguna disertakan dalam data pendaftaran.
- [ ] Formulir dengan input kosong diuji.
- [ ] Pendaftaran saat koneksi gagal diuji.
- [ ] Kepemilikan data sesuai Security Rules diverifikasi.

## D. Kualitas kode
- [x] `flutter analyze` — No issues found.
- [x] `flutter test` — 15 tes berhasil.
- [x] Perbaikan siklus hidup TextEditingController dilakukan.
- [ ] Pengujian ulang seluruh alur setelah perbaikan UI.

## E. Dokumentasi dan demo
- [x] `HowToRun.md`
- [x] `checklist_mvp.md`
- [ ] Video demo `demo.mp4`
- [ ] Pemeriksaan akhir seluruh deliverable.

## Status
MVP sudah memiliki alur login, membaca event, dan menyimpan pendaftaran. Pengujian tambahan serta perekaman demo masih diperlukan sebelum dinyatakan selesai sepenuhnya.
