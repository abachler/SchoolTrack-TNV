//%attributes = {}
  //ACTdp_OnExplorerLoad

If (Records in table:C83([ACT_Terceros:138])>0)
	$recs:=Size of array:C274(alBWR_recordNumber)
	$arrayApdo:=Get pointer:C304(atBWR_ArrayNames{7})
	READ ONLY:C145([ACT_Documentos_de_Pago:176])
	For ($i;1;$recs)
		GOTO RECORD:C242([ACT_Documentos_de_Pago:176];alBWR_recordNumber{$i})
		If ([ACT_Documentos_de_Pago:176]ID_Tercero:48#0)
			$arrayApdo->{$i}:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Documentos_de_Pago:176]ID_Tercero:48;->[ACT_Terceros:138]Nombre_Completo:9)
		End if 
	End for 
	REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
End if 