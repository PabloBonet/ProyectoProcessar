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
-- Create schema processar_krumbeinsa
--

CREATE DATABASE IF NOT EXISTS processar_krumbeinsa;
USE processar_krumbeinsa;

--
-- Definition of table `pntvoucher`
--

DROP TABLE IF EXISTS `pntvoucher`;
CREATE TABLE `pntvoucher` (
  `idpntvou` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `nombre` char(150) NOT NULL,
  `puntos` float(13,2) NOT NULL,
  `importe` float(13,2) NOT NULL,
  `idpntvalor` int(10) unsigned NOT NULL,
  `entidadre` int(10) unsigned NOT NULL,
  `fechare` char(8) NOT NULL,
  `usuario` char(30) NOT NULL,
  `fechaven` char(8) NOT NULL,
  `observa` char(200) NOT NULL,
  PRIMARY KEY (`idpntvou`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pntvoucher`
--

/*!40000 ALTER TABLE `pntvoucher` DISABLE KEYS */;
INSERT INTO `pntvoucher` (`idpntvou`,`idcomproba`,`pventa`,`numero`,`fecha`,`entidad`,`nombre`,`puntos`,`importe`,`idpntvalor`,`entidadre`,`fechare`,`usuario`,`fechaven`,`observa`) VALUES 
 (1,48,3,4,'20250220',4,'CENTRO SOCIAL SARMIENTO',25000.00,12500.00,2,7,'20250220','','',''),
 (2,48,3,5,'20250220',4,'CENTRO SOCIAL SARMIENTO',4000.00,2000.00,2,4,'20250101','','20250101','PROBAMOS'),
 (3,48,3,9,'20250224',127,'KRUMBEIN BRUNO',100000.00,50000.00,2,0,'','TULIO','20250425','');
/*!40000 ALTER TABLE `pntvoucher` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
