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
-- Definition of table `cumplimentaocd`
--

DROP TABLE IF EXISTS `cumplimentaocd`;
CREATE TABLE `cumplimentaocd` (
  `idcumpocd` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcumpoc` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `detalle` char(250) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  `cantidaduf` float(13,2) NOT NULL,
  `idocd` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcumpocd`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;



--
-- Definition of trigger `cumplimentaocd_AFTER_INSERT`
--

DROP TRIGGER /*!50030 IF EXISTS */ `cumplimentaocd_AFTER_INSERT`;

DELIMITER $$

CREATE DEFINER = `processaradmin`@`%` TRIGGER `cumplimentaocd_AFTER_INSERT` AFTER INSERT ON `cumplimentaocd` FOR EACH ROW BEGIN
	call p_ocdpendientes(NEW.idocd);
	call p_artocdpendiente(NEW.articulo);
END $$

DELIMITER ;

--
-- Definition of trigger `cumplimentaocd_AFTER_DELETE`
--

DROP TRIGGER /*!50030 IF EXISTS */ `cumplimentaocd_AFTER_DELETE`;

DELIMITER $$

CREATE DEFINER = `processaradmin`@`%` TRIGGER `cumplimentaocd_AFTER_DELETE` AFTER DELETE ON `cumplimentaocd` FOR EACH ROW BEGIN
	call p_ocdpendientes(OLD.idocd);
	call p_artocdpendiente(OLD.articulo);
END $$

DELIMITER ;

--
-- Definition of table `cumplimentaoc`
--

DROP TABLE IF EXISTS `cumplimentaoc`;
CREATE TABLE `cumplimentaoc` (
  `idcumpoc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `responsab` char(250) NOT NULL DEFAULT '',
  `observa1` char(250) NOT NULL,
  `observa2` char(250) NOT NULL,
  `observa3` char(250) NOT NULL,
  `observa4` char(250) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcumpoc`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;


--
-- Definition of table `oc`
--

DROP TABLE IF EXISTS `oc`;
CREATE TABLE `oc` (
  `idoc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `usuario` char(15) NOT NULL,
  `vendedor` int(10) unsigned NOT NULL,
  `transporte` int(10) unsigned NOT NULL,
  `nombretran` char(200) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `nombre` char(200) NOT NULL,
  `observa` char(200) NOT NULL,
  `idtiponp` int(10) unsigned NOT NULL,
  `fechaentre` char(8) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idoc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Definition of table `ocd`
--

DROP TABLE IF EXISTS `ocd`;
CREATE TABLE `ocd` (
  `idocd` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idoc` int(10) unsigned NOT NULL,
  `articulo` char(50) NOT NULL,
  `detalle` char(200) NOT NULL,
  `cantidad` double(13,2) DEFAULT NULL,
  `unidad` char(50) NOT NULL,
  `unitario` double(13,2) DEFAULT NULL,
  `observa` char(200) NOT NULL,
  `fechaentre` char(8) NOT NULL,
  `cantidadfc` double(13,2) DEFAULT NULL,
  `unidadfc` char(50) NOT NULL,
  `idmate` int(10) unsigned NOT NULL DEFAULT '0',
  `impuestos` double(13,2) DEFAULT NULL,
  `total` double(13,2) DEFAULT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `razonimp` double(13,2) DEFAULT NULL,
  `neto` double(13,2) DEFAULT NULL,
  `idtiponp` int(10) unsigned NOT NULL DEFAULT '0',
  `imprimir` char(1) NOT NULL DEFAULT 'S',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idocd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Definition of trigger `ocd_AFTER_INSERT`
--

DROP TRIGGER /*!50030 IF EXISTS */ `ot_AFTER_INSERT`;

DELIMITER $$

CREATE DEFINER = `processaradmin`@`%` TRIGGER `ocd_AFTER_INSERT` AFTER INSERT ON `ocd` FOR EACH ROW BEGIN
	call p_ocdpendientes(NEW.idocd);
	call p_artocdpendiente(NEW.articulo);
END $$

DELIMITER ;

--
-- Definition of trigger `ocd_AFTER_DELETE`
--

DROP TRIGGER /*!50030 IF EXISTS */ `ocd_AFTER_DELETE`;

DELIMITER $$

CREATE DEFINER = `processaradmin`@`%` TRIGGER `ocd_AFTER_DELETE` AFTER DELETE ON `ocd` FOR EACH ROW BEGIN
	call p_ocdpendientes(OLD.idocd);
	call p_artocdpendiente(OLD.articulo);
END $$

DELIMITER ;




--
-- Temporary table structure for view `artocdpendiente`
--
DROP TABLE IF EXISTS `artocdpendiente`;
DROP VIEW IF EXISTS `artocdpendiente`;
CREATE TABLE `artocdpendiente` (
  `articulo` char(50),
  `idmate` int(10) unsigned,
  `cantidad` double(19,2),
  `cantcump` double(19,2),
  `pendiente` double(19,2)
);

--
-- Temporary table structure for view `ocdpendientes`
--
DROP TABLE IF EXISTS `ocdpendientes`;
DROP VIEW IF EXISTS `ocdpendientes`;
CREATE TABLE `ocdpendientes` (
  `idocd` int(10) unsigned,
  `articulo` char(50),
  `idmate` int(10) unsigned,
  `cantidad` double(13,2),
  `cantcump` double(19,2),
  `pendiente` double(19,2)
);

--
-- Definition of procedure `p_artocdpendiente`
--

DROP PROCEDURE IF EXISTS `p_artocdpendiente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_artocdpendiente`(in particulo char(50))
BEGIN
    set @vcantidad    := 0.00 ;
    set @vcantcump    := 0.00 ;
    set @vpendiente   := 0.00 ;
    set @vidmate      := 0 ;


    select `o`.`idmate`, sum(`o`.`cantidad`), sum(`o`.`cantcump`), sum(`o`.`pendiente`) into @vidmate, @vcantidad, @vcantcump, @vpendiente
    from `r_ocdpendientes` `o` where  `o`.`articulo` = particulo and `o`.`idmate` = 0;

   delete from r_artocdpendiente where articulo = particulo  and idmate = 0;
   if isnull(@vcantidad) <> true then
      delete from r_artocdpendiente where articulo = particulo  and idmate = 0;
      insert into r_artocdpendiente values (particulo, 0 , @vcantidad, @vcantcump, @vpendiente);
    end if ;


    select `o`.`idmate`, sum(`o`.`cantidad`), sum(`o`.`cantcump`), sum(`o`.`pendiente`) into @vidmate, @vcantidad, @vcantcump, @vpendiente
    from `r_ocdpendientes` `o` where  `o`.`articulo` = particulo and `o`.`idmate` > 0 ;


    delete from r_artocdpendiente where articulo = particulo  and idmate > 0;
    if isnull(@vidmate) <> true then
      insert into r_artocdpendiente values (particulo, @vidmate , @vcantidad, @vcantcump, @vpendiente);
    end if ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_otpendientes`
--

DROP PROCEDURE IF EXISTS `p_ocdpendientes`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_ocdpendientes`(in pidocd int)
BEGIN

    set @varticulo    := ' ' ;
    set @vcantidad    := 0.00 ;
    set @vcantcump    := 0.00 ;
    set @vpendiente   := 0.00 ;
    set @vidmate      := 0;

    select `o`.`articulo`,`o`.`idmate` ,`o`.`cantidad` ,sum(ifnull(`h`.`cantidad`,0.00)), (`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00)))
    into @varticulo, @vidmate, @vcantidad, @vcantcump, @vpendiente
    from (`ocd` `o` left join `cumplimentaocd` `h` on((`o`.`idocd` = `h`.`idocd`))) where `o`.`idocd` = pidocd ;


    delete from r_ocdpendientes where idocd = pidocd ;
    if @vcantidad <> 0 then
        insert into r_ocdpendientes values (pidocd, @varticulo, @vidmate, @vcantidad, @vcantcump, @vpendiente);
    end if ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `artocdpendiente`
--

DROP TABLE IF EXISTS `artocdpendiente`;
DROP VIEW IF EXISTS `artocdpendiente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `artocdpendiente` AS select `ocdpendientes`.`articulo` AS `articulo`,`ocdpendientes`.`idmate` AS `idmate`,sum(`ocdpendientes`.`cantidad`) AS `cantidad`,sum(`ocdpendientes`.`cantcump`) AS `cantcump`,sum(`ocdpendientes`.`pendiente`) AS `pendiente` from `ocdpendientes` group by `ocdpendientes`.`articulo`,`ocdpendientes`.`idmate`;

--
-- Definition of view `ocdpendientes`
--

DROP TABLE IF EXISTS `ocdpendientes`;
DROP VIEW IF EXISTS `ocdpendientes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `ocdpendientes` AS select `o`.`idocd` AS `idocd`,`o`.`articulo` AS `articulo`,`o`.`idmate` AS `idmate`,`o`.`cantidad` AS `cantidad`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantcump`,(`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendiente` from (`ocd` `o` left join `cumplimentaocd` `h` on((`o`.`idocd` = `h`.`idocd`))) group by `o`.`idocd`;



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
   ALTER TABLE  `r_facturasctasaldo` ADD PRIMARY KEY (`idcuotafc`);

   
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

   DELETE FROM r_listaprea ;
   delete from r_listapreb ;

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
