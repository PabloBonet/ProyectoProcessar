 
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
			MESSAGEBOX("No se puede continuar con la ejecucion; Error en carga de archivo de configuración !! ",0+16,"Error de Ejecución")
			quit	
		ENDIF 
	ENDIF 

RETURN


ENDFUNC 


FUNCTION CREACONFIG()
		PARAMETERS pc_server, pc_usuario, pc_passw, pc_puerto, pc_esquema, pc_driver, pc_encripta, pc_llave
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

		USE 
RETURN 



*!*	*!*				v_charC=encripta(v_charC0,v_llave,.f.)+CHR(13)+CHR(10)
*!*			IF FILE('config.cfg') THEN 
*!*				DELETE FILE 'config.cfg' 
*!*			ENDIF 
*!*			v_NombreArchi="config.cfg"		
*!*			H=FCREATE(v_NombreArchi,0)
*!*			IF H < 0 THEN 
*!*				MESSAGEBOX("No se pudo CREAR el Archivo de Configuración ",0+48+0,"Error") 
*!*			ELSE
*!*				v_llave = 'Processar'
*!*				v_charC="PUBLIC _SYSMYSQL_SERVER, _SYSMYSQL_USER, _SYSMYSQL_PASS, _SYSMYSQL_PORT, _SYSSCHEMA, _SYSDRVMYSQL "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=fwrite(H,v_charC)

*!*				v_charC="PUBLIC _SYSMYSQL_PASS, _SYSMYSQL_PORT, _SYSSCHEMA, _SYSDRVMYSQL "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=fwrite(H,v_charC)

*!*				v_charC="_SYSMYSQL_SERVER = '"+ALLTRIM(pc_server)+"' "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=FWRITE(H,v_charC)

*!*				v_charC="_SYSMYSQL_USER   = '"+ALLTRIM(pc_usuario)+"' "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=FWRITE(H,v_charC)
*!*				v_charC="_SYSMYSQL_PASS   = '"+(ALLTRIM(pc_passw))+"' "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=FWRITE(H,v_charC)
*!*				v_charC="_SYSMYSQL_PORT   = '"+ALLTRIM(pc_puerto)+"' "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=FWRITE(H,v_charC)
*!*				v_charC="_SYSSCHEMA    	  = '"+ALLTRIM(pc_esquema)+"' "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=FWRITE(H,v_charC)
*!*				v_charC="_SYSDRVMYSQL     = '"+ALLTRIM(pc_driver)+"' "
*!*				v_charC=encripta(v_charC,v_llave,.f.)+CHR(13)+CHR(10)
*!*				chars=FWRITE(H,v_charC)
*!*				FCLOSE(H)
*!*			ENDIF 
*!*		RETURN 
ENDFUNC



************************************************************************************************************
************************************************************************************************************
********************************************************************************************************
FUNCTION CIERRAAPP
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
	_SYSMYSQL_SERVER 	= _SYSMASTER_SERVER 
	_SYSMYSQL_USER	 	= _SYSMASTER_USER   
	_SYSMYSQL_PASS   	= _SYSMASTER_PASS   
	_SYSMYSQL_PORT   	= _SYSMASTER_PORT   
	_SYSSCHEMA     		= _SYSMASTER_SCHEMA   
	_SYSDESCRIP			= _SYSMASTER_DESC
ENDFUNC 


FUNCTION SETVARPUBLICAS  
	PARAMETERS P_PREFIJO, P_TABLA
	** OBTIENE LOS DATOS DE UNA TABLA Y GENERA VARIABLES PUBLICAS CON LOS CAMPOS Y SUS VALORES **
	** RECIBE COMO PARAMETROS UNA CADENA PARA ANEXAR A LOS NOMBRES DE LOS CAMPOS PARA SU IDENTIFICACION **
	** COMO VARIABLE PUBLICA GLOBAL **
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
	** DEFINICION DE VARIABLES PUBLICAS DEL SISTEMA DESDE UNA TABLA DE MYSQL LLAMADA VARPUBLICAS EN EL SCHEMMA ADMINDB **
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
			EJE=&p_tabla..variable+" = "+STR(VAL(ALLTRIM(&p_tabla..valor)))
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
	IF MESSAGEBOX("¿Está seguro que desea Salir?",36,'Salir del Sistema') = 6
		CIERRAAPP()
    ENDIF
ENDPROC


FUNCTION winexec (tcExe)
	MESSAGEBOX(tcexe)
	&tcExe
ENDFUNC 



***********
********** BUSCO SETEO DE BOTONES DE TOOLBARSYS  E ICONOS ***
FUNCTION settoolbarsys 

	vconeccion=abreycierracon(0,'admindb')

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


* FUNCION DE SETEO DE LA BARRA DE HERRAMIENTAS
FUNCTION actutoolbarsys 
PARAMETERS p_form
	
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
	FOR i = 1 TO toolbarsys.controlcount
		eje = "toolbarsys.cmdbar_"+SUBSTR((STR(100+i,3)),2,2)+".visible = .f."
		&eje
		eje = "toolbarsys.cmdbar_"+SUBSTR((STR(100+i,3)),2,2)+".enabled = .f."
		&eje
	ENDFOR 
ENDFUNC 


FUNCTION validcmdtoolbar
	PARAMETERS p_cmdbar 
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
v_toolperfil = var_perfil

RELEASE toolbarmenu 
PUBLIC  toolbarmenu
toolbarmenu = CREATEOBJECT('toolbarmenu')
toolbarmenu.dock(0)
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


*** COPIAR IMAGENES ***
FUNCTION copyarchivo
	PARAMETERS p_archivo, p_pathn
	
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
			MESSAGEBOX(v_ejecutar)
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


**** COPIAR IMAGENES ****
FUNCTION copyimg
	PARAMETERS p_img, p_pathn, p_codigo
	
	j = LEN(ALLTRIM(p_img))
	LON = J
	DO WHILE ! (SUBSTR(p_img,j,1) == "\") AND ! (ALLTRIM(p_img) == "") AND j > 0
		j = j - 1
	ENDDO 

	IF !(ALLTRIM(p_img) == "") AND J > 0 THEN 
		viejo_directorio = LOWER(SUBSTR(p_img,1,J))	
	ENDIF 

	IF !(ALLTRIM(p_img) == "") THEN 
		a_archivo = LOWER("img" + ALLTRIM(p_codigo))
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

*** COPIAR DOCUMENTOS ***
** PARAMETROS: p_docu: Path completo del original; p_pathn: Nueva ubicación; p_codigo: código para diferenciar, p_viejo: Nombre del Archivo Original
FUNCTION copydocu
	PARAMETERS p_docu, p_pathn, p_codigo, p_viejo
	
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



** FUNCION PARA BUSQUEDA DE VALORES EN TABLAS DE LA BASE DE DATOS **
** RECIBE COMO PARAMETROS LA TABLA EN LA QUE BUSCAR Y EL CAMPO Y VALOR BUSCADO
** DATO ACERCA DEL VALOR A RETORNAR
** EN CASO DE NO HALLAR EL VALOR RETORNA ".NULL."
FUNCTION BUSCAVALORDB
PARAMETERS b_tabla, b_campoidx, b_valoridx, b_camporet, b_database
LOCAL varb_retorno 

	IF TYPE('b_valoridx') = 'C' THEN 
		b_valoridx_C = "'"+b_valoridx+"'"
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



*----------------------------------------------------- 
* FUNCTION Edad(tdNac, tdHoy) 
*----------------------------------------------------- 
* Calcula la edad pasando como parámetros: 
* tdNac = Fecha de nacimiento 
* tdHoy = Fecha a la cual se calcula la edad. 
* Por defecto toma la fecha actual. 
*----------------------------------------------------- 
FUNCTION Edad(tdNac, tdHoy) 
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


** SETEO DE MATRIZ PARA EJECUCION DE FUNCIONES DE LOS BOTONES **
FUNCTION seteoteclafn
PARAMETERS p_matriz_p , p_opcion, p_objeto, p_teclafn
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

* FUNCION PARA TRAER EL MAXIMO NUMERO DE UN COMPROBANTE
* RECIBE COMO PARAMETROS EL ID DEL COMPROBANTE, EL PUNTO DE VENTA Y EL VALOR A INCREMENTAR EL NUMERO
* DEVUELVE EL VALOR INCREMENTADO SEGUN EL PARAMETRO DE INCREMENTO RECIBIDO
FUNCTION maxnumerocom
PARAMETERS p_idcomproba, p_pventa, v_incre 

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

* FUNCION PARA TRAER EL MAXIMO ID O INDICE DE UNA TABLA
* RECIBE COMO PARAMETROS EL CAMPO QUE CONTIENE EL ID O INDICE, EL TIPO DE CAMPO, LA TABLA Y EL VALOR A INCREMENTAR EL ID
* DEVUELVE EL VALOR INCREMENTADO SEGUN EL PARAMETRO DE INCREMENTO RECIBIDO (SOLO SI ES NUMERO)
* SI V_AUTOINC ES .T. significa que el campo indice es autoincremental en la bd Y DEBE devolver "0"
FUNCTION maxnumeroidx
PARAMETERS p_campoidx, p_tipo, p_tabla, v_incre , v_autoinc

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
 

* FUNCIÓN PARA CARGAR EL SERVICIO
* PARAMETROS: P_PUNTOVTA, PUNTO DE VENTA DONDE SE VA A AUTORIZAR LOS COMPROBANTES

FUNCTION cargarServicioFE
	PARAMETERS p_puntoVta
	v_puntoVta = p_puntoVta
	Public loBasicHttpBinding_IServicio AS "XML Web Service"
	* LOCAL loBasicHttpBinding_IServicio AS "MSSOAP.SoapClient30"
	* Do not remove or alter following line. It is used to support IntelliSense for your XML Web service.
	*__VFPWSDef__: loBasicHttpBinding_IServicio = http://localhost:8000/?wsdl , Servicio , BasicHttpBinding_IServicio
	public loException, lcErrorMsg, loWSHandler
	v_cargado = .F.
	TRY

		
		loWSHandler = NEWOBJECT("WSHandler",IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_ws3client.vcx")

		loBasicHttpBinding_IServicio = loWSHandler.SetupClient("http://localhost:8000/?wsdl", "Servicio", "BasicHttpBinding_IServicio")
		* Call your XML Web service here.  ex: leResult = loBasicHttpBinding_IServicio.SomeMethod()
		
	

		*thisform.serviciocargado = .f.
		****** Inicio el servicio  ***

		respuesta = loBasicHttpBinding_IServicio.iniciarServicio(v_puntoVta)

		IF respuesta = .t.

			*Se cargo el servicio correctamente
			
			*thisform.lblComprobanteElec.Caption = "Comp. Electrónico - Servicio: INICIADO"
			v_cargado = .T.
		ELSE
			*El servicio no se cargó correctamente

			*thisform.lblComprobanteElec.Caption = "Comp. Electrónico - Servicio: NO INICIADO"
			v_cargado = .F.		

		ENDIF 
	
	CATCH TO loException
			lcErrorMsg="Error: "+TRANSFORM(loException.Errorno)+" - "+loException.Message
			DO CASE
			CASE VARTYPE(loBasicHttpBinding_IServicio)#"O"
				* Handle SOAP error connecting to web service
			CASE !EMPTY(loBasicHttpBinding_IServicio.FaultCode)
				* Handle SOAP error calling method
				lcErrorMsg=lcErrorMsg+CHR(13)+loBasicHttpBinding_IServicio.Detail
			OTHERWISE
				* Handle other error
			ENDCASE
			* Use for debugging purposes
			MESSAGEBOX(lcErrorMsg)
			v_cargado = .F.
		FINALLY
	ENDTRY

	RETURN v_cargado
ENDFUNC 
 
 
 
* FUNCION QUE PERMITE LA CARGA DEL COMPROBANTE AL SERVICIO LOCAL, PARA LUEGO SER AUTORIZADA
* PARAMETROS: p_idFactura, ID DEL COMPROBANTE A AUTORIZAR
FUNCTION cargarCompFE
PARAMETERS p_idFactura


	v_servicioCargado = .F.
	v_compCargado = .F.
	TRY 
	
		v_servicioCargado = loBasicHttpBinding_IServicio.servicioIniciado()
		
		IF v_servicioCargado  = .t.

			v_idfactura = p_idFactura
			
			**** CARGA COMPROBANTE ***

			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			
			
			
*			sqlmatriz(1)="Select f.*, a.codigo as codAfip, p.puntov from facturas f left join comprobantes c on f.idcomproba = c.idcomproba "
*			sqlmatriz(2)=" left join afipcompro a on  c.idafipcom = a.idafipcom left join puntosventa p on f.pventa = p.pventa "
*			sqlmatriz(3)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

			sqlmatriz(1)="Select f.*, a.codigo as codAfip, p.puntov from facturas f left join comprobantes c on f.idcomproba = c.idcomproba "
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

			SELECT factu_sql

			
			
			
			v_idComprobante = factu_sql.idfactura
			*id o tipo?
			v_tipoComprobante = VAL(factu_sql.codAfip)
			
			*Tipo doc = 80, CUIT?
			*¿Que pasa si es consumidor final?

			v_tipoDocCliente= factu_sql.tipodoc
			v_nroDocCliente	= factu_sql.cuit
			

*!*				IF factu_sql.tipodoc = '80'
*!*					v_tipoDocCliente = '80'
*!*					v_nroDocCliente = factu_sql.cuit
*!*				ELSE 
*!*					IF factu_sql.tipodoc = '99'
*!*						v_tipoDocCliente = '99'
*!*						v_nroDocCliente = factu_sql.cuit
*!*					ELSE
*!*						MESSAGEBOX("El tipo de cocumento no es CUIT ",0+48+0,"Error")
*!*					    
*!*					    v_compCargado =.F.
*!*					ENDIF 
*!*					
*!*					
*!*				ENDIF 
			
			v_fechaComprobante = factu_sql.fecha
			v_importeNeto = factu_sql.neto
			
			*** OPERACION EXCENTA???
			v_importeOpEx = 0
			*Tratamiento de impuestos
			IF factu_sql.operexenta = "S"
				v_importeOpEx = 0
			ELSE
			
			ENDIF 
			

*!*				SELECT * FROM factImp_sql  INTO TABLE .\factImp

	SET ENGINEBEHAVIOR 70  &&habilitará el comportamiento de Visual FoxPro 7. 
		SELECT *, SUM(importe) as impTot, SUM(neto) as netoTot FROM factImp_sql GROUP BY impuesto  INTO TABLE .\factImp
			
			 
			 
	SET ENGINEBEHAVIOR 90  &&habilitará el comportamiento de Visual FoxPro 9. 
			
			v_importeTotalComp = factu_sql.total
			v_idMoneda = "PES"
			v_cotizacionMoneda = 1
		*Concepto se refiere a:
		*1- Productos
		*2- Servicios
		*3- Productos y servicios
			v_concepto = _SYSCONCEPTOAFIP
			v_ptoVta = factu_sql.puntov 

			v_1 =	loBasicHttpBinding_IServicio.setIDComprobante(v_idComprobante)

			v_2=	loBasicHttpBinding_IServicio.setTipoComprobante(v_tipoComprobante)

			v_3=	loBasicHttpBinding_IServicio.setDocTipoClienteComprobante(v_tipoDocCliente)

			v_4=		loBasicHttpBinding_IServicio.setNroDocClienteComprobante(ALLTRIM(v_nroDocCliente))

			v_5=		loBasicHttpBinding_IServicio.setFechaComprobante(ALLTRIM(v_fechaComprobante))
				
			 
			
			v_totalIVA = 0
			v_totalTributo = 0
			SELECT factImp
			GO TOP
			DO WHILE  NOT EOF()
				
				v_impuesto = factImp.impuesto
				v_detalle  = factImp.detalle
*!*					v_importe  = factImp.importe
*!*					v_neto	   = factImp.neto
				v_importe	= factImp.impTot
				v_neto		= factImp.netoTot
				v_codAfip  = VAL(ALLTRIM(factImp.codigoafip))
				v_tipoAfip = factImp.tipoAfip
				v_detAfip  = factImp.detAfip

				DO case
				
					CASE v_tipoAfip = "IVA"

						resp = loBasicHttpBinding_IServicio.agregarAlicIva(v_codAfip,v_neto,v_importe)
					
						IF resp = .F.
							MESSAGEBOX("Error al cargar alicuota IVA",0+48+0,"Error")
						
						ELSE
							v_totalIVA = v_totalIVA + v_importe
					
						ENDIF 
						
						
					CASE v_tipoAfip = "TRIBUTO"
					**REVISAR ALICUOTA (0) EN TRIBUTO 

						resp = loBasicHttpBinding_IServicio.agregarTributo(v_codAfip, 0, v_neto, v_detAfip, v_importe)
					
						IF resp = .F.
							MESSAGEBOX("Error al cargar el TRIBUTO",0+48+0,"Error")
						
						ELSE
							v_totalTributo = v_totalTributo + v_importe
					
						ENDIF 
					
				
				ENDCASE 
				
				
			
				SELECT factImp
				SKIP 1
			ENDDO  

				v_importeTributo = v_totalTributo
				v_importeIva = v_totalIVA

					v_6=		loBasicHttpBinding_IServicio.setImporteNetoComprobante(v_importeNeto)

			v_7=		loBasicHttpBinding_IServicio.setImporteOpExComprobante(v_importeOpEx)

			v_8=		loBasicHttpBinding_IServicio.setImporteTributoComprobante(v_importeTributo)

			v_9=		loBasicHttpBinding_IServicio.setImporteIvaComprobante(v_importeIva)

			v_10 = 		loBasicHttpBinding_IServicio.setImporteTotalComprobante(v_importeTotalComp)
			

			v_11=		loBasicHttpBinding_IServicio.setIDMonedaComprobante(ALLTRIM(v_idMoneda))

			v_12=		loBasicHttpBinding_IServicio.setCotizacionMonedaComprobante(v_cotizacionMoneda)

			v_13=		loBasicHttpBinding_IServicio.setConceptoComprobante(v_concepto)

			v_14 =			loBasicHttpBinding_IServicio.setPtoVtaComprobante(v_ptoVta)

			v_estadoComp =	loBasicHttpBinding_IServicio.comprobanteCargado()
			
					
			
			IF v_estadoComp = .T.
			
				v_compCargado =.T.
			ELSE
			
			    v_compCargado =	.F.

			ENDIF 

		ELSE
			  MESSAGEBOX("El servicio de autorización no está Iniciado",0+48+0,"Error")

			    v_compCargado = .F.
		ENDIF 
	CATCH TO loException
		lcErrorMsg="Error: "+TRANSFORM(loException.Errorno)+" - "+loException.Message
		DO CASE
			CASE VARTYPE(loBasicHttpBinding_IServicio)#"O"
				* Handle SOAP error connecting to web service
			CASE !EMPTY(loBasicHttpBinding_IServicio.FaultCode)
				* Handle SOAP error calling method
				lcErrorMsg=lcErrorMsg+CHR(13)+loBasicHttpBinding_IServicio.Detail
			OTHERWISE
				* Handle other error
			ENDCASE
			* Use for debugging purposes
			MESSAGEBOX(lcErrorMsg,0+48+0,"Se produjo un Error")
			v_compCargado = .F.
		FINALLY
	ENDTRY
	RETURN v_compCargado
ENDFUNC 





* FUNCIÓN QUE AUTORIZA EL COMPROBANTE CARGADO EN EL SERVICIO Y QUE SEA EL QUE SE LE INDICA COMO PARÁMETRO
* PARAMETRO: P_IDFACTURA, ID DEL COMPROBANTE A AUTORIZAR
FUNCTION autorizarCompFE
PARAMETERS p_idFactura
	v_idAutorizar = p_idfactura
	v_autorizado = .F.
	v_servicioCargado = .F.
	v_estadoComp = .F.
		v_nro = "0"
		
	
	TRY 

		v_servicioCargado = loBasicHttpBinding_IServicio.servicioIniciado()

		v_estadoComp =	loBasicHttpBinding_IServicio.comprobanteCargado()

		v_fechaComp = loBasicHttpBinding_IServicio.getFechaComprobante()
		
		CATCH TO loException
		lcErrorMsg="Error: "+TRANSFORM(loException.Errorno)+" - "+loException.Message
		DO CASE
		CASE VARTYPE(loBasicHttpBinding_IServicio)#"O"
			* Handle SOAP error connecting to web service
		CASE !EMPTY(loBasicHttpBinding_IServicio.FaultCode)
			* Handle SOAP error calling method
			lcErrorMsg=lcErrorMsg+CHR(13)+loBasicHttpBinding_IServicio.Detail
		OTHERWISE
			* Handle other error
		ENDCASE
		* Use for debugging purposes
		MESSAGEBOX(lcErrorMsg,0+48+0,"Se produjo un Error")
		v_autorizado = .F.
	FINALLY
	ENDTRY

		IF  v_estadoComp  = .T.		

			v_respuesta=loBasicHttpBinding_IServicio.autorizarComprobante(v_idAutorizar)
	
			v_observacion = ""  
		
			v_estado = SUBSTR(v_respuesta,1,1)
			v_obsercacion = ""
			v_error = ""
			v_codError = ""
			IF v_estado = "A"
				*Arpobado
				*RAAAANNNNNNNNCCCCCCCCCCCCCCFFFFFFFF
				v_ptoVta =  SUBSTR(v_respuesta,2,4)
				v_nro =  SUBSTR(v_respuesta,6,8)
				v_cae =  SUBSTR(v_respuesta,14,14)
				v_fechavenc =  SUBSTR(v_respuesta,28,8)
				*FECHA QUE RETORNA ES FECHAVENC?
				v_obsercacion = ""
				v_error = ""
				v_fecha = cftofc(DATE())

				MESSAGEBOX("Comprobante Autorizado: "+ v_ptovta + " - "+v_nro + " CAE: "+v_cae+"Fecha: "+v_fecha,0+64,"Comprobante Autorizado")
			
			
			*** REGISTRO ESTADO AUTORIZADO PARA FACTURAS ELECTRONICAS ***

			
				registrarEstado("facturas","idfactura",v_idAutorizar,'I',"AUTORIZADO")
			
			
			
				*** ACTUALIZO EL NUMERO DEL COMPROBANTE EN FACTURAS
*				DIMENSION lamatriz7(1,2)
				
*				lamatriz7(1,1) = 'numero'
*				lamatriz7(1,2) = ALLTRIM(v_nro)
				
*				p_tipoope     = 'U'
*				p_condicion   = " idfactura = " + ALLTRIM(STR(v_idAutorizar))
*				v_titulo      = " LA MODIFICACIÓN "		
*				p_tabla     = 'facturas'
*				p_matriz    = 'lamatriz7'
*				p_conexion  = vconeccionF
*				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
*				ENDIF  
				
				
				
				*** ACTUALIZO EL MAXIMO NUMERO EN COMPACTIV ***
				
				*Busco el pventa e idcomproba de la factura
*				vconeccionF=abreycierracon(0,_SYSSCHEMA)	
*			
*				sqlmatriz(1)="Select idcomproba, pventa from facturas "
*				sqlmatriz(2)=" where idfactura = "+ ALLTRIM(STR(v_idfactura))
*
*				verror=sqlrun(vconeccionF,"comPvta_sql")
*				IF verror=.f.  
*				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de comprobante y pventa de la factura ",0+48+0,"Error")
*
*				ENDIF 
*				
*				SELECT comPvta_sql
*				GO TOP 
*
*				v_idcomproba 	= comPvta_sql.idcomproba
*				v_pventa		= comPvta_sql.pventa
*				
*				*Actualizo compactiv
*				
*				DIMENSION lamatriz7(1,2)
*				
*				lamatriz7(1,1) = 'maxnumero'
*				lamatriz7(1,2) = ALLTRIM(v_nro)
*				
*				p_tipoope     = 'U'
*				p_condicion   = " idcomproba = " + ALLTRIM(STR(v_idcomproba )) + " and pventa = "+ALLTRIM(STR(v_pventa))
*				v_titulo      = " LA MODIFICACIÓN "		
*				p_tabla     = 'compactiv'
*				p_matriz    = 'lamatriz7'
*				p_conexion  = vconeccionF
*				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*				    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
*				ENDIF  
							
			ELSE

				IF v_estado = "R"
					*Rechazado
					v_respuesta =  SUBSTR(v_respuesta,2)
					MESSAGEBOX("Comprobante Rechazado: "+ v_respuesta,0+48+0,"Comprobante Rechazado")
					v_ptoVta = ""
					v_nro = "0"
					v_cae = ""
					v_fechavenc =""
					
					*¿La respuesta va en error u observacion¡?
					v_error = ""
					v_observacion  = V_respuesta 
					*¿Falta codigo de error?
					v_codErro = ""
						
					*** REGISTRO ESTADO AUTORIZADO PARA FACTURAS ELECTRONICAS ***

					
						
						registrarEstado("facturas","idfactura",v_idAutorizar,'I',"RECHAZADO")
					 
				ELSE
					*Indefinido
					MESSAGEBOX("Respuesta desconocida",0+48+0,"Error al Autorizar")

				ENDIF 
			ENDIF 
			
				
			
			*** Guardar datos en facturasFe
			DIMENSION lamatriz8(13,2)
			
			v_idfe = maxnumeroidx("idfe","I","facturasfe",1)
			
			lamatriz8(1,1)='idfe'
			lamatriz8(1,2)= ALLTRIM(STR(v_idfe))
			lamatriz8(2,1)='idfactura'
			lamatriz8(2,2)= ALLTRIM(STR(v_idAutorizar))
			lamatriz8(3,1)='fecha'
			*lamatriz8(3,2)= "'"+ALLTRIM(cftofc(thisform.tb_fecha.Value))+"'"
			*Fecha de la factura
			lamatriz8(3,2)= "'"+ALLTRIM(v_fechaComp)+"'"
			lamatriz8(4,1)='resultado'
			lamatriz8(4,2)= "'"+ALLTRIM(v_estado)+"'"
			lamatriz8(5,1)='caecesp'
			lamatriz8(5,2)= "'"+ALLTRIM(v_cae)+"'"
			lamatriz8(6,1)='caecespven'
			lamatriz8(6,2)= "'"+ALLTRIM(v_fechavenc)+"'"
			*Fecha desde CESP
			lamatriz8(7,1)='caecespfec'
			lamatriz8(7,2)= "''"
			lamatriz8(8,1)='pathpdffe'
			lamatriz8(8,2)= "''"
			* idtipo comprobante afip
			lamatriz8(9,1)='idtipofe'
			lamatriz8(9,2)= "0"
			lamatriz8(10,1)='idtranafip'
			lamatriz8(10,2)= "0"
			*Descripción del error
			lamatriz8(11,1)='observa'
			lamatriz8(11,2)= "'"+ALLTRIM(v_observacion)+"'"
			*Codigo del error
			lamatriz8(12,1)='coderror'
			lamatriz8(12,2)= "'"+v_codError+"'"
				*¿ Que va aca?
			lamatriz8(13,1)='numerofe'
			lamatriz8(13,2)=  v_nro


		*** Creo siempre un nuevo registro para idfe?
			p_tipoope     = 'I'
			p_condicion   = ''
			v_titulo      = " EL ALTA "

			p_tabla     = 'facturasfe'
			p_matriz    = 'lamatriz8'
			p_conexion  = vconeccionF
			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
			    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
			    
			    v_autorizado =.F.
			ENDIF  
		
				v_autorizado =.T.
		
		ELSE
		
			MESSAGEBOX("El servicio no está iniciado o el comprobante no está cargado",0+48+0,"Error")
			    
			v_autorizado =.F.
		
		
		ENDIF 
		
	RETURN v_autorizado  

ENDFUNC 

* FUNCIÓN PARA AUTORIZAR COMPROBANTES
* PARAMETROS: P_PUNTOVTA, PUNTO DE VTA DEL COMPROBANTE; P_IDFACTURA, ID DEL COMPROBANTE A AUTORIZAR
FUNCTION autorizarFE
PARAMETERS p_puntoVta, p_idFactura

v_puntoVta = p_puntoVta
v_idfactura= p_idFactura
v_autorizar = .F.

	TRY 


	v_servicioCargado = loBasicHttpBinding_IServicio.servicioIniciado()
	
	*v_estadoComp =	loBasicHttpBinding_IServicio.comprobanteCargado()

		IF v_servicioCargado  = .F.
		
			*El servicio no está cargado
			*Intenta cargar
			v_servicioCargado = cargarServicioFE(v_puntoVta)
			
			IF v_servicioCargado  = .F.
				*Comprueba y no está cargado
				MESSAGEBOX("El servicio para autorizar comprobantes electrónicos no está disponible",0+48+0,"Error al autorizar")
				v_autorizar = .F.
			ENDIF  
			

		ENDIF 
	CATCH TO loException
			lcErrorMsg="Error: "+TRANSFORM(loException.Errorno)+" - "+loException.Message
			DO CASE
			CASE VARTYPE(loBasicHttpBinding_IServicio)#"O"
				* Handle SOAP error connecting to web service
			CASE !EMPTY(loBasicHttpBinding_IServicio.FaultCode)
				* Handle SOAP error calling method
				lcErrorMsg=lcErrorMsg+CHR(13)+loBasicHttpBinding_IServicio.Detail
			OTHERWISE
				* Handle other error
			ENDCASE
			* Use for debugging purposes
			MESSAGEBOX(lcErrorMsg,0+48+0,"Se produjo un Error")
			v_autorizar = .F.
		FINALLY
	ENDTRY	
		
		IF v_servicioCargado = .T.
			***COMPRUEBO QUE EL COMPROBANTE NO ESTÉ AUTORIZADO
	
			vconeccion=abreycierracon(0,_SYSSCHEMA)	
				
				sqlmatriz(1)="Select * from facturasfe "
				sqlmatriz(2)=" where idfactura = "+ ALLTRIM(STR(v_idfactura))

				verror=sqlrun(vconeccion,"factufe_sql")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la facturasFE",0+48+0,"Error")
				    v_autorizar = .F.
				ELSE
				
					SELECT factufe_sql
					GO TOP 
					
					DO WHILE NOT EOF()
						
						v_resultado = factufe_fe.resultado
						v_caecesp 	= factufe_fe.caecesp
						
						IF v_resultado = "A" OR v_caecesp <> ""
						
							MESSAGEBOX("El comprobante ID: "+ALLTRIM(STR(v_idfactura))+" ya se encuentra autorizado",0+48+0,"Error al autorizar")
							v_autorizar = .F.
							RETURN v_autorizar
						ENDIF 
						
						SELECT factu_fe
						SKIP 1
					
					ENDDO 
				ENDIF 


			*Carga el comprobante en el servicio para autorizar
			*thisform.cargarcomprobantefe


				
			v_comprobanteCargado = cargarcompFE(v_idfactura)
			IF v_comprobanteCargado = .t.
					*Intenta autorizar el comprobante cargado en el servicio
				*thisform.autorizarcomprobantefe


				v_comprobanteAutorizado = autorizarCompFE(v_idfactura)
				
				IF v_comprobanteAutorizado  = .T.
				
					v_autorizar = .T.
					
					
					
					
					
				ELSE
					MESSAGEBOX("Ha Ocurrido un Error al autorizar el comprobante en el servicio ",0+48+0,"Error")
				    
				    v_autorizar = .F.
				
				ENDIF 
				
				
			ELSE

			    MESSAGEBOX("Ha Ocurrido un Error al cargar el comprobante en el servicio ",0+48+0,"Error")
			    
			    v_autorizar = .F.
			
			ENDIF 
		ENDIF 

			

		

	RETURN v_autorizar

	

ENDFUNC 

* FUNCIÓN PARA IMPRIMIR UNA FACTURA (COMPROBANTES DE LA TABLA FACTURA: FACTURA, NC, ND)
* PARAMETROS: P_IDFACTURA, P_ESELECTRONICA
FUNCTION imprimirFactura
PARAMETERS p_idFactura, p_esElectronica


	v_idfactura = p_idFactura
	v_esElectronica = p_esElectronica 

	IF v_idfactura > 0
		
		*** Busco los datos de la factura y el detalle
		IF v_esElectronica  = .T.

			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

			sqlmatriz(1)=" Select f.*,d.*,fe.*,c.*,v.*,fe.numerofe as numFac,c.detalle as detIVA, v.nombre as nomVend,ca.puntov,ti.detalle as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP "
			sqlmatriz(2)=" from facturas f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(3)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
			sqlmatriz(4)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactu d on f.idfactura = d.idfactura "
			sqlmatriz(5)=" left join facturasfe fe on f.idfactura = fe.idfactura left join condfiscal c on f.iva = c.iva"
			sqlmatriz(6)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(7)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))+ " and fe.resultado = 'A'"
			
			verror=sqlrun(vconeccionF,"fac_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		
		ELSE
			
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			sqlmatriz(1)="Select f.*,d.*,c.*,v.*,f.numero as numFac, c.detalle as detIVA,ca.puntov,ti.detalle as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP "
			sqlmatriz(2)=" from facturas f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(3)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa  left join puntosventa pv on ca.pventa = pv.pventa  " 
			sqlmatriz(4)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactu d on f.idfactura = d.idfactura "
			sqlmatriz(5)=" left join condfiscal c on f.iva = c.iva"
			sqlmatriz(6)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(7)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"fac_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		
		ENDIF 
		
		
		*** Busco los datos de los impuestos
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			sqlmatriz(1)="Select fi.detalle as detaIMP, fi.neto as netoIMP, fi.razon as razonIMP, fi.importe as importeIMP, ai.tipo as tipoIMP "
			sqlmatriz(2)=" from facturasimp fi" 
			sqlmatriz(3)=" left join impuestos i on fi.impuesto = i.impuesto "
			sqlmatriz(4)=" left join afipimpuestos ai on i.idafipimp = ai.idafipimp "
			sqlmatriz(5)=" where fi.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"impuestos_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		

		SELECT * FROM fac_det_sql INTO TABLE .\factu
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpIVA WHERE ALLTRIM(tipoIMP) = "IVA"
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpTRIB WHERE ALLTRIM(tipoIMP) = "TRIBUTO"
		
		SELECT factu
		
		IF NOT EOF()
		
			ALTER table factu ADD COLUMN codBarra	 C(42)
		
			v_idcomproba = factu.idcomproba
			v_tipoCompAfip	= ALLTRIM(factu.tipcomAFIP)
			
			
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= factu.electro
			v_cuitEmpresa	= _SYSCUIT
			
			IF  ALLTRIM(v_electronica) == "S"
				v_cuitempresa	= ALLTRIM(v_CuitEmpresa)
				
				v_puntoVta		= ALLTRIM(factu.puntov)
				v_fechaVenc_cae	= ALLTRIM(factu.caecespven)
				v_cespcae		= ALLTRIM(factu.cespcae)
				
				v_codBarra		= v_cuitEmpresa+v_tipoCompAfip+"0"+v_puntoVta+v_fechaVenc_cae+v_Cespcae && EL PUNTO DE VENTA DEBE SER DE 5 DIGITOS
				MESSAGEBOX(v_codBarra)
				v_codBarraD 		= calculaDigitoVerif(v_codBarra)
				
				MESSAGEBOX(v_codBarraD)
				
				SELECT factu
				replace ALL codBarra WITH v_codBarraD
								
			ELSE
			
			ENDIF 
			
			DO FORM reporteform WITH "factu;impIva;impTRIB","facturasrc;impIVArc;impTRIBrc",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar la factura para imprimir",0+48+0,"Error al cargar la factura")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la factura ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 


* FUNCIÓN PARA IMPRIMIR RECIBO
* PARAMETROS: P_IDRECIBO
FUNCTION imprimirRecibo
PARAMETERS p_idRecibo


	v_idrecibo = p_idrecibo
	
	IF v_idrecibo > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del recibo
					
				
		
			sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip, e.cuit, dc.iddetacobro, dc.idtipopago, dc.importe as impCobrado, dc.idcuenta, tp.detalle as tipopago, cb.codcuenta "
			sqlmatriz(2)=" from recibos r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba "
			sqlmatriz(3)=" left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom " 
			sqlmatriz(4)=" left join entidades e on r.entidad = e.entidad left join detallecobros dc on r.idcomproba = dc.idcomproba and r.idrecibo = dc.idregistro "
			sqlmatriz(5)=" left join tipopagos tp on dc.idtipopago = tp.idtipopago left join cajabancos cb on dc.idcuenta = cb.idcuenta "
			sqlmatriz(6)=" where r.idrecibo = "+ ALLTRIM(STR(v_idrecibo))

			verror=sqlrun(vconeccionF,"recibo_sql_u")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del recibo",0+48+0,"Error")
			ENDIF
		
		 
		
		
		
		
		

		SELECT * FROM recibo_sql_u INTO TABLE .\recibo
				
		SELECT recibo
		
		IF NOT EOF()
		
			SELECT recibo 
			GO TOP 
			
			v_idcomproba 	= recibo.idcomproba
			*** Busco los datos de los cobros para el recibo
		
				sqlmatriz(1)=" Select c.*, f.numero,f.tipo,f.fecha,f.entidad, f.servicio, f.cuenta, f.nombre, f.apellido,f.cuit , pv.puntov "
				sqlmatriz(2)=" from cobros c left join facturas f on c.idfactura = f.idfactura left join puntosventa pv on f.pventa = pv.pventa "
				sqlmatriz(3)=" where c.idcomproba = " +ALLTRIM(STR(v_idcomproba))+" and c.idregipago = "+ ALLTRIM(STR(v_idrecibo))

				verror=sqlrun(vconeccionF,"cobros_sql_u")
				IF verror=.f.  
				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de cobros relacionados al recibo ",0+48+0,"Error")
				ENDIF
			
		
		
		
			SELECT * FROM cobros_sql_u INTO TABLE .\cobros
			SELECT cobros
			GO TOP 
			
		
		
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




* FUNCIÓN PARA IMPRIMIR UN MOVIMIENTO DE STOCK DE MATERIALES
* PARAMETROS: P_IDMOVISTOCK
FUNCTION imprimirOtMoviStock
PARAMETERS p_idMoviStockP


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


* FUNCIÓN PARA IMPRIMIR UNA Nota de Pedido (COMPROBANTES DE LA TABLA NP)
* PARAMETROS: P_IDNP
FUNCTION imprimirNP
PARAMETERS p_idnp


	v_idnp = p_idnp


	IF v_idnp  > 0
		

		v_imprimeMonto = 0		
		sino = MESSAGEBOX("¿Desea imprimir la NP con montos?",4+48+256,"Imprimir montos")

		IF sino = 6
			v_imprimeMonto	= 1
		
		ELSE
		
			v_imprimeMonto	= 0
		ENDIF 
		
		*** Busco los datos de la factura y el detalle
		
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		

			sqlmatriz(1)=" Select f.*,d.*,c.*,v.*,f.numero as numNP,com.tipo as tipoCom, c.detalle as detIVA, v.nombre as nomVend,ca.puntov, tc.idafipcom, pv.electronica as electro, ifnull(af.codigo,'') as tipcomAFIP,l.nombre as nomLoc, p.nombre as nomProv,e.cuit  "
			sqlmatriz(2)=" from np f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(3)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
			sqlmatriz(4)="  left join ot d on f.idnp = d.idnp "
			sqlmatriz(5)=" left join entidades e on f.entidad = e.entidad left join condfiscal c on e.iva = c.iva"
			sqlmatriz(6)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(7)=" left join localidades l on e.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
			sqlmatriz(8)=" where f.idnp = "+ ALLTRIM(STR(v_idnp))
			
			
			
			
					
			verror=sqlrun(vconeccionF,"np_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la NP",0+48+0,"Error")
			ENDIF
		
	
*!*			
*!*			*** Busco los datos de los impuestos
*!*				vconeccionF=abreycierracon(0,_SYSSCHEMA)	
*!*			
*!*				sqlmatriz(1)="Select fi.detalle as detaIMP, fi.neto as netoIMP, fi.razon as razonIMP, fi.importe as importeIMP, ai.tipo as tipoIMP "
*!*				sqlmatriz(2)=" from facturasimp fi" 
*!*				sqlmatriz(3)=" left join impuestos i on fi.impuesto = i.impuesto "
*!*				sqlmatriz(4)=" left join afipimpuestos ai on i.idafipimp = ai.idafipimp "
*!*				sqlmatriz(5)=" where fi.idfactura = "+ ALLTRIM(STR(v_idfactura))

*!*				verror=sqlrun(vconeccionF,"impuestos_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
*!*				ENDIF
		

		SELECT * FROM np_det_sql INTO TABLE .\np_impr
		
			
		SELECT np_impr
		
		IF NOT EOF()
			SELECT np_impr
			ALTER table np_impr ADD COLUMN imprMonto I
			
			SELECT np_impr
			GO TOP 
			replace ALL imprMonto WITH v_imprimeMonto
			
			SELECT np_impr
			GO TOP 
			
			
			v_idcomproba = np_impr.idcomproba
			v_tipoCompAfip	= ALLTRIM(np_impr.tipcomAFIP)
	
			
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= .F.
			v_cuitEmpresa	= _SYSCUIT
			
*!*				IF  ALLTRIM(v_electronica) == "S"
*!*					v_cuitempresa	= ALLTRIM(v_CuitEmpresa)
*!*					
*!*					v_puntoVta		= ALLTRIM(factu.puntov)
*!*					v_fechaVenc_cae	= ALLTRIM(factu.caecespven)
*!*					v_cespcae		= ALLTRIM(factu.cespcae)
*!*					
*!*					v_codBarra		= v_cuitEmpresa+v_tipoCompAfip+"0"+v_puntoVta+v_fechaVenc_cae+v_Cespcae && EL PUNTO DE VENTA DEBE SER DE 5 DIGITOS
*!*					MESSAGEBOX(v_codBarra)
*!*					v_codBarraD 		= calculaDigitoVerif(v_codBarra)
*!*					
*!*					MESSAGEBOX(v_codBarraD)
*!*					
*!*					SELECT factu
*!*					replace ALL codBarra WITH v_codBarraD
*!*									
*!*				ELSE
*!*				
*!*				ENDIF 
			
			DO FORM reporteform WITH "np_impr","npcr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar la NP  para imprimir",0+48+0,"Error al cargar la NP")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar la NP ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 




FUNCTION compruebaCajaReca

*** Controlo que se haya seleccionado una caja de recaudación 

IF _SYSCAJARECA = 0 && No hay caja seleccionada, pide caja

	v_idcajareca = 0
	
	DO FORM selectcajareca  TO v_idcajareca
	
	IF v_idcajareca > 0
	
		_SYSCAJARECA = v_idcajareca
	ENDIF 

ENDIF 


ENDFUNC 

* ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO
* PARAMETROS: P_idComp: id comprobante; P_idReg: ID del registro
FUNCTION guardaCajaRecaH 
PARAMETERS p_idComp, p_idReg
				
		v_idcajarecaudah = maxnumeroidx("idcajareh","I","cajarecaudah",1)

		v_idcajareca 	= _SYSCAJARECA
		v_usuario		= _SYSUSUARIO
		v_idcomproba	= p_idComp
		v_idregicomp	=  p_idReg

		DIMENSION lamatriz3(5,2)
		
			
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
		
			
		p_tipoope     = 'I'
		p_condicion   = ''
		v_titulo      = " EL ALTA "
		p_tabla     = 'cajarecaudah'
		p_matriz    = 'lamatriz3'
		p_conexion  = vconeccionF
		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_numero)),0+48+0,"Error")
		    RETURN .F.
		ENDIF	
	
		RETURN .T.

ENDFUNC 


*!*	 *** COPIAR ARCHIVOS ***
*!*	** PARAMETROS: p_docu: Archivo original; p_pathn: Nueva ubicación; p_codigo: código para diferenciar, p_viejo: Ubicación Origen
*!*	FUNCTION copydocu
*!*		PARAMETERS p_docu, p_pathn, p_codigo, p_viejo
*!*		
*!*		j = LEN(ALLTRIM(p_docu))
*!*		LON = J
*!*		DO WHILE ! (SUBSTR(p_docu,j,1) == "\") AND ! (ALLTRIM(p_docu) == "") AND j > 0
*!*			j = j - 1
*!*		ENDDO 

*!*		IF !(ALLTRIM(p_docu) == "") AND J > 0 THEN 
*!*			viejo_directorio = LOWER(SUBSTR(p_docu,1,J))	
*!*		ENDIF 

*!*		IF !(ALLTRIM(p_docu) == "") THEN 
*!*			a_archivo = LOWER(ALLTRIM(p_codigo)+"_"+ALLTRIM(p_viejo))
*!*		ENDIF 
*!*		
*!*		
*!*		nuevo_completo   = ALLTRIM(p_pathn)+"\"+ALLTRIM(a_archivo)
*!*		viejo_completo   = LOWER(ALLTRIM(p_docu))
*!*		
*!*		IF ALLTRIM(UPPER(viejo_completo))==ALLTRIM(UPPER(nuevo_completo)) THEN 
*!*			* El Archivo ya esta en el directorio de la red
*!*		ELSE 
*!*				v_var = 0	
*!*				new_nuevo_completo = ALLTRIM(nuevo_completo)
*!*				DO WHILE FILE(new_nuevo_completo) = .t.
*!*					v_var = v_var + 1
*!*					new_nuevo_completo = ALLTRIM(SUBSTR(nuevo_completo,1,(LEN(ALLTRIM(nuevo_completo))-4))+ALLTRIM(STR(v_var))+SUBSTR(nuevo_completo,(LEN(ALLTRIM(nuevo_completo))-3)))
*!*				ENDDO 
*!*				nuevo_completo = ALLTRIM(new_nuevo_completo)
*!*				v_ejecutar = "COPY FILE '"+ALLTRIM(viejo_completo)+"' TO '"+ALLTRIM(nuevo_completo)+"'"
*!*				MESSAGEBOX(v_ejecutar)
*!*				&v_ejecutar				
*!*		ENDIF

*!*		j = LEN(ALLTRIM(nuevo_completo))
*!*		LON = J
*!*		DO WHILE ! (SUBSTR(nuevo_completo,j,1) == "\") AND ! (ALLTRIM(nuevo_completo) == "") AND j > 0
*!*			j = j - 1
*!*		ENDDO 

*!*		a_archivo = ""
*!*		IF !(ALLTRIM(nuevo_completo) == "") THEN 
*!*			a_archivo = ALLTRIM(LOWER(SUBSTR(nuevo_completo,J+1,LON - J + 1)))
*!*		ENDIF 
*!*		
*!*	RETURN a_archivo
*!*	ENDFUNC 

*** Función que recibe un numero decimal y retorna el RGB equivalente, en una cadena de texto
FUNCTION decimalARGB
PARAMETERS p_numDecimal

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




*---------------------------------------------
* Función que encripta una cadena
* Parámetros:
*    tcCadena - Cadena a encriptar
*    tcLlave - Llave para encriptar (Debe ser la misma para Desencriptar)
*    tlSinDesencripta - .F. para proceso que se puede usar Desencripta
*       Los textos encriptados con este tlSinDesencripta en .T. no se pueden
*       desencriptar, ya que el mecanismo de encriptamiento utilizado
*       produce perdida de informacion que impide la inversion del proceso
* Retorno: Caracter (el doble de largo que el texto pasado)
*---------------------------------------------
FUNCTION Encripta(tcCadena, tcLlave, tlSinDesencripta)
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

*---------------------------------------------
* Función que desencripta una cadena encriptada
* Parámetros:
*    tcCadena - Cadena a desencriptar
*    tcLlave - Llave para desencriptar (Debe ser la misma de Encriptar)
* Retorno: Caracter (la mitad de largo que el texto pasado)
*---------------------------------------------
FUNCTION Desencripta(tcCadena, tcLlave)
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

*---------------------------------------------
* Función usada por Encripta y Desencripta
*---------------------------------------------
FUNCTION GetClaves(tcLlave, tnClaveMul, tnClaveXor)
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

*---------------------------------------------
* Función que registra los estados en OtEstadosOt
* Parámetros:
*    p_idot - IdOT que se va a registrar el estado
*    p_idestado - IdEstado a registrar
* Retorno: True o False en caso que se registre correctamente o no
*---------------------------------------------
FUNCTION RegistraEstadoOt
PARAMETERS p_idot, p_idestado

	
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
* calcula la cantidad de horas entre una hora de inicio y una de finalizacion
* formato en el que debe recibir los parametros en tipo de datos caracter:
*		'AAAAMMDDHH:MM:SS'
* recibe dos parametros de igual formato : HORAINICIO Y HORAFIN
* 
* retorna la cantidad de horas minutos y segundo en formato caracter
* transcurridos desde la fecha/hora de inicio a la de fin
*		'HHH:MM:SS'
*
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
	
	retorno = (STRTRAN((STR(v_horast,4))+':'+(STR(v_minutost,2))+':'+(STR(v_segundost,2)),' ','0'))
	RETURN retorno 
ENDFUNC 


FUNCTION SUMAHORAS
PARAMETERS P_HORA1 , P_HORA2
* suma las horas que recibe como parametro HORA1 Y HORA2
* el formato en el que recibe es de tipo caracter
*		'HHHH:MM:SS'
* devuelve el valor acumulado de horas en el mismo formato
	
	v_sig_h1= SUBSTR(ALLTRIM(p_hora1),1,1)
	v_sig_h2= SUBSTR(ALLTRIM(p_hora2),1,1)

	v_hora1 = ALLTRIM((STRTRAN(STRTRAN(STRTRAN(p_hora1,'-','0'),' ','0'),':',''))+'00000000')
	v_hora1 = SUBSTR(v_hora1,IIF(LEN(v_hora1)=16,1,2),8)

	v_hora2 = ALLTRIM((STRTRAN(STRTRAN(STRTRAN(p_hora2,'-','0'),' ','0'),':',''))+'00000000')
	v_hora2 = SUBSTR(v_hora2,IIF(LEN(v_hora2)=16,1,2),8)

	v_hora1_MS	= INT(VAL(SUBSTR(v_hora1,1,4)))*3600+INT(VAL(SUBSTR(v_hora1,5,2)))*60+INT(VAL(SUBSTR(v_hora1,7,2)))
    v_multi = IIF(v_sig_h1='-',-1,1)
	v_hora1_MS  = v_hora1_MS * v_multi
	v_hora2_MS	= INT(VAL(SUBSTR(v_hora2,1,4)))*3600+INT(VAL(SUBSTR(v_hora2,5,2)))*60+INT(VAL(SUBSTR(v_hora2,7,2)))
    v_multi = IIF(v_sig_h2='-',-1,1)
	v_hora2_MS  = v_hora2_MS * v_multi
	V_horat_MS	= (V_hora1_MS + v_hora2_MS)/3600

	
	V_sig_horat_MS = IIF(V_horat_MS>=0,'','-')

	
	V_horat_MS 		= ABS(V_horat_MS)
	v_horasMST		= INT(V_horat_MS)
	v_minutoMST 	= INT((V_horat_MS - v_horasMST)*60)
	v_segundMST		= (((V_horat_MS - v_horasMST)*60) - v_minutoMST )*60
	

	retorno = V_sig_horat_MS+(STRTRAN((STR(v_horasMST,4))+':'+(STR(v_minutoMST ,2))+':'+(STR(v_segundMST,2)),' ','0'))
*!*		retorno = STRTRAN(retorno,'-0','-')

	RETURN retorno 
ENDFUNC 




FUNCTION IPAddress
PARAMETERS pdato 
* Parametro pdato
*		 = 1 devuelve la ip local del equipo
*		 = 2 devuelve Nombre del host
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

	v_error = .f.
	ON ERROR v_error = .t.
	oWMI = getobject("winmgmts:")
	ON ERROR 
	IF !v_error THEN 

		oAdapters = oWMI.ExecQuery("Select * from Win32_NetworkAdapterConfiguration where IPEnabled=True")
		ipadd = ""
		hostn = ""
		for each oAdapter in oAdapters
			if not isnull(oAdapter.ipaddress)
				for each cAddress in oAdapter.ipaddress
					IF ATC('.',cAddress)>0 AND EMPTY(ipadd) THEN 
						ipadd = oAdapter.ipaddress
						hostn  = oAdapter.DNSHostName
					ENDIF 
				NEXT 
			endif
		NEXT  
		
		DO CASE 
			CASE pdato = 1 
				retorno = ipadd
			CASE pdato = 2
				retorno = hostn
			OTHERWISE 
				retorno = ''
		ENDCASE 
		RELEASE oWMI
	ELSE
		retorno = ''
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

FUNCTION obtienegrupo
PARAMETERS par_idtipogrupo, par_idgrupo , par_alias

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
		sqlmatriz(1)=" select concat_ws('  '" 
		sqlmatriz(3)= " ) as miembros , "+ALLTRIM(grupotipocampo_sql.campo)+" as idmiembro, 'N' as pertenece from "+ALLTRIM(grupotipocampo_sql.tabla)+" "
		
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




*---------------------------------------------
* Función que retorna el nombre del campo clave de la tabla pasada como parámetro
* Parámetros:
*    p_nomTabla: nombre de la tabla
* Retorno: Retorna el nombre del campo clave de la tabla. vacio en caso de no encotrarlo
*---------------------------------------------

FUNCTION getIdTabla
PARAMETERS p_nomTabla
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


** SEPARA CARACTERES BUSCADOS Y RETORNA VERDADERO O FALSO 0 O 1
FUNCTION ATCF 
PARAMETERS c_buscado, c_buscaren
IF !EMPTY(c_buscado) then 
	vfiltra01 = 0
	c_buscado 	= UPPER(c_buscado)
	c_buscaren 	= UPPER(c_buscaren)
	
	ALINES(cbuscadoarr,c_buscado,16,"&","#")
	aelementos = ALEN(cbuscadoarr)

	DIMENSION cbuscadof (aelementos,2)
	FOR i= 1 TO aelementos
		cbuscadof(i,2) = IIF(ATC("#",ALLTRIM(cbuscadoarr(i)))>0,'+',IIF(ATC("&",ALLTRIM(cbuscadoarr(i)))>0,'*','+'))
		cbuscadoarr(i)=STRTRAN(STRTRAN(cbuscadoarr(i),'#',""),"&","")
	ENDFOR 

	FOR i=1 TO aelementos
		vfiltra001 = IIF(ATC(ALLTRIM(cbuscadoarr(i)),c_buscaren)>0,'1','0')
		cbuscadof(i,1)=vfiltra001
	ENDFOR 
	vformula = ""
	FOR i=1 TO aelementos
		vformula = vformula+cbuscadof(i,1)+cbuscadof(i,2)
	ENDFOR 
	vformula = vformula +'+0'  
	vfiltra01 = &vformula
	RELEASE cbuscadoarr , cbuscadof
	RETURN vfiltra01
ELSE	
	RETURN 1
ENDIF 
ENDFUNC 



* FUNCION DE BUSQUEDA DE REPORTES Y SELECCION DE ACUERDO AL PARAMETRO APLICADO.

FUNCTION fselectreporte 
PARAMETERS pvar_paramrepo
	****************************************
	v_paramRepo = pvar_paramrepo
	pvar_retorno = ""

	IF TYPE("v_paramRepo") = "N"
		*** Si el parametro es un NUMERO, el nùmero es el idComproba

		vconeccion=abreycierracon(0,_SYSSCHEMA)	

		sqlmatriz(1)="select r.idreporte, r.nombre, r.descripcion as descrip, co.predeterminado as predet from comprorepo co "
		sqlmatriz(2)=" left join reportesimp r on co.idreporte = r.idreporte "
		sqlmatriz(3)=" where co.idcomproba = "+ALLTRIM(STR(v_paramRepo))
		verror=sqlrun(vconeccion,"repos_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Entidades ",0+48+0,"Error")
		    RETURN 
		ENDIF 
		
	ELSE

		IF TYPE("v_paramRepo") = "C"
		*** Si el paràmetro es un CARACTER, se corresponde con el nombre del formulario y metodo

			vconeccion=abreycierracon(0,_SYSSCHEMA)	

			sqlmatriz(1)="select r.idreporte, r.nombre, r.descripcion as descrip, co.predeterminado as predet from comprorepo co "
			sqlmatriz(2)=" left join reportesimp r on co.idreporte = r.idreporte "
			sqlmatriz(3)=" where co.codigoImpre= '"+ALLTRIM(v_paramRepo)+"'"
			
			verror=sqlrun(vconeccion,"repos_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de Reportes ",0+48+0,"Error")
    		    RETURN 

			ENDIF 
		ELSE
			MESSAGEBOX("No existe un tipo de reporte para el parametro",0+48+0,"Error al obtener el nombre del reporte")
		    RETURN 

		ENDIF 
	ENDIF 

****************************************
		SELECT repos_sql
		GO TOP 
		IF  EOF()
			MESSAGEBOX("No existe un tipo de reporte para el parametro",0+48+0,"Error al obtener el nombre del reporte")
			RETURN 
		ELSE
			v_cantRegistros = RECCOUNT()

			IF v_cantRegistros = 1

				 *** No tiene que seleccionar reportes, imprime con el que tiene predeterminado
				pvar_retorno = repos_sql.nombre
			
*!*					SELECT repos_sql
*!*					USE IN repos_sql 
			*thisform.cmdAceptar.Click
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
***			codarbol c(15)
***			tiporeg c(1) 'M'=Miembro, 'G'=Grupo 'T'=Tipo Grupo
FUNCTION obtieneallgrupos
PARAMETERS  para_aliasd
p_aliasreto  = ""

	vconeccionF=abreycierracon(0,_SYSSCHEMA)	
	
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
		MESSAGEBOX("No hay Grupos para Seleccionar...")
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
	ALTER table grupotmp0 ADD codarbol c(15)
	ALTER table grupotmp0 ADD codpadre c(15)
	GO TOP 
	replace ALL codarbol WITH SUBSTR(ALLTRIM(STR((idtipogrup+1000),4)),2,3)+SUBSTR(ALLTRIM(STR((idgrupo+1000),4)),2,3)+ ;
								ALLTRIM(REPLICATE('0',(9-LEN(ALLTRIM(idmiembro))))+ALLTRIM(idmiembro)), ;
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
	USE IN grupotmp1
	USE IN gruposall_sql 
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


*---------------------------------------------
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
*---------------------------------------------

FUNCTION registrarEstado
PARAMETERS p_nomTabla,p_nomCampo,p_indice,p_tipoInd,p_estado

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

	* me desconecto	
	=abreycierracon(vconeccionE,"") 
	RETURN .T.
ENDFUNC 



** AGREGA EL CAMPO busquedag para poder realizar busquedas y filtrados con el objeto de grupos

FUNCTION generabusquedag
	PARAMETERS para_tabla, para_string
	SELECT &para_tabla
	ALTER table &para_tabla ADD COLUMN busquedag c(254)
	GO TOP 
	replace ALL busquedag WITH &para_string
RETURN 

*---------------------------------------------------------------------------
* Filtrado de grupos en tablas Locales, recibe como parametro una tabla local 
*  y aplica el filtro de grupo a las tablas si está seleccionada la opcion de filtrados
*  en el objeto de grupos
*------------------------------------------------------------------------------
FUNCTION filtragrupos
	PARAMETERS pf_tbbuscador, pf_tablas 
	
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

	vcan_tablas=alines( arraytablas, pf_tablas, ";")
	IF vcan_tablas > 0 THEN 
		FOR _ifg = 1 TO vcan_tablas
			SELECT &arraytablas(_ifg)
			&EJE3 
			GO TOP	
		ENDFOR 
	ENDIF 
	RELEASE arraytablas 
	
ENDFUNC 

*-------------------------------------------------------------
* Oculta o muestra la tabla de seleccion de grupos del sistema
*-------------------------------------------------------------
FUNCTION showhidetoolbargrupo
	IF toolbargrupos.visible THEN 
		toolbargrupos.hide
		toolbargrupos.pageayuda.grupos.filtragrupos.value = .f.
	ELSE 
		toolbargrupos.show 	
		toolbargrupos.pageayuda.grupos.filtragrupos.value = .t.
	ENDIF 
ENDFUNC 



*---------------------------------------------
* Función que retorna el IdEstadoR del último estado según los parámetros pasados en la tabla estadosreg
* Parámetros:
*   p_nomTabla: nombre de la tabla
*	p_nomCampo: nombre del campo indice de la tabla
*	p_indice: valor del campo indice
*	p_tipoInd: tipo de valor del campo indice
**
* Retorno:
*	True: si no se produjeron errores, False en otro caso
*---------------------------------------------

FUNCTION obtenerEstado 
PARAMETERS p_nomTabla,p_nomCampo,p_indice,p_tipoInd

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


*---------------------------------------------------------------
* Ejecuta los formularios controlando que no estén activos
* Utilizado para evitar activar varias veces el mismo formulario
*---------------------------------------------------------------
FUNCTION ejecutaform 
PARAMETERS par_form, par_varpasadas
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


*---------------------------------------------------------------
* Función para obtener el campo indice de una tabla de la bd
* Parametros: p_Tabla: Nombre de la tabla consultada
* Retorno: Retorna el nombre del campo indice de la tabla consultada
*---------------------------------------------------------------
FUNCTION obtenerCampoIndice
PARAMETERS p_tabla


	vconeccionF = abreycierracon(0,_SYSSCHEMA)

		v_tabla = p_tabla
		
		sqlmatriz(1)="SHOW COLUMNS FROM "+ALLTRIM(v_tabla)
		verror=sqlrun(vconeccionF,"columnas_sql")
		IF verror=.f.
			MESSAGEBOX("No se puede obtener las columnas del Comprobantes",0+16,"Advertencia")
			RETURN 
		ENDIF 
		SELECT columnas_sql

	
	* me desconecto	
	=abreycierracon(vconeccionF,"")


	SELECT field as campo, key as clave FROM  columnas_sql WHERE key = "PRI" INTO TABLE columnas
	
	SELECT columnas
	GO TOP 
	v_retorno = ""
	
	v_retorno = columnas.campo 
		
	
	RETURN v_retorno

ENDFUNC 



*+ Funcion para el seteo de indices en tablas locales
* recibe como parametros una tabla a ordenar , una tabla con los indices y el valor que debe
* seleccionar para crear el indice. 
* busca en la tabla de orde pa_orden , selecciona el indice y lo crea en pa_tabla
FUNCTION SetearIndice
PARAMETERS pa_tabla, pa_tablaorden, pa_campobus, pa_valorbus, pa_camporet, pa_tag

	var_indice = ALLTRIM(BUSCAVALORDB(pa_tablaorden,pa_campobus,pa_valorbus, pa_camporet,1))
	IF !isnull(var_indice)  THEN 
		SELECT &pa_tabla
		SET SAFETY OFF 
		INDEX on &var_indice TAG &pa_tag  
		RETURN pa_tag
	ENDIF 
	RETURN ""
ENDFUNC 

*---------------------------------------------------------------

* LLama al Menu de Configuracion para Setearlo pasando como parametros

* los datos del Esquema seleccionado en el Sistema Seleccionado

*---------------------------------------------------------------

FUNCTION ejecutarexe

PARAMETERS param_path ,param_executa

 

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

*/-------------------------------------------------------------
* Setea los indices en las grillas pasadas como parametros
* Recibe como parametros la Grilla con todo el nombre gerarquico 
* es decir el formulario y la grilla.
* como segundo parametro el Orden de la columna que esta solicitando Indexar
* Finalmente ordenea de acuerdo a los parametros y setea la grilla con informacion
* para luego continuar con el orden.
* Para el Orden del Indice Ascentente o Descendente , la grilla debe tener seteado en 
* el campo StatusBarText= "A" = "ASCENDING" u "D" = "DESCENDING"
*/-------------------------------------------------------------
FUNCTION setidxgrilla
PARAMETERS p_grilla, p_columna, p_header 
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
*/-------------------------------------------------------------
* Seteo de las Grillas de
* Recibe como parametros, el cursor, el nombre de la grilla
* un arreglo con las columnas a a colocar en la grilla
*/-------------------------------------------------------------
FUNCTION seteagrilla
PARAMETERS p_grilla, p_RecordSource, p_matcolumn, p_DynamicColor, p_FontSize

	vcan_column = ALEN(&p_matcolumn,1)

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
			&v_columnxx..Enabled    = &p_matcolumn(_icl,5) && .t. habliltado .f. deshabilitado

		ENDFOR 
	ENDIF 

	&p_grilla..refresh 

RETURN 

ENDFUNC 

*/*****************************************************
*/ Toma en caracteres separados por puntos el valor de codigo
*/ y lo divide de acuerdo al codigo de ENTIDAD-SERVICIO-SUBCODIGO
*/ recibe caracteres y devuelve en valor numerico de acuerdo
*/ al parametro solicitado 1-ENTIDAD  2-SERVICIO  3-SUBCODIGO
*/******************************************************
FUNCTION fcodentidad
PARAMETERS pcodenti, pcual
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



*/-------------------------------------------------------------
* Retorna una cadena de caracteres con la localidad
* Con el siguiente formato: <Localidad> [(<Cod_postal)] [- <Provincia>] [- <Pais>]
* Parametros: 
*	p_idlocalidad I: 	Id de la localidad
*	p_conCod  B:		Booleano indicando si se muestra o no el codigo postal
*	p_conProv B:		Booleano indicando si se muestra o no la provincia
*	p_conPais B:		Booleano indicando si se muestra o no el país
*	
*/-------------------------------------------------------------
FUNCTION consultalocprovpais
PARAMETERS p_idlocalidad,p_conCod, p_conProv, p_conPais

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


*/-------------------------------------------------------------
* Retorna una cadena de caracteres con agregando al final el digito verificador a la cadena pasada como parámetro
* Con el siguiente formato: CCCCCCCCCCCTTTPPPPAAAAAAAAAAAAAAVVVVVVVVD
* Donde: C: CUIT_EMISOR; T: TIPO_COMPROBANTE; P: PUNTO_VENTA; A: CAE; V: FECHA_VTO; D: DIGITO_VERIFICADOR
* Parametros: 
*	p_codigoI: 	Cadena a calcular el digito verificador
* Retorno: Cadena con digito verificador	
*/-------------------------------------------------------------
FUNCTION calculaDigitoVerif
PARAMETERS p_codigo

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


	v_modulo = resE4 % 10
	v_dif = 10 - modulo
	v_digitoVerif = v_dif % 10;

	v_codigo = v_codigo + ALLTRIM(STR(v_digitoVerif))

	RETURN v_codigo


ENDFUNC 


** Función que retorna la cadena pasada como parámetro separada por puntos
FUNCTION separarcadena
PARAMETERS PCADENA
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



*/-------------------------------------------------------------
* Retorna el id del dejercicio economico y el id del Plan de Cuentas
* de acuerdo al ejercicio seleccionado segun la fecha ingresada
* Parametros: 1-Fecha a considerar
*			  2-Condicion devuelta : 0=Devuelve el idejercicio, 1= Devuelve el idplan
*/-------------------------------------------------------------
FUNCTION fejercicioplan
PARAMETERS p_fecha,p_devuelve

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


*/-------------------------------------------------------------
* Retorna un string conteniendo una descripcion del comprobante
* que permite identificarlo univocamente. 
* Parametros: 1-tabla
*			  2-nombre del indice
*			  3-Valor del indice
*/-------------------------------------------------------------
FUNCTION fdescribecompro
PARAMETERS par_tabla,par_nomindice,par_valindice

	v_retornod = ""

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
	sqlmatriz(1)= ALLTRIM(tabladescrip_sql.consulta)
	sqlmatriz(2)=" where "+ALLTRIM(par_tabla)+"."+ALLTRIM(par_nomindice)+" = "+ALLTRIM(STR(par_valindice))
	verror=sqlrun(vconeccionFD,"datoscompro_sql")
	IF verror=.f.
		=abreycierracon(vconeccionFD,"")
		RETURN v_retornod
	ENDIF 
	=abreycierracon(vconeccionFD,"")
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
		
	RETURN v_retornod
ENDFUNC 



* FUNCIÓN PARA IMPRIMIR UN REMITO
* PARAMETROS: P_IDREMITO, P_ESELECTRONICA
FUNCTION imprimirRemito
PARAMETERS p_idremito, p_esElectronica


	v_idremito = p_idremito
	v_esElectronica = p_esElectronica 

	IF v_idremito > 0
		
		*** Busco los datos de la factura y el detalle
		IF v_esElectronica  = .T.

		
		ELSE
			
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			sqlmatriz(1)="Select r.*,d.*,c.*,v.*,r.numero as numRem, c.detalle as detIVA,ca.puntov, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP, l.nombre as nomLoc, p.nombre as nomProv "
			sqlmatriz(2)=" from remitos r left join comprobantes com on r.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
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
		
		ENDIF 
		
	
		SELECT * FROM rec_det_sql INTO TABLE remi
		
		
		SELECT remi
		
		IF NOT EOF()
		
*			ALTER table factu ADD COLUMN codBarra	 C(42)
		
			v_idcomproba = remi.idcomproba
			v_tipoCompAfip	= ALLTRIM(remi.tipcomAFIP)
			
			
			v_codBarra		= ""
			v_codBarraD 	= ""
			v_electronica	= remi.electro
			v_cuitEmpresa	= _SYSCUIT
			
		
			
			DO FORM reporteform WITH "remi","remitoscr",v_idcomproba
			
		ELSE
			MESSAGEBOX("Error al cargar el remito para imprimir",0+48+0,"Error al cargar el remito")
			RETURN 	
		ENDIF 
		
		

	ELSE
		MESSAGEBOX("NO se pudo recuperar el remito ID <= 0",0+16,"Error al imprimir")
		RETURN 

	ENDIF 

ENDFUNC 

**** FUNCIÓN PARA GENERAR AJUSTES DE UN COMPROBANTE
** PARAMETROS: 	P_idtipomov: ID de la tabla tipomstock (Indica el tipo de ajuste a realizar)
***				P_idcomproba: ID de la tabla comprobante (comprobante relacionado al ajuste)
***				P_nomreCampo: Nombre del campo Indice de la tabla asociada al comprobante
***				P_Idregistro: ID de la tabla asociada al comprobante
***				P_TablaDatos: Tabla con los articulos a los que se le hará el ajuste, tiene el siguiente formato: [articulo C(50),cantidad Y,deposito I]
**RETORNO:		.T. o .F. Dependiendo si se realizó el ajuste correctamente o no respectivamente

FUNCTION AjusteComprobante
PARAMETERS p_idtipomov, p_idcomproba,p_nombreCampo,p_idregistro,p_tablaDatos

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
	sqlmatriz(1)=" select * from "+ALLTRIM(v_tabla)+" c left join compactiv cp on c.idcomproba = cp.idcomproba and c.pventa = cp.pventa "
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
	v_pventaC	= comprobante_sql.pventa
	
	
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
	v_puntov	= comprobante_sql.puntov
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
					lamatriz2(10,2)= ALLTRIM(STR(v_deposito))
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
							
								v_etiqueta = maxnumeroidx("etiqueta","I","etiquetas",1)
								
								p_tipoope     = 'I'
								p_condicion   = ''
								v_titulo      = " EL ALTA "
								
								DIMENSION lamatriz3(4,2)
								
								lamatriz3(1,1)='etiqueta'
								lamatriz3(1,2)=ALLTRIM(STR(v_etiqueta))
								lamatriz3(2,1)='fechaalta'
								lamatriz3(2,2)="'"+DTOS(DATE())+"'"
								lamatriz3(3,1)='codigo'
								lamatriz3(3,2)="''"
								lamatriz3(4,1)='articulo'
								lamatriz3(4,2)="'"+ALLTRIM(articulosDatos.articulo)+"'"
								

								p_tabla     = 'etiquetas'
								p_matriz    = 'lamatriz3'
								p_conexion  = vconeccionA
								IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
								    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_etiqueta )),0+48+0,"Error")
								ELSE
								
									*** Creo Asociación Etiqueta - AjusteStockH
										v_idajustestocke = maxnumeroidx("idajustestocke","I","ajustestocke",1)
									
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
									ELSE
									
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
			
		ELSE
			RETURN .F.
		ENDIF 
	ELSE
	
		RETURN .F.
		
	ENDIF 
	

ELSE
	RETURN .F.

ENDIF 

	RETURN .T.
ENDFUNC 



**********************************************************************
**********************************************************************
** Funcion que devuelve el asiento modelo armado a partir de un 
** codigo o modelo de asiento**
FUNCTION GenAstoContable
PARAMETERS par_modelo, par_tabla, par_registro, par_tablaret

	v_indicetabla = getIdTabla(par_tabla) && Obtengo el nombre del campo indice de la tabla
	var_retorno = ""
	**** El Modelo de Asiento Seleccionado ***
	vconeccionATO=abreycierracon(0,_SYSSCHEMA)	

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
	SELECT AstoCuentaA_sql

**********************************************
***	Armado del valor  de las cuentas a imputar 

	SELECT * FROM AstoValorA_sql INTO TABLE .\AstoValorA
	ALTER table AstoValorA ADD importe y
	ZAP 
	SELECT AstoValorA_sql 
	GO TOP 
	
	DO WHILE !EOF() 
		
		sqlmatriz(1)=" Select "+ALLTRIM(AstoValorA_sql.campo)+" as importe from "+ALLTRIM(AstoValorA_sql.tabla)
		sqlmatriz(2)=" where "+v_indicetabla+"  = "+ALLTRIM(STR(par_registro))
			
		verror=sqlrun(vconeccionATO,"tablacampo")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA en el Campo a Imputar de la Tabla Seleccionada ",0+48+0,"Error")
		    =abreycierracon(vconeccionATO,"")
		    RETURN var_retorno
		ENDIF
		
		SELECT tablacampo
		GO top
		DO WHILE !EOF()
			SELECT AstoValorA
			INSERT INTO AstoValorA VALUES (AstoValorA_sql.idastomode, AstoValorA_sql.idastocuen, AstoValorA_sql.idcpoconta, AstoValorA_sql.dh, ;
										   AstoValorA_sql.detalle, AstoValorA_sql.tabla, AstoValorA_sql.campo, AstoValorA_sql.opera, ;
										   AstoValorA_sql.idastoval, tablacampo.importe)
			SELECT tablacampo 
			SKIP 
		ENDDO 
				
		SELECT AstoValorA_sql
		SKIP 
	ENDDO 

	SELECT AstoValorA
	REPLACE ALL importe WITH importe * opera 
	
*****************************************************************
***** Agrupo para obtener el monto final a imputar a cada cuenta
	SET ENGINEBEHAVIOR 70 
	 
	SELECT idastomode, idastocuen, idcpoconta, dh, detalle, SUM(importe) as importe ;
		FROM AstoValorA INTO TABLE AstoValorB ORDER BY idastocuen GROUP BY idastocuen
	
	SET ENGINEBEHAVIOR 90 
	
	SELECT AstoValorB
	
*************************************************************************
** Obtengo el la Cuenta que se deberá imputar ***************************
	SELECT * FROM AstoCuentaA_sql INTO TABLE .\AstoCuentaA
	ALTER table AstoCuentaA ADD valor c(100)
	ZAP 
	SELECT AstoCuentaA_sql 
	GO TOP 
	DO WHILE !EOF() 
		
		sqlmatriz(1)=" Select "+ALLTRIM(AstoCuentaA_sql.campo)+" as valor from "+ALLTRIM(AstoCuentaA_sql.tabla)
		sqlmatriz(2)=" where "+v_indicetabla+"  = "+ALLTRIM(STR(par_registro))
		verror=sqlrun(vconeccionATO,"tablacuenta")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la Cuenta Seleccionada ",0+48+0,"Error")
		    =abreycierracon(vconeccionATO,"")
		    RETURN var_retorno
		ENDIF

		SELECT tablacuenta
		GO top
		DO WHILE !EOF()
			var_valor = IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F'),STR(tablacuenta.valor,12,2),tablacuenta.valor)
			v_incerta = .f.
			DO CASE 
				CASE UPPER(AstoCuentaA_sql.compara)="TODOS"
					v_incerta = .t.
				CASE UPPER(AstoCuentaA_sql.compara)="ENTRE"
					IF ALLTRIM(var_valor) >= ALLTRIM(AstoCuentaA_sql.valor1) AND ALLTRIM(var_valor) <= ALLTRIM(AstoCuentaA_sql.valor2) THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MAYOR"
					IF var_valor > AllTRIM(AstoCuentaA_sql.valor1) THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MAYOR O IGUAL"
					IF var_valor >= AllTRIM(AstoCuentaA_sql.valor1) THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MENOR"
					IF var_valor < AllTRIM(AstoCuentaA_sql.valor1) THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="MENOR O IGUAL"
					IF var_valor <= AllTRIM(AstoCuentaA_sql.valor1) THEN 
						v_incerta = .t.
					ENDIF 
				CASE UPPER(AstoCuentaA_sql.compara)="DISTINTO"
					IF var_valor <> AllTRIM(AstoCuentaA_sql.valor1) THEN 
						v_incerta = .t.
					ENDIF 
			ENDCASE 
			
			SELECT AstoCuentaA
			IF v_incerta = .t. THEN 
				INSERT INTO AstoCuentaA VALUES (AstoCuentaA_sql.idastomode, AstoCuentaA_sql.idastocuen, AstoCuentaA_sql.idcpoconta, AstoCuentaA_sql.dh, ;
										   AstoCuentaA_sql.detalle, AstoCuentaA_sql.tabla, AstoCuentaA_sql.campo, AstoCuentaA_sql.tipo, ;
										   AstoCuentaA_sql.detacpo, AstoCuentaA_sql.valor1, AstoCuentaA_sql.compara, AstoCuentaA_sql.valor2, ;
										   AstoCuentaA_sql.codigocta, AstoCuentaA_sql.tablag, AstoCuentaA_sql.campog, AstoCuentaA_sql.tipog,AstoCuentaA_sql.idcpocontg,var_valor)
			ENDIF 
			SELECT tablacuenta
			SKIP 
		ENDDO 
				
		SELECT AstoCuentaA_sql
		SKIP 
		
	ENDDO 

	 =abreycierracon(vconeccionATO,"")
	 
	 SELECT AstoCuentaA
	 GO TOP 

	 ************* Union de las dos partes que componen el Asiento, ************************************
	 ************* Se Unen el Valor o Importe a Imputar con la Cuenta que recibe la Imputación *********

	 SELECT AVB.idastomode, AVB.idastocuen, AVB.idcpoconta, AVB.dh, AVB.detalle, AVB.importe ,AVB.importe as debe ,AVB.importe as haber , ;
	 		 ACA.codigocta, ACA.valor, ACA.idcpocontg, SPACE(50) as tabla, 10000000000 as registro  ;
	 FROM  AstoValorB AVB left join AstoCuentaA ACA on AVB.idastocuen = ACA.idastocuen ;
	 INTO TABLE AstoFinalA 
	 
	 SELECT AstoFinalA
	 GO TOP 
	 replace ALL debe WITH IIF((((dh='D' AND importe > 0) OR (dh='H' AND importe < 0 ))),ABS(importe),0), haber WITH IIF((((dh='H' AND importe > 0) OR (dh='D' AND importe < 0))),ABS(importe),0), ;
	 			tabla WITH par_tabla, registro WITH par_registro 

	 SELECT  idastomode, codigocta, debe, haber, tabla, registro FROM AstoFinalA INTO TABLE &par_tablaret 
	 COPY TO &par_tablaret DELIMITED WITH ""
	
	 USE IN AstoCuentaA_sql
	 USE IN AstoValorA_sql
	 USE IN AstoCuentaA
	 USE IN AstoValorA
	 USE IN AstoValorB
	 USE IN AstoFinalA
	 USE IN tablacuenta
	 USE IN tablacampo
	 USE IN &par_tablaret 
	 var_retorno = par_tablaret 	 
	 RETURN var_retorno 
	
ENDFUNC 


**** FUNCIÓN PARA GENERAR AJUSTES DE UN COMPROBANTE de PROVEEDOR
** PARAMETROS: 	P_idtipomov: ID de la tabla tipomstock (Indica el tipo de ajuste a realizar)
***				P_idcomproba: ID de la tabla comprobante (comprobante relacionado al ajuste)
***				P_nomreCampo: Nombre del campo Indice de la tabla asociada al comprobante
***				P_Idregistro: ID de la tabla asociada al comprobante
***				P_TablaDatos: Tabla con los articulos a los que se le hará el ajuste, tiene el siguiente formato: [articulo C(50),cantidad Y,deposito I]
***				P_pventa: Pventa relacionado al ajuste que se va a realizar
**RETORNO:		.T. o .F. Dependiendo si se realizó el ajuste correctamente o no respectivamente

FUNCTION AjusteComprobanteProv
PARAMETERS p_idtipomov, p_idcomproba,p_nombreCampo,p_idregistro,p_tablaDatos,p_pventa

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
					lamatriz2(10,2)= ALLTRIM(STR(v_deposito))
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
							
								v_etiqueta = maxnumeroidx("etiqueta","I","etiquetas",1)
								
								p_tipoope     = 'I'
								p_condicion   = ''
								v_titulo      = " EL ALTA "
								
								DIMENSION lamatriz3(4,2)
								
								lamatriz3(1,1)='etiqueta'
								lamatriz3(1,2)=ALLTRIM(STR(v_etiqueta))
								lamatriz3(2,1)='fechaalta'
								lamatriz3(2,2)="'"+DTOS(DATE())+"'"
								lamatriz3(3,1)='codigo'
								lamatriz3(3,2)="''"
								lamatriz3(4,1)='articulo'
								lamatriz3(4,2)="'"+ALLTRIM(articulosDatos.articulo)+"'"
								

								p_tabla     = 'etiquetas'
								p_matriz    = 'lamatriz3'
								p_conexion  = vconeccionA
								IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
								    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo+" "+ALLTRIM(STR(v_etiqueta )),0+48+0,"Error")
								ELSE
								
									*** Creo Asociación Etiqueta - AjusteStockH
										v_idajustestocke = maxnumeroidx("idajustestocke","I","ajustestocke",1)
									
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
									ELSE
									
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
			
		ELSE
			RETURN .F.
		ENDIF 
	ELSE
	
		RETURN .F.
		
	ENDIF 
	

ELSE
	RETURN .F.

ENDIF 

	RETURN .T.
ENDFUNC 


*///////////////////////////////////////////////////////////////
**********************************************************************
** Funcion que devuelve el asiento modelo armado a partir de un 
** codigo o modelo de asiento**
** la funcion devuelve el nombre de la tabla con el asiento si lo pudo armar
** caso contrario devuelve vacio ""
** estructura devuelta .dbf o .txt 
**		idastomode i, codigocta c(30), debe y, haber y, tabla c(30), 
**      registro i ,fecha c(8), idfiltro i, idtipoasi i, idastoe i, idpland, codigo c(22)
*///////////////////////////////////////////////////////////////
FUNCTION GenAstoContable
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
	SELECT AstoCuentaA_sql

**********************************************
***	Armado del valor  de las cuentas a imputar 

	SELECT * FROM AstoValorA_sql INTO TABLE .\AstoValorA
	ALTER table AstoValorA ADD importe y
	ZAP 
	SELECT AstoValorA_sql 
	GO TOP 
	
	DO WHILE !EOF() 
		
		sqlmatriz(1)=" Select "+ALLTRIM(AstoValorA_sql.campo)+" as importe from "+ALLTRIM(AstoValorA_sql.tabla)
		sqlmatriz(2)=" where "+v_indicetabla+"  = "+ALLTRIM(STR(par_registro))
			
		verror=sqlrun(vconeccionATO,"tablacampo")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA en el Campo a Imputar de la Tabla Seleccionada ",0+48+0,"Error")
		    =abreycierracon(vconeccionATO,"")
		    RETURN var_retorno
		ENDIF
		
		SELECT tablacampo
		GO top
		DO WHILE !EOF()
			SELECT AstoValorA
			INSERT INTO AstoValorA VALUES (AstoValorA_sql.idastomode, AstoValorA_sql.idastocuen, AstoValorA_sql.idcpoconta, AstoValorA_sql.dh, ;
										   AstoValorA_sql.detalle, AstoValorA_sql.tabla, AstoValorA_sql.campo, AstoValorA_sql.opera, ;
										   AstoValorA_sql.idastoval, tablacampo.importe)
			SELECT tablacampo 
			SKIP 
		ENDDO 
				
		SELECT AstoValorA_sql
		SKIP 
	ENDDO 

	SELECT AstoValorA
	REPLACE ALL importe WITH importe * opera 
	
*****************************************************************
***** Agrupo para obtener el monto final a imputar a cada cuenta
	SET ENGINEBEHAVIOR 70 
	 
	SELECT idastomode, idastocuen, idcpoconta, dh, detalle, SUM(importe) as importe ;
		FROM AstoValorA INTO TABLE AstoValorB ORDER BY idastocuen GROUP BY idastocuen
	
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
	SELECT AstoCuentaA_sql 
	GO TOP 
	DO WHILE !EOF() 
		
		sqlmatriz(1)=" Select "+ALLTRIM(AstoCuentaA_sql.campo)+" as valor from "+ALLTRIM(AstoCuentaA_sql.tabla)
		sqlmatriz(2)=" where "+v_indicetabla+"  = "+ALLTRIM(STR(par_registro))
		verror=sqlrun(vconeccionATO,"tablacuenta")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la Cuenta Seleccionada ",0+48+0,"Error")
		    =abreycierracon(vconeccionATO,"")
		    RETURN var_retorno
		ENDIF

		SELECT tablacuenta
		GO top
		DO WHILE !EOF()
			var_valor = IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F'),tablacuenta.valor,ALLTRIM(tablacuenta.valor))  
			eje = " var_valor1= "+IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F'),'VAL(ALLTRIM(AstoCuentaA_sql.valor1))','ALLTRIM(AstoCuentaA_sql.valor1)')
			&eje 
					
			eje = " var_valor2= "+IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F'),'VAL(ALLTRIM(AstoCuentaA_sql.valor2))','ALLTRIM(AstoCuentaA_sql.valor2)')
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
					INSERT INTO AstoCuentaA VALUES (AstoCuentaA_sql.idastomode, AstoCuentaA_sql.idastocuen, AstoCuentaA_sql.idcpoconta, AstoCuentaA_sql.dh, ;
										   AstoCuentaA_sql.detalle, AstoCuentaA_sql.tabla, AstoCuentaA_sql.campo, AstoCuentaA_sql.tipo, ;
										   AstoCuentaA_sql.detacpo, AstoCuentaA_sql.valor1, AstoCuentaA_sql.compara, AstoCuentaA_sql.valor2, ;
										   AstoCuentaA_sql.codigocta, AstoCuentaA_sql.tablag, AstoCuentaA_sql.campog, AstoCuentaA_sql.tipog, ;
										   AstoCuentaA_sql.idcpocontg,var_valorinc,var_idpland,var_codigo,var_nombrecta)
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

	 =abreycierracon(vconeccionATO,"")
	 
	 SELECT AstoCuentaA
	 GO TOP 

	 ************* Union de las dos partes que componen el Asiento, ************************************
	 ************* Se Unen el Valor o Importe a Imputar con la Cuenta que recibe la Imputación *********

	 SELECT AVB.idastomode, AVB.idastocuen, AVB.idcpoconta, AVB.dh, AVB.detalle, AVB.importe ,AVB.importe as debe ,AVB.importe as haber , ;
	 		 ACA.codigocta, ACA.valor, ACA.idcpocontg, SPACE(50) as tabla, 10000000000 as registro, '        ' as fecha, ;
	 		 10000000000 as idfiltro, 10000000000 as idtipoasi, 10000000000 as idastoe, ACA.idpland, ACA.codigo, ACA.nombrecta   ;
	 FROM  AstoValorB AVB left join AstoCuentaA ACA on AVB.idastocuen = ACA.idastocuen ;
	 INTO TABLE AstoFinalA WHERE !ISNULL(ACA.idcpocontg)
	 
	 SELECT AstoFinalA
	 GO TOP 
	 replace ALL debe WITH IIF((((dh='D' AND importe > 0) OR (dh='H' AND importe < 0 ))),ABS(importe),0), haber WITH IIF((((dh='H' AND importe > 0) OR (dh='D' AND importe < 0))),ABS(importe),0), ;
	 			tabla WITH par_tabla, registro WITH par_registro, idfiltro WITH vpar_idfiltro, idtipoasi WITH vpar_idtipoasi, idastoe WITH vpar_idastoe, fecha WITH v_fechaasi

	 SELECT  idastomode, codigocta, debe, haber, tabla, registro, fecha , idfiltro, idtipoasi, idastoe, idpland, codigo, nombrecta FROM AstoFinalA INTO TABLE &vpar_tablaret 
	 COPY TO &vpar_tablaret DELIMITED WITH ""
	
	 USE IN AstoCuentaA_sql
	 USE IN AstoValorA_sql
	 USE IN AstoCuentaA
	 USE IN AstoValorA
	 USE IN AstoValorB
	 USE IN AstoFinalA
	 USE IN tablacuenta
	 USE IN tablacampo
	 USE IN &vpar_tablaret 
	 var_retorno = vpar_tablaret 	 
	 RETURN var_retorno 
	
ENDFUNC 

*////////////////////////////////////////////////////
** Función que devuelve verdadero o falso segun sea
*/ segun sea que el indice del registro  pasado como parámetro pertenezca o no al grupo asociado a la cuenta
*/ contable que se debiera utilizar en el asiento modelo.
*/**********************************************************

FUNCTION GrupoCuentaContable 
PARAMETERS pg_valor, pg_tablag, pg_campog, pg_tipog, pg_valor1, pg_vconeccion
	vpertenece = .f. 
	var_pg_valorg = IIF((UPPER(SUBSTR(pg_tipog,1,1))='I' or UPPER(SUBSTR(pg_tipog,1,1))='F'),ALLTRIM(STR(pg_valor,12,2)),"'"+ALLTRIM(pg_valor)+"'")	
	
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
				
			IF toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("idgrupo"))= val(alltrim(pg_valor1)) AND toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("tiporeg")) = "G" THEN 
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
					ALLTRIM(toolbargrupos.arraygrupos(i,toolbargrupos.arraynombrecol("idmiembro")))= ALLTRIM(v_idmiembrog) AND ;					
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


*//////////////////////////////////////
*/ Determina el Filtro y Modelo de Asiento a aplicar en funcion
*/ del filtrado que aplica al comprobante recibido como parametros
*//////////////////////////////////////

FUNCTION FiltroAstoModelo 
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
					eje = " var_valord= "+IIF((UPPER(SUBSTR(filtros.tipo,1,1))='I' or UPPER(SUBSTR(filtros.tipo,1,1))='F'),'VAL(ALLTRIM(filtros.valord))','ALLTRIM(filtros.valord)')
					&eje 
					eje = " var_valorh= "+IIF((UPPER(SUBSTR(filtros.tipo,1,1))='I' or UPPER(SUBSTR(filtros.tipo,1,1))='F'),'VAL(ALLTRIM(filtros.valorh))','ALLTRIM(filtros.valorh)')
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


*!*	*** -----------------------------------------
*!*	* Cambia el reclamop del sector indicado al estado pasado como parámetro
*!*	* Guarda el registro del cambio de estado además genera la novedad de cambio del estado
*!*	* Parámetros: 
*!*	*	P_reclamop: Reclamo al que se le va a cambiar de estado
*!*	*	P_Sector:	Sector asociado al reclamo
*!*	*	P_estado:	Nuevo estado del reclamo para el sector
*!*	*	P_CierraTodos: Indica que si el sector que se va a cambiar es el origen, y el estado es Cerrado: va a cerrar el reclamo para todos los sectores
*!*	* Retorna: True o False, según se cambió o no el estado
*!*	*** -----------------------------------------

*!*	FUNCTION cambiaAEstado
*!*		
*!*		PARAMETERS p_reclamop, p_sector, p_estado, P_cierraTodos

*!*		v_idreclamop	= p_reclamop
*!*		v_idsector		= p_sector
*!*		v_idestado		= p_estado
*!*		v_cierraTodos	= p_cierraTodos
*!*		v_fecha			= DTOS(DATE())+ALLTRIM(SUBSTR(ALLTRIM(TIME(DATETIME())),1,8))
*!*		

*!*		vconeccionM=abreycierracon(0,_SYSSCHEMA)	



*!*		*** Cambio el estado del reclamo, agregando un registro de la tabla reclamoe *
*!*		
*!*		p_campoidx	= 'idreclamoe'
*!*		p_tipo		= 'I'
*!*		p_tabla		= 'reclamoe'
*!*		p_incre		= 1
*!*		
*!*		v_idreclamoe	= maxnumeroidx (p_campoidx, p_tipo, p_tabla, p_incre)
*!*		
*!*		IF v_idreclamoe <= 0 
*!*			** Error al obtner el max idreclamoe 
*!*					
*!*			** me desconecto
*!*			=abreycierracon(vconeccionM,"")
*!*		
*!*			RETURN .F.
*!*		
*!*		ELSE
*!*		

*!*			vconeccionM=abreycierracon(0,_SYSSCHEMA)	

*!*			
*!*			sqlmatriz(1)=" select * from recestado "
*!*			sqlmatriz(2)=" where idrecest = "+ALLTRIM(STR(v_idestado))
*!*			
*!*			
*!*			verror=sqlrun(vconeccionM,"estado_sql")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error al buscar el estado",0+48+0,"Error")
*!*			    		
*!*				** me desconecto
*!*				=abreycierracon(vconeccionM,"")
*!*				
*!*			    RETURN .F.
*!*			ENDIF 

*!*			SELECT estado_sql
*!*			GO TOP 
*!*			
*!*			IF NOT EOF()
*!*				v_estado	= estado_sql.estado
*!*			ELSE
*!*					
*!*			** me desconecto
*!*			=abreycierracon(vconeccionM,"")
*!*			
*!*				RETURN .F.
*!*			ENDIF 
*!*			

*!*		

*!*			vconeccionM=abreycierracon(0,_SYSSCHEMA)	


*!*			sqlmatriz(1)=" insert into reclamoe  "
*!*			sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idreclamoe))+","+ALLTRIM(STR(v_idreclamop))+","+ALLTRIM(STR(v_idestado))+","+ALLTRIM(STR(v_idsector))+",'"+ALLTRIM(v_fecha)+"')"


*!*			verror=sqlrun(vconeccionM,"ins_reclamoe_sql")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error al registrar el estado del reclamo ",0+48+0,"Error")
*!*			    		
*!*				** me desconecto
*!*				=abreycierracon(vconeccionM,"")
*!*		
*!*			    RETURN .F.
*!*			ENDIF 

*!*			
*!*			IF v_idreclamop > 0 AND v_idreclamoe > 0
*!*			
*!*			
*!*			*** Busco datos del reclamo ***
*!*				sqlmatriz(1)=" select * from reclamop "
*!*				sqlmatriz(2)=" where idreclamop = "+ALLTRIM(STR(v_idreclamop))
*!*				
*!*				
*!*				verror=sqlrun(vconeccionM,"reclamop_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error al buscar el reclamo",0+48+0,"Error")
*!*				    		
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*				    RETURN .F.
*!*				ENDIF 

*!*				SELECT reclamop_sql
*!*				GO TOP 
*!*				
*!*				IF NOT EOF()
*!*					v_numeroRec	= reclamop_sql.numero
*!*				ELSE
*!*						
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*					RETURN .F.
*!*				ENDIF 
*!*				
*!*			*** Busco datos del sector ***	
*!*				sqlmatriz(1)=" select * from recsector "
*!*				sqlmatriz(2)=" where idrecsec = "+ALLTRIM(STR(v_idsector))
*!*				
*!*					
*!*				verror=sqlrun(vconeccionM,"sector_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error al buscar el sector",0+48+0,"Error")
*!*				    		
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*				    RETURN .F.
*!*				ENDIF 

*!*				SELECT sector_sql
*!*				GO TOP 
*!*				
*!*				IF NOT EOF()
*!*					v_sectorRec	= sector_sql.sector
*!*				ELSE
*!*				
*!*						
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*					RETURN .F.
*!*				ENDIF 
*!*						

*!*				p_campoidx	= 'idrecnov'
*!*				p_tipo		= 'I'
*!*				p_tabla		= 'recnovedad'
*!*				p_incre		= 1
*!*			
*!*			
*!*				v_idrecnov	= maxnumeroidx(p_campoidx, p_tipo, p_tabla, p_incre)
*!*				
*!*				

*!*				vconeccionM=abreycierracon(0,_SYSSCHEMA)	

*!*				
*!*				v_fechaHora		= DATETIME()
*!*				v_fecha			= DTOS(v_fechaHora)+ALLTRIM(SUBSTR(ALLTRIM(TIME(v_fechaHora)),1,8))
*!*				v_fechaStr		= ALLTRIM(TTOC(DATETIME()))
*!*				v_usuario		= _SYSUSUARIO
*!*				
*!*				v_nrumerostr	= alltrim(strtran(str(v_numerorec,8,0),' ' ,'0'))
*!*				
*!*				v_novedad	= "("+ALLTRIM(v_fechaStr)+") EL RECLAMO "+ALLTRIM(v_nrumerostr)+" CAMBIÓ AL ESTADO "+ALLTRIM(v_estado)+" [SECTOR "+ALLTRIM(v_sectorRec)+"]"
*!*						
*!*				
*!*				sqlmatriz(1)=" insert into recnovedad "
*!*				sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idrecnov))+","+ALLTRIM(STR(v_idreclamop))+",'"+ALLTRIM(v_fecha)+"','"+ALLTRIM(v_novedad)+"','"+ALLTRIM(v_usuario)+"')"


*!*				verror=sqlrun(vconeccionM,"ins_recnovedad_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error al registrar la novedad del reclamo ",0+48+0,"Error")
*!*				    		
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*				    RETURN .F.
*!*				ENDIF 
*!*			
*!*			ELSE
*!*			
*!*			
*!*			ENDIF 
*!*		
*!*		
*!*		
*!*		ENDIF 
*!*		
*!*		
*!*			
*!*		** me desconecto
*!*		=abreycierracon(vconeccionM,"")
*!*		

*!*		RETURN .T.
*!*	ENDFUNC 



*** -----------------------------------------
* Cambia el reclamop del sector indicado al estado pasado como parámetro
* Guarda el registro del cambio de estado además genera la novedad de cambio del estado
* Retorna: True o False, según se cambió o no el estado
*** -----------------------------------------


FUNCTION cambiaEstadoRec
	PARAMETERS p_reclamop, p_sector, p_estado

	v_idreclamop	= p_reclamop
	v_idsector		= p_sector
	v_idestado		= p_estado
	v_fecha			= DTOS(DATE())+ALLTRIM(SUBSTR(ALLTRIM(TIME(DATETIME())),1,8))
	

	
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
		
		
			v_idrecnov	= maxnumeroidx(p_campoidx, p_tipo, p_tabla, p_incre)
			
			

		vconeccionM = abreycierracon(0,_SYSSCHEMA)
			
			v_fechaHora		= DATETIME()
			v_fecha			= DTOS(v_fechaHora)+ALLTRIM(SUBSTR(ALLTRIM(TIME(v_fechaHora)),1,8))
			v_fechaStr		= ALLTRIM(TTOC(DATETIME()))
			v_usuario		= _SYSUSUARIO
			
			v_nrumerostr	= alltrim(strtran(str(v_numerorec,8,0),' ' ,'0'))
			
			v_novedad	= "("+ALLTRIM(v_fechaStr)+") EL RECLAMO "+ALLTRIM(v_nrumerostr)+" CAMBIÓ AL ESTADO "+ALLTRIM(v_estado)+" [SECTOR "+ALLTRIM(v_sectorRec)+"]"
					
			
			sqlmatriz(1)=" insert into recnovedad "
			sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idrecnov))+","+ALLTRIM(STR(v_idreclamop))+",'"+ALLTRIM(v_fecha)+"','"+ALLTRIM(v_novedad)+"','"+ALLTRIM(v_usuario)+"')"


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










*** -----------------------------------------
* Cambia los estados del reclamo según el sector y los sectores asociados al reclamo si está habilitada la opción
* Retorna: True o False, según se cambió o no el estado
*** -----------------------------------------

FUNCTION cambiaAEstado
	
	PARAMETERS p_reclamop, p_sector, p_estado

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





***//////////////////////////////////////////////////////////////////
** Función de incersion de asientos a partir de un txt con el asiento con el modelo de asiento y el comprobante asociado
** La funcion controla que el asiento balancee y que las cuentas se correspondan con el 
** Plan de Cuentas Actual
****////////////////////////////////////////////////////////////////
FUNCTION IncerAstoContable
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
		MESSAGEBOX("No se Puede Grabar el Asiento: "+varastovalido)
		RETURN .F.
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
			lamatriz(12,2)="'Registro Automático de Asientos'"
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
	RETURN .T.
	 
ENDFUNC 




* FUNCIÓN PARA IMPRIMIR PAGO
* PARAMETROS: P_idPagoProv
FUNCTION imprimirPagoProv
PARAMETERS p_idpagoProv


	v_idpagoProv = p_idpagoProv
	
	IF v_idpagoProv > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA) && ME CONECTO
		
		*** Busco los datos del recibo
					
				
		
			sqlmatriz(1)=" Select r.*, pv.puntov, com.tipo, a.codigo as tipcomafip, e.cuit, dc.iddetapago, dc.idtipopago, dc.importe as impCobrado, dc.idcuenta, tp.detalle as tipopago, cb.codcuenta "
			sqlmatriz(2)=" from pagosprov r left join puntosventa pv on r.pventa = pv.pventa left join comprobantes com on r.idcomproba = com.idcomproba "
			sqlmatriz(3)=" left join tipocompro t on com.idtipocompro = t.idtipocompro left join afipcompro a on t.idafipcom = a.idafipcom " 
			sqlmatriz(4)=" left join entidades e on r.entidad = e.entidad left join detallepagos dc on r.idcomproba = dc.idcomproba and r.idpago = dc.idregistro "
			sqlmatriz(5)=" left join tipopagos tp on dc.idtipopago = tp.idtipopago left join cajabancos cb on dc.idcuenta = cb.idcuenta "
			sqlmatriz(6)=" where r.idpago = "+ ALLTRIM(STR(v_idpagoProv))

			verror=sqlrun(vconeccionF,"pagoprov_sql_u")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del Pago a Proveedor",0+48+0,"Error")
			ENDIF
		
		 
		
		
		
		
		

		SELECT * FROM pagoprov_sql_u INTO TABLE .\pago
				
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
			
		
		
		
			SELECT * FROM pagos_sql_u INTO TABLE .\pagos
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




*** -----------------------------------------
* Obtiene el ID del sector al que pertenece el usuario
* Retorna: idusuario
*** -----------------------------------------

FUNCTION getSectorUsu
	
	PARAMETERS p_usuario

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





*** -----------------------------------------
* Obtiene el ID del sector al que pertenece el usuario
* Retorna: idrecsec
*** -----------------------------------------

FUNCTION getSecUsu
	
	PARAMETERS p_usuario

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



*!*	*** -----------------------------------------
*!*	* Cambia el reclamop del sector indicado al estado pasado como parámetro
*!*	* Guarda el registro del cambio de estado además genera la novedad de cambio del estado
*!*	* Retorna: True o False, según se cambió o no el estado
*!*	*** -----------------------------------------

*!*	FUNCTION cambiaAEstado
*!*		
*!*		PARAMETERS p_reclamop, p_sector, p_estado

*!*		v_idreclamop	= p_reclamop
*!*		v_idsector		= p_sector
*!*		v_idestado		= p_estado
*!*		v_fecha			= DTOS(DATE())+ALLTRIM(SUBSTR(ALLTRIM(TIME(DATETIME())),1,8))
*!*		
*!*		*Abro conexión
*!*		vconeccionM=abreycierracon(0,_SYSSCHEMA)


*!*		*** Cambio el estado del reclamo, agregando un registro de la tabla reclamoe *
*!*		
*!*		p_campoidx	= 'idreclamoe'
*!*		p_tipo		= 'I'
*!*		p_tabla		= 'reclamoe'
*!*		p_incre		= 1
*!*		
*!*		v_idreclamoe	= maxnumeroidx (p_campoidx, p_tipo, p_tabla, p_incre)
*!*		
*!*		IF v_idreclamoe <= 0 
*!*			** Error al obtner el max idreclamoe 
*!*					
*!*			** me desconecto
*!*			=abreycierracon(vconeccionM,"")
*!*		
*!*			RETURN .F.
*!*		
*!*		ELSE
*!*		
*!*		
*!*		
*!*			vconeccionM=abreycierracon(0,_SYSSCHEMA)
*!*			
*!*			sqlmatriz(1)=" select * from recestado "
*!*			sqlmatriz(2)=" where idrecest = "+ALLTRIM(STR(v_idestado))
*!*			
*!*			
*!*			verror=sqlrun(vconeccionM,"estado_sql")
*!*			IF verror=.f.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error al buscar el estado",0+48+0,"Error")
*!*			    		
*!*				** me desconecto
*!*				=abreycierracon(vconeccionM,"")
*!*				
*!*			    RETURN .F.
*!*			ENDIF 

*!*			SELECT estado_sql
*!*			GO TOP 
*!*			
*!*			IF NOT EOF()
*!*				v_estado	= estado_sql.estado
*!*			ELSE
*!*					
*!*			** me desconecto
*!*			=abreycierracon(vconeccionM,"")
*!*			
*!*				RETURN .F.
*!*			ENDIF 
*!*			



*!*			*Abro conexión
*!*			vconeccionM=abreycierracon(0,_SYSSCHEMA)

*!*			DIMENSION lamatriz(5,2)
*!*			
*!*						
*!*			lamatriz(1,1)='idreclamoe'
*!*			lamatriz(1,2)=ALLTRIM(STR(v_idreclamoe))
*!*			lamatriz(2,1)='idreclamop'
*!*			lamatriz(2,2)=ALLTRIM(STR(v_idreclamop))
*!*			lamatriz(3,1)='idrecest'
*!*			lamatriz(3,2)=ALLTRIM(STR(v_idestado))
*!*			lamatriz(4,1)='idrecsec'
*!*			lamatriz(4,2)=ALLTRIM(STR(v_idsector))
*!*			lamatriz(5,1)='fecha'
*!*			lamatriz(5,2)="'"+ALLTRIM(v_fecha)+"'"
*!*					
*!*			p_tabla     = 'reclamoe'
*!*			p_matriz    = 'lamatriz'
*!*			p_tipoope     = 'I'
*!*			p_condicion   = ''
*!*			v_titulo      = " EL ALTA "
*!*			p_conexion  = vconeccionM
*!*			
*!*			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error al registrar el estado del reclamo ",0+48+0,"Error")
*!*			    
*!*			    ** me desconecto
*!*				=abreycierracon(vconeccionM,"")
*!*			
*!*			  RETURN .F.
*!*			ENDIF	


*!*			
*!*			IF v_idreclamop > 0 AND v_idreclamoe > 0
*!*			
*!*			
*!*			*** Busco datos del reclamo ***
*!*				sqlmatriz(1)=" select * from reclamop "
*!*				sqlmatriz(2)=" where idreclamop = "+ALLTRIM(STR(v_idreclamop))
*!*				
*!*				
*!*				verror=sqlrun(vconeccionM,"reclamop_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error al buscar el reclamo",0+48+0,"Error")
*!*				    		
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*				    RETURN .F.
*!*				ENDIF 

*!*				SELECT reclamop_sql
*!*				GO TOP 
*!*				
*!*				IF NOT EOF()
*!*					v_numeroRec	= reclamop_sql.numero
*!*				ELSE
*!*						
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*					RETURN .F.
*!*				ENDIF 
*!*				
*!*			*** Busco datos del sector ***	
*!*				sqlmatriz(1)=" select * from recsector "
*!*				sqlmatriz(2)=" where idrecsec = "+ALLTRIM(STR(v_idsector))
*!*				
*!*					
*!*				verror=sqlrun(vconeccionM,"sector_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error al buscar el sector",0+48+0,"Error")
*!*				    		
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*				    RETURN .F.
*!*				ENDIF 

*!*				SELECT sector_sql
*!*				GO TOP 
*!*				
*!*				IF NOT EOF()
*!*					v_sectorRec	= sector_sql.sector
*!*				ELSE
*!*				
*!*						
*!*					** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*					
*!*					RETURN .F.
*!*				ENDIF 
*!*						
*!*				** me desconecto
*!*				=abreycierracon(vconeccionM,"")
*!*				
*!*				
*!*				p_campoidx	= 'idrecnov'
*!*				p_tipo		= 'I'
*!*				p_tabla		= 'recnovedad'
*!*				p_incre		= 1
*!*			
*!*			
*!*				v_idrecnov	= maxnumeroidx(p_campoidx, p_tipo, p_tabla, p_incre)
*!*				
*!*				
*!*				*Abro conexión
*!*				vconeccionM=abreycierracon(0,_SYSSCHEMA)
*!*				
*!*				v_fechaHora		= DATETIME()
*!*				v_fecha			= DTOS(v_fechaHora)+ALLTRIM(SUBSTR(ALLTRIM(TIME(v_fechaHora)),1,8))
*!*				v_fechaStr		= ALLTRIM(TTOC(DATETIME()))
*!*				v_usuario		= _SYSUSUARIO
*!*				
*!*				v_nrumerostr	= alltrim(strtran(str(v_numerorec,8,0),' ' ,'0'))
*!*				
*!*				v_novedad	= "("+ALLTRIM(v_fechaStr)+") EL RECLAMO "+ALLTRIM(v_nrumerostr)+" CAMBIÓ AL ESTADO "+ALLTRIM(v_estado)+" [SECTOR "+ALLTRIM(v_sectorRec)+"]"
*!*					
*!*				
*!*				DIMENSION lamatriz2(5,2)
*!*		
*!*					
*!*				lamatriz2(1,1)='idrecnov'
*!*				lamatriz2(1,2)=ALLTRIM(STR(v_idrecnov))
*!*				lamatriz2(2,1)='idreclamop'
*!*				lamatriz2(2,2)=ALLTRIM(STR(v_idreclamop))
*!*				lamatriz2(3,1)='fecha'
*!*				lamatriz2(3,2)="'"+ALLTRIM(v_fecha)+"'"
*!*				lamatriz2(4,1)='novedades'
*!*				lamatriz2(4,2)="'"+ALLTRIM(v_novedad)+"'"
*!*				lamatriz2(5,1)='usuario'
*!*				lamatriz2(5,2)="'"+ALLTRIM(v_usuario)+"'"
*!*						
*!*				p_tabla     = 'recnovedad'
*!*				p_matriz    = 'lamatriz2'
*!*				p_tipoope     = 'I'
*!*				p_condicion   = ''
*!*				v_titulo      = " EL ALTA "
*!*				p_conexion  = vconeccionM
*!*				
*!*				IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error al registrar el estado del reclamo ",0+48+0,"Error")
*!*				    
*!*				    ** me desconecto
*!*					=abreycierracon(vconeccionM,"")
*!*				
*!*				  RETURN .F.
*!*				ENDIF	
*!*				
*!*			
*!*			ENDIF 
*!*			
*!*		
*!*		ENDIF 
*!*				
*!*		** me desconecto
*!*		=abreycierracon(vconeccionM,"")
*!*		

*!*		RETURN .T.
*!*	ENDFUNC 




*** -----------------------------------------
* Cambia el reclamop del sector indicado al estado pasado como parámetro
* Guarda el registro del cambio de estado además genera la novedad de cambio del estado
* Retorna: True o False, según se cambió o no el estado
*** -----------------------------------------


FUNCTION cambiaEstadoRec
	PARAMETERS p_reclamop, p_sector, p_estado

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
					
			
			sqlmatriz(1)=" insert into recnovedad "
			sqlmatriz(2)= " values ("+ALLTRIM(STR(v_idrecnov))+","+ALLTRIM(STR(v_idreclamop))+",'"+ALLTRIM(v_fecha)+"','"+ALLTRIM(v_novedad)+"','"+ALLTRIM(v_usuario)+"')"


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










*** -----------------------------------------
* Cambia los estados del reclamo según el sector y los sectores asociados al reclamo si está habilitada la opción
* Retorna: True o False, según se cambió o no el estado
*** -----------------------------------------

FUNCTION cambiaAEstado
	
	PARAMETERS p_reclamop, p_sector, p_estado

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
	RETURN ALLTRIM(STRTRAN(SUBSTR(STR((RAND()*_SYSRAND)),2),'','0'))
ENDFUNC 


*** -----------------------------------------
* Retorna el ultimo estado para un reclamo dado, segun el sector
* Parametros: Reclamo, Sector, Retorno (I: Indice,N: Nombre)
* Retorna: ID_Reclamo_Estado
*** -----------------------------------------

FUNCTION estadoReclamoPorSector
	
	PARAMETERS p_reclamop, p_sector, p_Retorno

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
	v_auxi = ALIAS()
	IF !EMPTY(v_auxi) THEN 
		IF (ALLTRIM(FIELD("sel",v_auxi))=='SEL') THEN
			IF TYPE('sel')='L' THEN 
				SELECT * FROM &v_auxi INTO CURSOR ccopiarclip WHERE sel = .t. 
				SELECT ccopiarclip
				IF _tally = 0  THEN 
					SELECT * FROM &v_auxi INTO CURSOR ccopiarclip 
				ENDIF 
			ELSE
				SELECT * FROM &v_auxi INTO CURSOR ccopiarclip  			
			ENDIF 
		ELSE
			SELECT * FROM &v_auxi INTO CURSOR ccopiarclip  	
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
	RETURN 
ENDFUNC 





*** -----------------------------------------
* Retorna Verdadero o Falso, si el reclamo pertenece al sector dado
* Parametros: Reclamo, Sector
* Retorna: True o False
*** -----------------------------------------

FUNCTION reclamoPerteneceSector
	
	PARAMETERS p_reclamop, p_sector

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



*** -----------------------------------------
* Retorna una lista de correos asociados a la entidad pasado como parámetro
* pIdEntidadd: ID de la entidad
* Retorno: Lista de Emails separados por ';'
*** -----------------------------------------

FUNCTION obtenerCorreos
	PARAMETERS pIdEntidad

	
	v_retorno	= ""
	
	IF pIdCliente == 0 OR EMPTY(pIdCliente) == .T.
	
		RETURN  v_retorno
	ENDIF 

	v_identidad	= pIdEntidad
	
	vconeccionM	= abreycierracon(0,_SYSSCHEMA)
	
	sqlmatriz(1)=" select cliente, email1, email2 from entidad where entidad = "+ALLTRIM(STR(v_identidad))


	verror=sqlrun(vconeccionM,"entidades_sql_uti")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los correos de las entidades",0+48+0,"Error")
	    RETURN v_retorno
	ENDIF 

	* me desconecto	
	=abreycierracon(vconeccionM,"")
		
	
	SELECT entidades_sql_uti
	GO TOP 

		v_email1	= entidades_sql_uti.email1
		v_email2	= entidades_sql_utiv.email2
			
		IF EMPTY(v_email2)
			v_retorno	= v_email1
		ELSE
			IF EMPTY(v_email1)
				v_retorno	= v_email2
			ELSE
				v_retorno	= v_email1+";"+v_email2
			ENDIF 
		ENDIF  
			
		
		
		return v_retorno
		
		
ENDFUNC 


*** -----------------------------------------
* Busca la configuración de correo para el usuario logeado
* Retorna: objeto de configuración
*** -----------------------------------------
FUNCTION cargaCfgCorreo


vconeccionM = abreycierracon(0,_SYSCHEMA)


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

