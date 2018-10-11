Case of 
	: (Form event:C388=On Load:K2:1)
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportType:2=vtQR_CurrentReportType;*)
		QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]MainTable:3=Table:C252(yBWR_currentTable))
		ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
End case 
