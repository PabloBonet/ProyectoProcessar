FUNCTION PuntosAutoTablas
*#/----------------------------------------
** Funcion de Llamada a Puntuar Registros  de todas las tablas que no estén puntuadas
* 		Automatiza la puntuacion
* Parametros: sin  parametros
*#/----------------------------------------
	IF TYPE('_SYSPUNTOS') <> 'C' THEN 
		RETURN .f.
	ELSE 
		IF SUBSTR(_SYSPUNTOS,1,1) = '0'   THEN 
			RETURN .f.
		ENDIF 
	ENDIF 
	v_canlineas = ALINES(asyspuntos,_SYSPUNTOS,1,';')

	IF ( ALLTRIM(_syshost)==ALLTRIM(asyspuntos(3)) OR ALLTRIM(_sysip)==ALLTRIM(asyspuntos(3) ) ) then
		** es la pc que va a hacer el calculo de sistema
		vconeccionPN=abreycierracon(0,_SYSSCHEMA)

		sqlmatriz(1)= " select tabla, fechaini "
		sqlmatriz(2)= " from pntopera where fechaini >= '"+ALLTRIM(asyspuntos(4))+"' and automat = 'S' "
		verror=sqlrun(vconeccionPN ,"tablaspnt_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la registracion de puntos ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT tablaspnt_sql 
		GO TOP 
		IF !EOF()  THEN  && hay que puntuar 
			SELECT tabla, MIN(fechaini) as fechaini FROM tablaspnt_sql INTO TABLE tablaspnt GROUP BY tabla 
			USE IN tablaspnt_sql
			SELECT tablaspnt
			GO TOP 
			 * Aqui comienzo a calcular para las distintas tablas de las reglas habilitadas
			DO WHILE !EOF()
				pnt_nomindice = ""
				IF !EMPTY(tablaspnt.tabla) THEN
					pnt_tabla		= ALLTRIM(tablaspnt.tabla)
					pnt_fechaini	= ALLTRIM(tablaspnt.fechaini)
					pnt_nomindice 	= obtenerCampoIndice(ALLTRIM(pnt_tabla))

					sqlmatriz(1)= " select "+pnt_nomindice+" as indice "
					sqlmatriz(2)= " from "+pnt_tabla+" where fecha >= '"+ALLTRIM(pnt_fechaini)+"' "
					sqlmatriz(3)= " and "+pnt_nomindice+" not in ( select id from pntpuntos where tabla = '"+pnt_tabla+"' )"
					verror=sqlrun(vconeccionPN ,"registros_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la busqueda registros de puntos ",0+48+0,"Error")
					    RETURN ""  
					ENDIF	
					SELECT registros_sql
					GO TOP 
					DO WHILE !EOF()
						vidcomid 	= registros_sql.indice
						IF vidcomid > 0 THEN 
							AA= PuntosMov (pnt_tabla, vidcomid ,'A', vconeccionPN )
						ENDIF 
						
						SELECT registros_sql
						SKIP 
					ENDDO 
					USE IN registros_sql 
				ENDIF 
			
				SELECT tablaspnt
				SKIP 
			ENDDO 
			
			USE IN tablaspnt			 
		ELSE  
			USE IN tablaspnt_sql
		ENDIF 
		
		=abreycierracon(vconeccionPN,"")
		*************************************************
	ELSE 
	
	ENDIF  
	RELEASE asyspuntos

ENDFUNC 



FUNCTION PuntosMov
PARAMETERS punt_tabla, punt_id, punt_au, pcont_conex
*#/----------------------------------------
*/ Busca los Puntos de acuerdo al registro de Operaciones
* Recibe como parametros la tabla, el Idregistro y la conexion, 
* Verifica que el registro de la tabla pasada ya no esté asociado a una puntuación , si es asi no realiza la puntuación, 
* de otra manera los puntos y graba en la tabla pntpuntos.
*  RETORNA : IDPUNTOS INDICE EN EL REGISTRO DE LA PUNTUACIÓN "IDPUNTOS", 
* 		   : 0 SI NO PUNTUÓ 
*		   : -1 SI NO LO GENERÓ Y EL OPERADOR DEBIERA INGRESARLO, esto se controla con una variable publica : _SYSPUNTOS de seteo 
**         : -2 NO Generó el Asiento porque no está habilitado el Módulo Contable
*#/----------------------------------------
	
	ret_idpuntos = 0
	
	IF TYPE('_SYSPUNTOS') <> 'C' THEN 
		ret_idpuntos = 0
		RETURN ret_idpuntos 
	ELSE 
		IF SUBSTR(_SYSPUNTOS,1,1) = '0'   THEN 
			ret_idpuntos = 0
			RETURN ret_idpuntos
		ENDIF 
	ENDIF 
	IF pcont_conex = 0 THEN 
		vcone_conta=abreycierracon(0,_SYSSCHEMA)
	ELSE
		vcone_conta = pcont_conex
	ENDIF 


	* Verifico si el registro pasado ya no está puntuado , si es que tiene que puntuarlo *

		sqlmatriz(1)= " select idpuntos, entidad, tabla, id, fecha  "
		sqlmatriz(2)= " from pntpuntos where tabla = '"+ALLTRIM(punt_tabla)+"' and id="+alltrim(STR(punt_id))
		verror=sqlrun(vcone_conta ,"punt_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la registracion de puntos ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT punt_sql
		GO TOP 

		IF !EOF()  THEN 
			 ret_idpuntos = punt_sql.idpuntos
		ELSE  
		    *********************************************************
			para_tabla 			= ALLTRIM(punt_tabla)
			para_registro 		= punt_id
			para_filtropuntos	= FiltroPuntos (para_tabla, para_registro, punt_au, vcone_conta)

			IF !EMPTY(para_filtropuntos) THEN 
				v_canreglas=GenPuntos(para_filtropuntos,vcone_conta)
			ENDIF 
		ENDIF 
		
	IF pcont_conex = 0 THEN 
		=abreycierracon(vcone_conta,"")
	ENDIF 

	RETURN ret_idpuntos
ENDFUNC 



FUNCTION GenPuntos
*#///////////////////////////////////////////////////////////////
**********************************************************************
** Funcion que inserta los puntos en la tabla pntpuntos a partir de 
** una tabla recibida como parametro con los registros de puntos que debe insertar
** estructura de la tabla recibida .dbf  
**		idpntopera i, tabla c(50), campoid c(50), idreg i, cmpfactor n(10,2), puntos n(10,2), entidad i, fecha c(8) 
**	    idpntopera i, tabla c(50), campoid c(50), idreg i, cmpfactor c(50), funcionpnt c(50),factor n(10,2), puntos n(10,2) ,fpntpuntos n(10,2), entidad i, fecha c(8) 
*#///////////////////////////////////////////////////////////////


PARAMETERS ppun_tabla, pp_vconeccion


	pp_cierraconex = .f.
	IF pp_vconeccion = 0 THEN 
		pp_vconeccion=abreycierracon(0,_SYSSCHEMA)	
		pp_cierraconex = .t.
	ENDIF 
	var_retorno = 0
	
	*** abro la tabla recibida como parámetros
	IF !USED(ppun_tabla) THEN 
		USE &ppun_tabla IN 0
	ENDIF 
	SELECT &ppun_tabla
	GO TOP 
	DIMENSION lamatriz1(9,2)

	DO WHILE !EOF()

		IF (&ppun_tabla..factor*&ppun_tabla..puntos) <> 0 THEN 
				
			lamatriz1(1,1)='idpuntos'
			lamatriz1(1,2)= '0'
			lamatriz1(2,1)='idpntopera'
			lamatriz1(2,2)= ALLTRIM(STR(&ppun_tabla..idpntopera))
			lamatriz1(3,1)='entidad'
			lamatriz1(3,2)= ALLTRIM(STR(&ppun_tabla..entidad))
			lamatriz1(4,1)='puntos'
			lamatriz1(4,2)= ALLTRIM(STR((&ppun_tabla..factor*&ppun_tabla..puntos*&ppun_tabla..fpntpuntos),10,2))
			lamatriz1(5,1)='tabla'
			lamatriz1(5,2)= "'"+ALLTRIM(&ppun_tabla..tabla)+"'"
			lamatriz1(6,1)='campo'
			lamatriz1(6,2)= "'"+ALLTRIM(&ppun_tabla..campoid)+"'"
			lamatriz1(7,1)='id'
			lamatriz1(7,2)= ALLTRIM(STR(&ppun_tabla..idreg))
			lamatriz1(8,1)='fecha'
			lamatriz1(8,2)= "'"+ALLTRIM(&ppun_tabla..fecha)+"'"
			lamatriz1(9,1)='detalle'
			lamatriz1(9,2)= "'Registro Automatico - Tabla: "+ALLTRIM(&ppun_tabla..tabla)+" - Campo: "+ALLTRIM(&ppun_tabla..campoid)+" - Id: "+ALLTRIM(STR(&ppun_tabla..idreg))+"'"

						
			i_tipoope     = 'I'
			i_condicion   = ''
			i_titulo      = " EL ALTA "
			i_tabla     = 'pntpuntos'
			i_matriz    = 'lamatriz1'
			i_conexion  = pp_vconeccion
			IF SentenciaSQL(i_tabla,i_matriz,i_tipoope,i_condicion,i_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			    RETURN ""
			ENDIF	
			var_retorno = var_retorno + 1
			
		ENDIF 	
	
		SELECT &ppun_tabla
		SKIP 
	ENDDO 
	
	USE IN &ppun_tabla
	RELEASE lamatriz1	

	RETURN var_retorno
ENDFUNC 



FUNCTION FiltroPuntos 
*#//////////////////////////////////////
*/ Determina el Filtro de puntos para aplicar al comprobante seleccionado
*/ del filtrado que aplica al comprobante recibido como parametros
* PARAMETROS
* pf_tabla     : tabla que tiene el registro para puntuar
* pf_idregi    : id del registro que se va a evaluar dentro de la tabla
* pf_coneccion : conexion para la consulta, si es 0 abre una nueva conexion 
*
* RETORNO	   : retorna vacio o una tabla con los filtros aplicados al comprobante y los puntos a cargar 
*		
*#//////////////////////////////////////
PARAMETERS pf_tabla, pf_idregi, pf_au, pf_vconeccion
	
	pf_campoid = getIdTabla(pf_tabla) && Obtengo el nombre del campo indice de la tabla
	
	pf_cierraconex = .f.
	IF pf_vconeccion = 0 THEN 
		pf_vconeccion=abreycierracon(0,_SYSSCHEMA)	
		pf_cierraconex = .t.
	ENDIF 

	ret_puntos = ''

	var_pf_idregi = IIF((UPPER(type("pf_idregi"))='I' or UPPER(type("pf_idregi"))='N'),ALLTRIM(STR(pf_idregi)),"'"+ALLTRIM(pf_idregi)+"'")	
	
	sqlmatriz(1)=" Select t.*, ifnull(e.entidad,0) as pntentidad ,ifnull(e.fechaini,'        ') as fechaini, ifnull(e.fechafin,'        ') as fechafin from "
	sqlmatriz(2)= ALLTRIM(pf_tabla)+" t left join pntentidades e on e.entidad = t.entidad " 
	sqlmatriz(3)=" where t."+pf_campoid+" = "+var_pf_idregi+" and ifnull(e.entidad,0) > 0 "
	sqlmatriz(4)=" and length(trim(ifnull(e.fechaini,''))) > 0 and t.fecha >= trim(ifnull(e.fechaini,'')) and ( t.fecha <= trim(ifnull(e.fechafin,'')) or trim(ifnull(e.fechafin,'')) = '') "
	verror=sqlrun(pf_vconeccion,"registrof_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Registro en la Tabla: "+var_pf_idregi+";"+pf_tabla+";"+pf_campoid,0+48+0,"Error")
	    RETURN 	ret_puntos 
	ENDIF
	
	SELECT registrof_sql

	
	IF EOF() THEN 
		USE IN registrof_sql 
		IF pf_cierraconex THEN 
			**** El Modelo de Asiento Seleccionado ***
			=abreycierracon(pf_vconeccion,"")	
		ENDIF 
		RETURN ret_puntos 
	ELSE	


		*///////////////////
		*/Aca calculo la coincidencia con los filtros definidos para la tabla pasada*//
		*/ y el registro encontrado */**************
		*///////////////////
		
		v_fecharegi = ALLTRIM(registrof_sql.fecha)
		v_fautomat = IIF((ALLTRIM(pf_au)=='A')," and f.automat = 'S' "," ")
			
		sqlmatriz(1)=" Select d.*, f.detalle, f.puntos, f.tabla,  f.cmpfactor, f.tipo, f.fechaini, f.fechafin, f.funcionpnt  " 
		sqlmatriz(2)="   from pntfiltro d left join pntopera f on f.idpntopera = d.idpntopera "	
		sqlmatriz(3)="   where f.tabla = '"+ALLTRIM(pf_tabla)+"' "+v_fautomat 
		sqlmatriz(4)="   and length(trim(ifnull(f.fechaini,''))) > 0 and '"+v_fecharegi+"' >= trim(ifnull(f.fechaini,'')) and ( '"+v_fecharegi+"' <= trim(ifnull(f.fechafin,'')) or trim(ifnull(f.fechafin,'')) = '')  order by f.idpntopera " 
		verror=sqlrun(pf_vconeccion,"filtros_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Registro en la Tabla: "+var_pf_idregi+";"+pf_tabla+";"+pf_campoid,0+48+0,"Error")
		    RETURN ret_puntos 
		ENDIF
		SELECT *, 0 as cumple FROM filtros_sql INTO TABLE filtros
		SELECT filtros_sql
		USE IN filtros_sql
		SELECT registrof_sql
		SELECT filtros 		
		GO TOP 
		
		DO WHILE !EOF()
		
			v_cumple = 0
			IF ALLTRIM(filtros.tabla) = ALLTRIM(pf_tabla) THEN 
			
					eje = " var_valor = registrof_sql."+ALLTRIM(filtros.campof)
					&eje
					eje = " var_valor1= "+IIF((UPPER(SUBSTR(filtros.tipof,1,1))='I' or UPPER(SUBSTR(filtros.tipof,1,1))='D' or UPPER(SUBSTR(filtros.tipof,1,1))='F'),'VAL(ALLTRIM(filtros.valor1))','ALLTRIM(filtros.valor1)')
					&eje 
					eje = " var_valor2= "+IIF((UPPER(SUBSTR(filtros.tipof,1,1))='I' or UPPER(SUBSTR(filtros.tipof,1,1))='D' or UPPER(SUBSTR(filtros.tipof,1,1))='F'),'VAL(ALLTRIM(filtros.valor2))','ALLTRIM(filtros.valor2)')
					&eje 

				DO CASE 
					CASE UPPER(filtros.compara)="TODOS"
						v_cumple = 1
					CASE UPPER(filtros.compara)="ENTRE"
						IF  var_valor >= var_valor1 AND var_valor <= var_valor2 THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="IGUAL"
						IF var_valor = var_valor1 THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MAYOR"
						IF var_valor > var_valor1 THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MAYOR O IGUAL"
						IF var_valor >= var_valor1 THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MENOR"
						IF var_valor < var_valor1 THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MENOR O IGUAL"
						IF var_valor <= var_valor1 THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="DISTINTO"
						IF var_valor <> var_valor1 THEN 
							v_cumple = 1 
						ENDIF 
*!*						CASE UPPER(AstoCuentaA_sql.compara)="GRUPO"
*!*							IF GrupoCuentaContable (var_valor,AstoCuentaA_sql.tablag,AstoCuentaA_sql.campog,AstoCuentaA_sql.tipog,AstoCuentaA_sql.valor1, vconeccionATO) THEN 
*!*								v_incerta = .t.
*!*							ENDIF 

				ENDCASE 
				
				SELECT filtros
				replace cumple WITH v_cumple
			
			ENDIF 
		
			SELECT filtros
			SKIP 

		ENDDO 
	ENDIF 
	

	SET ENGINEBEHAVIOR 70
	SELECT idpntopera, tabla, puntos, cmpfactor, funcionpnt, SUM(1) as cantidadf, SUM(cumple) as cumplidos, pf_idregi as idreg, pf_campoid as campoid ;
			FROM  filtros INTO TABLE filtrosele ORDER BY idpntopera GROUP BY idpntopera
	SET ENGINEBEHAVIOR 90
	GO TOP 
	
	ret_puntos = 'ret_puntos'+frandom()
	SELECT idpntopera, tabla, campoid, idreg, cmpfactor, funcionpnt , 1000000.00 as factor, puntos, 1000000.00 as fpntpuntos, 1000000 as entidad, '        ' as fecha ;
		FROM filtrosele INTO TABLE &ret_puntos  WHERE cantidadf = cumplidos AND cumplidos > 0 
		
	SELECT &ret_puntos
	GO TOP 
	IF EOF() THEN 
		SELECT &ret_puntos
		USE IN &ret_puntos
		ret_puntos = ''
	ELSE 
		SELECT &ret_puntos
		GO TOP 
		DO WHILE !EOF()
			IF !EMPTY(cmpfactor) THEN 
				eje = "replace factor with registrof_sql."+ALLTRIM(cmpfactor)+" , entidad with registrof_sql.entidad, fecha with registrof_sql.fecha "
				&eje
			ELSE
				replace factor with 1 , entidad WITH registrof_sql.entidad, fecha WITH registrof_sql.fecha
			ENDIF 

			**ejecuta la funcion para calculo de punto variable por funcion**
			v_valorfn = 1
			IF !EMPTY(funcionpnt) THEN 
				Fun = ALLTRIM(funcionpnt)
				
				Fun = STRTRAN((STRTRAN((STRTRAN(Fun,'(','('+"'"+alltrim(tabla)+"','"+alltrim(campoid)+"',"+ALLTRIM(STR(idreg))+",")),',,',','))  ,',)',')') 
				v_valorfn = &Fun
			ENDIF
			replace fpntpuntos WITH v_valorfn 
			
			SKIP 
		ENDDO 

		USE IN &ret_puntos	
	ENDIF 
	
	SELECT registrof_sql
	USE IN registrof_sql
	SELECT filtros
	USE IN filtros
	SELECT filtrosele
	USE IN filtrosele

	IF pf_cierraconex THEN 
		=abreycierracon(pf_vconeccion,"")	
	ENDIF 
	
RETURN ret_puntos 
ENDFUNC 




************************************************
** FUNCIONES DE CALCULO ASOCIADAS A OPERACIONES
************************************************

FUNCTION FPNTMultiplo
PARAMETERS pft_tabla, pft_campoid, pft_id, pft_Multiplo
	RETURN pft_Multiplo
ENDFUNC 