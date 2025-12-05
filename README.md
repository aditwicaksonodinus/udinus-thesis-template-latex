# 📚 Template Tesis UDINUS (Magister Teknik Informatika)

---
| **Role**        | **Name**            |
|-----------------|---------------------|
| **Author**      | Adit Wicaksono[^1]  |
| **Contributor** | Ismail Oktavian, Jarot Muchtar |

[^1]: Email: Aditwicaksono34@gmail.com, p31202402610@mhs.dinus.ac.id
---

Template LaTeX untuk penulisan tesis Program Pascasarjana Magister Teknik Informatika, Universitas Dian Nuswantoro (UDINUS). Disusun mengikuti Panduan Tesis UDINUS (2020).

## 📋 Daftar Isi

- [Persyaratan](#-persyaratan)
- [Struktur Folder](#-struktur-folder)
- [Panduan Kompilasi](#-panduan-kompilasi)
- [Konfigurasi VS Code](#-konfigurasi-vs-code)
- [Cara Penggunaan](#-cara-penggunaan)
- [Troubleshooting](#-troubleshooting)

---

## 🔧 Persyaratan

Pastikan sistem Anda sudah terinstal:

| Software                     | Keterangan                                             |
| ---------------------------- | ------------------------------------------------------ |
| **TeX Live** atau **MiKTeX** | Distribusi LaTeX lengkap                               |
| **XeLaTeX**                  | Compiler untuk mendukung font system (Times New Roman) |
| **Biber**                    | Pemroses bibliografi untuk biblatex                    |
| **VS Code**                  | Editor yang direkomendasikan                           |
| **LaTeX Workshop**           | Ekstensi VS Code untuk LaTeX                           |
| **Font Times New Roman**     | Harus terinstal di sistem                              |

### Instalasi di Ubuntu/Debian

```bash
# Instal TeX Live lengkap
sudo apt update
sudo apt install texlive-full

# Instal font Microsoft (termasuk Times New Roman)
sudo apt install ttf-mscorefonts-installer
```

### Instalasi di Windows

1. Unduh dan instal [MiKTeX](https://miktex.org/download)
2. Font Times New Roman sudah tersedia secara default

### Instalasi di MacOS

#### install via terminal, menggunakan Brew

```bash
brew install --cask mactex
```
Semua paket sudah termasuk

#### Install via MacTex

1. Buka situs resmi LaTeX: latex-project.org/get, Pilih distribusi MacTeX (sekitar 4 GB, karena sudah termasuk paket lengkap).
2. Jalankan file `.pkh` hasil download, Ikuti setup biasa
3. Integrasi dengan VScode + LateX Workshop
   
---

## 📁 Struktur Folder

```
udinus-thesis-template/
├── main.tex                    # File utama (compile dari sini)
├── references.bib              # Database referensi
├── README.md                   # Dokumentasi ini
│
├── frontmatter/                # Halaman depan
│   ├── cover.tex               # Sampul
│   ├── titlepage.tex           # Halaman judul
│   ├── pengesahan_status.tex   # Pengesahan status
│   ├── pernyataan_penulis.tex  # Pernyataan keaslian
│   ├── persetujuan_tesis.tex   # Persetujuan tesis
│   ├── pengesahan_tesis.tex    # Pengesahan tesis
│   ├── abstract_en.tex         # Abstract (English)
│   ├── abstract_id.tex         # Abstrak (Indonesia)
│   ├── acknowledgments.tex     # Kata pengantar
│   ├── daftar_isi.tex          # Daftar isi
│   └── ...                     # Daftar lainnya
│
├── chapters/                   # Bab-bab tesis
│   ├── bab1_pendahuluan.tex
│   ├── bab2_tinjauan_pustaka.tex
│   ├── bab3_metode_penelitian.tex
│   ├── bab4_pelaksanaan_hasil.tex
│   └── bab5_penutup.tex
│
├── backmatter/                 # Lampiran
│   ├── lampiran_a.tex
│   └── ...
│
└── documents/                  # Gambar dan aset
    ├── udinus-logo.png
    └── ...
```

---

## 🚀 Panduan Kompilasi

### Urutan Kompilasi (PENTING!)

Template ini menggunakan **XeLaTeX** dan **Biber**. Urutan kompilasi yang benar:

```
XeLaTeX → Biber → XeLaTeX → XeLaTeX
```

| Langkah | Perintah           | Fungsi                                 |
| ------- | ------------------ | -------------------------------------- |
| 1       | `xelatex main.tex` | Kompilasi awal, generate .aux dan .bcf |
| 2       | `biber main`       | Proses bibliografi dari references.bib |
| 3       | `xelatex main.tex` | Update referensi dan sitasi            |
| 4       | `xelatex main.tex` | Finalisasi cross-reference             |

### Kompilasi Manual (Terminal)

```bash
cd /path/to/udinus-thesis-template

# Langkah 1: XeLaTeX pertama
xelatex -synctex=1 -interaction=nonstopmode main.tex

# Langkah 2: Biber
biber main

# Langkah 3 & 4: XeLaTeX dua kali lagi
xelatex -synctex=1 -interaction=nonstopmode main.tex
xelatex -synctex=1 -interaction=nonstopmode main.tex
```

---

## ⚙️ Konfigurasi VS Code

### Instalasi Ekstensi

1. Buka VS Code
2. Tekan `Ctrl+Shift+X` untuk membuka Extensions
3. Cari dan instal **LaTeX Workshop** by James Yu

### Konfigurasi settings.json

Buka Settings JSON (`Ctrl+Shift+P` → "Preferences: Open Settings (JSON)") dan tambahkan konfigurasi berikut:

```json
{
  // ===================== LATEX Config ========================
  "latex-workshop.formatting.latex": "none",
  "[latex]": {
    "editor.formatOnSave": false,
    "editor.lineHeight": 2.0,
    "editor.suggestSelection": "recentlyUsedByPrefix",
    "editor.fontFamily": "Fira Code",
    "editor.fontWeight": "500",
    "editor.fontSize": 16,
    "editor.fontLigatures": true
  },

  // Latex Workshop view
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.synctex.afterBuild.enabled": true,
  "latex-workshop.view.pdf.internal.synctex.keybinding": "double-click",
  "latex-workshop.chktex.enabled": false,

  // ===================== Build Recipes ========================
  // Resep build LaTeX - XeLaTeX + Biber (untuk fontspec & bibliografi)
  "latex-workshop.latex.recipes": [
    {
      "name": "xelatex -> biber -> xelatex*2",
      "tools": [
        "xelatex",
        "biber",
        "xelatex",
        "xelatex"
      ]
    },
    {
      "name": "xelatex only",
      "tools": [
        "xelatex"
      ]
    }
  ],

  "latex-workshop.latex.recipe.default": "first",
  "latex-workshop.latex.autoBuild.run": "onSave",

  // ===================== Build Tools ========================
  "latex-workshop.latex.tools": [
    {
      "name": "xelatex",
      "command": "xelatex",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "biber",
      "command": "biber",
      "args": [
        "%DOCFILE%"
      ]
    }
  ]
}
```

### Cara Menggunakan di VS Code

1. Buka folder template di VS Code
2. Buka file `main.tex`
3. Tekan `Ctrl+Alt+B` untuk build, atau
4. Simpan file (`Ctrl+S`) untuk auto-build
5. Tekan `Ctrl+Alt+V` untuk melihat PDF

---

## 📝 Cara Penggunaan

### 1. Edit Metadata Tesis

Buka `main.tex` dan edit bagian **VARIABEL METADATA TESIS**:

```latex
\newcommand{\ThesisTitle}{JUDUL TESIS ANDA}
\newcommand{\AuthorName}{NAMA LENGKAP ANDA}
\newcommand{\StudentID}{P31.2024.XXXXX}
\newcommand{\SupervisorOne}{Dr. Nama Pembimbing, M.Kom.}
% ... dan seterusnya
```

### 2. Tulis Konten Bab

Edit file-file di folder `chapters/`:
- `bab1_pendahuluan.tex` - Latar belakang, rumusan masalah, tujuan
- `bab2_tinjauan_pustaka.tex` - Landasan teori
- `bab3_metode_penelitian.tex` - Metodologi
- `bab4_pelaksanaan_hasil.tex` - Hasil dan pembahasan
- `bab5_penutup.tex` - Kesimpulan dan saran

### 3. Tambah Referensi

Edit `references.bib` dengan format BibTeX:

```bibtex
@article{Penulis2024,
  author  = {Nama Penulis},
  title   = {Judul Artikel},
  journal = {Nama Jurnal},
  year    = {2024},
  volume  = {10},
  pages   = {1-15}
}
```

Lalu sitasi di dokumen dengan `\cite{Penulis2024}`.

### 4. Sisipkan Gambar

```latex
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{documents/nama-gambar.png}
  \caption{Keterangan gambar.}
  \label{fig:nama-label}
\end{figure}
```

---

## 🔍 Troubleshooting

### Referensi muncul sebagai [?]

**Solusi:** Kompilasi ulang dengan urutan lengkap: XeLaTeX → Biber → XeLaTeX → XeLaTeX

### Font Times New Roman tidak ditemukan

**Solusi:**
```bash
# Ubuntu/Debian
sudo apt install ttf-mscorefonts-installer
sudo fc-cache -fv
```

### Sitasi tidak muncul di daftar pustaka

**Solusi:** Pastikan menjalankan Biber setelah kompilasi pertama

### Error "Undefined control sequence"

**Solusi:** Pastikan paket yang diperlukan sudah di-load di `main.tex`

### Gambar tidak ditemukan

**Solusi:** Periksa path gambar. Folder default adalah `documents/`

---

## 📄 Lisensi

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Template ini dilisensikan di bawah **Apache License 2.0** - lisensi open source yang permisif.

Anda bebas untuk:
- ✅ Menggunakan template ini untuk keperluan akademik maupun komersial
- ✅ Memodifikasi dan menyesuaikan sesuai kebutuhan
- ✅ Mendistribusikan ulang dalam bentuk asli atau modifikasi
- ✅ Menggunakan dalam proyek proprietary

Dengan syarat:
- 📝 Menyertakan salinan lisensi Apache 2.0
- 📝 Menyatakan perubahan yang dilakukan (jika ada modifikasi)
- 📝 Menyertakan pemberitahuan hak cipta asli

Untuk detail lengkap, lihat file [LICENSE](LICENSE) atau kunjungi [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

---

## 🤝 Kontribusi

Jika menemukan bug atau ingin menambahkan fitur, silakan berkontribusi melalui GitHub:

```bash
# Clone repository
git clone github.com/aditwicaksonodinus/udinus-thesis-template-latex/

# Buat branch baru untuk fitur/perbaikan
git checkout -b fitur-baru

# Commit perubahan
git commit -m "Deskripsi perubahan"

# Push ke repository
git push origin fitur-baru
```

Lalu buat **Pull Request** di GitHub untuk review dan merge. Kirim email untuk menjadi kontributor kami!

---

**Happy Writing! 📝**
