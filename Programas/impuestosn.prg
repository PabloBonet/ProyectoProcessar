

FUNCTION Ganancias
PARAMETERS P_importe, P_fecha

	CREATE TABLE .\temp\totpagos FREE (cod_socio i, pagosmes y)
	CREATE TABLE .\temp\totreten FREE (cod_socio i, retenmes y)
		
	* Abro una conexion con la base de datos Facturación
	varconexionF = abreycierracon(0,miservidor+"\Facturacion\Datos.dbc")
		
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
	IF EMPTY(MIDRVMYSQL) THEN 	
		v_desde = "{^"+STRTRAN(STR(anio,4,0)," ","0")+"-"+STRTRAN(STR(mes,2,0)," ","0")+"-"+diaini+"}"
		v_hasta = "{^"+STRTRAN(STR(anio,4,0)," ","0")+"-"+STRTRAN(STR(mes,2,0)," ","0")+"-"+diafin+"}"
	ELSE
		v_desde = "'"+STRTRAN(STR(anio,4,0)," ","0")+"-"+STRTRAN(STR(mes,2,0)," ","0")+"-"+diaini+"'"
		v_hasta = "'"+STRTRAN(STR(anio,4,0)," ","0")+"-"+STRTRAN(STR(mes,2,0)," ","0")+"-"+diafin+"'"
	ENDIF 
	sqlmatriz(1) = " SELECT R.cod_socio, max(R.pagosmes) as pagosmes FROM reciretencion  R "
	sqlmatriz(2) = "    left join recibosprov P on R.idrecibo = P.idrecibo "
	sqlmatriz(3) = "    WHERE P.fecha between "+v_desde+" and "+v_hasta+" and "
	sqlmatriz(4) = "    	  R.cod_socio = "+ALLTRIM(STR(tmpretencion.cod_socio))+" AND "
	sqlmatriz(5) = "          R.icodigo = "+ALLTRIM(STR(tmpretencion.icodigo))
	sqlmatriz(6) = "     group BY R.cod_socio ORDER BY R.cod_socio"	
	verror=sqlrun(varconexionF,"totpagos0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Impuestos (0)",0+16+0,"")
	ENDIF 
	ZAP IN totpagos
	SELECT totpagos0
	GO TOP 
	DO WHILE NOT EOF()
		v_cod_socio = totpagos0.cod_socio
		v_pagosmes  = totpagos0.pagosmes
		INSERT INTO totpagos (cod_socio,pagosmes) VALUES (v_cod_socio,v_pagosmes)
		
		SELECT totpagos0
		SKIP 1
	ENDDO 
	USE IN totpagos0 


	SELECT totpagos
	GO TOP 
	IF EOF() AND RECNO()=1  THEN  && NO Encontró retenciones, busco en los recibos del proveedor
		sqlmatriz(1) = " SELECT cod_socio, sum(importe) as pagosmes FROM recibosprov  "
		sqlmatriz(2) = "    WHERE fecha between "+v_desde+" and "+v_hasta+" and "
		sqlmatriz(3) = "    	     cod_socio = "+ALLTRIM(STR(tmpretencion.cod_socio))
		sqlmatriz(4) = "    group BY cod_socio ORDER BY cod_socio "			
		verror=sqlrun(varconexionF,"totpagos0")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Impuestos (1)",0+16+0,"")
		ENDIF 
		ZAP IN totpagos
		SELECT totpagos0
		GO TOP 
		DO WHILE NOT EOF()
			IF ISNULL(totpagos0.pagosmes) THEN 
				* No Grabo Nada
			ELSE 
				v_cod_socio = totpagos0.cod_socio
				v_pagosmes  = totpagos0.pagosmes
				INSERT INTO totpagos (cod_socio,pagosmes) VALUES (v_cod_socio,v_pagosmes)
			ENDIF 
			
			SELECT totpagos0
			SKIP 1
		ENDDO  
		USE IN totpagos0
		
		SELECT totpagos 
		GO TOP 
		replace pagosmes WITH pagosmes/1.21 
	ELSE		
		IF ISNULL(totpagos.pagosmes) THEN && NO Encontró retenciones, busco en los recibos del proveedor
			sqlmatriz(1) = " SELECT cod_socio, sum(importe) as pagosmes FROM recibosprov  "
			sqlmatriz(2) = "    WHERE fecha between "+v_desde+" and "+v_hasta+" and "
			sqlmatriz(3) = "    	     cod_socio = "+ALLTRIM(STR(tmpretencion.cod_socio))
			sqlmatriz(4) = "    group BY cod_socio ORDER BY cod_socio "			
			verror=sqlrun(varconexionF,"totpagos0")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Impuestos (1)",0+16+0,"")
			ENDIF 
			ZAP IN totpagos
			SELECT totpagos0
			GO TOP 
			DO WHILE NOT EOF()
				IF ISNULL(totpagos0.pagosmes) THEN 
					* No Grabo Nada
				ELSE 
					v_cod_socio = totpagos0.cod_socio
					v_pagosmes  = totpagos0.pagosmes
					INSERT INTO totpagos (cod_socio,pagosmes) VALUES (v_cod_socio,v_pagosmes)
				ENDIF 
				
				SELECT totpagos0
				SKIP 1
			ENDDO  
			USE IN totpagos0
			
			SELECT totpagos 
			GO TOP 
			replace pagosmes WITH pagosmes/1.21
		ELSE
			*
		ENDIF 
		
	ENDIF 


	
*** Retenciones hechas en el mes
	sqlmatriz(1) = " SELECT R.cod_socio, sum(R.importe) as retenmes FROM reciretencion  R  "
	sqlmatriz(2) = "    left join recibosprov P on R.idrecibo = P.idrecibo "
	sqlmatriz(3) = "    WHERE P.fecha between "+v_desde+" and "+v_hasta+" and "
	sqlmatriz(4) = "    	     R.cod_socio = "+ALLTRIM(STR(tmpretencion.cod_socio))+ " and "
	sqlmatriz(5) = "    	     R.icodigo   = "+ALLTRIM(STR(tmpretencion.icodigo))
	sqlmatriz(6) = "     group BY R.cod_socio ORDER BY R.cod_socio"	
	verror=sqlrun(varconexionF,"totreten0")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la SELECCION de Impuestos (2)",0+16+0,"")
	ENDIF 
	ZAP IN totreten
	SELECT totreten0
	GO TOP 
	DO WHILE NOT EOF()
		IF ISNULL(totreten0.retenmes ) THEN 
			* No grabo Nada
		ELSE 
			v_cod_socio = totreten0.cod_socio
			v_retenmes   = totreten0.retenmes 
			INSERT INTO totreten (cod_socio,retenmes) VALUES (v_cod_socio,v_retenmes)
		ENDIF 		
		SELECT totreten0
		SKIP 1
	ENDDO  
	USE IN totreten0
	SELECT totreten 
	GO TOP 
	
	SELECT tmpretencion
	replace alicuota WITH razon
	
	dife = ROUND(((totpagos.pagosmes + p_importe/1.21) - minimpon),2)
	replace concepto WITH "ENAJENACION BIEN DE CAMBIO Y MUEBLES"

	DO CASE 
		CASE dife<= 0
			replace importe WITH 0
			replace pagosmes WITH ROUND((totpagos.pagosmes + (p_importe/1.21)),2)
			replace retenmes WITH totreten.retenmes
		CASE dife > 0
			replace pagosmes WITH round((totpagos.pagosmes + (p_importe/1.21)),2)
			IF dife >= (p_importe/1.21) THEN 
				replace importe WITH ROUND(((((totpagos.pagosmes+ p_importe/1.21)-tmpretencion.minimpon) * razon/100)-totreten.retenmes),2)
				replace sujarete WITH ROUND((importe/(razon/100)),2)
			ELSE
				replace importe WITH ROUND((((totpagos.pagosmes+ p_importe /1.21) - tmpretencion.minimpon)*razon/100),2)
				replace sujarete WITH ROUND((((totpagos.pagosmes+ p_importe /1.21) - tmpretencion.minimpon)),2)
			ENDIF 
			replace retenmes WITH ROUND((totreten.retenmes + importe),2)
		OTHERWISE 
	ENDCASE 
	
	USE IN totreten
	USE IN totpagos
	
	* cierro la conexion
	= abreycierracon(varconexionF,"")

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
