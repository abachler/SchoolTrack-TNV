//%attributes = {}
  //QR_RemoveFromFavorites

$selectedITem:=Selected list items:C379(hl_FavoriteReports)
If ($selectedITem>0)
	GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$folderRef;$folderName)
	GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$reportId;$reportName)
	
	KRL_GotoRecord (->[xShell_Reports:54];$reportId)
	$reportId:=[xShell_Reports:54]ID:7
	
	QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportId:2=$reportID;*)
	QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportParentListId:7=$folderRef;*)
	QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID)
	If (Records in selection:C76([xShell_FavoriteReports:183])>0)
		READ WRITE:C146([xShell_FavoriteReports:183])
		DELETE RECORD:C58([xShell_FavoriteReports:183])
		READ ONLY:C145([xShell_FavoriteReports:183])
	End if 
	DELETE FROM LIST:C624(hl_informes;*)
	_O_REDRAW LIST:C382(hl_informes)
End if 
QR_LoadSelectedReport 