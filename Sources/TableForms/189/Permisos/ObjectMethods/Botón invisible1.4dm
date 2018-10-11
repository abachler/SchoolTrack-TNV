RESOLVE POINTER:C394(Focus object:C278;$varName;$itable;$iField)
OK:=1
Case of 
	: ($varName="@Groups@")
		$item:=Selected list items:C379(hlQR_authorizedGroups)
		If (($item>0) & (Count list items:C380(hlQR_authorizedGroups)>0))
			GET LIST ITEM:C378(hlQR_authorizedGroups;$item;$groupID;$groupName)
			If (Not:C34(Shift down:C543))
				OK:=CD_Dlog (0;__ ("¿Desea usted realmente retirar los permisos de personalización de configuración de Aprendizajes esperados a los usuarios miembros del grupo ")+$groupName+__ ("?");__ ("");__ ("Si");__ ("No"))
			End if 
			If (OK=1)
				DELETE FROM LIST:C624(hlQR_authorizedGroups;*)
				_O_REDRAW LIST:C382(hlQR_authorizedGroups)
				LIST TO BLOB:C556(hlQR_AuthorizedGroups;[MPA_AsignaturasMatrices:189]xPermisos:5)
				LIST TO BLOB:C556(hlQR_authorizedUsers;[MPA_AsignaturasMatrices:189]xPermisos:5;*)
				SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
			End if 
		End if 
		
	: ($varName="@Users@")
		$item:=Selected list items:C379(hlQR_authorizedUsers)
		If (($item>0) & (Count list items:C380(hlQR_authorizedUsers)>0))
			GET LIST ITEM:C378(hlQR_authorizedUsers;$item;$userID;$userName)
			If (Not:C34(Shift down:C543))
				OK:=CD_Dlog (0;__ ("¿Desea usted realmente retirar los permisos de personalización de configuración de Aprendizajes esperados al usuario ")+$userName+__ ("?");__ ("");__ ("Si");__ ("No"))
			End if 
			If (OK=1)
				DELETE FROM LIST:C624(hlQR_authorizedUsers;*)
				_O_REDRAW LIST:C382(hlQR_authorizedUsers)
				LIST TO BLOB:C556(hlQR_AuthorizedGroups;[MPA_AsignaturasMatrices:189]xPermisos:5)
				LIST TO BLOB:C556(hlQR_authorizedUsers;[MPA_AsignaturasMatrices:189]xPermisos:5;*)
				SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
			End if 
		End if 
End case 

