_screen.Visible = .t.
SET SYSMENU OFF
CLEAR

_screen.windowstate= 0
_screen.closable = .f.
_screen.MaxButton = .T.
_screen.AutoCenter = .T.
_screen.Caption 	= ""

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

SET PROCEDURE TO UTILITY.PRG, SALIDA.PRG, SONIDO.PRG, GENERAL.PRG, SQL.PRG, crystalreports.prg, libimportar.prg
SET CLASSLIB TO  toolbarsys.vcx
SET CLASSLIB TO crystalreports.vcx additive
SET CLASSLIB TO util.vcx ADDITIVE 




vrand = RAND(-100.001)

PUBLIC toolbarsys
toolbarsys = CREATEOBJECT('toolbarsys')

WAIT windows "Verificando Conexion con Base de Datos... Aguarde..." NOWAIT 

=LEECONFIG()

*** SETEO  Y DEFINICION DE VARIABLES PUBLICAS Y DE INICIO
PUBLIC _SYSSERVIDOR , _SYSMENUSYSTEM, _SYSMODULO , _SYSUSUARIO , _SYSVERSION , _SYSIP, _SYSHOST, _SYSLISTAPRECIO
PUBLIC _SYSMASTER_SERVER ,_SYSMASTER_USER, _SYSMASTER_PASS ,_SYSMASTER_USER , _SYSMYSQL_PORT , _SYSMASTER_SCHEMA, _SYSMASTER_DESC 
 

PUBLIC SQLMATRIZ(20)
FOR I = 1 TO 20
	SQLMATRIZ(I)=""
ENDFOR 

vconeccion = -1 
salir = 0


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



=DEFVARPUBLICAS ('varpublicas')


_SYSSERVIDOR 	= FULLPATH(CURDIR())
_SYSMENUSYSTEM 	= ""
_SYSMODULO 		= 1
_SYSLISTAPRECIO	= ""

_SYSMASTER_DESC		= _SYSDESCRIP  


_screen.BackColor 	= &_SYSCOLORFONDO
_screen.Caption 	= _SYSTITULO

_SYSIP = IPADDRESS(1)
_SYSHOST= IPADDRESS(2)


I=1
AUX = _SYSESTACION+"\"+ALLTRIM(STR(I))
DO WHILE DIRECTORY(AUX)
	I = I+1
	AUX = _SYSESTACION+"\"+ALLTRIM(STR(I))
ENDDO
IF !DIRECTORY(AUX) then
	MKDIR(AUX)
	_SYSESTACION = AUX
ENDIF

SET DEFAULT TO &_SYSESTACION	

ON SHUTDOWN DO CERRAR_TODO

*!*	****************
*!*	****************
*!*	****************
  
toolbarsys.dock(1)


=settoolbarsys()
=disabletoolbar()
=actutoolbarsys('_screen')


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
		toolbarsys.show 
*!*			SET MESSAGE TO "Esta es la Barra"
 		READ EVENTS
	ELSE 
	ENDIF 
	

CLEAR DLLS
RELEASE ALL EXTENDED
CLEAR ALL




