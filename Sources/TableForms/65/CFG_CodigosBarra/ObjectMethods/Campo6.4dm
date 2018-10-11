  // [xxBBL_Preferencias].CFG_CodigosBarra.Campo3()
  // Por: Alberto Bachler: 06/09/13, 17:46:36
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (([xxBBL_Preferencias:65]Lector_BarCodeConPrefijo:35=False:C215) & ([xxBBL_Preferencias:65]Registro_BarCodeConPrefijo:32=False:C215))
	$t_mensaje:=__ ("Si no utiliza prefijos para la generación de códigos de barra para lectores y registros podría MediaTrack no podrá distinguir entre ambos.")+"\r"
	$t_mensaje:=$t_mensaje+__ ("Si se presenta esa situación al leer el codigo de barra en la consola de circulación deberá resolver esa ambigüedad.")+"\r\r"
	$t_mensaje:=$t_mensaje+__ ("¿Está seguro que desea generar todos los códigos de barra sin prefijo?")
	OK:=CD_Dlog (0;$t_mensaje;"";__ ("Utilizar prefijos");__ ("Sin prefijos"))
	If (OK=1)
		[xxBBL_Preferencias:65]Lector_BarCodeConPrefijo:35:=Old:C35([xxBBL_Preferencias:65]Lector_BarCodeConPrefijo:35)
		SAVE RECORD:C53([xxBBL_Preferencias:65])
	End if 
Else 
	SAVE RECORD:C53([xxBBL_Preferencias:65])
End if 



