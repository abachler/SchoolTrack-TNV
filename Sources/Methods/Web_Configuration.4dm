//%attributes = {}
  //Web_Configuration
C_BOOLEAN:C305($b_configModificada)
C_LONGINT:C283($l_idProceso)
C_POINTER:C301($y_nil)

If (Semaphore:C143("NetworkConfig"))
	CD_Dlog (0;__ ("La configuración de red está siendo modificada por otro usuario."))
Else 
	CFG_OpenConfigPanel ($y_nil;"WebSettings";0;__ ("Red"))
	$b_configModificada:=WEB_SaveSettings 
	TRACE:C157
	If ($b_configModificada)
		  // la configuración fue modificada, reiniciamos el servidor
		$l_idProceso:=IT_UThermometer (1;0;__ ("Registrando cambios en configuración de red…");-1)
		KRL_ExecuteEverywhere ("WEB_LoadSettings")  // MONO (149214) refrescamos los cambios de settings en todos los clientes
		WEB_StartWebServer2 
		IT_UThermometer (-2;$l_idProceso)
	End if 
	
	If (<>web_proxy_ftp_host#"")
		  // si se establecio un proxy lo activamos
		$err:=IT_SetProxy (1;<>web_proxy_ftp_issocks;<>web_proxy_ftp_host;Num:C11(<>web_proxy_ftp_puerto);<>web_proxy_ftp_userid)
	End if 
	
	
End if 
CLEAR SEMAPHORE:C144("NetworkConfig")
