********************************************************************
********************************************************************

FUNCTION ABREYCIERRACON
PARAMETERS co,conex
* Abre y Cierra conexiones con base de datos
* Recibe como parametros el nombre de la base de datos 
* Si lo que se desea es cerrar la conexion, recibe como parametro
* "co" = al numero de la conexión y "conex" = ""
conectar = 0
IF !(ALLTRIM(conex) == "") then
	ccDataBaseSQL = conex

		vc_mysl= ""
		
		vc_mysl = LOWER(ALLTRIM(ccDataBaseSQL))
		VARCONMYSQL = ALLTRIM(vc_mysl)+'_cmysql'
		******************************************************************
		IF TYPE(VARCONMYSQL) = "U" THEN 
			PUBLIC &VARCONMYSQL
			conectar = conMySQL(ccDataBaseSQL) && realiza la conexion con la base de datos por unica vez
			EJE = VARCONMYSQL+" = conectar "
			&EJE
		ELSE
			conectar = conMySQL(ccDataBaseSQL) &&me vuelvo a conectar porque puede ser otra base de datos (ale)
			EJE = "conectar = "+VARCONMYSQL
			&EJE				
		ENDIF
		*seteo las variables de entorno para la conexion
		=MySQLVarSession(conectar)

	************************************************************************************************************************** HASTA AQUI ***
	*conectar = conMySQL(ccDataBaseSQL)
	******************************************************************************************************************************************
	
	IF conectar < 0 then
		=MESSAGEBOX("Error en apertura de la conexion con la base datos... ( "+ALLTRIM(conex)+" )",16,"Error Fatal")
		ON ERROR errores= .f.
		QUIT 
	ENDIF
ELSE
	*verfico si es una conexion a visual foxpro cierro la conexion desde aqui (en mysql se encarga de abrir y cerrar ConMysql)
	**********************************
	conectar = 0
ENDIF
RETURN conectar 

********************************************************************
FUNCTION LimpiaMatriz
* Blanquea la matriz SQLMATRIZ que se usa para armar centencias SQL
	FOR I = 1 TO 20
		SQLMATRIZ(I)=""
	ENDFOR 
RETURN


********************************************************************
********************************************************************
FUNCTION Sqlrun
* Ejecuta la sentencia SQL ingresada en la matriz SQLMATRIZ 
* recibe como parametro en "co" la conexion sobre la cual ejecutar la SQL
* y en "pcursor" el nombre del cursor en el cual se devuelve la consulta
* retorna falso si no se pudo ejecutar la consulta y limpia la matriz SQL siempre
    PARAMETERS co,pcursor
    LOCAL vrreturn
    local r
	
	* Esta rutina pone en minuscula los caracteres de sqlmatriz(i), 
	* salvo que el caractere se encuentre en una cadena encerrada en ''
	V_FLAG     = 1 && SI VALE 0 LA CADENA ESTÁ ABIERTA - SI VALE 1 LA CADENA CERRADA
	
	FOR I = 1 TO 20 STEP 1
		V_ORIGINAL = SQLMATRIZ(I)
		V_NUEVOSTR = ''
		V_TAMAÑO   = LEN(SQLMATRIZ(I)) 
*		V_FLAG     = 1 && SI VALE 0 LA CADENA ESTÁ ABIERTA - SI VALE 1 LA CADENA CERRADA
		* Proceso el string de sqlmatriz(i)
		FOR J=1 TO V_TAMAÑO STEP 1
			v_char = SUBSTR(v_original,j,1)
			IF v_char = "'" THEN 
				IF v_flag = 0 THEN 
					v_flag = 1
				ELSE 
					v_flag = 0
				ENDIF 
			ELSE
				IF v_flag = 0 THEN
					* lo dejo como esta
				ELSE 
					v_char = LOWER(v_char)
				ENDIF 
			ENDIF 
			V_NUEVOSTR = V_NUEVOSTR + v_char
		ENDFOR 
		
		SQLMATRIZ(I) = V_NUEVOSTR
	ENDFOR     
	LOCAL laError, lcMsg, ln
	DIMENSION laError[1]   
    
	r=SQLEXEC(co,SQLMATRIZ(1)+SQLMATRIZ(2)+SQLMATRIZ(3)+SQLMATRIZ(4)+SQLMATRIZ(5)+SQLMATRIZ(6)+SQLMATRIZ(7)+SQLMATRIZ(8)+SQLMATRIZ(9)+SQLMATRIZ(10)+SQLMATRIZ(11)+SQLMATRIZ(12)+SQLMATRIZ(13)+SQLMATRIZ(14)+SQLMATRIZ(15)+SQLMATRIZ(16)+SQLMATRIZ(17)+SQLMATRIZ(18)+SQLMATRIZ(19)+SQLMATRIZ(20),pcursor)
	IF r < 0
	  *MANEJO DE ERRORES * ALEJANDRO
	  MESSAGEBOX("HA OCURRIDO UN ERROR AL EJECUTAR LA SIGUIENTE SENTENCIA:"+CHR(13)+SQLMATRIZ(1)+SQLMATRIZ(2)+SQLMATRIZ(3)+SQLMATRIZ(4)+SQLMATRIZ(5)+SQLMATRIZ(6)+SQLMATRIZ(7)+SQLMATRIZ(8)+SQLMATRIZ(9)+SQLMATRIZ(10)+SQLMATRIZ(11)+SQLMATRIZ(12)+SQLMATRIZ(13)+SQLMATRIZ(14)+SQLMATRIZ(15)+SQLMATRIZ(16)+SQLMATRIZ(17)+SQLMATRIZ(18)+SQLMATRIZ(19)+SQLMATRIZ(20),0+64,'SQLRUN')
	  IF AERROR(laError) > 0
	    *-- Ocurrio un error
	    * DISPLAY MEMORY LIKE laError
	    lcMsg = ""
	    FOR ln = 1 TO ALEN(laError,2)
	      lcMsg = lcMsg + TRANSFORM(laError(1,ln)) + CHR(13)
	    ENDFOR
	    MESSAGEBOX(lcMsg, 64, "SQLRUN (ERROR)")
	  ENDIF
	  *FIN INFORME DE ERROR OCURRIDO	
		vrreturn=.f.
    ELSE
    	vrreturn=.t.
    ENDIF 
	LimpiaMatriz()	
RETURN vrreturn


********************************************************************
********************************************************************
FUNCTION SqlIniciarTrans
PARAMETERS co
* Inicia las transacciones en la conexion especificada en "co"
local varreturn	
local r
on error
r = sqlexec(co,'START TRANSACTION')					
if r<0 then
	varreturn=.f.
	SQLFlagErrorTrans=-1
else
	varreturn= .t.
	SQLFlagErrorTrans=0
endif	
return varreturn


********************************************************************
********************************************************************
FUNCTION SqlCerrarTrans
parameters co,paramCommitRollback &&0:commit, 1:rollback
*cierra las transacciones iniciadas en la conexion "co"
local varreturn	
local r
r=0 &&para que si no ejecuta nungun cierre devuelva un estado ok
if paramCommitRollback=0
	r = sqlexec(co,'COMMIT')
else
	r = sqlexec(co,'ROLLBACK')
ENDIF

if r<0 then
	varreturn=.f.
else
	varreturn= .t.
endif
return varreturn


*******************************************************************************
*******************************************************************************
FUNCTION ConMySQL
PARAMETERS pbase
&&	pbase2 = LOWER(ALLTRIM(pbase)+ALLTRIM(MYSQL_PRU))
	pbase2 = LOWER(ALLTRIM(pbase))
******************************************************************

	lnHandle = 0
	IF !EMPTY(pbase2) THEN 
		SQLDISCONNECT(lnHandle)
		lcServer=ALLTRIM(_sysmysql_server)
		lcDatabase=ALLTRIM(pbase2)
		lcUser=ALLTRIM(_sysmysql_user)
		lcPassword=ALLTRIM(_sysmysql_pass)
		lcDriver=ALLTRIM(_SYSDRVMYSQL)
		lcPort=ALLTRIM(_sysmysql_port)
		lcStringConn="Driver="+lcDriver+";Port="+lcPort+;
		";Server="+lcServer+;
		";Database="+lcDatabase+;
		";Uid="+lcUser+;
		";Pwd="+lcPassWord
		lnHandle=SQLSTRINGCONNECT(lcStringConn)
				
	ENDIF 
	
	IF lnHandle > 0
	ELSE
*		=AERROR(laError)
*		MESSAGEBOX("Error de conexión"+CHR(13)+;
*		"Descripcion:"+laError[2])
	ENDIF
	RETURN lnHandle
ENDFUNC 


FUNCTION configschema (tcId)
	*LEER VARIABLES DE CONFIG. DE ACCESO A ADMINDB
*!*		PUNTERO = FOPEN("CONMYSQL.CFG",0)
*!*		IF PUNTERO > 0 THEN
*!*			DO WHILE !FEOF(PUNTERO)
*!*				EJE = ALLTRIM(FGETS(PUNTERO))
*!*				IF !((ALLTRIM(EJE) == "") OR (SUBSTR(ALLTRIM(EJE),1,1)=="[")) THEN
*!*					&EJE
*!*				ENDIF
*!*			ENDDO
*!*			=FCLOSE(PUNTERO)
*!*			SET SAFETY OFF
*!*		ENDIF
	vco=abreycierracon(0,'admindb')
	
	sqlmatriz(1)="select * from esquemas where idesquema = "+ALLTRIM(tcId)
	
	verror=sqlrun(vco,'configesq')
	
	IF !verror THEN 
		MESSAGEBOX('Error al configurar el acceso al esquema. Function sql.prg(configschema)',0+64,'Error')
	ENDIF 
	SELECT configesq
	GO TOP 
	IF EOF() OR ISNULL(configesq.host) THEN  
		MESSAGEBOX('Error al configurar el acceso al esquema. Esquema no encontrado',0+64,'Error')
		RETURN .F.
	ENDIF 
	_sysmysql_server = configesq.host
	_sysmysql_user	 = configesq.usuario
	_sysmysql_pass	 = configesq.password
	_sysmysql_port	 = configesq.port
	_sysmischema	 = configesq.schemma
	USE IN configesq
	RETURN .T.
ENDFUNC 


**********************************************************************************
FUNCTION SentenciaSQL
PARAMETERS p_tabla, p_matriz, p_tipoope, p_condicion, p_conexion

	*quito caracter ' de los valores de la matriz
	elementos = ALEN(&p_matriz,1)
	FOR fila = 1 TO elementos STEP 1
		valormatriz = IIF(substr(ALLTRIM(&p_matriz(fila,2)),1,1)=="'","'"+STRTRAN(substr(ALLTRIM(&p_matriz(fila,2)),2,LEN(ALLTRIM(&p_matriz(fila,2)))-2),"'","´")+"'",ALLTRIM(&p_matriz(fila,2)))	
		&p_matriz(fila,2) = valormatriz
	ENDFOR 

	ErrorSQL = .F.
	DO CASE 
		CASE p_tipoope = 'I' && INSERT 
			limpiamatriz() 
			pos = 1
			elementos = ALEN(&p_matriz,1)
			sqlmatriz(pos) = "INSERT INTO "+ALLTRIM(p_tabla)+" ("
			FOR fila = 1 TO elementos STEP 1
				IF LEN(ALLTRIM(sqlmatriz(pos))) + LEN(ALLTRIM(&p_matriz(fila,1))) < 240 THEN 
					* no hago nada
				ELSE 
					pos  = pos + 1
				ENDIF
				IF fila < elementos THEN 
					sqlmatriz(pos) = sqlmatriz(pos)+ALLTRIM(&p_matriz(fila,1))+","
				ELSE 
					sqlmatriz(pos) = sqlmatriz(pos)+ALLTRIM(&p_matriz(fila,1))
				ENDIF 
		 	ENDFOR 
		 	sqlmatriz(pos) = sqlmatriz(pos)+ ") values ("
		 	
		 	
			FOR fila = 1 TO ALEN(&p_matriz,1) STEP 1
			
				IF LEN(ALLTRIM(sqlmatriz(pos))) + LEN(ALLTRIM(&p_matriz(fila,2))) < 240 THEN 
					* no hago nada
				ELSE 
					pos  = pos + 1
				ENDIF
				IF fila < elementos THEN 
					sqlmatriz(pos) = sqlmatriz(pos)+ALLTRIM(&p_matriz(fila,2))+","
				ELSE 
					sqlmatriz(pos) = sqlmatriz(pos)+ALLTRIM(&p_matriz(fila,2))
				ENDIF 
		 	ENDFOR 
		 	sqlmatriz(pos) = sqlmatriz(pos)+")"
		 	

		 	logSistema(p_tabla, p_matriz, p_tipoope,p_conexion)
		 	
		 	
*!*			 	MESSAGEBOX(sqlmatriz(1)+ ;
*!*			 				sqlmatriz(2)+ ;
*!*			 				sqlmatriz(3)+ ;
*!*			 				sqlmatriz(4)+ ;
*!*			 				sqlmatriz(5)+ ;
*!*			 				sqlmatriz(6)+ ;
*!*			 				sqlmatriz(7)+ ;
*!*			 				sqlmatriz(8)+ ;
*!*			 				sqlmatriz(9)+ ;
*!*			 				sqlmatriz(10)+ ;
*!*			 				sqlmatriz(11)+ ;
*!*			 				sqlmatriz(12)+ ;
*!*			 				sqlmatriz(13)+ ;
*!*			 				sqlmatriz(14)+ ;
*!*			 				sqlmatriz(15)+ ;
*!*			 				sqlmatriz(16))
		 	
		 	ErrorSQL=sqlrun(p_conexion,"nosuo")
		 	
		 	
		CASE p_tipoope = 'U' && UPDATE
			limpiamatriz()
			pos = 1
			elementos = ALEN(&p_matriz,1)
			sqlmatriz(pos) = "UPDATE "+ALLTRIM(p_tabla)+" SET "
			FOR fila = 1 TO elementos STEP 1
				IF LEN(ALLTRIM(sqlmatriz(pos))) + LEN(ALLTRIM(&p_matriz(fila,1))) + 3 + LEN(ALLTRIM(&p_matriz(fila,2))) < 240 THEN 
					* no hago nada
				ELSE 
					pos  = pos + 1
				ENDIF
				IF fila < elementos THEN 
					sqlmatriz(pos) = sqlmatriz(pos)+ALLTRIM(&p_matriz(fila,1))+" = "+ALLTRIM(&p_matriz(fila,2))+","
				ELSE 
					sqlmatriz(pos) = sqlmatriz(pos)+ALLTRIM(&p_matriz(fila,1))+" = "+ALLTRIM(&p_matriz(fila,2))
				ENDIF 
		 	ENDFOR 
		 	IF LEN(ALLTRIM(sqlmatriz(pos))) + LEN(" WHERE "+ALLTRIM(p_condicion)) < 240 THEN
		 		* no hago nada
		 	ELSE  
		 		pos = pos + 1
		 	ENDIF 
		 	sqlmatriz(pos) = sqlmatriz(pos)+" WHERE "+ALLTRIM(p_condicion)
		 	logSistema(p_tabla, p_matriz, p_tipoope,p_conexion)
		 	ErrorSQL=sqlrun(p_conexion,"nosuo")			
			
			
		CASE p_tipoope = 'D' && DELETE
			sqlmatriz(1) = "DELETE FROM "+ALLTRIM(p_tabla)+" WHERE "+ALLTRIM(p_condicion)
			logSistema(p_tabla, p_matriz, p_tipoope,p_conexion)
			ErrorSQL=sqlrun(p_conexion,"nosuo")
			
		
		OTHERWISE 
			MESSAGEBOX("Operación NO Válida",0+48+0,"Sentencia SQL")			
			ErrorSQL = .F.
	ENDCASE 

	RETURN ErrorSQL
ENDFUNC 


** --------------------------------------------------------------
* Graba en la tabla Logsystem de la base de datos todos los 
* movimientos de las tablas seleccionadas para grabar sus log
*----------------------------------------------------------------
FUNCTION logSistema
PARAMETERS p_tablalog, p_matrizlog, p_tipoopelog,p_conexiconlog
	
	IF _SYSSCHEMA = 'admindb' THEN 
		RETURN 
	ENDIF 
	
	ErrorSql = .F.
	
	
	*** Consulto por la tabla de seteo para obtener el campo id y el tipo ***
	v_sentenciaL = "select * from seteolog where tabla = '"+ALLTRIM(p_tablalog)+"' and log = 'S'"
	
	LOCAL laError, lcMsg, ln
	DIMENSION laError[1]


	r=SQLEXEC(p_conexiconlog,v_sentenciaL,"seteoCur")

	IF r < 0
	  MESSAGEBOX("HA OCURRIDO UN ERROR AL EJECUTAR LA SIGUIENTE SENTENCIA:"+CHR(13)+v_sentenciaL,0+64,'SQLRUN')
	  IF AERROR(laError) > 0
	    *-- Ocurrio un error
	    * DISPLAY MEMORY LIKE laError
	    lcMsg = ""
	    FOR ln = 1 TO ALEN(laError,2)
	      lcMsg = lcMsg + TRANSFORM(laError(1,ln)) + CHR(13)
	    ENDFOR
	    MESSAGEBOX(lcMsg, 64, "SQLRUN (ERROR)")
	  ENDIF
	  *FIN INFORME DE ERROR OCURRIDO	
		ErrorSql=.t.
    ELSE
    	SELECT seteoCur
    	GO TOP 
    	IF EOF()
	    	RETURN 
    	ENDIF 
    	v_campo = seteoCur.campo
    	v_tipo	= seteoCur.tipo
    
 		v_elementosm = ALEN(&p_matrizlog,1)
    	

    	FOR fila = 1 TO v_elementosm 
    		v_campoMat = &p_matrizlog(fila,1)
   
    		IF v_campoMat = ALLTRIM(v_campo)
       			v_valor		=  &p_matrizlog(fila,2)
    			fila = v_elementosm
    		ENDIF  
    	ENDFOR 
    	
    	
    	*** Inserto los campos en la tabla logsystem ***
    	
    *	v_idlog = maxnumeroidx('idlog', 'I', 'logsystem',1) 

	*INTEGER
	v_tipocampo = "I"
	V_consulta="UPDATE tablasidx set maxvalori = ( maxvalori + 1 ) WHERE campo = 'idlog' and tabla = 'logsystem' and tipocampo = 'I'"
	
	r=SQLEXEC(p_conexiconlog,V_consulta,"ActuCur")
		IF r < 0
		  MESSAGEBOX("HA OCURRIDO UN ERROR AL EJECUTAR LA SIGUIENTE SENTENCIA:"+CHR(13)+V_consulta,0+64,'SQLRUN')
		  IF AERROR(laError) > 0
		    *-- Ocurrio un error
		    * DISPLAY MEMORY LIKE laError
		    lcMsg = ""
		    FOR ln = 1 TO ALEN(laError,2)
		      lcMsg = lcMsg + TRANSFORM(laError(1,ln)) + CHR(13)
		    ENDFOR
		    MESSAGEBOX(lcMsg, 64, "SQLRUN (ERROR)")
		  ENDIF
		  *FIN INFORME DE ERROR OCURRIDO	
			ErrorSql=.t.
			
		ENDIF 
    	
	
	*** Vuelvo a buscar para corroborar
	
	
	v_consulta="select maxvalori as maxnro FROM tablasidx WHERE campo = 'idlog' and tabla = 'logsystem' and tipocampo = 'I'" 
		
	r=SQLEXEC(p_conexiconlog,V_consulta,"MaxCur")
		IF r < 0
		  MESSAGEBOX("HA OCURRIDO UN ERROR AL EJECUTAR LA SIGUIENTE SENTENCIA:"+CHR(13)+V_consulta,0+64,'SQLRUN')
		  IF AERROR(laError) > 0
		    *-- Ocurrio un error
		    * DISPLAY MEMORY LIKE laError
		    lcMsg = ""
		    FOR ln = 1 TO ALEN(laError,2)
		      lcMsg = lcMsg + TRANSFORM(laError(1,ln)) + CHR(13)
		    ENDFOR
		    MESSAGEBOX(lcMsg, 64, "SQLRUN (ERROR)")
		  ENDIF
		  *FIN INFORME DE ERROR OCURRIDO	
			ErrorSql=.t.
			
		ENDIF 
	
	SELECT maxCur
	v_maximo = IIF(ISNULL(maxCur.maxnro),0,maxCur.maxnro)

	SELECT maxCur
	USE IN maxCur

	v_idlog = v_maximo
	

		    	
    	v_fechalogsys = TTOC(DATETIME(),1)
    	v_usuario	= _SYSUSUARIO
    	v_ip		= _SYSIP
    	v_host		= _SYSHOST
 
    	v_sentencia = "INSERT INTO logsystem values ("+ALLTRIM(STR(v_idlog))+",'"+ALLTRIM(v_fechalogsys)+"','"+ALLTRIM(v_usuario)+"','"+ ;
    	ALLTRIM(p_tabla)+"','"+ALLTRIM(v_campo)+"','"+ALLTRIM(v_tipo)+"','"+ALLTRIM(v_valor)+"','"+ALLTRIM(p_tipoopelog)+"','"+ALLTRIM(v_ip)+"','"+ALLTRIM(v_host)+"'"
	
		*r=SQLEXEC(p_conexicon,v_sentencia+",'"+SQLMATRIZ(1)+SQLMATRIZ(2)+SQLMATRIZ(3)+SQLMATRIZ(4)+SQLMATRIZ(5)+SQLMATRIZ(6)+SQLMATRIZ(7)+SQLMATRIZ(8)+SQLMATRIZ(9)+SQLMATRIZ(10)+SQLMATRIZ(11)+SQLMATRIZ(12)+SQLMATRIZ(13)+SQLMATRIZ(14)+SQLMATRIZ(15)+SQLMATRIZ(16)+SQLMATRIZ(17)+SQLMATRIZ(18)+SQLMATRIZ(19)+SQLMATRIZ(20)+"')","InsertCur")
		r=SQLEXEC(p_conexiconlog,v_sentencia+",'"+STRTRAN(SQLMATRIZ(1)+SQLMATRIZ(2)+SQLMATRIZ(3)+SQLMATRIZ(4)+SQLMATRIZ(5)+SQLMATRIZ(6)+SQLMATRIZ(7)+SQLMATRIZ(8)+SQLMATRIZ(9)+SQLMATRIZ(10)+SQLMATRIZ(11)+SQLMATRIZ(12)+SQLMATRIZ(13)+SQLMATRIZ(14)+SQLMATRIZ(15)+SQLMATRIZ(16)+SQLMATRIZ(17)+SQLMATRIZ(18)+SQLMATRIZ(19)+SQLMATRIZ(20),"'","")+"')","InsertCur")
		IF r < 0
		  MESSAGEBOX("HA OCURRIDO UN ERROR AL EJECUTAR LA SIGUIENTE SENTENCIA:"+CHR(13)+v_sentencia,0+64,'SQLRUN')
		  IF AERROR(laError) > 0
		    *-- Ocurrio un error
		    * DISPLAY MEMORY LIKE laError
		    lcMsg = ""
		    FOR ln = 1 TO ALEN(laError,2)
		      lcMsg = lcMsg + TRANSFORM(laError(1,ln)) + CHR(13)
		    ENDFOR
		    MESSAGEBOX(lcMsg, 64, "SQLRUN (ERROR)")
		  ENDIF
		  *FIN INFORME DE ERROR OCURRIDO	
			ErrorSql=.t.
			
		ENDIF 
    	
 
    ENDIF 
	
	
	RETURN ErrorSql

ENDFUNC 


**-- FUNCION DE SETEO DE VARIALBES DE SESION EN ENTORNO MYSQL
** carga en mysql las variables definidas como publicas y que deben
** enviarse a la base de datos como entorno de sesion de la aplicacion
FUNCTION MySQLVarSession
PARAMETERS pv_conexion 
	v_consulta="select variable FROM varpublicas WHERE variable like '_SQL%' " 
		
	r=SQLEXEC(pv_conexion ,V_consulta,"SetVariables")
	IF r < 0
	  MESSAGEBOX("HA OCURRIDO UN ERROR AL EJECUTAR LA SIGUIENTE SENTENCIA:"+CHR(13)+V_consulta,0+64,'SQLRUN')
	  IF AERROR(laError) > 0
		    *-- Ocurrio un error
		    * DISPLAY MEMORY LIKE laError
	    lcMsg = ""
	    FOR ln = 1 TO ALEN(laError,2)
	      lcMsg = lcMsg + TRANSFORM(laError(1,ln)) + CHR(13)
	    ENDFOR
	    MESSAGEBOX(lcMsg, 64, "SQLRUN (ERROR)")
	  ENDIF
	  *FIN INFORME DE ERROR OCURRIDO	
		ErrorSql=.t.
		RETURN 
	ENDIF 

	SELECT SetVariables
	GO TOP 
	DO WHILE !EOF()
		
		IF !(TYPE(SetVariables.variable)='U') THEN 
			IF TYPE(ALLTRIM(SetVariables.variable))='C' THEN 
				eje =" valorv = "+SetVariables.variable
				&eje
				v_consulta = "set @"+ALLTRIM(LOWER(setVariables.variable))+":='"+valorv+"'"
			ELSE
				eje = "valorv = ALLTRIM(STR("+ALLTRIM(SetVariables.variable)+"))"
				&eje		
				v_consulta = "set @"+ALLTRIM(LOWER(setVariables.variable))+":="+valorv
			ENDIF 
			r=SQLEXEC(pv_conexion ,V_consulta,"seteo")
	
		ELSE 
		ENDIF 		
		SELECT SetVariables
		SKIP 
	ENDDO 	
	USE IN SetVariables 

ENDFUNC 