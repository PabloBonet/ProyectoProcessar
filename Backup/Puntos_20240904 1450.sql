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
-- Create schema processarel
--

CREATE DATABASE IF NOT EXISTS processarel;
USE processarel;

--
-- Definition of table `pntentidades`
--

DROP TABLE IF EXISTS `pntentidades`;
CREATE TABLE `pntentidades` (
  `entidad` int(10) unsigned NOT NULL,
  `fechaini` char(8) NOT NULL,
  `fechafin` char(8) NOT NULL,
  `observa` char(254) NOT NULL,
  PRIMARY KEY (`entidad`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pntentidades`
--

/*!40000 ALTER TABLE `pntentidades` DISABLE KEYS */;
INSERT INTO `pntentidades` (`entidad`,`fechaini`,`fechafin`,`observa`) VALUES 
 (1,'20240301','',''),
 (2,'20240730','',''),
 (282,'20240101','','');
/*!40000 ALTER TABLE `pntentidades` ENABLE KEYS */;


--
-- Definition of table `pntfiltro`
--

DROP TABLE IF EXISTS `pntfiltro`;
CREATE TABLE `pntfiltro` (
  `idpntfil` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpntopera` int(10) unsigned NOT NULL,
  `tablaf` char(100) NOT NULL DEFAULT '',
  `campof` char(100) NOT NULL DEFAULT '',
  `tipof` char(50) NOT NULL DEFAULT '',
  `valor1` char(50) NOT NULL DEFAULT '',
  `compara` char(20) NOT NULL,
  `valor2` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`idpntfil`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pntfiltro`
--

/*!40000 ALTER TABLE `pntfiltro` DISABLE KEYS */;
INSERT INTO `pntfiltro` (`idpntfil`,`idpntopera`,`tablaf`,`campof`,`tipof`,`valor1`,`compara`,`valor2`) VALUES 
 (5,1,'facturas','entidad','int(10) unsigned','1','Igual','20'),
 (6,2,'facturas','idcomproba','int(10) unsigned','','Todos','');
/*!40000 ALTER TABLE `pntfiltro` ENABLE KEYS */;


--
-- Definition of table `pntfuncion`
--

DROP TABLE IF EXISTS `pntfuncion`;
CREATE TABLE `pntfuncion` (
  `idpntfun` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(254) NOT NULL,
  `funcionpnt` char(100) NOT NULL,
  PRIMARY KEY (`idpntfun`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pntfuncion`
--

/*!40000 ALTER TABLE `pntfuncion` DISABLE KEYS */;
INSERT INTO `pntfuncion` (`idpntfun`,`detalle`,`funcionpnt`) VALUES 
 (1,'Sin Funcion Asociada','FPNTMultiplo(1)'),
 (2,'Multiplica Puntos Por 10','FPNTMultiplo(10)');
/*!40000 ALTER TABLE `pntfuncion` ENABLE KEYS */;


--
-- Definition of table `pntopera`
--

DROP TABLE IF EXISTS `pntopera`;
CREATE TABLE `pntopera` (
  `idpntopera` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(254) NOT NULL,
  `puntos` float(13,2) NOT NULL,
  `tabla` char(100) NOT NULL,
  `cmpfactor` char(100) NOT NULL,
  `tipo` char(50) NOT NULL,
  `fechaini` char(8) NOT NULL,
  `fechafin` char(8) NOT NULL,
  `idpntfun` int(10) unsigned NOT NULL,
  `funcionpnt` char(100) NOT NULL,
  `automat` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idpntopera`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pntopera`
--

/*!40000 ALTER TABLE `pntopera` DISABLE KEYS */;
INSERT INTO `pntopera` (`idpntopera`,`detalle`,`puntos`,`tabla`,`cmpfactor`,`tipo`,`fechaini`,`fechafin`,`idpntfun`,`funcionpnt`,`automat`) VALUES 
 (1,'Puntos por Total Facturado',10.00,'facturas','neto','double(13,2)','20240101','20241231',2,'FPNTMultiplo(10)','S'),
 (2,'REGLA SIN TABLA ASOCIADA',0.30,'facturas','numero','int(10) unsigned','20240101','',1,'FPNTMultiplo(1)','S'),
 (3,'DESCUENTO POR CONSUMO DE PUNTOS',1.00,'','','','20240101','',1,'FPNTMultiplo(1)','N');
/*!40000 ALTER TABLE `pntopera` ENABLE KEYS */;


--
-- Definition of table `pntpuntos`
--

DROP TABLE IF EXISTS `pntpuntos`;
CREATE TABLE `pntpuntos` (
  `idpuntos` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idpntopera` int(10) unsigned NOT NULL,
  `tabla` char(100) NOT NULL,
  `campo` char(100) NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `puntos` float(13,2) NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idpuntos`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pntpuntos`
--

/*!40000 ALTER TABLE `pntpuntos` DISABLE KEYS */;
INSERT INTO `pntpuntos` (`idpuntos`,`entidad`,`idpntopera`,`tabla`,`campo`,`id`,`fecha`,`puntos`,`detalle`) VALUES 
 (1,1,2,'','',0,'20240728',10.00,'Nuevo Registro para probar'),
 (3,1,1,'','',0,'20240728',-50.00,'RESTA'),
 (4,1,1,'','',0,'20240728',20.00,'Puesta a 0'),
 (5,1,1,'','',0,'20240728',3.00,'Gana puntos'),
 (21,282,2,'facturas','idfactura',13516,'20240706',8375.10,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1351'),
 (22,282,2,'facturas','idfactura',13517,'20240706',8375.40,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1351'),
 (24,1,1,'facturas','idfactura',13515,'20240531',4190.00,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1351'),
 (25,1,2,'facturas','idfactura',13515,'20240531',5394.90,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1351'),
 (26,1,1,'facturas','idfactura',13518,'20240823',8264.00,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1351'),
 (27,1,2,'facturas','idfactura',13518,'20240823',40.50,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1351'),
 (28,1,3,'facturas','idfactura',13519,'20240823',-10.00,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1351'),
 (29,1,3,'facturas','idfactura',13520,'20240823',-62.40,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1352'),
 (30,282,3,'facturas','idfactura',13521,'20240823',-750.00,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1352'),
 (31,1,3,'facturas','idfactura',13522,'20240823',-50.00,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1352'),
 (32,1,3,'facturas','idfactura',13523,'20240823',-750.00,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 1352'),
 (33,1,3,'facturas','idfactura',13524,'20240823',-13.00,'Registro Automatico - Tabla: facturas - Campo: idfactura - Id: 13524');
/*!40000 ALTER TABLE `pntpuntos` ENABLE KEYS */;


--
-- Definition of table `pntvalor`
--

DROP TABLE IF EXISTS `pntvalor`;
CREATE TABLE `pntvalor` (
  `idpntvalor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(254) NOT NULL,
  `valor` float(13,2) NOT NULL,
  `articulo` char(20) NOT NULL,
  PRIMARY KEY (`idpntvalor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pntvalor`
--

/*!40000 ALTER TABLE `pntvalor` DISABLE KEYS */;
INSERT INTO `pntvalor` (`idpntvalor`,`detalle`,`valor`,`articulo`) VALUES 
 (1,'PUNTOS EN PESOS',10.00,''),
 (2,'TERMOS NUEVOS',1000.00,'8228');
/*!40000 ALTER TABLE `pntvalor` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
