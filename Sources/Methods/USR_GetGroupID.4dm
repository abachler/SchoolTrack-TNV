//%attributes = {}
  //USR_GetGroupID

If (False:C215)
	  // Project method: XSug_GetGroupID
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_GetGroupID()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 29/12/01  12:49, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
_O_C_STRING:C293(255;$1)


  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================

$groupName:=$1
$groupID:=0
$el:=Find in array:C230(<>atUSR_GroupNames;$groupName)
If ($el>0)
	$groupID:=<>alUSR_GroupIds{$el}
Else 
	EM_HandleError (__ ("No se encontró el registro del grupo de usuarios.");Current method name:C684)
End if 
$0:=$groupID


  // END OF METHOD