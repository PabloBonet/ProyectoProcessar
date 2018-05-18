*****************************************************************
*																*
* Realiza una llamada y devuelve el manajador a la conexi�n		*
*																*
*****************************************************************
PROCEDURE LlamarCFR
	LPARAMETERS cConexion

	*** Declarac�n de las funciones del API
	DECLARE Integer RasDial ;
			IN RASAPI32.DLL ;
			Integer   RasDialExtensions, ;
			Integer   Phonebook, ;
			String    @ RasDialParams, ;
			Integer   NotifierType, ;
			Integer   Notifier, ;
			Integer   @ hRasConn

	DECLARE Integer RasHangUp ;
			IN RASAPI32.DLL ;
			Integer   hRasConn

	DECLARE Integer RasGetEntryDialParams ;
			IN RASAPI32.DLL ;
			String    @ PhoneDirectory, ;
			String    @ RasDialParams, ;
			Integer   @ IsPassword

	DECLARE Integer RasGetErrorString ;
			IN RASAPI32.DLL ;
			Integer   ErrorValue, ;
			String    @ MessageBuffer, ;
			Integer   BufferLen

	LOCAL cPhonebook, cRasDialParams, nResult
	LOCAL nRasConn
	*** Eliminar Blancos en el Par�metro pasado
	cConexion = ALLTRIM(cConexion)

	*** Preparar la Estructura para los parametros de conexi�n
	cRasDialParams = WordToc(1052) + cConexion + REPLICATE(CHR(0),1045-LEN(cConexion))
	cPhonebook = CHR(0)
	nPasswords = 0

	*** Obtener los parametros de coonexi�n
	nResult = RasGetEntryDialParams(@cPhonebook, @cRasDialParams,@nPasswords)

	*** Preparar Variable para el entorno del manejador
	nRasConn = 0

	*** Realizar la Conexi�n
	nResult = RasDial( 0, 0, @cRasDialParams, 0, 0, @nRasConn )

	*** Comprobar si hubo error y mostrar mensajes si los hubo
	IF nResult # 0
		PRIVATE cMensaje
		cMensaje=space(256)
		IF RasGetErrorString(nResult, @cMensaje,LEN(cMensaje))#0
			messagebox("Error NO DETERMINADO en Acceso Telef�nico a Redes. ("+LTRIM(STR(nResult))+")",0+16+0,"Error de Conexi�n")
		ELSE
			Messagebox("Acceso Telef�nico a Redes: ("+LTRIM(STR(nResult))+") "+LTRIM(cMensaje),0+16+0,"Error de Conexi�n")
		ENDIF
		*** Colgar por si qued� inestable la conexi�n
		CortarCFR(nRasConn)
		*RasHangUp(nRasConn)
		*** Retorno con Error -2
		RETURN -2
	ENDIF

	*** Retorno del manejador de la conexi�n
	RETURN nRasConn

ENDPROC


*** WORDTOC
*** Combierte un numero en un Buffer
PROCEDURE WORDTOC
LPARAMETER nNumber
RETURN  CHR(BITAND(255,nNumber))+CHR(BITAND(65280,nNumber)%255)+;
		CHR(BITAND(16711680,nNumber)%255)+CHR(BITAND(4278190080,nNumber)%255)
ENDPROC


*** CTOWORD
*** Combierte un buffer en un numero
PROCEDURE CTOWORD
LPARAMETER cBuffer
RETURN  ASC(SUBSTR(cBuffer,1,1))+ASC(SUBSTR(cBuffer,2,1))*256+ASC(SUBSTR(cBuffer,3,1))*65536 + ;
		ASC(SUBSTR(cBuffer,4,1))*16777216
ENDPROC


*****************************************************************
*																*
* Cuelga una conexi�n realizada y de la dispongamos un manajador*
*																*
*****************************************************************
PROCEDURE CortarCFR
LPARAMETER nRasConn
*** Declaraci�n de las funciones del API
	DECLARE Integer RasHangUp ;
			IN RASAPI32.DLL ;
			Integer hRasConn

	DECLARE Integer Sleep ;
			IN Win32API ;
			Integer Milliseconds

	LOCAL nResult

	*** Realizar el Cierre de la L�nea
	nResult = RasHangUp(nRasConn)

	*** Realizar un pausa de 5 segundos para asegurar el colgado
	=Sleep(5000)

	RETURN nResult
ENDPROC


*****************************************************************
*																*
* Construye una Matriz con todas las conexiones RAS abiertas    *
*																*
*****************************************************************
PROCEDURE HayConexion
LPARAMETER cArrayReturn

	*** Declaracion de las funciones del API
	DECLARE Integer RasEnumConnections ;
			IN RASAPI32.DLL ;
			String  @ RasConnectionsBuffer, ;
			Integer @ dwSize, ;
			Integer @ nCount

	DECLARE Integer RasGetErrorString ;
			IN RASAPI32.DLL ;
			Integer   ErrorValue, ;
			String    @ MessageBuffer, ;
			Integer   BufferLen

	*** Creaci�n de una estructura tipo RASCONN
	cConexion = wordtoc(412)+replicate(chr(0),408)

	*** creaci�n de una matriz con esa estructura
	cConexiones = replicate(cConexion,16)

	*** Variable con el tama�o de la matriz
	nSize = LEN(cConexiones)

	*** Variable en la que se retorna el n�mero de entradas encontradas
	nCount = 0

	*** Llamada a la funci�n para obtener la informaci�n
	nResult = RasEnumConnections(@cConexiones,@nSize,@ncount)

	*** Si Existe alguna conexi�n abierta
	IF nCount > 0
		***Dimensi�n de la matriz como p�blica
		PUBLIC ARRAY &cArrayReturn.[nCount,4]

		*** Extracci�n de los datos desde la matriz de estructura
		FOR nPos=0 to ncount -1
			*** Obtener una estructura
			cConexion = SUBSTR(cConexiones,(nPos*412)+1,412)
			*** Handle
			&cArrayReturn.[nPos+1,1] = ctoword(SUBSTR(cConexion,5,4))
			*** Nombre
			&cArrayReturn.[nPos+1,2] = strtran(SUBSTR(cConexion,9,257),chr(0))
			*** Tipo
			&cArrayReturn.[nPos+1,3] = strtran(SUBSTR(cConexion,266,17),chr(0))
			*** Device
			&cArrayReturn.[nPos+1,4] = strtran(SUBSTR(cConexion,283,129),chr(0))
		NEXT
	ENDIF

	*** Retorno del N�mero de elementos que se han encontrado
	RETURN nCount

ENDPROC
