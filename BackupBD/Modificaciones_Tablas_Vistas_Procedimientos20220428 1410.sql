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
-- Create schema processard
--

CREATE DATABASE IF NOT EXISTS processard;
USE processard;

--
-- Temporary table structure for view `artpendiente`
--
DROP TABLE IF EXISTS `artpendiente`;
DROP VIEW IF EXISTS `artpendiente`;
CREATE TABLE `artpendiente` (
  `articulo` char(50),
  `idmate` int(10) unsigned,
  `cantidad` double(19,2),
  `cantcump` double(19,2),
  `pendiente` double(19,2)
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
  `stocktot` double(19,2),
  `stock` double(19,2),
  `stockmin` double(13,2),
  `pendiente` double(19,2)
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
  `horas` char(1),
  `pendiente` double(19,2)
);

--
-- Temporary table structure for view `otpendientes`
--
DROP TABLE IF EXISTS `otpendientes`;
DROP VIEW IF EXISTS `otpendientes`;
CREATE TABLE `otpendientes` (
  `idot` int(10) unsigned,
  `articulo` char(50),
  `idmate` int(10) unsigned,
  `cantidad` double(13,2),
  `cantcump` double(19,2),
  `pendiente` double(19,2)
);

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
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaentre` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`idnp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `np`
--

/*!40000 ALTER TABLE `np` DISABLE KEYS */;
INSERT INTO `np` (`idnp`,`puntov`,`numero`,`fecha`,`hora`,`usuario`,`vendedor`,`transporte`,`nombretran`,`entidad`,`nombre`,`observa`,`sector`,`idtiponp`,`idcomproba`,`pventa`,`timestamp`,`fechaentre`) VALUES 
 (36,'0005',38,'20220428','13:00:36','TULIO',0,0,'',2,'ACOSTA DARIO','',0,2,16,1,'2022-04-27 12:15:58','20220428');
/*!40000 ALTER TABLE `np` ENABLE KEYS */;


--
-- Definition of table `observacomp`
--

DROP TABLE IF EXISTS `observacomp`;
CREATE TABLE `observacomp` (
  `idobscomp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tabla` char(100) NOT NULL,
  `observa` char(250) NOT NULL,
  `detalle` char(250) NOT NULL,
  `detalletxt` text NOT NULL,
  PRIMARY KEY (`idobscomp`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `observacomp`
--

/*!40000 ALTER TABLE `observacomp` DISABLE KEYS */;
INSERT INTO `observacomp` (`idobscomp`,`tabla`,`observa`,`detalle`,`detalletxt`) VALUES 
 (1,'facturas','El credito fiscal discriminado en el presente comprobante, solo podra ser computado a efectos del Regimen de Sostenimiento e Inclusion Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618','Filtro Monotributista FACTURA A',''),
 (2,'facturas','El credito fiscal discriminado en el presente comprobante, solo podra ser computado a efectos del Regimen de Sostenimiento e Inclusion Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618','Filtro Monotributista NOTA DEBITO A',''),
 (3,'facturas','El credito fiscal discriminado en el presente comprobante, solo podra ser computado a efectos del Regimen de Sostenimiento e Inclusion Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618','Filtro Monotributista NOTA CREDITO A',''),
 (4,'pagares','','Texto Predeterminado Pagare','PAGARE/MOS SIN PROTESTO (Art. 50 D Ley 5965/63 ) A Sr. Livio Jose Krumbein LA CANTIDAD DE  [>$$<] por igual valor en MERCADERIA segun Factura/s: [>FF<]a mi entera satisfaccion pagadero en 9 de Julio 14662, Margarita.\r\nConveniendose \r\n1) Exepciones : En caso de ejecucion judicial solo se podrá oponer la de pago documentado y renucia/n el/los libradores, endosantes y avalista/s a apelar el fallo en segunda instancia.\r\n2) Jurisdiccion : Las partes se someten a la jurisdicción de los tribunales ordinarios de la ciudad de Vera facultándose al beneficiario a designar martillero en caso de subasta judicial.\r\n3) Prescripcion: Se extiende el plazo de prescripcion del presente hasta 5 años contados a partir de la fecha de vencimiento.\r\n4) La falta de pago en termino acordado devengara un Interes 5% mensual.\r\n5) Recusacion en caso de iniciarse juicio ejecutivo renuncio/amos a recusar sin causa el juez interviniente.\r\n\r\n\r\n\r\n\r\n\r\n\r\nFIRMANTE: [>II<]\r\nDOC.NRO  : [>DD<]\r\nDIRECCION:[>RR<]\r\n\r\n\r\n\r\n\r\nFIRMA:.........................................................................');
/*!40000 ALTER TABLE `observacomp` ENABLE KEYS */;


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
  `cantidad` double(13,2) DEFAULT NULL,
  `unidad` char(50) NOT NULL,
  `unitario` double(13,2) DEFAULT NULL,
  `observa` char(254) NOT NULL,
  `fechaentre` char(8) NOT NULL,
  `cantidadfc` double(13,2) DEFAULT NULL,
  `unidadfc` char(50) NOT NULL,
  `idmate` int(10) unsigned NOT NULL DEFAULT '0',
  `impuestos` double(13,2) DEFAULT NULL,
  `total` double(13,2) DEFAULT NULL,
  `impuesto` int(10) unsigned NOT NULL,
  `razonimp` double(13,2) DEFAULT NULL,
  `neto` double(13,2) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idtiponp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ot`
--

/*!40000 ALTER TABLE `ot` DISABLE KEYS */;
INSERT INTO `ot` (`idnp`,`idot`,`idtipoot`,`articulo`,`detalle`,`cantidad`,`unidad`,`unitario`,`observa`,`fechaentre`,`cantidadfc`,`unidadfc`,`idmate`,`impuestos`,`total`,`impuesto`,`razonimp`,`neto`,`timestamp`,`idtiponp`) VALUES 
 (36,46,1,'01','PRUEBA',12.00,'UNIDAD',10.00,'','20220428',0.00,'',1,0.00,120.00,0,0.00,120.00,'2022-04-27 12:15:58',2);
/*!40000 ALTER TABLE `ot` ENABLE KEYS */;


--
-- Definition of trigger `ot_AFTER_INSERT`
--

DROP TRIGGER /*!50030 IF EXISTS */ `ot_AFTER_INSERT`;

DELIMITER $$

CREATE DEFINER = `tulior`@`%` TRIGGER `ot_AFTER_INSERT` AFTER INSERT ON `ot` FOR EACH ROW BEGIN
	call p_otpendientes(NEW.idot);
	call p_artpendiente(NEW.articulo);
END $$

DELIMITER ;

--
-- Definition of trigger `ot_AFTER_DELETE`
--

DROP TRIGGER /*!50030 IF EXISTS */ `ot_AFTER_DELETE`;

DELIMITER $$

CREATE DEFINER = `tulior`@`%` TRIGGER `ot_AFTER_DELETE` AFTER DELETE ON `ot` FOR EACH ROW BEGIN
	call p_otpendientes(OLD.idot);
	call p_artpendiente(OLD.articulo);
END $$

DELIMITER ;

--
-- Definition of table `pagares`
--

DROP TABLE IF EXISTS `pagares`;
CREATE TABLE `pagares` (
  `idpagare` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `nombre` char(200) NOT NULL,
  `detalle` text NOT NULL,
  `importe` double(13,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idpagare`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pagares`
--

/*!40000 ALTER TABLE `pagares` DISABLE KEYS */;
INSERT INTO `pagares` (`idpagare`,`idcomproba`,`pventa`,`numero`,`fecha`,`entidad`,`nombre`,`detalle`,`importe`,`timestamp`) VALUES 
 (1,45,1,3,'20220424',12,'ALVARENGA PEDRO ALEJANDRO','PAGARE/MOS SIN PROTESTO (Art. 50 D Ley 5965/63 ) A Sr. Livio José Krumbein LA CANTIDAD DE PESOS #$# por igual valor en MERCADERIA según Factura/s: #FC# a mi entera satisfacción pagadero en 9 de Julio 14662, Margarita.\r\nConveniendose \r\n1) Exepciones : En caso de ejecución judicial solo se podrá oponer la de pago documentado y renucia/n el/los libradores, endosantes y avalista/s a apelar el fallo en segunda instancia.\r\n2) Jurisdicción : Las partes se someten a la jurisdicción de los tribunales ordinarios de la ciudad de Vera facultándose al beneficiario a designar martillero en caso de subasta judicial.\r\n3) Prescripción: Se extiende el plazo de prescripción del presente hasta 5 años contados a partir de la fecha de vencimiento.\r\n4) La falta de pago en término acordado devengará un Interes 5% mensual.\r\n5) Recusación en caso de iniciarse juicio ejecutivo renuncio/amos a recusar sin causa el juez interviniente.\r\n\r\n\r\n\r\n\r\n\r\n\r\nFIRMANTE: #FM#\r\nDOC.NRO  : #DC#\r\nDIRECCION:#DI#\r\nLOCALIDAD: #LO#\r\n\r\n\r\n\r\n\r\nFIRMA:.........................................................................',1550.67,'2022-04-24 02:30:20'),
 (2,45,1,4,'20220424',12,'ALVARENGA PEDRO ALEJANDRO','PAGARE/MOS SIN PROTESTO (Art. 50 D Ley 5965/63 ) A Sr. Livio José Krumbein LA CANTIDAD DE PESOS #$# por igual valor en MERCADERIA según Factura/s: #FC# a mi entera satisfacción pagadero en 9 de Julio 14662, Margarita.\r\nConveniendose \r\n1) Exepciones : En caso de ejecución judicial solo se podrá oponer la de pago documentado y renucia/n el/los libradores, endosantes y avalista/s a apelar el fallo en segunda instancia.\r\n2) Jurisdicción : Las partes se someten a la jurisdicción de los tribunales ordinarios de la ciudad de Vera facultándose al beneficiario a designar martillero en caso de subasta judicial.\r\n3) Prescripción: Se extiende el plazo de prescripción del presente hasta 5 años contados a partir de la fecha de vencimiento.\r\n4) La falta de pago en término acordado devengará un Interes 5% mensual.\r\n5) Recusación en caso de iniciarse juicio ejecutivo renuncio/amos a recusar sin causa el juez interviniente.\r\n\r\n\r\n\r\n\r\n\r\n\r\nFIRMANTE: #FM#\r\nDOC.NRO  : #DC#\r\nDIRECCION:#DI#\r\nLOCALIDAD: #LO#\r\n\r\n\r\n\r\n\r\nFIRMA:.........................................................................',1550.67,'2022-04-24 02:34:14'),
 (3,45,1,5,'20220424',407,'ECEIZA JOSE LUIS','PAGARE/MOS SIN PROTESTO (Art. 50 D Ley 5965/63 ) A Sr. Livio José Krumbein LA CANTIDAD DE PESOS  6481.08  por igual valor en MERCADERIA según Factura/s:  \rFACTURA B  B  0005-00000719  20/08/2021   $     5931.07   407-ECEIZA JOSE LUIS\rFACTURA A  A  0005-00000005  19/05/2021   $      160.01   366-COOP. ELECTRICA Y O.S.P DE MARGARITA LTDA \rFACTURA A  A  0005-00000009  01/06/2021   $      390.00   257-POGLIANI RUBEN ORLANDO\r  a mi entera satisfacción pagadero en 9 de Julio 14662, Margarita.\r\nConveniendose \r\n1) Exepciones : En caso de ejecución judicial solo se podrá oponer la de pago documentado y renucia/n el/los libradores, endosantes y avalista/s a apelar el fallo en segunda instancia.\r\n2) Jurisdicción : Las partes se someten a la jurisdicción de los tribunales ordinarios de la ciudad de Vera facultándose al beneficiario a designar martillero en caso de subasta judicial.\r\n3) Prescripción: Se extiende el plazo de prescripción del presente hasta 5 años contados a partir de la fecha de vencimiento.\r\n4) La falta de pago en término acordado devengará un Interes 5% mensual.\r\n5) Recusación en caso de iniciarse juicio ejecutivo renuncio/amos a recusar sin causa el juez interviniente.\r\n\r\n\r\n\r\n\r\n\r\n\r\nFIRMANTE:  ECEIZA JOSE LUIS \r\nDOC.NRO  :  23100637979 \r\nDIRECCION: BELGRANO 1561 - MARGARITA \r\n\r\n\r\n\r\n\r\nFIRMA:.........................................................................',6481.08,'2022-04-24 22:34:48'),
 (4,45,1,6,'20220425',282,'ROSSI TULIO','PAGARE/MOS SIN PROTESTO (Art. 50 D Ley 5965/63 ) A Sr. Livio Jose Krumbein LA CANTIDAD DE NUEVE MIL CIENTO CINCUENTA Y CUATRO PESOS CON CINCUENTA Y SEIS CENTAVOS  por igual valor en MERCADERIA segun Factura/s:  \r\nFACTURA B  B  0005-00000790  04/09/2021   $     9154.56   282-ROSSI TULIO\r\n  a mi entera satisfaccion pagadero en 9 de Julio 14662, Margarita.\r\nConveniendose \r\n1) Exepciones : En caso de ejecucion judicial solo se podrá oponer la de pago documentado y renucia/n el/los libradores, endosantes y avalista/s a apelar el fallo en segunda instancia.\r\n2) Jurisdiccion : Las partes se someten a la jurisdicción de los tribunales ordinarios de la ciudad de Vera facultándose al beneficiario a designar martillero en caso de subasta judicial.\r\n3) Prescripcion: Se extiende el plazo de prescripcion del presente hasta 5 años contados a partir de la fecha de vencimiento.\r\n4) La falta de pago en termino acordado devengara un Interes 5% mensual.\r\n5) Recusacion en caso de iniciarse juicio ejecutivo renuncio/amos a recusar sin causa el juez interviniente.\r\n\r\n\r\n\r\n\r\n\r\n\r\nFIRMANTE:  ROSSI TULIO \r\nDOC.NRO  :  20221414978 \r\nDIRECCION: ZONA URBANA - MARGARITA \r\n\r\n\r\n\r\n\r\nFIRMA:.........................................................................',9154.56,'2022-04-25 14:06:50'),
 (5,45,1,7,'20220425',1468,'TREVISAN ROBERTO','PAGARE/MOS SIN PROTESTO (Art. 50 D Ley 5965/63 ) A Sr. Livio Jose Krumbein LA CANTIDAD DE   MIL SETECIENTOS NOVENTA Y CUATRO PESOS CON NOVENTA Y SEIS CENTAVOS  por igual valor en MERCADERIA segun Factura/s:  \rFACTURA A  A  0005-00000003  17/05/2021   $     1794.96   1468-TREVISAN ROBERTO\r a mi entera satisfaccion pagadero en 9 de Julio 14662, Margarita.\r\nConveniendose \r\n1) Exepciones : En caso de ejecucion judicial solo se podrá oponer la de pago documentado y renucia/n el/los libradores, endosantes y avalista/s a apelar el fallo en segunda instancia.\r\n2) Jurisdiccion : Las partes se someten a la jurisdicción de los tribunales ordinarios de la ciudad de Vera facultándose al beneficiario a designar martillero en caso de subasta judicial.\r\n3) Prescripcion: Se extiende el plazo de prescripcion del presente hasta 5 años contados a partir de la fecha de vencimiento.\r\n4) La falta de pago en termino acordado devengara un Interes 5% mensual.\r\n5) Recusacion en caso de iniciarse juicio ejecutivo renuncio/amos a recusar sin causa el juez interviniente.\r\n\r\n\r\n\r\n\r\n\r\n\r\nFIRMANTE:  TREVISAN ROBERTO \r\nDOC.NRO  :  20110959428 \r\nDIRECCION: ZONA RURAL - MARGARITA \r\n\r\n\r\n\r\n\r\nFIRMA:.........................................................................',1794.96,'2022-04-25 15:09:11');
/*!40000 ALTER TABLE `pagares` ENABLE KEYS */;


--
-- Definition of procedure `p_artpendiente`
--

DROP PROCEDURE IF EXISTS `p_artpendiente`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_artpendiente`(in particulo char(50))
BEGIN
    set @vcantidad    := 0.00 ;
    set @vcantcump    := 0.00 ;
    set @vpendiente   := 0.00 ;
    set @vidmate      := 0 ;

-- Calculo pendientes para articulos
    select `o`.`idmate`, sum(`o`.`cantidad`), sum(`o`.`cantcump`), sum(`o`.`pendiente`) into @vidmate, @vcantidad, @vcantcump, @vpendiente
    from `r_otpendientes` `o` where  `o`.`articulo` = particulo and `o`.`idmate` = 0;

   if @vidmate = 0 or isnull(@vidmate) = true  then
     update r_depostock set pendiente = @vpendiente where articulo = particulo ;
   end if;
   delete from r_artpendiente where articulo = particulo  and idmate = 0;
   if isnull(@vcantidad) <> true then
      delete from r_artpendiente where articulo = particulo  and idmate = 0;
      insert into r_artpendiente values (particulo, 0 , @vcantidad, @vcantcump, @vpendiente);
    end if ;

-- Calculo pendientes para materiales

    select `o`.`idmate`, sum(`o`.`cantidad`), sum(`o`.`cantcump`), sum(`o`.`pendiente`) into @vidmate, @vcantidad, @vcantcump, @vpendiente
    from `r_otpendientes` `o` where  `o`.`articulo` = particulo and `o`.`idmate` > 0 ;


    delete from r_artpendiente where articulo = particulo  and idmate > 0;
    if isnull(@vidmate) <> true then
      insert into r_artpendiente values (particulo, @vidmate , @vcantidad, @vcantcump, @vpendiente);
    end if ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_creartablasr_`
--

DROP PROCEDURE IF EXISTS `p_creartablasr_`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_creartablasr_`()
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
  -- ALTER TABLE  `r_articulostock` ADD PRIMARY KEY (`articulo`);

   
   DROP TABLE IF EXISTS `r_depostock`;
   CREATE TABLE `r_depostock` AS SELECT * FROM depostock ;
   ALTER TABLE  `r_depostock` ADD INDEX `deposito`(`deposito`), ADD INDEX `articulo`(`articulo`) ;

   
   DROP TABLE IF EXISTS `r_artpendiente`;
   CREATE TABLE `r_artpendiente` AS SELECT * FROM artpendiente ;
  -- ALTER TABLE  `r_artpendiente` ADD PRIMARY KEY (`articulo`);

   
   DROP TABLE IF EXISTS `r_otpendientes`;
   CREATE TABLE `r_otpendientes` AS SELECT * FROM otpendientes ;
   ALTER TABLE  `r_otpendientes` ADD PRIMARY KEY (`idot`);

   
   DROP TABLE IF EXISTS `r_bancosaldos`;
   CREATE TABLE `r_bancosaldos` AS SELECT * FROM bancosaldos ;
   ALTER TABLE  `r_bancosaldos` ADD PRIMARY KEY (`idcuenta`);

   DELETE FROM r_listaprea ;
   delete from r_listapreb ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_depostock`
--

DROP PROCEDURE IF EXISTS `p_depostock`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_depostock`(in pdeposito int, in particulo char(50))
BEGIN

    set @vnombreart  := ' ' ;
    set @vstocktot   := 0.00 ;
    set @vstock      := 0.00 ;
    set @vstockmin   := 0.00 ;
    set @vpendiente  := 0.00 ;


    select `m`.`detalle` ,ifnull(`u`.`stocktot`,0) , sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `a`.`cantidad`)) ,`m`.`stockmin`, ifnull(`p`.`pendiente`,0)
    into @vnombreart, @vstocktot, @vstock, @vstockmin, @vpendiente
    from ((((`ajustestockh` `a` left join `tipomstock` `t` on((`a`.`idtipomov` = `t`.`idtipomov`)))
    left join `articulos` `m` on((`a`.`articulo` = `m`.`articulo`))) left join `r_articulostock` `u` on((`a`.`articulo` = `u`.`articulo`)))
    left join `r_artpendiente` `p` on((`a`.`articulo` = `p`.`articulo` and `p`.`idmate` = 0)))
    where `a`.`deposito` = pdeposito and `a`.`articulo`= particulo and (not(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a`
    where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;


     delete from r_depostock where deposito = pdeposito and articulo = particulo;
     insert into r_depostock values (pdeposito, particulo, @vnombreart, @vstocktot, @vstock, @vstockmin, @vpendiente ) ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_otpendientes`
--

DROP PROCEDURE IF EXISTS `p_otpendientes`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_otpendientes`(in pidot int)
BEGIN

    set @varticulo    := ' ' ;
    set @vcantidad    := 0.00 ;
    set @vcantcump    := 0.00 ;
    set @vpendiente   := 0.00 ;
    set @vidmate      := 0;

    select `o`.`articulo`,`o`.`idmate` ,`o`.`cantidad` ,sum(ifnull(`h`.`cantidad`,0.00)), (`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00)))
    into @varticulo, @vidmate, @vcantidad, @vcantcump, @vpendiente
    from (`ot` `o` left join `cumplimentah` `h` on((`o`.`idot` = `h`.`idot`))) where `o`.`idot` = pidot ;


    delete from r_otpendientes where idot = pidot ;
    if @vcantidad <> 0 then
        insert into r_otpendientes values (pidot, @varticulo, @vidmate, @vcantidad, @vcantcump, @vpendiente);
    end if ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `artpendiente`
--

DROP TABLE IF EXISTS `artpendiente`;
DROP VIEW IF EXISTS `artpendiente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `artpendiente` AS select `otpendientes`.`articulo` AS `articulo`,`otpendientes`.`idmate` AS `idmate`,sum(`otpendientes`.`cantidad`) AS `cantidad`,sum(`otpendientes`.`cantcump`) AS `cantcump`,sum(`otpendientes`.`pendiente`) AS `pendiente` from `otpendientes` group by `otpendientes`.`articulo`,`otpendientes`.`idmate`;

--
-- Definition of view `depostock`
--

DROP TABLE IF EXISTS `depostock`;
DROP VIEW IF EXISTS `depostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stocktot`,0) AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `a`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin`,ifnull(`p`.`pendiente`,0) AS `pendiente` from ((((`ajustestockh` `a` left join `tipomstock` `t` on((`a`.`idtipomov` = `t`.`idtipomov`))) left join `articulos` `m` on((`a`.`articulo` = `m`.`articulo`))) left join `articulostock` `u` on((`a`.`articulo` = `u`.`articulo`))) left join `artpendiente` `p` on(((convert(`a`.`articulo` using utf8) = convert(`p`.`articulo` using utf8)) and (`p`.`idmate` = 0)))) where (not(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;

--
-- Definition of view `otdepostock`
--

DROP TABLE IF EXISTS `otdepostock`;
DROP VIEW IF EXISTS `otdepostock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otdepostock` AS select `o`.`iddepo` AS `iddepo`,`o`.`idmate` AS `idmate`,`o`.`codigomat` AS `codigomat`,`m`.`detalle` AS `nombremat`,`u`.`stocktot` AS `stocktot`,sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `o`.`cantidad`)) AS `stock`,`m`.`stockmin` AS `stockmin`,`v`.`stock` AS `constock`,`v`.`horas` AS `horas`,ifnull(`p`.`pendiente`,0) AS `pendiente` from (((((`otmovistockh` `o` left join `tipomstock` `t` on((`o`.`idtipomov` = `t`.`idtipomov`))) left join `otmateriales` `m` on((`o`.`idmate` = `m`.`idmate`))) left join `otmatestock` `u` on((`o`.`idmate` = `u`.`idmate`))) left join `tipomaterial` `v` on((`m`.`idtipomate` = `v`.`idtipomate`))) left join `artpendiente` `p` on((`p`.`idmate` = `o`.`idmate`))) where (not(`o`.`idmovip` in (select `otmovianul`.`idmovip` from `otmovianul`))) group by `o`.`iddepo`,`o`.`idmate`;

--
-- Definition of view `otpendientes`
--

DROP TABLE IF EXISTS `otpendientes`;
DROP VIEW IF EXISTS `otpendientes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otpendientes` AS select `o`.`idot` AS `idot`,`o`.`articulo` AS `articulo`,`o`.`idmate` AS `idmate`,`o`.`cantidad` AS `cantidad`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantcump`,(`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendiente` from (`ot` `o` left join `cumplimentah` `h` on((`o`.`idot` = `h`.`idot`))) group by `o`.`idot`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
