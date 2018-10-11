  // [xShell_Reports].ReportProperties.permisosUsuario()
  // Por: Alberto Bachler K.: 20-08-14, 11:05:48
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_elemento;$l_idUsuario;$l_IdUsuarioSeleccionado)
C_TEXT:C284($t_UsuarioSeleccionado;$t_nombreUsuario;$t_refAcciones;$t_refElemento;$t_refMenuUsuarios)

GET LIST ITEM:C378(hlQR_authorizedUsers;Selected list items:C379(hlQR_authorizedUsers);$l_IdUsuarioSeleccionado;$t_UsuarioSeleccionado)


$t_refMenuUsuarios:=Create menu:C408
For ($i_elemento;1;Count list items:C380(hlUSR_GroupsAndUsers))
	GET LIST ITEM:C378(hlUSR_GroupsAndUsers;$i_elemento;$l_idUsuario;$t_nombreUsuario)
	If (Find in list:C952(hlQR_authorizedUsers;$t_nombreUsuario;0)=0)
		APPEND MENU ITEM:C411($t_refMenuUsuarios;$t_nombreUsuario)
		SET MENU ITEM PARAMETER:C1004($t_refMenuUsuarios;-1;"A"+String:C10($l_idUsuario))
	End if 
End for 

$t_refAcciones:=Create menu:C408
APPEND MENU ITEM:C411($t_refAcciones;__ ("Añadir Usuario");$t_refMenuUsuarios)
If ($t_UsuarioSeleccionado#"")
	APPEND MENU ITEM:C411($t_refAcciones;__ ("Quitar Usuario ")+$t_UsuarioSeleccionado)
Else 
	APPEND MENU ITEM:C411($t_refAcciones;"("+__ ("Quitar Usuario"))
End if 
SET MENU ITEM PARAMETER:C1004($t_refAcciones;-1;"Q"+String:C10($l_IdUsuarioSeleccionado))


$t_refElemento:=Dynamic pop up menu:C1006($t_refAcciones)
RELEASE MENU:C978($t_refMenuUsuarios)
RELEASE MENU:C978($t_refAcciones)

Case of 
	: ($t_refElemento="A@")
		$l_idUsuario:=Num:C11($t_refElemento)
		SELECT LIST ITEMS BY REFERENCE:C630(hlUSR_GroupsAndUsers;$l_idUsuario)
		GET LIST ITEM:C378(hlUSR_GroupsAndUsers;Selected list items:C379(hlUSR_GroupsAndUsers);$l_idUsuario;$t_nombreUsuario)
		APPEND TO LIST:C376(hlQR_authorizedUsers;$t_nombreUsuario;$l_idUsuario)
		SORT LIST:C391(hlQR_authorizedUsers)
		LIST TO BLOB:C556(hlQR_authorizedUsers;[xShell_Reports:54]xAuthorizedUsers:28)
		SELECT LIST ITEMS BY REFERENCE:C630(hlQR_authorizedUsers;$l_idUsuario)
		If ((Count list items:C380(hlQR_authorizedUsers)=0) & (Count list items:C380(hlQR_AuthorizedUsers)=0))
			[xShell_Reports:54]Public:8:=False:C215
		End if 
	: ($t_refElemento="Q@")
		$l_idUsuario:=Num:C11($t_refElemento)
		DELETE FROM LIST:C624(hlQR_authorizedUsers;$l_idUsuario)
		SORT LIST:C391(hlQR_authorizedUsers)
		LIST TO BLOB:C556(hlQR_authorizedUsers;[xShell_Reports:54]xAuthorizedUsers:28)
		SELECT LIST ITEMS BY REFERENCE:C630(hlUSR_GroupsAndUsers;0)
End case 

