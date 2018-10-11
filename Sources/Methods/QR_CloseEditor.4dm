//%attributes = {}
  //QR_CloseEditor

Case of 
	: (vtQR_CurrentReportType="4DSE")
		POST KEY:C465(27;0)
	: (vtQR_CurrentReportType="gSR2")
		SRcust_AutoCode (xReportData)
		POST KEY:C465(27;0)
End case 
