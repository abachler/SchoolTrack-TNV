//%attributes = {}
  //USR_DeleteGroup

C_LONGINT:C283($1;$groupId)
$groupId:=$1

USR_GetGroupProperties ([xShell_UserGroups:17]IDGroup:1;->vsUSR_GroupName;->vlUSR_GroupOwnerID;-><>aMembersID)
For ($i;Size of array:C274(<>aMembersID);1;-1)
	$memberID:=<>aMembersID{$i}
	If (<>aMembersID{$i}<0)
		USR_RemoveGroupFromGroup ($memberID;$groupId)
	Else 
		USR_RemoveUserFromGroup ($memberID;$groupId)
	End if 
End for 

READ WRITE:C146([xShell_UserGroups:17])
QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=$groupId)

  //
  //se crea registro en el log para informar de la eliminacion del grupo
  //ticket 125103 08-09-15 JVP
LOG_RegisterEvt ("Eliminacion de grupo del sistema. Grupo: "+[xShell_UserGroups:17]GroupName:2+" Propietario: "+[xShell_UserGroups:17]PropietaryName:9)
  //

DELETE RECORD:C58([xShell_UserGroups:17])
STWA2_ManejaTiempoDeSesion ("delete";$groupId)

USR_GetUserMembership (<>alUSR_UserIds{<>atUSR_UserNames})
