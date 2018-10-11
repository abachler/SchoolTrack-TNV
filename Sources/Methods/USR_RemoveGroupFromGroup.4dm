//%attributes = {}
  //USR_RemoveGroupFromGroup

If (False:C215)
	  // Project method: XSug_RemoveGroupFromGroup
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_RemoveGroupFromGroup()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 12/1/02  10:45, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
$groupToRemove:=$1
$groupToRemoveFrom:=$2

  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
  //ARRAY LONGINT(aMembersID;0)
  //XSug_GetGroupProperties ($groupToRemove;->vsXSug_GroupName;->vlXSug_GroupOwner
  //~ID;->aMembersID)
  //COPY ARRAY(aMembersID;$aMembers)
  //For ($i;1;Size of array($aMembers))
  //  Case of 
  //    : ($aMembers{$i}<0)
  //      XSug_RemoveGroupFromGroup ($aMembers{$i};$groupToRemoveFrom)
  //    : ($aMembers{$i}>0)
  //      XSug_RemoveUserFromGroup ($aMembers{$i};$groupToRemoveFrom)
  //  End case 
  //End for 

USR_GetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};->vsUSR_GroupName;->vlUSR_GroupOwnerID;-><>aMembersID)
$el:=Find in array:C230(<>aMembersID;$groupToRemove)
If ($el>0)
	AT_Delete ($el;1;-><>aMembersID;-><>aMembers)
	$result:=USR_SetGroupProperties (<>alUSR_GroupIds{<>atUSR_GroupNames};vsUSR_GroupName;vlUSR_GroupOwnerID;-><>aMembersID)
End if 
USR_GetGroupProperties ($groupToRemove;->vsUSR_GroupName;->vlUSR_GroupOwnerID;-><>aMembersID)
$el:=Find in array:C230(alUSR_Membership;$groupToRemove)
If ($el>0)
	DELETE FROM ARRAY:C228(alUSR_Membership;$el)
	$result:=USR_SetGroupProperties ($groupToRemove;vsUSR_GroupName;vlUSR_GroupOwnerID;-><>aMembersID)
End if 





  // END OF METHOD