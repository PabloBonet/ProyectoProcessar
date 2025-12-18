*****************************************************************************************
********** PROGRAMA PARA GUARDAR LAS FUNCIONES RELACIONADAS A LAS VALIDACIONES **********
*****************************************************************************************

FUNCTION valfechactrlcompro
PARAMETERS pa_fecha, pa_conexion
*#/----------------------------------------
* Valida si la fecha pasada como parámetro es mayor o igual a la fecha indicada en la variable _SYSFECHACTRLCOMPRO
* PARAMETROS: 
*			pa_fecha [C]: fecha a validar
*			pa_conexion [I]: conexión a la base de datos a utilizar, si no se pasa conexión crea una nueva
* RETORNO: 
*			Retorna True si la validación es correcta, False en otro caso
*#/----------------------------------------

	** Valido las fechas **
	IF TYPE("pa_fecha") <> 'C' &&La fecha pasada no es caracter -> Retorno Falso
		RETURN .F.
	ENDIF 
	
	IF TYPE('_SYSFECTRLCOMP') = 'U' && No existe la variable -> la validación no se hace
		RETURN .T.
	ELSE
		IF EMPTY(ALLTRIM(_SYSFECTRLCOMP))  && La variable está vacia -> la validación no se hace
			RETURN .T.
		ELSE
		
			v_fechactrlD = cftofc(ALLTRIM(SUBSTR(_SYSFECTRLCOMP,1,8)))
			v_fechactrlH = cftofc(ALLTRIM(SUBSTR(_SYSFECTRLCOMP,10)))

			v_fechavalD  = cftofc(pa_fecha)
			
			IF v_fechavalD >= v_fechactrlD AND (EMPTY(v_fechactrlH) OR ( !EMPTY(v_fechactrlH) AND v_fechavalD <= v_fechactrlH )) THEN 
				RETURN  .T.
			ELSE
				MESSAGEBOX("La fecha no es Válida, debe estar en el período: "+DTOS(v_fechactrlD)+" - "+DTOS(v_fechactrlH),0+16+0,"Validación de fecha")
				RETURN .F.
			ENDIF 	
		ENDIF 
	ENDIF 

ENDFUNC 



FUNCTION FCierreContable
PARAMETERS pl_conexion
*#/----------------------------------------
* Devuelve la Fecha del Ultimo Cierre de Ejercicio Contable o Vacío si no hay cierre. 
* Parametro : Conexion a la Base de Datos
*#/----------------------------------------

	IF TYPE("pl_conexion") = 'N' THEN 
		IF pl_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionCR = pl_conexion
		ELSE 
			vconeccionCR = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionCR = abreycierracon(0,_SYSSCHEMA)	
		pl_conexion = 0
	ENDIF 

	* Busca la Fecha del Ultimo Cierre de Ejercicio Económico ***	
	sqlmatriz(1)=" SELECT max(fecha) as fecha  FROM asientos where idtipoasi = 3 "
	verror=sqlrun(vconeccionCR ,"fecha_cierre")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la Fecha de Cierre de Ejercicio... ",0+48+0,"Error")
	    RETURN '-'  
	ENDIF
	SELECT fecha_cierre
	GO TOP 

	IF EOF() THEN && Agregar articulo a un grupo de Línea
		v_maxifecha = ""		
	ELSE
		v_maxifecha = IIF((ISNULL(fecha_cierre.fecha) or EMPTY(fecha_cierre.fecha)),"",fecha_cierre.fecha)
	ENDIF 
	USE IN fecha_cierre
	IF pl_conexion= 0 THEN && cierro la conexion si no la abrio al ingresar
		=abreycierracon(vconeccionCR,"")
	ENDIF 

RETURN v_maxifecha





FUNCTION EVProductosWeb
PARAMETERS pa_fecha
*#/----------------------------------------
* Funcion de Control de ultima actualización WEB de productos
* Si la diferencia entre la ultima actualizacion y el dia de hoy es mayor 
* Al parametro de dias de actualizacion de imagenes
* Inserta un Evento de Agenda para informar que no se están haciendo
* las actualizaciones en la web
*#/----------------------------------------

	IF !(TYPE('_SYSPRODUCTOSWEB')='C') THEN 
		RETURN .T.
	ELSE
		IF  (SUBSTR(_SYSPRODUCTOSWEB+' ',1,1)='N') then  
			RETURN .T. 
		ENDIF 
	ENDIF 

	nFilas = ALINES(ArrProductoWEB, _SYSPRODUCTOSWEB , ";")
	IF nFilas = 0 THEN 
		RETURN .T. 
	ENDIF 
	
	v_listaWEB01 	= ArrProductoWEB(1)
	v_listaWEB02 	= ArrProductoWEB(2)
	v_depositoWEB   = ArrProductoWEB(3) 
	v_HostWEB		= ArrProductoWEB(4)
	v_PortWEB		= ArrProductoWEB(5)		
	v_UserWEB		= ArrProductoWEB(6)		
	v_PassWEB		= ArrProductoWEB(7)		
	v_PathLCSV		= ArrProductoWEB(8)
	v_PathLIMG      = ArrProductoWEB(9)		
	v_PathRCSV		= ArrProductoWEB(10)		
	v_PathRIMG		= ArrProductoWEB(11)
	v_DiasIMG		= ArrProductoWEB(12)		
	v_HostLOC		= ArrProductoWEB(13)		
	v_InteVALO		= ArrProductoWEB(14)
	v_ModoFTP		= ArrProductoWEB(15)
	v_fechaUA		= ArrProductoWEB(16)		


	** Valido las fechas **	
	IF !EMPTY(ALLTRIM(v_fechaUA))  && La variable está vacia -> la validación no se hace
		v_fechaUAD = cftofc(v_fechaUA)
		v_cantidaddias = ABS( pa_fecha - v_fechaUAD )
		IF v_cantidaddias >= ( VAL(v_DiasIMG) - 1 ) THEN && cantidad de dias mayor a los de las actualizaciones de imagenes debo informar
			vaa = FNotificaAgenda("A0001","","")
		ENDIF 			
	ENDIF 
	
	RELEASE ArrProductoWEB
	
	RETURN .t. 
	
RETURN 




FUNCTION puedeAnular
PARAMETERS p_tabla, p_campo, p_idregistro,p_tipoInd
*#/----------------------------------------
* Valida si se puede anular el comprobante pasado como parámetro
* Parametros : p_tabla	= Tabla del comprobante a validar
*              p_campo	= Nombre del campo del comprobante a validar
*			   p_idregistro = ID del registro del comprobante a validar
*			   p_tipoind = Tipo de dato del registro
*RETURN: True si se puede anular, False en otro caso

*#/----------------------------------------

	v_retorno = .F.
	
	*** Estados: 'ACTIVO', 'ANULADO', 'PENDIENTE AUTORIZACION', 'AUTORIZADO', 'RECHAZADO', 'ERROR'
	
	IF TYPE('p_tipoInd') == 'L'
		p_tipoInd = 'N'
	ENDIF 
	
	IF p_tipoInd == 'C' OR p_tipoInd == 'N'
	ELSE 
		RETURN .F.
	ENDIF 
	
	vconeccionFN = abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)=" select * "
	sqlmatriz(2)=" from "+ALLTRIM(p_tabla)
	sqlmatriz(3)=" where "+ALLTRIM(p_campo)+IIF(p_tipoInd = 'N', "="+ALLTRIM(STR(p_idregistro)),"="+ALLTRIM(p_idregistro))
	
	verror=sqlrun(vconeccionFN,"comproAnula_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante a ANULAR ",0+48+0,"Error")
	     =abreycierracon(vconeccionFN,"")
	    RETURN .F.
	ENDIF

	
	SELECT comproAnula_sql
	GO top
	
	IF NOT EOF()
		v_idcomproba = comproAnula_sql.idcomproba
		
		
		sqlmatriz(1)=" SELECT * FROM validaanular "
		sqlmatriz(2)=" where idcompa = "+ALLTRIM(STR(v_idcomproba))
		sqlmatriz(3)=" order by idcompb desc"
						
		verror=sqlrun(vconeccionFN,"validaanular_sql")
	
		
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de parametros de anulación ",0+48+0,"Error")
		     =abreycierracon(vconeccionFN,"")
		    RETURN .F.
		ENDIF
		
		
		SELECT validaanular_sql
		GO TOP 
		IF NOT EOF()
			v_retorno = .F.
		
			DO WHILE NOT EOF()
								
				v_idcomprobab = validaanular_sql.idcompb
				
				
				IF v_idcomprobab == 0
			
			
					IF v_retorno = .F.
						v_retorno = IIF(validaanular_sql.noanula = 1,.F.,.T.)

					ENDIF 
		
		
		
					v_retornoE = IIF(validaanular_sql.noelimina = 1,.F.,.T.)

					IF v_retorno = .T. 
					
						IF v_retornoE = .T. && Si no anula
							v_retorno = .F.	
						ENDIF 
					ENDIF 
					
				ELSE
					** Obtengo los asociados para ver si puedo anular
									
					v_tablaret = GetLinkCompro(v_idcomproba , p_idregistro,vconeccionFN)

					v_compasociados = ""
			
					SELECT &v_tablaret
					GO TOP 
					IF NOT EOF()
						DO WHILE NOT EOF()

							v_idcompa = &v_tablaret..idcomproa
							v_idcompb = &v_tablaret..idcomprob
												
							IF v_idcomproba == v_idcompa && IDCOMPA es igual al comprobante que quiero anular -> busco el idcompb
					
								SELECT * FROM validaanular_sql WHERE idcompb = v_idcompb INTO CURSOR auxvalidarB
								
								SELECT auxvalidarB 
								GO TOP 
								
								IF NOT EOF()
									v_auxnoanulaB = auxvalidarB.noanula
									v_retorno = IIF(v_auxnoanulaB  = 1,.F.,.T.)		
								ENDIF 

							ELSE
							
								IF v_idcomproba == v_idcompb && IDCOMPB es igual al comprobante que quiero anular -> busco el idcompa
								
									SELECT * FROM validaanular_sql WHERE idcompa = v_idcompa INTO CURSOR auxvalidarA
								
									SELECT auxvalidarA 
									GO TOP 
									
									IF NOT EOF()
										v_auxnoanulaA = auxvalidarA.noanula
										v_retorno = IIF(v_auxnoanulaA  = 1,.F.,.T.)		
									ENDIF 
								ENDIF 
							
							ENDIF 
							
							IF v_retorno == .F.
								RETURN v_retorno
							ENDIF 	

							SELECT &v_tablaret
							SKIP 1
						ENDDO
								
								
					ELSE
						*** No tiene comprobantes asociados podria dejar eliminar
						
						v_retorno = .T.
					ENDIF 
												
				ENDIF 
				
			
				SELECT validaanular_sql
				SKIP 1

			ENDDO
					
		ELSE

			MESSAGEBOX("No se puede determinar si el comprobante se puede Anular",0+16+256,"Anular comprobante")
			
			RETURN .F.
		ENDIF 
		
	else
		RETURN .F.
	
	ENDIF 
	
	RETURN v_retorno

ENDFUNC 





FUNCTION puedeEliminar
PARAMETERS p_tabla, p_campo, p_idregistro,p_tipoInd
*#/----------------------------------------
* Valida si se puede eliminar el comprobante pasado como parámetro
* Parametros : p_tabla	= Tabla del comprobante a validar
*              p_campo	= Nombre del campo del comprobante a validar
*			   p_idregistro = ID del registro del comprobante a validar
*			   p_tipoind = Tipo de dato del registro
*RETURN: True si se puede anular, False en otro caso

*#/----------------------------------------

	v_retorno = .F.
	
	*** Estados: 'ACTIVO', 'ANULADO', 'PENDIENTE AUTORIZACION', 'AUTORIZADO', 'RECHAZADO', 'ERROR'
	
	IF TYPE('p_tipoInd') == 'L'
		p_tipoInd = 'N'
	ENDIF 
	
	IF p_tipoInd == 'C' OR p_tipoInd == 'N'
	ELSE 
		RETURN .F.
	ENDIF 
	
	
	
		
	************************************************************************************************
	** Para la eliminación doy priodidad a como se venia eliminando, DEPENDIENDO del ESTADO
	** Si según el estado se puede eliminar -> se retorna TRUE sino FALSE. 
	** Si el estado indica que no se puede eliminar -> se usa la variable '_SYSVALANULAR' y la tabla 'validaanular' 
	************************************************************************************************
		
		peestadosObjc		= CREATEOBJECT('estadosclass')
			
		v_estadoAnulado 	= peestadosObjc.getIdestado("ANULADO")
		v_estadoRechazado 	= peestadosObjc.getIdestado("RECHAZADO")
		v_estadoError 		= peestadosObjc.getIdestado("ERROR")
		v_estadoPendiente 	= peestadosObjc.getIdestado("PENDIENTE AUTORIZACION")
		v_estadoActivo   	= peestadosObjc.getIdestado("ACTIVO")
		v_estadoAutorizado	= peestadosObjc.getIdestado("AUTORIZADO")	

		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		sqlmatriz(1)= "SELECT id as idcomp, fechaest as fecha, idestador "
		sqlmatriz(2)= " FROM ultimoestado "
		sqlmatriz(3)= " where tabla = '"+ALLTRIM(v_aetabla)+"' and campo = '"+ALLTRIM(v_aenomindice)+"' and (idestador = "+ALLTRIM(STR(v_estadoPendiente))+" or idestador = "+ALLTRIM(STR(v_estadoAnulado ))+" or idestador = "+ALLTRIM(STR(v_estadoRechazado)) +") and id = '"+ ALLTRIM(STR(p_idregistro))+"'"

		verror=sqlrun(vconeccionFN,"ComAnuRec_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al Buscar estado del comprobante",0+48+0,"Anular/Eliminar comprobates")
		    RETURN .F.
		ENDIF	

		v_fechaAnulado = ""
		 SELECT ComAnuRec_sql
		 GO top
		 
		 IF NOT EOF()
		 	v_estador = ComAnuRec_sql.idestador
		 	DO CASE
			 	CASE v_estador = v_estadoAnulado
		 			MESSAGEBOX("El comprobante ya esta Anulado.",0+48+0,"Anulación de Comprobante")
		 			v_eliminarComp = .F.
		 		CASE v_estador = v_estadoRechazado
					v_eliminarComp = .T.
		 		CASE v_estador = v_estadoPendiente
					v_eliminarComp = .T.
			 	OTHERWISE
					v_eliminarComp = .F.
		 	ENDCASE
		 
		 ELSE
		 	v_eliminarComp = .F.
		 ENDIF 
	
	
	IF TYPE('_SYSVALANULAR') = 'N' AND _SYSVALANULAR = 1
		IF v_eliminarComp = .T.
			RETURN .T.
		ENDIF 
	ELSE
		RETURN v_eliminarComp 
	ENDIF 
	

	
	vconeccionFN = abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)=" select * "
	sqlmatriz(2)=" from "+ALLTRIM(p_tabla)
	sqlmatriz(3)=" where "+ALLTRIM(p_campo)+IIF(p_tipoInd = 'N', "="+ALLTRIM(STR(p_idregistro)),"="+ALLTRIM(p_idregistro))
	
	verror=sqlrun(vconeccionFN,"comproAnula_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante a ANULAR ",0+48+0,"Error")
	     =abreycierracon(vconeccionFN,"")
	    RETURN .F.
	ENDIF

	
	SELECT comproAnula_sql
	GO top
	
	IF NOT EOF()
		v_idcomproba = comproAnula_sql.idcomproba
		
		
		sqlmatriz(1)=" SELECT * FROM validaanular "
		sqlmatriz(2)=" where idcompa = "+ALLTRIM(STR(v_idcomproba))
		sqlmatriz(3)=" order by idcompb desc"
						
		verror=sqlrun(vconeccionFN,"validaeliminar_sql")
	
		
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de parametros de anulación ",0+48+0,"Error")
		     =abreycierracon(vconeccionFN,"")
		    RETURN .F.
		ENDIF
		
		
		SELECT validaeliminar_sql
		GO TOP 
		IF NOT EOF()
		
				v_retorno = .F.
			DO WHILE NOT EOF()
			
			
				
				v_idcomprobab = validaeliminar_sql.idcompb
				
				
				IF v_idcomprobab == 0 
				
					IF v_retorno = .F.
						v_retorno = IIF(validaeliminar_sql.noelimina = 1,.F.,.T.)
					ENDIF 

					
				ELSE
					** Obtengo los asociados para ver si puedo eliminar
					
					
						v_tablaret = GetLinkCompro(v_idcomproba , p_idregistro,vconeccionFN)
				
						v_compasociados = ""
				
						SELECT &v_tablaret
						GO TOP 
						IF NOT EOF()
							DO WHILE NOT EOF()
							
								v_idcompa = &v_tablaret..idcomproa
								v_idcompb = &v_tablaret..idcomprob
											
											
								IF v_idcomproba == v_idcompa && IDCOMPA es igual al comprobante que quiero eliminar -> busco el idcompb
								
									IF v_idcomprobab == v_idcompb 
										v_retorno = IIF(validaeliminar_sql.noelimina = 1,.F.,.T.)								
									ENDIF 
								ELSE
									IF v_idcomproba == v_idcompb && IDCOMPB es igual al comprobante que quiero anular -> busco el idcompa
									
										IF v_idcomprobab == v_idcompa 
											v_retorno = IIF(validaeliminar_sql.noanula = 1,.F.,.T.)
										ENDIF 

									ENDIF 
								
								ENDIF 
								
									IF v_retorno == .F.
										RETURN v_retorno
									ENDIF 

								SELECT &v_tablaret
								SKIP 1
							ENDDO
						ELSE
							*** No tiene comprobantes asociados podria dejar eliminar
							
							v_retorno = .T.
						ENDIF 

				ENDIF 
			
			
			
			
				
				SELECT validaeliminar_sql
				SKIP 1
			ENDDO
		
		
		
		
		
		
		
			
			
			
		ELSE

			MESSAGEBOX("No se puede determinar si el comprobante se puede Eliminar",0+16+256,"Eliminar comprobante")
			
			RETURN .F.
		ENDIF 
		
		
		
	else
		RETURN .F.
	
	ENDIF 

	
	
	RETURN v_retorno

ENDFUNC 


*!*	FUNCTION puedeAnular
*!*	PARAMETERS p_tabla, p_campo, p_idregistro,p_tipoInd
*!*	*#/----------------------------------------
*!*	* Valida si se puede anular el comprobante pasado como parámetro
*!*	* Parametros : p_tabla	= Tabla del comprobante a validar
*!*	*              p_campo	= Nombre del campo del comprobante a validar
*!*	*			   p_idregistro = ID del registro del comprobante a validar
*!*	*			   p_tipoind = Tipo de dato del registro
*!*	*RETURN: True si se puede anular, False en otro caso

*!*	*#/----------------------------------------

*!*		v_retorno = .F.
*!*		
*!*		*** Estados: 'ACTIVO', 'ANULADO', 'PENDIENTE AUTORIZACION', 'AUTORIZADO', 'RECHAZADO', 'ERROR'
*!*		
*!*		IF TYPE('p_tipoInd') == 'L'
*!*			p_tipoInd = 'N'
*!*		ENDIF 
*!*		
*!*		IF p_tipoInd == 'C' OR p_tipoInd == 'N'
*!*		ELSE 
*!*			RETURN .F.
*!*		ENDIF 
*!*		
*!*		vconeccionFN = abreycierracon(0,_SYSSCHEMA)	
*!*		
*!*		sqlmatriz(1)=" select * "
*!*		sqlmatriz(2)=" from "+ALLTRIM(p_tabla)
*!*		sqlmatriz(3)=" where "+ALLTRIM(p_campo)+IIF(p_tipoInd = 'N', "="+ALLTRIM(STR(p_idregistro)),"="+ALLTRIM(p_idregistro))
*!*		
*!*		verror=sqlrun(vconeccionFN,"comproAnula_sql")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante a ANULAR ",0+48+0,"Error")
*!*		     =abreycierracon(vconeccionFN,"")
*!*		    RETURN .F.
*!*		ENDIF

*!*		
*!*		SELECT comproAnula_sql
*!*		GO top
*!*		
*!*		IF NOT EOF()
*!*			v_idcomproba = comproAnula_sql.idcomproba
*!*			
*!*			
*!*			sqlmatriz(1)=" SELECT * FROM validaanular "
*!*			sqlmatriz(2)=" where idcompa = "+ALLTRIM(STR(v_idcomproba))
*!*			sqlmatriz(3)=" order by idcompb desc"
*!*							
*!*			verror=sqlrun(vconeccionFN,"validaanular_sql")
*!*		
*!*			
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de parametros de anulación ",0+48+0,"Error")
*!*			     =abreycierracon(vconeccionFN,"")
*!*			    RETURN .F.
*!*			ENDIF
*!*			
*!*			
*!*			SELECT validaanular_sql
*!*			GO TOP 
*!*			IF NOT EOF()
*!*				v_retorno = .F.
*!*				
*!*				v_idcomprobab = validaanular_sql.idcompb
*!*				
*!*				
*!*				IF v_idcomprobab == 0
*!*					v_retorno = IIF(validaanular_sql.noanula = 1,.F.,.T.)
*!*					
*!*				ELSE
*!*					** Obtengo los asociados para ver si puedo anular
*!*					
*!*					
*!*						v_tablaret = GetLinkCompro(v_idcomproba , p_idregistro,vconeccionFN)
*!*						MESSAGEBOX("Asociados")
*!*						MESSAGEBOX(v_tablaret)
*!*						v_compasociados = ""
*!*				
*!*						SELECT &v_tablaret
*!*						GO TOP 
*!*						IF NOT EOF()
*!*							DO WHILE NOT EOF()
*!*								MESSAGEBOX("EN WHILE")
*!*								v_idcompa = &v_tablaret..idcomproa
*!*								v_idcompb = &v_tablaret..idcomprob
*!*													
*!*			
*!*											
*!*								IF v_idcomproba == v_idcompa && IDCOMPA es igual al comprobante que quiero anular -> busco el idcompb
*!*																
*!*									
*!*									
*!*									SELECT * FROM validaanular_sql WHERE idcompb = v_idcompb INTO CURSOR auxvalidarB
*!*									
*!*									SELECT auxvalidarB 
*!*									GO TOP 
*!*									
*!*									IF NOT EOF()
*!*										
*!*										v_auxnoanulaB = auxvalidarB.noanula
*!*										v_retorno = IIF(v_auxnoanulaB  = 1,.F.,.T.)		
*!*										MESSAGEBOX(v_retorno)
*!*									ENDIF 
*!*									
*!*									
*!*	*!*									IF v_idcomprobab == v_idcompb 
*!*	*!*										MESSAGEBOX("C2")
*!*	*!*										MESSAGEBOX(validaanular_sql.noanula)
*!*	*!*										
*!*	*!*										v_retorno = IIF(validaanular_sql.noanula = 1,.F.,.T.)								
*!*	*!*									ENDIF 
*!*								ELSE
*!*								
*!*									IF v_idcomproba == v_idcompb && IDCOMPB es igual al comprobante que quiero anular -> busco el idcompa
*!*									
*!*										SELECT * FROM validaanular_sql WHERE idcompa = v_idcompa INTO CURSOR auxvalidarA
*!*									
*!*										SELECT auxvalidarA 
*!*										GO TOP 
*!*										
*!*										IF NOT EOF()
*!*									
*!*											v_auxnoanulaA = auxvalidarA.noanula
*!*											v_retorno = IIF(v_auxnoanulaA  = 1,.F.,.T.)		
*!*								
*!*										ENDIF 
*!*									
*!*	*!*									
*!*	*!*											MESSAGEBOX("C4")
*!*	*!*										IF v_idcomprobab == v_idcompa 
*!*	*!*											v_retorno = IIF(validaanular_sql.noanula = 1,.F.,.T.)
*!*	*!*										ENDIF 

*!*									ENDIF 
*!*								
*!*								ENDIF 
*!*								
*!*								IF v_retorno == .F.
*!*									RETURN v_retorno
*!*								ENDIF 	

*!*								SELECT &v_tablaret
*!*								SKIP 1
*!*							ENDDO
*!*							
*!*							
*!*									
*!*									
*!*						ELSE
*!*							*** No tiene comprobantes asociados podria dejar eliminar
*!*							
*!*							v_retorno = .T.
*!*						ENDIF 
*!*										
*!*						
*!*	*!*						MESSAGEBOX(v_compasociados)
*!*	*!*				MESSAGEBOX("V4")
*!*				ENDIF 
*!*				
*!*				
*!*			ELSE

*!*				MESSAGEBOX("No se puede determinar si el comprobante se puede Anular",0+16+256,"Anular comprobante")
*!*				
*!*				RETURN .F.
*!*			ENDIF 
*!*			
*!*			
*!*			
*!*		else
*!*			RETURN .F.
*!*		
*!*		ENDIF 
*!*		
*!*	*!*		v_estadosR	= CREATEOBJECT('estadosclass')
*!*	*!*		v_estadoAnulado = v_estadosR.getIdestado("ANULADO")
*!*	*!*		v_estadoPendAut = v_estadosR.getIdestado("PENDIENTE AUTORIZACION")
*!*	*!*		
*!*	*!*		
*!*	*!*		
*!*	*!*		
*!*	*!*		v_estadoComp = obtenerEstado(p_tabla,p_campo,p_idregistro,p_tipoInd)
*!*	*!*		
*!*	*!*		
*!*	*!*		
*!*	*!*		DO CASE
*!*	*!*			CASE ALLTRIM(p_tabla) == "acopio"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "acopiop"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "ajustestockp"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "anularp"
*!*	*!*				v_retorno = .F.

*!*	*!*			CASE ALLTRIM(p_tabla) =="cajaie"
*!*	*!*				v_retorno = CHAnularCMP (v_idcomproba , p_idregistro, vconeccionFN)
*!*	*!*	*!*				 RETURN v_retorno
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "cajamovip"
*!*	*!*				v_retorno = .F.
*!*	*!*			CASE ALLTRIM(p_tabla) == "cumplimentap"
*!*	*!*				
*!*	*!*			CASE ALLTRIM(p_tabla) == "factuprove"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "facturas"
*!*	*!*				*** Las Facturas no se pueden anular
*!*	*!*				v_retorno = .F.
*!*	*!*				
*!*	*!*			CASE ALLTRIM(p_tabla) == "np"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "otmovistockp"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "pagares"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) =="pagosprov"
*!*	*!*				v_retorno = CHAnularCMP (v_idcomproba , p_idregistro, vconeccionFN) 
*!*	*!*	*!*				 RETURN v_retorno
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "presupu"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) =="recibos"
*!*	*!*				 v_retorno = CHAnularCMP (v_idcomproba , p_idregistro, vconeccionFN)	 
*!*	*!*	*!*				 RETURN v_retorno
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "remitos"
*!*	*!*				
*!*	*!*			CASE ALLTRIM(p_tabla) == "transferencias"
*!*	*!*			
*!*	*!*			CASE ALLTRIM(p_tabla) == "transfeti"
*!*	*!*				 
*!*	*!*			CASE ALLTRIM(p_tabla) == "vinculocomp"

*!*	*!*			OTHERWISE
*!*	*!*				MESSAGEBOX("El comprobante que quiere anular, no tiene reglas de anulación definidas [FUNCION: puedeAnular]",0+16+256,"Validación de anulación")
*!*	*!*				v_retorno = .F.
*!*	*!*		ENDCASE
*!*	*!*		
*!*		
*!*		
*!*		
*!*		
*!*		RETURN v_retorno

*!*	ENDFUNC 




*!*	FUNCTION puedeEliminar
*!*	PARAMETERS p_tabla, p_campo, p_idregistro,p_tipoInd
*!*	*#/----------------------------------------
*!*	* Valida si se puede eliminar el comprobante pasado como parámetro
*!*	* Parametros : p_tabla	= Tabla del comprobante a validar
*!*	*              p_campo	= Nombre del campo del comprobante a validar
*!*	*			   p_idregistro = ID del registro del comprobante a validar
*!*	*			   p_tipoind = Tipo de dato del registro
*!*	*RETURN: True si se puede anular, False en otro caso

*!*	*#/----------------------------------------

*!*		v_retorno = .F.
*!*		
*!*		*** Estados: 'ACTIVO', 'ANULADO', 'PENDIENTE AUTORIZACION', 'AUTORIZADO', 'RECHAZADO', 'ERROR'
*!*		
*!*		IF TYPE('p_tipoInd') == 'L'
*!*			p_tipoInd = 'N'
*!*		ENDIF 
*!*		
*!*		IF p_tipoInd == 'C' OR p_tipoInd == 'N'
*!*		ELSE 
*!*			RETURN .F.
*!*		ENDIF 
*!*		
*!*		
*!*		
*!*			
*!*		************************************************************************************************
*!*		** Para la eliminación doy priodidad a como se venia eliminando, DEPENDIENDO del ESTADO
*!*		** Si según el estado se puede eliminar -> se retorna TRUE sino FALSE. 
*!*		** Si el estado indica que no se puede eliminar -> se usa la variable '_SYSVALANULAR' y la tabla 'validaanular' 
*!*		************************************************************************************************
*!*			
*!*			peestadosObjc		= CREATEOBJECT('estadosclass')
*!*				
*!*			v_estadoAnulado 	= peestadosObjc.getIdestado("ANULADO")
*!*			v_estadoRechazado 	= peestadosObjc.getIdestado("RECHAZADO")
*!*			v_estadoError 		= peestadosObjc.getIdestado("ERROR")
*!*			v_estadoPendiente 	= peestadosObjc.getIdestado("PENDIENTE AUTORIZACION")
*!*			v_estadoActivo   	= peestadosObjc.getIdestado("ACTIVO")
*!*			v_estadoAutorizado	= peestadosObjc.getIdestado("AUTORIZADO")	

*!*			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
*!*			sqlmatriz(1)= "SELECT id as idcomp, fechaest as fecha, idestador "
*!*			sqlmatriz(2)= " FROM ultimoestado "
*!*			sqlmatriz(3)= " where tabla = '"+ALLTRIM(v_aetabla)+"' and campo = '"+ALLTRIM(v_aenomindice)+"' and (idestador = "+ALLTRIM(STR(v_estadoPendiente))+" or idestador = "+ALLTRIM(STR(v_estadoAnulado ))+" or idestador = "+ALLTRIM(STR(v_estadoRechazado)) +") and id = '"+ ALLTRIM(STR(p_idregistro))+"'"

*!*			verror=sqlrun(vconeccionFN,"ComAnuRec_sql")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error al Buscar estado del comprobante",0+48+0,"Anular/Eliminar comprobates")
*!*			    RETURN .F.
*!*			ENDIF	

*!*			v_fechaAnulado = ""
*!*			 SELECT ComAnuRec_sql
*!*			 GO top
*!*			 
*!*			 IF NOT EOF()
*!*			 	v_estador = ComAnuRec_sql.idestador
*!*			 	DO CASE
*!*				 	CASE v_estador = v_estadoAnulado
*!*			 			MESSAGEBOX("El comprobante ya esta Anulado.",0+48+0,"Anulación de Comprobante")
*!*			 			v_eliminarComp = .F.
*!*			 		CASE v_estador = v_estadoRechazado
*!*						v_eliminarComp = .T.
*!*			 		CASE v_estador = v_estadoPendiente
*!*						v_eliminarComp = .T.
*!*				 	OTHERWISE
*!*						v_eliminarComp = .F.
*!*			 	ENDCASE
*!*			 
*!*			 ELSE
*!*			 	v_eliminarComp = .F.
*!*			 ENDIF 
*!*		
*!*		
*!*		IF TYPE('_SYSVALANULAR') = 'N' AND _SYSVALANULAR = 1
*!*			IF v_eliminarComp = .T.
*!*				RETURN .T.
*!*			ENDIF 
*!*		ELSE
*!*			RETURN v_eliminarComp 
*!*		ENDIF 
*!*		

*!*		
*!*		vconeccionFN = abreycierracon(0,_SYSSCHEMA)	
*!*		
*!*		sqlmatriz(1)=" select * "
*!*		sqlmatriz(2)=" from "+ALLTRIM(p_tabla)
*!*		sqlmatriz(3)=" where "+ALLTRIM(p_campo)+IIF(p_tipoInd = 'N', "="+ALLTRIM(STR(p_idregistro)),"="+ALLTRIM(p_idregistro))
*!*		
*!*		verror=sqlrun(vconeccionFN,"comproAnula_sql")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del comprobante a ANULAR ",0+48+0,"Error")
*!*		     =abreycierracon(vconeccionFN,"")
*!*		    RETURN .F.
*!*		ENDIF

*!*		
*!*		SELECT comproAnula_sql
*!*		GO top
*!*		
*!*		IF NOT EOF()
*!*			v_idcomproba = comproAnula_sql.idcomproba
*!*			
*!*			
*!*			sqlmatriz(1)=" SELECT * FROM validaanular "
*!*			sqlmatriz(2)=" where idcompa = "+ALLTRIM(STR(v_idcomproba))
*!*			sqlmatriz(3)=" order by idcompb desc"
*!*							
*!*			verror=sqlrun(vconeccionFN,"validaeliminar_sql")
*!*		
*!*			
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de parametros de anulación ",0+48+0,"Error")
*!*			     =abreycierracon(vconeccionFN,"")
*!*			    RETURN .F.
*!*			ENDIF
*!*			
*!*			
*!*			SELECT validaeliminar_sql
*!*			GO TOP 
*!*			IF NOT EOF()
*!*				v_retorno = .F.
*!*				
*!*				v_idcomprobab = validaeliminar_sql.idcompb
*!*				
*!*				
*!*				IF v_idcomprobab == 0
*!*					v_retorno = IIF(validaeliminar_sql.noelimina = 1,.F.,.T.)
*!*					
*!*				ELSE
*!*					** Obtengo los asociados para ver si puedo eliminar
*!*					
*!*					
*!*						v_tablaret = GetLinkCompro(v_idcomproba , p_idregistro,vconeccionFN)
*!*				
*!*						v_compasociados = ""
*!*				
*!*						SELECT &v_tablaret
*!*						GO TOP 
*!*						IF NOT EOF()
*!*							DO WHILE NOT EOF()
*!*							
*!*								v_idcompa = &v_tablaret..idcomproa
*!*								v_idcompb = &v_tablaret..idcomprob
*!*											
*!*											
*!*								IF v_idcomproba == v_idcompa && IDCOMPA es igual al comprobante que quiero eliminar -> busco el idcompb
*!*								
*!*									IF v_idcomprobab == v_idcompb 
*!*										v_retorno = IIF(validaeliminar_sql.noelimina = 1,.F.,.T.)								
*!*									ENDIF 
*!*								ELSE
*!*									IF v_idcomproba == v_idcompb && IDCOMPB es igual al comprobante que quiero anular -> busco el idcompa
*!*									
*!*										IF v_idcomprobab == v_idcompa 
*!*											v_retorno = IIF(validaeliminar_sql.noanula = 1,.F.,.T.)
*!*										ENDIF 

*!*									ENDIF 
*!*								
*!*								ENDIF 
*!*								
*!*									IF v_retorno == .F.
*!*										RETURN v_retorno
*!*									ENDIF 

*!*								SELECT &v_tablaret
*!*								SKIP 1
*!*							ENDDO
*!*						ELSE
*!*							*** No tiene comprobantes asociados podria dejar eliminar
*!*							
*!*							v_retorno = .T.
*!*						ENDIF 

*!*				ENDIF 
*!*				
*!*				
*!*			ELSE

*!*				MESSAGEBOX("No se puede determinar si el comprobante se puede Eliminar",0+16+256,"Eliminar comprobante")
*!*				
*!*				RETURN .F.
*!*			ENDIF 
*!*			
*!*			
*!*			
*!*		else
*!*			RETURN .F.
*!*		
*!*		ENDIF 

*!*		
*!*		
*!*		RETURN v_retorno

*!*	ENDFUNC 