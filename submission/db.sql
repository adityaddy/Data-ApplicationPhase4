DROP DATABASE IF EXISTS `BAR`;
CREATE SCHEMA `BAR`;
USE `BAR`;

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `cid` int NOT NULL,
  `fav_drink_name` varchar(100) NULL,
  `dob` date NOT NULL,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `customer` WRITE;
INSERT INTO `customer` VALUES (1,'tuborg strong','2000-11-12','barry','allen'),(2,'tuborg green','1995-01-01','bruce','wayne');
UNLOCK TABLES;

DROP TABLE IF EXISTS `drinks`;
CREATE TABLE `drinks` (
  `dname` varchar(100) NOT NULL,
  `max_demand_bid` int NULL,
  `price` int NULL,
  `winebrand` varchar(100) NULL,
  `beerbrand` varchar(100) NULL,
  PRIMARY KEY (`dname`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `drinks` WRITE;
INSERT INTO `drinks` VALUES ('tuborg strong',1,1000,'','tuborg'),('tuborg green',2,2000,'','tuborg');
UNLOCK TABLES;

DROP TABLE IF EXISTS `bar_manager`;
CREATE TABLE `bar_manager` (
  `bid` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `dname` varchar(100) NULL,
  PRIMARY KEY (`bid`,`name`),
  CONSTRAINT `manages` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`),
  CONSTRAINT `sells` FOREIGN KEY (`dname`) REFERENCES `drinks` (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `bar_manager` WRITE;
INSERT INTO `bar_manager` VALUES (1,'rohan','tuborg strong'),(2,'raj','tuborg green');
UNLOCK TABLES;


DROP TABLE IF EXISTS `custguard`;
CREATE TABLE `custguard` (
  `cid` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `contactno` int NOT NULL,
  PRIMARY KEY (`cid`,`name`,`contactno`),
  CONSTRAINT `guards` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `custguard` WRITE;
INSERT INTO `custguard` VALUES (1,'john',8886655555),(1,'john',987654321),(2,'mclaine',123456789);
UNLOCK TABLES;



DROP TABLE IF EXISTS `bar`;
CREATE TABLE `bar` (
  `bid` int NOT NULL,
  `bname` varchar(100) NOT NULL,
  `address` varchar(100) NULL,
  PRIMARY KEY (`bid`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `bar` WRITE;
INSERT INTO `bar` VALUES (1,'turbo bar','gachibowli,hyderabad'),(2,'speed bar','kondapur,hyderabad');
UNLOCK TABLES;

DROP TABLE IF EXISTS `lovestogoto`;
CREATE TABLE `lovestogoto` (
  `cid` int NOT NULL,
  `bid` int NOT NULL,
  PRIMARY KEY (`cid`,`bid`),
  CONSTRAINT `cust` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`),
  CONSTRAINT `barr` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `lovestogoto` WRITE;
INSERT INTO `lovestogoto` VALUES (1,1),(2,2);
UNLOCK TABLES;

DROP TABLE IF EXISTS `drinktrans`;
CREATE TABLE `drinktrans` (
  `dname` varchar(100) NOT NULL,
  `mname` varchar(100) NOT NULL,
  `bid` int NOT NULL,
  `cid` int NOT NULL,
  PRIMARY KEY (`cid`,`bid`,`dname`,`mname`),
  CONSTRAINT `cust2` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`),
  CONSTRAINT `barr2` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`),
   CONSTRAINT `manages2` FOREIGN KEY (`mname`) REFERENCES `bar_manager` (`name`),
    CONSTRAINT `sells2` FOREIGN KEY (`dname`) REFERENCES `drinks` (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `drinktrans` WRITE;
INSERT INTO `drinktrans` VALUES ('turbo strong','rohan',1,1),('turbo green','raj',2,2);
UNLOCK TABLES;

DROP TABLE IF EXISTS `managercontact`;
CREATE TABLE `managercontact` (
  `bid` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `contactno` int NOT NULL,
  PRIMARY KEY (`name`,`bid`,`contactno`),
  CONSTRAINT `manages3` FOREIGN KEY (`name`) REFERENCES `bar_manager` (`name`),
  CONSTRAINT `barr3` FOREIGN KEY (`bid`) REFERENCES `bar_manager` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `managercontact` WRITE;
INSERT INTO `managercontact` VALUES (1,'rohan',123456789),(1,'rohan',123456783),(2,'raj',123456784);
UNLOCK TABLES;


DROP TABLE IF EXISTS `barcontact`;
CREATE TABLE `barcontact` (
  `bid` int NOT NULL,
  `contactno` int NOT NULL,
  PRIMARY KEY (`bid`,`contactno`),
  CONSTRAINT `barr4` FOREIGN KEY (`bid`) REFERENCES `bar` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `barcontact` WRITE;
INSERT INTO `barcontact` VALUES (1,1231231231),(2,1234123412);

DROP TABLE IF EXISTS `oldcust`;
CREATE TABLE `oldcust` (
  `cid` int NOT NULL,
  `fav_drink_name` varchar(100) NULL,
  `dob` date NOT NULL,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



