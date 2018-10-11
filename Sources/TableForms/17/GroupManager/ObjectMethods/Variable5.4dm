Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$currentUserID:=USR_GetUserID 
		If ((USR_IsGroupMember_by_GrpID (-15001)) | ($currentUserID<0))
			USR_ModifyUser (-><>atUSR_UserNamesInterfaz)
		Else 
			CD_Dlog (0;__ ("Usted no dispone de los derechos requeridos para editar los registros de usuarios."))
		End if 
	: (Form event:C388=On Clicked:K2:4)
		
		If (Self:C308->>0)
			USR_GetUserMembership (<>alUSR_UserIds2{<>atUSR_UserNamesInterfaz})
		End if 
		
	: (Form event:C388=On Drop:K2:12)
		
		$groupMembersPointer:=-><>aMembers
		DRAG AND DROP PROPERTIES:C607($source;$SourceElement;$processID)
		RESOLVE POINTER:C394($source;$sourceName;$tName;$fName)
		If ($source=$groupMembersPointer)
			$memberID:=<>aMembersId{$SourceElement}
			$member:=<>aMembers{$SourceElement}
			If (<>vbUSR_Use4DSecurity)
				If ($element>0)
					AT_Delete ($SourceElement;1;-><>aMembersID;-><>aMembers)
					GET GROUP PROPERTIES:C613(<>alUSR_GroupIds{<>atUSR_GroupNames};$name;$propietary)
					$ID:=Set group properties:C614(<>alUSR_GroupIds{<>atUSR_GroupNames};$name;$propietary;<>aMembersID)
				End if 
			Else 
				If ((Size of array:C274(<>aMembersId)=1) & (<>alUSR_GroupIds{<>atUSR_GroupNames}=-15001))
					ModernUI_Notificacion (__ ("Usuarios y Grupos");__ ("El grupo Administración debe contar con al menos un miembro"))
				Else 
					Case of 
						: ($memberID<0)
							USR_RemoveGroupFromGroup ($memberID;<>alUSR_GroupIds{<>atUSR_GroupNames})
						: ($memberID>0)
							USR_RemoveUserFromGroup ($memberID;<>alUSR_GroupIds{<>atUSR_GroupNames})
					End case 
				End if 
				If (<>atUSR_GroupNames#0)
					USR_GetGroupMemberList (<>alUSR_GroupIds{<>atUSR_GroupNames})
					USR_GetUserMembership (<>alUSR_UserIds2{<>atUSR_UserNamesInterfaz})  //MONO TICKET 200887
				End if 
				If (<>atUSR_UserNames#0)
					USR_GetUserMembership (<>alUSR_UserIds2{<>atUSR_UserNamesInterfaz})
				End if 
			End if 
			
		End if 
End case 