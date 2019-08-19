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
-- Create schema processar
--

CREATE DATABASE IF NOT EXISTS processar;
USE processar;

--
-- Definition of table `asientoscompro`
--

DROP TABLE IF EXISTS `asientoscompro`;
CREATE TABLE `asientoscompro` (
  `idastocompro` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idasiento` int(10) unsigned NOT NULL DEFAULT '0',
  `idregicomp` int(10) unsigned NOT NULL DEFAULT '0',
  `tabla` char(100) NOT NULL,
  PRIMARY KEY (`idastocompro`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asientoscompro`
--

/*!40000 ALTER TABLE `asientoscompro` DISABLE KEYS */;
INSERT INTO `asientoscompro` (`idastocompro`,`idasiento`,`idregicomp`,`tabla`) VALUES 
 (2,2,3,'facturas'),
 (16,33,2,'facturas');
/*!40000 ALTER TABLE `asientoscompro` ENABLE KEYS */;


--
-- Definition of table `tablasautoinc`
--

DROP TABLE IF EXISTS `tablasautoinc`;
CREATE TABLE `tablasautoinc` (
  `tabla` char(50) NOT NULL,
  `defautoinc` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`tabla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tablasautoinc`
--

/*!40000 ALTER TABLE `tablasautoinc` DISABLE KEYS */;
INSERT INTO `tablasautoinc` (`tabla`,`defautoinc`) VALUES 
 ('asientos',11);
/*!40000 ALTER TABLE `tablasautoinc` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
