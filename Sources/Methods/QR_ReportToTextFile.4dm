//%attributes = {}
  //QR_ReportToTextFile

Case of 
	: (vtQR_CurrentReportType="4DSE")
		QR GET DESTINATION:C756(xQR_ReportArea;$savedDestination)
		QR SET DESTINATION:C745(xQR_ReportArea;qr text file:K14903:2)
		QR RUN:C746(xQR_ReportArea)
		QR SET DESTINATION:C745(xQR_ReportArea;$savedDestination)
		
	: (vtQR_CurrentReportType="gSR2")
		SRcust_AutoCode (xReportData)
		$err:=SR Do Command (xReportData;SR MenuItem Print To Disk;0)
		
End case 

