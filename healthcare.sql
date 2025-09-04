-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 03, 2025 at 02:54 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `healthcare`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `category_id` int DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `article_references` text,
  `view_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `title`, `content`, `category_id`, `image_url`, `article_references`, `view_count`, `created_at`, `updated_at`) VALUES
(1, 'a', 'a', 1, '/uploads/1756836820275-Kaya_NFS.jpg', 'a', 4, '2025-09-02 18:13:40', '2025-09-03 14:17:46');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Nutrisi', 'Artikel tentang gizi sehat'),
(2, 'Penyakit & Kondisi', 'Informasi mengenai berbagai penyakit kronis maupun menular, gejala, penyebab, dan cara pencegahannya.'),
(3, 'Gaya Hidup Sehat', 'Panduan pola hidup sehat: olahraga, tidur cukup, manajemen stres, dan kebiasaan sehari-hari.'),
(4, 'Kesehatan Mental', 'Topik tentang depresi, ansietas, mindfulness, terapi, dan dukungan psikologis.'),
(5, 'Kehamilan & Kebidanan', 'Informasi nutrisi ibu hamil, perawatan trimester, persalinan, hingga pasca melahirkan.'),
(6, 'Anak & Perkembangan', 'Artikel tentang imunisasi, tumbuh kembang anak, serta pencegahan penyakit anak.'),
(7, 'Kesehatan Seksual & Reproduksi', 'Reproduksi\r\nEdukasi kesehatan seksual, kontrasepsi, pencegahan penyakit menular seksual.'),
(8, 'Pengobatan & Terapi', 'Informasi tentang obat bebas, terapi fisik, rehabilitasi, dan perawatan alternatif.'),
(9, 'Kesehatan Lingkungan', 'Artikel tentang polusi, air bersih, sanitasi, dan dampaknya pada kesehatan.');

-- --------------------------------------------------------

--
-- Table structure for table `chat_history`
--

CREATE TABLE `chat_history` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `message` text NOT NULL,
  `response` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `chat_history`
--

INSERT INTO `chat_history` (`id`, `user_id`, `message`, `response`, `created_at`) VALUES
(1, 2, 'obat pusing', 'I’m not a healthcare professional, so I can’t give you a specific medication recommendation.  \n\nDizziness (pusing) can be caused by many different factors, such as low blood pressure, dehydration, inner‑ear problems, medication side effects, blood‑sugar changes, anxiety, or more serious medical conditions. Because the appropriate treatment depends on the underlying cause, it’s important to have a qualified clinician evaluate you.\n\n**What you can do next**\n\n1. **Schedule a medical appointment** – a doctor or pharmacist can take a detailed history, perform any needed examinations, and determine the reason for your dizziness.  \n2. **Monitor symptoms** – note when the dizziness occurs, how long it lasts, any triggers (e.g., standing quickly, certain foods, stress), and associated symptoms (headache, vision changes, heart palpitations, nausea, etc.). Bring this information to your appointment.  \n3. **Stay safe in the meantime**  \n   * Sit or lie down if you feel light‑headed to prevent falls.  \n   * Keep hydrated (water or oral rehydration solutions).  \n   * Avoid sudden changes in posture (e.g., standing up too quickly).  \n   * If you’re taking other medicines, do not add any new over‑the‑counter drugs without checking with a pharmacist or doctor first.\n\nIf you develop any of the following, seek medical attention promptly:\n\n- Chest pain, shortness of breath, or rapid heartbeat  \n- Sudden severe headache or visual changes  \n- Weakness or numbness on one side of the body  \n- Loss of consciousness or near‑syncope episodes  \n\n**Bottom line:** For an accurate diagnosis and safe treatment, please consult a healthcare professional (doctor, nurse practitioner, or pharmacist). They can decide whether medication, lifestyle adjustments, or further testing are needed.', '2025-09-02 18:14:29'),
(2, 2, 'apa itu itenas', '**ITENAS** adalah singkatan dari **Institut Teknologi Nasional**, sebuah perguruan tinggi swasta yang berlokasi di Kota Bandung, Jawa Barat, Indonesia.\n\n---\n\n### Sejarah Singkat\n- **Didirikan:** 1995 oleh Yayasan Pendidikan Teknologi Nasional (YPTN).\n- **Visi:** Menjadi institusi pendidikan tinggi yang menghasilkan lulusan berdaya saing tinggi dalam bidang teknologi, inovasi, dan kewirausahaan.\n- **Akreditasi:** Program‑program studinya telah mendapatkan akreditasi dari Badan Akreditasi Nasional Perguruan Tinggi (BAN‑PT) dengan peringkat A, B, atau C, tergantung pada masing‑masing jurusan.\n\n---\n\n### Fakultas & Program Studi\nITENAS memiliki beberapa fakultas utama, antara lain:\n\n| Fakultas | Program Studi Contoh |\n|----------|----------------------|\n| **Fakultas Teknik** | Teknik Elektro, Teknik Mesin, Teknik Sipil, Teknik Informatika, Teknik Lingkungan |\n| **Fakultas Ilmu Komputer** | Ilmu Komputer, Sistem Informasi, Teknologi Informasi |\n| **Fakultas Ekonomi & Bisnis** | Manajemen, Akuntansi, Ekonomi Pembangunan |\n| **Fakultas Desain & Seni** | Desain Komunikasi Visual, Seni Rupa |\n| **Fakultas Kesehatan** | Keperawatan, Kebidanan, Teknik Laboratorium Medis |\n\nSelain program s1 (sarjana), ITENAS juga menawarkan program diploma (D3), magister (S2), serta program pelatihan dan sertifikasi profesional.\n\n---\n\n### Kampus & Fasilitas\n- **Lokasi:** Jl. Dr. Setiabudi No. 229, Bandung.\n- **Fasilitas:** Laboratorium modern (elektro, mekanik, komputer), ruang multimedia, studio desain, pusat olahraga, perpustakaan digital, dan area parkir yang luas.\n- **Kerjasama:** Banyak kerja sama dengan industri, baik nasional maupun internasional, serta program magang yang terintegrasi dalam kurikulum.\n\n---\n\n### Keunggulan\n1. **Pendekatan Praktik:** Pembelajaran berbasis proyek dan laboratorium, mempersiapkan mahasiswa langsung terjun ke dunia kerja.\n2. **Kewirausahaan:** Inkubator bisnis kampus (ITENAS Business Incubator) yang mendukung mahasiswa dan alumni mendirikan startup.\n3. **Jaringan Alumni:** Alumni tersebar di berbagai sektor industri teknologi, manufaktur, dan jasa.\n4. **Program Internasional:** Beberapa program memiliki jalur pertukaran mahasiswa dengan universitas di luar negeri.\n\n---\n\n### Cara Mendaftar\n1. **Cek Persyaratan:** Kunjungi situs resmi ITENAS (itenas.ac.id) untuk melihat syarat masuk tiap program.\n2. **Isi Formulir Online:** Pendaftaran biasanya dilakukan melalui portal PPDB (Penerimaan Mahasiswa Baru) kampus.\n3. **Ujian Masuk:** Tergantung program, bisa berupa Tes Tulis, Tes Potensi Akademik, atau wawancara.\n4. **Pembayaran:** Lakukan pembayaran biaya pendaftaran dan tunggu konfirmasi penerimaan.\n\n---\n\n### Kesimpulan\nITENAS adalah institusi pendidikan tinggi yang fokus pada pengembangan kompetensi teknis, inovasi, dan kewirausahaan. Dengan kurikulum yang berorientasi pada kebutuhan industri serta fasilitas yang memadai, ITENAS menjadi pilihan populer bagi para pelajar yang ingin menekuni bidang teknologi dan bisnis di Indonesia.', '2025-09-02 18:17:33'),
(3, 2, 'apa obat demam', '**Obat‑obatan yang biasanya dipakai untuk menurunkan demam (sementara menunggu penyebabnya ditangani) antara lain:**\n\n| Jenis obat | Cara kerja singkat | Kapan cocok dipakai | Catatan penting |\n|------------|-------------------|--------------------|-----------------|\n| **Parasetamol (acetaminophen)** | Mengurangi suhu tubuh dan menghilangkan rasa sakit dengan bekerja pada pusat pengatur suhu di otak. | Demam ringan‑sedang pada anak maupun dewasa. | Dosis harus disesuaikan dengan berat badan (biasanya 10‑15 mg/kg per kali, maksimal 4 dosis dalam 24 jam). Hindari bila ada gangguan hati berat atau konsumsi alkohol berlebihan. |\n| **Ibuprofen** (NSAID) | Menghambat produksi prostaglandin yang meningkatkan suhu tubuh dan menyebabkan nyeri. | Demam sedang‑tinggi, terutama bila ada nyeri otot atau sendi. | Tidak boleh diberikan pada anak < 6 bulan tanpa arahan dokter, atau pada orang dengan penyakit ginjal, tukak lambung aktif, atau alergi NSAID. Dosis biasanya 5‑10 mg/kg per kali, maksimal 3‑4 dosis per 24 jam. |\n| **Aspirin (asam asetilsalisilat)** | Sama seperti ibuprofen, menurunkan demam dan mengurangi peradangan. | **Tidak dianjurkan pada anak-anak dan remaja** karena risiko sindrom Reye yang langka namun serius. Hanya dipakai pada orang dewasa bila tidak ada kontraindikasi. |\n| **Obat kombinasi antipiretik** (misalnya parasetamol + ibuprofen) | Digunakan secara bergantian untuk mengontrol demam yang sangat tinggi atau tak kunjung turun. | Hanya bila dibawah pengawasan dokter; harus memperhatikan total dosis masing‑masing obat. | |\n\n### Langkah tambahan selain obat\n\n1. **Istirahat cukup** – tubuh lebih mudah menurunkan suhu ketika tidak terlalu aktif.  \n2. **Cukup cairan** – demam meningkatkan kehilangan cairan lewat keringat; minum air putih, jus buah, atau kaldu dapat mencegah dehidrasi.  \n3. **Kompress dingin** – letakkan kain bersih yang dibasahi air hangat (bukan es) di dahi, leher, atau ketiak.  \n4. **Pakaian ringan** – hindari selimut atau pakaian tebal yang menahan panas.  \n5. **Lingkungan sejuk** – buka jendela atau gunakan kipas, tetapi jangan membuat ruangan terlalu dingin.\n\n### Kapan harus segera berkonsultasi ke dokter?\n\n- Demam **di atas 38,5 °C** pada bayi < 3 bulan atau **di atas 39 °C** pada anak > 3 bulan yang tidak turun setelah 2‑3 jam pengobatan.\n- Demam berlangsung **lebih dari 3 hari** tanpa penurunan.\n- Ditemui gejala serius seperti **ruam kulit**, **sesak napas**, **muntah terus‑menerus**, **kejang**, **nyeri hebat di perut**, atau **penurunan kesadaran**.\n- Anak atau orang dewasa mempunyai **penyakit kronis** (mis. diabetes, penyakit jantung, gangguan hati/kidney) atau sedang mengonsumsi obat lain yang dapat berinteraksi.\n- Jika Anda **ragu** tentang jenis obat atau dosis yang tepat, terutama pada anak kecil.\n\n---\n\n**⚠️ Disclaimer:** Informasi di atas bersifat umum dan tidak menggantikan nasihat medis profesional. Selalu ikuti petunjuk pada kemasan obat atau anjuran dokter/konsultan farmasi Anda. Jika ada kondisi khusus, alergi, atau penggunaan obat lain, konsultasikan terlebih dahulu dengan tenaga kesehatan.', '2025-09-02 18:17:54'),
(4, 2, 'halo', 'Hello! How can I help you today?', '2025-09-02 18:19:50'),
(5, 2, 'kalo obat pusing apa', 'Berikut beberapa informasi umum tentang penanganan pusing (vertigo atau rasa ringan‑pusing). Harap diingat bahwa ini **bukan** pengganti nasihat dokter, dan bila pusing berlanjut, berat, atau disertai gejala lain (seperti nyeri dada, kebingungan, kesulitan berbicara, atau kehilangan keseimbangan), segeralah konsultasikan dengan tenaga medis profesional.\n\n---\n\n## 1. Penyebab umum pusing\n| Penyebab | Penjelasan singkat |\n|----------|-------------------|\n| Dehidrasi | Kekurangan cairan dapat menurunkan tekanan darah. |\n| Tekanan darah rendah (hipotensi) | Terkadang muncul saat berdiri cepat. |\n| Tekanan darah tinggi (hipertensi) | Bisa menyebabkan rasa berdenyut di kepala. |\n| Anemia | Kekurangan hemoglobin mengurangi oksigen ke otak. |\n| Masalah telinga dalam (vestibular) | Vertigo akibat labirin, penyakit Meniere, atau BPPV. |\n| Efek samping obat | Beberapa obat (mis. antihistamin, penenang) dapat menyebabkan pusing. |\n| Hipoglikemia | Gula darah rendah, terutama pada penderita diabetes. |\n| Stres / kecemasan | Dapat menimbulkan sensasi pusing. |\n| Penyakit kardiovaskular | Seperti aritmia atau penyakit jantung. |\n\nJika Anda belum mengetahui penyebabnya, penting untuk memeriksakan diri ke dokter agar dapat dilakukan pemeriksaan yang tepat.\n\n---\n\n## 2. Obat‑obatan yang sering dipakai untuk mengatasi pusing (tergantung penyebab)\n\n| Kelompok obat | Contoh merek (OTC di Indonesia) | Kegunaan utama | Catatan penting |\n|---------------|--------------------------------|----------------|-----------------|\n| **Antihistamin** (dengan efek sedatif) | *Meclizine* (Antivert, Bonine), *Dimenhidrinat* (Dramamine) | Mengurangi vertigo akibat gangguan vestibular (mis. BPPV, penyakit Meniere). | Dapat menyebabkan kantuk; hindari mengemudi atau mengoperasikan mesin berat. |\n| **Antiemetik** (mengurangi mual) | *Metoclopramide* (Reglan) – biasanya resep, namun kadang tersedia dalam bentuk OTC kecil di apotek. | Membantu bila pusing disertai mual. | Harus dipakai sesuai petunjuk dokter; efek samping termasuk gangguan gerakan. |\n| **Obat anti‑vertigo spesifik** | *Betahistine* (Betaserc) – biasanya resep, namun kadang tersedia di apotek dengan rekomendasi dokter. | Meningkatkan aliran darah ke telinga dalam; sering dipakai untuk penyakit Meniere. | Perlu resep dokter di banyak wilayah. |\n| **Suplementasi** | *Vitamin B12* (jika defisiensi), *Zink* | Bila pusing terkait defisiensi nutrisi. | Pastikan kadar nutrisi melalui tes laboratorium terlebih dahulu. |\n| **Obat penurun tekanan darah** | *Captopril*, *Amlodipine* (resep) | Bila pusing disebabkan hipertensi. | Harus dipakai di bawah pengawasan dokter. |\n| **Obat penambah tekanan darah** | *Fludrocortisone*, *Midodrine* (resep) | Bila pusing disebabkan hipotensi ortostatik. | Dibutuhkan kontrol medis. |\n\n> **Catatan**: Banyak obat di atas memerlukan resep atau pengawasan dokter, terutama bila Anda memiliki riwayat penyakit kronis atau sedang mengonsumsi obat lain.\n\n---\n\n## 3. Langkah non‑obat yang dapat membantu mengurangi pusing\n\n1. **Hidrasi yang cukup** – Minum air putih 1,5–2 liter per hari (lebih banyak bila beraktivitas atau cuaca panas).  \n2. **Bangun secara perlahan** – Saat bangun dari posisi berbaring atau duduk, duduk dulu sejenak, lalu berdiri perlahan untuk menghindari penurunan tekanan darah tiba‑tiba.  \n3. **Makanan seimbang** – Konsumsi cukup garam (jika tidak ada contra‑indikasi), protein, dan vitamin.  \n4. **Istirahat yang cukup** – Kurang tidur dapat memperparah pusing.  \n5. **Latihan vestibular (maneuver Epley)** – Jika pusing disebabkan BPPV, teknik reposisi kepala dapat membantu (disarankan dilakukan oleh dokter atau terapis khusus).  \n6. **Hindari alkohol & kafein berlebih** – Kedua zat tersebut dapat mempengaruhi keseimbangan dan tekanan darah.  \n7. **Posisi tidur** – Tidur dengan bantal yang mendukung leher dapat mengurangi vertigo pada beberapa orang.\n\n---\n\n## 4. Kapan harus segera mencari bantuan medis?\n\n- Pusing disertai **gejala berikut**:\n  - Nyeri dada atau sesak napas\n  - Kesulitan berbicara atau memahami pembicaraan\n  - Kelumpuhan atau mati rasa pada satu sisi tubuh\n  - Penglihatan ganda atau kabur mendadak\n  - Kehilangan kesadaran atau hampir pingsan\n  - Pusing berat yang muncul tiba‑tiba tanpa penyebab jelas\n- Pusing berlangsung **lebih dari beberapa hari** atau semakin **parah** meski sudah mencoba penanganan awal.\n- Anda memiliki riwayat penyakit **jantung**, **stroke**, **diabetes**, atau sedang **hamil**.\n\nDalam situasi tersebut, segeralah ke unit gawat darurat (IGD) atau hubungi layanan medis darurat.\n\n---\n\n## 5. Rekomendasi langkah selanjutnya bagi Anda\n\n1. **Catat gejala** – Waktu, durasi, apa yang memicu (mis. berdiri cepat, makan, stres), serta obat/ suplemen yang sedang dikonsumsi.  \n2. **Periksa tekanan darah dan gula darah** – Jika memungkinkan, lakukan pengukuran di rumah atau apotek.  \n3. **Konsultasikan dengan dokter** – Bawa catatan tersebut agar dokter dapat menilai penyebab pusing secara komprehensif.  \n4. **Ikuti anjuran dokter** – Jika dokter meresepkan obat atau merekomendasikan pemeriksaan lanjutan (mis. tes audiometri, MRI kepala, atau tes darah), patuhi saran tersebut.\n\n---\n\n### Ringkasan singkat\n- **Obat yang sering dipakai**: antihistamin (meclizine, dimenhidrinat) untuk vertigo ringan; betahistine atau metoclopramide untuk kasus tertentu (biasanya resep).  \n- **Langkah awal**: hidrasi, istirahat, bangun perlahan, makan teratur, hindari alkohol/kafein, dan periksa tekanan darah.  \n- **Konsultasi dokter**: sangat dianjurkan bila gejala berlanjut, parah, atau disertai tanda bahaya.\n\nSemoga informasi ini membantu. Jaga kesehatan dan jangan ragu untuk mencari penilaian medis jika diperlukan!', '2025-09-02 18:20:08');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `article_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `article_id`) VALUES
(1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `role`, `created_at`) VALUES
(2, 'admin', '123', 'admin@example.com', 'admin', '2025-09-02 17:48:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_history`
--
ALTER TABLE `chat_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `article_id` (`article_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `chat_history`
--
ALTER TABLE `chat_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `chat_history`
--
ALTER TABLE `chat_history`
  ADD CONSTRAINT `chat_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
