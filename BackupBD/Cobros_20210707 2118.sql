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
  `lotemax` int(10) unsigned NOT NULL,
  `loteact` int(10) unsigned NOT NULL,
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
  PRIMARY KEY (`idcbasoci`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbasociadas`
--

/*!40000 ALTER TABLE `cbasociadas` DISABLE KEYS */;
INSERT INTO `cbasociadas` (`idcbasoci`,`empresaid`,`nombre`,`cuit`,`activa`,`cobra`,`cobropar`,`lotemax`,`loteact`,`narchivoe`,`narchivor`,`esecuencia`,`ftp`,`email`,`elong`,`eempresaid`,`eesecuencia`,`eperiodo`,`ebc`,`ebceid`,`ebcsid`,`ebcidcomp`,`ebctotal1`,`ebcvence1`,`ebctotal2`,`ebcvence2`,`ebctotal3`,`ebcvence3`,`r0empresaid`,`r0puntorec`,`r0secuencia`,`r1idcobro`,`r1fechacobro`,`r1importe`,`r1recargo`,`r1bc`,`r2cantidad`,`r2total`) VALUES 
 (1,'0001','Krumbein','30-71204634-8','S','S','S',0,0,'0001','0001',0,'','ventas@amoblark.com.ar','1-95','1-4','5-4','9-14','23-73','23-4','27-4','31-8','39-12','51-7','58-12','70-7','77-12','89-7','2-4','6-4','10-4','2,8','10-7','17-12','29-10','39-70','2-6','8-16');
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
  `secuencia` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcbcompro`)
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
