C_TEXT:C284($t_DateStamp;$t_MacAddress;$t_resultado;$t_wsError;$t_version)

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json)
C_LONGINT:C283($httpStatus_l)
C_BOOLEAN:C305($b_errorResponse)

ARRAY TEXT:C222($at_direccionMAC;0)
$t_version:=SYS_LeeVersionEstructura 
$t_MacAddress:=SYS_GetServerMAC (->$at_direccionMAC)
$t_DateStamp:=DTS_MakeFromDateTime (Current date:C33;Current time:C178)


$ob_request:=OB_Create 
OB_SET ($ob_request;-><>GROLBD;"rolbd")
OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
OB_SET ($ob_request;->$t_MacAddress;"MacAddressServidor")
OB_SET ($ob_request;->$t_version;"VersionSchoolTrack")
OB_SET ($ob_request;->$t_DateStamp;"DateStamp")
OB_SET ($ob_request;->vt_nombreUsuario;"NombreUsuario")

$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
$httpStatus_l:=Intranet3_LlamadoWS ("WSset_RegistroServidor";$t_jsonRequest;->$t_json)

If ($httpStatus_l=200)
	
	$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	OB_GET ($ob_response;->$b_errorResponse;"error")
	OB_GET ($ob_response;->$t_errormsg;"mensaje")
	OB_GET ($ob_response;->$t_resultado;"resultado")
	
	If (Not:C34($b_errorResponse))
		If ($t_resultado=$t_MacAddress)
			LOG_RegisterEvt ("Registro del servidor MacAddress "+$t_MacAddress)
			ACCEPT:C269
		End if 
	Else 
		FORM GOTO PAGE:C247(2)
	End if 
	
Else 
	FORM GOTO PAGE:C247(2)
End if 
