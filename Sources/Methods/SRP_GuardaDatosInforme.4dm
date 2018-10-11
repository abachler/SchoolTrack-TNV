//%attributes = {}
  // SRP_GuardaDatosInforme()
  //
  //
  // creado por: Alberto Bachler Klein: 04-04-16, 17:15:47
  // -----------------------------------------------------------
C_LONGINT:C283($l_esArea)
C_TEXT:C284($t_xmlReport)

C_LONGINT:C283(xReportData)


$l_esArea:=SR_GetLongProperty (xReportData;1;SRP_Area_IsArea)
If ($l_esArea=1)  // me aseguro que el comando se esté ejecutando desde el editor
	[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
	[xShell_Reports:54]ReportType:2:=vtQR_CurrentReportType
	[xShell_Reports:54]RegistrosXPagina:44:=vlSR_RegXPagina
	[xShell_Reports:54]SR_MainTable:42:=SRP_LeeTablaInforme (xReportData)
	If ([xShell_Reports:54]Modulo:41="")
		[xShell_Reports:54]Modulo:41:=vsBWR_CurrentModule
	End if 
	If (Table:C252(yBWR_currentTable)#Abs:C99(vlQR_SRMainTable))
		[xShell_Reports:54]RelatedTable:14:=Abs:C99(vlQR_SRMainTable)
	End if 
	SRcust_AutoCode (xReportData)
	SR_SaveReport (xReportData;$t_xmlReport;0)
	TEXT TO BLOB:C554($t_xmlReport;[xShell_Reports:54]xReportData_:29;UTF8 text without length:K22:17)
	SAVE RECORD:C53([xShell_Reports:54])
End if 