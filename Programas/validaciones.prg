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