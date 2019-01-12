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
 ('_SYSDETAMOD','C','N','Permite editar y modificar el detalle de los comprobantes','1','N'),
 ('_SYSDIASPUNI','N','0','Cantidad de dias para aplicación de intereses punitorios','1','N'),
 ('_SYSIMPOMOD','C','N','Permite modificar los importes de los comprobantes','1','N'),
 ('_SYSINTERESMOD','C','N','Permite la modificación de los intereses cuando se cobra','1','N'),
 ('_SYSLONGCART','N','10.00','Longitud de codificacion de Articulos','1','N'),
 ('_SYSLONGCMAT','N','10.00','Longitud de codigicacion de materiales','1','N'),
 ('_SYSNUMEROSMOD','C','N','Permite la modificación de los números de comprobantes','1','N'),
 ('_SYSPATHARCHIVOS','C','C:\\GitHub\\ProyectoProcessar\\Archivos\\','Variable para guardar archivos compartidos','1','N'),
 ('_SYSSTOCKACTRL','C','N','Permite el descuento del stock cuando no tiene existencia el articulo','1','N'),
 ('_SYSSTOCKMCTRL','C','N','Permite el descuento de materiales cuando no hay existencia en el stock','1','N'),
 ('_SYSTASAPUNI','N','0.00','Tasa de intereses punitorios','1','N'),
 ('_SYSTOLEPUNI','N','0','Cantidad de días de tolerancia antes de intereses punitorios','1','N'),
 ('_SYSVCUIT','C','S','Valida el ingreso del CUIT, si existe o sino se duplica','1','N');
/*!40000 ALTER TABLE `varpublicas` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
