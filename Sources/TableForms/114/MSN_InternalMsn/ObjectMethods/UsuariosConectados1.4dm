If (at_UsuariosConectados>0)
	If (ab_MiConexion{at_UsuariosConectados}=False:C215)
		GOTO OBJECT:C206(vMsg)
	End if 
	IT_SetButtonState ((Not:C34(ab_MiConexion{at_UsuariosConectados}));->bSend)
	IT_SetEnterable ((Not:C34(ab_MiConexion{at_UsuariosConectados}));0;->vMsg)
Else 
	_O_DISABLE BUTTON:C193(bSend)
	OBJECT SET ENTERABLE:C238(vMsg;False:C215)
End if 