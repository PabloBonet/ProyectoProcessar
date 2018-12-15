-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.37-MariaDB-0+deb9u1


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
  `tipo` char(1),
  `fechaEst` char(16)
);

--
-- Temporary table structure for view `vw_stock`
--
DROP TABLE IF EXISTS `vw_stock`;
DROP VIEW IF EXISTS `vw_stock`;
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
 (1,'Processar','trsoftdb','{MySQL ODBC 3.51 Driver}','10.0.0.3','3306','tulior','owntod93','N','8454016','S',1,1,'');
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
 ('_SYSTITULO','C','Processar V1','Titulo para arranque del sistema en la barra superior','1','S');
/*!40000 ALTER TABLE `varpublicas` ENABLE KEYS */;

--
-- Create schema trsoftdb
--

CREATE DATABASE IF NOT EXISTS trsoftdb;
USE trsoftdb;

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
 (1,'1','IVA','NO GRAVADO'),
 (2,'2','IVA','EXENTO'),
 (3,'3','IVA','IVA 0 %'),
 (4,'4','IVA','IVA 10.5%'),
 (5,'5','IVA','IVA 21%'),
 (6,'6','IVA','IVA 27%');
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
  `idajustestocke` int(10) unsigned NOT NULL,
  `idajusteh` int(10) unsigned NOT NULL,
  `etiqueta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idajustestocke`) USING BTREE
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
  `neto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `deposito` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idajusteh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajustestockh`
--

/*!40000 ALTER TABLE `ajustestockh` DISABLE KEYS */;
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
  `idtipomov` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idajuste`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajustestockp`
--

/*!40000 ALTER TABLE `ajustestockp` DISABLE KEYS */;
INSERT INTO `ajustestockp` (`idajuste`,`puntov`,`numero`,`fecha`,`entidad`,`nombre`,`responsable`,`observa1`,`observa2`,`observa3`,`observa4`,`idtipomov`,`idcomproba`,`pventa`) VALUES 
 (1,'0001',1,'20170304',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (2,'0001',2,'20170304',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',1,0,0),
 (3,'0001',3,'20170306',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (4,'0001',4,'20170306',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',1,0,0),
 (5,'0001',5,'20170306',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','','','','',1,0,0),
 (6,'0001',6,'20170724',1,'ROSSI TULIO','FEDE','','','','',2,0,0),
 (7,'0001',7,'20170731',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','1','2','3','',1,0,0),
 (8,'0001',8,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','',1,0,0),
 (9,'0001',9,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','',1,0,0),
 (10,'0001',10,'20171009',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (11,'0001',11,'20171009',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (12,'0001',12,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','',1,0,0),
 (13,'0001',13,'20171009',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (14,'0001',14,'20171009',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (15,'0001',15,'20171009',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (16,'0001',16,'20170804',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','FEDE','PRUEBA','','','',1,0,0),
 (18,'0001',18,'20171010',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (19,'0001',19,'20171010',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (20,'0001',20,'20171010',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (21,'0001',21,'20171010',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (22,'0001',22,'20171010',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (23,'0001',23,'20180131',1,'ROSSI TULIO','TULIO','','','','',2,0,0),
 (24,'0001',24,'20180131',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','TULIO','','','','',2,0,0),
 (25,'0001',25,'20171010',1,'ROSSI TULIO','FEDE','','','','',1,0,0),
 (32,'0001',27,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (33,'0001',27,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (34,'0001',27,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (35,'0001',27,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (36,'0001',27,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (37,'0001',28,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (38,'0001',29,'20181114',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (39,'0001',30,'20181114',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (40,'0001',31,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (41,'0001',32,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (42,'0001',33,'20181114',4,'Bonet Pablo','TULIO','','','','',7,3,1),
 (43,'0001',34,'20181114',4,'Bonet Pablo','TULIO','','','','',7,3,1),
 (44,'0001',35,'20181114',4,'Bonet Pablo','TULIO','','','','',6,3,1),
 (45,'0001',36,'20181114',4,'Bonet Pablo','TULIO','','','','',0,3,1),
 (46,'0001',37,'20181114',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (47,'0001',38,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (48,'0001',39,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (49,'0001',40,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (50,'0001',41,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (51,'0001',42,'20181115',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','TULIO','','','','',3,3,1),
 (52,'0001',43,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (53,'0001',44,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (54,'0001',45,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (55,'0001',46,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (56,'0001',47,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (57,'0001',48,'20181115',4,'Bonet Pablo','TULIO','','','','',3,3,1),
 (58,'0001',49,'20181115',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','TULIO','','','','',8,3,1),
 (59,'0001',50,'20181115',2,'ALSAFEX S.A. - Racca Gaston Ramon Alberto','TULIO','','','','',0,3,1),
 (60,'0001',51,'20181122',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (61,'0001',52,'20181126',1,'ROSSI TULIO','TULIO','','','','',3,3,1),
 (62,'0001',53,'20181126',1,'ROSSI TULIO','TULIO','','','','',1,3,1),
 (63,'0001',54,'20181126',1,'ROSSI TULIO','TULIO','','','','',5,3,1),
 (64,'0001',55,'20181126',3,'OLIVIERO GERMAN','TULIO','','','','',1,3,1),
 (65,'0001',56,'20181126',1,'ROSSI TULIO','TULIO','','','','',1,3,1),
 (66,'0001',57,'20181127',1,'ROSSI TULIO','TULIO','','','','',3,3,1);
/*!40000 ALTER TABLE `ajustestockp` ENABLE KEYS */;


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
/*!40000 ALTER TABLE `campogrupo` ENABLE KEYS */;


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
 (10,14),
 (4,14);
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
 (1,1,201,'0001'),
 (3,1,57,'0001'),
 (4,4,35,'0003'),
 (1,4,132,'0003'),
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
 (14,4,151,'0003'),
 (14,1,108,'0001');
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
 (1,'IVA RESPONSABLE INSCRIPTO'),
 (2,'IVA RESPONSABLE NO INSCRIPTO'),
 (3,'IVA NO RESPONSABLE'),
 (4,'IVA SUJETO EXENTO'),
 (5,'CONSUMIDOR FINAL'),
 (6,'RESPONSABLE MONOTRIBUTO'),
 (7,'SUJETO NO CATEGORIZADO'),
 (8,'PROVEEDOR DEL EXTERIOR'),
 (9,'CLIENTE DEL EXTERIOR'),
 (10,'IVA LIBERADO'),
 (11,'IVA RESPONSABLE INSCRIPTO-AG DE PERCEPCION'),
 (12,'PEQUEÑO CONTRIBUYENTE EVENTUAL'),
 (13,'MONOTRIBUTISTA SOCIAL'),
 (14,'PEQUEÑO CONTRIBUYENTE EVENTUAL SOCIAL');
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
 (1,'DEPOSITO GENERAL','Belgrano 1602');
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
 (2,'ANULADO'),
 (3,'PENDIENTE AUTORIZACION'),
 (4,'AUTORIZADO'),
 (5,'RECHAZADO');
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
  `fecha` char(16) NOT NULL,
  PRIMARY KEY (`idestadosreg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `estadosreg`
--

/*!40000 ALTER TABLE `estadosreg` DISABLE KEYS */;
/*!40000 ALTER TABLE `estadosreg` ENABLE KEYS */;


--
-- Definition of table `etiquetas`
--

DROP TABLE IF EXISTS `etiquetas`;
CREATE TABLE `etiquetas` (
  `etiqueta` int(10) unsigned NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `codigo` char(100) NOT NULL,
  `articulo` char(50) NOT NULL,
  PRIMARY KEY (`etiqueta`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `etiquetas`
--

/*!40000 ALTER TABLE `etiquetas` DISABLE KEYS */;
INSERT INTO `etiquetas` (`etiqueta`,`fechaalta`,`codigo`,`articulo`) VALUES 
 (1,'20181114','',''),
 (2,'20181114','',''),
 (3,'20181114','',''),
 (4,'20181114','',''),
 (5,'20181114','',''),
 (7,'20181115','','0101002'),
 (8,'20181115','','0101002'),
 (9,'20181115','','0101002'),
 (10,'20181115','','0101002'),
 (11,'20181115','','0101002'),
 (12,'20181115','','0101002'),
 (13,'20181115','','0101002'),
 (14,'20181115','','0101002'),
 (15,'20181115','','0101001'),
 (16,'20181115','','0101001'),
 (17,'20181115','','0101001'),
 (18,'20181115','','0101001'),
 (19,'20181115','','0101001'),
 (20,'20181115','','0101001'),
 (21,'20181115','','0101001'),
 (22,'20181115','','0101001'),
 (23,'20181115','','0101001'),
 (24,'20181115','','0101001'),
 (25,'20181115','','0101001'),
 (26,'20181115','','0101001'),
 (27,'20181115','','0101001'),
 (28,'20181115','','0101001'),
 (29,'20181115','','0101001'),
 (30,'20181115','','0101001'),
 (31,'20181115','','0101001'),
 (32,'20181115','','0101001'),
 (33,'20181115','','0101001'),
 (34,'20181115','','0101001'),
 (35,'20181115','','0101002'),
 (36,'20181115','','0101002'),
 (37,'20181115','','0101002'),
 (38,'20181115','','0101002'),
 (39,'20181115','','0101002'),
 (40,'20181115','','0101002'),
 (41,'20181115','','0101002'),
 (42,'20181115','','0101002'),
 (43,'20181115','','0101002'),
 (44,'20181115','','0101002'),
 (45,'20181115','','0101002'),
 (46,'20181115','','0101002'),
 (47,'20181115','','0101002'),
 (48,'20181115','','0101002'),
 (49,'20181115','','0101002'),
 (50,'20181115','','0101002'),
 (51,'20181115','','0101002'),
 (52,'20181115','','0101002'),
 (53,'20181115','','0101002'),
 (54,'20181115','','0101002'),
 (55,'20181115','','0101002'),
 (56,'20181115','','0101002'),
 (57,'20181115','','0101002'),
 (58,'20181115','','0101002'),
 (59,'20181115','','0101002'),
 (60,'20181115','','0101002'),
 (61,'20181115','','0101002'),
 (62,'20181115','','0101002'),
 (63,'20181115','','0101002'),
 (64,'20181115','','0101002'),
 (65,'20181115','','0101003'),
 (66,'20181115','','0101003'),
 (67,'20181115','','0101003'),
 (68,'20181115','','0101003'),
 (69,'20181115','','0101003'),
 (70,'20181115','','0101003'),
 (71,'20181115','','0101003'),
 (72,'20181115','','0101003'),
 (73,'20181115','','0101003'),
 (74,'20181115','','0101003'),
 (75,'20181115','','0101003'),
 (76,'20181115','','0101003'),
 (77,'20181115','','0101003'),
 (78,'20181115','','0101003'),
 (79,'20181115','','0101003'),
 (80,'20181115','','0101003'),
 (81,'20181115','','0101003'),
 (82,'20181115','','0101003'),
 (83,'20181115','','0101003'),
 (84,'20181115','','0101003'),
 (85,'20181115','','0101003'),
 (86,'20181115','','0101003'),
 (87,'20181115','','0101003'),
 (88,'20181115','','0101003'),
 (89,'20181115','','0101003'),
 (90,'20181115','','0101003'),
 (91,'20181115','','0101003'),
 (92,'20181115','','0101003'),
 (93,'20181115','','0101003'),
 (94,'20181115','','0101003'),
 (95,'20181115','','0101003'),
 (96,'20181115','','0101003'),
 (97,'20181115','','0101003'),
 (98,'20181115','','0101003'),
 (99,'20181115','','0101003'),
 (100,'20181115','','0101003'),
 (101,'20181115','','0101003'),
 (102,'20181115','','0101003'),
 (103,'20181115','','0101003'),
 (104,'20181115','','0101003'),
 (105,'20181115','','0101003'),
 (106,'20181115','','0101003'),
 (107,'20181115','','0101003'),
 (108,'20181115','','0101003'),
 (109,'20181115','','0101003'),
 (110,'20181115','','0101003'),
 (111,'20181115','','0101003'),
 (112,'20181115','','0101003'),
 (113,'20181115','','0101003'),
 (114,'20181115','','0101003'),
 (115,'20181115','','0101003'),
 (116,'20181115','','0101003'),
 (117,'20181115','','0101003'),
 (118,'20181115','','0101003'),
 (119,'20181115','','0101003'),
 (120,'20181115','','0101003'),
 (121,'20181115','','0101003'),
 (122,'20181115','','0101003'),
 (123,'20181115','','0101003'),
 (124,'20181115','','0101003'),
 (125,'20181115','','0101003'),
 (126,'20181115','','0101003'),
 (127,'20181115','','0101003'),
 (128,'20181115','','0101003'),
 (129,'20181115','','0101003'),
 (130,'20181115','','0101003'),
 (131,'20181115','','0101003'),
 (132,'20181115','','0101003'),
 (133,'20181115','','0101003'),
 (134,'20181115','','0101003'),
 (135,'20181115','','0101003'),
 (136,'20181115','','0101003'),
 (137,'20181115','','0101003'),
 (138,'20181115','','0101003'),
 (139,'20181115','','0101003'),
 (140,'20181115','','0101003'),
 (141,'20181115','','0101003'),
 (142,'20181115','','0101003'),
 (143,'20181115','','0101003'),
 (144,'20181115','','0101003'),
 (145,'20181115','','0101003'),
 (146,'20181115','','0101003'),
 (147,'20181115','','0101003'),
 (148,'20181115','','0101003'),
 (149,'20181115','','0101003'),
 (150,'20181115','','0101003'),
 (151,'20181115','','0101003'),
 (152,'20181115','','0101003'),
 (153,'20181115','','0101003'),
 (154,'20181115','','0101003'),
 (155,'20181115','','0101003'),
 (156,'20181115','','0101003'),
 (157,'20181115','','0101003'),
 (158,'20181115','','0101003'),
 (159,'20181115','','0101003'),
 (160,'20181115','','0101003'),
 (161,'20181115','','0101003'),
 (162,'20181115','','0101003'),
 (163,'20181115','','0101003'),
 (164,'20181115','','0101003'),
 (165,'20181115','','0101003'),
 (166,'20181115','','0101003'),
 (167,'20181115','','0101003'),
 (168,'20181115','','0101003'),
 (169,'20181115','','0101003'),
 (170,'20181115','','0101003'),
 (171,'20181115','','0101003'),
 (172,'20181115','','0101003'),
 (173,'20181115','','0101003'),
 (174,'20181115','','0101003'),
 (175,'20181115','','0101003'),
 (176,'20181115','','0101003'),
 (177,'20181115','','0101003'),
 (178,'20181115','','0101003'),
 (179,'20181115','','0101003'),
 (180,'20181115','','0101003'),
 (181,'20181115','','0101003'),
 (182,'20181115','','0101003'),
 (183,'20181115','','0101003'),
 (184,'20181115','','0101003'),
 (185,'20181115','','0101003'),
 (186,'20181115','','0101003'),
 (187,'20181115','','0101003'),
 (188,'20181115','','0101003'),
 (189,'20181115','','0101003'),
 (190,'20181115','','0101003'),
 (191,'20181115','','0101003'),
 (192,'20181115','','0101003'),
 (193,'20181115','','0101003'),
 (194,'20181115','','0101003'),
 (195,'20181115','','0101003'),
 (196,'20181115','','0101003'),
 (197,'20181115','','0101003'),
 (198,'20181115','','0101003'),
 (199,'20181115','','0101003'),
 (200,'20181115','','0101003'),
 (201,'20181115','','0101003'),
 (202,'20181115','','0101003'),
 (203,'20181115','','0101003'),
 (204,'20181115','','0101003'),
 (205,'20181115','','0101003'),
 (206,'20181115','','0101003'),
 (207,'20181115','','0101003'),
 (208,'20181115','','0101003'),
 (209,'20181115','','0101003'),
 (210,'20181115','','0101003'),
 (211,'20181115','','0101003'),
 (212,'20181115','','0101003'),
 (213,'20181115','','0101003'),
 (214,'20181115','','0101003'),
 (215,'20181115','','0101003'),
 (216,'20181115','','0101003'),
 (217,'20181115','','0101003'),
 (218,'20181115','','0101003'),
 (219,'20181115','','0101003'),
 (220,'20181115','','0101003'),
 (221,'20181115','','0101003'),
 (222,'20181115','','0101003'),
 (223,'20181115','','0101003'),
 (224,'20181115','','0101003'),
 (225,'20181115','','0101003'),
 (226,'20181115','','0101003'),
 (227,'20181115','','0101003'),
 (228,'20181115','','0101003'),
 (229,'20181115','','0101003'),
 (230,'20181115','','0101003'),
 (231,'20181115','','0101003'),
 (232,'20181115','','0101003'),
 (233,'20181115','','0101003'),
 (234,'20181115','','0101003'),
 (235,'20181115','','0101003'),
 (236,'20181115','','0101003'),
 (237,'20181115','','0101003'),
 (238,'20181115','','0101003'),
 (239,'20181115','','0101003'),
 (240,'20181115','','0101003'),
 (241,'20181115','','0101003'),
 (242,'20181115','','0101003'),
 (243,'20181115','','0101003'),
 (244,'20181115','','0101003'),
 (245,'20181115','','0101003'),
 (246,'20181115','','0101003'),
 (247,'20181115','','0101003'),
 (248,'20181115','','0101003'),
 (249,'20181115','','0101003'),
 (250,'20181115','','0101003'),
 (251,'20181115','','0101003'),
 (252,'20181115','','0101003'),
 (253,'20181115','','0101003'),
 (254,'20181115','','0101003'),
 (255,'20181115','','0101003'),
 (256,'20181115','','0101003'),
 (257,'20181115','','0101003'),
 (258,'20181115','','0101003'),
 (259,'20181115','','0101003'),
 (260,'20181115','','0101003'),
 (261,'20181115','','0101003'),
 (262,'20181115','','0101003'),
 (263,'20181115','','0101003'),
 (264,'20181115','','0101003'),
 (265,'20181122','','0101001'),
 (266,'20181122','','0101001'),
 (267,'20181122','','0101001'),
 (268,'20181122','','0101001'),
 (269,'20181122','','0101001'),
 (270,'20181122','','0101001'),
 (271,'20181122','','0101001'),
 (272,'20181122','','0101001'),
 (273,'20181122','','0101001'),
 (274,'20181122','','0101001'),
 (275,'20181126','','0101004'),
 (276,'20181127','','0101005'),
 (277,'20181127','','0101005'),
 (278,'20181127','','0101005'),
 (279,'20181127','','0101005'),
 (280,'20181127','','0101005'),
 (281,'20181127','','0101005'),
 (282,'20181127','','0101005'),
 (283,'20181127','','0101005'),
 (284,'20181127','','0101005'),
 (285,'20181127','','0101005'),
 (286,'20181127','','0101005'),
 (287,'20181127','','0101005'),
 (288,'20181127','','0101005'),
 (289,'20181127','','0101005'),
 (290,'20181127','','0101005'),
 (291,'20181127','','0101005'),
 (292,'20181127','','0101005'),
 (293,'20181127','','0101005'),
 (294,'20181127','','0101005'),
 (295,'20181127','','0101005'),
 (296,'20181127','','0101005'),
 (297,'20181127','','0101005'),
 (298,'20181127','','0101005'),
 (299,'20181127','','0101005'),
 (300,'20181127','','0101005'),
 (301,'20181127','','0101005'),
 (302,'20181127','','0101005'),
 (303,'20181127','','0101005'),
 (304,'20181127','','0101005'),
 (305,'20181127','','0101005'),
 (306,'20181127','','0101005'),
 (307,'20181127','','0101005'),
 (308,'20181127','','0101005'),
 (309,'20181127','','0101005'),
 (310,'20181127','','0101005'),
 (311,'20181127','','0101005'),
 (312,'20181127','','0101005'),
 (313,'20181127','','0101005'),
 (314,'20181127','','0101005'),
 (315,'20181127','','0101005'),
 (316,'20181127','','0101005'),
 (317,'20181127','','0101005'),
 (318,'20181127','','0101005'),
 (319,'20181127','','0101005'),
 (320,'20181127','','0101005'),
 (321,'20181127','','0101005'),
 (322,'20181127','','0101005'),
 (323,'20181127','','0101005'),
 (324,'20181127','','0101005'),
 (325,'20181127','','0101005'),
 (326,'20181127','','0101005'),
 (327,'20181127','','0101005'),
 (328,'20181127','','0101005'),
 (329,'20181127','','0101005'),
 (330,'20181127','','0101005'),
 (331,'20181127','','0101005'),
 (332,'20181127','','0101005'),
 (333,'20181127','','0101005'),
 (334,'20181127','','0101005'),
 (335,'20181127','','0101005'),
 (336,'20181127','','0101005'),
 (337,'20181127','','0101005'),
 (338,'20181127','','0101005'),
 (339,'20181127','','0101005'),
 (340,'20181127','','0101005'),
 (341,'20181127','','0101005'),
 (342,'20181127','','0101005'),
 (343,'20181127','','0101005'),
 (344,'20181127','','0101005'),
 (345,'20181127','','0101005'),
 (346,'20181127','','0101005'),
 (347,'20181127','','0101005'),
 (348,'20181127','','0101005'),
 (349,'20181127','','0101005'),
 (350,'20181127','','0101005'),
 (351,'20181127','','0101005'),
 (352,'20181127','','0101005'),
 (353,'20181127','','0101005'),
 (354,'20181127','','0101005'),
 (355,'20181127','','0101005'),
 (356,'20181127','','0101005'),
 (357,'20181127','','0101005'),
 (358,'20181127','','0101005'),
 (359,'20181127','','0101005'),
 (360,'20181127','','0101005'),
 (361,'20181127','','0101005'),
 (362,'20181127','','0101005'),
 (363,'20181127','','0101005'),
 (364,'20181127','','0101005'),
 (365,'20181127','','0101005'),
 (366,'20181127','','0101005'),
 (367,'20181127','','0101005'),
 (368,'20181127','','0101005'),
 (369,'20181127','','0101005'),
 (370,'20181127','','0101005'),
 (371,'20181127','','0101005'),
 (372,'20181127','','0101005'),
 (373,'20181127','','0101005'),
 (374,'20181127','','0101005'),
 (375,'20181127','','0101005'),
 (376,'20181127','','0101012'),
 (377,'20181127','','0101012'),
 (378,'20181127','','0101012'),
 (379,'20181127','','0101012'),
 (380,'20181127','','0101012'),
 (381,'20181127','','0101012'),
 (382,'20181127','','0101012'),
 (383,'20181127','','0101012'),
 (384,'20181127','','0101012'),
 (385,'20181127','','0101012'),
 (386,'20181127','','0101012'),
 (387,'20181127','','0101012'),
 (388,'20181127','','0101012'),
 (389,'20181127','','0101012'),
 (390,'20181127','','0101012'),
 (391,'20181127','','0101012'),
 (392,'20181127','','0101012'),
 (393,'20181127','','0101012'),
 (394,'20181127','','0101012'),
 (395,'20181127','','0101012'),
 (396,'20181127','','0101012'),
 (397,'20181127','','0101012'),
 (398,'20181127','','0101012'),
 (399,'20181127','','0101012'),
 (400,'20181127','','0101012'),
 (401,'20181127','','0101012'),
 (402,'20181127','','0101012'),
 (403,'20181127','','0101012'),
 (404,'20181127','','0101012'),
 (405,'20181127','','0101012'),
 (406,'20181127','','0101012'),
 (407,'20181127','','0101012'),
 (408,'20181127','','0101012'),
 (409,'20181127','','0101012'),
 (410,'20181127','','0101012'),
 (411,'20181127','','0101012'),
 (412,'20181127','','0101012'),
 (413,'20181127','','0101012'),
 (414,'20181127','','0101012'),
 (415,'20181127','','0101012'),
 (416,'20181127','','0101012'),
 (417,'20181127','','0101012'),
 (418,'20181127','','0101012'),
 (419,'20181127','','0101012'),
 (420,'20181127','','0101012'),
 (421,'20181127','','0101012'),
 (422,'20181127','','0101012'),
 (423,'20181127','','0101012'),
 (424,'20181127','','0101012'),
 (425,'20181127','','0101012');
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
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;


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
 (2,'IVA 10.5%',10.5000,'','IVA',1000.0000,1.0000,4);
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
 (1,'LISTA 0','20180220','20180220','21000101',1.3000,0,1);
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
 (12,1,'H','01390000000000','\\-','','','','N','N','S','05','admin','2016030610:51:06',1,''),
 (13,1,'H','01400000000000','Salir                               Alt+F4','','SALIRMENU()','','S','S','S','01','admin','2016062420:45:28',1,'CERRAR.PNG'),
 (14,0,'P','04000000000000','Ayuda','','','','N','N','S','05','admin','2016030612:09:53',1,''),
 (15,14,'H','04010000000000','Info.Sistema...','','DO FORM infosistema','','S','S','S','05','TULIO','2018060712:33:37',1,'INFO1.PNG'),
 (16,1,'H','01110000000000','Empleados','','DO FORM empleados','6','S','S','S','01','admin','2018041008:20:04',1,''),
 (17,1,'H','01370000000000','Iconos','','DO FORM iconosabm','7','S','S','S','01','admin','2016062510:05:54',1,'FACE03.ICO'),
 (18,1,'H','01350000000000','Biblioteca de Función','','DO FORM bibliotecafabm','8','S','S','S','01','admin','2016052021:15:00',1,''),
 (19,1,'H','01040000000000','Sucursales','','DO FORM sucursalesabm','9','S','S','S','01','admin','2016052115:24:00',1,''),
 (20,1,'H','01360000000000','Modulos del Sistema','','DO FORM modulossysabm','10','S','S','S','01','admin','2016052116:38:00',1,''),
 (21,1,'H','01030000000000','Empresas','','DO FORM empresasabm','11','S','S','S','01','admin','2016052721:55:00',1,''),
 (22,1,'H','01150000000000','Condiciones Fiscales','','DO FORM condfiscalabm','12','S','S','S','01','admin','2016052809:43:00',1,''),
 (23,1,'H','01140000000000','Impuestos','','DO FORM impuestosabm','13','S','S','S','01','admin','2016052811:52:00',1,''),
 (24,1,'H','01130000000000','Servicios','','DO FORM serviciosabm2','14','S','S','S','01','admin','2016052817:17:00',1,''),
 (25,1,'H','01240000000000','Lineas','','DO FORM lineasabm','15','S','S','S','01','admin','2016061117:14:00',1,''),
 (26,1,'H','01100000000000','Provincias','','DO FORM provinciasabm','','S','S','S','01','admin','2016062510:51:36',1,''),
 (27,1,'H','01050000000000','\\-','','','','S','S','S','01','admin','2016062510:58:52',1,''),
 (28,1,'H','01340000000000','\\-','','','','S','S','S','01','admin','2016062511:00:16',1,''),
 (29,1,'H','01380000000000','Seteo ToolBar Sys','','DO FORM toolbarsysabm','','S','S','S','01','admin','2016062601:40:20',1,''),
 (30,1,'H','01060000000000','Clientes-Proveedores','','DO FORM entidades','','S','S','S','01','admin','2016062900:05:11',1,'EMPLY.ICO'),
 (31,1,'H','01220000000000','Artículos','','DO FORM articulos','','S','S','S','01','admin','2016070212:00:11',1,'WZPRINT.BMP'),
 (32,1,'H','01180000000000','\\-','','','','S','S','S','01','admin','2016070212:01:40',1,''),
 (33,10,'H','03010000000000','Factura','','DO FORM facturas with 0','','S','S','S','06','admin','2018120619:40:32',1,''),
 (34,1,'H','01200000000000','Depositos','','DO FORM depositos','','S','S','S','01','admin','2016071614:21:33',1,''),
 (35,1,'H','01190000000000','Conceptos','','DO FORM conceptoser','','S','S','S','01','admin','2016071816:17:25',1,''),
 (36,1,'H','01250000000000','Tipos de Movimientos de Stock','','DO FORM tipomstock','','S','S','S','01','admin','2016072021:19:29',1,''),
 (37,1,'H','01210000000000','Puntos de Venta','','DO FORM puntosventa','','S','S','S','01','admin','2016110509:59:05',1,''),
 (38,1,'H','01330000000000','Tipos de Comprobantes','','DO FORM tipocompro','','S','S','S','01','admin','2016122113:56:00',1,''),
 (39,1,'H','01230000000000','Comprobantes','','DO FORM comprobantes','','S','S','S','01','admin','2017010910:29:43',1,''),
 (40,1,'H','01260000000000','Ajuste de Stock','','DO FORM ajustestockp WITH 0','','S','S','S','01','admin','2018111219:29:56',1,''),
 (41,1,'H','01320000000000','Consulta Movimientos de Stock','','DO FORM consultamovistock with \"0\",\"0\",\"0\"','','S','S','S','01','admin','2018112218:21:26',1,''),
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
 (67,4,'H','02160000000000','Tipos de Observaciones','','DO FORM ottiposobsabm','','S','S','S','07','admin','2018070219:31:54',1,''),
 (68,1,'H','01310000000000','Listado de Stock','','DO FORM listadostock','','S','S','S','01','admin','2018110820:08:56',1,''),
 (69,0,'P','05000000000000','Grupo','','','','N','N','S','08','admin','2018111710:31:57',1,''),
 (70,69,'H','05010000000000','Tipo de grupos','','DO FORM tipogrupos','','S','S','S','08','admin','2018111710:32:29',1,''),
 (71,69,'H','05020000000000','Administrar grupos','','DO FORM grupos','','S','S','S','08','admin','2018111710:32:59',1,''),
 (72,69,'H','05030000000000','Barra de grupos','','showhidetoolbargrupo()','','S','S','S','08','admin','2018112411:19:24',1,''),
 (73,4,'H','02170000000000','Depósitos de materiales','','DO FORM otdepositos','','S','S','S','07','admin','2018112410:22:14',1,''),
 (74,14,'H','04040000000000','Actualizar Tablas de Indices','','DO FORM tablasidx','','S','S','S','05','admin','2018112411:18:38',1,'');
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
 (1,'DEPOSITO GENERAL'),
 (2,'MOVIL 1');
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
/*!40000 ALTER TABLE `otdocumentos` ENABLE KEYS */;


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
 (1,64,'S','',0),
 (1,65,'S','',0),
 (1,66,'S','',0),
 (1,67,'S','',0),
 (1,68,'S','',0),
 (1,69,'S','',0),
 (1,70,'S','',0),
 (1,71,'S','',0),
 (1,72,'S','',0),
 (1,73,'S','',0),
 (1,74,'S','',0);
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
 (1,'TULIO','S',1);
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
 (1,'CoSeMar','0001','1','20170202','','N');
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
/*!40000 ALTER TABLE `seteolog` ENABLE KEYS */;


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
 (1,'SUCURSAL 1');
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
 (1,'facturas','idfactura','I','0',0),
 (2,'detafactu','idfacturah','I','0',0),
 (3,'cupones','idcupon','I','0',0),
 (4,'detallecobros','iddetacobro','I','0',0),
 (5,'facturasfe','idfe','I','0',0),
 (6,'recibos','idrecibo','I','0',0),
 (7,'cobros','idcobro','I','0',0),
 (8,'facturascta','idcuotafc','I','0',0),
 (9,'cajarecaudah','idcajareh','I','0',0),
 (10,'otmovistockp','idmovip','I','0',0),
 (11,'otmovistockh','idmovih','I','0',0),
 (12,'otejecum','idotejem','I','0',0),
 (13,'otejecuh','idotejeh','I','0',0),
 (14,'ototetapas','idotetapa','I','0',0),
 (15,'otdetaot','idotdet','I','0',0),
 (16,'otpedido','idpedido','I','0',0),
 (17,'otdocumentos','iddocu','I','0',0),
 (18,'logsystem','idlog','I','0',0),
 (19,'otordentra','idot','I','0',0),
 (20,'ottiposobs','idottiposobs','I','0',0),
 (21,'otestadosot','idotestadosot','I','0',0),
 (22,'otmaterialespro','idotmatepro','I','0',0),
 (24,'carterachequed','idcheque','I','0',0),
 (25,'linkcompro','idlinkcomp','I','0',0),
 (27,'ajustestockp','idajuste','I','0',0),
 (28,'ajustestockh','idajusteh','I','0',0),
 (29,'etiquetas','etiqueta','I','0',0),
 (30,'ajustestocke','idajustestocke','I','0',0),
 (31,'estadosreg','idestadosreg','I','0',0),
 (32,'grupoobjeto','idgrupobj','I','0',0),
 (33,'grupos','idgrupo','I','0',0),
 (34,'tipogrupos','idtipogrupo','I','0',0);
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
 (16,'RECIBO',0,'RECIBO','S','N',0),
 (17,'REMITO',0,'REMITO','S','N',0);
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
 (3,'INGRESO POR COMPRA','I','AJUSTE DE STOCK','S',0),
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
 ('TULIO',1,65),
 ('TULIO',1,72);
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
 ('PABLO','PABLO BONET','P','','S'),
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
 (1,'Tulio Rossi','','1','','','','2');
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
 (1,'ZONA 1');
/*!40000 ALTER TABLE `zonas` ENABLE KEYS */;


--
-- Definition of view `articulostock`
--

DROP TABLE IF EXISTS `articulostock`;
DROP VIEW IF EXISTS `articulostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `articulostock` AS select `h`.`articulo` AS `articulo`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `h`.`cantidad`)) AS `stockTot` from (`ajustestockh` `h` left join `tipomstock` `t` on((`h`.`idtipomov` = `t`.`idtipomov`))) where (not(`h`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `h`.`articulo`;

--
-- Definition of view `depostock`
--

DROP TABLE IF EXISTS `depostock`;
DROP VIEW IF EXISTS `depostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stockTot`,0) AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `a`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin` from (((`ajustestockh` `a` left join `tipomstock` `t` on((`a`.`idtipomov` = `t`.`idtipomov`))) left join `articulos` `m` on((`a`.`articulo` = `m`.`articulo`))) left join `articulostock` `u` on((`a`.`articulo` = `u`.`articulo`))) where (not(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;

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
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `ultimoestado` AS select `e`.`tabla` AS `tabla`,`e`.`campo` AS `campo`,`e`.`id` AS `id`,`e`.`idestador` AS `idestador`,`e`.`tipo` AS `tipo`,`e`.`fecha` AS `fechaEst` from (`maxidestados` `m` left join `estadosreg` `e` on((`m`.`maxid` = `e`.`idestadosreg`)));

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
