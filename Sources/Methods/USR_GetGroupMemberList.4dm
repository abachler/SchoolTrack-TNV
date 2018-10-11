//%attributes = {}
  //USR_GetGroupMemberList
C_LONGINT:C283($1;$groupID)


$groupID:=$1

ARRAY LONGINT:C221(alUSR_Membership;0)
AT_Initialize (-><>aMembersID;-><>aMembers)
$nextElement:=1

COPY ARRAY:C226(<>aMembersID;$al_IdMiembrosActuales)

ARRAY LONGINT:C221($aMainGroupMembers;0)
ARRAY LONGINT:C221($aGroupMembers;0)
USR_GetGroupProperties ($1;->vsUSR_GroupName;->vlUSR_GroupOwnerID;->$aMainGroupMembers)

For ($membersIndex;1;Size of array:C274($aMainGroupMembers))
	Case of 
		: ($aMainGroupMembers{$membersIndex}<0)  //groups      
			USR_GetGroupProperties ($aMainGroupMembers{$membersIndex};->vsUSR_GroupName;->vlUSR_GroupOwnerID;->$aGroupMembers)
			If (vsUSR_GroupName#"")
				AT_Insert ($nextElement;1;-><>aMembersID;-><>aMembers)
				<>aMembersID{$nextElement}:=$aMainGroupMembers{$membersIndex}
				<>aMembers{$nextElement}:="("+vsUSR_GroupName+")"
				$nextElement:=$nextElement+1
			End if 
		: ($aMainGroupMembers{$membersIndex}>=1)  //users
			USR_GetUserProperties ($aMainGroupMembers{$membersIndex};->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
			If (vsUSR_UserName#"")
				AT_Insert ($nextElement;1;-><>aMembersID;-><>aMembers)
				<>aMembersID{$nextElement}:=$aMainGroupMembers{$membersIndex}
				<>aMembers{$nextElement}:=vsUSR_UserName
				$nextElement:=$nextElement+1
			End if 
	End case 
End for 

SORT ARRAY:C229(<>aMembers;<>aMembersID;>)

If (AT_IsEqual (->$al_IdMiembrosActuales;-><>aMembersID)=0)
	$result:=USR_SetGroupProperties ($groupID;vsUSR_GroupName;vlUSR_GroupOwnerID;-><>aMembersID)
End if 
