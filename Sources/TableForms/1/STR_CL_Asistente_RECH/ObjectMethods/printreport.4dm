READ ONLY:C145(*)
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26="Errores Actas")
xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29

ALL RECORDS:C47([xxSTR_Constants:1])
REDUCE SELECTION:C351([xxSTR_Constants:1];1)

If ((Macintosh option down:C545) | (Windows Alt down:C563))
	iSR_WinRef:=SR Preview (xSR_ReportBlob;10;60;610;600;8;[xShell_Reports:54]ReportName:26)
Else 
	$err:=SR Print Report (xSR_ReportBlob;3;65535)
End if 