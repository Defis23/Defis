
# ROBSPACE Mobile — How to Run

## 1. Deskripsi
ROBSPACE Mobile adalah aplikasi Flutter untuk login pengguna dan melihat serta mendaftar event ROBSPACE. Firebase Authentication digunakan untuk login, sedangkan Cloud Firestore digunakan untuk menyimpan data event dan pendaftaran.

## 2. Prasyarat
- Flutter SDK dan Dart SDK
- Android Studio atau Visual Studio Code
- Browser Microsoft Edge untuk menjalankan versi web
- Koneksi internet
- Akses ke Firebase project ROBSPACE MOBILE

## 3. Instalasi
Buka terminal pada folder proyek, kemudian jalankan:

```powershell
flutter pub get
```

## 4. Konfigurasi Firebase
Proyek menggunakan konfigurasi Firebase pada `lib/firebase_options.dart`.

Pastikan file konfigurasi tersebut tersedia dan project Firebase yang digunakan sesuai dengan konfigurasi aplikasi.

Fitur yang memerlukan Firebase membutuhkan koneksi internet dan pengaturan Firebase yang benar.

## 5. Menjalankan aplikasi
Jalankan aplikasi versi web menggunakan Edge:

```powershell
flutter run -d edge
```

Login menggunakan akun yang sudah terdaftar di Firebase Authentication.

## 6. Menjalankan pemeriksaan kode
```powershell
flutter analyze
```

## 7. Menjalankan pengujian
```powershell
flutter test
```

Pengujian terakhir yang tercatat: 15 tes berhasil.

## 8. Fitur utama
- Login dengan Firebase Authentication
- Menampilkan daftar event dari Cloud Firestore
- Menangani loading, error, dan data event kosong
- Validasi formulir pendaftaran
- Menyimpan pendaftaran event ke Cloud Firestore
- Menyertakan UID pengguna pada data pendaftaran

## 9. Catatan keamanan
Firestore Security Rules membatasi pembacaan event untuk pengguna yang login. Pendaftaran hanya dapat dibuat dengan UID pengguna yang sedang login. Perubahan dan penghapusan pendaftaran tidak diizinkan melalui aturan saat ini.
