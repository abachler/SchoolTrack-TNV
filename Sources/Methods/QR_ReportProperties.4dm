//%attributes = {}
  //QR_ReportProperties

C_LONGINT:C283(hl_ReportProperties;hlQR_authorizedGroups;hlQR_authorizedUsers;hlUSR_Groups;hlUSR_GroupsAndUsers)

OK:=1
If (Record number:C243([xShell_Reports:54])<0)
	$result:=CD_Dlog (0;__ ("Para ver las propiedades de un informe es necesario haberlo guardado previamente.\r\r¿Desea guardarlo ahora?");__ ("");__ ("Sí");__ ("No"))
	If ($result=1)
		QR_SaveReport 
	End if 
Else 
	GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$recNum;$CurrentReportName)
	KRL_GotoRecord (->[xShell_Reports:54];$recNum)
	$title:=__ ("Propiedades de Informe: ")+[xShell_Reports:54]ReportName:26
	WDW_OpenFormWindow (->[xShell_Reports:54];"ReportProperties";-1;8;$title)
	KRL_ModifyRecord (->[xShell_Reports:54];"ReportProperties")
	CLOSE WINDOW:C154
	QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportId:2=[xShell_Reports:54]ID:7)
	READ WRITE:C146([xShell_FavoriteReports:183])
	APPLY TO SELECTION:C70([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportName:4:=[xShell_Reports:54]ReportName:26)
	UNLOAD RECORD:C212([xShell_FavoriteReports:183])
	SET LIST ITEM:C385(hl_informes;$recNum;[xShell_Reports:54]ReportName:26;$recNum)
	QR_BuildReportHList 
	QR_LoadSelectedReport 
	_O_REDRAW LIST:C382(hl_informes)
End if 