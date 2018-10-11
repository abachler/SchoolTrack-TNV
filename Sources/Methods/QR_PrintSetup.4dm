//%attributes = {}
  //QR_PrintSetup

Case of 
	: (vtQR_CurrentReportType="4DSE")
		QR EXECUTE COMMAND:C791(xQR_ReportARea;qr cmd page setup:K14900:24)
	: (vtQR_CurrentReportType="gSR2")
		$err:=SR Do Command (xReportData;SR MenuItem Page Setup;0)
End case 

