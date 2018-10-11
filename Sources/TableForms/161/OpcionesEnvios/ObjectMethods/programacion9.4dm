C_LONGINT:C283($r)
C_TEXT:C284($result)
$r:=CD_Dlog (0;__ ("Se dispone a eliminar todos los datos (no los usuarios) existentes en la base de datos de SchoolNet. Esta operación no se puede cancelar ni deshacer.")+"\r\r"+__ ("¿Está seguro de querer hacer esto?");"";__ ("No");__ ("Si"))
If ($r=2)
	WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
	WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
	$p:=IT_UThermometer (1;0;"Eliminando datos en SchoolNet...")
	$err:=SN3_CallWebService ("sn3ws_eliminaciondatos_proceso.eliminaTodo")
	IT_UThermometer (-2;$p)
	If ($err="")
		WEB SERVICE GET RESULT:C779($result;"resultado";*)
		If ($result="0")
			  //se restablecen las fechas de ultimo envio por nivel
			READ WRITE:C146([xShell_Prefs:46])
			QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="ue-@")
			DELETE SELECTION:C66([xShell_Prefs:46])
			READ ONLY:C145([xShell_Prefs:46])
			
			READ WRITE:C146([xxSN3_RegistrosXEnviar:143])
			QUERY:C277([xxSN3_RegistrosXEnviar:143];[xxSN3_RegistrosXEnviar:143]accion:3=SNT_Accion_Eliminar)
			DELETE SELECTION:C66([xxSN3_RegistrosXEnviar:143])
			KRL_UnloadReadOnly (->[xxSN3_RegistrosXEnviar:143])
			
			LOG_RegisterEvt ("Eliminación de datos en SchoolNet exitosa por parte del colegio.")
			SN3_RegisterLogEntry (SN3_Log_Info;"Eliminación de datos en SchoolNet exitosa por parte del colegio.")
			CD_Dlog (0;__ ("Los datos fueron eliminados exitósamente."))
		Else 
			LOG_RegisterEvt ("Eliminación de datos en SchoolNet fallida por parte del colegio.")
			SN3_RegisterLogEntry (SN3_Log_Info;"Eliminación de datos en SchoolNet fallida por parte del colegio.")
			CD_Dlog (0;__ ("No fue posible eliminar los datos en este momento. Por favor intente más tarde."))
		End if 
	Else 
		LOG_RegisterEvt ("Eliminación de datos en SchoolNet fallida por parte del colegio.")
		SN3_RegisterLogEntry (SN3_Log_Info;"Eliminación de datos en SchoolNet fallida por parte del colegio.")
		CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
	End if 
End if 