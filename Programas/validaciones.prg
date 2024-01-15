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


*!*		** Creo la conexi�n **
*!*		IF TYPE("pa_conexion") = 'N' THEN 
*!*			IF pa_conexion> 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
*!*				vconeccionAn = pa_conexion
*!*			ELSE 
*!*				vconeccionAn = abreycierracon(0,_SYSSCHEMA)
*!*			ENDIF 	
*!*		ELSE 
*!*			vconeccionAn = abreycierracon(0,_SYSSCHEMA)	
*!*			pa_conexion = 0
*!*		ENDIF 

	** Valido las fechas **
	IF TYPE("pa_fecha") <> 'C' &&La fecha pasada no es caracter -> Retorno Falso
		RETURN .F.
	ENDIF 
	
	IF TYPE('_SYSFECTRLCOMP') = 'U' && No existe la variable -> la validaci�n no se hace
		RETURN .T.
	ELSE
		IF EMPTY(ALLTRIM(_SYSFECTRLCOMP))  && La variable est� vacia -> la validaci�n no se hace
			RETURN .T.
		ELSE
		
			v_fechactrlD = cftofc(ALLTRIM(SUBSTR(_SYSFECTRLCOMP,1,8)))
			v_fechactrlH = cftofc(ALLTRIM(SUBSTR(_SYSFECTRLCOMP,10)))

			v_fechavalD  = cftofc(pa_fecha)
			
			IF v_fechavalD >= v_fechactrlD AND (EMPTY(v_fechactrlH) OR ( !EMPTY(v_fechactrlH) AND v_fechavalD <= v_fechactrlH )) THEN 
				RETURN  .T.
			ELSE
				MESSAGEBOX("La fecha no es V�lida, debe estar en el per�odo: "+DTOS(v_fechactrlD)+" - "+DTOS(v_fechactrlH),0+16+0,"Validaci�n de fecha")
				RETURN .F.
			ENDIF 	
		ENDIF 
	ENDIF 

ENDFUNC 