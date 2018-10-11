//%attributes = {}
  //USR_ModifyGroup

C_LONGINT:C283(hl_AuthModules;hl_ExecPermissions)
C_TEXT:C284($str)
QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]GroupName:2=<>atUSR_GroupNames{<>atUSR_GroupNames})
WDW_OpenFormWindow (->[xShell_UserGroups:17];"Input";-1;Movable form dialog box:K39:8;__ ("Grupos de usuarios");"WDW_Closedlog")
BWR_ModifyRecord (->[xShell_UserGroups:17];"Input")
CLOSE WINDOW:C154
If (ok=1)
	USR_LoadPasswordTables 
End if 

KRL_UnloadReadOnly (->[xShell_UserGroups:17])
KRL_UnloadReadOnly (->[xShell_Users:47])
