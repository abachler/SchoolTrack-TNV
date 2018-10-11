//%attributes = {}
  //ACTac_ImpresionAvisos

$0:=-1
$reportRecNum:=$1

SRACTac_InitPrintingVariables 

READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
$reportName:=[xShell_Reports:54]FormName:17
$specialConfig:=[xShell_Reports:54]SpecialParameter:18
$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
$tablePointer:=Table:C252($tableNumber)
yBWR_currentTable:=$tablePointer
xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
$RegXPagina:=[xShell_Reports:54]RegistrosXPagina:44
If ($RegXPagina=0)
	$RegXPagina:=1
End if 
  //MONO Ticket 179726
SRP_ValidaAjustesImpresion ($reportRecNum)

<>stopExec:=False:C215
If ((OK=1) & (Not:C34(<>stopExec)))
	vb_HideColsCtas:=False:C215
	vb_HideColAfecto:=False:C215
	ARRAY LONGINT:C221($aRecNumsAvisos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRecNumsAvisos;"")
	$seleccionados:=Size of array:C274($aRecNumsAvisos)
	$Loops:=Int:C8($seleccionados/$RegXPagina)
	$BloquesProcesados:=0
	$LinearIndex:=0
	CD_Msg ("";6)
	For ($i;1;$Loops)
		If (Not:C34(<>stopExec))
			sMess:="Imprimiendo avisos de cobranza.\r\rCuantos de "+String:C10($seleccionados)+".\r\rNúmeros Total."
			$numDoc:=""
			For ($j;1;$RegXPagina)
				GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNumsAvisos{$LinearIndex+$j})
				$numDoc:=$numDoc+", "+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
				SRACTac_CargaCargos ($j)
			End for 
			$numDoc:=Substring:C12($numDoc;3)
			sMess:=Replace string:C233(sMess;"Cuantos";String:C10($LinearIndex+$RegXPagina))
			sMess:=Replace string:C233(sMess;"Total";$numDoc)
			DISPLAY RECORD:C105([xShell_Dialogs:114])
			SRACTac_HideNonUsedObjects 
			
			C_TEXT:C284($t_informeXML)
			$l_error:=SR_ConvertReportToXML (xSR_ReportBlob;$t_informeXML;[xShell_Reports:54]ReportName:26;"SRdh_ExecuteScript")
			
			If (($i=1) & (bHidePrintSettings=0))
				$l_error:=SR_Print ($t_informeXML;0;SRP_Print_AskJobSetup;"";0;"")
			Else 
				$l_error:=SR_Print ($t_informeXML;0;SRP_Print_ValidatePageSetup;"";0;"")
			End if 
			
			For ($j;1;$RegXPagina)
				SRACTac_EndAviso ($j)
			End for 
			$BloquesProcesados:=$BloquesProcesados+1
			$LinearIndex:=$LinearIndex+$RegXPagina
		End if 
		GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
		xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
	End for 
	$faltan:=$seleccionados-($BloquesProcesados*$RegXPagina)
	If ((Not:C34(<>stopExec)) & ($faltan>0))
		$arrayIndex:=Size of array:C274($aRecNumsAvisos)-$faltan
		sMess:="Imprimiendo avisos de cobranza.\r\rCuantos de "+String:C10($seleccionados)+".\r\rNúmero(s) Total."
		$numDoc:=""
		For ($i;1;$faltan)
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNumsAvisos{$arrayIndex+$i})
			$numDoc:=$numDoc+", "+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			SRACTac_CargaCargos ($i)
		End for 
		$numDoc:=Substring:C12($numDoc;3)
		sMess:=Replace string:C233(sMess;"Cuantos";String:C10($faltan))
		sMess:=Replace string:C233(sMess;"Total";$numDoc)
		DISPLAY RECORD:C105([xShell_Dialogs:114])
		For ($i;$faltan+1;4)
			SRACTac_HideNonUsedObjects ($i)
		End for 
		SRACTac_HideNonUsedObjects 
		$err:=SR Print Report (xSR_ReportBlob;4;65535)
		For ($i;1;$faltan)
			SRACTac_EndAviso ($i)
		End for 
	End if 
	CLOSE WINDOW:C154
End if 
$0:=1
