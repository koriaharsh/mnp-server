-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: mnp1332
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address1` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  `country` varchar(30) NOT NULL,
  `postalcode` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset`
--

DROP TABLE IF EXISTS `password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reset_token` varchar(100) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `token_creation_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
INSERT INTO `password_reset` VALUES (1,'64cb48f73332c16e7b0df747fabce55113cba90e947b6312936c81177921b9c9',0,'2023-01-16 19:44:16'),(2,'81afc847eba11bb103644a7e62f5f175ab3de00655f07817ee29367167a83bd3',1,'2023-01-16 19:50:32'),(3,'a52f1946c1cb95da8cf9dc539bccdd3f6ddba9990e282396a0539c4317d9e496',0,'2023-01-17 05:29:05'),(4,'8bdc81ab03f96c84f2e4e8763be1f3836b6558b98227dc3f44a5a458099de2f3',1,'2023-01-17 05:37:26'),(5,'7f7b88d9581a429e75c074abc192106601e3e8493661a74fa0a4f87328870b55',1,'2023-01-17 05:42:13'),(6,'7763e146ae6a4a600277c03fd6a45befbdd454989dc8d84d68da8935c7d790fa',1,'2023-01-17 05:43:38'),(7,'79ee2339e86395610b83f021ca6f7397ba17ab99d9f8727716dc451f3a8586a1',0,'2023-01-18 06:46:53'),(8,'cbe14a81296100ee5f16708ce131fc584f7e4b23c8209f2f0b1d02e6baffa196',0,'2023-01-18 06:49:21'),(9,'c4c061b948d7ef9e3b336acf624eba61a9c8104fae63191460a2d9f2e54dd4b8',0,'2023-01-18 06:50:32'),(10,'8ad9252e669db26943c9f0099129b33b3e4065bd5ee621968f63fb0815abde96',0,'2023-01-18 12:19:36'),(11,'3116b00e673668a88a71ceb70ec62e2ae23e8e9c3009fb2371f93a6b606a2798',0,'2023-01-18 12:27:07'),(12,'7ce3752a6bacf987af71ed1e1ee3021151f5cb386b33075941175b65fcb3048a',0,'2023-01-18 12:28:15'),(13,'3e9ac7ebdc0f193083d5a5a5abea459980ff44f5c2c6e8f8a72cca229dbe91a3',0,'2023-01-18 12:31:05'),(14,'f77cda894ee0158e6f2f26c831627d70c91b549d18b8013fb8e2157d3b1ef148',0,'2023-01-18 12:37:02'),(15,'6c3e6fd66abb279948caeda1e778b7e13d7ddf6b367665746a9de420f1a27016',0,'2023-01-18 12:44:10'),(16,'b640d14a1037066a8efa159d0c6d5fb00d61c56f1c7559092f099be3ce55c5e7',0,'2023-01-18 12:51:37'),(17,'614b0f6bc412c96a57b6202c3d1b2e712e004f057ca4a66fc3ff99fb321bf55c',0,'2023-01-18 12:53:58'),(18,'3bdca337f35e93722e7461335db923c9f32161688d800651d84bca06737869d6',0,'2023-01-18 12:57:07'),(19,'57ddf9e9ac48aa43c6343bee9d1c1cc7d00e7d9203e35b1d2896506cd363c43a',0,'2023-01-18 13:00:44'),(20,'a3868f48ccbb15aa76b20487d385aca88da1846dd665098577f3d0e3b3f44b16',0,'2023-01-18 13:02:11'),(21,'bf56aa40383670b71ef1ccc938d84a5bad77faf56bbbdedf8954c0701b28fc04',0,'2023-01-19 04:47:53'),(22,'3e2bc0be7bfe82e92a8731a4567e574adf81866ad963f000fee99de35ab64170',0,'2023-01-19 04:49:54'),(23,'abd492746959e2e45407838b20b1eb8ca192479e6369298dbac2bf7db6607e5b',0,'2023-01-19 05:03:17'),(24,'ce0ba9bae98adce97c1facbf6eeebc348df2d0e3f3571f503d2c9bb9ebe4c3e0',0,'2023-01-19 05:12:04'),(25,'83b05a56d9fd5208a91ef617fd847237e5b7c5ca870757765a7c1733d1f26ece',0,'2023-01-19 05:15:21'),(26,'9f4a77b97d6434e07789dd48a1b9b3d1255a15730166e924f61cbed34576dc71',0,'2023-01-19 05:27:01'),(27,'a8fcd2031a1e97e0ae0b672044dfea82273024576e247fe46a361613972b0262',0,'2023-01-19 05:30:41'),(28,'06cb39cbec47867bb04b03d961c6c5f85b4cfb19a9f12f055f8f75527643f02c',0,'2023-01-19 05:33:24');
/*!40000 ALTER TABLE `password_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_log` (
  `id` int NOT NULL,
  `loginDateTime` timestamp NOT NULL,
  `time_spent_in_seconds` float NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (4,'ADMIN'),(5,'INVIGILATOR'),(6,'USER');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `hashed_password` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `role_id` int NOT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `gender` varchar(15) NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `id` (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (91,'harshkoria@gmail.com','harsh','Harsh Koria','$2b$12$Qw1EYtW1T7bl.0vOiWGqi.fMqpudgy5uWxR6fz915t/TABJsTM1KC',1,5,'8209066019','MALE',26),(93,'piyushkirode07@gmail.com','piyush','Piyush Kirode','$2b$12$CCUk06yPXIW5AMHlXqsFm.r/EFL6WL9Z6QeA2BLO/jgmr5wBlxLkG',1,5,'','10',26),(94,'shubham@cdac.in','shubhammic','Shubham','$2b$12$a3YX8jrABoWOmXIQdK0WCuxgRKlgAVSCFmNJN3JsSBDtrah3Td0GK',1,6,'','10',28),(95,'saumyak@cdac.in','saumya','Saumya Kushwaha','$2b$12$ZqonVpW5HVR8zO1g35iP7OcadFfNevY4rNWgpeebtnuXM55mHi0r6',1,5,'','20',29);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_password`
--

DROP TABLE IF EXISTS `users_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_password` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USER_ID` int DEFAULT NULL,
  `HASHED_PASSWORD` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `USER_ID` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_password`
--

LOCK TABLES `users_password` WRITE;
/*!40000 ALTER TABLE `users_password` DISABLE KEYS */;
INSERT INTO `users_password` VALUES (1,1,'$2b$12$dev.77lDUB0VPAUd8rLxh..tSqdRBkXObSmIUIlyif/iTi1j1X6IO'),(2,2,'$2b$12$r7RVBUf9J1FBmVj.DM2rbeLFF7u0SiV49g/989yBYrfpaVP/Ovl.K'),(3,3,'$2b$12$EjvrL99.rH2jdPylcJJTkeCY18CRaNqGBnEi.zJWXFFpZZ4aj8uXO'),(4,4,'$2b$12$ui4WTwgoUMxioXemX8YTJ.E1K8.Ab6snBCrrbvlBv3/ka9kSPVGBm'),(5,5,'$2b$12$4UGoMOFeLtZKgD09Xdlws.wvXOTHdGrP3MjJH.7T9O2oCJwttLJlS'),(6,6,'$2b$12$ZCk5hDi.fq1oe3hmrgdLq.FYkMscxtA2gScWgqiOh9rzWvqumEiim'),(7,7,'$2b$12$ZZ7kgc3Q7JCYWX/eoYPxI.lMTmymaEnqmTWHVa9uDHVIMMU5HIdSu'),(8,8,'$2b$12$YZfXvzHEbiZpgF2EI06ereMjl5Hwql4OYRhAqMa26IBthISef9i1i'),(9,9,'$2b$12$TZSW8lBKmGzKOajBXdVWlu7K3mIKKc10hiRH9NOxnMwoP8Bml0mEW'),(10,10,'$2b$12$HcsMocLjIj2lxbNVlxl.H.KeNf4lLGxsznTdHnGEHuunhGoSFt.oq'),(11,11,'$2b$12$vvCiu8mG.49RGjRJ5VDVWe2U9upsxVIKoCnhLwrvf.GDh6GrroZgq'),(12,12,'$2b$12$1Y4ovCHtCTEPwoT8f4.TLuNLWAGG9Zn8sEyC7Zg1uuBT74qWYa.QO'),(13,13,'$2b$12$0yshmRH//o5mW9ixRt8SVe8T0lTLcu7O7rE01s/4CR.zc6qRFRwoK'),(14,14,'$2b$12$CFmyy8yWcDOkYCSzwYzPjem1q9deBITXjRUnme2uzZ97CsPWfcbE2'),(15,15,'$2b$12$PlWXU3B1DXr0jnfq/dCA2.l/6Tx5Ixsuva0.gwV/Lu06Qy5.txuS6'),(16,16,'$2b$12$t7sGuqq2XUzshOB2y4s28uUbG4hne8t2vyq4Q8hq3sr9TfKEdjyE6'),(17,17,'$2b$12$n6C/qxdBepxPy7qcSP8Mc.2trOMUOdNGRqXiPj4mG.lSP0Qte.MvK'),(18,18,'$2b$12$la.i7PqazgjVTXW.FPBIteMUnvb4UHC6U5HpjhZbRgXq2bXmZ5KGu'),(19,19,'$2b$12$WxEGTmr2bCDqwGbziFBYCu/vnoDvuHVh7gjN/J4k7Z20K1VXDYmTS'),(20,20,'$2b$12$U8Mc3nN9TY7UCcGHbCnA9ufJ88cwhF1C9jRXQ6Yi.C43GvEGG.5RC'),(21,21,'$2b$12$U7uAwjPG9FLVTPULz13bKu6g94nM5qnuN0tMiCNTX.XbNGW13Hjsy'),(22,22,'$2b$12$6qu5Hr.YLfW6crelk6uauuCNJEFRP5f1LhjwW0Ku/TZyPVlADF9/2'),(23,23,'$2b$12$H4IBcUesCkULD2VUW8mKtOZpxDtiPEbgzvU3PX9u9FHrJ0GbUWwNi'),(24,24,'$2b$12$IhHG1ivW5DH7Qx7CvsgwpOk5sF3Wts9cgGpqnf8WxksXWkwsOIejm'),(25,25,'$2b$12$Pt3KujNOTopQCqKEIhzIR.mEPzc6hxMpT1jmxXrkQhq1vjHKkzXQW'),(26,26,'$2b$12$bsUjAiSYzcgwzGz3zivRJubtqB/3C1Wd0I3Ag4HaJmchPglBkKNvC'),(27,27,'$2b$12$NqqXk2cM/zYZT/WY.xa2g.K8F6pnlIn84mkDDrlop6WEDg1HmlaHS'),(28,28,'$2b$12$ygr/Y0XCPk0RjzfpX0O2AOy0tAhtPOUNcWhjczA6cK7I6mj0tLBRW'),(29,29,'$2b$12$zTVTruD8U7kMTtWy76EIKusUWxZvWES481YO/n3jToTJ3PuUwA8gq'),(30,30,'$2b$12$tM4GXQZ08k2rCHGIqbPJIuv14V85m7FIWJbbrOqZGDdAGEXISVYIS'),(31,31,'$2b$12$caY6rvxhfu7duTBvLTij3.HmGwoYkqVsBPawdLeaHuhK37ANdwn7S'),(32,32,'$2b$12$HSIPasuAHvBleq7FltPaZedqGb29nqO0zxuBHz2UQz8.30qUBENLC'),(33,33,'$2b$12$/nXQVbrL52LNsJdLjRp3reKHtWY/3hIqNwBUqtdppurK9kKSm/AHu'),(34,34,'$2b$12$8.GtEGMcgLtcY8WEKFU3iOtCkTTE0XTVPD6YLVognHIKaWZ6m2zvW'),(35,35,'$2b$12$9wddFCtTyS1zjxXBtTUF/OJC5HM7pIyHPQ2SUQM0Q32ap5BJncoNa'),(36,36,'$2b$12$l.W/rSuyny/1/Wj08J6rqO9I9mDpE37ILpXV83WxTFzb9Nxb88Bsu'),(37,37,'$2b$12$SbZq6Y.GhZHVFmVnViksWO3JfgMU0Baqj48y/j6Tj05QqDwWlciQS'),(38,38,'$2b$12$nAz0ZqwzmtpKCyTpFTEfEeoumz6uQofr4xVXqGRtCkVV8eh9khjsK'),(39,39,'$2b$12$DW4M4TuWIBio/smfuI2nb.U.zO5loTwqIVOVOKOM2t/IBJatV796a'),(40,40,'$2b$12$tjk.UjIkTG4SoXysIPNrz.QHlc9PlaH8gMdRE6HZ5.8YRdE.LniKe'),(41,41,'$2b$12$9iJ7ygY3r1C4IIKawFm2DeUPOxBDhNDI124pRv42ReqzSICOGLWKy'),(42,42,'$2b$12$gVrDLac4UQi1r1RrWsZILu/o2RQxwjNCYaoQ.C0NBrg7qNuEpa9MK'),(43,43,'$2b$12$pzvz5LBsLUZaj/RmaQv/few7ZAKbmbENpg9tPUkcdD1yKkPxoOcMy'),(44,44,'$2b$12$z1XTH1IxITcelTR3W.haMOmbctm.IcHUkLvQbTT749IF3j0C.bwJ2'),(45,45,'$2b$12$BLLCIb6sirKGKxgeVO/G0.lOD3lEld8rrPPg5r1ezJjd.FZqc/8OC'),(46,46,'$2b$12$PZrfcb3sobrUS0cccLwLg.JJ73vgIM/4xTe4jWaV/G6lu68kX6Ame'),(47,47,'$2b$12$gGb6yzV2G0Qo4TRgpTMRmePbY9CeLT7KDhuyki1B64bQk5MN/oBom'),(48,48,'$2b$12$T4QjP1WD0f.mfIGkmXMEFOZGXIusg7aqJwGhZbg0hzl3.YhenG.2q'),(49,49,'$2b$12$UR23hfa.aFYAnP0cOvZc8eE.Dxt0pv6oCvE7x4NdP48FORmvPBYUy'),(50,50,'$2b$12$wVcYiVnmD8PvSSRxcY6gB.W70ahQ34vm7KhegtL0muFkE.HwPHQoW'),(51,51,'$2b$12$an4jFy6zkNxLDd9teLZ7r.r538qAcxxY5G4cFGFUa5LIbjKJGRuau'),(52,52,'$2b$12$Z1kDi/Zb9xo1IIz.UBGId.COjE35vje1kEIlqUIJM/IkA0kqJXzGi'),(53,53,'$2b$12$0ijSlFX9dOlj9hEO0fv/EOPKa/koO3I0smw/4YkaK.JTnLlM8SAti'),(54,54,'$2b$12$MZDA3iDQsA0hOn/UYkYjMeQd7jkJmEucgEIhab.iVnIIIwF61qDiG'),(55,55,'$2b$12$xO6X/wuF6FWA.sASH3HoGOnjf6DHGW60IEbJ3ranN0s43h2bYd78a'),(56,56,'$2b$12$.WSneHKqMwPbUiA1DNBd5OjcrE95hjjeymoqItfpGltXf3YD1FAC2'),(57,57,'$2b$12$pUeDT.9A/ffgdT3uWq.SiufrKeWAUSDoo8Z5.WAdd6syUpwDq6KK2');
/*!40000 ALTER TABLE `users_password` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-10 10:43:22
