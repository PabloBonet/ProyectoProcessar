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


******************************************************************************
******************************************************************************
FUNCTION ExpoProductoWEB
*#/----------------------------------------
* Genera Archivos para Exportar Articulos a PlataformaWeb
* Parametros : p_listap01
*              p_listap02 
*              p_deposito  
*#/----------------------------------------

IF !(TYPE('_SYSPRODUCTOSWEB')='C') THEN 
	RETURN 
ENDIF 


nFilas = ALINES(ArrProductoWEB, _SYSPRODUCTOSWEB , ";")
IF nFilas = 0 THEN 
	RETURN "" 
ENDIF 
v_listaWEB01 		= ArrProductoWEB(1)
v_listaWEB02 		= ArrProductoWEB(2)
RELEASE ArrProductoWEB

=GetListasPrecios('listaspreweb')

eje=" SELECT a.*, IIF( isnull(b.pventatot) =  .f., b.pventatot,0.00)  as pventatot2 FROM listaspreweba a LEFT JOIN listaspreweba b ON ( ALLTRIM(a.articulo) == ALLTRIM(b.articulo) "
eje = eje +" AND b.idlista = "+v_listaWEB02+") INTO TABLE productos01 WHERE a.idlista = "+v_listaWEB01 
&eje

*!*	SELECT productos01
*!*	BROWSE 


vconeccionF=abreycierracon(0,_SYSSCHEMA)
	* Traigo las propiedades de los articulos 
sqlmatriz(1) =" SELECT r.idregic ,  d.propiedad, d.valor, ifnull(c.propiedad,'') as categoriaa, ifnull(c.valor,'') as valora, ifnull(w.propiedad,'') as categoriah, ifnull(w.valor,'') as valorh "
sqlmatriz(2) =" FROM reldatosextra r "
sqlmatriz(3) =" left join datosextra d on d.iddatosex = r.iddatosex "
sqlmatriz(4) =" left join ( SELECT x.idregic, z.propiedad, z.valor FROM processar.reldatosextra x left join processar.datosextra z on z.iddatosex = x.iddatosex) c on (c.idregic = r.idregic and c.propiedad = 'CATEGORIA-AMOBLARK' and c.valor <> ''  ) "
sqlmatriz(5) =" left join ( SELECT u.idregic, v.propiedad, v.valor FROM processar.reldatosextra u left join processar.datosextra v on v.iddatosex = u.iddatosex) w on (w.idregic = r.idregic and w.propiedad = 'CATEGORIA-HOGAR' and w.valor <> ''  ) "
sqlmatriz(6) =" where r.tabla = 'articulos' order by idregic, propiedad "
verror=sqlrun(vconeccionF,"datosextrasweb_sql")
IF verror=.f.  
    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de AsientosCompro ",0+48+0,"Error")
ENDIF 

=abreycierracon(vconeccionF,"")	

SELECT * FROM datosextrasweb_sql INTO TABLE datosextraweb

SELECT p.articulo, p.detalle as nombre, p.pventatot, p.pventatot2, p.razonimpu, p.stocktot, d.propiedad, d.valor ;
FROM datosextrasweb_sql d ;
LEFT JOIN productos01 p ON ALLTRIM(p.articulo) == ALLTRIM(d.idregic) ;
into table productos02 where ALLTRIM(d.categoriaa) == 'CATEGORIA-AMOBLARK' AND ISNULL(p.articulo) = .f. AND !EMPTY(ALLTRIM(d.valora))

*!*	SELECT productos02
*!*	BROWSE 

SELECT p.articulo, p.detalle as nombre, p.pventatot, p.pventatot2, p.razonimpu, p.stocktot, d.propiedad, d.valor ;
FROM datosextrasweb_sql d ;
LEFT JOIN productos01 p ON ALLTRIM(p.articulo) == ALLTRIM(d.idregic) ;
into table productos03 where ALLTRIM(d.categoriah) == 'CATEGORIA-HOGAR' AND ISNULL(p.articulo) = .f. AND !EMPTY(ALLTRIM(d.valorh))

*!*	SELECT productos03
*!*	BROWSE 

IF USED("productosweb") THEN 
	USE IN productosweb 
ENDIF 
CREATE TABLE productosweb (seccion C(50), sku c(100), nombre c(254), descrip c(254), cate1 c(150), cate2 c(150), cate3 c(150), peso n(8,2), altura n(8,2), longitud n(8,2), ancho n(8,2), ;
						   titulo1 c(150), valor1 c(254),titulo2 c(150), valor2 c(254),titulo3 c(150), valor3 c(254),titulo4 c(150), valor4 c(254), titulo5 c(150), valor5 c(250), ;
						   titulo6 c(150), valor6 c(254),titulo7 c(150), valor7 c(254),titulo8 c(150), valor8 c(254), iva n(5,2) )
SELECT productosweb
INDEX on ALLTRIM(sku)+ALLTRIM(seccion) TAG sku

IF USED("preciosweb") THEN 
	USE IN preciosweb 
ENDIF 
CREATE TABLE preciosweb (seccion c(50), sku c(100), preciovta n(10,2), preciotach n(10,2) )
SELECT preciosweb 
INDEX on ALLTRIM(sku)+ALLTRIM(seccion) TAG sku

IF USED("stockweb") THEN 
	USE IN stockweb 
ENDIF 
CREATE TABLE stockweb (seccion c(50), sku c(100), stock n(10,2) )
SELECT stockweb 
INDEX on ALLTRIM(sku)+ALLTRIM(seccion) TAG sku


** PRODUCTOS AMOBLARK **
FOR j = 2 TO 3 

	v_idx = 'productos0'+ALLTRIM(STR(j))
	v_empre = IIF(j = 2, 'AMOBLARK','HOGAR')
	
	SELECT &v_idx 
	GO TOP 

	=ViewBarProgress(0,RECCOUNT(),"Generando Archivo de Productos...")
	
	DO WHILE !EOF()
		
		SELECT productosweb
		IF !SEEK(ALLTRIM(&v_idx..articulo)+v_empre) THEN 
			APPEND BLANK 
			replace sku WITH ALLTRIM(&v_idx..articulo), nombre WITH &v_idx..nombre, iva WITH &v_idx..razonimpu, seccion WITH v_empre 
		ENDIF 
		SELECT preciosweb
		IF !SEEK(ALLTRIM(&v_idx..articulo)+v_empre ) THEN 
			APPEND BLANK 
			replace sku WITH ALLTRIM(&v_idx..articulo), preciovta WITH &v_idx..pventatot, preciotach WITH &v_idx..pventatot, seccion WITH v_empre 
		ENDIF 
		SELECT stockweb
		IF !SEEK(ALLTRIM(&v_idx..articulo)+v_empre ) THEN 
			APPEND BLANK 
			replace sku WITH ALLTRIM(&v_idx..articulo), stock WITH &v_idx..stocktot, seccion WITH v_empre 
		ENDIF 

		DO CASE 
			CASE ALLTRIM(&v_idx..propiedad)=='CATEGORIA-HOGAR' OR ALLTRIM(&v_idx..propiedad)=='CATEGORIA-AMOBLARK' 
				
				nvalor = ALLTRIM(&v_idx..valor)
				nFilas = ALINES(ArrCategoWEB, nvalor  , ",")
				IF nFilas >= 0 THEN 
					i = 1
					DO WHILE i <= nFilas AND i <=3
						IF !EMPTY(ALLTRIM(ArrCategoWEB(i))) THEN 
							eje = " UPDATE productosweb SET cate"+ALLTRIM(STR(i))+" = ALLTRIM(ArrCategoWEB(i)) WHERE ALLTRIM(sku) == ALLTRIM("+v_idx+".articulo)  AND ALLTRIM(seccion) == v_empre "
							&eje
						ENDIF 
						i = i+1
					ENDDO 
				ENDIF 
				RELEASE arrCategoWEB
			
			CASE ALLTRIM(&v_idx..propiedad)=='PESO EN KG'
				UPDATE productosweb SET peso = VAL(STRTRAN(&v_idx..valor,',','.')) WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
				
			CASE ALLTRIM(&v_idx..propiedad)=='ALTURA EN CM'
				UPDATE productosweb SET altura = VAL(STRTRAN(&v_idx..valor,',','.')) WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
				
			CASE ALLTRIM(&v_idx..propiedad)=='PROFUNDIDAD EN CM'
				UPDATE productosweb SET longitud = VAL(STRTRAN(&v_idx..valor,',','.')) WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			CASE ALLTRIM(&v_idx..propiedad)=='ANCHO EN CM'
				UPDATE productosweb SET ancho = VAL(STRTRAN(&v_idx..valor,',','.')) WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A1'
				UPDATE productosweb SET titulo1 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A2'
				UPDATE productosweb SET titulo2 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A3'
				UPDATE productosweb SET titulo3 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A4'
				UPDATE productosweb SET titulo4 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A5'
				UPDATE productosweb SET titulo5 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A6'
				UPDATE productosweb SET titulo6 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A7'
				UPDATE productosweb SET titulo7 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='TITULO A8'
				UPDATE productosweb SET titulo8 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A1'
				UPDATE productosweb SET valor1 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A2'
				UPDATE productosweb SET valor2 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A3'
				UPDATE productosweb SET valor3 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A4'
				UPDATE productosweb SET valor4 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A5'
				UPDATE productosweb SET valor5 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A6'
				UPDATE productosweb SET valor6 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A7'
				UPDATE productosweb SET valor7 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
			CASE ALLTRIM(&v_idx..propiedad)=='VALOR A8'
				UPDATE productosweb SET valor8 = &v_idx..valor WHERE ALLTRIM(sku) == ALLTRIM(&v_idx..articulo) AND ALLTRIM(seccion) == v_empre 
			
		ENDCASE 
		
		SELECT &v_idx
		SKIP 
		=ViewBarProgress(RECNO(),RECCOUNT(),"Generando Archivo de Productos...")
	ENDDO 

ENDFOR 


SELECT productosweb
SELECT preciosweb
SELECT stockweb


v_defa = SYS(5)+'\' 
SET DEFAULT TO &v_defa

v_prgpath = ALLTRIM(GETDIR())

IF EMPTY(v_prgpath) THEN 
	SET DEFAULT TO &_SYSESTACION 
	RETURN  
ELSE
	SET default TO &v_prgpath 
ENDIF 


** Generar los archivos productos.csv, stock.csv, precios.csv
v_archivo_productos = 'productos.csv'
DELETE FILE &v_archivo_productos
p=fcreate(v_archivo_productos,0)
SELECT productosweb
GO TOP 
v_linea = "tienda,sku,nombre,descripcion,categoria_1,categoria_2,categoria_3,peso,altura,longitud,ancho,titulo_atributo_1,valor_atributo_1,"+;
          "titulo_atributo_2,valor_atributo_2,titulo_atributo_3,valor_atributo_3,titulo_atributo_4,valor_atributo_4,titulo_atributo_5,valor_atributo_5,"+ ;
          "titulo_atributo_6,valor_atributo_6,titulo_atributo_7,valor_atributo_7,titulo_atributo_8,valor_atributo_8,iva"
=fputs(p, v_linea )
=ViewBarProgress(0,RECCOUNT(),"Generando Archivo de Productos...")
DO WHILE NOT EOF() 
	v_linea = '"'+STRTRAN(ALLTRIM(seccion),',',' ')+'","'+STRTRAN(ALLTRIM(sku),',',' ')+'","'+STRTRAN(ALLTRIM(nombre),',',' ')+'","'+STRTRAN(ALLTRIM(descrip),',',' ')+'","'+ ;
	STRTRAN(ALLTRIM(cate1),',',' ')+'","'+STRTRAN(ALLTRIM(cate2),',',' ')+'","'+STRTRAN(ALLTRIM(cate3),',',' ')+'",'+STRTRAN(str(peso,8,2),',',' ')+','+STRTRAN(str(altura,8,2),',',' ')+','+ ;
	STRTRAN(str(longitud,8,2),',',' ')+','+STRTRAN(str(ancho,8,2),',',' ')+',"'+STRTRAN(ALLTRIM(titulo1),',',' ')+'","'+STRTRAN(ALLTRIM(valor1),',',' ')+'","'+ ;
	STRTRAN(ALLTRIM(titulo2),',',' ')+'","'+STRTRAN(ALLTRIM(valor2),',',' ')+'","'+STRTRAN(ALLTRIM(titulo3),',',' ')+'","'+STRTRAN(ALLTRIM(valor3),',',' ')+'","'+ ;
	STRTRAN(ALLTRIM(titulo4),',',' ')+'","'+STRTRAN(ALLTRIM(valor4),',',' ')+'","'+STRTRAN(ALLTRIM(titulo5),',',' ')+'","'+STRTRAN(ALLTRIM(valor5),',',' ')+'","'+ ;
	STRTRAN(ALLTRIM(titulo6),',',' ')+'","'+STRTRAN(ALLTRIM(valor6),',',' ')+'","'+STRTRAN(ALLTRIM(titulo7),',',' ')+'","'+STRTRAN(ALLTRIM(valor7),',',' ')+'","'+ ;
	STRTRAN(ALLTRIM(titulo8),',',' ')+'","'+STRTRAN(ALLTRIM(valor8),',',' ')+'",'+STRTRAN(str(iva,5,2),',',' ')  
	
	=fputs(p, v_linea )
	SELECT  productosweb
	SKIP 
	=ViewBarProgress(RECNO(),RECCOUNT(),"Generando Archivo de Productos...")
ENDDO 		
=fclose(p)

v_archivo_productos = 'precios.csv'
DELETE FILE &v_archivo_productos
p=fcreate(v_archivo_productos,0)
SELECT preciosweb
GO TOP 
v_linea ="sku,precioventa,preciotachado"
=fputs(p, v_linea )
=ViewBarProgress(0,RECCOUNT(),"Generando Archivo de Productos...")
DO WHILE NOT EOF() 
	v_linea = '"'+STRTRAN(ALLTRIM(sku),',',' ')+'",'+STRTRAN(str(preciovta,10,2),',',' ')+','+STRTRAN(str(preciotach,10,2),',',' ')
	=fputs(p, v_linea )
	SELECT  preciosweb
	SKIP 
	=ViewBarProgress(RECNO(),RECCOUNT(),"Generando Archivo de Productos...")
ENDDO 		
=fclose(p)

v_archivo_productos = 'stock.csv'
DELETE FILE &v_archivo_productos
p=fcreate(v_archivo_productos,0)
SELECT stockweb
GO TOP 
v_linea ="sku,stock"
=fputs(p, v_linea )
=ViewBarProgress(0,RECCOUNT(),"Generando Archivo de Productos...")
DO WHILE NOT EOF() 
	v_linea = '"'+STRTRAN(ALLTRIM(sku),',',' ')+'",'+STRTRAN(str(stock,10,2),',',' ')
	=fputs(p, v_linea )
	SELECT  stockweb
	SKIP 
	=ViewBarProgress(RECNO(),RECCOUNT(),"Generando Archivo de Productos...")
ENDDO 		
=fclose(p)

SET DEFAULT TO &_SYSESTACION 


**************************************************************

USE IN productos01
USE IN productos02
USE IN productos03
USE IN datosextrasweb_sql
USE IN productosweb
USE IN preciosweb
USE IN stockweb 
= MESSAGEBOX("Se han generado los archivos de Productos para la Web de la Empresa...",0+64,"Exportar Archivos para Web")
vpar_eje = "RUN /N  explorer.exe "+v_prgpath
&vpar_eje

ENDFUNC 