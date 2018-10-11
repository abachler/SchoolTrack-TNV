//%attributes = {}
  // VC4D_CheckUser_devHook()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 12:34:48
  // -----------------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($hl_SuperUsers;$i;$l_currentUserID;$l_idUsuario;$l_itemRef;$l_UserID)
C_TEXT:C284($t_contraseña;$t_itemText;$t_login;$t_password;$t_UserName)

ARRAY LONGINT:C221($al_ids;0)


If (False:C215)
	C_LONGINT:C283(VC4D_CheckUser_devHook ;$0)
End if 

$t_UserName:=$1
$t_password:=$2

$hl_SuperUsers:=Load list:C383("XS_Designers")
$l_idUsuario:=Find in list:C952($hl_SuperUsers;$t_UserName;0;$al_ids;*)

$0:=-1
For ($i;1;Count list items:C380($hl_SuperUsers))
	GET LIST ITEM:C378($hl_SuperUsers;$i;$l_itemRef;$t_itemText)
	GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_itemRef;"login";$t_login)
	GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_itemRef;"contraseña";$t_contraseña)
	If (($t_login=$t_UserName) & ($t_password=$t_contraseña))
		$0:=1
		$i:=Count list items:C380($hl_SuperUsers)+1
	End if 
End for 



