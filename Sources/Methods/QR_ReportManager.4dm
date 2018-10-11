//%attributes = {}
  // QR_ReportManager()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:24:07
  // -----------------------------------------------------------
C_POINTER:C301($1)


If (False:C215)
	C_POINTER:C301(QR_ReportManager ;$1)
End if 

C_LONGINT:C283(hl_Reports;hlQR_authorizedGroups;hlQR_authorizedUsers;HL_NewTemplatePopup)
C_TEXT:C284(vs_reportName)

If (USR_GetMethodAcces ("QR_ReportManager"))  //MONO ticket 178676 
	
	QR_InitGenericObjects 
	
	
	READ ONLY:C145([xShell_Reports:54])
	vb_NotInReportEditor:=False:C215
	
	vs_ReportName:=""
	If (Count parameters:C259=1)
		vyQR_TablePointer:=$1
	Else 
		vyQR_TablePointer:=yBWR_currentTable
	End if 
	
	
	If (Not:C34(Is a list:C621(hl_Reports)))
		hl_Reports:=New list:C375
	Else 
		  //CLEAR LIST(hl_Reports)
		hl_Reports:=New list:C375
	End if 
	If (Not:C34(Is a list:C621(HL_NewTemplatePopup)))
		HL_NewTemplatePopup:=New list:C375
	Else 
		  //CLEAR LIST(hl_Reports)
		HL_NewTemplatePopup:=New list:C375
	End if 
	
	QR_GetAvailableTables (vyQR_TablePointer)
	
	
	WDW_OpenFormWindow (->[xShell_Reports:54];"XS_ReportManager";-1;8;__ ("Explorador de informes"))
	DIALOG:C40([xShell_Reports:54];"XS_ReportManager")
	CLOSE WINDOW:C154
	
	
	CLEAR LIST:C377(hl_Reports;*)
	CLEAR LIST:C377(HL_NewTemplatePopup)
	
	
End if 

BWR_LoadFormReportsArrays 