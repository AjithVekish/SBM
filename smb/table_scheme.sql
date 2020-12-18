-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: sbm
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Current Database: `sbm`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sbm` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sbm`;

--
-- Table structure for table `attendance_time`
--

DROP TABLE IF EXISTS `attendance_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_time` (
  `time_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attendance_id` int(11) NOT NULL,
  `attendance_time` varchar(12) NOT NULL,
  `status` enum('IN','OUT') NOT NULL DEFAULT 'OUT',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`time_id`),
  UNIQUE KEY `attendance_id` (`attendance_id`,`attendance_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_time`
--

LOCK TABLES `attendance_time` WRITE;
/*!40000 ALTER TABLE `attendance_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_attendance`
--

DROP TABLE IF EXISTS `daily_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_attendance` (
  `attendance_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rfid` varchar(52) DEFAULT NULL,
  `student_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `stop_id` int(11) NOT NULL,
  `daily_date` varchar(22) NOT NULL,
  `status` enum('IN','OUT','LEV','DONE') NOT NULL DEFAULT 'OUT',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`attendance_id`),
  UNIQUE KEY `rfid` (`rfid`,`daily_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_attendance`
--

LOCK TABLES `daily_attendance` WRITE;
/*!40000 ALTER TABLE `daily_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_schedule`
--

DROP TABLE IF EXISTS `daily_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_schedule` (
  `schedule_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `start_date` varchar(20) NOT NULL,
  `end_date` varchar(20) NOT NULL,
  `img_url` varchar(52) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `stop_id` int(11) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_schedule`
--

LOCK TABLES `daily_schedule` WRITE;
/*!40000 ALTER TABLE `daily_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `map_route_stop`
--

DROP TABLE IF EXISTS `map_route_stop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_route_stop` (
  `map_id` int(11) NOT NULL AUTO_INCREMENT,
  `route_id` int(11) NOT NULL,
  `stop_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`map_id`),
  UNIQUE KEY `route_id` (`route_id`,`stop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_route_stop`
--

LOCK TABLES `map_route_stop` WRITE;
/*!40000 ALTER TABLE `map_route_stop` DISABLE KEYS */;
/*!40000 ALTER TABLE `map_route_stop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parent_image`
--

DROP TABLE IF EXISTS `parent_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parent_image` (
  `img_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `img_url` varchar(52) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`img_id`),
  UNIQUE KEY `parent_id` (`parent_id`,`img_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_image`
--

LOCK TABLES `parent_image` WRITE;
/*!40000 ALTER TABLE `parent_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `parent_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_bus`
--

DROP TABLE IF EXISTS `profile_bus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_bus` (
  `bus_id` int(11) NOT NULL,
  `bus_name` varchar(22) NOT NULL,
  `route_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `num_students` int(11) DEFAULT NULL,
  `latitude` varchar(22) DEFAULT NULL,
  `longitude` varchar(22) DEFAULT NULL,
  `nextstop_id` int(11) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`bus_id`),
  UNIQUE KEY `bus_id` (`bus_id`,`route_id`,`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_bus`
--

LOCK TABLES `profile_bus` WRITE;
/*!40000 ALTER TABLE `profile_bus` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_bus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_camera`
--

DROP TABLE IF EXISTS `profile_camera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_camera` (
  `camera_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `camera_ip` varchar(22) NOT NULL,
  `bus_id` int(11) DEFAULT NULL,
  `url` varchar(88) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`camera_id`),
  UNIQUE KEY `bus_id` (`bus_id`,`camera_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_camera`
--

LOCK TABLES `profile_camera` WRITE;
/*!40000 ALTER TABLE `profile_camera` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_camera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_parent`
--

DROP TABLE IF EXISTS `profile_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_parent` (
  `parent_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(12) NOT NULL,
  `active_student` int(11) DEFAULT NULL,
  `pwd` varchar(33) DEFAULT NULL,
  `otp` int(5) DEFAULT NULL,
  `img_url` varchar(52) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`parent_id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_parent`
--

LOCK TABLES `profile_parent` WRITE;
/*!40000 ALTER TABLE `profile_parent` DISABLE KEYS */;
INSERT INTO `profile_parent` VALUES (1001,'8220783780',1,'BalVw9CmjZGHM',NULL,NULL,'2020-02-24 17:11:10',0);
/*!40000 ALTER TABLE `profile_parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_route`
--

DROP TABLE IF EXISTS `profile_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `route_name` varchar(55) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`route_id`),
  UNIQUE KEY `route_name` (`route_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_route`
--

LOCK TABLES `profile_route` WRITE;
/*!40000 ALTER TABLE `profile_route` DISABLE KEYS */;
INSERT INTO `profile_route` VALUES (1,'Route1','2020-02-11 18:57:36',0);
/*!40000 ALTER TABLE `profile_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_staff`
--

DROP TABLE IF EXISTS `profile_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_staff` (
  `staff_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bus_id` int(11) DEFAULT NULL,
  `phone_number` varchar(12) NOT NULL,
  `full_name` varchar(12) NOT NULL,
  `role` varchar(12) NOT NULL,
  `img_url` varchar(52) DEFAULT NULL,
  `pwd` varchar(250) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_staff`
--

LOCK TABLES `profile_staff` WRITE;
/*!40000 ALTER TABLE `profile_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_stop`
--

DROP TABLE IF EXISTS `profile_stop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_stop` (
  `stop_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stop_name` varchar(55) NOT NULL,
  `latitude` varchar(22) DEFAULT NULL,
  `longitude` varchar(22) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`stop_id`),
  UNIQUE KEY `stop_name` (`stop_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_stop`
--

LOCK TABLES `profile_stop` WRITE;
/*!40000 ALTER TABLE `profile_stop` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_stop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_student`
--

DROP TABLE IF EXISTS `profile_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_student` (
  `student_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `bus_id` int(11) DEFAULT NULL,
  `stop_id` int(11) DEFAULT NULL,
  `rfid` varchar(52) DEFAULT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `stop_name` varchar(55) DEFAULT NULL,
  `img_url` varchar(52) DEFAULT NULL,
  `gender` enum('Male','Female') NOT NULL DEFAULT 'Male',
  `date_of_birth` date DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `bus_id` (`bus_id`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_student`
--

LOCK TABLES `profile_student` WRITE;
/*!40000 ALTER TABLE `profile_student` DISABLE KEYS */;
INSERT INTO `profile_student` VALUES (1,1001,1001,1,'1234.12.34.5.5.66','Ajith','Vaikundam','','Male','0000-00-00','2020-02-24 17:06:56',0);
/*!40000 ALTER TABLE `profile_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_auth` (
  `user_id` int(11) NOT NULL,
  `token` varchar(250) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_auth`
--

LOCK TABLES `user_auth` WRITE;
/*!40000 ALTER TABLE `user_auth` DISABLE KEYS */;
INSERT INTO `user_auth` VALUES (1001,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IkJhbFZ3OUNtalpHSE0xMDAxMjAyMC0wMy0wMSAxMzozNjoxNiI.Yo6AFw2NMWN8m53mUY7gDtKXAvOBGClMTDtNPKbcFR4','2020-02-11 18:55:13');
/*!40000 ALTER TABLE `user_auth` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-17 16:16:58
