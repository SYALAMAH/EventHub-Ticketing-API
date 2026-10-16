-- ============================================================================
-- SWC3633 / SWC4443 Web API Development
-- Event Ticketing and Venue Booking System
-- Data Manipulation Language (DML) Script - Sample Seed Data
-- 5 Records per table matching event_ticketing_db.sql specification
-- ============================================================================

USE `event_ticketing_db`;

-- 1. SEED USERS TABLE
-- Passwords:
-- Admin (user_id 1):     Admin@2026
-- Aina Org (user_id 2):   Aina#Org26
-- Daniel Org (user_id 3): Daniel#Org26
-- Sarah Cus (user_id 4):  Sarah#123
-- Amir Cus (user_id 5):   Amir#123
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password_hash`, `phone`, `role`, `api_key`, `created_at`) VALUES
(1, 'Admin EventHub', 'admin@example.com', '$2b$10$8mfo2xLPs5zizAhVBWefUeyydEGMdOtK2Q8/ESshYtxrMfF6VzbZS', '0121111111', 'admin', 'adm_live_key_9876543210abcdef', '2026-10-11 15:37:14'),
(2, 'Aina Rahman', 'aina@example.com', '$2b$10$YvNQcTfo9aU5abhPqYWr3eDwfWLa.ot85ScS0dz8Q3QrLJmYNB4wS', '0122222222', 'organiser', 'org_live_key_abcdef1234567890', '2026-10-11 15:37:14'),
(3, 'Daniel Lee', 'daniel@example.com', '$2b$10$ENF8fHdIs9e0Ymdbsk1lQ.d6NmsyFH.SiZuW1pqWouMHfBGosV.96', '0123333333', 'organiser', 'org_live_key_daniel23456789', '2026-10-11 15:37:14'),
(4, 'Sarah Ahmad', 'sarah@example.com', '$2b$10$h0Cx0EBtEb6MpD3PvmDJFeZ1ndIjeMJ42Y/N.weEQ41GX77UzsJtq', '0124444444', 'customer', 'cus_live_key_aaaabbbbccccdddd', '2026-10-11 15:37:14'),
(5, 'Amir Hakim', 'amir@example.com', '$2b$10$Ut7lYFOmnlkiqAH6zPnO0u4UX9FSPn9UrL4xmXqtHw7GcnBo/hRI2', '0125555555', 'customer', 'cus_live_key_amir1122334455', '2026-10-11 15:37:14');

-- 2. SEED VENUES TABLE
INSERT INTO `venues` (`venue_id`, `venue_name`, `location`, `capacity`, `description`, `approval_status`) VALUES
(1, 'KL Convention Centre', 'Kuala Lumpur', 3000, 'Convention and exhibition venue', 'approved'),
(2, 'Axiata Arena', 'Bukit Jalil', 12000, 'Indoor sports and entertainment arena', 'approved'),
(3, 'MITEC', 'Kuala Lumpur', 5000, 'Exhibition and conference centre', 'approved'),
(4, 'Dewan Merdeka', 'Kuala Lumpur', 2000, 'Multipurpose event hall', 'approved'),
(5, 'Sunway Convention Centre', 'Selangor', 3500, 'Convention and corporate event venue', 'pending');

-- 3. SEED CATEGORIES TABLE
INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Music', 'Concerts and live performances'),
(2, 'Technology', 'Technology conferences and events'),
(3, 'Sports', 'Sports events and competitions'),
(4, 'Education', 'Workshops and educational programmes'),
(5, 'Business', 'Business conferences and networking');

-- 4. SEED EVENTS TABLE
INSERT INTO `events` (`event_id`, `organiser_id`, `venue_id`, `category_id`, `event_name`, `description`, `event_date`, `start_time`, `end_time`, `ticket_price`, `total_tickets`, `available_tickets`, `event_status`, `created_at`) VALUES
(1, 2, 1, 1, 'Malaysia Music Festival', 'Live music festival featuring local artists', '2026-11-15', '18:00:00', '23:00:00', 120.00, 2500, 2498, 'published', '2026-10-11 15:37:14'),
(2, 3, 3, 2, 'Tech Innovation Conference', 'Conference about technology and innovation', '2026-11-20', '09:00:00', '17:00:00', 80.00, 3000, 3000, 'published', '2026-10-11 15:37:14'),
(3, 2, 2, 3, 'National Sports Championship', 'National indoor sports competition', '2026-12-05', '10:00:00', '18:00:00', 50.00, 8000, 7997, 'published', '2026-10-11 15:37:14'),
(4, 3, 4, 4, 'Digital Skills Workshop', 'Workshop on digital and technical skills', '2026-12-12', '09:00:00', '16:00:00', 35.00, 500, 499, 'published', '2026-10-11 15:37:14'),
(5, 2, 1, 5, 'Business Networking Summit', 'Networking event for entrepreneurs', '2027-01-10', '10:00:00', '17:00:00', 100.00, 1500, 1500, 'published', '2026-10-11 15:37:14');

-- 5. SEED BOOKINGS TABLE
INSERT INTO `bookings` (`booking_id`, `user_id`, `event_id`, `quantity`, `total_amount`, `booking_status`, `booking_date`, `ticket_code`) VALUES
(1, 4, 1, 2, 240.00, 'confirmed', '2026-10-11 15:37:14', 'TKT001'),
(2, 5, 2, 1, 80.00, 'confirmed', '2026-10-11 15:37:14', 'TKT002'),
(3, 4, 3, 3, 150.00, 'confirmed', '2026-10-11 15:37:14', 'TKT003'),
(4, 5, 4, 1, 35.00, 'confirmed', '2026-10-11 15:37:14', 'TKT004'),
(5, 4, 5, 2, 200.00, 'cancelled', '2026-10-11 15:37:14', 'TKT005');

-- 6. SEED PAYMENTS TABLE
INSERT INTO `payments` (`payment_id`, `booking_id`, `payment_method`, `payment_amount`, `payment_status`, `transaction_reference`, `payment_date`) VALUES
(1, 1, 'online_banking', 240.00, 'paid', 'TXN001', '2026-10-11 15:37:14'),
(2, 2, 'card', 80.00, 'paid', 'TXN002', '2026-10-11 15:37:14'),
(3, 3, 'ewallet', 150.00, 'paid', 'TXN003', '2026-10-11 15:37:14'),
(4, 4, 'online_banking', 35.00, 'paid', 'TXN004', '2026-10-11 15:37:14'),
(5, 5, 'card', 200.00, 'refunded', 'TXN005', '2026-10-11 15:37:14');
