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
-- Temporary table structure for view `anularppdtp`
--
DROP TABLE IF EXISTS `anularppdtp`;
DROP VIEW IF EXISTS `anularppdtp`;
CREATE TABLE `anularppdtp` (
  `idanularp` int(10) unsigned,
  `iddetacobro` int(10) unsigned,
  `idtipopago` int(10) unsigned,
  `detatipo` char(254),
  `importe` double(13,2),
  `opera` int(11),
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detacta` char(254),
  `idbanco` int(10) unsigned,
  `cuentabco` char(100)
);

--
-- Temporary table structure for view `anularprdtp`
--
DROP TABLE IF EXISTS `anularprdtp`;
DROP VIEW IF EXISTS `anularprdtp`;
CREATE TABLE `anularprdtp` (
  `idanularp` int(10) unsigned,
  `iddetapago` int(10) unsigned,
  `idtipopago` int(10) unsigned,
  `detatipo` char(254),
  `importe` double(13,2),
  `opera` int(11),
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detacta` char(254),
  `idbanco` int(10) unsigned,
  `cuentabco` char(100)
);

--
-- Temporary table structure for view `articulostock`
--
DROP TABLE IF EXISTS `articulostock`;
DROP VIEW IF EXISTS `articulostock`;
CREATE TABLE `articulostock` (
  `articulo` char(50),
  `stocktot` double(19,2)
);

--
-- Temporary table structure for view `artpendiente`
--
DROP TABLE IF EXISTS `artpendiente`;
DROP VIEW IF EXISTS `artpendiente`;
CREATE TABLE `artpendiente` (
  `articulo` char(50),
  `cantidad` double(19,2),
  `cantcump` double(19,2),
  `pendiente` double(19,2)
);

--
-- Temporary table structure for view `bancosaldos`
--
DROP TABLE IF EXISTS `bancosaldos`;
DROP VIEW IF EXISTS `bancosaldos`;
CREATE TABLE `bancosaldos` (
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
-- Temporary table structure for view `bancosegr`
--
DROP TABLE IF EXISTS `bancosegr`;
DROP VIEW IF EXISTS `bancosegr`;
CREATE TABLE `bancosegr` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `egresos` double(19,2)
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
-- Temporary table structure for view `bancosing`
--
DROP TABLE IF EXISTS `bancosing`;
DROP VIEW IF EXISTS `bancosing`;
CREATE TABLE `bancosing` (
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detalle` char(254),
  `cuentabco` char(100),
  `ingresos` double(19,2)
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
-- Temporary table structure for view `cajaiecedtp`
--
DROP TABLE IF EXISTS `cajaiecedtp`;
DROP VIEW IF EXISTS `cajaiecedtp`;
CREATE TABLE `cajaiecedtp` (
  `idcajaie` int(10) unsigned,
  `iddetapago` int(10) unsigned,
  `idtipopago` int(10) unsigned,
  `detatipo` char(254),
  `importe` double(13,2),
  `opera` int(11),
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detacta` char(254),
  `idbanco` int(10) unsigned,
  `cuentabco` char(100)
);

--
-- Temporary table structure for view `cajaiecidtp`
--
DROP TABLE IF EXISTS `cajaiecidtp`;
DROP VIEW IF EXISTS `cajaiecidtp`;
CREATE TABLE `cajaiecidtp` (
  `idcajaie` int(10) unsigned,
  `iddetacobro` int(10) unsigned,
  `idtipopago` int(10) unsigned,
  `detatipo` char(254),
  `importe` double(13,2),
  `opera` int(11),
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detacta` char(254),
  `idbanco` int(10) unsigned,
  `cuentabco` char(100)
);

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
-- Temporary table structure for view `ctactefact`
--
DROP TABLE IF EXISTS `ctactefact`;
DROP VIEW IF EXISTS `ctactefact`;
CREATE TABLE `ctactefact` (
  `entidad` int(10) unsigned,
  `saldo` double(19,2)
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
-- Temporary table structure for view `ctactepagos`
--
DROP TABLE IF EXISTS `ctactepagos`;
DROP VIEW IF EXISTS `ctactepagos`;
CREATE TABLE `ctactepagos` (
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
-- Temporary table structure for view `ctacteprofact`
--
DROP TABLE IF EXISTS `ctacteprofact`;
DROP VIEW IF EXISTS `ctacteprofact`;
CREATE TABLE `ctacteprofact` (
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
-- Temporary table structure for view `ctacteprosaldo`
--
DROP TABLE IF EXISTS `ctacteprosaldo`;
DROP VIEW IF EXISTS `ctacteprosaldo`;
CREATE TABLE `ctacteprosaldo` (
  `entidad` int(11),
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
-- Temporary table structure for view `ctactesaldo`
--
DROP TABLE IF EXISTS `ctactesaldo`;
DROP VIEW IF EXISTS `ctactesaldo`;
CREATE TABLE `ctactesaldo` (
  `entidad` int(11),
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
-- Temporary table structure for view `depostock`
--
DROP TABLE IF EXISTS `depostock`;
DROP VIEW IF EXISTS `depostock`;
CREATE TABLE `depostock` (
  `deposito` int(10) unsigned,
  `articulo` char(50),
  `nombreart` char(254),
  `stocktot` double(19,2),
  `stock` double(19,2),
  `stockmin` double(13,2),
  `pendiente` double(19,2)
);

--
-- Temporary table structure for view `factuprovesaldo`
--
DROP TABLE IF EXISTS `factuprovesaldo`;
DROP VIEW IF EXISTS `factuprovesaldo`;
CREATE TABLE `factuprovesaldo` (
  `idfactprov` int(10) unsigned,
  `cobrado` double(19,2),
  `saldof` double(19,2)
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
-- Temporary table structure for view `factuprovesaldof`
--
DROP TABLE IF EXISTS `factuprovesaldof`;
DROP VIEW IF EXISTS `factuprovesaldof`;
CREATE TABLE `factuprovesaldof` (
  `idfactprov` int(10) unsigned,
  `entidad` int(10) unsigned,
  `nombre` varchar(509),
  `cobrado` double(19,2),
  `saldof` double(19,2),
  `imputado` double(19,2),
  `fechafac` char(8),
  `fechacob` char(8),
  `idregipago` int(10) unsigned,
  `idpago` int(10) unsigned,
  `totrecibo` double(13,2),
  `idnc` int(10) unsigned,
  `fechanc` char(8),
  `totnc` double(13,2),
  `idcomproba` int(10) unsigned,
  `comprobab` char(100),
  `operab` int(11),
  `idcomprof` int(10) unsigned,
  `comprobaa` char(100),
  `operaa` int(11)
);

--
-- Temporary table structure for view `facturasaldo`
--
DROP TABLE IF EXISTS `facturasaldo`;
DROP VIEW IF EXISTS `facturasaldo`;
CREATE TABLE `facturasaldo` (
  `idfactura` int(10) unsigned,
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
-- Temporary table structure for view `facturasctasaldo`
--
DROP TABLE IF EXISTS `facturasctasaldo`;
DROP VIEW IF EXISTS `facturasctasaldo`;
CREATE TABLE `facturasctasaldo` (
  `idcuotafc` int(10) unsigned,
  `cuota` int(10) unsigned,
  `idfactura` int(10) unsigned,
  `importe` double(13,2),
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
-- Temporary table structure for view `maxidartcosto`
--
DROP TABLE IF EXISTS `maxidartcosto`;
DROP VIEW IF EXISTS `maxidartcosto`;
CREATE TABLE `maxidartcosto` (
  `idartcosto` int(10) unsigned,
  `articulo` char(50)
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
-- Temporary table structure for view `maxidtipop`
--
DROP TABLE IF EXISTS `maxidtipop`;
DROP VIEW IF EXISTS `maxidtipop`;
CREATE TABLE `maxidtipop` (
  `idmovitp` int(10) unsigned,
  `tabla` char(100),
  `campo` char(100),
  `idregistro` int(10) unsigned
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
  `costoest` double(13,2),
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
  `cantidad` double(13,2),
  `impuni` double(13,2),
  `imptotal` double(13,2),
  `idmate` int(10) unsigned,
  `fechai` char(8),
  `horai` char(8),
  `fechaf` char(8),
  `horaf` char(8),
  `tiemest` char(20),
  `cantm2` double(13,2),
  `idmoneda` int(10) unsigned,
  `moneda` char(50),
  `cotizacion` double(13,2),
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
-- Temporary table structure for view `otpendientes`
--
DROP TABLE IF EXISTS `otpendientes`;
DROP VIEW IF EXISTS `otpendientes`;
CREATE TABLE `otpendientes` (
  `idot` int(10) unsigned,
  `articulo` char(50),
  `cantidad` double(13,2),
  `cantcump` double(19,2),
  `pendiente` double(19,2)
);

--
-- Temporary table structure for view `pagospagfacview`
--
DROP TABLE IF EXISTS `pagospagfacview`;
DROP VIEW IF EXISTS `pagospagfacview`;
CREATE TABLE `pagospagfacview` (
  `idcomproba` int(10) unsigned,
  `idpago` int(10) unsigned,
  `idfactprove` int(10) unsigned,
  `imputado` double(13,2),
  `entidad` int(10) unsigned,
  `apellido` char(254),
  `nombre` char(254),
  `fechafac` char(8),
  `tipo` char(3),
  `actividad` int(10) unsigned,
  `numero` int(10) unsigned,
  `totalfact` double(13,2),
  `fechapago` char(8),
  `totalpago` double(13,2)
);

--
-- Temporary table structure for view `pagospagfacview1`
--
DROP TABLE IF EXISTS `pagospagfacview1`;
DROP VIEW IF EXISTS `pagospagfacview1`;
CREATE TABLE `pagospagfacview1` (
  `idcomproba` int(10) unsigned,
  `idpago` int(10) unsigned,
  `idfactprove` int(10) unsigned,
  `imputado` double(13,2),
  `entidad` int(10) unsigned,
  `apellido` char(254),
  `nombre` char(254),
  `fechafac` char(8),
  `tipo` char(3),
  `actividad` int(10) unsigned,
  `numero` int(10) unsigned,
  `totalfact` double(13,2),
  `fechapago` char(8),
  `totalpago` double(13,2)
);

--
-- Temporary table structure for view `pagospagsertvw`
--
DROP TABLE IF EXISTS `pagospagsertvw`;
DROP VIEW IF EXISTS `pagospagsertvw`;
CREATE TABLE `pagospagsertvw` (
  `idpago` int(11) unsigned,
  `fecha` char(8),
  `imptotal` double(13,2),
  `servicio` bigint(20),
  `imputado` double(19,2)
);

--
-- Temporary table structure for view `pagospagsertvw1`
--
DROP TABLE IF EXISTS `pagospagsertvw1`;
DROP VIEW IF EXISTS `pagospagsertvw1`;
CREATE TABLE `pagospagsertvw1` (
  `idpago` int(11) unsigned,
  `fecha` char(8),
  `imptotal` double(13,2),
  `servicio` bigint(20),
  `imputado` double(19,2)
);

--
-- Temporary table structure for view `pagospagserview`
--
DROP TABLE IF EXISTS `pagospagserview`;
DROP VIEW IF EXISTS `pagospagserview`;
CREATE TABLE `pagospagserview` (
  `idpago` int(11) unsigned,
  `servicio` bigint(20),
  `imputado` double,
  `totalpago` double(13,2),
  `fechapago` char(8)
);

--
-- Temporary table structure for view `pagospagserview1`
--
DROP TABLE IF EXISTS `pagospagserview1`;
DROP VIEW IF EXISTS `pagospagserview1`;
CREATE TABLE `pagospagserview1` (
  `idpago` int(11) unsigned,
  `servicio` bigint(20),
  `imputado` double,
  `totalpago` double(13,2),
  `fechapago` char(8)
);

--
-- Temporary table structure for view `pagosprovdtp`
--
DROP TABLE IF EXISTS `pagosprovdtp`;
DROP VIEW IF EXISTS `pagosprovdtp`;
CREATE TABLE `pagosprovdtp` (
  `idpago` int(10) unsigned,
  `iddetapago` int(10) unsigned,
  `idtipopago` int(10) unsigned,
  `detatipo` char(254),
  `importe` double(13,2),
  `opera` int(11),
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detacta` char(254),
  `idbanco` int(10) unsigned,
  `cuentabco` char(100)
);

--
-- Temporary table structure for view `pagosprovsaldo`
--
DROP TABLE IF EXISTS `pagosprovsaldo`;
DROP VIEW IF EXISTS `pagosprovsaldo`;
CREATE TABLE `pagosprovsaldo` (
  `idcomproba` int(10) unsigned,
  `totimputado` double(19,2),
  `idpago` int(10) unsigned,
  `importe` double(13,2),
  `saldo` double(19,2)
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
-- Temporary table structure for view `pagosprovsaldof`
--
DROP TABLE IF EXISTS `pagosprovsaldof`;
DROP VIEW IF EXISTS `pagosprovsaldof`;
CREATE TABLE `pagosprovsaldof` (
  `idcomproba` int(10) unsigned,
  `idpago` int(10) unsigned,
  `numero` int(10) unsigned,
  `entidad` int(10) unsigned,
  `nombre` varchar(509),
  `totimputado` double(19,2),
  `importe` double(13,2),
  `saldo` double(19,2),
  `fecha` char(8),
  `idpagosprovfc` int(10) unsigned,
  `idfactprove` int(10) unsigned,
  `fechafac` char(8)
);

--
-- Temporary table structure for view `recibosdtp`
--
DROP TABLE IF EXISTS `recibosdtp`;
DROP VIEW IF EXISTS `recibosdtp`;
CREATE TABLE `recibosdtp` (
  `idrecibo` int(10) unsigned,
  `iddetacobro` int(10) unsigned,
  `idtipopago` int(10) unsigned,
  `detatipo` char(254),
  `importe` double(13,2),
  `opera` int(11),
  `idcuenta` int(10) unsigned,
  `codcuenta` char(100),
  `detacta` char(254),
  `idbanco` int(10) unsigned,
  `cuentabco` char(100)
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
-- Temporary table structure for view `ultimoartcosto`
--
DROP TABLE IF EXISTS `ultimoartcosto`;
DROP VIEW IF EXISTS `ultimoartcosto`;
CREATE TABLE `ultimoartcosto` (
  `idartcosto` int(10) unsigned,
  `articulo` char(50),
  `costo` double(13,2),
  `fecha` char(16)
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
-- Temporary table structure for view `ultimomovitpago`
--
DROP TABLE IF EXISTS `ultimomovitpago`;
DROP VIEW IF EXISTS `ultimomovitpago`;
CREATE TABLE `ultimomovitpago` (
  `idmovitp` int(10) unsigned,
  `idtipopago` int(10) unsigned,
  `tabla` char(100),
  `campo` char(100),
  `idregistro` int(10) unsigned,
  `idcajareca` int(10) unsigned,
  `idcuenta` int(10) unsigned,
  `fecha` char(8),
  `hora` char(8),
  `movimiento` char(20)
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
-- Definition of function `_sqlidpago`
--

DROP FUNCTION IF EXISTS `_sqlidpago`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` FUNCTION `_sqlidpago`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @_sqlidpago $$
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
-- Definition of view `anularppdtp`
--

DROP TABLE IF EXISTS `anularppdtp`;
DROP VIEW IF EXISTS `anularppdtp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `anularppdtp` AS select `a`.`idanularp` AS `idanularp`,`d`.`iddetacobro` AS `iddetacobro`,`d`.`idtipopago` AS `idtipopago`,`t`.`detalle` AS `detatipo`,`d`.`importe` AS `importe`,`t`.`opera` AS `opera`,`d`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detacta`,`c`.`idbanco` AS `idbanco`,`c`.`cuentabco` AS `cuentabco` from (((`anularp` `a` left join `detallecobros` `d` on(((`a`.`idcomproba` = `d`.`idcomproba`) and (`a`.`idanularp` = `d`.`idregistro`)))) left join `tipopagos` `t` on((`t`.`idtipopago` = `d`.`idtipopago`))) left join `cajabancos` `c` on((`c`.`idcuenta` = `d`.`idcuenta`))) where (trim(`a`.`detallecp`) = 'detallecobros');

--
-- Definition of view `anularprdtp`
--

DROP TABLE IF EXISTS `anularprdtp`;
DROP VIEW IF EXISTS `anularprdtp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `anularprdtp` AS select `a`.`idanularp` AS `idanularp`,`d`.`iddetapago` AS `iddetapago`,`d`.`idtipopago` AS `idtipopago`,`t`.`detalle` AS `detatipo`,`d`.`importe` AS `importe`,`t`.`opera` AS `opera`,`d`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detacta`,`c`.`idbanco` AS `idbanco`,`c`.`cuentabco` AS `cuentabco` from (((`anularp` `a` left join `detallepagos` `d` on(((`a`.`idcomproba` = `d`.`idcomproba`) and (`a`.`idanularp` = `d`.`idregistro`)))) left join `tipopagos` `t` on((`t`.`idtipopago` = `d`.`idtipopago`))) left join `cajabancos` `c` on((`c`.`idcuenta` = `d`.`idcuenta`))) where (trim(`a`.`detallecp`) = 'detallepagos');

--
-- Definition of view `articulostock`
--

DROP TABLE IF EXISTS `articulostock`;
DROP VIEW IF EXISTS `articulostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `articulostock` AS select `h`.`articulo` AS `articulo`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `h`.`cantidad`)) AS `stocktot` from (`ajustestockh` `h` left join `tipomstock` `t` on((`h`.`idtipomov` = `t`.`idtipomov`))) where (not(`h`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `h`.`articulo`;

--
-- Definition of view `artpendiente`
--

DROP TABLE IF EXISTS `artpendiente`;
DROP VIEW IF EXISTS `artpendiente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `artpendiente` AS select `otpendientes`.`articulo` AS `articulo`,sum(`otpendientes`.`cantidad`) AS `cantidad`,sum(`otpendientes`.`cantcump`) AS `cantcump`,sum(`otpendientes`.`pendiente`) AS `pendiente` from `otpendientes` group by `otpendientes`.`articulo`;

--
-- Definition of view `bancosaldos`
--

DROP TABLE IF EXISTS `bancosaldos`;
DROP VIEW IF EXISTS `bancosaldos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosaldos` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,`c`.`idtipocta` AS `idtipocta`,`c`.`idbanco` AS `idbanco`,`c`.`cbu` AS `cbu`,`b`.`banco` AS `banco`,`b`.`nombre` AS `nombre`,`b`.`filial` AS `filial`,`b`.`cp` AS `cp`,(ifnull(`i`.`ingresos`,0) - ifnull(`e`.`egresos`,0)) AS `saldo` from (((`cajabancos` `c` left join `bancosing` `i` on((`c`.`idcuenta` = `i`.`idcuenta`))) left join `bancosegr` `e` on((`c`.`idcuenta` = `e`.`idcuenta`))) left join `bancos` `b` on((`b`.`idbanco` = `c`.`idbanco`)));

--
-- Definition of view `bancosaldos1`
--

DROP TABLE IF EXISTS `bancosaldos1`;
DROP VIEW IF EXISTS `bancosaldos1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosaldos1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,`c`.`idtipocta` AS `idtipocta`,`c`.`idbanco` AS `idbanco`,`c`.`cbu` AS `cbu`,`b`.`banco` AS `banco`,`b`.`nombre` AS `nombre`,`b`.`filial` AS `filial`,`b`.`cp` AS `cp`,(ifnull(`i`.`ingresos`,0) - ifnull(`e`.`egresos`,0)) AS `saldo` from (((`cajabancos` `c` left join `bancosing1` `i` on((`c`.`idcuenta` = `i`.`idcuenta`))) left join `bancosegr1` `e` on((`c`.`idcuenta` = `e`.`idcuenta`))) left join `bancos` `b` on((`b`.`idbanco` = `c`.`idbanco`))) where (`c`.`idcuenta` = `_sqlidcuenta`());

--
-- Definition of view `bancosegr`
--

DROP TABLE IF EXISTS `bancosegr`;
DROP VIEW IF EXISTS `bancosegr`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosegr` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `egresos` from (((`cajabancos` `c` left join `detallepagos` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `bancosegr1`
--

DROP TABLE IF EXISTS `bancosegr1`;
DROP VIEW IF EXISTS `bancosegr1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosegr1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `egresos` from (((`cajabancos` `c` left join `detallepagos` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`c`.`idcuenta` = `_sqlidcuenta`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `bancosing`
--

DROP TABLE IF EXISTS `bancosing`;
DROP VIEW IF EXISTS `bancosing`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosing` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `ingresos` from (((`cajabancos` `c` left join `detallecobros` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `bancosing1`
--

DROP TABLE IF EXISTS `bancosing1`;
DROP VIEW IF EXISTS `bancosing1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `bancosing1` AS select `c`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detalle`,`c`.`cuentabco` AS `cuentabco`,sum(ifnull(`d`.`importe`,0)) AS `ingresos` from (((`cajabancos` `c` left join `detallecobros` `d` on((`c`.`idcuenta` = `d`.`idcuenta`))) left join `comprobantes` `cd` on((`cd`.`idcomproba` = `d`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`id` = `d`.`idregistro`) and (convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))))) where ((`c`.`idcuenta` = `_sqlidcuenta`()) and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp')) group by `c`.`idcuenta`;

--
-- Definition of view `cajaiecedtp`
--

DROP TABLE IF EXISTS `cajaiecedtp`;
DROP VIEW IF EXISTS `cajaiecedtp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cajaiecedtp` AS select `ce`.`idcajaie` AS `idcajaie`,`d`.`iddetapago` AS `iddetapago`,`d`.`idtipopago` AS `idtipopago`,`t`.`detalle` AS `detatipo`,`d`.`importe` AS `importe`,`t`.`opera` AS `opera`,`d`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detacta`,`c`.`idbanco` AS `idbanco`,`c`.`cuentabco` AS `cuentabco` from (((`cajaie` `ce` left join `detallepagos` `d` on(((`ce`.`idcomproba` = `d`.`idcomproba`) and (`ce`.`idcajaie` = `d`.`idregistro`)))) left join `tipopagos` `t` on((`t`.`idtipopago` = `d`.`idtipopago`))) left join `cajabancos` `c` on((`c`.`idcuenta` = `d`.`idcuenta`))) where (trim(`ce`.`detallecp`) = 'detallepagos');

--
-- Definition of view `cajaiecidtp`
--

DROP TABLE IF EXISTS `cajaiecidtp`;
DROP VIEW IF EXISTS `cajaiecidtp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cajaiecidtp` AS select `ci`.`idcajaie` AS `idcajaie`,`d`.`iddetacobro` AS `iddetacobro`,`d`.`idtipopago` AS `idtipopago`,`t`.`detalle` AS `detatipo`,`d`.`importe` AS `importe`,`t`.`opera` AS `opera`,`d`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detacta`,`c`.`idbanco` AS `idbanco`,`c`.`cuentabco` AS `cuentabco` from (((`cajaie` `ci` left join `detallecobros` `d` on(((`ci`.`idcomproba` = `d`.`idcomproba`) and (`ci`.`idcajaie` = `d`.`idregistro`)))) left join `tipopagos` `t` on((`t`.`idtipopago` = `d`.`idtipopago`))) left join `cajabancos` `c` on((`c`.`idcuenta` = `d`.`idcuenta`))) where (trim(`ci`.`detallecp`) = 'detallecobros');

--
-- Definition of view `cobrorecsertvw`
--

DROP TABLE IF EXISTS `cobrorecsertvw`;
DROP VIEW IF EXISTS `cobrorecsertvw`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrorecsertvw` AS select `cobrosrecserview`.`idrecibo` AS `idrecibo`,`cobrosrecserview`.`fechareci` AS `fecha`,`cobrosrecserview`.`totalreci` AS `imptotal`,`cobrosrecserview`.`servicio` AS `servicio`,round(`cobrosrecserview`.`imputado`,2) AS `imputado` from `cobrosrecserview` where (`cobrosrecserview`.`imputado` > 0) order by `cobrosrecserview`.`idrecibo`,`cobrosrecserview`.`servicio`;

--
-- Definition of view `cobrorecsertvw1`
--

DROP TABLE IF EXISTS `cobrorecsertvw1`;
DROP VIEW IF EXISTS `cobrorecsertvw1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrorecsertvw1` AS select `cobrosrecserview1`.`idrecibo` AS `idrecibo`,`cobrosrecserview1`.`fechareci` AS `fecha`,`cobrosrecserview1`.`totalreci` AS `imptotal`,`cobrosrecserview1`.`servicio` AS `servicio`,round(`cobrosrecserview1`.`imputado`,2) AS `imputado` from `cobrosrecserview1` where (`cobrosrecserview1`.`imputado` > 0) order by `cobrosrecserview1`.`idrecibo`,`cobrosrecserview1`.`servicio`;

--
-- Definition of view `cobrosrecfacview`
--

DROP TABLE IF EXISTS `cobrosrecfacview`;
DROP VIEW IF EXISTS `cobrosrecfacview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrosrecfacview` AS select `c`.`idcomproba` AS `idcomproba`,`c`.`idregipago` AS `idrecibo`,`c`.`idfactura` AS `idfactura`,`c`.`imputado` AS `imputado`,`c`.`recargo` AS `recargo`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,`f`.`apellido` AS `apellido`,`f`.`nombre` AS `nombre`,`f`.`fecha` AS `fechafac`,`f`.`pventa` AS `pventa`,`f`.`tipo` AS `tipo`,`f`.`numero` AS `numero`,`f`.`total` AS `totalfact`,`r`.`fecha` AS `fechareci`,`r`.`importe` AS `totalreci` from ((((`cobros` `c` left join `facturas` `f` on((`f`.`idfactura` = `c`.`idfactura`))) left join `recibos` `r` on(((`c`.`idregipago` = `r`.`idrecibo`) and (`c`.`idcomproba` = `r`.`idcomproba`)))) left join `comprobantes` `p` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`tabla` = 'recibos') and (`r`.`idrecibo` = `u`.`id`)))) where ((`p`.`tabla` = 'recibos') and (`u`.`idestador` <> 2));

--
-- Definition of view `cobrosrecfacview1`
--

DROP TABLE IF EXISTS `cobrosrecfacview1`;
DROP VIEW IF EXISTS `cobrosrecfacview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrosrecfacview1` AS select `c`.`idcomproba` AS `idcomproba`,`c`.`idregipago` AS `idrecibo`,`c`.`idfactura` AS `idfactura`,`c`.`imputado` AS `imputado`,`c`.`recargo` AS `recargo`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,`f`.`apellido` AS `apellido`,`f`.`nombre` AS `nombre`,`f`.`fecha` AS `fechafac`,`f`.`pventa` AS `pventa`,`f`.`tipo` AS `tipo`,`f`.`numero` AS `numero`,`f`.`total` AS `totalfact`,`r`.`fecha` AS `fechareci`,`r`.`importe` AS `totalreci` from ((((`cobros` `c` left join `facturas` `f` on((`f`.`idfactura` = `c`.`idfactura`))) left join `recibos` `r` on(((`c`.`idregipago` = `r`.`idrecibo`) and (`c`.`idcomproba` = `r`.`idcomproba`)))) left join `comprobantes` `p` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`tabla` = 'recibos') and (`r`.`idrecibo` = `u`.`id`)))) where ((`c`.`idregipago` = `_sqlidrecibo`()) and (`p`.`tabla` = 'recibos') and (`u`.`idestador` <> 2));

--
-- Definition of view `cobrosrecserview`
--

DROP TABLE IF EXISTS `cobrosrecserview`;
DROP VIEW IF EXISTS `cobrosrecserview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrosrecserview` AS select `cobrosrecfacview`.`idrecibo` AS `idrecibo`,`cobrosrecfacview`.`servicio` AS `servicio`,sum(`cobrosrecfacview`.`imputado`) AS `imputado`,`cobrosrecfacview`.`totalreci` AS `totalreci`,`cobrosrecfacview`.`fechareci` AS `fechareci` from `cobrosrecfacview` group by `cobrosrecfacview`.`idrecibo`,`cobrosrecfacview`.`servicio` union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,`r`.`importe` AS `importe`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from `recibos` `r` where ((not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and (not(`r`.`idrecibo` in (select `cobrosrecfacview`.`idrecibo` from `cobrosrecfacview`))))) union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,(`r`.`importe` - sum(`cv`.`imputado`)) AS `imputado`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from (`recibos` `r` left join `cobrosrecfacview` `cv` on(((`cv`.`idrecibo` = `r`.`idrecibo`) and (`cv`.`idcomproba` = `r`.`idcomproba`)))) where ((not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and `r`.`idrecibo` in (select `cobrosrecfacview`.`idrecibo` from `cobrosrecfacview`)) group by `r`.`idrecibo`);

--
-- Definition of view `cobrosrecserview1`
--

DROP TABLE IF EXISTS `cobrosrecserview1`;
DROP VIEW IF EXISTS `cobrosrecserview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `cobrosrecserview1` AS select `cobrosrecfacview1`.`idrecibo` AS `idrecibo`,`cobrosrecfacview1`.`servicio` AS `servicio`,sum(`cobrosrecfacview1`.`imputado`) AS `imputado`,`cobrosrecfacview1`.`totalreci` AS `totalreci`,`cobrosrecfacview1`.`fechareci` AS `fechareci` from `cobrosrecfacview1` where (`cobrosrecfacview1`.`idrecibo` = `_sqlidrecibo`()) group by `cobrosrecfacview1`.`idrecibo`,`cobrosrecfacview1`.`servicio` union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,`r`.`importe` AS `importe`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from `recibos` `r` where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and (not(`r`.`idrecibo` in (select `cobrosrecfacview1`.`idrecibo` from `cobrosrecfacview1`))))) union (select `r`.`idrecibo` AS `idrecibo`,99 AS `servicio`,(`r`.`importe` - sum(`cv`.`imputado`)) AS `imputado`,`r`.`importe` AS `totalreci`,`r`.`fecha` AS `fechareci` from (`recibos` `r` left join `cobrosrecfacview1` `cv` on(((`cv`.`idrecibo` = `r`.`idrecibo`) and (`cv`.`idcomproba` = `r`.`idcomproba`)))) where ((`r`.`idrecibo` = `_sqlidrecibo`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`idestador` = 2))))) and `r`.`idrecibo` in (select `cobrosrecfacview1`.`idrecibo` from `cobrosrecfacview1`)) group by `r`.`idrecibo`);

--
-- Definition of view `ctactefact`
--

DROP TABLE IF EXISTS `ctactefact`;
DROP VIEW IF EXISTS `ctactefact`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactefact` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from ((`facturas` `f` left join `comprobantes` `c` on((`f`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`t`.`ctacte` = 'S') and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`entidad`;

--
-- Definition of view `ctactefact1`
--

DROP TABLE IF EXISTS `ctactefact1`;
DROP VIEW IF EXISTS `ctactefact1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactefact1` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from ((`facturas` `f` left join `comprobantes` `c` on((`f`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`f`.`entidad` = `_sqlentidad`()) and (`t`.`ctacte` = 'S') and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`entidad`;

--
-- Definition of view `ctactepagos`
--

DROP TABLE IF EXISTS `ctactepagos`;
DROP VIEW IF EXISTS `ctactepagos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactepagos` AS select `p`.`entidad` AS `entidad`,sum((`p`.`importe` * `t`.`opera`)) AS `saldo` from ((`pagosprov` `p` left join `comprobantes` `c` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`t`.`ctacte` = 'S') and (not(`p`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`idestador` = 2)))))) group by `p`.`entidad`;

--
-- Definition of view `ctactepagos1`
--

DROP TABLE IF EXISTS `ctactepagos1`;
DROP VIEW IF EXISTS `ctactepagos1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactepagos1` AS select `p`.`entidad` AS `entidad`,sum((`p`.`importe` * `t`.`opera`)) AS `saldo` from ((`pagosprov` `p` left join `comprobantes` `c` on((`p`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `t` on((`c`.`idtipocompro` = `t`.`idtipocompro`))) where ((`p`.`entidad` = `_sqlentidad`()) and (`t`.`ctacte` = 'S') and (not(`p`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`idestador` = 2)))))) group by `p`.`entidad`;

--
-- Definition of view `ctacteprofact`
--

DROP TABLE IF EXISTS `ctacteprofact`;
DROP VIEW IF EXISTS `ctacteprofact`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacteprofact` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from (`factuprove` `f` left join `tipocompro` `t` on((`f`.`idtipocompro` = `t`.`idtipocompro`))) group by `f`.`entidad`;

--
-- Definition of view `ctacteprofact1`
--

DROP TABLE IF EXISTS `ctacteprofact1`;
DROP VIEW IF EXISTS `ctacteprofact1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacteprofact1` AS select `f`.`entidad` AS `entidad`,sum((`f`.`total` * `t`.`opera`)) AS `saldo` from (`factuprove` `f` left join `tipocompro` `t` on((`f`.`idtipocompro` = `t`.`idtipocompro`))) where (`f`.`entidad` = `_sqlentidad`()) group by `f`.`entidad`;

--
-- Definition of view `ctacteprosaldo`
--

DROP TABLE IF EXISTS `ctacteprosaldo`;
DROP VIEW IF EXISTS `ctacteprosaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacteprosaldo` AS select `e`.`entidad` AS `entidad`,(ifnull(`fac`.`saldo`,0) + ifnull(`pag`.`saldo`,0)) AS `saldo` from ((`entidades` `e` left join `ctacteprofact` `fac` on((`e`.`entidad` = `fac`.`entidad`))) left join `ctactepagos` `pag` on((`e`.`entidad` = `pag`.`entidad`)));

--
-- Definition of view `ctacteprosaldo1`
--

DROP TABLE IF EXISTS `ctacteprosaldo1`;
DROP VIEW IF EXISTS `ctacteprosaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctacteprosaldo1` AS select `e`.`entidad` AS `entidad`,(ifnull(`fac`.`saldo`,0) + ifnull(`pag`.`saldo`,0)) AS `saldo` from ((`entidades` `e` left join `ctacteprofact1` `fac` on((`e`.`entidad` = `fac`.`entidad`))) left join `ctactepagos1` `pag` on((`e`.`entidad` = `pag`.`entidad`))) where (`e`.`entidad` = `_sqlentidad`());

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
-- Definition of view `ctactesaldo`
--

DROP TABLE IF EXISTS `ctactesaldo`;
DROP VIEW IF EXISTS `ctactesaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactesaldo` AS select `e`.`entidad` AS `entidad`,(ifnull(`fac`.`saldo`,0) + ifnull(`rec`.`saldo`,0)) AS `saldo` from ((`entidades` `e` left join `ctactefact` `fac` on((`e`.`entidad` = `fac`.`entidad`))) left join `ctacterec` `rec` on((`e`.`entidad` = `rec`.`entidad`)));

--
-- Definition of view `ctactesaldo1`
--

DROP TABLE IF EXISTS `ctactesaldo1`;
DROP VIEW IF EXISTS `ctactesaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ctactesaldo1` AS select `e`.`entidad` AS `entidad`,(ifnull(`fac`.`saldo`,0) + ifnull(`rec`.`saldo`,0)) AS `saldo` from ((`entidades` `e` left join `ctactefact1` `fac` on((`e`.`entidad` = `fac`.`entidad`))) left join `ctacterec1` `rec` on((`e`.`entidad` = `rec`.`entidad`))) where (`e`.`entidad` = `_sqlentidad`());

--
-- Definition of view `depostock`
--

DROP TABLE IF EXISTS `depostock`;
DROP VIEW IF EXISTS `depostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stocktot`,0) AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `a`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin`,ifnull(`p`.`pendiente`,0) AS `pendiente` from ((((`ajustestockh` `a` left join `tipomstock` `t` on((`a`.`idtipomov` = `t`.`idtipomov`))) left join `articulos` `m` on((`a`.`articulo` = `m`.`articulo`))) left join `articulostock` `u` on((`a`.`articulo` = `u`.`articulo`))) left join `artpendiente` `p` on((convert(`a`.`articulo` using utf8) = convert(`p`.`articulo` using utf8)))) where (not(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;

--
-- Definition of view `factuprovesaldo`
--

DROP TABLE IF EXISTS `factuprovesaldo`;
DROP VIEW IF EXISTS `factuprovesaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `factuprovesaldo` AS select `f`.`idfactprove` AS `idfactprov`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`factuprove` `f` left join `pagosprovfc` `c` on((`f`.`idfactprove` = `c`.`idfactprove`))) group by `f`.`idfactprove`;

--
-- Definition of view `factuprovesaldo1`
--

DROP TABLE IF EXISTS `factuprovesaldo1`;
DROP VIEW IF EXISTS `factuprovesaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `factuprovesaldo1` AS select `f`.`idfactprove` AS `idfactprov`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`factuprove` `f` left join `pagosprovfc` `c` on((`f`.`idfactprove` = `c`.`idfactprove`))) where (`f`.`entidad` = `_sqlentidad`()) group by `f`.`idfactprove`;

--
-- Definition of view `factuprovesaldof`
--

DROP TABLE IF EXISTS `factuprovesaldof`;
DROP VIEW IF EXISTS `factuprovesaldof`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `factuprovesaldof` AS select `f`.`idfactprove` AS `idfactprov`,`f`.`entidad` AS `entidad`,trim(concat(trim(`f`.`apellido`),' ',trim(`f`.`nombre`))) AS `nombre`,sum((ifnull(if(isnull(`r`.`idpago`),0,`c`.`imputado`),0) + ifnull(if(isnull(`n`.`idfactprove`),0,`c`.`imputado`),0))) AS `cobrado`,((`f`.`total` - sum(if(isnull(`r`.`idpago`),0,`c`.`imputado`))) - sum(if(isnull(`n`.`idfactprove`),0,`c`.`imputado`))) AS `saldof`,sum(`c`.`imputado`) AS `imputado`,`f`.`fecha` AS `fechafac`,`r`.`fecha` AS `fechacob`,`c`.`idpago` AS `idregipago`,`r`.`idpago` AS `idpago`,if(isnull(`r`.`idpago`),0,`r`.`importe`) AS `totrecibo`,`n`.`idfactprove` AS `idnc`,`n`.`fecha` AS `fechanc`,if(isnull(`n`.`idfactprove`),0,`n`.`total`) AS `totnc`,`c`.`idcomproba` AS `idcomproba`,`cm`.`comprobante` AS `comprobab`,`tc`.`opera` AS `operab`,`f`.`idcomproba` AS `idcomprof`,`fco`.`comprobante` AS `comprobaa`,`ftc`.`opera` AS `operaa` from (((((((`factuprove` `f` left join `pagosprovfc` `c` on((`f`.`idfactprove` = `c`.`idfactprove`))) left join `comprobantes` `cm` on((`cm`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `tc` on((`tc`.`idtipocompro` = `cm`.`idtipocompro`))) left join `comprobantes` `fco` on((`fco`.`idcomproba` = `f`.`idcomproba`))) left join `tipocompro` `ftc` on((`ftc`.`idtipocompro` = `fco`.`idtipocompro`))) left join `factuprove` `n` on(((`n`.`idfactprove` = `c`.`idpago`) and (`n`.`fecha` <= `_sqlfechadeu`()) and (`n`.`idcomproba` = `c`.`idcomproba`)))) left join `pagosprov` `r` on(((`r`.`idpago` = `c`.`idpago`) and (`r`.`fecha` <= `_sqlfechadeu`()) and (`r`.`idcomproba` = `c`.`idcomproba`)))) where ((`f`.`entidad` >= `_sqlentidadd`()) and (`f`.`entidad` <= `_sqlentidadh`()) and (`f`.`fecha` <= `_sqlfechadeu`()) and (not(`f`.`idfactprove` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'factuprove') and (`ultimoestado`.`campo` = 'idfactprove') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idfactprove`;

--
-- Definition of view `facturasaldo`
--

DROP TABLE IF EXISTS `facturasaldo`;
DROP VIEW IF EXISTS `facturasaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasaldo` AS select `f`.`idfactura` AS `idfactura`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) where (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2))))) group by `f`.`idfactura`;

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
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `facturasaldof` AS select `f`.`idfactura` AS `idfactura`,`f`.`entidad` AS `entidad`,`f`.`servicio` AS `servicio`,`f`.`cuenta` AS `cuenta`,trim(concat(trim(`f`.`apellido`),' ',trim(`f`.`nombre`))) AS `nombre`,`f`.`total` AS `total`,sum(ifnull(if(isnull(`r`.`idrecibo`),0,`c`.`imputado`),0)) AS `cobrado`,(((`f`.`total` * `ftc`.`opera`) - sum(if(isnull(`r`.`idrecibo`),0,`c`.`imputado`))) - sum(if(isnull(`n`.`idfactura`),0,(`c`.`imputado` * `ftc`.`opera`)))) AS `saldof`,sum(`c`.`imputado`) AS `imputado`,`f`.`fecha` AS `fechafac`,`r`.`fecha` AS `fechacob`,`c`.`idregipago` AS `idregipago`,`r`.`idrecibo` AS `idrecibo`,if(isnull(`r`.`idrecibo`),0,`r`.`importe`) AS `totrecibo`,`n`.`idfactura` AS `idnc`,`n`.`fecha` AS `fechanc`,if(isnull(`n`.`idfactura`),0,`n`.`total`) AS `totnc`,`tc`.`opera` AS `opera`,`c`.`idcomproba` AS `idcomproba`,`cm`.`comprobante` AS `comprobab`,ifnull(`se`.`detalle`,'  ') AS `detaservi`,`f`.`idcomproba` AS `idcomprof`,`fco`.`comprobante` AS `comprobaa`,`ftc`.`opera` AS `fopera` from ((((((((`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) left join `comprobantes` `cm` on((`cm`.`idcomproba` = `c`.`idcomproba`))) left join `tipocompro` `tc` on((`tc`.`idtipocompro` = `cm`.`idtipocompro`))) left join `comprobantes` `fco` on((`fco`.`idcomproba` = `f`.`idcomproba`))) left join `tipocompro` `ftc` on((`ftc`.`idtipocompro` = `fco`.`idtipocompro`))) left join `servicios` `se` on((`se`.`servicio` = `f`.`servicio`))) left join `facturas` `n` on(((`n`.`idfactura` = `c`.`idregipago`) and (`n`.`fecha` <= `_sqlfechadeu`()) and (`n`.`idcomproba` = `c`.`idcomproba`)))) left join `recibos` `r` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`fecha` <= `_sqlfechadeu`()) and (`r`.`idcomproba` = `c`.`idcomproba`)))) where ((`f`.`entidad` >= `_sqlentidadd`()) and (`f`.`entidad` <= `_sqlentidadh`()) and (`f`.`fecha` <= `_sqlfechadeu`()) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idfactura`;

--
-- Definition of view `facturasctasaldo`
--

DROP TABLE IF EXISTS `facturasctasaldo`;
DROP VIEW IF EXISTS `facturasctasaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasctasaldo` AS select `f`.`idcuotafc` AS `idcuotafc`,`f`.`cuota` AS `cuota`,`f`.`idfactura` AS `idfactura`,`f`.`importe` AS `importe`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`facturascta` `f` left join `cobros` `c` on((`f`.`idcuotafc` = `c`.`idcuotafc`))) where ((not(`f`.`idcuotafc` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturascta') and (`ultimoestado`.`campo` = 'idcuotafc') and (`ultimoestado`.`idestador` = 2))))) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idcuotafc`;

--
-- Definition of view `facturasctasaldo1`
--

DROP TABLE IF EXISTS `facturasctasaldo1`;
DROP VIEW IF EXISTS `facturasctasaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasctasaldo1` AS select `f`.`idcuotafc` AS `idcuotafc`,`f`.`cuota` AS `cuota`,`f`.`idfactura` AS `idfactura`,`f`.`importe` AS `importe`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldof`,`a`.`entidad` AS `entidad` from ((`facturascta` `f` left join `cobros` `c` on((`f`.`idcuotafc` = `c`.`idcuotafc`))) left join `facturas` `a` on((`a`.`idfactura` = `f`.`idfactura`))) where ((`a`.`entidad` = `_sqlentidad`()) and (not(`f`.`idcuotafc` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturascta') and (`ultimoestado`.`campo` = 'idcuotafc') and (`ultimoestado`.`idestador` = 2))))) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idcuotafc`;

--
-- Definition of view `maxidartcosto`
--

DROP TABLE IF EXISTS `maxidartcosto`;
DROP VIEW IF EXISTS `maxidartcosto`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `maxidartcosto` AS select max(`a`.`idartcosto`) AS `idartcosto`,`a`.`articulo` AS `articulo` from `articostos` `a` group by `a`.`articulo`;

--
-- Definition of view `maxidestados`
--

DROP TABLE IF EXISTS `maxidestados`;
DROP VIEW IF EXISTS `maxidestados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `maxidestados` AS select max(`estadosreg`.`idestadosreg`) AS `idestadosreg`,`estadosreg`.`tabla` AS `tabla`,`estadosreg`.`campo` AS `campo`,`estadosreg`.`id` AS `id` from `estadosreg` group by `estadosreg`.`tabla`,`estadosreg`.`campo`,`estadosreg`.`id`;

--
-- Definition of view `maxidtipop`
--

DROP TABLE IF EXISTS `maxidtipop`;
DROP VIEW IF EXISTS `maxidtipop`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `maxidtipop` AS select max(`movitpago`.`idmovitp`) AS `idmovitp`,`movitpago`.`tabla` AS `tabla`,`movitpago`.`campo` AS `campo`,`movitpago`.`idregistro` AS `idregistro` from `movitpago` group by `movitpago`.`tabla`,`movitpago`.`campo`,`movitpago`.`idregistro`;

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
-- Definition of view `otpendientes`
--

DROP TABLE IF EXISTS `otpendientes`;
DROP VIEW IF EXISTS `otpendientes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otpendientes` AS select `o`.`idot` AS `idot`,`o`.`articulo` AS `articulo`,`o`.`cantidad` AS `cantidad`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantcump`,(`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendiente` from (`ot` `o` left join `cumplimentah` `h` on((`o`.`idot` = `h`.`idot`))) group by `o`.`idot`;

--
-- Definition of view `pagospagfacview`
--

DROP TABLE IF EXISTS `pagospagfacview`;
DROP VIEW IF EXISTS `pagospagfacview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagospagfacview` AS select `p`.`idcomproba` AS `idcomproba`,`p`.`idpago` AS `idpago`,`p`.`idfactprove` AS `idfactprove`,`p`.`imputado` AS `imputado`,`f`.`entidad` AS `entidad`,`f`.`apellido` AS `apellido`,`f`.`nombre` AS `nombre`,`f`.`fecha` AS `fechafac`,`f`.`tipo` AS `tipo`,`f`.`actividad` AS `actividad`,`f`.`numero` AS `numero`,`f`.`total` AS `totalfact`,`r`.`fecha` AS `fechapago`,`r`.`importe` AS `totalpago` from ((((`pagosprovfc` `p` left join `factuprove` `f` on((`f`.`idfactprove` = `p`.`idfactprove`))) left join `pagosprov` `r` on(((`p`.`idpago` = `r`.`idpago`) and (`p`.`idcomproba` = `r`.`idcomproba`)))) left join `comprobantes` `c` on((`c`.`idcomproba` = `p`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`tabla` = 'pagosprov') and (`r`.`idpago` = `u`.`id`)))) where ((`c`.`tabla` = 'pagosprov') and (`u`.`idestador` <> 2));

--
-- Definition of view `pagospagfacview1`
--

DROP TABLE IF EXISTS `pagospagfacview1`;
DROP VIEW IF EXISTS `pagospagfacview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagospagfacview1` AS select `p`.`idcomproba` AS `idcomproba`,`p`.`idpago` AS `idpago`,`p`.`idfactprove` AS `idfactprove`,`p`.`imputado` AS `imputado`,`f`.`entidad` AS `entidad`,`f`.`apellido` AS `apellido`,`f`.`nombre` AS `nombre`,`f`.`fecha` AS `fechafac`,`f`.`tipo` AS `tipo`,`f`.`actividad` AS `actividad`,`f`.`numero` AS `numero`,`f`.`total` AS `totalfact`,`r`.`fecha` AS `fechapago`,`r`.`importe` AS `totalpago` from ((((`pagosprovfc` `p` left join `factuprove` `f` on((`f`.`idfactprove` = `p`.`idfactprove`))) left join `pagosprov` `r` on(((`p`.`idpago` = `r`.`idpago`) and (`p`.`idcomproba` = `r`.`idcomproba`)))) left join `comprobantes` `c` on((`c`.`idcomproba` = `p`.`idcomproba`))) left join `ultimoestado` `u` on(((`u`.`tabla` = 'pagosprov') and (`r`.`idpago` = `u`.`id`)))) where ((`p`.`idpago` = `_sqlidpago`()) and (`c`.`tabla` = 'pagosprov') and (`u`.`idestador` <> 2));

--
-- Definition of view `pagospagsertvw`
--

DROP TABLE IF EXISTS `pagospagsertvw`;
DROP VIEW IF EXISTS `pagospagsertvw`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagospagsertvw` AS select `pagospagserview`.`idpago` AS `idpago`,`pagospagserview`.`fechapago` AS `fecha`,`pagospagserview`.`totalpago` AS `imptotal`,`pagospagserview`.`servicio` AS `servicio`,round(`pagospagserview`.`imputado`,2) AS `imputado` from `pagospagserview` where (`pagospagserview`.`imputado` > 0) order by `pagospagserview`.`idpago`,`pagospagserview`.`servicio`;

--
-- Definition of view `pagospagsertvw1`
--

DROP TABLE IF EXISTS `pagospagsertvw1`;
DROP VIEW IF EXISTS `pagospagsertvw1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagospagsertvw1` AS select `pagospagserview1`.`idpago` AS `idpago`,`pagospagserview1`.`fechapago` AS `fecha`,`pagospagserview1`.`totalpago` AS `imptotal`,`pagospagserview1`.`servicio` AS `servicio`,round(`pagospagserview1`.`imputado`,2) AS `imputado` from `pagospagserview1` where (`pagospagserview1`.`imputado` > 0) order by `pagospagserview1`.`idpago`,`pagospagserview1`.`servicio`;

--
-- Definition of view `pagospagserview`
--

DROP TABLE IF EXISTS `pagospagserview`;
DROP VIEW IF EXISTS `pagospagserview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagospagserview` AS select `pagospagfacview`.`idpago` AS `idpago`,0 AS `servicio`,sum(`pagospagfacview`.`imputado`) AS `imputado`,`pagospagfacview`.`totalpago` AS `totalpago`,`pagospagfacview`.`fechapago` AS `fechapago` from `pagospagfacview` group by `pagospagfacview`.`idpago` union (select `r`.`idpago` AS `idpago`,99 AS `servicio`,`r`.`importe` AS `importe`,`r`.`importe` AS `totalpago`,`r`.`fecha` AS `fechapago` from `pagosprov` `r` where ((not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`idestador` = 2))))) and (not(`r`.`idpago` in (select `pagospagfacview`.`idpago` from `pagospagfacview`))))) union (select `r`.`idpago` AS `idpago`,99 AS `servicio`,(`r`.`importe` - sum(`cv`.`imputado`)) AS `imputado`,`r`.`importe` AS `totalpago`,`r`.`fecha` AS `fechapago` from (`pagosprov` `r` left join `pagospagfacview` `cv` on(((`cv`.`idpago` = `r`.`idpago`) and (`cv`.`idcomproba` = `r`.`idcomproba`)))) where ((not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`idestador` = 2))))) and `r`.`idpago` in (select `pagospagfacview`.`idpago` from `pagospagfacview`)) group by `r`.`idpago`);

--
-- Definition of view `pagospagserview1`
--

DROP TABLE IF EXISTS `pagospagserview1`;
DROP VIEW IF EXISTS `pagospagserview1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagospagserview1` AS select `pagospagfacview`.`idpago` AS `idpago`,0 AS `servicio`,sum(`pagospagfacview`.`imputado`) AS `imputado`,`pagospagfacview`.`totalpago` AS `totalpago`,`pagospagfacview`.`fechapago` AS `fechapago` from `pagospagfacview` where (`pagospagfacview`.`idpago` = `_sqlidpago`()) group by `pagospagfacview`.`idpago` union (select `r`.`idpago` AS `idpago`,99 AS `servicio`,`r`.`importe` AS `importe`,`r`.`importe` AS `totalpago`,`r`.`fecha` AS `fechapago` from `pagosprov` `r` where ((`r`.`idpago` = `_sqlidpago`()) and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`r`.`idpago` = `_sqlidpago`()) and (`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`idestador` = 2))))) and (not(`r`.`idpago` in (select `pagospagfacview`.`idpago` from `pagospagfacview`))))) union (select `r`.`idpago` AS `idpago`,99 AS `servicio`,(`r`.`importe` - sum(`cv`.`imputado`)) AS `imputado`,`r`.`importe` AS `totalpago`,`r`.`fecha` AS `fechapago` from (`pagosprov` `r` left join `pagospagfacview` `cv` on(((`cv`.`idpago` = `r`.`idpago`) and (`cv`.`idcomproba` = `r`.`idcomproba`)))) where ((`r`.`idpago` = `_sqlidpago`()) and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`idestador` = 2))))) and `r`.`idpago` in (select `pagospagfacview`.`idpago` from `pagospagfacview`)) group by `r`.`idpago`);

--
-- Definition of view `pagosprovdtp`
--

DROP TABLE IF EXISTS `pagosprovdtp`;
DROP VIEW IF EXISTS `pagosprovdtp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagosprovdtp` AS select `p`.`idpago` AS `idpago`,`d`.`iddetapago` AS `iddetapago`,`d`.`idtipopago` AS `idtipopago`,`t`.`detalle` AS `detatipo`,`d`.`importe` AS `importe`,`t`.`opera` AS `opera`,`d`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detacta`,`c`.`idbanco` AS `idbanco`,`c`.`cuentabco` AS `cuentabco` from (((`pagosprov` `p` left join `detallepagos` `d` on(((`p`.`idcomproba` = `d`.`idcomproba`) and (`p`.`idpago` = `d`.`idregistro`)))) left join `tipopagos` `t` on((`t`.`idtipopago` = `d`.`idtipopago`))) left join `cajabancos` `c` on((`c`.`idcuenta` = `d`.`idcuenta`)));

--
-- Definition of view `pagosprovsaldo`
--

DROP TABLE IF EXISTS `pagosprovsaldo`;
DROP VIEW IF EXISTS `pagosprovsaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagosprovsaldo` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,`r`.`idpago` AS `idpago`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`pagosprov` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `pagosprovfc` `c` on((`r`.`idpago` = `c`.`idpago`))) where ((`cp`.`tabla` = 'pagosprov') and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idpago`;

--
-- Definition of view `pagosprovsaldo1`
--

DROP TABLE IF EXISTS `pagosprovsaldo1`;
DROP VIEW IF EXISTS `pagosprovsaldo1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `pagosprovsaldo1` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,`r`.`idpago` AS `idpago`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`pagosprov` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `pagosprovfc` `c` on(((`r`.`idpago` = `c`.`idpago`) and (`r`.`idcomproba` = `c`.`idcomproba`)))) where ((`r`.`entidad` = `_sqlentidad`()) and (`cp`.`tabla` = 'pagosprov') and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idpago`;

--
-- Definition of view `pagosprovsaldof`
--

DROP TABLE IF EXISTS `pagosprovsaldof`;
DROP VIEW IF EXISTS `pagosprovsaldof`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `pagosprovsaldof` AS select `r`.`idcomproba` AS `idcomproba`,`r`.`idpago` AS `idpago`,`r`.`numero` AS `numero`,`r`.`entidad` AS `entidad`,trim(concat(trim(`r`.`apellido`),' ',trim(`r`.`nombre`))) AS `nombre`,(ifnull(sum(`c`.`imputado`),0) - if((ifnull(`f`.`idfactprove`,0) = 0),ifnull(sum(`c`.`imputado`),0),0)) AS `totimputado`,`r`.`importe` AS `importe`,(`r`.`importe` - (ifnull(sum(`c`.`imputado`),0) - if((ifnull(`f`.`idfactprove`,0) = 0),ifnull(sum(`c`.`imputado`),0),0))) AS `saldo`,`r`.`fecha` AS `fecha`,`c`.`idpagosprovfc` AS `idpagosprovfc`,`f`.`idfactprove` AS `idfactprove`,`f`.`fecha` AS `fechafac` from (((`pagosprov` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `pagosprovfc` `c` on(((`r`.`idpago` = `c`.`idpago`) and (`r`.`idcomproba` = `c`.`idcomproba`)))) left join `factuprove` `f` on(((`f`.`idfactprove` = `c`.`idfactprove`) and (`f`.`fecha` <= `_sqlfechadeu`())))) where ((`r`.`entidad` >= `_sqlentidadd`()) and (`r`.`entidad` <= `_sqlentidadh`()) and (`cp`.`tabla` = 'pagosprov') and (`r`.`fecha` <= `_sqlfechadeu`()) and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov') and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idpago`;

--
-- Definition of view `recibosdtp`
--

DROP TABLE IF EXISTS `recibosdtp`;
DROP VIEW IF EXISTS `recibosdtp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibosdtp` AS select `r`.`idrecibo` AS `idrecibo`,`d`.`iddetacobro` AS `iddetacobro`,`d`.`idtipopago` AS `idtipopago`,`t`.`detalle` AS `detatipo`,`d`.`importe` AS `importe`,`t`.`opera` AS `opera`,`d`.`idcuenta` AS `idcuenta`,`c`.`codcuenta` AS `codcuenta`,`c`.`detalle` AS `detacta`,`c`.`idbanco` AS `idbanco`,`c`.`cuentabco` AS `cuentabco` from (((`recibos` `r` left join `detallecobros` `d` on(((`r`.`idcomproba` = `d`.`idcomproba`) and (`r`.`idrecibo` = `d`.`idregistro`)))) left join `tipopagos` `t` on((`t`.`idtipopago` = `d`.`idtipopago`))) left join `cajabancos` `c` on((`c`.`idcuenta` = `d`.`idcuenta`)));

--
-- Definition of view `recibossaldo`
--

DROP TABLE IF EXISTS `recibossaldo`;
DROP VIEW IF EXISTS `recibossaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `recibossaldo` AS select `r`.`idcomproba` AS `idcomproba`,ifnull(sum(`c`.`imputado`),0) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`idrecibo` AS `idrecibo`,`r`.`importe` AS `importe`,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0)) AS `saldo` from ((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`idcomproba` = `c`.`idcomproba`)))) where ((`cp`.`tabla` = 'recibos') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;

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
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `recibossaldof` AS select `r`.`idcomproba` AS `idcomproba`,`r`.`idrecibo` AS `idrecibo`,`r`.`numero` AS `numero`,`r`.`entidad` AS `entidad`,trim(concat(trim(`r`.`apellido`),' ',trim(`r`.`nombre`))) AS `nombre`,(ifnull(sum(`c`.`imputado`),0) - if((ifnull(`f`.`idfactura`,0) = 0),ifnull(sum(`c`.`imputado`),0),0)) AS `totimputado`,ifnull(sum(`c`.`recargo`),0) AS `totrecargo`,`r`.`importe` AS `importe`,(`r`.`importe` - (ifnull(sum(`c`.`imputado`),0) - if((ifnull(`f`.`idfactura`,0) = 0),ifnull(sum(`c`.`imputado`),0),0))) AS `saldo`,`r`.`fecha` AS `fecha`,`c`.`idcobro` AS `idcobro`,`f`.`idfactura` AS `idfactura`,`f`.`fecha` AS `fechafac` from (((`recibos` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`))) left join `cobros` `c` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`idcomproba` = `c`.`idcomproba`)))) left join `facturas` `f` on(((`f`.`idfactura` = `c`.`idfactura`) and (`f`.`fecha` <= `_sqlfechadeu`())))) where ((`r`.`entidad` >= `_sqlentidadd`()) and (`r`.`entidad` <= `_sqlentidadh`()) and (`cp`.`tabla` = 'recibos') and (`r`.`fecha` <= `_sqlfechadeu`()) and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`idestador` = 2)))))) group by `r`.`idrecibo`;

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
-- Definition of view `ultimoartcosto`
--

DROP TABLE IF EXISTS `ultimoartcosto`;
DROP VIEW IF EXISTS `ultimoartcosto`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultimoartcosto` AS select `a`.`idartcosto` AS `idartcosto`,`a`.`articulo` AS `articulo`,`a`.`costo` AS `costo`,`a`.`fecha` AS `fecha` from (`maxidartcosto` `m` left join `articostos` `a` on((`m`.`idartcosto` = `a`.`idartcosto`)));

--
-- Definition of view `ultimoestado`
--

DROP TABLE IF EXISTS `ultimoestado`;
DROP VIEW IF EXISTS `ultimoestado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultimoestado` AS select `e`.`tabla` AS `tabla`,`e`.`campo` AS `campo`,`e`.`id` AS `id`,`e`.`idestador` AS `idestador`,`e`.`tipo` AS `tipo`,`e`.`fecha` AS `fechaest` from (`maxidestados` `m` left join `estadosreg` `e` on((`m`.`idestadosreg` = `e`.`idestadosreg`)));

--
-- Definition of view `ultimomovitpago`
--

DROP TABLE IF EXISTS `ultimomovitpago`;
DROP VIEW IF EXISTS `ultimomovitpago`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultimomovitpago` AS select `t`.`idmovitp` AS `idmovitp`,`t`.`idtipopago` AS `idtipopago`,`t`.`tabla` AS `tabla`,`t`.`campo` AS `campo`,`t`.`idregistro` AS `idregistro`,`t`.`idcajareca` AS `idcajareca`,`t`.`idcuenta` AS `idcuenta`,`t`.`fecha` AS `fecha`,`t`.`hora` AS `hora`,`t`.`movimiento` AS `movimiento` from (`maxidtipop` `m` left join `movitpago` `t` on((`m`.`idmovitp` = `t`.`idmovitp`)));



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
