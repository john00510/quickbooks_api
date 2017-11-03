-- MySQL dump 10.13  Distrib 5.5.58, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: quickbooks
-- ------------------------------------------------------
-- Server version	5.5.58-0ubuntu0.14.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add scopes',1,'add_scopes'),(2,'Can change scopes',1,'change_scopes'),(3,'Can delete scopes',1,'delete_scopes'),(4,'Can add tokens',2,'add_tokens'),(5,'Can change tokens',2,'change_tokens'),(6,'Can delete tokens',2,'delete_tokens'),(7,'Can add urls',3,'add_urls'),(8,'Can change urls',3,'change_urls'),(9,'Can delete urls',3,'delete_urls'),(10,'Can add credentials',4,'add_credentials'),(11,'Can change credentials',4,'change_credentials'),(12,'Can delete credentials',4,'delete_credentials'),(13,'Can add log entry',5,'add_logentry'),(14,'Can change log entry',5,'change_logentry'),(15,'Can delete log entry',5,'delete_logentry'),(16,'Can add permission',6,'add_permission'),(17,'Can change permission',6,'change_permission'),(18,'Can delete permission',6,'delete_permission'),(19,'Can add user',7,'add_user'),(20,'Can change user',7,'change_user'),(21,'Can delete user',7,'delete_user'),(22,'Can add group',8,'add_group'),(23,'Can change group',8,'change_group'),(24,'Can delete group',8,'delete_group'),(25,'Can add content type',9,'add_contenttype'),(26,'Can change content type',9,'change_contenttype'),(27,'Can delete content type',9,'delete_contenttype'),(28,'Can add session',10,'add_session'),(29,'Can change session',10,'change_session'),(30,'Can delete session',10,'delete_session'),(31,'Can add secrets',11,'add_secrets'),(32,'Can change secrets',11,'change_secrets'),(33,'Can delete secrets',11,'delete_secrets');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_bin NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8_bin NOT NULL,
  `first_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `last_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `email` varchar(254) COLLATE utf8_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext COLLATE utf8_bin,
  `object_repr` varchar(200) COLLATE utf8_bin NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_bin NOT NULL,
  `model` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (5,'admin','logentry'),(8,'auth','group'),(6,'auth','permission'),(7,'auth','user'),(9,'contenttypes','contenttype'),(4,'quickbooks_api','credentials'),(1,'quickbooks_api','scopes'),(11,'quickbooks_api','secrets'),(2,'quickbooks_api','tokens'),(3,'quickbooks_api','urls'),(10,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-10-28 14:18:01'),(2,'auth','0001_initial','2017-10-28 14:18:05'),(3,'admin','0001_initial','2017-10-28 14:18:06'),(4,'admin','0002_logentry_remove_auto_add','2017-10-28 14:18:06'),(5,'contenttypes','0002_remove_content_type_name','2017-10-28 14:18:07'),(6,'auth','0002_alter_permission_name_max_length','2017-10-28 14:18:07'),(7,'auth','0003_alter_user_email_max_length','2017-10-28 14:18:07'),(8,'auth','0004_alter_user_username_opts','2017-10-28 14:18:07'),(9,'auth','0005_alter_user_last_login_null','2017-10-28 14:18:08'),(10,'auth','0006_require_contenttypes_0002','2017-10-28 14:18:08'),(11,'auth','0007_alter_validators_add_error_messages','2017-10-28 14:18:08'),(12,'auth','0008_alter_user_username_max_length','2017-10-28 14:18:08'),(15,'sessions','0001_initial','2017-10-28 14:18:09'),(16,'quickbooks_api','0001_initial','2017-10-31 15:13:24'),(17,'quickbooks_api','0002_delete_credentials','2017-10-31 15:13:24');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_bin NOT NULL,
  `session_data` longtext COLLATE utf8_bin NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quickbooks_api_credentials`
--

DROP TABLE IF EXISTS `quickbooks_api_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quickbooks_api_credentials` (
  `user_id` varchar(200) COLLATE utf8_bin NOT NULL,
  `password` varchar(200) COLLATE utf8_bin NOT NULL,
  `client_id` varchar(200) COLLATE utf8_bin NOT NULL,
  `client_secret` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quickbooks_api_credentials`
--

LOCK TABLES `quickbooks_api_credentials` WRITE;
/*!40000 ALTER TABLE `quickbooks_api_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `quickbooks_api_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quickbooks_api_scopes`
--

DROP TABLE IF EXISTS `quickbooks_api_scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quickbooks_api_scopes` (
  `name` varchar(200) COLLATE utf8_bin NOT NULL,
  `value` varchar(200) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quickbooks_api_scopes`
--

LOCK TABLES `quickbooks_api_scopes` WRITE;
/*!40000 ALTER TABLE `quickbooks_api_scopes` DISABLE KEYS */;
INSERT INTO `quickbooks_api_scopes` VALUES ('accounting','com.intuit.quickbooks.accounting'),('payment','com.intuit.quickbooks.payment');
/*!40000 ALTER TABLE `quickbooks_api_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quickbooks_api_secrets`
--

DROP TABLE IF EXISTS `quickbooks_api_secrets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quickbooks_api_secrets` (
  `name` varchar(200) COLLATE utf8_bin NOT NULL,
  `client_id` longtext COLLATE utf8_bin NOT NULL,
  `client_secret` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quickbooks_api_secrets`
--

LOCK TABLES `quickbooks_api_secrets` WRITE;
/*!40000 ALTER TABLE `quickbooks_api_secrets` DISABLE KEYS */;
INSERT INTO `quickbooks_api_secrets` VALUES ('development','Q0ioTPK5LH1m7JfKA38aYbQqmUt0ihePDiBkQs9JKSjybeXUhI','Hyh5xX4Qbew6kK6PFSDcgEuLA2k0M2TdACb8oFIu'),('production','Q01VTsXWB6VaSdfBPLpzgXbwVkmvm2Rx9mzleuyJafCD4zHiep','3X9r4FzThZSsJ6Cn3RbSiXwWm2SJHnYWOYk9Khl4');
/*!40000 ALTER TABLE `quickbooks_api_secrets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quickbooks_api_tokens`
--

DROP TABLE IF EXISTS `quickbooks_api_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quickbooks_api_tokens` (
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `access_token` text COLLATE utf8_bin,
  `refresh_token` text COLLATE utf8_bin,
  `realm_id` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quickbooks_api_tokens`
--

LOCK TABLES `quickbooks_api_tokens` WRITE;
/*!40000 ALTER TABLE `quickbooks_api_tokens` DISABLE KEYS */;
INSERT INTO `quickbooks_api_tokens` VALUES ('development','eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..ocSOOB_cIk27MJJTHwKtsg.KP3DlmH47ZO89hn1TVkOWu-YdZOD0EqbiQJb0QaMxZFsVrRJlApPbKrXa79QARwF7qEDXfGu06VSjCtczlsXkWpw9PACn6n99Pmg3Smj6BDBRaf17fOOaRKg3bOOv6M5Gqx5azetLyCoLCd-vAKEZ3aRPbfylKa7Kxg_bthKB_qDrAirRIksfzLjKH_up6O8WzvHUAI46LHxAzsMhs-GrJrF36p9S32lu857lOl5oggQv3UmiwPUBc7HHGmPrwq_eRUlTMNfWBJIWUQBV7JPJ_vd9XjoARsZf2h2oNrXP9G2vteiZ272tcNHrolVbututzErB1-hMwc0gAMa1BTHeDIyvw2seoyM_IAFMjb6iW-V_zDAmztLQMPf8lSo8CULV9J6QycYQICwHg4_h8bgkGbUTlxQbL93UiOTK6oL3_kYamCdYgcFoN4C2qrC04WwKxEaa2y-8J2bN5Q9mIkwFloN6qj-39OTOlHsLNUBas74yjip7UOpZCbTYVU6LVcXFB3qnpfcuLrUFslR_vtO5fUDFsGxiP6vD816Fthfid0vvrCe3WFU61aDolsiOKMzafd09gn4KFYgB8iTXpF68a-C39vWznPtOsP1c8Zq9scMoJmytn81H5R1o_maSRRObU-NunOwFik-5vQAvsWOv-CSJDgEBzRdXuBjmIkSxngFaaFNRD2FljzAcne9VKUx.N6zlP259c7kNhTPBoA0NeQ','Q011518195311E5DWkiuLNpCSj50J834RTwW8JlWqBjo9jKds4','193514653866804');
/*!40000 ALTER TABLE `quickbooks_api_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quickbooks_api_urls`
--

DROP TABLE IF EXISTS `quickbooks_api_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quickbooks_api_urls` (
  `name` varchar(200) COLLATE utf8_bin NOT NULL,
  `value` varchar(200) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quickbooks_api_urls`
--

LOCK TABLES `quickbooks_api_urls` WRITE;
/*!40000 ALTER TABLE `quickbooks_api_urls` DISABLE KEYS */;
INSERT INTO `quickbooks_api_urls` VALUES ('accounting','https://quickbooks.api.intuit.com'),('accountingSandbox','https://sandbox-quickbooks.api.intuit.com'),('authorization','https://appcenter.intuit.com/connect/oauth2'),('bearer','https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'),('payment','https://api.intuit.com'),('paymentSandbox','https://sandbox.api.intuit.com'),('redirect_uri','http://localhost:8000/quickbooks_api/get_code_handler');
/*!40000 ALTER TABLE `quickbooks_api_urls` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-01  5:23:02
