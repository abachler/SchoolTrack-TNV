//%attributes = {}
C_LONGINT:C283($t)
C_BOOLEAN:C305($0)

$userID:=<>lUSR_CurrentUserID
If (Count parameters:C259=1)
	$userID:=$1
End if 

$0:=False:C215
If (Not:C34(USR_IsGroupMember_by_GrpID (-15001;$userID)))
	USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
	For ($i;1;Size of array:C274(alUSR_Membership))
		$groupID:=alUSR_Membership{$i}
		USR_GetGroupAppSpecificData ($groupID;"limitarbusquedas";->$t)
		If ($t=1)
			$i:=Size of array:C274(alUSR_Membership)+1
			$0:=True:C214
		End if 
	End for 
End if 