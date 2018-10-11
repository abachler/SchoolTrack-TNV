Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		WDW_SlideDrawer (->[MPA_AsignaturasMatrices:189];"Permisos")
		$offset:=0
		If (BLOB size:C605([MPA_AsignaturasMatrices:189]xPermisos:5)>0)
			hlQR_authorizedGroups:=BLOB to list:C557([MPA_AsignaturasMatrices:189]xPermisos:5;$offset)
			hlQR_authorizedUsers:=BLOB to list:C557([MPA_AsignaturasMatrices:189]xPermisos:5;$offset)
		Else 
			hlQR_authorizedGroups:=New list:C375
			hlQR_authorizedUsers:=New list:C375
			LIST TO BLOB:C556(hlQR_AuthorizedGroups;[MPA_AsignaturasMatrices:189]xPermisos:5)
			LIST TO BLOB:C556(hlQR_authorizedUsers;[MPA_AsignaturasMatrices:189]xPermisos:5;*)
			SAVE RECORD:C53([xShell_Reports:54])
		End if 
		hlUSR_Groups:=USR_BuildGroupsHList 
		If (Size of array:C274(<>atUSR_UserNames)>300)
			hlUSR_GroupsAndUsers:=USR_BuildUsersHList (True:C214)
		Else 
			hlUSR_GroupsAndUsers:=USR_BuildUsersHList 
		End if 
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

