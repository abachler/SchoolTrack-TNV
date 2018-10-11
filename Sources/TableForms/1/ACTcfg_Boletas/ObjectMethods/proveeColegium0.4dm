  //OPCION CREADA PARA PRUEBAS DE QA
If (Self:C308->=0)
	$resp:=CD_Dlog (0;"Al desmarcar esta opción el sistema enviará datos al ambiente de producción del SII."+"\r\r"+"¿Está seguro de que desea continuar?";"";"Sí";"No")
Else 
	  //$resp:=1
	$resp:=0  //20150902 RCH NO SE PODÍA MARCAR LA OPCIÓN
End if 
If ($resp=1)
	PREF_Set (0;"ACT_AMBIENTE_CERTIFICACION_SII";"0")
	LOG_RegisterEvt ("DTE: Ambiente de certificación desmarcado.")
Else 
	PREF_Set (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1")
	Self:C308->:=1
	LOG_RegisterEvt ("DTE: Ambiente de certificación marcado.")
End if 