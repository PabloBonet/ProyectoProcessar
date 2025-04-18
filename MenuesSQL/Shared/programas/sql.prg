********************************************************************
********************************************************************

FUNCTION ABREYCIERRACON
PARAMETERS co,conex
* Abre y Cierra conexiones con base de datos
* Recibe como paramtros el nombre de la base de datos 
* Si lo que se desea es cerrar la conexion, recibe como parametro
* "co" = al numero de la conexi�n y "conex" = ""
conectar = 0
IF !(ALLTRIM(conex) == "") then
	ccDataBaseSQL = conex

	**********************************************************************
	*SI MIDRVMYSQL NO ESTA DEFINIDO ME CONECTO A LA BASE DE VISUAL FOXPRO
	*ALE 09/07/2012
	**********************************************************************
	LOCAL lcPlataforma &&=1 Visualfoxpro =2 Mysql

	IF TYPE("MIDRVMYSQL") = "U" THEN 
		*VARIABLE NO DEFINIDA
		lcPlataforma = 1	  
	ELSE
		IF EMPTY(MIDRVMYSQL) THEN 
			lcPlataforma = 1
		ELSE
			lcPlataforma = 2
		ENDIF 
	ENDIF 

	IF lcPlataforma = 1 THEN 
	&& bases en Database Visual FoxPro
		conectar = -1
		contador = 1
		ccDataBaseSQL = ALLTRIM(MISERVIDOR)+"\"+ALLTRIM(ccDataBaseSQL)+".dbc"
		DO WHILE contador < 30 AND conectar < 0
			STORE SQLSTRINGCONNECT("DSN=Visual FoxPro Database;UID=;PWD=;SourceDB="+ ;
		                 ALLTRIM(ccDataBaseSQL)) TO conectar
		    contador = contador + 1
		    IF conectar < 0 THEN 
		    	WAIT '' TIMEOUT 1
		    ENDIF 
		ENDDO 
	ELSE 
		*Bases de datos en Mysql
		**AQUI AGREGUE LA LOGICA PARA QUE EN EL CASO DE QUE SEA UNA CONEXION A MYSQL SOLO ABRA UNA VEZ LA CONEXION *********** DESDE AQUI ****
		** EXTRAIGO EL NOMBRE DE LA BASE DEL STRING PASADO COMO CONEXION CON FECHA 25/08/2007
		*ale- anule esto porque no me podia conectar a distintas bases de datos
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
	ENDIF  
	************************************************************************************************************************** HASTA AQUI ***
	*conectar = conMySQL(ccDataBaseSQL)
	
	IF conectar < 0 then
		=MESSAGEBOX("Error en apertura de la conexion con la base datos... ( "+ALLTRIM(conex)+" )",16,"Error Fatal")
		CLOSE ALL
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
	r=SQLEXEC(co,SQLMATRIZ(1)+SQLMATRIZ(2)+SQLMATRIZ(3)+SQLMATRIZ(4)+SQLMATRIZ(5)+SQLMATRIZ(6)+SQLMATRIZ(7)+SQLMATRIZ(8)+SQLMATRIZ(9)+SQLMATRIZ(10)+SQLMATRIZ(11)+SQLMATRIZ(12)+SQLMATRIZ(13)+SQLMATRIZ(14)+SQLMATRIZ(15)+SQLMATRIZ(16)+SQLMATRIZ(17)+SQLMATRIZ(18)+SQLMATRIZ(19)+SQLMATRIZ(20),pcursor)
	IF r < 0
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
	pbase2 = LOWER(ALLTRIM(pbase)+ALLTRIM(MYSQL_PRU))
******************************************************************

	lnHandle = 0
	IF !EMPTY(pbase2) THEN 
		SQLDISCONNECT(lnHandle)
		lcServer=ALLTRIM(mysql_server)
		lcDatabase=ALLTRIM(pbase2)
		lcUser=ALLTRIM(mysql_user)
		lcPassword=ALLTRIM(mysql_pass)
		lcDriver=ALLTRIM(MIDRVMYSQL)
		lcPort=ALLTRIM(mysql_port)
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
*		MESSAGEBOX("Error de conexi�n"+CHR(13)+;
*		"Descripcion:"+laError[2])
	ENDIF
	RETURN lnHandle
ENDFUNC 
