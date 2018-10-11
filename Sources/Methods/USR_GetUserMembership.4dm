//%attributes = {}
  //USR_GetUserMembership


$userID:=$1
ARRAY TEXT:C222(<>atUSR_membership;0)
ARRAY LONGINT:C221(alUSR_Membership;0)

USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
AT_DimArrays (Size of array:C274(alUSR_Membership);-><>atUSR_membership)

For ($membersIndex;1;Size of array:C274(alUSR_Membership))
	$el:=Find in array:C230(<>alUSR_GroupIds;alUSR_Membership{$membersIndex})
	If ($el>0)
		<>atUSR_membership{$membersIndex}:=<>atUSR_GroupNames{$el}
	End if 
End for 