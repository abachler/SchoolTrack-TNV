//%attributes = {}
  //USR_AddGroupMembersToGroup

If (False:C215)
	  // Project method: XSug_SetUserMemberOf
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_SetUserMemberOf()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 11/1/02  18:59, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================


  // INITIALIZATION
  // ============================================
$currentGroup:=$2
$groupToAdd:=$1

  // MAIN CODE
  // ============================================
ARRAY LONGINT:C221(aLong1;0)
ARRAY LONGINT:C221(aLong2;0)
READ WRITE:C146([xShell_Users:47])
ALL RECORDS:C47([xShell_Users:47])
While (Not:C34(End selection:C36([xShell_Users:47])))
	BLOB TO VARIABLE:C533([xShell_Users:47]xGroups:18;aLong1)
	If ($currentGroup=0)  // if currentgroup=0, add membership to all users
		$el:=Find in array:C230(aLong1;$groupToAdd)
		If ($el<0)
			INSERT IN ARRAY:C227(aLong1;1;1)
			aLong1{$el}:=[xShell_Users:47]No:1
		End if 
	Else   // add membership only if user is member of the group $currentGroup
		$el:=Find in array:C230(aLong1;$currentGroup)
		If ($el>0)
			$el:=Find in array:C230(aLong1;$groupToAdd)
			If ($el=-1)
				INSERT IN ARRAY:C227(aLong1;1;1)
				aLong1{1}:=$groupToAdd
				VARIABLE TO BLOB:C532(aLong1;[xShell_Users:47]xGroups:18)
				SAVE RECORD:C53([xShell_Users:47])
			End if 
		End if 
	End if 
	NEXT RECORD:C51([xShell_Users:47])
End while 
KRL_ReloadAsReadOnly (->[xShell_Users:47])

  // END OF METHOD