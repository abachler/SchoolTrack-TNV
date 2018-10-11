Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		If (Self:C308->=0)
			OBJECT SET FONT STYLE:C166(Self:C308->;Bold:K14:2)
		End if 
	: (Form event:C388=On Mouse Leave:K2:34)
		If (Self:C308->=1)
			OBJECT SET FONT STYLE:C166(Self:C308->;Bold:K14:2)
		Else 
			OBJECT SET FONT STYLE:C166(Self:C308->;Plain:K14:1)
		End if 
	: (Form event:C388=On Clicked:K2:4)
		vtQR_CurrentReportType:="4DWR"
		QR_BuildReportHList 
		QR_LoadSelectedReport 
End case 
