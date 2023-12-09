-- MySQL dump 10.13  Distrib 8.0.34, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: bookstoremanagement
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `Author`
--

DROP TABLE IF EXISTS `Author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Author` (
  `id` varchar(12) NOT NULL,
  `name` text NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Author`
--

LOCK TABLES `Author` WRITE;
INSERT INTO `Author` VALUES ('tgak','Adam Khoo','2023-12-02 01:51:49','2023-12-02 01:51:49',1,NULL),('tgnna','Nguyễn Nhật Ánh','2023-12-02 01:51:49','2023-12-02 01:51:49',1,NULL),('tgvef','Viktor E Frankl','2023-12-02 01:51:49','2023-12-02 01:51:49',1,NULL);
UNLOCK TABLES;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book` (
  `id` varchar(12) NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` text,
  `edition` int NOT NULL,
  `qty` int DEFAULT '0',
  `listedPrice` float NOT NULL,
  `sellPrice` float NOT NULL,
  `publisherId` varchar(12) DEFAULT NULL,
  `authorIds` text NOT NULL,
  `categoryIds` text NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
INSERT INTO `Book` VALUES ('V3iCrODIR','Tôi là Bêtô','Tôi Là Bêtô là tác phẩm của nhà văn chuyên viết cho thanh thiếu niên Nguyễn Nhật Ánh.',1,0,75000,80000,'nxbdk','tgnna','dmtt|dmtruyen',1,'2023-12-09 20:35:03','2023-12-09 20:35:03',NULL);
UNLOCK TABLES;

--
-- Table structure for table `BookChangeHistory`
--

DROP TABLE IF EXISTS `BookChangeHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BookChangeHistory` (
  `id` varchar(12) NOT NULL,
  `bookId` varchar(12) NOT NULL,
  `amount` float NOT NULL,
  `amountLeft` float NOT NULL,
  `type` enum('Sell','Import','Modify') NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookChangeHistory`
--

LOCK TABLES `BookChangeHistory` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
  `id` varchar(12) NOT NULL,
  `name` varchar(50) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
INSERT INTO `Category` VALUES ('dmkns','Kỹ năng sống','2023-12-02 01:52:21','2023-12-02 01:52:21',1,NULL),('dmsgk','Sách giáo khoa','2023-12-02 01:52:21','2023-12-02 01:52:21',1,NULL),('dmtruyen','Truyện','2023-12-02 01:52:21','2023-12-02 01:52:21',1,NULL),('dmtt','Tiểu thuyết','2023-12-02 01:52:21','2023-12-02 01:52:21',1,NULL);
UNLOCK TABLES;

--
-- Table structure for table `Feature`
--

DROP TABLE IF EXISTS `Feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feature` (
  `id` varchar(12) NOT NULL,
  `description` text,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature`
--

LOCK TABLES `Feature` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `ImportNote`
--

DROP TABLE IF EXISTS `ImportNote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ImportNote` (
  `id` varchar(12) NOT NULL,
  `supplierId` varchar(12) NOT NULL,
  `totalPrice` float DEFAULT '0',
  `status` enum('InProgress','Done','Cancel') DEFAULT 'InProgress',
  `createBy` varchar(12) NOT NULL,
  `closeBy` varchar(12) DEFAULT NULL,
  `createAt` datetime DEFAULT (now()),
  `closeAt` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ImportNote`
--

LOCK TABLES `ImportNote` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `ImportNoteDetail`
--

DROP TABLE IF EXISTS `ImportNoteDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ImportNoteDetail` (
  `importNoteId` varchar(12) NOT NULL,
  `bookId` varchar(12) NOT NULL,
  `price` float NOT NULL,
  `qtyImport` float DEFAULT '0',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`importNoteId`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ImportNoteDetail`
--

LOCK TABLES `ImportNoteDetail` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `InventoryCheckNote`
--

DROP TABLE IF EXISTS `InventoryCheckNote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InventoryCheckNote` (
  `id` varchar(12) NOT NULL,
  `qtyDifferent` float NOT NULL,
  `qtyAfterAdjust` float NOT NULL,
  `createBy` varchar(12) NOT NULL,
  `createAt` datetime DEFAULT (now()),
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InventoryCheckNote`
--

LOCK TABLES `InventoryCheckNote` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `InventoryCheckNoteDetail`
--

DROP TABLE IF EXISTS `InventoryCheckNoteDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InventoryCheckNoteDetail` (
  `inventoryCheckNoteId` varchar(12) NOT NULL,
  `bookId` varchar(12) NOT NULL,
  `initial` float NOT NULL,
  `difference` float NOT NULL,
  `final` float NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`inventoryCheckNoteId`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InventoryCheckNoteDetail`
--

LOCK TABLES `InventoryCheckNoteDetail` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `Invoice`
--

DROP TABLE IF EXISTS `Invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Invoice` (
  `id` varchar(13) NOT NULL,
  `totalPrice` float NOT NULL,
  `qtyReceived` float NOT NULL,
  `createdBy` varchar(13) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Invoice`
--

LOCK TABLES `Invoice` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `InvoiceDetail`
--

DROP TABLE IF EXISTS `InvoiceDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InvoiceDetail` (
  `invoiceId` varchar(13) NOT NULL,
  `bookId` varchar(13) NOT NULL,
  `qty` float NOT NULL,
  `unitPrice` float NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`invoiceId`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InvoiceDetail`
--

LOCK TABLES `InvoiceDetail` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `MUser`
--

DROP TABLE IF EXISTS `MUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MUser` (
  `id` varchar(12) NOT NULL,
  `name` text NOT NULL,
  `phone` varchar(13) NOT NULL,
  `address` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `salt` text NOT NULL,
  `roleId` varchar(12) NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MUser`
--

LOCK TABLES `MUser` WRITE;
INSERT INTO `MUser` VALUES ('bgIqwQSIg','user','','','user@gmail.com','0dd71ba5a82e98ccdc6f5edb6fb870a5','ByVwWucjSGZkozLFeQcopssBrHPbCHoqRuUCFUbpfIhhqGUujj','user',1,'2023-12-02 01:52:32','2023-12-04 01:24:10',NULL),('g3W21A7SR','admin','1234567890','','admin@gmail.com','5e107317df151f6e8e0015c4f2ee7936','mVMxRDAHpAJfyzuiXWRELghNpynUqBKueSboGBcrwHUuzEWsms','admin',1,'2023-12-02 01:52:32','2023-12-04 01:24:10',NULL);
UNLOCK TABLES;

--
-- Table structure for table `Publisher`
--

DROP TABLE IF EXISTS `Publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Publisher` (
  `id` varchar(12) NOT NULL,
  `name` varchar(50) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Publisher`
--

LOCK TABLES `Publisher` WRITE;
INSERT INTO `Publisher` VALUES ('nxbdg','Giáo dục','2023-12-02 01:52:21','2023-12-02 01:52:21',1,NULL),('nxbdk','Kim Đồng','2023-12-02 01:52:21','2023-12-02 01:52:21',1,NULL);
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `id` varchar(13) NOT NULL,
  `name` text,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
INSERT INTO `Role` VALUES ('admin','admin','2023-12-02 01:52:40','2023-12-02 01:52:40',1,NULL),('user','user','2023-12-02 01:52:40','2023-12-02 01:52:40',1,NULL);
UNLOCK TABLES;

--
-- Table structure for table `RoleFeature`
--

DROP TABLE IF EXISTS `RoleFeature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RoleFeature` (
  `roleId` varchar(12) NOT NULL,
  `featureId` varchar(30) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`roleId`,`featureId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RoleFeature`
--

LOCK TABLES `RoleFeature` WRITE;
INSERT INTO `RoleFeature` VALUES ('admin','AUTHOR_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','AUTHOR_DELETE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','AUTHOR_UPDATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','AUTHOR_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','BOOK_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','BOOK_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CAN_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CAN_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CAT_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CAT_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CAT_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CATEGORY_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CATEGORY_DELETE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CATEGORY_UPDATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CATEGORY_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CUS_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CUS_PAY','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CUS_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','CUS_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','EXP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','EXP_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','FOD_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','FOD_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','FOD_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','FOD_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','IMP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','IMP_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','IMP_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','ING_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','ING_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','INV_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','INV_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','PUBLISHER_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','PUBLISHER_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','SUP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','SUP_PAY','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','SUP_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','SUP_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','TOP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','TOP_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','TOP_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','TOP_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','USE_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','USE_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('admin','USE_VIEW','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','CAN_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','CAT_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','CAT_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','CUS_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','CUS_PAY','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','CUS_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','EXP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','FOD_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','FOD_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','FOD_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','IMP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','IMP_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','ING_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','INV_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','SUP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','SUP_PAY','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','SUP_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','TOP_CREATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','TOP_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','TOP_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','USE_UP_INFO','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL),('user','USE_UP_STATE','2023-12-02 01:54:37','2023-12-02 01:54:37',1,NULL);
UNLOCK TABLES;

--
-- Table structure for table `ShopGeneral`
--

DROP TABLE IF EXISTS `ShopGeneral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ShopGeneral` (
  `id` varchar(12) NOT NULL,
  `name` varchar(12) NOT NULL,
  `email` float NOT NULL,
  `phone` float NOT NULL,
  `address` text,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShopGeneral`
--

LOCK TABLES `ShopGeneral` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `StockReport`
--

DROP TABLE IF EXISTS `StockReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StockReport` (
  `id` varchar(12) NOT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StockReport`
--

LOCK TABLES `StockReport` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `StockReportDetail`
--

DROP TABLE IF EXISTS `StockReportDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StockReportDetail` (
  `reportId` varchar(12) NOT NULL,
  `bookId` varchar(12) NOT NULL,
  `initial` float NOT NULL,
  `sell` float NOT NULL,
  `import` float NOT NULL,
  `modify` float NOT NULL,
  `final` float NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`reportId`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StockReportDetail`
--

LOCK TABLES `StockReportDetail` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `Supplier`
--

DROP TABLE IF EXISTS `Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supplier` (
  `id` varchar(12) NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `phone` varchar(11) NOT NULL,
  `debt` float DEFAULT '0',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplier`
--

LOCK TABLES `Supplier` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `SupplierDebt`
--

DROP TABLE IF EXISTS `SupplierDebt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SupplierDebt` (
  `id` varchar(12) NOT NULL,
  `supplierId` varchar(12) NOT NULL,
  `qty` float NOT NULL,
  `qtyLeft` float NOT NULL,
  `type` enum('Debt','Pay') NOT NULL,
  `createAt` datetime DEFAULT (now()),
  `createBy` varchar(9) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`supplierId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SupplierDebt`
--

LOCK TABLES `SupplierDebt` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `SupplierDebtDetail`
--

DROP TABLE IF EXISTS `SupplierDebtDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SupplierDebtDetail` (
  `reportId` varchar(12) NOT NULL,
  `supplierId` varchar(12) NOT NULL,
  `initial` float NOT NULL,
  `arise` float NOT NULL,
  `final` float NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`reportId`,`supplierId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SupplierDebtDetail`
--

LOCK TABLES `SupplierDebtDetail` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `SupplierDebtReport`
--

DROP TABLE IF EXISTS `SupplierDebtReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SupplierDebtReport` (
  `id` varchar(12) NOT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SupplierDebtReport`
--

LOCK TABLES `SupplierDebtReport` WRITE;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-10  3:36:54
