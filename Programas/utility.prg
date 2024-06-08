 
FUNCTION CTRLF12
	SET SYSMENU TO DEFA
	CANCEL
	RETURN
ENDFUNC 


FUNCTION LEECONFIG()
	v_llave = 'Processar'
	IF FILE('config.dbf') THEN 
		PUNTERO = 1
	ELSE 
		PUNTERO = 0
	ENDIF 

	IF PUNTERO > 0 THEN
		USE CONFIG.DBF IN 0
		SELECT config 
		DO WHILE !EOF() 
			EJE = ALLTRIM(config.valorc)

			IF !(SUBSTR(ALLTRIM(EJE),1,1)=="_" OR SUBSTR(ALLTRIM(EJE),1,1)=="P") THEN 
				EJE=desencripta(EJE,v_llave)
			ENDIF

			IF !(ALLTRIM(EJE)=="" OR SUBSTR(ALLTRIM(EJE),1,1)=="[") THEN 
				&EJE
			ENDIF
			SKIP 
		ENDDO
		USE 
		SET SAFETY OFF
		
	ELSE 
		_screen.Visible = .t. 
		DO FORM seteoaccesodb TO vseteo
		IF !(vseteo = "0") THEN
			USE CONFIG.DBF IN 0
			SELECT config 
			DO WHILE !EOF() 
				EJE = ALLTRIM(config.valorc)
				IF !(SUBSTR(ALLTRIM(EJE),1,1)=="_" OR SUBSTR(ALLTRIM(EJE),1,1)=="P") THEN 
					EJE=desencripta(EJE,v_llave)
				ENDIF

				IF !(ALLTRIM(EJE)=="" OR SUBSTR(ALLTRIM(EJE),1,1)=="[") THEN 
					&EJE
				ENDIF
				SKIP 
			ENDDO
			USE 
			SET SAFETY OFF
			RETURN 
		ELSE 
*			MESSAGEBOX("No se puede continuar con la ejecucion; Error en carga de archivo de configuración !! ",0+16,"Error de Ejecución")
			quit	
		ENDIF 
	ENDIF 

RETURN


ENDFUNC 


FUNCTION CREACONFIG()
		PARAMETERS pc_server, pc_usuario, pc_passw, pc_puerto, pc_esquema, pc_driver, pc_encripta, pc_llave, pc_vpnexe, pc_vpncon, pc_vpnusr, pc_vpnpass
		v_llave = pc_llave
		IF FILE('config.dbf') THEN 
			DELETE FILE 'config.dbf' 
		ENDIF 
		CREATE TABLE config.dbf (valorc c(254))
		v_charC="PUBLIC _SYSMYSQL_SERVER, _SYSMYSQL_USER "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="PUBLIC _SYSMYSQL_PASS, _SYSMYSQL_PORT, _SYSSCHEMA, _SYSDRVMYSQL "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSMYSQL_SERVER = '"+ALLTRIM(pc_server)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSMYSQL_USER   = '"+ALLTRIM(pc_usuario)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSMYSQL_PASS   = '"+(ALLTRIM(pc_passw))+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSMYSQL_PORT   = '"+ALLTRIM(pc_puerto)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSSCHEMA    	  = '"+ALLTRIM(pc_esquema)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSDRVMYSQL     = '"+ALLTRIM(pc_driver)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)

		v_charC="PUBLIC _SYSVPN_EXE, _SYSVPN_CON, _SYSVPN_USR, _SYSVPN_PASS "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSVPN_EXE     = '"+(ALLTRIM(pc_vpnexe))+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSVPN_CON     = '"+ALLTRIM(pc_vpncon)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSVPN_USR     = '"+ALLTRIM(pc_vpnusr)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)
		v_charC="_SYSVPN_PASS    = '"+ALLTRIM(pc_vpnpass)+"' "
		v_charC=IIF(pc_encripta=0 ,v_charC,encripta(v_charC,v_llave,.f.))
		INSERT INTO config VALUES (v_charC)


		USE 
	RETURN 

ENDFUNC




************************************************************************************************************
************************************************************************************************************
********************************************************************************************************
FUNCTION CIERRAAPP
*#/----------------------------------------
*** Función de Cierre del Sistema, Segun la variable _SYSPAPELERA = "S / N"
*** Elimina o deja los archivos temporales generados durante la Ejecución del Sistema
*#/----------------------------------------

*-- Cerrar Forms abiertos
vformCount = _SCREEN.FormCount
FOR i_vform = vformCount  TO 1 STEP -1
    _SCREEN.Forms(i_vform).Release() 			
ENDFOR

CLEAR EVENTS 
CLOSE ALL 
CLOSE TABLES ALL 
SET SAFETY OFF 
_screen.Visible= .F.
SET DEFAULT TO &_SYSESTACION 

IF TYPE("_SYSFILESTMP") = "C" THEN 
	IF SUBSTR(ALLTRIM(UPPER(_SYSFILESTMP)),1,1) = 'N' THEN 
		ON ERROR QUIT 
		DELETE FILE &_SYSESTACION\*.* &_SYSPAPELERA 
		CD ..
		RMDIR &_SYSESTACION
	ENDIF 
ENDIF 
QUIT 
RETURN


********************************************************************************************************
********************************************************************************************************
********************************************************************************************************
FUNCTION Valicuit (NRO_CUIT)
*#/----------------------------------------
*** Función Validación de Numero de CUIT, retorna verdadero o falso segun
*** el cuit recibido como parametro sea valido
*#/----------------------------------------

IF NRO_CUIT='  -        - ' OR NRO_CUIT='             ' THEN 
	RETURN .T.
ENDIF	
IF LEN(ALLTRIM(NRO_CUIT)) < 13 THEN 
	RETURN .F.
ENDIF	
A = VAL(SUBSTR(NRO_CUIT,1,1)) * 5
B = VAL(SUBSTR(NRO_CUIT,2,1)) * 4
C = VAL(SUBSTR(NRO_CUIT,4,1)) * 3
D = VAL(SUBSTR(NRO_CUIT,5,1)) * 2
E = VAL(SUBSTR(NRO_CUIT,6,1)) * 7
F = VAL(SUBSTR(NRO_CUIT,7,1)) * 6
G = VAL(SUBSTR(NRO_CUIT,8,1)) * 5
H = VAL(SUBSTR(NRO_CUIT,9,1)) * 4
I = VAL(SUBSTR(NRO_CUIT,10,1)) * 3
J = VAL(SUBSTR(NRO_CUIT,11,1)) * 2

DV_NRO = VAL(SUBSTR(NRO_CUIT,13,1)) 
SUMA = A + B + C + D + E + F + G + H + I + J

RESTO = MOD(SUMA,11)

DV = 11 - RESTO
IF RESTO = 0 OR RESTO = 1 THEN
	IF DV_NRO = 0 THEN
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
ELSE
	IF DV_NRO = DV THEN
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
ENDIF
ENDFUNC


********************************************************************************************************
********************************************************************************************************
********************************************************************************************************

PROCEDURE enletras
parameters enl_nume1
*#/----------------------------------------
*** Función de conversion de Numeros a Letras.
*** Recibe un Numero y devuelve el mismo expresado en letras
*#/----------------------------------------

N=""
N1="UN"
N2="DOS"
N3="TRES"
N4="CUATRO"
N5="CINCO"
N6="SEIS"
N7="SIETE"
N8="OCHO"
N9="NUEVE"
N10="DIEZ"
N11="ONCE"
N12="DOCE"
N13="TRECE"
N14="CATORCE"
N15="QUINCE"
N16="DIECISEIS"
N17="DIECISIETE"
N18="DIECIOCHO"
N19="DIECINUEVE"
N20="VEINTE"
N30="TREINTA"
N40="CUARENTA"
N50="CINCUENTA"
N60="SESENTA"
N70="SETENTA"
N80="OCHENTA"
N90="NOVENTA"
NCCC="CIEN"
N100="CIENTO"
N200="DOSCIENTOS"
N300="TRESCIENTOS"
N400="CUATROCIENTOS"
N500="QUINIENTOS"
N600="SEISCIENTOS"
N700="SETECIENTOS"
N800="OCHOCIENTOS"
N900="NOVECIENTOS"
* /////// *
cadena1 = STR(enl_nume1,12,2)
cadena = SUBSTR(cadena1,1,9)
enl_numer = VAL(cadena)
cadena = STR(ENL_NUMER,9)
nump = " "
otro = 0
do while otro <= 1
	contador = 1
	inicio = 1
	do while contador < 4
		subcadena = SUBSTR(cadena,inicio,3)
		centena = SUBSTR(subcadena,1,1)+'00'
		decena = SUBSTR(subcadena,2,2)
		unidad = SUBSTR(subcadena,3,1)
		IF VAL(subcadena) > 99
			IF VAL(subcadena) = 100 THEN
			nump = nump+NCCC+' '
			ELSE
			nump = nump + N&centena+' '
			ENDIF
		ENDIF
		T = VAL(decena)
		IF T > 0
		do case
		
			*****caso 1 : Decenas sin unidades o de 10 a 20.*********
			
			case (int(T/10.0)=T/10.0) .or. (T>9	.and. T<20)
				nump = nump + N&decena
				
			*****caso 2 : Decenas mayores de 10 pero con unidades*********	
			
			case (T > 9) .and. (INT(T/10.0) <> T/10.0)
				decena = SUBSTR(decena,1,1)+'0'
				IF decena <> '20'
					nump = nump+N&decena+' Y '+N&unidad	
				ELSE
					nump = nump+'VEINTI'+N&unidad
				ENDIF
			
			*****caso 3 : Si no hay decenas**********
			
			case T < 10
				nump = nump+N&unidad
			endcase
		ENDIF
		IF enl_numer > 999999 .and. contador = 1
			nump = nump+' MILLONES '
		ENDIF
		
		IF nump = " UN MILLONES "
			nump = " UN MILLON "
		ENDIF
		
		IF (enl_numer > 999 .and. contador = 2 .and. VAL(subcadena) > 0 ) THEN
			nump = nump +' MIL '
		ENDIF
		IF nump = " UN MIL "
			nump = " MIL "
		ENDIF
		
		inicio = contador * 3 + 1
		contador = contador + 1
	ENDDO
contador = 1
inicio = 1
cadena = '       '+SUBSTR(cadena1,11,2)
enl_numer = VAL(cadena)
if otro = 0
	nump = nump+" PESOS CON "
endif
IF enl_numer = 0 THEN
	nump = nump+"CERO"
	otro = 2
ELSE
otro = otro + 1
ENDIF
ENDDO
******DELETREA EL NUMERO*******
nump =  nump+" CENTAVOS "				
return nump


********************************************************************************************************
********************************************************************************************************
********************************************************************************************************
FUNCTION NOMBREMES
PARAMETER NMES
*#/----------------------------------------
*** Conversión de numeros a mes del año, recibe como parametro
*** el numero de mes (1-12) y devuelve el mes en letras (ENERO-DICIEMBRE)
*#/----------------------------------------

DO CASE
	CASE NMES = 1
		RETURN "Enero"
	CASE NMES = 2
		RETURN "Febrero"
	CASE NMES = 3
		RETURN "Marzo"
	CASE NMES = 4
		RETURN "Abril"
	CASE NMES = 5
		RETURN "Mayo"
	CASE NMES = 6
		RETURN "Junio"
	CASE NMES = 7
		RETURN "Julio"
	CASE NMES = 8
		RETURN "Agosto"
	CASE NMES = 9
		RETURN "Setiembre"
	CASE NMES = 10
		RETURN "Octubre"
	CASE NMES = 11
		RETURN "Noviembre"
	CASE NMES = 12
		RETURN "Diciembre"
	OTHERWISE 
	    RETURN "."
ENDCASE



FUNCTION SETMASTERSCHEMA
*#/----------------------------------------
*** Función para Cambiar el esquema seteado en el sistema
*** al esquema Maestros, es decir al equema de administración (admindb)
*#/----------------------------------------

	_SYSMYSQL_SERVER 	= _SYSMASTER_SERVER 
	_SYSMYSQL_USER	 	= _SYSMASTER_USER   
	_SYSMYSQL_PASS   	= _SYSMASTER_PASS   
	_SYSMYSQL_PORT   	= _SYSMASTER_PORT   
	_SYSSCHEMA     		= _SYSMASTER_SCHEMA   
	_SYSDESCRIP			= _SYSMASTER_DESC
ENDFUNC 


FUNCTION SETVARPUBLICAS  
	PARAMETERS P_PREFIJO, P_TABLA
*#/---------------------------
	** OBTIENE LOS DATOS DE UNA TABLA Y GENERA VARIABLES PUBLICAS CON LOS CAMPOS Y SUS VALORES **
	** RECIBE COMO PARAMETROS UNA CADENA PARA ANEXAR A LOS NOMBRES DE LOS CAMPOS PARA SU IDENTIFICACION **
	** COMO VARIABLE PUBLICA GLOBAL **
*#/---------------------
	vconeccion=abreycierracon(0,_SYSSCHEMA)
	sqlmatriz(1)=" select * from "+P_tabla 
	verror=sqlrun(vconeccion,p_tabla)
	IF !verror THEN 
		MESSAGEBOX('Ha ocurrido un error al obtener los datos de la Empresa',0+64,'Error')
	ENDIF 

	=abreycierracon(vconeccion,'')
	SELECT &p_tabla 
	FOR i = 1 TO FCOUNT(p_tabla)
		EJE='PUBLIC '+p_prefijo+FIELD(I)
		&EJE
		EJE=p_prefijo+FIELD(I)+'='+p_tabla+'.'+FIELD(i)
		&EJE 
	ENDFOR 
	USE 
ENDFUNC 


FUNCTION DEFVARPUBLICAS  
	PARAMETERS p_tabla
*#/---------------------------
	** DEFINICION DE VARIABLES PUBLICAS DEL SISTEMA DESDE UNA TABLA DE MYSQL LLAMADA VARPUBLICAS EN EL SCHEMMA ADMINDB **
*#/---------------------------
	vconeccion=abreycierracon(0,_SYSSCHEMA)
	sqlmatriz(1)=" select * from "+P_tabla 
	verror=sqlrun(vconeccion,p_tabla)
	IF !verror THEN 
		MESSAGEBOX('Ha ocurrido un error al obtener los datos de la Empresa',0+64,'Error')
	ENDIF 
	=abreycierracon(vconeccion,'')
	SELECT &p_tabla
	GO TOP  
	DO WHILE !EOF()
		EJE='PUBLIC '+&p_tabla..variable
		&EJE
		IF &p_tabla..tipo = 'I' OR &p_tabla..tipo = 'F' OR &p_tabla..tipo = 'N'  THEN  
			EJE=&p_tabla..variable+" = "+STR(VAL(ALLTRIM(&p_tabla..valor)),13,4)
		ELSE
			EJE=&p_tabla..variable+" = '"+ALLTRIM(&p_tabla..valor)+"'"
		ENDIF 
		&EJE 
		SKIP 
	ENDDO 
	USE 
ENDFUNC 


PROCEDURE cerrar_todo 
	ON ERROR error = .f.
	ON SHUTDOWN
	CLEAR EVENTS
	QUIT
ENDPROC 


PROCEDURE SETEO_ESC 
	IF !(type('_SCREEN.ActiveForm')='U') THEN 
		_SCREEN.ActiveForm.cerrar 
	ELSE
	ENDIF 	
ENDPROC 



PROCEDURE salirmenu 
*#/---------------------------
*** Consulta para salir de la ejecución del sistema
*#/---------------------------
	IF MESSAGEBOX("¿Está seguro que desea Salir?",36,'Salir del Sistema') = 6
		CIERRAAPP()
    ENDIF
ENDPROC


FUNCTION winexec (tcExe)
	&tcExe
ENDFUNC 



***********
********** BUSCO SETEO DE BOTONES DE TOOLBARSYS  E ICONOS ***
FUNCTION settoolbarsys 
*#/---------------------------
*** Seteo de los Botones de la Barra de trabajo toolbarsys
*#/---------------------------

	vconeccion=abreycierracon(0,_SYSMASTER_SCHEMA)

	sqlmatriz(1)="select * from settoolbarsys"

	verror=sqlrun(vconeccion,'setbar')

	IF !verror THEN 
		MESSAGEBOX('Ha ocurrido un error al obtener datos de toolbarsys',0+64,'Error')
	ENDIF 

	sqlmatriz(1)="select * from iconos"

	verror=sqlrun(vconeccion,'setico')

	IF !verror THEN 
		MESSAGEBOX('Ha ocurrido un error al obtener datos de iconos',0+64,'Error')
	ENDIF 

	=abreycierracon(vconeccion,'')


	SELECT * FROM setbar INTO TABLE .\settoolbarsys
	SELECT setbar
	USE IN setbar
	SELECT settoolbarsys
	USE IN settoolbarsys

	SELECT * FROM setico INTO TABLE .\seticonos
	SELECT setico 
	USE IN setico 
	SELECT seticonos
	USE IN seticonos

ENDFUNC 


FUNCTION actutoolbarsys 
PARAMETERS p_form
*#/---------------------------
* FUNCION DE SETEO DE LA BARRA DE HERRAMIENTAS
*** Actualiza los botones de la barra de herramienta del sistema
*** de acuerdo el formulario que llama el operador
*** recibe como parametro el nombre del formulario
*#/---------------------------

	** agregado para deshabilitar la barra de herramientas por cada formulario
	** si se necesita agregar se habilitará con variables de entorno	
	IF !(UPPER(ALLTRIM(p_form))='REPORTEFORM') THEN 
		toolbarsys.hide 
		RETURN 
	ELSE 
		toolbarsys.show 
	ENDIF 
	********************************************
	
	= disabletoolbar()
	
	USE .\settoolbarsys IN 0
		
	SELECT * FROM settoolbarsys INTO CURSOR settool WHERE UPPER(ALLTRIM(form)) == UPPER(ALLTRIM(p_form))
	DO WHILE !EOF()
	
		IF settool.habilita = '1' THEN 
			vhabi = '.t.'
		ELSE
			vhabi = '.f.'
		ENDIF 
		eje = "toolbarsys.cmdbar_"+ALLTRIM(settool.idobjeto)+".enabled ="+vhabi
		&eje
		
		IF settool.visible = '1' THEN 
			vhabi = '.t.'
		ELSE
			vhabi = '.f.'
		ENDIF 
		eje = "toolbarsys.cmdbar_"+ALLTRIM(settool.idobjeto)+".visible ="+vhabi
		&eje

		eje = "toolbarsys.cmdbar_"+ALLTRIM(settool.idobjeto)+".tag = '"+ALLTRIM(settool.active)+ALLTRIM(settool.funcion)+"'"
		&eje

		IF !EMPTY(ALLTRIM(settool.tooltip)) THEN 
			eje = "toolbarsys.cmdbar_"+ALLTRIM(settool.idobjeto)+".tooltiptext = '"+ALLTRIM(settool.tooltip)+"'"
			&eje
		ENDIF 
		
		IF !EMPTY(ALLTRIM(settool.icono)) THEN 
			eje = "toolbarsys.cmdbar_"+ALLTRIM(settool.idobjeto)+".picture = '"+_sysservidor+"\iconos\"+ALLTRIM(settool.icono)+"'"
			&eje
		ENDIF 

		SELECT settool
		SKIP 
	ENDDO  
	
	SELECT settoolbarsys
	USE 

ENDFUNC 

FUNCTION disabletoolbar
*#/---------------------------
*** Deshabilita la barra de trabajo del sistema
*#/---------------------------

	FOR i = 1 TO toolbarsys.controlcount
		eje = "toolbarsys.cmdbar_"+SUBSTR((STR(100+i,3)),2,2)+".visible = .f."
		&eje
		eje = "toolbarsys.cmdbar_"+SUBSTR((STR(100+i,3)),2,2)+".enabled = .f."
		&eje
	ENDFOR 
ENDFUNC 


FUNCTION validcmdtoolbar
	PARAMETERS p_cmdbar 
*#/---------------------------
*** Función para ejecutar el comando asociado al botón 
*** seleccionado en la barra de trabajo del sistema
*#/---------------------------
	
	eje="varejecutar = toolbarsys."+p_cmdbar+".tag"
	&eje 
	IF !TYPE('_SCREEN.ActiveForm ')= 'U' THEN 
		on error _screen.activeform.error(error())
		_screen.activeform.activecontrol.lostfocus()
		on error
	ENDIF 

	IF len(ALLTRIM(varejecutar))>1 THEN 
		varejecu    = SUBSTR(ALLTRIM(varejecutar),2)
		IF SUBSTR(ALLTRIM(varejecutar),1,1)='1'
			IF !TYPE('_SCREEN.ActiveForm ')= 'U' THEN 
				_screen.ActiveForm.&varejecu
			ENDIF 
		ELSE
			=&varejecu
		ENDIF 
	ENDIF 
	Return	
ENDFUNC 

*FUNCION DE SETEO DE ICONOS
FUNCTION seticonos
	PARAMETERS p_nombre, par_objeto, par_arreglo
*#/---------------------------
*** Función para el seteo dell icono y comentarios de los botones
**  de comando de los formularios.
** debe ser llamado en el evento init de cada boton a ser configurado
*#/---------------------------
	
	USE .\seticonos IN 0
	SELECT * FROM seticonos INTO CURSOR setico WHERE ALLTRIM(nombre) == ALLTRIM(p_nombre)
	SELECT setico
	GO TOP 
	IF !EOF() THEN 
		IF TYPE("par_objeto") = 'C' AND TYPE("par_arreglo") = 'C' THEN 
			ret = _sysservidor+"\iconos\"+ALLTRIM(setico.archivo)+"#"+ALLTRIM(setico.tooltip)+IIF(!EMPTY(ALLTRIM(setico.teclafn))," ( "+setico.teclafn+" )","")
		ELSE
			ret = _sysservidor+"\iconos\"+ALLTRIM(setico.archivo)+"#"+ALLTRIM(setico.tooltip)+IIF(!EMPTY(ALLTRIM(setico.teclafn))," ","")
		ENDIF 
	ELSE
		ret = ""
	ENDIF 
	SELECT seticonos
	USE
	SELECT setico
	tfn = ALLTRIM(setico.teclafn)
	USE
	

	IF TYPE("par_objeto") = 'C' AND TYPE("par_arreglo") = 'C' THEN 
		IF !EMPTY(tfn) THEN 
			=seteoteclafn (par_arreglo,1,par_objeto,tfn)
		ENDIF 
	ENDIF 

	
RETURN ret 
ENDFUNC 


FUNCTION settoolbarmenu
PARAMETERS var_perfil
*#/---------------------------
*** Función de creación y seteo del Menu del sistema
*** de acuerdo al perfil recibido como parámetro
*** Reconfigura el menu en funcion del usuario y perfil asociado
*#/---------------------------

v_toolperfil = var_perfil

RELEASE toolbarmenu 
PUBLIC  toolbarmenu
toolbarmenu = CREATEOBJECT('toolbarmenu')
toolbarmenu.dock(1)
toolbarmenu.show 
toolbarmenu.tag = var_perfil

vconeccion=abreycierracon(0,_SYSSCHEMA)

sqlmatriz(1)="select m.* from toolbarmenu t left join  menusql m on t.idmenu = m.idmenu "
sqlmatriz(3)="where t.idperfil = "+ALLTRIM((v_toolperfil))+" and t.usuario = '"+alltrim(_SYSUSUARIO)+"'  group by t.idmenu order by m.codigo "

verror=sqlrun(vconeccion,'TBMENU')
IF !verror THEN 
	MESSAGEBOX('Ha ocurrido un error al obtener el menu de ToolBar Menu...',0+64,'Error')
	RETURN 	
ENDIF 

SELECT TBMENU
GO TOP 
IF EOF() THEN 
	sqlmatriz(1)="select m.* from toolbarmenu t left join  menusql m on t.idmenu = m.idmenu "
	sqlmatriz(3)="where t.idperfil = 1 and t.usuario = 'ADMINISTRADOR'  group by t.idmenu order by m.codigo "

	verror=sqlrun(vconeccion,'TBMENU')
	IF !verror THEN 
		MESSAGEBOX('Ha ocurrido un error al obtener el menu de ToolBar Menu...',0+64,'Error')
		RETURN 	
	ENDIF 
ENDIF 
=abreycierracon(vconeccion,'')

SELECT TBMENU
GO TOP 
IF EOF() THEN 
	RETURN 
ENDIF 

DO WHILE !EOF()

	IF !EMPTY(ALLTRIM(tbmenu.comando)) THEN 

	

		toolbarmenu.addobject('cm'+alltrim(STR(tbmenu.idmenu)),'commandmenu')

		eje = "toolbarmenu."+"cm"+alltrim(STR(tbmenu.idmenu))+".visible = .t."
		&eje 

		eje = "toolbarmenu."+"cm"+alltrim(STR(tbmenu.idmenu))+".tag = '"+alltrim(tbmenu.comando)+"'"
		&eje 

		eje = "toolbarmenu."+"cm"+alltrim(STR(tbmenu.idmenu))+".ToolTipText = '"+alltrim(tbmenu.descrip)+"'"
		&eje 
	
		eje = "toolbarmenu."+"cm"+alltrim(STR(tbmenu.idmenu))+".caption = ''"
		&eje 

		v_icono =  IIF(!EMPTY(ALLTRIM(tbmenu.imagen)),"'"+ALLTRIM(_sysservidor)+"iconos\"+ALLTRIM(tbmenu.imagen)+"'","'"+ALLTRIM(_sysservidor)+"iconos\run1.png'")
		eje = "toolbarmenu."+"cm"+alltrim(STR(tbmenu.idmenu))+".Picture = "+v_icono
		&eje 
	
	ENDIF 

	SELECT tbmenu
	SKIP 
ENDDO 
SELECT tbmenu
USE 

ENDFUNC 


FUNCTION copyarchivo
	PARAMETERS p_archivo, p_pathn
*#/----------------------------------------
*** COPIAR IMAGENES ***
*#/----------------------------------------
	
	j = LEN(ALLTRIM(p_archivo))
	LON = J
	DO WHILE ! (SUBSTR(p_archivo,j,1) == "\") AND ! (ALLTRIM(p_archivo) == "") AND j > 0
		j = j - 1
	ENDDO 

	IF !(ALLTRIM(p_archivo) == "") AND J > 0 THEN 
		viejo_directorio = LOWER(SUBSTR(p_archivo,1,J))	
	ENDIF 

	IF !(ALLTRIM(p_archivo) == "") THEN 
		a_archivo = LOWER(SUBSTR(p_archivo,J+1,LON - J + 1))
	ENDIF 
	
	
	nuevo_completo   = ALLTRIM(p_pathn)+ALLTRIM(a_archivo)
	viejo_completo   = LOWER(ALLTRIM(p_archivo))
	
	IF ALLTRIM(UPPER(viejo_completo))==ALLTRIM(UPPER(nuevo_completo)) THEN 
		* El Archivo ya esta en el directorio de la red
	ELSE 
			v_var = 0	
			new_nuevo_completo = ALLTRIM(nuevo_completo)
			DO WHILE FILE(new_nuevo_completo) = .t.
				v_var = v_var + 1
				new_nuevo_completo = ALLTRIM(SUBSTR(nuevo_completo,1,(LEN(ALLTRIM(nuevo_completo))-4))+ALLTRIM(STR(v_var))+SUBSTR(nuevo_completo,(LEN(ALLTRIM(nuevo_completo))-3)))
			ENDDO 
			nuevo_completo = ALLTRIM(new_nuevo_completo)	
			v_ejecutar = "COPY FILE '"+ALLTRIM(viejo_completo)+"' TO '"+ALLTRIM(nuevo_completo)+"'"
			&v_ejecutar				
	ENDIF

	j = LEN(ALLTRIM(nuevo_completo))
	LON = J
	DO WHILE ! (SUBSTR(nuevo_completo,j,1) == "\") AND ! (ALLTRIM(nuevo_completo) == "") AND j > 0
		j = j - 1
	ENDDO 

	a_archivo = ""
	IF !(ALLTRIM(nuevo_completo) == "") THEN 
		a_archivo = ALLTRIM(LOWER(SUBSTR(nuevo_completo,J+1,LON - J + 1)))
	ENDIF 
	
RETURN a_archivo
ENDFUNC 


FUNCTION copyimg
	PARAMETERS p_img, p_pathn, p_codigo
*#/----------------------------------------
**** COPIAR IMAGENES ****
*#/----------------------------------------
	
	j = LEN(ALLTRIM(p_img))
	LON = J
	DO WHILE ! (SUBSTR(p_img,j,1) == "\") AND ! (ALLTRIM(p_img) == "") AND j > 0
		j = j - 1
	ENDDO 

	IF !(ALLTRIM(p_img) == "") AND J > 0 THEN 
		viejo_directorio = LOWER(SUBSTR(p_img,1,J))	
	ENDIF 

	IF !(ALLTRIM(p_img) == "") THEN 
		a_archivo = LOWER(ALLTRIM(p_codigo))
	ENDIF 
	
	
	nuevo_completo   = ALLTRIM(p_pathn)+ALLTRIM(a_archivo)
	viejo_completo   = LOWER(ALLTRIM(p_img))
	
	IF ALLTRIM(UPPER(viejo_completo))==ALLTRIM(UPPER(nuevo_completo)) THEN 
		* El Archivo ya esta en el directorio de la red
	ELSE 
			v_var = 0	
			new_nuevo_completo = ALLTRIM(nuevo_completo)
			DO WHILE FILE(new_nuevo_completo) = .t.
				v_var = v_var + 1
				new_nuevo_completo = ALLTRIM(SUBSTR(nuevo_completo,1,(LEN(ALLTRIM(nuevo_completo))-4))+ALLTRIM(STR(v_var))+SUBSTR(nuevo_completo,(LEN(ALLTRIM(nuevo_completo))-3)))
			ENDDO 
			nuevo_completo = ALLTRIM(new_nuevo_completo)
			
			v_ejecutar = "COPY FILE (viejo_completo) TO (nuevo_completo)"
			&v_ejecutar				
	ENDIF

	j = LEN(ALLTRIM(nuevo_completo))
	LON = J
	DO WHILE ! (SUBSTR(nuevo_completo,j,1) == "\") AND ! (ALLTRIM(nuevo_completo) == "") AND j > 0
		j = j - 1
	ENDDO 

	a_archivo = ""
	IF !(ALLTRIM(nuevo_completo) == "") THEN 
		a_archivo = ALLTRIM(LOWER(SUBSTR(nuevo_completo,J+1,LON - J + 1)))
	ENDIF 
	
RETURN a_archivo
ENDFUNC 



FUNCTION copydocu
	PARAMETERS p_docu, p_pathn, p_codigo, p_viejo
*#/----------------------------------------
*** COPIAR DOCUMENTOS ***
** PARAMETROS: p_docu: Path completo del original; p_pathn: Nueva ubicación; p_codigo: código para diferenciar, p_viejo: Nombre del Archivo Original
*#/----------------------------------------
	
	j = LEN(ALLTRIM(p_docu))
	LON = J
	DO WHILE ! (SUBSTR(p_docu,j,1) == "\") AND ! (ALLTRIM(p_docu) == "") AND j > 0
		j = j - 1
	ENDDO 

	IF !(ALLTRIM(p_docu) == "") AND J > 0 THEN 
		viejo_directorio = LOWER(SUBSTR(p_docu,1,J))	
	ENDIF 


	IF !(ALLTRIM(p_docu) == "") THEN 
		
		a_archivo =LOWER(ALLTRIM(p_codigo))+"_"+ALLTRIM(p_viejo)
	ENDIF 
	
	
	nuevo_completo   = ALLTRIM(p_pathn)+"\"+ALLTRIM(a_archivo)
	viejo_completo   = LOWER(ALLTRIM(p_docu))
	
	IF ALLTRIM(UPPER(viejo_completo))==ALLTRIM(UPPER(nuevo_completo)) THEN 
		* El Archivo ya esta en el directorio de la red
	ELSE 
			v_var = 0	
			new_nuevo_completo = ALLTRIM(nuevo_completo)
			DO WHILE FILE(new_nuevo_completo) = .t.
				v_var = v_var + 1
				new_nuevo_completo = ALLTRIM(SUBSTR(nuevo_completo,1,(LEN(ALLTRIM(nuevo_completo))-4))+ALLTRIM(STR(v_var))+SUBSTR(nuevo_completo,(LEN(ALLTRIM(nuevo_completo))-3)))
			ENDDO 
			nuevo_completo = ALLTRIM(new_nuevo_completo)
			*v_ejecutar = "COPY FILE (viejo_completo) TO (nuevo_completo)"
			v_ejecutar = "COPY FILE '"+viejo_completo+"' TO '"+nuevo_completo+"'" 
			
			&v_ejecutar				
	ENDIF

	j = LEN(ALLTRIM(nuevo_completo))
	LON = J
	DO WHILE ! (SUBSTR(nuevo_completo,j,1) == "\") AND ! (ALLTRIM(nuevo_completo) == "") AND j > 0
		j = j - 1
	ENDDO 

	a_archivo = ""
	IF !(ALLTRIM(nuevo_completo) == "") THEN 
		a_archivo = ALLTRIM(LOWER(SUBSTR(nuevo_completo,J+1,LON - J + 1)))
	ENDIF 
	
RETURN a_archivo
ENDFUNC 
*Convierte FECHA tipo CHAR a DATE
*COnvierte FECHA tipo DATE a CHAR
FUNCTION CFTOFC 
PARAMETERS P_TRANS
IF TYPE("P_TRANS")="C" THEN
	IF !EMPTY(P_TRANS) THEN 
		
		IF VAL(ALLTRIM(SUBSTR(P_TRANS,1,4)))>1900 AND VAL(ALLTRIM(SUBSTR(P_TRANS,5,2)))>0 AND VAL(ALLTRIM(SUBSTR(P_TRANS,5,2)))<13 AND ;
		    VAL(ALLTRIM(SUBSTR(P_TRANS,7,2)))>0 AND VAL(ALLTRIM(SUBSTR(P_TRANS,7,2)))< 32 THEN 
		    
			RETORNO = DATE(VAL(ALLTRIM(SUBSTR(P_TRANS,1,4))),VAL(ALLTRIM(SUBSTR(P_TRANS,5,2))),VAL(ALLTRIM(SUBSTR(P_TRANS,7,2))))
		ELSE
			RETORNO = {//}
		ENDIF 
	ELSE
		RETORNO = {//}
	ENDIF 
ELSE
	IF TYPE("P_TRANS")='D' THEN 
		IF EMPTY(P_TRANS) THEN 
			RETORNO = ""
		ELSE
			RETORNO = SUBSTR(ALLTRIM(DTOC(P_TRANS)),7,4)+SUBSTR(ALLTRIM(DTOC(P_TRANS)),4,2)+SUBSTR(ALLTRIM(DTOC(P_TRANS)),1,2)
		ENDIF 
	ELSE
		RETORNO = -1
	ENDIF 
ENDIF
RETURN RETORNO
ENDFUNC 



FUNCTION BUSCAVALORDB
PARAMETERS b_tabla, b_campoidx, b_valoridx, b_camporet, b_database
*#/----------------------------------------
** FUNCION PARA BUSQUEDA DE VALORES EN TABLAS DE LA BASE DE DATOS **
** RECIBE COMO PARAMETROS LA TABLA EN LA QUE BUSCAR Y EL CAMPO Y VALOR BUSCADO
** DATO ACERCA DEL VALOR A RETORNAR
** EN CASO DE NO HALLAR EL VALOR RETORNA ".NULL."
*#/----------------------------------------
LOCAL varb_retorno 

	IF TYPE('b_valoridx') = 'C' THEN 
		b_valoridx_C = "'"+b_valoridx+"'"
		b_campoidx	= "trim("+ALLTRIM(b_campoidx)+")"
	ELSE
		b_valoridx_C = STR(b_valoridx,10,2)
	ENDIF 

	IF b_database = 0 THEN && busca en database mysql
		vconefind=abreycierracon(0,_SYSSCHEMA)
		sqlmatriz(1)="SELECT "+ALLTRIM(b_camporet)+" as campo from "+b_tabla+" where "+ALLTRIM(b_campoidx)+"=="+alltrim(b_valoridx_C)
		verror=sqlrun(vconefind,"buscatmp")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Funcion BUSCAVALORDB ",0+48+0,"Error")
		ENDIF 
		=abreycierracon(vconefind,"")
		
	ELSE
		eje = "SELECT "+ALLTRIM(b_camporet)+" as campo from "+b_tabla+" into cursor buscatmp where "+ALLTRIM(b_campoidx)+"=="+alltrim(b_valoridx_C)
		&eje 
	ENDIF 
	
	SELECT buscatmp 
	GO top
	IF !EOF() THEN 
		varb_retorno = buscatmp.campo
	ELSE 
		varb_retorno = Null
	ENDIF 
	SELECT buscatmp
	USE 
RETURN varb_retorno
ENDFUNC 



FUNCTION Edad(tdNac, tdHoy) 
*#/----------------------------------------
* FUNCTION Edad(tdNac, tdHoy) 
*----------------------------------------------------- 
* Calcula la edad pasando como parámetros: 
* tdNac = Fecha de nacimiento 
* tdHoy = Fecha a la cual se calcula la edad. 
* Por defecto toma la fecha actual. 
*#/----------------------------------------
LOCAL lnAnio 
IF EMPTY(tdHoy) 
tdHoy = DATE() 
ENDIF 
IF TYPE("tdNac")='C' THEN 
	tdNacD = cftofc(tdNac)
ELSE
	tdNacD = tdNac
ENDIF 
lnAnio = YEAR(tdHoy) - YEAR(tdNacD) 
IF GOMONTH(tdNacD, 12 * lnAnio) > tdHoy 
lnAnio = lnAnio - 1 
ENDIF 
RETURN lnAnio 
ENDFUNC 


FUNCTION seteoteclafn
PARAMETERS p_matriz_p , p_opcion, p_objeto, p_teclafn
*#/----------------------------------------
** SETEO DE MATRIZ PARA EJECUCION DE FUNCIONES DE LOS BOTONES **
*#/----------------------------------------
	PRIVATE p_matriz 
	p_matriz = p_matriz_p+"FN"
	retorno =""
	DO CASE 
		CASE p_opcion = 0 &&CREACION DEL ARREGLO
			eje = "public array "+p_matriz+"(20,2)"
			&eje
			FOR i = 1 TO 20
					eje 	= p_matriz+"("+ALLTRIM(STR(i))+",1) = ''"
					&eje					
					eje 	= p_matriz+"("+ALLTRIM(STR(i))+",2) = ''"
					&eje					
			ENDFOR 

		CASE p_opcion = 1 &&ASIGNACION DE VALORES DE BOTONES
			i 	= 1
			var1 =""
			eje 	= "var1 = "+p_matriz+"("+ALLTRIM(STR(i))+",1)"
			&eje
			DO WHILE i <=20 AND !EMPTY(var1)
				
				i = i + 1
				eje 	= "var1 = "+p_matriz+"("+ALLTRIM(STR(i))+",1)"
				&eje		
			ENDDO 
			IF i <= 20 THEN 
				eje 	= p_matriz+"("+ALLTRIM(STR(i))+",1) = '"+ALLTRIM(p_objeto)+"'"
				&eje					
				eje 	= p_matriz+"("+ALLTRIM(STR(i))+",2) = '"+ALLTRIM(p_teclafn)+"'"
				&eje					
			ENDIF 
		
		CASE p_opcion = 2 && SETEA TECLAS DE FUNCION EN EL FORMULARIO
			
			FOR i = 1 TO 12 
				eje = "on key label F"+ALLTRIM(STR(I))
				&eje
				eje = "on key label CTRL+F"+ALLTRIM(STR(I))
				&eje
				eje = "on key label ALT+F"+ALLTRIM(STR(I))
				&eje
			ENDFOR 
			
			FOR I = 1 TO  20
				vtecla1 =" v1 = "+ p_matriz+"("+ALLTRIM(STR(i))+",2)"
				vtecla2 =" v2 = "+ p_matriz+"("+ALLTRIM(STR(i))+",1)"
				&vtecla1
				&vtecla2
				IF !EMPTY(ALLTRIM(v1)) THEN
					eje 	= "on key label "+v1+" "+p_matriz_p+"."+v2+".click ()"
					&eje
				ENDIF 
				
			ENDFOR 

		CASE p_opcion = 3 && LIBERA LAS TECLAS SETEADAS
			FOR i = 1 TO 12 
				eje = "on key label F"+ALLTRIM(STR(I))
				&eje
				eje = "on key label CTRL+F"+ALLTRIM(STR(I))
				&eje
				eje = "on key label ALT+F"+ALLTRIM(STR(I))
				&eje
			ENDFOR 
			eje = "release "+ p_matriz 
			&eje		
		OTHERWISE 
	ENDCASE 
	
	RETURN retorno 
ENDFUNC 



FUNCTION maxnumerocom
PARAMETERS p_idcomproba, p_pventa, v_incre 
*#/----------------------------------------
* FUNCION PARA TRAER EL MAXIMO NUMERO DE UN COMPROBANTE
* RECIBE COMO PARAMETROS EL ID DEL COMPROBANTE, EL PUNTO DE VENTA Y EL VALOR A INCREMENTAR EL NUMERO
* DEVUELVE EL VALOR INCREMENTADO SEGUN EL PARAMETRO DE INCREMENTO RECIBIDO
*#/----------------------------------------

	compruebaCajaReca()


vconeccionF = abreycierracon(0,_SYSSCHEMA)

*sqlmatriz(1)="UPDATE compactiv set maxnumero = ( maxnumero + "+ALLTRIM(STR(v_incre))+" ) "
*sqlmatriz(2)=" WHERE puntov = "+ALLTRIM(p_puntov)+" and idnumera in ( select idnumera from comprobantes where idcomproba = "+STR(p_idcomproba)+" ) "
*verror=sqlrun(vconeccionF,"upmaximo")
*IF verror=.f.  
*    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del maximo Numero de Comprobantes ",0+48+0,"Error")
*ENDIF 

sqlmatriz(1)="UPDATE compactiv set maxnumero = ( maxnumero + "+ALLTRIM(STR(v_incre))+" ) "
sqlmatriz(2)=" WHERE pventa = "+ALLTRIM(STR(p_pventa))+" and idcomproba = "+ALLTRIM(STR(p_idcomproba))
verror=sqlrun(vconeccionF,"upmaximo")
IF verror=.f.  
    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del maximo Numero de Comprobantes ",0+48+0,"Error")
ENDIF 



*sqlmatriz(1)="select a.maxnumero as maxnro FROM comprobantes c "
*sqlmatriz(2)="LEFT JOIN compactiv a ON a.idnumera = c.idnumera " 
*sqlmatriz(3)="WHERE c.idcomproba = "+ STR(p_idcomproba) + " AND a.puntov = " + p_puntov


sqlmatriz(1)="select maxnumero as maxnro FROM compactiv "
sqlmatriz(2)="WHERE idcomproba = "+ ALLTRIM(STR(p_idcomproba)) + " AND pventa = " + ALLTRIM(STR(p_pventa))


verror=sqlrun(vconeccionF,"maximo")
IF verror=.f.  
    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de Comprobantes ",0+48+0,"Error")
ENDIF 

* me desconecto	
=abreycierracon(vconeccionF,"")

v_maximo = IIF(ISNULL(maximo.maxnro),0,maximo.maxnro)

SELECT maximo
USE IN maximo

RETURN v_maximo


ENDFUNC



FUNCTION maxnumeroidx
PARAMETERS p_campoidx, p_tipo, p_tabla, v_incre , v_autoinc
*#/----------------------------------------
* FUNCION PARA TRAER EL MAXIMO ID O INDICE DE UNA TABLA
* RECIBE COMO PARAMETROS EL CAMPO QUE CONTIENE EL ID O INDICE, EL TIPO DE CAMPO, LA TABLA Y EL VALOR A INCREMENTAR EL ID
* DEVUELVE EL VALOR INCREMENTADO SEGUN EL PARAMETRO DE INCREMENTO RECIBIDO (SOLO SI ES NUMERO)
* SI V_AUTOINC ES .T. significa que el campo indice es autoincremental en la bd Y DEBE devolver "0"
*#/----------------------------------------

	v_tipoCampo = ""


	IF p_tipo = 'I'

		IF v_autoinc = .t. THEN 
			RETURN 0
		ENDIF 
		
		vconeccionFm = abreycierracon(0,_SYSSCHEMA)
		*INTEGER
		v_tipocampo = "I"
		sqlmatriz(1)="UPDATE tablasidx set maxvalori = ( maxvalori + "+ALLTRIM(STR(v_incre))+" ) "
		sqlmatriz(2)=" WHERE campo = '"+ALLTRIM(p_campoidx)+"' and tabla = '"+ALLTRIM(p_tabla)+"' and tipocampo = '"+ALLTRIM(v_tipocampo)+"'"

		verror=sqlrun(vconeccionFm,"idxmaximo")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del maximo Numero de indice ",0+48+0,"Error")
			=abreycierracon(vconeccionFm,"")
		    RETURN 
		ENDIF 
		
		*** Vuelvo a buscar para corroborar
		
		
		sqlmatriz(1)="select maxvalori as maxnro FROM tablasidx "
		sqlmatriz(2)="WHERE campo = '"+ALLTRIM(p_campoidx)+"' and tabla = '"+ALLTRIM(p_tabla)+"' and tipocampo = '"+ALLTRIM(v_tipocampo)+"'" 
			
		verror=sqlrun(vconeccionFm,"maximo")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA ddel maximo Numero de indice",0+48+0,"Error")
		ENDIF 

		* me desconecto	
		=abreycierracon(vconeccionFm,"")
		v_maximo = IIF(ISNULL(maximo.maxnro),0,maximo.maxnro)

		SELECT maximo
		USE IN maximo

		RETURN v_maximo

		

	ELSE
		IF p_tipo = 'C'
			*CHAR
			v_tipocampo = "C"
			
			vconeccionFm = abreycierracon(0,_SYSSCHEMA)
		
					
			sqlmatriz(1)="select maxvalorc as maxnro FROM tablasidx "
			sqlmatriz(3)="WHERE campo = '"+ALLTRIM(p_campoidx)+"' and tabla = '"+ALLTRIM(p_tabla)+"' and tipocampo = '"+ALLTRIM(v_tipocampo)+"'" 

			verror=sqlrun(vconeccionFm,"maximo")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA ddel maximo Numero de indice",0+48+0,"Error")
			ENDIF 

			* me desconecto	
			=abreycierracon(vconeccionFm,"")

			v_maximo = IIF(ISNULL(maximo.maxnro),"",maximo.maxnro)

			SELECT maximo
			USE IN maximo

			RETURN v_maximo
			
			
		ELSE
			
		ENDIF 

	ENDIF 

RETURN -1
ENDFUNC
 

 FUNCTION cursorAXML
 PARAMETERS p_nombre,p_idcomp
 
	IF TYPE("p_idcomp") = 'N'
	 SELECT * FROM &p_nombre WHERE idfactura = p_idcomp INTO TABLE tablaaxml
	ELSE
	 SELECT * FROM &p_nombre INTO TABLE tablaaxml
	ENDIF 

	 
	 SELECT tablaaxml
	 GO TOP 



	CURSORTOXML("tablaaxml","archivoXML.xml",1,512)

ENDFUNC 




FUNCTION validarCompAutorizado
PARAMETERS p_idcomprobante
*#/----------------------------------------
* FUNCIÓN PARA VALIDAR COMPROBANTES AUTORIZADOS
* PARAMETROS: P_IDCOMPROBANTE
* RETORNO: Retorna True si el comprobante NO está autorizado, False en caso de que esté autorizado
*#/----------------------------------------
IF TYPE('p_idcomprobante') = 'N'

	vconeccion=abreycierracon(0,_SYSSCHEMA)	
			
			sqlmatriz(1)="Select f.* from facturasfe f  "
			sqlmatriz(2)=" where f.idfactura = "+ ALLTRIM(STR(v_idcomprobante))

			verror=sqlrun(vconeccion,"factufe_sql")
			IF verror=.f.  
				IF p_nomsg = .f. THEN 
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la facturasFE",0+48+0,"Error")
			   	ENDIF 
			    v_autorizar = .F.
			    RETURN v_autorizar 
			ELSE
				*v_idcomproba = 0
				v_pventa	= 0
				
				
				SELECT factufe_sql
				GO TOP 
				
				DO WHILE NOT EOF()
					
					v_resultado = factufe_sql.resultado
					v_caecesp 	= factufe_sql.caecesp
					
					IF v_resultado = "A" OR v_caecesp <> ""
					
						IF p_nomsg = .f. THEN 
							MESSAGEBOX("El comprobante ID: "+ALLTRIM(STR(v_idcomprobante))+" ya se encuentra autorizado",0+48+0,"Error al autorizar")
						ENDIF 
						v_autorizar = .F.
						RETURN v_autorizar
					ENDIF 
					
					SELECT factufe_sql
					SKIP 1
				
				ENDDO 
			ENDIF 
			
		=abreycierracon(vconeccion,"") && Cierro conección
	RETURN .T.
ELSE
	MESSAGEBOX("Parametro incorrecto en la validación del comprobante (validarCompAutorizador)",0+16+256,"Validar comprobante")

	RETURN .F.

ENDIF 

ENDFUNC 

FUNCTION autorizarCompFE
PARAMETERS p_idregistro, p_idcomproba, p_nomsg
*#/----------------------------------------
* FUNCIÓN PARA AUTORIZAR COMPROBANTES
* PARAMETROS: P_IDCOMPROBANTE, ID DEL COMPROBANTE A AUTORIZAR
* RETORNO: Retorna True si no hubo errores al intentar autorizar el comprobante (NO significa que se haya APROBADO), retorna False en caso que haya ocurrido un error en la autorización
*#/----------------------------------------

	v_idcomprobante= p_idregistro
	v_autorizar = .F.
	v_objconfigurado = .F.
	v_idcomproba	= p_idcomproba
	v_error = .F.
LOCAL loException AS Exception


	*** COMPRUEBO QUE EL COMPROBANTE NO ESTÉ AUTORIZADO **
	v_validarComp =validarCompAutorizado(v_idcomprobante)
	
	IF v_validarComp = .F.
		RETURN .F. 
	ENDIF 
	
	
	TRY 
		v_tipoObj = TYPE("objModuloAFIP")
		
		IF v_tipoObj <> "O" && No se creo el objeto
		
			public objModuloAFIP
			objModuloAFIP = CREATEOBJECT("ModuloAFIP.ModuloAFIP")
			
		ENDIF 
		
		
		v_objconfigurado = objModuloAFIP.Configurado 
		
		IF v_objConfigurado = .F.
		
		
			v_ubicacionCertificado = STRTRAN(ALLTRIM(_SYSSERVIDOR+"AFIP\"+ALLTRIM(_SYSNOMBRECERT)),"\","\\")
			v_cuitSinGuiones	 	= ALLTRIM(STRTRAN(_SYSCUIT,'-',''))
			v_ticketAcceso			= STRTRAN(ALLTRIM(_SYSSERVIDOR+"AFIP\"+"TA"+v_cuitSinGuiones),"\","\\")
			v_log					= STRTRAN(ALLTRIM(_SYSSERVIDOR+"AFIP\"+"LOG"+v_cuitSinGuiones+".txt"),"\","\\")
									
*			v_objconfigurado	= objModuloAFIP.CargaConfiguracion(_SYSSERVICIOFE, _SYSURLWSAA, _SYSSERVICIOAFIP, _SYSPROXY, _SYSPROXYUSU, _SYSPROXYPASS, _SYSCERTIFICADO, _SYSTA, _SYSINTAUT, _SYSINTTA, _SYSNOMFISCAL, _SYSCUIT, _SYSLOGAFIP)
			v_objconfigurado	= objModuloAFIP.CargaConfiguracion(ALLTRIM(_SYSSERVICIOFE), ALLTRIM(_SYSURLWSAA), ALLTRIM(_SYSSERVICIOAFIP), ALLTRIM(_SYSPROXY), ALLTRIM(_SYSPROXYUSU), ALLTRIM(_SYSPROXYPASS), ALLTRIM(v_ubicacionCertificado), ALLTRIM(v_ticketAcceso), _SYSINTAUT, _SYSINTTA, ALLTRIM(_SYSNOMFISCAL), ALLTRIM(_SYSCUIT), ALLTRIM(v_log),ALLTRIM(_SYSSERVCONTRIB),ALLTRIM(_SYSSERVICIOPER))

			IF v_objconfigurado = .T.
			
				v_objerror = objModuloAFIP.Error
				
				IF v_objerror = .T.
				
					v_errores = ""
					v_errores = objModuloAFIP.Errores
					IF p_nomsg = .f. THEN 
						MESSAGEBOX("Errores: "+ALLTRIM(v_errores))
					ENDIF 
					
					RETURN .F.
				ENDIF 
					
				v_observaciones = objModuloAFIP.Observaciones
				IF EMPTY(v_observaciones) = .F.
					IF p_nomsg = .f. THEN 
						MESSAGEBOX("Observaciones: "+ALLTRIM(v_observaciones))
					ENDIF 
				ENDIF 
				
							
			ELSE
				IF p_nomsg = .f. THEN 	
					MESSAGEBOX("Configuración del modulo AFIP INCORRECTA")
				ENDIF 					
				v_objerror = objModuloAFIP.Error
				
				IF v_objerror = .T.
				
					v_errores = ""
					v_errores = objModuloAFIP.Errores
					IF p_nomsg = .f. THEN 
						MESSAGEBOX("Errores: "+ALLTRIM(v_errores))
					ENDIF 
				ENDIF 
					
				v_observaciones = objModuloAFIP.Observaciones
				
				IF p_nomsg = .f. THEN 
					MESSAGEBOX("Observaciones: "+ALLTRIM(v_observaciones))
				ENDIF 
						
				RETURN .F.
				
			ENDIF 
		ENDIF 
				
		
		
	
	CATCH TO loException
			
		IF p_nomsg = .f. THEN 
*			MESSAGEBOX(lcErrorMsg,0+48+0,"Se produjo un Error")


			
			    
      MESSAGEBOX(ALLTRIM(loException.MESSAGE),0+48+0,"Se produjo un Error")
      
		ENDIF 

		v_autorizar = .F.
		v_error = .T.


	ENDTRY	

	IF v_error = .T.

		RETURN .F.
	ENDIF 
					
	*** Armo el archivo XML para mandarlo a autorizar ***

		v_ubicacionXML = armarComprobanteXML(v_idcomprobante)

	*** Mando a autorizar el comprobante pasandole la ubicación del archivo  y el ID ***

		*** COMPRUEBO QUE EL COMPROBANTE NO ESTÉ AUTORIZADO **
			v_validarComp =validarCompAutorizado(v_idcomprobante)
			
			IF v_validarComp = .F.
				RETURN .F. 
			ENDIF 
		v_respuesta = objModuloAFIP.AutorizarComp(v_ubicacionXML,v_idComprobante)
			
				
		v_observaciones = objModuloAFIP.Observaciones

			
		IF EMPTY(v_observaciones) = .F.
			IF p_nomsg = .f. THEN 
				MESSAGEBOX("Observaciones: "+ALLTRIM(v_observaciones))				
			ENDIF 
		ENDIF 
	
		IF v_respuesta = .T. && Hubo respuesta del objeto que maneja el Módulo de AFIP, sin errores
		
			vcan_ubica=alines(arreglo,v_ubicacionXML, ";")
			v_ubicacionCompXML = arreglo(1)
			XMLTOCURSOR(v_ubicacionCompXML,"respuestaComp",512)

			SELECT respuestaComp
			GO TOP 
			ALTER table respuestaComp alter COLUMN fchvtopago C(8)
			SELECT respuestaComp
			GO TOP 
			IF NOT EOF()
				*** REGISTRO LA RESPUESTA DEL COMPROBANTE EN LA TABLA facturasfe ***
									
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				*ALTER table respuestaComp alter COLUMN idcomproba I
				
				*thisform.calcularmaxh
				v_idfe = maxnumeroidx("idfe","I","facturasfe",1)
				v_idfactura = respuestaComp.idfactura
				v_fecha		= ALLTRIM(STR(respuestaComp.fecha))
				v_resultado	= respuestaComp.resultado
				*v_idcomproba= respuestaComp.idcomproba
				v_pventa	= respuestaComp.pventa

				IF TYPE('v_pventa') = 'L' THEN 
					v_pventa = IIF(v_pventa=.f.,0,1)
				ENDIF 
				IF TYPE('v_idfactura') = 'L' THEN 
					v_idfactura = IIF(v_idfactura=.f.,0,1)
				ENDIF 
				
				IF ALLTRIM(v_resultado) == "A"
					v_caecesp	= ALLTRIM(STR(respuestaComp.cespcae,14,0))

					v_caecespven= ALLTRIM(STR(respuestaComp.caecespven))
					v_numerofe	= respuestaComp.numero
					IF TYPE('v_numerofe') = 'L' THEN 
						v_numerofe = IIF(v_numerofe=.f.,0,1)
					ENDIF 
					v_autorizar = .T.
				ELSE
					v_caecesp	= ""
					v_caecespven= ""
					v_numerofe	= 0
					v_autorizar = .F.
				endif	
				
*!*					v_observa	= respuestaComp.observa
*!*					v_errores = respuestaComp.errores
				v_observa = ALLTRIM(SUBSTR(STRTRAN(respuestaComp.observa,"'","")+SPACE(250),1,250))
				v_errores = ALLTRIM(SUBSTR(STRTRAN(respuestaComp.errores,"'","")+SPACE(250),1,250))
				DIMENSION lamatriz(9,2)
				
				lamatriz(1,1)='idfe'
				lamatriz(1,2)=ALLTRIM(STR(v_idfe))
				lamatriz(2,1)='idfactura'
				lamatriz(2,2)=ALLTRIM(STR(v_idfactura))
				lamatriz(3,1)='fecha'
				lamatriz(3,2)="'"+ALLTRIM(v_fecha)+"'"
				lamatriz(4,1)='resultado'
				lamatriz(4,2)="'"+ALLTRIM(v_resultado)+"'"
				lamatriz(5,1)='caecesp'
				lamatriz(5,2)="'"+ALLTRIM(v_caecesp)+"'"
				lamatriz(6,1)='caecespven' 
				lamatriz(6,2)="'"+ALLTRIM(v_caecespven)+"'"
				lamatriz(7,1)='observa'
				lamatriz(7,2)="'"+alltrim(v_observa)+"'"
				lamatriz(8,1)='errores'
				lamatriz(8,2)="'"+ALLTRIM(v_errores)+"'"
				lamatriz(9,1)='numerofe'
				lamatriz(9,2)=ALLTRIM(STR(v_numerofe))


				
				p_tabla     = 'facturasfe'
				p_matriz    = 'lamatriz'
				vconeccionp=abreycierracon(0,_SYSSCHEMA)
				p_conexion  = vconeccionp
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
				ENDIF	
			
				
				*** Actualizo Tabla de Facturas SI esta autorizada ***
				
				IF ALLTRIM(v_resultado) == "A"
					p_tipoope     = 'U'
					p_condicion   = " idfactura = "+ ALLTRIM(STR(v_idfactura))
					v_titulo      = " LA MODIFICACIÓN "
				
				
					
						DIMENSION lamatriz(4,2)
				
					lamatriz(1,1)='numero'
					lamatriz(1,2)=ALLTRIM(STR(v_numerofe))
					lamatriz(2,1)='cespcae'
					lamatriz(2,2)="'"+ALLTRIM(v_caecesp)+"'"
					lamatriz(3,1)='caecespven' 
					lamatriz(3,2)="'"+ALLTRIM(v_caecespven)+"'"
					lamatriz(4,1)="observa4"
					lamatriz(4,2)=IIF(EMPTY(respuestaComp.fchvtopago),"'"+ALLTRIM(respuestaComp.observa4)+"'","'Fecha Vto.:"+ ;
									ALLTRIM(SUBSTR(respuestaComp.fchvtopago,7,2)+"/"+SUBSTR(respuestaComp.fchvtopago,5,2)+"/"+SUBSTR(respuestaComp.fchvtopago,1,4))+ ;
									" CBU Emisor:"+ALLTRIM(_SYSCBUMIPYME)+"'")
					
										
					
					p_tabla     = 'facturas'
					p_matriz    = 'lamatriz'
					vconeccionp=abreycierracon(0,_SYSSCHEMA)
					p_conexion  = vconeccionp
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
					ENDIF	
					
					registrarEstado("facturas","idfactura",v_idfactura,'I',"AUTORIZADO")
						
					** Actualizo el maximo numero de comprobante en compactiv
					
					IF v_idcomproba > 0 AND v_pventa > 0 THEN 
						p_tipoope     = 'U'
						p_condicion   = " idcomproba = "+ ALLTRIM(STR(v_idcomproba)) +" and pventa = "+ALLTRIM(STR(v_pventa))+" and "+ALLTRIM(STR(v_numerofe))+" > maxnumero "
					
						v_titulo      = " LA MODIFICACIÓN "
						
						DIMENSION lamatriz(1,2)
					
						lamatriz(1,1)='maxnumero'
						lamatriz(1,2)=ALLTRIM(STR(v_numerofe))
								

						
						p_tabla     = 'compactiv'
						p_matriz    = 'lamatriz'
						vconeccionp=abreycierracon(0,_SYSSCHEMA)
						p_conexion  = vconeccionp
						IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
							IF p_nomsg = .f. THEN 
							    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
							ENDIF 
						ENDIF
					ENDIF 
						
					
					
				ELSE
					registrarEstado("facturas","idfactura",v_idfactura,'I',"RECHAZADO")
				ENDIF 	
				
											
			
				
				abreycierracon(vconeccionp,"")
				
				
			
			ELSE
				v_autorizar = .F.
			ENDIF 
							
			
			
		ELSE	&& Ocurrieron errores
			
			IF p_nomsg = .f. THEN 
				MESSAGEBOX("Ha Ocurrido un Error al autorizar el comprobante en el servicio",0+48+0,"Error")
			ENDIF 					
			v_objerror = objModuloAFIP.Error
			
			IF v_objerror = .T.
			
				v_errores = ""
				v_errores = objModuloAFIP.Errores

				IF p_nomsg = .f. THEN 
					MESSAGEBOX("Errores: "+ALLTRIM(v_errores))
				ENDIF 			
			ENDIF 
				
			v_observaciones = objModuloAFIP.Observaciones

			
			IF EMPTY(v_observaciones) = .F.
				IF p_nomsg = .f. THEN 
					MESSAGEBOX("Observaciones: "+ALLTRIM(v_observaciones))				
				ENDIF 
			ENDIF 
			
			v_autorizar = .F.
		ENDIF 	

	RETURN v_autorizar

ENDFUNC

  
  
  **********************************
  ***** FUNCIONES DE IMPRESIÓN******
  **********************************
  

FUNCTION imprimirFactura
PARAMETERS p_idFactura, p_esElectronica,pEnviarImpresora
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UNA FACTURA (COMPROBANTES DE LA TABLA FACTURA: FACTURA, NC, ND)
* PARAMETROS: P_IDFACTURA, P_ESELECTRONICA
*#/----------------------------------------


	v_idfactura 	= p_idFactura
	v_esElectronica = p_esElectronica 
	v_idperiodo		= 0
	
	IF v_idfactura > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			
		*** Busco los datos de la factura y el detalle
		IF v_esElectronica  = .T.

			sqlmatriz(1)=" Select f.*,d.*, d.descuento as descitem,fe.*,c.*,v.*,fe.numerofe as numFac,c.detalle as detIVA, v.nombre as nomVend,ca.puntov, ifnull(ti.detalle,'CONTADO') as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP, "
			sqlmatriz(2)=" l.nombre as nomLoc, p.nombre as nomProv, com.comprobante as nomcomp, ifnull(se.detalle,'    ') as nservicio "
			sqlmatriz(3)=" from facturas f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(4)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
			sqlmatriz(5)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactu d on f.idfactura = d.idfactura "
			sqlmatriz(6)=" left join facturasfe fe on f.idfactura = fe.idfactura left join condfiscal c on f.iva = c.iva"
			sqlmatriz(7)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(8)=" left join localidades l on f.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
			sqlmatriz(9)=" left join servicios se on se.servicio = f.servicio "
			sqlmatriz(10)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura)) +" order by fe.idfe desc " &&+  " and fe.resultado = 'A'"
			*sqlmatriz(8)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura)) &&+  " and fe.resultado = 'A'"
			
			verror=sqlrun(vconeccionF,"fac_det_sql_au")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
			
			v_idperiodo = fac_det_sql_au.idperiodo
		ELSE
			
			sqlmatriz(1)="Select f.*,d.*, d.descuento as descitem,c.*,v.*,f.numero as numFac, c.detalle as detIVA,ca.puntov,ifnull(ti.detalle,'CONTADO') as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP, "
			sqlmatriz(2)=" l.nombre as nomLoc, p.nombre as nomProv,com.comprobante as nomcomp, ifnull(se.detalle,'    ') as nservicio "
			sqlmatriz(3)=" from facturas f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(4)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa  left join puntosventa pv on ca.pventa = pv.pventa  " 
			sqlmatriz(5)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactu d on f.idfactura = d.idfactura "
			sqlmatriz(6)=" left join condfiscal c on f.iva = c.iva"
			sqlmatriz(7)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(8)=" left join localidades l on f.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
			sqlmatriz(9)=" left join servicios se on se.servicio = f.servicio "
			sqlmatriz(10)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"fac_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF

			v_idperiodo = fac_det_sql.idperiodo
		
		ENDIF 
		
		
		*** Busco los datos de los impuestos
			sqlmatriz(1)="Select fi.detalle as detaIMP, fi.neto as netoIMP, fi.razon as razonIMP, fi.importe as importeIMP, ai.tipo as tipoIMP "
			sqlmatriz(2)=" from facturasimp fi" 
			sqlmatriz(3)=" left join impuestos i on fi.impuesto = i.impuesto "
			sqlmatriz(4)=" left join afipimpuestos ai on i.idafipimp = ai.idafipimp "
			sqlmatriz(5)=" where fi.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"impuestos_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		

		*** Busco los datos de las deudas asociadas a la factura 	
			sqlmatriz(1)=" Select idfacturad, idfactura, idfcdeuda, detalle , importe  "
			sqlmatriz(2)=" from facturasd  " 
			sqlmatriz(3)=" where importe > 0 and idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"deuda_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  las deudas",0+48+0,"Error")
			ENDIF

		*** Busco los datos de las Cuotas asociadas a la factura 	
			sqlmatriz(1)=" Select idcuotafc, idfactura, cuota , cancuotas , importe , fechavenc "
			sqlmatriz(2)=" from facturascta " 
			sqlmatriz(3)=" where importe > 0 and idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"cuotas_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  las deudas",0+48+0,"Error")
			ENDIF

		*** Busco los datos de las Bocas de Servicios asociadas 	
			sqlmatriz(1)=" Select b.idfacbser, b.idfactura, b.bocanumero, b.ruta1, b.folio1, "
			sqlmatriz(2)=" b.ruta2, b.folio2, b.direccion, b.idtiposer, b.idcateser, b.valorref, b.unidadref, "
			sqlmatriz(3)=" b.manterior, b.mactual, b.consextra, b.consumo, t.detalle as detatipo, c.detalle as detacate "
			sqlmatriz(4)=" from facturasbser b " 
			sqlmatriz(5)=" left join tiposervicio t on t.idtiposer = b.idtiposer "
			sqlmatriz(6)=" left join cateservicio c on c.idcateser = b.idcateser "
			sqlmatriz(7)=" where b.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"bocas_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  las deudas",0+48+0,"Error")
			ENDIF

		*** Busco los datos de Lotes de Facturas ( en caso de que sea una factura de emisión Mensual )	
			sqlmatriz(1)=" Select * from factulotes  where idperiodo = "+ ALLTRIM(STR(v_idperiodo))
			verror=sqlrun(vconeccionF,"flotes_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del lote",0+48+0,"Error")
			ENDIF
			

		IF v_esElectronica  = .T.

			SELECT fac_det_sql_au 
			GO TOP
			IF NOT EOF()
				v_idfe = fac_det_sql_au.idfe
				SELECT * FROM fac_det_sql_au WHERE idfe = v_idfe INTO TABLE .\factu ORDER BY idfacturah
			
			ENDIF 
		ELSE
			SELECT * FROM fac_det_sql 	INTO TABLE .\factu ORDER BY idfacturah
		ENDIF 

	
		
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpIVA WHERE ALLTRIM(tipoIMP) = "IVA" AND importeimp <> 0
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpTRIB WHERE ALLTRIM(tipoIMP) = "TRIBUTO" AND importeimp <> 0

		SELECT * FROM deuda_sql 	INTO TABLE .\deuda

		SELECT * FROM cuotas_sql 	INTO TABLE .\cuotas

		SELECT * FROM bocas_sql 	INTO TABLE .\bocas
		
		SELECT * FROM flotes_sql 	INTO TABLE .\flotes
		
		SELECT factu
		GO TOP 
		IF NOT EOF()
		


			v_idcomproba = factu.idcomproba

			ALTER table factu ADD COLUMN codBarra C(42)
			ALTER table factu ADD COLUMN codQR C(100)
			ALTER table factu ADD COLUMN apeynom C(200)
			ALTER table factu ADD COLUMN totalletra C(254)
			ALTER table factu ADD COLUMN compAso M


	** Agrego el importe total en letras **
		SELECT factu
		v_totalFactura = factu.total
		v_totalEnLetras = enletras(v_totalFactura)
	
	
	** Agrego comprobantes asociados **
	
		v_comproAso  = ""
		tipoComproObjtmp 	= CREATEOBJECT('comprobantesclass')
	

		v_idCompRemi = tipoComproObjtmp.getidcomprobante("REMITO R")
		
		v_idCompFa = tipoComproObjtmp.getidcomprobante("FACTURA A")
		v_idCompFb = tipoComproObjtmp.getidcomprobante("FACTURA B")
		v_idCompFc = tipoComproObjtmp.getidcomprobante("FACTURA C")
		
		v_idCompNDa = tipoComproObjtmp.getidcomprobante("NOTA DE DEBITO A")
		v_idCompNDb = tipoComproObjtmp.getidcomprobante("NOTA DE DEBITO B")
		v_idCompNDc = tipoComproObjtmp.getidcomprobante("NOTA DE DEBITO C")
												
		v_idCompNCa = tipoComproObjtmp.getidcomprobante("NOTA DE CREDITO A")
		v_idCompNCb = tipoComproObjtmp.getidcomprobante("NOTA DE CREDITO B")		
		v_idCompNCc = tipoComproObjtmp.getidcomprobante("NOTA DE CREDITO C")		
		
		
	
	 	v_comproAsore = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompRemi )
	 	
	 	v_comproASo = v_comproAso + ALLTRIM(v_comproAsore)
	 	
	 	v_comproAsofa = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompFa )
	 	v_comproAsofb = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompFb)
		v_comproAsofc = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompFc)
		
		
		v_comproAso = ALLTRIM(v_comproAso)  + ALLTRIM(v_comproAsofa) + ALLTRIM(v_comproAsofb) + ALLTRIM(v_comproAsofc)
		
		v_comproAsoNDa = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNDa )
	 	v_comproAsoNDb = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNDb)
		v_comproAsoNDc = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNDc)
		
		v_comproAso = ALLTRIM(v_comproAso)  + ALLTRIM(v_comproAsoNDa) + ALLTRIM(v_comproAsoNDb) + ALLTRIM(v_comproAsoNDc)
		
		
		v_comproAsoNCa = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNCa )
	 	v_comproAsoNCb = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNCb)
		v_comproAsoNCc = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNCc)
		
		v_comproAso = ALLTRIM(v_comproAso)  + ALLTRIM(v_comproAsoNCa) + ALLTRIM(v_comproAsoNCb) + ALLTRIM(v_comproAsoNCc)
		
	** AGREGO OBSERVACIONES FIJAS EN EL COMPROBANTE SEGÚN CONDICIONES EN LA TABLA observacond  y el total en letras *
	
			ALTER table factu ADD COLUMN obsfijo C(250)
			v_observaFijo = obtenerObservaComp("facturas", "idfactura",v_idfactura, vconeccionF,.F.)
			SELECT factu 
			GO TOP 
			replace ALL obsfijo WITH v_observaFijo, apeynom WITH ALLTRIM(ALLTRIM(apellido)+" "+ALLTRIM(nombre)), totalletra WITH ALLTRIM(v_totalEnLetras), compAso WITH ALLTRIM(v_comproAso)

	** AGREGO EL CALCULO PARA LOS RECARGOS PARA AQUELLAS FACTURAS QUE TIENEN VENCIMIENTOS 1 2 Y 3
			ALTER table factu ADD COLUMN recargo1 n(13,2)
			ALTER table factu ADD COLUMN recargo2 n(13,2)
			GO TOP 
			v_interesdia = factu.interesd
			v_fechavence1 = cftofc(factu.fechavenc1)
			v_fechavence2 = cftofc(factu.fechavenc2)
			v_fechavence3 = cftofc(factu.fechavenc3)
			v_recargo1 	 = IIF(!EMPTY(v_fechavence1) and !EMPTY(v_fechavence2), ((v_fechavence2 - v_fechavence1)* factu.total * (v_interesdia / 100)), 0.00 )
			v_recargo2 	 = IIF(!EMPTY(v_fechavence1) and !EMPTY(v_fechavence3), ((v_fechavence3 - v_fechavence1)* factu.total * (v_interesdia / 100)), 0.00 )
			replace ALL recargo1 WITH v_recargo1, recargo2 WITH v_recargo2 
			
	**********************************************************************************************		
			SELECT factu 
			GO TOP 
			
					
			v_idcomproba = factu.idcomproba
			v_tipoCompAfip	= ALLTRIM(factu.tipcomAFIP)
			
			
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= factu.electro
			v_cuitEmpresa	= _SYSCUIT
			
			IF  ALLTRIM(v_electronica) == "S"

			*** Genero Código de Barras ***

				v_cuitempresa	= ALLTRIM(v_CuitEmpresa)
				
				v_puntoVta		= ALLTRIM(factu.puntov)
				v_fechaVenc_cae	= ALLTRIM(factu.caecespven)
				v_cespcae		= ALLTRIM(factu.cespcae)
			*	v_codBarra		= v_tipoCompAfip+"0"+v_puntoVta+v_Cespcae+v_fechaVenc_cae && EL PUNTO DE VENTA DEBE SER DE 5 DIGITOS
				v_codBarra		= STRTRAN(v_CuitEmpresa,'-','')+v_tipoCompAfip+"0"+v_puntoVta+v_Cespcae+v_fechaVenc_cae && EL PUNTO DE VENTA DEBE SER DE 5 DIGITOS

				v_codBarraD 		= calculaDigitoVerif(v_codBarra)
		
				SELECT factu
				replace ALL codBarra WITH v_codBarraD
				
				
				
			*** Genero Código QR ***
			
				PRIVATE poFbc
				poFbc = CREATEOBJECT("FoxBarcodeQR")
				
				
				  poFbc.nBackColor = RGB(255,255,255) && White
				  poFbc.nBarColor = RGB(0,0,0) && Black
				  poFbc.nCorrectionLevel = 0 && Medium 15%
  
  
  
				SELECT factu
				GO TOP 
						
					
				v_version = 1					
				v_moneda = "PES"
				v_cotizacion = 1
				v_tipoDoc	= 80
	
				v_cuitEmpSG	 	= ALLTRIM(STRTRAN(v_CuitEmpresa,'-',''))
				** Armo la cadena JSON  **
				versionFCompro = ALLTRIM(STR(v_version))

                fechaCompro = SUBSTR(ALLTRIM(factu.fecha),1,4)+'-'+SUBSTR(ALLTRIM(factu.fecha),5,2)+'-'+SUBSTR(ALLTRIM(factu.fecha),7,2)
                cuitE 		= ALLTRIM(v_cuitEmpSG)
	
                ptovta_fe   = ALLTRIM(STR(VAL(v_puntoVta)))
                idtipocbte_fe = ALLTRIM(STR(VAL(factu.tipcomAFIP)))
	
				numerostr  = ALLTRIM(STR(factu.numero))
                imp_totstr = ALLTRIM(STR(ROUND(factu.total,2),13,2))
	
	            monedastr = ALLTRIM(v_moneda)
                cotizacionstr = ALLTRIM(STR(v_cotizacion,13,2))
	
                tipoDocstr = ALLTRIM(STR(v_tipoDoc))
                cuitC = ALLTRIM(STRTRAN(factu.cuit,'-',''))
	
				cae_fe = ALLTRIM(v_cespcae)
										
					v_json1 = ' { "ver":' + versionFCompro+ ',"fecha":"' + fechaCompro +'","cuit":' + cuitE+ ',"ptoVta":' + ptovta_fe + ',"tipoCmp":' + idtipocbte_fe
					v_json2 = ',"nroCmp":' + numerostr  + ',"importe":' + imp_totstr + ',"moneda":"' + monedastr + '","ctz":' + cotizacionstr + ',"tipoDocRec":' + tipoDocstr 
					v_json3 = ',"nroDocRec":' + cuitC + ',"tipoCodAut":"E"' + ',"codAut":' + cae_fe + ' }'
														
				v_json	= ALLTRIM(ALLTRIM(v_json1)+ ALLTRIM(v_json2)+ ALLTRIM(v_json3))
	
			
					
				** Encripto la cadena JSON **
				v_datosCodificados  = "" 
				
				v_datosCodificados  = ALLTRIM(strconv(v_json,13))

				
				** Armo la cadena a codificar en el código QR **
				v_codigo = "https://www.afip.gob.ar/fe/qr/" + "?p=" + ALLTRIM(v_datosCodificados)
								
				** Genero la imagen con el código QR **
		
				v_idRegistroStr = ALLTRIM(STRTRAN(STR((factu.idfactura),10,0),' ','0'))
				v_ubicacionImgen = _SYSESTACION+"\imagenQR_"+ v_idRegistroStr 
				
				v_codQRImg= poFbc.FullQRCodeImage(ALLTRIM(v_codigo),v_ubicacionImgen,250)
				
				v_ubicacionImgen = v_ubicacionImgen+".bmp"
				
			
				
				
				SELECT factu 
				GO TOP 
				replace ALL codqr WITH v_ubicacionImgen
				
				
				SELECT factu 
				GO TOP 
				
				
			*	APPEND GENERAL factu.codqr FROM (v_codQRImg)				
				*replace  codqr WITH v_codQRImg				
				
								
			ELSE
				
			ENDIF 
			
			
			** Si se usa impresion de facturas con codigos de barra 
			** llamo a la dll que genera las barras en el archivo de facturas 
			IF TYPE("_SYSUSACBAR")="C" THEN 
				IF UPPER(_SYSUSACBAR) = "S"	THEN 
					oBar = CREATEOBJECT("processardll.CodigoBarras")
					IF TYPE("oBar") = "O" THEN 
						SELECT factu 
						USE IN factu 
						v_archi_factu = _SYSESTACION+"\factu"
						oBar.CargarBarras(v_archi_factu, _SYSCUIT )
						RELEASE oBar
						USE factu IN 0 
					ENDIF 
				ENDIF 
			ENDIF 
				************************************************************
			
		
			*** Obtengo el historial de saldos para la factura ***
			v_buscasaldo  = .F.	
			IF TYPE('_SYSREGHISCOMP') = 'C'
				IF _SYSREGHISCOMP == 'S'
					v_buscasaldo  = .T.
	
	
					sqlmatriz(1)=" SELECT fecha,entidad, comproba, puntov,numero,abrevia, tipo,total, saldo,imputado "
					sqlmatriz(2)=" FROM histosaldoent "
					sqlmatriz(3)=" where tablaaso = 'facturas' and idregaso = "+ALLTRIM(STR(v_idfactura))
					

					verror=sqlrun(vconeccionF,"hissaldo_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del historial de saldos",0+48+0,"Error")
					ENDIF


					SELECT * from hissaldo_sql INTO TABLE hissaldo
					
					ALTER table hissaldo alter COLUMN fecha C(8)
					ALTER table hissaldo alter COLUMN entidad I
					ALTER table hissaldo alter COLUMN puntov C(4)
					ALTER table hissaldo alter COLUMN numero I
					ALTER table hissaldo alter COLUMN abrevia C(10)
					ALTER table hissaldo alter COLUMN tipo C(10)
					ALTER table hissaldo alter column total N(13,4)
					ALTER table hissaldo alter column saldo N(13,4)
					ALTER table hissaldo alter column imputado N(13,4)
					 					


				endif
				
			endif
			
			=abreycierracon(vconeccionF,"")
				
			IF v_buscasaldo = .T.
				DO FORM reporteform WITH "factu;impIva;impTRIB;deuda;cuotas;bocas;flotes;hissaldo","facturasrc;impIVArc;impTRIBrc;deudarc;cuotasrc;bocasrc;flotesrc;hissaldorc",v_idcomproba,.F.,pEnviarImpresora
			ELSE
				DO FORM reporteform WITH "factu;impIva;impTRIB;deuda;cuotas;bocas;flotes","facturasrc;impIVArc;impTRIBrc;deudarc;cuotasrc;bocasrc;flotesrc",v_idcomproba,.F.,pEnviarImpresora
			ENDIF 

			
		ELSE
			MESSAGEBOX("Error al cargar la factura para imprimir",0+48+0,"Error al cargar la factura")
			
			=abreycierracon(vconeccionF,"")	
			
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la factura ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 

***************************************************************************************************
**Impresión de Facturas desde Tablas Temporarias en la generación de comprobantes por lotes

FUNCTION imprimirTmpFactura
PARAMETERS p_idFactura, p_esElectronica,pEnviarImpresora
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UNA FACTURA DE LA TABLA TEMPORARIA (COMPROBANTES DE LA TABLA FACTURATMP: FACTURA, NC, ND)
* PARAMETROS: P_IDFACTURA, P_ESELECTRONICA
*#/----------------------------------------


	v_idfactura 	= p_idFactura
	v_esElectronica = .F.
	v_idperiodo		= 0
	
	IF v_idfactura > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	

		*** Busco los datos de la factura y el detalle
		IF v_esElectronica  = .T.

*!*				sqlmatriz(1)=" Select f.*,d.*, d.descuento as descitem,fe.*,c.*,v.*,fe.numerofe as numFac,c.detalle as detIVA, v.nombre as nomVend,ca.puntov, ifnull(ti.detalle,'CONTADO') as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP, "
*!*				sqlmatriz(2)=" l.nombre as nomLoc, p.nombre as nomProv, com.comprobante as nomcomp, ifnull(se.detalle,'    ') as nservicio "
*!*				sqlmatriz(3)=" from facturas f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
*!*				sqlmatriz(4)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
*!*				sqlmatriz(5)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactu d on f.idfactura = d.idfactura "
*!*				sqlmatriz(6)=" left join facturasfe fe on f.idfactura = fe.idfactura left join condfiscal c on f.iva = c.iva"
*!*				sqlmatriz(7)=" left join vendedores v on f.vendedor = v.vendedor"
*!*				sqlmatriz(8)=" left join localidades l on f.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
*!*				sqlmatriz(9)=" left join servicios se on se.servicio = f.servicio "
*!*				sqlmatriz(10)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura)) +" order by fe.idfe desc " &&+  " and fe.resultado = 'A'"
*!*				*sqlmatriz(8)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura)) &&+  " and fe.resultado = 'A'"
*!*				
*!*				verror=sqlrun(vconeccionF,"fac_det_sql_au")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
*!*				ENDIF
*!*				
*!*				v_idperiodo = fac_det_sql_au.idperiodo
		ELSE
			
			sqlmatriz(1)="Select f.*,d.*, d.descuento as descitem,c.*,v.*,f.numero as numFac, c.detalle as detIVA,ca.puntov,ifnull(ti.detalle,'CONTADO') as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP, "
			sqlmatriz(2)=" l.nombre as nomLoc, p.nombre as nomProv,com.comprobante as nomcomp, ifnull(se.detalle,'    ') as nservicio "
			sqlmatriz(3)=" from facturastmp f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(4)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa  left join puntosventa pv on ca.pventa = pv.pventa  " 
			sqlmatriz(5)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactutmp d on f.idfactura = d.idfactura "
			sqlmatriz(6)=" left join condfiscal c on f.iva = c.iva"
			sqlmatriz(7)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(8)=" left join localidades l on f.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
			sqlmatriz(9)=" left join servicios se on se.servicio = f.servicio "
			sqlmatriz(10)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"fac_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF

			v_idperiodo = fac_det_sql.idperiodo
		
		ENDIF 
		
		
		*** Busco los datos de los impuestos
			sqlmatriz(1)="Select fi.detalle as detaimp, fi.neto as netoimp, fi.razon as razonimp, fi.importe as importeimp, ai.tipo as tipoimp "
			sqlmatriz(2)=" from facturasimptmp fi" 
			sqlmatriz(3)=" left join impuestos i on fi.impuesto = i.impuesto "
			sqlmatriz(4)=" left join afipimpuestos ai on i.idafipimp = ai.idafipimp "
			sqlmatriz(5)=" where fi.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"impuestos_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		

		*** Busco los datos de las deudas asociadas a la factura 	
			sqlmatriz(1)=" Select idfacturad, idfactura, idfcdeuda, detalle , importe  "
			sqlmatriz(2)=" from facturasdtmp  " 
			sqlmatriz(3)=" where importe > 0 and idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"deuda_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  las deudas",0+48+0,"Error")
			ENDIF

		*** Busco los datos de las Cuotas asociadas a la factura 	
			sqlmatriz(1)=" Select idcuotafc, idfactura, cuota , cancuotas , importe , fechavenc "
			sqlmatriz(2)=" from facturascta " 
			sqlmatriz(3)=" where importe < 0 and idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"cuotas_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  las deudas",0+48+0,"Error")
			ENDIF

		*** Busco los datos de las Bocas de Servicios asociadas 	
			sqlmatriz(1)=" Select b.idfacbser, b.idfactura, b.bocanumero, b.ruta1, b.folio1, "
			sqlmatriz(2)=" b.ruta2, b.folio2, b.direccion, b.idtiposer, b.idcateser, b.valorref, b.unidadref, "
			sqlmatriz(3)=" b.manterior, b.mactual, b.consextra, b.consumo, t.detalle as detatipo, c.detalle as detacate "
			sqlmatriz(4)=" from facturasbsertmp b " 
			sqlmatriz(5)=" left join tiposervicio t on t.idtiposer = b.idtiposer "
			sqlmatriz(6)=" left join cateservicio c on c.idcateser = b.idcateser "
			sqlmatriz(7)=" where b.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"bocas_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  las deudas",0+48+0,"Error")
			ENDIF

		*** Busco los datos de Lotes de Facturas ( en caso de que sea una factura de emisión Mensual )	
			sqlmatriz(1)=" Select * from factulotes  where idperiodo = "+ ALLTRIM(STR(v_idperiodo))
			verror=sqlrun(vconeccionF,"flotes_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del lote",0+48+0,"Error")
			ENDIF
			

		IF v_esElectronica  = .T.

*!*				SELECT fac_det_sql_au 
*!*				GO TOP
*!*				IF NOT EOF()
*!*					v_idfe = fac_det_sql_au.idfe
*!*					SELECT * FROM fac_det_sql_au WHERE idfe = v_idfe INTO TABLE .\factu ORDER BY idfacturah
*!*				
*!*				ENDIF 
		ELSE
			SELECT * FROM fac_det_sql 	INTO TABLE .\factu ORDER BY idfacturah
		ENDIF 

	
		
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpIVA WHERE ALLTRIM(tipoIMP) = "IVA" AND importeimp <> 0
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpTRIB WHERE ALLTRIM(tipoIMP) = "TRIBUTO" AND importeimp <> 0

		SELECT * FROM deuda_sql 	INTO TABLE .\deuda

		SELECT * FROM cuotas_sql 	INTO TABLE .\cuotas

		SELECT * FROM bocas_sql 	INTO TABLE .\bocas
		
		SELECT * FROM flotes_sql 	INTO TABLE .\flotes
		
		SELECT factu
		GO TOP 
		IF NOT EOF()
		


			v_idcomproba = factu.idcomproba

			ALTER table factu ADD COLUMN codBarra C(42)
			ALTER table factu ADD COLUMN codQR C(100)
			ALTER table factu ADD COLUMN apeynom C(200)
			ALTER table factu ADD COLUMN totalletra C(254)
			ALTER table factu ADD COLUMN compAso M


	** Agrego el importe total en letras **
		SELECT factu
		v_totalFactura = factu.total
		v_totalEnLetras = enletras(v_totalFactura)
	
	
	** Agrego comprobantes asociados **
	
		v_comproAso  = ""
		tipoComproObjtmp 	= CREATEOBJECT('comprobantesclass')
	

		v_idCompRemi = tipoComproObjtmp.getidcomprobante("REMITO R")
		
		v_idCompFa = tipoComproObjtmp.getidcomprobante("FACTURA A")
		v_idCompFb = tipoComproObjtmp.getidcomprobante("FACTURA B")
		v_idCompFc = tipoComproObjtmp.getidcomprobante("FACTURA C")
		
		v_idCompNDa = tipoComproObjtmp.getidcomprobante("NOTA DE DEBITO A")
		v_idCompNDb = tipoComproObjtmp.getidcomprobante("NOTA DE DEBITO B")
		v_idCompNDc = tipoComproObjtmp.getidcomprobante("NOTA DE DEBITO C")
												
		v_idCompNCa = tipoComproObjtmp.getidcomprobante("NOTA DE CREDITO A")
		v_idCompNCb = tipoComproObjtmp.getidcomprobante("NOTA DE CREDITO B")		
		v_idCompNCc = tipoComproObjtmp.getidcomprobante("NOTA DE CREDITO C")		
		
		
	
	 	v_comproAsore = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompRemi )
	 	
	 	v_comproASo = v_comproAso + ALLTRIM(v_comproAsore)
	 	
	 	v_comproAsofa = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompFa )
	 	v_comproAsofb = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompFb)
		v_comproAsofc = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompFc)
		
		
		v_comproAso = ALLTRIM(v_comproAso)  + ALLTRIM(v_comproAsofa) + ALLTRIM(v_comproAsofb) + ALLTRIM(v_comproAsofc)
		
		v_comproAsoNDa = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNDa )
	 	v_comproAsoNDb = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNDb)
		v_comproAsoNDc = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNDc)
		
		v_comproAso = ALLTRIM(v_comproAso)  + ALLTRIM(v_comproAsoNDa) + ALLTRIM(v_comproAsoNDb) + ALLTRIM(v_comproAsoNDc)
		
		
		v_comproAsoNCa = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNCa )
	 	v_comproAsoNCb = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNCb)
		v_comproAsoNCc = comprobantesAsociados(v_idcomproba, p_idFactura, vconeccionF,v_idCompNCc)
		
		v_comproAso = ALLTRIM(v_comproAso)  + ALLTRIM(v_comproAsoNCa) + ALLTRIM(v_comproAsoNCb) + ALLTRIM(v_comproAsoNCc)
		
	** AGREGO OBSERVACIONES FIJAS EN EL COMPROBANTE SEGÚN CONDICIONES EN LA TABLA observacond  y el total en letras *
	
		SELECT factu 
		GO TOP 
		ALTER table factu ADD COLUMN obsfijo C(250)
*!*				v_observaFijo = obtenerObservaComp("facturas", "idfactura",v_idfactura, vconeccionF,.F.)
*!*				SELECT factu 
*!*				GO TOP 
*!*				replace ALL obsfijo WITH v_observaFijo, apeynom WITH ALLTRIM(ALLTRIM(apellido)+" "+ALLTRIM(nombre)), totalletra WITH ALLTRIM(v_totalEnLetras), compAso WITH ALLTRIM(v_comproAso)

	** AGREGO EL CALCULO PARA LOS RECARGOS PARA AQUELLAS FACTURAS QUE TIENEN VENCIMIENTOS 1 2 Y 3
			ALTER table factu ADD COLUMN recargo1 n(13,2)
			ALTER table factu ADD COLUMN recargo2 n(13,2)
			GO TOP 
			v_interesdia = factu.interesd
			v_fechavence1 = cftofc(factu.fechavenc1)
			v_fechavence2 = cftofc(factu.fechavenc2)
			v_fechavence3 = cftofc(factu.fechavenc3)
			v_recargo1 	 = IIF(!EMPTY(v_fechavence1) and !EMPTY(v_fechavence2), ((v_fechavence2 - v_fechavence1)* factu.total * (v_interesdia / 100)), 0.00 )
			v_recargo2 	 = IIF(!EMPTY(v_fechavence1) and !EMPTY(v_fechavence3), ((v_fechavence3 - v_fechavence1)* factu.total * (v_interesdia / 100)), 0.00 )
			replace ALL apeynom WITH ALLTRIM(ALLTRIM(apellido)+" "+ALLTRIM(nombre)), totalletra WITH ALLTRIM(v_totalEnLetras), compAso WITH ALLTRIM(v_comproAso) , recargo1 WITH v_recargo1, recargo2 WITH v_recargo2 
			
	**********************************************************************************************		
			SELECT factu 
			GO TOP 
			
					
			v_idcomproba = factu.idcomproba
			v_tipoCompAfip	= ALLTRIM(factu.tipcomAFIP)
			
			
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= factu.electro
			v_cuitEmpresa	= _SYSCUIT
			
*!*				IF  ALLTRIM(v_electronica) == "S"

*!*				*** Genero Código de Barras ***

*!*					v_cuitempresa	= ALLTRIM(v_CuitEmpresa)
*!*					
*!*					v_puntoVta		= ALLTRIM(factu.puntov)
*!*					v_fechaVenc_cae	= ALLTRIM(factu.caecespven)
*!*					v_cespcae		= ALLTRIM(factu.cespcae)
*!*				*	v_codBarra		= v_tipoCompAfip+"0"+v_puntoVta+v_Cespcae+v_fechaVenc_cae && EL PUNTO DE VENTA DEBE SER DE 5 DIGITOS
*!*					v_codBarra		= STRTRAN(v_CuitEmpresa,'-','')+v_tipoCompAfip+"0"+v_puntoVta+v_Cespcae+v_fechaVenc_cae && EL PUNTO DE VENTA DEBE SER DE 5 DIGITOS

*!*					v_codBarraD 		= calculaDigitoVerif(v_codBarra)
*!*			
*!*					SELECT factu
*!*					replace ALL codBarra WITH v_codBarraD
*!*					
*!*					
*!*					
*!*				*** Genero Código QR ***
*!*				
*!*					PRIVATE poFbc
*!*					poFbc = CREATEOBJECT("FoxBarcodeQR")
*!*					
*!*					
*!*					  poFbc.nBackColor = RGB(255,255,255) && White
*!*					  poFbc.nBarColor = RGB(0,0,0) && Black
*!*					  poFbc.nCorrectionLevel = 0 && Medium 15%
*!*	  
*!*	  
*!*	  
*!*					SELECT factu
*!*					GO TOP 
*!*							
*!*						
*!*					v_version = 1					
*!*					v_moneda = "PES"
*!*					v_cotizacion = 1
*!*					v_tipoDoc	= 80
*!*		
*!*					v_cuitEmpSG	 	= ALLTRIM(STRTRAN(v_CuitEmpresa,'-',''))
*!*					** Armo la cadena JSON  **
*!*					versionFCompro = ALLTRIM(STR(v_version))

*!*	                fechaCompro = SUBSTR(ALLTRIM(factu.fecha),1,4)+'-'+SUBSTR(ALLTRIM(factu.fecha),5,2)+'-'+SUBSTR(ALLTRIM(factu.fecha),7,2)
*!*	                cuitE 		= ALLTRIM(v_cuitEmpSG)
*!*		
*!*	                ptovta_fe   = ALLTRIM(STR(VAL(v_puntoVta)))
*!*	                idtipocbte_fe = ALLTRIM(STR(VAL(factu.tipcomAFIP)))
*!*		
*!*					numerostr  = ALLTRIM(STR(factu.numero))
*!*	                imp_totstr = ALLTRIM(STR(ROUND(factu.total,2),13,2))
*!*		
*!*		            monedastr = ALLTRIM(v_moneda)
*!*	                cotizacionstr = ALLTRIM(STR(v_cotizacion,13,2))
*!*		
*!*	                tipoDocstr = ALLTRIM(STR(v_tipoDoc))
*!*	                cuitC = ALLTRIM(STRTRAN(factu.cuit,'-',''))
*!*		
*!*					cae_fe = ALLTRIM(v_cespcae)
*!*											
*!*						v_json1 = ' { "ver":' + versionFCompro+ ',"fecha":"' + fechaCompro +'","cuit":' + cuitE+ ',"ptoVta":' + ptovta_fe + ',"tipoCmp":' + idtipocbte_fe
*!*						v_json2 = ',"nroCmp":' + numerostr  + ',"importe":' + imp_totstr + ',"moneda":"' + monedastr + '","ctz":' + cotizacionstr + ',"tipoDocRec":' + tipoDocstr 
*!*						v_json3 = ',"nroDocRec":' + cuitC + ',"tipoCodAut":"E"' + ',"codAut":' + cae_fe + ' }'
*!*															
*!*					v_json	= ALLTRIM(ALLTRIM(v_json1)+ ALLTRIM(v_json2)+ ALLTRIM(v_json3))
*!*		
*!*				
*!*						
*!*					** Encripto la cadena JSON **
*!*					v_datosCodificados  = "" 
*!*					
*!*					v_datosCodificados  = ALLTRIM(strconv(v_json,13))

*!*					
*!*					** Armo la cadena a codificar en el código QR **
*!*					v_codigo = "https://www.afip.gob.ar/fe/qr/" + "?p=" + ALLTRIM(v_datosCodificados)
*!*									
*!*					** Genero la imagen con el código QR **
*!*			
*!*					v_idRegistroStr = ALLTRIM(STRTRAN(STR((factu.idfactura),10,0),' ','0'))
*!*					v_ubicacionImgen = _SYSESTACION+"\imagenQR_"+ v_idRegistroStr 
*!*					
*!*					v_codQRImg= poFbc.FullQRCodeImage(ALLTRIM(v_codigo),v_ubicacionImgen,250)
*!*					
*!*					v_ubicacionImgen = v_ubicacionImgen+".bmp"
*!*					
*!*				
*!*					
*!*					
*!*					SELECT factu 
*!*					GO TOP 
*!*					replace ALL codqr WITH v_ubicacionImgen
*!*					
*!*					
*!*					SELECT factu 
*!*					GO TOP 
*!*					
*!*				*	APPEND GENERAL factu.codqr FROM (v_codQRImg)				
*!*					*replace  codqr WITH v_codQRImg				
*!*							
*!*					
*!*									
*!*				ELSE
*!*					
*!*				ENDIF 
			
			
			
		
			*** Obtengo el historial de saldos para la factura ***
			v_buscasaldo  = .F.	
			IF TYPE('_SYSREGHISCOMP') = 'C'
				IF _SYSREGHISCOMP == 'S'
					v_buscasaldo  = .T.
	
	
					sqlmatriz(1)=" SELECT fecha,entidad, comproba, puntov,numero,abrevia, tipo,total, saldo,imputado "
					sqlmatriz(2)=" FROM histosaldoent "
					sqlmatriz(3)=" where tablaaso = 'facturastmp' and idregaso = "+ALLTRIM(STR(v_idfactura))
					

					verror=sqlrun(vconeccionF,"hissaldo_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del historial de saldos",0+48+0,"Error")
					ENDIF


					SELECT * from hissaldo_sql INTO TABLE hissaldo
					
					ALTER table hissaldo alter COLUMN fecha C(8)
					ALTER table hissaldo alter COLUMN entidad I
					ALTER table hissaldo alter COLUMN puntov C(4)
					ALTER table hissaldo alter COLUMN numero I
					ALTER table hissaldo alter COLUMN abrevia C(10)
					ALTER table hissaldo alter COLUMN tipo C(10)
					ALTER table hissaldo alter column total N(13,4)
					ALTER table hissaldo alter column saldo N(13,4)
					ALTER table hissaldo alter column imputado N(13,4)
					 					


				endif
				
			endif
			
			=abreycierracon(vconeccionF,"")
				
			IF v_buscasaldo = .T.
				DO FORM reporteform WITH "factu;impIva;impTRIB;deuda;cuotas;bocas;flotes;hissaldo","facturasrc;impIVArc;impTRIBrc;deudarc;cuotasrc;bocasrc;flotesrc;hissaldorc",v_idcomproba,.F.,pEnviarImpresora
			ELSE
				DO FORM reporteform WITH "factu;impIva;impTRIB;deuda;cuotas;bocas;flotes","facturasrc;impIVArc;impTRIBrc;deudarc;cuotasrc;bocasrc;flotesrc",v_idcomproba,.F.,pEnviarImpresora
			ENDIF 

			
		ELSE
			MESSAGEBOX("Error al cargar la factura para imprimir",0+48+0,"Error al cargar la factura")
			
			=abreycierracon(vconeccionF,"")	
			
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la factura ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 



***************************************************************************************************

FUNCTION imprimirRecibo
PARAMETERS p_idRecibo
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR RECIBO
* PARAMETROS: P_IDRECIBO
*#/----------------------------------------


	v_idrecibo = p_idrecibo
	
	IF v_idrecibo > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del recibo
					
			sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip, e.cuit, dc.iddetacobro, dc.idtipopago, dc.importe as impCobrado, dc.idcuenta, tp.detalle as tipopago, cb.codcuenta, "
			sqlmatriz(2)=" TRIM(SUBSTR(concat(cb.codcuenta,' ',cb.detalle,SPACE(100)),1,100)) as detcuenta ,com.comprobante as nomcomp from recibos r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba "
			sqlmatriz(3)=" left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom " 
			sqlmatriz(4)=" left join entidades e on r.entidad = e.entidad left join detallecobros dc on r.idcomproba = dc.idcomproba and r.idrecibo = dc.idregistro "
			sqlmatriz(5)=" left join tipopagos tp on dc.idtipopago = tp.idtipopago left join cajabancos cb on dc.idcuenta = cb.idcuenta "
			sqlmatriz(6)=" where r.idrecibo = "+ ALLTRIM(STR(v_idrecibo))

			verror=sqlrun(vconeccionF,"recibo_sql_ua")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del recibo",0+48+0,"Error")
			ENDIF
			
		SELECT *,iddetacobro as iddetac FROM recibo_sql_ua INTO TABLE recibo_sql_u 
		ALTER table recibo_sql_u alter COLUMN tipopago C(254) 

		SELECT recibo_sql_u
		GO TOP 
				
		SELECT iddetac FROM recibo_sql_u WHERE ALLTRIM(tipopago) == "CUPONES" OR ALLTRIM(tipopago) == "CHEQUE" INTO TABLE detallecobrosid_sql
		
		v_iddetcobros =""
		
		SELECT detallecobrosid_sql
		GO TOP 
		
		DO WHILE NOT EOF()
		
			SELECT detallecobrosid_sql
			v_iddetcobros = v_iddetcobros + IIF(EMPTY(v_iddetcobros)=.T., "",",")+ ALLTRIM(STR(detallecobrosid_sql.iddetac))
		
			SELECT detallecobrosid_sql
			SKIP 1
		
		ENDDO 
		

		IF EMPTY(v_iddetcobros) = .T.
				v_iddetcobros = "false"
		ELSE
			v_iddetcobros = "c.registrocp in ("+ALLTRIM(v_iddetcobros) +")"		
		ENDIF 
		
			sqlmatriz(1)=" SELECT c.*,concat('CHEQUE Nro: ',ch.serie,' ',ch.numero,' (',b.banco,'-',b.filial,'-',b.cp,') ',b.nombre) as descrip "
 			sqlmatriz(2)=" from  cobropagolink c left join  cheques ch on c.idregistro = ch.idcheque left join  bancos b "
 			sqlmatriz(3)=" on ch.idbanco = b.idbanco where c.tabla = 'cheques' and c.tablacp = 'detallecobros' and "+ALLTRIM(v_iddetcobros)+" union "
 			sqlmatriz(4)=" SELECT c.*,concat('CUPÓN Nro: ',cu.numero,' - TARJETA: ',cu.tarjeta,' - TITULAR: ',cu.titular) as descrip "
  			sqlmatriz(5)=" from  cobropagolink c left join  cupones cu on c.idregistro = cu.idcupon where c.tabla = 'cupones' and c.tablacp = 'detallecobros' and "+ALLTRIM(v_iddetcobros)
  			  			
			verror=sqlrun(vconeccionF,"che_cup_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del recibo",0+48+0,"Error")
			ENDIF
		
		
		SELECT che_cup_sql
		GO top
		
		
		SELECT recibo_sql_u
		GO TOP 
		
		DO WHILE NOT EOF()
			
			v_tipopago = recibo_sql_u.tipopago
			
			IF ALLTRIM(v_tipopago) == "CUPONES" OR ALLTRIM(v_tipopago) == "CHEQUE"
			
				v_idDetacobro = recibo_sql_u.iddetac 
			
				SELECT che_cup_sql 
				GO TOP 
				LOCATE FOR registrocp = v_idDetacobro 
				
				SELECT recibo_sql_u
				replace tipopago WITH che_cup_sql.descrip
			
			ENDIF 
			
		
		
			SELECT recibo_sql_u
			SKIP 1
		
		ENDDO 
		
		
		SELECT *, ALLTRIM(nombre)+' '+ALLTRIM(apellido) as apeynom FROM recibo_sql_u INTO TABLE .\recibo
				
		SELECT recibo
		
		IF NOT EOF()
		
			SELECT recibo 
			GO TOP 
			
			v_idcomproba 	= recibo.idcomproba
			*** Busco los datos de los cobros para el recibo
		
				sqlmatriz(1)=" Select c.*, f.numero,f.tipo,f.fecha,f.entidad, f.servicio, f.cuenta, f.nombre, f.apellido,f.cuit , pv.puntov,ifnull(fc.cuota,0) as cuota, ifnull(fc.cancuotas,0) as cancuotas "
				sqlmatriz(2)=" from cobros c left join facturas f on c.idfactura = f.idfactura left join puntosventa pv on f.pventa = pv.pventa "
				sqlmatriz(3)=" left join facturascta fc on c.idcuotafc = fc.idcuotafc "
				sqlmatriz(4)=" where c.idcomproba = " +ALLTRIM(STR(v_idcomproba))+" and c.idregipago = "+ ALLTRIM(STR(v_idrecibo))

				verror=sqlrun(vconeccionF,"cobros_sql_u")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de cobros relacionados al recibo ",0+48+0,"Error")
				ENDIF
			
			SELECT * FROM cobros_sql_u INTO TABLE .\cobros
			SELECT cobros
			GO TOP 
		
			ALTER table cobros alter COLUMN cuota I
			ALTER table cobros alter COLUMN cancuotas I
			ALTER table recibo ADD COLUMN strImporte C(250)
			
			SELECT recibo
			v_importe	= recibo.importe
			v_strImporte	= enletras (v_importe)
			
			SELECT recibo 
			GO TOP 
			
			replace ALL strImporte WITH v_strImporte
			
			SELECT recibo 
			GO TOP 
			v_idcomproba = recibo.idcomproba
			
			DO FORM reporteform WITH "recibo;cobros","reciborc;cobroscr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar el recibo para imprimir",0+48+0,"Error al cargar el recibo")
			RETURN 	
		ENDIF 
				

	ELSE
		MESSAGEBOX("NO se pudo recuperar el recibo el ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 




FUNCTION imprimirOtMoviStock
PARAMETERS p_idMoviStockP
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UN MOVIMIENTO DE STOCK DE MATERIALES
* PARAMETROS: P_IDMOVISTOCK
*#/----------------------------------------


	v_idmovip = p_idMoviStockP


	IF v_idmovip > 0
	
	
		** Compruebo que no esté anulado
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		sqlmatriz(1)="Select * from otmovianul "
		sqlmatriz(2)=" where idmovip= "+ ALLTRIM(STR(v_idmovip ))

		verror=sqlrun(vconeccionF,"otAnul_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la comprobación de comprobante anulado",0+48+0,"Error")
		    RETURN 
		ENDIF
	
		SELECT  otAnul_sql
		
		IF NOT EOF()
			 MESSAGEBOX("El comprobante se encuentra ANULADO, no se puede imprimir",0+48+0,"No se puede imprimir")
		    RETURN 
		ENDIF 
	
		
		
		*** Busco los datos del movimiento y el detalle
		
		
			sqlmatriz(1)="Select p.*,h.*, e.apellido as apellEnt, e.nombre as nomEnt, e.compania, e.cuit, e.direccion, t.ie,t.reporte, d.detalle as detDepo "
			sqlmatriz(2)=" from otmovistockp p left join otmovistockh h on p.idmovip = h.idmovip " 
			sqlmatriz(3)=" left join entidades e on p.entidad = e.entidad "
			*sqlmatriz(4)=" left join otmateriales m on h.idmate = m.idmate "
			sqlmatriz(5)=" left join tipomstock t on h.idtipomov = t.idtipomov "
			sqlmatriz(6)=" left join otdepositos d on h.iddepo = d.iddepo "
			sqlmatriz(7)=" where p.idmovip = "+ ALLTRIM(STR(v_idmovip))

			verror=sqlrun(vconeccionF,"otmovi_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del Movimiento de Stock",0+48+0,"Error")
			    RETURN 
			ENDIF
		
	
	
		

		SELECT * FROM otmovi_sql INTO TABLE .\otmoviImpr

		
		SELECT otmoviImpr
		
		IF NOT EOF()
		
			
			DO FORM reporteform WITH "otmoviImpr","movistockcr","otmovistock"
			
			
		ELSE
			MESSAGEBOX("Error al cargar el movimiento para imprimir",0+48+0,"Error al cargar el movimiento")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar el movimiento de stock ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION imprimirNP
PARAMETERS p_idnp
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UNA Nota de Pedido (COMPROBANTES DE LA TABLA NP)
* PARAMETROS: P_IDNP
*#/----------------------------------------


	v_idnp = p_idnp


	IF v_idnp  > 0
		

*		v_imprimeMonto = 0		
*		sino = MESSAGEBOX("¿Desea imprimir la NP con montos?",4+48+256,"Imprimir montos")

*		IF sino = 6
			v_imprimeMonto	= 1
		
*		ELSE
		
*			v_imprimeMonto	= 0
*		ENDIF 
		
		*** Busco los datos de la np y el detalle
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

		sqlmatriz(1)=" Select f.*,d.*,c.*,f.numero as numNP,com.tipo as tipoCom, c.detalle as detIVA, v.nombre as nomVend,ca.puntov, tc.idafipcom, pv.electronica as electro, ifnull(af.codigo,'') as tipcomAFIP,l.nombre as nomLoc, p.nombre as nomProv,e.cuit,e.direccion, "
		sqlmatriz(2)=" e.telefono, e.email, com.comprobante as nomcomp,ifnull(r.cantcump,0) as cantcump "
		sqlmatriz(3)=" from np f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
		sqlmatriz(4)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
		sqlmatriz(5)="  left join ot d on f.idnp = d.idnp "
		sqlmatriz(6)=" left join entidades e on f.entidad = e.entidad left join condfiscal c on e.iva = c.iva"
		sqlmatriz(7)=" left join vendedores v on f.vendedor = v.vendedor "
		sqlmatriz(8)=" left join r_otpendientes r on r.idot = d.idot "
		sqlmatriz(9)=" left join localidades l on e.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
		sqlmatriz(10)=" where f.idnp = "+ ALLTRIM(STR(v_idnp))
			
					
		verror=sqlrun(vconeccionF,"np_det_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la NP",0+48+0,"Error")
		ENDIF

		SELECT *, SPACE(200) as otvincula FROM np_det_sql INTO TABLE .\np_impr  WHERE imprimir = 'S'

		sqlmatriz(1)=" Select n.idot, o.fechaot, o.descriptot, p.entidad, p.nombre from otnp n left join otordentra o on o.idot = n.idot left join otpedido p on p.idpedido = o.idpedido "
		sqlmatriz(2)=" where n.idnp = "+ ALLTRIM(STR(v_idnp))
		verror=sqlrun(vconeccionF,"otvin_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
		ENDIF 

		v_otvincula = ""
		SELECT otvin_sql
		GO TOP 
		IF !EOF() THEN 
			v_otvincula = "O.T. Nro. "+ALLTRIM(STR(otvin_sql.idot))+'  F.'+SUBSTR(otvin_sql.fechaot,7,2)+'/'+SUBSTR(otvin_sql.fechaot,5,2)+'/'+SUBSTR(otvin_sql.fechaot,1,4)+'   '+STR(otvin_sql.entidad,6)+'-'+ALLTRIM(otvin_sql.nombre)+'  - '+ALLTRIM(otvin_sql.descriptot)
		ENDIF 
		USE IN otvin_sql 
		
		
		
		
			
		SELECT np_impr
		
		IF NOT EOF()
			SELECT np_impr
			ALTER table np_impr ADD COLUMN imprMonto I
			
			SELECT np_impr
			GO TOP 
			replace ALL imprMonto WITH v_imprimeMonto, otvincula WITH v_otvincula
			
			SELECT np_impr
			GO TOP 
			
			v_idcomproba 	= np_impr.idcomproba
			v_tipoCompAfip	= ALLTRIM(np_impr.tipcomAFIP)
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= .F.
			v_cuitEmpresa	= _SYSCUIT
			v_entidad		= np_impr.entidad
			
			*********************************************
			** Obtengo los datos anexos a la Nota de Pedido y el cliente si los hubiere 
			** agrega los datos extra y anexos de la entidad y la nota de pedido a la impresion
			************************************************************
			*Anexo Entidades
			sqlmatriz(1)=" select concat(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor, concat(r.tabla,SPACE(15)) as tabla, ifnull(o.orden,'000') as ordenar from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
			sqlmatriz(2)=" left join datosextraor o on o.tabla = 'entidades' and o.propiedad = d.propiedad "
			sqlmatriz(3)=" where d.imprimir = 'S' and r.tabla = 'entidades' and r.idregistro = "+ ALLTRIM(STR(v_entidad))

*!*				sqlmatriz(1)=" select concat(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor, concat(r.tabla,SPACE(15)) as tabla from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
*!*				sqlmatriz(2)=" where d.imprimir = 'S' and r.tabla = 'entidades' and r.idregistro = "+ ALLTRIM(STR(v_entidad))
			verror=sqlrun(vconeccionF,"entidadextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
			ENDIF 		
			
			*Anexo NP
			sqlmatriz(1)=" select CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor , concat(r.tabla,SPACE(15)) as tabla, ifnull(o.orden,'000') as ordenar from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
			sqlmatriz(2)=" left join datosextraor o on o.tabla = 'np' and o.propiedad = d.propiedad "
			sqlmatriz(3)=" where d.imprimir = 'S' and r.tabla = 'np' and r.idregistro = "+ ALLTRIM(STR(v_idnp))

*!*				sqlmatriz(1)=" select CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor , concat(r.tabla,SPACE(15)) as tabla from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
*!*				sqlmatriz(2)=" where d.imprimir = 'S' and r.tabla = 'np' and r.idregistro = "+ ALLTRIM(STR(v_idnp))
			verror=sqlrun(vconeccionF,"npextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
			ENDIF 		
			
			SELECT entidadextra_sql
			GO TOP 
			IF EOF() THEN 
				CREATE TABLE entidadex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , valor , tabla, ordenar FROM entidadextra_sql INTO TABLE .\entidadex ORDER BY ordenar, propiedad 
				ALTER table entidadex alter COLUMN valor m
			ENDIF 
			USE IN entidadextra_sql
			

			SELECT npextra_sql
			GO TOP 
			IF EOF() THEN 
				CREATE TABLE npex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , valor , tabla, ordenar FROM npextra_sql INTO TABLE .\npex ORDER BY ordenar, propiedad 
				ALTER table npex alter COLUMN valor m
			ENDIF 
			USE IN npextra_sql 



			DO FORM reporteform WITH "np_impr;entidadex;npex","npcr;entidadexcr;npexcr",v_idcomproba
			
			=abreycierracon(vconeccionF,"")	

			* Impresion de Datos Anexos si los hubiere
			=ImprimirDetalleAnexo ('np', v_idnp)
		
			
		ELSE
			MESSAGEBOX("Error al cargar la NP  para imprimir",0+48+0,"Error al cargar la NP")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la NP ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION imprimirPresu
PARAMETERS p_idpresupu
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UN PRESUPUESTO (COMPROBANTES DE LA TABLA PRESUPU)
* PARAMETROS: P_IDPRESUPU
*#/----------------------------------------


	v_idpresupu = p_idpresupu
	comproObjtmp		= CREATEOBJECT('comprobantesClass')
	v_idcomprobSol =  comproObjtmp.getidcomprobante("SOLICITUD DE PRESUPUESTO")
	
	IF v_idpresupu > 0
		
		v_imprimeMonto = 1
			
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

		sqlmatriz(1)=" Select f.*,d.*,c.*,f.numero as numNP,com.tipo as tipoCom, c.detalle as detIVA, v.nombre as nomVend,ca.puntov, tc.idafipcom, pv.electronica as electro, ifnull(af.codigo,'') as tipcomAFIP,l.nombre as nomLoc, p.nombre as nomProv,e.cuit,e.direccion, "
		sqlmatriz(2)=" e.telefono, e.email, com.comprobante as nomcomp,0 as cantcump from presupu f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
		sqlmatriz(3)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
		sqlmatriz(4)=" left join presupuh d on f.idpresupu = d.idpresupu "
		sqlmatriz(5)=" left join entidades e on f.entidad = e.entidad left join condfiscal c on e.iva = c.iva"
		sqlmatriz(6)=" left join vendedores v on f.vendedor = v.vendedor "
		sqlmatriz(7)=" left join localidades l on e.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
		sqlmatriz(8)=" where f.idpresupu = "+ ALLTRIM(STR(v_idpresupu))
			
					
		verror=sqlrun(vconeccionF,"np_det_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la NP",0+48+0,"Error")
		ENDIF

		SELECT *, SPACE(200) as otvincula FROM np_det_sql INTO TABLE .\presupu_impr WHERE imprimir = 'S'

		sqlmatriz(1)=" Select n.idpresupu, o.fechaot, o.descriptot, p.entidad, p.nombre from otpresupu n left join otordentra o on o.idot = n.idot left join otpedido p on p.idpedido = o.idpedido "
		sqlmatriz(2)=" where n.idpresupu = "+ ALLTRIM(STR(v_idpresupu))
		verror=sqlrun(vconeccionF,"otvin_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
		ENDIF 

		v_otvincula = ""
		SELECT otvin_sql
		GO TOP 
		IF !EOF() THEN 
			v_otvincula = "O.T. Nro. "+ALLTRIM(STR(otvin_sql.idot))+'  F.'+SUBSTR(otvin_sql.fechaot,7,2)+'/'+SUBSTR(otvin_sql.fechaot,5,2)+'/'+SUBSTR(otvin_sql.fechaot,1,4)+'   '+STR(otvin_sql.entidad,6)+'-'+ALLTRIM(otvin_sql.nombre)+'  - '+ALLTRIM(otvin_sql.descriptot)
		ENDIF 
		USE IN otvin_sql 
		
		
		
		
			
		SELECT presupu_impr
		
		IF NOT EOF()
			SELECT presupu_impr
			ALTER table presupu_impr ADD COLUMN imprMonto I
			
			SELECT presupu_impr
			GO TOP 
			
			v_idcomproba 	= presupu_impr.idcomproba
		
			IF v_idcomproba == v_idcomprobSol && Si el comprobante es Solicitud de presupuesto no debe mostrar los montos
				v_imprimeMonto = 0
			ELSE
				v_imprimeMonto = 1
			ENDIF 
			
			
			
			
			SELECT presupu_impr
			GO TOP 
			replace ALL imprMonto WITH v_imprimeMonto, otvincula WITH v_otvincula
			
			
			SELECT presupu_impr
			GO TOP 
			
			
			v_tipoCompAfip	= ALLTRIM(presupu_impr.tipcomAFIP)
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= .F.
			v_cuitEmpresa	= _SYSCUIT
			v_entidad		= presupu_impr.entidad
			
			*********************************************
			** Obtengo los datos anexos al Presupuesto y el cliente si los hubiere 
			** agrega los datos extra y anexos de la entidad y la nota de pedido a la impresion
			************************************************************
			*Anexo Entidades
			sqlmatriz(1)=" select concat(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor, concat(r.tabla,SPACE(15)) as tabla from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
			sqlmatriz(2)=" where d.imprimir = 'S' and r.tabla = 'entidades' and r.idregistro = "+ ALLTRIM(STR(v_entidad))
			verror=sqlrun(vconeccionF,"entidadextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
			ENDIF 		
			
			*Anexo NP
			sqlmatriz(1)=" select CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor , concat(r.tabla,SPACE(15)) as tabla from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
			sqlmatriz(2)=" where d.imprimir = 'S' and r.tabla = 'presupu' and r.idregistro = "+ ALLTRIM(STR(v_idpresupu))
			verror=sqlrun(vconeccionF,"npextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
			ENDIF 		
			
			SELECT entidadextra_sql
			GO TOP 
			IF EOF() THEN 
				CREATE TABLE entidadex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , valor , tabla FROM entidadextra_sql INTO TABLE .\entidadex ORDER BY propiedad 
				ALTER table entidadex alter COLUMN valor m
			ENDIF 
			USE IN entidadextra_sql
			

			SELECT npextra_sql
			GO TOP 
			IF EOF() THEN 
				CREATE TABLE presupuex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , valor , tabla FROM npextra_sql INTO TABLE .\presupuex ORDER BY propiedad 
				ALTER table presupuex alter COLUMN valor m
			ENDIF 
			USE IN npextra_sql 



			DO FORM reporteform WITH "presupu_impr;entidadex;presupuex","npcr;entidadexcr;npexcr",v_idcomproba
			
			=abreycierracon(vconeccionF,"")	

			* Impresion de Datos Anexos si los hubiere
			=ImprimirDetalleAnexo ('presupu', v_idpresupu)
		
			
		ELSE
			MESSAGEBOX("Error al cargar la NP  para imprimir",0+48+0,"Error al cargar la NP")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar El Presupuesto ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION imprimirTransferenciaCaja
PARAMETERS p_idcajamovip
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR TRANSFERENCIA DE CAJAS
* PARAMETROS: P_idcajamovip
*#/----------------------------------------

	v_idcajamovip = p_idcajamovip
	
	IF v_idcajamovip > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del recibo
					

		sqlmatriz(1)= " Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip,h.idcajamovh, h.idtipopago,h.importe as importetp, tp.detalle as tipopago, "
		sqlmatriz(2)= " com.comprobante as nomcomp, TRIM(SUBSTR(concat(cpl.descrip,SPACE(200)),1,200)) as desccpl, cd.detalle as cajaDes, co.detalle as cajaOri "
		sqlmatriz(3)= " from cajamovip r left join cajarecauda cd on r.idcajarecd = cd.idcajareca left join cajarecauda co on r.idcajareco = co.idcajareca "
		sqlmatriz(4)=" left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom "
		sqlmatriz(5)=" left join cajamovih h on r.idcajamovp = h.idcajamovp left join tipopagos tp on h.idtipopago = tp.idtipopago "
	 	sqlmatriz(6)= " left join (SELECT c.*,concat('CHEQUE Nro: ',ch.serie,' ',ch.numero,concat(' FV: ',substr(ch.fechavence,7,2),'/',substr(ch.fechavence,5,2),'/',substr(ch.fechavence,1,4)),' (',b.banco,'-',b.filial,'-',b.cp,') ',b.nombre) as descrip "
		sqlmatriz(7)= " from cobropagolink c left join cheques ch on c.idregistro = ch.idcheque left join bancos b on ch.idbanco = b.idbanco where c.tabla = 'cheques' and c.tablacp = 'cajamovih' union "
		sqlmatriz(8)= " SELECT c.*,concat('CUPÓN Nro: ',cu.numero,' - TARJETA: ',cu.tarjeta,' - TITULAR: ',cu.titular) as descrip  from cobropagolink c left join cupones cu on c.idregistro = cu.idcupon "
		sqlmatriz(9)= " where c.tabla = 'cupones' and c.tablacp = 'cajamovih') as cpl on h.idcajamovh = cpl.registrocp "
		sqlmatriz(10)=" where r.idcajamovp = "+ALLTRIM(STR(p_idcajamovip))
			verror=sqlrun(vconeccionF,"cajamovip_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Transferencia de Caja",0+48+0,"Error")
			    RETURN 
			ENDIF
									
		
		SELECT cajamovip_sql
		GO TOP 
*!*			
*!*			DO WHILE NOT EOF()
*!*				
*!*				v_idtipopago	= IIF(ISNULL(cajamovip_sql.idtipopago) = .T.,0,cajamovip_sql.idtipopago)	
*!*				
*!*				v_tipopago		= IIF(ISNULL(cajamovip_sql.tipopago) = .T.,"",cajamovip_sql.tipopago)	
*!*			
*!*				DO CASE
*!*					CASE ALLTRIM(v_tipoPago) == "CUPONES"
*!*						v_tipoPago = IIF(ISNULL(cajamovip_sql.desccpl) or EMPTY(cajamovip_sql.desccpl),"CUPONES",cajamovip_sql.desccpl)
*!*					CASE ALLTRIM(v_tipoPago) == "CHEQUE"
*!*						v_tipoPago =IIF(ISNULL(cajamovip_sql.desccpl) or EMPTY(cajamovip_sql.desccpl),"CHEQUE",cajamovip_sql.desccpl)
*!*					OTHERWISE
*!*						

*!*				ENDCASE
*!*			*	v_importe		= IIF(ISNULL(cajamovip_sql.imported)=.T.,0,cajamovip_sql.importe)
*!*					
*!*				SELECT cajamovip_sql
*!*				SKIP 1
*!*			
*!*			ENDDO 
*!*			
		
				
		SELECT * FROM cajamovip_sql INTO TABLE cajamovip
				
		SELECT cajamovip
		GO TOP 
	
		IF NOT EOF()
	
			replace ALL desccpl WITH tipopago FOR ISNULL(desccpl) = .T.
			
					
			SELECT cajamovip 
			GO TOP 
			v_idcomproba = cajamovip.idcomproba
			
			DO FORM reporteform WITH "cajamovip","cajamovipcr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar la Transferencia para imprimir",0+48+0,"Error al cargar la Transferencia")
			RETURN 	
		ENDIF 
				

	ELSE
		MESSAGEBOX("NO se pudo recuperar la Transferencia el ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 




FUNCTION imprimirTransferenciaCta
PARAMETERS p_idtransferencia
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR TRANSFERENCIA DE CAJAS
* PARAMETROS: P_idcajamovip
*#/----------------------------------------



	v_idtransfe = p_idtransferencia
	
	IF v_idtransfe > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del recibo
		 sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip,com.comprobante as nomcomp, cd.detalle as ctaDes, co.detalle as ctaOri,d.idtipopago, d.iddetacobro, d.importe as importetp,cpl.descrip as desccpl,tp.detalle as tipopago "
         sqlmatriz(2)=" FROM transferencias r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba left join tipocompro t on com.idtipocompro = t.idtipocompro"
		sqlmatriz(3)=" left join afipcompro a on t.idafipcom = a.idafipcom left join cajabancos cd on r.idcuentad = cd.idcuenta left join cajabancos co on r.idcuentao = co.idcuenta "
		sqlmatriz(4)="  left join detallecobros d   on r.idtransfe = d.idregistro left join tipopagos tp on d.idtipopago = tp.idtipopago left join (SELECT c.*,concat('CHEQUE Nro: ',ch.serie,' ',ch.numero, "
		sqlmatriz(5)=" concat(' FV: ',substr(ch.fechavence,7,2),'/',substr(ch.fechavence,5,2),'/',substr(ch.fechavence,1,4)),' (',b.banco,'-',b.filial,'-',b.cp,') ',b.nombre) as descrip "
		sqlmatriz(6)=" from cobropagolink c left join cheques ch on c.idregistro = ch.idcheque left join bancos b on ch.idbanco = b.idbanco where c.tabla = 'cheques' and c.tablacp = 'detallecobros' union "
		sqlmatriz(7)="	SELECT c.*,concat('CUPÓN Nro: ',cu.numero,' - TARJETA: ',cu.tarjeta,' - TITULAR: ',cu.titular) as descrip  from cobropagolink c left join cupones cu on c.idregistro = cu.idcupon "
		sqlmatriz(8)="	where c.tabla = 'cupones' and c.tablacp = 'detallecobros') as cpl on d.iddetacobro = cpl.registrocp	"
		sqlmatriz(9)=" where r.idcomproba = d.idcomproba and d.idregistro = "+ALLTRIM(STR(v_idtransfe))


			verror=sqlrun(vconeccionF,"transfecta_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Transferencia de Cuentas",0+48+0,"Error")
			    RETURN 
			ENDIF
									
		
		SELECT transfecta_sql
		GO TOP 
		
*!*			DO WHILE NOT EOF()
*!*				
*!*				v_idtipopago	= IIF(ISNULL(transfecta_sql.idtipopago) = .T.,0,transfecta_sql.idtipopago)	
*!*				
*!*				v_tipopago		= IIF(ISNULL(transfecta_sql.tipopago) = .T.,"",transfecta_sql.tipopago)	
*!*			
*!*				DO CASE
*!*					CASE ALLTRIM(v_tipoPago) == "CUPONES"
*!*						v_tipoPago = IIF(ISNULL(transfecta_sql.desccpl) or EMPTY(transfecta_sql.desccpl),"CUPONES",transfecta_sql.desccpl)
*!*					CASE ALLTRIM(v_tipoPago) == "CHEQUE"
*!*						v_tipoPago =IIF(ISNULL(transfecta_sql.desccpl) or EMPTY(transfecta_sql.desccpl),"CHEQUE",transfecta_sql.desccpl)
*!*					OTHERWISE
*!*						

*!*				ENDCASE
*!*			*	v_importe		= IIF(ISNULL(cajamovip_sql.imported)=.T.,0,cajamovip_sql.importe)
*!*					
*!*				SELECT transfecta_sql
*!*				SKIP 1
*!*			
*!*			ENDDO 
*!*			
*!*			
				
		SELECT * FROM transfecta_sql INTO TABLE transfecta
				
		SELECT transfecta
		GO TOP 
	
		IF NOT EOF()
	
			replace ALL desccpl WITH tipopago FOR ISNULL(desccpl) = .T.
			
					
			SELECT transfecta
			GO TOP 
			v_idcomproba = transfecta.idcomproba
			
			DO FORM reporteform WITH "transfecta","transfectacr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar la Transferencia para imprimir",0+48+0,"Error al cargar la Transferencia")
			RETURN 	
		ENDIF 
				

	ELSE
		MESSAGEBOX("NO se pudo recuperar la Transferencia el ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 



FUNCTION imprimirCajaIE
PARAMETERS p_idcajaie, P_opera_comp
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR CAJA INGRESO / EGRESO
* PARAMETROS: P_idcajaie
*#/----------------------------------------

	v_idcajaie = p_idcajaie
	v_opera_comp = P_opera_comp

	IF v_idcajaie  > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del cajaie
					

			sqlmatriz(1)= " Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip, d.idtipopago,d.importe as importetp, tp.detalle as tipopago, "
			sqlmatriz(2)= " com.comprobante as nomcomp, cpl.descrip as desccpl,cb.codcuenta, cb.detalle as detcuenta from cajaie r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba  "
			sqlmatriz(3)=" left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom  "
			
			IF v_opera_comp < 0
				sqlmatriz(4) = " left join detallepagos d on r.idcajaie = d.idregistro  left join tipopagos tp on d.idtipopago = tp.idtipopago left join cajabancos cb on d.idcuenta = cb.idcuenta "
				sqlmatriz(5)= " left join (SELECT c.*,concat('CHEQUE Nro: ',ch.serie,' ',ch.numero,concat(' FV: ',substr(ch.fechavence,7,2),'/',substr(ch.fechavence,5,2),'/',substr(ch.fechavence,1,4)),' (',b.banco,'-',b.filial,'-',b.cp,') ',b.nombre) as descrip "
				sqlmatriz(6)= " from cobropagolink c left join cheques ch on c.idregistro = ch.idcheque left join bancos b on ch.idbanco = b.idbanco where c.tabla = 'cheques' and c.tablacp = 'detallepagos' union "
				sqlmatriz(7)= " SELECT c.*,concat('CUPÓN Nro: ',cu.numero,' - TARJETA: ',cu.tarjeta,' - TITULAR: ',cu.titular) as descrip  from cobropagolink c left join cupones cu on c.idregistro = cu.idcupon "
				sqlmatriz(8)= " where c.tabla = 'cupones' and c.tablacp = 'detallepagos') as cpl on  d.iddetapago = cpl.registrocp "
				

			ELSE
				IF v_opera_comp > 0
					sqlmatriz(4) = " left join detallecobros d on r.idcajaie = d.idregistro  left join tipopagos tp on d.idtipopago = tp.idtipopago left join cajabancos cb on d.idcuenta = cb.idcuenta "
					sqlmatriz(5)= " left join (SELECT c.*,concat('CHEQUE Nro: ',ch.serie,' ',ch.numero,concat(' FV: ',substr(ch.fechavence,7,2),'/',substr(ch.fechavence,5,2),'/',substr(ch.fechavence,1,4)),' (',b.banco,'-',b.filial,'-',b.cp,') ',b.nombre) as descrip "
					sqlmatriz(6)= " from cobropagolink c left join cheques ch on c.idregistro = ch.idcheque left join bancos b on ch.idbanco = b.idbanco where c.tabla = 'cheques' and c.tablacp = 'detallecobros' union "
					sqlmatriz(7)= " SELECT c.*,concat('CUPÓN Nro: ',cu.numero,' - TARJETA: ',cu.tarjeta,' - TITULAR: ',cu.titular) as descrip  from cobropagolink c left join cupones cu on c.idregistro = cu.idcupon "
					sqlmatriz(8)= " where c.tabla = 'cupones' and c.tablacp = 'detallecobros') as cpl on  d.iddetacobro = cpl.registrocp "


				ELSE
					MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Caja Ingreso/Egreso. El tipo de operación es Cero",0+48+0,"Error")
				    RETURN 
				
				ENDIF 
			 	 
			ENDIF 
		sqlmatriz(9)=" where r.idcomproba = d.idcomproba and r.idcajaie = "+ALLTRIM(STR(v_idcajaie))
		
		
*!*			sqlmatriz(4)= " left join cajamovih h on r.idcajamovp = h.idcajamovp left join tipopagos tp on h.idtipopago = tp.idtipopago "
*!*		 	sqlmatriz(5)= " left join (SELECT c.*,concat('CHEQUE Nro: ',ch.serie,' ',ch.numero,concat(' FV: ',substr(ch.fechavence,7,2),'/',substr(ch.fechavence,5,2),'/',substr(ch.fechavence,1,4)),' (',b.banco,'-',b.filial,'-',b.cp,') ',b.nombre) as descrip "
*!*			sqlmatriz(6)= " from cobropagolink c left join cheques ch on c.idregistro = ch.idcheque left join bancos b on ch.idbanco = b.idbanco where c.tabla = 'cheques' and c.tablacp = 'cajamovih' union "
*!*			sqlmatriz(7)= " SELECT c.*,concat('CUPÓN Nro: ',cu.numero,' - TARJETA: ',cu.tarjeta,' - TITULAR: ',cu.titular) as descrip  from cobropagolink c left join cupones cu on c.idregistro = cu.idcupon "
*!*			sqlmatriz(8)= " where c.tabla = 'cupones' and c.tablacp = 'cajamovih') as cpl on h.idcajamovh = cpl.registrocp "
*!*			sqlmatriz(9)=" where r.idcajamovp = "+ALLTRIM(STR(p_idcajamovip))
			verror=sqlrun(vconeccionF,"cajaieimp_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de el comprobante de Caja Ingreso/Egreso",0+48+0,"Error")
			    RETURN 
			ENDIF
									
		
		SELECT cajaieimp_sql
		GO TOP 
		
*!*			DO WHILE NOT EOF()
*!*				
*!*				v_idtipopago	= IIF(ISNULL(cajaieimp_sql.idtipopago) = .T.,0,cajaieimp_sql.idtipopago)	
*!*				
*!*				v_tipopago		= IIF(ISNULL(cajaieimp_sql.tipopago) = .T.,"",cajaieimp_sql.tipopago)	
*!*			
*!*				DO CASE
*!*					CASE ALLTRIM(v_tipoPago) == "CUPONES"
*!*						v_tipoPago = IIF(ISNULL(cajamovip_sql.desccpl) or EMPTY(cajamovip_sql.desccpl),"CUPONES",cajamovip_sql.desccpl)
*!*					CASE ALLTRIM(v_tipoPago) == "CHEQUE"
*!*						v_tipoPago =IIF(ISNULL(cajamovip_sql.desccpl) or EMPTY(cajamovip_sql.desccpl),"CHEQUE",cajamovip_sql.desccpl)
*!*					OTHERWISE
*!*						

*!*				ENDCASE
*!*			*	v_importe		= IIF(ISNULL(cajamovip_sql.imported)=.T.,0,cajamovip_sql.importe)
*!*					
*!*				SELECT cajamovip_sql
*!*				SKIP 1
*!*			
*!*			ENDDO 
		
		
				
		SELECT * FROM cajaieimp_sql INTO TABLE cajaieimp
				
		ALTER table cajaieimp alter COLUMN tipopago C(254) 


		SELECT cajaieimp
		GO TOP 
	
		IF NOT EOF()
	
*			replace ALL desccpl WITH tipopago FOR ISNULL(desccpl) = .T.
		replace ALL tipopago WITH desccpl FOR ISNULL(desccpl) = .F.
			
					
			SELECT cajaieimp
			GO TOP 
			v_idcomproba = cajaieimp.idcomproba
			
			DO FORM reporteform WITH "cajaieimp","cajaieimpcr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar el comprobante de Caja Ingreso/Egreso para imprimir",0+48+0,"Error al cargar la Transferencia")
			RETURN 	
		ENDIF 
				

	ELSE
		MESSAGEBOX("NO se pudo recuperar el comprobante de Caja Ingreso/Egreso el ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 




FUNCTION imprimirCumplimentacion
PARAMETERS p_idcump
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UN COmprobante de cumplimentacion (COMPROBANTES DE LA TABLA cumplimentap)
* PARAMETROS: P_IDCUMP
*#/----------------------------------------


	v_idcump = p_idcump


	IF v_idcump > 0
		

	
		*** Busco los datos de la cumplimentación y el detalle
		
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

			sqlmatriz(1)=	" Select p.idcump,p.idcomproba,pv.puntov, p.numero, p.pventa, p.fecha, p.observa1, p.observa2, p.observa3, p.observa4, p.responsab, "
			sqlmatriz(2)= 	" h.articulo, h.detalle, h.cantidad, h.cantidaduf,h.idcumph, h.idot ,c.tipo,c.comprobante as nomcomp, a.unidad, ifnull(f.unidadf,a.unidad) as unidadf, f.base "
			sqlmatriz(3)=   " from cumplimentap p " 
			sqlmatriz(4)= 	" left join cumplimentah h on h.idcump = p.idcump "
			sqlmatriz(5)=	" left join comprobantes c on c.idcomproba = p.idcomproba "
			sqlmatriz(6)=   " left join puntosventa pv on p.pventa = pv.pventa "
			sqlmatriz(7)=   " left join articulos a on a.articulo=h.articulo "
			sqlmatriz(8)=	" left join articulosf f on a.articulo = f.articulo "
			sqlmatriz(9)=	" where p.idcump = "+ ALLTRIM(STR(v_idcump))
			 
					
			verror=sqlrun(vconeccionF,"cump_imp_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Cumplimentación",0+48+0,"Error")
			ENDIF
		
	
		SELECT * FROM cump_imp_sql INTO TABLE cump_impr
		
			
		SELECT cump_impr
		
		IF NOT EOF()
			SELECT cump_impr
			v_idcomproba = cump_impr.idcomproba
			
			DO FORM reporteform WITH "cump_impr","cumpcr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar la Cumplimentación para imprimir",0+48+0,"Error al cargar la Cumplimentación")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la Cumplimentación ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION imprimirCumpleOC
PARAMETERS p_idcumpoc
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UN COmprobante de CumpleOC (COMPROBANTES DE LA TABLA cumplimentaoc)
* PARAMETROS: P_IDCUMPOC
*#/----------------------------------------


	v_idcumpoc = p_idcumpoc


	IF v_idcumpoc > 0
		

	
		*** Busco los datos de la cumplimentación y el detalle
		
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

			sqlmatriz(1)=	" Select p.idcumpoc,p.idcomproba,pv.puntov, p.numero, p.pventa, p.fecha, p.observa1, p.observa2, p.observa3, p.observa4, p.responsab, "
			sqlmatriz(2)= 	" h.articulo, h.detalle, h.cantidad, h.cantidaduf,h.idcumpocd, h.idocd ,c.tipo,c.comprobante as nomcomp, a.unidad, ifnull(f.unidadf,a.unidad) as unidadf, f.base "
			sqlmatriz(3)=   " from cumplimentaoc p " 
			sqlmatriz(4)= 	" left join cumplimentaocd h on h.idcumpoc = p.idcumpoc "
			sqlmatriz(5)=	" left join comprobantes c on c.idcomproba = p.idcomproba "
			sqlmatriz(6)=   " left join puntosventa pv on p.pventa = pv.pventa "
			sqlmatriz(7)=   " left join articulos a on a.articulo=h.articulo "
			sqlmatriz(8)=	" left join articulosf f on a.articulo = f.articulo "
			sqlmatriz(9)=	" where p.idcumpoc = "+ ALLTRIM(STR(v_idcumpoc))
			 
					
			verror=sqlrun(vconeccionF,"cump_imp_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Cumplimentación",0+48+0,"Error")
			ENDIF
		
	
		SELECT * FROM cump_imp_sql INTO TABLE cumpoc_impr
		
			
		SELECT cumpoc_impr
		
		IF NOT EOF()
			SELECT cumpoc_impr
			v_idcomproba = cumpoc_impr.idcomproba
			
			DO FORM reporteform WITH "cumpoc_impr","cumpoccr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar la Cumplimentación para imprimir",0+48+0,"Error al cargar la Cumplimentación")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la Cumplimentación ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION imprimirVinculoComp
PARAMETERS p_idvinculo
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UN COmprobante de Vinculos (COMPROBANTES DE LA TABLA vinculocomp)
* PARAMETROS: P_idvinculo
*#/----------------------------------------


	v_idvinculo = p_idvinculo


	IF v_idvinculo > 0
		

	
		*** Busco los datos de la cumplimentación y el detalle
		
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

			sqlmatriz(1)=	" Select p.*, c.tipo, c.comprobante as nomcomp, pv.puntov "
			sqlmatriz(2)=   " from vinculocomp p " 
			sqlmatriz(3)=	" left join comprobantes c on c.idcomproba = p.idcomproba "
			sqlmatriz(4)=   " left join puntosventa pv on p.pventa = pv.pventa "
			sqlmatriz(5)=	" where p.idvinculo = "+ ALLTRIM(STR(v_idvinculo))
					
			verror=sqlrun(vconeccionF,"vinc_imp_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los Vinculos",0+48+0,"Error")
			ENDIF
		
	
		SELECT * FROM vinc_imp_sql INTO TABLE vinculocompim
		USE IN vinc_imp_sql
			
		SELECT vinculocompim
		
		IF NOT EOF()
			SELECT vinculocompim
			v_idcomproba = vinculocompim.idcomproba
			
			DO FORM reporteform WITH "vinculocompim","vinculocompcr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar el Vinculo para imprimir",0+48+0,"Error al cargar la Vinculos de Comprobantes")
			RETURN 	
		ENDIF 
		USE IN vinculocompim
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar el Vinculo de Comprobantes ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION imprimirPagare
PARAMETERS p_idpagare
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR PAGARES (COMPROBANTES DE LA TABLA pagares)
* PARAMETROS: P_idpagare
*#/----------------------------------------


	v_idpagare = p_idpagare


	IF v_idpagare > 0
		

	
		*** Busco los datos del Pagare
		
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

			sqlmatriz(1)=	" Select p.*, c.tipo, c.comprobante as nomcomp, pv.puntov "
			sqlmatriz(2)=   " from pagares p " 
			sqlmatriz(3)=	" left join comprobantes c on c.idcomproba = p.idcomproba "
			sqlmatriz(4)=   " left join puntosventa pv on p.pventa = pv.pventa "
			sqlmatriz(5)=	" where p.idpagare = "+ ALLTRIM(STR(v_idpagare))
					
			verror=sqlrun(vconeccionF,"pagares_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los Pagares",0+48+0,"Error")
			ENDIF
		
	
		SELECT * FROM pagares_sql INTO TABLE pagaresim
		USE IN pagares_sql
			
		SELECT pagaresim
		
		IF NOT EOF()
			SELECT pagaresim
			v_idcomproba = pagaresim.idcomproba
			
			DO FORM reporteform WITH "pagaresim","pagarescr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar el Pagaré para imprimir",0+48+0,"Error al cargar Pagares")
			RETURN 	
		ENDIF 
		USE IN pagaresim
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar el Pagare ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 




FUNCTION imprimirOC
PARAMETERS p_idoc
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UNA ORDEN DE COMPRA (COMPROBANTES DE LA TABLA OC)
* PARAMETROS: P_IDOC
*#/----------------------------------------


	v_idoc = p_idoc


	IF v_idoc  > 0
		

		v_imprimeMonto	= 1
		
		
		*** Busco los datos de la oc y el detalle
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

		sqlmatriz(1)=" Select f.*,d.*,c.*,f.numero as numNP,com.tipo as tipoCom, c.detalle as detIVA, v.nombre as nomVend,ca.puntov, tc.idafipcom, pv.electronica as electro, ifnull(af.codigo,'') as tipcomAFIP,l.nombre as nomLoc, p.nombre as nomProv,e.cuit,e.direccion, "
		sqlmatriz(2)=" e.telefono, e.email, com.comprobante as nomcomp,ifnull(r.cantcump,0) as cantcump "
		sqlmatriz(3)=" from oc f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
		sqlmatriz(4)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
		sqlmatriz(5)="  left join ocd d on f.idoc = d.idoc "
		sqlmatriz(6)=" left join entidades e on f.entidad = e.entidad left join condfiscal c on e.iva = c.iva"
		sqlmatriz(7)=" left join vendedores v on f.vendedor = v.vendedor "
		sqlmatriz(8)=" left join r_ocdpendientes r on r.idocd = d.idocd "
		sqlmatriz(9)=" left join localidades l on e.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
		sqlmatriz(10)=" where f.idoc = "+ ALLTRIM(STR(v_idoc))
			
					
		verror=sqlrun(vconeccionF,"oc_det_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la NP",0+48+0,"Error")
		ENDIF

		SELECT *, SPACE(200) as otvincula FROM oc_det_sql INTO TABLE .\oc_impr  WHERE imprimir = 'S'

*!*			sqlmatriz(1)=" Select n.idocd, o.fechaot, o.descriptot, p.entidad, p.nombre from otnp n left join otordentra o on o.idot = n.idot left join otpedido p on p.idpedido = o.idpedido "
*!*			sqlmatriz(2)=" where n.idnp = "+ ALLTRIM(STR(v_idnp))
*!*			verror=sqlrun(vconeccionF,"otvin_sql")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
*!*			ENDIF 

*!*			v_otvincula = ""
*!*			SELECT otvin_sql
*!*			GO TOP 
*!*			IF !EOF() THEN 
*!*				v_otvincula = "O.T. Nro. "+ALLTRIM(STR(otvin_sql.idot))+'  F.'+SUBSTR(otvin_sql.fechaot,7,2)+'/'+SUBSTR(otvin_sql.fechaot,5,2)+'/'+SUBSTR(otvin_sql.fechaot,1,4)+'   '+STR(otvin_sql.entidad,6)+'-'+ALLTRIM(otvin_sql.nombre)+'  - '+ALLTRIM(otvin_sql.descriptot)
*!*			ENDIF 
*!*			USE IN otvin_sql 
		
		
		
		
			
		SELECT oc_impr
		
		IF NOT EOF()
			SELECT oc_impr
			ALTER table oc_impr ADD COLUMN imprMonto I
			
			SELECT oc_impr
			GO TOP 
			replace ALL imprMonto WITH v_imprimeMonto
			
			SELECT oc_impr
			GO TOP 
			
			v_idcomproba 	= oc_impr.idcomproba
			v_tipoCompAfip	= ALLTRIM(oc_impr.tipcomAFIP)
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= .F.
			v_cuitEmpresa	= _SYSCUIT
			v_entidad		= oc_impr.entidad
			
			*********************************************
			** Obtengo los datos anexos a la Nota de Pedido y el cliente si los hubiere 
			** agrega los datos extra y anexos de la entidad y la nota de pedido a la impresion
			************************************************************
			*Anexo Entidades
			sqlmatriz(1)=" select concat(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor, concat(r.tabla,SPACE(15)) as tabla from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
			sqlmatriz(2)=" where d.imprimir = 'S' and r.tabla = 'entidades' and r.idregistro = "+ ALLTRIM(STR(v_entidad))
			verror=sqlrun(vconeccionF,"entidadextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Las OT DE Notas de Pedido ",0+48+0,"Error")
			ENDIF 		
			
			*Anexo OC
			sqlmatriz(1)=" select CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(d.valor,SPACE(200)) as valor , concat(r.tabla,SPACE(15)) as tabla from datosextra d left join reldatosextra r on d.iddatosex = r.iddatosex "
			sqlmatriz(2)=" where d.imprimir = 'S' and r.tabla = 'oc' and r.idregistro = "+ ALLTRIM(STR(v_idoc))
			verror=sqlrun(vconeccionF,"ocextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las propiedades de la OC ",0+48+0,"Error")
			ENDIF 		
			
			
			*Anexo prop Detalle
			sqlmatriz(1)=" SELECT CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(r.tabla,SPACE(15)) as tabla,sum(o.cantidad*d.valor) as valor  FROM ocd o left join reldatosextra r on o.articulo = r.idregic and r.tabla = 'articulos' "
			sqlmatriz(2)=" left join datosextra d on r.iddatosex = d.iddatosex where d.imprimir = 'S' and d.operable = 'S' and o.idoc = "+ ALLTRIM(STR(v_idoc)) +" group by d.propiedad "
			sqlmatriz(3)=" union "
			sqlmatriz(4)=" SELECT CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(r.tabla,SPACE(15)) as tabla,sum(o.cantidad*d.valor) as valor  FROM ocd o left join reldatosextra r on o.idmate = r.idregistro and r.tabla = 'otmateriales' "
			sqlmatriz(5)=" left join datosextra d on r.iddatosex = d.iddatosex where d.imprimir = 'S' and d.operable = 'S' and o.idoc = "+ ALLTRIM(STR(v_idoc)) +" group by d.propiedad "

			verror=sqlrun(vconeccionF,"ocdextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las propiedades del detalle de la OC ",0+48+0,"Error")
			ENDIF 		
			

			
			
			
			
			SELECT entidadextra_sql
			GO TOP 
			IF EOF() THEN 
				CREATE TABLE entidadex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , IIF(TYPE('valor')='N',ALLTRIM(STR(valor,13,2)),ALLTRIM(valor)) as valor, tabla FROM entidadextra_sql INTO TABLE .\entidadex ORDER BY propiedad 
				ALTER table entidadex alter COLUMN valor m
			ENDIF 
			USE IN entidadextra_sql
			

			SELECT ocextra_sql
			GO TOP 
			IF EOF() THEN 
				CREATE TABLE ocex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , IIF(TYPE('valor')='N',ALLTRIM(STR(valor,13,2)),ALLTRIM(valor)) as valor, tabla FROM ocextra_sql INTO TABLE .\ocex ORDER BY propiedad 
				ALTER table ocex alter COLUMN valor m
			ENDIF 
			USE IN ocextra_sql 


			SELECT ocdextra_sql
			GO TOP 
			
			IF EOF() THEN 
				CREATE TABLE ocdex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , IIF(TYPE('valor')='N',ALLTRIM(STR(valor,13,2)),ALLTRIM(valor)) as valor , tabla FROM ocdextra_sql INTO TABLE .\ocdex ORDER BY propiedad 
				ALTER table ocdex alter COLUMN valor m
			ENDIF 
			USE IN ocdextra_sql 
			
			

			DO FORM reporteform WITH "oc_impr;entidadex;ocex;ocdex","occr;entidadexcr;ocexcr;ocdexcr",v_idcomproba
			
			=abreycierracon(vconeccionF,"")	

			* Impresion de Datos Anexos si los hubiere
			=ImprimirDetalleAnexo ('oc', v_idoc)
		
			
		ELSE
			MESSAGEBOX("Error al cargar la OC  para imprimir",0+48+0,"Error al cargar la NP")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la OC ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


 FUNCTION imprimirAcopio
PARAMETERS p_idacopio
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UNA Acopio(COMPROBANTES DE LA TABLA Acopio)
* PARAMETROS: P_IDACOPIO
*#/----------------------------------------


	v_idacopio = p_idacopio


	IF v_idacopio > 0



		CREATE TABLE comprobantesimp FREE (fecha C(8), idregistro I, idnp I, numComp C(30), tipoComp C(60), neto Y, op I, acopio C(1), imprimir I, observa c(254), idajuste I, numacop I, cliacop I, ;
		nomCliAcop C(200), carAcop I, nomCarAcop C(200), ordAcop I, fechaAcop C(8), descAcop C(200), masAcop N(13,2), menosAcop N(13,2), saldoAcop N(13,2), tipoC C(1), nombrecomp C(50), puntov C(4), acopmast N(13,2), acopmenost N(13,2))
		
		SELECT comprobantesimp
		INDEX on ALLTRIM(fecha) TO fechaimp
		SET ORDER TO fechaimp

		CREATE TABLE materialesimp	FREE (idmate I, detalle C(100), unidad C(10),precio y, tipocbio y,moneda I,nom_mone C(80), op I, idacopiod I, kg y, kgTot y)

		vconeccionD=abreycierracon(0,_SYSSCHEMA)	
		
		************************************
		*** Busco la Cabecera del acopio ***
		************************************
		
		sqlmatriz(1)= "SELECT a.*,c.apellido as apeCli, c.nombre as nomCli, c.compania as compaCli ,r.apellido as apeCar, r.nombre as nomCar, r.compania as compCar, o.tipo, o.comprobante,p.puntov  "
		sqlmatriz(2)= " FROM acopio a left join entidades c on a.entidad = c.entidad left join entidades r on  a.carpintero = r.entidad  left join comprobantes o on a.idcomproba = o.idcomproba  left join puntosventa p on a.pventa = p.pventa "
		sqlmatriz(3)= " where a.idacopio = "+ALLTRIM(STR(v_idacopio))
		
		verror=sqlrun(vconeccionD,"acopio_sql_im")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los comprobantes asociados al acopio ",0+48+0,"Error")
		ENDIF
					
					
		v_numAcop = 0
		v_cliAcop =0
		v_nomCliAcop = ""
		v_carAcop = 0
		v_nomCArAcop = ""
		v_ordAcop	= 0
		v_fechaAcop	= ""
		v_descAcop = ""
		v_tipoC	= ""
		v_nombrecomp = ""
		v_puntov = "0000"
		
		v_masAcopt = 0.00
		v_menosAcopt = 0.00
		v_saldoAcopt = 0.00
		v_idcomprobaAcop = 0
		
		
		SELECT acopio_sql_im
		GO TOP 
		
		IF NOT EOF()

			v_numAcop = acopio_sql_im.numcomp
			v_cliAcop =  acopio_sql_im.entidad
			v_nomCliAcop = IIF(EMPTY(ALLTRIM(acopio_sql_im.apeCli+ " "+acopio_sql_im.nomCli))=.T.,acopio_sql_im.compaCli,ALLTRIM(acopio_sql_im.apeCli+ " "+acopio_sql_im.nomCli))
		
			v_carAcop = acopio_sql_im.carpintero
			v_nomCArAcop =  IIF(EMPTY(ALLTRIM(acopio_sql_im.apeCar+ " "+acopio_sql_im.nomCar))=.T.,acopio_sql_im.compCar,ALLTRIM(acopio_sql_im.apeCar+ " "+acopio_sql_im.nomCar))
			
			v_ordAcop	= acopio_sql_im.numero
			v_fechaAcop	= acopio_sql_im.fecha
			v_descAcop = acopio_sql_im.descrip
			v_idcomprobaAcop = acopio_sql_im.idcomproba
			v_tipoc		= acopio_sql_im.tipo
			v_nombrecomp = acopio_sql_im.comprobante
			v_puntov = acopio_sql_im.puntov

					
		ELSE
		
			RETURN 
		ENDIF 
				
		
		**************************************
		*** Busco comprobantes de facturas ***
		**************************************
		
		sqlmatriz(1)=" select a.*,p.puntov as actividad, f.numero, f.neto, f.fecha as fechaF,f.observa1 as observa, c.comprobante,c.abrevia, IF(a.importe < 0,-1,IF(a.importe > 0,1,0)) as opera from compacopio a left join facturas f "
		sqlmatriz(2)=" ON a.idregistro = f.idfactura left join comprobantes c on f.idcomproba = c.idcomproba left join puntosventa p on f.pventa = p.pventa left join tipocompro t on c.idtipocompro = t.idtipocompro "
		sqlmatriz(3)=" where a.idacopio = "+ALLTRIM(STR(v_idacopio))+" and a.idregistro > 0 "
		sqlmatriz(4)=" order by f.fecha, f.numero, f.idcomproba "
		
		verror=sqlrun(vconeccionD,"acopiosFac_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los comprobantes asociados al acopio ",0+48+0,"Error")
		ENDIF
		
		v_acopmenosFac 	= 0.00
		v_acopmasFac	= 0.00
			
				
		SELECT acopiosFac_sql
		GO TOP 
		
		DO WHILE NOT EOF()

		
			v_fecha 		= acopiosFac_sql.fechaF
			v_idregistro 	= acopiosFac_sql.idregistro
			v_idnp			= acopiosFac_sql.idnp
			v_idajuste		= acopiosFac_sql.idajustea
			v_numComp		= ALLTRIM(acopiosFac_sql.abrevia)+"      " + ALLTRIM(acopiosFac_sql.actividad)+" - "+ALLTRIM(STRTRAN(STR(acopiosFac_sql.numero, 8,0),' ','0'))
			v_tipoComp 		= acopiosFac_sql.comprobante 
			v_neto			= ROUND(acopiosFac_sql.importe,2)
			v_op			= acopiosFac_sql.opera 
			v_acopio		= acopiosFac_sql.acopio
			v_imp 			= 1
			v_observa		= ALLTRIM(acopiosFac_sql.observa)
			
			IF v_op < 0
				v_acopmenosFac 	= v_neto
				v_menosAcopt = v_menosAcopt + v_acopmenosFac 
			ELSE
				IF v_op > 0
					v_acopmasFac =  v_neto
					v_masAcopt = v_masAcopt + v_acopmasFac 
				ENDIF 
			ENDIF 
	
			INSERT INTO comprobantesimp values(v_fecha, v_idregistro, v_idnp,v_numComp, v_tipoComp, v_neto,v_op,v_acopio,v_imp, v_observa,v_idajuste,v_numacop, ;
			v_cliacop, v_nomCliAcop, v_carAcop, v_nomCarAcop, v_ordAcop, v_fechaAcop, v_descAcop, v_acopmasFac , v_acopmenosFac, v_saldoAcopt, v_tipoc, v_nombrecomp,v_puntov,v_masAcopt,v_menosAcopt)
		
	
	
			SELECT acopiosFac_sql
			SKIP 1
		
		ENDDO 
		*********************
		*** Busco Ajustes ***
		*********************
		v_acopmenosAju 	= 0.00
		v_acopmasAju	= 0.00
		
*!*			sqlmatriz(1)=" select a.*,aj.fecha as fechaA,aj.monto as montoAju, aj.observa from compacopio a left join ajustesacopio aj " 
*!*			sqlmatriz(2)=" ON a.idajustea = aj.idajustea "
*!*			sqlmatriz(3)=" where a.idacopio = "+ALLTRIM(STR(v_idacopio))+" and  a.idajustea > 0 "
*!*			sqlmatriz(4)=" order by aj.idajustea"
*!*			
*!*			verror=sqlrun(vconeccionD,"ajustesAcop_sql")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de ajustes de acopio",0+48+0,"Error")
*!*			ENDIF 
		
		
		
		
		
		sqlmatriz(1)=" select a.*,aj.fecha as fechaA,aj.monto as montoAju, aj.observa, IF(a.importe < 0,-1,IF(a.importe > 0,1,0)) as opera from compacopio a left join ajustesacopio aj " 
		sqlmatriz(2)=" ON a.idajustea = aj.idajustea "
		sqlmatriz(3)= "where a.idacopio = "+ALLTRIM(STR(v_idacopio))+" and  a.idajustea > 0 "
		sqlmatriz(4)=" order by aj.idajustea"


		verror=sqlrun(vconeccionD,"ajustesAcop_sqla")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de ajustes de acopio",0+48+0,"Error")
		ENDIF 


		SELECT * FROM  ajustesAcop_sqla INTO TABLE  ajustesAcop_sql
		GO TOP 

		ALTER table ajustesAcop_sql alter COLUMN opera I


		SELECT ajustesAcop_sql 
		GO TOP 
		replace ALL importe WITH importe*opera

		
		
		SELECT ajustesAcop_sql 
		GO TOP 

		DO WHILE NOT EOF()



			v_fecha 		= ajustesAcop_sql.fechaA
			v_idregistro 	= ajustesAcop_sql.idregistro
			v_idnp			= ajustesAcop_sql.idnp
			v_idajuste		= ajustesAcop_sql.idajustea
			v_op 		= ajustesAcop_sql.opera
			
			v_numComp		= "AJUSTE - " + ALLTRIM(STRTRAN(STR(ajustesAcop_sql.idajustea, 8,0),' ','0'))
			v_tipoComp 		= "AJUSTE "+ALLTRIM(IIF(v_op < 0, "DE EGRESO","DE INGRESO"))
			v_neto			= ROUND(ajustesAcop_sql.montoAju,2)
			v_acopio		= ajustesAcop_sql.acopio
			
			v_imp 			= 1
			
			
			
			v_busqueda		= ALLTRIM(v_numComp)+ALLTRIM(v_tipoComp)
			v_observa		= ALLTRIM(ajustesAcop_sql.observa)

	
		
			
			
*!*				v_fecha 		= ajustesAcop_sql.fechaA
*!*				v_idregistro 	= ajustesAcop_sql.idregistro
*!*				v_idnp			= ajustesAcop_sql.idnp
*!*				v_idajuste		= ajustesAcop_sql.idajustea
*!*				v_numComp		= "AJUSTE      " + ALLTRIM(STRTRAN(STR(ajustesAcop_sql.idajustea, 8,0),' ','0'))
*!*				v_tipoComp 		= "Ajuste de Acopio"
*!*				v_neto			= ROUND(ajustesAcop_sql.montoAju,2)
*!*				v_acopio		= ajustesAcop_sql.acopio
			
*!*				DO CASE
*!*				CASE v_neto > 0
*!*				
*!*					IF v_acopio = 'S'
*!*						v_op = 1
*!*						v_acopmasAju =  v_neto
*!*						v_masAcopt = v_masAcopt + v_acopmasAju 
*!*					ELSE
*!*						v_op = 0
*!*		
*!*					ENDIF 
*!*				CASE v_neto < 0
*!*					v_op = -1
*!*					v_acopmenosAju 	= (-1*v_neto)
*!*					v_menosAcopt = v_menosAcopt + v_acopmenosAju 
*!*				OTHERWISE
*!*					v_op 	= 0

*!*				ENDCASE
*!*		
	
	
			DO CASE
				CASE v_op > 0
					v_acopmasAju =  v_neto
					v_masAcopt = v_masAcopt + v_acopmasAju 
				CASE v_op < 0
					v_acopmenosAju 	= v_neto
					v_menosAcopt = v_menosAcopt + v_acopmenosAju 
				
			ENDCASE
		
			v_imp 			= 1
			v_observa		= ALLTRIM(ajustesAcop_sql.observa)
			
			INSERT INTO comprobantesimp values(v_fecha, v_idregistro, v_idnp,v_numComp, v_tipoComp, v_neto,v_op,v_acopio,v_imp, v_observa,v_idajuste,v_numacop, ;
			v_cliacop, v_nomCliAcop, v_carAcop, v_nomCarAcop, v_ordAcop, v_fechaAcop, v_descAcop, v_acopmasAju , v_acopmenosAju , v_saldoAcopt, v_tipoc, v_nombrecomp,v_puntov,v_masAcopt,v_menosAcopt)
		
		
		

			SELECT ajustesAcop_sql
			SKIP 1

		ENDDO 
	
		****************
		*** Busco NP ***
		****************
		v_acopmenosNP 	= 0.00
		v_acopmasNP	= 0.00
		
		sqlmatriz(1)=" select a.* from compacopio a "
		sqlmatriz(2)=" where a.idacopio = "+ALLTRIM(STR(v_idacopio))+" and a.idnp > 0 "

	
		verror=sqlrun(vconeccionD,"acopiosNPA_sql")

		SELECT * FROM acopiosNPA_sql INTO TABLE .\acopiosNP_sql
		
		SELECT acopiosNP_sql
		GO TOP 

		IF NOT EOF()
			DO WHILE NOT EOF()
				
				v_fecha 		= acopiosNP_sql.fechanp 
				v_idregistro 	= acopiosNP_sql.idregistro
				v_idajuste		= acopiosNP_sql.idajustea
				v_idnp			= acopiosNP_sql.idnp
				v_numComp		= "NP        " + ALLTRIM(acopiosNP_sql.nroserie)+" - "+ALLTRIM(STRTRAN(STR(acopiosNP_sql.nronp, 8,0),' ','0'))
				v_tipoComp 		= "Nota de Pedido"
				v_neto			= ROUND(acopiosNP_sql.importe,2)
				v_op			= 0
				v_acopio		= acopiosNP_sql.acopio
				v_imp			= 1
				v_observa		= ALLTRIM(acopiosNp_Sql.observa)

				
				INSERT INTO comprobantesimp values(v_fecha, v_idregistro, v_idnp,v_numComp, v_tipoComp, v_neto,v_op,v_acopio,v_imp, v_observa,v_idajuste,v_numacop, ;
				v_cliacop, v_nomCliAcop, v_carAcop, v_nomCarAcop, v_ordAcop, v_fechaAcop, v_descAcop, v_acopmasNP, v_acopmenosNP , v_saldoAcopt, v_tipoc, v_nombrecomp,v_puntov,v_masAcopt,v_menosAcopt)
	
	
	

				SELECT acopiosNP_sql
				SKIP 1

			ENDDO 

		ENDIF 
		************************
		*** Busco materiales ***
		************************
		
		sqlmatriz(1)=" select a.*, m.detalle, m.unidad from acopiod a left join mateacopio m on a.idmateacopio = m.idmateacopio "
		sqlmatriz(2)=" where a.idacopio = "+ALLTRIM(STR(v_Idacopio))
		sqlmatriz(3)=" order by a.idmateacopio "

	
		verror=sqlrun(vconeccionD,"acopiosMat_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Materiales del acopio",0+48+0,"Error")
		ENDIF 

		SELECT * FROM acopiosMat_sql INTO TABLE .\acopiosMat
		SELECT acopiosMat
		GO TOP 

		DO WHILE NOT EOF()
				
			v_idacopiod	= acopiosMat.idacopiod
			v_idmate 	= acopiosMat.idmateacop
			v_detalle	= acopiosMat.detalle
			v_unidad	= acopiosMat.unidad
			v_precio	= ROUND(acopiosMat.precio,2)
			v_tipocmbio	= ROUND(acopiosMat.tipocbio,2)
			v_moneda	= acopiosMat.moneda
			
			SELECT monedas_sql 
			GO top
			LOCATE FOR moneda = v_moneda
			v_nom_mon	= monedas_sql.nombre
			v_op		= 0
			v_kg		= 0.0
			v_kgTot		= 0.0

									
			INSERT INTO materialesimp values (v_idmate, v_detalle, v_unidad, v_precio, v_tipocmbio, v_moneda,v_nom_mon,v_op,v_idacopiod,v_kg,v_kgtot)

			SELECT acopiosMat
			SKIP 1

		ENDDO 

		*** Me desconecto ***
		=abreycierracon(vconeccionD,"")	


		v_saldoAcopt = v_masAcopt - v_menosAcopt 
	
			
		SELECT comprobantesimp 
		GO TOP 

		replace ALL saldoacop WITH v_saldoAcopt, acopmast WITH v_masAcopt, acopmenost WITH v_menosAcopt 



			IF v_idcomprobaAcop > 0

				DO FORM reporteform WITH "comprobantesimp;materialesimp","comprobantescr;materialescr",v_idcomprobaAcop 
			
			
			ENDIF 

						
	ELSE
		MESSAGEBOX("NO se pudo recuperar el ACOPIO para imprimir ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 



 FUNCTION imprimirAcopiop
PARAMETERS p_idacopiop
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UNA Acopiop(COMPROBANTES DE LA TABLA Acopiop)
* PARAMETROS: P_IDACOPIOP
*#/----------------------------------------


	v_idacopiop = p_idacopiop


	IF v_idacopiop > 0



		CREATE TABLE comprobantespimp FREE (fecha C(8), idregistro I, idnp I, numComp C(30), tipoComp C(60), total Y, op I, acopio C(1), imprimir I, observa c(254), idajuste I, numacop I, cliacop I, ;
		nomCliAcop C(200), carAcop I, nomCarAcop C(200), ordAcop I, fechaAcop C(8), descAcop C(200), masAcop N(13,2), menosAcop N(13,2), saldoAcop N(13,2), tipoC C(1), nombrecomp C(50), puntov C(4), acopmast N(13,2), acopmenost N(13,2))
		
		SELECT comprobantespimp
		INDEX on ALLTRIM(fecha) TO fechaimp
		SET ORDER TO fechaimp

		CREATE TABLE materialespimp	FREE (idmate I, detalle C(100), unidad C(10),precio y, tipocbio y,moneda I,nom_mone C(80), op I, idacopiod I, kg y, kgTot y)

		vconeccionD=abreycierracon(0,_SYSSCHEMA)	
		
		************************************
		*** Busco la Cabecera del acopiop ***
		************************************
		
		sqlmatriz(1)= "SELECT a.*,c.apellido as apeCli, c.nombre as nomCli, c.compania as compaCli , o.tipo, o.comprobante,p.puntov  "
		sqlmatriz(2)= " FROM acopiop a left join entidades c on a.entidad = c.entidad left join comprobantes o on a.idcomproba = o.idcomproba  left join puntosventa p on a.pventa = p.pventa "
		sqlmatriz(3)= " where a.idacopiop = "+ALLTRIM(STR(v_idacopiop))
		
		verror=sqlrun(vconeccionD,"acopiop_sql_im")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los comprobantes asociados al acopiop ",0+48+0,"Error")
		ENDIF
					
					
		v_numAcop = 0
		v_cliAcop =0
		v_nomCliAcop = ""
		v_carAcop = 0
		v_nomCArAcop = ""
		v_ordAcop	= 0
		v_fechaAcop	= ""
		v_descAcop = ""
		v_tipoC	= ""
		v_nombrecomp = ""
		v_puntov = "0000"
		
		v_masAcopt = 0.00
		v_menosAcopt = 0.00
		v_saldoAcopt = 0.00
		v_idcomprobaAcop = 0
		
		
		SELECT acopiop_sql_im
		GO TOP 
		
		IF NOT EOF()

			v_numAcop = acopiop_sql_im.numcomp
			v_cliAcop =  acopiop_sql_im.entidad
			v_nomCliAcop = IIF(EMPTY(ALLTRIM(acopiop_sql_im.apeCli+ " "+acopiop_sql_im.nomCli))=.T.,acopiop_sql_im.compaCli,ALLTRIM(acopiop_sql_im.apeCli+ " "+acopiop_sql_im.nomCli))
		
			
			v_ordAcop	= acopiop_sql_im.numero
			v_fechaAcop	= acopiop_sql_im.fecha
			v_descAcop = acopiop_sql_im.descrip
			v_idcomprobaAcop = acopiop_sql_im.idcomproba
			v_tipoc		= acopiop_sql_im.tipo
			v_nombrecomp = acopiop_sql_im.comprobante
			v_puntov = acopiop_sql_im.puntov

					
		ELSE
		
			RETURN 
		ENDIF 
				
		
		**************************************
		*** Busco comprobantes de facturas ***
		**************************************
		
		sqlmatriz(1)=" select a.*,f.actividad, f.numero, f.neto,f.total, f.fecha as fechaF,f.observa, c.comprobante,c.abrevia, IF(a.importe < 0,-1,IF(a.importe > 0,1,0)) as opera from compacopiop a left join factuprove f "
		sqlmatriz(2)=" ON a.idregistro = f.idfactprove left join comprobantes c on f.idcomproba = c.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro "
		sqlmatriz(3)=" where a.idacopiop = "+ALLTRIM(STR(v_idacopiop))+" and a.idregistro > 0 "
		sqlmatriz(4)=" order by f.fecha, f.numero, f.idcomproba "
		
		
			
		verror=sqlrun(vconeccionD,"acopiosFacp_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los comprobantes asociados al acopiop ",0+48+0,"Error")
		ENDIF
		
		v_acopmenosFac 	= 0.00
		v_acopmasFac	= 0.00
			
				
		SELECT acopiosFacp_sql
		GO TOP 
		
		DO WHILE NOT EOF()

		
			v_fecha 		= acopiosFacp_sql.fechaF
			v_idregistro 	= acopiosFacp_sql.idregistro
			v_idnp			= acopiosFacp_sql.idnp
			v_idajuste		= acopiosFacp_sql.idajusteap
			v_numComp		= ALLTRIM(acopiosFacp_sql.abrevia)+"      " +ALLTRIM(STRTRAN(STR(acopiosFacp_sql.actividad, 4,0),' ','0'))+" - "+ALLTRIM(STRTRAN(STR(acopiosFacp_sql.numero, 8,0),' ','0'))
			v_tipoComp 		= acopiosFacp_sql.comprobante 
			v_total			= ROUND(acopiosFacp_sql.total,2)
			v_op			= acopiosFacp_sql.opera 
			v_acopio		= acopiosFacp_sql.acopio
			v_imp 			= 1
			v_observa		= ALLTRIM(acopiosFacp_sql.observa)
			
			IF v_op < 0
				v_acopmenosFac 	= v_total
				v_menosAcopt = v_menosAcopt + v_acopmenosFac 
			ELSE
				IF v_op > 0
					v_acopmasFac =  v_total
					v_masAcopt = v_masAcopt + v_acopmasFac 
				ENDIF 
			ENDIF 
	
			INSERT INTO comprobantespimp values(v_fecha, v_idregistro, v_idnp,v_numComp, v_tipoComp, v_total,v_op,v_acopio,v_imp, v_observa,v_idajuste,v_numacop, ;
			v_cliacop, v_nomCliAcop, v_carAcop, v_nomCarAcop, v_ordAcop, v_fechaAcop, v_descAcop, v_acopmasFac , v_acopmenosFac, v_saldoAcopt, v_tipoc, v_nombrecomp,v_puntov,v_masAcopt,v_menosAcopt)
		
	
	
			SELECT acopiosFacp_sql
			SKIP 1
		
		ENDDO 
		*********************
		*** Busco Ajustes ***
		*********************
		v_acopmenosAju 	= 0.00
		v_acopmasAju	= 0.00
		

		
		sqlmatriz(1)=" select a.*,aj.fecha as fechaA,aj.monto as montoAju, aj.observa, IF(a.importe < 0,-1,IF(a.importe > 0,1,0)) as opera from compacopiop a left join ajustesacopiop aj " 
		sqlmatriz(2)=" ON a.idajusteap = aj.idajusteap "
		sqlmatriz(3)= "where a.idacopiop = "+ALLTRIM(STR(v_idacopiop))+" and  a.idajusteap > 0 "
		sqlmatriz(4)=" order by aj.idajusteap"


		verror=sqlrun(vconeccionD,"ajustesAcopp_sqla")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de ajustes de acopiop",0+48+0,"Error")
		ENDIF 


		SELECT * FROM  ajustesAcopp_sqla INTO TABLE  ajustesAcopp_sql
		GO TOP 

		ALTER table ajustesAcopp_sql alter COLUMN opera I


		SELECT ajustesAcopp_sql
		GO TOP 
		replace ALL importe WITH importe*opera

		
		
		SELECT ajustesAcopp_sql
		GO TOP 

		DO WHILE NOT EOF()



			v_fecha 		= ajustesAcopp_sql.fechaA
			v_idregistro 	= ajustesAcopp_sql.idregistro
			v_idnp			= ajustesAcopp_sql.idnp
			v_idajuste		= ajustesAcopp_sql.idajusteap
			v_op 			= ajustesAcopp_sql.opera
			
			v_numComp		= "AJUSTE - " + ALLTRIM(STRTRAN(STR(ajustesAcopp_sql.idajusteap, 8,0),' ','0'))
			v_tipoComp 		= "AJUSTE "+ALLTRIM(IIF(v_op < 0, "DE EGRESO","DE INGRESO"))
			v_total			= ROUND(ajustesAcopp_sql.montoAju,2)
			v_acopio		= ajustesAcopp_sql.acopio
			
			v_imp 			= 1
			
			
			
			v_busqueda		= ALLTRIM(v_numComp)+ALLTRIM(v_tipoComp)
			v_observa		= ALLTRIM(ajustesAcopp_sql.observa)

	
		
	
			DO CASE
				CASE v_op > 0
					v_acopmasAju =  v_total
					v_masAcopt = v_masAcopt + v_acopmasAju 
				CASE v_op < 0
					v_acopmenosAju 	= v_total
					v_menosAcopt = v_menosAcopt + v_acopmenosAju 
				
			ENDCASE
		
			v_imp 			= 1
			v_observa		= ALLTRIM(ajustesAcopp_sql.observa)
			
			INSERT INTO comprobantespimp values(v_fecha, v_idregistro, v_idnp,v_numComp, v_tipoComp, v_total,v_op,v_acopio,v_imp, v_observa,v_idajuste,v_numacop, ;
			v_cliacop, v_nomCliAcop, v_carAcop, v_nomCarAcop, v_ordAcop, v_fechaAcop, v_descAcop, v_acopmasAju , v_acopmenosAju , v_saldoAcopt, v_tipoc, v_nombrecomp,v_puntov,v_masAcopt,v_menosAcopt)
		
		
		

			SELECT ajustesAcopp_sql
			SKIP 1

		ENDDO 
	
		****************
		*** Busco NP ***
		****************
		v_acopmenosNP 	= 0.00
		v_acopmasNP	= 0.00
		
		sqlmatriz(1)=" select a.* from compacopiop a "
		sqlmatriz(2)=" where a.idacopiop = "+ALLTRIM(STR(v_idacopiop))+" and a.idnp > 0 "

	
		verror=sqlrun(vconeccionD,"acopiospNPA_sql")

		SELECT * FROM acopiospNPA_sql INTO TABLE .\acopiospNP_sql
		
		SELECT acopiospNP_sql
		GO TOP 

		IF NOT EOF()
			DO WHILE NOT EOF()
				
				v_fecha 		= acopiospNP_sql.fechanp 
				v_idregistro 	= acopiospNP_sql.idregistro
				v_idajuste		= acopiospNP_sql.idajusteap
				v_idnp			= acopiospNP_sql.idnp
				v_numComp		= "NP        " + ALLTRIM(acopiospNP_sql.nroserie)+" - "+ALLTRIM(STRTRAN(STR(acopiospNP_sql.nronp, 8,0),' ','0'))
				v_tipoComp 		= "Nota de Pedido"
				v_total			= ROUND(acopiospNP_sql.importe,2)
				v_op			= 0
				v_acopio		= acopiospNP_sql.acopiop
				v_imp			= 1
				v_observa		= ALLTRIM(acopiospNP_sql.observa)

				
				INSERT INTO comprobantespimp values(v_fecha, v_idregistro, v_idnp,v_numComp, v_tipoComp, v_total,v_op,v_acopio,v_imp, v_observa,v_idajuste,v_numacop, ;
				v_cliacop, v_nomCliAcop, v_carAcop, v_nomCarAcop, v_ordAcop, v_fechaAcop, v_descAcop, v_acopmasNP, v_acopmenosNP , v_saldoAcopt, v_tipoc, v_nombrecomp,v_puntov,v_masAcopt,v_menosAcopt)
	
	
	

				SELECT acopiosNP_sql
				SKIP 1

			ENDDO 

		ENDIF 
		************************
		*** Busco materiales ***
		************************
		
		sqlmatriz(1)=" select a.*, m.detalle, m.unidad from acopiodp a left join mateacopio m on a.idmateacop = m.idmateacopio "
		sqlmatriz(2)=" where a.idacopiop = "+ALLTRIM(STR(v_Idacopiop))
		sqlmatriz(3)=" order by a.idmateacop "

	
		verror=sqlrun(vconeccionD,"acopiospMat_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Materiales del acopiop",0+48+0,"Error")
		ENDIF 

		SELECT * FROM acopiospMat_sql INTO TABLE .\acopiospMat
		SELECT acopiospMat
		GO TOP 

		DO WHILE NOT EOF()
				
			v_idacopiodp	= acopiospMat.idacopiodp
			v_idmate 	= acopiospMat.idmateacop
			v_detalle	= acopiospMat.detalle
			v_unidad	= acopiospMat.unidad
			v_precio	= ROUND(acopiospMat.precio,2)
			v_tipocmbio	= ROUND(acopiospMat.tipocbio,2)
			v_moneda	= acopiospMat.moneda
			
			SELECT monedas_sql 
			GO top
			LOCATE FOR moneda = v_moneda
			v_nom_mon	= monedas_sql.nombre
			v_op		= 0
			v_kg		= 0.0
			v_kgTot		= 0.0

									
			INSERT INTO materialespimp values (v_idmate, v_detalle, v_unidad, v_precio, v_tipocmbio, v_moneda,v_nom_mon,v_op,v_idacopiodp,v_kg,v_kgtot)

			SELECT acopiospMat
			SKIP 1

		ENDDO 

		*** Me desconecto ***
		=abreycierracon(vconeccionD,"")	


		v_saldoAcopt = v_masAcopt - v_menosAcopt 
	
			
		SELECT comprobantespimp 
		GO TOP 

		replace ALL saldoacop WITH v_saldoAcopt, acopmast WITH v_masAcopt, acopmenost WITH v_menosAcopt 



			IF v_idcomprobaAcop > 0

				DO FORM reporteform WITH "comprobantespimp;materialespimp","comprobantespcr;materialespcr",v_idcomprobaAcop 
			
			
			ENDIF 

						
	ELSE
		MESSAGEBOX("NO se pudo recuperar el ACOPIOP para imprimir ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 



FUNCTION compruebaCajaReca
*#/----------------------------------------
*** Controlo que se haya seleccionado una caja de recaudación 
*#/----------------------------------------

IF _SYSCAJARECA = 0 && No hay caja seleccionada, pide caja

	v_idcajareca = 0
	
		vconeccion = abreycierracon(0,_SYSSCHEMA)
		sqlmatriz(1)=" select * from cajarecauda"
		verror=sqlrun(vconeccion,"cajareca_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las cajareca",0+48+0,"Error")
		ENDIF 
		* me desconecto	
		=abreycierracon(vconeccion,"")
		SELECT cajareca_sql 
		GO TOP 
		IF RECCOUNT() = 1  THEN 
			v_idcajareca=cajareca_sql.idcajareca
		ENDIF 
		IF RECCOUNT() = 0  THEN 
			v_idcajareca=1
		ENDIF 
		USE IN cajareca_sql 
	
	IF v_idcajareca=0 THEN 	
		DO FORM selectcajareca  TO v_idcajareca
	ENDIF 
	
	IF v_idcajareca > 0
		_SYSCAJARECA = v_idcajareca
	ENDIF 

ENDIF 


ENDFUNC 

FUNCTION guardaCajaRecaH 
PARAMETERS p_idComp, p_idReg, p_idCajaR
*#/----------------------------------------
* ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO
* PARAMETROS: P_idComp: id comprobante; P_idReg: ID del registro
*#/----------------------------------------
				
		v_idcajarecaudah = maxnumeroidx("idcajareh","I","cajarecaudah",1)

		v_idcajareca 	= _SYSCAJARECA
		IF TYPE('p_idCajaR')= 'N' THEN 
			v_idcajareca = p_idCajaR
		ENDIF 
		vcerrarcon = .f.
		IF !TYPE('vconeccionF')='N' THEN 
			* me conecto a la base de datos
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			vcerrarcon = .t.
		ENDIF 
		v_usuario		= _SYSUSUARIO
		v_idcomproba	= p_idComp
		v_idregicomp	=  p_idReg
		v_fecha			= DTOS(DATE())
		v_hora			= TIME()
		
		
		DIMENSION lamatriz3(7,2)
				
		lamatriz3(1,1)='idcajareh'
		lamatriz3(1,2)= ALLTRIM(STR(v_idcajarecaudah ))
		lamatriz3(2,1)='idcajareca'
		lamatriz3(2,2)= ALLTRIM(STR(v_idcajareca ))
		lamatriz3(3,1)='usuario'
		lamatriz3(3,2)= "'"+ALLTRIM(v_usuario)+"'"
		lamatriz3(4,1)='idcomproba'
		lamatriz3(4,2)= ALLTRIM(STR(v_idcomproba))
		lamatriz3(5,1)='idregicomp'
		lamatriz3(5,2)= ALLTRIM(STR(v_idregicomp))
		lamatriz3(6,1)='fecha'
		lamatriz3(6,2)="'"+ALLTRIM(v_fecha)+"'"
		lamatriz3(7,1)='hora'
		lamatriz3(7,2)="'"+ALLTRIM(v_hora)+"'"

			
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'cajarecaudah'
		p_matriz    = 'lamatriz3'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
		    RETURN .F.
		ENDIF	
		
		RELEASE lamatriz3
		
		IF vcerrarcon = .t. THEN 
			=abreycierracon(vconeccionF,"")				
		ENDIF 
		RETURN .T.

ENDFUNC 



FUNCTION decimalARGB
PARAMETERS p_numDecimal
*#/----------------------------------------
*** Función que recibe un numero decimal y retorna el RGB equivalente, en una cadena de texto
*#/----------------------------------------

v_num = p_numDecimal

v_cad1 = ""
v_cad2 = ""
v_cad3 = ""

v_cad1 = ALLTRIM(STRTRAN(STR(INT(VAL('0x'+RIGHT(TRANSFORM(v_num , '@0'),2))),3,0)," ","0"))

v_cad2= ALLTRIM(STRTRAN(STR(INT(VAL('0x'+SUBSTR(TRANSFORM(v_num, '@0'),7,2))),3,0)," ","0"))

v_cad3 = ALLTRIM(STRTRAN(STR(INT(VAL('0x'+SUBSTR(TRANSFORM(v_num , '@0'),5,2))),3,0)," ","0"))

v_retorno = v_cad1 + v_cad2 + v_cad3


*v_retorno = ALLTRIM(STR(INT(VAL('0x'+RIGHT(TRANSFORM(v_num , '@0'),2)))))+ALLTRIM(STR(INT(VAL('0x'+SUBSTR(TRANSFORM(v_num, '@0'),7,2)))))+ALLTRIM(STR(INT(VAL('0x'+SUBSTR(TRANSFORM(v_num , '@0'),5,2))))


RETURN v_retorno

ENDFUNC 




FUNCTION Encripta(tcCadena, tcLlave, tlSinDesencripta)
*#/----------------------------------------
* Función que encripta una cadena
* Parámetros:
*    tcCadena - Cadena a encriptar
*    tcLlave - Llave para encriptar (Debe ser la misma para Desencriptar)
*    tlSinDesencripta - .F. para proceso que se puede usar Desencripta
*       Los textos encriptados con este tlSinDesencripta en .T. no se pueden
*       desencriptar, ya que el mecanismo de encriptamiento utilizado
*       produce perdida de informacion que impide la inversion del proceso
* Retorno: Caracter (el doble de largo que el texto pasado)
*#/----------------------------------------
 LOCAL lc, ln, lcRet
 LOCAL lnClaveMul, lnClaveXor
 IF EMPTY(tcLlave)
  tcLlave = ""
 ENDIF
 =GetClaves(tcLlave,@lnClaveMul,@lnClaveXor)
 lcRet = ""
 lc = tcCadena
 DO WHILE LEN(lc) > 0
  ln = BITXOR(ASC(lc)*(lnClaveMul+1),lnClaveXor)
  IF tlSinDesencripta
   *-- Encripta de modo que no se puede desencriptar
   ln = BITAND(ln+(ln%256)*17+INT(ln/256)*135+ ;
    INT(ln/256)*(ln%256),65535)
  ENDIF
  lcRet = lcRet+BINTOC(ln-32768,2)
  lnClaveMul = BITAND(lnClaveMul+59,0xFF)
  lnClaveXor = BITAND(BITNOT(lnClaveXor),0xFFFF)
  lc = IIF(LEN(lc) > 1,SUBS(lc,2),"")
 ENDDO
 RETURN lcRet
ENDFUNC



FUNCTION Desencripta(tcCadena, tcLlave)
*#/----------------------------------------
* Función que desencripta una cadena encriptada
* Parámetros:
*    tcCadena - Cadena a desencriptar
*    tcLlave - Llave para desencriptar (Debe ser la misma de Encriptar)
* Retorno: Caracter (la mitad de largo que el texto pasado)
*#/----------------------------------------
 LOCAL lc, ln, lcRet, lnByte
 LOCAL lnClaveMul, lnClaveXor
 IF EMPTY(tcLlave)
  tcLlave = ""
 ENDIF
 =GetClaves(tcLlave, @lnClaveMul, @lnClaveXor)
 lcRet = ""
 FOR ln = 1 TO LEN(tcCadena)-1 STEP 2
  lnByte = BITXOR(CTOBIN(SUBS(tcCadena, ln,2))+ ;
   32768,lnClaveXor)/(lnClaveMul+1)
  lnClaveMul = BITAND(lnClaveMul+59, 0xFF)
  lnClaveXor = BITAND(BITNOT(lnClaveXor), 0xFFFF)
  lcRet = lcRet+CHR(IIF(BETWEEN(lnByte,0,255),lnByte,0))
 ENDFOR
 RETURN lcRet
ENDFUNC



FUNCTION GetClaves(tcLlave, tnClaveMul, tnClaveXor)
*#/----------------------------------------
* Función usada por Encripta y Desencripta
*#/----------------------------------------
 LOCAL lc, ln
 lc = ALLTRIM(LOWER(tcLlave))
 tnClaveMul = 31
 tnClaveXor = 3131
 DO WHILE NOT EMPTY(lc)
  tnClaveMul = BITXOR(tnClaveMul,ASC(lc))
  tnClaveXor = BITAND((tnClaveXor+1)*(ASC(lc)+1),0xFFFF)
  lc = IIF(LEN(lc) > 1,SUBS(lc,2),"")
 ENDDO
ENDFUNC



FUNCTION RegistraEstadoOt
PARAMETERS p_idot, p_idestado
*#/----------------------------------------
* Función que registra los estados en OtEstadosOt
* Parámetros:
*    p_idot - IdOT que se va a registrar el estado
*    p_idestado - IdEstado a registrar
* Retorno: True o False en caso que se registre correctamente o no
*#/----------------------------------------

	
	* me conecto a la base de datos
	vconeccion=abreycierracon(0,_SYSSCHEMA)	
	
	v_idestadoot	= maxnumeroidx("idotestadosot","I","otestadosot",1)
	v_idot 			= p_idot
	v_idestado 		= p_idestado
	v_fecha			= cftofc(DATE())

	p_tipoope     = 'I'
	p_condicion   = ''
	p_titulo      = " EL ALTA "
	p_tabla     = 'otestadosot'
	p_matriz    = 'lamatriz'



	p_conexion  = vconeccionF	

	
	DIMENSION lamatriz(4,2)
	
	lamatriz(1,1)='idotestadosot'
	lamatriz(1,2)= ALLTRIM(STR(v_idestadoot))
	lamatriz(2,1)='idot'
	lamatriz(2,2)= ALLTRIM(STR(v_idot))
	lamatriz(3,1)='idestado'
	lamatriz(3,2)=ALLTRIM(STR(v_idestado))
	lamatriz(4,1)='fecha'
	lamatriz(4,2)="'"+alltrim(v_fecha)+"'"
	
	
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(tmp_ejecumat.idotejem)),0+48+0,"Error")
	    * me desconecto	
		=abreycierracon(vconeccionF,"") 
		RETURN .F.
	ENDIF

	* me desconecto	
	=abreycierracon(vconeccionF,"") 
		
	RETURN .T.
ENDFUNC 


FUNCTION CANTIDADHORAS
PARAMETERS P_HORAD , P_HORAH
*#/----------------------------------------
* calcula la cantidad de horas entre una hora de inicio y una de finalizacion
* formato en el que debe recibir los parametros en tipo de datos caracter:
*		'AAAAMMDDHH:MM:SS'
* recibe dos parametros de igual formato : HORAINICIO Y HORAFIN
* 
* retorna la cantidad de horas minutos y segundo en formato caracter
* transcurridos desde la fecha/hora de inicio a la de fin
*		'HHHHHH:MM:SS'
*#/----------------------------------------

	vphorad = SUBSTR(ALLTRIM((STRTRAN(STRTRAN(p_horad,' ','0'),':',''))+'00000000000000'),1,14)
	vphorah = SUBSTR(ALLTRIM((STRTRAN(STRTRAN(p_horah,' ','0'),':',''))+'00000000000000'),1,14)

	IF VAL(SUBSTR(vphorad,9,2)) > 23  THEN 
		vphorad = SUBSTR(vphorad,1,8)+'00'+SUBSTR(vphorad,11)
	ENDIF 
	IF VAL(SUBSTR(vphorad,11,2)) > 60 THEN 
		vphorad = SUBSTR(vphorad,1,10)+'00'+SUBSTR(vphorad,13)
	ENDIF 
	IF VAL(SUBSTR(vphorad,13,2)) > 60 THEN 
		vphorad = SUBSTR(vphorad,1,12)+'00'
	ENDIF 
	
	IF VAL(SUBSTR(vphorah,9,2)) > 23 THEN 
		vphorah = SUBSTR(vphorah,1,8)+'00'+SUBSTR(vphorah,11)
	ENDIF 
	IF VAL(SUBSTR(vphorah,11,2)) > 60 THEN 
		vphorah = SUBSTR(vphorah,1,10)+'00'+SUBSTR(vphorah,13)
	ENDIF 
	IF VAL(SUBSTR(vphorah,13,2)) > 60 THEN 
		vphorah = SUBSTR(vphorah,1,12)+'00'
	ENDIF 
	
	

	vhorastot = (DATETIME(INT(VAL(SUBSTR(vphorah,1,4))), INT(VAL(SUBSTR(vphorah,5,2))), INT(VAL(SUBSTR(vphorah,7,2))) ,INT(VAL(SUBSTR(vphorah,9,2))) ,INT(VAL(SUBSTR(vphorah,11,2))), INT(VAL(SUBSTR(vphorah,13,2))))- ;
					DATETIME(INT(VAL(SUBSTR(vphorad,1,4))), INT(VAL(SUBSTR(vphorad,5,2))), INT(VAL(SUBSTR(vphorad,7,2))) ,INT(VAL(SUBSTR(vphorad,9,2))) ,INT(VAL(SUBSTR(vphorad,11,2))), INT(VAL(SUBSTR(vphorad,13,2)))) )/3600

	v_horast	= INT(vhorastot)
	v_minutost 	= INT((vhorastot - v_horast)*60)
	v_segundost	= (((vhorastot - v_horast)*60) - v_minutost)*60
	
	retorno = (STRTRAN((STR(v_horast,6))+':'+(STR(v_minutost,2))+':'+(STR(v_segundost,2)),' ','0'))
	RETURN retorno 
ENDFUNC 


FUNCTION SUMAHORAS
PARAMETERS P_HORA1 , P_HORA2
*#/----------------------------------------
* suma las horas que recibe como parametro HORA1 Y HORA2
* el formato en el que recibe es de tipo caracter
*		'HHHHHH:MM:SS'
* devuelve el valor acumulado de horas en el mismo formato
*#/----------------------------------------
	
	v_sig_h1= SUBSTR(ALLTRIM(p_hora1),1,1)
	v_sig_h2= SUBSTR(ALLTRIM(p_hora2),1,1)

	v_dop_1 = ATC(':',p_hora1,1)
	v_dop_2 = ATC(':',p_hora1,2)	
	vh1 = ('000000'+SUBSTR(p_hora1,1,(v_dop_1-1)))
	vh2 = ('00'+SUBSTR(p_hora1,v_dop_1+1,2))
	vh3 = ('00'+SUBSTR(p_hora1,v_dop_2+1,2))
	pa_hora1 = SUBSTR(vh1,LEN(vh1)-5)+":"+SUBSTR(vh2,LEN(vh2)-1)+":"+SUBSTR(vh3,LEN(vh3)-1)

	v_hora1 = ALLTRIM((STRTRAN(STRTRAN(STRTRAN(pa_hora1,'-','0'),' ','0'),':',''))+'0000000000')
	v_hora1 = SUBSTR(v_hora1,IIF(LEN(v_hora1)=20,1,2),10)


	v_dop_1 = ATC(':',p_hora2,1)
	v_dop_2 = ATC(':',p_hora2,2)	
	vh1 = ('000000'+SUBSTR(p_hora2,1,(v_dop_1-1)))
	vh2 = ('00'+SUBSTR(p_hora2,v_dop_1+1,2))
	vh3 = ('00'+SUBSTR(p_hora2,v_dop_2+1,2))
	pa_hora2 = SUBSTR(vh1,LEN(vh1)-5)+":"+SUBSTR(vh2,LEN(vh2)-1)+":"+SUBSTR(vh3,LEN(vh3)-1)

	v_hora2 = ALLTRIM((STRTRAN(STRTRAN(STRTRAN(pa_hora2,'-','0'),' ','0'),':',''))+'0000000000')
	v_hora2 = SUBSTR(v_hora2,IIF(LEN(v_hora2)=20,1,2),10)

	v_hora1_MS	= INT(VAL(SUBSTR(v_hora1,1,6)))*3600+INT(VAL(SUBSTR(v_hora1,7,2)))*60+INT(VAL(SUBSTR(v_hora1,9,2)))
    v_multi = IIF(v_sig_h1='-',-1,1)
	v_hora1_MS  = v_hora1_MS * v_multi
	v_hora2_MS	= INT(VAL(SUBSTR(v_hora2,1,6)))*3600+INT(VAL(SUBSTR(v_hora2,7,2)))*60+INT(VAL(SUBSTR(v_hora2,9,2)))
    v_multi = IIF(v_sig_h2='-',-1,1)
	v_hora2_MS  = v_hora2_MS * v_multi
	V_horat_MS	= (V_hora1_MS + v_hora2_MS)/3600

	
	V_sig_horat_MS = IIF(V_horat_MS>=0,'','-')

	
	V_horat_MS 		= ABS(V_horat_MS)
	v_horasMST		= INT(V_horat_MS)
	v_minutoMST 	= INT((V_horat_MS - v_horasMST)*60)
	v_segundMST		= (((V_horat_MS - v_horasMST)*60) - v_minutoMST )*60
	

	retorno = V_sig_horat_MS+(STRTRAN((STR(v_horasMST,6))+':'+(STR(v_minutoMST ,2))+':'+(STR(v_segundMST,2)),' ','0'))
	

*!*		v_hora1_MS	= INT(VAL(SUBSTR(v_hora1,1,4)))*3600+INT(VAL(SUBSTR(v_hora1,5,2)))*60+INT(VAL(SUBSTR(v_hora1,7,2)))
*!*	    v_multi = IIF(v_sig_h1='-',-1,1)
*!*		v_hora1_MS  = v_hora1_MS * v_multi
*!*		v_hora2_MS	= INT(VAL(SUBSTR(v_hora2,1,4)))*3600+INT(VAL(SUBSTR(v_hora2,5,2)))*60+INT(VAL(SUBSTR(v_hora2,7,2)))
*!*	    v_multi = IIF(v_sig_h2='-',-1,1)
*!*		v_hora2_MS  = v_hora2_MS * v_multi
*!*		V_horat_MS	= (V_hora1_MS + v_hora2_MS)/3600

*!*		
*!*		V_sig_horat_MS = IIF(V_horat_MS>=0,'','-')

*!*		
*!*		V_horat_MS 		= ABS(V_horat_MS)
*!*		v_horasMST		= INT(V_horat_MS)
*!*		v_minutoMST 	= INT((V_horat_MS - v_horasMST)*60)
*!*		v_segundMST		= (((V_horat_MS - v_horasMST)*60) - v_minutoMST )*60
*!*		

*!*		retorno = V_sig_horat_MS+(STRTRAN((STR(v_horasMST,4))+':'+(STR(v_minutoMST ,2))+':'+(STR(v_segundMST,2)),' ','0'))


	RETURN retorno 
ENDFUNC 




FUNCTION IPAddress
PARAMETERS pdato 
*#/----------------------------------------
* Parametro pdato
*		 = 1 devuelve la ip local del equipo
*		 = 2 devuelve Nombre del host
*#/----------------------------------------
v_error = .f.
ON ERROR v_error = .t.
oWS = CREATEOBJECT ("MSWinsock.Winsock")
ON ERROR 
IF !v_error THEN 
	DO CASE 
		CASE pdato = 1 
			retorno = oWS.LocalIP
		CASE pdato = 2
			retorno = oWS.LocalHostName
		
		OTHERWISE 
			retorno = ''
	ENDCASE 
ELSE

	ipadd = ""
	hostn = ID()
	
	v_error = .f.
	ON ERROR v_error = .t.
  	lowsock = CREATEOBJECTEX("{248DD896-BB45-11CF-9ABC-0080C7E7B78D}", "", "")
 	ON ERROR 
 	RELEASE lowsock
	IF !v_error THEN 
		ipadd = lowsock.LocalIP
*!*		v_error = .f.
*!*		ON ERROR v_error = .t.
*!*		oWMI = getobject("winmgmts:")
*!*		oAdapters = oWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration",,48)
*!*		ON ERROR 
*!*		MESSAGEBOX(v_error)

*!*			ipadd = ""
*!*			hostn = ""
*!*			MESSAGEBOX(TYPE("oAdapters"))
*!*			for each oAdapter in oAdapters
*!*				MESSAGEBOX(TYPE("oAdapter"))
*!*				if not isnull(oAdapter.ipaddress)
*!*					for each cAddress in oAdapter.ipaddress
*!*						IF ATC('.',cAddress)>0 AND EMPTY(ipadd) THEN 
*!*							ipadd = oAdapter.ipaddress
*!*							hostn  = oAdapter.DNSHostName
*!*						ENDIF 
*!*					NEXT 
*!*				endif
*!*			NEXT  
	
	ELSE
		
		DO CASE 
			CASE pdato = 1 
				retorno = ipadd
			CASE pdato = 2
				retorno = hostn
			OTHERWISE 
				retorno = ''
		ENDCASE 
*!*			RELEASE oWMI
*!*			retorno = ''
	ENDIF 
ENDIF 


RELEASE oWS
RETURN retorno

ENDFUNC 

*!*	[Dynamic, Provider("CIMWin32"), UUID("{8502C515-5FBB-11D2-AAC1-006008C78BC7}"), AMENDMENT]
*!*	class Win32_NetworkAdapterConfiguration : CIM_Setting
*!*	{
*!*	  string   Caption;
*!*	  string   Description;
*!*	  string   SettingID;
*!*	  boolean  ArpAlwaysSourceRoute;
*!*	  boolean  ArpUseEtherSNAP;
*!*	  string   DatabasePath;
*!*	  boolean  DeadGWDetectEnabled;
*!*	  string   DefaultIPGateway[];
*!*	  uint8    DefaultTOS;
*!*	  uint8    DefaultTTL;
*!*	  boolean  DHCPEnabled;
*!*	  datetime DHCPLeaseExpires;
*!*	  datetime DHCPLeaseObtained;
*!*	  string   DHCPServer;
*!*	  string   DNSDomain;
*!*	  string   DNSDomainSuffixSearchOrder[];
*!*	  boolean  DNSEnabledForWINSResolution;
*!*	  string   DNSHostName;
*!*	  string   DNSServerSearchOrder[];
*!*	  boolean  DomainDNSRegistrationEnabled;
*!*	  uint32   ForwardBufferMemory;
*!*	  boolean  FullDNSRegistrationEnabled;
*!*	  uint16   GatewayCostMetric[];
*!*	  uint8    IGMPLevel;
*!*	  uint32   Index;
*!*	  uint32   InterfaceIndex;
*!*	  string   IPAddress[];
*!*	  uint32   IPConnectionMetric;
*!*	  boolean  IPEnabled;
*!*	  boolean  IPFilterSecurityEnabled;
*!*	  boolean  IPPortSecurityEnabled;
*!*	  string   IPSecPermitIPProtocols[];
*!*	  string   IPSecPermitTCPPorts[];
*!*	  string   IPSecPermitUDPPorts[];
*!*	  string   IPSubnet[];
*!*	  boolean  IPUseZeroBroadcast;
*!*	  string   IPXAddress;
*!*	  boolean  IPXEnabled;
*!*	  uint32   IPXFrameType[];
*!*	  uint32   IPXMediaType;
*!*	  string   IPXNetworkNumber[];
*!*	  string   IPXVirtualNetNumber;
*!*	  uint32   KeepAliveInterval;
*!*	  uint32   KeepAliveTime;
*!*	  string   MACAddress;
*!*	  uint32   MTU;
*!*	  uint32   NumForwardPackets;
*!*	  boolean  PMTUBHDetectEnabled;
*!*	  boolean  PMTUDiscoveryEnabled;
*!*	  string   ServiceName;
*!*	  uint32   TcpipNetbiosOptions;
*!*	  uint32   TcpMaxConnectRetransmissions;
*!*	  uint32   TcpMaxDataRetransmissions;
*!*	  uint32   TcpNumConnections;
*!*	  boolean  TcpUseRFC1122UrgentPointer;
*!*	  uint16   TcpWindowSize;
*!*	  boolean  WINSEnableLMHostsLookup;
*!*	  string   WINSHostLookupFile;
*!*	  string   WINSPrimaryServer;
*!*	  string   WINSScopeID;
*!*	  string   WINSSecondaryServer;
*!*	}




FUNCTION obtienegrupo
PARAMETERS par_idtipogrupo, par_idgrupo , par_alias
*#/----------------------------------------
*** FUNCION PARA LA OBTENCION DE UNA TABLA O CURSOR CON TODOS LOS ELEMENTOS 
*** DE UN GRUPO , EN LA TABLA SE MARCAN TODOS LOS ELEMENTOS QUE PERTENECEN AL GRUPO
*** Y TODOS AQUELLOS QUE ESTÁN FUERA DEL MISMO A TRAVEZ DEL CAMPO pertenece
*** campos devueltos en la tabla
*** 		miembros c 	
*** 		idmiembro c o i
***			pertenece = 'S' o 'N'
***			idgrupo i
***			nombreg char(100)
***			tabla char(50)
***			campo char(50)
*#/----------------------------------------

		vconeccionF=abreycierracon(0,_SYSSCHEMA)	

		IF par_idgrupo > 0 THEN 		
				sqlmatriz(1)=" Select g.idgrupo, g.idtipogrupo, g.nombre as nombreg, "
				sqlmatriz(2)=" t.detalle as nombretipo, t.tabla, t.campo, t.tipoc, " 
				sqlmatriz(3)=" c.campo as campoc, c.tipoc as tipocc, c.orden  "
				sqlmatriz(4)=" from campogrupo c left join tipogrupos t on t.idtipogrupo = c.idtipogrupo "
				sqlmatriz(5)=" left join grupos g on g.idtipogrupo = t.idtipogrupo " 
				sqlmatriz(6)=" where g.idgrupo= "+ ALLTRIM(STR(par_idgrupo))+" order by c.orden"
		ELSE
				sqlmatriz(1)=" Select 0 as idgrupo, c.idtipogrupo, '  ' as nombreg, "
				sqlmatriz(2)=" t.detalle as nombretipo, t.tabla, t.campo, t.tipoc, " 
				sqlmatriz(3)=" c.campo as campoc, c.tipoc as tipocc, c.orden  "
				sqlmatriz(4)=" from campogrupo c left join tipogrupos t on t.idtipogrupo = c.idtipogrupo "
				sqlmatriz(6)=" where c.idtipogrupo= "+ ALLTRIM(STR(par_idtipogrupo))+" order by c.orden "
		ENDIF 
		verror=sqlrun(vconeccionF,"grupotipocampo_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la union de tablas de grupos... ",0+48+0,"Error")
		    RETURN 
		ENDIF

		SELECT grupotipocampo_sql
		GO TOP 
		IF EOF()
			MESSAGEBOX("No se puede generar una lista del Grupo Seleccionado...")
			RETURN ""
		ENDIF
		sqlmatriz(1)=" select TRIM(SUBSTR( concat_ws('  '" 
		sqlmatriz(3)= ", SPACE(200)),1,200 )) as miembros , "+ALLTRIM(grupotipocampo_sql.campo)+" as idmiembro, 'N' as pertenece from "+ALLTRIM(grupotipocampo_sql.tabla)+" "
		
		DO WHILE !EOF()
			sqlmatriz(2)= sqlmatriz(2)+","+ALLTRIM(grupotipocampo_sql.campoc)		
			SKIP 
		ENDDO 		
				
		verror=sqlrun(vconeccionF,"miembrosgru_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un en la busqueda de miembros del grupo... ",0+48+0,"Error")
		    RETURN 
		ENDIF
		
		SELECT grupotipocampo_sql
		GO TOP  

		
		SELECT * FROM miembrosgru_sql INTO TABLE .\&par_alias

		
		ALTER table &par_alias ALTER COLUMN  miembros c(200)
		ALTER table &par_alias add idgrupo i
		ALTER table &par_alias add nombreg char(100)
		ALTER table &par_alias add tabla char(50)
		ALTER table &par_alias add campo char(50)
		ALTER table &par_alias ADD tipoc char(1)
		ALTER table &par_alias ADD idtipogrup i
		ALTER table &par_alias ADD nombretipo char(100)
		UPDATE &par_alias SET idgrupo = IIF(TYPE("grupotipocampo_sql.idgrupo")='C',0,grupotipocampo_sql.idgrupo), nombreg = grupotipocampo_sql.nombreg, tabla = grupotipocampo_sql.tabla, ;
				campo = grupotipocampo_sql.campo, tipoc = grupotipocampo_sql.tipoc, idtipogrup = grupotipocampo_sql.idtipogrupo, nombretipo = grupotipocampo_sql.nombretipo

		sqlmatriz(1)=" select * from grupoobjeto where idgrupo = "+ ALLTRIM(STR(par_idgrupo)) 
		verror=sqlrun(vconeccionF,"grupoobjeto_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un en la busqueda de miembros del grupo... ",0+48+0,"Error")
		    RETURN 
		ENDIF

		SELECT grupoobjeto_sql 
		GO TOP 
		IF !EOF() THEN 
			UPDATE &par_alias SET pertenece = 'S' WHERE ;
				SUBSTR((IIF(tipoc='C',ALLTRIM(idmiembro),alltrim(str(idmiembro)))+REPLICATE('#',20)),1,20) in (select SUBSTR((ALLTRIM(idmiembro)+REPLICATE('#',20)),1,20) from grupoobjeto_sql) 
		ENDIF 

		=abreycierracon(vconeccionF,"")	
		
		USE IN miembrosgru_sql
		USE IN grupotipocampo_sql 
		p_alias = par_alias
		RETURN p_alias 
ENDFUNC 





FUNCTION getIdTabla
PARAMETERS p_nomTabla
*#/----------------------------------------
* Función que retorna el nombre del campo clave de la tabla pasada como parámetro
* Parámetros:
*    p_nomTabla: nombre de la tabla
* Retorno: Retorna el nombre del campo clave de la tabla. vacio en caso de no encotrarlo
*#/----------------------------------------

v_campoPK = ""
vconeccionFdb = abreycierracon(0,_SYSSCHEMA)

sqlmatriz(1)="SHOW TABLES FROM "+_SYSSCHEMA +" where Tables_in_"+_SYSSCHEMA+ "= '"+ALLTRIM(p_nomTabla)+"'"
verror=sqlrun(vconeccionFdb ,"tablaDb_sql")
IF verror=.f.
	MESSAGEBOX("No se puede obtener la Tabla de "+_SYSSCHEMA,0+16,"Advertencia")
	* me desconecto	
	=abreycierracon(vconeccionFdb ,"")
	RETURN  v_campoPK 
ENDIF 

eje=" SELECT Tables_in_"+_SYSSCHEMA+" as tablanom from tablaDb_sql INTO TABLE .\tabladb"
&eje 

USE IN tablaDb_sql

SELECT tabladb
GO TOP 

	
IF !EOF()
*!*		eje = "v_tabla = ALLTRIM(tablas.Tables_in_"+_SYSSCHEMA+")"
	v_tabla = ALLTRIM(tabladb.tablanom)
	
	
	sqlmatriz(1)="SHOW COLUMNS FROM "+v_tabla
	verror=sqlrun(vconeccionFdb ,"columnasdb_sql")
	IF verror=.f.
		MESSAGEBOX("No se puede obtener los Tipos de Comprobantes",0+16,"Advertencia")
			* me desconecto	
		=abreycierracon(vconeccionFdb ,"")
		RETURN  v_campoPK 
	ENDIF 
	SELECT columnasdb_sql
	
	
	SELECT  * FROM columnasdb_sql WHERE key = 'PRI' INTO TABLE .\columnaPKdb
	
	SELECT columnaPKdb
	GO TOP 
	ALTER table columnaPKdb ALTER COLUMN type c(100)
	ALTER table columnaPKdb alter COLUMN DEFAULT c(100)
	
	
	IF NOT EOF()
		v_campoPK = columnaPKdb.field
		
	ELSE
	
		v_campoPK = ""
	ENDIF 
	
  
	
	
ENDIF 

* me desconecto	
=abreycierracon(vconeccionFdb ,"")

RETURN v_campoPK

ENDFUNC 


FUNCTION ATCF 
PARAMETERS c_buscado, c_buscaren
*#/----------------------------------------
** SEPARA CARACTERES BUSCADOS Y RETORNA VERDADERO O FALSO 0 O 1
*#/----------------------------------------

IF !EMPTY(c_buscado) then 
	vfiltra01 = 0
	c_buscado 	= UPPER(c_buscado)
	c_buscaren 	= UPPER(c_buscaren)
	
	ALINES(cbuscadoarr,c_buscado,16,"&","#",")","(")
	aelementos = ALEN(cbuscadoarr)

*!*		FOR i= 1 TO aelementos
*!*			MESSAGEBOX(ALLTRIM(cbuscadoarr(i)))
*!*		ENDFOR 

	DIMENSION cbuscadof (aelementos,2)
	FOR i= 1 TO aelementos
*!*			cbuscadof(i,2) = IIF(ATC("#",ALLTRIM(cbuscadoarr(i)))>0,'+',IIF(ATC("&",ALLTRIM(cbuscadoarr(i)))>0,'*','+'))
*!*			cbuscadoarr(i)=STRTRAN(STRTRAN(cbuscadoarr(i),'#',""),"&","")
			cbuscadof(i,2) = IIF(ATC("#",ALLTRIM(cbuscadoarr(i)))>0,'+',IIF(ATC("&",ALLTRIM(cbuscadoarr(i)))>0,'*',IIF(ATC("(",ALLTRIM(cbuscadoarr(i)))>0,'(',IIF(ATC(")",ALLTRIM(cbuscadoarr(i)))>0,')','+'))))
			cbuscadoarr(i)=STRTRAN(STRTRAN(STRTRAN(STRTRAN(cbuscadoarr(i),'#',""),"&",""),"(",""),")","")
	ENDFOR 

	FOR i=1 TO aelementos
		IF !EMPTY(ALLTRIM(cbuscadoarr(i))) THEN 	
			vfiltra001 = IIF(ATC(ALLTRIM(cbuscadoarr(i)),c_buscaren)>0,'1','0')
			cbuscadof(i,1)=vfiltra001
		ELSE
			vfiltra001 = ""
			cbuscadof(i,1)=vfiltra001		
		ENDIF 
	ENDFOR 
	vformula = ""
	FOR i=1 TO aelementos
		vformula = vformula+cbuscadof(i,1)+cbuscadof(i,2)
	ENDFOR 
	vformula = STRTRAN(STRTRAN(STRTRAN(STRTRAN(STRTRAN(vformula,'**','*'),'+*','+'),'*+','+'),'(*(','(('),')*)','))')
	vformula = vformula +'+0'  
*!*		MESSAGEBOX(vformula)
	ON ERROR vfiltra01 = 1
	vfiltra01 = &vformula
	ON ERROR 
	RELEASE cbuscadoarr , cbuscadof
	RETURN vfiltra01
ELSE	
	RETURN 1
ENDIF 
ENDFUNC 





FUNCTION fselectreporte 
PARAMETERS pvar_paramrepo, pvar_tablarepo
*#/----------------------------------------
* FUNCION DE BUSQUEDA DE REPORTES Y SELECCION DE ACUERDO AL PARAMETRO APLICADO.
*#/----------------------------------------
	****************************************
	v_paramRepo = pvar_paramrepo
	pvar_retorno = ""

	v_itera = 0

	DO WHILE v_itera <= 1 && controlo las veces que consulto por un reporte

		vconeccion=abreycierracon(0,_SYSSCHEMA)	
		IF TYPE("v_paramRepo") = "N"
			*** Si el parametro es un NUMERO, el nùmero es el idComproba


			sqlmatriz(1)="select r.idreporte, r.nombre, r.descripcion as descrip, co.predeterminado as predet, r.copias from comprorepo co "
			sqlmatriz(2)=" left join reportesimp r on co.idreporte = r.idreporte "
			sqlmatriz(3)=" where co.predeterminado = 'S' and co.idcomproba = "+ALLTRIM(STR(v_paramRepo))
			verror=sqlrun(vconeccion,"repos_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Entidades ",0+48+0,"Error")
			    RETURN pvar_retorno
			ENDIF 
			
		ELSE
			IF TYPE("v_paramRepo") = "C"
			*** Si el paràmetro es un CARACTER, se corresponde con el nombre del formulario y metodo

				sqlmatriz(1)="select r.idreporte, r.nombre, r.descripcion as descrip, co.predeterminado as predet, r.copias from comprorepo co "
				sqlmatriz(2)=" left join reportesimp r on co.idreporte = r.idreporte "
				sqlmatriz(3)=" where  co.predeterminado = 'S' and co.codigoImpre= '"+ALLTRIM(LOWER(v_paramRepo))+"'"
				
				verror=sqlrun(vconeccion,"repos_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Reportes ",0+48+0,"Error")
	  				vconeccion=abreycierracon(vconeccion,"")	
	  		    	RETURN pvar_retorno
				ENDIF 
			ELSE
	*!*				MESSAGEBOX("No existe un tipo de reporte para el parametro",0+48+0,"Error al obtener el nombre del reporte")
			    	vconeccion=abreycierracon(vconeccion,"")	
					RETURN pvar_retorno

			ENDIF 
		ENDIF 
		vconeccion=abreycierracon(vconeccion,"")	
		
	****************************************
		SELECT repos_sql
		GO TOP 
		IF  EOF() THEN 
			IF MESSAGEBOX("NO EXISTE REPORTE ASIGNADO   "+CHR(13)+CHR(13)+"Seleccione Un Reporte para Asignar..."+CHR(13)+CHR(13)+ ;
			"-- CLAVE:  "+LOWER(ALLTRIM(IIF(TYPE('v_paramRepo')='C',v_paramRepo,STR(v_paramRepo))))+" --" +CHR(13)+  ;
			"-- TABLA:  "+LOWER(pvar_tablarepo)+" --"+CHR(13)+CHR(13)+ ;
			"Desea Seleccionar Un Reporte ? " ;
			,4+48+0,"Error al obtener el nombre del reporte") = 6 THEN 
				
				** Aqui LLamo a la funcion de Carga de Reportes para cargar uno nuevo 
				** Si lo Ingresa continuo sino retorno	
				v_cargarepo = 0 
				v_cargarepo = CargaReporte(v_paramRepo)
				
				IF v_cargarepo = 0 THEN 
					USE IN repos_sql 
					RETURN pvar_retorno
				ELSE 
					v_itera = v_itera + 1
				ENDIF 
			ELSE 
				v_itera = 2
			ENDIF 	
		ELSE 
			v_itera = 2
		ENDIF 
	ENDDO 
	
****************************************
	SELECT repos_sql
	GO TOP 
	IF  EOF()
			
		RETURN pvar_retorno
	ELSE
		v_cantRegistros = RECCOUNT()

		IF v_cantRegistros = 1

			 *** No tiene que seleccionar reportes, imprime con el que tiene predeterminado
			pvar_retorno = ALLTRIM(STR(repos_sql.idreporte))+";" + ALLTRIM(repos_sql.nombre) + ";" + ALLTRIM(repos_sql.copias)+ ";"
			
		ELSE
			IF v_cantRegistros > 1
				DO FORM selectreporte WITH v_paramRepo TO  pvar_retorno					

			ELSE
				MESSAGEBOX("No existe un tipo de reporte para el parametro",0+48+0,"Error al obtener el nombre del reporte")
			ENDIF 
		ENDIF 
		SELECT repos_sql
		USE IN repos_sql 
	ENDIF 
	
	RETURN 	pvar_retorno 
ENDFUNC 



FUNCTION CargaReporte
PARAMETERS pr_claverepo
*#/----------------------------------------
* Incerta un Reporte en la tabla reportesimp y agrega una relacion en comprorepo
* Se utiliza cuando no existe el reporte que el usuario quiere incertar
* retorna el idreporte si lo pudo insertar, sino devuelve 0
*#/----------------------------------------

	** Primero pido e incerto el reporte en la tabla reportesimp **
	** cargo el reporte si no existe ** 
	** si existe solo voy a asociar la nueva clave al reporte existente **
	v_idcomproreret = 0
	v_idreporteins = 0 

	v_defa = SYS(5)+'\' 
	SET DEFAULT TO &v_defa

	v_reportepath = ALLTRIM(GETFILE("rpt","Reporte","Seleccionar",0,"Reportes Sistema"))

	IF EMPTY(v_reportepath) THEN 
		SET DEFAULT TO &_SYSESTACION 
		RETURN v_idcomproreret 
	ENDIF 
	IF !FILE(v_reportepath) THEN 
		MESSAGEBOX("El archivo Seleccionado no es Válido o no Existe ",0+16,"Advertencia")
		SET DEFAULT TO &_SYSESTACION 
		RETURN v_idcomproreret 
	ENDIF 

	v_nombrerepo = STRTRAN(LOWER(JUSTFNAME(v_reportepath)),' ','_')
	v_pathrepo	= JUSTPATH(v_reportepath)
	SET DEFAULT TO &_SYSESTACION 

	vconeccionF=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="Select idreportea, idreporte, nombre from reportesimp where nombre='"+v_nombrerepo+"'"  
	verror=sqlrun(vconeccionF,"existerepo_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Tipos de Comprobantes ",0+48+0,"Error")
	ENDIF 
	SELECT existerepo_sql 
	IF EOF() THEN 

		ADIR (arrayreportes,v_reportepath)
		v_fechahora = DTOS(arrayreportes(1,3))+'-'+ALLTRIM(arrayreportes(1,4))
		v_tamanio	= arrayreportes(1,2)
		IF !EMPTY(v_reportepath) THEN 
			v_reporte_ins = STRCONV(FILETOSTR(v_reportepath),13)
		ELSE
			v_reporte_ins = ""
		ENDIF 

		sqlmatriz(1)="Select MAX(idreportea) as maxidra, MAX(idreporte) as maxidr from reportesimp "  
		verror=sqlrun(vconeccionF,"maximosid_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Tipos de Comprobantes ",0+48+0,"Error")
		ENDIF 
		max_idreporte  = maximosid_sql.maxidr + 1
		max_idreportea = maximosid_sql.maxidra + 1
		USE IN maximosid_sql 
		
		verror=SQLEXEC(vconeccionF," insert into reportesimp (idreportea, idreporte, nombre, descripcion, fechahora, tamanio, reporte,copias ) "+ ;
									" values ("+alltrim(STR(max_idreportea))+","+alltrim(str(max_idreporte))+",'"+alltrim(v_nombrerepo)+"',"+"'','"+alltrim(v_fechahora)+"',"+alltrim(STR(v_tamanio))+",'"+v_reporte_ins+"','')" ;
									,"reporte_in")
		IF verror < 0
			MESSAGEBOX("No se puede incertar el reporte Seleccionado ",0+16,"Advertencia")
			SET DEFAULT TO &_SYSESTACION 
			=abreycierracon(vconeccionF,"")	
			RETURN v_idcomproreret 
		ENDIF 

		v_idreporteins = max_idreporte
				
	ELSE && el reporte ya existe, solo recupero el idreporte
		v_idreporteins = existerepo_sql.idreporte 
	ENDIF 
	USE IN existerepo_sql	

	**********************************************************************
	**********************************************************************
	** Si tengo idreporte para insertar creo el registro con la clave asociada
	** al idreporte obtenida
	**********************************************************************

	IF v_idreporteins > 0 THEN 

		IF TYPE("pr_claverepo")='C' THEN 
			v_idcomproba = 0	
			v_codigoimpre = LOWER(ALLTRIM(pr_claverepo))
		ELSE
			v_idcomproba = pr_claverepo	
			v_codigoimpre = ""
		ENDIF 
		v_idreporte  = v_idreporteins 
		v_predeterminado = 'S'

		DIMENSION lamatriz(5,2)

		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		lamatriz(1,1) = 'idcomprore'
		lamatriz(1,2) = '0'
		lamatriz(2,1) = 'idcomproba'
		lamatriz(2,2) = ALLTRIM(STR(v_idcomproba))
		lamatriz(3,1) = 'codigoimpre'
		lamatriz(3,2) = "'"+ALLTRIM(v_codigoimpre)+"'"
		lamatriz(4,1) = 'idreporte'
		lamatriz(4,2) = ALLTRIM(STR(v_idreporte))
		lamatriz(5,1) = 'predeterminado'
		lamatriz(5,2) = "'S'"

		p_tabla     = 'comprorepo'
		p_matriz    = 'lamatriz'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" del Comprobante y Reporte ",0+48+0,"Error")
		ENDIF 

		sqlmatriz(1)=" select last_insert_id() as maxid "
		verror=sqlrun(vconeccionF,"ultimoId")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
			=abreycierracon(vconeccionF,"")	
		    RETURN v_idcomproreret
		ENDIF 
		SELECT ultimoId
		GO TOP 
		v_idcompro_Ultimo = VAL(ultimoId.maxid)
		USE IN ultimoId

		v_idcomproreret = v_idcompro_Ultimo
		
	ENDIF 

	=abreycierracon(vconeccionF,"")	

	RETURN v_idcomproreret 

ENDFUNC 


FUNCTION obtieneallgrupos
PARAMETERS  para_aliasd
*#/----------------------------------------
*** FUNCION PARA LA OBTENCION DE UNA TABLA O CURSOR CON TODOS LOS ELEMENTOS 
*** LOS GRUPOS DEL SISTEMA Y SUS COMPONENTES
*** campos devueltos en la tabla
*** 		miembros c 	
*** 		idmiembro c
***			pertenece = 'S' o 'N'
***			idgrupo i
***			nombreg char(100)
***			tabla char(50)
***			campo char(50)
***			tipoc char(1)
***			idtipogrup i
***			nombretipo c(100)
***			codarbol c(20)
***			tiporeg c(1) 'M'=Miembro, 'G'=Grupo 'T'=Tipo Grupo
*#/----------------------------------------

	
	p_aliasreto  = ""

	vconeccionF=abreycierracon(0,_SYSSCHEMA)	


	sqlmatriz(1)=" Select * from r_gruposall "
	verror=sqlrun(vconeccionF,"r_gruposall_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error busqueda de r_gruposall_sql ... ",0+48+0,"Error")
	    RETURN p_aliasreto  
	ENDIF
	SELECT r_gruposall_sql
	
	IF !EOF() THEN

		=abreycierracon(vconeccionF,"")	
		SELECT * FROM r_gruposall_sql INTO TABLE .\&para_aliasd
		USE IN r_gruposall_sql
	ELSE  

		sqlmatriz(1)=" Select g.idgrupo, g.idtipogrupo, g.nombre as nombreg, "
		sqlmatriz(2)=" t.detalle as nombretipo, t.tabla, t.campo, t.tipoc " 
		sqlmatriz(3)=" from grupos g left join tipogrupos t on t.idtipogrupo = g.idtipogrupo "
		sqlmatriz(4)=" order by g.idtipogrupo, g.idgrupo "

		verror=sqlrun(vconeccionF,"gruposall_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la union de tablas de grupos... ",0+48+0,"Error")
		    RETURN p_aliasreto  
		ENDIF
		=abreycierracon(vconeccionF,"")	

		SELECT gruposall_sql
		GO TOP 
		IF EOF()

			RETURN p_aliasreto  
		ENDIF
		v_nomtabla = "grupotmp0"
		DO WHILE !EOF()
			=obtienegrupo(gruposall_sql.idtipogrupo,gruposall_sql.idgrupo,"grupotmp")
			SELECT miembros, SUBSTR((IIF(tipoc='C',ALLTRIM(idmiembro),alltrim(str(idmiembro)))+REPLICATE(' ',20)),1,20) as idmiembro , ;
					 idgrupo, nombreg, tabla, campo, tipoc, idtipogrup, nombretipo, 'M' as tiporeg FROM grupotmp ;
				INTO TABLE .\&v_nomtabla WHERE pertenece = 'S'
			IF v_nomtabla = "grupotmp0" THEN 
				v_nomtabla = "grupotmp1"
			ELSE
				SELECT grupotmp0
				APPEND FROM .\grupotmp1
			ENDIF 	
			SELECT gruposall_sql
			skip
		ENDDO 
		SELECT grupotmp0
		ALTER table grupotmp0 ADD codarbol c(20)
		ALTER table grupotmp0 ADD codpadre c(20)
		GO TOP 
		replace ALL codarbol WITH SUBSTR(ALLTRIM(STR((idtipogrup+1000),4)),2,3)+SUBSTR(ALLTRIM(STR((idgrupo+1000),4)),2,3)+ ;
									ALLTRIM(REPLICATE('0',(14-LEN(ALLTRIM(idmiembro))))+ALLTRIM(idmiembro)), ;
					codpadre WITH SUBSTR(ALLTRIM(STR((idtipogrup+1000),4)),2,3)+SUBSTR(ALLTRIM(STR((idgrupo+1000),4)),2,3)
		
		SET ENGINEBEHAVIOR 70 
		
		SELECT * FROM grupotmp0 INTO TABLE .\grupotmpgru GROUP BY idgrupo
		replace ALL codarbol WITH SUBSTR(ALLTRIM(STR((idtipogrup+1000),4)),2,3)+SUBSTR(ALLTRIM(STR((idgrupo+1000),4)),2,3), ;
					codpadre WITH SUBSTR(ALLTRIM(STR((idtipogrup+1000),4)),2,3), ;
					miembros WITH SUBSTR(ALLTRIM(STR((idgrupo+1000),4)),2,3)+" - "+ALLTRIM(nombreg), idmiembro WITH "", tiporeg WITH "G"
		
		SELECT * FROM grupotmp0 INTO TABLE .\grupotmptip GROUP BY idtipogrup
		replace ALL codarbol WITH SUBSTR(ALLTRIM(STR((idtipogrup+1000),4)),2,3), ;
					codpadre WITH "0_" , ;
					miembros WITH SUBSTR(ALLTRIM(STR((idtipogrup+1000),4)),2,3)+" - "+ALLTRIM(nombretipo), idmiembro WITH "", idgrupo with 0 , nombreg with "", tiporeg WITH "T"
		SET ENGINEBEHAVIOR 90 
					
		SELECT grupotmp0
		APPEND FROM .\grupotmpgru
		APPEND FROM .\grupotmptip
		
		SELECT * FROM grupotmp0 INTO TABLE .\&para_aliasd


		USE IN grupotmp0
		IF USED("grupotmp1") THEN 
			USE IN grupotmp1
		ENDIF 
		USE IN gruposall_sql 
		
		=ActualizaGruposR("grupotmp0")
	ENDIF 
	
	p_aliasreto  = para_aliasd
	RETURN p_aliasreto  
ENDFUNC 



FUNCTION settoolbargrupo
PARAMETERS var_perfil
v_toolperfil = var_perfil

RELEASE toolbargrupos
PUBLIC  toolbargrupos
toolbargrupos= CREATEOBJECT('toolbargrupos')
toolbargrupos.hide 
*!*	toolbargrupos.enabled = .t.
toolbargrupos.tag = var_perfil

ENDFUNC 




FUNCTION registrarEstado
PARAMETERS p_nomTabla,p_nomCampo,p_indice,p_tipoInd,p_estado
*#/----------------------------------------
* Función que registra el estado según los parámetros pasados en la tabla estadosreg
* Parámetros:
*   p_nomTabla: nombre de la tabla
*	p_nomCampo: nombre del campo indice de la tabla
*	p_indice: valor del campo indice
*	p_tipoInd: tipo de valor del campo indice
*	p_estado: estado que se va a registrar, el estado debe estar en la tabla estadosr
**
* Retorno:
*	True: si no se produjeron errores, False en otro caso
*#/----------------------------------------

	estObj	= CREATEOBJECT('estadosclass')
	
	
	* me conecto a la base de datos
	vconeccionE=abreycierracon(0,_SYSSCHEMA)	
	
	v_idestadosreg	= maxnumeroidx("idestadosreg","I","estadosreg",1)
	v_nomTabla 		= p_nomTabla
	v_nomCampo 		= p_nomCampo
	
	v_idEst			= estObj.getIdEstado(p_estado)
	v_tipoInd		= p_tipoInd
	v_indice		= ""
	IF v_tipoInd = 'I'
		v_indice		= ALLTRIM(STR(p_indice))
	ELSE
		IF v_tipoInd = 'C'
			v_indice	= ALLTRIM(p_indice)
		ENDIF 
	ENDIF 
	v_fecha			= cftofc(DATE())+TIME()

	p_tipoope     = 'I'
	p_condicion   = ''
	p_titulo      = " EL ALTA "
	p_tabla     = 'estadosreg'
	p_matriz    = 'lamatriz'



	p_conexion  = vconeccionE	

	
	DIMENSION lamatriz(7,2)
	
	lamatriz(1,1)='idestadosreg'
	lamatriz(1,2)= ALLTRIM(STR(v_idestadosreg))
	lamatriz(2,1)='tabla'
	lamatriz(2,2)= "'"+ALLTRIM(v_nomTabla)+"'"
	lamatriz(3,1)='campo'
	lamatriz(3,2)="'"+ALLTRIM(v_nomCampo)+"'"
	lamatriz(4,1)='id'
	lamatriz(4,2)="'"+ALLTRIM(v_indice)+"'"
	lamatriz(5,1)='idestador'
	lamatriz(5,2)=ALLTRIM(STR(v_idEst))
	lamatriz(6,1)='tipo'
	lamatriz(6,2)="'"+ALLTRIM(v_tipoInd)+"'"
	lamatriz(7,1)='fecha'
	lamatriz(7,2)="'"+alltrim(v_fecha)+"'"
	
	
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error al registrar el estado ",0+48+0,"Error")
	    * me desconecto	
		=abreycierracon(vconeccionE,"") 
		RETURN .F.
		
	ENDIF

	IF p_estado = 'ANULADO' THEN 

		DO CASE  
			CASE lower(v_nomTabla) == 'facturas'
				sqlmatriz(1)= "delete from cobros where idfactura = "+alltrim(v_indice)
				
			CASE lower(v_nomTabla) == 'recibos'
				sqlmatriz(1)= "delete from cobros where idregipago = "+alltrim(v_indice)+" and idcomproba in ( select idcomproba from comprobantes where tabla='recibos')"
		
			CASE lower(v_nomTabla) == 'factuprove'
				sqlmatriz(1)= "delete from pagosprovfc where idfactprove = "+alltrim(v_indice)
				
			CASE lower(v_nomTabla) == 'pagosprov'			
				sqlmatriz(1)= "delete from pagosprovfc where idpago = "+alltrim(v_indice)+" and idcomproba in ( select idcomproba from comprobantes where tabla='pagosprov')"
		OTHERWISE
				sqlmatriz(1)=""
		ENDCASE 	
		IF !EMPTY(ALLTRIM(sqlmatriz(1))) THEN 
			verror=sqlrun(vconeccionF,"borra_rel")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en Eliminacion de Registros de Tablas... ",0+48+0,"Error")
			    RETURN p_aliasreto  
			ENDIF		
		ENDIF 
	ENDIF 


	* me desconecto	
	=abreycierracon(vconeccionE,"") 
	RETURN .T.
ENDFUNC 




FUNCTION generabusquedag
	PARAMETERS para_tabla, para_string
*#/----------------------------------------
** AGREGA EL CAMPO busquedag para poder realizar busquedas y filtrados con el objeto de grupos
*#/----------------------------------------
	SELECT &para_tabla
	IF EMPTY(FIELD("busquedag")) THEN 
		ALTER table &para_tabla ADD COLUMN busquedag c(254)
	ENDIF 
	replace ALL busquedag WITH &para_string
	GO TOP 
RETURN 



FUNCTION filtragrupos
	PARAMETERS pf_tbbuscador, pf_tablas, pf_extras
*#/----------------------------------------
* Filtrado de grupos en tablas Locales, recibe como parametro una tabla local 
*  y aplica el filtro de grupo a las tablas si está seleccionada la opcion de filtrados
*  en el objeto de grupos
*#/----------------------------------------

	IF TYPE("pf_extras")='C' THEN 
		IF !EMPTY(ALLTRIM(pf_extras)) THEN	
			EJE4 = pf_extras
		ELSE
			EJE4= ""	
		ENDIF 		
	ELSE 
		EJE4=""
	ENDIF 

*	SELECT &pf_tablas
	
	IF !EMPTY(ALLTRIM(pf_tbbuscador)) THEN	
		EJE1 = "ATCF(ALLTRIM('"+ALLTRIM(pf_tbbuscador)+"'), busqueda) > 0 "
	ELSE
		EJE1= ""	
	ENDIF 

	IF !EMPTY(ALLTRIM(toolbargrupos.seleccion)) AND toolbargrupos.pageayuda.grupos.filtragrupos.value THEN	
		EJE2 = "ATCF(ALLTRIM(busquedag), toolbargrupos.seleccion) > 0 "
	ELSE
		EJE2= ""	
	ENDIF 
	
	IF !EMPTY(EJE1) AND !EMPTY(EJE2) THEN 
		EJE3="SET FILTER TO "+EJE1+" AND "+EJE2
	ELSE
		EJE3="SET FILTER TO "+EJE1+EJE2
	ENDIF 
	
	
	IF !EMPTY(EJE1+EJE2) AND !EMPTY(EJE4) THEN 
		EJE3 = EJE3+" AND "+EJE4
	ELSE
		EJE3 = EJE3+EJE4
	ENDIF 


	vcan_tablas=alines( arraytablas, pf_tablas, ";")
	IF vcan_tablas > 0 THEN 
		FOR _ifg = 1 TO vcan_tablas
			SELECT &arraytablas(_ifg)
			&EJE3 
			GO TOP	
		ENDFOR 
	ENDIF 
	RELEASE arraytablas 
	
	RETURN EJE3
	
ENDFUNC 




FUNCTION showhidetoolbargrupo
*#/----------------------------------------
* Oculta o muestra la tabla de seleccion de grupos del sistema
*#/----------------------------------------
	IF toolbargrupos.visible THEN 
		toolbargrupos.hide
		toolbargrupos.pageayuda.grupos.filtragrupos.value = .f.
	ELSE 
		toolbargrupos.show 	
		toolbargrupos.pageayuda.grupos.filtragrupos.value = .t.
	ENDIF 
ENDFUNC 




FUNCTION obtenerEstado 
PARAMETERS p_nomTabla,p_nomCampo,p_indice,p_tipoInd
*#/----------------------------------------
* Función que retorna el IdEstadoR del último estado según los parámetros pasados en la tabla estadosreg
* Parámetros:
*   p_nomTabla: nombre de la tabla
*	p_nomCampo: nombre del campo indice de la tabla
*	p_indice: valor del campo indice
*	p_tipoInd: tipo de valor del campo indice
**
* Retorno:
*	True: si no se produjeron errores, False en otro caso
*#/----------------------------------------

	v_indice = ""
	IF p_tipoInd = 'I'
		v_indice		= ALLTRIM(STR(p_indice))
	ELSE
		IF p_tipoInd = 'C'
			v_indice	= ALLTRIM(p_indice)
		ENDIF 
	ENDIF 

	* me conecto a la base de datos
	vconeccionE=abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)=" Select idestador "
	sqlmatriz(2)=" from ultimoestado "
	sqlmatriz(3)=" where tabla = '"+ALLTRIM(p_nomTabla)+"' and campo = '"+ALLTRIM(p_nomCampo)+"' and id = '"+ALLTRIM(v_indice)+"' and tipo ='"+ALLTRIM(p_tipoInd)+"'"
	

	verror=sqlrun(vconeccionE,"ultimoEst_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la búsqueda del último estado",0+48+0,"Error")
	      * me desconecto	
		=abreycierracon(vconeccionE,"") 
		RETURN 0
	ENDIF

	SELECT ultimoEst_sql
	GO TOP 

	v_IdUltimoEstado	= ultimoEst_sql.idestador
	* me desconecto	
	=abreycierracon(vconeccionE,"") 
	RETURN v_IdUltimoEstado
ENDFUNC 


FUNCTION ejecutaform 
PARAMETERS par_form, par_varpasadas
*#/----------------------------------------
* Ejecuta los formularios controlando que no estén activos
* Utilizado para evitar activar varias veces el mismo formulario
*#/----------------------------------------
	vpar_retorno = ""
	vpar_varpasadas = ""
	vpar_form = ""
	
	IF EMPTY(par_form) THEN 
		RETURN vpar_retorno  
	ELSE
		vpar_form = ALLTRIM(par_form)
	ENDIF 
	IF TYPE("par_varpasadas") = 'C'  THEN 
		vpar_varpasadas = ALLTRIM(par_varpasadas)
	ENDIF 
	IF WEXIST(vpar_form) THEN 
		RETURN vpar_retorno
	ENDIF 
	vpar_eje = "DO FORM "+vpar_form+" "+vpar_varpasadas 
	&vpar_eje
ENDFUNC 


FUNCTION obtenerCampoIndice
PARAMETERS p_tabla, p_tipo, p_cone
*#/----------------------------------------
* Función para obtener el campo indice de una tabla de la bd
* Parametros: p_Tabla: Nombre de la tabla consultada
* 			  p_tipo: indica si quiere que retorne el tipo de campo del indice .f. = no retorna, .t.= retorna tipo "C" o "I"
*				 	  concatenado al nombre de campo serparado por ";"
*			  p_cone: si recibe la conexion, entonces no cierra ni abre, usa la conexion recibida
* Retorno: Retorna el nombre del campo indice de la tabla consultada
*#/----------------------------------------


	IF TYPE("p_cone") = 'N' THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionF = p_cone
	ELSE 
		vconeccionF = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	

		v_tabla = p_tabla
		
		sqlmatriz(1)="SHOW COLUMNS FROM "+ALLTRIM(v_tabla)
		verror=sqlrun(vconeccionF,"columnas_sql")
		IF verror=.f.
			MESSAGEBOX("No se puede obtener las columnas del Comprobantes",0+16,"Advertencia")
			RETURN 
		ENDIF 
		SELECT columnas_sql

	
	IF !(TYPE("p_cone") = 'N')  THEN && Se le Paso la Conexion entonces no abre ni cierra 
		* me desconecto	
		=abreycierracon(vconeccionF,"")
	ENDIF 

	SELECT field as campo, key as clave, type as tipo FROM  columnas_sql WHERE key = "PRI" INTO TABLE columnas
	
	SELECT columnas
	GO TOP 
	v_retorno = ""
	
	v_retorno = columnas.campo 
	
	IF p_tipo = .t. THEN && agregado en caso de que se necesite el nombre del campo indice y el tipo de campo
		v_retorno = ALLTRIM(v_retorno)+";"+UPPER(SUBSTR(ALLTRIM(columnas.tipo),1,1))
	ENDIF 	
	
	RETURN v_retorno

ENDFUNC 



FUNCTION SetearIndice
PARAMETERS pa_tabla, pa_tablaorden, pa_campobus, pa_valorbus, pa_camporet, pa_tag
*#/----------------------------------------
*+ Funcion para el seteo de indices en tablas locales
* recibe como parametros una tabla a ordenar , una tabla con los indices y el valor que debe
* seleccionar para crear el indice. 
* busca en la tabla de orde pa_orden , selecciona el indice y lo crea en pa_tabla
*#/----------------------------------------

	var_indice = ALLTRIM(BUSCAVALORDB(pa_tablaorden,pa_campobus,pa_valorbus, pa_camporet,1))
	
	IF !isnull(var_indice)  THEN 
		SELECT &pa_tabla
		SET SAFETY OFF 
		INDEX on &var_indice TAG &pa_tag  
		RETURN pa_tag
	ENDIF 
	RETURN ""
ENDFUNC 


FUNCTION ejecutarexe
PARAMETERS param_path ,param_executa
*#/---------------------------------------------------------------
* LLama al Menu de Configuracion para Setearlo pasando como parametros
* los datos del Esquema seleccionado en el Sistema Seleccionado
*#/---------------------------------------------------------------

 

      vpar_retorno = ""

      vpar_varpasadas = ""

     

      IF EMPTY( param_executa) THEN

            RETURN vpar_retorno 

      ELSE

            vparam_executa = ALLTRIM(param_executa)

      ENDIF

 

      vparam_path = ALLTRIM(param_path)

 

      SET DEFAULT TO &vparam_path

      vpar_eje = "RUN /N  "+vparam_path+vparam_executa

 

      SET DEFAULT TO &_SYSESTACION 

      &vpar_eje

ENDFUNC




FUNCTION setidxgrilla
PARAMETERS p_grilla, p_columna, p_header 
*#/-------------------------------------------------------------
* Setea los indices en las grillas pasadas como parametros
* Recibe como parametros la Grilla con todo el nombre gerarquico 
* es decir el formulario y la grilla.
* como segundo parametro el Orden de la columna que esta solicitando Indexar
* Finalmente ordenea de acuerdo a los parametros y setea la grilla con informacion
* para luego continuar con el orden.
* Para el Orden del Indice Ascentente o Descendente , la grilla debe tener seteado en 
* el campo StatusBarText= "A" = "ASCENDING" u "D" = "DESCENDING"
*#/-------------------------------------------------------------
v_grilla_tabla 			= p_grilla+".recordsource"
v_grilla_tag 			= p_grilla+".tag"
v_grilla_StatusBarText	= p_grilla+".StatusBarText"
v_columna_control 		= p_grilla+"."+ALLTRIM(p_columna)+".ControlSource"
v_columna_fontunderline = p_grilla+"."+ALLTRIM(p_columna)+"."+ALLTRIM(p_header)+".fontunderline"
v_columna_fontitalic	= p_grilla+"."+ALLTRIM(p_columna)+"."+ALLTRIM(p_header)+".fontitalic"
v_columna_tag 			= p_grilla+"."+ALLTRIM(p_columna)+".tag"
V_tipodato				= TYPE(&v_columna_control)


&v_grilla_tag = STRTRAN(&v_grilla_tag,&v_columna_tag,"")
IF empty(&v_columna_tag) THEN 
	DO CASE 
		CASE v_tipodato = 'N' 
			&v_columna_tag = "strtran(str("+&v_columna_control+",10),' ','0')"
		CASE  v_tipodato = 'D' 
			&v_columna_tag = "dtos("+&v_columna_control+")"
		CASE v_tipodato = 'U'
			&v_columna_tag = ""
		CASE v_tipodato = 'C'
			&v_columna_tag = &v_columna_control	
		CASE v_tipodato = 'Y' 
			&v_columna_tag = "strtran(str("+&v_columna_control+",10,2),' ','0')"

		OTHERWISE 
			&v_columna_tag = ""
	ENDCASE  
ELSE
	&v_columna_tag = ""
ENDIF
 
IF EMPTY(&v_columna_tag) THEN 
	&v_columna_fontunderline = .f.
	&v_columna_fontitalic 	= .f.
ELSE
	&v_columna_fontunderline = .t.
	&v_columna_fontitalic 	= .t.
ENDIF 


&v_grilla_tag = "+"+ALLTRIM(&v_grilla_tag)+"+"+&v_columna_tag+"+" 
&v_grilla_tag = strtran(&v_grilla_tag,'++','+')
&v_grilla_tag = substr(&v_grilla_tag,2)
&v_grilla_tag = strtran(&v_grilla_tag,'++','+')
&v_grilla_tag = IIF(SUBSTR(ALLTRIM(&v_grilla_tag),LEN(ALLTRIM(&v_grilla_tag)),1)='+',SUBSTR(ALLTRIM(&v_grilla_tag),1,LEN(ALLTRIM(&v_grilla_tag))-1),ALLTRIM(&v_grilla_tag))
EJE = "sele "+&v_grilla_tabla
&EJE 
EJE = IIF(!EMPTY(&v_grilla_tag),"INDEX ON  ALLTRIM(SUBSTR("+&v_grilla_tag+"+SPACE(240),1,240)) TAG indice "+IIF(SUBSTR(&v_grilla_StatusBarText,1,1) = 'A','ASCENDING','DESCENDING'),"SET ORDER TO ")
&EJE
&p_grilla..refresh 

RETURN 

ENDFUNC 


FUNCTION seteagrilla
PARAMETERS p_grilla, p_RecordSource, p_matcolumn, p_DynamicColor, p_FontSize
*#/-------------------------------------------------------------
* Seteo de las Grillas de
* Recibe como parametros, el cursor, el nombre de la grilla
* un arreglo con las columnas a a colocar en la grilla
*#/-------------------------------------------------------------

	vcan_column = ALEN(&p_matcolumn,1)

*!*		ejer = " dimension "+p_matcolumn+"("+ALLTRIM(STR(vcan_column))+",6)"
*!*		&ejer
	
	&p_grilla..RecordSource = &p_grilla..RecordSource
	&p_grilla..RecordSource = p_RecordSource
	&p_grilla..ReadOnly = .t.

	&p_grilla..ColumnCount = vcan_column
	&p_grilla..BackColor = RGB(255,255,255)
	&p_grilla..DeleteMark = .F. 
	&p_grilla..FontSize = 8
	&p_grilla..ScrollBars = 3

	&p_grilla..HighlightRowLineWidth=3
	&p_grilla..GridLineWidth= 1
	&p_grilla..anchor= 15
	IF !EMPTY(p_DynamicColor) AND TYPE('p_DynamicColor')='C' THEN 
		EJE = p_grilla+".SetAll('DynamicBackColor',["+p_DynamicColor+"],'Column')"
		&EJE
	ENDIF 

	IF !EMPTY(p_FontSize) AND TYPE('p_FontSize')='N' THEN 
		&p_grilla..FontSize = p_FontSize
	ENDIF 


	IF vcan_column > 0 THEN 
		FOR _icl = 1 TO vcan_column
			
			v_columnxx 						= p_grilla+".column"+ALLTRIM(STR(_icl))
			
			
			&v_columnxx..ControlSource 		= &p_matcolumn(_icl,1) 
			&v_columnxx..header1.Caption 	= IIF(&p_matcolumn(_icl,2)=="","Header",&p_matcolumn(_icl,2))
			&v_columnxx..header1.FontBold 	= .T. 
			&v_columnxx..header1.Alignment 	= 2
			&v_columnxx..Width 				= IIF(&p_matcolumn(_icl,3)=0,75,&p_matcolumn(_icl,3))
			&v_columnxx..Alignment 			= IIF(&p_matcolumn(_icl,4)=0,3,&p_matcolumn(_icl,4)) &&0=Izquierda 1=Derecha 2=Centro 3=Automatico
			&v_columnxx..Format 	= 'Z'
			&v_columnxx..Enabled    = &p_matcolumn(_icl,5) && Enabled= .t. habliltado .f. deshabilitado
*!*				&v_columnxx..Readonly   = &p_matcolumn(_icl,6) && ReaOnly=.t. habililtado .f. deshabilitado
						
		ENDFOR 
	ENDIF 

	&p_grilla..refresh 

RETURN 

ENDFUNC 

FUNCTION fcodentidad
PARAMETERS pcodenti, pcual
*#/*****************************************************
*/ Toma en caracteres separados por puntos el valor de codigo
*/ y lo divide de acuerdo al codigo de ENTIDAD-SERVICIO-SUBCODIGO
*/ recibe caracteres y devuelve en valor numerico de acuerdo
*/ al parametro solicitado 1-ENTIDAD  2-SERVICIO  3-SUBCODIGO
*#/******************************************************
varretorno = 0
ALINES(ccodarray,pcodenti,1,".",'-')
caelementos = ALEN(ccodarray)
aelementos = IIF(caelementos>3,3,caelementos)
vcual1 = 0
vcual2 = 0
vcual3 = 0
FOR i=1 TO aelementos
	eje = "vcual"+STR(i,1)+" = INT(VAL(ccodarray(1,"+STR(i,1)+")))"
	&eje
ENDFOR 

DO CASE 
	CASE pcual = 1 &&entidad
		varretorno = vcual1
	CASE pcual = 2 &&servicio
		varretorno = vcual2
	CASE pcual = 3 && subservicio
		varretorno = vcual3
	OTHERWISE
		varretorno = 0
ENDCASE 
RELEASE ccodarray 
RETURN varretorno



FUNCTION consultalocprovpais
PARAMETERS p_idlocalidad,p_conCod, p_conProv, p_conPais
*#/-------------------------------------------------------------
* Retorna una cadena de caracteres con la localidad
* Con el siguiente formato: <Localidad> [(<Cod_postal)] [- <Provincia>] [- <Pais>]
* Parametros: 
*	p_idlocalidad I: 	Id de la localidad
*	p_conCod  B:		Booleano indicando si se muestra o no el codigo postal
*	p_conProv B:		Booleano indicando si se muestra o no la provincia
*	p_conPais B:		Booleano indicando si se muestra o no el país
*	
*#/-------------------------------------------------------------

		v_idlocalidad	= p_idlocalidad
		v_conCod		= p_conCod
		v_conProv		= p_conProv
		v_conPais		= p_conPais
	
	
	
		v_retorno = ""
		vconeccionF = abreycierracon(0,_SYSSCHEMA)

		
		sqlmatriz(1)="select l.nombre as nomLoc, l.cp, p.nombre as nomProv, pa.nombre as nomPais "
		sqlmatriz(2)=" from localidades l left join provincias p on l.provincia = p.provincia left join paises pa on p.pais = pa.pais "
		sqlmatriz(3)=" where l.localidad = "+ALLTRIM(STR(v_idlocalidad))
		
		
		verror=sqlrun(vconeccionF,"locprovpais_sql")

		=abreycierracon(vconeccionF,"")

		IF verror=.f.
			MESSAGEBOX("No se puede obtener la localidad ",0+16,"Advertencia")
			RETURN v_retorno
		ENDIF 
		SELECT locprovpais_sql
		GO TOP 
		
		IF NOT EOF()
			
			v_strlocalidad	= ALLTRIM(locprovpais_sql.nomLoc)
			v_strCodPostal	= ALLTRIM(locprovpais_sql.cp)
			v_strNomProv	= ALLTRIM(locprovpais_sql.nomProv)
			v_strNomPais	= ALLTRIM(locprovpais_sql.nomPais)
		
		
			v_retorno = v_strLocalidad
			
			IF  v_conCod = .T.
				v_retorno = ALLTRIM(v_retorno) + " ("+v_strCodPostal+")"
			
			ENDIF 
			
			IF v_conProv = .T.
				v_retorno = ALLTRIM(v_retorno) + " - "+v_strNomProv
			ENDIF 
			
			IF 	v_conPais = .T.
				v_retorno	= ALLTRIM(v_retorno) + " - "+v_strNomPais
			ENDIF 
		ELSE
			v_retorno = ""
			RETURN v_retorno
		ENDIF 
		

	RETURN v_retorno

ENDFUNC 


FUNCTION calculaDigitoVerif
PARAMETERS p_codigo
*#/-------------------------------------------------------------
* Retorna una cadena de caracteres con agregando al final el digito verificador a la cadena pasada como parámetro
* Con el siguiente formato: CCCCCCCCCCCTTTPPPPAAAAAAAAAAAAAAVVVVVVVVD
* Donde: C: CUIT_EMISOR; T: TIPO_COMPROBANTE; P: PUNTO_VENTA; A: CAE; V: FECHA_VTO; D: DIGITO_VERIFICADOR
* Parametros: 
*	p_codigoI: 	Cadena a calcular el digito verificador
* Retorno: Cadena con digito verificador	
*#/-------------------------------------------------------------

	v_codigo	= ALLTRIM(p_codigo)
	v_cantDig	= LEN(v_codigo)
	v_sumaImpar	= 0
	
	
	**Etapa 1: Comenzar de Izquierda a derecha, sumar todos los caracteres ubicados en las posiciones impares
	FOR i = 1 TO v_cantDig STEP 2
	
		
		v_dig = SUBSTR(v_codigo,i,1)
		v_sumaImpar	= v_sumaImpar + VAL(v_dig)
	
	ENDFOR 
	

	 **Etapa 2: multiplicar la suma obtenida en la estapa 1 por 3
	v_resE2 = v_sumaImpar* 3

	

	**Etapa 3: comenzar desde la izquierda, sumar todos los caracteres que están ubicados en las posiciones pares

	v_sumaPar	= 0
	FOR i = 2 TO v_cantDig STEP 2
	
		v_dig = SUBSTR(v_codigo,i,1)
		v_sumaPar	= v_sumaPar + VAL(v_dig)
	
	ENDFOR 

	
	 **Etapa 4: sumar los resultados obtenidos en la etapas 2 y 3 

	v_resE4 = v_resE2 + v_sumaPar


	v_modulo = v_resE4 % 10
	v_dif = 10 - v_modulo 
	v_digitoVerif = v_dif % 10;

	v_codigo = v_codigo + ALLTRIM(STR(v_digitoVerif))

	RETURN v_codigo


ENDFUNC 


FUNCTION separarcadena
PARAMETERS PCADENA
*#/----------------------------------------
** Función que retorna la cadena pasada como parámetro separada por puntos
*#/----------------------------------------
	RETORNO = ALLTRIM(STRTRAN(PCADENA,".",""))
	CANTCAR = LEN(ALLTRIM(RETORNO))
	IF !(MOD(CANTCAR,2) = 0) THEN 
		RETORNO = ALLTRIM(RETORNO)+"0"
		CANTCAR = CANTCAR+1
	ENDIF

	RETORNA = ""
	FOR I = 1 TO CANTCAR
		IF MOD(I,2)=0 AND I > 1 THEN
			RETORNA = RETORNA + SUBSTR(RETORNO,I-1,2)+"."
		ENDIF
	ENDFOR
	RETORNA = SUBSTR(RETORNA,1,LEN(ALLTRIM(RETORNA))-1)
RETURN RETORNA



FUNCTION fejercicioplan
PARAMETERS p_fecha,p_devuelve
*#/-------------------------------------------------------------
* Retorna el id del dejercicio economico y el id del Plan de Cuentas
* de acuerdo al ejercicio seleccionado segun la fecha ingresada
* Parametros: 1-Fecha a considerar
*			  2-Condicion devuelta : 0=Devuelve el idejercicio, 1= Devuelve el idplan
*#/-------------------------------------------------------------

	IF TYPE('p_fecha')= 'D' THEN 
		v_fechapar = DTOS(p_fecha)
	ELSE
		v_fechapar = p_fecha 
	ENDIF 
		v_retorno = 0
		
		vconeccionF = abreycierracon(0,_SYSSCHEMA)
		sqlmatriz(1)="select * from ejercicioecon "
		sqlmatriz(3)=" where fechaini <= '"+ALLTRIM(v_fechapar)+"' and fechafin >= '"+ALLTRIM(v_fechapar)+"'"
		verror=sqlrun(vconeccionF,"ejecon_sql")
		IF verror=.f.
			*MESSAGEBOX("No se puede obtener Ejercicios Económicos ",0+16,"Advertencia")
			RETURN v_retorno
		ENDIF 
		SELECT ejecon_sql
		GO TOP 
		IF EOF()	
			sqlmatriz(1)="select * from ejercicioecon  where ejercicio in (select max(ejercicio) as ejercicio from ejercicioecon where fechafin <= '"+ALLTRIM(v_fechapar)+"') "
			verror=sqlrun(vconeccionF,"ejecon_sql")
			IF verror=.f.
				*MESSAGEBOX("No se puede obtener Ejercicios Económicos ",0+16,"Advertencia")
				RETURN v_retorno
			ENDIF 
		ENDIF 
		=abreycierracon(vconeccionF,"")

		SELECT ejecon_sql 
		GO TOP 
		IF !EOF() THEN 
			IF p_devuelve = 0 THEN 
				v_retorno = IIF(ISNULL(ejecon_sql.ejercicio),0,ejecon_sql.ejercicio)
			ELSE
				v_retorno = IIF(ISNULL(ejecon_sql.idplan),0,ejecon_sql.idplan)			
			ENDIF 
		ENDIF 
		SELECT ejecon_sql
		USE
				
	RETURN v_retorno
ENDFUNC 



*************************************************

FUNCTION fdescribecompro
PARAMETERS par_tabla,par_nomindice,par_valindice
*#/-------------------------------------------------------------
* Retorna un string conteniendo una descripcion del comprobante
* que permite identificarlo univocamente. 
* Parametros: 1-tabla
*			  2-nombre del indice, Si indice está vacio lo obtiene
*			  3-Valor del indice
*#/-------------------------------------------------------------

	v_retornod = ""


	IF EMPTY(par_nomindice) THEN 
		par_nomindice = obtenerCampoIndice(ALLTRIM(par_tabla))
	ENDIF 

	vconeccionFD = abreycierracon(0,_SYSSCHEMA)
	
	*// Busco el registro de descripcion de la tabla *//
	sqlmatriz(1)=" select * from tabladescrip "
	sqlmatriz(2)=" where tabla = '"+ALLTRIM(par_tabla)+"'"
	verror=sqlrun(vconeccionFD,"tabladescrip_sql")
	IF verror=.f.
		=abreycierracon(vconeccionFD,"")
		RETURN v_retornod
	ENDIF 
	SELECT tabladescrip_sql
	GO TOP 
	IF EOF() THEN 
		=abreycierracon(vconeccionFD,"")
		RETURN v_retornod
	ENDIF 
	
	*// si llego es porque hay registro de descripcion de la tabla *//
	*// busco la descripcion del registro pasado *//
	IF TYPE('par_valindice')="C" THEN 
		v_par_valindice = "'"+ALLTRIM(par_valindice)+"'"
	ELSE 
		v_par_valindice = ALLTRIM(STR(par_valindice))
	ENDIF 
	
	sqlmatriz(1)= ALLTRIM(tabladescrip_sql.consulta)
	sqlmatriz(2)=" where "+ALLTRIM(par_tabla)+"."+ALLTRIM(par_nomindice)+" = "+v_par_valindice  &&ALLTRIM(STR(par_valindice))

	verror=sqlrun(vconeccionFD,"datoscompro_sql")
	IF verror=.f.
		=abreycierracon(vconeccionFD,"")
		RETURN v_retornod
	ENDIF 
	SELECT datoscompro_sql
	GO TOP 
	IF !EOF() THEN 
		eje = "v_retornod = "+tabladescrip_sql.descrip
		&eje
	ENDIF 	

	SELECT datoscompro_sql 
	USE IN datoscompro_sql 
	SELECT tabladescrip_sql
	USE IN tabladescrip_sql

	IF !(TYPE('par_valindice')="C") THEN  && actualizo detalle de asientos solo si indice es numero --> comprobante
		sqlmatriz(1)	="  update asientoscompro set detacompro = '"+ALLTRIM(SUBSTR(ALLTRIM(v_retornod)+SPACE(254),1,254))+"'"
		sqlmatriz(2)	="  where  idregicomp = "+ALLTRIM(STR(par_valindice))+" and tabla = '"+ALLTRIM(par_tabla)+"'"
		verror=sqlrun(vconeccionFD,"asientosco")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualización de AsientosCompro ",0+48+0,"Error")
		ENDIF 
	ENDIF 
	
	=abreycierracon(vconeccionFD,"")

	RETURN v_retornod
ENDFUNC 


***********************************************


FUNCTION imprimirRemito
PARAMETERS p_idremito, p_esElectronica
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UN REMITO
* PARAMETROS: P_IDREMITO, P_ESELECTRONICA
*#/----------------------------------------


	v_idremito = p_idremito
	v_esElectronica = p_esElectronica 

	IF v_idremito > 0
		
		*** Busco los datos de la factura y el detalle
*!*			IF v_esElectronica  = .T.

*!*			
*!*			ELSE
			
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			sqlmatriz(1)="Select r.*,d.*,c.*,v.*,r.numero as numRem, c.detalle as detIVA,ca.puntov, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP, l.nombre as nomLoc, TRIM(p.nombre) as nomProv, "
			sqlmatriz(2)=" com.comprobante as nomcomp from remitos r left join comprobantes com on r.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(3)=" left join compactiv ca on r.idcomproba = ca.idcomproba and r.pventa = ca.pventa  left join puntosventa pv on ca.pventa = pv.pventa  " 
			sqlmatriz(4)=" left join remitosh d on r.idremito = d.idremito "
			sqlmatriz(5)=" left join condfiscal c on r.iva = c.iva"
			sqlmatriz(6)=" left join vendedores v on r.vendedor = v.vendedor"
			sqlmatriz(7)=" left join localidades l on r.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
			sqlmatriz(8)=" where r.idremito = "+ ALLTRIM(STR(v_idremito))
			verror=sqlrun(vconeccionF,"rec_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del Remito",0+48+0,"Error")
			ENDIF
		
*!*			ENDIF 
		
	
		SELECT * FROM rec_det_sql INTO TABLE remi
		
		
		
		SELECT remi
		ALTER table remi alter COLUMN apellido c(200)
		replace ALL apellido WITH ALLTRIM(apellido)+" "+ALLTRIM(nombre)
		GO TOP 
		IF NOT EOF()
		
*			ALTER table factu ADD COLUMN codBarra	 C(42)
		
			v_idcomproba = remi.idcomproba
			v_tipoCompAfip	= ALLTRIM(remi.tipcomAFIP)
			
			
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= remi.electro
			v_cuitEmpresa	= _SYSCUIT
			
		
		
		
		
		
		
		
		
			*Anexo prop Detalle
*!*				sqlmatriz(1)=" SELECT CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(r.tabla,SPACE(15)) as tabla,sum(o.cantidad*d.valor) as valor  FROM ocd o left join reldatosextra r on o.articulo = r.idregic and r.tabla = 'articulos' "
*!*				sqlmatriz(2)=" left join datosextra d on r.iddatosex = d.iddatosex where d.imprimir = 'S' and d.operable = 'S' group by d.propiedad "
*!*				sqlmatriz(3)=" union "
*!*				sqlmatriz(4)=" SELECT CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(r.tabla,SPACE(15)) as tabla,sum(o.cantidad*d.valor) as valor  FROM ocd o left join reldatosextra r on o.idmate = r.idregistro and r.tabla = 'otmateriales' "
*!*				sqlmatriz(5)=" left join datosextra d on r.iddatosex = d.iddatosex where d.imprimir = 'S' and d.operable = 'S'  group by d.propiedad "


			sqlmatriz(1)="SELECT CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(r.tabla,SPACE(15)) as tabla,sum(h.cantidad*d.valor) as valor  FROM remitosh h left join reldatosextra r on h.articulo = r.idregic and r.tabla = 'articulos' "
			sqlmatriz(2)=" left join datosextra d on r.iddatosex = d.iddatosex where d.imprimir = 'S' and d.operable = 'S' and h.idremito = "+ ALLTRIM(STR(v_idremito)) +" group by d.propiedad "
			sqlmatriz(3)=" union "
			sqlmatriz(4)=" SELECT CONCAT(d.propiedad,SPACE(50)) as propiedad, concat(r.tabla,SPACE(15)) as tabla,sum(h.cantidad*d.valor) as valor  FROM remitosh h left join reldatosextra r on h.articulo = r.idregic and r.tabla = 'otmateriales' "
			sqlmatriz(5)=" left join datosextra d on r.iddatosex = d.iddatosex where d.imprimir = 'S' and d.operable = 'S' and h.idremito = "+ ALLTRIM(STR(v_idremito)) +" group by d.propiedad "


			verror=sqlrun(vconeccionF,"remihextra_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las propiedades del detalle del Remito ",0+48+0,"Error")
			ENDIF 		
			

			
			


			SELECT remihextra_sql
			GO TOP 
			
			IF EOF() THEN 
				CREATE TABLE remihex ( propiedad c(50), valor m , tabla c(15)) 
			ELSE
				SELECT propiedad , IIF(TYPE('valor')='N',ALLTRIM(STR(valor,13,2)),ALLTRIM(valor)) as valor , tabla FROM remihextra_sql INTO TABLE .\remihex ORDER BY propiedad 
				ALTER table remihex alter COLUMN valor m
			ENDIF 
			USE IN remihextra_sql
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
			
			DO FORM reporteform WITH "remi;remihex","remitoscr;remihexcr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar el remito para imprimir",0+48+0,"Error al cargar el remito")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar el remito ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION imprimirRetenciones
PARAMETERS P_idpago, p_conexion
*#/****************************
* FUNCIÓN PARA IMPRIMIR LOS COMPROBANTES DE RETENCIONES DADO UNA ORDEN DE PAGO
* PARAMETROS: P_idpago: Recibe como parámetro el ID de la orden de pago
* La función imprime los comprobantes de retención según los parametros
*#/****************************

	vconeccionF= 0
	IF TYPE('p_conexion') = 'L'
	
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
	ELSE
	
		vconeccionF=P_conexion
	ENDIF 

		tipoComproObjtmp 	= CREATEOBJECT('tiposcomproclass')


		v_idtipoCompRet = tipoComproObjtmp.getIdtipocompro("RETENCION")
		
		
		sqlmatriz(1)= " select l.idlinkcomp, l.idcomprobaa as idcompag, l.idregistroa as idregpag, l.idcomprobab as idcompret, l.idregistrob as idregret "
		sqlmatriz(2)= " from comprobantes c left join linkcompro l on c.idcomproba = l.idcomprobab "
		sqlmatriz(3)=" where c.idtipocompro = "+ALLTRIM(STR(v_idtipoCompRet))+ " and l.idregistroa = " +ALLTRIM(STR(P_idpago))
		
			verror=sqlrun(vconeccionF,"retAimp_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de las retenciones a imprimir ",0+48+0,"Error")
			    RETURN 
			ENDIF
			
	
		SELECT retAimp_sql
		GO TOP 
		
		DO WHILE NOT EOF()
		
			
			v_idretencion = retAimp_sql.idregret 
			
			
			imprimirRetencion(v_idretencion)
			
			
			SELECT retAimp_Sql
			SKIP 1


		ENDDO



ENDFUNC 


FUNCTION imprimirRetencion
PARAMETERS p_idretencion, p_conexion
*#/****************************
* FUNCIÓN PARA IMPRIMIR EL COMPROBANTE DE RENTECIÓN
* PARAMETROS: P_idretencion: Recibe como parámetro el ID de la retención ha imprimir
* La función imprime un comprobante de retención según los parametros
*#/****************************

	vconeccionF= 0
	IF TYPE('p_conexion') = 'L'
	
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
	ELSE
	
		vconeccionF=P_conexion
	ENDIF 


	v_idreten  = p_idretencion
	
	IF v_idreten > 0
		
		*vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del recibo
					


*!*			sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, ifnull(a.codigo,'') as tipcomafip, e.cuit, i.idimpuret, i.detalle as nomimp, p.idpago, l.idcomprobaa  as idcomppag"
*!*			sqlmatriz(2)=" from retenciones r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba "
*!*			sqlmatriz(3)=" left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom "
*!*			sqlmatriz(4)=" left join entidades e on r.entidad = e.entidad left join impuretencion i on r.idimpuret = i.idimpuret "
*!*			sqlmatriz(5)=" left join linkcompro l on r.idcomproba = l.idcomprobab and r.idreten = l.idregistrob left join pagosprov p on l.idregistroa = p.idpago "
*!*			sqlmatriz(6)=" where r.idreten = "+ ALLTRIM(STR(v_idreten))


			sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, ifnull(a.codigo,'') as tipcomafip, e.*, cf.detalle as condfisc,lc.nombre as nomloc, pr.nombre as nomprov , i.baseimpon, i.idimpuret, i.detalle as nomimp, l.idcomprobaa  as idcomppag, " 
			sqlmatriz(2)=" p.numero as numerop, p.fecha as fechap, p.entidad as entidadp, p.apellido as apellidop,p.nombre as nombrep, p.importe as importep,pvp.puntov as puntovp, af.razon as razonap "
			sqlmatriz(3)=" from retenciones r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba "
			sqlmatriz(4)=" left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom "
			sqlmatriz(5)=" left join entidades e on r.entidad = e.entidad  left join localidades lc on e.localidad = lc.localidad left join provincias pr on lc.provincia = pr.provincia left join condfiscal cf on e.iva = cf.iva "
*			sqlmatriz(6)=" left join impuretencion i on r.idimpuret = i.idimpuret  left join linkcompro l on r.idcomproba = l.idcomprobab and r.idreten = l.idregistrob left join pagosprov p on l.idregistroa = p.idpago "
			sqlmatriz(6)=" left join impuretencionh i on r.idreten = i.idreten  left join linkcompro l on r.idcomproba = l.idcomprobab and r.idreten = l.idregistrob left join pagosprov p on l.idregistroa = p.idpago "
*			sqlmatriz(7)=" left join puntosventa pvp on p.pventa = pvp.pventa left join afipescalas af on r.idafipesc = af.idafipesc "
			sqlmatriz(7)=" left join puntosventa pvp on p.pventa = pvp.pventa left join afipescalash af on i.idafipesc = af.idafipesc "
			sqlmatriz(8)=" where r.idreten = "+ ALLTRIM(STR(v_idreten))



			verror=sqlrun(vconeccionF,"retenciones_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Retención",0+48+0,"Error")
			    RETURN 
			ENDIF
		
			SELECT * FROM retenciones_sql INTO TABLE retenciones
			SELECT retenciones
			GO TOP 
			
			*** Convierto el importe en letras ***
			
			ALTER table retenciones ADD COLUMN impstr C(250)
			
			SELECT retenciones
			GO TOP 
			
			DO WHILE NOT EOF()
			
			
				v_importe = retenciones.importe
			
				v_strImporte	= enletras (v_importe)
			
				SELECT retenciones
				replace impstr WITH ALLTRIM(v_strImporte)
			
				SELECT retenciones 
				
				SKIP 1

			ENDDO
			
			
			SELECT retenciones
			GO TOP 
			
			v_idcomprobaret = retenciones.idcomproba
			DO FORM reporteform WITH "retenciones","retencionescr",v_idcomprobaret
				
*!*			SELECT * FROM retenciones_sql INTO TABLE retenciones
*!*					
*!*			SELECT retenciones
*!*			GO TOP 
*!*		
*!*			IF NOT EOF()
*!*		
*!*		*		replace ALL desccpl WITH tipopago FOR ISNULL(desccpl) = .T.
*!*				
*!*						
*!*				SELECT retenciones
*!*				GO TOP 
*!*				v_idcomprobaret = retenciones.idcomproba
*!*				
*!*				v_idpago = retenciones.idpago
*!*				v_idcomprobapag = retenciones.idcomppag
*!*				*** Obtengo la orden de pago asociada junto con los comprobantes pagados ** 
*!*				
*!*				
*!*				sqlmatriz(1)= " select * from pagosprovfc pf left join factuprove f on pf.idfactprove = f.idfactprove and pf.idcomproba = f.idcomproba "
*!*				sqlmatriz(2)= " where pf.idpago = "+ALLTRIM(STR(v_idpago)) +" and pf.idcomproba = "+ALLTRIM(STR(v_idcomprobapag))
*!*				
*!*				verror=sqlrun(vconeccionF,"pagosprovfc_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la Retención",0+48+0,"Error")
*!*				    RETURN 
*!*				ENDIF
*!*				
*!*				
*!*				SELECT * FROM pagosprovfc_sql INTO TABLE pagosprovfc
*!*				
*!*				
*!*				DO FORM reporteform WITH "retenciones;pagosprovfc","retencionescr;pagosprovfccr",v_idcomprobaret
*!*				
*!*			ELSE
*!*				MESSAGEBOX("Error al cargar la Retención para imprimir",0+48+0,"Error al cargar la Retención")
*!*				RETURN 	
*!*			ENDIF 
				
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar el comprobante de Retención, ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 








FUNCTION AjusteComprobante
PARAMETERS p_idtipomov, p_idcomproba,p_nombreCampo,p_idregistro,p_tablaDatos
*#/----------------------------------------
**** FUNCIÓN PARA GENERAR AJUSTES DE UN COMPROBANTE
** PARAMETROS: 	P_idtipomov: ID de la tabla tipomstock (Indica el tipo de ajuste a realizar)
***				P_idcomproba: ID de la tabla comprobante (comprobante relacionado al ajuste)
***				P_nomreCampo: Nombre del campo Indice de la tabla asociada al comprobante
***				P_Idregistro: ID de la tabla asociada al comprobante
***				P_TablaDatos: Tabla con los articulos a los que se le hará el ajuste, tiene el siguiente formato: [articulo C(50),cantidad Y,deposito I]
**RETORNO:		.T. o .F. Dependiendo si se realizó el ajuste correctamente o no respectivamente
*#/----------------------------------------

v_idtipomov		= p_idtipomov
v_idcomproba	= p_idcomproba
v_nombreCampo	= p_nombreCampo
v_idregistro	= p_idregistro
v_tablaDatos	= p_tablaDatos

* Controlo que los articulos recibidos esten afectado a movimientos de stoc
* y no sean conceptos que no mueven stock 

**** Busco el comprobante asociado ***
vconeccionA=abreycierracon(0,_SYSSCHEMA)	
	
SELECT &v_tablaDatos
ALTER table &v_tablaDatos ADD COLUMN ajustar c(1)
GO TOP 

DO WHILE !EOF()
	sqlmatriz(1)=" Select * from articulos where TRIM(articulo) = '"+ALLTRIM(&v_tablaDatos..articulo)+"' and  ctrlstock = 'S'"
	verror=sqlrun(vconeccionA,"ajustar_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de Articulos ",0+48+0,"Error")
	    =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF
	SELECT ajustar_sql
	GO TOP 
	IF EOF() THEN 
		v_ajustar = 'N'
	ELSE
		v_ajustar = 'S'
	ENDIF 
	USE 
	SELECT &v_tablaDatos
	replace ajustar WITH v_ajustar	
	SKIP 
ENDDO 
DELETE FOR ajustar = 'N'
PACK
IF RECCOUNT() = 0 THEN 
	=abreycierracon(vconeccionA,"")
	RETURN .T.
ENDIF 

SELECT &v_tablaDatos
GO TOP 

*!*		**** Busco el comprobante asociado ***
*!*		vconeccionA=abreycierracon(0,_SYSSCHEMA)	

	*** Busco los comprobantes y sus respectivos puntos de venta 
	sqlmatriz(1)=" Select c.idcomproba, c.comprobante as nomcomp, c.idtipocompro, c.tipo, c.ctacte, c.tabla, t.pventa, "
	sqlmatriz(2)=" t.puntov from comprobantes c left join compactiv t on c.idcomproba = t.idcomproba "
	verror=sqlrun(vconeccionA,"Comprobantes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de comprobantes ",0+48+0,"Error")
	    =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF

IF v_idregistro	> 0

	SELECT * FROM comprobantes_sql WHERE idcomproba = v_idcomproba INTO TABLE compSelecc
	
	SELECT compSelecc
	GO TOP 
	
	v_tabla			= compSelecc.tabla
	v_nombreComp	= compSelecc.nomcomp
	
	*** Busco el comprobante asociado
	sqlmatriz(1)=" select * from "+ALLTRIM(v_tabla)+" c left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
	sqlmatriz(2)=" where c."+ALLTRIM(v_nombreCampo)+" = "+ALLTRIM(STR(v_idregistro))

	verror=sqlrun(vconeccionA,"Comprobante_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del comprobante asociado ",0+48+0,"Error")
	     =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF
	
	
*!*		SELECT Comprobante_sql
*!*		GO TOP 
	
	SELECT comprobante_sql
	GO TOP 
	v_entidad	= Comprobante_sql.entidad
	v_nombre	= ALLTRIM(Comprobante_sql.apellido)+" "+ALLTRIM(Comprobante_sql.nombre)
	v_puntov	= comprobante_sql.puntov
	v_numComp	= comprobante_sql.numero
*!*		v_observa1	= "Comprobante asociado: "+ALLTRIM(v_nombreComp)+" "+ALLTRIM(v_puntoVA)+" - "+ ALLTRIM(STRTRAN(STR(v_numComp,8,0)," ","0"))


	*** Busco el comprobante de ajuste para el punto de venta asociado al comprobante
	v_pventaC	= comprobante_sql.pventa

ELSE 	
	v_pventaC	= INT(VAL(SUBSTR(_SYSCIERRESTA,3,2)))

	v_entidad	= INT(VAL(SUBSTR(_SYSCIERRESTA,9)))
	
	*** Busco la Entidad o Nombre de Empresa asociado
	sqlmatriz(1)=" select * from entidades "
	sqlmatriz(2)=" where entidad = "+ALLTRIM(STR(v_entidad))

	verror=sqlrun(vconeccionA,"entidad_sel")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  Entidad para Ajuste ",0+48+0,"Error")
	     =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF
	SELECT entidad_sel
	GO TOP 
	IF !EOF() THEN 
		v_nombre	= ALLTRIM(entidad_sel.apellido) +" "+ ALLTRIM(entidad_sel.nombre) +" "+ ALLTRIM(entidad_sel.compania)
	ELSE 
		v_nombre	= "CIERRE DE STOCK Y PUESTA A 0 "		
	ENDIF 
	USE IN entidad_sel
	
	v_puntov	= 0
	v_numComp	= 0
	v_observa1	= "Cierre de Stock al "+SUBSTR(&v_tablaDatos..fecha,7,2)+"/"+SUBSTR(&v_tablaDatos..fecha,5,2)+"/"+SUBSTR(&v_tablaDatos..fecha,1,4)

ENDIF 

	SELECT * FROM comprobantes_Sql WHERE tabla = 'ajustestockp' AND pventa	= v_pventaC INTO TABLE compAjusteAso
	
	SELECT compAjusteAso 
	GO TOP 

	v_pventaA	 = compAjusteAso.pventa
	v_idcomprobaA= compAjusteAso.idcomproba
	v_puntoVA	 = compAjusteAso.puntov

	IF v_idregistro > 0 THEN 
		v_observa1	= "Comprobante asociado: "+ALLTRIM(v_nombreComp)+" "+ALLTRIM(v_puntoVA)+" - "+ ALLTRIM(STRTRAN(STR(v_numComp,8,0)," ","0"))
	ENDIF 


	v_idajuste 	 = maxnumeroidx("idajuste","I","ajustestockp",1)
	
	v_numero 	 = maxnumerocom(v_idcomprobaA, v_pventaA,1)
	
	v_fecha		 = &v_tablaDatos..fecha

	
*!*		SELECT comprobante_sql
*!*		GO TOP 
*!*		v_entidad	= Comprobante_sql.entidad
*!*		v_nombre	= Comprobante_sql.nombre+" "+Comprobante_sql.apellido
*!*		v_puntov	= comprobante_sql.puntov
*!*		v_numComp	= comprobante_sql.numero
*!*		v_observa1	= "Comprobante asociado: "+ALLTRIM(v_nombreComp)+" "+ALLTRIM(v_puntoVA)+" - "+ ALLTRIM(STRTRAN(STR(v_numComp,8,0)," ","0"))

	DIMENSION lamatriz1(14,2)

	lamatriz1(1,1)='idajuste'
	lamatriz1(1,2)= ALLTRIM(STR(v_idajuste))
	lamatriz1(2,1)='puntov'
	lamatriz1(2,2)= "'"+ALLTRIM(v_puntoVA)+"'"
	lamatriz1(3,1)='numero'
	lamatriz1(3,2)= ALLTRIM(STR(v_numero))
	lamatriz1(4,1)='fecha'
	lamatriz1(4,2)="'"+ALLTRIM(v_fecha)+"'"
	lamatriz1(5,1)='entidad'
	lamatriz1(5,2)=ALLTRIM(STR(v_entidad))
	lamatriz1(6,1)='nombre'
	lamatriz1(6,2)="'"+ALLTRIM(v_nombre)+"'"
	lamatriz1(7,1)='responsable'
	lamatriz1(7,2)="'"+ALLTRIM(_SYSUSUARIO)+"'"
	lamatriz1(8,1)='observa1'
	lamatriz1(8,2)="'"+v_observa1+"'"
	lamatriz1(9,1)='observa2'
	lamatriz1(9,2)="''"
	lamatriz1(10,1)='observa3'
	lamatriz1(10,2)="''"
	lamatriz1(11,1)='observa4'
	lamatriz1(11,2)="''"
	lamatriz1(12,1)='idtipomov'
	lamatriz1(12,2)=ALLTRIM(STR(v_idtipomov))
	lamatriz1(13,1)='idcomproba'
	lamatriz1(13,2)= ALLTRIM(STR(v_idcomprobaA))
	lamatriz1(14,1)='pventa'
	lamatriz1(14,2)=ALLTRIM(STR(v_pventaA))


	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
	p_tabla     = 'ajustestockp'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionA
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajuste)),0+48+0,"Error")
	    =abreycierracon(vconeccionA,"")
		    RETURN .F.
	ENDIF  




	*** INSERTO DETALLE ***			


	sqlmatriz(1)=" Select * from tipomstock where idtipomov = "+ALLTRIM(STR(v_idtipomov))
	verror=sqlrun(vconeccionA,"tipomstock_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de tipo de movimiento de stock ",0+48+0,"Error")
		   
	ENDIF

	v_descmovStock	= tipomstock_sql.descmov
*	v_generaEtiqueta = tipomstock_sql.generaeti
		
	
	SELECT &v_tablaDatos
	GO TOP 

	IF NOT EOF()
		
		*** Busco el comprobante asociado
		sqlmatriz(1)=" select * from articulos "
			
		verror=sqlrun(vconeccionA,"articulos_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de articulos ",0+48+0,"Error")
		     =abreycierracon(vconeccionA,"")
		    RETURN .F.
		ENDIF


		SELECT articulos_sql
		GO TOP 
		
		IF NOT EOF()
			SELECT t.*,a.detalle FROM &v_tablaDatos t LEFT JOIN articulos_sql a ON ALLTRIM(t.articulo) == ALLTRIM(a.articulo) ;
			INTO TABLE articulosDatos WHERE !ISNULL(a.detalle) 
			
			v_primerEti = 0
			v_ultimaEti = 0
			SELECT articulosDatos
			GO TOP 

			DO WHILE NOT EOF()
				IF !EMPTY(articulosDatos.articulo) AND articulosDatos.cantidad > 0 THEN 
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					
					DIMENSION lamatriz2(11,2)
					
					*thisform.calcularmaxh
					v_idajusteh = maxnumeroidx("idajusteh","I","ajustestockh",1)
					
					lamatriz2(1,1)='idajuste'
					lamatriz2(1,2)=ALLTRIM(STR(v_idajuste))
					lamatriz2(2,1)='articulo'
					lamatriz2(2,2)="'"+ALLTRIM(articulosDatos.articulo)+"'"
					lamatriz2(3,1)='detalle'
					lamatriz2(3,2)="'"+alltrim(articulosDatos.detalle)+"'"
					lamatriz2(4,1)='idtipomov'
					lamatriz2(4,2)=alltrim(STR(v_idtipomov))
					lamatriz2(5,1)='descmov'
					lamatriz2(5,2)="'"+alltrim(v_descmovStock)+"'"
					lamatriz2(6,1)='cantidad'
					lamatriz2(6,2)=alltrim(STR(articulosDatos.cantidad,10,2))
					lamatriz2(7,1)='idajusteh'
					lamatriz2(7,2)=ALLTRIM(STR(v_idajusteh))	
					lamatriz2(8,1)='neto'
					lamatriz2(8,2)="0"
					lamatriz2(9,1)='total'
					lamatriz2(9,2)="0"
					lamatriz2(10,1)='deposito'
					lamatriz2(10,2)= ALLTRIM(STR(articulosDatos.deposito))
					lamatriz2(11,1)='fecha'
					lamatriz2(11,2)="'"+ALLTRIM(v_fecha)+"'"
					
					p_tabla     = 'ajustestockh'
					p_matriz    = 'lamatriz2'
					p_conexion  = vconeccionA
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajusteh )),0+48+0,"Error")
					ELSE
					
					
					ENDIF						
					
				ENDIF

				SELECT articulosDatos
				SKIP 1
			ENDDO	
			
					
		ELSE
	    	=abreycierracon(vconeccionA,"")
			RETURN .F.
		ENDIF 
	ELSE
    	=abreycierracon(vconeccionA,"")	
		RETURN .F.
		
	ENDIF 
	

*!*	ELSE
*!*		RETURN .F.

*!*	ENDIF 
   	=abreycierracon(vconeccionA,"")
	RETURN .T.
ENDFUNC 




FUNCTION AjusteComprobanteProv
PARAMETERS p_idtipomov, p_idcomproba,p_nombreCampo,p_idregistro,p_tablaDatos,p_pventa
*#/----------------------------------------
**** FUNCIÓN PARA GENERAR AJUSTES DE UN COMPROBANTE de PROVEEDOR
** PARAMETROS: 	P_idtipomov: ID de la tabla tipomstock (Indica el tipo de ajuste a realizar)
***				P_idcomproba: ID de la tabla comprobante (comprobante relacionado al ajuste)
***				P_nomreCampo: Nombre del campo Indice de la tabla asociada al comprobante
***				P_Idregistro: ID de la tabla asociada al comprobante
***				P_TablaDatos: Tabla con los articulos a los que se le hará el ajuste, tiene el siguiente formato: [articulo C(50),cantidad Y,deposito I]
***				P_pventa: Pventa relacionado al ajuste que se va a realizar
**RETORNO:		.T. o .F. Dependiendo si se realizó el ajuste correctamente o no respectivamente
*#/----------------------------------------

v_idtipomov		= p_idtipomov
v_idcomproba	= p_idcomproba
v_nombreCampo	= p_nombreCampo
v_idregistro	= p_idregistro
v_tablaDatos	= p_tablaDatos



SELECT &v_tablaDatos
GO TOP 


IF v_idregistro	> 0

	**** Busco el comprobante asociado ***
	vconeccionA=abreycierracon(0,_SYSSCHEMA)	
		

	*** Busco los comprobantes y sus respectivos puntos de venta 
	sqlmatriz(1)=" Select c.idcomproba, c.comprobante as nomcomp, c.idtipocompro, c.tipo, c.ctacte, c.tabla, t.pventa, "
	sqlmatriz(2)=" t.puntov from comprobantes c left join compactiv t on c.idcomproba = t.idcomproba "
	*sqlmatriz(1)=" Select c.* from comprobantes c "
	verror=sqlrun(vconeccionA,"Comprobantes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de comprobantes ",0+48+0,"Error")
	    =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF


	SELECT * FROM comprobantes_sql WHERE idcomproba = v_idcomproba INTO TABLE compSelecc
	
	SELECT compSelecc
	GO TOP 
	
	v_tabla	= compSelecc.tabla
	v_nombreComp	= compSelecc.nomcomp
	
	*** Busco el comprobante asociado
	sqlmatriz(1)=" select * from "+ALLTRIM(v_tabla)+" c  "
	sqlmatriz(2)=" where c."+ALLTRIM(v_nombreCampo)+" = "+ALLTRIM(STR(v_idregistro))
	
	verror=sqlrun(vconeccionA,"Comprobante_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del comprobante asociado ",0+48+0,"Error")
	     =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF
	
	
	SELECT Comprobante_sql
	GO TOP 
	


	*** Busco el comprobante de ajuste para el punto de venta asociado al comprobante
*	v_pventaC	= comprobante_sql.pventa
	v_pventaC	= p_pventa
	
	
	SELECT * FROM comprobantes_Sql WHERE tabla = 'ajustestockp' AND pventa	= v_pventaC INTO TABLE compAjusteAso
	
	SELECT compAjusteAso 
	GO TOP 
	v_pventaA	= compAjusteAso.pventa
	v_idcomprobaA= compAjusteAso.idcomproba


	v_idajuste 	= maxnumeroidx("idajuste","I","ajustestockp",1)
	
	v_puntoVA	= compAjusteAso.puntov
	v_numero 	= maxnumerocom(v_idcomprobaA, v_pventaA,1)
	
	v_fecha		= DTOS(DATE())
	
	SELECT comprobante_sql
	GO TOP 
	v_entidad	= Comprobante_sql.entidad
	v_nombre	= Comprobante_sql.nombre
*	v_puntov	= comprobante_sql.puntov
	v_puntovA 	= STRTRAN(STR((Comprobante_sql.actividad),4,0)," ","0")
	v_numComp	= comprobante_sql.numero
	v_observa1	= "Comprobante asociado: "+ALLTRIM(v_nombreComp)+" "+ALLTRIM(v_puntoVA)+" - "+ ALLTRIM(STRTRAN(STR(v_numComp,8,0)," ","0"))

	DIMENSION lamatriz1(14,2)

	lamatriz1(1,1)='idajuste'
	lamatriz1(1,2)= ALLTRIM(STR(v_idajuste))
	lamatriz1(2,1)='puntov'
	lamatriz1(2,2)= "'"+ALLTRIM(v_puntoVA)+"'"
	lamatriz1(3,1)='numero'
	lamatriz1(3,2)= ALLTRIM(STR(v_numero))
	lamatriz1(4,1)='fecha'
	lamatriz1(4,2)="'"+ALLTRIM(v_fecha)+"'"
	lamatriz1(5,1)='entidad'
	lamatriz1(5,2)=ALLTRIM(STR(v_entidad))
	lamatriz1(6,1)='nombre'
	lamatriz1(6,2)="'"+ALLTRIM(v_nombre)+"'"
	lamatriz1(7,1)='responsable'
	lamatriz1(7,2)="'"+ALLTRIM(_SYSUSUARIO)+"'"
	lamatriz1(8,1)='observa1'
	lamatriz1(8,2)="'"+v_observa1+"'"
	lamatriz1(9,1)='observa2'
	lamatriz1(9,2)="''"
	lamatriz1(10,1)='observa3'
	lamatriz1(10,2)="''"
	lamatriz1(11,1)='observa4'
	lamatriz1(11,2)="''"
	lamatriz1(12,1)='idtipomov'
	lamatriz1(12,2)=ALLTRIM(STR(v_idtipomov))
	lamatriz1(13,1)='idcomproba'
	lamatriz1(13,2)= ALLTRIM(STR(v_idcomprobaA))
	lamatriz1(14,1)='pventa'
	lamatriz1(14,2)=ALLTRIM(STR(v_pventaA))


	p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
	p_tabla     = 'ajustestockp'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionA
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajuste)),0+48+0,"Error")
	    =abreycierracon(vconeccionA,"")
		    RETURN .F.
	ENDIF  




	*** INSERTO DETALLE ***			


	sqlmatriz(1)=" Select * from tipomstock where idtipomov = "+ALLTRIM(STR(v_idtipomov))
	verror=sqlrun(vconeccionA,"tipomstock_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de tipo de movimiento de stock ",0+48+0,"Error")
		   
	ENDIF

	v_descmovStock	= tipomstock_sql.descmov
	v_generaEtiqueta = tipomstock_sql.generaeti
		
	
	SELECT &v_tablaDatos
	GO TOP 

	IF NOT EOF()
		
		*** Busco el comprobante asociado
		sqlmatriz(1)=" select * from articulos "
			
		verror=sqlrun(vconeccionA,"articulos_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de articulos ",0+48+0,"Error")
		     =abreycierracon(vconeccionA,"")
		    RETURN .F.
		ENDIF


		SELECT articulos_sql
		GO TOP 
		
		IF NOT EOF()
			SELECT t.*,a.detalle FROM &v_tablaDatos t LEFT JOIN articulos_sql a ON t.articulo = a.articulo INTO TABLE articulosDatos
			
			v_primerEti = 0
			v_ultimoEit = 0
			SELECT articulosDatos
			GO TOP 

			DO WHILE NOT EOF()
				IF !EMPTY(articulosDatos.articulo) AND articulosDatos.cantidad > 0 THEN 
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					
					DIMENSION lamatriz2(11,2)
					
					*thisform.calcularmaxh
					v_idajusteh = maxnumeroidx("idajusteh","I","ajustestockh",1)
					
					lamatriz2(1,1)='idajuste'
					lamatriz2(1,2)=ALLTRIM(STR(v_idajuste))
					lamatriz2(2,1)='articulo'
					lamatriz2(2,2)="'"+ALLTRIM(articulosDatos.articulo)+"'"
					lamatriz2(3,1)='detalle'
					lamatriz2(3,2)="'"+alltrim(articulosDatos.detalle)+"'"
					lamatriz2(4,1)='idtipomov'
					lamatriz2(4,2)=alltrim(STR(v_idtipomov))
					lamatriz2(5,1)='descmov'
					lamatriz2(5,2)="'"+alltrim(v_descmovStock)+"'"
					lamatriz2(6,1)='cantidad'
					lamatriz2(6,2)=alltrim(STR(articulosDatos.cantidad,10,2))
					lamatriz2(7,1)='idajusteh'
					lamatriz2(7,2)=ALLTRIM(STR(v_idajusteh))	
					lamatriz2(8,1)='neto'
					lamatriz2(8,2)="0"
					lamatriz2(9,1)='total'
					lamatriz2(9,2)="0"
					lamatriz2(10,1)='deposito'
					lamatriz2(10,2)= ALLTRIM(STR(articulosDatos.deposito))
					lamatriz2(11,1)='fecha'
					lamatriz2(11,2)="'"+ALLTRIM(v_fecha)+"'"
					
					p_tabla     = 'ajustestockh'
					p_matriz    = 'lamatriz2'
					p_conexion  = vconeccionA
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajusteh )),0+48+0,"Error")
					ELSE
					
						*** Creo y asocio la ETIQUETA si el movimiento requiere de etiquetas
						IF v_generaEtiqueta = 'S'
							** CREO Etiqueta ***
								v_cantEti		= VAL(STR(articulosDatos.cantidad,10,2))
								indice = 1
			*!*					FOR i = 1 TO 20 STEP 1
							
							DO WHILE indice <= v_cantEti
							
							*	v_etiqueta = maxnumeroidx("etiqueta","I","etiquetas",1)
							
							
							
								DIMENSION lamatriz3(8,2)
								v_etiqueta = 0
								
								p_tipoope     = 'I'
								p_condicion   = ''
								v_titulo      = " EL ALTA "
								
								
								lamatriz3(1,1)='etiqueta'
								lamatriz3(1,2)=ALLTRIM(STR(v_etiqueta))
								lamatriz3(2,1)='fechaalta'
								lamatriz3(2,2)="'"+DTOS(DATE())+"'"
								lamatriz3(3,1)='codigo'
								lamatriz3(3,2)="''"
								lamatriz3(4,1)='articulo'
								lamatriz3(4,2)="'"+ALLTRIM(articulosDatos.articulo)+"'"
								lamatriz3(5,1)='tabla'
								lamatriz3(5,2)="'articulos'"
								lamatriz3(6,1)='campo'
								lamatriz3(6,2)="'articulo'"
								lamatriz3(7,1)='idregistro'
								lamatriz3(7,2)="0"
								lamatriz3(8,1)='detalle'
								lamatriz3(8,2)="'"+ALLTRIM(articulosDatos.articulo)+"-"+alltrim(articulosDatos.detalle)+"'"
							
								
								p_tabla     = 'etiquetas'
								p_matriz    = 'lamatriz3'
								p_conexion  = vconeccionA
								IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
								    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_etiqueta )),0+48+0,"Error")
								ELSE
								
								
								
								
								
									sqlmatriz(1)=" select last_insert_id() as maxid "
									verror=sqlrun(vconeccionF,"ultimoId")
									IF verror=.f.  
									    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
										=abreycierracon(vconeccionF,"")	
									   
									ENDIF 
									SELECT ultimoId
									GO TOP 
									v_etiqueta = VAL(ultimoId.maxid)
									USE IN ultimoId
								
									IF v_primerEti = 0
										v_primerEti = v_etiqueta
									ENDIF 
									v_ultimaEti = v_etiqueta
															
															
															
															
									*** Creo Asociación Etiqueta - AjusteStockH
									*	v_idajustestocke = maxnumeroidx("idajustestocke","I","ajustestocke",1)
										v_idajustestocke = 0
									p_tipoope     = 'I'
									p_condicion   = ''
									v_titulo      = " EL ALTA "
									
									DIMENSION lamatriz4(3,2)
									
									lamatriz4(1,1)='idajustestocke'
									lamatriz4(1,2)=ALLTRIM(STR(v_idajustestocke ))
									lamatriz4(2,1)='idajusteh'
									lamatriz4(2,2)=ALLTRIM(STR(v_idajusteh))
									lamatriz4(3,1)='etiqueta'
									lamatriz4(3,2)=ALLTRIM(STR(v_etiqueta))
									

									p_tabla     = 'ajustestocke'
									p_matriz    = 'lamatriz4'
									p_conexion  = vconeccionF
									IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
									    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajustestocke)),0+48+0,"Error")
																		
									ENDIF 
								ENDIF 
								
								indice = indice+1
								
							ENDDO 
							
							
												
						ENDIF 
					ENDIF						
					
				ENDIF

				SELECT articulosDatos
				SKIP 1
				
			ENDDO
			IF v_generaEtiqueta = 'S'
				** IMPRIMIR ETIQUETA **
				v_sino = MESSAGEBOX("¿Desea Imprimir las etiquetas de Materiales generadas?",4+32+0,"Imprimir etiqueta")
				
				IF v_sino = 6 then
																					
					printetiquetas("",v_primerEti,v_ultimaEti,_SYSBCQR)
				
				ENDIF 			
			ENDIF 

				
			
		ELSE
		=abreycierracon(vconeccionA,"")
			RETURN .F.
		ENDIF 
	ELSE
	=abreycierracon(vconeccionA,"")
		RETURN .F.
		
	ENDIF 
	

ELSE
=abreycierracon(vconeccionA,"")
	RETURN .F.

ENDIF 
=abreycierracon(vconeccionA,"")
	RETURN .T.
ENDFUNC 








FUNCTION AjusteMatComprobanteProv
PARAMETERS p_idtipomov, p_idcomproba,p_nombreCampo,p_idregistro,p_tablaDatos
*#/----------------------------------------
**** FUNCIÓN PARA GENERAR AJUSTES de MATERIALES DE UN COMPROBANTE de PROVEEDOR
** PARAMETROS: 	P_idtipomov: ID de la tabla tipomstock (Indica el tipo de ajuste a realizar)
***				P_idcomproba: ID de la tabla comprobante (comprobante relacionado al ajuste)
***				P_nomreCampo: Nombre del campo Indice de la tabla asociada al comprobante
***				P_Idregistro: ID de la tabla asociada al comprobante
***				P_TablaDatos: Tabla con los articulos a los que se le hará el ajuste, tiene el siguiente formato: [articulo C(50),cantidad Y,deposito I]
**RETORNO:		.T. o .F. Dependiendo si se realizó el ajuste correctamente o no respectivamente
*#/----------------------------------------

v_idtipomov		= p_idtipomov
v_idcomproba	= p_idcomproba
v_nombreCampo	= p_nombreCampo
v_idregistro	= p_idregistro
v_tablaDatos	= p_tablaDatos


SELECT &v_tablaDatos
GO TOP 



	**** Busco el comprobante asociado ***
	vconeccionA=abreycierracon(0,_SYSSCHEMA)	
		

	*** Busco los comprobantes y sus respectivos puntos de venta 
	sqlmatriz(1)=" Select c.idcomproba, c.comprobante as nomcomp, c.idtipocompro, c.tipo, c.ctacte, c.tabla "
	sqlmatriz(2)="  from comprobantes c "
	*sqlmatriz(1)=" Select c.* from comprobantes c "
	verror=sqlrun(vconeccionA,"Comprobantes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de comprobantes ",0+48+0,"Error")
	    =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF


IF v_idregistro	> 0

	SELECT * FROM comprobantes_sql WHERE idcomproba = v_idcomproba INTO TABLE compSelecc
	
	SELECT compSelecc
	GO TOP 
	
	v_tabla	= compSelecc.tabla
	v_nombreComp	= compSelecc.nomcomp
	
	*** Busco el comprobante asociado
	sqlmatriz(1)=" select * from "+ALLTRIM(v_tabla)+" c  "
	sqlmatriz(2)=" where c."+ALLTRIM(v_nombreCampo)+" = "+ALLTRIM(STR(v_idregistro))
	
	verror=sqlrun(vconeccionA,"Comprobante_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del comprobante asociado ",0+48+0,"Error")
	     =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF
	

	SELECT comprobante_sql
	GO TOP 
	v_entidad	= Comprobante_sql.entidad
	v_nombre	= Comprobante_sql.nombre
	v_puntovA 	= STRTRAN(STR((Comprobante_sql.actividad),4,0)," ","0")
	v_numComp	= comprobante_sql.numero
	v_observa1	= "Comprobante asociado: "+ALLTRIM(v_nombreComp)+" "+ALLTRIM(v_puntoVA)+" - "+ ALLTRIM(STRTRAN(STR(v_numComp,8,0)," ","0"))
	


	*** Busco el comprobante de ajuste para el punto de venta asociado al comprobante
*	v_pventaC	= comprobante_sql.pventa
	
ELSE 

	v_entidad	= INT(VAL(SUBSTR(_SYSCIERRESTM,9)))
	
	*** Busco la Entidad o Nombre de Empresa asociado
	sqlmatriz(1)=" select * from entidades "
	sqlmatriz(2)=" where entidad = "+ALLTRIM(STR(v_entidad))

	verror=sqlrun(vconeccionA,"entidad_sel")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  Entidad para Ajuste ",0+48+0,"Error")
	     =abreycierracon(vconeccionA,"")
	    RETURN .F.
	ENDIF
	SELECT entidad_sel
	GO TOP 
	IF !EOF() THEN 
		v_nombre	= ALLTRIM(entidad_sel.apellido) +" "+ ALLTRIM(entidad_sel.nombre) +" "+ ALLTRIM(entidad_sel.compania)
	ELSE 
		v_nombre	= "CIERRE DE STOCK Y PUESTA A 0 "		
	ENDIF 
	USE IN entidad_sel
	
	v_puntovA	= 0
	v_numComp	= 0
	v_observa1	= "Cierre de Stock al "+SUBSTR(&v_tablaDatos..fecha,7,2)+"/"+SUBSTR(&v_tablaDatos..fecha,5,2)+"/"+SUBSTR(&v_tablaDatos..fecha,1,4)

ENDIF 	

	SELECT * FROM comprobantes_Sql WHERE tabla = 'otmovistockp' INTO TABLE compAjusteAso
	
	SELECT compAjusteAso 
	GO TOP 
	v_idcomprobaAs= compAjusteAso.idcomproba


	v_idmovip 	= maxnumeroidx("idmovip","I","otmovistockp",1)
	
	*v_numero 	= maxnumerocom(v_idcomprobaAs, 0,1)
	
	v_fecha		= &v_tablaDatos..fecha
	
*!*		SELECT comprobante_sql
*!*		GO TOP 
*!*		v_entidad	= Comprobante_sql.entidad
*!*		v_nombre	= Comprobante_sql.nombre
*!*	*	v_puntov	= comprobante_sql.puntov
*!*		v_puntovA 	= STRTRAN(STR((Comprobante_sql.actividad),4,0)," ","0")
*!*		v_numComp	= comprobante_sql.numero
*!*		v_observa1	= "Comprobante asociado: "+ALLTRIM(v_nombreComp)+" "+ALLTRIM(v_puntoVA)+" - "+ ALLTRIM(STRTRAN(STR(v_numComp,8,0)," ","0"))

	DIMENSION lamatriz1(12,2)

		
	lamatriz1(1,1)='idmovip'
	lamatriz1(1,2)= ALLTRIM(STR(v_idmovip))
	lamatriz1(2,1)='fecha'
	lamatriz1(2,2)="'"+ALLTRIM(v_fecha)+"'"
	lamatriz1(3,1)='fechacarga'
	lamatriz1(3,2)="'"+ALLTRIM(v_fecha)+"'"
	lamatriz1(4,1)='entidad'
	lamatriz1(4,2)=ALLTRIM(STR(v_entidad))
	lamatriz1(5,1)='nombre'
	lamatriz1(5,2)="'"+ALLTRIM(v_nombre)+"'"
	lamatriz1(6,1)='responsa'
	lamatriz1(6,2)="'"+ALLTRIM(_SYSUSUARIO)+"'"
	lamatriz1(7,1)='observa1'
	lamatriz1(7,2)="'"+ALLTRIM(v_observa1)+"'"
	lamatriz1(8,1)='observa2'
	lamatriz1(8,2)="''"
	lamatriz1(9,1)='observa3'
	lamatriz1(9,2)="''"
	lamatriz1(10,1)='observa4'
	lamatriz1(10,2)="''"
	lamatriz1(11,1)='procli'
	lamatriz1(11,2)= "0"
	lamatriz1(12,1)='idtipomov'
	lamatriz1(12,2)=ALLTRIM(STR(v_idtipomov))


	p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
	
	p_tabla     = 'otmovistockp'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionA
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajuste)),0+48+0,"Error")
	    =abreycierracon(vconeccionA,"")
		    RETURN .F.
	ENDIF  




	*** INSERTO DETALLE ***			


	*** ELIMINO HIJOS PARA NO TENER PROBLEMAS DE ACTUALIZACION ***
	sqlmatriz(1)="DELETE FROM otmovistockh WHERE idmovip = " + ALLTRIM(STR(v_idmovip))
	verror=sqlrun(vconeccionA,"control1")



	sqlmatriz(1)=" Select * from tipomstock where idtipomov = "+ALLTRIM(STR(v_idtipomov))

	verror=sqlrun(vconeccionA,"tipomstock_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de tipo de movimiento de stock ",0+48+0,"Error")
		   
	ENDIF

	SELECT tipomstock_sql
	GO TOP 
	
	v_descmovStock	= tipomstock_sql.descmov
	v_generaEtiqueta = tipomstock_sql.generaeti
		
	
	SELECT &v_tablaDatos
	GO TOP 

	IF NOT EOF()
		
		*** Busco el comprobante asociado
		sqlmatriz(1)=" select * from otmateriales "
			
		verror=sqlrun(vconeccionA,"materiales_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de materiales ",0+48+0,"Error")
		     =abreycierracon(vconeccionA,"")
		    RETURN .F.
		ENDIF


		SELECT materiales_sql
		GO TOP 
		
		IF NOT EOF()
*			SELECT t.*,a.detalle FROM &v_tablaDatos t LEFT JOIN materiales_sql a ON t.idmate = a.idmate INTO TABLE materialesDatos
			SELECT a.*,t.articulo,t.cantidad,t.deposito FROM &v_tablaDatos t LEFT JOIN materiales_sql a ON ALLTRIM(t.articulo) == ALLTRIM(a.codigomat) INTO TABLE materialesDatos
			v_primerEti = 0
			v_ultimaEti = 0
			SELECT materialesDatos
			GO TOP 

			DO WHILE NOT EOF()
				IF !EMPTY(ALLTRIM(materialesDatos.codigomat)) AND materialesDatos.cantidad > 0 THEN 
					p_tipoope     = 'I'
					p_condicion   = ''
						v_titulo      = " EL ALTA "
					
					DIMENSION lamatriz2(14,2)
					
					*thisform.calcularmaxh
					v_idmovih = maxnumeroidx("idmovih","I","otmovistockh",1)
					
					lamatriz2(1,1)='idmovih'
					lamatriz2(1,2)=ALLTRIM(STR(v_idmovih))
					lamatriz2(2,1)='idmovip'
					lamatriz2(2,2)=ALLTRIM(STR(v_idmovip))
					lamatriz2(3,1)='fecha'
					lamatriz2(3,2)="'"+ALLTRIM(v_fecha)+"'"
					lamatriz2(4,1)='idmate'
					lamatriz2(4,2)=ALLTRIM(STR(materialesDatos.idmate))
					lamatriz2(5,1)='codigomat'
					lamatriz2(5,2)="'"+alltrim(materialesDatos.codigomat)+"'"
					lamatriz2(6,1)='descrip'
					lamatriz2(6,2)="'"+alltrim(materialesDatos.detalle)+"'"
					lamatriz2(7,1)='idtipomov'
					lamatriz2(7,2)=alltrim(STR(v_idtipomov))
					lamatriz2(8,1)='descmov'
					lamatriz2(8,2)="'"+alltrim(v_descmovStock)+"'"
					lamatriz2(9,1)='cantidad'
					lamatriz2(9,2)=alltrim(STR(materialesDatos.cantidad,10,2))
					lamatriz2(10,1)='impuni'
					lamatriz2(10,2)="0"
					lamatriz2(11,1)='imptotal'
					lamatriz2(11,2)="0"
					lamatriz2(12,1)='cantm2'
					lamatriz2(12,2)=alltrim(STR(materialesDatos.cantidad,10,2))
					lamatriz2(13,1)='iddepo'
					lamatriz2(13,2)= ALLTRIM(STR(materialesDatos.deposito))
					lamatriz2(14,1)='unidad'
					lamatriz2(14,2)="'"+alltrim(materialesDatos.unidad)+"'"

					p_tabla     = 'otmovistockh'
					
					
					p_matriz    = 'lamatriz2'
					p_conexion  = vconeccionA
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajusteh )),0+48+0,"Error")
					ELSE
					
					*** Creo y asocio la ETIQUETA si el movimiento requiere de etiquetas
						IF v_generaEtiqueta = 'S'
							** CREO Etiqueta ***
								v_cantEti		= VAL(STR(materialesDatos.cantidad,10,2))
								indice = 1
			*!*					FOR i = 1 TO 20 STEP 1
							
							DO WHILE indice <= v_cantEti
							
							*	v_etiqueta = maxnumeroidx("etiqueta","I","etiquetas",1)
							
							
							
							v_idmate = 0
							*** Busco el idmate según el codigo de material **
							sqlmatriz(1)=" Select * "
							sqlmatriz(2)="  from otmateriales m  "
							sqlmatriz(3)=" where codigomat = '"+ALLTRIM(materialesDatos.articulo)+"'"
							*sqlmatriz(1)=" Select c.* from comprobantes c "
							verror=sqlrun(vconeccionA,"material_sql")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del Material. No se guardó la etiqueta para el material "+ALLTRIM(materialesDatos.articulo)+"-"+alltrim(materialesDatos.detalle),0+48+0,"Error")
								  v_idmate = 0
							ELSE
								v_idmate = material_sql.idmate
								DIMENSION lamatriz3(8,2)
								v_etiqueta = 0
								
								p_tipoope     = 'I'
								p_condicion   = ''
								v_titulo      = " EL ALTA "
								
								
								lamatriz3(1,1)='etiqueta'
								lamatriz3(1,2)=ALLTRIM(STR(v_etiqueta))
								lamatriz3(2,1)='fechaalta'
								lamatriz3(2,2)="'"+DTOS(DATE())+"'"
								lamatriz3(3,1)='codigo'
								lamatriz3(3,2)="''"
								lamatriz3(4,1)='articulo'
								lamatriz3(4,2)="''"
								lamatriz3(5,1)='tabla'
								lamatriz3(5,2)="'otmateriales'"
								lamatriz3(6,1)='campo'
								lamatriz3(6,2)="'idmate'"
								lamatriz3(7,1)='idregistro'
								lamatriz3(7,2)=ALLTRIM(STR(v_idmate))
								lamatriz3(8,1)='detalle'
								lamatriz3(8,2)="'"+ALLTRIM(materialesDatos.articulo)+"-"+alltrim(materialesDatos.detalle)+"'"
							
								
								p_tabla     = 'etiquetas'
								p_matriz    = 'lamatriz3'
								p_conexion  = vconeccionA
								IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
								    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_etiqueta )),0+48+0,"Error")
								ELSE
								
								
										sqlmatriz(1)=" select last_insert_id() as maxid "
									verror=sqlrun(vconeccionA,"ultimoId")
									IF verror=.f.  
									    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
										=abreycierracon(vconeccionA,"")	
									   
									ENDIF 
									SELECT ultimoId
									GO TOP 
									v_etiqueta = VAL(ultimoId.maxid)
									USE IN ultimoId
								
									IF v_primerEti = 0
										v_primerEti = v_etiqueta
									ENDIF 
									v_ultimaEti = v_etiqueta

								
							
								
								
									*** Creo Asociación Etiqueta - AjusteStockH
										*v_idajustestocke = maxnumeroidx("idajustestocke","I","ajustestocke",1)
										v_idotmovie = 0
									
									p_tipoope     = 'I'
									p_condicion   = ''
									v_titulo      = " EL ALTA "
									
									DIMENSION lamatriz4(3,2)
									
									lamatriz4(1,1)='idmovie'
									lamatriz4(1,2)=ALLTRIM(STR(v_idotmovie))
									lamatriz4(2,1)='idmovih'
									lamatriz4(2,2)=ALLTRIM(STR(v_idmovih))
									lamatriz4(3,1)='etiqueta'
									lamatriz4(3,2)=ALLTRIM(STR(v_etiqueta))
									

									p_tabla     = 'otmovistocke'
									p_matriz    = 'lamatriz4'
									p_conexion  = vconeccionA
									IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
									    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajustestocke)),0+48+0,"Error")
																		
									ENDIF 
								ENDIF 
							ENDIF
														
							
								indice = indice+1
								
							ENDDO 
								
						ENDIF 
					ENDIF						
					
				ENDIF

				SELECT materialesDatos
				SKIP 1
			ENDDO	
			IF v_generaEtiqueta = 'S'
				** IMPRIMIR ETIQUETA **
				v_sino = MESSAGEBOX("¿Desea Imprimir las etiquetas generadas?",4+32+0,"Imprimir etiqueta")
				
				IF v_sino = 6 then
																					
					printetiquetas("",v_primerEti,v_ultimaEti,_SYSBCQR)
				
				ENDIF 			
			ENDIF 

		ELSE
		=abreycierracon(vconeccionA,"")
			RETURN .F.
		ENDIF 
	ELSE
	=abreycierracon(vconeccionA,"")
		RETURN .F.
		
	ENDIF 
	

*!*	ELSE

*!*	=abreycierracon(vconeccionA,"")
*!*		RETURN .F.

*!*	ENDIF 
=abreycierracon(vconeccionA,"")
	RETURN .T.
ENDFUNC 


FUNCTION GenAstoContable
*#///////////////////////////////////////////////////////////////
**********************************************************************
** Funcion que devuelve el asiento modelo armado a partir de un 
** codigo o modelo de asiento**
** la funcion devuelve el nombre de la tabla con el asiento si lo pudo armar
** caso contrario devuelve vacio ""
** estructura devuelta .dbf o .txt 
**		idastomode i, codigocta c(30), debe y, haber y, tabla c(30), 
**      registro i ,fecha c(8), idfiltro i, idtipoasi i, idastoe i, idpland, codigo c(22)
*#///////////////////////////////////////////////////////////////
PARAMETERS par_modelo, par_tabla, par_registro, par_idfiltro, par_idtipoasi, par_idastoe, par_tablaret

	IF TYPE("par_idfiltro") = 'L' THEN
		vpar_idfiltro = 0
	ELSE 
		vpar_idfiltro = par_idfiltro 
	ENDIF  	
	IF TYPE("par_idtipoasi") = 'L' THEN
		vpar_idtipoasi = 0
	ELSE
		vpar_idtipoasi = par_idtipoasi		
	ENDIF  	
	IF TYPE("par_idastoe") = 'L' THEN
		vpar_idastoe = 0
	ELSE 
		vpar_idastoe = par_idastoe
	ENDIF  	
	IF TYPE("par_tablaret") = 'L' THEN
		vpar_tablaret = "asientopropuesto"
	ELSE 
		vpar_tablaret = par_tablaret
	ENDIF  	

	** correccion para registros de recibos y Ordenes de Pago
	IF ALLTRIM(par_tabla) = 'recibos' THEN
		_SQLIDRECIBO = par_registro
	ENDIF  	
	IF ALLTRIM(par_tabla) = 'pagosprov' THEN
		_SQLIDPAGO = par_registro
	ENDIF  	
	


	v_indicetabla = getIdTabla(par_tabla) && Obtengo el nombre del campo indice de la tabla
	v_fechaasi = ""
	var_retorno = ""
	**** El Modelo de Asiento Seleccionado ***
	vconeccionATO=abreycierracon(0,_SYSSCHEMA)	

** Selecciono la Fecha del Comprobante para el Asiento **
	** Campos con los Valores que deben calcular el resultado a imputar a cada cuenta ***
	sqlmatriz(1)=" Select * from astofiltros where idfiltro = "+ALLTRIM(STR(vpar_idfiltro))
	verror=sqlrun(vconeccionATO,"Astofil_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de Filtros ",0+48+0,"Error")
	    =abreycierracon(vconeccionATO,"")
	    RETURN var_retorno
	ENDIF


	sqlmatriz(1)=" Select "+ALLTRIM(Astofil_sql.campofecha)+" as fecha from "+ALLTRIM(par_tabla)+" where "+ALLTRIM(v_indicetabla)+" = "+ALLTRIM(STR(par_registro))
	verror=sqlrun(vconeccionATO,"ComproFecha_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de Filtros ",0+48+0,"Error")
	    =abreycierracon(vconeccionATO,"")
	    RETURN var_retorno
	ENDIF

	v_fechaasi = ComproFecha_sql.fecha
	
	SELECT Astofil_sql
	USE IN Astofil_sql
	SELECT ComproFecha_sql
	USE IN ComproFecha_sql

**********************************************************
	** Campos con los Valores que deben calcular el resultado a imputar a cada cuenta ***
	sqlmatriz(1)=" Select ac.idastomode, ac.idastocuenta as idastocuen, ac.idcpoconta, ac.dh, ac.detalle, "
	sqlmatriz(2)="   av.tabla, av.campo, av.opera, av.idastovalor as idastoval from astovalor av left join astocuenta ac on av.idastocuenta=ac.idastocuenta "
	sqlmatriz(3)=" where ac.idastomode = "+ALLTRIM(STR(par_modelo))
	verror=sqlrun(vconeccionATO,"AstoValorA_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de AstoCuenta ",0+48+0,"Error")
	    =abreycierracon(vconeccionATO,"")
	    RETURN var_retorno
	ENDIF




	** Obtiene los registros que daran como resultado la cuenta a la cual debera imputarse el importe correspondiente calculado arriba ** 
	sqlmatriz(1)=" Select a.idastomode, a.idastocuenta as idastocuen, a.idcpoconta, a.dh, a.detalle, "
	sqlmatriz(2)="   	  c.tabla, c.campo, c.tipo, c.detalle as detacpo,   "
	sqlmatriz(3)="   	  cg.valor1,cg.compara, cg.valor2, cg.codigocta, cg.tablag, cg.campog, cg.tipog, cg.idcpocontag as idcpocontg  "
	sqlmatriz(4)=" from campocontag cg "
	sqlmatriz(5)=" left join campoconta c on c.idcpoconta=cg.idcpoconta "
	sqlmatriz(6)=" left join astocuenta a on a.idcpoconta=cg.idcpoconta "
	sqlmatriz(7)=" where a.idastomode = "+ALLTRIM(STR(par_modelo))
	verror=sqlrun(vconeccionATO,"AstoCuentaA_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de AstoCuenta ",0+48+0,"Error")
	    =abreycierracon(vconeccionATO,"")
	    RETURN var_retorno
	ENDIF


	SELECT AstoValorA_sql

	SELECT v.idastomode, v.idastocuen, v.idcpoconta, v.dh, v.detalle, v.tabla, v.campo, v.opera, v.idastoval, ;
		c.tabla as tablaf, c.campo as campof, c.tipo, c.valor1, c.compara, c.valor2, c.codigocta, c.tablag, c.campog, c.tipog, c.idcpocontg ;
		FROM AstoValorA_sql v LEFT JOIN AstoCuentaA_SQL c ON c.idastocuen = v.idastocuen INTO TABLE AstoValorAC_sql 
		

	SELECT AstoValorAC_sql 

**********************************************
***	Armado del valor  de las cuentas a imputar 

*	SELECT * FROM AstoValorA_sql INTO TABLE .\AstoValorA
	SELECT * FROM AstoValorAC_sql INTO TABLE .\AstoValorAC
*	ALTER table AstoValorA ADD importe y
	ALTER table AstoValorAC ADD importe y
	ZAP 
	SELECT AstoValorAC_sql 

	GO TOP 



	
	DO WHILE !EOF() 
	

*		sqlmatriz(1)=" Select *, "+ALLTRIM(AstoValorA_sql.campo)+" as importe from "+ALLTRIM(AstoValorA_sql.tabla)
*		sqlmatriz(2)=" where "+v_indicetabla+"  = "+ALLTRIM(STR(par_registro))
		sqlmatriz(1)=" Select "+ALLTRIM(AstoValorAC_sql.campof)+" as valorcf, "+ALLTRIM(AstoValorAC_sql.campo)+" as importe from "+ALLTRIM(AstoValorAC_sql.tabla)
		sqlmatriz(2)=" where "+v_indicetabla+"  = "+ALLTRIM(STR(par_registro))

		verror=sqlrun(vconeccionATO,"tablacampo")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA en el Campo a Imputar de la Tabla Seleccionada ",0+48+0,"Error")
		    =abreycierracon(vconeccionATO,"")
		    RETURN var_retorno
		ENDIF

		SELECT * FROM tablacampo INTO TABLE tablacampo00 		
		
		SELECT tablacampo 
		GO top

		
		DO WHILE !EOF()
			SELECT AstoValorAC

		**decidir si incerto o no			
		*********************************			


*!*				var_valor = IIF(((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F'  or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='B') and (TYPE("tablacampo.valorcf")<>'C' )),tablacampo.valorcf,ALLTRIM(tablacampo.valorcf))  
			
			IF TYPE("tablacampo.valorcf")='C' THEN 
				var_valor = IIF(((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F'  or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='B')),VAL(tablacampo.valorcf),ALLTRIM(tablacampo.valorcf))  
			ELSE
				var_valor = IIF(((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F'  or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='B')),tablacampo.valorcf,ALLTRIM(tablacampo.valorcf))  			
			ENDIF 

			eje = " var_valor1= "+IIF((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='B'),'VAL(ALLTRIM(AstoValorAC_sql.valor1))','ALLTRIM(AstoValorAC_sql.valor1)')
			&eje 
					
			eje = " var_valor2= "+IIF((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='B'),'VAL(ALLTRIM(AstoValorAC_sql.valor2))','ALLTRIM(AstoValorAC_sql.valor2)')
			&eje 
			

			v_incerta = .f.
			DO CASE 
				CASE UPPER(AstoValorAC_sql.compara)="TODOS"
					v_incerta = .t.
				CASE UPPER(AstoValorAC_sql.compara)="ENTRE"
					IF var_valor >= var_valor1 AND var_valor <= var_valor2 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoValorAC_sql.compara)="IGUAL"
					IF var_valor = var_valor1 THEN 
						v_incerta = .t. 
					ENDIF 
				CASE UPPER(AstoValorAC_sql.compara)="MAYOR"
					IF var_valor > var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoValorAC_sql.compara)="MAYOR O IGUAL"
					IF var_valor >= var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoValorAC_sql.compara)="MENOR"
					IF var_valor < var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoValorAC_sql.compara)="MENOR O IGUAL"
					IF var_valor <= var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoValorAC_sql.compara)="DISTINTO"
					IF var_valor <> var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoValorAC_sql.compara)="GRUPO"
					var_valorgru = IIF(TYPE("var_valor")='C',var_valor,ALLTRIM(STR(var_valor)))
					

					IF GrupoCuentaContable (var_valorgru,AstoValorAC_sql.tablag,AstoValorAC_sql.campog,AstoValorAC_sql.tipog,AstoValorAC_sql.valor1, vconeccionATO) THEN 
						v_incerta = .t.
					ENDIF 

					
			ENDCASE 
			
			IF v_incerta = .t. THEN 
				SELECT AstoValorAC
		
				INSERT INTO AstoValorAC VALUES (AstoValorAC_sql.idastomode, AstoValorAC_sql.idastocuen, AstoValorAC_sql.idcpoconta, AstoValorAC_sql.dh, AstoValorAC_sql.detalle, ;
							AstoValorAC_sql.tabla, AstoValorAC_sql.campo, AstoValorAC_sql.opera, AstoValorAC_sql.idastoval, AstoValorAC_sql.tablaf, AstoValorAC_sql.campof, ;
							AstoValorAC_sql.tipo, AstoValorAC_sql.valor1, AstoValorAC_sql.compara, AstoValorAC_sql.valor2, AstoValorAC_sql.codigocta, AstoValorAC_sql.tablag, ;
							AstoValorAC_sql.tipog, AstoValorAC_sql.tipog, AstoValorAC_sql.idcpocontg, tablacampo.importe)

			ENDIF 

			
			SELECT tablacampo 
			SKIP 
		ENDDO 

			
		SELECT AstoValorAC_sql
		SKIP 
	ENDDO 

	SELECT AstoValorAC

	REPLACE ALL importe WITH importe * opera 
	
*****************************************************************
***** Agrupo para obtener el monto final a imputar a cada cuenta
	SET ENGINEBEHAVIOR 70 
	 
	SELECT idastomode, idastocuen, idcpoconta, dh, detalle, SUM(importe) as importe, codigocta ;
		FROM AstoValorAC INTO TABLE AstoValorB ORDER BY idastocuen GROUP BY idastocuen
	
	SET ENGINEBEHAVIOR 90 
	
	SELECT AstoValorB


	
*************************************************************************
** Obtengo el la Cuenta que se deberá imputar ***************************
	SELECT * FROM AstoCuentaA_sql INTO TABLE .\AstoCuentaA
	ALTER table AstoCuentaA ADD valor c(100)
	ALTER table AstoCuentaA ADD idpland i
	ALTER table AstoCuentaA ADD codigo c(22)
	ALTER table AstoCuentaA ADD nombrecta c(100)
	ZAP 
	INDEX on ALLTRIM(codigocta) TAG codigocta 
	SET ORDER TO codigocta 
	SELECT AstoCuentaA_sql 
	GO TOP 


	DO WHILE !EOF() 
		
		sqlmatriz(1)=" Select "+ALLTRIM(AstoCuentaA_sql.campo)+" as valor from "+ALLTRIM(AstoCuentaA_sql.tabla)
		sqlmatriz(2)=" where "+v_indicetabla+"  = "+ALLTRIM(STR(par_registro))
		verror=sqlrun(vconeccionATO,"tablacuenta0")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la Cuenta Seleccionada ",0+48+0,"Error")
		    =abreycierracon(vconeccionATO,"")
		    RETURN var_retorno
		ENDIF

		SELECT * FROM tablacuenta0 INTO TABLE .\tablacuenta
		SELECT tablacuenta
		
		GO top
		
		DO WHILE !EOF()


*!*				var_valor = IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='B'),tablacuenta.valor,ALLTRIM(tablacuenta.valor))  
			IF TYPE("tablacuenta.valor")='C' THEN 
				var_valor = IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='B'),VAL(tablacuenta.valor),ALLTRIM(tablacuenta.valor))  
			ELSE
				var_valor = IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='B'),tablacuenta.valor,ALLTRIM(tablacuenta.valor))  
			ENDIF 


			eje = " var_valor1= "+IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='B'),'VAL(ALLTRIM(AstoCuentaA_sql.valor1))','ALLTRIM(AstoCuentaA_sql.valor1)')
			&eje 
					
			eje = " var_valor2= "+IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='B'),'VAL(ALLTRIM(AstoCuentaA_sql.valor2))','ALLTRIM(AstoCuentaA_sql.valor2)')
			&eje 


			v_incerta = .f.
			DO CASE 
				CASE UPPER(AstoCuentaA_sql.compara)="TODOS"
					v_incerta = .t.
				CASE UPPER(AstoCuentaA_sql.compara)="ENTRE"
					IF var_valor >= var_valor1 AND var_valor <= var_valor2 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="IGUAL"
					IF var_valor = var_valor1 THEN 
						v_incerta = .t. 
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MAYOR"
					IF var_valor > var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MAYOR O IGUAL"
					IF var_valor >= var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MENOR"
					IF var_valor < var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MENOR O IGUAL"
					IF var_valor <= var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="DISTINTO"
					IF var_valor <> var_valor1 THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="GRUPO"
					var_valorgru = IIF(TYPE("var_valor")='C',var_valor,ALLTRIM(STR(var_valor)))
					IF GrupoCuentaContable (var_valorgru,AstoCuentaA_sql.tablag,AstoCuentaA_sql.campog,AstoCuentaA_sql.tipog,AstoCuentaA_sql.valor1, vconeccionATO) THEN 
						v_incerta = .t.
					ENDIF 

			ENDCASE 

			
			SELECT AstoCuentaA
			IF v_incerta = .t. THEN 

				var_valorinc = IIF(TYPE("var_valor")='C',var_valor,ALLTRIM(STR(var_valor)))
				
				sqlmatriz(1)=" Select idpland, codigo, nombrecta from plancuentasd where idplan = "+str(_SYSIDPLAN)+" and codigocta = '"+ALLTRIM(AstoCuentaA_sql.codigocta)+"'"
				verror=sqlrun(vconeccionATO,"idpland_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del IDPLAN de la Cuenta del Asiento ",0+48+0,"Error")
				    =abreycierracon(vconeccionATO,"")
				    RETURN var_retorno
				ENDIF
				SELECT idpland_sql
				IF !EOF() THEN 
					var_idpland = idpland_sql.idpland 
					var_codigo	= idpland_sql.codigo
					var_nombrecta=idpland_sql.nombrecta

					SELECT AstoCuentaA
					IF !SEEK(AstoCuentaA_sql.codigocta) THEN &&** AGREGADO PARA VERIFICAR QUE YA NO HAYA INGRESADO LA CUENTA **

					
						INSERT INTO AstoCuentaA VALUES (AstoCuentaA_sql.idastomode, AstoCuentaA_sql.idastocuen, AstoCuentaA_sql.idcpoconta, AstoCuentaA_sql.dh, ;
										   AstoCuentaA_sql.detalle, AstoCuentaA_sql.tabla, AstoCuentaA_sql.campo, AstoCuentaA_sql.tipo, ;
										   AstoCuentaA_sql.detacpo, AstoCuentaA_sql.valor1, AstoCuentaA_sql.compara, AstoCuentaA_sql.valor2, ;
										   AstoCuentaA_sql.codigocta, AstoCuentaA_sql.tablag, AstoCuentaA_sql.campog, AstoCuentaA_sql.tipog, ;
										   AstoCuentaA_sql.idcpocontg,var_valorinc,var_idpland,var_codigo,var_nombrecta)
					ENDIF 

				ENDIF 
				SELECT idpland_sql
				USE IN idpland_sql 
			ENDIF 
			SELECT tablacuenta
			SKIP 
		ENDDO 
				
		SELECT AstoCuentaA_sql
		SKIP 
		
	ENDDO 


** Aqui Obtengo la Cuenta en la que debo utilizar el redondeo si es necesario
** Variable agregada con cuenta para Ajuste de Redondeos en Asientos contables 
**  _SYSCONTACTAREDO = [CUENTA;MARGEN] 99.99.99.99.99;0.01' ******
	
	vr_codigocta_redo = ""
	vr_redondeo_redo  = 0.00
	vr_idpland_redo   = _SYSIDPLAN
	vr_codigo_redo	  = ""
	vr_nombrecta_redo = ""
	
	IF TYPE("_SYSCONTAJUSTE")="C" THEN 
		IF !EMPTY(_SYSCONTAJUSTE) THEN 
		
			vr_codigocta_redo = SUBSTR(STRTRAN(SUBSTR(_SYSCONTAJUSTE,1,AT(';',_SYSCONTAJUSTE)-1),'.','')+'000000000000000000',1,18)
			vr_redondeo_redo  = VAL(SUBSTR(_SYSCONTAJUSTE,AT(';',_SYSCONTAJUSTE)+1))
			
			sqlmatriz(1)=" Select idpland, codigo, nombrecta from plancuentasd where idplan = "+str(_SYSIDPLAN)+" and codigocta = '"+ALLTRIM(vr_codigocta_redo)+"'"
			verror=sqlrun(vconeccionATO,"idpland_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del IDPLAN de la Cuenta del Asiento ",0+48+0,"Error")
			    =abreycierracon(vconeccionATO,"")
			    RETURN var_retorno
			ENDIF
			SELECT idpland_sql
			IF !EOF() THEN 
				vr_idpland_redo   = idpland_sql.idpland 
				vr_codigo_redo	  = idpland_sql.codigo
				vr_nombrecta_redo = idpland_sql.nombrecta
			ENDIF 
			USE IN idpland_sql 
			
		ENDIF 
	ENDIF 
*************************************************************************




	 =abreycierracon(vconeccionATO,"")
	 
	 SELECT AstoCuentaA
	 SET ORDER TO 


	 GO TOP 

	 ************* Union de las dos partes que componen el Asiento, ************************************
	 ************* Se Unen el Valor o Importe a Imputar con la Cuenta que recibe la Imputación *********

	 SELECT AVB.idastomode, AVB.idastocuen, AVB.idcpoconta, AVB.dh, AVB.detalle, AVB.importe ,AVB.importe as debe ,AVB.importe as haber , ;
	 		 ACA.codigocta, ACA.valor, ACA.idcpocontg, SPACE(50) as tabla, 10000000000 as registro, '        ' as fecha, ;
	 		 10000000000 as idfiltro, 10000000000 as idtipoasi, 10000000000 as idastoe, ACA.idpland, ACA.codigo, ACA.nombrecta   ;
	 FROM  AstoValorB AVB left join AstoCuentaA ACA on ALLTRIM(AVB.codigocta) = ALLTRIM(ACA.codigocta) ;
	 INTO TABLE AstoFinalA WHERE !ISNULL(ACA.idcpocontg)
*	 FROM  AstoValorB AVB left join AstoCuentaA ACA on AVB.idastocuen = ACA.idastocuen 
	 
	 SELECT AstoFinalA
	 GO TOP 
	 replace ALL debe WITH IIF((((dh='D' AND importe > 0) OR (dh='H' AND importe < 0 ))),ABS(importe),0), haber WITH IIF((((dh='H' AND importe > 0) OR (dh='D' AND importe < 0))),ABS(importe),0), ;
	 			tabla WITH par_tabla, registro WITH par_registro, idfiltro WITH vpar_idfiltro, idtipoasi WITH vpar_idtipoasi, idastoe WITH vpar_idastoe, fecha WITH v_fechaasi

*	 SELECT  idastomode, codigocta, debe, haber, tabla, registro, fecha , idfiltro, idtipoasi, idastoe, idpland, codigo, nombrecta FROM AstoFinalA INTO TABLE &vpar_tablaret 
	 SET ENGINEBEHAVIOR 70
	 
	 SELECT  idastomode, codigocta, SUM(debe) as debe, SUM(haber) as haber, SUM(debe-haber) as deoha, tabla, registro, fecha , idfiltro, idtipoasi, idastoe, idpland, codigo, nombrecta ;
	 FROM AstoFinalA INTO TABLE AstoFinalA0 GROUP BY idpland
	 
	 SET ENGINEBEHAVIOR 90
	 
	 SELECT AstoFinalA0 
	 replace ALL debe WITH IIF(deoha >= 0, deoha, 0.00 ), haber WITH IIF(deoha <= 0, -deoha, 0.00 )
	 CALCULATE SUM(debe-haber) TO vdif_debehaber 
	 
** Aqui debo intentar balancear el Asiento si hay diferencia de Redondeo
** Variable agregada con cuenta para Ajuste de Redondeos en Asientos contables 
**  _SYSCONTACTAREDO = [CUENTA;MARGEN] 99.99.99.99.99;0.01' ******
	IF 	vr_redondeo_redo  <> 0.00 AND vdif_debehaber <> 0 THEN  && si hay establecida tolerancia  y hay diferencia
		IF ABS(vdif_debehaber) <= vr_redondeo_redo THEN  && si la diferencia es menor o igual que la tolerancia 
		
			IF vdif_debehaber > 0 THEN 
				vr_haber = ABS(vdif_debehaber)
				vr_debe  = 0.00 
			ELSE
				vr_haber = 0.00
				vr_debe  = ABS(vdif_debehaber)
			ENDIF 
			SELECT AstoFinalA0
			vr_idastomode = AstoFinalA0.idastomode
			vr_tabla	  = AstoFinalA0.tabla
			vr_idfiltro	  = AstoFinalA0.idfiltro
			vr_idtipoasi  = AstoFinalA0.idtipoasi
			vr_fecha  	  = AstoFinalA0.fecha
			vr_registro	  = AstoFinalA0.registro
			vr_idastoe	  = AstoFinalA0.idastoe
			
			* inserto el registro con los datos de ajustes de tolerancia 
 			INSERT INTO AstoFinalA0 VALUES (vr_idastomode, vr_codigocta_redo, vr_debe , vr_haber ,0.00 , vr_tabla, vr_registro, vr_fecha , vr_idfiltro, vr_idtipoasi, vr_idastoe, vr_idpland_redo, vr_codigo_redo, vr_nombrecta_redo )
		
		ENDIF 
	ENDIF 
*************************************************************************
	 SELECT  idastomode, codigocta, debe, haber, tabla, registro, fecha , idfiltro, idtipoasi, idastoe, idpland, codigo, nombrecta ;
	 FROM AstoFinalA0 WHERE ( debe + haber ) <> 0 INTO TABLE &vpar_tablaret 
	
	 SELECT &vpar_tablaret 
	 
	 COPY TO &vpar_tablaret DELIMITED WITH ""
	
	 USE IN AstoCuentaA_sql
	 USE IN AstoValorAC_sql
	 USE IN AstoCuentaA
	 USE IN AstoValorAC
	 USE IN AstoValorB
	 USE IN AstoFinalA
	 USE IN tablacuenta
	 USE IN tablacampo

	 SELECT &vpar_tablaret 
	 GO TOP 
	 IF !EOF() THEN 
	 	var_retorno = vpar_tablaret 	 
	 ENDIF 
	 USE IN &vpar_tablaret 
*	 var_retorno = vpar_tablaret 	 
	 RETURN var_retorno 
	
ENDFUNC 

FUNCTION GrupoCuentaContable 
*#////////////////////////////////////////////////////
* Función que devuelve verdadero o falso segun sea
* segun sea que el indice del registro  pasado como parámetro pertenezca o no al grupo asociado a la cuenta
* contable que se debiera utilizar en el asiento modelo.
*#/**********************************************************
PARAMETERS pg_valor, pg_tablag, pg_campog, pg_tipog, pg_valor1, pg_vconeccion
	vpertenece = .f. 
	
	
	*var_pg_valorg = IIF((UPPER(SUBSTR(pg_tipog,1,1))='I' or UPPER(SUBSTR(pg_tipog,1,1))='D' or UPPER(SUBSTR(pg_tipog,1,1))='F'),ALLTRIM(STR(pg_valor,12,2)),"'"+ALLTRIM(pg_valor)+"'")	
	var_pg_valorg = IIF((UPPER(SUBSTR(pg_tipog,1,1))='I' or UPPER(SUBSTR(pg_tipog,1,1))='D' or UPPER(SUBSTR(pg_tipog,1,1))='F'),ALLTRIM(pg_valor),"'"+ALLTRIM(pg_valor)+"'")	


		
	sqlmatriz(1)=" Select * from "+ALLTRIM(pg_tablag)+" where "+pg_campog+" = "+var_pg_valorg
	verror=sqlrun(pg_vconeccion,"registro_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Campo a Seleccionar en la Tabla: "+var_pg_valorg+";"+pg_tablag+";"+pg_campog+";"+pg_tipog+";"+pg_valor1,0+48+0,"Error")
	    RETURN vpertenece
	ENDIF
	
	SELECT registro_sql
	IF EOF() THEN 
		USE IN registro_sql 
		RETURN vpertenece
	ELSE	
		v_campoidxg = ""
		v_tipoidxg  = ""
		FOR i = 1 TO toolbargrupos.pageAyuda.grupos.GruposTree.Nodes.Count 
				
			IF toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("idgrupo")) = val(alltrim(pg_valor1)) AND toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("tiporeg")) = "G" THEN 
				v_campoidxg = toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("campo"))
				v_tipoidxg  = toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("tipoc"))
				EXIT 
			ENDIF 
		ENDFOR 
		
		IF !EMPTY(v_campoidxg) THEN 
			
			v_idmiembrog = ""	
			eje = "v_idmiembroa = registro_sql."+ALLTRIM(v_campoidxg)
					
			&eje
			v_idmiembrog = IIF(ALLTRIM(v_tipoidxg)='I',ALLTRIM(STR(v_idmiembroa)),ALLTRIM(v_idmiembroa))
			
			FOR i = 1 TO toolbargrupos.pageAyuda.grupos.GruposTree.Nodes.Count 
						
				IF  toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("tabla"))= alltrim(pg_tablag) AND ;
					toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("idgrupo"))= val(alltrim(pg_valor1)) AND ;
					ALLTRIM(toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("idmiembro")))== ALLTRIM(v_idmiembrog) AND ;					
					toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("tiporeg")) = "M" THEN 

					
					vpertenece = .t. 
					EXIT 			
				ENDIF 
			ENDFOR 

		ENDIF 
		
	ENDIF 
	USE IN registro_sql
	RETURN vpertenece
ENDFUNC 


FUNCTION FiltroAstoModelo 
*#//////////////////////////////////////
*/ Determina el Filtro y Modelo de Asiento a aplicar en funcion
*/ del filtrado que aplica al comprobante recibido como parametros
*#//////////////////////////////////////
PARAMETERS pf_tabla, pf_idregi, pf_vconeccion
	
	pf_campoid = getIdTabla(pf_tabla) && Obtengo el nombre del campo indice de la tabla
	
	pf_cierraconex = .f.
	IF pf_vconeccion = 0 THEN 
		**** El Modelo de Asiento Seleccionado ***
		pf_vconeccion=abreycierracon(0,_SYSSCHEMA)	
		pf_cierraconex = .t.
	ENDIF 

	ret_modelo = ''
	var_pf_idregi = IIF((UPPER(type("pf_idregi"))='I' or UPPER(type("pf_idregi"))='N'),ALLTRIM(STR(pf_idregi)),"'"+ALLTRIM(pf_idregi)+"'")	
	
	sqlmatriz(1)=" Select * from "+ALLTRIM(pf_tabla)+" where "+pf_campoid+" = "+var_pf_idregi
	verror=sqlrun(pf_vconeccion,"registrof_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Registro en la Tabla: "+var_pf_idregi+";"+pf_tabla+";"+pf_campoid,0+48+0,"Error")
	    RETURN ret_modelo
	ENDIF
	
	SELECT registrof_sql
	
	IF EOF() THEN 
		USE IN registrof_sql 
		RETURN ret_modelo
	ELSE	
		*///////////////////
		*/Aca calculo la coincidencia con los filtros definidos para la tabla pasada*//
		*/ y el registro encontrado */**************
		*///////////////////
		
		sqlmatriz(1)=" Select d.*, f.tabla as tablaf, f.idastomode, f.campofecha as campofecha " 
		sqlmatriz(2)="   from astofiltrosd d left join astofiltros f on f.idfiltro = d.idfiltro "	
		sqlmatriz(3)="   where f.tabla = '"+ALLTRIM(pf_tabla)+"' order by f.idfiltro"
		verror=sqlrun(pf_vconeccion,"filtros_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Registro en la Tabla: "+var_pf_idregi+";"+pf_tabla+";"+pf_campoid,0+48+0,"Error")
		    RETURN ret_modelo
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
					eje = " var_valor = registrof_sql."+ALLTRIM(filtros.campo)
					&eje
					eje = " var_valord= "+IIF((UPPER(SUBSTR(filtros.tipo,1,1))='I' or UPPER(SUBSTR(filtros.tipo,1,1))='D' or UPPER(SUBSTR(filtros.tipo,1,1))='F'),'VAL(ALLTRIM(filtros.valord))','ALLTRIM(filtros.valord)')
					&eje 
					eje = " var_valorh= "+IIF((UPPER(SUBSTR(filtros.tipo,1,1))='I' or UPPER(SUBSTR(filtros.tipo,1,1))='D' or UPPER(SUBSTR(filtros.tipo,1,1))='F'),'VAL(ALLTRIM(filtros.valorh))','ALLTRIM(filtros.valorh)')
					&eje 

				DO CASE 
					CASE UPPER(filtros.compara)="TODOS"
						v_cumple = 1
					CASE UPPER(filtros.compara)="ENTRE"
						IF  var_valor >= var_valord AND var_valor <= var_valorh THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="IGUAL"
						IF var_valor = var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MAYOR"
						IF var_valor > var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MAYOR O IGUAL"
						IF var_valor >= var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MENOR"
						IF var_valor < var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MENOR O IGUAL"
						IF var_valor <= var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="DISTINTO"
						IF var_valor <> var_valord THEN 
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
	SELECT idfiltro, tabla, idastomode, campofecha, SUM(1) as cantidadf, SUM(cumple) as cumplidos, pf_idregi as idreg, pf_campoid as campoid ;
			FROM  filtros INTO TABLE filtrosele ORDER BY idfiltro GROUP BY idfiltro
	SET ENGINEBEHAVIOR 90
	GO TOP 
	
	SELECT filtrosele
	LOCATE FOR cantidadf = cumplidos AND cumplidos > 0 
	IF FOUND() THEN 
		ret_modelo = STRTRAN(STR(filtrosele.idfiltro,4),' ','0')+STRTRAN(STR(filtrosele.idastomode,4),' ','0')
	ENDIF   
	SELECT filtros
	USE IN filtros
	SELECT filtrosele
	USE IN filtrosele

	IF pf_cierraconex THEN 
		**** El Modelo de Asiento Seleccionado ***
		=abreycierracon(pf_vconeccion,"")	
	ENDIF 
	
RETURN ret_modelo
ENDFUNC 







FUNCTION cambiaEstadoRec
PARAMETERS p_reclamop, p_sector, p_estado
*#/----------------------------------------
* Cambia el reclamop del sector indicado al estado pasado como parámetro
* Guarda el registro del cambio de estado además genera la novedad de cambio del estado
* Retorna: True o False, según se cambió o no el estado
*#/----------------------------------------

	v_idreclamop	= p_reclamop
	v_idsector		= p_sector
	v_idestado		= p_estado
	v_fecha			= DTOS(DATE())+ALLTRIM(SUBSTR(ALLTRIM(TIME(DATETIME())),1,8))
	

	
	*** Cambio el estado del reclamo, agregando un registro de la tabla reclamoe *
	
	p_campoidx	= 'idreclamoe'
	p_tipo		= 'I'
	p_tabla		= 'reclamoe'
	p_incre		= 1
	
	v_idreclamoe	= 0 &&maxnumeroidx (p_campoidx, p_tipo, p_tabla, p_incre)
	
	IF v_idreclamoe <= 0 
		** Error al obtner el max idreclamoe 
				
		** me desconecto
		=abreycierracon(vconeccionM,"")
	
		RETURN .F.
	
	ELSE
	
	
	
		vconeccionM = abreycierracon(0,SYSSCHEMA)


		
		sqlmatriz(1)=" select * from recestado "
		sqlmatriz(2)=" where idrecest = "+ALLTRIM(STR(v_idestado))
		
		
		verror=sqlrun(vconeccionM,"estado_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al buscar el estado",0+48+0,"Error")
		    		
			** me desconecto
			=abreycierracon(vconeccionM,"")
			
		    RETURN .F.
		ENDIF 

		SELECT estado_sql
		GO TOP 
		
		IF NOT EOF()
			v_estado	= estado_sql.estado
		ELSE
				
		** me desconecto
		=abreycierracon(vconeccionM,"")
		
			RETURN .F.
		ENDIF 
		

	
		sqlmatriz(1)=" insert into reclamoe  "
		sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idreclamoe))+","+ALLTRIM(STR(v_idreclamop))+","+ALLTRIM(STR(v_idestado))+","+ALLTRIM(STR(v_idsector))+",'"+ALLTRIM(v_fecha)+"')"
		verror=sqlrun(vconeccionM,"ins_reclamoe_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al registrar el estado del reclamo ",0+48+0,"Error")
			** me desconecto
			=abreycierracon(vconeccionM,"")
		    RETURN .F.
		ENDIF 

		sqlmatriz(1)="SELECT last_insert_id() as maxid "
		verror=sqlrun(vconeccionM,"max_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID ",0+48+0,"Error")
		    v_errores = .T.
		ENDIF 
		SELECT max_sql
		GO TOP 
		v_idreclamoe = VAL(max_sql.maxid)
		USE IN max_sql 

		
		IF v_idreclamop > 0 AND v_idreclamoe > 0
		
		
		*** Busco datos del reclamo ***
			sqlmatriz(1)=" select * from reclamop "
			sqlmatriz(2)=" where idreclamop = "+ALLTRIM(STR(v_idreclamop))
			
			
			verror=sqlrun(vconeccionM,"reclamop_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al buscar el reclamo",0+48+0,"Error")
			    		
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
			    RETURN .F.
			ENDIF 

			SELECT reclamop_sql
			GO TOP 
			
			IF NOT EOF()
				v_numeroRec	= reclamop_sql.numero
			ELSE
					
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
				RETURN .F.
			ENDIF 
			
		*** Busco datos del sector ***	
			sqlmatriz(1)=" select * from recsector "
			sqlmatriz(2)=" where idrecsec = "+ALLTRIM(STR(v_idsector))
			
				
			verror=sqlrun(vconeccionM,"sector_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al buscar el sector",0+48+0,"Error")
			    		
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
			    RETURN .F.
			ENDIF 

			SELECT sector_sql
			GO TOP 
			
			IF NOT EOF()
				v_sectorRec	= sector_sql.sector
			ELSE
			
					
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
				RETURN .F.
			ENDIF 
			** me desconecto
			=abreycierracon(vconeccionM,"")
			p_campoidx	= 'idrecnov'
			p_tipo		= 'I'
			p_tabla		= 'recnovedad'
			p_incre		= 1
		
		
			v_idrecnov	= 0 && maxnumeroidx(p_campoidx, p_tipo, p_tabla, p_incre)

		    vconeccionM = abreycierracon(0,_SYSSCHEMA)
			
			v_fechaHora		= DATETIME()
			v_fecha			= DTOS(v_fechaHora)+ALLTRIM(SUBSTR(ALLTRIM(TIME(v_fechaHora)),1,8))
			v_fechaStr		= ALLTRIM(TTOC(DATETIME()))
			v_usuario		= _SYSUSUARIO
			v_nrumerostr	= alltrim(strtran(str(v_numerorec,8,0),' ' ,'0'))
			v_novedad	= "("+ALLTRIM(v_fechaStr)+") EL RECLAMO "+ALLTRIM(v_nrumerostr)+" CAMBIÓ AL ESTADO "+ALLTRIM(v_estado)+" [SECTOR "+ALLTRIM(v_sectorRec)+"]"
			
			sqlmatriz(1)=" insert into recnovedad (idrecnov, idreclamop, fecha, novedades, usuario, timestamp) "
			sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idrecnov))+","+ALLTRIM(STR(v_idreclamop))+",'"+ALLTRIM(v_fecha)+"','"+ALLTRIM(v_novedad)+"','"+ALLTRIM(v_usuario)+"',CURRENT_TIMESTAMP)"


			verror=sqlrun(vconeccionM,"ins_recnovedad_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al registrar la novedad del reclamo ",0+48+0,"Error")			    		
				** me desconecto
				=abreycierracon(vconeccionM,"")
			    RETURN .F.
			ENDIF 
		

		
		ENDIF 
	
	
	
	ENDIF 
	
	
		
	** me desconecto
	=abreycierracon(vconeccionM,"")
	

	RETURN .T.
ENDFUNC 











FUNCTION cambiaAEstado
	PARAMETERS p_reclamop, p_sector, p_estado
*#/----------------------------------------
* Cambia los estados del reclamo según el sector y los sectores asociados al reclamo si está habilitada la opción
* Retorna: True o False, según se cambió o no el estado
*#/----------------------------------------

	v_idreclamop	= p_reclamop
	v_idsector		= p_sector
	v_idestado		= p_estado
	v_retorno		= .F.
	
	estadoRecObjTmp = CREATEOBJECT('estadosrecclass')
	
	
	v_estadoCerradoTmp	=  estadoRecObjTmp.getidestado("CERRADO")
		
		
	IF v_estadoCerradoTmp = v_idestado AND _SYSRECCIERRAO = 'S'
		** El Sector origen cierra todos los sectores 
	
	
	

		vconeccionM = abreycierracon(0,_SYSSCHEMA)

		
		sqlmatriz(1)=" select * from reclamosec "
		sqlmatriz(2)=" where idrecseco = "+ALLTRIM(STR(v_idsector)) +" and idreclamop = "+ALLTRIM(STR(v_idreclamop))
		
		
		verror=sqlrun(vconeccionM,"reclamosec_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al buscar los sectores del reclamo",0+48+0,"Error")
		    		
			** me desconecto
			=abreycierracon(vconeccionM,"")
			
		    RETURN .F.
		ENDIF 	
			v_huboError	= 0
		
		SELECT reclamosec_sql
		
		v_cantReg	= RECCOUNT()
		
		SELECT reclamosec_sql
		GO TOP 
		
		DO WHILE NOT EOF()
		
			v_idsectorD	= reclamosec_sql.idrecsecd
		
			v_idultEstadoRecTmp	= estadoReclamoPorSector(v_idreclamop, v_idsectorD, 'I')
	
			
			IF v_idultEstadoRecTmp = v_estadoCerradoTmp
				** Si está en estado cerrado -> No cambio el estado
			ELSE
			
				** Cierro el reclamo para el sector
				v_retTmp = cambiaEstadoRec(v_idreclamop, v_idsector, v_idestado)
		
				IF v_retTmp = .F.
					v_huboError = v_huboError  + 1
					
					MESSAGEBOX("Hubo un problema al intentar cambiar de estado el reclamo ID: "+ALLTRIM(STR(v_idreclamop)),0+48+256,"Error al cambiar de estado")
				ENDIF 
			ENDIF 
		
			SELECT reclamosec_sql
			SKIP 1
		
		ENDDO 
		
		IF v_cantReg = v_huboError
			v_retorno = .F.
		ELSE
			v_retorno = .T.		
		ENDIF  
	ELSE
		v_retorno	= cambiaEstadoRec(v_idreclamop, v_idsector, v_idestado)
	
	ENDIF 		
	
	
		

	RETURN v_retorno
ENDFUNC 





FUNCTION IncerAstoContable
*#/**//////////////////////////////////////////////////////////////////
** Función de incersion de asientos a partir de un txt con el asiento con el modelo de asiento y el comprobante asociado
** La funcion controla que el asiento balancee y que las cuentas se correspondan con el 
** Plan de Cuentas Actual
*#/***////////////////////////////////////////////////////////////////
PARAMETERS par_asiento

	varastovalido = ""
	CREATE TABLE tmpasientoin FREE (idastomode i, codigocta c(30),debe y, haber y, tabla c(30), registro i, ;
	 fecha c(8), idfiltro i, idtipoasi i, idastoe i, idpland i, codigo c(22), nombrecta c(200))
	
	SELECT tmpasientoin 
	APPEND FROM &par_asiento DELIMITED WITH ""
	
	** Valido montos y balance del asiento
	CALCULATE SUM(debe)  TO va_debe
	CALCULATE SUM(haber) TO va_haber
	IF (va_debe + va_haber) > 0 AND (va_debe-va_haber) <> 0 THEN
		varastovalido = "El Asiento no Balancea..."
	ENDIF 
	SELECT * FROM tmpasientoin INTO CURSOR cuentainvalida WHERE idpland = 0 OR EMPTY(codigocta)
	IF _tally > 0 THEN 
		varastovalido = "Existe una Cuenta inválida para el Plan de Cuentas Actual..."
	ENDIF 
	USE IN cuentainvalida
	
	IF !EMPTY(varastovalido) THEN 
*!*			MESSAGEBOX("No se Puede Grabar el Asiento: "+varastovalido)
*		RETURN .F.
		RETURN 0
	ENDIF 
	
	** Obtengo el idasiento nuevo y el numero de asiento nuevo
	v_idasiento = maxnumeroidx("idasiento","I","asientos",1)
	v_numero	= maxnumeroidx("numero","I","asientos",1)
	v_ejercicio		= _SYSEJERCICIO
	

	vconeccionp=abreycierracon(0,_SYSSCHEMA)		
	*** ELIMINO HIJOS PARA NO TENER PROBLEMAS DE ACTUALIZACION ***
	sqlmatriz(1)="DELETE FROM asientos WHERE idasiento = " + ALLTRIM(STR(v_idasiento))
	verror=sqlrun(vconeccionp,"asiento1")

	DIMENSION lamatriz(16,2)

	*** INSERTO HIJOS - CREO EL ASIENTO***			
	SELECT tmpasientoin
	GO TOP 
	DO WHILE NOT EOF()
*!*			IF !EMPTY(tmpasientoin.codigocta) AND (tmpasientoin.debe + tmpasientoin.haber) > 0 AND tmpasientoin.idpland > 0 THEN 
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			
			*thisform.calcularmaxh
			v_idasientod = maxnumeroidx("idasientod","I","asientos",1,.t.)
			
			lamatriz(1,1)='idasientod'
			lamatriz(1,2)=ALLTRIM(STR(v_idasientod))
			lamatriz(2,1)='idasiento'
			lamatriz(2,2)=ALLTRIM(STR(v_idasiento))
			lamatriz(3,1)='numero'
			lamatriz(3,2)=ALLTRIM(STR(v_numero))
			lamatriz(4,1)='fecha'
			lamatriz(4,2)="'"+ALLTRIM(tmpasientoin.fecha)+"'"
			lamatriz(5,1)='ejercicio'
			lamatriz(5,2)=ALLTRIM(STR(v_ejercicio))
			lamatriz(6,1)='idpland' 
			lamatriz(6,2)=ALLTRIM(STR(tmpasientoin.idpland))
			lamatriz(7,1)='codigocta'
			lamatriz(7,2)="'"+alltrim(tmpasientoin.codigocta)+"'"
			lamatriz(8,1)='debe'
			lamatriz(8,2)=ALLTRIM(STR(tmpasientoin.debe,12,2))
			lamatriz(9,1)='haber'
			lamatriz(9,2)=ALLTRIM(STR(tmpasientoin.haber,12,2))
			lamatriz(10,1)='detalle'
			lamatriz(10,2)="''"
			lamatriz(11,1)='nombrecta'
			lamatriz(11,2)="'"+ALLTRIM(tmpasientoin.nombrecta)+"'"
			lamatriz(12,1)='detaasiento'
			lamatriz(12,2)="''"
			lamatriz(13,1)='idtipoasi'
			lamatriz(13,2)=STR(tmpasientoin.idtipoasi)
			lamatriz(14,1)='idastomode'
			lamatriz(14,2)=STR(tmpasientoin.idastomode)
			lamatriz(15,1)='idfiltro'
			lamatriz(15,2)=STR(tmpasientoin.idfiltro)
			lamatriz(16,1)='idastoe'
			lamatriz(16,2)=STR(tmpasientoin.idastoe)

			
			p_tabla     = 'asientos'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionp
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
			ENDIF						
			
*!*			ENDIF

		SELECT tmpasientoin
		SKIP 1
	ENDDO	
	
	*** INSERTO LA RELACION CON EL COMPROBANTE***			

	SELECT tmpasientoin
	GO TOP 
	*** SI HUBIERE ALGUNA RELACION CON EL COMPROBANTE DE ALGUN ASIENTO ANTES ***
	sqlmatriz(1)=" DELETE FROM asientoscompro WHERE tabla = '"+ALLTRIM(tmpasientoin.tabla)+"' and idregicomp="+ALLTRIM(STR(tmpasientoin.registro))
	verror=sqlrun(vconeccionp,"asiento1")


	DIMENSION lamatriz(4,2)
	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
			
			*thisform.calcularmaxh
	v_idastocompro = maxnumeroidx("idastocompro","I","asientoscompro",1,.T.)
				
	lamatriz(1,1)='idastocompro'
	lamatriz(1,2)=ALLTRIM(STR(v_idastocompro))
	lamatriz(2,1)='idasiento'
	lamatriz(2,2)=ALLTRIM(STR(v_idasiento))
	lamatriz(3,1)='idregicomp'
	lamatriz(3,2)=ALLTRIM(STR(tmpasientoin.registro))
	lamatriz(4,1)='tabla'
	lamatriz(4,2)="'"+ALLTRIM(tmpasientoin.tabla)+"'"

			
	p_tabla     = 'asientoscompro'
	p_matriz    = 'lamatriz'
	p_conexion  = vconeccionp
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
	ENDIF						
	
	
	=abreycierracon(vconeccionp,"")	
	RETURN v_idasiento
	 
ENDFUNC 



FUNCTION imprimirPagoProv
PARAMETERS p_idpagoProv
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR PAGO
* PARAMETROS: P_idPagoProv
*#/----------------------------------------


	v_idpagoProv = p_idpagoProv
	
	IF v_idpagoProv > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del recibo
					
				
		
			sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip, e.cuit, dc.iddetapago, dc.idtipopago, dc.importe as impCobrado, dc.idcuenta, tp.detalle as tipopago, cb.codcuenta, cb.detalle as nomcuenta "
			sqlmatriz(2)=" from pagosprov r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba "
			sqlmatriz(3)=" left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom " 
			sqlmatriz(4)=" left join entidades e on r.entidad = e.entidad left join detallepagos dc on r.idcomproba = dc.idcomproba and r.idpago = dc.idregistro "
			sqlmatriz(5)=" left join tipopagos tp on dc.idtipopago = tp.idtipopago left join cajabancos cb on dc.idcuenta = cb.idcuenta "
			sqlmatriz(6)=" where r.idpago = "+ ALLTRIM(STR(v_idpagoProv))

			verror=sqlrun(vconeccionF,"pagoprov_sql_ua")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del Pago a Proveedor",0+48+0,"Error")
			ENDIF
		
		 
		
		
		
		
		
		
		SELECT *,iddetapago as iddetap FROM pagoprov_sql_ua INTO TABLE pagoprov_sql_u
		ALTER table pagoprov_sql_u alter COLUMN tipopago C(254) 

		SELECT pagoprov_sql_u
		GO TOP 
		v_idcomproba = pagoprov_sql_u.idcomproba
		
		SELECT iddetap FROM pagoprov_sql_u WHERE ALLTRIM(tipopago) == "CUPONES" OR ALLTRIM(tipopago) == "CHEQUE" INTO TABLE detallepagosid_sql
		
		v_iddetpagos =""
		
		SELECT detallepagosid_sql
		GO TOP 
		
		DO WHILE NOT EOF()
		
			SELECT detallepagosid_sql
			v_iddetpagos = v_iddetpagos + IIF(EMPTY(v_iddetpagos)=.T., "",",")+ ALLTRIM(STR(detallepagosid_sql.iddetap))
		
			SELECT detallepagosid_sql
			SKIP 1
		
		ENDDO 
		

		IF EMPTY(v_iddetpagos) = .T.
				v_iddetpagos = "false"
		ELSE
			v_iddetpagos = "c.registrocp in ("+ALLTRIM(v_iddetpagos) +")"		
		ENDIF 
		
			sqlmatriz(1)=" SELECT c.*,concat('CHEQUE Nro: ',ch.serie,' ',ch.numero,' (',b.banco,'-',b.filial,'-',b.cp,') ',b.nombre) as descrip "
 			sqlmatriz(2)=" from  cobropagolink c left join  cheques ch on c.idregistro = ch.idcheque left join  bancos b "
 			sqlmatriz(3)=" on ch.idbanco = b.idbanco where c.tabla = 'cheques' and c.tablacp = 'detallepagos' and "+ALLTRIM(v_iddetpagos)+" union "
 			sqlmatriz(4)=" SELECT c.*,concat('CUPÓN Nro: ',cu.numero,' - TARJETA: ',cu.tarjeta,' - TITULAR: ',cu.titular) as descrip "
  			sqlmatriz(5)=" from  cobropagolink c left join  cupones cu on c.idregistro = cu.idcupon where c.tabla = 'cupones' and c.tablacp = 'detallepagos' and "+ALLTRIM(v_iddetpagos)
  			  			
			verror=sqlrun(vconeccionF,"che_cup_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del recibo",0+48+0,"Error")
			ENDIF
		
		**** Obtengo las retenciones asociadas al comprobante ***
		tipoPagoObjtmp 	= CREATEOBJECT('tipospagosclass')
		v_idtipoPagRet = tipoPagoObjtmp.getTiposPagos("RETENCION")
			
*!*				

*!*			sqlmatriz(1)= " select l.idlinkcomp, l.idcomprobaa as idcompag, l.idregistroa as idregpag, l.idcomprobab as idcompret, l.idregistrob as idregret, r.importe,d.idtipopago,d.idcuenta,h.detalle,d.iddetapago "
*!*			sqlmatriz(2)= " from detallepagos d left join linkcompro l on d.idcomproba = l.idcomprobaa and d.idregistro = l.idregistroa "
*!*			sqlmatriz(3)=" left join retenciones r on l.idcomprobab = r.idcomproba and l.idregistrob = r.idreten left join impuretencionh h on r.idreten = h.idreten "
*!*			sqlmatriz(4)=" where d.idcomproba = "+ALLTRIM(STR(v_idcomproba)) + " and d.idregistro = "+ALLTRIM(STR(v_idpagoProv))+" and  d.idtipopago= "+ALLTRIM(STR(v_idtipoPagRet ))+ " and l.idregistroa = " +ALLTRIM(STR(v_idpagoProv))
*!*			sqlmatriz(5)=" group by idregret "
*!*			
 
			*sqlmatriz(1)=" select * from detallepagos d left join linkcompro l on d.idcomproba = l.idcomprobaa and d.idregistro = l.idregistroa left join retenciones r on l.idregistrob = r.idreten and l.idcomprobab = r.idcomproba "
			sqlmatriz(1)=" select d.*,ifnull(l.idlinkcomp,0) as idlinkcomp,l.idcomprobaa, l.idregistroa,l.idcomprobab, l.idregistrob, r.*, h.* from detallepagos d left join linkcompro l on d.idcomproba = l.idcomprobaa and d.idregistro = l.idregistroa "
			sqlmatriz(2)=" left join retenciones r on l.idregistrob = r.idreten and l.idcomprobab = r.idcomproba left join impuretencionh h on r.idreten = h.idreten "
			sqlmatriz(3)=" where d.idcomproba = "+ALLTRIM(STR(v_idcomproba)) + " and d.idregistro = "+ALLTRIM(STR(v_idpagoProv))+" and  d.idtipopago= "+ALLTRIM(STR(v_idtipoPagRet ))
			sqlmatriz(4)=" group by r.idreten "



*!*				sqlmatriz(1)=" select * from impuretencionh where idreten in (select ifnull(r.idreten,0) as idreten  from detallepagos d left join linkcompro l on d.idcomproba = l.idcomprobaa and d.idregistro = l.idregistroa left join retenciones r on l.idregistrob = r.idreten and l.idcomprobab = r.idcomproba "
*!*				sqlmatriz(2)=" where d.idcomproba = "+ALLTRIM(STR(v_idcomproba)) + " and d.idregistro = "+ALLTRIM(STR(v_idpagoProv))+" and  d.idtipopago= "+ALLTRIM(STR(v_idtipoPagRet ))
*!*				sqlmatriz(3)=" group by idreten) "

			verror=sqlrun(vconeccionF,"detRetImp_sqla")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de las retenciones a imprimir ",0+48+0,"Error")
			    RETURN 
			ENDIF
			



		SELECT detRetImp_sqla
			GO TOP 

			SELECT * FROM detRetImp_sqla INTO TABLE detRetImp_sql
			GO TOP 
			
			ALTER TABLE detRetImp_sql alter COLUMN idlinkcomp I
			
			v_conLinkc = .F.
			
			SELECT * from detRetImp_sql WHERE idlinkcomp = 0 INTO CURSOR sinLinkc
			
			SELECT sinLinkc
			GO TOP 
			
			IF NOT EOF()
				v_conLinkc  = .F.
			ELSE
				v_conLinkc = .T.
			
			ENDIF 




		SELECT detRetImp_sql
		GO TOP 
		
		
		SELECT che_cup_sql
		GO top
		
		
		SELECT pagoprov_sql_u
		GO TOP 
		
		DO WHILE NOT EOF()
			
			v_tipopago = pagoprov_sql_u.tipopago
			
			IF ALLTRIM(v_tipopago) == "CUPONES" OR ALLTRIM(v_tipopago) == "CHEQUE"
			
				v_idDetapago = pagoprov_sql_u.iddetap
			
				SELECT che_cup_sql 
				GO TOP 
				LOCATE FOR registrocp = v_idDetapago
				
				SELECT pagoprov_sql_u
				replace tipopago WITH che_cup_sql.descrip
			
			ENDIF 
			
				
*!*				IF ALLTRIM(v_tipopago) == "RETENCION"
*!*					
*!*					v_idtipopago = pagoprov_sql_u.idtipopago
*!*					v_idcuenta	 = pagoprov_sql_u.idcuenta
*!*					v_iddetapago = pagoprov_sql_u.iddetap
*!*					
*!*					MESSAGEBOX(v_idtipopago)
*!*					MESSAGEBOX(v_idcuenta)
*!*					MESSAGEBOX(v_iddetapago)
*!*					
*!*					SELECT detRetImp_sql
*!*					GO TOP 
*!*					LOCATE FOR idtipopago = v_idtipopago AND idcuenta = v_idcuenta AND iddetapago = v_iddetapago 
*!*	*				LOCATE FOR idtipopago = v_idtipopago AND idcuenta = v_idcuenta AND importe = v_importe 
*!*					
*!*					
*!*					SELECT pagoprov_sql_u
*!*					replace tipopago WITH "RETENCION - "+ ALLTRIM(detRetImp_sql.detalle)
*!*				ENDIF  
*!*				
		
			SELECT pagoprov_sql_u
			SKIP 1
		
		ENDDO 
		
		IF v_conLinkc = .T.
			SELECT detRetImp_sql
			GO TOP 
			v_idtipopago = detRetImp_sql.idtipopago
			DO WHILE NOT EOF()
			
				SELECT pagoprov_sql_u
				GO TOP 
				
				LOCATE FOR idtipopago = v_idtipopago AND ALLTRIM(tipopago) == "RETENCION"
				
				SELECT pagoprov_sql_u 
				
				replace tipopago WITH "RETENCION - "+ ALLTRIM(detRetImp_sql.detalle)
				
				
				SELECT detRetImp_sql
				SKIP 1
			ENDDO
		ENDIF 
			
			

		
		
*!*			IF ALLTRIM(v_tipopago) == "RETENCION"
*!*					
*!*					v_idtipopago = pagoprov_sql_u.idtipopago
*!*					v_idcuenta	 = pagoprov_sql_u.idcuenta
*!*					v_iddetapago = pagoprov_sql_u.iddetap
*!*					
*!*					MESSAGEBOX(v_idtipopago)
*!*					MESSAGEBOX(v_idcuenta)
*!*					MESSAGEBOX(v_iddetapago)
*!*					
*!*					SELECT detRetImp_sql
*!*					GO TOP 
*!*					LOCATE FOR idtipopago = v_idtipopago AND idcuenta = v_idcuenta AND iddetapago = v_iddetapago 
*!*	*				LOCATE FOR idtipopago = v_idtipopago AND idcuenta = v_idcuenta AND importe = v_importe 
*!*					
*!*					
*!*					SELECT pagoprov_sql_u
*!*					replace tipopago WITH "RETENCION - "+ ALLTRIM(detRetImp_sql.detalle)
*!*				ENDIF  
*!*			
		
		

		SELECT *, ALLTRIM(nombre)+' '+ALLTRIM(apellido) as apeynom FROM pagoprov_sql_u INTO TABLE .\pago
				
		SELECT pago
		
		IF NOT EOF()
		
			SELECT pago
			GO TOP 
			
			v_idcomproba 	= pago.idcomproba
			*** Busco los datos de los cobros para el pago
		
				sqlmatriz(1)=" Select c.*,f.actividad, f.numero,f.tipo,f.fecha,f.entidad, f.nombre, f.apellido,f.cuit ,f.nroremito, f.nropedido, f.actividad "
				sqlmatriz(2)=" from pagosprovfc c left join factuprove f on c.idfactprove = f.idfactprove  "
				sqlmatriz(3)=" where c.idcomproba = " +ALLTRIM(STR(v_idcomproba))+" and c.idpago = "+ ALLTRIM(STR(v_idpagoProv))

				verror=sqlrun(vconeccionF,"pagos_sql_u")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de cobros relacionados al Pago de Proveedor ",0+48+0,"Error")
				ENDIF
			
		
		
		
			SELECT *, ALLTRIM(nombre)+' '+ALLTRIM(apellido) as apeynom FROM pagos_sql_u INTO TABLE .\pagos
			SELECT pagos
			GO TOP 
			
		
		
			ALTER table pago ADD COLUMN strImporte C(250)
			
			SELECT pago
			v_importe	= pago.importe
			v_strImporte	= enletras (v_importe)
			
			SELECT pago 
			GO TOP 
			
			replace ALL strImporte WITH v_strImporte
			
			SELECT pago 
			GO TOP 
			v_idcomproba = pago.idcomproba
			
			DO FORM reporteform WITH "pago;pagos","pagocr;pagoscr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar el Pago de proveedor para imprimir",0+48+0,"Error al cargar el Pago de proveedor ")
			RETURN 	
		ENDIF 
		
		
		
	

	ELSE
		MESSAGEBOX("NO se pudo recuperar el pago con ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 





***************************************************************************************************

FUNCTION imprimirCBTicket
PARAMETERS p_lotecobro
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR EL TICKET DE COBRO
* PARAMETROS: p_lotecobro
*#/----------------------------------------


	v_lotecobro = p_lotecobro
	
	IF v_lotecobro > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del cobro
			
			sqlmatriz(1)=" SELECT c.*,b.idcomp,b.descrip,b.bc,a.empresaid, a.nombre, a.cuit,a.empresaid,a.subcodid "
			sqlmatriz(2)=" FROM cbcobros c left join cbcomprobantes b on c.idcbcompro = b.idcbcompro left join cbasociadas a on b.idcbasoci = a.idcbasoci "
			sqlmatriz(3)=" where c.lotecobro = "+ALLTRIM(STR(v_lotecobro))
			
			
			
			verror=sqlrun(vconeccionF,"cobros_sql_a")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del cobro",0+48+0,"Error")
			ENDIF
			
		SELECT * FROM cobros_sql_a INTO TABLE cbticket


		SELECT cbticket
		GO TOP 
		IF NOT EOF()		
		
			
			DO FORM reporteform WITH "cbticket","cbticketcr","cbticket" 
			
		ELSE
			MESSAGEBOX("Error al cargar el cobro para imprimir",0+48+0,"Error al cargar el cobro")
			RETURN 	
		ENDIF 
				

	ELSE
		MESSAGEBOX("NO se pudo recuperar el cobro  el LOTE <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 



FUNCTION getSectorUsu
PARAMETERS p_usuario
*#/----------------------------------------
* Obtiene el ID del sector al que pertenece el usuario
* Retorna: idusuario
*#/----------------------------------------
	v_idsector	= 0
	
	v_usuario	= p_usuario
	
	* Abro conexión
	vconeccionM=abreycierracon(0,_SYSSCHEMA)	



	sqlmatriz(1)=" select * from recsecusu "
	sqlmatriz(2)= " where usuario = '"+ALLTRIM(v_usuario)+"'"


	verror=sqlrun(vconeccionM,"usuario_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del  usuario ",0+48+0,"Error")
	ENDIF 
	*Cierro Conexión
	=abreycierracon(vconeccionM,"")
	SELECT usuario_sql
	GO TOP 
	
	IF NOT EOF()
	
		v_idsector	= usuario_sql.idrecsusu
		
	ENDIF 


	RETURN v_idsector
ENDFUNC 






FUNCTION getSecUsu
	PARAMETERS p_usuario
*#/----------------------------------------
* Obtiene el ID del sector al que pertenece el usuario
* Retorna: idrecsec
*#/----------------------------------------

	v_idsector	= 0
	
	v_usuario	= p_usuario
	
	*Abro conexión
	vconeccionM=abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)=" select * from recsecusu "
	sqlmatriz(2)= " where usuario = '"+ALLTRIM(v_usuario)+"'"


	verror=sqlrun(vconeccionM,"usuario_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del  usuario ",0+48+0,"Error")
	ENDIF 
	
	*Cierro Conexión
	=abreycierracon(vconeccionM,"")
	SELECT usuario_sql
	GO TOP 
	
	IF NOT EOF()
	
		v_idrecsec	= usuario_sql.idrecsec
	ELSE
		v_idrecsec	= 0
		
	ENDIF 


	RETURN v_idrecsec
ENDFUNC 









FUNCTION cambiaEstadoRec
	PARAMETERS p_reclamop, p_sector, p_estado
*#/----------------------------------------
* Cambia el reclamop del sector indicado al estado pasado como parámetro
* Guarda el registro del cambio de estado además genera la novedad de cambio del estado
* Retorna: True o False, según se cambió o no el estado
*#/----------------------------------------

	v_idreclamop	= p_reclamop
	v_idsector		= p_sector
	v_idestado		= p_estado
	v_fecha			= DTOS(DATE())+ALLTRIM(SUBSTR(ALLTRIM(TIME(DATETIME())),1,8))
	

	vconeccionM = abreycierracon(0,_SYSSCHEMA)


	*** Cambio el estado del reclamo, agregando un registro de la tabla reclamoe *
	
	p_campoidx	= 'idreclamoe'
	p_tipo		= 'I'
	p_tabla		= 'reclamoe'
	p_incre		= 1
	
	v_idreclamoe	= maxnumeroidx (p_campoidx, p_tipo, p_tabla, p_incre)
	
	IF v_idreclamoe <= 0 
		** Error al obtner el max idreclamoe 
				
		** me desconecto
		=abreycierracon(vconeccionM,"")
	
		RETURN .F.
	
	ELSE
	
	
	

	vconeccionM = abreycierracon(0,_SYSSCHEMA)
		sqlmatriz(1)=" select * from recestado "
		sqlmatriz(2)=" where idrecest = "+ALLTRIM(STR(v_idestado))
		
		
		verror=sqlrun(vconeccionM,"estado_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al buscar el estado",0+48+0,"Error")
		    		
			** me desconecto
			=abreycierracon(vconeccionM,"")
			
		    RETURN .F.
		ENDIF 

		SELECT estado_sql
		GO TOP 
		
		IF NOT EOF()
			v_estado	= estado_sql.estado
		ELSE
				
		** me desconecto
		=abreycierracon(vconeccionM,"")
		
			RETURN .F.
		ENDIF 
		

	
		
	    vconeccionM = abreycierracon(0,_SYSSCHEMA)

		sqlmatriz(1)=" insert into reclamoe  "
		sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idreclamoe))+","+ALLTRIM(STR(v_idreclamop))+","+ALLTRIM(STR(v_idestado))+","+ALLTRIM(STR(v_idsector))+",'"+ALLTRIM(v_fecha)+"')"


		verror=sqlrun(vconeccionM,"ins_reclamoe_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al registrar el estado del reclamo ",0+48+0,"Error")
		    		
			** me desconecto
			=abreycierracon(vconeccionM,"")
	
		    RETURN .F.
		ENDIF 

		
		IF v_idreclamop > 0 AND v_idreclamoe > 0
		
		
		*** Busco datos del reclamo ***
			sqlmatriz(1)=" select * from reclamop "
			sqlmatriz(2)=" where idreclamop = "+ALLTRIM(STR(v_idreclamop))
			
			
			verror=sqlrun(vconeccionM,"reclamop_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al buscar el reclamo",0+48+0,"Error")
			    		
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
			    RETURN .F.
			ENDIF 

			SELECT reclamop_sql
			GO TOP 
			
			IF NOT EOF()
				v_numeroRec	= reclamop_sql.numero
			ELSE
					
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
				RETURN .F.
			ENDIF 
			
		*** Busco datos del sector ***	
			sqlmatriz(1)=" select * from recsector "
			sqlmatriz(2)=" where idrecsec = "+ALLTRIM(STR(v_idsector))
			
				
			verror=sqlrun(vconeccionM,"sector_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al buscar el sector",0+48+0,"Error")
			    		
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
			    RETURN .F.
			ENDIF 

			SELECT sector_sql
			GO TOP 
			
			IF NOT EOF()
				v_sectorRec	= sector_sql.sector
			ELSE
			
					
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
				RETURN .F.
			ENDIF 
					

			p_campoidx	= 'idrecnov'
			p_tipo		= 'I'
			p_tabla		= 'recnovedad'
			p_incre		= 1
		
		
			v_idrecnov	= maxnumeroidx(p_campoidx, p_tipo, p_tabla, p_incre)
			
			
		
			vconeccionM = abreycierracon(0,_SYSSCHEMA)
			
			v_fechaHora		= DATETIME()
			v_fecha			= DTOS(v_fechaHora)+ALLTRIM(SUBSTR(ALLTRIM(TIME(v_fechaHora)),1,8))
			v_fechaStr		= ALLTRIM(TTOC(DATETIME()))
			v_usuario		= _SYSUSUARIO
			
			v_nrumerostr	= alltrim(strtran(str(v_numerorec,8,0),' ' ,'0'))
			
			v_novedad	= "("+ALLTRIM(v_fechaStr)+") EL RECLAMO "+ALLTRIM(v_nrumerostr)+" CAMBIÓ AL ESTADO "+ALLTRIM(v_estado)+" [SECTOR "+ALLTRIM(v_sectorRec)+"]"
					
			sqlmatriz(1)=" insert into recnovedad (idrecnov, idreclamop, fecha, novedades, usuario, timestamp) "
			sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idrecnov))+","+ALLTRIM(STR(v_idreclamop))+",'"+ALLTRIM(v_fecha)+"','"+ALLTRIM(v_novedad)+"','"+ALLTRIM(v_usuario)+"',CURRENT_TIMESTAMP)"


			verror=sqlrun(vconeccionM,"ins_recnovedad_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error al registrar la novedad del reclamo ",0+48+0,"Error")
			    		
				** me desconecto
				=abreycierracon(vconeccionM,"")
				
			    RETURN .F.
			ENDIF 
		
		ELSE
		
		
		ENDIF 
	
	
	
	ENDIF 
	
	
		
	** me desconecto
	=abreycierracon(vconeccionM,"")
	

	RETURN .T.
ENDFUNC 











FUNCTION cambiaAEstado
	PARAMETERS p_reclamop, p_sector, p_estado
*#/----------------------------------------
* Cambia los estados del reclamo según el sector y los sectores asociados al reclamo si está habilitada la opción
* Retorna: True o False, según se cambió o no el estado
*#/----------------------------------------

	v_idreclamop	= p_reclamop
	v_idsector		= p_sector
	v_idestado		= p_estado
	v_retorno		= .F.
	
	estadoRecObjTmp = CREATEOBJECT('estadosrecclass')
	
	
	v_estadoCerradoTmp	=  estadoRecObjTmp.getidestado("CERRADO")
		
		
	IF v_estadoCerradoTmp = v_idestado AND _SYSRECCIERRAO = 'S'
		** El Sector origen cierra todos los sectores 
	
	
	
	
		vconeccionM = abreycierracon(0,_SYSSCHEMA)

		
		sqlmatriz(1)=" select * from reclamosec "
		sqlmatriz(2)=" where idrecseco = "+ALLTRIM(STR(v_idsector)) +" and idreclamop = "+ALLTRIM(STR(v_idreclamop))
		
		
		verror=sqlrun(vconeccionM,"reclamosec_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al buscar los sectores del reclamo",0+48+0,"Error")
		    		
			** me desconecto
			=abreycierracon(vconeccionM,"")
			
		    RETURN .F.
		ENDIF 	
			v_huboError	= 0
		
		SELECT reclamosec_sql
		
		v_cantReg	= RECCOUNT()
		
		SELECT reclamosec_sql
		GO TOP 
		
		DO WHILE NOT EOF()
		
			v_idsectorD	= reclamosec_sql.idrecsecd
		
			v_idultEstadoRecTmp	= estadoReclamoPorSector(v_idreclamop, v_idsectorD, 'I')
	
			
			IF v_idultEstadoRecTmp = v_estadoCerradoTmp
				** Si está en estado cerrado -> No cambio el estado
			ELSE
			
				** Cierro el reclamo para el sector
				v_retTmp = cambiaEstadoRec(v_idreclamop, v_idsector, v_idestado)
		
				IF v_retTmp = .F.
					v_huboError = v_huboError  + 1
					
					MESSAGEBOX("Hubo un problema al intentar cambiar de estado el reclamo ID: "+ALLTRIM(STR(v_idreclamop)),0+48+256,"Error al cambiar de estado")
				ENDIF 
			ENDIF 
		
			SELECT reclamosec_sql
			SKIP 1
		
		ENDDO 
		
		IF v_cantReg = v_huboError
			v_retorno = .F.
		ELSE
			v_retorno = .T.		
		ENDIF  
	ELSE
		v_retorno	= cambiaEstadoRec(v_idreclamop, v_idsector, v_idestado)
	
	ENDIF 		
	
	
		

	RETURN v_retorno
ENDFUNC 




FUNCTION frandom
PARAMETERS p_digitos
*#/----------------------------------------
** FUNCION DE CALCULO DE NUMEROS ALEATORIOS
* puede recibir como parametros la cantidad de numeros aleatorios
* si no recibe cantidad devuelve de acuerdo a la variable _SYSRAND
*#/----------------------------------------

IF TYPE('p_digitos') <> 'N'

	RETURN ALLTRIM(STRTRAN(SUBSTR(STR((RAND(-1)*_SYSRAND)),2),'','0'))
ELSE

	v_expo = p_digitos 
	
	v_rand = 10^v_expo
	
	RETURN ALLTRIM(STRTRAN(SUBSTR(STR((RAND(-1)*v_rand)),2),'','0'))
ENDIF 
	
ENDFUNC 




FUNCTION estadoReclamoPorSector
	PARAMETERS p_reclamop, p_sector, p_Retorno
*#/----------------------------------------
* Retorna el ultimo estado para un reclamo dado, segun el sector
* Parametros: Reclamo, Sector, Retorno (I: Indice,N: Nombre)
* Retorna: ID_Reclamo_Estado
*#/----------------------------------------


	v_idreclamop	= p_reclamop
	v_idsector		= p_sector
	v_retorno		= p_retorno

	

	
	*Abro conexión
	vconeccionM=abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)= "select r.*,e.estado from reclamoe  r left join recestado e on r.idrecest = e.idrecest "
	sqlmatriz(2)= " where r.idreclamop = "+ALLTRIM(STR(v_idreclamop)) + " and r.idrecsec = " +ALLTRIM(STR(v_idsector))
	sqlmatriz(3)= " order by r.idreclamoe " 


	verror=sqlrun(vconeccionM ,"reclamoe_sql")
	
	=abreycierracon(vconeccionM,"")
			
	IF verror=.f.
		MESSAGEBOX("Hubo un error al obtener el estado del reclamo",0+16+256,"Error al obtner el estado")		
		DO CASE
		CASE v_retorno 	= 'I'
			RETURN 0
		CASE v_retorno	= 'N'
			RETURN ''
		OTHERWISE

		ENDCASE

	ENDIF 


	
	SELECT reclamoe_sql
	v_cantReg	= RECCOUNT()
	IF v_cantReg = 0
		DO CASE
		CASE v_retorno 	= 'I'
			RETURN 0
		CASE v_retorno	= 'N'
			RETURN ''
		OTHERWISE

		ENDCASE

	ENDIF 

	SELECT reclamoe_sql
	GO BOTTOM 
	
	
	DO CASE
		CASE v_retorno 	= 'I'
			RETURN reclamoe_sql.idrecest
		CASE v_retorno	= 'N'
			RETURN reclamoe_sql.estado
		OTHERWISE
			RETURN ''
		ENDCASE

	
ENDFUNC 	
	
FUNCTION CopiarClip
*#/----------------------------------------
* Copia lo que hay en la grilla o area seleccinada a distintos formatos
* Parametros: p_csv es el formato en el cual dará salida al archivo
* Si no recibe parametro entonces convierte a .csv (separado por comas)
*#/----------------------------------------
	PARAMETERS p_csv 
	
	IF !TYPE('p_csv')='C' THEN 
		v_auxi = ALIAS()
		
		v_confiltro = FILTER(v_auxi)
		v_confiltro = IIF(EMPTY(v_confiltro),""," and "+ALLTRIM(v_confiltro))
		
		IF !EMPTY(v_auxi) THEN 
			IF (ALLTRIM(FIELD("sel",v_auxi))=='SEL') THEN
				IF TYPE('sel')='L' THEN 
					SELECT * FROM &v_auxi INTO CURSOR ccopiarclip WHERE sel = .t. &v_confiltro
					SELECT ccopiarclip
					IF _tally = 0  THEN 
						SELECT * FROM &v_auxi INTO CURSOR ccopiarclip WHERE .t. = .t. &v_confiltro
					ENDIF 
				ELSE
					SELECT * FROM &v_auxi INTO CURSOR ccopiarclip  	WHERE .t. = .t.	&v_confiltro	
				ENDIF 
			ELSE
				SELECT * FROM &v_auxi INTO CURSOR ccopiarclip  	WHERE .t. = .t. &v_confiltro
			ENDIF  
			SELECT ccopiarclip
			v_rec = reccount()
			IF v_rec > 0 then 
				_vfp.DataToClip('ccopiarclip',v_rec,3)
				MESSAGEBOX("Se copiaron los datos al Portapapeles",64)
			ENDIF 
			USE IN ccopiarclip
			SELECT &v_auxi
		ENDIF 
	ELSE
		v_auxi = ALIAS()
		IF !EMPTY(v_auxi) THEN 
		
			v_drv = SYS(5)+'\'
			SET DEFAULT TO &v_drv
			v_ext = 'CSV'
			v_tipo = 'csv'
			DO CASE 
				CASE EMPTY(p_csv)
					v_tipo = 'CSV' 
					v_ext = 'csv'
				CASE UPPER(p_csv) == 'CSV'
					v_ext = 'CSV' 
					v_ext = 'csv'
				CASE UPPER(p_csv) == 'XLS'
					v_tipo = 'XLS'
					v_ext = 'xls'
				CASE UPPER(p_csv) == 'XL5'
					v_tipo = 'XL5'
					v_ext = 'xls'
				CASE UPPER(p_csv) == 'FOX2X'
					v_tipo = 'FOX2X'
					v_ext = 'dbf'
				CASE UPPER(p_csv) == 'SDF'
					v_tipo = 'SDF'
					v_ext = 'txt'
				CASE UPPER(p_csv) == 'DBF'
					v_tipo = ''
					v_ext = 'dbf'
				OTHERWISE 
					v_ext = 'CSV' 
					v_ext = 'csv'
			ENDCASE 
			v_nuevo_csv = ALLTRIM(PUTFILE("Archivo",v_auxi,v_ext))
			IF !EMPTY(v_nuevo_csv) THEN 
				eje = "COPY TO "+ v_nuevo_csv + " TYPE "+v_tipo
				&eje
				APLIC=CREATEOBJECT("WSCript.Shell")
				APLIC.RUN(v_nuevo_csv)
				RELEASE APLIC 
			ENDIF 
			SET DEFAULT TO &_SYSESTACION	
			SELECT &v_auxi
		ENDIF 
	ENDIF 
	
	RETURN 
ENDFUNC 





FUNCTION reclamoPerteneceSector
	PARAMETERS p_reclamop, p_sector
*#/----------------------------------------
* Retorna Verdadero o Falso, si el reclamo pertenece al sector dado
* Parametros: Reclamo, Sector
* Retorna: True o False
*#/----------------------------------------

	v_idreclamop	= p_reclamop
	v_idsector		= p_sector


	*Abro conexión
	vconeccionM=abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)= "select * from reclamosec r  "
	sqlmatriz(2)= " where r.idreclamop = "+ALLTRIM(STR(v_idreclamop)) + " and r.idrecsecD = " +ALLTRIM(STR(v_idsector))


	verror=sqlrun(vconeccionM ,"reclamoSec_sql")
	
	=abreycierracon(vconeccionM,"")
			
	IF verror=.f.
		MESSAGEBOX("Hubo un error al obtener el sector ",0+16+256,"Error al obtner el sector")		
		RETURN .F.
	ENDIF 

	SELECT reclamoSec_sql
	GO top
	
	IF NOT EOF()
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF 
	
	
	RETURN .F.

ENDFUNC 




FUNCTION obtenerCorreos
	PARAMETERS pIdEntidad
*#/----------------------------------------
* Retorna una lista de correos asociados a la entidad pasado como parámetro
* pIdEntidadd: ID de la entidad
* Retorno: Lista de Emails separados por ';'
*#/----------------------------------------

	IF TYPE("pIdEntidad")='C' THEN 
		pIdEntidad = INT(VAL(pIdEntidad))
	ENDIF 
	
	v_retorno	= ""
	
	IF pIdEntidad == 0 OR EMPTY(pIdEntidad) == .T.
	
		RETURN  v_retorno
	ENDIF 

	v_identidad	= pIdEntidad
	
	vconeccionM	= abreycierracon(0,_SYSSCHEMA)
	
	sqlmatriz(1)=" select apellido,nombre, email from entidades where entidad = "+ALLTRIM(STR(v_identidad))

	verror=sqlrun(vconeccionM,"entidades_sql_uti")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los correos de las entidades",0+48+0,"Error")
	    RETURN v_retorno
	ENDIF 

	* me desconecto	
	=abreycierracon(vconeccionM,"")
		
	
	SELECT entidades_sql_uti
	GO TOP 
	v_email1	= entidades_sql_uti.email
	v_retorno	= v_email1
			
*!*			IF EMPTY(v_email2)
*!*				v_retorno	= v_email1
*!*			ELSE
*!*				IF EMPTY(v_email1)
*!*					v_retorno	= v_email2
*!*				ELSE
*!*					v_retorno	= v_email1+";"+v_email2
*!*				ENDIF 
*!*			ENDIF  
	USE IN entidades_sql_uti			
	return v_retorno
		
		
ENDFUNC 


FUNCTION cargaCfgCorreo
*#/----------------------------------------
* Busca la configuración de correo para el usuario logeado
* Retorna: objeto de configuración
*#/----------------------------------------


vconeccionM = abreycierracon(0,_SYSSCHEMA)


	sqlmatriz(1)=" select * FROM correoconf "
	sqlmatriz(2)= " where usuario = '"+ALLTRIM(_SYSUSUARIO )+"'"

	verror=sqlrun(vconeccionM,"correoconf_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la configuración del correo de usuario ",0+48+0,"Error")
	ENDIF 

	* me desconecto	
	=abreycierracon(vconeccionM,"")

	SELECT correoconf_sql
	GO top
	
	IF NOT EOF()
		** Encontró la configuración
	
		v_smtpserver	= correoconf_sql.smtpserv
		v_smtpport		= correoconf_sql.smtpport
		v_smtpport		= correoconf_sql.smtpport
 
		v_sendusing		= correoconf_sql.sendusing
		v_smtpaut		= IIF(correoconf_sql.smtpaut == 'S',.T.,.F.)
		v_smtpusessl	= IIF(correoconf_sql.smtpusessl == 'S', .T.,.F.)
		v_correoEnv		= correoconf_sql.correo
		v_clave			= correoconf_sql.clave
		
		
	 	loCfg = CREATEOBJECT("CDO.Configuration")
  		WITH loCfg.Fields
		    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = v_smtpserver
		    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = v_smtpport
		    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = v_sendusing
		    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = v_smtpaut
		    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = v_smtpusessl
		    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = v_correoEnv
		    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = v_clave
		    .Update
  		ENDWITH
  		
  		RETURN loCfg
	ELSE
		** No encontró configuración para el usuario -> Pido la configuración del correo
	
		DO FORM abmcfgcorreo TO v_respuesta
		
		IF v_respuesta > 0
					
			v_res = cargaCfgCorreo()
			
			RETURN v_res
			
	 	ELSE
	 	
	 		RETURN null	
		ENDIF 
	ENDIF 
ENDFUNC 




FUNCTION obtieneRecNoLeidos
PARAMETERS  para_aliasrnl, p_usuario
*#/----------------------------------------
* Obtiene todos los reclamos no leidos dato el usuario (y con el usuario el sector)
*#/----------------------------------------
p_aliasretorno  = ""

v_idrecsec	= getSecUsu(p_usuario)


	vconeccionM = abreycierracon(0,_SYSSCHEMA)
		
	sqlmatriz(1)=" SELECT r.idrecnol, r.idrecsec, p.*,t.tipo, r.leido "
	sqlmatriz(2)=" FROM recnoleido r  " 
	sqlmatriz(3)=" left join reclamop p on r.idreclamop = p.idreclamop  left join rectipo t on p.idrectipo = t.idrectipo "
	sqlmatriz(4)=" WHERE  r.leido = 0 and r.idrecsec = "+ALLTRIM(STR(v_idrecsec))

  
	verror=sqlrun(vconeccionM ,"recnoleido_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de reclamos no leidos... ",0+48+0,"Error")
	    RETURN p_aliasretorno  
	ENDIF
	=abreycierracon(vconeccionM ,"")	

	SELECT recnoleido_sql
	GO TOP 
	
	IF EOF()
		RETURN p_aliasretorno  
	ENDIF

	
	*	SELECT idrecnol,idrecsec, idreclamop, idrectipo,tipo,numero, entidad, fecha, observac, descrip FROM recnoleido_sql	INTO TABLE &v_nomtabla 
		SELECT idrecnol,idrecsec, idreclamop, idrectipo,tipo,numero, entidad, fecha, observac, descrip FROM recnoleido_sql	INTO TABLE recnoleidos 
		
		SELECT recnoleido_sql

	USE IN recnoleido_sql
	p_aliasretorno  = para_aliasrnl
	RETURN para_aliasrnl
ENDFUNC 


	
	
	
FUNCTION GetListasPrecios	
PARAMETERS p_nombrearchivo, p_condfis
*#/****
* Obtiene todas las listas de precios con los Precios Actualizados 
* La lista 0 corresponde a la basica de articulos sin Calculo de Costos
* Recibe como parametro el nombre de la tabla en la cual retornará las listas y la condicion fiscal (por defecto es la 1)
*#/**********************************************************************


vtmp_recalcular = .f. 
vtmp = frandom()

v_condFis = 1

IF TYPE('p_condfis') = 'N'
	v_condFis = p_condfis
ENDIF 

IF EMPTY(_SYSLISTAPRECIO)  THEN 
	_SYSLISTAPRECIO = 'syslistapre'
	vtmp_recalcular = .t.
ELSE 
	
	IF USED("syslistaprea") THEN 
	ELSE
		USE syslistaprea IN 0 
	ENDIF 
	IF USED("syslistapreb") THEN 
	ELSE
		USE syslistapreb IN 0 
	ENDIF 
	
	vconeccionL = abreycierracon(0,_SYSSCHEMA)
	sqlmatriz(1)="select MAX(actualiza) as maxactual from listapreciop  "
	verror=sqlrun(vconeccionL,'maximosql')
	IF verror=.f.
		MESSAGEBOX("No se puede obtener  Maximo en el Schema ",0+16,"Advertencia")
		RETURN 
	ENDIF 
	* me desconecto	
	=abreycierracon(vconeccionL,"")
	IF !(ALLTRIM(syslistaprea.actualiza) == ALLTRIM(maximosql.maxactual)) THEN 
		vtmp_recalcular = .t.
	ENDIF 
	SELECT syslistaprea 
	USE 
	SELECT syslistapreb 
	USE 
	SELECT maximosql
	USE 


ENDIF 



IF vtmp_recalcular = .t. THEN 


	WAIT windows "Calculando Listas de Precios... Aguarde..." NOWAIT 

	vconeccionF = abreycierracon(0,_SYSSCHEMA)

	** Busco las Listas de Precios guardadas en las tablas recalculadas
	** r_listaprea r_listapreb
	*--------------------------
	fvr_listaprea_sql 	= 'r_listaprea_sql'+vtmp 
	fvr_listapreb_sql 	= 'r_listapreb_sql'+vtmp 
	
	sqlmatriz(1)="select * from r_listaprea   " 
	verror=sqlrun(vconeccionF,fvr_listaprea_sql)
	IF verror=.f.
		MESSAGEBOX("No se puede obtener La Lista de Precios de la Base ",0+16,"Advertencia")
		RETURN 
	ENDIF 
	sqlmatriz(1)="select * from r_listapreb   " 
	verror=sqlrun(vconeccionF,fvr_listapreb_sql)
	IF verror=.f.
		MESSAGEBOX("No se puede obtener  Lista de Precios ",0+16,"Advertencia")
		RETURN 
	ENDIF 
	
	SELECT &fvr_listaprea_sql 
	GO TOP 
	 
	IF !EOF() THEN && Debe Recalcular toda la Lista de Precios
	
		SELECT * FROM &fvr_listaprea_sql	INTO TABLE syslistaprea	
		SELECT * FROM &fvr_listapreb_sql	INTO TABLE syslistapreb	
		SELECT syslistaprea
		USE 
		SELECT syslistapreb
		USE
		* me desconecto	
		=abreycierracon(vconeccionF,"")

	
	ELSE && Recalcula la Lista de Precios si no está disponible en la Base de Datos
	
	
		fvarticulos_sql 	= 'articulos_sql'+vtmp 
		fvlistapreciop_sql 	= 'listapreciop_sql'+vtmp 
		fvlistaprecioh_sql 	= 'listaprecioh_sql'+vtmp 
		fvlistaprecioc_sql 	= 'listaprecioc_sql'+vtmp 
		fvarticulosimp_sql	= 'articulosimp_sql'+vtmp
		
		* Elimina de listaprecioh si hubiere algun registro cuyo articulo se elimino de la tabla de articulos
		* puede haber quedado colgado algun registro 
		sqlmatriz(1)=" delete from listaprecioh where articulo not in ( select articulo from articulos )   " 
		verror=sqlrun(vconeccionF,"borra_sql")
		IF verror=.f.
			MESSAGEBOX("No se puede obtener Articulos de Listas de Precios " ,0+16,"Advertencia")
			RETURN 
		ENDIF 

		sqlmatriz(1)="select a.*, l.detalle as detalinea, IFNULL(s.stocktot,0) as stocktot,IFNULL(u.fecha,'') as fechaact, ifnull(sl.sublinea,SPACE(150)) as sublinea  from articulos a "
		sqlmatriz(2)=" left join lineas l on l.linea = a.linea left join sublineas sl on sl.idsublinea = a.idsublinea "
		sqlmatriz(3)=" left join r_articulostock s on s.articulo = a.articulo  left join ultimoartcosto u on a.articulo = u.articulo " 
		verror=sqlrun(vconeccionF,fvarticulos_sql)
		IF verror=.f.
			MESSAGEBOX("No se puede obtener  Articulos ",0+16,"Advertencia")
			RETURN 
		ENDIF 

		
		sqlmatriz(1)="select * from listapreciop   " 
		verror=sqlrun(vconeccionF,fvlistapreciop_sql)
		IF verror=.f.
			MESSAGEBOX("No se puede obtener  Lista de Precios ",0+16,"Advertencia")
			RETURN 
		ENDIF 
		sqlmatriz(1)="select * from listaprecioh   " 
		verror=sqlrun(vconeccionF,fvlistaprecioh_sql)
		IF verror=.f.
			MESSAGEBOX("No se puede obtener Articulos de Listas de Precios " ,0+16,"Advertencia")
			RETURN 
		ENDIF 
	*	sqlmatriz(1)="select a.articulo, SUM(i.razon) as razon  from articulosimp a left join impuestos i on a.impuesto = i.impuesto group by a.articulo " 

		sqlmatriz(1)="select a.articulo, SUM(i.razon) as razon  from articulosimp a left join impuestos i on a.impuesto = i.impuesto where a.iva = "+ALLTRIM(STR(v_condfis))+" group by a.articulo " 
		verror=sqlrun(vconeccionF,fvarticulosimp_sql)
		IF verror=.f.
			MESSAGEBOX("No se puede obtener Articulos de Listas de Precios " ,0+16,"Advertencia")
			RETURN 
		ENDIF 
*!*			sqlmatriz(1)="select l.*, c.habilitado from listaprecioc l left join financiacion c on l.idfinancia = c.idfinancia  " 
*!*			sqlmatriz(2)=" left join listapreciop p on l.
		sqlmatriz(1)= " select l.*, c.habilitado, ifnull(p.habilita,'N') as habilita from listaprecioc l left join financiacion c on l.idfinancia = c.idfinancia"
		sqlmatriz(2)= " left join listapreciop p on l.idlista = p.idlista"
		verror=sqlrun(vconeccionF,fvlistaprecioc_sql)
		IF verror=.f.
			MESSAGEBOX("No se puede obtener Cuotas de Listas de Precios ",0+16,"Advertencia")
			RETURN 
		ENDIF 
		* me desconecto	
		=abreycierracon(vconeccionF,"")


		* Obtengo los Articulos de Cada Lista Seleccionada 
		fvlistasart = 'listasart'+vtmp 
		fvlistasartp = 'listasartp'+vtmp 
		fvarticulos = 'articulos'+vtmp 

		SELECT p.idlista, SUBSTR(p.detalle+SPACE(200),1,200) as detallep, p.vigedesde, p.vigehasta, p.margen as margenp, p.condvta,  p.idlistap, p.actualiza, l.idlistah, ;  
			a.articulo, SUBSTR(a.detalle+SPACE(200),1,200) as detalle, a.unidad, a.abrevia, a.codbarra, a.costo as costoa, a.linea,a.detalinea,a.idsublinea,a.sublinea, a.ctrlstock, a.ocultar, ;
			a.stockmin,a.stocktot, a.desc1, a.desc2, a.desc3,  a.desc4,  a.desc5, a.reca1, a.moneda, ;
			a.costo as pcosto, l.margen , a.costo as pventa , i.razon as razonimpu, a.costo as impuestos, a.costo as pventatot,l.fechaact, p.habilita ;
		 	FROM &fvlistaprecioh_sql l ;
			LEFT JOIN &fvarticulos_sql a ON ALLTRIM(l.articulo)==ALLTRIM(a.articulo) ;
			LEFT JOIN &fvlistapreciop_sql p  ON l.idlista = p.idlista ;
			LEFT JOIN &fvarticulosimp_sql i  ON ALLTRIM(l.articulo) == ALLTRIM(i.articulo) ;
			INTO TABLE &fvlistasart 
			

		SELECT 'Lista Precio Base - Costos ' as detallep, a.articulo, a.detalle, ;
			a.unidad, a.abrevia, a.codbarra, a.costo as costoa, a.linea, a.detalinea, a.idsublinea, a.sublinea, a.ctrlstock, a.ocultar, ;
			a.stockmin, a.stocktot, a.desc1, a.desc2, a.desc3,  a.desc4,  a.desc5, a.reca1, a.moneda, ;
			a.costo as pcosto, a.costo as pventa, i.razon as razonimpu, a.costo as impuestos, a.costo as pventatot,a.fechaact   ;
			FROM &fvarticulos_sql a ;
			LEFT JOIN &fvarticulosimp_sql i  ON ALLTRIM(a.articulo) == ALLTRIM(i.articulo) ;
			INTO TABLE &fvarticulos


		SELECT &fvlistasart
		APPEND FROM &fvarticulos  
		INDEX on STR(idlista)+'#'+ALLTRIM(articulo) TAG idlisarti
		GO TOP 
		replace razonimpu WITH 0 FOR ISNULL(razonimpu)


		SELECT * FROM &fvlistasart INTO TABLE &fvlistasartp
		SELECT &fvlistasartp
		INDEX on STR(idlista)+'#'+ALLTRIM(articulo) TAG idlisarti
		SELECT &fvlistasart
		SET RELATION TO STR(idlistap)+'#'+ALLTRIM(articulo) INTO &fvlistasartp 




		fvlistas = 'listas'+vtmp
		SELECT idlista, idlistap, 1 as actul, 1 as actup  FROM &fvlistapreciop_sql INTO TABLE &fvlistas 
		SELECT &fvlistas
		replace actup WITH 0 FOR idlistap = 0

		vactualizadas = 1 
		DO WHILE vactualizadas > 0

			SELECT &fvlistas 
			
			SCAN FOR &fvlistas..actul = 1 AND actup = 0

				SELECT &fvlistasart
				* Reemplazo los costos en la lista nueva con los costos de la lista padre
				replace pcosto WITH &fvlistasartp..pventa, pventa WITH &fvlistasartp..pventa * (1 + margen/100)  ;
					    impuestos WITH (&fvlistasartp..pventa * (1 + margen/100))*(razonimpu/100), pventatot WITH (&fvlistasartp..pventa * (1 + margen/100))*(1 + razonimpu/100) FOR &fvlistasart..idlista	= &fvlistas..idlista
					    
				SET RELATION TO 
				SELECT &fvlistasartp
				SET RELATION TO STR(idlista)+'#'+ALLTRIM(articulo) INTO &fvlistasart 
				* actualizo los costos de la lista recien reemplazada en la tabla de listas padres 
				replace pcosto WITH &fvlistasart..pcosto, pventa WITH &fvlistasart..pventa ;
					FOR &fvlistasart..idlista	= &fvlistas..idlista
					
				SET RELATION TO 
				SELECT &fvlistasart
				SET RELATION TO STR(idlistap)+'#'+ALLTRIM(articulo) INTO &fvlistasartp 
				
				
				SELECT &fvlistas 
				replace &fvlistas..actul WITH 0 
			ENDSCAN 
			
			SELECT * FROM &fvlistas INTO CURSOR lista01 WHERE &fvlistas..actul = 0
			UPDATE &fvlistas SET actup = 0 WHERE idlistap in (select idlista from lista01)
			
			SELECT &fvlistas
			CALCULATE SUM(actul+actup) TO vactualizadas
		ENDDO  


		SELECT MAX(actualiza) as maxactual FROM &fvlistasart INTO CURSOR maximolis 
		SELECT &fvlistasart 
		UPDATE &fvlistasart SET actualiza=maximolis.maxactual
		SELECT maximolis
		USE IN maximolis
		
		SELECT * FROM &fvlistasart 			INTO TABLE syslistaprea	
		SELECT idlistac, idlista, SUBSTR(detalle+SPACE(200),1,200) as detalle, cuotas, razon, idfinancia, habilitado, habilita   FROM &fvlistaprecioc_sql  	INTO TABLE syslistapreb	

		USE IN &fvlistas  
		USE IN &fvlistasart  
		USE IN &fvlistasartp  
		USE IN &fvarticulos
		USE IN &fvarticulos_sql 
		USE IN &fvlistapreciop_sql 	
		USE IN &fvlistaprecioh_sql 	
		USE IN &fvlistaprecioc_sql 	
		
		SELECT syslistaprea
		USE 
		SELECT syslistapreb
		USE


		=ActualizaListasR("syslistapre")

		
	ENDIF 	
		
ENDIF 


	USE syslistaprea IN 0
	USE syslistapreb IN 0

	v_nombreretorno = 'syslistapre'+vtmp 
	IF !EMPTY(p_nombrearchivo) THEN 
		v_nombreretorno = p_nombrearchivo
		v_nombrearchivop = p_nombrearchivo+'a'
		v_nombrearchivoc = p_nombrearchivo+'b'
	ELSE 
		v_nombreretorno = 'syslistapre'+vtmp 
		v_nombrearchivop = 'syslistapre'+vtmp+'a'
		v_nombrearchivoc = 'syslistapre'+vtmp+'b'
	ENDIF 


	SELECT * FROM syslistaprea 	INTO TABLE &v_nombrearchivop	
	SELECT idlistac, idlista, detalle, cuotas, razon, idfinancia, habilitado   FROM syslistapreb  	INTO TABLE &v_nombrearchivoc

	USE IN syslistaprea
	USE IN syslistapreb

	WAIT CLEAR 
	
	RETURN v_nombreretorno 

ENDFUNC 



FUNCTION getLogo
archi = _SYSESTACION+'\'+_SYSLOGOEMPRE
IF FILE(archi) THEN 
	RETURN archi
ENDIF 
RETURN ""



FUNCTION armarComprobanteXML
PARAMETERS p_idFactura
*#/*** Función que arma el comprobante en un archivo XML**
* Busca en la Base de Datos los datos de la factura según el ID pasado como parámetro, 
* Utiliza la función CURSORTOXML, el formato del nombre xml es: 'factura_<idFactura>', donde <idFactura> es el ID en la tabla facturas
*#/** Recibe como parámetro el IDFactura

	v_servicioCargado = .F.
	v_compCargado = .F.
	v_ubicacionXML = ""

			v_idfactura = p_idFactura
			
			**** CARGA COMPROBANTE ***

			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			


			sqlmatriz(1)="Select f.*, a.codigo as codAfip, p.puntov, tc.idtipocompro as idtipocomp from facturas f left join comprobantes c on f.idcomproba = c.idcomproba "
			sqlmatriz(2)=" left join tipocompro tc on  c.idtipocompro = tc.idtipocompro left join afipcompro a on  tc.idafipcom = a.idafipcom "
			sqlmatriz(3)=" left join puntosventa p on f.pventa = p.pventa "
			sqlmatriz(4)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"factu_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la factura a cargar ",0+48+0,"Error")
			    *thisform.comprobantecargado = .f.
			    v_compCargado = .F.
			ENDIF 

			*** Cargo IMpuestos del comprobante agrupados por tipo de impuesto
			sqlmatriz(1)="Select fi.*,a.codigo as codigoAfip, a.tipo as tipoAfip, a.detalle as detAfip from  facturasimp fi left join impuestos i on fi.impuesto = i.impuesto "
			sqlmatriz(2)=" left join afipimpuestos a on i.idafipimp = a.idafipimp " 
			sqlmatriz(3)=" where fi.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"factImp_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los impuestos de las facturas ",0+48+0,"Error")
			    *thisform.comprobantecargado = .f.
			    v_compCargado = .F.
			ENDIF 

			SELECT factImp_sql
			GO TOP 
			
		
			
			SELECT f.*,IIF(EMPTY(ALLTRIM(f.cuit)),f.dni,f.cuit) as nrodoccli, f.neto as netocomp,i.impuesto,i.detalle, i.neto as netoimpu ,i.razon, i.importe,i.codigoafip,i.tipoafip,i.detafip ;
			FROM factu_sql f LEFT JOIN factImp_sql i ON f.idfactura = i.idfactura INTO TABLE tablaFactura


			ALTER table tablafactura add COLUMN opexento Y 
			ALTER table tablafactura ADD COLUMN idmoneda C(3)
			ALTER table tablafactura ADD COLUMN cotmoneda Y
			ALTER table tablafactura ADD COLUMN concepto I
			ALTER table tablafactura ADD COLUMN resultado C(1)
			ALTER table tablafactura ADD COLUMN observa C(254)
			ALTER table tablafactura ADD COLUMN errores C(254)
			ALTER table tablafactura ADD COLUMN opcionales C(254)
			ALTER table tablafactura ADD COLUMN fchvtopago C(8)

			tipoCompObj 	= CREATEOBJECT('tiposcomproclass')
			v_tipoFA_MiPyme = tipoCompObj.getIdTipoCompro("FACTURA A MiPyMEs")
			v_tipoNCA_MiPyme = tipoCompObj.getIdTipoCompro("NOTA DE CREDITO A MiPyMEs")
			v_tipoNDA_MiPyme = tipoCompObj.getIdTipoCompro("NOTA DE DEBITO A MiPyMEs")
			v_tipoFB_MiPyme = tipoCompObj.getIdTipoCompro("FACTURA B MiPyMEs")
			v_tipoNCB_MiPyme = tipoCompObj.getIdTipoCompro("NOTA DE CREDITO B MiPyMEs")
			v_tipoNDB_MiPyme = tipoCompObj.getIdTipoCompro("NOTA DE DEBITO B MiPyMEs")			
			v_tipoFC_MiPyme = tipoCompObj.getIdTipoCompro("FACTURA C MiPyMEs")
			v_tipoNCC_MiPyme = tipoCompObj.getIdTipoCompro("NOTA DE CREDITO C MiPyMEs")
			v_tipoNDC_MiPyme = tipoCompObj.getIdTipoCompro("NOTA DE DEBITO C MiPyMEs")
			
			SELECT tablaFactura
			GO TOP 
			
			v_idtipocomp = tablaFactura.idtipocomp
			v_fecha30dias = ""
			****
			** AGREGO OPCIONALES PARA LOS COMPROBANTES MiPyME
			****
			
			************
			** OPCIONES: 
			************
			
*!*				** CBU Para autorización de Comprobantes MiPyMEs **
*!*					v_opcionCBU	= IIF(ALLTRIM(_SYSCBUMIPYME)='0','',ALLTRIM("2101,"+_SYSCBUMIPYME))
*!*				
*!*				** ALIAS Para autorizacion de Comprobantes MiPyMES
*!*					v_opcionALIAS =  IIF(ALLTRIM(_SYSALIASMIPYME)='0','',ALLTRIM("2102,"+_SYSALIASMIPYME))
*!*					
*!*				** Informar si se transmite de modo: 
*!*				** Agente de Depósito Colectivo (ADC) o 
*!*				** Sistema de Circulación Abierta de la Cámara de Compensación Electrónica de la República Argentina (SCA - COELSA)
*!*					v_modoADCoSCA =  "27,SCA"
*!*				
*!*				** Informar si NC / ND es de anulación
*!*					v_opcionNCNDANULA = "22,N"
*!*				
*!*				v_opcionales = ""
			DO CASE
			** Facturas 
			CASE v_idtipocomp = v_tipoFA_MiPyme 
*				v_opcionales = v_opcionCBU+";"+v_opcionALIAS+";"+v_modoADCoSCA	
				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoFB_MiPyme 
*				v_opcionales = v_opcionCBU+";"+v_opcionALIAS+";"+v_modoADCoSCA			
				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)
			CASE v_idtipocomp = v_tipoFC_MiPyme 
*				v_opcionales = v_opcionCBU+";"+v_opcionALIAS+";"+v_modoADCoSCA							
				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)


			** Notas de Crédito 
			
			CASE v_idtipocomp = v_tipoNCA_MiPyme 
*				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNCB_MiPyme 
*				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNCC_MiPyme 
*				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			** Notas de Débito
			
			CASE v_idtipocomp = v_tipoNDA_MiPyme 
*				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNDB_MiPyme 
*				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNDC_MiPyme 
*				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			OTHERWISE
*				v_opcionales = ""
			ENDCASE
*!*				
			v_opcionales = obtenerOpcionesFactura(v_idfactura)
						
			SELECT tablaFactura
			GO TOP 

			replace ALL opexento WITH 0, idmoneda WITH "PES", cotmoneda WITH 1, concepto WITH _SYSCONCEPTOAFIP,opcionales WITH ALLTRIM(v_opcionales),fchvtopago WITH v_fecha30dias 
			
			SELECT tablaFactura
			GO TOP 
*!*				cursoraxml("facimp")
			v_nombreArchivo = _SYSESTACION+"\"+"factura_"+ALLTRIM(STR(v_idfactura))+".xml"

		
			v_ret = CURSORTOXML("tablaFactura",v_nombreArchivo,1,512)
			
			IF v_ret > 0
				v_ubicacionXML = v_nombreArchivo
			ELSE
				v_ubicacionXML = ""
				RETURN 
	
			ENDIF 
	
			*** BUSCO COMPROBANTE ASOCIADO PARA NOTA DE CREDITO O NOTA DE DEBITO ***
			
			SELECT tablaFactura
			GO TOP 
			
			v_idtipocomp = tablaFactura.idtipocomp
			v_idcomproba = tablaFactura.idcomproba
			

		
			
			v_ubicacionXMLAso	= ""

			DO CASE 
				** COMPROBANTES 'A' **	
				CASE v_idtipocomp == tipoCompObj.getIdTipoCompro("NOTA DE CREDITO A")
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)
				CASE v_idtipocomp == tipoCompObj.getIdTipoCompro("NOTA DE DEBITO A")
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)					
				** COMPROBANTES 'B' **	
				
					
				CASE v_idtipocomp == tipoCompObj.getIdTipoCompro("NOTA DE CREDITO B")
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)						
				CASE v_idtipocomp == tipoCompObj.getIdTipoCompro("NOTA DE DEBITO B")
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)							
				** COMPROBANTES 'C' **	

				
				CASE v_idtipocomp == tipoCompObj.getIdTipoCompro("NOTA DE CREDITO C")
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)										
				CASE v_idtipocomp == tipoCompObj.getIdTipoCompro("NOTA DE DEBITO C")
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)							

				CASE v_idtipocomp == v_tipoNCA_MiPyme 
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)					
				
				CASE v_idtipocomp == v_tipoNDA_MiPyme 
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)					
					
				** COMPROBANTES 'B' **	


				
				CASE v_idtipocomp == v_tipoNCB_MiPyme 
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)						
				CASE v_idtipocomp == v_tipoNDB_MiPyme 
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)							
				** COMPROBANTES 'C' **	


				
				CASE v_idtipocomp == v_tipoNCC_MiPyme 
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)					
				CASE v_idtipocomp == v_tipoNDC_MiPyme 
					v_ubicacionXMLAso	= armarCompAsociadosFacXML(v_idfactura,v_idcomproba)
				
										
			ENDCASE 

			IF EMPTY(v_ubicacionXMLAso) = .F.
				v_ubicacionXML = ALLTRIM(v_ubicacionXML)+";"+ALLTRIM(v_ubicacionXMLAso)
			ENDIF 

			
			RETURN v_ubicacionXML 
			
ENDFUNC 


FUNCTION armarCompAsociadosFacXML
*#/*** Función que los comprobantes asociados en un archivo XML**
* Busca en la Base de Datos los datos del comprobante asociados al comprobate de la tabla Facturas cuyo ID es pasado como parámetro, 
* Utiliza la función CURSORTOXML, el formato del nombre xml es: 'asociados_factura_<idFactura>', donde <idFactura> es el ID en la tabla facturas
*#/** Recibe como parámetro el IDFactura
PARAMETERS p_idregistro,p_idcomproba


	v_servicioCargado = .F.
	v_compCargado = .F.
	v_ubicacionXMLA = ""

			v_idfactura = p_idFactura
			
			**** CARGA COMPROBANTE ***

			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			


			sqlmatriz(1)=" Select f.*, a.codigo as codAfip, p.puntov, tc.idtipocompro as idtipocomp  "
			sqlmatriz(2)=" from linkcompro l left join facturas f on l.idcomprobaB = f.idcomproba and l.idregistroB = f.idfactura left join comprobantes c on f.idcomproba = c.idcomproba "
			sqlmatriz(3)=" left join tipocompro tc on  c.idtipocompro = tc.idtipocompro left join afipcompro a on  tc.idafipcom = a.idafipcom left join puntosventa p on f.pventa = p.pventa "
			sqlmatriz(4)=" where l.idregistroa = "+ ALLTRIM(STR(v_idfactura))+" and l.idcomprobaa = "+ALLTRIM(STR(p_idcomproba))+ " and c.tabla = 'facturas' and p.electronica = 'S' "

			verror=sqlrun(vconeccionF,"factuA_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la factura a cargar ",0+48+0,"Error")
			    *thisform.comprobantecargado = .f.
			    v_compCargado = .F.
			ENDIF 
			SELECT FactuA_sql
			GO TOP 
						
			SELECT f.*,f.cuit as nrodoccli, f.neto as netocomp ;
			FROM factuA_sql f INTO TABLE tablaAsoFac


			sqlmatriz(1)=" Select f.*, a.codigo as codAfip, p.puntov, tc.idtipocompro as idtipocomp  "
			sqlmatriz(2)=" from linkcompro l left join facturas f on l.idcomprobaA = f.idcomproba and l.idregistroA = f.idfactura left join comprobantes c on f.idcomproba = c.idcomproba "
			sqlmatriz(3)=" left join tipocompro tc on  c.idtipocompro = tc.idtipocompro left join afipcompro a on  tc.idafipcom = a.idafipcom left join puntosventa p on f.pventa = p.pventa "
			sqlmatriz(4)=" where l.idregistrob = "+ ALLTRIM(STR(v_idfactura))+" and l.idcomprobab = "+ALLTRIM(STR(p_idcomproba))+ " and c.tabla = 'facturas' and p.electronica = 'S' "

			verror=sqlrun(vconeccionF,"factuB_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la factura a cargar ",0+48+0,"Error")
			    *thisform.comprobantecargado = .f.
			    v_compCargado = .F.
			ENDIF 
			SELECT FactuB_sql
			GO TOP 
						
			SELECT f.*,f.cuit as nrodoccli, f.neto as netocomp ;
			FROM factuB_sql f INTO TABLE tablaAsoFacB


			SELECT tablaAsoFacB
			
			APPEND FROM tablaAsoFac


			SELECT tablaAsoFac
			GO TOP 

			
*!*				ALTER table tablafactura add COLUMN opexento Y 
*!*				ALTER table tablafactura ADD COLUMN idmoneda C(3)
*!*				ALTER table tablafactura ADD COLUMN cotmoneda Y
*!*				ALTER table tablafactura ADD COLUMN concepto I
*!*				ALTER table tablafactura ADD COLUMN resultado C(1)
*!*				ALTER table tablafactura ADD COLUMN observa C(254)
*!*				ALTER table tablafactura ADD COLUMN errores C(254)

			

			
			SELECT tablaAsoFac
			GO TOP 
			
		
			
*!*				cursoraxml("facimp")
			v_nombreArchivoA = _SYSESTACION+"\"+"asociados_factura_"+ALLTRIM(STR(v_idfactura))+".xml"

		
			v_ret = CURSORTOXML("tablaAsoFac",v_nombreArchivoA,1,512)
			
			IF v_ret > 0
				v_ubicacionXMLA = v_nombreArchivoA 
			ELSE
				v_ubicacionXMLA = ""
				RETURN 
	
			ENDIF 
	
	
			
			
			
			
			RETURN v_ubicacionXMLA 
			
ENDFUNC 



FUNCTION cfgmenues
	vpathejecuta= _SYSSERVIDOR+_SYSMENUPATH
	vejecutable = "menu.exe "+_SYSMASTER_SERVER+" "+_SYSMASTER_SCHEMA+" "+_SYSMASTER_USER+" "+_SYSMASTER_PASS+" "+_SYSMASTER_PORT+" "+_SYSMYSQL_SERVER+" "+_SYSMYSQL_PORT+" "+_SYSSCHEMA+" "+STRTRAN(_SYSDRVMYSQL," ","|")+" "+_SYSUSUARIO+" 1 "+vpathejecuta+" "+_SYSSERVIDOR
	=ejecutarexe(vpathejecuta, vejecutable)
ENDFUNC 




FUNCTION UpDwViFile
PARAMETERS pud_path, pud_arch, pud_updw, pud_conex, pud_tabla, pud_cpoix, pud_valid, pud_cponom, pud_cpoar
*#/----------------------------------------
* Funcion para insertar y descargar archivos de la base de datos 
* PARAMETROS 
* pud_path	= path completo del archivo a subir o path donde descargarlo
* pud_arch	= nombre del archivo a subir 
* pud_updw = ux: sube el archivo a la base, dx: descarga el archivo de la base, uv: sube y muestra el archivo, dv: descarga y muestra el archivo 
* pud_conex = puntero a la conexion de la base de datos 
* pud_tabla = nombre de tabla en la cual se insertara el archivo o se descargara
* pud_cpoix = nombre del campo indice por el cual buscar
* pud_valid = valor del campo para realizar la busqueda (Puede ser Caracter o Entero)
* pud_cponom= nombre del campo que contiene el nombre del archivo
* pud_cpoar = nombre del campo en el cual se insertara el archivo o se descargara
*
*Ej Upload 		= updownfile("c:\temp\","archivo.txt","UV-",vconeccion,"empresa","empresa","NombreEmpresa","nombrecert","certificado" ) 
*Ej Download 	= updownfile("c:\temp\","","DVC",vconeccion,"empresa","empresa","NombreEmpresa","nombrecert","certificado") 
*#/----------------------------------------
	v_mostrar = .t.	
	IF !EMPTY(pud_path) THEN 
		IF !(SUBSTR(pud_path,LEN(ALLTRIM(pud_path)),1)="\") THEN 
			pud_path = ALLTRIM(pud_path)+"\"
		ENDIF 
	ENDIF 

	v_archivo_nom= IIF(EMPTY(pud_path) or EMPTY(pud_arch),"",ALLTRIM(pud_path)+ALLTRIM(pud_arch)) 

	IF TYPE('pud_valid') = 'C' THEN
		pud_valid_a = "'"+ALLTRIM(pud_valid)+"'"
	ELSE
		pud_valid_a = ALLTRIM(STR(pud_valid))
	ENDIF  

	IF LEN(pud_updw) < 1 THEN 
		RETURN ""
	ENDIF 
	
	IF SUBSTR(UPPER(ALLTRIM(pud_updw)),1,1) = "U" && subir archivo
	
			IF !EMPTY(v_archivo_nom) THEN 
				v_archivo_ins= STRCONV(FILETOSTR(v_archivo_nom),13)
			ELSE
				v_archivo_ins=  ""
				RETURN ""
			ENDIF 
			
				
	
			sqlmatriz(1)=" update "+ALLTRIM(pud_tabla)+" set "+pud_cponom+"='"+STRTRAN(ALLTRIM(pud_arch),' ','_')+"', "
			sqlmatriz(2)=ALLTRIM(pud_cpoar)+"='"+v_archivo_ins+"' " 
			sqlmatriz(3)=" where "+ALLTRIM(pud_cpoix)+" = "+pud_valid_a

			verror=SQLEXEC(pud_conex,sqlmatriz(1)+sqlmatriz(2)+sqlmatriz(3),"updn_ar")
			IF verror < 0
				MESSAGEBOX("No se puede incertar el reporte Seleccionado ",0+16,"Advertencia")
				RETURN ""
			ENDIF 
			sqlmatriz(1)=""
			sqlmatriz(2)=""
			sqlmatriz(3)=""

	ENDIF 
	
	IF SUBSTR(UPPER(ALLTRIM(pud_updw)),1,1) = "D" && descargar archivo

			sqlmatriz(1)=" select "+pud_cponom+" as nombre, "+ALLTRIM(pud_cpoar)+" as archivo from "+ALLTRIM(pud_tabla)
			sqlmatriz(2)=" where "+ALLTRIM(pud_cpoix)+" = "+pud_valid_a

			verror=SQLEXEC(pud_conex,sqlmatriz(1)+sqlmatriz(2),"updn_ar")
			sqlmatriz(1)=""
			sqlmatriz(2)=""
			
			IF verror < 0
			    MESSAGEBOX("Ha Ocurrido un Error en la inserción de Archivos ",0+48+0,"Error")
			   	USE IN updn_ar
			    RETURN ""
			ENDIF 
			SELECT updn_ar
			GO TOP 
			IF !EOF() THEN 
				IF !EMPTY(updn_ar.nombre) AND !EMPTY(updn_ar.archivo) THEN 
					v_archivo_down = _SYSESTACION+'\'+ALLTRIM(updn_ar.nombre)
					STRTOFILE(STRCONV(updn_ar.archivo,14),v_archivo_down)

					v_archivo_nom = v_archivo_down 

					IF LEN(pud_updw) >= 3 THEN 
						IF SUBSTR(UPPER(ALLTRIM(pud_updw)),3,1) = "C"  && Copiar a Ubicacion especifica
							IF EMPTY(ALLTRIM(pud_path)) THEN 
								v_archivo_copy = ALLTRIM(pud_path)+ALLTRIM(updn_ar.nombre)
								v_ext=JUSTEXT(ALLTRIM(updn_ar.nombre))
								v_rnom= STRTRAN(updn_ar.nombre,'.'+v_ext,'')
								v_drv = SYS(5)+'\'
								SET DEFAULT TO &v_drv
								v_nuevo_archivo = ALLTRIM(PUTFILE("Archivo",v_rnom,v_ext))
								v_nuevo_nombre = JUSTFNAME(v_nuevo_archivo)
								SET DEFAULT TO &_SYSESTACION
								IF EMPTY(v_nuevo_nombre) THEN 
									MESSAGEBOX("Debe elegir una ubicacion y un nombre para el archivo a Descargar...",0+64,"Descarga de Archivos")
									v_mostrar = .f.
								ELSE 
									v_archivo_copy = v_nuevo_archivo
									v_ejecutar = "COPY FILE (v_archivo_nom) TO (v_archivo_copy)"
									&v_ejecutar				
									v_archivo_nom = v_archivo_copy
								ENDIF 
							
							ELSE 
								v_archivo_copy = ALLTRIM(pud_path)+ALLTRIM(updn_ar.nombre)
								v_ejecutar = "COPY FILE (v_archivo_nom) TO (v_archivo_copy)"
								&v_ejecutar				
								v_archivo_nom = v_archivo_copy
							ENDIF 
							
						ENDIF 
					ENDIF 

				ELSE
					USE IN updn_ar 
					RETURN ""
				ENDIF 
			ELSE 
			   	USE IN updn_ar
			   	RETURN ""
			ENDIF 
			USE IN updn_ar		
	ENDIF 

	IF LEN(pud_updw) >= 2 AND v_mostrar = .t. THEN 
		IF SUBSTR(UPPER(ALLTRIM(pud_updw)),2,1) = "V" AND !EMPTY(ALLTRIM(v_archivo_nom)) && Mostrar Archivo
			APLIC=CREATEOBJECT("WSCript.Shell")
			APLIC.RUN(v_archivo_nom)
			RELEASE APLIC 
		ENDIF 
	ENDIF 
	IF v_mostrar = .f. THEN 
		v_archivo_nom = ""
	ENDIF 
	RETURN ALLTRIM(v_archivo_nom)
	
ENDFUNC 





FUNCTION  actualizarComp
PARAMETERS p_idregistro, p_tabla
*#/----------------------------------------
*Funcion que cambia la fecha del comprobante y el CUIT
*
*Parametros:ID del comprobante, tabla
*Retorna True o False en caso de que se haya registrado correctamente o no 
*#/----------------------------------------


	v_retorno = .F.
	IF p_idregistro > 0
	
		IF TYPE('_SYSMODFECHAFAC') = 'U' && SI no está definida -> Actua como si no tuviera que modificar
			RETURN .T.
		ENDIF 
		IF _SYSMODFECHAFAC = 'N'
			RETURN .T.
		
		ENDIF 

		**** Busca datos comprobante ***

			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			

			sqlmatriz(1)=" Select f.*,e.cuit as cuitEnt "
			sqlmatriz(2)=" from  "+ALLTRIM(p_tabla) +" f left join entidades e on f.entidad = e.entidad "
			sqlmatriz(3)=" where f.idfactura = "+ALLTRIM(STR(p_idregistro))

			verror=sqlrun(vconeccionF,"facturaConsulta")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los datos de la factura ",0+48+0,"Error")
				RETURN .F.
			ELSE
			
			
				SELECT facturaConsulta
				GO TOP 
				
				IF NOT EOF()
				
					v_cuitEntidad = ALLTRIM(STRTRAN(facturaConsulta.cuitEnt,'-',''))		
					v_fechaActual = DTOS(DATE())
					*** Modifico la cabecera del reclamo ***
					DIMENSION lamatriz(1,2)
					
					
					lamatriz(1,1)='fecha'
					lamatriz(1,2)="'"+ALLTRIM(v_fechaActual)+"'"
*!*						lamatriz(2,1)='CUIT'
*!*						lamatriz(2,2)="'"+ALLTRIM(v_cuitEntidad)+"'"
					
					
					vconeccionA=abreycierracon(0,_SYSSCHEMA)	
					
					p_tipoope   = 'U'
					p_condicion = "idfactura = "+ALLTRIM(STR(p_idregistro))
					v_titulo    = " EL MODIFICACION "
					p_tabla     = ALLTRIM(v_tabla)
					p_matriz    = 'lamatriz'
					p_conexion  = vconeccionA
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en ",0+48+0,"Error")

					   v_retorno = .F.
					  ELSE
					  v_retorno = .T.
					ENDIF  
						* me desconecto	
					=abreycierracon(vconeccionA,"")
				ELSE 
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los datos de la factura ",0+48+0,"Error")
					RETURN .F.
				ENDIF 

				
			ENDIF 
	
		
	ELSE
		v_retorno = .F.
	ENDIF 
		RETURN v_retorno

ENDFUNC 



FUNCTION movimientoTPago
PARAMETERS P_idtipocompro, P_idtipopago, P_idcajareca, P_idcuenta
*#/----------------------------------------
*** Retorna el tipo de movimiento registrado según el comprobante, el tipo de pago, la cuenta y la caja
** Parametros:
**		P_idtipocompro: ID del tipo de comprobante
**		P_idtipopago: ID del tipo de pago que se está realizando
**		P_idcajareca: ID de la caja registradora (SI es 0, significa que va a obtener cualquier caja)
**		P_idcuenta: ID de la cuenta (SI es 0, significa que va a obtener cualquier cuenta)
**
** Retorno: Retorna el movimiento registrado para la combinación de parámetros
*#/----------------------------------------

	
	v_retorno = ""
	
	IF P_idtipocompro > 0 AND P_idtipopago > 0 AND P_idcajareca >= 0 AND P_idcuenta >= 0
	
		&& Están correctos los parámetros	
	ELSE
	
		v_retorno  = ""
	
		RETURN v_retorno
	
	ENDIF 
	
	vconeccionM = abreycierracon(0,_SYSSCHEMA)
	
	*** Busco los cheques relacionados a detallecobros ***
	

*!*		sqlmatriz(1)=" select idtipocompro, idtipopago,idcajareca, idcuenta, movimiento, (if(idcajareca = 0,0,1)*2+if(idcuenta = 0,0,1)) as valor "
*!*		sqlmatriz(2)=" FROM pmovitp "
*!*		sqlmatriz(3)=" where idtipocompro = "+ALLTRIM(STR(p_idtipocompro))+" and idtipopago = "+ALLTRIM(STR(P_idtipopago))
	
		sqlmatriz(1)= " select idtipocompro, idtipopago,idcajareca, idcuenta, movimiento, ((if(idtipocompro = " +ALLTRIM(STR(p_idtipocompro))+" or idtipocompro = 0,1,0)) + "
		sqlmatriz(2)= " (if(idtipopago = "+ALLTRIM(STR(p_idtipopago))+" or idtipopago = 0,1,0)) + (if(idcajareca = "+ALLTRIM(STR(P_idcajareca))+" or idcajareca = 0,1,0)) + "
		sqlmatriz(3)= " (if(idcuenta = "+ALLTRIM(STR(P_idcuenta))+" or idcuenta = 0,1,0))) as coincide, (if(idtipopago = 0,0,1)*4+if(idcuenta = 0,0,1)*2+if(idcajareca = 0,0,1)) as valor "
		sqlmatriz(4)= " FROM pmovitp  having coincide = 4 order by valor desc "

	verror=sqlrun(vconeccionM ,"pmovitp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los parámetros de movimientos ",0+48+0,"Error")
	    RETURN ""  
	ENDIF
	
	=abreycierracon(vconeccionM ,"")	

	SELECT pmovitp_sql
	GO TOP 

	IF NOT EOF()
		
		v_retorno = pmovitp_sql.movimiento
		
	ELSE
		v_retorno = ""
	
	ENDIF 


	RETURN v_retorno

ENDFUNC 



FUNCTION guardarMoviTPago
PARAMETERS p_idtipopago, p_tabla, p_campo, p_idregistro, p_idcajareca,p_idcuenta,P_idtipocompro, p_tablacp, p_campocp, p_idregistrocp

*#/----------------------------------------
*** Guardo un registro en la tabla de movitpago
** PARAMETROS: 
**	P_idtipopago: ID del tipo de pago que se quiere registrar
**	P_tabla: Nombre de la tabla asociada al tipo de pago ('CHEQUE', 'CUPON'...) 
**	P_campo: Nombre del campo indice de la tabla
**	P_idregistro: Numero de registro de la tabla correspondiente al campo pasado como parámetro
**	P_idacajareca: ID de la caja recaudadora (Si es 0 se puede tomar como que es para cualquier caja) 
**	P_idcuenta: ID de la cuenta (Si es 0 se puede tomar como que es para cualquier caja)
**  P_idcomproba: ID del tipo de comprobante 
**  P_tablacp: Nombre de la Tabla de Detalle asociada al comprobante que origina el pago ('DETALLECOBRO','DETALLEPAGO'...)
**  P_campocp: Nombre del campo indice de la tabla Asociada al cobro
**  P_idregistrocp: Numero de registro indice correspondiente al campo pasado como p_campocp
**	Retorno: Retorna True si se guardó correctamente, False en otro caso
*#/----------------------------------------
			
	v_retorno = .F.	

	v_movimiento	=  movimientoTPago(P_idtipocompro, P_idtipopago, P_idcajareca, P_idcuenta)

	IF EMPTY(ALLTRIM(v_movimiento)) == .T. && No retorno ningún movimiento, no se va a registrar el movimiento
		v_retorno = .F.
		RETURN v_retorno
	
	ENDIF 

	v_fecha			= DTOS(DATE())
	v_hora			= TIME()
	
	vp_tablacp 		= IIF(TYPE('p_tablacp')='C',p_tablacp,"")
	vp_campocp 		= IIF(TYPE('p_campocp')='C',p_campocp,"")
	vp_idregistrocp = IIF(TYPE('p_idregistrocp')='N',p_idregistrocp,0)
	v_tablafecha 	= ""
	v_indiceFecha	= ""
	
	vconeccionMo = abreycierracon(0,_SYSSCHEMA)

   ** && busco la fecha del comprobante asociado
 	IF !EMPTY(vp_tablacp) AND !EMPTY(vp_campocp) AND vp_idregistrocp > 0  AND (ALLTRIM(vp_tablacp) == 'detallecobros' OR ALLTRIM(vp_tablacp)== 'detallepagos' OR ALLTRIM(vp_tablacp)== 'cajamovih' )THEN 
		
		IF ALLTRIM(vp_tablacp) == 'detallecobros' OR ALLTRIM(vp_tablacp) == 'detallepagos' THEN 
			sqlmatriz(1)= " select c.tabla from "+ALLTRIM(vp_tablacp)+" t left join comprobantes c on c.idcomproba = t.idcomproba "
			sqlmatriz(2)= " where "+ALLTRIM(vp_campocp)+" = "+ALLTRIM(STR(vp_idregistrocp))
		ENDIF 

		IF ALLTRIM(vp_tablacp) == 'cajamovih' THEN 
			sqlmatriz(1)= " select c.tabla from cajamovih h left join cajamovip t on t.idcajamovp = h.idcajamovp"
			sqlmatriz(2)= " left join comprobantes c on c.idcomproba = t.idcomproba "
			sqlmatriz(3)= " where "+ALLTRIM(vp_campocp)+" = "+ALLTRIM(STR(vp_idregistrocp))		
		ENDIF 
		
		verror=sqlrun(vconeccionMo ,"tablacompro_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la Tabla del Movimiento de Tipo de Pagos ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT tablacompro_sql
		GO TOP 
		IF !EOF() THEN 	
			v_tablafecha = tablacompro_sql.tabla
		ENDIF 
		USE IN tablacompro_sql
		IF !EMPTY(v_tablafecha) THEN 
			v_IndiceFecha	 = obtenerCampoIndice(ALLTRIM(v_tablafecha))
		ENDIF 

		IF !EMPTY(v_IndiceFecha) THEN 
		
			DO CASE 
				CASE ALLTRIM(vp_tablacp) == 'detallecobros' OR ALLTRIM(vp_tablacp) == 'detallepagos'
				sqlmatriz(1) = " select c.fecha from "+ALLTRIM(vp_tablacp)+"  dc "
				sqlmatriz(2) = " left join "+ALLTRIM(v_tablafecha)+" c on dc.idregistro = c."+ALLTRIM(v_IndiceFecha)
				sqlmatriz(3) = " where dc."+ALLTRIM(vp_campocp)+" = "+ALLTRIM(STR(vp_idregistrocp))
			
				CASE ALLTRIM(vp_tablacp) == 'cajamovih'
				sqlmatriz(1) = " select c.fecha from "+ALLTRIM(vp_tablacp)+"  dc "
				sqlmatriz(2) = " left join "+ALLTRIM(v_tablafecha)+" c on dc.idcajamovp = c."+ALLTRIM(v_IndiceFecha)
				sqlmatriz(3) = " where dc."+ALLTRIM(vp_campocp)+" = "+ALLTRIM(STR(vp_idregistrocp))
				
				OTHERWISE 
				
			ENDCASE 
			
			verror=sqlrun(vconeccionMo ,"compromovi_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Comprobantes para Registrar Movimiento de Pagos ",0+48+0,"Error")
			    RETURN ""  
			ENDIF	
			SELECT compromovi_sql
			GO TOP 
			IF !EOF() THEN 	
				v_fecha = compromovi_sql.fecha
			ENDIF 
			USE IN compromovi_sql
			
		ENDIF 
	ENDIF 
	


	
	DIMENSION lamatriz3(13,2)
	
		
	lamatriz3(1,1)='idmovitp'
	lamatriz3(1,2)= "0"
	lamatriz3(2,1)='idtipopago'
	lamatriz3(2,2)= ALLTRIM(STR(p_idtipopago))
	lamatriz3(3,1)='tabla'
	lamatriz3(3,2)= "'"+ALLTRIM(P_tabla)+"'"
	lamatriz3(4,1)='campo'
	lamatriz3(4,2)= "'"+ALLTRIM(P_campo)+"'"
	lamatriz3(5,1)='idregistro'
	lamatriz3(5,2)= ALLTRIM(STR(P_idregistro))
	lamatriz3(6,1)='idcajareca'
	lamatriz3(6,2)= ALLTRIM(STR(P_idcajareca))
	lamatriz3(7,1)='idcuenta'
	lamatriz3(7,2)=ALLTRIM(STR(P_idcuenta))
	lamatriz3(8,1)='fecha'
	lamatriz3(8,2)="'"+ALLTRIM(v_fecha)+"'"
	lamatriz3(9,1)='hora'
	lamatriz3(9,2)="'"+ALLTRIM(v_hora)+"'"
	lamatriz3(10,1)='movimiento'
	lamatriz3(10,2)="'"+ALLTRIM(v_movimiento)+"'"
	lamatriz3(11,1)='tablacp'
	lamatriz3(11,2)="'"+ALLTRIM(vp_tablacp)+"'"
	lamatriz3(12,1)='campocp'
	lamatriz3(12,2)="'"+ALLTRIM(vp_campocp)+"'"
	lamatriz3(13,1)='idregicp'
	lamatriz3(13,2)=ALLTRIM(STR(vp_idregistrocp))
	
	
	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
	p_tabla     = 'movitpago'
	p_matriz    = 'lamatriz3'
	p_conexion  = vconeccionMo
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
	
		=abreycierracon(vconeccionMo ,"")	

	    RETURN .F.
	ENDIF	
	=abreycierracon(vconeccionMo ,"")	
	RETURN .T.

ENDFUNC 

*!*	FUNCTION moviTipoPago
*!*	PARAMETERS p_idtipopago,p_idcaja,p_idcuenta,p_tabla,p_campo,p_idregistro,p_movimiento,p_tablaRet
*!*	*#/----------------------------------------
*!*	*** Funcion de busqueda de los ultimos movimientos de Tipos de pago según los parametros pasados como parámetros
*!*	**  Si el parámetro recibido es CERO, lo ignora en la condición trayendo todos los registros para ese parámetro
*!*	** Parametros:
*!*	*	p_idtipopago: ID del tipo de pago 
*!*	* 	p_idcaja:	ID de la caja registradora
*!*	*	p_idcuenta: ID de la cuenta
*!*	*	p_tabla,p_campo,p_idregistro: Tabla, campo e ID del registro asociado al tipo de pago
*!*	*	p_movimiento: movimiento registrado
*!*	*	p_tablaRet: Nombre de la tabla de retorno
*!*	*** Retorno: Retorna True si se obtuvo correctamente los registros del movimiento; False en otro caso.
*!*	*#/----------------------------------------


*!*		tipoPagoObj 	= CREATEOBJECT('tipospagosclass')


*!*		v_idtipoCupones = tipoPagoObj.gettipospagos("CUPONES")
*!*		v_idTipoCheque 	= tipoPagoObj.gettipospagos("CHEQUE")



*!*		v_registro = IIF(EMPTY(ALLTRIM(p_tabla)) = .T. or EMPTY(ALLTRIM(p_campo)) = .T. or p_idregistro = 0,.F.,.T.)

*!*		v_valorTp= IIF(P_idtipopago > 0," and u.idtipopago = "+ALLTRIM(STR(p_idtipopago)),"")
*!*		v_valorCa=IIF(P_idcaja > 0," and u.idcajareca = "+ALLTRIM(STR(P_idcaja)),"")
*!*		v_valorCu=IIF(P_idcuenta > 0," and u.idcuenta = "+ALLTRIM(STR(P_idcuenta)),"")
*!*		v_valorRe=IIF(p_idregistro > 0," and u.tabla = '"+ALLTRIM(p_tabla)+ "' and u.campo = '"+ALLTRIM(p_campo)+"' and u.idregistro = "+ALLTRIM(STR(p_idregistro)),"")
*!*		v_valorMo=IIF(EMPTY(ALLTRIM(p_movimiento)) =.F.," and u.movimiento = '"+ALLTRIM(p_movimiento)+"'","")

*!*		
*!*		v_condicion = ALLTRIM(v_valorTP)+ALLTRIM(v_valorCa)+ALLTRIM(v_valorCu)+ALLTRIM(v_valorRe)+ALLTRIM(v_valorMo)
*!*		vconeccionMo = abreycierracon(0,_SYSSCHEMA)
*!*		
*!*		DO CASE
*!*			CASE p_idtipopago == 0 && Todos los tipos de pagos
*!*				sqlmatriz(1)=" select u.* "
*!*				sqlmatriz(2)=" from ultimomovitpago u "
*!*				sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)
*!*		
*!*			CASE v_idtipoCupones == p_idtipopago && Cupones

*!*				sqlmatriz(1)=" select u.*,c.idtarjeta,c.numero,c.tarjeta,c.fecha as fechatar, c.importe, c.vencimiento as venc, c.titular,c.codautoriz"
*!*				sqlmatriz(2)=" from ultimomovitpago u "
*!*				sqlmatriz(3)=" left join cupones c on u.idregistro = c.idcupon "
*!*				sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)
*!*			CASE v_idTipoCheques == p_idtipopago && Cheques
*!*				sqlmatriz(1)=" select u.*,c.serie, c.numero,c.importe,c.fechaemisi, c.fechavence,c.alaorden,c.librador,c.loentrega,c.cuit, "
*!*				sqlmatriz(2)=" c.cuenta,c.idbanco,c.codcheque,c.detercero,c.lugaremi,c.domilib,c.electro "
*!*				sqlmatriz(3)=" from ultimomovitpago u "
*!*				sqlmatriz(4)=" left join cheques c on u.idregistro = c.idcheque "
*!*				sqlmatriz(5)=" where 1 = 1 "+ALLTRIM(v_condicion)
*!*			
*!*			OTHERWISE
*!*					
*!*				MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los movimientos ",0+48+0,"Error")
*!*				=abreycierracon(vconeccionMo ,"")	
*!*		    	RETURN .F.  
*!*		ENDCASE
*!*		
*!*		



*!*		verror=sqlrun(vconeccionMo ,p_tablaRet)
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los movimientos ",0+48+0,"Error")
*!*		=abreycierracon(vconeccionMo ,"")	
*!*		    RETURN .F.  
*!*		ENDIF
*!*		
*!*		=abreycierracon(vconeccionMo ,"")	
*!*		RETURN .T.

*!*	ENDFUNC 




FUNCTION ContabilizaMov
PARAMETERS pcont_tabla, pcont_id, pcont_conex
*#/----------------------------------------
*/ Contabilizacion de Operaciones
* Recibe como parametros la tabla, el Idregistro y la conexion, 
* Verifica que el registro de la tabla pasada ya no esté contabilizado , si es asi no contabiliza, 
* de otra manera genera y graba el asiento.
*  RETORNA : NUMERO DE ASIENTO GENERADO "IDASIENTO", 
* 		   : 0 SI NO GENERO EL ASIENTO 
*		   : -1 SI NO LO GENERÓ Y EL OPERADOR DEBIERA INGRESARLO, esto se controla con una variable publica : _SYSMCONTABLE de seteo 
*			que indica si el operador debe ingresar o no los asientos al no encontrar un modelo adecuado
**          : -2 NO Generó el Asiento porque no está habilitado el Módulo Contable
*#/----------------------------------------
	
	ret_idasiento = 0
	
	IF TYPE('_SYSCONTABLE') <> 'N' THEN 
		ret_idasiento = -2
		RETURN ret_idasiento 
	ELSE 
		IF _SYSCONTABLE < 0 OR _SYSCONTABLE > 3  THEN 
			ret_idasiento = -2
			RETURN ret_idasiento 		
		ENDIF 
		IF _SYSCONTABLE = 0 THEN 
			ret_idasiento = -2
			RETURN ret_idasiento 					
		ENDIF 
		IF _SYSCONTABLE = 3 THEN 
			ret_idasiento = -1
		ENDIF 
	ENDIF 
	IF pcont_conex = 0 THEN 
		vcone_conta=abreycierracon(0,_SYSSCHEMA)
	ELSE
		vcone_conta = pcont_conex
	ENDIF 

	* Verifico Si el comprobante pasado para contabilizar tiene habilitada la contabilización
	sqlmatriz(1)= " select * from comprobantes where TRIM(tabla) = '"+ALLTRIM(pcont_tabla)+"'"
	verror=sqlrun(vcone_conta ,"escompro_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Comprobantes ",0+48+0,"Error")
	    RETURN ""  
	ENDIF	
	SELECT escompro_sql
	GO TOP 

	IF !EOF() AND RECNO() = 1 THEN 
		vnombreidx = obtenerCampoIndice(ALLTRIM(pcont_tabla))
		sqlmatriz(1)= " select t.idcomproba, c.astoconta, t.fecha from "+ALLTRIM(pcont_tabla)+" t "
		sqlmatriz(2)= " left join comprobantes c on c.idcomproba = t.idcomproba "
		sqlmatriz(3)= " where "+ALLTRIM(vnombreidx)+" = "+alltrim(STR(pcont_id))
		
		verror=sqlrun(vcone_conta ,"asentar_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda movimientos de tablas ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT asentar_sql
		
		IF asentar_sql.astoconta = 'N' OR asentar_sql.fecha < _SYSFEINICONTA THEN 
			ret_idasiento = -2
		ENDIF 
		USE IN asentar_sql
	ENDIF 
	USE IN escompro_sql



	* Verifico si el registro pasado ya no está contabilizado , si es que tiene que contabilizarlo *

	IF ret_idasiento = 0 THEN 
		sqlmatriz(1)= " select idastocompro, idasiento, idregicomp, tabla  "
		sqlmatriz(2)= " from asientoscompro where tabla = '"+ALLTRIM(pcont_tabla)+"' and idregicomp="+alltrim(STR(pcont_id))
		verror=sqlrun(vcone_conta ,"conta_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los parámetros de movimientos ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT conta_sql
		GO TOP 


		IF !EOF() AND RECNO() = 1 THEN 
			 ret_idasiento = conta_sql.idasiento
		ELSE  
		    *********************************************************
			para_tablaret 	= 'astopropuesto'
			para_tabla 			= ALLTRIM(pcont_tabla)
			para_registro 		= pcont_id
			para_filtromodelo	= FiltroAstoModelo (para_tabla, para_registro,vcone_conta)

			IF !EMPTY(para_filtromodelo) THEN 
				para_filtro 	= INT(VAL(SUBSTR(para_filtromodelo,1,4)))
				para_modelo 	= INT(VAL(SUBSTR(para_filtromodelo,5,4)))

				
			* Verifico si el Modelo Seleccionado indica que debe generar asiento o es un movimiento sin asiento Contable 
				sqlmatriz(1)= " select asiento from astomodelo where idastomode = "+ALLTRIM(STR(para_modelo))
				verror=sqlrun(vcone_conta ,"siasienta_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Asiento Modelo para ver si Corresponde Asentar ",0+48+0,"Error")
				    RETURN ""  
				ENDIF	
				SELECT siasienta_sql
				GO TOP 
				IF !EOF() AND siasienta_sql.asiento = 'N' THEN 
						ret_idasiento = -2
				ELSE 

					rettabla=GenAstoContable(para_modelo, para_tabla, para_registro,para_filtro,1,1,para_tablaret)					
					IF !EMPTY(rettabla) THEN 
						var_grabo = IncerAstoContable(rettabla) && Graba el Asiento recibido como parametro 
						ret_idasiento = var_grabo
					ENDIF 
					
				ENDIF 
				USE IN siasienta_sql
			*****************************
			ENDIF 
		ENDIF 
	ENDIF 
		
	IF pcont_conex = 0 THEN 
		=abreycierracon(vcone_conta,"")
	ENDIF 

	IF (_SYSCONTABLE = 1 OR _SYSCONTABLE = 3) AND ret_idasiento = 0 THEN 
		ret_idasiento = -1
		
	ENDIF 

	RETURN ret_idasiento
ENDFUNC 





FUNCTION ContabilizaManual
	PARAMETERS pcont_tabla, pcont_id, pcont_conex, pcont_tasiento
*#/----------------------------------------
*/ Contabilizacion de Operaciones Manuales
* Recibe como parametros la tabla, el Idregistro y la conexion, 
* Verifica que el registro de la tabla pasada ya no esté contabilizado , si es asi no contabiliza, 
* de otra manera genera y graba el asiento.
*  RETORNA : NUMERO DE ASIENTO GENERADO "IDASIENTO", 
* 		   : 0 SI NO GENERO EL ASIENTO 
*#/----------------------------------------
	
	reto_idasiento = 0
	IF TYPE('_SYSCONTABLE') <> 'N' THEN 
		reto_idasiento = -2
		RETURN reto_idasiento 
	ELSE 
		IF _SYSCONTABLE < 0 OR _SYSCONTABLE > 3  THEN 
			reto_idasiento = -2
			RETURN ret_idasiento 		
		ENDIF 
		IF _SYSCONTABLE = 0 THEN 
			reto_idasiento = -2
			RETURN ret_idasiento 					
		ENDIF 
		IF _SYSCONTABLE = 3 THEN 
			reto_idasiento = -1
		ENDIF 
	ENDIF 
	IF pcont_conex = 0 THEN 
		vcone_conta=abreycierracon(0,_SYSSCHEMA)
	ELSE
		vcone_conta = pcont_conex
	ENDIF 

	* Verifico si el registro pasado ya no está contabilizado , si es que tiene que contabilizarlo *

		sqlmatriz(1)= " select idastocompro, idasiento, idregicomp, tabla  "
		sqlmatriz(2)= " from asientoscompro where tabla = '"+ALLTRIM(pcont_tabla)+"' and idregicomp="+alltrim(STR(pcont_id))
		verror=sqlrun(vcone_conta ,"conta_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los parámetros de movimientos ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT conta_sql
		GO TOP 
		IF !EOF() AND RECNO() = 1 THEN 
			reto_idasiento = conta_sql.idasiento
			USE IN conta_sql 
		ELSE  
		    *********************************************************
			USE IN conta_sql 
			v_nomIndice	 = obtenerCampoIndice(ALLTRIM(pcont_tabla))
			v_detallecom = fdescribecompro(pcont_tabla,v_nomIndice,pcont_id)

			para_tablaret 		= 'astopropuesto'
			para_tabla 			= ALLTRIM(pcont_tabla)
			para_registro 		= pcont_id
			para_filtromodelo	= FiltroAstoModelo (para_tabla, para_registro,vcone_conta)

			IF !EMPTY(para_filtromodelo) THEN 
				para_filtro 	= INT(VAL(SUBSTR(para_filtromodelo,1,4)))
				para_modelo 	= INT(VAL(SUBSTR(para_filtromodelo,5,4)))
				rettabla=GenAstoContable(para_modelo, para_tabla, para_registro,para_filtro,1,1,para_tablaret)
			ELSE
				rettabla = ""
			ENDIF 	
 
 			DO FORM abmasientosconta WITH 0, rettabla,v_detallecom, pcont_tasiento	TO reto_idasiento	&& LLama a la Carga de Asientos con un asiento predeterminado


			IF reto_idasiento > 0 THEN 

			*** INSERTO LA RELACION CON EL COMPROBANTE***			

				*** SI HUBIERE ALGUNA RELACION CON EL COMPROBANTE DE ALGUN ASIENTO ANTES ***
				sqlmatriz(1)=" DELETE FROM asientoscompro WHERE tabla = '"+ALLTRIM(para_tabla)+"' and idregicomp="+ALLTRIM(STR(para_registro))
				verror=sqlrun(vcone_conta,"asiento1")

				DIMENSION lamatrizR(4,2)
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
						
						*thisform.calcularmaxh
				v_idastocompro = maxnumeroidx("idastocompro","I","asientoscompro",1,.T.)
							
				lamatrizR(1,1)='idastocompro'
				lamatrizR(1,2)=ALLTRIM(STR(v_idastocompro))
				lamatrizR(2,1)='idasiento'
				lamatrizR(2,2)=ALLTRIM(STR(reto_idasiento))
				lamatrizR(3,1)='idregicomp'
				lamatrizR(3,2)=ALLTRIM(STR(para_registro))
				lamatrizR(4,1)='tabla'
				lamatrizR(4,2)="'"+ALLTRIM(para_tabla)+"'"

						
				p_tabla     = 'asientoscompro'
				p_matriz    = 'lamatrizR'
				p_conexion  = vcone_conta
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
				ENDIF						
				RELEASE lamatrizR 
			ENDIF 
		ENDIF 

		
	IF pcont_conex = 0 THEN 
		=abreycierracon(vcone_conta,"")
	ENDIF 

	RETURN reto_idasiento
ENDFUNC 


FUNCTION ContabilizaCompro
	PARAMETERS pcomp_tabla, pcomp_id, pcomp_con, pcomp_impo
*#/----------------------------------------
** Funcion de Llamada a Contabilizar los comprobantes recibidos como parametros. 
* Parametros:
* 		pcomp_tabla : Tabla que contiene el registro del comprobante a contabilizar
*		pcomp_id	: id del registro a buscar para contabilizar
*		pcomp_con	: conexion a la base de datos , si es 0, entonces abre una nueva conexion, sino usa una abierta
*		pcomp_impo 	: Importe total del comprobante a contabilizar, si es para contabilización manual	
*#/----------------------------------------
	v_idasienton= ContabilizaMov(pcomp_tabla,  pcomp_id, pcomp_con )
	IF v_idasienton = -1 THEN 
		v_idasienton = ContabilizaManual(pcomp_tabla,  pcomp_id, pcomp_con,pcomp_impo)
	ENDIF 
	RETURN v_idasienton
ENDFUNC 






FUNCTION movimientoTPago
PARAMETERS P_idtipocompro, P_idtipopago, P_idcajareca, P_idcuenta
*#/----------------------------------------
*** Retorna el tipo de movimiento registrado según el comprobante, el tipo de pago, la cuenta y la caja
** Parametros:
**		P_idtipocompro: ID del tipo de comprobante
**		P_idtipopago: ID del tipo de pago que se está realizando
**		P_idcajareca: ID de la caja registradora (SI es 0, significa que va a obtener cualquier caja)
**		P_idcuenta: ID de la cuenta (SI es 0, significa que va a obtener cualquier cuenta)
**
** Retorno: Retorna el movimiento registrado para la combinación de parámetros
*#/----------------------------------------
	
	v_retorno = ""
	
	IF P_idtipocompro > 0 AND P_idtipopago > 0 AND P_idcajareca >= 0 AND P_idcuenta >= 0
	
		&& Están correctos los parámetros	
	ELSE
	
		v_retorno  = ""
	
		RETURN v_retorno
	
	ENDIF 
	
	vconeccionM = abreycierracon(0,_SYSSCHEMA)
	
	*** Busco los cheques relacionados a detallecobros ***


*!*		sqlmatriz(1)=" select idtipocompro, idtipopago,idcajareca, idcuenta, movimiento, (if(idcajareca = 0,0,1)*2+if(idcuenta = 0,0,1)) as valor "
*!*		sqlmatriz(2)=" FROM pmovitp "
*!*		sqlmatriz(3)=" where idtipocompro = "+ALLTRIM(STR(p_idtipocompro))+" and idtipopago = "+ALLTRIM(STR(P_idtipopago))
	
		sqlmatriz(1)= " select idtipocompro, idtipopago,idcajareca, idcuenta, movimiento, ((if(idtipocompro = " +ALLTRIM(STR(p_idtipocompro))+" or idtipocompro = 0,1,0)) + "
		sqlmatriz(2)= " (if(idtipopago = "+ALLTRIM(STR(p_idtipopago))+" or idtipopago = 0,1,0)) + (if(idcajareca = "+ALLTRIM(STR(P_idcajareca))+" or idcajareca = 0,1,0)) + "
		sqlmatriz(3)= " (if(idcuenta = "+ALLTRIM(STR(P_idcuenta))+" or idcuenta = 0,1,0))) as coincide, (if(idtipopago = 0,0,1)*4+if(idcuenta = 0,0,1)*2+if(idcajareca = 0,0,1)) as valor "
		sqlmatriz(4)= " FROM pmovitp  having coincide = 4 order by valor desc "

		
	verror=sqlrun(vconeccionM ,"pmovitp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los parámetros de movimientos ",0+48+0,"Error")
	    RETURN ""  
	ENDIF
	
	=abreycierracon(vconeccionM ,"")	

	SELECT pmovitp_sql
	GO TOP 

	IF NOT EOF()
		
		v_retorno = pmovitp_sql.movimiento
		
	ELSE
		v_retorno = ""
	
	ENDIF 


	RETURN v_retorno

ENDFUNC 






FUNCTION moviTipoPago
PARAMETERS p_idtipopago,p_idcaja,p_idcuenta,p_tabla,p_campo,p_idregistro,p_movimiento,p_tablaRet
*#/----------------------------------------
*** Funcion de busqueda de los ultimos movimientos de Tipos de pago según los parametros pasados como parámetros
**  Si el parámetro recibido es CERO, lo ignora en la condición trayendo todos los registros para ese parámetro
** Parametros:
*	p_idtipopago: ID del tipo de pago 
* 	p_idcaja:	ID de la caja registradora
*	p_idcuenta: ID de la cuenta
*	p_tabla,p_campo,p_idregistro: Tabla, campo e ID del registro asociado al tipo de pago
*	p_movimiento: movimiento registrado
*	p_tablaRet: Nombre de la tabla de retorno
*** Retorno: Retorna True si se obtuvo correctamente los registros del movimiento; False en otro caso.
*#/----------------------------------------


	tipoPagoObj 	= CREATEOBJECT('tipospagosclass')


	v_idtipoCupones = tipoPagoObj.gettipospagos("CUPONES")
	v_idTipoCheque 	= tipoPagoObj.gettipospagos("CHEQUE")

	v_registro = IIF(EMPTY(ALLTRIM(p_tabla)) = .T. or EMPTY(ALLTRIM(p_campo)) = .T. or p_idregistro = 0,.F.,.T.)

	v_valorTp= IIF(P_idtipopago > 0," and u.idtipopago = "+ALLTRIM(STR(p_idtipopago)),"")
	v_valorCa=IIF(P_idcaja > 0," and u.idcajareca = "+ALLTRIM(STR(P_idcaja)),"")
	v_valorCu=IIF(P_idcuenta > 0," and u.idcuenta = "+ALLTRIM(STR(P_idcuenta)),"")
	v_valorRe=IIF(p_idregistro > 0," and u.tabla = '"+ALLTRIM(p_tabla)+ "' and u.campo = '"+ALLTRIM(p_campo)+"' and u.idregistro = "+ALLTRIM(STR(p_idregistro)),"")
	v_valorMo=IIF(EMPTY(ALLTRIM(p_movimiento)) =.F.," and u.movimiento = '"+ALLTRIM(p_movimiento)+"'","")

	
	v_condicion = v_valorTP+v_valorCa+v_valorCu+v_valorRe+v_valorMo
	
	vconeccionMo = abreycierracon(0,_SYSSCHEMA)
	

	DO CASE
		CASE p_idtipopago == 0 && Todos los tipos de pagos
			sqlmatriz(1)=" select u.*, '  '  as histocajas "
			sqlmatriz(2)=" from ultimomovitpago u "
			sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)
	
		CASE v_idtipoCupones == p_idtipopago && Cupones

*!*				sqlmatriz(1)=" select u.*,c.idtarjeta,c.numero,c.tarjeta,c.fecha as fechatar, c.importe, c.vencimiento as venc, c.titular,c.codautoriz"
*!*				sqlmatriz(2)=" from ultimomovitpago u "
*!*				sqlmatriz(3)=" left join cupones c on u.idregistro = c.idcupon "
*!*				sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)

			sqlmatriz(1)=" select u.*,c.idtarjeta,c.numero,c.tarjeta,c.fecha as fechatar, c.importe, c.vencimiento as venc, c.titular,c.codautoriz,  group_concat(cr.detalle order by m.idmovitp ) as histocajas "
			sqlmatriz(2)=" from ultimomovitpago u "
			sqlmatriz(3)=" left join cupones c on u.idregistro = c.idcupon "
			sqlmatriz(4)=" left join movitpago m on m.tabla = 'cupones' and m.idregistro = c.idcupon "
			sqlmatriz(5)=" left join cajarecauda cr on m.idcajareca = cr.idcajareca "
			sqlmatriz(6)=" where 1 = 1 "+ALLTRIM(v_condicion)+" group by c.idcupon "


		CASE v_idTipoCheque == p_idtipopago && Cheques

			sqlmatriz(1)=" select u.*,c.serie, c.numero,c.importe,c.fechaemisi, c.fechavence,c.alaorden,c.librador,c.loentrega,c.cuit,  "
			sqlmatriz(2)=" c.cuenta,c.idbanco,c.codcheque,c.detercero,c.lugaremi,c.domilib,c.electro, group_concat(cr.detalle order by m.idmovitp ) as histocajas "
			sqlmatriz(3)=" from ultimomovitpago u "
			sqlmatriz(4)=" left join cheques c on u.idregistro = c.idcheque "
			sqlmatriz(5)=" left join movitpago m on m.tabla = 'cheques' and m.idregistro = c.idcheque "
			sqlmatriz(6)=" left join cajarecauda cr on m.idcajareca = cr.idcajareca "
			sqlmatriz(7)=" where 1 = 1 "+ALLTRIM(v_condicion)+" group by c.idcheque "
		
		OTHERWISE
		
			MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los movimientos ",0+48+0,"Error")
			=abreycierracon(vconeccionMo ,"")	
	    	RETURN .F.  
	ENDCASE
	
	verror=sqlrun(vconeccionMo ,p_tablaRet)
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los movimientos ",0+48+0,"Error")
	=abreycierracon(vconeccionMo ,"")	
	    RETURN .F.  
	ENDIF
	
	=abreycierracon(vconeccionMo ,"")	
	RETURN .T.

ENDFUNC 


******************************************************

******************************************************

FUNCTION AnularRP
PARAMETERS pan_idcomproba, pan_idregistro
*#/----------------------------------------
******************************************************
** Funcion para Anulación de Recibos y Ordenes de Pago
******************************************************
*#/----------------------------------------

	v_chAnular= CHAnularCMP (pan_idcomproba, pan_idregistro,0)
	IF v_chAnular = .f. THEN 
		MESSAGEBOX(" No se puede Anular el Comprobante,: "+CHR(13)+" Pertenece a otra Caja o se transfirieron los Valores o Cupones...",16,"Anular Comprobantes")
		RETURN .f. 
	ENDIF 


	estadosRP	= CREATEOBJECT('estadosclass')
	v_estadoRPAnulado = estadosRP.getIdestado("ANULADO")
	RELEASE estadosRP
	
	vconeccionAn = abreycierracon(0,_SYSSCHEMA)
	
	* Busco el comprobante a anular para saber si anulo un recibo o un pago a proveedor 
	sqlmatriz(1)=" select c.*, t.opera, p.pventa from comprobantes c left join tipocompro t on c.idtipocompro = t.idtipocompro "
	sqlmatriz(2)=" left join compactiv p on p.idcomproba = c.idcomproba "
	sqlmatriz(3)=" where c.idcomproba = "+ALLTRIM(STR(pan_idcomproba))+" or  c.tabla = 'anularp' " 
	verror=sqlrun(vconeccionAn ,"tablarp")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la Tabla de comprobantes ",0+48+0,"Error")
		=abreycierracon(vconeccionAn ,"")	
	    RETURN .F.  
	ENDIF	 

	SELECT tablarp
	GO TOP

	IF !EOF() THEN 
	
		LOCATE FOR idcomproba = pan_idcomproba 	 
		v_opera	  = tablarp.opera
		v_tablaor = ''	
		v_tablaPor= ""

		** Veo si el comprobante a Anular esta ACTIVO , sino no es posible anularlo nuevamente ***	
*********************************************************************
		sqlmatriz(1)=" select * from ultimoestado "
		sqlmatriz(4)=" where tabla = '"+ALLTRIM(tablarp.tabla)+"' and id = '"+ALLTRIM(STR(pan_idregistro))+"'"
		verror=sqlrun(vconeccionAn ,"ultimoestado")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda Ultimo Estado del Recibo - OP ",0+48+0,"Error")
			=abreycierracon(vconeccionAn ,"")	
		    RETURN .F.  
		ENDIF
		SELECT ultimoestado
		GO TOP 
		IF ultimoestado.idestador = v_estadoRPAnulado THEN 
			MESSAGEBOX("El Comprobante Ya se Encuentra ANULADO... Verifique",0+64,"Anulación de Comprobantes")
			USE IN ultimoestado
			=abreycierracon(vconeccionAn ,"")	
		    RETURN .F.  			
		ENDIF 
		USE IN ultimoestado
*********************************************************************
		IF tablarp.tabla = 'recibos' THEN 
			v_tablaPor = 'recibos'
			v_tablaor = 'detallecobros'	
			v_idtablaor = "iddetacobro"
		ENDIF 
		IF tablarp.tabla = 'pagosprov' THEN
			v_tablaPor= 'pagosprov' 		
			v_tablaor = 'detallepagos'	
			v_idtablaor = "iddetapago"
		ENDIF 

		IF EMPTY(v_tablaor) THEN 
			=abreycierracon(vconeccionAn ,"")	
			RETURN .f.
		ENDIF 
		* Obtengo el detalle de cobros o de pagos a anular
		sqlmatriz(1)=" select t.*, h.idcajareca, h.fecha, h.hora, tp.idtipocompro from "+v_tablaor+" t left join cajarecaudah h on t.idcomproba = h.idcomproba and t.idregistro = h.idregicomp "
		sqlmatriz(2)=" left join comprobantes cp on cp.idcomproba   = t.idcomproba "
		sqlmatriz(3)=" left join tipocompro   tp on tp.idtipocompro = cp.idtipocompro "
		sqlmatriz(4)=" where t.idcomproba = "+ALLTRIM(STR(pan_idcomproba))+" and t.idregistro = "+ALLTRIM(STR(pan_idregistro))
		verror=sqlrun(vconeccionAn ,"detalle")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del detalle de cobros ",0+48+0,"Error")
			=abreycierracon(vconeccionAn ,"")	
		    RETURN .F.  
		ENDIF
		SELECT detalle
		GO TOP 
		CALCULATE SUM(importe) TO v_importeAn
		
		* Obtener Tipo de Comprobante de Pago 
		v_idcomprobarp = 0
		v_pventa 	   = 0
		SELECT tablarp
		GO TOP 
		LOCATE FOR idcomproba <> pan_idcomproba AND opera <> v_opera 
		IF FOUND()
			v_idcomprobarp = tablarp.idcomproba 
			v_pventarp	   = tablarp.pventa
			v_tipocomprorp = tablarp.idtipocompro
		ENDIF 	
		
		
		* Grabo en las tablas de Anulación

		
		sino = MESSAGEBOX("¿Confirma La Generación del Comprobante de Anulación...? ",4+32," Anular Comprobante ")

		IF sino = 6
		
				v_idanulaRP  = 0

				v_anularp_idcomproba = v_idcomprobarp
				v_anularp_pventa 	 = v_pventarp
				v_anularp_numero 	 = maxnumerocom(v_anularp_idcomproba ,v_anularp_pventa ,1)
				v_fecha = cftofc(DATE())
				v_anularp_importe = v_importeAn
				v_detallecp			= ""
				v_anularp_idrecibo = 0
				v_anularp_idpago   = 0

				IF v_tablaor = 'detallecobros'
					v_detallecp = "detallepagos"
					v_anularp_idrecibo = pan_idregistro	
				ELSE
					IF v_tablaor = 'detallepagos'
						v_detallecp = "detallecobros"
						v_anularp_idpago = pan_idregistro	
					ENDIF 
				ENDIF 
				
				DIMENSION lamatrizA(9,2)
				
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				p_tabla     = 'anularp'
				p_matriz    = 'lamatrizA'
				p_conexion  = vconeccionAn 

				lamatrizA(1,1)='idanularp'
				lamatrizA(1,2)=ALLTRIM(STR(v_idanulaRP))
				lamatrizA(2,1)='idcomproba'
				lamatrizA(2,2)= ALLTRIM(STR(v_anularp_idcomproba))
				lamatrizA(3,1)='pventa'
				lamatrizA(3,2)=ALLTRIM(STR(v_anularp_pventa))
				lamatrizA(4,1)='numero'
				lamatrizA(4,2)=ALLTRIM(STR(v_anularp_numero))
				lamatrizA(5,1)='fecha'
				lamatrizA(5,2)="'"+ALLTRIM(v_fecha)+"'"
				lamatrizA(6,1)='importe'
				lamatrizA(6,2)=ALLTRIM(STR(v_anularp_importe,13,4))
				lamatrizA(7,1)='idrecibo'
				lamatrizA(7,2)=ALLTRIM(STR(v_anularp_idrecibo))
				lamatrizA(8,1)='idpago'
				lamatrizA(8,2)=ALLTRIM(STR(v_anularp_idpago ))
				lamatrizA(9,1)='detallecp'
				lamatrizA(9,2)="'"+v_detallecp+"'"

				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
				    RETURN 
				ENDIF 
				
				RELEASE lamatrizA
				
				*** Ultimo ID registrado ***
				
				
				sqlmatriz(1)="SELECT last_insert_id() as maxid "

				verror=sqlrun(vconeccionAn,"anularpmax_sql")
				IF verror=.f.  
			 	   MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID de Anulación",0+48+0,"Error")
				ENDIF 

				SELECT anularpmax_sql
				GO TOP 
				
				v_idanulaRP = VAL(anularpmax_sql.maxid)
	
				USE in anularpmax_sql
				
				
			*** REGISTRO ESTADO AUTORIZADO ***
				registrarEstado("anularp","idanularp",v_idanulaRP,'I',"AUTORIZADO")
		
				SELECT detalle
				GO TOP 			
				v_idcajarecaRP = 0
				IF !EOF() THEN 
					v_idcajarecaRP = detalle.idcajareca
				ENDIF 				
				*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
				guardaCajaRecaH (v_anularp_idcomproba, v_idanulaRP, v_idcajarecaRP)
				SELECT detalle
				GO TOP 							
				DIMENSION lamatriz(6,2)
				DIMENSION lamatrizL(8,2)
			
				DO WHILE NOT EOF() AND RECNO() >= 1
				
				**** GUARDO DATOS DE DETALLECOBRO / DETALLEPAGOS****
					v_nombreID	= ""
					v_iddetacp 	= 0
					
					IF v_detallecp == "detallecobros"
						v_iddetacp	= maxnumeroidx("iddetacobro", "I","detallecobros",1)
						v_nombreID	= "iddetacobro" 	
					ELSE
						IF v_detallecp == "detallepagos"
						v_iddetacp 	= maxnumeroidx("iddetapago", "I","detallepagos",1)
						v_nombreID	= "iddetapago" 	
						ENDIF 
					ENDIF 
					
					IF v_iddetacp <= 0
						MESSAGEBOX("Error al registrar el detalle de cobro o pago",0+16+0,"Error al registrar el comprobante")
					
					ENDIF 
					
					SELECT detalle 
					v_detallecp_idcomproba 		= v_anularp_idcomproba 
					v_detallecp_idregi			= v_idanulaRP
					v_idtipoPago 				= detalle.idtipopago 				
					v_detallecp_importe			= detalle.importe 
					id_cajabco					= detalle.idcuenta 
					v_fecha = cftofc(DATE())
					
					lamatriz(1,1)= v_nombreID
					lamatriz(1,2)=ALLTRIM(STR(v_iddetacp))
					lamatriz(2,1)='idcomproba'
					lamatriz(2,2)= ALLTRIM(STR(v_detallecp_idcomproba ))
					lamatriz(3,1)='idregistro'
					lamatriz(3,2)= ALLTRIM(STR(v_detallecp_idregi))
					lamatriz(4,1)= 'idtipopago'
					lamatriz(4,2)= ALLTRIM(STR(v_idtipoPago))		
					lamatriz(5,1)='importe'
					lamatriz(5,2)= ALLTRIM(STR(v_detallecp_importe,13,4))
					lamatriz(6,1)= 'idcuenta'
					lamatriz(6,2)= ALLTRIM(STR(id_cajabco))
					
					p_tipoope	= 'I'
					p_donficion = ''
					p_tabla		= v_detallecp
					p_matriz    = 'lamatriz'
					p_conexion  = vconeccionAn 
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")    
					ENDIF 


					* Obtengo si existe el registro de Cobro Pago Link que referencia al Detalle 
					v_registrocp = 0
					eje = " v_registrocp = detalle."+ALLTRIM(v_idtablaor)
					&eje 
					sqlmatriz(1)=" select * from cobropagolink "
					sqlmatriz(2)=" where tablacp = '"+v_tablaor+"' and campocp = '"+v_idtablaor+"' and registrocp = "+ALLTRIM(STR(v_registrocp))
					verror=sqlrun(vconeccionAn ,"cobropagolink")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del detalle de cobros ",0+48+0,"Error")
						=abreycierracon(vconeccionAn ,"")	
					    RETURN .F.  
					ENDIF
					SELECT cobropagolink
					GO TOP 

					IF !EOF() AND RECNO() >= 1 THEN 	
						*** Guardo en COBROPAGO LINK PARA CUPONES O CHEQUES ***
						v_idcplink = maxnumeroidx("idcplink", "I", "cobropagolink",1)	

						v_tablacp	= v_detallecp
						v_campocp	= v_nombreID
						v_tabla		= cobropagolink.tabla
						v_campo		= cobropagolink.campo
						v_idregistro= cobropagolink.idregistro
						v_fecha		= DTOS(DATE())
						v_hora 		= TIME()
						
						p_tipoope     = 'I'
						p_condicion   = ''
						v_titulo      = " EL ALTA "
						p_tabla     = 'cobropagolink'
						p_matriz    = 'lamatrizL'
						p_conexion  = vconeccionAn 

						lamatrizL(1,1)='idcplink'
						lamatrizL(1,2)=ALLTRIM(STR(v_idcplink))
						lamatrizL(2,1)='tablacp'
						lamatrizL(2,2)="'"+v_tablacp+"'"
						lamatrizL(3,1)='campocp'
						lamatrizL(3,2)="'"+v_campocp+"'"
						lamatrizL(4,1)='registrocp'
						lamatrizL(4,2)=ALLTRIM(STR(v_iddetacp))
						lamatrizL(5,1)='tabla'
						lamatrizL(5,2)="'"+v_tabla+"'"
						lamatrizL(6,1)='campo'
						lamatrizL(6,2)="'"+v_campo+"'"
						lamatrizL(7,1)='idregistro'
						lamatrizL(7,2)=ALLTRIM(STR(v_idregistro))
						lamatrizL(8,1)='fecha'
						lamatrizL(8,2)="'"+ALLTRIM(v_fecha)+"'"
						
								
						IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
						    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")		    
						ENDIF 
						
*!*							MESSAGEBOX(v_tablacp)
*!*							MESSAGEBOX(v_campocp)
*!*							MESSAGEBOX(v_iddetacp)
						v_ret = guardarMoviTPago(v_idtipoPago, v_tabla, v_campo, v_idregistro, v_idcajarecaRP , id_cajabco, v_tipocomprorp, v_tablacp, v_campocp, v_iddetacp)
						IF v_ret = .F.
							MESSAGEBOX("Ha Ocurrido un Error al intentar registrar el Movimiento para el Tipo de pago",0+48+0,"Error")
						ENDIF 					
					ENDIF 
				
					SELECT detalle
					SKIP 1
				ENDDO 
				
	
				** Elimino los registros de Cobro que corresponden al Recibo Anulado o Pago Anulado ***	
				***************************************************************************************
				* si el origen es detallecobros es un recibo por lo que hay que elimirar el registro asociado
				* al recibo pasado como parametro para anular
				IF v_tablaor = 'detallecobros' THEN 
					sqlmatriz(1)=" delete from cobros where idcomproba = "+ALLTRIM(STR(pan_idcomproba))+" and idregipago = "+ALLTRIM(STR(pan_idregistro))
					verror=sqlrun(vconeccionAn ,"delrecibo")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de los Cobros ",0+48+0,"Error")
						=abreycierracon(vconeccionAn ,"")	
					ENDIF
				ENDIF 
				IF v_tablaor = 'detallepagos' THEN 
					sqlmatriz(1)=" delete from pagosprovfc where idcomproba = "+ALLTRIM(STR(pan_idcomproba))+" and idpago = "+ALLTRIM(STR(pan_idregistro))
					verror=sqlrun(vconeccionAn ,"delpago")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de los Cobros ",0+48+0,"Error")
						=abreycierracon(vconeccionAn ,"")	
					ENDIF
				ENDIF 

						
*!*				*Registracion Contable de la Anulacion	

				nuevo_asiento = Contrasiento( 0,_SYSCONTRADH, v_tablaPor, pan_idregistro, 'anularp', v_idanulaRP)
				
				
				
				IF v_tablaor = 'detallecobros'
				
					v_ret = ctaCteBancos('ANULARRECIBO',v_idanulaRP,0)

				ELSE
					IF v_tablaor = 'detallepagos'
					
						v_ret = ctaCteBancos('ANULARPAGO',v_idanulaRP,0)
					ENDIF 
				ENDIF 
				
				
				
				
				** Elimino los Vinculos de Comprobantes y Asientos de vinculos que pueda haber tenido el Comprobante Anulado
				************************************************************************************************************
				= EliminaVinculo(v_tablaPor,pan_idregistro)
				*************************************************************************************		
				*************************************************************************************				
			
				
				*** Elimino las retenciones realizadas para el caso de las ordenes de pago ***
				IF v_tablaPor = "pagosprov"
					
					comproObjtmp		= CREATEOBJECT('comprobantesClass')
					v_idcomprobar =  comproObjtmp.getidcomprobante("RETENCION")
				
					sqlmatriz(1)=" select * from linkcompro where idcomprobaa = "+ALLTRIM(STR(pan_idcomproba))+" and idregistroa = "+ALLTRIM(STR(pan_idregistro))
				
					
					verror=sqlrun(vconeccionAn ,"linkcompro_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de las retenciones asociadas",0+48+0,"Error")
						=abreycierracon(vconeccionAn ,"")	
					ENDIF
				
					SELECT linkcompro_sql
					GO TOP 
					
					
					DO WHILE NOT EOF()
						v_idlinkcomp = linkcompro_sql.idlinkcomp
						v_idcomprobab = linkcompro_sql.idcomprobab
						v_idregistrob = linkcompro_sql.idregistrob
												
						IF v_idcomprobar = v_idcomprobab
						
							** Elimino el enlace **
							
							sqlmatriz(1)=" delete from linkcompro where idlinkcomp = "+ALLTRIM(STR(v_idlinkcomp))
						
							verror=sqlrun(vconeccionAn ,"delreten")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de la retención",0+48+0,"Error")
							
							ELSE
							
							
							
								** Elimino la retencion**
								sqlmatriz(1)=" delete from retenciones where idreten = "+ALLTRIM(STR(v_idregistrob))
								
								verror=sqlrun(vconeccionAn ,"delreten")
								IF verror=.f.  
								    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de la retención",0+48+0,"Error")
								
								ELSE
								
									
									
									sqlmatriz(1)=" select * from impuretencionh where idreten = "+ALLTRIM(STR(v_idregistrob))
						
									verror=sqlrun(vconeccionAn ,"impuretencionh_sql")
									IF verror=.f.  
									    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion del estado de la retención",0+48+0,"Error")
									ELSE
									
										select impuretencionh_sql
										GO TOP 
										
										DO WHILE NOT EOF()
										
											v_idafipesc = impuretencionh_sql.idafipesc
											** Elimino afipescalash **
											
											sqlmatriz(1)=" delete from afipescalash where idafipesc = "+ALLTRIM(STR(v_idafipesc))
										
											verror=sqlrun(vconeccionAn ,"delafipescalash ")
											IF verror=.f.  
											    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de las retenciones",0+48+0,"Error")																						
											ENDIF 
										
											SELECT impuretencionh_sql
											SKIP 1

										ENDDO
									ENDIF 	
									** Elimino impuretencionh **
									sqlmatriz(1)=" delete from  impuretencionh where idreten = "+ALLTRIM(STR(v_idregistrob))
									
									verror=sqlrun(vconeccionAn ,"delimpuretencionh ")
									IF verror=.f.  
									    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de las retenciones",0+48+0,"Error")																						
									ENDIF
									
									
									** Elimino los estados de la retención **
									sqlmatriz(1)=" delete from estadosreg where tabla = 'retenciones' and campo = 'idreten' and id = "+ALLTRIM(STR(v_idregistrob))
								
									verror=sqlrun(vconeccionAn ,"delretenest")
									IF verror=.f.  
									    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion del estado de la retención",0+48+0,"Error")
									ENDIF 						
								
								ENDIF
							ENDIF 
													
						
						ENDIF 

	
						SELECT linkcompro_sql
						SKIP 1
					ENDDO 
										
				
				ENDIF 
				
		ELSE
				
			=abreycierracon(vconeccionAn ,"")	
			RETURN .f.
		ENDIF 
	  	
		=abreycierracon(vconeccionAn ,"")	
		RETURN .t. 
	ELSE 
		=abreycierracon(vconeccionAn ,"")	
		RETURN .f. 
	ENDIF 

ENDFUNC 






FUNCTION ContrAsiento
PARAMETERS pca_idasiento,pca_DH, pca_tablaOri, pca_idOri, pca_tablaDes, pca_idDes
*#/----------------------------------------
*/* Carga un Contra-Asiento segun reciba el parametro del comprobante o del asiento origen
* Incerta el Asiento en la tabla asientos y devuelve el id de asiento generado
* Segun el ultimo parametro el asiento se invierte en columnas debe y haber o bien se carga
* en negativo en cada columna
* PARAMETROS
* pca_idasiento	:  idasiento del asiento a cancelar
* pca_DH		:  + . Invierte el asiento Manteniendo el signo en cada columna
*		  		   - . Mantiene los valores en las columnas pero con signo negativo 		  	
*#/----------------------------------------

	IF !(TYPE('pca_tablaOri')='C') THEN 
		pca_tablaOri = ""
	ENDIF 
	IF !(TYPE('pca_tablaDes')='C') THEN 
		pca_tablaOri = ""
	ENDIF 
	IF !(TYPE('pca_idOri')='N') THEN 
		pca_tablaOri = 0
	ENDIF 
	IF !(TYPE('pca_idDes')='N') THEN 
		pca_tablaOri = 0
	ENDIF 

	* Establece la condicion de busqueda
	v_condicion = ""
	IF pca_idasiento > 0 THEN 
		v_condicion = "  where a.idasiento = "+ALLTRIM(STR(pca_idasiento))
	ELSE 
		IF !EMPTY(pca_tablaOri) AND pca_idOri > 0 THEN 
			v_condicion = " where ac.tabla = '"+ALLTRIM(pca_tablaOri)+"' and ac.idregicomp = "+STR(pca_idOri) 
		ENDIF 
	ENDIF 

	* Si las condiciones de busqueda están vacia no retorno asiento
	IF EMPTY(v_condicion) THEN 
		RETURN 0
	ENDIF 
	
	
	* Abro conexion con la base de datos 
	vconeccionCa = abreycierracon(0,_SYSSCHEMA)

	vnomindice=obtenerCampoIndice(ALLTRIM(pca_tablaDes))

	* Busco el comprobante de anulacion para saber la fecha que le pongo al asiento 
	sqlmatriz(1)=" select * from "+ALLTRIM(pca_tablaDes)+" where "+ALLTRIM(vnomindice)+" = "+ALLTRIM(STR(pca_idDes))
	verror=sqlrun(vconeccionCa ,"fechaDes")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda Comprobante Destino ",0+48+0,"Error")
		=abreycierracon(vconeccionCa ,"")	
	    RETURN 0  
	ENDIF	 

	SELECT fechaDes
	GO TOP 
	v_fechades = ""
	IF !EOF() THEN 
		v_fechades = ALLTRIM(fechades.fecha)
	ENDIF 
	IF EMPTY(v_fechades) THEN 
		v_fechades = DTOS(DATE())
	ENDIF 
	USE IN fechades 
	
	
	* Busco el comprobante a anular para saber si anulo un recibo o un pago a proveedor 
	sqlmatriz(1)=" select a.*, ac.tabla, ac.idregicomp from asientos a left join asientoscompro ac on ac.idasiento = a.idasiento "
	sqlmatriz(2)= v_condicion  
	verror=sqlrun(vconeccionCa ,"asientoOri")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Asiento Origen ",0+48+0,"Error")
		=abreycierracon(vconeccionCa ,"")	
	    RETURN 0  
	ENDIF	 
	SELECT asientoOri
	GO TOP 
	IF !EOF() THEN 
*********************************************************************************	

			* Obtengo el idasiento nuevo y el numero de asiento nuevo
		v_idasiento =  maxnumeroidx("idasiento","I","asientos",1)
		v_numero	=  maxnumeroidx("numero","I","asientos",1)

		v_fecha			= v_fechades
		v_ejercicio		= asientoOri.ejercicio


		DIMENSION lamatriz(16,2)
		*** INSERTO HIJOS ***
		SELECT asientoOri
		GO TOP 
		DO WHILE NOT EOF()
			IF !EMPTY(asientoOri.codigocta) AND (asientoOri.debe + asientoOri.haber) <> 0 THEN 
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				
				v_idasientod = maxnumeroidx("idasientod","I","asientos",1,.T.)
				
				lamatriz(1,1)='idasientod'
				lamatriz(1,2)=ALLTRIM(STR(v_idasientod))
				lamatriz(2,1)='idasiento'
				lamatriz(2,2)=ALLTRIM(STR(v_idasiento))
				lamatriz(3,1)='numero'
				lamatriz(3,2)=ALLTRIM(STR(v_numero))
				lamatriz(4,1)='fecha'
				lamatriz(4,2)="'"+v_fecha+"'"
				lamatriz(5,1)='ejercicio'
				lamatriz(5,2)=ALLTRIM(STR(v_ejercicio))
				
				lamatriz(6,1)='idpland'
				lamatriz(6,2)=ALLTRIM(STR(asientoOri.idpland))
				lamatriz(7,1)='codigocta'
				lamatriz(7,2)="'"+alltrim(asientoOri.codigocta)+"'"
				lamatriz(8,1)='debe'
				lamatriz(8,2)=IIF(pca_DH = '-',ALLTRIM(STR(asientoOri.debe*(-1),12,2)),ALLTRIM(STR(asientoOri.haber,12,2))) 
				lamatriz(9,1)='haber'
				lamatriz(9,2)=IIF(pca_DH = '-',ALLTRIM(STR(asientoOri.haber*(-1),12,2)),ALLTRIM(STR(asientoOri.debe,12,2))) 
				lamatriz(10,1)='detalle'
				lamatriz(10,2)="'"+ALLTRIM(asientoOri.detalle)+"'"
				lamatriz(11,1)='nombrecta'
				lamatriz(11,2)="'"+ALLTRIM(asientoOri.nombrecta)+"'"
				lamatriz(12,1)='detaasiento'
				lamatriz(12,2)="'"+ALLTRIM(asientoOri.detaasiento)+"'"
				lamatriz(13,1)='idtipoasi'
				lamatriz(13,2)=STR(asientoOri.idtipoasi)
				lamatriz(14,1)='idastomode'
				lamatriz(14,2)=STR(asientoOri.idastomode)
				lamatriz(15,1)='idfiltro'
				lamatriz(15,2)=STR(asientoOri.idfiltro)
				lamatriz(16,1)='idastoe'
				lamatriz(16,2)=STR(asientoOri.idastoe)

				
				p_tabla     = 'asientos'
				p_matriz    = 'lamatriz'
				p_conexion  = vconeccionCa 
				p_condicion = ""
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				ENDIF						
				
			ENDIF

			SELECT asientoOri
			SKIP 1
		ENDDO	
		
		RELEASE lamatriz 
		
		* Agrego la relacion con Comprobantes si recibi la tabla y el id con el cual debo relacionarlo
		IF  !empty(pca_tablaDes) AND  pca_idDes > 0 THEN 
			DIMENSION lamatriz(4,2)
			
				lamatriz(1,1)='idastocompro'
				lamatriz(1,2)='0'
				lamatriz(2,1)='idasiento'
				lamatriz(2,2)=ALLTRIM(STR(v_idasiento))
				lamatriz(3,1)='idregicomp'
				lamatriz(3,2)=ALLTRIM(STR(pca_idDes))
				lamatriz(4,1)='tabla'
				lamatriz(4,2)="'"+pca_tablaDes+"'"
			
				p_tabla     = 'asientoscompro'
				p_matriz    = 'lamatriz'
				p_conexion  = vconeccionCa 
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				ENDIF						
			RELEASE lamatriz
			
		ENDIF 
		
		USE IN asientoOri 
		RETURN v_idasiento
*********************************************************************************	
	ENDIF 

ENDFUNC 



PROCEDURE MENSAJE_ERROR
*#/----------------------------------------
*/* Manejo de funciones de Error para las conexiones FTP
*#/----------------------------------------
LPARAMETERS toFTP, tcMensaje
LOCAL KEY_ENTER
  
  #DEFINE MSG_BOTON_OK    0
  #DEFINE MSG_ICONO_STOP 16
  
  KEY_ENTER = 13
  
  tcMensaje = Alltrim(tcMensaje)
  tcMensaje = Strtran(tcMensaje, Chr(0), "")
  
  tcMensaje = '"' + Strtran(tcMensaje, "*", '" + Chr(KEY_ENTER) + "') + '"'
  
  TRY
    tcMensaje = Evaluate(tcMensaje)
  CATCH
  ENDTRY
  
  =MessageBox(tcMensaje, MSG_ICONO_STOP + MSG_BOTON_OK, "Hay un problema...")
  
  WITH toFTP
    .cMensajeError    = ""
    .nCodigoResultado = 0
  ENDWITH
  
ENDPROC


*******************************************************************************




FUNCTION guardaHistCostoArt
PARAMETERS p_articulo, p_costo, p_conexion,p_fechahisto
*#/----------------------------------------
*** Función para guardar el Historico de actualización de costo del artículo ****
**Parametros: articulo: codigo del articulo a actualizar; costo: costo del articulo actualizado; coneccion: Conección a la Base de Datos
**            fechahisto: fecha y hora para registrar la grabacion del historico de costos
** Retorno: Retorna True si se Guarda correctamente, False en caso contrario
*#/----------------------------------------

v_conexion = 0

IF TYPE('p_conexion') = 'N'
	IF p_conexion <= 0
		v_conexion = abreycierracon(0,_SYSSCHEMA)
	ELSE 
		v_conexion = p_conexion 
	ENDIF 
ELSE
	v_conexion = abreycierracon(0,_SYSSCHEMA)

ENDIF 

*!*	 IF (EMPTY(p_articulo) =.T.) OR p_costo < -1 OR v_conexion <= 0
 IF (EMPTY(p_articulo) =.T.) OR v_conexion <= 0 THEN 
  	
 	MESSAGEBOX("Ha ocurrido un error al intentar registrar el historial de costo del articulo (Parámetros Incorrectos)",0+16+0,"No se pudo guardar el historial de costos")
 	RETURN .F.
 ENDIF 

IF p_costo > 0 THEN 

	v_idartcosto = 0
	IF TYPE('p_fechahisto')='C' THEN 
		v_fechahora = ALLTRIM(p_fechahisto)
	ELSE 
		v_fechahora = ALLTRIM(DTOS(DATE())+TIME())
	ENDIF 
	
	DIMENSION lamatriz(4,2)

	lamatriz(1,1)='idartcosto'
	lamatriz(1,2)=ALLTRIM(STR(v_idartcosto))
	lamatriz(2,1)='articulo'
	lamatriz(2,2)="'"+ALLTRIM(p_articulo)+"'"
	lamatriz(3,1)='costo'
	lamatriz(3,2)=ALLTRIM(STR(p_costo,13,4))
	lamatriz(4,1)='fecha'
	lamatriz(4,2)="'"+ALLTRIM(v_fechahora)+"'"

	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
	p_tabla     = 'articostos'
	p_matriz    = 'lamatriz'
	p_conexionar  = v_conexion 
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexionar) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")

	    RETURN .F.
	ENDIF	
						
ENDIF 

IF TYPE('p_conexion') = 'N'
	IF p_conexion <= 0
		 = abreycierracon(v_conexion,"")
	ENDIF 
ELSE
	 = abreycierracon(v_conexion,"")
ENDIF 

	RETURN .T.

ENDFUNC 





FUNCTION CreditoLimiteE
PARAMETERS  para_entidad, para_monto
*#/----------------------------------------
* Obtiene el Saldo de Crédito disponible para la entidad pasada como parametro
*#/----------------------------------------

	_SQLENTIDAD = para_entidad
	vconeccionCR = abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)=" SELECT * FROM tipocompro where detalle like 'RECIBO%' LIMIT 1 "
	verror=sqlrun(vconeccionCR ,"signocredito_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Crédito del Cliente... ",0+48+0,"Error")
	    RETURN 0  
	ENDIF
	SELECT signocredito_sql
	v_signosaldo = signocredito_sql.opera
	USE IN signocredito_sql 


	sqlmatriz(1)=" SELECT cc.entidad, (sum(ifnull("+ALLTRIM(STR(v_signosaldo))+"*cr.importe,0)) + cc.saldo) as credito "
	sqlmatriz(2)=" FROM ctactesaldo1 cc left join entidadescr cr on cc.entidad = cr.entidad  " 
	sqlmatriz(4)=" WHERE  cc.entidad = "+ALLTRIM(STR(para_entidad))
  
	verror=sqlrun(vconeccionCR ,"credito_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Crédito del Cliente... ",0+48+0,"Error")
	    RETURN 0  
	ENDIF
	=abreycierracon(vconeccionCR ,"")	

	SELECT credito_sql
	GO TOP 
	IF EOF()
		RETURN 0
	ENDIF
	vcredito = (credito_sql.credito + para_monto) * v_signosaldo
	USE IN credito_sql
	
	RETURN vcredito
ENDFUNC 
*------------------------------------------------------------------------------------



FUNCTION GruposArtLinea
PARAMETERS pl_articulo, pl_linea, pl_opera, pl_conexion
*#/----------------------------------------
* Incerta y Elimina Articulos en los Grupos asociados a las Lineas de los Artículos. Parametro : '+' o '-'
*#/----------------------------------------
	IF _SYSTIPOGRLIA = 0 THEN && No se definieron Grupos para las Lineas
		RETURN 
	ENDIF 

	IF pl_opera ="+" THEN 	
		* Veifica que exista el grupo para la Linea del articulo, si no existe lo crea ***	
		** busca el Grupo de la Linea pasada como Parámetro
		sqlmatriz(1)=" select idgrupo from grupos where  idtipogrupo = "+ALLTRIM(STR(_SYSTIPOGRLIA))+"  and " 
		sqlmatriz(2)=" TRIM(LOWER(nombre)) = '"+LOWER(ALLTRIM(pl_linea))+"'"
		verror=sqlrun(pl_conexion ,"grupo_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Grupo de la Linea... ",0+48+0,"Error")
		    RETURN 0  
		ENDIF
		SELECT grupo_sql
		GO TOP 
			
		** Si no Existe el Grupo para la Linea Lo Genero 
		**********************************************************************************************		
		IF EOF() THEN 	&& Creación del Grupo de Articulos para la Linea ya que no existe

			v_idmax = maxnumeroidx('idgrupo', 'I', 'grupos',1)
			v_idgrupoarti = v_idmax

			DIMENSION lamatriz(5,2)

			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "

			lamatriz(1,1) = 'idgrupo'
			lamatriz(1,2) = ALLTRIM(STR(v_idgrupoarti))
			lamatriz(2,1) = 'idtipogrupo'
			lamatriz(2,2) = ALLTRIM(STR(_SYSTIPOGRLIA))
			lamatriz(3,1) = 'nombre'
			lamatriz(3,2) = "'"+UPPER(SUBSTR(ALLTRIM(pl_linea),1,1))+LOWER(SUBSTR(ALLTRIM(pl_linea),2))+"'"
			lamatriz(4,1) = 'fecha'
			lamatriz(4,2) = "'"+ALLTRIM(DTOS(DATE()))+"'"
			lamatriz(5,1) = 'describir'
			lamatriz(5,2) = "'"+ALLTRIM("Grupo de Linea: "+UPPER(SUBSTR(ALLTRIM(pl_linea),1,1))+LOWER(SUBSTR(ALLTRIM(pl_linea),2)))+"'"
			
			p_tabla     = 'grupos'
			p_matriz    = 'lamatriz'
			p_conexion  = pl_conexion

			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(thisform.tb_idgrupo.value)+" - "+;
			                ALLTRIM(thisform.tb_grupo.value),0+48+0,"Error")
			     RETURN 
			ENDIF 		
		
		ELSE 
			v_idgrupoarti = grupo_sql.idgrupo
		ENDIF 
		SELECT grupo_sql
		USE IN grupo_sql 
	*********************************************************************************************		
	ENDIF 

	** busca el Artículo para saber si pertenece o no al grupo de la Linea pasada como parametro
	sqlmatriz(1)=" select o.idgrupobj, o.idgrupo, o.idmiembro, o.fecha, g.idtipogrupo, g.nombre, g.describir "
	sqlmatriz(2)=" from grupoobjeto o left join grupos g on g.idgrupo = o.idgrupo "
	sqlmatriz(3)=" where g.idtipogrupo = "+ALLTRIM(STR(_SYSTIPOGRLIA))+" and trim(o.idmiembro) = '"+ALLTRIM(pl_articulo)+"' and " 
	sqlmatriz(4)=" TRIM(LOWER(g.nombre)) = '"+LOWER(ALLTRIM(pl_linea))+"'"
	verror=sqlrun(pl_conexion ,"artigrupo_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Artículos en el Grupo... ",0+48+0,"Error")
	    RETURN 0  
	ENDIF
	SELECT artigrupo_sql
	GO TOP 

	IF pl_opera = "+" AND EOF() THEN && Agregar articulo a un grupo de Línea

		DIMENSION lamatriz(4,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'grupoobjeto'
		p_matriz    = 'lamatriz'
		p_conexion  = pl_conexion
			
		v_idgrupo = v_idgrupoarti 
		v_idmiembro= ALLTRIM(pl_articulo)


		v_idmax = maxnumeroidx('idgrupobj', 'I', 'grupoobjeto',1)
		lamatriz(1,1) = 'idgrupobj'
		lamatriz(1,2) = ALLTRIM(STR(v_idmax))
		lamatriz(2,1) = 'idgrupo'
		lamatriz(2,2) = ALLTRIM(STR(v_idgrupo))
		lamatriz(3,1) = 'idmiembro'
		lamatriz(3,2) = "'"+ALLTRIM(v_idmiembro)+"'"
		lamatriz(4,1) = 'fecha'
		lamatriz(4,2) = "'"+ALLTRIM(DTOS(DATE()))+"'"
		
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(thisform.tb_idgrupo.value)+" - "+;
		                ALLTRIM(thisform.tb_grupo.value),0+48+0,"Error")
		     RETURN 
		ENDIF 

		toolbargrupos.cmd_actualizar.backcolor = RGB(255,0,0)

	ENDIF 
	
	
	IF pl_opera = '-' THEN && Quitar Artículo a un Grupo de Linea
		IF !EOF() THEN 
			v_idgrupobj = artigrupo_sql.idgrupobj
			sqlmatriz(1)=" delete from grupoobjeto where idgrupobj = "+ALLTRIM(STR(v_idgrupobj))
			verror=sqlrun(pl_conexion ,"delgrupo_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de articulo del grupo ... ",0+48+0,"Error")
			    RETURN   
			ENDIF

			toolbargrupos.cmd_actualizar.backcolor = RGB(255,0,0)
			
		ENDIF 
	ENDIF 
	USE IN artigrupo_sql 


RETURN 




FUNCTION GruposMatLinea
PARAMETERS pl_material, pl_linea, pl_opera, pl_conexion

*#/----------------------------------------
* Incerta y Elimina Articulos en los Grupos asociados a las Lineas de los Materiales. Parametro : '+' o '-'
*#/----------------------------------------
	IF _SYSTIPOGRLIM = 0 THEN && No se definieron Grupos para las Lineas
		RETURN 
	ENDIF 

*!*		pl_material = ALLTRIM(STR(pl_materiali))
	
	IF pl_opera ="+" THEN 	
		* Veifica que exista el grupo para la Linea del articulo, si no existe lo crea ***	
		** busca el Grupo de la Linea pasada como Parámetro
		sqlmatriz(1)=" select idgrupo from grupos where  idtipogrupo = "+ALLTRIM(STR(_SYSTIPOGRLIM))+"  and " 
		sqlmatriz(2)=" TRIM(LOWER(nombre)) = '"+LOWER(ALLTRIM(pl_linea))+"'"
		verror=sqlrun(pl_conexion ,"grupo_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Grupo de la Linea... ",0+48+0,"Error")
		    RETURN 0  
		ENDIF
		SELECT grupo_sql
		GO TOP 
		** Si no Existe el Grupo para la Linea Lo Genero 
		**********************************************************************************************		
		IF EOF() THEN 	&& Creación del Grupo de Materiales para la Linea ya que no existe

			v_idmax = maxnumeroidx('idgrupo', 'I', 'grupos',1)
			v_idgrupomate = v_idmax

			DIMENSION lamatriz(5,2)

			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "

			lamatriz(1,1) = 'idgrupo'
			lamatriz(1,2) = ALLTRIM(STR(v_idgrupomate))
			lamatriz(2,1) = 'idtipogrupo'
			lamatriz(2,2) = ALLTRIM(STR(_SYSTIPOGRLIM))
			lamatriz(3,1) = 'nombre'
			lamatriz(3,2) = "'"+UPPER(SUBSTR(ALLTRIM(pl_linea),1,1))+LOWER(SUBSTR(ALLTRIM(pl_linea),2))+"'"
			lamatriz(4,1) = 'fecha'
			lamatriz(4,2) = "'"+ALLTRIM(DTOS(DATE()))+"'"
			lamatriz(5,1) = 'describir'
			lamatriz(5,2) = "'"+ALLTRIM("Grupo de Linea: "+UPPER(SUBSTR(ALLTRIM(pl_linea),1,1))+LOWER(SUBSTR(ALLTRIM(pl_linea),2)))+"'"
			
			p_tabla     = 'grupos'
			p_matriz    = 'lamatriz'
			p_conexion  = pl_conexion

			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(thisform.tb_idgrupo.value)+" - "+;
			                ALLTRIM(thisform.tb_grupo.value),0+48+0,"Error")
			     RETURN 
			ENDIF 		
		
		ELSE 
			v_idgrupomate = grupo_sql.idgrupo
		ENDIF 
		SELECT grupo_sql
		USE IN grupo_sql 
	*********************************************************************************************		
	ENDIF 

	** busca el Artículo para saber si pertenece o no al grupo de la Linea pasada como parametro
	sqlmatriz(1)=" select o.idgrupobj, o.idgrupo, o.idmiembro, o.fecha, g.idtipogrupo, g.nombre, g.describir "
	sqlmatriz(2)=" from grupoobjeto o left join grupos g on g.idgrupo = o.idgrupo "
	sqlmatriz(3)=" where g.idtipogrupo = "+ALLTRIM(STR(_SYSTIPOGRLIM))+" and trim(o.idmiembro) = '"+ALLTRIM(pl_material)+"' and " 
	sqlmatriz(4)=" TRIM(LOWER(g.nombre)) = '"+LOWER(ALLTRIM(pl_linea))+"'"
	verror=sqlrun(pl_conexion ,"mategrupo_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Materiales en el Grupo... ",0+48+0,"Error")
	    RETURN 0  
	ENDIF
	SELECT mategrupo_sql
	GO TOP 

	IF pl_opera = "+" AND EOF() THEN && Agregar articulo a un grupo de Línea

		DIMENSION lamatriz(4,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'grupoobjeto'
		p_matriz    = 'lamatriz'
		p_conexion  = pl_conexion
			
		v_idgrupo = v_idgrupomate 
		v_idmiembro= ALLTRIM(pl_material)


		v_idmax = maxnumeroidx('idgrupobj', 'I', 'grupoobjeto',1)
		lamatriz(1,1) = 'idgrupobj'
		lamatriz(1,2) = ALLTRIM(STR(v_idmax))
		lamatriz(2,1) = 'idgrupo'
		lamatriz(2,2) = ALLTRIM(STR(v_idgrupo))
		lamatriz(3,1) = 'idmiembro'
		lamatriz(3,2) = "'"+ALLTRIM(v_idmiembro)+"'"
		lamatriz(4,1) = 'fecha'
		lamatriz(4,2) = "'"+ALLTRIM(DTOS(DATE()))+"'"
		
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
		     RETURN 
		ENDIF 
		
		toolbargrupos.cmd_actualizar.backcolor = RGB(255,0,0)

	ENDIF 
	
	
	IF pl_opera = '-' THEN && Quitar Material a un Grupo de Linea
		IF !EOF() THEN 
			v_idgrupobj = mategrupo_sql.idgrupobj
			sqlmatriz(1)=" delete from grupoobjeto where idgrupobj = "+ALLTRIM(STR(v_idgrupobj))
			verror=sqlrun(pl_conexion ,"delgrupo_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Eliminacion de Material del grupo ... ",0+48+0,"Error")
			    RETURN   
			ENDIF

			toolbargrupos.cmd_actualizar.backcolor = RGB(255,0,0)

		ENDIF 
	ENDIF 
	USE IN mategrupo_sql 


RETURN 




FUNCTION CambiaTipoDato

	vconeccionF = abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)="SHOW TABLES FROM "+_SYSSCHEMA 
	verror=sqlrun(vconeccionF,"tablas_cmb_sql")
	IF verror=.f.
		MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
		RETURN 
	ENDIF 

	eje=" SELECT Tables_in_"+_SYSSCHEMA+" as tablanom from tablas_cmb_sql INTO TABLE .\tablas_cmb"
	&eje 

	USE IN tablas_cmb_sql

	sqlmatriz(1)="SELECT * FROM information_schema.tables where TRIM(table_schema) = '"+_SYSSCHEMA+"'" 
	verror=sqlrun(vconeccionF,"tablascmb0_tipo")
	IF verror=.f.
		MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
		RETURN 
	ENDIF 

	
	eje=" SELECT t.tablanom, ty.table_type as tipo , ty.auto_increment as autoincre from tablas_cmb t left join tablascmb0_tipo ty on alltrim(t.tablanom) == alltrim(ty.table_name) INTO TABLE .\tablascmb_tipo"
	&eje 

	SELECT tablascmb_tipo
	INDEX on ALLTRIM(tablanom) TAG tablanom 



	SELECT tablas_cmb 
	GO TOP 
	eje = "v_pritabla = ALLTRIM(tablas_cmb.tablanom)"
	&eje 
		
	DO WHILE !EOF()
	*!*		eje = "v_tabla = ALLTRIM(tablas.Tables_in_"+_SYSSCHEMA+")"
		eje = "v_tabla = ALLTRIM(tablas_cmb.tablanom)"
		&eje 

		sqlmatriz(1)="SELECT *, CONVERT(COLUMN_TYPE,CHAR(30)) AS TYPO FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '"+ALLTRIM(_SYSSCHEMA)+"' AND TABLE_NAME = '"+v_tabla+"'"
		verror=sqlrun(vconeccionF,"columnas0cmb_sql")
		IF verror=.f.
			MESSAGEBOX("No se puede obtener los Tipos de Comprobantes",0+16,"Advertencia")
			RETURN 
		ENDIF 
		SELECT column_name as field, typo as type, is_nullable as null, column_key as key, extra, column_default as default from columnas0cmb_sql INTO CURSOR columnascmb_sql 
		USE IN columnas0cmb_sql
		
		SELECT columnascmb_sql
		
		
		eje="SELECT  *, v_tabla+SPACE(30) as tablanom, .f. as sel, 10 as orden FROM columnascmb_sql INTO TABLE .\columnascmb"+v_tabla
		&eje 	
		
		IF v_tabla = v_pritabla THEN 
			SELECT *  FROM columnascmb&v_tabla INTO TABLE .\columnascmb
			ALTER TABLE columnascmb alter tablanom c(30)
			ALTER TABLE columnascmb alter field c(30)
			ALTER TABLE columnascmb alter type c(30)
			ALTER table columnascmb ADD COLUMN tipotabla c(20)

		ELSE
			SELECT columnascmb
			eje = " APPEND FROM .\columnascmb"+v_tabla
			&eje 
		ENDIF  
		SELECT columnascmb&v_tabla
		USE 
		
		SELECT tablas_cmb
		SKIP 
	ENDDO 


	SELECT tablas_cmb
	SELECT columnascmb 
	INDEX on ALLTRIM(tablanom) TAG tablanom

*!*		SELECT tablascmb
*!*		SET RELATION TO ALLTRIM(tablanom) INTO columnascmb 

	SELECT columnascmb
	GO TOP 
	SET RELATION TO ALLTRIM(tablanom) INTO tablascmb_tipo
	replace ALL tipotabla WITH tablascmb_tipo.tipo 
	
	SELECT columnascmb
	GO TOP 
	DO WHILE !EOF()
	
		IF (LOWER(ALLTRIM(columnascmb.type)) == 'float(13,4)' OR LOWER(ALLTRIM(columnascmb.type)) == 'float(13,2)' ) AND ALLTRIM(columnascmb.tipotabla)=='BASE TABLE'  THEN 
			sqlmatriz(1)="alter table "+ALLTRIM(columnascmb.tablanom)+" modify column "+ALLTRIM(columnascmb.field)+" double(13,2)"
			verror=sqlrun(vconeccionF,"modicolumna")
			IF verror=.f.
				MESSAGEBOX("No se puede modificar los campos flotantes de la base de datos ",0+16,"Advertencia")
				RETURN 
			ENDIF 
		ENDIF 

		sele columnascmb
		SKIP 
	ENDDO  
	* me desconecto	
	=abreycierracon(vconeccionF,"")
	
ENDFUNC 


FUNCTION GeneraEtiquetas
PARAMETERS pge_tabla, pge_id, pge_detalle, pge_cantidad, pge_detalleb
*#/----------------------------------------
* ----------------------------------------------------------------------------------------
*- Genera Registro en Tabla Etiquetas para los registros Pasados como parametros
*- Parametros : 
*-				TABLA    : Tabla que contiene el registro para el cual se generara la etiqueta
*-              ID       : Valor del Indice para la generación de la Etiqueta
*-              CANTIDAD : Cantidad de Etiquetas a Generar
*- Retorna el indice de las etiquetas generadas : Primer Etiqueta y Ultima Etiqueta 
*- formato : DDDDDDDDDD;DDDDDDDDDD
*-----------------------------------------------------------------------------------------
*#/----------------------------------------


	v_nomIndice	 = obtenerCampoIndice(ALLTRIM(pge_tabla))
	
	v_TipoIndice = TYPE("pge_id")
	IF v_TipoIndice ='C' THEN 
		pge_idc = "'"+ALLTRIM(pge_id)+"'"
	ELSE
		pge_idc = ALLTRIM(STR(pge_id))
	ENDIF 

	IF TYPE("pge_detalleb") ='C' THEN 
		vardetalleb = "'"+ALLTRIM(pge_detalleb)+"'"
	ELSE
		vardetalleb = "''"
	ENDIF 


	vconeccionF = abreycierracon(0,_SYSSCHEMA)

*-- Chequeo si existe el registro para el cual estoy generando las etiquetas
	sqlmatriz(1)=" select * from  "+ALLTRIM(pge_tabla)+" where "+ALLTRIM(v_nomIndice)+" = "+pge_idc
	verror=sqlrun(vconeccionF,"ExisteReg")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Registro en la tabla a etiquetar ",0+48+0,"Error")
		=abreycierracon(vconeccionF,"")	
		RETURN ""
	ENDIF 
	SELECT ExisteReg
	GO TOP 
	IF EOF() THEN 
	    MESSAGEBOX("No Existe el Registro para el Cual se Quieren Generar Etiquetas ",0+48+0,"Error")
		=abreycierracon(vconeccionF,"")	
		USE IN ExisteReg
		RETURN ""
	ENDIF 
	USE IN ExisteReg
*--------------------------------------------------------------------------


	indice = 1	
	vararticulo   = IIF(v_TipoIndice ="C","'"+ALLTRIM(pge_id)+"'","''")
	varidregistro = IIF(v_TipoIndice ="C","0",ALLTRIM(STR(pge_id)))
	
	vetiquetad = 0
	vetiquetah = 0		

	vardetalle= "'"+ALLTRIM(pge_detalle)+"'"
	
	DO WHILE indice <= pge_cantidad
				
		v_etiqueta = 0		
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
					
		DIMENSION lamatriz3(9,2)
					
		lamatriz3(1,1)='etiqueta'
		lamatriz3(1,2)=ALLTRIM(STR(v_etiqueta))
		lamatriz3(2,1)='fechaalta'
		lamatriz3(2,2)="'"+dtos(DATE())+"'"
		lamatriz3(3,1)='codigo'
		lamatriz3(3,2)="''"
		lamatriz3(4,1)='articulo'
		lamatriz3(4,2)=vararticulo   
		lamatriz3(5,1)='tabla'
		lamatriz3(5,2)="'"+ALLTRIM(pge_tabla)+"'"
		lamatriz3(6,1)='campo'
		lamatriz3(6,2)="'"+ALLTRIM(v_nomIndice)+"'"
		lamatriz3(7,1)='idregistro'
		lamatriz3(7,2)=varidregistro 
		lamatriz3(8,1)='detalle'
		lamatriz3(8,2)=vardetalle 
		lamatriz3(9,1)='detalleb'
		lamatriz3(9,2)=vardetalleb 
					

		p_tabla     = 'etiquetas'
		p_matriz    = 'lamatriz3'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_etiqueta )),0+48+0,"Error")
		    RETURN ""
		ELSE
			
			sqlmatriz(1)=" select last_insert_id() as maxid "
			verror=sqlrun(vconeccionF,"ultimoId")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
				=abreycierracon(vconeccionF,"")	
			ENDIF 
			SELECT ultimoId
			GO TOP 
			v_etiqueta = VAL(ultimoId.maxid)
			USE IN ultimoId
			
			IF vetiquetad = 0 THEN 
				vetiquetad = v_etiqueta
			ENDIF 
			vetiquetah = v_etiqueta
			
					
		ENDIF 

		indice = indice+1
					
	ENDDO 
	=abreycierracon(vconeccionF,"")	

	RETURN ALLTRIM(STR(vetiquetad))+";"+ALLTRIM(STR(vetiquetah))

ENDFUNC 




FUNCTION PrintEtiquetas
PARAMETERS par_etiqueimp, par_etiquetaINI, par_etiquetaFIN, par_BCQR
*#/----------------------------------------
*- Impresión de Etiquetas, recibe como parametro una tabla o un rango de Etiquetas 
*- con el listado de etiquetas a Imprimir y el modo de etiqueta seleccionado
*- BC: Codigo de Barras, QR : Codigo QR
*#/----------------------------------------

	vconeccionF=abreycierracon(0,_SYSSCHEMA)

	IF EMPTY(ALLTRIM(par_etiqueimp)) THEN 
		sqlmatriz(1)="select etiqueta from etiquetas where etiqueta >= "+ALLTRIM(STR(par_etiquetaINI))+" and etiqueta <= "+ALLTRIM(STR(par_etiquetaFIN))
		verror=sqlrun(vconeccionF,"impeti_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la seleccion de Etiquetas " ,0+48+0,"Seleccion de Etiquetas ")
			=abreycierracon(vconeccionF,"")	
			RETURN 
		ENDIF 
		SELECT impeti_sql
		SELECT * FROM impeti_sql INTO TABLE .\printetique 
		USE IN impeti_sql 
		SELECT printetique
		USE IN printetique			
		par_etiqueimp = "printetique"
	ENDIF 

	eje = " USE "+par_etiqueimp+" in 0 "
	&eje 
	SELECT &par_etiqueimp
	GO TOP 
	vimp_etiquetas = ""
	DO WHILE !EOF()
		
		vimp_etiquetas = ALLTRIM(vimp_etiquetas)+","+ALLTRIM(STR(&par_etiqueimp..etiqueta))
		SELECT &par_etiqueimp
		SKIP 
	ENDDO 
	USE IN &par_etiqueimp 
	vimp_etiquetas= SUBSTR(vimp_etiquetas,2)

	sqlmatriz(1)= " SELECT * from etiquetas where etiqueta in ( "+vimp_etiquetas+" ) " 
	sqlmatriz(2)= " order by tabla, detalle, etiqueta "
	verror=sqlrun(vconeccionF,"etiquetasimp_sql")
	IF verror=.f.
		MESSAGEBOX("No se puede obtener las Etiquetas... ",0+16,"Advertencia")
		=abreycierracon(vconeccionF,"")
		RETURN 
	ENDIF 

	
	narchivo = "petiquetas"+ALLTRIM(LOWER(par_BCQR))
	SELECT *, SPACE(50) as cb1, SPACE(50) as cb2, SPACE(100) qr1, SPACE(100) as qr2 FROM etiquetasimp_sql INTO TABLE .\&narchivo
	USE IN etiquetasimp_sql 
	
	=abreycierracon(vconeccionF,"")

	SELECT &narchivo
	IF par_BCQR = 'QR' THEN 
		PRIVATE poFbc
		poFbc = CREATEOBJECT("FoxBarcodeQR")
	    poFbc.nBackColor = RGB(255,255,255) && White
		poFbc.nBarColor = RGB(0,0,0) && Black
		poFbc.nCorrectionLevel = 0 && Medium 15%
	ENDIF 
	

	DO WHILE !EOF()
		
********************************************************************************************
				
		*** Genero Código QR ***
		** Armo la del Codigo de Barras **
		v_etiquetaqr 	= "*"+ALLTRIM(STR(&narchivo..etiqueta))+"*"
		v_codigoqr		= "*/"+IIF(&narchivo..idregistro <> 0,"//"+ALLTRIM(STR(&narchivo..idregistro)),IIF(EMPTY(ALLTRIM(&narchivo..articulo))=.t.,"/"+ALLTRIM(&narchivo..codigo),ALLTRIM(&narchivo..articulo)))+"*"
		replace cb1 WITH v_etiquetaqr, cb2 WITH v_codigoqr 

		IF par_BCQR = 'QR' THEN 	&& Armo la cadena a codificar en el código QR **


			** Genero la imagen con el código QR **
			* QR etiqueta
			v_idRegistroStr = ALLTRIM(STRTRAN(STR((&narchivo..etiqueta),10,0),' ','0'))
			v_ubicacionImgen = _SYSESTACION+"\etiquetaQR_"+ v_idRegistroStr 
			v_codQRImg= poFbc.FullQRCodeImage(ALLTRIM(v_etiquetaqr),v_ubicacionImgen,250)				
			v_ubicacionImgenE = v_ubicacionImgen+".bmp"
			**
			* Codigo QR
			v_ubicacionImgen = _SYSESTACION+"\codigoQR_"+ v_idRegistroStr 
			v_codQRImg= poFbc.FullQRCodeImage(ALLTRIM(v_codigoqr),v_ubicacionImgen,250)				
			v_ubicacionImgenC = v_ubicacionImgen+".bmp"


			replace qr1 WITH v_ubicacionImgenE, qr2 WITH v_ubicacionImgenC
			
		ENDIF 				
	
**********************************************************************************************
		SELECT &narchivo
		SKIP 
	ENDDO 

	RELEASE poFbc

	SELECT &narchivo 
	GO TOP 
	
	DO FORM reporteform WITH narchivo,narchivo+"cr","printetiquetas"+par_BCQR
	USE IN &narchivo	
	

	
RETURN 
ENDFUNC 





FUNCTION FindInTables
PARAMETERS fi_tabla, fi_campo, fi_valor, fi_modo, fi_excluidas
*#/----------------------------------------
*---VERIFICA AL INTEGRIDAD REFERENCIA DE DATOS-----------------------
*- Busqueda de un valor y un campo dado en una tabla en 
*- Las Tablas Restantes del Esquema
*- Devuelve vacio si el valor ingresado no existe en las otras tablas
*- Si existe devuelve la primer tabla en la que se encuentra
*- PARAMETER : tabla: nombre tabla origen de datos
*-			   campo: nombre del campo 
*-             valor: valor del campo a buscar,
*-              modo: modo de busqueda, 0 busca todas las ocurrencias, 1 busca la primer ocurrencia
*-		   excluidas: tablas excluidas , tablas en las que no debe controlar la existencia del valor a eliminar
*-                    formato de fi_excluidas = "'tabla1','tabla2','tabla3',...etc'"
*--------------------------------------------------------------------
*#/----------------------------------------	
	
	IF !(TYPE("fi_excluidas")="C") THEN 
		fi_excluidas = "''"
	ENDIF 


	ptablareto = ""

	vconeccionF=abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)= " SELECT TABLE_NAME as tablash FROM information_schema.columns where TRIM(TABLE_SCHEMA) = '"+ALLTRIM(_SYSSCHEMA)+"' and TRIM(TABLE_NAME) <> '"+ALLTRIM(fi_tabla)+"' AND TRIM(COLUMN_NAME)= '"+ALLTRIM(fi_campo)+"'" 
	sqlmatriz(2)= " and TRIM(TABLE_NAME) not in ( SELECT TRIM(TABLE_NAME) FROM information_schema.tables "
	sqlmatriz(3)= " WHERE TRIM(TABLE_SCHEMA) = '"+alltrim(_SYSSCHEMA)+"' and ( TRIM(TABLE_TYPE)='VIEW' or TRIM(TABLE_NAME) like 'r_%' or TRIM(TABLE_NAME) in ("+ALLTRIM(fi_excluidas)+") )  ) "
	
	verror=sqlrun(vconeccionF,"tablas_hijas")
	IF verror=.f.
		MESSAGEBOX("No se puede obtener las Tablas de "+alltrim(_SYSSCHEMA),0+16,"Advertencia")
		RETURN 
	ENDIF 
	
	SELECT tablas_hijas
	GO TOP 

	fi_cantidad = 0 
	DO WHILE !EOF()	
		sqlmatriz(1)="SELECT "+fi_campo+" FROM "+ALLTRIM(tablas_hijas.tablash)+" where "+fi_campo+"= "+IIF(TYPE("fi_valor")="C","'"+ALLTRIM(fi_valor)+"'",ALLTRIM(STR(fi_valor)))
		verror=sqlrun(vconeccionF,"existe")
		IF verror=.f.
			MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
			RETURN 
		ENDIF 
		SELECT existe
		GO TOP 
		IF !EOF() THEN 
			ptablareto = ptablareto + ';'+ALLTRIM(tablas_hijas.tablash)
			fi_cantidad = fi_cantidad + 1
		ENDIF  
		USE IN existe 
		SELECT tablas_hijas
		IF fi_modo > 0 AND fi_cantidad > 0 THEN 
			GO BOTTOM 			
		ENDIF 
		SKIP 
	ENDDO 
	USE IN tablas_hijas
	vconeccionF=abreycierracon(vconeccionF,"")
	
	RETURN ptablareto 
ENDFUNC 



FUNCTION eliminarRegistros
PARAMETERS p_tabla,p_campo,p_valor
*#/----------------------------------------
*** Elimina todas las dependencias del registro pasado como parámetro. ****
** Parametros:
***			p_tabla: Tabla asociada al registro, desde esta tabla se buscan las tablas relacionadas
***			p_campo: Campo de las tablas a eliminar
***			p_valor: Valor del registro a eliminar
** Retorno: Retorna True en caso que se hayan eliminado todas las dependencias del registro, False en otro caso
*#/----------------------------------------

		v_listaTablas = ""
		v_listaTablas = FindInTables(p_tabla, p_campo, p_valor, 0)
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			
		ALINES(arregloTablas,v_listaTablas,.F.,';')
			
		v_tam = ALEN(arregloTablas)
			
		IF v_tam > 0 THEN 
				
				* INICIAR TRANSACCION
				SQLFlagErrorTrans=0
				IF SqlIniciartrans(vconeccionF)=.f.
					MESSAGEBOX("NO se pudo iniciar la Transaccion ",0+48+0,"Error")
					SQLFlagErrorTrans=1
				ELSE 
			
					** Elimino los registros asociados a la tabla pasada como parámetro **
					FOR ie = 1 TO v_tam
						v_tablaEliminar = ""
						v_tablaEliminar = arregloTablas[ie]
						
						IF EMPTY(ALLTRIM(v_tablaEliminar)) = .F.
							
							sqlmatriz(1)=" delete from "+ALLTRIM(v_tablaEliminar)
							sqlmatriz(2)=" where "+ALLTRIM(p_campo)+"="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),"'"+ALLTRIM(p_valor)+"'"))
							verror=sqlrun(vconeccionF,"eliminaTabla_sql")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
							    SQLFlagErrorTrans=1
							    EXIT 
							ENDIF
							
						ENDIF 
						
					ENDFOR 
			
					*Elimino los registros de las tablas asociadas en relaciones indirectas a la tabla pasada como parametro
						* --> estadosreg
						sqlmatriz(1)=" delete from estadosreg "
						sqlmatriz(2)=" where tabla='"+ALLTRIM(p_tabla)+"' and id='"+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))+"'"
						verror=sqlrun(vconeccionF,"eliminaTabla_sql")
						IF verror=.f.  
						    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
						    SQLFlagErrorTrans=1
						    
						ENDIF

						* --> reldatosextra
						sqlmatriz(1)=" delete from reldatosextra "
						sqlmatriz(2)=" where tabla='"+ALLTRIM(p_tabla)+"' and idregistro="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))
						verror=sqlrun(vconeccionF,"eliminaTabla_sql")
						IF verror=.f.  
						    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla reldatosextra ",0+48+0,"Error")
						    SQLFlagErrorTrans=1
						    
						ENDIF

						* --> planillacajacomp
						sqlmatriz(1)=" delete from planillacajacomp "
						sqlmatriz(2)=" where tabla='"+ALLTRIM(p_tabla)+"' and idregistro="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))
						verror=sqlrun(vconeccionF,"eliminaTabla_sql")
						IF verror=.f.  
						    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla planillacajacomp",0+48+0,"Error")
						    SQLFlagErrorTrans=1    
						ENDIF


						* --> cajarecaudah ( facturas, recibos, factuprove, pagosprov, remitos, vinculocomp, pagares, np, presupuesto, cajaie
						* ajustestockp, cajamovip, transferencias, transferencias
						sqlmatriz(1)=" select * from "+ALLTRIM(p_tabla)
						sqlmatriz(2)=" where "+ALLTRIM(p_campo)+"="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),"'"+ALLTRIM(p_valor)+"'"))
						verror=sqlrun(vconeccionF,"registroTabla_sql")
						IF verror=.f.  
						    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
						    SQLFlagErrorTrans=1
						ENDIF
						SELECT registroTabla_sql
						LOCAL var_idcompro 
						var_idcompro = 0
						GO TOP 
						IF !EOF() THEN 
							FOR ncampos = 1 TO FCOUNT("registroTabla_sql")
								IF LOWER(ALLTRIM(FIELD(ncampos))) = 'idcomproba'	THEN 
									var_idcompro = registrotabla_sql.idcomproba
								ENDIF 
							ENDFOR 
						ENDIF 
						USE IN registrotabla_sql 

						IF var_idcompro > 0 THEN 
							sqlmatriz(1)=" delete from cajarecaudah "
							sqlmatriz(2)=" where idcomproba="+ALLTRIM(STR(var_idcompro))+" and idregicomp="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))
							verror=sqlrun(vconeccionF,"eliminaTabla_sql")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: cajarecaudah",0+48+0,"Error")
							    SQLFlagErrorTrans=1
							    
							ENDIF
						ENDIF 				

						
						* --> linkcompro ( facturas, recibos, factuprove, pagosprov, remitos, vinculocomp, pagares, np, presupuesto, cajaie
						IF var_idcompro > 0 THEN 
							sqlmatriz(1)=" delete from linkcompro "
							sqlmatriz(2)=" where ( idcomprobaa="+ALLTRIM(STR(var_idcompro))+" and idregistroa="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))+" )"
							sqlmatriz(3)="       or ( idcomprobab="+ALLTRIM(STR(var_idcompro))+" and idregistrob="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))+" )"
							verror=sqlrun(vconeccionF,"eliminaTabla_sql")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: linkcompro ",0+48+0,"Error")
							    SQLFlagErrorTrans=1
							    
							ENDIF
						ENDIF 				
						
						IF ALLTRIM(p_tabla)=='facturas'  THEN 
							sqlmatriz(1)=" delete from cobros "
							sqlmatriz(2)=" where idfactura="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))
							verror=sqlrun(vconeccionF,"eliminaTabla_sql")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: cobros ",0+48+0,"Error")
							    SQLFlagErrorTrans=1
							    
							ENDIF
						ENDIF 				
						
						* --> asientoscompro ( facturas, recibos, factuprove, pagosprov, remitos, vinculocomp, pagares, np, presupuesto, cajaie
						IF var_idcompro > 0 THEN 

							sqlmatriz(1)=" select idasiento from asientoscompro "
							sqlmatriz(2)=" where ( tabla='"+ALLTRIM(p_tabla)+"' and idregicomp="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),ALLTRIM(p_valor)))+" )"
							verror=sqlrun(vconeccionF,"asientoTabla_sql")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error al traer el asiento asociado a la tabla tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
							    SQLFlagErrorTrans=1
							ENDIF
							SELECT asientoTabla_sql
							LOCAL var_nroidasiento 
							var_nroidasiento = 0
							GO TOP 
							IF !EOF() THEN 
								var_nroidasiento = asientoTabla_sql.idasiento
							ENDIF 
							USE IN asientoTabla_sql
							IF var_nroidasiento > 0 THEN 

								* Elimino Asociacion con Comprobantes 
								sqlmatriz(1)="DELETE FROM asientoscompro WHERE idasiento = " + ALLTRIM(STR(var_nroidasiento))
								verror=sqlrun(vconeccionF,"asiento1")
								IF verror=.f.  
								    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
								    SQLFlagErrorTrans=1
								ENDIF

								* Elimino Asociacion con Asientos Agrupados si la Hubiere 
								sqlmatriz(1)="DELETE FROM asientosg WHERE idasiento = " + ALLTRIM(STR(var_nroidasiento))
								verror=sqlrun(vconeccionF,"asiento1")
								IF verror=.f.  
								    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
								    SQLFlagErrorTrans=1
								ENDIF

								* Elimino Asiento * 
								sqlmatriz(1)="DELETE FROM asientos WHERE idasiento = " + ALLTRIM(STR(var_nroidasiento))
								verror=sqlrun(vconeccionF,"asiento1")
								IF verror=.f.  
								    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
								    SQLFlagErrorTrans=1
								ENDIF
							
							ENDIF 
						ENDIF 				
								
					**********************************************************
					
					** Elimino el registro de la tabla pasada como parámetro**
					sqlmatriz(1)=" delete from "+ALLTRIM(p_tabla)
					sqlmatriz(2)=" where "+ALLTRIM(p_campo)+"="+ALLTRIM(IIF(TYPE('p_valor')='N',STR(p_valor),"'"+ALLTRIM(p_valor)+"'"))
					verror=sqlrun(vconeccionF,"eliminaTabla_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error al eliminar el registro de la tabla: "+ALLTRIM(p_tabla),0+48+0,"Error")
					    SQLFlagErrorTrans=1
					    
					ENDIF
			
			
			
					* FINALIZAR TRANSACCION
					IF sqlCerrarTrans(vconeccionF,SQLFlagErrorTrans)=.f.
						MESSAGEBOX("Ha Ocurrido un error al cerrar la Transacción ",0+48+0,"ERROR en Transacción")
						SQLFlagErrorTrans=1
					ENDIF 

			
				ENDIF 

					* Guardo el valor de SQLFlagErrorTrans
					I_SQLFlagErrorTrans  = SQLFlagErrorTrans		
								
					IF I_SQLFlagErrorTrans=1 
						MESSAGEBOX("Han Ocurrido Errores. La del registro en la Base de Datos NO FUE Realizada",0+16+0,"ERROR en Transacción")
						RETURN .F.
					ELSE
						*MESSAGEBOX("Se ha eliminado el registro correctamente",0+64+0,"Registro eliminado")
						RETURN .T.
					ENDIF 
				ENDIF 
			
				RETURN .F.
						
			
ENDFUNC 




FUNCTION CambiaIDCodigomat
PARAMETERS pca_codigo,pca_modo, pca_conex 
*#/----------------------------------------
*- devuelve el codigo del material o bien el idmate, dependiendo 
*- de la conversion que se le pida especificada en Modo
*- pca_modo = 'ID' OR 'CO'
*- ID = devuelve IDMATE buscando con CODIGOMAT
*- CO = devuelve CODIGOMAT buscando con IDMATE 
*#/----------------------------------------

cretorno = ""
IF !empty(pca_codigo) THEN
	
	pca_codigo = STRTRAN(STRTRAN(pca_codigo,'/',''),'*')
	
	sqlmatriz(1)=" SELECT * FROM otmateriales "
	IF UPPER(pca_modo) = 'CO' THEN 
		sqlmatriz(2)=" WHERE idmate = "+ALLTRIM(STR(VAL(pca_codigo)))
	ELSE
		sqlmatriz(2)=" WHERE codigomat = '"+ALLTRIM(pca_codigo)+"' or TRIM(codbarra) = '"+ALLTRIM(pca_codigo)+"'"
	ENDIF 
	verror=sqlrun(pca_conex,"otmatecam")
	IF verror=.f.
			* me desconecto
		=abreycierracon(pca_conex,"")
		RETURN 
	ENDIF 
	SELECT otmatecam
	GO TOP
	IF !EOF() 
		IF UPPER(pca_modo) = 'CO' THEN 
			cretorno = otmatecam.codigomat		
		ELSE
			cretorno = ALLTRIM(STR(otmatecam.idmate))
		ENDIF 
	ENDIF 
	USE IN otmatecam
ENDIF 
RETURN cretorno
ENDFUNC



FUNCTION BuscaLoteEti
PARAMETERS pl_tablaeti
*#/----------------------------------------
*- Devuelve el Nombre de Una Tabla conteniendo las Etiquetas 
*- que contiene un lote de Lectura Batch de Etiquetas
*- pl_tablaeti: nombre de la tabla para seleccion de etiquetas
*- devuelve el nombre de la tabla con los datos de la consulta o vacio si no selecciona nada
*#/----------------------------------------
	cretorno = ""
	DO FORM lecturaetiquetas TO v_loteeti
	
	IF v_loteeti > 0 THEN 
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		*Busco El Lote de Lectura Seleccionado 
		sqlmatriz(1)=" SELECT * FROM lecturaetique where idletique = "+STR(v_loteeti)
		verror=sqlrun(vconeccionF,"lecturasel_sql")
		IF verror=.f.
				* me desconecto
			=abreycierracon(vconeccionF,"")
			RETURN 
		ENDIF 
		SELECT lecturasel_sql
		GO TOP 
		IF !EOF() THEN 
*******************************************************************************	

			IF !EMPTY(lecturasel_sql.lecturae) THEN 



				vcanetique=ALINES(Arrayetiquetas,lecturasel_sql.lecturae)
				vcvalidas = 0
				vnonulas = 0
				varetiquetas = ""
				vararticulos = ""

				sqlmatriz(1)="create temporary table tmetiquetas select etiqueta from etiquetas limit 0 "
				verror=sqlrun(vconeccionF,"tmetiquetas_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Lecturas de Etiquetas ...",0+48+0,"Error")
				ENDIF 
				sqlmatriz(1)="create temporary table tmarticulos select articulo from articulos limit 0 "
				verror=sqlrun(vconeccionF,"tmarticulo_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Lecturas de Etiquetas ...",0+48+0,"Error")
				ENDIF 
				

				FOR ieti = 1 TO vcanetique 
				
					IF atc('/',arrayetiquetas(ieti )) = 0 AND !EMPTY(ALLTRIM(arrayetiquetas(ieti ))) THEN 

						varetiquetas = varetiquetas+','+ALLTRIM(STR(VAL(STRTRAN(arrayetiquetas(ieti ),'*',''))))
						varetiquetasins = ALLTRIM(STR(VAL(STRTRAN(arrayetiquetas(ieti ),'*',''))))
						
						sqlmatriz(1)="insert into tmetiquetas ( etiqueta ) values ( "+varetiquetasins+" )"
						verror=sqlrun(vconeccionF,"tmetiquetas")
						IF verror=.f.  
						    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Lecturas de Etiquetas ...",0+48+0,"Error")
						ENDIF 

					ENDIF 
					
					*Codigos de articulos
					IF !EMPTY(ALLTRIM(arrayetiquetas(ieti ))) AND LEN(ALLTRIM(arrayetiquetas(ieti ))) > 1 AND ( atc('/',arrayetiquetas(ieti )) = 2 OR atc('/',arrayetiquetas(ieti )) = 1 ) THEN 
						vararticulos = vararticulos+','+ALLTRIM(STRTRAN(STRTRAN(arrayetiquetas(ieti ),'*',''),'/',''))

						vararticulosins = ALLTRIM(STRTRAN(STRTRAN(arrayetiquetas(ieti ),'*',''),'/',''))

						sqlmatriz(1)="insert into tmarticulos values ( '"+vararticulosins+"')"
						verror=sqlrun(vconeccionF,"tmetiquetas")
						IF verror=.f.  
						    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Lecturas de Etiquetas ...",0+48+0,"Error")
						ENDIF 

					ENDIF 
					
					IF !EMPTY(ALLTRIM(arrayetiquetas(ieti ))) THEN 
						vnonulas = vnonulas + 1
					ENDIF 
					
				ENDFOR 
				lenvaretique = LEN(varetiquetas)
				varetiquetas = IIF(SUBSTR(varetiquetas,1,1)=',',SUBSTR(varetiquetas,2),varetiquetas)
				varetiquetas = IIF(SUBSTR(varetiquetas,(lenvaretique-1),1)=',',SUBSTR(varetiquetas,1,lenvaretique-1),varetiquetas)
				
*!*					sqlmatriz(1)="SELECT * from etiquetas where tabla ='"+ALLTRIM(pl_tablaeti)+"' and etiqueta in ( "+varetiquetas+" ) "
				sqlmatriz(1)="SELECT * from etiquetas where tabla ='"+ALLTRIM(pl_tablaeti)+"' and etiqueta in ( select etiqueta from tmetiquetas ) "
				verror=sqlrun(vconeccionF,"etiquetasleidas_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Lecturas de Etiquetas ...",0+48+0,"Error")
				ENDIF 

				
				eje = "SELECT *, "+STR(v_loteeti)+" as idletique, 1 as canti from etiquetasleidas_sql INTO TABLE .\seleccetiquetas "
				&eje 
				
				ALTER table seleccetiquetas alter COLUMN canti i
				ALTER table seleccetiquetas alter COLUMN idletique i
****************************
				********* Agrego las lecturas de codigos de articulos sin numero de etiquetas ej /2021

				lenvararticu = LEN(vararticulos)
				vararticulos = IIF(SUBSTR(vararticulos,1,1)=',',SUBSTR(vararticulos,2),vararticulos )
				vararticulos = IIF(SUBSTR(vararticulos,(lenvararticu-1),1)=',',SUBSTR(vararticulos,1,lenvararticulos-1),vararticulos)
				IF !EMPTY(vararticulos) THEN 
				
*!*						sqlmatriz(1)="SELECT * from articulos where TRIM(articulo) in ( "+vararticulos+" ) "
					sqlmatriz(1)="SELECT * from articulos where TRIM(articulo) in ( select TRIM(articulo) from tmarticulos ) "
					verror=sqlrun(vconeccionF,"articulosleidos_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Lecturas de Artículos ...",0+48+0,"Error")
					ENDIF 

					SELECT articulosleidos_sql 
					
					eje = "SELECT 0 as etiqueta, DTOS(DATE()) as fechaalta,articulo, 'articulos' as tabla, 'articulo' as campo, 0 as idregistro, ALLTRIM(articulo)+'-'+ALLTRIM(detalle)  as detalle, " ;
							+" '' as timestamp, "+STR(v_loteeti)+" as idletique, 0 as canti from articulosleidos_sql INTO TABLE .\articulosleidos "
					&eje 
					ALTER table articulosleidos alter COLUMN canti i
					ALTER table articulosleidos alter COLUMN idletique i

					SELECT articulosleidos
					FOR i = 1 TO vcanetique 
						*Codigos de articulos
						IF !EMPTY(ALLTRIM(arrayetiquetas(i))) AND LEN(ALLTRIM(arrayetiquetas(i))) > 1 AND atc('//',arrayetiquetas(i)) = 0 AND ( atc('/',arrayetiquetas(i)) = 2 OR atc('/',arrayetiquetas(i)) = 1 ) THEN 
							SELECT articulosleidos
							UPDATE articulosleidos SET canti = canti + 1 WHERE ALLTRIM(articulo)==ALLTRIM(STRTRAN(STRTRAN(arrayetiquetas(i),'*',''),'/',''))
						ENDIF 		
					ENDFOR 
					
*!*						
*!*						SELECT &vviewetiquetas 
*!*						APPEND FROM articulosleidos 
			*		COUNT FOR idletique = thisform.tb_idletique.Value AND !DELETED() TO vcvalidas 
					GO TOP 
					
					USE IN articulosleidos_sql 
					SELECT seleccetiquetas
					APPEND FROM articulosleidos
					USE IN articulosleidos
				
				
				ENDIF 
				
			***********************************************************************************************

****************************
				USE IN etiquetasleidas_sql 
*!*					SELECT seleccetiquetas
*!*					APPEND FROM articulosleidos
				USE IN seleccetiquetas
*!*					USE IN articulosleidos
				cretorno = "seleccetiquetas"
				
			ENDIF 

		ELSE 
		
		ENDIF 

		=abreycierracon(vconeccionF,"")	

	ENDIF 

RETURN cretorno
ENDFUNC




FUNCTION pedirAutorizacion
PARAMETERS p_funcion, p_detalleauto
*#/----------------------------------------
**Función para pedir autorización para realizar la función pasada como parámetro
** Busca en la base de datos si corresponde pedir autorización según el usuario y la función.
** Genera un pedido de autorización que deberá autorizar un usuario habilitado para ello
**
** Parametros: p_funcion: nombre clave de la función que se desea autorizar
**
** Retorno: Retorna True en caso de que el usuario esté autorizado. False en otro caso
*#/----------------------------------------

	
	IF ALLTRIM(_SYSPEDIRAUT) == 'N'
		RETURN .T.
	ENDIF 
	
	IF UPPER(ALLTRIM(_SYSNIVELUSU)) == 'SUPERVISOR'
		RETURN .T.
	ENDIF 
	
	v_autorizado = .F.
	
	IF EMPTY(alltrim(p_funcion))= .T.
		
		MESSAGEBOX("El parametro ingresado en la función pedir autorización es incorrecto",0+16+256,"Error al autorizar usuario")
		
		RETURN .F.
	
	ENDIF 
	
		
	 	** Me conecto a la Base de datos
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		*Controlo que la Clave se encuentre en autorizaclaves, si no está la agrego

		p_funcion = ALLTRIM(p_funcion)
		p_funcion = SUBSTR(p_funcion,ATC(' ',p_funcion,1)+1,ATC(' ',p_funcion,2)-ATC(' ',p_funcion,1))

		sqlmatriz(1)=" SELECT * FROM autorizaclaves "
		sqlmatriz(2)=" where UPPER(TRIM(clave)) = '"+UPPER(ALLTRIM(p_funcion))+"'"
		verror=sqlrun(vconeccionF,"autorizaclaves_sql")
		
		IF verror=.f.
			MESSAGEBOX("Error en la consulta al verificar las claves",0+16+256,"Error al autorizar usuario")
				* me desconecto
			=abreycierracon(vconeccionF,"")
			RETURN .F.
		ENDIF 
		SELECT autorizaclaves_sql
		GO TOP 
		IF EOF() THEN  && Si no esta la Clave la Agrega
			sqlmatriz(1)=" insert into autorizaclaves ( idautocla, clave, detalle ) values (0, '"+ALLTRIM(p_funcion)+"','"+ALLTRIM(p_detalleauto)+"')"
			verror=sqlrun(vconeccionF,"autoclaves_sql")
			
			IF verror=.f.
				MESSAGEBOX("Error en la insercion de las claves",0+16+256,"Error al insertar claves")
				=abreycierracon(vconeccionF,"")
				RETURN .F.
			ENDIF 		
			
		ENDIF 
		USE IN autorizaclaves_sql 		

* Controla que este la relacion del Nivel de Usuarios con las Claves, Si no Está Agrega la Relacion Negando Autorización
*
		sqlmatriz(1)=" SELECT * FROM autorizafn "
		sqlmatriz(2)=" where upper(TRIM(nivel)) = '"+UPPER(ALLTRIM(_SYSNIVELUSU))+"' and UPPER(TRIM(clave)) = '"+UPPER(ALLTRIM(p_funcion))+"'"
		verror=sqlrun(vconeccionF,"autofn_sql")
		IF verror=.f.
			MESSAGEBOX("Error en la consulta del usuario al pedir la autorización",0+16+256,"Error al autorizar usuario")
				* me desconecto
			=abreycierracon(vconeccionF,"")
			RETURN .F.
		ENDIF 
		SELECT autofn_sql
		GO TOP 

		IF EOF() THEN  && Si no esta la relacion con la clave y el Nivel de Usuario la agrega Negada
			
			sqlmatriz(1)=" insert into autorizafn ( idautofn, clave, nivel, autoriza, detalle ) values (0, '"+ALLTRIM(p_funcion)+"','"+ALLTRIM(_SYSNIVELUSU)+"','N','"+ALLTRIM(p_detalleauto)+"')"
			verror=sqlrun(vconeccionF,"auto_sql")
			IF verror=.f.
				MESSAGEBOX("Error en la insercion de las claves",0+16+256,"Error al insertar autorizaciones de claves")
				=abreycierracon(vconeccionF,"")
				RETURN .F.
			ENDIF 			

				
		ENDIF 
		USE IN autofn_sql 		

**************************************************************************************************************************

		*
		*Busco en la tabla de autorización de funciones según la clave
		
		sqlmatriz(1)=" SELECT * FROM autorizafn "
		sqlmatriz(2)=" where upper(TRIM(nivel)) = '"+UPPER(ALLTRIM(_SYSNIVELUSU))+"' and UPPER(TRIM(clave)) = '"+UPPER(ALLTRIM(p_funcion))+"'"
		verror=sqlrun(vconeccionF,"autorizafn_sql")
		
		IF verror=.f.
			MESSAGEBOX("Error en la consulta del usuario al pedir la autorización",0+16+256,"Error al autorizar usuario")
				* me desconecto
			=abreycierracon(vconeccionF,"")
			RETURN .F.
		ENDIF 
		
		SELECT autorizafn_sql
		GO TOP 
		
		v_cantReg = RECCOUNT()
		
		IF v_cantReg > 0
			
			v_autoriza = autorizafn_sql.autoriza
			
			IF ALLTRIM(v_autoriza) = 'S'
				v_autorizado = .T.
			ELSE
				
				DO FORM pedirautorizacion WITH p_funcion, p_detalleauto TO v_autorizado
								
			ENDIF 
		ELSE
			v_autorizado = .T.
		
		ENDIF 

	RETURN v_autorizado

ENDFUNC 







FUNCTION obtienePedidosAutorizacion
PARAMETERS  p_nombreTabla,p_estado 
*#/----------------------------------------
** Obtiene todos los pedidos de autorización 
** Parámetros:  p_nombreTabla: nombre de la tabla donde se van a cargar los pedidos
**				p_estado: estado de los pedidos a listar (Puede ser 'A', 'P' o 'N')
** Retorno: True si se cargó correctamente, False en caso contrario
*#/----------------------------------------


	IF EMPTY(ALLTRIM(p_nombreTabla)) = .T.
		MESSAGEBOX("El nombre de la tabla pasada como parámetro es inválida",0+16+256,"Error al obtener pedidos de autorización")
		RETURN .F.	
	ENDIF 
		
		
	** Me conecto a la base de datos
	vconeccionM = abreycierracon(0,_SYSSCHEMA)
		
	IF UPPER(ALLTRIM(_SYSNIVELUSU))='SUPERVISOR' THEN 
		sqlmatriz(1)=" SELECT * "
		sqlmatriz(2)=" FROM autorizaopera  " 
		IF EMPTY(ALLTRIM(p_estado)) = .F.
			sqlmatriz(3)=" WHERE estado = '"+ALLTRIM(p_estado)+"'"
		ENDIF 
	ELSE
		sqlmatriz(1)=" SELECT a.*, b.autoriza FROM autorizaopera a left join autorizafn b on TRIM(b.clave) = TRIM(a.clave) "
		sqlmatriz(2)=" where UPPER(TRIM(b.nivel)) = '"+ALLTRIM(_SYSNIVELUSU)+"' and b.autoriza = 'S' "
		IF EMPTY(ALLTRIM(p_estado)) = .F.
			sqlmatriz(3)=" and a.estado = '"+ALLTRIM(p_estado)+"'"
		ENDIF 	
  	ENDIF 
  	
 	
	verror=sqlrun(vconeccionM ,"autorizaopera_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los pedidos de autorización... ",0+48+0,"Error")
	    RETURN .F.
	ENDIF
	=abreycierracon(vconeccionM ,"")	

	SELECT autorizaopera_sql
	GO TOP 
	
	IF EOF()
		v_sentencia = "SELECT * FROM autorizaopera_sql INTO TABLE "+ALLTRIM(_SYSESTACION)+"\"+alltrim(p_nombreTabla)
		&v_sentencia
		RETURN .F.
	ELSE
	
		v_sentencia = "SELECT * FROM autorizaopera_sql INTO TABLE "+ALLTRIM(_SYSESTACION)+"\"+alltrim(p_nombreTabla)
		&v_sentencia
	ENDIF

	RETURN .T.
	
	
ENDFUNC 



FUNCTION PreciosArticulo
PARAMETERS  pv_articulos
*#/----------------------------------------
** Obtiene todas las cotizaciones y precios segun listas y cuotas para un artículo determinado 
** Parámetros:  p_articulos  - Lista de Articulos a mostrar
*#/----------------------------------------


	pv_articulos = STRTRAN(STRTRAN(STRTRAN(pv_articulos,"´","'"),"(","'"),")","'")
	

	CREATE CURSOR myarticulos (articulo C(20))
	=ALINES(arrpv_articulos,STRTRAN(pv_articulos,"'",""),1,",")
	SELECT myarticulos
	FOR ia = 1 TO ALEN(arrpv_articulos,1)
		APPEND BLANK 
		replace articulo WITH ALLTRIM(arrpv_articulos(ia))
	ENDFOR 

	
	* controlo si ya se genero la lista de precios actual, sino la genero
	pvtmp = frandom()
	vprecioarti = 'precioarti'+pvtmp 
	vprecioartia = vprecioarti+'a'
	vprecioartib = vprecioarti+'b'
	vprecioartic = vprecioarti+'c'
	vprecioartid = vprecioarti+'d'

	IF EMPTY(_SYSLISTAPRECIO)  THEN 
		* Obtengo los Articulos de Cada Lista Seleccionada 
		=GetListasPrecios(vprecioarti)
		SELECT &vprecioartia
		USE 
		SELECT &vprecioartib
		USE 
	ENDIF 


	*** obtengo los precios del articulo pasado como parametro en las distintas listas de precios
	IF !USED('syslistaprea') THEN 
		USE syslistaprea IN 0
	ENDIF 
	IF !USED('syslistapreb') THEN 
		USE syslistapreb IN 0 
	ENDIF 

	SET ENGINEBEHAVIOR 70

	
	IF EMPTY(pv_articulos) THEN 
		v_condicion = ""
	ELSE
		v_condicion = " and trim(articulo) in ( "+pv_articulos+" ) "
		v_condicion1 = " and trim(articulo) in ( select ALLTRIM(articulo) from myarticulos ) "
	ENDIF 
	
	
*	SELECT * FROM syslistaprea INTO TABLE &vprecioartic WHERE ALLTRIM(articulo) in ( &pv_articulos ) ORDER BY articulo GROUP BY articulo 
	SELECT a.* FROM syslistaprea a LEFT JOIN myarticulos m ON ALLTRIM(a.articulo)==ALLTRIM(m.articulo) INTO TABLE &vprecioartic ;
			WHERE 1 = 1 AND !ISNULL(m.articulo) ORDER BY a.articulo GROUP BY a.articulo 




	SELECT a.* FROM syslistaprea a LEFT JOIN myarticulos m ON ALLTRIM(a.articulo)==ALLTRIM(m.articulo) INTO TABLE &vprecioartia  ;
	 	WHERE 1 = 1 AND idlista > 0  AND !ISNULL(m.articulo)  ORDER BY idlista 


	
	SELECT a.idlistah, a.articulo, a.detalle as detalleart, a.pventa as pventaa, a.impuestos as impuestosa, a.pventatot as pventatota,a.detallep as detalista, ;
			b.*, razon as pventa, razon as impuestos, razon as pventatot, ;
			razon as entrega, razon as impcuota ;
		FROM syslistapreb b LEFT JOIN syslistaprea a ON  a.idlista = b.idlista ;
		LEFT JOIN &vprecioartia p ON ALLTRIM(a.articulo) == ALLTRIM(p.articulo) AND b.idlista = p.idlista ;
		INTO TABLE &vprecioartib WHERE b.habilitado = 'S' AND !ISNULL(p.articulo) ORDER BY  b.idlista , b.cuotas

		
*		INTO TABLE &vprecioartib WHERE b.idlista in ( SELECT idlista FROM &vprecioartia ) ;
*		AND b.habilitado = 'S' AND !ISNULL(p.articulo) ORDER BY  b.idlista , b.cuotas
*		AND b.habilitado = 'S' AND ALLTRIM(a.articulo) in ( SELECT ALLTRIM(articulo) FROM &vprecioartia ) ORDER BY  b.idlista , b.cuotas


	SET ENGINEBEHAVIOR 90


	SELECT &vprecioartia 
	ALTER table &vprecioartib alter COLUMN idlistah i 
	SELECT &vprecioartib 
	ALTER table &vprecioartib alter COLUMN idlistah i 
	INDEX on idlistah TAG idlistah
	replace ALL pventa WITH ( pventaa * (1+razon/100) ) , impuestos WITH ( impuestosa * (1+razon/100) ), ;
			 pventatot WITH ( pventatota * (1+razon/100)), entrega WITH 0, impcuota WITH (( pventatota * (1+razon/100))/ cuotas )
	
	
	INDEX on STR(idlista)+STR(cuotas)+STR(idfinancia)+articulo TAG indice1 
		
			 
	** Me conecto a la base de datos
	vconeccionD = abreycierracon(0,_SYSSCHEMA)
		
*	sqlmatriz(1)=" SELECT * FROM depostock where TRIM(articulo) in ( "+ALLTRIM(pv_articulos)+" ) "
	sqlmatriz(1)=" SELECT s.*, d.detalle as nombredep FROM r_depostock s left join depositos d on s.deposito = d.deposito where 1 = 1 "+v_condicion  &&TRIM(articulo) in ( "+ALLTRIM(pv_articulos)+" ) "
	verror=sqlrun(vconeccionD ,"depostock_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Stock por Depósitos... ",0+48+0,"Error")
	    RETURN .F.
	ENDIF
	=abreycierracon(vconeccionD ,"")	


	SELECT * FROM depostock_sql INTO TABLE &vprecioartid  ORDER BY articulo , deposito
	SELECT &vprecioartid
	ALTER TABLE &vprecioartid alter articulo c(20)
	INDEX on ALLTRIM(articulo) TAG articulo 
	
	USE IN depostock_sql			 

	USE IN &vprecioartia
	USE IN &vprecioartib 
	USE IN &vprecioartic 
	USE IN &vprecioartid 

	
	RETURN vprecioarti	
	
ENDFUNC 




*!*	FUNCTION PreciosArticulo
*!*	PARAMETERS  pv_articulos
*!*	*#/----------------------------------------
*!*	** Obtiene todas las cotizaciones y precios segun listas y cuotas para un artículo determinado 
*!*	** Parámetros:  p_articulos  - Lista de Articulos a mostrar
*!*	*#/----------------------------------------


*!*		pv_articulos = STRTRAN(STRTRAN(STRTRAN(pv_articulos,"´","'"),"(","'"),")","'")
*!*		* controlo si ya se genero la lista de precios actual, sino la genero
*!*		pvtmp = frandom()
*!*		vprecioarti = 'precioarti'+pvtmp 
*!*		vprecioartia = vprecioarti+'a'
*!*		vprecioartib = vprecioarti+'b'
*!*		vprecioartic = vprecioarti+'c'
*!*		vprecioartid = vprecioarti+'d'

*!*		IF EMPTY(_SYSLISTAPRECIO)  THEN 
*!*			* Obtengo los Articulos de Cada Lista Seleccionada 
*!*			=GetListasPrecios(vprecioarti)
*!*			SELECT &vprecioartia
*!*			USE 
*!*			SELECT &vprecioartib
*!*			USE 
*!*		ENDIF 


*!*		*** obtengo los precios del articulo pasado como parametro en las distintas listas de precios
*!*		IF !USED('syslistaprea') THEN 
*!*			USE syslistaprea IN 0
*!*		ENDIF 
*!*		IF !USED('syslistapreb') THEN 
*!*			USE syslistapreb IN 0 
*!*		ENDIF 

*!*		SET ENGINEBEHAVIOR 70

*!*		
*!*		IF EMPTY(pv_articulos) THEN 
*!*			v_condicion = ""
*!*		ELSE
*!*			v_condicion = " and trim(articulo) in ( "+pv_articulos+" ) "
*!*		ENDIF 
*!*		
*!*		
*!*	*	SELECT * FROM syslistaprea INTO TABLE &vprecioartic WHERE ALLTRIM(articulo) in ( &pv_articulos ) ORDER BY articulo GROUP BY articulo 
*!*		SELECT * FROM syslistaprea INTO TABLE &vprecioartic WHERE 1 = 1 &v_condicion ORDER BY articulo GROUP BY articulo 

*!*		SELECT * FROM syslistaprea INTO TABLE &vprecioartia WHERE 1 = 1 AND idlista > 0 &v_condicion ORDER BY idlista 
*!*		
*!*		SELECT a.idlistah, a.articulo, a.detalle as detalleart, a.pventa as pventaa, a.impuestos as impuestosa, a.pventatot as pventatota,a.detallep as detalista,  b.*, razon as pventa, razon as impuestos, razon as pventatot, ;
*!*				razon as entrega, razon as impcuota ;
*!*			FROM syslistapreb b LEFT JOIN syslistaprea a ON  a.idlista = b.idlista INTO TABLE &vprecioartib WHERE b.idlista in ( SELECT idlista FROM &vprecioartia ) ;
*!*			AND b.habilitado = 'S' AND ALLTRIM(a.articulo) in ( SELECT ALLTRIM(articulo) FROM &vprecioartia ) ORDER BY  b.idlista , b.cuotas


*!*		SET ENGINEBEHAVIOR 90


*!*		SELECT &vprecioartia 
*!*		ALTER table &vprecioartib alter COLUMN idlistah i 
*!*		SELECT &vprecioartib 
*!*		ALTER table &vprecioartib alter COLUMN idlistah i 
*!*		INDEX on idlistah TAG idlistah
*!*		replace ALL pventa WITH ( pventaa * (1+razon/100) ) , impuestos WITH ( impuestosa * (1+razon/100) ), ;
*!*				 pventatot WITH ( pventatota * (1+razon/100)), entrega WITH 0, impcuota WITH (( pventatota * (1+razon/100))/ cuotas )
*!*		
*!*		
*!*		INDEX on STR(idlista)+STR(cuotas)+STR(idfinancia)+articulo TAG indice1 
*!*			
*!*				 
*!*		** Me conecto a la base de datos
*!*		vconeccionD = abreycierracon(0,_SYSSCHEMA)
*!*			
*!*	*	sqlmatriz(1)=" SELECT * FROM depostock where TRIM(articulo) in ( "+ALLTRIM(pv_articulos)+" ) "
*!*		sqlmatriz(1)=" SELECT s.*, d.detalle as nombredep FROM r_depostock s left join depositos d on s.deposito = d.deposito where 1 = 1 "+v_condicion  &&TRIM(articulo) in ( "+ALLTRIM(pv_articulos)+" ) "
*!*		verror=sqlrun(vconeccionD ,"depostock_sql")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Stock por Depósitos... ",0+48+0,"Error")
*!*		    RETURN .F.
*!*		ENDIF
*!*		=abreycierracon(vconeccionD ,"")	


*!*		SELECT * FROM depostock_sql INTO TABLE &vprecioartid  ORDER BY articulo , deposito
*!*		SELECT &vprecioartid
*!*		ALTER TABLE &vprecioartid alter articulo c(20)
*!*		INDEX on ALLTRIM(articulo) TAG articulo 
*!*		
*!*		USE IN depostock_sql			 

*!*		USE IN &vprecioartia
*!*		USE IN &vprecioartib 
*!*		USE IN &vprecioartic 
*!*		USE IN &vprecioartid 

*!*	*		SELECT &vprecioartia 
*!*	*		INDEX on idlistah TAG idlista 
*!*	*!*		
*!*	*!*		SELECT &vprecioartib 
*!*	*!*		SET RELATION TO idlista INTO &vprecioartia
*!*	*!*		SET RELATION TO 
*!*		
*!*		RETURN vprecioarti	
*!*		
*!*	ENDFUNC 



FUNCTION EliminaAsientoC
PARAMETERS pe_idasiento
*#/----------------------------------------
** Elimina El Asiento Contable pasado como parametro
** Retorna 0 si lo pudo eliminar, sino retorna el numero del asiento
*#/----------------------------------------


	IF pe_idasiento = 0 THEN 
		RETURN 
	ENDIF 
*!*		IF MESSAGEBOX("Confirma la Eliminación del Asiento"+CHR(13)+" Número: "+ alltrim(thisform.tb_numero.value)+CHR(13)+" Fecha: "+DTOC(thisform.tb_fecha.value)+CHR(13)+" Detalle: "+ALLTRIM(thisform.tb_observa1.value),4+32+256,"Eliminación de Asientos Contables") = 7 THEN 
*!*			RETURN 
*!*		ENDIF 
	vconeccionp=abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)="select ejercicio FROM asientos WHERE idasiento = " + ALLTRIM(STR(pe_idasiento))
	verror=sqlrun(vconeccionp,"asiento0")

	IF asiento0.ejercicio <> _sysejercicio THEN 
		MESSAGEBOX("No se puede eliminar el Asiento, No pertenece al Ejercicio Activo ",0+16,"Eliminación de Asientos")
		=abreycierracon(vconeccionp,"")
		USE IN asiento0
		RETURN pe_idasiento 
	ENDIF 
	USE IN asiento0
	
	* Elimino Asiento * 
	sqlmatriz(1)="DELETE FROM asientos WHERE idasiento = " + ALLTRIM(STR(pe_idasiento))
	verror=sqlrun(vconeccionp,"asiento1")

	* Elimino Asociacion con Comprobantes 
	sqlmatriz(1)="DELETE FROM asientoscompro WHERE idasiento = " + ALLTRIM(STR(pe_idasiento))
	verror=sqlrun(vconeccionp,"asiento1")

	* Elimino Asociacion con Asientos Agrupados si la Hubiere 
	sqlmatriz(1)="DELETE FROM asientosg WHERE idasiento = " + ALLTRIM(STR(pe_idasiento))
	verror=sqlrun(vconeccionp,"asiento1")

	=abreycierracon(vconeccionp,"")
	
	pe_idasiento = 0	
	
	RETURN pe_idasiento 

ENDFUNC 



FUNCTION FiltroObserva
PARAMETERS pf_tabla, pf_idregi, pf_vconeccion
*#/----------------------------------------
*/ Determina el Filtro de Observación a aplicar en funcion
*/ del filtrado que aplica al comprobante recibido como parametros
*#/----------------------------------------
	
	pf_campoid = getIdTabla(pf_tabla) && Obtengo el nombre del campo indice de la tabla
	
	pf_cierraconex = .f.
	IF pf_vconeccion = 0 THEN 
		pf_vconeccion=abreycierracon(0,_SYSSCHEMA)	
		pf_cierraconex = .t.
	ENDIF 

	ret_Observa = ''
	var_pf_idregi = IIF((UPPER(type("pf_idregi"))='I' or UPPER(type("pf_idregi"))='N'),ALLTRIM(STR(pf_idregi)),"'"+ALLTRIM(pf_idregi)+"'")	
	
	sqlmatriz(1)=" Select * from "+ALLTRIM(pf_tabla)+" where "+pf_campoid+" = "+var_pf_idregi
	verror=sqlrun(pf_vconeccion,"registrof_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Registro en la Tabla: "+var_pf_idregi+";"+pf_tabla+";"+pf_campoid,0+48+0,"Error")
	    RETURN ret_observa 
	ENDIF
	
	SELECT registrof_sql
	
	IF EOF() THEN 
		USE IN registrof_sql 
		RETURN ret_observa 
	ELSE	
		*///////////////////
		*/Aca calculo la coincidencia con los filtros definidos para la tabla pasada*//
		*/ y el registro encontrado */**************
		*///////////////////
		
		sqlmatriz(1)=" Select d.*, f.tabla as tablaf, f.observa " 
		sqlmatriz(2)="   from observacond d left join observacomp f on f.idobscomp = d.idobscomp "	
		sqlmatriz(3)="   where f.tabla = '"+ALLTRIM(pf_tabla)+"' order by f.idobscomp "
		verror=sqlrun(pf_vconeccion,"filtros_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Registro en la Tabla: "+var_pf_idregi+";"+pf_tabla+";"+pf_campoid,0+48+0,"Error")
		    RETURN ret_observa 
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
					eje = " var_valor = registrof_sql."+ALLTRIM(filtros.campo)
					&eje
					eje = " var_valord= "+IIF((UPPER(SUBSTR(filtros.tipo,1,1))='I' or UPPER(SUBSTR(filtros.tipo,1,1))='D' or UPPER(SUBSTR(filtros.tipo,1,1))='F'),'VAL(ALLTRIM(filtros.valord))','ALLTRIM(filtros.valord)')
					&eje 
					eje = " var_valorh= "+IIF((UPPER(SUBSTR(filtros.tipo,1,1))='I' or UPPER(SUBSTR(filtros.tipo,1,1))='D' or UPPER(SUBSTR(filtros.tipo,1,1))='F'),'VAL(ALLTRIM(filtros.valorh))','ALLTRIM(filtros.valorh)')
					&eje 

				DO CASE 
					CASE UPPER(filtros.compara)="TODOS"
						v_cumple = 1
					CASE UPPER(filtros.compara)="ENTRE"
						IF  var_valor >= var_valord AND var_valor <= var_valorh THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="IGUAL"
						IF var_valor = var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MAYOR"
						IF var_valor > var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MAYOR O IGUAL"
						IF var_valor >= var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MENOR"
						IF var_valor < var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="MENOR O IGUAL"
						IF var_valor <= var_valord THEN 
							v_cumple = 1 
						ENDIF 
					CASE UPPER(filtros.compara)="DISTINTO"
						IF var_valor <> var_valord THEN 
							v_cumple = 1 
						ENDIF 

				ENDCASE 
				
				SELECT filtros
				replace cumple WITH v_cumple
			
			ENDIF 
		
			SELECT filtros
			SKIP 

		ENDDO 
	ENDIF 
	

	SET ENGINEBEHAVIOR 70
	SELECT idobscomp, tabla, observa, SUM(1) as cantidadf, SUM(cumple) as cumplidos, pf_idregi as idreg, pf_campoid as campoid ;
			FROM  filtros INTO TABLE filtrosele ORDER BY idobscomp GROUP BY idobscomp
	SET ENGINEBEHAVIOR 90
	GO TOP 
	
	SELECT filtrosele
	LOCATE FOR cantidadf = cumplidos AND cumplidos > 0 
	IF FOUND() THEN 

		ret_observa = ALLTRIM(filtrosele.observa)
	ENDIF   
	SELECT filtros
	USE IN filtros
	SELECT filtrosele
	USE IN filtrosele

	IF pf_cierraconex THEN 

		=abreycierracon(pf_vconeccion,"")	
	ENDIF 
	
RETURN ret_observa 
ENDFUNC 




FUNCTION EliminarMoviTPago
PARAMETERS pan_idcomproba, pan_idregistro
*#/----------------------------------------
*
*#/----------------------------------------
	
	vconeccionEl = abreycierracon(0,_SYSSCHEMA)
	
	* Busco el comprobante a Eliminar los Movimientos de Tipos de Pagos de detalles de cobros del comprobante anulado 
	sqlmatriz(1)=" select * from detallecobros  "
	sqlmatriz(3)=" where idcomproba = "+ALLTRIM(STR(pan_idcomproba))+" and idregistro = "+ALLTRIM(STR(pan_idregistro))  
	verror=sqlrun(vconeccionEl ,"detallecobros_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Detalle de Cobros ",0+48+0,"Error")
		=abreycierracon(vconeccionEl ,"")	
	    RETURN .F.  
	ENDIF	 

	SELECT detallecobros_sql
	GO TOP
	DO WHILE !EOF() 
		
		* Elimino los Movimientos en MOVITPAGOS para el comprobante Anulado en detalle de Cobros
		sqlmatriz(1)=" delete from movitpago "
		sqlmatriz(3)=" where tablacp = 'detallecobros' and idregicp = "+ALLTRIM(STR(detallecobros_sql.iddetacobro))  
		verror=sqlrun(vconeccionEl ,"movi_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Movimientos de Tipos de Pago de detallecobros ",0+48+0,"Error")
			=abreycierracon(vconeccionEl ,"")	
		    RETURN .F.  
		ENDIF	 
		
		SELECT detallecobros_sql
		SKIP 
	ENDDO 
	


	* Busco el comprobante a Eliminar los Movimientos de Tipos de Pagos de detalles de cobros del comprobante anulado 
	sqlmatriz(1)=" select * from detallepagos  "
	sqlmatriz(3)=" where idcomproba = "+ALLTRIM(STR(pan_idcomproba))+" and idregistro = "+ALLTRIM(STR(pan_idregistro))  
	verror=sqlrun(vconeccionEl ,"detallepagos_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Detalle de Pagos ",0+48+0,"Error")
		=abreycierracon(vconeccionEl ,"")	
	    RETURN .F.  
	ENDIF	 

	SELECT detallepagos_sql
	GO TOP
	DO WHILE !EOF() 
		
		* Elimino los Movimientos en MOVITPAGOS para el comprobante Anulado en detalle de Cobros
		sqlmatriz(1)=" delete from movitpago "
		sqlmatriz(3)=" where tablacp = 'detallepagos' and idregicp = "+ALLTRIM(STR(detallepagos_sql.iddetapago))  
		verror=sqlrun(vconeccionEl ,"movi_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Movimientos de Tipos de Pago de detallepagos ",0+48+0,"Error")
			=abreycierracon(vconeccionEl ,"")	
		    RETURN .F.  
		ENDIF	 
		
		SELECT detallepagos_sql
		SKIP 
	ENDDO 	
	
	=abreycierracon(vconeccionEl ,"")	
	USE IN detallecobros_sql
	USE IN detallepagos_sql
	
RETURN 
	


FUNCTION obtenerObservaComp
PARAMETERS p_tabla,p_campo,p_idregistro,p_coneccion,p_registrar
*#/----------------------------------------
*/ Obtiene la observación correspondiente según los filtros para la tabla, campo e id
*/ Y registra opcionalmente en la tabla observareg
* Parametros:
* p_tabla; p_campo; p_idregistro: tabla, campo y registro de la cual se va a obtener la observación 
* p_coneccion: conección a utilizar
* p_registrar: Si es Verdadero: registra la observación obtenida en la tabla observareg; si es Falso, la obtiene de la tabla sin registrar
*#/----------------------------------------

	v_idregistrostr =IIF((UPPER(type("p_idregistro"))='I' or UPPER(type("p_idregistro"))='N'),ALLTRIM(STR(p_idregistro)),"'"+ALLTRIM(p_idregistro)+"'")	
	IF EMPTY(ALLTRIM(p_tabla)) = .T. OR EMPTY(ALLTRIM(p_campo)) = .T. OR EMPTY(ALLTRIM(v_idregistrostr))= .T. OR EMPTY(ALLTRIM(p_tabla)) = .T. 
	
		RETURN ""
	
	ELSE
	
	
		
	
		IF p_registrar = .T. && Registra en base de datos y retorna la observacion
		
			v_observaFijo = FiltroObserva(p_tabla, v_idregistrostr,p_coneccion)		
			
			IF !EMPTY(ALLTRIM(v_observaFijo)) THEN 
				DIMENSION lamatriz1(5,2)
						
				v_idobsreg = 0
				
				v_campo = p_campo
				v_tabla	= p_tabla
						
				
				lamatriz1(1,1)='idobsreg'
				lamatriz1(1,2)= ALLTRIM(STR(v_idobsreg))
				lamatriz1(2,1)='idregistro'
				lamatriz1(2,2)= ALLTRIM(v_idregistrostr)
				lamatriz1(3,1)='campo'
				lamatriz1(3,2)= "'"+ALLTRIM(v_campo)+"'"
				lamatriz1(4,1)='tabla'
				lamatriz1(4,2)= "'"+ALLTRIM(v_tabla)+"'"
				lamatriz1(5,1)='observa'
				lamatriz1(5,2)= "'"+ALLTRIM(v_observaFijo)+"'"


					
				i_tipoope     = 'I'
				i_condicion   = ''
				i_titulo      = " EL ALTA "
				i_tabla     = 'observareg'
				i_matriz    = 'lamatriz1'
				i_conexion  = p_coneccion
				IF SentenciaSQL(i_tabla,i_matriz,i_tipoope,i_condicion,i_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				    RETURN ""
				ENDIF	
				RELEASE lamatriz1	
			ENDIF 			
		ELSE
			sqlmatriz(1)=" select observa from observareg  "
			sqlmatriz(2)=" where idregistro = "+ALLTRIM(STR(p_idregistro))+" and campo = '"+ALLTRIM(p_campo)+"' and tabla = '"+ALLTRIM(p_tabla)+"'"
			verror=sqlrun(p_coneccion,"observareg_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del registro de observación ",0+48+0,"Error")
			    RETURN "" 
			ENDIF	
			SELECT observareg_sql
			GO TOP 
			
			IF NOT EOF()
				v_observaFijo = observareg_sql.observa
			ELSE
				v_observaFijo = ""
			ENDIF 
		
		ENDIF 	
		
		
	ENDIF 


	RETURN v_observaFijo 

	
ENDFUNC 



FUNCTION SavePasswd
	PARAMETERS psv_accion, psv_usuario, psv_passw, psv_esquema, psv_save, psv_llave
*#/----------------------------------------
*/ Guarda el Seteo de la Clave de Acceso para aquellos usuarios que quieren salvar el passwd de acceso
* Parametros:
*  psv_accion	: A=ACTUALIZA O R=RECUPERA  CARACTER
*  psv_usuario	: Nombre de Usuario 		CARACTER
*  psv_passw	: Password o Clave			CARACTER
*  psv_esquema	: Esquema al que se conecta CARACTER
*  psv_save		: .t.= Salva Acceso, .f.= No Salva el Acceso LOGICO
*  psv_llave	: LLave para encriptacion CARACTER
*#/----------------------------------------

	vsv_retorno = ""
	
	IF !FILE(_SYSSERVIDOR+'savepwd.dbf') THEN 
		EJE = " CREATE TABLE "+_SYSSERVIDOR+"savepwd.dbf ( usuario c(100), clave c(100), esquema c(100), ultimo c(1) ) "
		&EJE
		USE IN savepwd
	ENDIF 
	EJE = " USE "+_SYSSERVIDOR+"savepwd.dbf in 0 exclusive "
	&EJE
		
	
	IF psv_accion = "A" THEN  && Actualizar la tabla
		
		replace ultimo WITH "1" FOR ALLTRIM(savepwd.usuario)==encripta(ALLTRIM(psv_usuario),psv_llave,.f.) 	
		DELETE FROM savepwd WHERE ALLTRIM(savepwd.usuario)==encripta(ALLTRIM(psv_usuario),psv_llave,.f.) AND ALLTRIM(savepwd.esquema)==encripta(ALLTRIM(psv_esquema),psv_llave,.f.)
		PACK 
		IF psv_save = .t. THEN && Salva la la clave de usuario pasado como parametro
			vsv_usuario	= encripta(ALLTRIM(psv_usuario),psv_llave,.f.)
			vsv_passw	= encripta(ALLTRIM(psv_passw),psv_llave,.f.)
			vsv_esquema = encripta(ALLTRIM(psv_esquema),psv_llave,.f.)
			INSERT INTO savepwd VALUES ( vsv_usuario, vsv_passw, vsv_esquema, "0")	
		ENDIF 
	
	ELSE 	&& Recupera la Clave
		
		SELECT savepwd
		INDEX on ultimo TAG ultimo 
		GO TOP 
		
		IF !EMPTY(psv_esquema) THEN 		
			LOCATE FOR ALLTRIM(savepwd.usuario)==encripta(ALLTRIM(psv_usuario),psv_llave,.f.) AND ALLTRIM(savepwd.esquema)==encripta(ALLTRIM(psv_esquema),psv_llave,.f.)
			IF FOUND() THEN  && encontro usuario y esquema pasado "##-##.1."
				vsv_retorno = Desencripta(ALLTRIM(savepwd.clave),psv_llave)+"##-##.1."+Desencripta(ALLTRIM(savepwd.esquema),psv_llave)
			ELSE	&& no encontro ni usuario ni esquema pasado "##-##.2."
				vsv_retorno = "##-##.2."  
			ENDIF 
					
		ELSE
			LOCATE FOR ALLTRIM(savepwd.usuario)==encripta(ALLTRIM(psv_usuario),psv_llave,.f.) 
			IF FOUND() THEN && Encontro usuario pero recibio esquema vacio
				vsv_retorno = Desencripta(ALLTRIM(savepwd.clave),psv_llave)+"##-##.3."+Desencripta(ALLTRIM(savepwd.esquema),psv_llave)
			ENDIF 		
			
		ENDIF 
	
	ENDIF 	
	
	
	USE IN savepwd 
	
RETURN vsv_retorno




FUNCTION RandomSele
	PARAMETERS rnd_tabla, rnd_cantidad 
*#/----------------------------------------
*/ Retorna un conjunto de valores de registros de una tabla seleccionados al azar
*/ recibe como parametros la tabla y la cantidad de registros al azar a devolver
*/ devuelve un archivo tipo texto con los indices seleccionados con extension .rnd
* Parametros:
*  rnd_tabla	: Nombre de la Tabla a elegir    CARACTER
*  rnd_cantidad : Cantidad de registros a elegir INTEGER
*#/----------------------------------------

	rnd_retorno 	= rnd_tabla+".rnd"
	ret_campotipo 	= obtenerCampoIndice(rnd_tabla,.T.)
	rnd_campo 		= SUBSTR(ret_campotipo,1,ATC(";",ret_campotipo)-1)
	rnd_tipo  		= SUBSTR(ret_campotipo,ATC(";",ret_campotipo)+1)

	vconeccionr = abreycierracon(0,_SYSSCHEMA)
	
	sqlmatriz(1)=" select "+ALLTRIM(rnd_campo)+"  from "+ALLTRIM(rnd_tabla)
	sqlmatriz(2)=" where "+ALLTRIM(rnd_campo)+" in ( select valor from randomsele where tabla = '"+ALLTRIM(rnd_tabla)+"' )"
	verror=sqlrun(vconeccionr ,"registros_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Cantidad de Registros ",0+48+0,"Error")
		=abreycierracon(vconeccionr ,"")	
	    RETURN .F.  
	ENDIF	 
	SELECT *, .f. as sel FROM registros_sql INTO TABLE registrossel 
	USE IN registros_sql 
	SELECT registrossel
	rnd_cantidadregselec = RECCOUNT()
	
	* Obtengo los registros de la tabla que aun no han sido seleccionados 
	sqlmatriz(1)=" select "+ALLTRIM(rnd_campo)+" from "+ALLTRIM(rnd_tabla)
	sqlmatriz(2)=" where "+ALLTRIM(rnd_campo)+" not in ( select valor from randomsele where tabla = '"+ALLTRIM(rnd_tabla)+"' )"
	verror=sqlrun(vconeccionr ,"cantidadpend")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Cantidad de Registros ",0+48+0,"Error")
		=abreycierracon(vconeccionr ,"")	
	    RETURN .F.  
	ENDIF	 
	
	
	SELECT * , .f. as sel FROM cantidadpend INTO TABLE seleregistros 
	USE IN cantidadpend
	
	SELECT seleregistros 
	rnd_cantidadregpend = RECCOUNT()
	
	IF ( rnd_cantidadregselec + rnd_cantidadregpend ) <= (rnd_cantidad + rnd_cantidadregselec ) THEN 
		
		sqlmatriz(1)=" delete from randomsele "
		sqlmatriz(2)=" where tabla = '"+ALLTRIM(rnd_tabla)+"' "
		verror=sqlrun(vconeccionr ,"delrandom")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error la Eliminacion de Registros ",0+48+0,"Error")
			=abreycierracon(vconeccionr ,"")	
		    RETURN .F.  
		ENDIF	 
	
		
	ENDIF 
	

* comparo para ver si puede generar la cantidad de registros solicitados o tomo los restantes y genero nuevos
	IF rnd_cantidadregpend > rnd_cantidad THEN  && si la cantidad pendiente de registros por seleccionar es mayor que la cantidad pedida
		SELE seleregistros 
		FOR idx = 1 TO rnd_cantidad
			v_regsel = INT(RAND()*rnd_cantidadregpend)
			
			IF v_regsel = 0 THEN 
				v_regsel = 1
			ENDIF 
			SELE seleregistros 
			GO v_regsel
			
			IF !sel THEN 
				replace sel WITH .t. 
			ELSE
				DO WHILE sel AND !EOF()
					SKIP
					IF EOF() THEN 
						GO TOP 
					ENDIF  
				ENDDO 
				REPLACE sel WITH .t. 
			ENDIF 
		ENDFOR 
	ENDIF 
	IF rnd_cantidadregpend = rnd_cantidad THEN  && si la cantidad pendiente de registros por seleccionar es igual que la cantidad pedida
		SELE seleregistros 
		replace ALL sel WITH .t. 
	ENDIF 
	IF rnd_cantidadregpend < rnd_cantidad THEN  && si la cantidad pendiente de registros por seleccionar es menor que la cantidad pedida
		SELE seleregistros 
		replace ALL sel WITH .t. 
		SELE registrossel
		FOR idx = 1 TO (rnd_cantidad - rnd_cantidadregpend )
			v_regsel = INT(RAND()*rnd_cantidadregselec)
			
			IF v_regsel = 0 THEN 
				v_regsel = 1
			ENDIF 
			SELE registrossel
			GO v_regsel
			IF !sel THEN 
				replace sel WITH .t. 
			ELSE
				DO WHILE sel AND !EOF()
					SKIP
					IF EOF() THEN 
						GO TOP 
					ENDIF  
				ENDDO 
			ENDIF 
		ENDFOR 
		SELECT * FROM registrossel WHERE sel = .t. INTO TABLE registroselA
		SELECT seleregistros 
		APPEND FROM registroselA
		USE IN registroselA
	ENDIF 
	
	SELECT seleregistros
	eje = "select "+ALLTRIM(rnd_campo)+" as valor from seleregistros into cursor seleccionfinal where sel = .t."
	&eje
	SELECT seleccionfinal
	COPY TO &rnd_retorno TYPE CSV 
	GO TOP 
	DO WHILE !EOF()

		v_valor = IIF(rnd_tipo ='C',"'"+ALLTRIM(seleccionfinal.valor)+"'",ALLTRIM(STR(seleccionfinal.valor)))
		
		sqlmatriz(1)=" insert into randomsele ( idrandom, tabla, valor ) "
		sqlmatriz(2)=" values ( 0, '"+ALLTRIM(rnd_tabla)+"',"+v_valor+" )"
		
		verror=sqlrun(vconeccionr ,"insrandom")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en el Agregado de Registro a la tabla Randomsele ",0+48+0,"Error")
			=abreycierracon(vconeccionr ,"")	
		    RETURN .F.  
		ENDIF	 
		
		SELECT seleccionfinal 
		SKIP 
	ENDDO 

	=abreycierracon(vconeccionr,"")

	USE IN seleccionfinal
	USE IN seleregistros
	USE IN registrossel
	RETURN rnd_retorno
ENDFUNC 






FUNCTION ArtiCostoHisto
PARAMETERS p_fechahisto,p_tablahisto, p_coneccion
*#/----------------------------------------
*/ Obtiene el costo historico por articulos dada una Fecha
*/ Devuelve el costo historico a la fecha pasada para todos los articulos
* Parametros:
* p_fecha: Fecha para el Calculo del Costo Histórico, si fecha es vacia devuelve el ultimo costo ingresado
* p_coneccion: conección a utilizar
* p_tablaret: Nombre de la tabla en la que devolverá el costo historico para todos los artículos
*#/----------------------------------------

	IF (UPPER(type("p_coneccion"))='I' or UPPER(type("p_coneccion"))='N')  THEN 
		IF p_coneccion = 0 THEN 
			pv_coneccion = abreycierracon(0,_SYSSCHEMA)
		ELSE 
			pv_coneccion = p_coneccion
		ENDIF 
	ELSE 
		pv_coneccion = abreycierracon(0,_SYSSCHEMA)
	ENDIF 
	
*!*		sqlmatriz(1)=" select * from articostos where concat( articulo,'-',fecha )  in ( select concat(articulo,'-',max(fecha)) as fecha "
*!*		sqlmatriz(2)=" from articostos where mid(fecha,1,8) <= '"+ALLTRIM(p_fechahisto)+"'  group by articulo ) order by articulo"
*!*		verror=sqlrun(pv_coneccion,"costoart_sql")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Costos de Artículos a Fecha ",0+48+0,"Error")
*!*		    RETURN "" 
*!*		ENDIF	

	sqlmatriz(1)="create temporary table tmarti select concat( articulo,'-',MAX(fecha) ) as artifecha from articostos "
	sqlmatriz(2)="where mid(fecha,1,8) <= '"+ALLTRIM(p_fechahisto)+"' group by articulo"
	verror=sqlrun(vconeccionF,"tmanulados_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Estados de anulados ...",0+48+0,"Error")
	ENDIF 
	sqlmatriz(1)="ALTER TABLE tmarti ADD INDEX artifecha (artifecha)"
	verror=sqlrun(vconeccionF,"indice_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Estados de anulados ...",0+48+0,"Error")
	ENDIF 
	
	
*!*		sqlmatriz(1)=" select * from articostos where idartcosto  in ( select MAX(idartcosto) as idartcosto "
*!*		sqlmatriz(2)=" from articostos where mid(fecha,1,8) <= '"+ALLTRIM(p_fechahisto)+"'  group by articulo ) order by articulo"

	sqlmatriz(1)=" select * from articostos a "
	sqlmatriz(2)=" left join tmarti t on t.artifecha = concat(a.articulo,'-',a.fecha) "
	sqlmatriz(3)=" where ifnull(t.artifecha,'')<>'' "
	verror=sqlrun(pv_coneccion,"costoart_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Costos de Artículos a Fecha ",0+48+0,"Error")
	    RETURN "" 
	ENDIF	

	SELECT * FROM costoart_sql INTO TABLE &p_tablahisto
	SELECT &p_tablahisto	
	USE 

	IF (UPPER(type("p_coneccion"))='I' or UPPER(type("p_coneccion"))='N')  THEN 
		IF p_coneccion = 0 THEN 
			= abreycierracon(pv_coneccion,"")
		ENDIF 
	ELSE 
		= abreycierracon(pv_coneccion,"")
	ENDIF 
	

	RETURN p_tablahisto 	
ENDFUNC 




FUNCTION FCAdeudadas
PARAMETERS pv_entidad, pv_servicio, pv_cuenta, pv_fechaven, pv_idfactura, pv_insert, pv_tmp, p_coneccion
*#/----------------------------------------
*/ Obtiene las facturas adeudadas para una entidad 
*/ Asocia la deuda de una cuenta a una factura del cliente  
*/ Devuelve una tabla con los idfactura y el importe de deuda
* Parametros:
* Entidad: Numero de la Entidad
* Servicio: codigo de Servicio si corresponde a una cuenta de un servicio particular
* Cuenta: codigo de cuenta del servicio
* FechaVen: Fecha de Vencimiento para el calculo de la deuda ( o fecha de facturas )
* PV_IS: operacion de la funcion INSERTA DEUDA O SOLO SELECCIONA DEUDA, 
* pv_tmp: parametro para tablas temporarias , si no está vacio utiliza tmp tabla temporaria
* pv_conexion: puntero de la conexion a la base de datos
* En cualquiera de los casos devuelve la deuda en un archivo de texto .csv
* Formato de archivo devuelto .csv : idfactura I, idfcdeuda I, importe Double(13,2)
*#/----------------------------------------

	IF (UPPER(type("p_coneccion"))='I' or UPPER(type("p_coneccion"))='N')  THEN 
		IF p_coneccion = 0 THEN 
			pv_coneccion = abreycierracon(0,_SYSSCHEMA)
		ELSE 
			pv_coneccion = p_coneccion
		ENDIF 
	ELSE 
		pv_coneccion = abreycierracon(0,_SYSSCHEMA)
	ENDIF 
	pv_tmp = IIF(EMPTY(pv_tmp),"","tmp")


	*Si recibo un idfactura reemplazo las entidades recibidas por la de la factura 
	IF pv_idfactura > 0 THEN 
		* Obtengo el registro de la factura a la cual asociar la deuda

		sqlmatriz(1)=" select entidad, servicio, cuenta, fecha from facturas"+ALLTRIM(pv_tmp)+" where idfactura = "+ALLTRIM(STR(pv_idfactura))
		verror=sqlrun(pv_coneccion,"facturad_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la factura ",0+48+0,"Error")
		    RETURN "" 
		ENDIF		
		SELECT facturad_sql
		GO TOP 
		IF !EOF() THEN 
			pv_entidad  = facturad_sql.entidad
			pv_servicio = facturad_sql.servicio
			pv_cuenta 	= facturad_sql.cuenta
		ENDIF 
		USE 
	ENDIF 
	
	v_deudareto = "deuda_fcadeuda.csv"

	* traigo solo una vez la vista de deudas de todas las facturas*
	IF USED('alldeudas') THEN 
	
	ELSE 
		IF file("alldeudas.dbf") THEN 
			USE alldeudas IN 0  EXCLUSIVE 
		ELSE
			* Obtengo la deuda todos los comprobantes 
			sqlmatriz(1)=" select s.idfactura, s.saldof, f.fecha, f.fechavenc1, f.fechavenc2, f.fechavenc3, f.entidad, f.servicio, f.cuenta, "
			sqlmatriz(2)=" f.tipo, p.puntov, f.numero, f.total "
			sqlmatriz(3)=" from r_facturasaldo s left join facturas f on f.idfactura = s.idfactura "
			sqlmatriz(4)=" left join puntosventa p on p.pventa = f.pventa "
			sqlmatriz(5)=" where s.saldof > 0 and f.servicio = "+ALLTRIM(STR(pv_servicio))	
			
			verror=sqlrun(pv_coneccion,"alldeudas_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Todas las deudas del servicio pasado ",0+48+0,"Error")
			    RETURN "" 
			ENDIF	
			SELECT *, ALLTRIM(tipo)+' '+ALLTRIM(puntov)+' '+STRTRAN(STR(numero,8),' ','0')+'  '+ ;
			ALLTRIM(SUBSTR(fecha,7,2))+'/'+ALLTRIM(SUBSTR(fecha,5,2))+'/'+ALLTRIM(SUBSTR(fecha,1,4))+ ;
			'  $ '+ALLTRIM(STR(total,13,2)) as detalle  FROM alldeudas_sql INTO TABLE alldeudas
			USE IN alldeudas_sql 
		ENDIF 
	ENDIF 
	SELECT alldeudas 
	INDEX on STR(entidad)+STR(cuenta) TAG cuenta 
	**************************************************************
	
	
*!*		* Obtengo la deuda de los comprobantes asociados a la cuenta
*!*		sqlmatriz(1)=" select s.idfactura, s.saldof, f.fecha, f.fechavenc1, f.fechavenc2, f.fechavenc3  from facturasaldo s left join facturas f on f.idfactura = s.idfactura "
*!*		sqlmatriz(2)=" where s.saldof > 0 and s.idfactura > 0 and f.entidad="+ALLTRIM(STR(pv_entidad))
*!*		sqlmatriz(3)=" and f.servicio = "+ALLTRIM(STR(pv_servicio))+" and f.cuenta="+ALLTRIM(STR(pv_cuenta))
*!*		
*!*		verror=sqlrun(pv_coneccion,"deudas_sql")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Costos de Artículos a Fecha ",0+48+0,"Error")
*!*		    RETURN "" 
*!*		ENDIF	
	
	
	*si calcula para tablas temporarias no debe tener en cuenta el idfactura
	v_condicionid = IIF(EMPTY(pv_tmp)," and idfactura <> "+ALLTRIM(STR(pv_idfactura)),"")
	
	SELECT * FROM alldeudas INTO CURSOR fcdeuda WHERE STR(entidad)+STR(cuenta) == STR(pv_entidad)+STR(pv_cuenta) ;
	&v_condicionid  AND (( EMPTY(fechavenc1) AND fecha <= pv_fechaven) OR ( !EMPTY(fechavenc1) AND (fechavenc1 <= pv_fechaven) ))  && modificado 
	
	
	
	SELECT fcdeuda
*	COPY TO &v_deudareto TYPE CSV 	
	
	** fin calculo de deuda **
	
	** inserta si se llamo a la funcion para incertar  asociada a factura **
	IF pv_idfactura > 0 AND UPPER(pv_insert) ='I'
		
			* Elimino si hubiere alguna deuda ya asociada
		sqlmatriz(1)=" delete from facturasd"+ALLTRIM(pv_tmp)+"  where idfactura = "+ALLTRIM(STR(pv_idfactura))	
		verror=sqlrun(pv_coneccion,"delete_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Facturas Asociadas ",0+48+0,"Error")
		    RETURN "" 
		ENDIF	
		
		DIMENSION lamatrizd(5,2)
		SELECT fcdeuda
		GO TOP 
		DO WHILE !EOF()

			lamatrizd(1,1)='idfacturad'
			lamatrizd(1,2)= "0"
			lamatrizd(2,1)='idfactura'
			lamatrizd(2,2)= ALLTRIM(STR(pv_idfactura))
			lamatrizd(3,1)='idfcdeuda'
			lamatrizd(3,2)= ALLTRIM(STR(fcdeuda.idfactura))
			lamatrizd(4,1)='importe'
			lamatrizd(4,2)=ALLTRIM(STR(fcdeuda.saldof,13,2))
			lamatrizd(5,1)='detalle'
			lamatrizd(5,2)="'"+ALLTRIM(fcdeuda.detalle)+"'"

			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla     = 'facturasd'+pv_tmp
			p_matriz    = 'lamatrizd'
			p_conexion  = pv_coneccion
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en grabacion de deuda asociada a facturas",0+48+0,"Error")
			    =abreycierracon(vconeccionA,"")
				    RETURN .F.
			ENDIF  

			
			SELECT fcdeuda 
			SKIP 
		ENDDO 
		RELEASE lamatrizd 
		
	ENDIF 
	
	**** fin insercion de deudas
		
	SELECT fcdeuda
	USE 

	IF (UPPER(type("p_coneccion"))='I' or UPPER(type("p_coneccion"))='N')  THEN 
		IF p_coneccion = 0 THEN 
			= abreycierracon(pv_coneccion,"")
		ENDIF 
	ELSE 
		= abreycierracon(pv_coneccion,"")
	ENDIF 
	
	IF EMPTY(pv_tmp) THEN 
		USE IN alldeuda
	ENDIF 

	RETURN v_deudareto 
ENDFUNC 





FUNCTION facturasCtasAdeudadas
PARAMETERS p_fechaIni, p_fechaFin, p_nomTablaTmp, p_coneccion
*#/----------------------------------------
*/ Obtiene las facturas y cuotas adeudadas filtradas por fecha de comprobante
*/ Devuelve una tabla con los datos de la facturas, cuotas
* Parametros:
* p_FechaIni: Fecha de Inicio del periodo de busqueda
* p_FechaFin: Fecha de Fin del periodo de busqueda
* p_nomTablaTmp: Nombre de la tabla temporaria donde se van a guardar los datos consultados
* pv_conexion: puntero de la conexion a la base de datos
* Retorno: Devuelve True si la función termino correctamente, False en otro caso. Además devuelve la consulta en una tabla con el nombre pasada como parámetro.
* Aclaración: Si el comprobante no tiene cuotas, la columna idcuotafc tendra valor = 0
*#/----------------------------------------

	
	IF TYPE('p_fechaIni') = 'C' AND TYPE('p_fechaFin') = 'C' AND TYPE('p_nomTablaTmp') = 'C'
		IF (UPPER(type("p_coneccion"))='I' or UPPER(type("p_coneccion"))='N')  THEN 
			IF p_coneccion = 0 THEN 
				pv_coneccion = abreycierracon(0,_SYSSCHEMA)
			ELSE 
				pv_coneccion = p_coneccion
			ENDIF 
		ELSE 
			pv_coneccion = abreycierracon(0,_SYSSCHEMA)
		ENDIF 
		
	ELSE
		RETURN .F.

	ENDIF 


	sqlmatriz(1)= " SELECT f.*,fs.cobrado as cobradotot,fs.saldof as saldoftot,ifnull(fc.idcuotafc,0) as idcuotafc,ifnull(fc.cuota,0) as cuota,fc.importe as importecta, "
	sqlmatriz(2)= " fc.cobrado as cobradocta,fc.saldof as saldofcta,ft.fechavenc as fecvencta,c.comprobante as nomcomp, pv.puntov " 
	sqlmatriz(3)= " FROM r_facturasaldo fs left join r_facturasctasaldo  fc on fs.idfactura = fc.idfactura left join facturas f on fs.idfactura = f.idfactura  "
	sqlmatriz(4)= " left join puntosventa pv on f.pventa = pv.pventa left join facturascta ft on fc.idcuotafc = ft.idcuotafc left join comprobantes c on f.idcomproba = c.idcomproba " 
	sqlmatriz(5)=" where f.fecha >= '"+ALLTRIM(p_fechaIni) + "' and f.fecha <='" +ALLTRIM(p_fechaFin)+"' and ((fs.saldof > 0 and fc.saldof >0) or (fs.saldof > 0 and fc.idcuotafc is null)) "
	
	verror=sqlrun(pv_coneccion,"factctaade_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Todas las deudas del servicio pasado ",0+48+0,"Error")
	    RETURN "" 
	ENDIF	


	SELECT * FROM factctaade_sql INTO TABLE &p_nomTablaTmp
	
	SELECT &p_nomTablaTmp 
	
	ALTER table &p_nomTablaTmp alter COLUMN idcuotafc I
	ALTER table &p_nomTablaTmp alter COLUMN cuota I
	
	
	RETURN .T.


ENDFUNC 


FUNCTION agregarParamaetro
PARAMETERS p_funcion,p_parametro
*#/----------------------------------------
*/ Agrega un parametro a la funcion
*/ Devuelve la funcion pasada con el nuevo paràmetro
* Parametros:
* p_funcion: Funciòn a la que se le va a agregar un paràmetro
* p_parametro: Paràmetro a agregar
*#/----------------------------------------

	IF TYPE('p_funcion') = 'C' AND TYPE('p_parametro') = 'C'
		v_funcion = p_funcion
		
		v_posP1 = AT('(',p_funcion)
		v_posP2 = AT(')',p_funcion)
		v_posC = AT(',',p_funcion)
		v_long = v_posP2 - (v_posP1+1)
		v_listaPar = ALLTRIM(SUBSTR(p_funcion,(v_posP1+1),v_long))
	

		
		IF EMPTY(v_listaPar) && NO Tiene parametros
			
			v_funcion = STRTRAN(v_funcion,')',ALLTRIM(ALLTRIM(p_parametro)+')'))
		
		ELSE
			v_funcion = STRTRAN(v_funcion,')',ALLTRIM(','+ALLTRIM(p_parametro)+')'))
		ENDIF 
	
		RETURN v_funcion			
	ENDIF 
	
	
	RETURN p_funcion

ENDFUNC 




******************************************************
******************************************************
******************************************************

FUNCTION VinculoComp
PARAMETERS pv_tipovin, pv_idcomprobav, pv_idregistrov, pv_idfactuv, pv_importe 
*#/----------------------------------------
** Funcion Genera Comprobante de Vinculos entre Facturas y Recibos o Pagos
** Registra Vinculos y Libreraciones de Comprobantes
** Parametros: 	pv_tipovin		= V/D Vincula o Desvincula Comprobantes
** 				pv_idcomprobav	= ID del comprobante que cancela la Factura
**				pv_idregistrov	= ID registro del comprobante que cancela la factura 
**				pv_idfactuv		= ID de la factura de cliente o de la factura de proveedores cancelada
**				pv_importe		= importe de la operación aplicada o desvinculada
**
*#/----------------------------------------
	

	v_tablav 		= ""
	v_tipovin		= pv_tipovin
	v_idcomprobav 	= pv_idcomprobav
	v_idregistrov 	= pv_idregistrov
	v_idfactuv		= pv_idfactuv
	v_importe 		= pv_importe
	v_entidad 		= 0
	v_servicio 		= 0
	v_cuenta 		= 0
	v_nombre		= ""
	v_apellido 		= ""
	v_fecha			= DTOS(DATE())
	v_idvinculo  	= 0
	v_vinculocomp_idcomproba = 0
	v_vinculocomp_pventa 	 = 0
	v_vinculocomp_numero 	 = 0
	v_comproa		= ""
	v_comprob		= ""
	
	vconeccionVi = abreycierracon(0,_SYSSCHEMA)

	* Busco el comprobante definido para hacer los vinculos entre clientes/cobros proveedores/cobros 
	sqlmatriz(1)=" select c.*, t.opera, p.pventa from comprobantes c left join tipocompro t on c.idtipocompro = t.idtipocompro "
	sqlmatriz(2)=" left join compactiv p on p.idcomproba = c.idcomproba "
	sqlmatriz(3)=" where c.tabla = 'vinculocomp' " 
	verror=sqlrun(vconeccionVi ,"idcompro_vinc")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la Tabla de comprobantes al obtener el idcomproba de vinculos ",0+48+0,"Error")
		=abreycierracon(vconeccionVi ,"")	
	    RETURN .F.  
	ENDIF	 
		
	SELECT idcompro_vinc
	GO TOP 
	IF EOF() THEN 
		USE IN idcompro_vinc
		MESSAGEBOX("No hay comprobante de Vinculos Definido")
		RETURN .f. 
	ENDIF 
				
	v_idvinculo  = 0
	v_vinculocomp_idcomproba = idcompro_vinc.idcomproba
	v_vinculocomp_pventa 	 = idcompro_vinc.pventa				
	USE IN idcompro_vinc
	
	
	* Busco la tabla del comprobante vinculado para saber si es un cobro (recibo / Nc) o un pago( Orden de Pago, NC)  
	sqlmatriz(1)=" select * from comprobantes "
	sqlmatriz(3)=" where idcomproba = "+ALLTRIM(STR(pv_idcomprobav))
	verror=sqlrun(vconeccionVi ,"tablav_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la Tabla del Comprobante Vinculado ",0+48+0,"Error")
		=abreycierracon(vconeccionVi ,"")	
	    RETURN .F.  
	ENDIF	 

	SELECT tablav_sql
	GO TOP
	IF !EOF() THEN 

		v_tablav = ALLTRIM(tablav_sql.tabla)

		IF ALLTRIM(v_tablav) == "recibos" OR ALLTRIM(v_tablav) == "facturas" THEN && Los comprobantes a vincular/desvincular son de Clientes

			sqlmatriz(1)=" select * from facturas "
			sqlmatriz(3)=" where idfactura = "+ALLTRIM(STR(v_idfactuv))
			verror=sqlrun(vconeccionVi ,"facturav_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Factura a Vincular ",0+48+0,"Error")
				=abreycierracon(vconeccionVi ,"")	
			   v_tablav = "" 
			ENDIF	 
		
			SELECT facturav_sql
			GO TOP 
			IF !EOF() THEN 
				v_entidad  	= facturav_sql.entidad
				v_servicio 	= facturav_sql.servicio
				v_cuenta 	= facturav_sql.cuenta
				V_apellido	= facturav_sql.apellido
				v_nombre 	= facturav_sql.nombre
			ENDIF 
			USE IN facturav_sql	
			
			v_comproa = fdescribecompro('facturas', 'idfactura',v_idfactuv)
			
			IF v_tablav == 'recibos' THEN 
				v_nomindice = 'idrecibo'
			ELSE
				v_nomindice = 'idfactura'
			ENDIF 
			v_comprob = fdescribecompro(v_tablav, v_nomindice ,v_idregistrov)
	
		
		ELSE  
			IF ALLTRIM(v_tablav) == "pagosprov" OR ALLTRIM(v_tablav) == "factuprove" && los comprobantes a vincular / desvincular son de Proveedores
		
				sqlmatriz(1)=" select * from factuprove "
				sqlmatriz(3)=" where idfactprove = "+ALLTRIM(STR(v_idfactuv))
				verror=sqlrun(vconeccionVi ,"facturav_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Factura a Vincular ",0+48+0,"Error")
					=abreycierracon(vconeccionVi ,"")	
					v_tablav = ""
				ENDIF	 
				
				SELECT facturav_sql
				GO TOP 
				IF !EOF() THEN 
					v_entidad   = facturav_sql.entidad
					V_apellido	= facturav_sql.apellido
					v_nombre 	= facturav_sql.nombre
				ENDIF 
				USE IN facturav_sql	

				v_comproa = fdescribecompro('factuprove', 'idfactprove',v_idfactuv)
			
				IF v_tablav == 'pagosprov' THEN 
					v_nomindice = 'idpago'
				ELSE
					v_nomindice = 'idfactprove'
				ENDIF 
				v_comprob = fdescribecompro(v_tablav, v_nomindice ,v_idregistrov)
		
			
			ELSE && los comprobantes pasados no se corresponden con los autorizados para generar el comprobante de vinculo
				v_tablav = ""
			ENDIF 
		ENDIF 
		

		IF EMPTY(v_tablav) THEN 
			=abreycierracon(vconeccionVi ,"")	
			USE IN tablav_sql
			RETURN .f.
		ENDIF 
		USE IN tablav_sql 
		v_vinculocomp_numero 	 = maxnumerocom(v_vinculocomp_idcomproba ,v_vinculocomp_pventa ,1)
		v_comproa= ALLTRIM(SUBSTR((v_comproa+SPACE(200)),1,200))
		v_comprob= ALLTRIM(SUBSTR((v_comprob+SPACE(200)),1,200))
	
		DIMENSION lamatrizV(18,2)
				
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'vinculocomp'
		p_matriz    = 'lamatrizV'
		p_conexion  = vconeccionVi 

		lamatrizV(1,1)='idvinculo'
		lamatrizV(1,2)=ALLTRIM(STR(v_idvinculo))
		lamatrizV(2,1)='idcomproba'
		lamatrizV(2,2)= ALLTRIM(STR(v_vinculocomp_idcomproba))
		lamatrizV(3,1)='pventa'
		lamatrizV(3,2)=ALLTRIM(STR(v_vinculocomp_pventa))
		lamatrizV(4,1)='numero'
		lamatrizV(4,2)=ALLTRIM(STR(v_vinculocomp_numero))
		lamatrizV(5,1)='fecha'
		lamatrizV(5,2)="'"+ALLTRIM(v_fecha)+"'"
		lamatrizV(6,1)='entidad'
		lamatrizV(6,2)=ALLTRIM(STR(v_entidad))
		lamatrizV(7,1)='servicio'
		lamatrizV(7,2)=ALLTRIM(STR(v_servicio))
		lamatrizV(8,1)='cuenta'
		lamatrizV(8,2)=ALLTRIM(STR(v_cuenta))
		lamatrizV(9,1)='apellido'
		lamatrizV(9,2)="'"+v_apellido+"'"
		lamatrizV(10,1)='nombre'
		lamatrizV(10,2)="'"+v_nombre+"'"
		lamatrizV(11,1)='importe'
		lamatrizV(11,2)=ALLTRIM(STR(v_importe,13,2))
		lamatrizV(12,1)='tipovin'
		lamatrizV(12,2)="'"+v_tipovin+"'"
		lamatrizV(13,1)='tablav'
		lamatrizV(13,2)="'"+v_tablav+"'"
		lamatrizV(14,1)='idcomprobav'
		lamatrizV(14,2)=ALLTRIM(STR(v_idcomprobav))
		lamatrizV(15,1)='idregistrov'
		lamatrizV(15,2)=ALLTRIM(STR(v_idregistrov))
		lamatrizV(16,1)='idfactuv'
		lamatrizV(16,2)=ALLTRIM(STR(v_idfactuv))
		lamatrizV(17,1)='comproa'
		lamatrizV(17,2)="'"+v_comproa+"'"
		lamatrizV(18,1)='comprob'
		lamatrizV(18,2)="'"+v_comprob+"'"

		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_vinculocomp_numero)),0+48+0,"Error")
		    RETURN 
		ENDIF 
			
		RELEASE lamatrizV
				
				*** Ultimo ID registrado ***
				
				
		sqlmatriz(1)="SELECT last_insert_id() as maxid "
		verror=sqlrun(vconeccionVi,"vinculomax_sql")
		IF verror=.f.  
	 	   MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID de Anulación",0+48+0,"Error")
		ENDIF 

		SELECT vinculomax_sql
		GO TOP 
				
		v_idvinculo = VAL(vinculomax_sql.maxid)
	
		USE in vinculomax_sql
				
				
			*** REGISTRO ESTADO AUTORIZADO ***
		registrarEstado("vinculocomp","idvinculo",v_idvinculo ,'I',"AUTORIZADO")
						
				*Registracion Contable del Caja Ingreso/Egreso	

*!*					nuevo_asiento = Contrasiento( 0,_SYSCONTRADH, v_tablaPor, pan_idregistro, 'anularp', v_idanulaRP)
	  	
		*Registracion Contable del Vinculo de Comprobantes	
		v_cargo = ContabilizaCompro('vinculocomp', v_idvinculo , vconeccionVi, v_importe)
			
		IF TYPE("_SYSIMPVINC")='C' THEN 		
			IF ALLTRIM(_SYSIMPVINC) = 'T' THEN 	
				imprimirVinculoComp(v_idvinculo)
			ELSE 	
				IF ALLTRIM(_SYSIMPVINC) = 'S' THEN 	
					sino = MESSAGEBOX("¿Desea imprimir el Comprobante de Vínculación-Desvinculación?",4+32,"Imprimir")
					IF sino = 6
						*SI
						imprimirVinculoComp(v_idvinculo)
					ENDIF 
			  	ENDIF 
			ENDIF 
		ELSE 
			sino = MESSAGEBOX("¿Desea imprimir el Comprobante de Vínculación-Desvinculación?",4+32,"Imprimir")
			IF sino = 6
				imprimirVinculoComp(v_idvinculo)
			ENDIF 
	  	ENDIF 
	  	
		=abreycierracon(vconeccionVi ,"")	
		RETURN .t. 
	ELSE 
		=abreycierracon(vconeccionVi ,"")	
		RETURN .f. 
	ENDIF 

ENDFUNC 





FUNCTION TarjetaCtaBaja
PARAMETERS pct_idcheque
*#/----------------------------------------
** Pasa Cuotas de Tarjetas propias de la Cuenta Tarjeta correspondiente
** a la Cuenta Proveedores, Genera CI TARJETA (Sin Registro de Asiento)
** Genera Factura de Proveedor en Entidad Asociada a Cuenta de Caja Banco para Tarjeta
** Genera Asiento Contable dando de Baja la Cuenta en Tarjeta y pasando el Saldo a Proveedores
*#/----------------------------------------

	IF  MESSAGEBOX("CONFIRMA LA LIQUIDACIÓN DE LA CUOTA SELECCIONADA  ",4+32,"Liquidacion de Cuotas de Tarjetas")= 7 THEN 
		RETURN 		
	ENDIF 

	IF  TYPE("_SYSCIFPTAR")="U" OR  EMPTY(_SYSCIFPTAR) OR ALLTRIM(_SYSCIFPTAR)="0" THEN 
	   	MESSAGEBOX("No ha Configurado el Comprobante asociado a esta Operación ( Variable _SYSCIFPTAR ) ",0+48+0,"Error")
		RETURN 		
	ENDIF 
	
	vconeccionTa = abreycierracon(0,_SYSSCHEMA)
	
	** Busco la Cuota a Cancelar de la tabla Cheques 

	sqlmatriz(1)=" select c.*, dc.iddetapago, dc.idcuenta as idcuentatj, ifnull(be.entidad,0) as entidad, ifnull(be.codigoctac,' ') as codigoctac, ifnull(be.codigoctap,0) as codigoctap, "
	sqlmatriz(2)=" ifnull(en.nombre,' ') as nomenti, ifnull(en.apellido,' ') as apeenti, ifnull(en.compania,' ') as compaenti, en.cuit as cuitenti, en.iva as ivaenti   "
	sqlmatriz(3)=" from cheques c "
	sqlmatriz(4)=" left join cobropagolink k on k.tablacp = 'detallepagos' and k.tabla = 'cheques' and k.idregistro = c.idcheque "
	sqlmatriz(5)=" left join detallepagos dc on dc.iddetapago = k.registrocp "
	sqlmatriz(6)=" left join comprobantes cm on cm.idcomproba = dc.idcomproba "
	sqlmatriz(7)=" left join ultimoestado ue on ue.tabla = cm.tabla and dc.idregistro = ue.id "
	sqlmatriz(8)=" left join cbancoentidad be on be.idcuenta = dc.idcuenta and be.predet = 'S'"
	sqlmatriz(9)=" left join entidades en on en.entidad = be.entidad "
	sqlmatriz(10)=" where idcheque = "+ALLTRIM(STR(pct_idcheque))
	
	verror=sqlrun(vconeccionTa ,"cuota_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la Cuota de Tarjeta ",0+48+0,"Error")
		=abreycierracon(vconeccionTa ,"")	
	    RETURN .F.  
	ENDIF	 

	SELECT * FROM cuota_sql INTO TABLE cuotasliq 
	GO TOP
	ALTER table cuotasliq alter COLUMN idcuentatj n(10)
	ALTER table cuotasliq alter COLUMN entidad n(10)
	USE IN cuota_sql 
	IF !EOF() THEN 
		IF !(cuotasliq.cuota = 'S') OR !EMPTY(cuotasliq.fechaacr) THEN 
	    	MESSAGEBOX("No ha Seleccionado una Cuota de Tarjeta o la Cuota ya fue Liquidada... Verifique... ",0+48+0,"Error")
			RETURN 
		ENDIF 
		IF cuotasliq.entidad = 0 THEN 
	    	MESSAGEBOX("Debe Asociar una Cuenta de Entidad para el Proveedor de Tarjetas... Verifique... ",0+48+0,"Error")
			RETURN 
		ENDIF 

		** Variable _SYSCIFPTAR = IIPPIIPPTP (idcomproba, punto venta : CI, idcomproba, punto venta : Fact.Prov, Tipo Pago para Caja Ingreso
		v_idcomprobaci = INT(VAL(SUBSTR(_SYSCIFPTAR,1,2)))
		v_pventaci	   = INT(VAL(SUBSTR(_SYSCIFPTAR,3,2)))
		v_idcomprobafp = INT(VAL(SUBSTR(_SYSCIFPTAR,5,2)))
		v_idtipocompfp = INT(VAL(SUBSTR(_SYSCIFPTAR,7,2)))
		v_tipopago	   = INT(VAL(SUBSTR(_SYSCIFPTAR,9,2)))
		v_impuestofp   = INT(VAL(SUBSTR(_SYSCIFPTAR,11,2)))

		* 1.- Le coloco fecha de Liquidación o Acreditación a la Cuota Correspondiente 

		sqlmatriz(1)=" update cheques set fechaacr= '"+DTOS(DATE())+"' "
		sqlmatriz(2)=" where idcheque = "+ALLTRIM(STR(pct_idcheque))	
		verror=sqlrun(vconeccionTa ,"cuota")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualización de la Fecha de la Tarjeta ",0+48+0,"Error")
			=abreycierracon(vconeccionTa ,"")	
		    RETURN .F.  
		ENDIF	 
		
		* 2.- Genero el Caja Ingreso en la Cuenta Cuenta de la Tarjeta
***************************************************************************
			v_idcajaie  = 0
			v_cajaie_idcomproba = v_idcomprobaci
			v_cajaie_pventa 	= v_pventaci
			v_cajaie_numero 	= maxnumerocom(v_cajaie_idcomproba ,v_cajaie_pventa ,1)
			v_fecha 			= DTOS(DATE())
			v_entidadCajaie 	= cuotasliq.entidad
			v_nombre 			= ALLTRIM(cuotasliq.nomenti)+" "+ALLTRIM(cuotasliq.apeenti)+" "+ALLTRIM(cuotasliq.compaenti)
			v_direccion			= " "	
			v_cuit				= " "
			v_cajaie_importe 	= cuotasliq.importe
			v_concepto			= "Paso Deuda a Proveedores : "+ALLTRIM(cuotasliq.serie)+" "+ALLTRIM(cuotasliq.numero)+" "+ALLTRIM(cuotasliq.alaorden)
			v_detallecp			= "detallecobros"
			
			DIMENSION lamatriz8(12,2)
			
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla     = 'cajaie'
			p_matriz    = 'lamatriz8'
			p_conexion  = vconeccionTa 

				
			
			lamatriz8(1,1)='idcajaie'
			lamatriz8(1,2)=ALLTRIM(STR(v_idcajaie))
			lamatriz8(2,1)='idcomproba'
			lamatriz8(2,2)= ALLTRIM(STR(v_cajaie_idcomproba))
			lamatriz8(3,1)='pventa'
			lamatriz8(3,2)=ALLTRIM(STR(v_cajaie_pventa))
			lamatriz8(4,1)='numero'
			lamatriz8(4,2)=ALLTRIM(STR(v_cajaie_numero))
			lamatriz8(5,1)='fecha'
			lamatriz8(5,2)="'"+ALLTRIM(v_fecha)+"'"
			lamatriz8(6,1)='entidad'
			lamatriz8(6,2)=ALLTRIM(STR(v_entidadCajaIE))
			lamatriz8(7,1)='nombre'
			lamatriz8(7,2)="'"+ALLTRIM(v_nombre)+"'"
			lamatriz8(8,1)='direccion'
			lamatriz8(8,2)="'"+ALLTRIM(v_direccion)+"'"
			lamatriz8(9,1)='cuit'
			lamatriz8(9,2)="'"+ALLTRIM(v_cuit)+"'"
			lamatriz8(10,1)='concepto'
			lamatriz8(10,2)="'"+ALLTRIM(v_concepto)+"'"
			lamatriz8(11,1)='importe'
			lamatriz8(11,2)=ALLTRIM(STR(v_cajaie_importe,13,2))
			lamatriz8(12,1)='detallecp'
			lamatriz8(12,2)="'"+v_detallecp+"'"
			

			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			    RETURN 
			ENDIF 
			
			RELEASE lamatriz8
			
			
			*** Ultimo ID registrado ***
			
			
			sqlmatriz(1)="SELECT last_insert_id() as maxid "

			verror=sqlrun(vconeccionTa,"cajaiemax_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID de cajaie",0+48+0,"Error")
			ENDIF 

			SELECT cajaiemax_sql
			GO TOP 

			v_idcajaie = VAL(cajaiemax_sql.maxid)
			
			USE in cajaiemax_sql

			
			
			
			*** REGISTRO ESTADO AUTORIZADO ***

			registrarEstado("cajaie","idcajaie",v_idcajaie,'I',"AUTORIZADO")
	
				
		*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
		
			guardaCajaRecaH (v_cajaie_idcomproba, v_idcajaie)
			
			
			**** GUARDO DATOS DE DETALLECOBRO		
			
				DIMENSION lamatriz5(6,2)
				v_nombreID	= ""
				v_iddetacp 	= 0
				
				v_iddetacp	= maxnumeroidx("iddetacobro", "I","detallecobros",1)
				v_nombreID	= "iddetacobro" 	
				
				IF v_iddetacp <= 0
					MESSAGEBOX("Error al registrar el detalle de cobro o pago",0+16+0,"Error al registrar el comprobante")
				ENDIF 
				
				v_detallecp_idcomproba 		= v_cajaie_idcomproba 
				v_detallecp_idregi			= v_idcajaie
				v_idtipoPago 				= v_tipopago			
				v_detallecp_importe			= v_cajaie_importe
				id_cajabco					= cuotasliq.idcuenta 

				v_fecha = DTOS(DATE())	
				
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
				p_tabla     = 'detallecobros'
				p_matriz    = 'lamatriz5'
				p_conexion  = vconeccionTa
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				    
				ENDIF 
				RELEASE lamatriz5
*!*						
*!*			*Registracion Contable del Caja Ingreso/Egreso	
*!*			v_cargo = ContabilizaCompro('cajaie', v_idcajaie, vconeccionF, v_cajaie_importe)
			
			sino = MESSAGEBOX("¿Desea imprimir el Comprobante de Caja Ingreso o Caja Egreso?",4+32,"Imprimir Caja Ingreso / Egreso")
			IF sino = 6

				v_opera_comp = 1
				imprimirCajaIE(v_idcajaie,v_opera_comp)
			
			ENDIF 
	
***************************************************************************
***************************************************************************		
		* 3.- Genero Factura de Proveedor sin Impuestos 
		* 	  para paso de deuda de cuota a Proveedor de Tarjeta
***************************************************************************


		*** ID_FACTURA = 0 SE ESTÁ CREANDO UNA FACTURA, PUEDE GUARDAR

		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "

			v_idfactura = maxnumeroidx("idfactprove","I","factuprove",1)
		
			v_fp_idcomproba = v_idcomprobafp
			v_fp_idtipocomp	= v_idtipocompfp
			v_fp_tipo 		= "X"
			v_fp_actividad  = 1
			v_fp_numero 	= cuotasliq.idcheque
			v_fp_fecha 		= DTOS(DATE())
			v_fp_entidad 	= v_entidadCajaie
			v_fp_nombre 	= ALLTRIM(cuotasliq.nomenti)
			v_fp_apellido	= ALLTRIM(cuotasliq.apeenti)+" "+ALLTRIM(cuotasliq.compaenti)
			v_fp_direccion	= " "	
			v_fp_cuit		= ALLTRIM(cuotasliq.cuitenti)
			v_fp_dni		= 0
			v_fp_docTipo	= "80"
			v_fp_iva		= cuotasliq.ivaenti
			v_fp_condVta	= 1
			v_fp_nroremito 	= ""
			v_fp_nropedido 	= ""
			v_fp_neto 		= cuotasliq.importe
			v_fp_impuestos	= 0.00
			v_fp_total		= cuotasliq.importe
			v_fp_fechacarga	= DTOS(DATE())
			v_fp_fechaing	= DTOS(DATE())
			v_fp_observa	= "Paso Deuda a Proveedores : "+ALLTRIM(cuotasliq.serie)+" "+ALLTRIM(cuotasliq.numero)+" "+ALLTRIM(cuotasliq.alaorden)
			v_fp_liva 		= 'N'
			
	
			*** GUARDA DATOS DE CABECERA DE LA FACTURA de PROVEEDOR

			DIMENSION lamatriz1(24,2)

			lamatriz1(1,1)='idfactprove'
			lamatriz1(1,2)= ALLTRIM(STR(v_idfactura))
			lamatriz1(2,1)='idtipocompro'
			lamatriz1(2,2)=ALLTRIM(STR(v_fp_idtipocomp))
			lamatriz1(3,1)='tipo'
			lamatriz1(3,2)="'"+ALLTRIM(v_fp_tipo)+"'"
			lamatriz1(4,1)='actividad'
			lamatriz1(4,2)= ALLTRIM(STR(v_fp_actividad))
			lamatriz1(5,1)='numero'
			lamatriz1(5,2)= ALLTRIM(STR(v_fp_numero))
			lamatriz1(6,1)='fecha'
			lamatriz1(6,2)="'"+ALLTRIM(v_fp_fecha)+"'"
			lamatriz1(7,1)='entidad'
			lamatriz1(7,2)=ALLTRIM(STR(v_fp_entidad))
			lamatriz1(8,1)='apellido'
			lamatriz1(8,2)= "'"+ALLTRIM(v_fp_apellido)+"'"
			lamatriz1(9,1)='nombre'
			lamatriz1(9,2)= "'"+ALLTRIM(v_fp_nombre)+"'"
			lamatriz1(10,1)='cuit'
			lamatriz1(10,2)= "'"+ALLTRIM(v_fp_cuit)+"'"
			lamatriz1(11,1)='dni'
			lamatriz1(11,2)= ALLTRIM(STR(v_fp_dni))
			lamatriz1(12,1)='tipodoc'
			lamatriz1(12,2)= "'"+ALLTRIM(v_fp_docTIpo)+"'"
			lamatriz1(13,1)='iva'
			lamatriz1(13,2)= ALLTRIM(STR(v_fp_iva))
			lamatriz1(14,1)='condvta'
			lamatriz1(14,2)= ALLTRIM(STR(v_fp_condVta))
			lamatriz1(15,1)='nroremito'
			lamatriz1(15,2)="'"+ALLTRIM(v_fp_nroremito)+"'"
			lamatriz1(16,1)='nropedido'
			lamatriz1(16,2)="'"+ALLTRIM(v_fp_nropedido)+"'"
			lamatriz1(17,1)='neto'
			lamatriz1(17,2)= ALLTRIM(STR(v_fp_neto,13,4))
			lamatriz1(18,1)= 'impuesto'
			lamatriz1(18,2)= ALLTRIM(STR(v_fp_impuestos,13,4))
			lamatriz1(19,1)='total'
			lamatriz1(19,2)= ALLTRIM(STR(v_fp_total,13,4))
			lamatriz1(20,1)='fechacarga'
			lamatriz1(20,2)= "'"+ALLTRIM(v_fp_fechaCarga)+"'"
			lamatriz1(21,1)='fechaingreso'
			lamatriz1(21,2)= "'"+ALLTRIM(v_fp_fechaIng)+"'"
			lamatriz1(22,1)='observa'
			lamatriz1(22,2)= "'"+ALLTRIM(v_fp_observa)+"'"
			lamatriz1(23,1)='idcomproba'
			lamatriz1(23,2)=ALLTRIM(STR(v_fp_idcomproba))
			lamatriz1(24,1)='liva'
			lamatriz1(24,2)= "'"+ALLTRIM(v_fp_liva)+"'"


			p_tabla     = 'factuprove'
			p_matriz    = 'lamatriz1'
			p_conexion  = vconeccionTa
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			    RETURN 
			ENDIF  


			*** GUARDO DETALLE de IMPUESTOS DE LA FACTURA ***	

			DIMENSION lamatriz3(6,2)

				
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
					
				
			lamatriz3(1,1)='idfactprove'
			lamatriz3(1,2)= ALLTRIM(STR(v_idfactura))
			lamatriz3(2,1)= 'impuesto'
			lamatriz3(2,2)= ALLTRIM(STR(v_impuestofp))
			lamatriz3(3,1)= 'detalle'
			lamatriz3(3,2)= "'SIN IMPUESTOS'"
			lamatriz3(4,1)= 'neto'
			lamatriz3(4,2)= ALLTRIM(STR(cuotasliq.importe,13,2))
			lamatriz3(5,1)= 'razon'
			lamatriz3(5,2)= ALLTRIM(STR(0.00,13,2))
			lamatriz3(6,1)= 'importe'
			lamatriz3(6,2)= ALLTRIM(STR(0.00,13,2))
					

			p_tabla     = 'factuproveimp'
			p_matriz    = 'lamatriz3'
			p_conexion  = vconeccionTa
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			ENDIF


			*** GENERO EL ASIENTO CONTABLE DE LA FACTURA DE PROVEEDOR RECIEN INGRESADA ***			
			IF TYPE('_SYSCONTABLE') <> 'N' THEN 
				*RETURN ret_idasiento 
			ELSE 
			
				IF _SYSCONTABLE <= 0 OR _SYSCONTABLE > 3  OR EMPTY(cuotasliq.codigoctac) OR EMPTY(cuotasliq.codigoctap)THEN 

				ELSE 
				
					** Busco las Cuentas Contables en el Plan de Cuentas Activo
					v_codigoctac = cuotasliq.codigoctac
					v_codigoc	 = ""
					v_nombrectac = ""
					v_idplandc	 = 0
					v_codigoctap = cuotasliq.codigoctap
					v_codigop	 = ""
					v_nombrectap = ""
					v_idplandp	 = 0
					v_debec		 = 0.00
					v_haberc	 = 0.00
					
					sqlmatriz(1)="SELECT * FROM plancuentasd "
					sqlmatriz(2)="WHERE activa = 'S' and imputable = 'S' and ( codigocta = '"+v_codigoctac+"' or codigocta = '"+v_codigoctap+"' ) and idplan = "+STR(_SYSIDPLAN)
					verror=sqlrun(vconeccionTa,"plancta")
					IF verror=.f.
						* me desconecto
					ELSE 
						* me desconecto
						SELECT plancta
						GO TOP
						IF EOF() THEN 
						ELSE
							DO WHILE !EOF()
								IF ALLTRIM(plancta.codigocta)==ALLTRIM(v_codigoctac) THEN 
									v_codigoc	 = plancta.codigo
									v_nombrectac = plancta.nombrecta
									v_idplandc	 = plancta.idpland
									v_debec		 = cuotasliq.importe
								ENDIF 
								IF ALLTRIM(plancta.codigocta)==ALLTRIM(v_codigoctap) THEN 
									v_codigop	 = plancta.codigo
									v_nombrectap = plancta.nombrecta
									v_idplandp	 = plancta.idpland	
									v_haberp	 = cuotasliq.importe								
								ENDIF 
								SKIP 
							ENDDO 						
						ENDIF 
						USE IN plancta			
					ENDIF 	
				
					
					IF v_idplandp > 0 AND v_idplandc > 0 THEN 
				
						
						*CREO EL ASIENTO CONTABLE
						CREATE TABLE asientofp.dbf ( idastomode i, codigocta c(20), debe y, haber y, tabla c(30), registro i, fecha c(8), idfiltro i, idtipoasi i, idastoe i, idpland i, codigo c(22), nombrecta c(200) ) 
						
						SELECT asientofp
						
						INSERT INTO asientofp VALUES (0,v_codigoctac,v_debec,0,'factuprove',v_idfactura, v_fp_fecha,0,1,1,v_idplandc,v_codigoc, v_nombrectac)
						INSERT INTO asientofp VALUES (0,v_codigoctap,0,v_haberp,'factuprove',v_idfactura, v_fp_fecha,0,1,1,v_idplandp,v_codigop, v_nombrectap)

						SELECT asientofp
						COPY TO asientofp.txt DELIMITED WITH ""
						USE IN asientofp 
						var_grabo = IncerAstoContable("asientofp.txt")  
					ENDIF 
									
				ENDIF 	
			ENDIF 			
			
***************************************************************************

***************************************************************************
***************************************************************************
	ENDIF 

	USE IN cuotasliq 
	=abreycierracon(vconeccionTa ,"")	

ENDFUNC 





FUNCTION anularCajaIE
PARAMETERS pIdregistro
*#/----------------------------------------
** FUNCIÓN para anular Caja Ingreso o Egreso
** Parametros: pIdRegistro: Id del registro de la tabla cajaie que se desea anular.
** Retorno: Retorna ID del registro de anulación. 0 en caso que no se haya registrado
*#/----------------------------------------

	v_retornocie = 0


*!*		estadosRP	= CREATEOBJECT('estadosclass')
*!*		v_estadoRPAnulado = estadosRP.getIdestado("ANULADO")
*!*		RELEASE estadosRP
*!*		
	vconeccionAn = abreycierracon(0,_SYSSCHEMA)


	** Obtengo el Comprobante para ver si puedo anularlo **
	sqlmatriz(1)=" select * from cajaie  where idcajaie = "+ALLTRIM(STR(pIdregistro))
	verror=sqlrun(vconeccionAn ,"cieAnul")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del comprobante a anular ",0+48+0,"Error")
		=abreycierracon(vconeccionAn ,"")	
	    RETURN -1  
	ENDIF	 
	SELECT cieAnul
	GO TOP 	

	vcieidcompro = cieAnul.idcomproba
	vcieidcaja	 = cieAnul.idcajaie
	USE IN cieAnul
	v_CHAnular = CHAnularCMP ( vcieidcompro , vcieidcaja, vconeccionAn )
	IF v_CHAnular = .f. THEN 
		MESSAGEBOX(" No se puede Anular el Comprobante,: "+CHR(13)+" Pertenece a otra Caja o se transfirieron los Valores o Cupones...",16,"Anular Comprobantes")
		=abreycierracon(vconeccionAn ,"")		
	    RETURN -1  		
	ENDIF 
	
	
	* Busco el comprobante a anular para saber si anulo un recibo o un pago a proveedor 
*!*		sqlmatriz(1)=" select c.*, t.opera, p.pventa from comprobantes c left join tipocompro t on c.idtipocompro = t.idtipocompro "
*!*		sqlmatriz(2)=" left join compactiv p on p.idcomproba = c.idcomproba "
*!*		sqlmatriz(3)=" where c.idcomproba = "+ALLTRIM(STR(pan_idcomproba))+" or  c.tabla = 'anularp' " 
*!*		verror=sqlrun(vconeccionAn ,"tablarp")
*!*		IF verror=.f.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la Tabla de comprobantes ",0+48+0,"Error")
*!*			=abreycierracon(vconeccionAn ,"")	
*!*		    RETURN .F.  
*!*		ENDIF	 
	
	** Valido que no estè anulado **
	sqlmatriz(1)=" select * from cajaie c left join linkcompro l on c.idcomproba = l.idcomprobaa and c.idcajaie = l.idregistroa  "
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
	
	
	
	sqlmatriz(1)=" select c.*,t.opera, t.idtipocompro as idtipocomp from cajaie c left join comprobantes o on c.idcomproba = o.idcomproba "
	sqlmatriz(2)=" left join tipocompro t on o.idtipocompro = t.idtipocompro " 
	sqlmatriz(3)=" where idcajaie = "+ALLTRIM(STR(pIdregistro)) 
	verror=sqlrun(vconeccionAn ,"cajaieA")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del comprobante a anular ",0+48+0,"Error")
		=abreycierracon(vconeccionAn ,"")	
	    RETURN -1  
	ENDIF	 

	SELECT cajaieA
	GO TOP

	IF !EOF() THEN 
		
		v_idcomproba = cajaieA.idcomproba
		v_idregistro = pIdregistro
		
		* Obtengo el detalle de cobros o de pagos a anular
		sqlmatriz(1)=" select t.*, h.idcajareca, h.fecha, h.hora, tp.idtipocompro, tp.operac as opera, tp.idtipocompro as idtipocomp "
		sqlmatriz(2)=" from cajaie t left join cajarecaudah h on t.idcomproba = h.idcomproba and t.idcajaie = h.idregicomp left join comprobantes cp on cp.idcomproba   = t.idcomproba "
		sqlmatriz(3)=" left join tipocompro   tp on tp.idtipocompro = cp.idtipocompro "
		sqlmatriz(4)=" where t.idcomproba = "+ALLTRIM(STR(v_idcomproba))+" and t.idcajaie = "+ALLTRIM(STR(v_idregistro))
		
										
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

	
	v_opera = cajaieA.opera

	IF v_opera > 0
		*sqlmatriz(1)="SELECT * FROM detallecobros  where idcomproba	= "+ALLTRIM(STR(v_idcomproba))+" and idregistro = "+ALLTRIM(STR(v_idcajaie))
		sqlmatriz(1)=" SELECT d.*,c.idregistro as idreg,m.idtipocompro as idtipocomp FROM detallecobros d left join cobropagolink c on d.iddetacobro = c.registrocp and c.tablacp = 'detallecobros' "
		sqlmatriz(2)= " and c.campocp = 'iddetacobro' left join comprobantes m on d.idcomproba = m.idcomproba "
		sqlmatriz(3)="  where d.idcomproba = "+ALLTRIM(STR(v_idcomproba))+" and d.idregistro = "+ALLTRIM(STR(v_idregistro)) 
	ELSE
		*sqlmatriz(1)="SELECT * FROM detallepagos where idcomproba	= "+ALLTRIM(STR(v_idcomproba))+" and idregistro = "+ALLTRIM(STR(v_idcajaie))
		sqlmatriz(1)=" SELECT d.*,c.idregistro as idreg,m.idtipocompro as idtipocomp FROM detallepagos  d left join cobropagolink c on d.iddetapago = c.registrocp and c.tablacp = 'detallepagos' "
		sqlmatriz(2)= " and c.campocp = 'iddetapago'  left join comprobantes m on d.idcomproba = m.idcomproba " 
		sqlmatriz(3)= " where d.idcomproba = "+ALLTRIM(STR(v_idcomproba))+" and d.idregistro = "+ALLTRIM(STR(v_idregistro))
	
	ENDIF 
	
	verror=sqlrun(vconeccionAn,"detacobropago_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de detalle de movimientos",0+48+0,"Error")
	ENDIF 



SELECT detacobropago_sql
GO TOP 


*************************************************************************************		
	
				
				v_idcompE = 0
				v_idptovtaE = 0
				v_idcompI = 0
				v_idptoVtaI = 0
				
				IF NOT EMPTY(ALLTRIM(_SYSANULAIE)) &&_SYSANULAIE (PPEEPPII)
					v_idptoVtaE = VAL(ALLTRIM(SUBSTR(_SYSANULAIE,1,2)))
					v_idcompE = VAL(ALLTRIM(SUBSTR(_SYSANULAIE,3,2)))
					v_idptoVtaI = VAL(ALLTRIM(SUBSTR(_SYSANULAIE,5,2)))
					v_idcompI = VAL(ALLTRIM(SUBSTR(_SYSANULAIE,7,2)))
					
					SELECT idtipocom FROM  comprobantes_sql WHERE idcomproba = v_idcompE INTO CURSOR tipoCompE
					
					SELECT tipocompE
					GO TOP 
					
					IF NOT EOF()
						v_idtipoCompE = tipoCompE.idtipocom
					ELSE
						MESSAGEBOX("Error al buscar el tipo de comprobante de anulación",0+48+0,"No se puede anular")
						RETURN -1
					ENDIF 

					SELECT idtipocom FROM  comprobantes_sql WHERE idcomproba = v_idcompI INTO CURSOR tipoCompI
					
					SELECT tipoCompI
					GO TOP 
					
					IF NOT EOF()
						v_idtipoCompI = tipoCompI.idtipocom
					ELSE
						MESSAGEBOX("Error al buscar el tipo de comprobante de anulación",0+48+0,"No se puede anular")
						RETURN -1
					ENDIF 

					
					
					
					
				ELSE
					MESSAGEBOX("No se han definido los comprobantes de anulación de Caja Ingreo y Egreso",0+48+0,"No se puede anular")
					RETURN -1
				ENDIF 
			
				v_opera = cajaieA.opera

				v_idcajaie  = 0

			SELECT cajaieA
			vconeccionF = abreycierracon(0,_SYSSCHEMA)

			*v_cajaie_idcomproba = comprobacie.idcomproba
			*v_cajaie_pventa 	= comprobacie.pventa
			*v_cajaie_numero = maxnumerocom(v_cajaie_idcomproba ,v_cajaie_pventa ,1)

			v_fecha = cftofc(DATE())
			v_entidadCajaie = cajaieA.entidad
			v_nombre = ALLTRIM(cajaieA.nombre)
			v_direccion	= ALLTRIM(cajaieA.direccion)
			v_cuit	= ALLTRIM(cajaieA.cuit)
			v_cajaie_importe = cajaieA.importe
			v_concepto		= ALLTRIM(cajaieA.concepto)
			v_opera_comp		= v_opera * (-1)
			v_detallecp			= ""
			IF v_opera_comp < 0
				v_detallecp = "detallepagos" 
				v_cajaie_idcomproba = v_idcompI
				v_cajaie_pventa 	= v_idptovtaI
				v_cajaie_numero = maxnumerocom(v_cajaie_idcomproba ,v_cajaie_pventa ,1)
				v_tablaPor= 'cajaie' 		
				v_tablaor = 'detallecobros'	
				v_idtablaor = "idcajaie"
				v_idtipocompAn = v_idtipocompI

			ELSE
				IF v_opera_comp > 0
					v_detallecp = "detallecobros" 
					v_cajaie_idcomproba = v_idcompE
					v_cajaie_pventa 	= v_idptovtaE
					v_cajaie_numero = maxnumerocom(v_cajaie_idcomproba ,v_cajaie_pventa ,1)
					v_tablaPor= 'cajaie' 			
					v_tablaor = 'detallepagos'	
					v_idtablaor = "idcajaie"
					v_idtipocompAn = v_idtipocompE
				ENDIF 
			
			ENDIF 
*!*				thisform.calcularmax
			

			DIMENSION lamatriz8(12,2)
			 
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla     = 'cajaie'
			p_matriz    = 'lamatriz8'
			p_conexion  = vconeccionF

				
			
			lamatriz8(1,1)='idcajaie'
			lamatriz8(1,2)=ALLTRIM(STR(v_idcajaie))
			lamatriz8(2,1)='idcomproba'
			lamatriz8(2,2)= ALLTRIM(STR(v_cajaie_idcomproba))
			lamatriz8(3,1)='pventa'
			lamatriz8(3,2)=ALLTRIM(STR(v_cajaie_pventa))
			lamatriz8(4,1)='numero'
			lamatriz8(4,2)=ALLTRIM(STR(v_cajaie_numero))
			lamatriz8(5,1)='fecha'
			lamatriz8(5,2)="'"+ALLTRIM(v_fecha)+"'"
			lamatriz8(6,1)='entidad'
			lamatriz8(6,2)=ALLTRIM(STR(v_entidadCajaIE))
			lamatriz8(7,1)='nombre'
			lamatriz8(7,2)="'"+ALLTRIM(v_nombre)+"'"
			lamatriz8(8,1)='direccion'
			lamatriz8(8,2)="'"+ALLTRIM(v_direccion)+"'"
			lamatriz8(9,1)='cuit'
			lamatriz8(9,2)="'"+ALLTRIM(v_cuit)+"'"
			lamatriz8(10,1)='concepto'
			lamatriz8(10,2)="'"+ALLTRIM(v_concepto)+"'"
			lamatriz8(11,1)='importe'
			lamatriz8(11,2)=ALLTRIM(STR(v_cajaie_importe,13,2))
			lamatriz8(12,1)='detallecp'
			lamatriz8(12,2)="'"+v_detallecp+"'"
			

			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			    RETURN  -1
			ENDIF 


*** Ultimo ID registrado ***
			
			
		sqlmatriz(1)="SELECT last_insert_id() as maxid "

		verror=sqlrun(p_conexion,"cajaiemax_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID de cajaie",0+48+0,"Error")
		ENDIF 

		SELECT cajaiemax_sql
		GO TOP 
	
		v_idcajaie = VAL(cajaiemax_sql.maxid)
		v_retornocie = v_idcajaie 
		
		
		USE in cajaiemax_sql


		tipoPagoObj 	= CREATEOBJECT('tipospagosclass')


			
			
				*** REGISTRO ESTADO AUTORIZADO PARA EL COMPROBANTE DE ANULACIÓN ***

			registrarEstado("cajaie","idcajaie",v_idcajaie,'I',"AUTORIZADO")
	
		*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
		
			guardaCajaRecaH (v_cajaie_idcomproba, v_idcajaie)
			
			
			
			
			
			*********************
			*
			****
			*
			*
			*FALTA TRAER LOS DATOS DE DETALLE PAGO - DETALLE COBROS--.... ESTÁ trayendo solamente los datos de la cabecera del comprobante cajaie
			*
			*
			*
			*
			*
			*
			*******************
			SELECT detacobropago_sql
			GO TOP 
			
			DO WHILE NOT EOF() 
			
			**** GUARDO DATOS DE DETALLECOBRO / DETALLEPAGOS****
			
			
				DIMENSION lamatriz5(6,2)
				v_nombreID	= ""
				v_iddetacp 	= 0
				
				IF v_detallecp == "detallecobros"
					v_iddetacp	= maxnumeroidx("iddetacobro", "I","detallecobros",1)
					v_nombreID	= "iddetacobro" 	
				ELSE
				
					IF v_detallecp == "detallepagos"
					v_iddetacp 		= maxnumeroidx("iddetapago", "I","detallepagos",1)
					v_nombreID	= "iddetapago" 	
					ENDIF 
				ENDIF 
				
				IF v_iddetacp <= 0
					MESSAGEBOX("Error al registrar el detalle de cobro o pago",0+16+0,"Error al registrar el comprobante")
				
				ENDIF 
				
				SELECT detallecp 
				v_detallecp_idcomproba 		= v_cajaie_idcomproba 
				v_detallecp_idregi			= v_idcajaie
				*v_detallecp_importe 		= v_cobro_imputado
				v_idtipoPago 				= detacobropago_sql.idtipopago 				
				v_detallecp_importe			= detacobropago_sql.importe 
				id_cajabco					= detacobropago_sql.idcuenta 
				
				
				v_fecha = cftofc(DATE())	
				
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
				*p_tabla     = 'detallecobros'
				p_tabla		= v_detallecp
			
				p_matriz    = 'lamatriz5'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
				    
				ENDIF 
			
			
				*** Guardo en COBROPAGO LINK PARA CUPONES O CHEQUES ***
				
				v_tipoPagoCupon = tipopagoObj.gettipospagos('CUPONES')
					*** Registro movitpago
					SELECT detacobropago_sql
					
					v_idtipocomp = detacobropago_sql.idtipocomp

					
			
					IF v_idtipoPago == v_tipoPagoCupon
						***GUARDA RELACION CUPON - DETALLE PAGO (EN TABLA COBROPAGOLINK)***
						
						DIMENSION lamatriz6(8,2)
				
						v_idcplink = maxnumeroidx("idcplink", "I", "cobropagolink",1)	
						*v_tablacp	= "detallecobros"
						v_tablacp	= v_detallecp
						v_campocp	= v_nombreID
						v_tabla		= "cupones"
						v_campo		= "idcupon"	
						*v_idregistro= v_detallecp_idregi
						v_idregistroD = detacobropago_sql.idreg
						*v_fecha		= DTOS(DATE())
						v_fecha = cftofc(DATE())						
						p_tipoope     = 'I'
						p_condicion   = ''
						v_titulo      = " EL ALTA "
						p_tabla     = 'cobropagolink'
						p_matriz    = 'lamatriz6'
						p_conexion  = vconeccionF

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
							v_ret = guardarMoviTPago(v_idtipoPago, v_tabla, v_campo, v_idregistroD, _SYSCAJARECA, id_cajabco, v_idtipocompAn, v_tablacp, v_campocp, v_iddetacp )
						
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
*!*								v_tablacp	= "detallecobros"
*!*								v_campocp	= "iddetacobro"
							v_tablacp	= v_detallecp
							v_campocp	= v_nombreID
							v_tabla		= "cheques"
							v_campo		= "idcheque"	
							*v_idregistro= v_detallecp_idregi
							v_idregistroD = detacobropago_sql.idreg
							*v_fecha		= DTOS(DATE())
							v_fecha = cftofc(DATE())
							p_tipoope     = 'I'
							p_condicion   = ''
							v_titulo      = " EL ALTA "
							p_tabla     = 'cobropagolink'
							p_matriz    = 'lamatriz6'
							p_conexion  = vconeccionF

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
								v_ret = guardarMoviTPago(v_idtipoPago, v_tabla, v_campo, v_idregistroD, _SYSCAJARECA,id_cajabco,v_idtipocompAn, v_tablacp, v_campocp, v_iddetacp )
						
								IF v_ret = .F.
									MESSAGEBOX("Ha Ocurrido un Error al intentar registrar el Movimiento para el Tipo de pago",0+48+0,"Error")
								ENDIF 

								* Actualizo el idcuenta del cheque SI ES PROPIO con la cuenta seleccionada
								* En el pago asociado al cheque
								sqlmatriz(1)= "update cheques set idcuenta = "+ALLTRIM(STR(id_cajabco))+" where detercero = 'N' and idcheque ="+ALLTRIM(STR(v_idregistroD))
								verror=sqlrun(p_conexion,"upcheque_sql")
								IF verror=.f.  
								    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion de Cheques  ",0+48+0,"Error")
								ENDIF 

							ENDIF 
						ENDIF 
					ENDIF 
							
			
				SELECT detacobropago_sql
				SKIP 1
			
			ENDDO 


	*** Asocio el comprobante de anulación con el CajaIE anulado **
							
			DIMENSION lamatriz7(5,2)

			v_idlinkComp = 0
			v_idcomprobaa=cajaieA.idcomproba
			v_idregistroa=cajaieA.idcajaie
			v_idcomprobab=v_cajaie_idcomproba
			v_idregistrob=v_idcajaie
			
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla     = 'linkcompro'
			p_matriz    = 'lamatriz7'
			p_conexion  = vconeccionF

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
	
						
				*Registracion Contable del Caja Ingreso/Egreso	
			pan_idregistro = pIdregistro
		
	

				nuevo_asiento = Contrasiento( 0,_SYSCONTRADH, v_tablaPor, pan_idregistro, 'cajaie', v_idcajaie)
		
	
			IF v_opera_comp < 0
				
				v_ret = ctaCteBancos('CAJAEGRESO',v_idcajaie,0)
			ELSE
				IF v_opera_comp > 0
					v_ret = ctaCteBancos('CAJAINGRESO',v_idcajaie,0)
				ENDIF 
			
			ENDIF 
			
			
		ELSE
				
			=abreycierracon(vconeccionAn ,"")	
			RETURN -1
		ENDIF 
		
*!*		  	*** REGISTRO ESTADO ANULADO PARA EL CAJAIE ***
*!*				registrarEstado("cajaie","idcajaie",pIdregistro,'I',"ANULADO")

		=abreycierracon(vconeccionAn ,"")	
	

	


	IF TYPE('v_retornocie') == 'C'
		v_retornocie= VAL(v_retornocie)
	ENDIF 
	

	RETURN v_retornocie

ENDFUNC 





FUNCTION obtenerOpcionesFactura
PARAMETERS p_idFactura
*#/----------------------------------------
*** Función que obtiene las opciones asociadas a la factura**
** Recibe como parámetro el IDFactura
** Retorna una lista de opciones con el siguiente formato: 'codigo1,valor1;codigo2,valor2;codigoN,valorN'
*#/----------------------------------------

	v_opcionesRet = ""

	**** CARGA OPCIONES ***

	vconeccionOp=abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)="Select f.idfactura, o.idopcion,o.codigo,o.valor,o.descrip,o.tipo "
	sqlmatriz(2)=" from facturaopciones f left join opcionesafip o on f.idopcion = o.idopcion  "
	sqlmatriz(4)=" where f.idfactura = "+ ALLTRIM(STR(p_idfactura))

	verror=sqlrun(vconeccionOp,"factopciones_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las opciones de AFIP",0+48+0,"Error")
	    =abreycierracon(vconeccionOp,"")
		RETURN v_opcionesRet
	ENDIF 
	

	SELECT factopciones_sql
	GO TOP 
	
	DO WHILE NOT EOF()
	
		
		SELECT factopciones_sql
		
		v_codigo = factopciones_sql.codigo
		v_valor = factopciones_sql.valor
		v_tipo = factopciones_sql.tipo
		
		IF !EMPTY(v_valor) AND !EMPTY(v_codigo) AND !Empty(v_tipo)
			DO CASE
			CASE ALLTRIM(v_tipo) = 'F' && FIJO
				&& Queda el mismo valor gurdado		
			CASE ALLTRIM(v_tipo) = 'V' && VARIABLE
					v_valor = &v_valor && Obtengo el valor de la variable
			OTHERWISE
				&& Queda el mismo valor gurdado		
			ENDCASE
			
									
			IF EMPTY(v_opcionesRet)
				v_opcionesRet = ALLTRIM(v_codigo)+","+ALLTRIM(v_valor)
			ELSE
				v_opcionesRet = ALLTRIM(v_opcionesRet)+";"+ALLTRIM(v_codigo)+","+ALLTRIM(v_valor)			
			ENDIF 
		ELSE
			RETURN v_opcionesRet		
		ENDIF 
		
		SELECT factopciones_sql
		SKIP 1
	ENDDO 
	

	RETURN v_opcionesRet

ENDFUNC 



FUNCTION EliminaVinculo
PARAMETERS pe_tablav, pe_idregiv
*#/----------------------------------------
*** Función para eliminar los Vinculos de Comprobantes los Asientos de estos
*** que se hayan vinculado con un Recibo u Orden de Pago que se Anula
*#/----------------------------------------
***

	**** Busco los Vinculos Asociados al Comprobante ***
	
	
	vconeccionOp=abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)=" Select v.*, ifnull(a.idasiento,0) as idasiento from vinculocomp v "
	sqlmatriz(2)=" left join asientoscompro a on a.idregicomp = v.idvinculo and a.tabla = 'vinculocomp' "
	sqlmatriz(3)=" where TRIM(tablav) = '"+ALLTRIM(pe_tablav)+"' and idregistrov = "+ ALLTRIM(STR(pe_idregiv))

	verror=sqlrun(vconeccionOp,"vinculoseli_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las opciones de AFIP",0+48+0,"Error")
	    =abreycierracon(vconeccionOp,"")
		RETURN v_opcionesRet
	ENDIF 
	SELECT * FROM vinculoseli_sql INTO TABLE vinculoseli
	
	SELECT vinculoseli_sql  
	USE IN vinculoseli_sql 
	SELECT vinculoseli 
	ALTER table vinculoseli alter COLUMN idasiento n(12)
	GO TOP 
	DO WHILE !EOF()
		*Primero Elimino el Asiento Asociado al Comprobante de Vínculo
		
		IF vinculoseli.idasiento > 0  THEN 

			* Elimino Asiento * 
			sqlmatriz(1)="DELETE FROM asientos WHERE idasiento = " + ALLTRIM(STR(vinculoseli.idasiento))
			verror=sqlrun(vconeccionOp,"asiento1")
			
			* Elimino Asociacion con Comprobantes 
			sqlmatriz(1)="DELETE FROM asientoscompro WHERE idasiento = " + ALLTRIM(STR(vinculoseli.idasiento))
			verror=sqlrun(vconeccionOp,"asiento1")
			
			* Elimino Asociacion con Asientos Agrupados si la Hubiere 
			sqlmatriz(1)="DELETE FROM asientosg WHERE idasiento = " + ALLTRIM(STR(vinculoseli.idasiento))
			verror=sqlrun(vconeccionOp,"asiento1")
			
		ENDIF 

		*Luego elimino el Comprobante de Vínculo
		sqlmatriz(1)=" delete from vinculocomp where idvinculo="+ALLTRIM(STR(vinculoseli.idvinculo))
		verror=sqlrun(vconeccionOp,"vinculoseli_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al Eliminar el Registro del Vinculo",0+48+0,"Error")
		    =abreycierracon(vconeccionOp,"")
			RETURN 
		ENDIF 
			

		SELECT vinculoseli
		SKIP 
	ENDDO 
	 USE IN vinculoseli 

    =abreycierracon(vconeccionOp,"")
	

ENDFUNC 



FUNCTION imprimirTransfEti
PARAMETERS p_idtransfeti
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR MOVIMIENTOS DE ETIQUETAS
* PARAMETROS: p_idtransfeti
*#/----------------------------------------



	v_idtransfe = p_idtransfeti
	
	IF v_idtransfe > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
*!*			*** Busco los datos del recibo
*!*			 sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip,com.comprobante as nomcomp, cd.detalle as ctaDes, co.detalle as ctaOri,d.idtipopago, d.iddetacobro, d.importe as importetp,cpl.descrip as desccpl,tp.detalle as tipopago "
*!*	         sqlmatriz(2)=" FROM transfeti r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba left join tipocompro t on com.idtipocompro = t.idtipocompro"
*!*			sqlmatriz(3)=" left join transfetih h on r.idtraeti = h.idtraeti "
*!*			sqlmatriz(4)=" where r.idcomproba = d.idcomproba and r.idtraeti = "+ALLTRIM(STR(p_idtransfeti))

sqlmatriz(1)=" Select r.idtraeti,r.depositoo,r.depositod,r.numero,r.fecha,r.hora,r.observa,r.idcomproba,r.usuario,et.etiqueta,et.fechaalta,et.codigo,et.articulo,a.detalle as nomarti,a.unidad,a.abrevia,a.codbarra,a.costo,h.idtraetih, pv.puntov, com.tipo, "
sqlmatriz(2)= " com.comprobante as nomcomp, ifnull(d.detalle,'SIN DEPOSITO') as depoori,ifnull(e.detalle,'SALIDA') as depodes "
sqlmatriz(3)=" FROM transfeti r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba left join tipocompro t on com.idtipocompro = t.idtipocompro "
sqlmatriz(4)=" left join transfetih h on r.idtraeti = h.idtraeti left join depositos d on r.depositoo = d.deposito left join depositos e on r.depositod = e.deposito left join etiquetas et on h.etiqueta = et.etiqueta "
sqlmatriz(5)=" left join articulos a on et.articulo = a.articulo and et.tabla = 'articulos' "
sqlmatriz(6)="  where r.idtraeti = "+ALLTRIM(STR(p_idtransfeti))
	
			verror=sqlrun(vconeccionF,"transfeti_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la los movimientos de etiquetas ",0+48+0,"Error")
			    RETURN 
			ENDIF
									
		
		SELECT transfeti_sql 
		GO TOP 
		

				
		SELECT * FROM transfeti_sql INTO TABLE movieti
				
		SELECT movieti
		GO TOP 
	
		IF NOT EOF()
*!*		
*!*				replace ALL desccpl WITH tipopago FOR ISNULL(desccpl) = .T.
*!*				
					
			SELECT movieti
			GO TOP 
			v_idcomproba = movieti.idcomproba
			
			DO FORM reporteform WITH "movieti","movieticr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar los movimientos para imprimir",0+48+0,"Error al cargar los movimientos")
			RETURN 	
		ENDIF 
				

	ELSE
		MESSAGEBOX("NO se pudo recuperar los movimientos el ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


FUNCTION variables_sys
*#/----------------------------------------
*
*#/----------------------------------------
	PARAMETERS p_ec
*!*		v_llave = 20
	IF p_ec = 0 THEN &&encripta

		DISPLAY MEMORY LIKE '_S*' TO FILE varpublicas._v NOCONSOLE 
		CREATE TABLE varpublicas_sys ( variables c(200) )
		APPEND FROM varpublicas._v TYPE SDF 
		DELETE FOR SUBSTR(ALLTRIM(variables),1,2) <> '_S'
		PACK 
		REPLACE ALL variables WITH IIF(AT(' ',ALLTRIM(VARIABLEs))=0,ALLTRIM(variables),SUBSTR(ALLTRIM(variables),1,AT(' ',ALLTRIM(variables))))
		INDEX on variables TAG variable
		p=FCREATE("variables._s1")
		GO TOP 
		DO WHILE !EOF()
			v_var = ALLTRIM(variables)	
			v_linea = ALLTRIM(variables)+"="+IIF(TYPE(v_var)='C','"'+ALLTRIM(&v_var)+'"',ALLTRIM(STR(&v_var,12,2)))
			IF LEN(ALLTRIM(v_linea))<50 THEN 
				FPUTS(p,v_linea)
			ENDIF
			SELECT varpublicas_sys 	
			SKIP 
		ENDDO 
		
		FCLOSE(p)
		v_variables_b64 = STRCONV(FILETOSTR("variables._s1"),13)
		STRTOFILE(v_variables_b64,"variables._c")	
		SELECT varpublicas_sys
		USE IN varpublicas_sys
		DELETE FILE varpublicas_sys.dbf
		DELETE FILE varpublicas_sys.cdx
		DELETE FILE varpublicas._v
		DELETE FILE variables._s1
		RETURN "variables._c"
	ELSE && desencripta
	
		v_variables_pl = STRCONV(FILETOSTR("variables._c"),14)
		STRTOFILE(v_variables_pl ,"variables._s")
	
	ENDIF 
ENDFUNC 



FUNCTION imprimirAjuste
PARAMETERS p_idajuste
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR UN AJUSTE DE STOCK
* PARAMETROS: p_idajuste
*#/----------------------------------------

	v_idajuste = p_idajuste
	IF v_idajuste > 0
	
	
		** Compruebo que no esté anulado
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		


			sqlmatriz(1)="Select p.*,h.*,a.unidad, ifnull(e.apellido,'') as apellEnt, ifnull(e.nombre,'') as nomEnt, ifnull(e.compania,'') as compania, "
			sqlmatriz(2)=" ifnull(e.cuit,'') as cuit, ifnull(e.direccion,'') as direccion, t.ie,t.reporte, d.detalle as detDepo"
			sqlmatriz(3)="  from ajustestockp p left join ajustestockh h on p.idajuste = h.idajuste " 
			sqlmatriz(4)=" 	 left join entidades e on p.entidad = e.entidad "
			sqlmatriz(5)=" left join articulos a on h.articulo = a.articulo "
			sqlmatriz(6)=" left join tipomstock t on h.idtipomov = t.idtipomov "
			sqlmatriz(7)=" left join depositos d on h.deposito = d.deposito "
			sqlmatriz(8)=" where p.idajuste = "+ ALLTRIM(STR(v_idajuste))


			verror=sqlrun(vconeccionF,"ajustestock_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de los ajustes de stock ",0+48+0,"Error")
			    RETURN 
			ENDIF
		
	
	
		

		SELECT * FROM ajustestock_sql INTO TABLE .\ajustockimp

		
		SELECT ajustockimp
		
		IF NOT EOF()
		
			
			DO FORM reporteform WITH "ajustockimp","ajustockcr","ajustestockp"
			
			
		ELSE
			MESSAGEBOX("Error al cargar el movimiento para imprimir",0+48+0,"Error al cargar el movimiento")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar el movimiento de stock ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 
	

ENDFUNC 





FUNCTION ActualizaListasR
PARAMETERS p_ListaP
*#/----------------------------------------
* Funcion de Actualizacion de Listas de Precios Resultados 
* - Calculos de Listas de Precios Finalizadas - 
* - Tablas actualizadas : r_listaprea (contienes precios de articulos finales)
*						  r_listapreb (contiene las listas de precios )
* PARAMETROS: p_ListaP : Si está vacío entonces elimina los registros del Calculo Actual (Vacia las Tablas )
*#/----------------------------------------

	IF !(TYPE("p_ListaP")="C") THEN 
		p_ListaP = ""
	ENDIF 
	
	
	IF !EMPTY(p_ListaP) THEN 
		p_listaPA = ALLTRIM(p_ListaP)+'a'
		p_listaPB = ALLTRIM(p_ListaP)+'b'
		
		vcerrar_locales = .f.
		IF !USED(p_ListaPA) THEN 
			USE &p_ListaPA IN 0
			vcerrar_locales = .t.
		ENDIF 
		IF !USED(p_ListaPB) THEN 
			USE &p_ListaPB IN 0
			vcerrar_locales = .t.
		ENDIF 

		** Abro la Conexión
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		** Elimino si hubiere algún cálculo de Listas de Precios 
		sqlmatriz(1)=" delete from r_listaprea "
		verror=sqlrun(vconeccionF,"r_listaprea")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Listas de Precios Calculadas ",0+48+0,"Error")
		    RETURN 
		ENDIF
		sqlmatriz(1)=" delete from r_listapreb "
		verror=sqlrun(vconeccionF,"r_listapreb")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Listas de Precios Calculadas ",0+48+0,"Error")
		    RETURN 
		ENDIF

		* Cargo el Nuevo Calculo de Listas de Precios A
		SELECT &p_ListaPA
		GO TOP 

		SELECT idlista, detallep, vigedesde, vigehasta, margenp, condvta,  idlistap, actualiza,idlistah, articulo, ;
			detalle, unidad, abrevia, codbarra, costoa, linea, detalinea, idsublinea, sublinea, ctrlstock, ocultar, stockmin, IIF(ISNULL(stocktot),0,stocktot) as stocktot, ;
			desc1, desc2, desc3,  desc4, desc5, reca1, moneda, pcosto, margen, pventa, razonimpu, impuestos, pventatot, fechaact, habilita ;
		from &p_ListaPA INTO TABLE p_listaPACSV
		
		SELECT p_listaPACSV
		p_archivocsv= STRTRAN(_sysestacion,'\','/')+"/p_listaPA"+frandom()+".csv"
		COPY TO &p_archivocsv DELIMITED WITH ";"
		USE IN p_listaPACSV
		
		sqlmatriz(1)=" LOAD DATA LOCAL INFILE '"+p_archivocsv+"'"
		sqlmatriz(2)=" INTO TABLE r_listaprea fields terminated by ',' "
		sqlmatriz(3)=" ENCLOSED BY ';' "
		sqlmatriz(4)=" LINES TERMINATED BY '\r\n' "
*		sqlmatriz(5)=" IGNORE 1 ROWS "

		verror=sqlrun(vconeccionF,"loadlp")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Carga de las Listas de Precios (LOAD DATA ",0+48+0,"Error")
		    RETURN 
		ENDIF

*!*			DIMENSION lamatrizLi(36,2)
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "

		* Cargo el Nuevo Calculo de Listas de Precios B
		SELECT &p_ListaPB
		GO TOP 
		DIMENSION lamatrizLi(7,2)

		DO WHILE !EOF()
		
			lamatrizLi(1,1)='idlistac'
			lamatrizLi(1,2)=ALLTRIM(STR(&p_ListaPB..idlistac))
			lamatrizLi(2,1)='idlista'
			lamatrizLi(2,2)=ALLTRIM(STR(&p_ListaPB..idlista))
			lamatrizLi(3,1)='detalle'
			lamatrizLi(3,2)="'"+ALLTRIM(&p_ListaPB..detalle)+"'"
			lamatrizLi(4,1)='cuotas'
			lamatrizLi(4,2)=ALLTRIM(STR(&p_ListaPB..cuotas))
			lamatrizLi(5,1)='razon'
			lamatrizLi(5,2)=ALLTRIM(STR(&p_ListaPB..razon,13,2))
			lamatrizLi(6,1)='idfinancia'
			lamatrizLi(6,2)=ALLTRIM(STR(&p_ListaPB..idfinancia))
			lamatrizLi(7,1)='habilitado'
			lamatrizLi(7,2)="'"+ALLTRIM(&p_ListaPB..habilitado)+"'"
						

			p_tabla     = 'r_listapreb'
			p_matriz    = 'lamatrizLi'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en Actualizacion de ListaPreB",0+48+0,"Error")
			    RETURN ""
			ENDIF 
		
			SELECT &p_ListaPB
			SKIP 
		ENDDO 		
		
		RELEASE lamatrizLi 
		
		** Cierro la Conexion
		=abreycierracon(vconeccionF,"")	
		
		IF vcerrar_locales = .t. THEN 
			SELE &p_ListaPA
			USE 
			SELE &p_ListaPB
			USE 
		ENDIF 
		

	ELSE && Elimino las Listas Calculadas Guardadas

		** Compruebo que no esté anulado
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		sqlmatriz(1)=" delete from r_listaprea "
		verror=sqlrun(vconeccionF,"r_listaprea")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Listas de Precios Calculadas ",0+48+0,"Error")
		    RETURN 
		ENDIF
		sqlmatriz(1)=" delete from r_listapreb "
		verror=sqlrun(vconeccionF,"r_listapreb")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Listas de Precios Calculadas ",0+48+0,"Error")
		    RETURN 
		ENDIF
		** Cierro la Conexion
		=abreycierracon(vconeccionF,"")	

	
	ENDIF 	

RETURN 


FUNCTION ActuDatosAnexos
PARAMETERS pda_tablatmp, pda_id
*#/----------------------------------------
* Funcion de Actualizacion de DatosAnexos 
* - Calculos de Listas de Precios Finalizadas - 
* - Tablas actualizadas : datosanexo (Contienes Datos Anexos)
* PARAMETROS: pda_tablatmp: Tabla que contiene los Registros a Grabar en datosanexo
*#/----------------------------------------

	IF !(TYPE("pda_tablatmp")="C") THEN 
		pda_tablatmp = ""
	ENDIF 
	
	IF EMPTY(pda_tablatmp) THEN 
		RETURN 
	ENDIF 

	farchivo= ALLTRIM(pda_tablatmp)+".dbf"
	IF file(farchivo) THEN 
		IF !USED(pda_tablatmp) THEN 
			USE &pda_tablatmp IN 0
		ENDIF 	
	ELSE 
		RETURN 
	ENDIF

	SELECT &pda_tablatmp
	replace ALL id WITH pda_id
	GO TOP 
	LOCATE FOR iddatoan = -999999
	vtablaaso = &pda_tablatmp..tabla
	vidaso	  = &pda_tablatmp..id
	
	** Abro la Conexión
	vconeccionACA=abreycierracon(0,_SYSSCHEMA)	
		
	** Elimino si hubiere algún cálculo de Listas de Precios 
	sqlmatriz(1)=" delete from datosanexo where tabla ='"+ALLTRIM(vtablaaso)+"' and id="+STR(vidaso)
	verror=sqlrun(vconeccionACA,"del_datoaso")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Datos Asociados ",0+48+0,"Error")
	    RETURN 
	ENDIF

	SELECT &pda_tablatmp
	GO TOP 
	p_tipoope   = 'I'
	p_condicion = ''
	v_titulo    = " EL ALTA "
	tablaACA     = "datosanexo"
	p_matriz    = 'lamatrizACA'
	DIMENSION lamatrizACA(9,2)

	DO WHILE !EOF()
	
		IF &pda_tablatmp..iddatoan <> -999999 THEN 

			lamatrizACA(1,1)='iddatoan'
			lamatrizACA(1,2)=ALLTRIM(STR(&pda_tablatmp..iddatoan))
			lamatrizACA(2,1)='fecha'
			lamatrizACA(2,2)="'"+ALLTRIM(&pda_tablatmp..fecha)+"'"
			lamatrizACA(3,1)='detalle'
			lamatrizACA(3,2)="'"+&pda_tablatmp..detalle+"'"
			lamatrizACA(4,1)='numero'
			lamatrizACA(4,2)=ALLTRIM(STR(&pda_tablatmp..numero))
			lamatrizACA(5,1)='importe'
			lamatrizACA(5,2)=ALLTRIM(STR(&pda_tablatmp..importe,13,2))
			lamatrizACA(6,1)='tabla'
			lamatrizACA(6,2)="'"+ALLTRIM(&pda_tablatmp..tabla)+"'"
			lamatrizACA(7,1)='id'
			lamatrizACA(7,2)=ALLTRIM(STR(&pda_tablatmp..id))
			lamatrizACA(8,1)='fechab'
			lamatrizACA(8,2)="'"+ALLTRIM(&pda_tablatmp..fechab)+"'"
			lamatrizACA(9,1)='importeb'
			lamatrizACA(9,2)=ALLTRIM(STR(&pda_tablatmp..importeb,13,2))
						
			p_conexion  = vconeccionACA
			IF SentenciaSQL(tablaACA,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en Actualizacion de ListaPreB",0+48+0,"Error")
			    RETURN ""
			ENDIF 
		
		ENDIF 	
	
		SELECT &pda_tablatmp
		SKIP 
	
	ENDDO 
	RELEASE lamatrizACA 
	** Abro la Conexión
	=abreycierracon(vconeccionACA,"")	

	USE IN &pda_tablatmp
	eje = "DELETE FILE "+ALLTRIM(pda_tablatmp)+".dbf"
	&eje
	eje = "DELETE FILE "+ALLTRIM(pda_tablatmp)+".fpt"
	&eje
	
	RETURN 
ENDFUNC 

	

FUNCTION imprimirDetalleAnexo
PARAMETERS p_tablacomp, p_idcomp
*#/----------------------------------------
* FUNCIÓN PARA IMPRIMIR DETALLES ANEXOS DE COMPROBANTES ()
* PARAMETROS: P_IDtabla , P_IDcomp
*#/----------------------------------------

	IF p_idcomp  > 0
		
		
		*** Busco los datos Anexos a Imprimir
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	

		sqlmatriz(1)=" Select * from datosanexo  where tabla='"+ALLTRIM(p_tablacomp)+"' and id = "+ ALLTRIM(STR(p_idcomp))
		verror=sqlrun(vconeccionF,"datosanexo_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de Datos Anexos",0+48+0,"Error")
		ENDIF

	   =abreycierracon(vconeccionF,"")	
	
		vdescribecomp=fdescribecompro(p_tablacomp,"",p_idcomp)
	
		
		SELECT datosanexo_sql 
		GO TOP 
		IF !EOF()
			if  MESSAGEBOX("¿Existen Datos Anexos, Desea Imprimirlos?",4+48+256,"Imprimir Datos Anexos")= 7 THEN 
				USE IN datosanexo_sql
				RETURN 
			ENDIF 
		ENDIF 	
	

		SELECT * FROM datosanexo_sql INTO TABLE .\anexoimpr
		USE IN datosanexo_sql
			
		SELECT anexoimpr
		ALTER table anexoimpr ADD COLUMN describecm c(200)
		REPLACE ALL describecm WITH vdescribecomp 
		GO TOP 
		
		IF NOT EOF()
			
			SELECT anexoimpr
			GO TOP 

			DO FORM reporteform WITH "anexoimpr","anexoimprcr","datosanexo"
		ENDIF 
		USE IN anexoimpr
	ENDIF 

ENDFUNC 





FUNCTION ObtieneCompNoAutoriza
PARAMETERS  para_aliasrnl
*#/----------------------------------------
* Obtiene todos los Comprobantes Electrónicos Pendientes de Autorización
*#/----------------------------------------

p_aliasretorno  = ""

	vconeccionM = abreycierracon(0,_SYSSCHEMA)
		
	sqlmatriz(1)= "SELECT f.idfactura , e.idestador FROM ultimoestado e left join facturas f on e.tabla ='facturas' and e.id = f.idfactura where e.tabla = 'facturas' and ( e.idestador = 3 or e.idestador = 5) "

	verror=sqlrun(vconeccionM ,"fpendiente_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Facturas No Autorizadas ... ",0+48+0,"Error")
	    RETURN p_aliasretorno  
	ENDIF
	=abreycierracon(vconeccionM ,"")	

	SELECT fpendiente_sql
	GO TOP 
	
	IF EOF()
		USE IN fpendiente_sql 
		RETURN p_aliasretorno  
	ENDIF

	
	SELECT idfactura,idestador FROM fpendiente_sql	INTO TABLE &para_aliasrnl WHERE !ISNULL(idfactura)
		
	SELECT fpendiente_sql
	USE IN fpendiente_sql
	p_aliasretorno  = para_aliasrnl
	RETURN para_aliasrnl
ENDFUNC 





FUNCTION FUpdatesys
*#/----------------------------------------
*-----------------------------------------------------------------------------------
* Chequea si existe alguna Actualización Nueva para descargar por FTP 
* Retorna 1 si existe actualización o 0 Si no existen versiones nuevas
*-----------------------------------------------------------------------------------
*#/----------------------------------------

	 p_updretorno  = 0
	 IF !(SUBSTR(ALLTRIM(UPPER(_SYSFTPUPDATE))+'   ',1,3)=='S/A') AND !(SUBSTR(ALLTRIM(UPPER(_SYSFTPUPDATE))+'    ',1,3)=='N/A') AND !EMPTY(ALLTRIM(_SYSFTPUPDATE))  THEN 
 
	  	  =ALINES(ARRFTP,_SYSFTPUPDATE,1,';',' ')
		IF ping(ALLTRIM(ARRFTP(1))) = .f. THEN 
			RELEASE ARRFTP 
			RETURN 0
		ENDIF 
	  	oFTp = .NULL.
	  	oFTP = CreateObject("CLASE_FTP")
	  
	  	IF Vartype(oFTP) == "O" THEN
	  	
*	  	  =ALINES(ARRFTP,_SYSFTPUPDATE,1,';',' ')
	  	
	      oFTP.cServidorFTP   = ARRFTP(1)
	      oFTP.cPuertoNro     = ARRFTP(2)
	      oFTP.cNombreUsuario = ARRFTP(3)
	      oFTP.cContrasena    = ARRFTP(4)
	      oFTP.CONECTAR_SERVIDOR_FTP()

		  IF Empty(oFTP.cMensajeError) THEN
			      	
					LOCAL lcNombreArchivoLocal, lcNombreArchivoRemoto
					lcCarpetaRemota = IIF((EMPTY(ALLTRIM(ARRFTP(5))) OR ALLTRIM(ARRFTP(5))=='/'),'/','/'+ALLTRIM(ARRFTP(5))+'/') 
					lcNombreArchivoRemoto = lcCarpetaRemota+STRTRAN(LOWER(ALLTRIM(JUSTFNAME(SYS(16,1)))),'.exe','ver.txt')
					lcNombreArchivoLocal  = STRTRAN(LOWER(ALLTRIM(JUSTFNAME(SYS(16,1)))),'.exe','ver.000')
					eje = "DELETE FILE '"+ STRTRAN(LOWER(ALLTRIM(JUSTFNAME(SYS(16,1)))),'.exe','ver.000')+"'"
					&eje

					 oFTP.RECIBIR_ARCHIVO_REMOTO(lcNombreArchivoRemoto, lcNombreArchivoLocal, .T.)     && .T. significa que ocurrirá un error si el archivo ya existe
					 IF Empty(oFTp.cMensajeError) THEN

							PUNTERO = FOPEN(lcNombreArchivoLocal,0)
							IF PUNTERO > 0 THEN
								n_version =  ALLTRIM(FGETS(PUNTERO))
								IF !EMPTY(n_version) THEN 
									IF  VAL(ALLTRIM(STRTRAN(n_version,'.','0'))) > VAL(ALLTRIM(STRTRAN(_SYSVERSION,'.','0'))) THEN 
										p_updretorno= 1
									ENDIF 
								ENDIF 
							ENDIF
							=FCLOSE(PUNTERO)
							PUNTERO = 0 
					 ENDIF
		   ENDIF
		   oFTP.DESCONECTAR_SERVIDOR_FTP()
	    	
	  	ENDIF
	 
	 ENDIF 

  	oFTp = .NULL.
	RELEASE oFTp
	RETURN p_updretorno
ENDFUNC 



FUNCTION ping
PARAMETERS tcIpNumber 
**********************************
DECLARE INTEGER ShellExecute IN shell32.dll ; 
INTEGER hndWin, ; 
STRING cAction, ; 
STRING cFileName, ; 
STRING cParams, ;  
STRING cDir, ; 
INTEGER nShowWin

local lcCMD, lcParas, lcping, lctmp
DECLARE Sleep IN Win32API INTEGER

lctmp = ALLTRIM(STRTRAN(SUBSTR(STR((RAND(-1)*1000)),2),'','0'))

lcCmd = 'ping -n 1 -w 2 '+tcIpNumber+' > '   && command to Execute 
lcParas = FULLPATH(CURDIR())+'ping'+lctmp+'.tcp '   && Extra parameter to pass your command 
 * --- Execute the command.
****   shellExecute last parameter 0  will hide DOS window
***  If you want to show DOS window change it to value  1 

ShellExecute(0,'open','cmd', '/C'+lcCmd+' '+lcParas, '',0)
sleep(2000)  && delay time to come  back
lcping=FILETOSTR(lcParas)
 *** sleep value  can be reduced according to your need
CLEAR DLLS ShellExecute
DELETE FILE &lcParas
* --- Return to caller.
IF ATC('recibidos = 1,',lcping) = 0 then 
	RETURN .f.
ELSE
	RETURN .t. 
ENDIF 
ENDFUNC



FUNCTION FCumpleNP
param cnp_idnp, cnp_tipo
*#/----------------------------------------
*******************************************
** Cumplimenta las OT Pendientes en una Nota de Pedido
** Parámetros:
*	cnp_idnp  : Nota de Pedido para la cual cancelar las OT
*   cnp_tipo: Tipo de articulos a cumplir, puede ser sobre articulos o materiales
*		 0 : Articulos, 1: Materiales , 2: Todos
*******************************************
*#/----------------------------------------

	cnp_condicion = " where ot.idnp = "+ALLTRIM(str(cnp_idnp))+" and p.pendiente > 0 "+IIF(cnp_tipo=0," and ot.idmate = 0 ","" )+IIF(cnp_tipo=1," and ot.idmate > 0 ","")

	vconeccionNP = abreycierracon(0,_SYSSCHEMA)
		
	sqlmatriz(1)= " SELECT ot.idot, ot.articulo, ot.detalle, ot.idmate, ot.cantidad as cantiot,ot.cantidadfc, p.pendiente as pendiente,  "
	sqlmatriz(2)= " np.puntov, np.numero as numeronp, np.entidad, np.nombre, np.fecha "
	sqlmatriz(3)= " FROM ot left join otpendientes p on ot.idot = p.idot "
	sqlmatriz(4)= " left join np on np.idnp = ot.idnp " +cnp_condicion 
	verror=sqlrun(vconeccionNP ,"npcumplir_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de OT a Cancelar ... ",0+48+0,"Error")
	    RETURN .F.
	ENDIF
	

	sqlmatriz(1)=" SELECT c.idcomproba, a.pventa FROM comprobantes c "
	sqlmatriz(2)=" LEFT JOIN compactiv a ON a.idcomproba = c.idcomproba "
	sqlmatriz(4)=" WHERE c.tabla = 'cumplimentap' " 
	verror=sqlrun(vconeccionNP ,"comprocump_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Comprobantes a Cumplir ... ",0+48+0,"Error")
	    RETURN .F.
	ENDIF	
	

	SELECT npcumplir_sql
	GO TOP 	
 	IF EOF()
		USE IN npcumplir_sql
		USE IN comprocump_sql
		RETURN .F.
	ENDIF

****************************************************************************
	DIMENSION lamatriz1(10,2)
	DIMENSION lamatriz2(7,2)


	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
				
	cnp_idcump		= 0
	cnp_idcomproba	= comprocump_sql.idcomproba
	cnp_pventa		= comprocump_sql.pventa
	cnp_numero		= maxnumerocom(cnp_idcomproba,cnp_pventa ,1)
	cnp_observa = ALLTRIM(npcumplir_sql.puntov)+'-'+STRTRAN(STR(npcumplir_sql.numeronp,8),' ','0')+'   '+ALLTRIM(STR(npcumplir_sql.entidad))+'-'+ALLTRIM(npcumplir_sql.nombre)+' '+ALLTRIM(npcumplir_sql.fecha)
				
	lamatriz1(1,1)='idcump'
	lamatriz1(1,2)= ALLTRIM(STR(cnp_idcump))
	lamatriz1(2,1)='idcomproba'
	lamatriz1(2,2)= ALLTRIM(STR(cnp_idcomproba))
	lamatriz1(3,1)='pventa'
	lamatriz1(3,2)= ALLTRIM(STR(cnp_pventa))
	lamatriz1(4,1)='fecha'
	lamatriz1(4,2)="'"+DTOS(DATE())+"'"
	lamatriz1(5,1)='responsab'
	lamatriz1(5,2)="'"+ALLTRIM(_SYSUSUARIO)+"'"
	lamatriz1(6,1)='observa1'
	lamatriz1(6,2)="'"+cnp_observa+"'"
	lamatriz1(7,1)='observa2'
	lamatriz1(7,2)="''"
	lamatriz1(8,1)='observa3'
	lamatriz1(8,2)="''"
	lamatriz1(9,1)='observa4'
	lamatriz1(9,2)="''"
	lamatriz1(10,1)='numero'
	lamatriz1(10,2)=alltrim(STR(cnp_numero))


	p_tabla     = 'cumplimentap'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionNP
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajuste)),0+48+0,"Error")
	    RETURN .F. 
	ENDIF  

	sqlmatriz(1)=" select last_insert_id() as maxid "
	verror=sqlrun(vconeccionNP,"ultimoId")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
		=abreycierracon(vconeccionNP,"")	
		USE IN npcumplir_sql
		USE IN comprocump_sql
		RETURN .F.
	ENDIF 
	SELECT ultimoId
	GO TOP 
	v_idcompro_Ultimo = VAL(ultimoId.maxid)
	USE IN ultimoId
	cnp_idcump= v_idcompro_Ultimo
				
	SELECT 	npcumplir_sql
	GO TOP 				
	DO WHILE !EOF()

			IF !EMPTY(npcumplir_sql.articulo) AND npcumplir_sql.pendiente > 0 THEN 

				v_idcumph = 0						
				lamatriz2(1,1)='idcumph'
				lamatriz2(1,2)=ALLTRIM(STR(v_idcumph))
				lamatriz2(2,1)='idcump'
				lamatriz2(2,2)=ALLTRIM(STR(cnp_idcump))
				lamatriz2(3,1)='articulo'
				lamatriz2(3,2)="'"+ALLTRIM(npcumplir_sql.articulo)+"'"
				lamatriz2(4,1)='detalle'
				lamatriz2(4,2)="'"+alltrim(npcumplir_sql.detalle)+"'"
				lamatriz2(5,1)='cantidad'
				lamatriz2(5,2)=alltrim(STR(npcumplir_sql.pendiente,10,2))
				lamatriz2(6,1)='cantidaduf'
				lamatriz2(6,2)=alltrim(STR(npcumplir_sql.cantidadfc,10,2))
				lamatriz2(7,1)='idot'
				lamatriz2(7,2)=alltrim(STR(npcumplir_sql.idot,10,2))
						
				p_tabla     = 'cumplimentah'
				p_matriz    = 'lamatriz2'
				p_conexion  = vconeccionNP
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idcumph)),0+48+0,"Error")	
				    RETURN .F.						 
				ENDIF						
					
			ENDIF

		SELECT npcumplir_sql
		SKIP 
	ENDDO 
*****************************************************************************	

USE IN npcumplir_sql
USE IN comprocump_sql

RELEASE lamatriz1
RELEASE lamatriz2

registrarEstado("cumplimentap","idcump",cnp_idcump,'I',"AUTORIZADO")
					

* me desconecto	
=abreycierracon(vconeccionNP,"")

RETURN .T.

**********************************************************************************



FUNCTION FIinsertaOT
PARAMETERS  ins_idnp, ins_tabla
*#/----------------------------------------
*******************************************
** Inserta OT en una Nota de Pedido
** Parámetros:
*	ins_idnp   : Nota de Pedido a la cual insertar las OT
*   ins_tabla: Tabla que contiene los articulos o materiales a insertar en a NP
*		 Estructura : articulo c(20), idmate I, cantidad n(10,2)
*******************************************
*#/----------------------------------------

	IF !(TYPE("ins_tabla")="C") THEN 
		ins_tabla= ""
	ENDIF 
	
	IF EMPTY(ins_tabla) THEN 
		RETURN .f.
	ENDIF 

	farchivo= ALLTRIM(ins_tabla)+".dbf"
	IF file(farchivo) THEN 
		IF !USED(ins_tabla) THEN 
			USE &ins_tabla IN 0
		ENDIF 	
	ELSE 
		RETURN .f.
	ENDIF

	SELECT &ins_tabla
	GO TOP 
	IF EOF() THEN 
		USE IN &ins_tabla 
		RETURN .f.
	ENDIF 


	vconeccionNP = abreycierracon(0,_SYSSCHEMA)
		
	sqlmatriz(1)= " SELECT * from np where idnp = "+ALLTRIM(str(ins_idnp))
	verror=sqlrun(vconeccionNP ,"npreceptora_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de NP Receptora ... ",0+48+0,"Error")
	    RETURN .f.
	ENDIF

	SELECT npreceptora_sql
	GO TOP 	
 	IF EOF()
		USE IN npreceptora_sql
		USE IN &ins_tabla
		= abreycierracon(vconeccionNP,"")
		RETURN .f.
	ENDIF

	DIMENSION lamatriz2(19,2)
	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
				
	SELECT &ins_tabla 
	GO TOP 				
	DO WHILE !EOF()

			IF !EMPTY(&ins_tabla..articulo) AND &ins_tabla..cantidad > 0 THEN 

				
				IF &ins_tabla..idmate = 0 THEN 
					sqlmatriz(1)= " SELECT detalle, unidad  from  articulos where articulo = '"+ALLTRIM(&ins_tabla..articulo)+"'"
				ELSE
					sqlmatriz(1)= " SELECT detalle, unidad  from  otmateriales where codigomat = '"+ALLTRIM(&ins_tabla..articulo)+"' and idmate = "+ALLTRIM(str(&ins_tabla..idmate))
				ENDIF 
				verror=sqlrun(vconeccionNP ,"detalleot_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Detalle para la Ot... ",0+48+0,"Error")
				    RETURN .f.
				ENDIF
				
				SELECT detalleot_sql
				GO TOP 
				IF !EOF() THEN 

					ins_id_ot = maxnumeroidx("idot","I","ot",1)
					ins_idtipoot	= 1 
					ins_articulo 	= &ins_tabla..articulo
					ins_idmate		= &ins_tabla..idmate
						
					ins_detalle 	= detalleot_sql.detalle
					ins_unidad 		= detalleot_sql.unidad
					ins_unidadFC 	= detalleot_sql.unidad
					ins_fechaentre	= DTOS(DATE())
						
					ins_cantidad 	= &ins_tabla..cantidad
					ins_unitario 	= 0.00		
					ins_observa		= "OT Insertada a petición"
					ins_cantidadFC  = 0.00
					ins_impuestos	= 0.00
					ins_impuesto	= 0.00
					ins_neto		= 0.00
					ins_razonimp	= 0.00
					ins_total		= 0.00
					ins_idtiponpot  = IIF(&ins_tabla..idmate=0,1,2)
						

					ins_idimpuesto 	= 0
					lamatriz2(1,1)='idnp'
					lamatriz2(1,2)=ALLTRIM(STR(ins_idnp))
					lamatriz2(2,1)='idot'
					lamatriz2(2,2)=ALLTRIM(STR(ins_id_ot))
					lamatriz2(3,1)='idtipoot'
					lamatriz2(3,2)=ALLTRIM(STR(ins_idtipoot))
					lamatriz2(4,1)='articulo'
					lamatriz2(4,2)="'"+ALLTRIM(ins_articulo)+"'"
					lamatriz2(5,1)='detalle'
					lamatriz2(5,2)= "'"+ALLTRIM(ins_detalle)+"'"
					lamatriz2(6,1)='cantidad'
					lamatriz2(6,2)=ALLTRIM(STR(ins_cantidad,13,4))
					lamatriz2(7,1)='unidad'
					lamatriz2(7,2)="'"+alltrim(ins_unidad )+"'"
					lamatriz2(8,1)='unitario'
					lamatriz2(8,2)=ALLTRIM(STR(ins_unitario,13,4))
					lamatriz2(9,1)='observa'
					lamatriz2(9,2)="'"+ALLTRIM(ins_observa)+"'"
					lamatriz2(10,1)='fechaentre'
					lamatriz2(10,2)="'"+ALLTRIM(ins_fechaentre)+"'"
					lamatriz2(11,1)='cantidadfc'
					lamatriz2(11,2)=ALLTRIM(STR(ins_cantidadFC ,13,4))
					lamatriz2(12,1)='unidadfc'
					lamatriz2(12,2)="'"+ALLTRIM(ins_unidadFC )+"'"
					lamatriz2(13,1)='impuestos'
					lamatriz2(13,2)=ALLTRIM(STR(ins_impuestos,13,4))
					lamatriz2(14,1)='total'
					lamatriz2(14,2)=ALLTRIM(STR(ins_total,13,4))
					lamatriz2(15,1)='impuesto'
					lamatriz2(15,2)=ALLTRIM(STR(ins_idimpuesto))
					lamatriz2(16,1)='razonimp'
					lamatriz2(16,2)=ALLTRIM(STR(ins_razonImp,13,4))
					lamatriz2(17,1)='neto'
					lamatriz2(17,2)=ALLTRIM(STR(ins_neto,13,4))
					lamatriz2(18,1)='idmate'
					lamatriz2(18,2)=ALLTRIM(STR(ins_idmate))
					lamatriz2(19,1)='idtiponp'
					lamatriz2(19,2)=ALLTRIM(STR(ins_idtiponpot))

					p_tabla     = 'ot'
					p_matriz    = 'lamatriz2'
					p_conexion  = vconeccionNP
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(ins_idnp)),0+48+0,"Error")
					    RETURN .f.
					ENDIF
						
				ENDIF 					
				USE IN detalleot_sql
			ENDIF

		SELECT &ins_tabla 
		SKIP 
	ENDDO 
	
*****************************************************************************	
USE IN npreceptora_sql
USE IN &ins_tabla 
RELEASE lamatriz2


* me desconecto	
=abreycierracon(vconeccionNP,"")

RETURN .T.

**********************************************************************************

FUNCTION FVinculaOTNP
PARAMETERS  pv_idot, pv_idnp, pv_operacion 
*#/----------------------------------------
*******************************************
** Vincula la OT del Módulo de Ordenes de Trabajo con las Notas de Pedidos de Clientes
** Parametros:
** 				pv_idot = idot de la orden de trabajo de Producción
**				pv_idnp = idnp de la Nota de Pedido a Vincular con la OT
** 				pv_operacion=  1: Vincula la OT con la Nota de Pedido -  2: Cumple los materiales de la NP asociada a la OT
*******************************************
*#/----------------------------------------

IF pv_operacion = 1 THEN 	&& Vinculacion OT con NP

	* Chequeo que ya no existe vínculo entre OT y NP, ambocs no tienen que tener vínculos ya ingresados
	vconeccionON = abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)= " SELECT * from otnp where idot = "+ALLTRIM(str(pv_idot))+" or idnp = "+ALLTRIM(str(pv_idnp))
	verror=sqlrun(vconeccionON ,"chkotnp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de OTNP ... ",0+48+0,"Error")
	    RETURN 
	ENDIF

	SELECT chkotnp_sql
	GO TOP 	
 	IF !EOF()
		MESSAGEBOX("No se Puede Realizar el Vínculo, Los Registros ya tienen Vínculos Establecidos...")
		USE IN chkotnp_sql
		= abreycierracon(vconeccionON,"")
		RETURN .f. 
	ENDIF


	* Verifico si la OT tiene Materiales para Vincular con las Notas de Pedidos, si no los tiene No vincula
	sqlmatriz(1)= " SELECT d.codigomat as articulo, d.idmate, d.cantidad  from otdetaot d "
	sqlmatriz(2)= " left join otmateriales m on m.idmate = d.idmate "
	sqlmatriz(3)= " where d.idot = "+ALLTRIM(str(pv_idot))+" and m.idtipomate = 1 and m.ctrlstock = 'S' "
	verror=sqlrun(vconeccionON ,"chkmate_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de otdetaot ... ",0+48+0,"Error")
	    RETURN .f.
	ENDIF

	SELECT chkmate_sql
	GO TOP 	
 	IF EOF()
		MESSAGEBOX("No se Puede Realizar el Vínculo, No Hay Materiales en la Orden de Trabajo ...")
		USE IN chkmate_sql
		= abreycierracon(vconeccionON,"")
		RETURN .f.
	ENDIF
	
	* Continuo con la Vinculación porque ambos OT Y NP no tienen vínculos establecidos, y la OT Tiene Materiales Cargados
	
	SELECT * FROM chkmate_sql INTO TABLE materialesot
	SELECT materialesot
	ALTER table materialesot alter COLUMN articulo c(20)
	ALTER table materialesot alter COLUMN idmate   i
	ALTER table materialesot alter COLUMN cantidad n(10,2)
	
	USE IN chkmate_sql
	USE IN materialesot 

	*- Inserto el registro de vinculo en la tabla OTNP
	DIMENSION lamatriz1(4,2)
	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
	
	v_idotnp = 0						
	lamatriz1(1,1)='idotnp'
	lamatriz1(1,2)=ALLTRIM(STR(v_idotnp))
	lamatriz1(2,1)='idot'
	lamatriz1(2,2)=ALLTRIM(STR(pv_idot))
	lamatriz1(3,1)='idnp'
	lamatriz1(3,2)=ALLTRIM(STR(pv_idnp))
	lamatriz1(4,1)='fecha'
	lamatriz1(4,2)="'"+alltrim(DTOS(DATE()))+"'"
						
	p_tabla     = 'otnp'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionON 
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idotnp)),0+48+0,"Error")	
	    RETURN 	.T.					 
	ENDIF						
	=abreycierracon(vconeccionON,"")
	*- Fin de la Insercion
	
	*- Cumplir los Materiales Existentes en la Nota de Pedido para Cancelar el Pendiente
	=FCumpleNP(pv_idnp,1)

	*- Agrega los Materiales de la OT a la Nota de Pedido
	=FIinsertaOT (pv_idnp, "materialesot" )


ELSE 						&& Cierre y Finalización de OT, Cumple los materiales de la NP

	* Chequeo que ya no existea vínculo entre OT y NP, ambos no tienen que tener vínculos ya ingresados
	vconeccionON = abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)= " SELECT * from otnp where idot = "+ALLTRIM(str(pv_idot))
	verror=sqlrun(vconeccionON ,"chkotnp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de OTNP ... ",0+48+0,"Error")
	    RETURN .f.
	ENDIF

	SELECT chkotnp_sql
	GO TOP 	
 	IF EOF()  && no Hago nada , no hay vínculos de OT con ninguna Nota de Pedido
		USE IN chkotnp_sql
		= abreycierracon(vconeccionON,"")
		RETURN .t.
	ENDIF
	=abreycierracon(vconeccionON,"")
	
	*- Debo Cumplir los Materiales de la Nota de Pedido Asociada
	vp_idnp = chkotnp_sql.idnp 
	USE IN chkotnp_sql 
	=FCumpleNP(vp_idnp,1)

ENDIF 

RETURN .t. 



FUNCTION FTranfiereEti
param trp_iddepoo, trp_iddepod, trp_tablaeti, trp_fecha

*#/----------------------------------------
*******************************************
** Carga un Comprobante de Transferencia de Etiquetas entre depósitos
** Recibe las etiquetas y el deposito de origen y destino, chequea que estén
** en origen y transfiere solo las que están en deposito de origen o no ingresadas
** Parámetros:
*	trp_iddepoo : Id del depósito de origen
*   trp_iddepod : Id del depósito de destino
*	trp_tablaeti: Tabla con las etiquetas a transferir
*   trp_fecha   : Fecha para la Transferencia
*  Retorna el Numero de Transferencia de Etiqueta o 0 si no la pudo hacer
*******************************************
*#/----------------------------------------

	IF !(TYPE("trp_tablaeti")="C") THEN 
		trp_tablaeti= ""
	ENDIF 
	
	IF EMPTY(trp_tablaeti) THEN 
		RETURN 0
	ENDIF 

	farchivo= ALLTRIM(trp_tablaeti)+".dbf"
	IF file(farchivo) THEN 
		IF !USED(trp_tablaeti) THEN 
			USE &trp_tablaeti IN 0
		ENDIF 	
	ELSE 
		RETURN 0
	ENDIF

	SELECT &trp_tablaeti
	GO TOP 
	IF EOF() THEN 
		USE IN &trp_tablaeti 
		RETURN 0
	ENDIF 


	* me conecto a la base de datos
	vconeccionTR=abreycierracon(0,_SYSSCHEMA)	

	IF trp_iddepoo > 0 THEN 
		sqlmatriz(1)=" select * from ultmoveti where depositod = "+str(trp_iddepoo)
	ELSE 
		sqlmatriz(1)=" select * from ultmoveti "	
	ENDIF 
	verror=sqlrun(vconeccionTR,"ultmoveti_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error al Los Ultimos movimientos de Etiquetas ",0+48+0,"Error")
	    RETURN 0
	ENDIF

	IF trp_iddepoo > 0 THEN 
		SELECT etiqueta FROM &trp_tablaeti INTO TABLE etiquetasTR WHERE etiqueta 	 in ( SELECT etiqueta FROM ultmoveti_sql  )
	ELSE
		SELECT etiqueta FROM &trp_tablaeti INTO TABLE etiquetasTR WHERE etiqueta NOT in ( SELECT etiqueta FROM ultmoveti_sql )	
	ENDIF 
	USE IN &trp_tablaeti
	USE IN ultmoveti_sql 

	SELECT etiquetasTR
	GO TOP 
	IF EOF () THEN && NO HAY Etiquetas para Transferir		
		USE IN etiquetasTR
		=abreycierracon(vconeccionTR,"")	
		RETURN 0
	ENDIF 

	sqlmatriz(1)=" SELECT c.idcomproba, a.pventa FROM comprobantes c "
	sqlmatriz(2)=" LEFT JOIN compactiv a ON a.idcomproba = c.idcomproba "
	sqlmatriz(4)=" WHERE c.tabla = 'transfeti' " 
	verror=sqlrun(vconeccionTR ,"comprocump_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Comprobantes a Cumplir ... ",0+48+0,"Error")
	    RETURN .F.
	ENDIF	
	
	SELECT comprocump_sql
	GO TOP 
	IF EOF () THEN && NO HAY Etiquetas para Transferir		
		USE IN comprocump_sql
		USE IN etiquetasTR
		=abreycierracon(vconeccionTR,"")	
		RETURN 0
	ENDIF 

****************************************************************************
	trp_idcomproba	= comprocump_sql.idcomproba
	trp_pventa		= comprocump_sql.pventa
	trp_numero		= maxnumerocom(trp_idcomproba,trp_pventa ,1)
	USE IN comprocump_sql 

	DIMENSION lamatriz1(10,2)
	DIMENSION lamatriz2(3,2)
	v_errores = .F.
	

	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "
	
	v_idtraeti 	= 0	
	v_depositoo	=  trp_iddepoo
	v_depositod =  trp_iddepod

	v_numero = trp_numero
	v_fecha  = trp_fecha
	v_hora = TIME()
	v_observa = "Transferencia Automática"
	v_pventa  = trp_pventa
	v_usuario = _SYSUSUARIO

	lamatriz1(1,1)='idtraeti'
	lamatriz1(1,2)= ALLTRIM(STR(v_idtraeti))
	lamatriz1(2,1)='depositoo'
	lamatriz1(2,2)= ALLTRIM(STR(v_depositoo))
	lamatriz1(3,1)='depositod'
	lamatriz1(3,2)= ALLTRIM(STR(v_depositod))
	lamatriz1(4,1)='numero'
	lamatriz1(4,2)= ALLTRIM(STR(v_numero))
	lamatriz1(5,1)='fecha'
	lamatriz1(5,2)="'"+ALLTRIM(v_fecha)+"'"
	lamatriz1(6,1)='hora'
	lamatriz1(6,2)="'"+ALLTRIM(v_hora)+"'"
	lamatriz1(7,1)='observa'
	lamatriz1(7,2)="'"+ALLTRIM(v_observa)+"'"
	lamatriz1(8,1)='idcomproba'
	lamatriz1(8,2)=ALLTRIM(STR(trp_idcomproba))
	lamatriz1(9,1)='pventa'
	lamatriz1(9,2)=ALLTRIM(STR(trp_pventa))
	lamatriz1(10,1)='usuario'
	lamatriz1(10,2)="'"+ALLTRIM(v_usuario)+"'"

	p_tabla     = 'transfeti'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionTR
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idtraeti)),0+48+0,"Error")
	    v_errores = .T.
	    RETURN 
	ENDIF  

	*** Ultimo ID registrado ***
	sqlmatriz(1)="SELECT last_insert_id() as maxid "
	verror=sqlrun(vconeccionF,"tranmax_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID de cajaie",0+48+0,"Error")
	     v_errores = .T.
	     RETURN 0
	ENDIF 
	SELECT tranmax_sql
	GO TOP 
	v_idtraeti = VAL(tranmax_sql.maxid)
	USE IN tranmax_sql
	
	*** INSERTO detalle ***			

	IF v_errores = .F.

		SELECT etiquetasTR
		GO TOP 

		DO WHILE NOT EOF()
			IF etiquetasTR.etiqueta > 0
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "

				v_idtraetih = 0
				v_etiqueta = etiquetasTR.etiqueta
				
				lamatriz2(1,1)='idtraetih'
				lamatriz2(1,2)=ALLTRIM(STR(v_idtraetih))
				lamatriz2(2,1)='etiqueta'
				lamatriz2(2,2)=ALLTRIM(STR(v_etiqueta))
				lamatriz2(3,1)='idtraeti'
				lamatriz2(3,2)=ALLTRIM(STR(v_idtraeti))

				p_tabla     = 'transfetih'
				p_matriz    = 'lamatriz2'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_idajusteh )),0+48+0,"Error")
							  
				ENDIF						
				
			ENDIF

			SELECT etiquetasTR
			SKIP 1
		ENDDO	

		*** REGISTRO estado activo ***
		IF  v_errores = .T.
			registrarEstado("transfeti","idtraeti",v_idtraeti,"I","ANULADO")	
		ELSE
			registrarEstado("transfeti","idtraeti",v_idtraeti,"I","ACTIVO")	
		ENDIF 

	ENDIF 
	SELECT etiquetasTR
	USE IN etiquetasTR
	
	RELEASE lamatriz1
	RELEASE lamatriz2

	* me desconecto	
	=abreycierracon(vconeccionTR,"")

RETURN v_idtraeti






FUNCTION FMueveEtiAjusteST
PARAMETERS pa_idajuste
*#/----------------------------------------
*******************************************
** Selecciona las Etiquetas de Un Ajuste de Stock para Transferirla segun los movimientos de Depósitos
** Parámetros:
*	pa_idajuste: Id del Ajuste de Stock
*  Retorna el id del movimiento de transferencia realizado o 0 si no lo pudo hacer
*******************************************
*#/----------------------------------------

	*** Si Generó Etiquetas y las Ingreso a depósito, debo generar una transferencia de estas hacia el deposito ingresado

	* me conecto a la base de datos
	vconeccionAJ=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)=" select e.etiqueta, h.deposito, t.ie , p.fecha, ifnull(u.depositoo,0) as ultdepoo, ifnull(u.depositod,0) as ultdepod from ajustestocke e left join ajustestockh h on h.idajusteh = e.idajusteh  left join tipomstock t on t.idtipomov = h.idtipomov "
	sqlmatriz(2)=" left join ajustestockp p on p.idajuste = h.idajuste left join ultmoveti u on u.etiqueta = e.etiqueta "
	sqlmatriz(3)=" where h.idajuste = "+STR(pa_idajuste)
	verror=sqlrun(vconeccionF,"etique_tran_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Etiquetas para Transferir",0+48+0,"Error")
		=abreycierracon(vconeccionAJ,"")
		RETURN 0	
	ENDIF 
	=abreycierracon(vconeccionAJ,"")
	SELECT etique_tran_sql
	GO TOP 
	v_retoidtran = 0
	IF !EOF() THEN 
		SELECT etiqueta, IIF(upper(ie) = 'I',0,deposito) as depositoo, IIF(upper(ie) = 'I',deposito,0) as depositod, fecha, ultdepoo, ultdepod  FROM etique_tran_sql  INTO TABLE etiquetran
		ALTER table etiquetran alter COLUMN ultdepoo i
		ALTER table etiquetran alter COLUMN ultdepod i		
		vt_iddepoo = etiquetran.ultdepod
		vt_iddepod = etiquetran.depositod
		vt_tablaeti = 'etiquetran'
		vt_fecha 	= etiquetran.fecha 
		USE IN etiquetran 
		v_retoidtran = FTranfiereEti (vt_iddepoo, vt_iddepod, vt_tablaeti, vt_fecha )
	
	ELSE 
	
		USE IN etique_tran_sql 
		RETURN 0
		
	ENDIF 
	USE IN etique_tran_sql 
	RETURN v_retoidtran
ENDFUNC 




FUNCTION FGeneraAsoc
PARAMETERS cp_idcomprobao, cp_id
*#/----------------------------------------
*******************************************
** Chequea que se puedan Generar Comprobantes Asociados para el Comprobante pasado como parametros 
** Parámetros:
*	cm_idcomprobao: Id del Comprobante Guardado a partir del cual se generará el Comprobante Relacionado
*   cm_id: id del comprobante origen 
*   Observacion : El comprobante Asociado se obtiene de la variable _SYSCMPASOC
*******************************************
*#/----------------------------------------

	IF EMPTY(_SYSCMPASOC) OR SUBSTR((_SYSCMPASOC+' '),1,1)='N' THEN 
		RETURN ""
	ENDIF 
	nFilas = ALINES(ArrCompro, _syscmpasoc , ";")
	IF nFilas = 0 THEN 
		RETURN "" 
	ENDIF 
	
	v_retornacompro = ""
	FOR iarr =1 TO nfilas 
		v_idc1 = INT(VAL(SUBSTR(ArrCompro(iarr ),1,(ATC('-',arrCompro(iarr ))-1))))
		v_idc2 = INT(VAL(SUBSTR(ArrCompro(iarr ),(ATC('-',arrCompro(iarr ))+1))))
			
		IF cp_idcomprobao = v_idc1 THEN && tiene comprobante asociado
			IF v_idc2 > 0 THEN 
			** Genera el Comprobante Asociado **
				v_idcmpge = 0 
				v_idcmpge = FGeneraCmpAsoc (cp_idcomprobao, cp_id, v_idc2) && Llama a la Generación del Comprobante Asociado
				IF v_idcmpge > 0 THEN 
						v_retornacompro = ALLTRIM(v_retornacompro)+ALLTRIM(STR(v_idc2))+'-'+ALLTRIM(STR(v_idcmpge))+';'
				ENDIF 
			
			ENDIF 
		ENDIF 
	
	ENDFOR 
	
	IF !EMPTY(v_retornacompro) THEN 
		v_retornacompro= SUBSTR(v_retornacompro,1,LEN(v_retornacompro)-1)
	ENDIF 
	RETURN v_retornacompro 
ENDFUNC 



FUNCTION FGeneraCmpAsoc
PARAMETERS cmp_idcomprobao, cmp_id, cmp_idcomprobad
*#/----------------------------------------
*******************************************
** Genera Comprobantes Asociados a partir de uno dado
** Parámetros:
*	cm_idcomprobao: Id del Comprobante Guardado a partir del cual se generará el Comprobante Relacionado
*   cm_id: id del comprobante origen 
*	cm_idcomprobad: Id del Comprobante que Generará 
*   Observacion : El comprobante Asociado se obtiene de la variable _SYSCMPASOC
*******************************************
*#/----------------------------------------


	* me conecto a la base de datos
	vconeccionCM=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)=" select tabla, idcomproba from comprobantes "
	sqlmatriz(3)=" where idcomproba = "+STR(cmp_idcomprobao)+" or idcomproba = "+STR(cmp_idcomprobad)
	verror=sqlrun(vconeccionCM,"comprobantes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Comprobantes ",0+48+0,"Error")
		=abreycierracon(vconeccionCM,"")
		RETURN 0	
	ENDIF 

	SELECT comprobantes_sql 
	GO TOP 
	IF EOF() THEN 
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Comprobantes ",0+48+0,"Error")
		USE IN comprobantes_sql
		=abreycierracon(vconeccionCM,"")
		RETURN 0
	ENDIF 
	
	GO TOP 
	LOCATE FOR idcomproba = cmp_idcomprobad 
	IF !found() THEN 
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Comprobante a Generar ",0+48+0,"Error")
		USE IN comprobantes_sql
		=abreycierracon(vconeccionCM,"")
		RETURN 0
	ELSE
		v_tablad = ALLTRIM(comprobantes_sql.tabla)
	ENDIF 
	
	GO TOP 
	LOCATE FOR idcomproba = cmp_idcomprobao 
	IF !found() THEN 
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Comprobante a Origen ",0+48+0,"Error")
		USE IN comprobantes_sql
		=abreycierracon(vconeccionCM,"")
		RETURN 0
	ELSE 
		v_tablao = ALLTRIM(comprobantes_sql.tabla)
	ENDIF 
	
	USE IN comprobantes_sql

	v_nomindice = obtenerCampoIndice(ALLTRIM(v_tablao))

	sqlmatriz(1)=" select t.*, pv.puntov as pvta from  "+ALLTRIM(v_tablao)+" t "
	sqlmatriz(2)=" left join puntosventa pv on pv.pventa = t.pventa "
	sqlmatriz(3)=" where t.idcomproba = "+STR(cmp_idcomprobao)+" and  t."+ALLTRIM(v_nomindice)+" = "+STR(cmp_id)
	verror=sqlrun(vconeccionCM,"comprorigen_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Comprobante origen ...",0+48+0,"Error")
		=abreycierracon(vconeccionCM,"")
		RETURN 0	
	ENDIF 

	=abreycierracon(vconeccionCM,"")

	v_idregretorno = 0	
	
	** Si llegó hasta aqui es porque el Comprobante de Origen y el comprobante de destino existen
	DO CASE && Considero solo los casos de comprobantes Asociados Factibles
	
		CASE ALLTRIM(v_tablao)='facturas' AND ALLTRIM(v_tablad)='remitos' && genera un remito a partir de una factura 

***************************** GENERACION DE REMITOS A PARTIR DE FACTURAS *************************************

			v_idremito = maxnumeroidx("idremito","I","remitos",1)

			IF v_idremito <= 0
				MESSAGEBOX("No se pudo recuperar el ultimo indice del remito",0+16,"Error")
				RETURN 0
			ENDIF 

			v_idcom  = STR(cmp_idcomprobad)
			v_pventa = comprorigen_sql.pventa
			v_tipo   = comprorigen_sql.tipo
			v_numero = maxnumerocom(VAL(v_idcom),v_pventa ,1)
			v_fecha  = comprorigen_sql.fecha 
			

			*** Me conecto a la base de datos
			vconeccionCM=abreycierracon(0,_SYSSCHEMA)	

			sqlmatriz(1)="SELECT idremito FROM remitos WHERE idremito = " + ALLTRIM(STR(v_idremito))
			verror=sqlrun(vconeccionCM,"controlF")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del código : "+ STR(v_idremito),0+48+0,"Error")
			*** me desconecto	
				=abreycierracon(vconeccionCM,"")
			    RETURN 
			ENDIF 

			SELECT controlF
			GO TOP 
			IF EOF() AND RECNO()=1 THEN 
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
			ELSE
				MESSAGEBOX("Ya existe un comprobante con el indice establecido",0+48+256,"No se puede cargar el comprobante")
			*** me desconecto	
				=abreycierracon(vconeccionCM,"")
				RETURN 0
			ENDIF 


			*** Carga de campos en la matriz  ***

			v_entidad 	= comprorigen_sql.entidad
			v_servicio 	= comprorigen_sql.servicio
			v_cuenta 	= comprorigen_sql.cuenta

			v_apellido 	= comprorigen_sql.apellido
			v_nombre 	= comprorigen_sql.nombre
			v_direccion = comprorigen_sql.direccion 
			v_localidad = comprorigen_sql.localidad
			v_iva 		= comprorigen_sql.iva
			v_cuit 		= comprorigen_sql.cuit
			v_docTIpo 	= comprorigen_sql.tipodoc
			v_dni 		= comprorigen_sql.dni
			v_telefono 	= comprorigen_sql.telefono
			v_cp 		= comprorigen_sql.cp
			v_fax 		= comprorigen_sql.fax
			v_email 	= comprorigen_sql.email
			v_zona = ""
			v_ruta1 = 0
			v_folio1 = 0
			v_ruta2 = 0
			v_folio2 = 0

			v_dirEntrega 		= comprorigen_sql.direntrega
			v_transporte 		= comprorigen_sql.transporte
			v_nombreTransporte 	= comprorigen_sql.nomtransp

			v_stock = 'N'
			v_tipoOp= 0
			v_neto = 0
			v_descuento = 0
			v_recargo = 0
			v_operaExenta = ""
			v_anulado = "N"

			v_fechavenc1 = ""
			v_fechavenc2 = ""
			v_fechavenc3 = ""
			v_fechaDescuento = ""
			v_proxvenc = ""
			v_confirmada = ""
			v_astoConta = 0
			v_deuda_cta = 0
			v_cespcae = ""
			v_caecespVen = ""

			v_vendedor = comprorigen_sql.vendedor
			v_idperiodo = 0
			v_observa1 = 'Ref.: '+ALLTRIM(comprorigen_sql.tipo)+' '+alltrim(comprorigen_sql.pvta)+'-'+STRTRAN(STR(comprorigen_sql.numero,8),' ','0')+' '+ALLTRIM(comprorigen_sql.observa1)
			v_observa2 = comprorigen_sql.observa2
			v_observa3 = comprorigen_sql.observa3
			v_observa4 = comprorigen_sql.observa4
				
			*** GUARDA DATOS DE CABECERA DEL REMITO
			DIMENSION lamatrizCM1(43,2)
			DIMENSION lamatrizCM2(18,2)

			lamatrizCM1(1,1)='idremito'
			lamatrizCM1(1,2)= ALLTRIM(STR(v_idremito))
			lamatrizCM1(2,1)='idcomproba'
			lamatrizCM1(2,2)=ALLTRIM(v_idcom)
			lamatrizCM1(3,1)='pventa'
			lamatrizCM1(3,2)= ALLTRIM(STR(v_pventa))
			lamatrizCM1(4,1)='numero'
			lamatrizCM1(4,2)=ALLTRIM(STR(v_numero))
			lamatrizCM1(5,1)='tipo'
			lamatrizCM1(5,2)="'"+ALLTRIM(v_tipo)+"'"
			lamatrizCM1(6,1)='fecha'
			lamatrizCM1(6,2)="'"+v_fecha+"'"
			lamatrizCM1(7,1)='entidad'
			lamatrizCM1(7,2)=ALLTRIM(STR(v_entidad))
			lamatrizCM1(8,1)='servicio'
			lamatrizCM1(8,2)= ALLTRIM(STR(v_servicio))
			lamatrizCM1(9,1)='cuenta'
			lamatrizCM1(9,2)= ALLTRIM(STR(v_cuenta))
			lamatrizCM1(10,1)='apellido'
			lamatrizCM1(10,2)= "'"+ALLTRIM(v_apellido)+"'"
			lamatrizCM1(11,1)='nombre'
			lamatrizCM1(11,2)= "'"+ALLTRIM(v_nombre)+"'"
			lamatrizCM1(12,1)='direccion'
			lamatrizCM1(12,2)= "'"+ALLTRIM(v_direccion)+"'"
			lamatrizCM1(13,1)='localidad'
			lamatrizCM1(13,2)= "'"+ALLTRIM(v_localidad)+"'"
			lamatrizCM1(14,1)='iva'
			lamatrizCM1(14,2)= ALLTRIM(STR(v_iva))
			lamatrizCM1(15,1)='cuit'
			lamatrizCM1(15,2)= "'"+ALLTRIM(v_cuit)+"'"
			lamatrizCM1(16,1)='tipodoc'
			lamatrizCM1(16,2)= "'"+ALLTRIM(v_docTIpo)+"'"
			lamatrizCM1(17,1)='dni'
			lamatrizCM1(17,2)= ALLTRIM(STR(v_dni))
			lamatrizCM1(18,1)='telefono'
			lamatrizCM1(18,2)= "'"+ALLTRIM(v_telefono)+"'"
			lamatrizCM1(19,1)='cp'
			lamatrizCM1(19,2)= "'"+ALLTRIM(v_cp)+"'"
			lamatrizCM1(20,1)='fax'
			lamatrizCM1(20,2)= "'"+ALLTRIM(v_fax)+"'"
			lamatrizCM1(21,1)='email' 
			lamatrizCM1(21,2)= "'"+ALLTRIM(v_email)+"'"
			lamatrizCM1(22,1)='transporte'
			lamatrizCM1(22,2)= ALLTRIM(STR(v_transporte))
			lamatrizCM1(23,1)='nomtransp'
			lamatrizCM1(23,2)= "'"+ALLTRIM(v_nombreTransporte)+"'"
			lamatrizCM1(24,1)='direntrega'
			lamatrizCM1(24,2)= "'"+ALLTRIM(v_dirEntrega)+"'"
			lamatrizCM1(25,1)='stock'
			lamatrizCM1(25,2)= "'"+ALLTRIM(v_stock)+"'"
			lamatrizCM1(26,1)='idtipoopera'
			lamatrizCM1(26,2)= ALLTRIM(STR(v_tipoOp))
			lamatrizCM1(27,1)='neto'
			lamatrizCM1(27,2)= ALLTRIM(STR(v_neto,13,4))
			lamatrizCM1(28,1)='subtotal'
			lamatrizCM1(28,2)= "0"
			lamatrizCM1(29,1)='recargo'
			lamatrizCM1(29,2)= "0"
			lamatrizCM1(30,1)='operexenta'
			lamatrizCM1(30,2)= "'"+ALLTRIM(v_operaExenta)+"'"
			lamatrizCM1(31,1)='anulado'
			lamatrizCM1(31,2)= "'"+ALLTRIM(v_anulado)+"'"
			lamatrizCM1(32,1)='observa1'
			lamatrizCM1(32,2)= "'"+ALLTRIM(v_observa1)+"'"
			lamatrizCM1(33,1)='observa2'
			lamatrizCM1(33,2)= "'"+ALLTRIM(v_observa2)+"'"
			lamatrizCM1(34,1)='observa3'
			lamatrizCM1(34,2)= "'"+ALLTRIM(v_observa3)+"'"
			lamatrizCM1(35,1)='observa4'
			lamatrizCM1(35,2)= "'"+ALLTRIM(v_observa4)+"'"
			lamatrizCM1(36,1)='ruta1'
			lamatrizCM1(36,2)= ALLTRIM(STR(v_ruta1))
			lamatrizCM1(37,1)='folio1'
			lamatrizCM1(37,2)= ALLTRIM(STR(v_folio1))
			lamatrizCM1(38,1)='ruta2'
			lamatrizCM1(38,2)= ALLTRIM(STR(v_ruta2))
			lamatrizCM1(39,1)='folio2'
			lamatrizCM1(39,2)= ALLTRIM(STR(v_folio2))
			lamatrizCM1(40,1)='astoconta'
			lamatrizCM1(40,2)= ALLTRIM(STR(v_astoConta))
			lamatrizCM1(41,1)='cespcae'
			lamatrizCM1(41,2)= "'"+ALLTRIM(v_cespcae)+"'"
			lamatrizCM1(42,1)='caecespven'
			lamatrizCM1(42,2)= "'"+ALLTRIM(v_caecespVen)+"'"
			lamatrizCM1(43,1)='vendedor'
			lamatrizCM1(43,2)= ALLTRIM(STR(v_vendedor))


			p_tabla     = 'remitos'
			p_matriz    = 'lamatrizCM1'
			p_conexion  = vconeccionCM
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			    RETURN 
			ENDIF  

			
			**** Ahora agrego el detalle del Remito a partir del detalle de la factura ****
			
			sqlmatriz(1)=" select * from  detafactu "
			sqlmatriz(2)=" where   "+ALLTRIM(v_nomindice)+" = "+STR(cmp_id)
			verror=sqlrun(vconeccionCM,"detaorigen_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Detalle del Comprobante de Origen ...",0+48+0,"Error")
				=abreycierracon(vconeccionCM,"")
				RETURN 0	
			ENDIF 
			
			
			SELECT detaorigen_sql 
			
			DO WHILE NOT EOF()
			
					p_tipoope     = 'I'
					p_condicion   = ''
					v_titulo      = " EL ALTA "
					
					v_idremitoh = maxnumeroidx("idremitoh","I","remitosh",1)

					v_articulo 		= detaorigen_sql.articulo
					v_idconcepto 	= detaorigen_sql.idconcepto
					v_servicio 		= detaorigen_sql.servicio
					v_cantidad 		= detaorigen_sql.cantidad
					v_unidad 		= detaorigen_sql.unidad
					v_cantidadFC 	= detaorigen_sql.cantidadFc
					v_unidadFC 		= detaorigen_sql.unidadFc
					v_detalle 		= detaorigen_sql.detalle
					v_unitario 		= detaorigen_sql.unitario
					v_impuesto 		= 0.00
					v_totalArt 		= 0.00
					v_codigoCta 	= ""
					v_nombreCta 	= ""
					v_padron 		= 0
					v_netoArt 		= 0.00
					v_idimpuesto	= 0
					v_razonImpuesto = 0

					lamatrizCM2(1,1)='idremito'
					lamatrizCM2(1,2)= ALLTRIM(STR(v_idremito))	
					lamatrizCM2(2,1)='idremitoh'
					lamatrizCM2(2,2)= ALLTRIM(STR(v_idremitoh))
					lamatrizCM2(3,1)='articulo'
					lamatrizCM2(3,2)= "'"+ALLTRIM(v_articulo)+"'"
					lamatrizCM2(4,1)='idconcepto'
					lamatrizCM2(4,2)= ALLTRIM(STR(v_idconcepto))
					lamatrizCM2(5,1)='servicio'
					lamatrizCM2(5,2)= ALLTRIM(STR(v_servicio))
					lamatrizCM2(6,1)='cantidad'
					lamatrizCM2(6,2)= ALLTRIM(STR(v_cantidad))
					lamatrizCM2(7,1)='unidad'
					lamatrizCM2(7,2)= "'"+ALLTRIM(v_unidad)+"'"
					lamatrizCM2(8,1)='cantidadfc'
					lamatrizCM2(8,2)= ALLTRIM(str(v_cantidadFC,13,4))
					lamatrizCM2(9,1)='unidadfc'
					lamatrizCM2(9,2)= "'"+ALLTRIM(v_unidadFC)+"'"
					lamatrizCM2(10,1)='detalle'
					lamatrizCM2(10,2)= "'"+ALLTRIM(v_detalle)+"'"
					lamatrizCM2(11,1)='unitario'
					lamatrizCM2(11,2)= ALLTRIM(STR(v_unitario,13,4))
					lamatrizCM2(12,1)='impuestos'
					lamatrizCM2(12,2)= ALLTRIM(STR(v_impuesto,13,4))
					lamatrizCM2(13,1)='total'
					lamatrizCM2(13,2)= ALLTRIM(STR(v_totalArt,13,4))
					lamatrizCM2(14,1)='codigocta'
					lamatrizCM2(14,2)= "'"+ALLTRIM(v_codigoCta)+"'"
					lamatrizCM2(15,1)='nombrecta'
					lamatrizCM2(15,2)= "'"+ALLTRIM(v_nombreCta)+"'"
					lamatrizCM2(16,1)='padron' 
					lamatrizCM2(16,2)= ALLTRIM(STR(v_padron))
					lamatrizCM2(17,1)='impuesto'
					lamatrizCM2(17,2)= ALLTRIM(STR(v_idimpuesto))
					lamatrizCM2(18,1)='razonimp'
					lamatrizCM2(18,2)= ALLTRIM(STR(v_razonImpuesto,13,4))
					

					p_tabla     = 'remitosh'
					p_matriz    = 'lamatrizCM2'
					p_conexion  = vconeccionCM
					IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
					    MESSAGEBOX("Ha Ocurrido un Error en Carga de Detalle en Remitos ",0+48+0,"Error")
					ENDIF						
					
				SELECT detaorigen_sql
				SKIP 1
			ENDDO	

			
			USE IN detaorigen_sql 
			USE IN comprorigen_sql

			registrarEstado("remitos","idremito",v_idremito,'I',"AUTORIZADO")

			guardaCajaRecaH (VAL(v_idcom), v_idremito)
			*** Registro la relación de los comprobantes- En caso que tenga ***
			DIMENSION lamatrizli(5,2)
			v_idlinkcomp = 0 	
			v_idregistroa	= cmp_id
			v_idcomprobaa	= cmp_idcomprobao
			v_idregistrob 	= v_idremito
			v_idcomprobab	= cmp_idcomprobad
				
				
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
				
			lamatrizli(1,1)='idlinkcomp'
			lamatrizli(1,2)= ALLTRIM(STR(v_idlinkcomp))
			lamatrizli(2,1)= 'idregistroa'
			lamatrizli(2,2)= ALLTRIM(STR(v_idregistroa))
			lamatrizli(3,1)= 'idcomprobaa'
			lamatrizli(3,2)= ALLTRIM(STR(v_idcomprobaa))
			lamatrizli(4,1)= 'idregistrob'
			lamatrizli(4,2)= ALLTRIM(STR(v_idregistrob))
			lamatrizli(5,1)= 'idcomprobab'
			lamatrizli(5,2)= ALLTRIM(STR(v_idcomprobab))

			p_tabla     = 'linkcompro'
			p_matriz    = 'lamatrizli'
			p_conexion  = vconeccionCM
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			ENDIF			

			
			RELEASE lamatrizli
			RELEASE lamatrizCM1
			RELEASE lamatrizCM2	
			
			*** Cierro la conexion
			=abreycierracon(vconeccionCM,"")
	
			** GENERO EL ASIENTO PARA EL REMITO			
			v_cargo = ContabilizaCompro('remitos', v_idregistrob, 0,0)
			
			sino = MESSAGEBOX("¿Desea imprimir el Remito Asociado ?",4+32,"Imprimir Remito")
			IF sino = 6
				*SI
				=imprimirRemito(v_idregistrob,.f.)

			ENDIF 
			 v_idregretorno = v_idregistrob 
			 
************************ FIN DE GENERACION DE REMITOS A PARTIR DE FACTURAS ***************************************			
******************************************************************************************************************

		OTHERWISE
		    MESSAGEBOX("No se Puede Generar el Comprobante Solicitado ...",0+48+0,"Error")
		    RETURN 0
	ENDCASE 
	

	RETURN v_idregretorno 
ENDFUNC 



FUNCTION FNDatosExtras
PARAMETERS pm_tabla, pm_id
*#/----------------------------------------
*******************************************
** Chequea la Tabla pasada como parámetro tenga etiquetas de datos Anexos, si hay solicita los datos para el id pasado como parametro
*	pm_tabla: Tabla para la solicitud de datos Anexos
*   pm_id: Id de la tabla para Asociar los datos anexos
*******************************************
*#/----------------------------------------

	*** Me conecto a la base de datos
	vconeccionFND=abreycierracon(0,_SYSSCHEMA)	

	sqlmatriz(1)="SELECT * FROM reldatosextra WHERE tabla = '"+ALLTRIM(pm_tabla)+"' LIMIT 1"
	verror=sqlrun(vconeccionFND,"controlF")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de RelDatosExtras ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionFND,"")
	    RETURN .F.
	ENDIF 

	SELECT controlF
	GO TOP 
	IF EOF() THEN 
		USE IN controlF
		=abreycierracon(vconeccionFND,"")
		RETURN .F.
	ENDIF 

	USE IN controlF
	IF MESSAGEBOX("Desea Agregar Datos Anexos al Registro Ingresado ?",4+32,"Datos Anexos")=7 THEN 
		=abreycierracon(vconeccionFND,"")
		RETURN .F. 
	ENDIF 
	=abreycierracon(vconeccionFND,"")

	DO FORM datosextras WITH pm_id, pm_tabla TO v_retDatos

	RETURN .T.
ENDFUNC 





FUNCTION FNPresupuToNP
PARAMETERS pp_idpresupu
*#/----------------------------------------
****************************************************************************************************************
*** Generación de una Nota de Pedido a partir de un Presupuesto *********************************************
***
*** PARAMETRO: 
*** pp_idpresupu : ID del presupuesto para el cual se realizará la nota de pedido anexa
*** retorna el idnp: de la nota de pedido generada, si no lo genera retorna 0
************************************************************************************************************
*#/----------------------------------------

	rt_idnp = 0 
	v_tmp = frandom()
	
	**** 1.- Obtengo los Datos del Presupuesto para generar la NP
	*** Me conecto a la base de datos
	vconeccionF=abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)="SELECT * FROM presupu WHERE idpresupu = " + ALLTRIM(STR(pp_idpresupu))
	verror=sqlrun(vconeccionF,"presupu_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del PRESUPUESTO : "+ STR(pp_idpresupu),0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionF,"")
	    RETURN 	rt_idnp  
	ENDIF 
	SELECT presupu_sql
	GO TOP 
	IF EOF() THEN 
		USE IN presupu_sql
		=abreycierracon(vconeccionF,"")
		RETURN rt_idnp 
	ENDIF 
	
	
	sqlmatriz(1)=" SELECT c.idcomproba, a.pventa FROM comprobantes c "
	sqlmatriz(2)=" LEFT JOIN compactiv a ON a.idcomproba = c.idcomproba "
	sqlmatriz(4)=" WHERE c.tabla = 'np' " 
	verror=sqlrun(vconeccionF,"compronp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Comprobantes de NP ... ",0+48+0,"Error")
	    RETURN rt_idnp
	ENDIF	


	sqlmatriz(1)=" SELECT * FROM linkcompro c where idcomprobaa = "+ALLTRIM(STR(compronp_sql.idcomproba))+" and idcomprobab = " +ALLTRIM(STR(presupu_sql.idcomproba))+" and idregistrob = " +ALLTRIM(STR(pp_idpresupu))
	verror=sqlrun(vconeccionF,"presuasocia_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Comprobantes de NP ... ",0+48+0,"Error")
	    RETURN .F.
	ENDIF	
	SELECT presuasocia_sql
	GO TOP 
	IF !EOF() THEN 
		IF MESSAGEBOX("Ya Existe una Nota de Pedido Asociada a Este Presupuesto...,"+CHR(13)+"Desea Generar una Nota de Pedido Nueva de todas formas...? ",4+32,"Nota de Pedido Asociada ") = 7 THEN
			USE IN compronp_sql
			USE IN presuasocia_sql
			USE IN presupu_sql
			=abreycierracon(vconeccionF,"")
			RETURN rt_idnp 
		ENDIF 
	ENDIF 
	USE IN presuasocia_sql 

		


	sqlmatriz(1)="SELECT * FROM presupuh WHERE idpresupu = " + ALLTRIM(STR(pp_idpresupu))
	verror=sqlrun(vconeccionF,"presupuh_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del DETALLE DEL PRESUPUESTO : "+ STR(pp_idpresupu),0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionF,"")
	    RETURN rt_idnp 
	ENDIF 
	
	sqlmatriz(1) = " SELECT a.* from datosextra a left join reldatosextra r on a.iddatosex = r.iddatosex "
	sqlmatriz(2) = " where r.idregistro = "+ALLTRIM(STR(pp_idpresupu)) + " and r.tabla = 'presupu'"
	verror=sqlrun(vconeccionF,"datosextra_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de DatosExtras ",0+48+0,"Error")
	    RETURN rt_idnp 
	ENDIF 
	
	sqlmatriz(1) = " SELECT iddatoan, fecha, detalle, numero, importe, tabla, id from datosanexo "
	sqlmatriz(2) = " where id = "+ALLTRIM(STR(pp_idpresupu)) + " and tabla = 'presupu'"
	verror=sqlrun(vconeccionF,"datosanexo_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de DatosAnexos ",0+48+0,"Error")
	    RETURN rt_idnp 
	ENDIF 



	*** Grabo en NP y sus Tablas Asociadas de acuerdo al Presupuesto	
	p_tipoope     = 'I'
	p_condicion   = ''
	v_titulo      = " EL ALTA "

	SELECT presupu_sql
	GO TOP 
	IF !EOF() THEN && Si existe el Presupuesto entonces Genero la Nota de Pedido
	
		** Grabo la Cabecera de la Nota de Pedido **
			
		v_idnp = 0
		v_idnp = maxnumeroidx("idnp","I","np",1)
		IF v_idnp <= 0
			MESSAGEBOX("No se pudo recuperar el ultimo indice de la NP",0+16,"Error")
			RETURN rt_idnp 
		ENDIF 
				
		cnp_idcomproba	= compronp_sql.idcomproba
		cnp_pventa		= presupu_sql.pventa
		cnp_numero		= maxnumerocom(cnp_idcomproba,presupu_sql.pventa,1)
		cnp_observa 	= "Presupuesto: X "+ALLTRIM(presupu_sql.puntov)+'-'+STRTRAN(STR(presupu_sql.numero,8),' ','0')+'   '+ALLTRIM(STR(presupu_sql.entidad))+'-'+ALLTRIM(presupu_sql.nombre)+' '+ALLTRIM(presupu_sql.fecha)

		DIMENSION lamatriz1(16,2)
		DIMENSION lamatriz2(20,2)
					
		lamatriz1(1,1)='idnp'
		lamatriz1(1,2)= ALLTRIM(STR(v_idnp))
		lamatriz1(2,1)='puntov'
		lamatriz1(2,2)="'"+ALLTRIM(presupu_sql.puntov)+"'"
		lamatriz1(3,1)='numero'
		lamatriz1(3,2)= ALLTRIM(STR(cnp_numero))
		lamatriz1(4,1)='fecha'
		lamatriz1(4,2)= "'"+ALLTRIM(DTOS(DATE()))+"'"
		lamatriz1(5,1)='hora'
		lamatriz1(5,2)= "'"+ALLTRIM(SUBSTR(TTOC(DATETIME(),3),12,9))+"'"
		lamatriz1(6,1)='usuario'
		lamatriz1(6,2)="'"+ALLTRIM(_SYSUSUARIO)+"'"
		lamatriz1(7,1)='vendedor'
		lamatriz1(7,2)= ALLTRIM(STR(presupu_sql.vendedor))
		lamatriz1(8,1)='transporte'
		lamatriz1(8,2)= ALLTRIM(STR(presupu_sql.transporte))
		lamatriz1(9,1)='nombretran'
		lamatriz1(9,2)="'"+ALLTRIM(presupu_sql.nombretran)+"'"
		lamatriz1(10,1)='entidad'
		lamatriz1(10,2)=ALLTRIM(STR(presupu_sql.entidad))
		lamatriz1(11,1)='nombre'
		lamatriz1(11,2)="'"+alltrim(presupu_sql.nombre)+"'"
		lamatriz1(12,1)='observa'
		lamatriz1(12,2)="'"+ALLTRIM(presupu_sql.observa)+cnp_observa+"'"
		lamatriz1(13,1)='idtiponp'
		lamatriz1(13,2)= ALLTRIM(STR(presupu_sql.idtiponp))
		lamatriz1(14,1)='idcomproba'
		lamatriz1(14,2)=ALLTRIM(STR(cnp_idcomproba))
		lamatriz1(15,1)='pventa'
		lamatriz1(15,2)=ALLTRIM(STR(presupu_sql.pventa))
		lamatriz1(16,1)='fechaentre'
		lamatriz1(16,2)= "'"+ALLTRIM(presupu_sql.fechaentre)+"'"

		p_tabla     = 'np'
		p_matriz    = 'lamatriz1'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+STR(cnp_numero),0+48+0,"Error")
		ENDIF  	
		RELEASE lamatriz1
		

		** Grabo el Detalle de la Nota de Pedido a partir de presupuh **

		SELECT presupuh_sql
		GO TOP 

		DO WHILE NOT EOF()
				

			v_id_ot = maxnumeroidx("idot","I","ot",1)
			v_idtipoot		= presupuh_sql.idtipoot
			v_articulo 		= presupuh_sql.articulo
			v_detalle 		= presupuh_sql.detalle
			v_cantidad 		= presupuh_sql.cantidad
			v_unidad 		= presupuh_sql.unidad
			v_unitario 		= presupuh_sql.unitario		
			v_observa		= presupuh_sql.observa
			v_fechaentre 	= presupuh_sql.fechaentre
			v_cantidadFC 	= presupuh_sql.cantidadFc
			v_unidadFC 	 	= presupuh_sql.unidadFc
			v_impuestos	 	= presupuh_sql.impuestos
			v_impuesto	 	= presupuh_sql.impuesto
			v_neto		 	= presupuh_sql.neto
			v_razonimp	 	= presupuh_sql.razonimp
			v_total		 	= presupuh_sql.total
			v_idmate	 	= presupuh_sql.idmate
			v_idtiponpot 	= presupuh_sql.idtiponp
			v_impr		 	= presupuh_sql.imprimir

			lamatriz2(1,1)='idnp'
			lamatriz2(1,2)=ALLTRIM(STR(v_idnp))
			lamatriz2(2,1)='idot'
			lamatriz2(2,2)=ALLTRIM(STR(v_id_ot))
			lamatriz2(3,1)='idtipoot'
			lamatriz2(3,2)=ALLTRIM(STR(v_idtipoot))
			lamatriz2(4,1)='articulo'
			lamatriz2(4,2)="'"+ALLTRIM(v_articulo)+"'"
			lamatriz2(5,1)='detalle'
			lamatriz2(5,2)= "'"+ALLTRIM(v_detalle)+"'"
			lamatriz2(6,1)='cantidad'
			lamatriz2(6,2)=ALLTRIM(STR(v_cantidad,13,4))
			lamatriz2(7,1)='unidad'
			lamatriz2(7,2)="'"+alltrim(v_unidad )+"'"
			lamatriz2(8,1)='unitario'
			lamatriz2(8,2)=ALLTRIM(STR(v_unitario,13,4))
			lamatriz2(9,1)='observa'
			lamatriz2(9,2)="'"+ALLTRIM(v_observa)+"'"
			lamatriz2(10,1)='fechaentre'
			lamatriz2(10,2)="'"+ALLTRIM(v_fechaentre)+"'"
			lamatriz2(11,1)='cantidadfc'
			lamatriz2(11,2)=ALLTRIM(STR(v_cantidadFC ,13,4))
			lamatriz2(12,1)='unidadfc'
			lamatriz2(12,2)="'"+ALLTRIM(v_unidadFC )+"'"
			lamatriz2(13,1)='impuestos'
			lamatriz2(13,2)=ALLTRIM(STR(v_impuestos,13,4))
			lamatriz2(14,1)='total'
			lamatriz2(14,2)=ALLTRIM(STR(v_total,13,4))
			lamatriz2(15,1)='impuesto'
			lamatriz2(15,2)=ALLTRIM(STR(v_impuesto))
			lamatriz2(16,1)='razonimp'
			lamatriz2(16,2)=ALLTRIM(STR(v_razonimp,13,4))
			lamatriz2(17,1)='neto'
			lamatriz2(17,2)=ALLTRIM(STR(v_neto,13,4))
			lamatriz2(18,1)='idmate'
			lamatriz2(18,2)=ALLTRIM(STR(v_idmate))
			lamatriz2(19,1)='idtiponp'
			lamatriz2(19,2)=ALLTRIM(STR(v_idtiponpot))
			lamatriz2(20,1)='imprimir'
			lamatriz2(20,2)="'"+ALLTRIM(v_impr)+"'"

			p_tabla     = 'ot'
			p_matriz    = 'lamatriz2'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			ENDIF						
			
			
			SELECT presupuh_sql
			SKIP 1
		ENDDO	
		RELEASE lamatriz2



		*** Registro la relación de los comprobantes- En caso que tenga ***
		DIMENSION lamatrizli(5,2)

		v_idlinkcomp	= maxnumeroidx("idlinkcomp","I","linkcompro",1)
		v_idregistroa	= v_idnp
		v_idcomprobaa	= cnp_idcomproba
		v_idregistrob 	= presupu_sql.idpresupu
		v_idcomprobab	= presupu_sql.idcomproba
			
		lamatrizli(1,1)='idlinkcomp'
		lamatrizli(1,2)= ALLTRIM(STR(v_idlinkcomp))
		lamatrizli(2,1)= 'idregistroa'
		lamatrizli(2,2)= ALLTRIM(STR(v_idregistroa))
		lamatrizli(3,1)= 'idcomprobaa'
		lamatrizli(3,2)= ALLTRIM(STR(v_idcomprobaa))
		lamatrizli(4,1)= 'idregistrob'
		lamatrizli(4,2)= ALLTRIM(STR(v_idregistrob))
		lamatrizli(5,1)= 'idcomprobab'
		lamatrizli(5,2)= ALLTRIM(STR(v_idcomprobab))

		p_tabla     = 'linkcompro'
		p_matriz    = 'lamatrizli'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
		ENDIF			
		RELEASE lamatrizli
		
		*******************************************************************
		********
		*** GUARDA LOS DATOS ANEXOS SI ES QUE SE CARGARON **
		vanexosnp = "anexosnp"+v_tmp 
		SELECT * FROM datosanexo_sql INTO TABLE &vanexosnp
		SELECT &vanexosnp
		replace ALL iddatoan WITH 0, tabla WITH 'np'
		USE IN &vanexosnp
		=ActuDatosAnexos(vanexosnp,v_idnp)
		

		*** GUARDA LOS DATO EXTRAS DEL PRESUPUESTO EN LA NP SI LOS TUVIERA **************
		SELECT * FROM datosextra_sql INTO TABLE cantDatos
		DIMENSION lamatriz(4,2)
		DIMENSION lamatriz2(4,2)
		SELECT cantDatos
		GO top
		DO WHILE !EOF()

			v_iddatosex		= 0
			v_propiedad		= ALLTRIM(cantDatos.propiedad)
			v_valor			= cantDatos.valor
			v_imprimir		= cantDatos.imprimir
				
			lamatriz(1,1)='iddatosex'
			lamatriz(1,2)=ALLTRIM(STR(v_iddatosex))
			lamatriz(2,1)='propiedad'
			lamatriz(2,2)="'"+ALLTRIM(v_propiedad)+"'"
			lamatriz(3,1)='valor'
			lamatriz(3,2)="'"+ALLTRIM(v_valor)+"'"
			lamatriz(4,1)='imprimir'
			lamatriz(4,2)="'"+ALLTRIM(v_imprimir)+"'"
							
			p_tabla     = 'datosextra'
			p_matriz    = 'lamatriz'
			p_conexion  = vconeccionF	
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en Ingreso de Datos Extras",0+48+0,"Error")
			    v_huboErrores	= .T.		    
			    RETURN 
			ENDIF  

			IF v_iddatosex = 0 THEN && Se Insertó uno nuevo 
				sqlmatriz(1)=" select last_insert_id() as maxid "
				verror=sqlrun(vconeccionF,"ultimoId")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
				    RETURN 
				ENDIF 
				SELECT ultimoId
				GO TOP 
				v_iddatosex_Ultimo = VAL(ultimoId.maxid)
				USE IN ultimoId
				
				v_idreldex	= 0
				
				*** Inserto en la tabla de de lararchivo
				
				lamatriz2(1,1)='idreldex'
				lamatriz2(1,2)=ALLTRIM(STR(v_idreldex))
				lamatriz2(2,1)='iddatosex'
				lamatriz2(2,2)=ALLTRIM(STR(v_iddatosex_Ultimo))
				lamatriz2(3,1)='idregistro'
				lamatriz2(3,2)=ALLTRIM(STR(v_idnp))
				lamatriz2(4,1)='tabla'
				lamatriz2(4,2)="'np'"

				p_tabla     = 'reldatosextra'
				p_matriz    = 'lamatriz2'
				p_conexion  = vconeccionF
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en tabla reldatosextra ",0+48+0,"Error")
				    RETURN 
				ENDIF  
			
			ENDIF 

			SELECT cantDatos
			SKIP 
		ENDDO 
		USE IN cantDatos
		RELEASE lamatriz
		RELEASE lamatriz2


		
		*********************************************************
		*** REGISTRO estado activo ***
		registrarEstado("np","idnp",v_idnp,"I","ACTIVO")
			
		*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
		guardaCajaRecaH (cnp_idcomproba, v_idnp)
		
		rt_idnp = v_idnp
	
	ENDIF
	
	USE IN presupu_sql
	USE IN presupuh_sql
	USE IN datosextra_sql
	USE IN datosanexo_sql 
	=abreycierracon(vconeccionF,"")	
	
	IF rt_idnp > 0 THEN 
		IF MESSAGEBOX("¿Desea Imprimir la Nota de Pedido Generada ?",4+32,"Imprimir Nota de Pedido") = 6 THEN 
			=imprimirNP(rt_idnp)
		ENDIF 
	ENDIF 

RETURN rt_idnp 





FUNCTION GenerarNotaProduccion
PARAMETERS pp_idnp
*#/----------------------------------------
****************************************************************************************************************
*** Generación de una Nota de Producción (NPr) a partir de una Nota de Pedido (NP) *********************************************
*** Genera una nota de Producción (es un comprobante del tipo de Nota de Pedido).
*** La Función recibe como parámetro una nota de pedido, si la nota de pedido tiene articulos compuestos; generará una Nota de Fabricación,
*** La cuál va a estar compuesta por los articulos compuestos de la NP original.
*** NOTA: La Nota de fabricación se guardara dentro de la tabla np, y tendrá el mismo comportamiento que una nota de pedido
*** PARAMETRO: 
*** pp_idnp : ID de la nota de pedido que se va a generar una nota de fabricación
*** retorna el idnp: de la nota de Producción, si no lo genera retorna 0
************************************************************************************************************
*#/----------------------------------------

	rt_idnp = 0 
	v_tmp = frandom()
	v_tipoOF = 'NOTA DE PRODUCCION'	

	
	**** 1.- Obtengo los Datos de la NP para generar la NPr
	*** Me conecto a la base de datos
	vconeccionF=abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)="SELECT * FROM np WHERE idnp = " + ALLTRIM(STR(pp_idnp))
	verror=sqlrun(vconeccionF,"np_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la NP: "+ STR(pp_idnp),0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionF,"")
	    RETURN 	rt_idnp  
	ENDIF 
	
	SELECT np_sql
	GO TOP 
	IF EOF() THEN 
		USE IN np_sql
		=abreycierracon(vconeccionF,"")
		RETURN rt_idnp 
	ENDIF 
	
	SELECT np_sql
	v_pventaNP = np_sql.pventa
	v_numeroNP = np_sql.numero
	v_puntoV = np_sql.puntov

	v_numeroNP = ALLTRIM(STRTRAN(STR(v_numeroNP,8,0),' ','0'))
	
	
	*** Busco el a 	
	comprobanteObj 	= CREATEOBJECT('comprobantesclass')
	v_idComproOF = comprobanteObj.getIdComprobante("NOTA DE PRODUCCION")
	
		
	sqlmatriz(1)=" SELECT c.idcomproba, a.pventa FROM comprobantes c "
	sqlmatriz(2)=" LEFT JOIN compactiv a ON a.idcomproba = c.idcomproba "
	sqlmatriz(4)=" WHERE c.tabla = 'np' and c.idcomproba = " +ALLTRIM(STR(v_idComproOF))+" and a.pventa = "+ALLTRIM(STR(v_pventaNP))

	verror=sqlrun(vconeccionF,"comproof_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Comprobantes de OF ... ",0+48+0,"Error")
	    RETURN rt_idnp
	ENDIF	
	
	***	Buso las OT de las NP que tengan articulos compuestos **
	
	sqlmatriz(1)="SELECT * FROM ot WHERE idnp = " + ALLTRIM(STR(pp_idnp))+ " and articulo in (select articulo from articuloscmp) "
	verror=sqlrun(vconeccionF,"ot_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del DETALLE de la NP: "+ STR(pp_idnp),0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionF,"")
	    RETURN rt_idnp 
	ENDIF 
	

	** Busco el tipo de NP ***
	sqlmatriz(1)="SELECT * FROM tiponp WHERE descpe = '"+ALLTRIM(v_tipoOF )+"'"
	verror=sqlrun(vconeccionF,"tipoOF_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del tipo de la OF: "+ STR(pp_idnp),0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionF,"")
	    RETURN rt_idnp 
	ENDIF 

	SELECT np_sql
	GO TOP 
	IF !EOF() THEN && Si existe la NP entonces Genero la Nota de Producción
	
		*** Comprueba que tengan componentes ***
		
		v_tablaCompuestosTMP = "compuestosOTTMP"
	
	
		CREATE TABLE otComponentes FREE (idtipoot I, articulo C(50),detalle C(254),cantidad N(13,2), unidad C(50), unitario N(13,2),observa C(254), ;
		 fechaentre C(8), cantidadfc N(13,2), unidadfc C(50), neto N(13,2), impuestos N(13,2), impuesto I, razonimp N(13,2), total N(13,2), idmate I, idtiponp I, imprimir C(1))
		 
	
		SELECT ot_sql
		GO top
		IF NOT EOF()
		
			v_sino = MESSAGEBOX("¿Desea crear una Nota de Producción con los componentes de la NP: "+v_puntoV+" - "+v_numeroNP ,4+32+256,"Crear Nota de Producción")
		
			IF v_sino <> 6
			
				RETURN rt_idnp 
			ENDIF 
		ELSE
		
				RETURN rt_idnp 	
		ENDIF 

		** Actualizo los precios ***
		vlistaspretmp = 'listaspretmp'
		GetListasPrecios(vlistaspretmp)
		
		vlistaPrecio = vlistaspretmp+'a'
		SELECT &vlistaPrecio 
		GO TOP 


		SELECT ot_sql
		GO top
		DO WHILE NOT eof()
			** Busco lo componentes para cada articulo y lo agrego a la tabla otComponentes ***
			v_artOT = ot_sql.articulo
			v_cantOT = ot_sql.cantidad
			v_ret = componentesArticulo (v_artOT, v_tablaCompuestosTMP)
			
			SELECT tipoOF_sql
			GO TOP 
			IF NOT EOF()
				v_idtipoNP = tipoOF_sql.idtiponp
			ELSE
			 v_idtipoNP = 1
			ENDIF 
			IF v_ret = .T.
			
				SELECT &v_tablaCompuestosTMP 
				GO TOP 
				
				DO WHILE NOT EOF()
				
				v_idtipoot		= 1
						v_articulo 		= &v_tablaCompuestosTMP..articulo
				
						v_sentencia = "SELECT * FROM "+ ALLTRIM(vlistaPrecio)+" WHERE articulo = v_articulo  INTO table artTmp"
						
						&v_sentencia
						
						SELECT artTmp
						GO TOP 
						
						
						
				
						
						v_detalle 		= &v_tablaCompuestosTMP..detalle
						v_cantidad 		= (&v_tablaCompuestosTMP..cantidad)*v_cantOT 
						v_unidad 		= &v_tablaCompuestosTMP..unidad
						v_idmate	 	= &v_tablaCompuestosTMP..idmate
						IF v_idmate > 0
						v_unitario 		= &v_tablaCompuestosTMP..costo
						ELSE
						v_unitario		= artTmp.pventa
						ENDIF 
*								
						
						
						v_observa		= &v_tablaCompuestosTMP..observa
						v_fechaentre 	= DTOS(DATE())
						v_cantidadFC 	= 0.00
						v_unidadFC 	 	= ''
						v_impuestos	 	= artTmp.impuestos
						v_impuesto	 	= 1
						v_neto		 	= v_unitario 
						v_razonimp	 	= artTmp.razonimpu
						v_total		 	= v_cantidad * v_unitario
						
						v_idtiponpot 	= v_idtipoNP 
						v_impr		 	= 'S'
						
					
						INSERT INTO otComponentes VALUES (v_idtipoot, v_articulo,v_detalle,v_cantidad, v_unidad, v_unitario,v_observa, ;
		 				v_fechaentre,v_cantidadfc,v_unidadfc, v_neto, v_impuestos, v_impuesto, v_razonimp, v_total,  v_idmate, v_idtiponp, v_impr)
		
				
				
					SELECT &v_tablaCompuestosTMP 
					SKIP 1

				ENDDO
			
			ENDIF 
			
		
			SELECT ot_sql
			SKIP 1

		ENDDO
		
		SELECT  otComponentes
		GO TOP 
		
		SELECT  otComponentes
		GO TOP 
		IF EOF() && La NP no tiene componentes -> Retorno 0
			RETURN rt_idnp		
		ENDIF 
	
		** Grabo la Cabecera de la Nota de Pedido **
			*** Grabo la Nota de Producción y sus Tablas Asociadas de acuerdo a la NP
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		v_idnp = 0
		v_idnp = maxnumeroidx("idnp","I","np",1)
		IF v_idnp <= 0
			MESSAGEBOX("No se pudo recuperar el ultimo indice de la NP",0+16,"Error")
			RETURN rt_idnp 
		ENDIF 
		
			cnp_idcomproba	= comproof_sql.idcomproba
			cnp_pventa		= comproof_sql.pventa
			cnp_numero		= maxnumerocom(cnp_idcomproba,cnp_pventa,1)
			
		
		SELECT np_sql
		GO TOP 
		
		v_idcomprobaNP = np_sql.idcomproba
		v_vendedor = np_sql.vendedor
		v_transporte = np_sql.transporte
		v_nombretran = np_sql.nombretran
		v_entidad = np_sql.entidad
		v_nombre = np_sql.nombre
		cnp_observa 	= "Nota de Producción asociada a NP: "+ALLTRIM(v_puntov)+'-'+v_numeroNP+'   '+ALLTRIM(STR(v_entidad))+'-'+ALLTRIM(v_nombre)
		v_tiponp = 4 && NOTA DE PRODUCCIÓN
		v_fechaEntre = np_sql.fechaentre
		

		DIMENSION lamatriz1(16,2)
		DIMENSION lamatriz2(20,2)
					
		lamatriz1(1,1)='idnp'
		lamatriz1(1,2)= ALLTRIM(STR(v_idnp))
		lamatriz1(2,1)='puntov'
		lamatriz1(2,2)="'"+ALLTRIM(v_puntov)+"'"
		lamatriz1(3,1)='numero'
		lamatriz1(3,2)= ALLTRIM(STR(cnp_numero))
		lamatriz1(4,1)='fecha'
		lamatriz1(4,2)= "'"+ALLTRIM(DTOS(DATE()))+"'"
		lamatriz1(5,1)='hora'
		lamatriz1(5,2)= "'"+ALLTRIM(SUBSTR(TTOC(DATETIME(),3),12,9))+"'"
		lamatriz1(6,1)='usuario'
		lamatriz1(6,2)="'"+ALLTRIM(_SYSUSUARIO)+"'"
		lamatriz1(7,1)='vendedor'
		lamatriz1(7,2)= ALLTRIM(STR(v_vendedor ))
		lamatriz1(8,1)='transporte'
		lamatriz1(8,2)= ALLTRIM(STR(v_transporte))
		lamatriz1(9,1)='nombretran'
		lamatriz1(9,2)="'"+ALLTRIM(v_nombretran)+"'"
		lamatriz1(10,1)='entidad'
		lamatriz1(10,2)=ALLTRIM(STR(v_entidad))
		lamatriz1(11,1)='nombre'
		lamatriz1(11,2)="'"+alltrim(v_nombre)+"'"
		lamatriz1(12,1)='observa'
		lamatriz1(12,2)="'"+ALLTRIM(cnp_observa)+"'"
		lamatriz1(13,1)='idtiponp'
		lamatriz1(13,2)= ALLTRIM(STR(v_tiponp))
		lamatriz1(14,1)='idcomproba'
		lamatriz1(14,2)=ALLTRIM(STR(cnp_idcomproba))
		lamatriz1(15,1)='pventa'
		lamatriz1(15,2)=ALLTRIM(STR(cnp_pventa))
		lamatriz1(16,1)='fechaentre'
		lamatriz1(16,2)= "'"+ALLTRIM(v_fechaEntre)+"'"

		p_tabla     = 'np'
		p_matriz    = 'lamatriz1'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+STR(cnp_numero),0+48+0,"Error")
		ENDIF  	
		RELEASE lamatriz1
		

		** Grabo el Detalle de la Nota de Producción a partir de la NP **

		SELECT otComponentes
		GO TOP 

		DO WHILE NOT EOF()
		 				
			v_id_ot 		= maxnumeroidx("idot","I","ot",1)
			v_idtipoot		= otComponentes.idtipoot
			v_articulo 		= otComponentes.articulo
			v_detalle 		= otComponentes.detalle
			v_cantidad 		= otComponentes.cantidad
			v_unidad 		= otComponentes.unidad
			v_unitario 		= otComponentes.unitario		
			v_observa		= otComponentes.observa
			v_fechaentre 	= otComponentes.fechaentre
			v_cantidadFC 	= otComponentes.cantidadFc
			v_unidadFC 	 	= otComponentes.unidadFc
			v_impuestos	 	= otComponentes.impuestos
			v_impuesto	 	= otComponentes.impuesto
			v_neto		 	= otComponentes.neto
			v_razonimp	 	= otComponentes.razonimp
			v_total		 	= otComponentes.total
			v_idmate	 	= otComponentes.idmate
			v_idtiponpot 	= otComponentes.idtiponp
			v_impr		 	= otComponentes.imprimir

			lamatriz2(1,1)='idnp'
			lamatriz2(1,2)=ALLTRIM(STR(v_idnp))
			lamatriz2(2,1)='idot'
			lamatriz2(2,2)=ALLTRIM(STR(v_id_ot))
			lamatriz2(3,1)='idtipoot'
			lamatriz2(3,2)=ALLTRIM(STR(v_idtipoot))
			lamatriz2(4,1)='articulo'
			lamatriz2(4,2)="'"+ALLTRIM(v_articulo)+"'"
			lamatriz2(5,1)='detalle'
			lamatriz2(5,2)= "'"+ALLTRIM(v_detalle)+"'"
			lamatriz2(6,1)='cantidad'
			lamatriz2(6,2)=ALLTRIM(STR(v_cantidad,13,4))
			lamatriz2(7,1)='unidad'
			lamatriz2(7,2)="'"+alltrim(v_unidad )+"'"
			lamatriz2(8,1)='unitario'
			lamatriz2(8,2)=ALLTRIM(STR(v_unitario,13,4))
			lamatriz2(9,1)='observa'
			lamatriz2(9,2)="'"+ALLTRIM(v_observa)+"'"
			lamatriz2(10,1)='fechaentre'
			lamatriz2(10,2)="'"+ALLTRIM(v_fechaentre)+"'"
			lamatriz2(11,1)='cantidadfc'
			lamatriz2(11,2)=ALLTRIM(STR(v_cantidadFC ,13,4))
			lamatriz2(12,1)='unidadfc'
			lamatriz2(12,2)="'"+ALLTRIM(v_unidadFC )+"'"
			lamatriz2(13,1)='impuestos'
			lamatriz2(13,2)=ALLTRIM(STR(v_impuestos,13,4))
			lamatriz2(14,1)='total'
			lamatriz2(14,2)=ALLTRIM(STR(v_total,13,4))
			lamatriz2(15,1)='impuesto'
			lamatriz2(15,2)=ALLTRIM(STR(v_impuesto))
			lamatriz2(16,1)='razonimp'
			lamatriz2(16,2)=ALLTRIM(STR(v_razonimp,13,4))
			lamatriz2(17,1)='neto'
			lamatriz2(17,2)=ALLTRIM(STR(v_neto,13,4))
			lamatriz2(18,1)='idmate'
			lamatriz2(18,2)=ALLTRIM(STR(v_idmate))
			lamatriz2(19,1)='idtiponp'
			lamatriz2(19,2)=ALLTRIM(STR(v_idtiponpot))
			lamatriz2(20,1)='imprimir'
			lamatriz2(20,2)="'"+ALLTRIM(v_impr)+"'"

			p_tabla     = 'ot'
			p_matriz    = 'lamatriz2'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
			ENDIF						
			
			
			SELECT otComponentes
			SKIP 1
		ENDDO	
		RELEASE lamatriz2



		*** Registro la relación de los comprobantes- En caso que tenga ***
		DIMENSION lamatrizli(5,2)

		v_idlinkcomp	= 0
		v_idregistroa	= pp_idnp
		v_idcomprobaa	= v_idcomprobaNP
		v_idregistrob 	= v_idnp
		v_idcomprobab	= cnp_idcomproba
			
		lamatrizli(1,1)='idlinkcomp'
		lamatrizli(1,2)= ALLTRIM(STR(v_idlinkcomp))
		lamatrizli(2,1)= 'idregistroa'
		lamatrizli(2,2)= ALLTRIM(STR(v_idregistroa))
		lamatrizli(3,1)= 'idcomprobaa'
		lamatrizli(3,2)= ALLTRIM(STR(v_idcomprobaa))
		lamatrizli(4,1)= 'idregistrob'
		lamatrizli(4,2)= ALLTRIM(STR(v_idregistrob))
		lamatrizli(5,1)= 'idcomprobab'
		lamatrizli(5,2)= ALLTRIM(STR(v_idcomprobab))

		p_tabla     = 'linkcompro'
		p_matriz    = 'lamatrizli'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" ",0+48+0,"Error")
		ENDIF			
		RELEASE lamatrizli
		
		
		
		RELEASE lamatriz
		RELEASE lamatriz2


		
		*********************************************************
		*** REGISTRO estado activo ***
		registrarEstado("np","idnp",v_idnp,"I","ACTIVO")
			
		*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
		guardaCajaRecaH (cnp_idcomproba, v_idnp)
		
		rt_idnp = v_idnp
	
	ENDIF
*!*		
*!*		USE IN presupu_sql
*!*		USE IN presupuh_sql
*!*		USE IN datosextra_sql
*!*		USE IN datosanexo_sql 
	=abreycierracon(vconeccionF,"")	
	
	IF rt_idnp > 0 THEN 
		IF MESSAGEBOX("¿Desea Imprimir la Nota de Producción Generada ?",4+32,"Imprimir Nota de Producción") = 6 THEN 
			=imprimirNP(rt_idnp)
		ENDIF 
	ENDIF 

RETURN rt_idnp 



FUNCTION filtrarTexto
PARAMETERS p_texto
*#/----------------------------------------
* FUNCIÓN QUE FILTRA EL TEXTO REEMPLAZANDO CARACTERES RAROS
* PARAMETROS: 	p_texto: texto a convertir
*				
* RETORNO: Retorna el texto convertido o vacio en caso de error
*#/----------------------------------------

*!*	 	&#160;	
*!*	¡	&#161;	
*!*	¢	&#162;
*!*	£	&#163;
*!*	¤	&#164;
*!*	¥	&#165;	
*!*	¦	&#166;	A6	&brvbar;	Barra partida
*!*	§	&#167;	A7	&sect;	Signo de sección
*!*	¨	&#168;	A8	&uml;	Diéresis
*!*	©	&#169;	A9	&copy;	Signo de derecho de copia (copyright)
*!*	ª	&#170;	AA	&ordf;	Indicador de ordinal femenino
*!*	«	&#171;	AB	&laquo;	Marca de acotación doble ángulo izquierdo
*!*	¬	&#172;	AC	&not;	Símbolo de No
*!*	­	&#173;	AD	&shy;	Guión suave
*!*	®	&#174;	AE	&reg;	Símbolo de Registrado
*!*	¯	&#175;	AF	&macr;	Acento de vocal larga (macrón)
*!*	°	&#176;	B0	&deg;	Símbolo de Grados
*!*	±	&#177;	B1	&plusmn;	Símbolo de más-menos
*!*	²	&#178;	B2	&sup2;	Superscript 2 (Símbolo de "al cuadrado")
*!*	³	&#179;	B3	&sup3;	Superscript 3 (Símbolo de "al cubo")
*!*	´	&#180;	B4	&acute;	Acento agudo
*!*	µ	&#181;	B5	&micro;	Símbolo de micro
*!*	¶	&#182;	B6	&para;	Símbolo de párrafo
*!*	·	&#183;	B7	&middot;	Punto medio
*!*	¸	&#184	B8	&cedil;	Cedilla
*!*	¹	&#185	B9	&sup1;	Superscript 1
*!*	º	&#186	BA	&ordm;	Indicador ordinal masculino
*!*	»	&#187	BB	&raquo;	Marca de acotación doble ángulo derecho
*!*	¼	&#188	BC	&frac14;	Fracción un cuarto
*!*	½	&#189;	BD	&frac12;	Fracción un medio
*!*	¾	&#190;	BE	&frac34;	Fracción tres cuartos
*!*	¿	&#191;	BF	&iquest;	Cerrar interrogación
*!*	À	&#192;	C0	&Agrave;	Letra mayúscula A con acento grave
*!*	Á	&#193;	C1	&Aacute;	Letra mayúscula A con acento agudo
*!*	Â	&#194;	C2	&Acirc;	Letra mayúscula A con acento circunflejo
*!*	Ã	&#195;	C3	&Atilde;	Letra mayúscula A con tilde
*!*	Ä	&#196;	C4	&Auml;	Letra mayúscula A con diéresis
*!*	Å	&#197;	C5	&Aring;	Letra mayúscula A con anillo encima
*!*	Æ	&#198;	C6	&AElig;	Letra mayúscula AE
*!*	Ç	&#199;	C7	&Ccedil;	Letra mayúscula C con cedilla
*!*	È	&#200;	C8	&Egrave;	Letra mayúscula E con acento grave
*!*	É	&#201;	C9	&Eacute;	Letra mayúscula E con acento agudo
*!*	Ê	&#202;	CA	&Ecirc;	Letra mayúscula E con acento circunflejo
*!*	Ë	&#203;	CB	&Euml;	Letra mayúscula E con diéresis
*!*	Ì	&#204;	CC	&Igrave;	Letra mayúscula I con acento grave
*!*	Í	&#205;	CD	&Iacute;	Letra mayúscula I con acento agudo
*!*	Î	&#206;	CE	&Icirc;	Letra mayúscula I con acento circunflejo
*!*	Ï	&#207;	CF	&Iuml;	Letra mayúscula I con diéresis
*!*	Ð	&#208;	D0	&ETH;	Letra mayúscula Eth (Inglés, Islandés, Feroés y Escandinavo antíguos)
*!*	Ñ	&#209;	D1	&Ntilde;	Letra mayúscula N con tilde
*!*	Ò	&#210;	D2	&Ograve;	Letra mayúscula O con acento grave
*!*	Ó	&#211;	D3	&Oacute;	Letra mayúscula O con acento agudo
*!*	Ô	&#212;	D4	&Ocirc;	Letra mayúscula O con acento circunflejo
*!*	Õ	&#213;	D5	&Otilde;	Letra mayúscula O con tilde
*!*	Ö	&#214;	D6	&Ouml;	Letra mayúscula O con diéresis
*!*	×	&#215;	D7	&times;	Signo de la multiplicación
*!*	Ø	&#216;	D8	&Oslash;	Letra mayúscula O barrada
*!*	Ù	&#217;	D9	&Ugrave;	Letra mayúscula U con acento grave
*!*	Ú	&#218,	DA	&Uacute;	Letra mayúscula U con acento agudo
*!*	Û	&#219;	DB	&Ucirc;	Letra mayúscula U con acento circunflejo
*!*	Ü	&#220;	DC	&Uuml;	Letra mayúscula U con diéresis
*!*	Ý	&#221;	DD	&Yacute;	Letra mayúscula Y con acento agudo
*!*	Þ	&#222;	DE	&THORN;	Letra mayúscula Thorn (Inglés, Islandés, Feroés y Escandinavo antíguos)
*!*	ß	&#223;	DF	&szlig;	Letra minúscula s picante
*!*	à	&#224;	E0	&agrave;	Letra minúscula a con acento grave
*!*	á	&#225;	E1	&aacute;	Letra minúscula a con acento agudo
*!*	â	&#226;	E2	&acirc;	Letra minúscula a con acento circunflejo
*!*	ã	&#227;	E3	&atilde;	Letra minúscula a con tilde
*!*	ä	&#228;	E4	&auml;	Letra minúscula a con diéresis
*!*	å	&#229;	E5	&aring;	Letra minúscula a con anillo encima
*!*	æ	&#230;	E6	&aelig;	Letra minúscula ae
*!*	ç	&#231;	E7	&ccedil;	Letra minúscula c con cedilla
*!*	è	&#232;	E8	&egrave;	Letra minúscula e con acento grave
*!*	é	&#233;	E9	&eacute;	Letra minúscula e con acento agudo
*!*	ê	&#234;	EA	&ecirc;	Letra minúscula e con acento circunflejo
*!*	ë	&#235;	EB	&euml;	Letra minúscula e con diéresis
*!*	ì	&#236;	EC	&igrave;	Letra minúscula i con acento grave
*!*	í	&#237;	ED	&iacute;	Letra minúscula i con acento agudo
*!*	î	&#238;	EE	&icirc;	Letra minúscula i con acento circunflejo
*!*	ï	&#239;	EF	&iuml;	Letra minúscula i con diéresis
*!*	ð	&#240;	F0	&eth;	Letra minúscula eth
*!*	ñ	&#241;	F1	&ntilde;	Letra minúscula n con tilde
*!*	ò	&#242;	F2	&ograve;	Letra minúscula o con acento grave
*!*	ó	&#243;	F3	&oacute;	Letra minúscula o con acento agudo
*!*	ô	&#244;	F4	&ocirc;	Letra minúscula o con acento circunflejo
*!*	õ	&#245;	F5	&otilde;	Letra minúscula o con tilde
*!*	ö	&#246;	F6	&ouml;	Letra minúscula o con diéresis
*!*	÷	&#247;	F7	&divide;	Signo de la división
*!*	ø	&#248;	F8	&oslash;	Letra minúscula o barrada
*!*	ù	&#249;	F9	&ugrave;	Letra minúscula u con acento grave
*!*	ú	&#250;	FA	&uacute;	Letra minúscula u con acento agudo
*!*	û	&#251;	FB	&ucirc;	Letra minúscula u con acento circunflejo
*!*	ü	&#252;	FC	&uuml;	Letra minúscula u con diéresis
*!*	ý	&#253;	FD	&yacute;	Letra minúscula y con acento agudo
*!*	þ	&#254;	FE	&thorn;	Letra minúscula thorn
*!*	ÿ	&#255	FF	&yuml;	Letra minúscula y con diéresis


ENDFUNC 

FUNCTION obtenerContribuyente 
PARAMETERS p_tablaRetorno, p_cuitContrib, p_nomsg
*#/----------------------------------------
* FUNCIÓN PARA OBTENER LOS DATOS DE UN CONTRIBUYENTE REGISTRADO EN AFIP
* PARAMETROS: 	p_tablaRetorno: Nombre de la tabla donde se van a retornar los datos del contribuyente encontrado
*				p_cuitContrib: CUIT del contribuyente a buscar en el AFIP	
*				p_nomsg: Parámetro para indicar si se van a mostrar los mensajes de error. Por defecto no muestra mensajes
* RETORNO: Retorna True si no hubo errores al intentar obtener los datos del contribuyente, retorna False en caso que haya ocurrido un error.
*#/----------------------------------------


	v_retorno = .F.


TRY 

			v_tipoObj = TYPE("objModuloAFIP")
			
			IF v_tipoObj <> "O" && No se creo el objeto
			
				public objModuloAFIP
				objModuloAFIP = CREATEOBJECT("ModuloAFIP.ModuloAFIP")
				
			ENDIF 
			
			
			v_objconfigurado = objModuloAFIP.Configurado 
		
			IF v_objConfigurado = .F.
			
			
				v_ubicacionCertificado = STRTRAN(ALLTRIM(_SYSSERVIDOR+"AFIP\"+ALLTRIM(_SYSNOMBRECERT)),"\","\\")
				v_cuitSinGuiones	 	= ALLTRIM(STRTRAN(_SYSCUIT,'-',''))
				v_ticketAcceso			= STRTRAN(ALLTRIM(_SYSSERVIDOR+"AFIP\"+"TA"+v_cuitSinGuiones),"\","\\")
				v_log					= STRTRAN(ALLTRIM(_SYSSERVIDOR+"AFIP\"+"LOG"+v_cuitSinGuiones+".txt"),"\","\\")
					
									
				v_objconfigurado	= objModuloAFIP.CargaConfiguracion(ALLTRIM(_SYSSERVICIOFE), ALLTRIM(_SYSURLWSAA), ALLTRIM(_SYSSERVICIOAFIP), ALLTRIM(_SYSPROXY), ALLTRIM(_SYSPROXYUSU), ALLTRIM(_SYSPROXYPASS), ALLTRIM(v_ubicacionCertificado), ALLTRIM(v_ticketAcceso), _SYSINTAUT, _SYSINTTA, ALLTRIM(_SYSNOMFISCAL), ALLTRIM(_SYSCUIT), ALLTRIM(v_log), ALLTRIM(_SYSSERVCONTRIB),ALLTRIM(_SYSSERVICIOPER))

				IF v_objconfigurado = .T.
				
					v_objerror = objModuloAFIP.Error
					
					IF v_objerror = .T.
					
						v_errores = ""
						v_errores = objModuloAFIP.Errores
						IF p_nomsg = .f. THEN 
							MESSAGEBOX("Errores: "+ALLTRIM(v_errores))
						ENDIF 
						
						RETURN .F.
					ENDIF 
						
					v_observaciones = objModuloAFIP.Observaciones
					IF EMPTY(v_observaciones) = .F.
						IF p_nomsg = .f. THEN
							MESSAGEBOX("Observaciones: "+ALLTRIM(v_observaciones))
						ENDIF 
					ENDIF 
					
								
				ELSE
						IF p_nomsg = .f. THEN
							MESSAGEBOX("Configuración del modulo AFIP INCORRECTA")
						ENDIF 			
					v_objerror = objModuloAFIP.Error
					
					IF v_objerror = .T.
					
						v_errores = ""
						v_errores = objModuloAFIP.Errores
						IF p_nomsg = .f. THEN 
							MESSAGEBOX("Errores: "+ALLTRIM(v_errores))
						ENDIF 
					ENDIF 
						
					v_observaciones = objModuloAFIP.Observaciones
					
					IF p_nomsg = .f. THEN 
						MESSAGEBOX("Observaciones: "+ALLTRIM(v_observaciones))
					ENDIF 
							
					RETURN .F.
					
				ENDIF 
			ENDIF 
						
		
			v_cuitSinGuiones	 	= ALLTRIM(STRTRAN(p_cuitContrib,'-',''))


			v_ubicacionXML = _SYSESTACION+"\"+"contrib_"+ALLTRIM(v_cuitSinGuiones)+".xml"
			
			v_respuesta = objModuloAFIP.obtenerContribuyente(v_ubicacionXML,v_cuitSinGuiones)

					

			IF v_respuesta =  .T.
								
				** Creo la tabla para retonar los datos del contribuyente **
    
				
				v_sentencia1 = " CREATE TABLE "+ ALLTRIM(p_tablaRetorno)+" FREE (apellido C(100), nombre C(100),cp C(50), "
				v_sentencia2 = " nomprov C(60), direccion C(200), nomLoc C(200),tipoDoc C(20), documento C(20),razonSoc C(100), iva I) "

				v_sentencia = v_sentencia1 + v_sentencia2
				&v_sentencia 
				
				SELECT &p_tablaRetorno
				
				*!*	Un ejemplo rápido de uso, del objto XMLDOMDocument

				*!*	?oDocumento.XML (contenido del documento)
				*!*	?oDocumento.documentElement.nodeName (nombre del root)
				*!*	?oDocumento.documentElement.hasChildNode (nodos hijos)
				*!*	?oDocumento.documentElement.nextNode.nodeName (siguiente nivel, nombre del nodo)
				*!*	?oDocumento.documentElement.childNodes.length (total de nodos hijos)
				*!*	?oDocumento.documentElement.childNodes.Item(0).attributes(1).Text (dato contenido en el nodo)

				oDocumento = CREATEOBJECT("msxml.domdocument")
				oDocumento.Load(v_ubicacionXML)
				v_tamError = oDocumento.getElementsByTagName("error").length
				IF v_tamError > 0
					** Si existe un error o un problema con el contribuyente lo muestra y retorna Falso
					v_error = oDocumento.getElementsByTagName("error").item(0).text
					IF p_nomsg = .F.
						MESSAGEBOX(ALLTRIM(v_error),0+16+0,"Error al obtener el contribuyente")
					ENDIF 
					
					RETURN .F.
							
				ENDIF 
				
				** Controlo Tipo de persona 
				
				v_tipoPersona = oDocumento.getElementsByTagName("tipoPersona").item(0).text
				v_nombre = ""
				v_apellido = ""
				v_razonSoc = ""
				
				DO CASE
				CASE ALLTRIM(v_tipoPersona) = "FISICA"
					v_apellido =	oDocumento.getElementsByTagName("apellido").item(0).text
					v_nombre =	oDocumento.getElementsByTagName("nombre").item(0).text
				CASE ALLTRIM(v_tipoPersona) = "JURIDICA"
					v_razonSoc = oDocumento.getElementsByTagName("razonSocial").item(0).text
				OTHERWISE
				
					v_tamApellidos = oDocumento.getElementsByTagName("apellido").length
					
					IF v_tamApellidos > 0
						v_apellido =	oDocumento.getElementsByTagName("apellido").item(0).text
						v_nombre =	oDocumento.getElementsByTagName("nombre").item(0).text
					ELSE
						v_razonSoc = oDocumento.getElementsByTagName("razonSocial").item(0).text
					ENDIF 

				ENDCASE
				
			
				v_codPostal =	oDocumento.getElementsByTagName("codPostal").item(0).text
				v_nomProv =	oDocumento.getElementsByTagName("descripcionProvincia").item(0).text
				v_direccion =	oDocumento.getElementsByTagName("direccion").item(0).text
				v_nomLoc =	oDocumento.getElementsByTagName("localidad").item(0).text
				v_tipoDoc =	oDocumento.getElementsByTagName("tipoClave").item(0).text
				v_documento =	oDocumento.getElementsByTagName("idPersona").item(0).text
				
				v_codPostal  = IIF(TYPE('v_codPostal')='N',STR(v_codPostal),v_codPostal)
				
				v_documento = IIF(TYPE('v_documento')='N',STR(v_documento),v_documento )
				
				v_cantImpuesto = oDocumento.getElementsByTagName("idImpuesto").length
				v_idimpuesto = ""
			
				IF v_cantImpuesto > 0
					
					FOR i = 0 TO (v_cantImpuesto -1)
					
						IF i = 0
							v_idimpuesto = ALLTRIM(oDocumento.getElementsByTagName("idImpuesto").item(i).text)
						ELSE
							v_idimpuesto = v_idimpuesto +","+ALLTRIM(oDocumento.getElementsByTagName("idImpuesto").item(i).text)
						ENDIF 
											
					ENDFOR 

					
					*v_idimpuesto = IIF(TYPE('v_idimpuesto')='C',VAL(v_idimpuesto),v_idimpuesto)
				ELSE
					v_idimpuesto = "0"
				ENDIF 
				
				
				
				
				* Me conecto a la BD
				vconimp = abreycierracon(0,_SYSSCHEMA)

				*sqlmatriz(1)=" select * from condfiscal where afipimpu = "+ALLTRIM(STR(v_idimpuesto))
				sqlmatriz(1)=" select * from condfiscal where afipimpu in ("+ALLTRIM(v_idimpuesto)+")"

				verror=sqlrun(vconimp,"impuestoAfip_Sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los tipos de Impuestos ",0+48+0,"Error")
				    v_autorizar = .F.
					RETURN v_autorizar
				ENDIF 

				SELECT  impuestoAfip_Sql
				GO TOP 
				
				IF NOT EOF()
					
					v_iva = impuestoAFIP_sql.iva
				ELSE
					v_iva = 0 
					
				ENDIF 


				* Me desconecto de la BD
				abreycierracon(vconimp,"")
				
				*** -1: CONSUMIDOR FINAL
				***  0: EXENTO?
				*** 20: MONOTRIBUTO
				*** 30: IVA
				
				
				
				
				v_sentIns1 = "INSERT INTO "+ALLTRIM(p_tablaRetorno)+ " VALUES ('"+ALLTRIM(v_apellido)+"','"+ALLTRIM(v_nombre)+"','"+ALLTRIM(v_codPostal)+"',"
				v_sentIns2 = "'"+ALLTRIM(v_nomProv)+"','"+ALLTRIM(v_direccion)+"','"+ALLTRIM(v_nomLoc)+"','"+ALLTRIM(v_tipoDoc)+"','"+ALLTRIM(v_documento)+"','"+alltrim(v_razonSoc)+"',"+ALLTRIM(STR(v_iva))+")"
				

				v_sentIns = v_sentIns1 + v_sentIns2
				&v_sentIns

				SELECT &p_tablaRetorno
				GO TOP 
				
				v_retorno = .T.
		
			ELSE
			
				
				v_retorno = .F.
			ENDIF 
		
		
		
		
		
*!*			
*!*			CATCH TO loException
			
 				
			IF p_nomsg = .f. THEN 
	*			MESSAGEBOX(lcErrorMsg,0+48+0,"Se produjo un Error")
	*			MESSAGEBOX(loException.message,0+48+0,"Se produjo un Error")
			ENDIF
			
*!*				THROW loException
*!*				
*!*				FINALLY 

*!*				v_autorizar = .F.
*!*				RETURN v_autorizar
*!*						    								
*!*			ENDTRY 
							
							
							
												
	CATCH TO loException
			
			sqlmatriz(1) = ""	
			IF p_nomsg = .f. THEN 
	*			MESSAGEBOX(lcErrorMsg,0+48+0,"Se produjo un Error")
			
				MESSAGEBOX(loException.message,0+48+0,"Se produjo un Error")
			ENDIF 
			v_autorizar = .F.
*!*				RETURN v_autorizar

	
			
*!*		FINALLY
*!*			RETURN v_autorizar
	ENDTRY	
	RETURN v_retorno


ENDFUNC 



FUNCTION AnularTransfe
PARAMETERS pIdregistro

*#/----------------------------------------
**** INICIO FUNCION ANULAR TRANSFERENCIAS **************
**********************************************************
** FUNCIÓN para anular Trasferencias Bancarias
** Parametros: pIdRegistro: Id del registro de la tabla Transferencias que se desea anular.
** Retorno: Retorna ID del registro de anulación. 0 en caso que no se haya registrado
**********************************************************
*#/----------------------------------------


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


FUNCTION cargarLocalidad
PARAMETERS p_nomLoc_car, p_cp_car, p_nomProv_car, p_nomPais_car
*#/----------------------------------------
**** FUNCION PARA CARGAR UNA LOCALIDAD POR NOMBRE DE LOCALIDAD, PROVINCIA y CP ****
** PARAMETROS:
* p_nomloc: Nombre de la localidad que se va a crear
* p_cp: Codigo postal de la localidad que se va a crear
* p_nomProv: Nombre de la provincia correspondiente
* p_nomPais: Pais de la localidad, en caso de no recibir un pais toma por defecto 'ARGENTINA'
** RETORNO: Retorna el numero de localidad, cero en caso de ocurrir un error
*#/----------------------------------------


	IF TYPE('p_nomPais_car') <> 'C'
		p_nomPais = "ARGENTINA"
	ENDIF 
	* Me conecto a la base de datos *
	vconeccion_car=abreycierracon(0,_SYSSCHEMA)	
		
	sqlmatriz(1)=" Select l.localidad, l.nombre as nomLoc, l.cp, pr.provincia, pr.nombre as nomProv, pa.pais, pa.nombre as nomPais "
	sqlmatriz(2)=" from paises pa left join provincias pr on pa.pais = pr.pais left join localidades l  on pr.provincia = l.provincia "
	sqlmatriz(3)=" where pa.nombre = '"+ALLTRIM(p_nomPais_car)+"' and pr.nombre = '"+ALLTRIM(p_nomProv_car) + "' and l.nombre = '"+ALLTRIM(p_nomLoc_car)+"'"

	verror=sqlrun(vconeccion_car,"localidad_sql_car")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la comprobanción de la localidad ",0+48+0,"Error")
	    
	    RETURN 0
	ENDIF 

	SELECT localidad_sql_car
	GO TOP 
	IF NOT EOF()
	
		
*!*			** Existe la localidad **
*!*			MESSAGEBOX("La localidad que intenta ingresar ya se encuentra cargada",0+48+0,"Cargar localidad")
*!*			
		v_idloc_car = localidad_sql_car.localidad
	
		* me desconecto	
			=abreycierracon(vconeccion_car,"")
		RETURN v_idloc_car	
			
	ELSE
		** No existe la localidad, la puedo cargar **
		sqlmatriz(1)=" Select pr.provincia, pr.nombre as nomProv, pa.pais, pa.nombre as nomPais "
		sqlmatriz(2)=" from paises pa left join provincias pr on pa.pais = pr.pais "
		sqlmatriz(3)=" where pa.nombre = '"+ALLTRIM(p_nomPais_car)+"' and pr.nombre = '"+ALLTRIM(p_nomProv_car)+"'"

		verror=sqlrun(vconeccionF,"provPais_sql_car")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de la información de la Provincia-Pais",0+48+0,"Error")
		    * me desconecto	
			=abreycierracon(vconeccion_car,"")
		    RETURN 0
		ENDIF 
		
		SELECT provPais_sql_car
		GO TOP 
		
		IF NOT EOF()
			*** Existe la provincia y el pais -> Creo la localidad **
						
			SELECT provPais_sql_car
			v_provincia_car = provPais_sql_car.provincia
			
			sqlmatriz(1)="SELECT MAX(CAST(localidad as unsigned)) AS maxi FROM localidades  "
			verror=sqlrun(vconeccionF,"maximo_car")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo código de Localidades ",0+48+0,"Error")
			    * me desconecto	
					=abreycierracon(vconeccion_car,"")
				RETURN 0
			ENDIF 

			*v_cod_loc  = INT(VAL(localidades.localidad))

			v_maximo_car = INT(VAL(maximo_car.maxi))


			SELECT maximo_car
			GO TOP 
			IF EOF() AND RECNO()=1 THEN 
				v_cod_loc_car = 1
			ELSE
				v_cod_loc_car = v_maximo_car + 1
			ENDIF 
			USE IN maximo
			
			p_tipoope_car     = 'I'
			p_condicion_car   = ''
			v_titulo_car      = " EL ALTA "
							
			DIMENSION lamatriz_car(4,2)
			
			lamatriz(1,1) = 'localidad'
			lamatriz(1,2) = "'"+ALLTRIM(STR(v_cod_loc_car))+"'"
			lamatriz(2,1) = 'nombre'
			lamatriz(2,2) = "'"+ALLTRIM(v_nomLoc_car)+"'"
			lamatriz(3,1) = 'cp'
			lamatriz(3,2) = "'"+ALLTRIM(v_cp_car)+"'"
			lamatriz(4,1) = 'provincia'
			lamatriz(4,2) = "'"+ALLTRIM(v_provincia_car)+"'"

			p_tabla_car     = 'localidades'
			p_matriz_car    = 'lamatriz_car'
			p_conexion_car  = vconeccion_car
			IF SentenciaSQL(p_tabla_car,p_matriz_car,p_tipoope_car,p_condicion_car,p_conexion_car) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo_car+" de la Localidad "+ALLTRIM(v_cod_loc_car)+"-"+;
			                ALLTRIM(v_nomLoc_car),0+48+0,"Error")
			            * me desconecto	
			=abreycierracon(vconeccion_car,"")    
			    RETURN v_cod_loc_car
			ENDIF 
			* me desconecto	
			=abreycierracon(vconeccion_car,"")
		
			RETURN v_cod_loc_car
		ELSE
			MESSAGEBOX("NO se encuentra la provincia, debe cargar la provincia correspondiente",0+16+0,"Error")
			* me desconecto	
			=abreycierracon(vconeccion_car,"")
		
			RETURN 0
			
		ENDIF 
		
		
	
	ENDIF 
		

ENDFUNC 




FUNCTION GenerarTablasR
*#/**
*** Genera / Regenera las Tablas de Resultados relacionadas con las Vistas
*#/**	
	WAIT windows "Aguarde... Regenerando Tablas..." NOWAIT  
	
	* Me conecto a la base de datos *
	vconeccionF=abreycierracon(0,_SYSSCHEMA)	
	
	sqlmatriz(1)=" call p_creartablasr_() "
	verror=sqlrun(vconeccionF,"Tablas_R")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Generacion de las Tablas de Resultado ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	* me desconecto	
	=abreycierracon(vconeccionF,"")

	WAIT CLEAR 	
	** Existe la localidad **
	MESSAGEBOX("Se han Regenerado las Tablas de Resultados de las Vistas... ",0+48+0,"Generar/Regenerar Tablas Resultados")

ENDFUNC 



FUNCTION Aso_StockArt
*#/- Tipo de funciones de búsquedas de Datos en Esquemas Asociados
*----------------------------------------------------------------
** Obtiene el Stock de Artículos de las bases de Datos asociadas
* * retorna una tabla con el stock de artículos en los esquemas asociados
*#/----------------------------------------------------------------

	valias = ALIAS()
	
	v_stockreto = 'stockreto'+frandom()
	
	* Me conecto a la base de datos *
	vconeccionA=abreycierracon(0,_SYSSCHEMA)	
	* Obtengo los datos de los esquemas asociados
	sqlmatriz(1)=" select * from dbasociada "
	verror=sqlrun(vconeccionA,"dbasociada_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error al Obtener los esquemas asociados ",0+48+0,"Error")
		* me desconecto	
		=abreycierracon(vconeccionA,"")
		SELECT &valias
	    RETURN ""
	ENDIF 
	
	SELECT dbasociada_sql
	GO TOP 
	IF EOF() THEN 
		USE IN dbasociada_sql
		* me desconecto	
		=abreycierracon(vconeccionA,"")
		SELECT &valias
		RETURN ""
	ENDIF 
	* me desconecto	
	=abreycierracon(vconeccionA,"")

	* Arranco a recorrer los esquemas asociados y traerme los stock de cada uno
	* Guardo el esquema en el que estoy trabajando 
	CREATE TABLE stockreto (articulo c(20), stocktot y)
	
	vs_db_sysbgproce = _SYSBGPROCE 
	_SYSBBPROCE = 0 && detiene la ejecucion de procesos de Relojes en Segundo Plano
	vs_db_server = _SYSMYSQL_SERVER
	vs_db_user   = _SYSMYSQL_USER	
	vs_db_pass   = _SYSMYSQL_PASS  
	vs_db_port   = _SYSMYSQL_PORT  
	vs_db_schema = _SYSSCHEMA    
	vs_db_descrip= _SYSDESCRIP  

	SELECT dbasociada_sql 
	GO TOP 
	DO WHILE !EOF()

		_SYSMYSQL_SERVER = ALLTRIM(dbasociada_sql.host) 
		_SYSMYSQL_USER	 = ALLTRIM(dbasociada_sql.usuario)   	
		_SYSMYSQL_PASS 	 = ALLTRIM(dbasociada_sql.password)
		_SYSMYSQL_PORT 	 = ALLTRIM(dbasociada_sql.port)
		_SYSSCHEMA    	 = ALLTRIM(dbasociada_sql.schemma)
		_SYSDESCRIP  	 = ALLTRIM(dbasociada_sql.descrip)

		* Me conecto a la base de datos *
		vconeccionA=abreycierracon(0,_SYSSCHEMA)	

		sqlmatriz(1)=" select * from r_articulostock "
		verror=sqlrun(vconeccionA,"r_articulostock_asql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al Obtener el Stock en Esquemas Asociados ",0+48+0,"Error")
			* me desconecto	

			_SYSMYSQL_SERVER = vs_db_server 
			_SYSMYSQL_USER	 = vs_db_user   	
			_SYSMYSQL_PASS 	 = vs_db_pass   
			_SYSMYSQL_PORT 	 = vs_db_port   
			_SYSSCHEMA    	 = vs_db_schema 
			_SYSDESCRIP  	 = vs_db_descrip
			_SYSBGPROCE 	 = vs_db_sysbgproce
			=abreycierracon(vconeccionA,"")
			USE IN dbasociada_sql
			
			SELECT &valias
		    RETURN ""
		ENDIF 		
		SELECT * FROM r_articulostock_asql INTO TABLE r_articulostocksql
		SELECT r_articulostocksql
		replace stocktot WITH 0 FOR ISNULL(stocktot)
		
		SELECT stockreto
		APPEND FROM .\r_articulostocksql
		USE IN r_articulostocksql
		USE IN r_articulostock_asql

		* me desconecto	
		=abreycierracon(vconeccionA,"")
		
		SELECT dbasociada_sql
		SKIP 	
	ENDDO 

	
	SET ENGINEBEHAVIOR 70
	SELECT articulo, SUM(IIF(ISNULL(stocktot),0,stocktot)) as stock FROM stockreto INTO TABLE &v_stockreto GROUP BY articulo 
	SET ENGINEBEHAVIOR 90
	
	USE IN stockreto
	USE IN &v_stockreto
	USE IN dbasociada_sql

	_SYSMYSQL_SERVER = vs_db_server 
	_SYSMYSQL_USER	 = vs_db_user   	
	_SYSMYSQL_PASS 	 = vs_db_pass   
	_SYSMYSQL_PORT 	 = vs_db_port   
	_SYSSCHEMA    	 = vs_db_schema 
	_SYSDESCRIP  	 = vs_db_descrip
	_SYSBGPROCE 	 = vs_db_sysbgproce

	SELECT &valias
	RETURN v_stockreto 
ENDFUNC 





FUNCTION SaldosEntidad
PARAMETERS p_Enti, p_tablareto, p_cone
*/
*---------------------------------------------------------------
* Función para obtener los Comprobantes con Saldo Disponibles de una Entidad, a favor o en Contra
* Parametros: p_Entidad: Entidad para el Calculo del Saldo disponible
* 			  p_tablaret: Nombre de la tabla temporaria en la cual se retornaran los comprobantes con saldos a favor o en contra
*			  p_cone: si recibe la conexion, entonces no cierra ni abre, usa la conexion recibida
* Retorno: Retona una Tabla con los comprobantes con saldos, Facturas, recibos y NC con saldo a favor o en Contra de la entidad
*---------------------------------------------------------------
*/
	IF !(TYPE("p_tablareto") = 'C') THEN 
		RETURN ""
	ENDIF 

	v_cerrar = .t.
	IF TYPE("p_cone") = 'N'  THEN && Se le Paso la Conexion entonces no abre ni cierra 
		IF p_cone > 0 THEN 
			vconeccionFv = p_cone
			v_cerrar = .f.
		ELSE 
			vconeccionFv = abreycierracon(0,_SYSSCHEMA)
		ENDIF 
	ELSE 
		vconeccionFv = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	


	sqlmatriz(1)= " select f.idfactura as idregistro, f.idcomproba, f.fecha,  c.tabla, r.saldof as saldo , t.opera, "
	sqlmatriz(2)= " p.puntov, f.tipo, f.numero, f.entidad, f.apellido, f.nombre, f.total, c.comprobante as comproba "
	sqlmatriz(3)= " from r_facturasaldo r "
	sqlmatriz(4)= " left join facturas f on f.idfactura = r.idfactura "
	sqlmatriz(5)= " left join comprobantes c on f.idcomproba = c.idcomproba "
	sqlmatriz(6)= " left join tipocompro t on t.idtipocompro = c.idtipocompro "
	sqlmatriz(7)= " left join puntosventa p on p.pventa = f.pventa "
	sqlmatriz(8)= " where f.entidad = "+STR(p_Enti)+" and r.saldof > 0  "
	
	sqlmatriz(9)= " union ( select re.idrecibo as idregistro, re.idcomproba, re.fecha, c.tabla, r.saldo as saldo , t.opera, "
	sqlmatriz(10)= " p.puntov, 'X' as tipo, re.numero, re.entidad, re.apellido, re.nombre, re.importe as total, c.comprobante as comproba "
	sqlmatriz(11)= " from r_recibossaldo r "
	sqlmatriz(12)= " left join recibos re on re.idrecibo = r.idrecibo "
	sqlmatriz(13)= " left join comprobantes c on re.idcomproba = c.idcomproba "
	sqlmatriz(14)= " left join tipocompro t on t.idtipocompro = c.idtipocompro "
	sqlmatriz(15)= " left join puntosventa p on p.pventa = re.pventa "
	sqlmatriz(16)= " left join ultimoestado u on u.tabla = 'recibos' and u.id = re.idrecibo "
	sqlmatriz(17)= " where re.entidad = "+STR(p_Enti)+" and u.idestador <> 2 and r.saldo > 0 ) "
	
	verror=sqlrun(vconeccionFv,"saldos_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error al Obtener el Stock en Esquemas Asociados ",0+48+0,"Error")
		* me desconecto	
	ENDIF 
	
	SELECT * FROM saldos_sql INTO TABLE &p_tablareto ORDER BY fecha, numero 
	
	USE IN saldos_sql
	SELECT &p_tablareto
	ALTER table &p_tablareto alter COLUMN idregistro i
	ALTER table &p_tablareto alter COLUMN idcomproba i
	ALTER table &p_tablareto alter COLUMN fecha c(8)
	ALTER table &p_tablareto alter COLUMN tabla c(50)
	ALTER table &p_tablareto alter COLUMN saldo y
	ALTER table &p_tablareto alter COLUMN opera i
	
	USE IN &p_tablareto
	
	IF v_cerrar = .t.  THEN && Se le Paso la Conexion entonces no abre ni cierra 
		* me desconecto	
		=abreycierracon(vconeccionFv,"")
	ENDIF 

	RETURN p_tablareto
ENDFUNC 






FUNCTION BuscaFunciones
PARAMETERS P_libreriasprg
*/ ------------------------------
*Busca Funciones y arma un listado de todas las funciones definidas en los .prg
*/--------------------------------
	v_defa = SYS(5)+'\' 
	SET DEFAULT TO &v_defa

	v_prgpath = ALLTRIM(GETDIR())

	IF EMPTY(v_prgpath) THEN 
		SET DEFAULT TO &_SYSESTACION 
		RETURN "" 
	ELSE
		SET default TO &v_prgpath 
	ENDIF 
	v_retorno = ALLTRIM(v_prgpath)+'ProcessarPFN.txt'

	IF FILE('ProcessarPFN.txt') THEN 
		DELETE FILE 'ProcessarPFN.txt' 
	ENDIF 
	v_NombreArchi="ProcessarPFN.txt"		
	H=FCREATE(v_NombreArchi,0)
	IF H < 0 THEN 
		MESSAGEBOX("No se pudo CREAR el Archivo de Listado de Funciones ",0+48+0,"Error") 
		RETURN 
	ENDIF 
	
	ADIR (arrayprg,"*.prg")
	v_filas=ALEN(arrayprg,1)
	FOR i = 1 TO v_filas 
		v_libreria = ALLTRIM(UPPER(arrayprg(i,1)))
		v_funcproc = ""
		IF ATC(ALLTRIM(UPPER(arrayprg(i,1))),ALLTRIM(UPPER(P_libreriasprg)))>0 THEN 

			PUNTERO = FOPEN(ALLTRIM(UPPER(arrayprg(i,1))),0)
			v_comentario = .f.
			v_comentlinea = 0
			IF PUNTERO > 0 THEN
				DO WHILE !FEOF(PUNTERO) 
					v_LineaLeida = ALLTRIM(FGETS(PUNTERO))
					IF SUBSTR((ALLTRIM(v_lineaLeida)+'   '),1,3)='*#/' THEN 
						v_comentario = !v_comentario
						v_comentlinea = 0
					ENDIF 
					IF SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'        '),1,8)="FUNCTION" OR SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'         '),1,9)="PROCEDURE" THEN 
						v_funcproc = ALLTRIM(v_LineaLeida)
					ENDIF 
					IF SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'        '),1,8)="FUNCTION" OR SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'         '),1,9)="PROCEDURE" OR SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'         '),1,9)="PARAMET" OR v_comentario ;
						OR SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'   '),1,3)="*#/" THEN 
						IF SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'        '),1,8)="FUNCTION" OR SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'         '),1,9)="PROCEDURE"  OR SUBSTR((UPPER(ALLTRIM(v_LineaLeida))+'         '),1,7)="PARAMET" THEN 
						ENDIF 
						IF v_comentario = .t. OR SUBSTR(ALLTRIM(v_LineaLeida)+'   ',1,3)="*#/" THEN  
							vpyc = ';;'
						ELSE
							vpyc = ';'
						ENDIF 
						IF v_comentario = .f. THEN 
							=FPUTS(H,ALLTRIM(v_libreria)+';'+v_funcproc+vpyc+v_LineaLeida)
						ENDIF 
						IF v_comentario = .t. AND v_comentlinea <= 30 THEN 
							=FPUTS(H,ALLTRIM(v_libreria)+';'+v_funcproc+vpyc+v_LineaLeida)
							v_comentlinea = v_comentlinea + 1
						ENDIF 
					ENDIF
				ENDDO
				=FCLOSE(PUNTERO)
			ENDIF
			
		ENDIF 
	ENDFOR 
	
	=FCLOSE(H)


	SET DEFAULT TO &_SYSESTACION 

	RETURN v_retorno 
ENDFUNC 





FUNCTION AplicarCreditos
PARAMETERS pac_idfactura, pac_credito, pac_idcomcr, pac_idcr
*#/ ------------------------------
* Aplica a la cuota 0 de la factura Seleccionada si la hubiere el crédito
* disponible en la cuenta, la cuenta de la entidad la busca a partir de la
* Factura que recibe como parámetro. El Crédito a aplicar lo recibe como parámetro
* Busca los comprobantes de Recibos o Notas de Credito con Saldo disponible y 
* Los aplica a partir de la fecha mas vieja en adelante hasta agotar el saldo
* o cancelar el crédito recibido como parámetro
* Realiza los vinculos con los comprobantes
*#/--------------------------------

	IF ALLTRIM(TYPE("pac_idcomcr"))='N' THEN 
		v_pac_idcomcr = pac_idcomcr
		v_pac_idcr    = pac_idcr
	ELSE
		v_pac_idcomcr = 0
		v_pac_idcr    = 0		
	ENDIF 


	* Me conecto a la base de datos *
	vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
	* Obtengo la Entidad de la Factura para calculo de crédito disponible
		
	sqlmatriz(1)= " SELECT f.entidad, f.idfactura, f.idcomproba, ifnull(sf.saldof,0.00) as saldof , "
	sqlmatriz(2)= " ifnull(c.idcuotafc,0) as idcuotafc,ifnull(c.cuota,0) as cuota, "
	sqlmatriz(3)= " ifnull(sc.saldof,0.00) as saldoc FROM facturas f "
	sqlmatriz(4)= "	left join facturascta c on f.idfactura = c.idfactura "
	sqlmatriz(5)= "	left join r_facturasaldo sf on sf.idfactura = f.idfactura "
	sqlmatriz(6)= "	left join r_facturasctasaldo sc on sc.idcuotafc = c.idcuotafc "
	sqlmatriz(7)= "	where f.idfactura = "+ALLTRIM(STR(pac_idfactura))+"  and ifnull(sf.saldof,0.00) > 0 and "
	sqlmatriz(8)= "	(ifnull(c.idcuotafc,0.00) = 0 or ifnull(sc.saldof,0.00) > 0)  order by c.cuota "
 	
	verror=sqlrun(vconeccionF,"FacturaAp_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Entidad para Aplicar el Crédito ",0+48+0,"Error")
	    RETURN 0
	ENDIF 
	
	* me desconecto	
	=abreycierracon(vconeccionF,"")
	
	SELECT * FROM facturaAp_sql INTO TABLE facturaap
	SELECT facturaap_sql 
	USE IN FacturaAp_sql 
	SELECT Facturaap
	ALTER table Facturaap alter COLUMN idcuotafc i
	ALTER table Facturaap alter COLUMN cuota 	 i
	ALTER table Facturaap add COLUMN   aplicado  y
	
	vtabCredito=SaldosEntidad (Facturaap.entidad,"CreEntidad",vconeccionF)
	IF EMPTY(ALLTRIM(vtabCredito)) THEN 
		SELECT Facturaap
		USE IN Facturaap
		RETURN 
	ENDIF 

	USE CreEntidad IN 0 
	
	if	v_pac_idcomcr > 0 THEN 
		SELECT *, 10000000.00 as aplicado FROM creentidad INTO TABLE CreditoEntidad WHERE opera < 0 and idcomproba = v_pac_idcomcr and idregistro = v_pac_idcr
	ELSE 
		SELECT *, 10000000.00 as aplicado FROM creentidad INTO TABLE CreditoEntidad WHERE opera < 0 
	ENDIF 
	SELECT CreEntidad
	USE IN CreEntidad
	
	SELECT CreditoEntidad
	replace ALL aplicado WITH 0
	GO TOP 
	
	*creo una tabla temporaria para cargar las imputaciones de cobros
	CREATE TABLE cobrosaplicar (idcomproba i, idregipago i, idcomprobf i ,idfactura i, idcuotafc i, imputado y )
	
	* Recorro las cuotas o solo la factura para aplicar hasta el crédito pasado como monto a aplicar
	SELECT Facturaap
	GO TOP 
	v_terminarfa = .f. 
	v_pac_credito = pac_credito
	
	DO WHILE (v_pac_credito > 0) AND !v_terminarfa AND  !EOF() && Recorro todas las cuotas de las facturas adeudadas
		
		va_idcomprof	= facturaap.idcomproba
		va_idfactura 	= facturaap.idfactura
		va_idcuotafc	= facturaap.idcuotafc
		v_terminarcr = .f.
		
		SELECT CreditoEntidad
		GO TOP 
		
		
		DO WHILE (v_pac_credito > 0) AND !v_terminarcr and !EOF() && Recorro todos los comprobantes con crédito para aplicar
		
			va_idcomproba = CreditoEntidad.idcomproba
			va_idregipago = CreditoEntidad.idregistro
			va_aplicado	  = CreditoEntidad.aplicado
			v_deudaap	  = IIF(va_idcuotafc = 0, Facturaap.saldof,Facturaap.saldoc)-Facturaap.aplicado && Saldo adeudado en la Factura o cuota a cancelar
			v_saldocr	  = CreditoEntidad.saldo-CreditoEntidad.aplicado
	
			IF v_saldocr > 0 THEN 		&& si el comprobante tiene saldo para aplicar entonces trata de aplicarlo
				IF v_deudaap > 0 THEN && Aca tengo saldo disponible y deuda para aplicar 


				
					DO CASE 
						CASE v_deudaap >= v_saldocr && deuda en comprobante >= Saldo disponible para aplicar
							va_imputado = IIF(v_saldocr<=v_pac_credito,v_saldocr,v_pac_credito) && Aplica todo el saldo disponible en el comprobante o el limite de credito
							
						CASE v_deudaap < v_saldocr && deuda en comprobante < Saldo disponible para aplicar
							va_imputado = IIF(v_deudaap<=v_pac_credito,v_deudaap,v_pac_credito) && Cancela toda la deuda del comprobante o el limite de credito
					ENDCASE 
				ELSE	&& la factura a cancelar ya se ha cancelado totalmente
					va_imputado = 0 
				ENDIF 
				
			ELSE	&& no hay credito en el comprobante para aplicarlo
				va_imputado = 0
			ENDIF
			
	
			IF va_imputado > 0 THEN 			 

				SELECT cobrosaplicar
												
				INSERT INTO cobrosaplicar VALUES ( va_idcomproba, va_idregipago, va_idcomprof, va_idfactura, va_idcuotafc, va_imputado )
				v_pac_credito = v_pac_credito - va_imputado && descuento del credito disponible lo que voy imputando
				SELECT CreditoEntidad
				replace aplicado WITH aplicado + va_imputado
				SELECT facturaap
				replace aplicado WITH aplicado + va_imputado
								
			ENDIF 

			SELECT CreditoEntidad
*!*				IF (CreditoEntidad.saldo - CreditoEntidad.aplicado) <= 0 THEN 
*!*	*				v_terminarcr = .t. 
*!*				ENDIF  
			
			SKIP
	
		ENDDO 
		
		SELECT Facturaap
*!*			IF (IIF(va_idcuotafc = 0, Facturaap.saldof,Facturaap.saldoc)-Facturaap.aplicado) <= 0 THEN 
*!*				v_terminarfa = .t. 
*!*			ENDIF  

		SKIP 	
	ENDDO 

	SELECT facturaap
	USE 
	SELECT CreditoEntidad
	USE 
	SELECT cobrosaplicar
	v_canreg = RECCOUNT()
	USE 
	IF v_canreg > 0 THEN && si hay cobros para aplicar ejecuto la aplicacion de creditos
		=GAplicaCobro("cobrosaplicar")
	ENDIF 
ENDFUNC 





FUNCTION GAplicaCobro
PARAMETERS pga_tablacobros, p_cone
*#/---
* Guarda las Aplicaciones de Recibos o Notas de Crédito a deudas de Facturas}
* pgu_tablacobros: Tabla con los cobros a aplicar
* p_cone : Conexión en caso de que esté abierta
* Recibe como parametro una tabla con todos los campos de la tabla cobros para guardarlos 
* Una Conexion que si no se indica entonces se abre dentro de la función
* en la tabla cobros. Guarda y genera el comprobante de vinculos de comprobantes.
* La tabla recibida puede tener n aplicaciones para insertar.
* Generará una aplicación para cada registro recibido
* Formato de la tabla a recibir : .DBF ( idcomproba i, idfactura i, idregipago i, idcuotafc i, imputado y )
*#/---

	v_cerrarcone = .t.
	IF TYPE("p_cone") = 'N'  THEN && Se le Paso la Conexion entonces no abre ni cierra 
		IF p_cone > 0 THEN 
			vconeccionAP = p_cone
			v_cerrarcone = .f.
		ELSE 
			vconeccionAP = abreycierracon(0,_SYSSCHEMA)
		ENDIF 
	ELSE 
		vconeccionAP = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	

	USE &pga_tablacobros IN 0


	TipoCompGAObj 	= CREATEOBJECT('tiposcomproclass')	
	v_idNCA			= TipoCompGAObj.getidtipocompro("NOTA DE CREDITO A")
	v_idNCB			= TipoCompGAObj.getidtipocompro("NOTA DE CREDITO B")
	v_idNCC			= TipoCompGAObj.getidtipocompro("NOTA DE CREDITO C")
	RELEASE TipoCompGAObj 
	
	
	SELECT &pga_tablacobros
	GO TOP 
	DO WHILE !EOF()
	

		sqlmatriz(1)= " SELECT c.idcomproba, t.idtipocompro FROM comprobantes c "
		sqlmatriz(2)=" left join tipocompro t on t.idtipocompro = c.idtipocompro "
		sqlmatriz(3)=" where c.idcomproba = "+STR(&pga_tablacobros..idcomproba)

		verror=sqlrun(vconeccionAP,"TipoComprobante_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Entidad para Aplicar el Crédito ",0+48+0,"Error")
		    RETURN 0
		ENDIF 
		v_idtipocompro= tipocomprobante_sql.idtipocompro
		USE IN tipocomprobante_sql
		SELECT  &pga_tablacobros


	*** Registro el cobro para cancelar la factura / ND
		DIMENSION lamatriz(8,2)

		v_idcobro = maxnumeroidx("idcobro", "I", "cobros",1)

		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'cobros'
		p_matriz    = 'lamatriz'
		p_conexion  = vconeccionAP

		v_cobro_idcomproba	= &pga_tablacobros..idcomproba
		v_cobro_idfactura	= &pga_tablacobros..idfactura
		v_cobro_recargo		= 0.00
		v_cobro_idregipago	= &pga_tablacobros..idregipago
		v_cobro_idcuotafc	= &pga_tablacobros..idcuotafc
		v_cobro_imputado	= &pga_tablacobros..imputado
		v_cobro_saldof 		= 0
			
		lamatriz(1,1)='idcobro'
		lamatriz(1,2)=ALLTRIM(STR(v_idcobro))
		lamatriz(2,1)='idcomproba'
		lamatriz(2,2)=ALLTRIM(STR(v_cobro_idcomproba))
		lamatriz(3,1)='idfactura'
		lamatriz(3,2)= ALLTRIM(STR(v_cobro_idfactura))
		lamatriz(4,1)='recargo'
		lamatriz(4,2)=ALLTRIM(STR(v_cobro_recargo,13,4))
		lamatriz(5,1)='idregipago'
		lamatriz(5,2)=ALLTRIM(STR(v_cobro_idregipago))
		lamatriz(6,1)='idcuotafc'
		lamatriz(6,2)=ALLTRIM(STR(v_cobro_idcuotafc))
		lamatriz(7,1)='imputado'
		lamatriz(7,2)=ALLTRIM(STR(v_cobro_imputado,13,4))
		lamatriz(8,1)='saldof'
		lamatriz(8,2)=ALLTRIM(STR(v_cobro_saldof,13,4))				
		
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")		
			* me desconecto	
				=abreycierracon(vconeccionAP,"")
		    RETURN 
		ENDIF 

		TipoCompGAObj 	= CREATEOBJECT('tiposcomproclass')	
		v_idNCA			= TipoCompGAObj.getidtipocompro("NOTA DE CREDITO A")
		v_idNCB			= TipoCompGAObj.getidtipocompro("NOTA DE CREDITO B")
		v_idNCC			= TipoCompGAObj.getidtipocompro("NOTA DE CREDITO C")
		RELEASE TipoCompGAObj 
			
		IF (v_idtipocompro = v_idNCA OR v_idtipocompro = v_idNCB OR v_idtipocompro = v_idNCC) THEN 
			
			 
			*** Registro el cobro para cancelar la NC si corresponde 
				
				DIMENSION lamatriz(8,2)

				v_idcobro = maxnumeroidx("idcobro", "I", "cobros",1)

				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				p_tabla     = 'cobros'
				p_matriz    = 'lamatriz'
				p_conexion  = vconeccionAP


				v_cobro_idcomproba	= &pga_tablacobros..idcomprobf
				v_cobro_idfactura	= &pga_tablacobros..idregipago
				v_cobro_recargo		= 0
				v_cobro_idregipago	= &pga_tablacobros..idfactura
				v_cobro_idcuotafc	= 0
				v_cobro_imputado	= &pga_tablacobros..imputado
				v_cobro_saldof 		= 0.00

				lamatriz(1,1)='idcobro'
				lamatriz(1,2)=ALLTRIM(STR(v_idcobro))
				lamatriz(2,1)='idcomproba'
				lamatriz(2,2)=ALLTRIM(STR(v_cobro_idcomproba))
				lamatriz(3,1)='idfactura'
				lamatriz(3,2)= ALLTRIM(STR(v_cobro_idfactura))
				lamatriz(4,1)='recargo'
				lamatriz(4,2)=ALLTRIM(STR(v_cobro_recargo,13,4))
				lamatriz(5,1)='idregipago'
				lamatriz(5,2)=ALLTRIM(STR(v_cobro_idregipago))
				lamatriz(6,1)='idcuotafc'
				lamatriz(6,2)=ALLTRIM(STR(v_cobro_idcuotafc))
				lamatriz(7,1)='imputado'
				lamatriz(7,2)=ALLTRIM(STR(v_cobro_imputado,13,4))
				lamatriz(8,1)='saldof'
				lamatriz(8,2)=ALLTRIM(STR(v_cobro_saldof,13,4))		
						
			
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
				    			* me desconecto	
					=abreycierracon(vconeccionAP,"")

				    RETURN 
				ENDIF 

			ENDIF 
			
			
			
		* Creo el Comprobante de registro de vinculos 
		* No quiero que imprima cada vez que genera el comprobante de vinculo en este caso
		*  Modifico la Variable de Impresión de Vinculos para obviar la Impresion
		vsysimpvinc_est = _SYSIMPVINC		
		_SYSIMPVINC = 'N'
		reto=VinculoComp('V',&pga_tablacobros..idcomproba,&pga_tablacobros..idregipago, &pga_tablacobros..idfactura,&pga_tablacobros..imputado)
		_SYSIMPVINC = vsysimpvinc_est 
		
		SELECT &pga_tablacobros
		SKIP 
	ENDDO 
	USE IN &pga_tablacobros
	IF v_cerrarcone = .t.  THEN 		
		=abreycierracon(vconeccionAP,"")
	ENDIF 

ENDFUNC 


FUNCTION retenciones
PARAMETERS p_entidad, P_fecha, p_nomTabRes,P_importe
*PARAMETERS p_entidad, P_importe,P_fecha, p_nomTabRes
*#/**************************************************************
*** FUNCIÓN PARA EL CALCULO DE RETENCIONES A APLICAR ***
****************************************************************
** PARÁMETROS: 	P_entidad: id de la entidad a retener
*				P_fecha: Fecha para el cálculo de la rentención
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual incluye: idimpuret,netoTotal,importeARetener,totpagosmes,totRetenmes )
*				P_importe: Importe Total, del cuál se va a calcular las retenciones. en caso de no pasar parámetro se pedirá en la pantalla
*La función recibe los parámetros indicados y va a determinar si se va a aplicar retenciones a la entidad, y cuanto retener por cada retención
****************************************************************
** RETORNO: Retorna el importe a retener, el total de retenciones al mes y total de pagos. True si terminó correctamente, False en otro caso
*#/**************************************************************


v_retorno = 0
v_importeTot = 0.00

****************************************************************
** 1- Verificar Si la empresa es agente de retenciones, se debe activar la variable _SYSAGENTERET = ‘S’
****************************************************************

 IF ALLTRIM(_SYSAGENTERET) = 'S'
 
 	IF TYPE('p_importe') = 'N'
 		v_importeTot = p_importe
 	ELSE
 		v_importeTot = 0.00
 	ENDIF 
 	****************************************************************
	** 2- Verificar si a la entidad le corresponde retenciones. Ver en las retenciones asociadas a la entidad en la tabla: entidadret
	****************************************************************
		* Me conecto a la base de datos *
		vconeccion=abreycierracon(0,_SYSSCHEMA)	

		 
		sqlmatriz(1)=" select e.identret,e.entidad,e.idimpuret,e.enconvenio, i.detalle,i.razonin,i.baseimpon, i.idtipopago, i.funcion, i.razonnin,i.regimen "
		sqlmatriz(2)=" from entidadret e left join impuretencion i on e.idimpuret = i.idimpuret "
		sqlmatriz(3)=" where e.entidad = "+ALLTRIM(STR(p_entidad))
		verror=sqlrun(vconeccion,"entidadret_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al Obtener las retenciones asociadas a la entidad",0+48+0,"Error")
			* me desconecto	

			=abreycierracon(vconeccion,"")
			
			RETURN 0
		ENDIF
		
		 		
		SELECT * FROM entidadret_sql INTO TABLE &p_nomTabRes
		
		SELECT &p_nomTabRes
		GO TOP 
		
		IF NOT EOF()	
			SELECT &p_nomTabRes
			ALTER table &p_nomTabRes ADD COLUMN impTot Y
			ALTER table &p_nomTabRes ADD COLUMN impARet Y
			ALTER table &p_nomTabRes ADD COLUMN totapagmes Y
			ALTER table &p_nomTabRes ADD COLUMN totretmes Y
			ALTER table &p_nomTabRes ADD COLUMN sel I
			ALTER table &p_nomTabRes ADD COLUMN sujarete Y
			ALTER table &p_nomTabRes ADD COLUMN idafipesc I
			ALTER table &p_nomTabRes ADD COLUMN fecha C(8)
			
			SELECT &p_nomTabRes
			GO TOP 
			
			replace ALL impTot WITH v_importeTot, impAret WITH 0.00, totAPagMes WITH 0.00, totRetMes WITH 0.00, sel WITH 0, sujarete WITH 0.00, idafipesc WITH 0, fecha WITH DTOS(p_fecha)
		ELSE
			RETURN -1
		endif
	
		USE IN entidadret_sql


		* me desconecto	
		=abreycierracon(vconeccion,"")
		
		
		
	****************************************************************	
	** 3- En caso de que le corresponda retenciones, abrir una ventana con las retenciones asociadas, pidiendo ingresar el monto total y una lista para poder elegir las retenciones que quiera aplicar
	****************************************************************

 	DO FORM selectretenciones WITH v_importeTot ,p_nomTabRes TO v_retorno 

 	DO CASE
 	CASE  v_retorno > 0.00
 	
	
 		SELECT &p_nomtabres
 		GO TOP 

	CASE v_retorno = 0 
		MESSAGEBOX("Hubo un problema al intentar aplicar retenciones",0+48+0,"Aplicar retenciones")
 		RETURN 0.00
 		

 	OTHERWISE
		RETURN -1
 	ENDCASE
 	
	
 ELSE
 	RETURN -1
 ENDIF 

 
 
RETURN v_retorno

ENDFUNC 



FUNCTION generarCompRetencion
PARAMETERS p_nomTablaret, p_idcomprobaaso, p_idregistroaso
*#/----------------------------------------
****************************************************************
*** FUNCIÓN PARA GENERAR UN COMPROBANTE DE RETENCIÓN SEGÚN LA TABLA ***
****************************************************************
** PARÁMETROS: 	p_nomTablaret: Nombre de la tabla donde están los datos para generar el comprobante y en la cuál se retornan los datos restantes
* La función recibe el nombre de una tabla, la cuál tiene el siguiente formato: (idreten I, pventa I, idcomproba I, numero I, fecha C(8), entidad I, idimpuret I, importe Y, sujarete Y)
* Donde (idreten, idcomproba, numero) estarán en CERO cuando se esté generando el comprobante. Al Retornar True la función previamente completa los datos faltantes
****************************************************************
** RETORNO: Retorna True si se generó correctamente, completando previamente los datos de idreten, idcomproba, numero
****************************************************************
*#/----------------------------------------



IF TYPE('p_idcomprobaaso') = 'N'
ELSE
	RETURN .F.
ENDIF 

IF TYPE('p_idregistroaso') = 'N'
ELSE
	RETURN .F.

ENDIF 


	v_retorno = .F.


	if USED(p_nomTablaret) = .F.
	
		MESSAGEBOX("No se encuentra la tabla temporal con los datos de la retención a generar", 0+16+0,"Error al generar el comprobante de retención")
		RETURN .F.
	ENDIF 
	
	comproObjtmp		= CREATEOBJECT('comprobantesClass')
	
	
	SELECT &p_nomTablaRet
	GO TOP 
	
	DO WHILE NOT EOF()
	
		SELECT &p_nomTablaRet
			v_re = RECNO()
			
			
		v_idretenr = &p_nomTablaRet..idreten
		
		IF v_idretenr = 0
	

			v_pventar = &p_nomTablaRet..pventa
			v_idcomprobar =  comproObjtmp.getidcomprobante("RETENCION")
			
		SELECT &p_nomTablaRet
			v_regis = RECNO()
		
			*v_numero  = &p_nomTablaRet..numero
			v_numeror = maxnumerocom(v_idcomprobar,v_pventar,1) + 1
			
		SELECT &p_nomTablaRet
			v_regis = RECNO()

			v_fechar = &p_nomTablaRet..fecha
			v_entidadr = &p_nomTablaRet..entidad
			v_idimpuretr  = &p_nomTablaRet..idimpuret
			v_importer  = &p_nomTablaRet..importe
			v_sujareter = &p_nomTablaRet..sujarete
			v_idafipesc = &p_nomTablaRet..idafipesc
			* Me conecto a la base de datos *
				vconeccion=abreycierracon(0,_SYSSCHEMA)	
				
				
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
							
			DIMENSION lamatrizr(8,2)
			
			lamatrizr(1,1) = 'idreten'
			lamatrizr(1,2) = "0"
			lamatrizr(2,1) = 'pventa'
			lamatrizr(2,2) = ALLTRIM(STR(v_pventar))
			lamatrizr(3,1) = 'idcomproba'
			lamatrizr(3,2) = ALLTRIM(STR(v_idcomprobar))
			lamatrizr(4,1) = 'numero'
			lamatrizr(4,2) = ALLTRIM(STR(v_numeror))
			lamatrizr(5,1) = 'fecha'
			lamatrizr(5,2) = "'"+ALLTRIM(v_fechar)+"'"
			lamatrizr(6,1) = 'entidad'
			lamatrizr(6,2) = ALLTRIM(STR(v_entidadr))
			lamatrizr(7,1) = 'importe'
			lamatrizr(7,2) = ALLTRIM(STR(v_importer,13,2))
			lamatrizr(8,1) = 'sujarete'
			lamatrizr(8,2) = ALLTRIM(STR(v_sujareter,13,2))
			

			p_tabla     = 'retenciones'
			p_matriz    = 'lamatrizr'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" de la Retención",0+48+0,"Error")
			            * me desconecto	
				=abreycierracon(vconeccionF,"")    
			    RETURN .f.
			ENDIF 
			
			
			
			sqlmatriz(1)=" select last_insert_id() as maxid "
			verror=sqlrun(vconeccionF,"ultimoId")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
				=abreycierracon(vconeccionF,"")	
			    RETURN v_idcomproreret
			ENDIF 
			SELECT ultimoId
			GO TOP 
			v_idcompro_Ultimo = VAL(ultimoId.maxid)
			USE IN ultimoId

			v_idretenr = v_idcompro_Ultimo
			
			SELECT &p_nomtablaRet
*!*				replace idreten WITH v_idretenr

			
*!*				SELECT &p_nomTablaRet
*!*				GO v_re
*!*				replace idreten WITH v_idretenr, idcomproba WITH v_idcomprobar, numero WITH v_numeror
*!*			
				
							
				*** Guardo la asociación del  comprobante de retención con el comprobante de pago **
							
*!*					v_idreten = &vRetencionesTMP..idreten
*!*					v_idcomprobaret = &vRetencionesTMP..idcomproba
*!*					
							
				DIMENSION lamatrizr2(5,2)

				v_idlinkComp = 0
				v_idcomprobaa= p_idcomprobaaso
				v_idregistroa= p_idregistroaso
				v_idcomprobab=v_idcomprobar
				v_idregistrob=v_idretenr 
				
				
				
				
				p_tipoope     = 'I'
				p_condicion   = ''
				v_titulo      = " EL ALTA "
				p_tabla     = 'linkcompro'
				p_matriz    = 'lamatrizr2'
				p_conexion  = vconeccionF

				lamatrizr2(1,1)='idlinkcomp'
				lamatrizr2(1,2)=ALLTRIM(STR(v_idlinkComp))
				lamatrizr2(2,1)='idcomprobaa'
				lamatrizr2(2,2)=ALLTRIM(STR(v_idcomprobaa))
				lamatrizr2(3,1)='idregistroa'
				lamatrizr2(3,2)=ALLTRIM(STR(v_idregistroa))
				lamatrizr2(4,1)='idcomprobab'
				lamatrizr2(4,2)=ALLTRIM(STR(v_idcomprobab))
				lamatrizr2(5,1)='idregistrob'
				lamatrizr2(5,2)=ALLTRIM(STR(v_idregistrob))
											

				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error al intentar guardar linkcompro",0+48+0,"Error")
					RETURN .f.
				ENDIF 
		
				
		
				sqlmatriz(1)=" select * from impuretencion "
				sqlmatriz(2)=" where idimpuret = "+ALLTRIM(STR(v_idimpuretr))
				
				
				verror=sqlrun(vconeccionF,"impuret_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la generación del comprobante de Retención (IMPURETENCION)",0+48+0,"Error")
					=abreycierracon(vconeccionF,"")	
				    RETURN .F.
				ENDIF 
				
				
				
				SELECT impuret_sql
				GO TOP 
				IF NOT EOF()

					sqlmatriz(1)=" select * from afipescalas "
					sqlmatriz(2)=" where idafipesc = "+ALLTRIM(STR(v_idafipesc))
				
				
					verror=sqlrun(vconeccionF,"afipescalas_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la generación del comprobante de Retención (AFIPESCALAS)",0+48+0,"Error")
						=abreycierracon(vconeccionF,"")	
					    RETURN .F.
					ENDIF 
				
					SELECT afipescalas_sql
					GO TOP 
					
					IF NOT EOF()
		
						*** Inserto los detalles de la retención ***
												
						SELECT afipescalas_sql
						GO TOP 
						IF NOT EOF()
						
							DIMENSION lamatrizr4(7,2)

							p_tipoope     = 'I'
							p_condicion   = ''
							v_titulo      = " EL ALTA "
							p_tabla     = 'afipescalash'
							p_matriz    = 'lamatrizr4'
							p_conexion  = vconeccionF


							SELECT afipescalas_sql
							GO TOP 
							
							v_idafipesch = 0
							v_codigo = afipescalas_sql.codigo
							v_descrip = ALLTRIM(afipescalas_sql.descrip)
							v_valmin= afipescalas_sql.valmin
							v_valmax = afipescalas_sql.valmax
							v_valfijo= afipescalas_sql.valfijo
							v_razon = afipescalas_sql.razon
							
							lamatrizr4(1,1)='idafipesc'
							lamatrizr4(1,2)=ALLTRIM(STR(v_idafipesch))
							lamatrizr4(2,1)='codigo'
							lamatrizr4(2,2)=ALLTRIM(STR(v_codigo))
							lamatrizr4(3,1)='descrip'
							lamatrizr4(3,2)="'"+ALLTRIM(v_descrip)+"'"
							lamatrizr4(4,1)='valmin'
							lamatrizr4(4,2)=ALLTRIM(STR(v_valmin,13,2))
							lamatrizr4(5,1)='valmax'
							lamatrizr4(5,2)=ALLTRIM(STR(v_valmax,13,2))
							lamatrizr4(6,1)='valfijo'
							lamatrizr4(6,2)=ALLTRIM(STR(v_valfijo,13,2))
							lamatrizr4(7,1)='razon'
							lamatrizr4(7,2)=ALLTRIM(STR(v_razon,13,2))																
							
							IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
							    MESSAGEBOX("Ha Ocurrido un Error al intentar guardar impuretencionh",0+48+0,"Error")
								RETURN .f.
							ENDIF 
							
							
							sqlmatriz(1)=" select last_insert_id() as maxid "
							verror=sqlrun(vconeccionF,"ultimoId")
							IF verror=.f.  
							    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
								=abreycierracon(vconeccionF,"")	
							    RETURN .F.
							ENDIF 
							SELECT ultimoId
							GO TOP 
							v_idcompro_Ultimo = VAL(ultimoId.maxid)
							USE IN ultimoId

							v_idafipesch = v_idcompro_Ultimo
											
														
							DIMENSION lamatrizr3(8,2)

							p_tipoope     = 'I'
							p_condicion   = ''
							v_titulo      = " EL ALTA "
							p_tabla     = 'impuretencionh'
							p_matriz    = 'lamatrizr3'
							p_conexion  = vconeccionF


							SELECT impuret_sql
							v_idimpureth = 0
							v_detalle = ALLTRIM(impuret_sql.detalle)
							v_baseimpon = impuret_sql.baseimpon
							v_idtipopago = impuret_sql.idtipopago
							v_funcion = impuret_sql.funcion
							
							v_regDetalle = impuret_sql.detalle
							v_regimen = IIF(ISNULL(impuret_sql.regimen),0,impuret_sql.regimen)
							

							lamatrizr3(1,1)='idimpuret'
							lamatrizr3(1,2)=ALLTRIM(STR(v_idimpureth))
							lamatrizr3(2,1)='detalle'
							lamatrizr3(2,2)="'"+ALLTRIM(v_detalle)+"'"
							lamatrizr3(3,1)='idafipesc'
							lamatrizr3(3,2)=ALLTRIM(STR(v_idafipesch))
							lamatrizr3(4,1)='baseimpon'
							lamatrizr3(4,2)=ALLTRIM(STR(v_baseimpon,13,2))
							lamatrizr3(5,1)='idtipopago'
							lamatrizr3(5,2)=ALLTRIM(STR(v_idtipopago))
							lamatrizr3(6,1)='funcion'
							lamatrizr3(6,2)="'"+ALLTRIM(v_funcion)+"'"
							lamatrizr3(7,1)='idreten'
							lamatrizr3(7,2)=ALLTRIM(STR(v_idretenr))	
							lamatrizr3(8,1)='regimen'
							lamatrizr3(8,2)=ALLTRIM(STR(v_regimen))																	
							
							IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
							    MESSAGEBOX("Ha Ocurrido un Error al intentar guardar impuretencionh",0+48+0,"Error")
								RETURN .f.
							ENDIF 
							
							
							
						
						ELSE
							RETURN .F.
						ENDIF 
						
						
					ELSE
						RETURN .F.
					
					ENDIF 
				ELSE
				
					RETURN .F.
				ENDIF 
			
				
				registrarEstado("retenciones","idreten",v_idretenr,'I',"AUTORIZADO")
				
			* me desconecto	
			=abreycierracon(vconeccionF,"")
			
			ENDIF 
		
		SELECT &p_nomTablaRet
		
		
		SKIP 1

	ENDDO

		
	v_retorno = .T.
	

	RETURN v_retorno
ENDFUNC 



FUNCTION percepciones
PARAMETERS p_entidad, P_fecha, p_nomTabRes,P_importe

*#/**************************************************************
*** FUNCIÓN PARA EL CALCULO DE PERCEPCIONES A APLICAR ***
****************************************************************
** PARÁMETROS: 	P_entidad: id de la entidad a percibir
*				P_fecha: Fecha para el cálculo de la percepcion
*				p_nomTabRes: Nombre de la tabla donde se va a entregar el resultado, la cual incluye: idimpuper,netoTotal,importeARetener,totpagosmes,totRetenmes )
*				P_importe: Importe Total, del cuál se va a calcular las percepciones. en caso de no pasar parámetro se pedirá en la pantalla
*La función recibe los parámetros indicados y va a determinar si se va a aplicar percepcion a la entidad, y cuanto percibir
****************************************************************
** RETORNO: Retorna el importe a percibir, el total de percepciones al mes y total de pagos. True si terminó correctamente, False en otro caso
*#/**************************************************************

v_retorno = .F.
v_importeTot = 0.00

****************************************************************
** 1- Verificar Si la empresa es agente de percepcion, se debe activar la variable _SYSAGENTEPER = ‘S’
****************************************************************

 IF ALLTRIM(_SYSAGENTEPER) = 'S'
 
 	IF TYPE('p_importe') = 'N'
 		v_importeTot = p_importe
 	ELSE
 		v_importeTot = 0.00
 	ENDIF 
 	
 	****************************************************************
	** 2- Verificar si a la entidad le corresponde percepción. Ver en las percepciones asociadas a la entidad en la tabla: entidadper
	****************************************************************
		* Me conecto a la base de datos *
		vconeccion=abreycierracon(0,_SYSSCHEMA)	

		 
		sqlmatriz(1)=" select e.identper,e.entidad,e.idimpuret,e.enconvenio, i.detalle,i.razonin,i.baseimpon, i.idtipopago, i.funcion, i.razonnin "
		sqlmatriz(2)=" from entidadper e left join impupercepcion i on e.idimpuper = i.idimpuper "
		sqlmatriz(3)=" where e.entidad = "+ALLTRIM(STR(p_entidad))
		verror=sqlrun(vconeccion,"entidadper_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error al Obtener las percepciones asociadas a la entidad",0+48+0,"Error")
			* me desconecto	

			=abreycierracon(vconeccion,"")
			
			RETURN .F.
		ENDIF
		
		 		
		SELECT * FROM entidadper_sql INTO TABLE &p_nomTabRes
		
		SELECT &p_nomTabRes
		GO TOP 
		
		IF NOT EOF()	
			SELECT &p_nomTabRes
			ALTER table &p_nomTabRes ADD COLUMN impTot Y
			ALTER table &p_nomTabRes ADD COLUMN impAPer Y
			ALTER table &p_nomTabRes ADD COLUMN totapagmes Y
			ALTER table &p_nomTabRes ADD COLUMN totretmes Y
			ALTER table &p_nomTabRes ADD COLUMN sel I
			ALTER table &p_nomTabRes ADD sujaper Y
			
			SELECT &p_nomTabPer
			GO TOP 
			
			replace ALL impTot WITH v_importeTot, impAper WITH 0.00, totAPagMes WITH 0.00, totRetMes WITH 0.00, sel WITH 0, sujarete WITH 0.00
			
		ELSE
			RETURN .T.
		endif

		USE IN entidadret_sql

		* me desconecto	
		=abreycierracon(vconeccion,"")
		
	****************************************************************	
	** 3- En caso de que le corresponda percepciones, abrir una ventana con las percepciones asociadas, pidiendo ingresar el monto total y una lista para poder elegir las percepciones que quiera aplicar
	****************************************************************

 	v_retorno = 0.00 
	** DO FORM selectpercepciones WITH v_importeTot ,p_nomTabRes TO v_retorno   && NO TENGO EL FORMULARIO
 	
 	IF v_retorno > 0.00

 		SELECT &p_nomtabres
 		GO TOP  		
 	ELSE
 		MESSAGEBOX("Hubo un problema al intentar aplicar percepciones",0+48+0,"Aplicar percepciones")
 		RETURN 0.00
 	ENDIF 

	
 ELSE
 	RETURN -1
 ENDIF 

RETURN v_retorno

ENDFUNC 



FUNCTION ConsultaEntidad
PARAMETERS pce_entidad
*#/**************************************************************
*** CONSULTA DE ENTIDAD ***
****************************************************************
** PARÁMETROS: 	P_entidad: id de la entidad a consultar
** RETORNO: Retorna una el nombre de una tabla con todos los datos de la entidad o "" si la entidad no existe
*#/**************************************************************
vreto_entidad 	=""
vnombrear		= "entidad"+frandom()
IF pce_entidad > 0 THEN 

	vconeccionPCE = abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)="Select * FROM entidades WHERE entidad = " + ALLTRIM(STR(pce_entidad))
	verror=sqlrun(vconeccionPCE,"entidades_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la Razon Social de la entidad solicitada ",0+48+0,"Error")
	ENDIF 
	SELECT entidades_sql 
	GO TOP 
	IF EOF() THEN 
		USE IN entidades_sql
		=abreycierracon(vconeccionPCE ,"")
		RETURN vreto_entidad 
	ENDIF 
	SELECT * FROM entidades_sql INTO TABLE &vnombrear
	USE IN &vnombrear
	USE IN entidades_sql
	vreto_entidad = vnombrear
	=abreycierracon(vconeccionPCE,"")
ENDIF 

RETURN vreto_entidad 





FUNCTION GeneraCMPCostos
PARAMETERS p_tabladatos
*#/----------------------------------------
**** FUNCIÓN PARA GENERAR COMPROBANTES DE COSTOS AUTOMATICOS
** Si los costos unitarios recibidos son 0 entonces busca el costo en las tablas de articulos o materiales
** PARAMETROS: 	par_costos: Tabla con los datos de entidad, articulos y Materiales para realizar el ajuste de costos
** 
** RETORNO:		Retorna 0 si no pudo realizar el Comprobante o el idcostop en caso de realizar el Comprobante correctamente 
**              Retorna -1 si no está habilitada la opcion de Generacion de Comprobantes de Costos Automático _SYSGENCOSTOS= "S/N"
** Tabla recibida como parametro: 
** fecha c(8), entidad i, articulo c(50), cantidad y, unitario y, idmate i, tablal c(50), campol c(50), idl i, detalle c(150)
*#/----------------------------------------
	IF _SYSGENCOSTOS = 'N' THEN 
		RETURN -1 
	ENDIF 
	v_tablaDatos	= p_tablaDatos
	v_retornocmp	= 0

	USE &v_tablaDatos IN 0 

	**** Busco el Primer idcomproba que corresponde a Costos ***
	vconeccionC=abreycierracon(0,_SYSSCHEMA)	

	*** Busco los comprobantes y sus respectivos puntos de venta 
	sqlmatriz(1)=" Select c.idcomproba, c.comprobante as nomcomp, c.idtipocompro, c.tipo, c.ctacte, c.tabla, t.pventa, "
	sqlmatriz(2)=" t.puntov from comprobantes c left join compactiv t on c.idcomproba = t.idcomproba where c.tabla = 'costop' "
	verror=sqlrun(vconeccionC,"Comprobantes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de comprobantes ",0+48+0," Error ")
	    =abreycierracon(vconeccionC,"")
	    RETURN .F.
	ENDIF

	*** Busco la Entidad o Nombre de Empresa asociado
	sqlmatriz(1)=" select * from entidades where entidad = "+ALLTRIM(STR(&v_tablaDatos..entidad))
	verror=sqlrun(vconeccionC,"entidad_sel")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  Entidad para Costo ",0+48+0,"Error")
	     =abreycierracon(vconeccionC,"")
	    RETURN .F.
	ENDIF


	SELECT &v_tablaDatos
	GO TOP 
	IF NOT EOF()
	
		v_idcostop 	 = 0
		v_idcomproba = Comprobantes_sql.idcomproba
		v_pventa	 = Comprobantes_sql.pventa
		v_entidad	 = entidad_sel.entidad
		v_nombre	 = ALLTRIM(entidad_sel.apellido)+" "+ALLTRIM(entidad_sel.nombre)+" "+ALLTRIM(entidad_sel.compania)
		v_numero 	 = maxnumerocom(v_idcomproba, v_pventa,1)
		v_fecha		 = &v_tablaDatos..fecha
		
		v_TablaL	= &v_tablaDatos..tablaL
		v_CampoL	= &v_tablaDatos..campoL
		v_IdL		= &v_tablaDatos..idL
		v_observa	= &v_tablaDatos..detalle

		DIMENSION lamatriz1(8,2)
		DIMENSION lamatriz2(13,2)

	******INSERTO CABECERA DE COSTO ***********************************

		lamatriz1(1,1)='idcostop'
		lamatriz1(1,2)= ALLTRIM(STR(v_idcostop))
		lamatriz1(2,1)='idcomproba'
		lamatriz1(2,2)=ALLTRIM(STR(v_idcomproba))
		lamatriz1(3,1)='pventa'
		lamatriz1(3,2)=ALLTRIM(STR(v_pventa))
		lamatriz1(4,1)='numero'
		lamatriz1(4,2)= ALLTRIM(STR(v_numero))
		lamatriz1(5,1)='fecha'
		lamatriz1(5,2)= "'"+ALLTRIM(v_fecha)+"'"
		lamatriz1(6,1)='entidad'
		lamatriz1(6,2)=ALLTRIM(STR(v_entidad))
		lamatriz1(7,1)='nombre'
		lamatriz1(7,2)="'"+alltrim(v_nombre)+"'"
		lamatriz1(8,1)='observa'
		lamatriz1(8,2)="'"+ALLTRIM(v_observa)+"'"

		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'costop'
		p_matriz    = 'lamatriz1'
		p_conexion  = vconeccionC
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" Costos ",0+48+0,"Error")
		ENDIF  

		sqlmatriz(1)="SELECT last_insert_id() as maxid "
		verror=sqlrun(vconeccionF,"max_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo ID ",0+48+0,"Error")
		    v_errores = .T.
		ENDIF 
		SELECT max_sql
		GO TOP 
		v_idcostop = VAL(max_sql.maxid)
		USE IN max_sql 


	*** INSERTO DETALLE ***			
		SELECT &v_tablaDatos
		v_totalneto = 0
		
		DO WHILE !EOF() 

			v_idcostoh = 0
			v_articulo = &v_TablaDatos..articulo
			v_cantidad = &v_TablaDatos..cantidad
			v_unitario = &v_TablaDatos..unitario
			v_idmate   = &v_TablaDatos..idmate
			v_impuestos= 0.00
			v_impuesto = 0
			v_razonimp   = 0
			
			
			** Obtengo o el Articulo o el Material asociado al Costo **
			IF v_idmate = 0 THEN  && Articulos		
				sqlmatriz(1)=" select detalle, unidad, costo from articulos where articulo = '"+ALLTRIM(v_articulo)+"'"
			ELSE && Materiales
				sqlmatriz(1)=" select detalle, unidad, impuni as costo  from otmateriales where idmate = "+ALLTRIM(STR(v_idmate))		
			ENDIF 
			verror=sqlrun(vconeccionC,"articulo_sql")
			IF verror=.f.  
				MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de articulos ",0+48+0,"Error")
				=abreycierracon(vconeccionC,"")
				RETURN v_retornocmp
			ENDIF
			SELECT articulo_sql
			GO TOP 
			IF !EOF() THEN
				v_detalle = articulo_sql.detalle
				v_unidad  = articulo_sql.unidad
				IF v_unitario  = 0 THEN 
					v_unitario = articulo_sql.costo	
				ENDIF 
			ELSE
				v_detalle = ""
				v_unidad  = ""  
			ENDIF 
			USE IN articulo_sql 
			v_neto	   = v_cantidad * v_unitario
			v_total	   = v_neto
			v_totalneto = v_totalneto + v_neto

			lamatriz2(1,1)='idcostoh'
			lamatriz2(1,2)=ALLTRIM(STR(v_idcostoh))
			lamatriz2(2,1)='idcostop'
			lamatriz2(2,2)=ALLTRIM(STR(v_idcostop))
			lamatriz2(3,1)='articulo'
			lamatriz2(3,2)="'"+ALLTRIM(v_articulo)+"'"
			lamatriz2(4,1)='detalle'
			lamatriz2(4,2)= "'"+ALLTRIM(v_detalle)+"'"
			lamatriz2(5,1)='cantidad'
			lamatriz2(5,2)=ALLTRIM(STR(v_cantidad,13,4))
			lamatriz2(6,1)='unidad'
			lamatriz2(6,2)="'"+alltrim(v_unidad )+"'"
			lamatriz2(7,1)='unitario'
			lamatriz2(7,2)=ALLTRIM(STR(v_unitario,13,4))
			lamatriz2(8,1)='impuestos'
			lamatriz2(8,2)=ALLTRIM(STR(v_impuestos,13,4))
			lamatriz2(9,1)='total'
			lamatriz2(9,2)=ALLTRIM(STR(v_total,13,4))
			lamatriz2(10,1)='impuesto'
			lamatriz2(10,2)=ALLTRIM(STR(v_impuesto))
			lamatriz2(11,1)='razonimp'
			lamatriz2(11,2)=ALLTRIM(STR(v_razonImp,13,4))
			lamatriz2(12,1)='neto'
			lamatriz2(12,2)=ALLTRIM(STR(v_neto,13,4))
			lamatriz2(13,1)='idmate'
			lamatriz2(13,2)=ALLTRIM(STR(v_idmate))

			p_tabla     = 'costoh'
			p_matriz    = 'lamatriz2'
			p_conexion  = vconeccionC
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error ",0+48+0,"Error")
			ENDIF						
		
			SELECT &v_TablaDatos 
			SKIP 		
		ENDDO 

		IF v_IdL > 0 THEN 	&& Agrego vinculo con Registro de Otra Tabla
			RTA=FLinkRegistro ( "I", vconeccionC,  'costop', 'idcostop', v_idcostop, v_TablaL, v_CampoL, v_IdL )
			MESSAGEBOX(RTA)

		ENDIF 

		SELECT &v_tablaDatos


		USE IN &v_tablaDatos  
		USE IN entidad_sel
		USE IN Comprobantes_sql
		
		release lamatriz1
		release lamatriz2
 		release lamatriz3
 		
 		v_retornocmp = v_idcostop 


	*** REGISTRO estado activo ***

	registrarEstado("costop","idcostop",v_idcostop,"I","ACTIVO")

	*** REGISTRAR TABLAS FALTANTES ***
		
			*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***

	guardaCajaRecaH (v_idcomproba, v_idcostop)

	***Contabiliza el comprobante de Costos
	** GENERO EL ASIENTO PARA EL COSTO
	v_cargo = ContabilizaCompro('costop', v_idcostop , vconeccionC, v_totalneto )
	
	ENDIF 

	=abreycierracon(vconeccionC,"")	
	RETURN v_retornocmp
ENDFUNC 




FUNCTION FLinkRegistro
PARAMETERS plr_fun, plr_cone, plr_tablaa, plr_campoa, plr_ida, plr_tablab, plr_campob, plr_idb
*#/----------------------------------------
**   FUNCIÓN PARA GENERAR , VERIFICAR O ELIMINAR VINCULOS ENTRE DISTINTOS REGISTROS DE TABLAS DE LA BD
** PARAMETROS: 	
**		plr_fun: Comportamiento 'I o C '=Crear Vinculo entre registros, 'V'=Verificar Vinculos entre Registros, 'E':Eliminar Vinculos entre Registros,
**      plr_cone: Conexion a la base de datos , si viene en 0 debo crear la Conexion
**		plr_tablaa: Tabla A para vincular Registro
**		plr_campoa: Campo A de tabla a vincular Registro
**		plr_ida:	Valor del Campo A de la tabla a Vincular
**		plr_tablab: Tabla B para vincular Registro
**		plr_campob: Campo B de la Tabla a Vincular Registro
**		plr_idb:    Valor del Campo B de la tabla a Vincular
** 		RETORNO: 'CS o CN','VS o VN', 'ES o EN', o '' si no pudo hacer nada
*#/----------------------------------------
	
	v_retornoFL = ""

	IF plr_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionFL = plr_cone
	ELSE 
		vconeccionFL = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	

	DO CASE 
		CASE plr_fun = 'C' OR plr_fun = 'I'
		
			IF !EMPTY(plr_tablaa) AND !EMPTY(plr_campoa) AND !EMPTY(plr_ida) AND ;
			   !EMPTY(plr_tablab) AND !EMPTY(plr_campob) AND !EMPTY(plr_idb) 	  THEN 	&& Agrego vinculo con Registro de Otra Tabla
			   
				v_idlinkreg = 0

				DIMENSION lamatriz3(7,2)

				lamatriz3(1,1)='idlinkreg'
				lamatriz3(1,2)=ALLTRIM(STR(v_idlinkreg))
				lamatriz3(2,1)='tablaa'
				lamatriz3(2,2)="'"+ALLTRIM(plr_tablaa)+"'"
				lamatriz3(3,1)='campoa'
				lamatriz3(3,2)="'"+ALLTRIM(plr_campoa)+"'"
				lamatriz3(4,1)='ida'
				lamatriz3(4,2)= ALLTRIM(STR(plr_ida))
				lamatriz3(5,1)='tablab'
				lamatriz3(5,2)="'"+ALLTRIM(plr_tablab)+"'"
				lamatriz3(6,1)='campob'
				lamatriz3(6,2)="'"+ALLTRIM(plr_campob)+"'"
				lamatriz3(7,1)='idb'
				lamatriz3(7,2)=ALLTRIM(STR(plr_idb))

				p_tipoope = 'I'
				p_condicion = ""
				p_tabla     = 'linkregistro'
				p_matriz    = 'lamatriz3'
				p_conexion  = vconeccionFL
				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
				    MESSAGEBOX("Ha Ocurrido un Error en insercion de linkregistro ",0+48+0,"Error")
					v_retornoFL = 'CN'
				ENDIF		
								
				RELEASE lamatriz3
				v_retornoFL = 'IS'
			ELSE
				v_retornoFL = 'IN'
			ENDIF 




		CASE plr_fun = 'E' &&Eliminar vinculos entre registros

			IF !EMPTY(plr_tablaa) AND !EMPTY(plr_campoa) AND !EMPTY(plr_ida) AND ;
			   !EMPTY(plr_tablab) AND !EMPTY(plr_campob) AND !EMPTY(plr_idb) 	THEN  && Elimino Vinculo Específico 
				sqlmatriz(1)= "delete from linkregistro where tablaa = '"+alltrim(plr_tablaa)+"' and  campoa = '"+alltrim(plr_campoa)+"' and ida = "+alltrim(STR(plr_ida))+" "
				sqlmatriz(2)= " 						and	  tablab = '"+alltrim(plr_tablab)+"' and  campob = '"+alltrim(plr_campob)+"' and idb = "+alltrim(STR(plr_idb))+" "
			ENDIF 
			IF !EMPTY(plr_tablaa) AND !EMPTY(plr_campoa) AND !EMPTY(plr_ida) AND EMPTY(plr_tablab)	THEN 	&& Elimino Vinculo Para una tabla 
				sqlmatriz(1)= "delete from linkregistro where ( tablaa = '"+alltrim(plr_tablaa)+"' and  campoa = '"+alltrim(plr_campoa)+"' and ida = "+alltrim(STR(plr_ida))+" ) "
				sqlmatriz(2)= " 						or	  ( tablab = '"+alltrim(plr_tablaa)+"' and  campob = '"+alltrim(plr_campoa)+"' and idb = "+alltrim(STR(plr_ida))+" ) "
			ENDIF 
			
			verror=sqlrun(vconeccionFL,"borra_rel")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en Eliminacion de Registros de Tablas... ",0+48+0,"Error")
			    RETURN v_retornoFL 
			ENDIF 
			v_retornoFL = 'ES'



	
		CASE plr_fun = 'V' 


			IF !EMPTY(plr_tablaa) AND !EMPTY(plr_campoa) AND !EMPTY(plr_ida) THEN  ;

				IF  !EMPTY(plr_tablab) AND !EMPTY(plr_campob) AND !EMPTY(plr_idb) 	THEN  && Verifico si Existe el Registro 
					sqlmatriz(1)= "select * from linkregistro where ( tablaa = '"+alltrim(plr_tablaa)+"' and  campoa = '"+alltrim(plr_campoa)+"' and ida = "+alltrim(STR(plr_ida))+"  "
					sqlmatriz(2)= " 						 and	  tablab = '"+alltrim(plr_tablab)+"' and  campob = '"+alltrim(plr_campob)+"' and idb = "+alltrim(STR(plr_idb))+" )  "
					sqlmatriz(3)= "							 OR 	( tablaa = '"+alltrim(plr_tablab)+"' and  campoa = '"+alltrim(plr_campob)+"' and ida = "+alltrim(STR(plr_idb))+"  "
					sqlmatriz(4)= " 						 and      tablab = '"+alltrim(plr_tablaa)+"' and  campob = '"+alltrim(plr_campoa)+"' and idb = "+alltrim(STR(plr_ida))+" ) "
				
				ELSE 
					sqlmatriz(1)= "select * from linkregistro where (( tablaa = '"+alltrim(plr_tablaa)+"' and  campoa = '"+alltrim(plr_campoa)+"' and ida = "+alltrim(STR(plr_ida))+" )  "
					sqlmatriz(2)= " 						 or	     ( tablab = '"+alltrim(plr_tablaa)+"' and  campob = '"+alltrim(plr_campoa)+"' and idb = "+alltrim(STR(plr_ida))+" )) and ( 1 = 1 "		
					sqlmatriz(3)= IIF(EMPTY(plr_tablab),""," and ( tablaa = '"+alltrim(plr_tablab)+"' or tablab = '"+alltrim(plr_tablab)+"' ) ")
					sqlmatriz(4)= IIF(EMPTY(plr_campob),""," and ( campoa = '"+alltrim(plr_campob)+"' or campob = '"+alltrim(plr_campob)+"' ) ")
					sqlmatriz(5)= IIF(EMPTY(plr_idb),""," and ( ida = "+alltrim(STR(plr_idb))+" or idb = "+alltrim(STR(plr_idb))+" ) ")+" ) "
				
				ENDIF 
							
				verror=sqlrun(vconeccionFL,"existe_rel")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en Seleccion de LinkRegistros ... ",0+48+0,"Error")
				    RETURN v_retornoFL 
				ENDIF
				
				SELECT existe_rel
				GO TOP 
				IF !EOF() THEN 
					v_retornoFL = 'VS'
				ELSE
					v_retornoFL = 'VN'			
				ENDIF 
				USE IN existe_rel 
			
			ELSE
				v_retornoFL = 'VN'			
			ENDIF 

		OTHERWISE
	ENDCASE 
	


	IF plr_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionFL = plr_cone
	ELSE 
		= abreycierracon(vconeccionFL ,"")
	ENDIF 	
	
	RETURN v_retornoFL

ENDFUNC 




FUNCTION GENCostosOT
PARAMETERS p_idot, p_cone
*#/----------------------------------------
**** GENERA UN ARCHIVO CON LOS COMPRONENTES DE COSTOS DE LAS ORDENES DE TRABAJO
** Si los costos unitarios recibidos son 0 entonces busca el costo en las tablas de articulos o materiales
** PARAMETROS: 	p_idot: IDOT de la Orden de Trabajo para la cual obtener los materiales ejecutados para los costos
** 
** RETORNO:		Nombre de archivo con el detalle de los materiales ejecutados en la orden de trabajo
** Tabla resultado generada: 
** fecha c(8), entidad i, articulo c(50), cantidad y, unitario y, idmate i, tablal c(50), campol c(50), idl i, detalle c(150)
*#/----------------------------------------

	v_retornoarchi = ""
	IF p_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionFL = p_cone
	ELSE 
		vconeccionFL = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	

**--- Obtengo los Materiales Ejecutados para la OT
	sqlmatriz(1)=" select m.idmate, m.codigomat as articulo, SUM(m.cantidad) as cantidad, m.impuni as unitario, p.entidad "
	sqlmatriz(2)=" from otejecum m "
	sqlmatriz(3)=" left join otordentra ot on ot.idot = m.idot "
	sqlmatriz(4)=" left join otpedido p on p.idpedido = ot.idpedido "
	sqlmatriz(5)=" where  m.idot = "+alltrim(STR(p_idot))+" group by m.idmate "
	
	verror=sqlrun(vconeccionFL,"otejecum_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en Seleccion de Ejecución Materiales ... ",0+48+0,"Error")
	    RETURN v_retornoarchi
	ENDIF
	SELECT * FROM otejecum_sql INTO TABLE otejecumCT
	USE IN otejecum_sql 
	
**--- Obtengo las Horas Ejecutados para la OT
	sqlmatriz(1)=" select m.idmate, m.codigomat as articulo, m.fechai, m.horai, m.fechaf, m.horaf, p.entidad "
	sqlmatriz(2)=" from otejecuh m "
	sqlmatriz(3)=" left join otordentra ot on ot.idot = m.idot "
	sqlmatriz(4)=" left join otpedido p on  p.idpedido = ot.idpedido "
	sqlmatriz(5)=" where  m.idot = "+alltrim(STR(p_idot))

	verror=sqlrun(vconeccionFL,"otejecuh_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en Seleccion de Ejecución de Horas ... ",0+48+0,"Error")
	    RETURN v_retornoarchi
	ENDIF

	SELECT * FROM otejecuh_sql INTO TABLE otejecuhCT0
	USE IN otejecuh_sql 
	SELECT otejecuhCT0 
	ALTER table otejecuhCT0 ADD COLUMN horasejecu c(13)
	ALTER table otejecuhCT0 ADD COLUMN cantidad y
	replace ALL horasejecu WITH cantidadhoras(ALLTRIM(fechai)+ALLTRIM(horai),ALLTRIM(fechaf)+ALLTRIM(horaf)) 
	replace ALL cantidad WITH VAL(SUBSTR(horasejecu,1,6))+VAL(SUBSTR(horasejecu,8,2))/60
	
	SET ENGINEBEHAVIOR 70
	SELECT idmate, articulo, SUM(cantidad) as cantidad , 0 as costo, entidad FROM otejecuhCT0 INTO TABLE otejecuhCT GROUP BY idmate 
	SET ENGINEBEHAVIOR 90
	
	USE IN otejecuhCT0
	

	vnombrearchi = "costos"+frandom()
	CREATE TABLE &vnombrearchi ( fecha c(8), entidad i, articulo c(50), cantidad y, unitario y, idmate i, tablal c(50), campol c(50), idl i, detalle c(150) )
	SELECT &vnombrearchi
	APPEND FROM otejecumCT
	APPEND FROM otejecuhCT
	replace ALL fecha WITH DTOS(DATE()), tablal WITH 'otordentra', campol WITH 'idot', idl WITH p_idot, detalle WITH " Cierre OT "+alltrim(STR(p_idot))
	USE IN otejecumCT
	USE IN otejecuhCT
	USE IN &vnombrearchi 

	IF p_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionFL = p_cone
	ELSE 
		= abreycierracon(vconeccionFL ,"")
	ENDIF 	
	
	v_retornoarchi = vnombrearchi 
	RETURN v_retornoarchi
ENDFUNC 





FUNCTION GetLinkCompro
PARAMETERS pgl_idcompro, pgl_idregi, p_cone, p_idcomproAso
*#/ ------------------------------
* Obtiene en una tabla todos los comprobantes vinculados con uno recibido como parametro
* PARAMETROS : 
*	pgl_idcompro: idcomproba que identifica el comprobante para el cual se quiere saber sus vinculos 
*   pgl_idregi :  id que identifica univocamente el comprobante para el cual se quiere saber sus vinculos
* RETORNO: 
* 	retorna una tabla con los comprobantes vinculados al recibido como parámetro si los hubiere.
*   Si hay error retorna una cadena vacia
*#/--------------------------------

	v_retornoarchi = ""
	IF p_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionL = p_cone
	ELSE 
		vconeccionL = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	
	
	IF TYPE('p_idcomproAso') = 'L'
		v_idcomproAsoB =" "
		v_idcomproAsoA = " "
	ELSE
		v_idcomproAsoB =" and l.idcomprobab = "+ALLTRIM(STR(p_idcomproAso))
		v_idcomproAsoA  =" and l.idcomprobaa = "+ALLTRIM(STR(p_idcomproAso))
	ENDIF 


**--- Obtengo Los Comprobantes Vinculados al recibido como parametro si el recibido está del lado de comprobantes A
	sqlmatriz(1)=" select l.idlinkcomp, l.idcomprobaa as idcomproa, l.idregistroa as idrega, l.idcomprobab as idcomprob, l.idregistrob as idregb, "
	sqlmatriz(2)=" c.tabla as tablaa, t.opera as operaa, d.tabla as tablab, u.opera as operab  from linkcompro  l "
	sqlmatriz(3)=" left join comprobantes c on c.idcomproba   = l.idcomprobaa"
	sqlmatriz(4)=" left join tipocompro   t on t.idtipocompro = c.idtipocompro "
	sqlmatriz(5)=" left join comprobantes d on d.idcomproba   = l.idcomprobab "
	sqlmatriz(6)=" left join tipocompro   u on u.idtipocompro = d.idtipocompro "
	sqlmatriz(7)=" where  l.idcomprobaa = "+alltrim(STR(pgl_idcompro))+" and l.idregistroa = "+alltrim(STR(pgl_idregi))+v_idcomproAsoB 
	

	verror=sqlrun(vconeccionL,"linkcomproA_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en Seleccion LinkCompro ... ",0+48+0,"Error")
	    RETURN v_retornoarchi
	ENDIF
	

**--- Obtengo Los Comprobantes Vinculados al recibido como parametro si el recibido está del lado de comprobantes B
	sqlmatriz(1)=" select l.idlinkcomp, l.idcomprobab as idcomproa, l.idregistrob as idrega, l.idcomprobaa as idcomprob, l.idregistroa as idregb, "
	sqlmatriz(2)=" c.tabla as tablaa, t.opera as operaa, d.tabla as tablab, u.opera as operab  from linkcompro  l "
	sqlmatriz(3)=" left join comprobantes c on c.idcomproba  = l.idcomprobab "
	sqlmatriz(4)=" left join tipocompro   t on t.idtipocompro = c.idtipocompro "
	sqlmatriz(5)=" left join comprobantes d on d.idcomproba   = l.idcomprobaa "
	sqlmatriz(6)=" left join tipocompro   u on u.idtipocompro = d.idtipocompro "
	sqlmatriz(7)=" where  l.idcomprobab = "+alltrim(STR(pgl_idcompro))+" and l.idregistrob = "+alltrim(STR(pgl_idregi))+v_idcomproAsoA
		

	verror=sqlrun(vconeccionL,"linkcomproB_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en Seleccion LinkCompro ... ",0+48+0,"Error")
	    RETURN v_retornoarchi
	ENDIF
	
	SELECT * FROM linkcomproA_sql UNION ;
	SELECT * FROM linkcomproB_sql INTO TABLE linkcomproU
	
	USE IN linkcomproA_sql 
	USE IN linkcomproB_sql 
	
	SELECT linkcomproU

	vnombrearchi = "GetLinkCMP"+frandom()
	CREATE TABLE &vnombrearchi ( idlinkcomp i , idcomproa i , idrega i , idcomprob i , idregb i , tablaa c(30), operaa i , tablab c(30), operab i )
	SELECT &vnombrearchi 
	APPEND FROM linkcomproU
	USE IN linkcomproU

	SELECT &vnombrearchi 
	USE IN &vnombrearchi 

	IF p_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionL = p_cone
	ELSE 
		= abreycierracon(vconeccionL ,"")
	ENDIF 	

	v_retornoarchi = vnombrearchi 
	RETURN v_retornoarchi
ENDFUNC 




FUNCTION ctaCteBancos
PARAMETERS p_tablaccb,p_idregistroccb,p_idcuentaccb
*#/ ------------------------------
* Crea una tabla Resultado de cuenta corriente asociada a una cuenta bancaria 
* PARAMETROS : 
*	p_tablaccb: Tabla principal con la que se va a generar la tabla resultado, pudiendo ser: 
*					RECIBOS, ANULARP, CAJAINGRESO,CAJAINGRESO,PAGOSPROV,TRANSFERENCIAS.
*   p_idregistroccb:  id del registro asociado a la tabla pasada como parámetro
*	p_idcuentaccb: id de la cuenta de banco
* Descripcion: La función se comporta de diferentes maneras según los parámetro.
*		SI p_tablaccb es vacio -> Regenera la tabla completa, para todas las tablas y todas las combinaciones, ignorando los demas parámetros
*		SI p_tablaccb tiene un valor y SI p_idregistroccb es = 0 -> Regenera la tabla resultado para esa tabla y todas las combinaciones, ignorando la cuenta
*		SI p_tablaccb tiene un valor y SI p_idregistroccb es > 0 -> Inserta en la tabla un registro
*		Para todos los casos retorna la tabla resultado
* RETORNO: 
* 	retorna True o False si insertó correctamente los registros o hubo un error
*#/--------------------------------

r_Retorno = .F.


vconeccionF=abreycierracon(0,_SYSSCHEMA)
v_r_CtaCteBancos = "r_ccb_"

	
	
	

IF TYPE('p_tablaccb') = 'C' AND TYPE('p_idregistroccb') = 'N'

	IF EMPTY(ALLTRIM(p_tablaccb)) = .F. && Pasó como parámetro una tabla

		
			
		
			
			DO CASE 
			CASE ALLTRIM(p_tablaccb) == 'RECIBOS'
			
			
				***********************
				**** TABLA RECIBOS ****
				***********************
				
				v_tablaRecibos = ALLTRIM(v_r_CtaCteBancos)+"recibos"
			
			IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
				
				sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablaRecibos) + " where idrecibo = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
			
				verror=sqlrun(vconeccionF,"existe_tabla")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
			
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablaRecibos)+" (Select dcp.iddetacobro , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'recibos' and c.idrecibo = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
			ELSE && Regenera la tabla resultado para esa tabla 
				sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablaRecibos)
			
				verror=sqlrun(vconeccionF,"existe_tabla")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
			
				sqlmatriz(1)=" create table "+ALLTRIM(v_tablaRecibos)+" as (Select dcp.iddetacobro , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
				sqlmatriz(19)=" where cc.tabla = 'recibos' "
								
			ENDIF 
				
			
			
				sqlmatriz(2)=" c.*, e.cuit, cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp,cc.abrevia,   "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica, tp.detalle as detapagos, "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallecobros dcp  left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='recibos' "
				sqlmatriz(10)=" left join recibos c on c.idcomproba = dcp.idcomproba and c.idrecibo = dcp.idregistro "
				sqlmatriz(11)=" left join entidades e on c.entidad = e.entidad "
				sqlmatriz(12)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(13)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(14)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(15)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallecobros' and clk.registrocp = dcp.iddetacobro "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		
				
				sqlmatriz(20)= " order by fecha, numero) "

			
				*verror=sqlrun(vconeccionF,ALLTRIM(v_tabla_r_CtaCteBancos)+"_recibos_sql")
				verror=sqlrun(vconeccionF,"r_ctactebancos_recibos_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
			
			IF p_idregistroccb <= 0
				sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablaRecibos)+"  ADD INDEX idrecibo(idrecibo), ADD INDEX idcuenta(idcuenta)"
				
 				verror=sqlrun(vconeccionF,"r_ctactebancos_recibos_sqli")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
			
			ENDIF 
			
				
				
			CASE ALLTRIM(p_tablaccb) == 'ANULARPAGO'
		
				***********************
				**** TABLA ANULARPAGO****
				***********************
			
				v_tablaAnularpa = ALLTRIM(v_r_CtaCteBancos)+"anularpago"
					
				IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
				
					sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablaAnularpa) + " where idanularp = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablaAnularpa)+" (Select dcp.iddetacobro , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'anularp' and c.idpago > 0 and c.idanularp = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				ELSE && Regenera la tabla resultado para esa tabla 
				
					sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablaAnularpa)
					
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					sqlmatriz(1)=" create table "+ALLTRIM(v_tablaAnularpa)+" as (Select dcp.iddetacobro , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'anularp' and c.idpago > 0 "
				ENDIF 
			
				
				
			
				
				sqlmatriz(2)=" c.*,  '             ' AS cuit, cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp,cc.abrevia,   "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica, tp.detalle as detapagos, pa.entidad, pa.nombre, pa.numero as npago,  "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallecobros dcp  left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='anularp' "
				sqlmatriz(10)=" left join anularp c on c.idcomproba = dcp.idcomproba and c.idanularp = dcp.idregistro left join pagosprov pa on pa.idpago = c.idpago "
				sqlmatriz(12)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(13)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(14)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(15)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallecobros' and clk.registrocp = dcp.iddetacobro "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		

				sqlmatriz(20)= " order by fecha, numero) "

				verror=sqlrun(vconeccionF,"r_ctactebancos_anularpago_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
				
				
				IF p_idregistroccb <= 0
					sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablaAnularpa)+"  ADD INDEX idanularp(idanularp), ADD INDEX idcuenta(idcuenta)"
					
	 				verror=sqlrun(vconeccionF,"r_ctactebancos_anularpago_sqli")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				ENDIF 
			
				
			
				
			CASE ALLTRIM(p_tablaccb) == 'ANULARRECIBO'
			
			
				***********************
				**** TABLA ANULARRECIBO****
				***********************
				
				v_tablaAnularre = ALLTRIM(v_r_CtaCteBancos)+"anularrecibo"
				
				IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
				
					sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablaAnularre) + " where idanularp = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablaAnularre)+" (Select dcp.iddetapago , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'anularp'  and c.idrecibo > 0 and c.idanularp = "+ALLTRIM(STR(p_idregistroccb))+ IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")

				ELSE && Regenera la tabla resultado para esa tabla 
				
					sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablaAnularre)
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" create table "+ALLTRIM(v_tablaAnularre)+" as (Select dcp.iddetapago , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'anularp'  and c.idrecibo > 0 "
				ENDIF 
				
				
				
				
				*sqlmatriz(1)=" create table "+ALLTRIM(v_tablaAnularre)+" as (Select dcp.iddetapago , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
				sqlmatriz(2)=" c.*, '             ' AS cuit ,  cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp,cc.abrevia,   "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica, tp.detalle as detapagos, re.entidad, re.nombre, re.numero as nrecibo,  "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallepagos dcp  left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='anularp' "
				sqlmatriz(10)=" left join anularp c on c.idcomproba = dcp.idcomproba and c.idanularp = dcp.idregistro left join recibos re on re.idrecibo = c.idrecibo "
				sqlmatriz(12)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(13)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(14)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(15)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallecobros' and clk.registrocp = dcp.iddetapago "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		
				*sqlmatriz(19)=" where cc.tabla = 'anularp'  and c.idrecibo > 0 "
				sqlmatriz(20)= " order by fecha, numero) "

				verror=sqlrun(vconeccionF,"r_ctactebancos_anularrecibo_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
				
				
				IF p_idregistroccb <= 0
					sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablaAnularre)+"  ADD INDEX idanularp(idanularp), ADD INDEX idcuenta(idcuenta)"
					
	 				verror=sqlrun(vconeccionF,"r_ctactebancos_anularrecibo_sqli")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				endif 
				
			
			CASE ALLTRIM(p_tablaccb) == 'CAJAINGRESO'
				***********************
				**** TABLA CAJAINGRESO****
				***********************
		
				v_tablacajaingreso = ALLTRIM(v_r_CtaCteBancos)+"cajaingreso"
			
				IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
			
			
					sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablacajaingreso) + " where idcajaie = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablacajaingreso)+ " (Select dcp.iddetacobro , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)= " where cc.tabla = 'cajaie' and c.detallecp = 'detallecobros' and  c.idcajaie = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
					
					
				ELSE && Regenera la tabla resultado para esa tabla 
					sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablacajaingreso)
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" create table "+ALLTRIM(v_tablacajaingreso)+" as (Select dcp.iddetacobro , dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)= " where cc.tabla = 'cajaie' and c.detallecp = 'detallecobros'  "
					
				ENDIF 
				
				
				
				
				sqlmatriz(2)=" c.*,  cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp, cc.abrevia,   "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica,tp.detalle as detapagos, "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallecobros dcp left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='cajaie' "
				sqlmatriz(10)=" left join cajaie c on c.idcomproba = dcp.idcomproba and c.idcajaie = dcp.idregistro "
				sqlmatriz(11)=" left join entidades e on c.entidad = e.entidad "
				sqlmatriz(12)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(13)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(14)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(15)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallecobros' and clk.registrocp = dcp.iddetacobro "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		
				
				sqlmatriz(20)= " order by fecha, numero) "
			
				verror=sqlrun(vconeccionF,"r_ctactebancos_cajaingreso_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
				
				
				IF p_idregistroccb <= 0
					sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablacajaingreso)+"  ADD INDEX idcajaie(idcajaie), ADD INDEX idcuenta(idcuenta)"
					
	 				verror=sqlrun(vconeccionF,"r_ctactebancos_cajaingreso_sqli")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				endif
			
			CASE ALLTRIM(p_tablaccb) == 'CAJAEGRESO'
				***********************
				**** TABLA CAJAEGRESO****
				***********************
			
				v_tablacajaegreso = ALLTRIM(v_r_CtaCteBancos)+"cajaegreso"
			
				sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablacajaegreso)
				
				IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
					sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablacajaegreso) + " where idcajaie = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablacajaegreso)+" (Select dcp.iddetapago, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					
					sqlmatriz(19)=" where cc.tabla = 'cajaie' and c.detallecp = 'detallepagos' and c.idcajaie = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
					
				ELSE && Regenera la tabla resultado para esa tabla 
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				
					sqlmatriz(1)=" create table "+ALLTRIM(v_tablacajaegreso)+" as (Select dcp.iddetapago, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'cajaie' and c.detallecp = 'detallepagos' "
					
				ENDIF 
				
				
				
				
				
				sqlmatriz(2)=" c.*,  cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp, cc.abrevia,   "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica, tp.detalle as detapagos, "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallepagos dcp  left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='cajaie' "
				sqlmatriz(10)=" left join cajaie c on c.idcomproba = dcp.idcomproba and c.idcajaie = dcp.idregistro "
				sqlmatriz(11)=" left join entidades e on c.entidad = e.entidad "
				sqlmatriz(12)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(13)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(14)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(15)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallepagos' and clk.registrocp = dcp.iddetapago "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		
				
				sqlmatriz(20)= " order by fecha, numero) "
		
				verror=sqlrun(vconeccionF,"r_ctactebancos_cajaegreso_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
				
				
				IF p_idregistroccb <= 0
					sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablacajaegreso)+"  ADD INDEX idcajaie(idcajaie), ADD INDEX idcuenta(idcuenta)"
					
	 				verror=sqlrun(vconeccionF,"r_ctactebancos_cajaegreso_sqli")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				endif
			
			CASE ALLTRIM(p_tablaccb) == 'PAGOSPROV'
		
				***********************
				**** TABLA PAGOSPROV****
				***********************
				
				v_tablapagosprov = ALLTRIM(v_r_CtaCteBancos)+"pagosprov"
				
				IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
			
					sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablapagosprov) + " where idpago = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablapagosprov)+" (Select dcp.iddetapago, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'pagosprov' and c.idpago = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				ELSE && Regenera la tabla resultado para esa tabla 
					sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablapagosprov)
					
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" create table "+ALLTRIM(v_tablapagosprov)+" as (Select dcp.iddetapago, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)="where cc.tabla = 'pagosprov' "
				ENDIF 
				
				
			
				
				sqlmatriz(2)=" c.*, e.cuit, cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp,cc.abrevia,   "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica, tp.detalle as detapagos, "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallepagos dcp left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='pagosprov' "
				sqlmatriz(10)=" left join pagosprov c on c.idcomproba = dcp.idcomproba and c.idpago = dcp.idregistro "
				sqlmatriz(11)=" left join entidades e on c.entidad = e.entidad "
				sqlmatriz(12)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(13)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(14)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(15)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallepagos' and clk.registrocp = dcp.iddetapago "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		
				
				sqlmatriz(20) =  " order by fecha, numero) "

				verror=sqlrun(vconeccionF,"r_ctactebancos_pagosprov_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
				
				
				IF p_idregistroccb <= 0
					sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablapagosprov)+"  ADD INDEX idpago(idpago), ADD INDEX idcuenta(idcuenta)"
					
	 				verror=sqlrun(vconeccionF,"r_ctactebancos_pagosprov_sqli")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				ENDIF
				
				
			CASE ALLTRIM(p_tablaccb) == 'TRANSFERENCIASD'		
		
				***********************
				**** TABLA TRANSFERENCIASD****
				***********************
				
				v_tablatransferenciasd = ALLTRIM(v_r_CtaCteBancos)+"transferenciasd"
				
				IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
			
					sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablatransferenciasd) + " where idtransfe = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				
					
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablatransferenciasd)+" (Select dcp.iddetacobro, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'transferencias'  and c.idtransfe = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				
					
				ELSE && Regenera la tabla resultado para esa tabla 
					sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablatransferenciasd)
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				
					sqlmatriz(1)=" create table "+ALLTRIM(v_tablatransferenciasd)+" as (Select dcp.iddetacobro, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)="where cc.tabla = 'transferencias'  "
					
				ENDIF 
				
				
				
				
				
				sqlmatriz(2)=" c.*, '             ' AS cuit, cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp,cc.abrevia,   "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica, tp.detalle as detapagos, cbo.detalle as detactao, cbd.detalle as detactad, "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallecobros dcp left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='transferencias' "
				sqlmatriz(10)=" left join transferencias c on c.idcomproba = dcp.idcomproba and c.idtransfe = dcp.idregistro "
				sqlmatriz(11)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(12)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(13)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(14)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(15)=" left join cajabancos cbo on cbo.idcuenta = c.idcuentao left join cajabancos cbd on cbd.idcuenta = c.idcuentad "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallecobros' and clk.registrocp = dcp.iddetacobro "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		
				
				sqlmatriz(20)=" order by fecha, numero) "
				
				verror=sqlrun(vconeccionF,"r_ctactebancos_transferenciasd_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
				
				IF p_idregistroccb <= 0
					sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablatransferenciasd)+"  ADD INDEX idtransfe(idtransfe), ADD INDEX idcuenta(idcuenta)"
					
	 				verror=sqlrun(vconeccionF,"r_ctactebancos_transferencias_sqli")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				ENDIF
				
				
			CASE ALLTRIM(p_tablaccb) == 'TRANSFERENCIASO'		
			
				***********************
				**** TABLA TRANSFERENCIASO****
				***********************
				
				v_tablatransferenciaso = ALLTRIM(v_r_CtaCteBancos)+"transferenciaso"
				
				IF p_idregistroccb > 0 && Inserta en la tabla esa combinación de parámetros
					sqlmatriz(1)= "delete from  "+ALLTRIM(v_tablatransferenciaso) + " where idtransfe = "+ALLTRIM(STR(p_idregistroccb)) + IIF(p_idcuentaccb>0," and idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
				
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" insert into "+ALLTRIM(v_tablatransferenciaso)+" (Select dcp.iddetapago, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'transferencias' and c.idtransfe = "+ALLTRIM(STR(p_idregistroccb))+ IIF(p_idcuentaccb>0," and dcp.idcuenta = "+ALLTRIM(STR(p_idcuentaccb)),"")
					
				ELSE && Regenera la tabla resultado para esa tabla 
					sqlmatriz(1)= "drop table if exists "+ALLTRIM(v_tablatransferenciaso)
		
					verror=sqlrun(vconeccionF,"existe_tabla")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
					
					sqlmatriz(1)=" create table "+ALLTRIM(v_tablatransferenciaso)+" as (Select dcp.iddetapago, dcp.idregistro, dcp.idtipopago, dcp.importe as importedet, dcp.idcuenta,  "
					sqlmatriz(19)=" where cc.tabla = 'transferencias'  "
					
					
				ENDIF 
				
				
				
				
				
				sqlmatriz(2)=" c.*, '             ' AS cuit, cc.tipo as tipocomp, cc.comprobante as nomComp,cc.ctacte,cc.idtipocompro as idtipocomp,cc.abrevia, "
				sqlmatriz(3)=" tc.opera, pv.puntov, pv.electronica, tp.detalle as detapagos, cbo.detalle as detactao, cbd.detalle as detactad, "
				sqlmatriz(4)=" ifnull(clk.tabla,' ') as tablaclk, ifnull(clk.campo,' ') as campoclk, ifnull(clk.idregistro,0) as idregiclk, "
				sqlmatriz(5)=" ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,' ') as chserie, ifnull(ch.numero,' ') as chnumero, ifnull(ch.importe,0) as chimporte, ifnull(ch.fechaemisi,' ') as fechaemisi, "
				sqlmatriz(6)=" ifnull(ch.fechavence,' ') as fechavence, ifnull(ch.alaorden,' ') as alaorden, ifnull(ch.librador,' ') as librador, ifnull(ch.loentrega,' ') as loentrega, ifnull(ch.cuit,' ') as cuitch, ifnull(ch.cuenta,' ') as cuentach,"
				sqlmatriz(7)=" ifnull(cu.idcupon,0) as idcupon , ifnull(cu.idtarjeta, 0) as idtarjeta, ifnull(cu.numero,0) as cunumero, ifnull(cu.tarjeta,' ') as cutarjeta," 
				sqlmatriz(8)=" ifnull(cu.fecha,' ') as cufecha, ifnull(cu.vencimiento,' ') as cuvence, ifnull(cu.importe,0) as cuimporte, ifnull(cu.titular,' ') as cutitular, ifnull(cu.dni,' ') as cudni, ifnull(cu.codautoriz,' ') as codautori "
				sqlmatriz(9)=" from detallepagos dcp left join comprobantes cc on cc.idcomproba = dcp.idcomproba and cc.tabla ='transferencias' "
				sqlmatriz(10)=" left join transferencias c on c.idcomproba = dcp.idcomproba and c.idtransfe = dcp.idregistro "
				sqlmatriz(11)=" left join tipocompro tc on cc.idtipocompro = tc.idtipocompro "
				sqlmatriz(12)=" left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
				sqlmatriz(13)=" left join puntosventa pv on cp.pventa = pv.pventa "
				sqlmatriz(14)=" left join tipopagos tp on tp.idtipopago = dcp.idtipopago "
				sqlmatriz(15)=" left join cajabancos cbo on cbo.idcuenta = c.idcuentao left join cajabancos cbd on cbd.idcuenta = c.idcuentad "
				sqlmatriz(16)="	left join cobropagolink clk on clk.tablacp = 'detallepagos' and clk.registrocp = dcp.iddetapago "
				sqlmatriz(17)=" left join cheques ch on ch.idcheque = clk.idregistro and clk.tabla = 'cheques' "
				sqlmatriz(18)=" left join cupones cu on cu.idcupon = clk.idregistro and clk.tabla = 'cupones' "		
				
				sqlmatriz(20)=" order by fecha, numero) "


				verror=sqlrun(vconeccionF,"r_ctactebancos_transferenciaso_sql")
				IF verror=.f.
					MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
					= abreycierracon(vconeccionF,"")
					RETURN .F. 
				ENDIF 
				
				
				
				IF p_idregistroccb <= 0
					sqlmatriz(1)=" ALTER TABLE "+ALLTRIM(v_tablatransferenciaso)+"  ADD INDEX idtransfe(idtransfe), ADD INDEX idcuenta(idcuenta)"
					
	 				verror=sqlrun(vconeccionF,"r_ctactebancos_transferencias_sqli")
					IF verror=.f.
						MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
						= abreycierracon(vconeccionF,"")
						RETURN .F. 
					ENDIF 
				ENDIF
				
			OTHERWISE
				RETURN .F.
			ENDCASE
			
			RETURN .T.
		
		
	ELSE && Regenera la tabla completa si existe, sino la crea

		*** Regenero los Saldos Resultados de las Cuentas Bancarias ** 
		**************************************************************
		
		sqlmatriz(1)= "drop table if exists r_bancosaldos "
		verror=sqlrun(vconeccionF,"borra_saldos")
		IF verror=.f.
			MESSAGEBOX("No se puede eliminar la Tabla r_bancosaldos",0+16,"Advertencia")
			= abreycierracon(vconeccionF,"")
			RETURN .F. 
		ENDIF 
		sqlmatriz(1)=" create table r_bancosaldos as SELECT * FROM bancosaldos   "
		verror=sqlrun(vconeccionF,"crea_saldos")
		IF verror=.f.
			MESSAGEBOX("No se puede Crear la Tabla r_bancosaldos",0+16,"Advertencia")
			= abreycierracon(vconeccionF,"")
			RETURN .F. 
		ENDIF 
		sqlmatriz(1)=" ALTER TABLE  r_bancosaldos ADD PRIMARY KEY (idcuenta)   "
		verror=sqlrun(vconeccionF,"crea_saldos")
		IF verror=.f.
			MESSAGEBOX("No se puede Crear la Tabla r_bancosaldos",0+16,"Advertencia")
			= abreycierracon(vconeccionF,"")
			RETURN .F. 
		ENDIF 
		****************************************************************
		
		*** Regenero para cada tabla ** 

		v_ret = ctaCteBancos('RECIBOS',0,0)
		
		IF v_ret = .T.
			v_ret = ctaCteBancos('ANULARPAGO',0,0)
		
		ENDIF 
		
		IF v_ret = .T.
			v_ret = ctaCteBancos('ANULARRECIBO',0,0)
		
		ENDIF 
		
		IF v_ret = .T.
			v_ret = ctaCteBancos('CAJAINGRESO',0,0)
		
		ENDIF 
		
		IF v_ret = .T.
			v_ret = ctaCteBancos('CAJAEGRESO',0,0)
		
		ENDIF 
		
		IF v_ret = .T.
			v_ret = ctaCteBancos('PAGOSPROV',0,0)
		
		ENDIF 
		
		IF v_ret = .T.
			v_ret = ctaCteBancos('TRANSFERENCIASD',0,0)
		
		ENDIF 
		
		IF v_ret = .T.
			v_ret = ctaCteBancos('TRANSFERENCIASO',0,0)
		
		ENDIF 
		
		RETURN v_ret 
		
	ENDIF 


ELSE
	
	RETURN .T.

ENDIF 







FUNCTION GenerarFDC
PARAMETERS p_tablaarti, p_cone, p_idvincular
*#/ ------------------------------
* Crea un Comprobante de facturacion a partir de los articulos recibidos en la tabla pasada como parámetros
* PARAMETROS : 
*	p_tablaarti: tabla conteniendo los datos para generar el comprobante (entidad i , servicio i, cuenta i, articulo c(15), cantidad y, unitario y, fecha c(8), idcomproba i, pventa i)
*   p_cone :  conexion a la base de datos, si es 0 abre una nueva conexion
* RETORNO: 
* 	retorna el idfactura del comprobante generado
*   Si hay error retorna 0
*#/--------------------------------
	IF !(TYPE('p_idvincular')='N') THEN 
		p_idvincular = 0 
	ENDIF 
	* Variables para Vinculos si se recibe parametro de vinculación
	v_idcompro_va	= 0
	v_idregistro_va	= 0
	v_idcompro_vb	= 0
	v_idregistro_vb	= p_idvincular
	
	USE &p_tablaarti IN 0
	SELECT &p_tablaarti
	GO TOP 
	CALCULATE SUM(&p_tablaarti..cantidad * &p_tablaarti..unitario) TO v_tfdc 
	GO TOP 
	IF v_tfdc <= _SYSREDONDEO THEN 
		USE IN &p_tablaarti	
		RETURN 0 
	ENDIF  
	
	
	v_retornoidfactura = 0
	IF p_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionL = p_cone
	ELSE 
		vconeccionL = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	
	




	v_entidad  		= &p_tablaarti..entidad
	v_servicio 		= &p_tablaarti..servicio
	v_cuenta   		= &p_tablaarti..cuenta
	v_idcomproba 	= &p_tablaarti..idcomproba
	v_pventa		= &p_tablaarti..pventa
	v_fecha 		= &p_tablaarti..fecha


	*** Busco el comprobante ***
	sqlmatriz(1)="SELECT c.*,t.opera,v.pventa,v.puntov, pv.electronica from comprobantes c left join compactiv v on c.idcomproba = v.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro "
	sqlmatriz(2)=" left join puntosventa pv on pv.puntov = v.puntov "
	sqlmatriz(3)=" WHERE c.ctacte = 'S' and t.opera <> 0 and ((c.idcomproba = "+ALLTRIM(STR(v_idcomproba ))+" and v.pventa = "+ALLTRIM(STR(v_pventa))+"))"

	verror=sqlrun(vconeccionL ,"compIngEgr_sql")

	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los comprobantes  ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionL ,"")
	    RETURN 0
	ENDIF 


	SELECT compIngEgr_sql
	GO TOP 
	IF EOF()
		MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los comprobantes  ",0+48+0,"Error")
		*** me desconecto	
		=abreycierracon(vconeccionL,"")
	    RETURN 0

		
	ENDIF 


	*** Busco la entidad ***

	sqlmatriz(1)= " SELECT e.*, IFNULL(h.servicio,0) as servicio, IFNULL(h.cuenta,0) as cuenta, "
	sqlmatriz(2)= " IFNULL(h.ruta1,0) as ruta1, IFNULL(h.folio1,0) as folio1, IFNULL(h.ruta2,0) as ruta2, IFNULL(h.folio2,0) as folio2, "
	sqlmatriz(3)= " IFNULL(h.compania,e.compania) as companiah, IFNULL(h.nombre,e.nombre) as nombreh, IFNULL(h.apellido,e.apellido) as apellidoh, "
	sqlmatriz(4)= " IFNULL(h.direccion,e.direccion) as direccionh, IFNULL(h.localidad,e.localidad) as localidadh, IFNULL(h.iva,e.iva) as ivah, IFNULL(h.dni,e.dni) as dnih, IFNULL(h.telefono,e.telefono) as telefonoh, "
	sqlmatriz(5)= " IFNULL(h.cuit,e.cuit) as cuith, IFNULL(h.cp,e.cp) as cph, IFNULL(h.fax,e.fax) as faxh, IFNULL(h.email,e.email) as emailh "
	sqlmatriz(6)= " from entidades e left join entidadesh h on e.entidad = h.entidad  where e.entidad = "+STR(v_entidad)

	verror=sqlrun(vconeccionL,"entidades0_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las entidades ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionL,"")
	    RETURN 0
	ENDIF 


	******************************************************************************************************
	SELECT * FROM entidades0_sql INTO TABLE entidadesax_sql
	ALTER table entidadesax_sql alter COLUMN servicio i
	ALTER table entidadesax_sql alter COLUMN cuenta i
	ALTER table entidadesax_sql alter COLUMN ruta1 i
	ALTER table entidadesax_sql alter COLUMN folio1 i
	ALTER table entidadesax_sql alter COLUMN ruta2 i
	ALTER table entidadesax_sql alter COLUMN folio2 i
	USE IN entidades0_sql 
		
		
	a_entidad = v_entidad
	a_servicio= v_servicio
	a_cuenta  = v_cuenta
	a_fecha	  = v_fecha
	a_numComp = ""
	a_monto	  = 0.00
	a_cuota   = 0
	a_vtocta  = ''
	a_fechavenc1=''
	a_fechavenc2=''
	a_fechavenc3=''
			
			
			
	*** GUARDA DATOS DE CABECERA DEL COMPROBANTE

	v_idfactura  = maxnumeroidx("idfactura","I","facturas",1)
	IF v_idfactura <= 0
		MESSAGEBOX("No se pudo recuperar el ultimo indice de la factura",0+16,"Error")
		RETURN 
	ENDIF 

	SELECT compIngEgr_sql
	GO TOP 
			
			
	v_idcom  = v_idcomproba
	v_pventa = v_pventa
	v_numero = maxnumerocom(v_idcom,v_pventa  ,1)
	v_tipo	 = compIngEgr_sql.tipo
	v_electroag = compIngEgr_sql.electronica
	
	DO CASE 
	
									
		CASE ( a_servicio = 0  OR a_cuenta = 0 ) AND a_entidad <> 0
						
			SELECT entidadesax_sql
			GO TOP 
					
			***Factura a ENTIDAD
			***Toma los datos de la tabla Entidad
			SELECT entidadesax_sql
				
			v_apellido 	= ALLTRIM(entidadesax_sql.companiah)+' '+IIF(EMPTY(ALLTRIM(entidadesax_sql.companiah)),ALLTRIM(entidadesax_sql.apellidoh),'')
			v_nombre 	=  IIF(EMPTY(ALLTRIM(entidadesax_sql.companiah)),ALLTRIM(entidadesax_sql.nombreh),'')  &&cuentaSel.nombre
			v_direccion = entidadesax_sql.direccion
			v_localidad = entidadesax_sql.localidad
			v_iva 		= entidadesax_sql.iva
			v_cuit 		= entidadesax_sql.cuit
			v_docTipo 	= '80'
			v_dni 		= entidadesax_sql.dni
			*v_cuit 			= IIF(thisform.tb_cuit.Tag= "1",thisform.tb_cuit.Value,&ventidad..cuit)
*!*			v_docTIpo = entidad.tipodoc
			*v_docTipoS 		= &ventidad..codafip 
			*v_dni 			= IIF(thisform.tb_dni.Tag= "1",thisform.tb_dni.Value,&ventidad..dni)
			
			DO CASE
			CASE EMPTY(ALLTRIM(v_cuit)) = .F.
				v_docTIpo = "80"
			CASE v_dni > 0 AND EMPTY(ALLTRIM(v_cuit)) = .T.
				v_docTIpo = "96"
			OTHERWISE
				v_docTIpo = "99"
			ENDCASE
			v_telefono 	= entidadesax_sql.telefono
			v_cp 		= entidadesax_sql.cp
			v_fax 		= entidadesax_sql.fax
			v_email 	= entidadesax_sql.email
			v_zona 		= ""
			v_ruta1 	= 0
			v_folio1 	= 0
			v_ruta2 	= 0
			v_folio2 	= 0
					
		CASE a_entidad <> 0 AND a_servicio <> 0  AND a_cuenta <> 0 
			***Factura a una SUBCUENTA de la ENTIDAD
			***Toma los datos de la tabla CuentaSel
			SELECT entidadesax_sql
			GO TOP 
					
			v_apellido 	= ALLTRIM(entidadesax_sql.companiah)+' '+IIF(EMPTY(ALLTRIM(entidadesax_sql.companiah)),ALLTRIM(entidadesax_sql.apellidoh),'')
			v_nombre 	=  IIF(EMPTY(ALLTRIM(entidadesax_sql.companiah)),ALLTRIM(entidadesax_sql.nombreh),'')  &&cuentaSel.nombre
			v_direccion = entidadesax_sql.direccionh
			v_localidad = entidadesax_sql.localidadh
			v_iva 		= entidadesax_sql.ivah
		*	v_cuit 			= IIF(thisform.tb_cuit.Tag= "1",thisform.tb_cuit.Value,&vcuentaSel..cuit)
*!*			v_docTIpo = cuentaSel.tipodoc
		*	v_docTipoS 		= &vcuentaSel..codafip 
		*	v_dni 			= IIF(thisform.tb_dni.Tag= "1",thisform.tb_dni.Value,&vcuentaSel..dni)
		
			DO CASE
			CASE EMPTY(ALLTRIM(v_cuit)) = .F.
				v_docTIpo = "80"
			CASE v_dni > 0 AND EMPTY(ALLTRIM(v_cuit)) = .T.
				v_docTIpo = "96"
			OTHERWISE
				v_docTIpo = "99"
			ENDCASE
			
			v_telefono 	= entidadesax_sql.telefonoh
			v_cp 		= entidadesax_sql.cph
			v_fax 		= entidadesax_sql.faxh
			v_email 	= entidadesax_sql.emailh
			v_zona 		= ""
			v_ruta1 	= entidadesax_sql.ruta1
			v_folio1 	= entidadesax_sql.folio1
			v_ruta2 	= entidadesax_sql.ruta2
			v_folio2 	= entidadesax_sql.folio2
		
		ENDCASE 
						
			v_dirEntrega = ""
			v_transporte = 0
			v_nombreTransporte = ""

			v_stock = ""

			v_tipoOp= 0

			v_neto = 0.00
			v_descuento = 0.00
			v_recargo = 0
			v_operaExenta = ""
			v_anulado = "N"
			v_fechavenc1 = ""
			v_fechavenc2 = ""
			v_fechavenc3 = ""
			v_fechaDescuento = ""
			v_proxvenc = ""
			v_confirmada = ""
			v_astoConta = 0
			v_deuda_cta = 0
			v_cespcae = ""
			v_caecespVen = ""

			v_vendedor = 0
			v_idperiodo = 0			
			v_impuestos = 0
						
			v_total = 0.00
		
			
			v_observa1 = ""
			v_observa2 = ""
			v_observa3 = ""
			v_observa4 = ""

			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
	
			* datos para vinculos de comprobantes
			v_idcompro_va   = v_idcom
			v_idregistro_va = v_idfactura
	
			DIMENSION lamatriz1(53,2)
			
			lamatriz1(1,1)='idfactura'
			lamatriz1(1,2)= ALLTRIM(STR(v_idfactura))
			lamatriz1(2,1)='idcomproba'
			lamatriz1(2,2)=ALLTRIM(STR(v_idcom))
			lamatriz1(3,1)='pventa'
			lamatriz1(3,2)= ALLTRIM(STR(v_pventa))
			lamatriz1(4,1)='numero'
			lamatriz1(4,2)=ALLTRIM(STR(v_numero))
			lamatriz1(5,1)='tipo'
			lamatriz1(5,2)="'"+ALLTRIM(v_tipo)+"'"
			lamatriz1(6,1)='fecha'
			lamatriz1(6,2)="'"+alltrim(a_fecha)+"'"
			lamatriz1(7,1)='entidad'
			lamatriz1(7,2)=ALLTRIM(STR(a_entidad))
			lamatriz1(8,1)='servicio'
			lamatriz1(8,2)= ALLTRIM(STR(a_servicio))
			lamatriz1(9,1)='cuenta'
			lamatriz1(9,2)= ALLTRIM(STR(a_cuenta))
			lamatriz1(10,1)='apellido'
			lamatriz1(10,2)= "'"+ALLTRIM(v_apellido)+"'"
			lamatriz1(11,1)='nombre'
			lamatriz1(11,2)= "'"+ALLTRIM(v_nombre)+"'"
			lamatriz1(12,1)='direccion'
			lamatriz1(12,2)= "'"+ALLTRIM(v_direccion)+"'"
			lamatriz1(13,1)='localidad'
			lamatriz1(13,2)= "'"+ALLTRIM(v_localidad)+"'"
			lamatriz1(14,1)='iva'
			lamatriz1(14,2)= ALLTRIM(STR(v_iva))
			lamatriz1(15,1)='cuit'
			lamatriz1(15,2)= "'"+ALLTRIM(v_cuit)+"'"
			lamatriz1(16,1)='tipodoc'
			lamatriz1(16,2)= "'"+ALLTRIM(v_docTIpo)+"'"
			lamatriz1(17,1)='dni'
			lamatriz1(17,2)= ALLTRIM(STR(v_dni))
			lamatriz1(18,1)='telefono'
			lamatriz1(18,2)= "'"+ALLTRIM(v_telefono)+"'"
			lamatriz1(19,1)='cp'
			lamatriz1(19,2)= "'"+ALLTRIM(v_cp)+"'"
			lamatriz1(20,1)='fax'
			lamatriz1(20,2)= "'"+ALLTRIM(v_fax)+"'"
			lamatriz1(21,1)='email' 
			lamatriz1(21,2)= "'"+ALLTRIM(v_email)+"'"
			lamatriz1(22,1)='transporte'
			lamatriz1(22,2)= ALLTRIM(STR(v_transporte))
			lamatriz1(23,1)='nomtransp'
			lamatriz1(23,2)= "'"+ALLTRIM(v_nombreTransporte)+"'"
			lamatriz1(24,1)='direntrega'
			lamatriz1(24,2)= "'"+ALLTRIM(v_dirEntrega)+"'"
			lamatriz1(25,1)='stock'
			lamatriz1(25,2)= "'"+ALLTRIM(v_stock)+"'"
			lamatriz1(26,1)='idtipoopera'
			lamatriz1(26,2)= ALLTRIM(STR(v_tipoOp))
			lamatriz1(27,1)='neto'
			lamatriz1(27,2)= ALLTRIM(STR(v_neto,13,2))
			lamatriz1(28,1)='subtotal'
			lamatriz1(28,2)= ALLTRIM(STR(v_neto,13,2))
			lamatriz1(29,1)='descuento'
			lamatriz1(29,2)= ALLTRIM(STR(v_descuento,13,2))
			lamatriz1(30,1)='recargo'
			lamatriz1(30,2)= ALLTRIM(STR(v_recargo,13,2))
			lamatriz1(31,1)='total'
			lamatriz1(31,2)= ALLTRIM(STR(v_total,13,2))
			lamatriz1(32,1)='totalimpu'
			lamatriz1(32,2)= ALLTRIM(STR(v_impuestos,13,2))
			lamatriz1(33,1)='operexenta'
			lamatriz1(33,2)= "'"+ALLTRIM(v_operaExenta)+"'"
			lamatriz1(34,1)='anulado'
			lamatriz1(34,2)= "'"+ALLTRIM(v_anulado)+"'"
			lamatriz1(35,1)='observa1'
			lamatriz1(35,2)= "'"+ALLTRIM(v_observa1)+"'"
			lamatriz1(36,1)='observa2'
			lamatriz1(36,2)= "'"+ALLTRIM(v_observa2)+"'"
			lamatriz1(37,1)='observa3'
			lamatriz1(37,2)= "'"+ALLTRIM(v_observa3)+"'"
			lamatriz1(38,1)='observa4'
			lamatriz1(38,2)= "'"+ALLTRIM(v_observa4)+"'"
			lamatriz1(39,1)='idperiodo'
			lamatriz1(39,2)= ALLTRIM(STR(v_idperiodo))
			lamatriz1(40,1)='ruta1'
			lamatriz1(40,2)= ALLTRIM(STR(v_ruta1))
			lamatriz1(41,1)='folio1'
			lamatriz1(41,2)= ALLTRIM(STR(v_folio1))
			lamatriz1(42,1)='ruta2'
			lamatriz1(42,2)= ALLTRIM(STR(v_ruta2))
			lamatriz1(43,1)='folio2'
			lamatriz1(43,2)= ALLTRIM(STR(v_folio2))
			lamatriz1(44,1)='fechavenc1'
			lamatriz1(44,2)= "'"+ALLTRIM(a_fechavenc1)+"'"
			lamatriz1(45,1)='fechavenc2'
			lamatriz1(45,2)= "'"+ALLTRIM(a_fechavenc2)+"'"
			lamatriz1(46,1)='fechavenc3'
			lamatriz1(46,2)= "'"+ALLTRIM(a_fechavenc3)+"'"
			lamatriz1(47,1)='proxvenc'
			lamatriz1(47,2)= "'"+ALLTRIM(v_proxvenc)+"'"
			lamatriz1(48,1)='confirmada'
			lamatriz1(48,2)= "'"+ALLTRIM(v_confirmada)+"'"
			lamatriz1(49,1)='astoconta'
			lamatriz1(49,2)= ALLTRIM(STR(v_astoConta))
			lamatriz1(50,1)='deudacta'
			lamatriz1(50,2)= ALLTRIM(STR(v_deuda_cta,13,4))
			lamatriz1(51,1)='cespcae'
			lamatriz1(51,2)= "'"+ALLTRIM(v_cespcae)+"'"
			lamatriz1(52,1)='caecespven'
			lamatriz1(52,2)= "'"+ALLTRIM(v_caecespVen)+"'"
			lamatriz1(53,1)='vendedor'
			lamatriz1(53,2)= ALLTRIM(STR(v_vendedor))
	

			p_tabla     = 'facturas'
			p_matriz    = 'lamatriz1'
			p_conexion  = vconeccionL
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			    RETURN 
			ENDIF  


			*** Agrego el detalle de la factura recien cargada
			SELECT &p_tablaarti
			GO TOP 
			v_idfacturaag 	= v_idfactura
			v_ivaag	  		= v_iva
			v_idcomag		= v_idcom
			DO WHILE !EOF() 
			
				v_articuloag = &p_tablaarti..articulo
				v_cantidadag = &p_tablaarti..cantidad
				v_unitarioag = &p_tablaarti..unitario
				
				
				v_ret = agregarItemEspecial(v_articuloag,v_cantidadag,v_unitarioag,v_idfacturaag,v_ivaag)	&& Agrego los componentes o articulos pasados como parametros en la tablaarti
					
				 
				SELECT &p_tablaarti
				SKIP 
						
			ENDDO 


			*** Busco el comprobante ***
			sqlmatriz(1)="SELECT total from facturas where idfactura = "+ALLTRIM(STR(v_idfacturaag))
			verror=sqlrun(vconeccionL ,"totalf_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA la Factura  ",0+48+0,"Error")
			*** me desconecto	
				=abreycierracon(vconeccionL ,"")
			    RETURN 0
			ENDIF 

			** SI RECIBIO PARAMETRO PARA VINCULAR BUSCO LOS DATOS PARA HACER EL VINCULO
			IF p_idvincular > 0 THEN 
				sqlmatriz(1)="SELECT idcomproba, idfactura from facturas where idfactura = "+ALLTRIM(STR(p_idvincular))
				verror=sqlrun(vconeccionL ,"fcvincular_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA la Factura  ",0+48+0,"Error")
				*** me desconecto	
					=abreycierracon(vconeccionL ,"")
				    RETURN 0
				ENDIF 			
				v_idcompro_vb = fcvincular_sql.idcomproba
			ENDIF 


			=abreycierracon(vconeccionL,"")
			v_totalfactu = totalf_sql.total
			USE IN totalf_sql

			*** REGISTRO ESTADO PENDIENTE DE AUTORIZAR PARA FACTURAS ELECTRONICAS o ESTADO AUTORIZADO SI NO SON ELECTRONICAS ***

			IF v_electroag = 'S' THEN 
				registrarEstado("facturas","idfactura",v_idfacturaag,'I',"PENDIENTE AUTORIZACION")
			ELSE
				registrarEstado("facturas","idfactura",v_idfacturaag,'I',"AUTORIZADO")
			ENDIF 

			*** ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO  ***
			guardaCajaRecaH (v_idcomag, v_idfacturaag)


			** REGISTRO EL VINCULO SI RECIBIO COMPROBANTE PARA VINCULAR ( para el caso de NC o ND)
			IF v_idcompro_va > 0 AND v_idregistro_va > 0  AND  v_idcompro_vb > 0 AND v_idregistro_vb  > 0 THEN 
				=ABLinkCompro(v_idcompro_va ,v_idregistro_va ,v_idcompro_vb ,v_idregistro_vb,'+')
			ENDIF 



		*** AUTORIZO COMPROBANTE ***
			IF v_electroag = 'S' THEN					
				vauto = autorizarCompFE(v_idfacturaag,v_idcomag)
			ENDIF 
			*** CONTABILIZO  EL COMPROBANTE ***
			v_cargo = ContabilizaCompro('facturas', v_idfacturaag, 0, v_totalfactu)

			*** IMPRIMIR ***
						
			sino = MESSAGEBOX("¿Desea imprimir el comprobante?",4+32,"Imprimir comprobante")
			IF sino = 6
				*SI
				v_eselectro = IIF(v_electroag ='S',.t.,.f.)
				imprimirFactura (v_idfacturaag,v_eselectro )
			ENDIF 
			
 	sele compIngEgr_sql
 	USE IN compIngEgr_sql
 	sele &p_tablaarti
 	USE IN &p_tablaarti
	SELECT entidadesax_sql	
	USE IN entidadesax_sql
	
 	v_retornoidfactura  = v_idfacturaag
	RETURN v_retornoidfactura 
ENDFUNC 






FUNCTION GenNDRecargo
PARAMETERS P_EntidadRec, p_ImporteRec, p_ImporteFin,  P_idcomprobaRec, p_pventaRec, P_IdReciboRec, p_coneg
*#/ ------------------------------
* Crea una Nota de Débito por Recargos, recibe como parametros el monto total del recargo y genera una Nota de Debito y lo cancela con el recibo pasado como parámetro si lo hubiere
* PARAMETROS : 
* 	P_EntidadRec: Entidad a la que se le cargará el comprobante de recargo
*   p_ImporteRec:  Importe Total Bruto del Recargo para generar el comprobante
*   p_ImporteFin:  Importe Total Bruto del Interes por Financiacion para generar el comprobante
*   P_idcomprobaRec: Idcomproba del comprobante ND que se utiliza para generar los recargos
*   p_pventaRec:      id del Punto de Venta que se utiliza para generar los recargos
*   P_IdReciboRec:   ID Recibo con el cual se cancela el comprobante de Recargos generados,
*					 si lo recibe y es mayor que 0 intenta generar el vinculo para cancelar el comprobante 
*					 si es = 0 entonces no cancela el comprobante y queda en cuenta corriente
*   p_cone :  conexion a la base de datos, si es 0 abre una nueva conexion
*
*   OBS: si no recibe p_idcomproba o p_pventaREc entonces verifica la existencia de la variable _SYSNDRECARGOS
*		 esta variable contiene el idcomproba y pventa (comprobante y punto de venta utilizado para hacer ND por intereses)
*	_SYSNDINTERES = 'PP;I,ID;I,ID;I,ID' ej '0101' si tiene '0000' o 'N' es porque no hace ND de intereses
* RETORNO: 
* 	retorna el idfactura del comprobante generado
*   Si hay error retorna 0
*#/--------------------------------
	
	IF TYPE('_SYSNDRECARGOS')='C' THEN 
		IF SUBSTR((_SYSNDRECARGOS+' '),1,1) = 'N' OR SUBSTR((_SYSNDRECARGOS+'    '),1,4) = '0000' THEN 
			RETURN 0
		ENDIF 
		
	ELSE
		RETURN 0
	ENDIF 
	
	 	
	IF ( p_ImporteRec + p_ImporteFin ) <= 0 OR P_EntidadRec <= 0 THEN 
		RETURN 0
	ENDIF 
*!*		oeObjR	= CREATEOBJECT('oeclass')	
*!*		v_codTabR	    =  oeObjR.getCodigoOp('ND INTERESES') && Obtengo: CODIGO_TABLA. El caracter '_' es el de separación
	
	v_retornoRec = 0
	IF p_coneg > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionR = p_coneg
	ELSE 
		vconeccionR = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	


	V_PidcomprobaRec = P_idcomprobaRec
	v_pventaRec 	 = p_pventaRec
	
	v_IDfacturaVin = 0
	

* Obtengo el Impuesto del Artículo para descontarlo del importe ya que tengo que pasar el valor neto

			*** Busco la Entidad ***
	sqlmatriz(1)="SELECT * from entidades where entidad = "+ALLTRIM(STR(P_EntidadRec))

	verror=sqlrun(vconeccionR ,"entidadRec_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA la Entidades  ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionR ,"")
	    RETURN 0
	ENDIF 
	SELECT entidadRec_sql 
	v_ivarec = entidadRec_sql.iva 
	USE IN  entidadRec_sql

* Obtengo el idcomproba y otros datos del recibo que voy a vincular, si lo hubiere
	*** Busco el Recibo ***
	V_idcomproRERec = 0
	V_SaldoREcibo   = 0.00
	IF 	P_IdReciboRec > 0 THEN 

		sqlmatriz(1)="SELECT r.*, s.saldo from recibos r left join r_recibossaldo s on s.idrecibo = r.idrecibo where r.idrecibo = "+ALLTRIM(STR(P_IdReciboRec))
		verror=sqlrun(vconeccionR ,"reciborec_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Recibo que cancela el Recargo  ",0+48+0,"Error")
		*** me desconecto	
			=abreycierracon(vconeccionR ,"")
		    RETURN 0
		ENDIF 
		SELECT reciborec_sql
		V_SaldoREcibo 	= reciborec_sql.saldo
		V_idcomproRERec = reciborec_sql.idcomproba
		USE IN reciborec_sql
	
	**********************************************	
		*Obtengo la factura asociada a la ND desde el recibo pasado como parametro
		* Es obligatorio enviar una factura asociada a la ND por Recargos

		sqlmatriz(1)=" SELECT idfactura, recargo FROM cobros  "
		sqlmatriz(5)=" WHERE  idregipago = "+ALLTRIM(STR(P_IdReciboRec))+" and  idcomproba = "+ALLTRIM(STR(V_idcomproRERec))+" "
		verror=sqlrun(vconeccionR ,"FacturasRec_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las Facturas asociadas a la ND  ",0+48+0,"Error")
		*** me desconecto	
			=abreycierracon(vconeccionR ,"")
		    RETURN 0
		ENDIF 
	
		SELECT FacturasRec_sql


		GO TOP 
		IF EOF() THEN 
			MESSAGEBOX("Error al obtener las Facturas Asociadas al Comprobante de Recargo",0+48+0,"Error")
			=abreycierracon(vconeccionR,"")
			RETURN 0
		ENDIF 
		SELECT FacturasRec_sql
		GO TOP 
		v_IDfacturaVin =  FacturasRec_sql.idfactura 

		USE IN FacturasRec_sql

	ENDIF 


**********************************************
*************************************************	
	IF V_PidcomprobaRec = 0 OR p_pventaRec = 0 THEN 
		v_canlineas = ALINES(arrcompro,_SYSNDRECARGOS,1,';')
		v_pventaRec 	 = INT(VAL(SUBSTR(_SYSNDRECARGOS,1,2)))	
		I=2 
		FOR i = 2 TO v_canlineas 
			IF INT(VAL(SUBSTR(arrcompro(i),1,1))) = v_ivarec THEN
				v_PidcomprobaRec = INT(VAL(SUBSTR(arrcompro(i),3)))
			ENDIF 
		ENDFOR 
		RELEASE arrcompro
	ENDIF 


	IF V_PidcomprobaRec = 0 OR v_pventaRec = 0 THEN 
		=abreycierracon(vconeccionR ,"")
		RETURN 0
	ENDIF 
	
	
	CREATE TABLE tmpndinteres (entidad i , servicio i, cuenta i, articulo c(20), cantidad y, unitario y, fecha c(8), idcomproba i, pventa i)

	IF p_ImporteRec > 0 THEN 
		* Obtengo el Codigo del Articulo asociado por TOE a los intereses Punitorios  para notas de debito 
		
		oeObjR	= CREATEOBJECT('oeclass')	
		v_codTabR	    =  oeObjR.getCodigoOp('ND RECARGOS') && Obtengo: CODIGO_TABLA. El caracter '_' es el de separación
		v_nPosR 		= AT('_',v_codTabR) &&Retorna la posición donde aparece el caracter de separacion utilizado (_)
		v_codigoREC	    = SUBSTR(v_codTabR,1,v_nPosR-1) && Retorna el código
		v_tablaR		= SUBSTR(v_codTabR,v_nPosR+1)	&& Retorna el resto de la cadena, que corresponde a la tabla
		RELEASE oeObjR


		sqlmatriz(1)=" SELECT a.*,ai.impuesto,ai.idartimp,i.razon as razon,i.detalle as detaimp, af.unidadf,af.base FROM articulos a "
		sqlmatriz(2)=" LEFT JOIN articulosimp ai on a.articulo = ai.articulo "
		sqlmatriz(3)=" LEFT JOIN impuestos i ON ai.impuesto = i.impuesto "
		sqlmatriz(4)=" LEFT JOIN articulosf af on a.articulo = af.articulo"
		sqlmatriz(5)=" WHERE  ai.iva = "+ALLTRIM(STR(v_ivarec))+" and  a.articulo = '"+ALLTRIM(v_codigoRec)+"'"
		verror=sqlrun(vconeccionR ,"articuloRec_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Artículo para la ND  ",0+48+0,"Error")
		*** me desconecto	
			=abreycierracon(vconeccionR ,"")
		    RETURN 0
		ENDIF 
		SELECT articuloRec_sql
		GO TOP 
		IF EOF() THEN 
			MESSAGEBOX("Error al obtener el Impuesto para el Artículo para la ND",0+48+0,"Error")
			=abreycierracon(vconeccionR,"")
			RETURN 0
		ENDIF 

		v_razonimpRec = articuloRec_sql.razon
		v_imponetouni =  p_ImporteRec /  (1+(v_razonimpRec/100))
		USE IN articuloRec_sql 


*!*			CREATE TABLE tmpndinteres (entidad i , servicio i, cuenta i, articulo c(20), cantidad y, unitario y, fecha c(8), idcomproba i, pventa i)
		SELECT tmpndinteres
		INSERT  INTO tmpndinteres VALUES (P_EntidadREc,0,0,'ND RECARGOS',1,v_imponetouni,DTOS(DATE()),V_PidcomprobaRec, V_pventaREc)
	ENDIF 

	IF p_ImporteFin > 0 THEN 
		* Obtengo el Codigo del Articulo asociado por TOE a los intereses de Financiacion  para notas de debito 
		
		oeObjR	= CREATEOBJECT('oeclass')	
		v_codTabR	    =  oeObjR.getCodigoOp('COSTO FINANCIACION') && Obtengo: CODIGO_TABLA. El caracter '_' es el de separación
		v_nPosR 		= AT('_',v_codTabR) &&Retorna la posición donde aparece el caracter de separacion utilizado (_)
		v_codigoREC	    = SUBSTR(v_codTabR,1,v_nPosR-1) && Retorna el código
		v_tablaR		= SUBSTR(v_codTabR,v_nPosR+1)	&& Retorna el resto de la cadena, que corresponde a la tabla
		RELEASE oeObjR


		sqlmatriz(1)=" SELECT a.*,ai.impuesto,ai.idartimp,i.razon as razon,i.detalle as detaimp, af.unidadf,af.base FROM articulos a "
		sqlmatriz(2)=" LEFT JOIN articulosimp ai on a.articulo = ai.articulo "
		sqlmatriz(3)=" LEFT JOIN impuestos i ON ai.impuesto = i.impuesto "
		sqlmatriz(4)=" LEFT JOIN articulosf af on a.articulo = af.articulo"
		sqlmatriz(5)=" WHERE  ai.iva = "+ALLTRIM(STR(v_ivarec))+" and  a.articulo = '"+ALLTRIM(v_codigoRec)+"'"
		verror=sqlrun(vconeccionR ,"articuloRec_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del Artículo para la ND  ",0+48+0,"Error")
		*** me desconecto	
			=abreycierracon(vconeccionR ,"")
		    RETURN 0
		ENDIF 
		SELECT articuloRec_sql
		GO TOP 
		IF EOF() THEN 
			MESSAGEBOX("Error al obtener el Impuesto para el Artículo para la ND",0+48+0,"Error")
			=abreycierracon(vconeccionR,"")
			RETURN 0
		ENDIF 

		v_razonimpRec = articuloRec_sql.razon
		v_imponetouni =  p_ImporteFin /  (1+(v_razonimpRec/100))
		USE IN articuloRec_sql 


		SELECT tmpndinteres
		INSERT  INTO tmpndinteres VALUES (P_EntidadREc,0,0,'COSTO FINANCIACION',1,v_imponetouni,DTOS(DATE()),V_PidcomprobaRec, V_pventaREc)
	ENDIF 


	USE IN tmpndinteres 
	
	v_idndRec = GenerarFDC("tmpndinteres",0,v_IDfacturaVin )

	
	IF v_idndRec > 0 AND P_IdReciboRec > 0 AND V_idcomproRERec > 0 AND V_SaldoREcibo > 0 THEN 
		v_importecancela = ( p_ImporteRec + p_ImporteFin )
		IF ( p_ImporteRec + p_ImporteFin ) > V_SaldoREcibo   THEN 
			v_ImporteCancela  =	V_SaldoREcibo
		ENDIF 
		CREATE TABLE tmpaplicarnd ( idcomproba i, idfactura i, idregipago i, idcuotafc i, imputado y )
		INSERT INTO  tmpaplicarnd VALUES (V_idcomproRERec ,v_idndRec ,P_IdReciboRec,0,v_ImporteCancela)
		USE IN tmpaplicarnd 
		=GAplicaCobro("tmpaplicarnd",0)

	ENDIF 

ENDFUNC 


FUNCTION GenerarRemito
PARAMETERS p_tablaarti, p_cone
*#/ ------------------------------
* Crea un Comprobante de facturacion a partir de los articulos recibidos en la tabla pasada como parámetros
* PARAMETROS : 
*	p_tablaarti: tabla conteniendo los datos para generar el comprobante (entidad i , servicio i, cuenta i, fecha c(8), idcomproba i, ;
* 																		 pventa i,transporte I,nomTrans C(254), dirEntrega C(254), stock C(1), tipoOp I, observa1 C(254),observa2 C(254),observa3 C(254), observa4 C(254), ;
*																		articulo c(15),idconcepto I, idservicio I, detalle C(254), unidad C(10),cantidadfc N(13,4),unidadfc  C(10), cantidad N(13,4), unitario N(13,4), impuestos N(13,4),impuesto I, razonimp N(13,4), numero I )


*   p_cone :  conexion a la base de datos, si es 0 abre una nueva conexion
* RETORNO: 
* 	retorna el Id del remito si no se produjeron errores
*   Si hay error retorna 0
*#/--------------------------------
	IF !(TYPE('p_idvincular')='N') THEN 
		p_idvincular = 0 
	ENDIF 
	* Variables para Vinculos si se recibe parametro de vinculación
	v_idcompro_va	= 0
	v_idregistro_va	= 0
	v_idcompro_vb	= 0
	v_idregistro_vb	= p_idvincular

	v_retornoidfactura = 0

	IF TYPE('p_cone') = 'L'
	p_cone = 0
	
	ENDIF 
	IF p_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionL = p_cone
	ELSE 
		vconeccionL = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	

*	USE &p_tablaarti IN 0

	SELECT SUM(cantidad*unitario) as neto  FROM &p_tablaarti INTO CURSOR totales
	
	
	
	
	SELECT &p_tablaarti
	GO TOP 
	IF NOT EOF()
		v_entidad  		= &p_tablaarti..entidad
		v_servicio 		= &p_tablaarti..servicio
		v_cuenta   		= &p_tablaarti..cuenta
		v_idcomproba 	= &p_tablaarti..idcomproba
		v_pventa		= &p_tablaarti..pventa
		v_fecha 		= &p_tablaarti..fecha
		v_transporte	= &p_tablaarti..transporte
		v_nombreTransporte = &p_tablaarti..nomTrans
*		v_dirEntrega	= &p_tablaarti..direntre
		v_stock			= &p_tablaarti..stock
		v_dirEntrega 	= &p_tablaarti..direntrega
		v_transporte	= &p_tablaarti..transporte
		v_nomTransporte	= &p_tablaarti..nomtrans
		v_tipoOp		= &p_tablaarti..tipoop
		v_numeroRem		= &p_tablaarti..numero
	
	
	
*!*		** valido que el comprobante no exista

*!*			*** Busco el Remito ***
*!*			sqlmatriz(1)=" SELECT *   "
*!*			sqlmatriz(2)=" FROM remitos r left join ultimoestado u on r.idremito = u.id "
*!*			sqlmatriz(3)=" where u.tabla = 'remitos' and u.campo = 'idremito' and r.numero = "+ALLTRIM(STR(v_numeroRem))
*!*			sqlmatriz(4)=" and r.idcomproba = "+ALLTRIM(STR(v_idcomproba))+" and r.pventa = "+ALLTRIM(STR(v_pventa))
*!*			verror=sqlrun(vconeccionL ,"RemitoVal_sql")

*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los comprobantes  ",0+48+0,"Error")
*!*			*** me desconecto	
*!*				=abreycierracon(vconeccionL ,"")
*!*			    RETURN 0
*!*			ENDIF 

*!*			SELECT RemitoVal_sql
*!*			GO TOP 
*!*			IF NOT EOF()
*!*				&& Ya existe el comprobante -> No lo cargo
*!*				RETURN 0
*!*			ENDIF 
		
	
	
	
		SELECT totales
		v_neto 			= totales.neto
		v_subtotal 		= totales.neto
		v_descuento 	= 0
		v_recargo 		= 0
		v_operaExenta 	= ""
		v_anulado 		= "N"
		v_vendedor 		= 0
		v_cespcae 		= ""
		v_caecespVen 	= ""
*!*			v_fechavenc1 	= ""
*!*			v_fechavenc2 	= ""
*!*			v_fechavenc3 	= ""
*!*			v_fechaDescuento = ""
*!*			v_proxvenc = ""
*!*			v_confirmada = ""
			v_astoConta = 0
*!*			v_deuda_cta = 0
				

	ELSE
		RETURN 0
	ENDIF 

	*** Busco el comprobante ***
	sqlmatriz(1)="SELECT c.*,t.opera,v.pventa,v.puntov, pv.electronica from comprobantes c left join compactiv v on c.idcomproba = v.idcomproba left join tipocompro t on c.idtipocompro = t.idtipocompro "
	sqlmatriz(2)=" left join puntosventa pv on pv.puntov = v.puntov "
	sqlmatriz(3)=" WHERE c.idcomproba = "+ALLTRIM(STR(v_idcomproba ))+" and v.pventa = "+ALLTRIM(STR(v_pventa))

	verror=sqlrun(vconeccionL ,"compRem_sql")

	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los comprobantes  ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionL ,"")
	    RETURN 0
	ENDIF 


	SELECT compRem_sql
	GO TOP 
	IF EOF()
		MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los comprobantes  ",0+48+0,"Error")
		*** me desconecto	
		=abreycierracon(vconeccionL,"")
	    RETURN 0
	ENDIF 

	*** Busco la entidad ***

	sqlmatriz(1)= " SELECT e.*, IFNULL(h.servicio,0) as servicio, IFNULL(h.cuenta,0) as cuenta, "
	sqlmatriz(2)= " IFNULL(h.ruta1,0) as ruta1, IFNULL(h.folio1,0) as folio1, IFNULL(h.ruta2,0) as ruta2, IFNULL(h.folio2,0) as folio2, "
	sqlmatriz(3)= " IFNULL(h.compania,e.compania) as companiah, IFNULL(h.nombre,e.nombre) as nombreh, IFNULL(h.apellido,e.apellido) as apellidoh, "
	sqlmatriz(4)= " IFNULL(h.direccion,e.direccion) as direccionh, IFNULL(h.localidad,e.localidad) as localidadh, IFNULL(h.iva,e.iva) as ivah, IFNULL(h.dni,e.dni) as dnih, IFNULL(h.telefono,e.telefono) as telefonoh, "
	sqlmatriz(5)= " IFNULL(h.cuit,e.cuit) as cuith, IFNULL(h.cp,e.cp) as cph, IFNULL(h.fax,e.fax) as faxh, IFNULL(h.email,e.email) as emailh "
	sqlmatriz(6)= " from entidades e left join entidadesh h on e.entidad = h.entidad  where e.entidad = "+STR(v_entidad)

	verror=sqlrun(vconeccionL,"entidades0_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las entidades ",0+48+0,"Error")
	*** me desconecto	
		=abreycierracon(vconeccionL,"")
	    RETURN 0
	ENDIF 


	******************************************************************************************************
	SELECT * FROM entidades0_sql INTO TABLE ent_sql
	
	ALTER table ent_sql alter COLUMN servicio i
	ALTER table ent_sql alter COLUMN cuenta i
	ALTER table ent_sql alter COLUMN ruta1 i
	ALTER table ent_sql alter COLUMN folio1 i
	ALTER table ent_sql alter COLUMN ruta2 i
	ALTER table ent_sql alter COLUMN folio2 i
	USE IN entidades0_sql 
		
		
	a_entidad = v_entidad
	a_servicio= v_servicio
	a_cuenta  = v_cuenta
	a_fecha	  = v_fecha
	a_numComp = ""
	a_monto	  = 0.00
	a_cuota   = 0
	a_vtocta  = ''
	a_fechavenc1=''
	a_fechavenc2=''
	a_fechavenc3=''
			
			
	*** GUARDA DATOS DE CABECERA DEL COMPROBANTE

	v_idremito  = maxnumeroidx("idremito","I","remitos",1)
	IF v_idremito  <= 0
		MESSAGEBOX("No se pudo recuperar el ultimo indice del remito",0+16,"Error")
		RETURN 0
	ENDIF  

	SELECT compRem_sql
	GO TOP 
			
			
	v_idcom  = v_idcomproba
	v_pventa = v_pventa
	v_numRem = &p_tablaarti..numero
	
	IF v_numRem > 0
		v_numero = v_numRem 
	ELSE
		v_numero = maxnumerocom(v_idcom,v_pventa  ,1)
	ENDIF 
	
	v_tipo	 = compRem_sql.tipo

	DO CASE 
		
		CASE v_entidad = 0  and v_servicio = 0 AND  v_cuenta = 0
			***Factura a CONSUMIDOR FINAL
			v_apellido = "CONSUMIDOR FINAL"
			v_nombre = ""
			v_direccion = ""
			v_localidad = ""
			** ? **
			v_iva = 0
			v_cuit = ""
			v_docTIpo = "99"
			v_dni = 0
			v_telefono = ""
			v_cp = ""
			v_fax = ""
			v_email = ""
			**** ? ****
			v_zona = ""
			**** ? ****
			v_ruta1 = 0
			**** ? ****
			v_folio1 = 0
			**** ? ****
			v_ruta2 = 0
			**** ? ****
			v_folio2 = 0
			
		CASE v_servicio = 0  OR v_cuenta = 0 AND v_entidad <> 0
			***Factura a ENTIDAD
			***Toma los datos de la tabla Entidad
			SELECT ent_sql
			GO TOP 
			v_apellido = ALLTRIM(ent_sql.compania)+' '+ent_sql.apellido
			v_nombre = IIF(EMPTY(ALLTRIM(ent_sql.compania)),ALLTRIM(ent_sql.nombre),'') &&entidad.nombre
			v_direccion = ent_sql.direccion
			v_localidad = ent_sql.localidad
			v_iva = ent_sql.iva
			v_cuit = ent_sql.cuit
			v_docTIpo = ent_sql.tipodoc
*			v_docTipo = ent_sql.codafip 
			v_dni = ent_sql.dni
			v_telefono = ent_sql.telefono
			v_cp = ent_sql.cp
			v_fax = ent_sql.fax
			v_email = ent_sql.email
			**** ? ****
			v_zona = ""
			**** ? ****
			v_ruta1 = 0
			**** ? ****
			v_folio1 = 0
			**** ? ****
			v_ruta2 = 0
			**** ? ****
			v_folio2 = 0
			
		CASE v_entidad <> 0 AND v_servicio <> 0  AND v_cuenta <> 0 
			***Factura a una SUBCUENTA de la ENTIDAD
			***Toma los datos de la tabla CuentaSel
			
			v_apellido =  ALLTRIM(ent_sql.companiah)+' '+IIF(EMPTY(ALLTRIM(ent_sql.companiah)),ALLTRIM(ent_sql.apellidoh),'') &&cuentaSel.apellido
			v_nombre = IIF(EMPTY(ALLTRIM(ent_sql.companiah)),ALLTRIM(ent_sql.nombreh),'')  &&cuentaSel.nombre
			v_direccion = ent_sql.direccionh
			v_localidad = ent_sql.localidadh
			v_iva = ent_sql.ivah
			v_cuit = ent_sql.cuith
			v_docTIpo = ent_sql.tipodoc
	*		v_docTipo = ent_sql.codafip
			v_dni = ent_sql.dnih
			v_telefono = ent_sql.telefonoh
			v_cp = ent_sql.cph
			v_fax = ent_sql.faxh
			v_email = ent_sql.emailh
			**** ? ****
			v_zona = ""
			**** ? ****
			v_ruta1 = ent_sql.ruta1
			**** ? ****
			v_folio1 = ent_sql.folio1
			**** ? ***
			v_ruta2 = ent_sql.ruta2
			**** ? ****
			v_folio2 = ent_sql.folio2
	ENDCASE 


		
	*** GUARDA DATOS DE CABECERA DEL REMITO
	DIMENSION lamatriz1(43,2)
	
	lamatriz1(1,1)='idremito'
	lamatriz1(1,2)= ALLTRIM(STR(v_idremito))
	lamatriz1(2,1)='idcomproba'
	lamatriz1(2,2)=ALLTRIM(STR(v_idcom))
	lamatriz1(3,1)='pventa'
	lamatriz1(3,2)= ALLTRIM(STR(v_pventa))
	lamatriz1(4,1)='numero'
	lamatriz1(4,2)=ALLTRIM(STR(v_numero))
	lamatriz1(5,1)='tipo'
	lamatriz1(5,2)="'"+ALLTRIM(v_tipo)+"'"
	lamatriz1(6,1)='fecha'
	lamatriz1(6,2)="'"+alltrim(v_fecha)+"'"
	lamatriz1(7,1)='entidad'
	lamatriz1(7,2)=ALLTRIM(STR(v_entidad))
	lamatriz1(8,1)='servicio'
	lamatriz1(8,2)= ALLTRIM(STR(v_servicio))
	lamatriz1(9,1)='cuenta'
	lamatriz1(9,2)= ALLTRIM(STR(v_cuenta))
	lamatriz1(10,1)='apellido'
	lamatriz1(10,2)= "'"+ALLTRIM(v_apellido)+"'"
	lamatriz1(11,1)='nombre'
	lamatriz1(11,2)= "'"+ALLTRIM(v_nombre)+"'"
	lamatriz1(12,1)='direccion'
	lamatriz1(12,2)= "'"+ALLTRIM(v_direccion)+"'"
	lamatriz1(13,1)='localidad'
	lamatriz1(13,2)= "'"+ALLTRIM(v_localidad)+"'"
	lamatriz1(14,1)='iva'
	lamatriz1(14,2)= ALLTRIM(STR(v_iva))
	lamatriz1(15,1)='cuit'
	lamatriz1(15,2)= "'"+ALLTRIM(v_cuit)+"'"
	lamatriz1(16,1)='tipodoc'
	lamatriz1(16,2)= "'"+ALLTRIM(v_docTIpo)+"'"
	lamatriz1(17,1)='dni'
	lamatriz1(17,2)= ALLTRIM(STR(v_dni))
	lamatriz1(18,1)='telefono'
	lamatriz1(18,2)= "'"+ALLTRIM(v_telefono)+"'"
	lamatriz1(19,1)='cp'
	lamatriz1(19,2)= "'"+ALLTRIM(v_cp)+"'"
	lamatriz1(20,1)='fax'
	lamatriz1(20,2)= "'"+ALLTRIM(v_fax)+"'"
	lamatriz1(21,1)='email' 
	lamatriz1(21,2)= "'"+ALLTRIM(v_email)+"'"
	lamatriz1(22,1)='transporte'
	lamatriz1(22,2)= ALLTRIM(STR(v_transporte))
	lamatriz1(23,1)='nomtransp'
	lamatriz1(23,2)= "'"+ALLTRIM(v_nombreTransporte)+"'"
	lamatriz1(24,1)='direntrega'
	lamatriz1(24,2)= "'"+ALLTRIM(v_dirEntrega)+"'"
	lamatriz1(25,1)='stock'
	lamatriz1(25,2)= "'"+ALLTRIM(v_stock)+"'"
	lamatriz1(26,1)='idtipoopera'
	lamatriz1(26,2)= ALLTRIM(STR(v_tipoOp))
	lamatriz1(27,1)='neto'
	lamatriz1(27,2)= ALLTRIM(STR(v_neto,13,4))
	lamatriz1(28,1)='subtotal'
	lamatriz1(28,2)= ALLTRIM(STR(v_subtotal,13,4))
	lamatriz1(29,1)='recargo'
	lamatriz1(29,2)= "0"
	lamatriz1(30,1)='operexenta'
	lamatriz1(30,2)= "'"+ALLTRIM(v_operaExenta)+"'"
	lamatriz1(31,1)='anulado'
	lamatriz1(31,2)= "'"+ALLTRIM(v_anulado)+"'"
	lamatriz1(32,1)='observa1'
	lamatriz1(32,2)= "'"+ALLTRIM(v_observa1)+"'"
	lamatriz1(33,1)='observa2'
	lamatriz1(33,2)= "'"+ALLTRIM(v_observa2)+"'"
	lamatriz1(34,1)='observa3'
	lamatriz1(34,2)= "'"+ALLTRIM(v_observa3)+"'"
	lamatriz1(35,1)='observa4'
	lamatriz1(35,2)= "'"+ALLTRIM(v_observa4)+"'"
	lamatriz1(36,1)='ruta1'
	lamatriz1(36,2)= ALLTRIM(STR(v_ruta1))
	lamatriz1(37,1)='folio1'
	lamatriz1(37,2)= ALLTRIM(STR(v_folio1))
	lamatriz1(38,1)='ruta2'
	lamatriz1(38,2)= ALLTRIM(STR(v_ruta2))
	lamatriz1(39,1)='folio2'
	lamatriz1(39,2)= ALLTRIM(STR(v_folio2))
	lamatriz1(40,1)='astoconta'
	lamatriz1(40,2)= ALLTRIM(STR(v_astoConta))
	lamatriz1(41,1)='cespcae'
	lamatriz1(41,2)= "'"+ALLTRIM(v_cespcae)+"'"
	lamatriz1(42,1)='caecespven'
	lamatriz1(42,2)= "'"+ALLTRIM(v_caecespVen)+"'"
	lamatriz1(43,1)='vendedor'
	lamatriz1(43,2)= ALLTRIM(STR(v_vendedor))


	p_tipoope = 'I'
	p_condicion   = ''
	p_tabla     = 'remitos'
	p_matriz    = 'lamatriz1'
	p_conexion  = vconeccionL
	IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
	    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
	    RETURN 0
	ENDIF  

	
		
	*** GUARDO DETALLE DEL REMITO ***			
SELECT &p_tablaarti
GO TOP 

DO WHILE NOT EOF()
	
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		
		v_idremitoh = maxnumeroidx("idremitoh","I","remitosh",1)

		v_articulo = &p_tablaarti..articulo
		v_idconcepto = &p_tablaarti..idconcepto
		
		IF !EMPTY(v_articulo) AND v_idconcepto > 0
		
			MESSAGEBOX("Un Item tiene asociado un artículo y un concepto a la vez",0+16,"Error al intentar guardar el detalle del comprobante")
			RETURN 0
		ENDIF 

		**** ? ****
		v_servicio 		= &p_tablaarti..servicio
		v_cantidad 		= &p_tablaarti..cantidad
*		MESSAGEBOX(v_Cantidad)
		v_unidad 		= &p_tablaarti..unidad
		v_cantidadFC 	= &p_tablaarti..cantidadFc
		v_unidadFC 		= &p_tablaarti..unidadFc
		v_detalle 		= &p_tablaarti..detalle
		v_unitario 		= &p_tablaarti..unitario
		v_impuestos		= &p_tablaarti..impuestos
		v_totalArt 		= (v_cantidad*v_unitario) + v_impuestos
		v_codigoCta 	= ""
		v_nombreCta 	= ""
		v_padron 		= 0
		v_idimpuesto	= &p_tablaarti..impuesto
		v_razonImpuesto = &p_tablaarti..razonimp

		DIMENSION lamatriz2(18,2)
		
		lamatriz2(1,1)='idremito'
		lamatriz2(1,2)= ALLTRIM(STR(v_idremito))
		lamatriz2(2,1)='idremitoh'
		lamatriz2(2,2)= ALLTRIM(STR(v_idremitoh))
		lamatriz2(3,1)='articulo'
		lamatriz2(3,2)= "'"+ALLTRIM(v_articulo)+"'"
		lamatriz2(4,1)='idconcepto'
		lamatriz2(4,2)= ALLTRIM(STR(v_idconcepto))
		lamatriz2(5,1)='servicio'
		lamatriz2(5,2)= ALLTRIM(STR(v_servicio))
		lamatriz2(6,1)='cantidad'
		lamatriz2(6,2)= ALLTRIM(STR(v_cantidad,13,4))
		lamatriz2(7,1)='unidad'
		lamatriz2(7,2)= "'"+ALLTRIM(v_unidad)+"'"
		lamatriz2(8,1)='cantidadfc'
		lamatriz2(8,2)= ALLTRIM(str(v_cantidadFC,13,4))
		lamatriz2(9,1)='unidadfc'
		lamatriz2(9,2)= "'"+ALLTRIM(v_unidadFC)+"'"
		lamatriz2(10,1)='detalle'
		lamatriz2(10,2)= "'"+ALLTRIM(v_detalle)+"'"
		lamatriz2(11,1)='unitario'
		lamatriz2(11,2)= ALLTRIM(STR(v_unitario,13,4))
		lamatriz2(12,1)='impuestos'
		lamatriz2(12,2)= ALLTRIM(STR(v_impuestos,13,4))
		lamatriz2(13,1)='total'
		lamatriz2(13,2)= ALLTRIM(STR(v_totalArt,13,4))
		lamatriz2(14,1)='codigocta'
		lamatriz2(14,2)= "'"+ALLTRIM(v_codigoCta)+"'"
		lamatriz2(15,1)='nombrecta'
		lamatriz2(15,2)= "'"+ALLTRIM(v_nombreCta)+"'"
		lamatriz2(16,1)='padron' 
		lamatriz2(16,2)= ALLTRIM(STR(v_padron))
		lamatriz2(17,1)='impuesto'
		lamatriz2(17,2)= ALLTRIM(STR(v_idimpuesto))
		lamatriz2(18,1)='razonimp'
		lamatriz2(18,2)= ALLTRIM(STR(v_razonImpuesto,13,4))
	
		p_tabla     = 'remitosh'
		p_matriz    = 'lamatriz2'
		p_conexion  = vconeccionL
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
		ENDIF						
		
		SELECT &p_tablaarti
	SKIP 1
ENDDO	
		
			
			
			
			
						
 	sele compRem_sql
 	USE IN compRem_sql
 	sele &p_tablaarti
 	USE IN &p_tablaarti
	SELECT ent_sql 	
	USE IN ent_sql 
	
 
	RETURN v_idremito
ENDFUNC 

FUNCTION GetMiembroGrupo
PARAMETERS pl_TipoGrupo, pl_NomGrupo, pl_conexion

*#/----------------------------------------
* Devuelve los miembros que pertenecen a un Grupo Cuya descripcion se Recibe como parametro
* la Tabla devuelve los miembros del Grupo recibido
* Devuelve "" si no puede calcular, sino devuelve el nombre de la tabla con los miembros del grupo recibido 
*#/----------------------------------------

	IF TYPE("pl_TipoGrupo") = 'N' THEN 
		IF pl_TipoGrupo = 0 OR EMPTY(ALLTRIM(pl_NomGrupo)) THEN && No se definieron Grupos 
			RETURN ""
		ENDIF 
	ELSE
		RETURN ""
	ENDIF 

	IF pl_conexion> 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionLP = pl_conexion
	ELSE 
		vconeccionLP = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	

	** busca los Miembros del Grupo de Lista pasado como parámetro
	sqlmatriz(1)=" select o.idgrupobj, o.idgrupo, o.idmiembro, o.fecha, g.idtipogrupo, g.nombre, g.describir "
	sqlmatriz(2)=" from grupoobjeto o left join grupos g on g.idgrupo = o.idgrupo "
	sqlmatriz(3)=" where g.idtipogrupo = "+ALLTRIM(STR(pl_TipoGrupo))+" and " 
	sqlmatriz(4)=" TRIM(LOWER(g.nombre)) = '"+LOWER(ALLTRIM(pl_NomGrupo))+"'"
	verror=sqlrun(vconeccionLP ,"listasgrupo_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de Listas de Precios en el Grupo... ",0+48+0,"Error")
		IF pl_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			= abreycierracon(vconeccionLP,"")
		ENDIF 	
	    RETURN "" 
	ENDIF
	SELECT listasgrupo_sql
	GO TOP 
	IF EOF() THEN 
		IF pl_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			= abreycierracon(vconeccionLP,"")
		ENDIF 	
		RETURN ""
	ENDIF 
	vlistaspregr = 'listaspregr'+frandom()
	SELECT * FROM listasgrupo_sql INTO TABLE &vlistaspregr
	SELECT listasgrupo_sql
	SELECT &vlistaspregr
	USE IN &vlistaspregr


	IF pl_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		=abreycierracon(vconeccionLP,"")
	ENDIF 	
	
	RETURN vlistaspregr
	
ENDFUNC 


FUNCTION CHAnularCMP
PARAMETERS pa_idcomproba, pa_id, pa_conexion
*#/----------------------------------------
* Chequea si el Comprobante recibido como parámetro se puede anular o no
* Fundamentalmente para Recibos, Ordenes de Pago y Caja Ingreso los que solo se pueden anular desde la Caja en la que se Realizaron
* la Función devuelve Verdadero o Falso segun sea que se puede o no Anular
*#/----------------------------------------

	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion> 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionAn = pa_conexion
		ELSE 
			vconeccionAn = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionAn = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 
	** busca los Miembros del Grupo de Lista pasado como parámetro
	sqlmatriz(1)=" select cm.tabla, cr.idcajareca  from cajarecaudah cr   "
	sqlmatriz(2)=" left join comprobantes cm on cm.idcomproba = cr.idcomproba "
	sqlmatriz(3)=" where cr.idcomproba = "+ALLTRIM(STR(pa_idcomproba))+" and idregicomp = "+ ALLTRIM(STR(pa_id))
	verror=sqlrun(vconeccionAn ,"comproanu_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda Comprobante para chequear Anulación... ",0+48+0,"Error")
		IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			= abreycierracon(vconeccionAn ,"")
		ENDIF 	
	    RETURN .f. 
	ENDIF
	SELECT comproanu_sql
	GO TOP 
	IF EOF() THEN 
		IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			= abreycierracon(vconeccionAn ,"")
		ENDIF 	
		USE IN comproanu_sql 
		RETURN .f.
	ENDIF 
	v_tablaanular = ALLTRIM(comproanu_sql.tabla)
	v_cajacompro  = comproanu_sql.idcajareca
	USE IN comproanu_sql 

	v_puedeanular = .t.

*!*			select  dc.iddetacobro, dc.idcuenta, dc.idtipopago, dc.importe as dcimporte, ifnull(cl.tabla,'') as tabla , ifnull(cl.idregistro,0) as clidregi,
*!*			ifnull(ch.idcheque,0) as idcheque, ifnull(ch.serie,'') as serie, ifnull(ch.numero,'') as numero,
*!*			ifnull(cah.idcajareca,0) as idcajareca, ifnull(cah.usuario,0) as usuario,
*!*			ifnull(umch.idcajareca,0) as idcajach, ifnull(umch.movimiento,'') as movimch,
*!*			ifnull(umcu.idcajareca,0) as idcajacu, ifnull(umcu.movimiento,'') as movimcu,
*!*			sum(ifnull(cah.idcajareca,0) - ifnull(umch.idcajareca,0) -ifnull(umcu.idcajareca,0))  as didcaja,
*!*			r.idrecibo, r.entidad from recibos r
*!*			left join detallecobros dc on r.idrecibo = dc.idregistro and r.idcomproba = dc.idcomproba
*!*			left join cobropagolink cl on cl.tablacp = 'detallecobros' and cl.registrocp = dc.iddetacobro
*!*			left join cheques ch on ch.idcheque = cl.idregistro and cl.tabla = 'cheques'
*!*			left join cupones cu on cu.idcupon = cl.idregistro and cl.tabla = 'cupones'
*!*			left join cajarecaudah cah on cah.idcomproba = r.idcomproba and cah.idregicomp = r.idrecibo
*!*			left join ultimomovitpago umch on umch.tabla = 'cheques' and umch.idregistro = ch.idcheque
*!*			left join ultimomovitpago umcu on umcu.tabla = 'cupones' and umcu.idregistro = cu.idcupon
*!*			where r.idrecibo = 2009 and ( cl.tabla = 'cheques' or cl.tabla = 'cupones' ) group by r.idrecibo
	
	IF v_cajacompro <> _SYSCAJARECA THEN && no se puede anular porque es de otra caja 
		v_puedeanular = .f.
	ENDIF 

	IF LOWER(ALLTRIM(v_tablaanular))=='recibos' AND v_puedeanular  THEN && control de anulacion para Recibos en la misma caja 
	
		
		sqlmatriz(1)= " select  sum( ABS( ifnull(cah.idcajareca,0) - ifnull(umch.idcajareca,0) - ifnull(umcu.idcajareca,0) ) )  as difidcaja from recibos r "
		sqlmatriz(2)= " left join detallecobros dc on r.idrecibo = dc.idregistro and r.idcomproba = dc.idcomproba "
		sqlmatriz(3)= " left join cobropagolink cl on cl.tablacp = 'detallecobros' and cl.registrocp = dc.iddetacobro "
		sqlmatriz(4)= " left join cheques ch on ch.idcheque = cl.idregistro and cl.tabla = 'cheques' "
		sqlmatriz(5)= " left join cupones cu on cu.idcupon = cl.idregistro and cl.tabla = 'cupones' "
		sqlmatriz(6)= " left join cajarecaudah cah on cah.idcomproba = r.idcomproba and cah.idregicomp = r.idrecibo "
		sqlmatriz(7)= " left join ultimomovitpago umch on umch.tabla = 'cheques' and umch.idregistro = ch.idcheque "
		sqlmatriz(8)= " left join ultimomovitpago umcu on umcu.tabla = 'cupones' and umcu.idregistro = cu.idcupon "
		sqlmatriz(9)= " where r.idrecibo = "+ALLTRIM(STR(pa_id))+" and ( cl.tabla = 'cheques' or cl.tabla = 'cupones' ) group by r.idrecibo"

		verror=sqlrun(vconeccionAn ,"anularcm_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de las condiciones para Anular... ",0+48+0,"Error")
			IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
				= abreycierracon(vconeccionAn ,"")
			ENDIF 	
		    RETURN .f. 
		ENDIF
	ENDIF && fin de control de anulacion de recibos en la misma caja 
	
	

	IF LOWER(ALLTRIM(v_tablaanular))=='pagosprov' AND v_puedeanular  THEN && control de anulacion para Pagos a Proveedores en la misma caja 
	
		sqlmatriz(1)= " select  sum( ABS( ifnull(cah.idcajareca,0) - ifnull(umch.idcajareca,0) - ifnull(umcu.idcajareca,0) ) )  as difidcaja from pagosprov r "
		sqlmatriz(2)= " left join detallepagos dc on r.idpago = dc.idregistro and r.idcomproba = dc.idcomproba "
		sqlmatriz(3)= " left join cobropagolink cl on cl.tablacp = 'detallepagos' and cl.registrocp = dc.iddetapago "
		sqlmatriz(4)= " left join cheques ch on ch.idcheque = cl.idregistro and cl.tabla = 'cheques' "
		sqlmatriz(5)= " left join cupones cu on cu.idcupon = cl.idregistro and cl.tabla = 'cupones' "
		sqlmatriz(6)= " left join cajarecaudah cah on cah.idcomproba = r.idcomproba and cah.idregicomp = r.idpago "
		sqlmatriz(7)= " left join ultimomovitpago umch on umch.tabla = 'cheques' and umch.idregistro = ch.idcheque "
		sqlmatriz(8)= " left join ultimomovitpago umcu on umcu.tabla = 'cupones' and umcu.idregistro = cu.idcupon "
		sqlmatriz(9)= " where r.idpago = "+ALLTRIM(STR(pa_id))+" and ( cl.tabla = 'cheques' or cl.tabla = 'cupones' ) group by r.idpago"

		verror=sqlrun(vconeccionAn ,"anularcm_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de las condiciones para Anular... ",0+48+0,"Error")
			IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
				= abreycierracon(vconeccionAn ,"")
			ENDIF 	
		    RETURN .f. 
		ENDIF
	ENDIF && fin de control de anulacion de Pagos a Proveedores en la misma caja 



	IF LOWER(ALLTRIM(v_tablaanular))=='cajaie' AND v_puedeanular THEN && control de anulacion para Caja Ingreso y Caja Egreso 

		** Busca El comprobante para ver si es un Caja Ingreso o Caja Egreso
		sqlmatriz(1)=" select * from cajaie  "
		sqlmatriz(2)=" where idcomproba = "+ALLTRIM(STR(pa_idcomproba))
		verror=sqlrun(vconeccionAn ,"cajaieanu_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Comprobante de cajaie Para chequear Anulación... ",0+48+0,"Error")
			IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
				= abreycierracon(vconeccionAn ,"")
			ENDIF 	
		    RETURN .f. 
		ENDIF
		SELECT cajaieanu_sql
		GO TOP 
		IF EOF() THEN 
			IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
				= abreycierracon(vconeccionAn ,"")
			ENDIF 	
			USE IN cajaieanu_sql
			RETURN .f.
		ENDIF 
		SELECT cajaieanu_sql
		v_detalle_anu = ALLTRIM(cajaieanu_sql.detallecp)
		v_iddetalle_anu = IIF(ALLTRIM(v_detalle_anu)=='detallecobros','iddetacobro','iddetapago')
		USE IN cajaieanu_sql
	
	
		sqlmatriz(1)= " select sum( ABS( ifnull(cah.idcajareca,0) - ifnull(umch.idcajareca,0) - ifnull(umcu.idcajareca,0) ) )  as difidcaja from cajaie r "
		sqlmatriz(2)= " left join "+v_detalle_anu+" dc on r.idcajaie = dc.idregistro and r.idcomproba = dc.idcomproba "
		sqlmatriz(3)= " left join cobropagolink cl on cl.tablacp = '"+v_detalle_anu+"' and cl.registrocp = "+v_iddetalle_anu+" "
		sqlmatriz(4)= " left join cheques ch on ch.idcheque = cl.idregistro and cl.tabla = 'cheques' "
		sqlmatriz(5)= " left join cupones cu on cu.idcupon = cl.idregistro and cl.tabla = 'cupones' "
		sqlmatriz(6)= " left join cajarecaudah cah on cah.idcomproba = r.idcomproba and cah.idregicomp = r.idcajaie "
		sqlmatriz(7)= " left join ultimomovitpago umch on umch.tabla = 'cheques' and umch.idregistro = ch.idcheque "
		sqlmatriz(8)= " left join ultimomovitpago umcu on umcu.tabla = 'cupones' and umcu.idregistro = cu.idcupon "
		sqlmatriz(9)= " where r.idcajaie = "+ALLTRIM(STR(pa_id))+" and ( cl.tabla = 'cheques' or cl.tabla = 'cupones' ) group by r.idcajaie"

		verror=sqlrun(vconeccionAn ,"anularcm_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de las condiciones para Anular... ",0+48+0,"Error")
			IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
				= abreycierracon(vconeccionAn ,"")
			ENDIF 	
		    RETURN .f. 
		ENDIF
		
	ENDIF && fin de control de anulacion de Caja Ingreso en la misma caja 



	
	if	v_puedeanular AND USED("anularcm_sql")= .T.  THEN 
		SELECT anularcm_sql
		GO TOP 
		IF !EOF() THEN 
			v_dife 		= anularcm_sql.difidcaja
			IF TYPE("v_dife")="C" THEN 
				v_dife = VAL(v_dife)
			ENDIF 
			IF v_dife <> 0 THEN  && controla que los cupones y cheques esten en la caja y el comprobante sea de la caja
				v_puedeanular = .f. 
			ENDIF 
		ENDIF 
		USE IN anularcm_sql
	ENDIF 
	
	IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		= abreycierracon(vconeccionAn ,"")
	ENDIF 	

	
	RETURN v_puedeanular 
ENDFUNC 


FUNCTION exportarRetenciones
PARAMETERS p_idcomproba,p_desde,p_hasta
*#/----------------------------------------
* Función para exportar las retenciones 
* Parámetros: 	p_idcomproba: ID del comprobante de retención, si el parámetro es CERO -> busca para todos los comprobantes
*				p_desde: Fecha de Inicio del periodo de búsqueda
*				p_hasta: Fecha de Fin del periodo de búsqueda
* La Función recibe el id del comprobante para el cuál se va a buscar las retenciones y un periodo de búsqueda.
* Retorna true si se exporta correctamente, falso en otro caso
*#/----------------------------------------

	v_retorno = .T.
	
	** Valido parametros **
	
	IF TYPE('p_idcomproba') <> 'N'
		RETURN .f.
	ENDIF 
	
	IF TYPE('P_desde') <> 'C' OR TYPE('p_hasta') <> 'C'
		RETURN .F.
	ENDIF 
	
	IF P_idcomproba < 0
		RETURN .F.
	ENDIF 
	
	IF p_desde > p_hasta
		RETURN .F.
	ENDIF 
		
		
	create table RetenAfip FREE (CodComp c(2), FecComp c(10), NroComp c(16), ImpComp c(16), ;
                           CodImp c(4), Regimen C(3), Operacion c(1), BaseCalc c(14), ;
                           Fecha C(10), CodCondi c(2), CodSujSus c(1), Monto C(14), PorceExcl c(6), ;
                           FecBoletin c(10), Tipoiden C(2), Identi C(20), NroCertOri c(14), ;
                           denoorde c(30), acrecenta c(1), cuitpaisre c(11), cuitorde c(11) )
                                        
                                        
	** Me conecto a la base de datos **
	vconeccionF=abreycierracon(0,_SYSSCHEMA)

	** Traigo las retenciones de la BD **	
*	SELECT * FROM retenciones r left join linkcompro l on r.idcomproba = l.idcomprobab and r.idreten = l.idregistrob left join pagosprov p on l.idcomprobaa = p.idcomproba and l.idregistroa = p.idpago;

	
	sqlmatriz(1)= " select p.fecha, p.numero,p.importe as imp_total,h.regimen, h.regimen,r.sujarete,r.fecha as fecharet,r.importe as importeret,e.cuit " 
	sqlmatriz(2)= " from retenciones r left join linkcompro l on r.idcomproba = l.idcomprobab and r.idreten = l.idregistrob "
	sqlmatriz(3)= " left join pagosprov p on l.idcomprobaa = p.idcomproba and l.idregistroa = p.idpago left join entidades e on p.entidad = e.entidad "
	sqlmatriz(4)= "  left join impuretencionh h on r.idreten = h.idreten where r.fecha >= '"+ALLTRIM(P_desde)+"' and r.fecha <= '"+ALLTRIM(P_hasta)+"' "
	
	IF p_idcomproba > 0
		sqlmatriz(5)=" and r.idcomproba = "+ALLTRIM(STR(p_idcomproba))
	ELSE
		sqlmatriz(5)=" "	
	ENDIF 
	
		verror=sqlrun(vconeccionF,"retenciones_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los datos de las Retenciones",0+48+0,"Error")
				= abreycierracon(vconeccionF,"")
		    RETURN .f. 
		ENDIF
		


	**	 Blanqueo la tabla por si tiene datos **
	ZAP IN RetenAfip
	
	
	** Agrego los datos a la tabla temporal, que luego se exportará como archivo **
	SELECT retenciones_sql
	GO TOP 
	
	DO WHILE NOT EOF()
	
		**** Campos del archivo ****
		* Código de comprobante
			V_CodComp    = '06' && Orden de Pago	
		* Fecha de emisión del comprobante
			V_FecComp    = SUBSTR(retenciones_sql.fecha,7,2)+"/"+SUBSTR(retenciones_sql.fecha,5,2)+"/"+SUBSTR(retenciones_sql.fecha,1,4)
		* Nro. de comprobante
			V_NroComp    = ALLTRIM(STRTRAN(STR(retenciones_sql.numero,16)," ","0"))
		* Importe comprobante
			V_ImpComp    = strtran(strtran(str(retenciones_sql.imp_total,16,2),'.',',')," ","0")
		* Código de impuesto
			V_CodImp     = '0217' && Impuesto a las ganancias
		* Código de régimen
			V_Regimen    = ALLTRIM(STRTRAN(STR(retenciones_sql.regimen,3)," ","0"))
		* Operación
			V_Operacion  = '1' && 1: Retención
		* Base de cálculo
			V_BaseCalc   = strtran(strtran(str(retenciones_sql.sujarete,14,2),'.',',')," ","0")
		* Fecha de emisión de la retención
			V_Fecha      = SUBSTR(retenciones_sql.fecharet,7,2)+"/"+SUBSTR(retenciones_sql.fecharet,5,2)+"/"+SUBSTR(retenciones_sql.fecharet,1,4)
		* Código de condición
			V_CodCondi   = '01' && 1: Inscripto
		* Retención aplicada a sujetos suspendidos según; 0: ninguno, 1: articulo 40 inciso A, articulo 40 inciso B
		    V_CodSujSus  = '0'
		* Importe de Retención
		    V_Monto      = strtran(strtran(str(retenciones_sql.importeret,14,2),'.',',')," ","0")
		* Porcentaje de Exlusión
		    V_PorceExcl  = '000,00'
		* Fecha de emisión del boletín
		    V_FecBoletin = '          '
		* Tipo de documento
		    V_Tipoiden   = '80' && 80: CUIT
		* Número de documento
		    V_Identi     = strtran(retenciones_sql.cuit,"-","")+space(9)
		* SOLO PARA EL CASO DE BENEFICIARIOS DEL EXTERIOS, además, podrán importarse los siguientes registros:
		* Número de certificado original
			V_NroCertOri = '00000000000000'
		* Denominación del ordenante
			V_denoorde   = space(30)
		* Acrecentamiento
			V_acrecenta  = '0'
		* CUIT del pais del retenido
			V_cuitpaisre = space(11)
		* CUIT del ordenante
			V_cuitorde   = space(11)	
					    
					   
					    
					   
							
		IF retenciones_sql.importeret> 0 THEN 
			* grabo en el Archivo Temporal para SIAP
			INSERT INTO RetenAfip(CodComp,FecComp,NroComp,ImpComp,CodImp,Regimen,Operacion,BaseCalc,Fecha,CodCondi,CodSujSus,;
			                      Monto,PorceExcl,FecBoletin,Tipoiden,Identi,NroCertOri,denoorde,acrecenta,cuitpaisre,cuitorde);
			            VALUES (V_CodComp,V_FecComp,V_NroComp,V_ImpComp,V_CodImp,V_Regimen,V_Operacion,V_BaseCalc,V_Fecha,V_CodCondi,;
			                    V_CodSujSus,V_Monto,V_PorceExcl,V_FecBoletin,V_Tipoiden,V_Identi,V_NroCertOri,V_denoorde,V_acrecenta,;
			                    V_cuitpaisre,V_cuitorde)
		ENDIF  
	
		SELECT retenciones_sql
		SKIP 1

	ENDDO
	
	
		** Exporto la tabla como archivo TXT **
	
		SET DEFAULT TO C:\
		v_archivo=PUTFILE('Guardar Archivo para SIAP','Retencion_GANANCIAS','TxT')
		IF EMPTY(v_archivo) THEN 
			MESSAGEBOX("NO SE HA ELEGIDO Ningún Nombre para Guardar el Archivo de Importación.",0+48+0,"Aviso del Sistema")
			RETURN .F.
		ELSE
			SELECT RetenAfip
			GO TOP 
			COPY TO (v_archivo) sdf
			MESSAGEBOX("El Archivo de Importación se ha Generado con Éxito.",0+64+0,"Aviso del Sistema")
			
		ENDIF 
	SET DEFAULT TO &_SYSESTACION 

	
	
*!*		
*!*				v_fecha      = CTOD( SUBSTR(percep.fecha,7,2)+"/"+SUBSTR(percep.fecha,5,2)+"/"+SUBSTR(percep.fecha,1,4) )				
*!*						v_compro     = "RE   0001-"+STRTRAN(STR(percep.numero,9,0)," ","0")				
*!*						v_alicuota   = percep.alicuota
*!*						v_montoimpo  = percep.sujaperc
*!*						v_basecalc   = percep.sujaperc
*!*						v_percepcion = percep.impperc
*!*						v_cuit       = percep.cuit
*!*						v_nombre     = percep.nomb_fanta
*!*						v_inscrip    = ALLTRIM(STRTRAN(percep.nroinscrip2,'-',''))
*!*						v_domicilio  = percep.domi_fanta
*!*						v_cp         = percep.cp_fanta
*!*						
*!*						SELECT localidad
*!*						GO TOP 
*!*						LOCATE FOR localidad = percep.loc_fanta
*!*						IF FOUND() THEN 
*!*							v_localidad = ALLTRIM(localidad.nombre)
*!*						ELSE
*!*							v_localidad = ''
*!*						ENDIF 
*!*						
*!*						SELECT provincias
*!*						GO top
*!*						LOCATE FOR provincia = percep.prov_fanta
*!*						IF FOUND() THEN 
*!*							v_Provincia  = ALLTRIM(provincias.nombre)
*!*						ELSE 
*!*							v_Provincia  = ''
*!*						ENDIF 
*!*						v_iva       = percep.iva
*!*						v_i_iva_g   = 0
*!*						v_imp_total = percep.imp_total
*!*						
*!*						* grabo en el Archivo Temporal para Listado
*!*						INSERT INTO TmpReten (fecha,compro,alicuota,montoimpo,basecalc, percepcion,cuit,nombre,inscrip,;
*!*						                       domicilio,cp,localidad,Provincia,iva,i_iva_g,imp_total);
*!*							VALUES (v_fecha,v_compro,v_alicuota,v_montoimpo,v_basecalc,v_percepcion,v_cuit,v_nombre,v_inscrip,;
*!*							        v_domicilio,v_cp,v_localidad,v_Provincia,v_iva,v_i_iva_g,v_imp_total)		
*!*		



*!*					SELECT TmpReten
*!*					SET ORDER TO fecha
*!*					GO TOP 
*!*					IF EOF() AND RECNO()=1
*!*						MESSAGEBOX("No Existen Retenciones de GANANCIAS con los parámetros de búsqueda ingresados",0+48+0,"Aviso del Sistema")
*!*						RETURN 
*!*					ENDIF 

*!*					ZAP IN RetenAfip

*!*					SELECT TmpReten
*!*					SET ORDER TO fecha
*!*					GO TOP 
*!*					DO WHILE NOT EOF()
*!*						V_CodComp    = '06'
*!*						V_FecComp    = DTOC(TmpReten.fecha)
*!*						V_NroComp    = strtran(STR(VAL(SUBSTR(TmpReten.compro,11,9)),16)," ","0")
*!*						V_ImpComp    = strtran(strtran(str(TmpReten.imp_total,16,2),'.',',')," ","0")
*!*						V_CodImp     = '0217'
*!*						V_Regimen    = '078'
*!*						V_Operacion  = '1'
*!*						V_BaseCalc   = strtran(strtran(str(TmpReten.basecalc,14,2),'.',',')," ","0")
*!*						V_Fecha      = DTOC(TmpReten.fecha)
*!*						V_CodCondi   = '01'
*!*					    V_CodSujSus  = '0'
*!*					    V_Monto      = strtran(strtran(str(TmpReten.percepcion,14,2),'.',',')," ","0")
*!*					    V_PorceExcl  = '000,00'
*!*					    V_FecBoletin = '          '
*!*					    V_Tipoiden   = '80'
*!*					    V_Identi     = strtran(TmpReten.cuit,"-","")+space(9)
*!*					    V_NroCertOri = '00000000000000'
*!*					    V_denoorde   = space(30)
*!*					    V_acrecenta  = '0'
*!*					    V_cuitpaisre = space(11)
*!*					    V_cuitorde   = space(11)
*!*							
*!*						IF TmpReten.percepcion > 0 THEN 
*!*							* grabo en el Archivo Temporal para SIAP
*!*							INSERT INTO RetenAfip(CodComp,FecComp,NroComp,ImpComp,CodImp,Regimen,Operacion,BaseCalc,Fecha,CodCondi,CodSujSus,;
*!*							                      Monto,PorceExcl,FecBoletin,Tipoiden,Identi,NroCertOri,denoorde,acrecenta,cuitpaisre,cuitorde);
*!*							            VALUES (V_CodComp,V_FecComp,V_NroComp,V_ImpComp,V_CodImp,V_Regimen,V_Operacion,V_BaseCalc,V_Fecha,V_CodCondi,;
*!*							                    V_CodSujSus,V_Monto,V_PorceExcl,V_FecBoletin,V_Tipoiden,V_Identi,V_NroCertOri,V_denoorde,V_acrecenta,;
*!*							                    V_cuitpaisre,V_cuitorde)
*!*						ELSE 
*!*							MESSAGEBOX("El comprobante "+ALLTRIM(TmpPercep.compro)+" de fecha "+v_fecharet+ CHR(13)+;
*!*							           "del cliente "+ALLTRIM(TmpPercep.nombre)+" tiene una retencion menor que cero."+ CHR(13)+;
*!*							           "Este comprobante no será incorporado al archivo de importación. Deberá ingresarse manualmente.",0+48+0,"ERROR")
*!*						ENDIF 
*!*							
*!*						SELECT TmpReten
*!*						SKIP 1 	
*!*					ENDDO 

*!*					SET DEFAULT TO C:\
*!*					v_archivo=PUTFILE('Guardar Archivo para SIAP','Retencion_GANANCIAS','TxT')
*!*					IF EMPTY(v_archivo) THEN 
*!*						MESSAGEBOX("NO SE HA ELEGIDO Ningún Nombre para Guardar el Archivo de Importación.",0+48+0,"Aviso del Sistema")
*!*					ELSE
*!*						SELECT RetenAfip
*!*						GO TOP 
*!*						COPY TO (v_archivo) sdf
*!*						MESSAGEBOX("El Archivo de Importación se ha Generado con Éxito.",0+64+0,"Aviso del Sistema")
*!*					ENDIF 
*!*					SET DEFAULT TO &MIESTACION	

	RETURN v_retorno
ENDFUNC 

FUNCTION abconceptos
PARAMETERS p_identidadh, p_idcateser, p_operacion
*#/----------------------------------------
* Función para Agregar o Quitar conceptos asociados a una entidad 
* Parámetros: 	p_identidadh: ID identidadh
*				p_idcateser: ID de la Categoria asociada a los conceptos que se van a agregar o quitar. Si es Cero y la operación es '-' se eliminan todos los conceptos
*				p_operacion: '+': Agrega conceptos de la categoria indicada, '-': Quita conceptos de la categoria indicada
* Retorna true si terminó correctamente, falso en otro caso
*#/----------------------------------------

	v_retorno = .T.
	
	** Valido parametros **
	
	IF TYPE('p_identidadh') <> 'N'
		RETURN .f.
	ENDIF 
		
	IF TYPE('p_idcateser') <> 'N'
		RETURN .f.
	ENDIF 	
	
	
	IF ALLTRIM(p_operacion) == '+' OR ALLTRIM(p_operacion) == '-' 
	
	ELSE
		RETURN .F.
	ENDIF 
		
	DO CASE
		CASE ALLTRIM(p_operacion) == '+'
                       
			** Me conecto a la base de datos **
				vconeccionF=abreycierracon(0,_SYSSCHEMA)

			sqlmatriz(1)=" select c.idconcepto,c.concepto,c.detalle,c.abrevia,c.importe as unitario,(c.importe*c.cantidad*r.cantidad) as importe,c.unidad,c.facturar,c.padron,e.identidadh,0 as identidadd,r.servicio,r.idcateser,r.cantidad"
			sqlmatriz(2)=" FROM entidadesh e left join rscconceptos r on e.servicio = r.servicio left join conceptoser c on r.idconcepto = c.idconcepto "
			sqlmatriz(3)=" where e.identidadh = "+ALLTRIM(STR(p_identidadh))+" and r.idcateser = "+ALLTRIM(STR(p_idcateser))


					verror=sqlrun(vconeccionF,"rscconceptos_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los datos las relaciones de conceptos",0+48+0,"Error")
							= abreycierracon(vconeccionF,"")
					    RETURN .f. 
					ENDIF

					DIMENSION lamatriz(14,2)
					
					SELECT rscconceptos_sql
					GO TOP 
					
					DO WHILE NOT EOF()
					
							p_tipoope     = 'I'
							p_condicion   = ''
							v_titulo      = " EL ALTA "
							v_identidadd  = 0
					
							v_idconcepto	= rscconceptos_sql.idconcepto
							v_concepto 		= rscconceptos_sql.concepto
							v_detalle		= rscconceptos_sql.detalle
							v_abrevia		= rscconceptos_sql.abrevia
							v_unidad		= rscconceptos_sql.unidad
							v_unitario		= rscconceptos_sql.unitario
							v_neto			= rscconceptos_sql.importe
							v_identidadh	= rscconceptos_sql.identidadh
							v_mensual		= "S"
							v_facturar		= rscconceptos_sql.facturar
							v_padron		= rscconceptos_sql.padron
							v_cantidad		= rscconceptos_sql.cantidad
							v_idlista		= 1
							v_identidadd	= 0
								
							lamatriz(1,1) = 'idconcepto'
							lamatriz(1,2) = ALLTRIM(STR(v_idconcepto))
							lamatriz(2,1) = 'articulo'	
							lamatriz(2,2) = "'"+ALLTRIM(v_concepto)+"'"
							lamatriz(3,1) = 'detalle'
							lamatriz(3,2) = "'"+ALLTRIM(v_detalle)+"'"
							lamatriz(4,1) = 'abreviado'
							lamatriz(4,2) = "'"+ALLTRIM(v_abrevia)+"'"
							lamatriz(5,1) = 'unidad'
							lamatriz(5,2) = "'"+ALLTRIM(v_unidad)+"'"
							lamatriz(6,1) = 'unitario'
							lamatriz(6,2) = ALLTRIM(STR(v_unitario,12,4))
							lamatriz(7,1) = 'neto'
							lamatriz(7,2) =  ALLTRIM(STR(v_neto,12,4))
							lamatriz(8,1) = 'identidadh'
							lamatriz(8,2) = ALLTRIM(STR(v_identidadh))
							lamatriz(9,1) = 'mensual'
							lamatriz(9,2) =  "'"+alltrim(v_mensual)+"'"
							lamatriz(10,1) = 'facturar'
							lamatriz(10,2) = "'"+ALLTRIM(v_facturar)+"'"
							lamatriz(11,1) = 'padron'
							lamatriz(11,2) = ALLTRIM(STR(v_padron))
							lamatriz(12,1) = 'cantidad'
							lamatriz(12,2) = ALLTRIM(STR(v_cantidad,12,4))
							lamatriz(13,1) = 'idlista'
							lamatriz(13,2) = ALLTRIM(STR(v_idlista))
							lamatriz(14,1) = 'identidadd'
							lamatriz(14,2) = ALLTRIM(STR(v_identidadd))

							p_tabla     = 'entidadesd'
							p_matriz    = 'lamatriz'
							p_conexion  = vconeccionF
							IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
							    MESSAGEBOX("Ha Ocurrido un Error en Grabación"+v_titulo,0+48+0,"Error")
							ELSE 

							ENDIF 
					
						SELECT rscconceptos_sql
						SKIP 1

					ENDDO
				
					** Cierra conexión
					= abreycierracon(vconeccionF,"")
					
		CASE ALLTRIM(p_operacion) == '-' 
			** Quito los conceptos de la entidad asociados a la categoria.
				
				** Me conecto a la base de datos **
				vconeccionF=abreycierracon(0,_SYSSCHEMA)

				sqlmatriz(1)=" delete from entidadesd "
				sqlmatriz(2)=" where identidadh = "+ALLTRIM(STR(p_identidadh))+" and idconcepto in (select r.idconcepto from entidadesh h " 
				sqlmatriz(3)=" left join rscconceptos r on h.servicio = r.servicio "
				IF p_idcateser > 0
					sqlmatriz(4)= " where r.idcateser = "+ALLTRIM(STR(p_idcateser))+" and h.identidadh = "+ALLTRIM(STR(p_identidadh))+") "
				ELSE
					sqlmatriz(4)= " where  h.identidadh = "+ALLTRIM(STR(p_identidadh))+") "
				ENDIF 
						verror=sqlrun(vconeccionF,"borroconceptos_sql")
						IF verror=.f.  
						    MESSAGEBOX("Ha Ocurrido un Error en la eliminación de conceptos asociados ",0+48+0,"Error")
								= abreycierracon(vconeccionF,"")
						    RETURN .f. 
						ENDIF
					** Cierra conexión
					= abreycierracon(vconeccionF,"")
			
		OTHERWISE
			RETURN .F.

	ENDCASE
                                       
 RETURN .T.                                       
	
ENDFUNC 


FUNCTION agregarconceptos
PARAMETERS p_identidadh, p_idcateser
*#/----------------------------------------
* Función para Agregar conceptos asociados a una entidad 
* Parámetros: 	p_identidadh: ID identidadh
*				p_idcateser: ID de la Categoria asociada a los conceptos que se van a agregar.
* Retorna true si terminó correctamente, falso en otro caso
*#/----------------------------------------

	v_retorno = .T.
	
	** Valido parametros **
	
	IF TYPE('p_identidadh') <> 'N'
		RETURN .f.
	ENDIF 
		
	IF TYPE('p_idcateser') <> 'N'
		RETURN .f.
	ENDIF 	
	

	IF p_idcateser <= 0
	
		RETURN .F.
	
	ENDIF 
	
	IF p_identidadh <= 0
		RETURN .F.
	ENDIF 
	
	v_ret =	abconceptos(p_identidadh, p_idcateser, "-")
	
	
	IF v_ret = .T.
		v_retorno = abconceptos(p_identidadh, p_idcateser, "+")
	ELSE
		RETURN .F.
	ENDIF 
	
	RETURN v_retorno
ENDFUNC 




FUNCTION quitarconceptos
PARAMETERS p_identidadh, p_idcateser
*#/----------------------------------------
* Función para Quitar conceptos asociados a una entidad 
* Parámetros: 	p_identidadh: ID identidadh
*				p_idcateser: ID de la Categoria asociada a los conceptos que se van a agregar.
* Retorna true si terminó correctamente, falso en otro caso
*#/----------------------------------------

	v_retorno = .T.
	
	** Valido parametros **
	
	IF TYPE('p_identidadh') <> 'N'
		RETURN .f.
	ENDIF 
		
	IF TYPE('p_idcateser') <> 'N'
		RETURN .f.
	ENDIF 	
	

	IF p_idcateser <= 0
	
		RETURN .F.
	
	ENDIF 
	
	IF p_identidadh <= 0
		RETURN .F.
	ENDIF 
	
	v_retorno =	abconceptos(p_identidadh, p_idcateser, "-")
		
	RETURN v_retorno
ENDFUNC 



FUNCTION esArticuloCompuesto
PARAMETERS p_codigoAM, p_tipo 
*#/----------------------------------------
* Función que indica si el articulo o material pasado como parámetro es un articulo compuesto
* Parámetros: 	p_codigoAM: Codigo del material o articulo
*				p_tipo: Indica si es del tipo A: articulo o M: material
* Retorna 1  si el articulo o material es un compuesto, 0 en caso de no serlo; -1 en caso de error
*#/----------------------------------------
	
	IF TYPE('p_codigoAM') <> 'C'
	
		MESSAGEBOX("El código del articulo/material es inválido, se esperaba una cadena de caracteres",0+16+256,"Función: esArticuloCompuesto")
		RETURN -1
	ENDIF 

	DO CASE
	CASE p_tipo = 'A'
		** Me conecto a la base de datos **
		vconeccionF=abreycierracon(0,_SYSSCHEMA)

		sqlmatriz(1)=" select idarticmp from articuloscmp "
		sqlmatriz(2)=" where articulo = '"+ALLTRIM(p_codigoAM)+"'" 
		
		verror=sqlrun(vconeccionF,"articuloscmpValidar_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los componentes del articulo/material",0+48+0,"Error")
				= abreycierracon(vconeccionF,"")
		    RETURN -1 
		ENDIF
		** Cierra conexión
		= abreycierracon(vconeccionF,"")
		
		SELECT articuloscmpValidar_sql
		GO TOP 
		IF NOT EOF()
			RETURN 1
		ELSE
			RETURN 0
		ENDIF 
				
	CASE p_tipo = 'M' && Material
		* Hasta el momento ningun material es compuesto. Solo los articulos tiene componentes
		RETURN 0
	OTHERWISE 
		RETURN -1
	ENDCASE
	
	RETURN -1
ENDFUNC 





FUNCTION componentesArticulo
PARAMETERS p_articulo, p_nombreTablaRet
*#/----------------------------------------
* Función que retorna una lista de los componentes y sus respectivas cantidades del articulo pasado como parámetro
* Parámetros: 	p_articulo: Codigo articulo compuesto
*				p_nombreTablaRet: Nombre de la tabla retorno
* 	Retorna .T. si no hubo errores .F. en otro caso
*#/----------------------------------------
	
	IF TYPE('p_articulo') <> 'C'
			MESSAGEBOX("El código del articulo es inválido, se esperaba una cadena de caracteres",0+16+256,"Función: componentesArticulo")
		RETURN .F.
	ENDIF 
	
	
	IF TYPE('p_nombreTablaRet') <> 'C'
			MESSAGEBOX("EL nombre de la tabla es inválida, se esperaba una cadena de caracteres",0+16+256,"Función: componentesArticulo")
		RETURN .F.
	ENDIF 

	
 	create table componentesTmp FREE (idarticmp I, idmate I, articulo C(50),cantidad N(13,2), detalle C(254), unidad C(50), costo N(13,2), linea C(10), observa C(254))
 	
*	CREATE TABLE temp (idmate I, articulo C(50),cantidad N(13,2), detalle C(254), unidad C(50), costo(13,2), linea C(10), unitario N(13,2),observa C(254), impuestos N(13,2), razonimp N(13,2),neto N(13,2))



	*** Busco los componentes 

	** Me conecto a la base de datos **
	vconeccionF=abreycierracon(0,_SYSSCHEMA)


	sqlmatriz(1)= " SELECT a.*,r.detalle, r.unidad, r.costo as importe, r.linea, r.observa,a.articuloc as codarti  FROM articuloscmp a left join articulos r on a.articuloc = r.articulo where a.articulo = '"+ALLTRIM(p_articulo)+"' and a.articuloc <> 0 "
	sqlmatriz(2)= " union "
	sqlmatriz(3)=" SELECT a.*,m.detalle, m.unidad, m.impuni as importe, m.linea, m.observa, m.codigomat as codarti FROM articuloscmp a left join otmateriales m on a.idmate = m.idmate where a.articulo = '"+ALLTRIM(p_articulo)+"' and a.idmate > 0  "
	
	verror=sqlrun(vconeccionF,"componentes_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los componentes del articulo",0+48+0,"Error")
			= abreycierracon(vconeccionF,"")
	    RETURN .F. 
	ENDIF
	** Cierra conexión
	= abreycierracon(vconeccionF,"")
	
		
	SELECT componentes_sql
	GO TOP 
	DO WHILE NOT EOF()
	
		v_idarticmp = componentes_sql.idarticmp
		v_idmate = componentes_sql.idmate 
		v_articulo = ALLTRIM(componentes_sql.codarti)
		v_cantidad = componentes_sql.cantidad 
		v_detalle = ALLTRIM(componentes_sql.detalle)
		v_unidad = ALLTRIM(componentes_sql.unidad)
		v_importe = componentes_sql.importe
		v_linea = ALLTRIM(componentes_sql.linea)
		v_observa = ALLTRIM(componentes_sql.observa)
	
		INSERT INTO componentesTmp VALUES (v_idarticmp, v_idmate, v_articulo, v_cantidad, v_detalle, v_unidad, v_importe, v_linea, v_observa)
	
	
		SELECT componentes_sql
		SKIP 1

	ENDDO
	
	
	SELECT * FROM componentesTmp INTO TABLE  &p_nombreTablaRet
	
	
	 RETURN .T.
	
ENDFUNC 




FUNCTION ABLinkCompro 
PARAMETERS pcl_idcomprobaa, pcl_idregistroa, pcl_idcomprobab, pcl_idregistrob, pcl_opera
*#/----------------------------------------
* Función que agrega (Alta) o quita (Baja) un vinculo entre comprobantes en la tabla linkcompro
* Parámetros: 	pcl_idcomprobaa = idcomproba del comprobante A
*			    pcl_idregistroa = idregistro del comprobante A
*				pcl_idcomprobab = idcomproba del comprobante B
*				pcl_idregistrob = idregistro del comprobante B
*				pcl_opera		= + su agrega - si elimina el registro
* 	Retorna el idlinkcompro del comprobante agregado o eliminado, o 0 si no pudo completar la operacion
*#/----------------------------------------
	v_reto = -1
	IF pcl_idcomprobaa > 0 AND pcl_idregistroa > 0 AND  pcl_idcomprobab > 0 AND pcl_idregistrob > 0  THEN 
		
		IF pcl_opera = '+' THEN  
		
			** Me conecto a la base de datos **
			vconeccionPCL=abreycierracon(0,_SYSSCHEMA)
			DIMENSION lamatriz7(5,2)
			v_idlinkComp  = 0
			v_idcomprobaa = pcl_idcomprobaa 
			v_idregistroa = pcl_idregistroa
			v_idcomprobab = pcl_idcomprobab 
			v_idregistrob = pcl_idregistrob
			
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla       = 'linkcompro'
			p_matriz      = 'lamatriz7'
			p_conexion    = vconeccionPCL

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
			
			sqlmatriz(1)=" select last_insert_id() as maxid "
			verror=sqlrun(vconeccionF,"ultimoId")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del maximo Numero de indice",0+48+0,"Error")
				=abreycierracon(vconeccionPCL,"")	
			    RETURN -1
			ENDIF 
			SELECT ultimoId
			GO TOP 
			v_reto = VAL(ultimoId.maxid)
			USE IN ultimoId
							
			** Cierra conexión
			= abreycierracon(vconeccionPCL,"")
			
		ENDIF 
		
		IF pcl_opera = '-' THEN 

			** Me conecto a la base de datos **
			vconeccionPCL=abreycierracon(0,_SYSSCHEMA)
			
			sqlmatriz(1)= " delete from linkcompro where idcomprobaa = "+ALLTRIM(STR(pcl_idcomprobaa))+" and  idregistroa = "+ALLTRIM(STR(pcl_idregistroa))
			sqlmatriz(2)= " and idcomprobab = "+ALLTRIM(STR(pcl_idcomprobab))+" and  idregistrob = "+ALLTRIM(STR(pcl_idregistrob))
			verror=sqlrun(vconeccionPCL,"dellinkcompro_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de los componentes del articulo",0+48+0,"Error")
					= abreycierracon(vconeccionPCL,"")
			    RETURN -1 
			ENDIF
			
			** Cierra conexión
			= abreycierracon(vconeccionPCL,"")
					
		ENDIF 
		
	ENDIF 
	RETURN v_reto
ENDFUNC 


FUNCTION FDiaVenceCta 
PARAMETERS pfd_fecha, pfd_periodo
*#/----------------------------------------
* Función que calcula la fecha de vencimiento de Cuotas de acuerdo a la fecha recibida y el periodo para el vencimiento
* Parámetros: 	pfd_fecha	= idcomproba del comprobante A
*			    pfd_periodo	= idregistro del comprobante A
* 	Retorna la Fecha de Vencimiento propuesta para la cuota
*#/----------------------------------------
	f_vencimiento = pfd_fecha + pfd_periodo
	fv_vencimiento = f_vencimiento 
	
	IF TYPE("_SYSDIASCUOTAS")='C' THEN 
		dia_vence = INT(VAL(SUBSTR(_SYSDIASCUOTAS,1,2)))
		IF dia_vence > 0 THEN 	
			dia_limite= INT(VAL(SUBSTR(_SYSDIASCUOTAS,4,2)))
			dia_fecha = DAY(pfd_fecha)
			fv_vencimiento = DATE(YEAR(f_vencimiento), MONTH(f_vencimiento), dia_vence)
			IF ( dia_fecha > dia_limite ) OR ( MONTH(f_vencimiento) = MONTH(pfd_fecha) AND pfd_periodo >= 30 ) THEN 
				fv_vencimiento = GOMONTH(fv_vencimiento,1)
			ENDIF 
		ENDIF 
	ENDIF 
			
RETURN fv_vencimiento
ENDFUNC 



FUNCTION comprobantesAsociados 
PARAMETERS p_idcompro, p_idregi, p_cone,p_idcomproAso
*#/ ------------------------------
* Obtiene una cadena de caracteres con los comprobantes asociados al comprobante pasado como parámetro
* PARAMETROS : 
*	p_idcompro: idcomproba que identifica el comprobante para el cual se quiere saber sus vinculos 
*   p_idregi :  id que identifica univocamente el comprobante para el cual se quiere saber sus vinculos
* RETORNO: 
* 	una cadena de caracteres con los comprobantes vinculados al recibido como parámetro si los hubiere.
*   Si hay error retorna una cadena vacia
*#/--------------------------------

	v_retornoAsociados = ""
	IF p_cone > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		vconeccionL = p_cone
	ELSE 
		vconeccionL = abreycierracon(0,_SYSSCHEMA)
	ENDIF 	

	v_tablaAso = GetLinkCompro(p_idcompro, p_idregi, vconeccionL, p_idcomproAso)
			
	IF EMPTY(ALLTRIM(v_tablaAso)) = .F.
		
		USE &v_tablaAso IN 0
	
		SELECT &v_tablaAso 
		GO TOP
		DO WHILE NOT EOF()
		
			**idlinkcomp i , idcomproa i , idrega i , idcomprob i , idregb i , tablaa c(30), operaa i , tablab c(30), operab i
		
			v_idcomprobaA = &v_tablaAso..idcomproa 
			v_idregA = &v_tablaAso..idrega 
			v_tablaA =&v_tablaAso..tablaa 
			v_idcomprobaB = &v_tablaAso..idcomprob 
			v_idregB = &v_tablaAso..idregb 
			v_tablaB =&v_tablaAso..tablab 
			
			v_BuscaT = "" && Tabla a buscar
			v_BuscaC = 0 && ID comprobante a buscar
			v_BuscaR = 0 && ID Registro a buscar
			
			IF p_idcompro == v_idcomprobaA AND p_idregi == v_idregA && El comprobante recibido es el comprobante A en la relación
				v_BuscaT = ALLTRIM(v_tablaB)
				v_BuscaC = v_idcomprobaB
				v_BuscaR = v_idregB
			ELSE
				IF p_idcompro == v_idcomprobaB AND p_idregi == v_idregB && El comprobante recibido es el comprobante B en la relación
					v_BuscaT = ALLTRIM(v_tablaA)
					v_BuscaC = v_idcomprobaA
					v_BuscaR = v_idregA
				ELSE && El comprobante recibido no coincide con el comprobante A ni B
					v_BuscaT = "" 
					v_BuscaC = 0 
					v_BuscaR = 0 
				ENDIF 
			ENDIF 
			
			
			IF EMPTY(ALLTRIM(v_buscaT))=.F. AND v_buscaC > 0 AND v_BuscaR > 0
						
				v_campoIndice = obtenerCampoIndice(v_buscaT, .F., vconeccionL)

				IF EMPTY(ALLTRIM(v_campoIndice))=.F.
				
				DO CASE
				CASE ALLTRIM(v_buscaT) = "factuprove"
					sqlmatriz(1)=" select * from "+ALLTRIM(v_buscaT)+" t left join comprobantes c on t.idcomproba = c.idcomproba "
					sqlmatriz(2)=" where t.idcomproba = "+ALLTRIM(STR(v_buscaC))+" and t."+(v_campoIndice)+"="+ALLTRIM(STR(v_BuscaR))
				OTHERWISE
					sqlmatriz(1)=" select * from "+ALLTRIM(v_buscaT)+" t left join comprobantes c on t.idcomproba = c.idcomproba left join puntosventa p on t.pventa = p.pventa "
					sqlmatriz(2)=" where t.idcomproba = "+ALLTRIM(STR(v_buscaC))+" and t."+(v_campoIndice)+"="+ALLTRIM(STR(v_BuscaR))
				ENDCASE
				
					verror=sqlrun(vconeccionL,"compAsociado_sql")
					IF verror=.f.  
					    MESSAGEBOX("Ha Ocurrido un Error en la búsqueda del comprobante asociado... ",0+48+0,"Error")
					ELSE
					
						SELECT compAsociado_sql
						GO top
						IF NOT EOF()
							v_comprobante = ""
							DO CASE
							CASE ALLTRIM(v_buscaT) = "factuprove"
								v_Comprobante = ALLTRIM(compAsociado_sql.abrevia)+" "+ALLTRIM(compAsociado_sql.tipo)+" "+STRTRAN(STR(compAsociado_sql.actividad,4),' ','0')+" - "+STRTRAN(STR(compAsociado_sql.numero,8),' ','0')
							OTHERWISE
								v_Comprobante = ALLTRIM(compAsociado_sql.abrevia)+" "+ALLTRIM(compAsociado_sql.tipo)+" "+ALLTRIM(compAsociado_sql.puntov)+" - "+STRTRAN(STR(compAsociado_sql.numero,8),' ','0')
							ENDCASE
						
						
						ENDIF     
						
						
						
						IF EMPTY(ALLTRIM(v_retornoAsociados))=.T.
							v_retornoAsociados = ALLTRIM(v_comprobante)
						ELSE
							v_retornoAsociados = v_retornoAsociados+"; "+ALLTRIM(v_comprobante)
						ENDIF 
						
					ENDIF
								
			
				ENDIF 
				
			ENDIF 
			
			
		
			SELECT &v_tablaAso 
			skip 1

		ENDDO
	ENDIF 
	
	RETURN v_retornoAsociados 
ENDFUNC 




********************************************************************************************************
********************************************************************************************************
********************************************************************************************************
FUNCTION GeneraCUIT (NRO_DOCU)
*#/----------------------------------------
*** Genera CUITs Válidos a partir de un Documento Recibido
*** Devuelve una lista de posibles cuits separados por coma
*#/----------------------------------------

IF EMPTY(NRO_DOCU) THEN 
	RETURN ""
ENDIF	

VCUIT_RET = ""

FOR ij = 1 TO 2 
	IF ij = 1 THEN 
		hm = "20"
	ELSE
		hm = "27"
	ENDIF 
	
	VNRO_CUIT = hm+SUBSTR(ALLTRIM(STR(100000000+NRO_DOCU)),2,8)
	A = VAL(SUBSTR(VNRO_CUIT,1,1)) * 5
	B = VAL(SUBSTR(VNRO_CUIT,2,1)) * 4
	C = VAL(SUBSTR(VNRO_CUIT,3,1)) * 3
	D = VAL(SUBSTR(VNRO_CUIT,4,1)) * 2
	E = VAL(SUBSTR(VNRO_CUIT,5,1)) * 7
	F = VAL(SUBSTR(VNRO_CUIT,6,1)) * 6
	G = VAL(SUBSTR(VNRO_CUIT,7,1)) * 5
	H = VAL(SUBSTR(VNRO_CUIT,8,1)) * 4
	I = VAL(SUBSTR(VNRO_CUIT,9,1)) * 3
	J = VAL(SUBSTR(VNRO_CUIT,10,1)) * 2

*!*		DV_NRO = VAL(SUBSTR(VNRO_CUIT,11,1)) 
	SUMA = A + B + C + D + E + F + G + H + I + J

	RESTO = MOD(SUMA,11)


	DV = 11 - RESTO


	IF RESTO = 0 OR RESTO = 1 THEN
		IF DV_NRO = 0 THEN
			VCUIT_RET = VCUIT_RET+VNRO_CUIT+ALLTRIM(STR(DV))+";"
	*		RETURN .T.
		ELSE
	*		RETURN .F.
		ENDIF
	ELSE
		VCUIT_RET = VCUIT_RET+VNRO_CUIT+ALLTRIM(STR(DV))+";"
	ENDIF
ENDFOR 
IF !empty(VCUIT_RET) THEN
	VCUIT_RET = SUBSTR(vcuit_ret,1,LEN(vcuit_ret)-1)
ENDIF  

RETURN VCUIT_RET 
ENDFUNC



********************************************************************************************************
********************************************************************************************************
********************************************************************************************************



FUNCTION ActualizaGruposR
PARAMETERS p_Grupos
*#/----------------------------------------
* Funcion de Actualizacion de Grupos Resultados 
* - Calculos de Grupos Finalizadas - 
* - Tablas actualizadas : r_gruposall (contienes grupos finales)
* PARAMETROS: p_Grupos : Si está vacío entonces elimina los registros del Calculo Actual (Vacia la Tabla r_gruposall )
*#/----------------------------------------

	IF !(TYPE("p_Grupos")="C") THEN 
		p_Grupos= ""
	ENDIF 
	
	
	IF !EMPTY(p_Grupos) THEN 
		vcerrar_locales = .f.
		IF !USED(p_Grupos) THEN 
			USE &p_Grupos IN 0
			vcerrar_locales = .t.
		ENDIF 

		** Abro la Conexión
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		** Elimino si hubiere algún cálculo de Listas de Precios 
		sqlmatriz(1)=" delete from r_gruposall "
		verror=sqlrun(vconeccionF,"r_gruposall")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Grupos Resultado ",0+48+0,"Error")
		    RETURN 
		ENDIF

		* Cargo el Nuevo Calculo de Grupos 
		SELECT &p_Grupos
		GO TOP 

		p_archivocsv= STRTRAN(_sysestacion,'\','/')+"/p_gruposall"+frandom()+".csv"
		COPY TO &p_archivocsv DELIMITED WITH ";"
		
		sqlmatriz(1)=" LOAD DATA LOCAL INFILE '"+p_archivocsv+"'"
		sqlmatriz(2)=" INTO TABLE r_gruposall fields terminated by ',' "
		sqlmatriz(3)=" ENCLOSED BY ';' "
		sqlmatriz(4)=" LINES TERMINATED BY '\r\n' "

		verror=sqlrun(vconeccionF,"loadlp")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Carga de Grupos (LOAD DATA ",0+48+0,"Error")
		    RETURN 
		ENDIF

		** Cierro la Conexion
		=abreycierracon(vconeccionF,"")	
		
		IF vcerrar_locales = .t. THEN 
			SELE &p_Grupos
			USE 
		ENDIF 
		

	ELSE && Elimino las Listas Calculadas Guardadas

		** Compruebo que no esté anulado
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
		sqlmatriz(1)=" delete from r_gruposall "
		verror=sqlrun(vconeccionF,"r_gruposall")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Eliminación de Grupos Resultados ",0+48+0,"Error")
		    RETURN 
		ENDIF
		** Cierro la Conexion
		=abreycierracon(vconeccionF,"")	
	
	ENDIF 	

RETURN 






********************************************************************************************************
********************************************************************************************************
********************************************************************************************************



FUNCTION DescuStockSN
PARAMETERS p_tablaarticulos, pa_conexion
*#/----------------------------------------
* Función que devuelve verdadero o Falso si se puede descontar stock 
* de deposito pasado como parametro en la tabla
* - PARAMETROS p_tablaarticulos : ( articulo c(50), cantidad y, deposito I )
* Retorna Verdadero o Falso segun se pueda hacer el descuento de stock o no en función de 
* la existencia del artículo en Stock,
* Basta que al menos uno no tenga disponibilidad para que devuelva falso 
*#/----------------------------------------
	* Si no esta hablitado el descuento de Stock devuelve siempre .t. = Puede descontar stock 
	IF ALLTRIM(_SYSSTOCKACTRL) = 'N' THEN 
		RETURN .T.
	ENDIF 

	LOCAL Rta_SN 
	Rta_SN = .T.
	
	IF !USED(p_tablaarticulos) THEN 
		USE &p_tablaarticulos IN 0
	ENDIF 
	SELECT &p_tablaarticulos 

	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionDV = pa_conexion
		ELSE 
			vconeccionDV = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionDV = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 
	
	SELECT &p_tablaarticulos 
	GO TOP 


	DO WHILE !EOF() 

		IF &p_tablaarticulos..cantidad > 0 THEN 
		
			*Veo si el Articulo es de Stock , si no lo es retorna .t. = hay stock suficiente ( no se controla)

			sqlmatriz(1)=" select articulo, ctrlstock from articulos "
			sqlmatriz(3)=" where TRIM(articulo) = '"+ALLTRIM(&p_tablaarticulos..articulo)+"'"
			verror=sqlrun(vconeccionDV,"star_art")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Articulo de Stock ",0+48+0,"Error")
			    RETURN .F.
			ENDIF
			
			v_ctrlstockc = .t.
			SELECT star_art
			IF !EOF() THEN 
				IF star_art.ctrlstock = 'N' THEN 
					v_ctrlstockc = .f.
				ENDIF 
			ENDIF 
			USE IN star_art		
		
		
			IF v_ctrlstockc = .t. THEN  && tengo que controlar el descuento de stock 
 
				sqlmatriz(1)=" select r.deposito, r.articulo, r.stock, a.ctrlstock from r_depostock r "
				sqlmatriz(2)=" left join articulos a on TRIM(a.articulo)=TRIM(r.articulo) "
				sqlmatriz(3)=" where TRIM(r.articulo) = '"+ALLTRIM(&p_tablaarticulos..articulo)+"' and r.deposito="+ALLTRIM(STR(&p_tablaarticulos..deposito))
				verror=sqlrun(vconeccionDV,"stde_art")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la busqueda de stock X depositos ",0+48+0,"Error")
				    RETURN .F.
				ENDIF
 
				
				SELECT stde_art
				GO TOP 

				IF !EOF() THEN 
					IF ( stde_art.stock - &p_tablaarticulos..cantidad) < 0 THEN 
						Rta_SN = .F.
						SELECT &p_tablaarticulos
						GO BOTT
					ENDIF 
				ELSE 
					Rta_SN = .F.
					SELECT &p_tablaarticulos
					GO BOTT				
				ENDIF 		
				USE IN stde_art
			ENDIF 
			
		ENDIF 		 
		SELECT &p_tablaarticulos 
		SKIP 
	ENDDO 
	
	SELECT &p_tablaarticulos
	USE 
	IF pa_conexion = 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
		= abreycierracon(vconeccionDV ,"")
	ENDIF 	

RETURN Rta_SN


FUNCTION registarCajaOrigen
PARAMETERS p_idcajamovih, p_idcajareca
*#/----------------------------------------
* Función para registar el id del detalle del movimiento de la caja con la caja origen asociada 
* - PARAMETROS 	p_idcajamovih: ID del detalle de movimiento entre cajas (En principio se va a usar para moviemento de efectivo)
*				p_idcajareca: ID de la caja recaudadora que originó el moviento, anterior a la caja actual
* Retorno: Retorna True si se cargó correctamente, false en otro caso
*#/----------------------------------------


	IF TYPE('p_idcajamovih') = 'N' AND TYPE('p_idcajareca') = 'N'
	
		** Abro la Conexión
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			DIMENSION lamatriz7(3,2)
			v_idcajamovo  = 0
			v_idcajamovih = p_idcajamovih
			v_idcajareca  = p_idcajareca
						
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla       = 'cajamovio'
			p_matriz      = 'lamatriz7'
			p_conexion    = vconeccionF

			lamatriz7(1,1)='idcajamovo'
			lamatriz7(1,2)=ALLTRIM(STR(v_idcajamovo))
			lamatriz7(2,1)='idcajamovh'
			lamatriz7(2,2)=ALLTRIM(STR(v_idcajamovih))
			lamatriz7(3,1)='idcajareca'
			lamatriz7(3,2)=ALLTRIM(STR(v_idcajareca))

																		
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error al intentar guardar en cajamovio",0+48+0,"Error")				
				RETURN .F.
			ENDIF 
			
			
		** Cierro la Conexion
		=abreycierracon(vconeccionF,"")
		
		
	
	ELSE
	
		RETURN .F.
	
	
	ENDIF 


	RETURN .T.

		

ENDFUNC 




FUNCTION maxnumero
PARAMETERS p_campo, p_tipo, p_tabla,p_condicion
*#/----------------------------------------
* FUNCION PARA TRAER EL MAXIMO numero UNA TABLA
* RECIBE COMO PARAMETROS EL CAMPO QUE CONTIENE EL ID o NUMERO, EL TIPO DE CAMPO, LA TABLA 
* Devuelve el MAXIMO numero o -1 en caso de error
*#/----------------------------------------

	v_cond =  ""
	IF TYPE('p_condicion') = 'C'
	
		v_cond = ALLTRIM(p_condicion)
	
	ENDIF 


	IF p_tipo = 'I'

		vconeccionFm = abreycierracon(0,_SYSSCHEMA)
		*INTEGER
		
		sqlmatriz(1)=" select MAX("+ALLTRIM(p_campo)+") as maximo from "+ALLTRIM(p_tabla)
		sqlmatriz(2)= " "+v_cond
		
		verror=sqlrun(vconeccionFm,"maximoNum_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del maximo Numero de indice ",0+48+0,"Error")
			=abreycierracon(vconeccionFm,"")
		    RETURN  -1 
		ENDIF 
		
				* me desconecto	
		=abreycierracon(vconeccionFm,"")
		SELECT maximoNum_sql
		GO TOP 
		IF NOT EOF()
			v_maximo = IIF(ISNULL(maximoNum_sql.maximo),0,maximoNum_sql.maximo)		
			v_maximo = IIF(TYPE('v_maximo')='N',v_maximo,VAL(v_maximo))
		ELSE
			v_maximo = 0
		ENDIF 

		RETURN v_maximo

	ELSE
		IF p_tipo = 'C'
			*CHAR
			sqlmatriz(1)=" select MAX("+ALLTRIM(p_campo)+") as maximo from "+ALLTRIM(p_tabla)
			sqlmatriz(2)= " "+v_cond
					
			verror=sqlrun(vconeccionFm,"maximoNum_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del maximo Numero de indice ",0+48+0,"Error")
				=abreycierracon(vconeccionFm,"")
			    RETURN  -1 
			ENDIF 
			
			* me desconecto	
			=abreycierracon(vconeccionFm,"")
			SELECT maximoNum_sql
			GO TOP 
			IF NOT EOF()
				v_maximo = IIF(ISNULL(maximoNum_sql.maximo),0,maximoNum_sql.maximo)		
				v_maximo = IIF(TYPE('v_maximo')='C',v_maximo,str(v_maximo))
			ELSE
				v_maximo = "0"
			ENDIF 

			RETURN v_maximo
						
		ELSE
			
		ENDIF 

	ENDIF 

RETURN -1
ENDFUNC
 
 
 
function formatearArchivo
PARAMETERS p_nombreArchivo
*#/----------------------------------------
* FUNCION PARA Formatear el archivo, cambiando la ',' por el '.'
* RECIBE COMO PARAMETROS EL NOMBRE DEL ARCHIVO, debe estar separado por ';'
* Devuelve True o False
*#/----------------------------------------

if !file(p_nombreArchivo) THEN
	=messagebox("El Archivo: "+p_archivo+" No se Encuentra,"+CHR(13)+" o la Ruta de Acceso no es Válida",16,"Error de Búsqueda")
	thisform.tb_adjunto.SetFocus
	RETURN 0
ENDIF

	ABRE = p_nombreArchivo
	
	
			PUNTERO = FOPEN(ABRE,0)
			ARCHITMP = "formateoArchivo.csv"
			PUNTER2 = FCREATE(ARCHITMP)
			
			
			IF PUNTERO > 0 THEN
				DO WHILE !FEOF(PUNTERO)
					EJE = ALLTRIM(FGETS(PUNTERO))
					
					posPunto = 0
					posComa = 0

					
					posComa = AT(ALLTRIM(","),EJE)
					posPunto = AT(ALLTRIM("."),EJE)
					
					
					DO CASE
					CASE posComa > 0 AND posPunto > 0 && Existe un punto y una coma
						
						IF posComa > posPunto
						
						** Quito el punto y  Reemplazo la ',' por el '.'
						=FPUTS(PUNTER2,STRTRAN(STRTRAN(EJE,'.',''),',','.'))
						
						ELSE
					
						** Quito la Coma
							=FPUTS(PUNTER2,STRTRAN(EJE,',',''))
						ENDIF 
												
					CASE posComa = 0 AND posPunto > 0 && Existe solo punto
					
						** Dejo como está
						=FPUTS(PUNTER2,EJE)
					CASE posComa > 0 AND posPunto = 0 && Existe solo coma
					
						** Reemplazo la ',' por '.'
						=FPUTS(PUNTER2,STRTRAN(EJE,',','.'))
					CASE posComa = 0 AND posPunto = 0 	&& No tiene puntos ni coma
				
						**Dejo como está
						=FPUTS(PUNTER2,EJE)
					OTHERWISE 
						=FPUTS(PUNTER2,EJE)
					ENDCASE
								
					

				ENDDO

				=FCLOSE(PUNTERO)
				=FCLOSE(PUNTER2)
					
				EJECU = "COPY FILE "+ARCHITMP+" TO "+ABRE 
				&EJECU
				EJECU = "DELETE FILE "+ARCHITMP
				&EJECU
			
			ELSE
			
				=FCLOSE(PUNTER2)
				EJECU = "DELETE FILE "+ARCHITMP
				&EJECU
			ENDIF

	RETURN .T.
ENDFUNC 


FUNCTION saldosEntidadesAFecha
PARAMETERS p_nombreTabRet, p_fechaHasta, p_entidadD, p_entidadH
*#/----------------------------------------
* FUNCION PARA Que retorna los saldos a una fecha de un grupo de entidades.
* PARAMETROS: 	p_nombreTabRet: Nombre de la tabla en la que se va a retornar los datos
*				p_fechaHasta: Fecha de calculo de saldo
*				p_entidadD: Entidad desde la que se va a calcular
*				p_entidadH: Entidad hasta la que se va a calcular. Si entidad Desde es igual a Hasta busca para una entidad
*				
* RETORNO:		True en caso de que no haya errores, False  en caso contrario
*#/---


	IF TYPE('p_nombreTabRet') <> 'C'
		MESSAGEBOX("Parametro 'nombreTabRet' incorrecto. <utility.saldosEntidadesAFecha>",0+16+256,"Error al obtener el saldo de entidades por fecha")
		RETURN .F.
	ENDIF 


	IF TYPE('p_fechaHasta') <> 'C'
		MESSAGEBOX("Parametro 'fechaHasta' incorrecto. <utility.saldosEntidadesAFecha>",0+16+256,"Error al obtener el saldo de entidades por fecha")
		RETURN .F.
	ENDIF 

	IF TYPE('p_entidadD') <> 'N'
		MESSAGEBOX("Parametro 'entidadD' incorrecto. <utility.saldosEntidadesAFecha>",0+16+256,"Error al obtener el saldo de entidades por fecha")
		RETURN .F.
	ENDIF 

	IF TYPE('p_entidadH') <> 'N'
		MESSAGEBOX("Parametro 'entidadH' incorrecto. <utility.saldosEntidadesAFecha>",0+16+256,"Error al obtener el saldo de entidades por fecha")
		RETURN .F.
	ENDIF 

	_sqlfechadeu = p_fechaHasta
	_sqlentidadd = p_entidadD
	_sqlentidadh = p_entidadH
	IF p_entidadH = 0 THEN 
		_sqlentidadh = 100000000
	ENDIF 


	
	vconeccionDV = abreycierracon(0,_SYSSCHEMA)
	
	
*!*		sqlmatriz(1)=" Select f.entidad, f.servicio, f.cuenta, TRIM(f.nombre) as nombre ,f.cuit, f.idclascomp, c.descrip as clasifica , SUM(saldof) as saldo, detaservi  "
*!*		sqlmatriz(2)=" from facturasaldof f left join clasificacomp c on c.idclascomp = f.idclascomp where f.saldof <> 0 group by f.entidad, f.servicio, f.cuenta, f.idclascomp  "
	sqlmatriz(1)=" Select f.entidad, f.servicio, f.cuenta, TRIM(f.nombre) as nombre ,f.cuit,f.fechafac as fecha, f.total, SUM(ifnull(f.imputado,0)) as imputado, SUM(f.saldof) as saldo, p.puntov, o.abrevia,o.comprobante as comproba, o.tipo, s.numero,t.opera,	 "
	sqlmatriz(2)=" s.idfactura as idregistro, s.idcomproba "
	sqlmatriz(3)=" from facturasaldof f left join clasificacomp c on c.idclascomp = f.idclascomp left join facturas s on f.idfactura = s.idfactura left join puntosventa p on s.pventa = p.pventa "
	sqlmatriz(4)=" left join comprobantes o on s.idcomproba = o.idcomproba left join tipocompro t on o.idtipocompro = t.idtipocompro "
	sqlmatriz(5)=" where f.saldof <> 0  group by f.idfactura"

	verror=sqlrun(vconeccionDV,"servicios_deudaA")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Comprobantes ",0+48+0,"Error")
	  
			*** Cierro conexión ***
			=abreycierracon(vconeccionDV ,"")
		
	    RETURN .F.
	ENDIF 
	
	SELECT servicios_deudaA
	

SELECT * FROM servicios_deudaA INTO TABLE servicios_deuda

*!*		sqlmatriz(1)=" Select r.entidad, TRIM(r.nombre) as nombre , e.cuit, SUM(r.saldo) as saldo "
*!*		sqlmatriz(2)=" from recibossaldof  r left join entidades e on e.entidad = r.entidad "
*!*		sqlmatriz(3)=" group by r.entidad "

	sqlmatriz(1)=" Select f.entidad,0 as servicio, 0 as cuenta, TRIM(f.nombre) as nombre , e.cuit,f.fecha,f.importe as total, SUM(ifnull(f.totimputado,0)) as imputado, SUM(f.saldo) as saldo, p.puntov, o.abrevia,o.comprobante as comproba, o.tipo, s.numero,t.opera,  "
	sqlmatriz(2)=" s.idrecibo as idregistro, s.idcomproba "
	sqlmatriz(3)=" from recibossaldof  f left join entidades e on e.entidad = f.entidad left join recibos s on f.idrecibo = s.idrecibo left join puntosventa p on s.pventa = p.pventa "
	sqlmatriz(4)=" left join comprobantes o on s.idcomproba = o.idcomproba left join tipocompro t on o.idtipocompro = t.idtipocompro  "
	sqlmatriz(5)=" where f.saldo <> 0 group by f.idrecibo"
	
	verror=sqlrun(vconeccionDV,"servicios_cobrosA")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Comprobantes ",0+48+0,"Error")
	    
			*** Cierro conexión ***
			=abreycierracon(vconeccionDV ,"")
		
	    RETURN .F.
	ENDIF 

	SELECT * FROM servicios_cobrosA INTO TABLE servicios_cobros
	
	
		*** Cierro conexión ***
		=abreycierracon(vconeccionDV ,"")
	
	v_sent = "CREATE TABLE "+ALLTRIM(p_nombreTabRet)+" (entidad I,servicio I,cuenta I,nombre C(250),cuit C(13),fecha C(8),total N(13,4), imputado N(13,4), saldo N(13,4),puntov C(4), abrevia C(20), comproba C(100), tipo C(1), numero I, opera I, idregistro I, idcomproba I)"
	
	&v_sent
	
	SELECT servicios_deuda
	GO TOP 
	
	IF NOT EOF()
	
		SELECT &p_nombreTabret
		APPEND FROM servicios_deuda
			
	ENDIF 
	
	SELECT servicios_cobros
	GO TOP 
	
	IF NOT EOF()
		SELECT &p_nombreTabret
		APPEND FROM servicios_cobros
	
	ENDIF 
	
	SELECT &p_nombreTabret
	replace all saldo WITH IIF(saldo<0,saldo*(-1),saldo)

	SELECT &p_nombreTabret
	GO TOP 
	RETURN .T.
	

ENDFUNC 




FUNCTION SetIDFinanciaFC
PARAMETERS pfin_idfactura, pfin_idfinancia, pa_conexion
*#/----------------------------------------
* FUNCION PARA Guardar el dato de que tipo de financiacion se eligio para la factura
*				solo actualiza si en la factura el campo idfinancia = 0 , sino deja la que está
*
* PARAMETROS: 	pfin_idfactura: ID de la factura a actualizar con la financiacion elegida
*				pfin_idfinancia: idfinancia, id de la financiacion seleccionada
*				pa_conexion: Conexión usada, si no hay conexión abierta -> abre una
* RETORNO:		True en caso de que no haya errores, False  en caso contrario
*#/---

	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionDV = pa_conexion
		ELSE 
			vconeccionDV = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionDV = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 

	
	sqlmatriz(1)=" Select idfinancia from facturas "
	sqlmatriz(2)=" where idfactura = "+alltrim(STR(pfin_idfactura))
	verror=sqlrun(vconeccionDV,"actu_idfinancia")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de idfinanciacion ",0+48+0,"Error")
	    IF pa_conexion = 0
			*** Cierro conexión ***
			=abreycierracon(vconeccionF,"")
		ENDIF 
	    RETURN .F.
	ENDIF 
	SELECT actu_idfinancia
	IF !EOF() THEN 
		IF actu_idfinancia.idfinancia = 0  AND pfin_idfinancia > 0 THEN 

			sqlmatriz(1)=" update facturas set idfinancia = "+alltrim(STR(pfin_idfinancia))
			sqlmatriz(2)=" where idfactura = "+alltrim(STR(pfin_idfactura))
			verror=sqlrun(vconeccionDV,"upd_idfinancia")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de idfinanciacion ",0+48+0,"Error")
			    IF pa_conexion = 0
					*** Cierro conexión ***
					=abreycierracon(vconeccionDV,"")
				ENDIF 
			    RETURN .F.
			ENDIF 
		
		ENDIF 
	ENDIF 
	USE IN actu_idfinancia
    IF pa_conexion = 0
		*** Cierro conexión ***
		=abreycierracon(vconeccionDV,"")
	ENDIF 
	RETURN .t. 
ENDFUNC 










FUNCTION guardarSaldosEntidades 
PARAMETERS  p_tablacomp,p_idregistro, p_fechaHasta, p_entidad,p_listComp, pa_conexion
*#/----------------------------------------
* FUNCION PARA Que para guardar los saldos en una fecha de un grupo de entidades.
* PARAMETROS: 	p_tablacomp: Tabla del comprobante generado que asocio a los saldos
*				p_idregistro: ID del comprobante que asocio a los saldos
*				p_fechaHasta: Fecha de calculo de saldo
*				p_entidadD: Entidad desde la que se va a calcular
*				p_entidadH: Entidad hasta la que se va a calcular. Si entidad Desde es igual a Hasta busca para una entidad
*				p_listComp: Lista de tipos de comprobantes que voy a registrar, si es vacia -> registro todos, sino va con el formato: <idcomp1,idcomp2,...,idcompN>
*				pa_conexion: Conexión usada, si no hay conexión abierta -> abre una
* RETORNO:		True en caso de que no haya errores, False  en caso contrario
*#/---


	** Llamar a saldosEntidadesAFecha
	IF TYPE('p_tablaComp') <> 'C'
		MESSAGEBOX("Parametro 'p_tablaComp' incorrecto. <utility.guardarSaldosEntidades >",0+16+256,"Error al registrar el saldo de entidad")

		RETURN .F.
	ENDIF 

	IF TYPE('p_idregistro') <> 'N'
		MESSAGEBOX("Parametro 'p_idregistro' incorrecto. <utility.guardarSaldosEntidades >",0+16+256,"Error al registrar el saldo de entidad")
		RETURN .F.
	ENDIF 

	IF TYPE('p_fechaHasta') <> 'C'
		MESSAGEBOX("Parametro 'p_fechaHasta' incorrecto. <utility.guardarSaldosEntidades >",0+16+256,"Error al registrar el saldo de entidad")
		RETURN .F.
	ENDIF 

	IF TYPE('p_entidad') <> 'N'
		MESSAGEBOX("Parametro 'p_fechaHasta' incorrecto. <utility.guardarSaldosEntidades >",0+16+256,"Error al registrar el saldo de entidad")
		RETURN .F.
	ENDIF 

	IF TYPE('p_listcomp') <> 'C'
		MESSAGEBOX("Parametro 'p_listcomp' incorrecto. <utility.guardarSaldosEntidades >",0+16+256,"Error al registrar el saldo de entidad")
		RETURN .F.
	ENDIF 

	
	IF pa_conexion<= 0
		vconeccionF=abreycierracon(0,_SYSSCHEMA)
	ELSE
		vconeccionF=pa_conexion
	ENDIF 



		v_ret = saldosEntidadesAFecha ("saldosTmpEnt", p_fechaHasta, p_entidad, p_entidad)
		
*		v_ret = saldosEntidadesAFecha ("saldosTmpEnt", p_fechaHasta, p_entidad, p_entidad, 0)


	*	v_sent = "CREATE TABLE "+ALLTRIM(p_nombreTabRet)+" (entidad I,servicio I,cuenta I,nombre C(250),cuit C(13),fecha C(8),total N(13,4), imputado N(13,4), saldo N(13,4),puntov C(4), abrevia C(20), comproba C(100), tipo C(1), numero I, opera I, idregistro I, idcomproba I)"


	IF EMPTY(ALLTRIM(p_listcomp)) = .T.
		SELECT * FROM saldosTmpEnt INTO TABLE saldoTmpEntFil
	ELSE
		v_sen = "SELECT * FROM saldosTmpEnt WHERE idcomproba in ("+ALLTRIM(p_listcomp)+") into table saldoTmpEntFil"
		&v_sen
	ENDIF 

	IF pa_conexion > 0
		vconeccionF = pa_conexion
	ELSE
		** Abro la Conexión
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
	ENDIF 
	
								
	
		DIMENSION lamatriz(16,2)
		
		
 
	 SELECT saldoTmpEntFil
	GO TOP 

	DO WHILE NOT EOF()


		SELECT saldoTmpEntFil
		
		
		v_idhisalent = 0
		v_tablaaso = p_tablacomp
		v_idregaso = p_idregistro 
		v_entidad = saldoTmpEntFil.entidad 
		v_servicio = saldoTmpEntFil.servicio 
		v_cuenta = saldoTmpEntFil.cuenta 
		v_nombre = saldoTmpEntFil.nombre 
		v_cuit = saldoTmpEntFil.cuit 
		v_fecha = saldoTmpEntFil.fecha 
		v_total = saldoTmpEntFil.total 
		v_imputado = saldoTmpEntFil.imputado 
		v_saldo = saldoTmpEntFil.saldo 
		v_puntov = saldoTmpEntFil.puntov 
		v_abrevia = saldoTmpEntFil.abrevia 
		v_comproba = saldoTmpEntFil.comproba 
		v_tipo = saldoTmpEntFil.tipo 
		v_numero = saldoTmpEntFil.numero 
		v_opera = saldoTmpEntFil.opera 
		v_idregistro = saldoTmpEntFil.idregistro 
		v_idcomproba= saldoTmpEntFil.idcomproba 
		
		
		
			v_idcajamovo  = 0
		
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "
			p_tabla       = 'histosaldoent'
			p_matriz      = 'lamatriz'
			p_conexion    = vconeccionF

			lamatriz(1,1)='idhisalent'
			lamatriz(1,2)=ALLTRIM(STR(v_idhisalent))
			lamatriz(2,1)='tablaaso'
			lamatriz(2,2)="'"+ALLTRIM(v_tablaaso)+"'"
			lamatriz(3,1)='idregaso'
			lamatriz(3,2)=ALLTRIM(STR(v_idregaso))
			lamatriz(4,1)='fecha'
			lamatriz(4,2)="'"+ALLTRIM(v_fecha)+"'"
			lamatriz(5,1)='entidad'
			lamatriz(5,2)=ALLTRIM(STR(v_entidad))
			lamatriz(6,1)='idcomproba'
			lamatriz(6,2)=ALLTRIM(STR(v_idcomproba))
			lamatriz(7,1)='idregistro'
			lamatriz(7,2)=ALLTRIM(STR(v_idregistro))
			lamatriz(8,1)='total'
			lamatriz(8,2)=ALLTRIM(STR(v_total,13,4))
			lamatriz(9,1)='imputado' 
			lamatriz(9,2)=ALLTRIM(STR(v_imputado,13,4))
			lamatriz(10,1)='saldo'
			lamatriz(10,2)=ALLTRIM(STR(v_saldo,13,4))
			lamatriz(11,1)='puntov'
			lamatriz(11,2)="'"+ALLTRIM(v_puntov)+"'"
			lamatriz(12,1)='abrevia'
			lamatriz(12,2)="'"+ALLTRIM(v_abrevia)+"'"
			lamatriz(13,1)='comproba'
			lamatriz(13,2)="'"+ALLTRIM(v_comproba)+"'"
			lamatriz(14,1)='tipo'
			lamatriz(14,2)="'"+ALLTRIM(v_tipo)+"'"
			lamatriz(15,1)='numero'
			lamatriz(15,2)=ALLTRIM(STR(v_numero))
			lamatriz(16,1)='opera'
			lamatriz(16,2)=ALLTRIM(STR(v_opera))
																		
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error al intentar guardar en histosaldoent",0+48+0,"Error")				
				RETURN .F.
			ENDIF 
		
		SELECT saldoTmpEntFil
		SKIP 1

	ENDDO
	
	IF pa_conexion <= 0
		** Cierro la Conexion
		=abreycierracon(vconeccionF,"")
		
	ENDIF 
	
	RETURN .t.
	
ENDFUNC 





FUNCTION RenumerarAsientos
PARAMETERS pren_tipoAsi, pren_desde, pren_hasta, pren_inicial, pa_conexion
*#/----------------------------------------
* FUNCION Renumerar los asientos en un determinado periodo
*
* PARAMETROS: 	pren_tipoAsi: Tipo de Asientos a Renumerar, "I"=Asientos Individuales, "G"=Asientos Grupales 
*				pren_desde: Fecha de Inicio para la Reenumeracion
*				pren_hasta: Fecha de Fin para reenumeracion 
*				pa_conexion: Conexión usada, si no hay conexión abierta -> abre una
* RETORNO:		True en caso de que no haya errores, False  en caso contrario
*#/---


	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionRA = pa_conexion
		ELSE 
			vconeccionRA = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionRA = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 

	IF pren_tipoAsi = "I" THEN 
	
		sqlmatriz(1)=" Select a.idasiento as ida , a.numero, a.fecha, a.idtipoasi, t.detalle as detatipo  from asientos a "
		sqlmatriz(2)=" left join tipoasiento t on t.idtipoasi = a.idtipoasi "
		sqlmatriz(3)=" where fecha >= '"+alltrim(pren_desde)+"' and fecha <= '"+alltrim(pren_hasta)+"'"
		sqlmatriz(4)=" group by a.idasiento "

		v_tabla_asiento = "asientos"
		v_campo_asiento = "idasiento"
		
	ELSE
		sqlmatriz(1)=" Select g.idasientog as ida , g.numero, g.fecha, a.idtipoasi, t.detalle as detatipo  from asientosg g "
		sqlmatriz(2)=" left join asientos a on a.idasiento = g.idasiento "
		sqlmatriz(3)=" left join tipoasiento t on t.idtipoasi = a.idtipoasi "
		sqlmatriz(4)=" where g.fecha >= '"+alltrim(pren_desde)+"' and g.fecha <= '"+alltrim(pren_hasta)+"'"
		sqlmatriz(5)=" group by g.idasientog "

		v_tabla_asiento = "asientosg"
		v_campo_asiento = "idasientog"
	ENDIF 
	
	verror=sqlrun(vconeccionRA,"numasientos_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de idfinanciacion ",0+48+0,"Error")
	    IF pa_conexion = 0
			*** Cierro conexión ***
			=abreycierracon(vconeccionRA,"")
		ENDIF 
	    RETURN .F.
	ENDIF 	

	SELECT *, IIF(ALLTRIM(detatipo)=='APERTURA' ,"A",IIF(ALLTRIM(detatipo)=='CIERRE' ,"Z","B")) AS tipo , ;
	STRTRAN(STR(ida,13),' ','0') as idasi, 100000000 AS numerado  ;
	FROM numasientos_sql INTO TABLE numeraasientos 
	
	
	USE IN numasientos_sql 
	SELECT numeraasientos
	INDEX on ALLTRIM(FECHA)+ALLTRIM(TIPO)+ALLTRIM(idasi) TAG orden
	GO TOP 
	cant_asientos = RECCOUNT()
	FOR nroasi = 1 TO cant_asientos
		replace numerado WITH (pren_inicial-1)+nroasi
		SKIP 
	ENDFOR  
	GO TOP 
	
	WAIT WINDOWS "Reenumerando..." NOWAIT 
	DO WHILE !EOF()
	
		sqlmatriz(1)=" update "+ALLTRIM(v_tabla_asiento)+" set numero = "+STR(numeraasientos.numerado)
		sqlmatriz(2)=" where "+ALLTRIM(v_campo_asiento)+" = "+STR(numeraasientos.ida)		
		verror=sqlrun(vconeccionRA,"update_asientos")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualización de Asientos ",0+48+0,"Error")
		    IF pa_conexion = 0
				*** Cierro conexión ***
				=abreycierracon(vconeccionRA,"")
			ENDIF 
		    RETURN .F.
		ENDIF 	

		SELECT numeraasientos
		SKIP 
	ENDDO 
	WAIT CLEAR 
	USE IN numeraasientos

    IF pa_conexion = 0
		*** Cierro conexión ***
		=abreycierracon(vconeccionRA,"")
	ENDIF 
	RETURN .t. 
ENDFUNC 





FUNCTION FActuCuotasEdc
PARAMETERS pfa_articulo, pfa_identidadd, pa_conexion
*#/----------------------------------------
* FUNCION Actualizar Importe de Cuotas para Facturacion Mensual
*
* PARAMETROS: 	pfa_articulo: articulo para el cual se cambiara el precio en los clientes con cuotas
*				pfa_identidadd: Item de detalle individual para el cual se cambiará el valor de la cuota a facturar 
*				pa_conexion: Conexión usada, si no hay conexión abierta -> abre una
* RETORNO:		True en caso de que no haya errores, False  en caso contrario
*#/---

	IF pfa_identidadd = 0 THEN 
*!*			RETURN .f. 
	ENDIF 

	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionRA = pa_conexion
		ELSE 
			vconeccionRA = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionRA = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 

	
	sqlmatriz(1) = " select d.identidadd, d.articulo, d.cantidad, d.neto, c.idcuotasd, c.neto as netocuota, c.impuesto as impucuota, c.neto as netoante, c.impuesto , c.cantcuotas, c.idfactura, c.facturar, c.valorcuota "
	sqlmatriz(2) = " from entidadesdc c left join entidadesd d on d.identidadd = c.identidadd " 
	sqlmatriz(3) = " where c.idfactura = 0 "+IIF(pfa_identidadd > 0 ," and c.identidadd = "+STR(pfa_identidadd) ,IIF( EMPTY(ALLTRIM(pfa_articulo))= .t. ," " ," and d.articulo = '"+ALLTRIM(pfa_articulo)+"'"))
	verror=sqlrun(vconeccionRA,"cuotasdc_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Cuotas a Actualizar  ",0+48+0,"Error")
	    IF pa_conexion = 0
			*** Cierro conexión ***
			=abreycierracon(vconeccionRA,"")
		ENDIF 
	    RETURN .F.
	ENDIF 	

	SELECT * FROM cuotasdc_sql INTO TABLE cuotasdc WHERE !ISNULL(identidadd)

	USE IN cuotasdc_sql
	SELECT cuotasdc
	GO TOP 

	IF !EOF() THEN && si hay cuotas
	
		replace ALL netocuota WITH neto / ( IIF(valorcuota = 'S' OR cantcuotas = 0 ,1,cantcuotas  ) ), ;
					impucuota WITH IIF(netoante = 0,0,( impuesto / netoante )) * ( neto / ( IIF(valorcuota = 'S' OR cantcuotas = 0 ,1,cantcuotas  ) ))
		GO TOP 
		DO WHILE !EOF()
		
			sqlmatriz(1)=" update entidadesdc  set neto = "+STR(cuotasdc.netocuota,13,2)+", impuesto = "+STR(cuotasdc.impucuota,13,2)
			sqlmatriz(2)=" where idcuotasd = "+str(cuotasdc.idcuotasd)
			verror=sqlrun(vconeccionRA,"update_entidadesdc")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la Actualización de Cuotas a Facturar ",0+48+0,"Error")
			    IF pa_conexion = 0
					=abreycierracon(vconeccionRA,"")
				ENDIF 
			    RETURN .F.
			ENDIF 	

			SELECT cuotasdc
			SKIP 
		ENDDO 
		
	ENDIF  
	USE IN cuotasdc

    IF pa_conexion = 0
		*** Cierro conexión ***
		=abreycierracon(vconeccionRA,"")
	ENDIF 
	RETURN .t. 
ENDFUNC 




FUNCTION FTRChDiferido
PARAMETERS pch_idcheque, pa_conexion
*#/----------------------------------------
* FUNCION Actualizar Importe de Cuotas para Facturacion Mensual
*
* PARAMETROS: 	pch_idcheque: idcheque para realizar la transferencia en la cuenta 
*				pa_conexion: Conexión usada, si no hay conexión abierta -> abre una
* RETORNO:		True en caso de que no haya errores, False  en caso contrario
*#/---

	IF !(TYPE("_SYSCHDIFERIDO") = 'C') THEN
		RETURN .f.
	ENDIF
	 
	
	IF EMPTY("_SYSCHDIFERIDO") OR LEN(_SYSCHDIFERIDO) = 1  OR UPPER(SUBSTR(ALLTRIM(_SYSCHDIFERIDO),1,1)) ='N'  THEN
		RETURN .f.
	ENDIF 
	
	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionCH = pa_conexion
		ELSE 
			vconeccionCH = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionCH = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 


	sqlmatriz(1)="select * from cheques where idcheque = "+STR(pch_idcheque)
	verror=sqlrun(vconeccionCH,"cheques_dife")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Busqueda de Cheques para Hacer la Transferencia ",0+48+0,"Error")
	    IF pa_conexion = 0
			=abreycierracon(vconeccionCH,"")
		ENDIF 
	    RETURN .F.
	ENDIF 	
	SELECT cheques_dife

	GO TOP 
	IF EOF()
		USE IN cheques_dife
	    IF pa_conexion = 0 THEN 
			=abreycierracon(vconeccionCH,"")	
		ENDIF 
	    RETURN .F.
	ENDIF 
	
	v_chidcuentad = cheques_dife.idcuenta && cuenta destino para la transferencia
	v_chidcuentao = 0					  && Cuenta Origen de los montos para la transferencia
	v_chimporte	  = cheques_dife.importe
	v_chfecha	  = cheques_dife.fechaacr
	v_chfechanul  = cheques_dife.fechanula
	v_chobserva   = 'IDCHQ:'+ALLTRIM(STR(cheques_dife.idcheque))+";"

	* Controlo que ya no haya una transferencia para este cheque
	sqlmatriz(1)="select * from transferencias where observa like 'IDCHQ:"+ALLTRIM(STR(pch_idcheque))+";'"
	verror=sqlrun(vconeccionCH,"transferido_dife")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Busqueda Comprobantes de Transferencias ya hechos para el Cheque",0+48+0,"Error")
	    IF pa_conexion = 0
			=abreycierracon(vconeccionCH,"")
		ENDIF 
	    RETURN .F.
	ENDIF 	
	SELECT transferido_dife
	GO TOP 
	IF !EOF()
		USE IN transferido_dife
	    IF pa_conexion = 0 THEN 
			=abreycierracon(vconeccionCH,"")	
		ENDIF 
	    RETURN .F.
	ENDIF 
	USE IN transferido_dife

	SELECT cheques_dife

	*************************************************************
	
	
	v_chmanualauto 	= IIF(SUBSTR(_SYSCHDIFERIDO,1,1)="A",.t.,.f.)
	aelemenche 		= ALINES(Arrbancos,SUBSTR(_SYSCHDIFERIDO,3),';')
	
	FOR canbc = 1 TO aelemenche 
		IF INT(VAL(SUBSTR(Arrbancos(canbc),1,(ATC('-',Arrbancos(canbc),1)-1)))) = v_chidcuentad then 
			IF v_chidcuentao = 0 THEN 
				v_chidcuentao = INT(VAL(SUBSTR(Arrbancos(canbc),(ATC('-',Arrbancos(canbc),1)+1))))
			ENDIF 
		ENDIF 
	ENDFOR 
	RELEASE ArrBancos


	IF EMPTY(v_chfecha) OR !EMPTY(v_chfechanul) OR v_chidcuentao = 0  THEN 
	    IF pa_conexion = 0
			*** Cierro conexión ***
			=abreycierracon(vconeccionCH,"")
		ENDIF 	
		RETURN .t.
	ENDIF 

	tipoPagoObjCh	= CREATEOBJECT('tipospagosclass')
	v_tipoPagoTR = tipopagoObjCh.gettipospagos('TRANSFERENCIA')	
	RELEASE tipoPagoObjCh
	
***  aqui preparo los datos para la transferencia de cuentas ***
	CREATE TABLE tmpdetacheque ( idtipopago i, idcuenta i, idcuentad i, fecha c(8), importe n(13,2), idregistro i, descrip c(200), observa c(200) )
	INSERT INTO tmpdetacheque VALUES (v_tipoPagoTR, v_chidcuentao, v_chidcuentad, v_chfecha, v_chimporte, 0, 'TRANSFERENCIA', v_chobserva  )
	USE IN tmpdetacheque 
	DO FORM transferencia WITH 0, "tmpdetacheque", v_chmanualauto  TO v_retornatra
	

****************************************************************
	IF pa_conexion = 0
		*** Cierro conexión ***
		=abreycierracon(vconeccionCH,"")
	ENDIF 

ENDFUNC 





FUNCTION registrarCumpFacRem
PARAMETERS p_idfactura, p_idremito, p_accion, pa_conexion
*#/----------------------------------------
* FUNCION Función para registrar las cumplimentaciones de Facturas o Remitos
* 	Busca el saldo de los items de las facturas y remitos asociados, y los registra 
*	Tabla que voy a registrar: cumpFacRem
* PARAMETROS: 	p_idfactura: ID de la factura a la cual se le van a cumplir los items
*				p_idremito: ID del remito al cual se le van a cumplir los items
*				p_accion: '+' o '-': para agregar o quitar la relación
* RETORNO:		True en caso de que no haya errores, False  en caso contrario
*#/---


** Obtener las facturas pendientes de remitar y los remitos pendientes de facturar
** Por cada factura veo el articuloo y la cantidad
* Hago una subconsulta de los remitos para ese articulo y lo guardo en un cursor.
* comparo, la cantidad pendiente de remitar con la cantidad que tenga el remito para ese articulo en ese item
* si la cantidad es mayor a cero, cambio el pendiende de facturar en el remito por el total remitado y en la facura en ese item pongo la diferencia.
* En un tabla temporal pongo el idfactturah y el idremitoh  con la cantidad imputada en el item del remito
** Hago el mismo procedimiento por cada item de la factura

	IF TYPE('p_idfactura') <> 'N' OR  TYPE('p_idremito') <> 'N' OR TYPE('p_accion') <> 'C'
	
		RETURN .F.
	ENDIF 

	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionR = pa_conexion
		ELSE 
			vconeccionR = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionR = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 


	DO CASE
	CASE accion = '+' && Agrego un registro a la tabla cumpfacrem
		sqlmatriz(1)= " select * from facpendrem where idfactura = "+ALLTRIM(STR(p_idfactura))
		verror=sqlrun(vconeccionR,"facpendrem_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de las facturas pendientes de remitar",0+48+0,"Error")
		    IF pa_conexion = 0
				*** Cierro conexión ***
				=abreycierracon(vconeccionR,"")
			ENDIF 
		    RETURN .F.
		ENDIF 	
	
		sqlmatriz(1)= " select * from rempendfac where idremito = "+ALLTRIM(STR(p_idremito))
		verror=sqlrun(vconeccionR,"facpendrem_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los remitos pendientes de facturar",0+48+0,"Error")
		    IF pa_conexion = 0
				*** Cierro conexión ***
				=abreycierracon(vconeccionR,"")
			ENDIF 
		    RETURN .F.
		ENDIF 	
	
		SELECT * FROM facpendrem_sql INTO TABLE facpendrem
		SELECT * FROM rempendfac_sql INTO TABLE rempendfac
		
	
		SELECT facpendrem
		GO TOP 
		DO WHILE NOT EOF()

			v_idfacturah = facpendrem.idfacturah
			v_articulo = facpendrem.articulo
			v_cantFact = facpendrem.cantidadf
			v_cantpendrem = facpendrem.cantpenr
			
			
			SELECT * FROM rempendfac WHERE articulo = v_articulo INTO CURSOR rempenart
			
			SELECT rempenart
			GO TOP 
			DO WHILE NOT EOF()
				v_cantpendfa = rempenart.cantpenf
				v_idremitoh = rempenart.idremitoh
				
				
				IF v_cantpendfa > 0
				
					v_acump = v_cantFact - v_cantpendfa 
					
					IF v_acump > 0
						
					ELSE
					
					ENDIF 
				ENDIF 
				SELECT rempenart
				SKIP 1

			ENDDO
			

			SELECT facpendrem
			SKIP 1
		ENDDO

	CASE accion = '-' && Elimino un registro de la tabla cumpfacrem
		sqlmatriz(1)= "delete from cumpfacrem where idfactura = "+ALLTRIM(STR(p_idfactura)) +" and idremito = " + ALLTRIM(STR(p_idremito))
		verror=sqlrun(vconeccionR,"borracumpfr_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la eliminación de las facturas pendientes de remitar",0+48+0,"Error")
		    IF pa_conexion = 0
				*** Cierro conexión ***
				=abreycierracon(vconeccionR,"")
			ENDIF 
		    RETURN .F.
		ENDIF 	
		
		RETURN .T.
	OTHERWISE	&& No hago nada, retorno False, porque paso un parámetro incorrecto
		RETURN .F.
	ENDCASE

ENDFUNC 




FUNCTION VPNConexion
*#/----------------------------------------
* FUNCION Verifica si necesita conexion con VPN
* RETORNO:		True en caso de que haya conectado, False  en caso contrario
*#/---

 IF !(TYPE("_SYSMYSQL_SERVER")= 'C') THEN 
 	RETURN .f.
 ENDIF 
 IF ping(ALLTRIM(_SYSMYSQL_SERVER)) = .T. THEN 
	 RETURN .T.
 ENDIF 
 IF TYPE("_SYSVPN_CON") = 'C' THEN 
	IF !EMPTY(_SYSVPN_CON) THEN 
		EJE = "RUN /N2 "+_SYSVPN_EXE+" "+_SYSVPN_CON+" "+_SYSVPN_USR+" "+_SYSVPN_PASS
		&EJE
		WAIT windows "Conectando VPN..." TIMEOUT 7 
*		RELEASE _SYSVPN_EXE,_SYSVPN_CON,_SYSVPN_USR,_SYSVPN_PASS
	ENDIF 
 	RETURN .T.
 ENDIF 




FUNCTION stockArticuloFecha
PARAMETERS pa_articulo, pa_deposito, pa_fecha, pa_conexion
*#/----------------------------------------
* FUNCION Función para obtener el stock de un articulo en un deposito hasta una fecha determinada.
* El codigo puede ser de articulos o material. Primero va a intentar buscar como articulo y si no lo encuentra busca material
* PARAMETROS: 	pa_articulo: ID del articulo que se desea buscar
*				pa_deposito: ID del deposito
*				pa_fecha: Fecha hasta la cual se va a calcular los movimientos formato: 'AAAAMMDD'
*				pa_conexion: Variable de conexión, si existe la usa sino la crea
* RETORNO:		Cantidad de stock a la fecha indicada, NULL en caso de error
*#/---

	IF EMPTY(ALLTRIM(pa_articulo)) = .T. OR TYPE('pa_deposito') <> 'N' OR TYPE('pa_fecha') <> 'C'
		RETURN null
	ENDIF 


	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionR = pa_conexion
		ELSE 
			vconeccionR = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionR = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 
	** Compruebo primero si es un articulo  **
	sqlmatriz(1)= " select articulo from articulos " 
	sqlmatriz(2)= " where articulo = '"+ALLTRIM(pa_articulo)+"'"
	
	verror=sqlrun(vconeccionR,"articulo_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del artículos ",0+48+0,"Error")
	    IF pa_conexion = 0
			*** Cierro conexión ***
			=abreycierracon(vconeccionR,"")
		ENDIF 
	    RETURN null
	ENDIF 	
	
	
	SELECT articulo_sql
	GO TOP 
	IF NOT EOF()
		** Es un artículo ** 
		
		sqlmatriz(1)= " SELECT p.fecha,h.articulo, h.detalle, h.deposito,sum((h.cantidad*if(t.ie='I',1,-1))) as stock "
		sqlmatriz(2)= " FROM ajustestockp p left join ajustestockh h on p.idajuste = h.idajuste left join tipomstock t on p.idtipomov = t.idtipomov "
		sqlmatriz(3)= " left join estadosreg e on e.tabla = 'ajustestockh' and e.campo = 'idajusteh' and h.idajusteh = e.id "
		sqlmatriz(4)= " where p.fecha <= '"+ALLTRIM(pa_fecha)+"' and  h.articulo = '"+ALLTRIM(pa_articulo)+"' and h.deposito = "+ALLTRIM(STR(pa_deposito))+" and (e.idestador is null or e.idestador <> 2) "

*!*			verror=sqlrun(vconeccionR,"stockart_sql")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del stock de artículos ",0+48+0,"Error")
*!*			    IF pa_conexion = 0
*!*					*** Cierro conexión ***
*!*					=abreycierracon(vconeccionR,"")
*!*				ENDIF 
*!*			    RETURN null
*!*			ENDIF 
*!*			
	
	ELSE
		
		** Compruebo primero si es un material **
		sqlmatriz(1)= " select codigomat from otmateriales" 
		sqlmatriz(2)= " where codigomat = '"+ALLTRIM(pa_articulo)+"'"
		
		verror=sqlrun(vconeccionR,"material_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del material ",0+48+0,"Error")
		    IF pa_conexion = 0
				*** Cierro conexión ***
				=abreycierracon(vconeccionR,"")
			ENDIF 
		    RETURN null
		ENDIF 	
		
		
		SELECT material_sql
		GO TOP 
		
		IF NOT EOF()
			** Es un material **
			sqlmatriz(1)= " SELECT p.fecha,h.idmate,h.codigomat, h.descrip, h.iddepo,sum((h.cantidad*if(t.ie='I',1,-1))) as stock "
			sqlmatriz(2)= " FROM otmovistockp p left join otmovistockh h on p.idmovip = h.idmovip left join ottiposmovi t on p.idtipomov = t.idtipomov "
			sqlmatriz(3)= "  left join estadosreg e on e.tabla = 'otmovistockh' and e.campo = 'idmovih' and h.idmovih = e.id "
			sqlmatriz(4)= "  where p.fecha <= '"+ALLTRIM(pa_fecha)+"' and  h.codigomat = '"+ALLTRIM(pa_articulo)+"'  and h.iddepo = "+ALLTRIM(STR(pa_deposito))+" and (e.idestador is null or e.idestador <> 2) "
		ELSE
			RETURN null 
		ENDIF 
	
	ENDIF 


	
	verror=sqlrun(vconeccionR,"stockart_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA del stock de artículos ",0+48+0,"Error")
	    IF pa_conexion = 0
			*** Cierro conexión ***
			=abreycierracon(vconeccionR,"")
		ENDIF 
	    RETURN null
	ENDIF 
		
	
	SELECT stockart_sql
	GO TOP 
	IF NOT EOF()
		SELECT stockart_sql
		v_stock = stockart_sql.stock
		IF ISNULL(v_stock) = .T.
			RETURN 0
		ELSE
		
			RETURN v_stock
		ENDIF 
	ELSE
	
		RETURN 0	
	
	ENDIF 
		

ENDFUNC 


FUNCTION TransponerDB
PARAMETERS tp_tablap, tp_tablah, tp_indice, tp_campoa, tp_campob, tp_prefijo 
*#/----------------------------------------
* FUNCION Función obtener una tabla resultado con los datos de tablap y los datos de tablah como columnas de la tabla resultado
* PARAMETROS: 	tp_tablap	: Tabla Padre a la cual se le anexaran los datos de la tabla hija en forma de columnas 
*				tp_tablah	: Tabla que contiene los datos de los valores a anexar a la tabla resultado en forma de columnas
*				tp_indice	: campo comun a las dos tablas para hacer el join al rellenar los datos
*				tp_campoa	: campo que será utilizado para nominar las columnas de la nueva tabla (ej:codigo)
*				tp_campob	: campo con el que se llenarán los valores de las nuevas columnas
*				tp_prefijo	: prefijo que se le coloca a los campos agregados
* RETORNO:		retorna la tabla con los datos agregados en forma de columna, el nombre de la nueva tabla se compone del nombre
*				de tp_tablap concatenado con '_T' (TransPoner DB)
*#/---
	IF USED(tp_tablap) THEN 
		USE IN &tp_tablap
	ENDIF 
	USE &tp_tablap IN 0 ALIAS tp_tablapp

	IF USED(tp_tablah) THEN 
		USE IN &tp_tablah 
	ENDIF 
	USE &tp_tablah IN 0 ALIAS tp_tablahh
	SELECT tp_tablahh
	
	*preparo la tabla que se va a modificar
	SELECT * FROM tp_tablapp INTO TABLE tablap01
	
	* obtengo los nombres de las columnas a utilizar
	SET ENGINEBEHAVIOR 70
	SELECT &tp_campoa+SPACE(10) as nombrecp FROM tp_tablahh INTO TABLE tablah01 ORDER BY nombrecp GROUP BY nombrecp

	v_campob = "tp_tablahh."+ALLTRIM(tp_campob)
	v_tipocampo = IIF(TYPE(v_campob)='C',"c(150)","n(12,2)")
	

	SELECT tablah01
	GO TOP 
	replace ALL nombrecp WITH LOWER(STRTRAN(SUBSTR((ALLTRIM(tp_prefijo)+ALLTRIM(nombrecp)+SPACE(10)),1,10),' ','_'))
	GO top
	DO WHILE !EOF()
		SELECT tablap01
		eje = "ALTER TABLE tablap01 ADD COLUMN "+alltrim(tablah01.nombrecp)+" "+v_tipocampo
		&eje 
		SELECT tablah01
		SKIP 
	ENDDO 


	IF SUBSTR(v_tipocampo,1,1) ='c' THEN 
		eje = "SELECT p.*, h."+ALLTRIM(tp_campoa)+" as campoa, h."+ALLTRIM(tp_campob)+" as campob  FROM tablap01 p LEFT JOIN tp_tablahh h ON h."+ALLTRIM(tp_indice)+"== p."+ALLTRIM(tp_indice)+ " into table tablap02 "
	ELSE
		v_campoa 		= "tp_tablahh."+ALLTRIM(tp_campoa)
		v_tipocampo_ca 	= IIF(TYPE(v_campoa)='N','str','')
		v_campoidx 		= "tp_tablahh."+ALLTRIM(tp_indice)
		v_tipocampo_idx = IIF(TYPE(v_campoidx)='N','str','')
		
		eje = "SELECT p.*, h."+ALLTRIM(tp_campoa)+" as campoa, SUM(h."+ALLTRIM(tp_campob)+") as campob,  "+v_tipocampo_idx+"(p."+ALLTRIM(tp_indice)+")+"+v_tipocampo_ca+"(h."+ALLTRIM(tp_campoa)+") as grupo "+ ;
				" FROM tablap01 p LEFT JOIN tp_tablahh h ON h."+ALLTRIM(tp_indice)+" == p."+ALLTRIM(tp_indice)+ ;
				" into table tablap02 group by grupo "
	ENDIF 
	&eje 

	SELECT tablap01
	eje = "index on "+ALLTRIM(tp_indice)+" tag "+ALLTRIM(tp_indice)
	&eje

	SELECT tablap02
	SET RELATION TO &tp_indice into tablap01 
	GO TOP 
	DO WHILE !EOF()
		SELECT tablap01
		eje = "replace  "+LOWER(STRTRAN(SUBSTR((ALLTRIM(tp_prefijo)+ALLTRIM(tablap02.campoa)+SPACE(10)),1,10),' ','_'))+" with tablap02.campob "
		&eje
		SELECT tablap02
		SKIP 
	ENDDO 

	SET ENGINEBEHAVIOR 90
	
	v_archivoreto = tp_tablap+'_T'
	SELECT * FROM tablap01 INTO TABLE &v_archivoreto 
	 
	USE IN tablah01
	USE IN tablap01
	USE IN tp_tablahh
	USE IN tp_tablapp
	USE IN tablap02
	USE IN &v_archivoreto 
	RETURN v_archivoreto
ENDFUNC 
	


FUNCTION GenerarTablasR	
PARAMETERS pa_conexion
*#/----------------------------------------
* FUNCION Regenera las Tablas de Resultados para las vistas
* PARAMETROS: 	pa_conexion: Variable de conexión, si existe la usa sino la crea
*#/---

	IF MESSAGEBOX("Confirma la Regeneacion de Tablas Resultados de Vistas...",4+32+256,"Regeneración de Tablas Resultados...") = 7 THEN 
		RETURN 
	ENDIF 
	WAIT windows "Aguarde... Regenerando Vistas y Tablas..." NOWAIT 
	IF TYPE("pa_conexion") = 'N' THEN 
		IF pa_conexion > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionRG = pa_conexion
		ELSE 
			vconeccionRG = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionRG = abreycierracon(0,_SYSSCHEMA)	
		pa_conexion = 0
	ENDIF 
	** Compruebo primero si es un articulo  **
	sqlmatriz(1)= " call p_creartablasr_() " 
	
	verror=sqlrun(vconeccionRG,"tablasr_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Regeneración de Tablas R ",0+48+0,"Error")
	    IF pa_conexion = 0
			*** Cierro conexión ***
*			=abreycierracon(vconeccionRG,"")
		ENDIF 
	ENDIF 
	
	IF pa_conexion = 0 THEN && cierro la conexion si no la abrio al ingresar
		=abreycierracon(vconeccionRG,"")
	ENDIF 

	WAIT CLEAR 
	MESSAGEBOX("Se ha Completado la Regeneración de Tablas Resultados... ",0+64,"Regeneración de Tablas Resultados...")
	
RETURN 
	


*************************
*************************

FUNCTION FSYSLOG()
PARAMETERS log_string, log_archivo
*#/----------------------------------------
* FUNCION Guarda un String en un Archivo de Log
* PARAMETROS: 	log_string: String para guardar en el archivo de log
*				log_archivo: Nombre del archivo en que se va a guardar el string
*#/---
	IF !(TYPE('_SYSLOGSYSTEM') = 'C') THEN 
		RETURN 
	ELSE 
		IF EMPTY(_SYSLOGSYSTEM) THEN 
			RETURN 
		ELSE 
			IF UPPER(SUBSTR(_SYSLOGSYSTEM,1,1)) = 'N' THEN 
				RETURN 			
			ENDIF 
		ENDIF 
	ENDIF 
	
	IF EMPTY(log_string) THEN 
		RETURN 
	ENDIF 
	
	IF !(TYPE('log_archivo') = 'C') THEN 
		log_archivo = ""
	ENDIF 
	IF EMPTY(log_archivo) THEN 
		log_archivo = IIF(EMPTY(SUBSTR(_SYSLOGSYSTEM,3)),'logsystem.log',SUBSTR(_SYSLOGSYSTEM,3))
	ENDIF 
	vlog_archivo = _SYSSERVIDOR+log_archivo	
	
	IF !FILE(vlog_archivo) THEN 
		p=FCREATE(vlog_archivo)
		FCLOSE(p)
	ENDIF 
	p=fopen(vlog_archivo,1)
	=FSEEK(p,0, 2)
	Str_Escribir = ALLTRIM(TTOC(DATETIME()))+" ; "+log_string+CHR(13)
	=fwrite(p, Str_Escribir)
	FCLOSE(p)
	RETURN 
ENDFUNC


************************************************************************
************************************************************************
FUNCTION FConsultaCompro
PARAMETERS pfc_idtipocomp, pfc_idregistro 
*#/----------------------------------------
* FUNCION Consulta comprobantes , recibe como parametro el tipo de comprobante y el idregistro y muestra en pantalla el comprobante
* PARAMETROS: 	pfc_idtipocomp: id del tipo de comprobante que se pretende mostrar
*				pfc_idregistro: id del comprobante a mostrar en la tabla padre en la que se guarda
*#/---

	IF pfc_idtipocomp = 0 THEN 
		RETURN 
	ENDIF 
	IF pfc_idregistro = 0 THEN 
		RETURN 
	ENDIF 
	
	vconeccionCO = abreycierracon(0,_SYSSCHEMA)
	sqlmatriz(1)= "SELECT tabla FROM comprobantes where idtipocompro = "+ALLTRIM(STR(pfc_idtipocomp))
	verror=sqlrun(vconeccionCO,"tablacompro_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Busqueda de la Tabla del Comprobante a Mostrar ",0+48+0,"Error")
	    RETURN 
	ENDIF 
	= abreycierracon(vconeccionCO,"")
	SELECT tablacompro_sql 
	GO TOP 
	IF EOF() THEN 
		USE IN tablacompro_sql
		RETURN 
	ENDIF 
	v_tablacomprobante = ALLTRIM(tablacompro_sql.tabla)
	USE IN tablacompro_sql 
	IF EMPTY(v_tablacomprobante) THEN 
		RETURN 
	ENDIF 

	DO CASE 
		CASE v_tablacomprobante == "cajaie"
			DO FORM cajaie WITH pfc_idregistro
			
		CASE v_tablacomprobante == "cajamovip"
			DO FORM transfecajas WITH pfc_idregistro
			
		CASE v_tablacomprobante == "costop"
			DO FORM costos WITH pfc_idregistro			
			
		CASE v_tablacomprobante == "cumplimentaoc"
			DO FORM cumpleoc WITH pfc_idregistro
			
		CASE v_tablacomprobante == "cumplimentap"
			DO FORM cumplimentacion WITH pfc_idregistro
			
		CASE v_tablacomprobante == "factuprove"
			DO FORM facturasprov WITH pfc_idregistro
			
		CASE v_tablacomprobante == "facturas"
			DO FORM facturas WITH pfc_idregistro
			
		CASE v_tablacomprobante == "np"
			DO FORM np WITH pfc_idregistro			
			
		CASE v_tablacomprobante == "oc"
			DO FORM oc WITH pfc_idregistro		
			
		CASE v_tablacomprobante == "pagares"
			DO FORM pagares WITH pfc_idregistro, 0			

		CASE v_tablacomprobante == "pagosprov"
			DO FORM pagosprov WITH pfc_idregistro,0,0,0

		CASE v_tablacomprobante == "presupu"
			DO FORM presupuesto WITH pfc_idregistro			
				
		CASE v_tablacomprobante == "recibos"
			DO FORM recibos WITH pfc_idregistro,0,0,0

		CASE v_tablacomprobante == "remitos"
			DO FORM remitos WITH pfc_idregistro

		CASE v_tablacomprobante == "transferencias"
			DO FORM transferencia WITH pfc_idregistro

		OTHERWISE 
	ENDCASE 

	RETURN 		
ENDFUNC 


************************************************************************
************************************************************************
FUNCTION FModTPago
PARAMETERS pfm_idcomproba, pfm_id, pfm_Fecha, pfm_Hora, pfm_cn
*#/----------------------------------------
* FUNCION Modifica el registro de Movimientos de Tipos de Pago (Fecha y Hora) para un comprobante
* PARAMETROS: 	pfm_idcomproba: id del tipo de comprobante que se pretende mostrar
*				pfm_id: id del comprobante a mostrar en la tabla padre en la que se guarda
*				pfm_Fecha: Nueva Fecha para el registro de movimiento
*				pfm_Hora:  Nueva hora para el registro de movimiento
*#/---

	IF pfm_idcomproba <= 0 OR pfm_id <= 0 THEN 
		RETURN 
	ENDIF 

	IF TYPE("pfm_cn") = 'N' THEN 
		IF pfm_cn > 0 THEN && Se le Paso la Conexion entonces no abre ni cierra 
			vconeccionFM = pfm_cn
		ELSE 
			vconeccionFM = abreycierracon(0,_SYSSCHEMA)
		ENDIF 	
	ELSE 
		vconeccionFM = abreycierracon(0,_SYSSCHEMA)	
		pfm_cn = 0
	ENDIF 


* Busco registros para Detallecobros 
	sqlmatriz(1) = " SELECT dc.idcomproba, dc.idregistro, dc.idtipopago, dc.importe, mp.fecha, mp.hora, mp.movimiento, mp.idmovitp FROM detallecobros dc "
	sqlmatriz(2) = " left join movitpago mp     on mp.tablacp = 'detallecobros' 	and mp.idregicp   = dc.iddetacobro "
	sqlmatriz(3) = " where ifnull(mp.idmovitp,0) > 0  and dc.idcomproba = "+ALLTRIM(STR(pfm_idcomproba))+" and dc.idregistro = "+ALLTRIM(STR(pfm_id))

	verror=sqlrun(vconeccionFM,"movitpago_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Busqueda de la Tabla del Movimiento de Tipo de Pago  ",0+48+0,"Error")
	    RETURN 
	ENDIF 
	SELECT movitpago_sql
	GO TOP 
	DO WHILE !EOF()

		vpfm_fecha = IIF(!EMPTY(pfm_Fecha),pfm_Fecha,movitpago_sql.fecha)
		vpfm_Hora  = IIF(!EMPTY(pfm_Hora),pfm_Hora,movitpago_sql.hora)

		sqlmatriz(1)="update movitpago set fecha = '"+ALLTRIM(vpfm_Fecha)+"', hora = '"+ALLTRIM(vpfm_Hora)+"' WHERE idmovitp = " +ALLTRIM(STR(movitpago_sql.idmovitp))
		verror=sqlrun(vconeccionFM,"ActuAC")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion de AsientosCompro (Fecha)",0+48+0,"Error")
		ENDIF 
	
		SELECT movitpago_sql
		SKIP 
	ENDDO 
	
* Busco registros para Detallepagos 
	sqlmatriz(1) = " SELECT dc.idcomproba, dc.idregistro, dc.idtipopago, dc.importe, mp.fecha, mp.hora, mp.movimiento, mp.idmovitp FROM detallepagos dc "
	sqlmatriz(2) = " left join movitpago mp     on mp.tablacp = 'detallepagos' 	and mp.idregicp   = dc.iddetapago "
	sqlmatriz(3) = " where ifnull(mp.idmovitp,0) > 0  and dc.idcomproba = "+ALLTRIM(STR(pfm_idcomproba))+" and dc.idregistro = "+ALLTRIM(STR(pfm_id))

	verror=sqlrun(vconeccionFM,"movitpago_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Busqueda de la Tabla del Movimiento de Tipo de Pago  ",0+48+0,"Error")
	    RETURN 
	ENDIF 
	= abreycierracon(vconeccionFM,"")
	SELECT movitpago_sql
	GO TOP 
	DO WHILE !EOF()

		vpfm_fecha = IIF(!EMPTY(pfm_Fecha),pfm_Fecha,movitpago_sql.fecha)
		vpfm_Hora  = IIF(!EMPTY(pfm_Hora),pfm_Hora,movitpago_sql.hora)

		sqlmatriz(1)="update movitpago set fecha = '"+ALLTRIM(vpfm_Fecha)+"', hora = '"+ALLTRIM(vpfm_Hora)+"' WHERE idmovitp = " +ALLTRIM(STR(movitpago_sql.idmovitp))
		verror=sqlrun(vconeccionFM,"ActuAC")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion de AsientosCompro (Fecha)",0+48+0,"Error")
		ENDIF 
	
		SELECT movitpago_sql
		SKIP 
	ENDDO 
	
	IF pfm_cn = 0 THEN && cierro la conexion si no la abrio al ingresar
		=abreycierracon(vconeccionFM,"")
	ENDIF 

	RETURN 
ENDFUNC 



FUNCTION ViewBarProgress
PARAMETERS pv_cantidad, pv_Total, pv_Titulo
*#/---------------------------
*** Función de creación y Activacion de Objeto para Mostrar Progreso
*** pv_cantidad = Numero de registro de avance
*** pv_total	= Total de Registros a procesar
*#/---------------------------
IF pv_cantidad < 0 OR (pv_cantidad >= pv_Total) THEN  
	RELEASE toolbarprogress
	RETURN 
ENDIF 
IF !(TYPE("toolbarprogress") = "O") THEN 
	PUBLIC  toolbarprogress
	toolbarprogress = CREATEOBJECT('toolbarprogress')
ENDIF 
toolbarprogress.top = ( (_screen.Height / 4 ) * 3 ) - 23
toolbarprogress.left = (_screen.Width /2 ) - ( toolbarprogress.width / 2)
toolbarprogress.progreso( pv_cantidad, pv_total, pv_titulo )
ENDFUNC 


FUNCTION FVerGrafico
PARAMETERS pfv_tabla, pfv_titulo, pfv_subtitulo, pfv_ejex, pfv_ejey, pfv_etiquetasx, pfv_detalletablax, pfv_series,  pfv_condicion
*#/---------------------------
*** Función de creación de Graficos 
*** pfv_tabla		: Tabla que contiene los datos de las series
*** pfv_titulo		: Titulo del Gráfico
*** pfv_subtitulo 	: Subtitulo del Grafico
*** pfv_ejex		: Leyenda que aparecera debajo del eje x
*** pfv_ejey		: Leyenda a la izquierda del eje Y
*** pfv_etiquetasx	: Etiquetas para cada uno de los valores de las series 
*** pfv_detalletablax: Campo que se mostrará como detalle en la Tabla adjunta al Gráfico - Generalmente igualal etiquetasx
*** pfv_series 		: Parametro que contiene la Leyenda de la serie y los valores que se graficaran
*** pfv_condicion	: Condicion que permite un filtrado en la seleccion de los registros de la tabla origen
*#/---------------------------
 
	IF !EMPTY(pfv_tabla) THEN 
		IF  !USED(pfv_tabla) THEN 
			USE &pfv_tabla IN 0
		ENDIF 
	ELSE 
		RETURN 
	ENDIF 
	pfv_tabla01 = pfv_tabla+"01"
	
	
 	vcan_series=alines( arrayseries, pfv_series, ";")
	vfcampos = ""
	FOR ise = 1 TO vcan_series
		
		vfcampos = vfcampos+", '"+SUBSTR(arrayseries(ise),1,AT(',',arrayseries(ise))-1)+"' as legen"+ALLTRIM(STRTRAN((STR(ise,5)),' ','0'))+" , "+ ;
					+SUBSTR(arrayseries(ise),AT(',',(arrayseries(ise)))+1)+" as valor"+ALLTRIM(STRTRAN((STR(ise,5)),' ','0'))
	ENDFOR 
	
	eje1 = " SELECT pfv_titulo AS titulo , pfv_subtitulo as subtitulo, pfv_ejex as ejex, pfv_ejey as ejey, "+pfv_etiquetasx+" as etiquetasx , "+STR(vcan_series)+" as cantidadgr, "+pfv_detalletablax+" as detallegrx, "
	eje2 = SUBSTR(vfcampos,2)
	eje3 = " FROM "+pfv_tabla+" into table "+pfv_tabla01+" "+IIF(!EMPTY(pfv_condicion)," where "+pfv_condicion,"")
	ejecuta = eje1+eje2+eje3
	&ejecuta 

	SELECT &pfv_tabla01
	GO TOP 
	IF EOF() THEN 
		USE IN &pfv_tabla01
		RETURN 
	ENDIF 
	
	USE IN &pfv_tabla01

	DO FORM graficos WITH pfv_tabla01

RETURN 







