//%attributes = {}
  // SR_PrintPrevue()
  // Por: Alberto Bachler K.: 21-08-15, 18:29:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_modificado:=SR_GetLongProperty (xReportData;1;SRP_Report_Modified)
If ($l_modificado=1)
	READ WRITE:C146([xShell_Reports:54])
	LOAD RECORD:C52([xShell_Reports:54])
	[xShell_Reports:54]DTS_UltimaModificacion:46:=DTS_MakeFromDateTime 
	[xShell_Reports:54]timestampISO_modificacion:35:=Timestamp:C1445
	SAVE RECORD:C53([xShell_Reports:54])
	SRP_GuardaDatosInforme 
End if 

READ ONLY:C145([xShell_Reports:54])
LOAD RECORD:C52([xShell_Reports:54])

If (SR_ValidaScripts (xReportData))
	$iSR_WinRef:=SR Preview ([xShell_Reports:54]xReportData_:29;10;60;790;Screen height:C188-20;8;"Vista preliminar de "+[xShell_Reports:54]ReportName:26;1)
	
Else 
	CD_Dlog (0;__ ("Este informe tiene comandos prohibidos en sus scripts.\r\rEl informe no puede imprimirse."))
End if 