//%attributes = {}
  //USR_SetGroupProperties

If (False:C215)
	  // Project method: XSug_SetGroupProperties
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_SetGroupProperties()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 11/1/02  19:19, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_LONGINT:C283($0;$1;$3;$groupID;$propietary)
C_TEXT:C284($2;$name)
C_POINTER:C301($members;$4)
  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
$groupID:=$1
$name:=$2
$Propietary:=$3
$members:=$4
If (<>vbUSR_Use4DSecurity)
	$groupID:=Set group properties:C614(groupID;$name;$propietary;$members->)
Else 
	$el:=Find in array:C230(<>alUSR_GroupIds;$groupID)
	If ($el>0)
		READ WRITE:C146([xShell_UserGroups:17])
		GOTO RECORD:C242([xShell_UserGroups:17];<>alUSR_GROUPRECNUMS{$el})
		While (Locked:C147([xShell_UserGroups:17]))
			DELAY PROCESS:C323(Current process:C322;10)
			LOAD RECORD:C52([xShell_UserGroups:17])
		End while 
		[xShell_UserGroups:17]GroupName:2:=$name
		[xShell_UserGroups:17]Propietary:3:=$Propietary
		VARIABLE TO BLOB:C532($members->;[xShell_UserGroups:17]xMembers:8)
		SAVE RECORD:C53([xShell_UserGroups:17])
		$groupID:=[xShell_UserGroups:17]IDGroup:1
		KRL_ReloadAsReadOnly (->[xShell_UserGroups:17])
	Else 
		$groupID:=0
	End if 
End if 

$0:=$groupID
  // END OF METHOD