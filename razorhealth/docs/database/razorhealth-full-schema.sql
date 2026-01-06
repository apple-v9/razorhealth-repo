-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project_razor_health
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `rz_client_schedule_requests`
--

DROP TABLE IF EXISTS `rz_client_schedule_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_client_schedule_requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `contract_id` int NOT NULL,
  `request_type` enum('RESCHEDULE','CANCEL','PAUSE','RESUME') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `new_visit_days` varchar(100) DEFAULT NULL,
  `new_preferred_time` time DEFAULT NULL,
  `status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `reason` text,
  `requested_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `requested_by` varchar(100) DEFAULT NULL,
  `reviewed_by` int DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `admin_notes` text,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`request_id`),
  KEY `client_id` (`client_id`),
  KEY `contract_id` (`contract_id`),
  KEY `reviewed_by` (`reviewed_by`),
  CONSTRAINT `rz_client_schedule_requests_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `rz_clients` (`client_id`),
  CONSTRAINT `rz_client_schedule_requests_ibfk_2` FOREIGN KEY (`contract_id`) REFERENCES `rz_client_service_contract` (`contract_id`),
  CONSTRAINT `rz_client_schedule_requests_ibfk_3` FOREIGN KEY (`reviewed_by`) REFERENCES `rz_schedulers` (`scheduler_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_client_schedule_requests`
--

LOCK TABLES `rz_client_schedule_requests` WRITE;
/*!40000 ALTER TABLE `rz_client_schedule_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `rz_client_schedule_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_client_service_contract`
--

DROP TABLE IF EXISTS `rz_client_service_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_client_service_contract` (
  `contract_id` int NOT NULL AUTO_INCREMENT,
  `contract_code` varchar(100) NOT NULL,
  `client_id` int NOT NULL,
  `contract_type` enum('SHORT_TERM','LONG_TERM') NOT NULL,
  `service_start_date` date NOT NULL,
  `service_end_date` date NOT NULL,
  `status` enum('ACTIVE','PAUSED','ENDED') DEFAULT 'ACTIVE',
  `frequency_type` enum('DAILY','WEEKLY','BIWEEKLY') NOT NULL,
  `occurrences_per_period` int DEFAULT '1',
  `preferred_time` time DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `service_type` varchar(100) DEFAULT NULL,
  `preferred_worker_id` int DEFAULT NULL,
  `gender_preference` enum('MALE','FEMALE','NO_PREFERENCE') DEFAULT NULL,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`contract_id`),
  UNIQUE KEY `contract_code` (`contract_code`),
  KEY `fk_client_contract` (`client_id`),
  CONSTRAINT `fk_client_contract` FOREIGN KEY (`client_id`) REFERENCES `rz_clients` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_client_service_contract`
--

LOCK TABLES `rz_client_service_contract` WRITE;
/*!40000 ALTER TABLE `rz_client_service_contract` DISABLE KEYS */;
INSERT INTO `rz_client_service_contract` VALUES (1,'C1',1,'LONG_TERM','2026-01-06','2026-12-31','ACTIVE','WEEKLY',3,'10:00:00',60,'Personal Care',NULL,'NO_PREFERENCE','2025-10-04 21:28:05','2026-01-04 14:59:02');
/*!40000 ALTER TABLE `rz_client_service_contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_client_service_days`
--

DROP TABLE IF EXISTS `rz_client_service_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_client_service_days` (
  `service_day_id` int NOT NULL AUTO_INCREMENT,
  `contract_id` int NOT NULL,
  `day_of_week` enum('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY') NOT NULL,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`service_day_id`),
  KEY `fk_contract_days` (`contract_id`),
  CONSTRAINT `fk_contract_days` FOREIGN KEY (`contract_id`) REFERENCES `rz_client_service_contract` (`contract_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_client_service_days`
--

LOCK TABLES `rz_client_service_days` WRITE;
/*!40000 ALTER TABLE `rz_client_service_days` DISABLE KEYS */;
INSERT INTO `rz_client_service_days` VALUES (1,1,'MONDAY','2025-10-04 21:30:25','2025-10-04 21:30:25'),(2,1,'WEDNESDAY','2025-10-04 21:30:25','2025-10-04 21:30:25'),(3,1,'FRIDAY','2025-10-04 21:30:25','2025-10-04 21:30:25');
/*!40000 ALTER TABLE `rz_client_service_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_clients`
--

DROP TABLE IF EXISTS `rz_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `client_name` varchar(100) NOT NULL,
  `client_address` varchar(255) NOT NULL,
  `client_area` varchar(255) NOT NULL,
  `client_importance` enum('HIGH','MEDIUM','LOW') NOT NULL,
  `client_gender` enum('MALE','FEMALE') NOT NULL,
  `client_has_pet` tinyint(1) DEFAULT '0',
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_clients`
--

LOCK TABLES `rz_clients` WRITE;
/*!40000 ALTER TABLE `rz_clients` DISABLE KEYS */;
INSERT INTO `rz_clients` VALUES (1,'Alice Johnson','123 Main St, Burnaby','Burnaby','HIGH','FEMALE',0,'2025-10-04 19:10:36','2025-10-04 19:16:17'),(2,'Robert White','456 Maple Rd, Coquitlam','Coquitlam','MEDIUM','MALE',1,'2025-10-04 19:10:36','2025-10-04 19:16:17'),(3,'Sophie Chan','789 Oak Ave, Maple Ridge','Maple Ridge','LOW','FEMALE',0,'2025-10-04 19:10:36','2025-10-04 19:16:17'),(4,'Daniel Kim','321 Cedar St, Port Coquitlam','Port Coquitlam','HIGH','MALE',0,'2025-10-04 19:10:36','2025-10-04 19:16:17'),(5,'Emily Wong','654 Pine Rd, New Westminster','New Westminster','MEDIUM','FEMALE',1,'2025-10-04 19:10:36','2025-10-04 19:16:17');
/*!40000 ALTER TABLE `rz_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_employees`
--

DROP TABLE IF EXISTS `rz_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(100) NOT NULL,
  `employee_address` varchar(255) NOT NULL,
  `employee_area` varchar(255) NOT NULL,
  `employee_role` enum('WORKER','SCHEDULER','ADMIN') NOT NULL,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `employee_gender` enum('MALE','FEMALE','NONE') DEFAULT 'NONE',
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_employees`
--

LOCK TABLES `rz_employees` WRITE;
/*!40000 ALTER TABLE `rz_employees` DISABLE KEYS */;
INSERT INTO `rz_employees` VALUES (1,'John Lee','101 First St, Coquitlam','Coquitlam','WORKER','2025-10-04 20:25:26','2025-10-04 21:06:15','MALE'),(2,'Priya Patel','202 Second Ave, Burnaby','Burnaby','WORKER','2025-10-04 20:25:26','2025-10-04 21:06:15','FEMALE'),(3,'Michael Chen','303 Third Rd, Port Moody','Port Moody','WORKER','2025-10-04 20:25:26','2025-10-04 21:06:15','MALE'),(4,'Sara Singh','404 Fourth Ave, Burnaby','Burnaby','WORKER','2025-10-04 20:25:26','2025-10-04 21:06:15','FEMALE'),(5,'David Brown','505 Fifth St, Coquitlam','Coquitlam','WORKER','2025-10-04 20:25:26','2025-10-04 21:06:15','MALE'),(6,'Jane Doe','123 Main St, Burnaby','Burnaby','SCHEDULER','2025-10-04 20:25:26','2025-10-04 21:06:15','FEMALE'),(7,'Michael Smith','456 Maple Rd, Coquitlam','Coquitlam','SCHEDULER','2025-10-04 20:25:26','2025-10-04 21:06:15','MALE'),(8,'Priya Scheduler','789 Oak Ave, Port Moody','Port Moody','SCHEDULER','2025-10-04 20:25:26','2025-10-04 21:06:15','FEMALE'),(9,'David Scheduler','321 Pine St, New Westminster','New Westminster','SCHEDULER','2025-10-04 20:25:26','2025-10-04 21:06:15','MALE'),(10,'Sara Scheduler','654 Cedar Rd, Maple Ridge','Maple Ridge','SCHEDULER','2025-10-04 20:25:26','2025-10-04 21:06:15','FEMALE'),(11,'System Scheduler','SYSTEM/DEFAULT ADDRESS','SYSTEM AREA','SCHEDULER','2025-10-04 20:25:26','2025-10-04 20:25:26','NONE');
/*!40000 ALTER TABLE `rz_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_logical_date`
--

DROP TABLE IF EXISTS `rz_logical_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_logical_date` (
  `logical_date_id` int NOT NULL AUTO_INCREMENT,
  `system_date` date NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`logical_date_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_logical_date`
--

LOCK TABLES `rz_logical_date` WRITE;
/*!40000 ALTER TABLE `rz_logical_date` DISABLE KEYS */;
INSERT INTO `rz_logical_date` VALUES (1,'2025-10-06',NULL,'Initial system logical date','2025-10-04 21:48:22','2025-10-04 21:48:22');
/*!40000 ALTER TABLE `rz_logical_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_schedule_assignments`
--

DROP TABLE IF EXISTS `rz_schedule_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_schedule_assignments` (
  `assignment_id` int NOT NULL AUTO_INCREMENT,
  `visit_id` int NOT NULL,
  `worker_id` int NOT NULL,
  `status` enum('ASSIGNED','COMPLETED','CANCELLED') DEFAULT 'ASSIGNED',
  `assigned_by` int DEFAULT NULL,
  `assigned_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `assignment_method` enum('AUTO','MANUAL') DEFAULT 'AUTO',
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assignment_id`),
  UNIQUE KEY `unique_assignment` (`visit_id`),
  KEY `assigned_by` (`assigned_by`),
  KEY `idx_worker_assignments` (`worker_id`,`visit_id`),
  CONSTRAINT `rz_schedule_assignments_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `rz_visits` (`visit_id`),
  CONSTRAINT `rz_schedule_assignments_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `rz_workers` (`worker_id`),
  CONSTRAINT `rz_schedule_assignments_ibfk_3` FOREIGN KEY (`assigned_by`) REFERENCES `rz_schedulers` (`scheduler_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_schedule_assignments`
--

LOCK TABLES `rz_schedule_assignments` WRITE;
/*!40000 ALTER TABLE `rz_schedule_assignments` DISABLE KEYS */;
INSERT INTO `rz_schedule_assignments` VALUES (4,101,1,'ASSIGNED',11,'2026-01-04 15:14:44','AUTO','2026-01-04 15:14:44','2026-01-04 15:14:44'),(5,102,1,'ASSIGNED',11,'2026-01-04 15:14:44','AUTO','2026-01-04 15:14:44','2026-01-04 15:14:44'),(6,103,1,'ASSIGNED',11,'2026-01-04 15:14:44','AUTO','2026-01-04 15:14:44','2026-01-04 15:14:44');
/*!40000 ALTER TABLE `rz_schedule_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_schedulers`
--

DROP TABLE IF EXISTS `rz_schedulers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_schedulers` (
  `scheduler_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`scheduler_id`),
  KEY `fk_scheduler_employee` (`employee_id`),
  CONSTRAINT `fk_scheduler_employee` FOREIGN KEY (`employee_id`) REFERENCES `rz_employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_schedulers`
--

LOCK TABLES `rz_schedulers` WRITE;
/*!40000 ALTER TABLE `rz_schedulers` DISABLE KEYS */;
INSERT INTO `rz_schedulers` VALUES (7,6,'2025-10-04 20:25:49','2025-10-04 20:25:49'),(8,7,'2025-10-04 20:25:49','2025-10-04 20:25:49'),(9,8,'2025-10-04 20:25:49','2025-10-04 20:25:49'),(10,9,'2025-10-04 20:25:49','2025-10-04 20:25:49'),(11,10,'2025-10-04 20:25:49','2025-10-04 20:25:49'),(12,11,'2025-10-04 20:25:49','2025-10-04 20:25:49');
/*!40000 ALTER TABLE `rz_schedulers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_visits`
--

DROP TABLE IF EXISTS `rz_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_visits` (
  `visit_id` int NOT NULL AUTO_INCREMENT,
  `contract_id` int NOT NULL,
  `client_id` int NOT NULL,
  `visit_date` date NOT NULL,
  `visit_time` time NOT NULL,
  `duration_minutes` int DEFAULT '60',
  `service_area` varchar(255) NOT NULL,
  `status` enum('UNASSIGNED','ASSIGNED','COMPLETED','CANCELLED','NO_SHOW') DEFAULT 'UNASSIGNED',
  `is_adhoc` tinyint(1) DEFAULT '0',
  `notes` text,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`visit_id`),
  UNIQUE KEY `unique_visit` (`client_id`,`visit_date`,`visit_time`),
  KEY `contract_id` (`contract_id`),
  KEY `idx_unassigned_visits` (`status`,`visit_date`),
  KEY `idx_visit_date_range` (`visit_date`,`status`),
  CONSTRAINT `rz_visits_ibfk_1` FOREIGN KEY (`contract_id`) REFERENCES `rz_client_service_contract` (`contract_id`),
  CONSTRAINT `rz_visits_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `rz_clients` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_visits`
--

LOCK TABLES `rz_visits` WRITE;
/*!40000 ALTER TABLE `rz_visits` DISABLE KEYS */;
INSERT INTO `rz_visits` VALUES (101,1,1,'2026-01-05','10:00:00',60,'Burnaby','ASSIGNED',0,'Monday morning care','2026-01-04 15:12:18','2026-01-04 18:15:04'),(102,1,1,'2026-01-08','10:00:00',60,'Burnaby','ASSIGNED',0,'Wednesday morning care','2026-01-04 15:12:18','2026-01-04 18:15:13'),(103,1,1,'2026-01-10','10:00:00',60,'Burnaby','ASSIGNED',0,'Friday morning care','2026-01-04 15:12:18','2026-01-04 18:15:16');
/*!40000 ALTER TABLE `rz_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_worker_availability`
--

DROP TABLE IF EXISTS `rz_worker_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_worker_availability` (
  `worker_id` int NOT NULL,
  `working_days` varchar(50) NOT NULL COMMENT 'Format: MON,WED,FRI or MON-FRI',
  `daily_start_time` time NOT NULL,
  `daily_end_time` time NOT NULL,
  `max_visits_per_day` int DEFAULT '6' COMMENT 'Optional capacity limit',
  `is_active` tinyint(1) DEFAULT '1',
  `notes` text,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`worker_id`),
  CONSTRAINT `rz_worker_availability_ibfk_1` FOREIGN KEY (`worker_id`) REFERENCES `rz_workers` (`worker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_worker_availability`
--

LOCK TABLES `rz_worker_availability` WRITE;
/*!40000 ALTER TABLE `rz_worker_availability` DISABLE KEYS */;
INSERT INTO `rz_worker_availability` VALUES (1,'MON,WED,FRI','09:00:00','17:00:00',6,1,NULL,'2026-01-04 14:34:30','2026-01-04 14:34:30'),(2,'MON-FRI','08:00:00','16:00:00',8,1,NULL,'2026-01-04 14:34:30','2026-01-04 14:34:30'),(3,'SAT,SUN','10:00:00','18:00:00',6,1,NULL,'2026-01-04 14:34:30','2026-01-04 14:34:30'),(4,'MON-FRI','14:00:00','22:00:00',6,1,NULL,'2026-01-04 14:34:30','2026-01-04 14:34:30'),(5,'TUE,THU','10:00:00','18:00:00',5,1,NULL,'2026-01-04 14:34:30','2026-01-04 14:34:30');
/*!40000 ALTER TABLE `rz_worker_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_worker_time_off_requests`
--

DROP TABLE IF EXISTS `rz_worker_time_off_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_worker_time_off_requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `worker_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `approval_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `approved_by` varchar(50) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`request_id`),
  KEY `idx_time_off_dates` (`worker_id`,`start_date`,`end_date`,`approval_status`),
  CONSTRAINT `fk_worker_time_off` FOREIGN KEY (`worker_id`) REFERENCES `rz_workers` (`worker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_worker_time_off_requests`
--

LOCK TABLES `rz_worker_time_off_requests` WRITE;
/*!40000 ALTER TABLE `rz_worker_time_off_requests` DISABLE KEYS */;
INSERT INTO `rz_worker_time_off_requests` VALUES (1,1,'2025-10-10','2025-10-12','Family emergency','APPROVED',NULL,NULL,'2025-10-04 19:10:36','2025-10-04 19:19:12'),(2,2,'2025-10-15','2025-10-16','Medical appointment','PENDING',NULL,NULL,'2025-10-04 19:10:36','2025-10-04 19:19:12'),(3,4,'2025-10-20','2025-10-22','Vacation','REJECTED',NULL,NULL,'2025-10-04 19:10:36','2025-10-04 19:19:12');
/*!40000 ALTER TABLE `rz_worker_time_off_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rz_workers`
--

DROP TABLE IF EXISTS `rz_workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rz_workers` (
  `worker_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `worker_preferred_shift` enum('MORNING','AFTERNOON','NIGHT') NOT NULL,
  `worker_pet_allergy` tinyint(1) DEFAULT '0',
  `rz_created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `rz_last_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`worker_id`),
  KEY `fk_worker_employee` (`employee_id`),
  CONSTRAINT `fk_worker_employee` FOREIGN KEY (`employee_id`) REFERENCES `rz_employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rz_workers`
--

LOCK TABLES `rz_workers` WRITE;
/*!40000 ALTER TABLE `rz_workers` DISABLE KEYS */;
INSERT INTO `rz_workers` VALUES (1,1,'MORNING',0,'2025-10-04 20:25:42','2025-10-04 20:36:59'),(2,2,'AFTERNOON',1,'2025-10-04 20:25:42','2025-10-04 20:36:59'),(3,3,'NIGHT',0,'2025-10-04 20:25:42','2025-10-04 20:36:59'),(4,4,'MORNING',0,'2025-10-04 20:25:42','2025-10-04 20:36:59'),(5,5,'AFTERNOON',1,'2025-10-04 20:25:42','2025-10-04 20:36:59');
/*!40000 ALTER TABLE `rz_workers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-04 19:21:28
