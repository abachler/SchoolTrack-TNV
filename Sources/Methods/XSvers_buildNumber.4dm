//%attributes = {}
  // XSvers_buildNumber()
  // Por: Alberto Bachler: 02/04/13, 05:22:43
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_plataforma;$l_version_BuildNumber;$l_version_Mayor;$l_version_Revision;$l_nuevoBuildNumber)
C_TEXT:C284($t_textoError;$t_version_completa;$t_version_Larga)
C_BOOLEAN:C305($1;$b_versionDesarrollo)
C_LONGINT:C283($2)

If (Count parameters:C259=1)
	$b_versionDesarrollo:=$1
End if 
$t_VersionCompleta:=SYS_LeeVersionEstructura ("aplicacion";->$t_version_Larga)
$t_VersionCompleta:=SYS_LeeVersionEstructura ("principal";->$l_version_Mayor)
$t_VersionCompleta:=SYS_LeeVersionEstructura ("revision";->$l_version_Revision)
$t_VersionCompleta:=SYS_LeeVersionEstructura ("build";->$l_version_BuildNumber)
$t_version_SinBuild:=String:C10($l_version_Mayor)+"."+String:C10($l_version_Revision;"00")
$t_version_SinBuild:=String:C10($l_version_Mayor)+"."+String:C10($l_version_Revision)



_O_PLATFORM PROPERTIES:C365($l_plataforma)

  //20180125 RCH Se llama directo a IN3 por problemas de conexión entre intranet 2 y pa IP 0.47
If (False:C215)
	WEB SERVICE SET PARAMETER:C777("plataforma";$l_plataforma)
	WEB SERVICE SET PARAMETER:C777("version";$t_version_SinBuild)
	WEB SERVICE SET PARAMETER:C777("build";$l_version_BuildNumber)
	WEB SERVICE SET PARAMETER:C777("versionDesarrollo";$b_versionDesarrollo)
	
	
	$t_textoError:=WS_CallIntranetWebService ("WSvers_BuildNumber")
	$l_nuevoBuildNumber:=-1
	
	If ($t_textoError="")
		WEB SERVICE GET RESULT:C779($l_nuevoBuildNumber;"resultado";*)
		If ($l_nuevoBuildNumber>=$l_version_BuildNumber)
			  //SYS_EstableceVersionEstructura ("Build";String($l_nuevoBuildNumber))
		End if 
	End if 
Else 
	C_TEXT:C284($t_json;$t_body)
	ARRAY TEXT:C222($at_httpHeaderNames;0)
	ARRAY TEXT:C222($at_httpHeaderValues;0)
	APPEND TO ARRAY:C911($at_httpHeaderNames;"content-type")
	APPEND TO ARRAY:C911($at_httpHeaderValues;"application/x-www-form-urlencoded")
	$t_body:="build="+String:C10($l_version_BuildNumber)+"&version="+$t_version_SinBuild+"&plataforma="+String:C10($l_plataforma)+"&versionDesarrollo="+String:C10($b_versionDesarrollo)
	$httpStatus_l:=Intranet3_LlamadoWS ("WSvers_BuildNumber";$t_body;->$t_json;->$at_httpHeaderNames;->$at_httpHeaderValues)  //MONO TICKET 183850
	$l_nuevoBuildNumber:=-1
	If ($httpStatus_l=200)
		C_OBJECT:C1216($ob_response)
		$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
		If ((OB Is defined:C1231($ob_response;"resultado")))
			$l_nuevoBuildNumber:=OB Get:C1224($ob_response;"resultado")
		End if 
	End if 
End if 
$0:=$l_nuevoBuildNumber
