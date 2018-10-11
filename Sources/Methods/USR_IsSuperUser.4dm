//%attributes = {}
  //USR_IsSuperUser
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_contraseña)
_O_C_INTEGER:C282($i_elemento)
C_LONGINT:C283($hl_SuperUsers;$l_IdGrupo;$l_idUsuario)
C_TEXT:C284($t_contraseña;$t_contraseña_crypt;$t_login;$t_NombreUsuario)

If (False:C215)
	C_BOOLEAN:C305(USR_IsSuperUser ;$0)
	C_TEXT:C284(USR_IsSuperUser ;$1)
	C_TEXT:C284(USR_IsSuperUser ;$2)
End if 


If (Count parameters:C259=2)
	$vs_Name:=$1
	$vs_password:=$2
Else 
	$vs_Name:=$1
	$vs_password:=""
End if 

$hl_SuperUsers:=Load list:C383("XS_Designers")
For ($i_elemento;1;Count list items:C380($hl_SuperUsers))
	GET LIST ITEM:C378($hl_SuperUsers;$i_elemento;$l_idUsuario;$t_NombreUsuario)
	GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_idUsuario;"login";$t_login)
	If ($t_login=$vs_Name)
		If ($vs_password="")
			<>lUSR_CurrentUserID:=Num:C11($l_idUsuario)
			$i_elemento:=Count list items:C380($hl_SuperUsers)
			$0:=True:C214
		Else 
			GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_idUsuario;"contraseña";$t_contraseña)
			If ($t_contraseña=$vs_password)
				GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_IdUsuario;"email";$t_email)
				GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_IdUsuario;"idGrupo";$l_IdGrupo)
				<>tUSR_CurrentUser:=$t_NombreUsuario
				<>lUSR_CurrentUserID:=Num:C11($l_idUsuario)
				<>tUSR_CurrentUserEmail:=$t_email
				<>lUSR_IdGrupoSuperUsuarios:=$l_IdGrupo
				$i_elemento:=Count list items:C380($hl_SuperUsers)
				$0:=True:C214
			End if 
		End if 
	End if 
End for 
