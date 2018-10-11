//%attributes = {}
  // USR_GetUserName({id_usuario: &L {;tipoNombreRetorno: &L}}) -> nombreUsuario, nombreLogin o nombreUsuario (nombreLogin)
  // Por: Alberto Bachler K.: 12-03-15, 14:06:24
  //  ---------------------------------------------
  //   retorna el nombres y/o login del usuario con el ID pasado en $1, segun el modo indicado (opcional):
  //   0=  nombre
  //   1= login 
  //   2 = nombre (login)
  //  ---------------------------------------------


If ("DESCRIPCION"="")
	
End if 

C_LONGINT:C283($1;$2;$l_IdUsuario;$l_numeroSesiones;$l_tipoNombre)
C_TEXT:C284($t_nombre;$t_metodoInicio;$t_contraseña;$0)
C_DATE:C307($d_ultimaSesion)
C_BOOLEAN:C305(<>vbUSR_Use4DSecurity)


$l_tipoNombre:=0
Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$l_IdUsuario:=$1
		
	: (Count parameters:C259=2)
		$l_IdUsuario:=$1
		$l_tipoNombre:=$2
End case 

If ($l_IdUsuario=0)
	$l_IdUsuario:=USR_GetUserID 
End if 

  //JVP 20160805 ticket 165585 
  //siempre se deja el nombre de login 
$l_tipoNombre:=1
If (<>vbUSR_Use4DSecurity)
	GET USER PROPERTIES:C611($l_IdUsuario;$t_nombre;$t_metodoInicio;$t_contraseña;$l_numeroSesiones;$d_ultimaSesion)
Else 
	If ($l_IdUsuario<0)
		$hl_SuperUsers:=Load list:C383("XS_Designers")
		SELECT LIST ITEMS BY REFERENCE:C630($hl_SuperUsers;$l_IdUsuario)
		GET LIST ITEM:C378($hl_SuperUsers;Selected list items:C379($hl_SuperUsers);$l_IdUsuario;$t_NombreUsuario)
		GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_IdUsuario;"login";$t_nombreLogin)
		Case of 
			: ($l_tipoNombre=0)
				$t_nombre:=$t_NombreUsuario
			: ($l_tipoNombre=1)
				$t_nombre:=$t_nombreLogin
			: ($l_tipoNombre=2)
				$t_nombre:=$t_NombreUsuario+" ("+$t_nombreLogin+")"
		End case 
	Else 
		$el:=Find in array:C230(<>alUSR_UserIds;$l_IdUsuario)
		If ($el>0)
			READ ONLY:C145([xShell_Users:47])
			GOTO RECORD:C242([xShell_Users:47];<>alUSR_USERSRECNUMS{$el})
			Case of 
				: ($l_tipoNombre=0)
					$t_nombre:=[xShell_Users:47]Name:2
				: ($l_tipoNombre=1)
					$t_nombre:=[xShell_Users:47]login:9
				: ($l_tipoNombre=2)
					$t_nombre:=[xShell_Users:47]Name:2+" ("+[xShell_Users:47]login:9+")"
			End case 
		End if 
	End if 
End if 

$0:=$t_nombre

