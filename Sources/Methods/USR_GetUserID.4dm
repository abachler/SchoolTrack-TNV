//%attributes = {}
  //USR_GetUserID

If (False:C215)
	  // Project method: XSug_GetUserID
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_GetUserID()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 23/12/01  17:03, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_TEXT:C284($userName;$1)
C_LONGINT:C283($userID;$0)
C_BOOLEAN:C305(<>vbUSR_Use4DSecurity)

  // INITIALIZATION
  // ============================================
$userID:=0
$0:=0

  // MAIN CODE
  // ============================================
If (<>vbUSR_Use4DSecurity)
	If (Count parameters:C259=0)
		$username:=Current user:C182
	Else 
		$userName:=$1
	End if 
	$el:=Find in array:C230(<>atUSR_UserNames;$userName)
	If ($el>0)
		$userID:=<>alUSR_UserIds{$el}
	End if 
	$0:=$userID
Else 
	If (Count parameters:C259=0)
		$0:=<>lUSR_CurrentUserID
	Else 
		$userName:=$1
		$el:=Find in array:C230(<>atUSR_UserNames;$userName)
		If ($el>0)
			$0:=<>alUSR_UserIds{$el}
		End if 
	End if 
End if 



  // END OF METHOD