-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.55-0+deb8u1


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema trsoftdb
--

CREATE DATABASE IF NOT EXISTS trsoftdb;
USE trsoftdb;

--
-- Definition of table `afipescalas`
--

DROP TABLE IF EXISTS `afipescalas`;
CREATE TABLE `afipescalas` (
  `idafipesc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` int(10) unsigned NOT NULL,
  `descrip` char(100) NOT NULL,
  `valmin` double(13,2) NOT NULL,
  `valmax` double(13,2) NOT NULL,
  `valfijo` double(13,2) NOT NULL,
  `razon` double(13,2) NOT NULL,
  PRIMARY KEY (`idafipesc`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `afipescalas`
--

/*!40000 ALTER TABLE `afipescalas` DISABLE KEYS */;
INSERT INTO `afipescalas` (`idafipesc`,`codigo`,`descrip`,`valmin`,`valmax`,`valfijo`,`razon`) VALUES 
 (1,2,'Escala Inscriptos cód. régimen 124',0.00,8000.00,0.00,5.00),
 (2,2,'Escala Inscriptos cód. régimen 124',8000.00,16000.00,400.00,9.00),
 (3,2,'Escala Inscriptos cód. régimen 124',16000.00,24000.00,1120.00,12.00),
 (4,2,'Escala Inscriptos cód. régimen 124',24000.00,32000.00,2080.00,15.00),
 (5,2,'Escala Inscriptos cód. régimen 124',32000.00,48000.00,3280.00,19.00),
 (6,2,'Escala Inscriptos cód. régimen 124',48000.00,64000.00,6320.00,23.00),
 (7,2,'Escala Inscriptos cód. régimen 124',64000.00,96000.00,10000.00,27.00),
 (8,2,'Escala Inscriptos cód. régimen 124',96000.00,-1.00,18640.00,31.00),
 (9,1,'Escala Inscriptos cód. régimen 78',0.00,-1.00,0.00,2.00),
 (10,3,'Escala NO Inscriptos cód. régimen 78',0.00,-1.00,0.00,10.00),
 (11,4,'Escala NO Inscriptos cód. régimen 124',0.00,-1.00,0.00,28.00),
 (12,5,'Escala para Inscriptos Ret. IIBB',0.00,-1.00,0.00,2.00),
 (13,6,'Escala para NO Inscriptos Ret. IIBB',0.00,-1.00,0.00,5.00);
/*!40000 ALTER TABLE `afipescalas` ENABLE KEYS */;


--
-- Definition of table `entidadret`
--

DROP TABLE IF EXISTS `entidadret`;
CREATE TABLE `entidadret` (
  `identret` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idimpuret` int(10) unsigned NOT NULL,
  `enconvenio` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`identret`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadret`
--

/*!40000 ALTER TABLE `entidadret` DISABLE KEYS */;
INSERT INTO `entidadret` (`identret`,`entidad`,`idimpuret`,`enconvenio`) VALUES 
 (1,1,1,'S'),
 (2,2,2,'S'),
 (3,3,2,'S'),
 (4,4,1,'S'),
 (5,4,3,'S');
/*!40000 ALTER TABLE `entidadret` ENABLE KEYS */;


--
-- Definition of table `impuretencion`
--

DROP TABLE IF EXISTS `impuretencion`;
CREATE TABLE `impuretencion` (
  `idimpuret` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(200) NOT NULL,
  `razonin` int(10) unsigned NOT NULL,
  `baseimpon` double(13,2) NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `funcion` char(100) NOT NULL,
  `razonnin` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idimpuret`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `impuretencion`
--

/*!40000 ALTER TABLE `impuretencion` DISABLE KEYS */;
INSERT INTO `impuretencion` (`idimpuret`,`detalle`,`razonin`,`baseimpon`,`idtipopago`,`funcion`,`razonnin`) VALUES 
 (1,'Enajenación de bienes muebles y bienes de cambio',1,224000.00,5,'RET_GANANCIAS_IFN',3),
 (2,'Corredor viajante de comercio y despachante de aduana',2,16830.00,5,'RET_GANANCIAS_IFN',4),
 (3,'Retención de IIBB',5,1000.00,5,'RET_IIBB_IFN',6);
/*!40000 ALTER TABLE `impuretencion` ENABLE KEYS */;


--
-- Definition of table `retenciones`
--

DROP TABLE IF EXISTS `retenciones`;
CREATE TABLE `retenciones` (
  `idreten` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pventa` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `idimpuret` int(10) unsigned NOT NULL,
  `importe` double(13,2) NOT NULL,
  `sujarete` double(13,2) NOT NULL,
  `idafipesc` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idreten`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `retenciones`
--

/*!40000 ALTER TABLE `retenciones` DISABLE KEYS */;
INSERT INTO `retenciones` (`idreten`,`pventa`,`idcomproba`,`numero`,`fecha`,`entidad`,`idimpuret`,`importe`,`sujarete`,`idafipesc`,`timestamp`) VALUES 
 (1,1,43,1,'20221119',1,1,1520.00,76000.00,0,'0000-00-00 00:00:00'),
 (2,1,43,2,'20221119',1,1,5000.00,326000.00,0,'2022-11-22 20:59:11'),
 (3,1,43,3,'20221122',1,1,2000.00,426000.00,0,'2022-11-22 21:07:21'),
 (4,1,43,3,'20221122',2,2,3502.30,33170.00,0,'2022-11-22 21:25:01'),
 (5,1,43,4,'20221122',2,2,26660.40,133170.00,0,'2022-11-22 21:39:15'),
 (6,1,43,5,'20221124',4,1,478.68,23933.88,0,'2022-11-24 19:17:30'),
 (7,1,43,6,'20221124',4,3,5980.00,299000.00,0,'2022-11-24 20:48:43'),
 (8,1,43,7,'20221124',4,1,4958.68,271867.77,0,'2022-11-24 21:31:27'),
 (9,1,43,8,'20221126',4,1,4958.67,519801.65,0,'2022-11-26 09:53:33'),
 (10,1,43,9,'20221126',4,1,180.81,528841.88,0,'2022-11-26 10:29:51'),
 (11,1,43,10,'20221126',4,1,4958.68,776775.76,0,'2022-11-26 10:32:33'),
 (12,1,43,11,'20221126',4,1,4958.67,1024709.64,0,'2022-11-26 10:38:49'),
 (13,1,43,12,'20221126',4,1,4958.68,1272643.53,0,'2022-11-26 11:00:06'),
 (14,1,43,13,'20221126',4,1,4958.68,1520577.41,0,'2022-11-26 11:03:09'),
 (15,1,43,14,'20221126',4,3,5980.00,299000.00,0,'2022-11-26 11:03:16'),
 (16,1,43,15,'20221128',4,1,4958.68,1768511.30,9,'2022-12-01 22:52:08'),
 (17,1,43,16,'20221128',4,3,5980.00,299000.00,10,'2022-12-01 22:52:08'),
 (18,1,43,17,'20221202',4,1,3784.46,189223.14,9,'2022-12-02 19:25:17'),
 (19,1,43,18,'20221202',4,3,9980.00,499000.00,12,'2022-12-02 19:25:17'),
 (20,1,43,19,'20221202',4,1,4958.68,437157.02,9,'2022-12-02 19:33:31'),
 (21,1,43,20,'20221202',4,1,4958.68,685090.91,9,'2022-12-02 19:44:35'),
 (22,1,43,21,'20221202',4,3,5980.00,299000.00,12,'2022-12-02 19:44:35'),
 (23,1,43,22,'20221202',4,1,4958.68,933024.79,9,'2022-12-02 20:05:28'),
 (24,1,43,23,'20221202',4,3,5980.00,299000.00,12,'2022-12-02 20:05:28'),
 (25,1,43,24,'20221202',4,1,1.65,933107.43,9,'2022-12-02 20:06:40'),
 (26,1,43,25,'20221202',4,3,0.00,0.00,0,'2022-12-02 20:06:40');
/*!40000 ALTER TABLE `retenciones` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
