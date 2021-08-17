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
-- Temporary table structure for view `cobrorecsertvw`
--
DROP TABLE IF EXISTS `cobrorecsertvw`;
DROP VIEW IF EXISTS `cobrorecsertvw`;
CREATE TABLE `cobrorecsertvw` (
  `idrecibo` int(11) unsigned,
  `fecha` char(8),
  `imptotal` double(13,2),
  `servicio` bigint(20) unsigned,
  `imputado` double(19,2)
);

--
-- Temporary table structure for view `cobrorecsertvw1`
--
DROP TABLE IF EXISTS `cobrorecsertvw1`;
DROP VIEW IF EXISTS `cobrorecsertvw1`;
CREATE TABLE `cobrorecsertvw1` (
  `idrecibo` int(11) unsigned,
  `fecha` char(8),
  `imptotal` double(13,2),
  `servicio` bigint(20) unsigned,
  `imputado` double(19,2)
);

--
-- Temporary table structure for view `cobrosrecfacview`
--
DROP TABLE IF EXISTS `cobrosrecfacview`;
DROP VIEW IF EXISTS `cobrosrecfacview`;
CREATE TABLE `cobrosrecfacview` (
  `idcomproba` int(10) unsigned,
  `idrecibo` int(10) unsigned,
  `idfactura` int(10) unsigned,
  `imputado` double(13,2),
  `recargo` double(13,2),
  `entidad` int(10) unsigned,
  `servicio` int(10) unsigned,
  `cuenta` int(10) unsigned,
  `apellido` char(254),
  `nombre` char(254),
  `fechafac` char(8),
  `pventa` int(10) unsigned,
  `tipo` char(1),
  `numero` int(10) unsigned,
  `totalfact` double(13,2),
  `fechareci` char(8),
  `totalreci` double(13,2)
);

--
-- Temporary table structure for view `cobrosrecfacview1`
--
DROP TABLE IF EXISTS `cobrosrecfacview1`;
DROP VIEW IF EXISTS `cobrosrecfacview1`;
CREATE TABLE `cobrosrecfacview1` (
  `idcomproba` int(10) unsigned,
  `idrecibo` int(10) unsigned,
  `idfactura` int(10) unsigned,
  `imputado` double(13,2),
  `recargo` double(13,2),
  `entidad` int(10) unsigned,
  `servicio` int(10) unsigned,
  `cuenta` int(10) unsigned,
  `apellido` char(254),
  `nombre` char(254),
  `fechafac` char(8),
  `pventa` int(10) unsigned,
  `tipo` char(1),
  `numero` int(10) unsigned,
  `totalfact` double(13,2),
  `fechareci` char(8),
  `totalreci` double(13,2)
);

--
-- Temporary table structure for view `cobrosrecserview`
--
DROP TABLE IF EXISTS `cobrosrecserview`;
DROP VIEW IF EXISTS `cobrosrecserview`;
CREATE TABLE `cobrosrecserview` (
  `idrecibo` int(11) unsigned,
  `servicio` bigint(20) unsigned,
  `imputado` double,
  `totalreci` double(13,2),
  `fechareci` char(8)
);

--
-- Temporary table structure for view `cobrosrecserview1`
--
DROP TABLE IF EXISTS `cobrosrecserview1`;
DROP VIEW IF EXISTS `cobrosrecserview1`;
CREATE TABLE `cobrosrecserview1` (
  `idrecibo` int(11) unsigned,
  `servicio` bigint(20) unsigned,
  `imputado` double,
  `totalreci` double(13,2),
  `fechareci` char(8)
);

--
-- Definition of function `_sqlidrecibo`
--

DROP FUNCTION IF EXISTS `_sqlidrecibo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`processaradmin`@`%` FUNCTION `_sqlidrecibo`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlidrecibo $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `cobrorecsertvw`
--

DROP TABLE IF EXISTS `cobrorecsertvw`;
DROP VIEW IF EXISTS `cobrorecsertvw`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `cobrorecsertvw` AS select `cobrosrecserview`.`idrecibo` AS `idrecibo`,`cobrosrecserview`.`fechareci` AS `fecha`,`cobrosrecserview`.`totalreci` AS `imptotal`,`cobrosrecserview`.`servicio` AS `servicio`,round(`cobrosrecserview`.`imputado`,2) AS `imputado` from `cobrosrecserview` where (`cobrosrecserview`.`imputado` > 0) order by `cobrosrecserview`.`idrecibo`,`cobrosrecserview`.`servicio`;

--
-- Definition of view `cobrorecsertvw1`
--

DROP TABLE IF EXISTS `cobrorecsertvw1`;
DROP VIEW IF EXISTS `cobrorecsertvw1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `cobrorecsertvw1` AS select `cobrosrecserview1`.`idrecibo` AS `idrecibo`,`cobrosrecserview1`.`fechareci` AS `fecha`,`cobrosrecserview1`.`totalreci` AS `imptotal`,`cobrosrecserview1`.`servicio` AS `servicio`,round(`cobrosrecserview1`.`imputado`,2) AS `imputado` from `cobrosrecserview1` where (`cobrosrecserview1`.`imputado` > 0) order by `cobrosrecserview1`.`idrecibo`,`cobrosrecserview1`.`servicio`;

--
-- Definition of view `cobrosrecfacview`
--

DROP TABLE IF EXISTS `cobrosrecfacview`;
DROP VIEW IF EXISTS `cobrosrecfacview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `cobrosrecfacview` AS select `c`.`idcomproba` AS `idcomproba`,`c`.`idregipago` AS `idrecibo`,`c`.`idfactura` AS `idfactura`,`c`.`imputado` AS `imputado`,`c`.`recargo` AS `recargo`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,`f`.`apellido` AS `apellido`,`f`.`nombre` AS `nombre`,`f`.`fecha` AS `fechafac`,`f`.`pventa` AS `pventa`,`f`.`tipo` AS `tipo`,`f`.`numero` AS `numero`,`f`.`total` AS `totalfact`,`r`.`fecha` AS `fechareci`,`r`.`importe` AS `totalreci` from ((((`cobros` `c` left join `facturas` `f` on((`f`.`idfactura` = `c`.`idfactura`))) left join `recibos` `r` on((`c`.`idregipago` = `r`.`idrecibo`))) left join `comprobantes` `p` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`tabla` = 'recibos') and (`r`.`idrecibo` = `u`.`id`)))) where ((`p`.`tabla` = 'recibos') and (`u`.`idestador` <> 2));

--
-- Definition of view `cobrosrecfacview1`
--

DROP TABLE IF EXISTS `cobrosrecfacview1`;
DROP VIEW IF EXISTS `cobrosrecfacview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `cobrosrecfacview1` AS select `c`.`idcomproba` AS `idcomproba`,`c`.`idregipago` AS `idrecibo`,`c`.`idfactura` AS `idfactura`,`c`.`imputado` AS `imputado`,`c`.`recargo` AS `recargo`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,`f`.`apellido` AS `apellido`,`f`.`nombre` AS `nombre`,`f`.`fecha` AS `fechafac`,`f`.`pventa` AS `pventa`,`f`.`tipo` AS `tipo`,`f`.`numero` AS `numero`,`f`.`total` AS `totalfact`,`r`.`fecha` AS `fechareci`,`r`.`importe` AS `totalreci` from ((((`cobros` `c` left join `facturas` `f` on((`f`.`idfactura` = `c`.`idfactura`))) left join `recibos` `r` on((`c`.`idregipago` = `r`.`idrecibo`))) left join `comprobantes` `p` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`tabla` = 'recibos') and (`r`.`idrecibo` = `u`.`id`)))) where ((`c`.`idregipago` = `_sqlidrecibo`()) and (`p`.`tabla` = 'recibos') and (`u`.`idestador` <> 2));

--
-- Definition of view `cobrosrecserview`
--

DROP TABLE IF EXISTS `cobrosrecserview`;
DROP VIEW IF EXISTS `cobrosrecserview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `cobrosrecserview` AS select `cobrosrecfacview`.`idrecibo` AS `idrecibo`,`cobrosrecfacview`.`servicio` AS `servicio`,sum(`cobrosrecfacview`.`imputado`) AS `imputado`,`cobrosrecfacview`.`totalreci` AS `totalreci`,`cobrosrecfacview`.`fechareci` AS `fechareci` from `cobrosrecfacview` group by `cobrosrecfacview`.`idrecibo`,`cobrosrecfacview`.`servicio` union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,`r`.`importe` AS `importe`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from `recibos` `r` where ((not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and (not(`r`.`idrecibo` in (select `cobrosrecfacview`.`idrecibo` from `cobrosrecfacview`))))) union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,(`r`.`importe` - sum(`cv`.`imputado`)) AS `imputado`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from (`recibos` `r` left join `cobrosrecfacview` `cv` on((`cv`.`idrecibo` = `r`.`idrecibo`))) where ((not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and `r`.`idrecibo` in (select `cobrosrecfacview`.`idrecibo` from `cobrosrecfacview`)) group by `r`.`idrecibo`);

--
-- Definition of view `cobrosrecserview1`
--

DROP TABLE IF EXISTS `cobrosrecserview1`;
DROP VIEW IF EXISTS `cobrosrecserview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `cobrosrecserview1` AS select `cobrosrecfacview1`.`idrecibo` AS `idrecibo`,`cobrosrecfacview1`.`servicio` AS `servicio`,sum(`cobrosrecfacview1`.`imputado`) AS `imputado`,`cobrosrecfacview1`.`totalreci` AS `totalreci`,`cobrosrecfacview1`.`fechareci` AS `fechareci` from `cobrosrecfacview1` where (`cobrosrecfacview1`.`idrecibo` = `_sqlidrecibo`()) group by `cobrosrecfacview1`.`idrecibo`,`cobrosrecfacview1`.`servicio` union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,`r`.`importe` AS `importe`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from `recibos` `r` where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and (not(`r`.`idrecibo` in (select `cobrosrecfacview1`.`idrecibo` from `cobrosrecfacview1`))))) union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,(`r`.`importe` - sum(`cv`.`imputado`)) AS `imputado`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from (`recibos` `r` left join `cobrosrecfacview1` `cv` on((`cv`.`idrecibo` = `r`.`idrecibo`))) where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and `r`.`idrecibo` in (select `cobrosrecfacview1`.`idrecibo` from `cobrosrecfacview1`)) group by `r`.`idrecibo`);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
