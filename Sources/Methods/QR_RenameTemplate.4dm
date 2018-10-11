//%attributes = {}
  //QR_RenameTemplate

READ WRITE:C146([xShell_Reports:54])
$informe:=Selected list items:C379(hl_Informes)
GOTO RECORD:C242([xShell_Reports:54];vlQR_ReportRecNum)

$r:=CD_Dlog (0;__ ("Ingrese nuevo nombre:");__ ("");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("");[xShell_Reports:54]ReportName:26)
$newName:=vt_UserEntry

If (($newName#"") & ($r=1))
	$newName:=Replace string:C233(Replace string:C233(Replace string:C233($newName;"/";"|");"(";"[");")";"]")
	[xShell_Reports:54]ReportName:26:=Replace string:C233(Replace string:C233($newName;".4QR";"");"4LB";"")
	SAVE RECORD:C53([xShell_Reports:54])
	QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportId:2=[xShell_Reports:54]ID:7)
	READ WRITE:C146([xShell_FavoriteReports:183])
	APPLY TO SELECTION:C70([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportName:4:=[xShell_Reports:54]ReportName:26)
	UNLOAD RECORD:C212([xShell_FavoriteReports:183])
End if 

QR_BuildReportHList 
REDUCE SELECTION:C351([xShell_Reports:54];0)

SELECT LIST ITEMS BY POSITION:C381(hl_informes;$informe)
QR_LoadSelectedReport 
QR_AjustesMenu 

