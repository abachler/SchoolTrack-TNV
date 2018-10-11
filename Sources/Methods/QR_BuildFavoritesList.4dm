//%attributes = {}
  // QR_BuildFavoritesList()
  // Por: Alberto Bachler K.: 21-03-14, 17:15:44
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_listaExpandida)
C_LONGINT:C283($i;$l_refItem;$l_iconoCarpeta;$l_refListaFavoritos;$l_refSublista;hl_FavoriteReports)
C_TEXT:C284($l_textoItem)

ARRAY BOOLEAN:C223($aItemIsExpanded;0)



If (Is a list:C621(hl_FavoriteReports))
	CLEAR LIST:C377(hl_FavoriteReports)
End if 
hl_FavoriteReports:=New list:C375


$l_iconoCarpeta:=Use PicRef:K28:4+27511
READ WRITE:C146([xShell_FavoriteReports:183])
QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]IsListDef:9=True:C214;*)
QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer))
If (Records in selection:C76([xShell_FavoriteReports:183])=0)
	$l_refListaFavoritos:=New list:C375
	APPEND TO LIST:C376($l_refListaFavoritos;"Mis Informes favoritos";1)
	SET LIST ITEM PROPERTIES:C386($l_refListaFavoritos;0;True:C214;0;$l_iconoCarpeta)
	CREATE RECORD:C68([xShell_FavoriteReports:183])
	[xShell_FavoriteReports:183]UserID:1:=<>lUSR_CurrentUserID
	[xShell_FavoriteReports:183]ReportName:4:="Mis Informes favoritos"
	[xShell_FavoriteReports:183]ReportTable:5:=Table:C252(vyQR_TablePointer)
	[xShell_FavoriteReports:183]IsListDef:9:=True:C214
	LIST TO BLOB:C556($l_refListaFavoritos;[xShell_FavoriteReports:183]xFolders:3)
	SAVE RECORD:C53([xShell_FavoriteReports:183])
	KRL_ReloadAsReadOnly (->[xShell_FavoriteReports:183])
	CLEAR LIST:C377($l_refListaFavoritos)
Else 
	If (BLOB size:C605([xShell_FavoriteReports:183]xFolders:3)=0)
		$l_refListaFavoritos:=New list:C375
		APPEND TO LIST:C376($l_refListaFavoritos;"Mis Informes favoritos";1)
		SET LIST ITEM PROPERTIES:C386($l_refListaFavoritos;0;True:C214;0;$l_iconoCarpeta)
		[xShell_FavoriteReports:183]UserID:1:=<>lUSR_CurrentUserID
		[xShell_FavoriteReports:183]ReportName:4:="Mis Informes favoritos"
		[xShell_FavoriteReports:183]ReportTable:5:=Table:C252(vyQR_TablePointer)
		[xShell_FavoriteReports:183]IsListDef:9:=True:C214
		LIST TO BLOB:C556($l_refListaFavoritos;[xShell_FavoriteReports:183]xFolders:3)
		SAVE RECORD:C53([xShell_FavoriteReports:183])
		KRL_ReloadAsReadOnly (->[xShell_FavoriteReports:183])
		CLEAR LIST:C377($l_refListaFavoritos)
	End if 
End if 
hl_FavoriteReports:=BLOB to list:C557([xShell_FavoriteReports:183]xFolders:3)
If (Count list items:C380(hl_FavoriteReports)=0)
	APPEND TO LIST:C376(hl_FavoriteReports;"Mis Informes Favoritos";1)
	SET LIST ITEM PROPERTIES:C386(hl_FavoriteReports;0;True:C214;0;$l_iconoCarpeta)
End if 

If (BLOB size:C605([xShell_FavoriteReports:183]xListSettings:6)>0)
	ARRAY BOOLEAN:C223($aItemIsExpanded;0)
	BLOB TO VARIABLE:C533([xShell_FavoriteReports:183]xListSettings:6;$aItemIsExpanded)
	For ($i;1;Size of array:C274($aItemIsExpanded))
		GET LIST ITEM:C378(hl_FavoriteReports;$i;$l_refItem;$l_textoItem;$l_refSublista;$b_listaExpandida)
		SET LIST ITEM:C385(hl_FavoriteReports;$l_refItem;$l_textoItem;$l_refItem;$l_refSublista;$aItemIsExpanded{$i})
	End for 
End if 


