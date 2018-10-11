//%attributes = {}
  // 
  // proxy_FEParamGetTiposTributos
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($proxy_ret1)
C_TEXT:C284($proxy_ret2)
C_TEXT:C284($proxy_ret3)
C_TEXT:C284($proxy_ret4)
C_LONGINT:C283($proxy_ret5)
C_TEXT:C284($proxy_ret6)
C_LONGINT:C283($proxy_ret7)
C_TEXT:C284($proxy_ret8)

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://ar.gov.afip.dif.FEV1/"
$root:=DOM Create XML Ref:C861("FEParamGetTiposTributos";$nameSpace)

$subElem:=DOM Create XML element:C865($root;"/FEParamGetTiposTributos/Auth/Token")
DOM SET XML ELEMENT VALUE:C868($subElem;$1)

$subElem:=DOM Create XML element:C865($root;"/FEParamGetTiposTributos/Auth/Sign")
DOM SET XML ELEMENT VALUE:C868($subElem;$2)

$subElem:=DOM Create XML element:C865($root;"/FEParamGetTiposTributos/Auth/Cuit")
DOM SET XML ELEMENT VALUE:C868($subElem;$3)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

If (<>bACTfear_CopiarRequest)
	DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
	SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
End if 

WEB SERVICE CALL:C778("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FEParamGetTiposTributos";"FEParamGetTiposTributos";"http://ar.gov.afip.dif.FEV1/";Web Service manual:K48:4)

If (OK=1)
	C_BLOB:C604($blob)
	_O_C_STRING:C293(16;$resRoot)
	_O_C_STRING:C293(16;$resSubElem)
	WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
	$resRoot:=DOM Parse XML variable:C720($blob)
	
	If (<>bACTfear_CopiarResponse)
		DOM EXPORT TO VAR:C863($resRoot;$t_xml)
		SET TEXT TO PASTEBOARD:C523($t_xmlOUT+$t_xml)
	End if 
	
	  //Verifica Errores
	C_TEXT:C284($t_error)
	ARRAY TEXT:C222($at_errores;0)
	$resSubElem:=DOM Find XML element:C864($resRoot;"/FEParamGetTiposTributosResponse/FEParamGetTiposTributosResult/Errors")
	If ($resSubElem#"0000000000000000")
		For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Err"))
			$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Errors/Err["+String:C10($l_indice)+"]/Msg")
			DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_error)
			APPEND TO ARRAY:C911($at_errores;$t_error)
		End for 
	End if 
	
	ARRAY TEXT:C222($at_id;0)
	ARRAY TEXT:C222($at_descripcion;0)
	ARRAY TEXT:C222($at_desde;0)
	ARRAY TEXT:C222($at_hasta;0)
	
	If (Size of array:C274($at_errores)=0)
		
		$resSubElem1:=DOM Find XML element:C864($resRoot;"/FEParamGetTiposTributosResponse/FEParamGetTiposTributosResult/ResultGet")
		If ($resSubElem1#"0000000000000000")
			For ($l_indice;1;DOM Count XML elements:C726($resSubElem1;"TributoTipo"))
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/TributoTipo["+String:C10($l_indice)+"]/Id")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret1)
				APPEND TO ARRAY:C911($at_id;$proxy_ret1)
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/TributoTipo["+String:C10($l_indice)+"]/Desc")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret2)
				APPEND TO ARRAY:C911($at_descripcion;$proxy_ret2)
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/TributoTipo["+String:C10($l_indice)+"]/FchDesde")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret3)
				APPEND TO ARRAY:C911($at_desde;$proxy_ret3)
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/TributoTipo["+String:C10($l_indice)+"]/FchHasta")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret4)
				APPEND TO ARRAY:C911($at_hasta;$proxy_ret4)
				
			End for 
		End if 
		
		  //Verifica Eventos
		C_TEXT:C284($t_evento)
		ARRAY TEXT:C222($at_eventos;0)
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FEParamGetTiposTributosResponse/FEParamGetTiposTributosResult/Events")
		If ($resSubElem#"0000000000000000")
			For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Evt"))
				$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Events/Evt["+String:C10($l_indice)+"]/Msg")
				DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_evento)
				APPEND TO ARRAY:C911($at_eventos;$t_evento)
			End for 
		End if 
		If (Size of array:C274($at_eventos)>0)
			CD_Dlog (0;"Error: "+"\r"+AT_array2text (->$at_eventos;"\r"))
		End if 
	Else 
		CD_Dlog (0;"Error: "+"\r"+AT_array2text (->$at_errores;"\r"))
	End if 
	
	DOM CLOSE XML:C722($resRoot)
	
End if 

DOM CLOSE XML:C722($root)

