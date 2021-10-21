 
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

*!*		
*!*	* FUNCION QUE PERMITE LA CARGA DEL COMPROBANTE AL SERVICIO LOCAL, PARA LUEGO SER AUTORIZADA
*!*	* PARAMETROS: p_idFactura, ID DEL COMPROBANTE A AUTORIZAR
*!*	FUNCTION cargarCompFE
*!*	PARAMETERS p_idFactura


*!*		v_servicioCargado = .F.
*!*		v_compCargado = .F.
*!*		TRY 
*!*		
*!*			v_servicioCargado = loBasicHttpBinding_IServicio.servicioIniciado()
*!*			
*!*			IF v_servicioCargado  = .t.

*!*				v_idfactura = p_idFactura
*!*				
*!*				**** CARGA COMPROBANTE ***

*!*				vconeccionF=abreycierracon(0,_SYSSCHEMA)	
*!*				


*!*				sqlmatriz(1)="Select f.*, a.codigo as codAfip, p.puntov from facturas f left join comprobantes c on f.idcomproba = c.idcomproba "
*!*				sqlmatriz(2)=" left join tipocompro tc on  c.idtipocompro = tc.idtipocompro left join afipcompro a on  tc.idafipcom = a.idafipcom "
*!*				sqlmatriz(3)=" left join puntosventa p on f.pventa = p.pventa "
*!*				sqlmatriz(4)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

*!*				verror=sqlrun(vconeccionF,"factu_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la factura a cargar ",0+48+0,"Error")
*!*				    *thisform.comprobantecargado = .f.
*!*				    v_compCargado = .F.
*!*				ENDIF 

*!*				*** Cargo IMpuestos del comprobante agrupados por tipo de impuesto
*!*				sqlmatriz(1)="Select fi.*,a.codigo as codigoAfip, a.tipo as tipoAfip, a.detalle as detAfip from  facturasimp fi left join impuestos i on fi.impuesto = i.impuesto "
*!*				sqlmatriz(2)=" left join afipimpuestos a on i.idafipimp = a.idafipimp " 
*!*				sqlmatriz(3)=" where fi.idfactura = "+ ALLTRIM(STR(v_idfactura))

*!*				verror=sqlrun(vconeccionF,"factImp_sql")
*!*				IF verror=.f.  
*!*				    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de los impuestos de las facturas ",0+48+0,"Error")
*!*				    *thisform.comprobantecargado = .f.
*!*				    v_compCargado = .F.
*!*				ENDIF 


*!*			
*!*				
*!*				SELECT factu_sql

*!*				
*!*				
*!*				v_idComprobante = factu_sql.idfactura
*!*				*id o tipo?
*!*				v_tipoComprobante = VAL(factu_sql.codAfip)
*!*				

*!*				v_tipoDocCliente= factu_sql.tipodoc
*!*				v_nroDocCliente	= factu_sql.cuit
*!*				
*!*				
*!*				v_fechaComprobante = factu_sql.fecha
*!*				v_importeNeto = factu_sql.neto
*!*				
*!*				*** OPERACION EXCENTA???
*!*				v_importeOpEx = 0
*!*				*Tratamiento de impuestos
*!*				IF factu_sql.operexenta = "S"
*!*					v_importeOpEx = 0
*!*				ELSE
*!*				
*!*				ENDIF 
*!*				


*!*		SET ENGINEBEHAVIOR 70  &&habilitará el comportamiento de Visual FoxPro 7. 
*!*			SELECT *, SUM(importe) as impTot, SUM(neto) as netoTot FROM factImp_sql GROUP BY impuesto  INTO TABLE .\factImp
*!*				
*!*				 
*!*				 
*!*		SET ENGINEBEHAVIOR 90  &&habilitará el comportamiento de Visual FoxPro 9. 
*!*				
*!*				v_importeTotalComp = factu_sql.total
*!*				v_idMoneda = "PES"
*!*				v_cotizacionMoneda = 1
*!*			*Concepto se refiere a:
*!*			*1- Productos
*!*			*2- Servicios
*!*			*3- Productos y servicios
*!*				v_concepto = _SYSCONCEPTOAFIP
*!*				v_ptoVta = factu_sql.puntov 

*!*				v_1 =	loBasicHttpBinding_IServicio.setIDComprobante(v_idComprobante)

*!*				v_2=	loBasicHttpBinding_IServicio.setTipoComprobante(v_tipoComprobante)

*!*				v_3=	loBasicHttpBinding_IServicio.setDocTipoClienteComprobante(v_tipoDocCliente)

*!*				v_4=		loBasicHttpBinding_IServicio.setNroDocClienteComprobante(ALLTRIM(v_nroDocCliente))

*!*				v_5=		loBasicHttpBinding_IServicio.setFechaComprobante(ALLTRIM(v_fechaComprobante))
*!*					
*!*				 
*!*				
*!*				v_totalIVA = 0
*!*				v_totalTributo = 0
*!*				SELECT factImp
*!*				GO TOP
*!*				DO WHILE  NOT EOF()
*!*					
*!*					v_impuesto = factImp.impuesto
*!*					v_detalle  = factImp.detalle
*!*	*!*					v_importe  = factImp.importe
*!*	*!*					v_neto	   = factImp.neto
*!*					v_importe	= factImp.impTot
*!*					v_neto		= factImp.netoTot
*!*					v_codAfip  = VAL(ALLTRIM(factImp.codigoafip))
*!*					v_tipoAfip = factImp.tipoAfip
*!*					v_detAfip  = factImp.detAfip

*!*					DO case
*!*					
*!*						CASE v_tipoAfip = "IVA"

*!*							resp = loBasicHttpBinding_IServicio.agregarAlicIva(v_codAfip,v_neto,v_importe)
*!*						
*!*							IF resp = .F.
*!*								MESSAGEBOX("Error al cargar alicuota IVA",0+48+0,"Error")
*!*							
*!*							ELSE
*!*								v_totalIVA = v_totalIVA + v_importe
*!*						
*!*							ENDIF 
*!*							
*!*							
*!*						CASE v_tipoAfip = "TRIBUTO"
*!*						**REVISAR ALICUOTA (0) EN TRIBUTO 

*!*							resp = loBasicHttpBinding_IServicio.agregarTributo(v_codAfip, 0, v_neto, v_detAfip, v_importe)
*!*						
*!*							IF resp = .F.
*!*								MESSAGEBOX("Error al cargar el TRIBUTO",0+48+0,"Error")
*!*							
*!*							ELSE
*!*								v_totalTributo = v_totalTributo + v_importe
*!*						
*!*							ENDIF 
*!*						
*!*					
*!*					ENDCASE 
*!*					
*!*					
*!*				
*!*					SELECT factImp
*!*					SKIP 1
*!*				ENDDO  

*!*					v_importeTributo = v_totalTributo
*!*					v_importeIva = v_totalIVA

*!*						v_6=		loBasicHttpBinding_IServicio.setImporteNetoComprobante(v_importeNeto)

*!*				v_7=		loBasicHttpBinding_IServicio.setImporteOpExComprobante(v_importeOpEx)

*!*				v_8=		loBasicHttpBinding_IServicio.setImporteTributoComprobante(v_importeTributo)

*!*				v_9=		loBasicHttpBinding_IServicio.setImporteIvaComprobante(v_importeIva)

*!*				v_10 = 		loBasicHttpBinding_IServicio.setImporteTotalComprobante(v_importeTotalComp)
*!*				

*!*				v_11=		loBasicHttpBinding_IServicio.setIDMonedaComprobante(ALLTRIM(v_idMoneda))

*!*				v_12=		loBasicHttpBinding_IServicio.setCotizacionMonedaComprobante(v_cotizacionMoneda)

*!*				v_13=		loBasicHttpBinding_IServicio.setConceptoComprobante(v_concepto)

*!*				v_14 =			loBasicHttpBinding_IServicio.setPtoVtaComprobante(v_ptoVta)

*!*				v_estadoComp =	loBasicHttpBinding_IServicio.comprobanteCargado()
*!*				
*!*						
*!*				
*!*				IF v_estadoComp = .T.
*!*				
*!*					v_compCargado =.T.
*!*				ELSE
*!*				
*!*				    v_compCargado =	.F.

*!*				ENDIF 

*!*			ELSE
*!*				  MESSAGEBOX("El servicio de autorización no está Iniciado",0+48+0,"Error")

*!*				    v_compCargado = .F.
*!*			ENDIF 
*!*		CATCH TO loException
*!*			lcErrorMsg="Error: "+TRANSFORM(loException.Errorno)+" - "+loException.Message
*!*			DO CASE
*!*				CASE VARTYPE(loBasicHttpBinding_IServicio)#"O"
*!*					* Handle SOAP error connecting to web service
*!*				CASE !EMPTY(loBasicHttpBinding_IServicio.FaultCode)
*!*					* Handle SOAP error calling method
*!*					lcErrorMsg=lcErrorMsg+CHR(13)+loBasicHttpBinding_IServicio.Detail
*!*				OTHERWISE
*!*					* Handle other error
*!*				ENDCASE
*!*				* Use for debugging purposes
*!*				MESSAGEBOX(lcErrorMsg,0+48+0,"Se produjo un Error")
*!*				v_compCargado = .F.
*!*			FINALLY
*!*		ENDTRY
*!*		RETURN v_compCargado
*!*	ENDFUNC  
*!*	 





* FUNCIÓN PARA AUTORIZAR COMPROBANTES
* PARAMETROS: P_IDCOMPROBANTE, ID DEL COMPROBANTE A AUTORIZAR
* RETORNO: Retorna True si no hubo errores al intentar autorizar el comprobante (NO significa que se haya APROBADO), retorna False en caso que haya ocurrido un error en la autorización
FUNCTION autorizarCompFE
PARAMETERS p_idregistro, p_idcomproba, p_nomsg

	v_idcomprobante= p_idregistro
	v_autorizar = .F.
	v_objconfigurado = .F.
	v_idcomproba	= p_idcomproba


	*** COMPRUEBO QUE EL COMPROBANTE NO ESTÉ AUTORIZADO **
	
	vconeccion=abreycierracon(0,_SYSSCHEMA)	
		
		sqlmatriz(1)="Select f.* from facturasfe f  "
		sqlmatriz(2)=" where f.idfactura = "+ ALLTRIM(STR(v_idcomprobante))

		verror=sqlrun(vconeccion,"factufe_sql")
		IF verror=.f.  
			IF p_nomsg = .f. THEN 
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la facturasFE",0+48+0,"Error")
		   	ENDIF 
		    v_autorizar = .F.
		    RETURN 
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
			v_objconfigurado	= objModuloAFIP.CargaConfiguracion(ALLTRIM(_SYSSERVICIOFE), ALLTRIM(_SYSURLWSAA), ALLTRIM(_SYSSERVICIOAFIP), ALLTRIM(_SYSPROXY), ALLTRIM(_SYSPROXYUSU), ALLTRIM(_SYSPROXYPASS), ALLTRIM(v_ubicacionCertificado), ALLTRIM(v_ticketAcceso), _SYSINTAUT, _SYSINTTA, ALLTRIM(_SYSNOMFISCAL), ALLTRIM(_SYSCUIT), ALLTRIM(v_log))

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
			MESSAGEBOX(loException.message,0+48+0,"Se produjo un Error")
		ENDIF 
		v_autorizar = .F.
		RETURN v_autorizar

	ENDTRY	
						
						
					
	*** Armo el archivo XML para mandarlo a autorizar ***

		v_ubicacionXML = armarComprobanteXML(v_idcomprobante)

	*** Mando a autorizar el comprobante pasandole la ubicación del archivo  y el ID ***

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
				v_observa	= STRTRAN(respuestaComp.observa,"'","")
				v_errores = STRTRAN(respuestaComp.errores,"'","")
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
					
						DIMENSION lamatriz(3,2)
				
					lamatriz(1,1)='numero'
					lamatriz(1,2)=ALLTRIM(STR(v_numerofe))
					lamatriz(2,1)='cespcae'
					lamatriz(2,2)="'"+ALLTRIM(v_caecesp)+"'"
					lamatriz(3,1)='caecespven' 
					lamatriz(3,2)="'"+ALLTRIM(v_caecespven)+"'"
					


					
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

* FUNCIÓN PARA IMPRIMIR UNA FACTURA (COMPROBANTES DE LA TABLA FACTURA: FACTURA, NC, ND)
* PARAMETROS: P_IDFACTURA, P_ESELECTRONICA
FUNCTION imprimirFactura
PARAMETERS p_idFactura, p_esElectronica,pEnviarImpresora


	v_idfactura 	= p_idFactura
	v_esElectronica = p_esElectronica 

	IF v_idfactura > 0
		
		vconeccionF=abreycierracon(0,_SYSSCHEMA)	
			
		*** Busco los datos de la factura y el detalle
		IF v_esElectronica  = .T.

			sqlmatriz(1)=" Select f.*,d.*,fe.*,c.*,v.*,fe.numerofe as numFac,c.detalle as detIVA, v.nombre as nomVend,ca.puntov,ti.detalle as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP,l.nombre as nomLoc, p.nombre as nomProv, "
			sqlmatriz(2)=" com.comprobante as nomcomp from facturas f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(3)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa left join puntosventa pv on  ca.pventa = pv.pventa  "
			sqlmatriz(4)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactu d on f.idfactura = d.idfactura "
			sqlmatriz(5)=" left join facturasfe fe on f.idfactura = fe.idfactura left join condfiscal c on f.iva = c.iva"
			sqlmatriz(6)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(7)=" left join localidades l on f.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
			sqlmatriz(8)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura)) +" order by fe.idfe desc " &&+  " and fe.resultado = 'A'"
			*sqlmatriz(8)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura)) &&+  " and fe.resultado = 'A'"
			
			verror=sqlrun(vconeccionF,"fac_det_sql_au")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		
		ELSE
			
			sqlmatriz(1)="Select f.*,d.*,c.*,v.*,f.numero as numFac, c.detalle as detIVA,ca.puntov,ti.detalle as tipoopera, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP,l.nombre as nomLoc, p.nombre as nomProv, "
			sqlmatriz(2)=" com.comprobante as nomcomp from facturas f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
			sqlmatriz(3)=" left join compactiv ca on f.idcomproba = ca.idcomproba and f.pventa = ca.pventa  left join puntosventa pv on ca.pventa = pv.pventa  " 
			sqlmatriz(4)=" left join tipooperacion ti on f.idtipoopera = ti.idtipoopera left join detafactu d on f.idfactura = d.idfactura "
			sqlmatriz(5)=" left join condfiscal c on f.iva = c.iva"
			sqlmatriz(6)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(7)=" left join localidades l on f.localidad = l.localidad left join provincias p on l.provincia = p.provincia "
			sqlmatriz(8)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"fac_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		
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
			sqlmatriz(2)=" b.ruta2, b.folio2, b.direccion, b.idtiposer, t.detalle as detatipo "
			sqlmatriz(3)=" from facturasbser b " 
			sqlmatriz(4)=" left join tiposervicio t on t.idtiposer = b.idtiposer "
			sqlmatriz(5)=" where b.idfactura = "+ ALLTRIM(STR(v_idfactura))

			verror=sqlrun(vconeccionF,"bocas_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  las deudas",0+48+0,"Error")
			ENDIF

		IF v_esElectronica  = .T.

			SELECT fac_det_sql_au 
			GO TOP
			IF NOT EOF()
				v_idfe = fac_det_sql_au.idfe
				SELECT * FROM fac_det_sql_au WHERE idfe = v_idfe INTO TABLE .\factu
			
			ENDIF 
		ELSE
			SELECT * FROM fac_det_sql 	INTO TABLE .\factu
		ENDIF 

	
		
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpIVA WHERE ALLTRIM(tipoIMP) = "IVA"
		
		SELECT * FROM impuestos_sql INTO TABLE .\ImpTRIB WHERE ALLTRIM(tipoIMP) = "TRIBUTO"

		SELECT * FROM deuda_sql 	INTO TABLE .\deuda

		SELECT * FROM cuotas_sql 	INTO TABLE .\cuotas

		SELECT * FROM bocas_sql 	INTO TABLE .\bocas
		
		SELECT factu
		GO TOP 
		IF NOT EOF()
		
			
			



			ALTER table factu ADD COLUMN codBarra	 C(42)
		*	ALTER table factu ADD COLUMN codQR		 general
			ALTER table factu ADD COLUMN codQR C(100)
			ALTER table factu ADD COLUMN apeynom C(200)

	** AGREGO OBSERVACIONES FIJAS EN EL COMPROBANTE SEGÚN CONDICIONES EN LA TABLA observacond *
	
			ALTER table factu ADD COLUMN obsfijo C(250)
			
			
			v_observaFijo = obtenerObservaComp("facturas", "idfactura",v_idfactura, vconeccionF,.F.)

			
			SELECT factu 
			GO TOP 
			replace ALL obsfijo WITH v_observaFijo, apeynom WITH ALLTRIM(ALLTRIM(apellido)+" "+ALLTRIM(nombre))
			
			
			
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
				
				v_codBarra		= v_cuitEmpresa+v_tipoCompAfip+"0"+v_puntoVta+v_fechaVenc_cae+v_Cespcae && EL PUNTO DE VENTA DEBE SER DE 5 DIGITOS

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

                fechaCompro = ALLTRIM(factu.fecha)
                cuitE 		= ALLTRIM(v_cuitEmpSG)
	
                ptovta_fe   = ALLTRIM(v_puntoVta)
                idtipocbte_fe = ALLTRIM(factu.tipcomAFIP)
	
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
			
			=abreycierracon(vconeccionF,"")
				

			DO FORM reporteform WITH "factu;impIva;impTRIB;deuda;cuotas;bocas","facturasrc;impIVArc;impTRIBrc;deudarc;cuotasrc;bocasrc",v_idcomproba,.F.,pEnviarImpresora
			
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


* FUNCIÓN PARA IMPRIMIR RECIBO
* PARAMETROS: P_IDRECIBO
FUNCTION imprimirRecibo
PARAMETERS p_idRecibo


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
		

			sqlmatriz(1)=" Select f.*,d.*,c.*,v.*,f.numero as numNP,com.tipo as tipoCom, c.detalle as detIVA, v.nombre as nomVend,ca.puntov, tc.idafipcom, pv.electronica as electro, ifnull(af.codigo,'') as tipcomAFIP,l.nombre as nomLoc, p.nombre as nomProv,e.cuit, "
			sqlmatriz(2)=" com.comprobante as nomcomp from np f left join comprobantes com on f.idcomproba = com.idcomproba left join tipocompro tc on com.idtipocompro = tc.idtipocompro left join afipcompro af on tc.idafipcom = af.idafipcom "
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


* FUNCIÓN PARA IMPRIMIR TRANSFERENCIA DE CAJAS
* PARAMETROS: P_idcajamovip
FUNCTION imprimirTransferenciaCaja
PARAMETERS p_idcajamovip

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




* FUNCIÓN PARA IMPRIMIR TRANSFERENCIA DE CAJAS
* PARAMETROS: P_idcajamovip
FUNCTION imprimirTransferenciaCta
PARAMETERS p_idtransferencia



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



* FUNCIÓN PARA IMPRIMIR CAJA INGRESO / EGRESO
* PARAMETROS: P_idcajaie
FUNCTION imprimirCajaIE
PARAMETERS p_idcajaie, P_opera_comp

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




* FUNCIÓN PARA IMPRIMIR UN COmprobante de cumplimentacion (COMPROBANTES DE LA TABLA cumplimentap)
* PARAMETROS: P_IDCUMP
FUNCTION imprimirCumplimentacion
PARAMETERS p_idcump


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


* FUNCIÓN PARA IMPRIMIR UN COmprobante de Vinculos (COMPROBANTES DE LA TABLA vinculocomp)
* PARAMETROS: P_idvinculo
FUNCTION imprimirVinculoComp
PARAMETERS p_idvinculo


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






FUNCTION compruebaCajaReca

*** Controlo que se haya seleccionado una caja de recaudación 

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

* ACTUALIZO CAJARECAUDAH CON EL COMPROBANTE GUARDADO
* PARAMETROS: P_idComp: id comprobante; P_idReg: ID del registro
FUNCTION guardaCajaRecaH 
PARAMETERS p_idComp, p_idReg, p_idCajaR
				
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
*		'HHHHHH:MM:SS'
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
	
	retorno = (STRTRAN((STR(v_horast,6))+':'+(STR(v_minutost,2))+':'+(STR(v_segundost,2)),' ','0'))
	RETURN retorno 
ENDFUNC 


FUNCTION SUMAHORAS
PARAMETERS P_HORA1 , P_HORA2
* suma las horas que recibe como parametro HORA1 Y HORA2
* el formato en el que recibe es de tipo caracter
*		'HHHHHH:MM:SS'
* devuelve el valor acumulado de horas en el mismo formato
	
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


*!*	** SEPARA CARACTERES BUSCADOS Y RETORNA VERDADERO O FALSO 0 O 1
*!*	FUNCTION ATCF_BKP 
*!*	PARAMETERS c_buscado, c_buscaren
*!*	IF !EMPTY(c_buscado) then 
*!*		vfiltra01 = 0
*!*		c_buscado 	= UPPER(c_buscado)
*!*		c_buscaren 	= UPPER(c_buscaren)
*!*		
*!*		ALINES(cbuscadoarr,c_buscado,16,"&","#")
*!*		aelementos = ALEN(cbuscadoarr)

*!*		DIMENSION cbuscadof (aelementos,2)
*!*		FOR i= 1 TO aelementos
*!*			cbuscadof(i,2) = IIF(ATC("#",ALLTRIM(cbuscadoarr(i)))>0,'+',IIF(ATC("&",ALLTRIM(cbuscadoarr(i)))>0,'*','+'))
*!*			cbuscadoarr(i)=STRTRAN(STRTRAN(cbuscadoarr(i),'#',""),"&","")
*!*		ENDFOR 

*!*		FOR i=1 TO aelementos
*!*			vfiltra001 = IIF(ATC(ALLTRIM(cbuscadoarr(i)),c_buscaren)>0,'1','0')
*!*			cbuscadof(i,1)=vfiltra001
*!*		ENDFOR 
*!*		vformula = ""
*!*		FOR i=1 TO aelementos
*!*			vformula = vformula+cbuscadof(i,1)+cbuscadof(i,2)
*!*		ENDFOR 
*!*		vformula = vformula +'+0'  
*!*		vfiltra01 = &vformula
*!*		RELEASE cbuscadoarr , cbuscadof
*!*		RETURN vfiltra01
*!*	ELSE	
*!*		RETURN 1
*!*	ENDIF 
*!*	ENDFUNC 


* FUNCION DE BUSQUEDA DE REPORTES Y SELECCION DE ACUERDO AL PARAMETRO APLICADO.

FUNCTION fselectreporte 
PARAMETERS pvar_paramrepo, pvar_tablarepo
	****************************************
	v_paramRepo = pvar_paramrepo
	pvar_retorno = ""

	v_itera = 0

	DO WHILE v_itera <= 1 && controlo las veces que consulto por un reporte

		vconeccion=abreycierracon(0,_SYSSCHEMA)	
		IF TYPE("v_paramRepo") = "N"
			*** Si el parametro es un NUMERO, el nùmero es el idComproba


			sqlmatriz(1)="select r.idreporte, r.nombre, r.descripcion as descrip, co.predeterminado as predet from comprorepo co "
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

				sqlmatriz(1)="select r.idreporte, r.nombre, r.descripcion as descrip, co.predeterminado as predet from comprorepo co "
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
			pvar_retorno = ALLTRIM(STR(repos_sql.idreporte))+";" + ALLTRIM(repos_sql.nombre)
			
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


* Incerta un Reporte en la tabla reportesimp y agrega una relacion en comprorepo
* Se utiliza cuando no existe el reporte que el usuario quiere incertar
* retorna el idreporte si lo pudo insertar, sino devuelve 0

FUNCTION CargaReporte
PARAMETERS pr_claverepo

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
		
		verror=SQLEXEC(vconeccionF," insert into reportesimp (idreportea, idreporte, nombre, descripcion, fechahora, tamanio, reporte ) "+ ;
									" values ("+alltrim(STR(max_idreportea))+","+alltrim(str(max_idreporte))+",'"+alltrim(v_nombrerepo)+"',"+"'','"+alltrim(v_fechahora)+"',"+alltrim(STR(v_tamanio))+",'"+v_reporte_ins+"')" ;
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
	IF USED("grupotmp1") THEN 
		USE IN grupotmp1
	ENDIF 
*!*		USE IN grupotmp1
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



** AGREGA EL CAMPO busquedag para poder realizar busquedas y filtrados con el objeto de grupos

FUNCTION generabusquedag
	PARAMETERS para_tabla, para_string
	SELECT &para_tabla
	ALTER table &para_tabla ADD COLUMN busquedag c(254)
	replace ALL busquedag WITH &para_string
	GO TOP 
RETURN 

*---------------------------------------------------------------------------
* Filtrado de grupos en tablas Locales, recibe como parametro una tabla local 
*  y aplica el filtro de grupo a las tablas si está seleccionada la opcion de filtrados
*  en el objeto de grupos
*------------------------------------------------------------------------------
FUNCTION filtragrupos
	PARAMETERS pf_tbbuscador, pf_tablas, pf_extras

	IF TYPE("pf_extras")='C' THEN 
		IF !EMPTY(ALLTRIM(pf_extras)) THEN	
			EJE4 = pf_extras
		ELSE
			EJE4= ""	
		ENDIF 		
	ELSE 
		EJE4=""
	ENDIF 

	SELECT &pf_tablas
	
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
* 			  p_tipo: indica si quiere que retorne el tipo de campo del indice .f. = no retorna, .t.= retorna tipo "C" o "I"
*				 	  concatenado al nombre de campo serparado por ";"
* Retorno: Retorna el nombre del campo indice de la tabla consultada
*---------------------------------------------------------------
FUNCTION obtenerCampoIndice
PARAMETERS p_tabla, p_tipo

	
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


	v_modulo = v_resE4 % 10
	v_dif = 10 - v_modulo 
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
*!*			IF v_esElectronica  = .T.

*!*			
*!*			ELSE
			
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			sqlmatriz(1)="Select r.*,d.*,c.*,v.*,r.numero as numRem, c.detalle as detIVA,ca.puntov, tc.idafipcom, pv.electronica as electro, af.codigo as tipcomAFIP, l.nombre as nomLoc, p.nombre as nomProv, "
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

	**** Busco el comprobante asociado ***
	vconeccionA=abreycierracon(0,_SYSSCHEMA)	

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
			SELECT t.*,a.detalle FROM &v_tablaDatos t LEFT JOIN articulos_sql a ON t.articulo = a.articulo INTO TABLE articulosDatos
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







**** FUNCIÓN PARA GENERAR AJUSTES de MATERIALES DE UN COMPROBANTE de PROVEEDOR
** PARAMETROS: 	P_idtipomov: ID de la tabla tipomstock (Indica el tipo de ajuste a realizar)
***				P_idcomproba: ID de la tabla comprobante (comprobante relacionado al ajuste)
***				P_nomreCampo: Nombre del campo Indice de la tabla asociada al comprobante
***				P_Idregistro: ID de la tabla asociada al comprobante
***				P_TablaDatos: Tabla con los articulos a los que se le hará el ajuste, tiene el siguiente formato: [articulo C(50),cantidad Y,deposito I]
**RETORNO:		.T. o .F. Dependiendo si se realizó el ajuste correctamente o no respectivamente

FUNCTION AjusteMatComprobanteProv
PARAMETERS p_idtipomov, p_idcomproba,p_nombreCampo,p_idregistro,p_tablaDatos

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
		
		SELECT tablacampo 
		GO top
		
		
		
		DO WHILE !EOF()
			SELECT AstoValorAC

		**decidir si incerto o no			
		*********************************			
			var_valor = IIF((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F'),tablacampo.valorcf,ALLTRIM(tablacampo.valorcf))  
			eje = " var_valor1= "+IIF((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F'),'VAL(ALLTRIM(AstoValorAC_sql.valor1))','ALLTRIM(AstoValorAC_sql.valor1)')
			&eje 
					
			eje = " var_valor2= "+IIF((UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoValorAC_sql.tipo,1,1))='F'),'VAL(ALLTRIM(AstoValorAC_sql.valor2))','ALLTRIM(AstoValorAC_sql.valor2)')
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

*				INSERT INTO AstoValorA VALUES (AstoValorAC_sql.idastomode, AstoValorAC_sql.idastocuen, AstoValorAC_sql.idcpoconta, AstoValorAC_sql.dh, ;
*											   AstoValorAC_sql.detalle, AstoValorAC_sql.tabla, AstoValorAC_sql.campo, AstoValorAC_sql.opera, ;
*											   AstoValorAC_sql.idastoval, tablacampo.importe)
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
	 
	SELECT idastomode, idastocuen, idcpoconta, dh, detalle, SUM(importe) as importe ;
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
		verror=sqlrun(vconeccionATO,"tablacuenta")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA de la Cuenta Seleccionada ",0+48+0,"Error")
		    =abreycierracon(vconeccionATO,"")
		    RETURN var_retorno
		ENDIF

		SELECT tablacuenta
		GO top
		DO WHILE !EOF()
			var_valor = IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F'),tablacuenta.valor,ALLTRIM(tablacuenta.valor))  
			eje = " var_valor1= "+IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F'),'VAL(ALLTRIM(AstoCuentaA_sql.valor1))','ALLTRIM(AstoCuentaA_sql.valor1)')
			&eje 
					
			eje = " var_valor2= "+IIF((UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='I' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='D' or UPPER(SUBSTR(AstoCuentaA_sql.tipo,1,1))='F'),'VAL(ALLTRIM(AstoCuentaA_sql.valor2))','ALLTRIM(AstoCuentaA_sql.valor2)')
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

	 =abreycierracon(vconeccionATO,"")
	 
	 SELECT AstoCuentaA
	 SET ORDER TO 


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
	 USE IN AstoValorAC_sql
	 USE IN AstoCuentaA
	 USE IN AstoValorAC
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
	RETURN v_idasiento
	 
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

			verror=sqlrun(vconeccionF,"pagoprov_sql_ua")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del Pago a Proveedor",0+48+0,"Error")
			ENDIF
		
		 
		
		
		
		
		
		
		SELECT *,iddetapago as iddetap FROM pagoprov_sql_ua INTO TABLE pagoprov_sql_u
		ALTER table pagoprov_sql_u alter COLUMN tipopago C(254) 

		SELECT pagoprov_sql_u
		GO TOP 
				
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
			
		
		
			SELECT pagoprov_sql_u
			SKIP 1
		
		ENDDO 
		
		
		
		

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



** FUNCION DE CALCULO DE NUMEROS ALEATORIOS
* puede recibir como parametros la cantidad de numeros aleatorios
* si no recibe cantidad devuelve de acuerdo a la variable _SYSRAND
*

FUNCTION frandom
PARAMETERS p_digitos

IF TYPE('p_digitos') <> 'N'

	RETURN ALLTRIM(STRTRAN(SUBSTR(STR((RAND(-1)*_SYSRAND)),2),'','0'))
ELSE

	v_expo = p_digitos 
	
	v_rand = 10^v_expo
	
	RETURN ALLTRIM(STRTRAN(SUBSTR(STR((RAND(-1)*v_rand)),2),'','0'))
ENDIF 
	
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
	PARAMETERS p_csv 
	
	IF !TYPE('p_csv')='C' THEN 
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


*-----------------------------------------------------------------------------------
* Obtiene todos los reclamos no leidos dato el usuario (y con el usuario el sector)
*-----------------------------------------------------------------------------------


FUNCTION obtieneRecNoLeidos
PARAMETERS  para_aliasrnl, p_usuario
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


	
*/****
* Obtiene todas las listas de precios con los Precios Actualizados 
* La lista 0 corresponde a la basica de articulos sin Calculo de Costos
* Recibe como parametro el nombre de la tabla en la cual retornará las listas y la condicion fiscal (por defecto es la 1)
***********************************************************************
FUNCTION GetListasPrecios	
PARAMETERS p_nombrearchivo, p_condfis


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

	vconeccionF = abreycierracon(0,_SYSSCHEMA)
	fvarticulos_sql 	= 'articulos_sql'+vtmp 
	fvlistapreciop_sql 	= 'listapreciop_sql'+vtmp 
	fvlistaprecioh_sql 	= 'listaprecioh_sql'+vtmp 
	fvlistaprecioc_sql 	= 'listaprecioc_sql'+vtmp 
	fvarticulosimp_sql	= 'articulosimp_sql'+vtmp

	sqlmatriz(1)="select a.*, l.detalle as detalinea, IFNULL(s.stocktot,0) as stocktot,IFNULL(u.fecha,'') as fechaact  from articulos a "
	sqlmatriz(2)=" left join lineas l on l.linea = a.linea "
	sqlmatriz(3)=" left join articulostock s on s.articulo = a.articulo left join ultimoartcosto u on a.articulo = u.articulo " 
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
	sqlmatriz(1)="select l.*, c.habilitado from listaprecioc l left join financiacion c on l.idfinancia = c.idfinancia  " 
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

	SELECT p.idlista, SUBSTR(p.detalle+SPACE(200),1,200) as detallep, p.vigedesde, p.vigehasta, p.margen as margenp, p.condvta, p.idlistap, p.actualiza, l.idlistah, ;  
		a.articulo, SUBSTR(a.detalle+SPACE(200),1,200) as detalle, a.unidad, a.abrevia, a.codbarra, a.costo as costoa, a.linea,a.detalinea, a.ctrlstock, a.ocultar, ;
		a.stockmin,a.stocktot, a.desc1, a.desc2, a.desc3,  a.desc4,  a.desc5, a.moneda, ;
		a.costo as pcosto, l.margen , a.costo as pventa , i.razon as razonimpu, a.costo as impuestos, a.costo as pventatot,l.fechaact ;
	 	FROM &fvlistaprecioh_sql l ;
		LEFT JOIN &fvarticulos_sql a ON ALLTRIM(l.articulo)==ALLTRIM(a.articulo) ;
		LEFT JOIN &fvlistapreciop_sql p  ON l.idlista = p.idlista ;
		LEFT JOIN &fvarticulosimp_sql i  ON l.articulo = i.articulo ;
		INTO TABLE &fvlistasart 

	SELECT 'Lista Precio Base - Costos ' as detallep, a.articulo, a.detalle, ;
		a.unidad, a.abrevia, a.codbarra, a.costo as costoa, a.linea, a.detalinea, a.ctrlstock, a.ocultar, ;
		a.stockmin, a.stocktot, a.desc1, a.desc2, a.desc3,  a.desc4,  a.desc5, a.moneda, ;
		a.costo as pcosto, a.costo as pventa, i.razon as razonimpu, a.costo as impuestos, a.costo as pventatot,a.fechaact   ;
		FROM &fvarticulos_sql a ;
		LEFT JOIN &fvarticulosimp_sql i  ON a.articulo = i.articulo ;
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

*!*		SELECT * FROM &fvlistasart 			INTO TABLE &v_nombrearchivop	
*!*		SELECT idlistac, idlista, SUBSTR(detalle+SPACE(254),1,254) as detalle, cuotas, razon, idfinancia, habilitado   FROM &fvlistaprecioc_sql  	INTO TABLE &v_nombrearchivoc

	SELECT MAX(actualiza) as maxactual FROM &fvlistasart INTO CURSOR maximolis 
	SELECT &fvlistasart 
	UPDATE &fvlistasart SET actualiza=maximolis.maxactual
	SELECT maximolis
	USE IN maximolis
	
	SELECT * FROM &fvlistasart 			INTO TABLE syslistaprea	
	SELECT idlistac, idlista, SUBSTR(detalle+SPACE(200),1,200) as detalle, cuotas, razon, idfinancia, habilitado   FROM &fvlistaprecioc_sql  	INTO TABLE syslistapreb	

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


	RETURN v_nombreretorno 

ENDFUNC 



FUNCTION getLogo
archi = _SYSESTACION+'\'+_SYSLOGOEMPRE
IF FILE(archi) THEN 
	RETURN archi
ENDIF 
RETURN ""

*** Función que arma el comprobante en un archivo XML**
* Busca en la Base de Datos los datos de la factura según el ID pasado como parámetro, 
* Utiliza la función CURSORTOXML, el formato del nombre xml es: 'factura_<idFactura>', donde <idFactura> es el ID en la tabla facturas
** Recibe como parámetro el IDFactura


FUNCTION armarComprobanteXML
PARAMETERS p_idFactura


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
			
		
			
			SELECT f.*,f.cuit as nrodoccli, f.neto as netocomp,i.impuesto,i.detalle, i.neto as netoimpu ,i.razon, i.importe,i.codigoafip,i.tipoafip,i.detafip ;
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
			
			** CBU Para autorización de Comprobantes MiPyMEs **
				v_opcionCBU	= IIF(ALLTRIM(_SYSCBUMIPYME)='0','',ALLTRIM("2101,"+_SYSCBUMIPYME))
			
			** ALIAS Para autorizacion de Comprobantes MiPyMES
				v_opcionALIAS =  IIF(ALLTRIM(_SYSALIASMIPYME)='0','',ALLTRIM("2102,"+_SYSALIASMIPYME))
				
			** Informar si se transmite de modo: 
			** Agente de Depósito Colectivo (ADC) o 
			** Sistema de Circulación Abierta de la Cámara de Compensación Electrónica de la República Argentina (SCA - COELSA)
				v_modoADCoSCA =  "27,SCA"
			
			** Informar si NC / ND es de anulación
				v_opcionNCNDANULA = "22,N"
			
			v_opcionales = ""
			DO CASE
			** Facturas 
			CASE v_idtipocomp = v_tipoFA_MiPyme 
				v_opcionales = v_opcionCBU+";"+v_opcionALIAS+";"+v_modoADCoSCA	
				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoFB_MiPyme 
				v_opcionales = v_opcionCBU+";"+v_opcionALIAS+";"+v_modoADCoSCA			
				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)
			CASE v_idtipocomp = v_tipoFC_MiPyme 
				v_opcionales = v_opcionCBU+";"+v_opcionALIAS+";"+v_modoADCoSCA							
				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)


			** Notas de Crédito 
			
			CASE v_idtipocomp = v_tipoNCA_MiPyme 
				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNCB_MiPyme 
				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNCC_MiPyme 
				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			** Notas de Débito
			
			CASE v_idtipocomp = v_tipoNDA_MiPyme 
				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNDB_MiPyme 
				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			CASE v_idtipocomp = v_tipoNDC_MiPyme 
				v_opcionales = v_opcionNCNDANULA 
*				v_fecha30dias = dtos((cftofc(tablaFactura.fecha))+30)		
			OTHERWISE
				v_opcionales = ""
			ENDCASE
			
						
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


*** Función que los comprobantes asociados en un archivo XML**
* Busca en la Base de Datos los datos del comprobante asociados al comprobate de la tabla Facturas cuyo ID es pasado como parámetro, 
* Utiliza la función CURSORTOXML, el formato del nombre xml es: 'asociados_factura_<idFactura>', donde <idFactura> es el ID en la tabla facturas
** Recibe como parámetro el IDFactura

FUNCTION armarCompAsociadosFacXML
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
			sqlmatriz(4)=" where l.idregistroa = "+ ALLTRIM(STR(v_idfactura))+" and l.idcomprobaa = "+ALLTRIM(STR(p_idcomproba))

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
			sqlmatriz(4)=" where l.idregistrob = "+ ALLTRIM(STR(v_idfactura))+" and l.idcomprobab = "+ALLTRIM(STR(p_idcomproba))

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

FUNCTION UpDwViFile
PARAMETERS pud_path, pud_arch, pud_updw, pud_conex, pud_tabla, pud_cpoix, pud_valid, pud_cponom, pud_cpoar

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

*!*	*****
*!*	*Funcion que cambia la fecha del comprobante pasado como parámetro a la fecha actual
*!*	*
*!*	*Parametros:ID del comprobante, tabla
*!*	*Retorna True o False en caso de que se haya registrado correctamente o no 
*!*	*****

*!*	FUNCTION  actualizarFechaComp
*!*	PARAMETERS p_idregistro, p_tabla


*!*		v_retorno = .F.
*!*		IF p_idregistro > 0
*!*			
*!*			v_fechaActual = DTOS(DATE())
*!*			*** Modifico la cabecera del reclamo ***
*!*			DIMENSION lamatriz(1,2)
*!*			
*!*			
*!*			lamatriz(1,1)='fecha'
*!*			lamatriz(1,2)="'"+ALLTRIM(v_fechaActual)+"'"
*!*			
*!*			vconeccionA=abreycierracon(0,_SYSSCHEMA)	
*!*			
*!*			p_tipoope   = 'U'
*!*			p_condicion = "idfactura = "+ALLTRIM(STR(p_idregistro))
*!*			v_titulo    = " EL MODIFICACION "
*!*			p_tabla     = ALLTRIM(v_tabla)
*!*			p_matriz    = 'lamatriz'
*!*			p_conexion  = vconeccionA
*!*			IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*			    MESSAGEBOX("Ha Ocurrido un Error en ",0+48+0,"Error")

*!*			   v_retorno = .F.
*!*			  ELSE
*!*			  v_retorno = .T.
*!*			ENDIF  
*!*				* me desconecto	
*!*			=abreycierracon(vconeccionA,"")
*!*		ELSE
*!*			v_retorno = .F.
*!*		ENDIF 
*!*			RETURN v_retorno

*!*	ENDFUNC 


*****
*Funcion que cambia la fecha del comprobante y el CUIT
*
*Parametros:ID del comprobante, tabla
*Retorna True o False en caso de que se haya registrado correctamente o no 
*****

FUNCTION  actualizarComp
PARAMETERS p_idregistro, p_tabla


	v_retorno = .F.
	IF p_idregistro > 0
	
	
	
	
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
					DIMENSION lamatriz(2,2)
					
					
					lamatriz(1,1)='fecha'
					lamatriz(1,2)="'"+ALLTRIM(v_fechaActual)+"'"
					lamatriz(2,1)='CUIT'
					lamatriz(2,2)="'"+ALLTRIM(v_cuitEntidad)+"'"
					
					
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

*** Retorna el tipo de movimiento registrado según el comprobante, el tipo de pago, la cuenta y la caja
** Parametros:
**		P_idtipocompro: ID del tipo de comprobante
**		P_idtipopago: ID del tipo de pago que se está realizando
**		P_idcajareca: ID de la caja registradora (SI es 0, significa que va a obtener cualquier caja)
**		P_idcuenta: ID de la cuenta (SI es 0, significa que va a obtener cualquier cuenta)
**
** Retorno: Retorna el movimiento registrado para la combinación de parámetros
***
FUNCTION movimientoTPago
PARAMETERS P_idtipocompro, P_idtipopago, P_idcajareca, P_idcuenta

	
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
***
FUNCTION guardarMoviTPago
PARAMETERS p_idtipopago, p_tabla, p_campo, p_idregistro, p_idcajareca,p_idcuenta,P_idtipocompro, p_tablacp, p_campocp, p_idregistrocp
			
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
	
	vconeccionMo = abreycierracon(0,_SYSSCHEMA)
	
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
***
FUNCTION moviTipoPago
PARAMETERS p_idtipopago,p_idcaja,p_idcuenta,p_tabla,p_campo,p_idregistro,p_movimiento,p_tablaRet

*!*		IF p_idtipopago < 0 OR p_idcaja < 0 OR p_idcuenta OR ALLTRIM(p_tablaRet) == "" OR p_idregistro < 0
*!*		
*!*			RETURN .F.
*!*		
*!*		ENDIF 

	tipoPagoObj 	= CREATEOBJECT('tipospagosclass')


	v_idtipoCupones = tipoPagoObj.gettipospagos("CUPONES")
	v_idTipoCheque 	= tipoPagoObj.gettipospagos("CHEQUE")



	v_registro = IIF(EMPTY(ALLTRIM(p_tabla)) = .T. or EMPTY(ALLTRIM(p_campo)) = .T. or p_idregistro = 0,.F.,.T.)

	v_valorTp= IIF(P_idtipopago > 0," and u.idtipopago = "+ALLTRIM(STR(p_idtipopago)),"")
	v_valorCa=IIF(P_idcaja > 0," and u.idcajareca = "+ALLTRIM(STR(P_idcaja)),"")
	v_valorCu=IIF(P_idcuenta > 0," and u.idcuenta = "+ALLTRIM(STR(P_idcuenta)),"")
	v_valorRe=IIF(p_idregistro > 0," and u.tabla = '"+ALLTRIM(p_tabla)+ "' and u.campo = '"+ALLTRIM(p_campo)+"' and u.idregistro = "+ALLTRIM(STR(p_idregistro)),"")
	v_valorMo=IIF(EMPTY(ALLTRIM(p_movimiento)) =.F.," and u.movimiento = '"+ALLTRIM(p_movimiento)+"'","")

	
	v_condicion = ALLTRIM(v_valorTP)+ALLTRIM(v_valorCa)+ALLTRIM(v_valorCu)+ALLTRIM(v_valorRe)+ALLTRIM(v_valorMo)
	MESSAGEBOX(v_condicion)
	vconeccionMo = abreycierracon(0,_SYSSCHEMA)
	
	DO CASE
		CASE p_idtipopago == 0 && Todos los tipos de pagos
			sqlmatriz(1)=" select u.* "
			sqlmatriz(2)=" from ultimomovitpago u "
			sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)
	
		CASE v_idtipoCupones == p_idtipopago && Cupones

			sqlmatriz(1)=" select u.*,c.idtarjeta,c.numero,c.tarjeta,c.fecha as fechatar, c.importe, c.vencimiento as venc, c.titular,c.codautoriz"
			sqlmatriz(2)=" from ultimomovitpago u "
			sqlmatriz(3)=" left join cupones c on u.idregistro = c.idcupon "
			sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)
		CASE v_idTipoCheques == p_idtipopago && Cheques
			sqlmatriz(1)=" select u.*,c.serie, c.numero,c.importe,c.fechaemisi, c.fechavence,c.alaorden,c.librador,c.loentrega,c.cuit, "
			sqlmatriz(2)=" c.cuenta,c.idbanco,c.codcheque,c.detercero,c.lugaremi,c.domilib,c.electro "
			sqlmatriz(3)=" from ultimomovitpago u "
			sqlmatriz(4)=" left join cheques c on u.idregistro = c.idcheque "
			sqlmatriz(5)=" where 1 = 1 "+ALLTRIM(v_condicion)
		
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

*/ Contabilizacion de Operaciones
* Recibe como parametros la tabla, el Idregistro y la conexion, 
* Verifica que el registro de la tabla pasada ya no esté contabilizado , si es asi no contabiliza, 
* de otra manera genera y graba el asiento.
*  RETORNA : NUMERO DE ASIENTO GENERADO "IDASIENTO", 
* 		   : 0 SI NO GENERO EL ASIENTO 
*		   : -1 SI NO LO GENERÓ Y EL OPERADOR DEBIERA INGRESARLO, esto se controla con una variable publica : _SYSMCONTABLE de seteo 
*			que indica si el operador debe ingresar o no los asientos al no encontrar un modelo adecuado
*          : -2 NO Generó el Asiento porque no está habilitado el Módulo Contable

FUNCTION ContabilizaMov
	PARAMETERS pcont_tabla, pcont_id, pcont_conex
	
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
		sqlmatriz(1)= " select t.idcomproba, c.astoconta from "+ALLTRIM(pcont_tabla)+" t "
		sqlmatriz(2)= " left join comprobantes c on c.idcomproba = t.idcomproba "
		sqlmatriz(3)= " where "+ALLTRIM(vnombreidx)+" = "+alltrim(STR(pcont_id))
		
		verror=sqlrun(vcone_conta ,"asentar_sql")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la busqueda movimientos de tablas ",0+48+0,"Error")
		    RETURN ""  
		ENDIF	
		SELECT asentar_sql
		
		IF asentar_sql.astoconta = 'N' THEN 
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



*/ Contabilizacion de Operaciones Manuales
* Recibe como parametros la tabla, el Idregistro y la conexion, 
* Verifica que el registro de la tabla pasada ya no esté contabilizado , si es asi no contabiliza, 
* de otra manera genera y graba el asiento.
*  RETORNA : NUMERO DE ASIENTO GENERADO "IDASIENTO", 
* 		   : 0 SI NO GENERO EL ASIENTO 

FUNCTION ContabilizaManual
	PARAMETERS pcont_tabla, pcont_id, pcont_conex, pcont_tasiento
	
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


** Funcion de Llamada a Contabilizar los comprobantes recibidos como parametros. 
* Parametros:
* 		pcomp_tabla : Tabla que contiene el registro del comprobante a contabilizar
*		pcomp_id	: id del registro a buscar para contabilizar
*		pcomp_con	: conexion a la base de datos , si es 0, entonces abre una nueva conexion, sino usa una abierta
*		pcomp_impo 	: Importe total del comprobante a contabilizar, si es para contabilización manual	
FUNCTION ContabilizaCompro
	PARAMETERS pcomp_tabla, pcomp_id, pcomp_con, pcomp_impo
	v_idasienton= ContabilizaMov(pcomp_tabla,  pcomp_id, pcomp_con )
	IF v_idasienton = -1 THEN 
		v_idasienton = ContabilizaManual(pcomp_tabla,  pcomp_id, pcomp_con,pcomp_impo)
	ENDIF 
	RETURN v_idasienton
ENDFUNC 





*** Retorna el tipo de movimiento registrado según el comprobante, el tipo de pago, la cuenta y la caja
** Parametros:
**		P_idtipocompro: ID del tipo de comprobante
**		P_idtipopago: ID del tipo de pago que se está realizando
**		P_idcajareca: ID de la caja registradora (SI es 0, significa que va a obtener cualquier caja)
**		P_idcuenta: ID de la cuenta (SI es 0, significa que va a obtener cualquier cuenta)
**
** Retorno: Retorna el movimiento registrado para la combinación de parámetros
***
FUNCTION movimientoTPago
PARAMETERS P_idtipocompro, P_idtipopago, P_idcajareca, P_idcuenta

	
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




*!*	*** Guardo un registro en la tabla de movitpago
*!*	** PARAMETROS: 
*!*	**	P_idtipopago: ID del tipo de pago que se quiere registrar
*!*	**	P_tabla: Nombre de la tabla asociada al tipo de pago ('CHEQUE', 'CUPON'...) 
*!*	**	P_campo: Nombre del campo indice de la tabla
*!*	**	P_idregistro: Numero de registro de la tabla correspondiente al campo pasado como parámetro
*!*	**	P_idacajareca: ID de la caja recaudadora (Si es 0 se puede tomar como que es para cualquier caja) 
*!*	**	P_idcuenta: ID de la cuenta (Si es 0 se puede tomar como que es para cualquier caja)
*!*	**  P_idcomproba: ID del tipo de comprobante 
*!*	**	Retorno: Retorna True si se guardó correctamente, False en otro caso
*!*	***
*!*	FUNCTION guardarMoviTPago
*!*	PARAMETERS p_idtipopago, p_tabla, p_campo, p_idregistro, p_idcajareca,p_idcuenta,P_idtipocompro
*!*				
*!*		v_retorno = .F.	
*!*		
*!*		v_movimiento	=  movimientoTPago(P_idtipocompro, P_idtipopago, P_idcajareca, P_idcuenta)

*!*		IF EMPTY(ALLTRIM(v_movimiento)) == .T. && No retorno ningún movimiento, no se va a registrar el movimiento
*!*			v_retorno = .F.
*!*			RETURN v_retorno
*!*		
*!*		ENDIF 


*!*		v_fecha			= DTOS(DATE())
*!*		v_hora			= TIME()
*!*		
*!*		
*!*		DIMENSION lamatriz3(10,2)
*!*		
*!*			
*!*		lamatriz3(1,1)='idmovitp'
*!*		lamatriz3(1,2)= "0"
*!*		lamatriz3(2,1)='idtipopago'
*!*		lamatriz3(2,2)= ALLTRIM(STR(p_idtipopago))
*!*		lamatriz3(3,1)='tabla'
*!*		lamatriz3(3,2)= "'"+ALLTRIM(P_tabla)+"'"
*!*		lamatriz3(4,1)='campo'
*!*		lamatriz3(4,2)= "'"+ALLTRIM(P_campo)+"'"
*!*		lamatriz3(5,1)='idregistro'
*!*		lamatriz3(5,2)= ALLTRIM(STR(P_idregistro))
*!*		lamatriz3(6,1)='idcajareca'
*!*		lamatriz3(6,2)= ALLTRIM(STR(P_idcajareca))
*!*		lamatriz3(7,1)='idcuenta'
*!*		lamatriz3(7,2)=ALLTRIM(STR(P_idcuenta))
*!*		lamatriz3(8,1)='fecha'
*!*		lamatriz3(8,2)="'"+ALLTRIM(v_fecha)+"'"
*!*		lamatriz3(9,1)='hora'
*!*		lamatriz3(9,2)="'"+ALLTRIM(v_hora)+"'"
*!*		lamatriz3(10,1)='movimiento'
*!*		lamatriz3(10,2)="'"+ALLTRIM(v_movimiento)+"'"
*!*		
*!*		vconeccionMo = abreycierracon(0,_SYSSCHEMA)
*!*		
*!*		p_tipoope     = 'I'
*!*		p_condicion   = ''
*!*		v_titulo      = " EL ALTA "
*!*		p_tabla     = 'movitpago'
*!*		p_matriz    = 'lamatriz3'
*!*		p_conexion  = vconeccionMo
*!*		IF SentenciaSQL(p_tabla,p_matriz,p_tipoope,p_condicion,p_conexion) = .F.  
*!*		    MESSAGEBOX("Ha Ocurrido un Error en "+v_titulo,0+48+0,"Error")
*!*		
*!*			=abreycierracon(vconeccionMo ,"")	

*!*		    RETURN .F.
*!*		ENDIF	
*!*		=abreycierracon(vconeccionMo ,"")	
*!*		RETURN .T.

*!*	ENDFUNC 

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
***
FUNCTION moviTipoPago
PARAMETERS p_idtipopago,p_idcaja,p_idcuenta,p_tabla,p_campo,p_idregistro,p_movimiento,p_tablaRet

*!*		IF p_idtipopago < 0 OR p_idcaja < 0 OR p_idcuenta OR ALLTRIM(p_tablaRet) == "" OR p_idregistro < 0
*!*		
*!*			RETURN .F.
*!*		
*!*		ENDIF 


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
			sqlmatriz(1)=" select u.* "
			sqlmatriz(2)=" from ultimomovitpago u "
			sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)
	
		CASE v_idtipoCupones == p_idtipopago && Cupones

			sqlmatriz(1)=" select u.*,c.idtarjeta,c.numero,c.tarjeta,c.fecha as fechatar, c.importe, c.vencimiento as venc, c.titular,c.codautoriz"
			sqlmatriz(2)=" from ultimomovitpago u "
			sqlmatriz(3)=" left join cupones c on u.idregistro = c.idcupon "
			sqlmatriz(4)=" where 1 = 1 "+ALLTRIM(v_condicion)
		CASE v_idTipoCheque == p_idtipopago && Cheques
			sqlmatriz(1)=" select u.*,c.serie, c.numero,c.importe,c.fechaemisi, c.fechavence,c.alaorden,c.librador,c.loentrega,c.cuit, "
			sqlmatriz(2)=" c.cuenta,c.idbanco,c.codcheque,c.detercero,c.lugaremi,c.domilib,c.electro "
			sqlmatriz(3)=" from ultimomovitpago u "
			sqlmatriz(4)=" left join cheques c on u.idregistro = c.idcheque "
			sqlmatriz(5)=" where 1 = 1 "+ALLTRIM(v_condicion)
		
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
** Funcion para Anulación de Recibos y Ordenes de Pago
******************************************************

FUNCTION AnularRP
PARAMETERS pan_idcomproba, pan_idregistro

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
*************************************************************************************		
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
						
*!*				*Registracion Contable del Caja Ingreso/Egreso	

				nuevo_asiento = Contrasiento( 0,_SYSCONTRADH, v_tablaPor, pan_idregistro, 'anularp', v_idanulaRP)
		
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



*/* Carga un Contra-Asiento segun reciba el parametro del comprobante o del asiento origen
* Incerta el Asiento en la tabla asientos y devuelve el id de asiento generado
* Segun el ultimo parametro el asiento se invierte en columnas debe y haber o bien se carga
* en negativo en cada columna
* PARAMETROS
* pca_idasiento	:  idasiento del asiento a cancelar
* pca_DH		:  + . Invierte el asiento Manteniendo el signo en cada columna
*		  		   - . Mantiene los valores en las columnas pero con signo negativo 		  	
FUNCTION ContrAsiento
PARAMETERS pca_idasiento,pca_DH, pca_tablaOri, pca_idOri, pca_tablaDes, pca_idDes

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

		v_fecha			= asientoOri.fecha
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


*/* Manejo de funciones de Error para las conexiones FTP

PROCEDURE MENSAJE_ERROR
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


*** Función para guardar el Historico de actualización de costo del artículo ****
**Parametros: articulo: codigo del articulo a actualizar; costo: costo del articulo actualizado; coneccion: Conección a la Base de Datos
**            fechahisto: fecha y hora para registrar la grabacion del historico de costos
** Retorno: Retorna True si se Guarda correctamente, False en caso contrario
*******


FUNCTION guardaHistCostoArt
PARAMETERS p_articulo, p_costo, p_conexion,p_fechahisto

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



*-----------------------------------------------------------------------------------
* Obtiene el Saldo de Crédito disponible para la entidad pasada como parametro
*-----------------------------------------------------------------------------------


FUNCTION CreditoLimiteE
PARAMETERS  para_entidad, para_monto

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
	sqlmatriz(2)=" FROM ctactesaldo cc left join entidadescr cr on cc.entidad = cr.entidad  " 
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


*-----------------------------------------------------------------------------------
* Incerta y Elimina Articulos en los Grupos asociados a las Lineas de los Artículos. Parametro : '+' o '-'
*-----------------------------------------------------------------------------------

FUNCTION GruposArtLinea
PARAMETERS pl_articulo, pl_linea, pl_opera, pl_conexion
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




*-----------------------------------------------------------------------------------
* Incerta y Elimina Articulos en los Grupos asociados a las Lineas de los Materiales. Parametro : '+' o '-'
*-----------------------------------------------------------------------------------

FUNCTION GruposMatLinea
PARAMETERS pl_material, pl_linea, pl_opera, pl_conexion
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


* ----------------------------------------------------------------------------------------
*- Genera Registro en Tabla Etiquetas para los registros Pasados como parametros
*- Parametros : 
*-				TABLA    : Tabla que contiene el registro para el cual se generara la etiqueta
*-              ID       : Valor del Indice para la generación de la Etiqueta
*-              CANTIDAD : Cantidad de Etiquetas a Generar
*- Retorna el indice de las etiquetas generadas : Primer Etiqueta y Ultima Etiqueta 
*- formato : DDDDDDDDDD;DDDDDDDDDD
*-----------------------------------------------------------------------------------------
FUNCTION GeneraEtiquetas
PARAMETERS pge_tabla, pge_id, pge_detalle, pge_cantidad


	v_nomIndice	 = obtenerCampoIndice(ALLTRIM(pge_tabla))
	
	v_TipoIndice = TYPE("pge_id")
	IF v_TipoIndice ='C' THEN 
		pge_idc = "'"+ALLTRIM(pge_id)+"'"
	ELSE
		pge_idc = ALLTRIM(STR(pge_id))
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
					
		DIMENSION lamatriz3(8,2)
					
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



*-----------------------------------------
*- Impresión de Etiquetas, recibe como parametro una tabla o un rango de Etiquetas 
*- con el listado de etiquetas a Imprimir y el modo de etiqueta seleccionado
*- BC: Codigo de Barras, QR : Codigo QR
*--------------------------------------------
FUNCTION PrintEtiquetas
PARAMETERS par_etiqueimp, par_etiquetaINI, par_etiquetaFIN, par_BCQR

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




*---VERIFICA AL INTEGRIDAD REFERENCIA DE DATOS-----------------------
*- Busqueda de un valor y un campo dado en una tabla en 
*- Las Tablas Restantes del Esquema
*- Devuelve vacio si el valor ingresado no existe en las otras tablas
*- Si existe devuelve la primer tabla en la que se encuentra
*- PARAMETER : tabla: nombre tabla origen de datos
*-			   campo: nombre del campo 
*-             valor: valor del campo a buscar,
*-              modo: modo de busqueda, 0 busca todas las ocurrencias, 1 busca la primer ocurrencia
*--------------------------------------------------------------------
FUNCTION FindInTables
PARAMETERS fi_tabla, fi_campo, fi_valor, fi_modo
	
	ptablareto = ""

	vconeccionF=abreycierracon(0,_SYSSCHEMA)

	sqlmatriz(1)= " SELECT TABLE_NAME as tablash FROM information_schema.columns where TRIM(TABLE_SCHEMA) = '"+_SYSSCHEMA+"' and TRIM(TABLE_NAME) <> '"+ALLTRIM(fi_tabla)+"' AND TRIM(COLUMN_NAME)= '"+ALLTRIM(fi_campo)+"'" 
	sqlmatriz(2)= " and TRIM(TABLE_NAME) not in ( SELECT TRIM(TABLE_NAME) FROM information_schema.tables WHERE TRIM(TABLE_TYPE)='VIEW') "
	verror=sqlrun(vconeccionF,"tablas_hijas")
	IF verror=.f.
		MESSAGEBOX("No se puede obtener las Tablas de "+_SYSSCHEMA,0+16,"Advertencia")
		RETURN 
	ENDIF 
	
	SELECT tablas_hijas
	GO TOP 
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
		ENDIF  
		USE IN existe 
		SELECT tablas_hijas
		IF fi_modo > 0 THEN 
			GO BOTTOM 			
		ENDIF 
		SKIP 
	ENDDO 
	USE IN tablas_hijas
	vconeccionF=abreycierracon(vconeccionF,"")
	
	RETURN ptablareto 
ENDFUNC 



*** Elimina todas las dependencias del registro pasado como parámetro. ****
** Parametros:
***			p_tabla: Tabla asociada al registro, desde esta tabla se buscan las tablas relacionadas
***			p_campo: Campo de las tablas a eliminar
***			p_valor: Valor del registro a eliminar
** Retorno: Retorna True en caso que se hayan eliminado todas las dependencias del registro, False en otro caso
*******
FUNCTION eliminarRegistros
PARAMETERS p_tabla,p_campo,p_valor

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
						MESSAGEBOX("Se ha eliminado el registro correctamente",0+64+0,"Registro eliminado")
						RETURN .T.
					ENDIF 
				ENDIF 
			
				RETURN .F.
						
			
ENDFUNC 



*- devuelve el codigo del material o bien el idmate, dependiendo 
*- de la conversion que se le pida especificada en Modo
*- pca_modo = 'ID' OR 'CO'
*- ID = devuelve IDMATE buscando con CODIGOMAT
*- CO = devuelve CODIGOMAT buscando con IDMATE 

FUNCTION CambiaIDCodigomat
PARAMETERS pca_codigo,pca_modo, pca_conex 
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


*- Devuelve el Nombre de Una Tabla conteniendo las Etiquetas 
*- que contiene un lote de Lectura Batch de Etiquetas
*- pl_tablaeti: nombre de la tabla para seleccion de etiquetas
*- devuelve el nombre de la tabla con los datos de la consulta o vacio si no selecciona nada
FUNCTION BuscaLoteEti
PARAMETERS pl_tablaeti
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
				ENDIF 
				
			***********************************************************************************************

****************************
				USE IN etiquetasleidas_sql 
				USE IN articulosleidos_sql 
				SELECT seleccetiquetas
				APPEND FROM articulosleidos
				USE IN seleccetiquetas
				USE IN articulosleidos
				cretorno = "seleccetiquetas"
				
			ENDIF 

		ELSE 
		
		ENDIF 

		=abreycierracon(vconeccionF,"")	

	ENDIF 

RETURN cretorno
ENDFUNC


*--------------------------------------------------------------------------------------------
**Función para pedir autorización para realizar la función pasada como parámetro
** Busca en la base de datos si corresponde pedir autorización según el usuario y la función.
** Genera un pedido de autorización que deberá autorizar un usuario habilitado para ello
**
** Parametros: p_funcion: nombre clave de la función que se desea autorizar
**
** Retorno: Retorna True en caso de que el usuario esté autorizado. False en otro caso
*--------------------------------------------------------------------------------------------


FUNCTION pedirAutorizacion
PARAMETERS p_funcion, p_detalleauto

	
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






*-----------------------------------------------------------------------------------
** Obtiene todos los pedidos de autorización 
** Parámetros:  p_nombreTabla: nombre de la tabla donde se van a cargar los pedidos
**				p_estado: estado de los pedidos a listar (Puede ser 'A', 'P' o 'N')
** Retorno: True si se cargó correctamente, False en caso contrario
*-----------------------------------------------------------------------------------


FUNCTION obtienePedidosAutorizacion
PARAMETERS  p_nombreTabla,p_estado 

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



*-----------------------------------------------------------------------------------
** Obtiene todas las cotizaciones y precios segun listas y cuotas para un artículo determinado 
** Parámetros:  p_articulos  - Lista de Articulos a mostrar
*-----------------------------------------------------------------------------------


FUNCTION PreciosArticulo
PARAMETERS  pv_articulos

	pv_articulos = STRTRAN(STRTRAN(STRTRAN(pv_articulos,"´","'"),"(","'"),")","'")
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
	ENDIF 
	
	
*	SELECT * FROM syslistaprea INTO TABLE &vprecioartic WHERE ALLTRIM(articulo) in ( &pv_articulos ) ORDER BY articulo GROUP BY articulo 
	SELECT * FROM syslistaprea INTO TABLE &vprecioartic WHERE 1 = 1 &v_condicion ORDER BY articulo GROUP BY articulo 

	SELECT * FROM syslistaprea INTO TABLE &vprecioartia WHERE 1 = 1 AND idlista > 0 &v_condicion ORDER BY idlista 
	
	SELECT a.idlistah, a.articulo, a.detalle as detalleart, a.pventa as pventaa, a.impuestos as impuestosa, a.pventatot as pventatota,a.detallep as detalista,  b.*, razon as pventa, razon as impuestos, razon as pventatot, ;
			razon as entrega, razon as impcuota ;
		FROM syslistapreb b LEFT JOIN syslistaprea a ON  a.idlista = b.idlista INTO TABLE &vprecioartib WHERE b.idlista in ( SELECT idlista FROM &vprecioartia ) ;
		AND b.habilitado = 'S' AND ALLTRIM(a.articulo) in ( SELECT ALLTRIM(articulo) FROM &vprecioartia ) ORDER BY  b.idlista , b.cuotas

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
	sqlmatriz(1)=" SELECT s.*, d.detalle as nombredep FROM depostock s left join depositos d on s.deposito = d.deposito where 1 = 1 "+v_condicion  &&TRIM(articulo) in ( "+ALLTRIM(pv_articulos)+" ) "
	verror=sqlrun(vconeccionD ,"depostock_sql")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la busqueda del Stock por Depósitos... ",0+48+0,"Error")
	    RETURN .F.
	ENDIF
	=abreycierracon(vconeccionD ,"")	

	SELECT * FROM depostock_sql INTO TABLE &vprecioartid  ORDER BY articulo , deposito
	SELECT &vprecioartid
	INDEX on ALLTRIM(articulo) TAG articulo 
	
	USE IN depostock_sql			 

	USE IN &vprecioartia
	USE IN &vprecioartib 
	USE IN &vprecioartic 
	USE IN &vprecioartid 

*		SELECT &vprecioartia 
*		INDEX on idlistah TAG idlista 
*!*		
*!*		SELECT &vprecioartib 
*!*		SET RELATION TO idlista INTO &vprecioartia
*!*		SET RELATION TO 
	
	RETURN vprecioarti	
	
ENDFUNC 



*-----------------------------------------------------------------------------------
** Elimina El Asiento Contable pasado como parametro
** Retorna 0 si lo pudo eliminar, sino retorna el numero del asiento
*-----------------------------------------------------------------------------------
FUNCTION EliminaAsientoC
PARAMETERS pe_idasiento


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

*//////////////////////////////////////
*/ Determina el Filtro de Observación a aplicar en funcion
*/ del filtrado que aplica al comprobante recibido como parametros
*//////////////////////////////////////

FUNCTION FiltroObserva
PARAMETERS pf_tabla, pf_idregi, pf_vconeccion
	
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
	
*//////////////////////////////////////
*/ Obtiene la observación correspondiente según los filtros para la tabla, campo e id
*/ Y registra opcionalmente en la tabla observareg
* Parametros:
* p_tabla; p_campo; p_idregistro: tabla, campo y registro de la cual se va a obtener la observación 
* p_coneccion: conección a utilizar
* p_registrar: Si es Verdadero: registra la observación obtenida en la tabla observareg; si es Falso, la obtiene de la tabla sin registrar
*//////////////////////////////////////

FUNCTION obtenerObservaComp
PARAMETERS p_tabla,p_campo,p_idregistro,p_coneccion,p_registrar

	v_idregistrostr =IIF((UPPER(type("p_idregistro"))='I' or UPPER(type("p_idregistro"))='N'),ALLTRIM(STR(p_idregistro)),"'"+ALLTRIM(p_idregistro)+"'")	
	IF EMPTY(ALLTRIM(p_tabla)) = .T. OR EMPTY(ALLTRIM(p_campo)) = .T. OR EMPTY(ALLTRIM(v_idregistrostr))= .T. OR EMPTY(ALLTRIM(p_tabla)) = .T. 
	
		RETURN ""
	
	ELSE
	
	
		
	
		IF p_registrar = .T. && Registra en base de datos y retorna la observacion
		
			v_observaFijo = FiltroObserva(p_tabla, v_idregistrostr,p_coneccion)		
			
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


*//////////////////////////////////////
*/ Guarda el Seteo de la Clave de Acceso para aquellos usuarios que quieren salvar el passwd de acceso
* Parametros:
*  psv_accion	: A=ACTUALIZA O R=RECUPERA  CARACTER
*  psv_usuario	: Nombre de Usuario 		CARACTER
*  psv_passw	: Password o Clave			CARACTER
*  psv_esquema	: Esquema al que se conecta CARACTER
*  psv_save		: .t.= Salva Acceso, .f.= No Salva el Acceso LOGICO
*  psv_llave	: LLave para encriptacion CARACTER
*//////////////////////////////////////

FUNCTION SavePasswd
	PARAMETERS psv_accion, psv_usuario, psv_passw, psv_esquema, psv_save, psv_llave
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



*//////////////////////////////////////
*/ Retorna un conjunto de valores de registros de una tabla seleccionados al azar
*/ recibe como parametros la tabla y la cantidad de registros al azar a devolver
*/ devuelve un archivo tipo texto con los indices seleccionados con extension .rnd
* Parametros:
*  rnd_tabla	: Nombre de la Tabla a elegir    CARACTER
*  rnd_cantidad : Cantidad de registros a elegir INTEGER
*//////////////////////////////////////

FUNCTION RandomSele
	PARAMETERS rnd_tabla, rnd_cantidad 
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





*//////////////////////////////////////
*/ Obtiene el costo historico por articulos dada una Fecha
*/ Devuelve el costo historico a la fecha pasada para todos los articulos
* Parametros:
* p_fecha: Fecha para el Calculo del Costo Histórico, si fecha es vacia devuelve el ultimo costo ingresado
* p_coneccion: conección a utilizar
* p_tablaret: Nombre de la tabla en la que devolverá el costo historico para todos los artículos
*//////////////////////////////////////

FUNCTION ArtiCostoHisto
PARAMETERS p_fechahisto,p_tablahisto, p_coneccion

	IF (UPPER(type("p_coneccion"))='I' or UPPER(type("p_coneccion"))='N')  THEN 
		IF p_coneccion = 0 THEN 
			pv_coneccion = abreycierracon(0,_SYSSCHEMA)
		ELSE 
			pv_coneccion = p_coneccion
		ENDIF 
	ELSE 
		pv_coneccion = abreycierracon(0,_SYSSCHEMA)
	ENDIF 
	
	sqlmatriz(1)=" select * from articostos where concat( articulo,'-',fecha )  in ( select concat(articulo,'-',max(fecha)) as fecha "
	sqlmatriz(2)=" from articostos where mid(fecha,1,8) <= '"+ALLTRIM(p_fechahisto)+"'  group by articulo ) order by articulo"
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



*//////////////////////////////////////
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
*//////////////////////////////////////

FUNCTION FCAdeudadas
PARAMETERS pv_entidad, pv_servicio, pv_cuenta, pv_fechaven, pv_idfactura, pv_insert, pv_tmp, p_coneccion

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
			USE alldeudas IN 0 
		ELSE
			* Obtengo la deuda todos los comprobantes 
			sqlmatriz(1)=" select s.idfactura, s.saldof, f.fecha, f.fechavenc1, f.fechavenc2, f.fechavenc3, f.entidad, f.servicio, f.cuenta, "
			sqlmatriz(2)=" f.tipo, p.puntov, f.numero, f.total "
			sqlmatriz(3)=" from facturasaldo s left join facturas f on f.idfactura = s.idfactura "
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
	&v_condicionid  AND ( EMPTY(fechavenc1) AND fecha <= pv_fechaven) OR ( !EMPTY(fechavenc1) AND (fechavenc1 <= pv_fechaven) ) 
	
	
	
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





*//////////////////////////////////////
*/ Obtiene las facturas y cuotas adeudadas filtradas por fecha de comprobante
*/ Devuelve una tabla con los datos de la facturas, cuotas
* Parametros:
* p_FechaIni: Fecha de Inicio del periodo de busqueda
* p_FechaFin: Fecha de Fin del periodo de busqueda
* p_nomTablaTmp: Nombre de la tabla temporaria donde se van a guardar los datos consultados
* pv_conexion: puntero de la conexion a la base de datos
* Retorno: Devuelve True si la función termino correctamente, False en otro caso. Además devuelve la consulta en una tabla con el nombre pasada como parámetro.
* Aclaración: Si el comprobante no tiene cuotas, la columna idcuotafc tendra valor = 0
*//////////////////////////////////////
FUNCTION facturasCtasAdeudadas
PARAMETERS p_fechaIni, p_fechaFin, p_nomTablaTmp, p_coneccion

	
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
	sqlmatriz(2)= " fc.cobrado as cobradocta,fc.saldof as saldofcta,ft.fechavenc as fecvencta,c.comprobante as nomcomp " 
	sqlmatriz(3)= " FROM facturasaldo fs left join facturasctasaldo  fc on fs.idfactura = fc.idfactura left join facturas f on fs.idfactura = f.idfactura  "
	sqlmatriz(4)= " left join facturascta ft on fc.idcuotafc = ft.idcuotafc left join comprobantes c on f.idcomproba = c.idcomproba " 
	sqlmatriz(5)=" where f.fecha >= '"+ALLTRIM(p_fechaIni) + "' and f.fecha <='" +ALLTRIM(p_fechaFin)+"'"
	
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

*//////////////////////////////////////
*/ Agrega un parametro a la funcion
*/ Devuelve la funcion pasada con el nuevo paràmetro
* Parametros:
* p_funcion: Funciòn a la que se le va a agregar un paràmetro
* p_parametro: Paràmetro a agregar

*//////////////////////////////////////
FUNCTION agregarParamaetro
PARAMETERS p_funcion,p_parametro

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
** Funcion Genera Comprobante de Vinculos entre Facturas y Recibos o Pagos
** Regostra Vinculos y Libreraciones de Comprobantes
** Parametros: 	pv_tipovin		= V/D Vincula o Desvincula Comprobantes
** 				pv_idcomprobav	= ID del comprobante que cancela la Factura
**				pv_idregistrov	= ID registro del comprobante que cancela la factura 
**				pv_idfactuv		= ID de la factura de cliente o de la factura de proveedores cancelada
**				pv_importe		= importe de la operación aplicada o desvinculada
**
******************************************************

FUNCTION VinculoComp
PARAMETERS pv_tipovin, pv_idcomprobav, pv_idregistrov, pv_idfactuv, pv_importe 
	

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
			
		sino = MESSAGEBOX("¿Desea imprimir el Comprobante de Vínculación-Desvinculación?",4+32,"Imprimir")
			IF sino = 6
				*SI
				imprimirVinculoComp(v_idvinculo)

			ELSE
				*NO
			
			ENDIF 
	  
	  	
	  	
		=abreycierracon(vconeccionVi ,"")	
		RETURN .t. 
	ELSE 
		=abreycierracon(vconeccionVi ,"")	
		RETURN .f. 
	ENDIF 

ENDFUNC 



