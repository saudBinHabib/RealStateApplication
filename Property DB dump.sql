-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 05, 2017 at 02:51 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Property`
--

-- --------------------------------------------------------

--
-- Table structure for table `buyer`
--

CREATE TABLE `buyer` (
  `USER_ID` varchar(30) NOT NULL,
  `PROP_TYPE_ID` int(11) NOT NULL,
  `COUNTRY_ID` int(11) DEFAULT NULL,
  `CITY_ID` int(11) DEFAULT NULL,
  `MIN_AREA` varchar(10) DEFAULT NULL,
  `MAX_AREA` varchar(10) DEFAULT NULL,
  `MIN_BUDGET` int(11) DEFAULT NULL,
  `MAX_BUDGET` int(11) DEFAULT NULL,
  `ACTIVE` char(1) NOT NULL DEFAULT 'Y',
  `CREATED_DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATED_BY` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `defination_type`
--

CREATE TABLE `defination_type` (
  `ID` int(11) NOT NULL,
  `DESCRIPTION` varchar(30) NOT NULL,
  `ACTIVE` char(1) NOT NULL DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `defination_type`
--

INSERT INTO `defination_type` (`ID`, `DESCRIPTION`, `ACTIVE`) VALUES
(1, 'PROPERTY_TYPE', 'Y'),
(2, 'USER_TYPE', 'Y'),
(3, 'STATUS', 'Y'),
(4, 'COUNTRY', 'Y'),
(5, 'CITY', 'Y'),
(7, 'STATE', 'Y'),
(0, 'NOT DEFINE', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `defination_type_detail`
--

CREATE TABLE `defination_type_detail` (
  `ID` int(11) NOT NULL,
  `DEF_ID` int(11) NOT NULL,
  `DESCRIPTION` varchar(30) NOT NULL,
  `ACTIVE` char(1) NOT NULL DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `defination_type_detail`
--

INSERT INTO `defination_type_detail` (`ID`, `DEF_ID`, `DESCRIPTION`, `ACTIVE`) VALUES
(1, 1, 'APARTMENT', 'Y'),
(2, 1, 'HOUSE', 'Y'),
(3, 2, 'ADMINISTRATOR', 'Y'),
(4, 2, 'STUDENT', 'Y'),
(5, 3, 'AVAILABLE', 'Y'),
(6, 3, 'SOLD', 'Y'),
(7, 3, 'N/A', 'Y'),
(8, 4, 'AMERICA', 'Y'),
(9, 4, 'GERMANY', 'Y'),
(10, 5, 'SFS', 'Y'),
(11, 5, 'FULDA', 'Y'),
(12, 6, 'SAN FRANCISCO', 'Y'),
(13, 1, 'BEDROOM', 'Y'),
(0, 0, 'N/A', 'Y'),
(15, 2, 'LANDLORD', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `image_uploads`
--

CREATE TABLE `image_uploads` (
  `ID` int(11) NOT NULL,
  `PROPERTY_ID` int(11) NOT NULL,
  `IMAGE_NAME` varchar(500) NOT NULL,
  `IMAGE_TYPE` varchar(50) NOT NULL,
  `IMAGE_SIZE` varchar(20) NOT NULL,
  `ACTIVE` char(1) NOT NULL DEFAULT 'Y',
  `CREATED_DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATED_BY` varchar(30) NOT NULL DEFAULT 'ADMIN'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `ID` int(11) NOT NULL,
  `USER_ID` varchar(30) NOT NULL DEFAULT 'ADMIN',
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `PROP_TYPE_ID` int(11) NOT NULL,
  `ADDRESS` varchar(400) DEFAULT NULL,
  `ZIP_CODE` int(5) NOT NULL,
  `TOTAL_ROOMS` int(11) DEFAULT NULL,
  `NUMBER_OCCUPANTS` int(11) DEFAULT NULL,
  `PRICE` int(11) NOT NULL DEFAULT '0',
  `IS_PET_ALLOWED` char(1) DEFAULT 'Y',
  `STATUS_ID` int(11) NOT NULL DEFAULT '5',
  `COMMENTS` varchar(100) DEFAULT NULL,
  `ACTIVE` char(1) NOT NULL DEFAULT 'Y',
  `CREATED_DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATED_BY` varchar(30) NOT NULL DEFAULT 'ADMIN'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`ID`, `USER_ID`, `TITLE`, `DESCRIPTION`, `PROP_TYPE_ID`, `ADDRESS`, `ZIP_CODE`, `TOTAL_ROOMS`, `NUMBER_OCCUPANTS`, `PRICE`, `IS_PET_ALLOWED`, `STATUS_ID`, `COMMENTS`, `ACTIVE`, `CREATED_DATE`, `CREATED_BY`) VALUES
(76, 'ADMIN', 'title', 'description', 1, 'address', 12345, NULL, 2, 400, 'N', 5, NULL, 'Y', '2017-04-01 14:41:40', 'ADMIN'),
(77, 'ADMIN', 'title', 'description', 1, 'address', 12345, NULL, 2, 400, 'N', 5, NULL, 'Y', '2017-04-01 14:43:07', 'ADMIN'),
(78, 'ADMIN', 'Location', 'Middle', 1, 'strasse', 12345, NULL, 2, 400, 'Y', 5, NULL, 'Y', '2017-04-01 14:44:52', 'ADMIN'),
(79, 'ADMIN', 'Location', 'Middle', 1, 'strasse', 12345, NULL, 2, 400, 'Y', 5, NULL, 'Y', '2017-04-01 14:45:16', 'ADMIN'),
(80, 'ADMIN', 'saad', 'saad', 1, 'saad', 123, NULL, 2, 233, 'Y', 5, NULL, 'Y', '2017-04-01 14:45:58', 'ADMIN'),
(81, 'ADMIN', 'asdf', 'asdf', 1, 'asdf', 123, NULL, 2, 223, 'Y', 5, NULL, 'Y', '2017-04-01 14:54:48', 'ADMIN'),
(82, 'ADMIN', 'saad', 'saad', 1, 'saad', 123, NULL, 2, 233, 'Y', 5, NULL, 'Y', '2017-04-01 14:56:15', 'ADMIN'),
(83, 'ADMIN', 'saad', 'saad', 1, 'saad', 123, NULL, 2, 1222, 'Y', 5, NULL, 'Y', '2017-04-01 15:24:34', 'ADMIN'),
(84, 'ADMIN', 'saad', 'saad', 1, '123', 123, NULL, 1, 123, 'Y', 5, NULL, 'Y', '2017-04-01 15:29:20', 'ADMIN'),
(85, 'ADMIN', 'saad', 'saad', 1, '123', 123, NULL, 1, 123, 'Y', 5, NULL, 'Y', '2017-04-01 15:29:29', 'ADMIN'),
(86, 'ADMIN', 'saa', 'saad', 1, 'saad', 123, NULL, 1, 123, 'Y', 5, NULL, 'Y', '2017-04-01 15:33:11', 'ADMIN'),
(87, 'ADMIN', 'saad', 'saad', 1, 'saad', 123, NULL, 1, 123, 'Y', 5, NULL, 'Y', '2017-04-01 15:38:54', 'ADMIN'),
(88, 'ADMIN', 'saad', 'saad', 1, 'saad', 123, NULL, 2, 123, 'Y', 5, NULL, 'Y', '2017-04-01 15:39:54', 'ADMIN'),
(89, 'ADMIN', 'Center of Fulda', 'A beautiful location', 1, 'Frankfurterstrasse', 33210, NULL, 1, 200, 'N', 5, NULL, 'Y', '2017-04-03 00:41:28', 'ADMIN'),
(90, 'ADMIN', 'Platz', 'Seth gut Platz', 1, 'Strasse', 12345, NULL, 2, 200, 'Y', 5, NULL, 'Y', '2017-04-03 08:44:50', 'ADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(10) NOT NULL,
  `FULL_NAME` varchar(30) DEFAULT NULL,
  `EMAIL` varchar(250) NOT NULL,
  `PASSWORD` varchar(40) NOT NULL,
  `USER_TYPE_ID` int(10) DEFAULT '4',
  `ACTIVE` char(1) NOT NULL DEFAULT 'Y',
  `PHONE` varchar(50) DEFAULT NULL,
  `MOBILE` varchar(50) DEFAULT NULL,
  `LOCATION` varchar(150) DEFAULT NULL,
  `CREATED_DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `FULL_NAME`, `EMAIL`, `PASSWORD`, `USER_TYPE_ID`, `ACTIVE`, `PHONE`, `MOBILE`, `LOCATION`, `CREATED_DATE`) VALUES
(33, 'saad', 'saad', '202cb962ac59075b964b07152d234b70', 4, 'Y', NULL, NULL, NULL, '2017-04-01 14:22:23'),
(34, 'land', 'land', '202cb962ac59075b964b07152d234b70', 15, 'Y', NULL, NULL, NULL, '2017-04-01 14:23:48'),
(35, 'user', 'user', '202cb962ac59075b964b07152d234b70', 4, 'Y', NULL, NULL, NULL, '2017-04-01 15:26:21'),
(36, 'Gondal', 'gondal@hotmail.com', '202cb962ac59075b964b07152d234b70', 15, 'Y', NULL, NULL, NULL, '2017-04-03 00:39:37'),
(37, 'saad', 'saad@hotmail.com', '202cb962ac59075b964b07152d234b70', 15, 'Y', NULL, NULL, NULL, '2017-04-03 08:44:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buyer`
--
ALTER TABLE `buyer`
  ADD KEY `USER_ID` (`USER_ID`),
  ADD KEY `COUNTRY_ID` (`COUNTRY_ID`);

--
-- Indexes for table `defination_type`
--
ALTER TABLE `defination_type`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `defination_type_detail`
--
ALTER TABLE `defination_type_detail`
  ADD PRIMARY KEY (`ID`,`DEF_ID`),
  ADD KEY `DEF_ID` (`DEF_ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `image_uploads`
--
ALTER TABLE `image_uploads`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD UNIQUE KEY `ID_2` (`ID`),
  ADD KEY `IMAGE_NAME` (`IMAGE_NAME`),
  ADD KEY `PROPERTY_ID` (`PROPERTY_ID`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD UNIQUE KEY `ID_2` (`ID`),
  ADD KEY `USER_ID` (`USER_ID`),
  ADD KEY `PROP_TYPE_ID` (`PROP_TYPE_ID`),
  ADD KEY `STATUS_ID` (`STATUS_ID`),
  ADD KEY `CREATED_DATE` (`CREATED_DATE`),
  ADD KEY `ADDRESS` (`ADDRESS`),
  ADD KEY `PRICE` (`PRICE`),
  ADD KEY `DESCRIPTION` (`DESCRIPTION`),
  ADD KEY `TITLE` (`TITLE`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `id` (`ID`,`EMAIL`),
  ADD UNIQUE KEY `email` (`EMAIL`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `defination_type`
--
ALTER TABLE `defination_type`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `defination_type_detail`
--
ALTER TABLE `defination_type_detail`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `image_uploads`
--
ALTER TABLE `image_uploads`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
