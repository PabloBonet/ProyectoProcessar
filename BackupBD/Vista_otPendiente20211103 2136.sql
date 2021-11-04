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
-- Temporary table structure for view `otpendientes`
--
DROP TABLE IF EXISTS `otpendientes`;
DROP VIEW IF EXISTS `otpendientes`;
CREATE TABLE `otpendientes` (
  `idot` int(10) unsigned,
  `articulo` char(50),
  `cantidad` double(13,2),
  `cantcump` double(19,2),
  `pendiente` double(19,2)
);

--
-- Definition of view `otpendientes`
--

DROP TABLE IF EXISTS `otpendientes`;
DROP VIEW IF EXISTS `otpendientes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otpendientes` AS select `o`.`idot` AS `idot`,`o`.`articulo` AS `articulo`,`o`.`cantidad` AS `cantidad`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantcump`,(`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendiente` from (((`ot` `o` left join `np` `n` on((`o`.`idnp` = `n`.`idnp`))) left join `tiponp` `t` on((`n`.`idtiponp` = `t`.`idtiponp`))) left join `cumplimentah` `h` on((`o`.`idot` = `h`.`idot`))) where (`t`.`stock` = 'S') group by `o`.`idot`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
