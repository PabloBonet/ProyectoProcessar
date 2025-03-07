*********************************************************************************************************
****************************************
* MODO DE USO :
* COPIAR EL TEXTO EN UN PRG EN
* CUALQUIER CARPETA EJ: MENU.PRG
* DO MENU.PRG
****************************************
* INDICACIONES :
**********************************************************************
*OBSERVACIONES: hay un menu unico por lo cual las opciones habilitdas tienen la siguente jerarquia (menu/perfil)
*es decir que si en el menu se deshabilita  una opcion no se tiene en cuenta el valor del perfil
*el resto de la validaciones ya se hicieron en el momento del login

PARAMETERS tnId, tnidmodulo  &&idperfil de menu
vconeccion=abreycierracon(0,_SYSSCHEMA)

sqlmatriz(1)="select m.* from perfilmh h left join  menusql m on h.idmenu = m.idmenu "
sqlmatriz(2)="left join perfilusu u on h.idperfil = u.idperfil "
sqlmatriz(3)="where h.idperfil = "+ALLTRIM(STR(tnId))+" and h.habilitado = 'S' and m.habilitado = 'S' and u.activo = 1 and m.idmodulo = "+ALLTRIM(STR(tnIdmodulo))+" group by h.idmenu order by m.codigo "
*sqlmatriz(3)="where h.idperfil = "+ALLTRIM(STR(tnId))+" and h.habilitado = 'S' and m.habilitado = 'S' and u.activo = 1 and m.idmodulo = "+ALLTRIM(STR(tnIdmodulo))+" group by h.idmenu order by m.orden, m.codigo"

verror=sqlrun(vconeccion,'TABMENU')

=abreycierracon(vconeccion,'')

IF !verror THEN 
	MESSAGEBOX('Ha ocurrido un error al obtener el menu',0+64,'Error')
	RETURN 	
ENDIF 

*!*	SELECT * FROM tabmenu INTO TABLE .\tabmenu2
*************************************************************
  	cNameMenuMP = ""
    SET TEXTMERGE ON
    cNameMenuMP = GETENV("TEMP")+"\"+"_" + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),1) 
    SET TEXTMERGE TO (cNameMenuMP+".MPR") NOSHOW
	  \LPARAMETER getMenuName
	  \
*!*	      \*LOCAL cMenuName
*!*	      \*m.cMenuName = _MSYSMENU  &&IIF(TYPE("m.getMenuName")="C",m.getMenuName,SYS(2015))
*!*	      \*DEFINE MENU (m.cMenuName) IN SCREEN BAR KEY F10
      \*
      \SET SYSMENU TO
	  \SET SYSMENU AUTOMATIC
	  \*
      ****************

      CREATE TABLE .\tmpPopup (tpopup c(50))
      SELECT tmpPopup
      INDEX ON ALLTRIM(tpopup) TAG tpopup 
      CREATE TABLE .\tmpPopupa (tpopup c(50))
      SELECT tmpPopupa
      INDEX ON ALLTRIM(tpopup) TAG tpopup       
      ****************
    SELECT TABMENU
    nNumberMenuPrin = 0
    nMenuTotal = 0
    ****
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
    	  *(m.cMenuName)
	      \DEFINE PAD <<cNamePad>> OF _MSYSMENU PROMPT "<<cDescripcion>>" COLOR SCHEME 4 KEY ALT+T, ""
    	  cNamePopup = "P" + LEFT(TABMENU.CODIGO,2) &&& + PADL(ALLTRIM(STR(nNumberMenuPrin)),2,'0')
    	  *ACTIVO EL MENU
	      \ON PAD <<cNamePad>> OF _MSYSMENU  ACTIVATE POPUP <<cNamePopup>>
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
	  cTagImagen = IIF(!EMPTY(ALLTRIM(tabmenu.imagen)),"PICTURE '"+ALLTRIM(_sysservidor)+"iconos\"+ALLTRIM(tabmenu.imagen)+"'","")
	  
	IF nNivel = 2 THEN 	
		nID = TABMENU.idmenup
		SELECT codigo, nivel, comando FROM TABMENU WHERE idmenu = nID INTO CURSOR curMenu
		SELECT curMenu
		GO TOP			
		cPadNameNivel = "P"+LEFT(curMenu.codigo,2)


		SELECT MIN(SUBSTR(tabmenu.codigo,(nNivel*2)-1,2)) as priitem FROM TABMENU WHERE idmenup = nID INTO CURSOR primeritem
		IF SUBSTR(tabmenu.codigo,3,2) = ALLTRIM(primeritem.priitem) THEN 
*!*			IF SUBSTR(tabmenu.codigo,3,2) = "01" THEN 
			*SI ES EL PRIMER ELEMENTO DENTRO DEL MENU DEFINO EL POPUP.
			\DEFINE POPUP <<cPadNameNivel>> MARGIN RELATIVE SHADOW COLOR SCHEME 4
		ENDIF  	
		
		IF TABMENU.nivel = "H" THEN 
			ctagComW=IIF(AT('DO FORM',UPPER(tabmenu.comando))=0,""," SKIP FOR WEXIST('"+ALLTRIM(  SUBSTR(STRTRAN(UPPER(tabmenu.comando),'DO FORM ',''),1, AT(' ',STRTRAN(UPPER(tabmenu.comando),'DO FORM ','')) )  ) +"')")
			\DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagImagen>> PROMPT "<<cTagBar>>"  <<cTagComW>>
			cTagCom = ALLTRIM(tabmenu.comando) 
			&& ACA INTERVINE
*!*				cTagCom = "f_ejecutar('"+ALLTRIM(tabmenu.arranque)+"','"+ALLTRIM(tabmenu.comando)+"', '"+tabmenu.pusu+"', '"+tabmenu.opcion+"', '"+ALLTRIM(tabmenu.prun)+"')"
			\ON SELECTION BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
		ELSE 
			*NIVEL I DENTRO DE UN NIVEL P			
	        \DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>>  <<cTagImagen>> PROMPT "<<cTagBar>>"	 
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
			
			\DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>>  <<cTagImagen>> PROMPT "<<cTagBar>>" 
			cTagCom = ALLTRIM(tabmenu.comando) 
			\ON BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
			
		 ELSE
		 	 
			SELECT MIN(SUBSTR(tabmenu.codigo,(nNivel*2)-1,2)) as priitem FROM TABMENU WHERE idmenup = nID INTO CURSOR primeritem
			IF SUBSTR(tabmenu.codigo,3,2) = ALLTRIM(primeritem.priitem) THEN 	 
*!*				IF SUBSTR(tabmenu.codigo,(nNivel*2)-1,2) = "01" THEN 
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
			cTagCom = ALLTRIM(tabmenu.comando)
			ctagComW=IIF(AT('DO FORM',UPPER(tabmenu.comando))=0,""," SKIP FOR WEXIST('"+ALLTRIM(  SUBSTR(STRTRAN(UPPER(tabmenu.comando),'DO FORM ',''),1, AT(' ',STRTRAN(UPPER(tabmenu.comando),'DO FORM ','')) )  ) +"')")
			
			\DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>>  <<cTagImagen>> PROMPT "<<cTagBar>>"  <<cTagComW>>
			\ON SELECTION BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
		ENDIF 
	ENDIF 
  ENDSCAN


*!*	  **********************************************************
*!*	  *FUNCTION SALIR MENU LA TENGO DEFINIDA EN PRINCIPAL.PRG  *
*!*	  **********************************************************
*!*	  
*!*	     nNumberMenuPrin = nNumberMenuPrin + 1
*!*	     cDescripcion = "SALIR"
*!*	     cNamePad = "PAD" + PADL(ALLTRIM(STR(nNumberMenuPrin)),3,'0')
*!*	     \DEFINE PAD <<cNamePad>> OF (m.cMenuName) PROMPT "<<cDescripcion>>" COLOR SCHEME 4 KEY ALT+F4, "ALT+F4"
*!*	      \ON SELECTION PAD <<cNamePad>> OF (m.cMenuName) SALIRMENU()
 *
*!*	 	MESSAGEBOX(m.cMenuName)
 	
* 	\ACTIVATE MENU (m.cMenuName) &&NOWAIT
* 	\_SYSMENU = m.cMenuName
    SET TEXTMERGE TO
    SET TEXTMERGE OFF
    SELECT TABMENU
    USE
    SELECT primeritem
    USE 
    COMPILE (cNameMenuMP+".MPR")
 
   
    _SYSMENUSYSTEM =cNameMenuMP+".MPR"
*!*		DO &_SYSMENUSYSTEM
*!*	    &EJE 
*!*	    COMPILE (THISFORM.cNameMenuMP+".MPR")
*!*	  ENDPROC
  
*!*	  PROCEDURE Previo
*!*	    SET TEXTMERGE ON
*!*	    cNameMenuMP = GETENV("TEMP")+"\"+"_" + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),1) 
*!*	    MESSAGEBOX(cNameMenuMP)   
*!*	    SET TEXTMERGE TO (cNameMenuMP+".MPR") NOSHOW
*!*	*!*	    THISFORM.cNameMenuMP = GETENV("TEMP")+"\"+"_" + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),1)
*!*	*!*	    SET TEXTMERGE TO (THISFORM.cNameMenuMP+".MPR") NOSHOW
*!*	  ENDPROC
  
*!*	  PROCEDURE INIT
*!*	    DO (THISFORM.cNameMenuMP+".MPX") WITH THISFORM,.F.
*!*	    THISFORM.RESIZE()
*!*	  ENDPROC
*!*	  
*!*	  PROCEDURE unload 
*!*	  	cierraapp() 
*!*	  ENDPROC 

*!*	ENDDEFINE




