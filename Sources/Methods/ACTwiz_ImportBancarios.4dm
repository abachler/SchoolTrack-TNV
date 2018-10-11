//%attributes = {}
  //ACTwiz_ImportBancarios

C_TEXT:C284(vtACT_filename)
C_BOOLEAN:C305(<>bACTimport_inDialog;<>bACTimport_enProceso;<>bACTimport_importando;<>bACTimport_botonCancelar)

<>bACTimport_inDialog:=True:C214  // para saber que la ventana se cerro y se puede leer las variables para ver si es necesario esperar que la importacion termine o no.
<>bACTimport_enProceso:=True:C214  // para esperar que el otro proceso lea las variables de este proceso
<>bACTimport_importando:=True:C214  // para indicar que el proceso de importacion termino
<>bACTimport_botonCancelar:=True:C214  // para saber si cancelo la ventana o no

vsBWR_CurrentModule:="AccountTrack"
GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)

vpXS_IconModule:=$1
vsBWR_CurrentModule:=$2

_O_ARRAY STRING:C218(80;aRUTRechazo;0)
ARRAY TEXT:C222(aDescRechazo;0)
_O_ARRAY STRING:C218(80;aRUTDoble;0)
_O_ARRAY STRING:C218(80;aRUTNoIdentif;0)
_O_ARRAY STRING:C218(80;aRUTInvalidos;0)
ARRAY TEXT:C222(aNumTarjetaRe;0)
_O_ARRAY STRING:C218(80;aRUTApdoNoCta;0)
_O_ARRAY STRING:C218(80;aMontoCero;0)
_O_ARRAY STRING:C218(80;aSinDeuda;0)
_O_ARRAY STRING:C218(2;aARXTransbankNoIdentif;0)
_O_ARRAY STRING:C218(2;aARXTransbankDoble;0)
_O_ARRAY STRING:C218(2;aARXTransbankInvalidos;0)
_O_ARRAY STRING:C218(2;aARXTransbankApdoNoCta;0)
ACTcfg_LeeBlob ("ACTcfg_MonedasYTasas")

C_LONGINT:C283(<>vlACT_WinRef)
If (<>vlACT_WinRef=0)
	<>vlACT_WinRef:=WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_ArchaImportar";-1;4;__ ("Asistentes"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_ArchaImportar")
	CLOSE WINDOW:C154
	If (ok=1)
		<>bACTimport_botonCancelar:=False:C215
		<>bACTimport_inDialog:=False:C215
		If (SYS_TestPathName (vt_ruta)=Is a document:K24:1)
			vtACT_fileName:=SYS_Path2FileName (vt_ruta)
			SET BLOB SIZE:C606($blob;0)
			EM_ErrorManager ("Install")
			EM_ErrorManager ("SetMode";"")
			DOCUMENT TO BLOB:C525(vt_ruta;$blob)
			EM_ErrorManager ("Clear")
			If (ok=1)
				vTipo:=atACT_formas_de_pago{atACT_formas_de_pago}
				LOG_RegisterEvt ("Proceso de importación de pagos tipo "+vTipo+" iniciado con fecha de pago: "+String:C10(vdACT_ImpRealDate)+" y fecha para monedas variables: "+String:C10(vd_FechaUF))
				$sem:=Semaphore:C143("PreImport")
				$sem1:=Semaphore:C143("LConfIBank")
				If ((Application type:C494=4D Remote mode:K5:5) & (cb_ImportOnServer=1))
					  //20130729 RCH
					  //$import:=Execute on server("ACTabc_ImportPorColegio";64000;"Importando archivos bancarios";$blob;vtACT_fileName;vlACT_ImportadorID;vlACT_id_modo_pago;vdACT_ImpRealDate;vpXS_IconModule;vsBWR_CurrentModule;typeWin;typeMac;vd_FechaUF)
					$import:=Execute on server:C373("ACTabc_ImportPorColegio";Pila_256K;"Importando archivos bancarios";$blob;vtACT_fileName;vlACT_ImportadorID;vlACT_id_modo_pago;vdACT_ImpRealDate;vpXS_IconModule;vsBWR_CurrentModule;typeWin;typeMac;vd_FechaUF;<>tUSR_CurrentUser)
					ACTabc_PreImportW ($import;vlACT_ImportadorID)
					ACTabc_SelectionItem2Import ($import)
					ACTwiz_ResultadosImport (-1)
				Else 
					  //20130729 RCH
					  //$import:=New process("ACTabc_ImportPorColegio";64000;"Importando archivos bancarios";$blob;vtACT_fileName;vlACT_ImportadorID;vlACT_id_modo_pago;vdACT_ImpRealDate;vpXS_IconModule;vsBWR_CurrentModule;typeWin;typeMac;vd_FechaUF)
					$import:=New process:C317("ACTabc_ImportPorColegio";Pila_256K;"Importando archivos bancarios";$blob;vtACT_fileName;vlACT_ImportadorID;vlACT_id_modo_pago;vdACT_ImpRealDate;vpXS_IconModule;vsBWR_CurrentModule;typeWin;typeMac;vd_FechaUF;<>tUSR_CurrentUser)
					ACTabc_PreImportW ($import;vlACT_ImportadorID)
					ACTabc_SelectionItem2Import ($import)
					ACTwiz_ResultadosImport ($import)
				End if 
			Else 
				CD_Dlog (0;__ ("No se puede leer archivo."))
			End if 
		Else 
			CD_Dlog (0;__ ("Archivo no encontrado."))
		End if 
	Else 
		<>bACTimport_botonCancelar:=True:C214
		<>bACTimport_inDialog:=False:C215
	End if 
	<>vlACT_WinRef:=0
	
	<>bACTimport_importando:=False:C215
	While (<>bACTimport_enProceso)
		DELAY PROCESS:C323(Current process:C322;60)
		IDLE:C311
	End while 
Else 
	  //BRING TO FRONT(<>vlACT_WinRef)
	WDW_SetFrontmost (<>vlACT_WinRef)
	
	<>bACTimport_inDialog:=False:C215
End if 