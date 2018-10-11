//%attributes = {}
  // 
  // ACTfear_FECompUltimoAutorizado
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_TEXT:C284($0;$t_retorno)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($proxy_ret3)
C_LONGINT:C283($proxy_ret4)
C_LONGINT:C283($proxy_ret5)
C_BLOB:C604(xblob)

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://ar.gov.afip.dif.FEV1/"
$root:=DOM Create XML Ref:C861("FECompUltimoAutorizado";$nameSpace)

C_LONGINT:C283($l_idRS)
C_TEXT:C284($t_token;$t_sign)
$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 

$ok:=ACTfear_ObtieneCredenciales ($l_idRS;->$t_token;->$t_sign)

$subElem:=DOM Create XML element:C865($root;"/FECompUltimoAutorizado/Auth/Token")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_token)

$subElem:=DOM Create XML element:C865($root;"/FECompUltimoAutorizado/Auth/Sign")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_sign)

$subElem:=DOM Create XML element:C865($root;"/FECompUltimoAutorizado/Auth/Cuit")
DOM SET XML ELEMENT VALUE:C868($subElem;vtACT_CUIT)

$subElem:=DOM Create XML element:C865($root;"/FECompUltimoAutorizado/PtoVta")
DOM SET XML ELEMENT VALUE:C868($subElem;$2)

$subElem:=DOM Create XML element:C865($root;"/FECompUltimoAutorizado/CbteTipo")
DOM SET XML ELEMENT VALUE:C868($subElem;$3)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

If (<>bACTfear_CopiarRequest)
	DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
	SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
End if 

ACTfear_CallWebService ("FECompUltimoAutorizado";$l_idRS)
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FECompUltimoAutorizado";"FECompUltimoAutorizado";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

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
	
	  //Verifica Errores
	C_TEXT:C284($t_error)
	ARRAY TEXT:C222($at_errores;0)
	$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompUltimoAutorizadoResponse/FECompUltimoAutorizadoResult/Errors")
	If ($resSubElem#"0000000000000000")
		For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Err"))
			$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Errors/Err["+String:C10($l_indice)+"]/Msg")
			DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_error)
			APPEND TO ARRAY:C911($at_errores;$t_error)
		End for 
	End if 
	
	If (Size of array:C274($at_errores)=0)
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompUltimoAutorizadoResponse/FECompUltimoAutorizadoResult/PtoVta")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret3)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompUltimoAutorizadoResponse/FECompUltimoAutorizadoResult/CbteTipo")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret4)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompUltimoAutorizadoResponse/FECompUltimoAutorizadoResult/CbteNro")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret5)
		
		$t_retorno:="El último comprobante emitido para CUIT: "+vtACT_CUIT+", punto de venta: "+String:C10($2)+", tipo de comprobante: "+String:C10($3)+" es: "+String:C10($proxy_ret5)+"."
		
		  //Verifica Eventos
		C_TEXT:C284($t_evento)
		ARRAY TEXT:C222($at_eventos;0)
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompUltimoAutorizadoResponse/FECompUltimoAutorizadoResult/Events")
		If ($resSubElem#"0000000000000000")
			For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Evt"))
				$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Events/Evt["+String:C10($l_indice)+"]/Msg")
				DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_evento)
				APPEND TO ARRAY:C911($at_eventos;$t_evento)
			End for 
		End if 
		If (Size of array:C274($at_eventos)>0)
			$t_retorno:=$t_retorno+"\r"+"Eventos: "+"\r"+AT_array2text (->$at_eventos;"\r")+"\r"
		End if 
	Else 
		$t_retorno:="Error al obtener el último comprobante para CUIT: "+vtACT_CUIT+", punto de venta: "+String:C10($2)+", tipo de documento: "+String:C10($3)+". Error: "+"\r"+AT_array2text (->$at_errores;"\r")
	End if 
	
	DOM CLOSE XML:C722($resRoot)
	
End if 
EM_ErrorManager ("Clear")
DOM CLOSE XML:C722($root)

$0:=$t_retorno

SET BLOB SIZE:C606(xblob;0)