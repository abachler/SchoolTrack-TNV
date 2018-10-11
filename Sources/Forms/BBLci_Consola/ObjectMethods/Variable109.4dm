ARRAY TEXT:C222(at_NombreReporte;0)
ARRAY LONGINT:C221(al_RecNumReporte;0)
  //COPY NAMED SELECTION([xxBBL_Logs];"◊Editions")
CUT NAMED SELECTION:C334([xxBBL_Logs:41];"◊Editions")  //20170315 RCH La selección se crea con CUT
CUT NAMED SELECTION:C334([xxBBL_Logs:41];"Logs")
CUT NAMED SELECTION:C334([BBL_Items:61];"Items")
CUT NAMED SELECTION:C334([BBL_Lectores:72];"Lector")
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[BBL_Items:61]);*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="_circulacion@")
If (Records in selection:C76([xShell_Reports:54])>1)
	SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;at_NombreReporte;[xShell_Reports:54];al_RecNumReporte)
	SRtbl_ShowChoiceList (0;"Seleccione Reporte";2;->bPrint_Informe;False:C215;->at_NombreReporte)
	If (ChoiceIdx>0)
		QR_ImprimeInformeSRP (al_RecNumReporte{ChoiceIdx})
	End if 
Else 
	If (Records in selection:C76([xShell_Reports:54])>0)
		QR_ImprimeInformeSRP (Record number:C243([xShell_Reports:54]))
	End if 
End if 
USE NAMED SELECTION:C332("Logs")
USE NAMED SELECTION:C332("Items")
USE NAMED SELECTION:C332("Lector")
