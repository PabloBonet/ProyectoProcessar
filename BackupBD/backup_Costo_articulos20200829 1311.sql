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
-- Temporary table structure for view `ultimoartcosto`
--
DROP TABLE IF EXISTS `ultimoartcosto`;
DROP VIEW IF EXISTS `ultimoartcosto`;
CREATE TABLE `ultimoartcosto` (
  `idartcosto` int(10) unsigned,
  `articulo` char(50),
  `costo` float(13,4),
  `fecha` char(16)
);

--
-- Definition of table `articostos`
--

DROP TABLE IF EXISTS `articostos`;
CREATE TABLE `articostos` (
  `idartcosto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `articulo` char(50) NOT NULL,
  `costo` float(13,4) NOT NULL,
  `fecha` char(16) NOT NULL,
  PRIMARY KEY (`idartcosto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articostos`
--

/*!40000 ALTER TABLE `articostos` DISABLE KEYS */;
/*!40000 ALTER TABLE `articostos` ENABLE KEYS */;


--
-- Definition of view `ultimoartcosto`
--

DROP TABLE IF EXISTS `ultimoartcosto`;
DROP VIEW IF EXISTS `ultimoartcosto`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultimoartcosto` AS select max(`a`.`idartcosto`) AS `idartcosto`,`a`.`articulo` AS `articulo`,`a`.`costo` AS `costo`,`a`.`fecha` AS `fecha` from `articostos` `a` group by `a`.`articulo`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
