//%attributes = {}
  //SN3_ActuaDatos_Download
If (<>bXS_esServidorOficial)  //MONO 203046
	$p:=IT_UThermometer (1;0;__ ("Buscando información en SchoolNet..."))
	If (Application type:C494=4D Remote mode:K5:5)
		
		$pro_num:=Execute on server:C373("SN3_ActuaDatos_CapturaDatos";128000;"ActuaDatos Captura Datos")
		
		DELAY PROCESS:C323(Current process:C322;120)
		While (Test semaphore:C652("SN3_ActuaDatos_Captura"))
			DELAY PROCESS:C323(Current process:C322;600)
		End while 
		
	Else 
		SN3_ActuaDatos_CapturaDatos 
	End if 
	
	$p:=IT_UThermometer (-2;$p)
	$msg:="Ejecución Recepción manual de datos"
	LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
Else 
	CD_Dlog (0;__ ("No está trabajando conectado al servidor oficial, las solicitudes de actualización no serán descargadas de SchoolNet."))
End if 