//%attributes = {}
  // RINws_HistorialCambios()
  // Por: Alberto Bachler K.: 13-08-14, 15:33:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_codigoError)
C_TEXT:C284($t_codigoError;$t_errorWS;$t_json;$t_refJson;$t_refNodoError;$t_refNodoInfo;$t_uuid;$t_uuidColegio)

If (False:C215)
	C_TEXT:C284(RIN_HistorialCambios ;$1)
	C_TEXT:C284(RIN_HistorialCambios ;$2)
End if 

$t_uuid:=$1
$t_uuidColegio:=$2

WEB SERVICE SET PARAMETER:C777("uuidInforme";$t_uuid)
WEB SERVICE SET PARAMETER:C777("uuidColegio";$t_uuidColegio)


$t_errorWS:=WS_CallIntranetWebService ("RINws_HistorialCambios";True:C214)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json")
	
	C_OBJECT:C1216($ob;$ob_error;$ob_info)
	
	$ob:=OB_Create 
	$ob_error:=OB_Create 
	$ob_info:=OB_Create 
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob;->$ob_error;"error")
	OB_GET ($ob;->$ob_info;"info")
	OB_GET ($ob_error;->$l_codigoError;"codigoError")
	OB_GET ($ob_error;->$t_codigoError;"textoError")
	
	If ($l_codigoError=0)
		$y_columnaFechaHora:=OBJECT Get pointer:C1124(Object named:K67:5;"fechaHora")
		$y_columnaAutor:=OBJECT Get pointer:C1124(Object named:K67:5;"autor")
		$y_columnaComentario:=OBJECT Get pointer:C1124(Object named:K67:5;"comentariosActualizaciones")
		$y_columnaTipoEvento:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoEvento")
		OB_GET ($ob_info;$y_columnaFechaHora;"dtsCambios")
		OB_GET ($ob_info;$y_columnaAutor;"autorCambios")
		OB_GET ($ob_info;$y_columnaComentario;"comentarioCambios")
		OB_GET ($ob_info;$y_columnaTipoEvento;"tipoEvento")
	End if 
	
	
Else 
	ModernUI_Notificacion (__ ("Conexión con repositorio de informes");__ ("No fue posible establecer la conexión con el repositorio de informes a causa de un error:")+"\r\r"+$t_errorWS)
End if 