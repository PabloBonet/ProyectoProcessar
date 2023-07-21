_screen.Visible = .t.
SET SYSMENU OFF
CLEAR

_screen.windowstate= 0
_screen.closable = .f.
_screen.MaxButton = .T.
_screen.AutoCenter = .T.
_screen.Caption 	= ""

PATHEXE= FULLPATH(CURDIR())
SET DEFAULT TO &PATHEXE
SET CONFIRM OFF 
SET SAFETY OFF 

** GENERA ARCHIVO PARA IMPORTACION DE CUOTAS Y SALDOS DE CLIENTES **
*** Formato archivo csv serparado por ; a generar 
*** ( entidad I, servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8), fechavenc1 c(8), fechavenc2 c(8), fechavenc3 c(8) )			

CREATE TABLE saldosimportar ( entidad I, servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8), fechavenc1 c(8), fechavenc2 c(8), fechavenc3 c(8))
CREATE TABLE comprobantes (c1 c(50), c2 c(200), c3 c(200), c4 c(50), c5 c(50), c6 c(50), c7 c(50), c8 c(50), c9 c(50), c10 c(50), c11 c(50), c12 c(50), ;
						   c13 c(50), c14 c(50), c15 c(50), c16 c(50), c17 c(50), c18 c(50), c19 c(50), c20 c(50), c21 c(50) )

SELECT comprobantes
APPEND FROM krumbeincuentasxcobrar.csv DELIMITED WITH CHARACTER ';'
DELETE FOR EMPTY(ALLTRIM(c17)) AND !(ALLTRIM(c1)= 'Cliente:' ) AND EMPTY(ALLTRIM(c2))
DELETE FOR ALLTRIM(c7) = 'Total x Cliente:'
PACK
replace ALL c3 WITH IIF(SUBSTR((ALLTRIM(c3)+'  '),1,2)=='00',c3,'')
GO TOP
v_c3ante = comprobantes.c3 
SKIP 
v_c2ante = comprobantes.c2
GO TOP  
DO WHILE !EOF()
	IF !(ALLTRIM(c3)==ALLTRIM(v_c3ante)) AND !EMPTY(ALLTRIM(c3)) THEN 
		v_c3ante = comprobantes.c3 
	ENDIF 
	IF !(ALLTRIM(c2)==ALLTRIM(v_c2ante)) AND !EMPTY(ALLTRIM(c2)) THEN 
		v_c2ante = comprobantes.c2 
	ENDIF 
	replace c3 WITH v_c3ante, c2 WITH v_c2ante

	SKIP 
ENDDO 
DELETE FOR EMPTY(ALLTRIM(comprobantes.c11))
PACK

GO TOP 
vi_numerocoma =""
DO WHILE !EOF()

	vi_entidad 		= INT(VAL(SUBSTR(ALLTRIM(comprobantes.c3),1,10)))
	vi_numerocomp 	= SUBSTR(ALLTRIM(comprobantes.c2),10,13)

	IF !(ALLTRIM(vi_numerocoma)==ALLTRIM(vi_numerocomp)) THEN 
		vi_numerocoma 	= SUBSTR(ALLTRIM(comprobantes.c2),10,13)
		vi_fecha   		= IIF(DTOS(DATE())< SUBSTR(ALLTRIM(comprobantes.c13),7,4)+SUBSTR(ALLTRIM(comprobantes.c13),4,2)+SUBSTR(ALLTRIM(comprobantes.c13),1,2),DTOS(DATE()),SUBSTR(ALLTRIM(comprobantes.c13),7,4)+SUBSTR(ALLTRIM(comprobantes.c13),4,2)+SUBSTR(ALLTRIM(comprobantes.c13),1,2))
	ENDIF 

	vi_monto 		= VAL(STRTRAN(STRTRAN(ALLTRIM(comprobantes.c17),'.',''),',','.'))
	vi_cuota 		= VAL(ALLTRIM(comprobantes.c11))
	vi_vtocta 		= SUBSTR(ALLTRIM(comprobantes.c13),7,4)+SUBSTR(ALLTRIM(comprobantes.c13),4,2)+SUBSTR(ALLTRIM(comprobantes.c13),1,2)
	
	INSERT INTO saldosimportar VALUES ( vi_entidad , 0, 0, vi_fecha ,vi_numerocomp , vi_monto , vi_cuota , vi_vtocta , vi_vtocta, vi_vtocta, vi_vtocta )
	SKIP 
ENDDO 

SELECT saldosimportar
GO TOP 
DELETE FILE .\importar\saldosimportar.csv
COPY TO 	.\importar\saldosimportar.csv DELIMITED WITH  CHARACTER ';'



** GENERA ARCHIVO PARA IMPORTACION DE CLIENTES **
*** Formato archivo csv serparado por ; a generar 
***  entidadescar FREE (entidad I, apellido C(100), nombre c(100), cargo C(100), compania C(100), cuit C(13), direccion C(100), ;
*					localidad C(10), iva I,fechaalta C(8), telefono C(50), cp C(50), fax C(50), ;
*					email C(254), web C(254), dni I, tipodoc C(3),  ;
*					fechanac C(8), idafiptipd I, credito n(12,2))


CREATE TABLE clientesmintrone ( c1 c(15), c2 c(100), c3 c(100), c4 c(15), c5 c(100), c6 c(100), c7 c(100), c8 c(100), c9 c(100), c10 c(100), ;
								c11 c(100), c12 c(100), c13 c(100), c14 c(100), c15 c(100), c16 c(100), c17 c(100), c18 c(100), c19 c(20), c20 c(20) )
								
CREATE TABLE localidades ( localidad c(15), nombre c(100), cp c(100), provincia c(15) )



CREATE TABLE entidadescar FREE (entidad I, apellido C(100), nombre c(100), cargo C(100), compania C(100), cuit C(13), direccion C(100), ;
					localidad C(10), iva I,fechaalta C(8), telefono C(50), cp C(50), fax C(50), ;
					email C(254), web C(254), dni n(12), tipodoc C(3),  ;
					fechanac C(8), idafiptipd I, credito n(12,2))		



SET EXACT ON 

SELECT localidades
APPEND FROM localidades.csv DELIMITED WITH CHARACTER ';'
SELECT localidades
REPLACE ALL nombre WITH UPPER(STRTRAN(ALLTRIM(nombre),' ',''))
INDEX on UPPER(ALLTRIM(nombre)) TAG nombre
SET ORDER TO nombre


*!*	SELECT provincias
*!*	APPEND FROM provincias.csv DELIMITED WITH CHARACTER ';'



SELECT clientesmintrone
APPEND FROM clientesmintrone.csv DELIMITED WITH CHARACTER ';'
ALTER table clientesmintrone ADD COLUMN localidad c(10)
SET RELATION to UPPER(STRTRAN(ALLTRIM(C10),' ','')) INTO localidades 
replace ALL localidad WITH localidades.localidad

SET EXACT off 



SELECT clientesmintrone
GO TOP
DO WHILE !EOF()

	vi_entidad 		= INT(VAL(ALLTRIM(clientesmintrone.c1)))
	vi_apellido 	= ALLTRIM(clientesmintrone.c3)
	vi_nombre 		= ALLTRIM(clientesmintrone.c2)
	vi_cargo 		= ""
	vi_compania		= ""
	vi_cuit			= ALLTRIM(clientesmintrone.c20)
	vi_direccion	= ALLTRIM(clientesmintrone.c5)
	vi_localidad	= iif(empty(alltrim(clientesmintrone.localidad)),'1',alltrim(clientesmintrone.localidad))
	vi_iva			= iif(upper(alltrim(clientesmintrone.c17))=="RESPONSABLE INSCRIPTO",1,iif(upper(alltrim(clientesmintrone.c17))=="CONSUMIDOR FINAL",4,iif(upper(alltrim(clientesmintrone.c17))=="RESPONSABLE MONOTRIBUTISTA",2,iif(upper(alltrim(clientesmintrone.c17))=="EXENTO",3,4))))
	vi_fechaalta	= '20230201'
	vi_telefono		= alltrim(clientesmintrone.c13)+' '+alltrim(clientesmintrone.c14)
	vi_cp 			= alltrim(clientesmintrone.c11)
	vi_fax			= ''
	vi_email		= ''
	vi_web			= ''
	vi_dni			= INT(VAL(ALLTRIM(clientesmintrone.c19)))
	vi_tipodoc		= '1'
	vi_fechanac		= ''
	vi_idafiptipd	= 2
	vi_credito		= 0

	SELECT entidadescar 
	INSERT INTO entidadescar VALUES ( vi_entidad , vi_apellido , vi_nombre , vi_cargo , vi_compania , vi_cuit , vi_direccion , ;
					vi_localidad , vi_iva ,vi_fechaalta , vi_telefono , vi_cp , vi_fax , vi_email , vi_web , vi_dni , vi_tipodoc ,  ;
					vi_fechanac , vi_idafiptipd , vi_credito )		

	SELECT clientesmintrone
	SKIP 
ENDDO 


SELECT entidadescar 
GO TOP 
DELETE FILE .\importar\clientesimportar.csv
COPY TO 	.\importar\clientesimportar.csv DELIMITED WITH  CHARACTER ';'

**---------------------------------------------------------------------------------------

**---- Archivo para Importacion de Lineas a partir de las lineas del sistema de Etiquetas
**
USE .\stock\lineacodigo IN 0
SELECT cod_linea as linea , descripcio as detalle,'  ' as codigoctac, '  ' as codigoctav, 0.00 as margen, '' as codmin, '' as codmax ;
	 FROM lineacodigo INTO TABLE lineas00 
DELETE FILE .\importar\lineasimportar.csv
COPY TO .\importar\lineasimportar.csv DELIMITED WITH  CHARACTER ';'

**-- Archivo para Importacion de Articulos a partir de los Articulos del Sistema de Etiquetas

USE .\stock\articulosp IN 0
SET ENGINEBEHAVIOR 70

SELECT codigofact as articulo, nombrefact as detalle, um as unidad, ' ' as abrevia, '' as codbarra, costomater as costo, ;
		codlinea as linea, 'S' as ctrlstock, ' ' as observa, 'N' as ocultar, 10.00 as stockmin, ;
		0.00 as desc1, 0.00 as desc2,0.00 as desc3,0.00 as desc4,0.00 as desc5, 1 as moneda, 1 as impuesto, ;
		30.00 as margen, 0 as proveedor, '' as codigop, 0 as idsublinea ;		
from articulosp INTO TABLE articulosp00 WHERE EMPTY(ALLTRIM(fechabaja)) GROUP BY articulo 

SET ENGINEBEHAVIOR 90
SELECT articulosp00 
DELETE FILE .\importar\articulosimportar.csv
COPY TO     .\importar\articulosimportar.csv DELIMITED WITH  CHARACTER ';'

**------------------------------------------------------------------------


*!*	*!*	**-- Carga de Existencias de Mintrone en distintas Sucursales
*!*	*!*	CREATE TABLE stockmintro0 ( articulo c(20),detalle c(200), stock n(13,2),depo c(10),depom c(10),c06 c(10),c07 c(10),c08 c(10),c09 c(10),c10 c(10))
*!*	*!*	CREATE TABLE stockmintro  ( articulo c(20),detalle c(200), stock n(13,2),depo c(10),depom c(10),c06 c(10),c07 c(10),c08 c(10),c09 c(10),c10 c(10))
*!*	*!*	SELECT stockmintro0 
*!*	*!*	APPEND FROM .\stock\MCS.csv DELIMITED WITH CHARACTER ';'
*!*	*!*	DELETE FROM stockmintro0 WHERE ALLTRIM(LOWER(articulo))='producto' OR ALLTRIM(LOWER(articulo))='categoría :' OR ALLTRIM(LOWER(articulo))="marca :"
*!*	*!*	REPLACE ALL depo WITH 'ECS', depom WITH 'MCS' 
*!*	*!*	PACK 
*!*	*!*	SELECT stockmintro
*!*	*!*	APPEND FROM stockmintro0

*!*	*!*	SELECT stockmintro0
*!*	*!*	ZAP
*!*	*!*	APPEND FROM .\stock\MCST.csv DELIMITED WITH CHARACTER ';'
*!*	*!*	DELETE FROM stockmintro0 WHERE ALLTRIM(LOWER(articulo))='producto' OR ALLTRIM(LOWER(articulo))='categoría :' OR ALLTRIM(LOWER(articulo))="marca :"
*!*	*!*	REPLACE ALL depo WITH 'ECS', depom WITH 'MCST'
*!*	*!*	PACK 
*!*	*!*	SELECT stockmintro
*!*	*!*	APPEND FROM stockmintro0

*!*	*!*	SELECT stockmintro0
*!*	*!*	ZAP
*!*	*!*	APPEND FROM .\stock\MCA.csv DELIMITED WITH CHARACTER ';'
*!*	*!*	DELETE FROM stockmintro0 WHERE ALLTRIM(LOWER(articulo))='producto' OR ALLTRIM(LOWER(articulo))='categoría :' OR ALLTRIM(LOWER(articulo))="marca :"
*!*	*!*	REPLACE ALL depo WITH 'ECA',depom WITH 'MCA'
*!*	*!*	PACK 
*!*	*!*	SELECT stockmintro
*!*	*!*	APPEND FROM stockmintro0


*!*	*!*	SELECT stockmintro0
*!*	*!*	ZAP
*!*	*!*	APPEND FROM .\stock\MGA.csv DELIMITED WITH CHARACTER ';'
*!*	*!*	DELETE FROM stockmintro0 WHERE ALLTRIM(LOWER(articulo))='producto' OR ALLTRIM(LOWER(articulo))='categoría :' OR ALLTRIM(LOWER(articulo))="marca :"
*!*	*!*	REPLACE ALL depo WITH 'EGA', depom WITH 'MGA'
*!*	*!*	PACK 
*!*	*!*	SELECT stockmintro
*!*	*!*	APPEND FROM stockmintro0

*!*	*!*	SELECT stockmintro0
*!*	*!*	ZAP
*!*	*!*	APPEND FROM .\stock\MRE.csv DELIMITED WITH CHARACTER ';'
*!*	*!*	DELETE FROM stockmintro0 WHERE ALLTRIM(LOWER(articulo))='producto' OR ALLTRIM(LOWER(articulo))='categoría :' OR ALLTRIM(LOWER(articulo))="marca :"
*!*	*!*	REPLACE ALL depo WITH 'ERE', depom WITH 'MRE'
*!*	*!*	PACK 
*!*	*!*	SELECT stockmintro
*!*	*!*	APPEND FROM stockmintro0

*!*	*!*	SELECT stockmintro0
*!*	*!*	ZAP
*!*	*!*	APPEND FROM .\stock\MVE.csv DELIMITED WITH CHARACTER ';'
*!*	*!*	DELETE FROM stockmintro0 WHERE ALLTRIM(LOWER(articulo))='producto' OR ALLTRIM(LOWER(articulo))='categoría :' OR ALLTRIM(LOWER(articulo))="marca :"
*!*	*!*	REPLACE ALL depo WITH 'EV2', depom WITH 'MVE'
*!*	*!*	PACK 
*!*	*!*	SELECT stockmintro
*!*	*!*	APPEND FROM stockmintro0



*!*	*!*	**-- Abro los Stocks de Etiquetas
*!*	*!*	SET ENGINEBEHAVIOR 70

*!*	*!*	*CASA CENTRAL
*!*	*!*	USE .\stock\ECS IN 0 
*!*	*!*	SELECT * FROM ecs INTO TABLE ecs0 GROUP BY idetique 
*!*	*!*	SELECT codigofact as articulo, stockreal as stock, SUM(1) as canteti, idartp, 'ECS       ' AS depo FROM ecs0 INTO TABLE ecst1 ;
*!*	*!*		WHERE idartp > 0 ;
*!*	*!*		ORDER BY idartp GROUP BY idartp
*!*	*!*	SELECT codigofact as articulo, idetique as etiqueta,  idartp, 'ECS       ' AS depo FROM ecs0 INTO TABLE ecse1 ;
*!*	*!*		WHERE idartp > 0 

*!*	*!*	*CALCHAQUI
*!*	*!*	USE .\stock\ECA IN 0 
*!*	*!*	SELECT * FROM eca INTO TABLE eca0 GROUP BY idetique 
*!*	*!*	SELECT codigofact as articulo, stockreal as stock, SUM(1) as canteti, idartp, 'ECA       ' AS depo FROM eca0 INTO TABLE ecat1 ;
*!*	*!*		WHERE idartp > 0 ;
*!*	*!*		ORDER BY idartp GROUP BY idartp
*!*	*!*	SELECT codigofact as articulo, idetique as etiqueta,  idartp, 'ECA       ' AS depo FROM eca0 INTO TABLE ecae1 ;
*!*	*!*		WHERE idartp > 0 

*!*	*!*	*RECONQUISTA
*!*	*!*	USE .\stock\ERE IN 0 
*!*	*!*	SELECT * FROM ere INTO TABLE ere0 GROUP BY idetique 
*!*	*!*	SELECT codigofact as articulo, stockreal as stock, SUM(1) as canteti, idartp, 'ERE       ' AS depo FROM ere0 INTO TABLE eret1 ;
*!*	*!*		WHERE idartp > 0 ;
*!*	*!*		ORDER BY idartp GROUP BY idartp
*!*	*!*	SELECT codigofact as articulo, idetique as etiqueta,  idartp, 'ERE       ' AS depo FROM ere0 INTO TABLE eree1 ;
*!*	*!*		WHERE idartp > 0 

*!*	*!*	*VERA
*!*	*!*	USE .\stock\EV2 IN 0 
*!*	*!*	SELECT * FROM ev2 INTO TABLE ev20 GROUP BY idetique 
*!*	*!*	SELECT codigofact as articulo, stockreal as stock, SUM(1) as canteti, idartp, 'EV2       ' AS depo FROM ev20 INTO TABLE ev2t1 ;
*!*	*!*		WHERE idartp > 0 ;
*!*	*!*		ORDER BY idartp GROUP BY idartp
*!*	*!*	SELECT codigofact as articulo, idetique as etiqueta,  idartp, 'EV2       ' AS depo FROM ev20 INTO TABLE ev2e1 ;
*!*	*!*		WHERE idartp > 0 

*!*	*!*	SELECT * FROM ecst1 INTO TABLE stocketiquetas
*!*	*!*	SELECT stocketiquetas
*!*	*!*	APPEND FROM .\ecat1
*!*	*!*	APPEND FROM .\eret1
*!*	*!*	APPEND FROM .\ev2t1
*!*	*!*	ALTER TABLE stocketiquetas alter COLUMN stock i
*!*	*!*	ALTER TABLE stocketiquetas alter COLUMN canteti i
*!*	*!*	DELETE FILE stocketiquetas.csv
*!*	*!*	COPY TO stocketiquetas.csv DELIMITED WITH  CHARACTER ';'

*!*	*!*	SELECT * FROM ecse1 INTO TABLE stetiquetas0
*!*	*!*	SELECT stetiquetas0  
*!*	*!*	APPEND FROM .\ecae1
*!*	*!*	APPEND FROM .\eree1
*!*	*!*	APPEND FROM .\ev2e1

*!*	*!*	SELECT m.detalle, e.*,IIF(ALLTRIM(e.depo) ='ECS','MARGARITA',IIF(e.depo ='ECA','CALCHAQUI',IIF(e.depo ='ERE','RECONQUISTA',IIF(e.depo ='EV2','VERA',IIF(e.depo ='EGA','GALLARETA',''))))) as localidad  ;
*!*	*!*	FROM stetiquetas0 e LEFT JOIN stockmintro m ON  ALLTRIM(e.articulo) == ALLTRIM(m.articulo) INTO TABLE stetiquetas


*!*	*!*	DELETE FILE .\importar\stetiquetas.csv
*!*	*!*	COPY TO 	.\importar\stetiquetas.csv DELIMITED WITH  CHARACTER ';'


*!*	*!*	SELECT m.articulo, m.detalle, SUM(m.stock) as stock , e.stock as stocketi, e.canteti , m.depo, m.depom, ;
*!*	*!*	IIF(ALLTRIM(m.depo) ='ECS','MARGARITA',IIF(m.depo ='ECA','CALCHAQUI',IIF(m.depo ='ERE','RECONQUISTA',IIF(m.depo ='EV2','VERA',IIF(m.depo ='EGA','GALLARETA',''))))) as localidad, ALLTRIM(m.depo)+'-'+ALLTRIM(m.articulo) as grupo ;
*!*	*!*	from stockmintro m LEFT JOIN stocketiquetas e ON ALLTRIM(m.articulo) == ALLTRIM(e.articulo) AND ALLTRIM(m.depo) == alltrim(e.depo) ;
*!*	*!*	INTO TABLE StockKrumbein ORDER BY grupo GROUP BY grupo 

*!*	*!*	&&IIF(m.depo ='ECA','CALCHAQUI',IIF(m.depo ='ERE','RECONQUISTA',IIF(m.depo ='EV2','VERA',IIF(m.depo ='EGA','GALLARETA',''))))

*!*	*!*	SELECT StockKrumbein 
*!*	*!*	ALTER table StockKrumbein alter COLUMN stock    i
*!*	*!*	ALTER table StockKrumbein alter COLUMN stocketi i
*!*	*!*	ALTER table StockKrumbein alter COLUMN canteti  i
*!*	*!*	DELETE FILE .\importar\StockKrumbein.csv
*!*	*!*	COPY TO     .\importar\StockKrumbein.csv DELIMITED WITH  CHARACTER ';'


**************************************************************************************************************************************************
*** Exportar y juntar todas las etiquetas para generar ingreso de etiquetas
*** en archivo de etiquetas de hogar
SET ENGINEBEHAVIOR 70

*CASA CENTRAL
USE .\stock\ECS IN 0 
SELECT  idetique as etiqueta, '20230624' as fechaalta, ' ' as codigo, codigofact as articulo, '  ' as timestamp, 'articulos' as tabla, 'articulo' as campo, 0 as idregistro, ;
ALLTRIM(codigofact)+"-"+ALLTRIM(nombrefact) as detalle , ' ' as detalleb , 'ECS' AS sucursal FROM ecs INTO TABLE ecs0 WHERE !(idartp = 0) GROUP BY etiqueta 



*GALLARETA
USE .\stock\EGA IN 0 
SELECT  idetique as etiqueta, '20230624' as fechaalta, ' ' as codigo, codigofact as articulo, '  ' as timestamp, 'articulos' as tabla, 'articulo' as campo, 0 as idregistro, ;
ALLTRIM(codigofact)+"-"+ALLTRIM(nombrefact) as detalle , ' ' as detalleb , 'EGA' AS sucursal FROM ega INTO TABLE ega0 WHERE !(idartp = 0) GROUP BY etiqueta 



*CALCHAQUI
USE .\stock\ECA IN 0 
SELECT  idetique as etiqueta, '20230624' as fechaalta, ' ' as codigo, codigofact as articulo, '  ' as timestamp, 'articulos' as tabla, 'articulo' as campo, 0 as idregistro, ;
ALLTRIM(codigofact)+"-"+ALLTRIM(nombrefact) as detalle , ' ' as detalleb , 'ECA' AS sucursal FROM eca INTO TABLE eca0 WHERE !(idartp = 0) GROUP BY etiqueta 



*VERA
USE .\stock\EV2 IN 0 
SELECT  idetique as etiqueta, '20230624' as fechaalta, ' ' as codigo, codigofact as articulo, '  ' as timestamp, 'articulos' as tabla, 'articulo' as campo, 0 as idregistro, ;
ALLTRIM(codigofact)+"-"+ALLTRIM(nombrefact) as detalle , ' ' as detalleb , 'EV2' AS sucursal FROM ev2 INTO TABLE ev20 WHERE !(idartp = 0) GROUP BY etiqueta 




SELECT ecs0
APPEND FROM .\ega0
APPEND FROM .\eca0
APPEND FROM .\ev20
DELETE FILE .\importar\etiquetasimpo.csv
COPY TO 	.\importar\etiquetasimpo.csv DELIMITED WITH  CHARACTER ';'

** ETIQUETAS PARA CARGAR STOCK Y MOVER ETIQUETAS
SELECT etiqueta FROM ecs0 INTO TABLE ecs1 WHERE ALLTRIM(sucursal)=='ECS'
SELECT ecs1 
DELETE FILE .\importar\etiquetasECS.csv
COPY TO 	.\importar\etiquetasECS.csv DELIMITED WITH  CHARACTER ';'

SELECT etiqueta FROM ecs0 INTO TABLE ega1 WHERE ALLTRIM(sucursal)=='EGA' 
SELECT ega1
DELETE FILE .\importar\etiquetasEGA.csv
COPY TO 	.\importar\etiquetasEGA.csv DELIMITED WITH  CHARACTER ';'

SELECT etiqueta FROM ecs0 INTO TABLE eca1 WHERE ALLTRIM(sucursal)=='ECA' 
SELECT eca1
DELETE FILE .\importar\etiquetasECA.csv
COPY TO 	.\importar\etiquetasECA.csv DELIMITED WITH  CHARACTER ';'

SELECT etiqueta FROM ecs0 INTO TABLE ev21 WHERE ALLTRIM(sucursal)=='EV2' 
SELECT ev21
DELETE FILE .\importar\etiquetasEV2.csv
COPY TO 	.\importar\etiquetasEV2.csv DELIMITED WITH  CHARACTER ';'



SET ENGINEBEHAVIOR 90
QUIT |