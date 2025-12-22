-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: lms_db
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Token',6,'add_token'),(22,'Can change Token',6,'change_token'),(23,'Can delete Token',6,'delete_token'),(24,'Can view Token',6,'view_token'),(25,'Can add Token',7,'add_tokenproxy'),(26,'Can change Token',7,'change_tokenproxy'),(27,'Can delete Token',7,'delete_tokenproxy'),(28,'Can view Token',7,'view_tokenproxy'),(29,'Can add Blacklisted Token',8,'add_blacklistedtoken'),(30,'Can change Blacklisted Token',8,'change_blacklistedtoken'),(31,'Can delete Blacklisted Token',8,'delete_blacklistedtoken'),(32,'Can view Blacklisted Token',8,'view_blacklistedtoken'),(33,'Can add Outstanding Token',9,'add_outstandingtoken'),(34,'Can change Outstanding Token',9,'change_outstandingtoken'),(35,'Can delete Outstanding Token',9,'delete_outstandingtoken'),(36,'Can view Outstanding Token',9,'view_outstandingtoken'),(37,'Can add user',10,'add_user'),(38,'Can change user',10,'change_user'),(39,'Can delete user',10,'delete_user'),(40,'Can view user',10,'view_user'),(41,'Can add announcement',11,'add_announcement'),(42,'Can change announcement',11,'change_announcement'),(43,'Can delete announcement',11,'delete_announcement'),(44,'Can view announcement',11,'view_announcement'),(45,'Can add assignment',12,'add_assignment'),(46,'Can change assignment',12,'change_assignment'),(47,'Can delete assignment',12,'delete_assignment'),(48,'Can view assignment',12,'view_assignment'),(49,'Can add choice',13,'add_choice'),(50,'Can change choice',13,'change_choice'),(51,'Can delete choice',13,'delete_choice'),(52,'Can view choice',13,'view_choice'),(53,'Can add comment',14,'add_comment'),(54,'Can change comment',14,'change_comment'),(55,'Can delete comment',14,'delete_comment'),(56,'Can view comment',14,'view_comment'),(57,'Can add course',15,'add_course'),(58,'Can change course',15,'change_course'),(59,'Can delete course',15,'delete_course'),(60,'Can view course',15,'view_course'),(61,'Can add discussion post',16,'add_discussionpost'),(62,'Can change discussion post',16,'change_discussionpost'),(63,'Can delete discussion post',16,'delete_discussionpost'),(64,'Can view discussion post',16,'view_discussionpost'),(65,'Can add discussion thread',17,'add_discussionthread'),(66,'Can change discussion thread',17,'change_discussionthread'),(67,'Can delete discussion thread',17,'delete_discussionthread'),(68,'Can view discussion thread',17,'view_discussionthread'),(69,'Can add enrollment',18,'add_enrollment'),(70,'Can change enrollment',18,'change_enrollment'),(71,'Can delete enrollment',18,'delete_enrollment'),(72,'Can view enrollment',18,'view_enrollment'),(73,'Can add lesson',19,'add_lesson'),(74,'Can change lesson',19,'change_lesson'),(75,'Can delete lesson',19,'delete_lesson'),(76,'Can view lesson',19,'view_lesson'),(77,'Can add material',20,'add_material'),(78,'Can change material',20,'change_material'),(79,'Can delete material',20,'delete_material'),(80,'Can view material',20,'view_material'),(81,'Can add notification',21,'add_notification'),(82,'Can change notification',21,'change_notification'),(83,'Can delete notification',21,'delete_notification'),(84,'Can view notification',21,'view_notification'),(85,'Can add progress',22,'add_progress'),(86,'Can change progress',22,'change_progress'),(87,'Can delete progress',22,'delete_progress'),(88,'Can view progress',22,'view_progress'),(89,'Can add question',23,'add_question'),(90,'Can change question',23,'change_question'),(91,'Can delete question',23,'delete_question'),(92,'Can view question',23,'view_question'),(93,'Can add quiz',24,'add_quiz'),(94,'Can change quiz',24,'change_quiz'),(95,'Can delete quiz',24,'delete_quiz'),(96,'Can view quiz',24,'view_quiz'),(97,'Can add schedule',25,'add_schedule'),(98,'Can change schedule',25,'change_schedule'),(99,'Can delete schedule',25,'delete_schedule'),(100,'Can view schedule',25,'view_schedule'),(101,'Can add section',26,'add_section'),(102,'Can change section',26,'change_section'),(103,'Can delete section',26,'delete_section'),(104,'Can view section',26,'view_section'),(105,'Can add submission',27,'add_submission'),(106,'Can change submission',27,'change_submission'),(107,'Can delete submission',27,'delete_submission'),(108,'Can view submission',27,'view_submission'),(109,'Can add quiz submission',28,'add_quizsubmission'),(110,'Can change quiz submission',28,'change_quizsubmission'),(111,'Can delete quiz submission',28,'delete_quizsubmission'),(112,'Can view quiz submission',28,'view_quizsubmission'),(113,'Can add attendance session',29,'add_attendancesession'),(114,'Can change attendance session',29,'change_attendancesession'),(115,'Can delete attendance session',29,'delete_attendancesession'),(116,'Can view attendance session',29,'view_attendancesession'),(117,'Can add attendance record',30,'add_attendancerecord'),(118,'Can change attendance record',30,'change_attendancerecord'),(119,'Can delete attendance record',30,'delete_attendancerecord'),(120,'Can view attendance record',30,'view_attendancerecord');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(6,'authtoken','token'),(7,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(11,'lms','announcement'),(12,'lms','assignment'),(30,'lms','attendancerecord'),(29,'lms','attendancesession'),(13,'lms','choice'),(14,'lms','comment'),(15,'lms','course'),(16,'lms','discussionpost'),(17,'lms','discussionthread'),(18,'lms','enrollment'),(19,'lms','lesson'),(20,'lms','material'),(21,'lms','notification'),(22,'lms','progress'),(23,'lms','question'),(24,'lms','quiz'),(28,'lms','quizsubmission'),(25,'lms','schedule'),(26,'lms','section'),(27,'lms','submission'),(5,'sessions','session'),(8,'token_blacklist','blacklistedtoken'),(9,'token_blacklist','outstandingtoken'),(10,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-11-17 08:20:00.051698'),(2,'contenttypes','0002_remove_content_type_name','2025-11-17 08:20:00.194090'),(3,'auth','0001_initial','2025-11-17 08:20:00.572915'),(4,'auth','0002_alter_permission_name_max_length','2025-11-17 08:20:00.683219'),(5,'auth','0003_alter_user_email_max_length','2025-11-17 08:20:00.691158'),(6,'auth','0004_alter_user_username_opts','2025-11-17 08:20:00.701954'),(7,'auth','0005_alter_user_last_login_null','2025-11-17 08:20:00.711537'),(8,'auth','0006_require_contenttypes_0002','2025-11-17 08:20:00.717111'),(9,'auth','0007_alter_validators_add_error_messages','2025-11-17 08:20:00.726246'),(10,'auth','0008_alter_user_username_max_length','2025-11-17 08:20:00.739013'),(11,'auth','0009_alter_user_last_name_max_length','2025-11-17 08:20:00.748647'),(12,'auth','0010_alter_group_name_max_length','2025-11-17 08:20:00.772253'),(13,'auth','0011_update_proxy_permissions','2025-11-17 08:20:00.782415'),(14,'auth','0012_alter_user_first_name_max_length','2025-11-17 08:20:00.792454'),(15,'users','0001_initial','2025-11-17 08:20:01.291656'),(16,'admin','0001_initial','2025-11-17 08:20:01.507177'),(17,'admin','0002_logentry_remove_auto_add','2025-11-17 08:20:01.516187'),(18,'admin','0003_logentry_add_action_flag_choices','2025-11-17 08:20:01.529307'),(19,'authtoken','0001_initial','2025-11-17 08:20:01.671096'),(20,'authtoken','0002_auto_20160226_1747','2025-11-17 08:20:01.696151'),(21,'authtoken','0003_tokenproxy','2025-11-17 08:20:01.701267'),(22,'authtoken','0004_alter_tokenproxy_options','2025-11-17 08:20:01.711140'),(23,'lms','0001_initial','2025-11-17 08:20:02.146745'),(24,'lms','0002_initial','2025-11-17 08:20:04.794776'),(25,'sessions','0001_initial','2025-11-17 08:20:04.914947'),(26,'token_blacklist','0001_initial','2025-11-17 08:20:05.175445'),(27,'token_blacklist','0002_outstandingtoken_jti_hex','2025-11-17 08:20:05.263415'),(28,'token_blacklist','0003_auto_20171017_2007','2025-11-17 08:20:05.292013'),(29,'token_blacklist','0004_auto_20171017_2013','2025-11-17 08:20:05.406039'),(30,'token_blacklist','0005_remove_outstandingtoken_jti','2025-11-17 08:20:05.495100'),(31,'token_blacklist','0006_auto_20171017_2113','2025-11-17 08:20:05.533279'),(32,'token_blacklist','0007_auto_20171017_2214','2025-11-17 08:20:05.814504'),(33,'token_blacklist','0008_migrate_to_bigautofield','2025-11-17 08:20:06.168436'),(34,'token_blacklist','0010_fix_migrate_to_bigautofield','2025-11-17 08:20:06.191358'),(35,'token_blacklist','0011_linearizes_history','2025-11-17 08:20:06.196477'),(36,'token_blacklist','0012_alter_outstandingtoken_user','2025-11-17 08:20:06.225027'),(37,'token_blacklist','0013_alter_blacklistedtoken_options_and_more','2025-11-17 08:20:06.252098'),(38,'lms','0003_assignment_updated_at_submission_status_and_more','2025-11-17 13:51:16.102231'),(39,'lms','0004_quiz_author_quiz_updated_at_alter_quiz_description','2025-11-18 09:28:58.197693'),(40,'lms','0005_quizsubmission','2025-11-21 06:39:57.405437'),(41,'lms','0006_course_meeting_link','2025-11-21 07:41:49.252219'),(42,'lms','0007_attendancesession_attendancerecord','2025-11-29 16:16:44.800713');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('fc881er990ch8n81xj9r2v6w6vc5pnp0','.eJxVjMsOgjAURP-la9NY2kupS_d8A7kvBTVtQmFl_HchYaG7yZwz8zYDrss4rFXnYRJzMc6cfjtCfmregTww34vlkpd5Irsr9qDV9kX0dT3cv4MR67itkaOLKUaCBNKp8-CpBeaWA4oKnbeo5Bt03IEEvAkBBtc2jYBCSObzBfiiOI0:1vKuU4:m_EiTINO-FtKpe_tDGCfnlyvESuu_ZNtNFHSkNMw6l0','2025-12-01 08:21:12.054631');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_announcement`
--

DROP TABLE IF EXISTS `lms_announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_announcement` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `author_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_announcement_author_id_1489f4b3_fk_users_user_id` (`author_id`),
  KEY `lms_announcement_course_id_2165cac0_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_announcement_author_id_1489f4b3_fk_users_user_id` FOREIGN KEY (`author_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `lms_announcement_course_id_2165cac0_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_announcement`
--

LOCK TABLES `lms_announcement` WRITE;
/*!40000 ALTER TABLE `lms_announcement` DISABLE KEYS */;
INSERT INTO `lms_announcement` VALUES (1,'Thông báo','ÁDADFHFGHF','2025-11-17 08:43:45.716479',3,1),(2,'Thông báo','alo','2025-11-17 09:44:13.890006',3,1);
/*!40000 ALTER TABLE `lms_announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_assignment`
--

DROP TABLE IF EXISTS `lms_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_assignment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `due_at` datetime(6) DEFAULT NULL,
  `max_score` double NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_assignment_course_id_37a70cef_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_assignment_course_id_37a70cef_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_assignment`
--

LOCK TABLES `lms_assignment` WRITE;
/*!40000 ALTER TABLE `lms_assignment` DISABLE KEYS */;
INSERT INTO `lms_assignment` VALUES (1,'BT1','ABCXYZ','2025-10-29 08:42:00.000000',10,'2025-11-17 08:42:36.164115',1,'2025-11-17 13:51:15.669493'),(2,'ưetd','dgfghs','2025-11-19 14:11:00.000000',10,'2025-11-17 14:12:02.158254',1,'2025-11-17 14:12:02.158254'),(3,'sdfs','sdfsdf','2025-11-23 16:32:00.000000',10,'2025-11-23 08:27:25.631005',1,'2025-11-23 08:27:25.631005'),(4,'fdhdfhd','àdfdhfdhdgh','2025-11-28 10:03:00.000000',10,'2025-11-28 02:55:24.722736',1,'2025-11-28 03:30:31.961216'),(5,'chương2','sss','2025-11-29 04:25:00.000000',10,'2025-11-29 16:21:52.689349',1,'2025-11-29 16:21:52.689357'),(6,'Chuong1','ABC','2025-12-25 07:49:00.000000',10,'2025-12-18 07:49:54.963070',2,'2025-12-18 07:49:54.963070'),(7,'bài tập 5','avc','2025-12-24 09:52:00.000000',10,'2025-12-19 09:52:39.838086',1,'2025-12-19 09:52:39.838086');
/*!40000 ALTER TABLE `lms_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_attendancerecord`
--

DROP TABLE IF EXISTS `lms_attendancerecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_attendancerecord` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` bigint NOT NULL,
  `session_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_attendancerecord_session_id_student_id_67ecd1f0_uniq` (`session_id`,`student_id`),
  KEY `lms_attendancerecord_student_id_fbfa48e0_fk_users_user_id` (`student_id`),
  CONSTRAINT `lms_attendancerecord_session_id_6634c301_fk_lms_atten` FOREIGN KEY (`session_id`) REFERENCES `lms_attendancesession` (`id`),
  CONSTRAINT `lms_attendancerecord_student_id_fbfa48e0_fk_users_user_id` FOREIGN KEY (`student_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_attendancerecord`
--

LOCK TABLES `lms_attendancerecord` WRITE;
/*!40000 ALTER TABLE `lms_attendancerecord` DISABLE KEYS */;
INSERT INTO `lms_attendancerecord` VALUES (1,'present','',2,1);
/*!40000 ALTER TABLE `lms_attendancerecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_attendancesession`
--

DROP TABLE IF EXISTS `lms_attendancesession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_attendancesession` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_attendancesession_course_id_0e057b43_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_attendancesession_course_id_0e057b43_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_attendancesession`
--

LOCK TABLES `lms_attendancesession` WRITE;
/*!40000 ALTER TABLE `lms_attendancesession` DISABLE KEYS */;
INSERT INTO `lms_attendancesession` VALUES (1,'2025-11-29','buổi1','2025-11-29 16:17:29.626287',1);
/*!40000 ALTER TABLE `lms_attendancesession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_choice`
--

DROP TABLE IF EXISTS `lms_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_choice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `question_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_choice_question_id_913bf082_fk_lms_question_id` (`question_id`),
  CONSTRAINT `lms_choice_question_id_913bf082_fk_lms_question_id` FOREIGN KEY (`question_id`) REFERENCES `lms_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_choice`
--

LOCK TABLES `lms_choice` WRITE;
/*!40000 ALTER TABLE `lms_choice` DISABLE KEYS */;
INSERT INTO `lms_choice` VALUES (11,'a',1,'2025-11-21 06:50:20.343040',8),(12,'b',0,'2025-11-21 06:50:24.421528',8),(13,'c',0,'2025-11-21 06:50:27.594754',8),(14,'d',0,'2025-11-21 06:50:30.611278',8),(15,'1',0,'2025-11-21 06:50:47.789566',9),(16,'2',0,'2025-11-21 06:50:52.316385',9),(17,'3',1,'2025-11-21 06:50:57.172261',9),(18,'4',0,'2025-11-21 06:51:02.939018',9),(43,'Hà Nội',0,'2025-11-26 08:06:53.099012',16),(44,'Lòng chảo Mường Thanh, tỉnh Lai Châu (nay là tỉnh Điện Biên)',1,'2025-11-26 08:06:53.119332',16),(45,'Hải Phòng',0,'2025-11-26 08:06:53.144177',16),(46,'Sài Gòn',0,'2025-11-26 08:06:53.153791',16),(47,'30 ngày đêm',0,'2025-11-26 08:06:53.209646',17),(48,'56 ngày đêm',1,'2025-11-26 08:06:53.226425',17),(49,'75 ngày đêm',0,'2025-11-26 08:06:53.252602',17),(50,'100 ngày đêm',0,'2025-11-26 08:06:53.274754',17),(51,'Hồ Chí Minh',0,'2025-11-26 08:06:53.311815',18),(52,'Võ Nguyên Giáp',1,'2025-11-26 08:06:53.333624',18),(53,'Trần Hưng Đạo',0,'2025-11-26 08:06:53.354430',18),(54,'Lê Lợi',0,'2025-11-26 08:06:53.376598',18),(55,'Tướng Patton',0,'2025-11-26 08:06:53.423533',19),(56,'Tướng De Castries',1,'2025-11-26 08:06:53.443961',19),(57,'Tướng MacArthur',0,'2025-11-26 08:06:53.454504',19),(58,'Tướng Eisenhower',0,'2025-11-26 08:06:53.484673',19),(59,'Hiệp định Paris',0,'2025-11-26 08:06:53.527558',20),(60,'Hiệp định Genève',1,'2025-11-26 08:06:53.550337',20),(61,'Hiệp định Sơ bộ',0,'2025-11-26 08:06:53.571856',20),(62,'Hiệp định Giơnevơ',0,'2025-11-26 08:06:53.593672',20),(67,'Một quốc gia',0,'2025-12-01 02:04:59.009950',22),(68,'Toàn cầu',1,'2025-12-01 02:04:59.032186',22),(69,'Một châu lục',0,'2025-12-01 02:04:59.052913',22),(70,'Khu vực Đông Nam Á',0,'2025-12-01 02:04:59.076504',22),(71,'Cuộc tấn công Trân Châu Cảng của Nhật Bản',0,'2025-12-01 02:04:59.124747',23),(72,'Việc Đức xâm lược Ba Lan',1,'2025-12-01 02:04:59.144999',23),(73,'Cuộc Cách mạng Tháng Mười Nga',0,'2025-12-01 02:04:59.165391',23),(74,'Sự kiện Vịnh Bắc Bộ',0,'2025-12-01 02:04:59.187089',23),(75,'1943',0,'2025-12-01 02:04:59.228048',24),(76,'1945',1,'2025-12-01 02:04:59.243097',24),(77,'1950',0,'2025-12-01 02:04:59.272676',24),(78,'1960',0,'2025-12-01 02:04:59.293150',24),(79,'Đức',0,'2025-12-01 02:04:59.327101',25),(80,'Ý',0,'2025-12-01 02:04:59.353517',25),(81,'Nhật Bản',0,'2025-12-01 02:04:59.371527',25),(82,'Liên Xô',1,'2025-12-01 02:04:59.389236',25),(83,'Sự hình thành Liên Hợp Quốc',0,'2025-12-01 02:04:59.426289',26),(84,'Số lượng người chết và bị thương rất lớn, cùng với sự tàn phá kinh tế',1,'2025-12-01 02:04:59.447079',26),(85,'Sự phân chia thế giới thành hai cực',0,'2025-12-01 02:04:59.468876',26),(86,'Sự ra đời của các quốc gia độc lập ở châu Á',0,'2025-12-01 02:04:59.492112',26),(87,'Toán học cao cấp',0,'2025-12-01 02:06:48.342464',27),(88,'Nhập môn lập trình',1,'2025-12-01 02:06:48.359587',27),(89,'Văn học Việt Nam',0,'2025-12-01 02:06:48.377745',27),(90,'Lịch sử thế giới',0,'2025-12-01 02:06:48.402709',27),(91,'Sách nấu ăn',0,'2025-12-01 02:06:48.442305',28),(92,'Giáo trình đại học',1,'2025-12-01 02:06:48.469427',28),(93,'Tiểu thuyết trinh thám',0,'2025-12-01 02:06:48.490045',28),(94,'Báo cáo tài chính',0,'2025-12-01 02:06:48.510811',28),(95,'Thuật toán',1,'2025-12-01 02:06:48.559279',29),(96,'Thiên văn học',0,'2025-12-01 02:06:48.577880',29),(97,'Địa lý học',0,'2025-12-01 02:06:48.602456',29),(98,'Sinh học',0,'2025-12-01 02:06:48.621853',29),(99,'Trẻ em mẫu giáo',0,'2025-12-01 02:06:48.677595',30),(100,'Người mới bắt đầu học lập trình',1,'2025-12-01 02:06:48.691986',30),(101,'Các nhà khoa học',0,'2025-12-01 02:06:48.718911',30),(102,'Những người đã có kinh nghiệm lập trình lâu năm',0,'2025-12-01 02:06:48.739259',30),(103,'Giải trí',0,'2025-12-01 02:06:48.785618',31),(104,'Giáo dục và hướng dẫn',1,'2025-12-01 02:06:48.804565',31),(105,'Thuyết phục',0,'2025-12-01 02:06:48.825542',31),(106,'Kể chuyện',0,'2025-12-01 02:06:48.845726',31),(107,'Trở thành một lập trình viên chuyên nghiệp ngay lập tức.',0,'2025-12-01 02:10:02.804130',32),(108,'Nắm vững các khái niệm cơ bản về lập trình và tư duy giải quyết vấn đề.',1,'2025-12-01 02:10:02.827471',32),(109,'Học cách sử dụng tất cả các ngôn ngữ lập trình.',0,'2025-12-01 02:10:02.846509',32),(110,'Tìm hiểu về phần cứng máy tính.',0,'2025-12-01 02:10:02.870320',32),(111,'Biến và kiểu dữ liệu.',0,'2025-12-01 02:10:02.910893',33),(112,'Cấu trúc điều khiển (if, else, vòng lặp).',0,'2025-12-01 02:10:02.930931',33),(113,'Giải thuật (Algorithm).',0,'2025-12-01 02:10:02.952352',33),(114,'Thiết kế giao diện người dùng (UI Design).',1,'2025-12-01 02:10:02.972343',33),(115,'Microsoft Word.',0,'2025-12-01 02:10:03.012757',34),(116,'Trình biên dịch (Compiler) hoặc thông dịch (Interpreter).',1,'2025-12-01 02:10:03.037920',34),(117,'Phần mềm thiết kế đồ họa.',0,'2025-12-01 02:10:03.058191',34),(118,'Bảng tính Excel.',0,'2025-12-01 02:10:03.079820',34),(119,'Vì nó giúp chương trình chạy nhanh hơn trên mọi phần cứng.',0,'2025-12-01 02:10:03.122027',35),(120,'Vì nó giúp chúng ta tìm ra cách giải quyết vấn đề một cách hiệu quả và có logic.',1,'2025-12-01 02:10:03.141774',35),(121,'Vì nó giúp viết code ngắn gọn hơn.',0,'2025-12-01 02:10:03.161764',35),(122,'Vì nó giúp tạo ra giao diện đẹp mắt hơn.',0,'2025-12-01 02:10:03.179800',35),(123,'Lỗi xảy ra khi chương trình chạy quá chậm.',0,'2025-12-01 02:10:03.222434',36),(124,'Lỗi xảy ra do vi phạm các quy tắc của ngôn ngữ lập trình.',1,'2025-12-01 02:10:03.246150',36),(125,'Lỗi xảy ra khi máy tính hết bộ nhớ.',0,'2025-12-01 02:10:03.269696',36),(126,'Lỗi xảy ra khi người dùng nhập dữ liệu không hợp lệ.',0,'2025-12-01 02:10:03.290112',36),(127,'Khoa học máy tính',0,'2025-12-19 10:07:46.719409',37),(128,'Lý thuyết máy tính',0,'2025-12-19 10:07:47.160137',37),(129,'Nghiên cứu hệ thống học, suy luận và nhận biết',1,'2025-12-19 10:07:47.268536',37),(130,'Khoa học máy tính lưu trữ',0,'2025-12-19 10:07:47.550379',37),(131,'AI (Artificial Intelligence)',1,'2025-12-19 10:08:51.822237',38),(132,'ML (Machine Learning)',0,'2025-12-19 10:08:51.850683',38),(133,'DS (Data Science)',0,'2025-12-19 10:08:51.877858',38),(134,'IoT (Internet of Things)',0,'2025-12-19 10:08:51.910173',38);
/*!40000 ALTER TABLE `lms_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_comment`
--

DROP TABLE IF EXISTS `lms_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `announcement_id` bigint DEFAULT NULL,
  `author_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_comment_announcement_id_d5173374_fk_lms_announcement_id` (`announcement_id`),
  KEY `lms_comment_author_id_e78723cf_fk_users_user_id` (`author_id`),
  KEY `lms_comment_course_id_de49410a_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_comment_announcement_id_d5173374_fk_lms_announcement_id` FOREIGN KEY (`announcement_id`) REFERENCES `lms_announcement` (`id`),
  CONSTRAINT `lms_comment_author_id_e78723cf_fk_users_user_id` FOREIGN KEY (`author_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `lms_comment_course_id_de49410a_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_comment`
--

LOCK TABLES `lms_comment` WRITE;
/*!40000 ALTER TABLE `lms_comment` DISABLE KEYS */;
INSERT INTO `lms_comment` VALUES (1,'dfgdfg','2025-11-17 09:43:49.713069','2025-11-17 09:43:49.713069',1,3,1),(2,'sdfsdfsdf','2025-11-17 09:43:56.056111','2025-11-17 09:43:56.056111',1,3,1),(3,'alo','2025-11-17 09:44:01.722232','2025-11-17 09:44:01.722232',1,3,1),(4,'ẻwr','2025-11-17 10:07:49.067725','2025-11-17 10:07:49.067725',2,2,1),(5,'ưeq1','2025-11-17 10:07:58.159717','2025-11-17 10:07:58.159717',2,2,1),(6,'dfg','2025-11-17 10:22:00.670278','2025-11-17 10:22:00.670278',2,3,1),(7,'alo 123','2025-11-21 08:12:54.406811','2025-11-21 08:12:54.406811',2,3,1),(8,'123','2025-11-21 08:13:06.810958','2025-11-21 08:13:06.810958',2,2,1),(9,'sdf','2025-11-22 08:49:45.788236','2025-11-22 08:49:45.788236',2,3,1),(10,'123','2025-11-22 08:49:52.386764','2025-11-22 08:49:52.386764',2,3,1),(11,'qe','2025-11-23 08:19:53.532662','2025-11-23 08:19:53.532662',2,2,1),(12,'https://meet.google.com/abc-defg-hjk','2025-11-23 13:20:00.935752','2025-11-23 13:20:00.935752',2,2,1),(13,'1','2025-12-06 05:41:55.963739','2025-12-06 05:41:55.963739',2,2,1);
/*!40000 ALTER TABLE `lms_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_course`
--

DROP TABLE IF EXISTS `lms_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `owner_id` bigint NOT NULL,
  `meeting_link` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `lms_course_owner_id_bf102a1a_fk_users_user_id` (`owner_id`),
  CONSTRAINT `lms_course_owner_id_bf102a1a_fk_users_user_id` FOREIGN KEY (`owner_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_course`
--

LOCK TABLES `lms_course` WRITE;
/*!40000 ALTER TABLE `lms_course` DISABLE KEYS */;
INSERT INTO `lms_course` VALUES (1,'AI','Robot & Trí tuệ nhân tạo','8ZIPLA','2025-11-17 08:37:45.828581','2025-11-29 16:09:39.976419',3,'https://meet.google.com/abc-defg-hjk'),(2,'CNTT','robot','P3PZSD','2025-12-18 07:44:50.144826','2025-12-18 07:44:50.144826',3,'');
/*!40000 ALTER TABLE `lms_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_discussionpost`
--

DROP TABLE IF EXISTS `lms_discussionpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_discussionpost` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `author_id` bigint NOT NULL,
  `thread_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_discussionpost_author_id_6eca2498_fk_users_user_id` (`author_id`),
  KEY `lms_discussionpost_thread_id_2ceda76d_fk_lms_discussionthread_id` (`thread_id`),
  CONSTRAINT `lms_discussionpost_author_id_6eca2498_fk_users_user_id` FOREIGN KEY (`author_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `lms_discussionpost_thread_id_2ceda76d_fk_lms_discussionthread_id` FOREIGN KEY (`thread_id`) REFERENCES `lms_discussionthread` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_discussionpost`
--

LOCK TABLES `lms_discussionpost` WRITE;
/*!40000 ALTER TABLE `lms_discussionpost` DISABLE KEYS */;
INSERT INTO `lms_discussionpost` VALUES (1,'fdgdf','2025-11-22 08:50:32.866750',3,1),(2,'123','2025-11-23 09:10:47.239626',2,1),(3,'sfs','2025-11-23 09:11:14.544571',3,1),(4,'sdf','2025-11-26 08:57:33.908079',2,1),(5,'123','2025-11-26 09:31:06.013747',3,1),(6,'sdf','2025-11-30 09:50:27.775439',3,1),(7,'1','2025-12-06 05:42:02.324954',2,1);
/*!40000 ALTER TABLE `lms_discussionpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_discussionthread`
--

DROP TABLE IF EXISTS `lms_discussionthread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_discussionthread` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_discussionthread_author_id_beb14f8f_fk_users_user_id` (`author_id`),
  KEY `lms_discussionthread_course_id_45a640f3_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_discussionthread_author_id_beb14f8f_fk_users_user_id` FOREIGN KEY (`author_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `lms_discussionthread_course_id_45a640f3_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_discussionthread`
--

LOCK TABLES `lms_discussionthread` WRITE;
/*!40000 ALTER TABLE `lms_discussionthread` DISABLE KEYS */;
INSERT INTO `lms_discussionthread` VALUES (1,'123','2025-11-22 08:50:26.318528',3,1);
/*!40000 ALTER TABLE `lms_discussionthread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_enrollment`
--

DROP TABLE IF EXISTS `lms_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_enrollment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_enrollment_course_id_user_id_55a630f7_uniq` (`course_id`,`user_id`),
  KEY `lms_enrollment_user_id_2ee2c0b4_fk_users_user_id` (`user_id`),
  CONSTRAINT `lms_enrollment_course_id_989457ae_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`),
  CONSTRAINT `lms_enrollment_user_id_2ee2c0b4_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_enrollment`
--

LOCK TABLES `lms_enrollment` WRITE;
/*!40000 ALTER TABLE `lms_enrollment` DISABLE KEYS */;
INSERT INTO `lms_enrollment` VALUES (1,'teacher','2025-11-17 08:37:45.834591','2025-11-17 08:37:45.834591',1,3),(2,'student','2025-11-17 09:06:09.442773','2025-11-17 09:06:09.442773',1,2),(3,'teacher','2025-12-18 07:44:50.153544','2025-12-18 07:44:50.153544',2,3);
/*!40000 ALTER TABLE `lms_enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_lesson`
--

DROP TABLE IF EXISTS `lms_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_lesson` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `section_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_lesson_section_id_594a6a01_fk_lms_section_id` (`section_id`),
  CONSTRAINT `lms_lesson_section_id_594a6a01_fk_lms_section_id` FOREIGN KEY (`section_id`) REFERENCES `lms_section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_lesson`
--

LOCK TABLES `lms_lesson` WRITE;
/*!40000 ALTER TABLE `lms_lesson` DISABLE KEYS */;
INSERT INTO `lms_lesson` VALUES (9,'Nhập môn lập trình','python',1,'2025-11-30 09:48:41.088266',10),(10,'cấu trúc dữ liệu & giải thuật','1',2,'2025-11-30 09:52:54.603549',11);
/*!40000 ALTER TABLE `lms_lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_material`
--

DROP TABLE IF EXISTS `lms_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_material` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `lesson_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_material_lesson_id_15ec2929_fk_lms_lesson_id` (`lesson_id`),
  CONSTRAINT `lms_material_lesson_id_15ec2929_fk_lms_lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lms_lesson` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_material`
--

LOCK TABLES `lms_material` WRITE;
/*!40000 ALTER TABLE `lms_material` DISABLE KEYS */;
INSERT INTO `lms_material` VALUES (3,'materials/2025/12/Bang_Diem_Lop_1.xlsx','','file','2025-12-19 09:53:34.776581',10);
/*!40000 ALTER TABLE `lms_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_notification`
--

DROP TABLE IF EXISTS `lms_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint DEFAULT NULL,
  `recipient_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_notification_course_id_99e0e5a9_fk_lms_course_id` (`course_id`),
  KEY `lms_notification_recipient_id_487da971_fk_users_user_id` (`recipient_id`),
  CONSTRAINT `lms_notification_course_id_99e0e5a9_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`),
  CONSTRAINT `lms_notification_recipient_id_487da971_fk_users_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_notification`
--

LOCK TABLES `lms_notification` WRITE;
/*!40000 ALTER TABLE `lms_notification` DISABLE KEYS */;
INSERT INTO `lms_notification` VALUES (1,'Thông báo mới: AI','Giáo viên đã đăng: \"alo...\"',1,'2025-11-17 09:44:13.898532',1,2),(2,'Học sinh nộp bài',' đã nộp bài \'giữa kỳ\'. Điểm: 10',1,'2025-11-21 06:43:22.716027',1,3),(3,'Bài kiểm tra mới','Kiểm tra: giữa kỳ',1,'2025-11-21 06:49:51.043525',1,2),(4,'Học sinh nộp bài',' đã nộp bài \'giữa kỳ\'. Điểm: 10',1,'2025-11-21 06:51:27.613187',1,3),(5,'Bài tập mới','Giáo viên đã giao bài tập: sdfs',1,'2025-11-23 08:27:25.640806',1,2),(6,'Bài kiểm tra mới','Kiểm tra: dfsf',1,'2025-11-23 08:27:53.053848',1,2),(7,'Học sinh nộp bài',' đã nộp bài \'dfsf\'. Điểm: 10',1,'2025-11-23 08:28:33.913279',1,3),(8,'Đã có điểm','Bài \'ưetd\' đã chấm.',1,'2025-11-23 09:30:23.452578',1,2),(9,'Đã có điểm','Bài \'BT1\' đã chấm.',1,'2025-11-23 09:30:51.839295',1,2),(10,'Đã trả bài','Bài \'BT1\' đã được trả.',1,'2025-11-23 09:30:59.910712',1,2),(11,'Đã có điểm','Bài \'sdfs\' đã chấm.',1,'2025-11-23 09:31:17.113888',1,2),(12,'Đã trả bài','Bài \'sdfs\' đã được trả.',1,'2025-11-23 09:31:22.778826',1,2),(13,'Bài kiểm tra mới','Kiểm tra: kt2',1,'2025-11-26 07:09:11.436352',1,2),(14,'Học sinh nộp bài',' đã nộp bài \'kt2\'. Điểm: 4',1,'2025-11-26 08:07:34.833187',1,3),(15,'Bài kiểm tra mới','Kiểm tra: bkt 3',1,'2025-11-28 02:53:11.973541',1,2),(16,'Bài tập mới','Giáo viên đã giao bài tập: fdhdfhd',1,'2025-11-28 02:55:24.732549',1,2),(17,'Đã có điểm','Bài \'fdhdfhd\' đã chấm.',1,'2025-11-28 03:31:14.344623',1,2),(18,'Đã trả bài','Bài \'fdhdfhd\' đã được trả.',1,'2025-11-28 03:31:17.814754',1,2),(19,'Bài tập mới','Giáo viên đã giao bài tập: chương2',1,'2025-11-29 16:21:52.699111',1,2),(20,'Bài kiểm tra mới','Kiểm tra: giữa kỳ2',1,'2025-12-01 02:06:32.783422',1,2),(21,'Học sinh nộp bài',' đã nộp bài \'giữa kỳ2\'. Điểm: 1',1,'2025-12-06 05:40:52.408413',1,3),(22,'Bài tập mới','Giáo viên đã giao bài tập: bài tập 5',0,'2025-12-19 09:52:39.860258',1,2);
/*!40000 ALTER TABLE `lms_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_progress`
--

DROP TABLE IF EXISTS `lms_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_progress` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `percent` int unsigned NOT NULL,
  `last_activity_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_progress_user_id_course_id_5c1a6d59_uniq` (`user_id`,`course_id`),
  KEY `lms_progress_course_id_9690a800_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_progress_course_id_9690a800_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`),
  CONSTRAINT `lms_progress_user_id_09586d4a_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `lms_progress_chk_1` CHECK ((`percent` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_progress`
--

LOCK TABLES `lms_progress` WRITE;
/*!40000 ALTER TABLE `lms_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `lms_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_question`
--

DROP TABLE IF EXISTS `lms_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_question` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` int NOT NULL,
  `order` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `quiz_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_question_quiz_id_f7fae637_fk_lms_quiz_id` (`quiz_id`),
  CONSTRAINT `lms_question_quiz_id_f7fae637_fk_lms_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `lms_quiz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_question`
--

LOCK TABLES `lms_question` WRITE;
/*!40000 ALTER TABLE `lms_question` DISABLE KEYS */;
INSERT INTO `lms_question` VALUES (8,'1234','single',10,0,'2025-11-21 06:50:14.495436',5),(9,'abc','single',10,0,'2025-11-21 06:50:42.253032',5),(16,'Chiến dịch Điện Biên Phủ diễn ra ở đâu?','single',1,0,'2025-11-26 08:06:53.076271',7),(17,'Chiến dịch Điện Biên Phủ kéo dài bao nhiêu ngày đêm?','single',1,0,'2025-11-26 08:06:53.186651',7),(18,'Ai là người chỉ huy Quân đội Nhân dân Việt Nam trong chiến dịch Điện Biên Phủ?','single',1,0,'2025-11-26 08:06:53.285914',7),(19,'Tướng nào của Pháp chỉ huy quân đội Pháp trong chiến dịch Điện Biên Phủ?','single',1,0,'2025-11-26 08:06:53.393351',7),(20,'Chiến thắng Điện Biên Phủ đã buộc thực dân Pháp phải ký hiệp định nào?','single',1,0,'2025-11-26 08:06:53.507875',7),(22,'Chiến tranh thế giới thứ hai là cuộc chiến tranh diễn ra trên phạm vi?','single',1,0,'2025-12-01 02:04:58.981921',7),(23,'Sự kiện nào sau đây được xem là khởi đầu của Chiến tranh thế giới thứ hai?','single',1,0,'2025-12-01 02:04:59.095102',7),(24,'Chiến tranh thế giới thứ hai kết thúc vào năm nào?','single',1,0,'2025-12-01 02:04:59.209817',7),(25,'Lực lượng nào sau đây KHÔNG thuộc phe Trục trong Chiến tranh thế giới thứ hai?','single',1,0,'2025-12-01 02:04:59.311309',7),(26,'Hậu quả lớn nhất của Chiến tranh thế giới thứ hai là gì?','single',1,0,'2025-12-01 02:04:59.408313',7),(27,'Chủ đề chính của văn bản này là gì?','single',1,0,'2025-12-01 02:06:48.292160',9),(28,'Văn bản này có khả năng là một phần của tài liệu nào?','single',1,0,'2025-12-01 02:06:48.420754',9),(29,'Từ nào sau đây liên quan mật thiết nhất đến chủ đề của văn bản?','single',1,0,'2025-12-01 02:06:48.535565',9),(30,'Đối tượng mục tiêu của văn bản này có thể là ai?','single',1,0,'2025-12-01 02:06:48.658555',9),(31,'Mục đích chính của văn bản có thể là gì?','single',1,0,'2025-12-01 02:06:48.759254',9),(32,'Mục tiêu chính của môn Nhập môn Lập trình là gì?','single',1,0,'2025-12-01 02:10:02.761460',9),(33,'Khái niệm nào sau đây KHÔNG thuộc về các khái niệm cơ bản trong lập trình?','single',1,0,'2025-12-01 02:10:02.889071',9),(34,'Công cụ nào thường được sử dụng để viết và chạy chương trình trong môn Nhập môn Lập trình?','single',1,0,'2025-12-01 02:10:02.992915',9),(35,'Tại sao việc học giải thuật (Algorithm) lại quan trọng trong lập trình?','single',1,0,'2025-12-01 02:10:03.094294',9),(36,'Lỗi cú pháp (Syntax Error) trong lập trình là gì?','single',1,0,'2025-12-01 02:10:03.202905',9),(37,'Lĩnh vực nào đang phát triển AI?','single',1,0,'2025-12-19 10:07:45.769524',10),(38,'Lĩnh vực nào đang tạo ra hệ thống có khả năng học, suy luận và nhận biết?','single',1,0,'2025-12-19 10:08:51.752223',10);
/*!40000 ALTER TABLE `lms_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_quiz`
--

DROP TABLE IF EXISTS `lms_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_quiz` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `author_id` bigint NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_quiz_course_id_b72840ad_fk_lms_course_id` (`course_id`),
  KEY `lms_quiz_author_id_82778e1e_fk_users_user_id` (`author_id`),
  CONSTRAINT `lms_quiz_author_id_82778e1e_fk_users_user_id` FOREIGN KEY (`author_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `lms_quiz_course_id_b72840ad_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_quiz`
--

LOCK TABLES `lms_quiz` WRITE;
/*!40000 ALTER TABLE `lms_quiz` DISABLE KEYS */;
INSERT INTO `lms_quiz` VALUES (5,'giữa kỳ','chọn đáp án đúng',1,'2025-11-21 06:49:51.031239',1,3,'2025-11-21 06:49:51.031239'),(7,'kt2','123',1,'2025-11-26 07:09:11.426104',1,3,'2025-11-26 07:09:11.426104'),(9,'giữa kỳ2','aaa',1,'2025-12-01 02:06:32.763717',1,3,'2025-12-01 02:06:32.763717'),(10,'kiemtra1','abc',1,'2025-12-18 07:50:37.954581',2,3,'2025-12-18 07:50:37.954581');
/*!40000 ALTER TABLE `lms_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_quizsubmission`
--

DROP TABLE IF EXISTS `lms_quizsubmission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_quizsubmission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `score` double NOT NULL,
  `correct_count` int NOT NULL,
  `total_questions` int NOT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `quiz_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_quizsubmission_quiz_id_student_id_978a17c5_uniq` (`quiz_id`,`student_id`),
  KEY `lms_quizsubmission_student_id_9e166d75_fk_users_user_id` (`student_id`),
  CONSTRAINT `lms_quizsubmission_quiz_id_655e9d49_fk_lms_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `lms_quiz` (`id`),
  CONSTRAINT `lms_quizsubmission_student_id_9e166d75_fk_users_user_id` FOREIGN KEY (`student_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_quizsubmission`
--

LOCK TABLES `lms_quizsubmission` WRITE;
/*!40000 ALTER TABLE `lms_quizsubmission` DISABLE KEYS */;
INSERT INTO `lms_quizsubmission` VALUES (2,10,1,2,'2025-11-21 06:51:27.603192',5,2),(4,4,4,5,'2025-11-26 08:07:34.815297',7,2),(5,1,1,10,'2025-12-06 05:40:52.394775',9,2);
/*!40000 ALTER TABLE `lms_quizsubmission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_schedule`
--

DROP TABLE IF EXISTS `lms_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_schedule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `starts_at` datetime(6) NOT NULL,
  `ends_at` datetime(6) NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_schedule_course_id_14fd9644_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_schedule_course_id_14fd9644_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_schedule`
--

LOCK TABLES `lms_schedule` WRITE;
/*!40000 ALTER TABLE `lms_schedule` DISABLE KEYS */;
INSERT INTO `lms_schedule` VALUES (1,'SDFS','2025-11-28 08:44:00.000000','2025-11-17 12:44:00.000000','exam','2025-11-17 08:44:15.881013',1),(2,'buoi2','2025-12-06 08:25:00.000000','2025-11-23 13:26:00.000000','lesson','2025-11-23 08:21:46.280005',1),(4,'buổi 3','2025-11-24 00:00:00.000000','2025-11-25 04:00:00.000000','exam','2025-11-23 10:24:35.930040',1),(5,'bài test','2025-11-26 01:00:00.000000','2025-11-26 04:00:00.000000','deadline','2025-11-23 10:32:21.916847',1),(7,'gjgjfghj','2025-11-28 17:00:00.000000','2025-11-29 17:00:00.000000','lesson','2025-11-28 03:34:02.505527',1);
/*!40000 ALTER TABLE `lms_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_section`
--

DROP TABLE IF EXISTS `lms_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_section` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_section_course_id_2471ac92_fk_lms_course_id` (`course_id`),
  CONSTRAINT `lms_section_course_id_2471ac92_fk_lms_course_id` FOREIGN KEY (`course_id`) REFERENCES `lms_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_section`
--

LOCK TABLES `lms_section` WRITE;
/*!40000 ALTER TABLE `lms_section` DISABLE KEYS */;
INSERT INTO `lms_section` VALUES (10,'chương1',1,'2025-11-30 09:47:24.349290',1),(11,'chương 2',2,'2025-11-30 09:52:28.182586',1);
/*!40000 ALTER TABLE `lms_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_submission`
--

DROP TABLE IF EXISTS `lms_submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lms_submission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer_text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` double DEFAULT NULL,
  `feedback` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `assignment_id` bigint NOT NULL,
  `owner_id` bigint NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_submission_assignment_id_owner_id_1f1679ee_uniq` (`assignment_id`,`owner_id`),
  KEY `lms_submission_owner_id_64f3b6b1_fk_users_user_id` (`owner_id`),
  CONSTRAINT `lms_submission_assignment_id_35dd5981_fk_lms_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `lms_assignment` (`id`),
  CONSTRAINT `lms_submission_owner_id_64f3b6b1_fk_users_user_id` FOREIGN KEY (`owner_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_submission`
--

LOCK TABLES `lms_submission` WRITE;
/*!40000 ALTER TABLE `lms_submission` DISABLE KEYS */;
INSERT INTO `lms_submission` VALUES (1,'submissions/1.1.1.7_Lab_-_Evaluate_Recent_IoT_Attacks_Lê_Trung_Hiếu.docx','fghfg',7,'bt1','2025-11-18 08:25:54.368982','2025-11-23 09:30:23.443478',2,2,'GRADED','2025-11-18 08:25:54.362078'),(2,'submissions/Bài_học_rút_ra_-_kết_luận_UdO9VBa.pptx','',8,'111','2025-11-21 10:34:37.339375','2025-11-23 09:30:59.902306',1,2,'RETURNED','2025-11-21 10:35:09.062583'),(3,'submissions/1.1.1.6_Lab_-_Shodan_Search_Lê_Trung_Hiếu.docx','xzcfs',9,'222','2025-11-23 09:12:25.530431','2025-11-23 09:31:22.767899',3,2,'RETURNED',NULL),(4,'submissions/1_ccRtlOl.1.1.6_Lab_-_Shodan_Search_Lê_Trung_Hiếu.docx','123',5,'123','2025-11-28 03:30:55.499433','2025-11-28 03:31:17.799656',4,2,'RETURNED',NULL);
/*!40000 ALTER TABLE `lms_submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_blacklistedtoken` VALUES (1,'2025-11-17 14:04:05.523287',16),(2,'2025-11-17 14:04:05.524298',14),(3,'2025-11-18 08:00:52.294355',17),(4,'2025-11-18 08:09:55.641574',18),(5,'2025-11-18 09:03:01.128477',22),(6,'2025-11-18 09:14:17.083565',26),(7,'2025-11-18 10:03:12.912725',31),(8,'2025-11-18 10:14:33.230218',34),(9,'2025-11-20 06:45:03.246786',39),(10,'2025-11-20 06:45:47.744689',41),(11,'2025-11-21 06:23:44.096836',42),(12,'2025-11-21 06:24:19.347215',44),(13,'2025-11-21 08:23:09.259215',57),(14,'2025-11-21 08:23:41.225161',56),(15,'2025-11-21 09:23:38.285872',67),(16,'2025-11-21 09:23:44.340367',69),(17,'2025-11-21 10:34:05.680009',84),(18,'2025-11-22 06:57:19.580038',90),(19,'2025-11-22 08:13:05.882684',85),(20,'2025-11-22 08:13:05.895094',91),(21,'2025-11-23 08:19:07.738167',133),(23,'2025-11-23 08:21:12.175020',134),(25,'2025-11-23 13:19:27.756258',157),(26,'2025-11-23 13:19:46.661440',158),(27,'2025-11-24 03:41:07.051925',160),(28,'2025-11-24 06:05:02.521548',164),(30,'2025-11-24 07:04:34.254926',165),(31,'2025-11-26 08:57:09.440119',179),(33,'2025-11-28 02:41:31.222036',196),(34,'2025-11-28 02:43:23.126075',197),(37,'2025-11-29 15:42:06.049145',203),(38,'2025-11-30 09:18:07.010040',215),(39,'2025-11-30 09:18:34.316139',216),(42,'2025-12-01 01:53:11.227771',227),(43,'2025-12-01 01:53:28.615824',230),(46,'2025-12-18 08:57:17.286125',247),(49,'2025-12-18 09:00:50.238316',248),(50,'2025-12-18 11:57:24.976408',254),(53,'2025-12-19 06:45:40.771146',257),(54,'2025-12-19 06:45:58.274011',258),(56,'2025-12-19 08:08:25.709604',261),(58,'2025-12-19 09:24:44.866154',265),(59,'2025-12-19 09:38:23.266938',272);
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `jti` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outs_user_id_83bc629a_fk_users_use` (`user_id`),
  CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES (1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3MjgxNiwiaWF0IjoxNzYzMzY4MDE2LCJqdGkiOiI2N2ZhM2RkM2JjZjM0ODEyOGEwYjMzYjIxN2FlY2Q1MiIsInVzZXJfaWQiOiIyIn0.Grss72yD-y6G_9BlNpJYFTuJ6duivlVxjcu0Rc1IPsM','2025-11-17 08:26:56.739074','2025-11-24 08:26:56.000000',2,'67fa3dd3bcf348128a0b33b217aecd52'),(2,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3Mjg5OSwiaWF0IjoxNzYzMzY4MDk5LCJqdGkiOiI2YmNiMGE1Yzk1Y2I0MjA1YWRlZjE2ZGQ5Njc2NzU0NiIsInVzZXJfaWQiOiIxIn0.HiSCtvhAd1MKraFuwAs04WpcSutVk2S9FOyqIf49Lbw','2025-11-17 08:28:19.765704','2025-11-24 08:28:19.000000',1,'6bcb0a5c95cb4205adef16dd96767546'),(3,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3MzA4NSwiaWF0IjoxNzYzMzY4Mjg1LCJqdGkiOiI4NGFjYmRkYzI5NTk0M2ZhODFlMWUyZTc0NjFjY2IyZiIsInVzZXJfaWQiOiIxIn0.UXu_Qjm2GGKXris2MB8Zt8B3J1oReQ2UHcmXydkT-5A','2025-11-17 08:31:25.268528','2025-11-24 08:31:25.000000',1,'84acbddc295943fa81e1e2e7461ccb2f'),(4,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3MzQzNCwiaWF0IjoxNzYzMzY4NjM0LCJqdGkiOiJjMzI3NDIzMWRhNTE0ZmViOTJlMzRiMzg1MWNmNjZlMyIsInVzZXJfaWQiOiIzIn0.uo9MtU_r1YmyNTo3apiXEGdGYm1NuDCTjLCHMLTqSMM','2025-11-17 08:37:14.064020','2025-11-24 08:37:14.000000',3,'c3274231da514feb92e34b3851cf66e3'),(5,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3MzUyMiwiaWF0IjoxNzYzMzY4NzIyLCJqdGkiOiI3YmQyOGJjYjAxMjE0NzM3YWI5NmJjZTRhMzAzYWUyNiIsInVzZXJfaWQiOiIyIn0.YvD1nz2uSKCqr2X6OM_5UcM5SO40CrXu3lvVOPIjUno','2025-11-17 08:38:42.325218','2025-11-24 08:38:42.000000',2,'7bd28bcb01214737ab96bce4a303ae26'),(6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3MzU4MiwiaWF0IjoxNzYzMzY4NzgyLCJqdGkiOiJjOWQyZGMyOGVjM2Q0YzBiYWUyZWU4ODMwODNkYTFhMyIsInVzZXJfaWQiOiIyIn0.hrcfFjWbf2P0r_9He9D8b_bKIT1vX58r0C_7IZqaLT0','2025-11-17 08:39:42.004815','2025-11-24 08:39:42.000000',2,'c9d2dc28ec3d4c0bae2ee883083da1a3'),(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3MzU4OSwiaWF0IjoxNzYzMzY4Nzg5LCJqdGkiOiI1NTBjNjIwMDAwYTQ0NTlmYTM2NjI1ZjI0ZDZkNjM2OSIsInVzZXJfaWQiOiIzIn0.glhiQfaKMEMEWqu-8zsZ-wCVvgQwV5Z_NIV_8Xwnrow','2025-11-17 08:39:49.720710','2025-11-24 08:39:49.000000',3,'550c620000a4459fa36625f24d6d6369'),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3NDAxMSwiaWF0IjoxNzYzMzY5MjExLCJqdGkiOiJmYjA0NTNhZjFkMDM0ZWM2OThhZjYyNjViNjIyYWQyMiIsInVzZXJfaWQiOiIzIn0.mvuW4RB_wFLEB6CLiYgLwjg3Fk3T9AUR0jk5TYzOU-Q','2025-11-17 08:46:51.879111','2025-11-24 08:46:51.000000',3,'fb0453af1d034ec698af6265b622ad22'),(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3NDA2OCwiaWF0IjoxNzYzMzY5MjY4LCJqdGkiOiJlMmQwMDhmMWE3NGU0M2MwOGMwOWVmZTlhMjVhYzAwNiIsInVzZXJfaWQiOiIyIn0.tzP2_kPOY0anhxm0ipB58ZwFP9qgHQ4GK28VquK9sOk','2025-11-17 08:47:48.781013','2025-11-24 08:47:48.000000',2,'e2d008f1a74e43c08c09efe9a25ac006'),(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3NDA3OSwiaWF0IjoxNzYzMzY5Mjc5LCJqdGkiOiIxZWQzMTAwYWQ4MzA0MmM4YTBlZjVhODRlMTBjZDFlOCIsInVzZXJfaWQiOiIyIn0.KvebRMLMBMHxtl2d7vhDrPe-qu2ulXM9cxYkqqKhpgo','2025-11-17 08:47:59.182850','2025-11-24 08:47:59.000000',2,'1ed3100ad83042c8a0ef5a84e10cd1e8'),(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3NTE1MiwiaWF0IjoxNzYzMzcwMzUyLCJqdGkiOiJjNzJhMzMxOGUwZWM0M2M3YTUxMTVkYzM2OWI4Y2YwZiIsInVzZXJfaWQiOiIzIn0.wYarsO27sbOUQkBb35wXaCRVgyfuZUjPChvQXv57Zww','2025-11-17 09:05:52.637711','2025-11-24 09:05:52.000000',3,'c72a3318e0ec43c7a5115dc369b8cf0f'),(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3NzIyNiwiaWF0IjoxNzYzMzcyNDI2LCJqdGkiOiI3MTE5YTkyZTI2Y2I0ZTY2OTZhZGExNjQ5MDlhNDRmZSIsInVzZXJfaWQiOiIyIn0.b5yUA3K_4-H78z1DF6iFqDGVRpLnyzKfX6wY6aYik7c','2025-11-17 09:40:26.566688','2025-11-24 09:40:26.000000',2,'7119a92e26cb4e6696ada164909a44fe'),(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3NzM0NiwiaWF0IjoxNzYzMzcyNTQ2LCJqdGkiOiIwY2NkNWE1M2UyYTY0NjNmODY5NDczM2QyZmU3NDY4YSIsInVzZXJfaWQiOiIzIn0.ZTv9eb-4r_ZOgcoj6I2be3KjUTlPIYmrjmMwxjH4RM8','2025-11-17 09:42:26.605854','2025-11-24 09:42:26.000000',3,'0ccd5a53e2a6463f8694733d2fe7468a'),(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3ODg1NCwiaWF0IjoxNzYzMzc0MDU0LCJqdGkiOiJhZTUxY2MyNDJkZjY0NmRmOTU1NDVhOWIxMWM5ZDQyMyIsInVzZXJfaWQiOiIyIn0.cxhWax_4x2oI-_bXVLFhQmzB1-b-SAzkTW9bNQHamE4','2025-11-17 10:07:34.136232','2025-11-24 10:07:34.000000',2,'ae51cc242df646df95545a9b11c9d423'),(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3OTE4MiwiaWF0IjoxNzYzMzc0MzgyLCJqdGkiOiJhMGI5ZDdlZGFhYTg0MjlmOWE2NWMwN2RlYTc0OTAwZiIsInVzZXJfaWQiOiIzIn0.tNlzHxlSZD7D-ef60PHJzG-FvBHip8OwcH7aUWlhYx8','2025-11-17 10:13:02.653061','2025-11-24 10:13:02.000000',3,'a0b9d7edaaa8429f9a65c07dea74900f'),(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk3OTM5OSwiaWF0IjoxNzYzMzc0NTk5LCJqdGkiOiI4MDNlYjYyMGM3OWU0YThhYmU3NTliMWM2OGYwNDU2NyIsInVzZXJfaWQiOiIzIn0.oyYQd7PNcAWcs0LrxHHaL0kwd5sNAmA4AQaPSy2DEuA','2025-11-17 10:16:39.688242','2025-11-24 10:16:39.000000',3,'803eb620c79e4a8abe759b1c68f04567'),(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk5MzA0NSwiaWF0IjoxNzYzMzg4MjQ1LCJqdGkiOiJjZDJjY2MwOTlkMzk0Y2U1OTBkOWUzYzZlNzZjYWMwZSIsInVzZXJfaWQiOiIyIn0.5DRphOrnrycmuTnbGHWdqt8JrRa1tLh4NQJFztyzpac','2025-11-17 14:04:05.482346','2025-11-24 14:04:05.000000',2,'cd2ccc099d394ce590d9e3c6e76cac0e'),(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk5MzA0NSwiaWF0IjoxNzYzMzg4MjQ1LCJqdGkiOiJhY2FjMzVlMWJhOWE0NWU5YTY1YTYxMTg4OGZiOGZhOCIsInVzZXJfaWQiOiIzIn0.EVN0VAIRYUTILpk_r7Hx8RkE18JOOpxChJEggA-jfu4','2025-11-17 14:04:05.480023','2025-11-24 14:04:05.000000',3,'acac35e1ba9a45e9a65a611888fb8fa8'),(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk5MzM3NCwiaWF0IjoxNzYzMzg4NTc0LCJqdGkiOiI1Mjk0ZDdlYzIwMzU0MTM1ODA4MjAxYjhkN2MyNmM2MyIsInVzZXJfaWQiOiIzIn0.x_HGWjriPEb0IaVImcwTLRv3CblDRK7qHPWf7b5gUCs','2025-11-17 14:09:34.025573','2025-11-24 14:09:34.000000',3,'5294d7ec20354135808201b8d7c26c63'),(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk5NTA3MywiaWF0IjoxNzYzMzkwMjczLCJqdGkiOiJmYTJiNjkzZDIyYjk0MjFlYWI5NDYxOTliNDE4YzljZCIsInVzZXJfaWQiOiIzIn0.CfJ9GIO34suy4NwGZ7KsC1euQ0E6E4ZsVPvgVwAjB38','2025-11-17 14:37:53.908042','2025-11-24 14:37:53.000000',3,'fa2b693d22b9421eab946199b418c9cd'),(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzk5NTE5NCwiaWF0IjoxNzYzMzkwMzk0LCJqdGkiOiJlMWY4ZjVkN2VlNmU0MmI1YTNlNTI2ZTJkMjg3NTkyMSIsInVzZXJfaWQiOiIyIn0.lUnkXTqL1mm0JYRHHosj6asmS-ztuPP8-cPTYK67EhM','2025-11-17 14:39:54.143148','2025-11-24 14:39:54.000000',2,'e1f8f5d7ee6e42b5a3e526e2d2875921'),(22,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA1NzY1MiwiaWF0IjoxNzYzNDUyODUyLCJqdGkiOiI1NzVkMzIyOGFiNTE0ZmIyODM0NjdiYzk4M2ViMzZkMyIsInVzZXJfaWQiOiIyIn0.y0MERTQTG9XrttdkdRuoeTqKYf8uqqUdziIsDWvadUg','2025-11-18 08:00:52.222901','2025-11-25 08:00:52.000000',2,'575d3228ab514fb283467bc983eb36d3'),(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA1ODEwMywiaWF0IjoxNzYzNDUzMzAzLCJqdGkiOiIwZjUyYTBmNjk0NDk0ZjdlODcxMWZkMjg5NThiZjI4YiIsInVzZXJfaWQiOiIyIn0.1bgM_xX0ggO7bq5brGlLbi0QIiSdgfXh3KQJLeDocQw','2025-11-18 08:08:23.681975','2025-11-25 08:08:23.000000',2,'0f52a0f694494f7e8711fd28958bf28b'),(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA1ODE0MywiaWF0IjoxNzYzNDUzMzQzLCJqdGkiOiJlNzdmNWMzYzNkNWQ0OWJjODE5OWZiZWM0MzZhOWEyNSIsInVzZXJfaWQiOiIyIn0.lhRKB11QwFsVRT-9lid9ywRWASdLrev5j92ALfmt0eQ','2025-11-18 08:09:03.147080','2025-11-25 08:09:03.000000',2,'e77f5c3c3d5d49bc8199fbec436a9a25'),(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA1ODE1MCwiaWF0IjoxNzYzNDUzMzUwLCJqdGkiOiI0Y2I4ZmQ1YzA3ZTY0OTAwODRhZDE2NGViNjk1NjBjZSIsInVzZXJfaWQiOiIyIn0.dWQYjRpE-QzFDXcp6AuzhP5r5YWXTn8b_XXkN_Z3SX8','2025-11-18 08:09:10.271376','2025-11-25 08:09:10.000000',2,'4cb8fd5c07e6490084ad164eb69560ce'),(26,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA1ODE5NSwiaWF0IjoxNzYzNDUzMzk1LCJqdGkiOiJhZTBlNWExYTNjMjE0OGVjOGJhZWQyMTU3NTcwZjYyMiIsInVzZXJfaWQiOiIzIn0.JBLUX7_-vKwp1fO_TTRE3qXxYf1JY_Xjb5jLVqqgjU4','2025-11-18 08:09:55.615138','2025-11-25 08:09:55.000000',3,'ae0e5a1a3c2148ec8baed2157570f622'),(27,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA1OTEyOSwiaWF0IjoxNzYzNDU0MzI5LCJqdGkiOiI5YmNmMjNhOWExNDc0MmQ4YWU3ZjJkM2Q1YWJlMWU0ZiIsInVzZXJfaWQiOiIyIn0.0bUtRp_s6RsDnecb_KpSpf7U6qo6ptT5sGk7Ta-FyXI','2025-11-18 08:25:29.723319','2025-11-25 08:25:29.000000',2,'9bcf23a9a14742d8ae7f2d3d5abe1e4f'),(28,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA1OTE5MCwiaWF0IjoxNzYzNDU0MzkwLCJqdGkiOiIzNGVlYjZhZDRhYWM0NTM4OWFhM2E3MGFiNjMwNWE4NyIsInVzZXJfaWQiOiIzIn0.hQnj-pqejUUNfGe06B4jlb8HvlGF2l_3J1UxW5o87bY','2025-11-18 08:26:30.409417','2025-11-25 08:26:30.000000',3,'34eeb6ad4aac45389aa3a70ab6305a87'),(29,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2MDk1OSwiaWF0IjoxNzYzNDU2MTU5LCJqdGkiOiJjN2E0ZTQxMzU0MmU0MjMyOWJiZTE4MmRjMGFmZTA2NCIsInVzZXJfaWQiOiIzIn0.XXqBESBRImauDWzZqV568HYB-BSOMxuAb-MlkpzTY9o','2025-11-18 08:55:59.514182','2025-11-25 08:55:59.000000',3,'c7a4e413542e42329bbe182dc0afe064'),(30,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2MDk4MywiaWF0IjoxNzYzNDU2MTgzLCJqdGkiOiJjMTdjZGYxODEwNWQ0ZDZlOTU3Yjg3NTNmMTllODgwZCIsInVzZXJfaWQiOiIyIn0.U1gkQY5px2-HonMbZ8jqGIKExptPkBvQAs3bTgaeCYY','2025-11-18 08:56:23.582508','2025-11-25 08:56:23.000000',2,'c17cdf18105d4d6e957b8753f19e880d'),(31,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2MTM4MSwiaWF0IjoxNzYzNDU2NTgxLCJqdGkiOiJmNDU3MzkxYjAyYjY0NmY1YjJmYzYxZDk2NWRmMzEzOSIsInVzZXJfaWQiOiIyIn0.C8unjTiY6oNsUybMhE-BUQXR-sCgWnS-ePAcq5wEHlY','2025-11-18 09:03:01.113378','2025-11-25 09:03:01.000000',2,'f457391b02b646f5b2fc61d965df3139'),(32,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2MjA0MSwiaWF0IjoxNzYzNDU3MjQxLCJqdGkiOiI3ODE1ZGNkZDMxYzc0MjlmODcyY2E1YzVkMzk4ZWU5OCIsInVzZXJfaWQiOiIyIn0.hKA6_oX0Z0zuR2iF1orBItFdJmpKwSogwNNFwedpghU','2025-11-18 09:14:01.170287','2025-11-25 09:14:01.000000',2,'7815dcdd31c7429f872ca5c5d398ee98'),(33,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2MjA1NiwiaWF0IjoxNzYzNDU3MjU2LCJqdGkiOiI4NTUyYjJlNjliZDI0NzA4OTRiOWY3YzYzZGFkMjg0NSIsInVzZXJfaWQiOiIzIn0.JOJb6geiYb0NvrKNB3xvIqtHTQAWs14RVpWCJwQD9GM','2025-11-18 09:14:16.980775','2025-11-25 09:14:16.000000',3,'8552b2e69bd2470894b9f7c63dad2845'),(34,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2MjA1NywiaWF0IjoxNzYzNDU3MjU3LCJqdGkiOiJhNTIxNWViNTJjMjA0NjM0OGZlY2UxMjNkNTEwNzQ0YSIsInVzZXJfaWQiOiIzIn0.VaYfd6eH7DCji9FCpdLI2oXLzXDS7lMK1EIqXEZ41pc','2025-11-18 09:14:17.064038','2025-11-25 09:14:17.000000',3,'a5215eb52c2046348fece123d510744a'),(35,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2Mjk4NiwiaWF0IjoxNzYzNDU4MTg2LCJqdGkiOiJmZDUyZmYxZjVjNmQ0MzA1YjNjZGRiOTM3M2M1ZGUzNSIsInVzZXJfaWQiOiIzIn0.nKoOaTkZMzludtQFxPv5ZnDAL5eBxE5nE54vfxX_CKk','2025-11-18 09:29:46.840347','2025-11-25 09:29:46.000000',3,'fd52ff1f5c6d4305b3cddb9373c5de35'),(36,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2NDA1OCwiaWF0IjoxNzYzNDU5MjU4LCJqdGkiOiI4NzlhMWM1OThkMTc0OGMzODI2ODAxYzIyMGEyODVkOCIsInVzZXJfaWQiOiIzIn0.wtRhm9FUEmlSQ0I64zDGNFvAZt58VZTEAjLyngopu8o','2025-11-18 09:47:38.933949','2025-11-25 09:47:38.000000',3,'879a1c598d1748c3826801c220a285d8'),(37,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2NDkzNywiaWF0IjoxNzYzNDYwMTM3LCJqdGkiOiI1OGFlZjdlYTMxYzU0ODRkOWY0NjA1NDdlMTY3YWFjOCIsInVzZXJfaWQiOiIyIn0.-Fh5FvO3CZYq9X23etU_ACVy7Tt1o26GWpYev95_rLw','2025-11-18 10:02:17.910201','2025-11-25 10:02:17.000000',2,'58aef7ea31c5484d9f460547e167aac8'),(38,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2NDk1MiwiaWF0IjoxNzYzNDYwMTUyLCJqdGkiOiIzYjE1MzZiN2Y4ODI0ZGU1YjJiMmNiNWI5NmNiNzUwNCIsInVzZXJfaWQiOiIzIn0.xQePxvI-UXdmiG6Bu5J9xUy1tPUNhbg6Es_L3CEBfE0','2025-11-18 10:02:32.609802','2025-11-25 10:02:32.000000',3,'3b1536b7f8824de5b2b2cb5b96cb7504'),(39,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2NDk5MiwiaWF0IjoxNzYzNDYwMTkyLCJqdGkiOiJhMWM2YTRkMGNlMTU0MWYyYmU4MWFmOTU5ZGZjNmM3NiIsInVzZXJfaWQiOiIyIn0.WfVeg8JYAKu3j1wyePWFl8vEViSWJ-l6Ye3BmBgJWLw','2025-11-18 10:03:12.896105','2025-11-25 10:03:12.000000',2,'a1c6a4d0ce1541f2be81af959dfc6c76'),(40,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2NTU0OSwiaWF0IjoxNzYzNDYwNzQ5LCJqdGkiOiJiYTg0ZDU0ZjQ5OTc0YWM1OWM3ZWZjNGM2OWQ3ZmYzNyIsInVzZXJfaWQiOiIyIn0.fCZ1JySE2ppQU2NYdJ6U-8qcCGP_4gJcJjG41086Y-w','2025-11-18 10:12:29.236208','2025-11-25 10:12:29.000000',2,'ba84d54f49974ac59c7efc4c69d7ff37'),(41,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA2NTY3MywiaWF0IjoxNzYzNDYwODczLCJqdGkiOiI2YTNkMTIzMDE1ZDY0ZmVmOTg1ZTJiN2I3NjQwZDNlZiIsInVzZXJfaWQiOiIzIn0.472lot-4V8311UxcudnoMcuGV9u3ES7qoSiMQGFnPcI','2025-11-18 10:14:33.212950','2025-11-25 10:14:33.000000',3,'6a3d123015d64fef985e2b7b7640d3ef'),(42,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDIyNTkwMywiaWF0IjoxNzYzNjIxMTAzLCJqdGkiOiI0Njk4OGY5ZWFmYzg0MGU1YWQ4YzkyODUzOTk0NGU2NSIsInVzZXJfaWQiOiIyIn0.KKu5dpg4jEHR_an6pAyrEoK_DOp5ja6KZ0cECj2iQhQ','2025-11-20 06:45:03.112563','2025-11-27 06:45:03.000000',2,'46988f9eafc840e5ad8c928539944e65'),(43,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDIyNTkwNSwiaWF0IjoxNzYzNjIxMTA1LCJqdGkiOiJjMWMxZTllNjk4ZGM0YTQyOWFiYmQ3OThlNTMwYzhkZSIsInVzZXJfaWQiOiIyIn0.OvzBs3AAbLFYGZuDyadvfhQmxgLg-v5YDxAQQ0TT7VM','2025-11-20 06:45:05.727664','2025-11-27 06:45:05.000000',2,'c1c1e9e698dc4a429abbd798e530c8de'),(44,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDIyNTk0NywiaWF0IjoxNzYzNjIxMTQ3LCJqdGkiOiI3ZTkyMjYwNGM2YzM0MGJmOGI1YTIyYjIxODJhZWUzNSIsInVzZXJfaWQiOiIzIn0.5sIOqzIOGVG9LCk9S6u_wUStzLSK_yk02ZgmL5enHrA','2025-11-20 06:45:47.728908','2025-11-27 06:45:47.000000',3,'7e922604c6c340bf8b5a22b2182aee35'),(45,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDIyNjUwNSwiaWF0IjoxNzYzNjIxNzA1LCJqdGkiOiJmOWQ0MTRjOTQ3ZGU0Y2Q1OTg3ZDUzY2Y4MTg3MDJiYyIsInVzZXJfaWQiOiIyIn0.SEgbokgjyhnrdRWebr24Ba0pq_waQLThEVrdVNrXQbA','2025-11-20 06:55:05.499157','2025-11-27 06:55:05.000000',2,'f9d414c947de4cd5987d53cf818702bc'),(46,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDIyNjU2MCwiaWF0IjoxNzYzNjIxNzYwLCJqdGkiOiIyYjVhYmEzMmZhMTE0ZjQwYmVmOGM4YjI4NzMxZWE1NiIsInVzZXJfaWQiOiIzIn0.ruG3E-V0lmWPDeX1hkDsYxA6LCtD2bVT_T2kT8m_U0I','2025-11-20 06:56:00.411198','2025-11-27 06:56:00.000000',3,'2b5aba32fa114f40bef8c8b28731ea56'),(47,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMTAyMywiaWF0IjoxNzYzNzA2MjIzLCJqdGkiOiJhMjc2YjUyMDI3ZjE0ODI1YWY5NDc0NTA0MjEwODZkZSIsInVzZXJfaWQiOiIyIn0.CJ8e5AYoYHaYP3OrshDrhp7Jjpg8u0noIEAPsUV88tM','2025-11-21 06:23:43.844429','2025-11-28 06:23:43.000000',2,'a276b52027f14825af947450421086de'),(48,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMTAyNSwiaWF0IjoxNzYzNzA2MjI1LCJqdGkiOiIwOGNmYWEwMTExNWM0ZGU3YWRhODMwZGZjNjc3ZTc4NyIsInVzZXJfaWQiOiIyIn0.g39H95TlDWwjgZojqxxTDddqax-i72K_xwwEBxw8U7g','2025-11-21 06:23:45.821673','2025-11-28 06:23:45.000000',2,'08cfaa01115c4de7ada830dfc677e787'),(49,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMTA1OSwiaWF0IjoxNzYzNzA2MjU5LCJqdGkiOiIyMjc0NmYwYjRmMzU0ODA3OTQzMTUyMzkxZjJmZDJlNyIsInVzZXJfaWQiOiIzIn0.g1mT3QxRzox3Un97k-04EXqQqPU_J7AiMaMTTa8FdIc','2025-11-21 06:24:19.327996','2025-11-28 06:24:19.000000',3,'22746f0b4f354807943152391f2fd2e7'),(50,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMjE5NSwiaWF0IjoxNzYzNzA3Mzk1LCJqdGkiOiJjNGEwYzIwZmRlNmY0OTI4YTIxMThlYmNhMDExMDQ4NCIsInVzZXJfaWQiOiIyIn0.h80o2IxZCiQL3nbnbqNcwXSHOiNTtrW8y4GpBMqt13w','2025-11-21 06:43:15.017942','2025-11-28 06:43:15.000000',2,'c4a0c20fde6f4928a2118ebca0110484'),(51,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMjIxNiwiaWF0IjoxNzYzNzA3NDE2LCJqdGkiOiIxZmZhOWQxYzM2ZDM0YjQ1ODQ2ODhhZjI4ZDg1M2MxNiIsInVzZXJfaWQiOiIzIn0.O8wJBPvhjq8BVNQRPWn9X5KwaWLODmHAMFiv_e7CmnY','2025-11-21 06:43:36.296652','2025-11-28 06:43:36.000000',3,'1ffa9d1c36d34b4584688af28d853c16'),(52,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMjUxMCwiaWF0IjoxNzYzNzA3NzEwLCJqdGkiOiIzM2U0YTJlMjk1OTQ0ZTY3YmRkNzJiYmU0M2JjMzA0OSIsInVzZXJfaWQiOiIzIn0.fRJBY0szeNZsuGWsibTaulTcdodRKUdVO8iXhxOBxX0','2025-11-21 06:48:30.546052','2025-11-28 06:48:30.000000',3,'33e4a2e295944e67bdd72bbe43bc3049'),(53,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMjU1MywiaWF0IjoxNzYzNzA3NzUzLCJqdGkiOiIyMmZkODcxYjlkYTQ0ZDFlOTBjZjEwNWY1NjZlOWY2NSIsInVzZXJfaWQiOiIyIn0.yYAl6OTriKRNYOSGEFpxiwcsQ10LZXjk-D_wpR_iK0A','2025-11-21 06:49:13.661741','2025-11-28 06:49:13.000000',2,'22fd871b9da44d1e90cf105f566e9f65'),(54,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMjk5NCwiaWF0IjoxNzYzNzA4MTk0LCJqdGkiOiIwYzFjMDQ1MWZlZGI0MmRhYTYyOTUxZTJiMTc5ZGFmNyIsInVzZXJfaWQiOiIyIn0.MY5wl1GNCrOkJsReczPT2so7BpCh-u9rE50pB8jJcmE','2025-11-21 06:56:34.624782','2025-11-28 06:56:34.000000',2,'0c1c0451fedb42daa62951e2b179daf7'),(55,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxMzAwNywiaWF0IjoxNzYzNzA4MjA3LCJqdGkiOiIwYjEzNTZhMzQ0MmY0N2M3YTI5N2RhZTQ1OGQ4YWYyMSIsInVzZXJfaWQiOiIzIn0.r_MpiCtdRbhbjR0gwppykEEvJNXOrepdukpjh0OXHOQ','2025-11-21 06:56:47.563877','2025-11-28 06:56:47.000000',3,'0b1356a3442f47c7a297dae458d8af21'),(56,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNDU1MiwiaWF0IjoxNzYzNzA5NzUyLCJqdGkiOiI4YTU0ZjU2Zjg0NzU0ODc0YmI2OTc1NDk0N2YyZGQ4MyIsInVzZXJfaWQiOiIzIn0.cDsI22d0i_tJd2yATBip5XsgD05eY-I_-s9pEfWgE4o','2025-11-21 07:22:32.663352','2025-11-28 07:22:32.000000',3,'8a54f56f84754874bb69754947f2dd83'),(57,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNDU3NCwiaWF0IjoxNzYzNzA5Nzc0LCJqdGkiOiI0NDY3NTJjNzVlOTU0YzhhYTRhN2QwNjIwMmFmZmI2NSIsInVzZXJfaWQiOiIyIn0.CmEhpsFphYXRw1TohKloDo8bNMqBHp59I7mvJHcjMQU','2025-11-21 07:22:54.778524','2025-11-28 07:22:54.000000',2,'446752c75e954c8aa4a7d06202affb65'),(58,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNjQ1NiwiaWF0IjoxNzYzNzExNjU2LCJqdGkiOiI3OGU1ZWQwNDBkMWI0ZDNkOTA3ZWZmNmU3ODg4MjRmNCIsInVzZXJfaWQiOiIyIn0.vZESTusdBqs4qvfztDY0_eaawT-5VZNOUqigTaUynpE','2025-11-21 07:54:16.141744','2025-11-28 07:54:16.000000',2,'78e5ed040d1b4d3d907eff6e788824f4'),(59,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNjU0NiwiaWF0IjoxNzYzNzExNzQ2LCJqdGkiOiJlZDk1MWY3NzFjMWE0ZWZmYmUyMDYxNWI0NjcwNGZiMCIsInVzZXJfaWQiOiIzIn0.wo8Gny5ltZcFIQ5dl2pLS9Lc7aVuXkwPVbrXnT0Cy8A','2025-11-21 07:55:46.424696','2025-11-28 07:55:46.000000',3,'ed951f771c1a4effbe20615b46704fb0'),(60,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNjg0NywiaWF0IjoxNzYzNzEyMDQ3LCJqdGkiOiI5YzllNzQ0ZjEzY2I0NDkyOGFiMjUzNTMzZDliMTMyNCIsInVzZXJfaWQiOiIzIn0.LUuZYFCgqrt_O8tfJ5ZQFEGgs_ccc34Ecz7mthIzgaQ','2025-11-21 08:00:47.960077','2025-11-28 08:00:47.000000',3,'9c9e744f13cb44928ab253533d9b1324'),(61,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNjk0MSwiaWF0IjoxNzYzNzEyMTQxLCJqdGkiOiI1YzFhNjliNjQ4YjY0MmFlOTU2NDlhMDQ0YzliNWI1OSIsInVzZXJfaWQiOiIzIn0.rhzm_w0UYU5kxlfjRHcMYkS3638hG5ekfD-j01dvkVM','2025-11-21 08:02:21.639936','2025-11-28 08:02:21.000000',3,'5c1a69b648b642ae95649a044c9b5b59'),(62,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNjk1MywiaWF0IjoxNzYzNzEyMTUzLCJqdGkiOiI3M2FkOTc4MWVmZmE0Yzc4ODY2NzA1MWQ3YWUwNGIwNyIsInVzZXJfaWQiOiIyIn0.zqAtu4UspD8aTuA8GQ6fVnZT-8GkbqtUdbCC0MHSEg8','2025-11-21 08:02:33.818722','2025-11-28 08:02:33.000000',2,'73ad9781effa4c788667051d7ae04b07'),(63,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNzQ2OSwiaWF0IjoxNzYzNzEyNjY5LCJqdGkiOiI5MDNmNjgzMzRkNDI0ZmFjYTUxNDJhOTA5ZjcxNDcxNSIsInVzZXJfaWQiOiIzIn0.t-loq_vtfEeDIdwy_ZlVCZQFmS_xAI0VBnG74fquklI','2025-11-21 08:11:09.874374','2025-11-28 08:11:09.000000',3,'903f68334d424faca5142a909f714715'),(64,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNzQ4MiwiaWF0IjoxNzYzNzEyNjgyLCJqdGkiOiJlMWI3MmI4ZmU5MzA0OTRhYWNmNTE4YzFkYmZmM2MwYyIsInVzZXJfaWQiOiIyIn0.7mdgVWabiP4LPDxjW_PqR__2Fi8iihfLdF8Eg_HnhLU','2025-11-21 08:11:22.310708','2025-11-28 08:11:22.000000',2,'e1b72b8fe930494aacf518c1dbff3c0c'),(65,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNzc0MCwiaWF0IjoxNzYzNzEyOTQwLCJqdGkiOiJjNzBkMWFhOGFmZDU0NmI0YmViYmVjNTA2MGUzM2I4ZCIsInVzZXJfaWQiOiIzIn0.1UdgroYeCJz6p5O7rlnoArRVlab5ilcIhhQfSux0onw','2025-11-21 08:15:40.858169','2025-11-28 08:15:40.000000',3,'c70d1aa8afd546b4bebbec5060e33b8d'),(66,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNzc0OCwiaWF0IjoxNzYzNzEyOTQ4LCJqdGkiOiIzOTQ1ODk4YWY1OTM0YjgxOWFkZGRhZjk3NzU4ZjcxZCIsInVzZXJfaWQiOiIyIn0.w95Pd661P7wrb7uZ0fs__oRBNdnNzhAk2YxJOkbpilc','2025-11-21 08:15:48.671828','2025-11-28 08:15:48.000000',2,'3945898af5934b819adddaf97758f71d'),(67,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODE4OSwiaWF0IjoxNzYzNzEzMzg5LCJqdGkiOiI3OThhMjg0NjdjNjI0MjNhYjAxNGY5M2VhY2M2ZWYxZCIsInVzZXJfaWQiOiIyIn0.iOOj-jPAb2CAo5a5SDX21u7u4TTqUVOpQGU-lOi8K4g','2025-11-21 08:23:09.244482','2025-11-28 08:23:09.000000',2,'798a28467c62423ab014f93eacc6ef1d'),(68,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODIwMywiaWF0IjoxNzYzNzEzNDAzLCJqdGkiOiJiOTE3NTNlMDE5ODM0MGM4YmZhODM1MjVlMGU4MjZjYiIsInVzZXJfaWQiOiIyIn0.Hi8v2JGF0KFuPyHE7dkQ7YTFqRCyCyMkL4Kc9V709GA','2025-11-21 08:23:23.587924','2025-11-28 08:23:23.000000',2,'b91753e0198340c8bfa83525e0e826cb'),(69,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODIyMSwiaWF0IjoxNzYzNzEzNDIxLCJqdGkiOiJhM2U2NjNhOTAzM2E0YjAxYWI1ZTcwYmMyYzA0ODU2MSIsInVzZXJfaWQiOiIzIn0.AAz1CQOvZC0gbqos1ainnerDs-gptWYjhS7IVKYOBCU','2025-11-21 08:23:41.215341','2025-11-28 08:23:41.000000',3,'a3e663a9033a4b01ab5e70bc2c048561'),(70,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODU1NiwiaWF0IjoxNzYzNzEzNzU2LCJqdGkiOiJmZGMxNGNkMDg4OTk0YTFmODlkNzFjNThjNWM3ZjE3ZSIsInVzZXJfaWQiOiIzIn0.gRZr9uWNZyD4z07B3L6V0INa7jk7hlBKjLO6-K_wTrA','2025-11-21 08:29:16.562767','2025-11-28 08:29:16.000000',3,'fdc14cd088994a1f89d71c58c5c7f17e'),(71,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODYwNywiaWF0IjoxNzYzNzEzODA3LCJqdGkiOiJhOTkwMGU5MWM5MjU0ZGYzYjg4ZWZjMGUyZDcwZDJlZCIsInVzZXJfaWQiOiIyIn0.yvK6G93mxXVK-Eg__IMs2_-FSguF0oqSCJV1fsGCVOc','2025-11-21 08:30:07.055257','2025-11-28 08:30:07.000000',2,'a9900e91c9254df3b88efc0e2d70d2ed'),(72,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODg0NCwiaWF0IjoxNzYzNzE0MDQ0LCJqdGkiOiJlNTMzNTQ4MmJlM2Q0YzE5YmViYmM0NzRhOGU0ZmUxMyIsInVzZXJfaWQiOiIyIn0.0PwDgR3SmywvnEMHEAo5qDS1OI7Zc53AhQociVD9mMs','2025-11-21 08:34:04.085124','2025-11-28 08:34:04.000000',2,'e5335482be3d4c19bebbc474a8e4fe13'),(73,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODg1MCwiaWF0IjoxNzYzNzE0MDUwLCJqdGkiOiJkM2U2ZjNkNzZjNjE0ODg4OTdkNDA5MTY5NTRhMGQ1MSIsInVzZXJfaWQiOiIzIn0.7GsAOguHgOYkOUuICAPLts6eflnBoBvlD0ZL8mcU6x0','2025-11-21 08:34:10.774761','2025-11-28 08:34:10.000000',3,'d3e6f3d76c61488897d40916954a0d51'),(74,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxOTA5NSwiaWF0IjoxNzYzNzE0Mjk1LCJqdGkiOiIzMjk1M2E5NWFlNjc0NmIyOGU3OWY0ZWU4ZDhiNThhMSIsInVzZXJfaWQiOiIyIn0.qoCZ09dnKyTSIeiAfpzFOygTU_IHbjheRvYsbbsv3RU','2025-11-21 08:38:15.777132','2025-11-28 08:38:15.000000',2,'32953a95ae6746b28e79f4ee8d8b58a1'),(75,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMDAyMCwiaWF0IjoxNzYzNzE1MjIwLCJqdGkiOiJhODU4YjdiMmQ0ZDI0ZGE2OTQ0ZGRmNDUzNjZjZTQ3MSIsInVzZXJfaWQiOiIzIn0.xQffvJy2RHY6uu2BY8iIJr1VctEVoIFAaYa7tGiFmAY','2025-11-21 08:53:40.547578','2025-11-28 08:53:40.000000',3,'a858b7b2d4d24da6944ddf45366ce471'),(76,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMDM5MiwiaWF0IjoxNzYzNzE1NTkyLCJqdGkiOiI0OGVlZjg3N2E5Zjk0YzMyYmZmZTdjYTc2MWYwNWMxOCIsInVzZXJfaWQiOiIyIn0.KLWXdqTCEA8GglA7SjRe5DfOH411gdJGNyrl5e50mkQ','2025-11-21 08:59:52.679769','2025-11-28 08:59:52.000000',2,'48eef877a9f94c32bffe7ca761f05c18'),(77,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMDQwMywiaWF0IjoxNzYzNzE1NjAzLCJqdGkiOiI3YjJjYWJjNGQ4NWM0NDI1YTE3NGE0YjZlY2U0MTIxMyIsInVzZXJfaWQiOiIzIn0.AsEmtPStvNNjWazdD62AyipAVDn755tLjxOHpmV3fr8','2025-11-21 09:00:03.852993','2025-11-28 09:00:03.000000',3,'7b2cabc4d85c4425a174a4b6ece41213'),(78,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMDUwOSwiaWF0IjoxNzYzNzE1NzA5LCJqdGkiOiI5YjVkYmIwMjk1Mjk0ZDVkODBhMTQ0OGRkNmVkMzE2NCIsInVzZXJfaWQiOiIyIn0.cTVMT27Qe7wv5rA8w9bZsEM4rhfgvc9q26M57KxeQwc','2025-11-21 09:01:49.487900','2025-11-28 09:01:49.000000',2,'9b5dbb0295294d5d80a1448dd6ed3164'),(79,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMDYwNCwiaWF0IjoxNzYzNzE1ODA0LCJqdGkiOiI5Y2NjMWU3NGNjZTQ0NTAxODM5ZmQzMWE3ZjgwNDE1OSIsInVzZXJfaWQiOiIyIn0.KostT6-jSOHiQ1Lu4MvdXMOlZviz3touy-mNPIWr7g4','2025-11-21 09:03:24.291022','2025-11-28 09:03:24.000000',2,'9ccc1e74cce44501839fd31a7f804159'),(80,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTE5OCwiaWF0IjoxNzYzNzE2Mzk4LCJqdGkiOiJhNzQ2NTY4ODc0Mjg0MjdjOWE3YmQwMWRiNjdkYjM1YSIsInVzZXJfaWQiOiIyIn0.XxC9q6IBs1YSk6pGGVbS-sSsXmvIqsUDIxD1hGQV66o','2025-11-21 09:13:18.580372','2025-11-28 09:13:18.000000',2,'a74656887428427c9a7bd01db67db35a'),(81,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTIyMCwiaWF0IjoxNzYzNzE2NDIwLCJqdGkiOiI1MTA4NzE5ODMyYTg0NzY3OTgwNTNmN2Y4MDE0MDAzOSIsInVzZXJfaWQiOiIzIn0.90WRHbY10yKmZ6O9vNm3XQHNzTX6Yw4b4H54ikWZxvM','2025-11-21 09:13:40.485704','2025-11-28 09:13:40.000000',3,'5108719832a8476798053f7f80140039'),(82,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTY5NywiaWF0IjoxNzYzNzE2ODk3LCJqdGkiOiIxYjg5MWJlYzJhNTU0MmJkOTRlMGNjNzQ3YWVmNTg4YSIsInVzZXJfaWQiOiIyIn0.gxSMPSyUOP14vMDtRdMvD_ZIlScG0mMsS_Xuvww9ck4','2025-11-21 09:21:37.449796','2025-11-28 09:21:37.000000',2,'1b891bec2a5542bd94e0cc747aef588a'),(83,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTcwMywiaWF0IjoxNzYzNzE2OTAzLCJqdGkiOiI0MDNlODQ2YjExYTE0YmEyYmQyY2ZmNmQ3ZjMzNDNkMyIsInVzZXJfaWQiOiIzIn0.RMMXRajiqJuFdzjm7oHcL1pis8fW3F3EOZWmKzF39Sk','2025-11-21 09:21:43.863402','2025-11-28 09:21:43.000000',3,'403e846b11a14ba2bd2cff6d7f3343d3'),(84,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTgxOCwiaWF0IjoxNzYzNzE3MDE4LCJqdGkiOiI0ZmQ0ZTMxNzBlZDA0NjNmYWEwZWUzOWY1NmExOGFhYyIsInVzZXJfaWQiOiIyIn0.JQb7QlJb-xHmEqiVOks1OT5eb7bbNwppRTd7vyJkE7k','2025-11-21 09:23:38.275493','2025-11-28 09:23:38.000000',2,'4fd4e3170ed0463faa0ee39f56a18aac'),(85,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTgyNCwiaWF0IjoxNzYzNzE3MDI0LCJqdGkiOiJlNjE5YmE1MTI3MjA0MDU2OTZlNTEzZTUxNjU4ZDQ4NCIsInVzZXJfaWQiOiIzIn0.9Xz2vi3zBBu0alktGiRMPXa6F0IC8LApQGCSak0RWyE','2025-11-21 09:23:44.313754','2025-11-28 09:23:44.000000',3,'e619ba512720405696e513e51658d484'),(86,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTg0OSwiaWF0IjoxNzYzNzE3MDQ5LCJqdGkiOiIxNDIyZmEyOGQ5NWM0ZDY4YTA1NzFmOGIwMDAxZGUyZiIsInVzZXJfaWQiOiIyIn0.W-A3wo3SdgfJaCByLjVWwC7YCsiUSuLIJmyYvRun8qk','2025-11-21 09:24:09.728556','2025-11-28 09:24:09.000000',2,'1422fa28d95c4d68a0571f8b0001de2f'),(87,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMTg1NSwiaWF0IjoxNzYzNzE3MDU1LCJqdGkiOiIyZjM3YzcwZTk2NWM0ZTk3OWUwZjgwOTBhMjk0NzQ4YiIsInVzZXJfaWQiOiIyIn0.2eUbP47Mf3jDejUhDsWEIGGsiwHKNUEuRRHvKvvFz2I','2025-11-21 09:24:15.751182','2025-11-28 09:24:15.000000',2,'2f37c70e965c4e979e0f8090a294748b'),(88,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMjA0MywiaWF0IjoxNzYzNzE3MjQzLCJqdGkiOiIxMzczZDIxZDUyZmY0NjNmYmI2MjI0ODNiY2QwNjZmOSIsInVzZXJfaWQiOiIyIn0.s2waxwduXGkB3IFkb-L7WdM-PXjNsoWENphEJHOy4AQ','2025-11-21 09:27:23.159083','2025-11-28 09:27:23.000000',2,'1373d21d52ff463fbb622483bcd066f9'),(89,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyMjU2NiwiaWF0IjoxNzYzNzE3NzY2LCJqdGkiOiI2NTg2NmJlNWU1OWQ0NTY0OTVhYmJhZjcxZWFmZjhiMSIsInVzZXJfaWQiOiIyIn0.0_evXki49qgXi4TuBtnZNgyuDzIzb-VdSARNprNd0rs','2025-11-21 09:36:06.158166','2025-11-28 09:36:06.000000',2,'65866be5e59d456495abbaf71eaff8b1'),(90,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMyNjA0NSwiaWF0IjoxNzYzNzIxMjQ1LCJqdGkiOiI3MzViZDI1YWU0ZGI0N2ZlOGZlODk5ODU3YmI4MDU4ZSIsInVzZXJfaWQiOiIyIn0.dnR-qrYAoV8Ovw9gidlrs2nHJOlvc9EPXmEo0h4ETHs','2025-11-21 10:34:05.656428','2025-11-28 10:34:05.000000',2,'735bd25ae4db47fe8fe899857bb8058e'),(91,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDM5OTQzOSwiaWF0IjoxNzYzNzk0NjM5LCJqdGkiOiIyMzkxMmVjMzI4NjU0MDdlYjk1ZjIzNjYyMzExNjQwMCIsInVzZXJfaWQiOiIyIn0.js-Nq6hkO3oBMxvnRHxfYZBOEYq8TEh7AKH8pszaKHg','2025-11-22 06:57:19.517952','2025-11-29 06:57:19.000000',2,'23912ec32865407eb95f236623116400'),(92,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwMzk4NSwiaWF0IjoxNzYzNzk5MTg1LCJqdGkiOiJkM2JhNTcxNGUyZDk0YTdhYTg1ZDgwMGNjMDNhZjc3YSIsInVzZXJfaWQiOiIzIn0.ZRK4Uf-JkROspVNSbzZYVVrhLPeDrnRr-1IgqQmJFvw','2025-11-22 08:13:05.839212','2025-11-29 08:13:05.000000',3,'d3ba5714e2d94a7aa85d800cc03af77a'),(93,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwMzk4NSwiaWF0IjoxNzYzNzk5MTg1LCJqdGkiOiIyMzk1MzY0MTY0MjA0NTI5ODQ3ZWI1ZTcxMWMyN2E1NCIsInVzZXJfaWQiOiIyIn0.XnxnWCwywnfzuLaQ_GpLEqra7pcmIqnyRC66tqHkTrI','2025-11-22 08:13:05.868817','2025-11-29 08:13:05.000000',2,'2395364164204529847eb5e711c27a54'),(94,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNDA3OCwiaWF0IjoxNzYzNzk5Mjc4LCJqdGkiOiIxZjc0ZmU2ZWI3NWE0ZGVjYjgyMDNkNjJkYTFhNTRmYiIsInVzZXJfaWQiOiIzIn0.LnkSUxjOt11iDDAUulHJxegS1lDBAxEZSysRgq5wYDE','2025-11-22 08:14:38.067215','2025-11-29 08:14:38.000000',3,'1f74fe6eb75a4decb8203d62da1a54fb'),(95,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNDQxMCwiaWF0IjoxNzYzNzk5NjEwLCJqdGkiOiI5MDI3OWM1MWFmOTg0NDNjOWRlMDljMTAyYjkxMmM4NiIsInVzZXJfaWQiOiIyIn0.l6NdCWlnakHGv692Ru3bEHHQ4xKNGgj35TzBAl7tekY','2025-11-22 08:20:10.099222','2025-11-29 08:20:10.000000',2,'90279c51af98443c9de09c102b912c86'),(96,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNDU5NiwiaWF0IjoxNzYzNzk5Nzk2LCJqdGkiOiJmZDVlM2ZiODgwMzg0NDk1Yjk0MGVlMzM1MWU0ZjEwMyIsInVzZXJfaWQiOiIzIn0.cwnCKVkidSN2ymOnuub_M_H0ZA-Zju3Jd-POqMENHac','2025-11-22 08:23:16.345799','2025-11-29 08:23:16.000000',3,'fd5e3fb880384495b940ee3351e4f103'),(97,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNTczMiwiaWF0IjoxNzYzODAwOTMyLCJqdGkiOiJiZDAzY2JhMGI1Y2M0NjJmODFlYmQ1ZDY1ODY2OWQzOCIsInVzZXJfaWQiOiIyIn0.Tm84mtFJqqXwt1dxms9f-26ypTKiYRniWi2Kiq2wIeA','2025-11-22 08:42:12.918488','2025-11-29 08:42:12.000000',2,'bd03cba0b5cc462f81ebd5d658669d38'),(98,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNTc0OSwiaWF0IjoxNzYzODAwOTQ5LCJqdGkiOiIwNDMzMWM2NGQ4NzI0MzQ4ODg4ZDYxNWQ1M2JjY2QwNCIsInVzZXJfaWQiOiIzIn0.8n6rH_OGi1VP0ItILV6ZgXD_0p-T-AySsJPbaPwniSg','2025-11-22 08:42:29.114432','2025-11-29 08:42:29.000000',3,'04331c64d8724348888d615d53bccd04'),(99,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNTk2MiwiaWF0IjoxNzYzODAxMTYyLCJqdGkiOiIxZGMxNjIyOWIwNzU0NTk4YjIwNTllNTViZTNiZTMxNiIsInVzZXJfaWQiOiIzIn0.S2oTKYktsxIeoDZopFtsmJ6PLi91nQoirIyubaLdIJ8','2025-11-22 08:46:02.511802','2025-11-29 08:46:02.000000',3,'1dc16229b0754598b2059e55be3be316'),(100,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNTk3NCwiaWF0IjoxNzYzODAxMTc0LCJqdGkiOiIyZDQ4NjM5YWIyY2I0OGNhYTk2YjM5OTdjOGYzYTRhYiIsInVzZXJfaWQiOiIzIn0.XWan3EYIJPbMUWzd20KACkKTYfxaBkUzPJ-1n6P_IPc','2025-11-22 08:46:14.594496','2025-11-29 08:46:14.000000',3,'2d48639ab2cb48caa96b3997c8f3a4ab'),(101,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNjAyOSwiaWF0IjoxNzYzODAxMjI5LCJqdGkiOiIzZjk1NmRlNzEyMGM0ZDJkOGVmODViZTk1Zjk1MTI1YyIsInVzZXJfaWQiOiIzIn0.eMY_cFiHmLbGQuX_dtHwD7fKUS9LcSsNYnypcg3ILCM','2025-11-22 08:47:09.020853','2025-11-29 08:47:09.000000',3,'3f956de7120c4d2d8ef85be95f95125c'),(102,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNjA2OCwiaWF0IjoxNzYzODAxMjY4LCJqdGkiOiI2NTlmYTcyZjYxNWM0NmY2ODgzNTExY2NiOTZlYzM5ZCIsInVzZXJfaWQiOiIyIn0.jdyJPwelQxPiL9IMdXErVvwBsYadvMqBj2YDOhM3vhI','2025-11-22 08:47:48.801504','2025-11-29 08:47:48.000000',2,'659fa72f615c46f6883511ccb96ec39d'),(103,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNjk5MiwiaWF0IjoxNzYzODAyMTkyLCJqdGkiOiI4MWU3NWMxYWE1OTI0OWI5OGMxNzZmNjAyNzQyZDAyMiIsInVzZXJfaWQiOiIyIn0.Zry2q1X2jiF5cxRyb5ZY66y1Cyt21bvIYWV11T61bYI','2025-11-22 09:03:12.448205','2025-11-29 09:03:12.000000',2,'81e75c1aa59249b98c176f602742d022'),(104,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNzQ1MywiaWF0IjoxNzYzODAyNjUzLCJqdGkiOiI4NDQ5ZjQyYmIzZjY0ZmJjYjk0M2UxMjY5Y2I1ZmU2MSIsInVzZXJfaWQiOiIyIn0.8tK3tqUazJzkD44o7nIhTdZP4JTpLZVLJr7yl6s1y2E','2025-11-22 09:10:53.950021','2025-11-29 09:10:53.000000',2,'8449f42bb3f64fbcb943e1269cb5fe61'),(105,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNzY5NSwiaWF0IjoxNzYzODAyODk1LCJqdGkiOiI0OGIwYWJiOGIyOWY0ZDQ5YTI3MzI5NDdmZWZlN2RkMSIsInVzZXJfaWQiOiIyIn0.y-j3hpQIJtMALbE__46VVno4Df4t2QwecFiRiFcf2TY','2025-11-22 09:14:55.518563','2025-11-29 09:14:55.000000',2,'48b0abb8b29f4d49a2732947fefe7dd1'),(106,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNzY5OCwiaWF0IjoxNzYzODAyODk4LCJqdGkiOiJmMmQwMDJiZGM1ZmI0MTM5YThjZmExZDYxMjFlNjdlZiIsInVzZXJfaWQiOiIyIn0.4L47L42EgssHi__54PQmpilGLl5WjmGQHJRleofL7Q8','2025-11-22 09:14:58.356567','2025-11-29 09:14:58.000000',2,'f2d002bdc5fb4139a8cfa1d6121e67ef'),(107,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNzcxMCwiaWF0IjoxNzYzODAyOTEwLCJqdGkiOiI2ODg2OTI0ZTYxMjU0MjBkYjdkODQzMjQwOWIwNTA1ZSIsInVzZXJfaWQiOiIyIn0.W8cq0LhDdy0tbZLTiZLax-90TuAIedT4V8vREryRn_w','2025-11-22 09:15:10.843407','2025-11-29 09:15:10.000000',2,'6886924e6125420db7d8432409b0505e'),(108,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwNzg0OCwiaWF0IjoxNzYzODAzMDQ4LCJqdGkiOiI4MTYxYmI3ZThkYzM0YzY3OTE3NmFmZDQyZWQxZDRjYSIsInVzZXJfaWQiOiIyIn0.o2oq3vSt6rRNSPBXUQq8te3fJwLi9TEGPIW3XT_PJ08','2025-11-22 09:17:28.125941','2025-11-29 09:17:28.000000',2,'8161bb7e8dc34c679176afd42ed1d4ca'),(109,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODAwMSwiaWF0IjoxNzYzODAzMjAxLCJqdGkiOiJhZDBiMTdiY2RmMDQ0MmJjYmZiMTczMTY0ZjEyYjYwMCIsInVzZXJfaWQiOiIyIn0.1Ith3YIfAsC3M1FnTy9X5YxoAon__Q4-5vdTbL308bA','2025-11-22 09:20:01.996728','2025-11-29 09:20:01.000000',2,'ad0b17bcdf0442bcbfb173164f12b600'),(110,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODAwNSwiaWF0IjoxNzYzODAzMjA1LCJqdGkiOiI0NzI1NTRkYzNhOTk0ZmJkODcyNjkzNTdhZTIwOGE0OCIsInVzZXJfaWQiOiIyIn0.KcgMVpZYbXhvyqcy1YCqZW0BEvlak42P92svZGis-qU','2025-11-22 09:20:05.257184','2025-11-29 09:20:05.000000',2,'472554dc3a994fbd87269357ae208a48'),(111,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODA5MSwiaWF0IjoxNzYzODAzMjkxLCJqdGkiOiJhYzYzOGVkZGYzZjI0ZTRiOTY3MGUxNDFlODRmNDc1YSIsInVzZXJfaWQiOiIyIn0.ApPA3ul0H-StENDuLUsTd_DwsbsDvMkYCMEi_y7pMKc','2025-11-22 09:21:31.899294','2025-11-29 09:21:31.000000',2,'ac638eddf3f24e4b9670e141e84f475a'),(112,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODI4MiwiaWF0IjoxNzYzODAzNDgyLCJqdGkiOiJlZGM1YTFhNWIyMzk0NDI2ODkzZGYyZWEwMTExNzMwZiIsInVzZXJfaWQiOiIyIn0.OIFZprHqU9MeREZhoAcyiomayVJgcLn_bSgoZXgTyKQ','2025-11-22 09:24:42.236628','2025-11-29 09:24:42.000000',2,'edc5a1a5b2394426893df2ea0111730f'),(113,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODMwMCwiaWF0IjoxNzYzODAzNTAwLCJqdGkiOiJlYjFlZDViYTA0NjE0MmNlYjE5MjRiZTU0YmU4NGY0YSIsInVzZXJfaWQiOiIyIn0.gElyyLRbKchgXQ_dK_6sxogUB_qe84mNhsooFuMGRnU','2025-11-22 09:25:00.687960','2025-11-29 09:25:00.000000',2,'eb1ed5ba046142ceb1924be54be84f4a'),(114,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODM1OCwiaWF0IjoxNzYzODAzNTU4LCJqdGkiOiI5ZTdmNjI3YzBiMTg0NzlhYWRmMzcwZDcyMzQ0NmJkYyIsInVzZXJfaWQiOiIyIn0.1PcwlB3VG8rQju81goAn0kOvqRgWsG8MoRS2dtBrOIU','2025-11-22 09:25:58.137544','2025-11-29 09:25:58.000000',2,'9e7f627c0b18479aadf370d723446bdc'),(115,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODM4MywiaWF0IjoxNzYzODAzNTgzLCJqdGkiOiJjODBjNDI4MWNlZDk0MWRkYjVhNDE3NDNkZWRmZmEzZCIsInVzZXJfaWQiOiIyIn0.f43CLQKum0xNHyescGFagP7MKunkR4auMio6PO6q7mA','2025-11-22 09:26:23.246623','2025-11-29 09:26:23.000000',2,'c80c4281ced941ddb5a41743dedffa3d'),(116,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODM4NSwiaWF0IjoxNzYzODAzNTg1LCJqdGkiOiI2ZDlhODAyMjY4MGU0OTQ2ODU0NTM1MmM5NTcxMTZkOSIsInVzZXJfaWQiOiIyIn0.-9jd-3CyH08uKv1g-5TzX-sqGitbZC6N-fcl8-wvELw','2025-11-22 09:26:25.315938','2025-11-29 09:26:25.000000',2,'6d9a8022680e49468545352c957116d9'),(117,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODQ4NywiaWF0IjoxNzYzODAzNjg3LCJqdGkiOiJhYTFiMzE4Y2UxYWE0NjRkODgwNmJmMTA3ZTc2N2YwNyIsInVzZXJfaWQiOiIyIn0.ZUE4KqVWcGwPi0n7H-2Sq_sTfEFr8s9Ia5Kph6DwA4g','2025-11-22 09:28:07.840290','2025-11-29 09:28:07.000000',2,'aa1b318ce1aa464d8806bf107e767f07'),(118,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODU3MSwiaWF0IjoxNzYzODAzNzcxLCJqdGkiOiJmZDA3ZWFiNzYyODk0NzE1OTc4YzgyNTFhNzg0Yzc4OSIsInVzZXJfaWQiOiIyIn0.R80IsPeWpE1_OWmPbtSDiW9lISRwnm5qusfAZZwf3SU','2025-11-22 09:29:31.437931','2025-11-29 09:29:31.000000',2,'fd07eab762894715978c8251a784c789'),(119,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODU3NSwiaWF0IjoxNzYzODAzNzc1LCJqdGkiOiJjMjg4MWViMzZiMzU0ZjQzYjQ1OTZiOWViMWQ0OTUxNSIsInVzZXJfaWQiOiIyIn0.Dt9u1VKx5i6ojSasjnHcpLxJnDGjzBUeXPOxc6k56kU','2025-11-22 09:29:35.029438','2025-11-29 09:29:35.000000',2,'c2881eb36b354f43b4596b9eb1d49515'),(120,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODkxNCwiaWF0IjoxNzYzODA0MTE0LCJqdGkiOiI0NmI3OWI3MTI4ZGE0MDM5YjQxZjg2ZDdkNzM0YTM0OSIsInVzZXJfaWQiOiIyIn0.nNqt7BNQguCfAbVcAHDpwpXrkx5L9WZjVJgbbkx8pfE','2025-11-22 09:35:14.290918','2025-11-29 09:35:14.000000',2,'46b79b7128da4039b41f86d7d734a349'),(121,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwODkxNywiaWF0IjoxNzYzODA0MTE3LCJqdGkiOiI1YmExYTY0ZWRkZTY0NjlmYmUwOTQyNWQxMTRlZjk0MiIsInVzZXJfaWQiOiIyIn0.kKjnxaCUCcpGhc2tjJbKUx0-ijN_DTTLuJ1dqR-LlJI','2025-11-22 09:35:17.713481','2025-11-29 09:35:17.000000',2,'5ba1a64edde6469fbe09425d114ef942'),(122,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwOTUzNiwiaWF0IjoxNzYzODA0NzM2LCJqdGkiOiI5ZTE0NjNjYTNkNzc0OWQ1ODlhMmYwM2M1NmQwYmU2NCIsInVzZXJfaWQiOiIyIn0.cMmCSHMjIkltexlHB75rh0sJt_OpfJ04THpj-pTDISQ','2025-11-22 09:45:36.045064','2025-11-29 09:45:36.000000',2,'9e1463ca3d7749d589a2f03c56d0be64'),(123,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwOTY4NCwiaWF0IjoxNzYzODA0ODg0LCJqdGkiOiI0ZjU5NTcxNWUzZGU0NmUxOGY1OWUwNWU1N2FkZGY0ZiIsInVzZXJfaWQiOiIyIn0.RTT-riZZG4ziH_aMi7icpQSitnuuqaVgj1Xq_lr78Xw','2025-11-22 09:48:04.029549','2025-11-29 09:48:04.000000',2,'4f595715e3de46e18f59e05e57addf4f'),(124,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwOTY4NywiaWF0IjoxNzYzODA0ODg3LCJqdGkiOiIwN2UwMzUzZTUzZGE0NjgxOWU1NzNjM2Y4YzJmMmNhNCIsInVzZXJfaWQiOiIyIn0.3yCI82Rz7LW5vgSWlVMsOtCIwPkOZWs6Vzr2dsJ15FM','2025-11-22 09:48:07.298662','2025-11-29 09:48:07.000000',2,'07e0353e53da46819e573c3f8c2f2ca4'),(125,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwOTg1OCwiaWF0IjoxNzYzODA1MDU4LCJqdGkiOiIwODczNzg1OWFmMGU0OWM3YjIzMGIwY2M3YjBmODQwMiIsInVzZXJfaWQiOiIyIn0.wFxeSDY35vFZpEjAUL94t06OTtfnLfzsvC7NMb8-WDo','2025-11-22 09:50:58.975688','2025-11-29 09:50:58.000000',2,'08737859af0e49c7b230b0cc7b0f8402'),(126,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwOTg2MSwiaWF0IjoxNzYzODA1MDYxLCJqdGkiOiI1ZWYxZDE3MjFmZmY0OWM2YjcyZTExMDRhM2IwNDM0NCIsInVzZXJfaWQiOiIyIn0.VfhmRUCPNtOxtlzgNgu91LozoXPOc9xLiQmqUNTG21s','2025-11-22 09:51:01.709081','2025-11-29 09:51:01.000000',2,'5ef1d1721fff49c6b72e1104a3b04344'),(127,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQwOTg2MywiaWF0IjoxNzYzODA1MDYzLCJqdGkiOiJlMzQzZGVjMjhhNTQ0ZjFiYmNjZjMzMTk1ZGU5NjVlZiIsInVzZXJfaWQiOiIyIn0.fHjVGMaTtSEJ25fiipxaoObG2ZNLxwXIJbsI0QhLJXQ','2025-11-22 09:51:03.932881','2025-11-29 09:51:03.000000',2,'e343dec28a544f1bbccf33195de965ef'),(128,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQxMDk1NywiaWF0IjoxNzYzODA2MTU3LCJqdGkiOiJiNWI5ZTcwNTNmYTU0ZGI1Yjc0ZTk4MTg1NjJhZWJiYiIsInVzZXJfaWQiOiIyIn0.GUzSZXpgoUjDLcWfSsNVs3nADTAAmIIV9MvrzhEBnE0','2025-11-22 10:09:17.122286','2025-11-29 10:09:17.000000',2,'b5b9e7053fa54db5b74e9818562aebbb'),(129,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQxMTEwMSwiaWF0IjoxNzYzODA2MzAxLCJqdGkiOiIyYzkzZWQwNTZjZmE0YTA1YWRhYzk2ZDllNGJmZDI5NyIsInVzZXJfaWQiOiIyIn0.mYIORCf5OdGGhxcUkpgL6kqvh2sQ6iWDFcZ2fgWODYs','2025-11-22 10:11:41.956257','2025-11-29 10:11:41.000000',2,'2c93ed056cfa4a05adac96d9e4bfd297'),(130,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQxMTczOCwiaWF0IjoxNzYzODA2OTM4LCJqdGkiOiI0ODI2OGQ4Y2YyYjQ0ODkwOGI3NjRkYzE2MmNkNDQ2OSIsInVzZXJfaWQiOiIyIn0.V2xIvj0rY5csrkANUEeP91_xE2MZcet5B9VDrBWPuPE','2025-11-22 10:22:18.981674','2025-11-29 10:22:18.000000',2,'48268d8cf2b448908b764dc162cd4469'),(131,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQxMjEzMSwiaWF0IjoxNzYzODA3MzMxLCJqdGkiOiI5ODc5NjYzOTdmNDc0MTJjODRlMTQyZTQ2MmMwYzE2YSIsInVzZXJfaWQiOiIyIn0.e_qb51kJiL0htciVieoRZ2TXnkFkABXy3BKr5XLayzk','2025-11-22 10:28:51.693221','2025-11-29 10:28:51.000000',2,'987966397f47412c84e142e462c0c16a'),(132,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQxMjEzNSwiaWF0IjoxNzYzODA3MzM1LCJqdGkiOiIyMDc5NDU2ZWViZTY0YmVkOTNkMjlmY2M0ZmQ1MGFjMCIsInVzZXJfaWQiOiIyIn0.EO1AZMje10bsR2ggSSeZh9gsNU70dOh_mASdts6qvZw','2025-11-22 10:28:55.774019','2025-11-29 10:28:55.000000',2,'2079456eebe64bed93d29fcc4fd50ac0'),(133,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQxNDk1MywiaWF0IjoxNzYzODEwMTUzLCJqdGkiOiI1YTM1MmQyMzM1NDE0MjNlOTUzNDI2NTg0NDk2NmU3ZSIsInVzZXJfaWQiOiIyIn0.jEvFvUgjPRLEZTR44aaHn4An8viSgWxO77oMscoNTw8','2025-11-22 11:15:53.072744','2025-11-29 11:15:53.000000',2,'5a352d233541423e9534265844966e7e'),(134,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQxNDk5MiwiaWF0IjoxNzYzODEwMTkyLCJqdGkiOiJmOGJmZWE1ZTgwMTI0NWVmOWVhY2UxMDA0MGZmMzhiNyIsInVzZXJfaWQiOiIzIn0.I99STfDeEmIEiW2xiTPbYBkigi7CGkRkxr3jVCsiZVc','2025-11-22 11:16:32.942225','2025-11-29 11:16:32.000000',3,'f8bfea5e801245ef9eace10040ff38b7'),(135,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MDc0NywiaWF0IjoxNzYzODg1OTQ3LCJqdGkiOiIxNzlkN2E1ZmE0M2U0OWQ3ODQ2NmU0YmM3MmNmODhhZSIsInVzZXJfaWQiOiIyIn0.DQm-lLTNV51L5TMttmsG91BKlAH38SVsveK54jhOBOM','2025-11-23 08:19:07.697935','2025-11-30 08:19:07.000000',2,'179d7a5fa43e49d78466e4bc72cf88ae'),(136,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MDc0NywiaWF0IjoxNzYzODg1OTQ3LCJqdGkiOiJmNWFjMWY2YTJlNDM0OWNkODk1ZDRlMDU1ZTZmMWE5NSIsInVzZXJfaWQiOiIyIn0.5QhiGyl6g5uZOFHyrViv2OyEcZhapsdkhBPIu6ZgdcQ','2025-11-23 08:19:07.699927','2025-11-30 08:19:07.000000',2,'f5ac1f6a2e4349cd895d4e055e6f1a95'),(137,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MDg3MiwiaWF0IjoxNzYzODg2MDcyLCJqdGkiOiI3MTYxZjA1ODhmZGI0ZDllOWZlMjFmMzA5NWE3OTQ5ZSIsInVzZXJfaWQiOiIzIn0.oXXSCH0E7RoR8-IDK-Oho_Xo_Ez747fX4oHxgWFG640','2025-11-23 08:21:12.134584','2025-11-30 08:21:12.000000',3,'7161f0588fdb4d9e9fe21f3095a7949e'),(138,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MDg3MiwiaWF0IjoxNzYzODg2MDcyLCJqdGkiOiI0YzQ0MzY4ZjkyMjU0ODYyYTVlNGU1MWZhNWIzNDhjYyIsInVzZXJfaWQiOiIzIn0.Dpq0jd47KkYHj6T6Knr-55CRYBK_4anXwerP-XvtAQg','2025-11-23 08:21:12.151587','2025-11-30 08:21:12.000000',3,'4c44368f92254862a5e4e51fa5b348cc'),(139,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MDkzNCwiaWF0IjoxNzYzODg2MTM0LCJqdGkiOiIyYjc5OTJmMTI0MmY0ZjZjYjZkYmY0ZWY0MDUwNWE1MCIsInVzZXJfaWQiOiIzIn0.ecCVvr_tFYQ3_L_i7XdNMmPuFcg-uVxNwccmsBQHtbI','2025-11-23 08:22:14.462294','2025-11-30 08:22:14.000000',3,'2b7992f1242f4f6cb6dbf4ef40505a50'),(140,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MDk5MSwiaWF0IjoxNzYzODg2MTkxLCJqdGkiOiI2ZGRkNzVlZDU0MDc0M2FjOGJhNGIyYmU2ZDQxOThmNCIsInVzZXJfaWQiOiIzIn0.8ABBcE_TMJgxn9mrjv2CHhECckXF2KhdLKht1AzDa54','2025-11-23 08:23:11.931638','2025-11-30 08:23:11.000000',3,'6ddd75ed540743ac8ba4b2be6d4198f4'),(141,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MDk5NywiaWF0IjoxNzYzODg2MTk3LCJqdGkiOiJmYzUwYzVhMDhhOTY0YjdkOTVlMDFkZDYyZDdiMWQ1OSIsInVzZXJfaWQiOiIzIn0.ioBIH3CoFB5rryhn-N9fIVa7604yTkTeWCTqtJro9JM','2025-11-23 08:23:17.726580','2025-11-30 08:23:17.000000',3,'fc50c5a08a964b7d95e01dd62d7b1d59'),(142,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MTIwMywiaWF0IjoxNzYzODg2NDAzLCJqdGkiOiIzOWFlZjExNTEyYTU0MDk4OWViMWJmMzIwZjM4N2Q5YiIsInVzZXJfaWQiOiIzIn0.qXU1qtYd2VgkI4JW2QZo2tNDgQJJBV8YzMQn1q6O10s','2025-11-23 08:26:43.534203','2025-11-30 08:26:43.000000',3,'39aef11512a540989eb1bf320f387d9b'),(143,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5MTIwNywiaWF0IjoxNzYzODg2NDA3LCJqdGkiOiI0NjJlYzllMTVlMDM0OWE5ODBkYzEzYmY1MTJmODBlNyIsInVzZXJfaWQiOiIzIn0.h7Qw62WY3VekkS3gfedZC9rhqCJ4iDUlIdFuvFBzqIk','2025-11-23 08:26:47.925210','2025-11-30 08:26:47.000000',3,'462ec9e15e0349a980dc13bf512f80e7'),(144,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5Mzg2NywiaWF0IjoxNzYzODg5MDY3LCJqdGkiOiIwMWJkZDBhZmI0Y2Y0MzIzYjIxMjhlZjA1Yjg2YmRlMCIsInVzZXJfaWQiOiIzIn0.GsnLk2SqM5B3WMd9bF00FbxOaXgTs9Y1TAkeRHwVh6s','2025-11-23 09:11:07.172189','2025-11-30 09:11:07.000000',3,'01bdd0afb4cf4323b2128ef05b86bde0'),(145,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NDg4OCwiaWF0IjoxNzYzODkwMDg4LCJqdGkiOiIxYThjYjhmYmQzMDE0ODY4OTY4ZWJhMzBhOTM5ZDc4ZiIsInVzZXJfaWQiOiIyIn0.Yja4XbugZyD9RKpGN3rFyn7vC6_QB9mHwXk93Mbbmjk','2025-11-23 09:28:08.334126','2025-11-30 09:28:08.000000',2,'1a8cb8fbd3014868968eba30a939d78f'),(146,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NDg5NiwiaWF0IjoxNzYzODkwMDk2LCJqdGkiOiI3ODQ1NzNlMzcxY2U0MjA5YjMwYjdlOGVmY2M2OTEzNiIsInVzZXJfaWQiOiIzIn0.SgrbiMUT-ZP0MdLz1VctDDO694xgSHuW9idFScry7Os','2025-11-23 09:28:16.811742','2025-11-30 09:28:16.000000',3,'784573e371ce4209b30b7e8efcc69136'),(147,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NTAyNywiaWF0IjoxNzYzODkwMjI3LCJqdGkiOiJlM2Q0NzZlZjZhZGY0NGFhODI5ZDFkNjU1Y2JmYjJhNiIsInVzZXJfaWQiOiIzIn0.vVfjrH0q0u6pRYjD_RAzJvZAN7vWeAqVQ8lo729Ostw','2025-11-23 09:30:27.161080','2025-11-30 09:30:27.000000',3,'e3d476ef6adf44aa829d1d655cbfb2a6'),(148,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NTA1NSwiaWF0IjoxNzYzODkwMjU1LCJqdGkiOiJlYjA4ZmExNDFmZDc0ZWE1YWNhM2JhYjdkN2ViZDYxMCIsInVzZXJfaWQiOiIzIn0.Ad_TE5awLGXmznp-DblpJGH8FdVFKsEIYtd9-yrJ0KI','2025-11-23 09:30:55.012153','2025-11-30 09:30:55.000000',3,'eb08fa141fd74ea5aca3bab7d7ebd610'),(149,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NTA2MywiaWF0IjoxNzYzODkwMjYzLCJqdGkiOiI3OGYwMTc5MjUyOWQ0ZWQ4YWQzYjQ4ZThiYzM2MGZhNyIsInVzZXJfaWQiOiIzIn0.KDvX7aoKvUXAJWXo1o-HzEqInqeWLIcprUeBCYtOcVc','2025-11-23 09:31:03.023844','2025-11-30 09:31:03.000000',3,'78f01792529d4ed8ad3b48e8bc360fa7'),(150,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NTA4MCwiaWF0IjoxNzYzODkwMjgwLCJqdGkiOiJmYWIwNjAwYjI0MjY0NjZmOGQ4ODJhMTk1NDA3ZjM2ZCIsInVzZXJfaWQiOiIzIn0.9MyWBJ49THVYJzvRLOy44kxaXuxRaIr_QSmbVKlvT1c','2025-11-23 09:31:20.437772','2025-11-30 09:31:20.000000',3,'fab0600b2426466f8d882a195407f36d'),(151,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NTA4NiwiaWF0IjoxNzYzODkwMjg2LCJqdGkiOiI0YjQ4NGUwMzlkODU0YTk1OTZjNTNlMTA1ZjJmOTJhOCIsInVzZXJfaWQiOiIzIn0.Iw_3HiwbyzgyEW_PHuXQv8T4pXcSddgZKN33aO5hThY','2025-11-23 09:31:26.487883','2025-11-30 09:31:26.000000',3,'4b484e039d854a9596c53e105f2f92a8'),(152,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NzMyNSwiaWF0IjoxNzYzODkyNTI1LCJqdGkiOiI5ZGM1M2U3NzFmYjU0ZjQ0ODYxYmY1ZmY3NGM5ZjVjOSIsInVzZXJfaWQiOiIyIn0.WoRMSXMEbk0tlN0uZtiU7oIIHGp133FHIouav_fzBlM','2025-11-23 10:08:45.396451','2025-11-30 10:08:45.000000',2,'9dc53e771fb54f44861bf5ff74c9f5c9'),(153,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5NzM3NywiaWF0IjoxNzYzODkyNTc3LCJqdGkiOiJlM2I5YWQ3ZmJjYjM0ZmRjYjJlNTk4NTkxNTc1ZWQwOSIsInVzZXJfaWQiOiIzIn0.zBgfM4MlXi8rnCqi4NSn7tQtrw4jrAlic-PCCzAeH8E','2025-11-23 10:09:37.299892','2025-11-30 10:09:37.000000',3,'e3b9ad7fbcb34fdcb2e598591575ed09'),(154,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5ODExMiwiaWF0IjoxNzYzODkzMzEyLCJqdGkiOiJmMTdjMmNkYTM1NDA0MWNkYWVhMzg5MjM0Yjk1Yjk0YyIsInVzZXJfaWQiOiIzIn0.HyRKtLqNXVb6aZSvMTJp80EeJXa20A3UZeOGAB7pjKE','2025-11-23 10:21:52.691911','2025-11-30 10:21:52.000000',3,'f17c2cda354041cdaea389234b95b94c'),(155,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5ODE2NSwiaWF0IjoxNzYzODkzMzY1LCJqdGkiOiJhNDRlMTQ5MmNhZGU0OWJjYmFhMjY0YTM2YzA2MmNmNSIsInVzZXJfaWQiOiIyIn0.2_KsxEtxWQ8cdMlX7p0naUMa22qXvp1psaEYEn4tuCI','2025-11-23 10:22:45.824998','2025-11-30 10:22:45.000000',2,'a44e1492cade49bcbaa264a36c062cf5'),(156,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5ODU4NCwiaWF0IjoxNzYzODkzNzg0LCJqdGkiOiI4ZWJlNjJlZWRlNjQ0ZmU0OWEwYzUzZDJlZmQ2MjE0NiIsInVzZXJfaWQiOiIzIn0.P2QbLlpbMvbeXAvJcpc-1mMqxQjizUiqXhhRBkFAWqM','2025-11-23 10:29:44.812285','2025-11-30 10:29:44.000000',3,'8ebe62eede644fe49a0c53d2efd62146'),(157,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5OTk3MiwiaWF0IjoxNzYzODk1MTcyLCJqdGkiOiJiYTE0MmFiYWJmNWI0MmM5YWIxMzE5NDMyYjFhMzUwMyIsInVzZXJfaWQiOiIyIn0.7jIyjRUbtaIsrtipWgJCA0j2O9PTsS6Nnu6eFtSoyrE','2025-11-23 10:52:52.184372','2025-11-30 10:52:52.000000',2,'ba142ababf5b42c9ab1319432b1a3503'),(158,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ5OTk3NywiaWF0IjoxNzYzODk1MTc3LCJqdGkiOiJhNzk0Y2JmMGRlZWY0YzdiYTA2NDhkMmJkZmYyZGQzMSIsInVzZXJfaWQiOiIzIn0._kss-IjK_87SZZvfNbZ3-BxKMPxUADiXD3d3TxtYIzs','2025-11-23 10:52:57.397525','2025-11-30 10:52:57.000000',3,'a794cbf0deef4c7ba0648d2bdff2dd31'),(159,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDUwODc2NywiaWF0IjoxNzYzOTAzOTY3LCJqdGkiOiIwZWJiM2JlOTc1NDE0OTM2YTJmNmU3NDQwOGY1ODBmMCIsInVzZXJfaWQiOiIyIn0.sdF2R5Yw2RaGYxHsYIFOe9QuL0tRHpGzFBp2uKTOgxE','2025-11-23 13:19:27.722123','2025-11-30 13:19:27.000000',2,'0ebb3be975414936a2f6e74408f580f0'),(160,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDUwODc3MSwiaWF0IjoxNzYzOTAzOTcxLCJqdGkiOiJmZmVhOGE5MmIyNmM0ZWY2OTYyZjUyNmRlZDQyMmY1MyIsInVzZXJfaWQiOiIyIn0.LUMOU34LCBZlQ9t8YH-Spar2aCP0HYW1XZHoalep-mA','2025-11-23 13:19:31.377214','2025-11-30 13:19:31.000000',2,'ffea8a92b26c4ef6962f526ded422f53'),(161,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDUwODc4NiwiaWF0IjoxNzYzOTAzOTg2LCJqdGkiOiI4ZDRlYzY5YjUyMzY0OTgzOGY5MThkMDcwNzg2Zjc1ZCIsInVzZXJfaWQiOiIzIn0.pSSEoCd2nauSAyEpn7zGt_huaaUDCnS79Fm_9UkE7BM','2025-11-23 13:19:46.650639','2025-11-30 13:19:46.000000',3,'8d4ec69b523649838f918d070786f75d'),(162,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU2MDQ2NiwiaWF0IjoxNzYzOTU1NjY2LCJqdGkiOiJiMjk0ZjU2ODdkNDE0NWRlYTI2MDFiMjUwZjA4MWQ0NiIsInVzZXJfaWQiOiIyIn0.JpPPbaqkOgILfBO4IB0CfznR4KS6xcPtVIMmvF_he2U','2025-11-24 03:41:06.980405','2025-12-01 03:41:06.000000',2,'b294f5687d4145dea2601b250f081d46'),(163,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU2MDQ2NiwiaWF0IjoxNzYzOTU1NjY2LCJqdGkiOiIxM2I0MTNkMTIzOGI0ZjQ5ODgzMzMzMTIzYTY1ODAxNiIsInVzZXJfaWQiOiIyIn0.PY6zlIDu0cvUc-Oo2LkPyn-OqbQrz-4HE0Gc8T31mUU','2025-11-24 03:41:06.982432','2025-12-01 03:41:06.000000',2,'13b413d1238b4f49883333123a658016'),(164,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU2MDQ4NSwiaWF0IjoxNzYzOTU1Njg1LCJqdGkiOiJmZGFjMWY5MGJmZmE0YWU2OTJiMjI2MWFjZjNmMWY5MiIsInVzZXJfaWQiOiIzIn0.Rt-0sVmR-WPYfVOrg9vdMhtToayi2ueyVq_OqSObnmE','2025-11-24 03:41:25.438210','2025-12-01 03:41:25.000000',3,'fdac1f90bffa4ae692b2261acf3f1f92'),(165,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU2OTA3MywiaWF0IjoxNzYzOTY0MjczLCJqdGkiOiI1ODhjNjkxZGUyOWE0ZDlhOWY0ODY0NzIwMTAyNDVhNiIsInVzZXJfaWQiOiIyIn0._Pn4zIwul5FiYZJ6MWyRODyYXgKDwm-m1upE7wSBjVE','2025-11-24 06:04:33.993795','2025-12-01 06:04:33.000000',2,'588c691de29a4d9a9f486472010245a6'),(166,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU2OTEwMiwiaWF0IjoxNzYzOTY0MzAyLCJqdGkiOiI2YmVlM2QyZDE3NDg0Zjk1ODg0MjBjMDY2MjYyZjc0MCIsInVzZXJfaWQiOiIzIn0.S0Sl7PxSNA9gjyzyC2EuH5YwM0PmI9k3cja_o_VWtUs','2025-11-24 06:05:02.489732','2025-12-01 06:05:02.000000',3,'6bee3d2d17484f9588420c066262f740'),(167,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU2OTEwMiwiaWF0IjoxNzYzOTY0MzAyLCJqdGkiOiJlNWYxODVlODg0OTc0NGNhODM0Nzk3ZGVmMDJkY2UzMiIsInVzZXJfaWQiOiIzIn0.61dxmnCD_Bd6sNQGaZdNh3Oa-aMcFY3er2wtJDShnbg','2025-11-24 06:05:02.497131','2025-12-01 06:05:02.000000',3,'e5f185e8849744ca834797def02dce32'),(168,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU3MjY3NCwiaWF0IjoxNzYzOTY3ODc0LCJqdGkiOiIzMDc4ZGJmYmJjMjc0MjI0ODIxNTQ4YmQ4MjVkODdhMiIsInVzZXJfaWQiOiIyIn0.hJPCYaNLHCUj6VUYOt8vrT1pffaq8UmcbkP1pXIJRSA','2025-11-24 07:04:34.233441','2025-12-01 07:04:34.000000',2,'3078dbfbbc274224821548bd825d87a2'),(169,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NTY4OSwiaWF0IjoxNzY0MTQwODg5LCJqdGkiOiJhMzM2YTU2N2RiZGI0Y2Q0ODY2MDE3MjVmZTJhNjcwYiIsInVzZXJfaWQiOiIyIn0.BoA8EJSGLHfG_t7QMy2ZalC5C9gGFpx9EhS-XaQjtTw','2025-11-26 07:08:09.936027','2025-12-03 07:08:09.000000',2,'a336a567dbdb4cd486601725fe2a670b'),(170,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NTczMSwiaWF0IjoxNzY0MTQwOTMxLCJqdGkiOiI0MzIxMDczOTRkMTQ0ZTViYWYzODcxZmY2MmMxNGY2NCIsInVzZXJfaWQiOiIzIn0.BmEsfZ-_MxUIim6F8O5Z7XqDSyHI9qsekJGBdbo-Wh4','2025-11-26 07:08:51.687780','2025-12-03 07:08:51.000000',3,'432107394d144e5baf3871ff62c14f64'),(171,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NjA5NiwiaWF0IjoxNzY0MTQxMjk2LCJqdGkiOiI4NDA1MDEyOGFmMWQ0YmRjYmYwZjUxMjIxMTIxNzFmNiIsInVzZXJfaWQiOiIzIn0.s6TajpVSgtqoEMBcDz7hqRO3zoEDrzyULdcsEr-LyIc','2025-11-26 07:14:56.149660','2025-12-03 07:14:56.000000',3,'84050128af1d4bdcbf0f5122112171f6'),(172,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NjgyMCwiaWF0IjoxNzY0MTQyMDIwLCJqdGkiOiJmOWI1MWQxYzRmODk0ZDQ1OGE2YzkwNTE3ZmQzMmExNSIsInVzZXJfaWQiOiIzIn0.UX9WY343majFLVmNN7hO7yf6ZTPKiEnycCAHHCIMHZc','2025-11-26 07:27:00.986411','2025-12-03 07:27:00.000000',3,'f9b51d1c4f894d458a6c90517fd32a15'),(173,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NzEyNCwiaWF0IjoxNzY0MTQyMzI0LCJqdGkiOiIxN2Q5MjY2MTFjYzk0MzA4YmI0NTI2NjAwM2UzNWFiZiIsInVzZXJfaWQiOiIyIn0.8qSwXtUv5wwsuxg-XSG_LBZhoNBQVlFC_pIqx3_TpdE','2025-11-26 07:32:04.605321','2025-12-03 07:32:04.000000',2,'17d926611cc94308bb45266003e35abf'),(174,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NzEzMSwiaWF0IjoxNzY0MTQyMzMxLCJqdGkiOiJhNjg2MDliZmU0ZGQ0ZDFhODM5OTYxNDA0NjUzYWEzYSIsInVzZXJfaWQiOiIzIn0.Uw2CJTs7IjDNEGOQGH1Djm9DjVoZENpb1gAQCJkPfuo','2025-11-26 07:32:11.637109','2025-12-03 07:32:11.000000',3,'a68609bfe4dd4d1a839961404653aa3a'),(175,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NzM4OCwiaWF0IjoxNzY0MTQyNTg4LCJqdGkiOiJkODgyM2YyM2I1MjA0NjFkODYzNDJkYzljOGY4MWZiYSIsInVzZXJfaWQiOiIyIn0.snOP6xQUY2H78qKbWfB0sqrUJrIEeWwXBldIZhUgA2I','2025-11-26 07:36:28.056426','2025-12-03 07:36:28.000000',2,'d8823f23b520461d86342dc9c8f81fba'),(176,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NzM5MiwiaWF0IjoxNzY0MTQyNTkyLCJqdGkiOiI5MmI2MDVjMjRjMDI0NDEwOTE2YmVmM2E1ZTdlZjUzZiIsInVzZXJfaWQiOiIzIn0.GSznwnyRJek-DyYRitCdZopSlxAujy2WvMorqkfv1AU','2025-11-26 07:36:32.777870','2025-12-03 07:36:32.000000',3,'92b605c24c024410916bef3a5e7ef53f'),(177,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NzY5MCwiaWF0IjoxNzY0MTQyODkwLCJqdGkiOiJlOGUzYmI4NTE0MjM0ZjRhOThmYTI4YzU5ZDQ0N2Y0MSIsInVzZXJfaWQiOiIzIn0.6TFcvW5DiN-_wTt9gsSqoqPcio1_NqMqzvdSI1VEIe0','2025-11-26 07:41:30.071290','2025-12-03 07:41:30.000000',3,'e8e3bb8514234f4a98fa28c59d447f41'),(178,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0NzkzNywiaWF0IjoxNzY0MTQzMTM3LCJqdGkiOiIwY2U3NmQ5OGU4MDY0MmEzYmZjOTc0NzQ3ZTYwN2VhNyIsInVzZXJfaWQiOiIzIn0.y-7oGHCTRbSVu90pwDHakXwgNmSy6EnCKlcNSstO9Yc','2025-11-26 07:45:37.600833','2025-12-03 07:45:37.000000',3,'0ce76d98e80642a3bfc974747e607ea7'),(179,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0Nzk1NiwiaWF0IjoxNzY0MTQzMTU2LCJqdGkiOiI3M2IyZjU5ZmRjNTk0YTc1OTUyYTczMjFiOGJlZDBiNSIsInVzZXJfaWQiOiIyIn0.KakiUMjfjVli8Cgl8sGoK7lZ8gCKDzAcO44gtBTjsUY','2025-11-26 07:45:56.518836','2025-12-03 07:45:56.000000',2,'73b2f59fdc594a75952a7321b8bed0b5'),(180,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0ODUwMiwiaWF0IjoxNzY0MTQzNzAyLCJqdGkiOiIyMzQ2NWNkZWU1MGI0OTk4OTY3MTE0ZDlmN2M4NDFmNiIsInVzZXJfaWQiOiIzIn0.Gc1IjeXeJDAx_9CWNXgDi1QPEpQT33FuqNPAjrtltIg','2025-11-26 07:55:02.830566','2025-12-03 07:55:02.000000',3,'23465cdee50b4998967114d9f7c841f6'),(181,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0ODk3MCwiaWF0IjoxNzY0MTQ0MTcwLCJqdGkiOiJkNTkyNDg5ZWY4NzM0NzdjODA3YmIyYzYzNDc0OTkwNyIsInVzZXJfaWQiOiIzIn0.qwg36M4N0WYTpsSlY9NGyHZcjyOmziBE72wB3MTfiCo','2025-11-26 08:02:50.791376','2025-12-03 08:02:50.000000',3,'d592489ef873477c807bb2c634749907'),(182,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0OTg1OSwiaWF0IjoxNzY0MTQ1MDU5LCJqdGkiOiI3Njc1YjhlMjMzNmE0NDk5ODAwZTJhMjJhNzI3YmYwZCIsInVzZXJfaWQiOiIzIn0.vrR6BeHmgV0zb8EEVsc4GypLcKG3hbkHWbRPRoH_x1o','2025-11-26 08:17:39.415850','2025-12-03 08:17:39.000000',3,'7675b8e2336a4499800e2a22a727bf0d'),(183,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MDA0OCwiaWF0IjoxNzY0MTQ1MjQ4LCJqdGkiOiIwN2ViYTI4Y2IyYTU0YmVjYWE1Y2Q2N2IwYWQ3Zjk2ZCIsInVzZXJfaWQiOiIzIn0.QDBv8UhX6Ag3sJmj-F5u6XHlsW0LU36-7wdldNuyJ-k','2025-11-26 08:20:48.596237','2025-12-03 08:20:48.000000',3,'07eba28cb2a54becaa5cd67b0ad7f96d'),(184,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MDM4NSwiaWF0IjoxNzY0MTQ1NTg1LCJqdGkiOiJjZWU3MTg0MDkyNDQ0N2I4YTFiNTA5N2E4YTc0YjQxZCIsInVzZXJfaWQiOiIzIn0.QdYyxomILXT-YMmX8sI5NymGkQJNC_snVKO1bo9Fgew','2025-11-26 08:26:25.104884','2025-12-03 08:26:25.000000',3,'cee71840924447b8a1b5097a8a74b41d'),(185,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MTEzMiwiaWF0IjoxNzY0MTQ2MzMyLCJqdGkiOiJjYTA3NjQ4OTA2ZGE0NTVlODFiNjRhZjZhYTQ0OGY4NCIsInVzZXJfaWQiOiIzIn0.2VLbZGBuC4rOr0MGzHchLvbSQ0ridk9MNVu02HQ4aY8','2025-11-26 08:38:52.860961','2025-12-03 08:38:52.000000',3,'ca07648906da455e81b64af6aa448f84'),(186,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MTQ1NCwiaWF0IjoxNzY0MTQ2NjU0LCJqdGkiOiIwMDk4YzQxZjE5YmY0YWM1OTY4Mzc1YjBiOWFiNWMxYSIsInVzZXJfaWQiOiIzIn0.jo8BYXruh1LBy5RGs_ipjYCMIUdvVFFpv6Jm4x0yvY4','2025-11-26 08:44:14.364387','2025-12-03 08:44:14.000000',3,'0098c41f19bf4ac5968375b0b9ab5c1a'),(187,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MTc1MCwiaWF0IjoxNzY0MTQ2OTUwLCJqdGkiOiIzN2E4YjVjYzkxNmI0NzI4YmY0ZDRkZTQyZWZhODI4YyIsInVzZXJfaWQiOiIzIn0.1t2x25FzBK7cXw_hiZx6Q6yJWjYWSZEeetn2x33Us-A','2025-11-26 08:49:10.348929','2025-12-03 08:49:10.000000',3,'37a8b5cc916b4728bf4d4de42efa828c'),(188,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MjIyOSwiaWF0IjoxNzY0MTQ3NDI5LCJqdGkiOiJjMzY1ZjljZTAxZWY0YThmYTcyZjJlMGViNzZjMDAxYiIsInVzZXJfaWQiOiIyIn0.kahcSlbwEJTpXTAfg0D-qrJS9LEH5TzNO3KnZ5v9CzE','2025-11-26 08:57:09.416408','2025-12-03 08:57:09.000000',2,'c365f9ce01ef4a8fa72f2e0eb76c001b'),(189,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MjIyOSwiaWF0IjoxNzY0MTQ3NDI5LCJqdGkiOiJlMDc3NDMzOWRhOGI0YWY3YmJlMDBiNDFkZGJkNzM3MiIsInVzZXJfaWQiOiIyIn0.dgVyqmQOwpEyFXrqBvOfaNFBpqLqxtuyGmSxR6kr9c4','2025-11-26 08:57:09.418866','2025-12-03 08:57:09.000000',2,'e0774339da8b4af7bbe00b41ddbd7372'),(190,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MjIzMSwiaWF0IjoxNzY0MTQ3NDMxLCJqdGkiOiI0YTJiMDAwMWY2MWQ0NDBiOGI3NDc1M2JlNDljOGE0MSIsInVzZXJfaWQiOiIyIn0.76HQUB3GtOe7BaI-TMC4jzsc8-rNt-dtE98J1slb1l8','2025-11-26 08:57:11.066582','2025-12-03 08:57:11.000000',2,'4a2b0001f61d440b8b74753be49c8a41'),(191,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MjI2MSwiaWF0IjoxNzY0MTQ3NDYxLCJqdGkiOiJhYzBiMzFmOTVkZjk0YzhhOGQyZWI1MDkyNzk4Nzc1YyIsInVzZXJfaWQiOiIzIn0.-8ebvf20Riwh71N2Iw64bcj7VG9zvMlW2mAXk8xDb4Y','2025-11-26 08:57:41.121313','2025-12-03 08:57:41.000000',3,'ac0b31f95df94c8a8d2eb5092798775c'),(192,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1Mjk1OSwiaWF0IjoxNzY0MTQ4MTU5LCJqdGkiOiJiOWUzNDVhODQyNzc0OWFkYTlhYTZlMTg1YzJlYmUxMiIsInVzZXJfaWQiOiIyIn0.N3X4ndgLr-XhkKHTKBHVYO8Zk5nZl6pR116AgoUIKEU','2025-11-26 09:09:19.950562','2025-12-03 09:09:19.000000',2,'b9e345a8427749ada9aa6e185c2ebe12'),(193,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1Mjk3NCwiaWF0IjoxNzY0MTQ4MTc0LCJqdGkiOiJhMjA4OWE4MzFjODU0NDViOTdjNTY1YjA1ZjA1OTkyMyIsInVzZXJfaWQiOiIzIn0.XgMpuaTBz_Usr4VAzleFi-bzx5LY4hSNz3_agC9l0wk','2025-11-26 09:09:34.067093','2025-12-03 09:09:34.000000',3,'a2089a831c85445b97c565b05f059923'),(194,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MzUxOSwiaWF0IjoxNzY0MTQ4NzE5LCJqdGkiOiJiNWQyOWI4MzAwMzU0ODM5YWRlOWI3MGM0NmYyYTk0NyIsInVzZXJfaWQiOiIzIn0.vrlFCYa-7wP6HPJxn_YLkSQVZbCyZbDT8NVWqDmO_hc','2025-11-26 09:18:39.417291','2025-12-03 09:18:39.000000',3,'b5d29b8300354839ade9b70c46f2a947'),(195,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MzYwNiwiaWF0IjoxNzY0MTQ4ODA2LCJqdGkiOiIyYjM5NzE2ODZlNTA0ZGNhOTFhZGMxODk4MDE2NjRmMiIsInVzZXJfaWQiOiIzIn0.LGWuCAbaAD_BfkeOl6UzX0_esl3plfOHTgP27FpQrVo','2025-11-26 09:20:06.914843','2025-12-03 09:20:06.000000',3,'2b3971686e504dca91adc189801664f2'),(196,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1NDIwMiwiaWF0IjoxNzY0MTQ5NDAyLCJqdGkiOiI4MjNiNTgzOGFlZGE0NDQ3OTFiYTRhMmE2MDQ2M2E5NyIsInVzZXJfaWQiOiIyIn0.Ba6E8qzKKSoFebW1aWFcq5bF9rkYPse5hBSIIY_fiQo','2025-11-26 09:30:02.410279','2025-12-03 09:30:02.000000',2,'823b5838aeda444791ba4a2a60463a97'),(197,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1NDIzNCwiaWF0IjoxNzY0MTQ5NDM0LCJqdGkiOiI5MjM5NjU2MGY1ZjM0YjE2YmFkNzY1OGRjZmU2ZGM2OSIsInVzZXJfaWQiOiIzIn0.sJ2PbIKAwnYKQH1uahCr8BQnQZLX9_J5ijM89ihSayg','2025-11-26 09:30:34.404096','2025-12-03 09:30:34.000000',3,'92396560f5f34b16bad7658dcfe6dc69'),(198,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDkwMjQ5MSwiaWF0IjoxNzY0Mjk3NjkxLCJqdGkiOiI0YTZlNWVhMTA1M2U0MjZlODE0MTJiZWIzOTMyZTY1YiIsInVzZXJfaWQiOiIyIn0.EDWIz9OrX5BbBPD0wknewqd6YrToEmUzkeg33Nrho10','2025-11-28 02:41:31.126201','2025-12-05 02:41:31.000000',2,'4a6e5ea1053e426e81412beb3932e65b'),(199,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDkwMjQ5MSwiaWF0IjoxNzY0Mjk3NjkxLCJqdGkiOiI0NzNmMTI5NGFlNmI0MzM4YTJhY2NiMmYzOTM2OTg1YSIsInVzZXJfaWQiOiIyIn0.kKSDQlsQK9YqR3oxyqea4EBeHoDunQK7wNw4lKPfGh8','2025-11-28 02:41:31.120503','2025-12-05 02:41:31.000000',2,'473f1294ae6b4338a2accb2f3936985a'),(200,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDkwMjYwMywiaWF0IjoxNzY0Mjk3ODAzLCJqdGkiOiIyZmY4NzhhYzYxZWQ0MDRhOTU4NGUxYzgwOGI3ZGFjMSIsInVzZXJfaWQiOiIzIn0.Qa5nVszFlFqqS0UHoK-l1kNlcQykcdEXVYuJL8QfFSA','2025-11-28 02:43:23.095818','2025-12-05 02:43:23.000000',3,'2ff878ac61ed404a9584e1c808b7dac1'),(201,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDkwMjYwMywiaWF0IjoxNzY0Mjk3ODAzLCJqdGkiOiJiMGNhOWEwZmFkN2M0NjNiYjY1ZjBmNjk5ZGZlNjVjMiIsInVzZXJfaWQiOiIzIn0._SwskZjEygA8vsvxATVm5tLXRcoucmOiJ01FN0Q8VAU','2025-11-28 02:43:23.103404','2025-12-05 02:43:23.000000',3,'b0ca9a0fad7c463bb65f0f699dfe65c2'),(202,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDkwNDA5OCwiaWF0IjoxNzY0Mjk5Mjk4LCJqdGkiOiJiNTFlYmEwODIxZDU0ZGZkYTZiYjI1YjBhNWNkOTc1OCIsInVzZXJfaWQiOiIzIn0.1hCMni6fSLuO_AgXza2N7mDItecr-Qcxy_nq9d_D30M','2025-11-28 03:08:18.773214','2025-12-05 03:08:18.000000',3,'b51eba0821d54dfda6bb25b0a5cd9758'),(203,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDkwNDU2MCwiaWF0IjoxNzY0Mjk5NzYwLCJqdGkiOiI1MmQ0ZTk4MDcwZTk0MDU4ODk1YjU4OTk5Zjk0MTUwZSIsInVzZXJfaWQiOiIzIn0.gtwPfFH5M96BPjhhtynCZR0UuinH86XgAgBANPmJ7ug','2025-11-28 03:16:00.762896','2025-12-05 03:16:00.000000',3,'52d4e98070e94058895b58999f94150e'),(204,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNTcyNSwiaWF0IjoxNzY0NDMwOTI1LCJqdGkiOiI2ODY2ODFiNzI5ODM0MjQwYmViYmIwNzUyZDk0MGJmNyIsInVzZXJfaWQiOiIzIn0.z7uj6_mIwNwEswnUhfnd-1d94ZexTfgX3u1X4KZrHmk','2025-11-29 15:42:05.978780','2025-12-06 15:42:05.000000',3,'686681b729834240bebbb0752d940bf7'),(205,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNTcyNSwiaWF0IjoxNzY0NDMwOTI1LCJqdGkiOiI2MTYyNDg1NjE0ZDA0ZTU2YTc5MWM2ZGJlNzYwMWMwYyIsInVzZXJfaWQiOiIzIn0.WJKHiOLMLl_V1h1v2HdP0nodOYd0npHclj3m4xiUSng','2025-11-29 15:42:05.985518','2025-12-06 15:42:05.000000',3,'6162485614d04e56a791c6dbe7601c0c'),(206,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNTg2MiwiaWF0IjoxNzY0NDMxMDYyLCJqdGkiOiIxMGU2ODM5ZGFlZTY0M2Y1ODYwMzUzNDBmZmE0MDE4YiIsInVzZXJfaWQiOiIyIn0.nuAHGpps-GiEoKBOPMeIEeyGnUezVejRBz6AtyRtPNg','2025-11-29 15:44:22.678383','2025-12-06 15:44:22.000000',2,'10e6839daee643f586035340ffa4018b'),(207,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNjQ0MCwiaWF0IjoxNzY0NDMxNjQwLCJqdGkiOiI1MWQ5YjRhZGFjNjE0OGQzYmE4NzgzMmQ1MGUxZGJjNCIsInVzZXJfaWQiOiIzIn0.MLyDANWR2CvNchUpc_ZMqrJru16Vt8hK2Fofh1hPh9U','2025-11-29 15:54:00.397810','2025-12-06 15:54:00.000000',3,'51d9b4adac6148d3ba87832d50e1dbc4'),(208,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNjUzMCwiaWF0IjoxNzY0NDMxNzMwLCJqdGkiOiJjNjk4NmE2NjBlY2Y0OWQ4YWIzZTY0MDE0ODU0YTM5NSIsInVzZXJfaWQiOiIyIn0.dnemCvMM05WVO4-KYVkiL4Qlxsnv5JgrMFJY-8ro-7Q','2025-11-29 15:55:30.167589','2025-12-06 15:55:30.000000',2,'c6986a660ecf49d8ab3e64014854a395'),(209,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNjY2MSwiaWF0IjoxNzY0NDMxODYxLCJqdGkiOiJhYTdlN2Y1NDAzNmE0M2I4OGMwZDU4NGU5MTQ1YWMzOSIsInVzZXJfaWQiOiIyIn0.IwIVlhBPitUp39MNha8ot4DdyWIU4yZXvu_wjyJPev0','2025-11-29 15:57:41.837018','2025-12-06 15:57:41.000000',2,'aa7e7f54036a43b88c0d584e9145ac39'),(210,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNjY3NSwiaWF0IjoxNzY0NDMxODc1LCJqdGkiOiIzYzBmYTM0YTczYzM0MzI0YmI5ZGE0ZGVmNjc2OGUzZCIsInVzZXJfaWQiOiIzIn0.zUv3YPSIFjLeBj2eQ8_Abvdey3OR4scoR4kRzctu6WI','2025-11-29 15:57:55.136681','2025-12-06 15:57:55.000000',3,'3c0fa34a73c34324bb9da4def6768e3d'),(211,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNzMxOCwiaWF0IjoxNzY0NDMyNTE4LCJqdGkiOiI4YThmYjk2MTI0OTQ0MGMzOGM1ZDI3N2M0MTA1NmEyYyIsInVzZXJfaWQiOiIzIn0.duL695pwM3BpWoFAw3MaihCLl88wGodT9x8yUJLnZnE','2025-11-29 16:08:38.005079','2025-12-06 16:08:38.000000',3,'8a8fb961249440c38c5d277c41056a2c'),(212,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNzgyNSwiaWF0IjoxNzY0NDMzMDI1LCJqdGkiOiIxOWYzODJlMzQ3MGY0NDNmOGE3MjkzYTJjNGRkMDdhYyIsInVzZXJfaWQiOiIyIn0.UHwI_nDHrWlY7VKeXv2cIal_rimTuAPnaFoSXp_Y8f8','2025-11-29 16:17:05.681449','2025-12-06 16:17:05.000000',2,'19f382e3470f443f8a7293a2c4dd07ac'),(213,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNzgyNiwiaWF0IjoxNzY0NDMzMDI2LCJqdGkiOiJjZTkzOWJhZGNjMDg0MzE3YWE3NTk1MDE1YmJmMGE3NiIsInVzZXJfaWQiOiIyIn0.8XLIUvu8NYA76Wa72iIiBj0cmpMrSYzA6-7i_9MWS5w','2025-11-29 16:17:06.490550','2025-12-06 16:17:06.000000',2,'ce939badcc084317aa7595015bbf0a76'),(214,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNzg0MCwiaWF0IjoxNzY0NDMzMDQwLCJqdGkiOiJlMDQ2NmJlMmVlNDM0YTZjOTA4NjUyYzAwYTY1MGYwZSIsInVzZXJfaWQiOiIzIn0.5oXajduPBqR2hcrXaeTC0I1M2qJKRLJkMJbNjeQgw0Q','2025-11-29 16:17:20.095505','2025-12-06 16:17:20.000000',3,'e0466be2ee434a6c908652c00a650f0e'),(215,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA0MDUwNiwiaWF0IjoxNzY0NDM1NzA2LCJqdGkiOiIwNDQ2MGQzM2ZkODY0NmNkYTdlNzRhZjNkNDkxNzk3MSIsInVzZXJfaWQiOiIyIn0.qGu3gekzskCH8-3Vbpguy1OxdQYIAL_mBKKnTeOvfNo','2025-11-29 17:01:46.294536','2025-12-06 17:01:46.000000',2,'04460d33fd8646cda7e74af3d4917971'),(216,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA0MDUzOCwiaWF0IjoxNzY0NDM1NzM4LCJqdGkiOiI1MjIwM2Q3ODNkZGM0OTgwYTJmYmVlZjA0ZmEzMTQzZiIsInVzZXJfaWQiOiIzIn0.7HX2NxPg0bDexe0NwfsaK9qKGRpLOLjT-OFn5ljkQ-k','2025-11-29 17:02:18.673373','2025-12-06 17:02:18.000000',3,'52203d783ddc4980a2fbeef04fa3143f'),(217,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA5OTA4NiwiaWF0IjoxNzY0NDk0Mjg2LCJqdGkiOiJkYzAzMWQ3ODQxZDM0MmQyYjc5ZDQ1OTRmM2Y5YWViNyIsInVzZXJfaWQiOiIyIn0.i6ZhV-YdezaE6qrWrUXstY0RPBC4HxuCHpRpSN7k0zs','2025-11-30 09:18:06.943091','2025-12-07 09:18:06.000000',2,'dc031d7841d342d2b79d4594f3f9aeb7'),(218,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA5OTA4NiwiaWF0IjoxNzY0NDk0Mjg2LCJqdGkiOiJhYWM1ZmFlMWEyYjA0ZTQ5OTNjYmUzMzk1ZDdhMmUwYiIsInVzZXJfaWQiOiIyIn0.95aCQ06Nv23lT7zXew5bnA24fAR5Pp6fwSx29VQOeSg','2025-11-30 09:18:06.942091','2025-12-07 09:18:06.000000',2,'aac5fae1a2b04e4993cbe3395d7a2e0b'),(219,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA5OTExNCwiaWF0IjoxNzY0NDk0MzE0LCJqdGkiOiJlZmE0YTMzYjFlMzk0ODFiOWZkNGEyOTA1NDExOTZhYyIsInVzZXJfaWQiOiIzIn0.s0swmMNh0z8kem0TUJy9geTHj4Y9daVKA7uwiyPs6Dg','2025-11-30 09:18:34.292935','2025-12-07 09:18:34.000000',3,'efa4a33b1e39481b9fd4a290541196ac'),(220,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA5OTExNCwiaWF0IjoxNzY0NDk0MzE0LCJqdGkiOiI0MDQwYmFiZDg2ZTQ0ODk3ODAwZDA5YjA3YzdhNzE4OSIsInVzZXJfaWQiOiIzIn0.2rWtU5pPglZYpBCHekwEnkKybX84Uiunlt64hb7yIKg','2025-11-30 09:18:34.304645','2025-12-07 09:18:34.000000',3,'4040babd86e44897800d09b07c7a7189'),(221,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA5OTIwMSwiaWF0IjoxNzY0NDk0NDAxLCJqdGkiOiIzOThlNjAyYWMyNTI0MmMwYmFjNzI2NzdiZGU0M2ZkZCIsInVzZXJfaWQiOiIyIn0.MNokZdAvQ5m-qBDfvOt6t6gGn_TpFb0BOQ34wEZMLX8','2025-11-30 09:20:01.333209','2025-12-07 09:20:01.000000',2,'398e602ac25242c0bac72677bde43fdd'),(222,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMDA1OCwiaWF0IjoxNzY0NDk1MjU4LCJqdGkiOiI3YTU0NmY2NjlmNDI0MTc3YWE0NWMwNzhlYjdmNjM1YyIsInVzZXJfaWQiOiIzIn0.9VcqzQ3JvmTbdhVp-HnjtBDLkcy-x9hAUqrbhF0fET4','2025-11-30 09:34:18.079748','2025-12-07 09:34:18.000000',3,'7a546f669f424177aa45c078eb7f635c'),(223,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMDQwNiwiaWF0IjoxNzY0NDk1NjA2LCJqdGkiOiJiNDVlMTRkMjU1Mjk0ZDM4YmNmY2I5MmI2ZDNjYWMzMyIsInVzZXJfaWQiOiIzIn0.CBJuzc8E64lsaXW5mydis9E6MgnJUqJVEeX6tSiBaY8','2025-11-30 09:40:06.242950','2025-12-07 09:40:06.000000',3,'b45e14d255294d38bcfcb92b6d3cac33'),(224,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMDQ3NiwiaWF0IjoxNzY0NDk1Njc2LCJqdGkiOiJhNTMxMzU3ZmQ0MTM0OGJkYWVmMjZlYWVlM2VlOGIzYyIsInVzZXJfaWQiOiIyIn0.5taH2K7bV-O4bEvXbAplVzKszOMyKYrDY3guKUZJy70','2025-11-30 09:41:16.882488','2025-12-07 09:41:16.000000',2,'a531357fd41348bdaef26eaee3ee8b3c'),(225,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMDc5MCwiaWF0IjoxNzY0NDk1OTkwLCJqdGkiOiI0OTE5ZDc3ZGFlMGE0ZjQ1OGQ2ZjIwNzMzMTI1NDM5NSIsInVzZXJfaWQiOiIyIn0.fnmPmkIpuGfVL2QxtpljcuRDiDis1R6ee3qXpFyQe2g','2025-11-30 09:46:30.816897','2025-12-07 09:46:30.000000',2,'4919d77dae0a4f458d6f207331254395'),(226,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMDkwMSwiaWF0IjoxNzY0NDk2MTAxLCJqdGkiOiI5NjI4MGQ4NTU4YTM0NTc3ODI5ZGRmOTQwYzI2ODRlMCIsInVzZXJfaWQiOiIzIn0.kT02xcGulRb4oLgz3LARxI7t0gyRozTBnoxAUK9phmQ','2025-11-30 09:48:21.993447','2025-12-07 09:48:21.000000',3,'96280d8558a34577829ddf940c2684e0'),(227,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMDkzMiwiaWF0IjoxNzY0NDk2MTMyLCJqdGkiOiI3MWQwODMxMjliOTY0ZmJlYWI0YWQwNDhiMDk3MGIwYSIsInVzZXJfaWQiOiIyIn0.WP6ozuz9C-cnb9HLTUrEH_R9pk_pYo23LHfxMJFtMvk','2025-11-30 09:48:52.647432','2025-12-07 09:48:52.000000',2,'71d083129b964fbeab4ad048b0970b0a'),(228,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMTEzOSwiaWF0IjoxNzY0NDk2MzM5LCJqdGkiOiJkY2NiZTliN2UwY2Q0OTgyODFkN2JkNTg2YTExMzc0NyIsInVzZXJfaWQiOiIzIn0.5xNU5RxtZMEM5YCeHzsBB1_-TWA-u0dqoNkNaTosGqA','2025-11-30 09:52:19.297085','2025-12-07 09:52:19.000000',3,'dccbe9b7e0cd498281d7bd586a113747'),(229,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMzM2NywiaWF0IjoxNzY0NDk4NTY3LCJqdGkiOiIwOTM3NTQzMjFjYjA0YjI0ODNhOThlYjAyOTI5YzVhMiIsInVzZXJfaWQiOiIzIn0.E1OS0L1kWdReCReIx242sp5dFML0BejD3-W8pQArmyg','2025-11-30 10:29:27.010183','2025-12-07 10:29:27.000000',3,'093754321cb04b2483a98eb02929c5a2'),(230,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTEwMzQ1MSwiaWF0IjoxNzY0NDk4NjUxLCJqdGkiOiIzZDIwNzVjNjM2MDg0YTIzODkyMGQwMGQ5N2MyMTFhZiIsInVzZXJfaWQiOiIzIn0.bryndxnrSiaBY3_3yYNtCLg9cJUInqJ0ZpYuJj55nZk','2025-11-30 10:30:51.087192','2025-12-07 10:30:51.000000',3,'3d2075c636084a238920d00d97c211af'),(231,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTE1ODc5MSwiaWF0IjoxNzY0NTUzOTkxLCJqdGkiOiJlYWEyYjE2YjcwODg0MWYyODU5ZjNmMWQ2MTk4NzkxNCIsInVzZXJfaWQiOiIyIn0.D5vCcRiVO1UEH0meB4gWwB7PQbtemjLOqmXevPdISrU','2025-12-01 01:53:11.198899','2025-12-08 01:53:11.000000',2,'eaa2b16b708841f2859f3f1d61987914'),(232,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTE1ODc5MSwiaWF0IjoxNzY0NTUzOTkxLCJqdGkiOiI0NWQ3MjZjMTBmM2M0OGQ3YmU3MWNiMjBlNGU3ZmRlNSIsInVzZXJfaWQiOiIyIn0.9MCHWJpXnIjC7SGzuYyv3LWUq-aO-hwc44hFyHJE-kE','2025-12-01 01:53:11.191895','2025-12-08 01:53:11.000000',2,'45d726c10f3c48d7be71cb20e4e7fde5'),(233,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTE1ODgwOCwiaWF0IjoxNzY0NTU0MDA4LCJqdGkiOiI2ZjBkNDk1ZjU3ZDY0NzliYmZkZDI4YzZjOWQzYjNhYyIsInVzZXJfaWQiOiIzIn0.wuj1IBCC-6ZH7C0fWO5p1Ll1ywNECx0ekV8qvtNujgs','2025-12-01 01:53:28.587630','2025-12-08 01:53:28.000000',3,'6f0d495f57d6479bbfdd28c6c9d3b3ac'),(234,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTE1ODgwOCwiaWF0IjoxNzY0NTU0MDA4LCJqdGkiOiJmNThjMzJmMzFkMDE0NDc0ODM1NmUxNThmNzkzZjMyNiIsInVzZXJfaWQiOiIzIn0.SRemi_aX8nKjBfu2tP1zZnSFItTnPKuX5RaHle_jLUM','2025-12-01 01:53:28.595083','2025-12-08 01:53:28.000000',3,'f58c32f31d0144748356e158f793f326'),(235,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTYwNDQzMiwiaWF0IjoxNzY0OTk5NjMyLCJqdGkiOiI1ODIxYTI1OGVjZGE0N2M4OWRiYTUzMzk2MmFkMzBmNyIsInVzZXJfaWQiOiIyIn0.MXMN8SR5aiWLjGid9yGVACW0stVZWbOoRuNeRJK3NBc','2025-12-06 05:40:32.891551','2025-12-13 05:40:32.000000',2,'5821a258ecda47c89dba533962ad30f7'),(236,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTYwNDU0MywiaWF0IjoxNzY0OTk5NzQzLCJqdGkiOiIwZDJkOTgwYzQzYWI0ZTE2OGJiM2I5ZjhjNmU4MjQ2YSIsInVzZXJfaWQiOiIzIn0.4Cf8-WMf1LM52n3iFR0SPiZVlm5tBwdOuDj0-BmQRsc','2025-12-06 05:42:23.475586','2025-12-13 05:42:23.000000',3,'0d2d980c43ab4e168bb3b9f8c6e8246a'),(237,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTYwNzEzMCwiaWF0IjoxNzY1MDAyMzMwLCJqdGkiOiJlYzgxOTZkM2UzYjU0MjZlYTg2YjhjZTI5MGY5ZjI5YyIsInVzZXJfaWQiOiIyIn0.sBAxFzKFWoF1z8Z2h15w4wquw0caip0Q7ZTpfUnmqa4','2025-12-06 06:25:30.750343','2025-12-13 06:25:30.000000',2,'ec8196d3e3b5426ea86b8ce290f9f29c'),(238,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0Nzk2NiwiaWF0IjoxNzY2MDQzMTY2LCJqdGkiOiIyZDdiZTRiNWE1YzM0NzRhYjhlM2RhMzhjMWEwNWE2NyIsInVzZXJfaWQiOiIyIn0.VWmJB_8PbTo9WbdgqQwcx4V7d0BWbkp1emdCy0nkPeg','2025-12-18 07:32:46.359272','2025-12-25 07:32:46.000000',2,'2d7be4b5a5c3474ab8e3da38c1a05a67'),(239,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODA5MywiaWF0IjoxNzY2MDQzMjkzLCJqdGkiOiJjMTc5ZWM0ZTZhYjU0MjJlOTkzYTk0YzRlZjAxMGU4OCIsInVzZXJfaWQiOiIzIn0.iDkeQRLHyrIIgqOKpe2bk-vBlZq8gHB2w_Ebh7dejg8','2025-12-18 07:34:53.832348','2025-12-25 07:34:53.000000',3,'c179ec4e6ab5422e993a94c4ef010e88'),(240,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODEzMCwiaWF0IjoxNzY2MDQzMzMwLCJqdGkiOiI2NjhiYWFmMmZlOTk0MmUyOGU4MGViMWQ1OTU1YTgwZSIsInVzZXJfaWQiOiIzIn0.pLXTz40e44_GPwBtDrQFiomjxJXqoz8dbhoKaoXJBDw','2025-12-18 07:35:30.234918','2025-12-25 07:35:30.000000',3,'668baaf2fe9942e28e80eb1d5955a80e'),(241,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODE5OSwiaWF0IjoxNzY2MDQzMzk5LCJqdGkiOiI5M2M3YjA2YmUxZjI0N2Y2YTE1M2E4YmVjZTVkNDE2NyIsInVzZXJfaWQiOiIzIn0.bJgOQtw7kqnXl_pVQmU4rmVuUlRcfBpwgpRs97H8Cxg','2025-12-18 07:36:39.175494','2025-12-25 07:36:39.000000',3,'93c7b06be1f247f6a153a8bece5d4167'),(242,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODIyNiwiaWF0IjoxNzY2MDQzNDI2LCJqdGkiOiI0Y2FiNTM4MzU0NDM0YTAyYTFkZTliYmI4MjVjYmJjNSIsInVzZXJfaWQiOiIzIn0.JzrIJb2bIXUlPg4i129S-y78DBDtf8_fQQCphZaBtNY','2025-12-18 07:37:06.608672','2025-12-25 07:37:06.000000',3,'4cab538354434a02a1de9bbb825cbbc5'),(243,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODIzMCwiaWF0IjoxNzY2MDQzNDMwLCJqdGkiOiIxYTk2MmQyNmYyZjk0ZTI5Yjk2MzI5NDZiNDVmNzc0NCIsInVzZXJfaWQiOiIyIn0.Mx8wb91l6dJ_o3HmX-wxGtwYGuRkRg1NLXAsiMpa_-A','2025-12-18 07:37:10.460134','2025-12-25 07:37:10.000000',2,'1a962d26f2f94e29b9632946b45f7744'),(244,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODI0MywiaWF0IjoxNzY2MDQzNDQzLCJqdGkiOiI5NTAxY2ZjMDZhZTA0ZmY4YjgzNmY3MGUzMjYyMDg3MiIsInVzZXJfaWQiOiIyIn0.hMGDoChKr1Lg5K7rMQgNY-2q3CP9R5vPBakMq-kGeP8','2025-12-18 07:37:23.890450','2025-12-25 07:37:23.000000',2,'9501cfc06ae04ff8b836f70e32620872'),(245,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODQ2NywiaWF0IjoxNzY2MDQzNjY3LCJqdGkiOiJlOTI1YmUzZjQwMmE0MzAyYWVhMWNlMmMxMjUxNTc1NSIsInVzZXJfaWQiOiIzIn0.aN6JDODwbGZC225wBFMt66hcQr4crsJhREZsAyJxFPY','2025-12-18 07:41:07.363281','2025-12-25 07:41:07.000000',3,'e925be3f402a4302aea1ce2c12515755'),(246,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0ODY1NiwiaWF0IjoxNzY2MDQzODU2LCJqdGkiOiIzOTAzY2M0ZDkxYjE0YjViYmYxMmZkMzkzZDM2ZjBiNSIsInVzZXJfaWQiOiIzIn0.fYz8r1TVty5nr7qMektASswf3mVTlz8TE6ixxjonzIo','2025-12-18 07:44:16.743617','2025-12-25 07:44:16.000000',3,'3903cc4d91b14b5bbf12fd393d36f0b5'),(247,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0OTM5NCwiaWF0IjoxNzY2MDQ0NTk0LCJqdGkiOiIyMGUxYWI2NTkyNmM0MjM1YjAzYWZmZWZiOWNkYjhjMiIsInVzZXJfaWQiOiIyIn0.WiK55p5r3mADUc8nlkzK-KEdEnzTkioJRe9y4GwtJEo','2025-12-18 07:56:34.183332','2025-12-25 07:56:34.000000',2,'20e1ab65926c4235b03affefb9cdb8c2'),(248,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY0OTYyOCwiaWF0IjoxNzY2MDQ0ODI4LCJqdGkiOiJjN2Q0ZTg0ZDU5ZDA0OWQ2YjNjNjliNDQ3MjRlMDY1YSIsInVzZXJfaWQiOiIzIn0.-lKtoQA5g3Mh1CK9AxSzyq_9X9EO_YH28-sbKDEIll8','2025-12-18 08:00:28.869811','2025-12-25 08:00:28.000000',3,'c7d4e84d59d049d6b3c69b44724e065a'),(249,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY1MzAzNywiaWF0IjoxNzY2MDQ4MjM3LCJqdGkiOiI2NTEyNzc1YjU0YTY0Njc2YjEwOWQwZThiMWIwMjJkNCIsInVzZXJfaWQiOiIyIn0.TMEJagvJu7lbXxPBMKSqxqkSkLXYF6h0PbOvEGHAAgQ','2025-12-18 08:57:17.239926','2025-12-25 08:57:17.000000',2,'6512775b54a64676b109d0e8b1b022d4'),(250,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY1MzAzNywiaWF0IjoxNzY2MDQ4MjM3LCJqdGkiOiIwMWIwM2E4ZGVmMGQ0NDFlYTMyOGQ1ODAzZTU3M2RiMSIsInVzZXJfaWQiOiIyIn0.1cIXpo27mL_Z5Igze-6j9m2j_GiT0I-ULGrAm89p9I8','2025-12-18 08:57:17.245803','2025-12-25 08:57:17.000000',2,'01b03a8def0d441ea328d5803e573db1'),(251,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY1MzAzNywiaWF0IjoxNzY2MDQ4MjM3LCJqdGkiOiJlYWQ3MWY0ODc2YjU0YjE3OTEzMzYzMWM0MDY0OWE4OCIsInVzZXJfaWQiOiIyIn0.iHCngVpuBFTSGs5CT2KGK6RSzEZC8eWz6CbEaZQUKnA','2025-12-18 08:57:17.241926','2025-12-25 08:57:17.000000',2,'ead71f4876b54b179133631c40649a88'),(252,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY1MzAzNywiaWF0IjoxNzY2MDQ4MjM3LCJqdGkiOiIxMjUyYTdjOWZkY2I0NzIxYWFlOTY2YTAwMWY0ZTE4OSIsInVzZXJfaWQiOiIyIn0.Jug0qsgUQ4oTf1cmBQaMEOTrKC9J82fFJHqoHPKu49c','2025-12-18 08:57:17.248346','2025-12-25 08:57:17.000000',2,'1252a7c9fdcb4721aae966a001f4e189'),(253,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY1MzI1MCwiaWF0IjoxNzY2MDQ4NDUwLCJqdGkiOiI4OGMxYTQ0MzE0ZDU0YWNjOWZiOGVmZTU3ZDE1NmI3OCIsInVzZXJfaWQiOiIzIn0.5uMgF61-bVU9dIxM3N7Cvuj2jVW8NbFUkyt7dtHz538','2025-12-18 09:00:50.221921','2025-12-25 09:00:50.000000',3,'88c1a44314d54acc9fb8efe57d156b78'),(254,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY1ODQ3OCwiaWF0IjoxNzY2MDUzNjc4LCJqdGkiOiIwYzYzMDk0ZTlhNWY0YWM0YTEwZDgxOTBmMmNmMmI1NiIsInVzZXJfaWQiOiIyIn0.mjY02NEXkEItdT-K1U4ZK6LiLNBOw1EOqmrnV1LD9NA','2025-12-18 10:27:58.139991','2025-12-25 10:27:58.000000',2,'0c63094e9a5f4ac4a10d8190f2cf2b56'),(255,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY2Mzg0NCwiaWF0IjoxNzY2MDU5MDQ0LCJqdGkiOiIwYzllZDljNWFlOWU0YTM1ODVmY2E3YzM1MDQzNTdmOCIsInVzZXJfaWQiOiIyIn0.Q3eZuNVAkxO5emCkhlpn_eCp-MFHtUyCcZ8SONgRtoI','2025-12-18 11:57:24.939684','2025-12-25 11:57:24.000000',2,'0c9ed9c5ae9e4a3585fca7c3504357f8'),(256,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY2Mzg0NCwiaWF0IjoxNzY2MDU5MDQ0LCJqdGkiOiI1ZjJhMDYwNTBlNWE0ZGMyYTRhM2I4YTNjM2QwOGI3OCIsInVzZXJfaWQiOiIyIn0.vvuohxTV4fE7d43zN_GPNqnM3j1hWd3nk-X_xpZ91t8','2025-12-18 11:57:24.933427','2025-12-25 11:57:24.000000',2,'5f2a06050e5a4dc2a4a3b8a3c3d08b78'),(257,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY2Mzg0NywiaWF0IjoxNzY2MDU5MDQ3LCJqdGkiOiJjZGQ4M2ViMzA0NWQ0NjMxYmU4NDczZjdhZDMyMjNlMCIsInVzZXJfaWQiOiIyIn0.-rcZeqMMDYFTwq67Y9TrxzCi8XYc_o1c-9LAzjpR5Fc','2025-12-18 11:57:27.335293','2025-12-25 11:57:27.000000',2,'cdd83eb3045d4631be8473f7ad3223e0'),(258,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjY2Mzg1NywiaWF0IjoxNzY2MDU5MDU3LCJqdGkiOiI0Njc5YmIyNmFhMTk0ZDE4OWI2MjY1ZGJlZDUzMGFhZSIsInVzZXJfaWQiOiIzIn0.ePB2QM2C1uaBtBwk5-73fQ2dFeBuCGm2SoCGnIomHak','2025-12-18 11:57:37.656152','2025-12-25 11:57:37.000000',3,'4679bb26aa194d189b6265dbed530aae'),(259,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczMTU0MCwiaWF0IjoxNzY2MTI2NzQwLCJqdGkiOiJiZGYxYTIxM2M4YTk0NTJhYmVkMDk0NzBkZmQ2OTQ3NSIsInVzZXJfaWQiOiIyIn0.XZr03PjXeYKR0I661cDxzYKY-Qfx3l9vjnDaVgEOE_A','2025-12-19 06:45:40.720866','2025-12-26 06:45:40.000000',2,'bdf1a213c8a9452abed09470dfd69475'),(260,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczMTU0MCwiaWF0IjoxNzY2MTI2NzQwLCJqdGkiOiJiNTE3ZTBhYTYxOTQ0NmIyYjk5YzA4ZDRkMThiMTNlNiIsInVzZXJfaWQiOiIyIn0.gTZjHW27S_v5yt_UK61AXParB3fsBwDFSTdITCvqOG0','2025-12-19 06:45:40.713047','2025-12-26 06:45:40.000000',2,'b517e0aa619446b2b99c08d4d18b13e6'),(261,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczMTU0MywiaWF0IjoxNzY2MTI2NzQzLCJqdGkiOiJlMmE3NDM0YzY3NTY0YjJhOTgwOGU2YTA5NTg5NDQ2MSIsInVzZXJfaWQiOiIyIn0.tYWfvvTpuZbbAo-7M9loCnQuLZhc3PoSJir24WBm11U','2025-12-19 06:45:43.027812','2025-12-26 06:45:43.000000',2,'e2a7434c67564b2a9808e6a095894461'),(262,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczMTU1OCwiaWF0IjoxNzY2MTI2NzU4LCJqdGkiOiJiMzVjZmZhNTExODk0YTZjYjBhYjBkOGVmYzA5MTFkNyIsInVzZXJfaWQiOiIzIn0.9K-X9laUctW3lHOtgvRi-s3jFhbWyML50YQ2HZh-Bq0','2025-12-19 06:45:58.241129','2025-12-26 06:45:58.000000',3,'b35cffa511894a6cb0ab0d8efc0911d7'),(263,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczMTU1OCwiaWF0IjoxNzY2MTI2NzU4LCJqdGkiOiI1ZDQ0MGI5ODdjZWM0MzgzYjg3ODdjNGRhOGE1NGMxMCIsInVzZXJfaWQiOiIzIn0.v8RBX-8olCDvrH_A51eURYDGwCmCfJCHNXDQ_RM8HEo','2025-12-19 06:45:58.237941','2025-12-26 06:45:58.000000',3,'5d440b987cec4383b8787c4da8a54c10'),(264,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczMTU2MSwiaWF0IjoxNzY2MTI2NzYxLCJqdGkiOiJkODFhYzM3YTVmNzY0OGY3OGNkYWE2MDA5N2FlNjdkNiIsInVzZXJfaWQiOiIzIn0.T8uMDtp6LP8Hp8gaiD47xxp4jBHiZDqfPBTp_vl4-w8','2025-12-19 06:46:01.079108','2025-12-26 06:46:01.000000',3,'d81ac37a5f7648f78cdaa60097ae67d6'),(265,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczNTE0NiwiaWF0IjoxNzY2MTMwMzQ2LCJqdGkiOiI4ZWRlOGUzZmZhMWI0Zjk4YWIyZjIwNGJjNmJiZDEyMCIsInVzZXJfaWQiOiIzIn0.eOT90b_Kxm9Yu4WLuFWtofVlTvZpdZ_DHUavg1yoWlM','2025-12-19 07:45:46.862295','2025-12-26 07:45:46.000000',3,'8ede8e3ffa1b4f98ab2f204bc6bbd120'),(266,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczNTE1NywiaWF0IjoxNzY2MTMwMzU3LCJqdGkiOiIyOGY0NjQzYjAzZTY0YmMxODc5NjQ3OTg3MGU5NzYzNCIsInVzZXJfaWQiOiIzIn0.X2kRi9ejtN0lipC9HGZWosGa6trh2j4rBVd7Hj9x8Z0','2025-12-19 07:45:57.000735','2025-12-26 07:45:57.000000',3,'28f4643b03e64bc18796479870e97634'),(267,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczNjE3MCwiaWF0IjoxNzY2MTMxMzcwLCJqdGkiOiI2NDQ2N2ZjNzIzZmI0ZGZiOWJlOTBlYmRmMDU1ZDg3OSIsInVzZXJfaWQiOiIzIn0.2Kd0LJlRv52vZldgYb4z6E2V6O-fyBO3KJBlNw5hyh4','2025-12-19 08:02:50.953314','2025-12-26 08:02:50.000000',3,'64467fc723fb4dfb9be90ebdf055d879'),(268,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczNjUwNSwiaWF0IjoxNzY2MTMxNzA1LCJqdGkiOiIyNDEwZWYwZTNkYjE0NzQ2Yjk2YzcwMzAzNmE0YWQxYSIsInVzZXJfaWQiOiIyIn0.VqZADO7Kx_ZtpgPFY8E5IyGv6246V2Weqg-0i3TyIWo','2025-12-19 08:08:25.678189','2025-12-26 08:08:25.000000',2,'2410ef0e3db14746b96c703036a4ad1a'),(269,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczNjUwNSwiaWF0IjoxNzY2MTMxNzA1LCJqdGkiOiIxYWQ5Y2Q0ZThkYzA0ZDVjOTM1YWViY2RlM2FhOGQ4ZCIsInVzZXJfaWQiOiIyIn0.oTtXptDx60iwOzKGuyBDxKqSItBa7GUQ0Nrw8mDU-PQ','2025-12-19 08:08:25.684207','2025-12-26 08:08:25.000000',2,'1ad9cd4e8dc04d5c935aebcde3aa8d8d'),(270,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0MTA4NCwiaWF0IjoxNzY2MTM2Mjg0LCJqdGkiOiJjYzBiNjA4MGNmZjI0ZDAxYmU4MTk5OTM5ZTk0OGM3MyIsInVzZXJfaWQiOiIzIn0.QozrPR7uRDjPu864cj4cddAEHs8hNK4ns4mLeaJdN2g','2025-12-19 09:24:44.846360','2025-12-26 09:24:44.000000',3,'cc0b6080cff24d01be8199939e948c73'),(271,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0MTE4NiwiaWF0IjoxNzY2MTM2Mzg2LCJqdGkiOiIyZmRmMmEwNzAyMjA0YzdjYjAxMjFmNjFkNWQ0YjlmMiIsInVzZXJfaWQiOiIzIn0.zZjPvdz8GawhSC0y0iU9enWCKIOpN_XjWqJzOSFIhzE','2025-12-19 09:26:26.353723','2025-12-26 09:26:26.000000',3,'2fdf2a0702204c7cb0121f61d5d4b9f2'),(272,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0MTg1OCwiaWF0IjoxNzY2MTM3MDU4LCJqdGkiOiI1YWRhZmRkYmU5YzY0NzUwOWM2NmM1Y2JiNzM5YTc3MCIsInVzZXJfaWQiOiIzIn0.8FrAtLaVqV4NAWMoEhGNgLmV9_IyQlhLJEA95ApBajE','2025-12-19 09:37:38.941737','2025-12-26 09:37:38.000000',3,'5adafddbe9c647509c66c5cbb739a770'),(273,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0MTkwMywiaWF0IjoxNzY2MTM3MTAzLCJqdGkiOiI1ZDY1NjI3NmU1M2M0NTY4YTA4NGVmNWFkOTM5MjZmOCIsInVzZXJfaWQiOiIzIn0.5cYJ1g4Fqqu8YiFZjGdgtE6J_qf6VB_2SGRj11IWbG0','2025-12-19 09:38:23.253597','2025-12-26 09:38:23.000000',3,'5d656276e53c4568a084ef5ad93926f8');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES (1,'pbkdf2_sha256$1000000$S93A296j5GP9NHx2MZSOz7$zoNGRapeWU7FtdH3g7rKWxXAzCSR8cnr6N5zlpayr8Y=','2025-11-17 08:21:12.048650',1,'hieu20050008','','',1,1,'2025-11-17 08:20:42.390479','20050008@student.bdu.edu.vn','student',NULL),(2,'pbkdf2_sha256$1000000$N59sLt3TMZNf5ezJZQ1y3j$hAKqem7NTmq5MuNR3kGWc5UPvkyKLVkugHKM87JRMgg=',NULL,0,'thau7681@gmail.com','','',0,1,'2025-11-17 08:26:56.021852','thau7681@gmail.com','student',NULL),(3,'pbkdf2_sha256$1000000$j5muZKQ5qBRkqPXC7hTxdp$6+zFXroOKk1GGaIE1J37PIG/qVLwB2fnNdAH7ehY3Nw=',NULL,0,'hieu0394439418@gmail.com','','',0,1,'2025-11-17 08:37:13.457699','hieu0394439418@gmail.com','teacher',NULL);
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_groups`
--

DROP TABLE IF EXISTS `users_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  KEY `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_groups`
--

LOCK TABLES `users_user_groups` WRITE;
/*!40000 ALTER TABLE `users_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_user_permissions`
--

DROP TABLE IF EXISTS `users_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  KEY `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_user_permissions`
--

LOCK TABLES `users_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-20 15:22:15
