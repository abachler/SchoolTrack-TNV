Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		GET PICTURE FROM LIBRARY:C565(13005;vpXS_IconModule)
		vsBWR_CurrentModule:="Servicio de Mensajería Interna"
		vToSendText:=""
		SenderNameandStatus:=Sender
		vHora:=Current time:C178(*)
		vFecha:=Current date:C33(*)
		SET TIMER:C645(60)
	: (Form event:C388=On Timer:K2:25)
		XS_SetInterface 
		Connected:=USR_TestConnection (AnswerTo)
		SenderNameandStatus:=ST_Boolean2Str ((Connected=0);Sender+" (desconectado)";Sender)
		IT_SetButtonState ((Not:C34(Connected=0));->bAnswer)
		REDRAW WINDOW:C456
End case 
