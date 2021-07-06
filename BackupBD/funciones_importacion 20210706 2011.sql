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
  `nombregene` char(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`idcomproba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comprobantes`
--

/*!40000 ALTER TABLE `comprobantes` DISABLE KEYS */;
INSERT INTO `comprobantes` (`idcomproba`,`comprobante`,`idtipocompro`,`tipo`,`tabla`,`ctacte`,`astoconta`,`nombregene`) VALUES 
 (1,'FACTURA A',1,'A','facturas','S','S','FACTURAS / NC / ND'),
 (3,'AJUSTE DE STOCK',4,'X','ajustestockp','N','S','AJUSTE DE STOCK ARTICULOS'),
 (4,'FACTURAE',1,'A','facturas','S','S','FACTURAS / NC / ND'),
 (5,'RECIBO A',5,'A','recibos','S','S','RECIBOS'),
 (6,'AJUSTE STOCK DE MATERIALES',4,'X','otmovistockp','N','N','AJUSTE STOCK MATERIALES'),
 (7,'NOTA DE DEBITO A',6,'A','facturas','S','N','FACTURAS / NC / ND'),
 (8,'NOTA DE CREDITO A',7,'A','facturas','S','N','FACTURAS / NC / ND'),
 (9,'NOTA DE CREDITO A',7,'A','facturas','S','N','FACTURAS / NC / ND'),
 (10,'FACTURA B',8,'B','facturas','S','N',''),
 (11,'NOTA DE CREDITO B',10,'B','facturas','S','N',''),
 (12,'NOTA DE DEBITO B',9,'B','facturas','S','N',''),
 (13,'RECIBO B',11,'B','recibos','S','N',''),
 (14,'RECIBO',16,'X','recibos','S','N',''),
 (15,'REMITO R',17,'R','remitos','N','S','REMITOS'),
 (16,'NOTA DE PEDIDO',2,'X','np','N','N','NOTAS DE PEDIDO'),
 (17,'FACTURA PROV A',18,'A','factuprove','S','S','COMPROBANTES DE PROVEEDORES'),
 (18,'FACTURA PROV B',19,'B','factuprove','S','S',''),
 (19,'FACTURA PROV C',20,'C','factuprove','S','N',''),
 (20,'ORDEN DE PAGO',21,'X','pagosprov','S','S','ORDENES DE PAGO'),
 (21,'NOTA DE CREDITO PROV A',22,'A','factuprove','S','N',''),
 (22,'CAJA INGRESO',28,'X','cajaie','N','S','CAJA INGRESO / EGRESO'),
 (23,'CAJA EGRESO',29,'X','cajaie','N','S',''),
 (24,'FACTURA A MiPyMEs',30,'A','facturas','S','N',''),
 (25,'TRANSFERENCIAS',39,'T','transferencias','S','S','TRANSFERENCIAS'),
 (26,'TRANSFERENCIA DE CAJA',40,'T','cajamovip','N','S','TRANSFERENCIAS DE CAJA'),
 (27,'ANULA RECIBOS',41,'X','anularp','N','N','ANULACION RECIBOS ORDENES DE PAGO'),
 (28,'ANULA ORDEN PAGO',42,'X','anularp','N','N',''),
 (29,'LIQUIDACION CUPONES',43,'A','factuprove','S','N',''),
 (30,'NC DE AJUSTE CTA CTE',7,'X','facturas','S','N',''),
 (31,'ND DE AJUSTE CTA CTE',6,'X','facturas','S','N',''),
 (32,'NC DE AJUSTE CTA CTE PROV',22,'X','factuprove','S','N',''),
 (33,'ND DE AJUSTE CTA CTE PROV',25,'X','factuprove','S','N',''),
 (34,'FACTURA A MiPyME',30,'A','facturas','S','S',''),
 (35,'NOTA DE CREDITO A MIPYME',31,'A','facturas','S','S',''),
 (36,'NOTA DE CREDITO A',7,'A','facturas','S','S',''),
 (37,'CUMPLIMENTACION NP',44,'X','cumplimentap','N','N','CUMPLIMENTACION');
/*!40000 ALTER TABLE `comprobantes` ENABLE KEYS */;


--
-- Definition of table `importadatos`
--

DROP TABLE IF EXISTS `importadatos`;
CREATE TABLE `importadatos` (
  `idimporta` int(10) unsigned NOT NULL DEFAULT '0',
  `detalle` char(100) NOT NULL,
  `funcion` char(100) NOT NULL,
  `tabla` char(50) NOT NULL,
  `habilitado` char(1) NOT NULL,
  `describir` text NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idimporta`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `importadatos`
--

/*!40000 ALTER TABLE `importadatos` DISABLE KEYS */;
INSERT INTO `importadatos` (`idimporta`,`detalle`,`funcion`,`tabla`,`habilitado`,`describir`,`servicio`) VALUES 
 (1,'Carga Archivos Medicion de Telefonia','CargaHuawei','medtelefono','S','Carga de Mediciones de Telefonia -  DESCRIPCION  -  DE ARCHIVO\r\nSADSF\r\n}ASD\r\nASDF\r\nAS\r\nFAS\r\nSDA\r\nFDAS\r\nFSDA\r\nSFD\r\nSFD\r\nFSDFDS\r\nDF',0),
 (2,'Importacion Calling Party Pay - CPP','CargaCPP','cpptelefono','S','',0),
 (3,'Importacion de Facturacion de CLARO Telefonia Celular','CargaClaro','factclaro','S','Carga los detalles de la Facturación de Claro Telefonia Celular',0),
 (4,'Importacion de Mediciones de AGUA POTABLE','CargaMservicios','mservicios','S','Carga de Mediciones de acurdo al servicio Seleccionado',2),
 (5,'Carga Cablemodems FlowDat','CargaCablemodem','cablemodems','S','Carga Existencias de Cablemodems por Periodos',0),
 (6,'Importacion Mediciones ENERGIA ELECTRICA','CargaMservicios','mservicios','S','',3),
 (7,'Importación de Entidades','CargaEntidades','entidades','S','Importación de Entidades. Elimina las Entidades Cargadas, tener en cuenta que realiza un blanqueo de los datos existentes y carga los nuevos .\r\nDescripcion de Archivo de Importación.\".csv\" separado por \";\"\r\n\r\nentidad I\r\napellido C(100)\r\nnombre c(100)\r\ncargo C(100)\r\ncompania C(100)\r\ncuit C(13)\r\ndireccion C(100)\r\nlocalidad C(10)\r\niva I\r\nfechaalta C(8)\r\ntelefono C(50)\r\ncp C(50)\r\nfax C(50)\r\nemail C(254)\r\nweb C(254)\r\ndni I\r\ntipodoc C(3)\r\nfechanac C(8)\r\nidafiptipd I			\r\n',0),
 (8,'Carga de Sub-Cuentas de Entidades','CargaSubEntidades','entidadesh','S','Carga de Sub-Cuentas de Entidades. Tener en Cuenta que Elimina las Sub-Cuentas Existentes. Se debe realizar solo una vez al Inicializar la Base de Datos.\r\nArchivo de Importación en .csv separado por \";\"\r\n\r\nentidad I\r\nservicios I\r\ncuenta I\r\napellido C(100)\r\nnombre c(100)\r\ncargo C(100)\r\ncompania C(100)\r\ncuit C(13)\r\ndireccion C(100)\r\nlocalidad C(10)\r\niva I\r\nfechaalta C(8)\r\ntelefono C(50)\r\ncp C(50)\r\nfax C(50)\r\nemail C(254)\r\ndni I\r\ntipodoc C(3)\r\nfechanac C(8)\r\nruta1 I\r\nfolio1 I\r\nruta2 I\r\nfolio2 I\r\nidentidadh I\r\nidafiptipd I 			\r\n',0),
 (9,'Importación de Localidades','CargaLocalidades','localidades','S','',0),
 (10,'Carga de Artículos','CargaArticulos','articulos','S','articulo C(50), detalle C(254), unidad C(200), abrevia C(50), codbarra C(100), costo n(13,4), linea C(20),\r\nctrlstock C(1), observa C(254), ocultar C(1), stockmin N(13,4), desc1 N(13,4), desc2 N(13,4), desc3 N(13,4), desc4 N(13,4), desc5 N(13,4), moneda I, impuesto I, margen N(13,4),proveedor I,codigop C(50)',0),
 (11,'Carga Cta Cte de Clientes','CargaCtaCteClientes','facturas','S','Carga comprobantes de Ingreso y Egreso para modificar las cuentas corrientes de los clientes, desde un archivo cuyo formato es: entidad I,servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8)',0),
 (12,'Carga Cta Cte de Proveedores','CargaCtaCteProveedores','factuprove','S','Carga comprobantes de Ingreso y Egreso para modificar las cuentas corrientes de los clientes, desde un archivo cuyo formato es: entidad I,servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8)',0);
/*!40000 ALTER TABLE `importadatos` ENABLE KEYS */;


--
-- Definition of table `importadatosp`
--

DROP TABLE IF EXISTS `importadatosp`;
CREATE TABLE `importadatosp` (
  `idimportap` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idimporta` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `fechad` char(8) NOT NULL,
  `fechah` char(8) NOT NULL,
  `fecha` char(8) NOT NULL,
  `observa` char(254) NOT NULL,
  PRIMARY KEY (`idimportap`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `importadatosp`
--

/*!40000 ALTER TABLE `importadatosp` DISABLE KEYS */;
INSERT INTO `importadatosp` (`idimportap`,`idimporta`,`secuencia`,`fechad`,`fechah`,`fecha`,`observa`) VALUES 
 (2,1,2,'20200615','20200615','20200630','BBBBBBBBBBB'),
 (3,2,1,'20200615','20200615','20200312','Carga archivo CCP'),
 (4,3,1,'20200301','20200317','20200317','C:/TEMP/201508.xml'),
 (5,3,2,'20200901','20200930','20200318','OTRA CARGA'),
 (9,4,1,'20200301','20200325','20200325',''),
 (10,4,2,'20200901','20200925','20200926',''),
 (11,5,1,'20200301','20200326','20200326','C:TEMPcablemodem.csv'),
 (12,3,3,'20200401','20200430','20200420','C:TEMP202004.xml'),
 (13,6,1,'20200901','20200930','20200901',''),
 (14,9,1,'20201201','20201210','20201210',''),
 (15,11,1,'20210301','20210325','20210325',''),
 (16,11,2,'20210301','20210327','20210327',''),
 (17,1,3,'20210301','20210327','20210327',''),
 (18,11,3,'20210301','20210327','20210327',''),
 (19,11,4,'20210301','20210327','20210327',''),
 (20,11,5,'20210301','20210327','20210327',''),
 (21,11,6,'20210301','20210327','20210327',''),
 (22,11,7,'20210301','20210327','20210327',''),
 (23,11,8,'20210301','20210329','20210329',''),
 (24,11,9,'20210301','20210329','20210329',''),
 (25,11,10,'20210301','20210329','20210329',''),
 (26,11,11,'20210301','20210329','20210329',''),
 (27,11,12,'20210301','20210329','20210329',''),
 (28,11,13,'20210301','20210329','20210329',''),
 (29,11,14,'20210301','20210330','20210330',''),
 (30,12,1,'20210401','20210414','20210414','');
/*!40000 ALTER TABLE `importadatosp` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
