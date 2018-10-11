//%attributes = {}
  // 
  // ACTfear_FEParamGetPtosVenta
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_TEXT:C284($0;$t_retorno)
  //C_TEXT($proxy_ret1)
C_LONGINT:C283($proxy_ret1)  //20150803 RCH 
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
$root:=DOM Create XML Ref:C861("FEParamGetPtosVenta";$nameSpace)

C_TEXT:C284($t_token;$t_sign)
C_LONGINT:C283($l_idRS)
$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 
  //$t_CUIT:=KRL_GetTextFieldData (->[ACT_RazonesSociales]id;->$l_idRS;->[ACT_RazonesSociales]RUT)
  //If (Not(Is compiled mode))
  //$t_CUIT:="20325866102"
  //End if 

$ok:=ACTfear_ObtieneCredenciales ($l_idRS;->$t_token;->$t_sign)
If ($ok=1)
	
	$subElem:=DOM Create XML element:C865($root;"/FEParamGetPtosVenta/Auth/Token")
	DOM SET XML ELEMENT VALUE:C868($subElem;$t_token)
	
	$subElem:=DOM Create XML element:C865($root;"/FEParamGetPtosVenta/Auth/Sign")
	DOM SET XML ELEMENT VALUE:C868($subElem;$t_sign)
	
	$subElem:=DOM Create XML element:C865($root;"/FEParamGetPtosVenta/Auth/Cuit")
	DOM SET XML ELEMENT VALUE:C868($subElem;vtACT_CUIT)
	
	If (<>bACTfear_CopiarRequest)
		DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
		SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
	End if 
	
	WEB SERVICE SET PARAMETER:C777("XMLIn";$root)
	ACTfear_CallWebService ("FEParamGetPtosVenta";$l_idRS)
	  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FEParamGetPtosVenta";"FEParamGetPtosVenta";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)
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
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FEParamGetPtosVentaResponse/FEParamGetPtosVentaResult/Errors")
		If ($resSubElem#"0000000000000000")
			For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Err"))
				$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Errors/Err["+String:C10($l_indice)+"]/Msg")
				DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_error)
				APPEND TO ARRAY:C911($at_errores;$t_error)
			End for 
		End if 
		
		If (Size of array:C274($at_errores)=0)
			
			$resSubElem1:=DOM Find XML element:C864($resRoot;"/FEParamGetPtosVentaResponse/FEParamGetPtosVentaResult/ResultGet")
			If ($resSubElem1#"0000000000000000")
				
				ARRAY LONGINT:C221($al_num;0)
				ARRAY TEXT:C222($at_emTipo;0)
				ARRAY TEXT:C222($at_bloqueado;0)
				ARRAY TEXT:C222($at_baja;0)
				
				  //For ($l_indice;1;DOM Count XML elements($resSubElem1;"DocTipo"))
				For ($l_indice;1;DOM Count XML elements:C726($resSubElem1;"PtoVenta"))  //20150803 RCH. Este corresponde al punto de venta
					$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/PtoVenta["+String:C10($l_indice)+"]/Nro")
					DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret1)
					APPEND TO ARRAY:C911($al_num;$proxy_ret1)
					
					$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/PtoVenta["+String:C10($l_indice)+"]/EmisionTipo")
					DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret2)
					APPEND TO ARRAY:C911($at_emTipo;$proxy_ret2)
					
					$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/PtoVenta["+String:C10($l_indice)+"]/Bloqueado")
					DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret3)
					APPEND TO ARRAY:C911($at_bloqueado;$proxy_ret3)
					
					$resSubElem:=DOM Find XML element:C864($resSubElem1;"/ResultGet/PtoVenta["+String:C10($l_indice)+"]/FchBaja")
					DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret4)
					APPEND TO ARRAY:C911($at_baja;$proxy_ret4)
					
				End for 
				$t_retorno:="Puntos de venta:"+"\r"+AT_Arrays2Text ("\r";"-";->$al_num;->$at_emTipo;->$at_bloqueado;->$at_baja)
			End if 
		Else 
			$t_retorno:="Error: "+"\r"+AT_array2text (->$at_errores;"\r")
		End if 
		DOM CLOSE XML:C722($resRoot)
	End if 
	EM_ErrorManager ("Clear")
	DOM CLOSE XML:C722($root)
Else 
	$t_retorno:=__ ("No fue posible obtener las credenciales necesarias para consumir el servicio. Revise si su computador tiene la hora oficial e intente nuevamente.")+"\r\r"
	$t_retorno:=$t_retorno+__ ("Si el servicio de la AFIP está funcionando correctamente y su computador tiene la hora oficial y el problema se mantiene, por favor contacte al Departamento Técnico de Colegium.")
End if 

$0:=$t_retorno

SET BLOB SIZE:C606(xblob;0)