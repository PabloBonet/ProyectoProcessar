

FUNCTION RET_GANANCIAS_IFN
PARAMETERS P_idimpuret, P_importe, P_fecha, P_entidad,P_nombreTabRes, p_regimen
*#/****************************
*** FUNCIÓN PARA EL CALCULO DEL MONTO A RETENER DE GANANCIAS ***
****************************************************************
** PARÁMETROS: 	P_idimpuret: id impuesto de retención
*				P_importe: Importe Total, del cuál se va a calcular la retención. 
*				P_fecha: Fecha para el cálculo de la rentención
*				P_entidad: Entidad a la cual se le va a calcular la retención
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual inclura: idimpuret,netoTotal,importeARetener,totpagosmes,totRetenmes )
*				p_regimen: Regimen utilizado en la regimen
* La función recibe los parametros indicados y en función de eso y las tablas de retenciones calcula cuanto debe retenerse para la entidad y el importe dado
****************************************************************
** RETORNO: Retorna el importe a retener, el total de retenciones al mes y total de pagos. True si terminó correctamente, False en otro caso
*#/****************************

	v_divisorParaNeto = 1.21

	***** DIVIDO EL IMPORTE POR 1.21 PARA OBTENER EL NETO ****

	P_importe = P_importe /v_divisorParaNeto
	
	******


	* Creo tablas
	CREATE TABLE totpagos FREE (entidad i, pagosmes y)
	CREATE TABLE totreten FREE (entidad i, retenmes y)
		
	v_sentenciaCrea1 = "CREATE TABLE "+ALLTRIM(p_nombreTabRes)+" FREE (entidad I,idimpuret I,impTotal Y,impARet Y,baseimpo Y,razon Y, idtipopago I, descrip C(250),totpagomes Y, totretmes Y, sujarete Y, idafipesc I)"

	&v_sentenciaCrea1
	
	* Abro una conexion con la base de datos 
	varconexionF = abreycierracon(0,_SYSSCHEMA)
		
	estadosObjr		= CREATEOBJECT('estadosclass')
	
	v_estadoAnulado = estadosObjr.getidestado("ANULADO")
	
	
	mes  = MONTH(P_FECHA)
	anio = YEAR(P_FECHA)
	diaini = '01'
	diafin =''
	DO CASE 
		CASE mes = 1
			diafin ='31'
		CASE mes = 2 AND MOD(anio,4)<>0
			diafin ='28'
		CASE mes = 2 AND MOD(anio,4)=0
			diafin ='29'
		CASE mes = 3
			diafin ='31'
		CASE mes = 4
			diafin ='30'
		CASE mes = 5
			diafin ='31'
		CASE mes = 6
			diafin ='30'
		CASE mes = 7
			diafin ='31'
		CASE mes = 8
			diafin ='31'
		CASE mes = 9
			diafin ='30'
		CASE mes = 10
			diafin ='31'
		CASE mes = 11
			diafin ='30'
		CASE mes = 12
			diafin ='31'
		OTHERWISE 
			MESSAGEBOX("Mes Inválido para el Cálculo de Ganancias",0+48+0,"Error")
	ENDCASE 

	v_desde = "'"+STRTRAN(STR(anio,4,0)," ","0")+STRTRAN(STR(mes,2,0)," ","0")+diaini+"'"
	v_hasta = "'"+STRTRAN(STR(anio,4,0)," ","0")+STRTRAN(STR(mes,2,0)," ","0")+diafin+"'"
	



******************************************************************************************
**** BUSCO PAGOS SIN RETENCIONES Y RETENCIONES REALIZADAS DE PAGOS ANTERIORES EN EL MES PASADO COMO PARÁMETRO ****
******************************************************************************************

****
*** Retenciones realizadas en el mes pasado como parámetro ***
****

	
*!*	sqlmatriz(1)= " SELECT p.entidad, ifnull(r.idimpuret, 0) as idimpuret, SUM(p.importe) as pagosmes, ifnull(sum(r.importe),0.00) as impret   FROM pagosprov p left join linkcompro l on p.idcomproba = l.idcomprobaa and p.idpago = l.idregistroa "
*!*	sqlmatriz(2)= "  left join retenciones r on l.idcomprobab = r.idcomproba and l.idregistrob = r.idreten left join ultimoestado u on p.idpago = u.id and u.campo = 'idpago' and u.tabla = 'pagosprov' "
*!*	sqlmatriz(3)= " WHERE p.fecha between "+ALLTRIM(v_desde)+" and "+ALLTRIM(v_hasta)+"  and  r.entidad = "+ALLTRIM(STR(p_entidad))+" AND  R.idimpuret = "+ALLTRIM(STR(P_idimpuret)) +" and u.idestador != "+ALLTRIM(STR(v_estadoAnulado))+"   group BY p.entidad,r.idimpuret "
  
  	sqlmatriz(1)= " SELECT p.entidad, ifnull(i.idimpuret, 0) as idimpuret, SUM(p.importe) as pagosmes, ifnull(sum(r.importe),0.00) as impret, i.regimen   FROM pagosprov p left join linkcompro l on p.idcomproba = l.idcomprobaa and p.idpago = l.idregistroa "
	sqlmatriz(2)= "  left join retenciones r on l.idcomprobab = r.idcomproba and l.idregistrob = r.idreten left join impuretencionh i on r.idreten = i.idreten left join ultimoestado u on p.idpago = u.id and u.campo = 'idpago' and u.tabla = 'pagosprov' "
*	sqlmatriz(3)= " WHERE p.fecha between "+ALLTRIM(v_desde)+" and "+ALLTRIM(v_hasta)+"  and  r.entidad = "+ALLTRIM(STR(p_entidad))+" AND  i.idimpuret = "+ALLTRIM(STR(P_idimpuret)) +" and u.idestador != "+ALLTRIM(STR(v_estadoAnulado))+"   group BY p.entidad,i.idimpuret "
	sqlmatriz(3)= " WHERE p.fecha between "+ALLTRIM(v_desde)+" and "+ALLTRIM(v_hasta)+"  and  r.entidad = "+ALLTRIM(STR(p_entidad))+" AND  i.regimen = "+ALLTRIM(STR(P_regimen)) +" and u.idestador != "+ALLTRIM(STR(v_estadoAnulado))+"   group BY p.entidad "

 	
	verror=sqlrun(varconexionF,"totpagosRet0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias (0)",0+16+0,"")
	    RETURN .F.
	ENDIF 
	
					
	SELECT * FROM totpagosRet0 INTO TABLE totpagosRet
					
	ALTER table totpagosret alter COLUMN idimpuret I
	ALTER table totpagosret alter COLUMN impret Y
	
	
	ZAP IN totpagos
	SELECT totpagosRet
	GO TOP 
	
	IF EOF() && Si es Fin de archivo: es porque no se realizaron retenciones en el mes, guardo el monto en Cero.
		v_cod_socio = p_entidad
		v_pagosmes  = 0.00
		INSERT INTO totpagos (entidad,pagosmes) VALUES (v_cod_socio,v_pagosmes)

	ELSE && Se realizaron retenciones en el mes
	
	
		SELECT entidad, (pagosmes/v_divisorParaNeto) as pagosmes FROM totpagosRet INTO TABLE  totpagos
		
*!*				v_cod_socio = totpagosRet.entidad
*!*				v_pagosmes  = totpagosRet.pagosmes
*!*				
*!*				v_pagosmes  = v_pagosmes  / v_divisorParaNeto
*!*				MESSAGEBOX(v_pagosmes)
*!*				** En caso de que haya retenciones actualizo **
*!*				SELECT totpagos 
*!*				replace pagosmes WITH pagosmes + v_pagosmes ADDITIVE FOR entidad = v_cod_socio
*!*				
*!*				
*!*	*!*			DO WHILE NOT EOF()
*!*	*!*				v_cod_socio = totpagosRet.entidad
*!*	*!*				v_pagosmes  = totpagosRet.pagosmes
*!*	*!*				
*!*	*!*				v_pagosmes  = v_pagosmes  / v_divisorParaNeto
*!*	*!*				
*!*	*!*				INSERT INTO totpagos (entidad,pagosmes) VALUES (v_cod_socio,v_pagosmes)
*!*	*!*				
*!*	*!*				SELECT totpagosRet
*!*	*!*				SKIP 1
*!*	*!*			ENDDO 
*!*			
	ENDIF 
*	USE IN totpagos0 

****
*** Busco en la tabla linkcompro los comprobantes de pagos a proveedores que no tengan asociadas retenciones ***
****

	sqlmatriz(1) = " SELECT p.entidad, SUM(p.importe) as pagosmes, i.idimpuret FROM pagosprov p left join linkcompro l on p.idcomproba = l.idcomprobaa and p.idpago = l.idregistroa "
	sqlmatriz(2) = "  left join retenciones r on l.idcomprobab = r.idcomproba and l.idregistrob = r.idreten left join impuretencionh i on r.idreten = i.idreten  left join ultimoestado u on p.idpago = u.id and u.campo = 'idpago' and u.tabla = 'pagosprov' "
	sqlmatriz(3) = "    WHERE p.fecha between "+v_desde+" and "+v_hasta+" and "
	sqlmatriz(4) = "    	     p.entidad = "+ALLTRIM(STR(p_entidad)) +" and u.idestador != " +ALLTRIM(STR(v_estadoAnulado))
	sqlmatriz(5) = "    group BY p.entidad having isnull(i.idimpuret) "			


	verror=sqlrun(varconexionF,"totpagos0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias (1)",0+16+0,"")
	    RETURN .F.
	ENDIF 

	SELECT totpagos0
	GO TOP 
	
	DO WHILE NOT EOF()
		IF ISNULL(totpagos0.pagosmes) THEN 
			* No Grabo Nada
		ELSE 
			v_cod_socio = totpagos0.entidad
			v_pagosmes  = totpagos0.pagosmes
			
			v_pagosmes  = v_pagosmes  / v_divisorParaNeto
			
			** En caso de que haya retenciones actualizo **
			SELECT totpagos 
			replace pagosmes WITH pagosmes + v_pagosmes ADDITIVE FOR entidad = v_cod_socio
			
			
			*INSERT INTO totpagos (entidad,pagosmes) VALUES (p_entidad,v_pagosmes)
		ENDIF 
		
		SELECT totpagos0
		SKIP 1
	ENDDO  
	USE IN totpagos0


SELECT totpagos 

****
*** Obtengo información de la retención ***
****
	
	
	sqlmatriz(1) = " SELECT * FROM entidadret  "
	sqlmatriz(2) = "  where entidad   = "+ALLTRIM(STR(p_entidad)) + " and idimpuret   = "+ALLTRIM(STR(p_idimpuret))

	verror=sqlrun(varconexionF,"entidadret")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(3)",0+16+0,"")
	    RETURN .F.
	ENDIF 
		
	v_enconvenio = 'N'
	
	SELECT entidadret
	GO TOP 
	
	IF NOT EOF()
		SELECT entidadret
		v_enconvenio = entidadret.enconvenio	
	ELSE
		v_enconvenio = 'N'
	ENDIF 
	
	
	IF v_enconvenio = 'S' && Si está en convenio busco en las escalas según el campo razonin de la tabla impuretencion

		sqlmatriz(1) = "SELECT i.idimpuret, i.detalle, i.baseimpon as  baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret  "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

	ELSE && Si no está en convenio busco en las escalas según el campo razonnin de la tabla impuretencion

		sqlmatriz(1) = " SELECT i.idimpuret, i.detalle, i.baseimponn as baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret  "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonnin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

	ENDIF 

	verror=sqlrun(varconexionF,"impureten")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(4)",0+16+0,"")
	    RETURN .F.
	ENDIF 
	
	
****
*** Obtengo el total de retenciones realizadas en el mes para la entidad
****
	
	SELECT totpagosRet 
	*	SELECT entidad, impret as retenmes FROM totpagosRet WHERE idimpuret = p_idimpuret INTO TABLE totreten0
	SELECT entidad, impret as retenmes FROM totpagosRet WHERE regimen = p_regimen  INTO TABLE totreten0
	
		
	ZAP IN totreten
	SELECT totreten0
	GO TOP 
	DO WHILE NOT EOF()
		IF ISNULL(totreten0.retenmes) THEN 
			* No grabo Nada

			v_retenmes = 0.00
			INSERT INTO totreten (entidad, retenmes) VALUES (p_entidad,v_retenmes)
		ELSE 
		
		SELECT entidad,retenmes FROM totreten0 INTO TABLE totreten 
*!*			
*!*				v_cod_socio = totreten0.entidad
*!*				v_retensmes  = totreten0.retenmes
*!*									
*!*				** En caso de que haya retenciones actualizo **
*!*				SELECT totreten
*!*				replace retenmes WITH retenmes + v_retensmes ADDITIVE FOR entidad = v_cod_socio
*!*	*!*				
*!*	*!*			
*!*	*!*			

*!*	*!*				v_retenmes   = totreten0.retenmes 
*!*	*!*				INSERT INTO totreten (entidad ,retenmes) VALUES (p_entidad,v_retenmes)
		ENDIF 		
		SELECT totreten0
		SKIP 1
	ENDDO  
	
		
	v_razonAplicar = 0.00
	SELECT impureten
	GO TOP 
	IF NOT EOF()
	
		** Obtengo la razón **
			* Obtengo la razon a aplicar dependiendo si está en convenio o no
			
			* Si está incluido  en convenio, uso el id perteneciente al campo razonin de la tabla impuretencion
			
			* Si NO está incluido en convenio, uso el id perteneciente al campo razonnin
			
**********************************************************************************************************************
**** CALCULO DE RETENCIONES SEGÚN LAS ESCALAS CORRESPONDIENTES Y EN FUNCIÓN DE LOS PAGOS Y RETENCIONES REALIZADOS ****
**********************************************************************************************************************
					
			
*******************
**** 1- Calculo el total de pagos incluyendo el pago actual: v_pago_total_retener = total_pagos_mes + p_importe
*******************

			v_pago_total_retener = 0.00
		
			SELECT totPagos
			GO TOP 
						
			IF NOT EOF()
				v_pago_total_retener = (totPagos.pagosmes) + p_importe
			ELSE
				v_pago_total_retener = p_importe
			ENDIF 
			
		
*******************
**** 2- Calculo las retenciones para el monto sujeto a retener
*******************
			
			SELECT impureten
			
			v_baseImponible = impureten.baseimpon
			
			v_aretener = v_pago_total_retener - v_baseImponible
			
			IF v_aretener  > 0 && Tengo que retener
				
				SELECT * FROM impureten where v_aretener >= valmin and (v_aretener < valmax or valmax = -1) INTO TABLE retenciongan
				
				SELECT retenciongan
				
				v_valmin = retenciongan.valmin

				v_retener = v_aretener - v_valmin

				v_razon = retenciongan.razon

				v_valfijo = retenciongan.valfijo
	
			
				v_totalRetencionesRealizadas =0.00
				
				
				SELECT totreten
				GO TOP 
				
				IF NOT EOF()
					SELECT SUM(IIF(ISNULL(retenmes),0.00,retenmes)) as tot FROM totreten  INTO CURSOR totalRetRealizadas			
					SELECT totalRetRealizadas
					GO top
					
					IF NOT EOF()
						v_totalRetencionesRealizadas = totalRetRealizadas.tot
					ELSE
						v_totalRetencionesRealizadas  = 0.00
					ENDIF 
				ELSE
					v_totalRetencionesRealizadas =0.00
				ENDIF 



				v_retencion = v_retener*(v_razon/100) + v_valfijo - v_totalRetencionesRealizadas 

****
*** Controlo que el monto a retener sea mayor al mínimo de retenciones por impuesto
****			
			
			SELECT impureten
			v_minRet = impureten.minret
			
			IF v_retencion < v_minRet
				&& La retención a aplicar es menor que el minimo a retener para el concepto. No se aplican retenciones
			ELSE
						
****
*** Guardo en la tabla los datos para la retención
****			
				SELECT totpagos
				GO TOP 
		
				IF NOT EOF()
				
					v_totpagomes = totpagos.pagosmes
				ELSE
					v_totpagosmes = 0.00
				ENDIF 			
				SELECT totreten 
				GO TOP 
				IF NOT  EOF()
					v_totRetmes = totreten.retenmes				
				ELSE 
					v_totRetmes = 0.00				
				ENDIF 
				
				v_entidad = p_entidad
				v_idimpuret = P_idimpuret
				v_impTotal = P_importe
				v_impARet = v_retencion
				*v_impARet = v_totRetMes - v_retencion
				SELECT impureten 
				
				v_idtipopago = impureten.idtipopago
				v_descrip = ALLTRIM(impureten.detalle)+ " - " + ALLTRIM(impureten.descescala)
				v_idafipesc = impureten.idafipesc
				
				INSERT INTO &p_nombretabRes (entidad, idimpuret,impTotal,impARet,baseimpo,razon,idtipopago,descrip,totpagomes,totretmes,sujarete,idafipesc) VALUES (v_entidad, v_idimpuret,v_impTotal,v_impARet,v_baseImponible,v_razon,v_idtipopago,v_descrip,v_totpagomes,v_totretmes,v_aretener,v_idafipesc)

			ENDIF 
			
			
			ELSE && No tengo que retener			
			
			ENDIF 
		
	
	ELSE
	
	
	ENDIF 
			
	USE IN totreten0
	USE IN totreten
	USE IN totpagos
	
	
	* cierro la conexion
	= abreycierracon(varconexionF,"")


	RETURN .T.
	

ENDFUNC 






FUNCTION RET_IIBB_IFN
PARAMETERS  P_idimpuret, P_importe, P_fecha, P_entidad,P_nombreTabRes
*#/****************************
*** FUNCIÓN PARA EL CALCULO DEL MONTO A RETENER DE IIBB ***
****************************************************************
** PARÁMETROS: 	P_idimpuret: id impuesto de retención
*				P_importe: Importe Total, del cuál se va a calcular la retención. 
*				P_entidad: Entidad a la cual se le va a calcular la retención
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual inclura: idimpuret,netoTotal,importeARetener,totpagosmes,totRetenmes )
* La función recibe los parametros indicados y en función de eso y las tablas de retenciones calcula cuanto debe retenerse para la entidad y el importe dado
****************************************************************
** RETORNO: Retorna el importe a retener, el total de retenciones al mes y total de pagos. True si terminó correctamente, False en otro caso
*#/****************************


****** SI está en convenio se calcula sobre el total bruto. Si NO está en convenio se calcula sobre el neto

	* Abro una conexion con la base de datos 
	varconexionF = abreycierracon(0,_SYSSCHEMA)
	
****
*** Obtengo información de la retención ***
****
	
	
	sqlmatriz(1) = " SELECT * FROM entidadret  "
	sqlmatriz(2) = "  where entidad   = "+ALLTRIM(STR(p_entidad)) + " and idimpuret   = "+ALLTRIM(STR(p_idimpuret))

	verror=sqlrun(varconexionF,"entidadret")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(1)",0+16+0,"")
	    RETURN .F.
	ENDIF 
		
	v_enconvenio = 'N'
	
	SELECT entidadret
	GO TOP 
	
	IF NOT EOF()
		SELECT entidadret
		v_enconvenio = entidadret.enconvenio	
	ELSE
		v_enconvenio = 'N'
	ENDIF 
	
	
	
	IF v_enconvenio = 'S' && Si está en convenio busco en las escalas según el campo razonin de la tabla impuretencion

		sqlmatriz(1) = "SELECT i.idimpuret, i.detalle, i.baseimpon as baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

		****  SI está en convenio se calcula sobre el total bruto ****
		
		v_pago_total_retener = P_importe

	ELSE && Si no está en convenio busco en las escalas según el campo razonnin de la tabla impuretencion

		sqlmatriz(1) = " SELECT i.idimpuret, i.detalle, i.baseimponn as baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonnin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

		
		****  Si NO está en convenio se calcula sobre el neto ****
		v_pago_total_retener = P_importe / 1.21
		
	ENDIF 

	verror=sqlrun(varconexionF,"impureten")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(2)",0+16+0,"")
	    RETURN .F.
	ENDIF 	
	
					
	*******************
	**** 1- Calculo las retenciones para el monto sujeto a retener
	*******************
			
			SELECT impureten
			v_baseImponible = impureten.baseimpon
			
			
			v_aretener = v_pago_total_retener - v_baseImponible
			
			IF v_aretener  > 0 && Tengo que retener
				
				SELECT * FROM impureten where v_aretener >= valmin and (v_aretener < valmax or valmax = -1) INTO TABLE retenciongan
				
				SELECT retenciongan
				
				v_valmin = retenciongan.valmin

				v_retener = v_aretener - v_valmin

				v_razon = retenciongan.razon

				v_valfijo = retenciongan.valfijo

				v_totalRetencionesRealizadas =0.00
				
				v_retencion = v_retener*(v_razon/100) + v_valfijo
			
						
****
*** Controlo que el monto a retener sea mayor al mínimo de retenciones por impuesto
****			
			
				SELECT impureten
				v_minRet = impureten.minret
				
				IF v_retencion < v_minRet
					&& La retención a aplicar es menor que el minimo a retener para el concepto. No se aplican retenciones
				ELSE

****
*** Guardo en la tabla los datos para la retención
****			
										
					v_entidad = p_entidad
					v_idimpuret = P_idimpuret
					v_impTotal = P_importe
					v_impARet = v_retencion
					
					SELECT impureten 
					
					v_idtipopago = impureten.idtipopago
					v_descrip = ALLTRIM(impureten.detalle)+ " - " + ALLTRIM(impureten.descescala)
					v_idafipesc = impureten.idafipesc
					
			
					INSERT INTO &p_nombretabRes (entidad, idimpuret,impTotal,impARet,baseimpo,razon,idtipopago,descrip,sujarete, idafipesc) VALUES (v_entidad, v_idimpuret,v_impTotal,v_impARet,v_baseImponible,v_razon,v_idtipopago,v_descrip,v_aretener, v_idafipesc)

				ENDIF 

						
			ELSE && No tengo que retener			
			
			ENDIF 
			
			
		RETURN .T.

ENDFUNC 


************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************




FUNCTION RET_IIBB_STAFE_IFN
PARAMETERS  P_idimpuret, P_importe, P_fecha, P_entidad,P_nombreTabRes, p_regimen
*#/****************************
*** FUNCIÓN PARA EL CALCULO DEL MONTO A RETENER DE IIBB ARBA***
****************************************************************
** PARÁMETROS: 	P_idimpuret: id impuesto de retención
*				P_importe: Importe Total, del cuál se va a calcular la retención. 
*				P_entidad: Entidad a la cual se le va a calcular la retención
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual inclura: idimpuret,netoTotal,importeARetener,totpagosmes,totRetenmes )
* La función recibe los parametros indicados y en función de eso y las tablas de retenciones calcula cuanto debe retenerse para la entidad y el importe dado
****************************************************************
** RETORNO: Retorna el importe a retener, el total de retenciones al mes y total de pagos. True si terminó correctamente, False en otro caso
*#/****************************


****** El calculo será sobre el importe neto


	* Abro una conexion con la base de datos 
	varconexionF = abreycierracon(0,_SYSSCHEMA)
	
	
	v_sentenciaCrea1 = "CREATE TABLE "+ALLTRIM(p_nombreTabRes)+" FREE (entidad I,idimpuret I,impTotal Y,impARet Y,baseimpo Y,razon Y, idtipopago I, descrip C(250),totpagomes Y, totretmes Y, sujarete Y, idafipesc I)"
	&v_sentenciaCrea1 

****
*** Obtengo información de la retención ***
****
	
	
	sqlmatriz(1) = " SELECT * FROM entidadret  "
	sqlmatriz(2) = "  where entidad   = "+ALLTRIM(STR(p_entidad)) + " and idimpuret   = "+ALLTRIM(STR(p_idimpuret))

	verror=sqlrun(varconexionF,"entidadret")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(1)",0+16+0,"")
	    RETURN .F.
	ENDIF 
		
	v_enconvenio = 'N'
	
	SELECT entidadret
	GO TOP 
	
	IF NOT EOF()
		SELECT entidadret
		v_enconvenio = entidadret.enconvenio	
	ELSE
		v_enconvenio = 'N'
	ENDIF 
	
	
	
	IF v_enconvenio = 'S' && Si está en convenio busco en las escalas según el campo razonin de la tabla impuretencion

		sqlmatriz(1) = "SELECT i.idimpuret, i.detalle, i.baseimpon as baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

		****  SI está en convenio se calcula sobre el total bruto ****
		
		v_pago_total_retener = P_importe /1.21

	ELSE && Si no está en convenio busco en las escalas según el campo razonnin de la tabla impuretencion

		sqlmatriz(1) = " SELECT i.idimpuret, i.detalle, i.baseimponn as baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonnin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

		
		****  Si NO está en convenio se calcula sobre el neto ****
		v_pago_total_retener = P_importe /1.21

		
	ENDIF 

	verror=sqlrun(varconexionF,"impureten")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(2)",0+16+0,"")
	    RETURN .F.
	ENDIF 	
	
					
	*******************
	**** 1- Calculo las retenciones para el monto sujeto a retener
	*******************
			
			SELECT impureten
			v_baseImponible = impureten.baseimpon
			
			
			v_aretener = v_pago_total_retener - v_baseImponible
			
			IF v_aretener  > 0 && Tengo que retener
				
				SELECT * FROM impureten where v_aretener >= valmin and (v_aretener < valmax or valmax = -1) INTO TABLE retenciongan
				
				SELECT retenciongan
				
				v_valmin = retenciongan.valmin

				v_retener = v_aretener - v_valmin

				v_razon = retenciongan.razon

				v_valfijo = retenciongan.valfijo

				v_totalRetencionesRealizadas =0.00
				
				v_retencion = v_retener*(v_razon/100) + v_valfijo
			
						
****
*** Controlo que el monto a retener sea mayor al mínimo de retenciones por impuesto
****			
			
				SELECT impureten
				v_minRet = impureten.minret
				
				IF v_retencion < v_minRet
					&& La retención a aplicar es menor que el minimo a retener para el concepto. No se aplican retenciones
				ELSE

****
*** Guardo en la tabla los datos para la retención
****			
										
					v_entidad = p_entidad
					v_idimpuret = P_idimpuret
					v_impTotal = P_importe
					v_impARet = v_retencion
					
					SELECT impureten 
					
					v_idtipopago = impureten.idtipopago
					v_descrip = ALLTRIM(impureten.detalle)+ " - " + ALLTRIM(impureten.descescala)
					v_idafipesc = impureten.idafipesc
					
			
					INSERT INTO &p_nombretabRes (entidad, idimpuret,impTotal,impARet,baseimpo,razon,idtipopago,descrip,sujarete, idafipesc) VALUES (v_entidad, v_idimpuret,v_impTotal,v_impARet,v_baseImponible,v_razon,v_idtipopago,v_descrip,v_aretener, v_idafipesc)

				ENDIF 

						
			ELSE && No tengo que retener			
			
			ENDIF 
			
			
		RETURN .T.

ENDFUNC 


************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************



FUNCTION RET_IIBB_ARBA_IFN
PARAMETERS  P_idimpuret, P_importe, P_fecha, P_entidad,P_nombreTabRes, p_regimen
*#/****************************
*** FUNCIÓN PARA EL CALCULO DEL MONTO A RETENER DE IIBB ARBA***
****************************************************************
** PARÁMETROS: 	P_idimpuret: id impuesto de retención
*				P_importe: Importe Total, del cuál se va a calcular la retención. 
*				P_entidad: Entidad a la cual se le va a calcular la retención
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual inclura: idimpuret,netoTotal,importeARetener,totpagosmes,totRetenmes )
* La función recibe los parametros indicados y en función de eso y las tablas de retenciones calcula cuanto debe retenerse para la entidad y el importe dado
****************************************************************
** RETORNO: Retorna el importe a retener, el total de retenciones al mes y total de pagos. True si terminó correctamente, False en otro caso
*#/****************************


****** El calculo será sobre el importe neto


	* Abro una conexion con la base de datos 
	varconexionF = abreycierracon(0,_SYSSCHEMA)
	
	
	v_sentenciaCrea1 = "CREATE TABLE "+ALLTRIM(p_nombreTabRes)+" FREE (entidad I,idimpuret I,impTotal Y,impARet Y,baseimpo Y,razon Y, idtipopago I, descrip C(250),totpagomes Y, totretmes Y, sujarete Y, idafipesc I)"
	&v_sentenciaCrea1 

****
*** Obtengo información de la retención ***
****
	
	
	sqlmatriz(1) = " SELECT * FROM entidadret  "
	sqlmatriz(2) = "  where entidad   = "+ALLTRIM(STR(p_entidad)) + " and idimpuret   = "+ALLTRIM(STR(p_idimpuret))

	verror=sqlrun(varconexionF,"entidadret")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(1)",0+16+0,"")
	    RETURN .F.
	ENDIF 
		
	v_enconvenio = 'N'
	
	SELECT entidadret
	GO TOP 
	
	IF NOT EOF()
		SELECT entidadret
		v_enconvenio = entidadret.enconvenio	
	ELSE
		v_enconvenio = 'N'
	ENDIF 
	
	
	
	IF v_enconvenio = 'S' && Si está en convenio busco en las escalas según el campo razonin de la tabla impuretencion

		sqlmatriz(1) = "SELECT i.idimpuret, i.detalle, i.baseimpon as baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

		****  SI está en convenio se calcula sobre el total bruto ****
		
		v_pago_total_retener = P_importe /1.21

	ELSE && Si no está en convenio busco en las escalas según el campo razonnin de la tabla impuretencion

		sqlmatriz(1) = " SELECT i.idimpuret, i.detalle, i.baseimponn as baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon,a.minret "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonnin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

		
		****  Si NO está en convenio se calcula sobre el neto ****
		v_pago_total_retener = P_importe /1.21

		
	ENDIF 

	verror=sqlrun(varconexionF,"impureten")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(2)",0+16+0,"")
	    RETURN .F.
	ENDIF 	
	
					
	*******************
	**** 1- Calculo las retenciones para el monto sujeto a retener
	*******************
			
			SELECT impureten
			v_baseImponible = impureten.baseimpon
			
			
			v_aretener = v_pago_total_retener - v_baseImponible
			
			IF v_aretener  > 0 && Tengo que retener
				
				SELECT * FROM impureten where v_aretener >= valmin and (v_aretener < valmax or valmax = -1) INTO TABLE retenciongan
				
				SELECT retenciongan
				
				v_valmin = retenciongan.valmin

				v_retener = v_aretener - v_valmin

				v_razon = retenciongan.razon

				v_valfijo = retenciongan.valfijo

				v_totalRetencionesRealizadas =0.00
				
				v_retencion = v_retener*(v_razon/100) + v_valfijo
			
						
****
*** Controlo que el monto a retener sea mayor al mínimo de retenciones por impuesto
****			
			
				SELECT impureten
				v_minRet = impureten.minret
				
				IF v_retencion < v_minRet
					&& La retención a aplicar es menor que el minimo a retener para el concepto. No se aplican retenciones
				ELSE

****
*** Guardo en la tabla los datos para la retención
****			
										
					v_entidad = p_entidad
					v_idimpuret = P_idimpuret
					v_impTotal = P_importe
					v_impARet = v_retencion
					
					SELECT impureten 
					
					v_idtipopago = impureten.idtipopago
					v_descrip = ALLTRIM(impureten.detalle)+ " - " + ALLTRIM(impureten.descescala)
					v_idafipesc = impureten.idafipesc
					
			
					INSERT INTO &p_nombretabRes (entidad, idimpuret,impTotal,impARet,baseimpo,razon,idtipopago,descrip,sujarete, idafipesc) VALUES (v_entidad, v_idimpuret,v_impTotal,v_impARet,v_baseImponible,v_razon,v_idtipopago,v_descrip,v_aretener, v_idafipesc)

				ENDIF 

						
			ELSE && No tengo que retener			
			
			ENDIF 
			
			
		RETURN .T.

ENDFUNC 






FUNCTION PER_IIBB_ARBA_IFN
*#/****************************
*** FUNCIÓN PARA EL CALCULO DEL MONTO A PERCIBIR DE IIBB ARBA***
****************************************************************
** PARÁMETROS: 	p_idimpuper: ID del impuesto a percibir
*				p_entidad: Entidad a la cual se le va a calcular la percepción
*				p_fecha: Fecha del comprobante
*				p_neto: monto neto del comprobante
*				p_importeIva: monto del iva del comprobante
*				p_tipo: Tipo de comprobante (Pudiendo ser 'A' | 'B' | 'C' )
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual inclura: idimpuper,netoTotal,importeAPercibir,totpagosmes,totPercepmes )
* La función recibe los parametros indicados y en función de eso y las tablas de retenciones calcula cuanto debe retenerse para la entidad y el importe dado
****************************************************************
** RETORNO: Retorna el importe a percibir, el total de percepciones al mes y total de pagos. True si terminó correctamente, False en otro caso
*#/****************************
*PARAMETERS p_entidad, P_fecha, p_idimpuper, P_neto, P_importeiva, p_tipo, p_opera
PARAMETERS p_idimpuper, p_entidad, P_fecha,  p_neto, P_importeiva, p_tipo, p_nomTabRes
	
	
	
***********************
** ALGORITMO CALCULO **
***********************
** 1 - Obtengo montos de facturación del dia (subtotal e iva)  y  le sumo el monto de la factura que estoy haciendo
**		¿Tengo que discriminar si es comprobante A del resto? porqe veo que en el calculo de facturacion diaria, si es A tomo solo el neto y sino tomo el total
** 2 - Obtengo las percepciones de IIBB ya realizadas 
**		Las percepciones realizadas van a estar en la tabla detfactu como un concepto (Concepto PERCEPCION IIBB ARBA)
**		Con el idimpuper obtengo el concepto asociado (Agregar concepto a la tabla impupercepcion)
** 3 - Obtengo los datos del impuesto que voy a aplicar
** 4 - Calculo el impuesto y guardo los datos en una tabla temporal para retornar
	
	r_percep = 0
*!*		IF p_compro='F' OR p_compro='D' then
*!*			pp_compro = 1
*!*		ELSE 
*!*			pp_compro = -1
*!*		ENDIF 
 
*!*		P_subtotal = P_subtotal * pp_compro
*!*		P_iva      = P_iva * pp_compro
	
	*MESSAGEBOX("Subtotal: "+ALLTRIM(STR(P_subtotal,18,2))+"   IVA: "+ALLTRIM(STR(P_iva,18,2)) )
	
	
	
	*v_sentenciaCrea1 = "CREATE TABLE "+ALLTRIM(p_nomTabRes)+" FREE (entidad I,idimpuper I,impAPer Y,baseimpo Y,razon Y, idtipopago I, descrip C(250),totpagodia Y, totperdia Y, sujaper Y,tabart C(100),campoart C(100),codiArt C(50), operacion C(100))"
	v_sentenciaCrea1 = "CREATE TABLE "+ALLTRIM(p_nomTabRes)+" FREE (entidad I,idimpuper I,impAPer Y,baseimpo Y,razon Y,  descrip C(250),totpagodia Y, totperdia Y, sujaper Y,tabart C(100),campoart C(100),codiArt C(50), operacion C(100))"

	&v_sentenciaCrea1 


	CREATE TABLE totfact FREE (entidad i, factdiario y)
	CREATE TABLE totperc FREE (entidad i, percdiario y)

	* Abro una conexion con la base de datos Facturación
	varconexionF = abreycierracon(0,_SYSSCHEMA)
	
*******************
**** 1- Obtengo los montos de facturación del día y le sumo el monto de la factura que estoy haciendo
*******************
	
	sqlmatriz(1) = " SELECT sum(f.subtotal * t.opera) as subtotal, sum(d.importe * t.opera) as iva , t.opera, c.tipo  "
	sqlmatriz(2) = "    FROM facturas f LEFT JOIN comprobantes c ON c.idcomproba=f.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro  "
	sqlmatriz(3) = "    left join facturasimp d on f.idfactura = d.idfactura left join impuestos i on d.impuesto = i.impuesto "
	sqlmatriz(4) = "    WHERE f.fecha = '"+ALLTRIM(p_fecha)+"' and f.entidad = "+ALLTRIM(STR(p_entidad))+" and i.abrevia = 'IVA' and t.opera > 0"

	sqlmatriz(5) = "    group by c.tipo ORDER BY f.entidad"	

	verror=sqlrun(varconexionF,"totfact1")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Facturas",0+16+0,"")
	    RETURN .F.
	ENDIF 
	
	SELECT totfact1
	GO TOP 
	IF EOF() AND RECNO()=1 THEN 
		v_factdiario = 0
	ELSE 
		v_factdiario = totfact1.subtotal
	ENDIF 


*********************************************************	
	** ¿Está bien esta diferenciación? **
*********************************************************


	IF p_tipo = "A" THEN 
		v_factdiario = v_factdiario + p_neto
	ELSE
		v_factdiario = v_factdiario + totfact1.iva + p_neto + P_importeiva
	ENDIF 
	USE IN totfact1

	INSERT INTO totfact(entidad,factdiario) VALUES(p_entidad,v_factdiario)


*******************
**** 2 - Obtengo las percepciones de IIBB ya realizadas
*******************

		oeObjIIBB	= CREATEOBJECT('oeclass')	
		v_codTabIB	    =  oeObjIIBB.getCodigoOp('PERCEPCION IIBB ARBA') && Obtengo: CODIGO_TABLA. El caracter '_' es el de separación
		v_nPosR 		= AT('_',v_codTabIB) &&Retorna la posición donde aparece el caracter de separacion utilizado (_)
		v_codigoREC	    = SUBSTR(v_codTabIB,1,v_nPosR-1) && Retorna el código
		v_tablaIB		= SUBSTR(v_codTabIB,v_nPosR+1)	&& Retorna el resto de la cadena, que corresponde a la tabla
		RELEASE oeObjIIBB

		
*!*		sqlmatriz(1) = " SELECT sum(impperc) as impperc, sum(sujaperc) as sujaperc FROM impufactu "
*!*		sqlmatriz(2) = "    WHERE fecha = '"+ALLTRIM(p_fecha)+"' and cliente = "+ALLTRIM(STR(p_cliente))
*!*		sqlmatriz(3) = "          and impperc > 0 "
*!*		
		sqlmatriz(1) = " SELECT sum(d.total) as impperc, sum(if(f.tipo = 'A',f.neto,if(f.tipo='B' or f.tipo = 'C',f.total,0))) as sujaperc "
		sqlmatriz(2) = " FROM facturas f left join detafactu d on f.idfactura = d.idfactura "
		sqlmatriz(3) = " where f.fecha = '"+ALLTRIM(p_fecha)+"' and d.articulo = '"+ALLTRIM(v_codigoREC)+"' and f.entidad = "+ALLTRIM(STR(p_entidad))

	verror=sqlrun(varconexionF,"totperc0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Percepciones de IB",0+16+0,"")
	    RETURN .F.
	ENDIF 
	
	s_sujaperc   = 0
	ZAP IN totperc 
	SELECT totperc0
	GO TOP 
	IF EOF() AND RECNO()=1 THEN 
		v_percdiario = 0
		s_sujaperc   = 0
	ELSE
		IF ISNULL(totperc0.impperc)
			v_percdiario = 0
			s_sujaperc   = 0
		ELSE
			v_percdiario = totperc0.impperc
			s_sujaperc   = totperc0.sujaperc
		ENDIF 
	ENDIF 
	
	INSERT INTO totperc (entidad,percdiario) VALUES (p_entidad,v_percdiario)
	USE IN totperc0
	
	
*******************
**** 3 - Obtengo los datos del impuesto que voy a aplicar
*******************

	sqlmatriz(1) = " SELECT * FROM entidadper e left join impupercepcion p on e.idimpuper = p.idimpuper "
	sqlmatriz(2) = "  where e.entidad   = "+ALLTRIM(STR(p_entidad)) + " and e.idimpuper   = "+ALLTRIM(STR(p_idimpuper))

	verror=sqlrun(varconexionF,"datperc")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BUSQUEDA de Percepciones de IB",0+16+0,"")
	    RETURN .F.
	ENDIF 
		
		
	SELECT datperc
	GO TOP 
	
	v_razon      = datperc.razon
	v_pnombre    = datperc.detalle
	v_baseimpon  = datperc.baseimpon
*	v_idtipopago = datperc.idtipopago

	* cierro la conexion
	= abreycierracon(varconexionF,"")
	
*******************
**** 4 - Calculo el impuesto y guardo los datos en una tabla temporal para retornar
*******************
	
	IF ((v_factdiario-v_percdiario) - v_baseimpon) => 0 THEN 
		r_percep = ( (v_factdiario-v_percdiario) * (v_razon /100) ) - v_percdiario
		IF r_percep < 0 THEN 
			r_percep = 0
		ENDIF 
	ELSE
		r_percep = 0
	ENDIF 
	
	IF r_percep > 0
	    g_totaldia   = v_factdiario
	    g_percepdia  = v_percdiario + r_percep
		g_sujaperc   = (v_factdiario-v_percdiario) - s_sujaperc
	    g_impperc    = r_percep
		v_campoArt   = ""
		
		DO CASE
			CASE ALLTRIM(v_tablaIB) = "articulos"
				v_campoart = "articulo"
			CASE ALLTRIM(v_tablaIB) = "conceptoser"
				v_campoart = "idconcepto"
			OTHERWISE
				v_campoart = "articulo"
		ENDCASE
		
		v_operacion = 'PERCEPCION IIBB ARBA'
*!*			INSERT INTO &p_nomTabRes (entidad,idimpuper,impAPer,baseimpo,razon, idtipopago, descrip,totpagodia, totperdia, sujaper,tabart,campoart,codiArt, operacion) ;
*!*								 VALUES (v_entidad,v_idimpuper,g_impperc,v_baseimpon,v_razon, v_idtipopago, v_pnombre ,v_factdiario, g_percepdia  , g_sujaperc,v_tablaIB,v_campoart, v_codigoREC,v_operacion  ) ;

			INSERT INTO &p_nomTabRes (entidad,idimpuper,impAPer,baseimpo,razon,  descrip,totpagodia, totperdia, sujaper,tabart,campoart,codiArt, operacion) ;
							 VALUES (v_entidad,v_idimpuper,g_impperc,v_baseimpon,v_razon,  v_pnombre ,v_factdiario, g_percepdia  , g_sujaperc,v_tablaIB,v_campoart, v_codigoREC,v_operacion  ) ;


		endif 
	RETURN .T.
ENDFUNC 




*!*	************************************************************************************************************************
*!*	************************************************************************************************************************
*!*	************************************************************************************************************************


*!*	FUNCTION PercepIB
*!*	PARAMETERS P_sucursal,P_Cliente, P_fecha, p_impuesto, P_subtotal, P_iva, P_tipo, P_compro
*!*		r_percep = 0
*!*		IF p_compro='F' OR p_compro='D' then
*!*			pp_compro = 1
*!*		ELSE 
*!*			pp_compro = -1
*!*		ENDIF 
*!*	 
*!*	*!*		P_subtotal = P_subtotal * pp_compro
*!*	*!*		P_iva      = P_iva * pp_compro
*!*		
*!*		*MESSAGEBOX("Subtotal: "+ALLTRIM(STR(P_subtotal,18,2))+"   IVA: "+ALLTRIM(STR(P_iva,18,2)) )
*!*		
*!*		CREATE TABLE .\temp\totfact FREE (sucursal c(4), cod_socio i, factdiario y)
*!*		CREATE TABLE .\temp\totperc FREE (sucursal c(4), cod_socio i, percdiario y)
*!*			
*!*		* Abro una conexion con la base de datos Facturación
*!*		varconexionF = abreycierracon(0,miservidor+"\Facturacion\Datos.dbc")

*!*		* Busco lo Facturado en el Día.
*!*		sqlmatriz(1) = " SELECT F.subtotal, F.i_iva_g, C.operacion as opera, C.tipo "
*!*		sqlmatriz(2) = "    FROM facturas F "
*!*		sqlmatriz(3) = "    LEFT JOIN Comprobantes C ON C.idcomp=F.idcomp "
*!*		sqlmatriz(4) = "    WHERE F.fecha = '"+p_fecha+"' and F.succliente ='"+p_sucursal+"' and F.cod_socio = "+ALLTRIM(STR(p_cliente))
*!*		sqlmatriz(5) = "    ORDER BY F.cod_socio"	
*!*		verror=sqlrun(varconexionF,"totfact0")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Facturas",0+16+0,"")
*!*		ENDIF 
*!*		ZAP IN totfact
*!*		SELECT tipo, sum(subtotal*opera) as subtotal, sum(i_iva_g*opera) as iva from totfact0 ;
*!*		    where opera > 0 GROUP BY tipo ORDER BY tipo INTO CURSOR totfact1
*!*		USE IN totfact0
*!*		
*!*		SELECT totfact1
*!*		GO TOP 
*!*		IF EOF() AND RECNO()=1 THEN 
*!*			v_factdiario = 0
*!*		ELSE 
*!*			v_factdiario = totfact1.subtotal
*!*		ENDIF 
*!*		
*!*		IF p_tipo = "A" THEN 
*!*			v_factdiario = v_factdiario + P_subtotal
*!*		ELSE
*!*			v_factdiario = v_factdiario + totfact1.iva + P_subtotal + P_iva
*!*		ENDIF 
*!*		USE IN totfact1
*!*		
*!*		*MESSAGEBOX("TOTAL Facturado Diario: "+ALLTRIM(STR(v_factdiario,18,2)) )
*!*		
*!*		INSERT INTO totfact(sucursal,cod_socio,factdiario) VALUES(p_sucursal,p_cliente,v_factdiario)
*!*		
*!*		* Busco las Percepciones de ingresos brutos y a realizadas 
*!*		sqlmatriz(1) = " SELECT sum(impperc) as impperc, sum(sujaperc) as sujaperc FROM impufactu "
*!*		sqlmatriz(2) = "    WHERE fecha = '"+p_fecha+"' and sucursal ='"+p_sucursal+"' and cliente = "+ALLTRIM(STR(p_cliente))
*!*		sqlmatriz(3) = "          and impperc > 0 "
*!*		verror=sqlrun(varconexionF,"totperc0")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Percepciones de IB",0+16+0,"")
*!*		ENDIF 
*!*		s_sujaperc   = 0
*!*		ZAP IN totperc 
*!*		SELECT totperc0
*!*		GO TOP 
*!*		IF EOF() AND RECNO()=1 THEN 
*!*			v_percdiario = 0
*!*			s_sujaperc   = 0
*!*		ELSE
*!*			IF ISNULL(totperc0.impperc)
*!*				v_percdiario = 0
*!*				s_sujaperc   = 0
*!*			ELSE
*!*				v_percdiario = totperc0.impperc
*!*				s_sujaperc   = totperc0.sujaperc
*!*			ENDIF 
*!*		ENDIF 
*!*		
*!*		*MESSAGEBOX("TOTAL Percepciones Diaria: "+ALLTRIM(STR(v_percdiario,18,2))+" Sujeto a Percep.: "+ALLTRIM(STR(s_sujaperc,18,2)) )
*!*		
*!*		INSERT INTO totperc (sucursal,cod_socio,percdiario) VALUES (p_sucursal,p_cliente,v_percdiario)
*!*		USE IN totperc0
*!*		
*!*		* Buscar datos del impuesto
*!*		sqlmatriz(1) = " SELECT * FROM percepciones "
*!*		sqlmatriz(2) = "    WHERE pcodigo = "+ALLTRIM(STR(p_impuesto))
*!*		verror=sqlrun(varconexionF,"datperc")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la BUSQUEDA de Percepciones de IB",0+16+0,"")
*!*		ENDIF 
*!*		SELECT datperc
*!*		GO TOP 
*!*		v_razon      = datperc.razon
*!*		v_pnombre    = datperc.pnombre
*!*		v_orden      = datperc.orden
*!*		
*!*		* Calculo el importe del impuesto
*!*		IF (v_factdiario - datperc.minimpon) => 0 THEN 
*!*			r_percep = ( v_factdiario * (v_razon /100) ) - v_percdiario
*!*			IF r_percep < 0 THEN 
*!*				r_percep = 0
*!*			ENDIF 
*!*		ELSE
*!*			r_percep = 0
*!*		ENDIF 
*!*		
*!*		*MESSAGEBOX("Impuesto Calculado: "+ALLTRIM(STR(r_percep*pp_compro,18,2)) )
*!*		
*!*		* Cierro Archivos
*!*		*USE IN clie
*!*		
*!*		* cierro la conexion
*!*		= abreycierracon(varconexionF,"")
*!*	*!*		= abreycierracon(varconexionM,"")
*!*		
*!*		g_idregistro = 0 
*!*		g_fecha      = p_fecha
*!*		g_sucursal   = p_sucursal
*!*		g_cliente    = p_cliente
*!*		g_pcodigo    = p_impuesto
*!*		g_pnombre    = v_pnombre
*!*		g_orden      = v_orden
*!*	    g_convenio   = cliepercep.convenio
*!*	    g_nroinscrip = cliepercep.nroinscrip
*!*	    g_porcen     = v_razon
*!*	    g_totaldia   = v_factdiario
*!*	    g_percepdia  = v_percdiario + r_percep
*!*		g_sujaperc   = v_factdiario - s_sujaperc
*!*	    g_impperc    = r_percep

*!*		SELECT impufactu 
*!*		DELETE for pcodigo = g_pcodigo
*!*		
*!*		INSERT INTO impufactu (idregistro,fecha,sucursal,cliente,pcodigo,pnombre,orden,;
*!*		                       convenio,nroinscrip,porcen,totaldia,percepdia,sujaperc,impperc) ;
*!*	       VALUES (g_idregistro,g_fecha,g_sucursal,g_cliente,g_pcodigo,g_pnombre,g_orden,;
*!*	               g_convenio,g_nroinscrip,g_porcen,g_totaldia,g_percepdia,g_sujaperc,g_impperc)
*!*		
*!*		RETURN  r_percep
*!*	ENDFUNC 


*!*	************************************************************************************************************************
*!*	************************************************************************************************************************
*!*	************************************************************************************************************************
*!*	FUNCTION PercepIBnc
*!*	PARAMETERS P_sucursal,P_Cliente, P_fecha, p_impuesto, P_subtotal, P_iva, P_tipo, p_percep
*!*		r_percep = 0
*!*		
*!*		CREATE TABLE .\temp\totfact FREE (sucursal c(4), cod_socio i, factdiario y)
*!*		CREATE TABLE .\temp\totperc FREE (sucursal c(4), cod_socio i, percdiario y)
*!*			
*!*		* Abro una conexion con la base de datos Facturación
*!*		varconexionF = abreycierracon(0,miservidor+"\Facturacion\Datos.dbc")

*!*		* Busco lo Facturado en el Día.
*!*		sqlmatriz(1) = " SELECT F.subtotal, F.i_iva_g, C.operacion as opera, C.tipo "
*!*		sqlmatriz(2) = "    FROM facturas F "
*!*		sqlmatriz(3) = "    LEFT JOIN Comprobantes C ON C.idcomp=F.idcomp "
*!*		sqlmatriz(4) = "    WHERE F.fecha = '"+p_fecha+"' and F.succliente ='"+p_sucursal+"' and F.cod_socio = "+ALLTRIM(STR(p_cliente))
*!*		sqlmatriz(5) = "    ORDER BY F.cod_socio"	
*!*		verror=sqlrun(varconexionF,"totfact0")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Facturas",0+16+0,"")
*!*		ENDIF 
*!*		ZAP IN totfact
*!*		SELECT tipo, sum(subtotal*opera) as subtotal, sum(i_iva_g*opera) as iva from totfact0 ;
*!*		    WHERE opera > 0 GROUP BY tipo ORDER BY tipo INTO CURSOR totfact1
*!*		USE IN totfact0
*!*		
*!*		SELECT totfact1
*!*		GO TOP 
*!*		IF EOF() AND RECNO()=1 THEN 
*!*			v_factdiario = 0
*!*		ELSE 
*!*			v_factdiario = totfact1.subtotal
*!*		ENDIF 
*!*		
*!*		IF p_tipo = "A" THEN 
*!*			v_factdiario = v_factdiario + (P_subtotal * (-1)) && Por se NC
*!*		ELSE
*!*			v_factdiario = v_factdiario + totfact1.iva + (P_subtotal * (-1)) + (P_iva * (-1)) && por se NC
*!*		ENDIF 
*!*		USE IN totfact1
*!*		
*!*		INSERT INTO totfact(sucursal,cod_socio,factdiario) VALUES(p_sucursal,p_cliente,v_factdiario)
*!*		
*!*		* Busco las Percepciones de ingresos brutos y a realizadas 
*!*		sqlmatriz(1) = " SELECT sum(impperc) as impperc, sum(sujaperc) as sujaperc FROM impufactu "
*!*		sqlmatriz(2) = "    WHERE fecha = '"+p_fecha+"' and sucursal ='"+p_sucursal+"' and cliente = "+ALLTRIM(STR(p_cliente))
*!*		sqlmatriz(3) = "          and sujaperc > 0 "
*!*		verror=sqlrun(varconexionF,"totperc0")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Percepciones de IB",0+16+0,"")
*!*		ENDIF 
*!*		s_sujaperc   = 0
*!*		ZAP IN totperc 
*!*		SELECT totperc0
*!*		GO TOP 
*!*		IF EOF() AND RECNO()=1 THEN 
*!*			v_percdiario = 0
*!*			s_sujaperc   = 0
*!*		ELSE
*!*			IF ISNULL(totperc0.impperc)
*!*				v_percdiario = 0
*!*				s_sujaperc   = 0
*!*			ELSE
*!*				v_percdiario = totperc0.impperc
*!*				s_sujaperc   = totperc0.sujaperc
*!*			ENDIF 
*!*		ENDIF 
*!*		INSERT INTO totperc (sucursal,cod_socio,percdiario) VALUES (p_sucursal,p_cliente,v_percdiario)
*!*		USE IN totperc0
*!*		
*!*		* Buscar datos del impuesto
*!*		sqlmatriz(1) = " SELECT * FROM percepciones "
*!*		sqlmatriz(2) = "    WHERE pcodigo = "+ALLTRIM(STR(p_impuesto))
*!*		verror=sqlrun(varconexionF,"datperc")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la BUSQUEDA de Percepciones de IB",0+16+0,"")
*!*		ENDIF 
*!*		SELECT datperc
*!*		GO TOP 
*!*		v_razon      = datperc.razon
*!*		v_pnombre    = datperc.pnombre
*!*		v_orden      = datperc.orden
*!*		
*!*		r_percep     = p_percep * (-1) && Por Ser NC

*!*		IF p_tipo = "A" THEN 
*!*			g_sujaperc = (P_subtotal * (-1)) && Por se NC
*!*		ELSE
*!*			g_sujaperc = (P_subtotal * (-1)) + (P_iva * (-1)) && por se NC
*!*		ENDIF 

*!*		* cierro la conexion
*!*		= abreycierracon(varconexionF,"")
*!*	*!*		= abreycierracon(varconexionM,"")
*!*		
*!*		g_idregistro = 0 
*!*		g_fecha      = p_fecha
*!*		g_sucursal   = p_sucursal
*!*		g_cliente    = p_cliente
*!*		g_pcodigo    = p_impuesto
*!*		g_pnombre    = v_pnombre
*!*		g_orden      = v_orden
*!*	    g_convenio   = cliepercep.convenio
*!*	    g_nroinscrip = cliepercep.nroinscrip
*!*	    g_porcen     = v_razon
*!*	    g_totaldia   = g_sujaperc
*!*	    g_percepdia  = r_percep && v_percdiario + r_percep
*!*		*g_sujaperc   = v_factdiario - s_sujaperc
*!*	    g_impperc    = r_percep

*!*		SELECT impufactu 
*!*		DELETE for pcodigo = g_pcodigo
*!*		
*!*		INSERT INTO impufactu (idregistro,fecha,sucursal,cliente,pcodigo,pnombre,orden,;
*!*		                       convenio,nroinscrip,porcen,totaldia,percepdia,sujaperc,impperc) ;
*!*	       VALUES (g_idregistro,g_fecha,g_sucursal,g_cliente,g_pcodigo,g_pnombre,g_orden,;
*!*	               g_convenio,g_nroinscrip,g_porcen,g_totaldia,g_percepdia,g_sujaperc,g_impperc)
*!*		
*!*		RETURN  r_percep
*!*	ENDFUNC 



FUNCTION atualizarRetenciones
PARAMETERS p_archivo, p_funcion
*#/****************************
*** FUNCIÓN PARA ACTUALIZAR LAS ALICUOTAS DE RETENCIONES***
****************************************************************
** PARÁMETROS: 	p_archivo: ubicación del archivo CSV de donde se va a leer
*				p_funcion: Función de filtrado de impuesto
****************************************************************
** RETORNO: Retorna la cantidad de registros procesados, retorna un valor <0 si hubo un error
*#/****************************


****
** Para el manejo de varios archivos se me ocurren dos alternativas:
** Usar un CASE con las funciones existentes e ir agregando casos en el CASE.
** o usar una tabla en la base de datos con tipos de archivos, donde tenga definido el formato y a que tipo de impuesto está asociado
**






IF EMPTY(ALLTRIM(p_archivo)) = .T.
	p_archivo= GETFILE('','','Ok',0,'Actualizar retenciones')
ENDIF 




* Abro una conexion con la base de datos 
	varconexionF = abreycierracon(0,_SYSSCHEMA)
	
	
	
	sqlmatriz(1)= " SELECT e.*,r.identret,r.idimpuret,i.funcion "
	sqlmatriz(2)= " from entidades e left join entidadret r on e.entidad = r.entidad left join impuretencion i on r.idimpuret = i.idimpuret "
	sqlmatriz(3)= " where i.funcion = '"+ALLTRIM(p_funcion)+"' or isnull(i.funcion) group by e.entidad,i.funcion "

	verror=sqlrun(varconexionF,"entidadesretaux")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de entidades ",0+16+0,"")
	    RETURN -1
	ENDIF 
	
	
	sqlmatriz(1)= " select i.*, ai.razon as alin, an.razon as alnin " 
	sqlmatriz(2)= " from impuretencion i  left join afipescalas ai on i.razonin = ai.codigo left join afipescalas an on i.razonnin = an.codigo "
	sqlmatriz(3)= " where funcion = '"+ALLTRIM(p_funcion)+"'"
	
	verror=sqlrun(varconexionF,"impuretencion")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de retenciones ",0+16+0,"")
	    RETURN -1
	ENDIF 
	
	* cierro la conexion
	= abreycierracon(varconexionF,"")
	SELECT * FROM entidadesretaux INTO TABLE entidadesret
	SELECT entidadesret 
	GO TOP 
	
	IF EOF()
		MESSAGEBOX("Ha Ocurrido un Error, no existen entidades cargadas ",0+16+0,"")
		RETURN -1
	ENDIF 
	SELECT entidadesret 
	INDEX on cuit TO cuit 
	
DO CASE
CASE ALLTRIM(p_funcion) == 'RET_IIBB_ARBA_IFN'
	p_archivo = alltrim(p_archivo)
	
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
			RETURN -1
		ENDIF
		
		
		*** Cargo el archivo en una tabla ***
		
		
		if file("padronIIBBARBAtmp.dbf") THEN
			if used("padronIIBBARBAtmp") then
				sele padronIIBBARBAtmp
				use
			endif
			DELETE FILE padronIIBBARBAtmp.dbf
		ENDIF
			

		CREATE TABLE padronIIBBARBAtmp FREE ( regimen c(1) , fechapub c(8), fechades c(8), fechahas c(8), cuit C(11), tipocont C(1), estado C(1), cambio C(1), alicuota N(10,2), grupo C(2) )
		SELE padronIIBBARBAtmp

 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje
		SELECT padronIIBBARBAtmp

		GO TOP 
		IF EOF() THEN 
			USE 
			RETURN 0
		ENDIF 
		
		SELECT padronIIBBARBAtmp

		ALTER table padronIIBBARBAtmp ADD COLUMN fechapubd D		
		ALTER table padronIIBBARBAtmp ADD COLUMN fechadesd D
		ALTER table padronIIBBARBAtmp ADD COLUMN fechahasd D

		SELECT padronIIBBARBAtmp
		GO TOP 
		replace ALL fechapubd WITH DATE(VAL(SUBSTR(fechapub,5,4)),VAL(SUBSTR(fechapub,3,2)),VAL(SUBSTR(fechapub,1,2))), ;
		fechadesd WITH DATE(VAL(SUBSTR(fechades,5,4)),VAL(SUBSTR(fechades,3,2)),VAL(SUBSTR(fechades,1,2))), ;
		fechahasd WITH DATE(VAL(SUBSTR(fechahas,5,4)),VAL(SUBSTR(fechahas,3,2)),VAL(SUBSTR(fechahas,1,2)))
		
		SELECT padronIIBBARBAtmp
		GO TOP 
		
		SELECT * FROM entidadesret e LEFT JOIN padronIIBBARBAtmp p  ON e.cuit = p.cuit HAVING  regimen = 'R' INTO TABLE padronIIBBARBA
		
		SELECT padronIIBBARBA
		GO top
		
		** Filtro las entidades para dar de baja de retención **
		
		SELECT * FROM padronIIBBARBA WHERE identret > 0 AND funcion = p_funcion AND (estado = 'B' OR ISNULL(regimen) = .T. OR alicuota = 0.00 ) INTO TABLE padronIIBBARBAbaja
		
		SELECT * FROM padronIIBBARBA WHERE identret > 0 AND funcion = p_funcion AND estado <> 'B' AND alicuota > 0  INTO TABLE padronIIBBARBAactu
			
		SELECT * FROM padronIIBBARBA WHERE ((identret = 0 AND funcion = p_funcion) OR ISNULL(identret) = .T.) AND estado <> 'B' AND alicuota > 0 INTO TABLE padronIIBBARBAalta
				
		SELECT padronIIBBARBAbaja
		GO TOP 	
		
		SELECT padronIIBBARBAactu
		GO TOP 	
				
		SELECT p.*,i.idimpuret as idimpret FROM padronIIBBARBAalta p LEFT JOIN impuretencion i ON p.alicuota = i.alin  INTO TABLE insIIBBarba
		
		v_regprocesados = 0
		SELECT insIIBBarba
		GO TOP 	

		IF NOT EOF()
		
			** Cargo los registros en entidadret **
		
			* Abro una conexion con la base de datos 
			varconexionF = abreycierracon(0,_SYSSCHEMA)
			DIMENSION lamatriz(4,2)
			
			SELECT insIIBBarba
			GO TOP 
			DO WHILE NOT EOF()
			
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				
				SELECT insIIBBarba
				v_identret = 0
				v_entidad = insIIBBarba.entidad
				v_idimpuret = insIIBBarba.idimpret
				v_enconvenio = IIF(insIIBBarba.tipocont ='C','S','N')
								
				lamatriz(1,1) = 'identret'
				lamatriz(1,2) = ALLTRIM(STR(v_identret))
				lamatriz(2,1) = 'entidad'
				lamatriz(2,2) = ALLTRIM(STR(v_entidad))
				lamatriz(3,1) = 'idimpuret'
				lamatriz(3,2) = ALLTRIM(STR(v_idimpuret))
				lamatriz(4,1) = 'enconvenio'
				lamatriz(4,2) = "'"+ALLTRIM(v_enconvenio)+"'"

				p_tabla     = 'entidadret'
				p_matriz    = 'lamatriz'
				p_conexion  = varconexionF 
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error al registrar la retención para la entidad "+ALLTRIM(STR(v_entidad)),0+48+0,"Error")
				ENDIF 
				v_regprocesados = v_regprocesados  + 1
				
				SELECT insIIBBarba
				SKIP 1
			ENDDO 
						
				* cierro la conexion
				= abreycierracon(varconexionF,"")
		
		ENDIF 
		
		**** ACtualizo entidades ***
		
		
		SELECT p.*,i.idimpuret as idimpret FROM padronIIBBARBAactu p LEFT JOIN impuretencion i ON p.alicuota = i.alin  INTO TABLE upIIBBarba
				
		SELECT upIIBBarba
		GO TOP 	

		IF NOT EOF()
		
			** Cargo los registros en entidadret **
			
			* Abro una conexion con la base de datos 
			varconexionF = abreycierracon(0,_SYSSCHEMA)
			DIMENSION lamatriz(4,2)
			
			SELECT upIIBBarba
			GO TOP 
			DO WHILE NOT EOF()
				v_identret = upIIBBarba.identret
				
				p_tipoope     = 'U'
				p_condicion   = " identret = "+ALLTRIM(STR(v_identret))
				v_titulo      = " LA MODIFICACIÓN "
				
				SELECT upIIBBarba
				
				v_entidad = upIIBBarba.entidad
				v_idimpuret = upIIBBarba.idimpret
				v_enconvenio = IIF(upIIBBarba.tipocont ='C','S','N')
								
				lamatriz(1,1) = 'identret'
				lamatriz(1,2) = ALLTRIM(STR(v_identret))
				lamatriz(2,1) = 'entidad'
				lamatriz(2,2) = ALLTRIM(STR(v_entidad))
				lamatriz(3,1) = 'idimpuret'
				lamatriz(3,2) = ALLTRIM(STR(v_idimpuret))
				lamatriz(4,1) = 'enconvenio'
				lamatriz(4,2) = "'"+ALLTRIM(v_enconvenio)+"'"
				
				p_tabla     = 'entidadret'
				p_matriz    = 'lamatriz'
				p_conexion  = varconexionF 
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error al registrar la retención para la entidad "+ALLTRIM(STR(v_entidad)),0+48+0,"Error")
				ENDIF 
				v_regprocesados = v_regprocesados  + 1
				
				SELECT upIIBBarba
				SKIP 1
			ENDDO 
			
		ENDIF 	
									
			**** Elimino las entidades ***
							
		SELECT padronIIBBARBAbaja
		GO TOP 	

		IF NOT EOF()
		
			** Cargo los registros en entidadret **
		
			* Abro una conexion con la base de datos 
			varconexionF = abreycierracon(0,_SYSSCHEMA)
							
			
			SELECT padronIIBBARBAbaja
			GO TOP 
			DO WHILE NOT EOF()
				v_identret = padronIIBBARBAbaja.identret
								
				sqlmatriz(1)= " DELETE FROM entidadret where identret = "+ALLTRIM(STR(v_identret))
							
				verror=sqlrun(varconexionF ,"eliminoretent")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la eliminación de retenciones ",0+16+0,"")
				    RETURN -1
				ENDIF 
					
				v_regprocesados = v_regprocesados  + 1
				
				SELECT padronIIBBARBAbaja
				SKIP 1
			ENDDO 
					
			
				* cierro la conexion
				= abreycierracon(varconexionF,"")

		ENDIF 
		
		
		
		
OTHERWISE

ENDCASE

**EJ: SELECT * FROM processar_arenera.entidadret e left join processar_arenera.impuretencion i on e.idimpuret = i.idimpuret where funcion = 'RET_IIBB_ARBA_IFN'

RETURN v_regprocesados 

ENDFUNC 












FUNCTION atualizarPercepciones
PARAMETERS p_archivo, p_funcion
*#/****************************
*** FUNCIÓN PARA ACTUALIZAR LAS ALICUOTAS DE PERCEPCIONES PARA LAS ENTIDADES***
****************************************************************
** PARÁMETROS: 	p_archivo: ubicación del archivo CSV de donde se va a leer
*				p_funcion: Función de filtrado de impuesto
****************************************************************
** RETORNO: Retorna la cantidad de registros procesados, retorna un valor <0 si hubo un error
*#/****************************


****
** Para el manejo de varios archivos se me ocurren dos alternativas:
** Usar un CASE con las funciones existentes e ir agregando casos en el CASE.
** o usar una tabla en la base de datos con tipos de archivos, donde tenga definido el formato y a que tipo de impuesto está asociado
**


IF EMPTY(ALLTRIM(p_archivo)) = .T.
	p_archivo= GETFILE('','','Ok',0,'Actualizar percepciones')
ENDIF 


* Abro una conexion con la base de datos 
	varconexionF = abreycierracon(0,_SYSSCHEMA)
		
	sqlmatriz(1)= " SELECT e.*,r.identper,r.idimpuper,i.funcion "
	sqlmatriz(2)= " from entidades e left join entidadper r on e.entidad = r.entidad left join impupercepcion i on r.idimpuper = i.idimpuper "
	sqlmatriz(3)= " where i.funcion = '"+ALLTRIM(p_funcion)+"' or isnull(i.funcion) group by e.entidad,i.funcion "

	verror=sqlrun(varconexionF,"entidadesperaux")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de entidades ",0+16+0,"")
	    RETURN -1
	ENDIF 
	
	sqlmatriz(1)= " select i.* " 
	sqlmatriz(2)= " from impupercepcion i  "
	sqlmatriz(3)= " where funcion = '"+ALLTRIM(p_funcion)+"'"
	
	verror=sqlrun(varconexionF,"impupercepcion")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de percepciones ",0+16+0,"")
	    RETURN -1
	ENDIF 
	
	* cierro la conexion
	= abreycierracon(varconexionF,"")
	SELECT * FROM entidadesperaux INTO TABLE entidadesper
	SELECT entidadesper
	GO TOP 
	
	IF EOF()
		MESSAGEBOX("Ha Ocurrido un Error, no existen entidades cargadas ",0+16+0,"")
		RETURN -1
	ENDIF 
	
	SELECT entidadesper
	INDEX on cuit TO cuit 
	
DO CASE
CASE ALLTRIM(p_funcion) == 'PER_IIBB_ARBA_IFN'
	p_archivo = alltrim(p_archivo)
	
		if !file(p_archivo) THEN
			=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
			RETURN -1
		ENDIF
				
		*** Cargo el archivo en una tabla ***
				
		if file("padronPIIBBARBAtmp.dbf") THEN
			if used("padronPIIBBARBAtmp") then
				sele padronPIIBBARBAtmp
				use
			endif
			DELETE FILE padronPIIBBARBAtmp.dbf
		ENDIF
			
		CREATE TABLE padronPIIBBARBAtmp FREE ( regimen c(1) , fechapub c(8), fechades c(8), fechahas c(8), cuit C(11), tipocont C(1), estado C(1), cambio C(1), alicuota N(10,2), grupo C(2) )
		SELE padronPIIBBARBAtmp 

 		eje = "APPEND FROM "+p_archivo+" DELIMITED WITH CHARACTER ';'"
		&eje
		
		SELECT padronPIIBBARBAtmp 

		GO TOP 
		IF EOF() THEN 
			USE 
			RETURN 0
		ENDIF 
		
		SELECT padronPIIBBARBAtmp 

		ALTER table padronPIIBBARBAtmp ADD COLUMN fechapubd D		
		ALTER table padronPIIBBARBAtmp ADD COLUMN fechadesd D
		ALTER table padronPIIBBARBAtmp ADD COLUMN fechahasd D

		SELECT padronPIIBBARBAtmp 
		GO TOP 
		replace ALL fechapubd WITH DATE(VAL(SUBSTR(fechapub,5,4)),VAL(SUBSTR(fechapub,3,2)),VAL(SUBSTR(fechapub,1,2))), ;
		fechadesd WITH DATE(VAL(SUBSTR(fechades,5,4)),VAL(SUBSTR(fechades,3,2)),VAL(SUBSTR(fechades,1,2))), ;
		fechahasd WITH DATE(VAL(SUBSTR(fechahas,5,4)),VAL(SUBSTR(fechahas,3,2)),VAL(SUBSTR(fechahas,1,2)))
			
		SELECT padronPIIBBARBAtmp 
		GO TOP 
		
		SELECT * FROM entidadesper e LEFT JOIN padronPIIBBARBAtmp p  ON e.cuit = p.cuit HAVING  regimen = 'P' INTO TABLE padronPIIBBARBA
		
		SELECT padronPIIBBARBA
		GO top
		
		** Filtro las entidades para dar de baja de retención **
		
		SELECT * FROM padronPIIBBARBA WHERE identper > 0 AND funcion = p_funcion AND (estado = 'B' OR ISNULL(regimen) = .T. OR alicuota = 0.00 ) INTO TABLE padronPIIBBARBAbaja
		
		SELECT * FROM padronPIIBBARBA WHERE identper > 0 AND funcion = p_funcion AND estado <> 'B' AND alicuota > 0  INTO TABLE padronPIIBBARBAactu
			
		SELECT * FROM padronPIIBBARBA WHERE ((identper  = 0 AND funcion = p_funcion) OR ISNULL(identper) = .T.) AND estado <> 'B' AND alicuota > 0 INTO TABLE padronPIIBBARBAalta
				
		SELECT padronPIIBBARBAbaja
		GO TOP 	
		
		SELECT padronPIIBBARBAactu
		GO TOP 	
				
		SELECT p.*,i.idimpuper as idimpper FROM padronPIIBBARBAalta p LEFT JOIN impupercepcion i ON p.alicuota = i.razon  INTO TABLE insPIIBBarba

		v_regprocesados = 0
		SELECT insPIIBBarba
		GO TOP 	

		IF NOT EOF()
		
			** Cargo los registros en entidadret **
		
			* Abro una conexion con la base de datos 
			varconexionF = abreycierracon(0,_SYSSCHEMA)
			DIMENSION lamatriz(4,2)
			
			SELECT insPIIBBarba
			GO TOP 
			DO WHILE NOT EOF()
			
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				
				SELECT insPIIBBarba
				v_identper = 0
				v_entidad = insPIIBBarba.entidad
				v_idimpuper = insPIIBBarba.idimpper
				v_enconvenio = IIF(insPIIBBarba.tipocont ='C','S','N')
								
				lamatriz(1,1) = 'identper'
				lamatriz(1,2) = ALLTRIM(STR(v_identper))
				lamatriz(2,1) = 'entidad'
				lamatriz(2,2) = ALLTRIM(STR(v_entidad))
				lamatriz(3,1) = 'idimpuper'
				lamatriz(3,2) = ALLTRIM(STR(v_idimpuper))
				lamatriz(4,1) = 'enconvenio'
				lamatriz(4,2) = "'"+ALLTRIM(v_enconvenio)+"'"

				p_tabla     = 'entidadper'
				p_matriz    = 'lamatriz'
				p_conexion  = varconexionF 
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error al registrar la retención para la entidad "+ALLTRIM(STR(v_entidad)),0+48+0,"Error")
				ENDIF 
				v_regprocesados = v_regprocesados  + 1
				
				SELECT insPIIBBarba
				SKIP 1
			ENDDO 
						
				* cierro la conexion
				= abreycierracon(varconexionF,"")
		
		ENDIF 
			
		**** ACtualizo entidades ***
				
		SELECT p.*,i.idimpuper as idimpper FROM padronPIIBBARBAactu p LEFT JOIN impupercepcion i ON p.alicuota = i.razon  INTO TABLE upPIIBBarba
				
		SELECT upPIIBBarba
		GO TOP 	

		IF NOT EOF()
		
			** Cargo los registros en entidadret **
			
			* Abro una conexion con la base de datos 
			varconexionF = abreycierracon(0,_SYSSCHEMA)
			DIMENSION lamatriz(4,2)
			
			SELECT upPIIBBarba
			GO TOP 
			DO WHILE NOT EOF()
				v_identper = upPIIBBarba.identper
				
				p_tipoope     = 'U'
				p_condicion   = " identper = "+ALLTRIM(STR(v_identper))
				v_titulo      = " LA MODIFICACIÓN "
				
				SELECT upPIIBBarba
				
				v_entidad = upPIIBBarba.entidad
				v_idimpuper = upPIIBBarba.idimpper
				v_enconvenio = IIF(upIIBBarba.tipocont ='C','S','N')
								
				lamatriz(1,1) = 'identper'
				lamatriz(1,2) = ALLTRIM(STR(v_identper))
				lamatriz(2,1) = 'entidad'
				lamatriz(2,2) = ALLTRIM(STR(v_entidad))
				lamatriz(3,1) = 'idimpuper'
				lamatriz(3,2) = ALLTRIM(STR(v_idimpuper))
				lamatriz(4,1) = 'enconvenio'
				lamatriz(4,2) = "'"+ALLTRIM(v_enconvenio)+"'"
				
				p_tabla     = 'entidadper'
				p_matriz    = 'lamatriz'
				p_conexion  = varconexionF 
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error al registrar la percepción para la entidad "+ALLTRIM(STR(v_entidad)),0+48+0,"Error")
				ENDIF 
				v_regprocesados = v_regprocesados  + 1
				
				SELECT upPIIBBarba
				SKIP 1
			ENDDO 
			
		ENDIF 	
						
			**** Elimino las entidades ***
							
		SELECT padronPIIBBARBAbaja
		GO TOP 	

		IF NOT EOF()
		
			** Cargo los registros en entidadret **
		
			* Abro una conexion con la base de datos 
			varconexionF = abreycierracon(0,_SYSSCHEMA)
			
			SELECT padronPIIBBARBAbaja
			GO TOP 
			DO WHILE NOT EOF()
				v_identper = padronPIIBBARBAbaja.identper
								
				sqlmatriz(1)= " DELETE FROM entidadper where identper = "+ALLTRIM(STR(v_identper))
							
				verror=sqlrun(varconexionF ,"eliminopercep")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la eliminación de percepciones ",0+16+0,"")
				    RETURN -1
				ENDIF 
					
				v_regprocesados = v_regprocesados  + 1
				
				SELECT padronPIIBBARBAbaja
				SKIP 1
			ENDDO 

				* cierro la conexion
				= abreycierracon(varconexionF,"")

		ENDIF 
					
		
OTHERWISE

ENDCASE

**EJ: SELECT * FROM processar_arenera.entidadret e left join processar_arenera.impuretencion i on e.idimpuret = i.idimpuret where funcion = 'RET_IIBB_ARBA_IFN'

RETURN v_regprocesados 

ENDFUNC 


