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
-- Temporary table structure for view `ultcbcomplote`
--
DROP TABLE IF EXISTS `ultcbcomplote`;
DROP VIEW IF EXISTS `ultcbcomplote`;
CREATE TABLE `ultcbcomplote` (
  `idcbcompro` int(10) unsigned,
  `idcbasoci` int(10) unsigned,
  `narchivo` char(100),
  `lote` int(10) unsigned,
  `eperiodo` char(20),
  `esecuencia` char(10),
  `comprobante` char(100),
  `total1` double(13,2),
  `vence1` char(8),
  `total2` double(13,2),
  `vence2` char(8),
  `total3` double(13,2),
  `vence3` char(8),
  `bc` char(254),
  `timestamp` timestamp,
  `codigo` varchar(45)
);

--
-- Definition of table `cbasociadas`
--

DROP TABLE IF EXISTS `cbasociadas`;
CREATE TABLE `cbasociadas` (
  `idcbasoci` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `empresaid` char(15) NOT NULL,
  `nombre` char(100) NOT NULL,
  `cuit` char(13) NOT NULL,
  `activa` char(1) NOT NULL,
  `cobra` char(1) NOT NULL,
  `cobropar` char(1) NOT NULL,
  `narchivoe` char(4) NOT NULL,
  `narchivor` char(4) NOT NULL,
  `esecuencia` int(10) unsigned NOT NULL,
  `ftp` char(100) NOT NULL,
  `email` char(100) NOT NULL,
  `elong` char(10) NOT NULL,
  `eempresaid` char(10) NOT NULL,
  `eesecuencia` char(10) NOT NULL,
  `eperiodo` char(10) NOT NULL,
  `ebc` char(10) NOT NULL,
  `ebceid` char(10) NOT NULL,
  `ebcsid` char(10) NOT NULL,
  `ebcidcomp` char(10) NOT NULL,
  `ebctotal1` char(10) NOT NULL,
  `ebcvence1` char(10) NOT NULL,
  `ebctotal2` char(10) NOT NULL,
  `ebcvence2` char(10) NOT NULL,
  `ebctotal3` char(10) NOT NULL,
  `ebcvence3` char(10) NOT NULL,
  `r0empresaid` char(10) NOT NULL,
  `r0puntorec` char(10) NOT NULL,
  `r0secuencia` char(10) NOT NULL,
  `r1idcobro` char(10) NOT NULL,
  `r1fechacobro` char(10) NOT NULL,
  `r1importe` char(10) NOT NULL,
  `r1recargo` char(10) NOT NULL,
  `r1bc` char(10) NOT NULL,
  `r2cantidad` char(10) NOT NULL,
  `r2total` char(10) NOT NULL,
  `subcodid` char(15) NOT NULL,
  PRIMARY KEY (`idcbasoci`,`cuit`) USING BTREE,
  KEY `Index_2` (`subcodid`),
  KEY `Index_3` (`empresaid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbasociadas`
--

/*!40000 ALTER TABLE `cbasociadas` DISABLE KEYS */;
INSERT INTO `cbasociadas` (`idcbasoci`,`empresaid`,`nombre`,`cuit`,`activa`,`cobra`,`cobropar`,`narchivoe`,`narchivor`,`esecuencia`,`ftp`,`email`,`elong`,`eempresaid`,`eesecuencia`,`eperiodo`,`ebc`,`ebceid`,`ebcsid`,`ebcidcomp`,`ebctotal1`,`ebcvence1`,`ebctotal2`,`ebcvence2`,`ebctotal3`,`ebcvence3`,`r0empresaid`,`r0puntorec`,`r0secuencia`,`r1idcobro`,`r1fechacobro`,`r1importe`,`r1recargo`,`r1bc`,`r2cantidad`,`r2total`,`subcodid`) VALUES 
 (1,'0001','Krumbein','30-71204634-8','S','S','S','0001','0001',4,'','ventas@amoblark.com.ar','1-96','1-4','5-5','10-14','24-73','24-4','28-4','32-8','40-12','52-7','59-12','71-7','78-12','90-7','2-4','6-13','19-5','2-8','10-7','17-12','29-10','39-73','2-6','8-16','0002'),
 (2,'0002','Cooperativa','20-11222333-8','S','S','S','0002','0002',1,'','ventas@cooperativa.com.ar','1-96','1-4','5-5','10-14','24-73','24-4','28-4','32-8','40-12','52-7','59-12','71-7','78-12','90-7','2-4','6-13','19-5','2-8','10-7','17-12','29-10','39-73','2-6','8-16','0003');
/*!40000 ALTER TABLE `cbasociadas` ENABLE KEYS */;


--
-- Definition of table `cbcobros`
--

DROP TABLE IF EXISTS `cbcobros`;
CREATE TABLE `cbcobros` (
  `idcbcobro` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcbcompro` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `importe` double(13,2) NOT NULL,
  `recargo` double(13,2) NOT NULL,
  `lotecobro` int(10) unsigned NOT NULL,
  `entrega` double(13,2) NOT NULL,
  `vuelto` double(13,2) NOT NULL,
  `usuario` char(20) NOT NULL,
  `host` char(20) NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcbcobro`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcobros`
--

/*!40000 ALTER TABLE `cbcobros` DISABLE KEYS */;
INSERT INTO `cbcobros` (`idcbcobro`,`idcbcompro`,`fecha`,`importe`,`recargo`,`lotecobro`,`entrega`,`vuelto`,`usuario`,`host`,`secuencia`,`timestamp`) VALUES 
 (2,2,'20210717',1700.30,200.00,1,1800.00,99.70,'TULIO','PC-PABLO',1,'2021-07-17 12:06:33'),
 (3,4,'20210728',2100.50,300.00,2,5000.00,399.10,'TULIO','PC-PABLO',1,'2021-07-28 21:50:28'),
 (4,5,'20210728',2500.40,600.00,2,5000.00,399.10,'TULIO','PC-PABLO',1,'2021-07-28 21:50:28'),
 (5,3,'20210729',1900.30,200.00,3,2000.00,99.70,'TULIO','PC-PABLO',1,'2021-07-29 21:04:22'),
 (6,10,'20210814',3100.50,300.00,4,3200.00,99.50,'TULIO','PC-PABLO',2,'2021-08-14 10:34:48'),
 (7,14,'20210814',700.00,0.00,5,2000.00,500.00,'TULIO','PC-PABLO',2,'2021-08-14 12:34:18'),
 (8,12,'20210814',800.00,0.00,5,2000.00,500.00,'TULIO','PC-PABLO',1,'2021-08-14 12:34:18'),
 (9,13,'20210814',2100.00,0.00,6,2300.00,200.00,'TULIO','PC-PABLO',2,'2021-08-14 12:44:12'),
 (10,11,'20210814',3100.30,199.90,7,3200.00,99.70,'TULIO','PC-PABLO',3,'2021-08-14 12:51:33'),
 (11,15,'20210814',2000.00,0.00,8,2000.00,0.00,'TULIO','PC-PABLO',4,'2021-08-14 12:54:41'),
 (12,16,'20210814',900.50,0.00,9,1000.00,99.50,'TULIO','PC-PABLO',4,'2021-08-14 12:57:25');
/*!40000 ALTER TABLE `cbcobros` ENABLE KEYS */;


--
-- Definition of table `cbcomprobantes`
--

DROP TABLE IF EXISTS `cbcomprobantes`;
CREATE TABLE `cbcomprobantes` (
  `idcbcompro` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcbasoci` int(10) unsigned NOT NULL,
  `narchivo` char(100) NOT NULL,
  `lote` int(10) unsigned NOT NULL,
  `eperiodo` char(20) NOT NULL,
  `esecuencia` char(10) NOT NULL,
  `comprobante` char(100) NOT NULL,
  `total1` double(13,2) NOT NULL,
  `vence1` char(8) NOT NULL,
  `total2` double(13,2) NOT NULL,
  `vence2` char(8) NOT NULL,
  `total3` double(13,2) NOT NULL,
  `vence3` char(8) NOT NULL,
  `bc` char(254) NOT NULL,
  `idcomp` char(15) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcbcompro`),
  KEY `Index_2` (`idcomp`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcomprobantes`
--

/*!40000 ALTER TABLE `cbcomprobantes` DISABLE KEYS */;
INSERT INTO `cbcomprobantes` (`idcbcompro`,`idcbasoci`,`narchivo`,`lote`,`eperiodo`,`esecuencia`,`comprobante`,`total1`,`vence1`,`total2`,`vence2`,`total3`,`vence3`,`bc`,`idcomp`,`timestamp`) VALUES 
 (1,1,'0001',1,'2021060120210630','1','',1500.30,'20210602',1600.30,'20210615',1700.30,'20210702','0001000200000003000000150030245936800000016003024593810000001700302459398','000000000000003','0000-00-00 00:00:00'),
 (2,1,'0001',2,'2021060120210630','1','',1500.30,'20210602',1600.30,'20210615',1700.30,'20210702','0001000200000003000000150030245936800000016003024593810000001700302459398','000000000000003','0000-00-00 00:00:00'),
 (3,1,'0001',3,'2021060120210630','2','',1700.30,'20210602',1800.30,'20210615',1900.30,'20210702','0001000200000004000000170030245936800000018003024593810000001900302459398','000000000000004','2021-07-27 21:39:27'),
 (4,1,'0001',3,'2021060120210630','2','',1800.50,'20210602',1900.30,'20210615',2000.30,'20210702','0001000200000005000000180050245936800000019003024593810000002000302459398','000000000000005','2021-07-27 21:39:27'),
 (5,1,'0001',3,'2021060120210630','2','',1900.40,'20210602',2000.30,'20210615',2100.30,'20210702','0001000200000006000000190040245936800000020003024593810000002100302459398','000000000000006','2021-07-27 21:39:27'),
 (9,1,'0001',4,'2021060120210630','3','',2700.30,'20210602',2800.30,'20210615',2900.30,'20210702','0001000200000007000000270030245936800000028003024593810000002900302459398','000000000000007','2021-08-14 10:20:50'),
 (10,1,'0001',4,'2021060120210630','3','',2800.50,'20210602',2900.30,'20210615',3000.30,'20210702','0001000200000008000000280050245936800000029003024593810000003000302459398','000000000000008','2021-08-14 10:20:51'),
 (11,1,'0001',4,'2021060120210630','3','',2900.40,'20210602',3000.30,'20210615',3100.30,'20210702','0001000200000009000000290040245936800000030003024593810000003100302459398','000000000000009','2021-08-14 10:20:51'),
 (12,2,'0002',5,'2021080120210831','1','',800.00,'20210830',900.30,'20210930',950.30,'20211030','0002000300000002000000080000245945700000009003024594880000000950302459518','000000000000002','2021-08-14 12:28:58'),
 (13,2,'0002',5,'2021080120210831','1','',2100.00,'20210830',2200.30,'20210930',3000.30,'20211030','0002000300000004000000210000245945700000022003024594880000003000302459518','000000000000004','2021-08-14 12:28:58'),
 (14,1,'0001',6,'2021080120210831','4','',700.00,'20210830',800.30,'20210930',900.30,'20211030','0001000200000010000000070000245945700000008003024594880000000900302459518','000000000000010','2021-08-14 12:29:44'),
 (15,1,'0001',6,'2021080120210831','4','',2000.00,'20210830',2200.30,'20210930',3000.30,'20211030','0001000200000011000000200000245945700000022003024594880000003000302459518','000000000000011','2021-08-14 12:29:44'),
 (16,1,'0001',6,'2021080120210831','4','',900.50,'20210830',1000.30,'20210930',1100.30,'20211030','0001000200000012000000090050245945700000010003024594880000001100302459518','000000000000012','2021-08-14 12:29:44');
/*!40000 ALTER TABLE `cbcomprobantes` ENABLE KEYS */;


--
-- Definition of view `ultcbcomplote`
--

DROP TABLE IF EXISTS `ultcbcomplote`;
DROP VIEW IF EXISTS `ultcbcomplote`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultcbcomplote` AS select `c`.`idcbcompro` AS `idcbcompro`,`c`.`idcbasoci` AS `idcbasoci`,`c`.`narchivo` AS `narchivo`,`c`.`lote` AS `lote`,`c`.`eperiodo` AS `eperiodo`,`c`.`esecuencia` AS `esecuencia`,`c`.`comprobante` AS `comprobante`,`c`.`total1` AS `total1`,`c`.`vence1` AS `vence1`,`c`.`total2` AS `total2`,`c`.`vence2` AS `vence2`,`c`.`total3` AS `total3`,`c`.`vence3` AS `vence3`,`c`.`bc` AS `bc`,`c`.`timestamp` AS `timestamp`,`m`.`codigo` AS `codigo` from (`maxcbcomplote` `m` left join (`cbcomprobantes` `c` left join `cbasociadas` `a` on((`c`.`idcbasoci` = `a`.`idcbasoci`))) on(((`m`.`codigo` = concat(`a`.`empresaid`,`a`.`subcodid`,`c`.`idcomp`)) and (`m`.`lote` = `c`.`lote`))));



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
