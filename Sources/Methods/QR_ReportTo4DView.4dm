//%attributes = {}
  //QR_ReportTo4DView

Case of 
	: (vtQR_CurrentReportType="4DSE")
		QR GET DESTINATION:C756(xQR_ReportArea;$savedDestination)
		QR SET DESTINATION:C745(xQR_ReportArea;qr 4D View area:K14903:3)
		QR RUN:C746(xQR_ReportArea)
		QR SET DESTINATION:C745(xQR_ReportArea;$savedDestination)
	: (vtQR_CurrentReportType="gSR2")
		  //No disponible
		
End case 

