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
-- Definition of table `comprobantes`
--

DROP TABLE IF EXISTS `comprobantes`;
CREATE TABLE `comprobantes` (
  `idcomproba` int(10) unsigned NOT NULL,
  `comprobante` char(100) NOT NULL,
  `idtipocompro` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `tabla` char(50) NOT NULL,
  `ctacte` char(1) NOT NULL,
  `astoconta` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`idcomproba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comprobantes`
--

/*!40000 ALTER TABLE `comprobantes` DISABLE KEYS */;
INSERT INTO `comprobantes` (`idcomproba`,`comprobante`,`idtipocompro`,`tipo`,`tabla`,`ctacte`,`astoconta`) VALUES 
 (1,'FACTURA A',1,'A','facturas','S','S'),
 (3,'AJUSTE DE STOCK',4,'X','ajustestockp','','S'),
 (4,'FACTURAE',1,'A','facturas','','S'),
 (5,'RECIBO A',5,'A','recibos','','S'),
 (6,'AJUSTE STOCK DE MATERIALES',4,'X','otmovistockp','','N'),
 (7,'NOTA DE DEBITO A',6,'A','facturas','','N'),
 (8,'NOTA DE CREDITO A',7,'A','facturas','','N'),
 (9,'NOTA DE CREDITO A',7,'A','facturas','','N'),
 (10,'FACTURA B',8,'B','facturas','','N'),
 (11,'NOTA DE CREDITO B',10,'B','facturas','','N'),
 (12,'NOTA DE DEBITO B',9,'B','facturas','','N'),
 (13,'RECIBO B',11,'B','recibos','','N'),
 (14,'RECIBO',16,'X','recibos','','N'),
 (15,'REMITO R',17,'R','remitos','','S'),
 (16,'NOTA DE PEDIDO',2,'X','np','','N'),
 (17,'FACTURA PROV A',18,'A','factuprove','','S'),
 (18,'FACTURA PROV B',19,'B','factuprove','','S'),
 (19,'FACTURA PROV C',20,'C','factuprove','','N'),
 (20,'ORDEN DE PAGO',21,'X','pagosprov','','S'),
 (21,'NOTA DE CREDITO PROV A',22,'A','factuprove','','N'),
 (22,'CAJA INGRESO',28,'X','cajaie','','S'),
 (23,'CAJA EGRESO',29,'X','cajaie','','S'),
 (24,'FACTURA A MiPyMEs',30,'A','facturas','S','N'),
 (25,'TRANSFERENCIAS',39,'T','transferencias','','S'),
 (26,'TRANSFERENCIA DE CAJA',40,'T','cajamovip','N','S'),
 (27,'ANULA RECIBOS',41,'X','anularp','N','N'),
 (28,'ANULA ORDEN PAGO',42,'X','anularp','N','N'),
 (29,'FACTURA A',1,'A','facturas','S','N'),
 (30,'LIQUIDACION CUPONES',43,'X','factuprove','S','S');
/*!40000 ALTER TABLE `comprobantes` ENABLE KEYS */;


--
-- Definition of table `factuprovec`
--

DROP TABLE IF EXISTS `factuprovec`;
CREATE TABLE `factuprovec` (
  `idfacprovc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idfactprove` int(10) unsigned NOT NULL,
  `idcupon` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfacprovc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factuprovec`
--

/*!40000 ALTER TABLE `factuprovec` DISABLE KEYS */;
/*!40000 ALTER TABLE `factuprovec` ENABLE KEYS */;


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
 (27,'NOTA DE DEBITO PROV C',-1,'ND PROV C','S','N',0,'S'),
 (28,'CAJA INGRESO',1,'CI','S','N',0,'N'),
 (29,'CAJA EGRESO',-1,'CE','S','N',0,'N'),
 (30,'FACTURA A MiPyMEs',1,'FACTURA A MiPyMEs','S','N',16,''),
 (31,'NOTA DE CREDITO A MiPyMEs',-1,'NC A MiPyME','S','N',18,''),
 (32,'NOTA DE CREDITO B MiPyMEs',-1,'NC B MiPyME','S','N',21,''),
 (33,'NOTA DE CREDITO C MiPyMEs',-1,'NC C MiPyME','S','N',24,''),
 (34,'FACTURA B MiPyMEs',1,'FC B MiPyME','S','N',19,''),
 (35,'FACTURA C MiPyMEs',1,'FC C MiPyMEs','S','N',22,''),
 (36,'NOTA DE DEBITO A MiPyMEs',-1,'ND A MiPyME','S','N',17,''),
 (37,'NOTA DE DEBITO B MiPyMEs',1,'ND B MiPyME','S','N',20,''),
 (38,'NOTA DE DEBITO C MiPyMEs',1,'ND C MiPyMEs','S','N',23,''),
 (39,'TRANSFERENCIAS',1,'TR','S','N',0,''),
 (40,'TRANSFERENCIAS DE CAJAS',1,'TC','S','N',0,''),
 (41,'ANULA RECIBOS',1,'AR','S','N',0,''),
 (42,'ANULA ORDEN PAGO',-1,'AOP','S','N',0,''),
 (43,'LIQUIDACION CUPONES',-1,'LIQ CUPONES','S','N',0,'');
/*!40000 ALTER TABLE `tipocompro` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
