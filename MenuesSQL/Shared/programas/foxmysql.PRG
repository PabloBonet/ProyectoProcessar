PARAMETERS CAMINO, BASEDATO,BASEMYSQL, SEP1, SEP2
** RECIBE COMO PARAMETRO EL PATH DE LA BASE DE DATOS
** EL NOMBRE DE LA BASE DE DATOS
** LA SEPARACION PARA EL ESPACIO ENTRE EL NOMBRE DEL CAMPO Y EL TIPO
** LA SEPARACION PARA EL INDICE Y EL TAG
SET SAFETY OFF 
SET CENTURY ON 
SET DATE TO DMY 
SET DEFAULT TO &CAMINO
ARCHI = CAMINO+"\"+ALLTRIM(BASEDATO)+".FOX"
DELETE FILE &ARCHI
ARCHI = CAMINO+"\"+ALLTRIM(BASEDATO)+".MyS"
DELETE FILE &ARCHI

PUBLIC SQLMATRIZ(20)
FOR I = 1 TO 20
	SQLMATRIZ(I)=""
ENDFOR 

PUBLIC lnHandle
lnHandle = 0

basecon = SUBSTR(BASEDATO,1,LEN(BASEDATO)-4)
=coneccion(BASEMYSQL)

***CREA BASE PARA VISUAL FOXPRO
***********************************************
IFOR = 0
*FOR IFOR = 1 TO 2 

	ARCHI = CAMINO+"\TMPTABLAS.DBF"
	IF FILE(ARCHI) THEN
		IF USED("TMPTABLAS") THEN
			SELECT TMPTABLAS
			USE
		ENDIF
		DELETE FILE &CAMINO\TMPTABLAS.DBF
		DELETE FILE &CAMINO\TMPTABLAS.CDX
	ENDIF
	CREATE DBF &CAMINO\TMPTABLAS FREE (NTABLA C(80), N2TABLA C(50))
	
	ARBO = CAMINO+"\"+BASEDATO
	OPEN DATABASE &ARBO
	DISPLAY TABLES TO FILE &CAMINO\LASTABLAS.TXT NOCONSOLE 
	SELECT TMPTABLAS
	APPEND FROM &CAMINO\LASTABLAS.TXT SDF
	SELECT TMPTABLAS
	REPLACE ALL NTABLA WITH ALLTRIM(NTABLA)
	GO 4
	DO WHILE !EOF()
		FOR I = 1 TO 80
			IF SUBSTR(NTABLA,I,1)=" " THEN 
				EXIT
			ENDIF 
		ENDFOR 
		REPLACE N2TABLA WITH SUBSTR(NTABLA,1,I)
		SKIP
	ENDDO
	SELECT tmptablas   
	INDEX ON ALLTRIM(N2TABLA) TAG N2TABLA 
	
	GO top
	SKIP 3
	DO WHILE !EOF()
		ARCHIVO = CAMINO+"\"+ALLTRIM(N2TABLA)
		USE &ARCHIVO IN 0 EXCLUSIVE 
		ARCHIVO = ALLTRIM(N2TABLA)
		SELECT &ARCHIVO
		PACK 
		COPY STRUCTURE EXTENDED TO &CAMINO\ESTRUCTU
		USE &CAMINO\ESTRUCTU IN 0 
		SELECT ESTRUCTU

			=INSERCION()
			
			=INSERTANDO()
		
		SELECT ESTRUCTU
		USE
		SELECT TMPTABLAS
		SKIP
	ENDDO
	CLOSE TABLES ALL 
	DELETE FILE &CAMINO\ESTRUCTU.FPT
	DELETE FILE &CAMINO\ESTRUCTU.DBF
	DELETE FILE &CAMINO\LASTABLAS.TXT
	DELETE FILE &CAMINO\TMPTABLAS.DBF
	DELETE FILE &CAMINO\TMPTABLAS.CDX
	
RETURN 
*ENDFOR 



FUNCTION INSERCION 
&& CREA LA SENTENCIA DE INSERCION Y LLAMA A UN BUCLE QUE CARGA LOS DATOS
* LO HACE CREANDO UN ARCHIVO TEMPORAL COM LA SENTENCIA
		ARVO = "C:\TEMP\FOXMYSQL\"+ALLTRIM(TMPTABLAS.N2TABLA)+".TXT"
		IF FILE(ARVO)  && �Existe el archivo?
			DELETE FILE &ARVO
		ENDIF
		PUNTERO = FCREATE(ARVO)  && Si no, crearlo

		RENGLON1 = "INSERT INTO "+lower(ALLTRIM(TMPTABLAS.N2TABLA))+" ( "
		RENGLON = ""
		RENGLON2 = ""
		SELECT ESTRUCTU
		GO TOP
		DO WHILE !EOF()
			DO CASE
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) = "C"
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +"'+ALLTRIM("+LOWER(ALLTRIM(FIELD_NAME))+")+',"
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) = "N"
					IF ESTRUCTU.FIELD_DEC > 0 THEN 
						RENGLON = UPPER(ALLTRIM(FIELD_NAME))+","
						RENGLON2 = RENGLON2 +"+ALLTRIM(str("+LOWER(ALLTRIM(FIELD_NAME))+",15,4))+,"
					ELSE
						RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
						RENGLON2 = RENGLON2 +"+ALLTRIM(str("+LOWER(ALLTRIM(FIELD_NAME))+",15,4))+,"
					ENDIF 
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) =  "Y"
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +"+ALLTRIM(str("+LOWER(ALLTRIM(FIELD_NAME))+",15,4))+,"
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) =  "D"
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +"'+DTOS("+LOWER(ALLTRIM(FIELD_NAME))+")+',"
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) =  "T"
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +"'+TTOC("+LOWER(ALLTRIM(FIELD_NAME))+")+',"
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) = "L"
*					MESSAGEBOX("CAMPO BOOLEANO: "+TMPTABLAS.N2TABLA+"."+FIELD_NAME)
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
*					RENGLON2 = RENGLON2 +"+"+LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +"'+IIF("+ALLTRIM(FIELD_NAME)+" , 'S' , 'N' )+',"

				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) = "M"
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +"'+ALLTRIM("+LOWER(ALLTRIM(FIELD_NAME))+")+',"
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) = "I"
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +"+alltrim(str("+LOWER(ALLTRIM(FIELD_NAME))+",14))+,"
				CASE ALLTRIM(ESTRUCTU.FIELD_TYPE) = "G"
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +""+LOWER(ALLTRIM(FIELD_NAME))+","
				OTHERWISE 
					RENGLON = RENGLON +LOWER(ALLTRIM(FIELD_NAME))+","
					RENGLON2 = RENGLON2 +""+LOWER(ALLTRIM(FIELD_NAME))+","
			ENDCASE
			SELECT ESTRUCTU
			SKIP
		ENDDO 
		RENGLON3 =") VALUES ( "
		RENGLON4 =")"
		cam = '"'+"',"
		renglon2=STRTRAN(renglon2,"',",cam)


		cam = ",'"+'"'
		renglon2=STRTRAN(renglon2,",'",cam)

		cam = '+","+'
		renglon2=STRTRAN(renglon2,"+,+",cam)

		cam = "',"+'"+'
		renglon2=STRTRAN(renglon2,"',+",cam)
		
		largo = LEN(renglon2)		
		IF SUBSTR(renglon2,largo-1,2)="',"
			renglon2=SUBSTR(renglon2,1,largo-1)+"'"+'"'
		ENDIF 
		largo = LEN(renglon2)		
		IF SUBSTR(renglon2,largo-1,2)="+,"
			renglon2=SUBSTR(renglon2,1,largo-2)
		ENDIF 


		cam = "'+"		
		IF SUBSTR(renglon2,1,2)="'+"
			renglon2='"'+"'"+'"+'+SUBSTR(renglon2,3)
		ELSE
			renglon2=SUBSTR(renglon2,2)	
		ENDIF 
*		renglon2=SUBSTR(renglon2,2)

		cam = '+",'
		renglon2=STRTRAN(renglon2,"+,",cam)

		largo = LEN(renglon2)		
		cmpa="''"+'"'
		IF SUBSTR(renglon2,largo-2,3)=cmpa
			renglon2=SUBSTR(renglon2,1,largo-2)+'"'
		ENDIF 

		largo = LEN(renglon)		
		renglon= SUBSTR(renglon,1,largo-1)




		=FPUTS(PUNTERO, RENGLON1)
		=FPUTS(PUNTERO, RENGLON)		
		=FPUTS(PUNTERO, RENGLON3)
		=FPUTS(PUNTERO, RENGLON2)
		=FPUTS(PUNTERO, RENGLON4)
		
		FCLOSE(PUNTERO)
RETURN 

*************************************************************
**********************************************************+**
************************************************************+

FUNCTION INSERTANDO
** RECORRE UNA TABLA E INSERTA LOS DATOS DE ESTA EN LA TABLA MYSQL
	ARVO = "C:\TEMP\FOXMYSQL\"+ALLTRIM(TMPTABLAS.N2TABLA)+".TXT"
	PUNTERO = FOPEN(ARVO,0)
	IF PUNTERO > 0 THEN
			SQLMATRIZ(1) = ALLTRIM(FGETS(PUNTERO,2024))
			SQLMATRIZ(2) = ALLTRIM(FGETS(PUNTERO,2024))
			SQLMATRIZ(3) = ALLTRIM(FGETS(PUNTERO))	
			VARDATOS     = ALLTRIM(FGETS(PUNTERO,2024))
			SQLMATRIZ(5) = ALLTRIM(FGETS(PUNTERO))
		=FCLOSE(PUNTERO)
		SET SAFETY OFF
	ENDIF

*	ARVO2 = "C:\TEMP\FOXMYSQL\"+ALLTRIM(TMPTABLAS.N2TABLA)+"2.TXT"
*	PUNTERO2 = FCREATE(ARVO2)  

	=SQLEXEC(lnHandle,"DELETE FROM "+LOWER(ARCHIVO),"in")

	SELECT &ARCHIVO
	GO TOP
	DO WHILE !EOF()

		* CARGO LOS DATOS EN LA TABLA CORRESPONDIENTE *
		SQLMATRIZ(4) = &VARDATOS
		SQLMATRIZ(4) = STRTRAN(SQLMATRIZ(4),"\","/")
		=SQLEXEC(lnHandle,sqlmatriz(1)+sqlmatriz(2)+sqlmatriz(3)+sqlmatriz(4)+sqlmatriz(5),"sin")
*		=FPUTS(PUNTERO2, sqlmatriz(4))

			
		SELECT &ARCHIVO
		SKIP
	ENDDO 
*	=SQLEXEC(lnHandle,"SELECT * FROM "+LOWER(ARCHIVO),ARCHIVO+"SQL")
*	BROWSE 

	SELECT &ARCHIVO
	
	FCLOSE(PUNTERO)
*	FCLOSE(PUNTERO2)

ENDFUNC

****************************************************************************************
****************************************************************************************
*****************************************************************************************

FUNCTION coneccion
PARAMETERS pbase
** ARMA LA CONEXION CON LA BASE DE DATOS E INSERTA LOS REGISTROS
** LA TABLA QUE SE LE PASA COMO PARAMETRO ES LA QUE USARA PARA INSERTAR LOS REGISTROS
	SQLDISCONNECT(lnHandle)
	lcServer="debian" 
	lcDatabase=pbase
	lcUser="tulio"
	lcPassword="tulio"
	lcDriver="{MySQL ODBC 3.51 Driver}"
	lcStringConn="Driver="+lcDriver+";Port=3306"+;
	";Server="+lcServer+;
	";Database="+lcDatabase+;
	";Uid="+lcUser+;
	";Pwd="+lcPassWord
*	PUBLIC lnHandle
	lnHandle=SQLSTRINGCONNECT(lcStringConn)
*	MESSAGEBOX(STR(lnHandle))
	
	IF lnHandle > 0
	*	SQLEXEC(lnHandle,"insert into prueba (item,idp,codigo,cantidad,detalle,unidad,proveedor) values (10,15,'dato nuevo',20,'detalle nuevo para probar si carga todos los datos','unidades','PROVEEDORES')","sin")
	*	SQLEXEC(lnHandle,"DELETE FROM prueba WHERE item = 10","in")
	*	SQLEXEC(lnHandle,"UPDATE prueba set idp = 11 WHERE item = 1","in")
	*	?SQLTABLES(lnHandle,"TABLES")
*		?SQLEXEC(lnHandle,"SELECT * FROM ocomprap","auxi")
*		brow
	ELSE
		=AERROR(laError)
		MESSAGEBOX("Error de conexi�n"+CHR(13)+;
		"Descripcion:"+laError[2])
	ENDIF
	
ENDFUNC 





