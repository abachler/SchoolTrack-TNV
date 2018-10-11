//%attributes = {}
  // 
  // ACTfear_FEParamGetTiposCbte
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_TEXT:C284($0;$t_retorno)
C_LONGINT:C283($proxy_ret1)
C_TEXT:C284($proxy_ret2)
C_TEXT:C284($proxy_ret3)
C_TEXT:C284($proxy_ret4)
C_LONGINT:C283($proxy_ret5)
C_TEXT:C284($proxy_ret6)
C_LONGINT:C283($proxy_ret7)
C_TEXT:C284($proxy_ret8)
C_BLOB:C604(xblob)

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://ar.gov.afip.dif.FEV1/"

$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 

C_TEXT:C284($t_token;$t_sign)
$ok:=ACTfear_ObtieneCredenciales ($l_idRS;->$t_token;->$t_sign)

$root:=DOM Create XML Ref:C861("ar:FEParamGetTiposCbte";$nameSpace)

$subElem:=DOM Create XML element:C865($root;"/ar:FEParamGetTiposCbte/ar:Auth/ar:Token")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_token)

$subElem:=DOM Create XML element:C865($root;"/ar:FEParamGetTiposCbte/ar:Auth/ar:Sign")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_sign)

$subElem:=DOM Create XML element:C865($root;"/ar:FEParamGetTiposCbte/ar:Auth/ar:Cuit")
DOM SET XML ELEMENT VALUE:C868($subElem;vtACT_CUIT)

If (<>bACTfear_CopiarRequest)
	DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
	SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
End if 

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

ACTfear_CallWebService ("FEParamGetTiposCbte";$l_idRS)
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FEParamGetTiposCbte";"FEParamGetTiposCbte";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)
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
	$resSubElem:=DOM Find XML element:C864($resRoot;"/FEParamGetTiposCbteResponse/FEParamGetTiposCbteResult/Errors")
	If ($resSubElem#"0000000000000000")
		For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Err"))
			$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Errors/Err["+String:C10($l_indice)+"]/Msg")
			DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_error)
			APPEND TO ARRAY:C911($at_errores;$t_error)
		End for 
	End if 
	
	If (Size of array:C274($at_errores)=0)
		
		$resSubElem1:=DOM Find XML element:C864($resRoot;"/FEParamGetTiposCbteResponse/FEParamGetTiposCbteResult/ResultGet")
		If ($resSubElem1#"0000000000000000")
			
			ARRAY LONGINT:C221($al_id;0)
			ARRAY TEXT:C222($at_desc;0)
			ARRAY TEXT:C222($at_desde;0)
			ARRAY TEXT:C222($at_hasta;0)
			
			For ($l_indice;1;DOM Count XML elements:C726($resSubElem1;"CbteTipo"))
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/CbteTipo["+String:C10($l_indice)+"]/Id")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret1)
				APPEND TO ARRAY:C911($al_id;$proxy_ret1)
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/CbteTipo["+String:C10($l_indice)+"]/Desc")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret2)
				APPEND TO ARRAY:C911($at_desc;$proxy_ret2)
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/CbteTipo["+String:C10($l_indice)+"]/FchDesde")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret3)
				APPEND TO ARRAY:C911($at_desde;$proxy_ret3)
				
				$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/CbteTipo["+String:C10($l_indice)+"]/FchHasta")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret4)
				APPEND TO ARRAY:C911($at_hasta;$proxy_ret4)
				
				$t_retorno:=$t_retorno+"Código "+String:C10($proxy_ret1)+", descripción "+ST_Qte ($proxy_ret2)+"."+"\r"
				
			End for 
		End if 
		
	Else 
		$t_retorno:="Error: "+"\r"+AT_array2text (->$at_errores;"\r")
	End if 
	
	DOM CLOSE XML:C722($resRoot)
	
End if 
EM_ErrorManager ("Clear")
DOM CLOSE XML:C722($root)

$0:=$t_retorno

SET BLOB SIZE:C606(xblob;0)