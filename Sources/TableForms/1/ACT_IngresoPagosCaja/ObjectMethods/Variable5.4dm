ARRAY TEXT:C222(at_NombreReporte;0)
ARRAY LONGINT:C221(al_RecNumReporte;0)
  //COPY NAMED SELECTION([ACT_Pagos];"◊Editions")
CUT NAMED SELECTION:C334([ACT_Pagos:172];"◊Editions")
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[ACT_Pagos:172]);*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="_Consola@")
If (Records in selection:C76([xShell_Reports:54])>1)
	SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;at_NombreReporte;[xShell_Reports:54];al_RecNumReporte)
	SRtbl_ShowChoiceList (0;"Seleccione Reporte";2;->bPrint;False:C215;->at_NombreReporte)
	If (ChoiceIdx>0)
		QR_ImprimeInformeSRP (al_RecNumReporte{ChoiceIdx})
	End if 
Else 
	If (Records in selection:C76([xShell_Reports:54])>0)
		QR_ImprimeInformeSRP (Record number:C243([xShell_Reports:54]))
	End if 
End if 