Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (BLOB size:C605([xShell_SpecialPermissions:119]Groups:3)>0)
			hl_authorizedGroups:=BLOB to list:C557([xShell_SpecialPermissions:119]Groups:3)
		Else 
			hl_authorizedGroups:=New list:C375
			LIST TO BLOB:C556(hl_authorizedGroups;[xShell_SpecialPermissions:119]Groups:3)
			SAVE RECORD:C53([xShell_SpecialPermissions:119])
		End if 
		If (BLOB size:C605([xShell_SpecialPermissions:119]Users:4)>0)
			hl_authorizedUsers:=BLOB to list:C557([xShell_SpecialPermissions:119]Users:4)
		Else 
			hl_authorizedUsers:=New list:C375
			LIST TO BLOB:C556(hl_authorizedUsers;[xShell_SpecialPermissions:119]Users:4)
			SAVE RECORD:C53([xShell_SpecialPermissions:119])
		End if 
		hlUSR_Groups:=USR_BuildGroupsHList 
		If (Size of array:C274(<>atUSR_UserNames)>300)
			hlUSR_GroupsAndUsers:=USR_BuildUsersHList (True:C214)
		Else 
			hlUSR_GroupsAndUsers:=USR_BuildUsersHList 
		End if 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		LIST TO BLOB:C556(hl_authorizedGroups;[xShell_SpecialPermissions:119]Groups:3)
		LIST TO BLOB:C556(hl_authorizedUsers;[xShell_SpecialPermissions:119]Users:4)
		SAVE RECORD:C53([xShell_SpecialPermissions:119])
		
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_authorizedGroups)
		CLEAR LIST:C377(hl_authorizedUsers)
		CLEAR LIST:C377(hlUSR_Groups)
		CLEAR LIST:C377(hlUSR_GroupsAndUsers)
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 