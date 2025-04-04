FUNCTION backupmysql(xControl, xCamino)
	*xControl= handle de conexion a la base de datos
	*xCamino= path donde se va a guardar la copia de seguridad
	
	*RECORRO TODA la BD Y COPIO TODAS LAS TABLAS A UN ARCHIVO DE TEXTO
	IF SQLEXEC(xControl,"show tables","tablas")>=0 THEN 
	*6
		*xCamino = "C:\TMP\" &&PATH DONDE SE GUARDA LA COPIA DE RESPALDO
		xList   = FCREATE(xCamino+"listablas.sql")
		SELECT tablas
		GO TOP 
		L=0		
		DO WHILE !EOF()
		*5
			L=L + 1
			xCampo  = FIELD(1) &&NOMBRE DEL PRIMER CAMPO DE LA TABLA SELECCIONADA
			xDato   = &xCampo
			xSql    = "select * from "+ALLTRIM(xDato)
			xDato   = ALLTRIM(xDato)
			xApunta = FCREATE(xCamino+xDato+".sql")

			?'Copiando '+xDato+" - "+STR(l)+" de "+STR(RECCOUNT("tablas"))
			
			IF SQLEXEC(xControl,xSql,xDato)>=0 THEN 
			*4
				SELECT  (xDato)
				GO TOP
				*3
				DO WHILE  !EOF()
					*2
					FOR c=1 TO FCOUNT()
						xContenido = field(c)
					    xContenido = &xContenido
					    *1
					    DO CASE 
					      	CASE  TYPE('xContenido')='C' or TYPE('xContenido')='M'
						       xContenido = '>'+xFormato(xContenido)+'>'
						       IF ISNULL(xContenido) THEN 
						        	xContenido = '>'+SPACE(10)+'>'
						       ENDIF 
							       
					    	CASE  TYPE('xContenido')='N' or TYPE('xContenido')='Y'
					    		xContenido = '>'+STR(xContenido,14,4)+'>'
					    		IF  ISNULL(xContenido) THEN 
							        xContenido = '>'+'0.0000'+'>'
							    ENDIF 
							       
						    CASE  TYPE('xContenido')='D'
						       xContenido = '>'+DTOC(xContenido)+'>'
						       IF ISNULL(xContenido) THEN 
							        xContenido = '>'+'01/0/1900'+'>'
						       ENDIF 
							       
						   CASE  TYPE('xContenido')='L'
						       IF xContenido THEN 
				     		   		xContenido = '>'+'.T.'+'>'
						       ELSE 
						        	xContenido = '>'+'.F.'+'>'
						       ENDIF 
						       
						   CASE  TYPE('xContenido')='T'
						      xContenido = '>'+TTOC(xContenido)+'>'
						      IF ISNULL(xContenido) THEN 
						        xContenido = '>'+space(10)+'>'
						      ENDIF
							       
						  CASE  TYPE('xContenido')='U'
						      xContenido = '>'+'TIPO DE DATO INDEFINIDO'+'>'
						ENDCASE
						*1 
						=FWRITE(xApunta,xContenido+'|')
					ENDFOR 
					*2
				 	=FPUTS(xApunta," ")
				    SELECT  (xDato)
			    	SKIP 
				ENDDO 
				*3
				=FCLOSE(xApunta)
				*escribo el nombre dela tabla en list para luego zipear los txt
				=FWRITE(xList,xDato+'.sql')
				=FPUTS(xList," ")				
			ENDIF 
			*4
			SELECT tablas
			SKIP 
		ENDDO 
		*5	
		=FCLOSE(xList) &&cierro txt con el listado de los txt. a zipear
	ENDIF
	*6
	*Generar archivo zip con todos los txt de backup, luego borrar todos los txt.
	LOCAL lcDir, lcMacro, lcData
	
	*Nombre del archivo zip nombreesquema.FAAAMMDDHHHMMSS
	lcData = ALLTRIM(esquemas.schemma)+'F'+DTOS(DATE())+'H'+STRTRAN(TIME(),':','')
	lcDir = SYS(2003)
		
	?'Generando *.bat aguarde unos instantes...'
	
	*creo un archivo bat con los comandos para comprimir y eliminar los txt.
	xApunta = FCREATE(xCamino+"backup.bat")
	xContenido = "cd "+ALLTRIM(xCamino)	
	=FWRITE(xApunta,xContenido)
	=FPUTS(xApunta," ")
	
	xContenido = "copy "+ALLTRIM(MISERVIDOR)+"\pkzip25.exe "+ALLTRIM(xCamino)
	=FWRITE(xApunta,xContenido)
	=FPUTS(xApunta," ")
	
	?'Compactando copia aguarde unos instantes...'
	
	xContenido = xCamino+"pkzip25 -add "+ALLTRIM(lcData)+".zip @listablas.sql"
	=FWRITE(xApunta,xContenido)
	=FPUTS(xApunta," ")
		
	xContenido =  "del "+xCamino+"*.sql" 
	=FWRITE(xApunta,xContenido)
	=FPUTS(xApunta," ")
	
	xContenido =  "del "+xCamino+"pkzip25.exe" 
	=FWRITE(xApunta,xContenido)	
	=FPUTS(xApunta," ")
	=FCLOSE(xApunta)
	?'Comprimiendo datos aguarde unos instantes...'
	lcMacro = "RUN /N2 "+xCamino+"backup.bat"
	&lcMacro	
    *me queda eliminar el bat 
	RETURN 
ENDFUNC 

FUNCTION restorebackupmysql(xControl, xCamino)
	*xControl = Handle de conexion
	*xCamino = directorio donde estan las copias de seguridad
	*CARGO del txt a mysql
	xAntes  = SYS(5)+CURDIR() &&Unidad predeterminada + directorio actual
*	xCamino = GETDIR() &&Selecciono directorio donde estan las copias de seguridad
	SET DEFAULT TO (xCamino)
	*xCamino = STRTRAN(xCamino,"\","/")
	xCamino = STRTRAN(xCamino,"\","\\")
	a=ADIR(matriz,"*.sql") &&creo una matriz con todos los txt          
	FOR c=1 TO a
		xTabla = SUBSTR(matriz(c,1),1,ATC(".",matriz(c,1))-1)
		xSql = 'load data local infile "'+xCamino+matriz(c,1)+'" into table '+LOWER(xTabla)+' FIELDS TERMINATED BY "|" ENCLOSED BY ">" LINES TERMINATED BY "\r\n" '
		
		IF SQLEXEC(xControl,xSql)>0
			?xSql
		ELSE 
			*Error 
			MESSAGEBOX(xsql)
			RETURN .F.
		ENDIF 
	ENDFOR 
	SET DEFAULT TO (xAntes) 
ENDFUNC  

FUNCTION  xFormato(xDato)
	xDato=STRTRAN(xDato, CHR(92), '\\') 
	xDato=STRTRAN(xDato, CHR(39), "\'") 
	xDato=STRTRAN(xDato, CHR(34), '\"') 
	RETURN xDato
ENDFUNC 

FUNCTION clonardbmysql(xControl, xCamino, xDB, xDBn)
	*xControl= handle de conexion a la base de datos (de la base de datos original)
	*xDB= Nombre de la base de datos a clonar
	*xDBn= nombre que va a tener la nueva base de datos
	
	*RECORRO TODA laS TABLAS DE LA  BD Y creo el script de creacion de todas la tablas a un txt
	IF SQLEXEC(xControl,"show full tables","tablas1")>=0 THEN 
	
		xApunta = FCREATE(xCamino+xDB+".sql") &&CREO UN nombredatabaseoriginal.TXT CON el script de creacion de  TODOS LAS TABLAS
		
		xSql = "show create database "+xDB
		IF !SQLEXEC(xControl,xSql,"cdatabase")>=0 THEN 
			MESSAGEBOX('Error')
			RETURN .F.
		ENDIF 
		SELECT cdatabase 
		xCampo = FIELD(2)
		xContenido = "cdatabase."+xCampo
	    xContenido = &xContenido
	    xContenido = STRTRAN(xContenido,ALLTRIM(xDB),ALLTRIM(xDBn))
		=FWRITE(xApunta,xContenido+';')
	 	=FPUTS(xApunta," ")
	    
	    xContenido = "use "+xDBn
		=FWRITE(xApunta,xContenido+';')
	 	=FPUTS(xApunta," ")

		SELECT * FROM tablas1 INTO CURSOR tablas ORDER BY Table_type 
**		SELECT * FROM tablas1 INTO CURSOR tablas WHERE Table_type = 'BASE TABLE'
	 	COUNT FOR Table_type = 'VIEW' TO xcantview

**		armo un array para controlar la cantidad de vistas que no puedo generar si da error la creacion por el orden	 	
	 	DIMENSION xSqlArray (xcantview)  
	 	FOR i = 1 TO xcantview
	 		xSqlArray(i) = ""
	 	ENDFOR 
	 	
		SELECT tablas
		GO TOP 
		L=0		
		J=0
		DO WHILE !EOF()
			L=L + 1
			xCampo  = FIELD(1) &&NOMBRE DEL PRIMER CAMPO DE LA TABLA SELECCIONADA
			xDato   = &xCampo
			xSql    = "show create table "+ALLTRIM(xDato)
			xDato   = ALLTRIM(xDato)

			?'Creando '+xDato+" - "+STR(l)+" de "+STR(RECCOUNT("tablas"))
			
			IF SQLEXEC(xControl,xSql,xDato)>=0 THEN 
				SELECT  (xDato)
				GO TOP
				DO WHILE  !EOF()
					xCampo = FIELD(2)
					xContenido = xDato+"."+xCampo
				    xContenido = &xContenido
					=FWRITE(xApunta,xContenido+';')
				 	=FPUTS(xApunta," ")
				    SELECT  (xDato)
			    	SKIP 
				ENDDO
			ENDIF 
			SELECT tablas 
			SKIP 
		ENDDO 
	*	=FCLOSE(xApunta)
	ENDIF
	*xCamino = STRTRAN(xCamino,"\","\\")
	*xCamino = ALLTRIM(xCamino)+ALLTRIM(xDB)+".txt"
	*MESSAGEBOX(xCamino)
	*xApunta = FOPEN(ALLTRIM(xCamino),0)
	LOCAL lnLen, lnAux
	lnAux = 0
	xSql = ""
	FSEEK(xApunta,0,0)
	IF xApunta > 0 THEN
		DO WHILE !FEOF(xApunta) 
			lnAux = lnAux + 1 &&vuelve a cero cada vez que se ejecuta la sentencia
			xSqltmp = ALLTRIM(FGETS(xApunta))
*!*				MESSAGEBOX(xSqltmp)
			lnLen = LEN(xSqltmp)
			IF SUBSTR(xSqltmp,lnLen,1) = ";" THEN 
				*ejecutar la sentencia
				lnAux = 0
				IF lnAux = 1 THEN 
					xSql = xSqltmp
				ELSE 
					xSql = xSql + xSqltmp
				ENDIF 
			ELSE 
				IF lnAux = 1 THEN 
					xSql = xSqltmp
				ELSE 
					xSql = xSql + xSqltmp
				ENDIF 
				LOOP 
			ENDIF 
			
			IF !SQLEXEC(xControl,xSql,'nouso')>=0 THEN 
*!*					MESSAGEBOX('Error al ejecutar '+ALLTRIM(xSql))
				J=J+1
				xSqlArray(J)=ALLTRIM(xSql)
*				RETURN .F.
*!*				ELSE 
				*limpiar sentencia
*!*					xSql = ""
			ENDIF 			
				xSql = ""
		ENDDO
		=FCLOSE(xApunta)
		SET SAFETY OFF
	ELSE 
		*error no se puedo leer el archivo
		RETURN .F.
	ENDIF	
	** ejecuto las sentencias que me dieron error hasta que se ejecuten todas
	M = 1
	DO WHILE M>0 
		M = 0
		FOR k= 1 TO xcantview
			IF !EMPTY(xSqlArray(k)) THEN 
				xSql = ALLTRIM(xSqlArray(k))
				IF !SQLEXEC(xControl,xSql,'nouso')>=0 THEN 
					M=M+1
				ELSE 
					xSqlArray(k)=""
				ENDIF 			
				xSql = ""		
			ENDIF 
		ENDFOR 
	ENDDO 
	
	RETURN .T.
ENDFUNC