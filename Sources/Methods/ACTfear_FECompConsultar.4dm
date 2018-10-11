//%attributes = {}
  // 
  // proxy_FECompConsultar
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_LONGINT:C283($l_idRS;$l_cbteTipo;$l_cbteNro;$l_ptoVenta)
C_TEXT:C284($t_xml;$0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($proxy_ret1)
C_LONGINT:C283($proxy_ret2)
C_TEXT:C284($proxy_ret3)
C_TEXT:C284($proxy_ret4)
C_TEXT:C284($proxy_ret5)
C_TEXT:C284($proxy_ret6)
C_REAL:C285($proxy_ret7)
C_REAL:C285($proxy_ret8)
C_REAL:C285($proxy_ret9)
C_REAL:C285($proxy_ret10)
C_REAL:C285($proxy_ret11)
C_REAL:C285($proxy_ret12)
C_TEXT:C284($proxy_ret13)
C_TEXT:C284($proxy_ret14)
C_TEXT:C284($proxy_ret15)
C_TEXT:C284($proxy_ret16)
C_REAL:C285($proxy_ret17)
C_LONGINT:C283($proxy_ret18)
C_LONGINT:C283($proxy_ret19)
C_TEXT:C284($proxy_ret20)
C_TEXT:C284($proxy_ret21)
C_TEXT:C284($proxy_ret22)
C_REAL:C285($proxy_ret23)
C_REAL:C285($proxy_ret24)
C_REAL:C285($proxy_ret25)
C_LONGINT:C283($proxy_ret26)
C_REAL:C285($proxy_ret27)
C_REAL:C285($proxy_ret28)
C_TEXT:C284($proxy_ret29)
C_TEXT:C284($proxy_ret30)
C_TEXT:C284($proxy_ret31)
C_TEXT:C284(t_ACT_codigoAUT)
C_TEXT:C284($proxy_ret33)
C_TEXT:C284(T_ACT_vencAUT)
C_TEXT:C284($proxy_ret35)
C_LONGINT:C283($proxy_ret36)
C_TEXT:C284($proxy_ret37)
C_LONGINT:C283($proxy_ret38)
C_LONGINT:C283($proxy_ret39)
C_LONGINT:C283($proxy_ret40)
C_TEXT:C284($proxy_ret41)
C_LONGINT:C283($proxy_ret42)
C_TEXT:C284($proxy_ret43)
C_TEXT:C284(t_ACT_codigoAUT)
C_BLOB:C604(xblob)

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://ar.gov.afip.dif.FEV1/"

t_ACT_codigoAUT:=""
T_ACT_vencAUT:=""

$root:=DOM Create XML Ref:C861("FECompConsultar";$nameSpace)

$l_idRS:=$1
$l_cbteTipo:=$2
$l_cbteNro:=$3
$l_ptoVenta:=$4
If ($l_idRS=0)
	$l_idRS:=-1
End if 

C_TEXT:C284($t_token;$t_sign)
$ok:=ACTfear_ObtieneCredenciales ($l_idRS;->$t_token;->$t_sign)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/Auth/Token")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_token)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/Auth/Sign")
DOM SET XML ELEMENT VALUE:C868($subElem;$t_sign)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/Auth/Cuit")
DOM SET XML ELEMENT VALUE:C868($subElem;vtACT_CUIT)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/FeCompConsReq/CbteTipo")
DOM SET XML ELEMENT VALUE:C868($subElem;$l_cbteTipo)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/FeCompConsReq/CbteNro")
DOM SET XML ELEMENT VALUE:C868($subElem;$l_cbteNro)

$subElem:=DOM Create XML element:C865($root;"/FECompConsultar/FeCompConsReq/PtoVta")
DOM SET XML ELEMENT VALUE:C868($subElem;$l_ptoVenta)

If (<>bACTfear_CopiarRequest)
	DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
	SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
End if 

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

ACTfear_CallWebService ("FECompConsultar";$l_idRS)
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FECompConsultar";"FECompConsultar";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

_O_C_STRING:C293(16;$resRoot)
_O_C_STRING:C293(16;$resSubElem)
WEB SERVICE GET RESULT:C779(xblob;"XMLOut";*)
$resRoot:=DOM Parse XML variable:C720(xblob)
If (OK=1)
	DOM EXPORT TO VAR:C863($resRoot;$t_xml)
	If (<>bACTfear_CopiarResponse)
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
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Concepto")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret1)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/DocTipo")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret2)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/DocNro")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret3)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CbteDesde")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret4)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CbteHasta")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret5)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CbteFch")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret6)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/ImpTotal")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret7)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/ImpTotConc")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret8)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/ImpNeto")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret9)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/ImpOpEx")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret10)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/ImpTrib")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret11)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/ImpIVA")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret12)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/FchServDesde")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret13)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/FchServHasta")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret14)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/FchVtoPago")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret15)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/MonId")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret16)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/MonCotiz")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret17)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CbtesAsoc/CbteAsoc/Tipo")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret18)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CbtesAsoc/CbteAsoc/PtoVta")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret19)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CbtesAsoc/CbteAsoc/Nro")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret20)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Tributos/Tributo/Id")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret21)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Tributos/Tributo/Desc")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret22)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Tributos/Tributo/BaseImp")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret23)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Tributos/Tributo/Alic")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret24)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Tributos/Tributo/Importe")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret25)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Iva/AlicIva/Id")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret26)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Iva/AlicIva/BaseImp")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret27)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Iva/AlicIva/Importe")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret28)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Opcionales/Opcional/Id")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret29)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Opcionales/Opcional/Valor")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret30)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Resultado")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret31)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CodAutorizacion")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;t_ACT_codigoAUT)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/EmisionTipo")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret33)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/FchVto")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;T_ACT_vencAUT)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/FchProceso")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret35)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Observaciones/Obs/Code")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret36)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/Observaciones/Obs/Msg")
		If ($resSubElem#"0000000000000000")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret37)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/PtoVta")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret38)
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/FECompConsultarResponse/FECompConsultarResult/ResultGet/CbteTipo")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret39)
		
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
		If (Size of array:C274($at_eventos)>0)
			CD_Dlog (0;"Error: "+"\r"+AT_array2text (->$at_eventos;"\r"))
		End if 
	Else 
		  //$t_xml:="" // se comenta porque servirá para ver el error.
		CD_Dlog (0;"Error: "+"\r"+AT_array2text (->$at_errores;"\r"))
	End if 
	
	DOM CLOSE XML:C722($resRoot)
	
End if 
EM_ErrorManager ("Clear")
DOM CLOSE XML:C722($root)

$0:=$t_xml

SET BLOB SIZE:C606(xblob;0)