//%attributes = {}
  // QR_SaveReport()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:30:40
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BLOB:C604($x_ReportBlob)
C_LONGINT:C283($l_refIcono;$l_IdInforme)
C_TEXT:C284($t_nombreInforme)


If (False:C215)
	C_LONGINT:C283(QR_SaveReport ;$1)
	C_LONGINT:C283(QR_SaveReport ;$2)
	C_LONGINT:C283(QR_SaveReport ;$3)
End if 

OK:=1

If ([xShell_Reports:54]ReportName:26#"")
	READ WRITE:C146([xShell_Reports:54])
	LOAD RECORD:C52([xShell_Reports:54])
	[xShell_Reports:54]DTS_UltimaModificacion:46:=""  //inicializo la fecha de modificación para forzar actualización en el trigger
	
	If ([xShell_Reports:54]LangageCode:10="")
		[xShell_Reports:54]LangageCode:10:=<>vtXS_langage
		SAVE RECORD:C53([xShell_Reports:54])
	End if 
	
	Case of 
		: (vtQR_CurrentReportType="gSR2")
			SRP_GuardaDatosInforme 
			KRL_ReloadAsReadOnly (->[xShell_Reports:54])
			
			
		: (vtQR_CurrentReportType="4DSE")
			[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
			[xShell_Reports:54]Modulo:41:=vsBWR_CurrentModule
			QR REPORT TO BLOB:C770(xQR_ReportArea;[xShell_Reports:54]xReportData_:29)
			SAVE RECORD:C53([xShell_Reports:54])
			KRL_ReloadAsReadOnly (->[xShell_Reports:54])
			
			
		: (vtQR_CurrentReportType="4DWR")
			[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
			[xShell_Reports:54]Modulo:41:=vsBWR_CurrentModule
			[xShell_Reports:54]xReportData_:29:=WR Area to blob:P12000:140 (xWrite;1)
			SAVE RECORD:C53([xShell_Reports:54])
			KRL_ReloadAsReadOnly (->[xShell_Reports:54])
			
			
		: (vtQR_CurrentReportType="4DVW")
			[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
			[xShell_Reports:54]Modulo:41:=vsBWR_CurrentModule
			[xShell_Reports:54]xReportData_:29:=PV Area to blob:P13000:14 (xView)
			SAVE RECORD:C53([xShell_Reports:54])
			KRL_ReloadAsReadOnly (->[xShell_Reports:54])
			
			
	End case 
	QR_SetReportEditorArea 
	QR_SetReportEditorMenu 
Else 
	QR_SaveReportAs 
	QR_SetReportEditorArea 
	QR_SetReportEditorMenu 
End if 
FLUSH CACHE:C297