//%attributes = {}
  //USR_CreateGroup

READ WRITE:C146([xShell_UserGroups:17])
FORM SET INPUT:C55([xShell_UserGroups:17];"Input2")
WDW_OpenFormWindow (->[xShell_UserGroups:17];"Input2";-1;Palette form window:K39:9;__ ("Grupos de usuarios");"WDW_Closedlog")
ADD RECORD:C56([xShell_UserGroups:17];*)
CLOSE WINDOW:C154
UNLOAD RECORD:C212([xShell_UserGroups:17])
READ ONLY:C145([xShell_UserGroups:17])
If (ok=1)
	USR_GetGroupsLists 
End if 