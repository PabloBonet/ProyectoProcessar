****************************************
* MODO DE USO :
* COPIAR EL TEXTO EN UN PRG EN
* CUALQUIER CARPETA EJ: MENU.PRG
* DO MENU.PRG
****************************************
* INDICACIONES :
* EL CODIGO SE ENCARGA DE CREAR UN FORM DE NIVEL SUPERIOR, GENERA EL
* MENU Y HACE LA LLAMADA AL MISMO LA PRIMERA VEZ QUE SE EJECUTA EL
* CODIGO, VERIFICA SI EXISTE LA TABLA DE MENU, EN LA CUAL SE DEFINEN LOS
* NIVELES DE PROFUNDIDAD DE CADA OPCION DEL MENU, LO CUAL LO PUEDES
* MANEJAR SEGUN REQUERIMIENTO LAS OPCIONES DE LOS MENUS NO VAN A
* FUNCIONAR AL NO EXISTIR LOS FORMULARIOS EN LA RUTA, ESO LO DEBES
* CAMBIAR SEGUN REQUERIMIENTO.
PARAMETERS tnId &&idperfil de menu
IF !FILE("MENU.DBF")
  CREATE TABLE MENU (MODULO C(2),;
    CODIGO C(14),;
    DESCRIPC C(50),;
    COMMAND C(50))
  SELECT MENU
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01000000000000","menu","do form abmmenu.scx")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01010000000000","Clientes","DO FORM CLIENTES.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01020000000000","Proveedores","DO FORM PROVEEDORES.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01030000000000","Maestras","ACTIVATE POPUP P010301")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01030100000000","Trabajadores","ACTIVATE POPUP P01030101")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01030101000000","Empleados","DO FORM EMPLEADOS.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01030102000000","Obreros","ACTIVATE POPUP P0103010201")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","01030102010000","Obreros Clasificados","DO FORM CLASIFICA.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02000000000000","Procesos","")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02010000000000","Calcular Encuesta","DO FORM CALCULAR.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020000000000","Tipos De Empleados","ACTIVATE POPUP P020201")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020100000000","Obreros","DO FORM OBREROS.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020100000000","Empleados","DO FORM EMPLEADOS.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020100000000","Contratistas","ACTIVATE POPUP P02020101")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020101000000","Luz Del Sur","ACTIVATE POPUP P0202010101")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020101010000","Electricistas","ACTIVATE POPUP P020201010101")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020101010100","Juan Perez","DO FORM JUAN.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("01","02020101010200","Jose Chavez","DO FORM JOSE.SCX")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("02","03000000000000","Ayuda","")
  INSERT INTO MENU(MODULO,CODIGO,DESCRIPC,COMMAND) VALUES ("02","03010000000000","Acerca De","do form acercade.scx")
  INDEX ON modulo+codigo TAG ORDEN
  CLOSE ALL
ENDIF
IF USED('TABMENU')
  USE IN TABMENU
ENDIF

oForm = CREATEOBJECT('MyFormSample')
oForm.SHOW
READ EVENTS

DEFINE CLASS MyFormSample AS FORM
  NAME = 'FrmPrincipal'
  CAPTION = ''
  SHOWWINDOW = 2
  WINDOWSTATE = 2
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
    SELECT TABMENU
    nNumberMenuPrin = 0
    SELECT TABMENU
    SCAN FOR INT(VAL(SUBSTR(CODIGO,3)))=0
      nNumberMenuPrin = nNumberMenuPrin + 1
      cDescripcion = ALLTRIM(TABMENU.descripc)
      =MESSAGEBOX("Creando Men� " + cDescripcion)
      cNamePad = "PAD" + PADL(ALLTRIM(STR(nNumberMenuPrin)),3,'0')
      \DEFINE PAD <<cNamePad>> OF (m.cMenuName) PROMPT "<<cDescripcion>>" COLOR SCHEME 4 KEY ALT+T, ""
    ENDSCAN
    SELECT LEFT(CODIGO,2) AS GRUPO FROM TABMENU GROUP BY 1 ORDER BY 1 INTO CURSOR _CrsOpciones
    nMenuTotal = RECCOUNT("_CrsOpciones")
    IF USED('_CrsOpciones')
      USE IN _CrsOpciones
    ENDIF
    nNumberMenuPrin = 0
    SELECT TABMENU
    SCAN FOR INT(VAL(SUBSTR(CODIGO,3)))=0
      nNumberMenuPrin = nNumberMenuPrin + 1
      cDescripcion = ALLTRIM(TABMENU.descripc)
      cNamePad   = "PAD" + PADL(ALLTRIM(STR(nNumberMenuPrin)),3,'0')
      cNamePopup = "P" + LEFT(TABMENU.CODIGO,2) &&& + PADL(ALLTRIM(STR(nNumberMenuPrin)),2,'0')
      \ON PAD <<cNamePad>> OF (m.cMenuName) ACTIVATE POPUP <<cNamePopup>>
    ENDSCAN

    * DEFINIENDO POPUS POR NIVELES
    nBarNivel = 0
    SELECT TABMENU
    GO TOP
    FOR nNiveles = 2 TO 6
      nSubStrCero = ((nNiveles+1)+nNiveles)
      nLeft = nSubStrCero-1
      nLeftNivelFactor = IIF(nNiveles=2,2,nNiveles*2)
      FOR nMenuPrin = 1 TO nMenuTotal
        SELECT * FROM TABMENU WHERE LEFT(TABMENU.CODIGO,2) = PADL(ALLTRIM(STR(nMenuPrin)),2,'0') AND ;
          INT(VAL(SUBSTR(TABMENU.CODIGO,nSubstrCero))) = 0 AND ;
          RIGHT(LEFT(TABMENU.CODIGO,nLeft),2) <> '00';
          INTO CURSOR _CrsConsultaSQL
        IF RECCOUNT('_CrsConsultaSQL')>0
          IF USED('_CrsConsultaSQL')
            USE IN _CrsConsultaSQL
          ENDIF
          nBarNivel = 0
          lEsPrimero = .T.
          SELECT TABMENU
          SCAN FOR LEFT(TABMENU.CODIGO,2)=PADL(ALLTRIM(STR(nMenuPrin)),2,'0') AND ;
              INT(VAL(SUBSTR(TABMENU.CODIGO,nSubstrCero))) = 0 AND ;
              RIGHT(LEFT(TABMENU.CODIGO,nLeft),2) <> '00'
            cTagNivelNamePad = LEFT(TABMENU.codigo,nLeftNivelFactor) &&& SUBSTR(TABMENU.codigo,3,2)
            IF lEsPrimero
              cPadNameNivel = "P" + cTagNivelNamePad
              \
              \DEFINE POPUP <<cPadNameNivel>> MARGIN RELATIVE SHADOW COLOR SCHEME 4
              lEsPrimero = .F.
            ENDIF
            cTagBar = ALLTRIM(TABMENU.DESCRIPC)
            nBarNivel = nBarNivel + 1
            \DEFINE BAR <<nBarNivel>> OF <<cPadNameNivel>> PROMPT "<<cTagBar>>"
          ENDSCAN
        ELSE
          IF USED('_CrsConsultaSQL')
            USE IN _CrsConsultaSQL
          ENDIF
        ENDIF
        nBarNivel = 0
        SELECT TABMENU
        SCAN FOR LEFT(TABMENU.CODIGO,2)=PADL(ALLTRIM(STR(nMenuPrin)),2,'0') AND ;
            INT(VAL(SUBSTR(TABMENU.CODIGO,nSubstrCero)))=0 AND ;
            RIGHT(LEFT(TABMENU.CODIGO,nLeft),2)<>'00'
          cTagBar = ALLTRIM(TABMENU.DESCRIPC)
          cTagCom = ALLTRIM(TABMENU.COMMAND)
          nBarNivel = nBarNivel + 1
          IF "ACTIVATE POPUP"$cTagCom
            \ON BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
          ELSE
            \ON SELECTION BAR <<nBarNivel>> OF <<cPadNameNivel>> <<cTagCom>>
          ENDIF
        ENDSCAN
      NEXT
    NEXT
    \ACTIVATE MENU (m.cMenuName) NOWAIT
    SET TEXTMERGE TO
    SET TEXTMERGE OFF
    COMPILE (THISFORM.cNameMenuMP+".MPR")
  ENDPROC
  PROCEDURE Previo
    SET TEXTMERGE ON
    cFileMenu = CURDIR() + "MENU.DBF"
    IF !FILE(cFileMenu)
      =MESSAGEBOX("No existe el archivo de Men� ...!"+CHR(13)+cFileMenu,16,"Error al cargar Form")
      RETURN .F.
    ENDIF
    USE (cFileMenu) IN 0 SHARED ALIAS TABMENU ORDER ORDEN
    THISFORM.cNameMenuMP = GETENV("TEMP")+"\"+"_" + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),3) + RIGHT(SUBSTR(SYS(2015), 3),1)
    SET TEXTMERGE TO (THISFORM.cNameMenuMP+".MPR") NOSHOW
  ENDPROC
  PROCEDURE INIT
    DO (THISFORM.cNameMenuMP+".MPX") WITH THISFORM,.F.
    THISFORM.RESIZE()
  ENDPROC
  ADD OBJECT CmdSalir AS MyButtonQuit  WITH ;
    CAPTION = "\<Salir"
ENDDEFINE


DEFINE CLASS MyButtonQuit AS COMMANDBUTTON
  HEIGHT = 30
  WIDTH = 130
  TOP = 50
  LEFT = 100
  NAME = 'CmdSalir'
  CAPTION = '\<Salir'

  PROCEDURE CLICK
    IF MESSAGEBOX("�Est� seguro que desea Salir?",36,THISFORM.CAPTION) = 6
      CLEAR EVENTS
      THISFORM.RELEASE
    ENDIF
  ENDPROC
ENDDEFINE