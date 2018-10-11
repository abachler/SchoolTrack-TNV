  // [xShell_Reports].ReportProperties.botonPermisos()
  // Por: Alberto Bachler K.: 19-08-14, 17:35:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
If (BLOB size:C605([xShell_Reports:54]xAuthorizedGroups:27)>0)
	hlQR_authorizedGroups:=BLOB to list:C557([xShell_Reports:54]xAuthorizedGroups:27)
Else 
	hlQR_authorizedGroups:=New list:C375
	LIST TO BLOB:C556(hlQR_authorizedGroups;[xShell_Reports:54]xAuthorizedGroups:27)
	SAVE RECORD:C53([xShell_Reports:54])
End if 
If (BLOB size:C605([xShell_Reports:54]xAuthorizedUsers:28)>0)
	hlQR_authorizedUsers:=BLOB to list:C557([xShell_Reports:54]xAuthorizedUsers:28)
Else 
	hlQR_authorizedUsers:=New list:C375
	LIST TO BLOB:C556(hlQR_authorizedUsers;[xShell_Reports:54]xAuthorizedUsers:28)
	SAVE RECORD:C53([xShell_Reports:54])
End if 
hlUSR_Groups:=USR_BuildGroupsHList 
If (Size of array:C274(<>atUSR_UserNames)>300)
	hlUSR_GroupsAndUsers:=USR_BuildUsersHList (True:C214)
Else 
	hlUSR_GroupsAndUsers:=USR_BuildUsersHList 
End if 
FORM GOTO PAGE:C247(2)
