DEFINE CLASS CodigoBarras AS Custom olepublic

TablaCompro = ""
CuitEmpresa = ""


	PROCEDURE CargarBarras
		PARAMETERS x,c
		TablaCompro = x
		CuitEmpresa = STRTRAN(c,'-','')
		
		USE &TablaCompro IN 0
		v_bar_codigo = this.BarCodigo(0)	&& CODIGO BARRA COSEMAR Y TELENORTE LOCALES			
		ALTER table &TablaCompro ADD COLUMN cb_empresa C(100)
		REPLACE all cb_empresa WITH v_bar_codigo 
		GO TOP 
		
		DO CASE 
			CASE CuitEmpresa == "30545784897" 

				v_bar_codigo = this.BarCodigo(2)	&& CODIGO BARRA COSEMAR 			
				ALTER table &TablaCompro ADD COLUMN cb_nbsf C(100)
				REPLACE all cb_nbsf WITH v_bar_codigo 
				GO TOP 
				
			CASE CuitEmpresa == "30674401953"

				v_bar_codigo = this.BarCodigo(1)	&& CODIGO BARRA TELENORTE 
				ALTER table &TablaCompro ADD COLUMN cb_nbsf C(100)
				REPLACE all cb_nbsf WITH v_bar_codigo 
				GO TOP 
					
			OTHERWISE 
		ENDCASE 
		
		USE 
	ENDPROC 



		**************************************************************************************
		** RETORNA LA CADENA DE CARACTERES A IMPRIMIR SEGUN EL PARAMETRO DE SELECCION RECIBIDO
		***************************************************************************************
		PROCEDURE BarCodigo
		PARAMETERS P_Elige
		RETCODIGO = ""
		DO CASE


			CASE P_Elige = 0 && COSEMAR Y TELENORTE MODULO COBRANZA PROPIO
				RETCODIGO =  "00010001"+RIGHT(REPLICATE("0",15)+ALLTRIM(STR(idfactura)),15)+'00'
		

			CASE P_ELIGE = 1 && IMPRESION DEL NUEVO BANCO DE SANTA FE TELENORTE 2 VENCIMIENTOS
				
				IF !EMPTY(fechavenc1) AND !EMPTY(fechavenc2) THEN 
				
					RETCODIGO1 = "11122222"+;
							SUBSTR(ALLTRIM(STR(entidad+10000)),2,4)+ ;
							SUBSTR(ALLTRIM(STR(servicio+100)),2,2)+ ;
							SUBSTR(ALLTRIM(STR(cuenta+100)),2,2)+ ;
							ALLTRIM(RIGHT(REPLICATE("0",12)+ALLTRIM(STR(idfactura)),12))+"0"+ ;
							this.DIAJULIANO(DATE(VAL(SUBSTR(fechavenc1,1,4)),VAL(SUBSTR(fechavenc1,5,2)),VAL(SUBSTR(fechavenc1,7,2))))+ ;
							STRTRAN(STRTRAN(STR(total,9,2)," ","0"),".","")+ ; 
							this.DIAJULIANO(DATE(VAL(SUBSTR(fechavenc2,1,4)),VAL(SUBSTR(fechavenc2,5,2)),VAL(SUBSTR(fechavenc2,7,2))))+ ;
							STRTRAN(STRTRAN(STR((total+recargo1),9,2)," ","0"),".","")  
					RETCODIGO2 =  RETCODIGO1 + this.VERIFICADOR(RETCODIGO1)
					RETCODIGO  = this.BAR25(RETCODIGO2)
				ENDIF 

			CASE P_ELIGE = 2 && CODIGO BARRA NUEVO BANCO DE SANTA FE PARA COSEMAR ( en blanco falta acuerdo )
				
				IF !EMPTY(fechavenc1) AND !EMPTY(fechavenc2) THEN 
				
*!*						RETCODIGO1 = "11122222"+;
*!*								SUBSTR(ALLTRIM(STR(entidad+10000)),2,4)+ ;
*!*								SUBSTR(ALLTRIM(STR(servicio+100)),2,2)+ ;
*!*								SUBSTR(ALLTRIM(STR(cuenta+100)),2,2)+ ;
*!*								ALLTRIM(RIGHT(REPLICATE("0",12)+ALLTRIM(STR(idfactura)),12))+"0"+ ;
*!*								this.DIAJULIANO(DATE(VAL(SUBSTR(fechavenc1,1,4)),VAL(SUBSTR(fechavenc1,5,2)),VAL(SUBSTR(fechavenc1,7,2))))+ ;
*!*								STRTRAN(STRTRAN(STR(total,9,2)," ","0"),".","")+ ; 
*!*								this.DIAJULIANO(DATE(VAL(SUBSTR(fechavenc2,1,4)),VAL(SUBSTR(fechavenc2,5,2)),VAL(SUBSTR(fechavenc2,7,2))))+ ;
*!*								STRTRAN(STRTRAN(STR((total+recargo1),9,2)," ","0"),".","")  
*!*						RETCODIGO2 =  RETCODIGO1 + this.VERIFICADOR(RETCODIGO1)
*!*						RETCODIGO  = this.BAR25(RETCODIGO2)
					RETCODIGO = "  "
				ENDIF 				
			
			OTHERWISE 
				
		ENDCASE
		RETURN RETCODIGO






	************************************************************
	** Función de Retorno del Dia Juliano de acuerdo a una fecha dada
	** en 4 digitos 1 posicion ultimo digito del año y 2 a 4 el dia
	************************************************************
	PROCEDURE DiaJuliano
	PARAMETERS eldia
		ano=SUBSTR(ALLTRIM(STR(YEAR(eldia))),4,1)
		diaj=SUBSTR(STR(((eldia-DATE(YEAR(eldia),01,01)+1)+1000),4),2)
		ret=ano+diaj
		RETURN ret 
	ENDFUNC 

	************************************************************
	** Función de Retorno de Dígito Verificador
	** Recibe el string y devuelve el digito verificador
	************************************************************
	PROCEDURE Verificador(t)
		L = LEN(t)
		DIMENSION arreglo(3,L)
		DIMENSION serie (1,4)
		serie(1,1) = 3
		serie(1,2) = 5
		serie(1,3) = 7
		serie(1,4) = 9
		arreglo(2,1)=1
		suma= 0
		y = 1
		FOR x = 1 TO L
			arreglo(1,x)= VAL(SUBSTR(t,x,1))
			IF x > 1 THEN 
				arreglo(2,x)=serie(1,y)
				IF y = 4 then
					y = 1
				ELSE
					y = y + 1
				ENDIF 
			ENDIF 
			arreglo(3,x) = arreglo(1,x)*arreglo(2,x)
			suma = suma + arreglo(3,x)
		NEXT 
		mitad=INT(suma/2)
		dg = ALLTRIM(STR(MOD(mitad,10)))
	RETURN dg			



	************************************************************
	** Esta funcion enviada por el Provincia para la conversion
	** en la impresion de las barras en codigo Interleave 2 de 5
	************************************************************
	PROCEDURE bar25(t)
	a=CHR(33)

	FOR x = 1 TO LEN(T) STEP 2 
		v= VAL(SUBSTR(t,x,2)) 
		DO CASE 
			CASE v >= 0 AND v<=91
				c=CHR(v+35)
			CASE v=92
				c=CHR(196)
			CASE v=93
				c=CHR(197)
			CASE v=94
			    c=CHR(199)
			CASE v=95
			    c=CHR(201)
			CASE v=96
			    c=CHR(209)
			CASE v=97
			    c=CHR(214)
			CASE v=98
				c=CHR(220)
			CASE v=99
				c=CHR(225)
		ENDCASE 
		a=a+c
		NEXT 
		a = a + CHR(34)
	RETURN a


ENDDEFINE 




DEFINE CLASS SMSWhatsapp AS Custom olepublic

cPhone 		= ""
ccMessage 	= ""
ccArchivo 	= ""

	PROCEDURE SendWhatsapp 
	PARAMETERS p_cphone, p_ccMensage, p_ccArchivo
	
		IF EMPTY(p_cphone) THEN 
			MESSAGEBOX("Debe Especificar un Telefono para el Envío de WhatsApp... Verifique ",48,"Envio de WhatsApp")
			RETURN 
		ENDIF 
		this.cPhone = (STRTRAN(p_cphone,'-',''))
		this.ccMessage = ALLTRIM(p_ccMensage)
		this.ccArchivo = ALLTRIM(p_ccArchivo)

		Declare Sleep In kernel32 Integer
		Declare  Integer FindWindow In WIN32API String , String
		Declare  Integer SetForegroundWindow In WIN32API Integer
		Declare  Integer  ShowWindow  In WIN32API Integer , Integer
		Declare Integer ShellExecute In shell32.Dll ;
			INTEGER hndWin, ;
			STRING cAction, ;
			STRING cFileName, ;
			STRING cParams, ;
			STRING cDir, ;
			INTEGER nShowWin

		Local lt, lhwnd
		
			cTelPhone=this.cPhone
			cmd='whatsapp://send?phone=&cTelPhone&text='+this.ccMessage 
			=ShellExecute(0, 'open', cmd,'', '', 1)
	*!*			Wait "" Timeout 3
			lt = "Whatsapp"
			lhwnd = FindWindow (0, lt)
	*!*			Wait "" Timeout 3
			If lhwnd!= 0
				SetForegroundWindow (lhwnd)
				ShowWindow (lhwnd, 1)
				ox = Createobject ( "Wscript.Shell" )

				sleep(1000)
				ox.sendKeys ( '{ENTER}' )
				** Copy list of files into Clipboard
			
				IF !EMPTY(this.ccArchivo) THEN 
					this.CopyFiles2Clipboard(this.ccArchivo)
							
					sleep(1000)
					ox.sendKeys ("^{v}")
					sleep(1000)
					ox.sendKeys ( '{ENTER}' )
				ENDIF 
			
					
			Else
				Messagebox ( "Whatsapp is not activated!" )
			ENDIF
			
	RETURN 






	PROCEDURE  CopyFiles2Clipboard(taFileList)
		*#/---------------------------
		*** Función para copiar un archivo al ClipBoard
		*** Parametro: taFileList = el path completo del archivo que se pretende copiar al Clipboard
		*#/---------------------------
			LOCAL lnDataLen, lcDropFiles, llOk, i, lhMem, lnPtr
			#DEFINE CF_HDROP 15

			*  Global Memory Variables with Compile Time Constants
			#DEFINE GMEM_MOVABLE 	0x0002
			#DEFINE GMEM_ZEROINIT	0x0040
			#DEFINE GMEM_SHARE	0x2000

			* Load required Windows API functions
			this.LoadApiDlls()

			llOk = .T.
			* Build DROPFILES structure
			lcDropFiles = ;
					CHR(20) + REPLICATE(CHR(0),3) + ; 	&& pFiles
					REPLICATE(CHR(0),8) + ; 		&& pt
					REPLICATE(CHR(0),8)  			&& fNC + fWide
			* Add zero delimited file list
				lcDropFiles = lcDropFiles + taFileList + CHR(0)
			* Final CHR(0)
			lcDropFiles = lcDropFiles + CHR(0)
			lnDataLen = LEN(lcDropFiles)
			* Copy DROPFILES structure into the allocated memory
			lhMem = GlobalAlloc(GMEM_MOVABLE+GMEM_ZEROINIT+GMEM_SHARE, lnDataLen)
			lnPtr = GlobalLock(lhMem)
			=CopyFromStr(lnPtr, @lcDropFiles, lnDataLen)
			=GlobalUnlock(lhMem)
			* Open clipboard and store DROPFILES into it
			llOk = (OpenClipboard(0) <> 0)
			IF llOk
				=EmptyClipboard()
				llOk = (SetClipboardData(CF_HDROP, lhMem) <> 0)
				* If call to SetClipboardData() is successful, the system will take ownership of the memory
				*   otherwise we have to free it
				IF NOT llOk
					=GlobalFree(lhMem)
				ENDIF
				* Close clipboard 
				=CloseClipboard()
			ENDIF
		RETURN llOk

		PROCEDURE  LoadApiDlls
			*  Clipboard Functions
			DECLARE LONG OpenClipboard IN WIN32API LONG HWND
			DECLARE LONG CloseClipboard IN WIN32API
			DECLARE LONG EmptyClipboard IN WIN32API
			DECLARE LONG SetClipboardData IN WIN32API LONG uFormat, LONG hMem
			*  Memory Management Functions
			DECLARE LONG GlobalAlloc IN WIN32API LONG wFlags, LONG dwBytes
			DECLARE LONG GlobalFree IN WIN32API LONG HMEM
			DECLARE LONG GlobalLock IN WIN32API LONG HMEM
			DECLARE LONG GlobalUnlock IN WIN32API LONG HMEM
			DECLARE LONG RtlMoveMemory IN WIN32API As CopyFromStr LONG lpDest, String @lpSrc, LONG iLen

		RETURN

ENDDEFINE 

