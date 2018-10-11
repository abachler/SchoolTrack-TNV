Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		SELECT LIST ITEMS BY POSITION:C381(hl_AvailableTables;1)
		_O_REDRAW LIST:C382(hl_AvailableTables)
		SELECT LIST ITEMS BY POSITION:C381(hl_AvailableTables;Count list items:C380(hl_AvailableTables)+1)
		bSRP:=bSuperReport
		bQR:=bQuickReports
		b4DLA:=bLabels
		b4DWR:=bWrite
		b4DVW:=bView
		b4DCH:=bChart
		b4DDR:=bDraw
	: (Form event:C388=On Clicked:K2:4)
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		bSuperReport:=bSRP
		bQuickReports:=bQR
		bLabels:=b4DLA
		bWrite:=b4DWR
		bView:=b4DVW
		bChart:=b4DCH
		bDraw:=b4DDR
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 