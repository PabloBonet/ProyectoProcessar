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
-- Definition of table `comprobantes`
--

DROP TABLE IF EXISTS `comprobantes`;
CREATE TABLE `comprobantes` (
  `idcomproba` int(10) unsigned NOT NULL,
  `comprobante` char(100) NOT NULL,
  `idtipocompro` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `tabla` char(50) NOT NULL,
  PRIMARY KEY (`idcomproba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comprobantes`
--

/*!40000 ALTER TABLE `comprobantes` DISABLE KEYS */;
INSERT INTO `comprobantes` (`idcomproba`,`comprobante`,`idtipocompro`,`tipo`,`tabla`) VALUES 
 (1,'FACTURA A',1,'A','facturas'),
 (3,'AJUSTE DE STOCK',4,'X','ajustestockp'),
 (4,'FACTURAE',1,'A','facturas'),
 (5,'RECIBO A',5,'A','recibos'),
 (6,'AJUSTE STOCK DE MATERIALES',4,'X','otmovistockp'),
 (7,'NOTA DE DEBITO A',6,'A','facturas'),
 (8,'NOTA DE CREDITO A',7,'A','facturas'),
 (9,'NOTA DE CREDITO A',7,'','facturas'),
 (10,'FACTURA B',8,'B','facturas'),
 (11,'NOTA DE CREDITO B',10,'B','facturas'),
 (12,'NOTA DE DEBITO B',9,'B','facturas'),
 (13,'RECIBO B',11,'B','recibos'),
 (14,'RECIBO',16,'X','recibos'),
 (15,'REMITO R',17,'R','remitos'),
 (16,'NOTA DE PEDIDO',2,'X','np'),
 (17,'FACTURA PROV A',18,'A','factuprove'),
 (18,'FACTURA PROV B',19,'B','factuprove'),
 (19,'FACTURA PROV C',20,'C','factuprove'),
 (20,'ORDEN DE PAGO',21,'X','pagosprov'),
 (21,'NOTA DE CREDITO PROV A',22,'A','factuprove');
/*!40000 ALTER TABLE `comprobantes` ENABLE KEYS */;


--
-- Definition of table `tipocompro`
--

DROP TABLE IF EXISTS `tipocompro`;
CREATE TABLE `tipocompro` (
  `idtipocompro` int(10) unsigned NOT NULL,
  `detalle` char(100) NOT NULL,
  `opera` int(11) NOT NULL,
  `abrevia` char(50) NOT NULL,
  `destino` char(50) NOT NULL DEFAULT '',
  `editable` char(1) NOT NULL,
  `idafipcom` int(10) unsigned NOT NULL,
  `ctacte` char(1) NOT NULL,
  PRIMARY KEY (`idtipocompro`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipocompro`
--

/*!40000 ALTER TABLE `tipocompro` DISABLE KEYS */;
INSERT INTO `tipocompro` (`idtipocompro`,`detalle`,`opera`,`abrevia`,`destino`,`editable`,`idafipcom`,`ctacte`) VALUES 
 (1,'FACTURA A',1,'FACTURA A','S','N',1,'S'),
 (2,'NOTA DE PEDIDO',0,'NOTA DE PEDIDO','F','S',0,'N'),
 (3,'ID AJUSTE DE STOCK',0,'AJUSTE DE STOCK','S','N',0,'N'),
 (4,'AJUSTE DE STOCK',0,'STOCK','S','N',0,'N'),
 (5,'RECIBO A',-1,'RECIBO A','S','N',4,'S'),
 (6,'NOTA DE DEBITO A',1,'ND A','S','N',2,'S'),
 (7,'NOTA DE CREDITO A',-1,'NC A','S','N',3,'S'),
 (8,'FACTURA B',1,'FACTURA B','S','N',5,'S'),
 (9,'NOTA DE DEBITO B',1,'ND B','S','N',6,'S'),
 (10,'NOTA DE CREDITO B',-1,'NC B','S','N',7,'S'),
 (11,'RECIBO B',-1,'RECIBOS B','S','N',8,'S'),
 (12,'FACTURA C',1,'FACTURA C','S','N',9,'S'),
 (13,'NOTA DE DEBITO C',1,'ND C','S','N',10,'S'),
 (14,'NOTA DE CREDITO C',-1,'NC C','S','N',11,'S'),
 (15,'RECIBO C',-1,'RECIBO C','S','N',12,'S'),
 (16,'RECIBO',-1,'RECIBO','S','N',0,'S'),
 (17,'REMITO',0,'REMITO','S','N',13,'N'),
 (18,'FACTURA PROV A',-1,'FACTURA PROV A','S','N',0,'S'),
 (19,'FACTURA PROV B',-1,'FACTURA PROV B','S','N',0,'S'),
 (20,'FACTURA PROV C',-1,'FACTURA PROV C','S','N',0,'S'),
 (21,'ORDEN DE PAGO',1,'ORDEN DE PAGO','S','N',0,'S'),
 (22,'NOTA DE CREDITO PROV A',1,'NC PROV A','S','N',0,'S'),
 (23,'NOTA DE CREDITO PROV B',1,'NC PROV B','S','N',0,'S'),
 (24,'NOTA DE CREDITO PROV C',1,'NC PROV C','S','N',0,'S'),
 (25,'NOTA DE DEBITO PROV A',-1,'ND PROV C','S','N',0,'S'),
 (26,'NOTA DE DEBITO PROV B',-1,'ND PROV B','S','N',0,'S'),
 (27,'NOTA DE DEBITO PROV C',-1,'ND PROV C','S','N',0,'S');
/*!40000 ALTER TABLE `tipocompro` ENABLE KEYS */;


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



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
