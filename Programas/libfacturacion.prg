** Procedimientos y Funciones para Emision de Facturas Batch **


FUNCTION GenerarFacturas
PARAMETERS par_idperiodo, par_ordenfa
*#/----------------------------------------
*/ Generacion de Facturas para un Período determinado
*/ Recibe como parametro el período para el cual se debe generar la Facturación 
*/ Obtiene los datos del servicio a facturar y los vencimientos del registro en "factulotes"
*/ Las entidades que deben facturarse se encuentran en "factulotese"
*#/----------------------------------------
	WAIT WINDOWS "Generando Facturación, Aguarde... " NOWAIT 

	vs_db_sysbgproce = _SYSBGPROCE 
	_SYSBBPROCE = 0 && detiene la ejecucion de procesos de Relojes en Segundo Plano

	vartmp = frandom()
	var_retorno = 0
	
	IF !(TYPE("par_ordenfa")="C") THEN 
		vpar_ordenfa = "AP"
	ELSE
		vpar_ordenfa = par_ordenfa
	ENDIF 

	*/***********************
	*/Obtengo las Listas de Precios de Artículos
	*/
	vlistaspre = 'listaspre'+vartmp  
	=GetListasPrecios(vlistaspre)
	vlistasprea = vlistaspre+'a'
	vlistaspreb = vlistaspre+'b'
	SELECT &vlistasprea
	INDEX ON STR(idlista)+'|'+ALLTRIM(articulo) TAG idlarti
	SELECT &vlistaspreb

	 vconeFacturar=abreycierracon(0,_SYSSCHEMA)	

	** Elimino las facturas temporarias del lote antes de generar nuevamente
	** 

	sqlmatriz(1)="delete from facturasbsertmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(par_idperiodo)+" )"
	verror=sqlrun(vconeFacturar,"elim_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Conceptos para Facturar ",0+48+0,"Error")
	ENDIF 

	sqlmatriz(1)="delete from facturasdtmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(par_idperiodo)+" )"
	verror=sqlrun(vconeFacturar,"elim_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error al Eliminar el listado de Facturas Adeudadas ",0+48+0,"Error")
	ENDIF 

	sqlmatriz(1)="delete from  facturasimptmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(par_idperiodo)+" )"
	verror=sqlrun(vconeFacturar,"elim_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Conceptos para Facturar ",0+48+0,"Error")
	ENDIF 
	
	sqlmatriz(1)="delete from  detafactutmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(par_idperiodo)+" )"
	verror=sqlrun(vconeFacturar,"elim_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Conceptos para Facturar ",0+48+0,"Error")
	ENDIF 

	sqlmatriz(1)="delete from  facturastmp where idperiodo = "+STR(par_idperiodo)
	verror=sqlrun(vconeFacturar,"elim_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Conceptos para Facturar ",0+48+0,"Error")
	ENDIF 
	*******************************************************************************	

	*/*************
	* Comienzo la generacion buscando el lote a facturar y sus clientes
	*/
	sqlmatriz(1)="Select * from conceptoser "
	verror=sqlrun(vconeFacturar,"conceptoser_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Conceptos para Facturar ",0+48+0,"Error")
	ENDIF 
	vconceptoser_sql= 'conceptoser_sql'+vartmp
	SELECT &vconceptoser_sql
	GO TOP 
	IF EOF() THEN  
		MESSAGEBOX("No se han Encontrado Conceptos para Facturación 1...",0+16," Generación de Facturas ")
		=abreycierracon(vconeFacturar,"")
		RETURN var_retorno 
	ENDIF 


	*/*************
	* Buscar Impuestos de Artículos y Conceptos y guardarlos en una sola tabla 
	*/
	sqlmatriz(1)=" Select a.articulo, 00000 as idconcepto , i.*, a.iva as iva from articulosimp a left join impuestos i on a.impuesto = i.impuesto union "
	sqlmatriz(2)=" select '                              ' as articulo, c.idconcepto, p.*, c.iva from conceptoimpu c left join impuestos p on p.impuesto = c.impuesto "
	verror=sqlrun(vconeFacturar,"impuestosac_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA Impuestos para Artículos ",0+48+0,"Error")
	ENDIF 
	vimpuestosac_sql= 'impuestosac_sql'+vartmp
	vimpuestosac = 'impuestosac'+vartmp
	SELECT &vimpuestosac_sql
	GO TOP 
	IF EOF() THEN  
		MESSAGEBOX("No se han Encontrado Conceptos para Facturación 2...",0+16," Generación de Facturas ")
		=abreycierracon(vconeFacturar,"")
		RETURN var_retorno 
	ENDIF 
	SELECT * FROM  &vimpuestosac_sql INTO TABLE &vimpuestosac
	ALTER table &vimpuestosac alter COLUMN idconcepto n(10)
	ALTER table &vimpuestosac alter COLUMN iva 		  n(10)


	
	*/*************
	*/*************
	* Comienzo la generacion buscando el lote a facturar y sus clientes
	*/
	sqlmatriz(1)="Select * from factulotes where idperiodo = "+STR(par_idperiodo)
	verror=sqlrun(vconeFacturar,"factulotes_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Período a Facturar ",0+48+0,"Error")
	ENDIF 
	vfactulotes_sql= 'factulotes_sql'+vartmp
	SELECT &vfactulotes_sql
	GO TOP 
	IF EOF() THEN  
		MESSAGEBOX("No se ha Grabado el Período para el cual se desea Generar la Facturacion...",0+16," Generación de Facturas ")
		=abreycierracon(vconeFacturar,"")
		RETURN var_retorno 
	ENDIF 


	*/*************
	* Busco los comprobantes y puntos de ventas que se utilizaran segun el servicio y la condicion de IVA 
	*/ de la entidad 
	
	sqlmatriz(1)=" Select s.*, c.tipo, p.maxnumero, p.puntov  from compiservi s left join comprobantes c on s.idcomproba = c.idcomproba "
	sqlmatriz(2)=" left join compactiv p on ( p.pventa = s.pventa and p.idcomproba = s.idcomproba ) "
	sqlmatriz(3)=" where s.servicio = "+STR( &vfactulotes_sql..servicio )
	verror=sqlrun(vconeFacturar,"compiservi_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA Impuestos para Artículos ",0+48+0,"Error")
	ENDIF 
	vcompiservi_sql	= 'compiservi_sql'+vartmp
	vcompiservi 	= 'compiservi'+vartmp
	SELECT &vcompiservi_sql
	GO TOP 
	IF EOF() THEN  
		MESSAGEBOX("No se han Encontrado Relacion entre Comprobantes y Servicios para Facturacion ...",0+16," Generación de Facturas ")
		=abreycierracon(vconeFacturar,"")
		RETURN var_retorno 
	ENDIF 	
	SELECT * FROM  &vcompiservi_sql INTO TABLE &vcompiservi

	
	*/*************
	* Obtengo las entidades a facturar para el lote solicitado  
	*/
	sqlmatriz(1)=" Select e.idperiodoe, h.*, a.codafip "
	sqlmatriz(2)=" from factulotese e left join entidadesh h on h.identidadh = e.identidadh "
	sqlmatriz(3)=" left join afiptipodocu a on a.idafiptipod = h.tipodoc "
	sqlmatriz(4)=" where h.facturar = 'S' and e.idperiodo = "+STR(par_idperiodo)
	verror=sqlrun(vconeFacturar,"entidadeshf_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Entidades a Facturar del Período a Facturar ",0+48+0,"Error")
	ENDIF 
	ventidadeshf_sql = 'entidadeshf_sql'+vartmp
	SELECT &ventidadeshf_sql 
	GO TOP 
	IF EOF() THEN  
		MESSAGEBOX("No se han Seleccionado Entidades para Generar la Facturacion...",0+16," Generación de Facturas ")
		=abreycierracon(vconeFacturar,"")
		RETURN var_retorno  
	ENDIF 


	*/*************
	* Obtengo las Los grupos de Sepelios para agregar al detalle de la factura 
	*/
	sqlmatriz(1)=" SELECT  identidadh ,group_concat(concat('  ',parentesco,':',apellido,' ',nombre)) as observa1  FROM gruposepelio group by identidadh "
	verror=sqlrun(vconeFacturar,"gruposepelio_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Grupos de Sepelios para facturar ",0+48+0,"Error")
	ENDIF 
	vgruposepelio_sql = 'gruposepelio_sql'+vartmp
	vgruposepeliof_sql = 'gruposepeliof_sql'+vartmp
	SELECT identidadh, SUBSTR(ALLTRIM(observa1)+SPACE(253),1,253) as observa1 FROM &vgruposepelio_sql INTO TABLE &vgruposepeliof_sql 
	USE IN &vgruposepelio_sql 

	*/*************
	* Obtengo las Bocas de Servicios 
	*/
	sqlmatriz(1)=" Select e.idperiodoe, b.* from bocaservicios b left join factulotese e on e.identidadh = b.identidadh left join entidadesh h on h.identidadh = b.identidadh "
	sqlmatriz(2)=" where  b.facturar = 'S'  and h.facturar = 'S' and e.idperiodo = "+STR(par_idperiodo)
	verror=sqlrun(vconeFacturar,"bocaserviciosf_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Entidades a Facturar del Período a Facturar ",0+48+0,"Error")
	ENDIF 
	vbocaserviciosf_sql = 'bocaserviciosf_sql'+vartmp
	SELECT &vbocaserviciosf_sql 
	GO TOP 
	IF EOF() THEN  
		MESSAGEBOX("No se han Seleccionado Entidades para Generar la Facturacion...",0+16," Generación de Facturas ")
		=abreycierracon(vconeFacturar,"")
		RETURN var_retorno  
	ENDIF 
	
	*/*************
	* Obtengo el detalle de todos los conceptos o detalles que debo facturar cargado a las entidades Seleccionadas
	*/ - sin los conceptos compuestos 
	sqlmatriz(1)=" Select e.idperiodoe, f.*, ifnull(c.funcion,'') as funcion, h.iva, ifnull(c.compuesto,'N') as compuesto, ifnull(a.idcuotasd,0) as cacuotas  from entidadesd f left join factulotese e on e.identidadh = f.identidadh "
	sqlmatriz(2)=" left join conceptoser c on c.idconcepto = f.idconcepto "
	sqlmatriz(3)=" left join entidadesh h on h.identidadh = f.identidadh "
	sqlmatriz(4)=" left join entidadesdc a on a.identidadd = f.identidadd "
	sqlmatriz(5)=" where f.facturar = 'S' and h.facturar = 'S' and e.idperiodo = "+STR(par_idperiodo)
	sqlmatriz(6)=" group by f.identidadd "

	verror=sqlrun(vconeFacturar,"entidadesdf_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Entidades a Facturar del Período a Facturar ",0+48+0,"Error")
	ENDIF 
	ventidadesdf_sql = 'entidadesdf_sql'+vartmp
	SELECT &ventidadesdf_sql
	GO TOP 

	IF EOF() THEN  
		MESSAGEBOX("No se han Seleccionado Entidades para Generar la Facturacion...",0+16," Generación de Facturas ")
		=abreycierracon(vconeFacturar,"")
		RETURN var_retorno  
	ENDIF 

	SELECT * FROM &ventidadesdf_sql INTO TABLE ventidadesdf
	


*******************************************************************************************************************
****** Obtengo los conceptos compuestos de aquellos que debo facturar para agregar los items correspondientes *****
*******************************************************************************************************************

	*/*************
	* Obtengo el detalle de todos los conceptos o detalles que debo facturar cargado a las entidades Seleccionadas
	*/ - QUE CORRESPONDEN A ACONCEPTOS COMPUESTOS ** 
	
	
	ventidadesdfcomp = 'entidadesdfcomp'+vartmp
	SELECT * FROM &ventidadesdf_sql INTO TABLE &ventidadesdfcomp WHERE compuesto = 'S' 
	IF _TALLY > 0 THEN 
		SELECT &ventidadesdfcomp 
		GO TOP 
		DO WHILE !EOF()
			vcombo=""
			vcombo = fpgcombo(vconeFacturar, &ventidadesdfcomp..idperiodoe, &ventidadesdfcomp..identidadh, &ventidadesdfcomp..iva, &ventidadesdfcomp..cantidad,&ventidadesdfcomp..identidadd ,&ventidadesdfcomp..funcion )
			IF !EMPTY(vcombo)
				SELECT &ventidadesdf_sql 
				
				USE &vcombo IN 0
				SELECT &vcombo
				SELECT &ventidadesdf_sql 
				APPEND FROM &vcombo 
			
			ENDIF 		
			SELECT &ventidadesdfcomp 
			SKIP 
		ENDDO 
	ENDIF 
	USE IN &ventidadesdfcomp



*******************************************************************************************************************


	v_fechaemite = &vfactulotes_sql..fechaemite
	
	*/*************
	* Obtengo las Cuotas de los detalles a facturar en el servicio
	*/
	sqlmatriz(1)=" Select e.idperiodoe, c.* from entidadesdc c left join entidadesd d on d.identidadd = c.identidadd "
	sqlmatriz(2)=" left join factulotese e on e.identidadh = d.identidadh "
	sqlmatriz(3)=" where c.idfactura = 0 and c.facturar = 'S' and e.idperiodo = "+STR(par_idperiodo)
	sqlmatriz(4)=" and c.fechavenc >='"+v_fechaemite+"' order by idcuotasd desc " 


	verror=sqlrun(vconeFacturar,"entidadesdcf_sql"+vartmp)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Cuotas a Facturar del Período a Facturar ",0+48+0,"Error")
	ENDIF 
	ventidadesdcf_sql = 'entidadesdcf_sql'+vartmp
	SELECT &ventidadesdcf_sql 
	GO TOP 
	ventidadesdcf = 'entidadesdcf'+vartmp
	SET ENGINEBEHAVIOR  70
	SELECT * FROM &ventidadesdcf_sql INTO TABLE &ventidadesdcf  ORDER BY identidadd GROUP BY identidadd 
	SET ENGINEBEHAVIOR 90
	SELECT &ventidadesdcf 
	INDEX on identidadd TAG identidadd 
	

	
	*// Calculo el Valor Actualizado para todos los Detalles de Artículos y Conceptos a Facturar 
	ventidadesdf = 'entidadesdf'+vartmp 
	SELECT * FROM &ventidadesdf_sql INTO TABLE &ventidadesdf WHERE compuesto = 'N'
	SELECT &ventidadesdf
	ALTER table &ventidadesdf alter COLUMN cacuotas i
	ALTER TABLE &ventidadesdf ALTER COLUMN detalle c(200)  
	ALTER table &ventidadesdf ADD COLUMN nrocuota i
	ALTER table &ventidadesdf ADD COLUMN cantcuotas i
	ALTER table &ventidadesdf ADD COLUMN netocuota y
	ALTER table &ventidadesdf ADD COLUMN idcuotasd i 
	ALTER TABLE &ventidadesdf ADD COLUMN ejecucion i 

	
	* Actualizo precios segun listas de precios solo para Articulos Facturados = idconcepto = 0
	SET RELATION TO STR(idlista)+'|'+ALLTRIM(articulo) INTO &vlistasprea
	SET RELATION TO identidadd INTO &ventidadesdcf ADDITIVE 
	
	GO TOP 
	
		*!*	antes de corregir para mantener el valor si fijarvalor = 'S'
*!*		replace ALL detalle WITH &vlistasprea..detalle, unidad WITH &vlistasprea..unidad , unitario WITH &vlistasprea..pventa, ;
*!*						nrocuota WITH &ventidadesdcf..nrocuota, cantcuotas WITH &ventidadesdcf..cantcuotas, ;
*!*						netocuota WITH &ventidadesdcf..neto, idcuotasd WITH &ventidadesdcf..idcuotasd FOR idconcepto = 0

	* Corregido para mantener el valor si fijarvalor es = 'S'
	replace ALL detalle WITH &vlistasprea..detalle, unidad WITH &vlistasprea..unidad ,unitario WITH IIF(ALLTRIM(fijarvalor)='S',&ventidadesdcf..unitario,&vlistasprea..pventa), ;
					nrocuota WITH &ventidadesdcf..nrocuota, cantcuotas WITH &ventidadesdcf..cantcuotas, ;
					netocuota WITH &ventidadesdcf..neto, idcuotasd WITH &ventidadesdcf..idcuotasd FOR idconcepto = 0



	
	
	* Actualizo para Conceptos Facturados segun Fórmulas de Calculo = idconcepto > 0
	vconceptoser = 'conceptoser'+vartmp
	SELECT * FROM &vconceptoser_sql INTO TABLE &vconceptoser
	SELECT &vconceptoser
	INDEX on idconcepto TAG idconcepto 
	
	SELECT &ventidadesdf
	SET RELATION TO idconcepto INTO &vconceptoser ADDITIVE 
	replace ALL ejecucion WITH &vconceptoser..ejecucion 

	** EJECUTA CALCULANDO CONCEPTOS POR NIVELES
	FOR ieje = 0 TO 3 
	
		SELECT &ventidadesdf 
		GO TOP 
		v_fechaemite = &vfactulotes_sql..fechaemite
		SCAN FOR ( &ventidadesdf..idconcepto > 0 ) AND !EOF() AND (&ventidadesdf..ejecucion = ieje) 
			
			IF  ( &vconceptoser..facturar = 'S' ) THEN 
				imp_cantidad = 1				
				imp_unitario = 0					
				IF  ( &vconceptoser..vigencia = '1' ) OR  ( &vconceptoser..vigencia = '2' AND &vconceptoser..vigedesde<=v_fechaemite AND v_fechaemite <= &vconceptoser..vigehasta )  THEN 			
					C   = &vconceptoser..cantidad
					* Corregido para respetar si el importe está fijado
*!*						I   = &vconceptoser..importe 
					I   = IIF(ALLTRIM(&ventidadesdf..fijarvalor) = 'S', &ventidadesdf..unitario, &vconceptoser..importe) 				
					Fun = &vconceptoser..funcion

					IF !EMPTY(Fun) THEN 
					
	*********************************************************				
	*/ Definir los Parametros a agregar a la funcion para calculo				
						IF SUBSTR(Fun,1,1)='=' THEN 
							Fun=STRTRAN(Fun,'=','')
							IF UPPER(SUBSTR(Fun,1,2))='FP' THEN 
								
								vartablaauxi = ""
								IF ieje > 0 THEN 
									varentih = &ventidadesdf..identidadh
									vartablaauxi = 'auxiconceptos'
									SELECT articulo, cantidad, (unitario * cantidad) as neto from &ventidadesdf INTO cursor &vartablaauxi ;
									WHERE identidadh = varentih AND (unitario*cantidad)  <> 0 AND ejecucion < ieje
									
								ENDIF 

								varparconceptos = IIF(EMPTY(vartablaauxi),"",'"'+vartablaauxi+'"')
								
								SELECT &ventidadesdf 

								Fun = STRTRAN(STRTRAN(STRTRAN(Fun,'(','('+ALLTRIM(STR(par_idperiodo))+','+ALLTRIM(STR(&ventidadesdf..identidadh))+','+ALLTRIM(STR(&ventidadesdf..idconcepto))+','+ALLTRIM(STR(vconeFacturar))+','+ALLTRIM(varparconceptos)+','),',,',','),',)',')')
								IF LEN(Fun) > 254 THEN 
									nfuncion =FModificaFuncion (Fun)
									Fun = SUBSTR(nfuncion,3)
									FunV= VAL(SUBSTR(nfuncion,1,2))
			
					
									V_retfun = &Fun
									
									IF FunV > 0 THEN 
										FOR ijv = 1 TO FunV
											eje="RELEASE fvar"+ALLTRIM(STR(ijv))
											&eje
										ENDFOR 
									ENDIF 
								ELSE
									V_retfun = &Fun
								ENDIF 	
								
								
								IF TYPE('V_retfun')='C' THEN 
									ALINES(ARR_CAN_IMP,V_retfun,4,';')
									imp_cantidad0 = ARR_CAN_IMP(1)
									imp_unitario0 = ARR_CAN_IMP(2)
									
									imp_cantidad = IIF(TYPE('imp_cantidad0')='C',VAL(imp_cantidad0),imp_cantidad0)
									imp_unitario = IIF(TYPE('imp_unitario0')='C',val(imp_unitario0),imp_unitario0)

								ELSE					
									imp_unitario = V_retfun
								ENDIF 

							ENDIF 
						ELSE
							imp_unitario = &Fun					
						ENDIF 
						
	****************************************************					
					ELSE 
						imp_unitario = 0
					ENDIF 

					
									
					SELECT &ventidadesdf
					replace articulo WITH &vconceptoser..concepto, detalle  WITH &vconceptoser..detalle, unidad WITH &vconceptoser..unidad , unitario WITH imp_unitario, ;
						nrocuota  WITH &ventidadesdcf..nrocuota, cantcuotas WITH &ventidadesdcf..cantcuotas, ;
						netocuota WITH &ventidadesdcf..neto, idcuotasd WITH &ventidadesdcf..idcuotasd, cantidad WITH ( cantidad * imp_cantidad )
					
				ELSE 
					replace articulo WITH &vconceptoser..concepto, detalle WITH &vconceptoser..detalle, unidad WITH &vconceptoser..unidad , unitario WITH 0 							
				ENDIF 
			ELSE 
				replace articulo WITH &vconceptoser..concepto, detalle WITH &vconceptoser..detalle, unidad WITH &vconceptoser..unidad , unitario WITH 0 	
			ENDIF 
		
		ENDSCAN 
		
	ENDFOR 



	SELECT &ventidadesdf
	GO TOP 
	UPDATE &ventidadesdf SET detalle = ALLTRIM(detalle)+' - Cta. '+ALLTRIM(STR(nrocuota))+'/'+ALLTRIM(STR(cantcuotas)) ,unitario=netocuota, cantidad=1 WHERE idcuotasd > 0
	** aqui elimino todos los que tienen cuotas pero no tienen idcuotasd 
	UPDATE &ventidadesdf SET unitario=0, cantidad=0 WHERE idcuotasd = 0 AND cacuotas > 0
	****
	UPDATE &ventidadesdf SET neto=unitario * cantidad 
	
	GO TOP 
	SET RELATION TO 

		
	**************************************************************************************
	*/ Calculo los Impuestos a aplicar para los Detalles a Facturar 
	*/ Uniendo detalles e impuestos en una nueva tabla 
	
	SELECT &ventidadesdf
	ALTER TABLE &ventidadesdf ALTER	COLUMN funcion char(254)

	ventidadesdif = 'entidadesdif'+vartmp
*!*		SELECT d.*,i.impuesto, i.detalle as detimpu, i.razon, i.baseimpon, d.neto as impuestos FROM &ventidadesdf d LEFT JOIN  &vimpuestosac i ON d.idconcepto=i.idconcepto WHERE d.idconcepto > 0 UNION  ;
*!*		SELECT e.*,j.impuesto, j.detalle as detimpu, j.razon, j.baseimpon, e.neto as impuestos FROM &ventidadesdf e LEFT JOIN  &vimpuestosac j ON ALLTRIM(e.articulo)==ALLTRIM(j.articulo) WHERE e.idconcepto = 0 AND !EMPTY(e.articulo) ;
*!*		into table &ventidadesdif

	SELECT d.*,IIF(ISNULL(i.impuesto),0,i.impuesto) as impuesto, IIF(ISNULL(i.detalle),'',i.detalle) as detimpu, IIF(ISNULL(i.razon),0,i.razon) as razon, IIF(ISNULL(i.baseimpon),0,i.baseimpon) as baseimpon, ;
		IIF(ISNULL(i.iva),0,i.iva) as iva, IIF(ISNULL(d.neto),0,d.neto) as impuestos FROM &ventidadesdf d LEFT JOIN  &vimpuestosac i ON (d.idconcepto=i.idconcepto AND d.iva = i.iva) WHERE (d.idconcepto > 0  AND d.neto <> 0 ) UNION  ;
	SELECT e.*,IIF(ISNULL(j.impuesto),0,j.impuesto) as impuesto, IIF(ISNULL(j.detalle),'',j.detalle) as detimpu, IIF(ISNULL(j.razon),0,j.razon) as razon, IIF(ISNULL(j.baseimpon),0,j.baseimpon) as baseimpon, ;
		IIF(ISNULL(j.iva),0,j.iva) as iva, IIF(ISNULL(e.neto),0,e.neto) as impuestos FROM &ventidadesdf e LEFT JOIN  &vimpuestosac j ON (ALLTRIM(e.articulo)==ALLTRIM(j.articulo) AND e.iva = j.iva) WHERE e.idconcepto = 0 AND !EMPTY(e.articulo) AND e.neto <> 0 ;
	into table &ventidadesdif
	SELECT &ventidadesdif 
	UPDATE &ventidadesdif SET impuestos = ( neto * razon / 100 )



	**************************************************************************************
	*/ Genero una Tabla con todos los datos de entidades y detalles de facturas e impuestos
	*/ Es el total facturado discriminado por conceptos, articulos e impuestos. 
	vfacturaciontot = 'facturaciontot'+vartmp
	SELECT h.*, i.idconcepto, i.articulo, i.detalle, i.abreviado, i.cantidad, i.unitario, i.neto, i.unidad, i.identidadd, i.mensual, i.facturar, i.padron, i.idlista,  ;
			i.idcuotasd, i.nrocuota, i.cantcuotas, i.impuesto, i.detimpu, i.razon, i.baseimpon, i.impuestos ;
			from &ventidadesdif i LEFT JOIN &ventidadeshf_sql h ON h.identidadh = i.identidadh INTO TABLE &vfacturaciontot ORDER BY h.identidadh 

	**/ Impuestos para Facturacion 
	vfacturasimptmp = 'facturasimptmp'+vartmp 
	SELECT identidadh as idfactura, identidadh, impuesto, detimpu as detalle, razon, neto, impuestos as importe, idconcepto, articulo ;
		FROM &ventidadesdif INTO TABLE &vfacturasimptmp 


	**/ Detalles para Facturacion 
	vdetafactutmp = 'detafactutmp'+vartmp 
	SET ENGINEBEHAVIOR 70
	SELECT identidadh, identidadh as idfacturah, identidadh as idfactura,  articulo, idconcepto , cantidad, unidad, cantidad as cantidadfc, unidad as unidadfc, ;
			detalle, unitario, neto, SUM(impuestos) as impuestos, SUM(razon) as razon, neto as total, " " as codigocta, " " as nombrecta, nrocuota as cuota, cantcuotas , padron, idcuotasd,  ;
			identidadd, STR(identidadh)+STR(idconcepto)+STR(identidadd)+ALLTRIM(articulo) as orden ;
		FROM &ventidadesdif INTO TABLE &vdetafactutmp  ORDER BY orden GROUP BY orden 



	SELECT &vdetafactutmp
	UPDATE &vdetafactutmp SET total = ( impuestos + neto )
	COUNT TO vCantidad_D	



	**/ Cabecera Temporal de facturacion para Ordenar
	vfacturastmp0 ='facturastmp0'+vartmp
	**/ Cabecera para Facturacion 
	vfacturastmp = 'facturastmp'+vartmp 
	
	SELECT h.* , h.identidadh as idfactura, h.identidadh as idcomproba, h.identidadh as pventa, h.identidadh as numero, 'X' as tipo,   ;
			&vfactulotes_sql..fechaemite as fecha, &vfactulotes_sql..idperiodo as idperiodo, &vfactulotes_sql..fechavenc1 as fechavenc1, ;
			&vfactulotes_sql..fechavenc2 as fechavenc2, &vfactulotes_sql..fechavenc3 as fechavenc3,&vfactulotes_sql..proxvenc as proxvenc, ;
			&vfactulotes_sql..cesp as cespcae, &vfactulotes_sql..cespvence as caevence, &vfactulotes_sql..interesd as interesd, ; 
			1 as idtipopera, SUM(d.neto) as neto, SUM(d.neto) as subtotal, 0 as descuento, 0 as recargo, SUM(d.total) as total, ;
			SUM(d.impuestos) as totalimpu, 'N' as operexenta, 'N' as anulado, STRTRAN(IIF(ISNULL(s.observa1),SPACE(254),s.observa1),',','') as observa1, "" as observa2, "" as observa3, "" as observa4 ;
		FROM &vdetafactutmp d LEFT JOIN &ventidadeshf_sql h ON h.identidadh = d.identidadh LEFT JOIN &vgruposepeliof_sql s ON s.identidadh = h.identidadh ;
		INTO TABLE &vfacturastmp0 ORDER BY h.identidadh GROUP BY h.identidadh


	
	**/ Establezco el orden de generacion de facturas 
	vsetorden = " "
	DO CASE 
		CASE vpar_ordenfa = "AP"
			vsetorden = " ALLTRIM(apellido)+ALLTRIM(nombre)+ALLTRIM(compania)"
		CASE vpar_ordenfa = "R1"
			vsetorden = " STR(ruta1)+STR(ruta1) "
		CASE vpar_ordenfa = "R2"
			vsetorden = " STR(ruta2)+STR(ruta2) "
	ENDCASE 
	
	SELECT *, &vsetorden as orden  FROM &vfacturastmp0 INTO TABLE &vfacturastmp ORDER BY orden 
	
	SELECT &vfacturastmp0
	USE IN &vfacturastmp0

	SELECT &vfacturastmp

	COUNT TO vCantidad_F	
		

		
	**/ Cargo la Numeracion de Facturas y Detalle en tabla temporaria


	var_idfactura_ini = maxnumeroidx("idfactura","I","facturastmp",0)
	var_idfactura_fin = maxnumeroidx("idfactura","I","facturastmp",vCantidad_F)

	var_idfacturah_ini = maxnumeroidx("idfacturah","I","detafactutmp",0)
	var_idfacturah_fin = maxnumeroidx("idfacturah","I","detafactutmp",vCantidad_D)			

	** Calcularlo cuando Grabo en la Tabla Temporaria
	**thisform.tb_numero.Value = maxnumerocom(VAL(v_idcom),thisform.pventa ,1)

	
	SELECT &vcompiservi
	INDEX on iva TAG iva 
	
	SELECT &vfacturastmp 
	SET RELATION TO iva INTO &vcompiservi
	replace ALL  idfactura WITH RECNO()+var_idfactura_ini, idcomproba WITH &vcompiservi..idcomproba, ;
		pventa WITH &vcompiservi..pventa, tipo WITH &vcompiservi..tipo, numero WITH &vcompiservi..maxnumero 
		
	INDEX on identidadh TAG identidadh
	SET RELATION TO 

	
	SELECT &vdetafactutmp  
	SET RELATION TO identidadh INTO &vfacturastmp
	replace ALL  idfacturah WITH RECNO()+var_idfacturah_ini, idfactura WITH &vfacturastmp..idfactura
	SET RELATION TO 
	
	SELECT &vfacturasimptmp
	SET RELATION TO identidadh INTO &vfacturastmp
	replace ALL  idfactura WITH &vfacturastmp..idfactura
	SET RELATION TO 
	
	** Agrego las bocas de servicios seleccionadas de acuerdo a las facturas generadas
	vbocaserviciosftmp = 'bocaserviciosf'+vartmp 
*	sqlmatriz(1)=" Select e.idperiodoe, b.* from bocaservicios b left join factulotese e on e.identidadh = b.identidadh "
*	sqlmatriz(2)=" where b.facturar = 'S'  and e.idperiodo = "+STR(par_idperiodo)
	SELECT b.* , f.idfactura FROM &vbocaserviciosf_sql b LEFT JOIN &vfacturastmp f ON f.identidadh = b.identidadh INTO TABLE &vbocaserviciosftmp WHERE !ISNULL(f.idfactura)  && ORDER BY h.identidadh GROUP BY h.identidadh
    
    **CREO QUE ACA PUEDO AGREGAR TODO EL CONSUMO DE MSERVICIOS ***
	GO TOP 
	ALTER TABLE &vbocaserviciosftmp ADD manterior n(10,2)
	ALTER table &vbocaserviciosftmp ADD mactual n(10,2)
	ALTER table &vbocaserviciosftmp ADD consextra n(10,2)
	ALTER table &vbocaserviciosftmp ADD consumo n(10,2)
	ALTER table &vbocaserviciosftmp ALTER COLUMN idcateser i


	DO WHILE !EOF()
		vmedidas = FPXMSERVICIO(PAR_idperiodo, &vbocaserviciosftmp..idbocaser, vconeFacturar)
		vmedidas1 = VAL(SUBSTR(vmedidas,1,ATC(';',vmedidas,1)-1)) && manterior
		vmedidas2 = VAL(SUBSTR(vmedidas,ATC(';',vmedidas,1)+1,ATC(';',vmedidas,2)-1)) && mactual
		vmedidas3 = VAL(SUBSTR(vmedidas,ATC(';',vmedidas,2)+1,ATC(';',vmedidas,3)-1)) && consextra
		vmedidas4 = VAL(SUBSTR(vmedidas,ATC(';',vmedidas,3)+1,ATC(';',vmedidas,4)-1)) &&consumo
		vmedidas5 = VAL(SUBSTR(vmedidas,ATC(';',vmedidas,4)+1)) &&factorm
		SELECT &vbocaserviciosftmp
		replace &vbocaserviciosftmp..manterior WITH vmedidas1, &vbocaserviciosftmp..mactual WITH vmedidas2, ;
				&vbocaserviciosftmp..consextra WITH vmedidas3, &vbocaserviciosftmp..consumo WITH vmedidas4, &vbocaserviciosftmp..factorm WITH vmedidas5
		SKIP 
	ENDDO 

BROWSE 


 
    
    *****************************
    
	*************************************************************************
	*************************************************************************
	*/ Actualizacion de Numeros de Facturas */
	vnumeracion = 'numeracion'+vartmp
	SELECT idcomproba, pventa, 'nume_'+ALLTRIM(STR(idcomproba))+'_'+ALLTRIM(STR(pventa)) as grupo FROM &vfacturastmp INTO TABLE &vnumeracion ORDER BY grupo GROUP BY grupo 
	SELECT &vnumeracion 
	GO TOP 
	DO WHILE !EOF()
		eje = ALLTRIM(&vnumeracion..grupo)+"=maxnumerocom("+STR(&vnumeracion..idcomproba)+","+str(&vnumeracion..pventa)+" ,0)"
		&eje
		SELECT &vnumeracion 
		SKIP 
	ENDDO 
	
	SELECT &vfacturastmp 
	GO TOP 
	DO WHILE !EOF()
		eje = "nume_"+ALLTRIM(STR(idcomproba))+'_'+ALLTRIM(STR(pventa))+" = nume_"+ALLTRIM(STR(idcomproba))+"_"+ALLTRIM(STR(pventa))+" + 1 "
		&eje 
		SELECT &vfacturastmp 
		eje = "replace "+vfacturastmp+".numero WITH nume_"+ALLTRIM(STR(idcomproba))+'_'+ALLTRIM(STR(pventa))
		&eje
		SKIP 
	ENDDO 	
	SET ENGINEBEHAVIOR 70

	
	= CargarFacturas ( vfacturastmp, vdetafactutmp, vfacturasimptmp, vbocaserviciosftmp,  vconeFacturar)

	
	=abreycierracon(vconeFacturar,"")
	
	USE IN &vlistasprea
	USE IN &vlistaspreb
	USE IN &vconceptoser_sql
	USE IN &vimpuestosac_sql
	USE IN &vimpuestosac
	USE IN &vfactulotes_sql
	USE IN &vcompiservi_sql
	USE IN &vcompiservi
	USE IN &ventidadeshf_sql 
	USE IN &vbocaserviciosf_sql 
	USE IN &ventidadesdf_sql 
	USE IN &ventidadesdf
	USE IN &vconceptoser 
	USE IN &ventidadesdif 
	USE IN &vfacturaciontot 
	USE IN &vfacturasimptmp 
	USE IN &vdetafactutmp 
	USE IN &vfacturastmp 
	USE IN &vbocaserviciosftmp 
	USE IN &vgruposepeliof_sql 

	WAIT CLEAR 

	_SYSBGPROCE = vs_db_sysbgproce
	
	var_retorno = 1
	RETURN var_retorno 
ENDFUNC 



FUNCTION CargarFacturas 
PARAMETERS pfacturas, pdetafactu, pfacturasimp,pbocaservi, pcone
*#/----------------------------------------
**/ Incerta las Facturas Generadas en la Base de Datos en 
** la tabla facturastmp, detafactutmp, facturasimptmp, facturasbsertmp
** Recibe como Parametro las Tablas de facturas, detalle, facturasimp
*#/----------------------------------------

	IF pcone = 0 THEN 
		vconeccionFa = abreycierracon(0,_SYSSCHEMA)	
	ELSE
		vconeccionFa = pcone
	ENDIF 


	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
	
	SELECT &pfacturas

	GO TOP 
	DIMENSION lamatriz1(56,2)


	DO WHILE !EOF() 

	
		*** GUARDA DATOS DE CABECERA DE LA FACTURA
		lamatriz1(1,1)='idfactura'
		lamatriz1(1,2)= ALLTRIM(STR(&pfacturas..idfactura))
		lamatriz1(2,1)='idcomproba'
		lamatriz1(2,2)=ALLTRIM(STR(&pfacturas..idcomproba))
		lamatriz1(3,1)='pventa'
		lamatriz1(3,2)= ALLTRIM(STR(&pfacturas..pventa))
		lamatriz1(4,1)='numero'
		lamatriz1(4,2)=ALLTRIM(STR(&pfacturas..numero))
		lamatriz1(5,1)='tipo'
		lamatriz1(5,2)="'"+ALLTRIM(&pfacturas..tipo)+"'"
		lamatriz1(6,1)='fecha'
		lamatriz1(6,2)="'"+ALLTRIM(&pfacturas..fecha)+"'"
		lamatriz1(7,1)='entidad'
		lamatriz1(7,2)=ALLTRIM(STR(&pfacturas..entidad))
		lamatriz1(8,1)='servicio'
		lamatriz1(8,2)= ALLTRIM(STR(&pfacturas..servicio))
		lamatriz1(9,1)='cuenta'
		lamatriz1(9,2)= ALLTRIM(STR(&pfacturas..cuenta))
		lamatriz1(10,1)='apellido'
		lamatriz1(10,2)= "'"+ALLTRIM(&pfacturas..apellido)+"'"
		lamatriz1(11,1)='nombre'
		lamatriz1(11,2)= "'"+ALLTRIM(&pfacturas..nombre)+"'"
		lamatriz1(12,1)='direccion'
		lamatriz1(12,2)= "'"+ALLTRIM(&pfacturas..direccion)+"'"
		lamatriz1(13,1)='localidad'
		lamatriz1(13,2)= "'"+ALLTRIM(&pfacturas..localidad)+"'"
		lamatriz1(14,1)='iva'
		lamatriz1(14,2)= ALLTRIM(STR(&pfacturas..iva))
		lamatriz1(15,1)='cuit'
		lamatriz1(15,2)= "'"+ALLTRIM(&pfacturas..cuit)+"'"
		lamatriz1(16,1)='tipodoc'
		lamatriz1(16,2)= "'"+ALLTRIM(&pfacturas..codafip)+"'" &&tipodoc
		lamatriz1(17,1)='dni'
		lamatriz1(17,2)= ALLTRIM(STR(&pfacturas..dni))
		lamatriz1(18,1)='telefono'
		lamatriz1(18,2)= "'"+ALLTRIM(&pfacturas..telefono)+"'"
		lamatriz1(19,1)='cp'
		lamatriz1(19,2)= "'"+ALLTRIM(&pfacturas..cp)+"'"
		lamatriz1(20,1)='fax'
		lamatriz1(20,2)= "'"+ALLTRIM(&pfacturas..fax)+"'"
		lamatriz1(21,1)='email' 
		lamatriz1(21,2)= "'"+ALLTRIM(&pfacturas..email)+"'"
		lamatriz1(22,1)='transporte'
		lamatriz1(22,2)= ALLTRIM(STR(0))
		lamatriz1(23,1)='nomtransp'
		lamatriz1(23,2)= "'"+ALLTRIM(" ")+"'"
		lamatriz1(24,1)='direntrega'
		lamatriz1(24,2)= "'"+ALLTRIM(" ")+"'"
		lamatriz1(25,1)='stock'
		lamatriz1(25,2)= "'"+ALLTRIM("N")+"'"
		lamatriz1(26,1)='idtipoopera'
		lamatriz1(26,2)= ALLTRIM(STR(&pfacturas..idtipopera))
		lamatriz1(27,1)='neto'
		lamatriz1(27,2)= ALLTRIM(STR(&pfacturas..neto,13,4))
		lamatriz1(28,1)='subtotal'
		lamatriz1(28,2)= ALLTRIM(STR(&pfacturas..subtotal,13,4))
		lamatriz1(29,1)='descuento'
		lamatriz1(29,2)= ALLTRIM(STR(&pfacturas..descuento,13,4))
		lamatriz1(30,1)='recargo'
		lamatriz1(30,2)= ALLTRIM(STR(&pfacturas..recargo,13,4))
		lamatriz1(31,1)='total'
		lamatriz1(31,2)= ALLTRIM(STR(&pfacturas..total,13,4))
		lamatriz1(32,1)='totalimpu'
		lamatriz1(32,2)= ALLTRIM(STR(&pfacturas..totalimpu,13,4))
		lamatriz1(33,1)='operexenta'
		lamatriz1(33,2)= "'"+ALLTRIM(&pfacturas..operexenta)+"'"
		lamatriz1(34,1)='anulado'
		lamatriz1(34,2)= "'"+ALLTRIM(&pfacturas..anulado)+"'"
		lamatriz1(35,1)='observa1'
		lamatriz1(35,2)= "'"+ALLTRIM(&pfacturas..observa1)+"'"
		lamatriz1(36,1)='observa2'
		lamatriz1(36,2)= "'"+ALLTRIM(&pfacturas..observa2)+"'"
		lamatriz1(37,1)='observa3'
		lamatriz1(37,2)= "'"+ALLTRIM(&pfacturas..observa3)+"'"
		lamatriz1(38,1)='observa4'
		lamatriz1(38,2)= "'"+ALLTRIM(&pfacturas..observa4)+"'"
		lamatriz1(39,1)='idperiodo'
		lamatriz1(39,2)= ALLTRIM(STR(&pfacturas..idperiodo))
		lamatriz1(40,1)='ruta1'
		lamatriz1(40,2)= ALLTRIM(STR(&pfacturas..ruta1))
		lamatriz1(41,1)='folio1'
		lamatriz1(41,2)= ALLTRIM(STR(&pfacturas..folio1))
		lamatriz1(42,1)='ruta2'
		lamatriz1(42,2)= ALLTRIM(STR(&pfacturas..ruta2))
		lamatriz1(43,1)='folio2'
		lamatriz1(43,2)= ALLTRIM(STR(&pfacturas..folio2))
		lamatriz1(44,1)='fechavenc1'
		lamatriz1(44,2)= "'"+ALLTRIM(&pfacturas..fechavenc1)+"'"
		lamatriz1(45,1)='fechavenc2'
		lamatriz1(45,2)= "'"+ALLTRIM(&pfacturas..fechavenc2)+"'"
		lamatriz1(46,1)='fechavenc3'
		lamatriz1(46,2)= "'"+ALLTRIM(&pfacturas..fechavenc3)+"'"
		lamatriz1(47,1)='proxvenc'
		lamatriz1(47,2)= "'"+ALLTRIM(&pfacturas..proxvenc)+"'"
		lamatriz1(48,1)='confirmada'
		lamatriz1(48,2)= "'"+ALLTRIM("N")+"'"
		lamatriz1(49,1)='astoconta'
		lamatriz1(49,2)= ALLTRIM(STR(0))
		lamatriz1(50,1)='deudacta'
		lamatriz1(50,2)= ALLTRIM(STR(0,13,4))
		lamatriz1(51,1)='cespcae'
		lamatriz1(51,2)= "'"+ALLTRIM(&pfacturas..cespcae)+"'"
		lamatriz1(52,1)='caecespven'
		lamatriz1(52,2)= "'"+ALLTRIM(&pfacturas..caevence)+"'"
		lamatriz1(53,1)='vendedor'
		lamatriz1(53,2)= ALLTRIM(STR(1))
		lamatriz1(54,1)='identidadh'
		lamatriz1(54,2)= ALLTRIM(STR(&pfacturas..identidadh))
		lamatriz1(55,1)='interesd'
		lamatriz1(55,2)= ALLTRIM(STR(&pfacturas..interesd,13,2))
		lamatriz1(56,1)='idtipocli'
		lamatriz1(56,2)= ALLTRIM(STR(&pfacturas..idtipocli))

		p_tabla     = 'facturastmp'
		p_matriz    = 'lamatriz1'
		p_conexion  = vconeccionFa 
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
		    RETURN 
		ENDIF  

		varchi = FCAdeudadas ( 0, 0, 0, ALLTRIM(&pfacturas..fecha), &pfacturas..idfactura, "I", "tmp", vconeccionFa )



		SELECT &pfacturas
		SKIP 
	ENDDO 


	IF USED('alldeudas') THEN 
		SELECT alldeudas
		USE IN alldeudas 
	ENDIF 

	
	SELECT &pdetafactu
	GO TOP 
	DIMENSION lamatriz2(22,2) 
	DO WHILE !EOF() 

		lamatriz2(1,1)='idfactura'
		lamatriz2(1,2)= ALLTRIM(STR(&pdetafactu..idfactura))
		lamatriz2(2,1)='idfacturah'
		lamatriz2(2,2)= ALLTRIM(STR(&pdetafactu..idfacturah))
		lamatriz2(3,1)='articulo'
		lamatriz2(3,2)= "'"+ALLTRIM(&pdetafactu..articulo)+"'"
		lamatriz2(4,1)='idconcepto'
		lamatriz2(4,2)= ALLTRIM(STR(&pdetafactu..idconcepto))
		lamatriz2(5,1)='servicio'
		lamatriz2(5,2)= ALLTRIM(STR(0))
		lamatriz2(6,1)='cantidad'
		lamatriz2(6,2)= ALLTRIM(STR(&pdetafactu..cantidad,13,2))
		lamatriz2(7,1)='unidad'
		lamatriz2(7,2)= "'"+ALLTRIM(&pdetafactu..unidad)+"'"
		lamatriz2(8,1)='cantidadfc'
		lamatriz2(8,2)= ALLTRIM(str(&pdetafactu..cantidadfc,13,4))
		lamatriz2(9,1)='unidadfc'
		lamatriz2(9,2)= "'"+ALLTRIM(&pdetafactu..unidadfc)+"'"
		lamatriz2(10,1)='detalle'
		lamatriz2(10,2)= "'"+ALLTRIM(&pdetafactu..detalle)+"'"
		lamatriz2(11,1)='unitario'
		lamatriz2(11,2)= ALLTRIM(STR(&pdetafactu..unitario,13,4))
		lamatriz2(12,1)='impuestos'
		lamatriz2(12,2)= ALLTRIM(STR(&pdetafactu..impuestos,13,4))
		lamatriz2(13,1)='total'
		lamatriz2(13,2)= ALLTRIM(STR(&pdetafactu..total,13,4))
		lamatriz2(14,1)='codigocta'
		lamatriz2(14,2)= "'"+ALLTRIM(&pdetafactu..codigocta)+"'"
		lamatriz2(15,1)='nombrecta'
		lamatriz2(15,2)= "'"+ALLTRIM(&pdetafactu..nombrecta)+"'"
		lamatriz2(16,1)='cuota'
		lamatriz2(16,2)= ALLTRIM(STR(&pdetafactu..cuota))
		lamatriz2(17,1)='cantcuotas'
		lamatriz2(17,2)= ALLTRIM(STR(&pdetafactu..cantcuotas))
		lamatriz2(18,1)='padron' 
		lamatriz2(18,2)= ALLTRIM(STR(&pdetafactu..padron))
		lamatriz2(19,1)='impuesto'
		lamatriz2(19,2)= ALLTRIM(STR(0))
		lamatriz2(20,1)='razonimp'
		lamatriz2(20,2)= ALLTRIM(STR(&pdetafactu..razon,13,4))
		lamatriz2(21,1)='neto'
		lamatriz2(21,2)= ALLTRIM(STR(&pdetafactu..neto,13,4))
		lamatriz2(22,1)='idcuotasd'
		lamatriz2(22,2)= ALLTRIM(STR(&pdetafactu..idcuotasd,13,4))


		p_tabla     = 'detafactutmp'
		p_matriz    = 'lamatriz2'
		p_conexion  = vconeccionFa 
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
		ENDIF						

		SELECT &pdetafactu
		SKIP 
	ENDDO 

	
	SELECT &pfacturasimp
	GO TOP 
	DIMENSION lamatriz3(8,2)
	DO WHILE !EOF() 
	
		lamatriz3(1,1)='idfactura'
		lamatriz3(1,2)= ALLTRIM(STR(&pfacturasimp..idfactura))
		lamatriz3(2,1)= 'impuesto'
		lamatriz3(2,2)= ALLTRIM(STR(&pfacturasimp..impuesto))
		lamatriz3(3,1)= 'detalle'
		lamatriz3(3,2)= "'"+ALLTRIM(&pfacturasimp..detalle)+"'"
		lamatriz3(4,1)= 'neto'
		lamatriz3(4,2)= ALLTRIM(STR(&pfacturasimp..neto,13,4))
		lamatriz3(5,1)= 'razon'
		lamatriz3(5,2)= ALLTRIM(STR(&pfacturasimp..razon,13,4))
		lamatriz3(6,1)= 'importe'
		lamatriz3(6,2)= ALLTRIM(STR(&pfacturasimp..importe,13,4))
		lamatriz3(7,1)= 'articulo'
		lamatriz3(7,2)= "'"+ALLTRIM(&pfacturasimp..articulo)+"'"
		lamatriz3(8,1)= 'idconcepto'
		lamatriz3(8,2)= ALLTRIM(STR(&pfacturasimp..idconcepto))
					
		p_tabla     = 'facturasimptmp'
		p_matriz    = 'lamatriz3'
		p_conexion  = vconeccionFa 
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
		ENDIF

		SELECT &pfacturasimp
		SKIP 		
	ENDDO 		


	SELECT &pbocaservi
	GO TOP 
	DIMENSION lamatriz4(19,2)
	DO WHILE !EOF() 
	
		lamatriz4(1,1)='idfacbser'
		lamatriz4(1,2)= "0"
		lamatriz4(2,1)= 'idfactura'
		lamatriz4(2,2)= ALLTRIM(STR(&pbocaservi..idfactura))
		lamatriz4(3,1)= 'bocanumero'
		lamatriz4(3,2)= "'"+ALLTRIM(&pbocaservi..bocanumero)+"'"
		lamatriz4(4,1)= 'ruta1'
		lamatriz4(4,2)= ALLTRIM(STR(&pbocaservi..ruta1))
		lamatriz4(5,1)= 'folio1'
		lamatriz4(5,2)= ALLTRIM(STR(&pbocaservi..folio1))
		lamatriz4(6,1)= 'ruta2'
		lamatriz4(6,2)= ALLTRIM(STR(&pbocaservi..ruta2))
		lamatriz4(7,1)= 'folio2'
		lamatriz4(7,2)= ALLTRIM(STR(&pbocaservi..folio2))
		lamatriz4(8,1)= 'ubicacion'
		lamatriz4(8,2)= "'"+ALLTRIM(&pbocaservi..ubicacion)+"'"
		lamatriz4(9,1)= 'direccion'
		lamatriz4(9,2)= "'"+ALLTRIM(&pbocaservi..direccion)+"'"
		lamatriz4(10,1)= 'idtiposer'
		lamatriz4(10,2)= ALLTRIM(STR(&pbocaservi..idtiposer))
		lamatriz4(11,1)= 'valorref'
		lamatriz4(11,2)= ALLTRIM(STR(&pbocaservi..valorref,12,2))
		lamatriz4(12,1)= 'unidadref'
		lamatriz4(12,2)= "'"+ALLTRIM(&pbocaservi..unidadref)+"'"
		lamatriz4(13,1)= 'manterior'
		lamatriz4(13,2)= ALLTRIM(STR(&pbocaservi..manterior,12,2))
		lamatriz4(14,1)= 'mactual'
		lamatriz4(14,2)= ALLTRIM(STR(&pbocaservi..mactual,12,2))
		lamatriz4(15,1)= 'consextra'
		lamatriz4(15,2)= ALLTRIM(STR(&pbocaservi..consextra,12,2))
		lamatriz4(16,1)= 'consumo'
		lamatriz4(16,2)= ALLTRIM(STR(&pbocaservi..consumo,12,2))
		lamatriz4(17,1)= 'idcateser'
		lamatriz4(17,2)= ALLTRIM(STR(&pbocaservi..idcateser))
		lamatriz4(18,1)= 'dataextra'
		lamatriz4(18,2)= "'"+ALLTRIM(&pbocaservi..dataextra)+"'"
		lamatriz4(19,1)= 'factorm'
		lamatriz4(19,2)= ALLTRIM(STR(&pbocaservi..factorm,12,2))

						
		p_tabla     = 'facturasbsertmp'
		p_matriz    = 'lamatriz4'
		p_conexion  = vconeccionFa 
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
		ENDIF

		SELECT &pbocaservi
		SKIP 		
	ENDDO 		

	
	RELEASE lamatriz1
	RELEASE lamatriz2
	RELEASE lamatriz3
	RELEASE lamatriz4
	
	RETURN 
	
ENDFUNC 	



	
FUNCTION CtrlFcPeriodo
PARAMETERS pa_idperiodo
*#/----------------------------------------
*/** Controla la Facturación de un Perido para informar el Estado de la Misma. 
*/** Valores Retornados 
*/		0-No Se han Seleccionado Entidades a Facturar para el Periodo 		
*/		1-No Generado
*/ 		2-Generado y Pendiente de Confirmar (No pasado a Facturación)
*/ 		3-Generado y Confirmado, (Pasado a Facturacion)
*/		4-No existe el Lote a Facturar Solicitado
*#/----------------------------------------
	vretorno = 0
	vconexx=abreycierracon(0,_SYSSCHEMA)	


	sqlmatriz(1)="Select * from factulotes where idperiodo = "+STR(pa_idperiodo)
	verror=sqlrun(vconexx,"factulotes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Lotes del Período a Facturar ",0+48+0,"Error")
	ENDIF 
	SELECT factulotes_sql
	IF EOF()
		USE 
		vretorno = "4-No Existe el Lote a Facturar Solicitado "
		=abreycierracon(vconexx,"")
		RETURN vretorno 
	ELSE 
		IF factulotes_sql.confirmado = 'S' THEN 
			USE 
			vretorno = "3-Generado y Confirmado.(Pasado a Facturacion)"
			=abreycierracon(vconexx,"")
			RETURN vretorno 
		ENDIF 
	ENDIF 


	sqlmatriz(1)="Select idperiodo from facturas where idperiodo = "+ALLTRIM(STR(pa_idperiodo))+" limit 1 "
	verror=sqlrun(vconexx,"facturas_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA Facturas del Período ",0+48+0,"Error")
	ENDIF 
	SELECT facturas_sql
	IF !EOF()
		USE 
		vretorno = "3-Generado y Confirmado.(Pasado a Facturacion)"
		=abreycierracon(vconexx,"")
		RETURN vretorno 
	ENDIF 


	sqlmatriz(1)="Select * from factulotese where idperiodo = "+STR(pa_idperiodo)+" limit 1 "
	verror=sqlrun(vconexx,"factulotese_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Entidades a Facturar del Período a Facturar ",0+48+0,"Error")
	ENDIF 
	SELECT factulotese_sql
	IF EOF()
		USE 
		vretorno = "0-No Se han Seleccionado Entidades a Facturar para el Periodo"
		=abreycierracon(vconexx,"")
		RETURN vretorno 
	ENDIF 
	
	
	sqlmatriz(1)="Select idperiodo from facturastmp where idperiodo = "+STR(pa_idperiodo)+" limit 1 "
	verror=sqlrun(vconexx,"facturastmp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA FacturasTmp del Período ",0+48+0,"Error")
	ENDIF 
	SELECT facturastmp_sql
	IF EOF()
		vretorno = "1-No Generado"
	ELSE 
		vretorno = "2-Generado y Pendiente de Confirmar (No pasado a Facturación)"
	ENDIF 
	USE 
	=abreycierracon(vconexx,"")
	RETURN vretorno

ENDFUNC 
	
	
	
	
FUNCTION ConfFcPeriodo
PARAMETERS pcon_idperiodo
*#/----------------------------------------
*/** Confirma el Período Facturado , pasa de la tabla de facturas tmporarias 
*/   a la tabla de facturas finales. 
*/  pasa 5 tablas : facturas -  detafactu - facturasimp - facturasbser - facturasd
*/
*#/----------------------------------------
	vretorno = 0
	
	* Calculo los valores para incertar los idregistros en facturacion 
	idfactura_ini = maxnumeroidx("idfactura","I","facturas",0) + 1

	idfacturah_ini = maxnumeroidx("idfacturah","I","detafactu",0) +1

	idestadosreg_ini = maxnumeroidx("idestadosreg","I","estadosreg",0) +1


	vcone=abreycierracon(0,_SYSSCHEMA)	


	sqlmatriz(1)=" create temporary table factutmpt as ( select * from facturastmp  where idperiodo = "+STR(pcon_idperiodo)+" )"
	verror=sqlrun(vcone,"facturastmpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	sqlmatriz(1)=" create temporary table detatmpt as ( select * from detafactutmp  where idfactura in "
	sqlmatriz(2)=" ( select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" ) ) "
	verror=sqlrun(vcone,"detafactutmpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Detalles Temporarios del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	sqlmatriz(1)=" create temporary table imputmpt as ( select * from facturasimptmp  where idfactura in "
	sqlmatriz(2)=" ( select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" ) ) "
	verror=sqlrun(vcone,"imputmpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Impuestos Temporarios del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	sqlmatriz(1)=" create temporary table bsertmpt as ( select * from facturasbsertmp  where idfactura in "
	sqlmatriz(2)=" ( select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" ) ) "
	verror=sqlrun(vcone,"bsertmpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Impuestos Boca de Servicios del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	sqlmatriz(1)=" create temporary table dtmpt as ( select * from facturasdtmp  where idfactura in "
	sqlmatriz(2)=" ( select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" ) ) "
	verror=sqlrun(vcone,"dtmpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Adeudadas Asociadas a la Cuenta ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	* Obtengo los Minimos y Maximos de los id de facturas y de Detalles de Facturas 
	sqlmatriz(1)=" select COUNT(1) as registros, MAX(idfactura) as maxid, MIN(idfactura) as minid from  factutmpt "
	verror=sqlrun(vcone,"cantidadfc_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	SELECT cantidadfc_sql 


	sqlmatriz(1)=" select COUNT(1) as registros, MAX(idfacturah) as maxidh, MIN(idfacturah) as minidh from  detatmpt "
	verror=sqlrun(vcone,"cantidaddh_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	SELECT cantidaddh_sql 

	
	var_cantidadfc = IIF(TYPE('cantidadfc_sql.registros')='C',VAL(cantidadfc_sql.registros),cantidadfc_sql.registros)
	var_maxid	   = cantidadfc_sql.maxid
	var_minid	   = cantidadfc_sql.minid

	var_cantidaddh = IIF(TYPE('cantidaddh_sql.registros')='C',VAL(cantidaddh_sql.registros),cantidaddh_sql.registros)
	var_maxidh	   = cantidaddh_sql.maxidh
	var_minidh	   = cantidaddh_sql.minidh
	
	* Corrijo idfactura en el temporario de Factura
	sqlmatriz(1)=" update factutmpt set idfactura = idfactura + ( "+STR(idfactura_ini)+" - "+STR(var_minid)+" )"
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 


	* Corrijo idfactura en el temporario de Detalle de Factura
	sqlmatriz(1)=" update detatmpt set idfactura = idfactura + ( "+STR(idfactura_ini)+" - "+STR(var_minid)+" ), idfacturah = idfacturah + ( "+STR(idfacturah_ini)+" - "+STR(var_minidh)+") "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	* Corrijo idfactura en el temporario de Impuestos de Facturas 
	sqlmatriz(1)=" update imputmpt set idfactura = idfactura + ( "+STR(idfactura_ini)+" - "+STR(var_minid)+" ) "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	* Corrijo idfactura en el temporario de Bocas de Servicios de Facturas 
	sqlmatriz(1)=" update bsertmpt set idfactura = idfactura + ( "+STR(idfactura_ini)+" - "+STR(var_minid)+" ) "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 


	* Corrijo idfactura en el temporario de Facturas Adeudadas asociadas a la facturacion actual 
	sqlmatriz(1)=" update dtmpt set idfactura = idfactura + ( "+STR(idfactura_ini)+" - "+STR(var_minid)+" ) "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del facturasdtmp con deuda de facturas ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	* Corrijo la Numeracion de la Factura en el temporario de Facturas
	*************************************************************************
	*************************************************************************
	*/ Actualizacion de Numeros de Facturas */
	*sqlmatriz(1)=" select idcomproba, pventa, COUNT(1) as registros, MAX(numero) as maxnum, MIN(numero) as minnum, concat(idcomproba,pventa) as orden from  factutmpt  group by orden "
	sqlmatriz(1)=" select  f.idcomproba, f.pventa, COUNT(1) as registros, MAX(f.numero) as maxnum, MIN(f.numero) as minnum, c.maxnumero, "
	sqlmatriz(2)=" concat(f.idcomproba,f.pventa) as orden from  factutmpt f left join compactiv c on f.idcomproba = c.idcomproba and f.pventa = c.pventa  group by orden	"
	verror=sqlrun(vcone,"cantidadnu_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA Cantidades de Numeros de Facturas ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	SELECT cantidadnu_sql 
	GO TOP 

	DO WHILE !EOF()
		var_cantidadnu = IIF(TYPE('cantidadnu_sql.registros')='C',VAL(cantidadnu_sql.registros),cantidadnu_sql.registros)
	

		var_maxinum	   = IIF(TYPE('cantidadnu_sql.maxnum')='C',VAL(cantidadnu_sql.maxnum),cantidadnu_sql.maxnum) 
		var_mininum	   = IIF(TYPE('cantidadnu_sql.minnum')='C',VAL(cantidadnu_sql.minnum),cantidadnu_sql.minnum) 
		numero_ini	   = IIF(ISNULL(cantidadnu_sql.maxnumero),0,cantidadnu_sql.maxnumero) + 1

		* Corrijo numero de factura  temporario de Factura
		sqlmatriz(1)=" update factutmpt set numero = numero + ( "+STR(numero_ini)+" - "+STR(var_mininum)+" ) where idcomproba = "+STR(cantidadnu_sql.idcomproba)+" and pventa = "+STR(cantidadnu_sql.pventa)
		verror=sqlrun(vcone,"selfcpt_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		ENDIF 

		SELECT cantidadnu_sql 
		SKIP 
	ENDDO 

	

********************************************************************************
	** Iserto desde las tablas temporarias en facturas, detafactu, facturasimp, facturasbser, facturasd, entidadesdc

	sqlmatriz(1)=" insert into facturas ( idfactura, idcomproba, pventa, numero, tipo, fecha, entidad, servicio, cuenta, apellido, "
	sqlmatriz(2)=" nombre, direccion, localidad, iva, cuit, tipodoc, dni, telefono, cp, fax, email, transporte, nomtransp, direntrega, "
	sqlmatriz(3)=" stock, idtipoopera, neto, subtotal, descuento, recargo, total, totalimpu, operexenta, anulado, observa1, observa2, "
	sqlmatriz(4)=" observa3, observa4, idperiodo, ruta1, folio1, ruta2, folio2, fechavenc1, fechavenc2, fechavenc3, proxvenc, confirmada, "
	sqlmatriz(5)=" astoconta, deudacta, cespcae, caecespven, vendedor, identidadh, interesd, idtipocli )"
	sqlmatriz(6)=" select idfactura, idcomproba, pventa, numero, tipo, fecha, entidad, servicio, cuenta, apellido, "
	sqlmatriz(7)=" nombre, direccion, localidad, iva, cuit, tipodoc, dni, telefono, cp, fax, email, transporte, nomtransp, direntrega, "
	sqlmatriz(8)=" stock, idtipoopera, neto, subtotal, descuento, recargo, total, totalimpu, operexenta, anulado, observa1, observa2, "
	sqlmatriz(9)=" observa3, observa4, idperiodo, ruta1, folio1, ruta2, folio2, fechavenc1, fechavenc2, fechavenc3, proxvenc, confirmada, "
	sqlmatriz(10)=" astoconta, deudacta, cespcae, caecespven, vendedor, identidadh, interesd, idtipocli from factutmpt  "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 


	sqlmatriz(1)=" insert into detafactu ( idfacturah, idfactura, articulo, idconcepto, servicio, cantidad, unidad, cantidadfc, unidadfc, "
	sqlmatriz(2)=" detalle, unitario, impuestos, total, codigocta, nombrecta, cuota, cantcuotas, padron, impuesto, razonimp, neto, idcuotasd ) "
	sqlmatriz(3)=" select  idfacturah, idfactura, articulo, idconcepto, servicio, cantidad, unidad, cantidadfc, unidadfc, "
	sqlmatriz(4)=" detalle, unitario, impuestos, total, codigocta, nombrecta, cuota, cantcuotas, padron, impuesto, razonimp, neto, idcuotasd from detatmpt  "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

*!*		  *corrijo en el detalle de las cuotas facturadas si hubiere el vinculo con la factura generada 
	sqlmatriz(1)=" select idfactura, idcuotasd from detatmpt where idcuotasd > 0   "
	verror=sqlrun(vcone,"selctast_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Cuotas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	SELECT selctast_sql 
	GO TOP 
	DO WHILE !EOF()
		sqlmatriz(1)=" update entidadesdc set idfactura= "+ALLTRIM(STR(selctast_sql.idfactura))+" where idcuotasd = "+ALLTRIM(STR(selctast_sql.idcuotasd))
		verror=sqlrun(vcone,"selctast_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Cuotas Temporarias del Período a Facturar ",0+48+0,"Error")
			=abreycierracon(vcone,"")
			RETURN vretorno	
		ENDIF 
		SELECT selctast_sql 
		SKIP 
	ENDDO 
	USE IN selctast_sql 
	
	

	sqlmatriz(1)=" insert into facturasimp ( idfactura, impuesto, detalle, neto, razon, importe, articulo, idconcepto ) "
	sqlmatriz(2)=" select idfactura, impuesto, detalle, neto, razon, importe, articulo, idconcepto from imputmpt  "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 


	sqlmatriz(1)=" insert into facturasbser ( idfacbser, idfactura, bocanumero, ruta1, folio1, ruta2, folio2, ubicacion, direccion, idtiposer, valorref, unidadref, manterior, mactual, consextra, consumo, idcateser,dataextra,factorm ) "
	sqlmatriz(2)=" select 0 as idfacbser, idfactura, bocanumero, ruta1, folio1, ruta2, folio2, ubicacion, direccion, idtiposer, valorref, unidadref, manterior, mactual, consextra, consumo, idcateser, dataextra, factorm from bsertmpt  "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 


	sqlmatriz(1)=" insert into facturasd ( idfacturad, idfactura, idfcdeuda, importe, detalle ) "
	sqlmatriz(2)=" select 0 as idfacbser, idfactura, idfcdeuda, importe, detalle from dtmpt  "
	verror=sqlrun(vcone,"selfcpt_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Adeudadas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	*/***************************************
	*/ Registro el Estado de la Factura Confirmada de acuerdo a su tipo 
	*/ Si el punto de Venta es Electronico queda "PENDIENTE AUTORIZACION"
	*/ En otro caso queda "AUTORIZADO"

	sqlmatriz(6)=" select * from puntosventa where pventa in ( select pventa from factutmpt ) "
	verror=sqlrun(vcone,"ptoVta_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Puntos de Venta ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	SELECT ptoVta_sql 
	GO TOP 
	IF ptoVta_sql.electronica = 'S'
		v_estador = "PENDIENTE AUTORIZACION"		
	ELSE
		v_estador = "AUTORIZADO"
	ENDIF 
	sqlmatriz(6)=" select * from estadosr where nombre = '"+ALLTRIM(v_estador)+"'"
	verror=sqlrun(vcone,"estador_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Estados de Registros ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	SELECT estador_sql 
	GO TOP 
	v_idestador = estador_sql.idestadosr

	sqlmatriz(1)=" select COUNT(1) as registros, MAX(idfactura) as maxidr, MIN(idfactura) as minidr from  factutmpt "
	verror=sqlrun(vcone,"cantidadre_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	SELECT cantidadre_sql
	var_cantidadre = IIF(TYPE('cantidadre_sql.registros')='C',VAL(cantidadre_sql.registros),cantidadre_sql.registros)
	var_maxidr	   = cantidadre_sql.maxidr
	var_minidr	   = cantidadre_sql.minidr


	sqlmatriz(1)=" create temporary table estatmpt as ( select ( idfactura + ( "+STR(idestadosreg_ini )+" - "+STR(var_minidr)+" )) as idestadosreg, 'facturas' as tabla,  'idfactura' as campo, "
	sqlmatriz(2)=" idfactura as id, "+STR(v_idestador)+" as idestador, 'I' as tipo, '"+DTOS(DATE())+TIME()+"' as fecha "
	sqlmatriz(3)=" from factutmpt ) "
	verror=sqlrun(vcone,"estatmp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en el Armado de estados Temporarios  ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	

	sqlmatriz(1)=" insert into estadosreg ( idestadosreg, tabla, campo, id, idestador, tipo, fecha ) "
	sqlmatriz(2)=" select idestadosreg, tabla, campo, id, idestador, tipo, fecha from estatmpt "
	verror=sqlrun(vcone,"estadosreg_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas Temporarias del Período a Facturar ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	

	************* Actualizo el maximo numero de los comprobantes para cada punto de venta y comprobante facturado 
	SELECT cantidadnu_sql 
	GO TOP 
	DO WHILE !EOF()
		var_cantidadnu = IIF(TYPE('cantidadnu_sql.registros')='C',VAL(cantidadnu_sql.registros),cantidadnu_sql.registros)

		sqlmatriz(1)=" update compactiv set maxnumero = maxnumero + "+STR(var_cantidadnu)+"  where idcomproba = "+STR(cantidadnu_sql.idcomproba)+" and pventa = "+STR(cantidadnu_sql.pventa)
		verror=sqlrun(vcone,"actual_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del Maximo Numero de Comprobante por punto de venta ",0+48+0,"Error")
		ENDIF 
		
		SELECT cantidadnu_sql 
		SKIP 
	ENDDO 

	*/**************************************
	*/ Coloco Confirmado el Lote de Facturacion ya que se pasaron todas las Facturas 

	sqlmatriz(1)=" update factulotes set confirmado = 'S' where idperiodo = "+STR(pcon_idperiodo)
	verror=sqlrun(vcone,"confirma_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error Al Confirmar el Lote de Facturacion  ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	
	*/**************************************
	*/ Elimino las facturas de los archivos Temporarios para el lote confirmado despues de terminar 
	** 
	sqlmatriz(1)="delete from  facturasbsertmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" )"
	verror=sqlrun(vcone,"elim_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de FacturasbserTmp ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	sqlmatriz(1)="delete from  facturasdtmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" )"
	verror=sqlrun(vcone,"elim_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de FacturasdTmp ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	sqlmatriz(1)="delete from  facturasimptmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" )"
	verror=sqlrun(vcone,"elim_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de FacturasImpTmp ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	
	sqlmatriz(1)="delete from  detafactutmp where idfactura in (select idfactura from facturastmp where idperiodo = "+STR(pcon_idperiodo)+" )"
	verror=sqlrun(vcone,"elim_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de detfactuTmp ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 

	sqlmatriz(1)="delete from  facturastmp where idperiodo = "+STR(pcon_idperiodo)
	verror=sqlrun(vcone,"elim_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de FacturasTmp  ",0+48+0,"Error")
		=abreycierracon(vcone,"")
		RETURN vretorno	
	ENDIF 
	*******************************************************************************	


	=abreycierracon(vcone,"")
	
	* Calculo los valores para incertar los idregistros en facturacion 
	idfactura_fin 	 = maxnumeroidx("idfactura","I","facturas",var_cantidadfc) 
	idfacturah_fin 	 = maxnumeroidx("idfacturah","I","detafactu",var_cantidaddh ) 
	idestadosreg_fin = maxnumeroidx("idestadosreg","I","estadosreg",var_cantidadre ) 

	USE IN cantidadfc_sql
	USE IN cantidaddh_sql
	USE IN cantidadnu_sql
	USE IN ptoVta_sql 
	USE IN estador_sql
	USE IN cantidadre_sql


	RETURN vretorno

ENDFUNC 	



FUNCTION AutoFcPeriodo
PARAMETERS paut_idperiodo
*#/----------------------------------------
*/** Si los comprobantes del Perido pasado son Electrónicos
*/   Pide la Autorización al Afip para cada uno de los Comprobantes
*/   del Período pasado como parametro, siempre y cuando sean de un 
*/   Punto de Venta Electrónico
*#/----------------------------------------

	vretorno = 0
	vconectar=abreycierracon(0,_SYSSCHEMA)	

	
*!*		tipoComproObj 	= CREATEOBJECT('tiposcomproclass')
*!*		tipoOpObj		= CREATEOBJECT('tipooperacionclass')
*!*		oeObj			= CREATEOBJECT('oeclass')
	estObj	= CREATEOBJECT('estadosclass')
*!*		tipoMStockobj	= CREATEOBJECT('tipomstockclass')
	estAnulado    = estObj.getIDestado("ANULADO")
	estAutorizado = estObj.getIDestado("AUTORIZADO")
	RELEASE estObj
	
	sqlmatriz(1)=" Select f.* from facturas f left join ultimoestado u on f.idfactura = u.id "
	sqlmatriz(2)=" left join puntosventa p on p.pventa = f.pventa "
	sqlmatriz(3)=" where f.idperiodo = "+STR(paut_idperiodo)
	sqlmatriz(4)=" and u.tabla = 'facturas' and p.electronica = 'S' and  u.idestador <> "+ALLTRIM(str(estAnulado))+" and u.idestador <> "+ALLTRIM(str(estAutorizado))
	
	verror=sqlrun(vconectar,"facturase_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Facturas a Autorizar ",0+48+0,"Error")
	ENDIF 
	=abreycierracon(vconectar,"")
	SELECT facturase_sql
	GO TOP 
	vcomproautorizado = .t. 
	DO WHILE !EOF() AND vcomproautorizado = .t. 
	
*!*			v_puntovta 	 = thisform.puntovta
		v_id_factura = facturase_sql.idfactura 
		
		vcomproautorizado =   autorizarCompFE(v_id_factura, .F. )
		
		SELECT facturase_sql 
		SKIP 
	ENDDO 
	=abreycierracon(vconectar,"")
	RETURN vretorno
ENDFUNC 





FUNCTION QuitaDNoMensual
*#/----------------------------------------
*/** Elimina los conceptos cargados y que no son Mensualizados es decir MENSUAL = 'N'
*/   Consulta al operador antes de eliminarlos y solo elimina aquellos que pertenecen al lote pasado como parámetro
*/   No se eliminan aquellos que tienen cuotas por mas que sean no mensualizados
*#/----------------------------------------
PARAMETERS p_idperiodo

	IF  MESSAGEBOX("Se Eliminarán los Conceptos Facturados NO MENSUALIZADOS del Lote ..."+CHR(13)+"Esta operación no se puede revertir..."+CHR(13)+" ¿ Desea Continuar con la Eliminación ?",4+48+256,"Eliminar Detalles No Mensualizados") = 7 THEN 
		RETURN 
	ENDIF 
	
	WAIT windows "Aguarde..." NOWAIT 
	
	vconeccion = abreycierracon(0,_SYSSCHEMA)


	sqlmatriz(1)=" create temporary table deletenmes as ( select dd.identidadd from factulotese e left join entidadesd dd on dd.identidadh = e.identidadh "
	sqlmatriz(3)="  where e.idperiodo = "+STR(p_idperiodo)+" and dd.mensual = 'N' )"
	verror=sqlrun(vconeccion ,"deletemes")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Creacion de Tablas Temporarioas para Eliminar Registros ",0+48+0,"Error")
		=abreycierracon(vconeccion,"")
		RETURN 	
	ENDIF 


	* Traigo los detalles de las Entidades h que están en el Lote pasado como parametro 
	sqlmatriz(1)=" delete from entidadesd where identidadd in "
	sqlmatriz(2)=" ( select identidadd from deletenmes ) and identidadd not in ( select identidadd from entidadesdc )"
	verror=sqlrun(vconeccion,"deletenm_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA Detalles para Eliminar no Mensuales ",0+48+0,"Error")
	ENDIF 


 	=abreycierracon(vconeccion,"")
WAIT CLEAR 


ENDFUNC 



FUNCTION FModificaFuncion
*#/----------------------------------------
*/* Modifica la Llamada a la función para ajustar a ejecucion
*/* Convierte en Parametros los stings pasados de mas de 255 caracteres
*#/----------------------------------------
PARAMETERS p_Fmodificar
	
	vfunc = ""
	vparametro = ""
	vcanvar 	= 0
	vagregar  	= 0
	vabrecomilla = 0
	FOR ifmv = 1 TO LEN(p_Fmodificar) 
		
		IF SUBSTR(p_Fmodificar,ifmv,1) = '"' THEN 
			IF vabrecomilla = 0 THEN 
				vabrecomilla = 1 
				vagregar = 1
				vcanvar = vcanvar + 1
				eje = "public fvar"+ALLTRIM(STR(vcanvar))
				&eje
				eje = "fvar"+ALLTRIM(STR(vcanvar))+"= ''"
				&eje
			ELSE
				vabrecomilla = 0 
			ENDIF 	
		ENDIF 
		
		IF vabrecomilla = 0 THEN 
			IF !(SUBSTR(p_Fmodificar,ifmv,1)='"')
				vfunc = vfunc+SUBSTR(p_Fmodificar,ifmv,1)	
			ENDIF 
		ELSE
			IF vagregar = 1 THEN 
				vfunc = vfunc+"fvar"+ALLTRIM(STR(vcanvar))	
				vagregar = 0			
			ENDIF 
			IF !(SUBSTR(p_Fmodificar,ifmv,1)='"')
				eje = "fvar"+ALLTRIM(STR(vcanvar))+"= fvar"+ALLTRIM(STR(vcanvar))+" + SUBSTR(p_Fmodificar,ifmv,1)"
				&eje
			ENDIF 
		ENDIF 
	
	ENDFOR 

	vreturnf = SUBSTR(ALLTRIM(STR(vcanvar+100)),2,2)+vfunc
	RETURN vreturnf
	
ENDFUNC 