-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: BAR
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bar`
--

DROP DATABASE IF EXISTS `BAR`;
CREATE SCHEMA `BAR`;
USE `BAR`;

DROP TABLE IF EXISTS `bar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bar` (
  `bid` int(11) NOT NULL,
  `bname` varchar(100) NOT NULL,
  `adress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bar`
--

LOCK TABLES `bar` WRITE;
/*!40000 ALTER TABLE `bar` DISABLE KEYS */;
INSERT INTO `bar` VALUES (1,'turbo bar','gachibowli,hyderabad'),(2,'speed bar','kondapur,hyderabad');
/*!40000 ALTER TABLE `bar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bar_manager`
--

DROP TABLE IF EXISTS `bar_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bar_manager` (
  `bid` int(11) NOT NULL,
  `mname` varchar(100) NOT NULL,
  `dname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bid`,`mname`),
  KEY `dname` (`dname`),
  CONSTRAINT `bar_manager_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`),
  CONSTRAINT `bar_manager_ibfk_2` FOREIGN KEY (`dname`) REFERENCES `drinks` (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bar_manager`
--

LOCK TABLES `bar_manager` WRITE;
/*!40000 ALTER TABLE `bar_manager` DISABLE KEYS */;
INSERT INTO `bar_manager` VALUES (1,'raj','tuborg green'),(2,'raj','tuborg green'),(1,'rohan','tuborg strong');
/*!40000 ALTER TABLE `bar_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barcontact`
--

DROP TABLE IF EXISTS `barcontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barcontact` (
  `bid` int(11) NOT NULL,
  `contactno` varchar(100) NOT NULL,
  PRIMARY KEY (`bid`,`contactno`),
  CONSTRAINT `barcontact_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barcontact`
--

LOCK TABLES `barcontact` WRITE;
/*!40000 ALTER TABLE `barcontact` DISABLE KEYS */;
INSERT INTO `barcontact` VALUES (1,'1231231231'),(2,'1234123412');
/*!40000 ALTER TABLE `barcontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custguard`
--

DROP TABLE IF EXISTS `custguard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custguard` (
  `cid` int(11) NOT NULL,
  `gname` varchar(100) NOT NULL,
  `contactno` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`,`gname`,`contactno`),
  CONSTRAINT `custguard_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custguard`
--

LOCK TABLES `custguard` WRITE;
/*!40000 ALTER TABLE `custguard` DISABLE KEYS */;
INSERT INTO `custguard` VALUES (1,'john','1886655552'),(1,'john','987654321'),(2,'mclaine','123456789');
/*!40000 ALTER TABLE `custguard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `fav_drinkname` varchar(100) DEFAULT NULL,
  `dob` date NOT NULL,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'tuborg strong','2000-11-12','barry','allen'),(2,'tuborg green','1995-01-01','bruce','wayne');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinks`
--

DROP TABLE IF EXISTS `drinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drinks` (
  `dname` varchar(100) NOT NULL,
  `maxdem_bid` int(11) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `winebrand` varchar(100) DEFAULT NULL,
  `beerbrand` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinks`
--

LOCK TABLES `drinks` WRITE;
/*!40000 ALTER TABLE `drinks` DISABLE KEYS */;
INSERT INTO `drinks` VALUES ('tuborg green',2,2000,'','tuborg'),('tuborg strong',1,1000,'','tuborg');
/*!40000 ALTER TABLE `drinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinktrans`
--

DROP TABLE IF EXISTS `drinktrans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drinktrans` (
  `dname` varchar(100) NOT NULL,
  `mname` varchar(100) NOT NULL,
  `bid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  PRIMARY KEY (`cid`,`bid`,`mname`,`dname`),
  KEY `bid` (`bid`,`mname`),
  KEY `dname` (`dname`),
  CONSTRAINT `drinktrans_ibfk_1` FOREIGN KEY (`bid`, `mname`) REFERENCES `bar_manager` (`bid`, `mname`),
  CONSTRAINT `drinktrans_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`),
  CONSTRAINT `drinktrans_ibfk_3` FOREIGN KEY (`dname`) REFERENCES `drinks` (`dname`),
  CONSTRAINT `drinktrans_ibfk_4` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinktrans`
--

LOCK TABLES `drinktrans` WRITE;
/*!40000 ALTER TABLE `drinktrans` DISABLE KEYS */;
INSERT INTO `drinktrans` VALUES ('tuborg green','raj',2,2),('tuborg strong','rohan',1,1);
/*!40000 ALTER TABLE `drinktrans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lovestogoto`
--

DROP TABLE IF EXISTS `lovestogoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lovestogoto` (
  `cid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  PRIMARY KEY (`cid`,`bid`),
  KEY `bid` (`bid`),
  CONSTRAINT `lovestogoto_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`),
  CONSTRAINT `lovestogoto_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lovestogoto`
--

LOCK TABLES `lovestogoto` WRITE;
/*!40000 ALTER TABLE `lovestogoto` DISABLE KEYS */;
INSERT INTO `lovestogoto` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `lovestogoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mancontact`
--

DROP TABLE IF EXISTS `mancontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mancontact` (
  `bid` int(11) NOT NULL,
  `mname` varchar(100) NOT NULL,
  `contactno` varchar(100) NOT NULL,
  PRIMARY KEY (`bid`,`mname`,`contactno`),
  CONSTRAINT `mancontact_ibfk_1` FOREIGN KEY (`bid`, `mname`) REFERENCES `bar_manager` (`bid`, `mname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mancontact`
--

LOCK TABLES `mancontact` WRITE;
/*!40000 ALTER TABLE `mancontact` DISABLE KEYS */;
INSERT INTO `mancontact` VALUES (1,'rohan','1231231231'),(2,'raj','1234123412');
/*!40000 ALTER TABLE `mancontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oldcust`
--

DROP TABLE IF EXISTS `oldcust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oldcust` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oldcust`
--

LOCK TABLES `oldcust` WRITE;
/*!40000 ALTER TABLE `oldcust` DISABLE KEYS */;
/*!40000 ALTER TABLE `oldcust` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-12  2:52:26
