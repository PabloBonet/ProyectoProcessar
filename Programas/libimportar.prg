*/ PARAMETROS
*--------------
* Todas las funciones de la libreria reciben 3 parametros
* 		P_idimportap : indice de la tabla importadatosp para localizar el registro que tiene los parametros de ejecuci�n
* 		P_archivo	 : Si la funcion se utiliza para importar datos, en este vendr� el archivo que se importar�
* 		P_func		 : Este parametro le indica a la funcion si se debe grabar , eliminar, chequear, etc 
*
* RETORNOS de las funciones en la librer�a
* -----------------------------------------
* Variables que indican el comportamiento de la funcion para comunicar resultados 
* Es necesario para saber si la funci�n se ejecuto correctamente o se produjeron errores

* valor a devolver:
*   'CHECK'   =  9 : Indica que solo se realiza un chequeo de la existencia de la funcion - retorna 9 si la funcion existe
*	 'MUESTRA' =  2 : Muestra los registros Importados
*	 'GUARDO'  =  1 : Indica que si se realiz� una grabaci�n, esta efectivamente se realiz� .
*   'NEUTRO'  =  0 : La funci�n no reporto errores y el resultado no afecta en nada la ejecucion de instrucciones siguientes
*   'ELIMINO' = -1 : Indica si se pudo eliminar los registros en caso de solicitar la baja
*   'ERROR'   = -9 : Indica que la funcion report� un error en la ejecuci�n 
* IMPORTANTE: Todas las funciones deben ser realizadas teniendo en cuenta al menos los parametros de ingreso y retorno 
* 				Explicados arriba
*------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------

FUNCTION chkfunction
*/ 
*Funci�n para Intentos de ejecuciones de funciones, devuelve .F. Falso si la funci�n no existe o da error 
*/
	LPARAMETERS pfuncion
	ON ERROR vfnvalida=.f. 
	vfnvalida = .t. 
	eje = "vretorno = "+ALLTRIM(pfuncion)
	&eje 
	ON ERROR  
	RETURN vfnvalida
ENDFUNC 

FUNCTION Fconsutablas
*/
* Funcion para Visualizacion de los datos de la importaci�n Seleccionada, Recibe como parametro el "idimportap"
*/
	PARAMETERS paraidimportap, paraformulario, paramodifica
		IF TYPE('paraformulario')<>'C' THEN 
			paraformulario = 'consultatablas'
		ENDIF 
		vconeccionF=abreycierracon(0,_SYSSCHEMA)
			sqlmatriz(1)="Select p.*, i.tabla, i.detalle as detallea , i.funcion, i.servicio from importadatosp p left join importadatos i on i.idimporta = p.idimporta "
			sqlmatriz(2)=" where p.idimportap = "+STR(paraidimportap)
			verror=sqlrun(vconeccionF,"importadatosp_sql01")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la B�squeda de Datos Importados ",0+48+0,"Error")
			    RETURN p_func 
			ENDIF 
		*******************************************************************
		*******************************************************************
		=abreycierracon(vconeccionF,"")
		SELECT importadatosp_sql01
		GO TOP 
		IF !EOF() THEN 
			v_tabla01 = LOWER(ALLTRIM(importadatosp_sql01.tabla))
			v_campo01 = "idimportap"
			v_indice01 = importadatosp_sql01.idimportap
			v_servicio01 = importadatosp_sql01.servicio
			USE IN importadatosp_sql01	
			DO FORM &paraformulario WITH v_tabla01, v_campo01, v_indice01, paramodifica
		ELSE 	
			USE IN importadatosp_sql01		
		ENDIF 
ENDFUNC 

* Funcion para Eliminaci�n de los registros de una tabla , recibe como parametro "Tabla" "idimportap"
FUNCTION fdeltablas
	PARAMETERS pnomtabla, paraidimportap
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			boton=messagebox("   Se van a Eliminar los Registros Cargados ( "+pnomtabla+" ),"+CHR(13)+CHR(13)+"� Confirma que desea Eliminarlos ?",4+32,"Informaci�n del Sistema")
			if boton = 6 then
				sqlmatriz(1)=" delete from "+pnomtabla+" where idimportap ="+STR(paraidimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros ... ",0+48+0,"Error")
				    RETURN 0 
				ENDIF
				RETURN -1
			else
				RETURN 0
			endif
		=abreycierracon(vconeccionF,"")		
ENDFUNC 
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de mediciones de la Central Telef�nica Huawei
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaHuawei
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
		p_func = fdeltablas("medtelefono",p_idimportap)
		RETURN p_func 
	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Telefon�a -
		p_archivo = alltrim(p_archivo)
	
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			RETURN 0
		ENDIF
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		sqlmatriz(1)=" select * from medtelefono where idimportap ="+STR(p_idimportap)
		verror=sqlrun(vconeccionF,"medtele_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de mediciones de telefonia... ",0+48+0,"Error")
		    RETURN 
		ENDIF

		SELECT medtele_sql
		GO TOP 
		if !EOF() then
			boton=messagebox("   Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"� DESEA SOBREESCRIBIRLOS ?",52,"Informaci�n del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from medtelefono where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de datos de mediciones de telefonia... ",0+48+0,"Error")
				    RETURN 
				ENDIF
			else
				RETURN
			endif
		endif

		MESSAGEBOX(_syspulso)
		
		V_archillamadas=HWDETBANDA(p_archivo, _SYSPULSO)
	
		IF !EMPTY(V_archillamadas) THEN 
			eje="USE .\"+v_archillamadas+" IN 0"
			&eje
			eje = "sele "+STRTRAN(UPPER(v_archillamadas),'.DBF','') 
			&eje
		ELSE
			RETURN 
		ENDIF 

		DIMENSION lamatriz(27,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "

		DO WHILE !EOF()
			lamatriz(1,1) = 'bocanumero'
			lamatriz(1,2) = "'"+ALLTRIM(STR(HWDETBANDA.telefono))+"'"
			lamatriz(2,1) = 'consumo'
			lamatriz(2,2) = ALLTRIM(STR(HWDETBANDA.pesos,12,4))
			lamatriz(3,1) = 'pulddn1'
			lamatriz(3,2) = ALLTRIM(STR(HWDETBANDA.canddn1))
			lamatriz(4,1) = 'pulddn2'
			lamatriz(4,2) = ALLTRIM(STR(HWDETBANDA.canddn2))
			lamatriz(5,1) = 'pesos_n'
			lamatriz(5,2) = ALLTRIM(STR(HWDETBANDA.pesos_n,12,4))
			lamatriz(6,1) = 'pesos_r'
			lamatriz(6,2) = ALLTRIM(STR(HWDETBANDA.pesos_r,12,4))
			lamatriz(7,1) = 'pesos'
			lamatriz(7,2) = ALLTRIM(STR(HWDETBANDA.pesos,12,4))
			lamatriz(8,1) = 'canddn1'
			lamatriz(8,2) = ALLTRIM(STR(HWDETBANDA.canddn1))
			lamatriz(9,1) = 'durddn1'
			lamatriz(9,2) = ALLTRIM(STR(HWDETBANDA.durddn1))
			lamatriz(10,1) = 'pesosddn1'
			lamatriz(10,2) = ALLTRIM(STR(HWDETBANDA.pesosddn1,12,4))
			lamatriz(11,1) = 'canddn2'
			lamatriz(11,2) = ALLTRIM(STR(HWDETBANDA.canddn2))
			lamatriz(12,1) = 'durddn2'
			lamatriz(12,2) = ALLTRIM(STR(HWDETBANDA.durddn2))
			lamatriz(13,1) = 'pesosddn2'
			lamatriz(13,2) = ALLTRIM(STR(HWDETBANDA.pesosddn2,12,4))
			lamatriz(14,1) = 'canddi1'
			lamatriz(14,2) = ALLTRIM(STR(HWDETBANDA.canddi1))
			lamatriz(15,1) = 'durddi1'
			lamatriz(15,2) = ALLTRIM(STR(HWDETBANDA.durddi1))
			lamatriz(16,1) = 'pesosddi1'
			lamatriz(16,2) = ALLTRIM(STR(HWDETBANDA.pesosddi1,12,4))
			lamatriz(17,1) = 'canddi2'
			lamatriz(17,2) = ALLTRIM(STR(HWDETBANDA.canddi2))
			lamatriz(18,1) = 'durddi2'
			lamatriz(18,2) = ALLTRIM(STR(HWDETBANDA.canddi2))
			lamatriz(19,1) = 'pesosddi2'
			lamatriz(19,2) = ALLTRIM(STR(HWDETBANDA.pesosddi2,12,4))
			lamatriz(20,1) = 'canloc1'
			lamatriz(20,2) = ALLTRIM(STR(HWDETBANDA.canloc1))
			lamatriz(21,1) = 'durloc1'
			lamatriz(21,2) = ALLTRIM(STR(HWDETBANDA.durloc1))
			lamatriz(22,1) = 'pesosloc1'
			lamatriz(22,2) = ALLTRIM(STR(HWDETBANDA.pesosloc1,12,4))
			lamatriz(23,1) = 'canloc2'
			lamatriz(23,2) = ALLTRIM(STR(HWDETBANDA.canloc2))
			lamatriz(24,1) = 'durloc2'
			lamatriz(24,2) = ALLTRIM(STR(HWDETBANDA.durloc2))
			lamatriz(25,1) = 'pesosloc2'
			lamatriz(25,2) = ALLTRIM(STR(HWDETBANDA.pesosloc2,12,4))
			lamatriz(26,1) = 'idimportap'
			lamatriz(26,2) = ALLTRIM(STR(p_idimportap))
			lamatriz(27,1) = 'idmedtele'
			lamatriz(27,2) = '0'


			p_tabla     = 'medtelefono'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de LLamadas Telef�nicas ",0+48+0,"Error")
			ENDIF 
			
			eje = "sele "+STRTRAN(UPPER(v_archillamadas),'.DBF','') 
			&eje
			SKIP 					
		ENDDO 
	
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	ENDIF 	&& 1- Carga de Archivo de Telefon�a -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Telefon�a 

	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap)	
	ENDIF && 2- Visualiza Datos de Telefon�a -
	
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC 


*******************************************************
************************************
* GENERA UN ARCHIVO TEMPORAL EN EL CUAL APARECEN TODAS LAS LLAMADAS
* REALIZADAS EN UN MES DETERMINADO EN LAS DISTINTAS BANDAS HORARIAS
* EL ARCHIVO GENERADO SE LLAMA HWDETBANDA.DBF
* RECIBE COMO PARAMETRO EL ARCHIVO DE ORIGEN Y EL VALOR DEL PULSO PARA TASAR
* EJ: =HWDETBANDA("C:\COSEMAR\TELEFONO\ABONADOS\",0.049)
* DEVUELVE EL NOMBRE DEL ARCHIVO SI TODO FUE CORRECTO, SINO DEVUELVE ""
************************************
FUNCTION HWDETBANDA
PARAMETER CAMINO, p_valorpulso
LOCAL v_hwdetbanda
v_hwdetbanda ="HWDETBANDA.DBF"
if file(".\HWDETBANDA.dbf") THEN
	if used("HWDETBANDA") then
		sele HWDETBANDA
		use
	endif
	DELETE FILE .\HWDETBANDA.dbf
endif

CREATE TABLE .\HWDETBANDA FREE (TELEFONO N(8), CANDDN1 N(6), DURDDN1 N(8), PESOSDDN1 N(16,8), ;
                                                    CANDDN2 N(6), DURDDN2 N(8), PESOSDDN2 N(16,8), ;
                                                    CANDDI1 N(6), DURDDI1 N(8), PESOSDDI1 N(16,8), ;
                                                    CANDDI2 N(6), DURDDI2 N(8), PESOSDDI2 N(16,8), ;
                                                    CANLOC1 N(6), DURLOC1 N(8), PESOSLOC1 N(16,8), ;
                                                    CANLOC2 N(6), DURLOC2 N(8), PESOSLOC2 N(16,8), ;
                                                    PESOS_N N(16,8), PESOS_R N(16,8), PESOS N(16,8))

CAMINO = alltrim(CAMINO)
ARCHIVO = CAMINO

	if !file(ARCHIVO) THEN
		*wait window "El Archivo "+alltrim(archivo)+ " NO EXISTE. " timeout 5
	ELSE
		=HWCDR(CAMINO,p_valorpulso)	
		
		if file(".\HWCDR.dbf") THEN
			if used("HWCDR") then
			ELSE 
				USE .\HWCDR.DBF IN 0
			endif
		endif

			
		*************** ACA EMPIEZA EL CALCULO DE DETALLE
		
		if file(".\HWDETLLAMA.dbf") THEN
			if used("HWDETLLAMA") then
				sele HWDETLLAMA
				use
			endif
			DELETE FILE .\HWDETLLAMA.dbf
		endif

		CREATE TABLE .\HWDETLLAMA FREE (SECUENCIA N(10), TELEFONO N(8), SALIDA N(4), DIA N(2),BARRA C(1), MES N(2), ;
		                                   HORA N(2),PUNTOS C(1), MINUTOS N(2), DURACION N(8), IMPORTE C(6), NLLAMADO C(16), ;
		                                   OTROS0 C(11),CLAVE N(2) ,OTROS C(11), PESOS N(10,4), FECHA D)
		
		
		sele HWDETLLAMA
		GO TOP
		************ SEPARO LOS TELEFONOS CON LLAMADAS Y LUEGO LOS PROCESO UNO POR UNO ***********
		SET ENGINEBEHAVIOR 70
		SELECT crnumber31 as telefono from hwcdr INTO TABLE hwtelefonos ORDER BY crnumber31 GROUP BY crnumber31 && cursor con los telefonos a cargar
		SET ENGINEBEHAVIOR 90 

		SELECT hwtelefonos
		GO TOP 
		DO WHILE !EOF()
			SELECT HWDETLLAMA
			ZAP 
			SELECT * from hwcdr INTO TABLE hwcdr1 WHERE crnumber31 = hwtelefonos.telefono ORDER BY fechah15
			SELECT hwcdr1
			GO TOP 
			DO WHILE !EOF()
					SELECT hwdetllama
					INSERT INTO hwdetllama (secuencia, telefono, salida , dia, barra, mes, hora, puntos, minutos, duracion, importe, nllamado, otros0, clave, otros, pesos, fecha) ;
									VALUES (hwcdr1.sernumber1, hwcdr1.crnumber31,0,INT(VAL(SUBSTR(hwcdr1.fechah15,9,2))),'/',INT(VAL(SUBSTR(hwcdr1.fechah15,6,2))),;
									        INT(VAL(SUBSTR(hwcdr1.fechah15,12,2))),':',INT(VAL(SUBSTR(hwcdr1.fechah15,15,2))),hwcdr1.tieconv16, ALLTRIM(STR(hwcdr1.importe,10,4)), ;
									        hwcdr1.dinumber36,' ',hwcdr1.chcas55,' ',hwcdr1.importe,DATE(INT(VAL(SUBSTR(hwcdr1.fechah15,1,4))),INT(VAL(SUBSTR(hwcdr1.fechah15,6,2))),INT(VAL(SUBSTR(hwcdr1.fechah15,9,2)))))
					
				SELECT hwcdr1
				SKIP 
			ENDDO 
			***** AQUI PROCESO LAS LLAMADAS DE UN ABONADO ******
			SELE hwdetllama		
			GO TOP 
			SELE HWDETBANDA
			APPEND BLANK
			REPLACE TELEFONO WITH hwdetllama.telefono
			SELE hwdetllama		
			DO WHILE !eof()

				tdia = DOW(hwdetllama.fecha)
				tbanda = 0
				DO CASE 
					CASE tdia = 1
						tbanda = 2
					CASE tdia = 7
						IF  8 <= hwdetllama.hora AND hwdetllama.hora < 13 THEN 
							tbanda = 1
						ELSE
							tbanda = 2
						ENDIF 
					OTHERWISE 
						IF  8 <= hwdetllama.hora AND hwdetllama.hora < 22 THEN 
							tbanda = 1
						ELSE
							tbanda = 2
						ENDIF 
				ENDCASE 
				SELE HWDETBANDA
				DO CASE
					CASE tbanda = 1 and hwdetllama.nllamado = "498"
						REPLACE canloc1 with canloc1 + 1, ;
								durloc1 with durloc1 + hwdetllama.duracion, ;
								pesosloc1 with pesosloc1 + hwdetllama.pesos , ;
								pesos_n with pesos_n + hwdetllama.pesos , ;
								pesos with pesos + hwdetllama.pesos 
								
					CASE tbanda = 1 and (hwdetllama.nllamado = "54")
						REPLACE canddi1 with canddi1 + 1, ;
								durddi1 with durddi1 + hwdetllama.duracion, ;
								pesosddi1 with pesosddi1 + hwdetllama.pesos , ;
								pesos_n with pesos_n + hwdetllama.pesos , ;
								pesos with pesos + hwdetllama.pesos 

					CASE tbanda = 1 and !(hwdetllama.nllamado = "498") and !(hwdetllama.nllamado = "54")
						REPLACE canddn1 with canddn1 + 1, ;
								durddn1 with durddn1 + hwdetllama.duracion, ;
								pesosddn1 with pesosddn1 + hwdetllama.pesos , ;
								pesos_n with pesos_n + hwdetllama.pesos , ;
								pesos with pesos + hwdetllama.pesos 

					CASE tbanda = 2 and hwdetllama.nllamado = "498"
						REPLACE canloc2 with canloc2 + 1, ;
								durloc2 with durloc2 + hwdetllama.duracion, ;
								pesosloc2 with pesosloc2 + hwdetllama.pesos, ;
								pesos_r with pesos_r + hwdetllama.pesos, ;
								pesos with pesos + hwdetllama.pesos
					
					CASE tbanda = 2 and (hwdetllama.nllamado = "54")
						REPLACE canddi2 with canddi2 + 1, ;
								durddi2 with durddi2 + hwdetllama.duracion, ;
								pesosddi2 with pesosddi2 + hwdetllama.pesos , ;
								pesos_r with pesos_r + hwdetllama.pesos , ;
								pesos with pesos + hwdetllama.pesos 

					CASE tbanda = 2 and !(hwdetllama.nllamado = "498") and !(hwdetllama.nllamado = "54")
						REPLACE canddn2 with canddn2 + 1, ;
								durddn2 with durddn2 + hwdetllama.duracion, ;
								pesosddn2 with pesosddn2 + hwdetllama.pesos , ;
								pesos_r with pesos_r + hwdetllama.pesos , ;
								pesos with pesos + hwdetllama.pesos 
					OTHERWISE
				ENDCASE
				
				SELE hwdetllama
				SKIP

			ENDDO
			
			SELECT hwtelefonos
			SKIP 
		ENDDO 
	ENDIF
	USE IN HWDETLLAMA
	USE IN hwtelefonos
	USE IN HWDETBANDA
	USE IN HWCDR
	USE IN hwcdr1 
	
RETURN v_hwdetbanda


************************************************************
************************************************************
************************************
* GENERA UN ARCHIVO TEMPORAL EN EL CUAL EST�N TODAS LAS LLAMADAS
* ESTAN TODAS LAS LLAMADAS DE TODOS LOS TELEFONOS INCLUIDOS EN 
* EL ARCHIVO PASADO COMO PARAMETRO, CALULADO AL VALOR DEL PUSO PASADO
* EJ: =HWCDR("C:\COSEMAR\TELEFONO\ABONADOS\ARCHIVO.TXT",0.049)
************************************

FUNCTION HWCDR
PARAMETER CAMINO, P_IMP_PULSO 
	SET DECIMALS TO 4
	v_retorno = "HWCDR.DBF"
	CAMINO = alltrim(CAMINO)

	if !file(CAMINO) THEN
		WAIT WINDOW "EL ARCHIVO "+CAMINO+" NO EXISTE" TIMEOUT 10
		RETURN .f.
	endif

	if file(".\HWCDR.dbf") THEN
		if used("HWCDR") then
			sele HWCDR
			use
		endif
		DELETE FILE .\HWCDR.dbf
	ENDIF

	CREATE TABLE .\HWCDR FREE (CDR C(142), crnan25 n(5), crnumber31 n(11), crc50 n(3),cdnan27 n(5),cdnumber35 n(20), ;
									fechah15 c(20),	tieconv16 n(8,2),pri4 N(3), sernumber1 n(10) ,dinumber36 c(24), ;
									ct52 n(2),st53 n(2),chcas55 n(2),pulse57 n(10), importe n(10,4))
	SELECT HWCDR
	APPEND FROM &CAMINO SDF
	SELECT hwcdr
	GO TOP 
	FOR i = 1 TO 4
		DELETE 
		SKIP 
	ENDFOR 
	GO BOTTOM 
	FOR i = 1 TO 11
		DELETE 
		SKIP -1
	ENDFOR 
	PACK 
	GO TOP 
	replace ALL crnan25 	WITH INT(VAL(SUBSTR(cdr,2,5))), ;
			    crnumber31 	WITH INT(VAL(SUBSTR(cdr,7,11))), ;
			    crc50 		WITH INT(VAL(SUBSTR(cdr,19,3))), ;
			    cdnan27 	WITH INT(VAL(SUBSTR(cdr,23,5))), ;
			    cdnumber35 	WITH INT(VAL(SUBSTR(cdr,29,20))), ;
			    fechah15 	WITH SUBSTR(cdr,50,19), ;
			    tieconv16 	WITH VAL(STRTRAN(SUBSTR(cdr,70,8),',','.')), ;
			    pri4 		WITH INT(VAL(SUBSTR(cdr,79,3))), ;
			    sernumber1 	WITH INT(VAL(SUBSTR(cdr,83,10))), ;
			    dinumber36 	WITH ALLTRIM(SUBSTR(cdr,94,24)), ;
			    ct52 		WITH INT(VAL(SUBSTR(cdr,119,2))), ;
			    st53 		WITH INT(VAL(SUBSTR(cdr,122,2))), ;
			    chcas55		WITH INT(VAL(SUBSTR(cdr,125,5))), ;
			    pulse57 	WITH INT(VAL(SUBSTR(cdr,131,10)))
	*		    importe 	WITH INT(VAL(SUBSTR(cdr,2,5)))
	GO TOP 

	** para eliminar archivos duplicados 
	SET ENGINEBEHAVIOR 70 
	SELECT *, SUBSTR(cdr,7,11)+SUBSTR(cdr,29,20)+SUBSTR(cdr,50,19)+SUBSTR(cdr,70,8)+SUBSTR(cdr,94,24) as unificado  FROM hwcdr INTO TABLE .\hwcdr01  ORDER BY unificado GROUP BY unificado  
	SET ENGINEBEHAVIOR 90 

	SELECT * FROM hwcdr01 INTO TABLE .\hwcdrall 
	SELECT hwcdrall
	GO TOP 
	replace importe WITH pulse57*P_IMP_PULSO FOR (ct52 = 1 OR ct52 = 3 OR ct52 = 4)

	SELECT hwcdr
	USE
	SELECT * from hwcdr01 INTO TABLE .\hwcdr

	SELECT hwcdr 
	GO TOP 
	DELETE FOR !(ct52 = 1 OR ct52 = 3 OR ct52 = 4)
	GO TOP 
	DELETE FOR (!(SUBSTR(ALLTRIM(STR(crnumber31)),1,3)='498') AND ct52=4)
	GO TOP 
	replace ALL importe 	WITH pulse57*P_IMP_PULSO
	PACK

	USE IN hwcdr
	USE IN hwcdr01  
	USE IN hwcdrall 
	
	RETURN v_retorno

ENDFUNC 

*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Fin de Funciones de Carga de Central Telef�nica Huawei
*/------------------------------------------------------------------------------------------------------------


*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga Archivo CPP Calling Party Pay
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaCPP
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************
	IF p_func = -1 THEN  &&  Eliminacion de Registros
		p_func = fdeltablas("cpptelefono",p_idimportap)
		RETURN p_func 
	ENDIF 
*/**************************************************************
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de CPP -
		p_archivo = alltrim(p_archivo)
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		sqlmatriz(1)=" select * from cpptelefono where idimportap ="+STR(p_idimportap)
		verror=sqlrun(vconeccionF,"cpp_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de CPP... ",0+48+0,"Error")
		    RETURN 
		ENDIF

		SELECT cpp_sql
		GO TOP 
		if !EOF() then
			boton=messagebox("   Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"� DESEA SOBREESCRIBIRLOS ?",52,"Informaci�n del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from cpptelefono where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de datos de CPP ... ",0+48+0,"Error")
				    RETURN 
				ENDIF
			else
				RETURN
			endif
		endif

		if file(".\cpptmp.dbf") THEN
			if used("cpptmp") then
				sele cpptmp
				use
			endif
			DELETE FILE .\cpptmp.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			RETURN 0
		ENDIF

		CREATE TABLE .\CPPTMP FREE (medidas C(73))
		SELE CPPTMP
		APPEND FROM &p_archivo FIELD medidas SDF
		GO 1

		IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 1) THEN
			GO 2
			IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 2) THEN
				GO BOTT
				IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 99) THEN
				ELSE
					=messagebox("EL ARCHIVO DE CARGA ES ERR�NEO",16,"Error de Carga")
					RETURN
				ENDIF
			ELSE
				=messagebox("EL ARCHIVO DE CARGA ES ERR�NEO",16,"Error de Carga")
				RETURN
			ENDIF
		ELSE
			=messagebox("EL ARCHIVO DE CARGA ES ERR�NEO",16,"Error de Carga")
			RETURN
		ENDIF

		GO 1
		SET DATE TO YMD
		FEGENE = CTOD(SUBSTR(CPPTMP.MEDIDAS,3,4)+"/"+SUBSTR(CPPTMP.MEDIDAS,7,2)+"/"+SUBSTR(CPPTMP.MEDIDAS,9,2))
		HOGENE = SUBSTR(CPPTMP.MEDIDAS,11,2)+":"+SUBSTR(CPPTMP.MEDIDAS,13,2)+":"+SUBSTR(CPPTMP.MEDIDAS,15,2)
		NSECUENCIA = VAL(SUBSTR(CPPTMP.MEDIDAS,17,7))

		SELE CPPTMP
		GO BOTT
		DELETE
		PACK
		GO 2
		SET DATE TO YMD

		DIMENSION lamatriz(17,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "

		DO WHILE !EOF()
			lamatriz(1,1) = 'bocanumero'
			lamatriz(1,2) = "'"+ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,17,6))))+"'"
			lamatriz(2,1) = 'cppprov'
			lamatriz(2,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,3,2)),12,4))
			lamatriz(3,1) = 'cod_coop'
			lamatriz(3,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,5,4))))
			lamatriz(4,1) = 'nsecfeco'
			lamatriz(4,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,9,4))))
			lamatriz(5,1) = 'carllama'
			lamatriz(5,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,13,4)),12,4))
			lamatriz(6,1) = 'nllamado'
			lamatriz(6,2) = "'"+ALLTRIM(SUBSTR(CPPTMP.MEDIDAS,23,15))+"'"
			lamatriz(7,1) = 'fechaini'
			lamatriz(7,2) = "'"+ALLTRIM(DTOS(CTOD(SUBSTR(CPPTMP.MEDIDAS,38,4)+"/"+SUBSTR(CPPTMP.MEDIDAS,42,2)+"/"+SUBSTR(CPPTMP.MEDIDAS,44,2))))+"'"
			lamatriz(8,1) = 'horaini'
			lamatriz(8,2) = "'"+ALLTRIM(SUBSTR(CPPTMP.MEDIDAS,46,2)+":"+SUBSTR(CPPTMP.MEDIDAS,48,2)+":"+SUBSTR(CPPTMP.MEDIDAS,50,2))+"'"
			lamatriz(9,1) = 'segureal'
			lamatriz(9,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,52,7))))
			lamatriz(10,1) = 'seguvalor'
			lamatriz(10,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,59,7))))
			lamatriz(11,1) = 'valorllama'
			lamatriz(11,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,66,5)+"."+SUBSTR(CPPTMP.MEDIDAS,71,2)),12,4))
			lamatriz(12,1) = 'tipollama'
			lamatriz(12,2) = ALLTRIM(STR(VAL(SUBSTR(CPPTMP.MEDIDAS,73,1))))
			lamatriz(13,1) = 'fechgene'
			lamatriz(13,2) = "'"+ALLTRIM(DTOS(FEGENE))+"'"
			lamatriz(14,1) = 'horagene'
			lamatriz(14,2) = "'"+ALLTRIM(HOGENE)+"'"
			lamatriz(15,1) = 'secuencia2'
			lamatriz(15,2) = ALLTRIM(STR(NSECUENCIA))
			lamatriz(16,1) = 'idimportap'
			lamatriz(16,2) = ALLTRIM(STR(p_idimportap))
			lamatriz(17,1) = 'idcpp'
			lamatriz(17,2) = '0'

			p_tabla     = 'cpptelefono'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de CPP ",0+48+0,"Error")
			ENDIF 
			
			SELE cpptmp
			SKIP 
						
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de CPP 
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC 



*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Fin de Funciones de CPP Calling Party Pay
*/------------------------------------------------------------------------------------------------------------


*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga Archivo CLARO Telefonia Celular
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaClaro
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 

*/**************************************************************
	IF p_func = -1 THEN  &&  Eliminacion de Registros
		p_func = fdeltablas("factclaro",p_idimportap)
		RETURN p_func 
	ENDIF 
*/**************************************************************
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de CLARO -
		
		IF EMPTY(ALLTRIM(p_archivo)) OR ALLTRIM(p_archivo)="Seleccione Archivo ..." THEN 
			=CargaClaro(0,"",3)
			p_archivo = _SYSESTACION+"\claroexpo.dbf"
		ENDIF 
			
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		sqlmatriz(1)=" select * from factclaro where idimportap ="+STR(p_idimportap)
		verror=sqlrun(vconeccionF,"claro_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de Claro... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN 0
		ENDIF

		local vppabono ,vppserv , vppcargos , vppaire , vppldn , vppldi , vppldim ,vppdata , vppeq , vppvarios 
		 vppabono 	= 0
		 vppserv 	= 0
		 vppcargos 	= 0
		 vppaire 	= 0
		 vppldn 	= 0
		 vppldi 	= 0
		 vppldim 	= 0
		 vppdata 	= 0
		 vppeq 		= 0
		 vppvarios 	= 0
		
		sqlmatriz(1)=" select CAST(ifnull(idimportap,0) as signed) as maxidimpo from factclaro where idimportap < "+STR(p_idimportap)
		verror=sqlrun(vconeccionF,"claropmax_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de Claro... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN 0
		ENDIF
		SELECT claropmax_sql
		vmaxidimpo = claropmax_sql.maxidimpo
		IF TYPE('vmaxidimpo')='C' THEN 
			vmaxidimpo = VAL(vmaxidimpo)
		ENDIF 
		IF !EOF() THEN 
			sqlmatriz(1)=" select max(pabono) as pabono, MAX(pserv) as pserv, MAX(pcargos) as pcargos, "
			sqlmatriz(2)=" max(paire) as paire, max(pldn) as pldn, MAX(pldi) as pldi, MAX(pldim) as pldim, "
			sqlmatriz(3)=" MAX(pdata) as pdata, MAX(peq) as peq, MAX(pvarios) as pvarios "
			sqlmatriz(4)=" from factclaro where idimportap = "+ALLTRIM(STR(vmaxidimpo))
			verror=sqlrun(vconeccionF,"clarop0_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de Claro... ",0+48+0,"Error")
				=abreycierracon(vconeccionF,"")	
			    RETURN 0
			ENDIF
			SELECT clarop0_sql
			GO TOP 
			IF !EOF() THEN 
				 vppabono 	= clarop0_sql.pabono
				 vppserv 	= clarop0_sql.pserv
				 vppcargos 	= clarop0_sql.pcargos
				 vppaire 	= clarop0_sql.paire
				 vppldn 	= clarop0_sql.pldn
				 vppldi 	= clarop0_sql.pldi
				 vppldim 	= clarop0_sql.pldim
				 vppdata 	= clarop0_sql.pdata
				 vppeq 		= clarop0_sql.peq
				 vppvarios 	= clarop0_sql.pvarios
			ENDIF 
			USE IN clarop0_sql 

		ENDIF 
		USE IN claropmax_sql

	
		SELECT claro_sql
		GO TOP 
		if !EOF() then
			boton=messagebox("  Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"� DESEA SOBREESCRIBIRLOS ?",52,"Informaci�n del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from factclaro where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de datos de Claro ... ",0+48+0,"Error")
					=abreycierracon(vconeccionF,"")	
				    RETURN 0
				ENDIF
			else
				=abreycierracon(vconeccionF,"")	
				RETURN 0
			endif
		endif

		if file(".\claro.dbf") THEN
			if used("claro") then
				sele claro
				use
			endif
			DELETE FILE .\claro.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\claro FREE (telefono c(15), usuario C(50), plan c(5), abono n(13,2), pabono n(13,2), tabono n(13,2), impserv n(13,2), ;
					pserv n(13,2), tserv n(13,2), cargos n(13,2), pcargos n(13,2), tcargos n(13,2), ;
					minaire n(13,2), minaireex n(13,2), impaire n(13,2), paire n(13,2), taire n(13,2), ;
					minldn n(13,2), impldn n(13,2), pldn n(13,2), tldn n(13,2), ;
					minldi n(13,2), impldi n(13,2), pldi n(13,2), tldi n(13,2), ;
					minldim n(13,2), impldim n(13,2), pldim n(13,2), tldim n(13,2), ;
					datau n(13,2), ;
					dataimp n(13,2), pdata n(13,2), tdata n(13,2), ;
					impeq n(13,2), peq n(13,2), teq n(13,2), ;
					varios n(13,2), pvarios n(13,2), tvarios n(13,2), tclaro n(13,2), ;
					total n(13,2), idregistro i, marca i)			
					
		SELECT claro 
		INDEX ON ALLTRIM(STRTRAN(telefono,'-','')) TAG telefono 

		LOCAL lcPath, lcCelda, lnCelda
		lcPath = p_archivo
		
		** verifico la extension del archivo y en funcion de eso decido como importarlo
		v_extension= UPPER(SUBSTR(lcPath,LEN(lcPath)-2))
		
		IF v_extension = "DBF" THEN  && Tabla de dbf con consumos 
	
			CREATE TABLE .\claro00 FREE (telefono c(15), usuario C(50), plan c(5), abono n(13,2), pabono n(13,2), tabono n(13,2), impserv n(13,2), ;
						pserv n(13,2), tserv n(13,2), cargos n(13,2), pcargos n(13,2), tcargos n(13,2), ;
						minaire n(13,2), minaireex n(13,2), impaire n(13,2), paire n(13,2), taire n(13,2), ;
						minldn n(13,2), impldn n(13,2), pldn n(13,2), tldn n(13,2), ;
						minldi n(13,2), impldi n(13,2), pldi n(13,2), tldi n(13,2), ;
						minldim n(13,2), impldim n(13,2), pldim n(13,2), tldim n(13,2), ;
						datau n(13,2), ;
						dataimp n(13,2), pdata n(13,2), tdata n(13,2), ;
						impeq n(13,2), peq n(13,2), teq n(13,2), ;
						varios n(13,2), pvarios n(13,2), tvarios n(13,2), tclaro n(13,2), ;
						total n(13,2), nroreg i, periodo i, anio i, zona i, idregistro i)	

			SELECT claro00		
			APPEND FROM &lcPath 
			
			SELECT claro 
			APPEND FROM .\claro00
			USE IN claro00				
	
		
		ELSE  && archivo excel con los consumos
			LOCAL lnCol, lnFil, lcMiHoja, lnHojas

			m.excel = createobject("excel.application")
			m.excel.application.visible = .F.
			m.excel.application.windowstate = -4137
			m.excel.workbooks.open(lcPath)

			*OBTENGO LA CANTIDAD DE HOJAS DE LIBRO
			lnHojas = 0
			FOR EACH oMyVar IN m.excel.sheets
				lnHojas = lnHojas + 1
			ENDFOR 

			SELECT claro 
			ZAP 

			LOCAL lcCelda, lnLi, lnCo, lnAux, lcAux, lcMacro, lnId
			*lnLi = linea, lnCo = columna
			*RECORRO TODAS LAS HOJAS DEL LIBRO
			lnId = 0

			FOR i=1 TO lnHojas  
				m.excel.sheets(i).select 	
				IF !m.excel.range("A2").value = "N�mero de L�nea" THEN 
					*los datos que tienen esta hoja no me interesan 
					LOOP 
				ENDIF 
				*-- Cantidad de columnas hoja actual
				lnCol = m.excel.ActiveSheet.UsedRange.COLUMNS.COUNT
				*-- Cantidad de filas hoja actual 
				lnFil = m.excel.ActiveSheet.UsedRange.ROWS.COUNT 

				*obtengo los datos 
				*arranco en la celda A4, recorror todas las columnas de la fila
				*luego avanzo de fila A(5) hasta llegar al final (lnFil)
				*lnFil = 4
				FOR lnLi=4 TO lnFil
					SELECT claro 
					APPEND BLANK 
					lnId = lnId + 1
					replace idregistro WITH lnId
					FOR lnCo = 1 TO lnCol 	
						*recorro todas las columnas de la fila 		
						lcAux = m.excel.ActiveSheet.cells(lnLi,lnCo).value	  		
						
						lnCol = lnCo
						tcValor = lcAux
						IF !ISNULL(tcValor) THEN 
							LOCAL lnAux
							SELECT claro 
							DO CASE 
								CASE lnCol = 1
									REPLACE telefono WITH tcValor
								CASE lnCol = 2		
									REPLACE usuario WITH tcValor
								CASE lnCol = 3		
									REPLACE plan WITH tcValor
								CASE lnCol = 4	
									REPLACE abono WITH tcValor
								CASE lnCol = 5
									REPLACE impserv WITH tcValor
								CASE lnCol = 6
									REPLACE cargos WITH tcValor
								CASE lnCol = 7
									REPLACE minaire WITH tcValor
								CASE lnCol = 8
									REPLACE minaireex WITH tcValor
								CASE lnCol = 9 &&PESOS ESTAB EN LLAMADAS
									REPLACE impaire WITH tcValor
								CASE lnCol = 10 
									REPLACE minldn WITH tcValor
								CASE lnCol = 11 &&PESOS MINUTOS
									REPLACE impldn WITH tcValor				
								CASE lnCol = 12
									REPLACE minldi WITH tcValor
								CASE lnCol = 13 &&PESOS ESTABL EN LLAMDAS LDI
									REPLACE impldi WITH tcValor
								CASE lnCol = 14	
									REPLACE minldim WITH tcValor	
								CASE lnCol = 15 
									REPLACE impldim WITH tcValor			
								CASE lnCol = 16
									REPLACE datau WITH tcValor
								CASE lnCol = 17
									REPLACE dataimp WITH tcValor
								CASE lnCol = 18
									REPLACE varios WITH tcValor
								CASE lnCol = 19
									REPLACE tclaro WITH tcValor
									REPLACE total WITH tcValor
							ENDCASE 
						ENDIF 
					ENDFOR 
				ENDFOR 	
			ENDFOR 
		
			m.excel.Workbooks.CLOSE
			m.excel.QUIT  

		ENDIF 

		LOCAL lnNro
		SELECT claro 
		GO TOP 
		SCAN FOR !EOF() AND !DELETED()
			IF claro.usuario = "., ." THEN 
				replace usuario WITH ''	
			ENDIF 
			IF UPPER(SUBSTR(claro.telefono,1,1)) = "T" THEN 
				DELETE 
				SELECT claro 
				LOOP 
			ENDIF 
	
		ENDSCAN 
		SELECT claro 
		REPLACE usuario WITH STRTRAN(claro.usuario,',',' ') ALL  
		REPLACE usuario WITH STRTRAN(claro.usuario,'.','') ALL 
		REPLACE usuario WITH STRTRAN(claro.usuario,CHR(10),'') ALL 
		REPLACE telefono WITH STRTRAN(claro.telefono,CHR(13),'') ALL 
		REPLACE impaire WITH 0.00 FOR impaire < 0 
		SELECT claro

		LOCAL lnAux 
		SELECT claro 
		
	 	IF !(vppabono = 0) THEN 

			UPDATE claro set pabono = vppabono, pserv = vppserv, pcargos = vppcargos, paire = vppaire, ;
							pldn = vppldn, pldi = vppldi, pldim = vppldim, pdata = vppdata, peq = vppeq, pvarios = vppvarios
		ENDIF 

		GO TOP 
		SCAN FOR !EOF()

			lnAux = claro.abono * claro.pabono
			replace tabono WITH lnAux

			lnAux = claro.impserv * claro.pserv
			replace tserv WITH lnAux

			lnAux = claro.cargos * claro.pcargos
			replace tcargos WITH lnAux

			lnAux = claro.impaire * claro.paire
			replace taire WITH lnAux

			lnAux = claro.impldn * claro.pldn
			replace tldn WITH lnAux

			lnAux = claro.impldi * claro.pldi
			replace tldi WITH lnAux

			lnAux = claro.impldim * claro.pldim
			replace tldim WITH lnAux

			lnAux = claro.dataimp * claro.pdata 
			replace tdata WITH lnAux

			lnAux = claro.impeq * claro.peq 
			replace teq WITH lnAux

			lnAux = claro.varios * claro.pvarios 
			replace tvarios WITH lnAux

			lnAux = claro.tabono+claro.tserv+claro.tcargos+claro.taire+claro.tldn+claro.tldi+claro.tldim+claro.tdata+claro.teq+claro.tvarios
			replace total WITH lnAux										

		ENDSCAN 

*!*			m.excel.Workbooks.CLOSE
*!*			m.excel.QUIT  

*!*			IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 1) THEN
*!*				GO 2
*!*				IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 2) THEN
*!*					GO BOTT
*!*					IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 99) THEN
*!*					ELSE
*!*						=messagebox("EL ARCHIVO DE CARGA ES ERR�NEO",16,"Error de Carga")
*!*						RETURN
*!*					ENDIF
*!*				ELSE
*!*					=messagebox("EL ARCHIVO DE CARGA ES ERR�NEO",16,"Error de Carga")
*!*					RETURN
*!*				ENDIF
*!*			ELSE
*!*				=messagebox("EL ARCHIVO DE CARGA ES ERR�NEO",16,"Error de Carga")
*!*				RETURN
*!*			ENDIF

		DIMENSION lamatriz(43,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		SELECT claro
		GO TOP 

		
		DO WHILE !EOF()
			lamatriz(1,1) = 'bocanumero'		
*			lamatriz(1,2) = "'"+substr(alltrim(claro.telefono),1,(LEN(alltrim(claro.telefono))-1))+"'"
			lamatriz(1,2) = "'"+alltrim(STRTRAN(claro.telefono,"-",""))+"'"
			lamatriz(2,1) = 'usuario'
			lamatriz(2,2) = "'"+alltrim(claro.usuario)+"'"
			lamatriz(3,1) = 'plan'
			lamatriz(3,2) = "'"+alltrim(claro.plan)+"'"
			lamatriz(4,1) = 'abono'
			lamatriz(4,2) = alltrim(str(claro.abono,12,4))
			lamatriz(5,1) = 'pabono'
			lamatriz(5,2) = alltrim(str(claro.pabono,12,4))
			lamatriz(6,1) = 'tabono'
			lamatriz(6,2) = alltrim(str(claro.tabono,12,4))
			lamatriz(7,1) = 'impserv'
			lamatriz(7,2) = alltrim(str(claro.impserv,12,4))
			lamatriz(8,1) = 'pserv'
			lamatriz(8,2) = alltrim(str(claro.pserv,12,4))
			lamatriz(9,1) = 'tserv'
			lamatriz(9,2) = alltrim(str(claro.tserv,12,4))
			lamatriz(10,1) = 'cargos'
			lamatriz(10,2) = alltrim(str(claro.cargos,12,4))
			lamatriz(11,1) = 'tcargos'
			lamatriz(11,2) = alltrim(str(claro.tcargos,12,4))
			lamatriz(12,1) = 'pcargos'
			lamatriz(12,2) = alltrim(str(claro.pcargos,12,4))
			lamatriz(13,1) = 'minaire'
			lamatriz(13,2) = alltrim(str(claro.minaire,12,4))
			lamatriz(14,1) = 'minaireex'
			lamatriz(14,2) = alltrim(str(claro.minaireex,12,4))
			lamatriz(15,1) = 'impaire'
			lamatriz(15,2) = alltrim(str(claro.impaire,12,4))
			lamatriz(16,1) = 'paire'
			lamatriz(16,2) = alltrim(str(claro.paire,12,4))
			lamatriz(17,1) = 'taire'
			lamatriz(17,2) = alltrim(str(claro.taire,12,4))
			lamatriz(18,1) = 'minldn'
			lamatriz(18,2) = alltrim(str(claro.minldn,12,4))
			lamatriz(19,1) = 'impldn'
			lamatriz(19,2) = alltrim(str(claro.impldn,12,4))
			lamatriz(20,1) = 'pldn'
			lamatriz(20,2) = alltrim(str(claro.pldn,12,4))
			lamatriz(21,1) = 'tldn'
			lamatriz(21,2) = alltrim(str(claro.tldn,12,4))
			lamatriz(22,1) = 'minldi'
			lamatriz(22,2) = alltrim(str(claro.minldi,12,4))
			lamatriz(23,1) = 'impldi'
			lamatriz(23,2) = alltrim(str(claro.impldi,12,4))
			lamatriz(24,1) = 'pldi'
			lamatriz(24,2) = alltrim(str(claro.pldi,12,4))
			lamatriz(25,1) = 'tldi'
			lamatriz(25,2) = alltrim(str(claro.tldi,12,4))
			lamatriz(26,1) = 'minldim'
			lamatriz(26,2) = alltrim(str(claro.minldim,12,4))
			lamatriz(27,1) = 'impldim'
			lamatriz(27,2) = alltrim(str(claro.impldim,12,4))
			lamatriz(28,1) = 'pldim'
			lamatriz(28,2) = alltrim(str(claro.pldim,12,4))
			lamatriz(29,1) = 'tldim'
			lamatriz(29,2) = alltrim(str(claro.tldim,12,4))
			lamatriz(30,1) = 'datau'
			lamatriz(30,2) = alltrim(str(claro.datau,12,4))
			lamatriz(31,1) = 'dataimp'
			lamatriz(31,2) = alltrim(str(claro.dataimp,12,4))
			lamatriz(32,1) = 'pdata'
			lamatriz(32,2) = alltrim(str(claro.pdata,12,4))
			lamatriz(33,1) = 'tdata'
			lamatriz(33,2) = alltrim(str(claro.tdata,12,4))
			lamatriz(34,1) = 'impeq'
			lamatriz(34,2) = alltrim(str(claro.impeq,12,4))
			lamatriz(35,1) = 'peq'
			lamatriz(35,2) = alltrim(str(claro.peq,12,4))
			lamatriz(36,1) = 'teq'
			lamatriz(36,2) = alltrim(str(claro.teq,12,4))
			lamatriz(37,1) = 'varios'
			lamatriz(37,2) = alltrim(str(claro.varios,12,4))
			lamatriz(38,1) = 'pvarios'
			lamatriz(38,2) = alltrim(str(claro.pvarios,12,4))
			lamatriz(39,1) = 'tvarios'
			lamatriz(39,2) = alltrim(str(claro.tvarios,12,4))
			lamatriz(40,1) = 'tclaro'
			lamatriz(40,2) = alltrim(str(claro.tclaro,12,4))
			lamatriz(41,1) = 'total'
			lamatriz(41,2) = alltrim(str(claro.total,12,4))
			lamatriz(42,1) = 'idclaro'
			lamatriz(42,2) = '0'
			lamatriz(43,1) = 'idimportap'
			lamatriz(43,2) = alltrim(STR(p_idimportap))

			p_tabla     = 'factclaro'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Claro ",0+48+0,"Error")
			ENDIF 
			
			SELE claro
			SKIP 
						
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT claro 
	USE IN claro 
	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap,'consultaclaro',.T.)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
*/ && 3- Exporta los datos de mediciones de la ultima facturaci�n
	IF p_func = 3 THEN && Exporta los datos de la ultima facturacion a una tabla .dbf

		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		sqlmatriz(1)=" select MAX(idimportap) as idimportap from factclaro "
		verror=sqlrun(vconeccionF,"maxclaro_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion del Maximo idimportap ... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN 0
		ENDIF
		v_ultidimportap = maxclaro_sql.idimportap
		USE IN maxclaro_sql
		
		sqlmatriz(1)=" select * from factclaro where idimportap ="+STR(v_ultidimportap)
		verror=sqlrun(vconeccionF,"claroexpo_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de Claro... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN 0
		ENDIF
		=abreycierracon(vconeccionF,"")	


		SELECT bocanumero as telefono, usuario , plan , abono , pabono , tabono , impserv , pserv , tserv , cargos , pcargos , tcargos , ;
					minaire , minaireex , impaire , paire , taire , minldn , impldn , pldn , tldn , minldi , impldi , pldi , tldi , ;
					minldim , impldim , pldim , tldim , datau , dataimp , pdata , tdata , impeq , peq , teq , ;
					varios , pvarios , tvarios , tclaro, total  FROM claroexpo_sql INTO TABLE claroexpo 
					
		USE IN claroexpo_sql
		USE IN claroexpo 
	ENDIF && 2- Exporta los datos de mediciones de la ultima facturaci�n
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC 

*/------------------------------------------------------------------------------------------------------------
*/ FINAL Carga Archivo CLARO Telefonia Celular
*/------------------------------------------------------------------------------------------------------------



*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Mediciones de Consumo de Servicios Generales
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaMServicios
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
	
	
*/**************************************************************
	IF p_func = -1 THEN  &&  Eliminacion de Registros
		p_func = fdeltablas("mservicios",p_idimportap)
		RETURN p_func 
	ENDIF 
*/**************************************************************
	
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Medicion de Servicios -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		sqlmatriz(1)=" select * from mservicios where idimportap ="+STR(p_idimportap)
		verror=sqlrun(vconeccionF,"mservicios_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de Mediciones de Servicios... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN 0
		ENDIF

	
		SELECT mservicios_sql
		GO TOP 
		if !EOF() then
			boton=messagebox("  Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"� DESEA SOBREESCRIBIRLOS ?",52,"Informaci�n del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from mservicios where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de datos de Mediciones de Servicios ... ",0+48+0,"Error")
					=abreycierracon(vconeccionF,"")	
				    RETURN 0
				ENDIF
			else
				=abreycierracon(vconeccionF,"")	
				RETURN 0
			endif
		endif


		*/ obtengo las bocas de servicios para las cuales cargare los movimientos
		*/------------------------------------------------------------------------
		sqlmatriz(1)=" select p.*, a.servicio from importadatosp p left join importadatos a on a.idimporta= p.idimporta where idimportap ="+STR(p_idimportap)
		verror=sqlrun(vconeccionF,"importa")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion Registro de Importa Datos... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN 0
		ENDIF
		SELECT importa
		GO TOP 
		IF importa.servicio <= 0 THEN 
		    MESSAGEBOX("No se Pueden Generar los Datos , No se ha asignado un Servicio para la Importaci�n "+CHR(13)+" Por favor se requiere fijar el Servicio para identificar las Mediciones ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
			USE IN importa 
		    RETURN 0
		ENDIF 
		
		sqlmatriz(1)=" select h.entidad, h.servicio, h.cuenta, h.apellido, h.nombre, b.* from bocaservicios b "
		sqlmatriz(2)=" left join entidadesh h on h.identidadh = b.identidadh "
		sqlmatriz(3)=" where b.habilitado ='S' and h.servicio ="+STR(importa.servicio)
		verror=sqlrun(vconeccionF,"bocaserv_sql")
		IF verror=.f.  
		    MESSAGEBOX(" ... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		ENDIF
		SELECT bocaserv_sql
		SELECT *, 100000000.000 as manterior, 100000000.000 as mactual,100000000.000 as consextra, 100000000.000 as consumo, 100000000 as idimportap  FROM bocaserv_sql INTO TABLE mservicios
		replace ALL manterior WITH 0, mactual WITH 0, consumo WITH 0, idimportap WITH p_idimportap, consextra WITH 0
		
		*/------------------------------------------------------------------------------------

		*/ Obtengo las mediciones anteriores para cargarlas como iniciales del periodo actual
		*/ ------------------------------------------------------------------------------------
		sqlmatriz(1)=" select ifnull(MAX(p.idimportap),0) as maxidant, ifnull(i.servicio,0) as servicio from importadatosp p "
		sqlmatriz(2)=" left join importadatos i on i.idimporta = p.idimporta "
		sqlmatriz(3)=" where p.idimportap < "+STR(p_idimportap)+" and  i.servicio = "+STR(importa.servicio)
		verror=sqlrun(vconeccionF,"maxidante_sql")
		IF verror=.f.  THEN 
		    MESSAGEBOX(" ... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		ENDIF
		SELECT maxidante_sql
		vmaxidimpo = maxidante_sql.maxidant
		IF TYPE('vmaxidimpo')='C' THEN 
			vmaxidimpo = VAL(vmaxidimpo)
		ENDIF 
		
	
		sqlmatriz(1)=" select bocanumero, manterior, mactual, consextra, consumo, idimportap "
		sqlmatriz(4)=" from mservicios where idimportap = "+ALLTRIM(STR(vmaxidimpo))
		verror=sqlrun(vconeccionF,"mserviant_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de Mediciones Anteriores... ",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN 0
		ENDIF
		SELECT * FROM mserviant_sql INTO TABLE mserviant
		USE IN mserviant_sql 
		SELECT mserviant
		ALTER table mserviant alter COLUMN bocanumero c(50)
		INDEX on ALLTRIM(bocanumero) TAG bocanumero
		GO TOP 
	
		USE IN maxidante_sql 
		*/-------------------------------------------------------------------------------------------		
		
		*/ cargo la medicion anterior para aquellos que existan en la facturacion anterior
		*/-------------------------------------------------------------------------------
		SELECT mservicios
		SET RELATION TO ALLTRIM(bocanumero) INTO mserviant 
		GO TOP 
		replace ALL manterior WITH mserviant.mactual, mactual WITH mserviant.mactual 
		

		DIMENSION lamatriz(8,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		SELECT mservicios
		GO TOP 
		
		DO WHILE !EOF()
			lamatriz(1,1) = 'bocanumero'
			lamatriz(1,2) = "'"+alltrim(mservicios.bocanumero)+"'"
			lamatriz(2,1) = 'manterior'
			lamatriz(2,2) = "'"+alltrim(str(mservicios.manterior,12,4))+"'"
			lamatriz(3,1) = 'mactual'
			lamatriz(3,2) = "'"+alltrim(str(mservicios.mactual,12,4))+"'"
			lamatriz(4,1) = 'consextra'
			lamatriz(4,2) = alltrim(str(mservicios.consextra,12,4))
			lamatriz(5,1) = 'consumo'
			lamatriz(5,2) = alltrim(str(mservicios.consumo,12,4))
			lamatriz(6,1) = 'idmservi'
			lamatriz(6,2) = '0'
			lamatriz(7,1) = 'idimportap'
			lamatriz(7,2) = alltrim(STR(p_idimportap))
			lamatriz(8,1) = 'idbocaser'
			lamatriz(8,2) = alltrim(str(mservicios.idbocaser))

			p_tabla     = 'mservicios'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Servicios ",0+48+0,"Error")
			ENDIF 
			
			SELE mservicios
			SKIP 
						
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT mservicios 
	USE IN mservicios 
	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap,'consultamservicios',.T.)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC 

*/------------------------------------------------------------------------------------------------------------
*/ FINAL Carga de Mediciones de Consumo de Servicios Generales
*/------------------------------------------------------------------------------------------------------------


*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Cablemodems FlowDat
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaCablemodem
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
		p_func = fdeltablas("cablemodems",p_idimportap)
		RETURN p_func 
	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Cablemodems  -
		p_archivo = alltrim(p_archivo)
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			RETURN 0
		ENDIF
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		sqlmatriz(1)=" select * from cablemodems where idimportap ="+STR(p_idimportap)
		verror=sqlrun(vconeccionF,"cablem_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de Cablemodems... ",0+48+0,"Error")
		    RETURN 
		ENDIF

		SELECT cablem_sql
		GO TOP 
		if !EOF() then
			boton=messagebox("   Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"� DESEA SOBREESCRIBIRLOS ?",52,"Informaci�n del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from cablemodems where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de datos de Cablemodems... ",0+48+0,"Error")
				    RETURN 
				ENDIF
			else
				RETURN
			endif
		endif

	
		if file(".\cablemodems.dbf") THEN
			if used("cablemodems") then
				sele cablemodems
				use
			endif
			DELETE FILE .\cablemodems.dbf
		endif


		CREATE TABLE cablemodems (campo1 c(40), campo2 c(40), campo3 c(40),  ;
				campo4 c(40), campo5 c(40), campo6 c(40), campo7 c(40), campo8 c(40), ;
				campo9 c(40), campo10 c(40), campo11 c(40), campo12 c(40), campo13 c(40), ;
				campo14 c(40), campo15 c(40), campo16 c(40), campo17 c(40), campo18 c(40), ;
				campo19 c(40), campo20 c(40), campo21 c(40), campo22 c(40), campo23 c(40), ;
				campo24 c(40), campo25 c(40), campo26 c(40), campo27 c(40), campo28 c(40), ;
				campo29 c(40), campo30 c(40), campo31 c(40), campo32 c(40), campo33 c(40), ;
				campo34 c(40), campo35 c(40))
		
		SELECT cablemodems
		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
		&eje

		DIMENSION lamatriz(33,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		GO TOP 
		DO WHILE !EOF()
			lamatriz(1,1) = 'bocanumero'
			lamatriz(1,2) = "'"+ALLTRIM(cablemodems.campo5)+"'"
			lamatriz(2,1) = 'codigo'
			lamatriz(2,2) = "'"+ALLTRIM(cablemodems.campo3)+"'"
			lamatriz(3,1) = 'usuario'
			lamatriz(3,2) = "'"+ALLTRIM(cablemodems.campo4)+"'"
			lamatriz(4,1) = 'estado'
			lamatriz(4,2) = "'"+ALLTRIM(cablemodems.campo6)+"'"
			lamatriz(5,1) = 'perfil'
			lamatriz(5,2) = "'"+ALLTRIM(cablemodems.campo7)+"'"
			lamatriz(6,1) = 'estadocm'
			lamatriz(6,2) = "'"+ALLTRIM(cablemodems.campo8)+"'"
			lamatriz(7,1) = 'txrxpower'
			lamatriz(7,2) = "'"+ALLTRIM(cablemodems.campo9)+"'"
			lamatriz(8,1) = 'txpower'
			lamatriz(8,2) = "'"+ALLTRIM(cablemodems.campo10)+"'"
			lamatriz(9,1) = 'rxpower'
			lamatriz(9,2) = "'"+ALLTRIM(cablemodems.campo11)+"'"
			lamatriz(10,1) = 'snr'
			lamatriz(10,2) = "'"+ALLTRIM(cablemodems.campo12)+"'"
			lamatriz(11,1) = 'snrus'
			lamatriz(11,2) = "'"+ALLTRIM(cablemodems.campo13)+"'"
			lamatriz(12,1) = 'download'
			lamatriz(12,2) = "'"+ALLTRIM(cablemodems.campo14)+"'"
			lamatriz(13,1) = 'upload'
			lamatriz(13,2) = "'"+ALLTRIM(cablemodems.campo15)+"'"
			lamatriz(14,1) = 'response'
			lamatriz(14,2) = "'"+ALLTRIM(cablemodems.campo16)+"'"
			lamatriz(15,1) = 'ciudadin'
			lamatriz(15,2) = "'"+ALLTRIM(cablemodems.campo17)+"'"
			lamatriz(16,1) = 'direccin'
			lamatriz(16,2) = "'"+ALLTRIM(cablemodems.campo18)+"'"
			lamatriz(17,1) = 'fcreacion'
			lamatriz(17,2) = "'"+ALLTRIM(cablemodems.campo19)+"'"
			lamatriz(18,1) = 'etiqueta'
			lamatriz(18,2) = "'"+ALLTRIM(cablemodems.campo20)+"'"
			lamatriz(19,1) = 'ipstats'
			lamatriz(19,2) = "'"+ALLTRIM(cablemodems.campo22)+"'"
			lamatriz(20,1) = 'ipcm'
			lamatriz(20,2) = "'"+ALLTRIM(cablemodems.campo23)+"'"
			lamatriz(21,1) = 'ipcpe'
			lamatriz(21,2) = "'"+ALLTRIM(cablemodems.campo24)+"'"
			lamatriz(22,1) = 'ipmta'
			lamatriz(22,2) = "'"+ALLTRIM(cablemodems.campo25)+"'"
			lamatriz(23,1) = 'nodo'
			lamatriz(23,2) = "'"+ALLTRIM(cablemodems.campo26)+"'"
			lamatriz(24,1) = 'modelocm'
			lamatriz(24,2) = "'"+ALLTRIM(cablemodems.campo27)+"'"
			lamatriz(25,1) = 'gestionid'
			lamatriz(25,2) = "'"+ALLTRIM(cablemodems.campo29)+"'"
			lamatriz(26,1) = 'emailcli'
			lamatriz(26,2) = "'"+ALLTRIM(cablemodems.campo30)+"'"
			lamatriz(27,1) = 'direccli'
			lamatriz(27,2) = "'"+ALLTRIM(cablemodems.campo31)+"'"
			lamatriz(28,1) = 'ciudadcli'
			lamatriz(28,2) = "'"+ALLTRIM(cablemodems.campo32)+"'"
			lamatriz(29,1) = 'telefono'
			lamatriz(29,2) = "'"+ALLTRIM(cablemodems.campo33)+"'"
			lamatriz(30,1) = 'downidx'
			lamatriz(30,2) = "'"+ALLTRIM(cablemodems.campo34)+"'"
			lamatriz(31,1) = 'upidx'
			lamatriz(31,2) = "'"+ALLTRIM(cablemodems.campo35)+"'"
			lamatriz(32,1) = 'idcablem'
			lamatriz(32,2) = '0'
			lamatriz(33,1) = 'idimportap'
			lamatriz(33,2) =  alltrim(STR(p_idimportap))

			p_tabla     = 'cablemodems'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Cablemodems ",0+48+0,"Error")
			ENDIF 
			
			SELECT cablemodems
			SKIP 					
		ENDDO 
	
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	=FEtiquetasCM(p_idimportap)
	 
	ENDIF 	&& 1- Carga de Archivo de Telefon�a -
*/**************************************************************
*/**************************************************************

*/ && 2- Visualiza Datos de Telefon�a 

	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap)	
	ENDIF && 2- Visualiza Datos de Telefon�a -
	
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC 


*******************************************************


*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Carga de Cablemodems FlowDat
*/------------------------------------------------------------------------------------------------------------


*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Entidades
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaEntidades
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Entidades -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	


		if file(".\entidadescar.dbf") THEN
			if used("entidadescar") then
				sele entidadescar
				use
			endif
			DELETE FILE .\entidadescar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\entidadescar FREE (entidad I, apellido C(100), nombre c(100), cargo C(100), compania C(100), cuit C(13), direccion C(100), ;
					localidad C(10), iva I,fechaalta C(8), telefono C(50), cp C(50), fax C(50), ;
					email C(254), web C(254), dni I, tipodoc C(3),  ;
					fechanac C(8), idafiptipd I, credito n(12,2))			
					
		SELECT entidadescar 
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		COUNT TO v_registros 
		IF v_registros > 0 THEN 
			*Elimino las Entidades que tenga el sistema
			*La carga debe hacerce con la tabla vacia
			sqlmatriz(1)=" delete from entidades "
			verror=sqlrun(vconeccionF,"entidad")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Entidades... ",0+48+0,"Error")
			    RETURN 
			ENDIF		
		ENDIF 
		
		SELECT entidadescar
		DIMENSION lamatriz(19,2)
		DIMENSION lamatrizcr(5,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		GO TOP 
		DO WHILE !EOF()
			lamatriz(1,1) = 'entidad'
			lamatriz(1,2) = ALLTRIM(STR(entidadescar.entidad))
			lamatriz(2,1) = 'apellido'
			lamatriz(2,2) = "'"+ALLTRIM(entidadescar.apellido)+"'"
			lamatriz(3,1) = 'nombre'
			lamatriz(3,2) = "'"+ALLTRIM(entidadescar.nombre)+"'"
			lamatriz(4,1) = 'cargo'
			lamatriz(4,2) = "'"+ALLTRIM(entidadescar.cargo)+"'"
			lamatriz(5,1) = 'compania'
			lamatriz(5,2) = "'"+ALLTRIM(entidadescar.compania)+"'"
			lamatriz(6,1) = 'cuit'
			lamatriz(6,2) = "'"+ALLTRIM(entidadescar.cuit)+"'"
			lamatriz(7,1) = 'direccion'
			lamatriz(7,2) = "'"+ALLTRIM(entidadescar.direccion)+"'"
			lamatriz(8,1) = 'localidad'
			lamatriz(8,2) = "'"+ALLTRIM(entidadescar.localidad)+"'"
			lamatriz(9,1) = 'fechaalta'
			lamatriz(9,2) = "'"+ALLTRIM(entidadescar.fechaalta)+"'"
			lamatriz(10,1) = 'telefono'
			lamatriz(10,2) = "'"+ALLTRIM(entidadescar.telefono)+"'"
			lamatriz(11,1) = 'cp'
			lamatriz(11,2) = "'"+ALLTRIM(entidadescar.cp)+"'"
			lamatriz(12,1) = 'fax'
			lamatriz(12,2) = "'"+ALLTRIM(entidadescar.fax)+"'"
			lamatriz(13,1) = 'email'
			lamatriz(13,2) = "'"+ALLTRIM(entidadescar.email)+"'"
			lamatriz(14,1) = 'web'
			lamatriz(14,2) = "'"+ALLTRIM(entidadescar.web)+"'"
			lamatriz(15,1) = 'dni'
			lamatriz(15,2) = ALLTRIM(STR(entidadescar.dni))
			lamatriz(16,1) = 'tipodoc'
			lamatriz(16,2) = "'"+ALLTRIM(entidadescar.tipodoc)+"'"
			lamatriz(17,1) = 'iva'
			lamatriz(17,2) = ALLTRIM(STR(entidadescar.iva))
			lamatriz(18,1) = 'fechanac'
			lamatriz(18,2) = "'"+ALLTRIM(entidadescar.fechanac)+"'"
			lamatriz(19,1) = 'idafiptipod'
			lamatriz(19,2) = ALLTRIM(STR(entidadescar.idafiptipd))
			

			p_tabla     = 'entidades'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Entidades ",0+48+0,"Error")
			ENDIF 
			
			IF entidadescar.credito > 0 THEN 
				lamatrizcr(1,1) = 'entidad'
				lamatrizcr(1,2) = ALLTRIM(STR(entidadescar.entidad))
				lamatrizcr(2,1) = 'fecha'
				lamatrizcr(2,2) = "'"+DTOS(DATE())+"'"
				lamatrizcr(3,1) = 'importe'
				lamatrizcr(3,2) = ALLTRIM(STR(entidadescar.credito,12,2))
				lamatrizcr(4,1) = 'autorizo'
				lamatrizcr(4,2) = "'"+ALLTRIM(_SYSUSUARIO)+"'"
				lamatrizcr(5,1) = 'identidadcr'
				lamatrizcr(5,2) = "0"

				p_tabla     = 'entidadescr'
				p_matriz    = 'lamatrizcr'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Creditos de Entidades ",0+48+0,"Error")
				ENDIF 

			ENDIF 
			
			SELECT entidadescar
			SKIP 					
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	RELEASE lamatriz
	RELEASE lamatrizcr
	SELECT entidadescar
	USE IN entidadescar
	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
	*	=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Carga de Sub-Entidades
*/------------------------------------------------------------------------------------------------------------


*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Sub-Entidades - Cuentas
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaSubEntidades
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Entidades -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	


		if file(".\entidadeshcar.dbf") THEN
			if used("entidadeshcar") then
				sele entidadeshcar
				use
			endif
			DELETE FILE .\entidadeshcar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\entidadeshcar FREE (entidad I,servicios I, cuenta I,  apellido C(100), nombre c(100), cargo C(100), compania C(100), cuit C(13), direccion C(100), ;
					localidad C(10), iva I, fechaalta C(8), telefono C(50), cp C(50), fax C(50), ;
					email C(254), dni I, tipodoc C(3),  ;
					fechanac C(8), ruta1 I, folio1 I, ruta2 I, folio2 I, identidadh I, idafiptipd I, bocaservi c(50) )			
					
		SELECT entidadeshcar 
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje
		replace ALL identidadh WITH RECNO()

		COUNT TO v_registros 
		IF v_registros > 0 THEN 
			*Elimino las subcuentas que tenga el sistema
			*La carga debe hacerce con la tabla vacia
			sqlmatriz(1)=" delete from entidadesh "
			verror=sqlrun(vconeccionF,"entidadh")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Sub-Cuentas... ",0+48+0,"Error")
			    RETURN 
			ENDIF
	
			sqlmatriz(1)=" delete from bocaservicios "
			verror=sqlrun(vconeccionF,"bocaser")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Bocas de Servicios... ",0+48+0,"Error")
			    RETURN 
			ENDIF

			sqlmatriz(1)=" delete from entidadesd "
			verror=sqlrun(vconeccionF,"entidadd")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Detalle de Sub-Cuentas... ",0+48+0,"Error")
			    RETURN 
			ENDIF
			
		ENDIF 		
		SELECT entidadeshcar

		DIMENSION lamatriz(25,2)
		DIMENSION lamatriz2(12,2)
		
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		GO TOP 
		DO WHILE !EOF()
			lamatriz(1,1) = 'entidad'
			lamatriz(1,2) = ALLTRIM(STR(entidadeshcar.entidad))
			lamatriz(2,1) = 'servicio'
			lamatriz(2,2) = ALLTRIM(STR(entidadeshcar.servicios))
			lamatriz(3,1) = 'Cuenta'
			lamatriz(3,2) = ALLTRIM(STR(entidadeshcar.cuenta))
			lamatriz(4,1) = 'apellido'
			lamatriz(4,2) = "'"+ALLTRIM(entidadeshcar.apellido)+"'"
			lamatriz(5,1) = 'nombre'
			lamatriz(5,2) = "'"+ALLTRIM(entidadeshcar.nombre)+"'"
			lamatriz(6,1) = 'cargo'
			lamatriz(6,2) = "'"+ALLTRIM(entidadeshcar.cargo)+"'"
			lamatriz(7,1) = 'compania'
			lamatriz(7,2) = "'"+ALLTRIM(entidadeshcar.compania)+"'"
			lamatriz(8,1) = 'cuit'
			lamatriz(8,2) = "'"+ALLTRIM(entidadeshcar.cuit)+"'"
			lamatriz(9,1) = 'direccion'
			lamatriz(9,2) = "'"+ALLTRIM(entidadeshcar.direccion)+"'"
			lamatriz(10,1) = 'localidad'
			lamatriz(10,2) = "'"+ALLTRIM(entidadeshcar.localidad)+"'"
			lamatriz(11,1) = 'fechaalta'
			lamatriz(11,2) = "'"+ALLTRIM(entidadeshcar.fechaalta)+"'"
			lamatriz(12,1) = 'telefono'
			lamatriz(12,2) = "'"+ALLTRIM(entidadeshcar.telefono)+"'"
			lamatriz(13,1) = 'cp'
			lamatriz(13,2) = "'"+ALLTRIM(entidadeshcar.cp)+"'"
			lamatriz(14,1) = 'fax'
			lamatriz(14,2) = "'"+ALLTRIM(entidadeshcar.fax)+"'"
			lamatriz(15,1) = 'email'
			lamatriz(15,2) = "'"+ALLTRIM(entidadeshcar.email)+"'"
			lamatriz(16,1) = 'dni'
			lamatriz(16,2) = ALLTRIM(STR(entidadeshcar.dni))
			lamatriz(17,1) = 'tipodoc'
			lamatriz(17,2) = "'"+ALLTRIM(entidadeshcar.tipodoc)+"'"
			lamatriz(18,1) = 'iva'
			lamatriz(18,2) = ALLTRIM(STR(entidadeshcar.iva))
			lamatriz(19,1) = 'fechanac'
			lamatriz(19,2) = "'"+ALLTRIM(entidadeshcar.fechanac)+"'"
			lamatriz(20,1) = 'ruta1'
			lamatriz(20,2) = ALLTRIM(STR(entidadeshcar.ruta1))
			lamatriz(21,1) = 'folio1'
			lamatriz(21,2) = ALLTRIM(STR(entidadeshcar.folio1))
			lamatriz(22,1) = 'ruta2'
			lamatriz(22,2) = ALLTRIM(STR(entidadeshcar.ruta2))
			lamatriz(23,1) = 'folio2'
			lamatriz(23,2) = ALLTRIM(STR(entidadeshcar.folio2))
			lamatriz(24,1) = 'identidadh'
			lamatriz(24,2) = ALLTRIM(STR(entidadeshcar.identidadh))
			lamatriz(25,1) = 'idafiptipod'
			lamatriz(25,2) = ALLTRIM(STR(entidadeshcar.idafiptipd))
			

			p_tabla     = 'entidadesh'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Sub-Cuentas ",0+48+0,"Error")
			ENDIF 
			
			**BOCAS DE SERVICIOS
			IF !(ALLTRIM(entidadeshcar.bocaservi) = '0') AND !EMPTY(ALLTRIM(entidadeshcar.bocaservi)) THEN 
			
				lamatriz2(1,1) = 'idbocaser'
				lamatriz2(1,2) = "0"
				lamatriz2(2,1) = 'identidadh'
				lamatriz2(2,2) = ALLTRIM(STR(entidadeshcar.identidadh))
				lamatriz2(3,1) = 'bocanumero'
				lamatriz2(3,2) = "'"+ALLTRIM(entidadeshcar.bocaservi)+"'"
				lamatriz2(4,1) = 'ruta1'
				lamatriz2(4,2) = ALLTRIM(STR(entidadeshcar.ruta1))
				lamatriz2(5,1) = 'folio1'
				lamatriz2(5,2) = ALLTRIM(STR(entidadeshcar.folio1))
				lamatriz2(6,1) = 'ruta2'
				lamatriz2(6,2) = ALLTRIM(STR(entidadeshcar.ruta2))
				lamatriz2(7,1) = 'folio2'
				lamatriz2(7,2) = ALLTRIM(STR(entidadeshcar.folio2))
				lamatriz2(8,1) = 'facturar'
				lamatriz2(8,2) = "'S'"
				lamatriz2(9,1) = 'habilitado'
				lamatriz2(9,2) = "'S'"
				lamatriz2(10,1) = 'direccion'
				lamatriz2(10,2) = "'"+ALLTRIM(entidadeshcar.direccion)+"'"
				lamatriz2(11,1) = 'ubicacion'
				lamatriz2(11,2) = "''"
				lamatriz2(12,1) = 'idtiposer'
				lamatriz2(12,2) = "1"
				

				p_tabla     = 'bocaservicios'
				p_matriz    = 'lamatriz2'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en importaci�n de Bocas de Servicios ",0+48+0,"Error")
				ENDIF 
				
			ENDIF 
			
			SELECT entidadeshcar
			SKIP 					
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT entidadeshcar
	USE IN entidadeshcar
	ENDIF 	&& 1- Carga de Archivo de Sub-Entidades -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
*		=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de Entidadesh -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Sub-Entidades - Cuentas
*/------------------------------------------------------------------------------------------------------------




*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Lineas
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaLineas
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Lineas -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	

		if file(".\lineascar.dbf") THEN
			if used("lineascar") then
				sele lineascar
				use
			endif
			DELETE FILE .\lineascar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\lineascar FREE (linea C(20), detalle C(254), codigoctac c(20), codigoctav C(20), margen N(13,4), codmin C(50), codmax C(50))			
					
		SELECT lineascar
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		COUNT TO v_registros 
		IF v_registros > 0 THEN 
			*Elimino las Lineas que tenga el sistema
			*La carga debe hacerce con la tabla vacia
			sqlmatriz(1)=" delete from lineas "
			verror=sqlrun(vconeccionF,"lineas")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Lineas... ",0+48+0,"Error")
			    RETURN 
			ENDIF
			sqlmatriz(1)=" delete from sublineas "
			verror=sqlrun(vconeccionF,"sublineas")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de SubLineas... ",0+48+0,"Error")
			    RETURN 
			ENDIF
			sqlmatriz(1)="alter table sublineas auto_increment = 1"
			verror=sqlrun(vconeccion,"modifauto")
			IF verror=.f.  
		    	MESSAGEBOX("Ha Ocurrido un Error el reseteo del valor de auto_increment de sublineas",0+48+0,"Eliminaci�n de Registros")
		    	RETURN -9
			ENDIF 

		ENDIF 		
		
		DIMENSION lamatriz(7,2)
		DIMENSION lamatriz1(3,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		GO TOP 
		DO WHILE !EOF()
			lamatriz(1,1) = 'linea'
			lamatriz(1,2) = "'"+ALLTRIM(lineascar.linea)+"'"
			lamatriz(2,1) = 'detalle'
			lamatriz(2,2) = "'"+ALLTRIM(lineascar.detalle)+"'"
			lamatriz(3,1) = 'codigoctac'
			lamatriz(3,2) = "'"+ALLTRIM(lineascar.codigoctac)+"'"
			lamatriz(4,1) = 'codigoctav'
			lamatriz(4,2) = "'"+ALLTRIM(lineascar.codigoctav)+"'"
			lamatriz(5,1) = 'margen'
			lamatriz(5,2) = ALLTRIM(STR(lineascar.margen))
			lamatriz(6,1) = 'codmin'
			lamatriz(6,2) = "'"+ALLTRIM(lineascar.codmin)+"'"
			lamatriz(7,1) = 'codmax'
			lamatriz(7,2) = "'"+ALLTRIM(lineascar.codmax)+"'"
			

			p_tabla     = 'lineas'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Lineas ",0+48+0,"Error")
			ENDIF 

			
			lamatriz1(1,1) = 'idsublinea'
			lamatriz1(1,2) = "0"
			lamatriz1(2,1) = 'linea'
			lamatriz1(2,2) = "'"+ALLTRIM(lineascar.linea)+"'"
			lamatriz1(3,1) = 'sublinea'
			lamatriz1(3,2) = "'"+ALLTRIM(lineascar.detalle)+"'"

			p_tabla     = 'sublineas'
			p_matriz    = 'lamatriz1'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Lineas ",0+48+0,"Error")
			ENDIF 
			
			
			SELECT lineascar
			SKIP 					
		ENDDO 
*/*/*/*/*/*/

	=abreycierracon(vconeccionF,"")	
		SELECT lineascar
		USE IN lineascar
		RELEASE lamatriz1
		RELEASE lamatriz
		MESSAGEBOX("Importaci�n de Lineas de Articulos Finalizada",0+64,"Importar Lineas de Articulos")
	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
*		=fconsutablas(p_idimportap,'lineascar',.T.)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Carga de Lineas
*/------------------------------------------------------------------------------------------------------------


*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Articulos con articulosimp,listaprecioh (solo para lista 1), articulospro
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaArticulos
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Articulos -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	

		if file(".\articuloscar.dbf") THEN
			if used("articuloscar") then
				sele articuloscar
				use
			endif
			DELETE FILE .\articuloscar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\articuloscar FREE (articulo C(50), detalle C(254), unidad C(200), abrevia C(50), codbarra C(100), costo n(13,4), linea C(20), ;
		ctrlstock C(1), observa C(254), ocultar C(1), stockmin N(13,4), desc1 N(13,4), desc2 N(13,4), desc3 N(13,4), desc4 N(13,4), desc5 N(13,4), moneda I, ;
		impuesto I, margen N(13,4),proveedor I,codigop C(50),idsublinea I)			
					
		SELECT articuloscar 
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		GO TOP 
		
		IF NOT EOF()
		
*!*				*** Borro las tablas que voy a ingresar ***
*!*				
*!*				*** Borro articulos ***
*!*				sqlmatriz(1)="delete from articulos "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla articulos ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF 
*!*				
*!*				*** Borro articulosimp ***
*!*				sqlmatriz(1)="delete from articulosimp "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla articulosimp ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF 
	


			*** Obtengo todas las condiciones Fiscales para Cargar los impuestos ***
			sqlmatriz(1)="select articulo from articulos"
			verror=sqlrun(vconeccion,"articulos_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Obtencion de los articulos existentes",0+48+0,"Eliminaci�n de Registros")
			    RETURN -9
			ENDIF
			
			
	
			*** Obtengo todas las condiciones Fiscales para Cargar los impuestos ***
			sqlmatriz(1)="select * from condfiscal "
			verror=sqlrun(vconeccion,"Cfiscal")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Obtencion de las Condiciones Fiscales ",0+48+0,"Eliminaci�n de Registros")
			    RETURN -9
			ENDIF 
					
					
*!*				*** Borro listaprecioh (lista 1) ***
*!*				sqlmatriz(1)="delete from listaprecioh where idlista = 1 "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla listaprecioh ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF
*!*				
*!*				*** Borro articulospro ***
*!*				sqlmatriz(1)="delete from articulospro "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla articulospro ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF 
			 
			v_idartimp = 0
			v_maximoArtiimp = 0
			*** Calulo el Maximo de listaprecioh ***
			sqlmatriz(1)="select MAX(idartimp) as maxi from articulosimp "
			verror=sqlrun(vconeccion,"maxarticulosimp")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en busqueda del maximo valor de articulosimp",0+48+0,"Eliminaci�n de Registros")
			    RETURN -9
			ELSE
				v_maximoArtiimp = IIF(ISNULL(maxarticulosimp.maxi)=.T.,0,maxarticulosimp.maxi)
				v_idartimp = v_maximoArtiimp 
				** Modifico el indice idlistah para que tome el maximo valor como el indice autoincremental **
*!*					sqlmatriz(1)="alter table listaprecioh auto_increment = "+ALLTRIM(STR(v_maximoListah ))
*!*					verror=sqlrun(vconeccion,"modifauto")
*!*					IF verror=.f.  
*!*				    	MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla listaprecioh(Error al modificar el autoincremental)",0+48+0,"Eliminaci�n de Registros")
*!*				    	RETURN -9
*!*					ENDIF 
			ENDIF 
					
							
		ENDIF 
	
	
		v_idartpro = 0
		*v_idlistah = v_maximoListah 
		v_fechaAct = ALLTRIM(DTOS(DATE()))

		DIMENSION lamatriz(18,2)
		DIMENSION lamatriz2(4,2)
		DIMENSION lamatriz3(6,2)
		DIMENSION lamatriz4(4,2)
		
		
		
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		
		SELECT * FROM articuloscar WHERE articulo NOT in (SELECT articulo FROM articulos_sql) INTO TABLE articuloscarF
		
		SELECT articuloscarF
		GO TOP 
		DO WHILE !EOF()
			
			
		
		*** Cargo el articulo en tabla articulos ***
			lamatriz(1,1) = 'articulo'
			lamatriz(1,2) = "'"+ALLTRIM(articuloscarF.articulo)+"'"
			lamatriz(2,1) = 'detalle'
			lamatriz(2,2) = "'"+ALLTRIM(articuloscarF.detalle)+"'"
			lamatriz(3,1) = 'unidad'
			lamatriz(3,2) = "'"+ALLTRIM(articuloscarF.unidad)+"'"
			lamatriz(4,1) = 'abrevia'
			lamatriz(4,2) = "'"+ALLTRIM(articuloscarF.abrevia)+"'"
			lamatriz(5,1) = 'codbarra'
			lamatriz(5,2) = "'"+ALLTRIM(articuloscarF.codbarra)+"'"
			lamatriz(6,1) = 'costo'
			lamatriz(6,2) = ALLTRIM(STR(articuloscarF.costo,13,2))
			lamatriz(7,1) = 'linea'
			lamatriz(7,2) = "'"+ALLTRIM(articuloscarF.linea)+"'"
			lamatriz(8,1) = 'ctrlstock'
			lamatriz(8,2) = "'"+ALLTRIM(articuloscarF.ctrlstock)+"'"
			lamatriz(9,1) = 'observa'
			lamatriz(9,2) = "'"+ALLTRIM(articuloscarF.observa)+"'"
			lamatriz(10,1) = 'ocultar'
			lamatriz(10,2) = "'"+ALLTRIM(articuloscarF.ocultar)+"'"
			lamatriz(11,1) = 'stockmin'
			lamatriz(11,2) = ALLTRIM(STR(articuloscarF.stockmin))
			lamatriz(12,1) = 'desc1'
			lamatriz(12,2) = ALLTRIM(STR(articuloscarF.desc1,13,2))
			lamatriz(13,1) = 'desc2'
			lamatriz(13,2) = ALLTRIM(STR(articuloscarF.desc2,13,2))
			lamatriz(14,1) = 'desc3'
			lamatriz(14,2) = ALLTRIM(STR(articuloscarF.desc3,13,2))
			lamatriz(15,1) = 'desc4'
			lamatriz(15,2) = ALLTRIM(STR(articuloscarF.desc4,13,2))
			lamatriz(16,1) = 'desc5'
			lamatriz(16,2) = ALLTRIM(STR(articuloscarF.desc5,13,2))
			lamatriz(17,1) = 'moneda'
			lamatriz(17,2) = ALLTRIM(STR(articuloscarF.moneda))
			lamatriz(18,1) = 'idsublinea'
			lamatriz(18,2) = ALLTRIM(STR(articuloscarF.idsublinea))

			p_tabla     = 'articulos'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos ",0+48+0,"Error")
			ELSE
				 *** Guardo el historial del costo del articulo ***
*				   guardaHistCostoArt(articuloscar.articulo, articuloscar.costo)

				 
				 SELECT Cfiscal
				 GO TOP 
				 DO while !EOF()
				*** Cargo el el impuesto del articulo en tabla articulosimp ***
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					
					v_idartimp = v_idartimp + 1
					lamatriz2(1,1)='idartimp'
					lamatriz2(1,2)= ALLTRIM(STR(v_idartimp))
					lamatriz2(2,1)='articulo'
					lamatriz2(2,2)="'"+ALLTRIM(articuloscarF.articulo)+"'"
					lamatriz2(3,1)='impuesto'
					lamatriz2(3,2)=ALLTRIM(STR(articuloscarF.impuesto))
					lamatriz2(4,1)='iva'
					lamatriz2(4,2)=ALLTRIM(STR(cfiscal.iva))
		
		
					p_tabla     = 'articulosimp'
					p_matriz    = 'lamatriz2'
					p_conexion  = vconeccionF
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos-Impuestos ",0+48+0,"Error")
					
					ENDIF 
				
					SELECT cfiscal
					SKIP 
				ENDDO 
				
			*** Cargo el margen del articulo en tabla listaprecioh ***
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					v_idlista	 = 1
					v_idlistah = 0
					v_fehcaAct 		= ALLTRIM(DTOS(DATE())+TIME())
							
					lamatriz3(1,1)='idlistah'
					lamatriz3(1,2)= ALLTRIM(STR(v_idlistah))
					lamatriz3(2,1)='idlista'
					lamatriz3(2,2)= ALLTRIM(STR(v_idlista))
					lamatriz3(3,1)='articulo'
					lamatriz3(3,2)="'"+ALLTRIM(articuloscarF.articulo)+"'"
					lamatriz3(4,1)='margen'
					lamatriz3(4,2)=ALLTRIM(STR(articuloscarF.margen,13,4))
					lamatriz3(5,1)='fechaalta'
					lamatriz3(5,2)="'"+ALLTRIM(v_fechaAct)+"'"
					lamatriz3(6,1)='fechaact'
					lamatriz3(6,2)= "'"+ALLTRIM(v_fehcaAct)+"'"
		
		
					p_tabla     = 'listaprecioh'
					p_matriz    = 'lamatriz3'
					p_conexion  = vconeccionF
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Lista de Precios ",0+48+0,"Error")
							
					ENDIF 
					
					
				*** Cargo el proveedor asociado al articulo y el codigo del proveedor en tabla articulosimp***
				IF articuloscarF.proveedor > 0 THEN
				 
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					
					v_idartpro = v_idartpro + 1
					lamatriz4(1,1)='idartpro'
					lamatriz4(1,2)= ALLTRIM(STR(v_idartpro))
					lamatriz4(2,1)='articulo'
					lamatriz4(2,2)="'"+ALLTRIM(articuloscarF.articulo)+"'"
					lamatriz4(3,1)='entidad'
					lamatriz4(3,2)=ALLTRIM(STR(articuloscarF.proveedor))
					lamatriz4(4,1)='codigop'
					lamatriz4(4,2)="'"+ALLTRIM(articuloscarF.codigop)+"'"	
		
					p_tabla     = 'articulospro'
					p_matriz    = 'lamatriz4'
					p_conexion  = vconeccionF
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos-Proveedor ",0+48+0,"Error")
					
					ENDIF 
					
				ENDIF 				
	
			ENDIF 
			
			SELECT articuloscarF
			SKIP 					
		ENDDO 
*/*/*/*/*/*/
		=abreycierracon(vconeccionF,"")
		SELECT articuloscar
		USE IN articuloscar
		SELECT articuloscarF
		USE IN articuloscarF
		RELEASE lamatriz
		RELEASE lamatriz2
		RELEASE lamatriz3
		RELEASE lamatriz4
		MESSAGEBOX("Importaci�n de Articulos Finalizada",0+64,"Importar  Articulos")

	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*!*	*/ && 2- Visualiza Datos de Claro
*!*		IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
*!*			=fconsutablas(p_idimportap,'articulos',.T.)
*!*		ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*!*	*/------------------------------------------------------------------------------------------------------------
*!*	*/------------------------------------------------------------------------------------------------------------
*!*	*/ Carga de Articulos con articulosimp,listaprecioh (solo para lista 1), articulospro
*!*	*/------------------------------------------------------------------------------------------------------------
*!*	FUNCTION CargaArticulos
*!*		PARAMETERS p_idimportap, p_archivo, p_func
*!*		IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
*!*			RETURN p_func
*!*		ENDIF 
*!*	*/**************************************************************

*!*		IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*	*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*	*!*			RETURN p_func 
*!*		

*!*		ENDIF 
*!*	*/**************************************************************
*!*		IF p_func = 1 then && 1- Carga de Archivo de Articulos -
*!*			p_archivo = alltrim(p_archivo)
*!*			vconeccionF=abreycierracon(0,_SYSSCHEMA)	

*!*			if file(".\articuloscar.dbf") THEN
*!*				if used("articuloscar") then
*!*					sele articuloscar
*!*					use
*!*				endif
*!*				DELETE FILE .\articuloscar.dbf
*!*			ENDIF
*!*			
*!*			if !file(p_archivo) THEN
*!*				=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
*!*				=abreycierracon(vconeccionF,"")	
*!*				RETURN 0
*!*			ENDIF

*!*			CREATE TABLE .\articuloscar FREE (articulo C(50), detalle C(254), unidad C(200), abrevia C(50), codbarra C(100), costo n(13,4), linea C(20), ;
*!*			ctrlstock C(1), observa C(254), ocultar C(1), stockmin N(13,4), desc1 N(13,4), desc2 N(13,4), desc3 N(13,4), desc4 N(13,4), desc5 N(13,4), moneda I, ;
*!*			impuesto I, margen N(13,4),proveedor I,codigop C(50),idsublinea I)			
*!*						
*!*			SELECT articuloscar 
*!*	*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
*!*	 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
*!*			&eje

*!*			GO TOP 
*!*			
*!*			IF NOT EOF()
*!*			
*!*				*** Borro las tablas que voy a ingresar ***
*!*				
*!*				*** Borro articulos ***
*!*				sqlmatriz(1)="delete from articulos "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla articulos ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF 
*!*				
*!*				*** Borro articulosimp ***
*!*				sqlmatriz(1)="delete from articulosimp "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla articulosimp ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF 
*!*		
*!*				*** Obtengo todas las condiciones Fiscales para Cargar los impuestos ***
*!*				sqlmatriz(1)="select * from condfiscal "
*!*				verror=sqlrun(vconeccion,"Cfiscal")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Obtencion de las Condiciones Fiscales ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF 
*!*						
*!*						
*!*				*** Borro listaprecioh (lista 1) ***
*!*				sqlmatriz(1)="delete from listaprecioh where idlista = 1 "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla listaprecioh ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF
*!*				
*!*				*** Borro articulospro ***
*!*				sqlmatriz(1)="delete from articulospro "
*!*				verror=sqlrun(vconeccion,"NoUso")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla articulospro ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ENDIF 
*!*				 
*!*				
*!*				v_maximoListah = 0
*!*				*** Calulo el Maximo de listaprecioh ***
*!*				sqlmatriz(1)="select MAX(idlistah) as maxi from listaprecioh  "
*!*				verror=sqlrun(vconeccion,"maxLIstah")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla listaprecioh ",0+48+0,"Eliminaci�n de Registros")
*!*				    RETURN -9
*!*				ELSE
*!*					v_maximoListah = IIF(ISNULL(maxLIstah.maxi)=.T.,0,maxLIstah.maxi)
*!*					v_maximoListah = v_maximoListah + 1
*!*					** Modifico el indice idlistah para que tome el maximo valor como el indice autoincremental **
*!*					sqlmatriz(1)="alter table listaprecioh auto_increment = "+ALLTRIM(STR(v_maximoListah ))
*!*					verror=sqlrun(vconeccion,"modifauto")
*!*					IF verror=.f.  
*!*				    	MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Registros de la tabla listaprecioh(Error al modificar el autoincremental)",0+48+0,"Eliminaci�n de Registros")
*!*				    	RETURN -9
*!*					ENDIF 
*!*				ENDIF 
*!*						
*!*								
*!*			ENDIF 
*!*		
*!*			

*!*			v_idartimp = 0
*!*			v_idartpro = 0
*!*			*v_idlistah = v_maximoListah 
*!*			v_fechaAct = ALLTRIM(DTOS(DATE()))

*!*			DIMENSION lamatriz(18,2)
*!*			DIMENSION lamatriz2(4,2)
*!*			DIMENSION lamatriz3(6,2)
*!*			DIMENSION lamatriz4(4,2)
*!*			
*!*			
*!*			
*!*			p_tipoope     = 'I'
*!*			p_condicion   = ''
*!*			v_titulo      = " EL ALTA "
*!*			
*!*			SELECT articuloscar 
*!*			GO TOP 
*!*			DO WHILE !EOF()
*!*			
*!*			*** Cargo el articulo en tabla articulos ***
*!*				lamatriz(1,1) = 'articulo'
*!*				lamatriz(1,2) = "'"+ALLTRIM(articuloscar.articulo)+"'"
*!*				lamatriz(2,1) = 'detalle'
*!*				lamatriz(2,2) = "'"+ALLTRIM(articuloscar.detalle)+"'"
*!*				lamatriz(3,1) = 'unidad'
*!*				lamatriz(3,2) = "'"+ALLTRIM(articuloscar.unidad)+"'"
*!*				lamatriz(4,1) = 'abrevia'
*!*				lamatriz(4,2) = "'"+ALLTRIM(articuloscar.abrevia)+"'"
*!*				lamatriz(5,1) = 'codbarra'
*!*				lamatriz(5,2) = "'"+ALLTRIM(articuloscar.codbarra)+"'"
*!*				lamatriz(6,1) = 'costo'
*!*				lamatriz(6,2) = ALLTRIM(STR(articuloscar.costo,13,2))
*!*				lamatriz(7,1) = 'linea'
*!*				lamatriz(7,2) = "'"+ALLTRIM(articuloscar.linea)+"'"
*!*				lamatriz(8,1) = 'ctrlstock'
*!*				lamatriz(8,2) = "'"+ALLTRIM(articuloscar.ctrlstock)+"'"
*!*				lamatriz(9,1) = 'observa'
*!*				lamatriz(9,2) = "'"+ALLTRIM(articuloscar.observa)+"'"
*!*				lamatriz(10,1) = 'ocultar'
*!*				lamatriz(10,2) = "'"+ALLTRIM(articuloscar.ocultar)+"'"
*!*				lamatriz(11,1) = 'stockmin'
*!*				lamatriz(11,2) = ALLTRIM(STR(articuloscar.stockmin))
*!*				lamatriz(12,1) = 'desc1'
*!*				lamatriz(12,2) = ALLTRIM(STR(articuloscar.desc1,13,2))
*!*				lamatriz(13,1) = 'desc2'
*!*				lamatriz(13,2) = ALLTRIM(STR(articuloscar.desc2,13,2))
*!*				lamatriz(14,1) = 'desc3'
*!*				lamatriz(14,2) = ALLTRIM(STR(articuloscar.desc3,13,2))
*!*				lamatriz(15,1) = 'desc4'
*!*				lamatriz(15,2) = ALLTRIM(STR(articuloscar.desc4,13,2))
*!*				lamatriz(16,1) = 'desc5'
*!*				lamatriz(16,2) = ALLTRIM(STR(articuloscar.desc5,13,2))
*!*				lamatriz(17,1) = 'moneda'
*!*				lamatriz(17,2) = ALLTRIM(STR(articuloscar.moneda))
*!*				lamatriz(18,1) = 'idsublinea'
*!*				lamatriz(18,2) = ALLTRIM(STR(articuloscar.idsublinea))

*!*				p_tabla     = 'articulos'
*!*				p_matriz    = 'lamatriz'
*!*				p_conexion  = vconeccionF
*!*				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos ",0+48+0,"Error")
*!*				ELSE
*!*					 *** Guardo el historial del costo del articulo ***
*!*	*				   guardaHistCostoArt(articuloscar.articulo, articuloscar.costo)
*!*					 
*!*					 
*!*					 SELECT Cfiscal
*!*					 GO TOP 
*!*					 DO while !EOF()
*!*					*** Cargo el el impuesto del articulo en tabla articulosimp ***
*!*						p_tipoope     = 'I'
*!*						p_condicion   = ''
*!*						v_titulo      = " EL ALTA "
*!*						
*!*						v_idartimp = v_idartimp + 1
*!*						lamatriz2(1,1)='idartimp'
*!*						lamatriz2(1,2)= ALLTRIM(STR(v_idartimp))
*!*						lamatriz2(2,1)='articulo'
*!*						lamatriz2(2,2)="'"+ALLTRIM(articuloscar.articulo)+"'"
*!*						lamatriz2(3,1)='impuesto'
*!*						lamatriz2(3,2)=ALLTRIM(STR(articuloscar.impuesto))
*!*						lamatriz2(4,1)='iva'
*!*						lamatriz2(4,2)=ALLTRIM(STR(cfiscal.iva))
*!*			
*!*			
*!*						p_tabla     = 'articulosimp'
*!*						p_matriz    = 'lamatriz2'
*!*						p_conexion  = vconeccionF
*!*						IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*						    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos-Impuestos ",0+48+0,"Error")
*!*						
*!*						ENDIF 
*!*					
*!*						SELECT cfiscal
*!*						SKIP 
*!*					ENDDO 
*!*					
*!*				*** Cargo el margen del articulo en tabla listaprecioh ***
*!*						p_tipoope     = 'I'
*!*						p_condicion   = ''
*!*						v_titulo      = " EL ALTA "
*!*						v_idlista	 = 1
*!*						v_idlistah = 0
*!*						v_fehcaAct 		= ALLTRIM(DTOS(DATE())+TIME())
*!*								
*!*						lamatriz3(1,1)='idlistah'
*!*						lamatriz3(1,2)= ALLTRIM(STR(v_idlistah))
*!*						lamatriz3(2,1)='idlista'
*!*						lamatriz3(2,2)= ALLTRIM(STR(v_idlista))
*!*						lamatriz3(3,1)='articulo'
*!*						lamatriz3(3,2)="'"+ALLTRIM(articuloscar.articulo)+"'"
*!*						lamatriz3(4,1)='margen'
*!*						lamatriz3(4,2)=ALLTRIM(STR(articuloscar.margen,13,4))
*!*						lamatriz3(5,1)='fechaalta'
*!*						lamatriz3(5,2)="'"+ALLTRIM(v_fechaAct)+"'"
*!*						lamatriz3(6,1)='fechaact'
*!*						lamatriz3(6,2)= "'"+ALLTRIM(v_fehcaAct)+"'"
*!*			
*!*			
*!*						p_tabla     = 'listaprecioh'
*!*						p_matriz    = 'lamatriz3'
*!*						p_conexion  = vconeccionF
*!*						IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*						    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Lista de Precios ",0+48+0,"Error")
*!*								
*!*						ENDIF 
*!*						
*!*						
*!*					*** Cargo el proveedor asociado al articulo y el codigo del proveedor en tabla articulosimp***
*!*					IF articuloscar.proveedor > 0 THEN
*!*					 
*!*						p_tipoope     = 'I'
*!*						p_condicion   = ''
*!*						v_titulo      = " EL ALTA "
*!*						
*!*						v_idartpro = v_idartpro + 1
*!*						lamatriz4(1,1)='idartpro'
*!*						lamatriz4(1,2)= ALLTRIM(STR(v_idartpro))
*!*						lamatriz4(2,1)='articulo'
*!*						lamatriz4(2,2)="'"+ALLTRIM(articuloscar.articulo)+"'"
*!*						lamatriz4(3,1)='entidad'
*!*						lamatriz4(3,2)=ALLTRIM(STR(articuloscar.proveedor))
*!*						lamatriz4(4,1)='codigop'
*!*						lamatriz4(4,2)="'"+ALLTRIM(articuloscar.codigop)+"'"	
*!*			
*!*						p_tabla     = 'articulospro'
*!*						p_matriz    = 'lamatriz4'
*!*						p_conexion  = vconeccionF
*!*						IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*						    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos-Proveedor ",0+48+0,"Error")
*!*						
*!*						ENDIF 
*!*						
*!*					ENDIF 				
*!*		
*!*				ENDIF 
*!*				
*!*				SELECT articuloscar
*!*				SKIP 					
*!*			ENDDO 
*!*	*/*/*/*/*/*/
*!*			=abreycierracon(vconeccionF,"")	
*!*			SELECT articuloscar
*!*			USE IN articuloscar
*!*			RELEASE lamatriz
*!*			RELEASE lamatriz2
*!*			RELEASE lamatriz3
*!*			RELEASE lamatriz4
*!*			MESSAGEBOX("Importaci�n de Articulos Finalizada",0+64,"Importar  Articulos")

*!*		ENDIF 	&& 1- Carga de Archivo de CPP -
*!*	*/**************************************************************
*!*	*/**************************************************************
*!*	*!*	*/ && 2- Visualiza Datos de Claro
*!*	*!*		IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
*!*	*!*			=fconsutablas(p_idimportap,'articulos',.T.)
*!*	*!*		ENDIF && 2- Visualiza Datos de CPP -
*!*	*/**************************************************************
*!*		lreto = p_func
*!*		RETURN lreto
*!*	ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Localidades
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaLocalidades
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Localidades y Provincias -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	


		if file(".\localidadescar.dbf") THEN
			if used("localidadescar") then
				sele localidadescar
				use
			endif
			DELETE FILE .\localidadescar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\localidadescar FREE ( localidad c(10), nombre C(200), cp c(50), provincia C(10), nprovincia C(60) )			
					
		SELECT localidadescar
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		COUNT TO v_registros 
		IF v_registros > 0 THEN 
			*Elimino las Entidades que tenga el sistema
			*La carga debe hacerce con la tabla vacia
			sqlmatriz(1)=" delete from localidades "
			verror=sqlrun(vconeccionF,"local")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de localidades... ",0+48+0,"Error")
			    RETURN 
			ENDIF	
			sqlmatriz(1)=" delete from provincias "
			verror=sqlrun(vconeccionF,"provi")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de provincias... ",0+48+0,"Error")
			    RETURN 
			ENDIF		
			
		ENDIF 
		
		SELECT localidadescar
		
		
		DIMENSION lamatriz(4,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		GO TOP 
		DO WHILE !EOF()
			lamatriz(1,1) = 'localidad'
			lamatriz(1,2) = "'"+ALLTRIM(localidadescar.localidad)+"'"
			lamatriz(2,1) = 'nombre'
			lamatriz(2,2) = "'"+ALLTRIM(localidadescar.nombre)+"'"
			lamatriz(3,1) = 'cp'
			lamatriz(3,2) = "'"+ALLTRIM(localidadescar.cp)+"'"
			lamatriz(4,1) = 'provincia'
			lamatriz(4,2) = "'"+ALLTRIM(localidadescar.provincia)+"'"

			p_tabla     = 'localidades'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Localidades ",0+48+0,"Error")
			ENDIF 
			
			SELECT localidadescar
			SKIP 					
		ENDDO 

		SET ENGINEBEHAVIOR 70
		SELECT provincia, nprovincia FROM localidadescar INTO CURSOR provinciascar GROUP BY provincia
		SET ENGINEBEHAVIOR 90 
		SELECT provinciascar
		
		DIMENSION lamatriz(3,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		GO TOP 
		DO WHILE !EOF()
			lamatriz(1,1) = 'provincia'
			lamatriz(1,2) = "'"+ALLTRIM(provinciascar.provincia)+"'"
			lamatriz(2,1) = 'nombre'
			lamatriz(2,2) = "'"+ALLTRIM(provinciascar.nprovincia)+"'"
			lamatriz(3,1) = 'pais'
			lamatriz(3,2) = "'01'"

			p_tabla     = 'provincias'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Provincias ",0+48+0,"Error")
			ENDIF 
			
			SELECT provinciascar
			SKIP 					
		ENDDO 
				
		
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT localidadescar
	USE IN localidadescar
	SELECT provinciascar
	USE IN provinciascar
	ENDIF 	&& 1- Carga de Archivo de Localidades -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
	*	=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Carga de CargaLocalidades
*/------------------------------------------------------------------------------------------------------------




*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Cuentas corrientes de clientes
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaCtaCteClientes
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Cuentas corrientes de Entidades -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	


		if file(".\ctasctesentcar.dbf") THEN
			if used("ctasctesentcar") then
				sele ctasctesentcar
				use
			endif
			DELETE FILE .\ctasctesentcar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\ctasctesentcar FREE ( entidad I, servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8), fechavenc1 c(8), fechavenc2 c(8), fechavenc3 c(8) )			
					
		SELECT ctasctesentcar
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

*** AQUI AGREGAR LOGICA PARA CONSULTAR Y ELIMINAR FACTURAS SI ASI LO DESEA QUIEN IMPORTA ***
		rta =MESSAGEBOX("Desea Eliminar los Comprobantes Existentes en las Cuentas Corrientes",3+32+256,"Eliminar Comprobantes ")
		IF rta=6  THEN 
		
			*Elimino las Facturas 
			sqlmatriz(1)=" delete from facturas "
			verror=sqlrun(vconeccionF,"fc")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Facturas... ",0+48+0,"Error")
			    RETURN 0
			ENDIF	
			sqlmatriz(1)=" delete from detafactu "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)=" delete from facturasimp "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)=" delete from facturascta "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)=" delete from facturasd "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)="alter table facturasd auto_increment = 1 "
			verror=sqlrun(vconeccionF,"dfa")
			IF verror=.f.  
		    	MESSAGEBOX("Ha Ocurrido un Error en la Actualizaci�n del indice autoincremental de facturasd ",0+48+0,"Eliminaci�n de Registros")
		    	RETURN 0
			ENDIF 

			sqlmatriz(1)=" delete from facturasbser "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Bocas de Servicios de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)="alter table facturasbser auto_increment = 1 "
			verror=sqlrun(vconeccionF,"fab")
			IF verror=.f.  
		    	MESSAGEBOX("Ha Ocurrido un Error en la Actualizaci�n del indice autoincremental de facturasd ",0+48+0,"Eliminaci�n de Registros")
		    	RETURN 0
			ENDIF 

			
			sqlmatriz(1)=" delete from facturasfe "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)=" delete from facturasrec "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		

			sqlmatriz(1)=" delete from facturaopciones "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Opciones de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)="alter table facturaopciones auto_increment = 1 "
			verror=sqlrun(vconeccionF,"fab")
			IF verror=.f.  
		    	MESSAGEBOX("Ha Ocurrido un Error en la Actualizaci�n del indice autoincremental de facturaopciones ",0+48+0,"Eliminaci�n de Registros")
		    	RETURN 0
			ENDIF 
			
			sqlmatriz(1)=" delete from estadosreg where tabla = 'facturas' "
			verror=sqlrun(vconeccionF,"er")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		

			* Reinicio indices de tablas afectadas a facturas 
			sqlmatriz(1)=" update tablasidx set maxvalori = 0 where tabla = 'detafactu' or tabla = 'facturas' or tabla = 'facturascta' "
			verror=sqlrun(vconeccionF,"er")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		


		ELSE 
			IF rta = 2 THEN 
				USE IN ctasctesentcar 
				=abreycierracon(vconeccionF,"")	
				RETURN 0
			ENDIF  	
		ENDIF 
		
	
	SELECT ctasctesentcar
	GO TOP 
	
	
	v_ret = .F.
	
	DO FORM cargactacteentidad WITH "ctasctesentcar",.T. TO v_ret 
	
	IF v_ret = .F.
		RETURN 0
	ENDIF 
	
	
	
	SELECT ctasctesentcar
	GO TOP 
		
	
	IF LEN(_SYSCOMPACC) <> 8
		 MESSAGEBOX("No se ha especificado correctamente los comprobantes de ajuste de Cta Cte de Cliente",0+48+0,"Error")
		 RETURN 0
	ENDIF 

	SET ENGINEBEHAVIOR 70
	SELECT entidad,servicio,cuenta,fecha,numerocomp,SUM(monto) as monto,cuota,vtocta,fechavenc1,fechavenc2,fechavenc3 FROM ctasctesentcar GROUP BY entidad,numerocomp INTO TABLE ctasctesentcarA
	SET ENGINEBEHAVIOR 90
v_pventaIng = VAL(ALLTRIM(SUBSTR(_SYSCOMPACC,1,2)))
v_idcompIng = VAL(ALLTRIM(SUBSTR(_SYSCOMPACC,3,2)))
v_pventaEgr = VAL(ALLTRIM(SUBSTR(_SYSCOMPACC,5,2)))
v_idcompEgr = VAL(ALLTRIM(SUBSTR(_SYSCOMPACC,7,2)))

*** BUsco comprobantes de Ingreso y Egreso ***
sqlmatriz(1)="SELECT c.*,t.opera,v.pventa,v.puntov from comprobantes c left join compactiv v on c.idcomproba = v.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro "
sqlmatriz(2)=" WHERE c.ctacte = 'S' and t.opera <> 0 and ((c.idcomproba = "+ALLTRIM(STR(v_idcompIng))+" and v.pventa = "+ALLTRIM(STR(v_pventaIng))+") or ( c.idcomproba = "+ALLTRIM(STR(v_idcompEgr))+" and v.pventa = "+ALLTRIM(STR(v_pventaEgr))+"))"


verror=sqlrun(vconeccionF,"compIngEgr_sql")

IF verror=.f.  
    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de los comprobantes de Ingreso y Egreso ",0+48+0,"Error")
*** me desconecto	
	=abreycierracon(vconeccionF,"")
    RETURN 0
ENDIF 


SELECT compIngEgr_sql
GO TOP 

IF EOF()
	MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de los comprobantes de Ingreso y Egreso ",0+48+0,"Error")
	*** me desconecto	
	=abreycierracon(vconeccionF,"")
    RETURN 0

	
ENDIF 


	*** Busco las entidades ***
*!*		sqlmatriz(1)=" SELECT e.*, IFNULL(h.servicio,0) as servicio, IFNULL(h.cuenta,0) as cuenta, "
*!*		sqlmatriz(2)=" IFNULL(h.ruta1,0) as ruta1, IFNULL(h.folio1,0) as folio1, IFNULL(h.ruta2,0) as ruta2, IFNULL(h.folio2,0) as folio2 "
*!*		sqlmatriz(3)=" from entidades e left join entidadesh h on e.entidad = h.entidad "

	sqlmatriz(1)= " SELECT e.*, IFNULL(h.servicio,0) as servicio, IFNULL(h.cuenta,0) as cuenta, "
	sqlmatriz(2)= " IFNULL(h.ruta1,0) as ruta1, IFNULL(h.folio1,0) as folio1, IFNULL(h.ruta2,0) as ruta2, IFNULL(h.folio2,0) as folio2, "
	sqlmatriz(3)= " IFNULL(h.compania,e.compania) as companiah, IFNULL(h.nombre,e.nombre) as nombreh, IFNULL(h.apellido,e.apellido) as apellidoh, "
	sqlmatriz(4)= " IFNULL(h.direccion,e.direccion) as direccionh, IFNULL(h.localidad,e.localidad) as localidadh, IFNULL(h.iva,e.iva) as ivah, IFNULL(h.dni,e.dni) as dnih, IFNULL(h.telefono,e.telefono) as telefonoh, "
	sqlmatriz(5)= " IFNULL(h.cuit,e.cuit) as cuith, IFNULL(h.cp,e.cp) as cph, IFNULL(h.fax,e.fax) as faxh, IFNULL(h.email,e.email) as emailh "
	sqlmatriz(6)= " from entidades e left join entidadesh h on e.entidad = h.entidad "

	verror=sqlrun(vconeccionF,"entidades0_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de las entidades ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionF,"")
	    RETURN 
	ENDIF 


******************************************************************************************************
	SELECT * FROM entidades0_sql INTO TABLE entidades_sql
	ALTER table entidades_sql alter COLUMN servicio i
	ALTER table entidades_sql alter COLUMN cuenta i
	ALTER table entidades_sql alter COLUMN ruta1 i
	ALTER table entidades_sql alter COLUMN folio1 i
	ALTER table entidades_sql alter COLUMN ruta2 i
	ALTER table entidades_sql alter COLUMN folio2 i
	USE IN entidades0_sql 
	


		SELECT ctasctesentcarA
				
		GO TOP 
		DO WHILE !EOF()
		
		
		
			a_entidad = ctasctesentcarA.entidad
			a_servicio= ctasctesentcarA.servicio
			a_cuenta  = ctasctesentcarA.cuenta
			a_fecha	  = ctasctesentcarA.fecha
			a_numComp = ctasctesentcarA.numeroComp
			a_monto	  = ctasctesentcarA.monto
			a_cuota   = IIF(ISNULL(ctasctesentcarA.cuota)=.T.,0,ctasctesentcarA.cuota)
			a_vtocta  = IIF(ISNULL(ctasctesentcarA.vtocta)=.T.,'',ctasctesentcarA.vtocta)
			a_fechavenc1=ctasctesentcarA.fechavenc1
			a_fechavenc2=ctasctesentcarA.fechavenc2
			a_fechavenc3=ctasctesentcarA.fechavenc3
			
			
			
			*** GUARDA DATOS DE CABECERA DEL COMPROBANTE


			v_idfactura  = maxnumeroidx("idfactura","I","facturas",1)
			IF v_idfactura <= 0
				MESSAGEBOX("No se pudo recuperar el ultimo indice de la factura",0+16,"Error")
				RETURN 
			ENDIF 
			
			v_opera = 0
			IF a_monto < 0 
				
				v_opera = -1
				
			ELSE
				v_opera = 1			
			ENDIF 
			
			
			
			IF v_opera = 0
				MESSAGEBOX("No se pudo recuperar el tipo de operaci�n del comprobante",0+16,"Error")
				RETURN 			
			ENDIF 
			
			SELECT compIngEgr_sql
			GO TOP 
			LOCATE FOR opera = v_opera
			
			
			v_idcom  = compIngEgr_sql.idcomproba
			v_pventa = compIngEgr_sql.pventa
			v_numero = maxnumerocom(v_idcom,v_pventa  ,1)
			v_tipo	 = compIngEgr_sql.tipo
			
			DO CASE 
	
									
				CASE ( a_servicio = 0  OR a_cuenta = 0 ) AND a_entidad <> 0
						
					SELECT entidades_sql
					GO TOP 
					LOCATE FOR entidad = a_entidad AND servicio = 0 AND entidad = 0 
					
					
					***Factura a ENTIDAD
					***Toma los datos de la tabla Entidad
					SELECT entidades_sql
				
					v_apellido = ALLTRIM(entidades_sql.compania)+' '+ALLTRIM(entidades_sql.apellidoh)
					v_nombre   = IIF(EMPTY(ALLTRIM(entidades_sql.compania)),ALLTRIM(entidades_sql.nombreh),'') &&entidad.nombre
					v_direccion = entidades_sql.direccion
					v_localidad = entidades_sql.localidad
					v_iva = entidades_sql.iva
					v_cuit = entidades_sql.cuit
					v_docTipo = '80'
					v_dni = entidades_sql.dni
					v_telefono = entidades_sql.telefono
					v_cp = entidades_sql.cp
					v_fax = entidades_sql.fax
					v_email = entidades_sql.email
					v_zona = ""
					v_ruta1 = 0
					v_folio1 = 0
					v_ruta2 = 0
					v_folio2 = 0
					
				CASE a_entidad <> 0 AND a_servicio <> 0  AND a_cuenta <> 0 
					***Factura a una SUBCUENTA de la ENTIDAD
					***Toma los datos de la tabla CuentaSel
					SELECT entidades_sql
					GO TOP 
					LOCATE FOR entidad = a_entidad AND servicio = a_servicio AND cuenta = a_cuenta 
					
					
					***Factura a ENTIDAD
					***Toma los datos de la tabla Entidad
					SELECT entidades_sql

					
					v_apellido = ALLTRIM(entidades_sql.companiah)+' '+IIF(EMPTY(ALLTRIM(entidades_sql.companiah)),ALLTRIM(entidades_sql.apellidoh),'')
					v_nombre =  IIF(EMPTY(ALLTRIM(entidades_sql.companiah)),ALLTRIM(entidades_sql.nombreh),'')  &&cuentaSel.nombre
					v_direccion = entidades_sql.direccionh
					v_localidad = entidades_sql.localidadh
					v_iva = entidades_sql.ivah
					v_cuit = entidades_sql.cuith
					v_docTipo = '80'
					v_dni = entidades_sql.dnih
					v_telefono = entidades_sql.telefonoh
					v_cp = entidades_sql.cph
					v_fax = entidades_sql.faxh
					v_email = entidades_sql.emailh
					v_zona = ""
					v_ruta1 	= entidades_sql.ruta1
					v_folio1 	= entidades_sql.folio1
					v_ruta2 	= entidades_sql.ruta2
					v_folio2 	= entidades_sql.folio2
			ENDCASE 
						
			v_dirEntrega = ""
			v_transporte = 0
			v_nombreTransporte = ""

			v_stock = ""

			v_tipoOp= 0

			v_neto = 0.00
			v_descuento = 0.00
			v_recargo = 0
			v_operaExenta = ""
			v_anulado = "N"
			v_fechavenc1 = ""
			v_fechavenc2 = ""
			v_fechavenc3 = ""
			v_fechaDescuento = ""
			v_proxvenc = ""
			v_confirmada = ""
			v_astoConta = 0
			v_deuda_cta = 0
			v_cespcae = ""
			v_caecespVen = ""

			v_vendedor = 0
			v_idperiodo = 0			
			v_impuestos = 0
						
			*v_total = v_neto - v_Descuento +v_impuestos
			v_total = 0.00
		
			
			v_observa1 = "Comprobante de ajuste asociado a: "+ALLTRIM(a_numComp)
			v_observa2 = ""
			v_observa3 = ""
			v_observa4 = ""

			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
	
			DIMENSION lamatriz1(53,2)
			
			lamatriz1(1,1)='idfactura'
			lamatriz1(1,2)= ALLTRIM(STR(v_idfactura))
			lamatriz1(2,1)='idcomproba'
			lamatriz1(2,2)=ALLTRIM(STR(v_idcom))
			lamatriz1(3,1)='pventa'
			lamatriz1(3,2)= ALLTRIM(STR(v_pventa))
			lamatriz1(4,1)='numero'
			lamatriz1(4,2)=ALLTRIM(STR(v_numero))
			lamatriz1(5,1)='tipo'
			lamatriz1(5,2)="'"+ALLTRIM(v_tipo)+"'"
			lamatriz1(6,1)='fecha'
			lamatriz1(6,2)="'"+alltrim(a_fecha)+"'"
			lamatriz1(7,1)='entidad'
			lamatriz1(7,2)=ALLTRIM(STR(a_entidad))
			lamatriz1(8,1)='servicio'
			lamatriz1(8,2)= ALLTRIM(STR(a_servicio))
			lamatriz1(9,1)='cuenta'
			lamatriz1(9,2)= ALLTRIM(STR(a_cuenta))
			lamatriz1(10,1)='apellido'
			lamatriz1(10,2)= "'"+ALLTRIM(v_apellido)+"'"
			lamatriz1(11,1)='nombre'
			lamatriz1(11,2)= "'"+ALLTRIM(v_nombre)+"'"
			lamatriz1(12,1)='direccion'
			lamatriz1(12,2)= "'"+ALLTRIM(v_direccion)+"'"
			lamatriz1(13,1)='localidad'
			lamatriz1(13,2)= "'"+ALLTRIM(v_localidad)+"'"
			lamatriz1(14,1)='iva'
			lamatriz1(14,2)= ALLTRIM(STR(v_iva))
			lamatriz1(15,1)='cuit'
			lamatriz1(15,2)= "'"+ALLTRIM(v_cuit)+"'"
			lamatriz1(16,1)='tipodoc'
			lamatriz1(16,2)= "'"+ALLTRIM(v_docTIpo)+"'"
			lamatriz1(17,1)='dni'
			lamatriz1(17,2)= ALLTRIM(STR(v_dni))
			lamatriz1(18,1)='telefono'
			lamatriz1(18,2)= "'"+ALLTRIM(v_telefono)+"'"
			lamatriz1(19,1)='cp'
			lamatriz1(19,2)= "'"+ALLTRIM(v_cp)+"'"
			lamatriz1(20,1)='fax'
			lamatriz1(20,2)= "'"+ALLTRIM(v_fax)+"'"
			lamatriz1(21,1)='email' 
			lamatriz1(21,2)= "'"+ALLTRIM(v_email)+"'"
			lamatriz1(22,1)='transporte'
			lamatriz1(22,2)= ALLTRIM(STR(v_transporte))
			lamatriz1(23,1)='nomtransp'
			lamatriz1(23,2)= "'"+ALLTRIM(v_nombreTransporte)+"'"
			lamatriz1(24,1)='direntrega'
			lamatriz1(24,2)= "'"+ALLTRIM(v_dirEntrega)+"'"
			lamatriz1(25,1)='stock'
			lamatriz1(25,2)= "'"+ALLTRIM(v_stock)+"'"
			lamatriz1(26,1)='idtipoopera'
			lamatriz1(26,2)= ALLTRIM(STR(v_tipoOp))
			*lamatriz1(26,2)= "''"
			lamatriz1(27,1)='neto'
			lamatriz1(27,2)= ALLTRIM(STR(v_neto,13,2))
			lamatriz1(28,1)='subtotal'
			lamatriz1(28,2)= ALLTRIM(STR(v_neto,13,2))
			lamatriz1(29,1)='descuento'
			lamatriz1(29,2)= ALLTRIM(STR(v_descuento,13,2))
			lamatriz1(30,1)='recargo'
			lamatriz1(30,2)= ALLTRIM(STR(v_recargo,13,2))
			lamatriz1(31,1)='total'
			lamatriz1(31,2)= ALLTRIM(STR(v_total,13,2))
			lamatriz1(32,1)='totalimpu'
			lamatriz1(32,2)= ALLTRIM(STR(v_impuestos,13,2))
			lamatriz1(33,1)='operexenta'
			lamatriz1(33,2)= "'"+ALLTRIM(v_operaExenta)+"'"
			lamatriz1(34,1)='anulado'
			lamatriz1(34,2)= "'"+ALLTRIM(v_anulado)+"'"
			lamatriz1(35,1)='observa1'
			lamatriz1(35,2)= "'"+ALLTRIM(v_observa1)+"'"
			lamatriz1(36,1)='observa2'
			lamatriz1(36,2)= "'"+ALLTRIM(v_observa2)+"'"
			lamatriz1(37,1)='observa3'
			lamatriz1(37,2)= "'"+ALLTRIM(v_observa3)+"'"
			lamatriz1(38,1)='observa4'
			lamatriz1(38,2)= "'"+ALLTRIM(v_observa4)+"'"
			lamatriz1(39,1)='idperiodo'
			lamatriz1(39,2)= ALLTRIM(STR(v_idperiodo))
			lamatriz1(40,1)='ruta1'
			lamatriz1(40,2)= ALLTRIM(STR(v_ruta1))
			lamatriz1(41,1)='folio1'
			lamatriz1(41,2)= ALLTRIM(STR(v_folio1))
			lamatriz1(42,1)='ruta2'
			lamatriz1(42,2)= ALLTRIM(STR(v_ruta2))
			lamatriz1(43,1)='folio2'
			lamatriz1(43,2)= ALLTRIM(STR(v_folio2))
			lamatriz1(44,1)='fechavenc1'
			lamatriz1(44,2)= "'"+ALLTRIM(a_fechavenc1)+"'"
			lamatriz1(45,1)='fechavenc2'
			lamatriz1(45,2)= "'"+ALLTRIM(a_fechavenc2)+"'"
			lamatriz1(46,1)='fechavenc3'
			lamatriz1(46,2)= "'"+ALLTRIM(a_fechavenc3)+"'"
			lamatriz1(47,1)='proxvenc'
			lamatriz1(47,2)= "'"+ALLTRIM(v_proxvenc)+"'"
			lamatriz1(48,1)='confirmada'
			lamatriz1(48,2)= "'"+ALLTRIM(v_confirmada)+"'"
			lamatriz1(49,1)='astoconta'
			lamatriz1(49,2)= ALLTRIM(STR(v_astoConta))
			lamatriz1(50,1)='deudacta'
			lamatriz1(50,2)= ALLTRIM(STR(v_deuda_cta,13,4))
			lamatriz1(51,1)='cespcae'
			lamatriz1(51,2)= "'"+ALLTRIM(v_cespcae)+"'"
			lamatriz1(52,1)='caecespven'
			lamatriz1(52,2)= "'"+ALLTRIM(v_caecespVen)+"'"
			lamatriz1(53,1)='vendedor'
			lamatriz1(53,2)= ALLTRIM(STR(v_vendedor))
	

			p_tabla     = 'facturas'
			p_matriz    = 'lamatriz1'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			    RETURN 
			ENDIF  

		
		
			p_cantidad = 1
			p_unitario = a_monto * v_opera 
			p_operacion = "AJUSTE CTA CTE"
		
			
			v_ret = agregarItemEspecial(p_operacion,p_cantidad,p_unitario,v_idfactura,v_iva)	
				
			IF v_ret = .F.
				 MESSAGEBOX("Ha Ocurrido un Error en el agregado del detalle del comprobante",0+48+0,"Error")
			    RETURN 
			ENDIF 
		
			
		
			
		
			
		
			SELECT * FROM ctasctesentcar WHERE cuota > 0 and entidad = a_entidad AND ALLTRIM(numerocomp) == ALLTRIM(a_numComp) ORDER BY cuota INTO TABLE ctasctesentcard
			**** Agrego las cuotas de la factura
			
			SELECT ctasctesentcard
			GO TOP 

			v_cantReg = RECCOUNT()

			IF v_cantReg > 0
			
				
				SELECT ctasctesentcard
				GO BOTTOM 
				
				v_cantCtas = ctasctesentcard.cuota
				
				SELECT ctasctesentcard
				GO TOP 
			
				
				DIMENSION lamatriz10(6,2)
				** Cuota 0 (anticipo en Cero)
				v_idcuotafc = maxnumeroidx("idcuotafc", "I", "facturascta",1)

					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					p_tabla     = 'facturascta'
					p_matriz    = 'lamatriz10'
					p_conexion  = vconeccionF



					lamatriz10(1,1)='idcuotafc'
					lamatriz10(1,2)=ALLTRIM(STR(v_idcuotafc))
					lamatriz10(2,1)='idfactura'
					lamatriz10(2,2)=ALLTRIM(STR(v_idfactura))
					lamatriz10(3,1)='cuota'
					lamatriz10(3,2)= "0"
					lamatriz10(4,1)='cancuotas'
					lamatriz10(4,2)=ALLTRIM(STR(a_cuota))
					lamatriz10(5,1)='importe'
					lamatriz10(5,2)="0.00"
					lamatriz10(6,1)='fechavenc'
					lamatriz10(6,2)="'"+ALLTRIM(a_vtocta)+"'"
												
					
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
					    RETURN 
					ENDIF 
			
			SELECT ctasctesentcard
			GO top	
				DO WHILE NOT EOF()
				
					v_montocta = ctasctesentcard.monto
					v_idcuotafc = maxnumeroidx("idcuotafc", "I", "facturascta",1)

					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					p_tabla     = 'facturascta'
					p_matriz    = 'lamatriz10'
					p_conexion  = vconeccionF
					


					lamatriz10(1,1)='idcuotafc'
					lamatriz10(1,2)=ALLTRIM(STR(v_idcuotafc))
					lamatriz10(2,1)='idfactura'
					lamatriz10(2,2)=ALLTRIM(STR(v_idfactura))
					lamatriz10(3,1)='cuota'
					lamatriz10(3,2)= ALLTRIM(STR(a_cuota))
					lamatriz10(4,1)='cancuotas'
					lamatriz10(4,2)=ALLTRIM(STR(v_cantCtas))
					lamatriz10(5,1)='importe'
					lamatriz10(5,2)=ALLTRIM(STR(v_montocta,13,4))
					lamatriz10(6,1)='fechavenc'
					lamatriz10(6,2)="'"+ALLTRIM(a_vtocta)+"'"
												
					
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en la grabaci�n de la cta",0+48+0,"Error")
					    RETURN 
					ENDIF 
				
					SELECT ctasctesentcard
					SKIP 1

				ENDDO
			ENDIF 
			
			
		
			registrarEstado("facturas","idfactura",v_idfactura,'I',"AUTORIZADO")
		
		
			
			SELECT ctasctesentcarA
			SKIP 					
		ENDDO 
			
		
			
				
		
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT ctasctesentcarA
	USE IN ctasctesentcarA
	
	SELECT ctasctesentcar
	USE IN ctasctesentcar

	ENDIF 	&& 1- Carga de Archivo de comprobantes de ingreso y egeso -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos 
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
	*	=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Carga de Cuenta corrientes de entidades
*/------------------------------------------------------------------------------------------------------------




*/------------------------------------------------------------------------------------------------------------
*/ Agrega un Item especial al comprobante de la tabla facturas cuyo ID es pasado como par�metro
*/------------------------------------------------------------------------------------------------------------
FUNCTION agregarItemEspecial
PARAMETERS p_operacion,p_cantidad,p_unitario,p_idfactura,p_iva

	
	IF p_cantidad = 0 OR p_unitario = 0
		RETURN .F.
	ENDIF 
	oeObj			= CREATEOBJECT('oeclass')
	
	v_codTab	=  oeObj.getCodigoOp(p_operacion) && Obtengo: CODIGO_TABLA. El caracter '_' es el de separaci�n
	v_cantidad 	= p_cantidad
	v_unitario 	= p_unitario
	
	
	v_nPos 		= AT('_',v_codTab) &&Retorna la posici�n donde aparece el caracter de separacion utilizado (_)
	
	v_codigo	= SUBSTR(v_codTab,1,v_nPos-1) && Retorna el c�digo
	v_tabla		= SUBSTR(v_codTab,v_nPos+1)	&& Retorna el resto de la cadena, que corresponde a la tabla
	
	
	*** Busco el impuesto para el articulo o concepto a agregar ***
	
	DO CASE
	CASE ALLTRIM(v_tabla) = "articulos"
		sqlmatriz(1)="SELECT a.*,ai.impuesto,ai.idartimp,i.razon as razon,i.detalle as detaimp, af.unidadf,af.base FROM articulos a "
		sqlmatriz(2)=" LEFT JOIN articulosimp ai on a.articulo = ai.articulo "
		sqlmatriz(3)=" LEFT JOIN impuestos i ON ai.impuesto = i.impuesto "
		sqlmatriz(4)=" LEFT JOIN articulosf af on a.articulo = af.articulo"
		sqlmatriz(5)=" WHERE  ai.iva = "+ALLTRIM(STR(p_iva))+" and  a.articulo = '"+ALLTRIM(v_codigo)+"'"
		
			
	OTHERWISE
		MESSAGEBOX("No se reconoce la operaci�n especial que intenta agregar",0+48+0,"Error al obtener el impuesto")
		RETURN .F.

	ENDCASE
	
	
	
	verror=sqlrun(vconeccion,"oeImp")
	* me desconecto
		=abreycierracon(vconeccion,"")
	IF verror=.f.
		MESSAGEBOX("Error al obtener el Impuesto para la Operaci�n Especial",0+48+0,"Error")
		RETURN .F.
	
	ENDIF 
	
	
	SELECT oeImp
	GO TOP 
	
	v_impuesto = oeImp.impuesto
	v_razonimp = oeImp.razon
	v_detalleIMP = oeImp.detaimp

		vconeccionF=abreycierracon(0,_SYSSCHEMA)
	
	sqlmatriz(1)="select * from facturas "
	sqlmatriz(2)=" where idfactura = "+ALLTRIM(STR(p_idfactura))
	
	verror=sqlrun(vconeccionF,"conFact_sql")

	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de la factura para actualizar montos",0+48+0,"Error")
	* me desconecto	
		*=abreycierracon(vconeccionF,"") 
	ENDIF 

	SELECT 	conFact_sql
	GO TOP 			
	
	
	v_netoAnterior = conFact_sql.neto
	v_subtotalAnterior = conFact_sql.subtotal
	v_totalAnterior = conFact_sql.total
	v_totalImpuAnterior = conFact_sql.totalimpu
	
	
	v_netoImpuesto =  v_unitario * v_cantidad 	
	v_ImpuestoFinanc = v_netoImpuesto  * (v_razonimp/100)

	*v_impuestos = v_total - v_unitario
	
	
	
	v_netoActu = (v_netoImpuesto ) + v_netoAnterior
	v_subtotalActu = (v_netoImpuesto ) + v_subtotalAnterior
	v_totalImpuestoActu = v_ImpuestoFinanc + v_totalImpuAnterior
	*v_totalActu = v_unitario + v_totalAnterior
	v_totalActu = v_netoActu + v_totalImpuestoActu 


	
	*** ACTUALIZO FACTURA ***
	
	DIMENSION lamatriz1(4,2)

	lamatriz1(1,1)='neto'
	lamatriz1(1,2)= ALLTRIM(STR(v_netoActu,13,4))
	lamatriz1(2,1)='subtotal'
	lamatriz1(2,2)= ALLTRIM(STR(v_subtotalActu,13,4))
	lamatriz1(3,1)='total'
	lamatriz1(3,2)= ALLTRIM(STR(v_totalActu,13,4))
	lamatriz1(4,1)='totalimpu'
	lamatriz1(4,2)= ALLTRIM(STR(v_totalImpuestoActu,13,4))
	


	
	p_tipoope     = 'U'
	p_condicion   = " idfactura = "+ ALLTRIM(STR(p_idfactura))
	v_titulo      = " LA MODIFICACI�N "
	
	p_tabla     = 'facturas'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionF
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
		 RETURN .F.
  	ENDIF  
	

	*** INSERTO DETALLE EN  DETAFACTU ***
		v_idfactura = p_idfactura
		v_idfacturah = maxnumeroidx("idfacturah","I","detafactu",1)
		v_articulo = v_codigo
		v_idconcepto = 0 
		v_servicio = 0
		v_cantidad = v_cantidad
		v_unidad = oeImp.unidad
		v_cantidadFC = v_cantidad
		v_unidadFC	= v_unidad 
		v_detalle = oeImp.detalle
		v_unitario = v_unitario
		v_impuestos = v_ImpuestoFinanc
		v_codigoCta = ""
		v_nombreCta = ""
		v_cuota = 0
		v_cantidadCtas = 0
		v_padron = 0
		v_idimpuesto = v_impuesto
		v_razonImpuesto = v_razonimp
		v_totalArt = v_netoImpuesto + v_ImpuestoFinanc
		v_netoArt = v_netoImpuesto 
		

		
	
		DIMENSION lamatriz2(21,2)
	
		lamatriz2(1,1)='idfactura'
		lamatriz2(1,2)= ALLTRIM(STR(v_idfactura))
		lamatriz2(2,1)='idfacturah'
		lamatriz2(2,2)= ALLTRIM(STR(v_idfacturah ))
		lamatriz2(3,1)='articulo'
		lamatriz2(3,2)= "'"+ALLTRIM(v_articulo)+"'"
		lamatriz2(4,1)='idconcepto'
		lamatriz2(4,2)= ALLTRIM(STR(v_idconcepto))
		lamatriz2(5,1)='servicio'
		lamatriz2(5,2)= ALLTRIM(STR(v_servicio))
	
		lamatriz2(6,1)='cantidad'
		lamatriz2(6,2)= ALLTRIM(STR(v_cantidad,13,2))
		lamatriz2(7,1)='unidad'
		lamatriz2(7,2)= "'"+ALLTRIM(v_unidad)+"'"
		lamatriz2(8,1)='cantidadfc'
		lamatriz2(8,2)= ALLTRIM(str(v_cantidadFC,13,2))
		lamatriz2(9,1)='unidadfc'
		lamatriz2(9,2)= "'"+ALLTRIM(v_unidadFC)+"'"
		lamatriz2(10,1)='detalle'
		lamatriz2(10,2)= "'"+ALLTRIM(v_detalle)+"'"
		lamatriz2(11,1)='unitario'
		lamatriz2(11,2)= ALLTRIM(STR(v_unitario,13,2))
		lamatriz2(12,1)='impuestos'
		lamatriz2(12,2)= ALLTRIM(STR(v_impuestos,13,2))
		lamatriz2(13,1)='total'
		lamatriz2(13,2)= ALLTRIM(STR(v_totalArt,13,2))
		lamatriz2(14,1)='codigocta'
		lamatriz2(14,2)= "'"+ALLTRIM(v_codigoCta)+"'"
		lamatriz2(15,1)='nombrecta'
		lamatriz2(15,2)= "'"+ALLTRIM(v_nombreCta)+"'"
		lamatriz2(16,1)='cuota'
		lamatriz2(16,2)= ALLTRIM(STR(v_cuota))
		lamatriz2(17,1)='cantcuotas'
		lamatriz2(17,2)= ALLTRIM(STR(v_cantidadCtas))
		lamatriz2(18,1)='padron' 
		lamatriz2(18,2)= ALLTRIM(STR(v_padron))
		lamatriz2(19,1)='impuesto'
		lamatriz2(19,2)= ALLTRIM(STR(v_idimpuesto))
		lamatriz2(20,1)='razonimp'
		lamatriz2(20,2)= ALLTRIM(STR(v_razonImpuesto,13,2))
		lamatriz2(21,1)='neto'
		lamatriz2(21,2)= ALLTRIM(STR(v_netoArt,13,2))


		p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
		p_tabla     = 'detafactu'
		p_matriz    = 'lamatriz2'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
		    RETURN .F.
		ENDIF	
		
		
		
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			
			DIMENSION lamatriz3(7,2)
	
			lamatriz3(1,1)='idfactura'
			lamatriz3(1,2)= ALLTRIM(STR(v_idfactura))
			lamatriz3(2,1)= 'impuesto'
			lamatriz3(2,2)= ALLTRIM(STR(v_impuesto ))
			lamatriz3(3,1)= 'detalle'
			lamatriz3(3,2)= "'"+ALLTRIM(v_detalleIMP)+"'"
			lamatriz3(4,1)= 'neto'
			lamatriz3(4,2)= ALLTRIM(STR(v_netoImpuesto,13,4))
			lamatriz3(5,1)= 'razon'
			lamatriz3(5,2)= ALLTRIM(STR(v_razonimp,13,4))
			lamatriz3(6,1)= 'importe'
			lamatriz3(6,2)= ALLTRIM(STR(v_ImpuestoFinanc,13,4))
			lamatriz3(7,1)= 'articulo'
			lamatriz3(7,2)= "'"+v_articulo+"'"

		p_tabla     = 'facturasimp'
		p_matriz    = 'lamatriz3'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idfactura)),0+48+0,"Error")
		    RETURN .F.
		ENDIF			
		
		
		RETURN .T.

ENDFUNC 




*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Cuentas corrientes de Proveedores
*/------------------------------------------------------------------------------------------------------------
	FUNCTION CargaCtaCteProveedores
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Cuentas corrientes de Entidades -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	


		if file(".\ctasctesentcarp.dbf") THEN
			if used("ctasctesentcarp") then
				sele ctasctesentcarp
				use
			endif
			DELETE FILE .\ctasctesentcarp.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\ctasctesentcarp FREE ( entidad I,servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8))			
					
		SELECT ctasctesentcarp
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

*** AQUI AGREGAR LOGICA PARA CONSULTAR Y ELIMINAR FACTURAS SI ASI LO DESEA QUIEN IMPORTA ***
		rta =MESSAGEBOX("Desea Eliminar los Comprobantes Existentes en las Cuentas Corrientes de Proveedores ",3+32+256,"Eliminar Comprobantes ")
		IF rta=6  THEN 
		
			*Elimino las Facturas de Proveedores
			sqlmatriz(1)=" delete from factuprove "
			verror=sqlrun(vconeccionF,"fc")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Facturas de Proveedor... ",0+48+0,"Error")
			    RETURN 0
			ENDIF	
			sqlmatriz(1)=" delete from factuproved "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas de Proveedor... ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)=" delete from factuprovec "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas  de Proveedor",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)="alter table factuprovec auto_increment = 1 "
			verror=sqlrun(vconeccionF,"dfa")
			IF verror=.f.  
		    	MESSAGEBOX("Ha Ocurrido un Error en la Actualizaci�n del indice autoincremental de facturasd ",0+48+0,"Eliminaci�n de Registros")
		    	RETURN 0
			ENDIF 
			
			sqlmatriz(1)=" delete from factuprovecc "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas  de Proveedor",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)="alter table factuprovecc auto_increment = 1 "
			verror=sqlrun(vconeccionF,"dfa")
			IF verror=.f.  
		    	MESSAGEBOX("Ha Ocurrido un Error en la Actualizaci�n del indice autoincremental de facturasd ",0+48+0,"Eliminaci�n de Registros")
		    	RETURN 0
			ENDIF 

			sqlmatriz(1)=" delete from factuproveimp "
			verror=sqlrun(vconeccionF,"df")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Impuestos de Facturas  de Proveedor Proveedor ",0+48+0,"Error")
			    RETURN 0
			ENDIF		
			sqlmatriz(1)="alter table factuproveimp auto_increment = 1 "
			verror=sqlrun(vconeccionF,"dfa")
			IF verror=.f.  
		    	MESSAGEBOX("Ha Ocurrido un Error en la Actualizaci�n del indice autoincremental de factuproveimp ",0+48+0,"Eliminaci�n de Registros")
		    	RETURN 0
			ENDIF 

			sqlmatriz(1)=" delete from estadosreg where tabla = 'factuprove' "
			verror=sqlrun(vconeccionF,"er")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Estados de Facturas de Proveedores ",0+48+0,"Error")
			    RETURN 0
			ENDIF		

			* Reinicio indices de tablas afectadas a facturas 
			sqlmatriz(1)=" update tablasidx set maxvalori = 0 where tabla = 'factuprove' or tabla = 'factuproved'  "
			verror=sqlrun(vconeccionF,"er")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n Detalles de Facturas ",0+48+0,"Error")
			    RETURN 0
			ENDIF		


		ELSE 
			IF rta = 2 THEN 
				USE IN ctasctesentcar 
				=abreycierracon(vconeccionF,"")	
				RETURN 0
			ENDIF  	
		ENDIF 
		




	
	SELECT ctasctesentcarp
	GO TOP 
	
	
	v_ret = .F.
	
	DO FORM cargactacteentidad WITH "ctasctesentcarp",.T. TO v_ret 
	
	IF v_ret = .F.
		RETURN 0
	ENDIF 
	
	
	
	SELECT ctasctesentcarp
	GO TOP 
		
	
	IF LEN(_SYSCOMPACCP) <> 8
		 MESSAGEBOX("No se ha especificado correctamente los comprobantes de ajuste de Cta Cte de Proveedores ",0+48+0,"Error")
		 RETURN 0
	ENDIF 

	SET ENGINEBEHAVIOR 70
	SELECT entidad,servicio,cuenta,fecha,numerocomp,SUM(monto) as monto,cuota,vtocta FROM ctasctesentcarp GROUP BY entidad,numerocomp INTO TABLE ctasctesentcarpA
	SET ENGINEBEHAVIOR 90
v_pventaIng = VAL(ALLTRIM(SUBSTR(_SYSCOMPACCP,1,2)))
v_idcompIng = VAL(ALLTRIM(SUBSTR(_SYSCOMPACCP,3,2)))
v_pventaEgr = VAL(ALLTRIM(SUBSTR(_SYSCOMPACCP,5,2)))
v_idcompEgr = VAL(ALLTRIM(SUBSTR(_SYSCOMPACCP,7,2)))

*** BUsco comprobantes de Ingreso y Egreso ***
*!*	sqlmatriz(1)="SELECT c.*,t.opera,v.pventa,v.puntov from comprobantes c left join compactiv v on c.idcomproba = v.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro "
*!*	sqlmatriz(2)=" WHERE c.ctacte = 'S' and t.opera <> 0 and ((c.idcomproba = "+ALLTRIM(STR(v_idcompIng))+" and v.pventa = "+ALLTRIM(STR(v_pventaIng))+") or ( c.idcomproba = "+ALLTRIM(STR(v_idcompEgr))+" and v.pventa = "+ALLTRIM(STR(v_pventaEgr))+"))"
sqlmatriz(1)="SELECT c.*,t.opera,t.idtipocompro as idtipocom from comprobantes c left join tipocompro t on c.idtipocompro = t.idtipocompro "
sqlmatriz(2)=" WHERE c.ctacte = 'S' and t.opera <> 0 and (c.idcomproba = "+ALLTRIM(STR(v_idcompIng))+" or  c.idcomproba = "+ALLTRIM(STR(v_idcompEgr))+")"
verror=sqlrun(vconeccionF,"compIngEgr_sql")

IF verror=.f.  
    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de los comprobantes de Ingreso y Egreso ",0+48+0,"Error")
*** me desconecto	
	=abreycierracon(vconeccionF,"")
    RETURN 0
ENDIF 


SELECT compIngEgr_sql
GO TOP 
IF EOF()
	MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de los comprobantes de Ingreso y Egreso ",0+48+0,"Error")
	*** me desconecto	
	=abreycierracon(vconeccionF,"")
    RETURN 0

	
ENDIF 


	*** Busco las entidades ***
	sqlmatriz(1)="SELECT * from entidades e left join entidadesh h on e.entidad = h.entidad "

	verror=sqlrun(vconeccionF,"entidades_sql")

	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de las entidades ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionF,"")
	    RETURN 0
	ENDIF 





		SELECT ctasctesentcarpA
				
		GO TOP 
		DO WHILE !EOF()
		
	
			a_entidad = ctasctesentcarpA.entidad
			a_servicio= ctasctesentcarpA.servicio
			a_cuenta  = ctasctesentcarpA.cuenta
			a_fecha	  = ctasctesentcarpA.fecha
			a_numComp = ctasctesentcarpA.numeroComp
			a_monto	  = ctasctesentcarpA.monto
			a_cuota   = IIF(ISNULL(ctasctesentcarpA.cuota)=.T.,0,ctasctesentcarpA.cuota)
			a_vtocta  = IIF(ISNULL(ctasctesentcarpA.vtocta)=.T.,'',ctasctesentcarpA.vtocta)
			
		
			
			*** GUARDA DATOS DE CABECERA DEL COMPROBANTE


			v_idfactura  = maxnumeroidx("idfactprove","I","factuprove",1)
			IF v_idfactura <= 0
				MESSAGEBOX("No se pudo recuperar el ultimo indice de la factura",0+16,"Error")
				RETURN 
			ENDIF 
			
			v_opera = 0
			IF a_monto < 0 
				
				v_opera = -1
				
			ELSE
				v_opera = 1			
			ENDIF 
			
			
			
			IF v_opera = 0
				MESSAGEBOX("No se pudo recuperar el tipo de operaci�n del comprobante",0+16,"Error")
				RETURN 			
			ENDIF 
			
			SELECT compIngEgr_sql
			GO TOP 
			LOCATE FOR opera = v_opera
				
			
			v_idcom = compIngEgr_sql.idcomproba
			v_idtipocomp = compIngEgr_sql.idtipocom
			IF v_idcom = v_idcompIng 
				v_pventa = v_pventaIng
			ELSE
				v_pventa = v_pventaEgr
			ENDIF 
			*v_pventa = compIngEgr_sql.pventa

			v_tipo	 = compIngEgr_sql.tipo
			
			
			
			
			
				*** Busco Maximo numero de comprobante para actividad-comprobante-entidad ***

				sqlmatriz(1)=" SELECT max(numero) as nromax   FROM factuprove "
				sqlmatriz(2)=" where idcomproba = "+ALLTRIM(STR(v_idcom))
				verror=sqlrun(vconeccionF,"maxnrofprove_sql")

				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA del maximo valor de a",0+48+0,"Error")
				*** me desconecto	
					=abreycierracon(vconeccionF,"")
				    RETURN 
				ENDIF 
					
				SELECT maxnrofprove_sql
				GO TOP 
				
				v_numero = 0
				IF NOT EOF()
					v_numero =IIF(ISNULL(maxnrofprove_sql.nromax),0,maxnrofprove_sql.nromax) + 1
					
				ELSE
					v_numero = 1
				ENDIF 
				
											
									
					SELECT entidades_sql
					GO TOP 
					LOCATE FOR entidad = a_entidad 
		
					***Factura a ENTIDAD
					***Toma los datos de la tabla Entidad
					SELECT entidades_sql
				
					v_apellido = ALLTRIM(entidades_sql.compania)+' '+ALLTRIM(entidades_sql.apellido)
					v_nombre   = IIF(EMPTY(ALLTRIM(entidades_sql.compania)),ALLTRIM(entidades_sql.nombre),'') &&entidad.nombre
					v_direccion = entidades_sql.direccion
					v_localidad = entidades_sql.localidad
					v_iva = entidades_sql.iva
					v_cuit = entidades_sql.cuit
					v_docTipo = '80'
					v_dni = entidades_sql.dni
					v_telefono = entidades_sql.telefono
					v_cp = entidades_sql.cp
					v_fax = entidades_sql.fax
					v_email = entidades_sql.email
					v_zona = ""
					v_ruta1 = 0
					v_folio1 = 0
					v_ruta2 = 0
					v_folio2 = 0
					
				
						
			v_dirEntrega = ""
			v_transporte = 0
			v_nombreTransporte = ""

			v_stock = ""

			v_tipoOp= 1
			v_nroremito=""
			v_nropedido="0"
			
			v_neto = 0.00
			v_descuento = 0.00
			v_recargo = 0
			v_operaExenta = ""
			v_anulado = "N"
			v_fechavenc1 = ""
			v_fechavenc2 = ""
			v_fechavenc3 = ""
			v_fechaDescuento = ""
			v_proxvenc = ""
			v_confirmada = ""
			v_astoConta = 0
			v_deuda_cta = 0
			v_cespcae = ""
			v_caecespVen = ""

			v_vendedor = 0
			v_idperiodo = 0			
			v_impuestos = 0.00
						
			*v_total = v_neto - v_Descuento +v_impuestos
			v_total = 0.00
			v_fechaCarga = DTOS(DATE())
			
			v_observa = "Comprobante de ajuste asociado a: "+ALLTRIM(a_numComp)
			v_liva = 'N'
			*** GUARDA DATOS DE CABECERA DE LA FACTURA de PROVEEDOR

		
			DIMENSION lamatriz1(24,2)

			lamatriz1(1,1)='idfactprove'
			lamatriz1(1,2)= ALLTRIM(STR(v_idfactura))
			lamatriz1(2,1)='idtipocompro'
			lamatriz1(2,2)=ALLTRIM(STR(v_idtipocomp))
			lamatriz1(3,1)='tipo'
			lamatriz1(3,2)="'"+ALLTRIM(v_tipo)+"'"
			lamatriz1(4,1)='actividad'
			lamatriz1(4,2)= ALLTRIM(STR(v_pventa))
			lamatriz1(5,1)='numero'
			lamatriz1(5,2)= ALLTRIM(STR(v_numero))
			lamatriz1(6,1)='fecha'
			lamatriz1(6,2)="'"+ALLTRIM(a_fecha)+"'"
			lamatriz1(7,1)='entidad'
			lamatriz1(7,2)=ALLTRIM(STR(a_entidad))
			lamatriz1(8,1)='apellido'
			lamatriz1(8,2)= "'"+ALLTRIM(v_apellido)+"'"
			lamatriz1(9,1)='nombre'
			lamatriz1(9,2)= "'"+ALLTRIM(v_nombre)+"'"
			lamatriz1(10,1)='cuit'
			lamatriz1(10,2)= "'"+ALLTRIM(v_cuit)+"'"
			lamatriz1(11,1)='dni'
			lamatriz1(11,2)= ALLTRIM(STR(v_dni))
			lamatriz1(12,1)='tipodoc'
			lamatriz1(12,2)= "'"+ALLTRIM(v_docTIpo)+"'"
			lamatriz1(13,1)='iva'
			lamatriz1(13,2)= ALLTRIM(STR(v_iva))
			lamatriz1(14,1)='condvta'
			lamatriz1(14,2)= ALLTRIM(STR(v_tipoOp))
			lamatriz1(15,1)='nroremito'
			lamatriz1(15,2)="'"+ALLTRIM(v_nroremito)+"'"
			lamatriz1(16,1)='nropedido'
			lamatriz1(16,2)="'"+ALLTRIM(v_nropedido)+"'"
			lamatriz1(17,1)='neto'
			lamatriz1(17,2)= ALLTRIM(STR(v_neto,13,2))
			lamatriz1(18,1)= 'impuesto'
			lamatriz1(18,2)= ALLTRIM(STR(v_impuestos,13,2))
			lamatriz1(19,1)='total'
			lamatriz1(19,2)= ALLTRIM(STR(v_total,13,2))
			lamatriz1(20,1)='fechacarga'
			lamatriz1(20,2)= "'"+ALLTRIM(v_fechaCarga)+"'"
			lamatriz1(21,1)='fechaingreso'
			lamatriz1(21,2)= "'"+ALLTRIM(v_fechaCarga)+"'"
			lamatriz1(22,1)='observa'
			lamatriz1(22,2)= "'"+ALLTRIM(v_observa)+"'"
			lamatriz1(23,1)='idcomproba'
			lamatriz1(23,2)=ALLTRIM(STR(v_idcom))
			lamatriz1(24,1)='liva'
			lamatriz1(24,2)= "'"+ALLTRIM(v_liva)+"'"

			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla     = 'factuprove'
			p_matriz    = 'lamatriz1'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			    RETURN 0
			ENDIF  

			p_cantidad = 1
			p_unitario = a_monto * v_opera 
			p_operacion = "AJUSTE CTA CTE"
		
			
			v_ret = agregarItemEspecialPro(p_operacion,p_cantidad,p_unitario,v_idfactura,v_iva)	
				
			IF v_ret = .F.
				 MESSAGEBOX("Ha Ocurrido un Error en el agregado del detalle del comprobante",0+48+0,"Error")
			    RETURN 0
			ENDIF 
		
			
		
			
		
			
		
						
			registrarEstado("facturas","idfactura",v_idfactura,'I',"AUTORIZADO")
		
		
			
			SELECT ctasctesentcarpA
			SKIP 					
		ENDDO 
			
		
			
				
		
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT ctasctesentcarpA
	USE IN ctasctesentcarpA
	
	SELECT ctasctesentcarp
	USE IN ctasctesentcarp

	ENDIF 	&& 1- Carga de Archivo de comprobantes de ingreso y egeso -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos 
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
	*	=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Carga de Cuenta corrientes de entidades
*/------------------------------------------------------------------------------------------------------------




*/------------------------------------------------------------------------------------------------------------
*/ Agrega un Item especial al comprobante de la tabla facturas cuyo ID es pasado como par�metro
*/------------------------------------------------------------------------------------------------------------
FUNCTION agregarItemEspecialPro
PARAMETERS p_operacion,p_cantidad,p_unitario,p_idfactura,p_iva

	
	IF p_cantidad = 0 OR p_unitario = 0
		RETURN .F.
	ENDIF 
	oeObj			= CREATEOBJECT('oeclass')
	
	v_codTab	=  oeObj.getCodigoOp(p_operacion) && Obtengo: CODIGO_TABLA. El caracter '_' es el de separaci�n
	v_cantidad 	= p_cantidad
	v_unitario 	= p_unitario
	
	
	v_nPos 		= AT('_',v_codTab) &&Retorna la posici�n donde aparece el caracter de separacion utilizado (_)
	
	v_codigo	= SUBSTR(v_codTab,1,v_nPos-1) && Retorna el c�digo
	v_tabla		= SUBSTR(v_codTab,v_nPos+1)	&& Retorna el resto de la cadena, que corresponde a la tabla
	
	
	*** Busco el impuesto para el articulo o concepto a agregar ***
	
	DO CASE
	CASE ALLTRIM(v_tabla) = "articulos"
		sqlmatriz(1)="SELECT a.*,ai.impuesto,ai.idartimp,i.razon as razon,i.detalle as detaimp, af.unidadf,af.base FROM articulos a "
		sqlmatriz(2)=" LEFT JOIN articulosimp ai on a.articulo = ai.articulo "
		sqlmatriz(3)=" LEFT JOIN impuestos i ON ai.impuesto = i.impuesto "
		sqlmatriz(4)=" LEFT JOIN articulosf af on a.articulo = af.articulo"
		sqlmatriz(5)=" WHERE  ai.iva = "+ALLTRIM(STR(p_iva))+" and  a.articulo = '"+ALLTRIM(v_codigo)+"'"
		
			
	OTHERWISE
		MESSAGEBOX("No se reconoce la operaci�n especial que intenta agregar",0+48+0,"Error al obtener el impuesto")
		RETURN .F.

	ENDCASE
	
	
	
	verror=sqlrun(vconeccion,"oeImp")
	* me desconecto
		=abreycierracon(vconeccion,"")
	IF verror=.f.
		MESSAGEBOX("Error al obtener el Impuesto para la Operaci�n Especial",0+48+0,"Error")
		RETURN .F.
	
	ENDIF 
	
	
	SELECT oeImp
	GO TOP 
	
	v_impuesto = oeImp.impuesto
	v_razonimp = oeImp.razon
	v_detalleIMP = oeImp.detaimp

		vconeccionF=abreycierracon(0,_SYSSCHEMA)
	
	sqlmatriz(1)="select * from factuprove "
	sqlmatriz(2)=" where idfactprove = "+ALLTRIM(STR(p_idfactura))
	
	verror=sqlrun(vconeccionF,"conFact_sql")

	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA de la factura para actualizar montos",0+48+0,"Error")
	* me desconecto	
		*=abreycierracon(vconeccionF,"") 
	ENDIF 

	SELECT 	conFact_sql
	GO TOP 			
	
	
	v_netoAnterior = conFact_sql.neto
	*v_subtotalAnterior = conFact_sql.subtotal
	v_totalAnterior = conFact_sql.total
	v_totalImpuAnterior = conFact_sql.impuesto
	
	
	v_netoImpuesto =  v_unitario * v_cantidad 	
	v_ImpuestoFinanc = v_netoImpuesto  * (v_razonimp/100)

	*v_impuestos = v_total - v_unitario
	
	
	
	v_netoActu = (v_netoImpuesto ) + v_netoAnterior
	*v_subtotalActu = (v_netoImpuesto ) + v_subtotalAnterior
	v_totalImpuestoActu = v_ImpuestoFinanc + v_totalImpuAnterior
	*v_totalActu = v_unitario + v_totalAnterior
	v_totalActu = v_netoActu + v_totalImpuestoActu 


	
	*** ACTUALIZO FACTURA ***
	
	DIMENSION lamatriz1(3,2)

	lamatriz1(1,1)='neto'
	lamatriz1(1,2)= ALLTRIM(STR(v_netoActu,13,2))
	lamatriz1(2,1)='impuesto'
	lamatriz1(2,2)= ALLTRIM(STR(v_totalImpuestoActu,13,2))
	lamatriz1(3,1)='total'
	lamatriz1(3,2)= ALLTRIM(STR(v_totalActu,13,2))
	

	
	p_tipoope     = 'U'
	p_condicion   = " idfactprove = "+ ALLTRIM(STR(p_idfactura))
	v_titulo      = " LA MODIFICACI�N "
	
	p_tabla     = 'factuprove'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionF
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
		 RETURN .F.
  	ENDIF  
	

	*** INSERTO DETALLE EN  DETAFACTU ***
		v_idfactura = p_idfactura
		v_articulo = v_codigo
		v_idconcepto = 0 
		v_servicio = 0
		v_cantidad = v_cantidad
		v_unidad = oeImp.unidad
		v_cantidadFC = v_cantidad
		v_unidadFC	= v_unidad 
		v_detalle = oeImp.detalle
		v_unitario = v_unitario
		v_impuestos = v_ImpuestoFinanc
		v_codigoCta = ""
		v_nombreCta = ""
		v_cuota = 0
		v_cantidadCtas = 0
		v_padron = 0
		v_idimpuesto = v_impuesto
		v_razonImpuesto = v_razonimp
		v_totalArt = v_netoImpuesto + v_ImpuestoFinanc
		v_netoArt = v_netoImpuesto 
		v_codigoprov		 =  ''
		v_costo				 = v_unitario 
		v_margen			 = 0.00
				

		
		*** GUARDO DETALLE de ARTICULOS DE LA FACTURA ***	
		DIMENSION lamatriz2(13,2)		
		
			*IF !EMPTY(tmpgrilla.articulo) THEN 
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				
				v_idfacturah = maxnumeroidx("idfactproveh","I","factuproved",1)

				
					
			
				
				lamatriz2(1,1)='idfactprove'
				lamatriz2(1,2)= ALLTRIM(STR(v_idfactura))
				lamatriz2(2,1)='idfactproveh'
				lamatriz2(2,2)= ALLTRIM(STR(v_idfacturah ))
				lamatriz2(3,1)='articulo'
				lamatriz2(3,2)= "'"+ALLTRIM(v_articulo)+"'"
				lamatriz2(4,1)='codigoprov'
				lamatriz2(4,2)= "'"+ALLTRIM(v_codigoprov)+"'"
				lamatriz2(5,1)='cantidad'
				lamatriz2(5,2)= ALLTRIM(STR(v_cantidad))
				lamatriz2(6,1)='unidad'
				lamatriz2(6,2)= "'"+ALLTRIM(v_unidad)+"'"
				lamatriz2(7,1)='detalle'
				lamatriz2(7,2)= "'"+ALLTRIM(v_detalle)+"'"
				lamatriz2(8,1)='unitario'
				lamatriz2(8,2)= ALLTRIM(STR(v_unitario,13,4))
				lamatriz2(9,1)='impuestos'
				lamatriz2(9,2)= ALLTRIM(STR(v_impuestos,13,4))
				lamatriz2(10,1)='total'
				lamatriz2(10,2)= ALLTRIM(STR(v_totalArt,13,4))
				lamatriz2(11,1)='impuesto'
				lamatriz2(11,2)= ALLTRIM(STR(v_idimpuesto))
				lamatriz2(12,1)='razon'
				lamatriz2(12,2)= ALLTRIM(STR(v_razonImpuesto,13,4))
				lamatriz2(13,1)='margengan'
				lamatriz2(13,2)= ALLTRIM(STR(v_margen,13,4))
			

				p_tabla     = 'factuproved'
				p_matriz    = 'lamatriz2'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
				ELSE
				
					DIMENSION lamatriz3(6,2)
		
				
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					
				
					lamatriz3(1,1)='idfactprove'
					lamatriz3(1,2)= ALLTRIM(STR(v_idfactura))
					lamatriz3(2,1)= 'impuesto'
					lamatriz3(2,2)= ALLTRIM(STR(v_impuesto))
					lamatriz3(3,1)= 'detalle'
					lamatriz3(3,2)= "'"+ALLTRIM(v_detalleIMP)+"'"
					lamatriz3(4,1)= 'neto'
					lamatriz3(4,2)= ALLTRIM(STR(v_netoImpuesto,13,2))
					lamatriz3(5,1)= 'razon'
					lamatriz3(5,2)= ALLTRIM(STR(v_razonImpuesto,13,2))
					lamatriz3(6,1)= 'importe'
					lamatriz3(6,2)= ALLTRIM(STR(v_impuestos,13,2))
					
					
			
						
					p_tabla     = 'factuproveimp'
					p_matriz    = 'lamatriz3'
					p_conexion  = vconeccionF
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
					ENDIF
									
				ENDIF						

		RETURN .T.

ENDFUNC 







*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Asientos Contables como Minutas
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaAsiContables
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Asientos Contables a Importar -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	


		if file(".\asientoscar.dbf") THEN
			if used("asientoscar") then
				sele asientoscar
				use
			endif
			DELETE FILE .\asientoscar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\asientoscar FREE ( numero I,fecha C(8),codigocta C(20), debe Y, haber y, detalle  C(100))			
					
		SELECT asientoscar
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

	
		*** Busco el Plan de Cuentas Activo ***

		sqlmatriz(1)=" SELECT * from plancuentasd  "
		sqlmatriz(2)=" where idplan = "+ALLTRIM(STR(_SYSIDPLAN))
		verror=sqlrun(vconeccionF,"plancuentas_sql")

		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA Plan de Cuentas Activo",0+48+0,"Error")
		*** me desconecto	
			=abreycierracon(vconeccionF,"")
		    RETURN 
		ENDIF 
					
		SELECT * FROM plancuentas_sql INTO TABLE planactivo 
		SELECT planactivo
		INDEX on ALLTRIM(codigocta) TAG codigocta
		USE IN plancuentas_sql 
		
	
		SELECT asientoscar
		ALTER table asientoscar ADD COLUMN codigoctab c(20)
		ALTER table asientoscar ADD COLUMN nombrecta c(200)
		ALTER table asientoscar ADD COLUMN idpland i
		ALTER table asientoscar ADD COLUMN idasiento i
		ALTER table asientoscar ADD COLUMN detaasto c(50)
		ALTER table asientoscar ADD COLUMN imputable c(1)
		
	
		
		SET RELATION TO ALLTRIM(codigocta) INTO planactivo
		
		GO TOP 
		replace ALL nombrecta WITH planactivo.nombrecta, idpland WITH planactivo.idpland , codigoctab WITH STRTRAN(separarcadena(STRTRAN(ALLTRIM(codigocta)+'00','.','')),'.00',''), ;
					imputable WITH ALLTRIM(planactivo.imputable)
		replace codigoctab WITH STRTRAN(separarcadena(STRTRAN(ALLTRIM(codigocta)+'00','.','')),'.00','') FOR idpland = 0
		*** Numero los asientos a importar 	
	  * Obtengo el idasiento nuevo y el numero de asiento nuevo por cada vez que el numero de asiento cambia
		v_idasientoimp = maxnumeroidx("idasiento","I","asientos",0)
		v_numeroimp	= maxnumeroidx("numero","I","asientos",0)
	
		SELECT asientoscar
		INDEX on ALLTRIM(fecha)+STR(numero) TAG numero
		SET ENGINEBEHAVIOR 70
		SELECT numero , SUM(debe-haber) as saldo, ALLTRIM(fecha)+STR(numero) as orden FROM asientoscar   INTO TABLE asientosnro HAVING saldo = 0 ORDER BY orden GROUP BY orden
		SET ENGINEBEHAVIOR 90
		
		

		GO TOP 
		DO WHILE !EOF()
			v_idasientoimp = v_idasientoimp + 1
			v_numeroimp = v_numeroimp + 1
			SELECT asientoscar 
			replace idasiento WITH v_idasientoimp , detaasto WITH "A.Nro.: "+ALLTRIM(STR(asientosnro.numero))+" - "+ALLTRIM(detalle) FOR numero = asientosnro.numero 
			replace numero WITH v_numeroimp FOR numero = asientosnro.numero
			SELECT asientosnro
			SKIP 
		ENDDO 

		SELECT asientoscar		

		

		v_ret = .F.
*!*		
		DO FORM cargaasicontables WITH "asientoscar",.f. TO v_ret 

	
		IF v_ret = .F.
			RETURN 0
		ENDIF 

		v_idasientoultimo = maxnumeroidx("idasiento","I","asientos",v_idasientoimp)
		v_numeroultimo	= maxnumeroidx("numero","I","asientos",v_numeroimp)


		
		SELECT asientoscar		
		GO TOP 
		
		DO WHILE !EOF()
		
			IF asientoscar.idasiento > 0 THEN 
				
				a_idasientod 	= "0"
				a_numero		= asientoscar.numero
				a_fecha			= asientoscar.fecha
				a_codigocta		= asientoscar.codigocta
				a_nombrecta		= asientoscar.nombrecta
				a_debe 			= asientoscar.debe
				a_haber	  		= asientoscar.haber
				a_detalle  		= asientoscar.detalle
				a_ejercicio		= _SYSEJERCICIO
				a_idpland		= asientoscar.idpland
				a_detaasiento	= asientoscar.detaasto
				a_idasiento 	= asientoscar.idasiento
				a_idtipoasi		= 1
				a_idastomode 	= 0
				a_idfiltro	 	= 0
				a_idastoe		= 1
							

				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
		
				DIMENSION lamatriz1(16,2)
				
				lamatriz1(1,1)='idasientod'
				lamatriz1(1,2)= a_idasientod
				lamatriz1(2,1)='numero'
				lamatriz1(2,2)=ALLTRIM(STR(a_numero))
				lamatriz1(3,1)='fecha'
				lamatriz1(3,2)= "'"+ALLTRIM(a_fecha)+"'"
				lamatriz1(4,1)='codigocta'
				lamatriz1(4,2)="'"+ALLTRIM(a_codigocta)+"'"
				lamatriz1(5,1)='nombrecta'
				lamatriz1(5,2)="'"+ALLTRIM(a_nombrecta)+"'"
				lamatriz1(6,1)='debe'
				lamatriz1(6,2)=alltrim(STR(a_debe,12,2))
				lamatriz1(7,1)='haber'
				lamatriz1(7,2)=alltrim(STR(a_haber,12,2))
				lamatriz1(8,1)='detalle'
				lamatriz1(8,2)= "'"+ALLTRIM(a_detalle)+"'"
				lamatriz1(9,1)='ejercicio'
				lamatriz1(9,2)= ALLTRIM(STR(a_ejercicio))
				lamatriz1(10,1)='idpland'
				lamatriz1(10,2)= ALLTRIM(STR(a_idpland))
				lamatriz1(11,1)='detaasiento'
				lamatriz1(11,2)= "'"+ALLTRIM(a_detaasiento)+"'"
				lamatriz1(12,1)='idasiento'
				lamatriz1(12,2)= ALLTRIM(STR(a_idasiento))
				lamatriz1(13,1)='idtipoasi'
				lamatriz1(13,2)= ALLTRIM(STR(a_idtipoasi))
				lamatriz1(14,1)='idastomode'
				lamatriz1(14,2)= ALLTRIM(STR(a_idastomode))
				lamatriz1(15,1)='idfiltro'
				lamatriz1(15,2)= ALLTRIM(STR(a_idfiltro))
				lamatriz1(16,1)='idastoe'
				lamatriz1(16,2)= ALLTRIM(STR(a_idastoe))
		
				p_tabla     = 'asientos'
				p_matriz    = 'lamatriz1'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en Importaci�n y Carga de Asientos ",0+48+0,"Error")
				    RETURN 
				ENDIF  
			ENDIF 
				
			SELECT asientoscar
			SKIP 					
			
		ENDDO 
		
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT asientoscar
	USE IN asientoscar
	
	ENDIF 	&& 1- Carga de Archivo de comprobantes de ingreso y egeso -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos 
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
	*	=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/*/*/*/*/*/*/*/*/*/*/*/*/*

*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Carga de Plan de Cuentas 
*/------------------------------------------------------------------------------------------------------------
FUNCTION CargaPlanCuentas
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Plan de Cuentas -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	


		if file(".\plancar.dbf") THEN
			if used("plancar") then
				sele plancar
				use
			endif
			DELETE FILE .\plancar.dbf
		ENDIF
		
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es V�lida",16,"Error de B�squeda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\plancar FREE ( idplan I,codigocta C(20) ,nombrecta C(50), imputable c(1), activa c(1), detalle c(50), idpland i, idplandp i, codigo c(20), nivel c(1))
					
		SELECT plancar
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		COUNT TO v_registros 
		IF v_registros > 0 THEN 
			*Elimino las Cuentas que tenga el sistema
			*La carga debe hacerce con la tabla vacia
			sqlmatriz(1)=" delete from plancuentasd "
			verror=sqlrun(vconeccionF,"plan")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Cuentas Existentes... ",0+48+0,"Error")
			    RETURN 0
			ENDIF
		ENDIF 		
	
	
		sqlmatriz(1)=" SELECT * from plancuentas  where idplan = 1 "
		verror=sqlrun(vconeccionF,"plancuentas_sql")

		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA Plan de Cuentas ",0+48+0,"Error")
		*** me desconecto	
			=abreycierracon(vconeccionF,"")
		    RETURN 
		ENDIF 
					
		SELECT  plancuentas_sql 
		GO TOP 
		IF EOF() THEN
			v_fechade = DTOS(DATE(YEAR(DATE()),01,01))
			v_fechaha = DTOS(DATE(YEAR(DATE()),12,31))
			sqlmatriz(1)=" INSERT INTO plancuentas (idplan, fechad, fechah, detalle) values (1,'"+v_fechade+"','"+v_fechaha+"','PLAN DE CUENTAS') "
			verror=sqlrun(vconeccionF,"plancuentas_sql")

			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la B�SQUEDA Plan de Cuentas ",0+48+0,"Error")
			*** me desconecto	
				=abreycierracon(vconeccionF,"")
			    RETURN 0
			ENDIF 
		
		ENDIF 
		USE IN plancuentas_sql 

		SELECT plancar		
		GO TOP 
		DIMENSION lamatriz1(10,2)
	
		DO WHILE !EOF()
		
			IF plancar.idpland > 0 THEN 
				
				a_idplan		= plancar.idplan
				a_codigocta		= plancar.codigocta
				a_nombrecta		= plancar.nombrecta
				a_imputable		= plancar.imputable
				a_activa		= plancar.activa
				a_detalle		= plancar.detalle
				a_idpland  		= plancar.idpland
				a_idplandp 		= plancar.idplandp
				a_codigo		= plancar.codigo
				a_nivel			= plancar.nivel
							

				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
		
				
				lamatriz1(1,1)='idplan'
				lamatriz1(1,2)= ALLTRIM(STR(a_idplan))
				lamatriz1(2,1)='codigocta'
				lamatriz1(2,2)="'"+ALLTRIM(a_codigocta)+"'"
				lamatriz1(3,1)='nombrecta'
				lamatriz1(3,2)= "'"+ALLTRIM(STRTRAN(a_nombrecta,'\',' '))+"'"
				lamatriz1(4,1)='imputable'
				lamatriz1(4,2)="'"+ALLTRIM(a_imputable)+"'"
				lamatriz1(5,1)='activa'
				lamatriz1(5,2)="'"+ALLTRIM(a_activa)+"'"
				lamatriz1(6,1)='detalle'
				lamatriz1(6,2)="'"+ALLTRIM(STRTRAN(a_detalle,'\',' '))+"'"
				lamatriz1(7,1)='idpland'
				lamatriz1(7,2)=ALLTRIM(STR(a_idpland))
				lamatriz1(8,1)='idplandp'
				lamatriz1(8,2)= ALLTRIM(STR(a_idplandp))
				lamatriz1(9,1)='codigo'
				lamatriz1(9,2)= "'"+ALLTRIM(a_codigo)+"'"
				lamatriz1(10,1)='nivel'
				lamatriz1(10,2)= "'"+ALLTRIM(a_nivel)+"'"
		
				p_tabla     = 'plancuentasd'
				p_matriz    = 'lamatriz1'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en Importaci�n y Carga de Asientos ",0+48+0,"Error")
				    RETURN 0
				ENDIF  
				
			ENDIF 
				
			SELECT plancar
			SKIP 					
			
		ENDDO 
		RELEASE lamatriz1
		
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT plancar
	USE IN plancar
	
	ENDIF 	&& 1- Carga de Archivo de comprobantes de ingreso y egeso -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos 
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
	*	=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************




*/*/*/*/*/*/*/*/*/*/*/*/*/*

*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------
*/ Asociar Cablemodems con Cuentas de Clientes 
*/ Si p_archivo = '(ACTUALIZA)INTERNET' --> entonces actualiza el perfil con los datos de acuerdo al cablemodem y agrega 
*/ aquellos cablemodems que no est�n a los actuales 
*/------------------------------------------------------------------------------------------------------------
FUNCTION AsociarCablemodems
	PARAMETERS p_idimportap, p_archivo, p_func
	IF p_func = 9 then && Chequeo de Funcion retorna 9 si es valida
		RETURN p_func
	ENDIF 
*/**************************************************************

	IF p_func = -1 THEN  &&  Eliminacion de Registros
*!*			p_func = fdeltablas("cablemodems",p_idimportap)
*!*			RETURN p_func 
	

	ENDIF 
*/**************************************************************
	IF p_func = 1 then && 1- Carga de Archivo de Plan de Cuentas -
		p_archivo = alltrim(p_archivo)
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	

			p_actualizar = substr(UPPER(p_archivo)+SPACE(12),1,12)
			p_archivo    = STRTRAN(UPPER(p_archivo),"(ACTUALIZAR)",'')
		
			IF ALLTRIM(p_actualizar) <> "(ACTUALIZAR)" THEN 		
				*Elimino las Cuentas que tenga el sistema
				*La carga debe hacerce con la tabla vacia
				sqlmatriz(1)=" delete from bocaservicios where identidadh in "
				sqlmatriz(2)=" ( select h.identidadh from entidadesh h left join servicios s on s.servicio = h.servicio where s.detalle = '"+ALLTRIM(UPPER(p_archivo))+"')"
				verror=sqlrun(vconeccionF,"del_bocas")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Bocas de Servicios... ",0+48+0,"Error")
				    RETURN 0
				ENDIF
			ENDIF 
			
	*!*		Obtengo el Codigo del Servicio al cual se asocian los cablemodems
			sqlmatriz(2)=" select h.servicio, s.detalle from entidadesh h left join servicios s on s.servicio = h.servicio where s.detalle = '"+ALLTRIM(UPPER(p_archivo))+"'"
			verror=sqlrun(vconeccionF,"servicio")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del servicio... ",0+48+0,"Error")
			    RETURN 0
			ENDIF	
				
		
			*Veo el idimportap de la ultima carga de Cablemodems
			sqlmatriz(1)=" select MAX(idimportap) as idimportap from cablemodems "
			verror=sqlrun(vconeccionF,"maxidimporta")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la ultima importaci�n de Cablemodems ... ",0+48+0,"Error")
			    RETURN 0
			ENDIF
			v_ultimoidimportap= maxidimporta.idimportap 
			v_inicialempre	= UPPER(SUBSTR(ALLTRIM(_SYSEMPRESA),1,1))
			v_servicio 		= servicio.servicio
			
			USE IN maxidimporta
			USE IN servicio
				
			*Traigo los Cablemodems cargados en la ultima lectura de archivo
			sqlmatriz(1)=" select * from cablemodems where idimportap = "+ALLTRIM(STR(v_ultimoidimportap))+" and telefono like '("+v_inicialempre+"%'"
			verror=sqlrun(vconeccionF,"cablemodems")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la ultima importaci�n de Cablemodems ... ",0+48+0,"Error")
			    RETURN 0
			ENDIF

			SELECT cablemodems		
			GO TOP 
			DIMENSION lamatriz1(14,2)
		
			DO WHILE !EOF()

				** Busco las bocaservicios que coincidan con la actualizada, si est� la actualizo, sino la cargo de nuevo 
				sqlmatriz(1)=" select * from bocaservicios where TRIM(bocanumero) = '"+ALLTRIM(UPPER(cablemodems.bocanumero))+"'"
				verror=sqlrun(vconeccionF,"existe_boca")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Bocas de Servicios... ",0+48+0,"Error")
				    RETURN 0
				ENDIF
				SELECT existe_boca
				GO TOP 
				IF !EOF() AND existe_boca.identidadh > 0 THEN 
					** actualizo los datos de la boca con el valor del perfil seleccionado para esa boca 
					sqlmatriz(1)=" update bocaservicios set unidadref= '"+ALLTRIM(cablemodems.perfil)+"' where TRIM(bocanumero) = '"+ALLTRIM(cablemodems.bocanumero)+"'"
					verror=sqlrun(vconeccionF,"actuboca")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la Eliminaci�n de Bocas de Servicios... ",0+48+0,"Error")
					    RETURN 0
					ENDIF		
				
				ELSE 

					v_entidad = SUBSTR(cablemodems.telefono,3,(ATC(')',cablemodems.telefono)-3))
					
					sqlmatriz(1)=" select identidadh from entidadesh  where entidad ="+v_entidad+" and servicio = "+ALLTRIM(STR(v_servicio))+" and cuenta = 1 "
					verror=sqlrun(vconeccionF,"entidadh")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Entidades... ",0+48+0,"Error")
					    RETURN 0
					ENDIF

					SELECT entidadh 
						
					IF !EOF() AND entidadh.identidadh > 0 THEN 
						
						a_identidadh    = entidadh.identidadh
						a_bocanumero	= UPPER(ALLTRIM(cablemodems.bocanumero))
						a_facturar		= IIF(UPPER(SUBSTR(ALLTRIM(cablemodems.estado),1,6))="ACTIVO","S","N")
						a_habilitado	= IIF(UPPER(SUBSTR(ALLTRIM(cablemodems.estado),1,6))="ACTIVO","S","N")
						a_direccion		= ALLTRIM(cablemodems.direccin) 
						a_unidadref		= ALLTRIM(cablemodems.perfil)	

						p_tipoope     = 'I'
						p_condicion   = ''
						v_titulo      = " EL ALTA "

						lamatriz1(1,1)='identidadh'
						lamatriz1(1,2)= ALLTRIM(STR(a_identidadh))
						lamatriz1(2,1)='bocanumero'
						lamatriz1(2,2)="'"+ALLTRIM(a_bocanumero)+"'"
						lamatriz1(3,1)='ruta1'
						lamatriz1(3,2)="0"
						lamatriz1(4,1)='folio1'
						lamatriz1(4,2)="0"
						lamatriz1(5,1)='ruta2'
						lamatriz1(5,2)="0"
						lamatriz1(6,1)='folio2'
						lamatriz1(6,2)="0"
						lamatriz1(7,1)='facturar'
						lamatriz1(7,2)="'"+a_facturar+"'"
						lamatriz1(8,1)='habilitado'
						lamatriz1(8,2)= "'"+a_habilitado+"'"
						lamatriz1(9,1)='direccion'
						lamatriz1(9,2)= "'"+ALLTRIM(a_direccion)+"'"
						lamatriz1(10,1)='idbocaser'
						lamatriz1(10,2)= "0"
						lamatriz1(11,1)='ubicacion'
						lamatriz1(11,2)= "' '"
						lamatriz1(12,1)='idtiposer'
						lamatriz1(12,2)= "1"
						lamatriz1(13,1)='valorref'
						lamatriz1(13,2)= "0.00"
						lamatriz1(14,1)='unidadref'
						lamatriz1(14,2)= "'"+ALLTRIM(a_unidadref)+"'"
				
						p_tabla     = 'bocaservicios'
						p_matriz    = 'lamatriz1'
						p_conexion  = vconeccionF
						IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
						    MESSAGEBOX("Ha Ocurrido un Error en Asociaci�n de Cablemodems con Cuentas ",0+48+0,"Error")
						    RETURN 0
						ENDIF  
						
					ENDIF 
					
				ENDIF 	
				
				SELECT existe_boca 
				USE IN existe_boca
						
				SELECT cablemodems
				SKIP 					
				
			ENDDO 
			RELEASE lamatriz1
			
			** Obtengo los Cablemodems que no tienen referencia con cuentas 
			** deben controlarse, se exportan a un archivo .CSV para su procesamiento
			** posterior
			*Traigo los Cablemodems cargados en la ultima lectura de archivo
			sqlmatriz(1)=" select * from cablemodems where idimportap = "+ALLTRIM(STR(v_ultimoidimportap)) &&+" and telefono like '("+v_inicialempre+"%' "
			sqlmatriz(2)=" and TRIM(bocanumero) not in (select TRIM(bocanumero) from bocaservicios )"
			verror=sqlrun(vconeccionF,"sincuentas")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la ultima importaci�n de Cablemodems ... ",0+48+0,"Error")
			    RETURN 0
			ENDIF
			SELECT sincuentas
			GO TOP 
			IF !EOF() THEN 
				COPY TO cm_verificar.csv TYPE CSV
	 			APLIC=CREATEOBJECT("WSCript.Shell")
				APLIC.RUN("cm_verificar.csv")
				RELEASE APLIC 
			ENDIF 
			
			USE IN sincuentas
	*/*/*/*/*/*/
			=abreycierracon(vconeccionF,"")	
			SELECT cablemodems
			USE IN cablemodems
		
		
	ENDIF 	&& 1- Carga de Archivo de comprobantes de ingreso y egeso -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos 
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
	*	=fconsutablas(p_idimportap)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************
FUNCTION FEtiquetasCM
PARAMETERS p_idimportap
	vconeccionF=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="  select *  from localidades where TRIM(localidad) = '"+ALLTRIM(_syslocalidad)+"'"
	verror=sqlrun(vconeccionF,"locali_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de Localidades... ",0+48+0,"Error")
	    RETURN 
	ENDIF
	v_nomlocalidad = locali_sql.nombre
	USE IN locali_sql

	sqlmatriz(1)="  select *  from cablemodems where TRIM(UPPER(ciudadin)) = '"+ALLTRIM(v_nomlocalidad)+"' and idimportap = "+STR(p_idimportap)+" and TRIM(lcase(bocanumero)) not in (select TRIM(lcase(detalleb)) as bocaservicio from etiquetas ) "
	verror=sqlrun(vconeccionF,"cablem_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de datos de Cablemodems... ",0+48+0,"Error")
	    RETURN 
	ENDIF
	SELECT cablem_sql
	GO top
	IF !EOF() THEN 
		IF MESSAGEBOX("Existen Cablemodems en el FlowDat sin Etiquetar..."+CHR(13)+" Desea generar las Etiquetas Correspondientes",4+48,"Error de B�squeda") = 6 THEN 
			

		* Busco el Codigo de Articulo para registrar las etiquetas de Cablemodems
			oeObj			= CREATEOBJECT('oeclass')		
			v_codTab	=  oeObj.getCodigoOp("CABLEMODEM GENERICO") && Obtengo: CODIGO_TABLA. El caracter '_' es el de separaci�n
			v_nPos 		= AT('_',v_codTab) &&Retorna la posici�n donde aparece el caracter de separacion utilizado (_)
			v_codigo	= SUBSTR(v_codTab,1,v_nPos-1) && Retorna el c�digo
			v_tabla		= SUBSTR(v_codTab,v_nPos+1)	&& Retorna el resto de la cadena, que corresponde a la tabla
			
			
			*** Busco el impuesto para el articulo o concepto a agregar ***
			
			DO CASE
			CASE ALLTRIM(v_tabla) = "articulos"
				sqlmatriz(1)="SELECT articulo, detalle FROM articulos  WHERE  articulo = '"+ALLTRIM(v_codigo)+"'"
			OTHERWISE
				MESSAGEBOX("No se reconoce la operaci�n especial que intenta agregar",0+48+0,"Error al obtener el impuesto")
				RETURN 

			ENDCASE
			verror=sqlrun(vconeccionF,"oeImp")
			IF verror=.f.
				MESSAGEBOX("Error al obtener el Impuesto para la Operaci�n Especial",0+48+0,"Error")
				* me desconecto
				=abreycierracon(vconeccionF,"")
				RETURN 
			ENDIF 
			
			
			SELECT oeImp
			GO TOP 
			vcmarticulo = ""
			vcmdetalle  = ""
			vcmdetalleb = ""
			IF !EOF() THEN 
				vcmarticulo = ALLTRIM(v_codigo)
				vcmdetalle  = ALLTRIM(oeImp.detalle)
			ENDIF 
			USE IN oeImp
			RELEASE oeObj
			
			
*********************************************************************************
************************ GENERO LAS ETIQUETAS QUE NECESITO ***********************
			SELECT cablem_sql
			v_eti_generadaINI="" 
			v_eti_generadaFIN=""
			DO WHILE !EOF() then 
				
				vcmdetalleb = cablem_sql.bocanumero
				ret=GeneraEtiquetas ("articulos",vcmarticulo, ALLTRIM(vcmarticulo)+"-"+ALLTRIM(vcmdetalle), 1, ALLTRIM(vcmdetalleb))
				v_eti_generadaINI = IIF(EMPTY(v_eti_generadaINI),IIF(EMPTY(ret),"",SUBSTR(ret,1,ATC(';',ret)-1)),v_eti_generadaINI)
				v_eti_generadaFIN = IIF(EMPTY(ret),"",SUBSTR(ret,ATC(';',ret)+1))
					
				SELECT cablem_sql
				SKIP 
			ENDDO 

			IF !EMPTY(v_eti_generadaINI) AND !EMPTY(v_eti_generadaFIN) THEN 
				MESSAGEBOX("Etiquetas Generadas: "+ALLTRIM(v_eti_generadaINI)+" a "+ALLTRIM(v_eti_generadaFIN)+" ",0+64,"Etiquetas " )					
			ENDIF 

*********************************************************************************
*********************************************************************************		
		ENDIF 
	ENDIF 	
	USE IN cablem_sql
	=abreycierracon(vconeccionF,"")	
	
ENDFUNC 