-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Oct 11, 2026 at 03:56 PM
-- Server version: 8.0.40
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `event_ticketing_db`
--
CREATE DATABASE IF NOT EXISTS `event_ticketing_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `event_ticketing_db`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `payments`;
DROP TABLE IF EXISTS `bookings`;
DROP TABLE IF EXISTS `events`;
DROP TABLE IF EXISTS `venues`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `users`;
SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int NOT NULL,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `quantity` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `booking_status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ticket_code` varchar(100) DEFAULT NULL
) ;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `event_id`, `quantity`, `total_amount`, `booking_status`, `booking_date`, `ticket_code`) VALUES
(1, 4, 1, 2, 240.00, 'confirmed', '2026-10-11 15:37:14', 'TKT001'),
(2, 5, 2, 1, 80.00, 'confirmed', '2026-10-11 15:37:14', 'TKT002'),
(3, 4, 3, 3, 150.00, 'confirmed', '2026-10-11 15:37:14', 'TKT003'),
(4, 5, 4, 1, 35.00, 'confirmed', '2026-10-11 15:37:14', 'TKT004'),
(5, 4, 5, 2, 200.00, 'cancelled', '2026-10-11 15:37:14', 'TKT005');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Music', 'Concerts and live performances'),
(2, 'Technology', 'Technology conferences and events'),
(3, 'Sports', 'Sports events and competitions'),
(4, 'Education', 'Workshops and educational programmes'),
(5, 'Business', 'Business conferences and networking');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `organiser_id` int NOT NULL,
  `venue_id` int NOT NULL,
  `category_id` int NOT NULL,
  `event_name` varchar(150) NOT NULL,
  `description` text,
  `event_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `ticket_price` decimal(10,2) NOT NULL,
  `total_tickets` int NOT NULL,
  `available_tickets` int NOT NULL,
  `event_status` enum('draft','published','cancelled','completed') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `organiser_id`, `venue_id`, `category_id`, `event_name`, `description`, `event_date`, `start_time`, `end_time`, `ticket_price`, `total_tickets`, `available_tickets`, `event_status`, `created_at`) VALUES
(1, 2, 1, 1, 'Malaysia Music Festival', 'Live music festival featuring local artists', '2026-11-15', '18:00:00', '23:00:00', 120.00, 2500, 2498, 'published', '2026-10-11 15:37:14'),
(2, 3, 3, 2, 'Tech Innovation Conference', 'Conference about technology and innovation', '2026-11-20', '09:00:00', '17:00:00', 80.00, 3000, 3000, 'published', '2026-10-11 15:37:14'),
(3, 2, 2, 3, 'National Sports Championship', 'National indoor sports competition', '2026-12-05', '10:00:00', '18:00:00', 50.00, 8000, 7997, 'published', '2026-10-11 15:37:14'),
(4, 3, 4, 4, 'Digital Skills Workshop', 'Workshop on digital and technical skills', '2026-12-12', '09:00:00', '16:00:00', 35.00, 500, 499, 'published', '2026-10-11 15:37:14'),
(5, 2, 1, 5, 'Business Networking Summit', 'Networking event for entrepreneurs', '2027-01-10', '10:00:00', '17:00:00', 100.00, 1500, 1500, 'published', '2026-10-11 15:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `payment_method` enum('online_banking','card','ewallet','cash') NOT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','paid','failed','refunded') NOT NULL DEFAULT 'pending',
  `transaction_reference` varchar(100) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `booking_id`, `payment_method`, `payment_amount`, `payment_status`, `transaction_reference`, `payment_date`) VALUES
(1, 1, 'online_banking', 240.00, 'paid', 'TXN001', '2026-10-11 15:37:14'),
(2, 2, 'card', 80.00, 'paid', 'TXN002', '2026-10-11 15:37:14'),
(3, 3, 'ewallet', 150.00, 'paid', 'TXN003', '2026-10-11 15:37:14'),
(4, 4, 'online_banking', 35.00, 'paid', 'TXN004', '2026-10-11 15:37:14'),
(5, 5, 'card', 200.00, 'refunded', 'TXN005', '2026-10-11 15:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('admin','organiser','customer') NOT NULL DEFAULT 'customer',
  `api_key` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
-- Plaintext Passwords:
-- User 1 (Admin):     Admin@2026
-- User 2 (Organiser): Aina#Org26
-- User 3 (Organiser): Daniel#Org26
-- User 4 (Customer):  Sarah#123
-- User 5 (Customer):  Amir#123
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password_hash`, `phone`, `role`, `api_key`, `created_at`) VALUES
(1, 'Admin EventHub', 'admin@example.com', '$2b$10$8mfo2xLPs5zizAhVBWefUeyydEGMdOtK2Q8/ESshYtxrMfF6VzbZS', '0121111111', 'admin', 'adm_live_key_9876543210abcdef', '2026-10-11 15:37:14'),
(2, 'Aina Rahman', 'aina@example.com', '$2b$10$YvNQcTfo9aU5abhPqYWr3eDwfWLa.ot85ScS0dz8Q3QrLJmYNB4wS', '0122222222', 'organiser', 'org_live_key_abcdef1234567890', '2026-10-11 15:37:14'),
(3, 'Daniel Lee', 'daniel@example.com', '$2b$10$ENF8fHdIs9e0Ymdbsk1lQ.d6NmsyFH.SiZuW1pqWouMHfBGosV.96', '0123333333', 'organiser', 'org_live_key_daniel23456789', '2026-10-11 15:37:14'),
(4, 'Sarah Ahmad', 'sarah@example.com', '$2b$10$h0Cx0EBtEb6MpD3PvmDJFeZ1ndIjeMJ42Y/N.weEQ41GX77UzsJtq', '0124444444', 'customer', 'cus_live_key_aaaabbbbccccdddd', '2026-10-11 15:37:14'),
(5, 'Amir Hakim', 'amir@example.com', '$2b$10$Ut7lYFOmnlkiqAH6zPnO0u4UX9FSPn9UrL4xmXqtHw7GcnBo/hRI2', '0125555555', 'customer', 'cus_live_key_amir1122334455', '2026-10-11 15:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `venue_id` int NOT NULL,
  `venue_name` varchar(150) NOT NULL,
  `location` varchar(255) NOT NULL,
  `capacity` int NOT NULL,
  `description` text,
  `approval_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending'
) ;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`venue_id`, `venue_name`, `location`, `capacity`, `description`, `approval_status`) VALUES
(1, 'KL Convention Centre', 'Kuala Lumpur', 3000, 'Convention and exhibition venue', 'approved'),
(2, 'Axiata Arena', 'Bukit Jalil', 12000, 'Indoor sports and entertainment arena', 'approved'),
(3, 'MITEC', 'Kuala Lumpur', 5000, 'Exhibition and conference centre', 'approved'),
(4, 'Dewan Merdeka', 'Kuala Lumpur', 2000, 'Multipurpose event hall', 'approved'),
(5, 'Sunway Convention Centre', 'Selangor', 3500, 'Convention and corporate event venue', 'pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD UNIQUE KEY `ticket_code` (`ticket_code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `organiser_id` (`organiser_id`),
  ADD KEY `venue_id` (`venue_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `transaction_reference` (`transaction_reference`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `api_key` (`api_key`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`venue_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `venue_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`organiser_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `events_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
