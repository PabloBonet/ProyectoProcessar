-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.5-10.5.12-MariaDB-0+deb11u1


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema processar
--

CREATE DATABASE IF NOT EXISTS processar;
USE processar;


--
-- Definition of trigger `facturas_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `facturas_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `facturas_AFTER_INSERT` AFTER INSERT ON `facturas` FOR EACH ROW BEGIN
	call p_facturasaldo(NEW.idfactura);
END $$
DELIMITER ;

--
-- Definition of trigger `facturas_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `facturas_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `facturas_AFTER_DELETE` AFTER DELETE ON `facturas` FOR EACH ROW BEGIN
	call p_facturasaldo(OLD.idfactura);
END $$
DELIMITER ;



--
-- Definition of trigger `cobros_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `cobros_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `cobros_AFTER_INSERT` AFTER INSERT ON `cobros` FOR EACH ROW BEGIN
	call p_facturasaldo(NEW.idfactura);
	call p_facturasctasaldo(NEW.idcuotafc);	
	call p_recibossaldo(NEW.idregipago);
	
END $$
DELIMITER ;

--
-- Definition of trigger `cobros_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `cobros_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `cobros_AFTER_DELETE` AFTER DELETE ON `cobros` FOR EACH ROW BEGIN
	call p_facturasaldo(OLD.idfactura);
	call p_facturasctasaldo(OLD.idcuotafc);	
	call p_recibossaldo(OLD.idregipago);
END $$
DELIMITER ;




--
-- Definition of trigger `facturascta_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `facturascta_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `facturascta_AFTER_INSERT` AFTER INSERT ON `facturascta` FOR EACH ROW BEGIN
	call p_facturasctasaldo(NEW.idcuotafc);
END $$
DELIMITER ;

--
-- Definition of trigger `cobros_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `facturascta_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `facturascta_AFTER_DELETE` AFTER DELETE ON `facturascta` FOR EACH ROW BEGIN
	call p_facturasctasaldo(OLD.idcuotafc);
END $$
DELIMITER ;




--
-- Definition of trigger `recibos_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `recibos_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `recibos_AFTER_INSERT` AFTER INSERT ON `recibos` FOR EACH ROW BEGIN
	call p_recibossaldo(NEW.idrecibo);
END $$
DELIMITER ;

--
-- Definition of trigger `recibos_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `recibos_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `recibos_AFTER_DELETE` AFTER DELETE ON `recibos` FOR EACH ROW BEGIN
	call p_recibossaldo(OLD.idrecibo);
END $$
DELIMITER ;


------------------------------------------------------------------------------

--
-- Definition of trigger `factuprove_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `factuprove_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `factuprove_AFTER_INSERT` AFTER INSERT ON `factuprove` FOR EACH ROW BEGIN
	call p_factuprovesaldo(NEW.idfactprove);
END $$
DELIMITER ;

--
-- Definition of trigger `factuprove_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `factuprove_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `factuprove_AFTER_DELETE` AFTER DELETE ON `factuprove` FOR EACH ROW BEGIN
	call p_factuprovesaldo(OLD.idfactprove);
END $$
DELIMITER ;



--
-- Definition of trigger `pagosprovfc_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `pagosprovfc_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `pagosprovfc_AFTER_INSERT` AFTER INSERT ON `pagosprovfc` FOR EACH ROW BEGIN
	call p_factuprovesaldo(NEW.idfactprove);
	call p_pagosprovsaldo(NEW.idpago);
END $$
DELIMITER ;

--
-- Definition of trigger `pagosprovfc_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `pagosprovfc_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `pagosprovfc_AFTER_DELETE` AFTER DELETE ON `pagosprovfc` FOR EACH ROW BEGIN
	call p_factuprovesaldo(OLD.idfactprove);
	call p_pagosprovsaldo(OLD.idpago);
END $$
DELIMITER ;




--
-- Definition of trigger `pagosprov_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `pagosprov_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `pagosprov_AFTER_INSERT` AFTER INSERT ON `pagosprov` FOR EACH ROW BEGIN
	call p_pagosprovsaldo(NEW.idpago);
END $$
DELIMITER ;

--
-- Definition of trigger `pagosprov_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `pagosprov_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `pagosprov_AFTER_DELETE` AFTER DELETE ON `pagosprov` FOR EACH ROW BEGIN
	call p_pagosprovsaldo(OLD.idpago);
END $$
DELIMITER ;


-------------------------------------------------------------------------------------


--
-- Definition of trigger `articulos_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `articulos_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `articulos_AFTER_INSERT` AFTER INSERT ON `articulos` FOR EACH ROW BEGIN
	call p_articulostock(NEW.articulo);
END $$
DELIMITER ;

--
-- Definition of trigger `articulos_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `articulos_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `articulos_AFTER_DELETE` AFTER DELETE ON `articulos` FOR EACH ROW BEGIN
	call p_articulostock(OLD.articulo);
END $$
DELIMITER ;



--
-- Definition of trigger `ajustestockh_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `ajustestockh_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `ajustestockh_AFTER_INSERT` AFTER INSERT ON `ajustestockh` FOR EACH ROW BEGIN
	call p_articulostock(NEW.articulo);
	call p_depostock(NEW.deposito, NEW.articulo);
END $$
DELIMITER ;

--
-- Definition of trigger `ajustestockh_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `ajustestockh_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `ajustestockh_AFTER_DELETE` AFTER DELETE ON `ajustestockh` FOR EACH ROW BEGIN
	call p_articulostock(OLD.articulo);
	call p_depostock(OLD.deposito,OLD.articulo);
END $$
DELIMITER ;



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
-- Definition of trigger `cumplimentah_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `cumplimentah_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `cumplimentah_AFTER_INSERT` AFTER INSERT ON `cumplimentah` FOR EACH ROW BEGIN
	call p_otpendientes(NEW.idot);
	call p_artpendiente(NEW.articulo);
END $$
DELIMITER ;

--
-- Definition of trigger `cumplimentah_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `cumplimentah_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `cumplimentah_AFTER_DELETE` AFTER DELETE ON `cumplimentah` FOR EACH ROW BEGIN
	call p_otpendientes(OLD.idot);
	call p_artpendiente(OLD.articulo);
END $$
DELIMITER ;


--------------------------------------------------------------


--
-- Definition of trigger `cajabancos_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `cajabancos_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `cajabancos_AFTER_INSERT` AFTER INSERT ON `cajabancos` FOR EACH ROW BEGIN
	call p_bancosaldos(NEW.idcuenta);
END $$
DELIMITER ;

--
-- Definition of trigger `cajabancos_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `cajabancos_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `cajabancos_AFTER_DELETE` AFTER DELETE ON `cajabancos` FOR EACH ROW BEGIN
	call p_bancosaldos(OLD.idcuenta);
END $$
DELIMITER ;


--
-- Definition of trigger `detallecobros_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `detallecobros_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `detallecobros_AFTER_INSERT` AFTER INSERT ON `detallecobros` FOR EACH ROW BEGIN
	call p_bancosaldos(NEW.idcuenta);
END $$
DELIMITER ;

--
-- Definition of trigger `detallecobros_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `detallecobros_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `detallecobros_AFTER_DELETE` AFTER DELETE ON `detallecobros` FOR EACH ROW BEGIN
	call p_bancosaldos(OLD.idcuenta);
END $$
DELIMITER ;



--
-- Definition of trigger `detallepagos_AFTER_INSERT`
--
DROP TRIGGER /*!50030 IF EXISTS */ `detallepagos_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `detallepagos_AFTER_INSERT` AFTER INSERT ON `detallepagos` FOR EACH ROW BEGIN
	call p_bancosaldos(NEW.idcuenta);
END $$
DELIMITER ;

--
-- Definition of trigger `detallepagos_AFTER_DELETE`
--
DROP TRIGGER /*!50030 IF EXISTS */ `detallepagos_AFTER_DELETE`;
DELIMITER $$
CREATE DEFINER = `tulior`@`%` TRIGGER `detallepagos_AFTER_DELETE` AFTER DELETE ON `detallepagos` FOR EACH ROW BEGIN
	call p_bancosaldos(OLD.idcuenta);
END $$
DELIMITER ;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
