//%attributes = {}
  // XSvers_GuardaRegistro()
  // Por: Alberto Bachler: 02/04/13, 05:46:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_HLversion;$l_plataforma;$l_version_BuildNumber;$l_Build4D)
C_TEXT:C284($t_build;$t_textoError;$t_usuario;$t_version_SinBuild)
C_LONGINT:C283(vl_Error)
C_TEXT:C284($t_versionBeta)  //20180817 RCH

If (False:C215)
	C_TEXT:C284(XSvers_GuardaRegistro ;$1)
	C_LONGINT:C283(XSvers_GuardaRegistro ;$2)
	C_LONGINT:C283(XSvers_GuardaRegistro ;$0)
End if 

C_LONGINT:C283(vl_Error)

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json)
C_LONGINT:C283($httpStatus_l)
C_BOOLEAN:C305($b_errorResponse)

$t_version_SinBuild:=$1
$l_version_BuildNumber:=$2

  //20180817 RCH Se agrega parámetro "beta". Se deja Trace para depurar funcionamiento en próxima generación.
$t_versionBeta:=ST_Uppercase ($3)  //para enviar siempre igual

$t_usuario:=USR_GetUserName (USR_GetUserID )
_O_PLATFORM PROPERTIES:C365($l_plataforma)
$t_version4D:=Application version:C493($l_Build4D)
$t_version4D:=Substring:C12($t_version4D;1;2)+"."+Substring:C12($t_version4D;3;1)+"."+Substring:C12($t_version4D;4;1)+"."+String:C10($l_Build4D)
$t_plataforma:=String:C10($l_plataforma)
  //MONO ticket 144984
$ob_request:=OB_Create 
OB_SET ($ob_request;->$l_version_BuildNumber;"build")
OB_SET ($ob_request;->$t_version_SinBuild;"version")
OB_SET ($ob_request;->$t_plataforma;"plataforma")
OB_SET ($ob_request;->$t_usuario;"generadapor")
OB_SET ($ob_request;->$t_version4D;"version4d")
OB_SET ($ob_request;->$t_versionBeta;"tipoversion")  //20180817 RCH

$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
$httpStatus_l:=Intranet3_LlamadoWS ("WSvers_GuardaVersion";$t_jsonRequest;->$t_json)

If ($httpStatus_l=200)
	$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob_response;->$b_errorResponse;"error")
	OB_GET ($ob_response;->$t_errormsg;"mensaje")
	OB_GET ($ob_response;->vl_error;"resultado")
	
	Case of 
		: (vl_error=-1)
			ALERT:C41("No hay registro para versión: "+$t_version_SinBuild+"."+String:C10($l_version_BuildNumber))
		: (vl_error=-2)
			ALERT:C41("La versión "+$t_version_SinBuild+"."+String:C10($l_version_BuildNumber)+" ya fue generada para esta plataforma.")
	End case 
	
Else 
	ALERT:C41("Error de conexion con Intranet")
End if 

$0:=vl_error
