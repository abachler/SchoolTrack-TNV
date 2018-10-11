//%attributes = {}
  //USR_AddUserMembership

If (False:C215)
	  // Project method: XSug_AddUserMembership
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_AddUserMembership()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 12/1/02  07:58, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_LONGINT:C283($userID;$groupToAdd;$result;$0;$1;$2)
ARRAY LONGINT:C221(alUSR_Membership;0)

  // INITIALIZATION
  // ============================================

$userID:=$1
$groupToAdd:=$2
  // MAIN CODE
  // ============================================
USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
If (Find in array:C230(alUSR_Membership;$groupToAdd)=-1)
	INSERT IN ARRAY:C227(alUSR_Membership;Size of array:C274(alUSR_Membership)+1;1)
	alUSR_Membership{Size of array:C274(alUSR_Membership)}:=$groupToAdd
End if 
$result:=USR_SetUserProperties ($userID;vsUSR_UserName;vsUSR_StartUpMethod;vsUSR_Password;vlUSR_NbLogin;vdUSR_LastLogin;->alUSR_Membership)

$0:=$result
  // END OF METHOD