//%attributes = {}
  //SERwa_InfoSchoolTrack

C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)
C_LONGINT:C283($l_idApp)
C_TEXT:C284($t_autenticacion)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	C_TEXT:C284($t_versionBD;$t_versionApp;$t_dts;$t_version)
	C_LONGINT:C283($l_build)
	C_OBJECT:C1216($ob_raiz;$ob_app;$ob_ambiente)
	
	  //$t_version:="1.0"  //version del servicio
	$t_version:="1.1"  //20180717 RCH Se agrega año actual
	$t_versionBD:=SYS_LeeVersionBaseDeDatos   //version de la base de datos
	$t_versionApp:=SYS_LeeVersionEstructura ("build";->$l_build)  //version de la aplicacion
	$t_dts:=DTS_MakeFromDateTime   //fecha y hora del computador
	
	If (<>gYear=0)
		READ ONLY:C145([xxSTR_Constants:1])
		ALL RECORDS:C47([xxSTR_Constants:1])
		FIRST RECORD:C50([xxSTR_Constants:1])
		<>gYear:=[xxSTR_Constants:1]Año:8
	End if 
	
	OB SET:C1220($ob_ambiente;"version";$t_version;"dts";$t_dts)
	OB SET:C1220($ob_app;"versionbase";$t_versionBD;"versionapp";$t_versionApp;"build";$l_build;"currentyear";<>gYear)
	
	OB SET:C1220($ob_raiz;"ambiente";$ob_ambiente)
	OB SET:C1220($ob_raiz;"app";$ob_app)
	
	$0:=JSON Stringify:C1217($ob_raiz)
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 