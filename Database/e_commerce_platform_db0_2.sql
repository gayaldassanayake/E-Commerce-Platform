-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2019 at 05:20 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_commerce_platform_db0.2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `error_procedure` (`pval` INT)  BEGIN
  IF pval = 0 THEN
    SIGNAL SQLSTATE '23513'
    SET MESSAGE_TEXT = 'Violation of attribute size constraint';
  ELSEIF pval = 1 THEN
    SIGNAL SQLSTATE '23513'
    SET MESSAGE_TEXT = 'Violation of attribute range constraint';
  ELSEIF pval = 2 THEN
    SIGNAL SQLSTATE '23513'
    SET MESSAGE_TEXT = 'Invalid value for an attribute';
  ELSE
    SIGNAL SQLSTATE '45000';
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `admin_id` char(5) NOT NULL,
  `name` varchar(200) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` char(6) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `super_category_id` char(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category_specialized_attribute`
--

CREATE TABLE `category_specialized_attribute` (
  `attribute_id` char(6) NOT NULL,
  `attribute` varchar(50) NOT NULL,
  `category_id` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `credit_card_detail`
--

CREATE TABLE `credit_card_detail` (
  `customer_id` char(7) NOT NULL,
  `credit_card_number` char(16) NOT NULL,
  `cvv` char(3) DEFAULT NULL,
  `expire_year` decimal(4,0) DEFAULT NULL,
  `expire_month` decimal(2,0) DEFAULT NULL,
  `name_on_card` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `credit_card_detail`
--
DELIMITER $$
CREATE TRIGGER `credit_card_validation_on_insert` BEFORE INSERT ON `credit_card_detail` FOR EACH ROW IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `credit_card_validation_on_update` BEFORE UPDATE ON `credit_card_detail` FOR EACH ROW IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` char(7) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer_telephone`
--

CREATE TABLE `customer_telephone` (
  `customer_id` char(7) NOT NULL,
  `telephone_number` char(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `custom_attribute`
--

CREATE TABLE `custom_attribute` (
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `attribute_name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_detail`
--

CREATE TABLE `delivery_detail` (
  `order_id` char(7) NOT NULL,
  `delivery_person_id` char(5) NOT NULL,
  `address` varchar(255) NOT NULL,
  `estimate_days` decimal(2,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `delivery_detail`
--
DELIMITER $$
CREATE TRIGGER `delivery_detail_validation_on_insert` BEFORE INSERT ON `delivery_detail` FOR EACH ROW IF NEW.estimate_days <0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delivery_detail_validation_on_update` BEFORE UPDATE ON `delivery_detail` FOR EACH ROW IF NEW.estimate_days <0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_person`
--

CREATE TABLE `delivery_person` (
  `delivery_person_id` char(5) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `order_id` char(7) NOT NULL,
  `state` char(30) DEFAULT NULL,
  `delivery_method` char(20) DEFAULT NULL,
  `payment_method` char(25) DEFAULT NULL,
  `credit_card_number` char(16) DEFAULT NULL,
  `cvv` char(3) DEFAULT NULL,
  `expire_year` decimal(4,0) DEFAULT NULL,
  `expire_month` decimal(2,0) DEFAULT NULL,
  `name_on_card` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `order`
--
DELIMITER $$
CREATE TRIGGER `order_validation_on_insert` BEFORE INSERT ON `order` FOR EACH ROW IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    ELSEIF NEW.state not in (
            'Pending',
            'Deliverying',
            'Delivered',
            'Waiting for Customer'
        ) THEN
        CALL error_procedure(2);
    ELSEIF NEW.delivery_method not in ('Store Pickup', 'Delivered') THEN
        CALL error_procedure(2);
    ELSEIF NEW.payment_method not in ('Credit Card', 'Cash on Delivery') THEN
        CALL error_procedure(2);
        END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `order_validation_on_update` BEFORE UPDATE ON `order` FOR EACH ROW IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    ELSEIF NEW.state not in (
            'Pending',
            'Deliverying',
            'Delivered',
            'Waiting for Customer'
        ) THEN
        CALL error_procedure(2);
    ELSEIF NEW.delivery_method not in ('Store Pickup', 'Delivered') THEN
        CALL error_procedure(2);
    ELSEIF NEW.payment_method not in ('Credit Card', 'Cash on Delivery') THEN
        CALL error_procedure(2);
        END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` char(6) NOT NULL,
  `title` varchar(100) NOT NULL,
  `manufacturer` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `product_id` char(6) NOT NULL,
  `category_id` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product_category_specialized_attribute`
--

CREATE TABLE `product_category_specialized_attribute` (
  `product_id` char(6) NOT NULL,
  `attribute_id` char(6) NOT NULL,
  `category_id` char(6) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart_item`
--

CREATE TABLE `shopping_cart_item` (
  `customer_id` char(7) NOT NULL,
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `shopping_cart_item`
--
DELIMITER $$
CREATE TRIGGER `shopping_cart_item_validation_on_insert` BEFORE INSERT ON `shopping_cart_item` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `shopping_cart_item_validation_on_update` BEFORE UPDATE ON `shopping_cart_item` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `varient`
--

CREATE TABLE `varient` (
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `sku` char(10) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `weight` decimal(6,2) DEFAULT NULL,
  `restock_limit` int(11) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `varient`
--
DELIMITER $$
CREATE TRIGGER `varient_validation_on_insert` BEFORE INSERT ON `varient` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.weight <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.restock_limit THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `varient_validation_on_update` BEFORE UPDATE ON `varient` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.weight <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.restock_limit THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `varient_item`
--

CREATE TABLE `varient_item` (
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `serial_number` char(10) NOT NULL,
  `order_id` char(7) DEFAULT NULL,
  `availability` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `super_category_id` (`super_category_id`);

--
-- Indexes for table `category_specialized_attribute`
--
ALTER TABLE `category_specialized_attribute`
  ADD PRIMARY KEY (`attribute_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `credit_card_detail`
--
ALTER TABLE `credit_card_detail`
  ADD PRIMARY KEY (`customer_id`,`credit_card_number`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `customer_telephone`
--
ALTER TABLE `customer_telephone`
  ADD PRIMARY KEY (`customer_id`,`telephone_number`);

--
-- Indexes for table `custom_attribute`
--
ALTER TABLE `custom_attribute`
  ADD PRIMARY KEY (`attribute_name`,`product_id`,`varient_id`),
  ADD KEY `product_id` (`product_id`,`varient_id`);

--
-- Indexes for table `delivery_detail`
--
ALTER TABLE `delivery_detail`
  ADD PRIMARY KEY (`order_id`,`delivery_person_id`),
  ADD KEY `delivery_person_id` (`delivery_person_id`);

--
-- Indexes for table `delivery_person`
--
ALTER TABLE `delivery_person`
  ADD PRIMARY KEY (`delivery_person_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_category_specialized_attribute`
--
ALTER TABLE `product_category_specialized_attribute`
  ADD PRIMARY KEY (`product_id`,`attribute_id`,`category_id`),
  ADD KEY `attribute_id` (`attribute_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  ADD PRIMARY KEY (`customer_id`,`product_id`,`varient_id`),
  ADD KEY `product_id` (`product_id`,`varient_id`);

--
-- Indexes for table `varient`
--
ALTER TABLE `varient`
  ADD PRIMARY KEY (`product_id`,`varient_id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indexes for table `varient_item`
--
ALTER TABLE `varient_item`
  ADD PRIMARY KEY (`product_id`,`varient_id`,`serial_number`),
  ADD KEY `order_id` (`order_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`super_category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `category_specialized_attribute`
--
ALTER TABLE `category_specialized_attribute`
  ADD CONSTRAINT `category_specialized_attribute_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `credit_card_detail`
--
ALTER TABLE `credit_card_detail`
  ADD CONSTRAINT `credit_card_detail_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_telephone`
--
ALTER TABLE `customer_telephone`
  ADD CONSTRAINT `customer_telephone_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `custom_attribute`
--
ALTER TABLE `custom_attribute`
  ADD CONSTRAINT `custom_attribute_ibfk_1` FOREIGN KEY (`product_id`,`varient_id`) REFERENCES `varient` (`product_id`, `varient_id`) ON UPDATE CASCADE;

--
-- Constraints for table `delivery_detail`
--
ALTER TABLE `delivery_detail`
  ADD CONSTRAINT `delivery_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `delivery_detail_ibfk_2` FOREIGN KEY (`delivery_person_id`) REFERENCES `delivery_person` (`delivery_person_id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `product_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_category_specialized_attribute`
--
ALTER TABLE `product_category_specialized_attribute`
  ADD CONSTRAINT `product_category_specialized_attribute_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `product_category_specialized_attribute_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `category_specialized_attribute` (`attribute_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `product_category_specialized_attribute_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  ADD CONSTRAINT `shopping_cart_item_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `shopping_cart_item_ibfk_2` FOREIGN KEY (`product_id`,`varient_id`) REFERENCES `varient` (`product_id`, `varient_id`) ON UPDATE CASCADE;

--
-- Constraints for table `varient`
--
ALTER TABLE `varient`
  ADD CONSTRAINT `varient_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `varient_item`
--
ALTER TABLE `varient_item`
  ADD CONSTRAINT `varient_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `varient_item_ibfk_2` FOREIGN KEY (`product_id`,`varient_id`) REFERENCES `varient` (`product_id`, `varient_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
