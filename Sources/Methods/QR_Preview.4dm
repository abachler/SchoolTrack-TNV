//%attributes = {}
  //QR_Preview

Case of 
	: (vtQR_CurrentReportType="4DSE")
		QR EXECUTE COMMAND:C791(xQR_ReportARea;qr cmd print preview:K14900:25)
		
	: (vtQR_CurrentReportType="gSR2")
		SRcust_AutoCode (xReportData)
		$err:=SR Do Command (xReportData;SR MenuItem Preview;0)
		
End case 

