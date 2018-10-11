//%attributes = {}
  //USR_EditAccess2

USR_LoadPasswordTables 
ARRAY TEXT:C222(<>atUSR_membership;0)
ARRAY LONGINT:C221(alUSR_Membership;0)
ARRAY LONGINT:C221(<>aMembersID;0)
ARRAY TEXT:C222(<>aMembers;0)
MNU_SetMenuBar ("XS_Browser")
CFG_OpenConfigPanel (->[xShell_UserGroups:17];"GroupManager2";0;__ ("Grupos y Usuarios"))
$p:=Execute on server:C373("USR_LoadPasswordTables";Pila_256K;"Cargando Usuarios")
USR_u4D2Tables 
KRL_ReloadAsReadOnly (->[xShell_UserGroups:17])
KRL_ReloadAsReadOnly (->[xShell_Users:47])
