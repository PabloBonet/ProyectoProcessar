*/ PARAMETROS
*--------------
*/ Todas las funciones de la libreria reciben 3 parametros
*/ 		P_idimportap : indice de la tabla importadatosp para localizar el registro que tiene los parametros de ejecución
*/ 		P_archivo	 : Si la funcion se utiliza para importar datos, en este vendrá el archivo que se importará
*/ 		P_func		 : Este parametro le indica a la funcion si se debe grabar , eliminar, chequear, etc 
*/
*/ RETORNOS de las funciones en la librería
*/ -----------------------------------------
*/ Variables que indican el comportamiento de la funcion para comunicar resultados 
*/ Es necesario para saber si la función se ejecuto correctamente o se produjeron errores

*/ valor a devolver:
*/   'CHECK'   =  9 : Indica que solo se realiza un chequeo de la existencia de la funcion - retorna 9 si la funcion existe
*/	 'MUESTRA' =  2 : Muestra los registros Importados
*/	 'GUARDO'  =  1 : Indica que si se realizó una grabación, esta efectivamente se realizó .
*/   'NEUTRO'  =  0 : La función no reporto errores y el resultado no afecta en nada la ejecucion de instrucciones siguientes
*/   'ELIMINO' = -1 : Indica si se pudo eliminar los registros en caso de solicitar la baja
*/   'ERROR'   = -9 : Indica que la funcion reportó un error en la ejecución 
*/ IMPORTANTE: Todas las funciones deben ser realizadas teniendo en cuenta al menos los parametros de ingreso y retorno 
*/ 				Explicados arriba
*/------------------------------------------------------------------------------------------------------------
*/------------------------------------------------------------------------------------------------------------

* Función para Intentos de ejecuciones de funciones, devuelve .F. Falso si la función no existe o da error 
FUNCTION chkfunction
	LPARAMETERS pfuncion
	ON ERROR vfnvalida=.f. 
	vfnvalida = .t. 
	eje = "vretorno = "+ALLTRIM(pfuncion)
	&eje 
	ON ERROR  
	RETURN vfnvalida
ENDFUNC 

* Funcion para Visualizacion de los datos de la importación Seleccionada, Recibe como parametro el "idimportap"
FUNCTION Fconsutablas
	PARAMETERS paraidimportap, paraformulario, paramodifica
		IF TYPE('paraformulario')<>'C' THEN 
			paraformulario = 'consultatablas'
		ENDIF 
		vconeccionF=abreycierracon(0,_SYSSCHEMA)
			sqlmatriz(1)="Select p.*, i.tabla, i.detalle as detallea , i.funcion, i.servicio from importadatosp p left join importadatos i on i.idimporta = p.idimporta "
			sqlmatriz(2)=" where p.idimportap = "+STR(paraidimportap)
			verror=sqlrun(vconeccionF,"importadatosp_sql01")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Búsqueda de Datos Importados ",0+48+0,"Error")
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

* Funcion para Eliminación de los registros de una tabla , recibe como parametro "Tabla" "idimportap"
FUNCTION fdeltablas
	PARAMETERS pnomtabla, paraidimportap
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			boton=messagebox("   Se van a Eliminar los Registros Cargados ( "+pnomtabla+" ),"+CHR(13)+CHR(13)+"¿ Confirma que desea Eliminarlos ?",4+32,"Información del Sistema")
			if boton = 6 then
				sqlmatriz(1)=" delete from "+pnomtabla+" where idimportap ="+STR(paraidimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Registros ... ",0+48+0,"Error")
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
*/ Carga de mediciones de la Central Telefónica Huawei
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
	IF p_func = 1 then && 1- Carga de Archivo de Telefonía -
		p_archivo = alltrim(p_archivo)
	
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
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
			boton=messagebox("   Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"¿ DESEA SOBREESCRIBIRLOS ?",52,"Información del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from medtelefono where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de datos de mediciones de telefonia... ",0+48+0,"Error")
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
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de LLamadas Telefónicas ",0+48+0,"Error")
			ENDIF 
			
			eje = "sele "+STRTRAN(UPPER(v_archillamadas),'.DBF','') 
			&eje
			SKIP 					
		ENDDO 
	
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	ENDIF 	&& 1- Carga de Archivo de Telefonía -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Telefonía 

	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap)	
	ENDIF && 2- Visualiza Datos de Telefonía -
	
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
* GENERA UN ARCHIVO TEMPORAL EN EL CUAL ESTÁN TODAS LAS LLAMADAS
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
*/ Fin de Funciones de Carga de Central Telefónica Huawei
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
			boton=messagebox("   Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"¿ DESEA SOBREESCRIBIRLOS ?",52,"Información del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from cpptelefono where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de datos de CPP ... ",0+48+0,"Error")
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
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
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
					=messagebox("EL ARCHIVO DE CARGA ES ERRÓNEO",16,"Error de Carga")
					RETURN
				ENDIF
			ELSE
				=messagebox("EL ARCHIVO DE CARGA ES ERRÓNEO",16,"Error de Carga")
				RETURN
			ENDIF
		ELSE
			=messagebox("EL ARCHIVO DE CARGA ES ERRÓNEO",16,"Error de Carga")
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
			boton=messagebox("  Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"¿ DESEA SOBREESCRIBIRLOS ?",52,"Información del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from factclaro where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de datos de Claro ... ",0+48+0,"Error")
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
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
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
			IF !m.excel.range("A2").value = "Número de Línea" THEN 
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
		UPDATE claro set pabono = vppabono, pserv = vppserv, pcargos = vppcargos, paire = vppaire, ;
						pldn = vppldn, pldi = vppldi, pldim = vppldim, pdata = vppdata, peq = vppeq, pvarios = vppvarios
		
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

		m.excel.Workbooks.CLOSE
		m.excel.QUIT  

*!*			IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 1) THEN
*!*				GO 2
*!*				IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 2) THEN
*!*					GO BOTT
*!*					IF (VAL(SUBSTR(CPPTMP.MEDIDAS,1,2)) = 99) THEN
*!*					ELSE
*!*						=messagebox("EL ARCHIVO DE CARGA ES ERRÓNEO",16,"Error de Carga")
*!*						RETURN
*!*					ENDIF
*!*				ELSE
*!*					=messagebox("EL ARCHIVO DE CARGA ES ERRÓNEO",16,"Error de Carga")
*!*					RETURN
*!*				ENDIF
*!*			ELSE
*!*				=messagebox("EL ARCHIVO DE CARGA ES ERRÓNEO",16,"Error de Carga")
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
			lamatriz(1,2) = "'"+substr(alltrim(claro.telefono),1,(LEN(alltrim(claro.telefono))-1))+"'"
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
			boton=messagebox("  Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"¿ DESEA SOBREESCRIBIRLOS ?",52,"Información del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from mservicios where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de datos de Mediciones de Servicios ... ",0+48+0,"Error")
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
		    MESSAGEBOX("No se Pueden Generar los Datos , No se ha asignado un Servicio para la Importación "+CHR(13)+" Por favor se requiere fijar el Servicio para identificar las Mediciones ",0+48+0,"Error")
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
		SELECT *, 100000000.000 as manterior, 100000000.000 as mactual, 100000000.000 as consumo, 100000000 as idimportap  FROM bocaserv_sql INTO TABLE mservicios
		replace ALL manterior WITH 0, mactual WITH 0, consumo WITH 0, idimportap WITH p_idimportap
		
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
		
	
		sqlmatriz(1)=" select bocanumero, manterior, mactual, consumo, idimportap "
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
		

		DIMENSION lamatriz(7,2)
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
			lamatriz(4,1) = 'consumo'
			lamatriz(4,2) = alltrim(str(mservicios.consumo,12,4))
			lamatriz(5,1) = 'idmservi'
			lamatriz(5,2) = '0'
			lamatriz(6,1) = 'idimportap'
			lamatriz(6,2) = alltrim(STR(p_idimportap))
			lamatriz(7,1) = 'idbocaser'
			lamatriz(7,2) = alltrim(str(mservicios.idbocaser))

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
	IF p_func = 1 then && 1- Carga de Archivo de Telefonía -
		p_archivo = alltrim(p_archivo)
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
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
			boton=messagebox("   Los Datos ya fueron cargados,"+CHR(13)+CHR(13)+"¿ DESEA SOBREESCRIBIRLOS ?",52,"Información del Sistema")
			if boton = 6 then

				sqlmatriz(1)=" delete from cablemodems where idimportap ="+STR(p_idimportap)
				verror=sqlrun(vconeccionF,"sin_ret")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de datos de Cablemodems... ",0+48+0,"Error")
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

		DIMENSION lamatriz(32,2)
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
			lamatriz(18,1) = 'ipstats'
			lamatriz(18,2) = "'"+ALLTRIM(cablemodems.campo22)+"'"
			lamatriz(19,1) = 'ipcm'
			lamatriz(19,2) = "'"+ALLTRIM(cablemodems.campo23)+"'"
			lamatriz(20,1) = 'ipcpe'
			lamatriz(20,2) = "'"+ALLTRIM(cablemodems.campo24)+"'"
			lamatriz(21,1) = 'ipmta'
			lamatriz(21,2) = "'"+ALLTRIM(cablemodems.campo25)+"'"
			lamatriz(22,1) = 'nodo'
			lamatriz(22,2) = "'"+ALLTRIM(cablemodems.campo26)+"'"
			lamatriz(23,1) = 'modelocm'
			lamatriz(23,2) = "'"+ALLTRIM(cablemodems.campo27)+"'"
			lamatriz(24,1) = 'gestionid'
			lamatriz(24,2) = "'"+ALLTRIM(cablemodems.campo29)+"'"
			lamatriz(25,1) = 'emailcli'
			lamatriz(25,2) = "'"+ALLTRIM(cablemodems.campo30)+"'"
			lamatriz(26,1) = 'direccli'
			lamatriz(26,2) = "'"+ALLTRIM(cablemodems.campo31)+"'"
			lamatriz(27,1) = 'ciudadcli'
			lamatriz(27,2) = "'"+ALLTRIM(cablemodems.campo32)+"'"
			lamatriz(28,1) = 'telefono'
			lamatriz(28,2) = "'"+ALLTRIM(cablemodems.campo33)+"'"
			lamatriz(29,1) = 'downidx'
			lamatriz(29,2) = "'"+ALLTRIM(cablemodems.campo34)+"'"
			lamatriz(30,1) = 'upidx'
			lamatriz(30,2) = "'"+ALLTRIM(cablemodems.campo35)+"'"
			lamatriz(31,1) = 'idcablem'
			lamatriz(31,2) = '0'
			lamatriz(32,1) = 'idimportap'
			lamatriz(32,2) =  alltrim(STR(p_idimportap))

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
	ENDIF 	&& 1- Carga de Archivo de Telefonía -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Telefonía 

	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap)	
	ENDIF && 2- Visualiza Datos de Telefonía -
	
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
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\entidadescar FREE (entidad I, apellido C(100), nombre c(100), cargo C(100), compania C(100), cuit C(13), direccion C(100), ;
					localidad C(10), iva I,fechaalta C(8), telefono C(50), cp C(50), fax C(50), ;
					email C(254), web C(254), dni I, tipodoc C(3),  ;
					fechanac C(8), idafiptipd I)			
					
		SELECT entidadescar 
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		DIMENSION lamatriz(19,2)
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
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Cablemodems ",0+48+0,"Error")
			ENDIF 
			
			SELECT entidadescar
			SKIP 					
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT entidadescar
	USE IN entidadescar
	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap,'entidades',.T.)
	ENDIF && 2- Visualiza Datos de CPP -
*/**************************************************************
	lreto = p_func
	RETURN lreto
ENDFUNC  


*******************************************************

*/------------------------------------------------------------------------------------------------------------
*/ FINAL  Carga de Entidades
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
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\lineascar FREE (linea C(20), detalle C(254), codigoctac c(20), codigoctav C(20), margen N(13,4), codmin C(50), codmax C(50))			
					
		SELECT lineascar
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		DIMENSION lamatriz(7,2)
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
			
			SELECT lineascar
			SKIP 					
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT lineascar
	USE IN lineascar
	ENDIF 	&& 1- Carga de Archivo de CPP -
*/**************************************************************
*/**************************************************************
*/ && 2- Visualiza Datos de Claro
	IF p_func = 2 THEN && Llama al formulario para visualizar los datos de la tabla
		=fconsutablas(p_idimportap,'lineascar',.T.)
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
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
			=abreycierracon(vconeccionF,"")	
			RETURN 0
		ENDIF

		CREATE TABLE .\articuloscar FREE (articulo C(50), detalle C(254), unidad C(200), abrevia C(50), codbarra C(100), costo n(13,4), linea C(20), ;
		ctrlstock C(1), observa C(254), ocultar C(1), stockmin N(13,4), desc1 N(13,4), desc2 N(13,4), desc3 N(13,4), desc4 N(13,4), desc5 N(13,4), moneda I, ;
		impuesto I, margen N(13,4),proveedor I,codigop C(50))			
					
		SELECT articuloscar 
*		eje = "APPEND FROM "+p_archivo+" TYPE CSV"
 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje

		GO TOP 
		
		IF NOT EOF()
		
			*** Borro las tablas que voy a ingresar ***
			
			*** Borro articulos ***
			sqlmatriz(1)="delete from articulos "
			verror=sqlrun(vconeccion,"NoUso")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Registros de la tabla articulos ",0+48+0,"Eliminación de Registros")
			    RETURN -9
			ENDIF 
			
			*** Borro articulosimp ***
			sqlmatriz(1)="delete from articulosimp "
			verror=sqlrun(vconeccion,"NoUso")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Registros de la tabla articulosimp ",0+48+0,"Eliminación de Registros")
			    RETURN -9
			ENDIF 
					
			*** Borro listaprecioh (lista 1) ***
			sqlmatriz(1)="delete from listaprecioh where idlista = 1 "
			verror=sqlrun(vconeccion,"NoUso")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Registros de la tabla listaprecioh ",0+48+0,"Eliminación de Registros")
			    RETURN -9
			ENDIF
			
			*** Borro articulospro ***
			sqlmatriz(1)="delete from articulospro "
			verror=sqlrun(vconeccion,"NoUso")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Registros de la tabla articulospro ",0+48+0,"Eliminación de Registros")
			    RETURN -9
			ENDIF 
			 
			
			v_maximoListah = 0
			*** Calulo el Maximo de listaprecioh ***
			sqlmatriz(1)="select MAX(idlistah) as maxi from listaprecioh  "
			verror=sqlrun(vconeccion,"maxLIstah")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Registros de la tabla listaprecioh ",0+48+0,"Eliminación de Registros")
			    RETURN -9
			ELSE
				v_maximoListah = IIF(ISNULL(maxLIstah.maxi)=.T.,0,maxLIstah.maxi)
				v_maximoListah = v_maximoListah + 1
				** Modifico el indice idlistah para que tome el maximo valor como el indice autoincremental **
				sqlmatriz(1)="alter table listaprecioh auto_increment = "+ALLTRIM(STR(v_maximoListah ))
				verror=sqlrun(vconeccion,"modifauto")
				IF verror=.f.  
			    	MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Registros de la tabla listaprecioh(Error al modificar el autoincremental)",0+48+0,"Eliminación de Registros")
			    	RETURN -9
				ENDIF 
			ENDIF 
					
							
		ENDIF 
	
		

		v_idartimp = 0
		v_idartpro = 0
		*v_idlistah = v_maximoListah 
		v_fechaAct = ALLTRIM(DTOS(DATE()))

		DIMENSION lamatriz(17,2)
		DIMENSION lamatriz2(3,2)
		DIMENSION lamatriz3(6,2)
		DIMENSION lamatriz4(4,2)
		
		
		
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		SELECT articuloscar 
		GO TOP 
		DO WHILE !EOF()
		
		*** Cargo el articulo en tabla articulos ***
			lamatriz(1,1) = 'articulo'
			lamatriz(1,2) = "'"+ALLTRIM(articuloscar.articulo)+"'"
			lamatriz(2,1) = 'detalle'
			lamatriz(2,2) = "'"+ALLTRIM(articuloscar.detalle)+"'"
			lamatriz(3,1) = 'unidad'
			lamatriz(3,2) = "'"+ALLTRIM(articuloscar.unidad)+"'"
			lamatriz(4,1) = 'abrevia'
			lamatriz(4,2) = "'"+ALLTRIM(articuloscar.abrevia)+"'"
			lamatriz(5,1) = 'codbarra'
			lamatriz(5,2) = "'"+ALLTRIM(articuloscar.codbarra)+"'"
			lamatriz(6,1) = 'costo'
			lamatriz(6,2) = ALLTRIM(STR(articuloscar.costo,13,4))
			lamatriz(7,1) = 'linea'
			lamatriz(7,2) = "'"+ALLTRIM(articuloscar.linea)+"'"
			lamatriz(8,1) = 'ctrlstock'
			lamatriz(8,2) = "'"+ALLTRIM(articuloscar.ctrlstock)+"'"
			lamatriz(9,1) = 'observa'
			lamatriz(9,2) = "'"+ALLTRIM(articuloscar.observa)+"'"
			lamatriz(10,1) = 'ocultar'
			lamatriz(10,2) = "'"+ALLTRIM(articuloscar.ocultar)+"'"
			lamatriz(11,1) = 'stockmin'
			lamatriz(11,2) = ALLTRIM(STR(articuloscar.stockmin))
			lamatriz(12,1) = 'desc1'
			lamatriz(12,2) = ALLTRIM(STR(articuloscar.desc1,13,4))
			lamatriz(13,1) = 'desc2'
			lamatriz(13,2) = ALLTRIM(STR(articuloscar.desc2,13,4))
			lamatriz(14,1) = 'desc3'
			lamatriz(14,2) = ALLTRIM(STR(articuloscar.desc3,13,4))
			lamatriz(15,1) = 'desc4'
			lamatriz(15,2) = ALLTRIM(STR(articuloscar.desc4,13,4))
			lamatriz(16,1) = 'desc5'
			lamatriz(16,2) = ALLTRIM(STR(articuloscar.desc5,13,4))
			lamatriz(17,1) = 'moneda'
			lamatriz(17,2) = ALLTRIM(STR(articuloscar.moneda))
					

			p_tabla     = 'articulos'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos ",0+48+0,"Error")
			ELSE
				 *** Guardo el historial del costo del articulo ***
				   guardaHistCostoArt(articuloscar.articulo, articuloscar.cost)
				 
			*** Cargo el el impuesto del articulo en tabla articulosimp ***
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				
				v_idartimp = v_idartimp + 1
				lamatriz2(1,1)='idartimp'
				lamatriz2(1,2)= ALLTRIM(STR(v_idartimp))
				lamatriz2(2,1)='articulo'
				lamatriz2(2,2)="'"+ALLTRIM(articuloscar.articulo)+"'"
				lamatriz2(3,1)='impuesto'
				lamatriz2(3,2)=ALLTRIM(STR(articuloscar.impuesto))
	
	
				p_tabla     = 'articulosimp'
				p_matriz    = 'lamatriz2'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos-Impuestos ",0+48+0,"Error")
				
				ENDIF 
				
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
					lamatriz3(3,2)="'"+ALLTRIM(articuloscar.articulo)+"'"
					lamatriz3(4,1)='margen'
					lamatriz3(4,2)=ALLTRIM(STR(articuloscar.margen,13,4))
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
					p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				
				v_idartpro = v_idartpro + 1
				lamatriz4(1,1)='idartpro'
				lamatriz4(1,2)= ALLTRIM(STR(v_idartpro))
				lamatriz4(2,1)='articulo'
				lamatriz4(2,2)="'"+ALLTRIM(articuloscar.articulo)+"'"
				lamatriz4(3,1)='entidad'
				lamatriz4(3,2)=ALLTRIM(STR(articuloscar.proveedor))
				lamatriz4(4,1)='codigop'
				lamatriz4(4,2)="'"+ALLTRIM(articuloscar.codigop)+"'"	
	
				p_tabla     = 'articulospro'
				p_matriz    = 'lamatriz4'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de Importaciones de Articulos-Proveedor ",0+48+0,"Error")
				
				ENDIF 
				
	
			ENDIF 
			
			SELECT articuloscar
			SKIP 					
		ENDDO 
*/*/*/*/*/*/
	=abreycierracon(vconeccionF,"")	
	SELECT articuloscar
	USE IN articuloscar
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


*******************************************************