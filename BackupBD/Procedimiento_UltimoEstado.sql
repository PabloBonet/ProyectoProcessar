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
-- Create schema processarmkfc
--

CREATE DATABASE IF NOT EXISTS processarmkfc;
USE processarmkfc;

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
  `fecha` char(8) NOT NULL,
  `hora` char(8) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcajareh`) USING BTREE,
  KEY `idcomproba` (`idcomproba`),
  KEY `idregicomp` (`idregicomp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cajarecaudah`
--

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
  PRIMARY KEY (`idestadosreg`),
  KEY `tabla` (`tabla`),
  KEY `campo` (`campo`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `estadosreg`
--

--
-- Definition of trigger `estadosreg_AFTER_INSERT`
--

DROP TRIGGER /*!50030 IF EXISTS */ `estadosreg_AFTER_INSERT`;

DELIMITER $$

CREATE DEFINER = `processaradmin`@`%` TRIGGER `estadosreg_AFTER_INSERT` AFTER INSERT ON `estadosreg` FOR EACH ROW BEGIN
	call p_ultimoestado(NEW.idestadosreg);
END $$

DELIMITER ;

--
-- Definition of procedure `p_creartablasr_`
--

DROP PROCEDURE IF EXISTS `p_creartablasr_`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_creartablasr_`()
BEGIN

   
   DROP TABLE IF EXISTS `r_facturasaldo`;
   CREATE TABLE `r_facturasaldo` AS SELECT * FROM facturasaldo ;
   ALTER TABLE  `r_facturasaldo` ADD PRIMARY KEY (`idfactura`);

   
   DROP TABLE IF EXISTS `r_facturasctasaldo`;
   CREATE TABLE `r_facturasctasaldo` AS SELECT * FROM facturasctasaldo ;
   ALTER TABLE  `r_facturasctasaldo` ADD PRIMARY KEY (`idcuotafc`),ADD INDEX `idfactura`(`idfactura`);

   
   DROP TABLE IF EXISTS `r_recibossaldo`;
   CREATE TABLE `r_recibossaldo` AS SELECT * FROM recibossaldo ;
   ALTER TABLE  `r_recibossaldo` ADD PRIMARY KEY (`idrecibo`);


   
   DROP TABLE IF EXISTS `r_factuprovesaldo`;
   CREATE TABLE `r_factuprovesaldo` AS SELECT * FROM factuprovesaldo ;
   ALTER TABLE  `r_factuprovesaldo` ADD PRIMARY KEY (`idfactprov`);

   
   DROP TABLE IF EXISTS `r_pagosprovsaldo`;
   CREATE TABLE `r_pagosprovsaldo` AS SELECT * FROM pagosprovsaldo ;
   ALTER TABLE  `r_pagosprovsaldo` ADD PRIMARY KEY (`idpago`);

   
   DROP TABLE IF EXISTS `r_articulostock`;
   CREATE TABLE `r_articulostock` AS SELECT * FROM articulostock ;
   ALTER TABLE  `r_articulostock` ADD INDEX `articulo`(`articulo`) ;


   
   DROP TABLE IF EXISTS `r_depostock`;
   CREATE TABLE `r_depostock` AS SELECT * FROM depostock ;
   ALTER TABLE  `r_depostock` ADD INDEX `deposito`(`deposito`), ADD INDEX `articulo`(`articulo`) ;


   DROP TABLE IF EXISTS `r_artpendiente`;
   CREATE TABLE `r_artpendiente` AS SELECT * FROM artpendiente ;



   DROP TABLE IF EXISTS `r_otpendientes`;
   CREATE TABLE `r_otpendientes` AS SELECT * FROM otpendientes ;
   ALTER TABLE  `r_otpendientes` ADD PRIMARY KEY (`idot`);


   DROP TABLE IF EXISTS `r_artocdpendiente`;
   CREATE TABLE `r_artocdpendiente` AS SELECT * FROM artocdpendiente ;


   DROP TABLE IF EXISTS `r_ocdpendientes`;
   CREATE TABLE `r_ocdpendientes` AS SELECT * FROM ocdpendientes ;
   ALTER TABLE  `r_ocdpendientes` ADD PRIMARY KEY (`idocd`);



   DROP TABLE IF EXISTS `r_bancosaldos`;
   CREATE TABLE `r_bancosaldos` AS SELECT * FROM bancosaldos ;
   ALTER TABLE  `r_bancosaldos` ADD PRIMARY KEY (`idcuenta`);


   DROP TABLE IF EXISTS `r_ultimoestado`;
   CREATE TABLE `r_ultimoestado` AS SELECT * FROM ultimoestado ;
   ALTER TABLE  `r_ultimoestado` ADD INDEX `tabla`(`tabla`),ADD INDEX `campo`(`campo`), ADD INDEX `id`(`id`), ADD INDEX `idestador`(`idestador`) ;


   DELETE FROM r_listaprea ;
   delete from r_listapreb ;
   delete from r_gruposall ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_ultimoestado`
--

DROP PROCEDURE IF EXISTS `p_ultimoestado`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_ultimoestado`(in pidestadosreg int )
BEGIN

    set @vtabla  	:= "" ;
    set @vcampo 	:= "" ;
    set @vid  		:= "" ;
    set @videstador := 0  ;
    set @vtipo      := "" ;
	set @vfechaest  := "" ;

    select `r`.`tabla` ,`r`.`campo` , `r`.`id` ,`r`.`idestador`, `r`.`tipo`,`r`.`fecha`  
    into   @vtabla, @vcampo, @vid, @videstador, @vtipo, @vfechaest
    from `estadosreg` `r`  
    where r.idestadosreg = pidestadosreg ;

    if isnull(@vtabla) <> true then
		delete from r_ultimoestado where tabla = @vtabla and id = @vid ;
		insert into r_ultimoestado values ( @vtabla, @vcampo, @vid, @videstador, @vtipo, @vfechaest);
    end if ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
