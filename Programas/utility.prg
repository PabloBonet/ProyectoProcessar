 
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
QUIT 
CLOSE ALL 
CLOSE TABLES ALL 
SET SAFETY OFF 
SET DEFAULT TO C:\
*DELETE FILE &MIESTACION\TEMP\*.* &MIPAPELERA 
*RMDIR &MIESTACION\TEMP
*DELETE FILE &MIESTACION\*.* &MIPAPELERA
*RMDIR &MIESTACION
CLEAR EVENTS 
CLEAR DLLS
RELEASE ALL EXTENDED
*=SQLDISCONNECT(0)
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
FUNCTION maxnumeroidx
PARAMETERS p_campoidx, p_tipo, p_tabla, v_incre 
v_tipoCampo = ""


vconeccionF = abreycierracon(0,_SYSSCHEMA)

IF p_tipo = 'I'
	*INTEGER
	v_tipocampo = "I"
	sqlmatriz(1)="UPDATE tablasidx set maxvalori = ( maxvalori + "+ALLTRIM(STR(v_incre))+" ) "
	sqlmatriz(2)=" WHERE campo = '"+ALLTRIM(p_campoidx)+"' and tabla = '"+ALLTRIM(p_tabla)+"' and tipocampo = '"+ALLTRIM(v_tipocampo)+"'"

	verror=sqlrun(vconeccionF,"idxmaximo")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la Actualizacion del maximo Numero de indice ",0+48+0,"Error")
	    RETURN 
	ENDIF 
	
	*** Vuelvo a buscar para corroborar
	
	
	sqlmatriz(1)="select maxvalori as maxnro FROM tablasidx "
	sqlmatriz(2)="WHERE campo = '"+ALLTRIM(p_campoidx)+"' and tabla = '"+ALLTRIM(p_tabla)+"' and tipocampo = '"+ALLTRIM(v_tipocampo)+"'" 
		
	verror=sqlrun(vconeccionF,"maximo")
	IF verror=.f.  
	    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA ddel maximo Numero de indice",0+48+0,"Error")
	ENDIF 

	* me desconecto	
	=abreycierracon(vconeccionF,"")
	v_maximo = IIF(ISNULL(maximo.maxnro),0,maximo.maxnro)

	SELECT maximo
	USE IN maximo

	RETURN v_maximo

	

ELSE
	IF p_tipo = 'C'
		*CHAR
		v_tipocampo = "C"
		
	
				
		sqlmatriz(1)="select maxvalorc as maxnro FROM tablasidx "
		sqlmatriz(3)="WHERE campo = '"+ALLTRIM(p_campoidx)+"' and tabla = '"+ALLTRIM(p_tabla)+"' and tipocampo = '"+ALLTRIM(v_tipocampo)+"'" 

		verror=sqlrun(vconeccionF,"maximo")
		IF verror=.f.  
		    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA ddel maximo Numero de indice",0+48+0,"Error")
		ENDIF 

		* me desconecto	
		=abreycierracon(vconeccionF,"")

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
		

			sqlmatriz(1)="Select *,c.detalle as detIVA, v.nombre as nomVend from facturas f left join detafactu d on f.idfactura = d.idfactura " 
			sqlmatriz(2)=" left join facturasfe fe on f.idfactura = fe.idfactura left join condfiscal c on f.iva = c.iva"
			sqlmatriz(3)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(4)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))+ " and fe.resultado = 'A'"
			
			verror=sqlrun(vconeccionF,"fac_det_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  de la factura",0+48+0,"Error")
			ENDIF
		
		ELSE
			
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			sqlmatriz(1)="Select *,c.detalle as detIVA from facturas f left join detafactu d on f.idfactura = d.idfactura " 
			sqlmatriz(2)=" left join condfiscal c on f.iva = c.iva"
			sqlmatriz(3)=" left join vendedores v on f.vendedor = v.vendedor"
			sqlmatriz(4)=" where f.idfactura = "+ ALLTRIM(STR(v_idfactura))

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
		
			v_idcomproba = factu.idcomproba
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
		
		*** Busco los datos del recibo
					
			vconeccionF=abreycierracon(0,_SYSSCHEMA)	
		
			sqlmatriz(1)="Select * from recibos" 
			sqlmatriz(4)=" where idrecibo = "+ ALLTRIM(STR(v_idrecibo))

			verror=sqlrun(vconeccionF,"recibo_sql")
			IF verror=.f.  
			    MESSAGEBOX("Ha Ocurrido un Error en la BÚSQUEDA  del recibo",0+48+0,"Error")
			ENDIF
		
		 		

		SELECT * FROM recibo_sql INTO TABLE .\recibo
				
		SELECT recibo
		
		IF NOT EOF()
		
			v_idcomproba = recibo.idcomproba
			DO FORM reporteform WITH "recibo","reciborc",v_idcomproba
			
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
	retorno = ''
ENDIF 
RELEASE oWS
RETURN retorno

ENDFUNC 




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
*---------------------------------------------

FUNCTION registrarEstado
PARAMETERS p_nomTabla,p_nomCampo,p_indice,p_tipoInd,p_estado

	estObj	= CREATEOBJECT('estadosclass')
	

	* me conecto a la base de datos
	vconeccion=abreycierracon(0,_SYSSCHEMA)	
	
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
	v_fecha			= cftofc(DATE())	

	p_tipoope     = 'I'
	p_condicion   = ''
	p_titulo      = " EL ALTA "
	p_tabla     = 'estadosreg'
	p_matriz    = 'lamatriz'



	p_conexion  = vconeccionF	

	
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
		=abreycierracon(vconeccionF,"") 
		
	ENDIF

	* me desconecto	
	=abreycierracon(vconeccionF,"") 
ENDFUNC 
