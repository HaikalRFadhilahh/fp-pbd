-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 19, 2023 at 01:31 PM
-- Server version: 8.0.33-0ubuntu0.22.04.2
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fp-pbd`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `display_jadwal` ()   BEGIN
    -- Variabel untuk menyimpan hasil perhitungan
    DECLARE jadwal_idCur INT;
    DECLARE id_busCur INT;
    DECLARE hargaCur INT;
    DECLARE done int DEFAULT 0;
    
    -- Deklarasi Cursor untuk mengambil data produk
    DECLARE jadwal_cursor CURSOR FOR
        SELECT id, id_bus, harga
        FROM jadwal;
    
    -- Handle ketika tidak ada data di Cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND set done =1;

    -- Buka Cursor
    OPEN jadwal_cursor;

    -- Loop untuk mengambil dan menampilkan data produk
    read_loop: LOOP
        FETCH jadwal_cursor INTO jadwal_idCur, id_busCur, hargaCur;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Tampilkan informasi produk
        SELECT CONCAT('Id Jadwal: ', jadwal_idCur, ', Id Bus: ', id_busCur, ', Harga: ', hargaCur) AS Jadwal_Info;
    END LOOP;

    -- Tutup Cursor
    CLOSE jadwal_cursor;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitungHargaTicket` (`jarak_tujuan` INT, `harga_per_km` INT) RETURNS BIGINT  BEGIN
	DECLARE total_harga bigint;
    SET total_harga = jarak_tujuan * harga_per_km;
    RETURN total_harga;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bus`
--

CREATE TABLE `bus` (
  `id` int NOT NULL,
  `nama_bus` varchar(255) NOT NULL,
  `id_tipe` int NOT NULL,
  `jumlah_kursi` int NOT NULL,
  `harga_per_km` int NOT NULL,
  `id_kelas` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bus`
--

INSERT INTO `bus` (`id`, `nama_bus`, `id_tipe`, `jumlah_kursi`, `harga_per_km`, `id_kelas`, `created_at`, `updated_at`) VALUES
(1, 'Maju Jaya', 2, 24, 3000, 4, '2023-07-06 22:42:34', '2023-07-06 22:42:34'),
(2, 'Sinar Jaya', 3, 30, 2500, 1, '2023-07-06 22:42:34', '2023-07-06 22:42:34'),
(3, 'Harapan Jaya', 1, 30, 1500, 1, '2023-07-06 22:42:34', '2023-07-06 22:42:34'),
(4, 'Pahala Kencana', 3, 50, 4000, 3, '2023-07-06 22:42:34', '2023-07-06 22:42:34'),
(5, 'Safari Dharma Raya', 5, 15, 1200, 5, '2023-07-06 22:42:34', '2023-07-06 22:42:34');

-- --------------------------------------------------------

--
-- Stand-in structure for view `data_bus`
-- (See below for the actual view)
--
CREATE TABLE `data_bus` (
`id` int
,`nama_bus` varchar(255)
,`jumlah_kursi` int
,`tipe` varchar(255)
,`nama_kelas` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `data_ticket`
-- (See below for the actual view)
--
CREATE TABLE `data_ticket` (
`nama` varchar(255)
,`nama_penumpang` varchar(255)
,`status_pembayaran` varchar(255)
,`tanggal_keberangkatan` datetime
,`tanggal_sampai` datetime
,`harga` int
,`nama_daerah` varchar(100)
,`nama_bus` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id` int NOT NULL,
  `id_tujuan` int NOT NULL,
  `id_bus` int NOT NULL,
  `harga` int DEFAULT NULL,
  `tanggal_keberangkatan` datetime NOT NULL,
  `tanggal_sampai` datetime NOT NULL,
  `status_jadwal` varchar(100) DEFAULT 'dibuka',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`id`, `id_tujuan`, `id_bus`, `harga`, `tanggal_keberangkatan`, `tanggal_sampai`, `status_jadwal`, `created_at`, `updated_at`) VALUES
(6, 5, 4, 500000, '2023-07-15 15:00:00', '2023-07-21 09:00:00', 'dibuka', '2023-07-06 22:53:16', '2023-07-06 22:53:16'),
(7, 2, 5, 350000, '2023-07-08 09:00:00', '2023-07-10 22:00:00', 'ditutup', '2023-07-06 22:53:16', '2023-07-06 22:53:16'),
(8, 1, 1, 150000, '2023-07-16 22:48:05', '2023-07-20 08:00:00', 'dibuka', '2023-07-06 22:53:16', '2023-07-06 22:53:16'),
(9, 3, 3, 80000, '2023-07-13 12:00:00', '2023-07-14 00:00:00', 'ditutup', '2023-07-06 22:53:16', '2023-07-06 22:53:16'),
(10, 3, 2, 760000, '2023-07-25 05:00:00', '2023-07-27 09:00:00', 'dibuka', '2023-07-06 22:53:16', '2023-07-06 22:53:16');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` int NOT NULL,
  `nama_kelas` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `nama_kelas`, `created_at`, `updated_at`) VALUES
(1, 'Ekonomi', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(2, 'Reguler', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(3, 'Express', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(4, 'Shuttle', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(5, 'Eksklusif', '2023-07-06 22:27:05', '2023-07-06 22:27:05');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_jadwal` int NOT NULL,
  `nama_penumpang` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telepon` int NOT NULL,
  `status_pembayaran` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `id_user`, `id_jadwal`, `nama_penumpang`, `email`, `telepon`, `status_pembayaran`, `created_at`, `updated_at`) VALUES
(6, 2, 7, 'Haikal Raditya Fadhilah', 'haikal@gmail.com', 123324, 'pending', '2023-07-06 23:08:19', '2023-07-06 23:08:19'),
(7, 1, 8, 'Kavi Raja', 'kavi@gmail.com', 435436546, 'pending', '2023-07-06 23:08:19', '2023-07-06 23:08:19'),
(8, 3, 8, 'Novanda renaldy', 'renal@gmail.com', 425456, 'lunas', '2023-07-06 23:08:19', '2023-07-06 23:08:19'),
(9, 4, 10, 'Deva Tri Rumanto', 'deva@gmail.com', 455656, 'batal', '2023-07-06 23:08:19', '2023-07-06 23:08:19'),
(10, 5, 7, 'Dahniar', 'niar@gmail.com', 454523, 'lunas', '2023-07-06 23:08:19', '2023-07-06 23:08:19');

-- --------------------------------------------------------

--
-- Table structure for table `tipe_bus`
--

CREATE TABLE `tipe_bus` (
  `id` int NOT NULL,
  `tipe` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tipe_bus`
--

INSERT INTO `tipe_bus` (`id`, `tipe`, `created_at`, `updated_at`) VALUES
(1, 'Normal Deck', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(2, 'High Deck', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(3, 'Ultra High Decker', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(4, 'Super High Decker', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(5, 'High Decker Double Glass', '2023-07-06 22:27:05', '2023-07-06 22:27:05');

-- --------------------------------------------------------

--
-- Table structure for table `tujuan`
--

CREATE TABLE `tujuan` (
  `id` int NOT NULL,
  `nama_daerah` varchar(100) NOT NULL,
  `jarak_tujuan` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tujuan`
--

INSERT INTO `tujuan` (`id`, `nama_daerah`, `jarak_tujuan`, `created_at`, `updated_at`) VALUES
(1, 'Solo', 142, '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(2, 'Semarang', 230, '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(3, 'Jakarta', 1200, '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(4, 'Surabaya', 720, '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(5, 'Bandung', 600, '2023-07-06 22:27:05', '2023-07-06 22:27:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(70) DEFAULT 'user',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Sulthan Asyraf D', 'asyraffff', 'asyraf1234', 'user', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(2, 'Haikal Raditya Fadhilah', 'haikkk', 'haikalfa1234', 'admin', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(3, 'Reza Setiawan', 'rezaaaa', 'rezaif1234', 'admin', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(4, 'Fajar Rizky Yunanto', 'Fajarrrr', 'fajar12345', 'user', '2023-07-06 22:27:05', '2023-07-06 22:27:05'),
(5, 'Gilang Ramadhani', 'gilangg', 'ramsss1234', 'user', '2023-07-06 22:27:05', '2023-07-06 22:27:05');

-- --------------------------------------------------------

--
-- Structure for view `data_bus`
--
DROP TABLE IF EXISTS `data_bus`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `data_bus`  AS SELECT `a`.`id` AS `id`, `a`.`nama_bus` AS `nama_bus`, `a`.`jumlah_kursi` AS `jumlah_kursi`, `b`.`tipe` AS `tipe`, `c`.`nama_kelas` AS `nama_kelas` FROM ((`bus` `a` join `tipe_bus` `b` on((`a`.`id_tipe` = `b`.`id`))) join `kelas` `c` on((`a`.`id_kelas` = `c`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `data_ticket`
--
DROP TABLE IF EXISTS `data_ticket`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `data_ticket`  AS SELECT `a`.`nama` AS `nama`, `b`.`nama_penumpang` AS `nama_penumpang`, `b`.`status_pembayaran` AS `status_pembayaran`, `c`.`tanggal_keberangkatan` AS `tanggal_keberangkatan`, `c`.`tanggal_sampai` AS `tanggal_sampai`, `c`.`harga` AS `harga`, `d`.`nama_daerah` AS `nama_daerah`, `e`.`nama_bus` AS `nama_bus` FROM ((((`users` `a` join `ticket` `b` on((`a`.`id` = `b`.`id_user`))) join `jadwal` `c` on((`b`.`id_jadwal` = `c`.`id`))) join `tujuan` `d` on((`c`.`id_tujuan` = `d`.`id`))) join `bus` `e` on((`c`.`id_bus` = `e`.`id`))) WHERE (`b`.`status_pembayaran` = 'lunas') ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipe` (`id_tipe`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tujuan` (`id_tujuan`),
  ADD KEY `id_bus` (`id_bus`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_jadwal` (`id_jadwal`);

--
-- Indexes for table `tipe_bus`
--
ALTER TABLE `tipe_bus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tujuan`
--
ALTER TABLE `tujuan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `idx_user_name` (`nama` DESC);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bus`
--
ALTER TABLE `bus`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipe_bus`
--
ALTER TABLE `tipe_bus`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tujuan`
--
ALTER TABLE `tujuan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bus`
--
ALTER TABLE `bus`
  ADD CONSTRAINT `bus_ibfk_1` FOREIGN KEY (`id_tipe`) REFERENCES `tipe_bus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bus_ibfk_2` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`id_tujuan`) REFERENCES `tujuan` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`id_bus`) REFERENCES `bus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
