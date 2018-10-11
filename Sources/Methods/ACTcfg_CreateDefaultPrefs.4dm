//%attributes = {}
  //ACTcfg_CreateDefaultPrefs

$processID:=IT_UThermometer (1;0;__ ("Creando preferencias por defecto..."))
PREF_Set (0;"ACT_DecideApoderado";"1")
ACTinit_CreateEjercicio 

  //ACTinit_CreateUFTables 
  //20141117 RCH recalcula UF
$r_valor:=ACTinit_CreateUFTables 
ACTinit_CreateMonedas 
If ($r_valor#0)
	READ WRITE:C146([xxACT_Monedas:146])
	$vl_idMoneda:=-6
	QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Id_Moneda:1=$vl_idMoneda)
	[xxACT_Monedas:146]Valor:3:=$r_valor
	SAVE RECORD:C53([xxACT_Monedas:146])
	KRL_UnloadReadOnly (->[xxACT_Monedas:146])
End if 
ACTmon_CreaTablaDiaria 
READ ONLY:C145([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1="ACT_IPC@")
If (Records in selection:C76([xShell_Prefs:46])>0)
	ORDER BY:C49([xShell_Prefs:46];[xShell_Prefs:46]Reference:1;<)
	ACTcfg_OpenYear (Num:C11(ST_GetWord ([xShell_Prefs:46]Reference:1;2;" ")))
End if 

ACTinit_CreatePerFamilyDiscount 
ACTinit_CreateGenerationPrefs 
ACTinit_CreateInteresRecord 
ACTinit_CreateDesctoXARecord 
ACTinit_CreateDesctoARecord 
ACTinit_CreateDesctoERecord 
ACTinit_CreateDctoMonedaRecord 
ACTinit_CreateCargoMonedaRecord 
ACTinit_CreateDesctoANC 
ACTinit_CreateDesctoENC 
ACTinit_CreateDevolucionNC 
ACTinit_CreateInstitutionPrefs 
ACTinit_CreateIncomeRanges 
  //ACTinit_CreateMonedas 
ACTinit_CreateIVATasas 

  //20111026 RCH Siempre tiene que estar antes de ACTinit_CreateDocTributarios
$vl_idRS:=-1
  //20111129 RCH Sin esta declaracion da error en compilado
ARRAY LONGINT:C221(alACT_IDsCats;0)
ACTcfdi_OpcionesGenerales ("OnLoadConf";->$vl_idRS)
ACTinit_CreateDocTributarios 

IN_ACT_CargaTablaBancos 

  //20111026 RCH daba error porque el arreglo con las formas de pago no estaba ni tampoco el que crea los estados por defecto de las formas de pago...
ACTfdp_CargaFormasDePago 
ACTfdp_EstadosXDefecto 
ACTinit_CreateDefFdPCodes 

ACTinit_CreateDefConta 
ACTinit_CreateDefSetIngPagos 
ACTinit_CreateDefAfectasInteres 
ACTcfg_OpcionesTareasFinDia ("CreateDefPrefsDBNew")
  //20120604 RCH
ACTcfg_OpcionesRazonesSociales ("CreaPrincipal")
  // Saul Ponce (23-08-2018) Ticket Nº 214989, crear el descuento x cta durante la inicialización ACT
ACTcfg_OpcionesDescuentos ("creaDctoxCtaxDefecto")
IT_UThermometer (-2;$processID)

If (False:C215)
	  //frecuencias de facturacion
	ARRAY TEXT:C222(<>atACT_FreqFacturacion;5)
	ARRAY REAL:C219(<>arACT_FreqDescuento;0)
	ARRAY REAL:C219(<>arACT_FreqDescuento;5)
	<>atACT_FreqFacturacion{1}:="Mensual"
	<>atACT_FreqFacturacion{2}:="Bimestral"
	<>atACT_FreqFacturacion{3}:="Trimestral"
	<>atACT_FreqFacturacion{4}:="Semestral"
	<>atACT_FreqFacturacion{5}:="Anual"
	SET BLOB SIZE:C606($blobPointer->;0)
	BLOB_Variables2Blob ($blobPointer;0;-><>atACT_FreqFacturacion;-><>arACT_FreqDescuento)
	PREF_SetBlob (0;"ACT_Frecuencias Facturación";$blobPointer->)
	BLOB_Blob2Vars ($blobPointer;0;-><>atACT_FreqFacturacion;-><>arACT_FreqDescuento)
	SET BLOB SIZE:C606($blobPointer->;0)
End if 