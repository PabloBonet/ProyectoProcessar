*********************************************************************
***
*** PROGRAMA PARA ALMACENAR LAS FUNCIONES DEL MÓDULO DE COBRANZA
***
*********************************************************************


*/------------------------------------------------------------------------------------------------------------
*/ 	Importación de comprobantes desde archivo de intercambio (Archivo de envio .ENV)
** 	Funcion: ImportarComprobantes 
* 	Parametros: 
*		P_idcbasociada: ID de la entidad asociada (Emisor del archivo de envio .ENV)
*		p_archivo: Path completo con el nombre del archivo .ENV
*	Retorno: Retorna 1 si se importó correctamente, 0 en otro caso
*/------------------------------------------------------------------------------------------------------------

FUNCTION ImportarComprobantes
	PARAMETERS p_idcbasociada, p_archivo,p_tablaComprobantes

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
		v_ebctotal1 	= ALLTRIM(cbasociada_sql.ebctotal1)
		v_ebcvence1 	= ALLTRIM(cbasociada_sql.ebcvence1)
		v_ebctotal2 	= ALLTRIM(cbasociada_sql.ebctotal2)
		v_ebcvence2		= ALLTRIM(cbasociada_sql.ebcvence2)
		v_ebctotal3 	= ALLTRIM(cbasociada_sql.ebctotal3)
		v_ebcvence3 	= ALLTRIM(cbasociada_sql.ebcvence3)
				
		v_sentenciaCrea = "create table "+ALLTRIM(p_tablaComprobantes)+ " (ident I, narchivo C(100), lote I, eperiodo C(20), esecuencia C(10), comproba C(100),idcomp I, total1 Y, vence1 C(8),total2 Y, vence2 C(8), total3 Y, vence3 C(8), bc C(254))"
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
												
						** Código Empresa/Ente **
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

							** Código de Entidad (en código de barra) **
							ALINES(ARR_ebceid,v_ebceid,'-')
							COD_ebceid = SUBSTR(v_linea,VAL(ARR_ebceid(1)),VAL(ARR_ebceid(2)))

							** Subcódigo de Entidad (en código de barra) **
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
							
							** Importe del primer vencimiento (en código de barra) **
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
							
							
							v_lote = 0
							v_comprobante = ""
																									
							v_sentenciaIns1 = " insert into "+ALLTRIM(p_tablaComprobantes)+ " (ident, narchivo, lote, eperiodo, esecuencia, comproba,idcomp, total1, vence1,total2, vence2, total3, vence3, bc) "
							v_sentenciaIns2 = " values ("+ALLTRIM(STR(p_idcbasociada))+",'"+ALLTRIM(v_nombArchivoEnv)+"',"+ALLTRIM(STR(v_lote))+",'"+ALLTRIM(COD_eperiodo)+"','"+ALLTRIM(COD_eesecuencia)+"','"+ALLTRIM(v_comprobante)+"',"+ALLTRIM(STR(NUM_ebcidcomp))+","
							v_sentenciaIns3 = ALLTRIM(STR(NUM_ebctotal1,13,2))+",'"+ALLTRIM(COD_ebcvence1)+"',"+ALLTRIM(STR(NUM_ebctotal2,13,2))+",'"+ALLTRIM(COD_ebcvence2)+"',"+ALLTRIM(STR(NUM_ebctotal3,13,2))+",'"+ALLTRIM(COD_ebcvence3)+"','"+alltrim(COD_ebc)+"')"
							

							v_sentenciaIns = v_sentenciaIns1+v_sentenciaIns2+v_sentenciaIns3
							
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

*/------------------------------------------------------------------------------------------------------------
*/ 	Busca un comprobante por el código de barra
** 	Funcion: buscaCompCB
* 	Parametros: 
*		p_codBarra: Código de barras para buscar el comprobante
*		p_NombreTabla: Nombre de la tabla donde se van a devolver los datos del comprobante buscado
*	Retorno: Retorna True si se encontró el comprobante, False en otro caso
*/------------------------------------------------------------------------------------------------------------
FUNCTION buscarCompCB
PARAMETERS p_codBarra,P_nombreTabla

	v_encontrado = .F.

	IF EMPTY(ALLTRIM(p_codBarra)) = .F. AND EMPTY(ALLTRIM(p_nombreTabla)) = .T.
	
		MESSAGEBOX("Uno de los parámetros es incorrecto", 0+16,"Error al buscar comprobante por código de barra")
		
		RETURN .F.
	
	ENDIF 

	* Me conecto a la base de datos
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="select idcbcompro, idcbasoci, narchivo, lote, eperiodo, esecuencia,comprobante as compro, total1, vence1, total2, vence2, total3, vence3,bc, timestamp,codigo " && Busco en la vista donde voy a tener los ultimos comprobantes ordenados por lote
	sqlmatriz(2)=" from ultcbcomplote " 
	sqlmatriz(3)=" where bc ='"+ALLTRIM(p_codBarra)+"'"

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



*/------------------------------------------------------------------------------------------------------------
*/ 	Busca un comprobante por los codigos de empresa,subcodigo y idcomp
** 	Funcion: buscaCompESC
* 	Parametros: 
*		p_codEnt: Código asignado a la entidad asociada
*		p_subCodEnt: Subcódigo asignado a la entidad asociada
*		p_idcomp: ID del comprobante asociado a la entidad
*		p_NombreTabla: Nombre de la tabla donde se van a devolver los datos del comprobante buscado
*	Retorno: Retorna True si se encontró el comprobante, False en otro caso
*/------------------------------------------------------------------------------------------------------------
FUNCTION buscarCompESC
PARAMETERS p_codEnt,p_subCodEnt,p_idcomp,P_nombreTabla

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

	sqlmatriz(1)="select idcbcompro, idcbasoci, narchivo, lote, eperiodo, esecuencia,comprobante as compro, total1, vence1, total2, vence2, total3, vence3,bc, timestamp,codigo " && Busco en la vista donde voy a tener los ultimos comprobantes ordenados por lote
	sqlmatriz(2)=" from ultcbcomplote " 
	sqlmatriz(3)=" where codigo ='"+ALLTRIM(v_codigoBusqueda)+"'"

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


*/------------------------------------------------------------------------------------------------------------
*/ 	Obtiene el Lote de cobro máximo utilizado
** 	Funcion: obtenerMaxLoteCobro
* 	
*	Retorno: Retorna el Lote máximo, en caso de no haber lotes de cobranza retorna cero. Retorna -1 en caso de error
*/------------------------------------------------------------------------------------------------------------
FUNCTION obtenerMaxLoteCobro

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



*/------------------------------------------------------------------------------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por la entidad pasada como parámetro
** 	Funcion: calculaSecueciaMax
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*/------------------------------------------------------------------------------------------------------------

FUNCTION calculaSecuenciaMax
PARAMETERS p_idcbasociado

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


*/------------------------------------------------------------------------------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por el cobrador pasado como parámetro
** 	Funcion: calculaSecueciaMaxCobrador
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*/------------------------------------------------------------------------------------------------------------

FUNCTION calculaSecMaxCobrador
PARAMETERS p_idcobrador

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


*/------------------------------------------------------------------------------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por el cobrador pasada como parámetro
** 	Funcion: calculaSecueciaMaxCob
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*/------------------------------------------------------------------------------------------------------------

FUNCTION calculaSecuenciaMaxCob
PARAMETERS p_idcbcobrador

IF p_idcbcobrador  > 0
	** Me conecto
	vconeccionD=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT c.esecuencia as maxsec "
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



*/------------------------------------------------------------------------------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada para los lotes de cobros
** 	Funcion: calculaLoteMax
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*/------------------------------------------------------------------------------------------------------------

FUNCTION calculaLoteMax

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




*/------------------------------------------------------------------------------------------------------------
*/ 	Exportación de cobros al archivo de intercambio (Archivo de retorno .RET)
** 	Funcion: ExportarCobro
* 	Parametros: 
*		P_idcbasociada: ID de la entidad asociada (Receptor del archivo .RET)
*		p_archivo: Path completo con el nombre del archivo .RET
*		p_tablaCobros: tabla con los datos de los cobros a exportar
*	Retorno: Retorna 1 si se exportó correctamente, 0 en otro caso
*/------------------------------------------------------------------------------------------------------------

FUNCTION ExportarCobro
	PARAMETERS p_idcbasociada, p_archivo,p_tablaCobros

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
						
			IF v_ultSecRet >= VAL(v_secArc)
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
				MESSAGEBOX("El tamaño del código 'Código de Barras' representado en el campo 'r1bc' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar cobros")
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
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
*!*			
*!*			
*!*			
*!*					
*!*			v_sentenciaCrea = "create table "+ALLTRIM(p_tablaComprobantes)+ " (ident I, narchivo C(100), lote I, eperiodo C(20), esecuencia C(10), comproba C(100),idcomp I, total1 Y, vence1 C(8),total2 Y, vence2 C(8), total3 Y, vence3 C(8), bc C(254))"
*!*			&v_sentenciaCrea
*!*		
*!*			** Recorro el archivo de envio, linea por linea **	
*!*			DO WHILE NOT FEOF(v_punteroArcEnv) && Finaliza cuando encuentra una linea vacia
*!*					v_linea = ALLTRIM(FGETS(v_punteroArcEnv))
*!*			MESSAGEBOX(v_linea)			
*!*					IF EMPTY(v_linea) = .F.
*!*						v_tamLinea = LEN(v_linea)
*!*																
*!*						ALINES(v_longitud,v_elong,'-')
*!*									
*!*						v_tamCodigo = (VAL(v_longitud(2))) - (VAL(v_longitud(1))) + 1 
*!*						
*!*						IF v_tamCodigo > v_tamLinea && COMPRUEBO LONGITUD DEL CODIGO
*!*						
*!*							MESSAGEBOX("Codigo erroneo. La longitud del codigo ("+ALLTRIM(STR(v_tamCodigo))+") es mayor al del registro en el archivo ("+ALLTRIM(STR(v_tamlinea))+")")
*!*							RETURN 0
*!*							&& CODIGO ERRONEO
*!*						ELSE
*!*							&& CODIGO CORRECTO
*!*													
*!*							** Código Empresa/Ente **
*!*							ALINES(ARR_eempresaid,v_eempresaid,'-')
*!*							COD_eempresaid = SUBSTR(v_linea,VAL(ARR_eempresaid(1)),VAL(ARR_eempresaid(2)))
*!*							
*!*							** Código de secuencia de envío **
*!*							ALINES(ARR_eesecuencia,v_eesecuencia,'-')
*!*							COD_eesecuencia = SUBSTR(v_linea,VAL(ARR_eesecuencia(1)),VAL(ARR_eesecuencia(2)))
*!*							
*!*							IF ALLTRIM(v_empresaid) == ALLTRIM(COD_eempresaid) AND ALLTRIM(v_secArc) == ALLTRIM(COD_eesecuencia) 
*!*								
*!*								** Período de Facturación **
*!*								ALINES(ARR_eperiodo,v_eperiodo,'-')
*!*								COD_eperiodo = SUBSTR(v_linea,VAL(ARR_eperiodo(1)),VAL(ARR_eperiodo(2)))

*!*								** Código de Barra Completo **
*!*								ALINES(ARR_ebc,v_ebc,'-')
*!*								COD_ebc = SUBSTR(v_linea,VAL(ARR_ebc(1)),VAL(ARR_ebc(2)))

*!*								** Código de Entidad (en código de barra) **
*!*								ALINES(ARR_ebceid,v_ebceid,'-')
*!*								COD_ebceid = SUBSTR(v_linea,VAL(ARR_ebceid(1)),VAL(ARR_ebceid(2)))

*!*								** Subcódigo de Entidad (en código de barra) **
*!*								ALINES(ARR_ebcsid,v_ebcsid,'-')
*!*								COD_ebcsid = SUBSTR(v_linea,VAL(ARR_ebcsid(1)),VAL(ARR_ebcsid(2)))
*!*							
*!*								** Código del comprobante (en código de barra) **
*!*								ALINES(ARR_ebcidcomp,v_ebcidcomp,'-')
*!*								COD_ebcidcomp = SUBSTR(v_linea,VAL(ARR_ebcidcomp(1)),VAL(ARR_ebcidcomp(2)))
*!*								
*!*								** Convierto el idcomprobante a numero **
*!*								NUM_ebcidcomp = VAL(COD_ebcidcomp)
*!*								** Fecha del primer vencimiento (en código de barra) **
*!*								ALINES(ARR_ebcvence1,v_ebcvence1,'-')
*!*								COD_ebcvence1 = SUBSTR(v_linea,VAL(ARR_ebcvence1(1)),VAL(ARR_ebcvence1(2)))
*!*								
*!*								** Importe del primer vencimiento (en código de barra) **
*!*								ALINES(ARR_ebctotal1,v_ebctotal1,'-')
*!*								COD_ebctotal1 = SUBSTR(v_linea,VAL(ARR_ebctotal1(1)),VAL(ARR_ebctotal1(2)))
*!*															
*!*								** Convierto COD_ebctotal1 a float **
*!*								v_NUM_entt1 = VAL(COD_ebctotal1)
*!*								NUM_ebctotal1 = (v_NUM_entt1/100)
*!*								
*!*								** Fecha del segundo vencimiento (en código de barra) **
*!*								ALINES(ARR_ebcvence2,v_ebcvence2,'-')
*!*								COD_ebcvence2 = SUBSTR(v_linea,VAL(ARR_ebcvence2(1)),VAL(ARR_ebcvence2(2)))
*!*								
*!*								** Importe del segundo vencimiento (en código de barra) **
*!*								ALINES(ARR_ebctotal2,v_ebctotal2,'-')
*!*								COD_ebctotal2 = SUBSTR(v_linea,VAL(ARR_ebctotal2(1)),VAL(ARR_ebctotal2(2)))
*!*								
*!*								** Convierto COD_ebctotal1 a float **
*!*								v_NUM_entt2 = VAL(COD_ebctotal2)
*!*								NUM_ebctotal2 = (v_NUM_entt2/100)
*!*								
*!*								** Fecha del tercer vencimiento (en código de barra) **
*!*								ALINES(ARR_ebcvence3,v_ebcvence3,'-')
*!*								COD_ebcvence3 = SUBSTR(v_linea,VAL(ARR_ebcvence3(1)),VAL(ARR_ebcvence3(2)))
*!*								
*!*								** Importe del tercer vencimiento (en código de barra) **
*!*								ALINES(ARR_ebctotal3,v_ebctotal3,'-')
*!*								COD_ebctotal3 = SUBSTR(v_linea,VAL(ARR_ebctotal3(1)),VAL(ARR_ebctotal3(2)))
*!*								
*!*								** Convierto COD_ebctotal1 a float **
*!*								v_NUM_entt3 = VAL(COD_ebctotal3)
*!*								NUM_ebctotal3 = (v_NUM_entt3/100)
*!*								
*!*								
*!*								v_lote = 0
*!*								v_comprobante = ""
*!*																										
*!*								v_sentenciaIns1 = " insert into "+ALLTRIM(p_tablaComprobantes)+ " (ident, narchivo, lote, eperiodo, esecuencia, comproba,idcomp, total1, vence1,total2, vence2, total3, vence3, bc) "
*!*								v_sentenciaIns2 = " values ("+ALLTRIM(STR(p_idcbasociada))+",'"+ALLTRIM(v_nombArchivoEnv)+"',"+ALLTRIM(STR(v_lote))+",'"+ALLTRIM(COD_eperiodo)+"','"+ALLTRIM(COD_eesecuencia)+"','"+ALLTRIM(v_comprobante)+"',"+ALLTRIM(STR(NUM_ebcidcomp))+","
*!*								v_sentenciaIns3 = ALLTRIM(STR(NUM_ebctotal1,13,2))+",'"+ALLTRIM(COD_ebcvence1)+"',"+ALLTRIM(STR(NUM_ebctotal2,13,2))+",'"+ALLTRIM(COD_ebcvence2)+"',"+ALLTRIM(STR(NUM_ebctotal3,13,2))+",'"+ALLTRIM(COD_ebcvence3)+"','"+alltrim(COD_ebc)+"')"
*!*								

*!*								v_sentenciaIns = v_sentenciaIns1+v_sentenciaIns2+v_sentenciaIns3
*!*								
*!*								&v_sentenciaIns
*!*					
*!*								
*!*							ELSE
*!*								** Código de empresa y secuencia no coincide con el codigo de la empresa y secuencia pasado en el registro del archivo **
*!*						
*!*							ENDIF 
*!*											
*!*						ENDIF 
*!*					ENDIF 

*!*				SKIP 1	
*!*			ENDDO 
*!*			FCLOSE(v_punteroArcEnv)
*!*		RETURN 1

*!*	ENDFUNC  






*/------------------------------------------------------------------------------------------------------------
*/ 	Obtiene el Máximo valor de secuencia utilizada por la empresa pasada como parámetro para exportar al modulo de cobro
** 	Funcion: calculaSecueciaExpMax
* 	
*	Retorno: Retorna el número de Secuencia Máxima. Retorna -1 en caso de error
*/------------------------------------------------------------------------------------------------------------

FUNCTION calculaSecueciaExpMax
PARAMETERS p_idcbcobrador

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


*/------------------------------------------------------------------------------------------------------------
*/ 	Exportación de comprobantes a un archivo de intercambio (Archivo de envio .ENV)
** 	Funcion: ExportarComprobantes
* 	Parametros: 
*		P_idcbcobra: ID de la entidad que va a cobrar desde el archivo de Envio (Receptor del archivo de envio .ENV)
*		p_archivo: Path completo con el nombre del archivo .ENV
*		p_TablaComprobantes: Tabla donde están los compprobantes que se van a exportar
*	Retorno: Retorna 1 si se exportó correctamente, 0 en otro caso
*/------------------------------------------------------------------------------------------------------------

FUNCTION ExportarComprobantes
	PARAMETERS p_idcbcobra, p_archivo,p_tablaComprobantes

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
		
			** Creo el archivo **
			v_adminArc = FCREATE(p_archivo)
	
			SELECT &p_tablaComprobantes
			GO TOP 
			DO WHILE NOT EOF()
				v_linea = ""
			
				*************************************
				*** Código Del Ente de la empresa ***
				*************************************					
				
				v_empresaid 	= ALLTRIM(cbcobrador_sql.narchivoe)
				v_eempresaid	= cbcobrador_sql.eempresaid
				
				ALINES(ARR_eempresaid,v_eempresaid,'-')
				v_tameempresaid = VAL(ARR_eempresaid(2))
				
				IF LEN(ALLTRIM(v_empresaid )) = v_tameempresaid 
					
					v_linea = v_linea+v_empresaid && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("El tamaño del código 'secuencia de retorno' representado en el campo 'r0secuencia' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
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
					MESSAGEBOX("El tamaño del código 'secuencia de retorno' representado en el campo 'r0secuencia' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
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
					MESSAGEBOX("El tamaño del código 'fechaPeriodo' representado en el campo 'eperiodo' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
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
					MESSAGEBOX("El tamaño del código 'CodEntidad' representado en el campo 'ebceid' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
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
					MESSAGEBOX("El tamaño del código 'CodSubCod' representado en el campo 'ebcsid' es mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
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
					MESSAGEBOX("El tamaño del código 'CodComprobante' representado en el campo 'ebcidcomp' es mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				
				*total1, vence1,total2, vence2,total3, vence3
				***************************
				** Importe Vencimiento 1 **
				***************************
							
				v_total1	= &p_tablaComprobantes..total1
				v_ebctotal1	= ALLTRIM(cbcobrador_sql.ebctotal1)
							
				ALINES(ARR_ebctotal1,v_ebctotal1,'-')
				v_tamebctotal1 = VAL(ARR_ebctotal1(2))
										
				v_total1str = ALLTRIM(STR(v_total1 * 100))
									
				IF LEN(ALLTRIM(v_total1str)) <= v_tamebctotal1 
					v_total1str = ALLTRIM(REPLICATE('0',v_tamebctotal1 - len(ALLTRIM(v_total1str)))+ALLTRIM(v_total1str))
					
					v_linea = v_linea+ALLTRIM(v_total1str) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("El tamaño del código 'ImporteVenc1' representado en el campo 'ebctotal1' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*************************
				** Fecha Vencimiento 1 **
				*************************
				v_fechaVence1 	= &p_tablaComprobantes..vence1				
				v_ebcvence1 	= ALLTRIM(cbcobrador_sql.ebcvence1)
				
				ALINES(ARR_ebcvence1,v_ebcvence1,'-')
				v_tamebcvence1 = VAL(ARR_ebcvence1(2))
		
				
				** Convierto la fecha a formato Juliano **
							
				v_fechaVence1J= SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaVence1 ,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaVence1 ,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaVence1 ,7,2)))))
												
				IF LEN(ALLTRIM(v_fechaVence1J)) = v_tamebcvence1 
					v_linea = v_linea+ALLTRIM(v_fechaVence1J) && Si está correcto: lo agrego a la linea
				ELSE
					MESSAGEBOX("El tamaño del código 'fechaVence1' representado en el campo 'ebcvence1' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				***************************
				** Importe Vencimiento 2 **
				***************************
							
				v_total2	= &p_tablaComprobantes..total2
				v_ebctotal2	= ALLTRIM(cbcobrador_sql.ebctotal2)
							
				ALINES(ARR_ebctotal2,v_ebctotal2,'-')
				v_tamebctotal2 = VAL(ARR_ebctotal2(2))
										
				v_total2str = ALLTRIM(STR(v_total2 * 100))
									
				IF LEN(ALLTRIM(v_total2str)) <= v_tamebctotal2 
					v_total2str = ALLTRIM(REPLICATE('0',v_tamebctotal2 - len(ALLTRIM(v_total2str)))+ALLTRIM(v_total2str))
					
					v_linea = v_linea+ALLTRIM(v_total2str) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("El tamaño del código 'ImporteVenc2' representado en el campo 'ebctotal2' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*************************
				** Fecha Vencimiento 2 **
				*************************
				v_fechaVence2 	= &p_tablaComprobantes..vence2				
				v_ebcvence2 	= ALLTRIM(cbcobrador_sql.ebcvence2)
				
				ALINES(ARR_ebcvence2,v_ebcvence2,'-')
				v_tamebcvence2= VAL(ARR_ebcvence2(2))
		
				
				** Convierto la fecha a formato Juliano **
							
				v_fechaVence2J= SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaVence2,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaVence2,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaVence2,7,2)))))
												
				IF LEN(ALLTRIM(v_fechaVence2J)) = v_tamebcvence2
					v_linea = v_linea+ALLTRIM(v_fechaVence2J) && Si está correcto: lo agrego a la linea
				ELSE
					MESSAGEBOX("El tamaño del código 'fechaVence2' representado en el campo 'ebcvence2' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				***************************
				** Importe Vencimiento 3**
				***************************
							
				v_total3	= &p_tablaComprobantes..total3
				v_ebctotal3	= ALLTRIM(cbcobrador_sql.ebctotal3)
							
				ALINES(ARR_ebctotal3,v_ebctotal3,'-')
				v_tamebctotal3 = VAL(ARR_ebctotal3(2))
										
				v_total3str = ALLTRIM(STR(v_total3 * 100))
									
				IF LEN(ALLTRIM(v_total3str)) <= v_tamebctotal3 
					v_total3str = ALLTRIM(REPLICATE('0',v_tamebctotal3 - len(ALLTRIM(v_total3str)))+ALLTRIM(v_total3str))
					
					v_linea = v_linea+ALLTRIM(v_total3str) && Si está correcto: lo agrego a la linea
					
				ELSE
					MESSAGEBOX("El tamaño del código 'ImporteVenc3' representado en el campo 'ebctotal3' es Mayor al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*************************
				** Fecha Vencimiento 2 **
				*************************
				v_fechaVence3 	= &p_tablaComprobantes..vence3				
				v_ebcvence3 	= ALLTRIM(cbcobrador_sql.ebcvence3)
				
				ALINES(ARR_ebcvence3,v_ebcvence3,'-')
				v_tamebcvence3= VAL(ARR_ebcvence3(2))
		
				
				** Convierto la fecha a formato Juliano **
							
				v_fechaVence3J= SYS(11,DATE(VAL(ALLTRIM(SUBSTR(v_fechaVence3,1,4))),VAL(ALLTRIM(SUBSTR(v_fechaVence3,5,2))),VAL(ALLTRIM(SUBSTR(v_fechaVence3,7,2)))))
												
				IF LEN(ALLTRIM(v_fechaVence3J)) = v_tamebcvence3
					v_linea = v_linea+ALLTRIM(v_fechaVence3J) && Si está correcto: lo agrego a la linea
				ELSE
					MESSAGEBOX("El tamaño del código 'fechaVence3' representado en el campo 'ebcvence3' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
				ENDIF
				
				
				*********************************************
				** Valido la Longitud del código de barras **
				*********************************************
				v_elong 		= ALLTRIM(cbcobrador_sql.elong)
				
				
				v_tamCodBarra = ALLTRIM(cbcobrador_sql.ebc)
				ALINES(ARR_ebccodbarra,v_tamCodBarra,'-')
				v_posIniCOdBarra = VAL(ARR_ebccodbarra(1))
				v_tamebccodbarra= VAL(ARR_ebccodbarra(2))
				
				v_CodBarra = SUBSTR(v_linea,v_posIniCodBarra)
			
				IF LEN(ALLTRIM(v_codBarra)) != v_tamebccodbarra
					MESSAGEBOX("El tamaño del código 'CodBarra' representado en el campo 'ebc' es distinto al indicado en la configuración.",0+48+0,"Error al Exportar comprobantes")
					RETURN 0
									
				ENDIF 
			
				FPUTS(v_adminArc,v_linea)

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








*/------------------------------------------------------------------------------------------------------------
*/ 	Importación de cobros desde archivo de intercambio (Archivo de retorno .RET)
** 	Funcion: ImportarCobros 
* 	Parametros: 
*		p_idcbcobra: ID de la entidad que realizo el cobro (Emisor del archivo de retorno .RET)
*		p_archivo: Path completo con el nombre del archivo .RET
*		p_tablaCobros: Nombre de la tabla donde se van a cargar los cobros importados
*	Retorno: Retorna 1 si se importó correctamente, 0 en otro caso
*/------------------------------------------------------------------------------------------------------------

FUNCTION ImportarCobros
	PARAMETERS p_idcbcobra, p_archivo,p_tablaCobros

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
		v_ebctotal1 	= ALLTRIM(cbcobrador_sql.ebctotal1)
		v_ebcvence1 	= ALLTRIM(cbcobrador_sql.ebcvence1)
		v_ebctotal2 	= ALLTRIM(cbcobrador_sql.ebctotal2)
		v_ebcvence2		= ALLTRIM(cbcobrador_sql.ebcvence2)
		v_ebctotal3 	= ALLTRIM(cbcobrador_sql.ebctotal3)
		v_ebcvence3 	= ALLTRIM(cbcobrador_sql.ebcvence3)
		
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
			IF VAL(COD_r0secuencia) <= v_ultSecCob 
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
										
									
																
									 
									
									
									
									v_comprobante = ""
																											
									v_sentenciaIns1 = " insert into "+ALLTRIM(p_tablaCobros)+ " (ident, puntorec, secuencia, idcobro, fechaCobro, impCobro, recCobro, bc) "
									v_sentenciaIns2 = " values ('"+ALLTRIM(COD_r0empresaid)+"','"+ALLTRIM(COD_r0puntorec)+"','"+ALLTRIM(COD_r0secuencia)+"',"+ALLTRIM(STR(NUM_r1idcobro))+",'"+ALLTRIM(STR_r1fechacobro)+"',"
									v_sentenciaIns3 = ALLTRIM(STR(NUM_r1importe,14,2))+","+ALLTRIM(STR(NUM_r1recargo,14,2))+",'"+ALLTRIM(COD_r1bc)+"')"

									v_sentenciaIns = v_sentenciaIns1+v_sentenciaIns2+v_sentenciaIns3
									MESSAGEBOX(v_sentenciaIns)
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
							NUM_r2total = (VAL(COD_r1importe)/100)
							
							
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
