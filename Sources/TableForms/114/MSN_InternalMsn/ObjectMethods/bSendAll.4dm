If (vMsg#"")
	For ($i;1;Size of array:C274(at_UsuariosConectados))
		If (ab_MiConexion{$i}=False:C215)
			EXECUTE ON CLIENT:C651(at_UsuariosConectados{$i};"MSN_DisplayMsgonClient";USR_CurrentUser ;vMsg;<>RegisteredName)
		End if 
	End for 
	vMsg:=""
Else 
	CD_Dlog (0;__ ("Por favor ingrese el mensaje a enviar."))
End if 
GOTO OBJECT:C206(vMsg)