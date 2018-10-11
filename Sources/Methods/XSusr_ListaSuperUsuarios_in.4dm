//%attributes = {"executedOnServer":true}
  // XSusr_RecuperaListaUsuarios()
  // Por: Alberto Bachler: 31/07/13, 13:53:18
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($l_IdUsuario;$l_listaUsuarios;$l_IdGrupo)
C_TEXT:C284($t_contraseña;$t_contraseñaEncriptada;$t_email;$t_login;$t_TextoError;$t_usuario)


WS_InitWebServicesVariables 
$t_TextoError:=WS_CallIntranetWebService ("XSusr_ListaSuperUsuarios_out")

If ($t_textoError="")
	WEB SERVICE GET RESULT:C779($x_blob;"listaUsuarios";*)
End if 

If ((BLOB size:C605($x_blob)>0) & ($t_textoError=""))
	$l_listaUsuarios:=BLOB to list:C557($x_blob)
	SAVE LIST:C384($l_ListaUsuarios;"XS_Designers")
End if 
