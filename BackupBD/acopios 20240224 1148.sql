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
-- Definition of table `acopio`
--

DROP TABLE IF EXISTS `acopio`;
CREATE TABLE `acopio` (
  `idacopio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pventa` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `descrip` char(100) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `numcomp` int(10) unsigned NOT NULL,
  `carpintero` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idacopio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acopio`
--

/*!40000 ALTER TABLE `acopio` DISABLE KEYS */;
/*!40000 ALTER TABLE `acopio` ENABLE KEYS */;


--
-- Definition of table `acopiod`
--

DROP TABLE IF EXISTS `acopiod`;
CREATE TABLE `acopiod` (
  `idacopiod` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopio` int(10) unsigned NOT NULL,
  `idmateacopio` int(10) unsigned NOT NULL,
  `precio` float(13,4) NOT NULL,
  `tipocbio` float(13,4) NOT NULL,
  `moneda` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idacopiod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acopiod`
--

/*!40000 ALTER TABLE `acopiod` DISABLE KEYS */;
/*!40000 ALTER TABLE `acopiod` ENABLE KEYS */;


--
-- Definition of table `acopiodp`
--

DROP TABLE IF EXISTS `acopiodp`;
CREATE TABLE `acopiodp` (
  `idacopiodp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopiop` int(10) unsigned NOT NULL,
  `idmateacop` int(10) unsigned NOT NULL,
  `precio` float(13,4) NOT NULL,
  `tipocbio` float(13,4) NOT NULL,
  `moneda` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idacopiodp`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acopiodp`
--

/*!40000 ALTER TABLE `acopiodp` DISABLE KEYS */;
INSERT INTO `acopiodp` (`idacopiodp`,`idacopiop`,`idmateacop`,`precio`,`tipocbio`,`moneda`) VALUES 
 (1,1,1,100.0000,1.0000,1),
 (2,2,1,1000.0000,1.0000,1),
 (3,2,2,100.0000,1.0000,1),
 (4,3,1,100.0000,1.0000,1),
 (5,4,1,1000.0000,1.0000,1);
/*!40000 ALTER TABLE `acopiodp` ENABLE KEYS */;


--
-- Definition of table `acopiop`
--

DROP TABLE IF EXISTS `acopiop`;
CREATE TABLE `acopiop` (
  `idacopiop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pventa` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `descrip` char(100) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `numcomp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idacopiop`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acopiop`
--

/*!40000 ALTER TABLE `acopiop` DISABLE KEYS */;
INSERT INTO `acopiop` (`idacopiop`,`pventa`,`idcomproba`,`fecha`,`entidad`,`descrip`,`numero`,`numcomp`) VALUES 
 (1,3,52,'20240209',76,'',1,1),
 (2,3,52,'20240217',76,'',2,2),
 (3,3,52,'20240222',1,'',1,3),
 (4,3,52,'20240224',76,'',3,4);
/*!40000 ALTER TABLE `acopiop` ENABLE KEYS */;


--
-- Definition of table `compacopio`
--

DROP TABLE IF EXISTS `compacopio`;
CREATE TABLE `compacopio` (
  `idcompacopio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopio` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  `idnp` int(10) unsigned NOT NULL,
  `acopio` char(1) NOT NULL,
  `idajustea` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcompacopio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compacopio`
--

/*!40000 ALTER TABLE `compacopio` DISABLE KEYS */;
/*!40000 ALTER TABLE `compacopio` ENABLE KEYS */;


--
-- Definition of table `compacopiop`
--

DROP TABLE IF EXISTS `compacopiop`;
CREATE TABLE `compacopiop` (
  `idcompacop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopiop` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  `idnp` int(10) unsigned NOT NULL,
  `acopio` char(1) NOT NULL,
  `idajusteap` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcompacop`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compacopiop`
--

/*!40000 ALTER TABLE `compacopiop` DISABLE KEYS */;
INSERT INTO `compacopiop` (`idcompacop`,`idacopiop`,`importe`,`idregistro`,`idnp`,`acopio`,`idajusteap`) VALUES 
 (1,1,172930.6250,5388,0,'S',0),
 (2,1,21600.6602,3878,0,'S',0),
 (3,1,100.0000,0,0,'S',0),
 (4,1,10.0000,0,0,'S',0),
 (5,1,100.0000,0,0,'S',0),
 (6,1,10.0000,0,0,'S',0),
 (7,1,100.0000,0,0,'S',0),
 (8,1,1000.0000,0,0,'S',0),
 (9,1,100.0000,0,0,'S',0),
 (10,1,1000.0000,0,0,'S',7),
 (12,1,10.0000,0,0,'S',9),
 (13,1,46233.3008,3217,0,'N',0),
 (14,1,10.0000,0,0,'S',10),
 (15,1,10.0000,0,0,'S',11),
 (16,2,46233.3008,3217,0,'S',0),
 (17,2,5000.0000,5396,0,'N',0),
 (18,2,-5000.0000,5397,0,'N',0),
 (19,2,15666.7197,1431,0,'S',0),
 (20,3,100.0000,0,0,'S',12),
 (21,3,-10.0000,0,0,'S',13),
 (22,2,-56900.0195,0,0,'S',14),
 (23,4,10000.0000,0,0,'S',15);
/*!40000 ALTER TABLE `compacopiop` ENABLE KEYS */;


--
-- Definition of table `mateacopio`
--

DROP TABLE IF EXISTS `mateacopio`;
CREATE TABLE `mateacopio` (
  `idmateacopio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(100) NOT NULL,
  `unidad` char(10) NOT NULL,
  `articulo` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`idmateacopio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mateacopio`
--

/*!40000 ALTER TABLE `mateacopio` DISABLE KEYS */;
INSERT INTO `mateacopio` (`idmateacopio`,`detalle`,`unidad`,`articulo`) VALUES 
 (1,'ALUMINIO','KG','00001'),
 (2,'AA PORTATIL SURREY 3000F FC 551IDQ1201F','UN','000940'),
 (5,'AMOB. COMERCIAL AMOBLARK A MEDIDA SEGUN DISEÑO  ','UN','000001');
/*!40000 ALTER TABLE `mateacopio` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
