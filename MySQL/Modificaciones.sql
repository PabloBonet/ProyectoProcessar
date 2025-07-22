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
