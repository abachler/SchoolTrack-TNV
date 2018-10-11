//%attributes = {}


  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 06/10/15, 17:03:15
  // ----------------------------------------------------
  // Método: STWA2_OWC_licencia_no_http
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$ipAddressServer;$url;$vt_direccion)
C_OBJECT:C1216($ob_raiz)
$ipAddressServer:=$2
$url:=$1
If ($url="/stwa/licencia")  //para poder redirigir el login en caso de acceso no http
	
	  // Modificado por: Alexis Bustamante (10-06-2017)
	  //TICKET 179869
	
	  //$jsonT:=JSON New 
	  //$node:=JSON Append text ($jsonT;"redireccion";"https://"+$ipAddressServer+"/stwa")
	  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	$vt_direccion:="https://"+$ipAddressServer+"/stwa"
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->$vt_direccion;"redireccion")
	$json:=OB_Object2Json ($ob_raiz)
	TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
	WEB SEND RAW DATA:C815($blob;*)
Else 
	$referer:=WEB_GetHTTPHeaderField ("Referer")
	$referer:=Substring:C12($referer;8)
	WEB SEND HTTP REDIRECT:C659("http://"+$referer+"stwa")
End if 