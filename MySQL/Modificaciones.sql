-- Modificaciones realizadas en la Base de Datos --

--20240710--

ALTER TABLE `cbcobrador` ADD COLUMN `cobromax` DOUBLE(13,2) NOT NULL DEFAULT 0.00 AFTER `idcajabco`,
 ADD COLUMN `ecobromax` CHAR(10) NOT NULL AFTER `edescripen`;


ALTER TABLE `cbasociadas` ADD COLUMN `cobromax` DOUBLE(13,2) NOT NULL DEFAULT 0.00 AFTER `subcodid`,
ADD COLUMN `ecobromax` CHAR(10) NOT NULL AFTER `edescripen`;

--20240921--

ALTER TABLE `bocaservicios` ADD COLUMN `factorm DOUBLE(13,2) NOT NULL DEFAULT 1.00 AFTER `idcatser`;
ALTER TABLE `mservicios` ADD COLUMN `factorm DOUBLE(13,2) NOT NULL DEFAULT 1.00 AFTER `idcatser`;
ALTER TABLE `facturasbser` ADD COLUMN `factorm DOUBLE(13,2) NOT NULL DEFAULT 1.00 AFTER `idcatser`;
ALTER TABLE `facturasbsertmp` ADD COLUMN `factorm DOUBLE(13,2) NOT NULL DEFAULT 1.00 AFTER `idcatser`;


--20240924--

CREATE TABLE `funcionesimp` (
  `funcion` CHAR(100) NOT NULL,
  `detalle` CHAR(200) NOT NULL,
  PRIMARY KEY (`funcion`)
)
ENGINE = InnoDB;


insert into `funcionesimp` values ('RET_GANANCIAS_IFN', 'Función para el cálculo de Retenciones de Ganancias');
insert into `funcionesimp` values ('RET_IIBB_STAFE_IFN', 'Función para el cálculo de Retenciones de Ingresos Brutos Santa Fé');
insert into `funcionesimp` values ('RET_IIBB_ARBA_IFN', 'Función para el cálculo de Retenciones de Ingresos Brutos Prov. Bs. As.');


--20241005--
ALTER TABLE `afipescalas` ADD COLUMN `escala` CHAR(100) NOT NULL AFTER `minret`;


--20241010--
ALTER TABLE `entidades` ADD COLUMN `whatsapp` CHAR(50) NOT NULL DEFAULT ' ' AFTER `timestamp`;



--20241128--

ALTER TABLE `grupoobjeto` MODIFY COLUMN `idgrupobj` INTEGER UNSIGNED NOT NULL DEFAULT NULL AUTO_INCREMENT;

--20250121--
-- Agregado de campo para guardar el nombre de la función a aplicar para convertir archivos de exportación o importación
ALTER TABLE `cbcobrador` ADD COLUMN `funcionfiltro` CHAR(100) NOT NULL DEFAULT ' ' AFTER `cobromax`;


--20250203--
ALTER TABLE `cbcomprobantes` ADD INDEX `Index_3`(`entidad`),
 ADD INDEX `Index_4`(`servicio`),
 ADD INDEX `Index_5`(`cuenta`),
 ADD INDEX `Index_6`(`bc`),
 ADD INDEX `Index_7`(`descrip`),
 ADD INDEX `Index_8`(`lote`),
 ADD INDEX `Index_9`(`idcbasoci`),
 ADD INDEX `Index_10`(`lote`);

ALTER TABLE `cbasociadas` DROP PRIMARY KEY,
 ADD PRIMARY KEY  USING BTREE(`idcbasoci`),
 ADD INDEX `Index_4`(`cuit`);
 
 --202502008--
 CREATE TABLE  `impupercepcion` (
  `idimpuper` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(200) NOT NULL,
  `razon` int(10) unsigned NOT NULL,
  `baseimpon` double(13,2) NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `funcion` char(100) NOT NULL,
  ADD COLUMN `idconcepto` INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (`idimpuper`),
  ADD INDEX `idconcepto`(`idconcepto`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

ALTER TABLE `facturasimp` ADD INDEX `idfactura`(`idfactura`),
 ADD INDEX `impuesto`(`impuesto`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idconcepto`(`idconcepto`);
 
 --20250213--
 ALTER TABLE `funcionesimp` ADD COLUMN `grupo` CHAR(100) NOT NULL AFTER `detalle`;


 --20250301--
CREATE TABLE `pntvoucher` (
  `idpntvou` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `pventa` int(10) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `nombre` char(150) NOT NULL,
  `puntos` float(13,2) NOT NULL,
  `importe` float(13,2) NOT NULL,
  `idpntvalor` int(10) unsigned NOT NULL,
  `entidadre` int(10) unsigned NOT NULL,
  `fechare` char(8) NOT NULL,
  `usuario` char(30) NOT NULL,
  `fechaven` char(8) NOT NULL,
  `observa` char(200) NOT NULL,
  PRIMARY KEY (`idpntvou`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


ALTER TABLE `otmovistockh` ADD COLUMN `lote` CHAR(50) NOT NULL DEFAULT ' ' AFTER `unidad`,
 ADD COLUMN `lotevto` CHAR(8) NOT NULL DEFAULT ' ' AFTER `lote`;
 
 
 --20250308--

CREATE TABLE  `impuretencion` (
  `idimpuret` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(200) NOT NULL,
  `razonin` int(10) unsigned NOT NULL,
  `baseimpon` double(13,2) NOT NULL,
  `idtipopago` int(10) unsigned NOT NULL,
  `funcion` char(100) NOT NULL,
  `razonnin` int(10) unsigned NOT NULL,
  `baseimponn` double(13,2) NOT NULL,
  `regimen` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idimpuret`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;


CREATE TABLE  `entidadper` (
  `identper` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idimpuper` int(10) unsigned NOT NULL,
  `enconvenio` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`identper`)
) ENGINE=InnoDB AUTO_INCREMENT=597 DEFAULT CHARSET=latin1;


CREATE TABLE  `entidadret` (
  `identret` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idimpuret` int(10) unsigned NOT NULL,
  `enconvenio` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`identret`)
) ENGINE=InnoDB AUTO_INCREMENT=613 DEFAULT CHARSET=latin1;


--20250318--

-- TABLAS

CREATE TABLE  `ajustesacopio` (
  `idajustea` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` char(8) NOT NULL,
  `monto` float(13,4) NOT NULL,
  `observa` char(254) NOT NULL,
  `opera` int(11) NOT NULL,
  PRIMARY KEY (`idajustea`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=utf8mb4_general_ci;


CREATE TABLE  `otsector` (
  `idotsector` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idot` int(10) unsigned NOT NULL,
  `idsector` int(10) unsigned NOT NULL,
  `cantidad` double(13,2) NOT NULL,
  `cantidaduf` double(13,2) NOT NULL,
  PRIMARY KEY (`idotsector`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE  `sector` (
  `idsector` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sector` char(100) NOT NULL,
  `descrip` char(250) NOT NULL,
  PRIMARY KEY (`idsector`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE  `sectorcomp` (
  `idseccomp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idsector` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idseccomp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--VISTAS

CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW  `cumplidootsec` AS select `h`.`articulo` AS `articulo`,`h`.`detalle` AS `detalle`,`h`.`idot` AS `idot`,`s`.`idsector` AS `idsector`,sum(`h`.`cantidad`) AS `cantcump`,sum(`h`.`cantidaduf`) AS `cantufcump` from ((`cumplimentap` `p` left join `sectorcomp` `s` on(`p`.`idcomproba` = `s`.`idcomproba`)) left join `cumplimentah` `h` on(`p`.`idcump` = `h`.`idcump`)) group by `h`.`idot`,`s`.`idsector`;

CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW  `otsectorpendiente` AS select `s`.`idsector` AS `idsector`,`s`.`idot` AS `idot`,`o`.`articulo` AS `articulo`,`o`.`idmate` AS `idmate`,`s`.`cantidad` AS `cantped`,`s`.`cantidaduf` AS `cantufped`,ifnull(`c`.`cantcump`,0.00) AS `cantcump`,ifnull(`c`.`cantufcump`,0.00) AS `cantufcump`,`s`.`cantidad` - ifnull(`c`.`cantcump`,0.00) AS `cantpend`,`s`.`cantidaduf` - ifnull(`c`.`cantufcump`,0.00) AS `cantufpend` from ((`otsector` `s` left join `ot` `o` on(`s`.`idot` = `o`.`idot`)) left join `cumplidootsec` `c` on(`s`.`idsector` = `c`.`idsector` and `s`.`idot` = `c`.`idot`));