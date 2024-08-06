-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2024 at 02:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `paket`
--

-- --------------------------------------------------------

--
-- Table structure for table `master_level`
--

CREATE TABLE `master_level` (
  `id_level` int(11) NOT NULL,
  `level` enum('Satpam','Pengguna') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `master_level`
--

INSERT INTO `master_level` (`id_level`, `level`) VALUES
(1, 'Satpam'),
(2, 'Pengguna');

-- --------------------------------------------------------

--
-- Table structure for table `penerima_paket`
--

CREATE TABLE `penerima_paket` (
  `id_paket` int(11) NOT NULL,
  `tanggal_kedatangan` datetime NOT NULL DEFAULT current_timestamp(),
  `nama_ekspedisi` varchar(25) NOT NULL,
  `nama_penerima` varchar(50) NOT NULL,
  `nama_pengambil` varchar(50) NOT NULL,
  `no_telp` varchar(18) NOT NULL,
  `tanggal_diambil` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Belum Diterima','Sudah Diterima') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penerima_paket`
--

INSERT INTO `penerima_paket` (`id_paket`, `tanggal_kedatangan`, `nama_ekspedisi`, `nama_penerima`, `nama_pengambil`, `no_telp`, `tanggal_diambil`, `status`) VALUES
(99, '2024-08-01 07:58:00', 'Shopee', 'Galih', 'A', '085600032739', '2024-08-01 07:58:00', 'Sudah Diterima'),
(100, '2024-08-01 08:04:00', 'Shopee', 'Azmita', 'Azmita', '085600032739', '2024-08-02 08:25:00', 'Sudah Diterima'),
(101, '2024-08-01 08:07:00', 'Shopee', 'Galih', '', '085600032739', '2024-08-01 08:07:29', 'Belum Diterima'),
(103, '2024-08-01 08:57:00', 'Tokopedia', 'Hanif', '', '087847550402', '2024-08-01 08:57:17', 'Belum Diterima'),
(105, '2024-08-01 14:50:00', 'JnT', 'Azmita', '', '081215837753', '2024-08-01 14:51:09', 'Belum Diterima'),
(107, '2024-08-02 08:28:00', 'Anteraja', 'Aqilah', '', '081215837753', '2024-08-02 08:29:11', 'Belum Diterima'),
(108, '2024-08-02 08:29:00', 'Shopee Express', 'Mita', '', '081215837753', '2024-08-02 08:30:15', 'Belum Diterima'),
(110, '2024-08-05 14:40:00', 'Tokopedia', 'Usmit', '', '081215837753', '2024-08-05 14:41:02', 'Belum Diterima'),
(111, '2024-08-05 14:58:00', 'AA', 'aa', '', '085600032739', '2024-08-05 14:59:05', 'Belum Diterima'),
(112, '2024-08-05 14:59:00', 'aa', 'aa', '', '085600032739', '2024-08-05 15:00:07', 'Belum Diterima'),
(113, '2024-08-05 15:06:00', 'aa', 'aa', '', '085600032739', '2024-08-05 15:06:51', 'Belum Diterima');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` enum('Satpam','Pengguna') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `username`, `password`, `level`) VALUES
(73, 'Azmita', 'azmita123', 'Pengguna'),
(74, 'Anton', 'anton123', 'Satpam'),
(75, 'Saifani', '123', 'Pengguna'),
(76, '123', '123', 'Pengguna'),
(77, 'Nanto', '123', 'Satpam');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `master_level`
--
ALTER TABLE `master_level`
  ADD PRIMARY KEY (`id_level`);

--
-- Indexes for table `penerima_paket`
--
ALTER TABLE `penerima_paket`
  ADD PRIMARY KEY (`id_paket`),
  ADD UNIQUE KEY `id_paket` (`id_paket`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `master_level`
--
ALTER TABLE `master_level`
  MODIFY `id_level` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `penerima_paket`
--
ALTER TABLE `penerima_paket`
  MODIFY `id_paket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
