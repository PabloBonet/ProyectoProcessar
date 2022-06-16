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
-- Create schema processard
--

CREATE DATABASE IF NOT EXISTS processard;
USE processard;

--
-- Definition of table `otpresupu`
--

DROP TABLE IF EXISTS `otpresupu`;
CREATE TABLE `otpresupu` (
  `idotpresu` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idot` int(10) unsigned NOT NULL,
  `idpresupu` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idotpresu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otpresupu`
--

/*!40000 ALTER TABLE `otpresupu` DISABLE KEYS */;
/*!40000 ALTER TABLE `otpresupu` ENABLE KEYS */;


--
-- Definition of table `presupu`
--

DROP TABLE IF EXISTS `presupu`;
CREATE TABLE `presupu` (
  `idpresupu` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL DEFAULT '0',
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `nombre` char(254) NOT NULL,
  `transporte` int(10) unsigned NOT NULL DEFAULT '0',
  `nombretran` char(254) NOT NULL DEFAULT '',
  `observa` char(254) NOT NULL DEFAULT '',
  `sector` int(10) unsigned NOT NULL DEFAULT '0',
  `vendedor` int(10) unsigned NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaentre` char(8) NOT NULL,
  `hora` char(8) NOT NULL,
  `usuario` char(15) NOT NULL,
  `idtiponp` int(10) unsigned NOT NULL,
  `puntov` char(4) NOT NULL,
  PRIMARY KEY (`idpresupu`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presupu`
--

/*!40000 ALTER TABLE `presupu` DISABLE KEYS */;
/*!40000 ALTER TABLE `presupu` ENABLE KEYS */;


--
-- Definition of table `presupuh`
--

DROP TABLE IF EXISTS `presupuh`;
CREATE TABLE `presupuh` (
  `idpresupu` int(10) unsigned NOT NULL,
  `idpresupuh` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idtipoot` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `cantidad` double(13,2) NOT NULL,
  `unidad` char(50) NOT NULL,
  `cantidadfc` char(50) NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `unidadfc` char(50) NOT NULL,
  `unitario` double(13,2) NOT NULL,
  `observa` char(254) NOT NULL,
  `fechaentre` char(8) NOT NULL,
  `impuestos` double(13,2) NOT NULL,
  `razonimp` double(13,2) NOT NULL,
  `neto` double(13,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idtiponp` int(10) unsigned NOT NULL,
  `total` double(13,2) NOT NULL,
  `impuesto` double(13,2) NOT NULL,
  `imprimir` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idpresupuh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presupuh`
--

/*!40000 ALTER TABLE `presupuh` DISABLE KEYS */;
/*!40000 ALTER TABLE `presupuh` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
