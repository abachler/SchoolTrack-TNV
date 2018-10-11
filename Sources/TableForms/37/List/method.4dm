Case of 
	: (Form event:C388=On Display Detail:K2:22)
		vt_DateTime:=String:C10([xShell_Logs:37]Event_Date:3;7)+", "+String:C10([xShell_Logs:37]Event_Time:4)
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		<>lXS_LogWindowProcessID:=0
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
End case 
