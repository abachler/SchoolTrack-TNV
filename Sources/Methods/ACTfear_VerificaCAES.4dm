//%attributes = {}
  //ACTfear_VerificaCAES

  //metodo para verificar que no se haya asignado un CAE por error a otro documento. 
  //Por ahora se deja el código por si se hace necesario ejecutarlo ya que se incluyó una corrección para intentar impedir eso.

C_LONGINT:C283($l_indice)
C_TEXT:C284($t_ret1;$t_ret2;$t_ref;$resSubElem)
ARRAY LONGINT:C221($alACT_recNumBoletas;0)

READ ONLY:C145([ACT_Boletas:181])
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]AR_CAEcodigo:48#"")
ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;<)
LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$alACT_recNumBoletas;"")
For ($l_indice;1;Size of array:C274($alACT_recNumBoletas))
	READ WRITE:C146([ACT_Boletas:181])
	GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNumBoletas{$l_indice})
	If (Not:C34(Locked:C147([ACT_Boletas:181])))
		$t_ref:=DOM Parse XML variable:C720([ACT_Boletas:181]AR_RespuestaWS:50)
		If ($t_ref#"0000000000000000")
			$t_ret1:=""
			$t_ret2:=""
			$resSubElem:=DOM Find XML element:C864($t_ref;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/CbteDesde")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$t_ret1)
			$resSubElem:=DOM Find XML element:C864($t_ref;"/FECAESolicitarResponse/FECAESolicitarResult/FeDetResp/FECAEDetResponse/CbteHasta")
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$t_ret2)
			If ([ACT_Boletas:181]Numero:11#Num:C11($t_ret1))
				LOG_RegisterEvt ("CAE eliminado para documento número: "+String:C10([ACT_Boletas:181]Numero:11)+", id: "+String:C10([ACT_Boletas:181]ID:1)+". Datos eliminados: Codigo: "+[ACT_Boletas:181]AR_CAEcodigo:48+". Vencimiento: "+String:C10([ACT_Boletas:181]AR_CAEvencimiento:49)+". Respuesta: "+[ACT_Boletas:181]AR_RespuestaWS:50+".")
				
				[ACT_Boletas:181]AR_CAEcodigo:48:=""
				[ACT_Boletas:181]AR_CAEvencimiento:49:=!00-00-00!
				[ACT_Boletas:181]AR_RespuestaWS:50:=""
				SAVE RECORD:C53([ACT_Boletas:181])
			Else 
				$l_indice:=Size of array:C274($alACT_recNumBoletas)
			End if 
			KRL_UnloadReadOnly (->[ACT_Boletas:181])
			DOM CLOSE XML:C722($t_ref)
		Else 
			CD_Dlog (0;"El Documento Tributario con número: "+String:C10([ACT_Boletas:181]Numero:11)+" no puede ser modificado.")
			$l_indice:=Size of array:C274($alACT_recNumBoletas)
		End if 
	End if 
End for 