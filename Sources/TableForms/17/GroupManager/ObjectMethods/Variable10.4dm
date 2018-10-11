Case of 
	: (Form event:C388=On Drop:K2:12)
		If (<>atUSR_GroupNames>0)
			DRAG AND DROP PROPERTIES:C607($source;$SourceElement;$processID)
			  //$userPointer:=-><>atUSR_UserNames
			$userPointer:=-><>atUSR_UserNamesInterfaz  //ABC//199095 //20180228
			Case of 
				: ($source=$userPointer)
					$userID:=<>alUSR_UserIds2{$sourceElement}
					USR_GetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};->vsUSR_GroupName;->vlUSR_GroupOwnerID;-><>aMembersID)
					If (Find in array:C230(<>aMembersID;$userID)<0)
						INSERT IN ARRAY:C227(<>aMembersID;Size of array:C274(<>aMembersID)+1;1)
						<>aMembersID{Size of array:C274(<>aMembersID)}:=$userID
						$result:=USR_SetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};vsUSR_GroupName;vlUSR_GroupOwnerID;-><>aMembersID)
					Else 
						$result:=0
						BEEP:C151
					End if 
					If ($result#0)
						$result:=USR_AddUserMembership ($userID;<>alUSR_GroupIds{<>atUSR_GroupNames})
						If ($result=0)
							$result:=USR_RemoveUserMembership ($userID;<>alUSR_GroupIds{<>atUSR_GroupNames})
							$ign:=CD_Dlog (0;__ (""))
						End if 
					End if 
					<>atUSR_GroupNames:=$dropPosition
					USR_GetGroupMemberList (<>alUSR_GroupIds{<>atUSR_GroupNames})
					USR_GetUserMembership (<>alUSR_UserIds2{<>atUSR_UserNamesInterfaz})
			End case 
		Else 
			CD_Dlog (0;__ ("Seleccione el grupo al que desea asignar el usuario o arrastre el usuario sobre el nombre del grupo."))
		End if 
	: (Form event:C388=On Double Clicked:K2:5)
		$currentUserID:=USR_GetUserID 
		If ((USR_IsGroupMember_by_GrpID (-15001)) | ($currentUserID<0))
			$el:=Find in array:C230(<>atUSR_UserNames;Self:C308->{Self:C308->})
			If ($el>0)
				<>alUSR_UserIds:=$el
				<>atUSR_UserNames:=$el
				<>atUSR_UserNamesInterfaz:=$el  // MOD Ticket N° 212997 Patricio Aliaga  20180816
				USR_ModifyUser (-><>atUSR_UserNamesInterfaz)
			End if 
		Else 
			CD_Dlog (0;__ ("Usted no dispone de los derechos requeridos para editar los registros de usuarios."))
		End if 
End case 