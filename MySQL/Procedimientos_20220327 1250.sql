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
-- Definition of table `r_listaprea`
--

DROP TABLE IF EXISTS `r_listaprea`;
CREATE TABLE `r_listaprea` (
  `idlista` int(10) unsigned NOT NULL,
  `detallep` char(200) NOT NULL,
  `vigedesde` char(8) NOT NULL,
  `vigehasta` char(8) NOT NULL,
  `margenp` double(13,2) NOT NULL,
  `condvta` int(10) unsigned NOT NULL,
  `idlistap` int(10) unsigned NOT NULL,
  `actualiza` char(16) NOT NULL,
  `idlistah` int(10) unsigned NOT NULL,
  `articulo` char(20) NOT NULL,
  `detalle` char(200) NOT NULL,
  `unidad` char(8) NOT NULL,
  `abrevia` char(6) NOT NULL,
  `codbarra` char(20) NOT NULL,
  `costoa` double(13,2) NOT NULL,
  `linea` char(20) NOT NULL,
  `detalinea` char(50) NOT NULL,
  `idsublinea` int(10) unsigned NOT NULL,
  `sublinea` char(150) NOT NULL,
  `ctrlstock` char(1) NOT NULL,
  `ocultar` char(1) NOT NULL,
  `stockmin` double(13,2) NOT NULL,
  `stocktot` double(13,2) NOT NULL,
  `desc1` double(13,2) NOT NULL,
  `desc2` double(13,2) NOT NULL,
  `desc3` double(13,2) NOT NULL,
  `desc4` double(13,2) NOT NULL,
  `desc5` double(13,2) NOT NULL,
  `moneda` int(10) unsigned NOT NULL,
  `pcosto` double(13,2) NOT NULL,
  `margen` double(13,2) NOT NULL,
  `pventa` double(13,2) NOT NULL,
  `razonimpu` double(13,2) NOT NULL,
  `impuestos` double(13,2) NOT NULL,
  `pventatot` double(13,2) NOT NULL,
  `fechaact` char(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



--
-- Definition of table `r_listapreb`
--

DROP TABLE IF EXISTS `r_listapreb`;
CREATE TABLE `r_listapreb` (
  `idlistac` int(10) unsigned NOT NULL,
  `idlista` int(10) unsigned NOT NULL,
  `detalle` char(200) NOT NULL,
  `cuotas` int(10) unsigned NOT NULL,
  `razon` double(13,2) NOT NULL,
  `idfinancia` int(10) unsigned NOT NULL,
  `habilitado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Definition of procedure `p_articulostock`
--

DROP PROCEDURE IF EXISTS `p_articulostock`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_articulostock`(in particulo char(50))
BEGIN
    set @vstocktot  := 0.00 ;

     select sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `h`.`cantidad`)) into @vstocktot
     from (`ajustestockh` `h` left join `tipomstock` `t` on((`h`.`idtipomov` = `t`.`idtipomov`)))
     where h.articulo = particulo and (not(`h`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a`
     where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) ;

     delete from r_articulostock where articulo = particulo ;

     insert into r_articulostock values (particulo,@vstocktot) ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

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

    select sum(`o`.`cantidad`), sum(`o`.`cantcump`), sum(`o`.`pendiente`) into @vcantidad, @vcantcump, @vpendiente
    from `r_otpendientes` `o` where  `o`.`articulo` = particulo ;

    delete from r_artpendiente where articulo = particulo ;
    insert into r_artpendiente values (particulo, @vcantidad, @vcantcump, @vpendiente);

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_bancosaldos`
--

DROP PROCEDURE IF EXISTS `p_bancosaldos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_bancosaldos`(in pidcuenta int)
BEGIN

    set @vcodcuenta   := ' ' ;
    set @vdetalle     := ' ' ;
    set @vcuentabco   := ' ' ;
    set @vidtipocta   := 0   ;
    set @vidbanco     := 0   ;
    set @vcbu         := ' ' ;
    set @vplcaja      := ' ' ;
    set @vcheques     := ' ' ;
    set @vcbancaria   := ' ' ;
    set @vbanco       := 0   ;
    set @vnombre      := ' ' ;
    set @vfilial      := 0   ;
    set @vcp          := ' ' ;
    set @vingresos    := 0.00;
    set @vegresos     := 0.00;
    set @vsaldo       := 0.00;

    # ingresos

    select `c`.`codcuenta` ,`c`.`detalle` ,`c`.`cuentabco`, `c`.`idtipocta`, `c`.`idbanco`, `c`.`cbu`, `c`.`plcaja`, `c`.`cheques`,
    `c`.`cbancaria`,`b`.`banco`, `b`.`nombre`, `b`.`filial`, `b`.`cp`, sum(ifnull(`d`.`importe`,0))
    into @vcodcuenta, @vdetalle,@vcuentabco, @vidtipocta,@vidbanco,@vcbu, @vplcaja, @vcheques, @vcbancaria, @vbanco, @vnombre, @vfilial, @vcp, @vingresos
    from `cajabancos` `c`
    left join `bancos` `b` on`b`.`idbanco` = `c`.`idbanco`
    left join `detallecobros` `d` on `c`.`idcuenta` = `d`.`idcuenta`
    left join `comprobantes` `cd` on `cd`.`idcomproba` = `d`.`idcomproba`
    left join `ultimoestado` `u` on (`u`.`id` = `d`.`idregistro` and convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))
    where `c`.`idcuenta`= pidcuenta and  (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp') ;


    # egresos

    select sum(ifnull(`d`.`importe`,0)) into @vegresos
    from `cajabancos` `c`
    left join `detallepagos` `d` on `c`.`idcuenta` = `d`.`idcuenta`
    left join `comprobantes` `cd` on `cd`.`idcomproba` = `d`.`idcomproba`
    left join `ultimoestado` `u` on (`u`.`id` = `d`.`idregistro` and convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))
    where `c`.`idcuenta`= pidcuenta and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp') ;

    if @vingresos = null then 
	   @vingresos := 0 ;
	end if ;

    if @vegresos = null then 
	   @vegresos := 0 ;
	end if ;
	
	set @vsaldo := ( @vingresos - @vegresos ) ;


    delete from r_bancosaldos where idcuenta = pidcuenta ;

    insert into r_bancosaldos values (pidcuenta, @vcodcuenta, @vdetalle,@vcuentabco, @vidtipocta,@vidbanco,@vcbu, @vplcaja, @vcheques, @vcbancaria, @vbanco, @vnombre, @vfilial, @vcp, @vsaldo);


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

   # r_facturasaldo
   DROP TABLE IF EXISTS `r_facturasaldo`;
   CREATE TABLE `r_facturasaldo` AS SELECT * FROM facturasaldo ;
   ALTER TABLE  `r_facturasaldo` ADD PRIMARY KEY (`idfactura`);

   # r_facturactasaldo
   DROP TABLE IF EXISTS `r_facturasctasaldo`;
   CREATE TABLE `r_facturasctasaldo` AS SELECT * FROM facturasctasaldo ;
   ALTER TABLE  `r_facturasctasaldo` ADD PRIMARY KEY (`idcuotafc`);

   # r_recibossaldo
   DROP TABLE IF EXISTS `r_recibossaldo`;
   CREATE TABLE `r_recibossaldo` AS SELECT * FROM recibossaldo ;
   ALTER TABLE  `r_recibossaldo` ADD PRIMARY KEY (`idrecibo`);


   # r_factuprovesaldo
   DROP TABLE IF EXISTS `r_factuprovesaldo`;
   CREATE TABLE `r_factuprovesaldo` AS SELECT * FROM factuprovesaldo ;
   ALTER TABLE  `r_factuprovesaldo` ADD PRIMARY KEY (`idfactprov`);

   # r_pagosprovsaldo
   DROP TABLE IF EXISTS `r_pagosprovsaldo`;
   CREATE TABLE `r_pagosprovsaldo` AS SELECT * FROM pagosprovsaldo ;
   ALTER TABLE  `r_pagosprovsaldo` ADD PRIMARY KEY (`idpago`);

   # r_articulostock
   DROP TABLE IF EXISTS `r_articulostock`;
   CREATE TABLE `r_articulostock` AS SELECT * FROM articulostock ;
   ALTER TABLE  `r_articulostock` ADD PRIMARY KEY (`articulo`);

   # r_depostock
   DROP TABLE IF EXISTS `r_depostock`;
   CREATE TABLE `r_depostock` AS SELECT * FROM depostock ;
   ALTER TABLE  `r_depostock` ADD INDEX `deposito`(`deposito`), ADD INDEX `articulo`(`articulo`) ;

   # r_artpendiente
   DROP TABLE IF EXISTS `r_artpendiente`;
   CREATE TABLE `r_artpendiente` AS SELECT * FROM artpendiente ;
   ALTER TABLE  `r_artpendiente` ADD PRIMARY KEY (`articulo`);

   # r_otpendientes
   DROP TABLE IF EXISTS `r_otpendientes`;
   CREATE TABLE `r_otpendientes` AS SELECT * FROM otpendientes ;
   ALTER TABLE  `r_otpendientes` ADD PRIMARY KEY (`idot`);

   # r_bancosaldos
   DROP TABLE IF EXISTS `r_bancosaldos`;
   CREATE TABLE `r_bancosaldos` AS SELECT * FROM bancosaldos ;
   ALTER TABLE  `r_bancosaldos` ADD PRIMARY KEY (`idcuenta`);

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
    left join `r_artpendiente` `p` on((`a`.`articulo` = `p`.`articulo` )))
    where `a`.`deposito` = pdeposito and `a`.`articulo`= particulo and (not(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a`
    where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;


     delete from r_depostock where deposito = pdeposito and articulo = particulo;
     insert into r_depostock values (pdeposito, particulo, @vnombreart, @vstocktot, @vstock, @vstockmin, @vpendiente ) ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_factuprovesaldo`
--

DROP PROCEDURE IF EXISTS `p_factuprovesaldo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_factuprovesaldo`(in pidfactprov int)
BEGIN
    set @vcobrado := 0.00 ;
    set @vsaldof  := 0.00 ;

    select ifnull(sum(`c`.`imputado`),0) , (`f`.`total` - ifnull(sum(`c`.`imputado`),0)) into @vcobrado, @vsaldof
    from (`factuprove` `f` left join `pagosprovfc` `c` on((`f`.`idfactprove` = `c`.`idfactprove`))) where f.idfactprove = pidfactprov ;

    delete from r_factuprovesaldo where idfactprov = pidfactprov ;

    if @vcobrado <> 0 or @vsaldof <> 0 then
      insert into r_factuprovesaldo values (pidfactprov,@vcobrado,@vsaldof);
    end if ;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_facturasaldo`
--

DROP PROCEDURE IF EXISTS `p_facturasaldo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_facturasaldo`(in pidfactura int)
BEGIN
    set @vcobrado := 0.00 ;
    set @vsaldof  := 0.00 ;

    select (ifnull(sum(`c`.`imputado`),0)), (`f`.`total` - ifnull(sum(`c`.`imputado`),0)) into @vcobrado, @vsaldof
    from (`facturas` `f` left join `cobros` `c` on((`f`.`idfactura` = `c`.`idfactura`)))
    where `f`.`idfactura` = pidfactura and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado`
    where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura') and (`ultimoestado`.`id` = pidfactura )
    and (`ultimoestado`.`idestador` = 2))))) ;

    delete from r_facturasaldo where idfactura = pidfactura ;

    if @vcobrado <> 0 or @vsaldof <> 0 then
      insert into r_facturasaldo values (pidfactura,@vcobrado,@vsaldof);
    end if ;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_facturasctasaldo`
--

DROP PROCEDURE IF EXISTS `p_facturasctasaldo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_facturasctasaldo`(in pidcuotafc int)
BEGIN

    set @vcuota     := 0 ;
    set @vidfactura := 0 ;
    set @vimporte   := 0.00 ;
    set @vcobrado   := 0.00 ;
    set @vsaldof    := 0.00 ;

    select `f`.`cuota` ,`f`.`idfactura` ,`f`.`importe` , ifnull(sum(`c`.`imputado`),0) ,(`f`.`importe` - ifnull(sum(`c`.`imputado`),0))
            into @vcuota, @vidfactura, @vimporte, @vcobrado, @vsaldof
    from (`facturascta` `f` left join `cobros` `c` on((`f`.`idcuotafc` = `c`.`idcuotafc`)))
    where `f`.`idcuotafc` = pidcuotafc and ((not(`f`.`idcuotafc` in (select `ultimoestado`.`id` from `ultimoestado`
    where ((`ultimoestado`.`tabla` = 'facturascta') and (`ultimoestado`.`campo` = 'idcuotafc') and  (`ultimoestado`.`id` = pidcuotafc)
    and (`ultimoestado`.`idestador` = 2))))) and (not(`f`.`idfactura` in (select `ultimoestado`.`id` from `ultimoestado`
    where ((`ultimoestado`.`tabla` = 'facturas') and (`ultimoestado`.`campo` = 'idfactura')
    and (`ultimoestado`.`idestador` = 2)))))) group by `f`.`idcuotafc`;


     delete from r_facturasctasaldo where idcuotafc = pidcuotafc ;
     insert into r_facturasctasaldo values (pidcuotafc,@vcuota, @vidfactura, @vimporte, @vcobrado, @vsaldof);

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

    select `o`.`articulo` ,`o`.`cantidad` ,sum(ifnull(`h`.`cantidad`,0.00)), (`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00)))
    into @varticulo, @vcantidad, @vcantcump, @vpendiente
    from (`ot` `o` left join `cumplimentah` `h` on((`o`.`idot` = `h`.`idot`))) where `o`.`idot` = pidot ;


    delete from r_otpendientes where idot = pidot ;
    if @vcantidad = 0 then
        insert into r_otpendientes values (pidot, @varticulo, @vcantidad, @vcantcump, @vpendiente);
    end if ;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_pagosprovsaldo`
--

DROP PROCEDURE IF EXISTS `p_pagosprovsaldo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_pagosprovsaldo`(in pidpago int)
BEGIN


    set @vidcomproba  := 0 ;
    set @vtotimputado := 0 ;
    set @vimporte     := 0.00 ;
    set @vsaldo       := 0.00 ;

    select `r`.`idcomproba` , ifnull(sum(`c`.`imputado`),0) , `r`.`importe` ,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0))
      into @vidcomproba, @vtotimputado, @vimporte, @vsaldo
    from ((`pagosprov` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`)))
    left join `pagosprovfc` `c` on((`r`.`idpago` = `c`.`idpago`)))
    where `r`.`idpago` = pidpago and ((`cp`.`tabla` = 'pagosprov') and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov')
    and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`id` = pidpago) and (`ultimoestado`.`idestador` = 2)))))) ;

	if @vidcomproba <> null then 
		delete from r_pagosprovsaldo where idpago = pidpago ;
		insert into r_pagosprovsaldo values (@vidcomproba,@vtotimputado, pidpago, @vimporte, @vsaldo);
	end if ;


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `p_recibossaldo`
--

DROP PROCEDURE IF EXISTS `p_recibossaldo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_recibossaldo`(in pidrecibo int )
BEGIN

    set @vidcomproba  := 0 ;
    set @vtotimputado := 0 ;
    set @vtotrecargo  := 0.00 ;
    set @vimporte     := 0.00 ;
    set @vsaldo       := 0.00 ;


    select `r`.`idcomproba` ,ifnull(sum(`c`.`imputado`),0) , ifnull(sum(`c`.`recargo`),0) ,`r`.`importe`, (`r`.`importe` - ifnull(sum(`c`.`imputado`),0))
    into   @vidcomproba, @vtotimputado, @vtotrecargo, @vimporte, @vsaldo
    from ((`recibos` `r`  left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`)))
    left join `cobros` `c` on(((`r`.`idrecibo` = `c`.`idregipago`) and (`r`.`idcomproba` = `c`.`idcomproba`))))
    where r.idrecibo = pidrecibo and ((`cp`.`tabla` = 'recibos') and (not(`r`.`idrecibo` in (select `ultimoestado`.`id` from `ultimoestado`
    where ((`ultimoestado`.`tabla` = 'recibos') and (`ultimoestado`.`campo` = 'idrecibo') and (`ultimoestado`.`id` = pidrecibo)
    and (`ultimoestado`.`idestador` = 2)))))) ;

    if @vidcomproba <> null then 
		delete from r_recibossaldo where idrecibo = pidrecibo ;
		insert into r_recibossaldo values (@vidcomproba,@vtotimputado, @vtotrecargo, pidrecibo, @vimporte, @vsaldo);
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
