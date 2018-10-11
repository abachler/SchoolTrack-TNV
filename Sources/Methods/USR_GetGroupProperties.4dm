//%attributes = {}
  //USR_GetGroupProperties

If (False:C215)
	  // Project method: XSug_GetGroupProperties
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_GetGroupProperties()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 10/1/02  12:02, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_LONGINT:C283($1;$id)
C_POINTER:C301($2;$3;$4;$name;$propietaryID;$membersIdArray)

  // INITIALIZATION
  // ============================================
$id:=$1
$name:=$2
$propietaryID:=$3
$membersIdArray:=$4
$name->:=""
$propietaryID->:=0
AT_Initialize ($membersIdArray)

  // MAIN CODE
  // ============================================
If (<>vbUSR_Use4DSecurity)
	GET GROUP PROPERTIES:C613($id;$name->;$propietaryID->;$membersArray->)
Else 
	$el:=Find in array:C230(<>alUSR_GroupIds;$id)
	If ($el>0)
		READ ONLY:C145([xShell_UserGroups:17])
		GOTO RECORD:C242([xShell_UserGroups:17];<>alUSR_GROUPRECNUMS{$el})
		$name->:=[xShell_UserGroups:17]GroupName:2
		$propietaryID->:=[xShell_UserGroups:17]Propietary:3
		BLOB TO VARIABLE:C533([xShell_UserGroups:17]xMembers:8;$membersIdArray->)
	End if 
End if 

  // END OF METHOD