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
-- Temporary table structure for view `facturasaldof`
--
DROP TABLE IF EXISTS `facturasaldof`;
DROP VIEW IF EXISTS `facturasaldof`;
CREATE TABLE `facturasaldof` (
  `idfactura` int(10) unsigned,
  `entidad` int(10) unsigned,
  `servicio` int(10) unsigned,
  `cuenta` int(10) unsigned,
  `nombre` varchar(509),
  `total` double(13,2),
  `cobrado` double(19,2),
  `saldof` double(19,2),
  `imputado` double(19,2),
  `fechafac` char(8),
  `fechacob` char(8),
  `idregipago` int(10) unsigned,
  `idrecibo` int(10) unsigned,
  `totrecibo` double(13,2),
  `idnc` int(10) unsigned,
  `fechanc` char(8),
  `totnc` double(13,2),
  `opera` int(11),
  `idcomproba` int(10) unsigned,
  `comprobab` char(100),
  `detaservi` varchar(100),
  `idcomprof` int(10) unsigned,
  `comprobaa` char(100),
  `fopera` int(11)
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
-- Temporary table structure for view `recibossaldof`
--
DROP TABLE IF EXISTS `recibossaldof`;
DROP VIEW IF EXISTS `recibossaldof`;
CREATE TABLE `recibossaldof` (
  `idcomproba` int(10) unsigned,
  `idrecibo` int(10) unsigned,
  `numero` int(10) unsigned,
  `entidad` int(10) unsigned,
  `nombre` varchar(509),
  `totimputado` double(19,2),
  `totrecargo` double(19,2),
  `importe` double(13,2),
  `saldo` double(19,2),
  `fecha` char(8),
  `idcobro` int(10) unsigned,
  `idfactura` int(10) unsigned,
  `fechafac` char(8)
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
-- Definition of function `_sqlentidadd`
--

DROP FUNCTION IF EXISTS `_sqlentidadd`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlentidadd`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlentidadd $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `_sqlentidadh`
--

DROP FUNCTION IF EXISTS `_sqlentidadh`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlentidadh`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlentidadh $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `_sqlfechadeu`
--

DROP FUNCTION IF EXISTS `_sqlfechadeu`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlfechadeu`() RETURNS varchar(8) CHARSET latin1
    NO SQL
    DETERMINISTIC
return @_sqlfechadeu $$
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
-- Definition of view `facturasaldo1`
--

DROP TABLE IF EXISTS `facturasaldo1`;
DROP VIEW IF EXISTS `facturasaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasaldo1` AS select `f`.`idfactura` AS `idfactura`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) where ((`f`.`entidad` = `_sqlentidad`()) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idfactura`;

--
-- Definition of view `facturasaldof`
--

DROP TABLE IF EXISTS `facturasaldof`;
DROP VIEW IF EXISTS `facturasaldof`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasaldof` AS select `f`.`idfactura` AS `idfactura`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,trim(concat(trim(`f`.`apellido`),' ',trim(`f`.`nombre`))) AS `nombre`,`f`.`total` AS `total`,sum(ifnull(if(isnull(`r`.`idrecibo`),0,`c`.`imputado`),0)) AS `cobrado`,(((`f`.`total` * `ftc`.`opera`) - sum(if(isnull(`r`.`idrecibo`),0,`c`.`imputado`))) - sum(if(isnull(`n`.`idfactura`),0,(`c`.`imputado` * `ftc`.`opera`)))) AS `saldof`,sum(`c`.`imputado`) AS `imputado`,`f`.`fecha` AS `fechafac`,`r`.`fecha` AS `fechacob`,`c`.`idregipago` AS `idregipago`,`r`.`idrecibo` AS `idrecibo`,if(isnull(`r`.`idrecibo`),0,`r`.`importe`) AS `totrecibo`,`n`.`idfactura` AS `idnc`,`n`.`fecha` AS `fechanc`,if(isnull(`n`.`idfactura`),0,`n`.`total`) AS `totnc`,`tc`.`opera` AS `opera`,`c`.`idcomproba` AS `idcomproba`,`cm`.`comprobante` AS `comprobab`,ifnull(`se`.`detalle`,'  ') AS `detaservi`,`f`.`idcomproba` AS `idcomprof`,`fco`.`comprobante` AS `comprobaa`,`ftc`.`opera` AS `fopera` from ((((((((`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) left join `comprobantes` `cm` on((`cm`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `tc` on((`tc`.`idtipocompro` = `cm`.`idtipocompro`))) left join `comprobantes` `fco` on((`fco`.`idcomproba` = `f`.`idcomproba`))) left join `tipocompro` `ftc` on((`ftc`.`idtipocompro` = `fco`.`idtipocompro`))) left join `servicios` `se` on((`se`.`servicio` = `f`.`servicio`))) left join `facturas` `n` on(((`n`.`idfactura` = `c`.`idregipago`) and (`n`.`fecha` <= `_sqlfechadeu`()) and (`n`.`idcomproba` = `c`.`idcomproba`)))) left join `recibos` `r` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`fecha` <= `_sqlfechadeu`()) and (`r`.`idcomproba` = `c`.`idcomproba`)))) where ((`f`.`entidad` >= `_sqlentidadd`()) and (`f`.`entidad` <= `_sqlentidadh`()) and (`f`.`fecha` <= `_sqlfechadeu`()) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idfactura`;

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
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldo1` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`idrecibo` AS `idrecibo`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`idcomproba` = `c`.`idcomproba`)))) where ((`r`.`entidad` = `_sqlentidad`()) and (`cp`.`tabla` = 'recibos') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;

--
-- Definition of view `recibossaldof`
--

DROP TABLE IF EXISTS `recibossaldof`;
DROP VIEW IF EXISTS `recibossaldof`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldof` AS select `r`.`idcomproba` AS `idcomproba`,`r`.`idrecibo` AS `idrecibo`,`r`.`numero` AS `numero`,`r`.`entidad` AS `entidad`,trim(concat(trim(`r`.`apellido`),' ',trim(`r`.`nombre`))) AS `nombre`,(ifnull(sum(`c`.`imputado`),0) - if((ifnull(`f`.`idfactura`,0) = 0),ifnull(sum(`c`.`imputado`),0),0)) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`importe` AS `importe`,(`r`.`importe` - (ifnull(sum(`c`.`imputado`),0) - if((ifnull(`f`.`idfactura`,0) = 0),ifnull(sum(`c`.`imputado`),0),0))) AS `saldo`,`r`.`fecha` AS `fecha`,`c`.`idcobro` AS `idcobro`,`f`.`idfactura` AS `idfactura`,`f`.`fecha` AS `fechafac` from (((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`idcomproba` = `c`.`idcomproba`)))) left join `facturas` `f` on(((`f`.`idfactura` = `c`.`idfactura`) and (`f`.`fecha` <= `_sqlfechadeu`())))) where ((`r`.`entidad` >= `_sqlentidadd`()) and (`r`.`entidad` <= `_sqlentidadh`()) and (`cp`.`tabla` = 'recibos') and (`r`.`fecha` <= `_sqlfechadeu`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
