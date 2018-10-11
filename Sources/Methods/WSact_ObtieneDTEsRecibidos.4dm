//%attributes = {}
  //WSact_ObtieneDTEsRecibidos

C_TEXT:C284($1)
C_BLOB:C604($0)
C_BLOB:C604($xBlob_respuesta)
C_TEXT:C284($t_rut;$t_rutReceptor;$t_tipo;$t_fechaEmision)
C_REAL:C285($r_value;$3)
C_POINTER:C301($2)

If (Is compiled mode:C492)
	  //$t_rut:="89862200-2"
	$t_rutReceptor:="96928810-9"
	$t_rutReceptor:=$1
	$t_rutReceptor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutReceptor)
	$t_tipo:="recepcion"
	$t_fechaEmision:=""
	
	  //SET WEB SERVICE PARAMETER("contribuyente";$1)
	  //SET WEB SERVICE PARAMETER("rutEmisor";$t_rut)
	WEB SERVICE SET PARAMETER:C777("rutReceptor";$t_rutReceptor)
	WEB SERVICE SET PARAMETER:C777("operacion";$t_tipo)
	If (Count parameters:C259>=3)
		WEB SERVICE SET PARAMETER:C777("offset";$3)
	End if 
	  //SET WEB SERVICE PARAMETER("periodoEmision";$t_fechaEmision)
	
	WSact_DTECallWebService ("doConsultaDTE";True:C214)
	
	If (OK=1)
		C_TEXT:C284($t_respuesta)
		If (True:C214)
			WEB SERVICE GET RESULT:C779($xBlob_respuesta;*)
			  //$t_ref:=DOM Parse XML variable($xx_tipo)
			$t_ref:=DOM Parse XML variable:C720($xBlob_respuesta)
			
			If (Count parameters:C259>=2)  //20161019 RCH
				C_REAL:C285($r_value)
				$t_refNodo:=DOM Find XML element:C864($t_ref;"ns2:doConsultaDTEResponse/totalDTE")
				DOM GET XML ELEMENT VALUE:C731($t_refNodo;$r_value)
				If (Not:C34(Is nil pointer:C315($2)))  //20171019 RCH
					$2->:=$r_value
				End if 
			End if 
			
			DOM EXPORT TO VAR:C863($t_ref;$t_respuesta)
			DOM CLOSE XML:C722($t_ref)
		Else 
			WEB SERVICE GET RESULT:C779($t_respuesta;*)
		End if 
		If (ok=1)
			  //SET TEXT TO PASTEBOARD($t_respuesta)
		End if 
		
	End if 
Else 
	C_TEXT:C284(<>t_path2XML)
	If (<>t_path2XML="")
		<>t_path2XML:=xfGetFileName 
	End if 
	If (<>t_path2XML#"")
		DOCUMENT TO BLOB:C525(<>t_path2XML;$xBlob_respuesta)
	End if 
End if 

$0:=$xBlob_respuesta
