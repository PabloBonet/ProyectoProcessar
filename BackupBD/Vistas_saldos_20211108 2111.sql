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
-- Temporary table structure for view `bancosaldosf`
--
DROP TABLE IF EXISTS `bancosaldosf`;
DROP VIEW IF EXISTS `bancosaldosf`;
CREATE TABLE `bancosaldosf` (
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
-- Temporary table structure for view `bancosaldosf1`
--
DROP TABLE IF EXISTS `bancosaldosf1`;
DROP VIEW IF EXISTS `bancosaldosf1`;
CREATE TABLE `bancosaldosf1` (
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
-- Temporary table structure for view `bancosegrf`
--
DROP TABLE IF EXISTS `bancosegrf`;
DROP VIEW IF EXISTS `bancosegrf`;
CREATE TABLE `bancosegrf` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `egresos` double(19,2),
  `fecha` char(8)
);

--
-- Temporary table structure for view `bancosegrf1`
--
DROP TABLE IF EXISTS `bancosegrf1`;
DROP VIEW IF EXISTS `bancosegrf1`;
CREATE TABLE `bancosegrf1` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `egresos` double(19,2),
  `fecha` char(8)
);

--
-- Temporary table structure for view `bancosingf`
--
DROP TABLE IF EXISTS `bancosingf`;
DROP VIEW IF EXISTS `bancosingf`;
CREATE TABLE `bancosingf` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `ingresos` double(19,2),
  `fecha` char(8)
);

--
-- Temporary table structure for view `bancosingf1`
--
DROP TABLE IF EXISTS `bancosingf1`;
DROP VIEW IF EXISTS `bancosingf1`;
CREATE TABLE `bancosingf1` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `ingresos` double(19,2),
  `fecha` char(8)
);

--
-- Definition of view `bancosaldosf`
--

DROP TABLE IF EXISTS `bancosaldosf`;
DROP VIEW IF EXISTS `bancosaldosf`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosaldosf` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,`c`.`idtipocta` AS `idtipocta`,`c`.`idbanco` AS `idbanco`,`c`.`cbu` AS `cbu`,`b`.`banco` AS `banco`,`b`.`nombre` AS `nombre`,`b`.`filial` AS `filial`,`b`.`cp` AS `cp`,sum((ifnull(`i`.`ingresos`,0) - ifnull(`e`.`egresos`,0))) AS `saldo` from (((`cajabancos` `c` left join `bancosingf` `i` on((`c`.`idcuenta` = `i`.`idcuenta`))) left join `bancosegrf` `e` on((`c`.`idcuenta` = `e`.`idcuenta`))) left join `bancos` `b` on((`b`.`idbanco` = `c`.`idbanco`))) group by `c`.`idcuenta`;

--
-- Definition of view `bancosaldosf1`
--

DROP TABLE IF EXISTS `bancosaldosf1`;
DROP VIEW IF EXISTS `bancosaldosf1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosaldosf1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,`c`.`idtipocta` AS `idtipocta`,`c`.`idbanco` AS `idbanco`,`c`.`cbu` AS `cbu`,`b`.`banco` AS `banco`,`b`.`nombre` AS `nombre`,`b`.`filial` AS `filial`,`b`.`cp` AS `cp`,sum((ifnull(`i`.`ingresos`,0) - ifnull(`e`.`egresos`,0))) AS `saldo` from (((`cajabancos` `c` left join `bancosingf1` `i` on((`c`.`idcuenta` = `i`.`idcuenta`))) left join `bancosegrf1` `e` on((`c`.`idcuenta` = `e`.`idcuenta`))) left join `bancos` `b` on((`b`.`idbanco` = `c`.`idbanco`))) group by `c`.`idcuenta`;

--
-- Definition of view `bancosegrf`
--

DROP TABLE IF EXISTS `bancosegrf`;
DROP VIEW IF EXISTS `bancosegrf`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosegrf` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `egresos`,`d`.`fecha` AS `fecha` from (((`cajabancos` `c` left join `detallepagos` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`d`.`fecha` = `_sqlfechadeu`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `bancosegrf1`
--

DROP TABLE IF EXISTS `bancosegrf1`;
DROP VIEW IF EXISTS `bancosegrf1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosegrf1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `egresos`,`d`.`fecha` AS `fecha` from (((`cajabancos` `c` left join `detallepagos` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`c`.`idcuenta` = `_sqlidcuenta`()) and (`d`.`fecha` = `_sqlfechadeu`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `bancosingf`
--

DROP TABLE IF EXISTS `bancosingf`;
DROP VIEW IF EXISTS `bancosingf`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosingf` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `ingresos`,`d`.`fecha` AS `fecha` from (((`cajabancos` `c` left join `detallecobros` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`d`.`fecha` < `_sqlfechadeu`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `bancosingf1`
--

DROP TABLE IF EXISTS `bancosingf1`;
DROP VIEW IF EXISTS `bancosingf1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosingf1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `ingresos`,`d`.`fecha` AS `fecha` from (((`cajabancos` `c` left join `detallecobros` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`c`.`idcuenta` = `_sqlidcuenta`()) and (`d`.`fecha` < `_sqlfechadeu`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
