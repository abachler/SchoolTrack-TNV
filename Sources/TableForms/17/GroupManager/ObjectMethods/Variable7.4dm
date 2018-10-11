$formEvent:=Form event:C388

Case of 
	: ($formEvent=On Clicked:K2:4)
		  //If (<>atUSR_UserNamesInterfaz>0)
		USR_GetGroupMemberList (<>alUSR_GroupIds{Self:C308->})
		  //End if 
	: ($formEvent=On Double Clicked:K2:5)
		USR_GetGroupProperties (<>alUSR_GroupIds{Self:C308->};->vsUSR_GroupName;->vlUSR_GroupOwnerID;-><>aMembersID)
		$userID:=USR_GetUserID 
		If (($UserID#vlUSR_GroupOwnerID) & ($userID>0))
			$recNum:=Find in field:C653([xShell_Users:47]No:1;vlUSR_GroupOwnerID)
			If (($recNum<0) & (USR_IsGroupMember_by_GrpID (-15001)))
				$answer:=CD_Dlog (0;__ ("El grupo ")+<>atUSR_GroupNames{<>atUSR_GroupNames}+__ (" es propiedad de un usuario que ya no existe.\r\r¿Desea usted tomar la propiedad de este grupo?");__ ("");__ ("Si");__ ("No"))
				If ($answer=1)
					READ WRITE:C146([xShell_UserGroups:17])
					QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=<>alUSR_GroupIds{<>atUSR_GroupNames})
					[xShell_UserGroups:17]Propietary:3:=<>lUSR_CurrentUserID
					[xShell_UserGroups:17]PropietaryName:9:=USR_GetUserName (<>lUSR_CurrentUserID)
					SAVE RECORD:C53([xShell_UserGroups:17])
					UNLOAD RECORD:C212([xShell_UserGroups:17])
					READ ONLY:C145([xShell_UserGroups:17])
					USR_ModifyGroup 
					<>atUSR_GroupNames:=0
					<>atUSR_UserNames:=0
					AT_Initialize (-><>aMembers;-><>atUSR_membership)
				End if 
			Else 
				$ownerName:=USR_GetUserName (vlUSR_GroupOwnerID)
				  //$msg:=Replace string(RP_GetIdxString (20001;7);"^0";$ownerName)
				CD_Dlog (0;Replace string:C233(__ ("Usted no es propietario de este grupo.\r\rEl grupo sólo puede ser editado por su propietario (^0).");__ ("^0");$ownerName))
			End if 
		Else 
			USR_ModifyGroup 
			<>atUSR_GroupNames:=0
			<>atUSR_UserNames:=0
			AT_Initialize (-><>aMembers;-><>atUSR_membership)
		End if 
		
	: ($formEvent=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($source;$SourceElement;$processID)
		$userPointer:=-><>atUSR_UserNamesInterfaz
		$membershipPointer:=-><>atUSR_membership
		$groupMembersPointer:=-><>aMembers
		
		Case of 
			: ($source=Self:C308)
				ARRAY LONGINT:C221($aMainGroupMembers;0)
				ARRAY LONGINT:C221($aGroupMembers;0)
				USR_GetGroupProperties (<>alUSR_GroupIds{Drop position:C608};->vsUSR_GroupName;->vlUSR_GroupOwnerID;->$aMainGroupMembers)
				If (Find in array:C230($aMainGroupMembers;<>alUSR_GroupIds{$sourceElement})<0)
					AT_Insert (0;1;->$aMainGroupMembers)
					$aMainGroupMembers{Size of array:C274($aMainGroupMembers)}:=<>alUSR_GroupIds{$sourceElement}
					USR_SetGroupMemberList (<>alUSR_GroupIds{Drop position:C608};->$aMainGroupMembers)
				End if 
				<>atUSR_GroupNames:=$dropPosition
				USR_GetGroupMemberList (<>alUSR_GroupIds{<>atUSR_GroupNames})
			: ($source=$membershipPointer)
				$draggedGroup:=Find in array:C230(<>atUSR_GroupNames;<>atUSR_membership{$sourceElement})
				If ($draggedGroup>0)
					$draggedGroupID:=<>alUSR_GroupIds{$draggedGroup}
				End if 
				$memberID:=<>alUSR_UserIds{<>atUSR_UserNames}
				$member:=<>atUSR_UserNames{<>atUSR_UserNames}
				If (<>vbUSR_Use4DSecurity)
					If ($element>0)
						AT_Delete ($SourceElement;1;-><>atUSR_membership)
						GET GROUP PROPERTIES:C613($draggedGroupID;$name;$propietary)
						$ID:=Set group properties:C614($draggedGroupID;$name;$propietary;<>aMembersID)
					End if 
				Else 
					Case of 
						: ($memberID<0)
							USR_RemoveGroupFromGroup ($memberID;$draggedGroupID)
						: ($memberID>0)
							USR_RemoveUserFromGroup ($memberID;$draggedGroupID)
					End case 
					If (<>atUSR_GroupNames#0)
						USR_GetGroupMemberList (<>alUSR_GroupIds{<>atUSR_GroupNames})
					End if 
					USR_GetUserMembership (<>alUSR_UserIds2{<>atUSR_UserNamesInterfaz})
					  //If (<>atUSR_UserNames#0)
					  //USR_GetUserMembership (<>alUSR_UserIds{<>atUSR_UserNames})
					  //End if 
				End if 
			: ($source=$groupMembersPointer)
				  //$draggedGroup:=Find in array(<>atUSR_GroupNames;<>atUSR_membership{$sourceElement})
				  //If ($draggedGroup>0)
				  //$draggedGroupID:=<>alUSR_GroupIds{<>atUSR_GroupNames}
				  //End if 
				$draggedGroupID:=<>alUSR_GroupIds{<>atUSR_GroupNames}
				If (<>aMembersID{$sourceElement}>0)
					$draggedMember:=Find in array:C230(<>atUSR_UserNames;<>aMembers{$sourceElement})
					If ($draggedMember>0)
						$memberID:=<>alUSR_UserIds{$draggedMember}
						$member:=<>atUSR_UserNames{$draggedMember}
					End if 
				Else 
					$groupName:=Substring:C12(<>aMembers{$sourceElement};2;Length:C16(<>aMembers{$sourceElement})-2)
					$draggedMember:=Find in array:C230(<>atUSR_GroupNames;$groupName)
					If ($draggedMember>0)
						$memberID:=<>alUSR_GroupIds{$draggedMember}
						$member:=<>atUSR_GroupNames{$draggedMember}
					End if 
				End if 
				  //$memberID:=<>alUSR_UserIds{<>atUSR_UserNames}
				  //$member:=<>atUSR_UserNames{<>atUSR_UserNames}
				If (<>vbUSR_Use4DSecurity)
					If ($element>0)
						AT_Delete ($SourceElement;1;-><>atUSR_membership)
						GET GROUP PROPERTIES:C613($draggedGroupID;$name;$propietary)
						$ID:=Set group properties:C614($draggedGroupID;$name;$propietary;<>aMembersID)
					End if 
				Else 
					Case of 
						: ($memberID<0)
							USR_RemoveGroupFromGroup ($memberID;$draggedGroupID)
						: ($memberID>0)
							USR_RemoveUserFromGroup ($memberID;$draggedGroupID)
					End case 
					If (<>atUSR_GroupNames#0)
						USR_GetGroupMemberList (<>alUSR_GroupIds{<>atUSR_GroupNames})
					End if 
					USR_GetUserMembership (<>alUSR_UserIds2{<>atUSR_UserNamesInterfaz})
					  //If (<>atUSR_UserNames#0)
					  //USR_GetUserMembership (<>alUSR_UserIds{<>atUSR_UserNames})
					  //End if 
				End if 
			: ($source=$userPointer)
				$dropPosition:=Drop position:C608
				<>atUSR_GroupNames:=$dropPosition
				If (<>atUSR_GroupNames>0)
					DRAG AND DROP PROPERTIES:C607($source;$SourceElement;$processID)
					
					  // Modificado por: Saúl Ponce (19/02/2018) Ticket Nº 198615, al realizar una búsqueda previa de usuarios, podía ocurrir que el sistema
					  // no lo asignara al arrastrar sobre el nombre del  grupo
					  // <>alUSR_UserIds, contiene el ID de todos los usuarios del sistema. <>alUSR_UserIds2, contiene el id de los usuarios filtrados
					$pos:=Find in array:C230(<>alUSR_UserIds;<>alUSR_UserIds2{$SourceElement})
					Case of 
						: ($source=$userPointer)
							  // Modificado por: Saúl Ponce (19/02/2018) Ticket Nº 198615, localizar el id usuario a partir de su posición en el array de todos los usuarios.
							  // $userID:=<>alUSR_UserIds{$sourceElement}
							$userID:=<>alUSR_UserIds{$pos}
							
							USR_GetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};->vsUSR_GroupName;->vlUSR_GroupOwnerID;-><>aMembersID)
							If (Find in array:C230(<>aMembersID;$userID)<0)
								INSERT IN ARRAY:C227(<>aMembersID;Size of array:C274(<>aMembersID)+1;1)
								<>aMembersID{Size of array:C274(<>aMembersID)}:=$userID
								$result:=USR_SetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};vsUSR_GroupName;vlUSR_GroupOwnerID;-><>aMembersID)
								
								  //20130822 RCH Asignar permisos para visualizar mensajes del centro de notificaciones
								If (<>alUSR_GroupIds{<>atUSR_GroupNames}=-15001)
									$l_bitsModules:=USR_ObtieneBitsParaGrupoNTC (<>alUSR_GroupIds{<>atUSR_GroupNames})
									If ($l_bitsModules#0)
										$t_parametros:=ST_Concatenate (";";->$userID;->$l_bitsModules)
										$b_done:=USR_AsignaBitAUsuarioNTC ($t_parametros)
										If (Not:C34($b_done))
											BM_CreateRequest ("NTC_AsignaBitAUsuario";$t_parametros)
										End if 
									End if 
								End if 
								
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
							  //USR_GetUserMembership (<>alUSR_UserIds{<>atUSR_UserNames})
							USR_GetUserMembership (<>alUSR_UserIds2{<>atUSR_UserNamesInterfaz})
					End case 
				Else 
					CD_Dlog (0;__ ("Seleccione el grupo al que desea asignar el usuario o arrastre el usuario sobre el nombre del grupo."))
				End if 
		End case 
End case 