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
-- Definition of table `afipescalas`
--

DROP TABLE IF EXISTS `afipescalas`;
CREATE TABLE `afipescalas` (
  `idafipesc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` int(10) unsigned NOT NULL,
  `descrip` char(100) NOT NULL,
  `valmin` double(13,2) NOT NULL,
  `valmax` double(13,2) NOT NULL,
  `valfijo` double(13,2) NOT NULL,
  `razon` double(13,2) NOT NULL,
  `minret` double(13,2) NOT NULL,
  PRIMARY KEY (`idafipesc`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `afipescalas`
--

/*!40000 ALTER TABLE `afipescalas` DISABLE KEYS */;
INSERT INTO `afipescalas` (`idafipesc`,`codigo`,`descrip`,`valmin`,`valmax`,`valfijo`,`razon`,`minret`) VALUES 
 (1,1,'Escala Ret. Gan. Inscriptos Reg 19',0.00,-1.00,0.00,3.00,240.00),
 (2,2,'Escala Ret. Gan. NO Inscriptos Reg 19',0.00,-1.00,0.00,10.00,240.00),
 (3,3,'Escala Ret. Gan. Inscriptos Reg 21',0.00,-1.00,0.00,6.00,240.00),
 (4,4,'Escala Ret. Gan. NO Inscriptos Reg 21',0.00,-1.00,0.00,25.00,240.00),
 (5,5,'Escala Ret. Gan. Inscriptos Reg 30',0.00,-1.00,0.00,6.00,240.00),
 (6,6,'Escala Ret. Gan. NO Inscriptos Reg 30',0.00,-1.00,0.00,25.00,240.00),
 (7,7,'Escala Ret. Gan. Inscriptos Reg 31',0.00,-1.00,0.00,6.00,240.00),
 (8,8,'Escala Ret. Gan. NO Inscriptos Reg 31',0.00,-1.00,0.00,25.00,1020.00),
 (9,9,'Escala Ret. Gan. Inscriptos Reg 32',0.00,-1.00,0.00,6.00,240.00),
 (10,10,'Escala Ret. Gan. NO Inscriptos Reg 32',0.00,-1.00,0.00,25.00,240.00),
 (11,11,'Escala Ret. Gan. Inscriptos Reg 35',0.00,-1.00,0.00,6.00,240.00),
 (12,12,'Escala Ret. Gan. NO Inscriptos Reg 35',0.00,-1.00,0.00,25.00,240.00),
 (13,13,'Escala Ret. Gan. Inscriptos Reg 43',0.00,-1.00,0.00,6.00,240.00),
 (14,14,'Escala Ret. Gan. NO Inscriptos Reg 43',0.00,-1.00,0.00,25.00,240.00),
 (15,15,'Escala Ret. Gan. Inscriptos Reg 51',0.00,-1.00,0.00,6.00,240.00),
 (16,16,'Escala Ret. Gan. NO Inscriptos Reg 51',0.00,-1.00,0.00,25.00,240.00),
 (17,17,'Escala Ret. Gan. Inscriptos Reg 78',0.00,-1.00,0.00,2.00,240.00),
 (18,18,'Escala Ret. Gan. NO Inscriptos Reg 78',0.00,-1.00,0.00,10.00,240.00),
 (19,19,'Escala Ret. Gan. Inscriptos Reg 86',0.00,-1.00,0.00,2.00,240.00),
 (20,20,'Escala Ret. Gan. NO Inscriptos Reg 86',0.00,-1.00,0.00,10.00,240.00),
 (21,21,'Escala Ret. Gan. Inscriptos Reg 110 a',0.00,8000.00,0.00,5.00,0.00),
 (22,21,'Escala Ret. Gan. Inscriptos Reg 110 b',8000.00,16000.00,400.00,9.00,0.00),
 (23,21,'Escala Ret. Gan. Inscriptos Reg 110 c',16000.00,24000.00,1120.00,12.00,0.00),
 (24,21,'Escala Ret. Gan. Inscriptos Reg 110 d',24000.00,32000.00,2080.00,15.00,0.00),
 (25,21,'Escala Ret. Gan. Inscriptos Reg 110 e',32000.00,48000.00,3280.00,19.00,0.00),
 (26,21,'Escala Ret. Gan. Inscriptos Reg 110 f',48000.00,64000.00,6320.00,23.00,0.00),
 (27,21,'Escala Ret. Gan. Inscriptos Reg 110 g',64000.00,96000.00,10000.00,27.00,0.00),
 (28,21,'Escala Ret. Gan. Inscriptos Reg 110 h',96000.00,-1.00,18640.00,31.00,0.00),
 (29,22,'Escala Ret. Gan. NO Inscriptos Reg 110',0.00,-1.00,0.00,28.00,240.00),
 (30,23,'Escala Ret. Gan. Inscriptos Reg 94',0.00,-1.00,0.00,2.00,240.00),
 (31,24,'Escala Ret. Gan. NO Inscriptos Reg 94',0.00,-1.00,0.00,25.00,240.00),
 (32,25,'Escala Ret. Gan. Inscriptos Reg 25 a',0.00,8000.00,0.00,5.00,0.00),
 (33,25,'Escala Ret. Gan. Inscriptos Reg 25 b',8000.00,16000.00,400.00,9.00,0.00),
 (34,25,'Escala Ret. Gan. Inscriptos Reg 25 c',16000.00,24000.00,1120.00,12.00,0.00),
 (35,25,'Escala Ret. Gan. Inscriptos Reg 25 d',24000.00,32000.00,2080.00,15.00,0.00),
 (36,25,'Escala Ret. Gan. Inscriptos Reg 25 e',32000.00,48000.00,3280.00,19.00,0.00),
 (37,25,'Escala Ret. Gan. Inscriptos Reg 25 f',48000.00,64000.00,6320.00,23.00,0.00),
 (38,25,'Escala Ret. Gan. Inscriptos Reg 25 g',64000.00,96000.00,10000.00,27.00,0.00),
 (39,25,'Escala Ret. Gan. Inscriptos Reg 25 h',96000.00,-1.00,18640.00,31.00,0.00),
 (40,26,'Escala Ret. Gan. NO Inscriptos Reg 25',0.00,-1.00,0.00,28.00,240.00),
 (41,27,'Escala Ret. Gan. Inscriptos Reg 116 a',0.00,8000.00,0.00,5.00,0.00),
 (42,27,'Escala Ret. Gan. Inscriptos Reg 116 b',8000.00,16000.00,400.00,9.00,0.00),
 (43,27,'Escala Ret. Gan. Inscriptos Reg 116 c',16000.00,24000.00,1120.00,12.00,0.00),
 (44,27,'Escala Ret. Gan. Inscriptos Reg 116 d',24000.00,32000.00,2080.00,15.00,0.00),
 (45,27,'Escala Ret. Gan. Inscriptos Reg 116 e',32000.00,48000.00,3280.00,19.00,0.00),
 (46,27,'Escala Ret. Gan. Inscriptos Reg 116 f',48000.00,64000.00,6320.00,23.00,0.00),
 (47,27,'Escala Ret. Gan. Inscriptos Reg 116 g',64000.00,96000.00,10000.00,27.00,0.00),
 (48,27,'Escala Ret. Gan. Inscriptos Reg 116 h',96000.00,-1.00,18640.00,31.00,0.00),
 (49,28,'Escala Ret. Gan. NO Inscriptos Reg 116',0.00,-1.00,0.00,28.00,240.00),
 (50,29,'Escala Ret. Gan. Inscriptos Reg 116 a',0.00,8000.00,0.00,5.00,0.00),
 (51,29,'Escala Ret. Gan. Inscriptos Reg 116 b',8000.00,16000.00,400.00,9.00,0.00),
 (52,29,'Escala Ret. Gan. Inscriptos Reg 116 c',16000.00,24000.00,1120.00,12.00,0.00),
 (53,29,'Escala Ret. Gan. Inscriptos Reg 116 d',24000.00,32000.00,2080.00,15.00,0.00),
 (54,29,'Escala Ret. Gan. Inscriptos Reg 116 e',32000.00,48000.00,3280.00,19.00,0.00),
 (55,29,'Escala Ret. Gan. Inscriptos Reg 116 f',48000.00,64000.00,6320.00,23.00,0.00),
 (56,29,'Escala Ret. Gan. Inscriptos Reg 116 g',64000.00,96000.00,10000.00,27.00,0.00),
 (57,29,'Escala Ret. Gan. Inscriptos Reg 116 h',96000.00,-1.00,18640.00,31.00,0.00),
 (58,30,'Escala Ret. Gan. NO Inscriptos Reg 116',0.00,-1.00,0.00,28.00,240.00),
 (59,31,'Escala Ret. Gan. Inscriptos Reg 124 a',0.00,8000.00,0.00,5.00,0.00),
 (60,31,'Escala Ret. Gan. Inscriptos Reg 124 b',8000.00,16000.00,400.00,9.00,0.00),
 (61,31,'Escala Ret. Gan. Inscriptos Reg 124 c',16000.00,24000.00,1120.00,12.00,0.00),
 (62,31,'Escala Ret. Gan. Inscriptos Reg 124 d',24000.00,32000.00,2080.00,15.00,0.00),
 (63,31,'Escala Ret. Gan. Inscriptos Reg 124 e',32000.00,48000.00,3280.00,19.00,0.00),
 (64,31,'Escala Ret. Gan. Inscriptos Reg 124 f',48000.00,64000.00,6320.00,23.00,0.00),
 (65,31,'Escala Ret. Gan. Inscriptos Reg 124 g',64000.00,96000.00,10000.00,27.00,0.00),
 (66,31,'Escala Ret. Gan. Inscriptos Reg 124 h',96000.00,-1.00,18640.00,31.00,0.00),
 (67,32,'Escala Ret. Gan. NO Inscriptos Reg 124',0.00,-1.00,0.00,28.00,240.00),
 (68,33,'Escala Ret. Gan. Inscriptos Reg 95',0.00,-1.00,0.00,0.25,240.00),
 (69,34,'Escala Ret. Gan. NO Inscriptos Reg 95',0.00,-1.00,0.00,25.00,240.00),
 (70,35,'Escala Ret. Gan. Inscriptos Reg 53',0.00,-1.00,0.00,0.50,240.00),
 (71,36,'Escala Ret. Gan. NO Inscriptos Reg 53',0.00,-1.00,0.00,2.00,240.00),
 (72,37,'Escala Ret. Gan. Inscriptos Reg 55',0.00,-1.00,0.00,0.50,240.00),
 (73,38,'Escala Ret. Gan. NO Inscriptos Reg 55',0.00,-1.00,0.00,2.00,240.00),
 (74,39,'Escala Ret. Gan. Inscriptos Reg 111',0.00,-1.00,0.00,0.50,240.00),
 (75,40,'Escala Ret. Gan. NO Inscriptos Reg 111',0.00,-1.00,0.00,2.00,240.00),
 (76,41,'Escala Ret. Gan. Inscriptos Reg 112',0.00,-1.00,0.00,3.00,240.00),
 (77,42,'Escala Ret. Gan. NO Inscriptos Reg 112',0.00,-1.00,0.00,3.00,240.00),
 (78,43,'Escala Ret. Gan. Inscriptos Reg 113',0.00,-1.00,0.00,3.00,240.00),
 (79,44,'Escala Ret. Gan. NO Inscriptos Reg 113',0.00,-1.00,0.00,3.00,240.00),
 (80,45,'Escala Ret. Gan. Inscriptos Reg 779',0.00,-1.00,0.00,2.00,240.00),
 (81,46,'Escala Ret. Gan. NO Inscriptos Reg 779',0.00,-1.00,0.00,10.00,240.00),
 (82,47,'Escala Ret. Gan. Inscriptos Reg 780',0.00,-1.00,0.00,2.00,240.00),
 (83,48,'Escala Ret. Gan. NO Inscriptos Reg 780',0.00,-1.00,0.00,25.00,240.00);
/*!40000 ALTER TABLE `afipescalas` ENABLE KEYS */;


--
-- Definition of table `impuretencion`
--

DROP TABLE IF EXISTS `impuretencion`;
CREATE TABLE `impuretencion` (
  `idimpuret` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(200) NOT NULL,
  `razonin` int(10) unsigned NOT NULL,
  `baseimpon` double(13,2) NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `funcion` char(100) NOT NULL,
  `razonnin` int(10) unsigned NOT NULL,
  `baseimponn` double(13,2) NOT NULL,
  PRIMARY KEY (`idimpuret`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `impuretencion`
--

/*!40000 ALTER TABLE `impuretencion` DISABLE KEYS */;
INSERT INTO `impuretencion` (`idimpuret`,`detalle`,`razonin`,`baseimpon`,`idtipopago`,`funcion`,`razonnin`,`baseimponn`) VALUES 
 (1,'Reg. 19 - Intereses por op. realizadas en entidades financieras. Ley 21526 o agentes de bolsa o mercado',1,0.00,5,'RET_GANANCIAS_IFN',2,0.00),
 (2,'Reg. 21 - Intereses originados en op. no comprendidas en Reg. 19',3,7870.00,5,'RET_GANANCIAS_IFN',4,0.00),
 (3,'Reg. 30 - Alquileres o arrendamientos de bienes muebles',5,11200.00,5,'RET_GANANCIAS_IFN',6,0.00),
 (4,'Reg. 31 - Bienes inmuebles urbanos, incluidos los efectuados bajo la modalidad de leasing - incluye suburbanos',7,11200.00,5,'RET_GANANCIAS_IFN',8,0.00),
 (5,'Reg. 32 - Bienes inmuebles rurales, incluidos los efectuados bajo la modalidad de leasing - incluye subrurales',9,11200.00,5,'RET_GANANCIAS_IFN',10,0.00),
 (6,'Reg. 35 - Regalias',11,7870.00,5,'RET_GANANCIAS_IFN',12,0.00),
 (7,'Reg. 43 - Interés accionario, excedentes y retornos distribuidos entre asociados, cooperativas - excepto consumo',13,7870.00,5,'RET_GANANCIAS_IFN',14,0.00),
 (8,'Reg. 51 - Obligaciones de no hacer, o por abandono o no ejercicio de una actividad',15,7870.00,5,'RET_GANANCIAS_IFN',16,0.00),
 (9,'Reg. 78 - Enajenación de bienes muebles y bienes de cambio',17,224000.00,5,'RET_GANANCIAS_IFN',18,0.00),
 (10,'Reg. 86 - Transf. temporaria o definitiva de derechos de llave, marcas, patentes de inv., regalías, concesiones y similares',19,224000.00,5,'RET_GANANCIAS_IFN',20,0.00),
 (11,'Reg. 110 - Explotación de derechos de autor',21,10000.00,5,'RET_GANANCIAS_IFN',22,0.00),
 (12,'Reg. 94 - Locaciones de obra y/o servicios no ejecutados en rel. de dep. no mencionados en otros incisos',23,67170.00,5,'RET_GANANCIAS_IFN',24,0.00),
 (13,'Reg. 25 - Comisiones u otras retribuciones derivadas de act. comisionista, rematador, consignatario y aux de comercio que se refiere en el articulo c del articulo 49',25,16830.00,5,'RET_GANANCIAS_IFN',26,0.00),
 (14,'Reg. 116 - Honorarios de director de SA., sidico, fiduciario, consejero de soc. coop., integrante de consejos de vigilancia y soc. admin. de SRL...',27,67170.00,5,'RET_GANANCIAS_IFN',28,0.00),
 (15,'Reg. 116 - Profesionales liberales, oficios, albacea, mandatarios, gestor de negocio',29,16830.00,5,'RET_GANANCIAS_IFN',30,0.00),
 (16,'Reg. 124 - Corredor viajante de comercio y despachante de aduana',31,16830.00,5,'RET_GANANCIAS_IFN',32,0.00),
 (17,'Reg. 95 - Operaciones de transporte de carga nacional e internacional',33,67170.00,5,'RET_GANANCIAS_IFN',34,0.00),
 (18,'Reg. 53 - Operaciones realizadas por intermedio de mercados de cereales a término',35,0.00,5,'RET_GANANCIAS_IFN',36,0.00),
 (19,'Reg. 55 - Distribución de películas. Transmisión de programación. Televisión via satelital',37,0.00,5,'RET_GANANCIAS_IFN',38,0.00),
 (20,'Reg. 111 - Cualquier otra cesión o locación de derechos, excepto las que correspondan a operaciones realizadas por intermedio de mercados de cereales',39,0.00,5,'RET_GANANCIAS_IFN',40,0.00),
 (21,'Reg. 112 - Benef. provenientes de los req. de los planes de seguro de retiro privados admin. lo establecido en el inciso d del art. 45 y el inciso d del art 79 excepto lo alcanzado por RG 2437',41,16830.00,5,'RET_GANANCIAS_IFN',42,16830.00),
 (22,'Reg. 113 - Rescates por desistimiento de planes de seguro de retiro referido en el inciso o, excepto que sea de aplicación lo normalizado en el art 101 de la ley de imp. a las ganancias',43,16830.00,5,'RET_GANANCIAS_IFN',44,16830.00),
 (23,'Reg. 779 - Subsidios abonados por los Est. Nacional, provinciales, municipales, en concepto de enajenación de bs muebles y bs de cambio',45,76140.00,5,'RET_GANANCIAS_IFN',46,0.00),
 (24,'Reg. 780 - Subsidios abonados por los Est. Nacional, provinciales, municipales en concepto de locaciones de obras y/o serv. no en rel de dependencia',47,31460.00,5,'RET_GANANCIAS_IFN',48,0.00);
/*!40000 ALTER TABLE `impuretencion` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
