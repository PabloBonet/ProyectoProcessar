-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.73-1-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


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
 (0,'Server Fede','trsoftdb','{MySQL ODBC 3.51 Driver}','192.168.1.100','3306','tulior','owntod93','N','8454016','S',0,0,''),
 (1,'COSEMAR','cosemardb','{MySQL ODBC 3.51 Driver}','tuly.changeip.org','3306','tulior','owntod93','','8454143','S',0,0,''),
 (2,'COSEMAR-CASA','cosemardb','{MySQL ODBC 3.51 Driver}','server.casa','3306','tulior','owntod93','','8454143','S',0,0,''),
 (3,'TRSoft-IT','trsoftdb','{MySQL ODBC 3.51 Driver}','server.casa','3306','tulior','owntod93','','8454143','S',0,0,''),
 (4,'KRUMBEIN-CASA-EXT','krumbeindb','{MySQL ODBC 3.51 Driver}','tuly.changeip.org','3306','tulior','owntod93','','8454143','S',0,0,'C:/Proyectos/Krumbein/MKMySQL/Fuentes/'),
 (5,'Esquema de Cosemar Para Fede','cosemarfede','{MySQL ODBC 3.51 Driver}','tuly.changeip.org','3306','tulior','owntod93','','8454143','S',0,0,''),
 (6,'Comuna Margarita','dbcomuna','{MySQL ODBC 3.51 Driver}','debian','3306','tulior','owntod93','20131231_220946.jpg','8454016','S',0,0,''),
 (7,'TRSoft-Desarrollo','trsoftdb','{MySQL ODBC 3.51 Driver}','190.225.164.12','3307','tulior','owntod93','N','8454016','S',0,0,' ');
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
  PRIMARY KEY (`idicono`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `iconos`
--

/*!40000 ALTER TABLE `iconos` DISABLE KEYS */;
INSERT INTO `iconos` (`idicono`,`nombre`,`archivo`,`tooltip`) VALUES 
 (0,'cerrar','cerrar.png','Cerrar'),
 (2,'eliminar','eliminar.png','Eliminar'),
 (3,'guardar','guardar.png','Guardar');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settoolbarsys`
--

/*!40000 ALTER TABLE `settoolbarsys` DISABLE KEYS */;
INSERT INTO `settoolbarsys` (`idset`,`form`,`idobjeto`,`icono`,`funcion`,`habilita`,`visible`,`tooltip`,`active`) VALUES 
 (1,'provinciasabm','14','exit1.png','cerrar()','1','1','Cerrar','1'),
 (2,'provinciasabm','02','wzprint.bmp','imprimir()','1','1','Imprimir','1'),
 (3,'_screen','01','exit1.png','salirmenu()','1','1','Cerrar Sistema','0'),
 (4,'provinciasabm','12','','filtrar()','1','1','Ingrese Texto','1'),
 (5,'provinciasabm','13','locate.bmp','filtrar()','1','1','Buscar','1'),
 (6,'provinciasabm','21','','','1','1','','1'),
 (7,'provinciasabm','22','','','1','1','','1');
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
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `varpublicas`
--

/*!40000 ALTER TABLE `varpublicas` DISABLE KEYS */;
INSERT INTO `varpublicas` (`variable`,`tipo`,`valor`,`detalle`,`grupo`) VALUES 
 ('_SYSADMIN','C','admin','Usuario administrador para acceso a configuracion de Menues','1'),
 ('_SYSBMPFONDO','C','\"\"','Archivo con Imagen de Fondo','1'),
 ('_SYSCOLORFONDO','C','RGB(192,192,192)','Color del Fondo de Sistema','1'),
 ('_SYSDESCRIP','C','Administración Principal','Descripcion de la Base de Datos conectada','1'),
 ('_SYSESTACION','C','C:\\TRSofttmp','Carpeta de destino de los archivos borrados','1'),
 ('_SYSPAPELERA','C','RECYCLE','Indica si los delete van a parar a la papelera','1'),
 ('_SYSPASSADMIN','C','1','Password para usuario administrador de Menues y seteos','1'),
 ('_SYSTITULO','C','TRSoft_Proyecto V0','Titulo para arranque del sistema en la barra superior','1');
/*!40000 ALTER TABLE `varpublicas` ENABLE KEYS */;

--
-- Create schema trsoftdb
--

CREATE DATABASE IF NOT EXISTS trsoftdb;
USE trsoftdb;

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
  `articulo` char(20) NOT NULL,
  `detalle` char(200) NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  `descmov` char(200) NOT NULL,
  `ie` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `idajusteh` int(10) unsigned NOT NULL,
  `renglon` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idajuste`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajustestockh`
--

/*!40000 ALTER TABLE `ajustestockh` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajustestockh` ENABLE KEYS */;


--
-- Definition of table `ajustestockp`
--

DROP TABLE IF EXISTS `ajustestockp`;
CREATE TABLE `ajustestockp` (
  `idajuste` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
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
  `deposito` int(10) unsigned NOT NULL,
  `descdepo` char(254) NOT NULL,
  PRIMARY KEY (`idajuste`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajustestockp`
--

/*!40000 ALTER TABLE `ajustestockp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajustestockp` ENABLE KEYS */;


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
  PRIMARY KEY (`articulo`)
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
  `base` float(13,2) NOT NULL,
  `unidadf` char(50) NOT NULL,
  PRIMARY KEY (`articulo`)
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
  `archivoimg` char(50) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  PRIMARY KEY (`idartimg`)
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
  `detalle` char(100) NOT NULL,
  `razon` float(13,2) NOT NULL,
  PRIMARY KEY (`articulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articulosimp`
--

/*!40000 ALTER TABLE `articulosimp` DISABLE KEYS */;
/*!40000 ALTER TABLE `articulosimp` ENABLE KEYS */;


--
-- Definition of table `asientos`
--

DROP TABLE IF EXISTS `asientos`;
CREATE TABLE `asientos` (
  `idasiento` int(10) unsigned NOT NULL,
  `nroasiento` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `idplan` int(10) unsigned NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(254) NOT NULL,
  `debe` float(13,4) NOT NULL,
  `haber` float(13,4) NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idasiento`)
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
-- Definition of table `bocaservicios`
--

DROP TABLE IF EXISTS `bocaservicios`;
CREATE TABLE `bocaservicios` (
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  `bocanumero` char(50) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `facturar` char(1) NOT NULL,
  `habilitado` char(1) NOT NULL,
  PRIMARY KEY (`entidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bocaservicios`
--

/*!40000 ALTER TABLE `bocaservicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `bocaservicios` ENABLE KEYS */;


--
-- Definition of table `cajaie`
--

DROP TABLE IF EXISTS `cajaie`;
CREATE TABLE `cajaie` (
  `idcajaie` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `direccion` char(254) NOT NULL,
  `cuit` char(13) NOT NULL,
  `concepto` char(254) NOT NULL,
  `contabilizado` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  PRIMARY KEY (`idcajaie`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajaie`
--

/*!40000 ALTER TABLE `cajaie` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajaie` ENABLE KEYS */;


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
-- Definition of table `cobros`
--

DROP TABLE IF EXISTS `cobros`;
CREATE TABLE `cobros` (
  `idcobro` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `fechapago` char(8) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `recargo` float(13,4) NOT NULL,
  `ivarecargo` float(13,4) NOT NULL,
  `idcomprobap` int(10) unsigned NOT NULL,
  `puntovtap` int(10) unsigned NOT NULL,
  `actividadp` int(10) unsigned NOT NULL,
  `numerop` int(10) unsigned NOT NULL,
  `idregipago` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcobro`)
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
  `idnumera` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `maxnumero` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idnumera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compactiv`
--

/*!40000 ALTER TABLE `compactiv` DISABLE KEYS */;
/*!40000 ALTER TABLE `compactiv` ENABLE KEYS */;


--
-- Definition of table `compiservi`
--

DROP TABLE IF EXISTS `compiservi`;
CREATE TABLE `compiservi` (
  `idcomproba` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcomproba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compiservi`
--

/*!40000 ALTER TABLE `compiservi` DISABLE KEYS */;
/*!40000 ALTER TABLE `compiservi` ENABLE KEYS */;


--
-- Definition of table `comprobantes`
--

DROP TABLE IF EXISTS `comprobantes`;
CREATE TABLE `comprobantes` (
  `idcomproba` int(10) unsigned NOT NULL,
  `comprobante` char(100) NOT NULL,
  `idnumera` int(10) unsigned NOT NULL,
  `idtipocom` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `ctacte` char(1) NOT NULL,
  PRIMARY KEY (`idcomproba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comprobantes`
--

/*!40000 ALTER TABLE `comprobantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comprobantes` ENABLE KEYS */;


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
  `idconcepto` int(10) unsigned NOT NULL,
  PRIMARY KEY (`impuesto`)
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
  `importe` float(13,2) NOT NULL,
  PRIMARY KEY (`idconcepto`)
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
  `idcondfis` int(10) unsigned NOT NULL,
  `detalle` char(200) NOT NULL,
  PRIMARY KEY (`idcondfis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `condfiscal`
--

/*!40000 ALTER TABLE `condfiscal` DISABLE KEYS */;
/*!40000 ALTER TABLE `condfiscal` ENABLE KEYS */;


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
  `valorllama` float(13,2) NOT NULL,
  `tipollama` int(10) unsigned NOT NULL,
  `fechgene` char(8) NOT NULL,
  `horagene` char(8) NOT NULL,
  `secuencia2` int(10) unsigned NOT NULL,
  `facturado` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
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
/*!40000 ALTER TABLE `depositos` ENABLE KEYS */;


--
-- Definition of table `destinooti`
--

DROP TABLE IF EXISTS `destinooti`;
CREATE TABLE `destinooti` (
  `destinooti` int(10) unsigned NOT NULL,
  `detalle` int(10) unsigned NOT NULL,
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `idfacturah` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cantidad` float(13,4) NOT NULL,
  `unidad` char(10) NOT NULL,
  `cantidadfc` float(13,4) NOT NULL,
  `unidadfc` char(10) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(100) NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cancuotas` int(10) unsigned NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  `idimpuesto` int(10) unsigned NOT NULL,
  `razonimp` float(13,4) NOT NULL,
  `neto` float(13,4) NOT NULL,
  PRIMARY KEY (`idfactura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detafactu`
--

/*!40000 ALTER TABLE `detafactu` DISABLE KEYS */;
/*!40000 ALTER TABLE `detafactu` ENABLE KEYS */;


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
  `localidad` char(100) NOT NULL,
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
 ('TRSoftIT Tulio Rossi','Tulio Rossi','20-22141497-8','IVA Responsable Inscripto','EXENTO','Avellaneda 6737','(3000) Santa Fe - Santa Fe','20160101','342-4693586 - Cel 342-15-5456398','trossi@cosemar.com.ar','www.cosemar.com.ar','');
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
  `localidad` char(50) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `web` char(254) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `doctipo` char(3) NOT NULL,
  `fechanac` char(8) NOT NULL,
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
  `compania` char(100) NOT NULL,
  `direccion` char(100) NOT NULL,
  `localidad` char(50) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `doctipo` char(3) NOT NULL,
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
  `operacion` char(1) NOT NULL,
  PRIMARY KEY (`entidad`) USING BTREE
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
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `cuotasfact` int(10) unsigned NOT NULL,
  `nrocuotas` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `detalle` char(254) NOT NULL,
  `abreviado` char(50) NOT NULL,
  `unitario` float(13,2) NOT NULL,
  `neto` float(13,2) NOT NULL,
  `impuesto` float(13,2) NOT NULL,
  `total` float(13,2) NOT NULL,
  `unidad` char(50) NOT NULL,
  `funcion` char(100) NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  `identindadd` int(10) unsigned NOT NULL,
  `mensual` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadesd`
--

/*!40000 ALTER TABLE `entidadesd` DISABLE KEYS */;
/*!40000 ALTER TABLE `entidadesd` ENABLE KEYS */;


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
  `localidad` char(50) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `fechaalt` char(8) NOT NULL,
  `telefono` char(100) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `doctipo` char(3) NOT NULL,
  `fechanac` char(8) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadesh`
--

/*!40000 ALTER TABLE `entidadesh` DISABLE KEYS */;
/*!40000 ALTER TABLE `entidadesh` ENABLE KEYS */;


--
-- Definition of table `entidadg`
--

DROP TABLE IF EXISTS `entidadg`;
CREATE TABLE `entidadg` (
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `idgrupoe` int(10) unsigned NOT NULL,
  `descripcion` char(100) NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`entidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entidadg`
--

/*!40000 ALTER TABLE `entidadg` DISABLE KEYS */;
/*!40000 ALTER TABLE `entidadg` ENABLE KEYS */;


--
-- Definition of table `etiquetas`
--

DROP TABLE IF EXISTS `etiquetas`;
CREATE TABLE `etiquetas` (
  `articulo` char(50) NOT NULL,
  `etiqueta` char(50) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  PRIMARY KEY (`articulo`)
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
  `bocanumero` char(20) NOT NULL,
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
  `minaireex` float(13,4) NOT NULL,
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
  PRIMARY KEY (`bocanumero`)
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
  PRIMARY KEY (`servicio`)
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
  `idfacprove` int(10) unsigned NOT NULL,
  `idtipocomp` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `cuit` char(13) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `tipodocu` char(3) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `condvta` int(10) unsigned NOT NULL,
  `nroremito` int(10) unsigned NOT NULL,
  `nropedido` int(10) unsigned NOT NULL,
  `neto` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `exento` float(13,4) NOT NULL,
  `nograbado` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `contabilizado` int(10) unsigned NOT NULL,
  `fechacarga` char(8) NOT NULL,
  `fechaingreso` char(8) NOT NULL,
  PRIMARY KEY (`idfacprove`)
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
  `idfacprove` int(10) unsigned NOT NULL,
  `idfacproveh` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `codigoprov` char(20) NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `unidad` char(10) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `idimpuesto` int(10) unsigned NOT NULL,
  `razonimp` float(13,4) NOT NULL,
  PRIMARY KEY (`idfacprove`)
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
  `idfacprove` int(10) unsigned NOT NULL,
  `idtipocomp` int(10) unsigned NOT NULL,
  `idimpuesto` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  PRIMARY KEY (`idfacprove`)
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
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
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
  `doctipo` char(3) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(254) NOT NULL,
  `transporte` int(10) unsigned NOT NULL,
  `nomtransp` char(254) NOT NULL,
  `direntrega` char(254) NOT NULL,
  `stock` char(1) NOT NULL,
  `condvta` char(1) NOT NULL,
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
  `mes` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `zona` char(50) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `fechavenc1` char(8) NOT NULL,
  `fechavenc2` char(8) NOT NULL,
  `fechavenc3` char(8) NOT NULL,
  `fechadesco` char(8) NOT NULL,
  `proxvenc` char(8) NOT NULL,
  `confirmada` char(1) NOT NULL,
  `astoconta` int(10) unsigned NOT NULL,
  `deudacta` float(13,4) NOT NULL,
  `cespcae` char(100) NOT NULL,
  `caecespven` char(8) NOT NULL,
  `idfe` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfactura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturas`
--

/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;


--
-- Definition of table `facturasanul`
--

DROP TABLE IF EXISTS `facturasanul`;
CREATE TABLE `facturasanul` (
  `idfactura` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cancuotas` int(10) unsigned NOT NULL,
  `totalfc` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `imppago` float(13,4) NOT NULL,
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numeroori` int(10) unsigned NOT NULL,
  `numeroaut` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
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
  PRIMARY KEY (`idfe`)
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  PRIMARY KEY (`idfactura`)
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
  `idfactura` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(8) NOT NULL,
  `recneto` float(13,4) NOT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `total` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  PRIMARY KEY (`idfactura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturasrec`
--

/*!40000 ALTER TABLE `facturasrec` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturasrec` ENABLE KEYS */;


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
  `entidad` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `tipodocu` char(3) NOT NULL,
  `apellido` char(100) NOT NULL,
  `nombre` char(100) NOT NULL,
  `fechanac` char(8) NOT NULL,
  `parentesco` char(100) NOT NULL,
  `fechaalta` char(8) NOT NULL,
  `fechabaja` char(8) NOT NULL,
  `diasvigen` int(10) unsigned NOT NULL,
  `sexo` char(1) NOT NULL,
  `edad` int(10) unsigned NOT NULL,
  `identidadh` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entidad`)
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
  `detalle` char(8) NOT NULL,
  `razon` float(13,2) NOT NULL,
  `formula` char(150) NOT NULL,
  `abrevia` char(150) NOT NULL,
  `baseimpon` float(13,2) NOT NULL,
  PRIMARY KEY (`impuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `impuestos`
--

/*!40000 ALTER TABLE `impuestos` DISABLE KEYS */;
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
  `importe` float(13,3) NOT NULL,
  `facturado` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `observa` char(254) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
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
  `dnicuit` char(50) NOT NULL,
  `actanro` char(20) NOT NULL,
  `nrosolici` int(10) unsigned NOT NULL,
  `capsusc` float(13,4) NOT NULL,
  `capreint` float(13,4) NOT NULL,
  `bajatrans` float(13,4) NOT NULL,
  `capemiti` float(13,4) NOT NULL,
  `capinteg` float(13,4) NOT NULL,
  `fechabaja` char(8) NOT NULL,
  `causabaja` char(254) NOT NULL,
  `observa` char(254) NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `idregicomp` int(10) unsigned NOT NULL,
  `idlibrosoc` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entidad`)
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
/*!40000 ALTER TABLE `lineas` ENABLE KEYS */;


--
-- Definition of table `listaprecioh`
--

DROP TABLE IF EXISTS `listaprecioh`;
CREATE TABLE `listaprecioh` (
  `idlista` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
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
  PRIMARY KEY (`idlista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `listapreciop`
--

/*!40000 ALTER TABLE `listapreciop` DISABLE KEYS */;
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
 ('3','Santa Fe','3033','1'),
 ('4','RECREO','6556','1'),
 ('5','GALLARETA','DDFD','1');
/*!40000 ALTER TABLE `localidades` ENABLE KEYS */;


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
  `consumo` float(13,2) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `facturado` char(1) NOT NULL,
  `facturar` char(1) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bocanumero`)
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
  `idmed` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
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
  PRIMARY KEY (`idmed`)
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
  `consumo` int(10) unsigned NOT NULL,
  `pulddn1` int(10) unsigned NOT NULL,
  `pulddn2` int(10) unsigned NOT NULL,
  `pesos_n` float(13,2) NOT NULL,
  `pesos_r` float(13,2) NOT NULL,
  `pesos` float(13,2) NOT NULL,
  `canddn1` int(10) unsigned NOT NULL,
  `durddn1` int(10) unsigned NOT NULL,
  `pesosddn1` float(13,2) NOT NULL,
  `canddn2` int(10) unsigned NOT NULL,
  `durddn2` int(10) unsigned NOT NULL,
  `pesosddn2` float(13,2) NOT NULL,
  `canddi1` int(10) unsigned NOT NULL,
  `durddi1` int(10) unsigned NOT NULL,
  `pesosddi1` float(13,2) NOT NULL,
  `canddi2` int(10) unsigned NOT NULL,
  `durddi2` int(10) unsigned NOT NULL,
  `pesosddi2` float(13,2) NOT NULL,
  `canloc1` int(10) unsigned NOT NULL,
  `durloc1` int(10) unsigned NOT NULL,
  `pesosloc1` float(13,2) NOT NULL,
  `canloc2` int(10) unsigned NOT NULL,
  `durloc2` int(10) unsigned NOT NULL,
  `pesosloc2` float(13,2) NOT NULL,
  `facturado` char(1) NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bocanumero`) USING BTREE
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
INSERT INTO `menusql` (`idmenu`,`idmenup`,`nivel`,`codigo`,`descrip`,`arranque`,`comando`,`opcion`,`prun`,`pusu`,`habilitado`,`orden`,`usuario`,`fechahora`,`idmodulo`) VALUES 
 (1,0,'P','01000000000000','Archivos','','','','N','N','S','01','admin','2012092919:33:00',1),
 (2,1,'H','01010000000000','Cambiar Empresa','','DO FORM login','0','S','S','S','01','admin','2014052220:27:14',1),
 (4,0,'P','02000000000000','Otros','','','','N','N','S','03','admin','2016012712:50:15',1),
 (5,4,'H','02010000000000','Provincias','','DO FORM provinciasabm','1','S','S','S','03','admin','2016012712:57:52',1),
 (6,4,'H','02020000000000','Localidades','','DO FORM localidadesabm','2','S','S','S','03','admin','2016012713:05:41',1),
 (7,4,'H','02030000000000','Monedas','','DO FORM monedasabm','3','S','S','S','03','admin','2016012713:14:10',1),
 (8,4,'H','02040000000000','Zonas','','DO FORM zonasabm','4','S','S','S','03','admin','2016012718:14:42',1),
 (9,4,'H','02050000000000','Vendedores','','DO FORM vendedoresabm','5','S','S','S','03','admin','2016012916:07:22',1),
 (10,0,'P','03000000000000','Contabilidad','','','','N','N','S','04','admin','2016030610:36:53',0),
 (11,10,'H','03010000000000','Localidades','','DO FORM localidades','','N','S','S','04','admin','2016030610:37:55',0),
 (12,1,'H','01020000000000','\\-','','','','N','N','S','01','admin','2016030610:51:06',1),
 (13,1,'H','01030000000000','Salir                               Alt+F4','','SALIRMENU()','','S','S','S','01','admin','2016030610:57:03',1),
 (14,0,'P','04000000000000','Ayuda','','','','N','N','S','05','admin','2016030612:09:53',1),
 (15,14,'H','04010000000000','Info.Sistema...','','DO FORM infosistema','','S','S','S','05','admin','2016030612:10:47',1);
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
  PRIMARY KEY (`moneda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `monedas`
--

/*!40000 ALTER TABLE `monedas` DISABLE KEYS */;
INSERT INTO `monedas` (`moneda`,`nombre`,`cotizacion`,`simbolo`) VALUES 
 (1,'PESO',1.0000,'$'),
 (2,'DOLAR',13.5000,'$$'),
 (3,'EURO',25.0000,'$e$');
/*!40000 ALTER TABLE `monedas` ENABLE KEYS */;


--
-- Definition of table `movidepo`
--

DROP TABLE IF EXISTS `movidepo`;
CREATE TABLE `movidepo` (
  `deposito` int(10) unsigned NOT NULL,
  `idajuste` int(10) unsigned NOT NULL,
  `operacion` int(10) unsigned NOT NULL,
  `idtipomov` int(10) unsigned NOT NULL,
  PRIMARY KEY (`deposito`)
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
  `actividad` int(10) unsigned NOT NULL,
  `numeronp` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `hora` char(8) NOT NULL,
  `usuario` char(20) NOT NULL,
  `vendedor` int(10) unsigned NOT NULL,
  `nombrevend` char(100) NOT NULL,
  `transporte` int(10) unsigned NOT NULL,
  `nombretran` char(100) NOT NULL,
  `estado` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `direccion` char(100) NOT NULL,
  `localidad` char(10) NOT NULL,
  `cp` char(20) NOT NULL,
  `provincia` char(10) NOT NULL,
  `pais` char(20) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `cuit` char(13) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `observa` char(254) NOT NULL,
  `sector` int(10) unsigned NOT NULL,
  `tipope` int(10) unsigned NOT NULL,
  `descpe` char(254) NOT NULL,
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
  `actividad` int(10) unsigned NOT NULL,
  `numeronp` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `estado` int(10) unsigned NOT NULL,
  `tipoot` int(10) unsigned NOT NULL,
  `subtipo` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `detalle` char(254) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  `unidad` char(50) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `anulada` char(1) NOT NULL,
  `observa` char(254) NOT NULL,
  `fechaentr` char(8) NOT NULL,
  `ordencpra` char(50) NOT NULL,
  PRIMARY KEY (`idnp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ot`
--

/*!40000 ALTER TABLE `ot` DISABLE KEYS */;
/*!40000 ALTER TABLE `ot` ENABLE KEYS */;


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
  PRIMARY KEY (`idotint`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `otint`
--

/*!40000 ALTER TABLE `otint` DISABLE KEYS */;
/*!40000 ALTER TABLE `otint` ENABLE KEYS */;


--
-- Definition of table `pagosprov`
--

DROP TABLE IF EXISTS `pagosprov`;
CREATE TABLE `pagosprov` (
  `idpago` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `concepto` char(254) NOT NULL,
  `contabilizado` int(10) unsigned NOT NULL,
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
  `idfactprove` int(10) unsigned NOT NULL,
  `idncprove` int(10) unsigned NOT NULL,
  `imputado` float(13,4) NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idpago`)
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
 ('2','BRASIL');
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;


--
-- Definition of table `perfilmh`
--

DROP TABLE IF EXISTS `perfilmh`;
CREATE TABLE `perfilmh` (
  `idperfil` int(11) NOT NULL DEFAULT '0',
  `idmenu` int(11) NOT NULL DEFAULT '0',
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  KEY `idmenu` (`idmenu`),
  KEY `idperfil` (`idperfil`),
  KEY `habilitado` (`habilitado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `perfilmh`
--

/*!40000 ALTER TABLE `perfilmh` DISABLE KEYS */;
INSERT INTO `perfilmh` (`idperfil`,`idmenu`,`habilitado`) VALUES 
 (1,1,'S'),
 (1,2,'S'),
 (1,3,'S'),
 (1,4,'S'),
 (1,5,'S'),
 (1,6,'S'),
 (1,7,'S'),
 (1,8,'S'),
 (1,9,'S'),
 (1,10,'S'),
 (1,11,'S'),
 (1,12,'S'),
 (1,13,'S'),
 (1,14,'S'),
 (1,15,'S');
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
  `usuario` char(20) NOT NULL DEFAULT '',
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
  `ejercicio` int(10) unsigned NOT NULL,
  `anio` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idplan`)
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
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
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
  `doctipo` char(3) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(200) NOT NULL,
  `trasp` int(10) unsigned NOT NULL,
  `nomtransp` char(254) NOT NULL,
  `domentrega` char(254) NOT NULL,
  `stock` char(1) NOT NULL,
  `condvta` char(1) NOT NULL,
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
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `confirmada` char(1) NOT NULL,
  `astoconta` int(10) unsigned NOT NULL,
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `fecha` char(8) NOT NULL,
  PRIMARY KEY (`idpresupu`)
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
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
  `impuesto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(100) NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cantcuotas` int(10) unsigned NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  `idimpuesto` int(10) unsigned NOT NULL,
  `razonimp` float(13,4) NOT NULL,
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(8) NOT NULL,
  `idimpuesto` int(10) unsigned NOT NULL,
  `detalle` char(254) NOT NULL,
  `neto` float(13,4) NOT NULL,
  `razon` float(13,4) NOT NULL,
  `importe` float(13,4) NOT NULL,
  PRIMARY KEY (`idpresupu`)
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
  PRIMARY KEY (`pventa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `puntosventa`
--

/*!40000 ALTER TABLE `puntosventa` DISABLE KEYS */;
/*!40000 ALTER TABLE `puntosventa` ENABLE KEYS */;


--
-- Definition of table `recibos`
--

DROP TABLE IF EXISTS `recibos`;
CREATE TABLE `recibos` (
  `idrecibo` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(254) NOT NULL,
  `nombre` char(254) NOT NULL,
  `importe` float(13,4) NOT NULL,
  `concepto` char(254) NOT NULL,
  `contabilizado` int(10) unsigned NOT NULL,
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
  `idfacturas` int(10) unsigned NOT NULL,
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
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
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
  `doctipo` char(3) NOT NULL,
  `dni` int(10) unsigned NOT NULL,
  `telefono` char(50) NOT NULL,
  `cp` char(50) NOT NULL,
  `fax` char(50) NOT NULL,
  `email` char(200) NOT NULL,
  `transp` int(10) unsigned NOT NULL,
  `nomtransp` char(254) NOT NULL,
  `domentrega` char(254) NOT NULL,
  `stock` char(1) NOT NULL,
  `condvta` char(1) NOT NULL,
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
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `confirmada` char(1) NOT NULL,
  `astoconta` int(10) unsigned NOT NULL,
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
  `idcomproba` int(10) unsigned NOT NULL,
  `puntovta` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `tipo` char(1) NOT NULL,
  `idremitoh` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `unidad` char(10) NOT NULL,
  `cantidadfc` int(10) unsigned NOT NULL,
  `unidadfc` char(10) NOT NULL,
  `detalle` char(254) NOT NULL,
  `unitario` float(13,4) NOT NULL,
  `impuesto` float(13,4) NOT NULL,
  `total` float(13,4) NOT NULL,
  `codigocta` char(20) NOT NULL,
  `nombrecta` char(100) NOT NULL,
  `cuota` int(10) unsigned NOT NULL,
  `cancuotas` int(10) unsigned NOT NULL,
  `padron` int(10) unsigned NOT NULL,
  `idimpuesto` int(10) unsigned NOT NULL,
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
  `idremitop` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `idremitoh` int(10) unsigned NOT NULL,
  `renglon` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `codartprov` char(20) NOT NULL,
  `detalle` char(254) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  `unitario` float(13,2) NOT NULL,
  `unidad` char(20) NOT NULL,
  PRIMARY KEY (`idremitop`)
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
  `idremitop` int(10) unsigned NOT NULL,
  `actividad` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `apellido` char(200) NOT NULL,
  `nombre` char(200) NOT NULL,
  `direccion` char(100) NOT NULL,
  `localidad` char(10) NOT NULL,
  `iva` int(10) unsigned NOT NULL,
  `cuit` char(13) NOT NULL,
  `fecha` char(8) NOT NULL,
  `obs1` char(254) NOT NULL,
  `obs2` char(254) NOT NULL,
  `obs3` char(254) NOT NULL,
  `obs4` char(254) NOT NULL,
  `fecharp` char(8) NOT NULL,
  `activrp` int(10) unsigned NOT NULL,
  `numerorp` int(10) unsigned NOT NULL,
  `deposito` int(10) unsigned NOT NULL,
  `descdepo` char(200) NOT NULL,
  PRIMARY KEY (`idremitop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `remitosprovp`
--

/*!40000 ALTER TABLE `remitosprovp` DISABLE KEYS */;
/*!40000 ALTER TABLE `remitosprovp` ENABLE KEYS */;


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
  `servicio` int(10) unsigned NOT NULL,
  PRIMARY KEY (`impuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `serviciosimpu`
--

/*!40000 ALTER TABLE `serviciosimpu` DISABLE KEYS */;
/*!40000 ALTER TABLE `serviciosimpu` ENABLE KEYS */;


--
-- Definition of table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `deposito` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `stock` float(13,2) NOT NULL,
  PRIMARY KEY (`deposito`)
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
/*!40000 ALTER TABLE `tablasidx` ENABLE KEYS */;


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
  `idtipocom` int(10) unsigned NOT NULL,
  `detalle` char(100) NOT NULL,
  `opera` int(10) unsigned NOT NULL,
  `abrevia` char(50) NOT NULL,
  `destino` char(1) NOT NULL,
  PRIMARY KEY (`idtipocom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipocompro`
--

/*!40000 ALTER TABLE `tipocompro` DISABLE KEYS */;
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
  `movotint` int(10) unsigned NOT NULL,
  `detalle` int(10) unsigned NOT NULL,
  `operacion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`movotint`)
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
  PRIMARY KEY (`idtipomov`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipomstock`
--

/*!40000 ALTER TABLE `tipomstock` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipomstock` ENABLE KEYS */;


--
-- Definition of table `tiponp`
--

DROP TABLE IF EXISTS `tiponp`;
CREATE TABLE `tiponp` (
  `tipope` int(10) unsigned NOT NULL,
  `descpe` char(254) NOT NULL,
  `stock` char(1) NOT NULL,
  PRIMARY KEY (`tipope`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiponp`
--

/*!40000 ALTER TABLE `tiponp` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiponp` ENABLE KEYS */;


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
-- Definition of table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `usuario` char(15) NOT NULL DEFAULT '',
  `nombre` char(100) NOT NULL DEFAULT '',
  `clave` char(15) NOT NULL DEFAULT '',
  `jerarquia` char(60) NOT NULL DEFAULT '',
  `seccion` char(20) NOT NULL DEFAULT '',
  `email` char(80) NOT NULL,
  `habilitado` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`usuario`),
  KEY `usuario` (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--

/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`usuario`,`nombre`,`clave`,`jerarquia`,`seccion`,`email`,`habilitado`) VALUES 
 ('FEDE','FEDERICO CARRION','F','Supervisor','INGENIERIA','','S'),
 ('TULIO','Tulio Rossi','A','Supervisor','INGENIERIA','trossi@cosemar.com.ar','S');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;


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
 (1,'Federico Carrion','Ricardo Gutierrez 1962','1','38374141','3483485750','fedecarrion137@gmail.com',''),
 (2,'Tulio Rossi','Avellaneda 6963','3','25826321','3424376983','tulior@cosemar.com',''),
 (3,'Javier','Pampa 232','1','35555666','3483485751','javi@gmail.com',''),
 (4,'FGDF','GDGDF','5','4564','5527','SDFDD','');
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




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
