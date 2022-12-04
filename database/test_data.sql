-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: borealis
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `code` varchar(9) NOT NULL,
  `name` varchar(100) NOT NULL,
  `descr` varchar(1000) NOT NULL DEFAULT '',
  `credits` decimal(2,1) NOT NULL DEFAULT '3.0',
  PRIMARY KEY (`code`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `courses_credits_min` CHECK ((`credits` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('ACC-1010','Intro to Financial Accounting','',3.0),('ACC-1020','Intro to Managerial Accounting','',3.0),('CHEM-3370','Cool and Dangerous Chemicals','',4.5),('COMP-1010','Intro to Computer Science 1','',3.0),('COMP-1020','Intro to Computer Science 2','',3.0),('COMP-2140','Data Structures and Algorithms','',3.0),('ECON-1010','Intro to Microeconomics','',3.0),('ECON-1020','Intro to Macroeconomics','',3.0),('ECON-2300','Monetary Policy','',3.0),('ECON-2400','Fiscal Policy, Taxation, and Government','',3.0),('ENG-4999','Engineering Capstone Project','',5.0),('HIST-1411','Canadian History, 1604-1867','',3.0),('HIST-1412','Canadian History, 1867-present','',3.0),('HIST-4800','Seminar on 20th Century Global Wars','',3.0),('MATH-1100','Calculus 1','',3.0),('MATH-1200','Calculus 2','',3.0),('MATH-1300','Intro to Linear Algebra','',3.0),('MATH-2200','Multivariable Calculus','',3.0),('MATH-2205','Multivariable Calculus (Advanced)','',4.5),('MATH-3440','Miscellaneous Topics in Graph Theory','',2.0),('SCI-2000','Practices in Scientific Research','',1.5);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `get_all_courses`
--

DROP TABLE IF EXISTS `get_all_courses`;
/*!50001 DROP VIEW IF EXISTS `get_all_courses`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `get_all_courses` AS SELECT 
 1 AS `code`,
 1 AS `name`,
 1 AS `descr`,
 1 AS `credits`,
 1 AS `num_sections`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `get_all_sections`
--

DROP TABLE IF EXISTS `get_all_sections`;
/*!50001 DROP VIEW IF EXISTS `get_all_sections`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `get_all_sections` AS SELECT 
 1 AS `section_code`,
 1 AS `name`,
 1 AS `start_date`,
 1 AS `end_date`,
 1 AS `start_time`,
 1 AS `end_time`,
 1 AS `weekdays`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `section_code` varchar(13) GENERATED ALWAYS AS (concat(`course_code`,_utf8mb4'-',`type`,`num`)) STORED NOT NULL,
  `course_code` varchar(9) NOT NULL,
  `type` enum('A','B','D') NOT NULL DEFAULT 'A',
  `num` tinyint unsigned NOT NULL DEFAULT '1',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `weekdays` set('Mon','Tue','Wed','Thu','Fri','Sat','Sun') DEFAULT NULL,
  PRIMARY KEY (`section_code`),
  KEY `sections_fk_course_code` (`course_code`),
  CONSTRAINT `sections_fk_course_code` FOREIGN KEY (`course_code`) REFERENCES `courses` (`code`),
  CONSTRAINT `sections_check_dates` CHECK ((`start_date` <= `end_date`)),
  CONSTRAINT `sections_end_time_max` CHECK ((`end_time` < '24:00:00')),
  CONSTRAINT `sections_end_time_min` CHECK ((`end_time` >= '00:00:00')),
  CONSTRAINT `sections_num_max` CHECK ((`num` < 100)),
  CONSTRAINT `sections_start_time_max` CHECK ((`start_time` < '24:00:00')),
  CONSTRAINT `sections_start_time_min` CHECK ((`start_time` >= '00:00:00'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` (`course_code`, `type`, `num`, `start_date`, `end_date`, `start_time`, `end_time`, `weekdays`) VALUES ,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),'HIST-1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),'HIST-1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),'HIST-4800','A',1,'2022-01-09','2022-04-14','12:00:00','15:00:00','Mon'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),'HIST-1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),'HIST-4800','A',1,'2022-01-09','2022-04-14','12:00:00','15:00:00','Mon'),'HIST-4800','A',2,'2022-01-09','2022-04-14','12:00:00','15:00:00','Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),'HIST-1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),'HIST-4800','A',1,'2022-01-09','2022-04-14','12:00:00','15:00:00','Mon'),'HIST-4800','A',2,'2022-01-09','2022-04-14','12:00:00','15:00:00','Fri'),'MATH-1100','A',1,'2022-01-09','2022-04-14','13:30:00','14:30:00','Mon,Wed,Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),'HIST-1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),'HIST-4800','A',1,'2022-01-09','2022-04-14','12:00:00','15:00:00','Mon'),'HIST-4800','A',2,'2022-01-09','2022-04-14','12:00:00','15:00:00','Fri'),'MATH-1100','A',1,'2022-01-09','2022-04-14','13:30:00','14:30:00','Mon,Wed,Fri'),'MATH-1200','A',1,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Thu'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),'HIST-1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),'HIST-4800','A',1,'2022-01-09','2022-04-14','12:00:00','15:00:00','Mon'),'HIST-4800','A',2,'2022-01-09','2022-04-14','12:00:00','15:00:00','Fri'),'MATH-1100','A',1,'2022-01-09','2022-04-14','13:30:00','14:30:00','Mon,Wed,Fri'),'MATH-1200','A',1,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Thu'),'MATH-1200','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Tue,Fri'),,'ACC-1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),'ACC-1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),'ACC-1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),'ACC-1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),'ACC-1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),'CHEM-3370','B',1,'2023-02-01','2023-02-28',NULL,NULL,'Tue,Thu'),'CHEM-3370','B',2,NULL,NULL,NULL,NULL,NULL),'COMP-1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),'COMP-1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),'COMP-1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),'COMP-2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),'ECON-2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),'ECON-2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),'ECON-2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),'ECON-2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),'HIST-1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),'HIST-1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),'HIST-4800','A',1,'2022-01-09','2022-04-14','12:00:00','15:00:00','Mon'),'HIST-4800','A',2,'2022-01-09','2022-04-14','12:00:00','15:00:00','Fri'),'MATH-1100','A',1,'2022-01-09','2022-04-14','13:30:00','14:30:00','Mon,Wed,Fri'),'MATH-1200','A',1,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Thu'),'MATH-1200','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Tue,Fri'),'SCI-2000','A',1,'2022-01-09','2022-04-14','09:00:00','12:00:00','Sat');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_regist`
--

DROP TABLE IF EXISTS `student_regist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_regist` (
  `student_id` int unsigned NOT NULL,
  `section_id` varchar(13) NOT NULL,
  KEY `student_regist_fk_student_id` (`student_id`),
  KEY `student_regist_fk_section_id` (`section_id`),
  CONSTRAINT `student_regist_fk_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_code`),
  CONSTRAINT `student_regist_fk_student_id` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_regist`
--

LOCK TABLES `student_regist` WRITE;
/*!40000 ALTER TABLE `student_regist` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_regist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int unsigned NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1867,'John A.','MacDonald'),(1873,'Alexander','Mackenzie'),(1896,'Wilfrid','Laurier'),(1911,'Robert','Borden'),(1921,'William L.M.','King');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `get_all_courses`
--

/*!50001 DROP VIEW IF EXISTS `get_all_courses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `get_all_courses` AS select `c`.`code` AS `code`,`c`.`name` AS `name`,`c`.`descr` AS `descr`,`c`.`credits` AS `credits`,count(`s`.`section_code`) AS `num_sections` from (`courses` `c` left join `sections` `s` on((`s`.`course_code` = `c`.`code`))) group by `c`.`code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `get_all_sections`
--

/*!50001 DROP VIEW IF EXISTS `get_all_sections`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `get_all_sections` AS select `s`.`section_code` AS `section_code`,`c`.`name` AS `name`,`s`.`start_date` AS `start_date`,`s`.`end_date` AS `end_date`,`s`.`start_time` AS `start_time`,`s`.`end_time` AS `end_time`,`s`.`weekdays` AS `weekdays` from (`sections` `s` join `courses` `c` on((`s`.`course_code` = `c`.`code`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-03 23:26:42
