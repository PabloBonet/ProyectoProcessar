*********************************************************************************************************
****************************************
* MODO DE USO :
* COPIAR EL TEXTO EN UN PRG EN
* CUALQUIER CARPETA EJ: MENU.PRG
* DO MENU.PRG
****************************************
* INDICACIONES :
* EL CODIGO SE ENCARGA DE CREAR UN FORM DE NIVEL SUPERIOR, GENERA EL
* MENU Y HACE LA LLAMADA AL MISMO.
**********************************************************************
*OBSERVACIONES: hay un menu unico por lo cual las opciones habilitdas tienen la siguente jerarquia (menu/perfil)
*es decir que si en el menu se deshabilita  una opcion no se tiene en cuenta el valor del perfil
*el resto de la validaciones ya se hicieron en el momento del login

PARAMETERS tnId  &&idperfil de menu
vconeccion=abreycierracon(0,MISCHEMA)

sqlmatriz(1)="select m.* from perfilmh h left join  menusql m on h.idmenu = m.idmenu "
sqlmatriz(2)="left join perfilusu u on h.idperfil = u.idperfil "
sqlmatriz(3)="where h.idperfil = "+ALLTRIM(STR(tnId))+" and h.habilitado = 'S' and m.habilitado = 'S' and u.activo = 1 and m.idmodulo = 0 group by h.idmenu order by m.orden, m.codigo"

verror=sqlrun(vconeccion,'TABMENU')

=abreycierracon(vconeccion,'')

IF !verror THEN 
	MESSAGEBOX('Ha ocurrido un error al obtener el menu',0+64,'Error')
	RETURN 	
ENDIF 
*************************************************************
oForm = CREATEOBJECT('MyFormSample')
oForm.SHOW
READ EVENTS
DEFINE CLASS MyFormSample AS FORM
  NAME = 'FrmPrincipal'
  CAPTION = MITITULO+" "+MIDESCRIP
  SHOWWINDOW = 2
  WINDOWSTATE = 2
  WINDOWTYPE = 1
  BACKCOLOR = MICOLORFONDO
  PICTURE   = MIFONDO
  ICON      = MIICONO
*SYSMETRIC(1) && Ancho de la pantalla
*SYSMETRIC(2) && Alto de la pantalla
  cNameMenuMP = ""
  PROCEDURE LOAD
    *ejecutando load
    THISFORM.Previo()
      \LPARAMETER oFormRef,getMenuName
      \
      \LOCAL cMenuName
      \IF TYPE("m.oFormRef") # "O" OR LOWER(m.oFormRef.BaseClass) # 'form' OR m.oFormRef.ShowWindow # 2
      \   RETURN
      \ENDIF
      \m.cMenuName = IIF(TYPE("m.getMenuName")="C",m.getMenuName,SYS(2015))
      \IF TYPE("m.getMenuName")="L" AND m.getMenuName
      \   m.oFormRef.Name = m.cMenuName
      \ENDIF
      \DEFINE MENU (m.cMenuName) IN (m.oFormRef.Name) BAR
      \*
      ****************
      CREATE TABLE .\TEMP\tmpPopup (tpopup c(50))
      SELECT tmpPopup
      INDEX ON ALLTRIM(tpopup) TAG tpopup 
      CREATE TABLE .\TEMP\tmpPopupa (tpopup c(50))
      SELECT tmpPopupa
      INDEX ON ALLTRIM(tpopup) TAG tpopup       
      ****************
    SELECT TABMENU
    nNumberMenuPrin = 0
    nMenuTotal = 0
    ****
    *OO
    *
    LOCAL nID
    
    SELECT TABMENU
	GO TOP 
    SCAN FOR !EOF()
    
      IF TABMENU.NIVEL = 'P' THEN 
	      nNumberMenuPrin = nNumberMenuPrin + 1
    	  cDescripcion = ALLTRIM(TABMENU.descrip)
	      *CREO UN TITULO DE MENU
    	  cNamePad = "PAD" + PADL(ALLTRIM(STR(nNumberMenuPrin)),4,'0')
	      \DEFINE PAD <<cNamePad>> OF (m.cMenuName) PROMPT "<<cDescripcion>>" COLOR SCHEME 4 KEY ALT+T, ""
    	  cNamePopup = "P" + LEFT(TABMENU.CODIGO,2) &&& + PADL(ALLTRIM(STR(nNumberMenuPrin)),2,'0')
    	  *ACTIVO EL MENU
	      \ON PAD <<cNamePad>> OF (m.cMenuName) ACTIVATE POPUP <<cNamePopup>>
	       nBarNivel = 0     
	  	  LOOP 
	  ENDIF 
	
	 *buscar el nivel del menu mediante 00 en cod.igo menu
	  nNivel = 1 &&Nivel 1 es nivel P, los niveles H e I arrancan en el Nivel 2
	  cSubcero = ''
	  nStart = 0
	  DO while .T. 	  
	  	nNivel = nNivel + 1
	  	IF nNivel = 2 THEN 
	  		cSubcero = SUBSTR(TABMENU.codigo,3,2)
	  	ELSE 
	  		nStart = (nNivel * 2)-1
	  		cSubCero = SUBSTR(TABMENU.codigo,nStart,2)
	  	ENDIF 
	  	IF cSubcero <> '00' THEN 
	  		LOOP 
	  	ELSE
	  		*Encontre la cadena 00 por lo tanto el nivel es el anterior 
	  		nNivel = nNivel - 1
	  		EXIT 
	  	ENDIF 
	  ENDDO 
	 
	  nBarNivel = nBarNivel + 1
	  nLeftNivelFactor = IIF(nNivel=2,2,nNivel*2)		
	  cTagNivelNamePad = LEFT(TABMENU.codigo,nLeftNivelFactor)	 
	  cTagBar = ALLTRIM(TABMENU.descrip)

	IF nNivel = 2 THEN 	
		nID = TABMENU.idmenup
		SELECT codigo, nivel, comando FROM TABMENU WHERE idmenu = nID INTO CURSOR curMenu
		SELECT curMenu
		GO TOP			
		cPadNameNivel = "P"+LEFT(curMenu.codigo,2)
			
		IF SUBSTR(tabmenu.codigo,3,2) = "01" THEN 
			*SI ES EL PRIMER ELEMENTO DENTRO DEL MENU DEFINO EL POPUP.
			\DEFINE POPUP <<cPadNameNivel>> MARGIN RELATIVE SHADOW COLOR SCHEME 4
		ENDIF  	
		
		IF TABMENU.nivel = "H" THEN 
			\DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>> PROMPT "<<cTagBar>>"   
			cTagCom = "f_ejecutar('"+ALLTRIM(tabmenu.arranque)+"','"+ALLTRIM(tabmenu.comando)+"', '"+tabmenu.pusu+"', '"+tabmenu.opcion+"', '"+ALLTRIM(tabmenu.prun)+"')"
			\ON SELECTION BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
		ELSE 
			*NIVEL I DENTRO DE UN NIVEL P			
	        \DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>> PROMPT "<<cTagBar>>"	  
		    cTagCom = ALLTRIM(tabmenu.comando)
		    \ON BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>	
		ENDIF 
	ELSE 
		*TERCER NIVEL O SUPERIOR
		nID = TABMENU.idmenup		 	
		SELECT codigo, nivel, comando FROM TABMENU WHERE idmenu = nID INTO CURSOR curMenu
		SELECT curMenu
		GO TOP				
		cPadNameNivel = STRTRAN(curMenu.comando,'ACTIVATE POPUP','')		
				
		IF TABMENU.nivel = "I" THEN 			
			IF !SEEK(ALLTRIM(cPadNameNivel),'tmpPopup','tpopup') THEN 
				\DEFINE POPUP <<cPadNameNivel>> MARGIN RELATIVE SHADOW COLOR SCHEME 4
				SELECT tmpPopup
				APPEND BLANK 
				REPLACE tpopup WITH ALLTRIM(cPadNameNivel)
			ENDIF 
			
			\DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>> PROMPT "<<cTagBar>>"
			cTagCom = ALLTRIM(tabmenu.comando)
			\ON BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
			
		 ELSE
			IF SUBSTR(tabmenu.codigo,(nNivel*2)-1,2) = "01" THEN 
				*SI ES EL PRIMER ELEMENTO DENTRO DEL MENU DEFINO EL POPUP. NIVEL H
				IF !SEEK(ALLTRIM(cPadNameNivel),'tmpPopup','tpopup') THEN 
					\DEFINE POPUP <<cPadNameNivel>> MARGIN RELATIVE SHADOW COLOR SCHEME 4
					SELECT tmpPopup
					APPEND BLANK 
					REPLACE tpopup WITH ALLTRIM(cPadNameNivel)				
				ENDIF  			
			ENDIF 
		ENDIF 	
		  	
		IF tabmenu.nivel = 'H' THEN 			  	
		 	*>2 NIVEL = H
			cTagCom = "f_ejecutar('"+ALLTRIM(tabmenu.arranque)+"','"+ALLTRIM(tabmenu.comando)+"', '"+tabmenu.pusu+"', '"+tabmenu.opcion+"', '"+ALLTRIM(tabmenu.prun)+"')"
			\DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>> PROMPT "<<cTagBar>>"
			\ON SELECTION BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
		ENDIF 
	ENDIF 
  ENDSCAN


  **********************************************************
  *FUNCTION SALIR MENU LA TENGO DEFINIDA EN PRINCIPAL.PRG  *
  **********************************************************
  
      nNumberMenuPrin = nNumberMenuPrin + 1
     cDescripcion = "SALIR"
     cNamePad = "PAD" + PADL(ALLTRIM(STR(nNumberMenuPrin)),3,'0')
     \DEFINE PAD <<cNamePad>> OF (m.cMenuName) PROMPT "<<cDescripcion>>" COLOR SCHEME 4 KEY ALT+F4, "ALT+F4"
      \ON SELECTION PAD <<cNamePad>> OF (m.cMenuName) SALIRMENU()
 *
 	\ACTIVATE MENU (m.cMenuName) NOWAIT
    SET TEXTMERGE TO
    SET TEXTMERGE OFF
    COMPILE (THISFORM.cNameMenuMP+".MPR")
  ENDPROC
  
  PROCEDURE Previo
    SET TEXTMERGE ON
    THISFORM.cNameMenuMP = GETENV("TEMP")+"\"+"_" + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),1)
    SET TEXTMERGE TO (THISFORM.cNameMenuMP+".MPR") NOSHOW
  ENDPROC
  PROCEDURE INIT
    DO (THISFORM.cNameMenuMP+".MPX") WITH THISFORM,.F.
    THISFORM.RESIZE()
  ENDPROC
  
  PROCEDURE unload 
  	cierraapp() 
  ENDPROC 

ENDDEFINE




