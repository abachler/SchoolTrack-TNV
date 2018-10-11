Case of 
	: (Form event:C388=On Data Change:K2:15)
		C_LONGINT:C283($vl_idApdoAsignado)
		C_LONGINT:C283($vl_col;$vl_line)
		LISTBOX GET CELL POSITION:C971(lb_doc2Reemp;$vl_col;$vl_line)
		$vl_idApdoAsignado:=alACTlb_ReempTitular{$vl_line}
		$vl_idDocPago:=KRL_GetNumericFieldData (->[ACT_Documentos_en_Cartera:182]ID:1;->alACTlb_ReempIDDoc{$vl_line};->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
		$vd_fecha:=KRL_GetDateFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->$vl_idDocPago;->[ACT_Documentos_de_Pago:176]FechaPago:4)
		ACTdc_OpcionesReemplazoMasivo ("ValidaSeleccionados";->$vl_idApdoAsignado;->$vd_fecha)
		ACTdc_OpcionesReemplazoMasivo ("CalculaMonto2Reemplazar")
End case 