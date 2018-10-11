  // [xShell_Reports].SuperReportEditor()
  // Por: Alberto Bachler K.: 18-02-14, 14:51:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Load:K2:1)
		vtQR_CurrentReportType:="gSR2"
		MNU_SetMenuBar ("XS_ReportEditor")
		QR_SetReportEditorMenu 
		MNU_SetMenuItemState (False:C215;2;11;2;12;2;13;2;14;2;16)
		QR_SetReportEditorArea 
		
		$err:=SR Options (xReportData;-1;-1;0)
		SR_SetStandardMenus 
		SR_SetVariables 
		SR_SetStructureMenu 
		$err:=SR Set Editor Callback (xReportData;"SRcust_EditorCallBack")
		dhSR_SetWizardsMenu 
		
	: (Form event:C388=On Activate:K2:9)
		MNU_SetMenuBar ("XS_ReportEditor")
		QR_SetReportEditorMenu 
		MNU_SetMenuItemState (False:C215;2;11;2;12;2;13;2;14;2;16)
		
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
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 

