//%attributes = {}
  //USR_CurrentUser

If (False:C215)
	  // Project method: XSug_CurrentUser
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_CurrentUser()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 10/1/02  12:44, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_BOOLEAN:C305(<>vbUSR_Use4DSecurity)
C_TEXT:C284(<>tUSR_CurrentUser)

  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
If (<>vbUSR_Use4DSecurity)
	$userName:=USR_CurrentUser 
Else 
	$userName:=<>tUSR_CurrentUser
End if 

$0:=$userName
  // END OF METHOD