//%attributes = {}
  // Licencia_HayConexionDisponible()
  // Por: Alberto Bachler K.: 29-08-14, 12:19:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_LONGINT:C283($l_maximoUsuario;$l_usuariosActuales)
C_TEXT:C284($t_nombreProducto)


If (False:C215)
	C_BOOLEAN:C305(LICENCIA_HayConexionDisponible ;$0)
End if 

If (Application type:C494=4D Remote mode:K5:5)
	If (<>lUSR_CurrentUserID<0)
		$0:=True:C214
	Else 
		$t_nombreProducto:="MAIN"
		$l_maximoUsuario:=KRL_GetNumericFieldData (->[xShell_ApplicationData:45]ProductName:16;->$t_nombreProducto;->[xShell_ApplicationData:45]Licenced_Users:11)
		$l_usuariosActuales:=LICENCIA_ConexionesActuales 
		If ($l_usuariosActuales<$l_maximoUsuario)
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
	End if 
Else 
	$0:=True:C214
End if 