PARAMETERS _PPARAMETROS
_screen.Visible = .t.
SET SYSMENU OFF
CLEAR

_screen.windowstate=0
_screen.closable = .f.
_screen.MaxButton = .T.
_screen.AutoCenter = .T.
_screen.Caption 	= ""
_screen.BackColor = RGB(72,120,118)

set exclusive OFF
set date to dmy
set century on
set delete on
set safety off
SET TALK OFF

set notify off
set escape off 
SET CONFIRM ON 


DEACTIVATE WINDOW "Project Manager"
SET DATE TO BRITISH
ON KEY LABEL CTRL+F4 DO SALIRMENU 
ON KEY LABEL ESC DO SETEO_ESC 
ON KEY LABEL CTRL+F11 MESSAGEBOX(_screen.ActiveForm.name)

PUBLIC _SYSLIBRERIAS, _VPARAMETROS
_VPARAMETROS = _PPARAMETROS

_SYSLIBRERIAS = " UTILITY.PRG, SALIDA.PRG, SONIDO.PRG, GENERAL.PRG, SQL.PRG, crystalreports.prg, libimportar.prg, libfacturacion.prg , ftp_class.prg, libconceptos.prg, foxbarcodeqr.prg, modulocb.prg, modulopnt.prg, libweb.prg, impuestosn.prg, validaciones.prg "
SET PROCEDURE TO &_SYSLIBRERIAS &&UTILITY.PRG, SALIDA.PRG, SONIDO.PRG, GENERAL.PRG, SQL.PRG, crystalreports.prg, libimportar.prg, libfacturacion.prg , ftp_class.prg, libconceptos.prg, foxbarcodeqr.prg, modulocb.prg, libweb.prg
SET CLASSLIB TO  toolbarsys.vcx
SET CLASSLIB TO crystalreports.vcx additive
SET CLASSLIB TO util.vcx ADDITIVE 
SET CLASSLIB TO foxcharts.vcx ADDITIVE 
SET CLASSLIB TO gdiplusx.vcx ADDITIVE 




vrand = RAND(-100.001)

PUBLIC toolbarsys, onactivitictrl
toolbarsys = CREATEOBJECT('toolbarsys')

*!*	_screen.Visible = .f.


*WAIT windows "Verificando Conexion con Base de Datos... Aguarde..." NOWAIT 

=LEECONFIG()

=VPNCONEXION()

*** SETEO  Y DEFINICION DE VARIABLES PUBLICAS Y DE INICIO
PUBLIC _SYSSERVIDOR , _SYSMENUSYSTEM, _SYSMODULO , _SYSUSUARIO,_SYSVERCAJASREC , _SYSVERSION , _SYSIP, _SYSHOST, _SYSLISTAPRECIO, _SYSBGPROCE, _SYSVERSION
PUBLIC _SYSMASTER_SERVER ,_SYSMASTER_USER, _SYSMASTER_PASS ,_SYSMASTER_USER , _SYSMASTER_PORT, _SYSMYSQL_PORT , _SYSMASTER_SCHEMA, _SYSMASTER_DESC, _SYSNIVELUSU

PUBLIC SQLMATRIZ(20)
FOR I = 1 TO 20
	SQLMATRIZ(I)=""
ENDFOR 

vconeccion = -1 
salir = 0

_SYSBGPROCE = 0
_SYSMASTER_SERVER 	= _SYSMYSQL_SERVER 
_SYSMASTER_USER	 	= _SYSMYSQL_USER   
_SYSMASTER_PASS   	= _SYSMYSQL_PASS   
_SYSMASTER_PORT   	= _SYSMYSQL_PORT   
_SYSMASTER_SCHEMA  	= _SYSSCHEMA  

DO WHILE vconeccion < 0 AND salir = 0 
	vconeccion=ConMySQL(_SYSSCHEMA)	
	IF vconeccion = -1 THEN 
		DO FORM seteoaccesodb TO vseteo
		IF !(vseteo = "0") THEN
			v_llave = vseteo
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
*			MESSAGEBOX("No se puede continuar con la ejecucion; Error en carga de archivo de configuración !! ",0+16,"Error de Ejecución")
			quit	
		ENDIF 		
	ELSE 
		=SQLDISCONNECT(vconeccion)
		salir = 1
	ENDIF 
ENDDO 
WAIT CLEAR 
_screen.windowstate= 2 

WAIT CLEAR 


*!*	****************
*!*	**** OBTIENE LA VERSION ACTUAL
*!* ****

v_archivoversion = STRTRAN(LOWER(ALLTRIM(JUSTFNAME(SYS(16,1)))),'.exe','ver.txt')
PUNTERO = FOPEN(v_archivoversion,0)
IF PUNTERO > 0 THEN
	_SYSVERSION  = ALLTRIM(FGETS(PUNTERO))
	IF EMPTY(ALLTRIM(_SYSVERSION)) THEN 
		_SYSVERSION ="0.0.0"			
	ENDIF
	=FCLOSE(PUNTERO)
ELSE
	PUNTERO = FCREATE(v_archivoversion)
	IF PUNTERO > 0 THEN 
		FPUTS(PUNTERO,"0.0.0")
		FCLOSE(PUNTERO)
	ENDIF 
	_SYSVERSION = "0.0.0"
ENDIF


****************************************************
*!*	****************

=DEFVARPUBLICAS ('varpublicas')

IF !(TYPE("_SYSTMRCHKTIME") = "U") THEN 
	IF _SYSTMRCHKTIME > 0 THEN 	
		PUBLIC TMRCHECK 
		_TMRCHECK = CREATEOBJECT("DetectActivity")
		_TMRCHECK.interval = 1800000 
		_TMRCHECK.InactivityInterval = _SYSTMRCHKTIME
		_TMRCHECK.LASTACTIVITY = DATETIME()
	ENDIF 
ENDIF 


_SYSSERVIDOR 	= FULLPATH(CURDIR())
_SYSMENUSYSTEM 	= ""
_SYSMODULO 		= 1
_SYSLISTAPRECIO	= ""

_SYSMASTER_DESC		= _SYSDESCRIP  

_screen.BackColor 	= &_SYSCOLORFONDO
_screen.Caption 	= _SYSTITULO +" V." + _SYSVERSION

IF !EMPTY(_SYSIMGFONDO) THEN  
	v_colorfondo	= SUBSTR(ALLTRIM(_SYSIMGFONDO),1,(ATC(';',_SYSIMGFONDO)-1))
	v_imagenfondo	= SUBSTR(ALLTRIM(_SYSIMGFONDO),(ATC(';',_SYSIMGFONDO)+1),(ATC(';',_SYSIMGFONDO,2)-(ATC(';',_SYSIMGFONDO))-1))
	v_imagenwidth	= SUBSTR(ALLTRIM(_SYSIMGFONDO),(ATC(';',_SYSIMGFONDO,2)+1),(ATC(';',_SYSIMGFONDO,3)-(ATC(';',_SYSIMGFONDO,2))-1))
	v_imagenheight	= SUBSTR(ALLTRIM(_SYSIMGFONDO),(ATC(';',_SYSIMGFONDO,3)+1))

	IF FILE(v_imagenfondo) THEN 	
		
		_screen.BackColor = &v_colorfondo 
		_SCREEN.ADDOBJECT("oImagen","Image")
		WITH _Screen.oImagen
		  .PICTURE = v_imagenfondo
		   .STRETCH = 2 && 1=Mantiene las proporciones, 2=Cubre todo
		  *-- Solo si la imagen tiene transparencia
		  * .BACKSTYLE = 0 && 0=Transparente, 1=Opaca
		  .LEFT = _SCREEN.WIDTH - &v_imagenwidth
		  .TOP = _SCREEN.HEIGHT - &v_imagenheight
		  *--.WIDTH = _SCREEN.WIDTH
		  *--.HEIGHT = _SCREEN.HEIGHT
		  .ANCHOR = 12
		  .VISIBLE = .T.
		ENDWITH
	ENDIF 
ENDIF 


_SYSIP = IPADDRESS(1)
_SYSHOST= IPADDRESS(2)


I= frandom()
AUX = _SYSESTACION+"\"+ALLTRIM(I)
DO WHILE DIRECTORY(AUX)
	I= frandom(5)
	AUX = _SYSESTACION+"\"+ALLTRIM(I)
ENDDO
IF !DIRECTORY(AUX) then
	MKDIR(AUX)
	_SYSESTACION = AUX
ENDIF

SET DEFAULT TO &_SYSESTACION	

ON SHUTDOWN DO CERRAR_TODO


  
toolbarsys.dock(1)

=settoolbarsys()
=disabletoolbar()
=actutoolbarsys('_screen')

* Oculto, si necesito habilitarlo por variable luego 
* Se agregará una variable de control 
*!*	toolbarsys.hide 

*!*	Local loDLL
*!*	   loDLL = CreateObject("importarobj.importaobj")
*!*	   loDLL.Sumar()
*!*	   MESSAGEBOX(loDLL.nResultado)
*!*	   loDLL.mensaje()
*!*	   MESSAGEBOX(loDLL.nResulta2)
*!*	   loDLL = .NULL.
*!*	   Release loDLL



    SET TALK OFF
	SET SYSMENU ON    
	SET SYSMENU TO 
	
	DO FORM LOGIN TO LOGEO

	IF LOGEO > 0 THEN 
	  	KEYBOARD '{F10}'
*		toolbarsys.show 
		toolbarsys.hide 
*!*			SET MESSAGE TO "Esta es la Barra"
		=variables_sys(0)
		IF fupdatesys() = 1 THEN 
			DO FORM updatesys
		ENDIF 
		READ EVENTS
	ELSE 
	ENDIF 
	

CLEAR DLLS
RELEASE ALL EXTENDED
CLEAR ALL



