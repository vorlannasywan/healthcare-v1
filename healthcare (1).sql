-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 04, 2025 at 03:28 PM
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
(2, 'Pentingnya Imunisasi Anak untuk Masa Depan Sehat', 'munisasi adalah langkah pencegahan penyakit menular yang efektif. WHO menekankan imunisasi dapat menyelamatkan jutaan nyawa setiap tahun.', 6, '/uploads/1756917563486-imunisasi.png', 'https://www.who.int/health-topics/vaccines', 3, '2025-09-03 16:39:23', '2025-09-03 18:17:08'),
(3, 'Gizi Seimbang untuk Anak Usia Sekolah', 'Anak sekolah memerlukan makronutrien (karbohidrat, protein, lemak) dan mikronutrien (vitamin, mineral) untuk tumbuh kembang optimal.', 1, '/uploads/1756917654540-gizi.jpeg', 'https://www.unicef.org/nutrition', 0, '2025-09-03 16:40:54', '2025-09-03 16:40:54'),
(4, 'Mengurangi Risiko Diabetes dengan Pola Makan Sehat', 'Diabetes tipe 2 dapat dicegah dengan diet rendah gula, aktivitas fisik teratur, dan kontrol berat badan.', 2, '/uploads/1756917803411-diabebetes.jpg', 'https://www.who.int/news-room/fact-sheets/detail/diabetes', 1, '2025-09-03 16:43:23', '2025-09-03 18:22:57'),
(5, 'Manajemen Stres dengan Teknik Mindfulness ', 'Mindfulness terbukti menurunkan tingkat kecemasan, meningkatkan fokus, dan kesehatan mental.', 4, '/uploads/1756917889697-mental.jpeg', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC3679190/%5d', 0, '2025-09-03 16:44:49', '2025-09-03 16:44:49'),
(6, 'Pentingnya Aktivitas Fisik 30 Menit Sehari', 'ktivitas fisik sedang, seperti jalan cepat atau bersepeda, membantu mencegah penyakit jantung dan meningkatkan kualitas hidup.', 3, '/uploads/1756917958561-sehat gaya.jpg', 'https://www.cdc.gov/physical-activity', 1, '2025-09-03 16:45:58', '2025-09-03 16:46:16'),
(7, 'Nutrisi Ibu Hamil Trimester Pertama', 'Asam folat, zat besi, dan protein sangat penting untuk perkembangan janin pada awal kehamilan.', 5, '/uploads/1756918060241-vidan.jpeg', 'https://www.who.int/health-topics/maternal-health', 1, '2025-09-03 16:47:40', '2025-09-03 18:23:52'),
(8, 'Dampak Polusi Udara terhadap Kesehatan Paru-Paru', ' Polusi udara meningkatkan risiko asma, bronkitis, dan kanker paru. SDG 3 menekankan pentingnya lingkungan sehat.', 9, '/uploads/1756918153568-lingkungan.jpg', 'https://www.who.int/health-topics/air-pollution', 1, '2025-09-03 16:49:13', '2025-09-03 17:58:17'),
(9, 'Pencegahan HIV/AIDS dengan Edukasi Seksual', 'Edukasi seksual yang benar dapat menurunkan penularan HIV/AIDS pada remaja. ', 7, '/uploads/1756918239427-aid.jpeg', 'https://www.unaids.org/en', 2, '2025-09-03 16:50:39', '2025-09-03 17:08:40'),
(10, 'Vaksinasi HPV untuk Pencegahan Kanker Serviks', 'Vaksin HPV direkomendasikan pada remaja untuk mencegah kanker serviks di usia dewasa.', 8, '/uploads/1756918334557-paksin.jpeg', 'http://cancer.org/cancer/cervical-cancer/prevention-and-early-detection/hpv-vaccines.html', 4, '2025-09-03 16:52:14', '2025-09-03 18:22:47'),
(11, 'Dampak Konsumsi Alkohol terhadap Kesehatan', 'Alkohol meningkatkan risiko penyakit hati, kanker, dan kecelakaan lalu lintas. WHO mendorong pengurangan konsumsi alkohol global.', 2, '/uploads/1756918388071-alko.png', 'https://www.who.int/news-room/fact-sheets/detail/alcohol', 3, '2025-09-03 16:53:08', '2025-09-03 17:38:12');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
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
  `sender` enum('user','bot') NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `chat_history`
--

INSERT INTO `chat_history` (`id`, `sender`, `message`, `created_at`) VALUES
(17, 'user', 'Pencegahan Kanker Serviks', '2025-09-03 18:55:08'),
(18, 'bot', 'Ini jawaban bot untuk: Pencegahan Kanker Serviks', '2025-09-03 18:55:08'),
(19, 'user', 'Pencegahan Kanker Serviks', '2025-09-03 18:55:25'),
(20, 'bot', 'Ini jawaban bot untuk: Pencegahan Kanker Serviks', '2025-09-03 18:55:25'),
(21, 'user', 'Dampak Konsumsi Alkohol', '2025-09-03 19:04:14'),
(22, 'bot', 'Ini jawaban bot untuk: Dampak Konsumsi Alkohol', '2025-09-03 19:04:14');

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
(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `role`, `created_at`) VALUES
(2, 'admin', '123', 'admin@example.com', 'admin', '2025-09-02 17:48:52'),
(3, 'admin2', '456', 'admin2@example.com', 'admin', '2025-09-03 15:55:51');

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
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `chat_history`
--
ALTER TABLE `chat_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

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
