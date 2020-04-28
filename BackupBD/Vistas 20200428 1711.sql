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
-- Temporary table structure for view `factuprovesaldo`
--
DROP TABLE IF EXISTS `factuprovesaldo`;
DROP VIEW IF EXISTS `factuprovesaldo`;
CREATE TABLE `factuprovesaldo` (
  `idfactprov` int(10) unsigned,
  `cobrado` double(21,4),
  `saldof` double(21,4)
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
-- Temporary table structure for view `otpedidoview`
--
DROP TABLE IF EXISTS `otpedidoview`;
DROP VIEW IF EXISTS `otpedidoview`;
CREATE TABLE `otpedidoview` (
  `fecha` char(8),
  `fechacarga` char(8),
  `nombre` char(200),
  `direccion` char(200),
  `telefono` char(50),
  `email` char(200),
  `proyecto` char(200),
  `idpedido` int(10) unsigned,
  `idot` int(10) unsigned,
  `fechaot` char(8),
  `fechaini` char(8),
  `testimado` char(20),
  `fechafin` char(8),
  `costoest` float(13,2),
  `descriptot` char(200),
  `idestado` int(10) unsigned,
  `detaestado` char(200),
  `responsa` char(200),
  `observa` char(200),
  `idetapa` int(10) unsigned,
  `etapa` char(200),
  `describir` longtext,
  `idotlinea` int(10) unsigned,
  `estadoot` char(200),
  `idestot` int(10) unsigned,
  `idotdet` int(10) unsigned,
  `codigomat1` char(20),
  `descrip` char(200),
  `cantidad` float(13,2),
  `impuni` float(13,2),
  `imptotal` float(13,2),
  `idmate` int(10) unsigned,
  `fechai` char(8),
  `horai` char(8),
  `fechaf` char(8),
  `horaf` char(8),
  `tiemest` char(20),
  `cantm2` float(13,2),
  `idmoneda` int(10) unsigned,
  `moneda` char(50),
  `cotizacion` float(13,2),
  `fechacot` char(8),
  `observa2` char(200),
  `fechaanu` char(8),
  `codigomat` char(20),
  `detmat` char(200),
  `unidad` char(10),
  `obsmat` char(254),
  `entidad` int(11),
  `nomentidad` char(100),
  `apeEntidad` char(100),
  `tmadeta` char(100),
  `tmastock` char(1),
  `tmahoras` varchar(10),
  `detaliot` char(200),
  `idtipomate` int(10) unsigned,
  `tipohora` char(1),
  `linea` char(10),
  `detlinea` char(50)
);

--
-- Temporary table structure for view `pagosprovsaldo`
--
DROP TABLE IF EXISTS `pagosprovsaldo`;
DROP VIEW IF EXISTS `pagosprovsaldo`;
CREATE TABLE `pagosprovsaldo` (
  `idcomproba` int(10) unsigned,
  `totimputado` double(21,4),
  `idpago` int(10) unsigned,
  `importe` float(13,4),
  `saldo` double(21,4)
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
-- Temporary table structure for view `recmaxidest`
--
DROP TABLE IF EXISTS `recmaxidest`;
DROP VIEW IF EXISTS `recmaxidest`;
CREATE TABLE `recmaxidest` (
  `maxid` int(10) unsigned,
  `idreclamop` int(10) unsigned,
  `idrecsec` int(10) unsigned
);

--
-- Temporary table structure for view `recultestr`
--
DROP TABLE IF EXISTS `recultestr`;
DROP VIEW IF EXISTS `recultestr`;
CREATE TABLE `recultestr` (
  `maxid` int(10) unsigned,
  `idreclamop` int(10) unsigned,
  `idrecsec` int(10) unsigned,
  `idrecest` int(10) unsigned,
  `fecha` char(16),
  `estado` char(50),
  `colore` int(10) unsigned
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
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactefact` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from ((`facturas` `f` left join `comprobantes` `c` on((`f`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`t`.`ctacte` = 'S') and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`entidad`;

--
-- Definition of view `ctacterec`
--

DROP TABLE IF EXISTS `ctacterec`;
DROP VIEW IF EXISTS `ctacterec`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacterec` AS select `r`.`entidad` AS `entidad`,sum((`r`.`importe` * `t`.`opera`)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `c` on((`r`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`t`.`ctacte` = 'S') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`entidad`;

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
-- Definition of view `factuprovesaldo`
--

DROP TABLE IF EXISTS `factuprovesaldo`;
DROP VIEW IF EXISTS `factuprovesaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `factuprovesaldo` AS select `f`.`idfactprove` AS `idfactprov`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`factuprove` `f` left join `pagosprovfc` `c` on((`f`.`idfactprove` = `c`.`idfactprove`))) group by `f`.`idfactprove`;

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
-- Definition of view `otpedidoview`
--

DROP TABLE IF EXISTS `otpedidoview`;
DROP VIEW IF EXISTS `otpedidoview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otpedidoview` AS select `op`.`fecha` AS `fecha`,`op`.`fechacarga` AS `fechacarga`,`op`.`nombre` AS `nombre`,`op`.`direccion` AS `direccion`,`op`.`telefono` AS `telefono`,`op`.`email` AS `email`,`op`.`proyecto` AS `proyecto`,`ot`.`idpedido` AS `idpedido`,`ot`.`idot` AS `idot`,`ot`.`fechaot` AS `fechaot`,`ot`.`fechaini` AS `fechaini`,`ot`.`testimado` AS `testimado`,`ot`.`fechafin` AS `fechafin`,`ot`.`costoest` AS `costoest`,`ot`.`descriptot` AS `descriptot`,`ot`.`idestado` AS `idestado`,`ot`.`detaestado` AS `detaestado`,`ot`.`responsa` AS `responsa`,`ot`.`observa` AS `observa`,`ot`.`idetapa` AS `idetapa`,`ot`.`etapa` AS `etapa`,`ot`.`describir` AS `describir`,`ot`.`idotlinea` AS `idotlinea`,`ot`.`detaestado` AS `estadoot`,`ot`.`idestado` AS `idestot`,`otd`.`idotdet` AS `idotdet`,`otd`.`codigomat` AS `codigomat1`,`otd`.`descrip` AS `descrip`,`otd`.`cantidad` AS `cantidad`,`otd`.`impuni` AS `impuni`,`otd`.`imptotal` AS `imptotal`,`otd`.`idmate` AS `idmate`,`otd`.`fechai` AS `fechai`,`otd`.`horai` AS `horai`,`otd`.`fechaf` AS `fechaf`,`otd`.`horaf` AS `horaf`,`otd`.`tiemest` AS `tiemest`,`otd`.`cantm2` AS `cantm2`,`otd`.`idmoneda` AS `idmoneda`,`otd`.`moneda` AS `moneda`,`otd`.`cotizacion` AS `cotizacion`,`otd`.`fechacot` AS `fechacot`,`otd`.`observa` AS `observa2`,`ota`.`fecha` AS `fechaanu`,`otm`.`codigomat` AS `codigomat`,`otm`.`detalle` AS `detmat`,`otm`.`unidad` AS `unidad`,`otm`.`observa` AS `obsmat`,`e`.`entidad` AS `entidad`,`e`.`nombre` AS `nomentidad`,`e`.`apellido` AS `apeEntidad`,`t`.`detalle` AS `tmadeta`,`t`.`stock` AS `tmastock`,if((`t`.`horas` = 'S'),'HORAS     ','MATERIALES') AS `tmahoras`,`l`.`detalle` AS `detaliot`,`t`.`idtipomate` AS `idtipomate`,`t`.`horas` AS `tipohora`,`lm`.`linea` AS `linea`,`lm`.`detalle` AS `detlinea` from ((((((((`otpedido` `op` left join `otordentra` `ot` on((`op`.`idpedido` = `ot`.`idpedido`))) left join `otpedidoanul` `ota` on((`op`.`idpedido` = `ota`.`idotpedido`))) left join `otdetaot` `otd` on((`ot`.`idot` = `otd`.`idot`))) left join `otmateriales` `otm` on((`otd`.`idmate` = `otm`.`idmate`))) left join `entidades` `e` on((`op`.`entidad` = `e`.`entidad`))) left join `otlineasot` `l` on((`l`.`idotlinea` = `ot`.`idotlinea`))) left join `tipomaterial` `t` on((`otm`.`idtipomate` = `t`.`idtipomate`))) left join `otlineasmat` `lm` on((`otm`.`linea` = `lm`.`linea`))) order by `op`.`idpedido`;

--
-- Definition of view `pagosprovsaldo`
--

DROP TABLE IF EXISTS `pagosprovsaldo`;
DROP VIEW IF EXISTS `pagosprovsaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagosprovsaldo` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,`r`.`idpago` AS `idpago`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`pagosprov` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `pagosprovfc` `c` on((`r`.`idpago` = `c`.`idpago`))) where (`cp`.`tabla` = 'factuprove') group by `r`.`idpago`;

--
-- Definition of view `recibossaldo`
--

DROP TABLE IF EXISTS `recibossaldo`;
DROP VIEW IF EXISTS `recibossaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldo` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`idrecibo` AS `idrecibo`,`r`.`importe` AS `importe`,((`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) - ifnull(sum(`c`.`recargo`),0)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on((`r`.`idrecibo` = `c`.`idregipago`))) where ((`cp`.`tabla` = 'recibos') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;

--
-- Definition of view `recmaxidest`
--

DROP TABLE IF EXISTS `recmaxidest`;
DROP VIEW IF EXISTS `recmaxidest`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recmaxidest` AS select max(`r`.`idreclamoe`) AS `maxid`,`r`.`idreclamop` AS `idreclamop`,`r`.`idrecsec` AS `idrecsec` from `reclamoe` `r` group by `r`.`idreclamop`,`r`.`idrecsec`;

--
-- Definition of view `recultestr`
--

DROP TABLE IF EXISTS `recultestr`;
DROP VIEW IF EXISTS `recultestr`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recultestr` AS select `m`.`maxid` AS `maxid`,`m`.`idreclamop` AS `idreclamop`,`m`.`idrecsec` AS `idrecsec`,`r`.`idrecest` AS `idrecest`,`r`.`fecha` AS `fecha`,`re`.`estado` AS `estado`,`re`.`colore` AS `colore` from ((`recmaxidest` `m` left join `reclamoe` `r` on((`m`.`maxid` = `r`.`idreclamoe`))) left join `recestado` `re` on((`r`.`idrecest` = `re`.`idrecest`)));

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
