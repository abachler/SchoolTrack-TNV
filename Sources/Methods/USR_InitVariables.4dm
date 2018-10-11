//%attributes = {}
  //USR_InitVariables

If (False:C215)
	  // Project method: XSug_Initialize
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_Initialize()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 29/12/01  13:32, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
ARRAY TEXT:C222(<>atUSR_GroupNames;0)
ARRAY TEXT:C222(<>atUSR_UserNames;0)
ARRAY TEXT:C222(<>aModules;0)
ARRAY LONGINT:C221(<>alUSR_GroupIds;0)
ARRAY LONGINT:C221(<>alUSR_UserIds;0)
ARRAY LONGINT:C221(<>alUSR_GROUPRECNUMS;0)
ARRAY LONGINT:C221(<>alUSR_USERSRECNUMS;0)
ARRAY LONGINT:C221(atpw_GroupMembersIDs;0)
ARRAY TEXT:C222(<>atUSR_membership;0)
ARRAY TEXT:C222(atpw_GroupMembersNames;0)
ARRAY INTEGER:C220(<>aAccesFile;0)
ARRAY INTEGER:C220(<>aAccesPriv;0)
ARRAY TEXT:C222(<>ATUSR_AUTHORIZEDCOMMANDS;0)
ARRAY TEXT:C222(<>atUSR_AuthModules;0)
ARRAY TEXT:C222(<>aMembers;0)
ARRAY LONGINT:C221(<>aMembersId;0)
ARRAY LONGINT:C221(alUSR_Membership;0)
C_TEXT:C284(vsUSR_GroupName)
C_LONGINT:C283(vlUSR_GroupOwnerID)
C_BOOLEAN:C305(<>vbUSR_Use4DSecurity)
C_DATE:C307(<>dUSR_ExpiresOn)
C_BLOB:C604(vxUSR_Pass)

  // INITIALIZATION
  // ============================================
<>vbUSR_Use4DSecurity:=False:C215

  // MAIN CODE
  // ============================================



  // END OF METHOD