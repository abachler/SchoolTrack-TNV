//%attributes = {}
  //USR_IsGroupMember_by_GrpName

If (False:C215)
	  // Project method: XSug_IsGroupMember
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_IsGroupMember()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 29/12/01  12:45, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_LONGINT:C283($2;$userID)
_O_C_STRING:C293(255;$1;$groupName)
ARRAY LONGINT:C221(alUSR_Membership;0)
vsUSR_UserName:=""
vsUSR_StartUpMethod:=""
vsUSR_Password:=""
vlUSR_NbLogin:=0
vdUSR_LastLogin:=!00-00-00!

  // INITIALIZATION
  // ============================================
$groupName:=$1
If (Count parameters:C259=2)
	$userId:=$2
Else 
	$userID:=USR_GetUserID 
End if 



  // MAIN CODE
  // ============================================
$groupID:=USR_GetGroupID ($groupName)
If (($USERID>=-99) & ($USERID<0))
	$0:=True:C214
Else 
	If ($groupID#0)
		If (<>vbUSR_Use4DSecurity)
			GET USER PROPERTIES:C611($userID;vsUSR_UserName;vsUSR_StartUpMethod;vsUSR_Password;vlUSR_NbLogin;vdUSR_LastLogin;alUSR_Membership)
		Else 
			USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
		End if 
		
		If (Find in array:C230(alUSR_Membership;$groupID)>0)
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
	End if 
End if 
  // END OF METHOD