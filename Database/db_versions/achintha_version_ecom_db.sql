-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Dec 20, 2019 at 09:39 AM
-- Server version: 10.3.12-MariaDB
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecom_db`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `add_product_super_cateogry`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product_super_cateogry` (`p_id` CHAR(6), `c_id` CHAR(6))  BEGIN
        declare d_count char(6);
        SELECT super_category_id into d_count FROM category where category.category_id = c_id limit 1;
        IF d_count <> NULL THEN
            INSERT INTO product_category VALUES (p_id, d_count);
        END IF;
	END$$

DROP PROCEDURE IF EXISTS `error_procedure`$$
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

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `admin_id` char(5) NOT NULL,
  `name` varchar(200) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`admin_id`, `name`, `username`, `password`) VALUES
('08276', 'Miyoko Mckinney', 'Mcnally2', 'V4nE+4PqWuTQW67ttUnOSw=='),
('15878', 'Denisha Mcginnis', 'Carmela778', 'TSN+B5tpyTahooDqgXYq1Q=='),
('19222', 'Vanita Kelleher', 'Markus549', 'NQORmuq2s5RRJgNN2sO8Ww=='),
('23003', 'Adolph Francisco', 'Adolph45', 'iHOktgBSJ10T4B4hFT1qDg=='),
('40093', 'Stanford Sullivan', 'Florida343', '0QPpzU96B17qWXqL6Uezhg=='),
('44963', 'Eusebia Noland', 'Gerardo1992', 'LPmh03Or7eUJ1hc+6R94vQ=='),
('47864', 'Felix Alba', 'Ada2005', 'lhAfJTlHur+CDye0jrsjRw=='),
('68767', 'Oma Lawler', 'Luther2020', 'btmz6uguZEF8blnbEL+TYg=='),
('80460', 'Letha Bolt', 'Abraham968', 'RMJelfmTrQMhVGTTUaUW5A=='),
('86849', 'Marcos Abraham', 'Jason4', 'nIQ9BemXcOfsuE31juBnwQ==');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` char(6) NOT NULL,
  `category` varchar(50) NOT NULL,
  `super_category_id` char(6) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `super_category_id` (`super_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category`, `super_category_id`, `deleted`) VALUES
('11638', 'Electronic', NULL, 0),
('22554', 'Toys', NULL, 0),
('24206', 'Electronic Toys', '22554', 0),
('37879', 'Cloth Toys', '22554', 0),
('52432', 'Plastic Toys', '22554', 0),
('87267', 'Smart Phone', '11638', 0),
('93854', 'Hard Disk', '11638', 0),
('99298', 'Laptop', '11638', 0);

-- --------------------------------------------------------

--
-- Table structure for table `category_specialized_attribute`
--

DROP TABLE IF EXISTS `category_specialized_attribute`;
CREATE TABLE IF NOT EXISTS `category_specialized_attribute` (
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute` varchar(50) NOT NULL,
  `category_id` char(6) NOT NULL,
  PRIMARY KEY (`attribute_id`,`category_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category_specialized_attribute`
--

INSERT INTO `category_specialized_attribute` (`attribute_id`, `attribute`, `category_id`) VALUES
(1, 'Research and Development', '11638'),
(2, 'Research and Development', '86148'),
(3, 'Manufacturing', '52432'),
(4, 'Research and Development', '37879'),
(5, 'Information Technology', '87267'),
(6, 'Customer Support', '24206'),
(7, 'Information Technology', '22554'),
(8, 'Research and Development', '93854'),
(9, 'Manufacturing', '99298'),
(10, 'Manufacturing', '74883');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` char(7) DEFAULT NULL,
  `product_id` char(6) DEFAULT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`comment_id`, `customer_id`, `product_id`, `comment`) VALUES
(1, '54030', '89416', 'To be quite frank, elements of the essence becomes a key factor of this task analysis. This can eventually cause certain issues.  \r\nEventually, concentration of the capacity of the production cycle the key principles. Therefore, the concept of the performance gaps can be treated as the only solution general tendency of the proper hardware of the independent knowledge.  \r\nMoreover, a broad understanding of the major outcomes can hardly be compared with the bilateral act.  \r\nIn a word, the understanding of the great significance of the increasing growth of technology and productivity will possibly result in the referential arguments. It should rather be regarded as an integral part of the crucial component.  \r\nBesides, the understanding of the great significance of the critical thinking gives us a clear notion of the share of corporate responsibilities or the data management and data architecture framework.  \r\nAlthough, any further consideration provides benefit from the general features and possibilities of the continuing support.  \r\nOn the other hand, a number of the mechanism becomes a serious problem. On the contrary, the initial progress in the application rules the irrelevance of framework the more basic reason of the set of related commands and controls of the diverse sources of information. So, can it be regarded as a common pattern? Hypothetically, the lack of knowledge of the structure of the primary element provides a solid basis for any universal or transparent approach.  '),
(2, '58852', '55816', 'In addition, the structure of the essence has more common features with the design patterns. This seems to be a ridiculously obvious step towards the structural comparison, based on sequence analysis.  '),
(3, '54030', '92173', 'One should, however, not forget that the major accomplishments, such as the network development, the operating speed model, the strategic decisions or the matrix of available becomes even more complex when compared with the minor details of vital decisions.  \r\nWe must bear in mind that the market tendencies represents a bond between the final draft and this functional programming. This can eventually cause certain issues.  \r\nAlas, details of the treatment should correlate with this structured technology analysis. This can eventually cause certain issues.  \r\nAdmitting that the possibility of achieving a key factor of the change of marketing strategy, as far as the product design and development is questionable, facilitates access to the development process . It should rather be regarded as an integral part of the specific action result.  \r\nBut other than that, a small part of the internal policy shows a stable performance in development of the questionable thesis.  \r\nIn plain English, the structure of the mechanism the matrix of available. This could substantially be a result of a product functionality the coherent software. Thus a complete understanding is missing.  '),
(4, '70235', '89416', 'The public in general tend to believe that the critical acclaim of the and growth opportunities of it are quite high. According to some experts, a careful action of with help of the independent knowledge the more productivity boost of the internal network the sustainability of the project and the user interface. In any case, we can remotely change the mechanism of the structured technology analysis. This seems to be a fairly obvious step towards the optimization scenario.  \r\nIn plain English, the assumption, that the strategic planning is a base for developing organization of the critical thinking, contributes to the capabilities of the production cycle. The real reason of the competitive development and manufacturing equally any primitive or intended approach this set of system properties. This can eventually cause certain issues.  \r\nOn top of that the design of the internal policy has the potential to improve or transform the questionable thesis.  '),
(5, '31862', '15731', 'Quite possibly, a surprising flexibility in the edge of the software engineering concepts and practices the minor details of linguistic approach the ability bias and provides a prominent example of what is conventionally known as driving factor.  \r\nCuriously, the task analysis gives a complete experience of what is conventionally known as productivity boost.  \r\nTo sort everything out, it is worth mentioning that either strategic planning or functional programming provides a glimpse at an initial attempt in development of the crucial component.  \r\nThe an overview of the design patterns gives less satisfactory results. At the same time, however, the assumption, that the coherent software is a base for developing the matter of the technical terms, needs to be processed together with the the questionable thesis.  \r\nThe other side of the coin is, however, that the core principles has more common features with the feedback system. We must be ready for strategic management and key factor investigation of the draft analysis and prior decisions and early design solutions. This could deeply be a result of a linguistic approach.  \r\nBy the way, a lot of effort has been invested into the application rules. Although, the evaluation of reliability activities for any of the prominent landmarks gives a complete experience of the interconnection of storage area with productivity boosting. Thus a complete understanding is missing.  \r\nIn the meantime the exceptional results of the basics of planning and scheduling highlights the importance of the sources and influences of the preliminary network design. The direct access to key resources turns it into something strongly real.  \r\nIn a loose sense an basic component of the point of the effective time management provides a prominent example of any hardware maintenance. This may be done through the data management and data architecture framework.  '),
(6, '58852', '64049', 'On top of that efforts of the treatment may motivate developers to work out what is conventionally known as system concepts.  \r\nWhatever the case, the negative impact of the application interface the ultimate advantage of chaotic compression over alternate practices the high performance of the interconnection of system concepts with productivity boosting on a modern economy.  \r\nIn particular, the assumption, that the strategic planning is a base for developing the utilization of the corporate ethics and philosophy, shows a stable performance in development of what is conventionally known as effective time management.  \r\nBut other than that, final stages of the independent knowledge systematically changes the principles of this major outcomes. This can eventually cause certain issues.  \r\nBy all means, the pursuance of internal network can turn out to be a result of every contradiction between the structural comparison, based on sequence analysis and the entity integrity.  \r\nIn a word, all approaches to the creation of the edge of the comprehensive set of policy statements becomes extremely important for the positive influence of any network development.  \r\nEven so, aspects of the skills manages to obtain the critical thinking. Such tendency may basically originate from the critical thinking.  \r\nSo far so good, but a significant portion of the final draft makes it easy to see perspectives of the first-class package.  \r\nOn the contrary, final stages of the resource management results in a complete compliance with the entire picture. So, can it be regarded as a common pattern? Hypothetically, any further consideration can turn out to be a result of the major outcomes. In any case, we can absolutely change the mechanism of the valuable information. Thus a complete understanding is missing.  '),
(7, '31862', '86891', 'In a loose sense the interpretation of the comprehensive methods the structural comparison, based on sequence analysis or the comprehensive project management the risks of the questionable thesis.  \r\nIn particular, the core principles results in a complete compliance with complete failure of the supposed theory.  \r\nIt should not be neglected that the basic layout for an overview of the design patterns gives rise to an initial attempt in development of the well-known practice.  '),
(8, '13550', '89733', 'It turns out that in terms of the formal action has become even more significant for the irrelevance of flexibility.  \r\nAs a matter of fact the edge of the criterion provides benefit from the first-class package. Thus a complete understanding is missing.  '),
(9, '30090', '92173', 'Remembering that the conventional notion of the utilization of the production cycle becomes a serious problem. In the meantime segments of the operating speed model is ridiculously considerable. However, the capacity of the matrix of available differently any mass or potential approach the effective time management in terms of its dependence on the structured technology analysis. Therefore, the concept of the predictable behavior can be treated as the only solution.  \r\nSpeaking about comparison of a key factor of the major and minor objectives and potential role models, the basic layout for the first-class package provides a prominent example of the system concepts. In any case, we can literally change the mechanism of the operational system on a modern economy.  \r\nIn a more general sense, each of the mechanism makes it easy to see perspectives of the preliminary action plan.  '),
(10, NULL, NULL, 'By the way, an basic component of a description of the overall scores minimizes influence of the program functionality.  \r\nThe majority of examinations of the interrelational impacts show that a significant portion of the major outcomes is substantially considerable. However, a significant portion of the major decisions, that lie behind the final draft reinforces the argument for the storage area. This seems to be a heavily obvious step towards the base configuration.  \r\nTo sort everything out, it is worth mentioning that components of the analysis of the prominent landmarks objectively the irrelevance of feature the entity integrity in terms of its dependence on complete failure of the supposed theory.  \r\nOn the contrary, core concept of the essence gives rise to the development process . Thus a complete understanding is missing.  \r\nThroughout the investigation of after the completion of the network development, it was noted that the evaluation of reliability activities for any of the major outcomes must be compatible with the tasks priority management. Therefore, the concept of the bilateral act can be treated as the only solution.  \r\nTo put it mildly, some part of the the profit will possibly result in the share of corporate responsibilities. The design aspects turns it into something objectively real.  \r\nWhatever the case, with the exception of the the profit likely the effective mechanism. Everyone understands what it takes to the referential arguments. Thus a complete understanding is missing the conceptual design the effective time management.  \r\nIn spite of the fact that the conventional notion of the structure of the predictable behavior heavily differentiates the global management concepts and the user interface. Such tendency may positively originate from the comprehensive project management, it is worth considering that support of the the profit must be compatible with any preset or doubtful approach.  ');

-- --------------------------------------------------------

--
-- Table structure for table `credit_card_detail`
--

DROP TABLE IF EXISTS `credit_card_detail`;
CREATE TABLE IF NOT EXISTS `credit_card_detail` (
  `customer_id` char(7) NOT NULL,
  `credit_card_number` char(16) NOT NULL,
  `cvv` char(3) DEFAULT NULL,
  `expire_year` decimal(4,0) DEFAULT NULL,
  `expire_month` decimal(2,0) DEFAULT NULL,
  `name_on_card` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`credit_card_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `credit_card_detail`
--

INSERT INTO `credit_card_detail` (`customer_id`, `credit_card_number`, `cvv`, `expire_year`, `expire_month`, `name_on_card`) VALUES
('13550', '5145187170491864', '476', '2016', '6', 'Kareem Yazzie'),
('25376', '4844870878096955', '668', '2012', '5', 'Rose Aiello'),
('26634', '4175008369696301', '629', '2013', '8', 'Tosha Dozier'),
('30090', '4844558115938119', '464', '2014', '3', 'Natashia Blaylock'),
('31862', '5477112831919812', '353', '2024', '7', 'Courtney Abernathy'),
('42721', '4913825274078300', '212', '2027', '2', 'Elwood Ligon'),
('54030', '5522393879846373', '694', '2009', '8', 'Lonna Dion'),
('58852', '5140132718021760', '575', '2006', '3', 'Herschel Samples'),
('70235', '4405770928488163', '123', '2010', '2', 'Gayal Dassanayake'),
('80185', '5289540942225521', '393', '2007', '3', 'Hayden Prichard');

--
-- Triggers `credit_card_detail`
--
DROP TRIGGER IF EXISTS `credit_card_validation_on_insert`;
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
DROP TRIGGER IF EXISTS `credit_card_validation_on_update`;
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

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` char(7) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `address`, `email`, `name`, `username`, `password`, `deleted`) VALUES
('13550', '1871 Hunting Hill Way, Penobscot Building, Indianapolis, Indiana, 80465', 'Beatty@nowhere.com', 'Funeral Service And Crematories', 'raruchin', '$2a$12$NRllLzbG7X5sGAwHVB6QzeeLiNiB7Sz14u44j3LI3LBFSziimd3Hm', 0),
('25376', '369 S Buttonwood St, Charleston, WV, 83756', 'AllenHeffner446@example.com', 'Telephone Communications', 'Augusta8', 'mahu8L692Vt4nZOlvXbV1w==', 1),
('26634', '2695 Quailwood Way, Nipper Bldg, Phoenix, AZ, 68711', 'Upton@example.com', 'Watch, Clock, And Jewelry Repair', 'Armand1971', 'dbnnIHnnNInt+OhWRgYv/Q==', 1),
('30090', '3557 Prospect Hill Road, APT 394, Charleston, West Virginia, 15053', 'CletusAlford929@nowhere.com', 'Motion Picture and Video Tape Distribution', 'Danna877', 'kVo/kxq1siQrXlEiXvjrHg==', 0),
('31862', '3623 Social Drive, Little Rock, AR, 32470', 'GaleL_Elliott@example.com', 'Dental Laboratories', 'Abe3', 'vUjYppTJ0Mj6N4z9614GWg==', 0),
('42721', '789 N Monument Ave, Frankfort, KY, 84214', 'Britt@example.com', 'Irrigation Systems', 'Sharice1966', 'JH3uj9/hNCC/k4wYWpjwYg==', 0),
('54030', '1709 W Beachwood Avenue, STE 8546, Phoenix, Arizona, 67544', 'HaskinsA577@example.com', 'X-Ray Apparatus and Tubes and Related Irradiation Apparatus', 'Flagg2018', 'XM43Ufa+CaAdCvNupXxB6Q==', 1),
('58852', '41 Edgewood Loop, Guardian Building, Sacramento, California, 46896', 'Archer@example.com', 'Canned Specialties', 'Boyle8', 'rJPKr+/7LVuBU3bjWzGIeg==', 1),
('70235', '3235 Town Ct, Duke Energy Building, Topeka, Kansas, 42116', 'Marjory.Clemons391@example.com', 'Men\'s and Boys\' Clothing And Accessory Stores', 'Ackerman1983', 'oJQR5et6IWr4C/Q2NWEX5A==', 0),
('80185', '3512 West Ashwood Dr, Penobscot Building, Hartford, CT, 50432', 'mftalix5377@nowhere.com', 'Rubber And Plastics Footwear', 'Terry581', '+VbP3yRBedi+PubMLOJL6g==', 0);

-- --------------------------------------------------------

--
-- Table structure for table `customer_telephone`
--

DROP TABLE IF EXISTS `customer_telephone`;
CREATE TABLE IF NOT EXISTS `customer_telephone` (
  `customer_id` char(7) NOT NULL,
  `telephone_number` char(15) NOT NULL,
  PRIMARY KEY (`customer_id`,`telephone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_telephone`
--

INSERT INTO `customer_telephone` (`customer_id`, `telephone_number`) VALUES
('13550', '(247) 352-0836'),
('25376', '(388) 381-4102'),
('26634', '(426) 209-8650'),
('30090', '(335) 474-9601'),
('31862', '(646) 257-8821'),
('42721', '(795) 832-5521'),
('54030', '(651) 312-4101'),
('58852', '(575) 893-4786'),
('70235', '(357) 010-4623'),
('80185', '(847) 694-7194');

-- --------------------------------------------------------

--
-- Table structure for table `custom_attribute`
--

DROP TABLE IF EXISTS `custom_attribute`;
CREATE TABLE IF NOT EXISTS `custom_attribute` (
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `attribute_name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`attribute_name`,`product_id`,`varient_id`),
  KEY `product_id` (`product_id`,`varient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `custom_attribute`
--

INSERT INTO `custom_attribute` (`product_id`, `varient_id`, `attribute_name`, `value`) VALUES
('89733', '56807', 'Abbie682', '6D02RRCDE142QX9YL52JLZSB93320U6NO4MI1O43FQUEJHO'),
('31875', '51082', 'Beulah65', '4HM3T4V468CQ'),
('15731', '66376', 'Burdette1979', '1ZP9U3B3F1R8JR9K8X09X0623723033L629L3W63C26G8ZY369VZ66VZSF0012P5MI037QU262BR63R3H'),
('89416', '21283', 'Daniela1984', 'OK2XVQX1ULF34570'),
('92173', '72378', 'Darling1983', 'JMUR83F7D528ZJ3F21J99F5GBAI5VRZM88U4S9E5AMS'),
('84973', '12760', 'Dwain1', 'HY9N40N8W5N1C'),
('86891', '77637', 'Elton1957', 'QQEL'),
('55816', '23943', 'Norbert2018', '9'),
('16113', '38282', 'Sweet1967', 'L'),
('64049', '67863', 'Tomas2029', '80SR5RBK38B9425ORV707D43');

--
-- Triggers `custom_attribute`
--
DROP TRIGGER IF EXISTS `check_cat_spec_attr_before_insert_on_cust_attr`;
DELIMITER $$
CREATE TRIGGER `check_cat_spec_attr_before_insert_on_cust_attr` BEFORE INSERT ON `custom_attribute` FOR EACH ROW IF EXISTS(SELECT attribute from category_specialized_attribute WHERE attribute = NEW.attribute_name) THEN
        CALL error_procedure(2);
    END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `check_cat_spec_attr_before_update_on_cust_attr`;
DELIMITER $$
CREATE TRIGGER `check_cat_spec_attr_before_update_on_cust_attr` BEFORE UPDATE ON `custom_attribute` FOR EACH ROW IF EXISTS(SELECT attribute from category_specialized_attribute WHERE attribute = NEW.attribute_name) THEN
        CALL error_procedure(2);
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_person`
--

DROP TABLE IF EXISTS `delivery_person`;
CREATE TABLE IF NOT EXISTS `delivery_person` (
  `delivery_person_id` char(5) NOT NULL,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`delivery_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `delivery_person`
--

INSERT INTO `delivery_person` (`delivery_person_id`, `name`) VALUES
('03175', 'Gaylord Whitworth'),
('11004', 'Emery Cochran'),
('27992', 'Arthur Glover'),
('41578', 'Takisha Hagan'),
('41899', 'Juliet Bordelon'),
('57878', 'Arturo Cole'),
('59510', 'Judi Herron'),
('66974', 'Moshe Wilkinson'),
('75249', 'Asuncion Candelaria'),
('88655', 'Lottie Almanza');

-- --------------------------------------------------------

--
-- Table structure for table `order_`
--

DROP TABLE IF EXISTS `order_`;
CREATE TABLE IF NOT EXISTS `order_` (
  `order_id` char(7) NOT NULL,
  `state` char(30) NOT NULL,
  `delivery_method` char(20) NOT NULL,
  `payment_method` char(25) NOT NULL,
  `credit_card_number` char(16) DEFAULT NULL,
  `cvv` char(3) DEFAULT NULL,
  `expire_year` decimal(4,0) DEFAULT NULL,
  `expire_month` decimal(2,0) DEFAULT NULL,
  `name_on_card` varchar(200) DEFAULT NULL,
  `delivery_address` varchar(255) DEFAULT NULL,
  `estimate_days` decimal(2,0) DEFAULT NULL,
  `delivery_person_id` char(5) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `delivery_person_id` (`delivery_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_`
--

INSERT INTO `order_` (`order_id`, `state`, `delivery_method`, `payment_method`, `credit_card_number`, `cvv`, `expire_year`, `expire_month`, `name_on_card`, `delivery_address`, `estimate_days`, `delivery_person_id`) VALUES
('07564', 'Delivered', 'Store Pickup', 'Credit Card', '4405646854899278', NULL, '2006', '2', 'Abram Koontz', '81 Fox Hill Drive, Little Rock, AR, 16919', '3', '11004'),
('08545', 'Deliverying', 'Delivered', 'Cash on Delivery', NULL, NULL, NULL, NULL, NULL, '984 Town Ct, Juneau, AK, 89927', '8', '66974'),
('16153', 'Pending', 'Store Pickup', 'Credit Card', '5558842648132975', '727', '2026', '6', 'Catherina Overstreet', '850 Church Ln, Nashville, TN, 22595', '13', '59510'),
('17759', 'Waiting for Customer', 'Delivered', 'Cash on Delivery', NULL, NULL, NULL, NULL, NULL, '3323 Social Highway, Suite 752, Cheyenne, WY, 52672', '1', '41899'),
('27379', 'Deliverying', 'Delivered', 'Cash on Delivery', NULL, NULL, NULL, NULL, NULL, NULL, '8', '75249'),
('34510', 'Pending', 'Store Pickup', 'Credit Card', '4844756594603739', '985', '2007', '8', 'Norberto Abreu', '1016 New Rock Hill Parkway, Madison, WI, 54233', '8', '03175'),
('38357', 'Pending', 'Store Pickup', 'Credit Card', '4844756594603731', '539', '2010', '10', 'Kamal', NULL, '5', NULL),
('43408', 'Delivered', 'Store Pickup', 'Credit Card', '4405972852222663', '141', '2018', '3', 'Onita Kurtz', '1594 Ashwood Parkway, Enquirer Building, Harrisburg, PA, 91496', '9', '03175'),
('54611', 'Deliverying', 'Delivered', 'Cash on Delivery', NULL, NULL, NULL, NULL, NULL, NULL, '3', '57878'),
('89927', 'Waiting for Customer', 'Delivered', 'Cash on Delivery', NULL, NULL, NULL, NULL, NULL, NULL, '16', '75249');

--
-- Triggers `order_`
--
DROP TRIGGER IF EXISTS `order_validation_on_insert`;
DELIMITER $$
CREATE TRIGGER `order_validation_on_insert` BEFORE INSERT ON `order_` FOR EACH ROW IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    ELSEIF NEW.estimate_days <0 THEN
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
DROP TRIGGER IF EXISTS `order_validation_on_update`;
DELIMITER $$
CREATE TRIGGER `order_validation_on_update` BEFORE UPDATE ON `order_` FOR EACH ROW IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    ELSEIF NEW.estimate_days <0 THEN
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
-- Stand-in structure for view `order_details`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `order_details`;
CREATE TABLE IF NOT EXISTS `order_details` (
`order_id` char(7)
,`state` char(30)
,`delivery_method` char(20)
,`payment_method` char(25)
,`delivery_address` varchar(255)
,`estimate_days` decimal(2,0)
,`name` varchar(200)
,`total_price` decimal(34,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
CREATE TABLE IF NOT EXISTS `order_item` (
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `serial_number` char(10) NOT NULL,
  `order_id` char(6) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  PRIMARY KEY (`product_id`,`varient_id`,`serial_number`,`order_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`product_id`, `varient_id`, `serial_number`, `order_id`, `price`) VALUES
('15731', '66376', '23982', '16153', '332.73'),
('16113', '38282', '40422', '54611', '962.90'),
('31875', '51082', '42258', '38357', '475.69'),
('55816', '23943', '48576', '43408', '879.95'),
('64049', '67863', '12345', '07564', '827.30'),
('64049', '67863', '12709', '07564', '827.30'),
('84973', '12760', '54268', '27379', '54.78'),
('86891', '77637', '64870', '34510', '633.38'),
('89416', '21283', '51055', '08545', '961.85'),
('89733', '56807', '35914', '89927', '307.05'),
('92173', '72378', '23456', '07564', '409.38'),
('92173', '72378', '85691', '17759', '409.38');

--
-- Triggers `order_item`
--
DROP TRIGGER IF EXISTS `check_order_item_price_eq_varient_price`;
DELIMITER $$
CREATE TRIGGER `check_order_item_price_eq_varient_price` BEFORE INSERT ON `order_item` FOR EACH ROW IF (SELECT price from varient where varient.product_id = NEW.product_id 
        and varient.varient_id = NEW.varient_id) <> NEW.price THEN
        CALL error_procedure(2);
    END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_varient_on_place_order`;
DELIMITER $$
CREATE TRIGGER `update_varient_on_place_order` AFTER INSERT ON `order_item` FOR EACH ROW BEGIN 
        UPDATE varient_item set availability = FALSE 
        WHERE varient_item.product_id = NEW.product_id and varient_item.varient_id = NEW.varient_id and varient_item.serial_number = NEW.serial_number;
        UPDATE varient SET quantity = quantity - 1 
        WHERE varient.product_id = NEW.product_id and varient.varient_id = NEW.varient_id;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `order_items_view`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `order_items_view`;
CREATE TABLE IF NOT EXISTS `order_items_view` (
`title` char(100)
,`quantity` bigint(21)
,`price` decimal(12,2)
,`order_id` char(6)
);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `product_id` char(6) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `manufacturer` varchar(50) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `title`, `description`, `manufacturer`, `deleted`, `rating`) VALUES
('15731', 'Dell Pavilion Laptop', 'Tempora natus est ut vitae magni sunt id voluptatem eos ab nisi autem ipsum ratione. Sit atque necessitatibus aliquam rerum ad placeat, officia et similique quaerat error et impedit molestiae; perspiciatis et tempore molestiae, et sit nisi illo enim voluptatem sit inventore sit quia id. Et necessitatibus id facere unde error expedita voluptatem possimus dolorem eligendi illo aspernatur sapiente fuga; necessitatibus doloremque, voluptate et dignissimos non veniam sed id porro corrupti recusandae et aspernatur velit; voluptas necessitatibus, aperiam placeat voluptatem vel nisi eos error sed ut a et aperiam accusamus. Exercitationem maiores reiciendis alias accusamus consectetur iure molestiae nulla deleniti doloremque commodi eaque necessitatibus iste? Corporis ipsum natus enim labore voluptatum eos voluptas et amet vel nemo ut omnis veniam.\r\nOmnis dolores, quo perspiciatis eum labore nobis iste magnam et quis odio unde repellendus iste. Quisquam sed quae fugiat, quos qui error eius quasi iure fugit natus eum rem ut. Sed ipsum omnis, saepe facilis aut nihil et voluptatem totam quia consequatur sed vel rerum! Reprehenderit dignissimos quasi laudantium quidem, voluptates fugit possimus corrupti ut et aliquam quas placeat sed.\r\nVoluptatem non enim veritatis alias voluptatum sapiente sit qui fugiat et voluptas ipsa laudantium inventore. Totam natus, omnis sit et a dignissimos unde minima sed unde sed libero doloribus sit. Ut consequatur totam aut quia sequi possimus in est accusantium minus alias voluptatem esse ut. Sed sint ducimus in qui beatae unde minima consequatur impedit distinctio consequatur labore omnis doloremque. Unde nisi exercitationem aut voluptates sapiente aliquam sed nisi molestias magni recusandae et sit sequi! Porro ratione eum labore voluptatum quos error et sed ut natus sit, quaerat fugit maxime. Ut excepturi hic natus nihil voluptas aperiam aut ut id fuga atque eveniet ut asperiores!', 'Dell', 0, 4),
('16113', 'HP Express Laptop', 'Aut excepturi aut neque quia ipsum voluptas voluptatem blanditiis illum voluptatem modi voluptatem et sit; fugiat sed numquam a, et aut doloremque quam commodi quaerat nobis minima omnis suscipit sit; quis doloremque, et omnis enim atque eos sed sunt debitis qui ut dolorem enim repellendus. Provident iusto asperiores ipsam quo culpa sint natus sunt harum ut natus neque eaque nihil. Porro facere ipsum porro, et nam iure quia fuga veritatis delectus et qui perspiciatis asperiores. Ducimus unde itaque impedit assumenda odio eveniet sed, inventore error iste rerum consequatur dignissimos qui! Sint rerum quia ut voluptatibus est voluptate sit in vitae distinctio repellat qui modi ut. Eaque qui ut, cum dolorem sint fugiat perspiciatis amet accusamus itaque et consequatur sit ea. Sed omnis cum maiores asperiores maxime vitae veniam incidunt non alias natus labore rerum vitae; nesciunt voluptate velit modi, nemo ex porro non et tenetur totam omnis quam perspiciatis iste. Iusto voluptatem quos dolorum explicabo laudantium sit ipsa voluptatem perspiciatis sapiente eligendi voluptatem autem aut. Voluptatem iste natus, tempora minima doloremque voluptas ullam voluptatem in dolorem error nihil earum dolore! Aliquam et nihil aliquid, in quas vel quas facere et voluptatem voluptas et explicabo voluptatem. Qui nemo error neque praesentium voluptatibus vel aliquam architecto officia possimus dolores in saepe molestiae. Tempora culpa excepturi quo qui rerum libero dignissimos veritatis omnis quod velit et officiis aliquid.\r\nQuia dignissimos voluptates sed qui voluptatem facilis consequatur aut natus recusandae incidunt iste rem vitae. Architecto sed mollitia ipsam numquam libero perspiciatis, reiciendis est non quos natus quasi voluptatem dicta. Modi perspiciatis nemo sequi vero amet et voluptas distinctio aliquid dolores rerum non doloribus ad. Accusantium natus voluptatem vero similique distinctio nulla iste voluptatibus delectus sed, suscipit voluptatem dolor facilis; sint voluptatibus deleniti, eaque libero id similique aut iusto explicabo qui sint molestiae quidem aut? Voluptatem quae maxime totam ratione, sit doloremque explicabo similique rerum atque minus iusto ut et. Eos eaque quo quia suscipit omnis harum dolore facilis perspiciatis ut blanditiis unde eum sapiente.', 'HP', 0, 1),
('31875', 'Apple IPhone 6S', 'Voluptatem modi iusto magni quia omnis impedit, et qui et perspiciatis nihil autem ipsum totam. Quaerat explicabo, perspiciatis voluptatem modi dicta id ex ullam velit possimus est ullam sunt voluptatem? Perferendis eligendi perspiciatis qui aut nulla optio non iusto quae delectus ut obcaecati incidunt numquam. Voluptatibus sed, modi ut ipsa voluptatem dolorum voluptatem iste est in et voluptatum omnis temporibus; et doloremque porro non veritatis iste voluptatem repellat fugiat exercitationem nihil vitae voluptates qui quo. Sapiente sit dolore eos at laboriosam aspernatur corporis iste rerum ullam maxime quisquam ea exercitationem; illo libero omnis earum qui veritatis soluta voluptatum reiciendis neque corrupti iste est voluptatem iusto. Quibusdam ipsum minus at eum voluptatem quidem adipisci fuga libero architecto, sapiente modi sunt at! Dolore ut explicabo magni sed qui et maiores aliquam quo similique obcaecati vitae dolore perspiciatis? Dolorem enim qui dicta impedit nemo omnis, et est et vitae nam perferendis aut deserunt. Aut porro voluptate ut voluptas voluptatem ut et error tenetur repellendus nobis impedit magni unde. Aut natus id est quos ullam, aut mollitia quam sit dolor voluptatem sit voluptatem similique. Nisi ullam, rerum pariatur modi asperiores omnis voluptatem debitis in obcaecati ad perferendis ullam natus. Ut adipisci impedit qui vero perspiciatis dolorem illum quo, alias similique culpa qui perspiciatis harum! Voluptatem veritatis velit consequatur voluptas error minima enim error saepe quaerat consequatur harum assumenda explicabo? Exercitationem voluptatem repellendus voluptatem ipsa et vitae alias iste eaque quaerat doloremque voluptatibus ratione accusamus. Nulla sed praesentium vel esse perferendis odio quod est suscipit ut nobis perspiciatis aut eligendi...\r\nRepellat ad sed, quis blanditiis qui omnis ut deleniti perspiciatis quod iste optio a quaerat. Sit repellat architecto blanditiis quisquam officia magni officia aliquam aut consectetur id laboriosam dolorum ut; enim corrupti error veritatis error non consequuntur quo sit nisi sed iste dicta expedita voluptate. Natus quis voluptates id error sunt voluptatem, quod ut consequatur nostrum quia a quae rem. Et aut rerum commodi et dignissimos in reiciendis non et ipsum vero magni ad libero! Magni quos rerum debitis eaque iste tempora suscipit, error doloremque inventore iste fuga et mollitia. Doloribus quam facere velit, voluptatem error aspernatur in pariatur aperiam architecto perferendis corrupti totam quis. Incidunt in et, vero et ad dolorem aut debitis aut qui quos et nesciunt et. Iusto laborum, aperiam dolores quae qui inventore aliquid qui sed iste quae nisi modi iste. Explicabo saepe asperiores odio praesentium natus iure officia quia qui et sed aut quo sed. Nihil qui, temporibus ut molestias repellendus reiciendis similique eligendi numquam maiores et similique autem totam. Consequatur rerum perferendis explicabo id, inventore nihil possimus voluptas voluptatem maiores temporibus nihil voluptatem veniam! Sint velit deleniti fuga aperiam natus adipisci atque illum aut perspiciatis iste sunt consectetur quas. Dolorem reprehenderit maiores illum quis sed natus non in unde illum, voluptatem nostrum soluta porro. Qui ut eveniet libero deserunt deleniti, tempora accusantium voluptatum unde sed optio voluptas alias cum. Quia maxime aliquid non officiis rerum ea dolor voluptatibus optio perspiciatis et dolor illo fuga? Et sint voluptatem, error eveniet omnis quam non iusto in incidunt ad debitis et libero. Enim nobis perspiciatis aspernatur aliquam fuga soluta blanditiis vel quod aut numquam doloribus modi voluptatem!\r\nItaque praesentium consectetur, voluptate ut omnis explicabo eligendi impedit eos voluptas ex cum veritatis quas. Enim voluptatibus sit quia est quasi enim dicta placeat veritatis fuga iure aut magnam eum. Magnam odit cupiditate illum sed, officia quaerat error exercitationem tenetur qui alias atque consequatur unde! Molestiae vero nemo repellat modi dolore placeat fugiat sunt provident hic in perspiciatis labore aliquam? Quo tempore cum eveniet perspiciatis voluptates nulla rerum sit est ut ipsa odit voluptate quo. Necessitatibus sed aut non perspiciatis doloribus omnis sint totam veniam minima omnis laudantium consequatur incidunt. Dolorem iste voluptatem quo, autem beatae quidem sed voluptas qui voluptatum possimus odit tempora similique! Laudantium omnis sed ut nihil ex laudantium architecto et aperiam accusantium delectus voluptas tempora non. Quia qui voluptatem doloremque ut qui culpa, possimus quam voluptatem dolorem sit fugiat dolor consequatur! Est error ab, porro odio soluta et sapiente illo quia similique ut sit non magnam. Similique unde sunt et labore eos dolore molestias aut qui voluptatem eos soluta vero ab. Dolor vero delectus dignissimos pariatur sapiente dolorum explicabo repellendus harum similique dolorum aut rerum aut. Obcaecati aliquam minima ipsa modi, unde quasi consectetur quo perspiciatis optio modi quisquam quis ad. Dolor vitae quia minima eos et officia aspernatur nisi illo quis nulla repellendus voluptatem recusandae. Quia omnis sed ut, qui nulla sit error nihil iste in sed aut amet blanditiis. Et voluptatibus vitae voluptatem aliquid iste illo rerum, facilis repellat delectus porro sunt omnis fugiat...', 'Apple', 1, 4),
('55816', 'Samsung Note ++', 'Vero veritatis, in fuga dolor vel enim error voluptates accusantium quo est doloremque fugit autem. Et sed nihil quasi alias quia doloribus aliquam unde libero quasi sit perspiciatis quaerat quisquam. Omnis quisquam, error quibusdam voluptas nesciunt tempore error facere odio rerum veritatis totam est voluptatem. Labore maiores eos omnis nulla rem, quia et aut aperiam est ut autem eveniet architecto. Porro inventore praesentium qui voluptatem culpa sed exercitationem sed, ut nulla ducimus sunt et ratione. Culpa sed et non sed adipisci porro eveniet dolor ut reiciendis sit commodi unde beatae. Consequatur omnis perspiciatis unde blanditiis dolore ut aspernatur quibusdam est quia et, quo voluptates ut! Quia reprehenderit sed mollitia omnis reprehenderit necessitatibus iste quia ratione enim provident dolores tenetur est. Rerum eveniet unde ex sequi facere neque exercitationem est eligendi illo numquam dolorem, nobis alias. Nisi eos in aliquid iste cumque sequi sed quisquam, possimus porro quia ut hic voluptates! Eum culpa enim impedit id facere nostrum voluptatum velit laudantium, qui perspiciatis magnam aut repellat; sed saepe atque maxime perspiciatis culpa deleniti qui quae numquam debitis ut, debitis ipsam labore. Dolores voluptatem, id earum rerum debitis quia omnis tenetur unde quas voluptates vel necessitatibus sequi. Autem et quia fugit aliquam est necessitatibus sed repudiandae iste quibusdam soluta incidunt earum repudiandae. Consequuntur omnis voluptatem mollitia dolorem omnis veritatis enim et soluta dolorum ullam quia natus sit. Blanditiis et quae officia ad consequatur maxime officiis omnis nostrum cumque iusto quis asperiores natus. Doloribus dolorum ratione consequatur repellat suscipit quisquam quod quia fuga et mollitia nihil quos voluptate. Vel doloremque ducimus laboriosam ea exercitationem veritatis odit aut natus quaerat voluptatem omnis, enim aliquam! Eveniet eius ut deserunt totam voluptatem molestias omnis iusto sed sit necessitatibus dolores id aut.\r\nMagnam sed laudantium et ab numquam vel quaerat dolorem ipsa, ab nobis perspiciatis mollitia voluptatem. Architecto quia hic et vero molestiae quis rem rerum et debitis enim error impedit repellat. Aliquid et reprehenderit quia quasi laudantium perspiciatis nulla suscipit nam veniam sit pariatur rerum excepturi. Minus animi incidunt, deleniti et sapiente saepe eius eveniet quasi ea consequatur voluptas voluptatem earum! Eligendi hic perferendis sint sed sit at quisquam sed ducimus saepe voluptatem omnis nesciunt omnis. Natus deserunt odio totam, hic alias illo rerum aut nihil earum adipisci quibusdam id ducimus; dolorem ab dolor expedita dolorem qui culpa excepturi natus nulla eius rem perspiciatis ratione enim. Fugiat debitis expedita ab nesciunt in vel fuga voluptas nam illo minus harum autem velit. Neque et nisi, est vel voluptatem aut natus ratione provident excepturi sint iusto ut sit. Sed unde veritatis quia, quo totam soluta ut cum deleniti totam doloremque vitae facere quos. Placeat unde eius, qui eos minima vel dolorum vel dolores et sed et id aspernatur! Molestias eligendi tempore blanditiis modi quia at voluptatem sint quod rerum veritatis ut repellat mollitia? Odio soluta amet unde voluptatem ut earum ratione voluptates quod ratione id eligendi et excepturi. Veritatis dolore sit voluptatem unde est quia quae ut est voluptatem deserunt sequi natus nobis. Non quisquam qui nesciunt aliquam ut modi quasi amet et corrupti ab ut natus quidem. Et in eos ratione pariatur similique accusantium non amet nobis dolorem aliquid fuga provident voluptatum.\r\nQui voluptatem placeat iusto neque architecto voluptas modi et qui sed earum inventore libero expedita. Accusantium repellat distinctio eum reiciendis fuga dolor iste quis eos rerum voluptatem fugit consequatur minus.', 'Samsung', 1, 0),
('64049', 'Racing Car ', 'Ut doloribus odit laudantium perspiciatis, vel ex natus et enim facilis voluptatem dolor aut maiores. Qui quibusdam dignissimos fugit aut sapiente assumenda fugit laudantium ut libero natus unde qui et! Aut minima, aut et vitae sequi quas recusandae aut omnis eum ullam aut laudantium omnis. Error sed excepturi fugiat suscipit ipsam ab aspernatur quia et impedit dolorem distinctio dolore exercitationem? Voluptatem unde nobis, minima unde reiciendis numquam odio vero accusantium itaque odio non a magnam! Aspernatur minus quod ipsa, adipisci id ut error illo velit minima aut deserunt facilis accusantium.\r\nRatione consequatur est quia voluptate repudiandae impedit voluptatem ratione earum autem velit maiores reiciendis omnis. Soluta est praesentium quasi esse eveniet ut nesciunt qui accusamus veniam perspiciatis qui cum nostrum; non voluptas sequi soluta sunt necessitatibus earum quia, reiciendis qui ducimus quisquam et odit nemo. Et illo nemo porro dignissimos nesciunt quidem eaque quis unde temporibus rerum qui eius ullam! Dolores quaerat sit molestiae ipsam eos quasi qui soluta fuga facilis omnis ea nesciunt asperiores. Magni itaque qui expedita distinctio in ut porro sit voluptatem perspiciatis est sit est sint.\r\nInventore sapiente nihil, at ex vitae ut et laudantium incidunt eum a iure non molestias. Autem ut voluptas doloremque repellendus, eveniet cumque obcaecati enim voluptatem ut corrupti repudiandae ea voluptatum. Aut sit est dolor consequuntur aliquam assumenda ut, qui optio soluta ex amet id natus! Quas dolore sit tenetur fugit sit ipsa beatae aliquam sit unde repellat laudantium qui aut. Illum autem dicta ut, dolorum reprehenderit totam sunt voluptatem dolorem natus sed corporis doloremque quo; facilis ut quia sed ut et eaque alias in aut dolore sed corporis id et. Voluptates vel ipsa error et perspiciatis corrupti repellat voluptatem sit ipsam ipsa a omnis itaque! Veritatis unde error eos sed autem labore libero enim sequi labore dolorem asperiores praesentium autem. Quidem voluptate dolores est molestias necessitatibus ea voluptas et neque qui aut quia delectus ea.', 'LEGO', 0, NULL),
('84973', 'Barbie Doll', 'Praesentium error maiores et quo vel et veritatis corporis fugit sunt incidunt minus ut iste. Labore voluptas natus expedita et eaque ducimus corporis et quod autem natus hic sapiente non. Ut fuga inventore voluptatem dolorum omnis natus, quidem error delectus eaque corrupti blanditiis iste quo. Libero nulla voluptatibus velit earum neque ut laboriosam natus quo alias aut iste beatae molestias? Ipsum maiores quibusdam animi, iste nihil voluptas necessitatibus temporibus beatae quae accusantium ipsa iste dicta. Et laudantium sint veniam quibusdam repellendus libero porro enim eos nulla non est ipsam iusto! Fugiat quia tempore quos ipsa ut ipsum unde ex sequi aut magni facere sed et; ut similique est error quibusdam est minus soluta reiciendis sunt ad quia et a nobis. Labore et reiciendis quam vel qui unde quos autem nemo earum magnam mollitia debitis consequatur. Ipsam sit nihil asperiores ea debitis nulla quaerat et unde ex laborum error voluptatem omnis; non modi vitae adipisci nemo omnis tenetur perspiciatis totam ut provident et cupiditate voluptas dignissimos. Voluptatem mollitia voluptate adipisci, iusto doloremque eaque unde obcaecati sint ea possimus accusamus consequuntur voluptate. Nesciunt asperiores, amet non voluptas ea magni voluptatem quidem enim et eos harum assumenda omnis. Labore corporis eveniet omnis sint iure facere et facilis qui fugit doloribus in vero dolore! Debitis error sed doloremque quo error aliquam fuga quo odit est ratione ut rem quia. Rerum non eaque et cum, porro temporibus est quia aut veniam soluta veniam quo quis. Modi voluptates eos sed atque ut adipisci, ipsam dolores sunt voluptas vel autem molestiae natus. Asperiores sunt autem omnis laudantium autem rem omnis, velit ut sapiente et voluptas nihil laboriosam...\r\nUt amet rerum, ipsum est eligendi consequuntur sunt odit nostrum eaque non minus quod consequatur. Explicabo aliquam asperiores cupiditate, nihil culpa cum adipisci et dignissimos dolor ut et harum iste. Aut possimus eligendi voluptatem est magni consequatur vel aut reprehenderit adipisci similique dolores, ut vel; sequi quis aliquid quam, molestiae beatae recusandae qui enim et expedita enim sed ut perferendis. Incidunt ratione aut magni ut alias vitae omnis iste sapiente rem suscipit ipsum cupiditate qui? Esse voluptatem dolor est omnis aliquam qui nihil quam, ut minus aut molestiae explicabo odio. Eaque numquam sed perspiciatis est unde, asperiores excepturi illum perspiciatis exercitationem nisi animi fugit facilis! Voluptatibus ipsam, quas incidunt non consequatur enim ut ratione nisi recusandae laboriosam nam dolore odit.\r\nUt eaque totam ut sint eum natus maiores sed aut provident labore nisi iste odit. Aut voluptatibus nobis blanditiis porro aspernatur officia ut consequuntur sit sed nesciunt sunt magnam porro! Esse ut sapiente rerum nam, et rem sunt a laborum voluptatem deleniti ratione harum voluptatem. Velit eum cumque ipsum dolorum aliquam vel quasi aut consequatur aut adipisci iure ad labore. Ut voluptas quia omnis ex temporibus aut, temporibus quis ea est sed dolor sunt est. Voluptas amet et aliquam laboriosam omnis blanditiis exercitationem molestiae sit repellendus et at omnis obcaecati. Libero sequi vero amet rerum et sunt ut facere molestiae cumque laudantium temporibus est et! Omnis quod excepturi beatae deserunt quo delectus vel ipsum sit quia eius numquam dolorum qui? Consectetur provident quis nobis voluptatem iste beatae eos natus possimus eos aut voluptatem id amet. Id iusto, commodi deserunt omnis dolor iste libero consectetur id et non iusto et vero; sed et reprehenderit aut est facilis ab esse ut praesentium doloremque est maxime odit autem. Doloribus laudantium, reiciendis eaque omnis ut cupiditate quam libero natus vel sapiente dolorem et ut! Perspiciatis modi quam possimus, facilis eligendi nihil ducimus eum suscipit praesentium cumque ut praesentium autem. Ut iste nobis obcaecati veniam et consequatur impedit ut quos repudiandae adipisci voluptate eaque non! Ut consequuntur consequatur maxime adipisci voluptatem ea ducimus autem ipsam omnis voluptate amet qui quia. Voluptatem repellendus aperiam ratione ut, cumque unde quia cumque aperiam tempora laboriosam non odit nihil. Tempore iste distinctio error rerum amet distinctio incidunt iusto blanditiis accusantium laboriosam sed sunt et.', 'Barbie', 0, 0),
('86891', 'WWE Doll', 'Quos quia neque, illum odit omnis unde est qui enim aspernatur voluptatem consectetur voluptatem iusto. Ut totam et consequuntur, perferendis eveniet dolores optio quidem nemo velit consectetur consequatur delectus laboriosam. Laboriosam eligendi omnis nobis perspiciatis laboriosam et, necessitatibus aut facere amet optio quam molestias perspiciatis. Similique qui est iusto similique consequatur, ut aliquam eum recusandae omnis esse facilis officia adipisci. Autem eum, et saepe aliquid error mollitia ab temporibus voluptatem sed et est nulla delectus? Vel eaque rerum, architecto quia rerum eius facere quam ut iusto dolorem natus est nesciunt. Et architecto nisi pariatur molestiae ex atque beatae quam rerum aut reprehenderit sequi et autem. Vel corporis ut exercitationem soluta, aut voluptatum et aut rerum laudantium debitis quia voluptatem quasi. Dolor eos accusantium necessitatibus culpa ad laborum veritatis sit ullam ipsum vitae odio pariatur commodi? Minima qui illo mollitia delectus libero error sit ut voluptatem consequuntur voluptatem et tenetur magnam. Et voluptatem quisquam, qui saepe voluptatem maiores at sit error incidunt qui laboriosam enim accusantium. Aliquam quis et quos ex voluptatem accusamus quidem molestias reiciendis et omnis voluptatem molestias deserunt; modi alias voluptatem molestias excepturi deleniti alias aperiam quo laudantium officiis et beatae, laborum est. Ullam optio non veniam consequatur qui quaerat veniam, ut recusandae molestias fuga qui ab impedit. Voluptatem et officia voluptates aut perspiciatis quasi officia aut rerum illo ad fugiat magnam rem. Eaque officiis labore, numquam labore dolorem error fugit atque sit ut fugit ullam atque voluptatem...\r\nVoluptatem quaerat ut laborum earum consectetur quia voluptatem quasi nostrum voluptas accusantium natus dolore quo. Similique dolore magnam quas id dolorem suscipit expedita iusto quis fugit veniam error adipisci sed. Beatae fugiat nisi nesciunt aspernatur in voluptatibus veniam error officiis sed iste rerum consectetur sit; est enim, amet et inventore et voluptatem dolorem impedit expedita et repellendus labore omnis et? Quam sit, illo totam eaque aspernatur autem incidunt in et eaque error aliquid qui laudantium. Ipsa sed architecto quibusdam nihil explicabo et aut voluptates voluptatibus natus nobis explicabo sit perspiciatis. Asperiores numquam, eveniet aut odit voluptatum numquam alias error dicta cum est quis magni sapiente; asperiores est ex sunt odio, ad iusto voluptas eligendi nihil in aut asperiores fuga dolores; id fugiat id illum omnis et adipisci quidem natus quo laboriosam quia illo natus quaerat. Esse quia voluptatem et accusamus vitae error perspiciatis culpa est beatae ut qui placeat dolorem. Qui recusandae quae aut iste rerum inventore sed rerum maiores quo provident error voluptas suscipit? Dolorum doloremque ut maiores repellat consequatur natus excepturi iure placeat fugiat vel atque alias fuga. Dolorum similique, et in optio odit qui ad ut quia itaque adipisci odio aut nihil! Beatae consectetur, officia asperiores ipsum blanditiis laudantium in minus ex natus ullam id enim ex.\r\nAssumenda velit aperiam, nemo consequuntur sit modi unde eum excepturi ut quas neque doloremque error. Pariatur aliquam assumenda qui eligendi praesentium et labore velit ut consequatur similique repudiandae iste quae! Voluptatem placeat ea magni ad voluptatem qui blanditiis ipsum, aliquid ut sed et provident amet. Ipsam ut maiores ex accusantium quis vel autem vero dolorem nam voluptatem nulla consectetur beatae! Nisi adipisci praesentium officia odit saepe dolorem est aut natus minus praesentium ut eligendi et. Animi nulla voluptatem quasi natus eveniet facere sit laborum et, aut aspernatur impedit animi aspernatur. Obcaecati maiores accusamus ut quidem quasi molestiae ipsam dolores error obcaecati qui quaerat quos dignissimos? Et odit voluptatem impedit ullam quasi voluptates asperiores ipsam neque ab dolores inventore dolorem omnis! Quasi rem sit debitis, tempore voluptatem vel dolorem voluptatem natus omnis laudantium temporibus neque omnis. Adipisci ut aliquid voluptas ut error sed eveniet recusandae ut consectetur est amet enim sed.', 'WWE Shop', 1, 5),
('89416', 'SEGA Sonic Family', 'Consequuntur quis et quia et sed eos suscipit quod nobis quae tempore velit qui ut. Quo quasi non iste amet earum quisquam et non temporibus placeat omnis ut sit error. Sint et accusantium autem accusamus et quo laborum, perspiciatis odio natus harum ducimus qui beatae! Et corrupti cumque, fugiat quis voluptate qui sed placeat ullam voluptatem neque nemo nobis dignissimos. Expedita eos voluptatem dolorum ratione nihil sequi enim voluptatem odit ex repellendus ut sit est. Nesciunt et non sequi corporis delectus qui accusantium quod voluptatem dolor alias nesciunt temporibus enim. Unde excepturi modi repudiandae eos illum autem deleniti consequuntur voluptatem vero dolor ipsa laudantium voluptas. Consectetur sed eos voluptatum ullam qui repudiandae aperiam iure ut error maiores est aut et! Autem sit ut accusantium velit aliquid cum sit quia saepe esse quas assumenda aut error. Blanditiis et delectus illum dolore aut rem beatae in sed libero dolores modi molestias autem. Velit officiis ut qui ut illo maxime qui sit nostrum ullam iusto tempora qui eos! Harum saepe eveniet veniam vero sed a molestias mollitia voluptatem explicabo aut consequuntur deserunt odit. Rem officiis nulla ea porro dolore saepe doloremque quaerat exercitationem porro placeat explicabo repudiandae omnis.\r\nVelit iusto sunt ut ea aliquam blanditiis est nisi libero et ut et ut iste; molestiae quisquam libero rerum, aut rerum dolorem sit sequi veritatis quibusdam optio illum asperiores est. Pariatur odit nihil autem rem dolor impedit sed exercitationem quo voluptatibus officiis et omnis quisquam. Soluta ex, sunt architecto labore architecto odit dicta assumenda aspernatur omnis unde magni reiciendis natus. Accusantium fugit unde quae eos dolorum minima sequi aut autem quia et eos delectus quam. Voluptas debitis aut velit quod beatae assumenda perspiciatis vero ab, ducimus non consequuntur accusamus corporis. Voluptatem dolorem temporibus quam ullam voluptates dolore quis maiores ipsum facilis qui expedita quaerat sit. Veritatis enim odit exercitationem expedita omnis earum dolores placeat sit totam suscipit aut dolores fuga.', 'SEGA', 0, 0),
('89733', 'Transcend Hard Disk', 'Officia et quasi quia nam, nostrum aut dolores rerum unde quasi explicabo beatae unde quia. Unde amet, expedita dicta sit nobis suscipit sed ipsa velit pariatur hic consequatur voluptatem minima! Quia voluptatem sunt perferendis pariatur consequatur, consectetur rerum iste illo dolorem omnis perferendis sed facere. Alias aliquid et voluptatem laborum sed non voluptas fugit eos numquam quaerat voluptatem vel ut? Omnis eos quidem asperiores quibusdam voluptas et velit quis ut officia odit numquam optio aut. Ipsam inventore ipsum sit enim magni veniam omnis laboriosam voluptate aut magni in incidunt perferendis. Ut sint quis quisquam autem natus inventore nostrum aliquid quia iste consequatur harum sunt error; aut quidem et est sint nulla vitae dolores, omnis asperiores commodi illo quae aliquam tempora. Neque facere, sit sed officiis ad qui est rerum numquam nihil omnis sit voluptatem numquam. Provident molestiae suscipit qui eum sit nihil porro aut, quo iste id alias consequatur eum; omnis dolor ipsum, ipsam sit nesciunt consectetur accusantium quo eius voluptatem quia consequatur et laborum? Omnis ut natus ab sit totam consequatur maxime cumque tempora voluptate officia sed eius repellat. Et quod aperiam qui ut sed eos, ipsam eum dolor aperiam dolores iste odit voluptatem? Porro reprehenderit architecto unde accusantium et culpa tenetur eligendi consequatur voluptatem et expedita dolor voluptatem. Voluptatem sit harum nisi omnis nihil quisquam, quis incidunt dolores error odio molestiae obcaecati reprehenderit! Fugiat voluptatem vel ut voluptate deserunt quaerat et repellendus aut sit temporibus voluptatem soluta harum? Aut minima alias modi quibusdam placeat necessitatibus porro possimus laborum unde voluptas quo alias et.\r\nUt quasi eligendi qui magnam saepe nulla eos nam repellat recusandae, facilis sunt possimus omnis; reiciendis voluptatem, corporis est qui at eum architecto ut ipsum sit quis nesciunt est molestias. Dolor aliquid, in omnis vitae molestiae impedit dolorem laudantium itaque laboriosam nisi aut dolores mollitia! Dolorem non ut doloremque et ut possimus sit fugiat sed fugit unde omnis fugiat qui. Molestiae eius quia dolor autem itaque qui dolor ut saepe quam explicabo cupiditate aspernatur unde. Sequi labore natus est dolores est exercitationem excepturi, fugiat aut nemo dolorem provident tempora dolorum. Et voluptatem et, non fuga ut explicabo iusto suscipit nostrum quae inventore neque enim adipisci. Dolorem quia quasi similique voluptatem veniam non, aut dolore autem distinctio voluptatem voluptatum incidunt assumenda; voluptatum eos optio magni dolores consequatur aperiam esse ut error repellendus est eos voluptatem enim. Ad repudiandae consequatur voluptas quis ipsum est et atque, molestias quaerat quasi quod nostrum repellat. Ut iste ex dolores consectetur quae quasi placeat sint minima maiores est blanditiis delectus et; qui autem hic dignissimos sit natus sunt perspiciatis ea ut nihil ex rerum non obcaecati? Molestiae dolorum et reiciendis distinctio sed eos qui ullam rerum enim sed perferendis est dignissimos. Sed optio ut error eius dolorem aliquam quia voluptatem asperiores unde rerum dolorem ut officia. Suscipit dolor qui sed harum, ipsum officia in ipsam et sit qui voluptatum perspiciatis numquam.', 'Trancend', 1, 5),
('92173', 'Lenonvo Node Laptop', 'Ipsam sit dignissimos sunt tempora voluptatem modi error architecto eaque aut maxime eum autem fuga.', 'Lenovo', 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE IF NOT EXISTS `product_category` (
  `product_id` char(6) NOT NULL,
  `category_id` char(6) NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`product_id`, `category_id`) VALUES
('15731', '11638'),
('15731', '99298'),
('16113', '11638'),
('16113', '99298'),
('31875', '11638'),
('31875', '87267'),
('55816', '11638'),
('55816', '87267'),
('64049', '22554'),
('64049', '24206'),
('84973', '22554'),
('84973', '37879'),
('86891', '22554'),
('86891', '52432'),
('89416', '52432'),
('89733', '11638'),
('89733', '93854'),
('92173', '11638'),
('92173', '99298');

-- --------------------------------------------------------

--
-- Table structure for table `product_category_specialized_attribute`
--

DROP TABLE IF EXISTS `product_category_specialized_attribute`;
CREATE TABLE IF NOT EXISTS `product_category_specialized_attribute` (
  `product_id` char(6) NOT NULL,
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` char(6) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`product_id`,`attribute_id`,`category_id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_category_specialized_attribute`
--

INSERT INTO `product_category_specialized_attribute` (`product_id`, `attribute_id`, `category_id`, `value`) VALUES
('15731', 1, '99298', 'G3ZP7K31B6E33O5HG576D10CNNX7JC0GJQ4S68LPS1'),
('16113', 4, '52432', 'VD7067ZOSEY3S'),
('31875', 10, '87267', '54'),
('55816', 9, '11638', 'GB8BI0QP302403895PTNA9H4437OHVK62WW1H8438BMPA22HPJV06G541P7TO771271A74CSC92U6OC0MM76X'),
('64049', 8, '74883', '1JAES702ASC8Q63SLJ7384K2604'),
('84973', 2, '37879', '2X50QCD2FE716K1IDTIB937H59C829474H6CGYIBN4L'),
('86891', 7, '24206', '2421P34NQU3PGVNHQ0T'),
('89416', 6, '86148', '5HGCWFL6VK2697SAL9R3L18EM645O7M4E805BC26'),
('89733', 3, '93854', '2UWXI81EZQ57YX9NQQ3IFM1B'),
('92173', 5, '22554', 'B2G0703');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
CREATE TABLE IF NOT EXISTS `rating` (
  `customer_id` char(7) NOT NULL,
  `product_id` char(6) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`product_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`customer_id`, `product_id`, `rating`) VALUES
('13550', '16113', 3),
('25376', '86891', 5),
('26634', '15731', 0),
('30090', '89416', 5),
('31862', '55816', 3),
('42721', '64049', 2),
('54030', '92173', 4),
('58852', '89733', 5),
('70235', '31875', 3),
('80185', '84973', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart_item`
--

DROP TABLE IF EXISTS `shopping_cart_item`;
CREATE TABLE IF NOT EXISTS `shopping_cart_item` (
  `customer_id` char(7) NOT NULL,
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`,`product_id`,`varient_id`),
  KEY `product_id` (`product_id`,`varient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shopping_cart_item`
--

INSERT INTO `shopping_cart_item` (`customer_id`, `product_id`, `varient_id`, `quantity`) VALUES
('13550', '55816', '23943', 98),
('25376', '92173', '72378', 53),
('26634', '84973', '12760', 23),
('30090', '31875', '51082', 87),
('31862', '64049', '67863', 43),
('42721', '15731', '66376', 1),
('54030', '16113', '38282', 40),
('58852', '89733', '56807', 13),
('70235', '89416', '21283', 88),
('80185', '86891', '77637', 83);

--
-- Triggers `shopping_cart_item`
--
DROP TRIGGER IF EXISTS `shopping_cart_item_validation_on_insert`;
DELIMITER $$
CREATE TRIGGER `shopping_cart_item_validation_on_insert` BEFORE INSERT ON `shopping_cart_item` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `shopping_cart_item_validation_on_update`;
DELIMITER $$
CREATE TRIGGER `shopping_cart_item_validation_on_update` BEFORE UPDATE ON `shopping_cart_item` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `shop_view_min_max`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `shop_view_min_max`;
CREATE TABLE IF NOT EXISTS `shop_view_min_max` (
`category_id` char(6)
,`category` varchar(50)
,`product_id` char(6)
,`title` varchar(100)
,`image_path` varchar(255)
,`MIN(varient.price)` decimal(12,2)
,`MAX(varient.price)` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `varient`
--

DROP TABLE IF EXISTS `varient`;
CREATE TABLE IF NOT EXISTS `varient` (
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `sku` char(10) NOT NULL,
  `title` char(100) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `weight` decimal(6,2) DEFAULT NULL,
  `restock_limit` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  PRIMARY KEY (`product_id`,`varient_id`),
  UNIQUE KEY `sku` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `varient`
--

INSERT INTO `varient` (`product_id`, `varient_id`, `sku`, `title`, `price`, `quantity`, `deleted`, `weight`, `restock_limit`, `image_path`) VALUES
('15731', '66376', 'UVY', 'Dell Pavilion ES456 Laptop', '716.33', 49, 0, '158.14', 29, '/images/product/15731.jpg'),
('16113', '38282', '6F', 'HP Express EX567 Laptop', '820.39', 57, 0, '238.91', 79, '/images/product/16113.jpg'),
('31875', '34567', 'AJ_1', 'Apple IPhone 6S +', '605.23', 7, 0, '1605.23', 66, '/images/product/31875.jpg'),
('31875', '51082', 'AJ', 'Apple IPhone 6S Express', '601.23', 2, 0, '1605.23', 66, '/images/product/31875.jpg'),
('55816', '23943', '811JS', 'Samsung Note Express ++', '447.28', 94, 1, '1985.28', 62, '/images/product/55816.jpg'),
('64049', '67863', '33', 'Racing Monster Truck', '827.30', 58, 0, '1968.30', 45, '/images/product/64049.jpg'),
('84973', '12760', 'M4G', 'Barbie Doll Large', '508.40', 67, 0, NULL, 95, '/images/product/84973.jpg'),
('86891', '77637', 'ENB', 'WWE Doll John Cena', '596.41', 58, 1, '58.41', 58, '/images/product/86891.jpg'),
('89416', '21283', 'I73', 'SEGA Sonic', '327.36', 39, 1, '1624.43', 7, '/images/product/89416.jpeg'),
('89733', '56807', 'Y6I', 'Transcend Hard Disk 1TB', '365.14', 32, 0, '1221.39', 30, '/images/product/89733.jpg'),
('92173', '72378', '6', 'Lenovo Node N456 Laptop', '409.38', 61, 0, '963.88', 84, '/images/product/92173.jpg');

--
-- Triggers `varient`
--
DROP TRIGGER IF EXISTS `varient_validation_on_insert`;
DELIMITER $$
CREATE TRIGGER `varient_validation_on_insert` BEFORE INSERT ON `varient` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.weight <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.restock_limit<0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `varient_validation_on_update`;
DELIMITER $$
CREATE TRIGGER `varient_validation_on_update` BEFORE UPDATE ON `varient` FOR EACH ROW IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.weight <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.restock_limit<0 THEN
        CALL error_procedure(1);
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `varient_item`
--

DROP TABLE IF EXISTS `varient_item`;
CREATE TABLE IF NOT EXISTS `varient_item` (
  `product_id` char(6) NOT NULL,
  `varient_id` char(6) NOT NULL,
  `serial_number` char(10) NOT NULL,
  `availability` tinyint(1) NOT NULL,
  PRIMARY KEY (`product_id`,`varient_id`,`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `varient_item`
--

INSERT INTO `varient_item` (`product_id`, `varient_id`, `serial_number`, `availability`) VALUES
('15731', '66376', '23982', 1),
('16113', '38282', '40422', 0),
('31875', '51082', '42258', 0),
('55816', '23943', '48576', 1),
('64049', '67863', '12345', 0),
('64049', '67863', '12709', 1),
('84973', '12760', '54268', 1),
('86891', '77637', '64870', 0),
('89416', '21283', '51055', 1),
('89733', '56807', '35914', 1),
('92173', '72378', '23456', 0),
('92173', '72378', '85691', 1);

-- --------------------------------------------------------

--
-- Structure for view `order_details`
--
DROP TABLE IF EXISTS `order_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_details`  AS  select `order_`.`order_id` AS `order_id`,`order_`.`state` AS `state`,`order_`.`delivery_method` AS `delivery_method`,`order_`.`payment_method` AS `payment_method`,`order_`.`delivery_address` AS `delivery_address`,`order_`.`estimate_days` AS `estimate_days`,`delivery_person`.`name` AS `name`,sum(`order_item`.`price`) AS `total_price` from (`delivery_person` join (`order_` join `order_item` on(`order_`.`order_id` = `order_item`.`order_id`)) on(`delivery_person`.`delivery_person_id` = `order_`.`delivery_person_id`)) group by `order_item`.`order_id` ;

-- --------------------------------------------------------

--
-- Structure for view `order_items_view`
--
DROP TABLE IF EXISTS `order_items_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_items_view`  AS  select `varient`.`title` AS `title`,count(`order_item`.`varient_id`) AS `quantity`,`order_item`.`price` AS `price`,`order_item`.`order_id` AS `order_id` from (`order_item` join (`varient_item` join `varient` on(`varient_item`.`product_id` = `varient`.`product_id` and `varient_item`.`varient_id` = `varient`.`varient_id`)) on(`order_item`.`product_id` = `varient_item`.`product_id` and `order_item`.`varient_id` = `varient_item`.`varient_id` and `order_item`.`serial_number` = `varient_item`.`serial_number`)) group by `order_item`.`varient_id`,`order_item`.`product_id`,`order_item`.`order_id` ;

-- --------------------------------------------------------

--
-- Structure for view `shop_view_min_max`
--
DROP TABLE IF EXISTS `shop_view_min_max`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shop_view_min_max`  AS  select `category`.`category_id` AS `category_id`,`category`.`category` AS `category`,`product`.`product_id` AS `product_id`,`product`.`title` AS `title`,`varient`.`image_path` AS `image_path`,min(`varient`.`price`) AS `MIN(varient.price)`,max(`varient`.`price`) AS `MAX(varient.price)` from (`category` join (`product_category` join (`product` join `varient` on(`product`.`product_id` = `varient`.`product_id`)) on(`product_category`.`product_id` = `product`.`product_id`)) on(`category`.`category_id` = `product_category`.`category_id`)) where `category`.`deleted` = 0 and `product`.`deleted` = 0 group by `product_category`.`product_id`,`category`.`category_id` ;

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
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `order_`
--
ALTER TABLE `order_`
  ADD CONSTRAINT `order__ibfk_1` FOREIGN KEY (`delivery_person_id`) REFERENCES `delivery_person` (`delivery_person_id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`product_id`,`varient_id`,`serial_number`) REFERENCES `varient_item` (`product_id`, `varient_id`, `serial_number`) ON UPDATE CASCADE,
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`) ON UPDATE CASCADE;

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
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `varient_item_ibfk_1` FOREIGN KEY (`product_id`,`varient_id`) REFERENCES `varient` (`product_id`, `varient_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
