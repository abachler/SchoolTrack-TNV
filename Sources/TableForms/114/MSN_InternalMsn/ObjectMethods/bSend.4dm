If ((at_UsuariosConectados>0) & (vMsg#""))
	EXECUTE ON CLIENT:C651(at_UsuariosConectados{at_UsuariosConectados};"MSN_DisplayMsgonClient";USR_CurrentUser ;vMsg;<>RegisteredName)
	vMsg:=""
	GOTO OBJECT:C206(vMsg)
Else 
	BEEP:C151
	Case of 
		: ((at_UsuariosConectados=0) & (vMsg#""))
			CD_Dlog (0;__ ("Por favor seleccione un usuario e ingrese un mensaje."))
		: (at_UsuariosConectados=0)
			CD_Dlog (0;__ ("Por favor seleccione un usuario"))
		: (vMsg="")
			CD_Dlog (0;__ ("Por favor ingrese un mensaje."))
	End case 
	GOTO OBJECT:C206(vMsg)
End if 