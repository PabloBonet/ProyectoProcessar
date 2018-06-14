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

SET PROCEDURE TO UTILITY.PRG, SALIDA.PRG, SONIDO.PRG, GENERAL.PRG, SQL.PRG, crystalreports.prg 
SET CLASSLIB TO  toolbarsys.vcx
SET CLASSLIB TO crystalreports.vcx additive

PUBLIC toolbarsys
toolbarsys = CREATEOBJECT('toolbarsys')

WAIT windows "Verificando Conexion con Base de Datos... Aguarde..." NOWAIT 

=LEECONFIG()

*** SETEO  Y DEFINICION DE VARIABLES PUBLICAS Y DE INICIO
PUBLIC _SYSSERVIDOR , _SYSMENUSYSTEM, _SYSMODULO , _SYSUSUARIO , _SYSVERSION 
PUBLIC _SYSMASTER_SERVER ,_SYSMASTER_USER, _SYSMASTER_PASS ,_SYSMASTER_USER , _SYSMYSQL_PORT , _SYSMASTER_SCHEMA, _SYSMASTER_DESC 
 

PUBLIC SQLMATRIZ(20)
FOR I = 1 TO 20
	SQLMATRIZ(I)=""
ENDFOR 

vconeccion = -1 
salir = 0
DO WHILE vconeccion < 0 AND salir = 0 
	vconeccion=ConMySQL(_SYSSCHEMA)
	IF vconeccion = -1 THEN 
		DO FORM seteoaccesodb TO vseteo
		IF vseteo = 1 THEN 
			PUNTERO1 = FOPEN("CONFIG.CFG",0)
			IF PUNTERO1 > 0 THEN
				DO WHILE !FEOF(PUNTERO1) 
					EJE = ALLTRIM(FGETS(PUNTERO1))
					IF !(ALLTRIM(EJE)=="" OR SUBSTR(ALLTRIM(EJE),1,1)=="[") THEN 
						&EJE
					ENDIF
				ENDDO
				=FCLOSE(PUNTERO1)
				SET SAFETY OFF
				
			ELSE 
				MESSAGEBOX("No se puede continuar con la ejecucion"+CHR(13)+" Error en carga de archivo de configuración !! ",0+16,"Error de Ejecución")
				quit	
			ENDIF 
		ELSE 
			MESSAGEBOX("No se puede continuar con la ejecucion"+CHR(13)+" Error en carga de archivo de configuración !! ",0+16,"Error de Ejecución")
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

_SYSMASTER_SERVER 	= _SYSMYSQL_SERVER 
_SYSMASTER_USER	 	= _SYSMYSQL_USER   
_SYSMASTER_PASS   	= _SYSMYSQL_PASS   
_SYSMASTER_PORT   	= _SYSMYSQL_PORT   
_SYSMASTER_SCHEMA  	= _SYSSCHEMA  
_SYSMASTER_DESC		= _SYSDESCRIP  

_screen.BackColor 	= &_SYSCOLORFONDO
_screen.Caption 	= _SYSTITULO




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

    SET TALK OFF
	SET SYSMENU ON    
	SET SYSMENU TO 
	DO FORM LOGIN TO LOGEO
	
	IF LOGEO > 0 THEN 
	  	KEYBOARD '{F10}'
		toolbarsys.show 
 		READ EVENTS
	ELSE 
	ENDIF 
	

CLEAR DLLS
RELEASE ALL EXTENDED
CLEAR ALL




