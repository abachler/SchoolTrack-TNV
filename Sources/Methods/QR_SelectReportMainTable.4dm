//%attributes = {}
  // QR_SelectReportMainTable()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 17:20:40
  // -----------------------------------------------------------
C_LONGINT:C283($0)


If (False:C215)
	C_LONGINT:C283(QR_SelectReportMainTable ;$0)
End if 

C_LONGINT:C283(vlQR_SelectedMainTableNumber)
vlQR_SelectedMainTableNumber:=0

QR_GetAvailableTables 
WDW_OpenFormWindow (->[xShell_Reports:54];"NewReport";7;Palette form window:K39:9)
DIALOG:C40([xShell_Reports:54];"NewReport")
CLOSE WINDOW:C154
CLEAR LIST:C377(hl_AvailableTables)
$0:=vlQR_SelectedMainTableNumber


