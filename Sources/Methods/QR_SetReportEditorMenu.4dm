//%attributes = {}
  //QR_SetReportEditorMenu

If (Record number:C243([xShell_Reports:54])>=0)
	ENABLE MENU ITEM:C149(1;6)
Else 
	DISABLE MENU ITEM:C150(1;6)
End if 

Case of 
	: (vtQR_CurrentReportType="4DSE")
		ENABLE MENU ITEM:C149(1;15)
		ENABLE MENU ITEM:C149(1;16)
		$saveEnabled:=QR Get command status:C792(xQR_ReportArea;qr cmd save:K14900:20)
		If ($saveEnabled=1)
			ENABLE MENU ITEM:C149(1;4)
		Else 
			DISABLE MENU ITEM:C150(1;4)
		End if 
	: (vtQR_CurrentReportType="gSR2")
		  //DISABLE MENU ITEM(1;13)
		DISABLE MENU ITEM:C150(1;15)
		DISABLE MENU ITEM:C150(1;16)
End case 


