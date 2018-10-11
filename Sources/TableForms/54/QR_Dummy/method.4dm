Case of 
	: (Form event:C388=On Load:K2:1)
		vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
		GOTO RECORD:C242([xShell_Reports:54];Record number:C243([xShell_Reports:54]))
		If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
			$blob:=[xShell_Reports:54]xReportData_:29
			QR BLOB TO REPORT:C771(xQR_ReportArea;$blob)
		End if 
		If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252(yBWR_currentTable)))
			QR SET REPORT TABLE:C757(xQR_ReportArea;[xShell_Reports:54]RelatedTable:14)
			atQR_TableFieldSelector:=2
			  //QR_BuildTableList (->hlQR_FieldList;vlQR_MainTable;atQR_TableFieldSelector)
		Else 
			QR SET REPORT TABLE:C757(xQR_ReportArea;[xShell_Reports:54]MainTable:3)
		End if 
		QR SET DESTINATION:C745(xQR_ReportArea;vi_printDestination)
		If (vb_PrintPreview)
			QR EXECUTE COMMAND:C791(xQR_ReportArea;2007)
		Else 
			QR EXECUTE COMMAND:C791(xQR_ReportArea;2008)
		End if 
		CANCEL:C270
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 