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
-- Definition of procedure `p_pagosprovsaldo`
--

DROP PROCEDURE IF EXISTS `p_pagosprovsaldo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_pagosprovsaldo`(in pidpago int)
BEGIN


    set @vidcomproba  := 0 ;
    set @vtotimputado := 0 ;
    set @vimporte     := 0.00 ;
    set @vsaldo       := 0.00 ;

    select `r`.`idcomproba` , ifnull(sum(`c`.`imputado`),0) , `r`.`importe` ,(`r`.`importe` - ifnull(sum(`c`.`imputado`),0))
      into @vidcomproba, @vtotimputado, @vimporte, @vsaldo
    from ((`pagosprov` `r` left join `comprobantes` `cp` on((`r`.`idcomproba` = `cp`.`idcomproba`)))
    left join `pagosprovfc` `c` on((`r`.`idpago` = `c`.`idpago`) and (`r`.`idcomproba` = `c`.`idcomproba`)))
    where `r`.`idpago` = pidpago and ((`cp`.`tabla` = 'pagosprov') and (not(`r`.`idpago` in (select `ultimoestado`.`id` from `ultimoestado` where ((`ultimoestado`.`tabla` = 'pagosprov')
    and (`ultimoestado`.`campo` = 'idpago') and (`ultimoestado`.`id` = pidpago) and (`ultimoestado`.`idestador` = 2)))))) ;

         if isnull(@vidcomproba) <> true then
		delete from r_pagosprovsaldo where idpago = pidpago ;
		insert into r_pagosprovsaldo values (@vidcomproba,@vtotimputado, pidpago, @vimporte, @vsaldo);
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
