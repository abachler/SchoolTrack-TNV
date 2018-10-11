//%attributes = {}
  //QR_SaveFavoritesList

C_LONGINT:C283($subList)
C_BOOLEAN:C305($expanded)
C_LONGINT:C283(hl_Informes_temp)  //20111124 AS. declaro lista para que no de problemas en caso de venir indefinida.

$items:=Count list items:C380(hl_FavoriteReports)
ARRAY BOOLEAN:C223($aItemIsExpanded;$items)
For ($i;1;$items)
	GET LIST ITEM:C378(hl_FavoriteReports;$i;$itemRef;$itemText;$sublist;$expanded)
	  //MONO ticket 203509
	  //Mono: 11-10-2011 para evitar que los usuarios dejen las carpetas sin nombres
	  //If ($itemText="")
	  //GET LIST ITEM(hl_Informes_temp;$i;$itemRef_temp;$itemText_temp;$sublist_temp;$expanded_temp)
	  //SET LIST ITEM(hl_FavoriteReports;$i;$itemText_temp;$itemRef;$subList;$expanded)
	  //End if 
	
	$aItemIsExpanded{$i}:=$expanded
End for 
  //CLEAR LIST(hl_Informes_temp)
  //20111102 RCH Daba error siempre...
HL_ClearList (hl_Informes_temp)

READ WRITE:C146([xShell_FavoriteReports:183])
QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]IsListDef:9=True:C214;*)
QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer))
LIST TO BLOB:C556(hl_FavoriteReports;[xShell_FavoriteReports:183]xFolders:3)
SET BLOB SIZE:C606([xShell_FavoriteReports:183]xListSettings:6;0)
VARIABLE TO BLOB:C532($aItemIsExpanded;[xShell_FavoriteReports:183]xListSettings:6)
SAVE RECORD:C53([xShell_FavoriteReports:183])
KRL_ReloadAsReadOnly (->[xShell_FavoriteReports:183])