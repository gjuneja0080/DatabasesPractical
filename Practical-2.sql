-- MySQL dump 10.16  Distrib 10.2.19-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: gj25_dbPrac
-- ------------------------------------------------------
-- Server version	10.2.19-MariaDB

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
-- Table structure for table `audiobook`
--

DROP TABLE IF EXISTS `audiobook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook` (
  `ISBN` varchar(30) COLLATE utf8_bin NOT NULL,
  `title` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `narrator_id` int(10) DEFAULT NULL,
  `running_time` time DEFAULT NULL,
  `age_rating` int(11) DEFAULT NULL,
  `purchase_price` decimal(8,2) DEFAULT NULL,
  `publisher_name` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `published_date` date DEFAULT NULL,
  `audiofile` blob DEFAULT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook`
--

LOCK TABLES `audiobook` WRITE;
/*!40000 ALTER TABLE `audiobook` DISABLE KEYS */;
INSERT INTO `audiobook` VALUES ('860-1404211171','Fantastic Beasts and Where to Find Them',12,'01:45:00',NULL,12.00,'Pottermore Publishing','2017-03-14',NULL),('978-0099457046','Moab Is My Washpot',12,'11:33:00',12,22.00,'Random House Audiobooks','2017-01-01',NULL),('978-0393957242','Gulliver\'s Travels',13,'05:35:00',NULL,38.00,'Penguin Books Ltd','2012-05-12',NULL),('978-1408855652','Harry Potter and the Philosopher\'s Stone',12,'08:44:00',NULL,7.19,'Pottermore Publishing','2014-09-01',NULL),('978-1611749731','The Gun Seller',16,'10:45:00',16,16.00,'Highbridge Audio','2012-10-16',NULL);
/*!40000 ALTER TABLE `audiobook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audiobook_authors`
--

DROP TABLE IF EXISTS `audiobook_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_authors` (
  `contributor_ID` int(11) NOT NULL,
  `ISBN` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`contributor_ID`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `audiobook_authors_ibfk_1` FOREIGN KEY (`contributor_ID`) REFERENCES `contributor` (`person_ID`),
  CONSTRAINT `audiobook_authors_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook_authors`
--

LOCK TABLES `audiobook_authors` WRITE;
/*!40000 ALTER TABLE `audiobook_authors` DISABLE KEYS */;
INSERT INTO `audiobook_authors` VALUES (12,'978-0099457046'),(13,'978-0393957242'),(15,'978-1611749731'),(16,'860-1404211171'),(16,'978-1408855652'),(17,'860-1404211171');
/*!40000 ALTER TABLE `audiobook_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audiobook_purchases`
--

DROP TABLE IF EXISTS `audiobook_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_purchases` (
  `customer_ID` int(11) NOT NULL,
  `ISBN` varchar(30) COLLATE utf8_bin NOT NULL,
  `purchase_date` datetime DEFAULT NULL,
  PRIMARY KEY (`customer_ID`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `audiobook_purchases_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`person_ID`),
  CONSTRAINT `audiobook_purchases_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook_purchases`
--

LOCK TABLES `audiobook_purchases` WRITE;
/*!40000 ALTER TABLE `audiobook_purchases` DISABLE KEYS */;
INSERT INTO `audiobook_purchases` VALUES (12,'978-0099457046','2018-10-23 21:34:02'),(12,'978-1408855652','2018-10-23 21:29:48'),(13,'978-0393957242','2018-10-23 21:30:10'),(14,'978-0393957242','2018-10-23 21:35:54'),(16,'978-0393957242','2018-10-23 21:30:34'),(16,'978-1408855652','2018-10-23 21:31:08'),(18,'978-1611749731','2018-10-23 21:30:47');
/*!40000 ALTER TABLE `audiobook_purchases` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`gj25`@`%`*/ /*!50003 trigger `verify_age` before insert on `audiobook_purchases` for each row
BEGIN
DECLARE age INT;
DECLARE ageRating INT;
set age := (SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) from person where person.ID = new.customer_ID);
set ageRating := (SELECT age_rating from audiobook where audiobook.ISBN = new.ISBN);
if(age < ageRating) THEN
SIGNAL sqlstate '45001' set message_text = "Too young to purchase the book";
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `audiobook_reviews`
--

DROP TABLE IF EXISTS `audiobook_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_reviews` (
  `customer_ID` int(11) NOT NULL,
  `ISBN` varchar(30) COLLATE utf8_bin NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `title` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `comment` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`customer_ID`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `audiobook_reviews_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`person_ID`),
  CONSTRAINT `audiobook_reviews_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook_reviews`
--

LOCK TABLES `audiobook_reviews` WRITE;
/*!40000 ALTER TABLE `audiobook_reviews` DISABLE KEYS */;
INSERT INTO `audiobook_reviews` VALUES (10,'860-1404211171',4,'Fantastic Book','Fantastic Book - Loved listening to this book before bed.',1),(16,'978-1408855652',5,'Best audio book EVER!','Best audio book I ever listened to. Stephen Fry does an excellent job reading the superb prose written by a genius author.',1),(19,'860-1404211171',2,'Not as good as Harry Potter','Not as good as Harry Potter - Never read the book, seen the movie or listened to the audio book but I can tell you right now - its not as good as harry potter',0);
/*!40000 ALTER TABLE `audiobook_reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`gj25`@`%`*/ /*!50003 trigger `check_audiobook_ratings` before insert on `audiobook_reviews` for each row
begin
DECLARE personid INT;
set personid := (Select audiobook_purchases.customer_ID 
from audiobook_purchases 
where audiobook_purchases.customer_ID = new.customer_ID AND audiobook_purchases.ISBN = new.ISBN);
if new.rating not in ('1', '2', '3', '4','5') then
SIGNAL sqlstate '45001' set message_text = "invalid rating";
end if;
IF(personid is not null) then
set new.verified = 1; 
end IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `chapter`
--

DROP TABLE IF EXISTS `chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chapter` (
  `ISBN` varchar(20) COLLATE utf8_bin NOT NULL,
  `number` int(11) NOT NULL,
  `title` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `start` time DEFAULT NULL,
  PRIMARY KEY (`ISBN`,`number`),
  CONSTRAINT `chapter_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapter`
--

LOCK TABLES `chapter` WRITE;
/*!40000 ALTER TABLE `chapter` DISABLE KEYS */;
INSERT INTO `chapter` VALUES ('978-0393957242',1,'Part I: A Voyage to Lilliput','00:00:00'),('978-0393957242',2,'Part II: A Voyage to Brobdingnag','01:40:07'),('978-0393957242',3,'Part III: A Voyage to Laputa, Balnibarbi, Luggnagg, Glubbdubdrib and Japan','03:01:09'),('978-0393957242',4,'Part IV: A Voyage to the Land of the Houyhnhnms','04:22:05'),('978-1408855652',1,'The Boy Who Lived','00:00:00'),('978-1408855652',2,'The Vanishing Glass','00:35:03'),('978-1408855652',3,'The Letters from No One','01:07:27'),('978-1408855652',4,'The Keeper of Keys','01:38:01'),('978-1408855652',5,'Diagon Alley','02:08:25'),('978-1408855652',6,'The Journey from Platform Nine and Three-Quarters','02:38:50'),('978-1408855652',7,'The Sorting Hat','03:09:43'),('978-1408855652',8,'The Potions Master','03:40:03'),('978-1408855652',9,'The Midnight Due','04:10:27'),('978-1408855652',10,'Hallowe\'en','04:40:48'),('978-1408855652',11,'Quidditch','05:11:06'),('978-1408855652',12,'The Mirror of Erised','05:32:38'),('978-1408855652',13,'Nicholas Flamel','06:11:56'),('978-1408855652',14,'Norbert the Norwegian Ridgeback','06:52:20'),('978-1408855652',15,'The Forbidden Forest','07:12:43'),('978-1408855652',16,'Through the Trapdoor','07:43:05'),('978-1408855652',17,'The Man with Two Faces','08:15:30');
/*!40000 ALTER TABLE `chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contributor`
--

DROP TABLE IF EXISTS `contributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contributor` (
  `person_ID` int(10) NOT NULL,
  `biography` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`person_ID`),
  CONSTRAINT `contributor_ibfk_1` FOREIGN KEY (`person_ID`) REFERENCES `person` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contributor`
--

LOCK TABLES `contributor` WRITE;
/*!40000 ALTER TABLE `contributor` DISABLE KEYS */;
INSERT INTO `contributor` VALUES (12,'An English comedian, actor, writer, presenter, and activist.'),(13,'An English actor, musician, comedian, and writer.'),(15,'An English actor and narrator. Initially a stage actor, he has a wide-ranging career in television drama, was a game show announcer in Britain, and a voice-over narrator for television, and film. In recent years he has narrated a large number of audio books and received an Audie (Audio book Oscar) in 2010.'),(16,'After finishing the first book and whilst training as a teacher, Harry Potter was accepted for publication by Bloomsbury. Harry Potter and the PhilosopherΓÇÖs Stone quickly became a bestseller on publication in 1997. As the book was translated into other languages, Harry Potter started spreading round the globe ΓÇô and J.K. Rowling was soon receiving thousands of letters from fans.'),(17,'Famed expert in the field of Magizoology.'),(20,'Irish author, clergyman and satirist Jonathan Swift received a bachelor\'s degree from Trinity College and then worked as a statesman\'s assistant. Eventually, he became dean of St. Patrick\'s Cathedral in Dublin.');
/*!40000 ALTER TABLE `contributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `person_ID` int(10) NOT NULL,
  `email_address` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`person_ID`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`person_ID`) REFERENCES `person` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (10,'bob_jnr@bobson.com'),(11,'bob_snr@bobson.com'),(12,'sfry@email.com'),(13,'hugh@laurie.com'),(14,'ruth@letham.com'),(15,NULL),(16,'jk@rowling.com'),(17,NULL),(18,'pippa.smith@email.com'),(19,'jon@spellbad.com'),(20,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `ID` int(20) NOT NULL,
  `forename` char(10) COLLATE utf8_bin DEFAULT NULL,
  `middle_initials` char(10) COLLATE utf8_bin DEFAULT NULL,
  `surname` char(10) COLLATE utf8_bin DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (10,'Bob','B A','Bobson','2009-12-31'),(11,'Bob','A B','Bobson','1978-10-23'),(12,'Stephen',NULL,'Fry','1957-08-24'),(13,'Hugh',NULL,'Laurie','1959-06-10'),(14,'Ruth',NULL,'Letham','1978-11-23'),(15,'Simon',NULL,'Prebble','1942-02-13'),(16,'JK',NULL,'Rowling','1965-07-31'),(17,'Newton','A F','Scamander','1897-02-24'),(18,'Pippa','A','Smith','2005-01-01'),(19,'Jon','Q','Spellbad','2007-01-01'),(20,'Jonathan',NULL,'Swift','1667-11-30');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_number`
--

DROP TABLE IF EXISTS `phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_number` (
  `customer_ID` int(11) NOT NULL,
  `phone_number` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`customer_ID`,`phone_number`),
  CONSTRAINT `phone_number_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`person_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_number`
--

LOCK TABLES `phone_number` WRITE;
/*!40000 ALTER TABLE `phone_number` DISABLE KEYS */;
INSERT INTO `phone_number` VALUES (10,''),(11,''),(12,''),(13,''),(14,'02222 111 333'),(15,''),(16,''),(17,''),(18,'01111 222 333'),(18,'07777 222 333'),(19,''),(20,'');
/*!40000 ALTER TABLE `phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher` (
  `name` varchar(30) COLLATE utf8_bin NOT NULL,
  `building` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `street` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `country` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `postcode` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `phone_number` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `established_date` date DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES ('HighBridge Audio','270','Skipjack Road','Prince Frederick','USA','MD 20678','1-800-755-8532','1901-01-01'),('Penguin Books Ltd','80','Strand','London','UK','WC2R 0RL','861590','1981-01-01'),('Pottermore Publishing','PO Box 7828',NULL,'London','UK','W1A 4GE','12345','2011-07-31'),('Random House AudioBooks','20','Vauxhall Bridge Road','London','UK','SW1V2SA','+4402078408400','1928-09-01');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `q1`
--

DROP TABLE IF EXISTS `q1`;
/*!50001 DROP VIEW IF EXISTS `q1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `q1` (
  `person_ID` tinyint NOT NULL,
  `fullname` tinyint NOT NULL,
  `email_address` tinyint NOT NULL,
  `total_books_purchased` tinyint NOT NULL,
  `total_money_spent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `q2`
--

DROP TABLE IF EXISTS `q2`;
/*!50001 DROP VIEW IF EXISTS `q2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `q2` (
  `ISBN` tinyint NOT NULL,
  `title` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `q3`
--

DROP TABLE IF EXISTS `q3`;
/*!50001 DROP VIEW IF EXISTS `q3`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `q3` (
  `customer_ID` tinyint NOT NULL,
  `Fullname` tinyint NOT NULL,
  `Books_contributed_to_and_bought` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'gj25_dbPrac'
--
/*!50003 DROP PROCEDURE IF EXISTS `insertContributor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`gj25`@`%` PROCEDURE `insertContributor`(in person_ID INT(20), in biography VARCHAR(1000), in forename char(10), in middle_initials char(10), in surname char(10), in date_of_birth DATE)
BEGIN
 Insert INTO person VALUES(person_ID, forename, middle_initials,surname, date_of_birth);
 INSERT INTO contributor VALUES(person_ID, biography);
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`gj25`@`%` PROCEDURE `insertCustomer`(in person_ID INT(20), in email_address VARCHAR(30), in forename char(10), in middle_initials char(10), in surname char(10), in date_of_birth DATE)
BEGIN
 DECLARE sqlquery VARCHAR(30);
 if(email_address NOT like '%__@__%') THEN
 SIGNAL sqlstate '45001' set message_text = "wrong format for email_address";
 else
 Insert INTO person VALUES(person_ID, forename, middle_initials,surname, date_of_birth);
 INSERT INTO customer VALUES(person_ID, email_address);
 
 end if;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `q1`
--

/*!50001 DROP TABLE IF EXISTS `q1`*/;
/*!50001 DROP VIEW IF EXISTS `q1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`gj25`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `q1` AS select `customer`.`person_ID` AS `person_ID`,ifnull(concat(`person`.`forename`,' ',`person`.`middle_initials`,' ',`person`.`surname`),concat(`person`.`forename`,' ',`person`.`surname`)) AS `fullname`,`customer`.`email_address` AS `email_address`,count(`audiobook_purchases`.`purchase_date`) AS `total_books_purchased`,coalesce(sum(`audiobook`.`purchase_price`),'0.00') AS `total_money_spent` from (((`person` join `customer` on(`person`.`ID` = `customer`.`person_ID`)) left join `audiobook_purchases` on(`person`.`ID` = `audiobook_purchases`.`customer_ID`)) left join `audiobook` on(`audiobook_purchases`.`ISBN` = `audiobook`.`ISBN`)) group by `person`.`ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `q2`
--

/*!50001 DROP TABLE IF EXISTS `q2`*/;
/*!50001 DROP VIEW IF EXISTS `q2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`gj25`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `q2` AS select `audiobook`.`ISBN` AS `ISBN`,`audiobook`.`title` AS `title` from (`audiobook` left join `audiobook_purchases` on(`audiobook_purchases`.`ISBN` = `audiobook`.`ISBN`)) where `audiobook_purchases`.`ISBN` is null order by `audiobook`.`title` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `q3`
--

/*!50001 DROP TABLE IF EXISTS `q3`*/;
/*!50001 DROP VIEW IF EXISTS `q3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`gj25`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `q3` AS select `audiobook_purchases`.`customer_ID` AS `customer_ID`,ifnull(concat(`person`.`forename`,' ',`person`.`middle_initials`,' ',`person`.`surname`),concat(`person`.`forename`,' ',`person`.`surname`)) AS `Fullname`,group_concat(`audiobook`.`title` order by `audiobook`.`title` ASC separator ',') AS `Books_contributed_to_and_bought` from (((`audiobook_purchases` left join `audiobook_authors` on(`audiobook_purchases`.`customer_ID` = `audiobook_authors`.`contributor_ID` and `audiobook_purchases`.`ISBN` = `audiobook_authors`.`ISBN`)) join `audiobook` on(`audiobook_purchases`.`ISBN` = `audiobook`.`ISBN` and `audiobook_purchases`.`customer_ID` = `audiobook`.`narrator_id` or `audiobook`.`ISBN` = `audiobook_authors`.`ISBN`)) join `person` on(`audiobook_purchases`.`customer_ID` = `person`.`ID`)) group by `audiobook_purchases`.`customer_ID` order by `audiobook_purchases`.`customer_ID` */;
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

-- Dump completed on 2018-11-27 16:30:41
