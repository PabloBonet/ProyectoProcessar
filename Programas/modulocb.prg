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
		MESSAGEBOX(v_linea)			
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










