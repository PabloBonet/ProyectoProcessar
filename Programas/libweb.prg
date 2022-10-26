** LIBRARIA DE FUNCIONES PARA MANEJO DE DATOS CON MODULO WEB 

*----------------------------------------------------------------
** Carga en la tabla webccclientes (tabla que contiene el calculo de cuentas corrientes de clientes)
** las cuentas corrientes de clientes en el periodo recibido como parámetro y para los clientes
** que tambien se reciben como parametros en un archivo de texto
** Esto es para dejar lista la cuenta corriente para ser accedidas desde la web y mostradas a los clientes
*----------------------------------------------------------------

FUNCTION WebCClientes  && COMIENZO FUNCION DE CARGA DE CUENTAS CORRIENTES PARA LA WEB
	PARAMETERS pw_fechad, pw_fechah, pw_clientes

	IF EMPTY(pw_clientes) THEN 
		RETURN .t.
	ENDIF 
	CREATE TABLE tmpclientesw FREE (entidad i)
	SELECT tmpclientesw
	APPEND FROM &pw_clientes DELIMITED WITH ""
	GO TOP
	DELETE FOR entidad = 0
	PACK 

	vtmp = frandom()
	vwebctacte 	  = 'webctacte'+vtmp
	CREATE TABLE &vwebctacte free(idregistro I, idcomproba I, tipo C(1), pventa I,puntov C(4), fecha C(8), compro c(100), numero I, debe Y, ;
	                                 haber Y, saldo Y, imp_total Y, opera I, saldocomp Y, subtotal Y, recargo Y, ;
	                                 entidad I, servicio I, cuenta I, nombre C(254), cuit C(13),idtipocomp I, electro C(1),nomservi c(50), clasifica c(40), tabla c(50))

	SELECT &vwebctacte
	GO TOP 
	INDEX on idregistro TAG idregistro
	INDEX on fecha TAG fecha


	vctactetmp 	  = 'ctactetmp'+vtmp
	CREATE TABLE &vctacteTmp free(idregistro I, idcomproba I, tipo C(1), pventa I,puntov C(4), fecha C(8), compro c(100), numero I, debe Y, ;
	                                 haber Y, saldo Y, imp_total Y, opera I, saldocomp Y, subtotal Y, recargo Y, ;
	                                 entidad I, servicio I, cuenta I, nombre C(254), cuit C(13),idtipocomp I, electro C(1),nomservi c(50), clasifica c(40), tabla c(50))

	SELECT &vctacteTmp
	GO TOP 
	INDEX on idregistro TAG idregistro
	INDEX on fecha TAG fecha


	estadosObj		= CREATEOBJECT('estadosclass')
	v_idEstadoAnul	= estadosObj.getidestado("ANULADO")

	vconeccionF=abreycierracon(0,_SYSSCHEMA)

	SELECT tmpclientesw
	GO TOP 
	

	DO WHILE !EOF() 
		
****************************---------------------------------------
		v_entidad	= tmpclientesw.entidad
		_SQLENTIDAD = v_entidad


		v_condicion0 = "  and (c.fecha >= '" + ALLTRIM(pw_fechad)+ " ') "
		v_condicion1 = " c.entidad = " + ALLTRIM(STR(v_entidad))
		v_condicion = " WHERE " + v_condicion1 + v_condicion0 

		SELECT &vctactetmp
		GO top
		ZAP IN &vctactetmp 

		v_cond	= v_condicion
		*** Busco comprobantes de la tabla facturas ***
		
		*-FACTURAS -*

			sqlmatriz(1)=" Select c.*,cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp, tc.opera, pv.puntov, pv.electronica, pv.pventa, ifnull(fs.saldof,0) as saldof, u.idestador,er.nombre as nomEstado,  "
			sqlmatriz(2)=" ifnull(se.detalle,'        ') as nomservi, ifnull(cm.descrip,'        ') as clasifica from facturas c "
			sqlmatriz(3)=" left join comprobantes cc on c.idcomproba = cc.idcomproba "
			sqlmatriz(4)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
			sqlmatriz(5)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
			sqlmatriz(6)=" left join puntosventa pv on cp.pventa = pv.pventa "
			sqlmatriz(7)=" left join servicios se on c.servicio= se.servicio "
			sqlmatriz(8)=" left join clasificacomp cm on cm.idclascomp = c.idclascomp "
			sqlmatriz(9)=" left join r_facturasaldo fs on c.idfactura = fs.idfactura "
			sqlmatriz(10)=" left join ultimoestado u on c.idfactura = u.id left join estadosr er on u.idestador = er.idestadosr "
			sqlmatriz(11)=v_condicion + " and u.tabla = 'facturas' and u.campo = 'idfactura' and u.idestador <> "+ALLTRIM(STR(v_idEstadoAnul))
			sqlmatriz(12)=" order by fecha, numero "

			verror=sqlrun(vconeccionF,"facturas_sql_consultactacte")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Comprobantes ",0+48+0,"Error")
			ENDIF 

			SELECT facturas_sql_consultactacte

			GO TOP 
			
			DO WHILE NOT EOF()
				
				v_idregistro 	= facturas_sql_consultactacte.idfactura
				v_idcomproba	= facturas_sql_consultactacte.idcomproba
				v_tipo			= IIF(ISNULL(facturas_sql_consultactacte.tipocomp),'',facturas_sql_consultactacte.tipocomp)
				v_pventa		= facturas_sql_consultactacte.pventa
				v_puntov		= IIF(ISNULL(facturas_sql_consultactacte.puntov),'',facturas_sql_consultactacte.puntov)
				v_fecha			= facturas_sql_consultactacte.fecha
				v_nomComp		= IIF(ISNULL(facturas_sql_consultactacte.nomComp),'',facturas_sql_consultactacte.nomComp)
				v_numero		= facturas_sql_consultactacte.numero
				v_debe 			= 0
				v_haber			= 0
				v_clasifica 	= ALLTRIM(facturas_sql_consultactacte.clasifica)
				v_tablacta 		= "facturas"
				
				IF ALLTRIM(facturas_sql_consultactacte.ctacte) = 'S'
					** Tengo en cuenta el comprobante para la Cta Cte del cliente ***
					
					v_monto			= facturas_sql_consultactacte.total * IIF(ISNULL(facturas_sql_consultactacte.opera),0,facturas_sql_consultactacte.opera)
					
					IF v_monto > 0
						v_debe			= facturas_sql_consultactacte.total
					ELSE
					
						IF v_monto < 0
							v_haber	= facturas_sql_consultactacte.total
						ENDIF 
					ENDIF 
					
				ELSE
					** NO Tengo en cuenta el comprobante para la Cta Cte del cliente ***
					v_debe		= 0
					v_haber		= 0
				ENDIF 
				
				v_saldo			= 0 && Se va a calcular después
				v_imp_total		= facturas_sql_consultactacte.total
				v_opera			= facturas_sql_consultactacte.opera
				v_saldoComp		= facturas_sql_consultactacte.saldof
				v_subtotal		= facturas_sql_consultactacte.subtotal
				v_recargo		= facturas_sql_consultactacte.recargo
				v_entidad		= facturas_sql_consultactacte.entidad
				v_servicio		= facturas_sql_consultactacte.servicio
				v_cuenta		= facturas_sql_consultactacte.cuenta
				v_nombre		= ALLTRIM(facturas_sql_consultactacte.apellido)+ " " + ALLTRIM(facturas_sql_consultactacte.nombre)
				v_cuit			= facturas_sql_consultactacte.cuit
						
				v_autorizado = ""
				v_anulado 	= ""
				v_fechaAnul = ""
				v_electro	= facturas_sql_consultactacte.electronica
				v_idtipocomp 	= facturas_sql_consultactacte.idtipocomp
				v_nomservi		= ALLTRIM(STR(v_entidad))+'.'+ALLTRIM(STR(v_servicio))+'.'+ALLTRIM(STR(v_cuenta))+' '+facturas_sql_consultactacte.nomservi

				INSERT INTO  &vctacteTmp (idregistro, idcomproba, tipo, pventa, puntov,fecha,compro, numero,debe, ;
							haber, saldo,imp_total, opera, saldocomp, subtotal, recargo, ;
							entidad, servicio, cuenta, nombre, cuit,idtipocomp, electro, nomservi, clasifica, tabla );
				VALUES (v_idregistro, v_idcomproba, v_tipo, v_pventa, v_puntov,v_fecha,v_nomComp,v_numero,v_debe, ;
							 v_haber, v_saldo, v_imp_total,v_opera,v_saldoComp,v_subtotal, v_recargo, ;
							 v_entidad, v_servicio, v_cuenta, v_nombre, v_cuit,v_idtipocomp,v_electro, v_nomservi, v_clasifica, v_tablacta)
				
				SELECT facturas_sql_consultactacte
				SKIP 1

			ENDDO 
			
			USE IN facturas_sql_consultactacte

*--*
		*** Busco comprobantes de la tabla recibos ***
		
		*-RECIBOS-* 

		sqlmatriz(1)="Select c.*,e.cuit, cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp,  tc.opera, pv.puntov, pv.electronica, pv.pventa, ifnull(rs.saldo,0) as saldor, ifnull(rs.totrecargo,0) as recargor "
		sqlmatriz(2)=" from recibos c"
		sqlmatriz(3)=" left join entidades e on c.entidad = e.entidad "
		sqlmatriz(4)=" left join comprobantes cc on c.idcomproba = cc.idcomproba "
		sqlmatriz(5)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
		sqlmatriz(6)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
		sqlmatriz(7)=" left join puntosventa pv on cp.pventa = pv.pventa "
		sqlmatriz(8)=" left join r_recibossaldo rs on c.idrecibo = rs.idrecibo "
		sqlmatriz(9)=v_condicion + " and c.idrecibo not in (select id from ultimoestado u where u.tabla = 'recibos' and u.campo = 'idrecibo' and u.idestador = "+ALLTRIM(STR(v_idEstadoAnul))+") "
		sqlmatriz(10)=" order by fecha, numero "
		verror=sqlrun(vconeccionF,"recibos_sql_consultactacte")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de recibos ",0+48+0,"Error")
		ENDIF 

		SELECT recibos_sql_consultactacte

		GO TOP 

		DO WHILE NOT EOF()
			
			v_idregistro 	= recibos_sql_consultactacte.idrecibo
			v_idcomproba	= recibos_sql_consultactacte.idcomproba
			v_tipo			= IIF(ISNULL(recibos_sql_consultactacte.tipocomp),'',recibos_sql_consultactacte.tipocomp)
			v_pventa		= recibos_sql_consultactacte.pventa
			v_puntov		= IIF(ISNULL(recibos_sql_consultactacte.puntov),'',recibos_sql_consultactacte.puntov)
			v_fecha			= recibos_sql_consultactacte.fecha
			v_nomComp		= IIF(ISNULL(recibos_sql_consultactacte.nomComp),'',recibos_sql_consultactacte.nomComp)
			v_numero		= recibos_sql_consultactacte.numero
			v_debe 			= 0
			v_haber			= 0
			v_clasifica		= ""
			IF ALLTRIM(recibos_sql_consultactacte.ctacte) = 'S'
				** Tengo en cuenta el comprobante para la Cta Cte del cliente ***
				
				v_monto	= recibos_sql_consultactacte.importe * IIF(ISNULL(recibos_sql_consultactacte.opera),0,recibos_sql_consultactacte.opera)
				
				IF v_monto > 0
					v_debe	= recibos_sql_consultactacte.importe 
				ELSE
				
					IF v_monto < 0
						v_haber	= recibos_sql_consultactacte.importe 
						v_monto	= recibos_sql_consultactacte.importe
					ENDIF 
				ENDIF 
				
			ELSE
				** NO Tengo en cuenta el comprobante para la Cta Cte del cliente ***
				v_debe		= 0
				v_haber		= 0
			ENDIF 
			
			v_saldo			= 0 && Se va a calcular después
			v_imp_total		= recibos_sql_consultactacte.importe 
			v_opera			= IIF(ISNULL(recibos_sql_consultactacte.opera),0,recibos_sql_consultactacte.opera)
			v_saldoComp		= recibos_sql_consultactacte.saldor
			v_subtotal		= recibos_sql_consultactacte.importe 
			v_recargo		= recibos_sql_consultactacte.recargor
			v_entidad		= recibos_sql_consultactacte.entidad
			v_servicio		= 0
			v_cuenta		= 0
			v_nombre		= ALLTRIM(recibos_sql_consultactacte.apellido)+ " " + ALLTRIM(recibos_sql_consultactacte.nombre)
			v_cuit			= recibos_sql_consultactacte.cuit
					
			v_autorizado = ""
			v_anulado 	= ""
			v_fechaAnul = ""
			v_electro	= recibos_sql_consultactacte.electronica
			v_idtipocomp	= recibos_sql_consultactacte.idtipocomp
			v_tablacta 		= "recibos"

			INSERT INTO  &vctacteTmp (idregistro, idcomproba, tipo, pventa, puntov,fecha,compro, numero,debe, ;
						haber, saldo,imp_total, opera, saldocomp, subtotal, recargo, ;
						entidad, servicio, cuenta, nombre, cuit,idtipocomp,electro,nomservi,clasifica, tabla);
			VALUES (v_idregistro, v_idcomproba, v_tipo, v_pventa, v_puntov,v_fecha,v_nomComp,v_numero,v_debe, ;
						 v_haber, v_saldo, v_imp_total,v_opera,v_saldoComp,v_subtotal, v_recargo, ;
						 v_entidad, v_servicio, v_cuenta, v_nombre, v_cuit,v_idtipocomp,v_electro,'          ','        ',v_tablacta)

			SELECT recibos_sql_consultactacte
			SKIP 1
		ENDDO 

		USE IN recibos_sql_consultactacte


**-----**
		*-CALCULO DEL SALDO DE LA CC -*
		*** Calculo el saldo de la cuenta corriente para la entidad

			sqlmatriz(1)="Select * FROM ctactesaldo1 WHERE entidad = " + ALLTRIM(STR(v_entidad))
			verror=sqlrun(vconeccionF,"ctactesaldo_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del saldo de la Cta Cte de la entidad seleccionada ",0+48+0,"Error")
			ENDIF 

*!*			* me desconecto	
*!*			=abreycierracon(vconeccionF,"")


		SELECT ctaCtesaldo_Sql
		GO TOP 
		v_saldoF	= ctactesaldo_sql.saldo

		v_totDebe 		= 0
		v_totHaber 		= 0
		v_saldoIncial 	= 0
		v_debe			= 0
		v_haber 		= 0

		SELECT &vctactetmp
		GO TOP 

		IF NOT EOF()
			SELECT SUM(debe) as totDebe, SUM(haber) as totHaber FROM &vctacteTmp INTO TABLE DHCtaCteT

			SELECT DHCtaCteT
			GO TOP 
			v_totDebe		= DHCtaCteT.totdebe 
			v_totHaber		= DHCtaCteT.tothaber 
			v_saldoInicial	= v_saldoF - v_totDebe + v_totHaber

			SELECT &vctactetmp
			GO TOP 


			v_debe 	= 0
			v_haber	= 0

			IF v_saldoInicial < 0

				v_haber = v_saldoInicial * -1

			ELSE

				v_debe 	= v_saldoInicial 
			ENDIF 

			INSERT INTO &vctactetmp VALUES (0,0, '',0,'','', 'SALDO ANTERIOR', 0, v_debe, v_haber, v_saldoInicial, 0,0, 0,0,0,v_entidad,0,0, v_nombre, v_cuit,0,'','','','')

			SELECT &vctacteTmp
			GO TOP 
			v_saldoAnt	= &vctaCteTmp..saldo && Saldo Inicial
			SKIP 1

			DO WHILE NOT EOF()
				
				v_idregistro	= &vctaCteTmp..idregistro
				v_idcomproba	= &VctaCtetmp..idcomproba
				v_pventa		= &vctactetmp..pventa
				v_debe			= &vctactetmp..debe
				v_haber			= &vctactetmp..haber
				
				v_saldoAct		= v_saldoAnt + v_debe - v_haber
				
				SELECT &Vctactetmp
				replace saldo WITH v_saldoAct
				
				v_saldoAnt	= v_saldoAct
				
				SELECT &vctacteTmp
				SKIP 1
			ENDDO 

		ELSE
			v_saldoInicial	= v_saldoF - v_totDebe + v_totHaber

			v_debe 	= 0
			v_haber	= 0

			IF v_saldoInicial < 0

				v_haber = v_saldoInicial * -1

			ELSE

				v_debe 	= v_saldoInicial 
			ENDIF 


			INSERT INTO &Vctactetmp VALUES (0,0, '',0,'','', 'SALDO ANTERIOR', 0, v_debe, v_haber, v_saldoInicial, 0,0, 0,0,0,v_entidad,0,0, v_nombre, v_cuit,0,'N','','','')
			SELECT &vctacteTmp
			GO TOP 
		ENDIF 

**------**

		SELECT &vctacteTmp
		DELETE FOR fecha > ALLTRIM(pw_fechah)
		PACK 
		
		SELECT &vctacteTmp
		GO TOP 
		SET ORDER TO fecha IN &vctacteTmp ASCENDING 

** -- INSERTO LA CUENTA CORRIENTE CALCULADA EN LA TABLA TEMPORARIA CON TODAS LAS CUENTAS CORRIENTES --- * 
		
		SELECT &vwebctacte 
		APPEND FROM .\&vctacteTmp

***************************----------------------------------------
		SELECT tmpclientesw
		SKIP 	
	ENDDO 
	USE IN &vctacteTmp
	
	vwebctactef ='webctactef'+vtmp 
	
	SELECT 0 AS idwebcc , tabla, idregistro , compro, fecha, SUBSTR((ALLTRIM(tipo)+' '+alltrim(puntov)+'-'+STRTRAN(STR(numero,8),' ','0')+SPACE(16)),1,16) as numero  , imp_total,  debe , ;
	       haber , saldo , opera , saldocomp , entidad , servicio , cuenta , nombre , cuit, IIF(idregistro > 0 ,ALLTRIM(ALLTRIM(tabla)+ALLTRIM(STR(idregistro))+SUBSTR((ALLTRIM(tipo)+alltrim(puntov)+'_'+STRTRAN(STR(numero,8),' ','0')+SPACE(16)),1,16)),' ') as urlpdf  ;
	       from &vwebctacte into table &vwebctactef ORDER BY entidad, fecha 
	
	USE IN &vwebctacte
	

	* Aqui inserto en la base de datos las cuentas corrientes calculadas antes*
	SELECT &vwebctactef
	GO TOP 

	p_archivocsv= STRTRAN(_sysestacion,'\','/')+"/"+vwebctactef+".csv"
	COPY TO &p_archivocsv DELIMITED WITH ";"
	USE IN &vwebctactef


	** Elimino la Tabla de C.C. para la Web
	
	sqlmatriz(1)="DROP TABLE IF EXISTS webcclientes "
	verror=sqlrun(vconeccionF,"webcclientes")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del saldo de la Cta Cte de la entidad seleccionada ",0+48+0,"Error")
	ENDIF 
		
	sqlmatriz(1)= " CREATE TABLE webcclientes ( idwebcc int(10) unsigned NOT NULL AUTO_INCREMENT, "
	sqlmatriz(2)=" tabla char(50) NOT NULL, idregistro int(10) unsigned NOT NULL ,  compro char(150) NOT NULL, "
	sqlmatriz(3)=" fecha char(8) NOT NULL, numero char(16) NOT NULL,  imp_total double(13,2) NOT NULL, "
	sqlmatriz(4)=" debe double(13,2) NOT NULL, haber double(13,2) NOT NULL,  saldo double(13,2) NOT NULL, "
	sqlmatriz(5)=" opera int(10) NOT NULL ,  saldocomp double(13,2) NOT NULL, entidad int(10) unsigned NOT NULL, "
	sqlmatriz(6)=" servicio int(10) NOT NULL , cuenta int(10) unsigned NOT NULL, nombre char(200) NOT NULL, cuit char(13) NOT NULL, urlpdf char(200) NOT NULL, "
	sqlmatriz(7)=" PRIMARY KEY (idwebcc)) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1"

	verror=sqlrun(vconeccionF,"webcclientes")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Creación de la tabla webcclientes ",0+48+0,"Error")
	ENDIF 

	sqlmatriz(1)=" LOAD DATA LOCAL INFILE '"+p_archivocsv+"'"
	sqlmatriz(2)=" INTO TABLE webcclientes fields terminated by ',' "
	sqlmatriz(3)=" ENCLOSED BY ';' "
	sqlmatriz(4)=" LINES TERMINATED BY '\r\n' "
*	sqlmatriz(5)=" IGNORE 1 ROWS "

	verror=sqlrun(vconeccionF,"loadlp")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Carga Cuentas Corrientes para la Web (LOAD DATA )",0+48+0,"Error")
	    RETURN 
	ENDIF


		* me desconecto	
	=abreycierracon(vconeccionF,"")

	******
	RETURN vwebctactef

ENDFUNC  && FIN DE LA FUNCION DE CARGA DE CUENTAS CORRIENTES PARA LA WEB

*----------------------------------------------------------------------
***********************************************************************