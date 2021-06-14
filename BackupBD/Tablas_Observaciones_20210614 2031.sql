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
-- Definition of table `observacomp`
--

DROP TABLE IF EXISTS `observacomp`;
CREATE TABLE `observacomp` (
  `idobscomp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tabla` char(100) NOT NULL,
  `observa` char(250) NOT NULL,
  `detalle` char(250) NOT NULL,
  PRIMARY KEY (`idobscomp`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `observacomp`
--

/*!40000 ALTER TABLE `observacomp` DISABLE KEYS */;
INSERT INTO `observacomp` (`idobscomp`,`tabla`,`observa`,`detalle`) VALUES 
 (1,'facturas','El crédito fiscal discriminado en el presente comprobante, sólo podrá ser computado a efectos del Régimen de Sostenimiento e Inclusión Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618','Filtro Monotributista FACTURA A'),
 (2,'facturas','El crédito fiscal discriminado en el presente comprobante, sólo podrá ser computado a efectos del Régimen de Sostenimiento e Inclusión Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618','Filtro Monotributista NOTA DEBITO A'),
 (3,'facturas','El crédito fiscal discriminado en el presente comprobante, sólo podrá ser computado a efectos del Régimen de Sostenimiento e Inclusión Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618','Filtro Monotributista NOTA CREDITO A');
/*!40000 ALTER TABLE `observacomp` ENABLE KEYS */;


--
-- Definition of table `observacond`
--

DROP TABLE IF EXISTS `observacond`;
CREATE TABLE `observacond` (
  `idobscond` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idobscomp` int(10) unsigned NOT NULL,
  `tabla` char(100) NOT NULL,
  `campo` char(100) NOT NULL,
  `tipo` char(10) NOT NULL,
  `valord` char(50) NOT NULL,
  `compara` char(10) NOT NULL,
  `valorh` char(50) NOT NULL,
  PRIMARY KEY (`idobscond`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `observacond`
--

/*!40000 ALTER TABLE `observacond` DISABLE KEYS */;
INSERT INTO `observacond` (`idobscond`,`idobscomp`,`tabla`,`campo`,`tipo`,`valord`,`compara`,`valorh`) VALUES 
 (1,1,'facturas','idcomproba','int(10) un','1','Igual',''),
 (2,1,'facturas','iva','int(10) un','2','Igual',''),
 (3,2,'facturas','idcomproba','int(10) un','8','Igual',''),
 (4,3,'facturas','idcomproba','int(10) un','9','Igual',''),
 (5,2,'facturas','iva','int(10) un','2','Igual',''),
 (6,3,'facturas','iva','int(10) un','2','Igual','');
/*!40000 ALTER TABLE `observacond` ENABLE KEYS */;


--
-- Definition of table `observareg`
--

DROP TABLE IF EXISTS `observareg`;
CREATE TABLE `observareg` (
  `idobsreg` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idregistro` int(10) unsigned NOT NULL,
  `campo` char(100) NOT NULL,
  `tabla` char(100) NOT NULL,
  `observa` char(250) NOT NULL,
  PRIMARY KEY (`idobsreg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `observareg`
--

/*!40000 ALTER TABLE `observareg` DISABLE KEYS */;
/*!40000 ALTER TABLE `observareg` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
