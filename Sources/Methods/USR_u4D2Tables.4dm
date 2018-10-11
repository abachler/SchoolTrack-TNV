//%attributes = {}
  //USR_u4D2Tables


USR_LoadPasswordTables 
$p:=Execute on server:C373("USR_LoadPasswordTables";Pila_256K;"Cargando usuarios y grupos...")

If (<>vbUSR_Use4DSecurity)
	READ WRITE:C146([xShell_Users:47])
	READ WRITE:C146([xShell_UserGroups:17])
	
	For ($users;1;Size of array:C274(<>alUSR_UserIds))
		If (Not:C34(Is user deleted:C616(<>alUSR_UserIds{$users})))
			QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=<>alUSR_UserIds{$users})
			If (Records in selection:C76([xShell_Users:47])=0)
				CREATE RECORD:C68([xShell_Users:47])
				GET USER PROPERTIES:C611(<>alUSR_UserIds{$users};$name;$Startup;$password;$nbLogin;$lastLogin;$ai_memberShip)
				[xShell_Users:47]No:1:=<>alUSR_UserIds{$users}
				[xShell_Users:47]login:9:=$name
				[xShell_UserGroups:17]PropietaryName:9:=[xShell_Users:47]Name:2
				[xShell_Users:47]SessionDate:5:=$lastLogin
				[xShell_Users:47]Nb_sesions:8:=$nbLogin
				
				ARRAY TEXT:C222(at_g1;0)
				ARRAY INTEGER:C220(ai_g1;0)
				For ($i;1;Size of array:C274($ai_memberShip))
					$pos:=Find in array:C230(<>alUSR_GroupIds;$ai_memberShip{$i})
					If ($pos>0)
						$s:=Size of array:C274(ai_g1)
						AT_Insert ($s;1;->ai_g1;->at_g1)
						ai_g1{$s}:=<>alUSR_GroupIds{$pos}
						at_g1{$s}:=<>atUSR_GroupNames{$pos}
					End if 
				End for 
				BLOB_Variables2Blob (->[xShell_Users:47]xGroups:18;0;->ai_g1;->at_g1)
				SAVE RECORD:C53([xShell_Users:47])
			End if 
		End if 
	End for 
	
	
	For ($groups;1;Size of array:C274(<>alUSR_GroupIds))
		GET GROUP PROPERTIES:C613(<>alUSR_GroupIds{$groups};$name;$propietario;$ai_members)
		QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=<>alUSR_GroupIds{$groups})
		If (Records in selection:C76([xShell_UserGroups:17])=0)
			CREATE RECORD:C68([xShell_UserGroups:17])
			[xShell_UserGroups:17]IDGroup:1:=<>alUSR_GroupIds{$groups}
			[xShell_UserGroups:17]GroupName:2:=<>atUSR_GroupNames{$groups}
		End if 
		[xShell_UserGroups:17]Propietary:3:=$propietario
		ARRAY TEXT:C222(at_g1;0)
		ARRAY INTEGER:C220(ai_g1;0)
		For ($i;1;Size of array:C274($ai_members))
			If (Not:C34(Is user deleted:C616($ai_members{$i})))
				GET USER PROPERTIES:C611($ai_members{$i};$name;$Startup;$password;$nbLogin;$lastLogin)
				$pos:=Find in array:C230(<>alUSR_UserIds;$ai_members{$i})
				If ($pos>0)
					$s:=Size of array:C274(ai_g1)
					AT_Insert ($s;1;->ai_g1;->at_g1)
					ai_g1{$s}:=<>alUSR_UserIds{$pos}
					at_g1{$s}:=<>atUSR_UserNames{$pos}
				End if 
			End if 
		End for 
		BLOB_Variables2Blob (->[xShell_UserGroups:17]xMembers:8;0;->ai_g1;->at_g1)
		SAVE RECORD:C53([xShell_UserGroups:17])
	End for 
End if 

KRL_ReloadAsReadOnly (->[xShell_UserGroups:17])
KRL_ReloadAsReadOnly (->[xShell_Users:47])