//%attributes = {}
  //USR_Initialize

  //type variables
  //C_STRING(15;sPass;newPass1;newPass2)
  //C_STRING(35;◊gUser)
  //C_BOOLEAN(createUser;modUser)
  //sPass:=""
  //newPass1:=""
  //newPass2:=""
  //◊gUser:=""
  //◊gGroup:=""
  //◊gUserNo:=0
  //◊gLevel:=0
  //createUser:=False
  //modUser:=False

USR_InitVariables 
USR_GetGroupsLists 
USR_GetUserLists 
USR_BuildAccesTables 

  //init users arrays
ARRAY TEXT:C222(<>aUsers;0)
ARRAY LONGINT:C221(<>aUserID;0)
ARRAY LONGINT:C221(<>aUserNo;0)

  //init group members array
ARRAY TEXT:C222(<>aMembers;0)
ARRAY LONGINT:C221(<>aMembersID;0)

  //Acces table
ARRAY TEXT:C222(<>aProcName;0)
ARRAY REAL:C219(<>aUserPriv;0)

  //UsersPrivileges
ARRAY TEXT:C222(<>aTools;0)
ARRAY TEXT:C222(<>aTxtPriv;0)
ARRAY PICTURE:C279(<>aPictPriv;0)

  //creating default Groups
If (Records in table:C83([xShell_UserGroups:17])=0)
	USR_CreateDefaultGroups 
End if 


