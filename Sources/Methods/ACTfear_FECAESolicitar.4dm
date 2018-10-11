//%attributes = {}
  // 
  // proxy_FECAESolicitar
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
  //C_LONGINT($7)
C_REAL:C285($7)  //20160426 RCH
C_LONGINT:C283($8)
C_LONGINT:C283($9)
C_TEXT:C284($10)
C_REAL:C285($11)
C_REAL:C285($12)
C_REAL:C285($13)
C_REAL:C285($14)
C_REAL:C285($15)
C_REAL:C285($16)
C_TEXT:C284($17)
C_TEXT:C284($18)
C_TEXT:C284($19)
C_TEXT:C284($20)
C_REAL:C285($21)
C_LONGINT:C283($22)
C_LONGINT:C283($23)
C_LONGINT:C283($24)
C_LONGINT:C283($25)
C_TEXT:C284($26)
C_REAL:C285($27)
C_REAL:C285($28)
C_REAL:C285($29)
C_LONGINT:C283($30)
C_REAL:C285($31)
C_REAL:C285($32)
C_TEXT:C284($33)
C_TEXT:C284($34)
C_TEXT:C284($proxy_ret1)
C_LONGINT:C283($proxy_ret2)
C_LONGINT:C283($proxy_ret3)
C_TEXT:C284($proxy_ret4)
C_LONGINT:C283($proxy_ret5)
C_TEXT:C284($proxy_ret6)
C_TEXT:C284($proxy_ret7)
C_LONGINT:C283($proxy_ret8)
C_LONGINT:C283($proxy_ret9)
C_TEXT:C284($proxy_ret10)
C_TEXT:C284($proxy_ret11)
C_TEXT:C284($proxy_ret12)
C_TEXT:C284($proxy_ret13)
C_TEXT:C284($proxy_ret14)
C_LONGINT:C283($proxy_ret15)
C_TEXT:C284($proxy_ret16)
C_TEXT:C284(t_ACT_codigoAUT)
C_TEXT:C284(t_ACT_vencAUT)
C_LONGINT:C283($proxy_ret19)
C_TEXT:C284($proxy_ret20)
C_LONGINT:C283($proxy_ret21)
C_TEXT:C284($proxy_ret22)
C_BLOB:C604(xblob)
C_LONGINT:C283($l_num1;$l_num2;$l_num3;$l_num4)

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://ar.gov.afip.dif.FEV1/"
t_ACT_codigoAUT:=""
t_ACT_vencAUT:=""
$root:=DOM Create XML Ref:C861("FECAESolicitar";$nameSpace)

C_TEXT:C284($t_xml;$0;$t_token;$t_sign;$t_CUIT)
$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 

$ok:=ACTfear_ObtieneCredenciales ($l_idRS;->$t_token;->$t_sign)
If ($ok=1)
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/Auth/Token")
	DOM SET XML ELEMENT VALUE:C868($subElem;$t_token)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/Auth/Sign")
	DOM SET XML ELEMENT VALUE:C868($subElem;$t_sign)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/Auth/Cuit")
	DOM SET XML ELEMENT VALUE:C868($subElem;vtACT_CUIT)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeCabReq/CantReg")
	DOM SET XML ELEMENT VALUE:C868($subElem;$2)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeCabReq/PtoVta")
	DOM SET XML ELEMENT VALUE:C868($subElem;$3)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeCabReq/CbteTipo")
	DOM SET XML ELEMENT VALUE:C868($subElem;$4)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Concepto")
	DOM SET XML ELEMENT VALUE:C868($subElem;$5)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/DocTipo")
	DOM SET XML ELEMENT VALUE:C868($subElem;$6)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/DocNro")
	DOM SET XML ELEMENT VALUE:C868($subElem;$7)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/CbteDesde")
	DOM SET XML ELEMENT VALUE:C868($subElem;$8)
	
	$l_num1:=$8
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/CbteHasta")
	DOM SET XML ELEMENT VALUE:C868($subElem;$9)
	
	$l_num2:=$9
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/CbteFch")
	DOM SET XML ELEMENT VALUE:C868($subElem;$10)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpTotal")
	DOM SET XML ELEMENT VALUE:C868($subElem;$11)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpTotConc")
	DOM SET XML ELEMENT VALUE:C868($subElem;$12)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpNeto")
	DOM SET XML ELEMENT VALUE:C868($subElem;$13)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpOpEx")
	DOM SET XML ELEMENT VALUE:C868($subElem;$14)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpTrib")
	DOM SET XML ELEMENT VALUE:C868($subElem;$15)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpIVA")
	DOM SET XML ELEMENT VALUE:C868($subElem;$16)
	
	If ($17#"")
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/FchServDesde")
		DOM SET XML ELEMENT VALUE:C868($subElem;$17)
	End if 
	
	If ($18#"")
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/FchServHasta")
		DOM SET XML ELEMENT VALUE:C868($subElem;$18)
	End if 
	
	If ($19#"")
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/FchVtoPago")
		DOM SET XML ELEMENT VALUE:C868($subElem;$19)
	End if 
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/MonId")
	DOM SET XML ELEMENT VALUE:C868($subElem;$20)
	
	$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/MonCotiz")
	DOM SET XML ELEMENT VALUE:C868($subElem;$21)
	
	If (($22#0) | ($23#0) | ($24#0))
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/CbtesAsoc/CbteAsoc/Tipo")
		DOM SET XML ELEMENT VALUE:C868($subElem;$22)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/CbtesAsoc/CbteAsoc/PtoVta")
		DOM SET XML ELEMENT VALUE:C868($subElem;$23)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/CbtesAsoc/CbteAsoc/Nro")
		DOM SET XML ELEMENT VALUE:C868($subElem;$24)
	End if 
	
	If (($25#0) | ($26#"") | ($27#0) | ($28#0) | ($29#0))
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Tributos/Tributo/Id")
		DOM SET XML ELEMENT VALUE:C868($subElem;$25)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Tributos/Tributo/Desc")
		DOM SET XML ELEMENT VALUE:C868($subElem;$26)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Tributos/Tributo/BaseImp")
		DOM SET XML ELEMENT VALUE:C868($subElem;$27)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Tributos/Tributo/Alic")
		DOM SET XML ELEMENT VALUE:C868($subElem;$28)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Tributos/Tributo/Importe")
		DOM SET XML ELEMENT VALUE:C868($subElem;$29)
	End if 
	
	If (($30#0) | ($31#0) | ($32#0))
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Iva/AlicIva/Id")
		DOM SET XML ELEMENT VALUE:C868($subElem;$30)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Iva/AlicIva/BaseImp")
		DOM SET XML ELEMENT VALUE:C868($subElem;$31)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Iva/AlicIva/Importe")
		DOM SET XML ELEMENT VALUE:C868($subElem;$32)
	End if 
	
	If ((($33#"") & ($33#"0")) | ($34#""))
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Opcionales/Opcional/Id")
		DOM SET XML ELEMENT VALUE:C868($subElem;$33)
		
		$subElem:=DOM Create XML element:C865($root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Opcionales/Opcional/Valor")
		DOM SET XML ELEMENT VALUE:C868($subElem;$34)
	End if 
	
	If (<>bACTfear_CopiarRequest)
		DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
		SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
	End if 
	
	$b_valida:=ACTfear_ValidaXML ($root)
	
	If ($b_valida)
		
		WEB SERVICE SET PARAMETER:C777("XMLIn";$root)
		
		ACTfear_CallWebService ("FECAESolicitar";$l_idRS)
		  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FECAESolicitar";"FECAESolicitar";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)
		
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
			$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/Errors")
			If ($resSubElem#"0000000000000000")
				For ($l_indice;1;DOM Count XML elements:C726($resSubElem;"Err"))
					$resSubElem1:=DOM Find XML element:C864($resSubElem;"/Errors/Err["+String:C10($l_indice)+"]/Msg")
					DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_error)
					APPEND TO ARRAY:C911($at_errores;$t_error)
				End for 
			End if 
			
			If (Size of array:C274($at_errores)=0)
				
				ARRAY TEXT:C222($at_arrayObs;0)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeCabResp/Cuit")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret1)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeCabResp/PtoVta")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret2)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeCabResp/CbteTipo")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret3)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeCabResp/FchProceso")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret4)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeCabResp/CantReg")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret5)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeCabResp/Resultado")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret6)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeCabResp/Reproceso")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret7)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/Concepto")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret8)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/DocTipo")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret9)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/DocNro")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret10)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/CbteDesde")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret11)
				
				$l_num3:=Num:C11($proxy_ret11)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/CbteHasta")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret12)
				
				$l_num4:=Num:C11($proxy_ret12)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/CbteFch")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret13)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/Resultado")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;$proxy_ret14)
				
				$resSubElem2:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/Observaciones")
				If ($resSubElem2#"0000000000000000")
					For ($l_indice;1;DOM Count XML elements:C726($resSubElem2;"Obs"))
						$resSubElem1:=DOM Find XML element:C864($resSubElem2;"/Observaciones/Obs["+String:C10($l_indice)+"]/Msg")
						DOM GET XML ELEMENT VALUE:C731($resSubElem1;$t_error)
						APPEND TO ARRAY:C911($at_arrayObs;$t_error)
					End for 
				End if 
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/CAE")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;t_ACT_codigoAUT)
				
				$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/CAEFchVto")
				DOM GET XML ELEMENT VALUE:C731($resSubElem;t_ACT_vencAUT)
				
				If (Size of array:C274($at_arrayObs)>0)
					CD_Dlog (0;"Error en documento: "+$proxy_ret11+"."+"\r"+AT_array2text (->$at_arrayObs;"\r"))
				End if 
				
				If (Num:C11(PREF_fGet (0;"ACT_FEAR_MuestraMensajeEventos";"1"))=0)  //20160928 RCH Por defecto no se muestran los eventos.
					  //Verifica Eventos
					C_TEXT:C284($t_evento)
					ARRAY TEXT:C222($at_eventos;0)
					$resSubElem:=DOM Find XML element:C864($resRoot;"/FECAESolicitarResponse/FECAESolicitarResult/Events")
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
				End if 
				
			Else 
				  //$t_xml:="" // se comenta porque servirá para ver el error.
				CD_Dlog (0;"Error: "+"\r"+AT_array2text (->$at_errores;"\r"))
			End if 
			
			DOM CLOSE XML:C722($resRoot)
			
		End if 
		EM_ErrorManager ("Clear")
	End if 
	
	DOM CLOSE XML:C722($root)
	
	  //20150824 RCH En un colegio en AR, se asignó el CAE del folio 124 al folio 125.
	If (($l_num1#$l_num3) | ($l_num2#$l_num4) | ($l_num1=0) | ($l_num2=0) | ($l_num3=0) | ($l_num4=0))
		t_ACT_codigoAUT:=""
		t_ACT_vencAUT:=""
		  //$t_xml:="Error "+vtWS_ErrorString+"."
		$t_xml:="Error "+vtWS_ErrorString+". "+$t_xml
	End if 
	
Else 
	$t_xml:="No fue posible obtener las credenciales necesarias para consumir el servicio. Intente nuevamente."+"\r\r"
	$t_xml:=$t_xml+"Si el servicio de la AFIP está funcionando correctamente y el problema se mantiene, por favor contacte al Departamento Técnico de Colegium."
End if 

$0:=$t_xml

SET BLOB SIZE:C606(xblob;0)