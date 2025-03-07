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
-- Create schema processar_cobrador
--

CREATE DATABASE IF NOT EXISTS processar_cobrador;
USE processar_cobrador;

--
-- Definition of table `cbasociadas`
--

DROP TABLE IF EXISTS `cbasociadas`;
CREATE TABLE `cbasociadas` (
  `idcbasoci` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `empresaid` char(15) NOT NULL,
  `nombre` char(100) NOT NULL,
  `cuit` char(13) NOT NULL,
  `activa` char(1) NOT NULL,
  `cobra` char(1) NOT NULL,
  `cobropar` char(1) NOT NULL,
  `narchivoe` char(4) NOT NULL,
  `narchivor` char(4) NOT NULL,
  `esecuencia` int(10) unsigned NOT NULL,
  `ftp` char(100) NOT NULL,
  `email` char(100) NOT NULL,
  `elong` char(10) NOT NULL,
  `eempresaid` char(10) NOT NULL,
  `eesecuencia` char(10) NOT NULL,
  `eperiodo` char(10) NOT NULL,
  `ebc` char(10) NOT NULL,
  `ebceid` char(10) NOT NULL,
  `ebcsid` char(10) NOT NULL,
  `ebcidcomp` char(10) NOT NULL,
  `etotal1` char(10) NOT NULL,
  `evence1` char(10) NOT NULL,
  `etotal2` char(10) NOT NULL,
  `evence2` char(10) NOT NULL,
  `etotal3` char(10) NOT NULL,
  `evence3` char(10) NOT NULL,
  `eentidad` char(10) NOT NULL,
  `eservicio` char(10) NOT NULL,
  `ecuenta` char(10) NOT NULL,
  `edescrip` char(10) NOT NULL,
  `edescripen` char(10) NOT NULL,
  `r0empresaid` char(10) NOT NULL,
  `r0puntorec` char(10) NOT NULL,
  `r0secuencia` char(10) NOT NULL,
  `r1idcobro` char(10) NOT NULL,
  `r1fechacobro` char(10) NOT NULL,
  `r1importe` char(10) NOT NULL,
  `r1recargo` char(10) NOT NULL,
  `r1bc` char(10) NOT NULL,
  `r2cantidad` char(10) NOT NULL,
  `r2total` char(10) NOT NULL,
  `subcodid` char(15) NOT NULL,
  PRIMARY KEY (`idcbasoci`,`cuit`) USING BTREE,
  KEY `Index_2` (`subcodid`),
  KEY `Index_3` (`empresaid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbasociadas`
--

/*!40000 ALTER TABLE `cbasociadas` DISABLE KEYS */;
INSERT INTO `cbasociadas` (`idcbasoci`,`empresaid`,`nombre`,`cuit`,`activa`,`cobra`,`cobropar`,`narchivoe`,`narchivor`,`esecuencia`,`ftp`,`email`,`elong`,`eempresaid`,`eesecuencia`,`eperiodo`,`ebc`,`ebceid`,`ebcsid`,`ebcidcomp`,`etotal1`,`evence1`,`etotal2`,`evence2`,`etotal3`,`evence3`,`eentidad`,`eservicio`,`ecuenta`,`edescrip`,`edescripen`,`r0empresaid`,`r0puntorec`,`r0secuencia`,`r1idcobro`,`r1fechacobro`,`r1importe`,`r1recargo`,`r1bc`,`r2cantidad`,`r2total`,`subcodid`) VALUES 
 (1,'0001','Krumbein','30-71204634-8','S','S','S','0001','0001',10,'','ventas@amoblark.com.ar','1-213','1-4','5-5','10-14','24-23','24-4','28-4','32-15','47-12','59-7','66-12','78-7','85-12','97-7','104-6','110-2','112-2','114-50','164-50','2-4','6-13','19-5','2-8','10-7','17-12','29-10','39-23','2-6','8-16','0002'),
 (2,'0002','Cooperativa','20-11222333-8','S','S','S','0002','0002',1,'','ventas@cooperativa.com.ar','1-213','1-4','5-5','10-14','24-23','24-4','28-4','32-15','47-12','59-7','66-12','78-7','85-12','97-7','104-6','110-2','112-2','114-50','164-50','2-4','6-13','19-5','2-8','10-7','17-12','29-10','39-23','2-6','8-16','0003');
/*!40000 ALTER TABLE `cbasociadas` ENABLE KEYS */;


--
-- Definition of table `cbcobros`
--

DROP TABLE IF EXISTS `cbcobros`;
CREATE TABLE `cbcobros` (
  `idcbcobro` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcbcompro` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `importe` double(13,2) NOT NULL,
  `recargo` double(13,2) NOT NULL,
  `lotecobro` int(10) unsigned NOT NULL,
  `entrega` double(13,2) NOT NULL,
  `vuelto` double(13,2) NOT NULL,
  `usuario` char(20) NOT NULL,
  `host` char(20) NOT NULL,
  `secuencia` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcbcobro`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcobros`
--

/*!40000 ALTER TABLE `cbcobros` DISABLE KEYS */;
INSERT INTO `cbcobros` (`idcbcobro`,`idcbcompro`,`fecha`,`importe`,`recargo`,`lotecobro`,`entrega`,`vuelto`,`usuario`,`host`,`secuencia`,`timestamp`) VALUES 
 (14,34,'20220314',346.94,10.00,1,350.00,3.06,'TULIO','PC-PABLO',1,'2022-03-14 19:51:26'),
 (15,37,'20220407',283.93,0.00,2,8250.00,1.07,'TULIO','PC-PABLO',2,'2022-04-07 21:35:52'),
 (16,41,'20220407',7965.00,100.00,2,8250.00,1.07,'TULIO','PC-PABLO',2,'2022-04-07 21:35:52'),
 (17,40,'20220407',1669.65,200.00,3,1700.00,30.35,'TULIO','PC-PABLO',2,'2022-04-07 21:36:16'),
 (18,59,'20220423',3887.22,947.92,4,4200.00,28.85,'TULIO','PC-PABLO',3,'2022-04-23 12:28:23'),
 (19,60,'20220423',283.93,0.00,4,4200.00,28.85,'TULIO','PC-PABLO',3,'2022-04-23 12:28:23'),
 (20,61,'20220427',283.93,0.00,5,300.00,16.07,'TULIO','PC-PABLO',4,'2022-04-27 20:37:14'),
 (21,69,'20220430',2200.00,0.00,6,2200.00,0.00,'TULIO','PC-PABLO',5,'2022-04-30 11:45:28'),
 (22,65,'20220430',123.54,0.00,7,150.00,26.46,'TULIO','PC-PABLO',5,'2022-04-30 11:55:26');
/*!40000 ALTER TABLE `cbcobros` ENABLE KEYS */;


--
-- Definition of table `cbcomprobantes`
--

DROP TABLE IF EXISTS `cbcomprobantes`;
CREATE TABLE `cbcomprobantes` (
  `idcbcompro` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcbasoci` int(10) unsigned NOT NULL,
  `narchivo` char(100) NOT NULL,
  `lote` int(10) unsigned NOT NULL,
  `eperiodo` char(20) NOT NULL,
  `esecuencia` char(10) NOT NULL,
  `total1` double(13,2) NOT NULL,
  `vence1` char(8) NOT NULL,
  `total2` double(13,2) NOT NULL,
  `vence2` char(8) NOT NULL,
  `total3` double(13,2) NOT NULL,
  `vence3` char(8) NOT NULL,
  `bc` char(254) NOT NULL,
  `idcomp` char(15) NOT NULL DEFAULT '0',
  `entidad` int(10) unsigned NOT NULL,
  `servicio` int(10) unsigned NOT NULL,
  `cuenta` int(10) unsigned NOT NULL,
  `descrip` char(250) NOT NULL,
  `descripen` char(250) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcbcompro`),
  KEY `Index_2` (`idcomp`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cbcomprobantes`
--

/*!40000 ALTER TABLE `cbcomprobantes` DISABLE KEYS */;
INSERT INTO `cbcomprobantes` (`idcbcompro`,`idcbasoci`,`narchivo`,`lote`,`eperiodo`,`esecuencia`,`total1`,`vence1`,`total2`,`vence2`,`total3`,`vence3`,`bc`,`idcomp`,`entidad`,`servicio`,`cuenta`,`descrip`,`descripen`,`timestamp`) VALUES 
 (34,1,'0001',1,'2022031420220314','1',336.94,'20220314',387.48,'20220413',445.60,'20220513','00010001000000000033800','000000000033800',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (35,1,'0001',1,'2022031420220314','1',673.87,'20220314',774.95,'20220413',891.19,'20220513','00010001000000000033900','000000000033900',10,0,0,'','MAURICIO RAMIREZ','0000-00-00 00:00:00'),
 (36,1,'0001',1,'2022031420220314','1',2939.30,'20220314',3380.20,'20220413',3887.22,'20220513','00010001000000000034000','000000000034000',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (37,1,'0001',2,'2022040720220407','2',283.93,'20220507',326.52,'20220606',375.50,'20220706','00010001000000000034101','000000000034101',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (38,1,'0001',2,'2022040720220407','2',283.93,'20220606',326.52,'20220706',375.50,'20220805','00010001000000000034102','000000000034102',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (39,1,'0001',2,'2022040720220407','2',283.93,'20220706',326.52,'20220805',375.50,'20220904','00010001000000000034103','000000000034103',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (40,1,'0001',2,'2022040720220407','2',1469.65,'20220407',1690.10,'20220507',1943.61,'20220606','00010001000000000034200','000000000034200',7,0,0,'','HUGO ALEGRE','0000-00-00 00:00:00'),
 (41,1,'0001',2,'2022040720220407','2',7865.00,'20220407',9044.75,'20220507',10401.46,'20220606','00010001000000000034300','000000000034300',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (42,1,'0001',3,'2022010120220416','3',673.87,'20220314',774.95,'20220413',891.19,'20220513','00010001000000000033900','000000000033900',10,0,0,'','MAURICIO RAMIREZ','0000-00-00 00:00:00'),
 (43,1,'0001',3,'2022010120220416','3',2939.30,'20220314',3380.20,'20220413',3887.22,'20220513','00010001000000000034000','000000000034000',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (44,1,'0001',3,'2022010120220416','3',283.93,'20220606',326.52,'20220706',375.50,'20220805','00010001000000000034102','000000000034102',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (45,1,'0001',3,'2022010120220416','3',283.93,'20220706',326.52,'20220805',375.50,'20220904','00010001000000000034103','000000000034103',1,0,0,'','KRUMBEIN S.A. KRUMBEIN S.A.','0000-00-00 00:00:00'),
 (58,1,'0001',4,'2022010120220422','7',673.87,'20220314',774.95,'20220413',891.19,'20220513','00010001000000000033900','000000000033900',10,0,0,'FACTURA B 0001-00000017','MAURICIO RAMIREZ','2022-04-22 20:52:47'),
 (59,1,'0001',4,'2022010120220422','7',2939.30,'20220314',3380.20,'20220413',3887.22,'20220513','00010001000000000034000','000000000034000',1,0,0,'FACTURA A 0001-00000134','KRUMBEIN S.A. KRUMBEIN S.A.','2022-04-22 20:52:47'),
 (60,1,'0001',4,'2022010120220422','7',283.93,'20220606',326.52,'20220706',375.50,'20220805','00010001000000000034102','000000000034102',1,0,0,'FACTURA A 0001-00000135','KRUMBEIN S.A. KRUMBEIN S.A.','2022-04-22 20:52:47'),
 (61,1,'0001',4,'2022010120220422','7',283.93,'20220706',326.52,'20220805',375.50,'20220904','00010001000000000034103','000000000034103',1,0,0,'FACTURA A 0001-00000135','KRUMBEIN S.A. KRUMBEIN S.A.','2022-04-22 20:52:47'),
 (62,1,'0001',5,'2022031420220427','8',673.87,'20220314',774.95,'20220413',891.19,'20220513','00010001000000000033900','000000000033900',10,0,0,'FACTURA B 0001-00000017','MAURICIO RAMIREZ','2022-04-27 20:56:37'),
 (63,1,'0001',5,'2022031420220427','8',283.93,'20220706',326.52,'20220805',375.50,'20220904','00010001000000000034103','000000000034103',1,0,0,'FACTURA A 0001-00000135','KRUMBEIN S.A. KRUMBEIN S.A.','2022-04-27 20:56:37'),
 (64,1,'0001',6,'2022043020220430','10',1806.59,'20220430',2077.58,'20220530',2389.22,'20220629','00010001000000000034400','000000000034400',5,0,0,'FACTURA A 0009-00000047','DIANA ALARCONCUIT:27173688887','2022-04-30 10:59:15'),
 (65,1,'0001',6,'2022043020220430','10',123.54,'20220530',142.07,'20220629',163.38,'20220729','00010001000000000034501','000000000034501',1,0,0,'FACTURA A 0001-00000137','KRUMBEIN S.A. KRUMBEIN S.A.CUIT:30412046348','2022-04-30 10:59:15'),
 (66,1,'0001',6,'2022043020220430','10',123.54,'20220629',142.07,'20220729',163.38,'20220828','00010001000000000034502','000000000034502',1,0,0,'FACTURA A 0001-00000137','KRUMBEIN S.A. KRUMBEIN S.A.CUIT:30412046348','2022-04-30 10:59:15'),
 (67,1,'0001',6,'2022043020220430','10',123.54,'20220729',142.07,'20220828',163.38,'20220927','00010001000000000034503','000000000034503',1,0,0,'FACTURA A 0001-00000137','KRUMBEIN S.A. KRUMBEIN S.A.CUIT:30412046348','2022-04-30 10:59:15'),
 (68,1,'0001',6,'2022043020220430','10',200.49,'20220430',230.56,'20220530',265.15,'20220629','00010001000000000034600','000000000034600',1,0,0,'FACTURA A 0001-00000138','KRUMBEIN S.A. KRUMBEIN S.A.CUIT:30412046348','2022-04-30 10:59:15'),
 (69,1,'0001',6,'2022043020220430','10',2200.00,'20220530',2530.00,'20220629',2909.50,'20220729','00010001000000000034701','000000000034701',7,0,0,'FACTURA B 0001-00000019','HUGO ALEGRECUIT:27291480669','2022-04-30 10:59:15'),
 (70,1,'0001',6,'2022043020220430','10',673.87,'20220430',774.95,'20220530',891.19,'20220629','00010001000000000034800','000000000034800',1,0,0,'FACTURA A 0001-00000139','KRUMBEIN S.A. KRUMBEIN S.A.CUIT:30412046348','2022-04-30 10:59:15'),
 (71,1,'0001',6,'2022043020220430','10',1469.65,'20220430',1690.10,'20220530',1943.61,'20220629','00010001000000000034900','000000000034900',10,0,0,'FACTURA B 0001-00000020','MAURICIO RAMIREZDNI:33464444','2022-04-30 10:59:15');
/*!40000 ALTER TABLE `cbcomprobantes` ENABLE KEYS */;


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
  `serviciofe` char(254) NOT NULL,
  `urlwsaa` char(254) NOT NULL,
  `servicioafip` char(254) NOT NULL,
  `proxy` char(254) NOT NULL,
  `proxyusu` char(254) NOT NULL,
  `proxypass` char(254) NOT NULL,
  `certificado` text NOT NULL,
  `intaut` int(10) unsigned NOT NULL DEFAULT '1',
  `intta` int(10) unsigned NOT NULL DEFAULT '1',
  `imagenlogo` mediumtext NOT NULL,
  `pconfafip` char(254) NOT NULL,
  `nombrecert` char(100) NOT NULL,
  `vencecert` char(8) NOT NULL,
  PRIMARY KEY (`empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empresa`
--

/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` (`empresa`,`nomfiscal`,`cuit`,`iva`,`iibb`,`direccion`,`localidad`,`inicioact`,`telefono`,`email`,`web`,`logoempre`,`serviciofe`,`urlwsaa`,`servicioafip`,`proxy`,`proxyusu`,`proxypass`,`certificado`,`intaut`,`intta`,`imagenlogo`,`pconfafip`,`nombrecert`,`vencecert`) VALUES 
 ('Krumbein Hogar','Krumbein','30-71204634-8','IVA Responsable Inscripto','151-011000-7','9 de Julio 1609','0083','19860501','3483-498405','ventas@amoblark.com.ar','','IMGAMOBLARK1.JPG','wsfe','https://wsaahomo.afip.gov.ar/ws/services/LoginCms?WSDL','ClienteLoginCms_CS.ar.gov.afip.wswhomo','','','','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',10,10,'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','','CERTIFICADOMK.PFX','');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
