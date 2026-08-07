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
  `grupo` CHAR(100) NOT NULL,
  PRIMARY KEY (`funcion`)
)
ENGINE = InnoDB;


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
  `razon` double(10,2) NOT NULL,
  `baseimpon` double(13,2) NOT NULL,
  `funcion` char(100) NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idimpuper`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `facturasimp` ADD INDEX `idfactura`(`idfactura`),
 ADD INDEX `impuesto`(`impuesto`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idconcepto`(`idconcepto`);
 
 


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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE  `entidadper` (
  `identper` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idimpuper` int(10) unsigned NOT NULL,
  `enconvenio` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`identper`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE  `entidadret` (
  `identret` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idimpuret` int(10) unsigned NOT NULL,
  `enconvenio` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`identret`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--20250318--

-- TABLAS


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


CREATE TABLE  `entidadesa` (
  `identa` int(11) NOT NULL,
  `entidad` int(11) DEFAULT NULL,
  `articulo` char(50) DEFAULT NULL,
  `idconcepto` int(11) DEFAULT NULL,
  PRIMARY KEY (`identa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE  `unidades` (
  `unidad` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` char(50) NOT NULL,
  PRIMARY KEY (`unidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


--VISTAS

CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW  `cumplidootsec` AS select `h`.`articulo` AS `articulo`,`h`.`detalle` AS `detalle`,`h`.`idot` AS `idot`,`s`.`idsector` AS `idsector`,sum(`h`.`cantidad`) AS `cantcump`,sum(`h`.`cantidaduf`) AS `cantufcump` from ((`cumplimentap` `p` left join `sectorcomp` `s` on(`p`.`idcomproba` = `s`.`idcomproba`)) left join `cumplimentah` `h` on(`p`.`idcump` = `h`.`idcump`)) group by `h`.`idot`,`s`.`idsector`;

CREATE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW  `otsectorpendiente` AS select `s`.`idsector` AS `idsector`,`s`.`idot` AS `idot`,`o`.`articulo` AS `articulo`,`o`.`idmate` AS `idmate`,`s`.`cantidad` AS `cantped`,`s`.`cantidaduf` AS `cantufped`,ifnull(`c`.`cantcump`,0.00) AS `cantcump`,ifnull(`c`.`cantufcump`,0.00) AS `cantufcump`,`s`.`cantidad` - ifnull(`c`.`cantcump`,0.00) AS `cantpend`,`s`.`cantidaduf` - ifnull(`c`.`cantufcump`,0.00) AS `cantufpend` from ((`otsector` `s` left join `ot` `o` on(`s`.`idot` = `o`.`idot`)) left join `cumplidootsec` `c` on(`s`.`idsector` = `c`.`idsector` and `s`.`idot` = `c`.`idot`));



--20250401--

--Tablas--
CREATE TABLE  `pntentidades` (
  `entidad` int(10) unsigned NOT NULL,
  `fechaini` char(8) NOT NULL,
  `fechafin` char(8) NOT NULL,
  PRIMARY KEY (`entidad`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `pntfiltro` (
  `idpntfil` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpntopera` int(10) unsigned NOT NULL,
  `tablaf` char(100) NOT NULL DEFAULT '',
  `campof` char(100) NOT NULL DEFAULT '',
  `tipof` char(50) NOT NULL DEFAULT '',
  `valor1` char(50) NOT NULL DEFAULT '',
  `compara` char(20) NOT NULL,
  `valor2` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`idpntfil`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

CREATE TABLE  `pntfuncion` (
  `idpntfun` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(254) NOT NULL,
  `funcionpnt` char(100) NOT NULL,
  PRIMARY KEY (`idpntfun`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE  `pntopera` (
  `idpntopera` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(254) NOT NULL,
  `puntos` float(13,2) NOT NULL,
  `tabla` char(100) NOT NULL,
  `cmpfactor` char(100) NOT NULL,
  `tipo` char(50) NOT NULL,
  `fechaini` char(8) NOT NULL,
  `fechafin` char(8) NOT NULL,
  `idpntfun` int(10) unsigned NOT NULL,
  `funcionpnt` char(100) NOT NULL,
  `automat` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idpntopera`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE  `pntpuntos` (
  `idpuntos` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idpntopera` int(10) unsigned NOT NULL,
  `tabla` char(100) NOT NULL,
  `campo` char(100) NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `puntos` float(13,2) NOT NULL,
  `detalle` char(254) NOT NULL,
  PRIMARY KEY (`idpuntos`)
) ENGINE=InnoDB AUTO_INCREMENT=2807 DEFAULT CHARSET=latin1;

CREATE TABLE  `pntvalor` (
  `idpntvalor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(254) NOT NULL,
  `valor` float(13,2) NOT NULL,
  `articulo` char(20) NOT NULL,
  PRIMARY KEY (`idpntvalor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE  `pntvoucher` (
  `idpntvou` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned DEFAULT NULL,
  `pventa` int(10) unsigned DEFAULT NULL,
  `numero` int(10) unsigned DEFAULT NULL,
  `fecha` char(8) DEFAULT NULL,
  `entidad` int(11) DEFAULT NULL,
  `nombre` char(150) DEFAULT NULL,
  `puntos` float(13,2) DEFAULT NULL,
  `importe` float(13,2) DEFAULT NULL,
  `idpntvalor` int(11) DEFAULT NULL,
  `entidadre` int(11) DEFAULT NULL,
  `fechare` char(8) DEFAULT NULL,
  `usuario` char(30) DEFAULT NULL,
  `fechaven` char(8) DEFAULT NULL,
  `observa` char(200) DEFAULT NULL,
  PRIMARY KEY (`idpntvou`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;


CREATE TABLE  `acopio` (
  `idacopio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pventa` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `descrip` char(100) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `numcomp` int(10) unsigned NOT NULL,
  `carpintero` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idacopio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `acopiod` (
  `idacopiod` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopio` int(10) unsigned NOT NULL,
  `idmateacopio` int(10) unsigned NOT NULL,
  `precio` float(13,4) NOT NULL,
  `tipocbio` float(13,4) NOT NULL,
  `moneda` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idacopiod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `acopiop` (
  `idacopiop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pventa` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `descrip` char(100) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idacopiop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `acopiodp` (
  `idacopiodp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopiop` int(10) unsigned NOT NULL,
  `idmateacop` int(10) unsigned NOT NULL,
  `precio` float(13,4) NOT NULL,
  `tipocbio` float(13,4) NOT NULL,
  `moneda` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idacopiodp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `ajustesacopio` (
  `idajustea` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` char(8) NOT NULL,
  `monto` float(13,4) NOT NULL,
  `observa` char(254) NOT NULL,
  `opera` int(11) NOT NULL,
  PRIMARY KEY (`idajustea`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `ajustesacopiop` (
  `idajusteap` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `monto` float(13,4) NOT NULL,
  `observa` char(254) NOT NULL,
  PRIMARY KEY (`idajusteap`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `compacopio` (
  `idcompacopio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopio` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  `idnp` int(10) unsigned NOT NULL,
  `acopio` char(1) NOT NULL,
  `idajustea` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcompacopio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `compacopiop` (
  `idcompacop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idacopiop` int(10) unsigned NOT NULL,
  `importe` float(13,4) NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  `idnp` int(10) unsigned NOT NULL,
  `acopio` char(1) NOT NULL,
  `idajusteap` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcompacop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `mateacopio` (
  `idmateacopio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(100) NOT NULL,
  `unidad` char(10) NOT NULL,
  `articulo` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`idmateacopio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `mateacopiop` (
  `idmateacop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(100) NOT NULL,
  `unidad` char(10) NOT NULL,
  PRIMARY KEY (`idmateacop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `rscconceptos` (
  `idrscc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `servicio` int(10) unsigned NOT NULL,
  `idcateser` int(10) unsigned NOT NULL,
  `idconcepto` int(10) unsigned NOT NULL,
  `cantidad` double(13,2) NOT NULL,
  PRIMARY KEY (`idrscc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `histosaldoent` (
  `idhisalent` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tablaaso` char(100) NOT NULL,
  `idregaso` int(10) unsigned NOT NULL,
  `fecha` char(8) NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  `total` double(13,4) NOT NULL,
  `imputado` double(13,4) NOT NULL,
  `saldo` double(13,4) NOT NULL,
  `puntov` char(5) NOT NULL,
  `abrevia` char(10) NOT NULL,
  `comproba` char(100) NOT NULL,
  `tipo` char(10) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `opera` int(11) NOT NULL,
  PRIMARY KEY (`idhisalent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `ajustestockh` MODIFY COLUMN `lotevto` CHAR(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT ' ';

ALTER TABLE `anularp` ADD COLUMN `entidad` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `timestamp`;


ALTER TABLE `articulos` ADD INDEX `linea`(`linea`), ADD INDEX `idsublinea`(`idsublinea`);
ALTER TABLE `asientos` ADD INDEX `fecha`(`fecha`);
ALTER TABLE `cajamovios` MODIFY COLUMN `saldo` DOUBLE(13,2) NOT NULL DEFAULT 0.00;
ALTER TABLE `cbasociadas` ADD INDEX `Index_4`(`cuit`);
ALTER TABLE `cbcomprobantes` ADD INDEX `Index_3`(`entidad`), ADD INDEX `Index_4`(`servicio`), ADD INDEX `Index_5`(`cuenta`), ADD INDEX `Index_6`(`bc`),
 ADD INDEX `Index_7`(`descrip`), ADD INDEX `Index_8`(`lote`), ADD INDEX `Index_9`(`idcbasoci`);
ALTER TABLE `comprotipo` MODIFY COLUMN `detalle` CHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL;
ALTER TABLE `entidades` ADD INDEX `iva`(`iva`),  ADD INDEX `tipodoc`(`tipodoc`);
ALTER TABLE `entidadesa` MODIFY COLUMN `identa` INTEGER UNSIGNED NOT NULL DEFAULT NULL AUTO_INCREMENT,  MODIFY COLUMN `entidad` INTEGER UNSIGNED DEFAULT NULL,
 MODIFY COLUMN `idconcepto` INTEGER UNSIGNED DEFAULT NULL;
ALTER TABLE `estadosreg` ADD INDEX `idestador`(`idestador`);
ALTER TABLE `etiquetas` ADD INDEX `tabla`(`tabla`), ADD INDEX `campo`(`campo`), ADD INDEX `codigo`(`codigo`), ADD INDEX `articulo`(`articulo`), ADD INDEX `idregistro`(`idregistro`);
ALTER TABLE `facturas` ADD INDEX `fecha`(`fecha`);









--Inserciones--

insert into funcionesimp values ('PER_IIBB_ARBA_IFN', 'Función para el cálculo de Percepciones de IIBB', 'PERCEPCIONES'),
('RET_GANANCIAS_IFN', 'Función para el cálculo de Retenciones de Ganancias', 'RETENCIONES'),
('RET_IIBB_ARBA_IFN', 'Función para el cálculo de Retenciones de Ingresos Brutos Prov. Bs. As.', 'RETENCIONES'),
('RET_IIBB_STAFE_IFN', 'Función para el cálculo de Retenciones de Ingresos Brutos Santa Fe', 'RETENCIONES');



--20250531--

CREATE VIEW `remitopendfact` AS
select `h`.`idremitoh`,`h`.`idremito` AS `idremito`,`h`.`articulo` AS `articulo`,`h`.`cantidad` AS `cantrem`,sum(ifnull(`d`.`cantidad`,0.00)) AS `cantfact`, (`h`.`cantidad` - sum(ifnull(`d`.`cantidad`,0.00))) AS `pendfact` from ((`remitosh` `h` left join `linkregistro` `l` on(((`l`.`tablab` = 'remitosh') and (`l`.`idb` = `h`.`idremitoh`)))) left join `detafactu` `d` on(((`l`.`tablaa` = 'detafactu') and (`d`.`idfacturah` = `l`.`ida`)))) group by `h`.`idremito`,`h`.`articulo`;

CREATE VIEW `facturapendrem` AS 
select `d`.`idfacturah`,`d`.`idfactura` AS `idfactura`,`d`.`articulo` AS `articulo`,`d`.`cantidad` AS `cantfact`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantrem`,(`d`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendrem` from ((`detafactu` `d` left join `linkregistro` `l` on(((`l`.`tablab` = 'detafactu') and (`l`.`idb` = `d`.`idfacturah`)))) left join `remitosh` `h` on(((`l`.`tablaa` = 'remitosh') and (`h`.`idremitoh` = `l`.`ida`)))) group by `d`.`idfacturah`,`d`.`articulo`;



-- 20250531 --
-- Tabla para manejo de Agenda y Observaciones Varias en Registros 

CREATE TABLE `agendadeta` (
  `idagenda` INT NOT NULL AUTO_INCREMENT,
  `tabla` CHAR(50) NULL,
  `idregistro` CHAR(20) NULL,
  `tipo` CHAR(1) NULL,
  `fecha` CHAR(8) NULL,
  `hora` CHAR(8) NULL,
  `detalle` TEXT NULL,
  `calendario` CHAR(1) NULL,
  `fagendad` CHAR(8) NULL,
  `hagendad` CHAR(8) NULL,
  `fagendah` CHAR(8) NULL,
  `hagendah` CHAR(8) NULL,
  `usuario` CHAR(20) NULL,
  `detallereg` CHAR(200) NULL,
  PRIMARY KEY (`idagenda`));


-- 20250630 --
--Vistas

--esquema: `processar_horlit`

DROP VIEW IF EXISTS `depostock`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stocktot`,0) AS `stocktot`,
sum(if(`t`.`ie` = 'I',1,if(`t`.`ie` = 'E',-1,0)) * `a`.`cantidad`) AS `stock`,`m`.`stockmin` AS `stockmin`,
ifnull(`p`.`pendiente`,0) AS `pendiente`, ifnull(`f`.`pendrem`,0) as `pendienter`, ifnull(`r`.`pendfact`,0) as `pendientef`
from ((((`ajustestockh` `a` left join `tipomstock` `t` on(`a`.`idtipomov` = `t`.`idtipomov`))
left join `articulos` `m` on(`a`.`articulo` = `m`.`articulo`)) left join `articulostock` `u` on(`a`.`articulo` = `u`.`articulo`))
left join `artpendiente` `p` on(convert(`a`.`articulo` using utf8mb3) = convert(`p`.`articulo` using utf8mb3) and `p`.`idmate` = 0))
left join (SELECT articulo,sum(pendrem) as pendrem FROM facturapendrem group by articulo) `f`  on(convert(`a`.`articulo` using utf8mb3) = convert(`f`.`articulo` using utf8mb3))
left join (SELECT articulo,sum(pendfact) as pendfact FROM remitopendfact group by articulo) `r` on(convert(`a`.`articulo` using utf8mb3) = convert(`r`.`articulo` using utf8mb3))
where !(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where `a`.`tabla` = 'ajustestockh' and `a`.`idestador` = 2))
group by `a`.`deposito`,`a`.`articulo`;





---- OTRA VISTA SIMILAR A LA ANTERIOR PERO USANDO VISTAS AUXILIRIARES EN VEZ DE SUB CONSULTAS ---


CREATE VIEW `factpendremaux` AS
  select `facturapendrem`.`articulo` AS `articulo`,sum(`facturapendrem`.`pendrem`) AS `pendrem` from `facturapendrem` group by `facturapendrem`.`articulo`;
  
  
CREATE VIEW `remitopendfactaux` AS
select `remitopendfact`.`articulo` AS `articulo`,sum(`remitopendfact`.`pendfact`) AS `pendfact` from `remitopendfact` group by `remitopendfact`.`articulo`;


-- Crear vista 
CREATE VIEW `depostock` AS
  select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stocktot`,0) AS `stocktot`,sum(if(`t`.`ie` = 'I',1,if(`t`.`ie` = 'E',-1,0)) * `a`.`cantidad`) AS `stock`,`m`.`stockmin` AS `stockmin`,ifnull(`p`.`pendiente`,0) AS `pendiente`,ifnull(`f`.`pendrem`,0) AS `pendienter`,ifnull(`r`.`pendfact`,0) AS `pendientef` from ((((((`ajustestockh` `a` left join `tipomstock` `t` on(`a`.`idtipomov` = `t`.`idtipomov`)) left join `articulos` `m` on(`a`.`articulo` = `m`.`articulo`)) left join `articulostock` `u` on(`a`.`articulo` = `u`.`articulo`)) left join `artpendiente` `p` on(convert(`a`.`articulo` using utf8mb3) = convert(`p`.`articulo` using utf8mb3) and `p`.`idmate` = 0)) left join `factpendremaux` `f` on(convert(`a`.`articulo` using utf8mb3) = convert(`f`.`articulo` using utf8mb3))) left join `remitopendfactaux`  `r` on(convert(`a`.`articulo` using utf8mb3) = convert(`r`.`articulo` using utf8mb3))) where !(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where `a`.`tabla` = 'ajustestockh' and `a`.`idestador` = 2)) group by `a`.`deposito`,`a`.`articulo`;
  
 -- 
  DROP VIEW IF EXISTS `depostock`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stocktot`,0) AS `stocktot`,sum(if(`t`.`ie` = 'I',1,if(`t`.`ie` = 'E',-1,0)) * `a`.`cantidad`) AS `stock`,`m`.`stockmin` AS `stockmin`,ifnull(`p`.`pendiente`,0) AS `pendiente`,ifnull(`f`.`pendrem`,0) AS `pendienter`,ifnull(`r`.`pendfact`,0) AS `pendientef` from ((((((`ajustestockh` `a` left join `tipomstock` `t` on(`a`.`idtipomov` = `t`.`idtipomov`)) left join `articulos` `m` on(`a`.`articulo` = `m`.`articulo`)) left join `articulostock` `u` on(`a`.`articulo` = `u`.`articulo`)) left join `artpendiente` `p` on(convert(`a`.`articulo` using utf8mb3) = convert(`p`.`articulo` using utf8mb3) and `p`.`idmate` = 0)) left join `factpendremaux` `f` on(convert(`a`.`articulo` using utf8mb3) = convert(`f`.`articulo` using utf8mb3))) left join `remitopendfactaux`  `r` on(convert(`a`.`articulo` using utf8mb3) = convert(`r`.`articulo` using utf8mb3))) where !(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where `a`.`tabla` = 'ajustestockh' and `a`.`idestador` = 2)) group by `a`.`deposito`,`a`.`articulo`;

--procedimientos:

DELIMITER $$

DROP PROCEDURE IF EXISTS `p_depostock` $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_depostock`(in pdeposito int, in particulo char(50))
BEGIN

    set @vnombreart  := ' ' ;
    set @vstocktot   := 0.00 ;
    set @vstock      := 0.00 ;
    set @vstockmin   := 0.00 ;
    set @vpendiente  := 0.00 ;
    set @vpendienter := 0.00 ;
    set @vpendientef := 0.00 ;

    select `m`.`detalle` ,ifnull(`u`.`stocktot`,0) , sum((if((`t`.`ie` = 'I'),1,if((`t`.`ie` = 'E'),-(1),0)) * `a`.`cantidad`)) ,`m`.`stockmin`, ifnull(`p`.`pendiente`,0), ifnull(`f`.`pendrem`,0) as `pendienter`, ifnull(`r`.`pendfact`,0) as `pendientef`
    into @vnombreart, @vstocktot, @vstock, @vstockmin, @vpendiente, @vpendienter, @vpendientef
    from ((((`ajustestockh` `a` left join `tipomstock` `t` on((`a`.`idtipomov` = `t`.`idtipomov`)))
    left join `articulos` `m` on((`a`.`articulo` = `m`.`articulo`))) left join `r_articulostock` `u` on((`a`.`articulo` = `u`.`articulo`)))
    left join `r_artpendiente` `p` on((`a`.`articulo` = `p`.`articulo` and `p`.`idmate` = 0)))
    left join (SELECT articulo,sum(pendrem) as pendrem FROM facturapendrem group by articulo) `f`  on(convert(`a`.`articulo` using utf8mb3) = convert(`f`.`articulo` using utf8mb3))
    left join (SELECT articulo,sum(pendfact) as pendfact FROM remitopendfact group by articulo) `r` on(convert(`a`.`articulo` using utf8mb3) = convert(`r`.`articulo` using utf8mb3))
    where `a`.`deposito` = pdeposito and `a`.`articulo`= particulo and (not(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a`
    where ((`a`.`tabla` = 'ajustestockh') and (`a`.`idestador` = 2))))) group by `a`.`deposito`,`a`.`articulo`;


     delete from r_depostock where deposito = pdeposito and articulo = particulo;
     insert into r_depostock values (pdeposito, particulo, @vnombreart, @vstocktot, @vstock, @vstockmin, @vpendiente,@vpendienter,@vpendientef ) ;

END $$

DELIMITER ;










--*********************************************
--esquema: `processar_horlit_b`

DROP VIEW IF EXISTS `depostock`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`processaradmin`@`%` SQL SECURITY DEFINER VIEW `depostock` AS select `a`.`deposito` AS `deposito`,`a`.`articulo` AS `articulo`,`m`.`detalle` AS `nombreart`,ifnull(`u`.`stocktot`,0) AS `stocktot`,
sum(if(`t`.`ie` = 'I',1,if(`t`.`ie` = 'E',-1,0)) * `a`.`cantidad`) AS `stock`,`m`.`stockmin` AS `stockmin`,
ifnull(`p`.`pendiente`,0) AS `pendiente`, ifnull(`f`.`pendrem`,0) as `pendienter`, ifnull(`r`.`pendfact`,0) as `pendientef`
from ((((`ajustestockh` `a` left join `tipomstock` `t` on(`a`.`idtipomov` = `t`.`idtipomov`))
left join `articulos` `m` on(`a`.`articulo` = `m`.`articulo`)) left join `articulostock` `u` on(`a`.`articulo` = `u`.`articulo`))
left join `artpendiente` `p` on(convert(`a`.`articulo` using utf8mb3) = convert(`p`.`articulo` using utf8mb3) and `p`.`idmate` = 0))
left join (SELECT articulo,sum(pendrem) as pendrem FROM facturapendrem group by articulo) `f`  on(convert(`a`.`articulo` using utf8mb3) = convert(`f`.`articulo` using utf8mb3))
left join (SELECT articulo,sum(pendfact) as pendfact FROM remitopendfact group by articulo) `r` on(convert(`a`.`articulo` using utf8mb3) = convert(`r`.`articulo` using utf8mb3))
where !(`a`.`idajusteh` in (select `a`.`id` from `ultimoestado` `a` where `a`.`tabla` = 'ajustestockh' and `a`.`idestador` = 2))
group by `a`.`deposito`,`a`.`articulo`;




procedimientos:



DELIMITER $$

DROP PROCEDURE IF EXISTS `p_artpendiente` $$
CREATE DEFINER=`processaradmin`@`%` PROCEDURE `p_artpendiente`(in particulo char(50))
BEGIN
    set @vcantidad    := 0.00 ;
    set @vcantcump    := 0.00 ;
    set @vpendiente   := 0.00 ;
    set @vidmate      := 0 ;


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



    select `o`.`idmate`, sum(`o`.`cantidad`), sum(`o`.`cantcump`), sum(`o`.`pendiente`) into @vidmate, @vcantidad, @vcantcump, @vpendiente
    from `r_otpendientes` `o` where  `o`.`articulo` = particulo and `o`.`idmate` > 0 ;


    delete from r_artpendiente where articulo = particulo  and idmate > 0;
    if isnull(@vidmate) <> true then
      insert into r_artpendiente values (particulo, @vidmate , @vcantidad, @vcantcump, @vpendiente);
    end if ;

END $$

DELIMITER ;


-- 20250712
-- Agregado de Tabla para Tipificar y Clasificar articulostock`
CREATE TABLE `tipologias` (
  `idtp` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `idp`  INTEGER UNSIGNED NOT NULL, 
  `codigo` CHAR(20) NOT NULL,
  `nombre` CHAR(150) NOT NULL,
  `articulo` CHAR(20) NOT NULL,
  `nivel` CHAR(1) NOT NULL,
  `cantidad` FLOAT(13,2) NOT NULL,
  PRIMARY KEY (`idtp`)
)
ENGINE = InnoDB;




--- Correcciones vistas --

-- Vista: remitospendfactax --

DROP VIEW IF EXISTS `remitospendfactax`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `remitospendfactax` AS 
select `h`.`idremitoh` AS `idremitoh`,`h`.`idremito` AS `idremito`,`h`.`articulo` AS `articulo`,`h`.`cantidad` AS `cantrem`,
sum(ifnull(`d`.`cantidad`,0.00)) AS `cantfact`,(`h`.`cantidad` - sum(ifnull(`d`.`cantidad`,0.00))) AS `pendfact` 
from (((`remitosh` `h` left join `linkregistro` `l` on(((`l`.`tablab` = 'remitosh') and (`l`.`idb` = `h`.`idremitoh`)))) 
left join `ultimoestado` `u` on(((`u`.`tabla` = 'remitos') and (`u`.`campo` = 'idremito') and (`h`.`idremito` = `u`.`id`)))) 
left join `detafactu` `d` on(((`l`.`tablaa` = 'detafactu') and (`d`.`idfacturah` = `l`.`ida`)))) 
where (`u`.`idestador` <> 2) group by `h`.`idremito`,`h`.`articulo` 
union 
select `h`.`idremitoh` AS `idremitoh`,`h`.`idremito` AS `idremito`,`h`.`articulo` AS `articulo`,`h`.`cantidad` AS `cantrem`,
sum(ifnull(`d`.`cantidad`,0.00)) AS `cantfact`,(`h`.`cantidad` - sum(ifnull(`d`.`cantidad`,0.00))) AS `pendfact` 
from (((`remitosh` `h` left join `linkregistro` `l` on(((`l`.`tablaa` = 'remitosh') and (`l`.`ida` = `h`.`idremitoh`)))) 
left join `ultimoestado` `u` on(((`u`.`tabla` = 'remitos') and (`u`.`campo` = 'idremito') and (`h`.`idremito` = `u`.`id`)))) 
left join `detafactu` `d` on(((`l`.`tablab` = 'detafactu') and (`d`.`idfacturah` = `l`.`idb`)))) 
where (`u`.`idestador` <> 2) group by `h`.`idremito`,`h`.`articulo`;


-- Vista: remitopendfactaux

DROP VIEW IF EXISTS `remitopendfactaux`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `remitopendfactaux` AS select `remitopendfact`.`articulo` AS `articulo`,sum(`remitopendfact`.`pendfact`) AS `pendfact` from (`remitopendfact` left join `ultimoestado` `u` on(((`u`.`tabla` = 'remitos') and (`u`.`campo` = 'idremito') and (`u`.`id` = `remitopendfact`.`idremito`)))) where (`u`.`idestador` <> 2) group by `remitopendfact`.`articulo`;




-- Vista: facturaspendremax


DROP VIEW IF EXISTS `facturaspendremax`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `facturaspendremax` AS select `d`.`idfacturah` AS `idfacturah`,`d`.`idfactura` AS `idfactura`,`d`.`articulo` AS `articulo`,`d`.`cantidad` AS `cantfact`,
sum(ifnull(`h`.`cantidad`,0.00)) AS `cantrem`,(`d`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendrem`
from (((`detafactu` `d` left join `linkregistro` `l` on(((`l`.`tablab` = 'detafactu') and (`l`.`idb` = `d`.`idfacturah`))))
left join `remitosh` `h` on(((`l`.`tablaa` = 'remitosh') and (`h`.`idremitoh` = `l`.`ida`))))
left join `facturas` `f` on((`f`.`idfactura` = `d`.`idfactura`)))
left join comprobantes c on f.idcomproba = c.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro
where (`f`.`stock` = 'N')  and t.comprotipo = 'FC'
group by `d`.`idfacturah`,`d`.`articulo`
union
select `d`.`idfacturah` AS `idfacturah`,`d`.`idfactura` AS `idfactura`,`d`.`articulo` AS `articulo`,`d`.`cantidad` AS `cantfact`,
sum(ifnull(`h`.`cantidad`,0.00)) AS `cantrem`,(`d`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))) AS `pendrem`
from (((`detafactu` `d` left join `linkregistro` `l` on(((`l`.`tablaa` = 'detafactu') and (`l`.`ida` = `d`.`idfacturah`))))
left join `remitosh` `h` on(((`l`.`tablab` = 'remitosh') and (`h`.`idremitoh` = `l`.`idb`))))
left join `facturas` `f` on((`f`.`idfactura` = `d`.`idfactura`)))
left join comprobantes c on f.idcomproba = c.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro
where (`f`.`stock` = 'N')  and t.comprotipo = 'FC'
group by `d`.`idfacturah`,`d`.`articulo`;



ALTER TABLE `remitos` ADD COLUMN `entidadaso` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `timestamp`;


-- Correcciones para unidad de facturación --

DROP VIEW IF EXISTS `otpendientes`;
 CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`tulior`@`%` SQL SECURITY DEFINER VIEW `otpendientes` AS select `o`.`idot` AS `idot`,`o`.`articulo` AS `articulo`,`o`.`idmate` AS `idmate`,`o`.`cantidad` AS `cantidad`,sum(ifnull(`h`.`cantidad`,0.00)) AS `cantcump`,`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00)) AS `pendiente`,sum(ifnull(`h`.`cantidaduf`,0.00)) AS `cantcumpuf` from (`ot` `o` left join `cumplimentah` `h` on(`o`.`idot` = `h`.`idot`)) group by `o`.`idot`;
 
 DELIMITER $$

DROP PROCEDURE IF EXISTS `p_otpendientes` $$
CREATE DEFINER=`tulior`@`%` PROCEDURE `p_otpendientes`(in pidot int)
BEGIN

    set @varticulo    := ' ' ;
    set @vcantidad    := 0.00 ;
    set @vcantcump    := 0.00 ;
    set @vpendiente   := 0.00 ;
    set @vidmate      := 0;
    set @vcantcumpfc  := 0.00;

    select `o`.`articulo`,`o`.`idmate` ,`o`.`cantidad` ,sum(ifnull(`h`.`cantidad`,0.00)), (`o`.`cantidad` - sum(ifnull(`h`.`cantidad`,0.00))), (`o`.`cantidadfc` - sum(ifnull(`h`.`cantidaduf`,0.00)))
    into @varticulo, @vidmate, @vcantidad, @vcantcump, @vpendiente,@vcantcumpfc
    from (`ot` `o` left join `cumplimentah` `h` on((`o`.`idot` = `h`.`idot`))) where `o`.`idot` = pidot ;


    delete from r_otpendientes where idot = pidot ;
    if @vcantidad <> 0 or @vcantcumpfc <> 0 then
        insert into r_otpendientes values (pidot, @varticulo, @vidmate, @vcantidad, @vcantcump, @vpendiente,@vcantcumpfc);
    end if ;

END $$

DELIMITER ;


-- Tabla formulariosfn --
DROP TABLE IF EXISTS `formulariosfn`;
CREATE TABLE  `formulariosfn` (
  `idformulario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `claveform` char(100) CHARACTER SET ucs2 COLLATE ucs2_general_ci NOT NULL,
  `formulario` char(100) NOT NULL,
  PRIMARY KEY (`idformulario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


insert into formulariosfn values (1, 'remitos', 'remitos'),
(2, 'cumplimentacion', 'cumplimentacion'),
(3, 'facturas', 'facturas'),
(4, 'np', 'np'),
(6, 'recibos', 'recibos'),
(8, 'facturasprov', 'facturasprov'),
(9, 'cajaie', 'cajaie'),
(10, 'transfecajas', 'transfecajas'),
(11, 'costos', 'costos'),
(12, 'cumpleoc', 'cumpleoc'),
(13, 'oc', 'oc'),
(14, 'pagares', 'pagares'),
(15, 'pagosprov', 'pagosprov'),
(16, 'presupuesto', 'presupuesto'),
(17, 'transferencia', 'transferencia');




-- Clasificación de NP --




--- ACTUALIZACION HORLIT DESDE ACÁ (20260806) ---


CREATE TABLE  `clasnpcomp` (
  `idclasnpco` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idclasifnp` int(10) unsigned NOT NULL,
  `idcompactiv` int(10) unsigned NOT NULL,
  `idclasifop` int(10) unsigned NOT NULL,
  `valor` char(50) NOT NULL,
  PRIMARY KEY (`idclasnpco`),
  KEY `Index_2` (`idclasifnp`),
  KEY `Index_3` (`idcompactiv`),
  KEY `Index_4` (`idclasifop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE  `clasifopera` (
  `idclasifop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` char(50) NOT NULL,
  `descrip` char(250) NOT NULL,
  PRIMARY KEY (`idclasifop`),
  KEY `Index_2` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE  `clasificanp` (
  `idclasifnp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` char(100) NOT NULL,
  `descrip` char(250) NOT NULL,
  PRIMARY KEY (`idclasifnp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `np` ADD COLUMN `idetiqueta` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `fechaentre`,
 ADD COLUMN `idclasifnp` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `idetiqueta`,
 ADD INDEX `idetiqueta`(`idetiqueta`),
 ADD INDEX `idclasifnp`(`idclasifnp`);



--20250811--

ALTER TABLE `agendadeta` ADD COLUMN `infotodos` CHAR(1) NOT NULL DEFAULT 'N' AFTER `detallereg`, ADD COLUMN `repetir` CHAR(1) NOT NULL DEFAULT 'N' AFTER `infotodos`;
 
ALTER TABLE `ajustesacopio` MODIFY COLUMN `monto` DOUBLE(13,4) NOT NULL;

ALTER TABLE `ajustesacopiop` MODIFY COLUMN `monto` DOUBLE(13,4) NOT NULL;

ALTER TABLE `compacopio` MODIFY COLUMN `importe` DOUBLE(13,4) NOT NULL;

ALTER TABLE `compacopiop` MODIFY COLUMN `importe` DOUBLE(13,4) NOT NULL;

 ALTER TABLE `ejercicioecon` ADD COLUMN `ctaresulta` CHAR(20) NOT NULL AFTER `idejerci`;
 
ALTER TABLE `facturasbsertmp` ADD COLUMN `consumo` DOUBLE(13,2) NOT NULL AFTER `idtiposer`,
 ADD COLUMN `mactual` DOUBLE(13,2) NOT NULL AFTER `consumo`,
 ADD COLUMN `manterior` DOUBLE(13,2) NOT NULL AFTER `mactual`,
 ADD COLUMN `consextra` DOUBLE(13,2) NOT NULL DEFAULT 0.00 AFTER `manterior`,
 ADD COLUMN `unidadref` CHAR(10) NOT NULL AFTER `consextra`,
 ADD COLUMN `valorref` DOUBLE(13,2) NOT NULL AFTER `unidadref`,
 ADD COLUMN `idcateser` INTEGER UNSIGNED NOT NULL DEFAULT 1 AFTER `valorref`,
 ADD COLUMN `factorm` DOUBLE(13,2) NOT NULL DEFAULT 1.00 AFTER `idcateser`,
 ADD COLUMN `dataextra` CHAR(254) NOT NULL AFTER `factorm`;
 

--20250814--

ALTER TABLE `remitos` ADD COLUMN `cai` CHAR(100) NOT NULL DEFAULT ' ' AFTER `entidadaso`,  ADD COLUMN `caiven` CHAR(8) NOT NULL DEFAULT ' ' AFTER `cai`;

ALTER TABLE `compactiv` ADD COLUMN `cai` CHAR(100) NOT NULL DEFAULT ' ' AFTER `idcompactiv`, ADD COLUMN `nromax` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `cai`;


--20250904--
ALTER TABLE `impuretencion` ADD COLUMN `divimporte` DOUBLE(12,4) NOT NULL DEFAULT 1.21 AFTER `regimen`;

ALTER TABLE `impupercepcion` ADD COLUMN `divimporte` DOUBLE(12,4) NOT NULL DEFAULT 1.21 AFTER `idconcepto`;

--20251014--
ALTER TABLE `detafactu` ADD INDEX `idfactura`(`idfactura`), ADD INDEX `articulo`(`articulo`), ADD INDEX `impuesto`(`impuesto`);

ALTER TABLE `sectorcomp` ADD COLUMN `stock` CHAR(1) NOT NULL DEFAULT 'N' AFTER `idcomproba`;


--20251217--
CREATE TABLE `compcai` (
  `idcompcai` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `idcompactiv` INTEGER UNSIGNED NOT NULL,
  `cai` CHAR(100) NOT NULL,
  `nromin` INTEGER UNSIGNED NOT NULL,
  `nromax` INTEGER UNSIGNED NOT NULL,
  `vtocai` CHAR(8) NOT NULL,
  PRIMARY KEY (`idcompcai`)
)
ENGINE = InnoDB;


ALTER TABLE `compcai` ADD INDEX `idcompactiv`(`idcompactiv`);

ALTER TABLE `compactiv` ADD INDEX `idcomproba`(`idcomproba`), ADD INDEX `pventa`(`pventa`);


ALTER TABLE `remitos` MODIFY COLUMN `cai` CHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT ' ',
 MODIFY COLUMN `caiven` CHAR(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT ' ';

--20260416--

CREATE TABLE  `tipoctamail` (
  `idtipocm` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` char(100) NOT NULL,
  PRIMARY KEY (`idtipocm`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

insert into tipoctamail values (1, 'PARTICULAR'),
(2, 'DIFUSION INFORMACION'),
(3, 'DIFUSION FACTURACION');



ALTER TABLE `correoconf` ADD COLUMN `idtipocm` int(10) unsigned  NOT NULL DEFAULT 1 AFTER `smtpusessl`;


CREATE TABLE `cajaiecc` (
  `idcajaiecc` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `idcentroc` INTEGER UNSIGNED NOT NULL,
  `razon` DOUBLE(13,2) NOT NULL,
  PRIMARY KEY (`idcajaiecc`)
)
ENGINE = InnoDB;


CREATE TABLE `maillog` (
  `idmaillog` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `idmailestado` INTEGER UNSIGNED NOT NULL,
  `idmailfn` INTEGER UNSIGNED NOT NULL,
  `entidad` INTEGER UNSIGNED NOT NULL,
  `detalle` CHAR(100) NOT NULL,
  `email` CHAR(100) NOT NULL,
  `observa` CHAR(250) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`idmaillog`),
  INDEX `idmailestado`(`idmailestado`),
  INDEX `idmailfn`(`idmailfn`),
  INDEX `entidad`(`entidad`)
)
ENGINE = InnoDB;


CREATE TABLE  `mailestado` (
  `idmailestado` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `estado` char(50) NOT NULL,
  PRIMARY KEY (`idmailestado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

insert into mailestado values (1, 'PENDIENTE'),
(2, 'ENVIADO'),
(3, 'ERROR'),
(4, 'SIN_CORREO');



CREATE TABLE `mailfuncion` (
  `idmailfn` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `funcion` CHAR(50) NOT NULL,
  `descip` CHAR(250) NOT NULL,
  PRIMARY KEY (`idmailfn`)
)
ENGINE = InnoDB;

insert into mailfuncion values (1, 'ENVIOCOMPROBANTES', 'Función de envío de compobantes');


CREATE TABLE `mailentcomp` (
  `idmentcomp` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `idcomproba` INTEGER UNSIGNED NOT NULL,
  `entidad` INTEGER UNSIGNED NOT NULL,
  `idfnmail` INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (`idmentcomp`),
  INDEX `idcomproba`(`idcomproba`),
  INDEX `entidad`(`entidad`),
  INDEX `idfnmail`(`idfnmail`)
)
ENGINE = InnoDB;

CREATE TABLE  `mailcomp` (
  `idmailcomp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idmaillog` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmailcomp`),
  KEY `idcomproba` (`idcomproba`),
  KEY `idmaillog` (`idmaillog`),
  KEY `idregistro` (`idregistro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 20260526--
---CONTROLAR LOS ID COMPROBAS ---
insert into mailentcomp select 0 as identcomp, 7 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 8 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 10 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 11 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 12 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 24 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 32 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 33 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 34 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 35 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 36 as idcomproba, entidad, 1 as idfnmail from entidades;
insert into mailentcomp select 0 as identcomp, 14 as idcomproba, entidad, 1 as idfnmail from entidades;




--- 20260528 ---

ALTER TABLE `r_artpendiente` ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idmate`(`idmate`);


ALTER TABLE `r_articulostock` ADD INDEX `articulo`(`articulo`);


ALTER TABLE `ajustestockh` ADD INDEX `idtipomov`(`idtipomov`);

ALTER TABLE `r_artocdpendiente` ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idmate`(`idmate`);

ALTER TABLE `r_bancosaldos` ADD INDEX `idtipocta`(`idtipocta`),
 ADD INDEX `idbanco`(`idbanco`);


ALTER TABLE `r_ccb_cajaingreso` ADD INDEX `iddetacobro`(`iddetacobro`),
 ADD INDEX `idregistro`(`idregistro`),
 ADD INDEX `idtipopago`(`idtipopago`),
 ADD INDEX `pventa`(`pventa`),
 ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `entidad`(`entidad`),
 ADD INDEX `idtipocomp`(`idtipocomp`),
 ADD INDEX `chnumero`(`chnumero`),
 ADD INDEX `idcupon`(`idcupon`),
 ADD INDEX `idtarjeta`(`idtarjeta`);

ALTER TABLE `r_ccb_pagosprov` ADD INDEX `iddetapago`(`iddetapago`),
 ADD INDEX `idregistro`(`idregistro`),
 ADD INDEX `idtipopago`(`idtipopago`),
 ADD INDEX `pventa`(`pventa`),
 ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `numero`(`numero`),
 ADD INDEX `entidad`(`entidad`),
 ADD INDEX `idtipocomp`(`idtipocomp`),
 ADD INDEX `idregiclk`(`idregiclk`),
 ADD INDEX `idcheque`(`idcheque`),
 ADD INDEX `chnumero`(`chnumero`),
 ADD INDEX `idcupon`(`idcupon`);

ALTER TABLE `r_ccb_recibos` ADD INDEX `iddetacobro`(`iddetacobro`),
 ADD INDEX `idregistro`(`idregistro`),
 ADD INDEX `idtipopago`(`idtipopago`),
 ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `pventa`(`pventa`),
 ADD INDEX `entidad`(`entidad`),
 ADD INDEX `idtipocomp`(`idtipocomp`),
 ADD INDEX `idregiclk`(`idregiclk`),
 ADD INDEX `idcheque`(`idcheque`),
 ADD INDEX `chnumero`(`chnumero`),
 ADD INDEX `idcupon`(`idcupon`),
 ADD INDEX `idtarjeta`(`idtarjeta`);

ALTER TABLE `r_gruposall` ADD INDEX `idmiembro`(`idmiembro`),
 ADD INDEX `idgrupo`(`idgrupo`),
 ADD INDEX `nombreg`(`nombreg`),
 ADD INDEX `idtipogrup`(`idtipogrup`),
 ADD INDEX `codarbol`(`codarbol`),
 ADD INDEX `codpadre`(`codpadre`);

ALTER TABLE `r_listaprea` ADD INDEX `idlista`(`idlista`),
 ADD INDEX `idlistap`(`idlistap`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `linea`(`linea`),
 ADD INDEX `idsublinea`(`idsublinea`);

ALTER TABLE `r_otpendientes` ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idmate`(`idmate`);

ALTER TABLE `r_otpendientesec` ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idmate`(`idmate`);

ALTER TABLE `r_recibossaldo` ADD INDEX `idcomproba`(`idcomproba`);

ALTER TABLE `facturas` ADD COLUMN `entidadaso` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `idfinancia`;

ALTER TABLE `facturas` ADD INDEX `entidadaso`(`entidadaso`);


-- 20260601 --
ALTER TABLE `mailfuncion` ADD INDEX `funcion`(`funcion`);
ALTER TABLE `maillog` MODIFY COLUMN `timestamp` DATETIME NOT NULL DEFAULT current_timestamp();


ALTER TABLE `linkcompro` ADD INDEX `idcomprobaa`(`idcomprobaa`),
 ADD INDEX `idregistroa`(`idregistroa`),
 ADD INDEX `idcomprobab`(`idcomprobab`),
 ADD INDEX `idregistrob`(`idregistrob`);


-- 20260725 --

ALTER TABLE `comprobantes` ADD INDEX `idtipocompro`(`idtipocompro`),
 ADD INDEX `tabla`(`tabla`);


ALTER TABLE `cajarecaudah` ADD INDEX `idcajareca`(`idcajareca`);

ALTER TABLE `compactiv` ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `pventa`(`pventa`);


ALTER TABLE `entidades` ADD INDEX `localidad`(`localidad`);
ALTER TABLE `entidades` ADD INDEX `idtipocli`(`idtipocli`),
 ADD INDEX `idafiptipod`(`idafiptipod`),
 ADD INDEX `idlistadef`(`idlistadef`);


ALTER TABLE `localidades` ADD INDEX `provincia`(`provincia`);


ALTER TABLE `provincias` ADD INDEX `pais`(`pais`);

ALTER TABLE `detafactu` ADD INDEX `idfactura`(`idfactura`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idconcepto`(`idconcepto`),
 ADD INDEX `impuesto`(`impuesto`),
 ADD INDEX `idcuotasd`(`idcuotasd`);


ALTER TABLE `np` ADD INDEX `vendedor`(`vendedor`),
 ADD INDEX `transporte`(`transporte`),
 ADD INDEX `sector`(`sector`),
 ADD INDEX `idtiponp`(`idtiponp`),
 ADD INDEX `pventa`(`pventa`);


ALTER TABLE `ot` ADD INDEX `idnp`(`idnp`),
 ADD INDEX `idtipoot`(`idtipoot`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idmate`(`idmate`),
 ADD INDEX `impuesto`(`impuesto`),
 ADD INDEX `idtiponp`(`idtiponp`);



ALTER TABLE `presupu` ADD INDEX `sector`(`sector`),
 ADD INDEX `vendedor`(`vendedor`),
 ADD INDEX `idtiponp`(`vendedor`);

ALTER TABLE `presupuh` ADD INDEX `idpresupu`(`idpresupu`),
 ADD INDEX `idtipoot`(`idtipoot`),
 ADD INDEX `articulo`(`articulo`);


ALTER TABLE `anularp` ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `pventa`(`pventa`),
 ADD INDEX `idrecibo`(`idrecibo`),
 ADD INDEX `idpago`(`idpago`),
 ADD INDEX `entidad`(`entidad`);


ALTER TABLE `oc` ADD INDEX `pventa`(`pventa`),
 ADD INDEX `idtiponp`(`idtiponp`);


ALTER TABLE `ocd` ADD INDEX `idoc`(`idoc`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idmate`(`idmate`),
 ADD INDEX `idtiponp`(`idtiponp`);


ALTER TABLE `recibos` ADD INDEX `pventa`(`pventa`);


ALTER TABLE `retenciones` ADD INDEX `pventa`(`pventa`),
 ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `entidad`(`entidad`);


ALTER TABLE `cumplimentap` ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `pventa`(`pventa`);



ALTER TABLE `cumplimentah` ADD INDEX `idcump`(`idcump`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idot`(`idot`);




ALTER TABLE `facturas` ADD INDEX `pventa`(`pventa`),
 ADD INDEX `iva`(`iva`),
 ADD INDEX `cuit`(`cuit`),
 ADD INDEX `transporte`(`transporte`),
 ADD INDEX `idtipoopera`(`idtipoopera`),
 ADD INDEX `idclascomp`(`idclascomp`),
 ADD INDEX `deposito`(`deposito`),
 ADD INDEX `idtipocli`(`idtipocli`),
 ADD INDEX `idlista`(`idlista`),
 ADD INDEX `idfinancia`(`idfinancia`);


ALTER TABLE `remitos` ADD INDEX `idcomproba`(`idcomproba`),
 ADD INDEX `pventa`(`pventa`),
 ADD INDEX `localidad`(`localidad`),
 ADD INDEX `iva`(`iva`),
 ADD INDEX `cuit`(`cuit`),
 ADD INDEX `idtipoopera`(`idtipoopera`),
 ADD INDEX `entidadaso`(`entidadaso`),
 ADD INDEX `vendedor`(`vendedor`);


ALTER TABLE `remitosh` ADD INDEX `idremito`(`idremito`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `idconcepto`(`idconcepto`),
 ADD INDEX `impuesto`(`impuesto`);


ALTER TABLE `remitos` ADD COLUMN `entidadaso` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `timestamp`;
ALTER TABLE `facturas` ADD COLUMN `entidadaso` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `timestamp`;

-- 20260727 --

CREATE TABLE  `tipoarticulo` (
  `idtipoart` int(11) NOT NULL AUTO_INCREMENT,
  `tipoarti` char(100) DEFAULT NULL,
  `observa` char(254) DEFAULT NULL,
  PRIMARY KEY (`idtipoart`)
) ENGINE=InnoDB CHARSET=utf8mb4;

insert into tipoarticulo values (0,'ARTICULO','')


ALTER TABLE `articulos` ADD COLUMN `idtipoart` INTEGER UNSIGNED NOT NULL DEFAULT 1 AFTER `timestamp`;

-- AGREGAR A LA VISTA DE ARTICULOS EN HORLIT B: --
-- ,`processar_horlit`.`articulos`.`idtipoart` AS `idtipoart`


-- 20260728 --
ALTER TABLE `acopiop` ADD COLUMN `numcomp` INTEGER UNSIGNED NOT NULL AFTER `numero`;
ALTER TABLE `ajustesacopiop` ADD COLUMN `opera` INTEGER UNSIGNED NOT NULL AFTER `observa`;
ALTER TABLE `ajustestockh` ADD INDEX `idtipomov`(`idtipomov`);

ALTER TABLE `articulos` ADD INDEX `moneda`(`moneda`),
 ADD INDEX `idtipoart`(`idtipoart`);


CREATE TABLE  `cajaiecc` (
  `idcajaiecc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcentroc` int(10) unsigned NOT NULL,
  `razon` double(13,2) NOT NULL,
  `idcajaie` int(10) DEFAULT NULL,
  PRIMARY KEY (`idcajaiecc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `clasificacomp` ADD COLUMN `tabla` CHAR(50) NOT NULL AFTER `recargo`;

CREATE TABLE  `clasificanp` (
  `idclasifnp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` char(100) NOT NULL,
  `descrip` char(250) NOT NULL,
  PRIMARY KEY (`idclasifnp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into clasificanp values (1, 'NP NORMAL', 'NP normal'),(2, 'NP ACOPIO', 'NP de acopio')


CREATE TABLE  `clasifopera` (
  `idclasifop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` char(50) NOT NULL,
  `descrip` char(250) NOT NULL,
  PRIMARY KEY (`idclasifop`),
  KEY `Index_2` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE  `clasnpcomp` (
  `idclasnpco` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idclasifnp` int(10) unsigned NOT NULL,
  `idcompactiv` int(10) unsigned NOT NULL,
  `idclasifop` int(10) unsigned NOT NULL,
  `valor` char(50) NOT NULL,
  PRIMARY KEY (`idclasnpco`),
  KEY `Index_2` (`idclasifnp`),
  KEY `Index_3` (`idcompactiv`),
  KEY `Index_4` (`idclasifop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE  `compcai` (
  `idcompcai` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcompactiv` int(10) unsigned NOT NULL,
  `cai` char(100) NOT NULL,
  `nromin` int(10) unsigned NOT NULL,
  `nromax` int(10) unsigned NOT NULL,
  `vtocai` char(8) NOT NULL,
  PRIMARY KEY (`idcompcai`),
  KEY `idcompactiv` (`idcompactiv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `comprobantes` ADD INDEX `comprobante`(`comprobante`);


ALTER TABLE `correoconf` ADD COLUMN `idtipocm` INTEGER UNSIGNED NOT NULL DEFAULT 1 AFTER `smtpusessl`,
 ADD INDEX `usuario`(`usuario`);


CREATE TABLE  `tipoctamail` (
  `idtipocm` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` char(100) NOT NULL,
  PRIMARY KEY (`idtipocm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into tipoctamail values (1, 'PARTICULAR'),(2, 'DIFUSION INFORMACION'),(3, 'DIFUSION FACTURACION')

-- 20260730 --

ALTER TABLE `cumplimentah` MODIFY COLUMN `cantidad` DOUBLE(13,2) NOT NULL,
 MODIFY COLUMN `cantidaduf` DOUBLE(13,2) NOT NULL;

ALTER TABLE `cumplimentap` ADD COLUMN `idclascomp` INTEGER UNSIGNED NOT NULL AFTER `observa4`,
 ADD COLUMN `paquetes` INTEGER UNSIGNED NOT NULL DEFAULT 1 AFTER `idclascomp`;
 
 ALTER TABLE `cumplimentap` ADD INDEX `idclascomp`(`idclascomp`);

ALTER TABLE `datosextra` ADD INDEX `propiedad`(`propiedad`);

ALTER TABLE `entartdes` ADD INDEX `entidad`(`entidad`),
 ADD INDEX `articulo`(`articulo`);

ALTER TABLE `entartdes` ADD COLUMN `idgrupo` INTEGER UNSIGNED NOT NULL AFTER `descmonto`,
 ADD INDEX `idgrupo`(`idgrupo`);
 
 
 CREATE TABLE  `entdes` (
  `identdes` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `descuento` decimal(13,2) NOT NULL,
  `descmonto` decimal(13,2) NOT NULL,
  PRIMARY KEY (`identdes`),
  KEY `entidad` (`entidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `estadosreg` MODIFY COLUMN `idestadosreg` INTEGER UNSIGNED NOT NULL DEFAULT NULL AUTO_INCREMENT;

CREATE TABLE  `etiquetanp` (
  `idetiqueta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `etiqueta` char(50) NOT NULL,
  `descrip` char(250) NOT NULL,
  `orden` char(2) NOT NULL DEFAULT '99',
  `habilitado` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idetiqueta`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

ALTER TABLE `facturas` ADD INDEX `entidadaso`(`entidadaso`);

CREATE TABLE  `facturasbsertmp` (
  `idfacbser` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idfactura` int(10) unsigned NOT NULL,
  `bocanumero` char(50) NOT NULL,
  `ruta1` int(10) unsigned NOT NULL,
  `folio1` int(10) unsigned NOT NULL,
  `ruta2` int(10) unsigned NOT NULL,
  `folio2` int(10) unsigned NOT NULL,
  `ubicacion` char(30) NOT NULL,
  `direccion` char(30) NOT NULL,
  `idtiposer` int(10) unsigned NOT NULL,
  `consumo` double(13,2) NOT NULL,
  `mactual` double(13,2) NOT NULL,
  `manterior` double(13,2) NOT NULL,
  `consextra` double(13,2) NOT NULL DEFAULT '0.00',
  `unidadref` char(10) NOT NULL,
  `valorref` double(13,2) NOT NULL,
  `idcateser` int(10) unsigned NOT NULL DEFAULT '1',
  `factorm` double(13,2) NOT NULL DEFAULT '1.00',
  `dataextra` char(254) NOT NULL,
  PRIMARY KEY (`idfacbser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `filtrocomp` (
  `idfiltro` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcompa` int(10) unsigned NOT NULL,
  `idcompb` int(10) unsigned NOT NULL,
  `grupo` char(100) NOT NULL,
  PRIMARY KEY (`idfiltro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


insert into filtrocomp values (1, 15, 46, 'remitos_btn_cump'),
(2, 15, 53, 'remitos_btn_cump'),
(3, 15, 54, 'remitos_btn_cump'),
(4, 15, 1, 'remitos_btn_comprobante'),
(5, 15, 10, 'remitos_btn_comprobante'),
(6, 1, 11, 'facturas_btn_comprobante'),
(7, 7, 8, 'facturas_btn_comprobante'),
(8, 8, 10, 'facturas_btn_comprobante'),
(9, 8, 7, 'facturas_btn_comprobante'),
(10, 10, 8, 'facturas_btn_comprobante'),
(11, 11, 1, 'facturas_btn_comprobante'),
(12, 11, 12, 'facturas_btn_comprobante'),
(13, 12, 11, 'facturas_btn_comprobante'),
(14, 24, 33, 'facturas_btn_comprobante'),
(15, 32, 33, 'facturas_btn_comprobante'),
(16, 33, 24, 'facturas_btn_comprobante'),
(17, 33, 32, 'facturas_btn_comprobante'),
(18, 34, 36, 'facturas_btn_comprobante'),
(19, 35, 36, 'facturas_btn_comprobante'),
(20, 36, 34, 'facturas_btn_comprobante'),
(21, 36, 35, 'facturas_btn_comprobante'),
(22, 39, 40, 'facturas_btn_comprobante'),
(23, 40, 39, 'facturas_btn_comprobante'),
(24, 48, 50, 'facturas_btn_comprobante'),
(25, 49, 50, 'facturas_btn_comprobante'),
(26, 50, 48, 'facturas_btn_comprobante'),
(27, 50, 49, 'facturas_btn_comprobante'),
(28, 1, 15, 'facturas_btn_remito'),
(29, 7, 15, 'facturas_btn_remito'),
(30, 8, 15, 'facturas_btn_remito'),
(31, 10, 15, 'facturas_btn_remito'),
(32, 11, 15, 'facturas_btn_remito'),
(33, 12, 15, 'facturas_btn_remito'),
(34, 24, 15, 'facturas_btn_remito'),
(35, 32, 15, 'facturas_btn_remito'),
(36, 33, 15, 'facturas_btn_remito'),
(37, 34, 15, 'facturas_btn_remito'),
(38, 35, 15, 'facturas_btn_remito'),
(39, 36, 15, 'facturas_btn_remito'),
(40, 39, 15, 'facturas_btn_remito'),
(41, 40, 15, 'facturas_btn_remito'),
(42, 48, 15, 'facturas_btn_remito'),
(43, 49, 15, 'facturas_btn_remito'),
(44, 50, 15, 'facturas_btn_remito'),
(45, 10, 10, 'facturas_btn_comprobante'),
(46, 1, 1, 'facturas_btn_comprobante'),
(47, 7, 10, 'facturas_btn_comprobante'),
(48, 12, 1, 'facturas_btn_comprobante')


CREATE TABLE  `impupercepcion` (
  `idimpuper` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detalle` char(200) NOT NULL,
  `razon` double(10,2) NOT NULL,
  `baseimpon` double(13,2) NOT NULL,
  `funcion` char(100) NOT NULL,
  `divimporte` double(12,4) NOT NULL DEFAULT '1.2100',
  PRIMARY KEY (`idimpuper`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;


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
  `divimporte` double(12,4) NOT NULL DEFAULT '1.2100',
  PRIMARY KEY (`idimpuret`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;


insert into impuretencion values (1, 'Reg. 19 - Intereses por op. realizadas en entidades financieras. Ley 21526 o agentes de bolsa o mercado', 1, 0.00, 5, 'RET_GANANCIAS_IFN', 2, 0.00, 19, 1.2100),
(2, 'Reg. 21 - Intereses originados en op. no comprendidas en Reg. 19', 3, 7870.00, 5, 'RET_GANANCIAS_IFN', 4, 7870.00, 21, 1.2100),
(3, 'Reg. 30 - Alquileres o arrendamientos de bienes muebles', 5, 11200.00, 5, 'RET_GANANCIAS_IFN', 6, 11200.00, 30, 1.2100),
(4, 'Reg. 31 - Bienes inmuebles urbanos, incluidos los efectuados bajo la modalidad de leasing - incluye suburbanos', 7, 11200.00, 5, 'RET_GANANCIAS_IFN', 8, 11200.00, 31, 1.2100),
(5, 'Reg. 32 - Bienes inmuebles rurales, incluidos los efectuados bajo la modalidad de leasing - incluye subrurales', 9, 11200.00, 5, 'RET_GANANCIAS_IFN', 10, 11200.00, 32, 1.2100),
(6, 'Reg. 35 - Regalias', 11, 7870.00, 5, 'RET_GANANCIAS_IFN', 12, 0.00, 35, 1.2100),
(7, 'Reg. 43 - Interés accionario, excedentes y retornos distribuidos entre asociados, cooperativas - excepto consumo', 13, 7870.00, 5, 'RET_GANANCIAS_IFN', 14, 0.00, 43, 1.2100),
(8, 'Reg. 51 - Obligaciones de no hacer, o por abandono o no ejercicio de una actividad', 15, 7870.00, 5, 'RET_GANANCIAS_IFN', 16, 0.00, 51, 1.2100),
(9, 'Reg. 78 - Enajenación de bienes muebles y bienes de cambio', 17, 224000.00, 5, 'RET_GANANCIAS_IFN', 18, 0.00, 78, 1.2100),
(10, 'Reg. 86 - Transf. temporaria o definitiva de derechos de llave, marcas, patentes de inv., regalías, concesiones y similares', 19, 224000.00, 5, 'RET_GANANCIAS_IFN', 20, 0.00, 86, 1.2100),
(11, 'Reg. 110 - Explotación de derechos de autor', 21, 10000.00, 5, 'RET_GANANCIAS_IFN', 22, 0.00, 110, 1.2100),
(12, 'Reg. 94 - Locaciones de obra y/o servicios no ejecutados en rel. de dep. no mencionados en otros incisos', 23, 67170.00, 5, 'RET_GANANCIAS_IFN', 24, 67170.00, 94, 1.2100),
(13, 'Reg. 25 - Comisiones u otras retribuciones derivadas de act. comisionista, rematador, consignatario y aux de comercio que se refiere en el articulo c del articulo 49', 25, 16830.00, 5, 'RET_GANANCIAS_IFN', 26, 0.00, 25, 1.2100),
(14, 'Reg. 116 - Honorarios de director de SA., sidico, fiduciario, consejero de soc. coop., integrante de consejos de vigilancia y soc. admin. de SRL...', 27, 67170.00, 5, 'RET_GANANCIAS_IFN', 28, 0.00, 116, 1.2100),
(15, 'Reg. 119 - Profesionales liberales, oficios, albacea, mandatarios, gestor de negocio', 29, 160000.00, 5, 'RET_GANANCIAS_IFN', 30, 160000.00, 119, 1.2100),
(16, 'Reg. 124 - Corredor viajante de comercio y despachante de aduana', 31, 16830.00, 5, 'RET_GANANCIAS_IFN', 32, 0.00, 124, 1.2100),
(17, 'Reg. 95 - Operaciones de transporte de carga nacional e internacional', 33, 67170.00, 5, 'RET_GANANCIAS_IFN', 34, 67170.00, 95, 1.2100),
(18, 'Reg. 53 - Operaciones realizadas por intermedio de mercados de cereales a término', 35, 0.00, 5, 'RET_GANANCIAS_IFN', 36, 0.00, 53, 1.2100),
(19, 'Reg. 55 - Distribución de películas. Transmisión de programación. Televisión via satelital', 37, 0.00, 5, 'RET_GANANCIAS_IFN', 38, 0.00, 55, 1.2100),
(20, 'Reg. 111 - Cualquier otra cesión o locación de derechos, excepto las que correspondan a operaciones realizadas por intermedio de mercados de cereales', 39, 0.00, 5, 'RET_GANANCIAS_IFN', 40, 0.00, 111, 1.2100),
(21, 'Reg. 112 - Benef. provenientes de los req. de los planes de seguro de retiro privados admin. lo establecido en el inciso d del art. 45 y el inciso d del art 79 excepto lo alcanzado por RG 2437', 41, 16830.00, 5, 'RET_GANANCIAS_IFN', 42, 16830.00, 112, 1.2100),
(22, 'Reg. 113 - Rescates por desistimiento de planes de seguro de retiro referido en el inciso o, excepto que sea de aplicación lo normalizado en el art 101 de la ley de imp. a las ganancias', 43, 16830.00, 5, 'RET_GANANCIAS_IFN', 44, 16830.00, 113, 1.2100),
(23, 'Reg. 779 - Subsidios abonados por los Est. Nacional, provinciales, municipales, en concepto de enajenación de bs muebles y bs de cambio', 45, 76140.00, 5, 'RET_GANANCIAS_IFN', 46, 0.00, 779, 1.2100),
(24, 'Reg. 780 - Subsidios abonados por los Est. Nacional, provinciales, municipales en concepto de locaciones de obras y/o serv. no en rel de dependencia', 47, 31460.00, 5, 'RET_GANANCIAS_IFN', 48, 0.00, 780, 1.2100),
(25, 'Ret. IIBB STAFE', 50, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 49, 650000.00, 0, 1.2100),
(26, 'Ret. IIBB STAFE 1.50', 51, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 52, 650000.00, 0, 1.2100),
(27, 'Ret. IIBB STAFE 0.5', 53, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 54, 650000.00, 0, 1.2100),
(28, 'Ret. IIBB otra jurisdicción', 55, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 56, 650000.00, 0, 1.2100),
(29, 'Ret. IIBB STAFE 0.01', 57, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 58, 650000.00, 0, 1.2100),
(30, 'Ret. IIBB STAFE 0.05', 59, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 60, 650000.00, 0, 1.2100),
(31, 'Ret. IIBB STAFE 0.10', 61, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 62, 650000.00, 0, 1.2100),
(32, 'Ret. IIBB STAFE 0.20', 63, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 64, 650000.00, 0, 1.2100),
(33, 'Ret. IIBB STAFE 0.30', 65, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 66, 650000.00, 0, 1.2100),
(34, 'Ret. IIBB STAFE 0.35', 67, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 68, 650000.00, 0, 1.2100),
(35, 'Ret. IIBB STAFE 0.60', 69, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 70, 650000.00, 0, 1.2100),
(36, 'Ret. IIBB STAFE 0.70', 71, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 72, 650000.00, 0, 1.2100),
(37, 'Ret. IIBB STAFE 0.80', 73, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 74, 650000.00, 0, 1.2100),
(38, 'Ret. IIBB STAFE 1.00', 75, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 76, 650000.00, 0, 1.2100),
(39, 'Ret. IIBB STAFE 1.25', 77, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 78, 650000.00, 0, 1.2100),
(40, 'Ret. IIBB STAFE 2.00', 79, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 80, 650000.00, 0, 1.2100),
(41, 'Ret. IIBB STAFE 2.50', 81, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 82, 650000.00, 0, 1.2100),
(42, 'Ret. IIBB STAFE 2.75', 83, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 84, 650000.00, 0, 1.2100),
(43, 'Ret. IIBB STAFE 3.00', 85, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 86, 650000.00, 0, 1.2100),
(44, 'Ret. IIBB STAFE 3.50', 87, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 88, 650000.00, 0, 1.2100),
(45, 'Ret. IIBB STAFE 4.00', 89, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 90, 650000.00, 0, 1.2100),
(46, 'Ret. IIBB STAFE 4.50', 91, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 92, 650000.00, 0, 1.2100),
(47, 'Ret. IIBB STAFE 5.00', 93, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 94, 650000.00, 0, 1.2100),
(48, 'Ret. IIBB STAFE 0.40', 95, 650000.00, 5, 'RET_IIBB_STAFE_IFN', 96, 650000.00, 0, 1.2100);

CREATE TABLE  `mailcomp` (
  `idmailcomp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idmaillog` int(10) unsigned NOT NULL,
  `idcomproba` int(10) unsigned NOT NULL,
  `idregistro` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmailcomp`),
  KEY `idcomproba` (`idcomproba`),
  KEY `idmaillog` (`idmaillog`),
  KEY `idregistro` (`idregistro`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

CREATE TABLE  `mailentcomp` (
  `idmentcomp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcomproba` int(10) unsigned NOT NULL,
  `entidad` int(10) unsigned NOT NULL,
  `idfnmail` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idmentcomp`),
  KEY `idcomproba` (`idcomproba`),
  KEY `entidad` (`entidad`),
  KEY `idfnmail` (`idfnmail`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

CREATE TABLE  `mailestado` (
  `idmailestado` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `estado` char(50) NOT NULL,
  PRIMARY KEY (`idmailestado`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into mailestado values (1, 'PENDIENTE'),
(2, 'ENVIADO'),
(3, 'ERROR'),
(4, 'SIN_CORREO')

CREATE TABLE  `mailfuncion` (
  `idmailfn` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `funcion` char(50) NOT NULL,
  `descip` char(250) NOT NULL,
  PRIMARY KEY (`idmailfn`),
  KEY `funcion` (`funcion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into mailfuncion values (1, 'ENVIOCOMPROBANTES', 'Función de envío de compobantes')

ALTER TABLE `mateacopiop` ADD COLUMN `articulo` CHAR(50) NOT NULL AFTER `unidad`,
 ADD INDEX `articulo`(`articulo`);
 
 ALTER TABLE `np` ADD COLUMN `idetiqueta` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `fechaentre`,
 ADD COLUMN `idclasifnp` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `idetiqueta`,
 ADD INDEX `idetiqueta`(`idetiqueta`),
 ADD INDEX `idclasifnp`(`idclasifnp`);

ALTER TABLE `otsector` ADD INDEX `idot`(`idot`),
 ADD INDEX `idsector`(`idsector`);
 
 
 CREATE TABLE  `percepciones` (
  `idper` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entidad` int(10) unsigned NOT NULL,
  `idimpuper` int(10) unsigned NOT NULL,
  `idfactura` int(10) unsigned NOT NULL,
  `baseimpon` double(13,2) NOT NULL,
  `enconvenio` char(1) NOT NULL,
  `razon` double(10,2) NOT NULL,
  `detalle` char(200) NOT NULL,
  `impaper` double(12,4) NOT NULL,
  `sujaper` double(12,4) NOT NULL,
  `funcion` char(100) NOT NULL,
  PRIMARY KEY (`idper`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


ALTER TABLE `reldatosextra` ADD INDEX `iddatosex`(`iddatosex`),
 ADD INDEX `tabla`(`tabla`),
 ADD INDEX `idregistro`(`idregistro`),
 ADD INDEX `idregic`(`idregic`);

ALTER TABLE `remitos` ADD INDEX `entidad`(`entidad`);

ALTER TABLE `remitosh` ADD INDEX `idremito`(`idremito`),
 ADD INDEX `idconcepto`(`idconcepto`),
 ADD INDEX `impuesto`(`impuesto`);


ALTER TABLE `sectorcomp` ADD COLUMN `stock` CHAR(1) NOT NULL DEFAULT 'N' AFTER `idcomproba`,
 ADD COLUMN `stockco` CHAR(1) NOT NULL DEFAULT 'N' AFTER `stock`,
 ADD INDEX `idsector`(`idsector`),
 ADD INDEX `idcomproba`(`idcomproba`);


ALTER TABLE `tablasidx` ADD INDEX `tabla`(`tabla`),
 ADD INDEX `campo`(`campo`);


CREATE TABLE  `tipologias` (
  `idtp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idp` int(10) unsigned NOT NULL,
  `codigo` char(20) NOT NULL,
  `nombre` char(150) NOT NULL,
  `articulo` char(20) NOT NULL,
  `nivel` char(1) NOT NULL,
  `cantidad` float(13,2) NOT NULL,
  PRIMARY KEY (`idtp`)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tipomstock` ADD INDEX `ie`(`ie`),
 ADD INDEX `deposito`(`deposito`);


CREATE TABLE  `transferenciasd` (
  `idtransfed` int(10) NOT NULL AUTO_INCREMENT,
  `idtransfe` int(10) DEFAULT NULL,
  `iddetacobro` int(10) DEFAULT NULL,
  `estado` int(10) DEFAULT NULL,
  `detalle` char(254) DEFAULT NULL,
  PRIMARY KEY (`idtransfed`),
  KEY `idtransfe` (`idtransfe`),
  KEY `iddetacobro` (`iddetacobro`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

ALTER TABLE `transporte` ADD INDEX `entidad`(`entidad`);

CREATE TABLE  `trazaie` (
  `idtie` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idtraza` char(10) NOT NULL,
  `articulo` char(50) NOT NULL,
  `cantidad` double(13,2) NOT NULL,
  `fecha` char(8) NOT NULL,
  `tabla` char(50) NOT NULL,
  `campo` char(50) NOT NULL,
  `registroi` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idtie`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

CREATE TABLE  `validaanular` (
  `idvalida` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcompa` int(10) unsigned NOT NULL,
  `idcompb` int(10) unsigned NOT NULL,
  `noanula` int(10) unsigned NOT NULL,
  `noelimina` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idvalida`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


ALTER TABLE `vendedores` ADD COLUMN `usuario` CHAR(15) NOT NULL AFTER `tipodoc`,
 ADD INDEX `usuario`(`usuario`);

-- 20260731 --

----------------------
--- IMPORTENTE!!! ---
-- Al modificar los campos como autoincremental controlar el ultimo valor del indice --
-----
ALTER TABLE `ajustestockh` MODIFY COLUMN `idajusteh` INTEGER UNSIGNED NOT NULL DEFAULT NULL AUTO_INCREMENT;

ALTER TABLE `ajustestockp` MODIFY COLUMN `idajuste` INTEGER UNSIGNED NOT NULL DEFAULT NULL AUTO_INCREMENT,
 ADD INDEX `idtipomov`(`idtipomov`),
 ADD INDEX `pventa`(`pventa`);


ALTER TABLE `r_listaprea` ADD COLUMN `idtipoart` INTEGER UNSIGNED NOT NULL AFTER `unidadf`,
 ADD INDEX `idlista`(`idlista`),
 ADD INDEX `idlistap`(`idlistap`),
 ADD INDEX `idlistah`(`idlistah`),
 ADD INDEX `articulo`(`articulo`),
 ADD INDEX `linea`(`linea`),
 ADD INDEX `idsublinea`(`idsublinea`),
 ADD INDEX `idtipoart`(`idtipoart`);
 
 
 --20260806--
 
 ALTER TABLE `facturas`  ADD INDEX `numero`(`numero`);
ALTER TABLE `remitos`  ADD INDEX `numero`(`numero`);

