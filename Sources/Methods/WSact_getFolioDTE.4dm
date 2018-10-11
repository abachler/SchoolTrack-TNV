//%attributes = {}
  //WSact_getFolioDTE

C_TEXT:C284(vtWS_ResultString;$vt_countryCode;$vt_rut;$vt_glosa)
C_LONGINT:C283($vl_idDTE;$1;$0;$vl_folio)
C_POINTER:C301($vy_folio;$vy_glosa)
$vl_idDTE:=$1
$vy_folio:=$2
$vy_glosa:=$3
$t_tipo:=$4

If ($vl_idDTE>0)
	If (($t_tipo="IEC") | ($t_tipo="IEV") | ($t_tipo="BOLETA") | ($t_tipo="GUIAS"))
		KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$vl_idDTE)
		$y_razonSocial:=->[ACT_IECV:253]id_razon_social:15
	Else 
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idDTE)
		$y_razonSocial:=->[ACT_Boletas:181]ID_RazonSocial:25
	End if 
	If (ok=1)
		  //ACTdte_GeneraArchivo ("LoadRS")
		
		  //****INICIALIZACIONES****
		vtWS_ResultString:=""
		
		$vt_countryCode:=<>gCountryCode
		$vt_rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;$y_razonSocial;->[ACT_RazonesSociales:279]RUT:3)
		
		
		WEB SERVICE SET PARAMETER:C777("countryCode";$vt_countryCode)
		WEB SERVICE SET PARAMETER:C777("rut";$vt_rut)
		WEB SERVICE SET PARAMETER:C777("id";$vl_idDTE)
		WEB SERVICE SET PARAMETER:C777("tipo";$t_tipo)
		
		
		  //****CUERPO****
		WSact_DTECallWebServiceDTE ("WSout_SendFolioDTE")
		
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"mensajeError")
			WEB SERVICE GET RESULT:C779($vt_glosa;"glosa")
			WEB SERVICE GET RESULT:C779($vl_folio;"folio";*)
		End if 
		
		Case of 
			: ((error#0) | (ok=0))
				  //CD_Dlog (0;__ ("No fue posible conectarse a Colegium."))
			: (vtWS_ResultString#"")
				  //CD_Dlog (0;vtWS_ResultString)
				$vt_glosa:=vtWS_ResultString
			: (vtWS_ResultString="")
		End case 
		$0:=$vl_folio
		
		$vy_folio->:=$vl_folio
		$vy_glosa->:=$vt_glosa
		
	Else 
		$0:=0
	End if 
Else 
	OK:=0
	$0:=0
End if 

