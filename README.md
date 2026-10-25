# Proyek UTS Resep Nusantara

Nama            : Muhammad Langgeng Zainul Irsyad Tsalis
NIM             : 240605110174
Mata Kuliah     : Praktikum Mobile Programming I
Dosen Pengampu  : Amalia Fadhila Rahmaniati, S.Kom., M.Kom 

# Resep Nusantara

Aplikasi katalog resep masakan Indonesia yang dibuat dengan Flutter sebagai tugas UTS Mobile Programming (Semester Ganjil 2025/2026).

## Tema dan Tujuan

Membantu pengguna menemukan resep masakan dan minuman Nusantara berdasarkan kategori, lengkap dengan bahan dan langkah memasaknya. Tampilan bertema warna ubi ungu dengan aksen kuning kunyit.

## Halaman dan Fungsinya

| Halaman | File | Fungsi |
|---|---|---|
| Beranda | `lib/screens/home_screen.dart` | Pencarian, pintasan 4 kategori, resep populer (geser horizontal), dan resep terbaru. |
| Daftar Resep | `lib/screens/recipe_list_screen.dart` | Daftar resep per kategori atau semua resep, dengan pencarian langsung. Layar lebar memakai grid 2 kolom. |
| Detail Resep | `lib/screens/recipe_detail_screen.dart` | Info singkat, bahan-bahan, langkah memasak, dan tombol favorit. |

Navigasi memakai `Navigator.pushNamed` dengan `onGenerateRoute` (lihat `lib/main.dart` dan `lib/routes.dart`).

## Struktur Proyek

```
lib/
  main.dart                  # entry point, tema, routing
  routes.dart                # konstanta nama route
  models/                    # Recipe, RecipeCategory
  services/                  # RecipeRepository (sumber data)
  screens/                   # tiga halaman aplikasi
  widgets/                   # komponen yang dipakai ulang
  theme/                     # warna dan tema
assets/data/recipes.json     # data dummy (10 resep)
```

## Persiapan Data untuk API

Data dibaca lewat `RecipeRepository.fetchRecipes()`. Model `Recipe` sudah punya `fromJson` dengan field snake_case. Saat API tersedia, cukup ganti isi `fetchRecipes()` dengan permintaan HTTP; layar tidak perlu diubah.

## Cara Menjalankan

1. Pastikan Flutter SDK sudah terpasang (`flutter doctor`).
2. Buat proyek baru: `flutter create resep_nusantara`
3. Salin folder `lib/`, `assets/`, dan `README.md` dari repositori ini ke proyek tersebut (timpa file yang ada), lalu gunakan `pubspec.yaml` dari repositori ini atau tambahkan bagian `assets:` ke `pubspec.yaml` milik Anda.
4. Hapus `test/widget_test.dart` bawaan agar tidak error.
5. Jalankan `flutter pub get`, lalu `flutter run`.
