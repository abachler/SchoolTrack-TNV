//%attributes = {}
  //USR_RemoveUserMembership

If (False:C215)
	  // Project method: XSug_RemoveUserMembership
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_RemoveUserMembership()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 12/1/02  08:38, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_LONGINT:C283($userID;$groupToRemove;$result;$0;$1;$2)


  // INITIALIZATION
  // ============================================

$userID:=$1
$groupToRemove:=$2
  // MAIN CODE
  // ============================================
USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
$el:=Find in array:C230(alUSR_Membership;$groupToRemove)
If ($el>0)
	DELETE FROM ARRAY:C228(alUSR_Membership;$el)
End if 
$result:=USR_SetUserProperties ($userID;vsUSR_UserName;vsUSR_StartUpMethod;vsUSR_Password;vlUSR_NbLogin;vdUSR_LastLogin;->alUSR_Membership)


  // END OF METHOD