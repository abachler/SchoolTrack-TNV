If (vtCM_Aplicacion#String:C10(CommTrack))
	CMT_Transferencia ("Guardar";->vtCM_Aplicacion)
	  //CMT_Transferencia ("GuardaLibreria";->vtCM_Aplicacion)
Else 
	CD_Dlog (0;__ ("La libreria de Commtrack se almacena automáticamente al guardar."))
End if 