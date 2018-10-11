//%attributes = {}
  //WSact_DesmarcaProcesado

C_TEXT:C284(vtWS_ResultString;$vt_countryCode;$vt_rut)
C_BLOB:C604(xBlob)
C_TEXT:C284($0)
ARRAY LONGINT:C221($alACT_idsDTEs;0)
ARRAY LONGINT:C221($alACT_idsRS;0)
ARRAY LONGINT:C221($alACT_idsDTEs2Send;0)
SET BLOB SIZE:C606(xBlob;0)

If (Records in selection:C76([ACT_Boletas:181])>0)
	$vt_countryCode:=<>gCountryCode
	
	CREATE SET:C116([ACT_Boletas:181];"setBoletas")
	DISTINCT VALUES:C339([ACT_Boletas:181]ID_RazonSocial:25;$alACT_idsRS)
	
	For ($i;1;Size of array:C274($alACT_idsRS))
		USE SET:C118("setBoletas")
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=$alACT_idsRS{$i})
		SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$alACT_idsDTEs2Send)
		$vt_rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$alACT_idsRS{$i};->[ACT_RazonesSociales:279]RUT:3)
		BLOB_Variables2Blob (->xBlob;0;->$alACT_idsDTEs2Send)
		
		WEB SERVICE SET PARAMETER:C777("countryCode";$vt_countryCode)
		WEB SERVICE SET PARAMETER:C777("rut";$vt_rut)
		WEB SERVICE SET PARAMETER:C777("xIdsDTES";xBlob)
		
		  //****CUERPO****
		WSact_DTECallWebServiceDTE ("WSout_EliminaRegistroProcesado")
		
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"mensajeError";*)  //20180514 RCH Ticket 206788
		Else 
			vtWS_ResultString:="Error de conexión."
		End if 
		$0:=vtWS_ResultString
		
	End for 
	  //****INICIALIZACIONES****
	vtWS_ResultString:=""
End if 

