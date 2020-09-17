*/ PARAMETROS
*--------------
*/------------------------------------------------------------------------------------------------------------
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



* Función para Cálculo de consumo de CUOTA CAPITAL TELEFONICA .
FUNCTION FPTCCAPITAL
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
*!*		sqlmatriz(2)=" where idconcepto ="+STR(pper_idconcepto)+" and consudesde <= "+ALLTRIM(STR(vtotalconsumo,12,4))+" and "+ALLTRIM(STR(vtotalconsumo,12,4))+" <= consuhasta  "
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


* Función para Cálculo de ENRES AGUA
FUNCTION FPAENRES
PARAMETERS pper_periodo, pper_identidadh, pper_idconcepto, pper_conexion, pper_conceptos, pper_I, pper_A

	vcond = ""
	IF !EMPTY(ALLTRIM(pper_A)) THEN 
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
******************************************************************************
