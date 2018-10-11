//%attributes = {}
  //USR_ModifyUser2

QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=<>atUSR_UserNames{<>atUSR_UserNames})
$title:=__ ("Usuario: ")+<>atUSR_UserNames{<>atUSR_UserNames}
WDW_OpenFormWindow (->[xShell_Users:47];"Input2";-1;Palette form window:K39:9;$title)
BWR_ModifyRecord (->[xShell_Users:47];"Input2")
CLOSE WINDOW:C154
If (ok=1)
	USR_LoadPasswordTables 
End if 

KRL_UnloadReadOnly (->[xShell_UserGroups:17])
KRL_UnloadReadOnly (->[xShell_Users:47])