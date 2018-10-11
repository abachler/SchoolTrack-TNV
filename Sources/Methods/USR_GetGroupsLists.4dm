//%attributes = {}
  //USR_GetGroupsLists

If (False:C215)
	  // Project method: XSug_GetGroups
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_GetGroups()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 29/12/01  13:30, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================


  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
If (<>vbUSR_Use4DSecurity)
	GET GROUP LIST:C610(<>atUSR_GroupNames;<>alUSR_GroupIds)
Else 
	READ ONLY:C145([xShell_UserGroups:17])
	ALL RECORDS:C47([xShell_UserGroups:17])
	SELECTION TO ARRAY:C260([xShell_UserGroups:17]GroupName:2;<>atUSR_GroupNames;[xShell_UserGroups:17]IDGroup:1;<>alUSR_GroupIds;[xShell_UserGroups:17];<>alUSR_GROUPRECNUMS)
End if 
SORT ARRAY:C229(<>atUSR_GroupNames;<>alUSR_GroupIds;<>alUSR_GROUPRECNUMS;>)
  // END OF METHOD