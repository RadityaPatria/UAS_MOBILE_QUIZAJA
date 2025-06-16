-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 11 Jun 2025 pada 03.24
-- Versi server: 8.0.30
-- Versi PHP: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quizaja_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int NOT NULL,
  `category` varchar(50) NOT NULL,
  `question` text NOT NULL,
  `option_a` varchar(100) NOT NULL,
  `option_b` varchar(100) NOT NULL,
  `option_c` varchar(100) NOT NULL,
  `option_d` varchar(100) NOT NULL,
  `correct_answer` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `quizzes`
--

INSERT INTO `quizzes` (`id`, `category`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`) VALUES
(13, 'Musik', 'Siapa penyanyi lagu \"Shape of You\"?', 'Ed Sheeran', 'Justin Bieber', 'Shawn Mendes', 'Charlie Puth', 'A'),
(14, 'Musik', 'Band mana yang menyanyikan lagu \"Bohemian Rhapsody\"?', 'The Beatles', 'Queen', 'Led Zeppelin', 'The Rolling Stones', 'B'),
(15, 'Musik', 'Lagu \"Despacito\" dinyanyikan oleh siapa?', 'Zayn Malik', 'Enrique Iglesias', 'Ricky Martin', 'Luis Fonsi', 'D'),
(16, 'Musik', 'Alat musik apa yang identik dengan Jimi Hendrix?', 'Gitar', 'Drum', 'Piano', 'Saxophone', 'A'),
(17, 'Musik', 'Siapa yang dikenal sebagai \"King of Pop\"?', 'Elvis Presley', 'Michael Jackson', 'Prince', 'David Bowie', 'B'),
(18, 'Film', 'Siapa sutradara film \"Titanic\"?', 'James Cameron', 'Steven Spielberg', 'Christopher Nolan', 'Quentin Tarantino', 'A'),
(19, 'Film', 'Film apa yang memenangkan Oscar Best Picture tahun 1994?', 'Parasite', 'The Shawshank Redemption', 'Pulp Fiction', 'Forrest Gump', 'D'),
(20, 'Film', 'Siapa aktor yang memerankan Harry Potter?', 'Tom Felton', 'Rupert Grint', 'Daniel Radcliffe', 'Matthew Lewis', 'C'),
(21, 'Film', 'Film \"The Avengers\" termasuk dalam franchise apa?', 'DC Extended Universe', 'Marvel Cinematic Universe', 'Star Wars', 'Harry Potter', 'B'),
(22, 'Film', 'Siapa yang menyutradarai \"The Dark Knight\"?', 'Tim Burton', 'Zack Snyder', 'Joss Whedon', 'Christopher Nolan', 'D'),
(23, 'Game', 'Game apa yang dikenal dengan karakter bernama Mario?', 'The Legend of Zelda', 'Super Mario', 'Pokemon', 'Sonic the Hedgehog', 'B'),
(24, 'Game', 'Siapa pengembang game \"Fortnite\"?', 'Activision', 'Epic Games', 'EA Sports', 'Rockstar Games', 'B'),
(25, 'Game', 'Game apa yang dikenal dengan \"Battle Royale\" pertama?', 'Minecraft', 'Apex Legends', 'Call of Duty', 'PUBG', 'D'),
(26, 'Game', 'Karakter utama di \"The Legend of Zelda\" bernama?', 'Link', 'Zelda', 'Ganon', 'Epona', 'B'),
(27, 'Game', 'Game \"GTA V\" dikembangkan oleh siapa?', 'Rockstar Games', 'Ubisoft', 'Bethesda', 'Square Enix', 'A'),
(28, 'Pengetahuan Umum', 'Apa ibu kota Prancis?', 'Paris', 'London', 'Berlin', 'Madrid', 'A'),
(29, 'Pengetahuan Umum', 'Siapa penemu lampu pijar?', 'Nikola Tesla', 'Thomas Edison', 'Albert Einstein', 'Isaac Newton', 'B'),
(30, 'Pengetahuan Umum', 'Berapa jumlah planet di tata surya kita?', '7', '9', '8', '10', 'C'),
(31, 'Pengetahuan Umum', 'Apa simbol kimia untuk emas?', 'Au', 'Ag', 'Fe', 'Cu', 'A'),
(32, 'Pengetahuan Umum', 'Gunung tertinggi di dunia adalah?', 'Lhotse', 'K2', 'Kangchenjunga', 'Everest', 'D'),
(33, 'Musik', 'Lagu \"Rolling in the Deep\" dinyanyikan oleh siapa?', 'Beyonce', 'Adele', 'Rihanna', 'Taylor Swift', 'B'),
(34, 'Musik', 'Siapa penyanyi utama band Coldplay?', 'Chris Martin', 'Jonny Buckland', 'Guy Berryman', 'Will Champion', 'A'),
(35, 'Musik', 'Alat musik apa yang dimainkan oleh Mozart dengan mahir?', 'Biola', 'Gitar', 'Piano', 'Drum', 'C'),
(36, 'Musik', 'Lagu \"Sweet Child O\' Mine\" berasal dari band mana?', 'Metallica', 'Aerosmith', 'Nirvana', 'Guns N\' Roses', 'D'),
(37, 'Musik', 'Siapa yang dikenal sebagai \"Queen of Soul\"?', 'Aretha Franklin', 'Whitney Houston', 'Diana Ross', 'Tina Turner', 'A'),
(38, 'Film', 'Siapa aktor yang memerankan Tony Stark di \"Iron Man\"?', 'Robert Downey Jr.', 'Chris Hemsworth', 'Chris Evans', 'Mark Ruffalo', 'A'),
(39, 'Film', 'Film \"Jurassic Park\" dirilis pada tahun berapa?', '1999', '1993', '2001', '1989', 'B'),
(40, 'Film', 'Siapa sutradara film \"Inception\"?', 'Tim Burton', 'Christopher Nolan', 'David Fincher', 'Martin Scorsese', 'B'),
(41, 'Film', 'Film apa yang dikenal dengan kutipan \"May the Force be with you\"?', 'Jumanji', 'Star Trek', 'The Matrix', 'Star Wars', 'D'),
(42, 'Film', 'Siapa aktris yang memerankan Katniss Everdeen di \"The Hunger Games\"?', 'Gal Gadot', 'Emma Watson', 'Jennifer Lawrence', 'Shailene Woodley', 'C'),
(43, 'Game', 'Game \"The Witcher 3\" dikembangkan oleh siapa?', 'CD Projekt Red', 'Bethesda', 'Rockstar Games', 'Ubisoft', 'A'),
(44, 'Game', 'Karakter utama di \"Tomb Raider\" bernama?', 'Ellie', 'Samus Aran', 'Jill Valentine', 'Lara Croft', 'D'),
(45, 'Game', 'Game apa yang dikenal dengan \"Creeper\" sebagai musuhnya?', 'Roblox', 'Terraria', 'Minecraft', 'Stardew Valley', 'C'),
(46, 'Game', 'Siapa pengembang game \"FIFA\" series?', 'Konami', 'EA Sports', '2K Games', 'Sega', 'B'),
(47, 'Game', 'Game \"Among Us\" dirilis pada tahun berapa?', '2018', '2020', '2016', '2019', 'A'),
(48, 'Pengetahuan Umum', 'Apa nama benua terkecil di dunia?', 'Asia', 'Antartika', 'Australia', 'Afrika', 'C'),
(49, 'Pengetahuan Umum', 'Siapa presiden pertama Amerika Serikat?', 'George Washington', 'Thomas Jefferson', 'Abraham Lincoln', 'John Adams', 'A'),
(50, 'Pengetahuan Umum', 'Berapa sisi yang dimiliki segitiga?', '4', '3', '5', '6', 'B'),
(51, 'Pengetahuan Umum', 'Apa nama samudra terbesar di dunia?', 'Pasifik', 'Atlantik', 'Hindia', 'Arktik', 'A'),
(52, 'Pengetahuan Umum', 'Hewan apa yang dikenal sebagai \"Raja Hutan\"?', 'Beruang', 'Harimau', 'Gajah', 'Singa', 'D'),
(73, 'Sains', 'Apa rumus kimia air?', 'H2O', 'CO2', 'O2', 'H2SO4', 'A'),
(74, 'Sains', 'Planet apa yang dikenal sebagai planet merah?', 'Jupiter', 'Mars', 'Venus', 'Saturnus', 'B'),
(75, 'Sains', 'Berapa kecepatan cahaya dalam vakum?', '300,000 km/s', '150,000 km/s', '200,000 km/s', '100,000 km/s', 'A'),
(76, 'Sains', 'Apa yang menyebabkan pelangi?', 'Refleksi cahaya', 'Difraksi cahaya', 'Pembiasan cahaya', 'Absorpsi cahaya', 'C'),
(77, 'Sains', 'Apa satuan gaya dalam SI?', 'Joule', 'Watt', 'Newton', 'Pascal', 'C'),
(78, 'Sains', 'Zat apa yang dihasilkan tumbuhan saat fotosintesis?', 'Nitrogen', 'Oksigen', 'Karbon Dioksida', 'Hidrogen', 'B'),
(79, 'Sains', 'Apa inti atom yang bermuatan positif?', 'Elektron', 'Neutron', 'Proton', 'Positron', 'C'),
(80, 'Sains', 'Berapa jumlah tulang pada tubuh manusia dewasa?', '206', '208', '210', '204', 'A'),
(81, 'Sains', 'Apa nama alat untuk mengukur tekanan udara?', 'Termometer', 'Higrometer', 'Barometer', 'Anemometer', 'C'),
(82, 'Sains', 'Apa sumber energi utama bumi?', 'Matahari', 'Angin', 'Air', 'Pan Bumi', 'A'),
(83, 'Matematika', 'Berapa hasil dari 8 ÷ 2 + 3?', '7', '10', '5', '12', 'A'),
(84, 'Matematika', 'Jika y - 4 = 9, berapa nilai y?', '12', '13', '10', '15', 'B'),
(85, 'Matematika', 'Berapa sudut dalam segitiga sama sisi?', '90°', '45°', '60°', '120°', 'C'),
(86, 'Matematika', 'Apa hasil dari 15 - 2 × 3?', '9', '13', '3', '6', 'A'),
(87, 'Matematika', 'Berapa volume kubus dengan sisi 4 cm?', '64 cm³', '16 cm³', '32 cm³', '48 cm³', 'A'),
(88, 'Matematika', 'Apa hasil dari 3/5 + 2/5?', '1/5', '1', '4/5', '2/5', 'B'),
(89, 'Matematika', 'Jika 4a = 20, berapa a?', '4', '6', '5', '8', 'C'),
(90, 'Matematika', 'Berapa panjang diagonal persegi dengan sisi 6 cm?', '6 cm', '12 cm', '8.5 cm', '9 cm', 'C'),
(91, 'Matematika', 'Apa hasil dari 7² - 5?', '44', '40', '49', '45', 'A'),
(92, 'Matematika', 'Berapa 10% dari 150?', '10', '15', '20', '25', 'B'),
(93, 'Seni dan Budaya', 'Tarian tradisional apa yang berasal dari Bali?', 'Saman', 'Kecak', 'Pendet', 'Jaipongan', 'B'),
(94, 'Seni dan Budaya', 'Alat musik tradisional Indonesia yang terbuat dari bambu adalah?', 'Sasando', 'Angklung', 'Kolintang', 'Gamelan', 'B'),
(95, 'Seni dan Budaya', 'Wayang kulit berasal dari budaya?', 'Jawa', 'Sunda', 'Bali', 'Minang', 'A'),
(96, 'Seni dan Budaya', 'Apa nama kain tradisional yang terkenal dari Palembang?', 'Songket', 'Batik', 'Tenun Ikat', 'Ulos', 'A'),
(97, 'Seni dan Budaya', 'Siapa pelukis terkenal Indonesia yang melukis \"Self-Portrait\"?', 'Affandi', 'Raden Saleh', 'Basuki Abdullah', 'S. Sudjojono', 'A'),
(98, 'Seni dan Budaya', 'Pernikahan adat apa yang menggunakan upacara Siraman?', 'Jawa', 'Minang', 'Bugis', 'Batak', 'A'),
(99, 'Seni dan Budaya', 'Apa nama seni ukir kayu khas Jepara?', 'Ukiran Bali', 'Ukiran Jepara', 'Ukiran Aceh', 'Ukiran Minang', 'B'),
(100, 'Seni dan Budaya', 'Teater tradisional yang menggunakan topeng adalah?', 'Ludruk', 'Lenong', 'Topeng', 'Ketoprak', 'C'),
(101, 'Seni dan Budaya', 'Rumah adat Betawi disebut?', 'Joglo', 'Rumah Kebaya', 'Rumah Gadang', 'Tongkonan', 'B'),
(102, 'Seni dan Budaya', 'Apa nama festival budaya tahunan di Solo?', 'Festival Danau Toba', 'Festival Lembah Baliem', 'Festival Keraton Solo', 'Festival Danau Sentani', 'C'),
(103, 'Geografi', 'Ibu kota negara Australia adalah?', 'Sydney', 'Canberra', 'Melbourne', 'Perth', 'B'),
(104, 'Geografi', 'Gunung tertinggi di Eropa adalah?', 'Mont Blanc', 'Matterhorn', 'Elbrus', 'Alps', 'C'),
(105, 'Geografi', 'Sungai terpanjang di Amerika Selatan adalah?', 'Amazon', 'Parana', 'Orinoco', 'Negro', 'A'),
(106, 'Geografi', 'Negara dengan wilayah terluas di dunia adalah?', 'Kanada', 'Rusia', 'China', 'Amerika Serikat', 'B'),
(107, 'Geografi', 'Samudra terbesar di dunia adalah?', 'Atlantik', 'Pasifik', 'Hindia', 'Arktik', 'B'),
(108, 'Geografi', 'Benua yang tidak memiliki gurun adalah?', 'Eropa', 'Afrika', 'Australia', 'Asia', 'A'),
(109, 'Geografi', 'Ibu kota negara Brasil adalah?', 'Rio de Janeiro', 'Sao Paulo', 'Brasilia', 'Salvador', 'C'),
(110, 'Geografi', 'Pulau terbesar di dunia adalah?', 'Madagaskar', 'Borneo', 'Greenland', 'New Guinea', 'C'),
(111, 'Geografi', 'Negara yang terletak di dua benua adalah?', 'Mesir', 'Turki', 'Rusia', 'Kazakhstan', 'B'),
(112, 'Geografi', 'Danau terbesar di Afrika adalah?', 'Tanganyika', 'Victoria', 'Malawi', 'Turkana', 'B'),
(113, 'Makanan', 'Makanan khas Padang yang terkenal adalah?', 'Rendang', 'Sate', 'Gado-gado', 'Soto', 'A'),
(114, 'Makanan', 'Bahan utama bakso adalah?', 'Daging', 'Tahu', 'Kentang', 'Ikan', 'A'),
(115, 'Makanan', 'Makanan penutup tradisional Indonesia yang terbuat dari ketan adalah?', 'Klepon', 'Lumpia', 'Martabak', 'Pempek', 'A'),
(116, 'Makanan', 'Kuliner apa yang terkenal dari Bandung?', 'Nasi Goreng', 'Batagor', 'Sate Padang', 'Rawon', 'B'),
(117, 'Makanan', 'Bumbu utama rendang adalah?', 'Kunyit', 'Kemiri', 'Kelapa', 'Kuning', 'C'),
(118, 'Makanan', 'Makanan apa yang identik dengan kota Makassar?', 'Coto Makassar', 'Soto Betawi', 'Pecel', 'Sop Buntut', 'A'),
(119, 'Makanan', 'Minuman tradisional yang terbuat dari beras ketan adalah?', 'Wedang Jahe', 'Bajigur', 'Wedang Ronde', 'Brem', 'D'),
(120, 'Makanan', 'Makanan apa yang menggunakan bumbu kecap manis sebagai ciri khas?', 'Semur', 'Rawon', 'Sayur Asem', 'Gulai', 'A'),
(121, 'Makanan', 'Kue tradisional yang berbentuk bulat dan berisi vla adalah?', 'Kue Lumpur', 'Pastel', 'Kue Sus', 'Kue Cubit', 'C'),
(122, 'Makanan', 'Makanan khas Betawi yang terbuat dari ketan dan parutan kelapa adalah?', 'Kerak Telor', 'Ketupat', 'Lontong', 'Nasi Uduk', 'A'),
(123, 'Wisata', 'Destinasi wisata terkenal di Yogyakarta adalah?', 'Borobudur', 'Prambanan', 'Pantai Parangtritis', 'Kawah Ijen', 'B'),
(124, 'Wisata', 'Gunung berapi aktif yang menjadi destinasi wisata di Jawa Timur adalah?', 'Merapi', 'Bromo', 'Semeru', 'Rinjani', 'B'),
(125, 'Wisata', 'Danau Toba terletak di provinsi?', 'Sumatera Utara', 'Sumatera Barat', 'Riau', 'Jambi', 'A'),
(126, 'Wisata', 'Candi terbesar di Asia Tenggara adalah?', 'Borobudur', 'Angkor Wat', 'My Son', 'Prasat Hin Phimai', 'A'),
(127, 'Wisata', 'Pantai Kuta terletak di pulau?', 'Bali', 'Lombok', 'Sumatra', 'Java', 'A'),
(128, 'Wisata', 'Taman Nasional yang terkenal dengan orangutan adalah?', 'Bali Barat', 'Gunung Leuser', 'Kerinci Seblat', 'Ujung Kulon', 'B'),
(129, 'Wisata', 'Air Terjun tertinggi di Indonesia adalah?', 'Air Terjun Gitgit', 'Air Terjun Sipiso-piso', 'Air Terjun Madakaripura', 'Air Terjun Tumpak Sewu', 'B'),
(130, 'Wisata', 'Pulau Komodo termasuk dalam Taman Nasional?', 'Bali', 'Flores', 'Sumba', 'Raja Ampat', 'B'),
(131, 'Wisata', 'Destinasi wisata bawah laut terkenal di Indonesia adalah?', 'Bunaken', 'Derawan', 'Wakatobi', 'Raja Ampat', 'D'),
(132, 'Wisata', 'Candi Hindu terbesar di dunia terletak di?', 'Kamboja', 'Thailand', 'Indonesia', 'Vietnam', 'A');

-- --------------------------------------------------------

--
-- Struktur dari tabel `scores`
--

CREATE TABLE `scores` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `score` int NOT NULL,
  `category` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `scores`
--

INSERT INTO `scores` (`id`, `user_id`, `username`, `score`, `category`, `created_at`) VALUES
(5, 1, 'radit', 50, 'Film', '2025-04-08 10:09:13'),
(6, 2, 'jono', 10, 'Film', '2025-04-08 10:09:47'),
(7, 1, 'radit', 60, 'Film', '2025-04-08 11:00:03'),
(8, 1, 'radit', 70, 'Game', '2025-04-08 11:00:28'),
(9, 1, 'radit', 50, 'Pengetahuan Umum', '2025-04-08 11:01:01'),
(10, 1, 'radit', 40, 'Pengetahuan Umum', '2025-04-08 11:01:21'),
(11, 4, 'messi', 30, 'Game', '2025-04-08 11:04:02'),
(12, 1, 'radit', 30, 'Film', '2025-04-08 12:22:26'),
(14, 1, 'radit', 50, 'Musik', '2025-04-08 12:24:23'),
(15, 1, 'radit', 50, 'Pengetahuan Umum', '2025-04-08 12:30:08'),
(16, 1, 'radit', 90, 'Pengetahuan Umum', '2025-04-08 12:45:47'),
(17, 1, 'radit', 90, 'Game', '2025-04-08 12:47:51'),
(18, 1, 'radit', 30, 'Pengetahuan Umum', '2025-04-08 12:52:34'),
(19, 1, 'radit', 50, 'Game', '2025-04-08 12:52:55'),
(20, 1, 'radit', 60, 'Film', '2025-04-08 13:02:00'),
(21, 1, 'radit', 70, 'Musik', '2025-04-08 13:02:50'),
(22, 5, 'dodo', 60, 'Pengetahuan Umum', '2025-04-08 13:04:18'),
(23, 1, 'radit', 20, 'Pengetahuan Umum', '2025-04-08 13:14:38'),
(24, 1, 'radit', 70, 'Film', '2025-04-08 13:14:55'),
(25, 1, 'radit', 30, 'Film', '2025-04-08 13:17:18'),
(26, 1, 'radit', 60, 'Film', '2025-04-08 13:25:09'),
(29, 1, 'radit', 30, 'Film', '2025-04-09 09:41:13'),
(30, 1, 'radit', 80, 'Musik', '2025-04-09 10:16:55'),
(31, 4, 'messi', 80, 'Musik', '2025-04-11 01:21:12'),
(32, 4, 'messi', 50, 'Film', '2025-04-11 01:22:27'),
(33, 4, 'messi', 60, 'Film', '2025-04-11 01:23:04'),
(34, 4, 'messi', 60, 'Game', '2025-04-11 01:24:33'),
(35, 4, 'messi', 80, 'Musik', '2025-04-11 01:25:07'),
(36, 1, 'radit', 80, 'Musik', '2025-04-11 02:17:07'),
(37, 1, 'radit', 50, 'Musik', '2025-04-11 02:26:16'),
(38, 7, 'mila', 70, 'Musik', '2025-04-11 02:28:49'),
(39, 7, 'mila', 90, 'Pengetahuan Umum', '2025-04-11 02:30:40'),
(40, 7, 'mila', 100, 'Pengetahuan Umum', '2025-04-11 02:32:08'),
(41, 8, 'zaki', 50, 'Musik', '2025-04-11 02:46:12'),
(42, 9, 'tito', 80, 'Musik', '2025-04-11 02:56:13'),
(43, 9, 'tito', 90, 'Pengetahuan Umum', '2025-04-11 02:56:45'),
(44, 9, 'tito', 40, 'Film', '2025-04-11 02:57:42'),
(45, 10, 'Meng Meng', 50, 'Musik', '2025-04-11 03:04:07'),
(46, 10, 'Meng Meng', 100, 'Pengetahuan Umum', '2025-04-11 03:06:21'),
(47, 12, 'xnxx', 60, 'Musik', '2025-04-11 03:11:20'),
(48, 13, 'vika', 10, 'Musik', '2025-04-28 03:52:28'),
(49, 1, 'radit', 20, 'Musik', '2025-05-09 06:34:28'),
(50, 1, 'radit', 100, 'Film', '2025-05-09 06:36:27'),
(51, 1, 'radit', 30, 'Musik', '2025-05-09 06:38:52'),
(52, 1, 'radit', 60, 'Pengetahuan Umum', '2025-05-09 06:53:08'),
(56, 2, 'jono', 70, 'Pengetahuan Umum', '2025-05-09 07:58:44'),
(57, 2, 'jono', 50, 'Pengetahuan Umum', '2025-05-09 07:59:52'),
(58, 2, 'jono', 100, 'Pengetahuan Umum', '2025-05-09 08:00:29'),
(59, 2, 'jono', 70, 'Game', '2025-05-09 08:01:50'),
(62, 1, 'raditya', 20, 'Matematika', '2025-05-16 06:30:37'),
(63, 1, 'raditya', 40, 'Sains', '2025-05-16 06:31:46'),
(64, 1, 'raditya', 70, 'Matematika', '2025-05-16 06:33:05'),
(65, 1, 'raditya', 50, 'Matematika', '2025-05-16 06:38:13'),
(66, 1, 'raditya', 10, 'Matematika', '2025-05-16 06:43:04'),
(67, 1, 'raditya', 50, 'Matematika', '2025-05-16 06:44:14'),
(68, 1, 'raditya', 70, 'Seni dan Budaya', '2025-05-16 06:45:32'),
(69, 1, 'raditya', 100, 'Seni dan Budaya', '2025-05-16 06:47:08'),
(70, 1, 'raditya', 80, 'Matematika', '2025-05-16 06:48:41'),
(71, 1, 'raditya', 10, 'Geografi', '2025-05-16 06:50:53'),
(72, 1, 'raditya', 60, 'Geografi', '2025-05-16 06:51:53'),
(73, 1, 'raditya', 60, 'Geografi', '2025-05-16 06:52:35'),
(74, 1, 'raditya', 90, 'Geografi', '2025-05-16 06:53:28'),
(75, 2, 'jono', 80, 'Makanan', '2025-05-16 07:01:52'),
(76, 2, 'jono', 90, 'Makanan', '2025-05-16 07:02:39'),
(77, 2, 'jono', 60, 'Makanan', '2025-05-16 07:03:36'),
(78, 2, 'jono', 100, 'Makanan', '2025-05-16 07:04:29'),
(79, 2, 'jono', 40, 'Wisata', '2025-05-16 07:05:22'),
(80, 2, 'jono', 30, 'Wisata', '2025-05-16 07:06:29'),
(81, 2, 'jono', 90, 'Wisata', '2025-05-16 07:07:32'),
(82, 2, 'jono', 100, 'Wisata', '2025-05-16 07:08:21'),
(83, 2, 'jono', 80, 'Matematika', '2025-05-16 07:09:29'),
(84, 2, 'jono', 60, 'Sains', '2025-05-16 07:10:40'),
(85, 2, 'jono', 90, 'Sains', '2025-05-16 07:11:18'),
(86, 19, 'kucrit123', 10, 'Musik', '2025-05-19 12:53:32'),
(87, 19, 'kucrit123', 70, 'Pengetahuan Umum', '2025-05-19 12:54:57'),
(88, 19, 'kucrit123', 70, 'Seni dan Budaya', '2025-05-19 12:56:29'),
(89, 20, 'zaky', 10, 'Musik', '2025-05-21 10:09:34'),
(90, 20, 'zaky', 10, 'Film', '2025-05-21 10:11:15'),
(91, 21, 'jors', 10, 'Musik', '2025-05-23 06:42:16'),
(92, 21, 'jors', 50, 'Musik', '2025-05-23 06:43:16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`) VALUES
(1, 'raditya', '$2y$10$Plhp4sShQGGL6DhrfQkY6el4JGdMVC1CSUYZcKuAssskeigF1Qy8C', 'raditya@gmail.com'),
(2, 'jono', '$2y$10$A8w82NlJws1HZlLb3lJw5ulFhvUVFOhdB9umnFzCkAJ1fjvBfP4Km', 'jono@gmail.com'),
(4, 'messi', '$2y$10$K6OCcgw4/hzvuU4XsOm87em/NYAQhbrS3CHaJYmIZEjdXK.ii0OS2', 'messi@gmail.com'),
(5, 'dodo', '$2y$10$/fVIvQMg1N3sbnWgIDxi7O3GVML1adHqoIhMEfcKUdRe1WFwDWHwK', 'dodo@gmail.com'),
(7, 'mila', '$2y$10$MJh88gmn/y9M.ZvT.LbpSuCqGz6MmiJqImJ1kRpijYRVl6qz8IZm2', 'mila'),
(8, 'zaki', '$2y$10$lcaZvlohZJT8ZwERC9LtSuBtrO1JPa6sWLLlhVHfwMGAfKL9ot5dq', 'zaki@gmail.com'),
(9, 'tito', '$2y$10$bQCBm5sbccpkmnob71CAEeqyS/ewHp4BBtMYHESt260e5kYABjhWG', 'tito@gmail.com'),
(10, 'Meng Meng', '$2y$10$ze3YRyCtsXRuY6DIJ0gh/OdTWXrgIF6yqLfC1QygDnF.H.wnHTIp6', 'asdfggdd@gmail.com'),
(13, 'vika', '$2y$10$5X2eDMx5HqDw2IJVsx9YOOq3n5xHSg7Y1DAUPe9l6uMzsB5CoZbTi', 'vika@gmail.com'),
(14, 'sayu', '$2y$10$nC.HnAU992n5QP6YWkVfxelrMeu4w/opn5RNyl7oo/Fn3a4buJ0sm', 'sayu@gmail.com'),
(16, 'farid', '$2y$10$j/F.FkW1XdiISE6V.s3JHutsA/.IfgJyCFhv4n8IyS9bc/zsD5eK.', 'farid@gmail.com'),
(18, 'kucrit', '$2y$10$1nTkIwHmc0qlxxYgnNFT0ea7UCqzMpa8l/OCG3jHwHx0lcNBZgU9y', 'kucritcrut@gmail.com'),
(19, 'kucrit123', '$2y$10$dSrvfa85Q2dgyN1JwmEWT.jYUC3xcU//WYrtUW4nvhuhnP1MqYBca', 'kucrit@gmail.com'),
(20, 'zaky', '$2y$10$t577RbscVk7gSCcPtuS8teNbj/caHbXnj7QTaDqYWkpU.EgQk95Qa', 'zaky@gmail.com'),
(21, 'jors', '$2y$10$kSYW1jY5U3SJczZUab2VdezFS6PkhxSNWpS5Y3WafKVci6hVd00h.', 'jors@gmail.com'),
(22, 'adit', '$2y$10$RAqnQsncNr.Nf/yuzw7XaOAI2Wpojb6eZf5uRWN84lZlAE9uYqg9S', 'adit@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT untuk tabel `scores`
--
ALTER TABLE `scores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
