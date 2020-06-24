-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 24, 2020 at 01:26 AM
-- Server version: 5.7.30
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smileyli_skyBus`
--

-- --------------------------------------------------------

--
-- Table structure for table `PAYMENT`
--

CREATE TABLE `PAYMENT` (
  `ORDERID` varchar(50) NOT NULL,
  `BILLID` varchar(50) NOT NULL,
  `USERID` varchar(50) NOT NULL,
  `TOTAL` varchar(50) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PAYMENT`
--

INSERT INTO `PAYMENT` (`ORDERID`, `BILLID`, `USERID`, `TOTAL`, `DATE`) VALUES
('inn-20062020-6UQ66K', 'gzzt28be', 'winniejia0103@gmail.com', '9.20', '2020-06-20 20:42:07'),
('inn-20062020-032456', 'cxslfb8v', 'winniejia0103@gmail.com', '9.20', '2020-06-20 20:45:36'),
('inn-20062020-B85DFD', 'rwhgeu2j', 'winniejia0103@gmail.com', '55.20', '2020-06-20 20:51:25'),
('inn-20062020-t62Dia', 'fvwrm9xd', 'winniejia0103@gmail.com', '32.40', '2020-06-20 21:23:35'),
('inn-20062020-R5226F', 'yflhc20g', 'winniejia0103@gmail.com', '10.00', '2020-06-20 21:43:04'),
('inn-20062020-l6nL42', 'pkecwepy', 'winniejia0103@gmail.com', '44.60', '2020-06-20 22:25:26'),
('inn-20062020-1338Y1', 'u5nhmrtl', 'winniejia0103@gmail.com', '13.80', '2020-06-20 22:26:20'),
('inn-20062020-8d3M7T', 'lppvwykx', 'winniejia0103@gmail.com', '40.00', '2020-06-20 23:02:17'),
('inn-20062020-Hd850N', '1irv09ng', 'winniejia0103@gmail.com', '9.20', '2020-06-20 23:09:24'),
('inn-20062020-Po1M32', 'f2cm0nbf', 'winniejia0103@gmail.com', '85.60', '2020-06-21 00:06:48'),
('inn-21062020-7050R4', 'm0szjojm', 'winniejia0103@gmail.com', '15.00', '2020-06-21 11:35:41'),
('inn-21062020-7x6QSV', '3q8m5ids', 'winniejia0103@gmail.com', '21.60', '2020-06-21 20:25:56'),
('inn-21062020-02B7om', 'nnwqahvo', 'winniejia0103@gmail.com', '9.20', '2020-06-21 22:43:48'),
('inn-21062020-Y5F0PI', 'nqbdgsad', 'winniejia0103@gmail.com', '4.60', '2020-06-21 23:10:59'),
('inn-21062020-4V7688', 'kpjksz5v', 'winniejia0103@gmail.com', '13.80', '2020-06-22 16:01:32'),
('inn-22062020-K5ofH7', '8dbxpkjm', 'winniejia0103@gmail.com', '4.60', '2020-06-22 18:59:31'),
('inn-22062020-1thkuH', 'hmatasaf', 'winniejia0103@gmail.com', '10.80', '2020-06-22 20:55:27'),
('uhu-23062020-6CU67s', 'teg9lksp', 'huhu980606@gmail.com', '9.20', '2020-06-23 12:58:25'),
('uhu-23062020-jfj3Ce', 'vwsatqtd', 'huhu980606@gmail.com', '9.20', '2020-06-23 13:08:02'),
('uhu-23062020-120311', 'xh1057eu', 'huhu980606@gmail.com', '5.00', '2020-06-23 13:22:12');

-- --------------------------------------------------------

--
-- Table structure for table `SCHEDULE`
--

CREATE TABLE `SCHEDULE` (
  `ID` varchar(10) NOT NULL,
  `DEPARTURE_STATION` varchar(50) NOT NULL,
  `ARRIVAL_STATION` varchar(50) NOT NULL,
  `DEPARTURE_TIME` varchar(30) NOT NULL,
  `ARRIVAL_TIME` varchar(30) NOT NULL,
  `PRICE` varchar(20) NOT NULL,
  `COMPANY` varchar(20) NOT NULL,
  `QUANTITY` varchar(20) NOT NULL,
  `SOLD` varchar(20) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SCHEDULE`
--

INSERT INTO `SCHEDULE` (`ID`, `DEPARTURE_STATION`, `ARRIVAL_STATION`, `DEPARTURE_TIME`, `ARRIVAL_TIME`, `PRICE`, `COMPANY`, `QUANTITY`, `SOLD`, `DATE`) VALUES
('R7', 'BATU PAHAT ', 'JOHOR BAHRU', '07:00', '09:00', '11.70', 'S&S EXPRESS', '20', '0', '2020-06-21 16:19:46'),
('R8', 'BATU PAHAT', 'JOHOR BAHRU', '10:00', '11:45', '11.00', 'CAUSEWAY LINK', '20', '0', '2020-06-21 16:19:46'),
('R9', 'KLUANG', 'BATU PAHAT', '08:00', '09:30', '5.00', 'S&S EXPRESS', '20', '0', '2020-06-21 16:19:46'),
('R1', 'JOHOR BAHRU', 'KLUANG', '07:30', '09:00', '10.80', 'S&S EXPRESS', '19', '1', '2020-06-21 16:19:46'),
('R10', 'KLUANG', 'BATU PAHAT', '16:00', '17:30', '4.60', 'CEPAT EXPRESS', '18', '2', '2020-06-21 16:19:46'),
('R2', 'JOHOR BAHRU', 'KLUANG', '10:00', '12:00', '10.80', 'S&S EXPRESS', '20', '0', '2020-06-21 16:19:46'),
('R3', 'JOHOR BAHRU', 'BATU PAHAT', '07:00', '09:00', '11.70', 'S&S EXPRESS', '20', '0', '2020-06-21 16:19:46'),
('R4', 'JOHOR BAHRU', 'BATU PAHAT', '15:00', '16:45', '11.00', 'CAUSEWAY LINK', '20', '0', '2020-06-21 16:19:46'),
('R5', 'KLUANG ', 'JOHOR BAHRU', '07:00', '08:30', '10.80', 'S&S EXPRESS', '20', '0', '2020-06-21 16:19:46'),
('R6', 'KLUANG', 'JOHOR BAHRU', '09:00', '10.30', '12.00', 'KKKL EXPRESS', '20', '0', '2020-06-21 16:19:46'),
('R11', 'BATU PAHAT ', 'KLUANG', '10:00', '11:30', '4.60', 'CEPAT EXPRESS', '18', '2', '2020-06-21 16:19:46'),
('R12', 'BATU PAHAT', 'KLUANG', '18:00', '19:30', '5.00', 'S&S EXPRESS', '19', '1', '2020-06-21 16:19:46');

-- --------------------------------------------------------

--
-- Table structure for table `TICKET`
--

CREATE TABLE `TICKET` (
  `EMAIL` varchar(30) NOT NULL,
  `BUSID` varchar(10) NOT NULL,
  `BQUANTITY` varchar(20) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `TICKETHISTORY`
--

CREATE TABLE `TICKETHISTORY` (
  `EMAIL` varchar(50) NOT NULL,
  `ORDERID` varchar(50) NOT NULL,
  `BILLID` varchar(50) NOT NULL,
  `BUSID` varchar(50) NOT NULL,
  `BQUANTITY` varchar(50) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `TICKETHISTORY`
--

INSERT INTO `TICKETHISTORY` (`EMAIL`, `ORDERID`, `BILLID`, `BUSID`, `BQUANTITY`, `DATE`) VALUES
('huhu980606@gmail.com', 'uhu-23062020-120311', 'xh1057eu', 'R12', '1', '2020-06-23 13:22:12'),
('huhu980606@gmail.com', 'uhu-23062020-jfj3Ce', 'vwsatqtd', 'R11', '1', '2020-06-23 13:08:02'),
('huhu980606@gmail.com', 'uhu-23062020-jfj3Ce', 'vwsatqtd', 'R10', '1', '2020-06-23 13:08:02'),
('huhu980606@gmail.com', 'uhu-23062020-6CU67s', 'teg9lksp', 'R10', '1', '2020-06-23 12:58:25'),
('huhu980606@gmail.com', 'uhu-23062020-6CU67s', 'teg9lksp', 'R11', '1', '2020-06-23 12:58:25');

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `NAME` varchar(50) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PHONE` varchar(11) NOT NULL,
  `CREDIT` varchar(40) NOT NULL,
  `PASSWORD` varchar(60) NOT NULL,
  `VERIFY` varchar(1) NOT NULL,
  `DATEREG` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`NAME`, `EMAIL`, `PHONE`, `CREDIT`, `PASSWORD`, `VERIFY`, `DATEREG`) VALUES
('yy', 'huhu980606@gmail.com', '1111111111', '10', '7c4a8d09ca3762af61e59520943dc26494f8941b', '1', '2020-06-20 10:04:25'),
('pp', 'ulaleejiajia0103@gmail.com', '5555555555', '10', '7c4a8d09ca3762af61e59520943dc26494f8941b', '1', '2020-06-20 10:04:25'),
('oh', 'winniejia0103@gmail.com', '0111111111', '10', '7c4a8d09ca3762af61e59520943dc26494f8941b', '1', '2020-06-20 10:25:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `SCHEDULE`
--
ALTER TABLE `SCHEDULE`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`EMAIL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
