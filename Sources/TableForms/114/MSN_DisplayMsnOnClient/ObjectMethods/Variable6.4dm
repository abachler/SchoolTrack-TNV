If ((AnswerTo#"") & (vToSendText#""))
	Conected:=USR_TestConnection (AnswerTo)
	EXECUTE ON CLIENT:C651(AnswerTo;"MSN_DisplayMsgOnClient";USR_CurrentUser ;vToSendText;<>RegisteredName)
	vToSendText:=""
	GOTO OBJECT:C206(vToSendText)
	CANCEL:C270
Else 
	If (vToSendText="")
		BEEP:C151
		CD_Dlog (0;__ ("Por favor ingrese un mensaje."))
		GOTO OBJECT:C206(vToSendText)
	Else 
		CD_Dlog (0;__ ("El usuario se ha desconectado. El mensaje no pudo ser enviado."))
		CANCEL:C270
	End if 
End if 