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
-- Create schema processarel
--

CREATE DATABASE IF NOT EXISTS processarel;
USE processarel;

--
-- Definition of procedure `p_bancosaldos`
--

DROP PROCEDURE IF EXISTS `p_bancosaldos`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_bancosaldos`(in pidcuenta int)
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

    

 --   select `c`.`codcuenta` ,`c`.`detalle` ,`c`.`cuentabco`, `c`.`idtipocta`, `c`.`idbanco`, `c`.`cbu`, `c`.`plcaja`, `c`.`cheques`,
 --   `c`.`cbancaria`,`b`.`banco`, `b`.`nombre`, `b`.`filial`, `b`.`cp`, sum(ifnull(`d`.`importe`,0))
 --   into @vcodcuenta, @vdetalle,@vcuentabco, @vidtipocta,@vidbanco,@vcbu, @vplcaja, @vcheques, @vcbancaria, @vbanco, @vnombre, @vfilial, @vcp, @vingresos
 --   from `cajabancos` `c`
 --   left join `bancos` `b` on`b`.`idbanco` = `c`.`idbanco`
 --   left join `detallecobros` `d` on `c`.`idcuenta` = `d`.`idcuenta`
 --   left join `comprobantes` `cd` on `cd`.`idcomproba` = `d`.`idcomproba`
 --   left join `ultimoestado` `u` on (`u`.`id` = `d`.`idregistro` and convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))
 --   where `c`.`idcuenta`= pidcuenta and  (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp') ;

    create temporary table tmpanulados as SELECT concat(trim(tabla),id) as idx   FROM ultimoestado where idestador = 2 or tabla = 'anularp';

    create temporary table tmpcobros as ( select `c`.`codcuenta` ,`c`.`detalle` ,`c`.`cuentabco`, `c`.`idtipocta`, `c`.`idbanco`, `c`.`cbu`, `c`.`plcaja`, `c`.`cheques`,
    `c`.`cbancaria`,`b`.`banco`, `b`.`nombre`, `b`.`filial`, `b`.`cp`, (ifnull(`d`.`importe`,0)) as importe , concat(trim(cd.tabla),d.idregistro) as idx
    from `cajabancos` `c`
    left join `bancos` `b` on`b`.`idbanco` = `c`.`idbanco`
    left join `detallecobros` `d` on `c`.`idcuenta` = `d`.`idcuenta`
    left join `comprobantes` `cd` on `cd`.`idcomproba` = `d`.`idcomproba`
    where `c`.`idcuenta`= pidcuenta and cd.tabla <> 'anularp' );

    select `codcuenta` ,`detalle` ,`cuentabco`, `idtipocta`, `idbanco`, `cbu`, `plcaja`, `cheques`,
    `cbancaria`,`banco`, `nombre`, `filial`, `cp`, sum(ifnull(`importe`,0))
    into @vcodcuenta, @vdetalle,@vcuentabco, @vidtipocta,@vidbanco,@vcbu, @vplcaja, @vcheques, @vcbancaria, @vbanco, @vnombre, @vfilial, @vcp, @vingresos
    from `tmpcobros` where idx not in (select idx from tmpanulados) ;



 --   select sum(ifnull(`d`.`importe`,0)) into @vegresos
 --   from `cajabancos` `c`
 --   left join `detallepagos` `d` on `c`.`idcuenta` = `d`.`idcuenta`
 --   left join `comprobantes` `cd` on `cd`.`idcomproba` = `d`.`idcomproba`
 --   left join `ultimoestado` `u` on (`u`.`id` = `d`.`idregistro` and convert(`u`.`tabla` using utf8) = convert(`cd`.`tabla` using utf8))
 --   where `c`.`idcuenta`= pidcuenta and (`u`.`idestador` <> 2) and (`u`.`tabla` <> 'anularp') ;

    create temporary table tmppagos as ( select concat(trim(cd.tabla),d.idregistro) as idx , (ifnull(`d`.`importe`,0)) as importe
    from `cajabancos` `c`
    left join `detallepagos` `d` on `c`.`idcuenta` = `d`.`idcuenta`
    left join `comprobantes` `cd` on `cd`.`idcomproba` = `d`.`idcomproba`
    where `c`.`idcuenta`= pidcuenta  and cd.tabla <> 'anularp' ) ;

    select sum(ifnull(`importe`,0)) into @vegresos
    from tmppagos where idx not in (select idx from tmpanulados) ;

	  drop temporary table tmpanulados ;
    drop temporary table tmpcobros ;
    drop temporary table tmppagos ;


	  set @vsaldo := ( ifnull(@vingresos,0.00) - ifnull(@vegresos,0.00) ) ;


    delete from r_bancosaldos where idcuenta = pidcuenta ;

    insert into r_bancosaldos values (pidcuenta, @vcodcuenta, @vdetalle,@vcuentabco, @vidtipocta,@vidbanco,@vcbu, @vplcaja, @vcheques, @vcbancaria, @vbanco, @vnombre, @vfilial, @vcp, @vsaldo);


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
