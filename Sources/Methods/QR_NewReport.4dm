//%attributes = {}
  //QR_NewReport

Case of 
	: (vtQR_CurrentReportType="4DSE")
		QR EXECUTE COMMAND:C791(xQR_ReportARea;qr cmd new:K14900:18)
		
	: (vtQR_CurrentReportType="gSR2")
		If (Application version:C493>="15@")
			SRP_NuevoInforme 
		Else 
			  //$err:=SR Do Command (xReportData;SR MenuItem New;0)
		End if 
End case 

