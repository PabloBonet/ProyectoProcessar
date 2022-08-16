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
-- Create schema processarmkfc
--

CREATE DATABASE IF NOT EXISTS processarmkfc;
USE processarmkfc;

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
  `cuit` char(13),
  `idclascomp` int(10) unsigned,
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
-- Definition of view `facturasaldof`
--

DROP TABLE IF EXISTS `facturasaldof`;
DROP VIEW IF EXISTS `facturasaldof`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `facturasaldof` AS select `f`.`idfactura` AS `idfactura`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,trim(concat(trim(`f`.`apellido`),' ',trim(`f`.`nombre`))) AS `nombre`,`f`.`cuit` AS `cuit`,`f`.`idclascomp` AS `idclascomp`,`f`.`total` AS `total`,sum(ifnull(if(isnull(`r`.`idrecibo`),0,`c`.`imputado`),0)) AS `cobrado`,(((`f`.`total` * `ftc`.`opera`) - sum(if(isnull(`r`.`idrecibo`),0,`c`.`imputado`))) - sum(if(isnull(`n`.`idfactura`),0,(`c`.`imputado` * `ftc`.`opera`)))) AS `saldof`,sum(`c`.`imputado`) AS `imputado`,`f`.`fecha` AS `fechafac`,`r`.`fecha` AS `fechacob`,`c`.`idregipago` AS `idregipago`,`r`.`idrecibo` AS `idrecibo`,if(isnull(`r`.`idrecibo`),0,`r`.`importe`) AS `totrecibo`,`n`.`idfactura` AS `idnc`,`n`.`fecha` AS `fechanc`,if(isnull(`n`.`idfactura`),0,`n`.`total`) AS `totnc`,`tc`.`opera` AS `opera`,`c`.`idcomproba` AS `idcomproba`,`cm`.`comprobante` AS `comprobab`,ifnull(`se`.`detalle`,'  ') AS `detaservi`,`f`.`idcomproba` AS `idcomprof`,`fco`.`comprobante` AS `comprobaa`,`ftc`.`opera` AS `fopera` from ((((((((`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) left join `comprobantes` `cm` on((`cm`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `tc` on((`tc`.`idtipocompro` = `cm`.`idtipocompro`))) left join `comprobantes` `fco` on((`fco`.`idcomproba` = `f`.`idcomproba`))) left join `tipocompro` `ftc` on((`ftc`.`idtipocompro` = `fco`.`idtipocompro`))) left join `servicios` `se` on((`se`.`servicio` = `f`.`servicio`))) left join `facturas` `n` on(((`n`.`idfactura` = `c`.`idregipago`) and (`n`.`fecha` <= `_sqlfechadeu`()) and (`n`.`idcomproba` = `c`.`idcomproba`)))) left join `recibos` `r` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`fecha` <= `_sqlfechadeu`()) and (`r`.`idcomproba` = `c`.`idcomproba`)))) where ((`f`.`entidad` >= `_sqlentidadd`()) and (`f`.`entidad` <= `_sqlentidadh`()) and (`f`.`fecha` <= `_sqlfechadeu`()) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idfactura`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
