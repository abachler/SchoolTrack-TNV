//%attributes = {}
  //ACTbol_ImpresionDocsTrib

TRACE:C157
$0:=-1
$reportRecNum:=$1

READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
$reportName:=[xShell_Reports:54]FormName:17
$specialConfig:=[xShell_Reports:54]SpecialParameter:18
$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
$tablePointer:=Table:C252($tableNumber)
yBWR_currentTable:=$tablePointer
xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29

<>stopExec:=False:C215
Case of 
	: (<>gRolBD="100001")  //San Mateo Argentina
		ARRAY LONGINT:C221($aRecNumsBoletas;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$aRecNumsBoletas;"")
		CD_Msg ("";6)
		$seleccionados:=Size of array:C274($aRecNumsBoletas)
		For ($i;1;$seleccionados)
			If (Not:C34(<>stopExec))
				GOTO RECORD:C242([ACT_Boletas:181];$aRecNumsBoletas{$i})
				$numDoc1:=String:C10([ACT_Boletas:181]Numero:11)
				$tipo:=[ACT_Boletas:181]TipoDocumento:7
				sMess:="Imprimiendo "+$tipo+".\r\r"+String:C10($i)+" de "+String:C10($seleccionados)+"\r\rNúmero "+$numDoc1
				DISPLAY RECORD:C105([xShell_Dialogs:114])
				SRACTbol_CargaCargosGrange (1)
				$err:=SR Print Report (xSR_ReportBlob;4;65535)
				SRACTbol_EndBoletaGrange (1)
			End if 
		End for 
		CLOSE WINDOW:C154
		$0:=1
End case 
