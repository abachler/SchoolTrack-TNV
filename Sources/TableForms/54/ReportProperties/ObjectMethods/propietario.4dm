  // [xShell_Reports].EnvioRepositorio.institucion()
  // Por: Alberto Bachler K.: 13-08-14, 11:30:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------


$t_refMenuUsuarios:=Create menu:C408
For ($i_elemento;1;Count list items:C380(hlUSR_GroupsAndUsers))
	GET LIST ITEM:C378(hlUSR_GroupsAndUsers;$i_elemento;$l_idUsuario;$t_nombreUsuario)
	If (Find in list:C952(hlQR_authorizedUsers;$t_nombreUsuario;0)=0)
		APPEND MENU ITEM:C411($t_refMenuUsuarios;$t_nombreUsuario)
		SET MENU ITEM PARAMETER:C1004($t_refMenuUsuarios;-1;String:C10($l_idUsuario))
		If ([xShell_Reports:54]Propietary:9=$l_idUsuario)
			SET MENU ITEM MARK:C208($t_refMenuUsuarios;-1;Char:C90(18))
		End if 
	End if 
End for 

$t_refElemento:=Dynamic pop up menu:C1006($t_refMenuUsuarios;String:C10([xShell_Reports:54]Propietary:9))
If ($t_refElemento#"")
	[xShell_Reports:54]Propietary:9:=Num:C11($t_refElemento)
End if 
$t_nombreUsuario:=USR_GetUserName ([xShell_Reports:54]Propietary:9;1)+(" "*5)
IT_PropiedadesBotonPopup ("propietario";$t_nombreUsuario;160)
