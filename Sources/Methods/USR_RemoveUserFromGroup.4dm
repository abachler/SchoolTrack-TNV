//%attributes = {}
  //USR_RemoveUserFromGroup

If (False:C215)
	  // Project method: XSug_RemoveUserFromGroup
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_RemoveUserFromGroup()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 12/1/02  09:13, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================


  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
$userID:=$1
$groupId:=$2
$result:=$groupId
If (<>vbUSR_Use4DSecurity)
	DELETE USER:C615($id)
Else 
	USR_GetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};->vsUSR_GroupName;->vlUSR_GroupOwnerID;-><>aMembersID)
	$el:=Find in array:C230(<>aMembersID;$userId)
	If ($el>0)
		AT_Delete ($el;1;-><>aMembersID;-><>aMembers)
		$result:=USR_SetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};vsUSR_GroupName;vlUSR_GroupOwnerID;-><>aMembersID)
	End if 
	USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
	$el:=Find in array:C230(alUSR_Membership;$groupId)
	If ($el>0)
		DELETE FROM ARRAY:C228(alUSR_Membership;$el)
		$result:=USR_SetUserProperties ($userID;vsUSR_UserName;vsUSR_StartUpMethod;vsUSR_Password;vlUSR_NbLogin;vdUSR_LastLogin;->alUSR_Membership)
	End if 
End if 
$0:=$result
  // END OF METHOD