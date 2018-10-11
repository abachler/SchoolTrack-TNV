If (vtCM_Aplicacion#String:C10(CommTrack))
	CMT_Transferencia ("CargaLibreria";->vtCM_Aplicacion)
	CMT_Transferencia ("OnLoad")
Else 
	CD_Dlog (0;__ ("La libreria de Commtrack se carga automáticamente al presionar en la configuración el botón ")+ST_Qte (__ ("Envío de datos a CommTrack activado"))+__ ("."))
End if 