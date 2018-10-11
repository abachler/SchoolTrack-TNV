//%attributes = {}
  //QR_PreviewReport

$printPreview:=True:C214

dhQR_PrePrintInstructions 

Case of 
	: (atQR_Selection2Print=1)
		vtQR_SelectionType:="Selección a imprimir: Los registros de la lista"
	: (atQR_Selection2Print=2)
		vtQR_SelectionType:="Selección a imprimir: Registros seleccionados en la lista"
	: (atQR_Selection2Print=3)
		vtQR_SelectionType:="Selección a imprimir: Todos los registros"
	: (atQR_Selection2Print=4)
		vtQR_SelectionType:="Selección a imprimir: Búsqueda previa"
End case 
vtQR_Records:=String:C10(Records in selection:C76(vyQR_TablePointer->))+" entre "+String:C10(Records in table:C83(vyQR_TablePointer->))+" "+vt_QRtableVName

  //ABK 20110921 - código eliminado
  // aquí había código para gestionar los ajustes de impresión de informes SuperReport
  // lo eliminé para manejarlo solo en QR_PrintSuperReport

  //PS 18-06-2012: se agrega verificacion para que solo se imprima un informe a la vez ya que al imprimir mas de un informe lanza error ya que la seleccion temporal es borrada tras la primera impresion

C_LONGINT:C283($vl_proc;$size;$i;$procState;$procTime;$origin)
C_TEXT:C284($vt_proc;$procName)
C_BOOLEAN:C305($vb_continuar;$procVisible)
_O_C_INTEGER:C282($unique)
  //$vt_proc:="Impresión de: Alumnos Con Descuentos"
$vt_proc:="Impresión de:@"
$vl_proc:=Process number:C372($vt_proc)

$size:=Count tasks:C335
$vb_continuar:=True:C214
For ($i;1;$size)
	PROCESS PROPERTIES:C336($i;$procName;$procState;$procTime;$procVisible;$unique;$origin)
	If ($procName=$vt_proc)
		$vb_continuar:=False:C215
		$i:=$size
	End if 
End for 

If ($vb_continuar)
	
	COPY NAMED SELECTION:C331(vyQR_TablePointer->;"<>Editions")
	$processName:="Impresión de: "+[xShell_Reports:54]ReportName:26
	$reportRecNum:=Record number:C243([xShell_Reports:54])
	
	
	
	USR_RegisterUserEvent (UE_PreviewReport;vlBWR_SelectedTableRef;[xShell_Reports:54]ReportName:26+";"+[xShell_Reports:54]ReportType:2)
	
	Case of 
		: ([xShell_Reports:54]ReportType:2="4DFO")  // 4D Form
			$id:=New process:C317("dhQR_SpecialReports";Pila_256K;$processName;$reportRecNum;$printPreview;vpXS_IconModule;vsBWR_CurrentModule)
		: ([xShell_Reports:54]ReportType:2="gSR2")  // SuperReport
			$pID:=New process:C317("QR_PrintSuperReport";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;vpXS_IconModule;vsBWR_CurrentModule)
		: ([xShell_Reports:54]ReportType:2="4DSE")  //Quick Report
			$pID:=New process:C317("QR_PrintQuickReport";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;vpXS_IconModule;vsBWR_CurrentModule)
		: ([xShell_Reports:54]ReportType:2="4DET")  //Quick Report
			$pID:=New process:C317("QR_PrintLabel";Pila_256K;$processName;$reportRecNum;$printPreview;vpXS_IconModule;vsBWR_CurrentModule)
		: ([xShell_Reports:54]ReportType:2="4DWR")
			$pID:=New process:C317("QR_PrintWriteDocument";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;"";vpXS_IconModule;vsBWR_CurrentModule)
		: ([xShell_Reports:54]ReportType:2="4DVW")
			$pID:=New process:C317("QR_PrintViewDocument";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;"";vpXS_IconModule;vsBWR_CurrentModule)
		: ([xShell_Reports:54]ReportType:2="4DDW")
			$pID:=New process:C317("QR_PrintDrawDocument";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;"")
		: ([xShell_Reports:54]ReportType:2="4DCT")
			$pID:=New process:C317("QR_PrintChartDocument";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;"")
		: ([xShell_Reports:54]ReportType:2="PPro")
			$pID:=New process:C317("PPro_Print";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;"")
		: ([xShell_Reports:54]ReportType:2="hmRE")
			$pID:=New process:C317("hmR_Print";Pila_256K;$processName;$reportRecNum;$printPreview;qr printer:K14903:1;"")
	End case 
	  //End if 
	
	vyQRY_TablePointer:=vyQR_TablePointer
	Case of 
		: (atQR_Selection2Print=1)
			vtQR_SelectionType:="Selección a imprimir: Registros seleccionados en la lista"
			BWR_SearchRecords 
			If (Records in selection:C76(vyQR_TablePointer->)=0)
				_O_DISABLE BUTTON:C193(bPrint)
				_O_DISABLE BUTTON:C193(bPreview)
			End if 
			
		: (atQR_Selection2Print=2)
			vtQR_SelectionType:="Selección a imprimir: Los registros de la lista"
			SET_UseSet ("<>setFile "+String:C10(Table:C252(vyQR_TablePointer)))
			If (Records in selection:C76(vyQR_TablePointer->)=0)
				_O_DISABLE BUTTON:C193(bPrint)
				_O_DISABLE BUTTON:C193(bPreview)
			End if 
			
		: (atQR_Selection2Print=3)
			vtQR_SelectionType:="Selección a imprimir: Todos los registros"
			wSrchInSel:=False:C215
			ALL RECORDS:C47(vyQR_TablePointer->)
			If (Records in selection:C76(vyQR_TablePointer->)=0)
				_O_DISABLE BUTTON:C193(bPrint)
				_O_DISABLE BUTTON:C193(bPreview)
			End if 
			
		: (atQR_Selection2Print=4)
			If (Records in selection:C76(vyQR_TablePointer->)=0)
				_O_DISABLE BUTTON:C193(bPrint)
				_O_DISABLE BUTTON:C193(bPreview)
			End if 
	End case 
	If (atQR_Selection2Print#0)
		vtQR_Records:=String:C10(Records in selection:C76(vyQR_TablePointer->))+" entre "+String:C10(Records in table:C83(vyQR_TablePointer->))+" "+vt_QRtableVName
	Else 
		vtQR_Records:=""
	End if 
	
End if 