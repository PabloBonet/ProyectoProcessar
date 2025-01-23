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
