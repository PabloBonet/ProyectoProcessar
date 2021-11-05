*/ PARAMETROS
*--------------
*/------------------------------------------------------------------------------------------------------------
*/---------------------------------------------------------------------------
* Función Global Calculo de Porcentajes sobre Conceptos  .
FUNCTION FPGPORCENT
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion, pper_conceptos, pper_I, pper_A

	vcond = ""
	IF !EMPTY(pper_A) THEN 
		ALINES(Aparam,pper_A,4,',')
		FOR ipar = 1 TO ALEN(Aparam,1)
			IF !EMPTY(ALLTRIM(Aparam(ipar))) THEN 
				vcond = vcond+" OR alltrim(articulo)== '"+ALLTRIM(Aparam(ipar))+"' "
			ENDIF 
		ENDFOR 
	ENDIF 
	IF !EMPTY(vcond) THEN 
		vcond = "F"+ALLTRIM(vcond)
	ENDIF 

	SELECT &pper_conceptos
	CALCULATE SUM(neto) TO vneto &vcond
	vtotal = vneto * pper_I/100	
	RETURN vtotal
ENDFUNC 


*/---------------------------------------------------------------------------
* Función Global Calculo de Porcentajes sobre Conceptos  .
FUNCTION FPGCOMBO
PARAMETERS pper_conexion ,pper_periodo, pper_identidadh,pper_iva, pper_cantidad, pper_identidadd, pper_conceptos


	vcond = " in ('"+ALLTRIM(STRTRAN(STRTRAN(pper_conceptos,"=",''),",","','"))+"')"

	** CONCEPTOS **
	sqlmatriz(1)=" select 0 as idperiodoe, idconcepto, concepto as articulo, detalle, abrevia as abreviado, importe as unitario, importe as neto, "
	sqlmatriz(2)=" 		unidad, 0 as identidadh, 0 as identidadd, 'S' as mensual, facturar, padron, cantidad, 1 as idlista, funcion, 1 as iva, 'N' as compuesto "
	sqlmatriz(3)=" from conceptoser  " 
	sqlmatriz(4)=" where compuesto = 'N' and concepto "+vcond
	verror=sqlrun(pper_conexion,"concefalta")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA De Articulos Faltantes ",0+48+0,"Error")
	    RETURN 0
	ENDIF 	
	SELECT * FROM concefalta INTO TABLE agregacombo
	SELECT agregacombo
	ALTER table agregacombo alter COLUMN idperiodoe n(10)
	ALTER table agregacombo alter COLUMN identidadh n(10)
	ALTER table agregacombo alter COLUMN identidadd n(10)
	ALTER table agregacombo alter COLUMN idlista n(10)
	ALTER table agregacombo alter COLUMN iva n(10)
	ALTER table agregacombo alter COLUMN articulo c(20)
	replace ALL idperiodoe WITH pper_periodo, identidadh WITH pper_identidadh, iva WITH pper_iva, cantidad WITH (cantidad * pper_cantidad), identidadd WITH pper_identidadd
	USE IN concefalta
*!*		USE IN agregacombo 
	
	
	** ARTICULOS **
	sqlmatriz(1)=" select 0 as idperiodoe,  0 as idconcepto, a.articulo, a.detalle, a.abrevia as abreviado, ((h.margen/100+1)* a.costo) as unitario, ((h.margen/100+1)* a.costo) as neto, "
	sqlmatriz(2)=" unidad, 0 as identidadh, 0 as identidadd, 'S' as mensual, 'S' as facturar, 0 as padron, 1 as cantidad , 1 as idlista, 'C*I' as funcion, 1 as iva, 'N' as compuesto "
 	sqlmatriz(3)=" from articulos a left join listaprecioh h on a.articulo = h.articulo "
	sqlmatriz(4)=" where h.idlista = 1 and a.articulo "+vcond
	verror=sqlrun(pper_conexion,"artifalta")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA De Articulos Faltantes ",0+48+0,"Error")
	    RETURN 0
	ENDIF 	
	SELECT * FROM artifalta INTO TABLE agregaarti
	SELECT agregaarti
	ALTER table agregaarti alter COLUMN idperiodoe n(10)
	ALTER table agregaarti alter COLUMN identidadh n(10)
	ALTER table agregaarti alter COLUMN identidadd n(10)
	ALTER table agregaarti alter COLUMN idlista n(10)
	ALTER table agregaarti alter COLUMN iva n(10)
	ALTER table agregaarti alter COLUMN cantidad n(10)
	replace ALL idperiodoe WITH pper_periodo, identidadh WITH pper_identidadh, iva WITH pper_iva, cantidad WITH pper_cantidad ,neto WITH (pper_cantidad * unitario), identidadd WITH pper_identidadd
	USE IN artifalta
	SELECT agregacombo
	APPEND FROM agregaarti
	USE IN agregacombo 
	USE IN agregaarti

	RETURN "agregacombo"
ENDFUNC 


*/------------------------------------------------------------------------------------------------------------
*/ FUNCIONES DE CONCEPTOS PARA CALCULO DE FACTURACION DE TELEFONIA FIJA 

* Función para Cálculo de consumo de telefonía a partir de la medicion de Central Telefónica.
FUNCTION FPTCONSUMO
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion, pper_cantidad, pper_unitario

	sqlmatriz(1)=" select * from factulotes  " 
	sqlmatriz(4)=" where idperiodo ="+STR(pper_periodo)
	verror=sqlrun(pper_conexion,"periodocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Periodo a facturar ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	
	vfechad = ""
	vfechah = ""
	SELECT periodocs
	IF !EOF() THEN 
		vfechad = periodocs.fechad
		vfechah = periodocs.fechah
	ENDIF 
	USE IN  periodocs 
	IF EMPTY(vfechad) OR EMPTY(vfechah) THEN 
		RETURN 0	
	ENDIF 

	sqlmatriz(1)=" select b.identidadh, m.*  from bocaservicios b " 
	sqlmatriz(2)=" left join medtelefono m on TRIM(m.bocanumero) = TRIM(b.bocanumero) "
	sqlmatriz(3)=" left join importadatosp p on p.idimportap = m.idimportap "
	sqlmatriz(4)=" where b.identidadh ="+STR(pper_identidadh)+" and p.fechad >= '"+vfechad+"' and p.fechah <= '"+vfechah+"' "
	sqlmatriz(5)="       and b.facturar = 'S' and b.habilitado = 'S' "
	verror=sqlrun(pper_conexion,"medicionescs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Telefonia ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	vtotalconsumo  = 0.00
	SELECT medicionescs
	GO TOP 
	IF !EOF() THEN 
		CALCULATE SUM(pesos) TO vtotalconsumo 
		vtotalconsumo = ROUND(vtotalconsumo,2)	
	ENDIF 
	USE 	
	
	* Descuento segun Categoria de consumo 
	sqlmatriz(1)=" select ifnull(importe,0) as importe from conceptolimit "
	sqlmatriz(4)=" where idconcepto ="+STR(pper_idconcepto)+" and consudesde <= "+ALLTRIM(STR(vtotalconsumo,12,4))+" and "+ALLTRIM(STR(vtotalconsumo,12,4))+" <= consuhasta  "
	verror=sqlrun(pper_conexion,"descuentocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Telefonia ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	SELECT descuentocs
	GO TOP 
	IF !EOF() THEN 
		vtotalconsumo = IIF(vtotalconsumo-descuentocs.importe <= 0,0,ROUND(vtotalconsumo-descuentocs.importe,2))
	ENDIF 
	USE 		
	
	RETURN vtotalconsumo
ENDFUNC 



* Función para Cálculo de consumo de CPP .
FUNCTION FPTCPP
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion

	sqlmatriz(1)=" select * from factulotes  " 
	sqlmatriz(4)=" where idperiodo ="+STR(pper_periodo)
	verror=sqlrun(pper_conexion,"periodocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Periodo a facturar ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	
	vfechad = ""
	vfechah = ""
	SELECT periodocs
	IF !EOF() THEN 
		vfechad = periodocs.fechad
		vfechah = periodocs.fechah
	ENDIF 
	USE IN  periodocs 
	IF EMPTY(vfechad) OR EMPTY(vfechah) THEN 
		RETURN 0	
	ENDIF 

	sqlmatriz(1)=" select b.identidadh, m.*  from bocaservicios b " 
	sqlmatriz(2)=" left join cpptelefono m on TRIM(m.bocanumero) = TRIM(b.bocanumero) "
	sqlmatriz(3)=" left join importadatosp p on p.idimportap = m.idimportap "
	sqlmatriz(4)=" where b.identidadh ="+STR(pper_identidadh)+" and p.fechad >= '"+vfechad+"' and p.fechah <= '"+vfechah+"' "
	sqlmatriz(5)="       and b.facturar = 'S' and b.habilitado = 'S' "
	verror=sqlrun(pper_conexion,"cppcs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de CPP Telefonía ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	vtotalconsumo  = 0.00
	SELECT cppcs
	GO TOP 
	IF !EOF() THEN 
		CALCULATE SUM(valorllama) TO vtotalconsumo 
		vtotalconsumo = ROUND(vtotalconsumo,2)	
	ENDIF 
	USE 	
	
	RETURN vtotalconsumo
ENDFUNC 


*/------------------------------------------------------------------------------------------------------------
*/ FUNCIONES DE CONCEPTOS PARA CALCULO DE FACTURACION DE AGUA POTABLE

* Función para Cálculo de Abono de Agua a partir de la medicion del Período.
FUNCTION FPAABONO
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion

	sqlmatriz(1)=" select * from factulotes  " 
	sqlmatriz(4)=" where idperiodo ="+STR(pper_periodo)
	verror=sqlrun(pper_conexion,"periodocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Periodo a facturar ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	vfechad = ""
	vfechah = ""
	SELECT periodocs
	IF !EOF() THEN 
		vfechad = periodocs.fechad
		vfechah = periodocs.fechah
	ENDIF 
	USE IN  periodocs 
	IF EMPTY(vfechad) OR EMPTY(vfechah) THEN 
		RETURN 0	
	ENDIF 

	sqlmatriz(1)=" select b.identidadh, m.*  from bocaservicios b " 
	sqlmatriz(2)=" left join mservicios m on TRIM(m.bocanumero) = TRIM(b.bocanumero) "
	sqlmatriz(3)=" left join importadatosp p on p.idimportap = m.idimportap "
	sqlmatriz(4)=" where b.identidadh ="+STR(pper_identidadh)+" and p.fechad >= '"+vfechad+"' and p.fechah <= '"+vfechah+"' "
	sqlmatriz(5)="       and b.facturar = 'S' and b.habilitado = 'S' "
	verror=sqlrun(pper_conexion,"medicionescs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Telefonia ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	vtotalconsumo  = 0.00
	SELECT medicionescs
	GO TOP 
	IF !EOF() THEN 
		CALCULATE SUM(consumo) TO vtotalconsumo 
		vtotalconsumo = ROUND(vtotalconsumo,2)	
	ENDIF 
	USE 	
	
	* Busco el Abono segun los limites de las Categorias 
	sqlmatriz(1)=" select ifnull(importe,0) as importe from conceptolimit "
	sqlmatriz(4)=" where idconcepto ="+STR(pper_idconcepto)+" and consudesde <= "+ALLTRIM(STR(vtotalconsumo,12,4))+" and "+ALLTRIM(STR(vtotalconsumo,12,4))+" <= consuhasta  "
	verror=sqlrun(pper_conexion,"m3abono")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Agua ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	SELECT m3abono
	GO TOP 
	vtotalabono = 0.00
	IF !EOF() THEN 
		vtotalabono = m3abono.importe
	ENDIF 
	USE 		
	
	RETURN vtotalabono 
ENDFUNC 


*/-----------------------------------------------------------------------------------------------
* Función para Cálculo de M3 Exedente de Agua Potable.
FUNCTION FPAEXEDEM3
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion, pper_c


	sqlmatriz(1)=" select * from factulotes  " 
	sqlmatriz(4)=" where idperiodo ="+STR(pper_periodo)
	verror=sqlrun(pper_conexion,"periodocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Periodo a facturar ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	vfechad = ""
	vfechah = ""
	SELECT periodocs
	IF !EOF() THEN 
		vfechad = periodocs.fechad
		vfechah = periodocs.fechah
	ENDIF 
	USE IN  periodocs 
	IF EMPTY(vfechad) OR EMPTY(vfechah) THEN 
		RETURN 0	
	ENDIF 

	sqlmatriz(1)=" select b.identidadh, m.*  from bocaservicios b " 
	sqlmatriz(2)=" left join mservicios m on TRIM(m.bocanumero) = TRIM(b.bocanumero) "
	sqlmatriz(3)=" left join importadatosp p on p.idimportap = m.idimportap "
	sqlmatriz(4)=" where b.identidadh ="+STR(pper_identidadh)+" and p.fechad >= '"+vfechad+"' and p.fechah <= '"+vfechah+"' "
	sqlmatriz(5)="       and b.facturar = 'S' and b.habilitado = 'S' "
	verror=sqlrun(pper_conexion,"medicionescs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Telefonia ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	vtotalconsumo  = 0.00
	vexedente = 0.00
	SELECT medicionescs
	GO TOP 
	IF !EOF() THEN 
		CALCULATE SUM(consumo) TO vtotalconsumo 
*!*			vexedente = IIF((vtotalconsumo-pper_c < 0 ) ,0 ,ROUND(vtotalconsumo-pper_c,2))
	ENDIF 
	USE 	
	* Busco el Abono segun los limites de las Categorias 
	sqlmatriz(1)=" select ifnull(importe,0) as importe, consudesde, consuhasta from conceptolimit "
	sqlmatriz(2)=" where idconcepto ="+STR(pper_idconcepto)+" and consudesde <= "+ALLTRIM(STR(vtotalconsumo,12,4))+" and consudesde <= "+ALLTRIM(STR(pper_c,12,4))+" and "+ALLTRIM(STR(pper_c,12,4))+" < consuhasta  "
	verror=sqlrun(pper_conexion,"m3consumo")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Agua ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	SELECT m3consumo
	GO TOP 
	
	vtotalm3 = 0.00
	IF !EOF() THEN 
		vtotalm3 = m3consumo.importe

		vexedente_A = ( vtotalconsumo - pper_c )
		vexedente_B = ( vtotalconsumo - m3consumo.consuhasta )
		vexedente_T	= vexedente_A - IIF(vexedente_B < 0, 0, vexedente_B)
		vexedente = IIF(vexedente_T< 0, 0, vexedente_T) 
	ENDIF 
	USE 		
	
	vreto = ALLTRIM(STR(vexedente,12,2))+';'+ALLTRIM(STR(vtotalm3,12,4))
	
	RETURN vreto
	
ENDFUNC 
******************************************************************************



*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ FUNCIONES DE CONCEPTOS PARA CALCULO DE FACTURACION DE ENERGIA ELECTRICA

*** Función para Cálculo Abono Energia Electrica
FUNCTION FPECONSUMO
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion, pper_c


	sqlmatriz(1)=" select * from factulotes  " 
	sqlmatriz(4)=" where idperiodo ="+STR(pper_periodo)
	verror=sqlrun(pper_conexion,"periodocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Periodo a facturar ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	vfechad = ""
	vfechah = ""
	SELECT periodocs
	IF !EOF() THEN 
		vfechad = periodocs.fechad
		vfechah = periodocs.fechah
	ENDIF 
	USE IN  periodocs 
	IF EMPTY(vfechad) OR EMPTY(vfechah) THEN 
		RETURN 0	
	ENDIF 

	sqlmatriz(1)=" select b.identidadh, m.*  from bocaservicios b " 
	sqlmatriz(2)=" left join mservicios m on TRIM(m.bocanumero) = TRIM(b.bocanumero) "
	sqlmatriz(3)=" left join importadatosp p on p.idimportap = m.idimportap "
	sqlmatriz(4)=" where b.identidadh ="+STR(pper_identidadh)+" and p.fechad >= '"+vfechad+"' and p.fechah <= '"+vfechah+"' "
	sqlmatriz(5)="       and b.facturar = 'S' and b.habilitado = 'S' "
	verror=sqlrun(pper_conexion,"medicionescs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Telefonia ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	vtotalconsumo  = 0.00
	vexedente = 0.00
	SELECT medicionescs
	GO TOP 
	IF !EOF() THEN 
		CALCULATE SUM(consumo) TO vtotalconsumo 
	ENDIF 
	USE 	
	* Busco el Abono segun los limites de las Categorias 
	sqlmatriz(1)=" select ifnull(importe,0) as importe, consudesde, consuhasta from conceptolimit "
	sqlmatriz(2)=" where idconcepto ="+STR(pper_idconcepto)+" and consudesde <= "+ALLTRIM(STR(vtotalconsumo,12,4))+" and consudesde <= "+ALLTRIM(STR(pper_c,12,4))+" and "+ALLTRIM(STR(pper_c,12,4))+" < consuhasta  "
	verror=sqlrun(pper_conexion,"m3consumo")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Agua ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	SELECT m3consumo
	GO TOP 
	
	vtotalm3 = 0.00
	IF !EOF() THEN 
		vtotalm3 = m3consumo.importe

		vexedente_A = ( vtotalconsumo - pper_c )
		vexedente_B = ( vtotalconsumo - m3consumo.consuhasta )
		vexedente_T	= vexedente_A - IIF(vexedente_B < 0, 0, vexedente_B)
		vexedente = IIF(vexedente_T< 0, 0, vexedente_T) 
	ENDIF 
	USE 		
	
	vreto = ALLTRIM(STR(vexedente,12,2))+';'+ALLTRIM(STR(vtotalm3,12,4))
	
	RETURN vreto
	
ENDFUNC 
******************************************************************************




*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ FUNCIONES DE CONCEPTOS PARA CALCULO DE FACTURACION DE TELEFONIA CELULAR

*** Función para Cálculo Abono y Cargos de la Telefonia Celular
*** Cargar como parametros el item del cual se quiere obtener el valor 
*** 1-Abono
*** 2-Servicio
*** 3-Cargos
*** 4-Aire
*** 5-Discado Nacional
*** 6-Discado Internacional
*** 7-Minutos
*** 8-Datos
*** 9-Equipos
*** 10-Varios
FUNCTION FPTCELULAR
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion, pper_c

	DO CASE 
		CASE pper_c = 1
			vcampo = 'tabono'
		CASE pper_c = 2
			vcampo = 'tserv'
		CASE pper_c = 3
			vcampo = 'tcargos'
		CASE pper_c = 4
			vcampo = 'taire'
		CASE pper_c = 5
			vcampo = 'tldn'
		CASE pper_c = 6
			vcampo = 'tldi'
		CASE pper_c = 7
			vcampo = 'tldim'
		CASE pper_c = 8
			vcampo = 'tdata'
		CASE pper_c = 9
			vcampo = 'teq'
		CASE pper_c = 10
			vcampo = 'tvarios'
		OTHERWISE 
			vcampo = ""
	ENDCASE 
	
	IF EMPTY(vcampo) THEN 
		RETURN 0.00
	ENDIF 

	sqlmatriz(1)=" select * from factulotes  " 
	sqlmatriz(4)=" where idperiodo ="+STR(pper_periodo)
	verror=sqlrun(pper_conexion,"periodocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Periodo a facturar ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	vfechad = ""
	vfechah = ""
	SELECT periodocs
	IF !EOF() THEN 
		vfechad = periodocs.fechad
		vfechah = periodocs.fechah
	ENDIF 
	USE IN  periodocs 
	IF EMPTY(vfechad) OR EMPTY(vfechah) THEN 
		RETURN 0	
	ENDIF 

	sqlmatriz(1)=" select b.identidadh, m.*  from bocaservicios b " 
	sqlmatriz(2)=" left join factclaro m on TRIM(m.bocanumero) = TRIM(b.bocanumero) "
	sqlmatriz(3)=" left join importadatosp p on p.idimportap = m.idimportap "
	sqlmatriz(4)=" where b.identidadh ="+STR(pper_identidadh)+" and p.fechad >= '"+vfechad+"' and p.fechah <= '"+vfechah+"' "
	sqlmatriz(5)="       and b.facturar = 'S' and b.habilitado = 'S' "
	verror=sqlrun(pper_conexion,"medicionescs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Telefonia ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 


	
	vtotalconsumo  = 0.00
	SELECT medicionescs
	GO TOP 
	IF !EOF() THEN 
		CALCULATE SUM(&vcampo) TO vtotalconsumo 
	ENDIF 
	USE 	
	
	RETURN vtotalconsumo 
	
ENDFUNC 
******************************************************************************



*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ FUNCIONES DE OBTENCION DE VALORES DE MEDICIONES PARA UNA BOCA DE SERVICIO EN UN PERIODO DEL ARCHIVO MSERVICIOS

*** Función de busqueda de Valores para una boca de servicio en un periodo dado
FUNCTION FPXMSERVICIO
PARAMETERS pper_periodo, pper_idbocaser, pper_conexion


	sqlmatriz(1)=" select * from factulotes  " 
	sqlmatriz(2)=" where idperiodo ="+STR(pper_periodo)
	verror=sqlrun(pper_conexion,"periodocs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Periodo a facturar ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	vfechad = ""
	vfechah = ""
	SELECT periodocs
	IF !EOF() THEN 
		vfechad = periodocs.fechad
		vfechah = periodocs.fechah
	ENDIF 
	USE IN  periodocs 
	IF EMPTY(vfechad) OR EMPTY(vfechah) THEN 
		RETURN 0	
	ENDIF 

	sqlmatriz(1)=" select m.*  from bocaservicios b " 
	sqlmatriz(2)=" left join mservicios m on TRIM(m.bocanumero) = TRIM(b.bocanumero) "
	sqlmatriz(3)=" left join importadatosp p on p.idimportap = m.idimportap "
	sqlmatriz(4)=" where b.idbocaser ="+STR(pper_idbocaser)+" and p.fechad >= '"+vfechad+"' and p.fechah <= '"+vfechah+"' "
	sqlmatriz(5)="       and b.facturar = 'S' and b.habilitado = 'S' "
	verror=sqlrun(pper_conexion,"medicionescs")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Mediciones de Telefonia ",0+48+0,"Error")
	    RETURN 0 
	ENDIF 

	vmanterior = 0.00
	vmactual = 0.00
	vconsumo  = 0.00
	SELECT medicionescs
	GO TOP 
	IF !EOF() THEN 
		vmanterior 	= medicionescs.manterior
		vmactual 	= medicionescs.mactual
		vconsumo  	= medicionescs.consumo
	ENDIF 
	USE 	
	
	vreto = ALLTRIM(STR(vmanterior,12,2))+';'+ALLTRIM(STR(vmactual,12,2))+';'+ALLTRIM(STR(vconsumo,12,2))
	
	RETURN vreto
	
ENDFUNC 
******************************************************************************

