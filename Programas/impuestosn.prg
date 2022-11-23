
****************************************************************
*** FUNCIÓN PARA EL CALCULO DEL MONTO A RETENER DE GANANCIAS ***
****************************************************************
** PARÁMETROS: 	P_idimpuret: id impuesto de retención
*				P_importe: Importe Total, del cuál se va a calcular la retención
*				P_fecha: Fecha para el cálculo de la rentención
*				P_entidad: Entidad a la cual se le va a calcular la retención
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual inclura: idimpuret,netoTotal,importeARetener,totpagosmes,totRetenmes )
* La función recibe los parametros indicados y en función de eso y las tablas de retenciones calcula cuanto debe retenerse para la entidad y el importe dado
****************************************************************
** RETORNO: Retorna el importe a retener, el total de retenciones al mes y total de pagos. True si terminó correctamente, False en otro caso
****************************************************************

FUNCTION GANANCIAS_IFN
PARAMETERS P_idimpuret, P_importe, P_fecha, P_entidad,P_nombreTabRes


	* Creo tablas
	CREATE TABLE totpagos FREE (entidad i, pagosmes y)
	CREATE TABLE totreten FREE (entidad i, retenmes y)
		
	v_sentenciaCrea1 = "CREATE TABLE "+ALLTRIM(p_nombreTabRes)+" FREE (entidad I,idimpuret I,impTotal Y,impARet Y,baseimpo Y,razon Y, idtipopago I, descrip C(250),totpagomes Y, totretmes Y, sujarete Y)"

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
	
*!*		sqlmatriz(1) = " SELECT R.cod_socio, max(R.pagosmes) as pagosmes FROM reciretencion  R "
*!*		sqlmatriz(2) = "    left join recibosprov P on R.idrecibo = P.idrecibo "
*!*		sqlmatriz(3) = "    WHERE P.fecha between "+v_desde+" and "+v_hasta+" and "
*!*		sqlmatriz(4) = "    	  R.cod_socio = "+ALLTRIM(STR(tmpretencion.cod_socio))+" AND "
*!*		sqlmatriz(5) = "          R.icodigo = "+ALLTRIM(STR(tmpretencion.icodigo))
*!*		sqlmatriz(6) = "     group BY R.cod_socio ORDER BY R.cod_socio"	
*!*		verror=sqlrun(varconexionF,"totpagos0")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Impuestos (0)",0+16+0,"")
*!*		ENDIF 
*!*		


******************************************************************************************
**** BUSCO PAGOS SIN RETENCIONES Y RETENCIONES REALIZADAS DE PAGOS ANTERIORES EN EL MES PASADO COMO PARÁMETRO ****
******************************************************************************************

****
*** Retenciones realizadas en el mes pasado como parámetro ***
****

*!*		sqlmatriz(1) = " SELECT R.entidad, max(R.importe) as pagosmes FROM retenciones R "
*!*		sqlmatriz(2) = "    WHERE R.fecha between "+v_desde+" and "+v_hasta+" and "
*!*		sqlmatriz(3) = "    	  R.entidad = "+ALLTRIM(STR(p_entidad))+" AND "
*!*		sqlmatriz(4) = "          R.idimpuret = "+ALLTRIM(STR(P_idimpuret))
*!*		sqlmatriz(5) = "     group BY R.entidad ORDER BY R.entidad "	
	
sqlmatriz(1)= " SELECT p.entidad, ifnull(r.idimpuret, 0) as idimpuret, SUM(p.importe) as pagosmes, ifnull(sum(r.importe),0.00) as impret   FROM pagosprov p left join linkcompro l on p.idcomproba = l.idcomprobaa and p.idpago = l.idregistroa "
sqlmatriz(2)= "  left join retenciones r on l.idcomprobab = r.idcomproba and l.idregistrob = r.idreten left join ultimoestado u on p.idpago = u.id and u.campo = 'idpago' and u.tabla = 'pagosprov' "
sqlmatriz(3)= " WHERE p.fecha between "+ALLTRIM(v_desde)+" and "+ALLTRIM(v_hasta)+"  and  "+ALLTRIM(STR(p_entidad))+" AND  R.idimpuret = "+ALLTRIM(STR(P_idimpuret)) +" and u.idestador != "+ALLTRIM(STR(v_estadoAnulado))+"   group BY p.entidad,r.idimpuret "
 
 
 
 
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
	
		DO WHILE NOT EOF()
			v_cod_socio = totpagosRet.entidad
			v_pagosmes  = totpagosRet.pagosmes
			INSERT INTO totpagos (entidad,pagosmes) VALUES (v_cod_socio,v_pagosmes)
			
			SELECT totpagosRet
			SKIP 1
		ENDDO 
		
	ENDIF 
*	USE IN totpagos0 

****
*** Busco en la tabla linkcompro los comprobantes de pagos a proveedores que no tengan asociadas retenciones ***
****

	sqlmatriz(1) = " SELECT p.entidad, SUM(p.importe) as pagosmes, r.idimpuret FROM pagosprov p left join linkcompro l on p.idcomproba = l.idcomprobaa and p.idpago = l.idregistroa "
	sqlmatriz(2) = "  left join retenciones r on l.idcomprobab = r.idcomproba and l.idregistrob = r.idreten left join ultimoestado u on p.idpago = u.id and u.campo = 'idpago' and u.tabla = 'pagosprov' "
	sqlmatriz(3) = "    WHERE p.fecha between "+v_desde+" and "+v_hasta+" and "
	sqlmatriz(4) = "    	     p.entidad = "+ALLTRIM(STR(p_entidad)) +" and u.idestador != " +ALLTRIM(STR(v_estadoAnulado))
	sqlmatriz(5) = "    group BY p.entidad having isnull(r.idimpuret) "			



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

*!*		SELECT totpagos
*!*		GO TOP 
*!*		IF EOF() AND RECNO()=1  THEN  && NO Encontró retenciones, busco en los recibos del proveedor
*!*			sqlmatriz(1) = " SELECT entidad, sum(importe) as pagosmes FROM pagosprov  "
*!*			sqlmatriz(2) = "    WHERE fecha between "+v_desde+" and "+v_hasta+" and "
*!*			sqlmatriz(3) = "    	     entidad = "+ALLTRIM(STR(p_entidad))
*!*			sqlmatriz(4) = "    group BY entidad ORDER BY entidad "			
*!*			verror=sqlrun(varconexionF,"totpagos0")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias (1)",0+16+0,"")
*!*			ENDIF 
*!*			ZAP IN totpagos
*!*			SELECT totpagos0
*!*			GO TOP 
*!*			DO WHILE NOT EOF()
*!*				IF ISNULL(totpagos0.pagosmes) THEN 
*!*					* No Grabo Nada
*!*				ELSE 
*!*					v_cod_socio = totpagos0.entidad
*!*					v_pagosmes  = totpagos0.pagosmes
*!*					INSERT INTO totpagos (entidad,pagosmes) VALUES (p_entidad,v_pagosmes)
*!*				ENDIF 
*!*				
*!*				SELECT totpagos0
*!*				SKIP 1
*!*			ENDDO  
*!*			USE IN totpagos0
*!*			
*!*			SELECT totpagos 
*!*			GO TOP 
*!*			replace pagosmes WITH pagosmes/1.21 
*!*		ELSE		
*!*			IF ISNULL(totpagos.pagosmes) THEN && NO Encontró retenciones, busco en los recibos del proveedor
*!*				sqlmatriz(1) = " SELECT entidad, sum(importe) as pagosmes FROM pagosprov  "
*!*				sqlmatriz(2) = "    WHERE fecha between "+v_desde+" and "+v_hasta+" and "
*!*				sqlmatriz(3) = "    	     entidad = "+ALLTRIM(STR(P_entidad))
*!*				sqlmatriz(4) = "    group BY entidad ORDER BY entidad "			
*!*				verror=sqlrun(varconexionF,"totpagos0")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias (1)",0+16+0,"")
*!*				ENDIF 
*!*				ZAP IN totpagos
*!*				SELECT totpagos0
*!*				GO TOP 
*!*				DO WHILE NOT EOF()
*!*					IF ISNULL(totpagos0.pagosmes) THEN 
*!*						* No Grabo Nada
*!*					ELSE 
*!*						v_cod_socio = totpagos0.cod_socio
*!*						v_pagosmes  = totpagos0.pagosmes
*!*						INSERT INTO totpagos (entidad,pagosmes) VALUES (P_entidad,v_pagosmes)
*!*					ENDIF 
*!*					
*!*					SELECT totpagos0
*!*					SKIP 1
*!*				ENDDO  
*!*				USE IN totpagos0
*!*				
*!*				SELECT totpagos 
*!*				GO TOP 
*!*				replace pagosmes WITH pagosmes/1.21
*!*			ELSE
*!*				*
*!*			ENDIF 
*!*			
*!*		ENDIF 





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

		sqlmatriz(1) = "SELECT i.idimpuret, i.detalle, i.baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon  "
		sqlmatriz(2) = "  FROM impuretencion i left join  afipescalas a on i.razonin = a.codigo "
		sqlmatriz(3) = "  where i.idimpuret   = "+ALLTRIM(STR(p_idimpuret))	

	ELSE && Si no está en convenio busco en las escalas según el campo razonnin de la tabla impuretencion

		sqlmatriz(1) = " SELECT i.idimpuret, i.detalle, i.baseimpon,i.idtipopago, i.funcion, a.idafipesc, a.codigo,a.descrip as descescala, a.valmin, a.valmax, a.valfijo,a.razon  "
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
*!*		sqlmatriz(1) = " SELECT R.entidad, sum(R.importe) as retenmes FROM retenciones  R  "
*!*		sqlmatriz(2) = " left join linkcompro L on R.idcomproba = L.idcomprobaa and R.idreten = L.idregistroa "
*!*		sqlmatriz(3) = "    left join pagosprov P on L.idcomprobab = P.idcomproba and L.idregistrob = P.idpago  "
*!*		sqlmatriz(4) = " left join ultimoestado u on p.idpago = u.id and u.campo = 'idpago' and u.tabla = 'pagosprov'"
*!*		sqlmatriz(5) = "    WHERE P.fecha between "+v_desde+" and "+v_hasta+" and "
*!*		sqlmatriz(6) = "    	     R.entidad = "+ALLTRIM(STR(P_entidad))+ " and "
*!*		sqlmatriz(7) = "    	     R.idimpuret   = "+ALLTRIM(STR(p_idimpuret)) +" and u.idestador != " +ALLTRIM(STR(v_estadoAnulado))
*!*		sqlmatriz(8) = "     group BY R.entidad ORDER BY R.entidad"	
*!*		verror=sqlrun(varconexionF,"totreten0")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(5)",0+16+0,"")
*!*		    RETURN .F.
*!*		ENDIF 
	
	SELECT entidad, impret as retenmes FROM totpagosRet WHERE idimpuret = p_idimpuret INTO TABLE totreten0
	
	
	
	ZAP IN totreten
	SELECT totreten0
	GO TOP 
	DO WHILE NOT EOF()
		IF ISNULL(totreten0.retenmes) THEN 
			* No grabo Nada

			v_retenmes = 0.00
			INSERT INTO totreten (entidad, retenmes) VALUES (p_entidad,v_retenmes)
		ELSE 

			v_retenmes   = totreten0.retenmes 
			INSERT INTO totreten (entidad ,retenmes) VALUES (p_entidad,v_retenmes)
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
*				MESSAGEBOX(v_valmin)
				v_retener = v_aretener - v_valmin
*				MESSAGEBOX(v_retener)
				v_razon = retenciongan.razon
*				MESSAGEBOX(v_razon )
				v_valfijo = retenciongan.valfijo
*				MESSAGEBOX(v_valfijo )			
			
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
				
				SELECT impureten 
				
				v_idtipopago = impureten.idtipopago
				v_descrip = ALLTRIM(impureten.detalle)+ " - " + ALLTRIM(impureten.descescala)
		
				INSERT INTO &p_nombretabRes (entidad, idimpuret,impTotal,impARet,baseimpo,razon,idtipopago,descrip,totpagomes,totretmes,sujarete) VALUES (v_entidad, v_idimpuret,v_impTotal,v_impARet,v_baseImponible,v_razon,v_idtipopago,v_descrip,v_totpagomes,v_totretmes,v_aretener)

			
			
			ELSE && No tengo que retener			
			
			ENDIF 
			
			
			
			
*!*				
*!*			
*!*			v_razonnum = VAL(v_razon)
*!*			v_usaEscala = .F.
*!*			
*!*			IF v_razonnum > 0 
*!*				&& EL VALOR Es numerico
*!*				v_razonAplicar  = v_razonnum
*!*				v_usaEscala = .F.
*!*				v_valorFijoASumar = 0.00
*!*			ELSE
*!*				v_tipoRazon = TYPE('v_razon')
*!*				IF v_tipoRazon = 'C'
*!*				
*!*					&& La razón es caracter -> Es el código de la tabla de afipescalas
*!*					v_usaEscala = .T.
*!*					
*!*					sqlmatriz(1) = " SELECT * "
*!*					sqlmatriz(2) = " FROM afipescalas "
*!*					sqlmatriz(3) = " WHERE codigo = '"+alltrim(v_razon)+"' and ("+ALLTRIM(STR(p_importe,13,2))+" >= valmin  and "+ALLTRIM(STR(p_importe,13,2))+" <= valmax) "
*!*					sqlmatriz(4) = " or ("+ALLTRIM(STR(p_importe,13,2))+">= valmin and valmax = -1) "
*!*					verror=sqlrun(varconexionF,"escalagan")
*!*					IF verror=.f.  
*!*						MESSAGEBOX("Ha Ocurrido un Error en el cálculo de ganancias(5)",0+16+0,"")
*!*						RETURN .F.
*!*					ENDIF 
*!*					
*!*					SELECT escalagan
*!*					IF NOT EOF()
*!*						
*!*						v_razonAplicar = escalagan.razon
*!*						v_valorFijoASumar = escalagan.valfijo
*!*					ELSE
*!*						&& No se puede establecer la razón 
*!*						RETURN -1
*!*					ENDIF 
*!*					
*!*					
*!*				ELSE
*!*					&& No se puede establecer la razón 
*!*					RETURN -1
*!*				ENDIF 
*!*			
*!*			ENDIF 
*!*		
	
	ELSE
	
	
	ENDIF 
			
	USE IN totreten0
	USE IN totreten
	USE IN totpagos
	
*!*		
*!*		
*!*		
*!*		SELECT totreten 
*!*		GO TOP 
*!*		
*!*		
*!*		
*!*		IF v_razonAplicar > 0
*!*		
*!*			SELECT impureten
*!*			 v_minimpon = impureten.baseimpon
*!*		 
*!*	*!*			SELECT tmpretencion
*!*	*!*			replace alicuota WITH v_razonAplicar 
*!*	*!*			
*!*			SELECT SUM(pagosmes) as tpagos FROM totpagos TO v_totpagosmes
*!*			dife = ROUND(((v_totpagosmes + p_importe) - v_minimpon ),2)
*!*			
*!*	*		dife = ROUND(((totpagos.pagosmes + p_importe/1.21) - v_minimpon ),2)
*!*			*replace concepto WITH "ENAJENACION BIEN DE CAMBIO Y MUEBLES"

*!*			v_importeARetener = 0.00


*!*			DO CASE 
*!*				CASE dife<= 0
*!*					v_importeARetener = 0.00
*!*					v_totpagosmes = ROUND((totpagos.pagosmes + (p_importe)),2)
*!*					v_totRetenmes =  totreten.retenmes
*!*					
*!*					
*!*					*alltriM(p_nombreTabRes)+" FREE (idimpuret I,impTotal Y,importeARetener Y,totpagosmes Y,totRetenmes Y)"
*!*					
*!*				CASE dife > 0
*!*					v_totpagosmes = round((totpagos.pagosmes + (p_importe)),2)
*!*					IF dife >= (p_importe) THEN 
*!*						
*!*	*!*						IF v_usaEscala = .T.
*!*	*!*							SELECT escalagan
*!*	*!*							IF NOT EOF()
*!*	*!*													
*!*	*!*								v_importeARetener = ROUND(((((totpagos.pagosmes+ p_importe)-v_minimpon) * v_razonAplicar/100)+v_valorFijoASumar-totreten.retenmes),2)
*!*	*!*							ENDIF 
*!*	*!*						ELSE
*!*	*!*								v_importeARetener = ROUND(((((totpagos.pagosmes+ p_importe)-v_minimpon) * v_razonAplicar/100)-totreten.retenmes),2)
*!*	*!*						ENDIF 
*!*						v_importeARetener = ROUND(((((totpagos.pagosmes+ p_importe)-v_minimpon) * v_razonAplicar/100)+v_valorFijoASumar-totreten.retenmes),2)
*!*						
*!*						*v_importeARetener = ROUND(((((totpagos.pagosmes+ p_importe)-tmpretencion.minimpon) * v_razonAplicar/100)-totreten.retenmes),2)
*!*						v_sujetoARetencion = ROUND((importe/(v_razonAplicar/100)),2)
*!*					ELSE
*!*					
*!*					
*!*	*!*						IF v_usaEscala = .T.
*!*	*!*							SELECT escalagan
*!*	*!*							IF NOT EOF()
*!*	*!*													
*!*	*!*								v_importeARetener = ROUND((((totpagos.pagosmes+ p_importe) - tmpretencion.minimpon)*razon/100)+v_valorFijoASumar,2)
*!*	*!*							ENDIF 
*!*	*!*						ELSE
*!*	*!*							v_importeARetener = ROUND(((((totpagos.pagosmes+ p_importe)-v_minimpon) * v_razonAplicar/100)-totreten.retenmes),2)
*!*	*!*						ENDIF 
*!*						
*!*						v_importeARetener = ROUND((((totpagos.pagosmes+ p_importe) - tmpretencion.minimpon)*razon/100)+v_valorFijoASumar,2)
*!*						
*!*					*	replace importe WITH ROUND((((totpagos.pagosmes+ p_importe) - tmpretencion.minimpon)*razon/100),2)
*!*						v_sujetoARetencion = ROUND((((totpagos.pagosmes+ p_importe) - v_minimpon)),2)
*!*					ENDIF 
*!*					v_totRetenmes = ROUND((totreten.retenmes + importe),2)
*!*				OTHERWISE 
*!*				RETURN .F.
*!*			ENDCASE 
*!*			
*!*			
*!*			
*!*			
*!*			
*!*			INSERT INTO &p_nombreTabRes VALUES (P_idimpuret,P_importe,v_importeARetener,v_totpagosmes,v_totRetenmes)
*!*			
*!*			
*!*			
*!*			
*!*	*!*			DO CASE 
*!*	*!*				CASE dife<= 0
*!*	*!*					replace importe WITH 0
*!*	*!*					replace pagosmes WITH ROUND((totpagos.pagosmes + (p_importe/1.21)),2)
*!*	*!*					replace retenmes WITH totreten.retenmes
*!*	*!*				CASE dife > 0
*!*	*!*					replace pagosmes WITH round((totpagos.pagosmes + (p_importe/1.21)),2)
*!*	*!*					IF dife >= (p_importe/1.21) THEN 
*!*	*!*						replace importe WITH ROUND(((((totpagos.pagosmes+ p_importe/1.21)-tmpretencion.minimpon) * razon/100)-totreten.retenmes),2)
*!*	*!*						replace sujarete WITH ROUND((importe/(razon/100)),2)
*!*	*!*					ELSE
*!*	*!*						replace importe WITH ROUND((((totpagos.pagosmes+ p_importe /1.21) - tmpretencion.minimpon)*razon/100),2)
*!*	*!*						replace sujarete WITH ROUND((((totpagos.pagosmes+ p_importe /1.21) - tmpretencion.minimpon)),2)
*!*	*!*					ENDIF 
*!*	*!*					replace retenmes WITH ROUND((totreten.retenmes + importe),2)
*!*	*!*				OTHERWISE 
*!*	*!*			ENDCASE 
*!*			
*!*			USE IN totreten
*!*			USE IN totpagos
*!*		
*!*		ELSE
*!*		
*!*		
*!*		
*!*		
*!*		ENDIF 
*!*		
	
	
	* cierro la conexion
	= abreycierracon(varconexionF,"")


	RETURN .T.
	

ENDFUNC 


************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
FUNCTION PercepIB
PARAMETERS P_sucursal,P_Cliente, P_fecha, p_impuesto, P_subtotal, P_iva, P_tipo, P_compro
	r_percep = 0
	IF p_compro='F' OR p_compro='D' then
		pp_compro = 1
	ELSE 
		pp_compro = -1
	ENDIF 
 
*!*		P_subtotal = P_subtotal * pp_compro
*!*		P_iva      = P_iva * pp_compro
	
	*MESSAGEBOX("Subtotal: "+ALLTRIM(STR(P_subtotal,18,2))+"   IVA: "+ALLTRIM(STR(P_iva,18,2)) )
	
	CREATE TABLE .\temp\totfact FREE (sucursal c(4), cod_socio i, factdiario y)
	CREATE TABLE .\temp\totperc FREE (sucursal c(4), cod_socio i, percdiario y)
		
	* Abro una conexion con la base de datos Facturación
	varconexionF = abreycierracon(0,miservidor+"\Facturacion\Datos.dbc")

	* Busco lo Facturado en el Día.
	sqlmatriz(1) = " SELECT F.subtotal, F.i_iva_g, C.operacion as opera, C.tipo "
	sqlmatriz(2) = "    FROM facturas F "
	sqlmatriz(3) = "    LEFT JOIN Comprobantes C ON C.idcomp=F.idcomp "
	sqlmatriz(4) = "    WHERE F.fecha = '"+p_fecha+"' and F.succliente ='"+p_sucursal+"' and F.cod_socio = "+ALLTRIM(STR(p_cliente))
	sqlmatriz(5) = "    ORDER BY F.cod_socio"	
	verror=sqlrun(varconexionF,"totfact0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Facturas",0+16+0,"")
	ENDIF 
	ZAP IN totfact
	SELECT tipo, sum(subtotal*opera) as subtotal, sum(i_iva_g*opera) as iva from totfact0 ;
	    where opera > 0 GROUP BY tipo ORDER BY tipo INTO CURSOR totfact1
	USE IN totfact0
	
	SELECT totfact1
	GO TOP 
	IF EOF() AND RECNO()=1 THEN 
		v_factdiario = 0
	ELSE 
		v_factdiario = totfact1.subtotal
	ENDIF 
	
	IF p_tipo = "A" THEN 
		v_factdiario = v_factdiario + P_subtotal
	ELSE
		v_factdiario = v_factdiario + totfact1.iva + P_subtotal + P_iva
	ENDIF 
	USE IN totfact1
	
	*MESSAGEBOX("TOTAL Facturado Diario: "+ALLTRIM(STR(v_factdiario,18,2)) )
	
	INSERT INTO totfact(sucursal,cod_socio,factdiario) VALUES(p_sucursal,p_cliente,v_factdiario)
	
	* Busco las Percepciones de ingresos brutos y a realizadas 
	sqlmatriz(1) = " SELECT sum(impperc) as impperc, sum(sujaperc) as sujaperc FROM impufactu "
	sqlmatriz(2) = "    WHERE fecha = '"+p_fecha+"' and sucursal ='"+p_sucursal+"' and cliente = "+ALLTRIM(STR(p_cliente))
	sqlmatriz(3) = "          and impperc > 0 "
	verror=sqlrun(varconexionF,"totperc0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Percepciones de IB",0+16+0,"")
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
	
	*MESSAGEBOX("TOTAL Percepciones Diaria: "+ALLTRIM(STR(v_percdiario,18,2))+" Sujeto a Percep.: "+ALLTRIM(STR(s_sujaperc,18,2)) )
	
	INSERT INTO totperc (sucursal,cod_socio,percdiario) VALUES (p_sucursal,p_cliente,v_percdiario)
	USE IN totperc0
	
	* Buscar datos del impuesto
	sqlmatriz(1) = " SELECT * FROM percepciones "
	sqlmatriz(2) = "    WHERE pcodigo = "+ALLTRIM(STR(p_impuesto))
	verror=sqlrun(varconexionF,"datperc")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BUSQUEDA de Percepciones de IB",0+16+0,"")
	ENDIF 
	SELECT datperc
	GO TOP 
	v_razon      = datperc.razon
	v_pnombre    = datperc.pnombre
	v_orden      = datperc.orden
	
	* Calculo el importe del impuesto
	IF (v_factdiario - datperc.minimpon) => 0 THEN 
		r_percep = ( v_factdiario * (v_razon /100) ) - v_percdiario
		IF r_percep < 0 THEN 
			r_percep = 0
		ENDIF 
	ELSE
		r_percep = 0
	ENDIF 
	
	*MESSAGEBOX("Impuesto Calculado: "+ALLTRIM(STR(r_percep*pp_compro,18,2)) )
	
	* Cierro Archivos
	*USE IN clie
	
	* cierro la conexion
	= abreycierracon(varconexionF,"")
*!*		= abreycierracon(varconexionM,"")
	
	g_idregistro = 0 
	g_fecha      = p_fecha
	g_sucursal   = p_sucursal
	g_cliente    = p_cliente
	g_pcodigo    = p_impuesto
	g_pnombre    = v_pnombre
	g_orden      = v_orden
    g_convenio   = cliepercep.convenio
    g_nroinscrip = cliepercep.nroinscrip
    g_porcen     = v_razon
    g_totaldia   = v_factdiario
    g_percepdia  = v_percdiario + r_percep
	g_sujaperc   = v_factdiario - s_sujaperc
    g_impperc    = r_percep

	SELECT impufactu 
	DELETE for pcodigo = g_pcodigo
	
	INSERT INTO impufactu (idregistro,fecha,sucursal,cliente,pcodigo,pnombre,orden,;
	                       convenio,nroinscrip,porcen,totaldia,percepdia,sujaperc,impperc) ;
       VALUES (g_idregistro,g_fecha,g_sucursal,g_cliente,g_pcodigo,g_pnombre,g_orden,;
               g_convenio,g_nroinscrip,g_porcen,g_totaldia,g_percepdia,g_sujaperc,g_impperc)
	
	RETURN  r_percep
ENDFUNC 


************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
FUNCTION PercepIBnc
PARAMETERS P_sucursal,P_Cliente, P_fecha, p_impuesto, P_subtotal, P_iva, P_tipo, p_percep
	r_percep = 0
	
	CREATE TABLE .\temp\totfact FREE (sucursal c(4), cod_socio i, factdiario y)
	CREATE TABLE .\temp\totperc FREE (sucursal c(4), cod_socio i, percdiario y)
		
	* Abro una conexion con la base de datos Facturación
	varconexionF = abreycierracon(0,miservidor+"\Facturacion\Datos.dbc")

	* Busco lo Facturado en el Día.
	sqlmatriz(1) = " SELECT F.subtotal, F.i_iva_g, C.operacion as opera, C.tipo "
	sqlmatriz(2) = "    FROM facturas F "
	sqlmatriz(3) = "    LEFT JOIN Comprobantes C ON C.idcomp=F.idcomp "
	sqlmatriz(4) = "    WHERE F.fecha = '"+p_fecha+"' and F.succliente ='"+p_sucursal+"' and F.cod_socio = "+ALLTRIM(STR(p_cliente))
	sqlmatriz(5) = "    ORDER BY F.cod_socio"	
	verror=sqlrun(varconexionF,"totfact0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Facturas",0+16+0,"")
	ENDIF 
	ZAP IN totfact
	SELECT tipo, sum(subtotal*opera) as subtotal, sum(i_iva_g*opera) as iva from totfact0 ;
	    WHERE opera > 0 GROUP BY tipo ORDER BY tipo INTO CURSOR totfact1
	USE IN totfact0
	
	SELECT totfact1
	GO TOP 
	IF EOF() AND RECNO()=1 THEN 
		v_factdiario = 0
	ELSE 
		v_factdiario = totfact1.subtotal
	ENDIF 
	
	IF p_tipo = "A" THEN 
		v_factdiario = v_factdiario + (P_subtotal * (-1)) && Por se NC
	ELSE
		v_factdiario = v_factdiario + totfact1.iva + (P_subtotal * (-1)) + (P_iva * (-1)) && por se NC
	ENDIF 
	USE IN totfact1
	
	INSERT INTO totfact(sucursal,cod_socio,factdiario) VALUES(p_sucursal,p_cliente,v_factdiario)
	
	* Busco las Percepciones de ingresos brutos y a realizadas 
	sqlmatriz(1) = " SELECT sum(impperc) as impperc, sum(sujaperc) as sujaperc FROM impufactu "
	sqlmatriz(2) = "    WHERE fecha = '"+p_fecha+"' and sucursal ='"+p_sucursal+"' and cliente = "+ALLTRIM(STR(p_cliente))
	sqlmatriz(3) = "          and sujaperc > 0 "
	verror=sqlrun(varconexionF,"totperc0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Percepciones de IB",0+16+0,"")
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
	INSERT INTO totperc (sucursal,cod_socio,percdiario) VALUES (p_sucursal,p_cliente,v_percdiario)
	USE IN totperc0
	
	* Buscar datos del impuesto
	sqlmatriz(1) = " SELECT * FROM percepciones "
	sqlmatriz(2) = "    WHERE pcodigo = "+ALLTRIM(STR(p_impuesto))
	verror=sqlrun(varconexionF,"datperc")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BUSQUEDA de Percepciones de IB",0+16+0,"")
	ENDIF 
	SELECT datperc
	GO TOP 
	v_razon      = datperc.razon
	v_pnombre    = datperc.pnombre
	v_orden      = datperc.orden
	
	r_percep     = p_percep * (-1) && Por Ser NC

	IF p_tipo = "A" THEN 
		g_sujaperc = (P_subtotal * (-1)) && Por se NC
	ELSE
		g_sujaperc = (P_subtotal * (-1)) + (P_iva * (-1)) && por se NC
	ENDIF 

	* cierro la conexion
	= abreycierracon(varconexionF,"")
*!*		= abreycierracon(varconexionM,"")
	
	g_idregistro = 0 
	g_fecha      = p_fecha
	g_sucursal   = p_sucursal
	g_cliente    = p_cliente
	g_pcodigo    = p_impuesto
	g_pnombre    = v_pnombre
	g_orden      = v_orden
    g_convenio   = cliepercep.convenio
    g_nroinscrip = cliepercep.nroinscrip
    g_porcen     = v_razon
    g_totaldia   = g_sujaperc
    g_percepdia  = r_percep && v_percdiario + r_percep
	*g_sujaperc   = v_factdiario - s_sujaperc
    g_impperc    = r_percep

	SELECT impufactu 
	DELETE for pcodigo = g_pcodigo
	
	INSERT INTO impufactu (idregistro,fecha,sucursal,cliente,pcodigo,pnombre,orden,;
	                       convenio,nroinscrip,porcen,totaldia,percepdia,sujaperc,impperc) ;
       VALUES (g_idregistro,g_fecha,g_sucursal,g_cliente,g_pcodigo,g_pnombre,g_orden,;
               g_convenio,g_nroinscrip,g_porcen,g_totaldia,g_percepdia,g_sujaperc,g_impperc)
	
	RETURN  r_percep
ENDFUNC 
