//%attributes = {}
  // 
  // ACTfear_FECompConsultar
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_OBJECT:C1216($0;$ob_respuesta)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($proxy_ret3)
C_TEXT:C284($proxy_ret4)
C_TEXT:C284($proxy_ret5)
C_BLOB:C604(xblob)

C_LONGINT:C283($l_error)
C_TEXT:C284($t_error)

C_TEXT:C284($t_cae)
C_DATE:C307($d_vencimiento)
C_TEXT:C284($root;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://ar.gov.afip.dif.FEV1/"
$root:=DOM Create XML Ref:C861("FECompConsultar";$nameSpace)

C_LONGINT:C283($l_idRS)
C_TEXT:C284($t_token;$t_sign)
$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 

$ok:=ACTfear_ObtieneCredenciales ($l_idRS;->$t_token;->$t_sign)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/Auth/Token")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_token)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/Auth/Sign")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_sign)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/Auth/Cuit")
DOM SET XML ELEMENT VALUE:C868($subElem;vtACT_CUIT)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/FeCompConsReq/CbteTipo")
DOM SET XML ELEMENT VALUE:C868($subElem;$2)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/FeCompConsReq/CbteNro")
DOM SET XML ELEMENT VALUE:C868($subElem;$3)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/FeCompConsReq/PtoVta")
DOM SET XML ELEMENT VALUE:C868($subElem;$4)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

If (<>bACTfear_CopiarRequest)
	DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
	SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
End if 

ACTfear_CallWebService ("FECompConsultar";$l_idRS)
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FECompConsultar";"FECompConsultar";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)
If (vtWS_ErrorString="")
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	
	C_TEXT:C284($resRoot;$resSubElem)
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
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/Errors")
		If ($resSubElem#"0000000000000000")
			For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Err"))
				$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Errors/Err["+String:C10($l_indice)+"]/Msg")
				DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_error)
				APPEND TO ARRAY:C911($at_errores;$t_error)
			End for 
		End if 
		
		If (Size of array:C274($at_errores)=0)
			$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Resultado")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret3)
			
			$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CodAutorizacion")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret4)
			
			$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/FchVto")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret5)
			
			
			  //Verifica Eventos
			C_TEXT:C284($t_evento)
			ARRAY TEXT:C222($at_eventos;0)
			$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/Events")
			If ($resSubElem#"0000000000000000")
				For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Evt"))
					$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Events/Evt["+String:C10($l_indice)+"]/Msg")
					DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_evento)
					APPEND TO ARRAY:C911($at_eventos;$t_evento)
				End for 
			End if 
			
			DOM EXPORT TO VAR:C863($resRoot;$t_xml)
			LOG_RegisterEvt ("Verificación de CAE. Para la razón social id: "+String:C10($l_idRS)+", tipo de documento: "+String:C10($2)+", número: "+String:C10($3)+", punto de venta: "+String:C10($4)+". Eventos: "+AT_array2text (->$at_eventos;", ")+". Respuesta: "+$t_xml+".")
			
			
			If ($proxy_ret3="A")
				$l_error:=0
				$t_error:=""
				$t_cae:=$proxy_ret4
				$d_vencimiento:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($proxy_ret5;7;2));Num:C11(Substring:C12($proxy_ret5;5;2));Num:C11(Substring:C12($proxy_ret5;1;4)))
			Else 
				$l_error:=1
				$t_error:="Documento rechazado"
			End if 
			
		Else 
			LOG_RegisterEvt ("Verificación de CAE. Error al intentar actualizar CAE. CUIT: "+vtACT_CUIT+", tipo de documento: "+String:C10($2)+", número: "+String:C10($3)+", punto de venta: "+String:C10($4)+". Error: "+<>cr+AT_array2text (->$at_errores;<>cr))
			$l_error:=2
			$t_error:="Error al actualizar CAE. Error: "+AT_array2text (->$at_errores;", ")+". Detalles en registro de actividades."
		End if 
		DOM CLOSE XML:C722($resRoot)
	Else 
		$l_error:=5
		$t_error:="El XML no pudo ser procesado."
		
	End if 
	EM_ErrorManager ("Clear")
	DOM CLOSE XML:C722($root)
Else 
	$l_error:=4
	$t_error:="Error al consumir servicio. Número de error: "+vtWS_ErrorNum+", texto error: "+vtWS_ErrorString+"."
End if 

C_OBJECT:C1216($ob_error;$ob_datos)
OB SET:C1220($ob_error;"codigo";$l_error)
OB SET:C1220($ob_error;"descripcion";$t_error)
OB SET:C1220($ob_datos;"cae";$t_cae)
OB SET:C1220($ob_datos;"fecha";DTS_MakeFromDateTime ($d_vencimiento))
OB SET:C1220($ob_respuesta;"error";$ob_error)
OB SET:C1220($ob_respuesta;"datos";$ob_datos)

SET BLOB SIZE:C606(xblob;0)

$0:=$ob_respuesta