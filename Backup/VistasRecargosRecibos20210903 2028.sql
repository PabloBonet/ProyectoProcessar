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
-- Temporary table structure for view `ctacterec`
--
DROP TABLE IF EXISTS `ctacterec`;
DROP VIEW IF EXISTS `ctacterec`;
CREATE TABLE `ctacterec` (
  `entidad` int(10) unsigned,
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
-- Temporary table structure for view `recibossaldo`
--
DROP TABLE IF EXISTS `recibossaldo`;
DROP VIEW IF EXISTS `recibossaldo`;
CREATE TABLE `recibossaldo` (
  `idcomproba` int(10) unsigned,
  `totimputado` double(19,2),
  `totrecargo` double(19,2),
  `idrecibo` int(10) unsigned,
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
-- Definition of view `ctacterec`
--

DROP TABLE IF EXISTS `ctacterec`;
DROP VIEW IF EXISTS `ctacterec`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacterec` AS select `r`.`entidad` AS `entidad`,sum((`r`.`importe` * `t`.`opera`)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `c` on((`r`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`t`.`ctacte` = 'S') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`entidad`;

--
-- Definition of view `ctacterec1`
--

DROP TABLE IF EXISTS `ctacterec1`;
DROP VIEW IF EXISTS `ctacterec1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacterec1` AS select `r`.`entidad` AS `entidad`,sum((`r`.`importe` * `t`.`opera`)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `c` on((`r`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`r`.`entidad` = `_sqlentidad`()) and (`t`.`ctacte` = 'S') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`entidad`;

--
-- Definition of view `recibossaldo`
--

DROP TABLE IF EXISTS `recibossaldo`;
DROP VIEW IF EXISTS `recibossaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldo` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`idrecibo` AS `idrecibo`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on((`r`.`idrecibo` = `c`.`idregipago`))) where ((`cp`.`tabla` = 'recibos') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;

--
-- Definition of view `recibossaldo1`
--

DROP TABLE IF EXISTS `recibossaldo1`;
DROP VIEW IF EXISTS `recibossaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldo1` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`idrecibo` AS `idrecibo`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on((`r`.`idrecibo` = `c`.`idregipago`))) where ((`r`.`entidad` = `_sqlentidad`()) and (`cp`.`tabla` = 'recibos') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
