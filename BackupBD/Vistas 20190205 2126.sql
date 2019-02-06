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
-- Temporary table structure for view `articulostock`
--
DROP TABLE IF EXISTS `articulostock`;
DROP VIEW IF EXISTS `articulostock`;
CREATE TABLE `articulostock` (
  `articulo` char(50),
  `stocktot` double(21,4)
);

--
-- Temporary table structure for view `ctactefact`
--
DROP TABLE IF EXISTS `ctactefact`;
DROP VIEW IF EXISTS `ctactefact`;
CREATE TABLE `ctactefact` (
  `entidad` int(10) unsigned,
  `saldo` double(21,4)
);

--
-- Temporary table structure for view `ctacterec`
--
DROP TABLE IF EXISTS `ctacterec`;
DROP VIEW IF EXISTS `ctacterec`;
CREATE TABLE `ctacterec` (
  `entidad` int(10) unsigned,
  `saldo` double(21,4)
);

--
-- Temporary table structure for view `ctactesaldo`
--
DROP TABLE IF EXISTS `ctactesaldo`;
DROP VIEW IF EXISTS `ctactesaldo`;
CREATE TABLE `ctactesaldo` (
  `entidad` int(11),
  `saldo` double(21,4)
);

--
-- Temporary table structure for view `depostock`
--
DROP TABLE IF EXISTS `depostock`;
DROP VIEW IF EXISTS `depostock`;
CREATE TABLE `depostock` (
  `deposito` int(10) unsigned,
  `articulo` char(50),
  `nombreart` char(254),
  `stocktot` double(21,4),
  `stock` double(21,4),
  `stockmin` float(13,4)
);

--
-- Temporary table structure for view `facturasaldo`
--
DROP TABLE IF EXISTS `facturasaldo`;
DROP VIEW IF EXISTS `facturasaldo`;
CREATE TABLE `facturasaldo` (
  `idfactura` int(10) unsigned,
  `cobrado` double(21,4),
  `saldof` double(21,4)
);

--
-- Temporary table structure for view `facturasctasaldo`
--
DROP TABLE IF EXISTS `facturasctasaldo`;
DROP VIEW IF EXISTS `facturasctasaldo`;
CREATE TABLE `facturasctasaldo` (
  `idcuotafc` int(10) unsigned,
  `cuota` int(10) unsigned,
  `idfactura` int(10) unsigned,
  `importe` float(13,4),
  `cobrado` double(21,4),
  `saldof` double(21,4)
);

--
-- Temporary table structure for view `maxidestados`
--
DROP TABLE IF EXISTS `maxidestados`;
DROP VIEW IF EXISTS `maxidestados`;
CREATE TABLE `maxidestados` (
  `idestadosreg` int(10) unsigned,
  `tabla` char(100),
  `campo` char(100),
  `id` char(30)
);

--
-- Temporary table structure for view `otdepostock`
--
DROP TABLE IF EXISTS `otdepostock`;
DROP VIEW IF EXISTS `otdepostock`;
CREATE TABLE `otdepostock` (
  `iddepo` int(10) unsigned,
  `idmate` int(10) unsigned,
  `codigomat` char(20),
  `nombremat` char(200),
  `stocktot` double(19,2),
  `stock` double(19,2),
  `stockmin` float(13,3),
  `constock` char(1),
  `horas` char(1)
);

--
-- Temporary table structure for view `otmatestock`
--
DROP TABLE IF EXISTS `otmatestock`;
DROP VIEW IF EXISTS `otmatestock`;
CREATE TABLE `otmatestock` (
  `idmate` int(10) unsigned,
  `stocktot` double(19,2)
);

--
-- Temporary table structure for view `recibossaldo`
--
DROP TABLE IF EXISTS `recibossaldo`;
DROP VIEW IF EXISTS `recibossaldo`;
CREATE TABLE `recibossaldo` (
  `idcomproba` int(10) unsigned,
  `totimputado` double(21,4),
  `totrecargo` double(21,4),
  `idrecibo` int(10) unsigned,
  `importe` float(13,4),
  `saldo` double(21,4)
);

--
-- Temporary table structure for view `ultimoestado`
--
DROP TABLE IF EXISTS `ultimoestado`;
DROP VIEW IF EXISTS `ultimoestado`;
CREATE TABLE `ultimoestado` (
  `tabla` char(100),
  `campo` char(100),
  `id` char(30),
  `idestador` int(10) unsigned,
  `tipo` char(1),
  `fechaest` char(16)
);

--
-- Definition of view `articulostock`
--

DROP TABLE IF EXISTS `articulostock`;
DROP VIEW IF EXISTS `articulostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `articulostock` AS select `h`.`articulo` AS `articulo`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `h`.`cantidad`)) AS `stocktot` from (`ajustestockh` `h` left join `tipomstock` `t` on((`h`.`idtipomov` = `t`.`idtipomov`))) where (not(`h`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `h`.`articulo`;

--
-- Definition of view `ctactefact`
--

DROP TABLE IF EXISTS `ctactefact`;
DROP VIEW IF EXISTS `ctactefact`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactefact` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from ((`facturas` `f` left join `comprobantes` `c` on((`f`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`c`.`ctacte` = 'S') and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`entidad`;

--
-- Definition of view `ctacterec`
--

DROP TABLE IF EXISTS `ctacterec`;
DROP VIEW IF EXISTS `ctacterec`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacterec` AS select `r`.`entidad` AS `entidad`,sum((`r`.`importe` * `t`.`opera`)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `c` on((`r`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`c`.`ctacte` = 'S') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`entidad`;

--
-- Definition of view `ctactesaldo`
--

DROP TABLE IF EXISTS `ctactesaldo`;
DROP VIEW IF EXISTS `ctactesaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactesaldo` AS select `e`.`entidad` AS `entidad`,(ifnull(`fac`.`saldo`,0) + ifnull(`rec`.`saldo`,0)) AS `saldo` from ((`entidades` `e` left join `ctactefact` `fac` on((`e`.`entidad` = `fac`.`entidad`))) left join `ctacterec` `rec` on((`e`.`entidad` = `rec`.`entidad`)));

--
-- Definition of view `depostock`
--

DROP TABLE IF EXISTS `depostock`;
DROP VIEW IF EXISTS `depostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stocktot`,0) AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `a`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin` from (((`ajustestockh` `a` left join `tipomstock` `t` on((`a`.`idtipomov` = `t`.`idtipomov`))) left join `articulos` `m` on((`a`.`articulo` = `m`.`articulo`))) left join `articulostock` `u` on((`a`.`articulo` = `u`.`articulo`))) where (not(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;

--
-- Definition of view `facturasaldo`
--

DROP TABLE IF EXISTS `facturasaldo`;
DROP VIEW IF EXISTS `facturasaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasaldo` AS select `f`.`idfactura` AS `idfactura`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) where (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2))))) group by `f`.`idfactura`;

--
-- Definition of view `facturasctasaldo`
--

DROP TABLE IF EXISTS `facturasctasaldo`;
DROP VIEW IF EXISTS `facturasctasaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasctasaldo` AS select `f`.`idcuotafc` AS `idcuotafc`,`f`.`cuota` AS `cuota`,`f`.`idfactura` AS `idfactura`,`f`.`importe` AS `importe`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`facturascta` `f` left join `cobros` `c` on((`f`.`idcuotafc` = `c`.`idcuotafc`))) where (not(`f`.`idcuotafc` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturascta') and (`ultimoestado`.`campo` = 'idcuotafc') and (`ultimoestado`.`idestador` = 2))))) group by `f`.`idcuotafc`;

--
-- Definition of view `maxidestados`
--

DROP TABLE IF EXISTS `maxidestados`;
DROP VIEW IF EXISTS `maxidestados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `maxidestados` AS select max(`estadosreg`.`idestadosreg`) AS `idestadosreg`,`estadosreg`.`tabla` AS `tabla`,`estadosreg`.`campo` AS `campo`,`estadosreg`.`id` AS `id` from `estadosreg` group by `estadosreg`.`tabla`,`estadosreg`.`campo`,`estadosreg`.`id`;

--
-- Definition of view `otdepostock`
--

DROP TABLE IF EXISTS `otdepostock`;
DROP VIEW IF EXISTS `otdepostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otdepostock` AS select `o`.`iddepo` AS `iddepo`,`o`.`idmate` AS `idmate`,`o`.`codigomat` AS `codigomat`,`m`.`detalle` AS `nombremat`,`u`.`stocktot` AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `o`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin`,`v`.`stock` AS `constock`,`v`.`horas` AS `horas` from ((((`otmovistockh` `o` left join `tipomstock` `t` on((`o`.`idtipomov` = `t`.`idtipomov`))) left join `otmateriales` `m` on((`o`.`idmate` = `m`.`idmate`))) left join `otmatestock` `u` on((`o`.`idmate` = `u`.`idmate`))) left join `tipomaterial` `v` on((`m`.`idtipomate` = `v`.`idtipomate`))) where (not(`o`.`idmovip` in (select `otmovianul`.`idmovip` from `otmovianul`))) group by `o`.`iddepo`,`o`.`idmate`;

--
-- Definition of view `otmatestock`
--

DROP TABLE IF EXISTS `otmatestock`;
DROP VIEW IF EXISTS `otmatestock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otmatestock` AS select `o`.`idmate` AS `idmate`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `o`.`cantidad`)) AS `stocktot` from (`otmovistockh` `o` left join `tipomstock` `t` on((`o`.`idtipomov` = `t`.`idtipomov`))) where (not(`o`.`idmovip` in (select `otmovianul`.`idmovip` from `otmovianul`))) group by `o`.`idmate`;

--
-- Definition of view `recibossaldo`
--

DROP TABLE IF EXISTS `recibossaldo`;
DROP VIEW IF EXISTS `recibossaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldo` AS select `c`.`idcomproba` AS `idcomproba`,sum(`c`.`imputado`) AS `totimputado`,sum(`c`.`recargo`) AS `totrecargo`,`r`.`idrecibo` AS `idrecibo`,`r`.`importe` AS `importe`,((`r`.`importe` - sum(`c`.`imputado`)) - sum(`c`.`recargo`)) AS `saldo` from (`cobros` `c` left join `recibos` `r` on(((`c`.`idregipago` = `r`.`idrecibo`) and (`c`.`idcomproba` = `r`.`idcomproba`)))) where (((`c`.`idcomproba` = 5) or (`c`.`idcomproba` = 13) or (`c`.`idcomproba` = 14)) and (not(`c`.`idregipago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `c`.`idcomproba`,`c`.`idregipago`;

--
-- Definition of view `ultimoestado`
--

DROP TABLE IF EXISTS `ultimoestado`;
DROP VIEW IF EXISTS `ultimoestado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultimoestado` AS select `e`.`tabla` AS `tabla`,`e`.`campo` AS `campo`,`e`.`id` AS `id`,`e`.`idestador` AS `idestador`,`e`.`tipo` AS `tipo`,`e`.`fecha` AS `fechaest` from (`maxidestados` `m` left join `estadosreg` `e` on((`m`.`idestadosreg` = `e`.`idestadosreg`)));



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
