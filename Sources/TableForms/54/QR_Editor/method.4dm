Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vtQR_CurrentReportType:="4DSE"
		QR_SetReportEditorArea 
		QR_SetSortArea 
		QR_SetReportEditorMenu 
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15) | (Form event:C388=On Plug in Area:K2:16))
		MNU_SetMenuBar ("XS_ReportEditor")
		QR_SetReportEditorMenu 
		MNU_SetMenuItemState (False:C215;2;11;2;12;2;13;2;14;2;16)
	: (Form event:C388=On Activate:K2:9)
		MNU_SetMenuBar ("XS_ReportEditor")
		QR_SetReportEditorMenu 
		MNU_SetMenuItemState (False:C215;2;11;2;12;2;13;2;14;2;16)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Menu Selected:K2:14)
		$menu:=Menu selected:C152\65536
		$menuLine:=Menu selected:C152%65536
		Case of 
			: ($menu=1)
				Case of 
					: ($menuLine=1)
						QR_NewReport 
					: ($menuLine=2)
						QR_OpenReport 
					: ($menuLine=4)
						QR_SaveReport 
					: ($menuLine=5)
						QR_SaveReportAs 
					: ($menuLine=6)
						QR_RevertReport 
					: ($menuLine=8)
						QR_PrintSetup 
					: ($menuLine=9)
						QR_Preview 
					: ($menuLine=10)
						QR_Print 
					: ($menuLine=12)
						QR_ReportToTextFile 
					: ($menuLine=13)
						QR_ReportToHtml 
					: ($menuLine=15)
						QR_ReportTo4DView 
					: ($menuLine=18)
						QR_ReportProperties 
					: ($menuLine=20)
						QR_CloseEditor 
				End case 
		End case 
End case 