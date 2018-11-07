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
  `stockTot` double(21,4)
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
-- Temporary table structure for view `maxidestados`
--
DROP TABLE IF EXISTS `maxidestados`;
DROP VIEW IF EXISTS `maxidestados`;
CREATE TABLE `maxidestados` (
  `maxid` int(10) unsigned,
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
  `stockTot` double(19,2)
);

--
-- Temporary table structure for view `totalclientes`
--
DROP TABLE IF EXISTS `totalclientes`;
DROP VIEW IF EXISTS `totalclientes`;

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
  `tipo` char(1)
);

--
-- Temporary table structure for view `vw_stock`
--
DROP TABLE IF EXISTS `vw_stock`;
DROP VIEW IF EXISTS `vw_stock`;

--
-- Definition of table `afipcompro`
--

DROP TABLE IF EXISTS `afipcompro`;
CREATE TABLE `afipcompro` (
  `idafipcom` int(10) unsigned NOT NULL,
  `codigo` char(10) NOT NULL,
  `detalle` char(100) NOT NULL,
  PRIMARY KEY (`idafipcom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `afipcompro`
--

/*!40000 ALTER TABLE `afipcompro` DISABLE KEYS */;
INSERT INTO `afipcompro` (`idafipcom`,`codigo`,`detalle`) VALUES 
 (1,'001','FACTURA A'),
 (2,'002','NOTA DE DEBITO A'),
 (3,'003','NOTA DE CREDITO A'),
 (4,'004','RECIBO A'),
 (5,'006','FACTURA B'),
 (6,'007','NOTA DE DEBITO B'),
 (7,'008','NOTA DE CREDITO B'),
 (8,'009','RECIBO B'),
 (9,'011','FACTURA C'),
 (10,'012','NOTA DE DEBITO C'),
 (11,'013','NOTA DE CREDITO C'),
 (12,'015','RECIBO C');
/*!40000 ALTER TABLE `afipcompro` ENABLE KEYS */;


--
-- Definition of table `afipimpuestos`
--

DROP TABLE IF EXISTS `afipimpuestos`;
CREATE TABLE `afipimpuestos` (
  `idafipimp` int(10) unsigned NOT NULL,
  `codigo` char(10) NOT NULL,
  `tipo` char(10) NOT NULL,
  `detalle` char(100) NOT NULL,
  PRIMARY KEY (`idafipimp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `afipimpuestos`
--

/*!40000 ALTER TABLE `afipimpuestos` DISABLE KEYS */;
INSERT INTO `afipimpuestos` (`idafipimp`,`codigo`,`tipo`,`detalle`) VALUES 
 (2,'4','IVA','IVA 10.5'),
 (5,'5','IVA','IVA 21');
/*!40000 ALTER TABLE `afipimpuestos` ENABLE KEYS */;


--
-- Definition of table `afiptipodocu`
--

DROP TABLE IF EXISTS `afiptipodocu`;
CREATE TABLE `afiptipodocu` (
  `idafiptipod` int(10) unsigned NOT NULL,
  `codafip` char(20) NOT NULL,
  `detalle` char(100) NOT NULL,
  PRIMARY KEY (`idafiptipod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `afiptipodocu`
--

/*!40000 ALTER TABLE `afiptipodocu` DISABLE KEYS */;
INSERT INTO `afiptipodocu` (`idafiptipod`,`codafip`,`detalle`) VALUES 
 (1,'96','DNI'),
 (2,'80','CUIT'),
 (3,'86','CUIL'),
 (4,'87','CDI'),
 (5,'89','LE'),
 (6,'90','LC'),
 (7,'99','VENTA DIARIA');
/*!40000 ALTER TABLE `afiptipodocu` ENABLE KEYS */;


--
-- Definition of table `ajustestocke`
--

DROP TABLE IF EXISTS `ajustestocke`;
CREATE TABLE `ajustestocke` (
  `idajuste` int(10) unsigned NOT NULL,
  `idajusteh` int(10) unsigned NOT NULL,
  `etiqueta` char(50) NOT NULL,
  PRIMARY KEY (`idajuste`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajustestocke`
--

/*!40000 ALTER TABLE `ajustestocke` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajustestocke` ENABLE KEYS */;


--
-- Definition of table `ajustestockh`
--

DROP TABLE IF EXISTS `ajustestockh`;
CREATE TABLE `ajustestockh` (
  `idajuste` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  `descmov` char(254) NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `idajusteh` int(10) unsigned NOT NULL,
  `renglon` int(10) unsigned NOT NULL,
  `neto` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `deposito` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idajusteh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajustestockh`
--

/*!40000 ALTER TABLE `ajustestockh` DISABLE KEYS */;
INSERT INTO `ajustestockh` (`idajuste`,`articulo`,`detalle`,`idtipomov`,`descmov`,`cantidad`,`idajusteh`,`renglon`,`neto`,`impuesto`,`total`,`deposito`) VALUES 
 (1,'0101001','Alambre de bajada c/autop.2 x 0.61',4,'EGRESO POR VENTA',2.0000,1,1,101.0000,42.4200,244.4200,1),
 (2,'0101002','Alambre de bajada PVC 2 x 0.81',4,'EGRESO POR VENTA',32.0000,2,1,102.0000,685.4400,3949.4399,1),
 (1,'0101001','Alambre de bajada c/autop.2 x 0.61',4,'EGRESO POR VENTA',35.0000,3,1,101.0000,749.7000,4284.7002,1),
 (1,'0101002','Alambre de bajada PVC 2 x 0.81',4,'EGRESO POR VENTA',46.0000,4,1,102.0000,985.3200,5677.3198,1),
 (2,'0101001','Alambre de bajada c/autop.2 x 0.61',4,'EGRESO POR VENTA',2.0000,5,1,101.0000,42.8400,244.8400,1),
 (2,'0101002','Alambre de bajada PVC 2 x 0.81',4,'EGRESO POR VENTA',3.0000,6,1,102.0000,64.2600,370.2600,1),
 (3,'0101001','Alambre de bajada c/autop.2 x 0.61',4,'EGRESO POR VENTA',35.0000,7,1,101.0000,742.3500,4277.3501,1),
 (1,'0101001','Alambre de bajada c/autop.2 x 0.61',4,'EGRESO POR VENTA',35.0000,8,1,101.0000,742.3500,4277.3501,1),
 (2,'0101002','Alambre de bajada PVC 2 x 0.81',4,'EGRESO POR VENTA',55.0000,9,1,102.0000,1178.1000,6788.1001,1),
 (3,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',35.0000,10,1,101.0000,749.7000,4284.7002,1),
 (4,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',35.0000,11,1,101.0000,742.3500,4277.3501,1),
 (4,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',35.0000,12,1,101.0000,742.3500,4277.3501,1),
 (5,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',35.0000,13,1,101.0000,749.7000,4284.7002,1),
 (5,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',54.0000,14,1,102.0000,1156.6801,6664.6802,1),
 (6,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',65.0000,15,1,101.0000,1378.6500,7943.6499,1),
 (5,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',35.0000,16,1,101.0000,742.3500,4277.3501,1),
 (7,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',8.0000,17,1,101.0000,171.3600,979.3600,1),
 (7,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',58.0000,18,1,102.0000,1242.3600,7158.3599,1),
 (8,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',3.0000,19,1,101.0000,63.6300,366.6300,1),
 (6,'0101001','Alambre de bajada c/autop.2 x 0.61',8,'INGRESO POR AJUSTE DE STOCK',25.0000,20,1,101.0000,530.2500,3055.2500,1),
 (7,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',30.0000,21,1,102.0000,642.6000,3702.6001,1),
 (8,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',5.0000,22,1,101.0000,107.1000,612.1000,1),
 (8,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',3.0000,23,1,102.0000,64.2600,370.2600,1),
 (9,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',5.0000,24,1,505.0000,107.1000,612.1000,1),
 (9,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',6.0000,25,1,612.0000,128.5200,740.5200,1),
 (10,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',2.0000,27,1,202.0000,42.4200,244.4200,1),
 (11,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',2.0000,28,1,202.0000,42.4200,244.4200,1),
 (13,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',3.0000,29,1,306.0000,64.2600,370.2600,1),
 (14,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',3.0000,30,1,303.0000,63.6300,366.6300,1),
 (15,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',2.0000,31,1,202.0000,42.4200,244.4200,1),
 (17,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',5.0000,32,1,505.0000,106.0500,611.0500,1),
 (25,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',1.0000,40,1,102.0000,21.4200,123.4200,1),
 (18,'0101001','Alambre de bajada c/autop.2 x 0.61',7,'EGRESO POR AJUSTE DE STOCK',111.0000,41,1,11211.0000,2354.3101,13565.3096,1),
 (19,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',2.0000,42,1,204.0000,42.8400,246.8400,1),
 (20,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',10.0000,43,1,1020.0000,214.2000,1234.2000,1),
 (21,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',5.0000,44,1,510.0000,107.1000,617.1000,1),
 (22,'0101002','Alambre de bajada PVC 2 x 0.81',7,'EGRESO POR AJUSTE DE STOCK',6.0000,45,1,612.0000,128.5200,740.5200,1),
 (23,'0101001','Alambre de bajada c/autop.2 x 0.61',8,'INGRESO POR AJUSTE DE STOCK',1.0000,46,1,101.0000,21.2100,122.2100,1),
 (24,'0101001','Alambre de bajada c/autop.2 x 0.61',8,'INGRESO POR AJUSTE DE STOCK',1.0000,47,1,101.0000,21.2100,122.2100,1);
/*!40000 ALTER TABLE `ajustestockh` ENABLE KEYS */;


--
-- Definition of table `ajustestockimp`
--

DROP TABLE IF EXISTS `ajustestockimp`;
CREATE TABLE `ajustestockimp` (
  `idajuste` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `puntov` char(4) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `detalle` char(200) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ajustestockimp`
--

/*!40000 ALTER TABLE `ajustestockimp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajustestockimp` ENABLE KEYS */;


--
-- Definition of table `ajustestockp`
--

DROP TABLE IF EXISTS `ajustestockp`;
CREATE TABLE `ajustestockp` (
  `idajuste` int(10) unsigned NOT NULL,
  `puntov` char(4) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `nombre` char(254) NOT NULL,
  `responsable` char(254) NOT NULL,
  `observa1` char(254) NOT NULL,
  `observa2` char(254) NOT NULL,
  `observa3` char(254) NOT NULL,
  `observa4` char(254) NOT NULL,
  `anulado` char(1) NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  `descmov` char(254) NOT NULL,
  `descdepo` char(254) NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idajuste`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajustestockp`
--

/*!40000 ALTER TABLE `ajustestockp` DISABLE KEYS */;
INSERT INTO `ajustestockp` (`idajuste`,`puntov`,`numero`,`fecha`,`entidad`,`nombre`,`responsable`,`observa1`,`observa2`,`observa3`,`observa4`,`anulado`,`idtipomov`,`descmov`,`descdepo`,`idcomproba`,`pventa`) VALUES 
 (1,'0001',1,'20170304',1,'ROSSI TULIO','FEDE','','','','','N',1,'ENTREGA MATERIALES POR PEDIDO DE CLIENTE','DEPOSITO 1',0,0),
 (2,'0001',2,'20170304',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','','N',1,'ENTREGA MATERIALES POR PEDIDO DE CLIENTE','DEPOSITO 1',0,0),
 (3,'0001',3,'20170306',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (4,'0001',4,'20170306',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (5,'0001',5,'20170306',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (6,'0001',6,'20170724',1,'ROSSI TULIO','FEDE','','','','','S',2,'INGRESO POR AJUSTE DE STOCK','',0,0),
 (7,'0001',7,'20170731',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','1','2','3','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (8,'0001',8,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (9,'0001',9,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (10,'0001',10,'20171009',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (11,'0001',11,'20171009',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (12,'0001',12,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (13,'0001',13,'20171009',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (14,'0001',14,'20171009',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (15,'0001',15,'20171009',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (16,'0001',16,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (18,'0001',18,'20171010',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (19,'0001',19,'20171010',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (20,'0001',20,'20171010',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (21,'0001',21,'20171010',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (22,'0001',22,'20171010',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (23,'0001',23,'20180131',1,'ROSSI TULIO','TULIO','','','','','N',2,'INGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (24,'0001',24,'20180131',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','TULIO','','','','','N',2,'INGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0),
 (25,'0001',25,'20171010',1,'ROSSI TULIO','FEDE','','','','','N',1,'EGRESO POR AJUSTE DE STOCK','Deposito Belgrano 1602',0,0);
/*!40000 ALTER TABLE `ajustestockp` ENABLE KEYS */;


--
-- Definition of table `anulados`
--

DROP TABLE IF EXISTS `anulados`;
CREATE TABLE `anulados` (
  `idanulado` int(10) unsigned NOT NULL,
  `idregistro` char(50) NOT NULL,
  `tipo` char(1) NOT NULL,
  `tabla` char(50) NOT NULL,
  PRIMARY KEY (`idanulado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `anulados`
--

/*!40000 ALTER TABLE `anulados` DISABLE KEYS */;
/*!40000 ALTER TABLE `anulados` ENABLE KEYS */;


--
-- Definition of table `arqueocajah`
--

DROP TABLE IF EXISTS `arqueocajah`;
CREATE TABLE `arqueocajah` (
  `idarqueo` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `tipovalor` char(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `arqueocajah`
--

/*!40000 ALTER TABLE `arqueocajah` DISABLE KEYS */;
/*!40000 ALTER TABLE `arqueocajah` ENABLE KEYS */;


--
-- Definition of table `arqueocajap`
--

DROP TABLE IF EXISTS `arqueocajap`;
CREATE TABLE `arqueocajap` (
  `idarqueo` int(10) unsigned NOT NULL,
  `idcajareca` int(10) unsigned NOT NULL,
  `usuario` char(50) NOT NULL,
  `fechad` char(50) NOT NULL,
  `fechah` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idarqueo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `arqueocajap`
--

/*!40000 ALTER TABLE `arqueocajap` DISABLE KEYS */;
/*!40000 ALTER TABLE `arqueocajap` ENABLE KEYS */;


--
-- Definition of table `articulos`
--

DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos` (
  `articulo` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unidad` char(200) NOT NULL,
  `abrevia` char(50) NOT NULL,
  `codbarra` char(100) NOT NULL,
  `costo` float(13,4) NOT NULL,
  `linea` char(20) NOT NULL,
  `ctrlstock` char(1) NOT NULL,
  `observa` char(254) NOT NULL,
  `ocultar` char(1) NOT NULL,
  `stockmin` float(13,4) NOT NULL,
  `desc1` float(13,4) NOT NULL,
  `desc2` float(13,4) NOT NULL,
  `desc3` float(13,4) NOT NULL,
  `desc4` float(13,4) NOT NULL,
  `desc5` float(13,4) NOT NULL,
  `moneda` int(10) unsigned NOT NULL,
  PRIMARY KEY (`articulo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articulos`
--

/*!40000 ALTER TABLE `articulos` DISABLE KEYS */;
INSERT INTO `articulos` (`articulo`,`detalle`,`unidad`,`abrevia`,`codbarra`,`costo`,`linea`,`ctrlstock`,`observa`,`ocultar`,`stockmin`,`desc1`,`desc2`,`desc3`,`desc4`,`desc5`,`moneda`) VALUES 
 ('0000001','Interés por financiación','pesos','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0000002','ND por interés tarjeta','pesos','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0000003','Descuentos','pesos','','',-1.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101001','Alambre de bajada c/autop.2 x 0.61','unidades','alambre de bajada','999999',101.0000,'0101','S','obs','N',1.0000,5.0000,2.0000,1.0000,5.0000,0.0000,1),
 ('0101002','Alambre de bajada PVC 2 x 0.81','unidades','alambre','122222',102.0000,'0101','S','','N',5.0000,10.0000,0.0000,0.0000,0.0000,0.0000,1),
 ('0101003','Alambre de cruzada bicolor 2 x 0.51','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101004','Alambre p/rienda 4,8 c/PVC','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101005','Alambre p/rienda de  6 mm','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101006','Alambre p/rienda de 3  y 4 mm','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101007','Alambre p/rienda de 8 mm','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101008','Alambre p/rienda de 9 mm','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101009','Cable Autop. Liv. (4,8) 30ps. 0,40','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101010','Cable Autop. Liv. (4,8) 50ps. 0,40','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101011','Cable Autop. Liviano 0.50/10 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101012','Cable autop. liviano PAL 0.50/20 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101013','Cable autop. liviano PAL 0.50/30 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101014','Cable autop. pesado PAL 0.40/100 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101015','Cable autop. pesado PAL 0.40/150 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101016','Cable autop. pesado PAL 0.40/20 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101017','Cable autop. pesado PAL 0.40/200 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101018','Cable autop. pesado PAL 0.40/30 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101019','Cable autop. pesado PAL 0.40/300 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101020','Cable autop. pesado PAL 0.40/50 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101021','Cable autop. pesado PAL 0.50/100 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101022','Cable autop. pesado PAL 0.50/150 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101023','Cable autop. pesado PAL 0.50/20 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101024','Cable autop. pesado PAL 0.50/200 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101025','Cable autop. pesado PAL 0.50/30 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101026','Cable autop. pesado PAL 0.50/50 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101027','Cable bajada XDSL 1 par c/portante','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101028','Cable cilind. subt. PAL 0.50/100 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101029','Cable cilind. subt. PAL 0.50/150 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101030','Cable cilind. subt. PAL 0.50/20 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101031','Cable cilind. subt. PAL 0.50/200 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101032','Cable cilind. subt. PAL 0.50/30 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101033','Cable cilind. subt. PAL 0.50/300 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101034','Cable cilind. subt. PAL 0.50/400 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101035','Cable cilind. Subt. PAL 0.50/50 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101036','Cable cilind. subt. PAL 0.50/500 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101037','Cable cilind. subt. PAL 0.50/600 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101038','Cable de bajada c/suspensor 0.50 x 2 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101039','Cable de bajada c/suspensor 0.50 x 4 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101040','Cable de bajada c/suspensor 0.50 x 6 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101041','Cable de bajada c/suspensor 0.50 x 8 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101042','Cable p/inst. interior 2 x 0.51','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101043','Cable p/instalacion de fachada 2 x 0.61','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101044','Cable p/microfono balanceado','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101045','Cable subterraneo 2 ps 0,50','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101046','Cable telefonico p/interior 0.50 x 1 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101047','Cable telefonico p/interior 0.50 x 10 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101048','Cable telefonico p/interior 0.50 x 100 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101049','Cable telefonico p/interior 0.50 x 16 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101050','Cable telefonico p/interior 0.50 x 2 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101051','Cable telefonico p/interior 0.50 x 20 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101052','Cable telefonico p/interior 0.50 x 25 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101053','Cable telefonico p/interior 0.50 x 4 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101054','Cable telefonico p/interior 0.50 x 50 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101055','Cable telefonico p/interior 0.50 x 6 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101056','Cable telefonico p/interior 0.50 x 8 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101057','Cable UTP cat 5 c/portante','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101058','Cable UTP Cat. 5 de 4 ps','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0101059','Cable UTP cat.5 p/exterior','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102001','Arandela cuadrada curva 83/18','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102002','Arandela cuadrada curva 89/22','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102003','Arandela cuadrada curva 89/29','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102004','Arandela cuadrada plana 102/29','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102005','Arandela cuadrada plana 57/18','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102006','Arandela cuadrada plana 76/18','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102007','Arandela cuadrada plana 89/22','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102008','Arandela de seguridad 21/13','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102009','Arandela de seguridad 26/16','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102010','Arandela redonda plana 26/11.5','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102011','Arandela redonda plana 41/18','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102012','Bulon cabeza cuadrada 16 x 140','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102013','Bulon cabeza cuadrada 16 x 160','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102014','Bulon cabeza cuadrada 16 x 180','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102015','Bulon cabeza cuadrada 16 x 200','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102016','Bulon cabeza cuadrada 16 x 260','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102017','Bulon cabeza cuadrada 16 x 300','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102018','Bulon cabeza cuadrada 16 x 350','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102019','Bulon cabeza cuadrada 16 x 400','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102020','Bulon cabeza cuadrada 16 x 630','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102021','Bulon cabeza cuadrada 19 x 260','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102022','Bulon cabeza cuadrada 9.5 x 80','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102023','Bulon cabeza cuadrada 9.5 x 125','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102024','Bulon cabeza redonda 9.5 x 100','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102025','Bulon cabeza redonda 9.5 x 125','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102026','Bulon de ojo curvo c/tuerca 16 x 180','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102027','Bulon de ojo curvo c/tuerca 16 x 205','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102028','Bulon de ojo curvo c/tuerca 16 x 230','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102029','Bulon de ojo curvo c/tuerca 16 x 255','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102030','Bulon de ojo curvo c/tuerca 19 x 180','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102031','Bulon de ojo curvo c/tuerca 19 x 210','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102032','Bulon de ojo curvo c/tuerca 19 x 240','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102033','Bulon de ojo curvo c/tuerca 19 x 270','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102034','Bulon de ojo curvo c/tuerca 25 x 180','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102035','Bulon de ojo curvo c/tuerca 25 x 210','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102036','Bulon de ojo curvo c/tuerca 25 x 240','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102037','Bulon de ojo curvo c/tuerca 25 x 270','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102038','Bulon de ojo recto c/tuerca 16 x 180','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102039','Bulon de ojo recto c/tuerca 16 x 205','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102040','Bulon de ojo recto c/tuerca 16 x 230','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102041','Bulon de ojo recto c/tuerca 16 x 255','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102042','Bulon de ojo recto c/tuerca 16 x 270','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102043','Bulon de ojo recto c/tuerca 19 x 180','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102044','Bulon de ojo recto c/tuerca 19 x 210','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102045','Bulon de ojo recto c/tuerca 19 x 240','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102046','Bulon de ojo recto c/tuerca 19 x 270','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102047','Bulon de ojo recto c/tuerca 25 x 210','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102048','Bulon de ojo recto c/tuerca 25 x 240','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102049','Esparragos c/4 tuercas 16 x 350','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102050','Esparragos c/4 tuercas 16 x 400','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102051','Esparragos c/4 tuercas 16 x 450','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102052','Esparragos c/4 tuercas 16 x 500','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102053','Tuerca de ojo p/bulon 16','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0102054','Tuerca de ojo p/bulon 19','','','',0.0000,'0102','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103001','Caja 10 ps. c/prot. s/cola 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103002','Caja 10 ps. c/prot.. c/cola 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103003','Caja 20 ps. c/prot. s/cola 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103004','Caja 20 ps. c/prot. c/cola 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103005','Caja distrib.ab.10 ps.  s/cola Pouyet','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103006','Caja distrib.ab.10 ps.  c/cola Pouyet','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103007','Caja p/empalme reentrable 100 ps','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103008','Caja p/empalme reentrable 200 ps','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103009','Caja p/empalme reentrable 300 ps','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103010','Caja p/empalme vertical 200 ps','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103011','Caja p/empalme vertical 300 ps','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103012','Caja p/empalme vertical 50 ps.','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103013','Caja p/conexion RJ11 x 4','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103014','Caja p/conexion RJ11 x 8','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103015','Caja estanca 10 pares','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103016','Caja p/ fachada 1pr. c/proteccion','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103017','Caja p/fachada 2pr. c/proteccion','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103018','Caño  de PVC 87/90 - 6 m','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103019','Curva de PVC 87/90 - 45 grados','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103020','Curva de PVC 87/90 - 90 grados','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103021','Cierre Slic 100 ps. 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103022','Cierre Slic 200 ps. 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103023','Cierre Slic 50 ps. 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103024','Tira abrazadera de aluminio 250 mm','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103025','Tira abrazadera de aluminio 300 mm','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103026','Tira abrazadera de aluminio 350 mm','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103027','Tira abrazadera de aluminio 520 mm','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103028','Tira abrazadera de aluminio 650 mm','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103029','Tira abrazadera de aluminio 700 mm','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103030','Juego continuidad a tierra','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103031','Descargado Trip. 3M p/c/Pouyet','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103032','Modulo de conexion p/ cajas 3M','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103033','Manguito de union de PVC 87/90','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103034','Sellador p/ducto 90mm Raychem','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103035','Tapon 90mm Ultraflex','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0103036','Tubo corrugado 90 mm Ultraflex','','','',0.0000,'0103','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104001','Adaptador Amer. doble','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104002','Adaptador Americano Triple','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104003','Conector BNC macho acodado 90ø','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104004','Conector hembra 4 cables RJ11','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104005','Conector hembra 4 cables RJ9','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104006','Conector hembra RJ 45 cat.5','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104007','Conector hembra RJ11 p/crimpear','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104008','Conector hembra RJ45 cat.5 p/crimpear','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104009','Conector plug c/capuchon RJ45','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104010','Conectores antienrosque TP 801','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104011','Conectores plug RJ45  flexibles AMP','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104012','Conector Telesplise 2 vias c/derv.','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104013','Conectores Telesplice 2 vias','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104014','Conectores Telesplice de 3 vias','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104015','Cupla alargue Americana RJ11','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104016','Cupla Alargue Americana RJ45','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104017','Cupla prolongacion RJ45 H-H','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104018','Grampas Kalop N§  5','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104019','Grampas Kalop N§  8','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104020','Grampas Kalop N§  10','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104021','Jack Americano  exterior c/gel','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104022','Jack Americano exterior simple','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104023','Jack Americano  exterior doble','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104024','Jack Americano  embutido doble c/filtro','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104025','Jack Americano  embutido simple c/filtro','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104026','Jack Americano  exterior  c/filtro','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104027','Plug 6,5 mono metal','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104028','Plug 6.5 Stereo metal','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104029','Plug p/cordon Americano RJ9','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104030','Plug p/linea Americano RJ 11 - 6C','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104031','Plug p/linea Americano  RJ11 - 4C','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0104032','Roseta 2 bocas ext. p/con. hem. RJ11 y 45','','','',0.0000,'0104','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105001','Anillas de distribucion  32 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105002','Anillas de distribucion 41 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105003','Anillas de distribucion 76 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105004','Anillas de retencion 115 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105005','Anillas de retencion 155 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105006','Anillas de retencion 80 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105007','Anillas p/instalacion de bajada 10 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105008','Anillas p/instalacion de bajada 15 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105009','Anillas p/retencion de bajada 115 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105010','Anillas p/retencion de bajada 80 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105011','Brazo de extension 1.220 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105012','Brazo de extension 750 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105013','Clavo de acero cincado 127 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105014','Clavo de acero cincado 152 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105015','Clavo de acero cincado 38 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105016','Clavo de acero cincado 51 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105017','Gancho de suspension tipo J','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105018','Grampa de 1 oreja D 10 L 32.5','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105019','Grampa de 1 oreja D 13 L 36.5','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105020','Grampa de 1 oreja D 16 L 39.5','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105021','Grampa de 1 oreja D 18 L 57','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105022','Grampa de 1 oreja D 23 L 62','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105023','Grampa de 1 oreja D 25 L 66','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105024','Grampa de 1 oreja D 29 L 72.5','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105025','Grampa de 1 oreja D 35 L 79','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105026','Grampa de 1 oreja D 8 L 29','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105027','Grampa de 2 orejas D 116 L 171.4','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105028','Grampa de 2 orejas D 16 L 65.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105029','Grampa de 2 orejas D 23 L 72.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105030','Grampa de 2 orejas D 25 L 77.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105031','Grampa de 2 orejas D 28 L 80.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105032','Grampa de 2 orejas D 35 L 87.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105033','Grampa de 2 orejas D 42 L 94.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105034','Grampa de 2 orejas D 51 L 103.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105035','Grampa de 2 orejas D 60 L 112.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105036','Grampa de 2 orejas D 77 L 129.2','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105037','Grampa de 2 orejas D 91 L 146.4','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105038','Grampa prensacable tipo U p/alam.3mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105039','Grampa prensacable tipo U p/alam.5mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105040','Grampa prensacable tipo U p/alam.6mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105041','Grampa prensacable tipo U p/alam.8mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105042','Kit de continuidad  a tierra p/empalmes','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105043','Modulo de conexion 10 ps Krone','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105044','Modulo de corte 10 ps Krone','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105045','Modulo de proteccion electronico MPE','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105046','Modulo MPG p/cajas Tecsel','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105047','Modulo p/puesta a tierra MT','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105048','Mordaza galvanizada p/bajada','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105049','Mordaza p/cable XDSL','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105050','Mordaza reforzada de PVC p/bajada','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105051','Morseto de susp. 3 agujeros 2 bulones','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105052','Morseto p/alam.de susp. 3 bulones','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105053','Morseto p/alam.de susp. chica 2 bulones','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105054','Morseto p/conexion a tierra','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105055','Prec.metal.c/recub.plas.PMPCH40','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105056','Proteccion forma U de chapa 2.440x36x32','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105057','Proteccion forma U de chapa 2.440x59x55','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105058','Proteccion forma U de chapa 2.440x84x80','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105059','Soporte cadena','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105060','Tirafondo cabaza cuadrada 9.5 x 100 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105061','Tirafondo cabeza cuadrada 12.7 x 110 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105062','Tirafondo cabeza cuadrada 8 x 63 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105063','Tirafondo cabeza cuadrada 8 x 80 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105064','Tirafondo cabeza redonda 25 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0105065','Tirafondo cabeza redonda 35 mm','','','',0.0000,'0105','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106001','Barra P/Ancla de Madera de 16 x 1.50','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106002','Barra P/ ancla de Madera 19 x 1.80','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106003','Barra p/Ancla de Madera de 16 x 1.80','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106004','Barra p/ancla de madera de 19 x 2.25','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106005','Barra  p/anclaje doble elice  de 16 x 1.50','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106006','Barra p/anclaje doble elice de 19 x 1.90','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106007','Barra p/puesta a tierra de Cu  1.50 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106008','Barra p/puesta a tierra de Cu 2.00 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106009','Barra p/puesta a tierra de Cu 2.50 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106010','Barra p/puesta a tierra de Cu 3.00 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106011','Bulones p/guardarriendas','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106012','Guardarriendas','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106013','Poste de eucalipto tratado c/CCA de 6 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106014','Poste de eucalipto tratado c/CCa de 7 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106015','Poste de eucalipto tratado c/CCA de 7.50 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106016','Poste de eucalipto tratado c/CCA de 8 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106017','Poste de eucalipto tratado c/CCA de 8.50 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106018','Poste de eucalipto tratado c/CCA de 9 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106019','Poste de eucalipto tratado c/CCA de 9.50 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106020','Poste de eucalipto tratado c/CCA de 10 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0106021','Poste de eucalipto tratado c/CCA de 11 m','','','',0.0000,'0106','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109001','Antena omni 4 dipolos (pol.Vert.) Fr. 165.400 - 172.100 MHZ','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109002','Bateria SN358 Ion-Li 1030mA','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109003','Booster 160MHz (equipo TRASA)','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109004','Cabezal Plantronics 142 p/TE 901','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109005','Capsula Rx Panasonic inalam.','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109006','Capsula Tx electronica','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109007','Casula Rx electronica','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109008','Cinta aisladora','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109009','Cinta TZ231, 12mm blanco','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109010','Cordon de linea Amer.','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109011','Cordon de linea Amer. p/metro','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109012','Cordon de Pacheo 0.90 m','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109013','Cordon de pacheo 1.80 m','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109014','Cordon de pacheo 2.10 m','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109015','Cordon de pacheo 3.00 m','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109016','Cordon de pacheo 5.00 m','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109017','Cordon micro Amer.','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109018','Kit aliment. TRASA','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109019','Molex H y M  15C.062 TRASA','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109020','Piezo electronico p/telefonos','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109021','Pin p/molex H y M  .062 TRASA','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109022','Resitencia 50 Ohm 40 W (TASA)','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109023','Turbina 12V 4 s/rod','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109024','Turbina 220V 4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0109025','Varistor 235V 18mm','','','',0.0000,'0109','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110001','Adpt. VoIP p/telef. anal¢gico GKM 2210T','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110002','Airgrid Ubiquiti M5','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110003','Ampliacion 2 inter. central 284','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110004','Ampliacion 4 inter. central 412','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110005','Ampliacion de linea central 412','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110006','Antena grillada NRD 29Db','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110007','Antena Omni Ubiquiti 2.4 - 10 dB','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110008','Antena p/TRAM 11 elementos','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110009','Antena p/TRAM 13 o 14 elementos','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110010','Antena p/TRAM 4 elementos','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110011','Antena p/TRAM 5 elementos','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110012','Antena p/TRAM 7 elementos','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110013','Antena p/TRAM 9 elementos','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110014','Antena parab. Hyperlink 5Ghz - 27dBi','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110015','Antena pasiva p/telef. celular','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110016','Antena Ubiquiti 5 Ghz s¢lida 21 dB','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110017','Antena Ubiquiti 5Ghz s¢lida 30 dBi','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110018','ATA Audiocodes MP202B/2Fxs','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110019','ATA Planet Vip-156 / 156PE','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110020','Bateria 12 V - 7 Amp.','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110021','Bateria 6 V - 4 Amp.','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110022','Bateria Gel 12 V x 2,3A','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110023','Bateria n° 31 tipo Panasonic','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110024','Bateria Ni-Mh panasonic nø 14','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110025','Bateria Ni-Mh Panasonic nø 31','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110026','Bateria p/telef. celular Nokia','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110027','Bateria p/telef. inalam. 280 x 3.6 trebol','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110028','Bateria p/telef. inalam. 300 x 2.4','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110029','Baterias 3.6 V x 700mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110030','Baterias Ni-Cd 3.6V - 300mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110031','Baterias p/telef. inalam. AA270','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110032','Enlace  Bullet Ubiquiti 5Ghz  Mimo Airmax','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110033','Cabezal Panasonic 110','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110034','Cable coaxil RG213','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110035','Cable coaxil RG58','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110036','Cable coaxil UHF26/73','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110037','Caller Id Siemens ID199','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110038','Campanilla auxiliar 220/75 - 10 cm','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110039','Campanilla auxiliar 220/75 - 15 cm','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110040','Campanilla auxiliar 220/75 - 20 cm','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110041','Campanilla auxiliar 75 Vcc','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110042','Cargador p/Gigaset 3000','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110043','Cargador p/pilas 4xAA, 4xAAA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110044','Cargador para Gigaset 3000','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110045','Cartucho  Ng. Fax Brother','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110046','Cartucho color Fax Brother','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110047','Central Avatec Nova 206','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110048','Central Intelbras Corp6000 -2 x 12','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110049','Central Nexo Tekna 1248','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110050','Central Panasonic KX-TES824','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110051','Central Starligh MC104','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110052','Central telef. Nexo Facil 1 x 4','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110053','Central Telef. Nexo Facil 3x8 eq. 2x8','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110054','Central telef. Nor-K 1 x 4','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110055','Central telef. Nor-K 2 x 8','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110056','Central telef. Nor-K 284 sub.2 x 6','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110057','Central telef. Nor-K 412','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110058','Central Telef.Digitek 1 x 2','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110059','Conector adaptador N a UHF','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110060','Conector BNC p/cable  RG58','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110061','Conector N p/coaxil RG213','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110062','Conector N p/UHF26/73 Cod.240','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110063','Conector UHF p/cable RG213','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110064','Conector UHF p/cable RG58','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110065','Contestador digital GE 2-9875','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110066','Contestador telef. G.E. 2-9802','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110067','Conversor AP 485 p/sistema Delsat','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110068','Conversor celular (interfase)','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110069','Desoldador a piston','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110070','Detector de llamas','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110071','Enlace Ubiquiti Bullet 5 c/poe','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110072','Enlace Ubiquiti Nano 2 c/poe y fuente','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110073','Equipo terminal de ab. TRASA 10W','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110074','Equpo terminal abonado TRASA UP','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110075','Fax Brother 275','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110076','Fax color Brother MFC210C','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110077','Fax Panasonic KX-FT908AG','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110078','Fax Panasonic KX-FT932AG','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110079','Fax Panasonic KX-FT982AG-B','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110080','Fax Panasonic KX-FT988AG c/cont.dig','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110081','Fax Samsumg SF100','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110082','Fax Sarp FO-165 / 175','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110083','Fax Sharp UX-45 papel termico','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110084','Fax Siemens','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110085','Filtro p/alta frecuencia HF-1','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110086','Frente Port. Elect. Nor-K','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110087','Frente Port.Electr.Starligh DR10','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110088','Fuente 6 V 500 mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110089','Fuente 7,5 V 500mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110090','Fuente 9 Vcc / 500mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110091','Fuente F9 para TRAM','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110092','Fuente p/comunic 13,8 V x 10 A','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110093','Fuente POE Ubiquiti 24 V - 0,5A','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110094','Fuente switching 5v - 25w','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110095','Fuente switching 5v - 5w','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110096','Fuente universal 1,5 a 12VCC 800mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110097','Gategway AudioCode MP202B/2S/SIP','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110098','Gateway Grandstream HT286','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110099','Gateway Grandstream HT502','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110100','Handy Gigaset 3000','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110101','Identificador de llamadas','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110102','Impactadora Noga T/814 c/filo','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110103','Kit Handy Ucom 3500 UHF','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110104','Kit TRAM: PTL1,F9,Ant.5,Coax.30m,2 con,tabl.','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110105','Mikrotik AAB RB 750','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110106','Mini Gbic 40 km 1 pelo','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110107','Modem ADSL','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110108','Modem interno p/sistema Delsat','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110109','Modem-Fax externo','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110110','Modem-Fax interno','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110111','Modulo Port. Elect. Nor-K','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110112','Modulo portero elect. Nexo Facil','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110113','Enlace Nano Bridge M5','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110114','Enlace  Nanostation Ubiquiti 5Ghz','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110115','Patchcord 0,60 cm Gen‚rico','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110116','Patchera 24 P Gen‚rica','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110117','Pilas Niquel-Metal 900 mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110118','Pilas Nique-Matal 1200 mA','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110119','Pinz.metal p/con.Amer.RJ45','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110120','Placa ampli. 1 linea  central Modulare','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110121','Placa Ubiquitti XR2','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110122','Protector base Tecsel 10 ps','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110123','Protector base Tecsel 2 ps','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110124','Protector guardafax dual','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110125','Protector modolo MPG','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110126','Enlace Rocket Ubiquiti 5Ghz mimo Airmax','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110127','Router inalam. TP-LINK  TL-WR743ND','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110128','Router Mikrotik RB 450','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110129','Router TP-Link 740','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110130','Router TP-Link WR741N','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110131','Router WiFi Senao ESR 1221','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110132','Soldador punta ceramica 60W','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110133','Soldador ZR-400 de 40W','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110134','Soporte soldador HS-88','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110135','Spliter PoE TP-LINK TL-POE10R','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110136','Swicht TP-Link 5p','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110137','Switch Micronet SP 608K','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110138','Switch micronet SP 616B','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110139','Switch TP-Link 24 P','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110140','TE inal.Panasonic KX-TG1311AG-2','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110141','TE inalam. Panasonic KX-TG1712 AGB','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110142','TE inalambrico Gigaset 4000','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110143','TE inalm. Gigaset A390','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110144','TE inalm. Panasaonic KX-TG1711','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110145','TE IP Grandstream GXP-1405 Poe','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110146','TE IP Grandstream GXP-280 1 l¡nea','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110147','TE IP Yealink SIP-T20','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110148','TE Nexo NP-315','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110149','TE Nexo NP-80 Gondola','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110150','TE Panasonic KX-T7703x c/ident.','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110151','TE Panasonic KX-T7730 inteligente','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110152','TE Panasonic KX-TG4011','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110153','TE Panasonic KX-TG6421 c/contestador','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110154','TE Panasonic KX-TG7521 c/cont.','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110155','TE Stromberg BG-51 Gondola','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110156','TE. inal. Panasonic KX-TG3510 2.4 Mhz','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110157','TE. inalam.Siemens Gigaset 3000 clasico','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110158','TE. inalam.Siemens Gigaset 3010 m/lib.','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110159','TE. Nexo NP-1919 C/ID M/Libre','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110160','TE. Nexo Sigma','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110161','TE. Panasonic Auto-Logic KX-T2390','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110162','TE. Panasonic KX-TS 11C/ID','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110163','TE. Panasonic KX-TS500','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110164','TE.GE 2-9480 2 lineas','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110165','TE.Inal. Panasonic KX-TG1311AG','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110166','TE.Panacom PA7272 C/ID','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110167','Enlace TP-Link 2.4 TL-W5210G','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110168','UPS APC Back 650 watt - 230vca','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110169','UPS Excel 500','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110170','UPS Lyonn 1000VA Online','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110171','UPS Lyonn 800','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110172','UPS M.G.E. Modelo Pulsar  EL4','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110173','UPS M.G.E. Pulsar Elipse 500','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110174','UPS TRV Pro500F','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110175','Visor p/telecabina sistema Delsat','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110176','VOIP Grandstream GXW 4008 - 8 FXS','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0110177','VOIP Grandstream GXW4104 - 4 Fxo','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201001','Abrazadera 50 -PVC- 1/2 - Con Cuña','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201002','Abrazadera 63 -PVC- 1/2 - Con Cuña','','','',0.0000,'0110','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201003','Abrazadera 75 -PVC- 1/2 - Con Cuña','','','',0.0000,'0201','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201004','Abrazadera 90 -PVC- 1/2 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201005','Abrazadera 110 -PVC- 1/2 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201006','Abrazadera 140 -PVC- 1/2 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201007','Abrazadera 160 -PVC- 1/2 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201008','Abrazadera 50 -PVC- 3/4 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201009','Abrazadera 63 -PVC- 3/4 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201010','Abrazadera 75 -PVC- 3/4 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201011','Abrazadera 90 -PVC- 3/4 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201012','Abrazadera 110 -PVC- 3/4 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201013','Abrazadera 140 -PVC- 3/4 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201014','Abrazadera 160 -PVC- 3/4 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201015','Abrazadera 50 -PVC- 1 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201016','Abrazadera 63 -PVC- 1 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201017','Abrazadera 75 -PVC- 1 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201018','Abrazadera 90 -PVC- 1 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201019','Abrazadera 110 -PVC- 1 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201020','Abrazadera 140 -PVC- 1 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201021','Abrazadera 160 -PVC- 1 - Con Cuña','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201022','Abrazadera 50 -PVC- 1/2 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201023','Abrazadera 63 -PVC- 1/2 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201024','Abrazadera 75 -PVC- 1/2 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201025','Abrazadera 90 -PVC- 1/2 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201026','Abrazadera 110 -PVC- 1/2 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201027','Abrazadera 140 -PVC- 1/2 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201028','Abrazadera 160 -PVC- 1/2 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201029','Abrazadera 50 -PVC- 3/4 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201030','Abrazadera 63 -PVC- 3/4 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201031','Abrazadera 75 -PVC- 3/4 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201032','Abrazadera 90 -PVC- 3/4 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201033','Abrazadera 110 -PVC- 3/4 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201034','Abrazadera 140 -PVC- 3/4 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201035','Abrazadera 160 -PVC- 3/4 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201036','Abrazadera 50 -PVC- 1 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201037','Abrazadera 63 -PVC- 1 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201038','Abrazadera 75 -PVC- 1 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201039','Abrazadera 90 -PVC- 1 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201040','Abrazadera 110 -PVC- 1 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0201041','Abrazadera 140 -PVC- 1 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0);
INSERT INTO `articulos` (`articulo`,`detalle`,`unidad`,`abrevia`,`codbarra`,`costo`,`linea`,`ctrlstock`,`observa`,`ocultar`,`stockmin`,`desc1`,`desc2`,`desc3`,`desc4`,`desc5`,`moneda`) VALUES 
 ('0201042','Abrazadera 160 -PVC- 1 - Doble Bulon','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0202001','Adaptador con Registro - PVC - 20 x 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0203001','Brida para tubo 63 mm.','','','',0.0000,'0203','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0203002','Brida H§F§ c/aro de goma p/ca¤o 110mm','','','',0.0000,'0203','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0203003','Brida c/aro goma 160x140','','','',0.0000,'0203','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0203004','Bulón de acero p/brida 1/2 x 2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0203005','Tuerca de acero  p/bulon 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0203006','Arandela  Plana   p/bulon','','','',0.0000,'0203','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0203007','Junta de Goma p/brida de 110mm','','','',0.0000,'0203','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204001','Buje Reduccion   PVC  1 a 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204002','Buje Reduccion - PVC -1 x 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204003','Buje Reduccion - PPN -3/4 a 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204004','Buje Reduccion - Bronce - 1 x 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204005','Buje reduccion galvanizado  1 1/4 a 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204006','Buje reduccion galvanizado  1 1/4 a 1','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204007','Buje reduccion galvanizado  2 1/2 a 2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204008','Buje reduccion galvanizado  2 1/2 a 1 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204009','Buje reduccion galvanizado  2 1/2 a 1 1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204010','Buje reduccion galvanizado 3 a 1','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204011','Buje reduccion galvanizado 3 a 1 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204012','Buje reduccion galvanizado 3 a 1 1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204013','Buje reduccion galvanizado 3 a 2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204014','Niple galvanizado de 2 x 10 cm','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204015','Buje Niple entre rosca de 1/2 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204016','Buje entrerosca de 3/4 PPM','','','',0.0000,'0204','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204017','Buje entrerosca galvanizada de 2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204018','Buje entrerosca galvanizada de 2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204019','Buje entrerosca galvanizada de 3','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204020','Espiga Conica - PVC','','','',0.0000,'0204','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204021','Espiga Plana - PVC','','','',0.0000,'0204','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204022','Espiga/Espiga - Bronce','','','',0.0000,'0204','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204023','Espiga con Rosca Macho 3/4','','','',0.0000,'0204','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204024','Racord RM - 1/2 x 17mm - K6','','','',0.0000,'0101','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204025','Racord RM - 1/2 x 20mm - K10','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204026','Racord con tuerca loca 1 x 17mm','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0204027','Racord con tuerca loca 1 x 20mm','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205001','Caño PVC - 50 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205002','Caño PVC - 63 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205003','Caño PVC - 75 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205004','Caño PVC - 90 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205005','Caño PVC - 110 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205006','Caño PVC - 140 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205007','Caño PVC - 160 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205008','Caño PVC - 200 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205009','Caño PVC - 250 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205010','Caño PVC - 300 - J/D','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205011','Caño PVC - 50 - J/P','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205012','Caño PVC - 63 - J/P','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205013','Caño PVC - 75 - J/P','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205014','Caño PVC - 90 - J/P','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205015','Caño PVC - 110 - J/P','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205016','Caño PVC - 140 - J/P','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205017','Caño PVC - 160 - J/P','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205018','Caño PeBD 1/2 x 20 mm.','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205019','Caño PeBD 1/2 x 20 mm.','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205020','Caño PPM  1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205021','Caño PeBD 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205022','Caño Bicapa 3/4 PPM','','','',0.0000,'0205','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205023','Caño galvanizado de  2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205024','Ramal Y a 45° de 100 x 100 c/bridas H°F°','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0205025','Ramal Y doble de 160 X 160 X 110','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206001','Cupla PVC - 50 - J/P','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206002','Cupla PVC - 63 - J/P','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206003','Cupla PVC - 75 - J/P','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206004','Cupla PVC - 90 - J/P','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206005','Cupla PVC - 110 - J/P','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206006','Cupla PVC - 140 - J/P','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206007','Cupla PVC - 160 - J/P','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206008','Cupla PVC - 50 - J/D','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206009','Cupla PVC - 63 - J/D','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206010','Cupla PVC - 75 - J/D','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206011','Cupla PVC - 90 - J/D','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206012','Cupla PVC - 110 - J/D','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206013','Cupla PVC - 140 - J/D','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206014','Cupla PVC - 160 - J/D','','','',0.0000,'0206','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206015','Cupla PPN - H H - 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206016','Cupla PPN - H H - 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206017','Cupla PPN - H H - 1','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206018','Cupla PPN - H H - 1 1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206019','Cupla PPN - H H - 1 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206020','Cupla PPN - H H - 1 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206021','Cupla PPN - H H - 2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206022','Cupla PPN - H H - 2 1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206023','Cupla PPN - H H - 2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206024','Cupla PPN - H H - 2 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206025','Cupla PPN - H H - 3','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206026','Cupla Galvanizada H H - 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206027','Cupla Galvanizada - H H - 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206028','Cupla Galvanizada - H H - 1','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206029','Cupla Galvanizada - H H - 1 1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206030','Cupla Galvanizada - H H - 1 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206031','Cupla Galvanizada - H H - 1 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206032','Cupla Galvanizada - H H - 2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206033','Cupla Galvanizada - H H - 2 1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206034','Cupla Galvanizada - H H - 2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206035','Cupla Galvanizada - H H - 2 3/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0206036','Cupla Galvanizada - H H - 3','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207001','Curva 45° - PVC - 50 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207002','Curva 45° - PVC - 63 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207003','Curva 45° - PVC - 75 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207004','Curva 45° - PVC - 90 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207005','Curva 45° - PVC - 110 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207006','Curva 45° - PVC - 140 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207007','Curva 45° - PVC - 160 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207008','Curva 45° - PVC - 50 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207009','Curva 45° - PVC - 63 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207010','Curva 45° - PVC - 75 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207011','Curva 45° - PVC - 90 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207012','Curva 45° - PVC - 110 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207013','Curva 45° - PVC - 140 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207014','Curva 45° - PVC - 160 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207015','Curva 90° - PVC - 50 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207016','Curva 90° - PVC - 63 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207017','Curva 90° - PVC - 75 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207018','Curva 90° - PVC - 90 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207019','Curva 90° - PVC - 110 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207020','Curva 90° - PVC - 140 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207021','Curva 90° - PVC - 160 - J/D','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207022','Curva 90° - PVC - 50 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207023','Curva 90° - PVC - 63 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207024','Curva 90° - PVC - 75 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207025','Curva 90° - PVC - 90 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207026','Curva 90° - PVC - 110 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207027','Curva 90° - PVC - 140 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207028','Curva 90° - PVC - 160 - J/P','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207029','Curva a 45° 1/2 ppm','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207030','Curva  galvanizada  HH  2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207031','Codo de 1/2 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207032','Codo 3/4 PPM','','','',0.0000,'0207','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0207033','Codo de 1 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208001','Llave Esferica -PVC - 1/2 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208002','Llave Esferica - PVC - 3/4 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208003','Llave Esferica - PVC - 1 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208004','Llave Esferica - PVC - 1 1/4 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208005','Llave Esferica - PVC - 1 1/2 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208006','Llave Esferica - PVC - 1 3/4 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208007','Llave Esferica - PVC - 2 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208008','Llave Esferica - PVC - 2 1/4 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208009','Llave Esferica - PVC - 2 1/2 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208010','Llave Esferica - PVC - 2  3/4 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208011','Llave Esferica - PVC -  3 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208012','Llave Esferica - Racord 17 - T/L 1','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208013','Llave Esferica - Racord 20 - T/L 1','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208014','Llave esferica  1/2 HH de Bronce','','','',0.0000,'0208','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208015','Valvula Esclusa - Bronce - 2 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208016','Valvula Esclusa - Bronce - 2 1/2 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208017','Valvula Esclusa - Bronce - 4 - HH','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208018','Valvula esferica Polietileno  2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208019','Valvula de Retencion de Bronce de 3','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208020','Valvula EURO de 63 mm.','','','',0.0000,'0208','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208021','Valvula EURO de 110 mm.  J/D.','','','',0.0000,'0208','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208022','Valvula Mariposa 100 - 4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0208023','Valvula Mariposa 150 - 6','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209001','Mango Deslizante - PVC - 50','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209002','Mango Deslizante - PVC - 63','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209003','Mango Deslizante - PVC - 75','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209004','Mango Deslizante - PVC - 90','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209005','Mango Deslizante - PVC - 110','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209006','Mango Deslizante - PVC - 140','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209007','Mango Deslizante - PVC - 160','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209008','Manguito Roscado - PVC - 50 - J/D','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209009','Manguito Roscado - PVC - 63 - J/D','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209010','Manguito Roscado - PVC - 75 - J/D','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209011','Manguito Roscado - PVC - 90 - J/D','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209012','Manguito Roscado - PVC - 110 - J/D','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209013','Manguito Roscado - PVC - 140 - J/D','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209014','Manguito Roscado - PVC - 160 - J/D','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209015','Manguito Roscado J/P 50x2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209016','Manguito Roscado JP 63x 2 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209017','Manguito Roscado J/P 160 x 6','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209018','Aro de Goma Diam. 50mm','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0209019','Aro de Goma para Union de Rep.','','','',0.0000,'0209','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210001','Medidor Clase C PVC  marca','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210002','Medidor Clase C PVC  marca','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210003','Medidor Clase C PVC  marca','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210004','Medidor Clase C Bronce marca','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210005','Medidor Clase C Bronce marca','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210006','Medidor Clase C Bronce marca','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210007','Macromedidor','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210008','Prolongacion para medidores','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210009','Prolongacion para medidores (pl stico)','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210010','Tuerca de Bronce x 1','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210011','Caja Unificada PVC - P/Medidores','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210012','Caja vereda p/ llave Gde.PVC 200x200x180mm','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210013','Caja p/ Macromedidor PVC','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210014','Tapa Inspeccion Limpieza','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210015','Tapa y Marco - F Gris - 500mm x 600mm','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0210016','Tapa con Marcos - F Gris - P/Medidores','','','',0.0000,'0210','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211001','Reduccion - PVC - 63x50 - J/D','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211002','Reduccion - PVC - 75x63 - J/D','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211003','Reduccion - PVC - 90x75 - J/D','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211004','Reduccion - PVC - 110x90 - J/D','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211005','Reduccion - PVC - 140x110 - J/D','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211006','Reduccion - PVC - 160x140 - J/D','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211007','Reduccion - PVC - 63x50 - J/P','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211008','Reduccion - PVC - 75x63 - J/P','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211009','Reduccion - PVC - 90x75 - J/P','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211010','Reduccion - PVC - 110x90 - J/P','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211011','Reduccion - PVC - 140x110 - J/P','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211012','Reduccion - PVC - 160x140 - J/P','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211013','Reduccion (especial) 75 x 50mm','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211014','Reduccion (especial) 110   x  75','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0211015','Reduccion (especial) 160 x 110','','','',0.0000,'0211','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212001','Tapon Terminal - PVC - 50','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212002','Tapon Terminal - PVC - 63','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212003','Tapon Terminal - PVC - 75','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212004','Tapon Terminal - PVC - 90','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212005','Tapon Terminal - PVC - 110','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212006','Tapon Terminal - PVC - 140','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212007','Tapon Terminal - PVC - 160','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212008','Tapon Terminal 1/2 RM PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212009','TEE 1/2 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212010','TEE - PVC - 50 - J/D','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212011','TEE - PVC - 63 - J/D','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212012','TEE - PVC - 75 - J/D','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212013','TEE - PVC - 90 - J/D','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212014','TEE - PVC - 110 - J/D','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212015','TEE - PVC - 140 - J/D','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212016','TEE - PVC - 160 - J/D','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212017','TEE - PVC - 50 - J/P','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212018','TEE - PVC - 63 - J/P','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212019','TEE - PVC - 75 - J/P','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212020','TEE - PVC - 90 - J/P','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212021','TEE - PVC - 110 - J/P','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212022','TEE - PVC - 140 - J/P','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212023','TEE - PVC - 160 - J/P','','','',0.0000,'0212','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0212024','TEE Galvanizada de 3','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213001','Union de Reparacion - 1/2 - K 6','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213002','Union de Reparacion - 1/2 - K 10','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213003','Union de Reparacion - 1/2 - Conica - K6','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213004','Union de Reparacion - 1/2 - Conica - K10','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213005','Union de Reparaci¢n 3/4 (Junta Dressel)','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213006','Union de Reparacion 50 x 20','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213007','Union de Reparacion 50 x 30','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213008','Union de Reparacion 50 x 40','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213009','Union de Reparacion 50 x 50','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213010','Union de Reparacion 50 x 60','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213011','Union de Reparacion 50 x 70','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213012','Union de Reparacion 50 x 80','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213013','Union de Reparacion 50 x 90','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213014','Union de Reparacion 50 x 1 mt.','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213015','Union de Reparacion 63 x 20','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213016','Union de Reparacion 63 x 30','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213017','Union de Reparacion 63 x 40','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213018','Union de Reparacion 63 x 50','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213019','Union de Reparacion 63 x 60','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213020','Union de Reparacion 63 x 70','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213021','Union de Reparacion 63 x 80','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213022','Union de Reparacion 63 x 90','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213023','Union de Reparacion 63 x 1 mt.','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213024','Union de Reparacion 75 x 20','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213025','Union de Reparacion 75 x 30','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213026','Union de Reparacion 75 x 40','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213027','Union de Reparacion 75 x 50','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213028','Union de Reparacion 75 x 60','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213029','Union de Reparacion 75 x 70','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213030','Union de Reparacion 75 x 80','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213031','Union de Reparacion 75 x 90','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213032','Union de Reparacion 75 x 1 mt.','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213033','Union de Reparacion 90 x 20','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213034','Union de Reparacion 90 x 30','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213035','Union de Reparacion 90 x 40','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213036','Union de Reparacion 90 x 50','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213037','Union de Reparacion 90 x 60','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213038','Union de Reparacion 90 x 70','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213039','Union de Reparacion 90 x 80','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213040','Union de Reparacion 90 x 90','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213041','Union de Reparacion 90 x 1 mt.','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213042','Union de Reparacion 110 x 20','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213043','Union de Reparacion 110 x 30','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213044','Union de Reparacion 110 x 40','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213045','Union de Reparacion 110 c/tensores','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213046','Union de reparaci¢n 140 x 40 cm con tensores','','','',0.0000,'0213','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213047','Union Desmontable de 1/2 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213048','Union Desmontable 3/4 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213049','Union Desmontable 1 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213050','Union Desmontable 1 1/4 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213051','Union Desmontable 1 1/2 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213052','Union Desmontable 2 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0213053','Union Doble x 2 1/2 PPM','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214001','Cuerpo de Bomba Rotor Pump 2.5 -4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214002','Motor Sumergible Franklin Rotor PUMP','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214003','Cable Chato Alimentacion B. 4x2.5mm','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214004','Empalme para Cable','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214005','Clorinador Mod 015 Milenio (1.45 l/h)','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214006','Kit Cabezal p/Clorinador','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214007','Valvula de pie (Filtro Clorinador)','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214008','Cinta Peligro de 8 cm','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214009','Hidro Faja - 50','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214010','Hidro Faja - 63','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214011','Hidro Faja 135 - 145 Ajustable','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214012','Adhesivo PVC - 500 grs.','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214013','Adhesivo  PVC -  250g','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214014','Guarniciones','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214015','Guarnicion de Nylon','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214016','Pasta Lubricante','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0214017','Teflon - 19 x 50','','','',0.0000,'0214','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215001','Monturas  (abrazaderas)  160 a 110  a  45°','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215002','Monturas  (abrazaderas)  160 a 110  a  90°','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215003','Monturas  (abrazaderas)  200 a 110  a  45°','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215004','Monturas  (abrazaderas)  250 a 110  a  45°','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215005','Caños  PVC  110 - J/P','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215006','Caños PVC  110 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215007','Caños PVC  160 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215008','Caños PVC 200 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215009','Caños PVC  250 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215010','Caños PVC  300 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215011','Curvas a  45° de 110 - J/P','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215012','Curvas a  90° de 110 - J/P','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215013','Curvas a  45° de 110 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215014','Curvas a 90° de 110 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215015','Curvas a 45° de 160 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215016','Curvas a 90° de 160 - J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215017','Ramal Y de 110','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215018','Ramal Y de 160','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215019','Cuplas de 110  J/P','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215020','Cuplas de 110  J/D','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215021','Tapa Terminal  de  110  J/P','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215022','Tapa Terminal  de  160  J/P','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215023','Tapa con marco H° F° para calle','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0215024','Tapa con marco H° F° para vereda','','','',0.0000,'0215','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0901001','KC 3301 para columna de alumbrado','','','',0.0000,'0901','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0901002','chica KC 3302  de 80 A 120 mm.','','','',0.0000,'0201','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0901003','mediana KC  3303  de 120 a 160 mm.','','','',0.0000,'0901','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0901004','grande  KC 3304  de 160   a  200  mm.','','','',0.0000,'0901','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0901005','soporte montaje p/fleje Kc3571','','','',0.0000,'0901','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0901006','fleje acero inoxidable 3/4','','','',0.0000,'0901','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0901007','hebilla 3/4','','','',0.0000,'0901','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902001','extension para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902002','extension recto con pin para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902003','extension sin pin para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902004','extension 90° largo para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902005','extension 90° mediano para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902006','extension 90° corto para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902007','180° con pin para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0902008','90° con pin para punto 500','','','',0.0000,'0902','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903001','domiciliario AD 42114','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903002','domiciliario con retorno 30dB','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903003','line extender con retorno','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903004','Mintroncal  MB','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903005','Nodos','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903006','Atenuador para Nodo LE/MB','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903007','Ecualizador para Nodo LE/MB','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903008','Spliter para amplificadores','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0903009','Duplexores','','','',0.0000,'0903','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904001','ojo recto con tuerca 5/8 x 180 KC  6421','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904002','ojo recto con tuerca 5/8 x  205KC 6422','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904003','ojo recto con tuerca 3/4 x 180 KC 6425','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904004','CR CC  5/16 x 1,1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904005','CR CC 3/8 x  2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904006','CR  CC 3/8 x 3','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904007','CR  CC 3/8 x 3,1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904008','CR  CC 3/8 x 2,1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904009','CR CC 3/8  x  1,1/4','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904010','3 bulones liviano  KC 3560','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904011','3 bulones  pesado  KC 3520','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904012','3 buolnes reforz. Para rienda 10 a 12 KC 3567','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904013','curvo aluminio KC  3568','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0904014','de suspension para FO KC  3563','','','',0.0000,'0904','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905001','RG 6 con portante','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905002','RG 6 sin portante','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905003','RG 59 con portante','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905004','RG 59 sin portante','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905005','Punto 500 con suspensor','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905006','UTP  con portante','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905007','UTP  sin portante','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905008','RG  11 con suspensor','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0905009','Fibra optica  48 pelos','','','',0.0000,'0905','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906001','F a com RG 6','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906002','F a com RG 59','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906003','F.H a F rapido','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906004','F.H. A Din','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906005','F-M a Din-H','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906006','F con pollera RG 11','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906007','F r pido a Din H','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906008','Codo - Rosca 90° F M-H','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906009','Para punto 500','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906010','Para punto 500 con pin','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906011','para punto 500  a  F.M.','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906012','Ks para punto 500 a F.H','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906013','con  pin a FH','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906014','para  RG 11 Ks','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906015','Ks-Ks para punto 500','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906016','Adaptador de punto 500 H a FM','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906017','Adaptador de punto 500 H a FH','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906018','Adaptador RG 11 cripmear a FM','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906019','KS 75 Ohm','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906020','F 75 Ohm','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0906021','F Tramas 75 Ohm','','','',0.0000,'0906','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907001','domiciliario  x  2','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907002','domiciliario  x  3','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907003','domiciliario x  4','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907004','domiciliario  x  2','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907005','de red x  2 vias troncales','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907006','de red x 3 vias troncales','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907007','de red acoplador 8 dB','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907008','de red acoplador 12 dB','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907009','de red acoplador 16 dB','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907010','power insert','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907011','filtros pasa bajos','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0907012','filtros pasa altos','','','',0.0000,'0907','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0908001','F H-H','','','',0.0000,'0908','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0908002','F M-M','','','',0.0000,'0908','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0908003','Splice . 500','','','',0.0000,'0908','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0908004','Cierre empalme  FO','','','',0.0000,'0908','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909001','clavos  para  RG 6','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909002','clavos  para  RG 59','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909003','de sujección simple para  FO KC 3700 pared','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909004','de sujección simple para  FO KC 3701 techo','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909005','de sujección simple para  FO KC 3702 pared','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909006','cerco forma U 38 x 6,5 mm.','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909007','Omega  de 1/2','','','',0.0000,'','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909008','prensacable 3/16 KC 5105','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909009','prensacable  1/4  KC  5106','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0909010','prensacable   5/16 KC  5108','','','',0.0000,'0909','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910001','cobreada 3/8 x 1000  KC 7110','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910002','cobreada 3/8 x 1500  KC 7111','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910003','cobreada  1/2  x 1500  KC 7121','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910004','cobreada 1/2 x 2000  KC 7122','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910005','cobreada 5/8 x 2500  KC 7133','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910006','cobreada 5/8 x 3000  KC 7134','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910007','para jabalina 3/8 KC 7150','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910008','para jabalina 1/2 KC 7151','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910009','para jabalina 5/8 KC  7152','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910010','para jabalina  3/4  KC 7153','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0910011','cobreado  3 mm. KC 7160','','','',0.0000,'0910','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0911001','EOC','','','',0.0000,'0911','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0911002','Cablemodem','','','',0.0000,'0911','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912001','Rienda de acero 3 mm KC 3410','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912002','Rienda de acero 3 mm KC 3411','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912003','Rienda de acero 4,8 mm KC 3412','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912004','Rienda de acero  6mm KC 3413','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912005','Rienda de acero 8  mm KC 3414','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912006','Rienda de acero forrada en PVC 3 mm. KC 3450','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912007','Rienda de acero forrada en PVC 4 mm. KC 3451','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912008','Rienda de acero forrada en PVC 6 mm. KC 3453','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912009','Rienda de acero forrada en PVC 8 mm. KC 3454','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912010','Torniquete N° 5  KC 3401','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912011','Torniquete N° 7  KC 3403','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912012','Torniquete doble  KC 3405','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912013','Proteccion para cable tipo U KC 3319','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0912014','Proteccion para cable tipo U KC 3320','','','',0.0000,'0912','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913001','32  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913002','29  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913003','26  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913004','23  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913005','20  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913006','17  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913007','14  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913008','11  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913009','8  dB x 4 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913010','32  dB x 8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913011','29  dB x8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913012','26  dB x 8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913013','23  dB x 8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913014','20  dB x 8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913015','17  dB x 8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913016','14  dB x 8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913017','11  dB x 8 vias','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0),
 ('0913018','Brackett KC 3556','','','',0.0000,'0913','S','','N',1.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0);
/*!40000 ALTER TABLE `articulos` ENABLE KEYS */;


--
-- Definition of table `articulosf`
--

DROP TABLE IF EXISTS `articulosf`;
CREATE TABLE `articulosf` (
  `articulo` char(50) NOT NULL,
  `base` float(13,4) NOT NULL,
  `unidadf` char(50) NOT NULL,
  `idartf` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idartf`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articulosf`
--

/*!40000 ALTER TABLE `articulosf` DISABLE KEYS */;
INSERT INTO `articulosf` (`articulo`,`base`,`unidadf`,`idartf`) VALUES 
 ('0201002',0.0000,'',1),
 ('0201001',0.0000,'',2),
 ('0215001',0.0000,'',3),
 ('0215002',0.0000,'',4),
 ('0215003',0.0000,'',5),
 ('0215004',0.0000,'',6),
 ('0901002',0.0000,'',7),
 ('0109021',0.0000,'',8),
 ('0109023',0.0000,'',9),
 ('0201003',0.0000,'',10),
 ('0208014',0.0000,'',11),
 ('0101003',0.0000,'',14),
 ('1000001',0.0000,'$',15),
 ('0000003',0.0000,'',21),
 ('0101001',0.0000,'',26),
 ('0101002',0.0000,'',31),
 ('0000001',0.0000,'',33),
 ('0000002',0.0000,'',34);
/*!40000 ALTER TABLE `articulosf` ENABLE KEYS */;


--
-- Definition of table `articulosimg`
--

DROP TABLE IF EXISTS `articulosimg`;
CREATE TABLE `articulosimg` (
  `idartimg` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `archivoimg` char(150) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  PRIMARY KEY (`idartimg`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articulosimg`
--

/*!40000 ALTER TABLE `articulosimg` DISABLE KEYS */;
INSERT INTO `articulosimg` (`idartimg`,`articulo`,`archivoimg`,`fechaalta`) VALUES 
 (1,'0102013','img0102013','20171108'),
 (2,'0102013','img01012013','20171108'),
 (3,'0101001','img0101001','20180113');
/*!40000 ALTER TABLE `articulosimg` ENABLE KEYS */;


--
-- Definition of table `articulosimp`
--

DROP TABLE IF EXISTS `articulosimp`;
CREATE TABLE `articulosimp` (
  `articulo` char(50) NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `idartimp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idartimp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articulosimp`
--

/*!40000 ALTER TABLE `articulosimp` DISABLE KEYS */;
INSERT INTO `articulosimp` (`articulo`,`impuesto`,`idartimp`) VALUES 
 ('0101001',1,1),
 ('0101002',1,2),
 ('0101004',1,3),
 ('1000001',1,4),
 ('0101003',1,7),
 ('0000001',1,8),
 ('0000002',1,9),
 ('0000003',1,10);
/*!40000 ALTER TABLE `articulosimp` ENABLE KEYS */;


--
-- Definition of table `articulospro`
--

DROP TABLE IF EXISTS `articulospro`;
CREATE TABLE `articulospro` (
  `idartpro` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `codigop` char(50) NOT NULL,
  PRIMARY KEY (`idartpro`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `articulospro`
--

/*!40000 ALTER TABLE `articulospro` DISABLE KEYS */;
INSERT INTO `articulospro` (`idartpro`,`articulo`,`entidad`,`codigop`) VALUES 
 (1,'0101001',1,'+100');
/*!40000 ALTER TABLE `articulospro` ENABLE KEYS */;


--
-- Definition of table `asientos`
--

DROP TABLE IF EXISTS `asientos`;
CREATE TABLE `asientos` (
  `idasientod` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `idplan` int(10) unsigned NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(254) NOT NULL,
  `debe` float(13,4) NOT NULL,
  `haber` float(13,4) NOT NULL,
  `detalle` char(254) NOT NULL,
  `ejercicio` int(10) unsigned NOT NULL,
  `idpland` int(10) unsigned NOT NULL,
  `detaasiento` char(254) NOT NULL,
  `idasiento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idasientod`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asientos`
--

/*!40000 ALTER TABLE `asientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `asientos` ENABLE KEYS */;


--
-- Definition of table `asientoscompro`
--

DROP TABLE IF EXISTS `asientoscompro`;
CREATE TABLE `asientoscompro` (
  `idasiento` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregicomp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idasiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asientoscompro`
--

/*!40000 ALTER TABLE `asientoscompro` DISABLE KEYS */;
/*!40000 ALTER TABLE `asientoscompro` ENABLE KEYS */;


--
-- Definition of table `astocuenta`
--

DROP TABLE IF EXISTS `astocuenta`;
CREATE TABLE `astocuenta` (
  `idastocuenta` int(10) unsigned NOT NULL,
  `codasto` int(10) unsigned NOT NULL,
  `idpland` int(10) unsigned NOT NULL,
  `dh` char(1) NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idastocuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `astocuenta`
--

/*!40000 ALTER TABLE `astocuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `astocuenta` ENABLE KEYS */;


--
-- Definition of table `astomode`
--

DROP TABLE IF EXISTS `astomode`;
CREATE TABLE `astomode` (
  `codasto` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`codasto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `astomode`
--

/*!40000 ALTER TABLE `astomode` DISABLE KEYS */;
/*!40000 ALTER TABLE `astomode` ENABLE KEYS */;


--
-- Definition of table `astovalor`
--

DROP TABLE IF EXISTS `astovalor`;
CREATE TABLE `astovalor` (
  `idastocuenta` int(10) unsigned NOT NULL,
  `tabla` char(100) NOT NULL,
  `campo` char(100) NOT NULL,
  `opera` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `astovalor`
--

/*!40000 ALTER TABLE `astovalor` DISABLE KEYS */;
/*!40000 ALTER TABLE `astovalor` ENABLE KEYS */;


--
-- Definition of table `bancos`
--

DROP TABLE IF EXISTS `bancos`;
CREATE TABLE `bancos` (
  `idbanco` int(10) unsigned NOT NULL,
  `banco` int(10) unsigned NOT NULL,
  `nombre` char(254) NOT NULL,
  `filial` int(10) unsigned NOT NULL,
  `cp` char(50) NOT NULL,
  PRIMARY KEY (`idbanco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bancos`
--

/*!40000 ALTER TABLE `bancos` DISABLE KEYS */;
INSERT INTO `bancos` (`idbanco`,`banco`,`nombre`,`filial`,`cp`) VALUES 
 (1,0,'CAJA_SUCURSAL',1,''),
 (2,1,'BANCO 1',1,''),
 (3,3,'SANTA FE',1,'');
/*!40000 ALTER TABLE `bancos` ENABLE KEYS */;


--
-- Definition of table `bocaservicios`
--

DROP TABLE IF EXISTS `bocaservicios`;
CREATE TABLE `bocaservicios` (
  `identidadh` int(10) unsigned NOT NULL,
  `bocanumero` char(50) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `facturar` char(1) NOT NULL,
  `habilitado` char(1) NOT NULL,
  PRIMARY KEY (`identidadh`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bocaservicios`
--

/*!40000 ALTER TABLE `bocaservicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `bocaservicios` ENABLE KEYS */;


--
-- Definition of table `cajabancos`
--

DROP TABLE IF EXISTS `cajabancos`;
CREATE TABLE `cajabancos` (
  `idcuenta` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `codcuenta` char(100) NOT NULL,
  `detalle` char(254) NOT NULL,
  `idtipocta` int(10) unsigned NOT NULL,
  `idbanco` int(10) unsigned NOT NULL,
  `cuentabco` char(100) NOT NULL,
  `cbu` char(100) NOT NULL,
  PRIMARY KEY (`idcuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajabancos`
--

/*!40000 ALTER TABLE `cajabancos` DISABLE KEYS */;
INSERT INTO `cajabancos` (`idcuenta`,`fecha`,`codcuenta`,`detalle`,`idtipocta`,`idbanco`,`cuentabco`,`cbu`) VALUES 
 (1,'20180315','CAJA1','CAJA1',1,1,'',''),
 (2,'20180320','CTA CTE 1','CTA CTE 1',2,2,'CTA CTE','1234567890');
/*!40000 ALTER TABLE `cajabancos` ENABLE KEYS */;


--
-- Definition of table `cajaie`
--

DROP TABLE IF EXISTS `cajaie`;
CREATE TABLE `cajaie` (
  `idcajaie` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `direccion` char(254) NOT NULL,
  `cuit` char(13) NOT NULL,
  `concepto` char(254) NOT NULL,
  `contabilizado` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  PRIMARY KEY (`idcajaie`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajaie`
--

/*!40000 ALTER TABLE `cajaie` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajaie` ENABLE KEYS */;


--
-- Definition of table `cajamovih`
--

DROP TABLE IF EXISTS `cajamovih`;
CREATE TABLE `cajamovih` (
  `idcajamovip` int(10) unsigned NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `idcheque` int(10) unsigned NOT NULL,
  `idcupon` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajamovih`
--

/*!40000 ALTER TABLE `cajamovih` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajamovih` ENABLE KEYS */;


--
-- Definition of table `cajamovip`
--

DROP TABLE IF EXISTS `cajamovip`;
CREATE TABLE `cajamovip` (
  `idcajamovip` int(10) unsigned NOT NULL,
  `idcajarecao` int(10) unsigned NOT NULL,
  `idcajarecad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `observa` char(254) NOT NULL,
  PRIMARY KEY (`idcajamovip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajamovip`
--

/*!40000 ALTER TABLE `cajamovip` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajamovip` ENABLE KEYS */;


--
-- Definition of table `cajarecauda`
--

DROP TABLE IF EXISTS `cajarecauda`;
CREATE TABLE `cajarecauda` (
  `idcajareca` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idcajareca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajarecauda`
--

/*!40000 ALTER TABLE `cajarecauda` DISABLE KEYS */;
INSERT INTO `cajarecauda` (`idcajareca`,`detalle`) VALUES 
 (1,'CAJA-PRINCIPAL'),
 (2,'CAJA-01'),
 (3,'CAJA-02');
/*!40000 ALTER TABLE `cajarecauda` ENABLE KEYS */;


--
-- Definition of table `cajarecaudah`
--

DROP TABLE IF EXISTS `cajarecaudah`;
CREATE TABLE `cajarecaudah` (
  `idcajareh` int(10) unsigned NOT NULL,
  `idcajareca` int(10) unsigned NOT NULL,
  `usuario` char(15) NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregicomp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcajareh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajarecaudah`
--

/*!40000 ALTER TABLE `cajarecaudah` DISABLE KEYS */;
INSERT INTO `cajarecaudah` (`idcajareh`,`idcajareca`,`usuario`,`idcomproba`,`idregicomp`) VALUES 
 (0,0,'',0,0),
 (3,2,'TULIO',1,98),
 (4,2,'TULIO',1,99),
 (5,2,'TULIO',1,100),
 (6,2,'TULIO',1,101),
 (7,2,'TULIO',1,101),
 (8,2,'TULIO',1,102),
 (9,2,'TULIO',1,103),
 (10,2,'TULIO',1,104),
 (11,2,'TULIO',1,105),
 (12,2,'TULIO',1,106),
 (13,2,'TULIO',1,107),
 (14,2,'TULIO',1,108),
 (15,2,'TULIO',1,109),
 (16,2,'TULIO',1,110),
 (17,2,'TULIO',1,111),
 (18,2,'TULIO',1,112),
 (19,2,'TULIO',1,113),
 (20,2,'TULIO',1,114),
 (21,2,'TULIO',1,115),
 (22,2,'TULIO',1,116),
 (23,2,'TULIO',1,117),
 (24,2,'TULIO',1,118),
 (25,2,'TULIO',1,119),
 (26,2,'TULIO',1,120),
 (27,2,'TULIO',1,121),
 (28,2,'TULIO',1,122),
 (29,2,'TULIO',1,123),
 (30,2,'TULIO',1,124),
 (31,2,'TULIO',1,125),
 (32,2,'TULIO',1,126),
 (33,2,'TULIO',1,127),
 (34,2,'TULIO',1,128),
 (35,2,'TULIO',1,129),
 (36,2,'TULIO',1,130),
 (37,2,'TULIO',1,131),
 (38,2,'TULIO',1,132),
 (39,2,'TULIO',1,133),
 (40,2,'TULIO',1,134),
 (41,2,'TULIO',1,135),
 (42,2,'TULIO',1,30),
 (43,2,'TULIO',1,136),
 (44,2,'TULIO',1,31),
 (45,2,'TULIO',1,137),
 (46,2,'TULIO',1,32),
 (47,2,'TULIO',202,138),
 (48,2,'TULIO',5,33),
 (49,2,'TULIO',101,139),
 (50,2,'TULIO',5,34),
 (51,2,'TULIO',202,140),
 (52,2,'TULIO',5,35),
 (53,2,'TULIO',202,141),
 (54,2,'TULIO',1,142),
 (55,2,'TULIO',5,36),
 (56,2,'TULIO',1,143),
 (57,2,'TULIO',5,37),
 (58,2,'TULIO',1,144),
 (59,2,'TULIO',5,38),
 (60,2,'TULIO',1,145),
 (61,2,'TULIO',5,39),
 (62,2,'TULIO',1,146),
 (63,2,'TULIO',5,40),
 (64,2,'TULIO',1,147),
 (65,2,'TULIO',5,41),
 (66,2,'TULIO',1,148),
 (67,2,'TULIO',5,42),
 (68,1,'TULIO',1,149),
 (69,2,'TULIO',1,150),
 (70,2,'TULIO',5,43),
 (71,2,'TULIO',1,151),
 (72,2,'TULIO',1,152),
 (73,2,'TULIO',1,153),
 (74,2,'TULIO',1,154),
 (75,2,'TULIO',1,155),
 (76,2,'TULIO',1,156),
 (77,2,'TULIO',1,157),
 (78,2,'TULIO',1,158),
 (79,2,'TULIO',1,159),
 (80,2,'TULIO',1,160),
 (81,2,'TULIO',1,161),
 (82,2,'TULIO',1,162),
 (83,2,'TULIO',5,44),
 (84,2,'TULIO',1,163),
 (85,2,'TULIO',5,45),
 (86,2,'TULIO',1,164),
 (87,2,'TULIO',1,165),
 (88,2,'TULIO',1,166),
 (89,2,'TULIO',5,46),
 (90,2,'TULIO',1,167),
 (91,2,'TULIO',1,168),
 (92,2,'TULIO',1,169),
 (93,2,'TULIO',1,170),
 (94,2,'TULIO',5,47),
 (95,2,'TULIO',1,171),
 (96,2,'TULIO',1,172),
 (97,2,'TULIO',5,48),
 (98,2,'TULIO',1,173),
 (99,2,'TULIO',5,49),
 (100,2,'TULIO',1,174),
 (101,2,'TULIO',5,50),
 (102,2,'TULIO',1,175),
 (103,2,'TULIO',5,51),
 (104,2,'TULIO',1,176),
 (105,2,'TULIO',1,177),
 (106,2,'TULIO',5,52),
 (107,2,'TULIO',1,178),
 (108,2,'TULIO',5,53),
 (109,2,'TULIO',1,179),
 (110,2,'TULIO',1,180),
 (111,2,'TULIO',1,181),
 (112,2,'TULIO',1,182),
 (113,2,'TULIO',5,54),
 (114,2,'TULIO',1,183),
 (115,2,'TULIO',5,55),
 (116,2,'TULIO',1,184),
 (117,2,'TULIO',5,56),
 (118,2,'TULIO',1,185),
 (119,2,'TULIO',1,186),
 (120,2,'TULIO',1,187),
 (121,2,'TULIO',1,188),
 (122,2,'TULIO',1,189),
 (123,2,'TULIO',5,57),
 (124,2,'TULIO',1,190),
 (125,2,'TULIO',5,58),
 (126,2,'TULIO',1,191),
 (127,2,'TULIO',5,59),
 (128,2,'TULIO',1,192),
 (129,2,'TULIO',5,60),
 (130,2,'TULIO',1,193),
 (131,2,'TULIO',5,61),
 (132,2,'TULIO',1,194),
 (133,2,'TULIO',1,195),
 (134,2,'TULIO',1,196),
 (135,2,'TULIO',5,62),
 (136,2,'TULIO',1,197),
 (137,2,'TULIO',1,198),
 (138,2,'TULIO',1,199),
 (139,2,'TULIO',1,200),
 (140,2,'TULIO',1,201),
 (141,2,'TULIO',1,202),
 (142,2,'TULIO',1,203),
 (143,1,'TULIO',4,204),
 (144,1,'TULIO',0,63),
 (145,1,'TULIO',1,205),
 (146,1,'TULIO',5,64),
 (147,1,'TULIO',1,208),
 (148,1,'TULIO',1,209),
 (149,1,'TULIO',1,210),
 (150,1,'TULIO',0,65),
 (151,1,'TULIO',1,211),
 (152,1,'TULIO',1,212),
 (153,1,'TULIO',1,213),
 (154,1,'TULIO',1,214),
 (155,1,'TULIO',1,215),
 (156,1,'TULIO',0,66),
 (157,1,'TULIO',1,216),
 (158,1,'TULIO',1,217),
 (159,1,'TULIO',0,67),
 (160,1,'TULIO',1,218),
 (161,1,'TULIO',0,68),
 (162,1,'TULIO',1,219),
 (163,1,'TULIO',0,69),
 (164,1,'TULIO',1,220),
 (165,1,'TULIO',1,221),
 (166,1,'TULIO',0,70),
 (167,1,'TULIO',1,222),
 (168,1,'TULIO',5,71),
 (169,1,'TULIO',1,223),
 (170,1,'TULIO',1,224),
 (171,1,'TULIO',5,72),
 (172,1,'TULIO',1,225),
 (173,1,'TULIO',1,226),
 (174,1,'TULIO',1,227),
 (175,1,'TULIO',5,73),
 (176,1,'TULIO',1,228),
 (177,1,'TULIO',5,74),
 (178,1,'TULIO',1,229),
 (179,1,'TULIO',5,75),
 (180,1,'TULIO',1,230),
 (181,1,'TULIO',1,231),
 (182,1,'TULIO',1,232),
 (183,1,'TULIO',5,76),
 (184,1,'TULIO',1,233),
 (185,1,'TULIO',1,234),
 (186,1,'TULIO',5,77),
 (187,1,'TULIO',1,235),
 (188,1,'TULIO',1,236),
 (189,1,'TULIO',5,78),
 (190,1,'TULIO',1,237),
 (191,1,'TULIO',1,238),
 (192,1,'TULIO',1,239),
 (193,1,'TULIO',1,240),
 (194,1,'TULIO',5,79),
 (195,1,'TULIO',1,241),
 (196,1,'TULIO',5,80),
 (197,1,'TULIO',1,242),
 (198,1,'TULIO',1,243),
 (199,1,'TULIO',5,81),
 (200,1,'TULIO',1,244),
 (201,1,'TULIO',5,82),
 (202,1,'TULIO',1,245),
 (203,1,'TULIO',5,83),
 (204,1,'TULIO',1,246),
 (205,1,'TULIO',1,247),
 (206,1,'TULIO',5,86),
 (207,1,'TULIO',1,248),
 (208,1,'TULIO',5,87),
 (209,1,'TULIO',5,88),
 (210,1,'TULIO',1,249),
 (211,1,'TULIO',5,89),
 (212,1,'TULIO',5,90),
 (213,1,'TULIO',1,250),
 (214,1,'TULIO',5,91),
 (215,1,'TULIO',1,251),
 (216,1,'TULIO',5,92),
 (217,1,'TULIO',5,93),
 (218,1,'TULIO',1,252),
 (219,1,'TULIO',5,94),
 (220,1,'TULIO',1,253),
 (221,1,'TULIO',5,95),
 (222,1,'TULIO',1,254),
 (223,1,'TULIO',5,96),
 (224,1,'TULIO',1,255),
 (225,1,'TULIO',1,256),
 (226,1,'TULIO',1,257),
 (227,1,'TULIO',1,258),
 (228,1,'TULIO',1,259),
 (229,1,'TULIO',1,260),
 (230,1,'TULIO',5,97),
 (231,1,'TULIO',1,261),
 (232,1,'TULIO',1,262),
 (233,1,'TULIO',1,263),
 (234,1,'TULIO',1,264),
 (235,1,'TULIO',5,98),
 (236,1,'TULIO',1,265),
 (237,1,'TULIO',5,99),
 (238,1,'TULIO',1,266),
 (239,1,'TULIO',1,267),
 (240,1,'TULIO',1,268),
 (241,1,'TULIO',1,269),
 (242,1,'TULIO',1,270),
 (243,1,'TULIO',1,271),
 (244,1,'TULIO',1,272),
 (245,1,'TULIO',1,273),
 (246,1,'TULIO',1,274),
 (247,1,'TULIO',1,275),
 (248,1,'TULIO',1,276),
 (249,1,'TULIO',1,277),
 (250,1,'TULIO',5,100),
 (251,1,'TULIO',1,278),
 (252,1,'TULIO',5,101),
 (253,1,'TULIO',5,102),
 (254,1,'TULIO',1,279),
 (255,1,'TULIO',1,280),
 (256,1,'TULIO',1,282),
 (257,1,'TULIO',5,103),
 (258,1,'TULIO',1,286),
 (259,1,'TULIO',1,287),
 (260,1,'TULIO',5,104),
 (261,1,'TULIO',1,288),
 (262,1,'TULIO',5,105),
 (263,1,'TULIO',1,289),
 (264,1,'TULIO',5,106),
 (265,1,'TULIO',1,291),
 (266,1,'TULIO',5,107),
 (267,1,'TULIO',1,292),
 (268,1,'TULIO',1,293),
 (269,1,'TULIO',1,294),
 (270,1,'TULIO',5,108),
 (271,1,'TULIO',1,295),
 (272,1,'TULIO',1,296),
 (273,1,'TULIO',1,299),
 (274,1,'TULIO',1,300),
 (275,1,'TULIO',1,301),
 (276,1,'TULIO',5,109),
 (277,1,'TULIO',5,110),
 (278,1,'TULIO',5,111),
 (279,1,'TULIO',1,302),
 (280,1,'TULIO',1,303),
 (281,1,'TULIO',1,304),
 (282,1,'TULIO',1,305),
 (283,1,'TULIO',1,306),
 (284,1,'TULIO',1,307),
 (285,1,'TULIO',1,308),
 (286,1,'TULIO',1,309),
 (287,1,'TULIO',1,310),
 (288,1,'TULIO',1,311),
 (289,1,'TULIO',1,312),
 (290,1,'TULIO',5,112),
 (291,1,'TULIO',1,313),
 (292,1,'TULIO',1,314),
 (293,1,'TULIO',1,315),
 (294,1,'TULIO',1,316),
 (295,1,'TULIO',5,113),
 (296,1,'TULIO',1,317),
 (297,1,'TULIO',4,318),
 (298,1,'TULIO',5,114),
 (299,1,'TULIO',4,319),
 (300,1,'TULIO',5,115),
 (301,1,'TULIO',4,320),
 (302,1,'TULIO',5,116),
 (303,1,'TULIO',4,321),
 (304,1,'TULIO',4,322),
 (305,1,'TULIO',5,117),
 (306,1,'TULIO',1,323),
 (307,1,'TULIO',5,118),
 (308,1,'TULIO',1,324),
 (309,1,'TULIO',5,119),
 (310,1,'TULIO',9,325),
 (311,1,'TULIO',5,120),
 (312,1,'TULIO',1,326),
 (313,1,'TULIO',1,327),
 (314,1,'TULIO',1,328),
 (315,1,'TULIO',5,121),
 (316,1,'TULIO',5,122),
 (317,1,'TULIO',1,329),
 (318,1,'TULIO',1,330),
 (319,1,'TULIO',7,331),
 (320,1,'TULIO',5,123),
 (321,1,'TULIO',5,124),
 (322,1,'TULIO',5,125),
 (323,1,'TULIO',1,334),
 (324,1,'TULIO',5,126),
 (325,1,'TULIO',4,335),
 (326,1,'TULIO',5,127),
 (327,1,'TULIO',4,336),
 (328,1,'TULIO',5,128),
 (329,1,'TULIO',7,337),
 (330,1,'TULIO',1,338),
 (331,1,'TULIO',7,339),
 (332,1,'TULIO',5,129),
 (333,1,'TULIO',5,130),
 (334,1,'TULIO',1,340),
 (335,1,'TULIO',1,343),
 (336,1,'TULIO',7,344),
 (337,1,'TULIO',1,345),
 (338,1,'TULIO',1,346),
 (339,1,'TULIO',1,347),
 (340,1,'TULIO',1,349),
 (341,1,'TULIO',1,352),
 (342,1,'TULIO',1,353),
 (343,1,'TULIO',1,354),
 (344,1,'TULIO',1,356),
 (345,1,'TULIO',1,358),
 (346,1,'TULIO',1,360),
 (347,1,'TULIO',1,362),
 (348,1,'TULIO',5,131),
 (349,1,'TULIO',4,363),
 (350,1,'TULIO',4,364),
 (351,1,'TULIO',5,132),
 (352,1,'TULIO',4,365),
 (353,1,'TULIO',4,366),
 (354,1,'TULIO',1,367),
 (355,1,'TULIO',4,368),
 (356,1,'TULIO',5,133),
 (357,1,'TULIO',4,369),
 (358,1,'TULIO',5,134),
 (359,1,'TULIO',4,370),
 (360,1,'TULIO',5,135),
 (361,1,'TULIO',4,371),
 (362,1,'TULIO',4,372),
 (363,1,'TULIO',1,373),
 (364,1,'TULIO',4,374),
 (365,1,'TULIO',4,375),
 (366,1,'TULIO',5,136),
 (367,1,'TULIO',4,376),
 (368,1,'TULIO',4,377),
 (369,1,'TULIO',4,378),
 (370,1,'TULIO',5,137),
 (371,1,'TULIO',4,379),
 (372,1,'TULIO',1,380),
 (373,1,'TULIO',5,138),
 (374,1,'TULIO',1,381),
 (375,1,'TULIO',1,382),
 (376,1,'TULIO',1,383),
 (377,1,'TULIO',1,384),
 (378,1,'TULIO',5,139),
 (379,1,'TULIO',1,385),
 (380,1,'TULIO',5,140),
 (381,1,'TULIO',1,386),
 (382,1,'TULIO',5,141),
 (383,1,'TULIO',1,387),
 (384,1,'TULIO',5,142),
 (385,1,'TULIO',1,388),
 (386,1,'TULIO',5,143),
 (387,1,'TULIO',1,389),
 (388,1,'TULIO',5,144),
 (389,1,'TULIO',10,390),
 (390,1,'TULIO',0,145),
 (391,1,'TULIO',10,391),
 (392,1,'TULIO',10,392),
 (393,1,'TULIO',10,393),
 (394,1,'TULIO',10,394),
 (395,1,'TULIO',10,395),
 (396,1,'TULIO',13,146),
 (397,1,'TULIO',1,396),
 (398,1,'TULIO',1,397),
 (399,1,'TULIO',1,398),
 (400,1,'TULIO',1,399),
 (401,1,'TULIO',5,147),
 (402,1,'TULIO',1,400),
 (403,1,'TULIO',1,401),
 (404,1,'TULIO',5,148),
 (405,1,'TULIO',1,402),
 (406,1,'TULIO',5,149),
 (407,1,'TULIO',1,403),
 (408,1,'TULIO',5,150),
 (409,1,'TULIO',1,404),
 (410,1,'TULIO',1,405),
 (411,1,'TULIO',1,406),
 (412,1,'TULIO',1,407),
 (413,1,'TULIO',1,408),
 (414,1,'TULIO',1,409),
 (415,1,'TULIO',1,410),
 (416,1,'TULIO',1,411),
 (417,1,'TULIO',1,412),
 (418,1,'TULIO',5,151),
 (419,1,'TULIO',1,413),
 (420,1,'TULIO',5,152),
 (421,1,'TULIO',1,414),
 (422,1,'TULIO',5,153),
 (423,1,'TULIO',1,415),
 (424,1,'TULIO',5,154),
 (425,1,'TULIO',1,416),
 (426,1,'TULIO',5,155),
 (427,1,'TULIO',1,417),
 (428,1,'TULIO',5,156),
 (429,1,'TULIO',1,418),
 (430,1,'TULIO',5,157),
 (431,1,'TULIO',1,419),
 (432,1,'TULIO',5,158),
 (433,1,'TULIO',1,420),
 (434,1,'TULIO',5,159),
 (435,1,'TULIO',1,421),
 (436,1,'TULIO',5,160),
 (437,1,'TULIO',1,422),
 (438,1,'TULIO',5,161),
 (439,1,'TULIO',1,423),
 (440,1,'TULIO',5,162),
 (441,1,'TULIO',1,424),
 (442,1,'TULIO',1,425),
 (443,1,'TULIO',1,426),
 (444,1,'TULIO',5,163),
 (445,1,'TULIO',1,427),
 (446,1,'TULIO',5,164),
 (447,1,'TULIO',1,428),
 (448,1,'TULIO',5,165),
 (449,1,'TULIO',1,429),
 (450,1,'TULIO',1,430),
 (451,1,'TULIO',5,166),
 (452,1,'TULIO',10,431),
 (453,1,'TULIO',10,432),
 (454,1,'TULIO',10,433),
 (455,1,'TULIO',0,167),
 (456,1,'TULIO',10,434),
 (457,1,'TULIO',0,168),
 (458,1,'TULIO',10,435),
 (459,1,'TULIO',0,169),
 (460,1,'TULIO',10,436),
 (461,1,'TULIO',0,170),
 (462,1,'TULIO',10,437),
 (463,1,'TULIO',0,171),
 (464,1,'TULIO',10,438),
 (465,1,'TULIO',0,172),
 (466,1,'TULIO',1,439),
 (467,1,'TULIO',5,173),
 (468,1,'TULIO',1,440),
 (469,1,'TULIO',1,441),
 (470,1,'TULIO',1,442),
 (471,1,'TULIO',5,174),
 (472,1,'TULIO',1,443),
 (473,1,'TULIO',1,444),
 (474,1,'TULIO',5,175),
 (475,1,'TULIO',1,445),
 (476,1,'TULIO',5,176),
 (477,1,'TULIO',10,446),
 (478,1,'TULIO',10,447),
 (479,1,'TULIO',0,177),
 (480,1,'TULIO',10,448),
 (481,1,'TULIO',5,178),
 (482,1,'TULIO',7,449),
 (483,1,'TULIO',9,450),
 (484,1,'TULIO',1,451),
 (485,1,'TULIO',5,179),
 (486,1,'TULIO',10,452),
 (487,1,'TULIO',10,453),
 (488,1,'TULIO',13,180),
 (489,1,'TULIO',10,454),
 (490,1,'TULIO',10,455),
 (491,1,'TULIO',10,456),
 (492,1,'TULIO',13,181),
 (493,1,'TULIO',10,457),
 (494,1,'TULIO',13,182),
 (495,1,'TULIO',1,458),
 (496,1,'TULIO',5,183),
 (497,1,'TULIO',10,459),
 (498,1,'TULIO',13,184),
 (499,1,'TULIO',1,460),
 (500,1,'TULIO',1,461),
 (501,1,'TULIO',1,462),
 (502,1,'TULIO',1,463),
 (503,1,'TULIO',10,464),
 (504,1,'TULIO',1,465),
 (505,1,'TULIO',1,466),
 (506,1,'TULIO',1,467),
 (507,1,'TULIO',14,185),
 (508,1,'TULIO',1,468),
 (509,1,'TULIO',14,186);
/*!40000 ALTER TABLE `cajarecaudah` ENABLE KEYS */;


--
-- Definition of table `campogrupo`
--

DROP TABLE IF EXISTS `campogrupo`;
CREATE TABLE `campogrupo` (
  `idcampog` int(10) unsigned NOT NULL,
  `idtipogrupo` int(10) unsigned NOT NULL,
  `campo` char(50) NOT NULL,
  `tipoc` char(1) NOT NULL,
  `orden` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcampog`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campogrupo`
--

/*!40000 ALTER TABLE `campogrupo` DISABLE KEYS */;
INSERT INTO `campogrupo` (`idcampog`,`idtipogrupo`,`campo`,`tipoc`,`orden`) VALUES 
 (39,2,'apellido','C',0),
 (40,2,'nombre','C',0),
 (41,2,'compania','C',0),
 (42,2,'cuit','C',0),
 (67,5,'codigomat','C',0),
 (68,5,'detalle','C',0),
 (69,5,'unidad','C',0),
 (90,8,'nombre','C',1),
 (91,8,'apellido','C',2),
 (92,1,'detalle','C',1),
 (93,9,'banco','I',10),
 (94,9,'nombre','C',10);
/*!40000 ALTER TABLE `campogrupo` ENABLE KEYS */;


--
-- Definition of table `carterach`
--

DROP TABLE IF EXISTS `carterach`;
CREATE TABLE `carterach` (
  `idcartera` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `codigocta` char(20) NOT NULL,
  PRIMARY KEY (`idcartera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `carterach`
--

/*!40000 ALTER TABLE `carterach` DISABLE KEYS */;
/*!40000 ALTER TABLE `carterach` ENABLE KEYS */;


--
-- Definition of table `carterachdeta`
--

DROP TABLE IF EXISTS `carterachdeta`;
CREATE TABLE `carterachdeta` (
  `idcartera` int(10) unsigned NOT NULL,
  `idtipocomp` int(10) unsigned NOT NULL,
  `idcheque` int(10) unsigned NOT NULL,
  `fechaing` char(8) NOT NULL,
  `fechaegr` char(8) NOT NULL,
  `serie` char(8) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `banco` int(10) unsigned NOT NULL,
  `filial` int(10) unsigned NOT NULL,
  `cp` char(50) NOT NULL,
  `detercero` char(1) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(100) NOT NULL,
  `fechaentre` char(8) NOT NULL,
  `entregadoa` char(254) NOT NULL,
  `fechaemisi` char(8) NOT NULL,
  `fechavence` char(8) NOT NULL,
  `alaordende` char(254) NOT NULL,
  `librador` char(254) NOT NULL,
  `loentrega` char(254) NOT NULL,
  `ctacte` char(50) NOT NULL,
  `fechaacred` char(8) NOT NULL,
  PRIMARY KEY (`idcartera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `carterachdeta`
--

/*!40000 ALTER TABLE `carterachdeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `carterachdeta` ENABLE KEYS */;


--
-- Definition of table `carteracheque`
--

DROP TABLE IF EXISTS `carteracheque`;
CREATE TABLE `carteracheque` (
  `idcartera` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `idpland` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcartera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `carteracheque`
--

/*!40000 ALTER TABLE `carteracheque` DISABLE KEYS */;
INSERT INTO `carteracheque` (`idcartera`,`detalle`,`fechaalta`,`idpland`) VALUES 
 (1,'CARTERA 1','20180908',1);
/*!40000 ALTER TABLE `carteracheque` ENABLE KEYS */;


--
-- Definition of table `carterachequed`
--

DROP TABLE IF EXISTS `carterachequed`;
CREATE TABLE `carterachequed` (
  `idcartera` int(10) unsigned NOT NULL,
  `idcheque` int(10) unsigned NOT NULL,
  `serie` char(10) NOT NULL,
  `numero` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `detercero` char(1) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `cuenta` char(50) NOT NULL,
  `fechaemisi` char(8) NOT NULL,
  `fechavence` char(8) NOT NULL,
  `alaorden` char(254) NOT NULL,
  `librador` char(254) NOT NULL,
  `loentrega` char(254) NOT NULL,
  `iddetacobro` int(10) unsigned NOT NULL,
  `idbanco` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcheque`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `carterachequed`
--

/*!40000 ALTER TABLE `carterachequed` DISABLE KEYS */;
INSERT INTO `carterachequed` (`idcartera`,`idcheque`,`serie`,`numero`,`cp`,`detercero`,`importe`,`cuenta`,`fechaemisi`,`fechavence`,`alaorden`,`librador`,`loentrega`,`iddetacobro`,`idbanco`) VALUES 
 (1,2,'A','2231556','2018','S',122.2100,'222333456','20000101','20180912','Pablo','Pablo','Pablo',0,3),
 (1,3,'B','12323654','3000','N',122.2100,'123456789','20000101','20180912','Pablo','Pablo','Pablo',126,3),
 (1,4,'A','123456','3000','N',600.0000,'123213','20000101','20180915','Pablo','Pablo','PAblo',127,3),
 (1,5,'A','12345678','3018','N',500.0000,'123456798','20000101','20180915','Pablo','Pablo','Pablo',0,3),
 (1,6,'A','12345679','2000','N',500.0000,'544865656','20000101','20180915','P','P','P',0,3);
/*!40000 ALTER TABLE `carterachequed` ENABLE KEYS */;


--
-- Definition of table `chequesprop`
--

DROP TABLE IF EXISTS `chequesprop`;
CREATE TABLE `chequesprop` (
  `idchequep` int(10) unsigned NOT NULL,
  `iddetapago` int(10) unsigned NOT NULL,
  `idcuenta` int(10) unsigned NOT NULL,
  `serie` char(10) NOT NULL,
  `numero` char(50) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `fechaemisi` char(8) NOT NULL,
  `fechavence` char(8) NOT NULL,
  `alaorden` char(254) NOT NULL,
  PRIMARY KEY (`idchequep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chequesprop`
--

/*!40000 ALTER TABLE `chequesprop` DISABLE KEYS */;
/*!40000 ALTER TABLE `chequesprop` ENABLE KEYS */;


--
-- Definition of table `cobrocomproba`
--

DROP TABLE IF EXISTS `cobrocomproba`;
CREATE TABLE `cobrocomproba` (
  `idcomprobafact` int(10) unsigned NOT NULL,
  `idcomprobarec` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cobrocomproba`
--

/*!40000 ALTER TABLE `cobrocomproba` DISABLE KEYS */;
INSERT INTO `cobrocomproba` (`idcomprobafact`,`idcomprobarec`) VALUES 
 (1,14),
 (10,14);
/*!40000 ALTER TABLE `cobrocomproba` ENABLE KEYS */;


--
-- Definition of table `cobros`
--

DROP TABLE IF EXISTS `cobros`;
CREATE TABLE `cobros` (
  `idcobro` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `recargo` float(13,4) NOT NULL,
  `idregipago` int(10) unsigned NOT NULL,
  `idcuotafc` int(10) unsigned NOT NULL,
  `imputado` float(13,4) NOT NULL,
  PRIMARY KEY (`idcobro`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cobros`
--

/*!40000 ALTER TABLE `cobros` DISABLE KEYS */;
INSERT INTO `cobros` (`idcobro`,`idcomproba`,`idfactura`,`recargo`,`idregipago`,`idcuotafc`,`imputado`) VALUES 
 (5,5,65,0.0000,15,0,244.4200),
 (6,5,67,0.0000,17,0,122.2100),
 (7,5,68,0.0000,18,0,244.4200),
 (8,5,79,0.0000,24,0,44.4200),
 (9,0,79,0.0000,0,0,44.4200),
 (10,5,80,0.0000,25,0,44.4200),
 (11,0,80,0.0000,0,0,44.4200),
 (12,5,81,0.0000,26,0,44.4200),
 (13,5,82,0.0000,27,0,44.4200),
 (14,5,90,0.0000,28,0,44.0000),
 (18,5,138,0.0000,33,0,244.4200),
 (26,5,150,0.0000,43,0,244.4200),
 (27,5,162,0.0000,44,0,44.4200),
 (28,5,163,0.0000,45,0,66.6300),
 (30,5,170,0.0000,47,0,244.4200),
 (31,5,172,0.0000,48,0,366.6300),
 (32,5,173,0.0000,49,0,366.6300),
 (33,5,174,0.0000,50,0,244.4200),
 (34,5,175,0.0000,51,0,244.4200),
 (35,5,177,0.0000,52,0,734.7241),
 (36,5,178,0.0000,53,0,279.3696),
 (37,5,182,0.0000,54,0,279.3696),
 (38,5,183,0.0000,55,0,279.3696),
 (39,5,184,0.0000,56,0,279.3696),
 (40,5,189,0.0000,57,0,146.4100),
 (41,5,190,0.0000,58,0,445.3761),
 (42,5,191,0.0000,59,0,366.6300),
 (43,5,192,0.0000,60,0,441.9587),
 (44,5,193,0.0000,61,0,292.8200),
 (45,5,196,0.0000,62,0,122.2100),
 (46,0,204,0.0000,63,0,122.2100),
 (47,5,205,0.0000,64,0,122.2100),
 (48,0,210,0.0000,65,0,611.0500),
 (49,0,215,0.0000,66,0,733.2600),
 (50,0,217,0.0000,67,0,244.4200),
 (51,0,219,0.0000,69,0,244.4200),
 (52,0,221,0.0000,70,26,88.8400),
 (53,0,221,0.0000,70,27,0.0000),
 (54,0,221,0.0000,70,28,0.0000),
 (55,0,221,0.0000,70,29,0.0000),
 (56,5,222,0.0000,71,30,88.8400),
 (57,5,222,0.0000,71,31,0.0000),
 (58,5,222,0.0000,71,32,0.0000),
 (59,5,222,0.0000,71,33,0.0000),
 (60,5,224,0.0000,72,0,611.0500),
 (61,5,227,0.0000,73,53,11.0500),
 (62,5,227,0.0000,73,54,0.0000),
 (63,5,227,0.0000,73,55,0.0000),
 (64,5,227,0.0000,73,56,0.0000),
 (65,5,227,0.0000,73,57,0.0000),
 (66,5,227,0.0000,73,58,0.0000),
 (67,5,228,0.0000,74,0,611.0500),
 (68,5,229,0.0000,75,59,11.0500),
 (69,5,229,0.0000,75,60,0.0000),
 (70,5,229,0.0000,75,61,0.0000),
 (71,5,229,0.0000,75,62,0.0000),
 (72,5,229,0.0000,75,63,0.0000),
 (73,5,229,0.0000,75,64,0.0000),
 (74,5,232,0.0000,76,72,44.4200),
 (75,5,234,0.0000,77,0,244.4200),
 (76,5,236,0.0000,78,0,244.4200),
 (77,5,240,0.0000,79,81,44.4200),
 (78,5,241,0.0000,80,84,44.4200),
 (79,5,243,0.0000,81,0,244.4200),
 (80,5,244,0.0000,82,0,292.8200),
 (81,5,245,0.0000,83,0,122.2100),
 (82,5,104,0.0000,86,0,200.0000),
 (83,5,247,0.0000,86,0,1000.0000),
 (84,5,248,0.0000,87,0,611.0500),
 (85,5,104,0.0000,88,0,40.0000),
 (86,5,247,0.0000,88,0,60.0000),
 (87,5,247,0.0000,89,0,100.0000),
 (88,5,104,0.0000,90,0,4.4200),
 (89,5,247,0.0000,90,0,62.1000),
 (90,5,249,0.0000,90,0,33.4800),
 (91,5,250,0.0000,91,87,11.0500),
 (92,5,251,0.0000,92,0,611.0500),
 (93,5,249,0.0000,93,0,577.5700),
 (94,5,250,0.0000,93,88,200.0000),
 (95,5,250,0.0000,93,90,200.0000),
 (96,5,250,0.0000,93,89,22.4300),
 (97,5,250,0.0000,94,89,177.5700),
 (98,5,252,0.0000,94,0,22.4300),
 (99,5,253,0.0000,95,91,11.0500),
 (100,5,254,0.0000,96,0,303.5696),
 (101,5,260,0.0000,97,94,22.2100),
 (102,5,264,0.0000,98,110,6.3000),
 (103,5,265,0.0000,99,113,2.1000),
 (104,5,277,0.0000,100,0,122.2100),
 (105,5,278,0.0000,101,0,600.0000),
 (106,5,278,0.0000,102,0,11.0500),
 (107,5,282,0.0000,103,0,122.2100),
 (108,5,287,0.0000,104,0,611.0500),
 (109,5,288,0.0000,105,0,1222.1000),
 (110,5,289,0.0000,106,0,122.2100),
 (111,5,291,0.0000,107,0,100.0000),
 (112,5,294,0.0000,108,116,11.0500),
 (113,5,294,0.0000,108,117,1.5500),
 (114,5,252,0.0000,109,0,99.7800),
 (115,5,256,0.0000,109,0,0.2200),
 (116,5,253,0.0000,110,92,330.0000),
 (117,5,253,0.0000,110,93,330.0000),
 (118,5,255,0.0000,110,0,340.0000),
 (119,5,257,0.0000,111,0,500.0000),
 (120,5,312,0.0000,112,0,303.5696),
 (121,5,316,0.0000,113,0,734.7241),
 (122,5,318,0.0000,114,0,244.4200),
 (123,5,319,0.0000,115,0,244.4200),
 (124,5,320,0.0000,116,0,244.4200),
 (125,5,322,0.0000,117,0,244.4200),
 (126,5,323,0.0000,118,0,611.0500),
 (127,5,324,0.0000,119,0,244.4200),
 (128,5,325,0.0000,120,0,244.4200),
 (129,5,328,0.0000,121,0,244.4200),
 (130,5,255,0.0000,122,0,100.0000),
 (131,5,330,0.0000,123,0,244.4200),
 (132,5,331,0.0000,123,0,59.1496),
 (133,5,331,0.0000,124,0,0.0001),
 (134,5,331,0.0000,125,0,0.0003),
 (135,5,334,0.0000,126,0,122.2100),
 (136,5,335,0.0000,127,0,122.2100),
 (137,5,336,0.0000,128,0,122.2100),
 (138,5,338,0.0000,129,0,366.6300),
 (139,5,339,0.0000,129,0,88.7245),
 (140,5,255,0.0000,130,0,171.0500),
 (141,5,256,0.0000,130,0,610.8300),
 (142,5,257,0.0000,130,0,111.0500),
 (143,5,258,0.0000,130,0,107.0700),
 (144,5,362,0.0000,131,0,390.4700),
 (145,5,364,0.0000,132,0,365.4200),
 (146,5,368,0.0000,133,0,1305.5400),
 (147,5,369,0.0000,134,0,402.3900),
 (148,5,370,0.0000,135,0,434.5200),
 (149,5,375,0.0000,136,0,390.4700),
 (150,5,378,0.0000,137,0,243.2100),
 (151,5,380,0.0000,138,0,614.6800),
 (152,5,384,0.0000,139,130,14.6800),
 (153,5,385,0.0000,140,133,14.6800),
 (154,5,386,0.0000,141,0,614.6800),
 (155,5,387,0.0000,142,0,244.4200),
 (156,5,388,0.0000,143,0,244.4200),
 (157,5,389,0.0000,144,0,614.6800),
 (158,0,390,0.0000,145,0,614.6800),
 (159,13,395,0.0000,146,0,614.6800),
 (160,5,399,0.0000,147,0,614.6800),
 (161,5,401,0.0000,148,0,244.4200),
 (162,5,402,0.0000,149,0,763.4326),
 (163,5,403,0.0000,150,0,763.4326),
 (164,5,412,0.0000,151,160,14.6800),
 (165,5,413,0.0000,152,163,12.6000),
 (166,5,414,0.0000,153,0,614.6800),
 (167,5,415,0.0000,154,0,614.6800),
 (168,5,416,0.0000,155,0,759.8800),
 (169,5,417,0.0000,156,0,763.4326),
 (170,5,418,0.0000,157,0,759.8800),
 (171,5,419,0.0000,158,0,614.6800),
 (172,5,420,0.0000,159,0,614.6800),
 (173,5,421,0.0000,160,0,614.6800),
 (174,5,422,0.0000,161,0,763.4326),
 (175,5,423,0.0000,162,0,759.8800),
 (176,5,426,0.0000,163,0,734.6801),
 (177,5,427,0.0000,164,0,734.6801),
 (178,5,428,0.0000,165,0,734.6801),
 (179,5,430,0.0000,166,0,734.6801),
 (180,0,433,0.0000,167,169,14.6800),
 (181,0,434,0.0000,168,0,614.6800),
 (182,0,435,0.0000,169,0,614.6800),
 (183,0,436,0.0000,170,0,614.6800),
 (184,0,437,0.0000,171,0,737.6160),
 (185,0,438,0.0000,172,0,734.6801),
 (186,5,439,0.0000,173,172,14.6800),
 (187,5,439,0.0000,173,173,10.5200),
 (188,5,442,0.0000,174,175,14.6800),
 (189,5,442,0.0000,174,176,10.5200),
 (190,5,444,0.0000,175,181,0.0001),
 (191,5,445,0.0000,176,184,14.6800),
 (192,0,447,0.0000,177,190,14.6800),
 (193,5,448,0.0000,178,195,368.8000),
 (194,5,451,0.0000,179,0,196.0200),
 (195,13,453,0.0000,180,0,244.4200),
 (196,13,456,0.0000,181,0,602.5800),
 (197,13,457,0.0000,182,0,244.4200),
 (198,5,458,0.0000,183,0,244.4200),
 (199,13,459,0.0000,184,0,914.6420),
 (200,14,467,0.0000,185,0,293.3040),
 (201,14,468,0.0000,186,0,293.3040);
/*!40000 ALTER TABLE `cobros` ENABLE KEYS */;


--
-- Definition of table `compactiv`
--

DROP TABLE IF EXISTS `compactiv`;
CREATE TABLE `compactiv` (
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `maxnumero` int(10) unsigned NOT NULL,
  `puntov` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compactiv`
--

/*!40000 ALTER TABLE `compactiv` DISABLE KEYS */;
INSERT INTO `compactiv` (`idcomproba`,`pventa`,`maxnumero`,`puntov`) VALUES 
 (1,1,188,'0001'),
 (3,1,26,'0001'),
 (3,0,26,'0'),
 (4,4,25,'0003'),
 (1,4,127,'0003'),
 (5,4,142,'0003'),
 (6,4,71,'0003'),
 (5,1,83,'0001'),
 (7,1,4,'0001'),
 (8,1,0,'0001'),
 (9,4,2,'0003'),
 (11,1,0,'0001'),
 (10,1,7,'0001'),
 (12,1,0,'0001'),
 (13,1,1,'0001'),
 (10,4,18,'0003'),
 (7,4,1,'0003'),
 (13,4,4,'0003'),
 (14,4,150,'0003'),
 (14,1,102,'0001');
/*!40000 ALTER TABLE `compactiv` ENABLE KEYS */;


--
-- Definition of table `compiservi`
--

DROP TABLE IF EXISTS `compiservi`;
CREATE TABLE `compiservi` (
  `idcomproba` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compiservi`
--

/*!40000 ALTER TABLE `compiservi` DISABLE KEYS */;
/*!40000 ALTER TABLE `compiservi` ENABLE KEYS */;


--
-- Definition of table `comproasiento`
--

DROP TABLE IF EXISTS `comproasiento`;
CREATE TABLE `comproasiento` (
  `idcomproba` int(10) unsigned NOT NULL,
  `codasto` char(1) NOT NULL,
  PRIMARY KEY (`idcomproba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comproasiento`
--

/*!40000 ALTER TABLE `comproasiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `comproasiento` ENABLE KEYS */;


--
-- Definition of table `comprobantes`
--

DROP TABLE IF EXISTS `comprobantes`;
CREATE TABLE `comprobantes` (
  `idcomproba` int(10) unsigned NOT NULL,
  `comprobante` char(100) NOT NULL,
  `idnumera` int(10) unsigned NOT NULL,
  `idtipocompro` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `ctacte` char(1) NOT NULL,
  `tabla` char(50) NOT NULL,
  PRIMARY KEY (`idcomproba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comprobantes`
--

/*!40000 ALTER TABLE `comprobantes` DISABLE KEYS */;
INSERT INTO `comprobantes` (`idcomproba`,`comprobante`,`idnumera`,`idtipocompro`,`tipo`,`ctacte`,`tabla`) VALUES 
 (1,'FACTURA A',1,1,'A','S','facturas'),
 (3,'AJUSTE DE STOCK',3,4,'X','N','ajustestockp'),
 (4,'FACTURAE',4,1,'A','S','facturas'),
 (5,'RECIBO A',0,5,'A','N','recibos'),
 (6,'AJUSTE STOCK DE MATERIALES',6,4,'X','N','otmovistockp'),
 (7,'NOTA DE DEBITO A',0,6,'A','S','facturas'),
 (8,'NOTA DE CREDITO A',8,7,'A','S','facturas'),
 (9,'NOTA DE CREDITO A',0,7,'','','facturas'),
 (10,'FACTURA B',0,8,'B','S','facturas'),
 (11,'NOTA DE CREDITO B',0,10,'B','S','facturas'),
 (12,'NOTA DE DEBITO B',0,9,'B','S','facturas'),
 (13,'RECIBO B',0,11,'B','N','recibos'),
 (14,'RECIBO',0,16,'X','N','recibos');
/*!40000 ALTER TABLE `comprobantes` ENABLE KEYS */;


--
-- Definition of table `comprorepo`
--

DROP TABLE IF EXISTS `comprorepo`;
CREATE TABLE `comprorepo` (
  `idcomproba` int(10) unsigned NOT NULL,
  `codigoimpre` char(100) NOT NULL,
  `idreporte` int(10) unsigned NOT NULL,
  `predeterminado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comprorepo`
--

/*!40000 ALTER TABLE `comprorepo` DISABLE KEYS */;
INSERT INTO `comprorepo` (`idcomproba`,`codigoimpre`,`idreporte`,`predeterminado`) VALUES 
 (1,'',1,'S'),
 (5,'',2,'S'),
 (0,'ajustestockp',3,'S'),
 (0,'articulos',4,'S'),
 (0,'articulosimp',4,'S'),
 (0,'articulospro',6,'S'),
 (0,'articulosimp',5,'S'),
 (0,'bancos',7,'S'),
 (0,'bibliotecafabm',8,'S'),
 (0,'buscaconceptos',9,'S'),
 (0,'buscaempleados',10,'S'),
 (0,'buscaentidades',11,'S'),
 (0,'buscaot',12,'S'),
 (0,'buscaotmateriales',13,'S'),
 (0,'buscavendedores',14,'S'),
 (0,'comprobantes',15,'S'),
 (0,'conceptoser',16,'S'),
 (0,'condfiscalabm',17,'S'),
 (0,'consultastock',18,'S'),
 (0,'depositos',19,'S'),
 (0,'empleados',10,'S'),
 (0,'empresasabm',20,'S'),
 (0,'entidades',11,'S'),
 (0,'entidadesc',21,'S'),
 (0,'entidadescr',22,'S'),
 (0,'entidadesg',23,'S'),
 (0,'entidadesh',24,'S'),
 (0,'gruposepelio',25,'S'),
 (0,'iconos',26,'S'),
 (0,'impuestosabm',27,'S'),
 (0,'lineasabm',28,'S'),
 (0,'localidadesabm',29,'S'),
 (0,'localidadesamb',30,'S'),
 (0,'otestados',31,'S'),
 (0,'otetapas',32,'S'),
 (0,'otmonedas',30,'S'),
 (0,'otpedidosdet',33,'S'),
 (0,'otpedidosot',34,'S'),
 (0,'ottiposmovi',35,'S'),
 (0,'paisesabm',36,'S'),
 (0,'provinciasabm',37,'S'),
 (0,'puntosventa',38,'S'),
 (0,'serviciosabm2',39,'S'),
 (0,'serviciosimpuabm',27,'S'),
 (0,'sucursalesabm',40,'S'),
 (0,'tarjetas',41,'S'),
 (0,'tipocompro',42,'S'),
 (0,'tipomstock',43,'S'),
 (0,'toolbarsysabm',44,'S'),
 (0,'vendedoresabm',14,'S'),
 (0,'zonasabm',45,'S'),
 (0,'otlineasmat',46,'S'),
 (0,'monedasabm',30,'S'),
 (0,'otmateriales',13,'S'),
 (0,'otmovistock',47,'S'),
 (0,'otlistadostock',48,'S'),
 (0,'otconsultamovistock',49,'S'),
 (0,'otinfotrazabilidad',50,'S'),
 (0,'otinfopendientes',51,'S'),
 (0,'otinfoestados',52,'S'),
 (0,'otejecuh',53,'S'),
 (0,'otmaterialesequipro',54,'S');
/*!40000 ALTER TABLE `comprorepo` ENABLE KEYS */;


--
-- Definition of table `conceptogrupo`
--

DROP TABLE IF EXISTS `conceptogrupo`;
CREATE TABLE `conceptogrupo` (
  `idconceptg` int(10) unsigned NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idconceptg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conceptogrupo`
--

/*!40000 ALTER TABLE `conceptogrupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `conceptogrupo` ENABLE KEYS */;


--
-- Definition of table `conceptoimpu`
--

DROP TABLE IF EXISTS `conceptoimpu`;
CREATE TABLE `conceptoimpu` (
  `impuesto` int(10) unsigned NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conceptoimpu`
--

/*!40000 ALTER TABLE `conceptoimpu` DISABLE KEYS */;
INSERT INTO `conceptoimpu` (`impuesto`,`idconcepto`) VALUES 
 (1,1);
/*!40000 ALTER TABLE `conceptoimpu` ENABLE KEYS */;


--
-- Definition of table `conceptolimit`
--

DROP TABLE IF EXISTS `conceptolimit`;
CREATE TABLE `conceptolimit` (
  `idconcepto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `concepto` char(20) NOT NULL,
  `consudesde` float(13,4) NOT NULL,
  `consuhasta` float(13,4) NOT NULL,
  `unidad` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  `importe` float(13,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conceptolimit`
--

/*!40000 ALTER TABLE `conceptolimit` DISABLE KEYS */;
/*!40000 ALTER TABLE `conceptolimit` ENABLE KEYS */;


--
-- Definition of table `conceptoser`
--

DROP TABLE IF EXISTS `conceptoser`;
CREATE TABLE `conceptoser` (
  `idconcepto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `concepto` char(20) NOT NULL,
  `detalle` char(254) NOT NULL,
  `abrevia` char(100) NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `unidad` char(20) NOT NULL,
  `facturar` char(1) NOT NULL,
  `cuotasfact` int(10) unsigned NOT NULL,
  `cantcuotas` int(10) unsigned NOT NULL,
  `funcion` char(254) NOT NULL,
  `vigedesde` char(8) NOT NULL,
  `vigehasta` char(8) NOT NULL,
  `vigencia` char(1) NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  `compuesto` char(1) NOT NULL,
  PRIMARY KEY (`idconcepto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conceptoser`
--

/*!40000 ALTER TABLE `conceptoser` DISABLE KEYS */;
INSERT INTO `conceptoser` (`idconcepto`,`servicio`,`concepto`,`detalle`,`abrevia`,`cantidad`,`importe`,`unidad`,`facturar`,`cuotasfact`,`cantcuotas`,`funcion`,`vigedesde`,`vigehasta`,`vigencia`,`padron`,`compuesto`) VALUES 
 (1,2,'FM','FM','FMX',1.0000,100.0000,'unidades','S',0,0,'','20160903','20160903','1',9,'N');
/*!40000 ALTER TABLE `conceptoser` ENABLE KEYS */;


--
-- Definition of table `condfiscal`
--

DROP TABLE IF EXISTS `condfiscal`;
CREATE TABLE `condfiscal` (
  `iva` int(10) unsigned NOT NULL,
  `detalle` char(200) NOT NULL,
  PRIMARY KEY (`iva`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `condfiscal`
--

/*!40000 ALTER TABLE `condfiscal` DISABLE KEYS */;
INSERT INTO `condfiscal` (`iva`,`detalle`) VALUES 
 (1,'RESPONSABLE INSCRIPTO'),
 (2,'RESPONSABLE MONOTRIBUTISTA');
/*!40000 ALTER TABLE `condfiscal` ENABLE KEYS */;


--
-- Definition of table `contabarticonc`
--

DROP TABLE IF EXISTS `contabarticonc`;
CREATE TABLE `contabarticonc` (
  `articulo` char(50) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `idplandc` int(10) unsigned NOT NULL,
  `idplandv` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contabarticonc`
--

/*!40000 ALTER TABLE `contabarticonc` DISABLE KEYS */;
/*!40000 ALTER TABLE `contabarticonc` ENABLE KEYS */;


--
-- Definition of table `cpptelefono`
--

DROP TABLE IF EXISTS `cpptelefono`;
CREATE TABLE `cpptelefono` (
  `bocanumero` char(50) NOT NULL,
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `cppprov` int(10) unsigned NOT NULL,
  `cod_coop` int(10) unsigned NOT NULL,
  `nsecfeco` int(10) unsigned NOT NULL,
  `carllama` int(10) unsigned NOT NULL,
  `nllamado` char(20) NOT NULL,
  `fechaini` char(8) NOT NULL,
  `horaini` char(8) NOT NULL,
  `segureal` int(10) unsigned NOT NULL,
  `valorllama` float(13,4) NOT NULL,
  `tipollama` int(10) unsigned NOT NULL,
  `fechgene` char(8) NOT NULL,
  `horagene` char(8) NOT NULL,
  `secuencia2` int(10) unsigned NOT NULL,
  `facturado` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bocanumero`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cpptelefono`
--

/*!40000 ALTER TABLE `cpptelefono` DISABLE KEYS */;
/*!40000 ALTER TABLE `cpptelefono` ENABLE KEYS */;


--
-- Definition of table `cuentasdispon`
--

DROP TABLE IF EXISTS `cuentasdispon`;
CREATE TABLE `cuentasdispon` (
  `idcuenta` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `codcuenta` char(100) NOT NULL,
  `detalle` char(254) NOT NULL,
  `idtipo` int(10) unsigned NOT NULL,
  `banco` char(50) NOT NULL,
  `filial` char(50) NOT NULL,
  `nombanco` char(254) NOT NULL,
  `cuentabco` char(100) NOT NULL,
  PRIMARY KEY (`idcuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cuentasdispon`
--

/*!40000 ALTER TABLE `cuentasdispon` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuentasdispon` ENABLE KEYS */;


--
-- Definition of table `cupones`
--

DROP TABLE IF EXISTS `cupones`;
CREATE TABLE `cupones` (
  `idcupon` int(10) unsigned NOT NULL,
  `idtarjeta` int(10) unsigned NOT NULL,
  `numero` char(16) NOT NULL,
  `tarjeta` char(50) NOT NULL,
  `fecha` char(8) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `vencimiento` char(10) NOT NULL,
  `titular` char(100) NOT NULL,
  `codautoriz` char(10) NOT NULL,
  `iddetacobro` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcupon`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cupones`
--

/*!40000 ALTER TABLE `cupones` DISABLE KEYS */;
INSERT INTO `cupones` (`idcupon`,`idtarjeta`,`numero`,`tarjeta`,`fecha`,`importe`,`vencimiento`,`titular`,`codautoriz`,`iddetacobro`) VALUES 
 (1,1,'123456','SANTA FE - CREDITO VISA 3 CTAS','20180405',200.0000,'20180405','Pablo Bonet','789456',0),
 (2,1,'111222','SANTA FE - CREDITO VISA 3 CTAS','20180405',611.0000,'20180405','Adrián Magnago','2222888',0),
 (3,1,'123456','SANTA FE - CREDITO VISA 3 CTAS','20180406',200.0000,'20180406','Pablo Bonet','123123',0),
 (4,1,'456789','SANTA FE - CREDITO VISA 3 CTAS','20180406',200.0000,'20180406','Adrián Magnago','887998',0),
 (5,1,'789456','SANTA FE - CREDITO VISA 3 CTAS','20180406',600.0000,'20180406','Pablo','456123',0),
 (6,1,'85654654','SANTA FE - CREDITO VISA 3 CTAS','20180406',200.0000,'20180406','asdsa','32131',0),
 (7,1,'644','SANTA FE - CREDITO VISA 3 CTAS','20180406',199.0000,'20180406','asdsa','213123',0),
 (8,1,'5465','SANTA FE - CREDITO VISA 3 CTAS','20180406',300.0000,'20180406','sdasd','54654',0),
 (9,1,'12321','SANTA FE - CREDITO VISA 3 CTAS','20180406',300.0000,'20180406','asdsad','123123',0),
 (10,1,'2151','SANTA FE - CREDITO VISA 3 CTAS','20180406',200.0000,'20180406','dad','3213',0),
 (11,1,'5654','SANTA FE - CREDITO VISA 3 CTAS','20180406',200.0000,'20180406','asddad','546',0),
 (12,3,'2123','SANTA FE - CREDITO VISA 6 CTAS','20180406',396.0000,'20180406','qweqwe','2135',0),
 (13,3,'5551','SANTA FE - CREDITO VISA 6 CTAS','20180406',613.0000,'20180406','lklj','1565',0),
 (14,3,'546','SANTA FE - CREDITO VISA 6 CTAS','20180406',173.0000,'20180406','sds','5165',0),
 (15,3,'23424','SANTA FE - CREDITO VISA 6 CTAS','20180406',202.0000,'20180406','wefwe','2342',0),
 (16,3,'123123','SANTA FE - CREDITO VISA 6 CTAS','20180407',173.0000,'20180407','Pablo Adrián','001123',0),
 (18,3,'1234567','SANTA FE - CREDITO VISA 6 CTAS','20180407',179.0000,'20180407','Pablo Adrián','99998888',0),
 (19,3,'123213','SANTA FE - CREDITO VISA 6 CTAS','20180407',179.0000,'20180407','Pablo','9877554',0),
 (20,3,'456789','SANTA FE - CREDITO VISA 6 CTAS','20180407',179.0000,'20180407','Pablo','123456',0),
 (21,3,'4654894','SANTA FE - CREDITO VISA 6 CTAS','20180410',248.0000,'20180410','Pablo','15651615',0),
 (22,3,'35645','SANTA FE - CREDITO VISA 6 CTAS','20180410',179.0000,'20180410','asdsad','223123',0),
 (23,3,'654','SANTA FE - CREDITO VISA 6 CTAS','20180410',124.0000,'20180410','adsad','6565',0),
 (24,3,'54886','SANTA FE - CREDITO VISA 6 CTAS','20180410',124.0000,'20180410','sdasdsad','3565',0),
 (25,3,'21533','SANTA FE - CREDITO VISA 6 CTAS','20180410',386.0000,'20180410','kljljlk','21321',0),
 (26,3,'64654','SANTA FE - CREDITO VISA 6 CTAS','20180410',387.0000,'20180410','asdsd','65654',0),
 (27,3,'5654','SANTA FE - CREDITO VISA 6 CTAS','20180410',248.0000,'20180410','asdad','36456',84),
 (28,1,'1234123441','SANTA FE - CREDITO VISA 3 CTAS','20180823',1222.0000,'20180823','Bonet Pablo','8273929',0),
 (30,1,'123456987','SANTA FE - CREDITO VISA 3 CTAS','20180823',200.0000,'20180823','Bonet Pablo','12345',100),
 (31,1,'123456','SANTA FE - CREDITO VISA 3 CTAS','20180824',244.0000,'20180824','Pablo Bonet','1111',0),
 (32,1,'123456','SANTA FE - CREDITO VISA 3 CTAS','20180824',200.0000,'20180824','Pablo Bonet','789',105),
 (33,3,'1111','SANTA FE - CREDITO VISA 6 CTAS','20180824',248.0000,'20180824','Pablo Bonet','5555',107),
 (34,1,'123213','SANTA FE - CREDITO VISA 3 CTAS','20180831',600.0000,'20180831','PAblo','236',117),
 (35,3,'5465432','SANTA FE - CREDITO VISA 6 CTAS','20180903',304.0000,'20180903','Pablo','12',122),
 (36,3,'6546564','SANTA FE - CREDITO VISA 6 CTAS','20180922',28.0000,'20180922','Pablo','32131',0),
 (38,0,'','','',0.0000,'','','',0),
 (39,0,'','','',0.0000,'','','',0),
 (40,0,'','','',0.0000,'','','',0),
 (41,3,'1234123412341234','SANTA FE - CREDITO VISA 6 CTAS','20181006',304.0000,'20181006','Pablo','1234',0),
 (42,3,'1234123412341234','SANTA FE - CREDITO VISA 6 CTAS','20181006',304.0000,'20181006','Pablo','32',0),
 (43,3,'1234567812345678','SANTA FE - CREDITO VISA 6 CTAS','20181006',455.0000,'20181006','Pablo','123',0),
 (44,3,'1234123412341234','SANTA FE - CREDITO VISA 6 CTAS','20181006',304.0000,'20181006','Pablo','123',0),
 (45,3,'1234123412341234','SANTA FE - CREDITO VISA 6 CTAS','20181006',304.0000,'20181006','Pablo','213',138),
 (46,3,'','SANTA FE - CREDITO VISA 6 CTAS','20181006',304.0000,'20181006','','',0),
 (47,3,'123221312323','SANTA FE - CREDITO VISA 6 CTAS','20181008',1242.0000,'20181008','Pablo','123',0),
 (48,3,'132561','SANTA FE - CREDITO VISA 6 CTAS','20181008',635.0000,'20181008','Pablo','11531',0),
 (49,3,'31513215','SANTA FE - CREDITO VISA 6 CTAS','20181008',635.0000,'20181008','Pablo','132131',140),
 (50,1,'654654565','SANTA FE - CREDITO VISA 3 CTAS','20181012',100.0000,'20181012','Pablo','5464',0),
 (52,3,'123456789','SANTA FE - CREDITO VISA 6 CTAS','20181012',304.0000,'20181012','Pablo Bonet','321',150),
 (53,3,'32131654','SANTA FE - CREDITO VISA 6 CTAS','20181013',455.0000,'20181013','Pablo','61565',0),
 (54,3,'56165161615','SANTA FE - CREDITO VISA 6 CTAS','20181013',455.0000,'20181013','Pablo','1651',156),
 (55,1,'123456789','SANTA FE - CREDITO VISA 3 CTAS','20181022',600.0000,'20181022','Pablo','5555',169),
 (56,3,'546464','SANTA FE - CREDITO VISA 6 CTAS','20181023',763.0000,'20181023','Pablo','13313',175),
 (57,3,'12312313','SANTA FE - CREDITO VISA 6 CTAS','20181024',304.0000,'20181024','Pablo','123213',176),
 (58,3,'2123213','SANTA FE - CREDITO VISA 6 CTAS','20181024',763.0000,'20181024','Pablo','12313',177),
 (59,3,'123123','SANTA FE - CREDITO VISA 6 CTAS','20181024',763.0000,'20181024','Pablo','123',178),
 (60,1,'123465798','SANTA FE - CREDITO VISA 3 CTAS','20181024',600.0000,'20181024','Pablo','3333',182),
 (61,1,'123456789','SANTA FE - CREDITO VISA 3 CTAS','20181024',615.0000,'20181024','Pablo','3333',183),
 (62,3,'1232134654','SANTA FE - CREDITO VISA 6 CTAS','20181024',745.2000,'20181024','Pablo','35654',185),
 (63,3,'32156654','SANTA FE - CREDITO VISA 6 CTAS','20181024',763.4326,'20181024','Pablo','321',186),
 (64,3,'31516','SANTA FE - CREDITO VISA 6 CTAS','20181024',745.2000,'20181024','Pablo','312321',188),
 (65,1,'654645','SANTA FE - CREDITO VISA 3 CTAS','20181024',614.6800,'20181024','Pablo','123213',190),
 (66,1,'1561615','SANTA FE - CREDITO VISA 3 CTAS','20181024',600.0000,'20181024','Pablo','32131',192),
 (67,3,'315651','SANTA FE - CREDITO VISA 6 CTAS','20181024',763.4326,'20181024','Pablo','23131',193),
 (68,3,'654646','SANTA FE - CREDITO VISA 6 CTAS','20181025',745.2000,'20181025','Pablo','1231',195),
 (69,3,'123123','SANTA FE - CREDITO VISA 6 CTAS','20181025',720.0000,'20181025','Pablo','123213',0),
 (70,3,'5151616','SANTA FE - CREDITO VISA 6 CTAS','20181025',720.0000,'20181025','Pablo','3211',0),
 (71,3,'31656516','SANTA FE - CREDITO VISA 6 CTAS','20181025',720.0000,'20181025','Pablo','231321',197),
 (72,3,'123456789','SANTA FE - CREDITO VISA 6 CTAS','20181025',720.0000,'20181025','Pablo Bonet','3355',199),
 (73,3,'12356987','SANTA FE - CREDITO VISA 6 CTAS','20181025',720.0000,'20181025','Pablo','5555',201),
 (74,3,'1234569987','SANTA FE - CREDITO VISA 6 CTAS','20181025',720.0000,'20181025','Pablo','3333',203),
 (75,1,'123456','SANTA FE - CREDITO VISA 3 CTAS','20181026',614.6800,'20181026','Pablo','333',206),
 (76,1,'13132','SANTA FE - CREDITO VISA 3 CTAS','20181026',600.0000,'20181026','Pablo','23232',208),
 (77,3,'3213165','SANTA FE - CREDITO VISA 6 CTAS','20181026',737.6160,'20181026','Pablo','33',209),
 (78,3,'316565','SANTA FE - CREDITO VISA 6 CTAS','20181026',720.0000,'20181026','Pablo','5546546',211),
 (79,3,'123121','SANTA FE - CREDITO VISA 6 CTAS','20181027',840.0000,'20181027','Pablo','656465',224);
/*!40000 ALTER TABLE `cupones` ENABLE KEYS */;


--
-- Definition of table `depositos`
--

DROP TABLE IF EXISTS `depositos`;
CREATE TABLE `depositos` (
  `deposito` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `direccion` char(254) NOT NULL,
  PRIMARY KEY (`deposito`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `depositos`
--

/*!40000 ALTER TABLE `depositos` DISABLE KEYS */;
INSERT INTO `depositos` (`deposito`,`detalle`,`direccion`) VALUES 
 (1,'Deposito Belgrano 1602','Belgrano 1602');
/*!40000 ALTER TABLE `depositos` ENABLE KEYS */;


--
-- Definition of table `destinooti`
--

DROP TABLE IF EXISTS `destinooti`;
CREATE TABLE `destinooti` (
  `destinooti` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`destinooti`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `destinooti`
--

/*!40000 ALTER TABLE `destinooti` DISABLE KEYS */;
/*!40000 ALTER TABLE `destinooti` ENABLE KEYS */;


--
-- Definition of table `detafactu`
--

DROP TABLE IF EXISTS `detafactu`;
CREATE TABLE `detafactu` (
  `idfactura` int(10) unsigned NOT NULL,
  `idfacturah` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `unidad` char(10) NOT NULL,
  `cantidadfc` float(13,4) NOT NULL,
  `unidadfc` char(10) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `impuestos` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(100) NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cantcuotas` int(10) unsigned NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `razonimp` float(13,4) NOT NULL,
  `neto` float(13,4) NOT NULL,
  PRIMARY KEY (`idfacturah`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detafactu`
--

/*!40000 ALTER TABLE `detafactu` DISABLE KEYS */;
INSERT INTO `detafactu` (`idfactura`,`idfacturah`,`articulo`,`idconcepto`,`servicio`,`cantidad`,`unidad`,`cantidadfc`,`unidadfc`,`detalle`,`unitario`,`impuestos`,`total`,`codigocta`,`nombrecta`,`cuota`,`cantcuotas`,`padron`,`impuesto`,`razonimp`,`neto`) VALUES 
 (1,1,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (2,2,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (3,3,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (4,4,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (5,5,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (6,6,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (7,7,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (8,8,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (9,9,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (10,10,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (11,11,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (12,12,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,3.3600,407.3600,'','',0,0,0,1,21.0000,404.0000),
 (13,13,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (14,14,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (15,15,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (16,16,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (17,17,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (18,18,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (19,19,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (20,20,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (21,21,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (22,22,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (23,23,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (24,24,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (25,25,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (26,26,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (27,27,'0101002',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,107.1000,617.1000,'','',0,0,0,1,21.0000,510.0000),
 (28,28,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (29,29,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (30,30,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (31,31,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (32,32,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (33,33,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (34,34,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (35,35,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (36,36,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (37,37,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (38,38,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (39,39,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (40,40,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (41,41,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (42,42,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (43,43,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (44,44,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (45,45,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (46,46,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (47,47,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (48,48,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (48,49,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (49,50,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (50,51,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (51,52,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (52,53,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (53,54,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,21.4200,123.4200,'','',0,0,0,1,21.0000,102.0000),
 (54,55,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (55,56,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (56,57,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (57,58,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (58,59,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (59,60,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,42.8400,246.8400,'','',0,0,0,1,21.0000,204.0000),
 (60,61,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,42.8400,246.8400,'','',0,0,0,1,21.0000,204.0000),
 (61,62,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (62,63,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (63,64,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (64,65,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (65,66,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (66,67,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (67,68,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (68,69,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (69,70,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (70,71,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (71,72,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (72,73,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (73,74,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (74,75,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (75,76,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (76,77,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (77,78,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (78,79,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (79,80,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (80,81,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (81,82,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (82,83,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (83,84,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (84,85,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (85,86,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (86,87,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (87,88,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (88,89,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (89,90,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (90,91,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (92,92,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (93,93,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (94,94,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (95,95,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (96,96,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (97,97,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (98,98,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (99,99,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (100,100,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (101,101,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (101,102,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (102,103,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (103,104,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (104,105,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (105,106,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (106,107,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (107,108,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (108,109,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (109,110,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (110,111,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (111,112,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (112,113,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (113,114,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (114,115,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,42.8400,246.8400,'','',0,0,0,1,21.0000,204.0000),
 (115,116,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (116,117,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (117,118,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (118,119,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (119,120,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (120,121,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (121,122,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (122,123,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (123,124,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (124,125,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (125,126,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (126,127,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (127,128,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (128,129,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (129,130,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (130,131,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (131,132,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (132,133,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (133,134,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (134,135,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (135,136,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (136,137,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (137,138,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (138,139,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (139,140,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (140,141,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (141,142,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (142,143,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (143,144,'0101002',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,85.6800,493.6800,'','',0,0,0,1,21.0000,408.0000),
 (144,145,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (145,146,'0101002',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,107.1000,617.1000,'','',0,0,0,1,21.0000,510.0000),
 (146,147,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (147,148,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (148,149,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (149,150,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (150,151,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (151,152,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (152,153,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (153,154,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (154,155,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (155,156,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (156,157,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (157,158,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (158,159,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (159,160,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (160,161,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (161,162,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (162,163,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (163,165,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (164,166,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (165,167,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (166,169,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (167,171,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (168,172,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (169,174,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (170,176,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (171,178,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (172,180,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,1.0000,'','',0,0,0,1,21.0000,1.0000),
 (173,182,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (174,184,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (175,186,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,1.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (175,187,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (176,189,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (176,190,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (176,191,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',65.9260,1.0000,79.7705,'','',0,0,0,0,21.0000,79.7705),
 (177,192,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (177,193,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',102.2100,1.0000,123.6741,'','',0,0,0,1,21.0000,123.6741),
 (178,194,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (178,195,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',28.8840,1.0000,34.9496,'','',0,0,0,1,21.0000,34.9496),
 (179,196,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (179,197,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',28.8840,1.0000,34.9496,'','',0,0,0,1,21.0000,34.9496),
 (180,198,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (180,199,'0101001',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',28.8840,1.0000,34.9496,'','',0,0,0,1,21.0000,34.9496),
 (181,200,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (182,201,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (182,202,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',28.8840,6.0656,34.9496,'','',0,0,0,1,21.0000,28.8840),
 (183,203,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (183,204,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',28.8840,6.0656,34.9496,'','',0,0,0,1,21.0000,28.8840),
 (184,205,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (184,206,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',28.8840,6.0656,34.9496,'','',0,0,0,1,21.0000,28.8840),
 (185,207,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (185,208,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,21.2100,123.2100,'','',0,0,0,1,21.0000,102.0000),
 (186,209,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (186,210,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',40.0000,8.4000,48.4000,'','',0,0,0,1,21.0000,40.0000),
 (187,211,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (187,212,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',28.8840,6.0656,34.9496,'','',0,0,0,1,21.0000,28.8840),
 (188,213,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (188,214,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',20.0000,4.2000,24.2000,'','',0,0,0,1,21.0000,20.0000),
 (189,215,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (189,216,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',20.0000,4.2000,24.2000,'','',0,0,0,1,21.0000,20.0000),
 (190,217,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (190,218,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',62.0794,13.0367,75.1161,'','',0,0,0,1,21.0000,62.0794),
 (191,219,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (192,220,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (192,221,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',62.2551,13.0736,75.3287,'','',0,0,0,1,21.0000,62.2551),
 (193,222,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (193,223,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',40.0000,8.4000,48.4000,'','',0,0,0,1,21.0000,40.0000),
 (194,224,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (195,225,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,42.8400,246.8400,'','',0,0,0,1,21.0000,204.0000),
 (196,226,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (197,227,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (198,228,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (199,229,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (200,230,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (201,231,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (202,232,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (203,233,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (204,234,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (205,235,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (208,236,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (209,237,'0101004',0,0,5.0000,'',0.0000,'','Alambre p/rienda 4,8 c/PVC',10.0000,10.5000,60.5000,'','',0,0,0,1,21.0000,50.0000),
 (210,238,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (210,239,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (211,240,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (212,241,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (213,242,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (214,243,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (215,244,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (216,245,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (217,246,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (218,247,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (219,248,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (220,249,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (221,250,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (222,251,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,84.8400,488.8400,'','',0,0,0,1,21.0000,404.0000),
 (223,252,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (224,253,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (225,254,'0101001',0,0,6.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,127.2600,733.2600,'','',0,0,0,1,21.0000,606.0000),
 (226,255,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (227,256,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (228,257,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (229,258,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (230,259,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (230,260,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (231,261,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (232,262,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (233,263,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (233,264,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (234,265,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (234,266,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (235,267,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (236,268,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (237,269,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (238,270,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (239,271,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (240,272,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (241,273,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (242,274,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (242,275,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (243,276,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (243,277,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (244,278,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (244,279,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',40.0000,8.4000,48.4000,'','',0,0,0,1,21.0000,40.0000),
 (245,280,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (246,281,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (247,282,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (248,283,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (249,284,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (250,285,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (251,286,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (251,287,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (252,288,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (253,289,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (254,290,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (254,291,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',48.8840,10.2656,59.1496,'','',0,0,0,1,21.0000,48.8840),
 (255,292,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (256,293,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (257,294,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (258,295,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (259,296,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (260,297,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (260,298,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (261,299,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (261,300,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (262,301,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (262,302,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',-68.8400,-14.4564,-83.2964,'','',0,0,0,1,21.0000,-68.8400),
 (263,303,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (264,304,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (264,305,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',30.0000,6.3000,36.3000,'','',0,0,0,1,21.0000,30.0000),
 (265,306,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (265,307,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',10.0000,2.1000,12.1000,'','',0,0,0,1,21.0000,10.0000),
 (266,308,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (267,309,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (268,310,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (269,311,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (270,312,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (271,313,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (272,314,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (273,315,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (274,316,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (275,317,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (276,318,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (277,319,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (278,320,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (279,321,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (280,322,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (282,323,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (285,324,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (285,325,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (286,326,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (286,327,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (287,328,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (288,329,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (289,330,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (291,331,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (292,332,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (293,333,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (293,334,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',4.4420,0.9328,5.3748,'','',0,0,0,1,21.0000,4.4420),
 (294,335,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (294,336,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',60.0000,12.6000,72.6000,'','',0,0,0,1,21.0000,60.0000),
 (295,337,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (296,338,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,0.0000,505.0000,'','',0,0,0,1,21.0000,505.0000),
 (296,339,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,0.0000,505.0000,'','',0,0,0,1,21.0000,505.0000),
 (296,340,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,0.0000,505.0000,'','',0,0,0,1,21.0000,505.0000),
 (299,341,'0101001',0,0,20.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,424.2000,2444.2000,'','',0,0,0,1,21.0000,2020.0000),
 (300,342,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (300,343,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',60.0000,12.6000,72.6000,'','',0,0,0,1,21.0000,60.0000),
 (301,344,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (302,345,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (302,346,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (303,347,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (304,348,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (305,349,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (305,350,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',122.2100,25.6641,147.8741,'','',0,0,0,1,21.0000,122.2100),
 (306,351,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (306,352,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',122.2100,25.6641,147.8741,'','',0,0,0,1,21.0000,122.2100),
 (307,353,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (307,354,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',48.8840,10.2656,59.1496,'','',0,0,0,1,21.0000,48.8840),
 (308,355,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (308,356,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',48.8840,10.2656,59.1496,'','',0,0,0,1,21.0000,48.8840),
 (309,357,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (309,358,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',48.8840,10.2656,59.1496,'','',0,0,0,1,21.0000,48.8840),
 (310,359,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (310,360,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',73.3260,15.3985,88.7245,'','',0,0,0,1,21.0000,73.3260),
 (311,361,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (311,362,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',48.8840,10.2656,59.1496,'','',0,0,0,1,21.0000,48.8840),
 (312,363,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (312,364,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',48.8840,10.2656,59.1496,'','',0,0,0,1,21.0000,48.8840),
 (313,365,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (313,366,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',48.8840,10.2656,59.1496,'','',0,0,0,1,21.0000,48.8840),
 (314,367,'0101001',0,0,10.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,212.1000,1222.1000,'','',0,0,0,1,21.0000,1010.0000),
 (314,368,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',200.0000,42.0000,242.0000,'','',0,0,0,1,21.0000,200.0000),
 (315,369,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (315,370,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (315,371,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',102.2100,21.4641,123.6741,'','',0,0,0,1,21.0000,102.2100),
 (316,372,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (316,373,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',102.2100,21.4641,123.6741,'','',0,0,0,1,21.0000,102.2100),
 (317,374,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (318,375,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (319,376,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (320,377,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (321,378,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (322,379,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (323,380,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (324,381,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (325,382,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (326,383,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (327,384,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (328,385,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (329,386,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (330,387,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (331,388,'1000001',0,0,1.0000,'$',0.0000,'','ND por interés en tarjeta',59.1500,0.0000,59.1500,'','',0,0,0,0,0.0000,59.1500),
 (334,389,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (335,390,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (336,391,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (337,392,'1000001',0,0,1.0000,'$',0.0000,'','ND por interés en tarjeta',50.0000,10.5000,60.5000,'','',0,0,0,1,21.0000,50.0000),
 (338,393,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (339,394,'1000001',0,0,1.0000,'$',0.0000,'','ND por interés en tarjeta',73.3300,15.3972,88.7272,'','',0,0,0,1,21.0000,73.3300),
 (340,395,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (343,396,'0101001',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',105.0000,106.0500,611.0500,'','',0,0,0,1,21.0000,505.0000),
 (344,397,'1000001',0,0,1.0000,'$',0.0000,'','ND por interés en tarjeta',50.0000,10.5000,60.5000,'','',0,0,0,1,21.0000,50.0000),
 (345,398,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,0.0000,202.0000,'','',0,0,0,0,0.0000,202.0000),
 (345,399,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,0.0000,102.0000,'','',0,0,0,0,0.0000,102.0000),
 (345,400,'0101003',0,0,1.0000,'',0.0000,'','Alambre de cruzada bicolor 2 x 0.51',1.0000,0.0000,1.0000,'','',0,0,0,0,0.0000,1.0000),
 (346,401,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (346,402,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,21.2100,123.2100,'','',0,0,0,1,21.0000,102.0000),
 (347,403,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (347,404,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',101.0000,63.6300,366.6300,'','',0,0,0,0,0.0000,303.0000),
 (347,405,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (348,406,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (348,407,'',0,0,0.0000,'',0.0000,'','',0.0000,0.0000,0.0000,'','',0,0,0,0,0.0000,0.0000),
 (349,408,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (350,409,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (350,410,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,63.6300,369.6300,'','',0,0,0,1,21.0000,306.0000),
 (351,411,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (351,412,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,63.6300,369.6300,'','',0,0,0,1,21.0000,306.0000),
 (352,413,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (352,414,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,63.6300,369.6300,'','',0,0,0,1,21.0000,306.0000),
 (353,415,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (353,416,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,63.6300,369.6300,'','',0,0,0,1,21.0000,306.0000),
 (354,417,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,21.4200,123.4200,'','',0,0,0,0,0.0000,102.0000),
 (354,418,'0101001',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,85.6800,489.6800,'','',0,0,0,1,21.0000,404.0000),
 (355,419,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (355,420,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,63.6300,369.6300,'','',0,0,0,1,21.0000,306.0000),
 (356,421,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (356,422,'0101002',0,0,4.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,84.8400,492.8400,'','',0,0,0,1,21.0000,408.0000),
 (357,423,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,0,0.0000,202.0000),
 (357,424,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,63.6300,369.6300,'','',0,0,0,1,21.0000,306.0000),
 (358,425,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (358,426,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (359,427,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (359,428,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (360,429,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (360,430,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (361,431,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (361,432,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (362,433,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (362,434,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (363,435,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (363,436,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (364,437,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (364,438,'0101004',0,0,1.0000,'',0.0000,'','Alambre p/rienda 4,8 c/PVC',100.0000,21.0000,121.0000,'','',0,0,0,1,21.0000,100.0000),
 (365,439,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (365,440,'0101004',0,0,1.0000,'',0.0000,'','Alambre p/rienda 4,8 c/PVC',100.0000,21.0000,121.0000,'','',0,0,0,1,21.0000,100.0000),
 (366,441,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (366,442,'0101004',0,0,1.0000,'',0.0000,'','Alambre p/rienda 4,8 c/PVC',100.0000,21.0000,121.0000,'','',0,0,0,1,21.0000,100.0000),
 (367,443,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (367,444,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,32.1300,134.1300,'','',0,0,0,1,21.0000,102.0000),
 (368,445,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (368,446,'0101001',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,63.6300,366.6300,'','',0,0,0,1,21.0000,303.0000),
 (368,447,'0101002',0,0,5.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,160.6500,670.6500,'','',0,0,0,1,21.0000,510.0000),
 (369,448,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (369,449,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,32.1300,134.1300,'','',0,0,0,1,21.0000,102.0000),
 (370,450,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (370,451,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,166.2600,'','',0,0,0,1,21.0000,102.0000),
 (371,452,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (371,453,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,32.1300,134.1300,'','',0,0,0,1,21.0000,102.0000),
 (372,454,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (372,455,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,32.1300,134.1300,'','',0,0,0,1,21.0000,102.0000),
 (373,456,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,192.7800,396.7800,'','',0,0,0,1,21.0000,204.0000),
 (373,457,'0101002',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,96.3900,198.3900,'','',0,0,0,1,21.0000,102.0000),
 (374,458,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (374,459,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (375,460,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (375,461,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (376,462,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000);
INSERT INTO `detafactu` (`idfactura`,`idfacturah`,`articulo`,`idconcepto`,`servicio`,`cantidad`,`unidad`,`cantidadfc`,`unidadfc`,`detalle`,`unitario`,`impuestos`,`total`,`codigocta`,`nombrecta`,`cuota`,`cantcuotas`,`padron`,`impuesto`,`razonimp`,`neto`) VALUES 
 (377,463,'0101002',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,268.2600,'','',0,0,0,1,21.0000,204.0000),
 (378,464,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,21.2100,122.2100,'','',0,0,0,1,21.0000,101.0000),
 (378,465,'0101004',0,0,1.0000,'',0.0000,'','Alambre p/rienda 4,8 c/PVC',100.0000,21.0000,121.0000,'','',0,0,0,1,21.0000,100.0000),
 (379,466,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (379,467,'0101003',0,0,1.0000,'',0.0000,'','Alambre de cruzada bicolor 2 x 0.51',100.0000,10.5000,110.5000,'','',0,0,0,2,10.5000,100.0000),
 (380,468,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (380,469,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (381,470,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (381,471,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (382,472,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (382,473,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (382,474,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (383,475,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (383,476,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (383,477,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (384,478,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (384,479,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (384,480,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (385,481,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (385,482,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (385,483,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (386,484,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (386,485,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (386,486,'',0,0,1.0000,'',1.0000,'','COSTO FINANCIACION',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (387,487,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (388,488,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (389,489,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (389,490,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (390,491,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (390,492,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (391,493,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (391,494,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (392,495,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (392,496,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (393,497,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (393,498,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (394,499,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (394,500,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (395,501,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (395,502,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (396,503,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (396,504,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (397,505,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (397,506,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (398,507,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (398,508,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (399,509,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (399,510,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (400,511,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (400,512,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (401,513,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (402,514,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (402,515,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (402,516,'0000001',0,0,1.0000,'$',1.0000,'','COSTO FINANCIACION',122.9360,25.8166,148.7526,'','',0,0,0,1,21.0000,122.9360),
 (403,517,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (403,518,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (403,519,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',122.9360,25.8166,148.7526,'','',0,0,0,1,21.0000,122.9360),
 (404,520,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (404,521,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (404,522,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',0.0000,0.0000,0.0000,'','',0,0,0,1,21.0000,0.0000),
 (405,523,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (405,524,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (406,525,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (406,526,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (407,527,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (407,528,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (408,529,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (408,530,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (409,531,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (409,532,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (410,533,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (410,534,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (410,535,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',61.4600,12.9066,74.3666,'','',0,0,0,1,21.0000,61.4600),
 (411,536,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (411,537,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (411,538,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',61.4600,12.9066,74.3666,'','',0,0,0,1,21.0000,61.4600),
 (412,539,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (412,540,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (413,541,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (413,542,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (413,543,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',60.0000,12.6000,72.6000,'','',0,0,0,1,21.0000,60.0000),
 (414,544,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (414,545,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (415,546,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (415,547,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (416,548,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (416,549,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (416,550,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',120.0000,25.2000,145.2000,'','',0,0,0,1,21.0000,120.0000),
 (417,551,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (417,552,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (417,553,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',122.9360,25.8166,148.7526,'','',0,0,0,1,21.0000,122.9360),
 (418,554,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (418,555,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (418,556,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',120.0000,25.2000,145.2000,'','',0,0,0,1,21.0000,120.0000),
 (419,557,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (419,558,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (420,559,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (420,560,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (421,561,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (421,562,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (422,563,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (422,564,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (422,565,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',122.9360,25.8166,148.7526,'','',0,0,0,1,21.0000,122.9360),
 (423,566,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (423,567,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (423,568,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',120.0000,25.2000,145.2000,'','',0,0,0,1,21.0000,120.0000),
 (424,569,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (424,570,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (424,571,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',20.8320,4.3747,25.2067,'','',0,0,0,1,21.0000,20.8320),
 (425,572,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (425,573,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (425,574,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',20.8320,4.3747,25.2067,'','',0,0,0,1,21.0000,20.8320),
 (426,575,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (426,576,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (426,577,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (427,578,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (427,579,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (427,580,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (428,581,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (428,582,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (428,583,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (429,584,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (429,585,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (429,586,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (430,587,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (430,588,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (430,589,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (431,590,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (431,591,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (432,592,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (432,593,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (433,594,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (433,595,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (434,596,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (434,597,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (435,598,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (435,599,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (436,600,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (436,601,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (437,602,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (437,603,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (437,604,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',101.6000,21.3360,122.9360,'','',0,0,0,1,21.0000,101.6000),
 (438,605,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (438,606,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (438,607,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (439,608,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (439,609,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (439,610,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',120.0000,25.2000,145.2000,'','',0,0,0,1,21.0000,120.0000),
 (440,611,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (440,612,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (441,613,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (441,614,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (442,615,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (442,616,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (442,617,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',120.0000,25.2000,145.2000,'','',0,0,0,1,21.0000,120.0000),
 (443,618,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (443,619,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (443,620,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',120.0000,25.2000,145.2000,'','',0,0,0,1,21.0000,120.0000),
 (444,621,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (444,622,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (444,623,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (445,624,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (445,625,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (445,626,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',99.1736,20.8265,120.0001,'','',0,0,0,1,21.0000,99.1736),
 (446,627,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (446,628,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (446,629,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',101.5868,21.3332,122.9200,'','',0,0,0,1,21.0000,101.5868),
 (447,630,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (447,631,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (448,632,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (448,633,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (448,634,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',101.5868,21.3332,122.9200,'','',0,0,0,1,21.0000,101.5868),
 (449,635,'0000002',0,0,1.0000,'$',0.0000,'','ND por interés tarjeta',100.0000,21.0000,121.0000,'','',0,0,0,1,21.0000,100.0000),
 (450,636,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (451,637,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (451,638,'0000003',0,0,40.0000,'$',0.0000,'','Descuentos',-1.0000,-8.4000,-48.4000,'','',0,0,0,1,21.0000,-40.0000),
 (452,639,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (453,640,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (454,641,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (454,642,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (454,643,'0000003',0,0,8.0000,'$',0.0000,'','Descuentos',-1.0000,-1.6800,-9.6800,'','',0,0,0,1,21.0000,-8.0000),
 (455,644,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (455,645,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (455,646,'0000003',0,0,8.0000,'$',0.0000,'','Descuentos',-1.0000,-1.6800,-9.6800,'','',0,0,0,1,21.0000,-8.0000),
 (456,647,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (456,648,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',102.0000,64.2600,370.2600,'','',0,0,0,1,21.0000,306.0000),
 (456,649,'0000003',0,0,10.0000,'$',0.0000,'','Descuentos',-1.0000,-2.1000,-12.1000,'','',0,0,0,1,21.0000,-10.0000),
 (457,650,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (458,651,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',101.0000,42.4200,244.4200,'','',0,0,0,1,21.0000,202.0000),
 (459,652,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000),
 (459,653,'0101002',0,0,3.0000,'UNIDADES',0.0000,'','Alambre de bajada PVC 2 x 0.81',132.6000,83.5380,481.3380,'','',0,0,0,1,21.0000,397.8000),
 (459,654,'0000001',0,0,1.0000,'$',1.0000,'$','Interés por financiación',115.7025,24.2975,140.0000,'','',0,0,0,1,21.0000,115.7025),
 (460,655,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,25.4520,146.6520,'','',0,0,0,1,21.0000,121.2000),
 (461,656,'0101001',0,0,1.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,25.4520,146.6520,'','',0,0,0,1,21.0000,121.2000),
 (462,657,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000),
 (463,658,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000),
 (464,659,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000),
 (465,660,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000),
 (466,661,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000),
 (467,662,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000),
 (468,663,'0101001',0,0,2.0000,'UNIDADES',0.0000,'','Alambre de bajada c/autop.2 x 0.61',121.2000,50.9040,293.3040,'','',0,0,0,1,21.0000,242.4000);
/*!40000 ALTER TABLE `detafactu` ENABLE KEYS */;


--
-- Definition of table `detallecobros`
--

DROP TABLE IF EXISTS `detallecobros`;
CREATE TABLE `detallecobros` (
  `iddetacobro` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `idcuenta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`iddetacobro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detallecobros`
--

/*!40000 ALTER TABLE `detallecobros` DISABLE KEYS */;
INSERT INTO `detallecobros` (`iddetacobro`,`idcomproba`,`idregistro`,`idtipopago`,`importe`,`idcuenta`) VALUES 
 (1,1,1,3,611.0500,0),
 (2,1,2,3,611.0500,0),
 (3,1,3,3,611.0500,0),
 (4,1,4,3,611.0500,0),
 (5,1,5,3,611.0500,0),
 (6,1,7,3,611.0500,0),
 (7,1,8,3,733.2600,0),
 (8,1,9,3,733.2600,0),
 (9,1,10,3,733.2600,0),
 (10,1,12,3,407.3600,0),
 (11,1,13,3,488.8400,0),
 (12,1,14,3,488.8400,0),
 (13,1,15,3,733.2600,0),
 (14,1,16,3,733.2600,0),
 (15,1,17,3,733.2600,0),
 (16,1,18,3,488.8400,0),
 (17,1,19,3,611.0500,0),
 (18,1,20,3,733.2600,0),
 (19,1,21,3,488.8400,0),
 (20,1,22,3,488.8400,0),
 (21,1,23,3,488.8400,0),
 (22,1,24,3,488.8400,0),
 (23,1,25,3,488.8400,0),
 (24,1,26,3,488.8400,0),
 (25,1,27,3,617.1000,0),
 (26,1,28,3,611.0500,0),
 (27,1,29,3,611.0500,0),
 (28,1,30,3,611.0500,0),
 (29,1,31,3,488.8400,0),
 (30,1,32,3,244.4200,0),
 (31,1,33,3,122.2100,0),
 (32,1,34,3,366.6300,0),
 (33,1,35,3,366.6300,0),
 (34,1,36,3,244.4200,0),
 (35,1,37,3,366.6300,0),
 (36,1,38,3,244.4200,0),
 (37,1,39,3,366.6300,0),
 (38,1,40,3,366.6300,0),
 (39,1,41,3,366.6300,0),
 (40,1,42,3,366.6300,0),
 (41,1,43,3,488.8400,0),
 (42,5,15,3,244.4200,1),
 (43,5,17,3,122.2100,1),
 (44,5,18,3,244.4200,1),
 (45,5,24,2,44.4200,1),
 (46,0,0,2,44.4200,1),
 (47,5,25,2,44.4200,1),
 (48,0,0,2,44.4200,1),
 (49,5,26,2,44.4200,1),
 (50,5,27,2,44.4200,1),
 (51,5,28,2,44.0000,1),
 (53,5,43,1,244.4200,0),
 (54,5,44,1,44.4200,0),
 (55,5,45,1,66.6300,0),
 (56,5,47,1,44.4200,1),
 (57,5,47,4,200.0000,1),
 (58,5,48,1,66.6300,1),
 (59,5,48,4,300.0000,1),
 (60,5,49,1,66.6300,1),
 (61,5,49,4,300.0000,1),
 (62,5,50,1,44.4200,1),
 (63,5,50,4,200.0000,1),
 (64,5,51,1,44.4200,1),
 (65,5,51,4,200.0000,1),
 (66,5,52,1,121.4641,1),
 (67,5,52,4,613.2600,1),
 (68,5,53,1,106.0656,1),
 (69,5,53,4,173.3040,1),
 (70,5,54,1,100.0000,1),
 (71,5,54,4,179.3696,1),
 (72,5,55,1,100.0000,1),
 (73,5,55,4,179.3696,1),
 (74,5,56,1,100.0000,1),
 (75,5,56,4,179.3696,1),
 (76,5,57,1,22.2100,1),
 (77,5,57,4,124.2000,1),
 (78,5,58,1,59.8629,1),
 (79,5,58,4,385.5132,1),
 (80,5,59,1,366.6300,1),
 (81,5,60,1,55.3545,1),
 (82,5,60,4,386.6042,1),
 (83,5,61,1,44.4200,1),
 (84,5,61,4,248.4000,1),
 (85,5,62,1,122.2100,1),
 (86,0,63,1,122.2100,1),
 (87,5,64,1,122.2100,1),
 (88,0,65,1,611.0500,1),
 (89,0,66,1,733.2600,1),
 (90,0,67,1,244.4200,1),
 (91,0,69,1,244.4200,1),
 (92,0,70,1,88.8400,1),
 (93,5,71,1,88.8400,1),
 (94,5,72,1,611.0500,1),
 (95,5,73,1,11.0500,1),
 (96,5,74,1,611.0500,1),
 (97,5,75,1,11.0500,1),
 (98,5,76,1,44.4200,1),
 (99,5,77,1,44.4200,1),
 (100,5,77,4,200.0000,1),
 (101,5,78,1,244.4200,1),
 (102,5,79,1,44.4200,1),
 (103,5,80,1,44.4200,1),
 (104,5,81,1,44.4200,1),
 (105,5,81,4,200.0000,1),
 (106,5,82,1,44.4200,1),
 (107,5,82,4,248.4000,1),
 (108,5,83,1,122.2100,1),
 (109,5,86,1,1000.0000,1),
 (110,5,86,1,200.0000,1),
 (111,5,87,1,611.0500,1),
 (112,5,88,1,100.0000,1),
 (113,5,89,1,100.0000,1),
 (114,5,90,1,100.0000,1),
 (115,5,91,1,11.0500,1),
 (116,5,92,1,11.0500,1),
 (117,5,92,4,600.0000,1),
 (118,5,93,1,1000.0000,1),
 (119,5,94,1,200.0000,1),
 (120,5,95,1,11.0500,1),
 (121,5,96,1,0.0000,1),
 (122,5,96,4,303.5696,1),
 (123,5,97,1,22.2100,1),
 (124,5,98,1,6.3000,1),
 (125,5,99,1,2.1000,1),
 (126,5,100,3,122.2100,1),
 (127,5,101,3,600.0000,1),
 (128,5,102,1,11.0500,1),
 (129,5,103,1,122.2100,1),
 (130,5,104,1,611.0500,1),
 (131,5,105,1,1222.1000,1),
 (132,5,106,1,122.2100,1),
 (133,5,107,1,100.0000,1),
 (134,5,108,1,12.6000,1),
 (135,5,109,1,100.0000,1),
 (136,5,110,1,1000.0000,1),
 (137,5,111,1,500.0000,1),
 (138,5,112,4,303.5696,1),
 (139,5,113,1,100.0000,1),
 (140,5,113,4,634.7241,1),
 (141,5,114,1,244.4200,1),
 (142,5,115,1,244.4200,1),
 (143,5,116,1,244.4200,1),
 (144,5,117,1,244.4200,1),
 (145,5,118,1,611.0500,1),
 (146,5,119,1,244.4200,1),
 (147,5,120,1,244.4200,1),
 (148,5,121,1,244.4200,1),
 (149,5,122,1,100.0000,1),
 (150,5,123,4,303.5696,1),
 (151,5,124,1,0.0001,1),
 (152,5,125,1,0.0003,1),
 (153,5,126,1,122.2100,1),
 (154,5,127,1,122.2100,1),
 (155,5,128,1,122.2100,1),
 (156,5,129,4,455.3545,1),
 (157,5,130,1,1000.0000,1),
 (158,5,131,1,390.4700,1),
 (159,5,132,1,365.4200,1),
 (160,5,133,1,1305.5400,1),
 (161,5,134,1,402.3900,1),
 (162,5,135,1,434.5200,1),
 (163,5,136,1,390.4700,1),
 (164,5,137,1,243.2100,1),
 (165,5,138,1,614.6800,1),
 (166,5,139,1,14.6800,1),
 (167,5,140,1,14.6800,1),
 (168,5,141,1,14.6800,1),
 (169,5,141,4,600.0000,1),
 (170,5,142,1,244.4200,1),
 (171,5,143,1,244.4200,1),
 (172,5,144,1,614.6800,1),
 (173,0,145,1,614.6800,1),
 (174,13,146,1,614.6800,1),
 (175,5,147,4,763.4326,1),
 (176,5,148,4,303.5696,1),
 (177,5,149,4,763.4326,1),
 (178,5,150,4,763.4326,1),
 (179,5,151,1,14.6800,1),
 (180,5,152,1,12.6000,1),
 (181,5,153,1,14.6800,1),
 (182,5,153,4,600.0000,1),
 (183,5,154,4,614.6800,1),
 (184,5,155,1,14.6800,1),
 (185,5,155,4,745.2000,1),
 (186,5,156,4,763.4326,1),
 (187,5,157,1,14.6800,1),
 (188,5,157,4,745.2000,1),
 (189,5,158,1,614.6800,1),
 (190,5,159,4,614.6800,1),
 (191,5,160,1,14.6800,1),
 (192,5,160,4,600.0000,1),
 (193,5,161,4,763.4326,1),
 (194,5,162,1,14.6800,1),
 (195,5,162,4,745.2000,1),
 (196,5,163,1,14.6801,1),
 (197,5,163,4,720.0000,1),
 (198,5,164,1,14.6801,1),
 (199,5,164,4,720.0000,1),
 (200,5,165,1,14.6801,1),
 (201,5,165,4,720.0000,1),
 (202,5,166,1,14.6801,1),
 (203,5,166,4,720.0000,1),
 (204,0,167,1,14.6800,1),
 (205,0,168,1,614.6800,1),
 (206,0,169,4,614.6800,1),
 (207,0,170,1,14.6800,1),
 (208,0,170,4,600.0000,1),
 (209,0,171,4,737.6160,1),
 (210,0,172,1,14.6801,1),
 (211,0,172,4,720.0000,1),
 (212,5,173,1,25.2000,1),
 (213,5,174,1,25.2000,1),
 (214,5,175,1,0.0001,1),
 (215,5,176,1,14.6800,1),
 (216,0,177,1,14.6800,1),
 (217,5,178,1,368.8000,1),
 (218,5,179,1,196.0200,1),
 (219,13,180,1,244.4200,1),
 (220,13,181,1,602.5800,1),
 (221,13,182,1,244.4200,1),
 (222,5,183,1,244.4200,1),
 (223,13,184,1,74.6420,1),
 (224,13,184,4,840.0000,1),
 (225,14,185,1,293.3040,1),
 (226,14,186,1,293.3040,1);
/*!40000 ALTER TABLE `detallecobros` ENABLE KEYS */;


--
-- Definition of table `detallepagos`
--

DROP TABLE IF EXISTS `detallepagos`;
CREATE TABLE `detallepagos` (
  `iddetapago` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `idcuenta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`iddetapago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detallepagos`
--

/*!40000 ALTER TABLE `detallepagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `detallepagos` ENABLE KEYS */;


--
-- Definition of table `ejercicioecon`
--

DROP TABLE IF EXISTS `ejercicioecon`;
CREATE TABLE `ejercicioecon` (
  `ejercicio` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `fechaini` char(8) NOT NULL,
  `fechafin` char(8) NOT NULL,
  `detalle` char(254) NOT NULL,
  `idplan` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ejercicio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ejercicioecon`
--

/*!40000 ALTER TABLE `ejercicioecon` DISABLE KEYS */;
/*!40000 ALTER TABLE `ejercicioecon` ENABLE KEYS */;


--
-- Definition of table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `idempleado` int(10) unsigned NOT NULL,
  `nombre` char(200) NOT NULL,
  `apellido` char(200) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `direccion` char(200) NOT NULL,
  `telefono` char(20) NOT NULL,
  `sucursal` char(4) NOT NULL,
  `legajo` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idempleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empleados`
--

/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` (`idempleado`,`nombre`,`apellido`,`dni`,`direccion`,`telefono`,`sucursal`,`legajo`) VALUES 
 (1,'Federico','Carrión',38374141,'Ricardo Gutierrez 1962','03483-498389','0001',0);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;


--
-- Definition of table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa` (
  `empresa` char(100) NOT NULL,
  `nomfiscal` char(100) NOT NULL,
  `cuit` char(13) NOT NULL,
  `iva` char(100) NOT NULL,
  `iibb` char(100) NOT NULL,
  `direccion` char(200) NOT NULL,
  `localidad` char(10) NOT NULL,
  `inicioact` char(8) NOT NULL,
  `telefono` char(100) NOT NULL,
  `email` char(200) NOT NULL,
  `web` char(200) NOT NULL,
  `logoempre` char(200) NOT NULL,
  PRIMARY KEY (`empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empresa`
--

/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` (`empresa`,`nomfiscal`,`cuit`,`iva`,`iibb`,`direccion`,`localidad`,`inicioact`,`telefono`,`email`,`web`,`logoempre`) VALUES 
 ('CoSeMar Coop. Ltda.','CoSeMar','20-22141497-8','IVA Responsable Inscripto','EXENTO','Belgrano 1602','1','19870331','03483 - 498200 / 498511','cosemar@cosemar.com.ar','www.cosemar.com.ar','imgamoblark1.jpg');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;


--
-- Definition of table `entidades`
--

DROP TABLE IF EXISTS `entidades`;
CREATE TABLE `entidades` (
  `entidad` int(11) NOT NULL DEFAULT '0',
  `apellido` char(100) NOT NULL,
  `nombre` char(100) NOT NULL,
  `cargo` char(100) NOT NULL,
  `compania` char(100) NOT NULL,
  `cuit` char(13) NOT NULL,
  `direccion` char(100) NOT NULL,
  `localidad` char(10) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `web` char(254) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `tipodoc` char(3) NOT NULL DEFAULT '0',
  `fechanac` char(8) NOT NULL,
  `idafiptipod` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entidad`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidades`
--

/*!40000 ALTER TABLE `entidades` DISABLE KEYS */;
INSERT INTO `entidades` (`entidad`,`apellido`,`nombre`,`cargo`,`compania`,`cuit`,`direccion`,`localidad`,`iva`,`fechaalta`,`telefono`,`cp`,`fax`,`email`,`web`,`dni`,`tipodoc`,`fechanac`,`idafiptipod`) VALUES 
 (1,'ROSSI','TULIO','Sistemas','','20221414978','Avellaneda 6737','3',2,'20150110','4693586','3000','4693586','trossi@cosemar.com.ar','www.cosemar.com.ar',22141497,'1','19711110',2),
 (2,'Racca','Gaston Ramon Alberto','Encargado de Produccion','ALSAFEX S.A.','30712443347','Ruta 11 Km 486','4',1,'','342-4191679','6556','','gracca@alsafex.com.ar','www.alsafex.com.ar',0,'1','',2),
 (3,'OLIVIERO','GERMAN','','','20222222223','PEDRO CENTENO','3',1,'','AAAAAD','3000','DSF','','',2121,'1','',7),
 (4,'Bonet','Pablo','','','20334684734','Mitre','4',2,'20180216','','3018','','','',33468473,'1','19880409',2),
 (5,'Perez','Juán','','','20334684554','','4',1,'20181027','','3018','','','',33468455,'1','19880409',0);
/*!40000 ALTER TABLE `entidades` ENABLE KEYS */;


--
-- Definition of table `entidadesc`
--

DROP TABLE IF EXISTS `entidadesc`;
CREATE TABLE `entidadesc` (
  `idcontacto` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(100) NOT NULL,
  `nombre` char(100) NOT NULL,
  `cargo` char(100) NOT NULL,
  `sector` char(100) NOT NULL,
  `direccion` char(100) NOT NULL,
  `localidad` char(10) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `tipodoc` char(3) NOT NULL,
  `fechanac` char(8) NOT NULL,
  `cuit` char(13) NOT NULL,
  PRIMARY KEY (`idcontacto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadesc`
--

/*!40000 ALTER TABLE `entidadesc` DISABLE KEYS */;
INSERT INTO `entidadesc` (`idcontacto`,`entidad`,`apellido`,`nombre`,`cargo`,`sector`,`direccion`,`localidad`,`fechaalta`,`telefono`,`cp`,`fax`,`email`,`dni`,`tipodoc`,`fechanac`,`cuit`) VALUES 
 (1,1,'DDDDDDDDD','BBBBB','HHHHHHHHH','KKKKKKKK','Avellaneda 6737','1','20150110','66666666','3056','7777777','trossi@cosemar.com.ar',525,'1','20160101','CCCCCCC'),
 (2,1,'Freddy','Rossi','Profesor','Escolar','Alvear','3','20160705','34343445545','3000','','freddyrossi@yahoo.com.ar',0,'1','19730215','33333333');
/*!40000 ALTER TABLE `entidadesc` ENABLE KEYS */;


--
-- Definition of table `entidadescr`
--

DROP TABLE IF EXISTS `entidadescr`;
CREATE TABLE `entidadescr` (
  `entidad` int(10) unsigned NOT NULL DEFAULT '0',
  `fecha` char(8) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `autorizo` char(50) NOT NULL,
  `identidacr` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`identidacr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadescr`
--

/*!40000 ALTER TABLE `entidadescr` DISABLE KEYS */;
INSERT INTO `entidadescr` (`entidad`,`fecha`,`importe`,`autorizo`,`identidacr`) VALUES 
 (1,'20160703',10000.0000,'TULIO',1),
 (2,'20160703',5000.0000,'TULIO',3),
 (1,'20160705',-100.0000,'TULIO',4),
 (3,'20160705',10000.0000,'TULIO',5),
 (3,'20160705',-5000.0000,'TULIO',6),
 (1,'20160705',-8000.0000,'TULIO',7);
/*!40000 ALTER TABLE `entidadescr` ENABLE KEYS */;


--
-- Definition of table `entidadesd`
--

DROP TABLE IF EXISTS `entidadesd`;
CREATE TABLE `entidadesd` (
  `idconcepto` int(10) unsigned NOT NULL,
  `cuotasfact` int(10) unsigned NOT NULL,
  `nrocuotas` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  `abreviado` char(50) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `unidad` char(50) NOT NULL,
  `funcion` char(100) DEFAULT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  `identidadd` int(10) unsigned NOT NULL,
  `mensual` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  PRIMARY KEY (`identidadd`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadesd`
--

/*!40000 ALTER TABLE `entidadesd` DISABLE KEYS */;
INSERT INTO `entidadesd` (`idconcepto`,`cuotasfact`,`nrocuotas`,`articulo`,`detalle`,`abreviado`,`unitario`,`neto`,`impuesto`,`total`,`unidad`,`funcion`,`identidadh`,`identidadd`,`mensual`,`facturar`,`codigocta`,`padron`,`cantidad`) VALUES 
 (0,0,3,'0101001','Alambre de bajada c/autop.2 x 0.61','alambre de bajada',101.0000,101.0000,31.8200,132.8200,'unidades','',3,1,'N','S','0',0,1.0000);
/*!40000 ALTER TABLE `entidadesd` ENABLE KEYS */;


--
-- Definition of table `entidadesdc`
--

DROP TABLE IF EXISTS `entidadesdc`;
CREATE TABLE `entidadesdc` (
  `idcuotasd` int(10) unsigned NOT NULL,
  `identidadd` int(10) unsigned NOT NULL,
  `nrocuota` int(10) unsigned NOT NULL,
  `fechavenc` char(8) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `iva` float(13,4) NOT NULL,
  `cantcuotas` int(10) unsigned NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcuotasd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entidadesdc`
--

/*!40000 ALTER TABLE `entidadesdc` DISABLE KEYS */;
INSERT INTO `entidadesdc` (`idcuotasd`,`identidadd`,`nrocuota`,`fechavenc`,`neto`,`iva`,`cantcuotas`,`idfactura`) VALUES 
 (1,1,1,'20170201',44.2700,9.3000,3,0),
 (2,1,2,'20170301',44.2700,9.3000,3,0),
 (3,1,3,'20170401',44.2700,9.3000,3,0),
 (4,2,1,'20170310',24.4400,5.1300,5,0),
 (5,2,2,'20170410',24.4400,5.1300,5,0),
 (6,2,3,'20170510',24.4400,5.1300,5,0),
 (7,2,4,'20170610',24.4400,5.1300,5,0),
 (8,2,5,'20170710',24.4400,5.1300,5,0);
/*!40000 ALTER TABLE `entidadesdc` ENABLE KEYS */;


--
-- Definition of table `entidadesh`
--

DROP TABLE IF EXISTS `entidadesh`;
CREATE TABLE `entidadesh` (
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `apellido` char(100) NOT NULL,
  `nombre` char(100) NOT NULL,
  `cargo` char(100) NOT NULL,
  `compania` char(100) NOT NULL,
  `cuit` char(13) NOT NULL,
  `direccion` char(100) NOT NULL,
  `localidad` char(10) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `telefono` char(100) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `tipodoc` char(3) NOT NULL,
  `fechanac` char(8) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  `idafiptipod` int(10) unsigned NOT NULL,
  PRIMARY KEY (`identidadh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadesh`
--

/*!40000 ALTER TABLE `entidadesh` DISABLE KEYS */;
INSERT INTO `entidadesh` (`entidad`,`servicio`,`cuenta`,`apellido`,`nombre`,`cargo`,`compania`,`cuit`,`direccion`,`localidad`,`iva`,`fechaalta`,`telefono`,`cp`,`fax`,`email`,`dni`,`tipodoc`,`fechanac`,`ruta1`,`folio1`,`ruta2`,`folio2`,`identidadh`,`idafiptipod`) VALUES 
 (2,2,1,'Racca','Gaston Ramon Alberto','Encargado de Produccion','ALSAFEX S.A.','30712443347','Ruta 11 Km 486','4',1,'20160707','342-4191679','6556','','gracca@alsafex.com.ar',451515,'1','20160707',0,0,0,0,1,0),
 (1,2,1,'ROSSI','TULIO','Sistemas','TRSOFT IT','20221414978','Avellaneda 6737','3',2,'20160707','4693586','3000','4693586','trossi@cosemar.com.ar',22141497,'1','20160707',0,0,0,0,2,0),
 (1,3,1,'ROSSI','TULIO','Sistemas','','20221414978','Avellaneda 6737','3',2,'20160707','4693586','3000','4693586','trossi@cosemar.com.ar',22141497,'1','20160707',0,0,0,0,3,0),
 (1,3,2,'OLIVIERO','GERMAN','Sistemas','','20221414978','Avellaneda 6737','3',2,'20160707','4693586','3000','4693586','trossi@cosemar.com.ar',22141497,'1','20160707',0,0,0,0,4,0);
/*!40000 ALTER TABLE `entidadesh` ENABLE KEYS */;


--
-- Definition of table `entidadg`
--

DROP TABLE IF EXISTS `entidadg`;
CREATE TABLE `entidadg` (
  `idgrupoe` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`identidadh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadg`
--

/*!40000 ALTER TABLE `entidadg` DISABLE KEYS */;
/*!40000 ALTER TABLE `entidadg` ENABLE KEYS */;


--
-- Definition of table `estadosr`
--

DROP TABLE IF EXISTS `estadosr`;
CREATE TABLE `estadosr` (
  `idestadosr` int(10) unsigned NOT NULL,
  `nombre` char(100) NOT NULL,
  PRIMARY KEY (`idestadosr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `estadosr`
--

/*!40000 ALTER TABLE `estadosr` DISABLE KEYS */;
INSERT INTO `estadosr` (`idestadosr`,`nombre`) VALUES 
 (1,'ACTIVO'),
 (2,'ANULADO');
/*!40000 ALTER TABLE `estadosr` ENABLE KEYS */;


--
-- Definition of table `estadosreg`
--

DROP TABLE IF EXISTS `estadosreg`;
CREATE TABLE `estadosreg` (
  `idestadosreg` int(10) unsigned NOT NULL,
  `tabla` char(100) NOT NULL,
  `campo` char(100) NOT NULL,
  `id` char(30) NOT NULL,
  `idestador` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  PRIMARY KEY (`idestadosreg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `estadosreg`
--

/*!40000 ALTER TABLE `estadosreg` DISABLE KEYS */;
INSERT INTO `estadosreg` (`idestadosreg`,`tabla`,`campo`,`id`,`idestador`,`tipo`) VALUES 
 (1,'articulos','articulo','0101001',2,'C'),
 (2,'articulos','articulo','0101001',1,'C'),
 (3,'articulos','articulo','0101002',1,'C'),
 (4,'articulos','articulo','0101001',2,'C'),
 (5,'articulos','articulo','0101001',1,'C'),
 (6,'articulos','articulo','0101002',1,'C'),
 (7,'articulos','articulo','0101002',2,'C'),
 (8,'articulos','articulo','0101001',2,'C'),
 (9,'articulos','articulo','0101001',1,'C'),
 (10,'articulos','articulo','0101002',1,'C'),
 (11,'articulos','articulo','0101002',1,'C');
/*!40000 ALTER TABLE `estadosreg` ENABLE KEYS */;


--
-- Definition of table `etiquetas`
--

DROP TABLE IF EXISTS `etiquetas`;
CREATE TABLE `etiquetas` (
  `articulo` char(50) NOT NULL,
  `etiqueta` char(50) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  PRIMARY KEY (`etiqueta`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `etiquetas`
--

/*!40000 ALTER TABLE `etiquetas` DISABLE KEYS */;
/*!40000 ALTER TABLE `etiquetas` ENABLE KEYS */;


--
-- Definition of table `factclaro`
--

DROP TABLE IF EXISTS `factclaro`;
CREATE TABLE `factclaro` (
  `bocanumero` char(50) NOT NULL,
  `usuario` char(50) NOT NULL,
  `plan` char(5) NOT NULL,
  `abono` float(13,4) NOT NULL,
  `pabono` float(13,4) NOT NULL,
  `tabono` float(13,4) NOT NULL,
  `impserv` float(13,4) NOT NULL,
  `pserv` float(13,4) NOT NULL,
  `tserv` float(13,4) NOT NULL,
  `cargos` float(13,4) NOT NULL,
  `pcargos` float(13,4) NOT NULL,
  `tcargos` float(13,4) NOT NULL,
  `minaire` float(13,4) NOT NULL,
  `minarieex` float(13,4) NOT NULL,
  `impaire` float(13,4) NOT NULL,
  `paire` float(13,4) NOT NULL,
  `taire` float(13,4) NOT NULL,
  `minldn` float(13,4) NOT NULL,
  `impldn` float(13,4) NOT NULL,
  `pldn` float(13,4) NOT NULL,
  `tldn` float(13,4) NOT NULL,
  `minldi` float(13,4) NOT NULL,
  `impldi` float(13,4) NOT NULL,
  `pldi` float(13,4) NOT NULL,
  `tldi` float(13,4) NOT NULL,
  `minldim` float(13,4) NOT NULL,
  `impldim` float(13,4) NOT NULL,
  `pldim` float(13,4) NOT NULL,
  `tldim` float(13,4) NOT NULL,
  `datau` float(13,4) NOT NULL,
  `dataimp` float(13,4) NOT NULL,
  `pdata` float(13,4) NOT NULL,
  `tdata` float(13,4) NOT NULL,
  `impeq` float(13,4) NOT NULL,
  `peq` float(13,4) NOT NULL,
  `teq` float(13,4) NOT NULL,
  `varios` float(13,4) NOT NULL,
  `pvarios` float(13,4) NOT NULL,
  `tvarios` float(13,4) NOT NULL,
  `tclaro` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `nroreg` int(10) unsigned NOT NULL,
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `zona` int(10) unsigned NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `idfactclaro` int(10) unsigned NOT NULL,
  `secuenciaf` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfactclaro`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factclaro`
--

/*!40000 ALTER TABLE `factclaro` DISABLE KEYS */;
/*!40000 ALTER TABLE `factclaro` ENABLE KEYS */;


--
-- Definition of table `factuperiodos`
--

DROP TABLE IF EXISTS `factuperiodos`;
CREATE TABLE `factuperiodos` (
  `servicio` int(10) unsigned NOT NULL,
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `zona` char(50) NOT NULL,
  `fechavenc1` char(8) NOT NULL,
  `fechavenc2` char(8) NOT NULL,
  `fechavenc3` char(8) NOT NULL,
  `proxvenc` char(8) NOT NULL,
  `fechatoma` char(8) NOT NULL,
  `fechaemite` char(8) NOT NULL,
  `fechadesco` char(8) NOT NULL,
  `impresas` char(1) NOT NULL,
  `confirmadas` char(1) NOT NULL,
  `cesp` char(50) NOT NULL,
  `cespvence` char(8) NOT NULL,
  `idperiodo` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idperiodo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factuperiodos`
--

/*!40000 ALTER TABLE `factuperiodos` DISABLE KEYS */;
/*!40000 ALTER TABLE `factuperiodos` ENABLE KEYS */;


--
-- Definition of table `factuprove`
--

DROP TABLE IF EXISTS `factuprove`;
CREATE TABLE `factuprove` (
  `idfactprove` int(10) unsigned NOT NULL,
  `idtipocomp` int(10) unsigned NOT NULL,
  `tipo` char(3) NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `cuit` char(13) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `tipodoc` char(3) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `condvta` int(10) unsigned NOT NULL,
  `nroremito` int(10) unsigned NOT NULL,
  `nropedido` int(10) unsigned NOT NULL,
  `neto` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `exento` float(13,4) NOT NULL,
  `nograbado` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `fechacarga` char(8) NOT NULL,
  `fechaingreso` char(8) NOT NULL,
  PRIMARY KEY (`idfactprove`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factuprove`
--

/*!40000 ALTER TABLE `factuprove` DISABLE KEYS */;
/*!40000 ALTER TABLE `factuprove` ENABLE KEYS */;


--
-- Definition of table `factuproved`
--

DROP TABLE IF EXISTS `factuproved`;
CREATE TABLE `factuproved` (
  `idfactprove` int(10) unsigned NOT NULL,
  `idfactproveh` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `codigoprov` char(50) NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `unidad` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `impuestos` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `razon` float(13,4) NOT NULL,
  PRIMARY KEY (`idfactproveh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factuproved`
--

/*!40000 ALTER TABLE `factuproved` DISABLE KEYS */;
/*!40000 ALTER TABLE `factuproved` ENABLE KEYS */;


--
-- Definition of table `factuproveimp`
--

DROP TABLE IF EXISTS `factuproveimp`;
CREATE TABLE `factuproveimp` (
  `idfactprove` int(10) unsigned NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  PRIMARY KEY (`idfactprove`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factuproveimp`
--

/*!40000 ALTER TABLE `factuproveimp` DISABLE KEYS */;
/*!40000 ALTER TABLE `factuproveimp` ENABLE KEYS */;


--
-- Definition of table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
CREATE TABLE `facturas` (
  `idfactura` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `direccion` char(254) NOT NULL,
  `localidad` char(10) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `cuit` char(13) NOT NULL,
  `tipodoc` char(3) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `transporte` int(10) unsigned NOT NULL,
  `nomtransp` char(254) NOT NULL,
  `direntrega` char(254) NOT NULL,
  `stock` char(1) NOT NULL,
  `idtipoopera` int(10) unsigned NOT NULL,
  `neto` float(13,4) NOT NULL,
  `subtotal` float(13,4) NOT NULL,
  `descuento` float(13,4) NOT NULL,
  `recargo` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `totalimpu` float(13,4) NOT NULL,
  `operexenta` char(1) NOT NULL,
  `anulado` char(1) NOT NULL,
  `observa1` char(254) NOT NULL,
  `observa2` char(254) NOT NULL,
  `observa3` char(254) NOT NULL,
  `observa4` char(254) NOT NULL,
  `idperiodo` int(10) unsigned NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `fechavenc1` char(8) NOT NULL,
  `fechavenc2` char(8) NOT NULL,
  `fechavenc3` char(8) NOT NULL,
  `proxvenc` char(8) NOT NULL,
  `confirmada` char(1) NOT NULL,
  `astoconta` int(10) unsigned NOT NULL,
  `deudacta` float(13,4) NOT NULL,
  `cespcae` char(100) NOT NULL,
  `caecespven` char(8) NOT NULL,
  `vendedor` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfactura`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturas`
--

/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` (`idfactura`,`idcomproba`,`pventa`,`numero`,`tipo`,`fecha`,`entidad`,`servicio`,`cuenta`,`apellido`,`nombre`,`direccion`,`localidad`,`iva`,`cuit`,`tipodoc`,`dni`,`telefono`,`cp`,`fax`,`email`,`transporte`,`nomtransp`,`direntrega`,`stock`,`idtipoopera`,`neto`,`subtotal`,`descuento`,`recargo`,`total`,`totalimpu`,`operexenta`,`anulado`,`observa1`,`observa2`,`observa3`,`observa4`,`idperiodo`,`ruta1`,`folio1`,`ruta2`,`folio2`,`fechavenc1`,`fechavenc2`,`fechavenc3`,`proxvenc`,`confirmada`,`astoconta`,`deudacta`,`cespcae`,`caecespven`,`vendedor`) VALUES 
 (1,1,3,1,'A','20180308',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (2,1,3,1,'A','20180308',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (3,1,3,1,'A','20180308',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (4,1,3,1,'A','20180308',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (5,1,4,16,'A','20180308',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (6,1,4,17,'A','20180308',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (7,1,3,1,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (8,1,3,1,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (9,1,3,1,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (10,1,4,19,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (11,1,4,20,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (12,1,4,1,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,407.3600,3.3600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (13,1,4,21,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (14,1,4,22,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (15,1,4,23,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (16,1,4,24,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (17,1,4,25,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (18,1,4,26,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (19,1,4,27,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (20,1,4,28,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (21,1,4,29,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (22,1,4,30,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (23,1,4,31,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (24,1,4,32,'A','20180309',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (25,1,4,1,'A','20180310',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (26,1,4,1,'A','20180310',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (27,1,4,33,'A','20180310',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,510.0000,510.0000,0.0000,0.0000,617.1000,107.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (28,1,4,34,'A','20180310',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (29,1,4,35,'A','20180312',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (30,1,4,36,'A','20180312',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (31,1,4,37,'A','20180312',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (32,1,4,38,'A','20180312',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (33,1,4,39,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (34,1,4,40,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (35,1,4,41,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (36,1,4,42,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (37,1,4,43,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (38,1,4,44,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (39,1,4,45,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (40,1,4,46,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (41,1,4,47,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (42,1,4,48,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (43,1,4,49,'A','20180313',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (44,1,4,1,'A','20180315',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,306.0000,306.0000,0.0000,0.0000,370.2600,64.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (45,1,4,1,'A','20180315',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (46,1,4,1,'A','20180315',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (47,1,4,1,'A','20180315',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (48,4,4,44,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,306.0000,306.0000,0.0000,0.0000,370.2600,64.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (49,4,4,44,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (50,4,4,44,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (51,4,4,44,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (52,4,4,44,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (53,4,4,44,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,102.0000,102.0000,0.0000,0.0000,123.4200,21.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (54,1,4,1,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (55,1,4,2,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (56,1,4,3,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (57,1,4,4,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (58,1,4,5,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (59,1,4,6,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,204.0000,204.0000,0.0000,0.0000,246.8400,42.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (60,1,4,7,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,204.0000,204.0000,0.0000,0.0000,246.8400,42.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (61,1,4,8,'A','20180316',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (62,1,4,9,'A','20180317',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (63,1,4,63,'A','20180317',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (64,1,4,10,'A','20180317',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (65,1,4,11,'A','20180317',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (66,1,4,12,'A','20180317',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (67,1,4,50,'A','20180317',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (68,1,4,51,'A','20180320',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (69,1,4,52,'A','20180320',0,0,0,'ROSSI TULIO','','Avellaneda 6737','',0,'','99',0,'','','','',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (70,1,4,52,'A','20180320',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (71,1,4,53,'A','20180320',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (72,1,4,54,'A','20180320',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (73,1,4,54,'A','20180320',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (74,1,4,55,'A','20180321',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (75,1,4,56,'A','20180321',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (76,1,4,55,'A','20180321',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (77,1,4,56,'A','20180321',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (78,1,4,57,'A','20180321',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (79,1,4,58,'A','20180321',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (80,1,4,59,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (81,1,4,60,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (82,1,4,61,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (83,1,4,62,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (84,1,4,63,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (85,1,4,64,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (86,1,4,64,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (87,1,4,64,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (88,1,4,65,'A','20180322',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (89,1,4,65,'A','20180324',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (90,1,4,66,'A','20180324',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',0,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (92,1,4,67,'A','20180326',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (93,1,4,67,'A','20180328',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (94,1,4,67,'A','20180328',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (95,1,4,67,'A','20180328',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (96,1,4,67,'A','20180328',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (97,1,4,67,'A','20180328',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (98,1,4,67,'A','20180328',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (99,1,4,67,'A','20180328',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (100,1,4,67,'A','20180329',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (101,1,4,67,'A','20180329',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (102,1,4,67,'A','20180329',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (103,1,4,67,'A','20180329',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (104,1,4,67,'A','20180329',4,0,0,'Bonet','Pablo','Mitre','4',2,'','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (105,1,4,67,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (106,1,4,67,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (107,1,4,67,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (108,1,4,67,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (109,1,4,67,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (110,1,4,68,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (111,1,4,69,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (112,1,4,69,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (113,1,4,69,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (114,1,4,70,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,204.0000,204.0000,0.0000,0.0000,246.8400,42.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (115,1,4,71,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (116,1,4,71,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (117,1,4,71,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (118,1,4,71,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (119,1,4,72,'A','20180331',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (120,1,4,73,'A','20180402',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (121,1,4,74,'A','20180402',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (122,1,4,75,'A','20180402',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (123,1,4,76,'A','20180402',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (124,1,4,76,'A','20180402',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (125,1,4,77,'A','20180402',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (126,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (127,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (128,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (129,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (130,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (131,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (132,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (133,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',2),
 (134,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (135,1,4,78,'A','20180403',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (136,1,4,79,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (137,1,4,80,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (138,1,4,81,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (139,1,4,81,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (140,1,4,81,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (141,1,4,81,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (142,1,4,82,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (143,1,4,83,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,408.0000,408.0000,0.0000,0.0000,493.6800,85.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (144,1,4,84,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (145,1,4,84,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,510.0000,510.0000,0.0000,0.0000,617.1000,107.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (146,1,4,84,'A','20180404',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (147,1,4,84,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (148,1,4,84,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (149,1,4,85,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (150,1,4,85,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (151,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (152,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (153,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (154,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (155,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (156,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (157,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (158,1,4,86,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (159,1,4,87,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (160,1,4,87,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (161,1,4,87,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (162,1,4,87,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (163,1,4,87,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (164,1,4,88,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (165,1,4,89,'A','20180405',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (166,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (167,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (168,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (169,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (170,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (171,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (172,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (173,1,4,89,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (174,1,4,90,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (175,1,4,91,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (176,1,4,92,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,368.9260,368.9260,0.0000,0.0000,446.4005,77.4745,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (177,1,4,92,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,607.2100,607.2100,0.0000,0.0000,734.7241,127.5141,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (178,1,4,92,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,230.8840,230.8840,0.0000,0.0000,279.3696,48.4856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (179,1,4,92,'A','20180406',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,230.8840,230.8840,0.0000,0.0000,279.3696,48.4856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (180,1,4,92,'A','20180407',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,230.8840,230.8840,0.0000,0.0000,279.3696,48.4856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (181,1,4,92,'A','20180407',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (182,1,4,92,'A','20180407',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,230.8840,230.8840,0.0000,0.0000,279.3696,48.4856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (183,1,4,92,'A','20180407',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,230.8840,230.8840,0.0000,0.0000,279.3696,48.4856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (184,1,4,92,'A','20180407',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,230.8840,230.8840,0.0000,0.0000,279.3696,48.4856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (185,1,4,93,'A','20180408',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,304.0000,304.0000,0.0000,0.0000,367.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (186,1,4,93,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,242.0000,242.0000,0.0000,0.0000,292.8200,50.8200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (187,1,4,93,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,230.8840,230.8840,0.0000,0.0000,279.3696,48.4856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (188,1,4,93,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,121.0000,121.0000,0.0000,0.0000,146.4100,25.4100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (189,1,4,93,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,121.0000,121.0000,0.0000,0.0000,146.4100,25.4100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (190,1,4,93,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,368.0794,368.0794,0.0000,0.0000,445.3761,77.2967,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (191,1,4,94,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (192,1,4,95,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,365.2551,365.2551,0.0000,0.0000,441.9587,76.7036,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (193,1,4,96,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,242.0000,242.0000,0.0000,0.0000,292.8200,50.8200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (194,1,4,97,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (195,1,4,98,'A','20180410',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,204.0000,204.0000,0.0000,0.0000,246.8400,42.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (196,1,4,99,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (197,1,4,99,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (198,1,4,99,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (199,1,4,101,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (200,1,4,102,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (201,1,4,103,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (202,1,4,104,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (203,1,4,105,'A','20180411',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (204,4,4,3,'A','20180804',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (205,1,4,106,'A','20180804',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (206,1,1,3,'A','20180817',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,515.0000,515.0000,0.0000,0.0000,515.0000,0.0000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (207,1,1,4,'A','20180817',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (208,1,1,5,'A','20180817',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (209,1,1,6,'A','20180817',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,50.0000,50.0000,0.0000,0.0000,60.5000,10.5000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (210,1,1,7,'A','20180818',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (211,1,1,8,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (212,1,1,9,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1);
INSERT INTO `facturas` (`idfactura`,`idcomproba`,`pventa`,`numero`,`tipo`,`fecha`,`entidad`,`servicio`,`cuenta`,`apellido`,`nombre`,`direccion`,`localidad`,`iva`,`cuit`,`tipodoc`,`dni`,`telefono`,`cp`,`fax`,`email`,`transporte`,`nomtransp`,`direntrega`,`stock`,`idtipoopera`,`neto`,`subtotal`,`descuento`,`recargo`,`total`,`totalimpu`,`operexenta`,`anulado`,`observa1`,`observa2`,`observa3`,`observa4`,`idperiodo`,`ruta1`,`folio1`,`ruta2`,`folio2`,`fechavenc1`,`fechavenc2`,`fechavenc3`,`proxvenc`,`confirmada`,`astoconta`,`deudacta`,`cespcae`,`caecespven`,`vendedor`) VALUES 
 (213,1,1,10,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (214,1,1,11,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (215,1,1,12,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (216,1,1,13,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (217,1,1,14,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (218,1,1,15,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (219,1,1,16,'A','20180821',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (220,1,1,17,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (221,1,1,18,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (222,1,1,19,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,404.0000,404.0000,0.0000,0.0000,488.8400,84.8400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (223,1,1,20,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (224,1,1,21,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (225,1,1,22,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,606.0000,606.0000,0.0000,0.0000,733.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (226,1,1,23,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (227,1,1,24,'A','20180822',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (228,1,1,25,'A','20180823',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (229,1,1,26,'A','20180823',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (230,1,1,27,'A','20180823',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (231,1,1,28,'A','20180823',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (232,1,1,29,'A','20180823',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (233,1,1,30,'A','20180823',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (234,1,1,31,'A','20180823',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (235,1,1,32,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (236,1,1,33,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (237,1,1,34,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (238,1,1,35,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (239,1,1,36,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (240,1,1,37,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (241,1,1,38,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (242,1,1,39,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (243,1,1,40,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (244,1,1,41,'A','20180824',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,242.0000,242.0000,0.0000,0.0000,292.8200,50.8200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (245,1,1,42,'A','20180828',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (246,1,1,43,'A','20180828',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (247,1,1,44,'A','20180829',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (248,1,1,45,'A','20180829',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (249,1,1,46,'A','20180830',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (250,1,1,47,'A','20180831',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (251,1,1,48,'A','20180831',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (252,1,1,49,'A','20180901',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (253,1,1,50,'A','20180903',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (254,1,1,51,'A','20180903',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,250.8840,250.8840,0.0000,0.0000,303.5696,52.6856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (255,1,1,52,'A','20180903',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (256,1,1,53,'A','20180907',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (257,1,1,54,'A','20180907',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (258,1,1,55,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (259,1,1,56,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (260,1,1,57,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (261,1,1,58,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (262,1,1,59,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,133.1600,133.1600,0.0000,0.0000,161.1236,27.9636,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (263,1,1,60,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (264,1,1,61,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,333.0000,333.0000,0.0000,0.0000,402.9300,69.9300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (265,1,1,62,'A','20180908',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,111.0000,111.0000,0.0000,0.0000,134.3100,23.3100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (266,1,1,63,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (267,1,1,64,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (268,1,1,65,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (269,1,1,66,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (270,1,1,67,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (271,1,1,68,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (272,1,1,69,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (273,1,1,70,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (274,1,1,71,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (275,1,1,72,'A','20180911',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (276,1,1,73,'A','20180912',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (277,1,1,74,'A','20180912',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (278,1,1,75,'A','20180915',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (279,1,1,76,'A','20180915',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (280,1,1,77,'A','20180915',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (282,1,1,79,'A','20180921',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (285,1,1,82,'A','20180921',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (286,1,1,83,'A','20180921',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (287,1,1,84,'A','20180921',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (288,1,1,85,'A','20180921',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,1010.0000,1010.0000,0.0000,0.0000,1222.1000,212.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (289,1,1,86,'A','20180922',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (291,1,1,87,'A','20180922',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (292,1,1,88,'A','20180922',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (293,1,1,89,'A','20180922',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,105.4420,105.4420,0.0000,0.0000,127.5848,22.1428,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (294,1,1,90,'A','20180925',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,565.0000,565.0000,0.0000,0.0000,683.6500,118.6500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (295,1,1,91,'A','20180925',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (296,1,1,92,'A','20180926',0,0,0,'','','','',0,'','99',0,'','','','',0,'','','',1,1515.0000,1515.0000,0.0000,0.0000,1515.0000,0.0000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',0),
 (299,1,1,94,'A','20180926',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,2020.0000,2020.0000,0.0000,0.0000,2444.2000,424.2000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (300,1,1,95,'A','20180928',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,565.0000,565.0000,0.0000,0.0000,683.6500,118.6500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (301,1,1,96,'A','20180928',0,0,0,'','','','',0,'','99',0,'','','','',0,'','','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',0),
 (302,1,1,97,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (303,1,1,98,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (304,1,1,99,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (305,1,1,100,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,627.2100,627.2100,0.0000,0.0000,758.9241,131.7141,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (306,1,1,101,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,627.2100,627.2100,0.0000,0.0000,758.9241,131.7141,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (307,1,1,102,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,250.8840,250.8840,0.0000,0.0000,303.5696,52.6856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (308,1,1,103,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,250.8840,250.8840,0.0000,0.0000,303.5696,52.6856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (309,1,1,104,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,250.8840,250.8840,0.0000,0.0000,303.5696,52.6856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (310,1,1,105,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,376.3260,376.3260,0.0000,0.0000,455.3545,79.0285,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (311,1,1,106,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,250.8840,250.8840,0.0000,0.0000,303.5696,52.6856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (312,1,1,107,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,250.8840,250.8840,0.0000,0.0000,303.5696,52.6856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (313,1,1,108,'A','20181006',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,250.8840,250.8840,0.0000,0.0000,303.5696,52.6856,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (314,1,1,109,'A','20181008',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,1210.0000,1210.0000,0.0000,0.0000,1464.1000,254.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (315,1,1,110,'A','20181008',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,607.2100,607.2100,0.0000,0.0000,734.7241,127.5141,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (316,1,1,111,'A','20181008',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,607.2100,607.2100,0.0000,0.0000,734.7241,127.5141,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (317,1,1,112,'A','20181008',0,0,0,'Pablo Rodriguez','','','',0,'','99',0,'','','','',0,'','','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',3),
 (318,4,4,4,'A','20181011',4,0,0,'Bonet','Pablo','Mitre','4',2,'','1',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (319,4,4,5,'A','20181011',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (320,4,4,6,'A','20181011',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','1',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (321,4,4,7,'A','20181011',0,0,0,'','','','',0,'','99',0,'','','','',4,'Bonet Pablo','','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (322,4,4,8,'A','20181011',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (323,1,4,107,'A','20181011',4,0,0,'Bonet','Pablo','Mitre','4',2,'','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (324,1,4,108,'A','20181011',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (325,9,4,1,'','20181011',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (326,1,1,113,'A','20181011',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (327,1,1,114,'A','20181011',4,0,0,'Bonet','Pablo','Mitre','4',2,'','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (328,1,1,115,'A','20181011',4,0,0,'Bonet','Pablo','Mitre','4',2,'','80',33468473,'','3018','','',1,'','Mitre','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (329,1,1,116,'A','20181012',4,0,0,'Bonet','Pablo','Mitre','4',2,'','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',2,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (330,1,1,117,'A','20181012',4,0,0,'Bonet','Pablo','Mitre','4',2,'','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (331,7,1,1,'A','20181012',4,0,0,'Bonet','Pablo','Mitre','4',2,'','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,59.1500,59.1500,0.0000,0.0000,59.1500,0.0000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (334,1,1,120,'A','20181012',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (335,4,4,9,'A','20181012',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (336,4,4,10,'A','20181012',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (337,7,1,2,'A','20181013',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,50.0000,50.0000,0.0000,0.0000,60.5000,10.5000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (338,1,1,121,'A','20181013',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,303.0000,303.0000,0.0000,0.0000,366.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (339,7,1,3,'A','20181013',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,73.3300,73.3300,0.0000,0.0000,88.7272,15.3972,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (340,1,1,122,'A','20181013',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',5,101.0000,101.0000,0.0000,0.0000,122.2100,21.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (343,1,1,125,'A','20181013',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (344,7,1,4,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,50.0000,50.0000,0.0000,0.0000,60.5000,10.5000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (345,1,1,126,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,305.0000,305.0000,0.0000,0.0000,305.0000,0.0000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (346,1,1,127,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,304.0000,304.0000,0.0000,0.0000,367.6300,63.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (347,1,1,128,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,505.0000,505.0000,0.0000,0.0000,611.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (348,1,1,129,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (349,1,1,130,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (350,1,1,131,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,508.0000,508.0000,0.0000,0.0000,614.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (351,1,1,132,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,508.0000,508.0000,0.0000,0.0000,614.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (352,1,1,133,'A','20181016',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','mitre','',1,508.0000,508.0000,0.0000,0.0000,614.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (353,1,1,134,'A','20181017',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,508.0000,508.0000,0.0000,0.0000,614.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (354,1,1,135,'A','20181017',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,506.0000,506.0000,0.0000,0.0000,613.1000,107.1000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (355,1,1,136,'A','20181017',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',3,'','Avellaneda 6737','',1,508.0000,508.0000,0.0000,0.0000,614.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (356,1,1,137,'A','20181017',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,610.0000,610.0000,0.0000,0.0000,737.2600,127.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (357,1,1,138,'A','20181017',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,508.0000,508.0000,0.0000,0.0000,614.0500,106.0500,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (358,1,1,139,'A','20181018',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,305.0000,305.0000,0.0000,0.0000,390.4700,85.4700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (359,1,1,140,'A','20181018',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,305.0000,305.0000,0.0000,0.0000,390.4700,85.4700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (360,1,1,141,'A','20181018',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,305.0000,305.0000,0.0000,0.0000,390.4700,85.4700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',4),
 (361,1,1,142,'A','20181019',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,305.0000,305.0000,0.0000,0.0000,390.4700,85.4700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (362,1,1,143,'A','20181019',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,305.0000,305.0000,0.0000,0.0000,390.4700,85.4700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',2),
 (363,4,4,11,'A','20181019',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,507.0000,507.0000,0.0000,0.0000,634.8900,127.8900,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (364,4,4,12,'A','20181019',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,302.0000,302.0000,0.0000,0.0000,365.4200,63.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (365,4,4,13,'A','20181019',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,302.0000,302.0000,0.0000,0.0000,365.4200,63.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (366,4,4,14,'A','20181019',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,403.0000,403.0000,0.0000,0.0000,487.6300,84.6300,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (367,1,1,144,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,306.0000,306.0000,0.0000,0.0000,402.3900,96.3900,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (368,4,4,15,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,1017.0000,1017.0000,0.0000,0.0000,1305.5400,288.5400,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (369,4,4,16,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,306.0000,306.0000,0.0000,0.0000,402.3900,96.3900,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (370,4,4,17,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,306.0000,306.0000,0.0000,0.0000,434.5200,128.5200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (371,4,4,18,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,306.0000,306.0000,0.0000,0.0000,402.3900,96.3900,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (372,4,4,19,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,306.0000,306.0000,0.0000,0.0000,402.3900,96.3900,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (373,1,4,109,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,306.0000,306.0000,0.0000,0.0000,595.1700,289.1700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (374,4,4,20,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,305.0000,305.0000,0.0000,0.0000,390.4700,85.4700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (375,4,4,21,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,305.0000,305.0000,0.0000,0.0000,390.4700,85.4700,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (376,4,4,22,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,204.0000,204.0000,0.0000,0.0000,268.2600,64.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (377,4,4,23,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,204.0000,204.0000,0.0000,0.0000,268.2600,64.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (378,4,4,24,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,201.0000,201.0000,0.0000,0.0000,243.2100,42.2100,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (379,4,4,25,'A','20181020',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,302.0000,302.0000,0.0000,0.0000,354.9200,52.9200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (380,1,1,145,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (381,1,1,146,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (382,1,1,147,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (383,1,1,148,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (384,1,1,149,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (385,1,1,150,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (386,1,1,151,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (387,1,1,152,'A','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (388,1,1,153,'A','20181022',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (389,1,1,154,'A','20181022',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (390,10,1,1,'B','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (391,10,1,2,'B','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (392,10,1,3,'B','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (393,10,1,4,'B','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (394,10,1,5,'B','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (395,10,1,6,'B','20181022',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (396,1,1,155,'A','20181023',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (397,1,1,156,'A','20181023',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (398,1,1,157,'A','20181023',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (399,1,1,158,'A','20181023',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (400,1,4,110,'A','20181024',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',1,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (401,1,1,159,'A','20181024',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (402,1,1,160,'A','20181024',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,630.9360,630.9360,0.0000,0.0000,763.4326,132.4966,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (403,1,1,161,'A','20181024',4,0,0,'Bonet','Pablo','Mitre','4',2,'20334684734','80',33468473,'','3018','','',4,'Bonet Pablo','Mitre','',4,630.9360,630.9360,0.0000,0.0000,763.4326,132.4966,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (404,1,1,162,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (405,1,1,163,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (406,1,1,164,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (407,1,1,165,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (408,1,1,166,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (409,1,1,167,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (410,1,1,168,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,569.4600,569.4600,0.0000,0.0000,689.0466,119.5866,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (411,1,1,169,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,569.4600,569.4600,0.0000,0.0000,689.0466,119.5866,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (412,1,1,170,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (413,1,1,171,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,568.0000,568.0000,0.0000,0.0000,687.2800,119.2800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (414,1,1,172,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (415,1,1,173,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (416,1,1,174,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,628.0000,628.0000,0.0000,0.0000,759.8800,131.8800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (417,1,1,175,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,630.9360,630.9360,0.0000,0.0000,763.4326,132.4966,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (418,1,4,111,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,628.0000,628.0000,0.0000,0.0000,759.8800,131.8800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (419,1,4,112,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (420,1,4,113,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (421,1,4,114,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (422,1,4,115,'A','20181024',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,630.9360,630.9360,0.0000,0.0000,763.4326,132.4966,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (423,1,1,176,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,628.0000,628.0000,0.0000,0.0000,759.8800,131.8800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (424,1,1,177,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,528.8320,528.8320,0.0000,0.0000,639.8867,111.0547,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (425,1,1,178,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',3,'','Avellaneda 6737','',4,528.8320,528.8320,0.0000,0.0000,639.8867,111.0547,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (426,1,1,179,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (427,1,4,116,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (428,1,4,117,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (429,1,4,118,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (430,1,4,119,'A','20181025',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (431,10,4,1,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (432,10,4,2,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (433,10,4,3,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (434,10,4,4,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (435,10,4,5,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (436,10,4,6,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (437,10,4,7,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,609.6000,609.6000,0.0000,0.0000,737.6160,128.0160,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (438,10,4,8,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',4,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (439,1,4,120,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,628.0000,628.0000,0.0000,0.0000,759.8800,131.8800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (440,1,4,121,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (441,1,4,122,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (442,1,4,123,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,628.0000,628.0000,0.0000,0.0000,759.8800,131.8800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (443,1,4,124,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,628.0000,628.0000,0.0000,0.0000,759.8800,131.8800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (444,1,4,125,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (445,1,4,126,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,607.1736,607.1736,0.0000,0.0000,734.6801,127.5065,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (446,10,4,9,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,609.5868,609.5868,0.0000,0.0000,737.6000,128.0132,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (447,10,4,10,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,508.0000,508.0000,0.0000,0.0000,614.6800,106.6800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (448,10,4,11,'B','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',2,609.5868,609.5868,0.0000,0.0000,737.6000,128.0132,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (449,7,4,1,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,100.0000,100.0000,0.0000,0.0000,121.0000,21.0000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (450,9,4,2,'A','20181026',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',1,306.0000,306.0000,0.0000,0.0000,370.2600,64.2600,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (451,1,4,127,'A','20181027',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,162.0000,162.0000,0.0000,0.0000,196.0200,34.0200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (452,10,4,12,'B','20181027',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (453,10,4,13,'B','20181027',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (454,10,4,14,'B','20181027',0,0,0,'Adrián Magnago','','','',0,'','99',0,'','','','',1,'','','',3,500.0000,500.0000,0.0000,0.0000,605.0000,105.0000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (455,10,4,15,'B','20181027',0,0,0,'Pablo Adrián','','','',0,'','99',0,'','','','',1,'','','',3,500.0000,500.0000,0.0000,0.0000,605.0000,105.0000,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (456,10,4,16,'B','20181027',0,0,0,'Adrián Magnago','','','',0,'','99',0,'','','','',1,'','','',3,498.0000,498.0000,0.0000,0.0000,602.5800,104.5800,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (457,10,4,17,'B','20181027',0,0,0,'Adrián Magnago','','','',0,'','99',0,'','','','',1,'','','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (458,1,1,180,'A','20181027',0,0,0,'Adrián MAgnago','','','',0,'','99',0,'','','','',1,'','','',3,202.0000,202.0000,0.0000,0.0000,244.4200,42.4200,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (459,10,4,18,'B','20181027',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',4,755.9025,755.9025,0.0000,0.0000,914.6420,158.7395,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1);
INSERT INTO `facturas` (`idfactura`,`idcomproba`,`pventa`,`numero`,`tipo`,`fecha`,`entidad`,`servicio`,`cuenta`,`apellido`,`nombre`,`direccion`,`localidad`,`iva`,`cuit`,`tipodoc`,`dni`,`telefono`,`cp`,`fax`,`email`,`transporte`,`nomtransp`,`direntrega`,`stock`,`idtipoopera`,`neto`,`subtotal`,`descuento`,`recargo`,`total`,`totalimpu`,`operexenta`,`anulado`,`observa1`,`observa2`,`observa3`,`observa4`,`idperiodo`,`ruta1`,`folio1`,`ruta2`,`folio2`,`fechavenc1`,`fechavenc2`,`fechavenc3`,`proxvenc`,`confirmada`,`astoconta`,`deudacta`,`cespcae`,`caecespven`,`vendedor`) VALUES 
 (460,1,1,181,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,121.2000,121.2000,0.0000,0.0000,146.6520,25.4520,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (461,1,1,182,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,121.2000,121.2000,0.0000,0.0000,146.6520,25.4520,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (462,1,1,183,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',3,242.4000,242.4000,0.0000,0.0000,293.3040,50.9040,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (463,1,1,184,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',3,242.4000,242.4000,0.0000,0.0000,293.3040,50.9040,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (464,10,1,7,'B','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',3,242.4000,242.4000,0.0000,0.0000,293.3040,50.9040,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (465,1,1,185,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',4,'Bonet Pablo','Avellaneda 6737','',3,242.4000,242.4000,0.0000,0.0000,293.3040,50.9040,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (466,1,1,186,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',3,242.4000,242.4000,0.0000,0.0000,293.3040,50.9040,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',2),
 (467,1,1,187,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',3,242.4000,242.4000,0.0000,0.0000,293.3040,50.9040,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1),
 (468,1,1,188,'A','20181031',1,0,0,'ROSSI','TULIO','Avellaneda 6737','3',2,'20221414978','80',22141497,'4693586','3000','4693586','trossi@cosemar.com.ar',1,'','Avellaneda 6737','',3,242.4000,242.4000,0.0000,0.0000,293.3040,50.9040,'','N','','','','',0,0,0,0,0,'','','','','',0,0.0000,'','',1);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;


--
-- Definition of table `facturasanul`
--

DROP TABLE IF EXISTS `facturasanul`;
CREATE TABLE `facturasanul` (
  `idfactura` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idfactura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturasanul`
--

/*!40000 ALTER TABLE `facturasanul` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturasanul` ENABLE KEYS */;


--
-- Definition of table `facturascta`
--

DROP TABLE IF EXISTS `facturascta`;
CREATE TABLE `facturascta` (
  `idcuotafc` int(10) unsigned NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cancuotas` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `fechavenc` char(8) NOT NULL,
  PRIMARY KEY (`idcuotafc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturascta`
--

/*!40000 ALTER TABLE `facturascta` DISABLE KEYS */;
INSERT INTO `facturascta` (`idcuotafc`,`idfactura`,`cuota`,`cancuotas`,`importe`,`fechavenc`) VALUES 
 (3,82,1,2,110.0000,'20180322'),
 (4,82,2,2,110.0000,'20180322'),
 (5,84,1,3,89.6200,'20180322'),
 (6,84,2,3,89.6200,'20180322'),
 (7,84,3,3,89.6200,'20180322'),
 (8,90,1,3,73.4800,'20180324'),
 (9,90,2,3,73.4800,'20180324'),
 (10,90,3,3,73.4800,'20180324'),
 (11,163,1,3,110.0000,'20180405'),
 (12,163,2,3,110.0000,'20180405'),
 (13,163,3,3,110.0000,'20180405'),
 (14,195,1,1,200.0000,'20180510'),
 (15,198,1,1,220.0000,'20180511'),
 (16,199,1,1,100.0000,'20180411'),
 (17,200,1,2,100.0000,'20180411'),
 (18,200,2,2,100.0000,'20180411'),
 (19,201,1,2,100.0000,'20180411'),
 (20,201,2,2,100.0000,'20180411'),
 (21,202,1,2,100.0000,'20180411'),
 (22,202,2,2,100.0000,'20180411'),
 (23,203,1,2,100.0000,'20180411'),
 (24,203,2,2,100.0000,'20180411'),
 (25,209,1,1,60.5000,'20180817'),
 (26,221,1,4,100.0000,'20180822'),
 (27,221,2,4,100.0000,'20180822'),
 (28,221,3,4,100.0000,'20180822'),
 (29,221,4,4,100.0000,'20180822'),
 (30,222,1,4,100.0000,'20180822'),
 (31,222,2,4,100.0000,'20180822'),
 (32,222,3,4,100.0000,'20180822'),
 (33,222,4,4,100.0000,'20180822'),
 (34,223,1,6,100.0000,'20180822'),
 (35,223,2,6,100.0000,'20180822'),
 (36,223,3,6,100.0000,'20180822'),
 (37,223,4,6,100.0000,'20180822'),
 (38,223,5,6,100.0000,'20180822'),
 (39,223,6,6,100.0000,'20180822'),
 (40,225,1,7,100.0000,'20180822'),
 (41,225,2,7,100.0000,'20180822'),
 (42,225,3,7,100.0000,'20180822'),
 (43,225,4,7,100.0000,'20180822'),
 (44,225,5,7,100.0000,'20180822'),
 (45,225,6,7,100.0000,'20180822'),
 (46,225,7,7,100.0000,'20180822'),
 (47,226,1,6,100.0000,'20180822'),
 (48,226,2,6,100.0000,'20180822'),
 (49,226,3,6,100.0000,'20180822'),
 (50,226,4,6,100.0000,'20180822'),
 (51,226,5,6,100.0000,'20180822'),
 (52,226,6,6,100.0000,'20180822'),
 (53,227,1,6,100.0000,'20180822'),
 (54,227,2,6,100.0000,'20180822'),
 (55,227,3,6,100.0000,'20180822'),
 (56,227,4,6,100.0000,'20180822'),
 (57,227,5,6,100.0000,'20180822'),
 (58,227,6,6,100.0000,'20180822'),
 (59,229,1,6,100.0000,'20180823'),
 (60,229,2,6,100.0000,'20180823'),
 (61,229,3,6,100.0000,'20180823'),
 (62,229,4,6,100.0000,'20180823'),
 (63,229,5,6,100.0000,'20180823'),
 (64,229,6,6,100.0000,'20180823'),
 (65,231,0,6,11.0500,'20180823'),
 (66,231,1,6,100.0000,'20180823'),
 (67,231,2,6,100.0000,'20180823'),
 (68,231,3,6,100.0000,'20180823'),
 (69,231,4,6,100.0000,'20180823'),
 (70,231,5,6,100.0000,'20180823'),
 (71,231,6,6,100.0000,'20180823'),
 (72,232,0,2,44.4200,'20180823'),
 (73,232,1,2,100.0000,'20180823'),
 (74,232,2,2,100.0000,'20180823'),
 (75,238,0,2,0.0000,'20180824'),
 (76,238,1,2,122.2100,'20180824'),
 (77,238,2,2,122.2100,'20180824'),
 (78,239,0,2,0.0000,'20180824'),
 (79,239,1,2,134.4300,'20180824'),
 (80,239,2,2,134.4300,'20180824'),
 (81,240,0,2,44.4200,'20180824'),
 (82,240,1,2,100.0000,'20180824'),
 (83,240,2,2,100.0000,'20180824'),
 (84,241,0,2,44.4200,'20180824'),
 (85,241,1,2,110.0000,'20180824'),
 (86,241,2,2,110.0000,'20180824'),
 (87,250,0,3,11.0500,'20180831'),
 (88,250,1,3,200.0000,'20180831'),
 (89,250,2,3,200.0000,'20180831'),
 (90,250,3,3,200.0000,'20180831'),
 (91,253,0,2,11.0500,'20180903'),
 (92,253,1,2,330.0000,'20180903'),
 (93,253,2,2,330.0000,'20180903'),
 (94,260,0,6,22.2100,'20180908'),
 (95,260,1,6,20.0000,'20180908'),
 (96,260,2,6,20.0000,'20180908'),
 (97,260,3,6,20.0000,'20180908'),
 (98,260,4,6,20.0000,'20180908'),
 (99,260,5,6,20.0000,'20180908'),
 (100,260,6,6,20.0000,'20180908'),
 (101,261,0,5,2.2100,'20180908'),
 (102,261,1,5,26.4000,'20180908'),
 (103,261,2,5,26.4000,'20180908'),
 (104,261,3,5,26.4000,'20180908'),
 (105,261,4,5,26.4000,'20180908'),
 (106,261,5,5,26.4000,'20180908'),
 (107,262,0,2,44.4200,'20180908'),
 (108,262,1,2,110.0000,'20180908'),
 (109,262,2,2,110.0000,'20180908'),
 (110,264,0,2,66.6300,'20180908'),
 (111,264,1,2,165.0000,'20180908'),
 (112,264,2,2,165.0000,'20180908'),
 (113,265,0,2,22.2100,'20180908'),
 (114,265,1,2,55.0000,'20180908'),
 (115,265,2,2,55.0000,'20180908'),
 (116,294,0,1,11.0500,'20180925'),
 (117,294,1,1,660.0000,'20180925'),
 (118,300,0,5,11.0500,'20180928'),
 (119,300,1,5,132.0000,'20180928'),
 (120,300,2,5,132.0000,'20180928'),
 (121,300,3,5,132.0000,'20180928'),
 (122,300,4,5,132.0000,'20180928'),
 (123,300,5,5,132.0000,'20180928'),
 (124,382,0,2,0.0000,'20181022'),
 (125,382,1,2,307.3400,'20181022'),
 (126,382,2,2,307.3400,'20181022'),
 (127,383,0,2,0.0000,'20181022'),
 (128,383,1,2,338.0700,'20181022'),
 (129,383,2,2,338.0700,'20181022'),
 (130,384,0,2,14.6800,'20181022'),
 (131,384,1,2,300.0000,'20181022'),
 (132,384,2,2,300.0000,'20181022'),
 (133,385,0,2,14.6800,'20181022'),
 (134,385,1,2,330.0000,'20181022'),
 (135,385,2,2,330.0000,'20181022'),
 (136,404,0,2,0.0000,'20181024'),
 (137,404,1,2,307.3400,'20181024'),
 (138,404,2,2,307.3400,'20181024'),
 (139,405,0,2,0.0000,'20181024'),
 (140,405,1,2,307.3400,'20181024'),
 (141,405,2,2,307.3400,'20181024'),
 (142,406,0,2,0.0000,'20181024'),
 (143,406,1,2,307.3400,'20181024'),
 (144,406,2,2,307.3400,'20181024'),
 (145,407,0,2,0.0000,'20181024'),
 (146,407,1,2,338.0700,'20181024'),
 (147,407,2,2,338.0700,'20181024'),
 (148,408,0,2,0.0000,'20181024'),
 (149,408,1,2,338.0700,'20181024'),
 (150,408,2,2,338.0700,'20181024'),
 (151,409,0,2,0.0000,'20181024'),
 (152,409,1,2,338.0700,'20181024'),
 (153,409,2,2,338.0700,'20181024'),
 (154,410,0,2,0.0000,'20181024'),
 (155,410,1,2,338.0700,'20181024'),
 (156,410,2,2,338.0700,'20181024'),
 (157,411,0,2,0.0000,'20181024'),
 (158,411,1,2,338.0700,'20181024'),
 (159,411,2,2,338.0700,'20181024'),
 (160,412,0,2,14.6800,'20181024'),
 (161,412,1,2,300.0000,'20181024'),
 (162,412,2,2,300.0000,'20181024'),
 (163,413,0,2,14.6800,'20181024'),
 (164,413,1,2,330.0000,'20181024'),
 (165,413,2,2,330.0000,'20181024'),
 (166,432,0,2,0.0000,'20181026'),
 (167,432,1,2,307.3400,'20181026'),
 (168,432,2,2,307.3400,'20181026'),
 (169,433,0,2,14.6800,'20181026'),
 (170,433,1,2,300.0000,'20181026'),
 (171,433,2,2,300.0000,'20181026'),
 (172,439,0,2,14.6800,'20181026'),
 (173,439,1,2,360.0000,'20181026'),
 (174,439,2,2,360.0000,'20181026'),
 (175,442,0,2,14.6800,'20181026'),
 (176,442,1,2,360.0000,'20181026'),
 (177,442,2,2,360.0000,'20181026'),
 (178,443,0,2,14.6800,'20181026'),
 (179,443,1,2,360.0000,'20181026'),
 (180,443,2,2,360.0000,'20181026'),
 (181,444,0,2,14.6800,'20181026'),
 (182,444,1,2,360.0000,'20181026'),
 (183,444,2,2,360.0000,'20181026'),
 (184,445,0,2,14.6800,'20181026'),
 (185,445,1,2,360.0000,'20181026'),
 (186,445,2,2,360.0000,'20181026'),
 (187,446,0,2,0.0000,'20181026'),
 (188,446,1,2,368.8000,'20181026'),
 (189,446,2,2,368.8000,'20181026'),
 (190,447,0,2,14.6800,'20181026'),
 (191,447,1,2,300.0000,'20181026'),
 (192,447,2,2,300.0000,'20181026'),
 (193,448,0,2,0.0000,'20181026'),
 (194,448,1,2,368.8000,'20181026'),
 (195,448,2,2,368.8000,'20181026');
/*!40000 ALTER TABLE `facturascta` ENABLE KEYS */;


--
-- Definition of table `facturasfe`
--

DROP TABLE IF EXISTS `facturasfe`;
CREATE TABLE `facturasfe` (
  `idfe` int(10) unsigned NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `resultado` char(1) NOT NULL,
  `caecesp` char(50) NOT NULL,
  `caecespven` char(8) NOT NULL,
  `caecespfec` char(8) NOT NULL,
  `pathpdffe` char(254) NOT NULL,
  `idtipofe` int(10) unsigned NOT NULL,
  `idtranafip` int(10) unsigned NOT NULL,
  `observa` char(254) NOT NULL,
  `coderror` char(20) NOT NULL,
  `numerofe` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfe`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturasfe`
--

/*!40000 ALTER TABLE `facturasfe` DISABLE KEYS */;
INSERT INTO `facturasfe` (`idfe`,`idfactura`,`fecha`,`resultado`,`caecesp`,`caecespven`,`caecespfec`,`pathpdffe`,`idtipofe`,`idtranafip`,`observa`,`coderror`,`numerofe`) VALUES 
 (1,5,'20180308','A','68107639037495','20180318','','',0,0,'','',16),
 (2,6,'20180308','A','68107639037877','20180318','','',0,0,'','',17),
 (3,10,'20180309','A','68107639198933','20180319','','',0,0,'','',19),
 (4,11,'20180309','A','68107639201091','20180319','','',0,0,'','',20),
 (6,13,'20180309','A','68107639202709','20180319','','',0,0,'','',21),
 (7,14,'20180309','A','68107639202990','20180319','','',0,0,'','',22),
 (8,15,'20180309','A','68107639203475','20180319','','',0,0,'','',23),
 (9,16,'20180309','A','68107639203755','20180319','','',0,0,'','',24),
 (10,17,'20180309','A','68107639203988','20180319','','',0,0,'','',25),
 (11,18,'20180309','A','68107639204387','20180319','','',0,0,'','',26),
 (12,19,'20180309','A','68107639205008','20180319','','',0,0,'','',27),
 (13,20,'20180309','A','68107639205257','20180319','','',0,0,'','',28),
 (14,21,'20180309','A','68107639205508','20180319','','',0,0,'','',29),
 (15,22,'20180309','A','68107639207393','20180319','','',0,0,'','',30),
 (16,23,'20180309','A','68107639207893','20180319','','',0,0,'','',31),
 (17,24,'20180309','A','68107639208085','20180319','','',0,0,'','',32),
 (18,27,'20180310','A','68107639224469','20180320','','',0,0,'','',33),
 (19,28,'20180310','A','68107639224689','20180320','','',0,0,'','',34),
 (20,29,'20180312','A','68117639499506','20180322','','',0,0,'','',35),
 (21,30,'20180312','A','68117639500324','20180322','','',0,0,'','',36),
 (22,31,'20180312','A','68117639500882','20180322','','',0,0,'','',37),
 (23,32,'20180312','A','68117639501090','20180322','','',0,0,'','',38),
 (24,33,'20180313','A','68117639658552','20180323','','',0,0,'','',39),
 (25,34,'20180313','A','68117639658934','20180323','','',0,0,'','',40),
 (26,35,'20180313','A','68117639659113','20180323','','',0,0,'','',41),
 (27,36,'20180313','A','68117639659286','20180323','','',0,0,'','',42),
 (28,37,'20180313','A','68117639660329','20180323','','',0,0,'','',43),
 (29,38,'20180313','A','68117639661993','20180323','','',0,0,'','',44),
 (30,39,'20180313','A','68117639662245','20180323','','',0,0,'','',45),
 (31,40,'20180313','A','68117639664776','20180323','','',0,0,'','',46),
 (32,41,'20180313','A','68117639665984','20180323','','',0,0,'','',47),
 (33,42,'20180313','A','68117639666516','20180323','','',0,0,'','',48),
 (34,43,'20180313','A','68117639667606','20180323','','',0,0,'','',49),
 (35,54,'20180316','A','68117640042706','20180326','','',0,0,'','',1),
 (36,55,'20180316','A','68117640042748','20180326','','',0,0,'','',2),
 (37,56,'20180316','A','68117640042777','20180326','','',0,0,'','',3),
 (38,57,'20180316','A','68117640042866','20180326','','',0,0,'','',4),
 (39,58,'20180316','A','68117640042882','20180326','','',0,0,'','',5),
 (40,59,'20180316','A','68117640042895','20180326','','',0,0,'','',6),
 (41,60,'20180316','A','68117640042926','20180326','','',0,0,'','',7),
 (42,61,'20180316','A','68117640042942','20180326','','',0,0,'','',8),
 (43,62,'20180317','A','68117640049376','20180327','','',0,0,'','',9),
 (44,64,'20180317','A','68117640055812','20180327','','',0,0,'','',10),
 (45,65,'20180317','A','68117640056017','20180327','','',0,0,'','',11),
 (46,67,'20180317','A','68117640056135','20180327','','',0,0,'','',50),
 (47,68,'20180320','A','68127640325435','20180330','','',0,0,'','',51),
 (48,70,'20180320','A','68127640329879','20180330','','',0,0,'','',52),
 (49,71,'20180320','A','68127640331777','20180330','','',0,0,'','',53),
 (50,73,'20180320','A','68127640332503','20180330','','',0,0,'','',54),
 (51,76,'20180321','A','68127640449592','20180331','','',0,0,'','',55),
 (52,77,'20180321','A','68127640449827','20180331','','',0,0,'','',56),
 (53,78,'20180321','A','68127640451149','20180331','','',0,0,'','',57),
 (54,79,'20180321','A','68127640451916','20180331','','',0,0,'','',58),
 (55,80,'20180322','A','68127640576650','20180401','','',0,0,'','',59),
 (56,81,'20180322','A','68127640577651','20180401','','',0,0,'','',60),
 (57,82,'20180322','A','68127640578021','20180401','','',0,0,'','',61),
 (58,83,'20180322','A','68127640578712','20180401','','',0,0,'','',62),
 (59,84,'20180322','A','68127640578929','20180401','','',0,0,'','',63),
 (60,87,'20180322','A','68127640580301','20180401','','',0,0,'','',64),
 (61,89,'20180324','A','68127640884746','20180403','','',0,0,'','',65),
 (62,90,'20180324','A','68127640884953','20180403','','',0,0,'','',66),
 (63,109,'20180331','A','68137642335446','20180410','','',0,0,'','',67),
 (64,110,'20180331','A','68137642336036','20180410','','',0,0,'','',68),
 (65,113,'20180331','A','68137642337655','20180410','','',0,0,'','',69),
 (66,114,'20180331','A','68137642337891','20180410','','',0,0,'','',70),
 (67,118,'20180331','A','68137642338630','20180410','','',0,0,'','',71),
 (68,119,'20180331','A','68137642351642','20180410','','',0,0,'','',72),
 (69,120,'20180402','A','68147642518474','20180412','','',0,0,'','',73),
 (70,121,'20180402','A','68147642518636','20180412','','',0,0,'','',74),
 (71,122,'20180402','A','68147642519137','20180412','','',0,0,'','',75),
 (72,124,'20180402','A','68147642523566','20180412','','',0,0,'','',76),
 (73,125,'20180402','A','68147642523728','20180412','','',0,0,'','',77),
 (74,135,'20180403','A','68147642751546','20180413','','',0,0,'','',78),
 (75,136,'20180404','A','68147642859376','20180414','','',0,0,'','',79),
 (76,137,'20180404','A','68147642861907','20180414','','',0,0,'','',80),
 (77,141,'20180404','A','68147642865058','20180414','','',0,0,'','',81),
 (78,142,'20180404','A','68147642865469','20180414','','',0,0,'','',82),
 (79,143,'20180404','A','68147642868700','20180414','','',0,0,'','',83),
 (80,148,'20180405','A','68147643100463','20180415','','',0,0,'','',84),
 (81,150,'20180405','A','68147643101715','20180415','','',0,0,'','',85),
 (82,158,'20180405','A','68147643125906','20180415','','',0,0,'','',86),
 (84,163,'20180405','A','68147643127644','20180415','','',0,0,'','',87),
 (85,164,'20180405','A','68147643128014','20180415','','',0,0,'','',88),
 (91,173,'20180406','A','68147643313235','20180416','','',0,0,'','',89),
 (92,174,'20180406','A','68147643313442','20180416','','',0,0,'','',90),
 (93,175,'20180406','A','68147643313528','20180416','','',0,0,'','',91),
 (107,194,'20180410','A','68157644386152','20180420','','',0,0,'','',97),
 (108,195,'20180410','A','68157644386547','20180420','','',0,0,'','',98),
 (109,197,'20180411','A','68157644565691','20180421','','',0,0,'','',99),
 (110,198,'20180411','A','68157644566430','20180421','','',0,0,'','',100),
 (111,199,'20180411','A','68157644568238','20180421','','',0,0,'','',101),
 (112,203,'20180411','A','68157644571608','20180421','','',0,0,'','',102),
 (113,322,'20181011','A','68417686448147','20181021','','',0,0,'','',105),
 (114,324,'20181011','A','68417686448401','20181021','','',0,0,'','',106),
 (115,325,'20181011','A','68417686452801','20181021','','',0,0,'','',1),
 (116,336,'20181012','A','68417686618176','20181022','','',0,0,'','',107),
 (119,366,'20181019','A','68427688741358','20181029','','',0,0,'','',108),
 (127,375,'20181020','R','','','','',0,0,'[10061] La suma de los campos BaseImp en AlicIva debe ser igual al valor ingresado en ImpNeto.\n','',0),
 (128,376,'20181020','R','','','','',0,0,'[10061] La suma de los campos BaseImp en AlicIva debe ser igual al valor ingresado en ImpNeto.\n','',0),
 (129,378,'20181020','A','68427688787123','20181030','','',0,0,'','',109),
 (130,379,'20181020','A','68427688787149','20181030','','',0,0,'','',110),
 (131,400,'20181024','A','68437689373567','20181103','','',0,0,'','',111),
 (133,419,'20181024','A','68437689385509','20181103','','',0,0,'','',112),
 (134,420,'20181024','A','68437689385583','20181103','','',0,0,'','',113),
 (135,421,'20181024','A','68437689385656','20181103','','',0,0,'','',114),
 (136,422,'20181024','R','','','','',0,0,'Hubo un error al autorizar el comprobante. Se obtuvo una respuesta Nula\n','',0),
 (139,430,'20181025','A','68437689748011','20181104','','',0,0,'','',115),
 (140,431,'20181026','A','68437690646097','20181105','','',0,0,'','',1),
 (141,432,'20181026','A','68437690646160','20181105','','',0,0,'','',2),
 (142,433,'20181026','A','68437690646246','20181105','','',0,0,'','',3),
 (143,434,'20181026','A','68437690646306','20181105','','',0,0,'','',4),
 (144,435,'20181026','A','68437690646377','20181105','','',0,0,'','',5),
 (145,436,'20181026','A','68437690646482','20181105','','',0,0,'','',6),
 (146,437,'20181026','A','68437690646568','20181105','','',0,0,'','',7),
 (147,438,'20181026','A','68437690646644','20181105','','',0,0,'','',8),
 (148,439,'20181026','A','68437690647187','20181105','','',0,0,'','',116),
 (149,440,'20181026','A','68437690648971','20181105','','',0,0,'','',117),
 (150,442,'20181026','A','68437690650280','20181105','','',0,0,'','',118),
 (151,443,'20181026','A','68437690650824','20181105','','',0,0,'','',119),
 (152,444,'20181026','A','68437690651265','20181105','','',0,0,'','',120),
 (153,445,'20181026','A','68437690653018','20181105','','',0,0,'','',121),
 (154,446,'20181026','A','68437690653518','20181105','','',0,0,'','',9),
 (155,447,'20181026','A','68437690653607','20181105','','',0,0,'','',10),
 (156,448,'20181026','A','68437690653801','20181105','','',0,0,'','',11),
 (157,449,'20181026','A','68437690654933','20181105','','',0,0,'','',3),
 (158,450,'20181026','A','68437690655201','20181105','','',0,0,'','',2),
 (159,451,'20181027','A','68437690720589','20181106','','',0,0,'','',122),
 (160,452,'20181027','A','68437690721111','20181106','','',0,0,'','',12),
 (161,453,'20181027','A','68437690721682','20181106','','',0,0,'','',13),
 (162,459,'20181027','A','68437690732270','20181106','','',0,0,'','',14);
/*!40000 ALTER TABLE `facturasfe` ENABLE KEYS */;


--
-- Definition of table `facturasimp`
--

DROP TABLE IF EXISTS `facturasimp`;
CREATE TABLE `facturasimp` (
  `idfactura` int(10) unsigned NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `articulo` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturasimp`
--

/*!40000 ALTER TABLE `facturasimp` DISABLE KEYS */;
INSERT INTO `facturasimp` (`idfactura`,`impuesto`,`detalle`,`neto`,`razon`,`importe`,`articulo`) VALUES 
 (1,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (2,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (3,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (4,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (5,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (6,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (7,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (8,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (9,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (10,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (11,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (12,1,'IVA 21%',404.0000,21.0000,3.3600,''),
 (13,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (14,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (15,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (16,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (17,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (18,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (19,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (20,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (21,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (22,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (23,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (24,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (25,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (26,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (27,1,'IVA 21%',510.0000,21.0000,107.1000,''),
 (28,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (29,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (30,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (31,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (32,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (33,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (34,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (35,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (36,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (37,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (38,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (39,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (40,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (41,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (42,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (43,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (44,1,'IVA 21%',306.0000,21.0000,64.2600,''),
 (45,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (46,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (47,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (48,1,'IVA 21%',306.0000,21.0000,64.2600,''),
 (49,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (50,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (51,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (52,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (53,1,'IVA 21%',102.0000,21.0000,21.4200,''),
 (54,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (55,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (56,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (57,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (58,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (59,1,'IVA 21%',204.0000,21.0000,42.8400,''),
 (60,1,'IVA 21%',204.0000,21.0000,42.8400,''),
 (61,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (62,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (63,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (64,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (65,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (66,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (67,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (68,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (69,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (70,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (71,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (72,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (73,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (74,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (75,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (76,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (77,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (78,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (79,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (80,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (81,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (82,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (83,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (84,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (85,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (86,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (87,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (88,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (89,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (90,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (92,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (96,1,'IVA 21%',202.0000,21.0000,0.0000,''),
 (98,1,'IVA 21%',202.0000,21.0000,0.0000,''),
 (99,1,'IVA 21%',101.0000,21.0000,0.0000,''),
 (100,1,'IVA 21%',202.0000,21.0000,0.0000,''),
 (101,1,'IVA 21%',202.0000,21.0000,0.0000,''),
 (102,1,'IVA 21%',202.0000,21.0000,0.0000,''),
 (103,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (104,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (105,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (106,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (107,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (108,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (109,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (110,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (111,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (112,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (113,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (114,1,'IVA 21%',204.0000,21.0000,42.8400,''),
 (115,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (116,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (117,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (118,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (119,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (120,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (121,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (122,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (123,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (124,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (125,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (126,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (127,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (128,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (129,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (130,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (131,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (132,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (133,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (134,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (135,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (136,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (137,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (138,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (139,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (140,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (141,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (142,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (143,1,'IVA 21%',408.0000,21.0000,85.6800,''),
 (144,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (145,1,'IVA 21%',510.0000,21.0000,107.1000,''),
 (146,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (147,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (148,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (149,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (150,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (151,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (152,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (153,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (154,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (155,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (156,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (157,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (158,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (159,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (160,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (161,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (162,1,'IVA 21%',42.4200,21.0000,84.8400,''),
 (163,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (164,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (165,1,'IVA 21%',106.0500,21.0000,212.1000,''),
 (166,1,'IVA 21%',42.4200,21.0000,84.8400,''),
 (167,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (168,1,'IVA 21%',42.4200,21.0000,84.8400,''),
 (169,1,'IVA 21%',106.0500,21.0000,212.1000,''),
 (170,1,'IVA 21%',42.4200,21.0000,84.8400,''),
 (171,1,'IVA 21%',42.4200,21.0000,84.8400,''),
 (172,1,'IVA 21%',63.6300,21.0000,127.2600,''),
 (173,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (174,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (0,0,'',202.0000,0.0000,42.4200,''),
 (175,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (0,0,'',202.0000,0.0000,42.4200,''),
 (176,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (0,0,'',368.9260,0.0000,77.4745,''),
 (177,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (0,0,'',607.2100,0.0000,127.5141,''),
 (178,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (0,0,'',230.8840,0.0000,48.4856,''),
 (179,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (0,0,'',230.8840,0.0000,48.4856,''),
 (180,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (0,0,'',230.8840,0.0000,48.4856,''),
 (181,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (182,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (183,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (184,1,'IVA 21%',230.8840,21.0000,48.4856,''),
 (185,1,'IVA 21%',102.0000,21.0000,21.2100,''),
 (186,1,'IVA 21%',242.0000,21.0000,50.8200,''),
 (187,1,'IVA 21%',230.8840,21.0000,48.4856,''),
 (188,1,'IVA 21%',121.0000,21.0000,25.4100,''),
 (189,1,'IVA 21%',121.0000,21.0000,25.4100,''),
 (190,1,'IVA 21%',368.0794,21.0000,77.2967,''),
 (191,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (192,1,'IVA 21%',365.2551,21.0000,76.7036,''),
 (193,1,'IVA 21%',242.0000,21.0000,50.8200,''),
 (194,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (195,1,'IVA 21%',204.0000,21.0000,42.8400,''),
 (196,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (197,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (198,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (199,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (200,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (201,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (202,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (203,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (204,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (205,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (208,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (209,1,'IVA 21%',50.0000,21.0000,10.5000,''),
 (210,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (211,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (212,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (213,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (214,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (215,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (216,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (217,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (218,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (219,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (220,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (221,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (222,1,'IVA 21%',404.0000,21.0000,84.8400,''),
 (223,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (224,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (225,1,'IVA 21%',606.0000,21.0000,127.2600,''),
 (226,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (227,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (228,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (229,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (230,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (231,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (232,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (233,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (234,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (235,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (236,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (237,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (238,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (239,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (240,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (241,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (242,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (243,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (244,1,'IVA 21%',242.0000,21.0000,50.8200,''),
 (245,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (246,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (247,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (248,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (249,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (250,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (251,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (252,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (253,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (254,1,'IVA 21%',250.8840,21.0000,52.6856,''),
 (255,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (256,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (257,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (258,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (259,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (260,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (261,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (262,1,'IVA 21%',133.1600,21.0000,27.9636,''),
 (263,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (264,1,'IVA 21%',333.0000,21.0000,69.9300,''),
 (265,1,'IVA 21%',111.0000,21.0000,23.3100,''),
 (266,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (267,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (268,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (269,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (270,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (271,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (272,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (273,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (274,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (275,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (276,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (277,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (278,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (279,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (280,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (282,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (286,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (287,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (288,1,'IVA 21%',1010.0000,21.0000,212.1000,''),
 (289,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (291,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (292,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (293,1,'IVA 21%',105.4420,21.0000,22.1428,''),
 (294,1,'IVA 21%',565.0000,21.0000,118.6500,''),
 (295,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (296,1,'IVA 21%',1515.0000,21.0000,0.0000,''),
 (299,1,'IVA 21%',2020.0000,21.0000,424.2000,''),
 (300,1,'IVA 21%',565.0000,21.0000,118.6500,''),
 (301,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (302,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (303,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (304,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (305,1,'IVA 21%',627.2100,21.0000,131.7141,''),
 (306,1,'IVA 21%',627.2100,21.0000,131.7141,''),
 (307,1,'IVA 21%',250.8840,21.0000,52.6856,''),
 (308,1,'IVA 21%',250.8840,21.0000,52.6856,''),
 (309,1,'IVA 21%',250.8840,21.0000,52.6856,''),
 (310,1,'IVA 21%',376.3260,21.0000,79.0285,''),
 (311,1,'IVA 21%',250.8840,21.0000,52.6856,''),
 (312,1,'IVA 21%',250.8840,21.0000,52.6856,''),
 (313,1,'IVA 21%',250.8840,21.0000,52.6856,''),
 (314,1,'IVA 21%',1210.0000,21.0000,254.1000,''),
 (315,1,'IVA 21%',607.2100,21.0000,127.5141,''),
 (316,1,'IVA 21%',607.2100,21.0000,127.5141,''),
 (317,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (318,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (319,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (320,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (321,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (322,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (323,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (324,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (325,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (326,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (327,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (328,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (329,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (330,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (334,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (335,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (336,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (337,1,'IVA 21%',50.0000,21.0000,10.5000,''),
 (338,1,'IVA 21%',303.0000,21.0000,63.6300,''),
 (339,1,'IVA 21%',73.3300,21.0000,15.3972,''),
 (340,1,'IVA 21%',101.0000,21.0000,21.2100,''),
 (343,1,'IVA 21%',505.0000,21.0000,106.0500,''),
 (344,1,'IVA 21%',50.0000,21.0000,10.5000,''),
 (346,1,'IVA 21%',102.0000,21.0000,21.2100,''),
 (347,0,'IVA 21%',0.0000,0.0000,0.0000,''),
 (349,1,'IVA 21%',202.0000,21.0000,42.4200,''),
 (352,1,'IVA 21%',306.0000,21.0000,63.6300,''),
 (353,1,'IVA 21%',306.0000,21.0000,63.6300,''),
 (354,1,'IVA 21%',404.0000,21.0000,85.6800,''),
 (356,1,'IVA 21%',408.0000,21.0000,84.8400,''),
 (358,1,'IVA 21%',305.0000,21.0000,85.4700,''),
 (358,2,'IVA 10.5%',204.0000,10.5000,64.2600,''),
 (360,1,'IVA 21%',305.0000,21.0000,64.0500,''),
 (360,2,'IVA 10.5%',204.0000,10.5000,21.4200,''),
 (361,1,'IVA 21%',204.0000,21.0000,42.8400,'0101002'),
 (362,1,'IVA 21%',204.0000,21.0000,42.8400,'0101002'),
 (362,1,'IVA 21%',101.0000,21.0000,21.2100,'0101001'),
 (362,2,'IVA 10.5%',204.0000,10.5000,21.4200,'0101002'),
 (363,1,'IVA 21%',204.0000,21.0000,42.8400,'0101002'),
 (363,1,'IVA 21%',303.0000,21.0000,63.6300,'0101001'),
 (363,2,'IVA 10.5%',204.0000,10.5000,21.4200,'0101002'),
 (364,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (364,1,'IVA 21%',100.0000,21.0000,21.0000,'0101004'),
 (365,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (365,1,'IVA 21%',100.0000,21.0000,21.0000,'0101004'),
 (366,1,'IVA 21%',303.0000,21.0000,63.6300,'0101001'),
 (366,1,'IVA 21%',100.0000,21.0000,21.0000,'0101004'),
 (367,1,'IVA 21%',204.0000,21.0000,21.4200,'0101002'),
 (367,1,'IVA 21%',102.0000,21.0000,21.4200,'0101002'),
 (367,2,'IVA 10.5%',204.0000,10.5000,10.7100,'0101002'),
 (367,2,'IVA 10.5%',102.0000,10.5000,10.7100,'0101002'),
 (368,1,'IVA 21%',204.0000,21.0000,107.1000,'0101002'),
 (368,1,'IVA 21%',303.0000,21.0000,63.6300,'0101001'),
 (368,1,'IVA 21%',510.0000,21.0000,107.1000,'0101002'),
 (368,2,'IVA 10.5%',204.0000,10.5000,53.5500,'0101002'),
 (368,2,'IVA 10.5%',510.0000,10.5000,53.5500,'0101002'),
 (369,1,'IVA 21%',204.0000,21.0000,21.4200,'0101002'),
 (369,1,'IVA 21%',102.0000,21.0000,21.4200,'0101002'),
 (369,2,'IVA 10.5%',204.0000,10.5000,10.7100,'0101002'),
 (369,2,'IVA 10.5%',102.0000,10.5000,10.7100,'0101002'),
 (370,1,'IVA 21%',204.0000,21.0000,21.4200,'0101002'),
 (370,1,'IVA 21%',204.0000,21.0000,21.4200,'0101002'),
 (370,1,'IVA 21%',102.0000,21.0000,21.4200,'0101002'),
 (370,1,'IVA 21%',102.0000,21.0000,21.4200,'0101002'),
 (370,2,'IVA 10.5%',204.0000,10.5000,10.7100,'0101002'),
 (370,2,'IVA 10.5%',204.0000,10.5000,10.7100,'0101002'),
 (370,2,'IVA 10.5%',102.0000,10.5000,10.7100,'0101002'),
 (370,2,'IVA 10.5%',102.0000,10.5000,10.7100,'0101002'),
 (371,1,'IVA 21%',204.0000,21.0000,21.4200,'0101002'),
 (371,1,'IVA 21%',102.0000,21.0000,21.4200,'0101002'),
 (371,2,'IVA 10.5%',204.0000,10.5000,10.7100,'0101002'),
 (371,2,'IVA 10.5%',102.0000,10.5000,10.7100,'0101002'),
 (372,1,'IVA 21%',204.0000,21.0000,21.4200,'0101002'),
 (372,1,'IVA 21%',102.0000,21.0000,21.4200,'0101002'),
 (372,2,'IVA 10.5%',204.0000,10.5000,10.7100,'0101002'),
 (372,2,'IVA 10.5%',102.0000,10.5000,10.7100,'0101002'),
 (373,1,'IVA 21%',204.0000,21.0000,64.2600,'0101002'),
 (373,1,'IVA 21%',102.0000,21.0000,64.2600,'0101002'),
 (373,2,'IVA 10.5%',204.0000,10.5000,32.1300,'0101002'),
 (373,2,'IVA 10.5%',102.0000,10.5000,32.1300,'0101002'),
 (374,1,'IVA 21%',204.0000,21.0000,42.8400,'0101002'),
 (374,1,'IVA 21%',101.0000,21.0000,21.2100,'0101001'),
 (374,2,'IVA 10.5%',204.0000,10.5000,21.4200,'0101002'),
 (375,1,'IVA 21%',204.0000,21.0000,42.8400,'0101002'),
 (375,1,'IVA 21%',101.0000,21.0000,21.2100,'0101001'),
 (375,2,'IVA 10.5%',204.0000,10.5000,21.4200,'0101002'),
 (376,1,'IVA 21%',204.0000,21.0000,42.8400,'0101002'),
 (376,2,'IVA 10.5%',204.0000,10.5000,21.4200,'0101002'),
 (377,1,'IVA 21%',204.0000,21.0000,42.8400,'0101002'),
 (377,2,'IVA 10.5%',204.0000,10.5000,21.4200,'0101002'),
 (378,1,'IVA 21%',101.0000,21.0000,21.2100,'0101001'),
 (378,1,'IVA 21%',100.0000,21.0000,21.0000,'0101004'),
 (379,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (379,2,'IVA 10.5%',100.0000,10.5000,10.5000,'0101003'),
 (380,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (380,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (381,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (381,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (382,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (382,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (383,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (383,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (384,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (384,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (385,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (385,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (386,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (386,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (387,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (388,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (389,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (389,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (390,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (390,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (391,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (391,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (392,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (392,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (393,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (393,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (394,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (394,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (395,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (395,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (396,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (396,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (397,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (397,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (398,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (398,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (399,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (399,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (400,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (400,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (401,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (402,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (402,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (403,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (403,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (404,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (404,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (405,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (405,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (406,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (406,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (407,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (407,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (408,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (408,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (409,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (409,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (410,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (410,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (411,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (411,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (412,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (412,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (413,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (413,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (414,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (414,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (415,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (415,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (416,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (416,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (417,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (417,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (418,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (418,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (419,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (419,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (420,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (420,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (421,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (421,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (422,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (422,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (423,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (423,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (424,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (424,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (425,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (425,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (426,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (426,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (427,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (427,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (428,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (428,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (429,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (429,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (430,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (430,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (430,1,'IVA 21%',99.1736,21.0000,20.8265,'1'),
 (431,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (431,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (432,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (432,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (433,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (433,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (434,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (434,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (435,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (435,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (436,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (436,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (437,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (437,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (437,1,'IVA 21%',101.6000,21.0000,21.3360,'1'),
 (438,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (438,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (438,1,'IVA 21%',99.1736,21.0000,20.8265,'1'),
 (439,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (439,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (439,1,'IVA 21%',120.0000,21.0000,25.2000,'1'),
 (440,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (440,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (441,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (441,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (442,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (442,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (442,1,'IVA 21%',120.0000,21.0000,25.2000,'1'),
 (443,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (443,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (443,1,'IVA 21%',120.0000,21.0000,25.2000,'1'),
 (444,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (444,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (444,1,'IVA 21%',99.1736,21.0000,20.8265,'1'),
 (445,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (445,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (445,1,'IVA 21%',99.1736,21.0000,20.8265,'1'),
 (446,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (446,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (446,1,'IVA 21%',101.5868,21.0000,21.3332,'1'),
 (447,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (447,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (448,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (448,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (448,1,'IVA 21%',101.5868,21.0000,21.3332,'1'),
 (449,1,'IVA 21%',100.0000,21.0000,21.0000,'0000002'),
 (450,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (451,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (451,1,'IVA 21%',-40.0000,21.0000,-8.4000,'0000003'),
 (452,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (453,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (454,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (454,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (454,1,'IVA 21%',-8.0000,21.0000,-1.6800,'0000003'),
 (455,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (455,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (455,1,'IVA 21%',-8.0000,21.0000,-1.6800,'0000003'),
 (456,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (456,1,'IVA 21%',306.0000,21.0000,64.2600,'0101002'),
 (456,1,'IVA 21%',-10.0000,21.0000,-2.1000,'0000003'),
 (457,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (458,1,'IVA 21%',202.0000,21.0000,42.4200,'0101001'),
 (459,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001'),
 (459,1,'IVA 21%',397.8000,21.0000,83.5380,'0101002'),
 (459,1,'IVA 21%',115.7025,21.0000,24.2975,'1'),
 (460,1,'IVA 21%',121.2000,21.0000,25.4520,'0101001'),
 (461,1,'IVA 21%',121.2000,21.0000,25.4520,'0101001'),
 (462,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001'),
 (463,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001'),
 (464,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001'),
 (465,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001'),
 (466,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001'),
 (467,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001'),
 (468,1,'IVA 21%',242.4000,21.0000,50.9040,'0101001');
/*!40000 ALTER TABLE `facturasimp` ENABLE KEYS */;


--
-- Definition of table `facturasrec`
--

DROP TABLE IF EXISTS `facturasrec`;
CREATE TABLE `facturasrec` (
  `idfacrec` int(10) unsigned NOT NULL,
  `recneto` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `idrecibo` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfacrec`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturasrec`
--

/*!40000 ALTER TABLE `facturasrec` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturasrec` ENABLE KEYS */;


--
-- Definition of table `formicompro`
--

DROP TABLE IF EXISTS `formicompro`;
CREATE TABLE `formicompro` (
  `idform` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `formicompro`
--

/*!40000 ALTER TABLE `formicompro` DISABLE KEYS */;
/*!40000 ALTER TABLE `formicompro` ENABLE KEYS */;


--
-- Definition of table `grupoobjeto`
--

DROP TABLE IF EXISTS `grupoobjeto`;
CREATE TABLE `grupoobjeto` (
  `idgrupobj` int(10) unsigned NOT NULL,
  `idgrupo` int(10) unsigned NOT NULL,
  `idmiembro` char(20) NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idgrupobj`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `grupoobjeto`
--

/*!40000 ALTER TABLE `grupoobjeto` DISABLE KEYS */;
INSERT INTO `grupoobjeto` (`idgrupobj`,`idgrupo`,`idmiembro`,`fecha`) VALUES 
 (34,5,'4','20180823'),
 (35,5,'3','20180823'),
 (36,5,'1','20180823'),
 (37,5,'2','20180823'),
 (63,2,'3','20180823'),
 (64,2,'1','20180823'),
 (65,6,'637','20180823'),
 (66,6,'821','20180823'),
 (67,1,'0913015','20180817'),
 (68,1,'0902007','20180817'),
 (69,1,'0913005','20180817'),
 (70,1,'0913014','20180817'),
 (71,1,'0913004','20180817'),
 (72,1,'0913013','20180817'),
 (73,1,'0913003','20180817'),
 (74,1,'0913012','20180817'),
 (75,1,'0101002','20180817'),
 (76,1,'0101001','20180817'),
 (77,1,'0104013','20180817'),
 (78,1,'0104014','20180817'),
 (79,1,'0104010','20180817'),
 (80,1,'0104011','20180817'),
 (81,1,'0210014','20180817'),
 (82,1,'0215021','20180817'),
 (83,1,'0215022','20180817'),
 (84,1,'0210016','20180817'),
 (85,1,'0215023','20180817'),
 (86,7,'3','20180824'),
 (88,9,'1','20180824'),
 (89,9,'2','20180824'),
 (90,9,'3','20180824');
/*!40000 ALTER TABLE `grupoobjeto` ENABLE KEYS */;


--
-- Definition of table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
CREATE TABLE `grupos` (
  `idgrupo` int(10) unsigned NOT NULL,
  `idtipogrupo` int(10) unsigned NOT NULL,
  `nombre` char(100) NOT NULL,
  `fecha` char(8) NOT NULL,
  `describir` longtext NOT NULL,
  PRIMARY KEY (`idgrupo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `grupos`
--

/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` (`idgrupo`,`idtipogrupo`,`nombre`,`fecha`,`describir`) VALUES 
 (1,1,'Primer Grupo','20180817','cualquiera'),
 (2,2,'Clientes','20180823','Carga de Grupos de Clientes'),
 (4,2,'Clientes 2','20180823','Otro grupo Cliente para Probar'),
 (5,2,'Grupo Clientes Numero 2','20180823','probamos si funciona la carga de grupos nueva'),
 (6,5,'Tapacantos','20180823','Grupo de Materiales de Ordenes de Trabajo Tapacantos'),
 (7,9,'Bancos 0','20180824',''),
 (8,9,'Bancos 1','20180824','Bancos Nuevo'),
 (9,9,'Grupo1','20180824','');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;


--
-- Definition of table `grupose`
--

DROP TABLE IF EXISTS `grupose`;
CREATE TABLE `grupose` (
  `idgrupoe` int(10) unsigned NOT NULL DEFAULT '0',
  `descripcion` char(100) NOT NULL,
  `observa` char(254) NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idgrupoe`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `grupose`
--

/*!40000 ALTER TABLE `grupose` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupose` ENABLE KEYS */;


--
-- Definition of table `gruposepelio`
--

DROP TABLE IF EXISTS `gruposepelio`;
CREATE TABLE `gruposepelio` (
  `dni` int(10) unsigned NOT NULL,
  `tipodoc` char(3) NOT NULL,
  `apellido` char(100) NOT NULL,
  `nombre` char(100) NOT NULL,
  `fechanac` char(8) NOT NULL,
  `parentesco` char(100) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `fechabaja` char(8) NOT NULL,
  `diasvigen` int(10) unsigned NOT NULL DEFAULT '0',
  `sexo` char(1) NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  `idgruposep` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idgruposep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gruposepelio`
--

/*!40000 ALTER TABLE `gruposepelio` DISABLE KEYS */;
INSERT INTO `gruposepelio` (`dni`,`tipodoc`,`apellido`,`nombre`,`fechanac`,`parentesco`,`fechaalta`,`fechabaja`,`diasvigen`,`sexo`,`identidadh`,`idgruposep`) VALUES 
 (38374141,'1','CARRION','FEDERICO','19940713','AMIGO','20170125','20170125',0,'M',3,1);
/*!40000 ALTER TABLE `gruposepelio` ENABLE KEYS */;


--
-- Definition of table `impuestos`
--

DROP TABLE IF EXISTS `impuestos`;
CREATE TABLE `impuestos` (
  `impuesto` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `formula` char(150) DEFAULT NULL,
  `abrevia` char(150) NOT NULL,
  `baseimpon` float(13,4) NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `idafipimp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`impuesto`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `impuestos`
--

/*!40000 ALTER TABLE `impuestos` DISABLE KEYS */;
INSERT INTO `impuestos` (`impuesto`,`detalle`,`razon`,`formula`,`abrevia`,`baseimpon`,`cantidad`,`idafipimp`) VALUES 
 (1,'IVA 21%',21.0000,'','IVA',500.0000,1.0000,5),
 (2,'IVA 10.5%',10.5000,'','IVA',1000.0000,1.0000,2),
 (3,'DESCUENTO POR PAGO EN TERMINO',10.0000,'TOTAL * 10%','DESCUENTO',0.0000,1.0000,0);
/*!40000 ALTER TABLE `impuestos` ENABLE KEYS */;


--
-- Definition of table `largadistancia`
--

DROP TABLE IF EXISTS `largadistancia`;
CREATE TABLE `largadistancia` (
  `idlargad` int(10) unsigned NOT NULL,
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `bocanumero` char(50) NOT NULL,
  `fechllama` char(8) NOT NULL,
  `destino` char(50) NOT NULL,
  `tiempo` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `facturado` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `observa` char(254) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idlargad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `largadistancia`
--

/*!40000 ALTER TABLE `largadistancia` DISABLE KEYS */;
/*!40000 ALTER TABLE `largadistancia` ENABLE KEYS */;


--
-- Definition of table `librosocios`
--

DROP TABLE IF EXISTS `librosocios`;
CREATE TABLE `librosocios` (
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `nombre` char(254) NOT NULL,
  `apellido` char(254) NOT NULL,
  `direccion` char(254) NOT NULL,
  `localidad` int(10) unsigned NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `actanro` char(20) NOT NULL,
  `nrosolicitud` char(20) NOT NULL,
  `capsusc` float(13,4) NOT NULL,
  `capemiti` float(13,4) NOT NULL,
  `capinteg` float(13,4) NOT NULL,
  `fechabaja` char(8) NOT NULL,
  `causabaja` char(8) NOT NULL,
  `observa` char(254) NOT NULL,
  `idlibrosoc` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  `cuit` char(13) NOT NULL,
  `tipodoc` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idlibrosoc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `librosocios`
--

/*!40000 ALTER TABLE `librosocios` DISABLE KEYS */;
/*!40000 ALTER TABLE `librosocios` ENABLE KEYS */;


--
-- Definition of table `librosociosdet`
--

DROP TABLE IF EXISTS `librosociosdet`;
CREATE TABLE `librosociosdet` (
  `idlibrosoc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` char(8) NOT NULL,
  `capemiti` float(13,4) NOT NULL,
  `capineg` float(13,4) NOT NULL,
  `compro` char(30) NOT NULL,
  PRIMARY KEY (`idlibrosoc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `librosociosdet`
--

/*!40000 ALTER TABLE `librosociosdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `librosociosdet` ENABLE KEYS */;


--
-- Definition of table `librosociosdeta`
--

DROP TABLE IF EXISTS `librosociosdeta`;
CREATE TABLE `librosociosdeta` (
  `idlibrosoc` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `capemiti` float(13,4) NOT NULL,
  `capinteg` float(13,4) NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregicomp` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `librosociosdeta`
--

/*!40000 ALTER TABLE `librosociosdeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `librosociosdeta` ENABLE KEYS */;


--
-- Definition of table `lineas`
--

DROP TABLE IF EXISTS `lineas`;
CREATE TABLE `lineas` (
  `linea` char(20) NOT NULL,
  `detalle` char(254) NOT NULL,
  `codigoctac` char(20) NOT NULL,
  `codigoctav` char(20) NOT NULL,
  PRIMARY KEY (`linea`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lineas`
--

/*!40000 ALTER TABLE `lineas` DISABLE KEYS */;
INSERT INTO `lineas` (`linea`,`detalle`,`codigoctac`,`codigoctav`) VALUES 
 ('0101','ALAMBRE Y CABLES','',''),
 ('0102','BULONES','',''),
 ('0103','CAJA Y CAÑOS','',''),
 ('0104','FICHAS','',''),
 ('0105','MORSETERIA','',''),
 ('0106','POSTES Y ANCLAJES','',''),
 ('0109','REPUESTOS','',''),
 ('0110','MATERIALES PARA VENTAS','',''),
 ('0201','ABRAZADERAS','',''),
 ('0202','ADAPTADORES','',''),
 ('0203','BRIDAS','',''),
 ('0204','BUJES','',''),
 ('0205','CAÑOS','',''),
 ('0206','CUPLAS','',''),
 ('0207','CURVAS','',''),
 ('0208','LLAVES','',''),
 ('0209','MANGOS','',''),
 ('0210','MEDIDORES, ACCESORIOS Y CAJAS','',''),
 ('0211','REDUCCIONES','',''),
 ('0212','TAPONES Y TEE','',''),
 ('0213','UNIONES DE REPARACION','',''),
 ('0214','VARIOS','',''),
 ('0215','MATERIALES PARA CLOACAS','',''),
 ('0901','ABRAZADERAS','',''),
 ('0902','ADAPTADORES','',''),
 ('0903','AMPLIFICADORES','',''),
 ('0904','BULONES - MORSETOS -','',''),
 ('0905','CABLES','',''),
 ('0906','CONECTORES','',''),
 ('0907','DIVISORES','',''),
 ('0908','EMPALMES','',''),
 ('0909','GRAMPAS','',''),
 ('0910','JABALINAS','',''),
 ('0911','MODEMS','',''),
 ('0912','RIENDAS, TORNIQUETES Y ANCLAS','',''),
 ('0913','TAPS','','');
/*!40000 ALTER TABLE `lineas` ENABLE KEYS */;


--
-- Definition of table `linkcompro`
--

DROP TABLE IF EXISTS `linkcompro`;
CREATE TABLE `linkcompro` (
  `idlinkcomp` int(10) unsigned NOT NULL,
  `idcomprobaA` int(10) unsigned NOT NULL,
  `idregistroA` int(10) unsigned NOT NULL,
  `idcomprobaB` int(10) unsigned NOT NULL,
  `idregistroB` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idlinkcomp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `linkcompro`
--

/*!40000 ALTER TABLE `linkcompro` DISABLE KEYS */;
INSERT INTO `linkcompro` (`idlinkcomp`,`idcomprobaA`,`idregistroA`,`idcomprobaB`,`idregistroB`) VALUES 
 (1,1,286,1,251),
 (2,1,287,1,251),
 (3,1,288,1,280),
 (4,1,289,1,252),
 (5,1,296,1,249),
 (6,1,296,1,248),
 (7,1,296,1,251),
 (8,1,301,1,251),
 (9,1,343,1,285);
/*!40000 ALTER TABLE `linkcompro` ENABLE KEYS */;


--
-- Definition of table `listaprecioh`
--

DROP TABLE IF EXISTS `listaprecioh`;
CREATE TABLE `listaprecioh` (
  `idlista` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `costo` float(13,4) NOT NULL,
  `margen` float(13,4) NOT NULL,
  `importe` float(13,3) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  PRIMARY KEY (`idlista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `listaprecioh`
--

/*!40000 ALTER TABLE `listaprecioh` DISABLE KEYS */;
INSERT INTO `listaprecioh` (`idlista`,`articulo`,`costo`,`margen`,`importe`,`fechaalta`) VALUES 
 (1,'0101001',101.0000,1.2000,121.200,'20181027');
/*!40000 ALTER TABLE `listaprecioh` ENABLE KEYS */;


--
-- Definition of table `listapreciop`
--

DROP TABLE IF EXISTS `listapreciop`;
CREATE TABLE `listapreciop` (
  `idlista` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `vigedesde` char(8) NOT NULL,
  `vigehasta` char(8) NOT NULL,
  `margen` float(13,4) NOT NULL,
  `condvta` int(10) unsigned NOT NULL,
  `idlistap` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idlista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `listapreciop`
--

/*!40000 ALTER TABLE `listapreciop` DISABLE KEYS */;
INSERT INTO `listapreciop` (`idlista`,`detalle`,`fechaalta`,`vigedesde`,`vigehasta`,`margen`,`condvta`,`idlistap`) VALUES 
 (1,'LISTA 0','20180220','20180220','21000101',1.3000,0,1),
 (2,'LISTA 1','20181031','20181031','20201031',1.5000,0,1);
/*!40000 ALTER TABLE `listapreciop` ENABLE KEYS */;


--
-- Definition of table `localidades`
--

DROP TABLE IF EXISTS `localidades`;
CREATE TABLE `localidades` (
  `localidad` char(10) NOT NULL DEFAULT '0',
  `nombre` char(200) NOT NULL,
  `cp` char(50) NOT NULL,
  `provincia` char(10) NOT NULL,
  PRIMARY KEY (`localidad`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `localidades`
--

/*!40000 ALTER TABLE `localidades` DISABLE KEYS */;
INSERT INTO `localidades` (`localidad`,`nombre`,`cp`,`provincia`) VALUES 
 ('1','Margarita','3056','1'),
 ('3','Santa Fe','3000','1'),
 ('4','RECREO','6556','1'),
 ('5','GALLARETA','DDFD','1');
/*!40000 ALTER TABLE `localidades` ENABLE KEYS */;


--
-- Definition of table `logsystem`
--

DROP TABLE IF EXISTS `logsystem`;
CREATE TABLE `logsystem` (
  `idlog` int(10) unsigned NOT NULL,
  `fechahora` char(20) NOT NULL,
  `usuario` char(20) NOT NULL,
  `tabla` char(50) NOT NULL,
  `campo` char(50) NOT NULL,
  `tipo` char(1) NOT NULL,
  `idtabla` char(50) NOT NULL,
  `operacion` char(20) NOT NULL,
  `ipaddress` char(15) NOT NULL,
  `host` char(30) NOT NULL,
  `detalle` text NOT NULL,
  PRIMARY KEY (`idlog`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logsystem`
--

/*!40000 ALTER TABLE `logsystem` DISABLE KEYS */;
INSERT INTO `logsystem` (`idlog`,`fechahora`,`usuario`,`tabla`,`campo`,`tipo`,`idtabla`,`operacion`,`ipaddress`,`host`,`detalle`) VALUES 
 (6,'18/08/2018 12:44:25','TULIO','otordentra','idot','I','20','I','','',''),
 (7,'28/07/2018 12:47:21','TULIO','otordentra','idot','I','21','I','','',''),
 (8,'28/07/2018 12:54:09','TULIO','otordentra','idot','I','23','I','','',''),
 (9,'28/07/2018 12:58:52','TULIO','otordentra','idot','I','24','I','','','pruebaaosmdosmdo'),
 (10,'28/07/2018 01:00:37','TULIO','otordentra','idot','I','25','I','','',''),
 (18,'28/07/2018 01:20:51','TULIO','otordentra','idot','I','30','I','','','INSERT INTO otordentra (idpedido,idot,fechaot,fechaini,testimado,costoest,descriptot,idestado,detaestado,responsa,observa,idetapa,etapa) values (1,30,20180728,20180728,10d-00:00:00,1000.00,OT PRUEBA 8888,1,INICIADO,TULIO,,1,PREPARACION DE MATERIALES (STOCK))'),
 (19,'28/07/2018 01:21:02','TULIO','otestadosot','','','8','I','','','INSERT INTO otestadosot (idotestadosot,idot,idestado,fecha) values (8,30,1,20180728)'),
 (20,'28/07/2018 01:24:15','TULIO','otordentra','idot','I','31','I','','','INSERT INTO otordentra (idpedido,idot,fechaot,fechaini,testimado,costoest,descriptot,idestado,detaestado,responsa,observa,idetapa,etapa) values (2,31,20180728,20180728,10d-00:00:00,100.00,OT PRUEBA 9999,1,INICIADO,TULIO,,1,PREPARACION DE MATERIALES (STOCK))'),
 (21,'20180728132757','TULIO','otordentra','idot','I','32','I','','','INSERT INTO otordentra (idpedido,idot,fechaot,fechaini,testimado,costoest,descriptot,idestado,detaestado,responsa,observa,idetapa,etapa) values (1,32,20180728,20180728,10d-00:00:00,100.00,OT PRUEBA qowjo,1,INICIADO,TULIO,,1,PREPARACION DE MATERIALES (STOCK))');
/*!40000 ALTER TABLE `logsystem` ENABLE KEYS */;


--
-- Definition of table `medagua`
--

DROP TABLE IF EXISTS `medagua`;
CREATE TABLE `medagua` (
  `bocanumero` char(50) NOT NULL,
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `vue_ante` int(10) unsigned NOT NULL,
  `med_ante` int(10) unsigned NOT NULL,
  `vue_actu` int(10) unsigned NOT NULL,
  `med_actu` int(10) unsigned NOT NULL,
  `consumo` int(10) unsigned NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `facturado` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `idmedagua` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmedagua`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medagua`
--

/*!40000 ALTER TABLE `medagua` DISABLE KEYS */;
/*!40000 ALTER TABLE `medagua` ENABLE KEYS */;


--
-- Definition of table `medluz`
--

DROP TABLE IF EXISTS `medluz`;
CREATE TABLE `medluz` (
  `idmedluz` int(10) unsigned NOT NULL,
  `medant` float(13,4) NOT NULL,
  `medact` float(13,4) NOT NULL,
  `medcal` float(13,4) NOT NULL,
  `consumo` float(13,4) NOT NULL,
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `zona` int(10) unsigned NOT NULL,
  `nroreg` int(10) unsigned NOT NULL,
  `medidor` int(10) unsigned NOT NULL,
  `categoria` int(10) unsigned NOT NULL,
  `fant` char(8) NOT NULL,
  `fact` char(8) NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  `bocanumero` char(50) NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmedluz`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medluz`
--

/*!40000 ALTER TABLE `medluz` DISABLE KEYS */;
/*!40000 ALTER TABLE `medluz` ENABLE KEYS */;


--
-- Definition of table `medtelefono`
--

DROP TABLE IF EXISTS `medtelefono`;
CREATE TABLE `medtelefono` (
  `bocanumero` char(50) NOT NULL DEFAULT '',
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `consumo` float(13,4) NOT NULL,
  `pulddn1` int(10) unsigned NOT NULL,
  `pulddn2` int(10) unsigned NOT NULL,
  `pesos_n` float(13,4) NOT NULL,
  `pesos_r` float(13,4) NOT NULL,
  `pesos` float(13,4) NOT NULL,
  `canddn1` int(10) unsigned NOT NULL,
  `durddn1` int(10) unsigned NOT NULL,
  `pesosddn1` float(13,4) NOT NULL,
  `canddn2` int(10) unsigned NOT NULL,
  `durddn2` int(10) unsigned NOT NULL,
  `pesosddn2` float(13,4) NOT NULL,
  `canddi1` int(10) unsigned NOT NULL,
  `durddi1` int(10) unsigned NOT NULL,
  `pesosddi1` float(13,4) NOT NULL,
  `canddi2` int(10) unsigned NOT NULL,
  `durddi2` int(10) unsigned NOT NULL,
  `pesosddi2` float(13,4) NOT NULL,
  `canloc1` int(10) unsigned NOT NULL,
  `durloc1` int(10) unsigned NOT NULL,
  `pesosloc1` float(13,4) NOT NULL,
  `canloc2` int(10) unsigned NOT NULL,
  `durloc2` int(10) unsigned NOT NULL,
  `pesosloc2` float(13,4) NOT NULL,
  `facturado` char(1) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `idmedtele` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmedtele`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medtelefono`
--

/*!40000 ALTER TABLE `medtelefono` DISABLE KEYS */;
/*!40000 ALTER TABLE `medtelefono` ENABLE KEYS */;


--
-- Definition of table `menusql`
--

DROP TABLE IF EXISTS `menusql`;
CREATE TABLE `menusql` (
  `idmenu` int(11) NOT NULL DEFAULT '0',
  `idmenup` int(11) NOT NULL DEFAULT '0',
  `nivel` char(2) NOT NULL DEFAULT '',
  `codigo` char(14) NOT NULL DEFAULT '',
  `descrip` char(50) NOT NULL DEFAULT '',
  `arranque` char(254) NOT NULL DEFAULT '',
  `comando` char(254) NOT NULL DEFAULT '',
  `opcion` char(2) NOT NULL DEFAULT '',
  `prun` char(1) NOT NULL DEFAULT 'S',
  `pusu` char(1) NOT NULL DEFAULT 'S',
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  `orden` char(2) NOT NULL DEFAULT '00',
  `usuario` char(20) NOT NULL DEFAULT '',
  `fechahora` char(18) NOT NULL DEFAULT '',
  `idmodulo` int(10) unsigned NOT NULL,
  `imagen` char(50) NOT NULL DEFAULT '""',
  PRIMARY KEY (`idmenu`),
  KEY `idmenu` (`idmenu`),
  KEY `nivel` (`nivel`),
  KEY `codigo` (`codigo`),
  KEY `habilitado` (`habilitado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menusql`
--

/*!40000 ALTER TABLE `menusql` DISABLE KEYS */;
INSERT INTO `menusql` (`idmenu`,`idmenup`,`nivel`,`codigo`,`descrip`,`arranque`,`comando`,`opcion`,`prun`,`pusu`,`habilitado`,`orden`,`usuario`,`fechahora`,`idmodulo`,`imagen`) VALUES 
 (1,0,'P','01000000000000','Archivos','','','','N','N','S','01','admin','2012092919:33:00',1,''),
 (2,1,'H','01010000000000','Cambiar Empresa','','DO FORM login','0','S','S','S','01','admin','2016062509:55:42',1,'GANANCIAS SOCIEDADES.ICO'),
 (4,0,'P','02000000000000','Ordenes de Trabajo','','','','N','N','S','07','admin','2018041411:51:05',1,''),
 (6,1,'H','01090000000000','Localidades','','DO FORM localidadesabm','2','S','S','S','01','admin','2016062510:46:30',1,''),
 (7,1,'H','01120000000000','Monedas','','DO FORM monedasabm','3','S','S','S','01','admin','2016062510:02:38',1,'ORDERS.ICO'),
 (8,1,'H','01080000000000','Zonas','','DO FORM zonasabm','4','S','S','S','01','admin','2016012718:14:42',1,''),
 (9,1,'H','01070000000000','Vendedores','','DO FORM vendedoresabm','5','S','S','S','01','admin','2016062510:00:14',1,'EMPLY.ICO'),
 (10,0,'P','03000000000000','Facturación','','','','N','N','S','06','admin','2018041411:46:36',1,''),
 (12,1,'H','01380000000000','\\-','','','','N','N','S','05','admin','2016030610:51:06',1,''),
 (13,1,'H','01390000000000','Salir                               Alt+F4','','SALIRMENU()','','S','S','S','01','admin','2016062420:45:28',1,'CERRAR.PNG'),
 (14,0,'P','04000000000000','Ayuda','','','','N','N','S','05','admin','2016030612:09:53',1,''),
 (15,14,'H','04010000000000','Info.Sistema...','','DO FORM infosistema','','S','S','S','05','TULIO','2018060712:33:37',1,'INFO1.PNG'),
 (16,1,'H','01110000000000','Empleados','','DO FORM empleados','6','S','S','S','01','admin','2018041008:20:04',1,''),
 (17,1,'H','01360000000000','Iconos','','DO FORM iconosabm','7','S','S','S','01','admin','2016062510:05:54',1,'FACE03.ICO'),
 (18,1,'H','01340000000000','Biblioteca de Función','','DO FORM bibliotecafabm','8','S','S','S','01','admin','2016052021:15:00',1,''),
 (19,1,'H','01040000000000','Sucursales','','DO FORM sucursalesabm','9','S','S','S','01','admin','2016052115:24:00',1,''),
 (20,1,'H','01350000000000','Modulos del Sistema','','DO FORM modulossysabm','10','S','S','S','01','admin','2016052116:38:00',1,''),
 (21,1,'H','01030000000000','Empresas','','DO FORM empresasabm','11','S','S','S','01','admin','2016052721:55:00',1,''),
 (22,1,'H','01150000000000','Condiciones Fiscales','','DO FORM condfiscalabm','12','S','S','S','01','admin','2016052809:43:00',1,''),
 (23,1,'H','01140000000000','Impuestos','','DO FORM impuestosabm','13','S','S','S','01','admin','2016052811:52:00',1,''),
 (24,1,'H','01130000000000','Servicios','','DO FORM serviciosabm2','14','S','S','S','01','admin','2016052817:17:00',1,''),
 (25,1,'H','01240000000000','Lineas','','DO FORM lineasabm','15','S','S','S','01','admin','2016061117:14:00',1,''),
 (26,1,'H','01100000000000','Provincias','','DO FORM provinciasabm','','S','S','S','01','admin','2016062510:51:36',1,''),
 (27,1,'H','01050000000000','\\-','','','','S','S','S','01','admin','2016062510:58:52',1,''),
 (28,1,'H','01330000000000','\\-','','','','S','S','S','01','admin','2016062511:00:16',1,''),
 (29,1,'H','01370000000000','Seteo ToolBar Sys','','DO FORM toolbarsysabm','','S','S','S','01','admin','2016062601:40:20',1,''),
 (30,1,'H','01060000000000','Clientes-Proveedores','','DO FORM entidades','','S','S','S','01','admin','2016062900:05:11',1,'EMPLY.ICO'),
 (31,1,'H','01220000000000','Artículos','','DO FORM articulos','','S','S','S','01','admin','2016070212:00:11',1,'WZPRINT.BMP'),
 (32,1,'H','01180000000000','\\-','','','','S','S','S','01','admin','2016070212:01:40',1,''),
 (33,10,'H','03010000000000','Factura','','DO FORM facturas','','S','S','S','06','admin','2018041412:06:43',1,''),
 (34,1,'H','01200000000000','Depositos','','DO FORM depositos','','S','S','S','01','admin','2016071614:21:33',1,''),
 (35,1,'H','01190000000000','Conceptos','','DO FORM conceptoser','','S','S','S','01','admin','2016071816:17:25',1,''),
 (36,1,'H','01250000000000','Tipos de Movimientos de Stock','','DO FORM tipomstock','','S','S','S','01','admin','2016072021:19:29',1,''),
 (37,1,'H','01210000000000','Puntos de Venta','','DO FORM puntosventa','','S','S','S','01','admin','2016110509:59:05',1,''),
 (38,1,'H','01320000000000','Tipos de Comprobantes','','DO FORM tipocompro','','S','S','S','01','admin','2016122113:56:00',1,''),
 (39,1,'H','01230000000000','Comprobantes','','DO FORM comprobantes','','S','S','S','01','admin','2017010910:29:43',1,''),
 (40,1,'H','01260000000000','Ajuste de Stock','','DO FORM ajustestockp WITH \"0\"','','S','S','S','01','admin','2017020221:53:08',1,''),
 (41,1,'H','01310000000000','Consulta Movimientos de Stock','','DO FORM consultastock','','S','S','S','01','admin','2017072412:10:44',1,''),
 (46,4,'H','02010000000000','Pedidos','','DO FORM otpedidos','','S','S','S','07','admin','2018041412:07:11',1,''),
 (47,4,'H','02020000000000','Ejecución de Materiales','','DO FORM otejecum','','S','S','S','07','admin','2018041412:07:26',1,''),
 (48,4,'H','02030000000000','Ejecución de Horas H.','','DO FORM otejecuh','','S','S','S','07','admin','2018041412:07:36',1,''),
 (49,4,'H','02040000000000','Ajustes de Stock Materiales','','DO FORM otmovistock WITH 0','','S','S','S','07','admin','2018050318:23:29',1,''),
 (50,4,'H','02050000000000','Materiales','','DO FORM otmateriales','','S','S','S','07','admin','2018041412:07:55',1,''),
 (51,4,'H','02060000000000','Empleados','','DO FORM empleados','','S','S','S','07','admin','2018041412:08:07',1,''),
 (52,10,'H','03030000000000','Consulta comprobantes','','DO FORM consultacomprobantes WITH 0,0,0','','S','S','S','06','admin','2018041411:50:36',1,''),
 (53,4,'H','02070000000000','Tipo de Movimientos','','DO FORM ottiposmovi','','S','S','S','07','admin','2018041412:08:16',1,''),
 (54,4,'H','02080000000000','Lineas de Materiales','','DO FORM otlineasmat','','S','S','S','07','admin','2018041412:08:25',1,''),
 (56,4,'H','02100000000000','Etapas','','DO FORM otetapas','','S','S','S','07','admin','2018041412:08:46',1,''),
 (57,1,'H','01160000000000','Bancos','','DO FORM bancos','','S','S','S','01','admin','2018041412:10:13',1,''),
 (58,1,'H','01170000000000','Tarjetas','','DO FORM tarjetas','','S','S','S','01','admin','2018041412:11:17',1,''),
 (59,10,'H','03020000000000','Recibo','','DO FORM recibos WITH 0,0,0,0','','S','S','S','06','admin','2018041412:13:08',1,''),
 (60,4,'H','02110000000000','Estados de OT','','DO FORM otestados','','S','S','S','07','admin','2018042018:24:22',1,''),
 (61,4,'H','02120000000000','Consulta Movimientos de Stock','','DO FORM otconsultamovistock with \"0\",\"0\",\"0\"','','S','S','S','07','admin','2018060817:42:14',1,''),
 (62,4,'H','02130000000000','Listado de Stock','','DO FORM OTLISTADOSTOCK','','S','S','S','07','admin','2018051118:43:40',1,''),
 (63,4,'H','02140000000000','Informes','','DO FORM otinformesot','','S','S','S','07','admin','2018052319:46:02',1,''),
 (64,14,'H','04020000000000','Configurar Barra Menú','','DO FORM settoolmenu','','S','S','S','05','TULIO','2018060616:39:11',1,'CONFIG1.PNG'),
 (65,14,'H','04030000000000','Salir                               Alt+F4','','SALIRMENU()','','S','S','S','05','TULIO','2018060712:41:13',1,'CERRAR1.PNG'),
 (66,4,'H','02150000000000','Equivalencias de código de materiales','','do form otmaterialesequi with \"\"','','S','S','S','07','admin','2018061217:21:01',1,''),
 (67,4,'H','02160000000000','Tipos de Observaciones','','DO FORM ottiposobsabm','','S','S','S','07','admin','2018070219:31:54',1,'');
/*!40000 ALTER TABLE `menusql` ENABLE KEYS */;


--
-- Definition of table `monedas`
--

DROP TABLE IF EXISTS `monedas`;
CREATE TABLE `monedas` (
  `moneda` int(10) unsigned NOT NULL,
  `nombre` char(200) NOT NULL,
  `cotizacion` float(13,4) NOT NULL,
  `simbolo` char(10) NOT NULL,
  `fechacot` char(8) NOT NULL,
  PRIMARY KEY (`moneda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `monedas`
--

/*!40000 ALTER TABLE `monedas` DISABLE KEYS */;
INSERT INTO `monedas` (`moneda`,`nombre`,`cotizacion`,`simbolo`,`fechacot`) VALUES 
 (1,'PESO',1.0000,'$','20160101'),
 (2,'DOLAR',13.5000,'$$','20160101'),
 (3,'EURO',25.0000,'$e$','20160101');
/*!40000 ALTER TABLE `monedas` ENABLE KEYS */;


--
-- Definition of table `movidepo`
--

DROP TABLE IF EXISTS `movidepo`;
CREATE TABLE `movidepo` (
  `deposito` int(10) unsigned NOT NULL,
  `operacion` int(10) unsigned NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `movidepo`
--

/*!40000 ALTER TABLE `movidepo` DISABLE KEYS */;
/*!40000 ALTER TABLE `movidepo` ENABLE KEYS */;


--
-- Definition of table `np`
--

DROP TABLE IF EXISTS `np`;
CREATE TABLE `np` (
  `idnp` int(10) unsigned NOT NULL,
  `puntov` char(4) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `hora` char(8) NOT NULL,
  `usuario` char(15) NOT NULL,
  `vendedor` int(10) unsigned NOT NULL,
  `transporte` int(10) unsigned NOT NULL,
  `nombretran` char(254) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `nombre` char(254) NOT NULL,
  `observa` char(254) NOT NULL,
  `sector` int(10) unsigned NOT NULL,
  `idtiponp` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idnp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `np`
--

/*!40000 ALTER TABLE `np` DISABLE KEYS */;
/*!40000 ALTER TABLE `np` ENABLE KEYS */;


--
-- Definition of table `ot`
--

DROP TABLE IF EXISTS `ot`;
CREATE TABLE `ot` (
  `idnp` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `idtipoot` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `unidad` char(50) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `anulada` char(1) NOT NULL,
  `observa` char(254) NOT NULL,
  `fechaentre` char(8) NOT NULL,
  `cantidadfc` float(13,4) NOT NULL,
  `unidadfc` char(50) NOT NULL,
  PRIMARY KEY (`idot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ot`
--

/*!40000 ALTER TABLE `ot` DISABLE KEYS */;
/*!40000 ALTER TABLE `ot` ENABLE KEYS */;


--
-- Definition of table `otajuste`
--

DROP TABLE IF EXISTS `otajuste`;
CREATE TABLE `otajuste` (
  `idot` int(10) unsigned NOT NULL,
  `idmovih` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otajuste`
--

/*!40000 ALTER TABLE `otajuste` DISABLE KEYS */;
/*!40000 ALTER TABLE `otajuste` ENABLE KEYS */;


--
-- Definition of table `otcancela`
--

DROP TABLE IF EXISTS `otcancela`;
CREATE TABLE `otcancela` (
  `idot` int(10) unsigned NOT NULL,
  `fechabaja` char(8) NOT NULL,
  `observa` char(200) NOT NULL,
  PRIMARY KEY (`idot`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otcancela`
--

/*!40000 ALTER TABLE `otcancela` DISABLE KEYS */;
/*!40000 ALTER TABLE `otcancela` ENABLE KEYS */;


--
-- Definition of table `otcumpleh`
--

DROP TABLE IF EXISTS `otcumpleh`;
CREATE TABLE `otcumpleh` (
  `idotcumple` int(10) unsigned NOT NULL,
  `idotcumpleh` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `cantidaduf` float(13,4) NOT NULL,
  `lote` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idotcumple`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otcumpleh`
--

/*!40000 ALTER TABLE `otcumpleh` DISABLE KEYS */;
/*!40000 ALTER TABLE `otcumpleh` ENABLE KEYS */;


--
-- Definition of table `otcumplep`
--

DROP TABLE IF EXISTS `otcumplep`;
CREATE TABLE `otcumplep` (
  `idotcumple` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `hora` char(8) NOT NULL,
  `lote` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `cantidaduf` float(13,4) NOT NULL,
  PRIMARY KEY (`idotcumple`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otcumplep`
--

/*!40000 ALTER TABLE `otcumplep` DISABLE KEYS */;
/*!40000 ALTER TABLE `otcumplep` ENABLE KEYS */;


--
-- Definition of table `otdepositos`
--

DROP TABLE IF EXISTS `otdepositos`;
CREATE TABLE `otdepositos` (
  `iddepo` int(10) unsigned NOT NULL,
  `detalle` char(50) NOT NULL,
  PRIMARY KEY (`iddepo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otdepositos`
--

/*!40000 ALTER TABLE `otdepositos` DISABLE KEYS */;
INSERT INTO `otdepositos` (`iddepo`,`detalle`) VALUES 
 (1,'DEPOSITO GENERAL ENTREPISO'),
 (2,'DEPOSITO 2');
/*!40000 ALTER TABLE `otdepositos` ENABLE KEYS */;


--
-- Definition of table `otdetaot`
--

DROP TABLE IF EXISTS `otdetaot`;
CREATE TABLE `otdetaot` (
  `idot` int(10) unsigned NOT NULL,
  `idotdet` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `codigomat` char(20) NOT NULL,
  `descrip` char(200) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  `impuni` float(13,2) NOT NULL,
  `imptotal` float(13,2) NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `fechai` char(8) NOT NULL,
  `horai` char(8) NOT NULL,
  `fechaf` char(8) NOT NULL,
  `horaf` char(8) NOT NULL,
  `tiemest` char(20) NOT NULL DEFAULT '',
  `unidad` char(10) NOT NULL,
  `cantm2` float(13,2) NOT NULL,
  `observa` char(200) NOT NULL,
  `idmoneda` int(10) unsigned NOT NULL,
  `moneda` char(50) NOT NULL,
  `cotizacion` float(13,2) NOT NULL,
  `fechacot` char(8) NOT NULL,
  PRIMARY KEY (`idotdet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otdetaot`
--

/*!40000 ALTER TABLE `otdetaot` DISABLE KEYS */;
INSERT INTO `otdetaot` (`idot`,`idotdet`,`fecha`,`codigomat`,`descrip`,`cantidad`,`impuni`,`imptotal`,`idmate`,`fechai`,`horai`,`fechaf`,`horaf`,`tiemest`,`unidad`,`cantm2`,`observa`,`idmoneda`,`moneda`,`cotizacion`,`fechacot`) VALUES 
 (2,1,'20180613','5040','ADHESIVO CORIAN 50 ML',100.00,280.00,28000.00,549,'20180613','00:00:00','20180613','00:00:00','01:00:00','UND.',0.00,'',1,'PESO',1.00,'20160101'),
 (1,2,'20180618','5040','ADHESIVO CORIAN 50 ML',10.00,280.00,2800.00,549,'20180618','00:00:00','20180618','00:00:00','01:00:00','UND.',0.00,'sdasd',1,'PESO',1.00,'20160101'),
 (10,3,'20180625','5071','PORTA COPAS REDONDO',10.00,0.00,0.00,580,'20180625','00:00:00','20180625','00:00:00','01:00:00','UND.',1.00,'',1,'PESO',1.00,'20160101'),
 (10,4,'20180619','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',10.00,42.00,420.00,451,'20180619','00:00:00','20180619','00:00:00','01:00:00','UND.',10.00,'',1,'PESO',1.00,'20160101'),
 (10,5,'20180619','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',100.00,42.00,4200.00,451,'20180619','00:00:00','20180619','00:00:00','01:00:00','UND.',10.00,'',1,'PESO',1.00,'20160101'),
 (10,6,'20180619','7011','MONTANTE 35 MM',100.00,0.00,0.00,853,'20180619','00:00:00','20180619','00:00:00','01:00:00','UNID.',10.00,'',1,'PESO',1.00,'20160101'),
 (10,7,'20180625','3000','ANGULO DE TERM. ALUMINIO 12X12',50.00,2.00,100.00,202,'20180625','00:00:00','20180625','00:00:00','01:00:00','UND.',0.00,'',1,'PESO',1.00,'20160101'),
 (3,8,'20180703','5040','ADHESIVO CORIAN 50 ML',100.00,280.00,2800.00,549,'20180703','00:00:00','20180703','00:00:00','01:00:00','UND.',10.00,'',1,'PESO',1.00,'20160101'),
 (4,9,'20180703','3000','ANGULO DE TERM. ALUMINIO 12X12',10.00,2.00,20.00,202,'20180703','00:00:00','20180703','00:00:00','01:00:00','UND.',0.00,'',1,'PESO',1.00,'20160101'),
 (5,10,'20180703','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',10.00,1785.00,17850.00,13,'20180703','00:00:00','20180703','00:00:00','01:00:00','PLACA',0.00,'',1,'PESO',1.00,'20160101'),
 (7,11,'20180703','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1.00,1785.00,1785.00,13,'20180703','00:00:00','20180703','00:00:00','01:00:00','PLACA',0.00,'',1,'PESO',1.00,'20160101'),
 (1,12,'20180724','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',5.00,42.00,420.00,451,'20180724','00:00:00','20180724','00:00:00','01:00:00','UND.',10.00,'',1,'PESO',1.00,'20160101');
/*!40000 ALTER TABLE `otdetaot` ENABLE KEYS */;


--
-- Definition of table `otdocumento`
--

DROP TABLE IF EXISTS `otdocumento`;
CREATE TABLE `otdocumento` (
  `idregistro` int(10) unsigned NOT NULL,
  `tipodoc` char(2) NOT NULL,
  `iddocu` int(10) unsigned NOT NULL,
  `camino` char(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otdocumento`
--

/*!40000 ALTER TABLE `otdocumento` DISABLE KEYS */;
/*!40000 ALTER TABLE `otdocumento` ENABLE KEYS */;


--
-- Definition of table `otdocumentos`
--

DROP TABLE IF EXISTS `otdocumentos`;
CREATE TABLE `otdocumentos` (
  `idot` int(10) unsigned NOT NULL,
  `iddocu` int(10) unsigned NOT NULL,
  `camino` char(200) NOT NULL,
  `archivo` char(100) NOT NULL,
  `original` char(100) NOT NULL,
  `tipodoc` char(10) NOT NULL,
  `fecha` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otdocumentos`
--

/*!40000 ALTER TABLE `otdocumentos` DISABLE KEYS */;
INSERT INTO `otdocumentos` (`idot`,`iddocu`,`camino`,`archivo`,`original`,`tipodoc`,`fecha`) VALUES 
 (1,1,'/Documentos/ot/P1_O1_D1.pdf','P1_O1_D1.pdf','asientos2013.pdf','OT','20140826'),
 (1,2,'/Documentos/ot/P1_O1_D2.jpg','P1_O1_D2.jpg','pool 4.jpg','OT','20160830'),
 (3,3,'C:/PROYECTOS/TRITCO/Documentos/OT/0000003-ROSSI_TULIO','3_stock-de-insumos.xlsx','STOCK DE INSUMOS.XLSX','OT','20180312'),
 (3,4,'C:/PROYECTOS/TRITCO/Documentos/OT/0000003-ROSSI_TULIO','3_mi-tesis.pptx','MI TESIS.PPTX','OT','20180312'),
 (3,5,'C:/PROYECTOS/TRITCO/Documentos/OT/0000003-ROSSI_TULIO','3_tp-adminfinancier.jpeg','TP-ADMINFINANCIER.JPEG','OT','20180312'),
 (4,6,'C:/PROYECTOS/TRITCO/Documentos/OT/0000004-ALSAFEX_S.A._-_Racca_Gaston_Ramon_Alberto','4_stock-de-insumos.xlsx','STOCK DE INSUMOS.XLSX','OT','20180313'),
 (8,15,'C:GitHubProyectoProcessarArchivosDocumentosOT8','15_ARCHIVO PRUEBA.TXT','C:USERSPABLODESKTOPARCHIVO PRUEBA.TXT','OT','20180519'),
 (8,18,'C:GitHubProyectoProcessarArchivosDocumentosOT8','18_ARCHIVO PRUEBA  2.TXT','C:USERSPABLODESKTOPARCHIVO PRUEBA  2.TXT','OT','20180519'),
 (2,19,'documentos\\ot\\2\\','19_VISTA.TXT','C:\\USERS\\PABLO\\DESKTOP\\VISTA.TXT','OT','20180706'),
 (2,20,'documentos\\ot\\2\\','20_PRUEBA.TXT','C:\\USERS\\PABLO\\DOCUMENTS\\PRUEBAS\\PRUEBA.TXT','OT','20180706'),
 (2,21,'documentos\\ot\\2\\','21_PRUEBA3.TXT','C:\\USERS\\PABLO\\DOCUMENTS\\PRUEBAS\\PRUEBA3.TXT','OT','20180706'),
 (2,22,'documentos\\ot\\2\\','22_PRUEBA3.TXT','C:\\USERS\\PABLO\\DOCUMENTS\\PRUEBAS\\PRUEBA3.TXT','OT','20180706'),
 (9,23,'documentos\\ot\\9\\','23_PRUEBA.TXT','C:\\USERS\\PABLO\\DOCUMENTS\\PRUEBAS\\PRUEBA.TXT','OT','20180706'),
 (9,25,'documentos\\ot\\9\\','25_PRUEBA 2.TXT','C:\\USERS\\PABLO\\DOCUMENTS\\PRUEBAS\\PRUEBA 2.TXT','OT','20180706');
/*!40000 ALTER TABLE `otdocumentos` ENABLE KEYS */;


--
-- Definition of table `otejecu`
--

DROP TABLE IF EXISTS `otejecu`;
CREATE TABLE `otejecu` (
  `idpedido` int(10) unsigned NOT NULL DEFAULT '0',
  `idot` int(10) unsigned NOT NULL,
  `idoteje` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `codigomat` char(20) NOT NULL,
  `descrip` char(200) NOT NULL,
  `cantidad` float(13,3) NOT NULL,
  `impuni` float(13,3) NOT NULL,
  `imptotal` float(13,3) NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `fechai` char(8) NOT NULL,
  `horai` char(8) NOT NULL,
  `fechaf` char(8) NOT NULL,
  `horaf` char(8) NOT NULL,
  `tiempo` char(8) NOT NULL,
  `unidad` char(20) NOT NULL,
  `cantm2` float(13,3) NOT NULL,
  `descustock` char(1) NOT NULL,
  `iddepo` int(10) unsigned NOT NULL DEFAULT '0',
  `idmoneda` int(10) unsigned NOT NULL DEFAULT '0',
  `moneda` char(50) NOT NULL DEFAULT '',
  `cotizacion` float(13,2) NOT NULL DEFAULT '0.00',
  `fechacot` char(8) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otejecu`
--

/*!40000 ALTER TABLE `otejecu` DISABLE KEYS */;
INSERT INTO `otejecu` (`idpedido`,`idot`,`idoteje`,`fecha`,`codigomat`,`descrip`,`cantidad`,`impuni`,`imptotal`,`idmate`,`fechai`,`horai`,`fechaf`,`horaf`,`tiempo`,`unidad`,`cantm2`,`descustock`,`iddepo`,`idmoneda`,`moneda`,`cotizacion`,`fechacot`) VALUES 
 (1,1,3,'20140827','D1001','MELAMINA SOBRE MDF 18 MM BLANCO FAPLAC',1.000,453.690,453.690,2,'','','','','','PLACA',0.000,'N',1,1,'PESO',1.00,'20140101');
/*!40000 ALTER TABLE `otejecu` ENABLE KEYS */;


--
-- Definition of table `otejecuh`
--

DROP TABLE IF EXISTS `otejecuh`;
CREATE TABLE `otejecuh` (
  `idot` int(10) unsigned NOT NULL,
  `idotejeh` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `fechai` char(8) NOT NULL,
  `horai` char(8) NOT NULL,
  `fechaf` char(8) NOT NULL,
  `horaf` char(8) NOT NULL,
  `tiempoest` char(20) NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  `descmov` char(200) NOT NULL,
  `idempleado` int(10) unsigned NOT NULL,
  `nombre` char(200) NOT NULL,
  `idetapa` int(10) unsigned NOT NULL,
  `observa` char(200) NOT NULL,
  PRIMARY KEY (`idotejeh`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otejecuh`
--

/*!40000 ALTER TABLE `otejecuh` DISABLE KEYS */;
INSERT INTO `otejecuh` (`idot`,`idotejeh`,`fecha`,`fechai`,`horai`,`fechaf`,`horaf`,`tiempoest`,`idtipomov`,`descmov`,`idempleado`,`nombre`,`idetapa`,`observa`) VALUES 
 (2,1,'20180219','20180212','00:00:00','20180213','00:00:00','01d-00:00:00',1,'INGRESO POR FACT PROV',1,'Federico Carrión',0,''),
 (1,2,'20180216','20180216','08:00:00','20180217','08:00:00','01d-00:00:00',1,'INGRESO POR FACT PROV',1,'Federico Carrión',0,''),
 (3,3,'20180223','20180219','09:00:00','20180222','09:00:00','03d-00:00:00',1,'INGRESO POR FACT PROV',1,'Federico Carrión',0,''),
 (1,4,'20180309','20180309','10:00:00','20180309','12:00:00','',0,'',1,'Federico Carrión',1,''),
 (1,5,'20180309','20180309','08:00:00','20180309','13:00:00','',0,'',1,'Federico Carrión',2,''),
 (1,6,'20180309','20180309','08:00:00','20180309','12:00:00','',0,'',1,'Federico Carrión',1,''),
 (1,7,'20180309','20180309','16:00:00','20180309','18:00:00','',0,'',1,'Federico Carrión',3,''),
 (5,8,'20180309','20180309','08:00:00','20180309','10:00:00','',0,'',1,'Federico Carrión',1,''),
 (5,9,'20180309','20180309','10:00:00','20180309','11:00:00','',0,'',1,'Federico Carrión',2,''),
 (4,10,'20180313','20180313','08:00:00','20180313','10:00:00','',0,'',1,'Federico Carrión',2,''),
 (5,11,'20180313','20180313','10:00:00','20180313','11:30:00','',0,'',1,'Federico Carrión',5,''),
 (2,12,'20180421','20180421','2 : 0:0','20180421','3 :0 :','',0,'',1,'Federico Carrión',1,'hbug'),
 (8,13,'20180422','20180422','08:00:00','20180422','10:00:00','',0,'',1,'Federico Carrión',1,''),
 (2,14,'20180515','20180515','17:00:00','20180515','18:00:00','',0,'',1,'Federico Carrión',1,'sdad'),
 (1,15,'20180515','20180515','10:00:00','20180515','15:00:00','',0,'',1,'Federico Carrión',2,'sdad'),
 (7,16,'20180517','20180517','12:00:00','20180517','15:00:00','',0,'',1,'Federico Carrión',2,'weqeq'),
 (6,17,'20180517','20180517','10:00:00','20180517','11:00:00','',0,'',1,'Federico Carrión',1,'weqeq'),
 (7,18,'20180517','20180517','13:00:00','20180517','16:00:00','',0,'',1,'Federico Carrión',2,'weqeq'),
 (13,19,'20180606','20180606','08:00:00','20180606','10:00:00','',0,'',1,'Federico Carrión',1,''),
 (13,20,'20180606','20180606','10:00:00','20180606','12:00:00','',0,'',1,'Federico Carrión',1,''),
 (13,21,'20180606','20180606','11:00:00','20180606','13:00:00','',0,'',1,'Federico Carrión',1,''),
 (14,22,'20180606','20180606','10:00:00','20180606','12:00:00','',0,'',1,'Federico Carrión',1,''),
 (14,23,'20180606','20180606','18:00:00','20180606','20:00:00','',0,'',1,'Federico Carrión',1,''),
 (14,24,'20180606','20180606','22:00:00','20180606','23:00:00','',0,'',1,'Federico Carrión',1,''),
 (14,25,'20180608','20180608','10:00:00','20180608','12:00:00','',0,'',1,'Federico Carrión',2,''),
 (14,26,'20180608','20180608','14:00:00','20180608','18:00:00','',0,'',1,'Federico Carrión',2,''),
 (10,27,'20180627','20180627','10:00:00','20180627','11:00:00','',0,'',1,'Federico Carrión',1,''),
 (10,28,'20180627','20180627','12:00:00','20180627','14:00:00','',0,'',1,'Federico Carrión',1,'obs'),
 (10,29,'20180629','20180629','10:00:00','20180629','11:00:00','',0,'',1,'Federico Carrión',2,''),
 (10,30,'20180629','20180629','12:00:00','20180629','13:00:00','',0,'',1,'Federico Carrión',2,''),
 (10,31,'20180629','20180629','13:00:00','20180629','14:00:00','',0,'',1,'Federico Carrión',1,''),
 (10,32,'20180629','20180629','11:00:00','20180629','12:00:00','',0,'',1,'Federico Carrión',2,''),
 (10,33,'20180629','20180629','10:00:00','20180629','10:00:00','',0,'',1,'Federico Carrión',2,''),
 (10,34,'20180629','20180629','11:00:00','20180629','12:00:00','',0,'',1,'Federico Carrión',6,''),
 (10,35,'20180629','20180629','15:00:00','20180629','16:00:00','',0,'',1,'Federico Carrión',4,''),
 (10,36,'20180629','20180629','10:00:00','20180629','11:00:00','',0,'',1,'Federico Carrión',6,''),
 (10,37,'20180629','20180629','12:00:00','20180629','13:00:00','',0,'',1,'Federico Carrión',3,''),
 (10,39,'20180629','20180629','15:00:00','20180629','15:30:00','',0,'',1,'Federico Carrión',1,''),
 (10,40,'20180702','20180702','10:00:00','20180702','11:00:00','',0,'',1,'Federico Carrión',7,'VARIOS4'),
 (10,41,'20180702','20180702','12:00:00','20180702','13:00:00','',0,'',1,'Federico Carrión',7,'MATERIAL NO PRESUPUESTADO'),
 (10,42,'20180702','20180702','14:00:00','20180702','15:00:00','',0,'',1,'Federico Carrión',7,'obs'),
 (10,43,'20180706','20180706','00:00:00','20180706','00:00:00','',0,'',1,'Federico Carrión',8,'');
/*!40000 ALTER TABLE `otejecuh` ENABLE KEYS */;


--
-- Definition of table `otejecum`
--

DROP TABLE IF EXISTS `otejecum`;
CREATE TABLE `otejecum` (
  `idot` int(10) unsigned NOT NULL,
  `idotejem` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `codigomat` char(20) NOT NULL,
  `descrip` char(200) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  `impuni` float(13,2) NOT NULL,
  `imptotal` float(13,2) NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `unidad` char(50) DEFAULT NULL,
  `cantm2` float(13,2) NOT NULL,
  `iddepo` int(10) unsigned NOT NULL,
  `idmoneda` int(10) unsigned NOT NULL,
  `moneda` char(200) NOT NULL,
  `cotizacion` float(13,2) NOT NULL,
  `fechacot` char(8) NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  `descmov` char(200) NOT NULL,
  `idetapa` int(10) unsigned NOT NULL,
  `observa` char(200) NOT NULL,
  PRIMARY KEY (`idotejem`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otejecum`
--

/*!40000 ALTER TABLE `otejecum` DISABLE KEYS */;
INSERT INTO `otejecum` (`idot`,`idotejem`,`fecha`,`codigomat`,`descrip`,`cantidad`,`impuni`,`imptotal`,`idmate`,`unidad`,`cantm2`,`iddepo`,`idmoneda`,`moneda`,`cotizacion`,`fechacot`,`idtipomov`,`descmov`,`idetapa`,`observa`) VALUES 
 (2,1,'20180310','3066','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 1.50 MTS',1.00,1247.00,1247.00,268,'UND.',0.00,1,1,'PESO',1.00,'20140101',2,'EGRESO POR PRODUCCION',4,''),
 (8,2,'20180409','3008','BISAGRA COMUN 35 MM CODO 9',7.00,7.00,49.00,210,'UND.',0.00,1,1,'PESO',1.00,'20140101',2,'EGRESO POR PRODUCCION',5,''),
 (1,3,'20180408','3008','BISAGRA COMUN 35 MM CODO 9',20.00,7.00,140.00,210,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,4,'20180408','3008','BISAGRA COMUN 35 MM CODO 9',2.00,7.00,14.00,210,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,5,'20180408','3043','CORREDERA TELESCOPICA 500 MM',3.00,72.00,216.00,245,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,6,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',35.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,7,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',5.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,8,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',5.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,9,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',5.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,10,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',5.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,11,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',5.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,12,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',2.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (1,13,'20180408','3182','TARUGO DE MADERA 8 X 30 MM',20.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (1,14,'20180408','2013','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM VENEZIA',50.00,5.00,250.00,649,'MTS',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (1,15,'20180408','2025','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BLANCO',20.00,1.00,20.00,661,'MTS',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (2,16,'20180310','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2.00,1785.00,3570.00,13,'PLACA',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,''),
 (2,17,'20180310','3066','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 1.50 MTS',1.00,1247.00,1247.00,268,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,''),
 (3,18,'20180409','3008','BISAGRA COMUN 35 MM CODO 9',10.00,7.00,70.00,210,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,''),
 (3,19,'20180409','3043','CORREDERA TELESCOPICA 500 MM',4.00,72.00,288.00,245,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,''),
 (3,20,'20180409','3008','BISAGRA COMUN 35 MM CODO 9',4.00,7.00,28.00,210,'UND.',5.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,''),
 (3,21,'20180409','3086','MANIJA BARRAL RECTO 128 MM',5.00,43.00,215.00,288,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (3,22,'20180409','3182','TARUGO DE MADERA 8 X 30 MM',100.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (3,23,'20180409','3086','MANIJA BARRAL RECTO 128 MM',10.00,43.00,430.00,288,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (3,24,'20180409','3182','TARUGO DE MADERA 8 X 30 MM',5.00,0.00,0.00,383,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (3,25,'20180409','2025','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BLANCO',1.00,1.00,1.00,661,'MTS',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (8,26,'20180409','101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',4.00,1747.00,6988.00,14,'PLACA',4.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,'ADASD'),
 (8,27,'20180409','3008','BISAGRA COMUN 35 MM CODO 9',7.00,7.00,49.00,210,'UND.',7.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,'ASDASD'),
 (8,28,'20180409','3043','CORREDERA TELESCOPICA 500 MM',4.00,72.00,288.00,245,'UND.',4.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,'jjoij'),
 (8,29,'20180409','3086','MANIJA BARRAL RECTO 128 MM',10.00,45.00,450.00,288,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,'kjoj'),
 (8,30,'20180409','3086','MANIJA BARRAL RECTO 128 MM',5.00,45.00,225.00,288,'UND.',5.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,'jjoij'),
 (8,31,'20180409','3182','TARUGO DE MADERA 8 X 30 MM',8.00,0.00,0.00,383,'UND.',8.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,'lkjojo'),
 (9,32,'20180515','3008','BISAGRA COMUN 35 MM CODO 9',4.00,7.00,28.00,210,'UND.',4.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,'asasd'),
 (9,33,'20180515','3043','CORREDERA TELESCOPICA 500 MM',4.00,72.00,288.00,245,'UND.',4.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,'asdsa'),
 (9,34,'20180515','3086','MANIJA BARRAL RECTO 128 MM',10.00,45.00,450.00,288,'UND.',10.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,'asdasd'),
 (12,35,'20180521','5040','ADHESIVO CORIAN 50 ML',5.00,280.00,1400.00,549,'UND.',5.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'asdsad'),
 (12,36,'20180521','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2.00,1785.00,3570.00,13,'PLACA',2.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'ads'),
 (12,37,'20180521','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',3.00,1785.00,5355.00,13,'PLACA',3.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'adsd'),
 (12,38,'20180521','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1.00,1785.00,1785.00,13,'PLACA',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,''),
 (12,39,'20180521','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1.00,1785.00,1785.00,13,'PLACA',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'asda'),
 (12,40,'20180521','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1.00,1785.00,1785.00,13,'PLACA',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'adsad'),
 (12,41,'20180521','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1.00,1785.00,1785.00,13,'PLACA',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',2,'5465'),
 (13,42,'20180606','5040','ADHESIVO CORIAN 50 ML',5.00,280.00,1400.00,549,'UND.',5.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'uso 5 de corian'),
 (13,43,'20180606','3001','BASE PLASTICA',2.00,0.00,0.00,203,'UND.',2.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'uso 2 de base'),
 (13,44,'20180606','3001','BASE PLASTICA',5.00,0.00,0.00,203,'UND.',5.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',2,''),
 (14,45,'20180606','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2.00,1785.00,3570.00,13,'PLACA',2.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,''),
 (14,46,'20180606','10001','FILM STRECH BANDITA 10 CM',5.00,31.00,155.00,635,'UND.',5.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,''),
 (2,47,'20180618','5040','ADHESIVO CORIAN 50 ML',100.00,280.00,28000.00,549,'UND.',10.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'kijoi'),
 (2,48,'20180618','3311','AVENTO BLUM HF',10.00,0.00,0.00,0,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',2,''),
 (2,49,'20180618','3311','AVENTO BLUM HF',10.00,0.00,0.00,0,'UND.',10.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'obs'),
 (2,50,'20180618','5029','ARANDELA PLANA 22 X 8.5 X 2 MM',2.00,0.00,0.00,0,'UND.',2.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'sad'),
 (1,51,'20180618','5040','ADHESIVO CORIAN 50 ML',12.00,280.00,3360.00,549,'UND.',12.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'dasd'),
 (1,52,'20180619','5040','ADHESIVO CORIAN 50 ML',2.00,280.00,560.00,549,'UND.',2.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',2,''),
 (2,53,'20180619','5040','ADHESIVO CORIAN 50 ML',10.00,280.00,2800.00,549,'UND.',10.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'asdad'),
 (10,55,'20180619','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',1.00,42.00,42.00,451,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,''),
 (10,56,'20180622','3227','BISAGRA COM‚N 35 MM CODO 18',10.00,0.00,0.00,0,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,'kokp'),
 (10,58,'20180622','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2.00,42.00,84.00,451,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,'13213'),
 (10,66,'20180625','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2.00,42.00,84.00,451,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,68,'20180625','5029','ARANDELA PLANA 22 X 8.5 X 2 MM',5.00,0.00,0.00,0,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'asdasd'),
 (10,69,'20180625','3308','CANASTO 2 NIV. EXTRAIBLE 450MM CROMADO',1.00,0.00,0.00,0,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'dsfs'),
 (10,70,'20180625','3000','ANGULO DE TERM. ALUMINIO 12X12',10.00,2.00,20.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,72,'20180625','5071','PORTA COPAS REDONDO',1.00,0.00,0.00,580,'UND.',10.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,74,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',5.00,2.00,10.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,75,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,76,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',2.00,2.00,4.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,77,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,78,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,79,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',5.00,2.00,10.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,80,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',5.00,2.00,10.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,81,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,82,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,83,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',2.00,2.00,4.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,84,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,85,'20180628','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,86,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',2.00,2.00,4.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,87,'20180629','7011','MONTANTE 35 MM',1.00,0.00,2.00,853,'UNID.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,88,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',2.00,2.00,4.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,''),
 (10,89,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,''),
 (10,90,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',2.00,2.00,4.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (10,91,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (10,92,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,''),
 (10,93,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',6,''),
 (10,94,'20180629','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',1.00,42.00,42.00,451,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,''),
 (10,95,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',4,''),
 (10,98,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',5,''),
 (10,99,'20180629','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',7,''),
 (10,100,'20180629','3237','CORREDERA TELESC…PICA 350 MM PUSCH',10.00,0.00,0.00,0,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',3,'asdasd'),
 (10,101,'20180702','3000','ANGULO DE TERM. ALUMINIO 12X12',1.00,2.00,2.00,202,'UND.',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'VARIOS4'),
 (10,102,'20180702','3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',1.00,42.00,42.00,451,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'VARIOS'),
 (10,103,'20180702','5071','PORTA COPAS REDONDO',1.00,0.00,0.00,580,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'MATERIAL NO PRESUPUESTADO'),
 (10,104,'20180702','7011','MONTANTE 35 MM',1.00,0.00,0.00,853,'UNID.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',8,'MATERIAL NO PRESUPUESTADO'),
 (3,105,'20180703','5040','ADHESIVO CORIAN 50 ML',10.00,280.00,2800.00,549,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'MATERIAL NO PRESUPUESTADO'),
 (3,106,'20180703','5040','ADHESIVO CORIAN 50 ML',10.00,280.00,2800.00,549,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'VARIOS4'),
 (4,107,'20180703','3000','ANGULO DE TERM. ALUMINIO 12X12',2.00,2.00,4.00,202,'UND.',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'VARIOS4'),
 (5,108,'20180703','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1.00,1785.00,1785.00,13,'PLACA',1.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,''),
 (7,109,'20180703','100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1.00,1785.00,1785.00,13,'PLACA',0.00,1,1,'PESO',1.00,'20160101',2,'EGRESO POR PRODUCCION',1,'');
/*!40000 ALTER TABLE `otejecum` ENABLE KEYS */;


--
-- Definition of table `otejecumovi`
--

DROP TABLE IF EXISTS `otejecumovi`;
CREATE TABLE `otejecumovi` (
  `idotejem` int(10) unsigned NOT NULL,
  `idmovih` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otejecumovi`
--

/*!40000 ALTER TABLE `otejecumovi` DISABLE KEYS */;
INSERT INTO `otejecumovi` (`idotejem`,`idmovih`) VALUES 
 (2,12),
 (3,13),
 (4,39),
 (5,40),
 (6,41),
 (7,42),
 (8,43),
 (9,44),
 (10,45),
 (11,46),
 (12,47),
 (12,48),
 (12,49),
 (12,50),
 (12,51),
 (13,52),
 (14,53),
 (15,54),
 (16,55),
 (17,56),
 (1,57),
 (2,58),
 (3,59),
 (3,60),
 (4,61),
 (5,62),
 (6,63),
 (7,64),
 (8,65),
 (9,66),
 (10,67),
 (11,68),
 (12,69),
 (13,70),
 (14,71),
 (15,72),
 (16,77),
 (17,78),
 (18,79),
 (19,80),
 (20,81),
 (21,82),
 (22,83),
 (23,84),
 (24,85),
 (25,86),
 (26,107),
 (27,108),
 (28,109),
 (29,110),
 (30,111),
 (31,112),
 (32,113),
 (33,114),
 (34,115),
 (35,116),
 (36,117),
 (37,118),
 (38,119),
 (39,120),
 (40,121),
 (41,122),
 (42,126),
 (43,127),
 (44,128),
 (45,129),
 (46,130),
 (47,132),
 (48,133),
 (49,134),
 (50,135),
 (51,136),
 (52,137),
 (53,138),
 (54,139),
 (55,140),
 (56,141),
 (57,142),
 (58,143),
 (60,145),
 (63,148),
 (64,149),
 (66,151),
 (68,153),
 (69,154),
 (70,155),
 (72,157),
 (74,159),
 (75,160),
 (76,161),
 (77,162),
 (78,163),
 (79,164),
 (80,165),
 (81,166),
 (82,167),
 (83,168),
 (84,169),
 (85,170),
 (86,171),
 (87,172),
 (88,173),
 (89,174),
 (90,175),
 (91,176),
 (92,177),
 (93,178),
 (94,179),
 (95,180),
 (98,183),
 (99,184),
 (100,185),
 (101,186),
 (102,187),
 (103,188),
 (104,189),
 (105,190),
 (106,191),
 (107,192),
 (108,193),
 (109,194);
/*!40000 ALTER TABLE `otejecumovi` ENABLE KEYS */;


--
-- Definition of table `otestados`
--

DROP TABLE IF EXISTS `otestados`;
CREATE TABLE `otestados` (
  `idestado` int(10) unsigned NOT NULL,
  `detalle` char(50) NOT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otestados`
--

/*!40000 ALTER TABLE `otestados` DISABLE KEYS */;
INSERT INTO `otestados` (`idestado`,`detalle`) VALUES 
 (1,'INICIADO'),
 (2,'EN PRODUCCION'),
 (3,'FINALIZADO');
/*!40000 ALTER TABLE `otestados` ENABLE KEYS */;


--
-- Definition of table `otestadosot`
--

DROP TABLE IF EXISTS `otestadosot`;
CREATE TABLE `otestadosot` (
  `idotestadosot` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `idestado` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idotestadosot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otestadosot`
--

/*!40000 ALTER TABLE `otestadosot` DISABLE KEYS */;
INSERT INTO `otestadosot` (`idotestadosot`,`idot`,`idestado`,`fecha`) VALUES 
 (1,3,2,'20180703'),
 (2,4,2,'20180703'),
 (3,5,2,'20180703'),
 (5,27,1,'20180728'),
 (6,28,1,'20180728'),
 (7,29,1,'20180728'),
 (8,30,1,'20180728'),
 (9,31,1,'20180728'),
 (10,32,1,'20180728');
/*!40000 ALTER TABLE `otestadosot` ENABLE KEYS */;


--
-- Definition of table `otetapas`
--

DROP TABLE IF EXISTS `otetapas`;
CREATE TABLE `otetapas` (
  `idetapa` int(11) NOT NULL,
  `etapa` char(200) NOT NULL,
  `coloretapa` int(10) unsigned NOT NULL,
  `idetapasig` int(10) unsigned NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idetapa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otetapas`
--

/*!40000 ALTER TABLE `otetapas` DISABLE KEYS */;
INSERT INTO `otetapas` (`idetapa`,`etapa`,`coloretapa`,`idetapasig`,`idtipomov`) VALUES 
 (1,'PREPARACION DE MATERIALES (STOCK)',12632256,2,2),
 (2,'CORTE Y MECANIZADO',65408,3,2),
 (3,'PEGADO DE CANTOS',8421440,4,2),
 (4,'ARMADO Y CONTROL DE CALIDAD',255,5,2),
 (5,'EMBALAJE',8454143,6,2),
 (6,'CARGA',8404992,7,2),
 (7,'TRANSPORTE Y COLOCACIÓN',16744703,8,2),
 (8,'SERVICIO DE POSVENTA',16776960,8,2);
/*!40000 ALTER TABLE `otetapas` ENABLE KEYS */;


--
-- Definition of table `otint`
--

DROP TABLE IF EXISTS `otint`;
CREATE TABLE `otint` (
  `idotint` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `destinooti` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `cantidad` float(13,3) NOT NULL,
  `cantidaduf` float(13,3) NOT NULL,
  `movotint` int(10) unsigned NOT NULL,
  `idpesadah` int(10) unsigned NOT NULL,
  `otintori` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idotint`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otint`
--

/*!40000 ALTER TABLE `otint` DISABLE KEYS */;
/*!40000 ALTER TABLE `otint` ENABLE KEYS */;


--
-- Definition of table `otinterna`
--

DROP TABLE IF EXISTS `otinterna`;
CREATE TABLE `otinterna` (
  `idotint` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `destinooti` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `cantidaduf` float(13,4) NOT NULL,
  `idmovotint` int(10) unsigned NOT NULL,
  `idotintori` int(10) unsigned NOT NULL,
  `idotcumpleh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idotint`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otinterna`
--

/*!40000 ALTER TABLE `otinterna` DISABLE KEYS */;
/*!40000 ALTER TABLE `otinterna` ENABLE KEYS */;


--
-- Definition of table `otlineasmat`
--

DROP TABLE IF EXISTS `otlineasmat`;
CREATE TABLE `otlineasmat` (
  `linea` char(10) NOT NULL DEFAULT '',
  `detalle` char(50) NOT NULL,
  `codmin` char(20) NOT NULL,
  `codmax` char(20) NOT NULL,
  PRIMARY KEY (`linea`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otlineasmat`
--

/*!40000 ALTER TABLE `otlineasmat` DISABLE KEYS */;
INSERT INTO `otlineasmat` (`linea`,`detalle`,`codmin`,`codmax`) VALUES 
 ('1','PRUEBA','',''),
 ('2','HERRAJES Y ACCESORIOS','',''),
 ('3','BULONERIA','',''),
 ('4','SEGURIDAD','',''),
 ('5','HERRAMIENTAS','',''),
 ('6','BURLETES Y FELPAS','',''),
 ('7','PILETAS','',''),
 ('8','MESADAS','',''),
 ('9','VIDRIOS','',''),
 ('A','PERFILERIA ALUMINIO','',''),
 ('B','COMBUSTIBLES Y LUBRICANTES','',''),
 ('C','SELLADORES , PEGAMENTOS Y ADHESIVOS','',''),
 ('D','MELAMINA','',''),
 ('E','CONSUMIBLES','',''),
 ('F','PACKAGING','',''),
 ('G','PRUEBA2','4000','5000'),
 ('H','PRUEBA3','10000','11000');
/*!40000 ALTER TABLE `otlineasmat` ENABLE KEYS */;


--
-- Definition of table `otmateriales`
--

DROP TABLE IF EXISTS `otmateriales`;
CREATE TABLE `otmateriales` (
  `codigomat` char(20) NOT NULL,
  `detalle` char(200) NOT NULL,
  `unidad` char(10) NOT NULL,
  `impuni` float(13,3) NOT NULL,
  `ctrlstock` char(1) NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `ctacontable` char(20) NOT NULL,
  `linea` char(10) NOT NULL,
  `fbaja` char(8) NOT NULL,
  `observa` char(254) NOT NULL,
  `ocultar` char(1) NOT NULL,
  `idmoneda` int(10) unsigned NOT NULL,
  `moneda` char(50) NOT NULL,
  `stockmin` float(13,3) NOT NULL,
  `idtipomate` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmateriales`
--

/*!40000 ALTER TABLE `otmateriales` DISABLE KEYS */;
INSERT INTO `otmateriales` (`codigomat`,`detalle`,`unidad`,`impuni`,`ctrlstock`,`idmate`,`ctacontable`,`linea`,`fbaja`,`observa`,`ocultar`,`idmoneda`,`moneda`,`stockmin`,`idtipomate`) VALUES 
 ('0070','MELAMINA SOBRE MDF 15MM BLANCO FAPLAC','PLACA',938.000,'S',1,'','1','','','N',1,'PESO',6.000,1),
 ('0089','MELAMINA SOBRE MDF 18MM HAYA MASISA','PLACA',1648.000,'S',2,'','1','','','N',1,'PESO',10.000,1),
 ('0090','MELAMINA SOBRE MDF 18MM CEREJEIRA MASISA','PLACA',1648.000,'S',3,'','1','','','N',1,'PESO',10.000,1),
 ('0091','MELAMINA SOBRE MDF 18MM ROBLE MORO MASISA','PLACA',1444.000,'S',4,'','1','','','N',1,'PESO',10.000,1),
 ('0092','MELAMINA SOBRE MDF 18MM TECA ITALIA TOUCH MASISA','PLACA',1789.000,'S',5,'','1','','','N',1,'PESO',1.000,1),
 ('0093','MELAMINA SOBRE MDF 18MM FRESNO NEGRO MASISA','PLACA',1675.000,'S',6,'','1','','','N',1,'PESO',1.000,1),
 ('0094','MELAMINA SOBRE MDF 18MM WENGUE MASISA','PLACA',1648.000,'S',7,'','1','','','N',1,'PESO',1.000,1),
 ('0095','MELAMINA SOBRE MDF 18MM GUINDO MASISA','PLACA',1648.000,'S',8,'','1','','','N',1,'PESO',1.000,1),
 ('0096','MELAMINA SOBRE MDF 18MM FRESNO ABEDUL MASISA','PLACA',1911.000,'S',9,'','1','','','N',1,'PESO',1.000,1),
 ('0097','MELAMINA SOBRE MDF 18MM TECA MASISA','PLACA',1633.000,'S',10,'','1','','','N',1,'PESO',1.000,1),
 ('0098','MELAMINA SOBRE MDF 18MM VISON MASISA','PLACA',1808.000,'S',11,'','1','','','N',1,'PESO',1.000,1),
 ('0099','MELAMINA SOBRE MDF 18MM NOGAL HABANO MASISA','PLACA',1675.000,'S',12,'','1','','','N',1,'PESO',2.000,1),
 ('0100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA','PLACA',1785.000,'S',13,'','1','','','N',1,'PESO',2.000,1),
 ('0101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA','PLACA',1747.000,'S',14,'','1','','','N',1,'PESO',3.000,1),
 ('0102','MELAMINA SOBRE MDF 18MM TWEED MASISA','PLACA',1808.000,'S',15,'','1','','','N',1,'PESO',10.000,1),
 ('0103','MELAMINA SOBRE MDF 18MM LINO MASISA','PLACA',1808.000,'S',16,'','1','','','N',1,'PESO',10.000,1),
 ('0104','MELAMINA SOBRE MDF 18MM ENIGMA MASISA','PLACA',1893.000,'S',17,'','1','','','N',1,'PESO',4.000,1),
 ('0105','MELAMINA SOBRE MDF 18MM TECA LIMO MASISA','PLACA',1911.000,'S',18,'','1','','','N',1,'PESO',10.000,1),
 ('0106','MELAMINA SOBRE MDF 18MM ROBLE NATURAL MASISA','PLACA',1911.000,'S',19,'','1','','','N',1,'PESO',10.000,1),
 ('0107','MELAMINA SOBRE MDF 18MM ROBLE AMERICANO MASISA','PLACA',1911.000,'S',20,'','1','','','N',1,'PESO',10.000,1),
 ('0108','MELAMINA SOBRE MDF 18MM ROBLE BLANCO MASISA','PLACA',1911.000,'S',21,'','1','','','N',1,'PESO',10.000,1),
 ('0109','MELAMINA SOBRE MDF 18MM MANGO MASISA','PLACA',1808.000,'S',22,'','1','','','N',1,'PESO',10.000,1),
 ('0110','MELAMINA SOBRE MDF 18MM COÑAC MASISA','PLACA',1808.000,'S',23,'','1','','','N',1,'PESO',10.000,1),
 ('0111','MELAMINA SOBRE MDF 18MM ESMERALDA MASISA','PLACA',1808.000,'S',24,'','1','','','N',1,'PESO',10.000,1),
 ('0112','MELAMINA SOBRE MDF 18MM VERDE OLIVA MASISA','PLACA',1808.000,'S',25,'','1','','','N',1,'PESO',10.000,1),
 ('0113','MELAMINA SOBRE MDF 18MM BLANCO MASISA','PLACA',669.000,'S',26,'','1','','','N',1,'PESO',45.000,1),
 ('0114','MELAMINA SOBRE MDF 18MM AZUL ACERO MASISA','PLACA',1808.000,'S',27,'','1','','','N',1,'PESO',10.000,1),
 ('0115','MELAMINA SOBRE MDF 18MM OLMO ALPINO MASISA','PLACA',1575.000,'S',28,'','1','','','N',1,'PESO',10.000,1),
 ('0116','MELAMINA SOBRE MDF 18MM KENIA MASISA','PLACA',1808.000,'S',29,'','1','','','N',1,'PESO',1.000,1),
 ('0117','MELAMINA SOBRE MDF 18MM SIBERIA MASISA','PLACA',1808.000,'S',30,'','1','','','N',1,'PESO',10.000,1),
 ('0118','MELAMINA SOBRE MDF 18MM MALAGA MASISA','PLACA',1808.000,'S',31,'','1','','','N',1,'PESO',10.000,1),
 ('0119','MELAMINA SOBRE MDF 18MM TOLEDO MASISA','PLACA',1808.000,'S',32,'','1','','','N',1,'PESO',10.000,1),
 ('0120','MELAMINA SOBRE MDF 18MM LARICINA MASISA','PLACA',1575.000,'S',33,'','1','','','N',1,'PESO',10.000,1),
 ('0121','MELAMINA SOBRE MDF 18MM CEDRO MASISA','PLACA',1648.000,'S',34,'','1','','','N',1,'PESO',1.000,1),
 ('0122','MELAMINA SOBRE MDF 18MM NOGAL BRIANZA MASISA','PLACA',1648.000,'S',35,'','1','','','N',1,'PESO',10.000,1),
 ('0123','MELAMINA SOBRE MDF 18MM ROBLE INGLES MASISA','PLACA',1313.000,'S',36,'','1','','','N',1,'PESO',10.000,1),
 ('0124','MELAMINA SOBRE MDF 18MM ALMENDRA MASISA','PLACA',1575.000,'S',37,'','1','','','N',1,'PESO',10.000,1),
 ('0125','MELAMINA SOBRE MDF 18MM ARCILLA MASISA','PLACA',1575.000,'S',38,'','1','','','N',1,'PESO',10.000,1),
 ('0126','MELAMINA SOBRE MDF 18MM CENIZA MASISA','PLACA',1575.000,'S',39,'','1','','','N',1,'PESO',10.000,1),
 ('0127','MELAMINA SOBRE MDF 18MM GRIS HUMO MASISA','PLACA',1575.000,'S',40,'','1','','','N',1,'PESO',10.000,1),
 ('0128','MELAMINA SOBRE MDF 18MM ALUMINIO MASISA','PLACA',1575.000,'S',41,'','1','','','N',1,'PESO',10.000,1),
 ('0129','MELAMINA SOBRE MDF 18MM NEGRO FAPLAC','PLACA',1451.000,'S',42,'','1','','','N',1,'PESO',5.000,1),
 ('0130','MELAMINA SOBRE MDF 18MM ROJO MASISA','PLACA',1575.000,'S',43,'','1','','','N',1,'PESO',10.000,1),
 ('0131','MELAMINA SOBRE MDF 18MM GRIS GRAFITO MASISA','PLACA',1575.000,'S',44,'','1','','','N',1,'PESO',1.000,1),
 ('0133','MELAMINA SOBRE MDF 18MM BLANCO NATURE FAPLAC','PLACA',1291.000,'S',45,'','1','','','N',1,'PESO',2.000,1),
 ('0134','MELAMINA SOBRE MDF 18MM GRIS HUMO FAPLAC','PLACA',1451.000,'S',46,'','1','','','N',1,'PESO',3.000,1),
 ('0135','MELAMINA SOBRE MDF 18MM ALMENDRA FAPLAC','PLACA',1159.000,'S',47,'','1','','','N',1,'PESO',2.000,1),
 ('0136','MELAMINA SOBRE MDF 18MM BLANCO LACA MASISA','PLACA',1808.000,'S',48,'','1','','','N',1,'PESO',10.000,1),
 ('0137','MELAMINA SOBRE MDF 18MM CARVALHO MEZZO FAPLAC','PLACA',1419.000,'S',49,'','1','','','N',1,'PESO',1.000,1),
 ('0138','MELAMINA SOBRE MDF 18MM LINOSA CINZA TOUCH FAPLAC','PLACA',1243.000,'S',50,'','1','','','N',1,'PESO',1.000,1),
 ('0139','MELAMINA SOBRE MDF 18MM TANGANICA TABACO FAPLAC','PLACA',1302.000,'S',51,'','1','','','N',1,'PESO',3.000,1),
 ('0140','MELAMINA SOBRE MDF 18MM ROBLE ESPA¾OL FAPLAC','PLACA',1336.000,'S',52,'','1','','','N',1,'PESO',5.000,1),
 ('0141','MELAMINA SOBRE MDF 18MM ROBLE DAKAR FAPLAC','PLACA',1485.000,'S',53,'','1','','','N',1,'PESO',4.000,1),
 ('0142','MELAMINA SOBRE MDF 18MM ROBLE DAKAR NATURE FAPLAC','PLACA',1654.000,'S',54,'','1','','','N',1,'PESO',10.000,1),
 ('0143','MELAMINA SOBRE MDF 18MM CEREZO MASISA','PLACA',1648.000,'S',55,'','1','','','N',1,'PESO',2.000,1),
 ('0144','MELAMINA SOBRE MDF 18MM MAPLE FAPLAC','PLACA',1430.000,'S',56,'','1','','','N',1,'PESO',10.000,1),
 ('0145','MELAMINA SOBRE MDF 18MM TEKA ARTICO FAPLAC','PLACA',1243.000,'S',57,'','1','','','N',1,'PESO',1.000,1),
 ('0146','MELAMINA SOBRE MDF 18MM VENEZIA VEFAPLAC','PLACA',1654.000,'S',58,'','1','','','N',1,'PESO',1.000,1),
 ('0147','MELAMINA SOBRE MDF 18MM NOCCE MILANO FAPLAC','PLACA',1654.000,'S',59,'','1','','','N',1,'PESO',2.000,1),
 ('0148','MELAMINA SOBRE MDF 18MM CARVALHO ASERRADO FAPLAC','PLACA',1496.000,'S',60,'','1','','','N',1,'PESO',1.000,1),
 ('0149','MELAMINA SOBRE MDF 18MM TERRARUM FAPLAC','PLACA',1496.000,'S',61,'','1','','','N',1,'PESO',2.000,1),
 ('0150','MELAMINA SOBRE MDF 18MM ROBLE AMERICANO FAPLAC','PLACA',1961.000,'S',62,'','1','','','N',1,'PESO',1.000,1),
 ('0151','MELAMINA SOBRE MDF 18MM CEDRO NATURE FAPLAC','PLACA',1602.000,'S',63,'','1','','','N',1,'PESO',2.000,1),
 ('0152','MELAMINA SOBRE MDF 18MM NOGAL TERRACOTA FAPLAC','PLACA',1496.000,'S',64,'','1','','','N',1,'PESO',10.000,1),
 ('0153','MELAMINA SOBRE MDF 18MM ABEDUL FAPLAC','PLACA',1430.000,'S',65,'','1','','','N',1,'PESO',10.000,1),
 ('0154','MELAMINA SOBRE MDF 18MM HAYA FAPLAC','PLACA',1107.000,'S',66,'','1','','','N',1,'PESO',10.000,1),
 ('0155','MELAMINA SOBRE MDF 18MM PERAL FAPLAC','PLACA',1430.000,'S',67,'','1','','','N',1,'PESO',10.000,1),
 ('0156','MELAMINA SOBRE MDF 18MM CEDRO FAPLAC','PLACA',1430.000,'S',68,'','1','','','N',1,'PESO',4.000,1),
 ('0157','MELAMINA SOBRE MDF 18MM EBANO NEGRO FAPLAC','PLACA',1267.000,'S',69,'','1','','','N',1,'PESO',1.000,1),
 ('0158','MELAMINA SOBRE MDF 18MM BLANCO FAPLAC','PLACA',1066.000,'S',70,'','1','','','N',1,'PESO',89.000,1),
 ('0159','MELAMINA SOBRE MDF 18MM CENIZA FAPLAC','PLACA',1327.000,'S',71,'','1','','','N',1,'PESO',8.000,1),
 ('0160','MELAMINA SOBRE MDF 18MM GRAFITO FAPLAC','PLACA',1267.000,'S',72,'','1','','','N',1,'PESO',6.000,1),
 ('0162','MELAMINA SOBRE MDF 18MM AZUL LAGO FAPLAC','PLACA',1430.000,'S',73,'','1','','','N',1,'PESO',10.000,1),
 ('0163','MELAMINA SOBRE MDF 18MM LILA FAPLAC','PLACA',1430.000,'S',74,'','1','','','N',1,'PESO',10.000,1),
 ('0164','MELAMINA SOBRE MDF 18MM VERDE FAPLAC','PLACA',1430.000,'S',75,'','1','','','N',1,'PESO',10.000,1),
 ('0165','MELAMINA SOBRE MDF 18MM MARILLO FAPLAC','PLACA',1430.000,'S',76,'','1','','','N',1,'PESO',10.000,1),
 ('0166','MELAMINA SOBRE MDF 18MM ROJO FAPLAC','PLACA',1411.000,'S',77,'','1','','','N',1,'PESO',3.000,1),
 ('0167','MELAMINA SOBRE MDF 18MM ALUMINIO FAPLAC','PLACA',1430.000,'S',78,'','1','','','N',1,'PESO',1.000,1),
 ('0168','MELAMINA SOBRE MDF 18MM SEDA GIORNO FAPLAC','PLACA',1654.000,'S',79,'','1','','','N',1,'PESO',4.000,1),
 ('0169','MELAMINA SOBRE MDF 18MM SEDA NOTTE FAPLAC','PLACA',1654.000,'S',80,'','1','','','N',1,'PESO',6.000,1),
 ('0170','MELAMINA SOBRE MDF 18MM LINO CHIARO FAPLAC','PLACA',1419.000,'S',81,'','1','','','N',1,'PESO',8.000,1),
 ('0171','MELAMINA SOBRE MDF 18MM LINO TERRA FAPLAC','PLACA',1400.000,'S',82,'','1','','','N',1,'PESO',4.000,1),
 ('0172','MELAMINA SOBRE MDF 18MM LINO BLANCO FAPLAC','PLACA',1571.000,'S',83,'','1','','','N',1,'PESO',2.000,1),
 ('0173','MELAMINA SOBRE MDF 18MM LINO NEGRO FAPLAC','PLACA',1240.000,'S',84,'','1','','','N',1,'PESO',2.000,1),
 ('0174','MELAMINA SOBRE MDF 18MM LITIO FAPLAC','PLACA',1411.000,'S',85,'','1','','','N',1,'PESO',1.000,1),
 ('0175','MELAMINA SOBRE MDF 18MM COBRE FAPLAC','PLACA',1602.000,'S',86,'','1','','','N',1,'PESO',10.000,1),
 ('0176','MELAMINA SOBRE MDF 18MM TITANIO FAPLAC','PLACA',1602.000,'S',87,'','1','','','N',1,'PESO',1.000,1),
 ('0177','MELAMINA SOBRE MDF 18MM ROBLE ESCANDINAVO FAPLAC','PLACA',1419.000,'S',88,'','1','','','N',1,'PESO',3.000,1),
 ('0178','MELAMINA SOBRE MDF 18MM HELSINKI FAPLAC','PLACA',1654.000,'S',89,'','1','','','N',1,'PESO',5.000,1),
 ('0179','MELAMINA SOBRE MDF 18MM BALTICO FAPLAC','PLACA',1496.000,'S',90,'','1','','','N',1,'PESO',5.000,1),
 ('0180','MELAMINA SOBRE MDF 18MM OLMO FINLANDES FAPLAC','PLACA',1608.000,'S',91,'','1','','','N',1,'PESO',3.000,1),
 ('0181','MELAMINA SOBRE MDF 18MM TEKA OSLO FAPLAC','PLACA',1344.000,'S',92,'','1','','','N',1,'PESO',2.000,1),
 ('0182','MELAMINA SOBRE MDF 18MM RAUVISIO BLANCO','PLACA',5792.000,'S',93,'','1','','','N',1,'PESO',2.000,1),
 ('0183','MELAMINA SOBRE MDF 18MM RAUVISIO NEGRO','PLACA',5122.000,'S',94,'','1','','','N',1,'PESO',10.000,1),
 ('0184','MELAMINA SOBRE MDF 18MM RAUVISIO BORD…','PLACA',5900.000,'S',95,'','1','','','N',1,'PESO',10.000,1),
 ('0185','MELAMINA SOBRE MDF 18MM RAUVISIO CHAMPAGNE','PLACA',5780.000,'S',96,'','1','','','N',1,'PESO',10.000,1),
 ('0186','MDF 18 MM MASISA','PLACA',399.000,'S',97,'','1','','','N',1,'PESO',1.000,1),
 ('0187','PANEL RANURADO BLANCO 2.60 X 1.83','PANEL',1700.000,'S',98,'','1','','','N',1,'PESO',1.000,1),
 ('0188','MELAMINA SOBRE AGLOMERADO 18MM TANGANICA','PLACA',0.000,'S',99,'','1','','','N',1,'PESO',2.000,1),
 ('0189','MELAMINA SOBRE MDF 18MM ROBLE MIEL MASISA','PLACA',1961.000,'S',100,'','1','','','N',1,'PESO',1.000,1),
 ('0190','MELAMINA SOBRE MDF 18MM URBAN STREET FAPLAC','PLACA',1290.000,'S',101,'','1','','','N',1,'PESO',1.000,1),
 ('0191','PRACTIWALL ROBLE MORO - PANEL RANURADO','PLACA',1737.000,'S',102,'','1','','','N',1,'PESO',10.000,1),
 ('0193','MELAMINA SOBRE MDF 9MM ESPECIAL EUCA','PLACA',381.000,'S',103,'','1','','','N',1,'PESO',10.000,1),
 ('0194','MELAMINA SOBRE MDF 9MM TRUPAN STD','PLACA',374.000,'S',104,'','1','','','N',1,'PESO',10.000,1),
 ('0195','MELAMINA SOBRE MDF 18MM ENCHAPADO MELAMINICO WENGUE','PLACA',1785.000,'S',105,'','1','','','N',1,'PESO',10.000,1),
 ('1170','FIBROPLUS 3MM BLANCO','PLACA',293.000,'S',106,'','2','','','N',1,'PESO',66.000,1),
 ('1171','FIBROPLUS 3MM HAYA MASISA','PLACA',460.000,'S',107,'','2','','','N',1,'PESO',10.000,1),
 ('1172','FIBROPLUS 3MM CEREJEIRA MASISA','PLACA',460.000,'S',108,'','2','','','N',1,'PESO',10.000,1),
 ('1173','FIBROPLUS 3MM ROBLE MORO MASISA','PLACA',460.000,'S',109,'','2','','','N',1,'PESO',10.000,1),
 ('1174','FIBROPLUS 3MM TECA ITALIA TOUCH MASISA','PLACA',460.000,'S',110,'','2','','','N',1,'PESO',10.000,1),
 ('1175','FIBROPLUS 3MM FRESNO NEGRO MASISA','PLACA',460.000,'S',111,'','2','','','N',1,'PESO',10.000,1),
 ('1176','FIBROPLUS 3MM WENGUE MASISA','PLACA',460.000,'S',112,'','2','','','N',1,'PESO',10.000,1),
 ('1177','FIBROPLUS 3MM GUINDO MASISA','PLACA',460.000,'S',113,'','2','','','N',1,'PESO',10.000,1),
 ('1178','FIBROPLUS 3MM FRESNO ABEDUL MASISA','PLACA',460.000,'S',114,'','2','','','N',1,'PESO',10.000,1),
 ('1179','FIBROPLUS 3MM TECA MASISA','PLACA',460.000,'S',115,'','2','','','N',1,'PESO',10.000,1),
 ('1180','FIBROPLUS 3MM VISON MASISA','PLACA',460.000,'S',116,'','2','','','N',1,'PESO',10.000,1),
 ('1181','FIBROPLUS 3MM NOGAL HABANO MASISA','PLACA',460.000,'S',117,'','2','','','N',1,'PESO',10.000,1),
 ('1182','FIBROPLUS 3MM CONCRETO METROPOLITAN MASISA','PLACA',460.000,'S',118,'','2','','','N',1,'PESO',10.000,1),
 ('1183','FIBROPLUS 3MM NEBRASKA MASISA','PLACA',460.000,'S',119,'','2','','','N',1,'PESO',10.000,1),
 ('1184','FIBROPLUS 3MM TWEED MASISA','PLACA',460.000,'S',120,'','2','','','N',1,'PESO',10.000,1),
 ('1185','FIBROPLUS 3MM LINO MASISA','PLACA',460.000,'S',121,'','2','','','N',1,'PESO',10.000,1),
 ('1186','FIBROPLUS 3MM ENIGMA MASISA','PLACA',460.000,'S',122,'','2','','','N',1,'PESO',1.000,1),
 ('1187','FIBROPLUS 3MM TECA LIMO MASISA','PLACA',460.000,'S',123,'','2','','','N',1,'PESO',10.000,1),
 ('1188','FIBROPLUS 3MM ROBLE NATURAL MASISA','PLACA',460.000,'S',124,'','2','','','N',1,'PESO',10.000,1),
 ('1189','FIBROPLUS 3MM ROBLE AMERICANO MASISA','PLACA',460.000,'S',125,'','2','','','N',1,'PESO',10.000,1),
 ('1190','FIBROPLUS 3MM ROBLE BLANCO MASISA','PLACA',460.000,'S',126,'','2','','','N',1,'PESO',10.000,1),
 ('1191','FIBROPLUS 3MM MANGO MASISA','PLACA',460.000,'S',127,'','2','','','N',1,'PESO',10.000,1),
 ('1192','FIBROPLUS 3MM CO¾AC MASISA','PLACA',460.000,'S',128,'','2','','','N',1,'PESO',10.000,1),
 ('1193','FIBROPLUS 3MM ESMERALDA MASISA','PLACA',460.000,'S',129,'','2','','','N',1,'PESO',10.000,1),
 ('1194','FIBROPLUS 3MM VERDE OLIVA MASISA','PLACA',460.000,'S',130,'','2','','','N',1,'PESO',10.000,1),
 ('1195','FIBROPLUS 3MM BLANCO MASISA','PLACA',460.000,'S',131,'','2','','','N',1,'PESO',10.000,1),
 ('1196','FIBROPLUS 3MM AZUL ACERO MASISA','PLACA',460.000,'S',132,'','2','','','N',1,'PESO',10.000,1),
 ('1197','FIBROPLUS 3MM OLMO ALPINO MASISA','PLACA',460.000,'S',133,'','2','','','N',1,'PESO',10.000,1),
 ('1198','FIBROPLUS 3MM KENIA MASISA','PLACA',460.000,'S',134,'','2','','','N',1,'PESO',10.000,1),
 ('1199','FIBROPLUS 3MM SIBERIA MASISA','PLACA',460.000,'S',135,'','2','','','N',1,'PESO',10.000,1),
 ('1200','FIBROPLUS 3MM MæLAGA MASISA','PLACA',460.000,'S',136,'','2','','','N',1,'PESO',10.000,1),
 ('1201','FIBROPLUS 3MM TOLEDO MASISA','PLACA',460.000,'S',137,'','2','','','N',1,'PESO',10.000,1),
 ('1202','FIBROPLUS 3MM LARICINA MASISA','PLACA',460.000,'S',138,'','2','','','N',1,'PESO',10.000,1),
 ('1203','FIBROPLUS 3MM CEDRO MASISA','PLACA',460.000,'S',139,'','2','','','N',1,'PESO',10.000,1),
 ('1204','FIBROPLUS 3MM NOGAL BRIANZA MASISA','PLACA',460.000,'S',140,'','2','','','N',1,'PESO',10.000,1),
 ('1205','FIBROPLUS 3MM ROBLE INGLES MASISA','PLACA',460.000,'S',141,'','2','','','N',1,'PESO',10.000,1),
 ('1206','FIBROPLUS 3MM ALMENDRA MASISA','PLACA',460.000,'S',142,'','2','','','N',1,'PESO',10.000,1),
 ('1207','FIBROPLUS 3MM ARCILLA MASISA','PLACA',460.000,'S',143,'','2','','','N',1,'PESO',10.000,1),
 ('1208','FIBROPLUS 3MM CENIZA MASISA','PLACA',460.000,'S',144,'','2','','','N',1,'PESO',10.000,1),
 ('1209','FIBROPLUS 3MM GRIS HUMO MASISA','PLACA',460.000,'S',145,'','2','','','N',1,'PESO',10.000,1),
 ('1210','FIBROPLUS 3MM ALUMINIO MASISA','PLACA',460.000,'S',146,'','2','','','N',1,'PESO',10.000,1),
 ('1211','FIBROPLUS 3MM NEGRO','PLACA',356.000,'S',147,'','2','','','N',1,'PESO',10.000,1),
 ('1212','FIBROPLUS 3MM ROJO MASISA','PLACA',460.000,'S',148,'','2','','','N',1,'PESO',10.000,1),
 ('1213','FIBROPLUS 3MM GRIS GRAFITO MASISA','PLACA',460.000,'S',149,'','2','','','N',1,'PESO',10.000,1),
 ('1214','FIBROPLUS 3MM BLANCO NATURE FAPLAC','PLACA',460.000,'S',150,'','2','','','N',1,'PESO',10.000,1),
 ('1215','FIBROPLUS 3MM GRIS HUMO FAPLAC','PLACA',460.000,'S',151,'','2','','','N',1,'PESO',10.000,1),
 ('1216','FIBROPLUS 3MM ALMENDRA FAPLAC','PLACA',460.000,'S',152,'','2','','','N',1,'PESO',10.000,1),
 ('1217','FIBROPLUS 3MM BLANCO LACAS MASISA','PLACA',460.000,'S',153,'','2','','','N',1,'PESO',10.000,1),
 ('1218','FIBROPLUS 3MM CARVALHO MEZZO FAPLAC','PLACA',460.000,'S',154,'','2','','','N',1,'PESO',10.000,1),
 ('1219','FIBROPLUS 3MM LINOSA CINZA TOUCH FAPLAC','PLACA',460.000,'S',155,'','2','','','N',1,'PESO',10.000,1),
 ('1220','FIBROPLUS 3MM TANGANICA TABACO FAPLAC','PLACA',460.000,'S',156,'','2','','','N',1,'PESO',10.000,1),
 ('1221','FIBROPLUS 3MM ROBLE ESPAÑOL FAPLAC','PLACA',460.000,'S',157,'','2','','','N',1,'PESO',10.000,1),
 ('1222','FIBROPLUS 3MM ROBLE DAKAR FAPLAC','PLACA',460.000,'S',158,'','2','','','N',1,'PESO',10.000,1),
 ('1223','FIBROPLUS 3MM ROBLE DAKAR NATURE FAPLAC','PLACA',460.000,'S',159,'','2','','','N',1,'PESO',10.000,1),
 ('1224','FIBROPLUS 3MM CEREZO FAPLAC','PLACA',460.000,'S',160,'','2','','','N',1,'PESO',10.000,1),
 ('1225','FIBROPLUS 3MM MAPLE FAPLAC','PLACA',460.000,'S',161,'','2','','','N',1,'PESO',10.000,1),
 ('1226','FIBROPLUS 3MM TEKA ARTICO FAPLAC','PLACA',460.000,'S',162,'','2','','','N',1,'PESO',10.000,1),
 ('1227','FIBROPLUS 3MM VENEZIA VEFAPLAC','PLACA',460.000,'S',163,'','2','','','N',1,'PESO',10.000,1),
 ('1228','FIBROPLUS 3MM NOSSE MILANO FAPLAC','PLACA',460.000,'S',164,'','2','','','N',1,'PESO',10.000,1),
 ('1229','FIBROPLUS 3MM CARVALHO ASERRADO FAPLAC','PLACA',460.000,'S',165,'','2','','','N',1,'PESO',10.000,1),
 ('1230','FIBROPLUS 3MM TERRARUM FAPLAC','PLACA',460.000,'S',166,'','2','','','N',1,'PESO',10.000,1),
 ('1231','FIBROPLUS 3MM ROBLE AMERICANO FAPLAC','PLACA',460.000,'S',167,'','2','','','N',1,'PESO',10.000,1),
 ('1232','FIBROPLUS 3MM CEDRO NATURE FAPLAC','PLACA',460.000,'S',168,'','2','','','N',1,'PESO',10.000,1),
 ('1233','FIBROPLUS 3MM NOGAL TERRACOTA FAPLAC','PLACA',460.000,'S',169,'','2','','','N',1,'PESO',10.000,1),
 ('1234','FIBROPLUS 3MM ABEDUL FAPLAC','PLACA',460.000,'S',170,'','2','','','N',1,'PESO',10.000,1),
 ('1235','FIBROPLUS 3MM HAYA FAPLAC','PLACA',460.000,'S',171,'','2','','','N',1,'PESO',10.000,1),
 ('1236','FIBROPLUS 3MM PERAL FAPLAC','PLACA',460.000,'S',172,'','2','','','N',1,'PESO',10.000,1),
 ('1237','FIBROPLUS 3MM CEDRO FAPLAC','PLACA',400.000,'S',173,'','2','','','N',1,'PESO',1.000,1),
 ('1238','FIBROPLUS 3MM EBANO NEGRO FAPLAC','PLACA',460.000,'S',174,'','2','','','N',1,'PESO',2.000,1),
 ('1239','FIBROPLUS 3MM BLANCO FAPLAC','PLACA',312.000,'S',175,'','2','','','N',1,'PESO',10.000,1),
 ('1240','FIBROPLUS 3MM CENIZA 3MM','PLACA',337.000,'S',176,'','2','','','N',1,'PESO',10.000,1),
 ('1241','FIBROPLUS 3MM GRAFITO FAPLAC','PLACA',460.000,'S',177,'','2','','','N',1,'PESO',10.000,1),
 ('1242','FIBROPLUS 3MM AZUL LAGO FAPLAC','PLACA',460.000,'S',178,'','2','','','N',1,'PESO',10.000,1),
 ('1243','FIBROPLUS 3MM LILA FAPLAC','PLACA',460.000,'S',179,'','2','','','N',1,'PESO',10.000,1),
 ('1244','FIBROPLUS 3MM VERDE FAPLAC','PLACA',460.000,'S',180,'','2','','','N',1,'PESO',10.000,1),
 ('1245','FIBROPLUS 3MM MARILLO FAPLAC','PLACA',460.000,'S',181,'','2','','','N',1,'PESO',10.000,1),
 ('1246','FIBROPLUS 5.5MM ROJO FAPLAC','PLACA',543.000,'S',182,'','2','','','N',1,'PESO',1.000,1),
 ('1247','FIBROPLUS 3MM ALUMINIO FAPLAC','PLACA',460.000,'S',183,'','2','','','N',1,'PESO',10.000,1),
 ('1248','FIBROPLUS 3MM SEDA GIORNO FAPLAC','PLACA',460.000,'S',184,'','2','','','N',1,'PESO',10.000,1),
 ('1249','FIBROPLUS 3MM SEDA NOTTE FAPLAC','PLACA',460.000,'S',185,'','2','','','N',1,'PESO',10.000,1),
 ('1250','FIBROPLUS 3MM LINO CHIARO FAPLAC','PLACA',460.000,'S',186,'','2','','','N',1,'PESO',10.000,1),
 ('1251','FIBROPLUS 3MM LINO TERRA FAPLAC','PLACA',460.000,'S',187,'','2','','','N',1,'PESO',10.000,1),
 ('1252','FIBROPLUS 3MM LINO BLANCO FAPLAC','PLACA',460.000,'S',188,'','2','','','N',1,'PESO',10.000,1),
 ('1253','FIBROPLUS 3MM LINO NEGRO FAPLAC','PLACA',460.000,'S',189,'','2','','','N',1,'PESO',10.000,1),
 ('1254','FIBROPLUS 3MM LITIO FAPLAC','PLACA',460.000,'S',190,'','2','','','N',1,'PESO',10.000,1),
 ('1255','FIBROPLUS 3MM COBRE FAPLAC','PLACA',460.000,'S',191,'','2','','','N',1,'PESO',10.000,1),
 ('1256','FIBROPLUS 3MM TITANIO FAPLAC','PLACA',460.000,'S',192,'','2','','','N',1,'PESO',10.000,1),
 ('1257','FIBROPLUS 3MM ROBLE ESCANDINAVO FAPLAC','PLACA',460.000,'S',193,'','2','','','N',1,'PESO',10.000,1),
 ('1258','FIBROPLUS 3MM HELSINKI FAPLAC','PLACA',460.000,'S',194,'','2','','','N',1,'PESO',10.000,1),
 ('1259','FIBROPLUS 3MM BALTICO FAPLAC','PLACA',460.000,'S',195,'','2','','','N',1,'PESO',10.000,1),
 ('1260','FIBROPLUS 3MM OLMO FINLANDES FAPLAC','PLACA',460.000,'S',196,'','2','','','N',1,'PESO',10.000,1),
 ('1261','FIBROPLUS 3MM TEKA OSLO FAPLAC','PLACA',460.000,'S',197,'','2','','','N',1,'PESO',10.000,1),
 ('1262','FIBROPLUS 3MM RAUVISIO BLANCO','PLACA',460.000,'S',198,'','2','','','N',1,'PESO',10.000,1),
 ('1263','FIBROPLUS 3MM RAUVISIO NEGRO','PLACA',460.000,'S',199,'','2','','','N',1,'PESO',10.000,1),
 ('1264','FIBROPLUS 3MM RAUVISIO BORD…','PLACA',460.000,'S',200,'','2','','','N',1,'PESO',10.000,1),
 ('1265','FIBROPLUS 3MM RAUVISIO CHAMPAGNE','PLACA',460.000,'S',201,'','2','','','N',1,'PESO',10.000,1),
 ('3000','ANGULO DE TERM. ALUMINIO 12X12','UND.',2.000,'S',202,'','4','','','N',1,'PESO',10.000,1),
 ('3001','BASE PLASTICA','UND.',0.000,'S',203,'','4','','','N',1,'PESO',485.000,1),
 ('3002','BISAGRA 165 GRADOS','UND.',24.000,'S',204,'','4','','','N',1,'PESO',53.000,1),
 ('3003','BISAGRA CIERRE SUAVE 35 MM CODO 0','UND.',27.000,'S',205,'','4','','','N',1,'PESO',23.000,1),
 ('3004','BISAGRA CIERRE SUAVE 35 MM CODO 9','UND.',24.000,'S',206,'','4','','','N',1,'PESO',26.000,1),
 ('3005','BISAGRA COMUN 25 MM CODO 0','UND.',3.000,'S',207,'','4','','','N',1,'PESO',10.000,1),
 ('3006','BISAGRA COMUN 25 MM CODO 9','UND.',3.000,'S',208,'','4','','','N',1,'PESO',10.000,1),
 ('3007','BISAGRA COMUN 35 MM CODO 0','UND.',7.000,'S',209,'','4','','','N',1,'PESO',124.000,1),
 ('3008','BISAGRA COMUN 35 MM CODO 9','UND.',7.000,'S',210,'','4','','','N',1,'PESO',290.000,1),
 ('3009','BISAGRA DOBLE ACCION VAIVEN 3','',0.000,'S',211,'','4','','','N',1,'PESO',10.000,1),
 ('3010','BISAGRA INTERMEDIA  135 GRADOS','UND.',17.000,'S',212,'','4','','','N',1,'PESO',1.000,1),
 ('3011','BISAGRA PARA PERFIL ALUMINIO 20 X 20','UND.',17.000,'S',213,'','4','','','N',1,'PESO',10.000,1),
 ('3012','BISAGRA PARA PUERTA DE VIDRIO','UND.',8.000,'S',214,'','4','','','N',1,'PESO',10.000,1),
 ('3013','BOTINERO CROMADO 12 PARES','UND.',575.000,'S',215,'','4','','','N',1,'PESO',10.000,1),
 ('3014','BOTINERO CROMADO 8 PARES','UND.',449.000,'S',216,'','4','','','N',1,'PESO',1.000,1),
 ('3015','BURLETE DE GOMA','MTS,',22.000,'S',217,'','4','','','N',1,'PESO',10.000,1),
 ('3016','BURLETE PARA VIDRIO','MTS',5.000,'S',218,'','4','','','N',1,'PESO',10.000,1),
 ('3017','CAJA FUERTE CIERRE ELECTRONICO 200 X 200 X 310 MM','UND.',0.000,'S',219,'','4','','','N',1,'PESO',10.000,1),
 ('3018','CANASTO DE METAL VERDULERO CROMADO 430 X 460 MM','UND.',0.000,'S',220,'','4','','','N',1,'PESO',10.000,1),
 ('3019','CA¾O ALUMINIO OVAL','MTS,',0.000,'S',221,'','4','','','N',1,'PESO',10.000,1),
 ('3020','CA¾O ALUMINIO OVAL LINEA S','MTS,',99.000,'S',222,'','4','','','N',1,'PESO',10.000,1),
 ('3021','CERRADURA DE BOTON CROMADA','UND.',0.000,'S',223,'','4','','','N',1,'PESO',3.000,1),
 ('3022','CERRADURA DE CAJON CUADRADA CROMADA','UND.',25.000,'S',224,'','4','','','N',1,'PESO',13.000,1),
 ('3023','CERRADURA INDICADOR LIBRE/OCUPADO PARA BA¾O','UND.',26.000,'S',225,'','4','','','N',1,'PESO',10.000,1),
 ('3024','CERRADURA PARA PUERTA DE ROPERO ECONOMICA','UND.',0.000,'S',226,'','4','','','N',1,'PESO',10.000,1),
 ('3025','CERRADURA PUERTA DE VIDRIO CORREDIZA CROMADA','UND.',35.000,'S',227,'','4','','','N',1,'PESO',10.000,1),
 ('3026','CHAPITA PARA FONDO','UND.',0.000,'S',228,'','4','','','N',1,'PESO',10.000,1),
 ('3027','COLGADOR DE ALACENA BLANCO','UND.',8.000,'S',229,'','4','','','N',1,'PESO',97.000,1),
 ('3028','CORREDERA AL PISO PARA MUEBLE DUCASSE','UND.',0.000,'S',230,'','4','','','N',1,'PESO',10.000,1),
 ('3029','CORREDERA COMUN 250 MM','UND.',20.000,'S',231,'','4','','','N',1,'PESO',10.000,1),
 ('3030','CORREDERA COMUN 300 MM','UND.',24.000,'S',232,'','4','','','N',1,'PESO',1.000,1),
 ('3031','CORREDERA COMUN 350 MM','UND.',28.000,'S',233,'','4','','','N',1,'PESO',2.000,1),
 ('3032','CORREDERA COMUN 400 MM','UND.',78.000,'S',234,'','4','','','N',1,'PESO',3.000,1),
 ('3033','CORREDERA COMUN 450 MM','UND.',88.000,'S',235,'','4','','','N',1,'PESO',1.000,1),
 ('3034','CORREDERA COMUN 500 MM','UND.',62.000,'S',236,'','4','','','N',1,'PESO',4.000,1),
 ('3035','CORREDERA LATERAL METALICO 400 MM','UND.',0.000,'S',237,'','4','','','N',1,'PESO',10.000,1),
 ('3036','CORREDERA OCULTA CON LATERAL 500 MM','UND.',0.000,'S',238,'','4','','','N',1,'PESO',10.000,1),
 ('3037','CORREDERA TELESCOPICA 250 MM','UND.',40.000,'S',239,'','4','','','N',1,'PESO',5.000,1),
 ('3038','CORREDERA TELESCOPICA 300 MM','UND.',43.000,'S',240,'','4','','','N',1,'PESO',14.000,1),
 ('3039','CORREDERA TELESCOPICA 350 MM','UND.',67.000,'S',241,'','4','','','N',1,'PESO',18.000,1),
 ('3040','CORREDERA TELESCOPICA 350 MM PORTATECLADO','UND.',0.000,'S',242,'','4','','','N',1,'PESO',10.000,1),
 ('3041','CORREDERA TELESCOPICA 400 MM','UND.',62.000,'S',243,'','4','','','N',1,'PESO',34.000,1),
 ('3042','CORREDERA TELESCOPICA 450 MM','UND.',69.000,'S',244,'','4','','','N',1,'PESO',93.000,1),
 ('3043','CORREDERA TELESCOPICA 500 MM','UND.',72.000,'S',245,'','4','','','N',1,'PESO',74.000,1),
 ('3044','CORREDERA TELESCOPICA 500 MM CIERRE SUAVE','UND.',130.000,'S',246,'','4','','','N',1,'PESO',13.000,1),
 ('3045','CUBIERTERO 300 X 470 MM','UND.',153.000,'S',247,'','4','','','N',1,'PESO',10.000,1),
 ('3046','CUBIERTERO 350 X 470 MM','UND.',187.000,'S',248,'','4','','','N',1,'PESO',4.000,1),
 ('3047','CUBIERTERO 400 X 500 MM','UND.',196.000,'S',249,'','4','','','N',1,'PESO',6.000,1),
 ('3048','CUBIERTERO 600 X 500 MM','UND.',277.000,'S',250,'','4','','','N',1,'PESO',5.000,1),
 ('3049','ESCADRA PERFIL PIANNO','UND.',9.000,'S',251,'','4','','','N',1,'PESO',10.000,1),
 ('3050','ESCUADRA','L',1.000,'S',252,'','4','','','N',1,'PESO',10.000,1),
 ('3051','ESCUADRA ESQUINERO 25 X 25 MM','UND.',3.000,'S',253,'','4','','','N',1,'PESO',6.000,1),
 ('3052','ESCUADRA ESQUINERO 50 X 50 MM','UND.',4.000,'S',254,'','4','','','N',1,'PESO',10.000,1),
 ('3053','ESCUADRA ESQUINERO 75 X 75 MM','UND.',4.000,'S',255,'','4','','','N',1,'PESO',10.000,1),
 ('3054','CANASTO VOLCABLE PARA ROPA 350 MM','UND.',342.000,'S',256,'','4','','','N',1,'PESO',1.000,1),
 ('3055','ESCUADRA PERFIL SCALE','UND.',14.000,'S',257,'','4','','','N',1,'PESO',80.000,1),
 ('3056','ESCUADRA PLASTICA PARA PERFIL 20 X 20 MM ALUMINIO','UND.',9.000,'S',258,'','4','','','N',1,'PESO',10.000,1),
 ('3057','ESQUINERO 0.1 CM','UND.',0.000,'S',259,'','4','','','N',1,'PESO',10.000,1),
 ('3058','ESTABILIZADOR DERECHO','UND.',19.000,'S',260,'','4','','','N',1,'PESO',10.000,1),
 ('3059','ESTABILIZADOR IZQUIERDO','UND.',19.000,'S',261,'','4','','','N',1,'PESO',10.000,1),
 ('3060','FELPA 5X5','UND.',2.000,'S',262,'','4','','','N',1,'PESO',10.000,1),
 ('3061','GU™A INFERIOR ALUMINIO','UND.',0.000,'S',263,'','4','','','N',1,'PESO',10.000,1),
 ('3062','GU™A SUPERIOR ALUMINIO','UND.',0.000,'S',264,'','4','','','N',1,'PESO',10.000,1),
 ('3063','H MINI ALUMINIO','UND.',0.000,'S',265,'','4','','','N',1,'PESO',10.000,1),
 ('3064','KIT CORREDIZO SIN PERIL MANIJA SISTEMA GE52-300','UND.',0.000,'S',266,'','4','','','N',1,'PESO',10.000,1),
 ('3065','KIT CORREDIZO SIN PERIL MANIJA SISTEMA OFFICE','UND.',41.000,'S',267,'','4','','','N',1,'PESO',2.000,1),
 ('3066','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 1.50 MTS','UND.',1247.000,'S',268,'','4','','','N',1,'PESO',2.000,1),
 ('3067','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 2.00 MTS','UND.',1319.000,'S',269,'','4','','','N',1,'PESO',6.000,1),
 ('3068','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 3.00 MTS','UND.',1455.000,'S',270,'','4','','','N',1,'PESO',9.000,1),
 ('3069','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 4.00 MTS','UND.',1611.000,'S',271,'','4','','','N',1,'PESO',3.000,1),
 ('3070','KIT CORREDIZO SISTEMA COMPACTO ANCHO GU™A 1.50 MTS','UND.',808.000,'S',272,'','4','','','N',1,'PESO',10.000,1),
 ('3071','KIT CORREDIZO SISTEMA COMPACTO ANCHO GU™A 2.00 MTS','UND.',855.000,'S',273,'','4','','','N',1,'PESO',10.000,1),
 ('3072','KIT CORREDIZO SISTEMA COMPACTO ANCHO GU™A 3.00 MTS -KC300-','UND.',940.000,'S',274,'','4','','','N',1,'PESO',10.000,1),
 ('3073','KIT CORREDIZO SISTEMA COMPACTO ANCHO GU™A 4.00 MTS','UND.',1044.000,'S',275,'','4','','','N',1,'PESO',10.000,1),
 ('3074','VARILLA LED 80 CM 220V BLANCO','UND.',467.000,'S',276,'','4','','','N',1,'PESO',10.000,1),
 ('3075','KIT FRENO PLACARD','UND.',448.000,'S',277,'','4','','','N',1,'PESO',1.000,1),
 ('3076','MANIJA ABRUZZO 160 MM','UND.',64.000,'S',278,'','4','','','N',1,'PESO',10.000,1),
 ('3077','MANIJA ABRUZZO PINTADA 160 MM','UND.',64.000,'S',279,'','4','','','N',1,'PESO',10.000,1),
 ('3078','MANIJA AMANDA 192 MM','UND.',94.000,'S',280,'','4','','','N',1,'PESO',3.000,1),
 ('3079','MANIJA AMON 128 MM','UND.',27.000,'S',281,'','4','','','N',1,'PESO',10.000,1),
 ('3080','MANIJA AMON 160 MM','UND.',34.000,'S',282,'','4','','','N',1,'PESO',10.000,1),
 ('3081','MANIJA AMON 96 MM','UND.',24.000,'S',283,'','4','','','N',1,'PESO',10.000,1),
 ('3082','VARILLA LED 40 CM 220V BLANCO','UND.',208.000,'S',284,'','4','','','N',1,'PESO',10.000,1),
 ('3083','PATA REDONDA GRIS C/REG.','UND.',21.000,'S',285,'','4','','','N',1,'PESO',10.000,1),
 ('3084','PATA CUADRADA GRIS C/REG.','UND.',21.000,'S',286,'','4','','','N',1,'PESO',10.000,1),
 ('3085','MANIJA BARRAL 96 MM PLASTICAS','UND.',4.000,'S',287,'','4','','','N',1,'PESO',2.000,1),
 ('3086','MANIJA BARRAL RECTO 128 MM','UND.',45.000,'S',288,'','4','','','N',1,'PESO',19.000,1),
 ('3087','MANIJA BARRAL RECTO 160 MM','UND.',24.000,'S',289,'','4','','','N',1,'PESO',10.000,1),
 ('3088','MANIJA BARRAL RECTO 192 MM','UND.',26.000,'S',290,'','4','','','N',1,'PESO',4.000,1),
 ('3089','MANIJA BARRAL RECTO 256 MM','UND.',38.000,'S',291,'','4','','','N',1,'PESO',10.000,1),
 ('3090','MANIJA BARRAL RECTO 96 MM','UND.',29.000,'S',292,'','4','','','N',1,'PESO',31.000,1),
 ('3091','MANIJA CINTA 160 MM','UND.',47.000,'S',293,'','4','','','N',1,'PESO',10.000,1),
 ('3092','MANIJA CUBETA 128 MM','UND.',65.000,'S',294,'','4','','','N',1,'PESO',1.000,1),
 ('3093','MANIJA CUBETA METAL CHICA','UND.',0.000,'S',295,'','4','','','N',1,'PESO',10.000,1),
 ('3094','MANIJA CUBETA PLASTICO REDONDO','UND.',0.000,'S',296,'','4','','','N',1,'PESO',10.000,1),
 ('3095','MANIJA MEDIALUNA 128 MM','UND.',12.000,'S',297,'','4','','','N',1,'PESO',2.000,1),
 ('3096','MANIJA MEDIALUNA 96 MM','UND.',10.000,'S',298,'','4','','','N',1,'PESO',9.000,1),
 ('3097','MANIJA PLASTICA 96 MM','UND.',0.000,'S',299,'','4','','','N',1,'PESO',10.000,1),
 ('3098','MANIJA OCULTA EURO','UND.',17.000,'S',300,'','4','','','N',1,'PESO',7.000,1),
 ('3099','MANIJA PLASTICA BLANCA','UND.',0.000,'S',301,'','4','','','N',1,'PESO',10.000,1),
 ('3100','MANIJA PLASTICA CINTA 128 MM','UND.',5.000,'S',302,'','4','','','N',1,'PESO',1.000,1),
 ('3101','MANIJA TITANIUM 128 MM','UND.',0.000,'S',303,'','4','','','N',1,'PESO',10.000,1),
 ('3102','MANIJA TITANIUM 160 MM','UND.',0.000,'S',304,'','4','','','N',1,'PESO',10.000,1),
 ('3103','HOJA ADICIONAL KIT CLASSIC','UND.',554.000,'S',305,'','4','','','N',1,'PESO',7.000,1),
 ('3104','HOJA ADICIONAL KIT COMPACTO','UND.',277.000,'S',306,'','4','','','N',1,'PESO',10.000,1),
 ('3105','HOJA ADICIONAL KIT PLUS','UND.',908.000,'S',307,'','4','','','N',1,'PESO',10.000,1),
 ('3106','MENSULA RE 17 CM','UND.',0.000,'S',308,'','4','','','N',1,'PESO',1.000,1),
 ('3107','MENSULA RE 27 CM','UND.',0.000,'S',309,'','4','','','N',1,'PESO',10.000,1),
 ('3108','MENSULA RE 37 CM','UND.',0.000,'S',310,'','4','','','N',1,'PESO',10.000,1),
 ('3109','MENSULA RE 44 CM','UND.',0.000,'S',311,'','4','','','N',1,'PESO',10.000,1),
 ('3110','MENSULA RE 54 CM','UND.',0.000,'S',312,'','4','','','N',1,'PESO',10.000,1),
 ('3111','PANTALONERO CROMADO 10 PERCHAS','UND.',1004.000,'S',313,'','4','','','N',1,'PESO',15.000,1),
 ('3112','REGATON REGULABLE CHICO + BASE','UND.',5.000,'S',314,'','4','','','N',1,'PESO',3.000,1),
 ('3113','PANTALONERO DE ALAMBRE','UND.',0.000,'S',315,'','4','','','N',1,'PESO',10.000,1),
 ('3114','PASA CABLE 60 MM NEGRO','UND.',4.000,'S',316,'','4','','','N',1,'PESO',3.000,1),
 ('3115','PATA DE ALUMINIO','UND.',54.000,'S',317,'','4','','','N',1,'PESO',2.000,1),
 ('3116','PATA DESAYUNADOR 71CM CROMADA','UND.',250.000,'S',318,'','4','','','N',1,'PESO',10.000,1),
 ('3117','PATA DESAYUNADOR 75CM','UND.',0.000,'S',319,'','4','','','N',1,'PESO',10.000,1),
 ('3118','PATA DESAYUNADOR 98CM','UND.',232.000,'S',320,'','4','','','N',1,'PESO',10.000,1),
 ('3119','PATA PLASTICA PARA BAJO MESADA 10CM','UND.',9.000,'S',321,'','4','','','N',1,'PESO',121.000,1),
 ('3120','PATIN ESTABILIZADOR','UND.',0.000,'S',322,'','4','','','N',1,'PESO',10.000,1),
 ('3121','PATIN ESTABILIZADOR CON RUEDAS','UND.',19.000,'S',323,'','4','','','N',1,'PESO',10.000,1),
 ('3123','PERFIL PIANNO 20X20','UND.',171.000,'S',324,'','4','','','N',1,'PESO',10.000,1),
 ('3124','PERFIL SCALE 45X20','MTS',334.000,'S',325,'','4','','','N',1,'PESO',10.000,1),
 ('3125','PERFIL LINEA / CITY 45X20','UND.',0.000,'S',326,'','4','','','N',1,'PESO',10.000,1),
 ('3126','PISTON A GAS  100 N','UND.',25.000,'S',327,'','4','','','N',1,'PESO',14.000,1),
 ('3127','PISTON A GAS  120 N','UND.',41.000,'S',328,'','4','','','N',1,'PESO',11.000,1),
 ('3128','PISTON A GAS  80 N','UND.',19.000,'S',329,'','4','','','N',1,'PESO',5.000,1),
 ('3129','PORTA CD PLASTICO','UND.',0.000,'S',330,'','4','','','N',1,'PESO',10.000,1),
 ('3130','PUNTERA BRILLOSA 18 MM','UND.',3.000,'S',331,'','4','','','N',1,'PESO',10.000,1),
 ('3131','PUNTERA BRILLOSA 36 MM PLASTICA','UND.',7.000,'S',332,'','4','','','N',1,'PESO',10.000,1),
 ('3132','PUNTERA MATE 18 MM','UND.',3.000,'S',333,'','4','','','N',1,'PESO',26.000,1),
 ('3133','PUNTERA MATE 36 MM','UND.',8.000,'S',334,'','4','','','N',1,'PESO',10.000,1),
 ('3134','PUNTERA U BRILLOSA 18 MM','UND.',2.000,'S',335,'','4','','','N',1,'PESO',10.000,1),
 ('3135','PUNTERA U MATE 18 MM','UND.',3.000,'S',336,'','4','','','N',1,'PESO',10.000,1),
 ('3136','REJILLA RESPIRATORIA PLASTICA 35 MM','UND.',0.000,'S',337,'','4','','','N',1,'PESO',10.000,1),
 ('3137','REJILLA RESPIRATORIA PLASTICA 55 MM','UND.',0.000,'S',338,'','4','','','N',1,'PESO',10.000,1),
 ('3138','RIEL RE 1.00 MTS','UND.',0.000,'S',339,'','4','','','N',1,'PESO',10.000,1),
 ('3139','RIEL RE 1.50 MTS','UND.',0.000,'S',340,'','4','','','N',1,'PESO',10.000,1),
 ('3140','RIEL RE 2.00 MTS','UND.',0.000,'S',341,'','4','','','N',1,'PESO',10.000,1),
 ('3141','RIEL RE 2.50 MTS','UND.',121.000,'S',342,'','4','','','N',1,'PESO',10.000,1),
 ('3142','RIEL RE 3.00 MTS','UND.',0.000,'S',343,'','4','','','N',1,'PESO',10.000,1),
 ('3143','RUEDA CHINA DE GOMA GIRATORIA 51MM','UND.',17.000,'S',344,'','4','','','N',1,'PESO',6.000,1),
 ('3144','RUEDA CON FELPA AUTOLIMPIANTE','UND.',49.000,'S',345,'','4','','','N',1,'PESO',10.000,1),
 ('3145','RUEDA DE NYLON PARA MESA DE COMPUTACION','UND.',0.000,'S',346,'','4','','','N',1,'PESO',10.000,1),
 ('3146','RUEDA DE NYLON PARA MESA TV','UND.',15.000,'S',347,'','4','','','N',1,'PESO',3.000,1),
 ('3147','RUEDA NACIONAL GIRATORIA 50MM CON FRENO','UND.',65.000,'S',348,'','4','','','N',1,'PESO',2.000,1),
 ('3148','RUEDA NACIONAL GIRATORIA 50MM S/FRENO','UND.',58.000,'S',349,'','4','','','N',1,'PESO',1.000,1),
 ('3149','RUEDA PARA CAMA MARINERA','UND.',0.000,'S',350,'','4','','','N',1,'PESO',10.000,1),
 ('3150','TIRADOR ALUMINIO CINTAADHESIVA CHICA -ADHR-','UND.',235.000,'S',351,'','4','','','N',1,'PESO',10.000,1),
 ('3151','TIRADOR ALUMINIO CINTAADHESIVA GRANDE -ADH-','UND.',353.000,'S',352,'','4','','','N',1,'PESO',10.000,1),
 ('3152','RUEDA PARA PUERTA CORREDIZA PLASTICA','UND.',0.000,'S',353,'','4','','','N',1,'PESO',10.000,1),
 ('3153','SEPARADOR ALUMINIO (H)','UND.',0.000,'S',354,'','4','','','N',1,'PESO',10.000,1),
 ('3154','PATA PLASTICA PARA BAJO MESADA 15CM','UND.',9.000,'S',355,'','4','','','N',1,'PESO',4.000,1),
 ('3155','PASA CABLE 60 MM GRIS','',4.000,'S',356,'','4','','','N',1,'PESO',5.000,1),
 ('3156','SOPORTE DE ESTANTE 5 MM ZINCADO','UND.',0.000,'S',357,'','4','','','N',1,'PESO',10.000,1),
 ('3157','SOPORTE DE PERCHERO CENTRAL CROMADO','UND.',6.000,'S',358,'','4','','','N',1,'PESO',6.000,1),
 ('3158','SOPORTE DE PERCHERO CROMADO','UND.',4.000,'S',359,'','4','','','N',1,'PESO',80.000,1),
 ('3159','SOPORTE DE PERCHERO PLASTICO PARA CA¾O REDONDO','UND.',0.000,'S',360,'','4','','','N',1,'PESO',10.000,1),
 ('3160','CALESITA GIRATORIA 70CM BLANCA','UND.',554.000,'S',361,'','4','','','N',1,'PESO',10.000,1),
 ('3161','SPOT EMBUTIR CHATO CON MOVIMEINTO DORADO','UND.',0.000,'S',362,'','4','','','N',1,'PESO',10.000,1),
 ('3162','CUBIERTERO DE AC. INOX 363X473 EURO HARD','UND.',1251.000,'S',363,'','4','','','N',1,'PESO',10.000,1),
 ('3163','TAPA TORNILLAS HAYA','UND.',0.000,'S',364,'','4','','','N',1,'PESO',10.000,1),
 ('3164','TAPA TORNILLOS AUTOADHESIVA CEDRO','UND.',0.000,'S',365,'','4','','','N',1,'PESO',10.000,1),
 ('3165','TAPA TORNILLOS AUTOADHESIVA CEREJEIRA','UND.',0.000,'S',366,'','4','','','N',1,'PESO',10.000,1),
 ('3166','TAPA TORNILLOS AUTOADHESIVA GUINDO','UND.',0.000,'S',367,'','4','','','N',1,'PESO',10.000,1),
 ('3167','TAPA TORNILLOS AUTOADHESIVA HAYA','UND.',0.000,'S',368,'','4','','','N',1,'PESO',10.000,1),
 ('3168','TAPA TORNILLOS AUTOADHESIVA NEGRO','UND.',0.000,'S',369,'','4','','','N',1,'PESO',10.000,1),
 ('3169','TAPA TORNILLOS AUTOADHESIVA ROBLE MORO','UND.',0.000,'S',370,'','4','','','N',1,'PESO',10.000,1),
 ('3170','TAPA TORNILLOS AUTOADHESIVA WENGUE','UND.',0.000,'S',371,'','4','','','N',1,'PESO',10.000,1),
 ('3171','TAPA TORNILLOS AUTOADHESIVA BLANCA','CAJA',0.000,'S',372,'','4','','10 PLANCHAS X CAJA, 48 TAPAS X PLANCHA','N',1,'PESO',10.000,1),
 ('3172','TAPA TORNILLOS CREMA','UND.',0.000,'S',373,'','4','','','N',1,'PESO',10.000,1),
 ('3173','TAPA TORNILLOS MARRON OSCURO','UND.',0.000,'S',374,'','4','','','N',1,'PESO',10.000,1),
 ('3174','TAPA TORNILLOS NEGRO','UND.',0.000,'S',375,'','4','','','N',1,'PESO',10.000,1),
 ('3175','TAPA TORNILLOS TABACO','UND.',0.000,'S',376,'','4','','','N',1,'PESO',10.000,1),
 ('3176','TAPA TORNILLOS TOSTADO','UND.',0.000,'S',377,'','4','','','N',1,'PESO',10.000,1),
 ('3177','TAPA TRONILLOS GRIS','UND.',0.000,'S',378,'','4','','','N',1,'PESO',10.000,1),
 ('3178','TAPACANTO CON ESPIGA PUNTERA','UND.',0.000,'S',379,'','4','','','N',1,'PESO',10.000,1),
 ('3179','TAPACANTOS','U',1.000,'S',380,'','4','','','N',1,'PESO',10.000,1),
 ('3180','TAPACANTOS','U',1.000,'S',381,'','4','','','N',1,'PESO',10.000,1),
 ('3181','TARUGO DE MADERA 10 X 30 MM','UND.',0.000,'S',382,'','4','','','N',1,'PESO',10.000,1),
 ('3182','TARUGO DE MADERA 8 X 30 MM','UND.',0.000,'S',383,'','4','','','N',1,'PESO',7504.000,1),
 ('3183','TIJERA COMPASS 150 MM DERECHA','UND.',0.000,'S',384,'','4','','','N',1,'PESO',10.000,1),
 ('3184','TIJERA COMPASS 150 MM IZQUIERDA','UND.',0.000,'S',385,'','4','','','N',1,'PESO',10.000,1),
 ('3185','TIRADOR','F',1.000,'S',386,'','4','','','N',1,'PESO',10.000,1),
 ('3186','TIRADOR ALUMINIO DOMO','UND.',8.000,'S',387,'','4','','','N',1,'PESO',10.000,1),
 ('3187','TIRADOR ALUMINIO INDIKO','UND.',11.000,'S',388,'','4','','','N',1,'PESO',6.000,1),
 ('3188','TIRADOR ALUMINIO IOSSA','UND.',8.000,'S',389,'','4','','','N',1,'PESO',83.000,1),
 ('3189','TIRADOR ALUMINIO LILIUZ','UND.',7.000,'S',390,'','4','','','N',1,'PESO',10.000,1),
 ('3190','TIRADOR ALUMINIO LUSS','UND.',6.000,'S',391,'','4','','','N',1,'PESO',10.000,1),
 ('3191','TIRADOR ALUMINIO ROCA','UND.',12.000,'S',392,'','4','','','N',1,'PESO',10.000,1),
 ('3192','Tirador Bock 116/96','UND.',43.000,'S',393,'','4','','','N',1,'PESO',10.000,1),
 ('3193','Tirador Bock 148/128','UND.',52.000,'S',394,'','4','','','N',1,'PESO',10.000,1),
 ('3194','Tirador Bock 180/160','UND.',62.000,'S',395,'','4','','','N',1,'PESO',10.000,1),
 ('3195','Tirador Bock 212/192','UND.',69.000,'S',396,'','4','','','N',1,'PESO',10.000,1),
 ('3196','Tirador Bock 52/32','UND.',22.000,'S',397,'','4','','','N',1,'PESO',10.000,1),
 ('3197','Tirador Bock 84/64','UND.',33.000,'S',398,'','4','','','N',1,'PESO',10.000,1),
 ('3198','TAPACANTO EBEN','UND.',47.000,'S',399,'','4','','','N',1,'PESO',10.000,1),
 ('3199','Tirador Infinit 116/96','UND.',36.000,'S',400,'','4','','','N',1,'PESO',10.000,1),
 ('3200','Tirador Infinit 148/128','UND.',40.000,'S',401,'','4','','','N',1,'PESO',2.000,1),
 ('3201','Tirador Infinit 180/160','UND.',63.000,'S',402,'','4','','','N',1,'PESO',10.000,1),
 ('3202','Tirador Infinit 212/192','UND.',59.000,'S',403,'','4','','','N',1,'PESO',10.000,1),
 ('3203','Tirador Infinit 52/32','UND.',19.000,'S',404,'','4','','','N',1,'PESO',10.000,1),
 ('3204','Tirador Infinit 84/64','UND.',28.000,'S',405,'','4','','','N',1,'PESO',10.000,1),
 ('3205','TIRADOR J CUADRADA','MTS',249.000,'S',406,'','4','','','N',1,'PESO',10.000,1),
 ('3206','TIRADOR LATERAL ALUMINIO','UND.',0.000,'S',407,'','4','','','N',1,'PESO',10.000,1),
 ('3207','TIRADOR PLASTICO AUTITO','UND.',10.000,'S',408,'','4','','','N',1,'PESO',10.000,1),
 ('3208','TIRADOR PLASTICO OSITO','UND.',10.000,'S',409,'','4','','','N',1,'PESO',10.000,1),
 ('3209','TIRADOR PLASTICO RANA','UND.',10.000,'S',410,'','4','','','N',1,'PESO',10.000,1),
 ('3213','Tirador Scala 212/192','UND.',51.000,'S',411,'','4','','','N',1,'PESO',10.000,1),
 ('3214','Tirador Scala 52/32','UND.',25.000,'S',412,'','4','','','N',1,'PESO',10.000,1),
 ('3215','Tirador Scala 84/64','UND.',30.000,'S',413,'','4','','','N',1,'PESO',10.000,1),
 ('3216','MOLDURA PUERTA EURO MP','UND.',60.000,'S',414,'','4','','','N',1,'PESO',10.000,1),
 ('3217','ZOCALO ALUMINIO 100 EURO Z100','UND.',414.000,'S',415,'','4','','','N',1,'PESO',10.000,1),
 ('3218','ZOCALO ALUMINIO 120 EURO Z120','UND.',491.000,'S',416,'','4','','','N',1,'PESO',10.000,1),
 ('3219','ZOCALO ALUMINIO 150 EURO Z150','UND.',735.000,'S',417,'','4','','','N',1,'PESO',10.000,1),
 ('3220','ZOCALO ALUMINIO 2 X 0.10 M','UND.',0.000,'S',418,'','4','','','N',1,'PESO',10.000,1),
 ('3221','ZOCALO ALUMINIO 3 X 0.10 M','UND.',288.000,'S',419,'','4','','','N',1,'PESO',10.000,1),
 ('3222','ZOCALO CLIP ALUMINIO 0.10X4 M','UND.',415.000,'S',420,'','4','','','N',1,'PESO',10.000,1),
 ('3223','TACHO DE RESIDUOS ACERO INOX. SIMPLE','UND.',502.000,'S',421,'','4','','','N',1,'PESO',14.000,1),
 ('3224','TACHO DE RESIDUOS ACERO INOX. DOBLE','UND.',1464.000,'S',422,'','4','','','N',1,'PESO',2.000,1),
 ('3225','TACHO DE RESIDUOS PLASTICO SIMPLE','UND.',365.000,'S',423,'','4','','','N',1,'PESO',10.000,1),
 ('3226','TACHO DE RESIDUOS PLASTICO DOBLE','UND.',896.000,'S',424,'','4','','','N',1,'PESO',10.000,1),
 ('3227','BISAGRA COMUN 35 MM CODO 18','UND.',5.000,'S',425,'','4','','','N',1,'PESO',28.000,1),
 ('3228','BISAGRA BLUM 35 MM CODO 9','UND.',36.000,'S',426,'','4','','','N',1,'PESO',6.000,1),
 ('3229','BISAGRA BLUM 35 MM CODO 165','UND.',11.000,'S',427,'','4','','','N',1,'PESO',1.000,1),
 ('3230','BISAGRA BLUM 35 MM CODO 0','UND.',29.000,'S',428,'','4','','','N',1,'PESO',16.000,1),
 ('3231','BISAGRA PUSCH 35 MM CODO 0','UND.',14.000,'S',429,'','4','','','N',1,'PESO',5.000,1),
 ('3232','BISAGRA PUSCH 35 MM CODO 9','UND.',14.000,'S',430,'','4','','','N',1,'PESO',3.000,1),
 ('3233','CORREDERA TELESC…PICA 450 MM CIERRE SUAVE','UND.',165.000,'S',431,'','4','','','N',1,'PESO',10.000,1),
 ('3234','CORREDERA TELESC…PICA 350 MM CIERRE SUAVE','UND.',158.000,'S',432,'','4','','','N',1,'PESO',10.000,1),
 ('3235','CORREDERA TELESC…PICA 500 MM PUSCH','UND.',171.000,'S',433,'','4','','','N',1,'PESO',1.000,1),
 ('3236','CORREDERA BLUM TANDEMBOX ANTARO BAJA 500 MM','UND.',1368.000,'S',434,'','4','','','N',1,'PESO',3.000,1),
 ('3237','CORREDERA TELESC…PICA 350 MM PUSCH','UND.',93.000,'S',435,'','4','','','N',1,'PESO',3.000,1),
 ('3238','CORREDERA TELESC…PICA 300 MM PUSCH','UND.',146.000,'S',436,'','4','','','N',1,'PESO',10.000,1),
 ('3239','CORREDERA TELESC…PICA 400 MM CIERRE SUAVE','UND.',117.000,'S',437,'','4','','','N',1,'PESO',10.000,1),
 ('3240','GUIAS CON SISTEMA PUSCH BLUM','UND.',0.000,'S',438,'','4','','','N',1,'PESO',10.000,1),
 ('3241','CORREDERA TELESC…PICA 250 MM PUSCH','UND.',146.000,'S',439,'','4','','','N',1,'PESO',10.000,1),
 ('3242','COLGADOR DE ALACENA NEGRO','UND.',7.000,'S',440,'','4','','','N',1,'PESO',40.000,1),
 ('3243','COLGADOR DE ALACENA MARRON','UND.',6.000,'S',441,'','4','','','N',1,'PESO',3.000,1),
 ('3244','MANIJA EURO SCALA 128MM','UND.',47.000,'S',442,'','4','','','N',1,'PESO',40.000,1),
 ('3245','MANIJA EURO SCALA 96MM','UND.',45.000,'S',443,'','4','','','N',1,'PESO',26.000,1),
 ('3246','MANIJA EURO SCALA 160MM','UND.',57.000,'S',444,'','4','','','N',1,'PESO',10.000,1),
 ('3247','MANIJA BARRAL 320','UND.',54.000,'S',445,'','4','','','N',1,'PESO',1.000,1),
 ('3248','RETEN MINI LATCH PARA PUSCH','UND.',54.000,'S',446,'','4','','','N',1,'PESO',4.000,1),
 ('3249','MANIJA MEDIALUNA PLASTICA','UND.',10.000,'S',447,'','4','','','N',1,'PESO',10.000,1),
 ('3250','PISTON A GAS  60','UND.',19.000,'S',448,'','4','','','N',1,'PESO',1.000,1),
 ('3251','PISTON A GAS  150','UND.',17.000,'S',449,'','4','','','N',1,'PESO',1.000,1),
 ('3252','BRAZO A FRICCI…N','UND.',78.000,'S',450,'','4','','','N',1,'PESO',23.000,1),
 ('3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0','UND.',42.000,'S',451,'','4','','','N',1,'PESO',8.000,1),
 ('3254','AMORTIGUARDOR BLUMOTION (BLUM) CODO 9','UND.',65.000,'S',452,'','4','','','N',1,'PESO',3.000,1),
 ('3255','CORREDERA BLUM TANDEMBOX ANTARO ALTA 500 MM','UND.',1680.000,'S',453,'','4','','','N',1,'PESO',6.000,1),
 ('3256','KIT CORREDIZO SISTEMA PLUS ANCHO GU™A 1.50 MTS','UND.',2188.000,'S',454,'','4','','','N',1,'PESO',10.000,1),
 ('3257','KIT CORREDIZO SISTEMA PLUS ANCHO GU™A 2.00 MTS','UND.',2312.000,'S',455,'','4','','','N',1,'PESO',10.000,1),
 ('3258','KIT CORREDIZO SISTEMA PLUS ANCHO GU™A 3.00 MTS','UND.',2559.000,'S',456,'','4','','','N',1,'PESO',10.000,1),
 ('3259','KIT CORREDIZO SISTEMA PLUS ANCHO GU™A 4.00 MTS','UND.',2807.000,'S',457,'','4','','','N',1,'PESO',10.000,1),
 ('3260','KIT CORREDIZO SISTEMA DF ANCHO GU™A 2.00 MTS','UND.',832.000,'S',458,'','4','','','N',1,'PESO',10.000,1),
 ('3261','KIT CORREDIZO SISTEMA DF ANCHO GU™A 3.00MTS','UND.',0.000,'S',459,'','4','','','N',1,'PESO',10.000,1),
 ('3262','SOPORTE ENTRE PA¾O OCULTO (MENSULA)','UND.',115.000,'S',460,'','4','','','N',1,'PESO',13.000,1),
 ('3263','CORREDERA BLUM TANDEMBOX ANTARO BAJO BACHA ALTA 500 MM','UND.',2045.000,'S',461,'','4','','','N',1,'PESO',10.000,1),
 ('3264','CANASTO 3 NIV. EXTRAIBLE 230MM CROMADO','UND.',803.000,'S',462,'','4','','','N',1,'PESO',3.000,1),
 ('3265','ELEVADOR DE ROPA','UND.',922.000,'S',463,'','4','','','N',1,'PESO',3.000,1),
 ('3266','PERCHA 1 GANCHO ZAMAC','UND.',8.000,'S',464,'','4','','','N',1,'PESO',10.000,1),
 ('3302','ESCUADRA SOPORTE PARA PERFILES GOLA','UND.',21.000,'S',465,'','4','','','N',1,'PESO',43.000,1),
 ('3303','MANIJA TITANIUM 96 MM','UND.',0.000,'S',466,'','4','','','N',1,'PESO',10.000,1),
 ('3304','MENSULA PARA PANEL RANURADO PARA ESTANTE 300MM','UND.',46.000,'S',467,'','4','','','N',1,'PESO',10.000,1),
 ('3305','MENSULA RE 10 CM','UND.',0.000,'S',468,'','4','','','N',1,'PESO',10.000,1),
 ('3306','PASA CABLE 60 MM BLANCO','UND.',4.000,'S',469,'','4','','','N',1,'PESO',10.000,1),
 ('3307','CANASTO 2 NIV. EXTRAIBLE 230MM CROMADO','UND.',745.000,'S',470,'','4','','','N',1,'PESO',1.000,1),
 ('3308','CANASTO 2 NIV. EXTRAIBLE 450MM CROMADO','UND.',1174.000,'S',471,'','4','','','N',1,'PESO',2.000,1),
 ('3309','CANASTO VOLCABLE PARA ROPA 250 MM','UND.',333.000,'S',472,'','4','','','N',1,'PESO',1.000,1),
 ('3310','CORREDERA BLUM TANDEMBOX ANTARO CAJON INTERNO ALTO 500 MM','UND.',1632.000,'S',473,'','4','','','N',1,'PESO',10.000,1),
 ('3311','AVENTO BLUM HF','UND.',2855.000,'S',474,'','4','20180611','','N',1,'PESO',10.000,1),
 ('3312','CONJUNTO LATERAL DOBLE PARED EURO HARD BAJA 500MM','UND.',0.000,'S',475,'','4','','','N',1,'PESO',10.000,1),
 ('3313','VARILLA LED 150 CM 220V BLANCO','UND.',828.000,'S',476,'','4','','','N',1,'PESO',1.000,1),
 ('3314','TIRADOR MANIJA DE CUERO 128 MM','UND.',83.000,'S',477,'','4','','','N',1,'PESO',7.000,1),
 ('3315','TIRADOR DE CUERO 128MM','UND.',70.000,'S',478,'','4','','','N',1,'PESO',10.000,1),
 ('3316','CUBIERTERO DE AC. INOX P/MOD 900','UND.',1714.000,'S',479,'','4','','','N',1,'PESO',10.000,1),
 ('3317','CORREDERA TELESC…PICA 450 MM PUSCH','UND.',106.000,'S',480,'','4','','','N',1,'PESO',2.000,1),
 ('3318','CORREDERA TELESC…PICA 400 MM PUSCH','UND.',109.000,'S',481,'','4','','','N',1,'PESO',2.000,1),
 ('3319','PISO DE ALUMINIO 1.20','UND.',567.000,'S',482,'','4','','','N',1,'PESO',10.000,1),
 ('3320','CANASTO 3 NIV. EXTRAIBLE 450MM CROMADO','UND.',1428.000,'S',483,'','4','','','N',1,'PESO',10.000,1),
 ('3321','SOPORTE ESTANTE EURO SE 18','UND.',423.000,'S',484,'','4','','','N',1,'PESO',10.000,1),
 ('3322','TACHO DE RESIDUOS CUADRADO EXTRAIBLE AC. INOX. 2002','UND.',969.000,'S',485,'','4','','','N',1,'PESO',10.000,1),
 ('3323','COLUMNA EXTRAIBLE','UND.',2276.000,'S',486,'','4','','','N',1,'PESO',10.000,1),
 ('3324','CANASTO P/COLUMNA 350 MM','UND.',355.000,'S',487,'','4','','','N',1,'PESO',10.000,1),
 ('3325','MANIJA MJ 15 EURO','UND.',173.000,'S',488,'','4','','','N',1,'PESO',10.000,1),
 ('3326','MANIJA MJ 18 EURO','UND.',179.000,'S',489,'','4','','','N',1,'PESO',10.000,1),
 ('3327','MANIJA CLASS EURO','UND.',217.000,'S',490,'','4','','','N',1,'PESO',10.000,1),
 ('3328','MANIJA J C/ESPIGA MJE EURO','UND.',272.000,'S',491,'','4','','','N',1,'PESO',10.000,1),
 ('3330','PERFIL MH 18 EURO','UND.',256.000,'S',493,'','4','','','N',1,'PESO',10.000,1),
 ('3331','PERFIL MH 15 EURO','UND.',235.000,'S',494,'','4','','','N',1,'PESO',10.000,1),
 ('3332','SISTEMA GOLA MEDIA','UND.',266.000,'S',495,'','4','','','N',1,'PESO',10.000,1),
 ('3333','SISTEMA GOLA SUPERIOR','UND.',225.000,'S',496,'','4','','','N',1,'PESO',10.000,1),
 ('3334','PERFIL TUBO','UND.',0.000,'S',497,'','4','','','N',1,'PESO',10.000,1),
 ('3337','PERFIL TOP','UND.',0.000,'S',500,'','4','','','N',1,'PESO',10.000,1),
 ('3338','PERFIL ESPEJO/CUADRO','UND.',84.000,'S',501,'','4','','','N',1,'PESO',10.000,1),
 ('3339','PERFIL ESQUINERO','UND.',129.000,'S',502,'','4','','','N',1,'PESO',10.000,1),
 ('3340','PERFIL OVAL','UND.',100.000,'S',503,'','4','','','N',1,'PESO',10.000,1),
 ('3341','PERFIL HV','UND.',0.000,'S',504,'','4','','','N',1,'PESO',10.000,1),
 ('3342','TIRADOR ADHJ','UND.',0.000,'S',505,'','4','','','N',1,'PESO',10.000,1),
 ('3343','TIRADOR ADHR','UND.',0.000,'S',506,'','4','','','N',1,'PESO',10.000,1),
 ('3344','PERFIL FORMA 50','UND.',968.000,'S',507,'','4','','','N',1,'PESO',10.000,1),
 ('3345','TABLA DE PLANCHAR EXRAIBLE HAFELE','UND.',0.000,'S',508,'','4','','','N',1,'PESO',10.000,1),
 ('5000','TORNILLO AUTOPERFORANTE 3.0 X10 MM','UND.',0.000,'S',509,'','5','','','N',1,'PESO',10.000,1),
 ('5001','TORNILLO AUTOPERFORANTE 3.8 X16 MM','UND.',0.000,'S',510,'','5','','CAJA X 20000','N',1,'PESO',10.000,1),
 ('5002','TORNILLO AUTOPERFORANTE 3.8 X19 MM','CAJA',0.000,'S',511,'','5','','CAJA X 15000','N',1,'PESO',10.000,1),
 ('5003','TORNILLO AUTOPERFORANTE 3.8 X25 MM','UND.',0.000,'S',512,'','5','','','N',1,'PESO',10.000,1),
 ('5004','TORNILLO AUTOPERFORANTE 3.8 X32 MM','CAJA',0.000,'S',513,'','5','','CAJA X 8000','N',1,'PESO',10.000,1),
 ('5005','TORNILLO AUTOPERFORANTE 3.8 X41 MM','UND.',0.000,'S',514,'','5','','CAJA POR 5000','N',1,'PESO',10.000,1),
 ('5006','TORNILLO AUTOPERFORANTE 3.8 X50 MM','CAJA',0.000,'S',515,'','5','','CAJA X 3500','N',1,'PESO',10.000,1),
 ('5007','TORNILLO AUTOPERFORANTE 3.8 X57 MM','UND.',0.000,'S',516,'','5','','','N',1,'PESO',10.000,1),
 ('5008','TORNILLO AUTOPERFORANTE 3.8 X70 MM','UND.',1.000,'S',517,'','5','','CAJA X 1500','N',1,'PESO',10.000,1),
 ('5009','TORNILLO AUTOPERFORANTE 4.2 X63 MM','UND.',1.000,'S',518,'','5','','','N',1,'PESO',10.000,1),
 ('5010','TORNILLO AUTOPERFORANTE 4.5 X63 MM','UND.',0.000,'S',519,'','5','','','N',1,'PESO',10.000,1),
 ('5011','TORNILLO AUTOPERFORANTE 8.0 X 50 MM','UND.',0.000,'S',520,'','5','','','N',1,'PESO',10.000,1),
 ('5012','TORNILLO AUTOPERFORANTE PARA CHAPA','UND.',0.000,'S',521,'','5','','','N',1,'PESO',10.000,1),
 ('5013','TIRAFONDO CABEZA HEXAGONAL ZINC 5/16 X 2 3/4','UND.',2.000,'S',522,'','5','','','N',1,'PESO',10.000,1),
 ('5014','TIRAFONDO CABEZA HEXAGONAL ZINC 5/16 X 3 1/4','UND.',2.000,'S',523,'','5','','','N',1,'PESO',10.000,1),
 ('5015','TIRAFONDO CABEZA HEXAGONAL ZINC 5/16 X 4','UND.',2.000,'S',524,'','5','','','N',1,'PESO',10.000,1),
 ('5016','TIRAFONDO CABEZA HEXAGONAL ZINC 5/16 X 3','UND.',2.000,'S',525,'','5','','','N',1,'PESO',10.000,1),
 ('5017','TIRAFONDO CABEZA HEXAGONAL ZINC 5/16 X 2','UND.',2.000,'S',526,'','5','','','N',1,'PESO',10.000,1),
 ('5018','TIRAFONDO CABEZA HEXAGONAL ZINC 5/16 X 5','UND.',2.000,'S',527,'','5','','','N',1,'PESO',10.000,1),
 ('5019','TIRAFONDO CABEZA HEXAGONAL ZINC 5/16 X 3 1/2','UND.',2.000,'S',528,'','5','','','N',1,'PESO',10.000,1),
 ('5020','TIRAFONDO CABEZA HEXAGONAL ZINC 1/4 X 2','UND.',2.000,'S',529,'','5','','','N',1,'PESO',10.000,1),
 ('5021','BULON PARA CAMA 1/4 X 100 LLAVE ALLEN C/TUERCA','UND.',0.000,'S',530,'','5','','','N',1,'PESO',10.000,1),
 ('5022','TACO FISHER 12MM','UND.',1.000,'S',531,'','5','','','N',1,'PESO',65.000,1),
 ('5023','TACO FISHER 10MM','UND.',0.000,'S',532,'','5','','','N',1,'PESO',10.000,1),
 ('5024','TACO FISHER 8MM','UND.',0.000,'S',533,'','5','','','N',1,'PESO',41.000,1),
 ('5025','TACO FISHER 12MM LADRILLO HUECO','UND.',1.000,'S',534,'','5','','','N',1,'PESO',10.000,1),
 ('5026','TACO FISHER 10MM LADRILLO HUECO','UND.',0.000,'S',535,'','5','','','N',1,'PESO',77.000,1),
 ('5027','TACO FISHER 8MM LADRILLO HUECO','UND.',0.000,'S',536,'','5','','','N',1,'PESO',54.000,1),
 ('5028','SILICONA NEUTRA TRANSPARENTE 300 ML','UND.',96.000,'S',537,'','5','','','N',1,'PESO',5.000,1),
 ('5029','ARANDELA PLANA 22 X 8.5 X 2 MM (5/16x0.90-2.00)','UND.',0.000,'S',538,'','5','','','N',1,'PESO',29.000,1),
 ('5030','GRAMPA 90/20','UND.',300.000,'S',539,'','5','','','N',1,'PESO',10.000,1),
 ('5031','GRAMPA 90/30','UND.',300.000,'S',540,'','5','','','N',1,'PESO',10.000,1),
 ('5032','GRAMPA 90/40','UND.',300.000,'S',541,'','5','','','N',1,'PESO',10.000,1),
 ('5033','GRAMPA 71/14 PARA FONDO','UND.',0.000,'S',542,'','5','','','N',1,'PESO',10.000,1),
 ('5034','GRAMPA 84/14 PARA FONDO X 10000','CAJA',0.000,'S',543,'','5','','','N',1,'PESO',1.000,1),
 ('5035','GRAMPA S115 ESPINA','UND.',0.000,'S',544,'','5','','','N',1,'PESO',10.000,1),
 ('5036','GRAMPA S120 ESPINA','UND.',0.000,'S',545,'','5','','','N',1,'PESO',10.000,1),
 ('5037','GRAMPA W09 PARA MESA','UND.',0.000,'S',546,'','5','','','N',1,'PESO',10.000,1),
 ('5038','TOPE AUTOADHESIVO BOMBE (POR PLANCHA)','UND.',0.600,'S',547,'','5','','','N',1,'PESO',1.000,1),
 ('5039','TINNER','UND.',0.000,'S',548,'','5','','','N',1,'PESO',10.000,1),
 ('5040','ADHESIVO CORIAN 50 ML','UND.',280.000,'S',549,'','5','','','N',1,'PESO',8.000,1),
 ('5041','SILICONA ACRILICA','UND.',66.000,'S',550,'','5','','','N',1,'PESO',4.000,1),
 ('5042','SILICONA TRANSPARENTE','UND.',66.000,'S',551,'','5','','','N',1,'PESO',18.000,1),
 ('5043','SILICONA BLANCA','UND.',66.000,'S',552,'','5','','','N',1,'PESO',4.000,1),
 ('5044','SILICONA NEGRA','UND.',66.000,'S',553,'','5','','','N',1,'PESO',10.000,1),
 ('5045','MINI FIX PLACA DE 18 MM','UND.',3.000,'S',554,'','5','','','N',1,'PESO',2539.000,1),
 ('5046','DISCOS DE CORTE','UND.',0.000,'S',555,'','5','','','N',1,'PESO',10.000,1),
 ('5047','LIJAS','UND.',0.000,'S',556,'','5','','','N',1,'PESO',10.000,1),
 ('5048','SIERRAS','UND.',0.000,'S',557,'','5','','','N',1,'PESO',10.000,1),
 ('5049','CART…N','UND.',0.000,'S',558,'','5','','','N',1,'PESO',10.000,1),
 ('5050','CINTA EMBALAJE','UND.',0.000,'S',559,'','5','','','N',1,'PESO',10.000,1),
 ('5051','FILM','UND.',0.000,'S',560,'','5','','','N',1,'PESO',10.000,1),
 ('5052','PUNTA PHILIPS PH1','UND.',10.000,'S',561,'','5','','','N',1,'PESO',10.000,1),
 ('5053','PUNTA PHILIPS PH2','UND.',0.000,'S',562,'','5','','','N',1,'PESO',10.000,1),
 ('5054','LIJA ROLO CHICA','UND.',0.000,'S',563,'','5','','','N',1,'PESO',10.000,1),
 ('5055','LIJA ROLO GRANDE','UND.',0.000,'S',564,'','5','','','N',1,'PESO',10.000,1),
 ('5056','LIJA DISCO AMOLADORA GRANDE','UND.',0.000,'S',565,'','5','','','N',1,'PESO',10.000,1),
 ('5057','LIJA GRANO 120','UND.',15.000,'S',566,'','5','','','N',1,'PESO',10.000,1),
 ('5058','LIJA GRANO 100','UND.',15.000,'S',567,'','5','','','N',1,'PESO',10.000,1),
 ('5059','LIJA GRANO 80','UND.',15.000,'S',568,'','5','','','N',1,'PESO',10.000,1),
 ('5060','LIJA GRANO 60','UND.',15.000,'S',569,'','5','','','N',1,'PESO',10.000,1),
 ('5061','DISCO AMOLADORA CORTE COMUN 7 PULGADAS','UND.',50.000,'S',570,'','5','','','N',1,'PESO',10.000,1),
 ('5062','DISCO AMOLADORA CORTE COMUN 4 1/2 PULGADAS','UND.',50.000,'S',571,'','5','','','N',1,'PESO',10.000,1),
 ('5063','DISCO AMOLADORA DEVASTE 4 1/2 P.','UND.',40.000,'S',572,'','5','','','N',1,'PESO',10.000,1),
 ('5064','DISCO AMOLADORA PARA PULIR VIDRIOS','UND.',150.000,'S',573,'','5','','','N',1,'PESO',10.000,1),
 ('5065','DISCO AMOLADORA DE VIDIA 4 1/2 P.','UND.',150.000,'S',574,'','5','','','N',1,'PESO',10.000,1),
 ('5066','MECHA COMUN 3 MM','UND.',20.000,'S',575,'','5','','','N',1,'PESO',10.000,1),
 ('5067','MECHA COMUN 4.75 MM','UND.',20.000,'S',576,'','5','','','N',1,'PESO',10.000,1),
 ('5068','MECHA VIDIA 6 MM','UND.',80.000,'S',577,'','5','','','N',1,'PESO',10.000,1),
 ('5069','MECHA VIDIA 8 MM','UND.',80.000,'S',578,'','5','','','N',1,'PESO',10.000,1),
 ('5070','MECHA VIDIA 12 MM','UND.',80.000,'S',579,'','5','','','N',1,'PESO',10.000,1),
 ('5071','PORTA COPAS REDONDO','UND.',0.000,'S',580,'','5','','','N',1,'PESO',10.000,1),
 ('5072','PORTA COPAS MEDIALUNA','UND.',250.000,'S',581,'','5','','','N',1,'PESO',10.000,1),
 ('5073','PORTA COPAS RECTO LARGO','UND.',0.000,'S',582,'','5','','','N',1,'PESO',10.000,1),
 ('5074','PORTA COPAS RECTO CORTO','UND.',0.000,'S',583,'','5','','','N',1,'PESO',10.000,1),
 ('5075','STRECH CHICO','UND.',0.000,'S',584,'','5','','','N',1,'PESO',10.000,1),
 ('5076','STRECH GRANDE','UND.',0.000,'S',585,'','5','','','N',1,'PESO',10.000,1),
 ('5077','CINTA STICO ANCHA','UND.',35.000,'S',586,'','5','','','N',1,'PESO',1.000,1),
 ('5078','CINTA DE PAPEL 18 X 50','UND.',30.000,'S',587,'','5','','','N',1,'PESO',10.000,1),
 ('5079','ESPATULAS','UND.',0.000,'S',588,'','5','','','N',1,'PESO',10.000,1),
 ('6000','VIDRIO FLOAT INCOLORO 3MM','M2',661.000,'S',589,'','6','','','N',1,'PESO',10.000,1),
 ('6001','VIDRIO FLOAT INCOLORO 4MM','M2',840.000,'S',590,'','6','','','N',1,'PESO',10.000,1),
 ('6002','VIDRIO FLOAT INCOLORO 5MM','M2',1093.000,'S',591,'','6','','','N',1,'PESO',10.000,1),
 ('6003','VIDRIO FLOAT 10MM','M2',4655.000,'S',592,'','6','','','N',1,'PESO',10.000,1),
 ('6004','VIDRIO PACIFICO 4MM','M2',761.000,'S',593,'','6','','','N',1,'PESO',10.000,1),
 ('6005','VIDRIO GRAPHITE GRIS 4MM','M2',1238.000,'S',594,'','6','','','N',1,'PESO',10.000,1),
 ('6006','ESPEJO INCOLORO 3 MM','M2',1275.000,'S',595,'','6','','','N',1,'PESO',10.000,1),
 ('6007','COVERGLASS NEGRO 5MM','M2',5403.000,'S',596,'','6','','','N',1,'PESO',10.000,1),
 ('6500','PLACA CORIAN 1/2 GLACIER WHITE','PLACA',8572.000,'S',597,'','7','','','N',1,'PESO',1.000,1),
 ('6501','PLACA CORIAN 1/2\' VANILLA','PLACA',8895.000,'S',598,'','7','','','N',1,'PESO',1.000,1),
 ('6502','PLACA CORIAN 1/2\' SILVER GRAY','PLACA',10572.000,'S',599,'','7','','','N',1,'PESO',10.000,1),
 ('6503','PLACA CORIAN 1/2\' CONCRETE','PLACA',12016.000,'S',600,'','7','','','N',1,'PESO',10.000,1),
 ('6504','PLACA CORIAN 1/2\' RICE PAPER','PLACA',12016.000,'S',601,'','7','','','N',1,'PESO',10.000,1),
 ('6505','PLACA CORIAN 1/2\' RAFFIA','PLACA',12016.000,'S',602,'','7','','','N',1,'PESO',10.000,1),
 ('6506','PLACA CORIAN 1/2\' WHISPER','PLACA',12016.000,'S',603,'','7','','','N',1,'PESO',10.000,1),
 ('6507','PLACA CORIAN 1/2\' AURORA','PLACA',10572.000,'S',604,'','7','','','N',1,'PESO',10.000,1),
 ('6508','PLACA CORIAN 1/2\' DOVE','PLACA',12016.000,'S',605,'','7','','','N',1,'PESO',10.000,1),
 ('6509','PLACA CORIAN 1/2\' HOT','PLACA',0.000,'S',606,'','7','','','N',1,'PESO',10.000,1),
 ('6510','PLACA CORIAN 1/2\' MANDARIN','PLACA',0.000,'S',607,'','7','','','N',1,'PESO',10.000,1),
 ('6511','PLACA CORIAN 1/2\' DEEP NOCTORNE','PLACA',12016.000,'S',608,'','7','','','N',1,'PESO',10.000,1),
 ('6512','PLACA CORIAN 1/2\' DEEP MINK','PLACA',12016.000,'S',609,'','7','','','N',1,'PESO',10.000,1),
 ('6513','PLACA CORIAN 1/2\' SUEDE','PLACA',12016.000,'S',610,'','7','','','N',1,'PESO',10.000,1),
 ('6514','PLACA CORIAN 1/2\' DEPP NIGHT SKY','PLACA',12016.000,'S',611,'','7','','','N',1,'PESO',10.000,1),
 ('6515','PLACA CORIAN 1/2\' CLACIER ICE','PLACA',12016.000,'S',612,'','7','','','N',1,'PESO',10.000,1),
 ('6516','PLACA CORIAN 1/2\' RAIN CLOUD','PLACA',12822.000,'S',613,'','7','','','N',1,'PESO',10.000,1),
 ('6517','PLACA CORIAN 1/2\' CLAM SHELL','PLACA',12822.000,'S',614,'','7','','','N',1,'PESO',10.000,1),
 ('6518','PLACA CORIAN 1/4\' GLACIER WHITE','PLACA',0.000,'S',615,'','7','','','N',1,'PESO',10.000,1),
 ('6519','PLACA CORIAN 1/4 VANILLA','PLACA',0.000,'S',616,'','7','','','N',1,'PESO',10.000,1),
 ('6520','PLACA CORIAN 1/4\' CLACIER ICE','PLACA',0.000,'S',617,'','7','','','N',1,'PESO',10.000,1),
 ('6521','PILETA C37-18','UND.',1150.000,'S',618,'','7','','','N',1,'PESO',10.000,1),
 ('6522','PILETA JOHNSON OV440L','UND.',518.000,'S',619,'','7','','','N',1,'PESO',1.000,1),
 ('6523','PILETA LUXOR S185 A','UND.',954.000,'S',620,'','7','','','N',1,'PESO',10.000,1),
 ('6524','PILETA Q 085 A','UND.',2800.000,'S',621,'','7','','','N',1,'PESO',10.000,1),
 ('6525','PILETA AXA D78 A','UND.',2767.000,'S',622,'','7','','','N',1,'PESO',10.000,1),
 ('6526','PILETA JOHNSON LUXOR SI71 A','UND.',1742.000,'S',623,'','7','','','N',1,'PESO',10.000,1),
 ('6527','PILETA JOHNSON C28','UND.',1042.000,'S',624,'','7','','','N',1,'PESO',1.000,1),
 ('6528','PILETA DN1','UND.',2379.000,'S',625,'','7','','','N',1,'PESO',10.000,1),
 ('6529','PILETA JOHNSON Q76','UND.',2190.000,'S',626,'','7','','','N',1,'PESO',10.000,1),
 ('6530','PILETA 0340 LISA','UND.',550.000,'S',627,'','7','','','N',1,'PESO',10.000,1),
 ('6531','PILETA 304 Z 52','UND.',592.000,'S',628,'','7','','','N',1,'PESO',10.000,1),
 ('6532','PILETA 304 O37A','UND.',1073.000,'S',629,'','7','','','N',1,'PESO',10.000,1),
 ('6533','PILETA JOHNSON LN50','UND.',1102.000,'S',630,'','7','','','N',1,'PESO',10.000,1),
 ('6534','PILETA C28/18','UND.',1011.000,'S',631,'','7','','','N',1,'PESO',10.000,1),
 ('6535','PILETA O 250l','UND.',450.000,'S',632,'','7','','','N',1,'PESO',10.000,1),
 ('6536','PILETA C37','UND.',1100.000,'S',633,'','7','','','N',1,'PESO',10.000,1),
 ('1000','FILM STRECH MANIJA 50 CM','UND.',111.000,'S',634,'','2','','','N',1,'PESO',10.000,1),
 ('1001','FILM STRECH BANDITA 10 CM','UND.',31.000,'S',635,'','2','','','N',1,'PESO',10.000,1),
 ('2000','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BLANCO NATURE','MTS',5.000,'S',636,'','3','','','N',1,'PESO',10.000,1),
 ('2001','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM GRIS HUMO','MTS',3.000,'S',637,'','3','','','N',1,'PESO',32.000,1),
 ('2002','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ALMENDRA','MTS',3.000,'S',638,'','3','','','N',1,'PESO',10.000,1);
INSERT INTO `otmateriales` (`codigomat`,`detalle`,`unidad`,`impuni`,`ctrlstock`,`idmate`,`ctacontable`,`linea`,`fbaja`,`observa`,`ocultar`,`idmoneda`,`moneda`,`stockmin`,`idtipomate`) VALUES 
 ('2003','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM HELSINKI','MTS',5.000,'S',639,'','3','','','N',1,'PESO',72.000,1),
 ('2004','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CARVALHO MEZZO','MTS',5.000,'S',640,'','3','','','N',1,'PESO',10.000,1),
 ('2005','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LINOSA CINZA TOUCH','MTS',9.000,'S',641,'','3','','','N',1,'PESO',28.000,1),
 ('2006','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TANGANICA TABACO','MTS',5.000,'S',642,'','3','','','N',1,'PESO',49.000,1),
 ('2007','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE ESPA¾OL','MTS',5.000,'S',643,'','3','','','N',1,'PESO',63.000,1),
 ('2008','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE MORO','MTS',5.000,'S',644,'','3','','','N',1,'PESO',10.000,1),
 ('2009','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE DAKAR/R.D. NATURE','MTS',5.000,'S',645,'','3','','','N',1,'PESO',111.000,1),
 ('2010','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CEREZO','MTS',0.000,'S',646,'','3','','','N',1,'PESO',10.000,1),
 ('2011','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM MAPLE','MTS',5.000,'S',647,'','3','','','N',1,'PESO',10.000,1),
 ('2012','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TEKA ARTICO','MTS',5.000,'S',648,'','3','','','N',1,'PESO',10.000,1),
 ('2013','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM VENEZIA','MTS',5.000,'S',649,'','3','','','N',1,'PESO',9.000,1),
 ('2014','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM NOCCE MILANO','MTS',5.000,'S',650,'','3','','','N',1,'PESO',21.000,1),
 ('2015','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CARVALHO ASERRADO','MTS',5.000,'S',651,'','3','','','N',1,'PESO',28.000,1),
 ('2016','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TERRARUM','MTS',5.000,'S',652,'','3','','','N',1,'PESO',17.000,1),
 ('2017','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE AMERICANO','MTS',5.000,'S',653,'','3','','','N',1,'PESO',9.000,1),
 ('2018','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CEDRO/ CEDRO NATURE','MTS',5.000,'S',654,'','3','','','N',1,'PESO',45.000,1),
 ('2019','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM NOGAL TERRACOTA','MTS',5.000,'S',655,'','3','','','N',1,'PESO',3.000,1),
 ('2020','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM FRESNO ABEDUL','MTS',5.000,'S',656,'','3','','','N',1,'PESO',19.000,1),
 ('2021','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM HAYA','MTS',5.000,'S',657,'','3','','','N',1,'PESO',4.000,1),
 ('2022','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM PERAL','MTS',0.000,'S',658,'','3','','','N',1,'PESO',10.000,1),
 ('2023','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CEDRO MASISA','MTS',0.000,'S',659,'','3','','','N',1,'PESO',10.000,1),
 ('2024','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM WENGUE','MTS',5.000,'S',660,'','3','','','N',1,'PESO',7.000,1),
 ('2025','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BLANCO','MTS',1.000,'S',661,'','3','','','N',1,'PESO',1005.000,1),
 ('2026','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CENIZA','MTS',3.000,'S',662,'','3','','','N',1,'PESO',120.000,1),
 ('2027','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM GRAFITO','MTS',3.000,'S',663,'','3','','','N',1,'PESO',52.000,1),
 ('2028','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM NEGRO','MTS',3.000,'S',664,'','3','','','N',1,'PESO',93.000,1),
 ('2029','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM AZUL LAGO','MTS',3.000,'S',665,'','3','','','N',1,'PESO',10.000,1),
 ('2030','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LILA','MTS',3.000,'S',666,'','3','','','N',1,'PESO',10.000,1),
 ('2031','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM VERDE','MTS',3.000,'S',667,'','3','','','N',1,'PESO',1.000,1),
 ('2032','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM AMARILLO','MTS',3.000,'S',668,'','3','','','N',1,'PESO',10.000,1),
 ('2033','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROJO','MTS',3.000,'S',669,'','3','','','N',1,'PESO',18.000,1),
 ('2034','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ALUMINIO','MTS',5.000,'S',670,'','3','','','N',1,'PESO',3.000,1),
 ('2035','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM SEDA GIORNO','MTS',5.000,'S',671,'','3','','','N',1,'PESO',72.000,1),
 ('2036','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM SEDA NOTTE','MTS',5.000,'S',672,'','3','','','N',1,'PESO',70.000,1),
 ('2037','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LINO CHIARO','MTS',5.000,'S',673,'','3','','','N',1,'PESO',58.000,1),
 ('2038','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LINO TERRA','MTS',5.000,'S',674,'','3','','','N',1,'PESO',61.000,1),
 ('2039','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LINO BLANCO','MTS',3.000,'S',675,'','3','','','N',1,'PESO',23.000,1),
 ('2040','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LINO NEGRO','MTS',3.000,'S',676,'','3','','','N',1,'PESO',5.000,1),
 ('2041','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LITIO','MTS',5.000,'S',677,'','3','','','N',1,'PESO',12.000,1),
 ('2042','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM COBRE','MTS',0.000,'S',678,'','3','','','N',1,'PESO',10.000,1),
 ('2043','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TITANIO','MTS',0.000,'S',679,'','3','','','N',1,'PESO',10.000,1),
 ('2044','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TECA','MTS',5.000,'S',680,'','3','','','N',1,'PESO',18.000,1),
 ('2045','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM SIBERIA','MTS',5.000,'S',681,'','3','','','N',1,'PESO',10.000,1),
 ('2046','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CONCRETO','MTS',5.000,'S',682,'','3','','','N',1,'PESO',45.000,1),
 ('2047','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM NOGAL HABANO','MTS',5.000,'S',683,'','3','','','N',1,'PESO',8.000,1),
 ('2048','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE ESCANDINAVO','MTS',5.000,'S',684,'','3','','','N',1,'PESO',63.000,1),
 ('2049','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM URBAN STREET','MTS',5.000,'S',685,'','3','','','N',1,'PESO',7.000,1),
 ('2050','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM GUINDO','MTS',5.000,'S',686,'','3','','','N',1,'PESO',1.000,1),
 ('2051','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM NOGAL BRIANZA','MTS',5.000,'S',687,'','3','','','N',1,'PESO',10.000,1),
 ('2052','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ENIGMA','MTS',6.000,'S',688,'','3','','','N',1,'PESO',60.000,1),
 ('2053','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM OLMO FINLANDES','MTS',5.000,'S',689,'','3','','','N',1,'PESO',49.000,1),
 ('2054','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BALTICO','MTS',5.000,'S',690,'','3','','','N',1,'PESO',117.000,1),
 ('2055','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM VISON','MTS',5.000,'S',691,'','3','','','N',1,'PESO',10.000,1),
 ('2056','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM LINO','MTS',5.000,'S',692,'','3','','','N',1,'PESO',10.000,1),
 ('2057','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TECA LIMO','MTS',5.000,'S',693,'','3','','','N',1,'PESO',10.000,1),
 ('2058','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE NATURAL','MTS',5.000,'S',694,'','3','','','N',1,'PESO',12.000,1),
 ('2059','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM NEBRASKA','MTS',5.000,'S',695,'','3','','','N',1,'PESO',29.000,1),
 ('2060','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TECA OSLO','MTS',5.000,'S',696,'','3','','','N',1,'PESO',42.000,1),
 ('2061','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM TECA ITALIA','MTS',5.000,'S',697,'','3','','','N',1,'PESO',10.000,1),
 ('2062','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE INGLES','MTS',5.000,'S',698,'','3','','','N',1,'PESO',10.000,1),
 ('2063','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ESMERALDA','MTS',5.000,'S',699,'','3','','','N',1,'PESO',10.000,1),
 ('2064','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM CO¾AC','MTS',5.000,'S',700,'','3','','','N',1,'PESO',10.000,1),
 ('2065','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM AZUL ACERO','MTS',5.000,'S',701,'','3','','','N',1,'PESO',10.000,1),
 ('2066','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ROBLE MIEL','MTS',5.000,'S',702,'','3','','','N',1,'PESO',18.000,1),
 ('2067','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM HELSINKI','MTS',5.000,'S',703,'','3','','','N',1,'PESO',10.000,1),
 ('2200','TAPACANTO PVC P/MAQUINA 22 X 2 MM BLANCO NATURE','MTS',0.000,'S',704,'','3','','','N',1,'PESO',10.000,1),
 ('2201','TAPACANTO PVC P/MAQUINA 22 X 2 MM GRIS HUMO','MTS',9.000,'S',705,'','3','','','N',1,'PESO',10.000,1),
 ('2202','TAPACANTO PVC P/MAQUINA 22 X 2 MM ALMENDRA','MTS',9.000,'S',706,'','3','','','N',1,'PESO',10.000,1),
 ('2203','TAPACANTO PVC P/MAQUINA 22 X 2 MM HELSINKI','MTS',0.000,'S',707,'','3','','','N',1,'PESO',10.000,1),
 ('2204','TAPACANTO PVC P/MAQUINA 22 X 2 MM CARVALHO MEZZO','MTS',0.000,'S',708,'','3','','','N',1,'PESO',10.000,1),
 ('2205','TAPACANTO PVC P/MAQUINA 22 X 2 MM LINOSA CINZA TOUCH','MTS',0.000,'S',709,'','3','','','N',1,'PESO',8.000,1),
 ('2206','TAPACANTO PVC P/MAQUINA 22 X 2 MM TANGANICA TABACO','MTS',0.000,'S',710,'','3','','','N',1,'PESO',6.000,1),
 ('2207','TAPACANTO PVC P/MAQUINA 22 X 2 MM ROBLE ESPA¾OL','MTS',0.000,'S',711,'','3','','','N',1,'PESO',10.000,1),
 ('2208','TAPACANTO PVC P/MAQUINA 22 X 2 MM ROBLE DAKAR','MTS',0.000,'S',712,'','3','','','N',1,'PESO',10.000,1),
 ('2209','TAPACANTO PVC P/MAQUINA 22 X 2 MM ROBLE DAKAR NATURE','MTS',0.000,'S',713,'','3','','','N',1,'PESO',10.000,1),
 ('2210','TAPACANTO PVC P/MAQUINA 22 X 2 MM CEREZO','MTS',0.000,'S',714,'','3','','','N',1,'PESO',10.000,1),
 ('2211','TAPACANTO PVC P/MAQUINA 22 X 2 MM MAPLE','MTS',0.000,'S',715,'','3','','','N',1,'PESO',10.000,1),
 ('2212','TAPACANTO PVC P/MAQUINA 22 X 2 MM TEKA ARTICO','MTS',0.000,'S',716,'','3','','','N',1,'PESO',10.000,1),
 ('2213','TAPACANTO PVC P/MAQUINA 22 X 2 MM VENEZIA','MTS',0.000,'S',717,'','3','','','N',1,'PESO',10.000,1),
 ('2214','TAPACANTO PVC P/MAQUINA 22 X 2 MM NOSSE MILANO','MTS',0.000,'S',718,'','3','','','N',1,'PESO',10.000,1),
 ('2215','TAPACANTO PVC P/MAQUINA 22 X 2 MM CARVALHO ASERRADO','MTS',0.000,'S',719,'','3','','','N',1,'PESO',10.000,1),
 ('2216','TAPACANTO PVC P/MAQUINA 22 X 2 MM TERRARUM','MTS',0.000,'S',720,'','3','','','N',1,'PESO',10.000,1),
 ('2217','TAPACANTO PVC P/MAQUINA 22 X 2 MM ROBLE AMERICANO','MTS',0.000,'S',721,'','3','','','N',1,'PESO',10.000,1),
 ('2218','TAPACANTO PVC P/MAQUINA 22 X 2 MM CEDRO NATURE','MTS',0.000,'S',722,'','3','','','N',1,'PESO',10.000,1),
 ('2219','TAPACANTO PVC P/MAQUINA 22 X 2 MM NOGAL TERRACOTA','MTS',0.000,'S',723,'','3','','','N',1,'PESO',10.000,1),
 ('2220','TAPACANTO PVC P/MAQUINA 22 X 2 MM ABEDUL','MTS',0.000,'S',724,'','3','','','N',1,'PESO',10.000,1),
 ('2221','TAPACANTO PVC P/MAQUINA 22 X 2 MM HAYA','MTS',0.000,'S',725,'','3','','','N',1,'PESO',10.000,1),
 ('2222','TAPACANTO PVC P/MAQUINA 22 X 2 MM PERAL','MTS',0.000,'S',726,'','3','','','N',1,'PESO',10.000,1),
 ('2223','TAPACANTO PVC P/MAQUINA 22 X 2 MM CEDRO','MTS',0.000,'S',727,'','3','','','N',1,'PESO',10.000,1),
 ('2224','TAPACANTO PVC P/MAQUINA 22 X 2 MM EBANO NEGRO','MTS',0.000,'S',728,'','3','','','N',1,'PESO',10.000,1),
 ('2225','TAPACANTO PVC P/MAQUINA 22 X 2 MM BLANCO','MTS',9.000,'S',729,'','3','','','N',1,'PESO',10.000,1),
 ('2226','TAPACANTO PVC P/MAQUINA 22 X 2 MM CENIZA','MTS',0.000,'S',730,'','3','','','N',1,'PESO',10.000,1),
 ('2227','TAPACANTO PVC P/MAQUINA 22 X 2 MM GRAFITO','MTS',12.000,'S',731,'','3','','','N',1,'PESO',25.000,1),
 ('2228','TAPACANTO PVC P/MAQUINA 22 X 2 MM NEGRO','MTS',9.000,'S',732,'','3','','','N',1,'PESO',4.000,1),
 ('2229','TAPACANTO PVC P/MAQUINA 22 X 2 MM AZUL LAGO','MTS',9.000,'S',733,'','3','','','N',1,'PESO',10.000,1),
 ('2230','TAPACANTO PVC P/MAQUINA 22 X 2 MM LILA','MTS',9.000,'S',734,'','3','','','N',1,'PESO',10.000,1),
 ('2231','TAPACANTO PVC P/MAQUINA 22 X 2 MM VERDE','MTS',9.000,'S',735,'','3','','','N',1,'PESO',10.000,1),
 ('2232','TAPACANTO PVC P/MAQUINA 22 X 2 MM MARILLO','MTS',9.000,'S',736,'','3','','','N',1,'PESO',10.000,1),
 ('2233','TAPACANTO PVC P/MAQUINA 22 X 2 MM ROJO','MTS',9.000,'S',737,'','3','','','N',1,'PESO',10.000,1),
 ('2234','TAPACANTO PVC P/MAQUINA 22 X 2 MM ALUMINIO','MTS',9.000,'S',738,'','3','','','N',1,'PESO',5.000,1),
 ('2235','TAPACANTO PVC P/MAQUINA 22 X 2 MM SEDA GIORNO','MTS',0.000,'S',739,'','3','','','N',1,'PESO',4.000,1),
 ('2236','TAPACANTO PVC P/MAQUINA 22 X 2 MM SEDA NOTTE','MTS',0.000,'S',740,'','3','','','N',1,'PESO',10.000,1),
 ('2237','TAPACANTO PVC P/MAQUINA 22 X 2 MM LINO CHIARO','MTS',0.000,'S',741,'','3','','','N',1,'PESO',10.000,1),
 ('2238','TAPACANTO PVC P/MAQUINA 22 X 2 MM LINO TERRA','MTS',0.000,'S',742,'','3','','','N',1,'PESO',11.000,1),
 ('2239','TAPACANTO PVC P/MAQUINA 22 X 2 MM LINO BLANCO','MTS',0.000,'S',743,'','3','','','N',1,'PESO',10.000,1),
 ('2240','TAPACANTO PVC P/MAQUINA 22 X 2 MM LINO NEGRO','MTS',0.000,'S',744,'','3','','','N',1,'PESO',10.000,1),
 ('2241','TAPACANTO PVC P/MAQUINA 22 X 2 MM LITIO','MTS',9.000,'S',745,'','3','','','N',1,'PESO',10.000,1),
 ('2242','TAPACANTO PVC P/MAQUINA 22 X 2 MM COBRE','MTS',9.000,'S',746,'','3','','','N',1,'PESO',10.000,1),
 ('2243','TAPACANTO PVC P/MAQUINA 22 X 2 MM TITANIO','MTS',9.000,'S',747,'','3','','','N',1,'PESO',10.000,1),
 ('2244','TAPACANTO PVC P/MAQUINA 22 X 2 MM TECA','MTS',0.000,'S',748,'','3','','','N',1,'PESO',10.000,1),
 ('2245','TAPACANTO PVC P/MAQUINA 22 X 2 MM SIBERIA','MTS',0.000,'S',749,'','3','','','N',1,'PESO',10.000,1),
 ('2246','TAPACANTO PVC P/MAQUINA 22 X 2 MM CONCRETO','MTS',19.000,'S',750,'','3','','','N',1,'PESO',1.000,1),
 ('2247','TAPACANTO PVC P/MAQUINA 22 X 2 MM NOGAL HABANO','MTS',0.000,'S',751,'','3','','','N',1,'PESO',10.000,1),
 ('2248','TAPACANTO PVC P/MAQUINA 22 X 2 MM ROBLE ESCANDINAVO','MTS',0.000,'S',752,'','3','','','N',1,'PESO',10.000,1),
 ('2282','TAPACANTO PVC P/MAQUINA 22 X 2 MM RAUVISIO BLANCO','MTS',33.000,'S',753,'','3','','','N',1,'PESO',29.000,1),
 ('2400','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM BLANCO NATURE','MTS',0.000,'S',754,'','3','','','N',1,'PESO',10.000,1),
 ('2401','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM GRIS HUMO','MTS',13.000,'S',755,'','3','','','N',1,'PESO',10.000,1),
 ('2402','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ALMENDRA','MTS',13.000,'S',756,'','3','','','N',1,'PESO',10.000,1),
 ('2403','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM HELSINKI','MTS',13.000,'S',757,'','3','','','N',1,'PESO',10.000,1),
 ('2404','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM CARVALHO MEZZO','MTS',13.000,'S',758,'','3','','','N',1,'PESO',10.000,1),
 ('2405','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM LINOSA CINZA TOUCH','MTS',0.000,'S',759,'','3','','','N',1,'PESO',10.000,1),
 ('2406','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM TANGANICA TABACO','MTS',13.000,'S',760,'','3','','','N',1,'PESO',10.000,1),
 ('2407','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ROBLE ESPA¾OL','MTS',0.000,'S',761,'','3','','','N',1,'PESO',10.000,1),
 ('2408','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ROBLE DAKAR','MTS',13.000,'S',762,'','3','','','N',1,'PESO',10.000,1),
 ('2409','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ROBLE DAKAR NATURE','MTS',0.000,'S',763,'','3','','','N',1,'PESO',10.000,1),
 ('2410','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM CEREZO','MTS',0.000,'S',764,'','3','','','N',1,'PESO',10.000,1),
 ('2411','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM MAPLE','MTS',0.000,'S',765,'','3','','','N',1,'PESO',10.000,1),
 ('2412','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM TEKA ARTICO','MTS',0.000,'S',766,'','3','','','N',1,'PESO',10.000,1),
 ('2413','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM VENEZIA VE','MTS',13.000,'S',767,'','3','','','N',1,'PESO',10.000,1),
 ('2414','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM NOSSE MILANO','MTS',13.000,'S',768,'','3','','','N',1,'PESO',10.000,1),
 ('2415','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM CARVALHO ASERRADO','MTS',13.000,'S',769,'','3','','','N',1,'PESO',10.000,1),
 ('2416','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM TERRARUM','MTS',0.000,'S',770,'','3','','','N',1,'PESO',10.000,1),
 ('2417','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ROBLE AMERICANO','MTS',0.000,'S',771,'','3','','','N',1,'PESO',10.000,1),
 ('2418','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM CEDRO NATURE','MTS',0.000,'S',772,'','3','','','N',1,'PESO',10.000,1),
 ('2419','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM NOGAL TERRACOTA','MTS',0.000,'S',773,'','3','','','N',1,'PESO',10.000,1),
 ('2420','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ABEDUL','MTS',0.000,'S',774,'','3','','','N',1,'PESO',10.000,1),
 ('2421','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM HAYA','MTS',0.000,'S',775,'','3','','','N',1,'PESO',10.000,1),
 ('2422','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM PERAL','MTS',0.000,'S',776,'','3','','','N',1,'PESO',10.000,1),
 ('2423','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM CEDRO','MTS',13.000,'S',777,'','3','','','N',1,'PESO',10.000,1),
 ('2424','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM EBANO NEGRO','MTS',0.000,'S',778,'','3','','','N',1,'PESO',10.000,1),
 ('2425','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM BLANCO','MTS',13.000,'S',779,'','3','','','N',1,'PESO',1.000,1),
 ('2426','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM CENIZA','MTS',7.000,'S',780,'','3','','','N',1,'PESO',10.000,1),
 ('2427','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM GRAFITO','MTS',13.000,'S',781,'','3','','','N',1,'PESO',10.000,1),
 ('2428','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM NEGRO','MTS',13.000,'S',782,'','3','','','N',1,'PESO',1.000,1),
 ('2429','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM AZUL LAGO','MTS',13.000,'S',783,'','3','','','N',1,'PESO',10.000,1),
 ('2430','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM LILA','MTS',0.000,'S',784,'','3','','','N',1,'PESO',10.000,1),
 ('2431','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM VERDE','MTS',0.000,'S',785,'','3','','','N',1,'PESO',10.000,1),
 ('2432','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM MARILLO','MTS',0.000,'S',786,'','3','','','N',1,'PESO',10.000,1),
 ('2433','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ROJO','MTS',0.000,'S',787,'','3','','','N',1,'PESO',10.000,1),
 ('2434','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM ALUMINIO','MTS',0.000,'S',788,'','3','','','N',1,'PESO',10.000,1),
 ('2435','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM SEDA GIORNO','MTS',13.000,'S',789,'','3','','','N',1,'PESO',10.000,1),
 ('2436','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM SEDA NOTTE','MTS',13.000,'S',790,'','3','','','N',1,'PESO',10.000,1),
 ('2437','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM LINO CHIARO','MTS',0.000,'S',791,'','3','','','N',1,'PESO',10.000,1),
 ('2438','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM LINO TERRA','MTS',0.000,'S',792,'','3','','','N',1,'PESO',10.000,1),
 ('2439','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM LINO BLANCO','MTS',13.000,'S',793,'','3','','','N',1,'PESO',10.000,1),
 ('2440','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM LINO NEGRO','MTS',0.000,'S',794,'','3','','','N',1,'PESO',10.000,1),
 ('2441','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM LITIO','MTS',0.000,'S',795,'','3','','','N',1,'PESO',10.000,1),
 ('2442','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM COBRE','MTS',0.000,'S',796,'','3','','','N',1,'PESO',10.000,1),
 ('2443','TAPACANTO PVC P/MAQUINA 50 X 0.45 MM TITANIO','MTS',0.000,'S',797,'','3','','','N',1,'PESO',10.000,1),
 ('2600','TAPACANTO PVC P/MAQUINA 50 X 2 MM BLANCO NATURE','MTS',0.000,'S',798,'','3','','','N',1,'PESO',10.000,1),
 ('2601','TAPACANTO PVC P/MAQUINA 50 X 2 MM GRIS HUMO','MTS',0.000,'S',799,'','3','','','N',1,'PESO',10.000,1),
 ('2602','TAPACANTO PVC P/MAQUINA 50 X 2 MM ALMENDRA','MTS',0.000,'S',800,'','3','','','N',1,'PESO',10.000,1),
 ('2603','TAPACANTO PVC P/MAQUINA 50 X 2 MM HELSINKI','MTS',0.000,'S',801,'','3','','','N',1,'PESO',10.000,1),
 ('2604','TAPACANTO PVC P/MAQUINA 50 X 2 MM CARVALHO MEZZO','MTS',0.000,'S',802,'','3','','','N',1,'PESO',10.000,1),
 ('2605','TAPACANTO PVC P/MAQUINA 50 X 2 MM LINOSA CINZA TOUCH','MTS',0.000,'S',803,'','3','','','N',1,'PESO',10.000,1),
 ('2606','TAPACANTO PVC P/MAQUINA 50 X 2 MM TANGANICA TABACO','MTS',0.000,'S',804,'','3','','','N',1,'PESO',10.000,1),
 ('2607','TAPACANTO PVC P/MAQUINA 50 X 2 MM ROBLE ESPA¾OL','MTS',0.000,'S',805,'','3','','','N',1,'PESO',10.000,1),
 ('2608','TAPACANTO PVC P/MAQUINA 50 X 2 MM ROBLE DAKAR','MTS',0.000,'S',806,'','3','','','N',1,'PESO',10.000,1),
 ('2609','TAPACANTO PVC P/MAQUINA 50 X 2 MM ROBLE DAKAR NATURE','MTS',0.000,'S',807,'','3','','','N',1,'PESO',10.000,1),
 ('2610','TAPACANTO PVC P/MAQUINA 50 X 2 MM CEREZO','MTS',0.000,'S',808,'','3','','','N',1,'PESO',10.000,1),
 ('2611','TAPACANTO PVC P/MAQUINA 50 X 2 MM MAPLE','MTS',0.000,'S',809,'','3','','','N',1,'PESO',10.000,1),
 ('2612','TAPACANTO PVC P/MAQUINA 50 X 2 MM TEKA ARTICO','MTS',0.000,'S',810,'','3','','','N',1,'PESO',10.000,1),
 ('2613','TAPACANTO PVC P/MAQUINA 50 X 2 MM VENEZIA VE','MTS',0.000,'S',811,'','3','','','N',1,'PESO',10.000,1),
 ('2614','TAPACANTO PVC P/MAQUINA 50 X 2 MM NOSSE MILANO','MTS',0.000,'S',812,'','3','','','N',1,'PESO',10.000,1),
 ('2615','TAPACANTO PVC P/MAQUINA 50 X 2 MM CARVALHO ASERRADO','MTS',0.000,'S',813,'','3','','','N',1,'PESO',10.000,1),
 ('2616','TAPACANTO PVC P/MAQUINA 50 X 2 MM TERRARUM','MTS',0.000,'S',814,'','3','','','N',1,'PESO',10.000,1),
 ('2617','TAPACANTO PVC P/MAQUINA 50 X 2 MM ROBLE AMERICANO','MTS',0.000,'S',815,'','3','','','N',1,'PESO',10.000,1),
 ('2618','TAPACANTO PVC P/MAQUINA 50 X 2 MM CEDRO NATURE','MTS',0.000,'S',816,'','3','','','N',1,'PESO',10.000,1),
 ('2619','TAPACANTO PVC P/MAQUINA 50 X 2 MM NOGAL TERRACOTA','MTS',0.000,'S',817,'','3','','','N',1,'PESO',10.000,1),
 ('2620','TAPACANTO PVC P/MAQUINA 50 X 2 MM ABEDUL','MTS',0.000,'S',818,'','3','','','N',1,'PESO',10.000,1),
 ('2621','TAPACANTO PVC P/MAQUINA 50 X 2 MM HAYA','MTS',0.000,'S',819,'','3','','','N',1,'PESO',10.000,1),
 ('2622','TAPACANTO PVC P/MAQUINA 50 X 2 MM PERAL','MTS',0.000,'S',820,'','3','','','N',1,'PESO',10.000,1),
 ('2623','TAPACANTO PVC P/MAQUINA 50 X 2 MM CEDRO','MTS',0.000,'S',821,'','3','','','N',1,'PESO',10.000,1),
 ('2624','TAPACANTO PVC P/MAQUINA 50 X 2 MM EBANO NEGRO','MTS',0.000,'S',822,'','3','','','N',1,'PESO',10.000,1),
 ('2625','TAPACANTO PVC P/MAQUINA 50 X 2 MM BLANCO','MTS',0.000,'S',823,'','3','','','N',1,'PESO',10.000,1),
 ('2626','TAPACANTO PVC P/MAQUINA 50 X 2 MM CENIZA','MTS',0.000,'S',824,'','3','','','N',1,'PESO',10.000,1),
 ('2627','TAPACANTO PVC P/MAQUINA 50 X 2 MM GRAFITO','MTS',0.000,'S',825,'','3','','','N',1,'PESO',10.000,1),
 ('2628','TAPACANTO PVC P/MAQUINA 50 X 2 MM NEGRO','MTS',0.000,'S',826,'','3','','','N',1,'PESO',10.000,1),
 ('2629','TAPACANTO PVC P/MAQUINA 50 X 2 MM AZUL LAGO','MTS',0.000,'S',827,'','3','','','N',1,'PESO',10.000,1),
 ('2630','TAPACANTO PVC P/MAQUINA 50 X 2 MM LILA','MTS',0.000,'S',828,'','3','','','N',1,'PESO',10.000,1),
 ('2631','TAPACANTO PVC P/MAQUINA 50 X 2 MM VERDE','MTS',0.000,'S',829,'','3','','','N',1,'PESO',10.000,1),
 ('2632','TAPACANTO PVC P/MAQUINA 50 X 2 MM MARILLO','MTS',0.000,'S',830,'','3','','','N',1,'PESO',10.000,1),
 ('2633','TAPACANTO PVC P/MAQUINA 50 X 2 MM ROJO','MTS',0.000,'S',831,'','3','','','N',1,'PESO',10.000,1),
 ('2634','TAPACANTO PVC P/MAQUINA 50 X 2 MM ALUMINIO','MTS',0.000,'S',832,'','3','','','N',1,'PESO',10.000,1),
 ('2635','TAPACANTO PVC P/MAQUINA 50 X 2 MM SEDA GIORNO','MTS',0.000,'S',833,'','3','','','N',1,'PESO',10.000,1),
 ('2636','TAPACANTO PVC P/MAQUINA 50 X 2 MM SEDA NOTTE','MTS',0.000,'S',834,'','3','','','N',1,'PESO',10.000,1),
 ('2637','TAPACANTO PVC P/MAQUINA 50 X 2 MM LINO CHIARO','MTS',0.000,'S',835,'','3','','','N',1,'PESO',10.000,1),
 ('2638','TAPACANTO PVC P/MAQUINA 50 X 2 MM LINO TERRA','MTS',0.000,'S',836,'','3','','','N',1,'PESO',10.000,1),
 ('2639','TAPACANTO PVC P/MAQUINA 50 X 2 MM LINO BLANCO','MTS',0.000,'S',837,'','3','','','N',1,'PESO',10.000,1),
 ('2640','TAPACANTO PVC P/MAQUINA 50 X 2 MM LINO NEGRO','MTS',0.000,'S',838,'','3','','','N',1,'PESO',10.000,1),
 ('2641','TAPACANTO PVC P/MAQUINA 50 X 2 MM LITIO','MTS',0.000,'S',839,'','3','','','N',1,'PESO',10.000,1),
 ('2642','TAPACANTO PVC P/MAQUINA 50 X 2 MM COBRE','MTS',0.000,'S',840,'','3','','','N',1,'PESO',10.000,1),
 ('2643','TAPACANTO PVC P/MAQUINA 50 X 2 MM TITANIO','MTS',0.000,'S',841,'','3','','','N',1,'PESO',10.000,1),
 ('7000','PLACA KNAUF 9.5 MM','PLACA',0.000,'S',842,'','8','','','N',1,'PESO',10.000,1),
 ('7001','MASILLA LISTA PARA USAR 1.5 KG','UNID.',0.000,'S',843,'','8','','','N',1,'PESO',10.000,1),
 ('7002','MASILLA LISTA PARA USAR 6 KG','UNID.',0.000,'S',844,'','8','','','N',1,'PESO',10.000,1),
 ('7003','MASILLA LISTA PARA USAR 16 KG','UNID.',0.000,'S',845,'','8','','','N',1,'PESO',10.000,1),
 ('7004','MASILLA LISTA PARA USAR 32 KG','UNID.',0.000,'S',846,'','8','','','N',1,'PESO',10.000,1),
 ('7005','CINTA DE PAPEL PARA JUNTA X 75 MTS','UNID.',0.000,'S',847,'','8','','','N',1,'PESO',10.000,1),
 ('7006','CINTA TRAMADA X 90 MTS','UNID.',0.000,'S',848,'','8','','','N',1,'PESO',10.000,1),
 ('7007','BANDA ACUSTICA KNAUF X 3.5 X 70 MM','UNID.',0.000,'S',849,'','8','','','N',1,'PESO',10.000,1),
 ('7008','SOLERA 70 MM','UNID.',0.000,'S',850,'','8','','','N',1,'PESO',10.000,1),
 ('7009','SOLERA 35 MM','UNID.',0.000,'S',851,'','8','','','N',1,'PESO',10.000,1),
 ('7010','MONTANTE 70 MM','UNID.',0.000,'S',852,'','8','','','N',1,'PESO',10.000,1),
 ('7011','MONTANTE 35 MM','UNID.',0.000,'S',853,'','8','','','N',1,'PESO',10.000,1),
 ('2283','TAPACANTO PVC P/MAQUINA 22 X 2 MM ROBLE MIEL','MTS',0.000,'S',854,'','3','','','N',1,'PESO',100.000,1),
 ('2444','TAPACANTO PVC P/MAQUINA 50 X 0,45 MM ROBLE MIEL','MTS',0.000,'S',855,'','3','','','N',1,'PESO',100.000,1),
 ('2445','TAPACANTO PVC P/MAQUINA 50 X 0,45 MM OLMO FINLANDES','MTS',0.000,'S',856,'','3','','','N',1,'PESO',100.000,1),
 ('3335','PATA REDONDA CROMADA 38X100 MM','UND.',0.000,'S',858,'','4','','','N',1,'PESO',100.000,1),
 ('3336','KIT 2 PATINES, 2 RUEDAS','UND.',0.000,'S',859,'','4','','','N',1,'PESO',100.000,1),
 ('3346','VARILLA LED 120 CM 220V BLANCO','UND.',660.000,'S',860,'','4','','','N',1,'PESO',100.000,1),
 ('3347','PLATO GIRATORIO PARA MESA TV','UND.',0.000,'S',861,'','4','','','N',1,'PESO',100.000,1),
 ('3348','CORBATERO PERCHAS MOVILES','UND.',0.000,'S',862,'','4','','','N',1,'PESO',100.000,1),
 ('3349','PATA ACERO (PLASTICA) CR. 80MM. FIJA REDONDA','UND.',0.000,'S',863,'','4','','','N',1,'PESO',100.000,1),
 ('5080','FILM STRECH MANIJA 50 CM','UND.',0.000,'S',864,'','5','','','N',1,'PESO',100.000,1),
 ('5081','FILM STRECH BANDITA 10 CM','UND.',0.000,'S',865,'','5','','','N',1,'PESO',100.000,1),
 ('6537','PILETA 304 HYDRA J107A','UND.',0.000,'S',866,'','7','','','N',1,'PESO',100.000,1),
 ('6538','PILETA 304 R63/18F','UND.',0.000,'S',867,'','7','','','N',1,'PESO',100.000,1),
 ('6539','PILETA 304 LUXOR mini S155A','UND.',0.000,'S',868,'','7','','','N',1,'PESO',100.000,1),
 ('7500','HERRAMIENTA 1','UND.',0.000,'N',869,'','9','','','N',1,'PESO',100.000,1),
 ('7501','HERRAMIENTA 2','UND.',0.000,'N',870,'','9','','','N',1,'PESO',100.000,1),
 ('8000','MANO DE OBRA DISEÑO Y PRESUPUESTO','HORAS',0.000,'N',871,'','10','','','N',1,'PESO',100.000,1),
 ('8001','MANO DE OBRA PRODUCCION','HORAS',0.000,'N',872,'','10','','','N',1,'PESO',100.000,2),
 ('8002','MANO DE OBRA COLOCACIÓN','HORAS',0.000,'N',873,'','10','','','N',1,'PESO',100.000,2),
 ('8003','MANO DE OBRA SERVICIO POSVENTA','HORAS',0.000,'N',874,'','10','','','N',1,'PESO',100.000,1),
 ('8100','ENERGIA ELECTRICA','$/HH',0.000,'N',875,'','11','','','N',1,'PESO',100.000,1),
 ('8150','COMISIÓN VENDEDOR','%/COSTOS',0.000,'N',876,'','11','','','N',1,'PESO',100.000,1),
 ('8200','ENERGIA ELECTRICA','$*HM',25.000,'N',877,'','12','','','N',1,'PESO',0.000,1),
 ('8300','IMPUESTOS','%/COSTO',0.000,'N',879,'','12','','','N',1,'PESO',0.000,1),
 ('8350','GASTOS BANCARIOS','%/COSTO',0.000,'N',880,'','12','','','N',1,'PESO',0.000,1),
 ('8500','CALCO - STICKER MARCA','UND.',10.000,'N',881,'','10','','','N',1,'PESO',0.000,1),
 ('5082','MANIJA ARCO 96 mm BLANCA','UNI.',0.000,'S',882,'','5','','','N',1,'PESO',10.000,1),
 ('8400','GASTOS VARIOS','$/HH',0.000,'N',883,'','12','','','N',1,'PESO',0.000,1),
 ('8450','FLETE','$/KM',0.000,'N',884,'','12','','','N',1,'PESO',0.000,1),
 ('3350','GUIA DE ALUMINIO OFFICE','METRO',40.000,'S',885,'','4','','PRECIO POR METRO','N',1,'PESO',0.000,1),
 ('3351','LAMINA AUTOADHESIVA DE ALUMINIO','MTS',70.000,'S',886,'','4','','','N',1,'PESO',0.000,1),
 ('7800','CONSUMIBLES','%/COSTO',0.000,'S',887,'','9','','','N',3,'EURO',0.000,1),
 ('8250','COMISION VENDEDOR','%/COSTO',0.000,'S',888,'','12','','','N',1,'PESO',0.000,1),
 ('8460','VIATICOS VIAJES','$',0.000,'N',889,'','12','','','N',1,'PESO',0.000,1),
 ('0196','MELAMINA SOBRE MDF 18 MM SANTORINI','PLACA',2150.000,'S',890,'','1','','','N',1,'PESO',10.000,1),
 ('2069','TAPACANTO PVC P/MAQUINA 22 X 2 MM','MTS',12.000,'S',891,'','3','','','N',1,'PESO',100.000,1),
 ('0196','MELAMINA SOBRE MDF 18 MM SANTORINI','PLACA',2150.000,'S',892,'','1','','','N',1,'PESO',10.000,1),
 ('3352','ESCUADRA METALICA STRONG 100 X 150 MM','UNIDAD',41.220,'S',893,'','4','','','N',1,'PESO',10.000,1),
 ('3353','ESCUADRA PLASTICA ARMAMUEBLE','UNIDAD',0.000,'S',894,'','4','','','N',1,'PESO',50.000,1),
 ('3354','TERMINAL GOLA SUPERIOR','UNIDAD',0.000,'S',895,'','4','','','N',1,'PESO',0.000,1),
 ('3355','TERMINAL GOLA INFERIOR','UNIDAD',0.000,'S',896,'','4','','','N',1,'PESO',0.000,1),
 ('6540','PILETA JOHNSON E44/18','UNIDAD',0.000,'S',897,'','7','','','N',1,'PESO',0.000,1),
 ('6541','PILETA JOHNSON R63','UNIDAD',0.000,'S',898,'','7','','','N',1,'PESO',0.000,1),
 ('6542','PILETA JOHNSON R63/18 F','UNIDAD',0.000,'S',899,'','7','','','N',1,'PESO',0.000,1),
 ('3356','ESQUINERO GOLA INFERIOR','UNIDAD',0.000,'S',900,'','4','','','N',1,'PESO',0.000,1),
 ('3357','FICHERO SIMPLE ART. 5041 FARK','UNIDAD',0.000,'S',901,'','4','','','N',1,'PESO',0.000,1),
 ('5100','CALCO - STICKER MARCA','UND',10.000,'S',902,'','5','','','N',1,'PESO',100.000,1),
 ('1266','FIBROPLUS 5.5MM TECA ITALIA MASISA','PLACA',0.000,'S',903,'','2','','','N',1,'PESO',10.000,1),
 ('1267','FIBROPLUS 5.5MM TEKA ARTICO FAPLAC','PLACA',0.000,'S',904,'','2','','','N',1,'PESO',10.000,1),
 ('1268','FIBROPLUS 5.5MM KENIA MASISA','PLACA',0.000,'S',905,'','2','','','N',1,'PESO',10.000,1),
 ('1269','FIBROPLUS  5.5MM NEBRASKA MASISA','PLACA',0.000,'S',906,'','2','','','N',1,'PESO',10.000,1),
 ('1270','FIBROLPUS 5.5MM TECA MASISA','PLACA',0.000,'S',907,'','2','','','N',1,'PESO',10.000,1),
 ('1271','CHAPADUR 3MM BLANCO 3 X 1.20 MTS','PLACA',0.000,'S',908,'','2','','','N',1,'PESO',10.000,1),
 ('0197','MELAMINA SOBRE MDF 18MM MADERA LUSTRE MASISA','PLACA',0.000,'S',909,'','1','','','N',1,'PESO',10.000,1),
 ('0198','MELAMINA SOBRE MDF 18MM TECA TOUCH MASISA','',0.000,'S',910,'','1','','','N',1,'PESO',10.000,1),
 ('0199','MELAMINA SOBRE MDF 18MM ROBLE RUSTICO MASISA','',0.000,'S',911,'','1','','','N',1,'PESO',10.000,1),
 ('0200','MELAMINA SOBRE MDF 18MM FRESNO ABEDUL MASISA','PLACA',0.000,'S',912,'','1','','','N',1,'PESO',10.000,1),
 ('201','MELAMINA SOBRE MDF 18MM OXIDO MASISA','PLACA',0.000,'S',913,'','1','','','N',1,'PESO',10.000,1),
 ('202','MELAMINA SOBRE AGLOMERADO 18MM HELSINKI FAPLAC','PLACA',0.000,'S',914,'','1','','','N',1,'PESO',10.000,1),
 ('6543','PILETA JOHNSON Q76A','UNIDAD',0.000,'S',915,'','7','','','N',1,'PESO',10.000,1),
 ('6544','PILETA JOHNSON R37/18','UNIDAD',0.000,'S',916,'','7','','','N',1,'PESO',10.000,1),
 ('6545','PILETA JOHNSON R63/18CR C/ANTIRREBALSE','UNIDAD',0.000,'S',917,'','7','','','N',1,'PESO',10.000,1),
 ('3358','ESCURREPLATOS JOHNSON ESAC E3','UNIDAD',0.000,'S',918,'','4','','','N',1,'PESO',10.000,1),
 ('0203','MELAMINA SOBRE AGLOMERADO 18MM BALTICO FAPLAC','PLACA',0.000,'S',919,'','1','','','N',1,'PESO',10.000,1),
 ('3359','CERRADURA DE CAJON CUADRADA PUERTAS CORREDIZAS','UND.',0.000,'S',920,'','4','','','N',1,'PESO',10.000,1),
 ('3360','CANASTO SECAPLATOS JOHNSON ACERO LUXOR CASELU','UND.',0.000,'S',921,'','4','','','N',1,'PESO',10.000,1),
 ('3361','CANASTO JOHNSON ACERO E37','UND.',0.000,'S',922,'','4','','','N',1,'PESO',10.000,1),
 ('3362','TABLA JOHNSON DE MADERA LUXOR TALU','UND.',0.000,'S',923,'','4','','','N',1,'PESO',10.000,1),
 ('3363','TABLA DE PICAR JOHNSON DE MADERA E37','UND.',0.000,'S',924,'','4','','','N',1,'PESO',10.000,1),
 ('5101','COLA P/MAQUINA RAKOLL X 15 KG','CAJA',3107.000,'S',925,'','5','','','N',1,'PESO',10.000,1),
 ('6546','DOSIFICADOR APIDO','UNIDAD',3.220,'S',926,'','7','','','N',1,'PESO',4.000,1);
/*!40000 ALTER TABLE `otmateriales` ENABLE KEYS */;


--
-- Definition of table `otmaterialeslep`
--

DROP TABLE IF EXISTS `otmaterialeslep`;
CREATE TABLE `otmaterialeslep` (
  `idotmatelep` int(10) unsigned NOT NULL,
  `codigomat` char(50) NOT NULL,
  `codigolep` char(50) NOT NULL,
  PRIMARY KEY (`idotmatelep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmaterialeslep`
--

/*!40000 ALTER TABLE `otmaterialeslep` DISABLE KEYS */;
INSERT INTO `otmaterialeslep` (`idotmatelep`,`codigomat`,`codigolep`) VALUES 
 (1,'70','FAP-15BC'),
 (2,'89','MAS-18HN'),
 (3,'90','MAS18CJE'),
 (4,'91','MAS-18RM'),
 (5,'92','MAS-18TI'),
 (6,'93','MAS-18FN'),
 (7,'94','MAS-18WG'),
 (8,'95','MAS-18GD'),
 (9,'96','MAS-18FA'),
 (10,'97','MAS-18TE'),
 (11,'98','MAS-18VI'),
 (12,'99','MAS-18NH'),
 (13,'100','MAS-18CM'),
 (14,'101','MAS-18NK'),
 (15,'102','MAS-18TW'),
 (16,'103','MAS-18LI'),
 (17,'104','MAS-18EG'),
 (18,'105','MAS-18TL'),
 (19,'106','MAS-18RT'),
 (20,'107','MAS-18ROA'),
 (21,'108','MAS-18ROB'),
 (22,'109','MAS-18MGLL'),
 (23,'110','MAS-18CCLL'),
 (24,'111','MAS-18ESMLL'),
 (25,'112','MAS-18VO'),
 (26,'113','MAS-18BC'),
 (27,'114','MAS-18AZACLL'),
 (28,'115','MAS-18OA'),
 (29,'116','MAS-18KA'),
 (30,'117','MAS-18SI'),
 (31,'118','MAS-18MC'),
 (32,'119','MAS-18TO'),
 (33,'120','MAS-18LA'),
 (34,'121','MAS-18CE'),
 (35,'122','MAS-18NB'),
 (36,'123','MAS-18RI'),
 (37,'124','MAS-18AM'),
 (38,'125','MAS-18AR'),
 (39,'126','MAS-18CN'),
 (40,'127','MAS-18GH'),
 (41,'128','MAS-18AL'),
 (42,'129','FAP-18NE'),
 (43,'130','MAS-18RJ'),
 (44,'131','MAS-18GG'),
 (45,'134','FAP-18GH'),
 (46,'135','FAP-18AM'),
 (47,'136','MAS-18BCLL'),
 (48,'137','FAP-18CM'),
 (49,'138','FAP-18LZ'),
 (50,'139','FAP-18TT'),
 (51,'140','FAP-18RE'),
 (52,'141','FAP-18RN'),
 (53,'142','FAP_18RDN'),
 (54,'143','MAS-18CZ'),
 (55,'144','MAS-18MP'),
 (56,'145','FAP-18TA'),
 (57,'146','FAP-18VZ'),
 (58,'147','FAP-18CO'),
 (59,'148','FAP-18CA'),
 (60,'149','FAP-18TE'),
 (61,'150','FAP-18RA'),
 (62,'152','MAS-18NO'),
 (63,'153','FAP-18AB'),
 (64,'154','FAP-18HN'),
 (65,'155','FAP-18PN'),
 (66,'156','FAP-18CN'),
 (67,'157','FAP-18EN'),
 (68,'158','FAP-18BC'),
 (69,'159','FAP-18CE'),
 (70,'160','FAP-18GF'),
 (71,'162','FAP-18AG'),
 (72,'163','FAP-18LIL'),
 (73,'164','FAP-18VER'),
 (74,'165','FAP-18AMA'),
 (75,'166','FAP-18AA'),
 (76,'167','FAP-18AL'),
 (77,'168','FAP-18SEG'),
 (78,'169','FAP-18SED'),
 (79,'170','FAP-18LIC'),
 (80,'171','FAP-18LIT'),
 (81,'172','FAP-18LIB'),
 (82,'173','FAP-18LING'),
 (83,'174','FAP-18LT'),
 (84,'175','FAP-18CB'),
 (85,'176','FAP-18TO'),
 (86,'177','FAP-18RELN'),
 (87,'178','FAP-18HKI'),
 (88,'179','FAP-18BLCO'),
 (89,'180','FAP-18OFIN'),
 (90,'181','FAP-18TOS'),
 (91,'182','RAUBRIBLA'),
 (92,'183','RAUBRINEG'),
 (93,'184','RAUBRIBOR'),
 (94,'185','RAUBRICHAM'),
 (95,'186','MDF-18'),
 (96,'187','PRANBL'),
 (97,'195','MAS-18WGE'),
 (98,'1170','FAP-3BC'),
 (99,'1171','FAP-3HN'),
 (100,'1172','MASFIB3CJE'),
 (101,'1173','MASFIB3RM'),
 (102,'1174','MASFIB3TI'),
 (103,'1175','MASFIB3TI'),
 (104,'1176','MASFIB3WG'),
 (105,'1177','MASFIB3GD'),
 (106,'1178','MASFIB3FA'),
 (107,'1179','MASFIB3T'),
 (108,'1181','MASFIB3NH'),
 (109,'1182','MASFIB3NK'),
 (110,'1183','MASFIB3LI'),
 (111,'1184','MASFIB3TW'),
 (112,'1185','MASFIB3LI'),
 (113,'1186','MASFIB3EG'),
 (114,'1187','MASFIB3TL'),
 (115,'1188','MASFIB3RT'),
 (116,'1189','MASFIB3ROA'),
 (117,'1190','MASFIB3ROB'),
 (118,'1191','MASFIB3MGLL'),
 (119,'1192','MASFIB3CCLL'),
 (120,'1193','MASFIB3ESMLL'),
 (121,'1196','MASFIB3AZACLL'),
 (122,'1197','MASFIB3OA'),
 (123,'1198','MASFIB3KA'),
 (124,'1199','MASFIB3SI'),
 (125,'1200','MAS-3MC'),
 (126,'1201','MASFIB3TO'),
 (127,'1202','MASFIB3LA'),
 (128,'1203','MASFIB3CE'),
 (129,'1204','MASFIB3NB'),
 (130,'1205','MASFIB3RI'),
 (131,'1206','MASFIB3AM'),
 (132,'1207','MASFIB3AR'),
 (133,'1209','MASFIB3GH'),
 (134,'1210','MASFIB3AL'),
 (135,'1211','FAP-3NE'),
 (136,'1212','MASFIB3RJ'),
 (137,'1213','MASFIB3GG'),
 (138,'1215','FAP-3GH'),
 (139,'1216','FAP-3AM2'),
 (140,'1217','MASFIB3BCLL'),
 (141,'1218','FAP-3CM'),
 (142,'1219','FAP-3LZ'),
 (143,'1220','FAP-3TT'),
 (144,'1221','FAP-3RE'),
 (145,'1222','FAP-3RN'),
 (146,'1224','FAP-3CR'),
 (147,'1227','FAP-3VZ'),
 (148,'1228','FAP-3CO'),
 (149,'1229','FAP-3CA'),
 (150,'1230','FAP-3TE'),
 (151,'1231','FAP-3RA'),
 (152,'1232','FAP-3CN'),
 (153,'1233','FAP-5NE'),
 (154,'1234','FAP-3AB'),
 (155,'1235','FAP-3HN'),
 (156,'1236','FAP-3PN'),
 (157,'1240','FAP-3CE'),
 (158,'1241','FAP-3GF'),
 (159,'1242','FAP-3AG'),
 (160,'1243','FAP-3LIL'),
 (161,'1244','FAP-3VER'),
 (162,'1245','FAP-3AMA'),
 (163,'1246','FAP-3AA'),
 (164,'1247','FAP-3AL'),
 (165,'1248','FAP-3SEG'),
 (166,'1249','FAP-3SED'),
 (167,'1250','FAP-3LIC'),
 (168,'1251','FAP-3LIT'),
 (169,'1254','FAP-3LT'),
 (170,'1255','FAP-3CB'),
 (171,'1256','FAP-3TO'),
 (172,'3002','BHAF165'),
 (173,'3007','BHAFC0'),
 (174,'3008','BHAFC9'),
 (175,'3037','TEL-HAF250'),
 (176,'3038','TEL-PB300'),
 (177,'3038','TEL-HAF300'),
 (178,'3039','TEL-PB350'),
 (179,'3039','TEL-HAF350'),
 (180,'3041','TEL-IQPB400'),
 (181,'3041','TEL-HAF400'),
 (182,'3042','TEL-HAF450'),
 (183,'3042','TEL-IQ450M'),
 (184,'3042','TEL-IQPB450'),
 (185,'3042','TELPBGW'),
 (186,'3042','TEL-ST450'),
 (187,'3042','TEL-GREN450M'),
 (188,'3043','TEL-IQ500'),
 (189,'3043','TEL-IQPB500'),
 (190,'3043','TEL-HAF500'),
 (191,'3044','TEL-GRECS50'),
 (192,'3066','CL150'),
 (193,'3067','CL200'),
 (194,'3068','CL300'),
 (195,'3069','CL400'),
 (196,'3086','BRECTO128'),
 (197,'3090','BRECTO096'),
 (198,'3102','TITANIUM160'),
 (199,'3112','REGATON'),
 (200,'3182','TAR8X30'),
 (201,'3244','SC148'),
 (202,'3245','SC116'),
 (203,'3246','SC180'),
 (204,'3264','CANEXT233N'),
 (205,'3307','CANEXT232N'),
 (206,'3319','30115ACC'),
 (207,'6001','FLOAT'),
 (208,'6003','FLOAT10'),
 (209,'6004','PACIFIC'),
 (210,'6005','GRAPHITE'),
 (211,'6006','ESPEJO3'),
 (212,'2001','RECM5779_18'),
 (213,'2002','RECM7292_18'),
 (214,'2003','FFAP-18HKI'),
 (215,'2004','RECM7710_18'),
 (216,'2005','RECM7910_18'),
 (217,'2006','FFAP-18TGT'),
 (218,'2007','RERD350S_18'),
 (219,'2008','RECM6810_18'),
 (220,'2009','RECM2212_18'),
 (221,'2010','RECM4275_18'),
 (222,'2011','RECM4290_18'),
 (223,'2012','FFAP-18TKA'),
 (224,'2013','RECM0903_18'),
 (225,'2014','RECM8010_18'),
 (226,'2015','RECM0972_18'),
 (227,'2016','RECM1161_18'),
 (228,'2017','FFAP-18RA'),
 (229,'2018','RECM4276_18'),
 (230,'2019','TMAS-18NO'),
 (231,'2020','FMAS-18FA'),
 (232,'2021','FFAP-18HN'),
 (233,'2022','RECM4449_18'),
 (234,'2023','RECM2376_18'),
 (235,'2024','RERD9838_18'),
 (236,'2025','RECM0725_18'),
 (237,'2026','RECM5789_18'),
 (238,'2027','RECM5778_18'),
 (239,'2028','RECM7836_18'),
 (240,'2029','FFAP-18AG'),
 (241,'2030','RECM0707_18'),
 (242,'2031','RECM0526_18'),
 (243,'2032','RERU74614_18'),
 (244,'2033','FFAP-18ROJ'),
 (245,'2034','RERD094L_18'),
 (246,'2035','RECM0977_18'),
 (247,'2036','RECM0978_18'),
 (248,'2037','T-FAPLIC18'),
 (249,'2038','T-FAPLIT18'),
 (250,'2041','RECM4021_18'),
 (251,'2042','RECM4022_18'),
 (252,'2043','RECM4023_18'),
 (253,'2044','RECMF7001_18'),
 (254,'2045','TMAS-18SI'),
 (255,'2046','TMAS-18CM'),
 (256,'2047','RECM2389_18'),
 (257,'2048','FFAP-18RELN'),
 (258,'2049','TAP-PVCSTREE'),
 (259,'2050','RERD8502_18'),
 (260,'2051','RECM2367_18'),
 (261,'2052','TMAS-18EG'),
 (262,'2053','FFAP-18OFIN'),
 (263,'2054','FFAP-18BLCO'),
 (264,'2055','TMAS-18VILL'),
 (265,'2056','TMAS-18LI'),
 (266,'2057','TMAS-18TL'),
 (267,'2058','RERD175S_18'),
 (268,'2059','TMAS-18NK'),
 (269,'2060','FFPA-18TOS'),
 (270,'2061','RECM6410T_18'),
 (271,'2062','TMAS-18RI'),
 (272,'2063','TMAS-18ESMLL'),
 (273,'2064','TMAS-18CCLL'),
 (274,'2065','TMAS-18AZACL'),
 (275,'2066','TAP-PVCRM0.4'),
 (276,'2207','RERD350S_182'),
 (277,'2208','PVCRD2MM'),
 (278,'2210','RERD6399_18'),
 (279,'2211','RERD4851_18'),
 (280,'2213','RERD406S_18'),
 (281,'2214','RERD245S_18'),
 (282,'2216','RERD185S_18'),
 (283,'2217','RERD719L_18'),
 (284,'2218','RERD6797_18'),
 (285,'2221','RERD4713_18'),
 (286,'2222','RERD6400_18'),
 (287,'2223','RERD6186_18'),
 (288,'2225','TAPBL2MM'),
 (289,'2226','TMAS-18CN'),
 (290,'2227','TMAS-18GG'),
 (291,'2228','FFAP-NG2'),
 (292,'2234','RERD5516_18'),
 (293,'2235','RERD408S_18'),
 (294,'2236','RERD407S_18'),
 (295,'2238','T-FAPLIT182M'),
 (296,'2241','RERD511S_18'),
 (297,'2243','RERD513S_18'),
 (298,'2246','TMAS-18CM2'),
 (299,'2247','RERD730L_18');
/*!40000 ALTER TABLE `otmaterialeslep` ENABLE KEYS */;


--
-- Definition of table `otmaterialespro`
--

DROP TABLE IF EXISTS `otmaterialespro`;
CREATE TABLE `otmaterialespro` (
  `idotmatepro` int(10) unsigned NOT NULL,
  `codigomat` char(50) NOT NULL,
  `codigopro` char(50) NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idotmatepro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmaterialespro`
--

/*!40000 ALTER TABLE `otmaterialespro` DISABLE KEYS */;
INSERT INTO `otmaterialespro` (`idotmatepro`,`codigomat`,`codigopro`,`idmate`,`entidad`) VALUES 
 (1,'140','+2235',0,0),
 (2,'187','+2395',0,0),
 (3,'100','+2960',0,0),
 (4,'3111','+3018',0,0),
 (5,'152','+3262',0,0),
 (6,'5016','+3476',0,0),
 (7,'179','+3505',0,0),
 (8,'180','+3515',0,0),
 (9,'1239','+3705',0,0),
 (10,'5042','+20001',0,0),
 (11,'3182','+57025',0,0),
 (12,'92','+73420',0,0),
 (13,'1211','+73730',0,0),
 (14,'5042','+150019',0,0),
 (15,'5044','+150023',0,0),
 (16,'5028','+150028',0,0),
 (17,'5022','+160013',0,0),
 (18,'5025','+160115',0,0),
 (19,'5024','+160117',0,0),
 (20,'5042','+200001',0,0),
 (21,'5043','+200004',0,0),
 (22,'3156','+304009',0,0),
 (23,'3156','+304010',0,0),
 (24,'195','+354469',0,0),
 (25,'2005','+800485',0,0),
 (26,'5016','+900000',0,0),
 (27,'5015','+900000',0,0),
 (28,'3141','+1012015',0,0),
 (29,'3007','+1271300',0,0),
 (30,'3022','+1611002',0,0),
 (31,'3090','+2623001',0,0),
 (32,'3086','+2623002',0,0),
 (33,'3086','+2623005',0,0),
 (34,'3201','+4220005',0,0),
 (35,'3039','+4301003',0,0),
 (36,'3032','+4301004',0,0),
 (37,'3033','+4301005',0,0),
 (38,'3037','+4301009',0,0),
 (39,'3041','+4301012',0,0),
 (40,'3239','+4301021',0,0),
 (41,'3044','+4301023',0,0),
 (42,'3318','+4301031',0,0),
 (43,'3317','+4301032',0,0),
 (44,'3008','+4302002',0,0),
 (45,'3227','+4302003',0,0),
 (46,'3158','+5506008',0,0),
 (47,'3243','+6901018',0,0),
 (48,'3242','+6901018',0,0),
 (49,'3027','+6901018',0,0),
 (50,'3154','+7701002',0,0),
 (51,'5038','+9107023',0,0),
 (52,'3046','+9502002',0,0),
 (53,'3047','+9502003',0,0),
 (54,'3046','+9502003',0,0),
 (55,'3047','+9502004',0,0),
 (56,'3048','+9502006',0,0),
 (57,'3309','+9503001',0,0),
 (58,'3054','+9503002',0,0),
 (59,'3111','+9504004',0,0),
 (60,'3160','+9506004',0,0),
 (61,'3223','+9508001',0,0),
 (62,'3224','+9508003',0,0),
 (63,'3322','+9508004',0,0),
 (64,'3307','+9512002',0,0),
 (65,'3308','+9512003',0,0),
 (66,'3264','+9512004',0,0),
 (67,'3320','+9512004',0,0),
 (68,'3264','+9512005',0,0),
 (69,'3320','+9512005',0,0),
 (70,'3265','+11411003',0,0),
 (71,'3143','+11501004',0,0),
 (72,'3039','+12706003',0,0),
 (73,'3003','+12712010',0,0),
 (74,'3008','+12713002',0,0),
 (75,'3002','+12713004',0,0),
 (76,'3010','+12713005',0,0),
 (77,'3004','+12713011',0,0),
 (78,'3252','+12714002',0,0),
 (79,'3182','+13906005',0,0),
 (80,'3266','+16702003',0,0),
 (81,'3096','+18406001',0,0),
 (82,'3265','+21505003',0,0),
 (83,'5045','+26226034',0,0),
 (84,'3111','+26228679',0,0),
 (85,'3262','+28333904',0,0),
 (86,'3236','+57 euros c/u',0,0),
 (87,'1170','+07/003706',0,0),
 (88,'97','+jul-60',0,0),
 (89,'150','+jul-60',0,0),
 (90,'104','+jul-00',0,0),
 (91,'101','+jul-65',0,0),
 (92,'189','+jul-85',0,0),
 (93,'1170','+jul-06',0,0),
 (94,'1211','+jul-30',0,0),
 (95,'2227','+08/02310',0,0),
 (96,'182','+08/412294',0,0),
 (97,'182','+08/90005',0,0),
 (98,'183','+08/90010',0,0),
 (99,'182','+ago-05',0,0),
 (100,'2282','+08/95005',0,0),
 (101,'3047','+10102001',0,0),
 (102,'3009','+10102001',0,0),
 (103,'3026','+11047',0,0),
 (104,'3265','+11411003',0,0),
 (105,'3002','+12713004',0,0),
 (106,'3182','+13906005',0,0),
 (107,'3182','+13906006',0,0),
 (108,'3112','+5607002',0,0),
 (109,'3112','+17303003',0,0),
 (110,'5043','+20809002',0,0),
 (111,'159','+22/1700',0,0),
 (112,'158','+22/1731',0,0),
 (113,'159','+22/1781',0,0),
 (114,'175','+22/1820',0,0),
 (115,'160','+22/1826',0,0),
 (116,'134','+22/1845',0,0),
 (117,'174','+22/1855',0,0),
 (118,'129','+22/1860',0,0),
 (119,'166','+22/1870',0,0),
 (120,'156','+22/2125',0,0),
 (121,'144','+22/2190',0,0),
 (122,'150','+22/2212',0,0),
 (123,'140','+22/2236',0,0),
 (124,'139','+22/2246',0,0),
 (125,'137','+22/3145',0,0),
 (126,'148','+22/3150',0,0),
 (127,'138','+22/3230',0,0),
 (128,'147','+22/3250',0,0),
 (129,'152','+22/3262',0,0),
 (130,'150','+22/3270',0,0),
 (131,'142','+22/3290',0,0),
 (132,'142','+22/3291',0,0),
 (133,'141','+22/3291',0,0),
 (134,'145','+22/3310',0,0),
 (135,'149','+22/3315',0,0),
 (136,'146','+22/3320',0,0),
 (137,'172','+22/3420',0,0),
 (138,'170','+22/3430',0,0),
 (139,'170','+22/3431',0,0),
 (140,'171','+22/3450',0,0),
 (141,'171','+22/3451',0,0),
 (142,'168','+22/3460',0,0),
 (143,'169','+22/3470',0,0),
 (144,'169','+22/3471',0,0),
 (145,'179','+22/3506',0,0),
 (146,'178','+22/3510',0,0),
 (147,'180','+22/3515',0,0),
 (148,'177','+22/3520',0,0),
 (149,'190','+22/3610',0,0),
 (150,'3090','+2623001',0,0),
 (151,'3086','+2623002',0,0),
 (152,'3111','+3018',0,0),
 (153,'3244','+35212',0,0),
 (154,'3245','+35525',0,0),
 (155,'3038','+4301010',0,0),
 (156,'3043','+4301014',0,0),
 (157,'3158','+5506008',0,0),
 (158,'3242','+6901018',0,0),
 (159,'3027','+6901018',0,0),
 (160,'3255','+70 euros c/u',0,0),
 (161,'3319','+700-120',0,0),
 (162,'3083','+7217001',0,0),
 (163,'3084','+7217002',0,0),
 (164,'3154','+7701002',0,0),
 (165,'3001','+7702002',0,0),
 (166,'5045','+77089',0,0),
 (167,'5045','+77091',0,0),
 (168,'3046','+9502003',0,0),
 (169,'3048','+9502006',0,0),
 (170,'3111','+9504004',0,0),
 (171,'3223','+9508001',0,0),
 (172,'3224','+9508003',0,0),
 (173,'3307','+9512002',0,0),
 (174,'3264','+9512004',0,0),
 (175,'3082','+bar01cwar',0,0),
 (176,'3074','+BAR02CWAR',0,0),
 (177,'3313','+bar03cwar',0,0),
 (178,'3015','+BB',0,0),
 (179,'3192','+BC116',0,0),
 (180,'3193','+BC148',0,0),
 (181,'3162','+C600/700I',0,0),
 (182,'3066','+CL150',0,0),
 (183,'3067','+CL200',0,0),
 (184,'3068','+CL300',0,0),
 (185,'3069','+CL400',0,0),
 (186,'3103','+CLH',0,0),
 (187,'3103','+CLH',0,0),
 (188,'3314','+CM2.128M',0,0),
 (189,'3315','+CR2.30M',0,0),
 (190,'3119','+CTJ1',0,0),
 (191,'6500','+D11803513',0,0),
 (192,'6519','+D11972920',0,0),
 (193,'3316','+EHC900',0,0),
 (194,'3037','+EHCT25B',0,0),
 (195,'3306','+EHEPCC60B',0,0),
 (196,'3114','+EHEPCC60N',0,0),
 (197,'3132','+EM18',0,0),
 (198,'3055','+ES2045',0,0),
 (199,'3344','+F50-T50',0,0),
 (200,'10000','+Formula1',0,0),
 (201,'6532','+Formula1',0,0),
 (202,'6527','+Formula1',0,0),
 (203,'6526','+Formula1',0,0),
 (204,'6523','+Formula1',0,0),
 (205,'6522','+Formula1',0,0),
 (206,'5045','+Formula1',0,0),
 (207,'5044','+Formula1',0,0),
 (208,'5042','+Formula1',0,0),
 (209,'5028','+Formula1',0,0),
 (210,'5016','+Formula1',0,0),
 (211,'3315','+Formula1',0,0),
 (212,'3314','+Formula1',0,0),
 (213,'3313','+Formula1',0,0),
 (214,'3312','+Formula1',0,0),
 (215,'3266','+Formula1',0,0),
 (216,'3265','+Formula1',0,0),
 (217,'3264','+Formula1',0,0),
 (218,'3255','+Formula1',0,0),
 (219,'3252','+Formula1',0,0),
 (220,'3244','+Formula1',0,0),
 (221,'3243','+Formula1',0,0),
 (222,'3242','+Formula1',0,0),
 (223,'3237','+Formula1',0,0),
 (224,'3236','+Formula1',0,0),
 (225,'3227','+Formula1',0,0),
 (226,'3224','+Formula1',0,0),
 (227,'3223','+Formula1',0,0),
 (228,'3205','+Formula1',0,0),
 (229,'3201','+Formula1',0,0),
 (230,'3200','+Formula1',0,0),
 (231,'3182','+Formula1',0,0),
 (232,'3158','+Formula1',0,0),
 (233,'3156','+Formula1',0,0),
 (234,'3141','+Formula1',0,0),
 (235,'3124','+Formula1',0,0),
 (236,'3111','+Formula1',0,0),
 (237,'3103','+Formula1',0,0),
 (238,'3074','+Formula1',0,0),
 (239,'3068','+Formula1',0,0),
 (240,'3067','+Formula1',0,0),
 (241,'3066','+Formula1',0,0),
 (242,'3055','+Formula1',0,0),
 (243,'3048','+Formula1',0,0),
 (244,'3047','+Formula1',0,0),
 (245,'3046','+Formula1',0,0),
 (246,'3043','+Formula1',0,0),
 (247,'3042','+Formula1',0,0),
 (248,'3008','+Formula1',0,0),
 (249,'3003','+Formula1',0,0),
 (250,'3002','+Formula1',0,0),
 (251,'1239','+Formula1',0,0),
 (252,'187','+Formula1',0,0),
 (253,'180','+Formula1',0,0),
 (254,'179','+Formula1',0,0),
 (255,'171','+Formula1',0,0),
 (256,'158','+Formula1',0,0),
 (257,'152','+Formula1',0,0),
 (258,'149','+Formula1',0,0),
 (259,'148','+Formula1',0,0),
 (260,'140','+Formula1',0,0),
 (261,'100','+Formula1',0,0),
 (262,'10001','+Formula1',0,0),
 (263,'6529','+Formula1',0,0),
 (264,'6525','+Formula1',0,0),
 (265,'6524','+Formula1',0,0),
 (266,'5022','+Formula1',0,0),
 (267,'3311','+Formula1',0,0),
 (268,'3310','+Formula1',0,0),
 (269,'3304','+Formula1',0,0),
 (270,'3302','+Formula1',0,0),
 (271,'3263','+Formula1',0,0),
 (272,'3262','+Formula1',0,0),
 (273,'3254','+Formula1',0,0),
 (274,'3253','+Formula1',0,0),
 (275,'3230','+Formula1',0,0),
 (276,'3127','+Formula1',0,0),
 (277,'3119','+Formula1',0,0),
 (278,'3078','+Formula1',0,0),
 (279,'3041','+Formula1',0,0),
 (280,'3039','+Formula1',0,0),
 (281,'3038','+Formula1',0,0),
 (282,'3034','+Formula1',0,0),
 (283,'3027','+Formula1',0,0),
 (284,'3022','+Formula1',0,0),
 (285,'3021','+Formula1',0,0),
 (286,'3007','+Formula1',0,0),
 (287,'3001','+Formula1',0,0),
 (288,'1246','+Formula1',0,0),
 (289,'1240','+Formula1',0,0),
 (290,'1211','+Formula1',0,0),
 (291,'1170','+Formula1',0,0),
 (292,'194','+Formula1',0,0),
 (293,'193','+Formula1',0,0),
 (294,'191','+Formula1',0,0),
 (295,'190','+Formula1',0,0),
 (296,'189','+Formula1',0,0),
 (297,'188','+Formula1',0,0),
 (298,'186','+Formula1',0,0),
 (299,'183','+Formula1',0,0),
 (300,'182','+Formula1',0,0),
 (301,'181','+Formula1',0,0),
 (302,'178','+Formula1',0,0),
 (303,'177','+Formula1',0,0),
 (304,'174','+Formula1',0,0),
 (305,'173','+Formula1',0,0),
 (306,'172','+Formula1',0,0),
 (307,'170','+Formula1',0,0),
 (308,'168','+Formula1',0,0),
 (309,'160','+Formula1',0,0),
 (310,'159','+Formula1',0,0),
 (311,'157','+Formula1',0,0),
 (312,'154','+Formula1',0,0),
 (313,'147','+Formula1',0,0),
 (314,'146','+Formula1',0,0),
 (315,'142','+Formula1',0,0),
 (316,'139','+Formula1',0,0),
 (317,'138','+Formula1',0,0),
 (318,'137','+Formula1',0,0),
 (319,'135','+Formula1',0,0),
 (320,'134','+Formula1',0,0),
 (321,'133','+Formula1',0,0),
 (322,'129','+Formula1',0,0),
 (323,'123','+Formula1',0,0),
 (324,'120','+Formula1',0,0),
 (325,'115','+Formula1',0,0),
 (326,'113','+Formula1',0,0),
 (327,'99','+Formula1',0,0),
 (328,'93','+Formula1',0,0),
 (329,'91','+Formula1',0,0),
 (330,'195','+Formula1',0,0),
 (331,'3075','+Formula1',0,0),
 (332,'3319','+Formula1',0,0),
 (333,'5025','+Formula1',0,0),
 (334,'141','+Formula1',0,0),
 (335,'169','+Formula1',0,0),
 (336,'3317','+Formula1',0,0),
 (337,'3044','+Formula1',0,0),
 (338,'3316','+Formula1',0,0),
 (339,'3069','+Formula1',0,0),
 (340,'3154','+Formula1',0,0),
 (341,'3239','+Formula1',0,0),
 (342,'3318','+Formula1',0,0),
 (343,'3090','+Formula1',0,0),
 (344,'3086','+Formula1',0,0),
 (345,'3160','+Formula1',0,0),
 (346,'3112','+Formula1',0,0),
 (347,'3037','+Formula1',0,0),
 (348,'2227','+Formula1',0,0),
 (349,'3306','+Formula1',0,0),
 (350,'3114','+Formula1',0,0),
 (351,'3162','+Formula1',0,0),
 (352,'2025','+Formula1',0,0),
 (353,'2040','+Formula1',0,0),
 (354,'2037','+Formula1',0,0),
 (355,'2034','+Formula1',0,0),
 (356,'2035','+Formula1',0,0),
 (357,'2036','+Formula1',0,0),
 (358,'3054','+Formula1',0,0),
 (359,'3309','+Formula1',0,0),
 (360,'145','+Formula1',0,0),
 (361,'3308','+Formula1',0,0),
 (362,'3320','+Formula1',0,0),
 (363,'3010','+Formula1',0,0),
 (364,'3307','+Formula1',0,0),
 (365,'3004','+Formula1',0,0),
 (366,'92','+Formula1',0,0),
 (367,'2005','+Formula1',0,0),
 (368,'3188','+Formula1',0,0),
 (369,'3187','+Formula1',0,0),
 (370,'5024','+Formula1',0,0),
 (371,'5038','+Formula1',0,0),
 (372,'3032','+Formula1',0,0),
 (373,'3033','+Formula1',0,0),
 (374,'3082','+Formula1',0,0),
 (375,'3126','+Formula1',0,0),
 (376,'2038','+Formula1',0,0),
 (377,'2041','+Formula1',0,0),
 (378,'2024','+Formula1',0,0),
 (379,'2028','+Formula1',0,0),
 (380,'2050','+Formula1',0,0),
 (381,'2007','+Formula1',0,0),
 (382,'2048','+Formula1',0,0),
 (383,'2426','+Formula1',0,0),
 (384,'2047','+Formula1',0,0),
 (385,'6534','+Formula1',0,0),
 (386,'6521','+Formula1',0,0),
 (387,'166','+Formula1',0,0),
 (388,'3251','+Formula1',0,0),
 (389,'3128','+Formula1',0,0),
 (390,'3250','+Formula1',0,0),
 (391,'5043','+Formula1',0,0),
 (392,'150','+Formula1',0,0),
 (393,'101','+Formula1',0,0),
 (394,'97','+Formula1',0,0),
 (395,'104','+Formula1',0,0),
 (396,'2060','+Formula1',0,0),
 (397,'2054','+Formula1',0,0),
 (398,'2053','+Formula1',0,0),
 (399,'2067','+Formula1',0,0),
 (400,'2052','+Formula1',0,0),
 (401,'2066','+Formula1',0,0),
 (402,'2282','+Formula1',0,0),
 (403,'6500','+Formula1',0,0),
 (404,'6519','+Formula1',0,0),
 (405,'5040','+Formula1',0,0),
 (406,'3083','+Formula1',0,0),
 (407,'3084','+Formula1',0,0),
 (408,'3009','+Formula1',0,0),
 (409,'3192','+Formula1',0,0),
 (410,'3193','+Formula1',0,0),
 (411,'3344','+Formula1',0,0),
 (412,'144','+Formula1',0,0),
 (413,'3322','+Formula1',0,0),
 (414,'3096','+Formula1',0,0),
 (415,'6531','+Formula1',0,0),
 (416,'3135','+Formula1',0,0),
 (417,'3221','+Formula1',0,0),
 (418,'3132','+Formula1',0,0),
 (419,'3333','+Formula1',0,0),
 (420,'2009','+Formula1',0,0),
 (421,'2018','+Formula1',0,0),
 (422,'2013','+Formula1',0,0),
 (423,'2001','+Formula1',0,0),
 (424,'2014','+Formula1',0,0),
 (425,'2437','+Formula1',0,0),
 (426,'3056','+Formula1',0,0),
 (427,'2225','+Formula1',0,0),
 (428,'2246','+Formula1',0,0),
 (429,'3143','+Formula1',0,0),
 (430,'5015','+Formula1',0,0),
 (431,'175','+Formula1',0,0),
 (432,'156','+Formula1',0,0),
 (433,'3015','+Formula1',0,0),
 (434,'3123','+Formula1',0,0),
 (435,'3026','+Formula1',0,0),
 (436,'3245','+Formula1',0,0),
 (437,'3075','+FRENO',0,0),
 (438,'10001','+FSVB1038',0,0),
 (439,'10000','+FSVM50',0,0),
 (440,'3333','+GS',0,0),
 (441,'3007','+GW35C0',0,0),
 (442,'3003','+GW35C03D',0,0),
 (443,'3002','+GW35C175',0,0),
 (444,'3008','+GW35C9',0,0),
 (445,'3041','+GW400N',0,0),
 (446,'3042','+GW450N',0,0),
 (447,'3043','+GW500N',0,0),
 (448,'3044','+GW500NCS',0,0),
 (449,'3126','+GWPG100N',0,0),
 (450,'3127','+GWPG120N',0,0),
 (451,'3127','+GWPG12ON',0,0),
 (452,'3251','+GWPG150N',0,0),
 (453,'3250','+GWPG60NC',0,0),
 (454,'3128','+GWPG80N',0,0),
 (455,'3237','+HCTPO350B',0,0),
 (456,'3312','+HLD083B50',0,0),
 (457,'3200','+IN148',0,0),
 (458,'3201','+IN180',0,0),
 (459,'3187','+INDIKO',0,0),
 (460,'3124','+INTER',0,0),
 (461,'3188','+IOSSA',0,0),
 (462,'3205','+JQ',0,0),
 (463,'3205','+JQ292',0,0),
 (464,'3126','+P100N',0,0),
 (465,'6532','+P3037AS',0,0),
 (466,'6521','+P30C27/18S',0,0),
 (467,'6534','+P30C28/18S',0,0),
 (468,'6527','+P30C28S',0,0),
 (469,'6523','+P30LN50S',0,0),
 (470,'6526','+P30LUXORSI71A',0,0),
 (471,'6529','+P30Q76A',0,0),
 (472,'6529','+P30Q76S',0,0),
 (473,'6532','+P30R37S',0,0),
 (474,'6531','+P30Z52S',0,0),
 (475,'3123','+PPIANNO',0,0),
 (476,'3124','+pu10101',0,0),
 (477,'3135','+PUNT UFM',0,0),
 (478,'6522','+PVAOV44OL',0,0),
 (479,'3244','+SC148',0,0),
 (480,'3042','+T450Z',0,0),
 (481,'3042','+T4645ON',0,0),
 (482,'3182','+T8/30',0,0),
 (483,'3041','+TE400Z',0,0),
 (484,'3043','+TE500N',0,0),
 (485,'3044','+TE500N',0,0),
 (486,'3043','+TE500Z',0,0),
 (487,'3221','+Z100',0,0),
 (491,'3201','+IN180',402,1),
 (493,'0140','+2235',52,72),
 (494,'0187','+2395',98,72),
 (495,'0100','+2960',13,72),
 (497,'0152','+3262',64,72),
 (498,'3111','+3018',313,73),
 (500,'0179','+3505',90,72),
 (501,'0180','+3515',91,72),
 (502,'1239','+3705',175,72),
 (504,'3182','+57025',383,75),
 (505,'0092','+73420',5,72),
 (506,'1211','+73730',147,72),
 (507,'5022','+160013',531,74),
 (508,'5025','+160115',534,74),
 (509,'5024','+160117',533,74),
 (510,'5042','+200001',551,74),
 (511,'5043','+200004',552,74),
 (512,'3156','+304009',357,76),
 (513,'0195','+354469',105,72),
 (514,'2005','+800485',641,72),
 (515,'5016','+900000',525,74),
 (516,'3007','+1271300',209,76),
 (517,'3141','+1012015',342,76),
 (518,'3022','+1611002',224,76),
 (519,'3156','+304010',357,76),
 (520,'3090','+2623001',292,76),
 (521,'3086','+2623002',288,76),
 (522,'3086','+2623005',288,76),
 (523,'3201','+4220005',402,76),
 (524,'3039','+4301003',241,76),
 (525,'3032','+4301004',234,76),
 (526,'3033','+4301005',235,76),
 (527,'3037','+4301009',239,76),
 (528,'3041','+4301012',243,76),
 (529,'3239','+4301021',437,76),
 (530,'3044','+4301023',246,76),
 (531,'3318','+4301031',481,76),
 (532,'3317','+4301032',480,76),
 (533,'3008','+4302002',210,76),
 (534,'3227','+4302003',425,76),
 (535,'3158','+5506008',359,76),
 (536,'3243','+6901018',441,76),
 (537,'3154','+7701002',355,76),
 (538,'5038','+9107023',547,76),
 (539,'0159','+22/1700',71,72),
 (540,'0158','+22/1731',70,72),
 (541,'0159','+22/1781',71,72),
 (542,'0175','+22/1820',86,72),
 (543,'0160','+22/1826',72,72),
 (544,'0134','+22/1845',46,72),
 (545,'3046','+9502002',248,76),
 (546,'3047','+9502003',249,76),
 (547,'3047','+9502004',249,76),
 (548,'3048','+9502006',250,76),
 (549,'3309','+9503001',472,76),
 (550,'3054','+9503002',256,76),
 (551,'3111','+9504004',313,76),
 (552,'3160','+9506004',361,76),
 (553,'3223','+9508001',421,76),
 (554,'3224','+9508003',422,76),
 (555,'3322','+9508004',485,76),
 (556,'3307','+9512002',470,76),
 (557,'3308','+9512003',471,76),
 (558,'3264','+9512004',462,76),
 (559,'3264','+9512005',462,76),
 (560,'3265','+11411003',463,76),
 (561,'3143','+11501004',344,76),
 (562,'3039','+12706003',241,76),
 (563,'3003','+12712010',205,76),
 (564,'3008','+12713002',210,76),
 (565,'3002','+12713004',204,76),
 (566,'3010','+12713005',212,76),
 (567,'3004','+12713011',206,76),
 (568,'3252','+12714002',450,76),
 (569,'3182','+13906005',383,76),
 (570,'3266','+16702003',464,76),
 (571,'3096','+18406001',298,76),
 (572,'3265','+21505003',463,76),
 (573,'5045','+26226034',554,73),
 (574,'3111','+26228679',313,73),
 (575,'3262','+28333904',460,73),
 (577,'0097','+07/2760',10,72),
 (578,'0150','+07/2860',62,72),
 (579,'0104','+07/2900',17,72),
 (580,'0101','+07/2965',14,72),
 (581,'0189','+07/2985',100,72),
 (582,'1170','+07/3706',106,72),
 (583,'1211','+07/3730',147,72),
 (584,'2227','+08/02310',731,72),
 (585,'0182','+08/412294',93,72),
 (586,'0182','+08/90005',93,72),
 (587,'0183','+08/90010',94,72),
 (588,'0182','+08/9005',93,72),
 (589,'2282','+08/95005',753,72),
 (590,'3047','+10102001',249,76),
 (591,'3026','+11047',228,75),
 (592,'3182','+13906006',383,76),
 (593,'3112','+303003/56070',314,76),
 (594,'5043','+20809002',552,76),
 (595,'3319','+700-120',482,73),
 (596,'0174','+22/1855',85,72),
 (597,'0129','+22/1860',42,72),
 (598,'0166','+22/1870',77,72),
 (599,'0151','+22/2125',63,72),
 (600,'0144','+22/2190',56,72),
 (601,'0150','+22/2212',62,72),
 (602,'0140','+22/2236',52,72),
 (603,'0139','+22/2246',51,72),
 (604,'0137','+22/3145',49,72),
 (605,'0148','+22/3150',60,72),
 (606,'0138','+22/3230',50,72),
 (607,'0147','+22/3250',59,72),
 (608,'0152','+22/3262',64,72),
 (609,'0150','+22/3270',62,72),
 (610,'0142','+22/3290',54,72),
 (611,'0142','+22/3291',54,72),
 (612,'0145','+22/3310',57,72),
 (613,'0149','+22/3315',61,72),
 (614,'0146','+22/3320',58,72),
 (615,'0172','+22/3420',83,72),
 (616,'0170','+22/3430',81,72),
 (617,'0170','+22/3431',81,72),
 (618,'0171','+22/3450',82,72),
 (619,'0171','+22/3451',82,72),
 (620,'0168','+22/3460',79,72),
 (621,'0169','+22/3470',80,72),
 (622,'0169','+22/3471',80,72),
 (623,'0179','+22/3506',90,72),
 (624,'0178','+22/3510',89,72),
 (625,'0180','+22/3515',91,72),
 (626,'0177','+22/3520',88,72),
 (627,'0190','+22/3610',101,72),
 (628,'3244','+35212',442,75),
 (629,'3245','+35525',443,75),
 (630,'3038','+4301010',240,76),
 (631,'3043','+4301014',245,76),
 (632,'3043','+GW500N',245,78),
 (633,'3044','+GW500NCS',246,78),
 (634,'3126','+GWPG100N',327,78),
 (635,'3127','+GWPG120N',328,78),
 (636,'3251','+GWPG150N',449,78),
 (637,'3250','+GWPG60NC',448,78),
 (638,'3128','+GWPG80N',329,78),
 (639,'3237','+HCTP0350B',435,73),
 (640,'3312','+HLD083B50',475,73),
 (641,'3200','+IN148',401,79),
 (642,'3083','+7217001',285,76),
 (643,'3084','+7217002',286,76),
 (644,'3001','+7702002',203,76),
 (645,'5045','+77089',554,75),
 (646,'5045','+77091',554,75),
 (647,'3082','+BAR01CWAR',284,73),
 (648,'3074','+BAR02CWAR',276,73),
 (649,'3313','+BAR03CWAR',476,73),
 (650,'3015','+BB',217,80),
 (651,'3192','+BC116',393,79),
 (652,'3193','+BC148',394,79),
 (653,'3162','+C600/700I',363,73),
 (654,'3066','+CL150',268,79),
 (655,'3067','+CL200',269,79),
 (656,'3068','+CL300',270,79),
 (657,'3069','+CL400',271,79),
 (658,'3103','+CLH',305,79),
 (659,'3314','+CM2.128M',477,73),
 (660,'3315','+CR2.30M',478,73),
 (661,'3119','+CTJ1',321,73),
 (662,'6500','+D11803513',597,81),
 (663,'6519','+D11972920',616,81),
 (664,'3316','+EHC900',479,73),
 (665,'3037','+EHCT25B',239,73),
 (666,'3306','+EHEPCC60B',469,80),
 (667,'3114','+EHEPCC60N',316,80),
 (668,'3132','+EM18',333,79),
 (669,'3055','+ES2045',257,79),
 (670,'3075','+FRENO',277,80),
 (671,'5081','+FSVB1038',865,82),
 (672,'5080','+FSVM50',864,82),
 (673,'3333','+GS',496,79),
 (674,'3007','+GW35C0',209,78),
 (675,'3003','+GW35C03D',205,78),
 (676,'3002','+GW35C175',204,78),
 (677,'3008','+GW35C9',210,78),
 (678,'3041','+GW400N',243,78),
 (679,'3042','+GW450N',244,78),
 (680,'3187','+INDIKO',388,80),
 (681,'3124','+INTER',325,79),
 (682,'3188','+IOSSA',389,80),
 (683,'3205','+JQ',406,80),
 (684,'3205','+JQ292',406,80),
 (685,'3126','+F100N',327,73),
 (686,'6521','+P30C27818S',618,83),
 (687,'6534','+P30C28/18S',631,83),
 (688,'6527','+P30C28S',624,83),
 (690,'6526','+P30LUXORSI71A',623,83),
 (692,'6529','+P30Q76S',626,83),
 (693,'6532','+P30R37S',629,83),
 (694,'6531','+P30Z52S',628,83),
 (695,'3124','+PU10101',325,80),
 (696,'3135','+PUNT UFM',336,80),
 (697,'6522','+PVAO44OL',619,83),
 (698,'3040','+T450Z',242,73),
 (699,'3042','+T46450N',244,73),
 (700,'3182','+T8/30',383,73),
 (701,'3041','+TE400Z',243,73),
 (702,'3043','+TE500N',245,73),
 (703,'3043','+TE500Z',245,73),
 (704,'3221','+Z100',419,80),
 (705,'3346','+BAR120CWA',860,73),
 (706,'3313','+BAR150CWA',476,73),
 (707,'3074','+BAR80CWAR',276,73),
 (708,'6533','+P30LN50S',630,83),
 (709,'6543','+P30Q76A',915,83),
 (710,'6541','+P30R63S',898,83),
 (711,'6544','+P30R37/18S',916,83),
 (712,'6545','+P30R63/18CRS',917,83),
 (713,'3358','+APIESACE3',918,83),
 (714,'3245','+4219003',443,76),
 (715,'3038','+4301002',240,76),
 (716,'3007','+12713020',209,76),
 (717,'3008','+12713021',210,76),
 (718,'3157','+5506005',358,76),
 (719,'5101','+001-0570',925,94),
 (720,'0159','+22/1780',71,72),
 (721,'1170','+07/3705',106,72),
 (722,'0139','+22/2245',51,72),
 (723,'0160','+22/1825',72,72),
 (724,'0173','+22/3440',84,72),
 (725,'0136','+07/2371',48,72),
 (726,'0162','+22/1816',73,72);
/*!40000 ALTER TABLE `otmaterialespro` ENABLE KEYS */;


--
-- Definition of table `otmonedah`
--

DROP TABLE IF EXISTS `otmonedah`;
CREATE TABLE `otmonedah` (
  `moneda` int(10) unsigned NOT NULL,
  `nombre` char(50) NOT NULL,
  `cotizacion` float(13,2) NOT NULL,
  `fechacot` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmonedah`
--

/*!40000 ALTER TABLE `otmonedah` DISABLE KEYS */;
INSERT INTO `otmonedah` (`moneda`,`nombre`,`cotizacion`,`fechacot`) VALUES 
 (1,'PESO',1.00,'20140801'),
 (3,'LIBRA ESTERLINA',18.00,'20141008'),
 (2,'DOLAR',14.50,'20171012');
/*!40000 ALTER TABLE `otmonedah` ENABLE KEYS */;


--
-- Definition of table `otmonedas`
--

DROP TABLE IF EXISTS `otmonedas`;
CREATE TABLE `otmonedas` (
  `moneda` int(10) unsigned NOT NULL,
  `nombre` char(50) NOT NULL,
  `cotizacion` float(13,2) DEFAULT NULL,
  `fechacot` char(8) DEFAULT NULL,
  `simbolo` char(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmonedas`
--

/*!40000 ALTER TABLE `otmonedas` DISABLE KEYS */;
INSERT INTO `otmonedas` (`moneda`,`nombre`,`cotizacion`,`fechacot`,`simbolo`) VALUES 
 (1,'PESO',1.00,'20140101','$'),
 (2,'DOLAR',14.50,'20171012','U$S'),
 (3,'LIBRA ESTERLINA',18.00,'20141008','Lib'),
 (4,'CENTAVO',0.10,'20171012','c$');
/*!40000 ALTER TABLE `otmonedas` ENABLE KEYS */;


--
-- Definition of table `otmovianul`
--

DROP TABLE IF EXISTS `otmovianul`;
CREATE TABLE `otmovianul` (
  `idmovip` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmovianul`
--

/*!40000 ALTER TABLE `otmovianul` DISABLE KEYS */;
INSERT INTO `otmovianul` (`idmovip`,`fecha`) VALUES 
 (1,'20180522'),
 (77,'20180522'),
 (137,'20180625'),
 (137,'20180625'),
 (135,'20180625'),
 (140,'20180625'),
 (142,'20180625'),
 (146,'20180625'),
 (171,'20180629'),
 (170,'20180629');
/*!40000 ALTER TABLE `otmovianul` ENABLE KEYS */;


--
-- Definition of table `otmovistockh`
--

DROP TABLE IF EXISTS `otmovistockh`;
CREATE TABLE `otmovistockh` (
  `idmovip` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `codigomat` char(20) NOT NULL,
  `descrip` char(200) NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  `descmov` char(200) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  `impuni` float(13,2) NOT NULL,
  `imptotal` float(13,2) NOT NULL,
  `cantm2` float(13,2) NOT NULL,
  `idmovih` int(10) unsigned NOT NULL,
  `iddepo` int(10) unsigned NOT NULL,
  `unidad` char(10) NOT NULL,
  PRIMARY KEY (`idmovih`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmovistockh`
--

/*!40000 ALTER TABLE `otmovistockh` DISABLE KEYS */;
INSERT INTO `otmovistockh` (`idmovip`,`fecha`,`idmate`,`codigomat`,`descrip`,`idtipomov`,`descmov`,`cantidad`,`impuni`,`imptotal`,`cantm2`,`idmovih`,`iddepo`,`unidad`) VALUES 
 (1,'20180307',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1.00,0.00,1,1,'PLACA'),
 (2,'20180307',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1.00,0.00,2,1,'PLACA'),
 (1,'20180307',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1.00,0.00,3,1,'PLACA'),
 (2,'20180307',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1.00,0.00,4,1,'PLACA'),
 (3,'20180307',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',2.00,1785.00,2.00,0.00,5,1,'PLACA'),
 (4,'20180307',32,'119','MELAMINA SOBRE MDF 18MM TOLEDO MASISA',2,'EGRESO POR PRODUCCION',1.00,1808.00,1.00,0.00,6,1,'PLACA'),
 (5,'20180307',39,'126','MELAMINA SOBRE MDF 18MM CENIZA MASISA',2,'EGRESO POR PRODUCCION',1.00,1575.00,1.00,0.00,7,1,'PLACA'),
 (6,'20180307',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',2.00,1785.00,2.00,0.00,8,1,'PLACA'),
 (7,'20180309',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',3.00,1785.00,3.00,0.00,9,1,'PLACA'),
 (8,'20180309',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',2.00,1785.00,2.00,0.00,10,1,'PLACA'),
 (9,'20180309',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',3.00,1785.00,3.00,0.00,11,1,'PLACA'),
 (10,'20180313',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',2,'EGRESO POR PRODUCCION',1.00,1747.00,1.00,0.00,12,1,'PLACA'),
 (11,'20180313',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',2,'EGRESO POR PRODUCCION',1.00,1747.00,1.00,0.00,13,1,'PLACA'),
 (18,'20180405',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',3,'INGRESO POR COMPRA',5.00,1609.00,8045.00,5.00,14,1,'PANEL'),
 (19,'20180405',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',3,'INGRESO POR COMPRA',5.00,1609.00,8045.00,5.00,15,1,'PANEL'),
 (19,'20180405',52,'140','MELAMINA SOBRE MDF 18MM ROBLE ESPA¾OL FAPLAC',3,'INGRESO POR COMPRA',3.00,1336.00,4008.00,3.00,16,1,'PLACA'),
 (20,'20180405',52,'140','MELAMINA SOBRE MDF 18MM ROBLE ESPA¾OL FAPLAC',4,'EGRESO POR VENTA',2.00,1336.00,2672.00,2.00,17,1,'PLACA'),
 (21,'20180409',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'INGRESO POR DEVOLUCION',18.00,1785.00,32130.00,18.00,18,1,'PLACA'),
 (22,'20180409',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',3.00,1785.00,5355.00,3.00,19,1,'PLACA'),
 (23,'20180409',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'INGRESO POR DEVOLUCION',3.00,1785.00,5355.00,3.00,20,1,'PLACA'),
 (24,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',3,'INGRESO POR COMPRA',100.00,1609.00,160900.00,100.00,21,1,'PANEL'),
 (25,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',2,'EGRESO POR PRODUCCION',20.00,1609.00,32180.00,20.00,22,1,'PANEL'),
 (26,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',2,'EGRESO POR PRODUCCION',55.00,1609.00,88495.00,55.00,23,1,'PANEL'),
 (27,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',2,'EGRESO POR PRODUCCION',10.00,1609.00,16090.00,10.00,24,1,'PANEL'),
 (28,'20180409',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',1,'INGRESO POR DEVOLUCION',3.00,1747.00,5241.00,3.00,25,1,'PLACA'),
 (29,'20180409',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',2,'EGRESO POR PRODUCCION',1.00,1747.00,1747.00,1.00,26,1,'PLACA'),
 (30,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',3,'INGRESO POR COMPRA',2.00,1700.00,3400.00,2.00,27,1,'PANEL'),
 (31,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',3,'INGRESO POR COMPRA',2.00,1700.00,3400.00,2.00,28,1,'PANEL'),
 (32,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',3,'INGRESO POR COMPRA',1.00,1700.00,1700.00,1.00,29,1,'PANEL'),
 (33,'20180409',98,'187','PANEL RANURADO BLANCO 2.60 X 1.83',3,'INGRESO POR COMPRA',1.00,1700.00,1700.00,1.00,30,1,'PANEL'),
 (34,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',3,'INGRESO POR COMPRA',20.00,45.00,900.00,20.00,31,1,'UND.'),
 (35,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',1,'INGRESO POR DEVOLUCION',4.00,45.00,180.00,4.00,32,1,'UND.'),
 (36,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',8.00,45.00,360.00,8.00,33,1,'UND.'),
 (37,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',10.00,45.00,450.00,10.00,34,1,'UND.'),
 (38,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',4.00,45.00,180.00,4.00,35,1,'UND.'),
 (39,'20180409',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',3,'INGRESO POR COMPRA',10.00,1747.00,17470.00,10.00,36,1,'PLACA'),
 (40,'20180409',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',4,'EGRESO POR VENTA',9.00,1747.00,15723.00,9.00,37,1,'PLACA'),
 (41,'20180409',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',3,'INGRESO POR COMPRA',4.00,1747.00,6988.00,4.00,38,1,'PLACA'),
 (42,'20180409',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',2,'EGRESO POR PRODUCCION',4.00,1747.00,6988.00,0.00,39,1,'PLACA'),
 (43,'20180409',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',10.00,7.00,70.00,0.00,40,1,'UND.'),
 (44,'20180409',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',4.00,7.00,28.00,0.00,41,1,'UND.'),
 (45,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,0.00,42,1,'UND.'),
 (46,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',15.00,45.00,675.00,0.00,43,1,'UND.'),
 (47,'20180409',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',178.00,0.00,0.00,0.00,44,1,'UND.'),
 (48,'20180409',661,'2025','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BLANCO',2,'EGRESO POR PRODUCCION',21.00,1.00,21.00,0.00,45,1,'MTS'),
 (49,'20180409',689,'2053','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM OLMO FINLANDES',2,'EGRESO POR PRODUCCION',21.00,5.00,105.00,0.00,46,1,'MTS'),
 (50,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',3.00,72.00,216.00,0.00,47,1,'UND.'),
 (51,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,0.00,48,1,'UND.'),
 (52,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,0.00,49,1,'UND.'),
 (53,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,0.00,50,1,'UND.'),
 (54,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,0.00,51,1,'UND.'),
 (55,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,0.00,52,1,'UND.'),
 (56,'20180409',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',14.00,7.00,98.00,0.00,53,1,'UND.'),
 (57,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',15.00,45.00,675.00,0.00,54,1,'UND.'),
 (58,'20180310',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',2.00,1785.00,3570.00,0.00,55,1,'PLACA'),
 (58,'20180310',268,'3066','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 1.50 MTS',2,'EGRESO POR PRODUCCION',1.00,1247.00,1247.00,0.00,56,1,'UND.'),
 (59,'20180310',268,'3066','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 1.50 MTS',2,'EGRESO POR PRODUCCION',1.00,1247.00,1247.00,0.00,57,1,'UND.'),
 (60,'20180409',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',7.00,7.00,49.00,0.00,58,1,'UND.'),
 (61,'20180408',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',2.00,7.00,14.00,0.00,59,1,'UND.'),
 (62,'20180408',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',20.00,7.00,140.00,0.00,60,1,'UND.'),
 (63,'20180408',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',2.00,7.00,14.00,0.00,61,1,'UND.'),
 (64,'20180408',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',3.00,72.00,216.00,0.00,62,1,'UND.'),
 (65,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',35.00,0.00,0.00,0.00,63,1,'UND.'),
 (66,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,0.00,64,1,'UND.'),
 (67,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,0.00,65,1,'UND.'),
 (68,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,0.00,66,1,'UND.'),
 (69,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,0.00,67,1,'UND.'),
 (70,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,0.00,68,1,'UND.'),
 (71,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',2.00,0.00,0.00,0.00,69,1,'UND.'),
 (72,'20180408',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',20.00,0.00,0.00,0.00,70,1,'UND.'),
 (73,'20180408',649,'2013','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM VENEZIA',2,'EGRESO POR PRODUCCION',50.00,5.00,250.00,0.00,71,1,'MTS'),
 (74,'20180408',661,'2025','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BLANCO',2,'EGRESO POR PRODUCCION',20.00,1.00,20.00,0.00,72,1,'MTS'),
 (77,'20180503',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'INGRESO POR DEVOLUCION',5.00,1785.00,8925.00,5.00,75,1,'PLACA'),
 (77,'20180503',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',1,'INGRESO POR DEVOLUCION',10.00,1747.00,17470.00,10.00,76,1,'PLACA'),
 (79,'20180310',268,'3066','KIT CORREDIZO SISTEMA CLASSIC ANCHO GU™A 1.50 MTS',2,'EGRESO POR PRODUCCION',1.00,1247.00,1247.00,0.00,78,1,'UND.'),
 (80,'20180409',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',10.00,7.00,70.00,0.00,79,1,'UND.'),
 (81,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,0.00,80,1,'UND.'),
 (82,'20180409',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',4.00,7.00,28.00,5.00,81,1,'UND.'),
 (83,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',5.00,43.00,215.00,0.00,82,1,'UND.'),
 (84,'20180409',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',100.00,0.00,0.00,0.00,83,1,'UND.'),
 (85,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',10.00,43.00,430.00,0.00,84,1,'UND.'),
 (86,'20180409',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,0.00,85,1,'UND.'),
 (87,'20180409',661,'2025','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM BLANCO',2,'EGRESO POR PRODUCCION',1.00,1.00,1.00,0.00,86,1,'MTS'),
 (88,'20180505',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',3,'INGRESO POR COMPRA',5.00,1785.00,8925.00,5.00,87,1,'PLACA'),
 (88,'20180505',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',3,'INGRESO POR COMPRA',1.00,1785.00,1785.00,1.00,88,1,'PLACA'),
 (89,'20180505',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',1,'INGRESO POR DEVOLUCION',5.00,1747.00,8735.00,5.00,89,1,'PLACA'),
 (89,'20180505',351,'3150','TIRADOR ALUMINIO CINTAADHESIVA CHICA -ADHR-',1,'INGRESO POR DEVOLUCION',2.00,235.00,470.00,2.00,90,1,'UND.'),
 (89,'20180505',36,'123','MELAMINA SOBRE MDF 18MM ROBLE INGLES MASISA',1,'INGRESO POR DEVOLUCION',10.00,1313.00,13130.00,10.00,91,1,'PLACA'),
 (90,'20180505',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'INGRESO POR DEVOLUCION',5.00,1785.00,8925.00,5.00,92,1,'PLACA'),
 (91,'20180505',245,'3043','CORREDERA TELESCOPICA 500 MM',3,'INGRESO POR COMPRA',100.00,72.00,7200.00,100.00,93,1,'UND.'),
 (92,'20180505',245,'3043','CORREDERA TELESCOPICA 500 MM',3,'INGRESO POR COMPRA',10.00,72.00,720.00,10.00,94,1,'UND.'),
 (93,'20180505',32,'119','MELAMINA SOBRE MDF 18MM TOLEDO MASISA',3,'INGRESO POR COMPRA',1.00,1808.00,1808.00,1.00,95,1,'PLACA'),
 (94,'20180507',16,'103','MELAMINA SOBRE MDF 18MM LINO MASISA',1,'INGRESO POR DEVOLUCION',5.00,1808.00,9040.00,5.00,96,1,'PLACA'),
 (95,'20180509',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'INGRESO POR DEVOLUCION',5.00,1785.00,8925.00,5.00,97,1,'PLACA'),
 (96,'20180511',634,'10000','FILM STRECH MANIJA 50 CM',3,'3-INGRESO POR COMPRA-I',10.00,111.00,1110.00,10.00,98,1,'UND.'),
 (97,'20180511',634,'10000','FILM STRECH MANIJA 50 CM',3,'3-INGRESO POR COMPRA-I',15.00,111.00,1665.00,15.00,99,1,'UND.'),
 (98,'20180512',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'2-EGRESO POR PRODUCCION-E',100.00,1785.00,178500.00,100.00,100,1,'PLACA'),
 (99,'20180512',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'1-INGRESO POR DEVOLUCION-I',79.00,1785.00,141015.00,79.00,101,1,'PLACA'),
 (100,'20180513',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'1-INGRESO POR DEVOLUCION-I',10.00,1785.00,17850.00,10.00,102,2,'PLACA'),
 (101,'20180513',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',1,'1-INGRESO POR DEVOLUCION-I',2.00,1785.00,3570.00,2.00,103,1,'PLACA'),
 (102,'20180513',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'2-EGRESO POR PRODUCCION-E',1.00,1785.00,1785.00,1.00,104,1,'PLACA'),
 (103,'20180513',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'2-EGRESO POR PRODUCCION-E',9.00,1785.00,16065.00,9.00,105,2,'PLACA'),
 (104,'20180513',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',1,'1-INGRESO POR DEVOLUCION-I',10.00,1747.00,17470.00,10.00,106,1,'PLACA'),
 (105,'20180409',14,'101','MELAMINA SOBRE MDF 18MM NEBRASKA MASISA',2,'EGRESO POR PRODUCCION',4.00,1747.00,6988.00,4.00,107,1,'PLACA'),
 (105,'20180409',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',7.00,7.00,49.00,7.00,108,1,'UND.'),
 (106,'20180409',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,4.00,109,1,'UND.'),
 (106,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',10.00,45.00,450.00,0.00,110,1,'UND.'),
 (107,'20180409',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',5.00,45.00,225.00,5.00,111,1,'UND.'),
 (107,'20180409',383,'3182','TARUGO DE MADERA 8 X 30 MM',2,'EGRESO POR PRODUCCION',8.00,0.00,0.00,8.00,112,1,'UND.'),
 (108,'20180515',210,'3008','BISAGRA COMUN 35 MM CODO 9',2,'EGRESO POR PRODUCCION',4.00,7.00,28.00,4.00,113,1,'UND.'),
 (108,'20180515',245,'3043','CORREDERA TELESCOPICA 500 MM',2,'EGRESO POR PRODUCCION',4.00,72.00,288.00,4.00,114,1,'UND.'),
 (108,'20180515',288,'3086','MANIJA BARRAL RECTO 128 MM',2,'EGRESO POR PRODUCCION',10.00,45.00,450.00,10.00,115,1,'UND.'),
 (109,'20180521',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',5.00,280.00,1400.00,5.00,116,1,'UND.'),
 (109,'20180521',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',2.00,1785.00,3570.00,2.00,117,1,'PLACA'),
 (110,'20180521',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',3.00,1785.00,5355.00,3.00,118,1,'PLACA'),
 (111,'20180521',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1785.00,1.00,119,1,'PLACA'),
 (112,'20180521',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1785.00,1.00,120,1,'PLACA'),
 (113,'20180521',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1785.00,1.00,121,1,'PLACA'),
 (114,'20180521',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1785.00,1.00,122,1,'PLACA'),
 (115,'20180522',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',3,'3-INGRESO POR COMPRA-I',5.00,1785.00,8925.00,5.00,123,1,'PLACA'),
 (116,'20180522',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',4,'4-EGRESO POR VENTA-E',5.00,1785.00,8925.00,5.00,124,1,'PLACA'),
 (116,'20180522',635,'10001','FILM STRECH BANDITA 10 CM',4,'4-EGRESO POR VENTA-E',10.00,31.00,310.00,10.00,125,1,'UND.'),
 (117,'20180606',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',5.00,280.00,1400.00,5.00,126,1,'UND.'),
 (117,'20180606',203,'3001','BASE PLASTICA',2,'EGRESO POR PRODUCCION',2.00,0.00,0.00,2.00,127,1,'UND.'),
 (118,'20180606',203,'3001','BASE PLASTICA',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,5.00,128,1,'UND.'),
 (119,'20180606',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',2.00,1785.00,3570.00,2.00,129,1,'PLACA'),
 (119,'20180606',635,'10001','FILM STRECH BANDITA 10 CM',2,'EGRESO POR PRODUCCION',5.00,31.00,155.00,5.00,130,1,'UND.'),
 (120,'20180609',634,'10000','FILM STRECH MANIJA 50 CM',3,'3-INGRESO POR COMPRA-I',100.00,111.00,11100.00,100.00,131,1,'UND.'),
 (121,'20180618',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',100.00,280.00,28000.00,10.00,132,1,'UND.'),
 (122,'20180618',0,'3311','AVENTO BLUM HF',2,'EGRESO POR PRODUCCION',10.00,0.00,0.00,0.00,133,1,'UND.'),
 (123,'20180618',0,'3311','AVENTO BLUM HF',2,'EGRESO POR PRODUCCION',10.00,0.00,0.00,10.00,134,1,'UND.'),
 (124,'20180618',0,'5029','ARANDELA PLANA 22 X 8.5 X 2 MM',2,'EGRESO POR PRODUCCION',2.00,0.00,0.00,2.00,135,1,'UND.'),
 (125,'20180618',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',12.00,280.00,3360.00,12.00,136,1,'UND.'),
 (126,'20180619',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',2.00,280.00,560.00,2.00,137,1,'UND.'),
 (127,'20180619',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',10.00,280.00,2800.00,10.00,138,1,'UND.'),
 (129,'20180619',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',10.00,280.00,2800.00,1.00,139,1,'UND.'),
 (129,'20180619',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',1.00,42.00,42.00,1.00,140,1,'UND.'),
 (132,'20180622',0,'3227','BISAGRA COM‚N 35 MM CODO 18',2,'EGRESO POR PRODUCCION',10.00,0.00,0.00,1.00,141,1,'UND.'),
 (133,'20180622',0,'3264','CANASTO 3 NIV. EXTRAIBLE 230MM CROMADO',2,'EGRESO POR PRODUCCION',100.00,0.00,0.00,1.00,142,1,'UND.'),
 (134,'20180622',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',2.00,42.00,84.00,1.00,143,1,'UND.'),
 (135,'20180622',0,'3030','CORREDERA COMUN 300 MM',2,'EGRESO POR PRODUCCION',10.00,0.00,0.00,0.00,144,1,'UND.'),
 (136,'20180622',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',7.00,42.00,294.00,0.00,145,1,'UND.'),
 (137,'20180625',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',2.00,42.00,84.00,0.00,146,1,'UND.'),
 (137,'20180625',0,'3227','BISAGRA COM‚N 35 MM CODO 18',2,'EGRESO POR PRODUCCION',10.00,0.00,0.00,1.00,147,1,'UND.'),
 (138,'20180625',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',2.00,42.00,84.00,1.00,148,1,'UND.'),
 (140,'20180625',0,'5042','SILICONA TRANSPARENTE',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,1.00,150,1,'UND.'),
 (142,'20180625',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',2.00,42.00,84.00,1.00,151,1,'UND.'),
 (142,'20180625',0,'2002','TAPACANTO PVC P/MAQUINA 22 X 0.45 MM ALMENDRA',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,1.00,152,1,'MTS'),
 (143,'20180625',0,'5029','ARANDELA PLANA 22 X 8.5 X 2 MM',2,'EGRESO POR PRODUCCION',5.00,0.00,0.00,0.00,153,1,'UND.'),
 (144,'20180625',0,'3308','CANASTO 2 NIV. EXTRAIBLE 450MM CROMADO',2,'EGRESO POR PRODUCCION',1.00,0.00,0.00,1.00,154,1,'UND.'),
 (145,'20180625',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',10.00,2.00,20.00,1.00,155,1,'UND.'),
 (145,'20180625',580,'5071','PORTA COPAS REDONDO',2,'EGRESO POR PRODUCCION',1.00,0.00,0.00,10.00,157,1,'UND.'),
 (146,'20180625',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',2.00,42.00,84.00,1.00,158,1,'UND.'),
 (147,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',5.00,2.00,10.00,0.00,159,1,'UND.'),
 (148,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,160,1,'UND.'),
 (149,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',2.00,2.00,4.00,0.00,161,1,'UND.'),
 (151,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,0.00,162,1,'UND.'),
 (152,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,0.00,163,1,'UND.'),
 (153,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',5.00,2.00,10.00,1.00,164,1,'UND.'),
 (154,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',5.00,2.00,10.00,1.00,165,1,'UND.'),
 (156,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,166,1,'UND.'),
 (157,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,167,1,'UND.'),
 (158,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',2.00,2.00,4.00,1.00,168,1,'UND.'),
 (159,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,0.00,169,1,'UND.'),
 (161,'20180628',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,170,1,'UND.'),
 (162,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',2.00,2.00,4.00,0.00,171,1,'UND.'),
 (162,'20180629',853,'7011','MONTANTE 35 MM',2,'EGRESO POR PRODUCCION',1.00,0.00,2.00,1.00,172,1,'UNID.'),
 (163,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',2.00,2.00,4.00,0.00,173,1,'UND.'),
 (164,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,174,1,'UND.'),
 (165,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',2.00,2.00,4.00,0.00,175,1,'UND.'),
 (166,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,176,1,'UND.'),
 (167,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,177,1,'UND.'),
 (168,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,178,1,'UND.'),
 (168,'20180629',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',1.00,42.00,42.00,1.00,179,1,'UND.'),
 (169,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,180,1,'UND.'),
 (170,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,181,1,'UND.'),
 (171,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,1.00,182,1,'UND.'),
 (173,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,0.00,183,1,'UND.'),
 (174,'20180629',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,0.00,184,1,'UND.'),
 (175,'20180629',0,'3237','CORREDERA TELESC…PICA 350 MM PUSCH',2,'EGRESO POR PRODUCCION',10.00,0.00,0.00,1.00,185,1,'UND.'),
 (176,'20180702',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',1.00,2.00,2.00,0.00,186,1,'UND.'),
 (177,'20180702',451,'3253','AMORTIGUARDOR BLUMOTION (BLUM) CODO 0',2,'EGRESO POR PRODUCCION',1.00,42.00,42.00,1.00,187,1,'UND.'),
 (177,'20180702',580,'5071','PORTA COPAS REDONDO',2,'EGRESO POR PRODUCCION',1.00,0.00,0.00,1.00,188,1,'UND.'),
 (177,'20180702',853,'7011','MONTANTE 35 MM',2,'EGRESO POR PRODUCCION',1.00,0.00,0.00,1.00,189,1,'UNID.'),
 (178,'20180703',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',10.00,280.00,2800.00,1.00,190,1,'UND.'),
 (179,'20180703',549,'5040','ADHESIVO CORIAN 50 ML',2,'EGRESO POR PRODUCCION',10.00,280.00,2800.00,1.00,191,1,'UND.'),
 (180,'20180703',202,'3000','ANGULO DE TERM. ALUMINIO 12X12',2,'EGRESO POR PRODUCCION',2.00,2.00,4.00,1.00,192,1,'UND.'),
 (181,'20180703',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1785.00,1.00,193,1,'PLACA'),
 (182,'20180703',13,'100','MELAMINA SOBRE MDF 18MM CONCRETO METROPOLITAN MASISA',2,'EGRESO POR PRODUCCION',1.00,1785.00,1785.00,0.00,194,1,'PLACA');
/*!40000 ALTER TABLE `otmovistockh` ENABLE KEYS */;


--
-- Definition of table `otmovistockp`
--

DROP TABLE IF EXISTS `otmovistockp`;
CREATE TABLE `otmovistockp` (
  `idmovip` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `fechacarga` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL DEFAULT '0',
  `nombre` char(200) NOT NULL,
  `responsa` char(50) NOT NULL,
  `observa1` char(200) DEFAULT NULL,
  `observa2` char(200) DEFAULT NULL,
  `observa3` char(200) DEFAULT NULL,
  `observa4` char(200) DEFAULT NULL,
  `procli` int(10) unsigned NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmovip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otmovistockp`
--

/*!40000 ALTER TABLE `otmovistockp` DISABLE KEYS */;
INSERT INTO `otmovistockp` (`idmovip`,`fecha`,`fechacarga`,`entidad`,`nombre`,`responsa`,`observa1`,`observa2`,`observa3`,`observa4`,`procli`,`idtipomov`) VALUES 
 (1,'20180307','20180307',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (2,'20180307','20180307',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (3,'20180307','20180307',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (4,'20180307','20180307',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (5,'20180307','20180307',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (6,'20180307','20180307',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (7,'20180309','20180309',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (8,'20180309','20180309',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (9,'20180309','20180309',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (10,'20180313','20180313',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (11,'20180313','20180313',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (12,'20180405','20180405',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (13,'20180405','20180405',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (14,'20180405','20180405',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (15,'20180405','20180405',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (16,'20180405','20180405',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (17,'20180405','20180405',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (18,'20180405','20180405',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (19,'20180405','20180405',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (20,'20180405','20180405',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (21,'20180409','20180409',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (22,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (23,'20180409','20180409',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (24,'20180409','20180409',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (25,'20180409','20180409',0,'','FEDE','','','','',0,0),
 (26,'20180409','20180409',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (27,'20180409','20180409',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (28,'20180409','20180409',1,'ROSSI TULIO','FEDE','','','','',0,0),
 (29,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (30,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (31,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (32,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (33,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (34,'20180409','20180409',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (35,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (36,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (37,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (38,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (39,'20180409','20180409',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (40,'20180409','20180409',0,'','FEDE','','','','',0,0),
 (41,'20180409','20180409',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',0,0),
 (42,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (43,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (44,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (45,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (46,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (47,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (48,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (49,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (50,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (51,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (52,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (53,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (54,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (55,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (56,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (57,'20180409','20180409',3,'OLIVIERO GERMAN','FEDE','','','','',0,0),
 (58,'20180310','20180310',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (59,'20180310','20180310',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (60,'20180409','20180409',3,'OLIVIERO GERMAN','TULIO','','','','',0,2),
 (61,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (62,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (63,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (64,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (65,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (66,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (67,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (68,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (69,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (70,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (71,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (72,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (73,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (74,'20180408','20180408',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (75,'20180503','20180503',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (76,'20180503','20180503',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (77,'20180503','20180503',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (79,'20180310','20180310',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (80,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (81,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (82,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (83,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (84,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (85,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (86,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (87,'20180409','20180409',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (88,'20180505','20180505',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (89,'20180505','20180505',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (90,'20180505','20180505',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (91,'20180505','20180505',4,'Bonet Pablo','TULIO','','','','',0,0),
 (92,'20180505','20180505',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (93,'20180505','20180505',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (94,'20180507','20180507',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','TULIO','','','','',0,0),
 (95,'20180509','20180509',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (96,'20180511','20180511',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (97,'20180511','20180511',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (98,'20180512','20180512',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (99,'20180512','20180512',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (100,'20180513','20180513',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (101,'20180513','20180513',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (102,'20180513','20180513',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (103,'20180513','20180513',0,'','TULIO','','','','',0,0),
 (104,'20180513','20180513',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (105,'20180409','20180409',3,'OLIVIERO GERMAN','TULIO','','','','',0,2),
 (106,'20180409','20180409',3,'OLIVIERO GERMAN','TULIO','','','','',0,2),
 (107,'20180409','20180409',3,'OLIVIERO GERMAN','TULIO','','','','',0,2),
 (108,'20180515','20180515',3,'OLIVIERO GERMAN','TULIO','','','','',0,2),
 (109,'20180521','20180521',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (110,'20180521','20180521',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (111,'20180521','20180521',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (112,'20180521','20180521',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (113,'20180521','20180521',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (114,'20180521','20180521',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (115,'20180522','20180522',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (116,'20180522','20180522',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (117,'20180606','20180606',4,'Bonet Pablo','TULIO','','','','',0,2),
 (118,'20180606','20180606',4,'Bonet Pablo','TULIO','','','','',0,2),
 (119,'20180606','20180606',4,'Bonet Pablo','TULIO','','','','',0,2),
 (120,'20180609','20180609',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (121,'20180618','20180618',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (122,'20180618','20180618',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (123,'20180618','20180618',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (124,'20180618','20180618',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (125,'20180618','20180618',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (126,'20180619','20180619',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (127,'20180619','20180619',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (128,'20180619','20180619',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (129,'20180619','20180619',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (130,'20180622','20180622',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (131,'20180622','20180622',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (132,'20180622','20180622',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (133,'20180622','20180622',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (134,'20180622','20180622',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (135,'20180622','20180622',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (136,'20180622','20180622',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (137,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (138,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (139,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (140,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (141,'20180625','20180625',0,'','TULIO','','','','',0,0),
 (142,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (143,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (144,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (145,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (146,'20180625','20180625',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (147,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (148,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (149,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (150,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (151,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (152,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (153,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (154,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (155,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (156,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (157,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (158,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (159,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (160,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (161,'20180628','20180628',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (162,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (163,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (164,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (165,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (166,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (167,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (168,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (169,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (170,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (171,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (172,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (173,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (174,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (175,'20180629','20180629',1,'ROSSI TULIO','TULIO','','','','',0,0),
 (176,'20180702','20180702',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (177,'20180702','20180702',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (178,'20180703','20180703',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (179,'20180703','20180703',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (180,'20180703','20180703',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (181,'20180703','20180703',1,'ROSSI TULIO','TULIO','','','','',0,2),
 (182,'20180703','20180703',1,'ROSSI TULIO','TULIO','','','','',0,2);
/*!40000 ALTER TABLE `otmovistockp` ENABLE KEYS */;


--
-- Definition of table `otordentra`
--

DROP TABLE IF EXISTS `otordentra`;
CREATE TABLE `otordentra` (
  `idpedido` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `fechaot` char(8) NOT NULL,
  `fechaini` char(8) NOT NULL,
  `testimado` char(20) NOT NULL DEFAULT '',
  `costoest` float(13,2) NOT NULL,
  `descriptot` char(200) NOT NULL,
  `idestado` int(10) unsigned NOT NULL,
  `detaestado` char(200) NOT NULL,
  `responsa` char(200) NOT NULL,
  `observa` char(200) NOT NULL,
  `idetapa` int(10) unsigned NOT NULL,
  `etapa` char(200) NOT NULL,
  `describir` longtext NOT NULL,
  PRIMARY KEY (`idot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otordentra`
--

/*!40000 ALTER TABLE `otordentra` DISABLE KEYS */;
INSERT INTO `otordentra` (`idpedido`,`idot`,`fechaot`,`fechaini`,`testimado`,`costoest`,`descriptot`,`idestado`,`detaestado`,`responsa`,`observa`,`idetapa`,`etapa`,`describir`) VALUES 
 (2,1,'20180613','20180613','01d-00:00:00',100.00,'OT 1',2,'EN PRODUCCION','TULIO','',3,'CORTE Y MECANIZADO',''),
 (1,2,'20180613','20180613','01d-00:00:00',100.00,'OT 2',2,'EN PRODUCCION','TULIO','asdasd',8,'SERVICIO DE POSVENTA',''),
 (2,3,'20180613','20180613','01d-00:00:00',101.00,'OT 3',2,'EN PRODUCCION','TULIO','',2,'PREPARACION DE MATERIALES (STOCK)',''),
 (6,4,'20180616','20180616','01d-00:00:00',100.00,'OT p6',2,'EN PRODUCCION','TULIO','',2,'PREPARACION DE MATERIALES (STOCK)',''),
 (6,5,'20180616','20180616','01d-00:00:00',100.00,'OT P 6',2,'EN PRODUCCION','TULIO','',2,'PREPARACION DE MATERIALES (STOCK)',''),
 (6,6,'20180616','20180616','02d-00:00:00',1000.00,'OT P 6',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (6,7,'20180616','20180616','02d-00:00:00',100.00,'OT p6',2,'EN PRODUCCION','TULIO','',2,'PREPARACION DE MATERIALES (STOCK)',''),
 (9,8,'20180616','20180616','02d-00:00:00',100.00,'OT P9',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (3,9,'20180618','20180618','01d-00:00:00',1000.00,'OT 2',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (7,10,'20180619','20180619','02d-00:00:00',1000.00,'OT p7',2,'EN PRODUCCION','TULIO','',8,'SERVICIO DE POSVENTA',''),
 (1,26,'20180728','20180728','10d-00:00:00',1000.00,'OT PRUEBA 4444',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (1,27,'20180728','20180728','10d-00:00:00',1000.00,'OT PRUEBA 5555',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (1,28,'20180728','20180728','10d-00:00:00',1000.00,'OT PRUEBA 6666',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (1,29,'20180728','20180728','10d-00:00:00',1000.00,'OT PRUEBA 7777',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (1,30,'20180728','20180728','10d-00:00:00',1000.00,'OT PRUEBA 8888',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (2,31,'20180728','20180728','10d-00:00:00',100.00,'OT PRUEBA 9999',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)',''),
 (1,32,'20180728','20180728','10d-00:00:00',100.00,'OT PRUEBA qowjo',1,'INICIADO','TULIO','',1,'PREPARACION DE MATERIALES (STOCK)','');
/*!40000 ALTER TABLE `otordentra` ENABLE KEYS */;


--
-- Definition of table `ototetapas`
--

DROP TABLE IF EXISTS `ototetapas`;
CREATE TABLE `ototetapas` (
  `idpedido` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `idotetapa` int(10) unsigned NOT NULL,
  `idetapa` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idotetapa`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ototetapas`
--

/*!40000 ALTER TABLE `ototetapas` DISABLE KEYS */;
INSERT INTO `ototetapas` (`idpedido`,`idot`,`idotetapa`,`idetapa`,`fecha`) VALUES 
 (1,1,1,1,'20180309'),
 (3,4,2,1,'20180313'),
 (3,4,3,2,'20180313'),
 (3,4,4,3,'20180313'),
 (4,6,5,1,'20180409'),
 (5,7,6,1,'20180409'),
 (5,7,7,1,'20180409'),
 (5,7,8,1,'20180409'),
 (5,7,9,1,'20180409'),
 (5,7,10,1,'20180409'),
 (6,8,11,1,'20180409'),
 (6,8,12,2,'20180409'),
 (6,8,13,2,'20180409'),
 (6,8,14,2,'20180409'),
 (6,8,15,2,'20180409'),
 (6,8,16,3,'20180409'),
 (6,8,17,4,'20180409'),
 (6,9,18,1,'20180409'),
 (6,9,19,1,'20180409'),
 (6,9,20,1,'20180409'),
 (6,9,21,1,'20180409'),
 (6,9,22,1,'20180409'),
 (6,9,23,1,'20180409'),
 (6,9,24,2,'20180409'),
 (6,9,25,3,'20180409'),
 (1,1,26,4,'20180408'),
 (1,1,27,5,'20180408'),
 (2,2,28,4,'20180310'),
 (2,2,29,4,'20180310'),
 (2,2,30,4,'20180310'),
 (2,2,31,4,'20180310'),
 (2,2,32,4,'20180310'),
 (2,2,33,4,'20180310'),
 (6,8,34,5,'20180409'),
 (1,1,35,6,'20180408'),
 (0,1,36,6,'20180408'),
 (0,1,37,6,'20180408'),
 (0,1,38,6,'20180408'),
 (0,1,39,6,'20180408'),
 (0,1,40,6,'20180408'),
 (0,1,41,6,'20180408'),
 (0,1,42,7,'20180408'),
 (0,2,43,4,'20180310'),
 (0,2,44,5,'20180310'),
 (0,3,45,4,'20180409'),
 (0,3,46,5,'20180409'),
 (0,3,47,6,'20180409'),
 (0,3,48,7,'20180409'),
 (0,8,49,5,'20180409'),
 (0,8,50,6,'20180409'),
 (0,8,51,7,'20180409'),
 (0,9,52,4,'20180409'),
 (0,12,53,1,'20180521'),
 (0,12,54,1,'20180521'),
 (0,12,55,1,'20180521'),
 (0,12,56,1,'20180521'),
 (0,12,57,1,'20180521'),
 (0,12,58,2,'20180521'),
 (0,13,59,1,'20180606'),
 (0,13,60,2,'20180606'),
 (0,14,61,1,'20180606'),
 (0,2,62,1,'20180613'),
 (0,2,63,2,'20180613'),
 (0,2,64,3,'20180613'),
 (0,2,65,8,'20180613'),
 (0,1,66,1,'20180618'),
 (0,1,67,2,'20180618'),
 (0,2,68,8,'20180613'),
 (0,2,69,8,'20180613'),
 (0,10,70,1,'20180619'),
 (0,10,71,2,'20180619'),
 (0,10,72,3,'20180619'),
 (0,10,73,4,'20180619'),
 (0,10,74,5,'20180619'),
 (0,10,75,6,'20180619'),
 (0,10,76,7,'20180619'),
 (0,10,77,8,'20180619'),
 (0,10,78,8,'20180619'),
 (0,10,79,8,'20180619'),
 (0,10,80,8,'20180619'),
 (0,10,81,8,'20180619'),
 (0,0,82,0,''),
 (0,10,83,8,'20180619'),
 (0,10,84,8,'20180619'),
 (0,10,85,8,'20180619'),
 (0,10,86,8,'20180625'),
 (0,10,87,8,'20180625'),
 (0,10,88,8,'20180625'),
 (0,10,89,8,'20180625'),
 (0,10,90,8,'20180625'),
 (0,10,91,8,'20180625'),
 (0,10,92,8,'20180625'),
 (0,10,93,8,'20180625'),
 (0,10,94,8,'20180625'),
 (0,10,95,8,'20180625'),
 (0,10,96,8,'20180625'),
 (0,10,97,8,'20180625'),
 (0,10,98,8,'20180625'),
 (0,10,99,8,'20180625'),
 (0,10,100,8,'20180625'),
 (0,10,101,8,'20180625'),
 (0,10,102,8,'20180625'),
 (0,10,103,8,'20180625'),
 (0,10,104,8,'20180625'),
 (0,10,105,5,'20180625'),
 (0,10,106,7,'20180625'),
 (0,10,107,6,'20180625'),
 (0,10,108,5,'20180625'),
 (0,10,109,6,'20180625'),
 (0,10,110,4,'20180625'),
 (0,10,111,6,'20180625'),
 (0,10,112,4,'20180625'),
 (0,10,113,7,'20180625'),
 (0,10,114,5,'20180625'),
 (0,10,115,7,'20180625'),
 (0,10,116,8,'20180625'),
 (0,10,117,8,'20180625'),
 (0,10,118,8,'20180619'),
 (0,3,119,1,'20180703'),
 (0,4,120,1,'20180703'),
 (0,5,121,1,'20180703'),
 (0,7,122,1,'20180703');
/*!40000 ALTER TABLE `ototetapas` ENABLE KEYS */;


--
-- Definition of table `otparametros`
--

DROP TABLE IF EXISTS `otparametros`;
CREATE TABLE `otparametros` (
  `idmate` int(10) unsigned NOT NULL,
  `idmovip` int(10) unsigned NOT NULL,
  `idmovih` int(10) unsigned NOT NULL,
  `idpedido` int(10) unsigned NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `idotdet` int(10) unsigned NOT NULL,
  `idoteje` int(10) unsigned NOT NULL,
  `iddocu` int(10) unsigned NOT NULL,
  `idotetapa` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otparametros`
--

/*!40000 ALTER TABLE `otparametros` DISABLE KEYS */;
INSERT INTO `otparametros` (`idmate`,`idmovip`,`idmovih`,`idpedido`,`idot`,`idotdet`,`idoteje`,`iddocu`,`idotetapa`) VALUES 
 (731,0,0,5,9,17,3,2,13);
/*!40000 ALTER TABLE `otparametros` ENABLE KEYS */;


--
-- Definition of table `otpedido`
--

DROP TABLE IF EXISTS `otpedido`;
CREATE TABLE `otpedido` (
  `idpedido` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `responsa` char(50) NOT NULL DEFAULT '',
  `fechacarga` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL DEFAULT '0',
  `nombre` char(200) NOT NULL,
  `direccion` char(200) NOT NULL,
  `telefono` char(50) NOT NULL,
  `email` char(200) NOT NULL,
  `proyecto` char(200) NOT NULL,
  `observa` char(200) NOT NULL,
  `idestado` int(10) unsigned NOT NULL,
  `detaestado` char(50) NOT NULL,
  `describir` longtext NOT NULL,
  PRIMARY KEY (`idpedido`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otpedido`
--

/*!40000 ALTER TABLE `otpedido` DISABLE KEYS */;
INSERT INTO `otpedido` (`idpedido`,`fecha`,`responsa`,`fechacarga`,`entidad`,`nombre`,`direccion`,`telefono`,`email`,`proyecto`,`observa`,`idestado`,`detaestado`,`describir`) VALUES 
 (1,'20180613','TULIO','20180613',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PROYECTO 1','',1,'INICIADO',''),
 (2,'20180613','TULIO','20180613',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PROYECTO 2','',1,'INICIADO',''),
 (3,'20180616','TULIO','20180616',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PROY 3','',1,'INICIADO',''),
 (4,'20180616','TULIO','20180616',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PROY 4','',1,'INICIADO',''),
 (5,'20180616','TULIO','20180616',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PROY 5','',1,'INICIADO',''),
 (6,'20180616','TULIO','20180616',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PROY 6','',1,'INICIADO',''),
 (7,'20180616','TULIO','20180616',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PROYECTO 7','',1,'INICIADO',''),
 (8,'20180616','TULIO','20180616',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PRO 8','',1,'INICIADO',''),
 (9,'20180616','TULIO','20180616',1,'ROSSI TULIO','Avellaneda 6737','4693586','trossi@cosemar.com.ar','PRO 9','',1,'INICIADO','');
/*!40000 ALTER TABLE `otpedido` ENABLE KEYS */;


--
-- Definition of table `otpedidoanul`
--

DROP TABLE IF EXISTS `otpedidoanul`;
CREATE TABLE `otpedidoanul` (
  `idotpedido` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idotpedido`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otpedidoanul`
--

/*!40000 ALTER TABLE `otpedidoanul` DISABLE KEYS */;
/*!40000 ALTER TABLE `otpedidoanul` ENABLE KEYS */;


--
-- Definition of table `otperfiles`
--

DROP TABLE IF EXISTS `otperfiles`;
CREATE TABLE `otperfiles` (
  `idper` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(50) NOT NULL,
  `habilita` char(1) NOT NULL,
  PRIMARY KEY (`idper`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otperfiles`
--

/*!40000 ALTER TABLE `otperfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `otperfiles` ENABLE KEYS */;


--
-- Definition of table `otperfusu`
--

DROP TABLE IF EXISTS `otperfusu`;
CREATE TABLE `otperfusu` (
  `usuario` char(20) NOT NULL,
  `idper` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idper`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otperfusu`
--

/*!40000 ALTER TABLE `otperfusu` DISABLE KEYS */;
/*!40000 ALTER TABLE `otperfusu` ENABLE KEYS */;


--
-- Definition of table `otpresu`
--

DROP TABLE IF EXISTS `otpresu`;
CREATE TABLE `otpresu` (
  `idot` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpresu` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otpresu`
--

/*!40000 ALTER TABLE `otpresu` DISABLE KEYS */;
/*!40000 ALTER TABLE `otpresu` ENABLE KEYS */;


--
-- Definition of table `otstandar`
--

DROP TABLE IF EXISTS `otstandar`;
CREATE TABLE `otstandar` (
  `idstandar` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalleot` char(200) NOT NULL,
  `idot` int(10) unsigned NOT NULL,
  `fechastan` char(8) NOT NULL,
  `usuario` char(20) NOT NULL,
  PRIMARY KEY (`idstandar`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otstandar`
--

/*!40000 ALTER TABLE `otstandar` DISABLE KEYS */;
/*!40000 ALTER TABLE `otstandar` ENABLE KEYS */;


--
-- Definition of table `otstock`
--

DROP TABLE IF EXISTS `otstock`;
CREATE TABLE `otstock` (
  `iddepo` int(10) unsigned NOT NULL,
  `idmate` int(10) unsigned NOT NULL,
  `stock` float(13,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otstock`
--

/*!40000 ALTER TABLE `otstock` DISABLE KEYS */;
/*!40000 ALTER TABLE `otstock` ENABLE KEYS */;


--
-- Definition of table `ottiposmovi`
--

DROP TABLE IF EXISTS `ottiposmovi`;
CREATE TABLE `ottiposmovi` (
  `idtipomov` int(10) unsigned NOT NULL DEFAULT '0',
  `descmov` char(200) NOT NULL,
  `ie` char(1) NOT NULL,
  PRIMARY KEY (`idtipomov`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ottiposmovi`
--

/*!40000 ALTER TABLE `ottiposmovi` DISABLE KEYS */;
INSERT INTO `ottiposmovi` (`idtipomov`,`descmov`,`ie`) VALUES 
 (1,'INGRESO POR DEVOLUCION','I'),
 (2,'EGRESO POR PRODUCCION','E'),
 (3,'INGRESO POR COMPRA','I'),
 (4,'EGRESO POR VENTA','E'),
 (5,'AJUSTE DE INVENTARIO (I)','I'),
 (6,'AJUSTE DE INVENTARIO (E)','E');
/*!40000 ALTER TABLE `ottiposmovi` ENABLE KEYS */;


--
-- Definition of table `ottiposobs`
--

DROP TABLE IF EXISTS `ottiposobs`;
CREATE TABLE `ottiposobs` (
  `idottiposobs` int(10) unsigned NOT NULL,
  `codigo` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idottiposobs`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ottiposobs`
--

/*!40000 ALTER TABLE `ottiposobs` DISABLE KEYS */;
INSERT INTO `ottiposobs` (`idottiposobs`,`codigo`,`detalle`) VALUES 
 (2,2,'MATERIAL NO PRESUPUESTADO'),
 (3,3,'VARIOS'),
 (4,10,'VARIOS2'),
 (5,15,'VARIOS3'),
 (6,1,'VARIOS4');
/*!40000 ALTER TABLE `ottiposobs` ENABLE KEYS */;


--
-- Definition of table `pagosprov`
--

DROP TABLE IF EXISTS `pagosprov`;
CREATE TABLE `pagosprov` (
  `idpago` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `concepto` char(254) NOT NULL,
  PRIMARY KEY (`idpago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pagosprov`
--

/*!40000 ALTER TABLE `pagosprov` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagosprov` ENABLE KEYS */;


--
-- Definition of table `pagosprovfc`
--

DROP TABLE IF EXISTS `pagosprovfc`;
CREATE TABLE `pagosprovfc` (
  `idpago` int(10) unsigned NOT NULL,
  `idfactprovep` int(10) unsigned NOT NULL DEFAULT '0',
  `idncprove` int(10) unsigned NOT NULL,
  `imputado` float(13,4) NOT NULL,
  `fecha` char(8) NOT NULL,
  `idpagosprovfc` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpagosprovfc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pagosprovfc`
--

/*!40000 ALTER TABLE `pagosprovfc` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagosprovfc` ENABLE KEYS */;


--
-- Definition of table `paises`
--

DROP TABLE IF EXISTS `paises`;
CREATE TABLE `paises` (
  `pais` char(10) NOT NULL DEFAULT '0',
  `nombre` char(60) NOT NULL,
  PRIMARY KEY (`pais`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paises`
--

/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` (`pais`,`nombre`) VALUES 
 ('1','ARGENTINA'),
 ('2','BRASIL'),
 ('3','URUGUAY'),
 ('4','PARAGUAY');
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;


--
-- Definition of table `perfilmh`
--

DROP TABLE IF EXISTS `perfilmh`;
CREATE TABLE `perfilmh` (
  `idperfil` int(11) NOT NULL DEFAULT '0',
  `idmenu` int(11) NOT NULL DEFAULT '0',
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  `codigo` char(14) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  KEY `idmenu` (`idmenu`),
  KEY `idperfil` (`idperfil`),
  KEY `habilitado` (`habilitado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `perfilmh`
--

/*!40000 ALTER TABLE `perfilmh` DISABLE KEYS */;
INSERT INTO `perfilmh` (`idperfil`,`idmenu`,`habilitado`,`codigo`,`idconcepto`) VALUES 
 (1,1,'S','',0),
 (1,2,'S','',0),
 (1,3,'S','',0),
 (1,4,'S','',0),
 (1,5,'S','',0),
 (1,6,'S','',0),
 (1,7,'S','',0),
 (1,8,'S','',0),
 (1,9,'S','',0),
 (1,10,'S','',0),
 (1,11,'S','',0),
 (1,12,'S','',0),
 (1,13,'S','',0),
 (1,14,'S','',0),
 (1,15,'S','',0),
 (1,16,'S','',0),
 (1,17,'S','',0),
 (1,18,'S','',0),
 (1,19,'S','',0),
 (1,20,'S','',0),
 (1,21,'S','',0),
 (1,22,'S','',0),
 (1,23,'S','',0),
 (1,24,'S','',0),
 (1,25,'S','',0),
 (1,26,'S','',0),
 (1,27,'S','',0),
 (1,28,'S','',0),
 (1,29,'S','',0),
 (1,30,'S','',0),
 (1,31,'S','',0),
 (1,32,'S','',0),
 (1,33,'S','',0),
 (1,34,'S','',0),
 (1,35,'S','',0),
 (1,36,'S','',0),
 (1,37,'S','',0),
 (1,38,'S','',0),
 (1,39,'S','',0),
 (1,40,'S','',0),
 (1,41,'S','',0),
 (1,42,'S','',0),
 (1,43,'S','',0),
 (1,44,'S','',0),
 (1,45,'S','',0),
 (1,46,'S','',0),
 (1,50,'S','',0),
 (1,47,'S','',0),
 (1,48,'S','',0),
 (1,49,'S','',0),
 (1,51,'S','',0),
 (1,52,'S','',0),
 (1,53,'S','',0),
 (1,54,'S','',0),
 (1,55,'S','',0),
 (1,56,'S','',0),
 (1,57,'S','',0),
 (1,58,'S','',0),
 (1,59,'S','',0),
 (1,60,'S','',0),
 (1,61,'S','',0),
 (1,62,'S','',0),
 (1,63,'S','',0),
 (1,64,'N','',0),
 (1,65,'N','',0),
 (1,66,'S','',0),
 (1,67,'S','',0);
/*!40000 ALTER TABLE `perfilmh` ENABLE KEYS */;


--
-- Definition of table `perfilmp`
--

DROP TABLE IF EXISTS `perfilmp`;
CREATE TABLE `perfilmp` (
  `idperfil` int(11) NOT NULL DEFAULT '0',
  `perfil` char(20) NOT NULL DEFAULT '',
  `descrip` char(200) NOT NULL DEFAULT '',
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idperfil`),
  KEY `idperfil` (`idperfil`),
  KEY `habilitado` (`habilitado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `perfilmp`
--

/*!40000 ALTER TABLE `perfilmp` DISABLE KEYS */;
INSERT INTO `perfilmp` (`idperfil`,`perfil`,`descrip`,`habilitado`) VALUES 
 (1,'Perfil Maestros','','S');
/*!40000 ALTER TABLE `perfilmp` ENABLE KEYS */;


--
-- Definition of table `perfilusu`
--

DROP TABLE IF EXISTS `perfilusu`;
CREATE TABLE `perfilusu` (
  `idperfil` int(11) NOT NULL DEFAULT '0',
  `usuario` char(15) NOT NULL,
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  `activo` int(11) NOT NULL DEFAULT '0',
  KEY `idperfil` (`idperfil`),
  KEY `usuario` (`usuario`),
  KEY `habilitado` (`habilitado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `perfilusu`
--

/*!40000 ALTER TABLE `perfilusu` DISABLE KEYS */;
INSERT INTO `perfilusu` (`idperfil`,`usuario`,`habilitado`,`activo`) VALUES 
 (1,'GUSTAVO','S',1),
 (1,'TULIO','S',1),
 (1,'FEDE','S',1);
/*!40000 ALTER TABLE `perfilusu` ENABLE KEYS */;


--
-- Definition of table `plancuentas`
--

DROP TABLE IF EXISTS `plancuentas`;
CREATE TABLE `plancuentas` (
  `idplan` int(10) unsigned NOT NULL,
  `fechad` char(8) NOT NULL,
  `fechah` char(8) NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idplan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plancuentas`
--

/*!40000 ALTER TABLE `plancuentas` DISABLE KEYS */;
/*!40000 ALTER TABLE `plancuentas` ENABLE KEYS */;


--
-- Definition of table `plancuentasd`
--

DROP TABLE IF EXISTS `plancuentasd`;
CREATE TABLE `plancuentasd` (
  `idplan` int(10) unsigned NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(254) NOT NULL,
  `sumarizaen` char(20) NOT NULL,
  `imputable` char(1) NOT NULL,
  `activa` char(1) NOT NULL,
  `detalle` char(254) NOT NULL,
  `idpland` int(10) unsigned NOT NULL,
  `idplandup` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpland`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plancuentasd`
--

/*!40000 ALTER TABLE `plancuentasd` DISABLE KEYS */;
/*!40000 ALTER TABLE `plancuentasd` ENABLE KEYS */;


--
-- Definition of table `presupu`
--

DROP TABLE IF EXISTS `presupu`;
CREATE TABLE `presupu` (
  `idpresupu` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL DEFAULT '0',
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `fechavenc` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `direccion` char(254) NOT NULL,
  `localidad` int(10) unsigned NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `cuit` char(13) NOT NULL,
  `tipodoc` char(3) NOT NULL DEFAULT '',
  `dni` int(10) unsigned NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(200) NOT NULL,
  `trasp` int(10) unsigned NOT NULL,
  `nomtransp` char(254) NOT NULL,
  `domentrega` char(254) NOT NULL,
  `condvta` int(10) unsigned NOT NULL DEFAULT '0',
  `neto` float(13,4) NOT NULL,
  `subtotal` float(13,4) NOT NULL,
  `descuento` float(13,4) NOT NULL,
  `recargo` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `operexenta` char(1) NOT NULL,
  `anulado` char(1) NOT NULL,
  `observa1` char(254) NOT NULL,
  `observa2` char(254) NOT NULL,
  `observa3` char(254) NOT NULL,
  `observa4` char(254) NOT NULL,
  `vendedor` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idpresupu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presupu`
--

/*!40000 ALTER TABLE `presupu` DISABLE KEYS */;
/*!40000 ALTER TABLE `presupu` ENABLE KEYS */;


--
-- Definition of table `presupuanul`
--

DROP TABLE IF EXISTS `presupuanul`;
CREATE TABLE `presupuanul` (
  `idpresupu` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presupuanul`
--

/*!40000 ALTER TABLE `presupuanul` DISABLE KEYS */;
/*!40000 ALTER TABLE `presupuanul` ENABLE KEYS */;


--
-- Definition of table `presupuh`
--

DROP TABLE IF EXISTS `presupuh`;
CREATE TABLE `presupuh` (
  `idpresupu` int(10) unsigned NOT NULL,
  `idpresupuh` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `unidad` char(10) NOT NULL,
  `cantidadfc` int(10) unsigned NOT NULL,
  `unidadfc` char(10) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `impuestos` float(13,4) NOT NULL DEFAULT '0.0000',
  `total` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cantcuotas` int(10) unsigned NOT NULL,
  `impuesto` int(10) unsigned NOT NULL DEFAULT '0',
  `entidad` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idpresupu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presupuh`
--

/*!40000 ALTER TABLE `presupuh` DISABLE KEYS */;
/*!40000 ALTER TABLE `presupuh` ENABLE KEYS */;


--
-- Definition of table `presupuimp`
--

DROP TABLE IF EXISTS `presupuimp`;
CREATE TABLE `presupuimp` (
  `idpresupu` int(10) unsigned NOT NULL,
  `impuesto` int(10) unsigned NOT NULL DEFAULT '0',
  `detalle` char(254) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presupuimp`
--

/*!40000 ALTER TABLE `presupuimp` DISABLE KEYS */;
/*!40000 ALTER TABLE `presupuimp` ENABLE KEYS */;


--
-- Definition of table `provincias`
--

DROP TABLE IF EXISTS `provincias`;
CREATE TABLE `provincias` (
  `provincia` char(10) NOT NULL DEFAULT '',
  `nombre` char(60) NOT NULL,
  `pais` char(10) NOT NULL,
  PRIMARY KEY (`provincia`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `provincias`
--

/*!40000 ALTER TABLE `provincias` DISABLE KEYS */;
INSERT INTO `provincias` (`provincia`,`nombre`,`pais`) VALUES 
 ('1','SANTA FE','1'),
 ('2','CHACO','1'),
 ('3','ENTRE RIOS','1'),
 ('4','CATAMARCA','1'),
 ('5','TIERRA DEL FUEGO','1'),
 ('6','FLORIANOPOLIS','2'),
 ('7','CAMBORIU','2'),
 ('8','SAN PABLO','2'),
 ('9','BUENOS AIRES','1');
/*!40000 ALTER TABLE `provincias` ENABLE KEYS */;


--
-- Definition of table `puntosventa`
--

DROP TABLE IF EXISTS `puntosventa`;
CREATE TABLE `puntosventa` (
  `pventa` int(10) unsigned NOT NULL,
  `detalle` char(200) NOT NULL,
  `puntov` char(4) NOT NULL,
  `habilitado` char(1) NOT NULL,
  `fechaini` char(8) NOT NULL,
  `fechabaja` char(8) NOT NULL,
  `electronica` char(1) NOT NULL,
  PRIMARY KEY (`pventa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `puntosventa`
--

/*!40000 ALTER TABLE `puntosventa` DISABLE KEYS */;
INSERT INTO `puntosventa` (`pventa`,`detalle`,`puntov`,`habilitado`,`fechaini`,`fechabaja`,`electronica`) VALUES 
 (1,'CoSeMar','0001','1','20170202','','N'),
 (3,'PUNTO DE VENTA PARA ID','0','1','','','N'),
 (4,'CoSeMar_Electrónica','0003','1','','','S');
/*!40000 ALTER TABLE `puntosventa` ENABLE KEYS */;


--
-- Definition of table `recibos`
--

DROP TABLE IF EXISTS `recibos`;
CREATE TABLE `recibos` (
  `idrecibo` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `concepto` char(254) NOT NULL,
  PRIMARY KEY (`idrecibo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recibos`
--

/*!40000 ALTER TABLE `recibos` DISABLE KEYS */;
INSERT INTO `recibos` (`idrecibo`,`idcomproba`,`pventa`,`numero`,`fecha`,`entidad`,`apellido`,`nombre`,`importe`,`concepto`) VALUES 
 (8,5,4,5,'20180316',1,'','ROSSI TULIO',366.6300,'Pago Contado - Efectivo'),
 (9,5,4,6,'20180316',1,'','ROSSI TULIO',246.8400,'Pago Contado - Efectivo'),
 (10,5,4,7,'20180316',1,'','ROSSI TULIO',246.8400,'Pago Contado - Efectivo'),
 (11,5,4,8,'20180316',1,'','ROSSI TULIO',244.4200,'Pago Contado - Efectivo'),
 (12,5,4,9,'20180317',1,'','ROSSI TULIO',366.6300,'Pago Contado - Efectivo'),
 (13,5,4,1,'20180317',1,'','ROSSI TULIO',122.2100,'Pago Contado - Efectivo'),
 (14,5,4,2,'20180317',1,'','ROSSI TULIO',366.6300,'Pago Contado - Efectivo'),
 (15,5,4,12,'20180317',1,'','ROSSI TULIO',244.4200,'Pago Contado - Efectivo'),
 (16,5,4,13,'20180317',1,'','ROSSI TULIO',122.2100,'Pago Contado - Efectivo'),
 (17,5,4,14,'20180317',1,'','ROSSI TULIO',122.2100,'Pago Contado - Efectivo'),
 (18,5,4,15,'20180320',1,'','ROSSI TULIO',244.4200,'Pago Contado - Efectivo'),
 (24,5,4,18,'20180321',1,'','ROSSI TULIO',44.4200,'Pago de anticipo - CTA CTE - Cuotas'),
 (25,5,4,19,'20180322',1,'','ROSSI TULIO',44.4200,'Pago de anticipo - CTA CTE - Cuotas'),
 (26,5,4,20,'20180322',1,'','ROSSI TULIO',44.4200,'Pago de anticipo - CTA CTE - Cuotas'),
 (27,5,4,21,'20180322',1,'','ROSSI TULIO',44.4200,'Pago de anticipo - CTA CTE - Cuotas'),
 (28,5,4,22,'20180324',1,'','ROSSI TULIO',44.0000,'Pago de anticipo - CTA CTE - Cuotas'),
 (30,5,4,23,'20180403',1,'','TULIO',122.2100,''),
 (31,5,4,24,'20180404',1,'','TULIO',244.4200,''),
 (32,5,4,25,'20180404',1,'','TULIO',244.4200,''),
 (33,5,4,26,'20180404',1,'','TULIO',244.4200,''),
 (34,5,4,27,'20180404',1,'','TULIO',122.2100,''),
 (35,5,4,28,'20180404',1,'','TULIO',244.4200,''),
 (36,5,4,29,'20180404',1,'','TULIO',244.4200,''),
 (37,5,4,30,'20180404',1,'','TULIO',493.6800,''),
 (38,5,4,31,'20180404',1,'','TULIO',366.6300,''),
 (39,5,4,32,'20180404',1,'','TULIO',617.1000,''),
 (40,5,4,33,'20180404',1,'','TULIO',244.4200,''),
 (41,5,4,34,'20180405',1,'','TULIO',244.4200,''),
 (42,5,4,35,'20180405',1,'','TULIO',122.2100,''),
 (43,5,4,36,'20180405',1,'','TULIO',244.4200,''),
 (44,5,4,37,'20180405',1,'','TULIO',44.4200,''),
 (45,5,4,38,'20180405',1,'','TULIO',66.6300,''),
 (46,5,4,39,'20180406',1,'','TULIO',244.4200,''),
 (47,5,4,40,'20180406',1,'','TULIO',244.4200,''),
 (48,5,4,41,'20180406',1,'','TULIO',366.6300,''),
 (49,5,4,42,'20180406',1,'','TULIO',366.6300,''),
 (50,5,4,43,'20180406',1,'','TULIO',244.4200,''),
 (51,5,4,44,'20180406',1,'','TULIO',244.4200,''),
 (52,5,4,45,'20180406',1,'','TULIO',734.7241,''),
 (53,5,4,46,'20180406',1,'','TULIO',279.3696,''),
 (54,5,4,47,'20180407',1,'','TULIO',279.3696,''),
 (55,5,4,48,'20180407',1,'','TULIO',279.3696,''),
 (56,5,4,49,'20180407',1,'','TULIO',279.3696,''),
 (57,5,4,50,'20180410',1,'','TULIO',146.4100,''),
 (58,5,4,51,'20180410',1,'','TULIO',445.3761,''),
 (59,5,4,52,'20180410',1,'','TULIO',366.6300,''),
 (60,5,4,53,'20180410',1,'','TULIO',441.9587,''),
 (61,5,4,54,'20180410',1,'','TULIO',292.8200,''),
 (62,5,4,55,'20180411',1,'','TULIO',122.2100,''),
 (63,0,0,0,'20180804',1,'','TULIO',122.2100,''),
 (64,5,4,56,'20180804',4,'','Pablo',122.2100,''),
 (65,0,0,0,'20180818',1,'','TULIO',611.0500,''),
 (66,0,0,0,'20180821',1,'','TULIO',733.2600,''),
 (67,0,0,0,'20180821',1,'','TULIO',244.4200,''),
 (68,0,0,0,'20180821',1,'','TULIO',611.0500,''),
 (69,0,0,0,'20180821',1,'','TULIO',244.4200,''),
 (70,0,0,0,'20180822',1,'','TULIO',88.8400,''),
 (71,5,4,57,'20180822',1,'','TULIO',88.8400,''),
 (72,5,4,58,'20180822',1,'','TULIO',611.0500,''),
 (73,5,4,59,'20180822',1,'','TULIO',11.0500,''),
 (74,5,4,60,'20180823',1,'','TULIO',611.0500,''),
 (75,5,4,61,'20180823',1,'','TULIO',11.0500,''),
 (76,5,4,62,'20180823',1,'','TULIO',44.4200,''),
 (77,5,4,63,'20180823',1,'','TULIO',244.4200,''),
 (78,5,4,64,'20180824',1,'','TULIO',244.4200,''),
 (79,5,4,65,'20180824',1,'','TULIO',44.4200,''),
 (80,5,4,66,'20180824',1,'','TULIO',44.4200,''),
 (81,5,4,67,'20180824',1,'','TULIO',244.4200,''),
 (82,5,4,68,'20180824',1,'','TULIO',292.8200,''),
 (83,5,4,69,'20180828',1,'','TULIO',122.2100,''),
 (86,5,4,72,'20180829',4,'','Bonet Pablo',1200.0000,''),
 (87,5,4,73,'20180829',1,'','TULIO',611.0500,''),
 (88,5,4,74,'20180830',4,'','Bonet Pablo',100.0000,''),
 (89,5,4,75,'20180830',4,'','Bonet Pablo',100.0000,''),
 (90,5,4,76,'20180831',4,'','Bonet Pablo',100.0000,''),
 (91,5,4,77,'20180831',4,'','Pablo',11.0500,''),
 (92,5,4,78,'20180831',4,'','Pablo',611.0500,''),
 (93,5,4,79,'20180901',4,'','Bonet Pablo',1000.0000,''),
 (94,5,4,80,'20180901',4,'','Bonet Pablo',200.0000,''),
 (95,5,4,81,'20180903',4,'','Pablo',11.0500,''),
 (96,5,4,82,'20180903',4,'','Pablo',303.5696,''),
 (97,5,4,83,'20180908',4,'','Pablo',22.2100,''),
 (98,5,4,84,'20180908',4,'','Pablo',6.3000,''),
 (99,5,4,85,'20180908',4,'','Pablo',2.1000,''),
 (100,5,4,86,'20180912',4,'','Pablo',122.2100,''),
 (101,5,4,87,'20180915',4,'','Pablo',600.0000,''),
 (102,5,4,88,'20180915',4,'','Bonet Pablo',11.0500,''),
 (103,5,4,89,'20180921',4,'','Pablo',122.2100,''),
 (104,5,4,90,'20180921',4,'','Pablo',611.0500,''),
 (105,5,4,91,'20180921',4,'','Pablo',1222.1000,''),
 (106,5,4,92,'20180922',4,'','Pablo',122.2100,''),
 (107,5,4,93,'20180922',4,'','Bonet Pablo',100.0000,''),
 (108,5,4,94,'20180925',4,'','Pablo',12.6000,''),
 (109,5,4,95,'20180928',4,'','Bonet Pablo',100.0000,''),
 (110,5,4,96,'20181006',4,'','Bonet Pablo',1000.0000,''),
 (111,5,4,97,'20181006',4,'','Bonet Pablo',500.0000,''),
 (112,5,4,98,'20181006',4,'','Pablo',303.5696,''),
 (113,5,4,99,'20181008',4,'','Pablo',734.7241,''),
 (114,5,4,100,'20181011',4,'','Pablo',244.4200,''),
 (115,5,4,101,'20181011',1,'','TULIO',244.4200,''),
 (116,5,4,102,'20181011',1,'','TULIO',244.4200,''),
 (117,5,4,103,'20181011',1,'','TULIO',244.4200,''),
 (118,5,4,104,'20181011',4,'','Pablo',611.0500,''),
 (119,5,4,105,'20181011',1,'','TULIO',244.4200,''),
 (120,5,4,106,'20181011',1,'','TULIO',244.4200,''),
 (121,5,4,107,'20181011',4,'','Pablo',244.4200,''),
 (122,5,4,108,'20181011',4,'','Bonet Pablo',100.0000,''),
 (123,5,4,109,'20181012',4,'','Bonet Pablo',303.5696,''),
 (124,5,4,110,'20181012',4,'','Bonet Pablo',0.0001,''),
 (125,5,4,111,'20181012',4,'','Bonet Pablo',0.0003,''),
 (126,5,4,112,'20181012',4,'','Pablo',122.2100,''),
 (127,5,4,113,'20181012',4,'','Pablo',122.2100,''),
 (128,5,4,114,'20181012',4,'','Pablo',122.2100,''),
 (129,5,4,115,'20181013',4,'','Bonet Pablo',455.3545,''),
 (130,5,4,116,'20181013',4,'','Bonet Pablo',1000.0000,''),
 (131,5,4,117,'20181019',4,'','Pablo',390.4700,''),
 (132,5,4,118,'20181019',4,'','Pablo',365.4200,''),
 (133,5,4,119,'20181020',4,'','Pablo',1305.5400,''),
 (134,5,4,120,'20181020',4,'','Pablo',402.3900,''),
 (135,5,4,121,'20181020',4,'','Pablo',434.5200,''),
 (136,5,4,122,'20181020',4,'','Pablo',390.4700,''),
 (137,5,4,123,'20181020',4,'','Pablo',243.2100,''),
 (138,5,4,124,'20181022',1,'','TULIO',614.6800,''),
 (139,5,4,125,'20181022',1,'','TULIO',14.6800,''),
 (140,5,4,126,'20181022',1,'','TULIO',14.6800,''),
 (141,5,4,127,'20181022',1,'','TULIO',614.6800,''),
 (142,5,4,128,'20181022',1,'','TULIO',244.4200,''),
 (143,5,1,69,'20181022',4,'','Pablo',244.4200,''),
 (144,5,1,70,'20181022',4,'','Pablo',614.6800,''),
 (145,0,0,0,'20181022',1,'','TULIO',614.6800,''),
 (146,13,1,1,'20181022',1,'','TULIO',614.6800,''),
 (147,5,1,71,'20181023',4,'','Pablo',763.4326,''),
 (148,5,1,72,'20181024',4,'','Pablo',303.5696,''),
 (149,5,1,73,'20181024',4,'','Pablo',763.4326,''),
 (150,5,1,74,'20181024',4,'','Pablo',763.4326,''),
 (151,5,1,75,'20181024',1,'','TULIO',14.6800,''),
 (152,5,1,76,'20181024',1,'','TULIO',12.6000,''),
 (153,5,1,77,'20181024',1,'','TULIO',614.6800,''),
 (154,5,1,78,'20181024',1,'','TULIO',614.6800,''),
 (155,5,1,79,'20181024',1,'','TULIO',759.8800,''),
 (156,5,1,80,'20181024',1,'','TULIO',763.4326,''),
 (157,5,4,129,'20181024',1,'','TULIO',759.8800,''),
 (158,5,4,130,'20181024',1,'','TULIO',614.6800,''),
 (159,5,4,131,'20181024',1,'','TULIO',614.6800,''),
 (160,5,4,132,'20181024',1,'','TULIO',614.6800,''),
 (161,5,4,133,'20181024',1,'','TULIO',763.4326,''),
 (162,5,1,81,'20181025',1,'','TULIO',759.8800,''),
 (163,5,1,82,'20181025',1,'','TULIO',734.6801,''),
 (164,5,4,134,'20181025',1,'','TULIO',734.6801,''),
 (165,5,4,135,'20181025',1,'','TULIO',734.6801,''),
 (166,5,4,136,'20181025',1,'','TULIO',734.6801,''),
 (167,0,0,0,'20181026',1,'','TULIO',14.6800,''),
 (168,0,0,0,'20181026',1,'','TULIO',614.6800,''),
 (169,0,0,0,'20181026',1,'','TULIO',614.6800,''),
 (170,0,0,0,'20181026',1,'','TULIO',614.6800,''),
 (171,0,0,0,'20181026',1,'','TULIO',737.6160,''),
 (172,0,0,0,'20181026',1,'','TULIO',734.6801,''),
 (173,5,4,137,'20181026',1,'','TULIO',25.2000,''),
 (174,5,4,138,'20181026',1,'','TULIO',25.2000,''),
 (175,5,4,139,'20181026',1,'','TULIO',0.0001,''),
 (176,5,4,140,'20181026',1,'','TULIO',14.6800,''),
 (177,0,0,0,'20181026',1,'','TULIO',14.6800,''),
 (178,5,4,141,'20181026',1,'','ROSSI TULIO',368.8000,''),
 (179,5,4,142,'20181027',1,'','TULIO',196.0200,''),
 (180,13,4,1,'20181027',1,'','TULIO',244.4200,''),
 (181,13,4,2,'20181027',0,'','Adrián Bonet',602.5800,''),
 (182,13,4,3,'20181027',0,'','Adrián Magnago',244.4200,''),
 (183,5,1,83,'20181027',0,'','Magnago Adrian',244.4200,''),
 (184,13,4,4,'20181027',1,'','TULIO',914.6420,''),
 (185,14,1,101,'20181031',1,'','TULIO',293.3040,''),
 (186,14,1,102,'20181031',1,'','TULIO',293.3040,'');
/*!40000 ALTER TABLE `recibos` ENABLE KEYS */;


--
-- Definition of table `relotcompro`
--

DROP TABLE IF EXISTS `relotcompro`;
CREATE TABLE `relotcompro` (
  `idot` int(10) unsigned NOT NULL,
  `idotint` int(10) unsigned NOT NULL,
  `idremitoh` int(10) unsigned NOT NULL,
  `idfacturah` int(10) unsigned NOT NULL,
  `idpresupuh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `relotcompro`
--

/*!40000 ALTER TABLE `relotcompro` DISABLE KEYS */;
/*!40000 ALTER TABLE `relotcompro` ENABLE KEYS */;


--
-- Definition of table `remitos`
--

DROP TABLE IF EXISTS `remitos`;
CREATE TABLE `remitos` (
  `idremito` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL DEFAULT '0',
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `direccion` char(254) NOT NULL,
  `localidad` int(10) unsigned NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `cuit` char(13) NOT NULL,
  `tipodoc` char(3) NOT NULL DEFAULT '',
  `dni` int(10) unsigned NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(200) NOT NULL,
  `transporte` int(10) unsigned NOT NULL DEFAULT '0',
  `nomtransp` char(254) NOT NULL,
  `domentrega` char(254) NOT NULL,
  `stock` char(1) NOT NULL,
  `condvta` int(10) unsigned NOT NULL DEFAULT '0',
  `neto` float(13,4) NOT NULL,
  `subtotal` float(13,4) NOT NULL,
  `recargo` float(13,4) NOT NULL,
  `operexenta` char(1) NOT NULL,
  `anulado` char(1) NOT NULL,
  `observa1` char(254) NOT NULL,
  `observa2` char(254) NOT NULL,
  `observa3` char(254) NOT NULL,
  `observa4` char(254) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `vendedor` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idremito`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `remitos`
--

/*!40000 ALTER TABLE `remitos` DISABLE KEYS */;
/*!40000 ALTER TABLE `remitos` ENABLE KEYS */;


--
-- Definition of table `remitosanul`
--

DROP TABLE IF EXISTS `remitosanul`;
CREATE TABLE `remitosanul` (
  `idremito` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `remitosanul`
--

/*!40000 ALTER TABLE `remitosanul` DISABLE KEYS */;
/*!40000 ALTER TABLE `remitosanul` ENABLE KEYS */;


--
-- Definition of table `remitosh`
--

DROP TABLE IF EXISTS `remitosh`;
CREATE TABLE `remitosh` (
  `idremito` int(10) unsigned NOT NULL,
  `idremitoh` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL DEFAULT '0.0000',
  `unidad` char(10) NOT NULL,
  `cantidadfc` float(13,4) NOT NULL DEFAULT '0.0000',
  `unidadfc` char(10) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `impuestos` float(13,4) NOT NULL DEFAULT '0.0000',
  `total` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(100) NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cancuotas` int(10) unsigned NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  `impuesto` int(10) unsigned NOT NULL DEFAULT '0',
  `razonimp` float(13,4) NOT NULL,
  PRIMARY KEY (`idremito`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `remitosh`
--

/*!40000 ALTER TABLE `remitosh` DISABLE KEYS */;
/*!40000 ALTER TABLE `remitosh` ENABLE KEYS */;


--
-- Definition of table `remitosprovh`
--

DROP TABLE IF EXISTS `remitosprovh`;
CREATE TABLE `remitosprovh` (
  `idremiprovh` int(10) unsigned NOT NULL DEFAULT '0',
  `idremiprovp` int(10) unsigned NOT NULL DEFAULT '0',
  `renglon` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `codartprov` char(20) NOT NULL,
  `detalle` char(254) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  `unitario` float(13,2) NOT NULL,
  `unidad` char(20) NOT NULL,
  `impuestos` float(13,2) NOT NULL,
  `total` float(13,2) NOT NULL,
  PRIMARY KEY (`idremiprovh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `remitosprovh`
--

/*!40000 ALTER TABLE `remitosprovh` DISABLE KEYS */;
/*!40000 ALTER TABLE `remitosprovh` ENABLE KEYS */;


--
-- Definition of table `remitosprovp`
--

DROP TABLE IF EXISTS `remitosprovp`;
CREATE TABLE `remitosprovp` (
  `idremitprovp` int(10) unsigned NOT NULL DEFAULT '0',
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(200) NOT NULL,
  `nombre` char(200) NOT NULL,
  `direccion` char(100) NOT NULL,
  `localidad` int(10) unsigned NOT NULL DEFAULT '0',
  `iva` int(10) unsigned NOT NULL,
  `cuit` char(13) NOT NULL,
  `fecha` char(8) NOT NULL,
  `observa1` char(254) NOT NULL DEFAULT '',
  `observa2` char(254) NOT NULL DEFAULT '',
  `observa3` char(254) NOT NULL DEFAULT '',
  `observa4` char(254) NOT NULL DEFAULT '',
  `fecharp` char(8) NOT NULL,
  `actividadrp` int(10) unsigned NOT NULL DEFAULT '0',
  `numerorp` int(10) unsigned NOT NULL,
  `deposito` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idremitprovp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `remitosprovp`
--

/*!40000 ALTER TABLE `remitosprovp` DISABLE KEYS */;
/*!40000 ALTER TABLE `remitosprovp` ENABLE KEYS */;


--
-- Definition of table `reportesimp`
--

DROP TABLE IF EXISTS `reportesimp`;
CREATE TABLE `reportesimp` (
  `idreporte` int(10) unsigned NOT NULL,
  `nombre` char(50) NOT NULL,
  `descripcion` char(254) NOT NULL,
  PRIMARY KEY (`idreporte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reportesimp`
--

/*!40000 ALTER TABLE `reportesimp` DISABLE KEYS */;
INSERT INTO `reportesimp` (`idreporte`,`nombre`,`descripcion`) VALUES 
 (0,'',''),
 (1,'facturas1.rpt','Modelo 1 de facturas u otros comprobantes'),
 (2,'recibos1.rpt','Modelo 1 de recibos'),
 (3,'comprobante.rpt',''),
 (4,'articulos.rpt',''),
 (5,'artimpu.rpt',''),
 (6,'artPro.rpt',''),
 (7,'bancos.rpt',''),
 (8,'bibliotecaf.rpt',''),
 (9,'conceptos.rpt',''),
 (10,'empleados.rpt',''),
 (11,'entidades.rpt',''),
 (12,'otordentra.rpt',''),
 (13,'otmateriales.rpt',''),
 (14,'vendedores.rpt',''),
 (15,'comprobantes.rpt',''),
 (16,'conceptoser.rpt',''),
 (17,'condfiscal.rpt',''),
 (18,'ajustestock.rpt',''),
 (19,'depositos.rpt',''),
 (20,'empresas.rpt',''),
 (21,'entidadesc.rpt',''),
 (22,'entidadescr.rpt',''),
 (23,'entidadesg.rpt',''),
 (24,'entidadesh.rpt',''),
 (25,'gruposepelio.rpt',''),
 (26,'iconos.rpt',''),
 (27,'impuestos.rpt',''),
 (28,'lineas.rpt',''),
 (29,'localidades.rpt',''),
 (30,'monedas.rpt',''),
 (31,'otestados.rpt',''),
 (32,'otetapas.rpt',''),
 (33,'otDetalle.rpt',''),
 (34,'pedidoOt.rpt',''),
 (35,'ottiposmovi.rpt',''),
 (36,'paises.rpt',''),
 (37,'provincias.rpt',''),
 (38,'puntosventa.rpt',''),
 (39,'servicios.rpt',''),
 (40,'sucursales.rpt',''),
 (41,'tarjetacredito.rpt',''),
 (42,'tipocompro.rpt',''),
 (43,'tipomstock.rpt',''),
 (44,'settoolb.rpt',''),
 (45,'zonas.rpt',''),
 (46,'otlineasmat.rpt',''),
 (47,'movistock.rpt',''),
 (48,'otlistadostock.rpt',''),
 (49,'movimientosstock.rpt',''),
 (50,'otinfotrazabilidad.rpt','Informe de Trazabilidad del formulario otinformesot'),
 (51,'otinfopendientes.rpt','Informe de Pendientes del formulario otinformesot'),
 (52,'otinfoestados.rpt','Informe de Estados y costos estimados'),
 (53,'otejecuh.rpt','Reporte de ejecución de horas'),
 (54,'otmatequipro.rpt','Informe de codigo de materiales equivalentes de proveedores');
/*!40000 ALTER TABLE `reportesimp` ENABLE KEYS */;


--
-- Definition of table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
CREATE TABLE `servicios` (
  `servicio` int(10) unsigned NOT NULL,
  `detalle` char(100) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `diasvenc2` int(10) unsigned NOT NULL,
  `diasvenc3` int(10) unsigned NOT NULL,
  `diasdescon` int(10) unsigned NOT NULL,
  `interesd` float(13,4) NOT NULL,
  PRIMARY KEY (`servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `servicios`
--

/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` (`servicio`,`detalle`,`fechaalta`,`diasvenc2`,`diasvenc3`,`diasdescon`,`interesd`) VALUES 
 (2,'RADIO FM 93.5','20160511',10,2,13,0.0000),
 (3,'SEPELIO','20161112',10,15,20,0.0000);
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;


--
-- Definition of table `serviciosimpu`
--

DROP TABLE IF EXISTS `serviciosimpu`;
CREATE TABLE `serviciosimpu` (
  `impuesto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `serviciosimpu`
--

/*!40000 ALTER TABLE `serviciosimpu` DISABLE KEYS */;
INSERT INTO `serviciosimpu` (`impuesto`,`servicio`) VALUES 
 (2,2);
/*!40000 ALTER TABLE `serviciosimpu` ENABLE KEYS */;


--
-- Definition of table `seteolog`
--

DROP TABLE IF EXISTS `seteolog`;
CREATE TABLE `seteolog` (
  `tabla` char(50) NOT NULL,
  `campo` char(50) NOT NULL,
  `tipo` char(1) NOT NULL,
  `log` char(1) NOT NULL,
  PRIMARY KEY (`tabla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `seteolog`
--

/*!40000 ALTER TABLE `seteolog` DISABLE KEYS */;
INSERT INTO `seteolog` (`tabla`,`campo`,`tipo`,`log`) VALUES 
 ('afipcompro','idafipcom','I','N'),
 ('afipimpuestos','idafipimp','I','N'),
 ('ajustestocke','idajuste','I','N'),
 ('ajustestockh','idajusteh','I','N'),
 ('ajustestockp','idajuste','I','N'),
 ('arqueocajap','idarqueo','I','N'),
 ('articulos','articulo','I','N'),
 ('articulosf','idartf','I','N'),
 ('articulosimg','idartimg','I','N'),
 ('articulosimp','idartimp','I','N'),
 ('articulospro','idartpro','I','N'),
 ('asientos','idasientod','I','N'),
 ('asientoscompro','idasiento','I','N'),
 ('astocuenta','idastocuenta','I','N'),
 ('astomode','codasto','I','N'),
 ('bancos','idbanco','I','N'),
 ('bocaservicios','identidadh','I','N'),
 ('cajabancos','idcuenta','I','N'),
 ('cajaie','idcajaie','I','N'),
 ('cajamovip','idcajamovip','I','N'),
 ('cajarecauda','idcajareca','I','N'),
 ('cajarecaudah','idcajareh','I','N'),
 ('carterach','idcartera','I','N'),
 ('carterachdeta','idcartera','I','N'),
 ('carteracheque','idcartera','I','N'),
 ('carterachequed','idcheque','I','N'),
 ('chequesprop','idchequep','I','N'),
 ('cobros','idcobro','I','N'),
 ('comproasiento','idcomproba','I','N'),
 ('comprobantes','idcomproba','I','N'),
 ('conceptogrupo','idconceptg','I','N'),
 ('conceptoser','idconcepto','I','N'),
 ('condfiscal','iva','I','N'),
 ('cpptelefono','bocanumero','I','N'),
 ('cuentasdispon','idcuenta','I','N'),
 ('cupones','idcupon','I','N'),
 ('depositos','deposito','I','N'),
 ('destinooti','destinooti','I','N'),
 ('detafactu','idfacturah','I','N'),
 ('detallecobros','iddetacobro','I','N'),
 ('detallepagos','iddetapago','I','N'),
 ('ejercicioecon','ejercicio','I','N'),
 ('empleados','idempleado','I','N'),
 ('empresa','empresa','I','N'),
 ('entidades','entidad','I','N'),
 ('entidadesc','idcontacto','I','N'),
 ('entidadescr','identidacr','I','N'),
 ('entidadesd','identidadd','I','N'),
 ('entidadesdc','idcuotasd','I','N'),
 ('entidadesg','idgarante','I','N'),
 ('entidadesh','identidadh','I','N'),
 ('entidadg','identidadh','I','N'),
 ('etiquetas','etiqueta','I','N'),
 ('factclaro','idfactclaro','I','N'),
 ('factuperiodos','idperiodo','I','N'),
 ('factuprove','idfactprove','I','N'),
 ('factuproved','idfactproveh','I','N'),
 ('factuproveimp','idfactprove','I','N'),
 ('facturas','idfactura','I','N'),
 ('facturasanul','idfactura','I','N'),
 ('facturascta','idcuotafc','I','N'),
 ('facturasfe','idfe','I','N'),
 ('grupose','idgrupoe','I','N'),
 ('gruposepelio','idgruposep','I','N'),
 ('impuestos','impuesto','I','N'),
 ('largadistancia','idlargad','I','N'),
 ('librosocios','idlibrosoc','I','N'),
 ('librosociosdet','idlibrosoc','I','N'),
 ('lineas','linea','I','N'),
 ('listaprecioh','idlista','I','N'),
 ('listapreciop','idlista','I','N'),
 ('localidades','localidad','I','N'),
 ('logsystem','idlog','I','N'),
 ('medagua','idmedagua','I','N'),
 ('medluz','idmedluz','I','N'),
 ('medtelefono','idmedtele','I','N'),
 ('menusql','idmenu','I','N'),
 ('monedas','moneda','I','N'),
 ('np','idnp','I','N'),
 ('ot','idot','I','N'),
 ('otcancela','idot','I','N'),
 ('otcumpleh','idotcumple','I','N'),
 ('otcumplep','idotcumple','I','N'),
 ('otdepositos','iddepo','I','N'),
 ('otdetaot','idotdet','I','N'),
 ('otejecuh','idotejeh','I','N'),
 ('otejecum','idotejem','I','N'),
 ('otestados','idestado','I','N'),
 ('otestadosot','idotestadosot','I','N'),
 ('otetapas','idetapa','I','N'),
 ('otint','idotint','I','N'),
 ('otinterna','idotint','I','N'),
 ('otlineasmat','linea','I','N'),
 ('otmateriales','idmate','I','S'),
 ('otmaterialeslep','idotmatelep','I','N'),
 ('otmaterialespro','idotmatepro','I','N'),
 ('otmovistockh','idmovih','I','N'),
 ('otmovistockp','idmovip','I','N'),
 ('otordentra','idot','I','N'),
 ('ototetapas','idotetapa','I','N'),
 ('otpedido','idpedido','I','N'),
 ('otpedidoanul','idotpedido','I','N'),
 ('otperfiles','idper','I','N'),
 ('otperfusu','idper','I','N'),
 ('otpresu','idot','I','N'),
 ('otstandar','idstandar','I','N'),
 ('ottiposobs','idottiposobs','I','N'),
 ('pagosprov','idpago','I','N'),
 ('pagosprovfc','idpagosprovfc','I','N'),
 ('paises','pais','I','N'),
 ('perfilmp','idperfil','I','N'),
 ('plancuentas','idplan','I','N'),
 ('plancuentasd','idpland','I','N'),
 ('presupu','idpresupu','I','N'),
 ('presupuh','idpresupu','I','N'),
 ('provincias','provincia','I','N'),
 ('puntosventa','pventa','I','N'),
 ('recibos','idrecibo','I','N'),
 ('relotcompro','idot','I','N'),
 ('remitos','idremito','I','N'),
 ('remitosh','idremito','I','N'),
 ('remitosprovh','idremiprovh','I','N'),
 ('remitosprovp','idremitprovp','I','N'),
 ('reportesimp','idreporte','I','N'),
 ('servicios','servicio','I','N'),
 ('seteolog','tabla','I','N'),
 ('sucursales','sucursal','I','N'),
 ('tablasidx','idindex','I','N'),
 ('tarjetacredito','idtarjeta','I','N'),
 ('tarjetacuotas','idtarjetacta','I','N'),
 ('tipocajabanco','idtipocta','I','N'),
 ('tipocobrosdeta','puntovta','I','N'),
 ('tipocompro','idtipocompro','I','N'),
 ('tipocuenta','idtipo','I','N'),
 ('tipodocumento','tipodoc','I','N'),
 ('tipomovctap','idtipomovi','I','N'),
 ('tipomovotint','idmovotint','I','N'),
 ('tipomstock','idtipomov','I','N'),
 ('tiponp','idtiponp','I','N'),
 ('tipooperacion','idtipoopera','I','N'),
 ('tipoot','idtipoot','I','N'),
 ('tipopagos','idtipopago','I','N'),
 ('tranintercta','idmovicta','I','N'),
 ('traninterctah','idmovicta','I','N'),
 ('transfep','idtransfep','I','N'),
 ('transporte','transporte','I','N'),
 ('usuarios','usuario','I','N'),
 ('varpublicas','variable','I','N'),
 ('vendedores','vendedor','I','N'),
 ('zonas','zona','I','N');
/*!40000 ALTER TABLE `seteolog` ENABLE KEYS */;


--
-- Definition of table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `articulo` char(50) NOT NULL,
  `stock` float(13,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock`
--

/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;


--
-- Definition of table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
CREATE TABLE `sucursales` (
  `sucursal` int(10) unsigned NOT NULL,
  `detalle` char(200) NOT NULL,
  PRIMARY KEY (`sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sucursales`
--

/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` (`sucursal`,`detalle`) VALUES 
 (1,'SUCURSAL 1'),
 (2,'SUCURSAL 2'),
 (3,'SUCURSAL 3');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;


--
-- Definition of table `sucursalpventa`
--

DROP TABLE IF EXISTS `sucursalpventa`;
CREATE TABLE `sucursalpventa` (
  `sucursal` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `fechaini` char(8) NOT NULL,
  `fechabaja` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sucursalpventa`
--

/*!40000 ALTER TABLE `sucursalpventa` DISABLE KEYS */;
/*!40000 ALTER TABLE `sucursalpventa` ENABLE KEYS */;


--
-- Definition of table `tablasidx`
--

DROP TABLE IF EXISTS `tablasidx`;
CREATE TABLE `tablasidx` (
  `idindex` int(10) unsigned NOT NULL,
  `tabla` char(50) NOT NULL,
  `campo` char(50) NOT NULL,
  `tipocampo` char(10) NOT NULL,
  `maxvalorc` char(50) NOT NULL,
  `maxvalori` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idindex`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tablasidx`
--

/*!40000 ALTER TABLE `tablasidx` DISABLE KEYS */;
INSERT INTO `tablasidx` (`idindex`,`tabla`,`campo`,`tipocampo`,`maxvalorc`,`maxvalori`) VALUES 
 (1,'facturas','idfactura','I','0',468),
 (2,'detafactu','idfacturah','I','0',663),
 (3,'cupones','idcupon','I','0',79),
 (4,'detallecobros','iddetacobro','I','0',226),
 (5,'facturasfe','idfe','I','0',162),
 (6,'recibos','idrecibo','I','0',186),
 (7,'cobros','idcobro','I','0',201),
 (8,'facturascta','idcuotafc','I','0',195),
 (9,'cajarecaudah','idcajareh','I','0',509),
 (10,'otmovistockp','idmovip','I','0',182),
 (11,'otmovistockh','idmovih','I','0',194),
 (12,'otejecum','idotejem','I','0',109),
 (13,'otejecuh','idotejeh','I','0',13),
 (14,'ototetapas','idotetapa','I','0',122),
 (15,'otdetaot','idotdet','I','0',12),
 (16,'otpedido','idpedido','I','0',9),
 (17,'otdocumentos','iddocu','I','0',25),
 (18,'logsystem','idlog','I','0',21),
 (19,'otordentra','idot','I','0',32),
 (20,'ottiposobs','idottiposobs','I','0',6),
 (21,'otestadosot','idotestadosot','I','0',10),
 (22,'otmaterialespro','idotmatepro','I','0',509),
 (23,'logsystem','idlog','I','0',21),
 (24,'carterachequed','idcheque','I','0',6),
 (25,'linkcompro','idlinkcomp','I','0',9),
 (26,'anulados','idanulado','I','0',0);
/*!40000 ALTER TABLE `tablasidx` ENABLE KEYS */;


--
-- Definition of table `tarjetacredito`
--

DROP TABLE IF EXISTS `tarjetacredito`;
CREATE TABLE `tarjetacredito` (
  `idtarjeta` int(10) unsigned NOT NULL DEFAULT '0',
  `nombre` char(254) NOT NULL,
  `idbanco` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idtarjeta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tarjetacredito`
--

/*!40000 ALTER TABLE `tarjetacredito` DISABLE KEYS */;
INSERT INTO `tarjetacredito` (`idtarjeta`,`nombre`,`idbanco`) VALUES 
 (1,'CREDITO VISA 3 CTAS',3),
 (2,'CREDITO MASTERCARD',3),
 (3,'CREDITO VISA 6 CTAS',3);
/*!40000 ALTER TABLE `tarjetacredito` ENABLE KEYS */;


--
-- Definition of table `tarjetacuotas`
--

DROP TABLE IF EXISTS `tarjetacuotas`;
CREATE TABLE `tarjetacuotas` (
  `idtarjetacta` int(10) unsigned NOT NULL,
  `idtarjeta` int(10) unsigned NOT NULL,
  `cuotas` int(10) unsigned NOT NULL,
  `razon` float(13,4) NOT NULL,
  PRIMARY KEY (`idtarjetacta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tarjetacuotas`
--

/*!40000 ALTER TABLE `tarjetacuotas` DISABLE KEYS */;
INSERT INTO `tarjetacuotas` (`idtarjetacta`,`idtarjeta`,`cuotas`,`razon`) VALUES 
 (1,1,3,1.0000),
 (2,3,6,1.2000),
 (3,2,1,1.0000);
/*!40000 ALTER TABLE `tarjetacuotas` ENABLE KEYS */;


--
-- Definition of table `tipocajabanco`
--

DROP TABLE IF EXISTS `tipocajabanco`;
CREATE TABLE `tipocajabanco` (
  `idtipocta` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `abrevia` char(50) NOT NULL,
  PRIMARY KEY (`idtipocta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipocajabanco`
--

/*!40000 ALTER TABLE `tipocajabanco` DISABLE KEYS */;
INSERT INTO `tipocajabanco` (`idtipocta`,`detalle`,`abrevia`) VALUES 
 (1,'CAJA','CAJA'),
 (2,'Cuenta Corriente','CTA CTE');
/*!40000 ALTER TABLE `tipocajabanco` ENABLE KEYS */;


--
-- Definition of table `tipocobrosdeta`
--

DROP TABLE IF EXISTS `tipocobrosdeta`;
CREATE TABLE `tipocobrosdeta` (
  `puntovta` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned zerofill NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `idregicomp` int(10) unsigned NOT NULL,
  `tipopago` int(10) unsigned NOT NULL,
  `serie` char(10) NOT NULL,
  `cheque` int(10) unsigned NOT NULL,
  `banco` int(10) unsigned NOT NULL,
  `filial` int(10) unsigned NOT NULL,
  `cp` char(50) NOT NULL,
  `detercero` char(1) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(100) NOT NULL,
  `fechaentre` char(8) NOT NULL,
  `entregadoa` char(254) NOT NULL,
  `fechaemisi` char(8) NOT NULL,
  `fechavence` char(8) NOT NULL,
  `alaordende` char(254) NOT NULL,
  `librador` char(254) NOT NULL,
  `loentrega` char(254) NOT NULL,
  `cuenta` char(50) NOT NULL,
  `idtipocomp` int(10) unsigned NOT NULL,
  `idcartera` int(10) unsigned NOT NULL,
  PRIMARY KEY (`puntovta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipocobrosdeta`
--

/*!40000 ALTER TABLE `tipocobrosdeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipocobrosdeta` ENABLE KEYS */;


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
  PRIMARY KEY (`idtipocompro`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipocompro`
--

/*!40000 ALTER TABLE `tipocompro` DISABLE KEYS */;
INSERT INTO `tipocompro` (`idtipocompro`,`detalle`,`opera`,`abrevia`,`destino`,`editable`,`idafipcom`) VALUES 
 (1,'FACTURA A',1,'FACTURA A','S','N',1),
 (2,'NOTA DE PEDIDO',-1,'NOTA DE PEDIDO','F','S',0),
 (3,'ID AJUSTE DE STOCK',0,'AJUSTE DE STOCK','S','N',0),
 (4,'AJUSTE DE STOCK',0,'STOCK','S','N',0),
 (5,'RECIBO A',0,'RECIBO A','S','N',4),
 (6,'NOTA DE DEBITO A',-1,'ND A','S','N',2),
 (7,'NOTA DE CREDITO A',1,'NC A','S','N',3),
 (8,'FACTURA B',1,'FACTURA B','S','N',5),
 (9,'NOTA DE DEBITO B',-1,'ND B','S','N',6),
 (10,'NOTA DE CREDITO B',1,'NC B','S','N',7),
 (11,'RECIBO B',1,'RECIBOS B','S','N',8),
 (12,'FACTURA C',1,'FACTURA C','S','N',9),
 (13,'NOTA DE DEBITO C',-1,'ND C','S','N',10),
 (14,'NOTA DE CREDITO C',1,'NC C','S','N',11),
 (15,'RECIBO C',1,'RECIBO C','S','N',12),
 (16,'RECIBO',0,'RECIBO','S','N',0);
/*!40000 ALTER TABLE `tipocompro` ENABLE KEYS */;


--
-- Definition of table `tipocuenta`
--

DROP TABLE IF EXISTS `tipocuenta`;
CREATE TABLE `tipocuenta` (
  `idtipo` int(10) unsigned NOT NULL,
  `detalle` char(100) NOT NULL,
  `abrevia` char(50) NOT NULL,
  PRIMARY KEY (`idtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipocuenta`
--

/*!40000 ALTER TABLE `tipocuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipocuenta` ENABLE KEYS */;


--
-- Definition of table `tipodocumento`
--

DROP TABLE IF EXISTS `tipodocumento`;
CREATE TABLE `tipodocumento` (
  `tipodoc` char(3) NOT NULL,
  `tipo` char(3) NOT NULL,
  PRIMARY KEY (`tipodoc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipodocumento`
--

/*!40000 ALTER TABLE `tipodocumento` DISABLE KEYS */;
INSERT INTO `tipodocumento` (`tipodoc`,`tipo`) VALUES 
 ('1','DNI'),
 ('2','CN');
/*!40000 ALTER TABLE `tipodocumento` ENABLE KEYS */;


--
-- Definition of table `tipogrupos`
--

DROP TABLE IF EXISTS `tipogrupos`;
CREATE TABLE `tipogrupos` (
  `idtipogrupo` int(10) unsigned NOT NULL,
  `detalle` char(200) NOT NULL,
  `tabla` char(50) NOT NULL,
  `campo` char(50) NOT NULL,
  `tipoc` char(1) NOT NULL,
  `describir` longtext NOT NULL,
  PRIMARY KEY (`idtipogrupo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipogrupos`
--

/*!40000 ALTER TABLE `tipogrupos` DISABLE KEYS */;
INSERT INTO `tipogrupos` (`idtipogrupo`,`detalle`,`tabla`,`campo`,`tipoc`,`describir`) VALUES 
 (1,'ARTICULOS','articulos','articulo','C','Tipo de Grupos para Clasificacion de Articulos'),
 (2,'CLIENTES','entidades','entidad','I','Clasificacion de Clientes y Proveedores'),
 (5,'MATERIALES OT','otmateriales','idmate','I','Materiales de las Ordenes de Trabajo'),
 (8,'Grupo de Empleados NUEVOS','empleados','idempleado','I','Nuevo'),
 (9,'Bancos','bancos','idbanco','I','');
/*!40000 ALTER TABLE `tipogrupos` ENABLE KEYS */;


--
-- Definition of table `tipomaterial`
--

DROP TABLE IF EXISTS `tipomaterial`;
CREATE TABLE `tipomaterial` (
  `idtipomate` int(10) unsigned NOT NULL,
  `detalle` char(100) NOT NULL,
  `stock` char(1) NOT NULL,
  `horas` char(1) NOT NULL,
  PRIMARY KEY (`idtipomate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipomaterial`
--

/*!40000 ALTER TABLE `tipomaterial` DISABLE KEYS */;
INSERT INTO `tipomaterial` (`idtipomate`,`detalle`,`stock`,`horas`) VALUES 
 (1,'MATERIA PRIMA','S','N'),
 (2,'MANO DE OBRA','N','S');
/*!40000 ALTER TABLE `tipomaterial` ENABLE KEYS */;


--
-- Definition of table `tipomovctap`
--

DROP TABLE IF EXISTS `tipomovctap`;
CREATE TABLE `tipomovctap` (
  `idtipomovi` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `abrevia` char(50) NOT NULL,
  `opera` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idtipomovi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipomovctap`
--

/*!40000 ALTER TABLE `tipomovctap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipomovctap` ENABLE KEYS */;


--
-- Definition of table `tipomovotint`
--

DROP TABLE IF EXISTS `tipomovotint`;
CREATE TABLE `tipomovotint` (
  `idmovotint` int(10) unsigned NOT NULL DEFAULT '0',
  `detalle` char(254) NOT NULL DEFAULT '',
  `operacion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmovotint`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipomovotint`
--

/*!40000 ALTER TABLE `tipomovotint` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipomovotint` ENABLE KEYS */;


--
-- Definition of table `tipomstock`
--

DROP TABLE IF EXISTS `tipomstock`;
CREATE TABLE `tipomstock` (
  `idtipomov` int(10) unsigned NOT NULL,
  `descmov` char(200) NOT NULL,
  `ie` char(1) NOT NULL,
  `reporte` char(100) NOT NULL,
  `generaeti` char(1) NOT NULL,
  `deposito` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idtipomov`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipomstock`
--

/*!40000 ALTER TABLE `tipomstock` DISABLE KEYS */;
INSERT INTO `tipomstock` (`idtipomov`,`descmov`,`ie`,`reporte`,`generaeti`,`deposito`) VALUES 
 (1,'INGRESO POR DEVOLUCION','I','AJUSTE DE STOCK','N',0),
 (2,'EGRESO POR PRODUCCION','E','AJUSTE DE STOCK','N',0),
 (3,'INGRESO POR COMPRA','I','AJUSTE DE STOCK','N',0),
 (4,'EGRESO POR VENTA','E','AJUSTE DE STOCK','N',0),
 (5,'AJUSTE ING. DE INVENTARIO','I','AJUSTE DE STOCK','N',0),
 (6,'AJUSTE EGR. DE INVENTARIO','E','AJUSTE DE STOCK','N',0),
 (7,'EGRESO POR AJUSTE DE STOCK','E','AJUSTE DE STOCK','N',0),
 (8,'INGRESO POR AJUSTE DE STOCK','I','AJUSTE DE STOCK','S',0);
/*!40000 ALTER TABLE `tipomstock` ENABLE KEYS */;


--
-- Definition of table `tiponp`
--

DROP TABLE IF EXISTS `tiponp`;
CREATE TABLE `tiponp` (
  `idtiponp` int(10) unsigned NOT NULL DEFAULT '0',
  `descpe` char(254) NOT NULL,
  `stock` char(1) NOT NULL,
  PRIMARY KEY (`idtiponp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiponp`
--

/*!40000 ALTER TABLE `tiponp` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiponp` ENABLE KEYS */;


--
-- Definition of table `tipooperacion`
--

DROP TABLE IF EXISTS `tipooperacion`;
CREATE TABLE `tipooperacion` (
  `idtipoopera` int(10) unsigned NOT NULL,
  `detalle` char(100) NOT NULL,
  PRIMARY KEY (`idtipoopera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipooperacion`
--

/*!40000 ALTER TABLE `tipooperacion` DISABLE KEYS */;
INSERT INTO `tipooperacion` (`idtipoopera`,`detalle`) VALUES 
 (1,'CTA CTE - SIN CUOTAS'),
 (2,'CTA CTE - CON CUOTAS'),
 (3,'CTADO - EFECTIVO'),
 (4,'CTADO - TARJETA'),
 (5,'CTADO - CHEQUE'),
 (6,'CTADO - DEPOSITO BCO');
/*!40000 ALTER TABLE `tipooperacion` ENABLE KEYS */;


--
-- Definition of table `tipoot`
--

DROP TABLE IF EXISTS `tipoot`;
CREATE TABLE `tipoot` (
  `idtipoot` int(10) unsigned NOT NULL,
  `descot` char(254) NOT NULL,
  PRIMARY KEY (`idtipoot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipoot`
--

/*!40000 ALTER TABLE `tipoot` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipoot` ENABLE KEYS */;


--
-- Definition of table `tipopagos`
--

DROP TABLE IF EXISTS `tipopagos`;
CREATE TABLE `tipopagos` (
  `idtipopago` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idtipopago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipopagos`
--

/*!40000 ALTER TABLE `tipopagos` DISABLE KEYS */;
INSERT INTO `tipopagos` (`idtipopago`,`detalle`) VALUES 
 (1,'EFECTIVO'),
 (2,'DEBITO'),
 (3,'CHEQUE'),
 (4,'CUPONES'),
 (5,'RETENCION');
/*!40000 ALTER TABLE `tipopagos` ENABLE KEYS */;


--
-- Definition of table `toe`
--

DROP TABLE IF EXISTS `toe`;
CREATE TABLE `toe` (
  `idtoe` int(10) unsigned NOT NULL,
  `operacion` char(100) NOT NULL,
  `tabla` char(100) NOT NULL,
  `codigo` char(100) NOT NULL,
  PRIMARY KEY (`idtoe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toe`
--

/*!40000 ALTER TABLE `toe` DISABLE KEYS */;
INSERT INTO `toe` (`idtoe`,`operacion`,`tabla`,`codigo`) VALUES 
 (1,'COSTO FINANCIACION','articulos','0000001'),
 (2,'ND INTERES TARJETA','articulos','0000002');
/*!40000 ALTER TABLE `toe` ENABLE KEYS */;


--
-- Definition of table `toolbarmenu`
--

DROP TABLE IF EXISTS `toolbarmenu`;
CREATE TABLE `toolbarmenu` (
  `usuario` char(15) NOT NULL DEFAULT '',
  `idperfil` int(10) unsigned NOT NULL,
  `idmenu` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toolbarmenu`
--

/*!40000 ALTER TABLE `toolbarmenu` DISABLE KEYS */;
INSERT INTO `toolbarmenu` (`usuario`,`idperfil`,`idmenu`) VALUES 
 ('ADMINISTRADOR',1,13),
 ('TULIO',1,2),
 ('TULIO',1,30),
 ('TULIO',1,6),
 ('TULIO',1,26),
 ('TULIO',1,16),
 ('TULIO',1,15),
 ('TULIO',1,64),
 ('TULIO',1,65);
/*!40000 ALTER TABLE `toolbarmenu` ENABLE KEYS */;


--
-- Definition of table `tranintercta`
--

DROP TABLE IF EXISTS `tranintercta`;
CREATE TABLE `tranintercta` (
  `idmovicta` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `comprobante` char(254) NOT NULL,
  `idtipomovi` int(10) unsigned NOT NULL,
  `idcuentao` int(10) unsigned NOT NULL,
  `idcuentad` int(10) unsigned NOT NULL,
  `contabiliza` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmovicta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tranintercta`
--

/*!40000 ALTER TABLE `tranintercta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tranintercta` ENABLE KEYS */;


--
-- Definition of table `traninterctah`
--

DROP TABLE IF EXISTS `traninterctah`;
CREATE TABLE `traninterctah` (
  `idmovicta` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `tipopago` int(10) unsigned NOT NULL,
  `idcheque` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `importe` float(13,4) NOT NULL,
  PRIMARY KEY (`idmovicta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `traninterctah`
--

/*!40000 ALTER TABLE `traninterctah` DISABLE KEYS */;
/*!40000 ALTER TABLE `traninterctah` ENABLE KEYS */;


--
-- Definition of table `transfeh`
--

DROP TABLE IF EXISTS `transfeh`;
CREATE TABLE `transfeh` (
  `idtransfep` int(10) unsigned NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `idcheque` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `importe` float(13,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transfeh`
--

/*!40000 ALTER TABLE `transfeh` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfeh` ENABLE KEYS */;


--
-- Definition of table `transfep`
--

DROP TABLE IF EXISTS `transfep`;
CREATE TABLE `transfep` (
  `idtransfep` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `comprobante` char(254) NOT NULL,
  `idcuentao` int(10) unsigned NOT NULL,
  `idcuentad` int(10) unsigned NOT NULL,
  `observa` char(254) NOT NULL,
  PRIMARY KEY (`idtransfep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transfep`
--

/*!40000 ALTER TABLE `transfep` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfep` ENABLE KEYS */;


--
-- Definition of table `transporte`
--

DROP TABLE IF EXISTS `transporte`;
CREATE TABLE `transporte` (
  `transporte` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`transporte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transporte`
--

/*!40000 ALTER TABLE `transporte` DISABLE KEYS */;
INSERT INTO `transporte` (`transporte`,`entidad`) VALUES 
 (1,4);
/*!40000 ALTER TABLE `transporte` ENABLE KEYS */;


--
-- Definition of table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `usuario` char(15) NOT NULL DEFAULT '',
  `nombre` char(100) NOT NULL DEFAULT '',
  `clave` char(15) NOT NULL DEFAULT '',
  `email` char(80) NOT NULL,
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`usuario`),
  KEY `usuario` (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--

/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`usuario`,`nombre`,`clave`,`email`,`habilitado`) VALUES 
 ('FEDE','FEDERICO CARRION','F','','S'),
 ('TULIO','Tulio Rossi','A','trossi@cosemar.com.ar','S');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;


--
-- Definition of table `varpublicas`
--

DROP TABLE IF EXISTS `varpublicas`;
CREATE TABLE `varpublicas` (
  `variable` char(50) NOT NULL,
  `tipo` char(1) NOT NULL,
  `valor` char(100) NOT NULL,
  `detalle` char(254) NOT NULL,
  `grupo` char(2) NOT NULL,
  `eliminar` char(1) NOT NULL,
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `varpublicas`
--

/*!40000 ALTER TABLE `varpublicas` DISABLE KEYS */;
INSERT INTO `varpublicas` (`variable`,`tipo`,`valor`,`detalle`,`grupo`,`eliminar`) VALUES 
 ('_SYSPATHARCHIVOS','C','C:\\GitHub\\ProyectoProcessar\\Archivos\\','Variable para guardar archivos compartidos','1','N');
/*!40000 ALTER TABLE `varpublicas` ENABLE KEYS */;


--
-- Definition of table `vendedores`
--

DROP TABLE IF EXISTS `vendedores`;
CREATE TABLE `vendedores` (
  `vendedor` int(10) unsigned NOT NULL DEFAULT '0',
  `nombre` char(200) NOT NULL,
  `domicilio` char(254) NOT NULL,
  `localidad` char(10) NOT NULL,
  `dni` char(20) NOT NULL,
  `telefono` char(100) NOT NULL,
  `email` char(254) NOT NULL,
  `tipodoc` char(3) NOT NULL,
  PRIMARY KEY (`vendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vendedores`
--

/*!40000 ALTER TABLE `vendedores` DISABLE KEYS */;
INSERT INTO `vendedores` (`vendedor`,`nombre`,`domicilio`,`localidad`,`dni`,`telefono`,`email`,`tipodoc`) VALUES 
 (1,'Federico Carrion','Ricardo Gutierrez 1962','1','38374141','3483485750','fedecarrion137@gmail.com','2'),
 (2,'Tulio Rossi','Avellaneda 6963','3','25826321','3424376983','tulior@cosemar.com','1'),
 (3,'Javier','Pampa 232','1','35555666','3483485751','javi@gmail.com','2'),
 (4,'ROXANA','1 DE MAYO','4','3692815','498389','roxy@gmail.com','1'),
 (7,'CLAUDIO','25 DE MAYO','5','1231333','12312','ASDA','1'),
 (8,'AAAAAAA','AAAAAAAAAA','1','22141491','ASSSA','DSD','1');
/*!40000 ALTER TABLE `vendedores` ENABLE KEYS */;


--
-- Definition of table `zonas`
--

DROP TABLE IF EXISTS `zonas`;
CREATE TABLE `zonas` (
  `zona` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`zona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zonas`
--

/*!40000 ALTER TABLE `zonas` DISABLE KEYS */;
INSERT INTO `zonas` (`zona`,`detalle`) VALUES 
 (1,'MARGARITA - SAN JUSTO'),
 (2,'SANTA FE - ROSARIO');
/*!40000 ALTER TABLE `zonas` ENABLE KEYS */;

--
-- Create schema admindb
--

CREATE DATABASE IF NOT EXISTS admindb;
USE admindb;

--
-- Definition of table `bibliotecaf`
--

DROP TABLE IF EXISTS `bibliotecaf`;
CREATE TABLE `bibliotecaf` (
  `nombre` char(50) NOT NULL,
  `parametros` char(100) NOT NULL,
  `tipo` char(1) NOT NULL,
  `detalle` char(254) NOT NULL,
  `libreria` char(50) NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bibliotecaf`
--

/*!40000 ALTER TABLE `bibliotecaf` DISABLE KEYS */;
INSERT INTO `bibliotecaf` (`nombre`,`parametros`,`tipo`,`detalle`,`libreria`) VALUES 
 ('FUNCION1','TITULO, ID','F','FUNCION 1 BLA BLA BLA BLAAAAA','LIBRERIA1'),
 ('FUNCION2','PARAMETRO1, PARAMETRO2','P','DAKDLADKASDASDJASLKDAJSDKLSKDALL','LIBRERIA2');
/*!40000 ALTER TABLE `bibliotecaf` ENABLE KEYS */;


--
-- Definition of table `esquemas`
--

DROP TABLE IF EXISTS `esquemas`;
CREATE TABLE `esquemas` (
  `idesquema` int(11) NOT NULL DEFAULT '0',
  `descrip` char(50) NOT NULL DEFAULT '',
  `schemma` char(25) NOT NULL DEFAULT '',
  `driver` char(50) NOT NULL DEFAULT '',
  `host` char(50) NOT NULL DEFAULT '',
  `port` char(4) NOT NULL DEFAULT '3306',
  `usuario` char(20) NOT NULL DEFAULT '',
  `password` char(25) NOT NULL DEFAULT '',
  `fondo` char(200) NOT NULL DEFAULT 'N',
  `colorfondo` char(200) NOT NULL,
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  `idempresa` int(10) unsigned NOT NULL,
  `idsucursal` int(10) unsigned NOT NULL,
  `path` varchar(80) NOT NULL,
  PRIMARY KEY (`idesquema`),
  KEY `schemma` (`schemma`),
  KEY `usuario` (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `esquemas`
--

/*!40000 ALTER TABLE `esquemas` DISABLE KEYS */;
INSERT INTO `esquemas` (`idesquema`,`descrip`,`schemma`,`driver`,`host`,`port`,`usuario`,`password`,`fondo`,`colorfondo`,`habilitado`,`idempresa`,`idsucursal`,`path`) VALUES 
 (1,'Processar','trsoftdb','{MySQL ODBC 3.51 Driver}','192.168.150.100','3306','tulior','owntod93','N','8454016','S',1,1,''),
 (2,'Processar Krumbein','trsoftdb','{MySQL ODBC 3.51 Driver}','186.38.115.2','3306','mysqladmin','krumbein405','N','8454016','S',1,1,' '),
 (3,'PROCESSAR 01','proce01','{MySQL ODBC 3.51 Driver}','192.168.100.2','3306','tulior','owntod93','','8454016','S',1,1,''),
 (4,'PROCE1','proce1','{MySQL ODBC 3.51 Driver}','192.168.100.2','3306','tulior','owntod93','N','8454016','S',1,1,''),
 (5,'Esquema Clonado Processar','processar','{MySQL ODBC 3.51 Driver}','192.168.100.2','3306','tulior','owntod93','N','8454016','S',1,1,'');
/*!40000 ALTER TABLE `esquemas` ENABLE KEYS */;


--
-- Definition of table `iconos`
--

DROP TABLE IF EXISTS `iconos`;
CREATE TABLE `iconos` (
  `idicono` int(10) unsigned NOT NULL,
  `nombre` char(50) NOT NULL,
  `archivo` char(50) NOT NULL,
  `tooltip` char(50) NOT NULL,
  `teclafn` char(50) NOT NULL,
  PRIMARY KEY (`idicono`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `iconos`
--

/*!40000 ALTER TABLE `iconos` DISABLE KEYS */;
INSERT INTO `iconos` (`idicono`,`nombre`,`archivo`,`tooltip`,`teclafn`) VALUES 
 (0,'cerrar','cerrar.png','Cerrar',''),
 (1,'editar','editar.png','Editar',''),
 (2,'eliminar','eliminar.png','Eliminar',''),
 (3,'guardar','guardar.png','Guardar',''),
 (4,'imprimir','imprimir.png','Imprimir',''),
 (5,'nuevo','nuevo.png','Nuevo','F5'),
 (6,'cancelar','cancelar.png','Cancelar',''),
 (7,'actualizar','actualizar.png','Actualizar',''),
 (8,'credito','peso.png','Crédito',''),
 (9,'empleado','empleado.png','Empleados / Contactos',''),
 (10,'servicios','perfil.png','Servicios - Sub Cuentas',''),
 (11,'importar','subir.png','Importar desde archivo',''),
 (12,'nuevo1','nuevo1.png','Nuevo','F5'),
 (13,'editar1','editar1.png','Editar',''),
 (14,'anular','eliminar2.png','Anular',''),
 (15,'buscar1','buscar1.png','buscar',''),
 (16,'ayuda','info1.png','Ayuda',''),
 (17,'entidad','entidad.png','Entidad',''),
 (18,'materiales','materiales.png','Materiales','F4'),
 (19,'materiales1','materiales1.png','Materiales','F4');
/*!40000 ALTER TABLE `iconos` ENABLE KEYS */;


--
-- Definition of table `modulossys`
--

DROP TABLE IF EXISTS `modulossys`;
CREATE TABLE `modulossys` (
  `idmodulo` int(10) unsigned NOT NULL,
  `modulo` char(254) NOT NULL,
  `habilitado` char(1) NOT NULL,
  PRIMARY KEY (`idmodulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `modulossys`
--

/*!40000 ALTER TABLE `modulossys` DISABLE KEYS */;
INSERT INTO `modulossys` (`idmodulo`,`modulo`,`habilitado`) VALUES 
 (1,'modulo 1','1'),
 (2,'modulo 2','1');
/*!40000 ALTER TABLE `modulossys` ENABLE KEYS */;


--
-- Definition of table `settoolbarsys`
--

DROP TABLE IF EXISTS `settoolbarsys`;
CREATE TABLE `settoolbarsys` (
  `idset` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form` char(100) NOT NULL,
  `idobjeto` char(2) NOT NULL,
  `icono` char(100) NOT NULL,
  `funcion` char(100) NOT NULL,
  `habilita` char(1) NOT NULL,
  `visible` char(1) NOT NULL,
  `tooltip` char(100) NOT NULL,
  `active` char(1) NOT NULL,
  PRIMARY KEY (`idset`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settoolbarsys`
--

/*!40000 ALTER TABLE `settoolbarsys` DISABLE KEYS */;
INSERT INTO `settoolbarsys` (`idset`,`form`,`idobjeto`,`icono`,`funcion`,`habilita`,`visible`,`tooltip`,`active`) VALUES 
 (1,'provinciasabm','14','cerrar1.png','cerrar()','1','1','Cerrar Otro','1'),
 (2,'provinciasabm','08','imprimir1.png','imprimir()','1','1','Imprimir','1'),
 (3,'_screen','01','cerrar1.png','salirmenu()','1','1','Cerrar Sistema','0'),
 (4,'provinciasabm','12','','filtrar()','1','1','Ingrese Texto','1'),
 (5,'provinciasabm','13','buscar1.png','filtrar()','1','1','Buscar','1'),
 (6,'serviciosabm2','14','cerrar1.png','cerrar()','1','1','Cerrar','1'),
 (7,'serviciosabm2','01','imprimir1.png','imprimir()','1','1','Imprimir','1'),
 (8,'serviciosabm2','12','','filtrar()','1','1','Ingrese Texto','1'),
 (9,'serviciosabm2','13','buscar1.png','filtrar()','1','1','Buscar','1'),
 (10,'toolbarsysabm','13','cerrar1.png','cerrar()','1','1','Cerrar','1'),
 (11,'entidades','14','cerrar1.png','cerrar()','1','1','Cerrar','1'),
 (14,'toolbarsysabm','10','actualizar1.png','actualizar()','1','1','Actualizar Barra','1'),
 (15,'toolbarsysabm','01','nuevo1.png','nuevo()','1','1','Nuevo','1'),
 (16,'lineasabm','14','cerrar1.png','cerrar()','1','1','Cerrar','1'),
 (17,'lineasabm','12','','filtrar()','1','1','Buscar Texto','1'),
 (18,'toolbarsysabm','02','gurdar1.png','guardar()','1','1','Guardar','1'),
 (19,'toolbarsysabm','12','','filtrar()','1','0','Ingrese Texto','1'),
 (20,'empresasabm','18','cerrar1.png','cerrar()','1','1','Cerrar','1'),
 (21,'articulos','20','cerrar1.png','cerrar()','1','1','Cerrar','1'),
 (23,'articulos','01','nuevo1.png','nuevo','1','0','Nuevo Artículo','1'),
 (24,'articulos','03','gurdar1.png','guardar','1','1','Guardar','1'),
 (25,'articulos','04','eliminar1.png','eliminar','1','1','Eliminar Artículo','1'),
 (26,'articulos','02','cancelar1.png','cancelar','1','1','Cancelar','1'),
 (27,'articulos','06','editar1.png','modificar','1','1','Modificar','1'),
 (28,'entidades','06','peso1.png','credito','1','1','Crédito','1'),
 (29,'zonasabm','19','cerrar1.png','cerrar()','1','1','Cerrar Zona','1'),
 (30,'entidades','01','nuevo1.png','nuevo()','1','1','Nuevo','1'),
 (31,'entidades','02','editar1.png','modificar()','1','1','Modificar','1'),
 (34,'entidades','07','empleado1.png','empleados()','1','1','Empleados / Contactos','1'),
 (35,'entidades','05','imprimir1.png','imprimir()','1','1','Imprimir','1'),
 (36,'entidades','03','eliminar1.png','eliminar','1','1','Eliminar','1'),
 (37,'toolbarsysabm','03','eliminar1.png','eliminar()','1','1','Eliminar','1'),
 (38,'toolbarsysabm','04','imprimir1.png','imprimir','1','1','Imprimir','1'),
 (39,'iconosabm','14','cerrar1.png','cerrar()','1','1','Cerrar','1'),
 (40,'articulos','05','imprimir1.png','imprimir','1','1','Imprimir','1'),
 (41,'facturas','20','cerrar1.png','cerrar()','1','1','','1'),
 (42,'otpedidos','20','cerrar1.png','cerrar','1','1','Cerrar','1'),
 (43,'otejecum','20','cerrar1.png','cerrar','1','1','Cerrar','1'),
 (44,'otejecum','01','gurdar1.png','guardar','1','1','Guardar','1'),
 (45,'otejecum','03','buscar1.png','buscarotMateriales','1','1','Buscar Materiales','1'),
 (46,'otejecum','02','buscar1.png','buscarot','1','1','Buscar OT','1'),
 (47,'otmovistock','01','gurdar1.png','guardar','1','1','Guardar','1'),
 (48,'otmovistock','02','imprimir1.png','imprimir','1','1','Imprimir','1'),
 (49,'otmovistock','03','entidad1.png','buscarentidades','1','1','Entidades','1'),
 (50,'otmovistock','20','cerrar1.png','cerrar','1','1','Cerrar','1'),
 (51,'otmateriales','01','nuevo1.png','nuevo','1','1','Nuevo','1'),
 (52,'otmateriales','02','cancelar1.png','cancelar','1','1','Cancelar','1'),
 (53,'otmateriales','03','gurdar1.png','guardar','1','1','Guardar','1'),
 (54,'otmateriales','04','eliminar1.png','eliminar','1','1','Eliminar','1'),
 (55,'otmateriales','05','imprimir1.png','imprimir','1','1','Imprimir','1'),
 (56,'otmateriales','06','actualizar1.png','actualizar','1','1','Actualizar','1'),
 (57,'otmateriales','07','subir1.png','importarLista','1','1','Importar LIsta','1'),
 (58,'otmateriales','20','cerrar1.png','cerrar','1','1','Cerrar','1'),
 (59,'otetapas','01','nuevo1.png','nuevo','1','1','Nuevo','1'),
 (60,'otetapas','02','cancelar1.png','cancelar','1','1','Cancelar','1'),
 (61,'otetapas','03','gurdar1.png','guardar','1','1','Guardar','1'),
 (62,'otetapas','04','eliminar1.png','eliminar','1','1','Eliminar','1'),
 (63,'otetapas','05','imprimir1.png','imprimir','1','1','Imprimir','1'),
 (64,'otetapas','20','cerrar1.png','cerrar','1','1','Cerrar','1'),
 (65,'buscaotmateriales','01','ok1.png','seleccionar','1','1','Seleccionar','1'),
 (66,'buscaotmateriales','20','cerrar1.png','cerrar','1','1','Salir','1'),
 (67,'otlistadostock','01','imprimir1.png','imprimir','1','1','Imprimir','1'),
 (68,'otlistadostock','02','materiales1.png','buscarotMateriales','1','1','Materiales','1'),
 (69,'otlistadostock','20','cerrar1.png','cerrar','1','1','Cerrar','1'),
 (70,'otconsultamovistock','20','cerrar1.png','cerrar','1','1','Cerrar','1'),
 (71,'otconsultamovistock','19','materiales1.png','buscarotmateriales','1','1','Materiales','1'),
 (72,'reporteform','20','cerrar1.png','cerrar()','1','1','Cerrar','1');
/*!40000 ALTER TABLE `settoolbarsys` ENABLE KEYS */;


--
-- Definition of table `varpublicas`
--

DROP TABLE IF EXISTS `varpublicas`;
CREATE TABLE `varpublicas` (
  `variable` char(50) NOT NULL,
  `tipo` char(1) NOT NULL,
  `valor` char(100) NOT NULL,
  `detalle` char(254) NOT NULL,
  `grupo` char(2) NOT NULL,
  `eliminar` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `varpublicas`
--

/*!40000 ALTER TABLE `varpublicas` DISABLE KEYS */;
INSERT INTO `varpublicas` (`variable`,`tipo`,`valor`,`detalle`,`grupo`,`eliminar`) VALUES 
 ('_SYSADMIN','C','admin','Usuario administrador para acceso a configuracion de Menues','1','S'),
 ('_SYSBMPFONDO','C','\"\"','Archivo con Imagen de Fondo','1','S'),
 ('_SYSCAJARECA','N','0','Variable control de grabación de caja recaudadora','1','N'),
 ('_SYSCOLORFONDO','C','RGB(192,192,192)','Color del Fondo de Sistema','1','S'),
 ('_SYSCONCEPTOAFIP','N','1','Guarda Concepto AFIP (1: Prod. 2: Serv. 3: Productos y Servicios','','S'),
 ('_SYSDESCRIP','C','Administración Principal','Descripcion de la Base de Datos conectada','1','S'),
 ('_SYSESTACION','C','C:\\TRSofttmp','Carpeta de destino de los archivos borrados','1','S'),
 ('_SYSLONGCART','N','10','Longitud de codificacion de Articulos','1','S'),
 ('_SYSLONGCMAT','N','10.00','Longitud de codigicacion de materiales','1','N'),
 ('_SYSPAPELERA','C','RECYCLE','Indica si los delete van a parar a la papelera','1','S'),
 ('_SYSPASSADMIN','C','1','Password para usuario administrador de Menues y seteos','1','S'),
 ('_SYSREPORTES','C','reportes','Ubicacion dentro del Sistema de los Reportes','1','N'),
 ('_SYSTITULO','C','TRSoft V0','Titulo para arranque del sistema en la barra superior','1','S');
/*!40000 ALTER TABLE `varpublicas` ENABLE KEYS */;

--
-- Create schema trsoftdb
--

CREATE DATABASE IF NOT EXISTS trsoftdb;
USE trsoftdb;

--
-- Definition of function `idmate`
--

DROP FUNCTION IF EXISTS `idmate`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` FUNCTION `idmate`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @idmate $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `articulostock`
--

DROP TABLE IF EXISTS `articulostock`;
DROP VIEW IF EXISTS `articulostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `articulostock` AS select `h`.`articulo` AS `articulo`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `h`.`cantidad`)) AS `stockTot` from (`ajustestockh` `h` left join `tipomstock` `t` on((`h`.`idtipomov` = `t`.`idtipomov`))) where (not(`h`.`articulo` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'articulos') and (`a`.`idestador` = 2))))) group by `h`.`articulo`;

--
-- Definition of view `depostock`
--

DROP TABLE IF EXISTS `depostock`;
DROP VIEW IF EXISTS `depostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,`u`.`stockTot` AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `a`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin` from (((`ajustestockh` `a` left join `tipomstock` `t` on((`a`.`idtipomov` = `t`.`idtipomov`))) left join `articulos` `m` on((`a`.`articulo` = `m`.`articulo`))) left join `articulostock` `u` on((`a`.`articulo` = `u`.`articulo`))) where (not(`a`.`idajuste` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'articulos') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;

--
-- Definition of view `facturasaldo`
--

DROP TABLE IF EXISTS `facturasaldo`;
DROP VIEW IF EXISTS `facturasaldo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturasaldo` AS select `f`.`idfactura` AS `idfactura`,ifnull(sum(`c`.`imputado`),0) AS `cobrado`,(`f`.`total` - ifnull(sum(`c`.`imputado`),0)) AS `saldof` from (`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`))) group by `f`.`idfactura`;

--
-- Definition of view `maxidestados`
--

DROP TABLE IF EXISTS `maxidestados`;
DROP VIEW IF EXISTS `maxidestados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `maxidestados` AS select max(`estadosreg`.`idestadosreg`) AS `maxid`,`estadosreg`.`tabla` AS `tabla`,`estadosreg`.`campo` AS `campo`,`estadosreg`.`id` AS `id` from `estadosreg` group by `estadosreg`.`tabla`,`estadosreg`.`campo`,`estadosreg`.`id`;

--
-- Definition of view `otdepostock`
--

DROP TABLE IF EXISTS `otdepostock`;
DROP VIEW IF EXISTS `otdepostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otdepostock` AS select `o`.`iddepo` AS `iddepo`,`o`.`idmate` AS `idmate`,`o`.`codigomat` AS `codigomat`,`m`.`detalle` AS `nombremat`,`u`.`stockTot` AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `o`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin`,`v`.`stock` AS `constock`,`v`.`horas` AS `horas` from ((((`otmovistockh` `o` left join `tipomstock` `t` on((`o`.`idtipomov` = `t`.`idtipomov`))) left join `otmateriales` `m` on((`o`.`idmate` = `m`.`idmate`))) left join `otmatestock` `u` on((`o`.`idmate` = `u`.`idmate`))) left join `tipomaterial` `v` on((`m`.`idtipomate` = `v`.`idtipomate`))) where (not(`o`.`idmovip` in (select `otmovianul`.`idmovip` from `otmovianul`))) group by `o`.`iddepo`,`o`.`idmate`;

--
-- Definition of view `otmatestock`
--

DROP TABLE IF EXISTS `otmatestock`;
DROP VIEW IF EXISTS `otmatestock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otmatestock` AS select `o`.`idmate` AS `idmate`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `o`.`cantidad`)) AS `stockTot` from (`otmovistockh` `o` left join `tipomstock` `t` on((`o`.`idtipomov` = `t`.`idtipomov`))) where (not(`o`.`idmovip` in (select `otmovianul`.`idmovip` from `otmovianul`))) group by `o`.`idmate`;

--
-- Definition of view `totalclientes`
--

DROP TABLE IF EXISTS `totalclientes`;
DROP VIEW IF EXISTS `totalclientes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `totalclientes` AS select sum(`entidades`.`entidad`) AS `totentidad` from `entidades`;

--
-- Definition of view `ultimoestado`
--

DROP TABLE IF EXISTS `ultimoestado`;
DROP VIEW IF EXISTS `ultimoestado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultimoestado` AS select `e`.`tabla` AS `tabla`,`e`.`campo` AS `campo`,`e`.`id` AS `id`,`e`.`idestador` AS `idestador`,`e`.`tipo` AS `tipo` from (`maxidestados` `m` left join `estadosreg` `e` on((`m`.`maxid` = `e`.`idestadosreg`)));

--
-- Definition of view `vw_stock`
--

DROP TABLE IF EXISTS `vw_stock`;
DROP VIEW IF EXISTS `vw_stock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_stock` AS select ((select sum(`o`.`cantidad`) AS `ingresado` from `otmovistockh` `o` where ((`o`.`idtipomov` = 3) and (`o`.`codigomat` = `trsoftdb`.`idmate`()))) - (select sum(`o`.`cantidad`) AS `egresado` from `otmovistockh` `o` where ((`o`.`idtipomov` = 4) and (`o`.`codigomat` = `trsoftdb`.`idmate`())))) AS `stock`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
