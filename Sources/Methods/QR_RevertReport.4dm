//%attributes = {}
  //QR_RevertReport

If (Record number:C243([xShell_Reports:54])>=0)
	Case of 
		: (vtQR_CurrentReportType="4DSE")
			
			If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
				$blob:=[xShell_Reports:54]xReportData_:29
				QR BLOB TO REPORT:C771(xQR_ReportArea;$blob)
			Else 
				
			End if 
			
		: (vtQR_CurrentReportType="gSR2")
			QR_SetReportEditorArea 
	End case 
End if 