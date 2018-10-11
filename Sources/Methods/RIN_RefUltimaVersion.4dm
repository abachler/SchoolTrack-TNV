//%attributes = {}
  // RIN_RefUltimaVersion()
  // Por: Alberto Bachler K.: 17-08-14, 18:38:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($b_guardar)
C_LONGINT:C283($l_error;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_TEXT:C284($t_error;$t_errorWS;$t_json;$t_refJson;$t_uuid;$t_uuidActualizacion;$t_uuidColegio;$t_version;$t_versionEstructura)


If (False:C215)
	C_TEXT:C284(RIN_RefUltimaVersion ;$0)
	C_TEXT:C284(RIN_RefUltimaVersion ;$1)
End if 

$t_uuid:=$1
$t_uuidColegio:=<>GUUID

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")

WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
WEB SERVICE SET PARAMETER:C777("version";$t_version)
WEB SERVICE SET PARAMETER:C777("uuidColegio";$t_uuidColegio)



$t_errorWS:=WS_CallIntranetWebService ("RINws_RefUltimaVersion";True:C214)
If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
	C_OBJECT:C1216($ob_error)
	
	$ob_error:=OB_Create 
	$ob_error:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	OB_GET ($ob_error;->$t_error;"textoError")
	OB_GET ($ob_error;->$l_error;"codigoError")
	OB_GET ($ob_error;->$t_uuidActualizacion;"uuidActualizacion")
	
	Case of 
		: ($l_error=0)
			$b_guardar:=True:C214
			
		: ($l_error=-3)
			ModernUI_Notificacion (__ ("Descarga de informe desde el repositorio");$t_error)
			
		: ($l_error=-2)
			ModernUI_Notificacion (__ ("Descarga de informe desde el repositorio");$t_error)
			
		: ($l_error=-1)
			ModernUI_Notificacion (__ ("Descarga de informe desde el repositorio");$t_error)
			
		Else 
			OB_GET ($ob_error;->$t_uuidActualizacion;"uuidActualizacion")
	End case 
Else 
	ModernUI_Notificacion (__ ("Conexión con repositorio de informes");__ ("No fue posible establecer la conexión con el repositorio de informes a causa de un error:")+"\r\r"+$t_errorWS)
End if 
$0:=$t_uuidActualizacion