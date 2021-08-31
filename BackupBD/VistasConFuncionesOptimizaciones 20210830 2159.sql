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
-- Temporary table structure for view `bancosaldos1`
--
DROP TABLE IF EXISTS `bancosaldos1`;
DROP VIEW IF EXISTS `bancosaldos1`;
CREATE TABLE `bancosaldos1` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `idtipocta` int(10) unsigned,
  `idbanco` int(10) unsigned,
  `cbu` char(100),
  `banco` int(10) unsigned,
  `nombre` char(254),
  `filial` int(10) unsigned,
  `cp` char(50),
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `bancosegr1`
--
DROP TABLE IF EXISTS `bancosegr1`;
DROP VIEW IF EXISTS `bancosegr1`;
CREATE TABLE `bancosegr1` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `egresos` double(19,2)
);

--
-- Temporary table structure for view `bancosing1`
--
DROP TABLE IF EXISTS `bancosing1`;
DROP VIEW IF EXISTS `bancosing1`;
CREATE TABLE `bancosing1` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `ingresos` double(19,2)
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
-- Temporary table structure for view `ctactefact1`
--
DROP TABLE IF EXISTS `ctactefact1`;
DROP VIEW IF EXISTS `ctactefact1`;
CREATE TABLE `ctactefact1` (
  `entidad` int(10) unsigned,
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `ctactepagos1`
--
DROP TABLE IF EXISTS `ctactepagos1`;
DROP VIEW IF EXISTS `ctactepagos1`;
CREATE TABLE `ctactepagos1` (
  `entidad` int(10) unsigned,
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `ctacteprofact1`
--
DROP TABLE IF EXISTS `ctacteprofact1`;
DROP VIEW IF EXISTS `ctacteprofact1`;
CREATE TABLE `ctacteprofact1` (
  `entidad` int(10) unsigned,
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `ctacteprosaldo1`
--
DROP TABLE IF EXISTS `ctacteprosaldo1`;
DROP VIEW IF EXISTS `ctacteprosaldo1`;
CREATE TABLE `ctacteprosaldo1` (
  `entidad` int(11),
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `ctacterec1`
--
DROP TABLE IF EXISTS `ctacterec1`;
DROP VIEW IF EXISTS `ctacterec1`;
CREATE TABLE `ctacterec1` (
  `entidad` int(10) unsigned,
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `ctactesaldo1`
--
DROP TABLE IF EXISTS `ctactesaldo1`;
DROP VIEW IF EXISTS `ctactesaldo1`;
CREATE TABLE `ctactesaldo1` (
  `entidad` int(11),
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `factuprovesaldo1`
--
DROP TABLE IF EXISTS `factuprovesaldo1`;
DROP VIEW IF EXISTS `factuprovesaldo1`;
CREATE TABLE `factuprovesaldo1` (
  `idfactprov` int(10) unsigned,
  `cobrado` double(19,2),
  `saldof` double(19,2)
);

--
-- Temporary table structure for view `facturasaldo1`
--
DROP TABLE IF EXISTS `facturasaldo1`;
DROP VIEW IF EXISTS `facturasaldo1`;
CREATE TABLE `facturasaldo1` (
  `idfactura` int(10) unsigned,
  `cobrado` double(19,2),
  `saldof` double(19,2)
);

--
-- Temporary table structure for view `facturasctasaldo1`
--
DROP TABLE IF EXISTS `facturasctasaldo1`;
DROP VIEW IF EXISTS `facturasctasaldo1`;
CREATE TABLE `facturasctasaldo1` (
  `idcuotafc` int(10) unsigned,
  `cuota` int(10) unsigned,
  `idfactura` int(10) unsigned,
  `importe` double(13,2),
  `cobrado` double(19,2),
  `saldof` double(19,2),
  `entidad` int(10) unsigned
);

--
-- Temporary table structure for view `pagosprovsaldo1`
--
DROP TABLE IF EXISTS `pagosprovsaldo1`;
DROP VIEW IF EXISTS `pagosprovsaldo1`;
CREATE TABLE `pagosprovsaldo1` (
  `idcomproba` int(10) unsigned,
  `totimputado` double(19,2),
  `idpago` int(10) unsigned,
  `importe` double(13,2),
  `saldo` double(19,2)
);

--
-- Temporary table structure for view `recibossaldo1`
--
DROP TABLE IF EXISTS `recibossaldo1`;
DROP VIEW IF EXISTS `recibossaldo1`;
CREATE TABLE `recibossaldo1` (
  `idcomproba` int(10) unsigned,
  `totimputado` double(19,2),
  `totrecargo` double(19,2),
  `idrecibo` int(10) unsigned,
  `importe` double(13,2),
  `saldo` double(19,2)
);

--
-- Definition of function `_sqlcuenta`
--

DROP FUNCTION IF EXISTS `_sqlcuenta`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlcuenta`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlcuenta $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `_sqlentidad`
--

DROP FUNCTION IF EXISTS `_sqlentidad`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlentidad`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlentidad $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `_sqlidcuenta`
--

DROP FUNCTION IF EXISTS `_sqlidcuenta`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlidcuenta`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlidcuenta $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `_sqlidrecibo`
--

DROP FUNCTION IF EXISTS `_sqlidrecibo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlidrecibo`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlidrecibo $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `_sqlservicio`
--

DROP FUNCTION IF EXISTS `_sqlservicio`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlservicio`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlservicio $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `bancosaldos1`
--

DROP TABLE IF EXISTS `bancosaldos1`;
DROP VIEW IF EXISTS `bancosaldos1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosaldos1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,`c`.`idtipocta` AS `idtipocta`,`c`.`idbanco` AS `idbanco`,`c`.`cbu` AS `cbu`,`b`.`banco` AS `banco`,`b`.`nombre` AS `nombre`,`b`.`filial` AS `filial`,`b`.`cp` AS `cp`,(ifnull(`i`.`ingresos`,0) - ifnull(`e`.`egresos`,0)) AS `saldo` from (((`cajabancos` `c` left join `bancosing1` `i` on((`c`.`idcuenta` = `i`.`idcuenta`))) left join `bancosegr1` `e` on((`c`.`idcuenta` = `e`.`idcuenta`))) left join `bancos` `b` on((`b`.`idbanco` = `c`.`idbanco`))) where (`c`.`idcuenta` = `_sqlidcuenta`());

--
-- Definition of view `bancosegr1`
--

DROP TABLE IF EXISTS `bancosegr1`;
DROP VIEW IF EXISTS `bancosegr1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosegr1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `egresos` from (((`cajabancos` `c` left join `detallepagos` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`c`.`idcuenta` = `_sqlidcuenta`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `bancosing1`
--

DROP TABLE IF EXISTS `bancosing1`;
DROP VIEW IF EXISTS `bancosing1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosing1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `ingresos` from (((`cajabancos` `c` left join `detallecobros` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`c`.`idcuenta` = `_sqlidcuenta`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `cobrorecsertvw1`
--

DROP TABLE IF EXISTS `cobrorecsertvw1`;
DROP VIEW IF EXISTS `cobrorecsertvw1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrorecsertvw1` AS select `cobrosrecserview1`.`idrecibo` AS `idrecibo`,`cobrosrecserview1`.`fechareci` AS `fecha`,`cobrosrecserview1`.`totalreci` AS `imptotal`,`cobrosrecserview1`.`servicio` AS `servicio`,round(`cobrosrecserview1`.`imputado`,2) AS `imputado` from `cobrosrecserview1` where (`cobrosrecserview1`.`imputado` > 0) order by `cobrosrecserview1`.`idrecibo`,`cobrosrecserview1`.`servicio`;

--
-- Definition of view `cobrosrecfacview1`
--

DROP TABLE IF EXISTS `cobrosrecfacview1`;
DROP VIEW IF EXISTS `cobrosrecfacview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrosrecfacview1` AS select `c`.`idcomproba` AS `idcomproba`,`c`.`idregipago` AS `idrecibo`,`c`.`idfactura` AS `idfactura`,`c`.`imputado` AS `imputado`,`c`.`recargo` AS `recargo`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,`f`.`apellido` AS `apellido`,`f`.`nombre` AS `nombre`,`f`.`fecha` AS `fechafac`,`f`.`pventa` AS `pventa`,`f`.`tipo` AS `tipo`,`f`.`numero` AS `numero`,`f`.`total` AS `totalfact`,`r`.`fecha` AS `fechareci`,`r`.`importe` AS `totalreci` from ((((`cobros` `c` left join `facturas` `f` on((`f`.`idfactura` = `c`.`idfactura`))) left join `recibos` `r` on((`c`.`idregipago` = `r`.`idrecibo`))) left join `comprobantes` `p` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`tabla` = 'recibos') and (`r`.`idrecibo` = `u`.`id`)))) where ((`c`.`idregipago` = `_sqlidrecibo`()) and (`p`.`tabla` = 'recibos') and (`u`.`idestador` <> 2));

--
-- Definition of view `cobrosrecserview1`
--

DROP TABLE IF EXISTS `cobrosrecserview1`;
DROP VIEW IF EXISTS `cobrosrecserview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrosrecserview1` AS select `cobrosrecfacview1`.`idrecibo` AS `idrecibo`,`cobrosrecfacview1`.`servicio` AS `servicio`,sum(`cobrosrecfacview1`.`imputado`) AS `imputado`,`cobrosrecfacview1`.`totalreci` AS `totalreci`,`cobrosrecfacview1`.`fechareci` AS `fechareci` from `cobrosrecfacview1` where (`cobrosrecfacview1`.`idrecibo` = `_sqlidrecibo`()) group by `cobrosrecfacview1`.`idrecibo`,`cobrosrecfacview1`.`servicio` union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,`r`.`importe` AS `importe`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from `recibos` `r` where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and (not(`r`.`idrecibo` in (select `cobrosrecfacview1`.`idrecibo` from `cobrosrecfacview1`))))) union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,(`r`.`importe` - sum(`cv`.`imputado`)) AS `imputado`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from (`recibos` `r` left join `cobrosrecfacview1` `cv` on((`cv`.`idrecibo` = `r`.`idrecibo`))) where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and `r`.`idrecibo` in (select `cobrosrecfacview1`.`idrecibo` from `cobrosrecfacview1`)) group by `r`.`idrecibo`);

--
-- Definition of view `ctactefact1`
--

DROP TABLE IF EXISTS `ctactefact1`;
DROP VIEW IF EXISTS `ctactefact1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactefact1` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from ((`facturas` `f` left join `comprobantes` `c` on((`f`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`f`.`entidad` = `_sqlentidad`()) and (`t`.`ctacte` = 'S') and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`entidad`;

--
-- Definition of view `ctactepagos1`
--

DROP TABLE IF EXISTS `ctactepagos1`;
DROP VIEW IF EXISTS `ctactepagos1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactepagos1` AS select `p`.`entidad` AS `entidad`,sum((`p`.`importe` * `t`.`opera`)) AS `saldo` from ((`pagosprov` `p` left join `comprobantes` `c` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`p`.`entidad` = `_sqlentidad`()) and (`t`.`ctacte` = 'S') and (not(`p`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`idestador` = 2)))))) group by `p`.`entidad`;

--
-- Definition of view `ctacteprofact1`
--

DROP TABLE IF EXISTS `ctacteprofact1`;
DROP VIEW IF EXISTS `ctacteprofact1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacteprofact1` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from (`factuprove` `f` left join `tipocompro` `t` on((`f`.`idtipocompro` = `t`.`idtipocompro`))) where (`f`.`entidad` = `_sqlentidad`()) group by `f`.`entidad`;

--
-- Definition of view `ctacteprosaldo1`
--

DROP TABLE IF EXISTS `ctacteprosaldo1`;
DROP VIEW IF EXISTS `ctacteprosaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacteprosaldo1` AS select `e`.`entidad` AS `entidad`,(ifnull(`fac`.`saldo`,0) + ifnull(`pag`.`saldo`,0)) AS `saldo` from ((`entidades` `e` left join `ctacteprofact1` `fac` on((`e`.`entidad` = `fac`.`entidad`))) left join `ctactepagos1` `pag` on((`e`.`entidad` = `pag`.`entidad`))) where (`e`.`entidad` = `_sqlentidad`());

--
-- Definition of view `ctacterec1`
--

DROP TABLE IF EXISTS `ctacterec1`;
DROP VIEW IF EXISTS `ctacterec1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacterec1` AS select `r`.`entidad` AS `entidad`,sum(((`r`.`importe` - `rs`.`totrecargo`) * `t`.`opera`)) AS `saldo` from (((`recibos` `r` left join `comprobantes` `c` on((`r`.`idcomproba` = `c`.`idcomproba`))) left join `recibossaldo1` `rs` on((`rs`.`idrecibo` = `r`.`idrecibo`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`r`.`entidad` = `_sqlentidad`()) and (`t`.`ctacte` = 'S') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`entidad`;

--
-- Definition of view `ctactesaldo1`
--

DROP TABLE IF EXISTS `ctactesaldo1`;
DROP VIEW IF EXISTS `ctactesaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactesaldo1` AS select `e`.`entidad` AS `entidad`,(ifnull(`fac`.`saldo`,0) + ifnull(`rec`.`saldo`,0)) AS `saldo` from ((`entidades` `e` left join `ctactefact1` `fac` on((`e`.`entidad` = `fac`.`entidad`))) left join `ctacterec1` `rec` on((`e`.`entidad` = `rec`.`entidad`))) where (`e`.`entidad` = `_sqlentidad`());

--
-- Definition of view `factuprovesaldo1`
--

DROP TABLE IF EXISTS `factuprovesaldo1`;
DROP VIEW IF EXISTS `factuprovesaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `factuprovesaldo1` AS select `f`.`idfactprove` AS `idfactprov`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`factuprove` `f` left join `pagosprovfc` `c` on((`f`.`idfactprove` = `c`.`idfactprove`))) where (`f`.`entidad` = `_sqlentidad`()) group by `f`.`idfactprove`;

--
-- Definition of view `facturasaldo1`
--

DROP TABLE IF EXISTS `facturasaldo1`;
DROP VIEW IF EXISTS `facturasaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasaldo1` AS select `f`.`idfactura` AS `idfactura`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) where ((`f`.`entidad` = `_sqlentidad`()) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idfactura`;

--
-- Definition of view `facturasctasaldo1`
--

DROP TABLE IF EXISTS `facturasctasaldo1`;
DROP VIEW IF EXISTS `facturasctasaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasctasaldo1` AS select `f`.`idcuotafc` AS `idcuotafc`,`f`.`cuota` AS `cuota`,`f`.`idfactura` AS `idfactura`,`f`.`importe` AS `importe`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldof`,`a`.`entidad` AS `entidad` from ((`facturascta` `f` left join `cobros` `c` on((`f`.`idcuotafc` = `c`.`idcuotafc`))) left join `facturas` `a` on((`a`.`idfactura` = `f`.`idfactura`))) where ((`a`.`entidad` = `_sqlentidad`()) and (not(`f`.`idcuotafc` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturascta') and (`ultimoestado`.`campo` = 'idcuotafc') and (`ultimoestado`.`idestador` = 2))))) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idcuotafc`;

--
-- Definition of view `pagosprovsaldo1`
--

DROP TABLE IF EXISTS `pagosprovsaldo1`;
DROP VIEW IF EXISTS `pagosprovsaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagosprovsaldo1` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,`r`.`idpago` AS `idpago`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`pagosprov` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `pagosprovfc` `c` on((`r`.`idpago` = `c`.`idpago`))) where ((`r`.`entidad` = `_sqlentidad`()) and (`cp`.`tabla` = 'pagosprov') and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idpago`;

--
-- Definition of view `recibossaldo1`
--

DROP TABLE IF EXISTS `recibossaldo1`;
DROP VIEW IF EXISTS `recibossaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldo1` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`idrecibo` AS `idrecibo`,`r`.`importe` AS `importe`,((`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) - ifnull(sum(`c`.`recargo`),0)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on((`r`.`idrecibo` = `c`.`idregipago`))) where ((`r`.`entidad` = `_sqlentidad`()) and (`cp`.`tabla` = 'recibos') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
