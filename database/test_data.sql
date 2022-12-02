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
INSERT INTO `courses` VALUES ('ACC 1010','Intro to Financial Accounting','',3.0),('ACC 1020','Intro to Managerial Accounting','',3.0),('COMP 1010','Intro to Computer Science 1','',3.0),('COMP 1020','Intro to Computer Science 2','',3.0),('COMP 2140','Data Structures and Algorithms','',3.0),('ECON 1010','Intro to Microeconomics','',3.0),('ECON 1020','Intro to Macroeconomics','',3.0),('ECON 2300','Monetary Policy','',3.0),('ECON 2400','Fiscal Policy, Taxation, and Government','',3.0),('ENG 4999','Engineering Capstone Project','',5.0),('HIST 1411','Canadian History, 1604-1867','',3.0),('HIST 1412','Canadian History, 1867-present','',3.0),('HIST 4800','Seminar on 20th Century Global Wars','',3.0),('MATH 1100','Calculus 1','',3.0),('MATH 1200','Calculus 2','',3.0),('MATH 1300','Intro to Linear Algebra','',3.0),('MATH 2200','Multivariable Calculus','',3.0),('MATH 2205','Multivariable Calculus (Advanced)','',4.5),('MATH 3440','Miscellaneous Topics in Graph Theory','',2.0),('SCI 2000','Practices in Scientific Research','',1.5);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `course` varchar(9) NOT NULL,
  `type` enum('A','B','D') NOT NULL DEFAULT 'A',
  `num` tinyint unsigned NOT NULL DEFAULT '1',
  `code` varchar(13) GENERATED ALWAYS AS (concat(`course`,_utf8mb4' ',`type`,`num`)) STORED,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `weekdays` set('Mon','Tue','Wed','Thu','Fri','Sat','Sun') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `course` (`course`),
  CONSTRAINT `sections_fk_course_code` FOREIGN KEY (`course`) REFERENCES `courses` (`code`),
  CONSTRAINT `sections_check_dates` CHECK ((`start_date` <= `end_date`)),
  CONSTRAINT `sections_end_time_max` CHECK ((`end_time` < '24:00:00')),
  CONSTRAINT `sections_end_time_min` CHECK ((`end_time` >= '00:00:00')),
  CONSTRAINT `sections_num_max` CHECK ((`num` < 100)),
  CONSTRAINT `sections_start_time_max` CHECK ((`start_time` < '24:00:00')),
  CONSTRAINT `sections_start_time_min` CHECK ((`start_time` >= '00:00:00'))
) ENGINE=InnoDB AUTO_INCREMENT=10028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` (`id`, `course`, `type`, `num`, `start_date`, `end_date`, `start_time`, `end_time`, `weekdays`) VALUES (10007,'ACC 1010','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Wed'),(10008,'ACC 1010','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Wed'),(10009,'ACC 1010','B',1,'2022-01-09','2022-04-14','10:00:00','11:30:00','Fri'),(10010,'ACC 1010','B',2,'2022-01-09','2022-04-14','12:30:00','14:00:00','Fri'),(10011,'ACC 1010','B',3,'2022-01-09','2022-04-14','15:00:00','16:30:00','Fri'),(10012,'COMP 1010','A',1,'2022-01-09','2022-04-14','08:30:00','09:30:00','Mon,Wed,Fri'),(10013,'COMP 1010','A',2,'2022-01-09','2022-04-14','12:00:00','13:30:00','Tue,Thu'),(10014,'COMP 1020','A',1,'2022-01-09','2022-04-14','10:30:00','12:00:00','Mon,Wed,Fri'),(10015,'COMP 2140','A',1,'2022-01-09','2022-04-14','12:00:00','14:00:00','Tue,Fri'),(10016,'ECON 2300','A',1,'2022-01-09','2022-04-14','18:00:00','21:00:00','Thu'),(10017,'ECON 2300','A',2,'2022-01-09','2022-04-14','18:00:00','21:00:00','Fri'),(10018,'ECON 2400','A',1,'2022-01-09','2022-04-14','13:00:00','14:30:00','Mon,Fri'),(10019,'ECON 2400','A',2,'2022-01-09','2022-04-14','13:00:00','14:30:00','Tue,Thu'),(10020,'HIST 1411','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Wed,Fri'),(10021,'HIST 1412','A',1,'2022-01-09','2022-04-14','15:30:00','17:00:00','Tue,Thu'),(10022,'HIST 4800','A',1,'2022-01-09','2022-04-14','12:00:00','15:00:00','Mon'),(10023,'HIST 4800','A',2,'2022-01-09','2022-04-14','12:00:00','15:00:00','Fri'),(10024,'MATH 1100','A',1,'2022-01-09','2022-04-14','13:30:00','14:30:00','Mon,Wed,Fri'),(10025,'MATH 1200','A',1,'2022-01-09','2022-04-14','08:30:00','10:00:00','Mon,Thu'),(10026,'MATH 1200','A',2,'2022-01-09','2022-04-14','08:30:00','10:00:00','Tue,Fri'),(10027,'SCI 2000','A',1,'2022-01-09','2022-04-14','09:00:00','12:00:00','Sat');
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
  `section_id` int unsigned NOT NULL,
  KEY `student_regist_fk_student_id` (`student_id`),
  KEY `student_regist_fk_section_id` (`section_id`),
  CONSTRAINT `student_regist_fk_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`),
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-02 12:50:34
