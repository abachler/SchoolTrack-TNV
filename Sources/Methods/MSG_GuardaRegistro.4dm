//%attributes = {}
  // MSG_GuardaRegistro()
  // Por: Alberto Bachler: 13/06/13, 09:22:33
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (KRL_RegistroFueModificado (->[xShell_MensajesAplicacion:244]))
	SAVE RECORD:C53([xShell_MensajesAplicacion:244])
	MSGws_EnviaMensaje_out ([xShell_MensajesAplicacion:244]ID:5)
End if 




