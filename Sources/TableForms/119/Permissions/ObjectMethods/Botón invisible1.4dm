RESOLVE POINTER:C394(Focus object:C278;$varName;$itable;$iField)
OK:=1
Case of 
	: ($varName="@Groups@")
		$item:=Selected list items:C379(hl_authorizedGroups)
		If (($item>0) & (Count list items:C380(hl_authorizedGroups)>0))
			GET LIST ITEM:C378(hl_authorizedGroups;$item;$groupID;$groupName)
			If (Not:C34(Shift down:C543))
				OK:=CD_Dlog (0;__ ("¿Desea usted realmente retirar los permisos de impresión de este informe para los usuarios miembros del grupo ")+$groupName+__ ("?");__ ("");__ ("Si");__ ("No"))
			End if 
			If (OK=1)
				DELETE FROM LIST:C624(hl_authorizedGroups;*)
				_O_REDRAW LIST:C382(hl_authorizedGroups)
				LIST TO BLOB:C556(hl_authorizedGroups;[xShell_Reports:54]xAuthorizedGroups:27)
				SAVE RECORD:C53([xShell_Reports:54])
			End if 
		End if 
		
	: ($varName="@Users@")
		$item:=Selected list items:C379(hl_authorizedUsers)
		If (($item>0) & (Count list items:C380(hl_authorizedUsers)>0))
			GET LIST ITEM:C378(hl_authorizedUsers;$item;$userID;$userName)
			If (Not:C34(Shift down:C543))
				OK:=CD_Dlog (0;__ ("¿Desea usted realmente retirar los permisos de impresión de este informe para el usuario ")+$userName+__ ("?");__ ("");__ ("Si");__ ("No"))
			End if 
			If (OK=1)
				DELETE FROM LIST:C624(hl_authorizedUsers;*)
				_O_REDRAW LIST:C382(hl_authorizedUsers)
				LIST TO BLOB:C556(hl_authorizedUsers;[xShell_Reports:54]xAuthorizedUsers:28)
				SAVE RECORD:C53([xShell_Reports:54])
			End if 
		End if 
End case 
