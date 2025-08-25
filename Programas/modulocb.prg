*********************************************************************
***
*** PROGRAMA PARA ALMACENAR LAS FUNCIONES DEL MÓDULO DE COBRANZA
***
*********************************************************************



FUNCTION ImportarComprobantes
	PARAMETERS p_idcbasociada, p_archivo,p_tablaComprobantes
*#/----------------------------------------
*/ 	Importación de comprobantes desde archivo de intercambio (Archivo de envio .ENV)
** 	Funcion: ImportarComprobantes 
* 	Parametros: 
*		P_idcbasociada: ID de la entidad asociada (Emisor del archivo de envio .ENV)
*		p_archivo: Path completo con el nombre del archivo .ENV
*	Retorno: Retorna 1 si se importó correctamente, 0 en otro caso
*#/----------------------------------------

		IF TYPE('p_idcbasociada') != 'N'
			=messagebox("El ID de la entidad asociada no es válido",16,"Error al Importar comprobantes")
			RETURN 0
		ENDIF 

		p_archivo = alltrim(p_archivo)
		
		IF !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error al Importar comprobantes")
			RETURN 0
		ENDIF
		
		IF EMPTY(ALLTRIM(p_tablaComprobantes)) = .T.
			MESSAGEBOX("Nombre de tabla temporal incorrecta",0+16+0,"Error al Importar comprobantes")
			RETURN 0
		ENDIF 


		** Controlar que el archivo sea de la entidad asociada **
		v_nombreArchivo = ALLTRIM(JUSTSTEM(p_archivo))
		v_extension = ALLTRIM(UPPER(JUSTEXT(p_archivo)))
		
		IF v_extension != 'ENV'
			=messagebox("El Archivo: "+p_archivo+" Tiene una extensión incorrecta, la extensión debe ser .ENV ",16,"Error al Importar comprobantes")
			RETURN 0
		ENDIF 

			
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		** Busco los datos de la entidad asociada pasada como parámetro **
		sqlmatriz(1)= " select * from cbasociadas where idcbasoci = " +ALLTRIM(STR(p_idcbasociada))
		
		verror=sqlrun(vconeccionF,"cbasociada_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al obtener los datos de la entidad asociada ",0+48+0,"Error al Importar comprobantes")
			    RETURN 0
			ENDIF	
			
		SELECT cbasociada_sql
		GO TOP 
		
		IF NOT EOF()
			v_nombArchivoEnv = ALLTRIM(cbasociada_sql.narchivoe)
			v_ultSecEnv	= cbasociada_sql.esecuencia
			
			v_longArcEnv = LEN(v_nombArchivoEnv)
			
			** Compruebo el nombre del archivo **
			v_entArc = SUBSTR(v_nombreArchivo,1,v_longArcEnv)
			v_secArc = SUBSTR(v_nombreArchivo,v_longArcEnv+1)
			
			IF ALLTRIM(v_entArc) != ALLTRIM(v_nombArchivoEnv)
				MESSAGEBOX("El nombre del archivo no se corresponde con la entidad",0+48+0,"Error al Importar comprobantes")
			    RETURN 0	
			ENDIF 
						
			*IF v_ultSecEnv >= VAL(v_secArc)
			IF v_ultSecEnv >= VAL(v_secArc)
				MESSAGEBOX("El número de secuencia del archivo es menor o igual al úlimo ingresado",0+48+0,"Error al Importar comprobantes")
			    RETURN 0	
			ENDIF 
		ELSE
			MESSAGEBOX("No se encuentran los datos de la entidada asociada",0+48+0,"Error al Importar comprobantes")
			RETURN 0
		ENDIF 
			
		v_punteroArcEnv = FOPEN(p_archivo) && Puntero del arhivo
		
		IF v_punteroArcEnv < 0		
			MESSAGEBOX("No se puede abrir el archivo de Envio",0+48+0,"Error al Importar comprobantes")
			RETURN 0
		ENDIF 
		
		** Obtengo información de ubicación de campos en el registro del archivo de envio **
		SELECT cbasociada_sql
		GO TOP 
	
		v_empresaid		= ALLTRIM(cbasociada_sql.empresaid)
		v_elong 		= ALLTRIM(cbasociada_sql.elong)
		v_eempresaid  	= ALLTRIM(cbasociada_sql.eempresaid)
		v_eesecuencia 	= ALLTRIM(cbasociada_sql.eesecuencia)
		v_eperiodo 		= ALLTRIM(cbasociada_sql.eperiodo)
		v_ebc			= ALLTRIM(cbasociada_sql.ebc)
		v_ebceid 		= ALLTRIM(cbasociada_sql.ebceid)
		v_ebcsid		= ALLTRIM(cbasociada_sql.ebcsid)
		v_ebcidcomp 	= ALLTRIM(cbasociada_sql.ebcidcomp)
		v_ebctotal1 	= ALLTRIM(cbasociada_sql.etotal1)
		v_ebcvence1 	= ALLTRIM(cbasociada_sql.evence1)
		v_ebctotal2 	= ALLTRIM(cbasociada_sql.etotal2)
		v_ebcvence2		= ALLTRIM(cbasociada_sql.evence2)
		v_ebctotal3 	= ALLTRIM(cbasociada_sql.etotal3)
		v_ebcvence3 	= ALLTRIM(cbasociada_sql.evence3)
		v_eentidad		= ALLTRIM(cbasociada_sql.eentidad)
		v_eservicio		= ALLTRIM(cbasociada_sql.eservicio)
		v_ecuenta		= ALLTRIM(cbasociada_sql.ecuenta)
		v_edescrip		= ALLTRIM(cbasociada_sql.edescrip)
		v_edescripen	= ALLTRIM(cbasociada_sql.edescripen)		
		v_ecobromax		= ALLTRIM(cbasociada_sql.ecobromax)
				
		v_sentenciaCrea1 = "create table "+ALLTRIM(p_tablaComprobantes)+ " (ident I, narchivo C(100), lote I, eperiodo C(20), esecuencia C(10), comproba C(100),idcomp I, total1 N(13,2), vence1 C(8),total2 N(13,2), vence2 C(8), total3 N(13,2), vence3 C(8), bc C(254), "
		v_sentenciaCrea2 = " eentidad I, eservicio I, ecuenta I, edescrip C(250), edescripen C(250), ecobromax N(13,2))"
		v_sentenciaCrea = v_sentenciaCrea1 + v_sentenciaCrea2
		&v_sentenciaCrea
	
		** Recorro el archivo de envio, linea por linea **	
		DO WHILE NOT FEOF(v_punteroArcEnv) && Finaliza cuando encuentra una linea vacia
				v_linea = ALLTRIM(FGETS(v_punteroArcEnv))
			
				IF EMPTY(v_linea) = .F.
					v_tamLinea = LEN(v_linea)
															
					ALINES(v_longitud,v_elong,'-')
								
					v_tamCodigo = (VAL(v_longitud(2))) - (VAL(v_longitud(1))) + 1 
					
					IF v_tamCodigo > v_tamLinea && COMPRUEBO LONGITUD DEL CODIGO
					
						MESSAGEBOX("Codigo erroneo. La longitud del codigo ("+ALLTRIM(STR(v_tamCodigo))+") es mayor al del registro en el archivo ("+ALLTRIM(STR(v_tamlinea))+")")
						RETURN 0
						&& CODIGO ERRONEO
					ELSE
						&& CODIGO CORRECTO
												
						** Código Empresa **
						ALINES(ARR_eempresaid,v_eempresaid,'-')
						COD_eempresaid = SUBSTR(v_linea,VAL(ARR_eempresaid(1)),VAL(ARR_eempresaid(2)))
						
						** Código de secuencia de envío **
						ALINES(ARR_eesecuencia,v_eesecuencia,'-')
						COD_eesecuencia = SUBSTR(v_linea,VAL(ARR_eesecuencia(1)),VAL(ARR_eesecuencia(2)))
					
						
						IF ALLTRIM(v_empresaid) == ALLTRIM(COD_eempresaid) AND ALLTRIM(v_secArc) == ALLTRIM(COD_eesecuencia) 
							
							** Período de Facturación **
							ALINES(ARR_eperiodo,v_eperiodo,'-')
							COD_eperiodo = SUBSTR(v_linea,VAL(ARR_eperiodo(1)),VAL(ARR_eperiodo(2)))

							** Código de Barra Completo **
							ALINES(ARR_ebc,v_ebc,'-')
							COD_ebc = SUBSTR(v_linea,VAL(ARR_ebc(1)),VAL(ARR_ebc(2)))

							** Código de Empresa (en código de barra) **
							ALINES(ARR_ebceid,v_ebceid,'-')
							COD_ebceid = SUBSTR(v_linea,VAL(ARR_ebceid(1)),VAL(ARR_ebceid(2)))

							** Subcódigo de Empresa(en código de barra) **
							ALINES(ARR_ebcsid,v_ebcsid,'-')
							COD_ebcsid = SUBSTR(v_linea,VAL(ARR_ebcsid(1)),VAL(ARR_ebcsid(2)))
						
							** Código del comprobante (en código de barra) **
							ALINES(ARR_ebcidcomp,v_ebcidcomp,'-')
							COD_ebcidcomp = SUBSTR(v_linea,VAL(ARR_ebcidcomp(1)),VAL(ARR_ebcidcomp(2)))
							
							** Convierto el idcomprobante a numero **
							NUM_ebcidcomp = VAL(COD_ebcidcomp)
							** Fecha del primer vencimiento (en código de barra) **
							ALINES(ARR_ebcvence1,v_ebcvence1,'-')
							COD_ebcvence1 = SUBSTR(v_linea,VAL(ARR_ebcvence1(1)),VAL(ARR_ebcvence1(2)))
							
							** Importe del primer vencimiento **
							ALINES(ARR_ebctotal1,v_ebctotal1,'-')
							COD_ebctotal1 = SUBSTR(v_linea,VAL(ARR_ebctotal1(1)),VAL(ARR_ebctotal1(2)))
														
							** Convierto COD_ebctotal1 a float **
							v_NUM_entt1 = VAL(COD_ebctotal1)
							NUM_ebctotal1 = (v_NUM_entt1/100)
							
							** Fecha del segundo vencimiento (en código de barra) **
							ALINES(ARR_ebcvence2,v_ebcvence2,'-')
							COD_ebcvence2 = SUBSTR(v_linea,VAL(ARR_ebcvence2(1)),VAL(ARR_ebcvence2(2)))
							
							** Importe del segundo vencimiento (en código de barra) **
							ALINES(ARR_ebctotal2,v_ebctotal2,'-')
							COD_ebctotal2 = SUBSTR(v_linea,VAL(ARR_ebctotal2(1)),VAL(ARR_ebctotal2(2)))
							
							** Convierto COD_ebctotal1 a float **
							v_NUM_entt2 = VAL(COD_ebctotal2)
							NUM_ebctotal2 = (v_NUM_entt2/100)
							
							** Fecha del tercer vencimiento (en código de barra) **
							ALINES(ARR_ebcvence3,v_ebcvence3,'-')
							COD_ebcvence3 = SUBSTR(v_linea,VAL(ARR_ebcvence3(1)),VAL(ARR_ebcvence3(2)))
							
							** Importe del tercer vencimiento (en código de barra) **
							ALINES(ARR_ebctotal3,v_ebctotal3,'-')
							COD_ebctotal3 = SUBSTR(v_linea,VAL(ARR_ebctotal3(1)),VAL(ARR_ebctotal3(2)))
							
							** Convierto COD_ebctotal1 a float **
							v_NUM_entt3 = VAL(COD_ebctotal3)
							NUM_ebctotal3 = (v_NUM_entt3/100)
							
							
							** Código de Entidad **
							ALINES(ARR_eentidad,v_eentidad,'-')
							COD_eentidad = SUBSTR(v_linea,VAL(ARR_eentidad(1)),VAL(ARR_eentidad(2)))
													
							
							** Código de Entidad **
							ALINES(ARR_eservicio,v_eservicio,'-')
							COD_eservicio = SUBSTR(v_linea,VAL(ARR_eservicio(1)),VAL(ARR_eservicio(2)))
							
						
							** Código de Cuenta  **
							ALINES(ARR_ecuenta,v_ecuenta,'-')
							COD_ecuenta = SUBSTR(v_linea,VAL(ARR_ecuenta(1)),VAL(ARR_ecuenta(2)))

							** Descripción de comprobante**
							ALINES(ARR_edescrip,v_edescrip,'-')
							COD_edescrip = SUBSTR(v_linea,VAL(ARR_edescrip(1)),VAL(ARR_edescrip(2)))
							
							** Descripción de entidad**
							ALINES(ARR_edescripen,v_edescripen,'-')
							COD_edescripen = SUBSTR(v_linea,VAL(ARR_edescripen(1)),VAL(ARR_edescripen(2)))
							
							** Cobro maximo diario**
							ALINES(ARR_ecobromax,v_ecobromax,'-')
							COD_ecobromax = SUBSTR(v_linea,VAL(ARR_ecobromax(1)),VAL(ARR_ecobromax(2)))
							
							** Convierto COD_ecobromax a float **
							v_NUM_ecobm = VAL(COD_ecobromax)
							NUM_ecobromax = (v_NUM_ecobm/100)
							
							v_lote = 0
							
																									
							v_sentenciaIns1 = " insert into "+ALLTRIM(p_tablaComprobantes)+ " (ident, narchivo, lote, eperiodo, esecuencia, idcomp, total1, vence1,total2, vence2, total3, vence3, bc,eentidad,eservicio,ecuenta,edescrip, edescripen, ecobromax) "
							v_sentenciaIns2 = " values ("+ALLTRIM(STR(p_idcbasociada))+",'"+ALLTRIM(v_nombArchivoEnv)+"',"+ALLTRIM(STR(v_lote))+",'"+ALLTRIM(COD_eperiodo)+"','"+ALLTRIM(COD_eesecuencia)+"',"+ALLTRIM(STR(NUM_ebcidcomp))+","
							v_sentenciaIns3 = ALLTRIM(STR(NUM_ebctotal1,13,2))+",'"+ALLTRIM(COD_ebcvence1)+"',"+ALLTRIM(STR(NUM_ebctotal2,13,2))+",'"+ALLTRIM(COD_ebcvence2)+"',"+ALLTRIM(STR(NUM_ebctotal3,13,2))+",'"+ALLTRIM(COD_ebcvence3)+"','"+alltrim(COD_ebc)+"',"
							v_sentenciaIns4 = ALLTRIM(COD_eentidad)+","+ALLTRIM(COD_eservicio)+","+ALLTRIM(COD_ecuenta)+",'"+ALLTRIM(COD_edescrip)+"','"+ALLTRIM(COD_edescripen)+"',"+ALLTRIM(STR(NUM_ecobromax,13,2))+")"
							

							v_sentenciaIns = v_sentenciaIns1+v_sentenciaIns2+v_sentenciaIns3+v_sentenciaIns4
							
							&v_sentenciaIns
				
							
						ELSE
							** Código de empresa y secuencia no coincide con el codigo de la empresa y secuencia pasado en el registro del archivo **
					
						ENDIF 
										
					ENDIF 
				ENDIF 

			SKIP 1	
		ENDDO 
		FCLOSE(v_punteroArcEnv)
	RETURN 1

ENDFUNC  

FUNCTION buscarCompCB
PARAMETERS p_codBarra,P_nombreTabla
*#/----------------------------------------
*/ 	Busca un comprobante por el código de barra
** 	Funcion: buscaCompCB
* 	Parametros: 
*		p_codBarra: Código de barras para buscar el comprobante
*		p_NombreTabla: Nombre de la tabla donde se van a devolver los datos del comprobante buscado
*	Retorno: Retorna True si se encontró el comprobante, False en otro caso
*#/----------------------------------------

	v_encontrado = .F.

	IF EMPTY(ALLTRIM(p_codBarra)) = .F. AND EMPTY(ALLTRIM(p_nombreTabla)) = .T.
	
		MESSAGEBOX("Uno de los parámetros es incorrecto", 0+16,"Error al buscar comprobante por código de barra")
		
		RETURN .F.
	
	ENDIF 

	* Me conecto a la base de datos
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="select idcbcompro, idcbasoci, narchivo, lote, eperiodo, esecuencia, descrip as compro, entidad, servicio, cuenta, descripen,"
	sqlmatriz(2)=" total1, vence1, total2, vence2, total3, vence3,bc, timestamp,codigo " && Busco en la vista donde voy a tener los ultimos comprobantes ordenados por lote
	sqlmatriz(3)=" from ultcbcomplote " 
	sqlmatriz(4)=" where bc ='"+ALLTRIM(p_codBarra)+"'"

	verror=sqlrun(vconeccionD,"comprobante_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		return	.F.
	ELSE
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		SELECT comprobante_sql
		GO TOP 
		
		IF NOT EOF()
			SELECT comprobante_sql
			v_cantBusq = RECCOUNT()
			
			IF v_cantBusq > 0
				SELECT * FROM comprobante_sql INTO TABLE &p_nombreTabla	
				
				v_encontrado = .T.
				
			ENDIF 
		
		ENDIF 

				
		ENDIF 



	RETURN v_encontrado

ENDFUNC 



FUNCTION buscarCompESC
PARAMETERS p_codEnt,p_subCodEnt,p_idcomp,P_nombreTabla
*#/----------------------------------------
*/ 	Busca un comprobante por los codigos de empresa,subcodigo y idcomp
** 	Funcion: buscaCompESC
* 	Parametros: 
*		p_codEnt: Código asignado a la entidad asociada
*		p_subCodEnt: Subcódigo asignado a la entidad asociada
*		p_idcomp: ID del comprobante asociado a la entidad
*		p_NombreTabla: Nombre de la tabla donde se van a devolver los datos del comprobante buscado
*	Retorno: Retorna True si se encontró el comprobante, False en otro caso
*#/----------------------------------------

	v_encontrado = .F.

	IF p_codEnt <= 0 AND p_subCodEnt <= 0 AND p_idcomp <= 0AND EMPTY(ALLTRIM(p_nombreTabla)) = .T.
	
		MESSAGEBOX("Uno de los parámetros es incorrecto", 0+16,"Error al buscar comprobante por código")
		
		RETURN .F.
	
	ENDIF 

	** Genero el código para buscar en la visa de ultComprobante **
	
	v_codigoBusEnt = ALLTRIM(REPLICATE('0',4-LEN(ALLTRIM(str(p_codEnt))))+ALLTRIM(str(p_codEnt)))
	v_codigoBusSub = ALLTRIM(REPLICATE('0',4-LEN(ALLTRIM(str(p_subCodEnt))))+ALLTRIM(str(p_subCodEnt)))
	v_codigoBusCom = ALLTRIM(REPLICATE('0',15-LEN(ALLTRIM(str(p_idcomp))))+ALLTRIM(str(p_idcomp)))
	
	v_codigoBusqueda = ALLTRIM(v_codigoBusEnt)+ALLTRIM(v_codigoBusSub)+ALLTRIM(v_codigoBusCom)

	* Me conecto a la base de datos
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="select idcbcompro, idcbasoci, narchivo, lote, eperiodo, esecuencia,descrip as compro, entidad, servicio, cuenta, descripen, "
	sqlmatriz(2)=" total1, vence1, total2, vence2, total3, vence3,bc, timestamp,codigo " && Busco en la vista donde voy a tener los ultimos comprobantes ordenados por lote
	sqlmatriz(3)=" from ultcbcomplote " 
	sqlmatriz(4)=" where codigo ='"+ALLTRIM(v_codigoBusqueda)+"'"

	verror=sqlrun(vconeccionD,"comprobante_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		return	.F.
	ELSE
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		SELECT comprobante_sql
		GO TOP 
		
		IF NOT EOF()
			SELECT comprobante_sql
			v_cantBusq = RECCOUNT()
			
			IF v_cantBusq > 0
				SELECT * FROM comprobante_sql INTO TABLE &p_nombreTabla	
				
				v_encontrado = .T.
				
			ENDIF 
		
		ENDIF 

				
		ENDIF 



	RETURN v_encontrado

ENDFUNC 




FUNCTION buscarCompESCN
PARAMETERS p_Ent,p_Serv,p_cta, p_pvta,p_numcomp,P_nombreTabla
*#/----------------------------------------
*/ 	Busca un comprobante por los codigos de Entidad, servicio, cuenta, pto vta y numero de comprobante
** 	Funcion: buscarCompESCN
* 	Parametros: 
*		p_Ent: Código de la entidad
*		p_Serv: Código del servicio
*		p_cta: Código de la cuenta
*		p_pvta: Punto de venta del comprobante
*		p_numcomp: Número del comprobante
*		p_NombreTabla: Nombre de la tabla donde se van a devolver los datos del comprobante buscado
*	Retorno: Retorna True si se encontró el comprobante, False en otro caso
*#/----------------------------------------

	v_encontrado = .F.

	IF p_Ent <= 0 AND p_Serv < 0 AND p_cta< 0 AND p_pvta <= 0 AND p_numcomp <= 0 AND EMPTY(ALLTRIM(p_nombreTabla)) = .T.
	
		MESSAGEBOX("Uno de los parámetros es incorrecto", 0+16,"Error al buscar comprobante por Entidad-Comprobante")
		
		RETURN .F.
	
	ENDIF 

	** Genero el código para buscar en la vista de ultComprobante **
	
	v_nrocompstr = ALLTRIM(STR(p_numcomp))
	
	v_lenstr = LEN(v_nrocompstr)
	
	
	v_codigoBusComp = ALLTRIM("%"+ALLTRIM(STR(p_pvta))+"-"+REPLICATE('0',(8-v_lenstr)))+ALLTRIM(v_nrocompstr)
	

	* Me conecto a la base de datos
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="select idcbcompro, idcbasoci, narchivo, lote, eperiodo, esecuencia,descrip as compro, entidad, servicio, cuenta, descripen, "
	sqlmatriz(2)=" total1, vence1, total2, vence2, total3, vence3,bc, timestamp,codigo " && Busco en la vista donde voy a tener los ultimos comprobantes ordenados por lote
	sqlmatriz(3)=" from ultcbcomplote " 
	sqlmatriz(4)=" where entidad = "+ALLTRIM(STR(p_ent))+" and servicio = "+ALLTRIM(STR(p_serv))+" and cuenta = "+ALLTRIM(STR(p_cta))+" and descrip like '"+ALLTRIM(v_codigoBusComp)+"'"

	
	verror=sqlrun(vconeccionD,"comprobante_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		return	.F.
	ELSE
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		SELECT comprobante_sql
		GO TOP 
		
		IF NOT EOF()
			SELECT comprobante_sql
			v_cantBusq = RECCOUNT()
			
			IF v_cantBusq > 0
				SELECT * FROM comprobante_sql INTO TABLE &p_nombreTabla	
				
				v_encontrado = .T.
				
			ENDIF 
		
		ENDIF 

				
		ENDIF 



	RETURN v_encontrado

ENDFUNC 




FUNCTION listaCompESE
PARAMETERS p_codEmp,p_subCodEmp,p_entidad,P_nombreTabla
*#/----------------------------------------
*/ Lista todos los comprobantes asociados a empresa,subcodigo y entidad
** 	Funcion: listaCompESE
* 	Parametros: 
*		p_codEnt: Código asignado a la empresa asociada
*		p_subCodEnt: Subcódigo asignado a la empresa asociada
*		p_entidad: ID de la entidad asociada
*		p_NombreTabla: Nombre de la tabla donde se van a devolver los datos de los comprobantes buscados
*	Retorno: Retorna True si se encontró comprobantes, False en otro caso
*#/----------------------------------------

	v_encontrado = .F.

	IF p_codEmp <= 0 AND p_subCodEmp <= 0 AND p_entidad <= 0 AND EMPTY(ALLTRIM(p_nombreTabla)) = .T.
	
		MESSAGEBOX("Uno de los parámetros es incorrecto", 0+16,"Error al buscar comprobante por código")
		
		RETURN .F.
	
	ENDIF 

	** Genero el código para buscar en la visa de ultComprobante **
	
	v_codigoBusEmp = ALLTRIM(REPLICATE('0',4-LEN(ALLTRIM(str(p_codEmp))))+ALLTRIM(str(p_codEmp)))
	v_codigoBusSub = ALLTRIM(REPLICATE('0',4-LEN(ALLTRIM(str(p_subCodEmp))))+ALLTRIM(str(p_subCodEmp)))
	*v_codigoBusCom = ALLTRIM(REPLICATE('0',15-LEN(ALLTRIM(str(p_idcomp))))+ALLTRIM(str(p_idcomp)))
	
	v_codigoBusqueda = ALLTRIM(v_codigoBusEmp)+ALLTRIM(v_codigoBusSub)

	* Me conecto a la base de datos
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="select idcbcompro, idcbasoci, narchivo, lote, eperiodo, esecuencia,descrip as compro, total1, vence1, total2, vence2, total3, vence3,bc, timestamp,codigo " && Busco en la vista donde voy a tener los ultimos comprobantes ordenados por lote
	sqlmatriz(2)=" from ultcbcomplote " 
	sqlmatriz(3)=" where SUBSTR(codigo,1,8) ='"+ALLTRIM(v_codigoBusqueda)+"' and entidad = "+ALLTRIM(STR(p_entidad))

	verror=sqlrun(vconeccionD,"comprobante_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		return	.F.
	ELSE
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		SELECT comprobante_sql
		GO TOP 
		
		IF NOT EOF()
			SELECT comprobante_sql
			v_cantBusq = RECCOUNT()
			
			IF v_cantBusq > 0
				SELECT * FROM comprobante_sql INTO TABLE &p_nombreTabla	
				
				v_encontrado = .T.
				
			ENDIF 
		
		ENDIF 

				
		ENDIF 



	RETURN v_encontrado

ENDFUNC 



FUNCTION obtenerMaxLoteCobro
*#/----------------------------------------
*/ 	Obtiene el Lote de cobro máximo utilizado
** 	Funcion: obtenerMaxLoteCobro
* 	
*	Retorno: Retorna el Lote máximo, en caso de no haber lotes de cobranza retorna cero. Retorna -1 en caso de error
*#/----------------------------------------

	v_loteMaxCobro = 0
	
	* Me conecto a la base de datos
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)=" select MAX(lotecobro) as lotemax "
	sqlmatriz(2)=" from cbcobros " 

	verror=sqlrun(vconeccionD,"cbmaxcobro_sql")
	IF verror=.f. 
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA lote máximo ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		return	-1
	ELSE
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		SELECT cbmaxcobro_sql
		GO TOP 
		
		IF NOT EOF()
		
			v_loteMaxCobro = IIF(ISNULL(cbmaxcobro_sql.lotemax)=.T.,0,cbmaxcobro_sql.lotemax)
		
		ENDIF 
					
	ENDIF 

	RETURN v_loteMaxCobro 

ENDFUNC 




FUNCTION calculaSecuenciaMax
PARAMETERS p_idcbasociado
*#/----------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por la entidad pasada como parámetro
** 	Funcion: calculaSecueciaMax
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*#/----------------------------------------

IF p_idcbasociado  > 0
	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT max(cc.secuencia) as maxsec "
	sqlmatriz(2)=" FROM cbcobros cc left join cbcomprobantes cp on cc.idcbcompro = cp.idcbcompro "
	sqlmatriz(3)=" WHERE cp.idcbasoci = "+ALLTRIM(STR(p_idcbasociado))

	verror=sqlrun(vconeccionD,"maxSecuencia_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Datos ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

	    RETURN -1
	ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		v_maxsec = maxSecuencia_sql.maxsec
		v_maxsec = IIF(TYPE('v_maxsec')=='C', VAL(v_maxsec),v_maxsec)
	 RETURN v_maxsec
	 
ELSE
	RETURN  -1
ENDIF 

ENDFUNC 



FUNCTION calculaSecMaxCobrador
PARAMETERS p_idcobrador
*#/----------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por el cobrador pasado como parámetro
** 	Funcion: calculaSecueciaMaxCobrador
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*#/----------------------------------------

IF p_idcobrador  > 0
	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)=" SELECT ifnull(max(secuencia),0) as maxsec "
	sqlmatriz(2)=" FROM cbcobrados "
	sqlmatriz(3)=" WHERE idcbcobra = "+ALLTRIM(STR(p_idcobrador))

	verror=sqlrun(vconeccionD,"maxSecuencia_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Datos ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

	    RETURN -1
	ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		v_maxsec = maxSecuencia_sql.maxsec
		v_maxsec = IIF(TYPE('v_maxsec')=='C', VAL(v_maxsec),v_maxsec)
	 RETURN v_maxsec
	 
ELSE
	RETURN  -1
ENDIF 

ENDFUNC 



FUNCTION calculaSecuenciaMaxCob
PARAMETERS p_idcbcobrador
*#/----------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por el cobrador pasada como parámetro
** 	Funcion: calculaSecueciaMaxCob
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*#/----------------------------------------

IF p_idcbcobrador  > 0
	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT MAX(c.esecuencia) as maxsec "
	sqlmatriz(2)=" FROM cbcobrador c "
	sqlmatriz(3)=" WHERE c.idcbcobra = "+ALLTRIM(STR(p_idcbcobrador))

	verror=sqlrun(vconeccionD,"maxSecuencia_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Datos ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

	    RETURN -1
	ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		v_maxsec = maxSecuencia_sql.maxsec
		v_maxsec = IIF(TYPE('v_maxsec')=='C', VAL(v_maxsec),v_maxsec)
	 RETURN v_maxsec
	 
ELSE
	RETURN  -1
ENDIF 

ENDFUNC 



FUNCTION calculaSecuenciaMaxImp
PARAMETERS p_idcbasociada
*#/----------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada en la importación de comprobantes por el cobrador pasada como parámetro
** 	Funcion: calculaSecueciaMaxCob
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*#/----------------------------------------


IF p_idcbasociada > 0
	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT ifnull(MAX(cast(esecuencia as UNSIGNED)),0) as maxsec "
	sqlmatriz(2)=" FROM cbcomprobantes c "
	sqlmatriz(3)=" WHERE c.idcbasoci = "+ALLTRIM(STR(p_idcbasociada))

	verror=sqlrun(vconeccionD,"maxSecuencia_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Datos ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

	    RETURN -1
	ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		v_maxsec = maxSecuencia_sql.maxsec
	
		v_maxsec = IIF(TYPE('v_maxsec')=='C', VAL(v_maxsec),v_maxsec)
	 RETURN v_maxsec
	 
ELSE
	RETURN  -1
ENDIF 

ENDFUNC 



FUNCTION calculaLoteMax
*#/----------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada para los lotes de cobros
** 	Funcion: calculaLoteMax
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*#/----------------------------------------

	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT ifnull(max(loteimp),0) as maxlote "
	sqlmatriz(2)=" FROM cbcobrados "

	verror=sqlrun(vconeccionD,"maxLote_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Datos ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

	    RETURN -1
	ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		v_maxLote = maxLote_sql.maxlote
		v_maxLote = IIF(TYPE('v_maxLote')=='C', VAL(v_maxLote),v_maxLote)
	 RETURN v_maxLote
	 

ENDFUNC 




FUNCTION calculaLoteMaxImp
*#/----------------------------------------
*/ 	Obtiene el Máximo valor de lote de importación
** 	Funcion: calculaLoteMaxImp
* 	
*	Retorno: Retorna el número de Lote Máximo. Retorna -1 en caso de error
*#/----------------------------------------

	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT ifnull(max(lote),0) as maxlote "
	sqlmatriz(2)=" FROM cbcomprobantes "

	verror=sqlrun(vconeccionD,"maxLoteimp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Datos ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

	    RETURN -1
	ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		v_maxLoteImp = maxLoteimp_sql.maxlote
		v_maxLoteImp = IIF(TYPE('v_maxLoteImp')=='C', VAL(v_maxLoteImp),v_maxLoteImp)
	 RETURN v_maxLoteImp
	 

ENDFUNC 




FUNCTION ExportarCobro
	PARAMETERS p_idcbasociada, p_archivo,p_tablaCobros, p_cbptoreca, p_omitirvalidacion
*#/----------------------------------------
*/ 	Exportación de cobros al archivo de intercambio (Archivo de retorno .RET)
** 	Funcion: ExportarCobro
* 	Parametros: 
*		P_idcbasociada: ID de la entidad asociada (Receptor del archivo .RET)
*		p_archivo: Path completo con el nombre del archivo .RET
*		p_tablaCobros: tabla con los datos de los cobros a exportar
*		p_cbptoreca: parametro opcional con el id del punto de recadudación, si no se pasa se toma de la variable: _SYSCBPTORECA
*		p_omitirvalidacion: Variable para omitir la validación de la secuencia de envio
*	Retorno: Retorna 1 si se exportó correctamente, 0 en otro caso
*#/----------------------------------------

		IF TYPE('p_idcbasociada') != 'N'
			=messagebox("El ID de la entidad asociada no es válido",16,"Error al Exportar los cobros")
		ENDIF 

		p_archivo = alltrim(p_archivo)
		
*!*			IF !file(p_archivo) THEN
*!*				=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error al Exportar los cobros")
*!*				RETURN 0
*!*			ENDIF
		
		IF EMPTY(ALLTRIM(p_tablaCobros)) = .T.
			MESSAGEBOX("Nombre de tabla temporal incorrecta",0+16+0,"Error al Exportar los cobros")
			RETURN 0
		ENDIF 
		
		IF USED(p_tablaCobros) = .F.
			MESSAGEBOX("La tabla pasada como parámetro no existe",0+16+0,"Error al Exportar los cobros")
			RETURN 0
		ENDIF 


		** Controlar que el archivo sea de la entidad asociada **
		v_nombreArchivo = ALLTRIM(JUSTSTEM(p_archivo))
		v_extension = ALLTRIM(UPPER(JUSTEXT(p_archivo)))
		
		IF v_extension != 'RET'
			=messagebox("El Archivo: "+p_archivo+" Tiene una extensión incorrecta, la extensión debe ser .RET ",16,"Error al Exportar cobros")
			RETURN 0
		ENDIF 

			
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		** Busco los datos de la entidad asociada pasada como parámetro **
		sqlmatriz(1)= " select * from cbasociadas where idcbasoci = " +ALLTRIM(STR(p_idcbasociada))
		
		verror=sqlrun(vconeccionF,"cbasociada_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al obtener los datos de la entidad asociada ",0+48+0,"Error al Importar comprobantes")
			    RETURN 0
			ENDIF	
			
		SELECT cbasociada_sql
		GO TOP 
		
		IF NOT EOF()
			v_nombArchivoRet = ALLTRIM(cbasociada_sql.narchivor)
			
			 v_ultSecRet = calculaSecuenciaMax(p_idcbasociada)

		
			v_longArcRet = LEN(v_nombArchivoRet)
			
			** Compruebo el nombre del archivo **
			v_entArc = SUBSTR(v_nombreArchivo,1,v_longArcRet)
			v_secArc = SUBSTR(v_nombreArchivo,v_longArcRet+1)
			
			IF ALLTRIM(v_entArc) != ALLTRIM(v_nombArchivoRet)
				MESSAGEBOX("El nombre del archivo no se corresponde con la entidad",0+48+0,"Error al Importar comprobantes")
			    RETURN 0	
			ENDIF 
						
			IF p_omitirvalidacion = .F. AND v_ultSecRet >= VAL(v_secArc)
				MESSAGEBOX("El número de secuencia del archivo es menor o igual al úlimo ingresado",0+48+0,"Error al Exportar Cobros")
			    RETURN 0	
			ENDIF 
		ELSE
			MESSAGEBOX("No se encuentran los datos de la entidada asociada",0+48+0,"Error al Exportar Cobros")
			RETURN 0
		ENDIF 
			
		
		** Obtengo información de ubicación de campos en el registro del archivo de retorno **
		SELECT cbasociada_sql
		GO TOP 
	
		
		v_ridcobro 	= ALLTRIM(cbasociada_sql.r1idcobro)
		v_rfechacobro 		= ALLTRIM(cbasociada_sql.r1fechacobro)
		v_rimporte			= ALLTRIM(cbasociada_sql.r1importe)
		v_rrecargo 		= ALLTRIM(cbasociada_sql.r1recargo)
		v_rbc		= ALLTRIM(cbasociada_sql.r1bc)
		v_rcantidad 	= ALLTRIM(cbasociada_sql.r2cantidad)
		v_rtotal 	= ALLTRIM(cbasociada_sql.r2total)

			
		SELECT &p_tablaCobros
		GO TOP 

		
		IF NOT EOF()
		
			** Creo el archivo **
			v_adminArc = FCREATE(p_archivo)
		
		
		
			****************
			*** LINEA 0 ****
			****************
		
			v_linea0 = "0"
		
			** Código Empresa/Ente **
			
			v_empresaid = &p_tablaCobros..empresaid
							
			v_rmpresaid		= ALLTRIM(cbasociada_sql.r0empresaid)
			ALINES(ARR_rempresaid,v_rmpresaid,'-')
			v_tamempid = VAL(ARR_rempresaid(2))
						
			IF LEN(ALLTRIM(STR(v_empresaid))) <= v_tamempid 
				v_rempresaidstr = ALLTRIM(REPLICATE('0',v_tamempid-LEN(ALLTRIM(STR(v_empresaid))))+ALLTRIM(STR(v_empresaid)))
				v_linea0 = v_linea0+v_rempresaidstr && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'empresaID' representado en el campo 'r0empresaid' es mayor al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
			
			
			 ** Código Punto recaudación **
			 v_idptoRecauda = ALLTRIM(_SYSCBPTORECA)
			
			 IF TYPE('p_cbptoreca') = 'L'
			 	v_idptoRecauda = ALLTRIM(_SYSCBPTORECA)
			 ELSE
			 	IF TYPE('p_cbptoreca') = 'C'
			 		v_idptoRecauda = ALLTRIM(p_cbptoreca)
			 	ELSE
			 		v_idptoRecauda = ALLTRIM(_SYSCBPTORECA)
			 	ENDIF 
			 ENDIF 
			  
			
	
			v_rpuntorec		= ALLTRIM(cbasociada_sql.r0puntorec)
	
			ALINES(ARR_rpuntorec,v_rpuntorec,'-')
			v_tamptorec = VAL(ARR_rpuntorec(2))
			
						
			IF LEN(ALLTRIM(v_idptoRecauda)) = v_tamptorec
				
				v_linea0 = v_linea0+v_idptoRecauda && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'punto de recaudación' representado en el campo 'r0puntorec' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
			
			
			
			** Código de secuencia de Retorno **
			v_rsecuncia  	= ALLTRIM(cbasociada_sql.r0secuencia)
			ALINES(ARR_rsecuencia,v_rsecuncia,'-')

			v_tamrsec = VAL(ARR_rsecuencia(2))
			IF LEN(ALLTRIM(v_secArc)) = v_tamrsec 
				
				v_linea0 = v_linea0+v_secArc && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'secuencia de retorno' representado en el campo 'r0secuencia' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
				
			** Registro la LINEA0 en el Archivo
			FPUTS(v_adminArc,v_linea0 )
		
			***************
			* FIN LINEA 0 *
			***************
			
			v_cantidadCobros = 0
			v_TotalCobros = 0.00
			
			****************
			*** LINEA 1 ****
			****************
				
		
			SELECT &p_tablaCobros
			GO TOP 
			DO WHILE NOT EOF()
			v_linea1  = "1"
			
			** Código Cobro **
			
			v_idcbcobro = &p_tablaCobros..idcbcobro
						
			v_ridcobro	= ALLTRIM(cbasociada_sql.r1idcobro)
			ALINES(ARR_ridcobro,v_ridcobro,'-')
			v_tamrcobro = VAL(ARR_ridcobro(2))
							
					
			IF LEN(ALLTRIM(STR(v_idcbcobro))) <= v_tamrcobro
				v_ridcobrostr = ALLTRIM(REPLICATE('0',v_tamrcobro-len(ALLTRIM(STR(v_idcbcobro))))+ALLTRIM(STR(v_idcbcobro)))
				
				v_linea1 = v_linea1+v_ridcobrostr && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'IDcbCobro' representado en el campo 'r1idcobro' es mayor al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
			
			
			** Código Fecha Cobro **
			
			v_fechaCob = &p_tablaCobros..fechacob
						
			v_RfechaCob = ALLTRIM(cbasociada_sql.r1fechacobro)
			ALINES(ARR_rfechacob,v_RfechaCob,'-')
			v_tamrfechacob = VAL(ARR_rfechacob(2))
			
							
			
			** Convierto la fecha a formato Juliano **
			
			**SYS(11,DATE(2021,08,09))
						
			v_fechaCobJ = SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaCob,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaCob,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaCob,7,2)))))
			
								
			IF LEN(ALLTRIM(v_fechaCobJ)) = v_tamrfechacob 
			*	v_ridcobrostr = ALLTRIM(REPLICATE('0',v_tamrcobro-len(ALLTRIM(STR(v_idcbcobro))))+ALLTRIM(STR(v_idcbcobro)))
				
				v_linea1 = v_linea1+ALLTRIM(v_fechaCobJ) && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'fechaCobro' representado en el campo 'r1fechacobro' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
			



			** Código Importe Cobro **
			
			v_importeCob = &p_tablaCobros..importecob
						
			v_RimpCob = ALLTRIM(cbasociada_sql.r1importe)
			ALINES(ARR_rimpcob,v_RimpCob,'-')
			v_tamrimportecob = VAL(ARR_rimpcob(2))
			
							
			v_importeCobStr = ALLTRIM(STR(v_importeCob * 100))
								
			IF LEN(ALLTRIM(v_importeCobStr)) <= v_tamrimportecob 
				v_rimporteCobstr = ALLTRIM(REPLICATE('0',v_tamrimportecob - len(ALLTRIM(v_importeCobStr)))+ALLTRIM(v_importeCobStr))
				
				v_linea1 = v_linea1+ALLTRIM(v_rimporteCobstr) && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'importe Cobro' representado en el campo 'r1importe' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF

			
			
			** Código Recargo Cobro **
			
			v_recargoCob = &p_tablaCobros..recargocob
						
			v_RrecargoCob = ALLTRIM(cbasociada_sql.r1recargo)
			ALINES(ARR_rReccob,v_RrecargoCob,'-')
			v_tamrReccob = VAL(ARR_rReccob(2))
			
							
			v_recCobStr = ALLTRIM(STR(v_recargoCob * 100))
								
			IF LEN(ALLTRIM(v_recCobStr)) <= v_tamrReccob 
				v_rRecCobstr = ALLTRIM(REPLICATE('0',v_tamrReccob - len(ALLTRIM(v_recCobStr)))+ALLTRIM(v_recCobStr))
				
				v_linea1 = v_linea1+ALLTRIM(v_rRecCobstr) && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'Recargo Cobro' representado en el campo 'r1recargo' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
			
			
			
			
			
			** Código de Barras **
			
			v_cbCob = &p_tablaCobros..cb
						
			v_Rcb = ALLTRIM(cbasociada_sql.r1bc)
			ALINES(ARR_rCB,v_Rcb,'-')
			v_tamrCB = VAL(ARR_rCB(2))
			
			
	
			IF LEN(ALLTRIM(v_cbCob)) = v_tamrCB 
			*	v_rRecCobstr = ALLTRIM(REPLICATE('0',v_tamrReccob - len(ALLTRIM(v_recCobStr)))+ALLTRIM(v_recCobStr))
				
				v_linea1 = v_linea1+ALLTRIM(v_cbCob) && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("r0del código 'Código de Barras' representado en el campo 'r1bc' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
			
			FPUTS(v_adminArc,v_linea1) && ¿O fwrite(v_adminArc,v_linea1) ?
					
			v_CantidadCobros = v_cantidadCobros + 1
			v_totalCobros = v_totalCobros + v_importeCob 
			****************
			* FIN LINEA 1 **
			****************
			
			
			SELECT &p_tablaCobros
			SKIP 1

		ENDDO
	
	
	
			****************
			*** LINEA 2 ****
			****************
	
			v_linea2 = "2"
			
			
			
			
			** Código Total Cobros **
			
						
			v_RCantidadCob = ALLTRIM(cbasociada_sql.r2cantidad)
			ALINES(ARR_RCantidadCob,v_RCantidadCob,'-')
			v_tamRCantidadCob = VAL(ARR_RCantidadCob(2))
			
							
			v_CantidadCobrosStr = ALLTRIM(STR(v_CantidadCobros))
								
			IF LEN(ALLTRIM(v_CantidadCobrosStr)) <= v_tamRCantidadCob 
				v_RCantidadCobrosStr = ALLTRIM(REPLICATE('0',v_tamRCantidadCob - len(ALLTRIM(v_CantidadCobrosStr)))+ALLTRIM(v_CantidadCobrosStr))
				
				v_linea2 = v_linea2+ALLTRIM(v_RCantidadCobrosStr) && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'Cantidad Cobros' representado en el campo 'r2cantidad' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
			
			
		
			** Código Total Cobros **
			
						
			v_RTotalCob = ALLTRIM(cbasociada_sql.r2total)
			ALINES(ARR_rTotalcob,v_RTotalCob,'-')
			v_tamrTotalcob = VAL(ARR_rTotalcob(2))
			
							
			v_TotalCobStr = ALLTRIM(STR(v_totalCobros * 100))
								
			IF LEN(ALLTRIM(v_TotalCobStr)) <= v_tamrTotalcob 
				v_rTotalCobstr = ALLTRIM(REPLICATE('0',v_tamrTotalcob - len(ALLTRIM(v_TotalCobStr)))+ALLTRIM(v_TotalCobStr))
				
				v_linea2 = v_linea2+ALLTRIM(v_rTotalCobstr ) && Si está correcto: lo agrego a la linea
				
			ELSE
				MESSAGEBOX("El tamaño del código 'Total Cobros' representado en el campo 'r2total' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
				RETURN 0
			ENDIF
	
	
			FPUTS(v_adminArc,v_linea2)
	
			****************
			* FIN LINEA 2 **
			****************
			
			
			FCLOSE(v_adminArc)
			
		ELSE
			MESSAGEBOX("Error al obtener la tabla temporal de cobros",0+48+0,"Error al Exportar cobros")
			RETURN 0
			
		ENDIF 
		
		RETURN 1

ENDFUNC 
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		







FUNCTION calculaSecueciaExpMax
PARAMETERS p_idcbcobrador
*#/----------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por la empresa pasada como parámetro para exportar al modulo de cobro
** 	Funcion: calculaSecueciaExpMax
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*#/----------------------------------------

IF p_idcbcobrador > 0
	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT max(cc.esecuencia) as maxsec "
	sqlmatriz(2)=" FROM cbcobrador cc "
	sqlmatriz(3)=" WHERE cc.idcbcobra = "+ALLTRIM(STR(p_idcbcobrador))

	verror=sqlrun(vconeccionD,"maxSecuencia_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Datos ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionD,"")

	    RETURN -1
	ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionD,"")

		v_maxsec = maxSecuencia_sql.maxsec
		v_maxsec = IIF(TYPE('v_maxsec')=='C', VAL(v_maxsec),v_maxsec)
	 RETURN v_maxsec
	 
ELSE
	RETURN  -1
ENDIF 

ENDFUNC 



FUNCTION ExportarComprobantes
	PARAMETERS p_idcbcobra, p_archivo,p_tablaComprobantes
*#/----------------------------------------
*/ 	Exportación de comprobantes a un archivo de intercambio (Archivo de envio .ENV)
** 	Funcion: ExportarComprobantes
* 	Parametros: 
*		P_idcbcobra: ID de la entidad que va a cobrar desde el archivo de Envio (Receptor del archivo de envio .ENV)
*		p_archivo: Path completo con el nombre del archivo .ENV
*		p_TablaComprobantes: Tabla donde están los compprobantes que se van a exportar
*	Retorno: Retorna 1 si se exportó correctamente, 0 en otro caso
*#/----------------------------------------

		IF TYPE('p_idcbcobra') != 'N'
			=messagebox("El ID del cobrador no es válido",16,"Error al Exportar comprobantes")
			RETURN 0
		ENDIF 

		p_archivo = alltrim(p_archivo)
		
		IF EMPTY(ALLTRIM(p_tablaComprobantes)) = .T.
			MESSAGEBOX("Nombre de tabla temporal incorrecta",0+16+0,"Error al Exportar comprobantes")
			RETURN 0
		ENDIF 


		** Controlar que el archivo sea de la entidad asociada **
		v_nombreArchivo = ALLTRIM(JUSTSTEM(p_archivo))
		v_extension = ALLTRIM(UPPER(JUSTEXT(p_archivo)))
		
		IF v_extension != 'ENV'
			=messagebox("El Archivo: "+p_archivo+" Tiene una extensión incorrecta, la extensión debe ser .ENV ",16,"Error al Exportar comprobantes")
			RETURN 0
		ENDIF 
			
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		** Busco los datos de la entidad asociada pasada como parámetro **
		sqlmatriz(1)= " select * from cbcobrador where idcbcobra = " +ALLTRIM(STR(p_idcbcobra))
		
		verror=sqlrun(vconeccionF,"cbcobrador_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al obtener los datos del cobrador asociada ",0+48+0,"Error al Exportar comprobantes")
			    RETURN 0
			ENDIF	
			
		SELECT cbcobrador_sql
		GO TOP 
		
		IF NOT EOF()
			v_nombArchivoEnv = ALLTRIM(cbcobrador_sql.narchivoe)
			 v_ultSecEnv = calculaSecuenciaMaxCob(p_idcbcobra)

	
			v_longArcEnv = LEN(v_nombArchivoEnv)
			
			** Compruebo el nombre del archivo **
			v_entArc = SUBSTR(v_nombreArchivo,1,v_longArcEnv)
			v_secArc = SUBSTR(v_nombreArchivo,v_longArcEnv+1)
			
			IF ALLTRIM(v_entArc) != ALLTRIM(v_nombArchivoEnv)
				MESSAGEBOX("El nombre del archivo no se corresponde con el cobrador",0+48+0,"Error al Exportar comprobantes")
			    RETURN 0	
			ENDIF 
						
			IF v_ultSecEnv > VAL(v_secArc)
				v_secArc = v_ultSecEnv +1
				
				v_nuevoNombre = v_entArc + v_secArc 		
				
				v_nombreViejo = ALLTRIM(JUSTSTEM(p_archivo))
				STRTRAN(p_archivo,v_nombreViejo,v_nuevoNombre)
				 				
			ENDIF 
		ELSE
			MESSAGEBOX("No se encuentran los datos de la entidada asociada",0+48+0,"Error al Importar comprobantes")
			RETURN 0
		ENDIF 
		
		** Obtengo información de ubicación de campos en el registro del archivo de retorno **
		SELECT cbcobrador_sql
		GO TOP 
	
			
		SELECT &p_tablaComprobantes
		GO TOP 
		
		IF NOT EOF()
			v_nroLinea = 1
			** Creo el archivo **
			v_adminArc = FCREATE(p_archivo)
	
			SELECT &p_tablaComprobantes
			GO TOP 
			DO WHILE NOT EOF()
				v_linea = ""
			
				*************************************
				*** Código Del Empresa ***
				*************************************					
				
				*v_empresaid 	= ALLTRIM(cbcobrador_sql.narchivoe)
				v_empresaid 	= ALLTRIM(cbcobrador_sql.narchivor)
				v_eempresaid	= cbcobrador_sql.eempresaid
				
				ALINES(ARR_eempresaid,v_eempresaid,'-')
				v_tameempresaid = VAL(ARR_eempresaid(2))
				
				IF LEN(ALLTRIM(v_empresaid )) = v_tameempresaid 
					
					v_linea = v_linea+v_empresaid && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'secuencia de retorno' representado en el campo 'r0secuencia' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				**************************************			
				*** Código de secuencia de Retorno ***
				**************************************
				v_eesecuencia 		= ALLTRIM(cbcobrador_sql.eesecuencia)
				ALINES(ARR_esecuencia,v_eesecuencia,'-')
				v_tamrsec = VAL(ARR_esecuencia(2))
				IF LEN(ALLTRIM(v_secArc)) = v_tamrsec 
					
					v_linea = v_linea+v_secArc && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'secuencia de retorno' representado en el campo 'r0secuencia' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
					
				
				** Periodo de Facturación ***
				v_periodo	= &p_tablaComprobantes..periodo
				v_fechaI 	= SUBSTR(ALLTRIM(v_periodo),1,8)
				v_fechaH 	= SUBSTR(ALLTRIM(v_periodo),9,8)
								
				v_eperiodo	= ALLTRIM(cbcobrador_sql.eperiodo)
								
				ALINES(ARR_eperiodo,v_eperiodo,'-')
				v_tameperiodo = VAL(ARR_eperiodo(2))
				
				v_fechaIJ = SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaI,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaI,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaI,7,2)))))	
				v_fechaHJ = SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaH,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaH,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaH,7,2)))))
				v_fechaPJ = v_fechaIj+v_fechaHJ
									
				IF LEN(ALLTRIM(v_fechaPJ)) = v_tameperiodo 
				*	v_ridcobrostr = ALLTRIM(REPLICATE('0',v_tamrcobro-len(ALLTRIM(STR(v_idcbcobro))))+ALLTRIM(STR(v_idcbcobro)))
					
					v_linea = v_linea+ALLTRIM(v_fechaPJ) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'fechaPeriodo' representado en el campo 'eperiodo' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				******************************
				*** Código de Barras (CB) ***
				******************************
							
				****************************
				** CB Codigo del cobrador **
				****************************
				
				v_codcobrador = cbcobrador_sql.narchivoe
				v_ebceid	  = ALLTRIM(cbcobrador_sql.ebceid)
							
				ALINES(ARR_ebceid,v_ebceid,'-')
				v_tamebcid = VAL(ARR_ebceid(2))
			
				IF LEN(ALLTRIM(v_codcobrador)) = v_tamebcid 
				*	v_codempresaidstr = ALLTRIM(REPLICATE('0',v_tamecodidcobrador-len(ALLTRIM(STR(v_ebceid))))+ALLTRIM(STR(v_ebceid)))
					
					v_linea = v_linea+v_codcobrador&& Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'CodEntidad' representado en el campo 'ebceid' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
							
				*******************************
				** CB Subcodigo del cobrador **
				*******************************
				
				v_subcodcobrador = cbcobrador_sql.subcodid
				
				v_subcod = cbcobrador_sql.ebcsid
				ALINES(ARR_subcod,v_subcod,'-')
				v_tamebcsid = VAL(ARR_subcod(2))
						
				IF LEN(ALLTRIM(v_subcodcobrador)) = v_tamebcsid
					*v_codempresaidstr = ALLTRIM(REPLICATE('0',v_tamecodidcobrador-len(ALLTRIM(STR(v_ebceid))))+ALLTRIM(STR(v_ebceid)))
					
					v_linea = v_linea+v_subcodcobrador&& Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'CodSubCod' representado en el campo 'ebcsid' es mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				****************************
				** Codigo del comprobante **
				****************************
				
				v_codigocomp 	=  &p_tablaComprobantes..codigocomp
				v_ebccom 		= cbcobrador_sql.ebcidcomp
				
				ALINES(ARR_codebccomp,v_ebccom,'-')
				v_tamebccom = VAL(ARR_codebccomp(2))
							
				IF LEN(ALLTRIM(v_codigocomp)) <= v_tamebccom
					v_codebccompstr = ALLTRIM(REPLICATE('0',v_tamebccom-len(ALLTRIM(v_codigocomp)))+ALLTRIM(v_codigocomp))
					
					v_linea = v_linea+v_codebccompstr && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'CodComprobante' representado en el campo 'ebcidcomp' es mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				
				*********************************************
				** Valido la Longitud del código de barras **
				*********************************************
								
				v_tamCodBarra = ALLTRIM(cbcobrador_sql.ebc)
				ALINES(ARR_ebccodbarra,v_tamCodBarra,'-')
				v_posIniCOdBarra = VAL(ARR_ebccodbarra(1))
				v_tamebccodbarra= VAL(ARR_ebccodbarra(2))
				
				v_CodBarra = SUBSTR(v_linea,v_posIniCodBarra,v_tamebccodbarra)
			
				IF LEN(ALLTRIM(v_codBarra)) != v_tamebccodbarra
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'CodBarra' representado en el campo 'ebc' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
									
				ENDIF 
				
				
				*total1, vence1,total2, vence2,total3, vence3
				***************************
				** Importe Vencimiento 1 **
				***************************
							
				v_total1	= &p_tablaComprobantes..total1
				v_etotal1	= ALLTRIM(cbcobrador_sql.etotal1)
							
				ALINES(ARR_etotal1,v_etotal1,'-')
				v_tametotal1 = VAL(ARR_etotal1(2))
										
				v_total1str = ALLTRIM(STR(v_total1 * 100))
									
				IF LEN(ALLTRIM(v_total1str)) <= v_tametotal1 
					v_total1str = ALLTRIM(REPLICATE('0',v_tametotal1 - len(ALLTRIM(v_total1str)))+ALLTRIM(v_total1str))
					
					v_linea = v_linea+ALLTRIM(v_total1str) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'ImporteVenc1' representado en el campo 'etotal1' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*************************
				** Fecha Vencimiento 1 **
				*************************
				v_fechaVence1 	= &p_tablaComprobantes..vence1				
				v_evence1 	= ALLTRIM(cbcobrador_sql.evence1)
				
				ALINES(ARR_evence1,v_evence1,'-')
				v_tamevence1 = VAL(ARR_evence1(2))
		
				
				** Convierto la fecha a formato Juliano **
							
				v_fechaVence1J= SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaVence1 ,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaVence1 ,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaVence1 ,7,2)))))
												
				IF LEN(ALLTRIM(v_fechaVence1J)) = v_tamevence1 
					v_linea = v_linea+ALLTRIM(v_fechaVence1J) && Si está correcto: lo agrego a la linea
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'fechaVence1' representado en el campo 'evence1' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				***************************
				** Importe Vencimiento 2 **
				***************************
							
				v_total2	= &p_tablaComprobantes..total2
				v_etotal2	= ALLTRIM(cbcobrador_sql.etotal2)
							
				ALINES(ARR_etotal2,v_etotal2,'-')
				v_tametotal2 = VAL(ARR_etotal2(2))
										
				v_total2str = ALLTRIM(STR(v_total2 * 100))
									
				IF LEN(ALLTRIM(v_total2str)) <= v_tametotal2 
					v_total2str = ALLTRIM(REPLICATE('0',v_tametotal2 - len(ALLTRIM(v_total2str)))+ALLTRIM(v_total2str))
					
					v_linea = v_linea+ALLTRIM(v_total2str) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'ImporteVenc2' representado en el campo 'etotal2' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*************************
				** Fecha Vencimiento 2 **
				*************************
				v_fechaVence2 	= &p_tablaComprobantes..vence2				
				v_evence2 	= ALLTRIM(cbcobrador_sql.evence2)
				
				ALINES(ARR_evence2,v_evence2,'-')
				v_tamevence2= VAL(ARR_evence2(2))
		
				
				** Convierto la fecha a formato Juliano **
							
				v_fechaVence2J= SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaVence2,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaVence2,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaVence2,7,2)))))
												
				IF LEN(ALLTRIM(v_fechaVence2J)) = v_tamevence2
					v_linea = v_linea+ALLTRIM(v_fechaVence2J) && Si está correcto: lo agrego a la linea
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'fechaVence2' representado en el campo 'evence2' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				***************************
				** Importe Vencimiento 3**
				***************************
							
				v_total3	= &p_tablaComprobantes..total3
				v_etotal3	= ALLTRIM(cbcobrador_sql.etotal3)
							
				ALINES(ARR_etotal3,v_etotal3,'-')
				v_tametotal3 = VAL(ARR_etotal3(2))
										
				v_total3str = ALLTRIM(STR(v_total3 * 100))
									
				IF LEN(ALLTRIM(v_total3str)) <= v_tametotal3 
					v_total3str = ALLTRIM(REPLICATE('0',v_tametotal3 - len(ALLTRIM(v_total3str)))+ALLTRIM(v_total3str))
					
					v_linea = v_linea+ALLTRIM(v_total3str) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'ImporteVenc3' representado en el campo 'etotal3' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*************************
				** Fecha Vencimiento 2 **
				*************************
				v_fechaVence3 	= &p_tablaComprobantes..vence3				
				v_evence3 	= ALLTRIM(cbcobrador_sql.evence3)
				
				ALINES(ARR_evence3,v_evence3,'-')
				v_tamevence3= VAL(ARR_evence3(2))
		
				
				** Convierto la fecha a formato Juliano **
							
				v_fechaVence3J= SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaVence3,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaVence3,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaVence3,7,2)))))
												
				IF LEN(ALLTRIM(v_fechaVence3J)) = v_tamevence3
					v_linea = v_linea+ALLTRIM(v_fechaVence3J) && Si está correcto: lo agrego a la linea
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'fechaVence3' representado en el campo 'evence3' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				*************************
				** Código de Entidad **
				*************************
				v_entidad 	= &p_tablaComprobantes..entidad				
				v_eentidad 	= ALLTRIM(cbcobrador_sql.eentidad)
				
				ALINES(ARR_eentidad,v_eentidad,'-')
				v_tameentidad = VAL(ARR_eentidad(2))
		
				
				v_eentidadstr = ALLTRIM(STR(v_entidad))
									
				IF LEN(ALLTRIM(v_eentidadstr)) <= v_tameentidad
					v_eentidadstr = ALLTRIM(REPLICATE('0',v_tameentidad - len(ALLTRIM(v_eentidadstr)))+ALLTRIM(v_eentidadstr))
					
					v_linea = v_linea+ALLTRIM(v_eentidadstr) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'CodEntidad' representado en el campo 'eentidad' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*************************
				** Código de Servicio **
				*************************
				v_servicio 	= &p_tablaComprobantes..servicio				
				v_eservicio 	= ALLTRIM(cbcobrador_sql.eservicio)
				
				ALINES(ARR_eservicio,v_eservicio,'-')
				v_tameservicio = VAL(ARR_eservicio(2))
		
				
				v_eserviciostr = ALLTRIM(STR(v_servicio))
									
				IF LEN(ALLTRIM(v_eserviciostr)) <= v_tameservicio
					v_eserviciostr = ALLTRIM(REPLICATE('0',v_tameservicio - len(ALLTRIM(v_eserviciostr)))+ALLTRIM(v_eserviciostr))
					
					v_linea = v_linea+ALLTRIM(v_eserviciostr) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'Codservicio' representado en el campo 'eservicio' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				*************************
				** Código de cuenta **
				*************************
				v_cuenta 	= &p_tablaComprobantes..cuenta				
				v_ecuenta 	= ALLTRIM(cbcobrador_sql.ecuenta)
				
				ALINES(ARR_ecuenta,v_ecuenta,'-')
				v_tamecuenta = VAL(ARR_ecuenta(2))
		
				
				v_ecuentastr = ALLTRIM(STR(v_cuenta))
									
				IF LEN(ALLTRIM(v_ecuentastr)) <= v_tamecuenta
					v_ecuentastr = ALLTRIM(REPLICATE('0',v_tamecuenta - len(ALLTRIM(v_ecuentastr)))+ALLTRIM(v_ecuentastr))
					
					v_linea = v_linea+ALLTRIM(v_ecuentastr) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'Codcuenta' representado en el campo 'ecuenta' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				
				
				
				*************************
				** Descripción del comprobante **
				*************************
				v_compdescrip 	= &p_tablaComprobantes..comproba 
				v_edescrip 	= ALLTRIM(cbcobrador_sql.edescrip)
				
				ALINES(ARR_edescrip,v_edescrip,'-')
				v_tamedescrip = VAL(ARR_edescrip(2))
		
				
				v_ecompcripstr = ALLTRIM(v_compdescrip)
					
														
				IF LEN(ALLTRIM(v_ecompcripstr)) <= v_tamedescrip
					v_ecompcripstr = REPLICATE(' ',v_tamedescrip- len(ALLTRIM(v_ecompcripstr)))+ALLTRIM(v_ecompcripstr)

					v_linea = v_linea+v_ecompcripstr&& Si está correcto: lo agrego a la linea
					
				ELSE
					** Si tengo mas caractes lo trunco
					v_ecompcripstr= SUBSTR(ALLTRIM(v_ecompcripstr),1,v_tamedescrip)
					
					
					v_linea = v_linea+ALLTRIM(v_ecompcripstr)
					
				ENDIF
				
				*************************
				** Descripción de la entidad **
				*************************
				v_entdescripen 	= ALLTRIM(&p_tablaComprobantes..nombre)+" "+ALLTRIM(&p_tablaComprobantes..documento)
				v_edescripen 	= ALLTRIM(cbcobrador_sql.edescripen)
				
				ALINES(ARR_edescripen,v_edescripen,'-')
				v_tamedescripen = VAL(ARR_edescripen(2))
		
				
				v_edescripenstr = ALLTRIM(v_entdescripen)
					
														
				IF LEN(ALLTRIM(v_edescripenstr)) <= v_tamedescripen
					v_edescripenstr = REPLICATE(' ',v_tamedescripen- len(ALLTRIM(v_edescripenstr)))+ALLTRIM(v_edescripenstr)

					v_linea = v_linea+v_edescripenstr && Si está correcto: lo agrego a la linea
					
				ELSE
					** Si tengo mas caractes lo trunco
					v_edescripenstr = SUBSTR(ALLTRIM(v_edescripenstr),1,v_tamedescripen)
					
					
					v_linea = v_linea+v_edescripenstr
					
				ENDIF
				
				
				***********************************
				** Limite máximo de cobro diario **
				***********************************
				
				v_ecobromax 		= ALLTRIM(cbcobrador_sql.ecobromax)
			
				ALINES(ARR_ecobromax,v_ecobromax,'-')
				v_tamrcm = VAL(ARR_ecobromax(2))
			
				v_cobroMaximo = cbcobrador_sql.cobromax
				
				v_cobromaximostr = STR((v_cobromaximo *100))
				v_lencobromax =  LEN(ALLTRIM(v_cobromaximostr))
			
				IF v_lencobromax <= v_tamrcm
					
					v_cobromaximostr= REPLICATE('0',v_tamrcm-v_lencobromax)+ALLTRIM(v_cobromaximostr)

					v_linea = v_linea+v_cobromaximostr&& Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño del código 'Monto Máximo' representado en el campo 'ecobromax' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
					
				
				
				
				
				
				
				
				****************************************
				*** Compruebo la logitud de la linea ***
				****************************************
				v_elong 		= ALLTRIM(cbcobrador_sql.elong)
		
			
				ALINES(ARR_elong,v_elong,'-')
				v_tamelong = VAL(ARR_elong(2))

				
		
				v_longLinea = LEN(v_linea)
			
				
				v_dif = v_tamelong - v_longLinea 
			
				IF v_dif >= v_tamelong 
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño de la linea no coincide con el tamaño descripto en la configuración (Tam linea: "+ALLTRIM(STR(v_longLinea))+" debe tener:" +ALLTRIM(STR(v_tamelong)),0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ELSE
					v_linea = v_linea + REPLICATE(' ',v_dif)
				ENDIF 
				
				v_longLinea = LEN(v_linea)
				
				v_dif = v_tamelong - v_longLinea 
				IF v_dif > 0
					MESSAGEBOX("[ERROR LINEA:"+ALLTRIM(STR(v_nroLinea))+"] El tamaño de la linea no coincide con el tamaño descripto en la configuración (Tam linea: "+ALLTRIM(STR(v_longLinea))+" debe tener:" +ALLTRIM(STR(v_tamelong)),0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF 
				
							
				FPUTS(v_adminArc,v_linea)

				v_nroLinea = v_nroLinea  + 1
	
			SELECT &p_tablaComprobantes
			SKIP 1
			
		ENDDO 
			
			
		FCLOSE(v_adminArc)
			
		ELSE
			MESSAGEBOX("Error al obtener la tabla temporal de comprobantes",0+48+0,"Error al Exportar Comprobantes")
			RETURN 0
			
		ENDIF 
		
		RETURN VAL(v_secArc )

ENDFUNC 









FUNCTION ImportarCobros
	PARAMETERS p_idcbcobra, p_archivo,p_tablaCobros
*#/----------------------------------------
*/ 	Importación de cobros desde archivo de intercambio (Archivo de retorno .RET)
** 	Funcion: ImportarCobros 
* 	Parametros: 
*		p_idcbcobra: ID de la entidad que realizo el cobro (Emisor del archivo de retorno .RET)
*		p_archivo: Path completo con el nombre del archivo .RET
*		p_tablaCobros: Nombre de la tabla donde se van a cargar los cobros importados
*	Retorno: Retorna 1 si se importó correctamente, 0 en otro caso
*#/----------------------------------------

		** Validación de parámetros **
		IF TYPE('p_idcbcobra') != 'N'
			=messagebox("El ID del cobrador no es válido",16,"Error al Importar cobros")
			RETURN 0
		ENDIF 

		p_archivo = alltrim(p_archivo)
		
		IF EMPTY(ALLTRIM(p_tablaCobros)) = .T.
			MESSAGEBOX("Nombre de tabla temporal incorrecta",0+16+0,"Error al Importar cobross")
			RETURN 0
		ENDIF 


		** Controlar que el archivo sea de la entidad asociada **
		v_nombreArchivo = ALLTRIM(JUSTSTEM(p_archivo))
		v_extension = ALLTRIM(UPPER(JUSTEXT(p_archivo)))
		
		IF v_extension != 'RET'
			=messagebox("El Archivo: "+p_archivo+" Tiene una extensión incorrecta, la extensión debe ser .RET  ",16,"Error al Importar cobros")
			RETURN 0
		ENDIF 
			
			
		** Obtengo la secuencia maxima de cobro **
			
		
			
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		** Busco los datos de la entidad asociada pasada como parámetro **
		sqlmatriz(1)= " select * from cbcobrador where idcbcobra = " +ALLTRIM(STR(p_idcbcobra))
		
		verror=sqlrun(vconeccionF,"cbcobrador_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al obtener los datos del cobrador asociada ",0+48+0,"Error al Importar cobros")
			    RETURN 0
			ENDIF	
			
			
		SELECT cbcobrador_sql
		GO TOP 
		IF NOT EOF()
			v_nombArchivoRet = ALLTRIM(cbcobrador_sql.narchivor)

			 v_ultSecCob = calculaSecMaxCobrador(p_idcbcobra)
			*v_ultSecCob = cbcobrador_sql.esecuencia
	
			v_longArcRet = LEN(v_nombArchivoRet)
			
			** Compruebo el nombre del archivo **
			v_entArc = SUBSTR(v_nombreArchivo,1,v_longArcRet)
			v_secArc = SUBSTR(v_nombreArchivo,v_longArcRet+1)
			
			
			IF ALLTRIM(v_entArc) != ALLTRIM(v_nombArchivoRet)
				MESSAGEBOX("El nombre del archivo no se corresponde con el cobrador",0+48+0,"Error al Importar cobros")
			    RETURN 0	
			ENDIF 
						
			IF VAL(v_secArc) <= v_ultSecCob
				MESSAGEBOX("La secuencia del archivo de imporación es Menor o Igual a la registrada",0+48+0,"Error al Importar cobros")
				RETURN 0

			ENDIF 
		ELSE
			MESSAGEBOX("No se encuentran los datos de la entidada asociada",0+48+0,"Error al Importar cobros")
			RETURN 0
		ENDIF 
		
		
		** Abro el archivo ha importar **		
		v_punteroArcEnv = FOPEN(p_archivo) && Puntero del arhivo
		
		IF v_punteroArcEnv < 0		
			MESSAGEBOX("No se puede abrir el archivo de Envio",0+48+0,"Error al Importar comprobantes")
			RETURN 0
		ENDIF 
		
		
		
		
		
		** Obtengo información de ubicación de campos en el registro del archivo de retorno **
		SELECT cbcobrador_sql
		GO TOP 
		
		v_empresaid		= ALLTRIM(cbcobrador_sql.empresaid)
		v_narchivor		= ALLTRIM(cbcobrador_sql.narchivor)
		v_elong 		= ALLTRIM(cbcobrador_sql.elong)
		v_eempresaid  	= ALLTRIM(cbcobrador_sql.eempresaid)
		v_eesecuencia 	= ALLTRIM(cbcobrador_sql.eesecuencia)
		v_eperiodo 		= ALLTRIM(cbcobrador_sql.eperiodo)
		** Código de barras **
		v_ebc			= ALLTRIM(cbcobrador_sql.ebc)
		v_ebceid 		= ALLTRIM(cbcobrador_sql.ebceid)
		v_ebcsid		= ALLTRIM(cbcobrador_sql.ebcsid)
		v_ebcidcomp 	= ALLTRIM(cbcobrador_sql.ebcidcomp)
		v_ebctotal1 	= ALLTRIM(cbcobrador_sql.etotal1)
		v_ebcvence1 	= ALLTRIM(cbcobrador_sql.evence1)
		v_ebctotal2 	= ALLTRIM(cbcobrador_sql.etotal2)
		v_ebcvence2		= ALLTRIM(cbcobrador_sql.evence2)
		v_ebctotal3 	= ALLTRIM(cbcobrador_sql.etotal3)
		v_ebcvence3 	= ALLTRIM(cbcobrador_sql.evence3)
		
		** Información de archivo de retorno **
		v_r0empresaid	= ALLTRIM(cbcobrador_sql.r0empresaid)
		v_r0puntorec	= ALLTRIM(cbcobrador_sql.r0puntorec)
		v_r0secuencia	= ALLTRIM(cbcobrador_sql.r0secuencia)
		v_r1idcobro		= ALLTRIM(cbcobrador_sql.r1idcobro)
		v_r1fechacobro	= ALLTRIM(cbcobrador_sql.r1fechacobro)
		v_r1importe		= ALLTRIM(cbcobrador_sql.r1importe)
		v_r1recargo		= ALLTRIM(cbcobrador_sql.r1recargo)
		v_r1bc			= ALLTRIM(cbcobrador_sql.r1bc)
		v_r2cantidad	= ALLTRIM(cbcobrador_sql.r2cantidad)
		v_r2total		= ALLTRIM(cbcobrador_sql.r2total)
		v_subcodid		= ALLTRIM(cbcobrador_sql.subcodid)
				
				
		
		v_linea = ALLTRIM(FGETS(v_punteroArcEnv)) && Primer linea del archivo -> CABECERA
			
		IF EMPTY(ALLTRIM(v_linea)) = .F.
	
		*** VERIFICACIÓN DE CABECERA ***
					
			** Tipo de registro **
				COD_tiporegistro = SUBSTR(v_linea,1,1)


				IF ALLTRIM(COD_tiporegistro) <> '0'
					MESSAGEBOX("Error al obtener el primer registro del archivo (Cabecera)",0+16+256,"Error al cargar el archivo de importación")
					RETURN 0
				ENDIF 
				
			** Código Empresa/Ente **
			ALINES(ARR_r0empresaid,v_r0empresaid,'-')
			COD_r0empresaid = SUBSTR(v_linea,VAL(ARR_r0empresaid(1)),VAL(ARR_r0empresaid(2)))
			
			** Código punto de recaudación **
			ALINES(ARR_r0puntorec,v_r0puntorec,'-')
			COD_r0puntorec = SUBSTR(v_linea,VAL(ARR_r0puntorec(1)),VAL(ARR_r0puntorec(2)))
			
			** Código secuencia del archivo **
			ALINES(ARR_r0secuencia,v_r0secuencia,'-')
			COD_r0secuencia = SUBSTR(v_linea,VAL(ARR_r0secuencia(1)),VAL(ARR_r0secuencia(2)))
	
			
			IF ALLTRIM(v_narchivor) <> alltrim(COD_r0empresaid) OR ALLTRIM(v_empresaid) <> ALLTRIM(COD_r0puntorec) 
				MESSAGEBOX("El archivo no se corresponde al cobrador seleccionado",0+16+256,"Error al cargar el archivo de importación")
				RETURN 0
			
			ENDIF 
			
			IF VAL(COD_r0secuencia) <> VAL(v_secArc)
			
			ENDIF 
		*	IF VAL(COD_r0secuencia) <= v_ultSecCob 
			IF VAL(COD_r0secuencia) < v_ultSecCob 
				MESSAGEBOX("La secuencia del archivo de imporación es Menor o Igual a la registrada",0+48+0,"Error al Importar cobros")
				RETURN 0
			
			ENDIF 
			
			
		*** FIN VERIFICACIÓN DE CABECERA ***	
		
		
		*** DATOS DE COBRO ***
				
*!*					
*!*				v_sentenciaCrea1 = "create table "+ALLTRIM(p_tablaCobros)+ " (ident I, idsubent I, secuencia C(10), comproba C(100),idcomp I, total1 Y, vence1 C(8),total2 Y, vence2 C(8), total3 Y, vence3 C(8), bc C(254), "
*!*				v_sentenciaCrea2 = " puntorec C(13), idcobro I, fechaCobro C(10), impCobro Y, recCobro Y)"

			v_sentenciaCrea = "create table "+ALLTRIM(p_tablaCobros)+ " (ident C(4), puntorec C(13), secuencia C(5) , idcobro I, fechaCobro C(10), impCobro Y, recCobro Y, bc C(254)) "
			&v_sentenciaCrea
		 
			** Recorro el archivo de envio, linea por linea **	
			DO WHILE NOT FEOF(v_punteroArcEnv) && Finaliza cuando encuentra una linea vacia
					v_linea = ALLTRIM(FGETS(v_punteroArcEnv))
				
					IF EMPTY(ALLTRIM(v_linea)) = .F.
						
						COD_tiporegistro = SUBSTR(v_linea,1,1)
						
						IF ALLTRIM(COD_Tiporegistro) = '1'
						
							v_tamLinea = LEN(v_linea)
																	
*!*								ALINES(v_longitud,v_elong,'-')
*!*											
*!*								v_tamCodigo = (VAL(v_longitud(2))) - (VAL(v_longitud(1))) + 1 
*!*								
*!*								IF v_tamCodigo > v_tamLinea && COMPRUEBO LONGITUD DEL CODIGO
*!*								
*!*									MESSAGEBOX("Codigo erroneo. La longitud del codigo ("+ALLTRIM(STR(v_tamCodigo))+") es mayor al del registro en el archivo ("+ALLTRIM(STR(v_tamlinea))+")")
*!*									RETURN 0
*!*									&& CODIGO ERRONEO
*!*								ELSE
*!*									&& CODIGO CORRECTO
														
								** ID cobro **
								ALINES(ARR_r1idcobro,v_r1idcobro,'-')
								COD_r1idcobro = SUBSTR(v_linea,VAL(ARR_r1idcobro(1)),VAL(ARR_r1idcobro(2)))
								NUM_r1idcobro = VAL(COD_r1idcobro)
								
								** Fecha cobro **
								ALINES(ARR_r1fechacobro,v_r1fechacobro,'-')
								COD_r1fechacobro = SUBSTR(v_linea,VAL(ARR_r1fechacobro(1)),VAL(ARR_r1fechacobro(2)))
								
								* Convierto fecha de Formato Juliano -> String *
								STR_r1fechacobro = DTOS(CTOD(SYS(10,VAL(COD_r1fechacobro))))
								
								
								** Importe cobro **
								ALINES(ARR_r1importe,v_r1importe,'-')
								COD_r1importe = SUBSTR(v_linea,VAL(ARR_r1importe(1)),VAL(ARR_r1importe(2)))
								NUM_r1importe = (VAL(COD_r1importe)/100)
								
								** Recargo **
								ALINES(ARR_r1recargo,v_r1recargo,'-')
								COD_r1recargo = SUBSTR(v_linea,VAL(ARR_r1recargo(1)),VAL(ARR_r1recargo(2)))
								NUM_r1recargo = (VAL(COD_r1recargo)/100)
							
								** Código de Barras **
								ALINES(ARR_r1bc,v_r1bc,'-')
								COD_r1bc = SUBSTR(v_linea,VAL(ARR_r1bc(1)),VAL(ARR_r1bc(2)))
										
									
																
									 
									
									
									
																			
									v_sentenciaIns1 = " insert into "+ALLTRIM(p_tablaCobros)+ " (ident, puntorec, secuencia, idcobro, fechaCobro, impCobro, recCobro, bc) "
									v_sentenciaIns2 = " values ('"+ALLTRIM(COD_r0empresaid)+"','"+ALLTRIM(COD_r0puntorec)+"','"+ALLTRIM(COD_r0secuencia)+"',"+ALLTRIM(STR(NUM_r1idcobro))+",'"+ALLTRIM(STR_r1fechacobro)+"',"
									v_sentenciaIns3 = ALLTRIM(STR(NUM_r1importe,14,2))+","+ALLTRIM(STR(NUM_r1recargo,14,2))+",'"+ALLTRIM(COD_r1bc)+"')"

									v_sentenciaIns = v_sentenciaIns1+v_sentenciaIns2+v_sentenciaIns3
								
									&v_sentenciaIns
						
							
												
*!*								ENDIF 
						
							*** FIN DATOS DE COBRO ***
						ELSE
						
						IF ALLTRIM(COD_Tiporegistro) = '2'
							*** VALIDACIÓN DE DATOS ***
							
							** Cantidad de registros **
							ALINES(ARR_r2cantidad,v_r2cantidad,'-')
							COD_r2cantidad = SUBSTR(v_linea,VAL(ARR_r2cantidad(1)),VAL(ARR_r2cantidad(2)))
							NUM_r2cantidad = VAL(COD_r2cantidad)
							
							** Monto total ** 
							ALINES(ARR_r2total,v_r2total,'-')
							COD_r2total = SUBSTR(v_linea,VAL(ARR_r2total(1)),VAL(ARR_r2total(2)))
							NUM_r2total = (VAL(COD_r2total)/100)
							
							
							SELECT &p_tablaCobros
							GO TOP 
							v_cantRegistros  = RECCOUNT() 
							
							SELECT SUM(impCobro) as total FROM &p_tablaCobros INTO TABLE totalCob
							
							v_totalCobrado = totalCob.total
							
							
							
							IF v_cantRegistros <> NUM_r2cantidad 
							
								MESSAGEBOX("La cantidad de registros declarados en el archivo no coincide con los cargados",0+48+0,"Error al Importar cobros")
								RETURN 0
			
													
							ENDIF 
					
							IF v_totalCobrado <> NUM_r2total
													
								MESSAGEBOX("El importe total declarado en el archivo no coincide con los cargados",0+48+0,"Error al Importar cobros")
								RETURN 0
												
							ENDIF 
							
							
							*** FIN VALIDACIÓN ***
		
						ENDIF 

		
		
		
		
		
						ENDIF 
						
					ENDIF 

				SKIP 1	
			ENDDO 
		
		
		
	
		
		ELSE
		
			MESSAGEBOX("No se puede obtener la cacebera del archivo de importación", 0+16+256,"Error al importar el archivo")
			RETURN 0
		
		ENDIF 
		
		
	
		
		FCLOSE(v_punteroArcEnv)
	RETURN 1

ENDFUNC  





FUNCTION ImputarCobros
	PARAMETERS p_tablacom, p_IDPvta, p_Idcomp
*#/----------------------------------------
*/ 	Imputación de cobros a facturas.
*/ 		Se imputa el total cobrado sin recargo al saldo de la factura, en caso de tener recargo o que el cobro sea mayor al saldo se deja a cuenta el monto 
** 	Funcion: ImputarCobros
* 	Parametros: 
*		P_tabla: Tabla con los comprobantes de facturas que se van a imputar 
*		p_IDPvta: ID del punto de venta que se va a utilizar en el comprobante de recibo, para elegir el ID por defecto no pasar los parámetros
*		p_Idcomp: ID del comprobante del tipo recibo que se va a utilizar para los cobros, para elegir el ID por defecto no pasar los parámetros
*	Retorno: Retorna 1 si se generaron correctamente los recibos, 0 en otro caso
*#/----------------------------------------
	
	
	v_idpvta = 0
	v_idcomp = 0

	*** Validación de parámetros ***
	IF EMPTY(p_tablacom) = .T.
	
		MESSAGEBOX("NO se indico la tabla donde se encuentran los comprobantes de facturas",0+16+256,"Error al Imputar facturas")
		RETURN 0
	ENDIF 
	
	IF TYPE('p_idpvta') ='L' and TYPE('p_idcomp') = 'L' && Los dos parámetros son logicos
	
		IF p_idpvta = .F. AND p_idcomp  =.F. && No especificó IDs -> elijo el comprobante por defecto
		
			IF ISBLANK(_SYSRECIBOCB) = .T. OR  EMPTY(_SYSRECIBOCB) = .T.
			
				MESSAGEBOX("No existe variable para comprobante de recibo por defecto. Cree la variable '_SYSRECIBOCB'",0+16+256,"Error al imputar facturas")
				RETURN 0
			
			ELSE
								
				v_idpvta = VAL(SUBSTR(_SYSRECIBOCB,1,2))
				v_idcomp = VAL(SUBSTR(_SYSRECIBOCB,3,2))
				
			ENDIF 
		ELSE
			MESSAGEBOX("Uno de los parámetros de la función 'imputarFacturas' es incorrecto",0+16+256,"Error al imputar facturas")
			RETURN 0
		ENDIF 
	
	
	ELSE
		
		IF TYPE('p_idpvta') ='N' and TYPE('p_idcomp') = 'N' && Los dos parámetros son numéricos
	
			v_idpvta = p_idpvta
			v_idcomp = p_idcomp
		ELSE
			MESSAGEBOX("Uno de los parámetros de la función 'imputarFacturas' es incorrecto",0+16+256,"Error al imputar facturas")
			RETURN 0
		ENDIF 
	
	ENDIF 
	
	****
	*** Busco los datos del recibo ***
	
	vconeccionF=abreycierracon(0,_SYSSCHEMA)	


	sqlmatriz(1)=" SELECT CONCAT_WS(' - ',TRIM(c.comprobante),TRIM(a.puntov),MID(TRIM(p.detalle),1,15)) as deta, c.tipo, c.idcomproba, a.puntov, a.pventa,t.opera,c.idtipocompro as idtipocomp FROM comprobantes c "
	sqlmatriz(2)=" left join tipocompro t on c.idtipocompro = t.idtipocompro  LEFT JOIN compactiv a ON a.idcomproba = c.idcomproba " 
	sqlmatriz(3)=" left join puntosventa p on p.pventa = a.pventa "
	sqlmatriz(4)=" WHERE a.puntov <> '0' and c.tabla = 'recibos' and c.idcomproba = "+ALLTRIM(STR(v_idcomp))+" and a.pventa = "+ALLTRIM(STR(v_idpvta))

	verror=sqlrun(vconeccionF,"compReci_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error al Buscar el Comprobante",0+48+0,"Error")
	    RETURN 
	ENDIF

	sqlmatriz(1)=" select * "
	sqlmatriz(2)=" from cbcobrador " 
	
	verror=sqlrun(vconeccionF,"cbcobradores_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error al Buscar cobradores",0+48+0,"Error")
	    RETURN 
	ENDIF




	* me desconecto	
	=abreycierracon(vconeccionF,"")

	SELECT * FROM compReci_sql INTO TABLE .\comprobareci ORDER BY deta
	sele comprobareci
	GO TOP 
	USE IN compReci_sql

	
	** BUsco los datos de la cuenta del cobrador
	SELECT cbcobrador_sql
	GO TOP 
	
	IF NOT EOF()
		
	ELSE
		MESSAGEBOX("No se encuentran los datos del cobrador ingresado",0+16+256,"Error")
		RETURN 
	
	ENDIF 
	
	*** Creo un comprobante del tipo de recibo por cada factura ***
	** El recibo se hace por el total del cobro. EN caso de que el monto del recibo sea mayor al saldo de la factura, el exedente queda a cuenta **
	
	
	SELECT &p_tablacom
	GO top
	v_cant_regrec = reccount() 
 	
 	*** Intento reservar el ID de recibo antes de grabar los datos ***
 	v_correcto = .F.
 	v_intentos = 0
 	v_cantMaxIntentos = 10
 	DO WHILE v_correcto = .F. AND v_intentos < v_cantMaxIntentos 

	
		** Reservo el ID **
		v_idregsinuso = maxnumeroidx("idrecibo", "I", "recibos",1)	
		v_reservarId = maxnumeroidx("idrecibo", "I", "recibos",v_cant_regrec)
		v_idrecibo = v_idregsinuso
*!*			 MESSAGEBOX(v_cant_regrec)
*!*			 MESSAGEBOX(v_correcto)
*!*			 MESSAGEBOX(v_intentos)
*!*			 MESSAGEBOX(v_idregsinuso)
*!*			 MESSAGEBOX(v_reservarId)
*!*			 MESSAGEBOX(v_idrecibo)
		** Reservo el número **
*!*			v_numrecsinuso = maxnumerocom(v_recibo_idcomproba ,v_recibo_pventa ,1)
*!*			v_reservanum = maxnumerocom(v_recibo_idcomproba ,v_recibo_pventa ,v_cant_regrec)
*!*			v_recibo_numero = v_numrecsinuso

		sqlmatriz(1)=" select idrecibo "
		sqlmatriz(2)=" from recibos " 
		sqlmatriz(3)=" where idrecibo >= "+ALLTRIM(STR((v_idrecibo+1)))+" and idrecibo <= "+ALLTRIM(STR((v_idrecibo+1+v_cant_regrec)))
	
		verror=sqlrun(vconeccionF,"cbcontrolreci_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al controlar el ID del recibo ",0+48+0,"Error")
		    RETURN 
		ENDIF
		
		SELECT cbcontrolreci_sql
		GO top
		
		IF NOT EOF()
			** Existen recibos con ese valor **
		ELSE
			** NO existen recibos con el id **
			v_correcto = .t.
		ENDIF 
		
		v_intentos = v_intentos + 1
 	ENDDO
 	
 	
 	IF v_intentos >= v_cantMaxIntentos 
 	
 		MESSAGEBOX("Se alcanzo la cantidad máxima de intentos de grabar los registros",0+16+256,"Error al imputar cobros")
		RETURN 
 	ENDIF
 		
	
	=ViewBarProgress(0,v_cant_regrec,"Imputando cobros...")
	
	
	SELECT &p_tablacom
	GO TOP 
	
	DO WHILE NOT EOF()
		v_idrecibo = v_idrecibo + 1 
		
		*v_idrecibo = maxnumeroidx("idrecibo", "I", "recibos",1)

			SELECT comprobareci


				** BUsco los datos de la cuenta del cobrador
			SELECT cbcobradores_sql
			GO TOP 
			
			IF NOT EOF()
				v_idcbcobra = cbcobradores_sql.idcbcobra
				SELECT cbcobradores_sql
				GO TOP 
				LOCATE FOR idcbcobra = v_idcbcobra
				
				IF NOT EOF()
				
					id_cajabco = cbcobrador_sql.idcajabco
				ELSE
					MESSAGEBOX("No se encuentran los datos del cobrador ingresado",0+16+256,"Error")
					RETURN 
			
			
				ENDIF 
				
			
			ELSE
				MESSAGEBOX("No se encuentran los datos del cobrador ingresado",0+16+256,"Error")
				RETURN 
			
			ENDIF 
	
	
	
			vconeccionF = abreycierracon(0,_SYSSCHEMA)
	
			v_recibo_idcomproba = v_idcomp
			v_recibo_pventa 	= v_idpvta
			
			v_recibo_numero = maxnumerocom(v_recibo_idcomproba ,v_recibo_pventa ,1)
			
			v_fecha = DTOS(DATE())		
			
			v_entidadRecibo = &p_tablacom..ident
			v_apellido = ""
			v_nombre = &p_tablacom..entidad
			v_recibo_importe = &p_tablacom..importeCob 
			v_idcobro	= &p_tablacom..idcobro
			v_concepto 		= "Imputación de cobro según cobro N°: "+ALLTRIM(REPLICATE('0',8-LEN(ALLTRIM(STR(v_idcobro))))+ALLTRIM(STR(v_idcobro)))+" del cobrador N°: "+ALLTRIM(REPLICATE('0',8-LEN(ALLTRIM(STR(v_idcbcobra))))+ALLTRIM(STR(v_idcbcobra)))
		
			DIMENSION lamatriz8(10,2)
			
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla     = 'recibos'
			p_matriz    = 'lamatriz8'
			p_conexion  = vconeccionF
					
			lamatriz8(1,1)='idrecibo'
			lamatriz8(1,2)=ALLTRIM(STR(v_idrecibo))
			lamatriz8(2,1)='idcomproba'
			lamatriz8(2,2)= ALLTRIM(STR(v_recibo_idcomproba ))
			lamatriz8(3,1)='pventa'
			lamatriz8(3,2)=ALLTRIM(STR(v_recibo_pventa))
			lamatriz8(4,1)='numero'
			lamatriz8(4,2)=ALLTRIM(STR(v_recibo_numero))
			lamatriz8(5,1)='fecha'
			lamatriz8(5,2)="'"+ALLTRIM(v_fecha)+"'"
			lamatriz8(6,1)='entidad'
			lamatriz8(6,2)=ALLTRIM(STR(v_entidadRecibo))
			lamatriz8(7,1)='apellido'
			lamatriz8(7,2)="'"+ALLTRIM(v_apellido)+"'"
			lamatriz8(8,1)='nombre'
			lamatriz8(8,2)="'"+ALLTRIM(v_nombre)+"'"
			lamatriz8(9,1)='importe'
			lamatriz8(9,2)=ALLTRIM(STR(v_recibo_importe,13,2))
			lamatriz8(10,1)='concepto'
			lamatriz8(10,2)="'"+ALLTRIM(v_concepto)+"'"
		

			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			    RETURN 
			ENDIF 
			
			*** REGISTRO ESTADO AUTORIZADO ***

			registrarEstado("recibos","idrecibo",v_idrecibo,'I',"AUTORIZADO")
	
				
		*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
		
			guardaCajaRecaH(v_recibo_idcomproba, v_idrecibo)
			
	
				*** GUARDO EL COBRO DE LA FACTURA ***

			SELECT &p_tablacom
			
			v_idcuotafc = &p_tablacom..idcuotafc
			v_cuota	= &p_tablacom..cuota
			v_saldof = &p_tablacom..saldof
			v_saldofc = &p_tablacom..saldofc
			
			v_importeCob = &p_tablacom..importeCob 
*			v_recargocob = &p_tablacom..recargoCob
			v_recargocob = 0.00
			v_importe = v_importeCob - v_recargoCob
				
			v_cobro_idcuotafc = 0.00
			
			v_cobro_imputado = 0.00

			IF v_idcuotafc  >= 0 &&
				
				IF v_importe > v_saldofc 
				
					v_saldoCob = v_importe - v_saldofc + v_recargoCob  && SUMO EL RECARGO ACÁ O LO AGREGO A RECARGO EN EL COBRO ?
					*v_saldoCob = v_importe - v_saldofc 
					v_cobro_imputado = v_saldofc 

					
				ELSE
					v_cobro_imputado = v_importe
					v_saldoCob = v_saldofc - v_importe  + v_recargoCob  && SUMO EL RECARGO ACÁ O LO AGREGO A RECARGO EN EL COBRO ?
				*	v_saldoCob = v_saldofc - v_importe  
					
				ENDIF 
				v_cobro_idcuotafc = v_idcuotafc				
			ELSE
			
				IF v_importe > v_saldof 
				
					v_saldoCob = v_importe - v_saldof + v_recargoCob && SUMO EL RECARGO ACÁ O LO AGREGO A RECARGO EN EL COBRO ?
			*		v_saldoCob = v_importe - v_saldof 
					
					v_cobro_imputado = v_saldof 
					
				ELSE
					v_cobro_imputado = v_importe
					v_saldoCob = v_recargoCob
					
				ENDIF 
			
			
			ENDIF  		

					
			v_idfactura = &p_tablacom..idfactura
			
			v_cobro_recargo = v_recargoCob
			v_cobro_saldof = v_saldoCob
	
			
			IF v_cobro_imputado > 0
				
					DIMENSION lamatriz9(8,2)

					v_idcobro = maxnumeroidx("idcobro", "I", "cobros",1)

					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					p_tabla     = 'cobros'
					p_matriz    = 'lamatriz9'
					p_conexion  = vconeccionF
					v_cobro_idcomproba 	= v_recibo_idcomproba 
					v_cobro_idregipago 	= v_idrecibo
					v_cobro_idfactura 	= v_idFactura



					lamatriz9(1,1)='idcobro'
					lamatriz9(1,2)=ALLTRIM(STR(v_idcobro))
					lamatriz9(2,1)='idcomproba'
					lamatriz9(2,2)=ALLTRIM(STR(v_cobro_idcomproba))
					lamatriz9(3,1)='idfactura'
					lamatriz9(3,2)= ALLTRIM(STR(v_cobro_idfactura))
					lamatriz9(4,1)='recargo'
					lamatriz9(4,2)=ALLTRIM(STR(v_cobro_recargo,13,2))
					lamatriz9(5,1)='idregipago'
					lamatriz9(5,2)=ALLTRIM(STR(v_cobro_idregipago))
					lamatriz9(6,1)='idcuotafc'
					lamatriz9(6,2)=ALLTRIM(STR(v_cobro_idcuotafc))
					lamatriz9(7,1)='imputado'
					lamatriz9(7,2)=ALLTRIM(STR(v_cobro_imputado,13,2))
					lamatriz9(8,1)='saldof'
					lamatriz9(8,2)=ALLTRIM(STR(v_cobro_saldof,13,2))
							
				
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
					    RETURN 
					ENDIF 
				
				
			
				ENDIF 

				**** GUARDO DATOS DE DETALLECOBRO ****
				
				v_iddetacobro 				= maxnumeroidx("iddetacobro", "I","detallecobros",1)
				v_detallecobro_idcomproba 	= v_recibo_idcomproba 
				v_detallecobro_idregi		= v_idrecibo
				v_detallecobro_importe 		= v_cobro_imputado
				

				tipoPagoObj		= CREATEOBJECT('tipospagosclass')
				v_idtipopagoTra				= tipopagoObj.gettipospagos('TRANSFERENCIA')
				v_idtipoPago 				= v_idtipopagoTra		
				
				*id_cajabco					= _SYSCTAIMPUTACB
								
				
				DIMENSION lamatriz5(6,2)
				
				lamatriz5(1,1)='iddetacobro'
				lamatriz5(1,2)=ALLTRIM(STR(v_iddetacobro))
				lamatriz5(2,1)='idcomproba'
				lamatriz5(2,2)= ALLTRIM(STR(v_detallecobro_idcomproba))
				lamatriz5(3,1)='idregistro'
				lamatriz5(3,2)= ALLTRIM(STR(v_detallecobro_idregi))
				lamatriz5(4,1)=	'idtipopago'
				lamatriz5(4,2)=	ALLTRIM(STR(v_idtipoPago))		
				lamatriz5(5,1)='importe'
				lamatriz5(5,2)= ALLTRIM(STR(v_recibo_importe,13,2))
				lamatriz5(6,1)= 'idcuenta'
				lamatriz5(6,2)= ALLTRIM(STR(id_cajabco))
				
		
				
				p_tipoope	= 'I'
				p_donficion = ''
				p_tabla     = 'detallecobros'
				p_matriz    = 'lamatriz5'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				ENDIF 
		
	
*!*			
*!*			** GENERO EL ASIENTO PARA EL RECIBO			
*!*			v_cargo = ContabilizaCompro('recibos', v_idrecibo, vconeccionF, v_recibo_importe)
	
	
		*** Guardo los datos del cobro en cbcobrados ***
		
		
				SELECT &p_tablacom
		
				v_idcbcob = 0
				v_idfactura = &p_tablacom..idfactura
				v_idcbcobra = &p_tablacom..idcbcobra
				v_idcobro = &p_tablacom..idcobro
				v_secuencia = &p_tablacom..secuencia
				v_fechaCobro = &p_tablacom..fechacob
				v_impcobro = &p_tablacom..importecob
				v_recargo = &p_tablacom..recargocob
				v_bc = &p_tablacom..cb
				v_loteImp = &p_tablacom..loteimp
				
				
				DIMENSION lamatriz6(10,2)
				
				lamatriz6(1,1)='idcbcob'
				lamatriz6(1,2)=ALLTRIM(STR(v_idcbcob ))
				lamatriz6(2,1)='idfactura'
				lamatriz6(2,2)= ALLTRIM(STR(v_idfactura ))
				lamatriz6(3,1)='idcbcobra'
				lamatriz6(3,2)= ALLTRIM(STR(v_idcbcobra))
				lamatriz6(4,1)=	'idcobro'
				lamatriz6(4,2)=	ALLTRIM(STR(v_idcobro))		
				lamatriz6(5,1)='secuencia'
				lamatriz6(5,2)= ALLTRIM(STR(v_secuencia))
				lamatriz6(6,1)= 'fechacobro'
				lamatriz6(6,2)= "'"+ALLTRIM(v_fechaCobro)+"'"
				lamatriz6(7,1)= 'impcobro'
				lamatriz6(7,2)= ALLTRIM(STR(v_impcobro,13,2))
				lamatriz6(8,1)= 'imprecargo'
				lamatriz6(8,2)= ALLTRIM(STR(v_recargo,13,2))
				lamatriz6(9,1)= 'bc'
				lamatriz6(9,2)= "'"+ALLTRIM(v_bc)+"'"
				lamatriz6(10,1)= 'loteimp'
				lamatriz6(10,2)= ALLTRIM(STR(v_loteimp))
				
		
				
				p_tipoope	= 'I'
				p_donficion = ''
				p_tabla     = 'cbcobrados'
				p_matriz    = 'lamatriz6'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				ENDIF 
		
		

			
*!*				** GENERO EL ASIENTO PARA EL RECIBO			
*!*				v_cargo = ContabilizaCompro('recibos', v_idrecibo, vconeccionF, v_recibo_importe)
			
			v_ret = ctaCteBancos('RECIBOS',v_idrecibo,0)
			
			
			* me desconecto	
			=abreycierracon(vconeccionF,"")
			
			
			** Creo la ND de recargo **
			v_interesFin = 0.00
			
			IF TYPE("_SYSNDRECARGOS")='C' THEN 
				IF (v_recargo > 0 OR  v_interesFin> 0) AND ( v_impcobro > 0 ) AND !(SUBSTR(_SYSNDRECARGOS,1,1)='N') THEN 
						v_nd_idrecibo = v_idrecibo
						v_nd_entidad  = v_entidadRecibo
						ndreto =GenNDRecargo( v_nd_entidad , v_recargo,v_interesFin, 0, 0, v_nd_idrecibo , 0, 'N' )
				ENDIF 
			ENDIF 




		SELECT &p_tablacom
		=ViewBarProgress(RECNO(),v_cant_regrec,"Imputando cobros...")
		SKIP 1

	ENDDO
	
	
		RETURN 1
	
ENDFUNC 





FUNCTION CBSaldoCompro
PARAMETERS pcb_EmpresaID, pcb_EmpresaSID, pcb_IdFactura
*#/----------------------------------------
*** Función Obtener el Saldo del Comprobante en la Base Maestra de Casa Central
*** Parameter:
***		pcb_EmpresaID, pcb_EmpresaSID, pcb_IdFactura
***	Retorno
*** 	pcb_retorno: Devuelve una variable de tipo caracter 'S[saldo comprobante]', o 'N' si no tiene que controlar saldo
*** Si devuelve S, seguida del saldo es porque encontró y debe controlar el saldo, de otra forma devuelve 'N' 
**  Se debe llamar a la funcion sin ninguna conexion abierta, ya que cierra y abre una conexion a otra base de datos
*#/----------------------------------------
	pcb_Retorno = "N" && variable de retorno
	

	vconeccionCB=abreycierracon(0,_SYSSCHEMA) && ME CONECTO

*!*		v_llave = ALLTRIM(pcb_EmpresaID)+"Pr0$$3"+ALLTRIM(pcb_EmpresaSID)
		v_llave = "Pr0$$3"+ALLTRIM(pcb_EmpresaSID)
	
	
	sqlmatriz(1)=" Select host, port, schemma, aes_decrypt(TRIM(usuario),'"+v_llave+"') as usuario, aes_decrypt(TRIM(password),'"+v_llave+"') as password, controldb from cbasociadas where TRIM(narchivoe) = '"+ALLTRIM(pcb_EmpresaID)+"' and  TRIM(subcodid) = '"+ALLTRIM(pcb_EmpresaSID)+"'"
	verror=sqlrun(vconeccionCB,"asociadactrl_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Empresa Asociada para Control de Saldos ",0+48+0,"Error")
	    =abreycierracon(vconeccionCB,"")
	    RETURN pcb_Retorno 
	ENDIF
	SELECT asociadactrl_sql
	GO TOP 

	IF EOF() THEN 
		pcb_Retorno = 'N'
	ELSE
	
		IF ALLTRIM(asociadactrl_sql.controldb)=='S' THEN 

			=abreycierracon(vconeccionCB,"")
			
			cdb_host	 = asociadactrl_sql.host
			cdb_port	 = asociadactrl_sql.port
			cdb_schemma	 = asociadactrl_sql.schemma
			cdb_usuario	 = asociadactrl_sql.usuario
			cdb_password = asociadactrl_sql.password
			

			** Guardo las Variables Actuales de Conexion al Servidor para restaurarlas
			** antes de abandonar la función 

			_SYSMYSQL_SERVER_TMP 	= _SYSMYSQL_SERVER 
			_SYSMYSQL_USER_TMP	 	= _SYSMYSQL_USER   
			_SYSMYSQL_PASS_TMP   	= _SYSMYSQL_PASS   
			_SYSMYSQL_PORT_TMP   	= _SYSMYSQL_PORT   
			_SYSSCHEMA_TMP     		= _SYSSCHEMA   
			_SYSDESCRIP_TMP			= _SYSDESCRIP
			
			** Intento conectarme con la base de datos maestra del asociado 
			_SYSMYSQL_SERVER = cdb_host	
			_SYSMYSQL_USER   = cdb_usuario
			_SYSMYSQL_PASS   = cdb_password 	
			_SYSMYSQL_PORT   = cdb_port
			_SYSSCHEMA 		 = cdb_schemma

			vconeccionCBA=abreycierracon(0,_SYSSCHEMA) && ME CONECTO

			IF vconeccionCBA > 0 THEN 
				sqlmatriz(1)=" Select idfactura, saldof  from r_facturasaldo where idfactura = "+ALLTRIM(STR(pcb_IdFactura))
				verror=sqlrun(vconeccionCBA,"saldoctrl_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del Saldo de La Factura ",0+48+0,"Error")
				    =abreycierracon(vconeccionCBA,"")
				ENDIF
				SELECT saldoctrl_sql
				GO TOP 
				IF EOF() THEN 
					pcb_Retorno = 'N'
				ELSE
					pcb_Retorno = 'S'+STR(saldoctrl_sql.saldof,13,2)
				ENDIF 
				USE IN saldoctrl_sql 
			ELSE 
				pcb_Retorno = 'N'
			ENDIF 
			=abreycierracon(vconeccionCBA,"")
			
			** Restauro las variables de conexión a la base de datos 
			** antes de abandonar la función 
			_SYSMYSQL_SERVER = _SYSMYSQL_SERVER_TMP 	
			_SYSMYSQL_USER   = _SYSMYSQL_USER_TMP 
			_SYSMYSQL_PASS   = _SYSMYSQL_PASS_TMP   	
			_SYSMYSQL_PORT   = _SYSMYSQL_PORT_TMP
			_SYSSCHEMA 		 = _SYSSCHEMA_TMP   
			_SYSDESCRIP 	 = _SYSDESCRIP_TMP
		
		ELSE 
			pcb_Retorno = 'N'
		ENDIF 
	ENDIF 
	
	USE IN asociadactrl_sql
	RETURN pcb_Retorno
ENDFUNC 



FUNCTION CBconvertirArchivo
PARAMETERS pcb_EmpresaID, pcb_archivo, pcb_operacion
*#/----------------------------------------
*** Función para convertir un archivo al formato correspondiente
*** Parameter:
***		pcb_EmpresaID: Id de la empresa
***		pcb_archivo: path completo del archivo a convertir (el parametro puede ser vacio, en ese caso se pedirá seleccionar)
***		pcb_operacion: Operación, puede ser R o E (R: formato archivo retorno, E: Formato archivo Envio)
***	Retorno
*** 	pcb_retorno: Devuelve el path del archivo convertido. Si no puede convertir o hay algún error retorna vacio
**  Se debe llamar a la funcion sin ninguna conexion abierta, ya que cierra y abre una conexion a otra base de datos
*#/----------------------------------------

	pcb_Retorno = ""


	vconeccionCBA=abreycierracon(0,_SYSSCHEMA) && ME CONECTO

	IF vconeccionCBA > 0 THEN 

		sqlmatriz(1)=" Select funcionfiltro from cbcobrador where empresaid = '"+ALLTRIM(pcb_EmpresaID)+"'"
		verror=sqlrun(vconeccionCBA,"funcionfiltro_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la función de conversión",0+48+0,"Error")
		    =abreycierracon(vconeccionCBA,"")
		    pcb_Retorno = ""
		
		    RETURN pcb_Retorno 
		ENDIF
		
		
		SELECT funcionfiltro_sql
		GO TOP 
		IF EOF() THEN 
			pcb_Retorno = ""
	
			=abreycierracon(vconeccionCBA,"")    
	
		    RETURN pcb_Retorno 
		ELSE
		
			*** Trato de ejecutar la función de conversión ***
			
			v_funcionConv = funcionfiltro_sql.funcionfiltro
		
			IF EMPTY(ALLTRIM(v_funcionconv)) = .F.
			
			
				v_fnconv = ALLTRIM(v_funcionConv)+"('', '', '')"
				
				v_existe = chkfunction(v_fnconv) 
				
				IF v_existe = .T.
					v_fnconv = ALLTRIM(v_funcionConv)+"(pcb_EmpresaID, pcb_archivo, pcb_operacion)"
					eje = "pcb_Retorno = "+ALLTRIM(v_fnconv)
					&eje 
				ELSE
					MESSAGEBOX("La función: '"+ALLTRIM(v_fnconv)+"' No está definida. Contacte al administrador del sistema",0+16+256,"Convertir archivo")
					
					pcb_Retorno = ""
			
					=abreycierracon(vconeccionCBA,"")    
			
				    RETURN pcb_Retorno 
				ENDIF 
				
			ELSE
				pcb_Retorno = ""
	
				=abreycierracon(vconeccionCBA,"")    
		
			    RETURN pcb_Retorno 
			ENDIF 
		
				
		ENDIF 
		USE IN funcionfiltro_sql
	ELSE 
		pcb_Retorno = ""
	ENDIF 
	
			

	RETURN pcb_Retorno

ENDFUNC 



*#/----------------------------------------
***
*** FUNCIONES PARA CONVERSIÓN DE ARCHIVOS DE EXPORTACIÓN E IMPORTACIÓN
***
*** TODAS LAS FUNCIONES DEBEN RECIBIR LOS SIGUIENTES PARAMETROS: 
***		pcb_EmpresaID: Id de la empresa
***		pcb_archivo: path completo del archivo a convertir (el parametro puede ser vacio, en ese caso se pedirá seleccionar)
***		pcb_operacion: Operación, puede ser R o E (R: formato archivo retorno, E: Formato archivo Envio)
***	Retorno
*** 	pcb_retorno: Devuelve el path del archivo convertido. Si no puede convertir o hay algún error retorna vacio
***
*#/----------------------------------------


FUNCTION CBFNRLCREDICOOP
*#/----------------------------------------
*** Función para convertir un archivo al formato de RedLink Credicoop
*** Parameter:
***		pcb_EmpresaID: Id de la empresa
***		pcb_archivo: path completo del archivo a convertir (el parametro puede ser vacio, en ese caso se pedirá seleccionar)
***		pcb_operacion: Operación, puede ser I o E (I: formato archivo para Importación, E: Formato archivo para exportarción)
***	Retorno
*** 	pcb_retorno: Devuelve el path del archivo convertido. Si no puede convertir o hay algún error retorna vacio
**  Se debe llamar a la funcion sin ninguna conexion abierta, ya que cierra y abre una conexion a otra base de datos
*#/----------------------------------------
PARAMETERS pcb_EmpresaID, pcb_archivo, pcb_operacion

	pcb_Retorno = ""

*** Obtengo las configuraciones de los archivos y datos de empresa asociada y cobrador ***

	vconeccionCBA=abreycierracon(0,_SYSSCHEMA) && ME CONECTO

	IF vconeccionCBA > 0 THEN 
		
		sqlmatriz(1)= " select * from cbasociadas "
		
		verror=sqlrun(vconeccionCBA,"cbasociada_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al obtener los datos de la entidad asociada ",0+48+0,"Error al Importar comprobantes")
		    RETURN 0
		ENDIF	
			
		SELECT cbasociada_sql
		GO TOP 
		
		IF EOF()
			
		 	MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los datos del archivo de la empresa ",0+48+0,"Error")
		    =abreycierracon(vconeccionCBA,"")
		    pcb_Retorno = ""
	
		    RETURN pcb_Retorno 
		ENDIF 
		
		sqlmatriz(1)=" Select * from cbcobrador where empresaid = '"+ALLTRIM(pcb_EmpresaID)+"'"
	
		verror=sqlrun(vconeccionCBA,"cbcobrador_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los datos del cobrador",0+48+0,"Error")
		    =abreycierracon(vconeccionCBA,"")
		    pcb_Retorno = ""
	
		    RETURN pcb_Retorno 
		ENDIF
		
		SELECT cbcobrador_sql
		GO TOP 
		
		IF NOT EOF()
			SELECT cbcobrador_sql
				
		ELSE
		
			pcb_Retorno = ""
		
			RETURN pcb_Retorno 
		ENDIF  

	***********************************
	
	*** Creo la tabla con los datos de los cobros ****	
		v_s1 = "CREATE TABLE cobrostmp  FREE (idcbasoci I, empresaid I, idsubent I,idcomp I, comproba C(100),total1 Y, "
		v_s2 = " vence1 C(8),idcbcobro I,fechacob C(8),importeCob Y,recargoCob Y, cb C(254), sel L) "
		v_s = v_s1+v_s2
		
		&v_s

		
	***************
	
	*** Cargo la tabla con los datos de los cobros desde el archivo de REDLINK ****
	
		sqlmatriz(1)=" select * from servicios "
		verror=sqlrun(vconeccionCBA,"servicios")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los datos de los servicios ",0+48+0,"Error")
		    =abreycierracon(vconeccionCBA,"")
		    pcb_Retorno = ""
	
		    RETURN pcb_Retorno 
		ENDIF
					
		IF EMPTY(pcb_archivo)
			
	*!*			pcb_archivo = GETFILE('ret','Docs.','Ok',0,'Adjuntar Archivo')
			pcb_archivo = GETFILE()
		ENDIF 


		IF !EMPTY(pcb_archivo) then
			IF used("lectura") then
				SELECT lectura
				use
			ENDIF

			CREATE TABLE lectura FREE (REGISTRO C(98) ,FECHA D, IDREGISTRO N(10), COBRADO N(12,2))
			
								
			SELECT lectura
			APPEND FROM &pcb_archivo SDF
			
			SELECT lectura 
			GO TOP 
			IF  (LEN(ALLTRIM(lectura.registro))= 98) AND ( ;
				SUBSTR(ALLTRIM(lectura.registro),2,3)='FVA' OR ;
				SUBSTR(ALLTRIM(lectura.registro),2,3)='FVB' OR ;
				SUBSTR(ALLTRIM(lectura.registro),2,3)='FVC' OR ;
				SUBSTR(ALLTRIM(lectura.registro),2,3)='FVD' OR ;
				SUBSTR(ALLTRIM(lectura.registro),2,3)='FVE' OR ;
				SUBSTR(ALLTRIM(lectura.registro),2,3)='FVF' OR ;
				SUBSTR(ALLTRIM(lectura.registro),2,3)='FVG' ) THEN
				 
				DELETE
				GO bott
				DELETE
				PACK
				GO TOP 
					REPLACE ALL idregistro 	WITH VAL(SUBSTR(ALLTRIM(lectura.registro),49,10)), ;
								cobrado WITH VAL(SUBSTR(ALLTRIM(lectura.registro),29,12))/100 ;
								fecha   WITH DATE((INT(VAL(SUBSTR(ALLTRIM(lectura.registro),41,4)))),INT(VAL(SUBSTR(ALLTRIM(lectura.registro),45,2))),INT(VAL(SUBSTR(ALLTRIM(lectura.registro),47,2))))

				***** Completo los datos restantes de la factura *****
		
				tipoComproObjtmp 	= CREATEOBJECT('comprobantesclass')
				
				v_idCompNDA = tipoComproObjtmp.getidcomprobante("ND DE AJUSTE CTA CTE")
				
				RELEASE tipoComproObjtmp   
				
				SELECT lectura 
				GO TOP 
				
				DO WHILE NOT EOF()
			
					v_idregistro = lectura.idregistro
					v_cobrado	= lectura.cobrado
					v_fecha	= lectura.fecha
					
					
					sqlmatriz(1)=" select * from facturas f left join comprobantes c on f.idcomproba = c.idcomproba left join puntosventa p on f.pventa = p.pventa "
					sqlmatriz(2)=" where (f.observa2 = '"+ALLTRIM(STR(v_idregistro))+"' and f.idcomproba = "+ALLTRIM(STR(v_idCompNDA))+") or (f.idfactura = "+ALLTRIM(STR(v_idregistro))+" and f.idcomproba <> "+ALLTRIM(STR(v_idCompNDA))+" ) " 
					
					verror=sqlrun(vconeccionCBA,"factura_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los datos de la factura ",0+48+0,"Error")
					    =abreycierracon(vconeccionCBA,"")
					ELSE
					
						SELECT factura_sql
						GO TOP 
						
						IF NOT EOF()
							v_idcbasoci =  cbasociada_sql.idcbasoci
							v_empresaid = VAL(cbasociada_sql.empresaid)
							v_idsubent	= VAL(cbasociada_sql.subcodid)
							v_idcomp 	= IIF(TYPE('v_idregistro')='C',VAL(v_idregistro),v_idregistro)

							v_comproba = factura_sql.comprobante
							v_total1 = factura_sql.total
							v_vence1 = factura_sql.fechavenc1
							v_idcbcobro = 0
							v_fechacob = DTOS(lectura.fecha)
							v_importeCob = lectura.cobrado
							v_recargoCob = lectura.cobrado - v_total1 
							
							ALINES(ARR_codebccomp,cbcobrador_sql.ebc,'-')
							v_tbc  = VAL(ARR_codebccomp(2))
									
							ALINES(ARR_codebccomp,cbcobrador_sql.ebceid,'-')
							v_tbceid  = VAL(ARR_codebccomp(2))
													
							ALINES(ARR_codebccomp,cbcobrador_sql.ebcsid,'-')
							v_tbcsid  = VAL(ARR_codebccomp(2))
							
							ALINES(ARR_codebccomp,cbcobrador_sql.ebcidcomp,'-')
							v_tcbcodcomp= VAL(ARR_codebccomp(2))
							v_idfactura = 	factura_sql.idfactura	
												
							v_strempresaid = STRTRAN(STR(v_empresaid,v_tbceid,0)," ","0")
							v_stridsubent = STRTRAN(STR(v_idsubent,v_tbcsid,0)," ","0")
							v_stridcomp = STRTRAN(STR(v_idfactura ,(v_tcbcodcomp-2),0)," ","0")
							
							v_codibc = v_strempresaid+v_stridsubent+v_stridcomp+"00"
							
							v_difbc = v_tbc - LEN(v_codibc)
							
							IF v_difbc >= 0
								v_cb = v_codibc + REPLICATE('0',v_difbc )
							ELSE
								v_cb = "00010001000000000000000"
							ENDIF 
	
							v_sel = .T.
							
							INSERT INTO cobrostmp VALUES (v_idcbasoci , v_empresaid, v_idsubent,v_idfactura , v_comproba,v_total1, v_vence1,v_idcbcobro,v_fechacob,v_importeCob,v_recargoCob, v_cb, v_sel)
						
						ENDIF 
											
					ENDIF
									
					SELECT lectura
					SKIP 1

				ENDDO


		***********************
	SELECT cobrostmp 
	GO TOP 
		SELECT cobrostmp 
	GO TOP 
	IF EOF()
		MESSAGEBOX("No se pudieron cargar los cobros del archivo... Verifique...",0+16+256,"Convertir archivo")
			
			pcb_Retorno = ""
			RETURN pcb_Retorno
	ENDIF 

		**** Exporto el archivo .ret ****
		DO CASE
		CASE pcb_operacion = 'R' && Formato de archivo Retorno [.RET]
			v_r = 0
			*v_maxSecuencia = calculaSecuenciaMax(v_idcbasoci)
			
			SELECT cbcobrador_sql
			GO  TOP 
			*v_maxSecuencia = cbcobrador_sql.idcbcobra
			*v_maxSecuencia = calculaSecuenciaMaxCob(v_idcbcobrador)
			v_idcbcobra = cbcobrador_sql.idcbcobra
			
			*v_maxSecuencia = cbcobrador_sql.esecuencia
			
			v_maxSecuencia = calculaSecMaxCobrador(v_idcbcobra)
				IF v_maxSecuencia < 0
					v_secuenciastr = '00000'
					
				ELSE
					v_secuenciaAct = v_maxSecuencia + 1
					
					IF v_secuenciaAct > 0
					
						SELECT cbasociada_sql
						v_narchivor	= ALLTRIM(cbasociada_sql.narchivor)
						v_longNarchivor = LEN(v_narchivor)

						IF v_longNarchivor <= 4 AND v_secuenciaAct <= 99999
							
							v_secuenciaStr = REPLICATE('0',5-LEN(ALLTRIM(STR(v_secuenciaAct))))+ALLTRIM(STR(v_secuenciaAct))
							
							v_secuenciastr = ALLTRIM(v_secuenciaStr)
							
							v_nombrearchivo = v_narchivor+v_secuenciaStr+".ret"	
							
							p_idcbasociada = cbasociada_sql.idcbasoci
																		
						v_archivo= _SYSESTACION+"\"+v_nombrearchivo
					
						v_r = ExportarCobro (p_idcbasociada, v_archivo ,"cobrostmp",pcb_EmpresaID,.T.  )

						ELSE
							v_secuenciastr  = '00000'
						ENDIF 
					ELSE
						v_secuenciastr  = '00000'
						
					ENDIF 
				ENDIF 
				

		*******************

			IF v_r = 1
				pcb_Retorno = v_archivo 
			ELSE
				pcb_Retorno = ""
			ENDIF 

		CASE pcb_operacion = 'E' && Formato de archivo Envio[.ENV])
		
		OTHERWISE

		ENDCASE
 
			ELSE
				MESSAGEBOX("El Archivo Seleccionado no es Valido... Verifique...",0+16+256,"Convertir archivo")
				pcb_Retorno = ""
				RETURN pcb_Retorno
			ENDIF 
			
		ELSE
			MESSAGEBOX("No ha seleccionado ningun archivo... Verifique...",0+16+256,"Convertir archivo")
			
			pcb_Retorno = ""
			RETURN pcb_Retorno
		ENDIF
	ELSE
	
		MESSAGEBOX("Error al crear la conexión con la Base de Datos",0+16+256,"Convertir archivo")
		pcb_Retorno = ""
			RETURN pcb_Retorno
	ENDIF 

	RETURN pcb_Retorno
ENDFUNC 


