//%attributes = {}
  // RIN_DescargaEjemplo()
  // Por: Alberto Bachler K.: 12-08-14, 11:21:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($l_error;$l_respuesta;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_TEXT:C284($t_ejemplo_B64;$t_error;$t_errorWS;$t_json;$t_RefJson;$t_uuid;$t_version;$t_versionEstructura)

If (([xShell_Reports:54]UUID:47#"") & ([xShell_Reports:54]EnRepositorio:48))
	$t_uuid:=[xShell_Reports:54]UUID:47
	$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
	$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
	$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")
	
	WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
	WEB SERVICE SET PARAMETER:C777("version";$t_version)
	WEB SERVICE SET PARAMETER:C777("uuidColegio";<>GUUID)
	
	
	$t_errorWS:=WS_CallIntranetWebService ("RINws_DescargaEjemplo";True:C214)
	If ($t_errorWS="")
		WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
		
		C_OBJECT:C1216($ob_error)
		$ob_error:=OB_Create 
		$ob_error:=JSON Parse:C1218($t_json;Is object:K8:27)
		
		OB_GET ($ob_error;->$t_error;"textoError")
		OB_GET ($ob_error;->$l_error;"codigoError")
		
		Case of 
			: ($l_error=-2)
				ModernUI_Notificacion (__ ("Visualización de ejemplo de informe");__ ("Error: El informe no existe en el repositorio de informes."))
				
			: ($l_error=-3)
				ModernUI_Notificacion (__ ("Visualización de ejemplo de informe");__ ("Error: La referencia del informe no es única.\rPor favor póngase en contacto con el departamento de soporte de Colegium."))
				
			: ($l_error=-4)
				$l_respuesta:=ModernUI_Notificacion (__ ("Visualización de ejemplo de informe");__ ("El informe seleccionado está obsoleto en el repositorio.\r\r¿Desea visualizar el ejemplo de todas maneras?");__ ("Aceptar");__ ("Cancelar"))
				If ($l_respuesta=1)
					$l_error:=0
				End if 
				
			: ($l_error=-5)
				$l_respuesta:=ModernUI_Notificacion (__ ("Visualización de ejemplo de informe");__ ("El informe seleccionado está obsoleto en el repositorio.\r\r¿Desea visualizar el ejemplo de todas maneras?");__ ("Aceptar");__ ("Cancelar"))
		End case 
		If ($l_error=0)
			OB_GET ($ob_error;->$t_ejemplo_B64;"ejemplo")
			If ($t_ejemplo_B64#"")
				BASE64 DECODE:C896($t_ejemplo_B64;$x_blob)
				WEBarea_MuestraDocumento_blob ($x_blob;".pdf";[xShell_Reports:54]ReportName:26)
			End if 
		End if 
	End if 
	  //
Else 
	ModernUI_Notificacion (__ ("Conexión con repositorio de informes");__ ("No fue posible establecer la conexión con el repositorio de informes a causa de un error:")+"\r\r"+$t_errorWS)
End if 