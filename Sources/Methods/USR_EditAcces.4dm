//%attributes = {}
  //USR_EditAcces

C_LONGINT:C283($numPages;$width;$height)
C_BOOLEAN:C305($fixedWidth;$fixedHeight)
C_TEXT:C284($title)
FORM GET PROPERTIES:C674([xShell_UserGroups:17];"GroupManager";$width;$height;$numPages;$fixedWidth;$fixedHeight;$title)
USR_LoadPasswordTables 
ARRAY TEXT:C222(<>atUSR_membership;0)
ARRAY LONGINT:C221(alUSR_Membership;0)
ARRAY LONGINT:C221(<>aMembersID;0)
ARRAY TEXT:C222(<>aMembers;0)
MNU_SetMenuBar ("XS_Browser")
CFG_OpenConfigPanel (->[xShell_UserGroups:17];"GroupManager";0;$title)
$p:=Execute on server:C373("USR_LoadPasswordTables";Pila_256K;"Cargando Usuarios")
USR_u4D2Tables 
KRL_ReloadAsReadOnly (->[xShell_UserGroups:17])
KRL_ReloadAsReadOnly (->[xShell_Users:47])
