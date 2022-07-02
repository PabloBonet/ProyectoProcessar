
**** INICIO FUNCION ANULAR TRANSFERENCIAS **************

**********************************************************
** FUNCIÓN para anular Trasferencias Bancarias
** Parametros: pIdRegistro: Id del registro de la tabla Transferencias que se desea anular.
** Retorno: Retorna ID del registro de anulación. 0 en caso que no se haya registrado
**********************************************************

FUNCTION AnularTransfe
PARAMETERS pIdregistro

	v_retornocie = 0

	vconeccionAn = abreycierracon(0,_SYSSCHEMA)
	
	** Valido que no estè anulado **
	sqlmatriz(1)=" select * from transferencias c left join linkcompro l on c.idcomproba = l.idcomprobaa and c.idtransfe = l.idregistroa  "
	sqlmatriz(2)=" where l.idregistroa = "+ALLTRIM(STR(pIdregistro))+" or l.idregistrob = "+ALLTRIM(STR(pIdregistro)) 
	verror=sqlrun(vconeccionAn ,"validaAnul")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del comprobante a anular ",0+48+0,"Error")
		=abreycierracon(vconeccionAn ,"")	
	    RETURN -1  
	ENDIF	 
	SELECT validaAnul
	GO TOP 
	
	IF NOT EOF()
		MESSAGEBOX("El comprobante ya se encuentra anulado",0+48+0,"Error")
		=abreycierracon(vconeccionAn ,"")	
	    RETURN -1 
	
	ENDIF 
	
	
	**** Obtengo los comprobantes ***
	
	sqlmatriz(1)=" select idtipocompro as idtipocom, idcomproba from comprobantes "
									
	verror=sqlrun(vconeccionAn ,"comprobantes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda los comprobantes",0+48+0,"Error")
		=abreycierracon(vconeccionAn ,"")	
	    RETURN -1
	ENDIF
	
	sqlmatriz(1)=" select c.*,t.opera, t.idtipocompro as idtipocomp from transferencias c left join comprobantes o on c.idcomproba = o.idcomproba "
	sqlmatriz(2)=" left join tipocompro t on o.idtipocompro = t.idtipocompro " 
	sqlmatriz(3)=" where idtransfe = "+ALLTRIM(STR(pIdregistro)) 
	verror=sqlrun(vconeccionAn ,"transfeA")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del comprobante a anular ",0+48+0,"Error")
		=abreycierracon(vconeccionAn ,"")	
	    RETURN -1  
	ENDIF	 

	SELECT transfeA
	GO TOP

	IF !EOF() THEN 
		
		v_idcomproba = transfeA.idcomproba
		v_idregistro = pIdregistro
		v_idtipocomp = transfeA.idtipocomp
		
		* Obtengo el detalle de la Transferencia a anular
		sqlmatriz(1)=" select t.*, h.idcajareca, h.fecha, h.hora, tp.idtipocompro, tp.operac as opera, tp.idtipocompro as idtipocomp "
		sqlmatriz(2)=" from transferencias t left join cajarecaudah h on t.idcomproba = h.idcomproba and t.idtransfe = h.idregicomp left join comprobantes cp on cp.idcomproba   = t.idcomproba "
		sqlmatriz(3)=" left join tipocompro   tp on tp.idtipocompro = cp.idtipocompro "
		sqlmatriz(4)=" where t.idcomproba = "+ALLTRIM(STR(v_idcomproba))+" and t.idtransfe = "+ALLTRIM(STR(v_idregistro))
		
										
		verror=sqlrun(vconeccionAn ,"detallecp")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del detalle de cobros ",0+48+0,"Error")
			=abreycierracon(vconeccionAn ,"")	
		    RETURN -1
		ENDIF
		SELECT detallecp
		GO TOP 
		CALCULATE SUM(importe) TO v_importeAn
		
		
		
		SELECT detallecp
		GO TOP 

	
		v_opera = transfeA.opera

		sqlmatriz(1)=" SELECT d.*,c.idregistro as idreg,m.idtipocompro as idtipocomp FROM detallecobros d left join cobropagolink c on d.iddetacobro = c.registrocp and c.tablacp = 'detallecobros' "
		sqlmatriz(2)= " and c.campocp = 'iddetacobro' left join comprobantes m on d.idcomproba = m.idcomproba "
		sqlmatriz(3)="  where d.idcomproba = "+ALLTRIM(STR(v_idcomproba))+" and d.idregistro = "+ALLTRIM(STR(v_idregistro)) 
		verror=sqlrun(vconeccionAn,"detacobrotr_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de detalle de movimientos",0+48+0,"Error")
		ENDIF 

		sqlmatriz(1)=" SELECT d.*,c.idregistro as idreg,m.idtipocompro as idtipocomp FROM detallepagos  d left join cobropagolink c on d.iddetapago = c.registrocp and c.tablacp = 'detallepagos' "
		sqlmatriz(2)= " and c.campocp = 'iddetapago'  left join comprobantes m on d.idcomproba = m.idcomproba " 
		sqlmatriz(3)= " where d.idcomproba = "+ALLTRIM(STR(v_idcomproba))+" and d.idregistro = "+ALLTRIM(STR(v_idregistro))	
		verror=sqlrun(vconeccionAn,"detapagotr_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de detalle de movimientos",0+48+0,"Error")
		ENDIF 

		

		SELECT detacobrotr_sql
		GO TOP 

		v_idtransfe = 0
		v_fecha 		 		= dtos(DATE())
		v_transfe_importe 		= transfeA.importe
		v_transfe_idcomproba 	= transfeA.idcomproba
		v_transfe_pventa 		= transfeA.pventa
		v_transfe_numero 		= maxnumerocom(v_transfe_idcomproba ,v_transfe_pventa ,1)
		v_transfe_comprobante	= transfeA.comprobante
		v_transfe_idcuentao 	= transfeA.idcuentao
		v_transfe_idcuentad 	= transfeA.idcuentad
		v_transfe_observa 		= "- ANULA TRANSFERENCIA "+STRTRAN(STR(transfeA.numero,8),' ','0')+" - "+ALLTRIM(transfeA.observa)
		v_tablaPor= 'transferencias' 		
				

		DIMENSION lamatriz8(10,2)
				 
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'transferencias'
		p_matriz    = 'lamatriz8'
		p_conexion  = vconeccionAn

					
		lamatriz8(1,1)='idtransfe'
		lamatriz8(1,2)=ALLTRIM(STR(v_idtransfe))
		lamatriz8(2,1)='idcomproba'
		lamatriz8(2,2)= ALLTRIM(STR(v_transfe_idcomproba))
		lamatriz8(3,1)='pventa'
		lamatriz8(3,2)=ALLTRIM(STR(v_transfe_pventa))
		lamatriz8(4,1)='numero'
		lamatriz8(4,2)=ALLTRIM(STR(v_transfe_numero))
		lamatriz8(5,1)='fecha'
		lamatriz8(5,2)="'"+ALLTRIM(v_fecha)+"'"
		lamatriz8(6,1)='importe'
		lamatriz8(6,2)=ALLTRIM(STR(v_transfe_importe,13,2))
		lamatriz8(7,1)='comprobante'
		lamatriz8(7,2)="'"+ALLTRIM(v_transfe_comprobante)+"'"
		lamatriz8(8,1)='idcuentao'
		lamatriz8(8,2)=ALLTRIM(STR(v_transfe_idcuentad))
		lamatriz8(9,1)='idcuentad'
		lamatriz8(9,2)=ALLTRIM(STR(v_transfe_idcuentao))
		lamatriz8(10,1)='observa'
		lamatriz8(10,2)="'"+ALLTRIM(v_transfe_observa)+"'"
		
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
		    RETURN  -1
		ENDIF 


		*** Ultimo ID registrado ***
		sqlmatriz(1)="SELECT last_insert_id() as maxid "

		verror=sqlrun(p_conexion,"transfemax_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID de cajaie",0+48+0,"Error")
		ENDIF 

		SELECT transfemax_sql
		GO TOP 
	
		v_idtransfe = VAL(transfemax_sql.maxid)
		v_retornotra = v_idtransfe 
		
		
		USE in transfemax_sql

		tipoPagoObj 	= CREATEOBJECT('tipospagosclass')
			
		*** REGISTRO ESTADO AUTORIZADO PARA EL COMPROBANTE DE ANULACIÓN ***

		registrarEstado("transferencias","idtransfe",v_idtransfe,'I',"AUTORIZADO")
	
		*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
		
		guardaCajaRecaH (v_transfe_idcomproba, v_idtransfe)
			

		

		SELECT detacobrotr_sql
		GO TOP 
			
		DO WHILE NOT EOF() 
			
		**** GUARDO DATOS DE DETALLECOBRO / DETALLEPAGOS****
			
			DIMENSION lamatriz5(6,2)
			v_nombreID	= ""
			v_iddetacp 	= 0
				
			v_iddetacp 		= maxnumeroidx("iddetapago", "I","detallepagos",1)
			v_nombreID	= "iddetapago" 	
				
			IF v_iddetacp <= 0
				MESSAGEBOX("Error al registrar el detalle de cobro o pago",0+16+0,"Error al registrar el comprobante")
			ENDIF 
				
			v_detallecp_idcomproba 		= v_transfe_idcomproba 
			v_detallecp_idregi			= v_idtransfe
			v_idtipoPago 				= detacobrotr_sql.idtipopago 				
			v_detallecp_importe			= detacobrotr_sql.importe 
			id_cajabco					= detacobrotr_sql.idcuenta 
				
				
			lamatriz5(1,1)= v_nombreID
			lamatriz5(1,2)=ALLTRIM(STR(v_iddetacp))
			lamatriz5(2,1)='idcomproba'
			lamatriz5(2,2)= ALLTRIM(STR(v_detallecp_idcomproba ))
			lamatriz5(3,1)='idregistro'
			lamatriz5(3,2)= ALLTRIM(STR(v_detallecp_idregi))
			lamatriz5(4,1)=	'idtipopago'
			lamatriz5(4,2)=	ALLTRIM(STR(v_idtipoPago))		
			lamatriz5(5,1)='importe'
			lamatriz5(5,2)= ALLTRIM(STR(v_detallecp_importe,13,2))
			lamatriz5(6,1)= 'idcuenta'
			lamatriz5(6,2)= ALLTRIM(STR(id_cajabco))
				
				
			p_tipoope	= 'I'
			p_donficion = ''
			p_tabla		= "detallepagos"
		
			p_matriz    = 'lamatriz5'
			p_conexion  = vconeccionAn
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			    
			ENDIF 
			
			
			*** Guardo en COBROPAGO LINK PARA CUPONES O CHEQUES ***
				
			v_tipoPagoCupon = tipopagoObj.gettipospagos('CUPONES')
			*** Registro movitpago
			SELECT detacobrotr_sql
			v_idtipocomp = detacobrotr_sql.idtipocomp

					
			
			IF v_idtipoPago == v_tipoPagoCupon
				***GUARDA RELACION CUPON - DETALLE PAGO (EN TABLA COBROPAGOLINK)***
						
				DIMENSION lamatriz6(8,2)
				
				v_idcplink = maxnumeroidx("idcplink", "I", "cobropagolink",1)	
				v_tablacp	= "detallepagos"
				v_campocp	= "iddetapago"
				v_tabla		= "cupones"
				v_campo		= "idcupon"	
				v_idregistroD = detacobrotr_sql.idreg
				v_fecha = dtos(DATE())						
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				p_tabla     = 'cobropagolink'
				p_matriz    = 'lamatriz6'
				p_conexion  = vconeccionAn

				lamatriz6(1,1)='idcplink'
				lamatriz6(1,2)=ALLTRIM(STR(v_idcplink))
				lamatriz6(2,1)='tablacp'
				lamatriz6(2,2)="'"+v_tablacp+"'"
				lamatriz6(3,1)='campocp'
				lamatriz6(3,2)="'"+v_campocp+"'"
				lamatriz6(4,1)='registrocp'
				lamatriz6(4,2)=ALLTRIM(STR(v_iddetacp))
				lamatriz6(5,1)='tabla'
				lamatriz6(5,2)="'"+v_tabla+"'"
				lamatriz6(6,1)='campo'
				lamatriz6(6,2)="'"+v_campo+"'"
				lamatriz6(7,1)='idregistro'
				lamatriz6(7,2)=ALLTRIM(STR(v_idregistroD))
				lamatriz6(8,1)='fecha'
				lamatriz6(8,2)="'"+ALLTRIM(v_fecha)+"'"
						
					
						
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				ELSE
					v_ret = guardarMoviTPago(v_idtipoPago, v_tabla, v_campo, v_idregistroD, _SYSCAJARECA, v_transfe_idcuentao, v_idtipocomp, v_tablacp, v_campocp, v_iddetacp )
				
					IF v_ret = .F.
						MESSAGEBOX("Ha Ocurrido un Error al intentar registrar el Movimiento para el Tipo de pago",0+48+0,"Error")
					ENDIF 
				    
				ENDIF 
						
						
					
			ELSE
					
				v_tipoPagoCheque = tipopagoObj.gettipospagos('CHEQUE')	
				
				IF v_idtipoPago == v_tipoPagoCheque 
					***GUARDA RELACION CHEQUE - DETALLE PAGO (EN TABLA COBROPAGOLINK)***
								
					DIMENSION lamatriz6(8,2)
					
					v_idcplink = maxnumeroidx("idcplink", "I", "cobropagolink",1)	
					v_tablacp	= "detallepagos"
					v_campocp	= "iddetapago"
					v_tabla		= "cheques"
					v_campo		= "idcheque"	
					v_idregistroD = detacobrotr_sql.idreg
					v_fecha = dtos(DATE())
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					p_tabla     = 'cobropagolink'
					p_matriz    = 'lamatriz6'
					p_conexion  = vconeccionAn

					lamatriz6(1,1)='idcplink'
					lamatriz6(1,2)=ALLTRIM(STR(v_idcplink))
					lamatriz6(2,1)='tablacp'
					lamatriz6(2,2)="'"+v_tablacp+"'"
					lamatriz6(3,1)='campocp'
					lamatriz6(3,2)="'"+v_campocp+"'"
					lamatriz6(4,1)='registrocp'
					lamatriz6(4,2)=ALLTRIM(STR(v_iddetacp))
					lamatriz6(5,1)='tabla'
					lamatriz6(5,2)="'"+v_tabla+"'"
					lamatriz6(6,1)='campo'
					lamatriz6(6,2)="'"+v_campo+"'"
					lamatriz6(7,1)='idregistro'
					lamatriz6(7,2)=ALLTRIM(STR(v_idregistroD))
					lamatriz6(8,1)='fecha'
					lamatriz6(8,2)="'"+ALLTRIM(v_fecha)+"'"
							
							
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
					ELSE
						v_ret = guardarMoviTPago(v_idtipoPago, v_tabla, v_campo, v_idregistroD, _SYSCAJARECA, v_transfe_idcuentao, v_idtipocomp, v_tablacp, v_campocp, v_iddetacp )
				
						IF v_ret = .F.
							MESSAGEBOX("Ha Ocurrido un Error al intentar registrar el Movimiento para el Tipo de pago",0+48+0,"Error")
						ENDIF 


					ENDIF 
				ENDIF 
			ENDIF 
							
			SELECT detacobrotr_sql
			SKIP 1	
		ENDDO 

** hasta aqui la parte de detallecobros que graba en detallepagos **

		SELECT detapagotr_sql
		GO TOP 
			
		DO WHILE NOT EOF() 
			
		**** GUARDO DATOS DE DETALLECOBRO / DETALLEPAGOS****
			
			
			DIMENSION lamatriz5(6,2)
			v_nombreID	= ""
			v_iddetacp 	= 0
				
			v_iddetacp	= maxnumeroidx("iddetacobro", "I","detallecobros",1)
			v_nombreID	= "iddetacobro" 	
				
			IF v_iddetacp <= 0
				MESSAGEBOX("Error al registrar el detalle de cobro o pago",0+16+0,"Error al registrar el comprobante")
			ENDIF 
				
			v_detallecp_idcomproba 		= v_transfe_idcomproba 
			v_detallecp_idregi			= v_idtransfe
			v_idtipoPago 				= detapagotr_sql.idtipopago 				
			v_detallecp_importe			= detapagotr_sql.importe 
			id_cajabco					= detapagotr_sql.idcuenta 
				
				
			lamatriz5(1,1)= v_nombreID
			lamatriz5(1,2)=ALLTRIM(STR(v_iddetacp))
			lamatriz5(2,1)='idcomproba'
			lamatriz5(2,2)= ALLTRIM(STR(v_detallecp_idcomproba ))
			lamatriz5(3,1)='idregistro'
			lamatriz5(3,2)= ALLTRIM(STR(v_detallecp_idregi))
			lamatriz5(4,1)=	'idtipopago'
			lamatriz5(4,2)=	ALLTRIM(STR(v_idtipoPago))		
			lamatriz5(5,1)='importe'
			lamatriz5(5,2)= ALLTRIM(STR(v_detallecp_importe,13,2))
			lamatriz5(6,1)= 'idcuenta'
			lamatriz5(6,2)= ALLTRIM(STR(id_cajabco))
				
				
			p_tipoope	= 'I'
			p_donficion = ''
			p_tabla		= "detallecobros"
			
			p_matriz    = 'lamatriz5'
			p_conexion  = vconeccionAn
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			    
			ENDIF 
			
			
			*** Guardo en COBROPAGO LINK PARA CUPONES O CHEQUES ***
				
			v_tipoPagoCupon = tipopagoObj.gettipospagos('CUPONES')
				*** Registro movitpago
			SELECT detapagotr_sql
			v_idtipocomp = detapagotr_sql.idtipocomp

					
			
			IF v_idtipoPago == v_tipoPagoCupon
				***GUARDA RELACION CUPON - DETALLE PAGO (EN TABLA COBROPAGOLINK)***
						
				DIMENSION lamatriz6(8,2)
				
				v_idcplink = maxnumeroidx("idcplink", "I", "cobropagolink",1)	
				v_tablacp	= "detallecobros"
				v_campocp	= "iddetacobro"
				v_tabla		= "cupones"
				v_campo		= "idcupon"	
				v_idregistroD = detapagotr_sql.idreg
				v_fecha = dtos(DATE())						
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				p_tabla     = 'cobropagolink'
				p_matriz    = 'lamatriz6'
				p_conexion  = vconeccionAn

				lamatriz6(1,1)='idcplink'
				lamatriz6(1,2)=ALLTRIM(STR(v_idcplink))
				lamatriz6(2,1)='tablacp'
				lamatriz6(2,2)="'"+v_tablacp+"'"
				lamatriz6(3,1)='campocp'
				lamatriz6(3,2)="'"+v_campocp+"'"
				lamatriz6(4,1)='registrocp'
				lamatriz6(4,2)=ALLTRIM(STR(v_iddetacp))
				lamatriz6(5,1)='tabla'
				lamatriz6(5,2)="'"+v_tabla+"'"
				lamatriz6(6,1)='campo'
				lamatriz6(6,2)="'"+v_campo+"'"
				lamatriz6(7,1)='idregistro'
				lamatriz6(7,2)=ALLTRIM(STR(v_idregistroD))
				lamatriz6(8,1)='fecha'
				lamatriz6(8,2)="'"+ALLTRIM(v_fecha)+"'"
						
					
						
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				ELSE
					v_ret = guardarMoviTPago(v_idtipoPago, v_tabla, v_campo, v_idregistroD, _SYSCAJARECA, id_cajabco, v_idtipocomp, v_tablacp, v_campocp, v_iddetacp )
				
					IF v_ret = .F.
						MESSAGEBOX("Ha Ocurrido un Error al intentar registrar el Movimiento para el Tipo de pago",0+48+0,"Error")
					ENDIF 
				    
				ENDIF 
						
						
					
			ELSE
					
				v_tipoPagoCheque = tipopagoObj.gettipospagos('CHEQUE')	
				
				IF v_idtipoPago == v_tipoPagoCheque 
					***GUARDA RELACION CHEQUE - DETALLE PAGO (EN TABLA COBROPAGOLINK)***
								
					DIMENSION lamatriz6(8,2)
					
					v_idcplink = maxnumeroidx("idcplink", "I", "cobropagolink",1)	
					v_tablacp	= "detallecobros"
					v_campocp	= "iddetacobro"
					v_tabla		= "cheques"
					v_campo		= "idcheque"	
					v_idregistroD = detapagotr_sql.idreg
					v_fecha = dtos(DATE())
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					p_tabla     = 'cobropagolink'
					p_matriz    = 'lamatriz6'
					p_conexion  = vconeccionAn

					lamatriz6(1,1)='idcplink'
					lamatriz6(1,2)=ALLTRIM(STR(v_idcplink))
					lamatriz6(2,1)='tablacp'
					lamatriz6(2,2)="'"+v_tablacp+"'"
					lamatriz6(3,1)='campocp'
					lamatriz6(3,2)="'"+v_campocp+"'"
					lamatriz6(4,1)='registrocp'
					lamatriz6(4,2)=ALLTRIM(STR(v_iddetacp))
					lamatriz6(5,1)='tabla'
					lamatriz6(5,2)="'"+v_tabla+"'"
					lamatriz6(6,1)='campo'
					lamatriz6(6,2)="'"+v_campo+"'"
					lamatriz6(7,1)='idregistro'
					lamatriz6(7,2)=ALLTRIM(STR(v_idregistroD))
					lamatriz6(8,1)='fecha'
					lamatriz6(8,2)="'"+ALLTRIM(v_fecha)+"'"
							
							
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
					ELSE
						v_ret = guardarMoviTPago(v_idtipoPago, v_tabla, v_campo, v_idregistroD, _SYSCAJARECA,id_cajabco,v_idtipocomp, v_tablacp, v_campocp, v_iddetacp )
				
						IF v_ret = .F.
							MESSAGEBOX("Ha Ocurrido un Error al intentar registrar el Movimiento para el Tipo de pago",0+48+0,"Error")
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
			
			SELECT detapagotr_sql
			SKIP 1
			
		ENDDO 

** hasta aqui la parte de detallecobros que graba en detallepagos **

	*** Asocio el comprobante de anulación con el CajaIE anulado **
							
		DIMENSION lamatriz7(5,2)

		v_idlinkComp = 0
		v_idcomprobaa=transfeA.idcomproba
		v_idregistroa=transfeA.idtransfe
		v_idcomprobab=v_transfe_idcomproba
		v_idregistrob=v_idtransfe
		
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'linkcompro'
		p_matriz    = 'lamatriz7'
		p_conexion  = vconeccionAn

		lamatriz7(1,1)='idlinkcomp'
		lamatriz7(1,2)=ALLTRIM(STR(v_idlinkComp))
		lamatriz7(2,1)='idcomprobaa'
		lamatriz7(2,2)=ALLTRIM(STR(v_idcomprobaa))
		lamatriz7(3,1)='idregistroa'
		lamatriz7(3,2)=ALLTRIM(STR(v_idregistroa))
		lamatriz7(4,1)='idcomprobab'
		lamatriz7(4,2)=ALLTRIM(STR(v_idcomprobab))
		lamatriz7(5,1)='idregistrob'
		lamatriz7(5,2)=ALLTRIM(STR(v_idregistrob))
														
							
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error al intentar guardar linkcompro",0+48+0,"Error")
			
		ENDIF 
	
						
		*Registracion Contable del la Transferencia	
		pan_idregistro = pIdregistro

		nuevo_asiento = Contrasiento( 0,_SYSCONTRADH, v_tablaPor, pan_idregistro, 'transferencias', v_idtransfe)
		
		
	ELSE
				
		=abreycierracon(vconeccionAn ,"")	
		RETURN -1
	ENDIF 
		
	=abreycierracon(vconeccionAn ,"")	

	IF TYPE('v_retornotra') == 'C'
		v_retornotra= VAL(v_retornotra)
	ENDIF 

	RETURN v_retornotra

ENDFUNC 

************ FIN FUNCION ANULAR TRANSFERENCIAS *********************************


