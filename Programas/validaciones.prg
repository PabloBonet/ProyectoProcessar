*****************************************************************************************
********** PROGRAMA PARA GUARDAR LAS FUNCIONES RELACIONADAS A LAS VALIDACIONES **********
*****************************************************************************************

FUNCTION valfechactrlcompro
PARAMETERS pa_fecha, pa_conexion
*#/----------------------------------------
* Valida si la fecha pasada como par�metro es mayor o igual a la fecha indicada en la variable _SYSFECHACTRLCOMPRO
* PARAMETROS: 
*			pa_fecha [C]: fecha a validar
*			pa_conexion [I]: conexi�n a la base de datos a utilizar, si no se pasa conexi�n crea una nueva
* RETORNO: 
*			Retorna True si la validaci�n es correcta, False en otro caso
*#/----------------------------------------


	** Creo la conexi�n **
	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion> 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionAn = pa_conexion
		ELSE 
			vconeccionAn = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionAn = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 

	** Valido las fechas **
	IF TYPE("pa_fecha") <> 'C' &&La fecha pasada no es caracter -> Retorno Falso
		RETURN .F.
	ENDIF 
	
	IF TYPE('_SYSFECHACTRLCOMPRO') = 'U' && No existe la variable -> la validaci�n no se hace
		RETURN .T.
	ELSE
		IF EMPTY(ALLTRIM(_SYSFECHACTRLCOMPRO))  && La variable est� vacia -> la validaci�n no se hace
			RETURN .T.
		ELSE
			v_fechactrlD = cftofc(ALLTRIM(_SYSFECHACTRLCOMPRO))
			v_fechavalD = cftofc(pa_fecha)
			
			IF v_fechavalD >= v_fechactrlD 
				RETURN  .T.
			ELSE
				MESSAGEBOX("La fecha no es V�lida, debe ser menor a '_SYSFECHACTRLCOMPRO'",0+16+0,"Validaci�n de fecha")
				RETURN .F.
			ENDIF 	
		ENDIF 
	ENDIF 

ENDFUNC 