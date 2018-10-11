//%attributes = {}
  //QR_Print

Case of 
	: (vtQR_CurrentReportType="4DSE")
		QR SET DESTINATION:C745(xQR_ReportArea;qr printer:K14903:1)
		QR RUN:C746(xQR_ReportArea)
		
	: (vtQR_CurrentReportType="gSR2")
		SRcust_AutoCode (xReportData)
		$err:=SR Do Command (xReportData;SR MenuItem Print;0)
		
End case 

