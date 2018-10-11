//%attributes = {}
  // 
  // ACTfear_FEDummy
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_TEXT:C284($t_appServer)
C_TEXT:C284($t_dbServer)
C_TEXT:C284($t_authServer)
C_BLOB:C604(xblob)

$t_appServer:="Error"
$t_dbServer:="Error"
$t_authServer:="Error"

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://ar.gov.afip.dif.FEV1/"

$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 

$root:=DOM Create XML Ref:C861("FEDummy";$nameSpace)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

If (<>bACTfear_CopiarRequest)
	DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
	SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
End if 

ACTfear_CallWebService ("FEDummy";$l_idRS)
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FEDummy";"FEDummy";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

If (vtWS_ErrorString="")
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	
	_O_C_STRING:C293(16;$resRoot)
	_O_C_STRING:C293(16;$resSubElem)
	WEB SERVICE GET RESULT:C779(xblob;"XMLOut";*)
	$resRoot:=DOM Parse XML variable:C720(xblob)
	If (OK=1)
		If (<>bACTfear_CopiarResponse)
			DOM EXPORT TO VAR:C863($resRoot;$t_xml)
			SET TEXT TO PASTEBOARD:C523($t_xmlOUT+$t_xml)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FEDummyResponse/FEDummyResult/AppServer")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$t_appServer)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FEDummyResponse/FEDummyResult/DbServer")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$t_dbServer)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FEDummyResponse/FEDummyResult/AuthServer")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$t_authServer)
		DOM CLOSE XML:C722($resRoot)
		
	End if 
	EM_ErrorManager ("Clear")
	DOM CLOSE XML:C722($root)
	
	$0:="AppServer: "+$t_appServer+"\r"+"DbServer: "+$t_dbServer+"\r"+"AuthServer: "+$t_authServer
	
Else 
	$0:="Error al consumir servicio: "+ST_Qte (vtWS_ErrorString)
End if 

SET BLOB SIZE:C606(xblob;0)