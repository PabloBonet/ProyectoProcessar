_screen.Visible = .t.
SET SYSMENU OFF
CLEAR


PUBLIC _SYSLIBRERIAS
_SYSLIBRERIAS = " UTILITY.PRG "
SET PROCEDURE TO &_SYSLIBRERIAS &&UTILITY.PRG

=LEECONFIG("arenera_config.cfg")


_screen.windowstate= 0
_screen.closable = .f.
_screen.MaxButton = .T.
_screen.AutoCenter = .T.
_screen.Caption 	= ""


v_dirRaiz = CURDIR()
PATHEXE= FULLPATH(v_dirRaiz+"archivos/origen/")

SET DEFAULT TO &PATHEXE
SET CONFIRM OFF 
SET SAFETY OFF 

** GENERA ARCHIVO PARA IMPORTACION DE CUOTAS Y SALDOS DE CLIENTES **
*** Formato archivo csv serparado por ; a generar 
*** ( entidad I, servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8), fechavenc1 c(8), fechavenc2 c(8), fechavenc3 c(8) )			

v_sino = MESSAGEBOX("¿Generar los Archivos de Cta Cte?",4+32+256,"Generar Archivo de Cta Cte")

IF v_sino = 6 && SI

	CREATE TABLE saldosimportar ( entidad I, servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8), fechavenc1 c(8), fechavenc2 c(8), fechavenc3 c(8))
	CREATE TABLE saldosexcluidos ( entidad I, servicio I, cuenta I, fecha C(8),numerocomp C(200), monto Y, cuota I, vtocta C(8), fechavenc1 c(8), fechavenc2 c(8), fechavenc3 c(8))

	CREATE TABLE codent (codigo C(50), entidad C(50))

	CREATE TABLE comprobantes (c1 c(50), c2 c(200), c3 c(200), c4 c(50), c5 c(50), c6 c(50), c7 c(50), c8 c(50), c9 c(50), c10 c(50), c11 C(50))


	SELECT comprobantes
	*APPEND FROM ctacte_arenera.csv DELIMITED WITH CHARACTER ';'
	v_ejecutar1 = "APPEND FROM "+ALLTRIM(_SYSNOMARCHIVOCTACTE)+" DELIMITED WITH CHARACTER ';'"
	&v_ejecutar1

	DELETE FOR EMPTY(ALLTRIM(c1)) 
	PACK

	SELECT codent 
	*APPEND FROM codigo_entidad.csv DELIMITED WITH CHARACTER ';'
	v_ejecutar2 = "APPEND FROM "+ALLTRIM(_SYSNOMARCHIVOCODENT)+" DELIMITED WITH CHARACTER ';'"
	&v_ejecutar2

	*!*	replace ALL c3 WITH IIF(SUBSTR((ALLTRIM(c3)+'  '),1,2)=='00',c3,'')
	*!*	GO TOP
	*!*	v_c3ante = comprobantes.c3 
	*!*	SKIP 
	*!*	v_c2ante = comprobantes.c2

	v_codigoEnt = ""
	SELECT comprobantes
	GO TOP  
	DO WHILE !EOF()

		v_campo1 = ALLTRIM(comprobantes.c1) && ENTIDAD / FECHA VTO.
		
		
		IF EMPTY(v_campo1) = .F.
		
		v_tieneBarra = AT('/',v_campo1)
		
		
			IF v_tieneBarra > 0  AND EMPTY(ALLTRIM(v_codigoEnt)) = .F.
				** Es fecha **
				
				
				v_campo3 = ALLTRIM(comprobantes.c3) && FECHA EMISION
				v_campo6 = ALLTRIM(comprobantes.c6) && ABREVIA
				v_campo7 = ALLTRIM(comprobantes.c7) && NUMERO
				v_campo10 = ALLTRIM(comprobantes.c10) && SALDO
		
		
				v_fechaVenc1 = ALLTRIM(SUBSTR(v_campo1,7,4))+ALLTRIM(SUBSTR(v_campo1,4,2))+ALLTRIM(SUBSTR(v_campo1,1,2))
				v_fechaComp = ALLTRIM(SUBSTR(v_campo3,7,4))+ALLTRIM(SUBSTR(v_campo3,4,2))+ALLTRIM(SUBSTR(v_campo3,1,2))
				v_comprobante = ALLTRIM(v_campo6)
				v_numeroComp = ALLTRIM(v_campo7)
				v_saldoComp = ALLTRIM(v_campo10)

				
				v_entidad = VAL(v_codigoEnt)
				v_servicio = 0
				v_cuenta = 0
				v_fecha = v_fechaComp
				v_numerocomp =v_comprobante + " - "+v_numeroComp 
				v_monto = VAL(v_saldoComp)
				v_cuota = 0
				v_vtocta =""
				v_fechavenc1 = v_fechaVenc1 
				v_fechavenc2 = ""
				v_fechavenc3 = ""
				
				IF v_monto >= _SYSSALDOMINIMO OR  v_monto <= (_SYSSALDOMINIMO*(-1))
					INSERT INTO saldosimportar VALUES (v_entidad,v_servicio,v_cuenta,v_fecha,v_numerocomp, v_monto, v_cuota, v_vtocta, v_fechavenc1, v_fechavenc2,v_fechavenc3)
				ELSE
					INSERT INTO saldosexcluidos VALUES (v_entidad,v_servicio,v_cuenta,v_fecha,v_numerocomp, v_monto, v_cuota, v_vtocta, v_fechavenc1, v_fechavenc2,v_fechavenc3)
				ENDIF 
				
			ELSE
				** Es Código **
				
				v_entnro = 	VAL(v_campo1)
		
				IF v_entnro > 0
					v_sen = "SELECT * FROM codent WHERE VAL(codigo) = "+ALLTRIM(STR(v_entnro))+" INTO CURSOR CodigoEntidad "
					
					&v_sen
				ELSE
					v_sen = "SELECT * FROM codent WHERE alltrim(codigo) == '"+ALLTRIM(v_campo1) +"' INTO CURSOR CodigoEntidad "
					&v_sen
				ENDIF 
				
				
	*!*				SELECT * FROM codent WHERE alltrim(codigo) == ALLTRIM(v_campo1) INTO CURSOR CodigoEntidad
				SELECT codigoEntidad
				GO TOP 
				IF NOT EOF()
				
					v_codigoEnt = ALLTRIM(CodigoEntidad.entidad)
				
				ENDIF 
						
				
			ENDIF 
				
			
			
		
		ENDIF
		 
		SELECT comprobantes
		SKIP 1
	ENDDO 

	PATHEXE= FULLPATH(v_dirRaiz+"archivos/destino/")

	SET DEFAULT TO &PATHEXE
	SELECT saldosimportar
	GO TOP 

	*COPY TO	ctaCte_Arenera_gen.csv DELIMITED WITH  CHARACTER ';'
	v_ejecutar3 = "COPY TO	"+ALLTRIM(_SYSNOMARCHIVOCTACTEIMP)+" DELIMITED WITH  CHARACTER ';'"
	&v_ejecutar3


	SELECT saldosexcluidos
	GO TOP 

	*COPY TO	ctaCte_Arenera_gen.csv DELIMITED WITH  CHARACTER ';'
	v_ejecutar4 = "COPY TO	"+ALLTRIM(_SYSNOMARCHIVOCTACTEEXC)+" DELIMITED WITH  CHARACTER ';'"
	&v_ejecutar4

ENDIF 

v_sino = MESSAGEBOX("¿Convertir el archivo para generar los Asientos contables?",4+32+256,"Convertir Archivo de asiento contable")

IF v_sino = 6 && SI

	** Tengo que llegar al siguiente formato: asientos (c1 c(50), c2 c(200), c3 c(200), c4 c(50), c5 c(50), c6 c(50), c7 c(50), c8 c(50), c9 c(50), c10 c(50), c11 C(50), c12 C(50))
	
	CREATE TABLE asientostmp (c1 c(50), c2 c(200), c3 c(200), c4 c(50), c5 c(50), c6 c(50), c7 c(250), c8 c(50), c9 c(50), c10 c(50), c11 C(50), c12 C(50))


	V_CONTADOR = 0

	IF FILE(_SYSNOMARCHIVOCONVASI) && SI el archivo existe
		V_PUNTERO = FOPEN(_SYSNOMARCHIVOCONVASI,0)
		
		IF v_PUNTERO > 0
			DO WHILE !EOF(V_PUNTERO) AND v_contador < 48000 &&& NOTA::: QUITAR EL CONTADOR DESPUES DE PROBAR
*			DO WHILE !EOF(V_PUNTERO) AND v_contador < 10 &&& NOTA::: QUITAR EL CONTADOR DESPUES DE PROBAR
		*	DO WHILE !EOF(V_PUNTERO) 
				
				v_numero = 0
				v_fecha=""
				v_codigocta =0
				v_debe = 0.00
				v_haber = 0.00
				v_cotiz = 0.00
				v_detalle = ""
			*	v_nroComp = 0
				*v_tipoComp = ""

	
				v_linea = FGETS(v_puntero)
	
				IF EMPTY(ALLTRIM(v_linea)) = .F.
				
					v_tieneFecha = AT('/',v_linea)		
					
					IF v_tieneFecha > 0
					
						v_cantele = ALINES(arreglo,v_linea,';')

						IF v_cantEle > 0 
							
							v_i = 1
							
							** Recorro la la linea hasta obtener la fecha, numero de asiento y codigo de cuenta **
							DO WHILE (v_i <= v_cantEle) and (v_codigocta <= 0)  && Recorri todos los elementos del arrego o encontre el codigo de la cuenta (Ultimo elemento antes de la descripción)  
								
								v_elem1 = arreglo[v_i]

								IF AT('/',v_elem1) > 0 AND EMPTY(ALLTRIM(v_fecha))=.T. && CAMPO FECHA y NO se obtuvo previamente 
									v_fecha = v_elem1
								
								ELSE
									IF AT('/',v_elem1) = 0 && Si no tiene la '/' no es fecha
										IF TYPE(v_elem1)='N'  && Si el tipo es numerico-> es el numero o la cuenta
											IF v_numero = 0 && NO tenia asignado numero -> le asigno un número
												v_numero = VAL(v_elem1)
											ELSE
												IF v_codigocta = 0 && No tenia asignado un codigo de cuenta -> le asigno el codigo de cuenta
													v_codigocta= VAL(v_elem1) 																							
												
												ENDIF 
											ENDIF 
										ENDIF 
									ENDIF 
								ENDIF 
								
								v_i = v_i + 1

							ENDDO
						
						
							** Obtengo los ultimos elementos con numeros de atras para adelante -> HABER, DEBE, COTIZACION, NUMEROCOMP
							v_asignoD = .F.
							v_asignoH = .F.
							v_asignoCot = .F.
*							v_asignoNComp = .F.
							*v_asignoTC = .F.
							
							v_j = v_cantEle
							
*							DO WHILE v_j > 0 AND (v_asignoD = .F. OR  v_asignoH = .F. OR v_asignoCot = .F. OR v_asignoNComp = .F.)
							DO WHILE v_j > 0 AND (v_asignoD = .F. OR  v_asignoH = .F. OR v_asignoCot = .F.)

									v_elemJ = arreglo[v_j]
*								MESSAGEBOX(v_elemJ)
						
									v_elemj = STRTRAN(v_elemJ,'.','')
									v_elemj = STRTRAN(v_elemJ,',','.')

									IF TYPE(v_elemJ) = 'N'

										IF v_asignoH = .F.
											v_haber = VAL(v_elemJ)
											v_asignoH = .T.
										ELSE
											
											IF v_asignoD = .F.
												v_debe = VAL(v_elemJ)
											
												v_asignoD = .T.
											ELSE
												IF v_asignoCot = .F.
													v_cotiz = VAL(v_elemJ)
													v_asignoCot = .T.
												ELSE
												
*!*														IF v_asignoNComp = .F.
*!*														
*!*															v_nroComp = VAL(v_elemJ)
*!*															v_asignoNComp  = .T.
*!*														ENDIF 
*!*														
												ENDIF 
												
											ENDIF 
										ENDIF 
									
									ELSE
									
*!*											MESSAGEBOX(TYPE('v_elemJ'))
*!*											IF TYPE('v_elemJ') = 'C' 
*!*												MESSAGEBOX(v_elemJ)
*!*												MESSAGEBOX(EMPTY(ALLTRIM(v_elemJ)))
*!*												IF EMPTY(ALLTRIM(v_elemJ)) = .F. AND v_asignoNComp = .T.
*!*												MESSAGEBOX("A1")
*!*													v_tipoComp = ALLTRIM(v_elemJ)
*!*												
*!*												ENDIF 
*!*										MESSAGEBOX("A2")
*!*											ENDIF 
									ENDIF 
*								MESSAGEBOX("A3")
								v_j = v_j - 1 
		
							ENDDO
	
	
							IF v_i <= v_j 
							
								v_i = v_i +1
								
								DO WHILE v_i <= v_j
								
									v_elemI = arreglo[v_i]
									
									
									v_detalle = v_detalle +"@"+ ALLTRIM(v_elemI)
								
									v_i = v_i +1
								
								ENDDO 
								
							
							ENDIF 
							
							
						ENDIF 
						
						
					ENDIF 
					
					
				ENDIF 


				v_c1 = ALLTRIM(v_fecha)&&FECHA
				v_c2 = STR(v_numero) &&NRO. ASIENTO
				v_c3 = STR(v_codigocta) &&COD. CTA
				v_c4 = "" && DESCRIP. de CTA (NO se va a usar)
				v_c5 = ""
				v_c6 = ALLTRIM(v_detalle)&&CONCEPTO
*				v_c7 =  ALLTRIM(v_tipoComp)&&COMPROBANTE
				v_c7 = ""
*				v_c8 = v_nroComp
				v_c8 = ""
				v_c9 = ""
				v_c10 = ""
				v_c11 = STR(v_debe,13,2)&&DEBE
				v_c12 = STR(v_haber,13,2) &&HABER
		
										
				IF  EMPTY(ALLTRIM(v_c1)) = .T. OR v_numero <= 0
				ELSE
				

					INSERT INTO asientostmp VALUES (v_c1, v_c2, v_c3, v_c4, v_c5, v_c6, v_c7, v_c8, v_c9, v_c10, v_c11, v_c12)
				ENDIF 
				
				
				v_contador = v_contador + 1
						
			ENDDO




		
			=FCLOSE(V_PUNTERO)  && Close file


		ELSE
		
			MESSAGEBOX("NO se pudo abrir el archivo: "+ALLTRIM(_SYSNOMARCHIVOCONVASI),0+16+256,"Error al  convertir el archivo para generar los asientos")
				
		ENDIF 

	ELSE
	
		MESSAGEBOX("NO existe el archivo: "+ALLTRIM(_SYSNOMARCHIVOCONVASI),0+16+256,"Error al  convertir el archivo para generar los asientos")

	ENDIF 

	


	SELECT asientostmp 
	GO TOP 

	v_ejecutar5 = "COPY TO	"+ALLTRIM(_SYSNOMARCHIVOASIENTOS)+" DELIMITED WITH  CHARACTER ';'"
	&v_ejecutar5
	

endif 





v_sino = MESSAGEBOX("¿Generar los archivos de Asientos contables?",4+32+256,"Generar Archivo de asiento contable")

IF v_sino = 6 && SI

	
	CREATE TABLE asientosimportar ( numero I,fecha C(8),codigocta C(20), debe Y, haber y, detalle  C(100))

	CREATE TABLE codCta (codigo C(20), cuenta C(20))

	CREATE TABLE asientos (c1 c(50), c2 c(200), c3 c(200), c4 c(50), c5 c(50), c6 c(50), c7 c(50), c8 c(50), c9 c(50), c10 c(50), c11 C(50), c12 C(50))

	CREATE TABLE asientosExcluidos ( numero I,fecha C(8),codigocta C(20), debe Y, haber y, detalle  C(100))


	SELECT asientos 

	v_ejecutar1 = "APPEND FROM "+ALLTRIM(_SYSNOMARCHIVOASIENTOS)+" DELIMITED WITH CHARACTER ';'"
	MESSAGEBOX(v_ejecutar1)
	&v_ejecutar1

	DELETE FOR EMPTY(ALLTRIM(c1)) 
	PACK

	SELECT codCta 

	v_ejecutar2 = "APPEND FROM "+ALLTRIM(_SYSNOMARCHIVOCODCTA)+" DELIMITED WITH CHARACTER ';'"
	MESSAGEBOX(v_ejecutar2)
	&v_ejecutar2

	v_nroAsiento = 0
	v_nroAstoAnt = 0
	v_fechaAnt = ''

	SELECT asientos 
	GO TOP  
	DO WHILE !EOF()

		v_campo1 = ALLTRIM(asientos.c1) &&FECHA
		
		
		IF EMPTY(v_campo1) = .F.
		
		v_tieneBarra = AT('/',v_campo1)
		
		
			IF v_tieneBarra > 0 
				** Es fecha **
				v_error = .F.
				
				v_campo2 = ALLTRIM(asientos.c2) &&NRO. ASIENTO
				v_campo3 = ALLTRIM(asientos.c3) &&COD. CTA
				v_campo4 = ALLTRIM(asientos.c4) && DESCRIP. de CTA (NO se va a usar)
				
				v_campo6 = ALLTRIM(asientos.c6) &&CONCEPTO
				v_campo7 = ALLTRIM(asientos.c7) &&COMPROBANTE
				v_campo8 = ALLTRIM(asientos.c8) &&NRO. COMPROBANTE
				
				
				v_campo11 = ALLTRIM(asientos.c11) &&DEBE
				v_campo12 = ALLTRIM(asientos.c12) &&HABER
				
				
				v_fecha = ALLTRIM(SUBSTR(v_campo1,7,4))+ALLTRIM(SUBSTR(v_campo1,4,2))+ALLTRIM(SUBSTR(v_campo1,1,2))
				
				v_nroAsto = VAL(v_campo2)
				
				
				IF v_nroAsto <> v_nroAstoAnt
				
					v_nroASiento = v_nroAsiento + 1
					v_nroAstoAnt = v_nroAsto
					v_fechaAnt = v_fecha
				ELSE
					IF v_fechaAnt <> v_fecha
					
						_nroASiento = v_nroAsiento + 1
						v_nroAstoAnt = v_nroAsto
						v_fechaAnt = v_fecha
					ENDIF 
				
				ENDIF 			
			
				v_sen = "SELECT * FROM codcta WHERE alltrim(codigo) == '"+ALLTRIM(v_campo3) +"' INTO CURSOR CodigoCuenta "
				&v_sen
			
				
				SELECT CodigoCuenta 
				GO TOP 
				IF NOT EOF()
				
					v_codigoCuenta = ALLTRIM(CodigoCuenta.cuenta)
				
				ELSE
					v_codigoCuenta  = ""
					v_error = .T.
				ENDIF 
			
				v_debe = VAL(v_campo11)
				v_haber = VAL(v_campo12)
					
				v_detalle = "Conc: "+ALLTRIM(v_campo6)+" - Comp: "+ALLTRIM(v_campo7)+ " "+ALLTRIM(v_campo8)
				
				IF v_error = .T.
					INSERT INTO asientosExcluidos VALUES (v_nroAsto, v_fecha,v_codigoCuenta, v_debe,v_haber,v_detalle)
				ELSE
					INSERT INTO asientosimportar VALUES (v_nroAsto, v_fecha,v_codigoCuenta, v_debe,v_haber,v_detalle)
				ENDIF 			
					
						
								
			ENDIF 
				
				
		
		ENDIF
		 
		SELECT asientos 
		SKIP 1
	ENDDO 

	PATHEXE= FULLPATH(v_dirRaiz+"archivos/destino/")

	SET DEFAULT TO &PATHEXE
	SELECT asientosimportar 
	GO TOP 

	*COPY TO	ctaCte_Arenera_gen.csv DELIMITED WITH  CHARACTER ';'
	v_ejecutar3 = "COPY TO	"+ALLTRIM(_SYSNOMARCHIVOASIIMP)+" DELIMITED WITH  CHARACTER ';'"

	&v_ejecutar3


	SELECT asientosExcluidos 
	GO TOP 

	*COPY TO	ctaCte_Arenera_gen.csv DELIMITED WITH  CHARACTER ';'
	v_ejecutar4 = "COPY TO	"+ALLTRIM(_SYSNOMARCHIVOASIEXC)+" DELIMITED WITH  CHARACTER ';'"
	
	&v_ejecutar4











ENDIF 

