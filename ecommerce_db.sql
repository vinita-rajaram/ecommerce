-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 20, 2025 at 11:33 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `password`) VALUES
(1, 'admin@example.com', '$2b$10$14sXHJq9daAX7saUeBMo7O8to9KIcyxQgd7.pk6K75eVzqPbR0cv.');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(4, 'ganesh', 'ganesh@gmail.com', '4545454545', '2025-03-12 18:06:35', '2025-03-12 18:06:35'),
(5, 'kamal', 'kamal@gmail.com', 'kamal123', '2025-03-13 11:31:09', '2025-03-13 11:31:09'),
(7, 'Kadal selvam', 'kadalselvam6@gmail.com', '12345', '2025-03-14 09:44:12', '2025-03-14 09:44:12'),
(8, 'ganga', 'ganga@gmail.com', 'ganga123', '2025-03-14 12:37:16', '2025-03-14 12:37:16'),
(9, 'rajesh', 'rajesh@gmail.com', 'rajesh123', '2025-03-15 04:24:43', '2025-03-15 04:24:43'),
(11, 'suresh', 'suresh@gmail.com', '12345', '2025-03-15 07:13:36', '2025-03-15 07:13:36'),
(12, 'priya', 'priya@gmail.com', 'priya123', '2025-03-20 08:44:21', '2025-03-20 08:44:21'),
(20, 'vimal', 'vimal@gmail.com', '$2b$10$1bXRyrkGaOn1cT1VwYgPOeR4QxtYniX1S58iqNZQQeNUAZXO3ghui', '2025-03-20 09:26:12', '2025-03-20 09:26:12');

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `cardholder_name` varchar(255) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_status` varchar(50) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`id`, `order_id`, `total_amount`, `cardholder_name`, `payment_method`, `payment_status`, `transaction_id`, `created_at`, `updated_at`) VALUES
(1, 97288, '19999.00', 'saravanan', 'Card', 'Success', 'TXN1741803179959', '2025-03-12 18:12:59', '2025-03-12 18:12:59'),
(2, 176271, '19999.00', 'kadal', 'Card', 'Success', 'TXN1741945479546', '2025-03-14 09:44:39', '2025-03-14 09:44:39'),
(3, 490758, '299.00', 'saravanan', 'Card', 'Success', 'TXN1741956002155', '2025-03-14 12:40:02', '2025-03-14 12:40:02'),
(4, 668542, '19999.00', 'kishore', 'Card', 'Success', 'TXN1742385241473', '2025-03-19 11:54:01', '2025-03-19 11:54:01'),
(5, 403521, '299.00', 'vimal', 'Card', 'Success', 'TXN1742462832921', '2025-03-20 09:27:12', '2025-03-20 09:27:12');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `image`) VALUES
(8, 'boAt Bassheads', '400.00', '/uploads/1741779926673.webp'),
(10, 'JBL Flip 5 Wireless', '599.00', '/uploads/1741781783966.webp'),
(11, 'boAt Airdopes', '488.00', '/uploads/1741781825014.jpg'),
(15, 'HP Laptop 15s', '19999.00', '/uploads/1741781925972.jpg'),
(16, 'Astigo Remote', '299.00', '/uploads/1741782133801.webp'),
(17, 'Galaxy', '8000.00', '/uploads/1741782163833.webp'),
(18, 'asus-laptop', '40999.00', '/uploads/1741782202305.webp'),
(19, 'Lenovo IdeaPad', '28888.00', '/uploads/1741782251728.jpg'),
(20, 'real Me', '22999.00', '/uploads/1741782855066.webp'),
(21, 'boAt Bassheads', '450.00', '/uploads/1741945409296.jpg'),
(23, 'realme', '7800.00', '/uploads/1742022712786.webp'),
(24, 'JBL Flip 5 Wireless', '399.00', '/uploads/1742460940878.webp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `payment_details`
--
ALTER TABLE `payment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
