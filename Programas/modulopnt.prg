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
		sqlmatriz(2)= " from pntopera where fechaini >= '"+ALLTRIM(asyspuntos(4))+"' and automat = 'S' order by tabla desc "
		verror=sqlrun(vconeccionPN ,"tablaspnt_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la registracion de puntos ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT tablaspnt_sql 
		GO TOP 
		IF !EOF()  THEN  && hay que puntuar 
			SELECT tabla, MIN(fechaini) as fechaini FROM tablaspnt_sql INTO TABLE tablaspnt GROUP BY tabla ORDER BY tabla desc
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
					sqlmatriz(2)= " from "+pnt_tabla+" t "
					sqlmatriz(3)= " left join pntentidades p on p.entidad = t.entidad "
					sqlmatriz(4)= " where t.fecha >= '"+ALLTRIM(pnt_fechaini)+"' "
					sqlmatriz(5)= " and ifnull(p.entidad,0) > 0 and t."+pnt_nomindice+" not in ( select id from pntpuntos where tabla = '"+pnt_tabla+"' )"
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
	SELECT idpntopera, tabla, campoid, idreg, cmpfactor, funcionpnt , 1000000.00 as factor, puntos, 1000000.00 as fpntpuntos, 1000000000 as entidad, '        ' as fecha ;
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
				
				Fun = STRTRAN((STRTRAN((STRTRAN(Fun,'(','('+"'"+alltrim(tabla)+"','"+alltrim(campoid)+"',"+ALLTRIM(STR(idreg))+","+ALLTRIM(STR(entidad))+","+ALLTRIM(STR(pf_vconeccion))+",")),',,',','))  ,',)',')') 
				v_valorfn = &Fun
			ENDIF
	
			SELECT &ret_puntos
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
PARAMETERS pft_tabla, pft_campoid, pft_id, pft_entidad, pft_coneccion, pft_Multiplo
	RETURN pft_Multiplo
ENDFUNC 



FUNCTION FPNTEntidadGR
*#//////////////////////////////////////
*/ Verifica si una entidad pertenece a un grupo dado 
*/ Devuelve verdadero o falso segun pertenezca o no
*#//////////////////////////////////////
PARAMETERS pft_tabla, pft_campoid, pft_id, pft_entidad, pft_coneccion, pft_Grupo

	v_pertenece=GrupoCuentaContable(ALLTRIM(STR(pft_entidad)),"entidades","entidad","int(10)",ALLTRIM(STR(pft_Grupo)),pft_coneccion)

	IF v_pertenece = .t. THEN 
		pft_Multiplo = 1
	ELSE
		pft_Multiplo = 0
	ENDIF 
	RETURN pft_Multiplo
ENDFUNC 


FUNCTION FPNTRecibosGR
*#//////////////////////////////////////
*/ Calcula la Puntuación de un Recibo de acuerdo a 
*/ Condiciones del recibos y datos de cuotas a abonar
*/ Retorna los puntos a aplicar para el recibo ingresado como parámetro
*#//////////////////////////////////////
PARAMETERS pft_tabla, pft_campoid, pft_id, pft_entidad, pft_coneccion, pft_Grupo, pft_porc1, pft_porc2, pft_porc3

	v_pertenece=GrupoCuentaContable(ALLTRIM(STR(pft_entidad)),"entidades","entidad","int(10)",ALLTRIM(STR(pft_Grupo)),pft_coneccion)

	IF v_pertenece = .t. THEN 
		v_factor_entidad = 1
	ELSE
		v_factor_entidad = 0
		RETURN 0 
	ENDIF 

	pft_porc1 = STRTRAN(pft_porc1,'%','')
	pft_porc2 = STRTRAN(pft_porc2,'%','')
	pft_porc3 = STRTRAN(pft_porc3,'%','')
	
	*Separacion de Bloques de porcentajes
	*cuotas y porcentajes primer fraccion
	vp1_cuotad = INT(VAL(SUBSTR(pft_porc1,1,AT('-',pft_porc1,1)-1)))
	vp1_cuotah = int(val(SUBSTR(pft_porc1,AT('-',pft_porc1,1)+1,AT('-',pft_porc1,2)-(AT('-',pft_porc1,1)+1))))
	vp1_porc = val(SUBSTR(pft_porc1,AT('-',pft_porc1,2)+1))

	*cuotas y porcentajes segunda fraccion
	vp2_cuotad = INT(VAL(SUBSTR(pft_porc2,1,AT('-',pft_porc2,1)-1)))
	vp2_cuotah = int(val(SUBSTR(pft_porc2,AT('-',pft_porc2,1)+1,AT('-',pft_porc2,2)-(AT('-',pft_porc2,1)+1))))
	vp2_porc = val(SUBSTR(pft_porc2,AT('-',pft_porc2,2)+1))

	*cuotas y porcentajes segunda Factura Completa
	vp3_cuotad = INT(VAL(SUBSTR(pft_porc3,1,AT('-',pft_porc3,1)-1)))
	vp3_porc = val(SUBSTR(pft_porc3,AT('-',pft_porc3,1)+1))


	* busqueda del recibo 
	sqlmatriz(1)=" Select * from "+pft_tabla+" where "+pft_campoid+" = "+STR(pft_id)
	verror=sqlrun(pft_coneccion,"regreci_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Recibo",0+48+0,"Error")
	ENDIF
	SELECT regreci_sql
	
	v_idcomprobar 		= regreci_sql.idcomproba 
	v_importerecibo 	= regreci_sql.importe
	v_fechaRecibo		= regreci_sql.fecha
	v_ImporteCuotaVP1 	= 0.00
	v_ImporteCuotaVP2   = 0.00
	v_NetoFacturas  	= 0.00
	
	sqlmatriz(1) = " SELECT c.*, ifnull(f.cuota,0) as cuota, "
	sqlmatriz(2) = " ifnull(f.cancuotas,0) as cancuotas, ifnull(f.importe,0.00) as importe , ifnull(f.fechavenc,'        ') as fechavenc, "
	sqlmatriz(3) = " ifnull(s.cobrado,0.00) as cobrado, ifnull(s.saldof,0.00) as saldof, fc.neto  "
	sqlmatriz(4) = " FROM cobros c left join facturascta f on f.idcuotafc = c.idcuotafc "
	sqlmatriz(5) = " left join facturasctasaldo s on s.idcuotafc = c.idcuotafc "
	sqlmatriz(6) = " left join facturas fc on fc.idfactura = f.idfactura "
	sqlmatriz(7) = " where c.idcomproba = "+ALLTRIM(STR(v_idcomprobar))+" and c.idregipago = "+STR(pft_id)
	verror=sqlrun(pft_coneccion,"regcobros_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Recibo",0+48+0,"Error")
	ENDIF

	SELECT regcobros_sql
	GO TOP 
	

	DO WHILE !EOF() 
		
		IF regcobros_sql.idcuotafc > 0 THEN 
			v_importerecibo = v_importerecibo - regcobros_sql.imputado
			IF ALLTRIM(regcobros_sql.fechavenc) >= ALLTRIM(v_fechaRecibo) THEN
				** Secciona el pago por Numeros de Cuotas 
				v_cuotafc = regcobros_sql.cuota
				IF TYPE("v_cuotafc")="C" THEN 
					v_cuotafc = VAL(v_cuotafc)
				ENDIF 
				v_cancuotafc = regcobros_sql.cancuotas
				IF TYPE("v_cancuotafc")="C" THEN 
					v_cancuotafc = VAL(v_cancuotafc)
				ENDIF 
				IF v_cuotafc  >= vp1_cuotad AND v_cuotafc  <= vp1_cuotah   THEN 
					v_ImporteCuotaVP1 = v_ImporteCuotaVP1 + regcobros_sql.imputado
				ENDIF 
				IF v_cuotafc  >= vp2_cuotad AND v_cuotafc  <= vp2_cuotah THEN 
					v_ImporteCuotaVP2 = v_ImporteCuotaVP2 + regcobros_sql.imputado
				ENDIF 
				
				** Para aquellos comprobantes mayores a 10 Cuotas pagados totalmente y en termino 
				IF v_cuotafc  >= vp3_cuotad  AND  v_cuotafc  = v_cancuotafc  THEN && verifico que se hayan pagado todas las cuotas a termino 

					sqlmatriz(1)=	" SELECT SUM(1) as cantpago "
					sqlmatriz(2)=	" FROM cobros c left join facturascta f on f.idcuotafc = c.idcuotafc"
					sqlmatriz(3)=	" left join recibos r on r.idcomproba = c.idcomproba and r.idrecibo = c.idregipago"
					sqlmatriz(4)=	" where f.idfactura = "+ALLTRIM(STR(regcobros_sql.idfactura))+" and  f.fechavenc >= r.fecha" 
					verror=sqlrun(pft_coneccion,"cuotaspagas_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA Cuotas Pagadas",0+48+0,"Error")
					ENDIF
					SELECT cuotaspagas_sql
					GO TOP 
 
					IF !EOF() THEN 
						IF cuotaspagas_sql.cantpago = regcobros_sql.cancuotas THEN 
							v_NetoFacturas  = regcobros_sql.neto				
						ENDIF 
					ENDIF 		
					USE IN cuotaspagas_sql 	
				ENDIF 
				
			ENDIF 
		ENDIF 
		SELECT regcobros_sql
		SKIP 
	ENDDO 
	
	USE IN regcobros_sql
	

	v_importerecibo   	= v_importerecibo       * (vp1_porc / 100)
	v_ImporteCuotaVP1 	= v_importecuotaVP1 	* (vp1_porc / 100)
	v_ImporteCuotaVP2   = v_importecuotaVP2 	* (vp2_porc / 100)
	v_NetoFacturas  	= v_NetoFacturas  		* (vp3_porc / 100)

	v_total_puntos = ROUND(v_factor_entidad * (v_importerecibo + v_ImporteCuotaVP1 + v_ImporteCuotaVP2 + v_NetoFacturas ),0)
	
	RETURN v_total_puntos
ENDFUNC 



FUNCTION FPNTAnulaRe
*#//////////////////////////////////////
*/ Calcula la Puntuación de una Anulación de Recibos de Acuerdo 
*/ a los puntos sumados por el recibo anulado
*/ Retorna los puntos a descontar por la anulación
*#//////////////////////////////////////
PARAMETERS pft_tabla, pft_campoid, pft_id, pft_entidad, pft_coneccion

	* busqueda del recibo 
	sqlmatriz(1)=" Select * from "+pft_tabla+" where "+pft_campoid+" = "+STR(pft_id)
	verror=sqlrun(pft_coneccion,"reganula_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la Anulación de Recibo",0+48+0,"Error")
	ENDIF
	SELECT reganula_sql
	
	v_idreciboanu 	= reganula_sql.idrecibo
	USE IN reganula_sql 
	
	IF v_idreciboanu <= 0 THEN 
		RETURN 0
	ENDIF 

	v_total_puntos	 = 0
	
	sqlmatriz(1) = " SELECT SUM(puntos) as puntos from pntpuntos where tabla = 'recibos' and campo='idrecibo' and id = "+ALLTRIM(STR(v_idreciboanu))
	verror=sqlrun(pft_coneccion,"regipuntos_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Puntos del Recibo",0+48+0,"Error")
	ENDIF
	SELECT regipuntos_sql
	GO TOP 
	IF !EOF() THEN 
		v_total_puntos = (-1)*IIF(ISNULL(regipuntos_sql.puntos),0,regipuntos_sql.puntos)
	ENDIF 
	USE IN regipuntos_sql 

	RETURN v_total_puntos
ENDFUNC 






































