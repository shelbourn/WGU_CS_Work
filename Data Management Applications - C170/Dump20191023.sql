-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: localhost    Database: WGU
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CUSTOMER`
--

DROP TABLE IF EXISTS `CUSTOMER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER` (
  `CUS_CODE` decimal(10,0) NOT NULL,
  `CUS_LNAME` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `CUS_FNAME` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `CUS_INITIAL` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CUS_AREACODE` char(3) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '615',
  `CUS_PHONE` char(8) COLLATE utf8mb4_general_ci NOT NULL,
  `CUS_BALANCE` decimal(9,2) DEFAULT '0.00',
  PRIMARY KEY (`CUS_CODE`),
  UNIQUE KEY `CUS_UI1` (`CUS_LNAME`,`CUS_FNAME`),
  CONSTRAINT `customer_chk_1` CHECK ((`CUS_AREACODE` in (_utf8mb4'615',_utf8mb4'713',_utf8mb4'931')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER`
--

LOCK TABLES `CUSTOMER` WRITE;
/*!40000 ALTER TABLE `CUSTOMER` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVOICE`
--

DROP TABLE IF EXISTS `INVOICE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVOICE` (
  `INV_NUMBER` decimal(10,0) NOT NULL,
  `CUS_CODE` decimal(10,0) NOT NULL,
  `INV_DATE` date NOT NULL DEFAULT (_utf8mb4'01-01-2019'),
  PRIMARY KEY (`INV_NUMBER`),
  CONSTRAINT `INV_CK1` CHECK ((`INV_DATE` > cast(_utf8mb4'01-JAN-2016' as date)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVOICE`
--

LOCK TABLES `INVOICE` WRITE;
/*!40000 ALTER TABLE `INVOICE` DISABLE KEYS */;
/*!40000 ALTER TABLE `INVOICE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LINE`
--

DROP TABLE IF EXISTS `LINE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LINE` (
  `INV_NUMBER` decimal(10,0) NOT NULL,
  `LINE_NUMBER` decimal(2,0) NOT NULL,
  `P_CODE` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `LINE_UNITS` decimal(9,2) NOT NULL DEFAULT '0.00',
  `LINE_PRICE` decimal(9,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`INV_NUMBER`,`LINE_NUMBER`),
  UNIQUE KEY `LINE_UI1` (`INV_NUMBER`,`P_CODE`),
  KEY `P_CODE` (`P_CODE`),
  CONSTRAINT `line_ibfk_1` FOREIGN KEY (`INV_NUMBER`) REFERENCES `invoice` (`INV_NUMBER`) ON DELETE CASCADE,
  CONSTRAINT `line_ibfk_2` FOREIGN KEY (`P_CODE`) REFERENCES `product` (`P_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LINE`
--

LOCK TABLES `LINE` WRITE;
/*!40000 ALTER TABLE `LINE` DISABLE KEYS */;
/*!40000 ALTER TABLE `LINE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT`
--

DROP TABLE IF EXISTS `PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT` (
  `P_CODE` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `P_DESCRIPT` varchar(35) COLLATE utf8mb4_general_ci NOT NULL,
  `P_INDATE` date NOT NULL,
  `P_QOH` smallint(6) NOT NULL,
  `P_MIN` smallint(6) NOT NULL,
  `P_PRICE` decimal(8,2) NOT NULL,
  `P_DISCOUNT` decimal(5,2) NOT NULL,
  `V_CODE` int(11) DEFAULT NULL,
  PRIMARY KEY (`P_CODE`),
  UNIQUE KEY `P_CODE` (`P_CODE`),
  KEY `V_CODE` (`V_CODE`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`V_CODE`) REFERENCES `vendor` (`V_CODE`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT`
--

LOCK TABLES `PRODUCT` WRITE;
/*!40000 ALTER TABLE `PRODUCT` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VENDOR`
--

DROP TABLE IF EXISTS `VENDOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VENDOR` (
  `V_CODE` int(11) NOT NULL,
  `V_NAME` varchar(35) COLLATE utf8mb4_general_ci NOT NULL,
  `V_CONTACT` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  `V_AREACODE` char(3) COLLATE utf8mb4_general_ci NOT NULL,
  `V_PHONE` char(8) COLLATE utf8mb4_general_ci NOT NULL,
  `V_STATE` char(2) COLLATE utf8mb4_general_ci NOT NULL,
  `V_ORDER` char(1) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`V_CODE`),
  UNIQUE KEY `V_CODE` (`V_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VENDOR`
--

LOCK TABLES `VENDOR` WRITE;
/*!40000 ALTER TABLE `VENDOR` DISABLE KEYS */;
/*!40000 ALTER TABLE `VENDOR` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-23 14:22:25
