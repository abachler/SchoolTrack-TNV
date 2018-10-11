//%attributes = {}
  //WS_SIGE_VerificaIngresoAsist
  // proxy_getReporteEnvioAsistencia
  // http://dido.mineduc.cl:9080/WsApiMineduc/wsdl/AsistenciaSigeSoapPort.wsdl
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------

C_TEXT:C284($rol_bd;$1;$vt_codenv;$2;$semilla;$3;$vt_cod_envio;$childName)
C_LONGINT:C283($vl_cod_resp)
C_POINTER:C301($ptr_msg;$4)

$rol_bd:=String:C10(Num:C11(Substring:C12($1;1;Length:C16($1)-1)))
$vt_codenv:=$2
$semilla:=$3
$ptr_msg:=$4

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subelem)
C_TEXT:C284($namespace)
$namespace:="http://dido.mineduc.cl/Archivos/Schemas/"
$root:=DOM Create XML Ref:C861("EntradaGetReporteEnvioAsistenciaSige";$namespace)

DOM SET XML DECLARATION:C859($root;"UTF-8")

DOM_SetElementValueAndAttr ($root;"RBD";$rol_bd;True:C214)
DOM_SetElementValueAndAttr ($root;"CodigoEnvioAsistencia";$vt_codenv;True:C214)
DOM_SetElementValueAndAttr ($root;"Semilla";$semilla;True:C214)

DOM EXPORT TO VAR:C863($root;$vt_xml)
CLEAR PASTEBOARD:C402
SET TEXT TO PASTEBOARD:C523($vt_xml)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

WEB SERVICE CALL:C778("http://w7app.mineduc.cl/WsApiMineduc/services/AsistenciaSigeSoapPort";"getReporteEnvioAsistencia";"getReporteEnvioAsistencia";"http://wwwfs.mineduc.cl/Archivos/Schemas/";Web Service manual:K48:4)

If (OK=1)
	C_BLOB:C604($blob)
	_O_C_STRING:C293(16;$resroot)
	_O_C_STRING:C293(16;$ressubelem)
	WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot;"/SalidaGetReporteEnvioAsistenciaSige/CodigoRespuestaReporteEnvioAsistencia")
	DOM GET XML ELEMENT VALUE:C731($ressubelem;$vl_cod_resp)
	
	Case of 
		: ($vl_cod_resp=1)
			$ressubelem:=DOM Find XML element:C864($resroot;"/SalidaGetReporteEnvioAsistenciaSige/CodigoRespuestaReporteEnvioAsistencia")
			DOM GET XML ELEMENT VALUE:C731($ressubelem;$vt_cod_envio)
			$ptr_msg->:=$vt_cod_envio
			
		: (($vl_cod_resp=2) | ($vl_cod_resp=3))
			
			$vt_msg:=""
			  //Listado de mensajes de error
			$xml_Parent_Ref:=DOM Get first child XML element:C723($resroot;$childName;$childValue)
			$xml_Parent_Ref2:=DOM Get next sibling XML element:C724($xml_Parent_Ref;$childName;$childValue)
			$xml_Parent_Ref3:=DOM Get first child XML element:C723($xml_Parent_Ref2;$childName;$childValue)
			$xml_Parent_Ref4:=DOM Get next sibling XML element:C724($xml_Parent_Ref3;$childName;$childValue)
			$vt_msg:=$vt_msg+"\r"+$childValue
			
			While (OK=1)
				$xml_Parent_Ref4:=DOM Get next sibling XML element:C724($xml_Parent_Ref4;$childName;$childValue)
				If (OK=1)
					$vt_msg:=$vt_msg+" "+$childValue
				End if 
			End while 
			$ptr_msg->:=$vt_msg
			
	End case 
	
	
	DOM EXPORT TO VAR:C863($resroot;$vt_xml)
	CLEAR PASTEBOARD:C402
	SET TEXT TO PASTEBOARD:C523($vt_xml)
	DOM CLOSE XML:C722($resroot)
	
End if 

DOM CLOSE XML:C722($root)
$0:=String:C10($vl_cod_resp)
