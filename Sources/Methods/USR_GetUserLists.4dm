//%attributes = {}
  //USR_GetUserLists

If (False:C215)
	  // Project method: XSug_LoadUserAndGroups
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_LoadUserAndGroups()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 23/12/01  15:58, by Alberto Bachler
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
	ARRAY TEXT:C222(<>atUSR_UserNames;0)
	ARRAY LONGINT:C221(<>alUSR_UserIds;0)
	ARRAY TEXT:C222(<>atUSR_UserNombreRegistrado;0)
	GET USER LIST:C609(<>atUSR_UserNames;<>alUSR_UserIds)
	For ($i;Size of array:C274(<>alUSR_UserIds);1;-1)
		If (Is user deleted:C616(<>alUSR_UserIds{$i}))
			AT_Delete ($i;1;-><>alUSR_UserIds;-><>atUSR_UserNames)
		End if 
	End for 
	SORT ARRAY:C229(<>atUSR_UserNames;<>alUSR_UserIds;>)
Else 
	READ ONLY:C145([xShell_Users:47])
	ALL RECORDS:C47([xShell_Users:47])
	SELECTION TO ARRAY:C260([xShell_Users:47]login:9;<>atUSR_UserNames;[xShell_Users:47]No:1;<>alUSR_UserIds;[xShell_Users:47];<>alUSR_USERSRECNUMS;[xShell_Users:47]Name:2;<>atUSR_UserNombreRegistrado)
	SORT ARRAY:C229(<>atUSR_UserNames;<>atUSR_UserNombreRegistrado;<>alUSR_UserIds;<>alUSR_USERSRECNUMS;>)
End if 
  //Para actulizar la lista cunado se eliminan usuarios
ARRAY LONGINT:C221(al_idUsuarios;0)
ARRAY LONGINT:C221(al_Recnum;0)
ARRAY TEXT:C222(at_nombres;0)
ARRAY TEXT:C222(at_nombres2;0)

COPY ARRAY:C226(<>ALUSR_USERIDS;al_idUsuarios)
COPY ARRAY:C226(<>ATUSR_USERNAMES;at_nombres)
COPY ARRAY:C226(<>alUSR_USERSRECNUMS;al_Recnum)
COPY ARRAY:C226(<>atUSR_UserNombreRegistrado;at_nombres2)
  //ABC1
ARRAY TEXT:C222(<>ATUSR_USERNAMES2;0)  //Arreglos para usar en busquedas.
ARRAY TEXT:C222(<>atUSR_UserNamesInterfaz;0)
ARRAY LONGINT:C221(<>ALUSR_USERIDS2;0)
ARRAY LONGINT:C221(<>alUSR_USERSRECNUMS2;0)

COPY ARRAY:C226(<>ALUSR_USERIDS;<>ALUSR_USERIDS2)
COPY ARRAY:C226(<>ATUSR_USERNAMES;<>ATUSR_USERNAMES2)
COPY ARRAY:C226(<>alUSR_USERSRECNUMS;<>alUSR_USERSRECNUMS2)
COPY ARRAY:C226(<>ATUSR_USERNAMES;<>atUSR_UserNamesInterfaz)
  // END OF METHOD