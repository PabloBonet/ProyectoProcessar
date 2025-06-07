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
-- Create schema prueba_horlit
--

CREATE DATABASE IF NOT EXISTS prueba_horlit;
USE prueba_horlit;

--
-- Temporary table structure for view `facturapendrem`
--
DROP TABLE IF EXISTS `facturapendrem`;
DROP VIEW IF EXISTS `facturapendrem`;
CREATE TABLE `facturapendrem` (
  `idfacturah` int(11) unsigned,
  `idfactura` int(11) unsigned,
  `articulo` char(50),
  `cantfact` double(13,2),
  `cantrem` double(19,2),
  `pendrem` double(19,2)
);

--
-- Temporary table structure for view `facturaspendremax`
--
DROP TABLE IF EXISTS `facturaspendremax`;
DROP VIEW IF EXISTS `facturaspendremax`;
CREATE TABLE `facturaspendremax` (
  `idfacturah` int(11) unsigned,
  `idfactura` int(11) unsigned,
  `articulo` char(50),
  `cantfact` double(13,2),
  `cantrem` double(19,2),
  `pendrem` double(19,2)
);

--
-- Temporary table structure for view `remitopendfact`
--
DROP TABLE IF EXISTS `remitopendfact`;
DROP VIEW IF EXISTS `remitopendfact`;
CREATE TABLE `remitopendfact` (
  `idremitoh` int(11) unsigned,
  `idremito` int(11) unsigned,
  `articulo` char(50),
  `cantrem` double(13,2),
  `cantfact` double(19,2),
  `pendfact` double(19,2)
);

--
-- Temporary table structure for view `remitospendfactax`
--
DROP TABLE IF EXISTS `remitospendfactax`;
DROP VIEW IF EXISTS `remitospendfactax`;
CREATE TABLE `remitospendfactax` (
  `idremitoh` int(11) unsigned,
  `idremito` int(11) unsigned,
  `articulo` char(50),
  `cantrem` double(13,2),
  `cantfact` double(19,2),
  `pendfact` double(19,2)
);

--
-- Definition of view `facturapendrem`
--

DROP TABLE IF EXISTS `facturapendrem`;
DROP VIEW IF EXISTS `facturapendrem`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturapendrem` AS select `facturaspendremax`.`idfacturah` AS `idfacturah`,`facturaspendremax`.`idfactura` AS `idfactura`,`facturaspendremax`.`articulo` AS `articulo`,`facturaspendremax`.`cantfact` AS `cantfact`,sum(`facturaspendremax`.`cantrem`) AS `cantrem`,(`facturaspendremax`.`cantfact` - sum(`facturaspendremax`.`cantrem`)) AS `pendrem` from `facturaspendremax` group by `facturaspendremax`.`idfacturah`,`facturaspendremax`.`articulo`;

--
-- Definition of view `facturaspendremax`
--

DROP TABLE IF EXISTS `facturaspendremax`;
DROP VIEW IF EXISTS `facturaspendremax`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturaspendremax` AS select `d`.`idfacturah` AS `idfacturah`,`d`.`idfactura` AS `idfactura`,`d`.`articulo` AS `articulo`,`d`.`cantidad` AS `cantfact`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantrem`,(`d`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendrem` from ((`detafactu` `d` left join `linkregistro` `l` on(((`l`.`tablab` = 'detafactu') and (`l`.`idb` = `d`.`idfacturah`)))) left join `remitosh` `h` on(((`l`.`tablaa` = 'remitosh') and (`h`.`idremitoh` = `l`.`ida`)))) group by `d`.`idfacturah`,`d`.`articulo` union select `d`.`idfacturah` AS `idfacturah`,`d`.`idfactura` AS `idfactura`,`d`.`articulo` AS `articulo`,`d`.`cantidad` AS `cantfact`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantrem`,(`d`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendrem` from ((`detafactu` `d` left join `linkregistro` `l` on(((`l`.`tablaa` = 'detafactu') and (`l`.`ida` = `d`.`idfacturah`)))) left join `remitosh` `h` on(((`l`.`tablab` = 'remitosh') and (`h`.`idremitoh` = `l`.`idb`)))) group by `d`.`idfacturah`,`d`.`articulo`;

--
-- Definition of view `remitopendfact`
--

DROP TABLE IF EXISTS `remitopendfact`;
DROP VIEW IF EXISTS `remitopendfact`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `remitopendfact` AS select `remitospendfactax`.`idremitoh` AS `idremitoh`,`remitospendfactax`.`idremito` AS `idremito`,`remitospendfactax`.`articulo` AS `articulo`,`remitospendfactax`.`cantrem` AS `cantrem`,sum(`remitospendfactax`.`cantfact`) AS `cantfact`,(`remitospendfactax`.`cantrem` - sum(`remitospendfactax`.`cantfact`)) AS `pendfact` from `remitospendfactax` group by `remitospendfactax`.`idremitoh`,`remitospendfactax`.`articulo`;

--
-- Definition of view `remitospendfactax`
--

DROP TABLE IF EXISTS `remitospendfactax`;
DROP VIEW IF EXISTS `remitospendfactax`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `remitospendfactax` AS select `h`.`idremitoh` AS `idremitoh`,`h`.`idremito` AS `idremito`,`h`.`articulo` AS `articulo`,`h`.`cantidad` AS `cantrem`,sum(ifnull(`d`.`cantidad`,0.00)) AS `cantfact`,(`h`.`cantidad` - sum(ifnull(`d`.`cantidad`,0.00))) AS `pendfact` from ((`remitosh` `h` left join `linkregistro` `l` on(((`l`.`tablab` = 'remitosh') and (`l`.`idb` = `h`.`idremitoh`)))) left join `detafactu` `d` on(((`l`.`tablaa` = 'detafactu') and (`d`.`idfacturah` = `l`.`ida`)))) group by `h`.`idremito`,`h`.`articulo` union select `h`.`idremitoh` AS `idremitoh`,`h`.`idremito` AS `idremito`,`h`.`articulo` AS `articulo`,`h`.`cantidad` AS `cantrem`,sum(ifnull(`d`.`cantidad`,0.00)) AS `cantfact`,(`h`.`cantidad` - sum(ifnull(`d`.`cantidad`,0.00))) AS `pendfact` from ((`remitosh` `h` left join `linkregistro` `l` on(((`l`.`tablaa` = 'remitosh') and (`l`.`ida` = `h`.`idremitoh`)))) left join `detafactu` `d` on(((`l`.`tablab` = 'detafactu') and (`d`.`idfacturah` = `l`.`idb`)))) group by `h`.`idremito`,`h`.`articulo`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
