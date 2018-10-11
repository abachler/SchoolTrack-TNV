If (vtCal_EventoEnvioAsunto="")
	$r:=CD_Dlog (0;__ ("Este mensaje no tiene asunto. ¿Seguro que desea enviarlo?");"";__ ("Enviar de todas formas");__ ("Cancelar"))
	If ($r=1)
		ACCEPT:C269
	End if 
Else 
	ACCEPT:C269
End if 