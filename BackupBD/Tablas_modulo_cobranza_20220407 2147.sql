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
 (1,'0001','Krumbein','30-71204634-8','S','S','S','0001','0001',8,'','ventas@amoblark.com.ar','1-103','1-4','5-5','10-14','24-80','24-4','28-4','32-15','47-12','59-7','66-12','78-7','85-12','97-7','2-4','6-13','19-5','2-8','10-7','17-12','29-10','39-73','2-6','8-16','0002'),
 (2,'0002','Cooperativa','20-11222333-8','S','S','S','0002','0002',1,'','ventas@cooperativa.com.ar','1-103','1-4','5-5','10-14','24-80','24-4','28-4','32-15','47-12','59-7','66-12','78-7','85-12','97-7','2-4','6-13','19-5','2-8','10-7','17-12','29-10','39-73','2-6','8-16','0003');
/*!40000 ALTER TABLE `cbasociadas` ENABLE KEYS */;


--
-- Definition of table `cbcobrador`
--

DROP TABLE IF EXISTS `cbcobrador`;
CREATE TABLE `cbcobrador` (
  `idcbcobra` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`idcbcobra`),
  KEY `Index_3` (`empresaid`),
  KEY `Index_2` (`subcodid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcobrador`
--

/*!40000 ALTER TABLE `cbcobrador` DISABLE KEYS */;
INSERT INTO `cbcobrador` (`idcbcobra`,`empresaid`,`nombre`,`cuit`,`activa`,`cobra`,`cobropar`,`narchivoe`,`narchivor`,`esecuencia`,`ftp`,`email`,`elong`,`eempresaid`,`eesecuencia`,`eperiodo`,`ebc`,`ebceid`,`ebcsid`,`ebcidcomp`,`ebctotal1`,`ebcvence1`,`ebctotal2`,`ebcvence2`,`ebctotal3`,`ebcvence3`,`r0empresaid`,`r0puntorec`,`r0secuencia`,`r1idcobro`,`r1fechacobro`,`r1importe`,`r1recargo`,`r1bc`,`r2cantidad`,`r2total`,`subcodid`) VALUES 
 (1,'2011222333401','Cobrador1','20-11222333-4','S','S','S','0001','0001',2,'','ventas@cobrador1.com.ar','1-103','1-4','5-5','10-14','24-80','24-4','28-4','32-15','47-12','59-7','66-12','78-7','85-12','97-7','2-4','6-13','19-5','2-8','10-7','17-12','29-10','39-80','2-6','8-16','0001');
/*!40000 ALTER TABLE `cbcobrador` ENABLE KEYS */;


--
-- Definition of table `cbcobrados`
--

DROP TABLE IF EXISTS `cbcobrados`;
CREATE TABLE `cbcobrados` (
  `idcbcob` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idfactura` int(10) unsigned NOT NULL,
  `idcbcobra` int(10) unsigned NOT NULL,
  `idcobro` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `fechacobro` char(8) NOT NULL,
  `impcobro` double(13,2) NOT NULL,
  `imprecargo` double(13,2) NOT NULL,
  `bc` char(254) NOT NULL,
  `loteimp` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcbcob`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcobrados`
--

/*!40000 ALTER TABLE `cbcobrados` DISABLE KEYS */;
/*!40000 ALTER TABLE `cbcobrados` ENABLE KEYS */;


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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcobros`
--

/*!40000 ALTER TABLE `cbcobros` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcomprobantes`
--

/*!40000 ALTER TABLE `cbcomprobantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `cbcomprobantes` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
