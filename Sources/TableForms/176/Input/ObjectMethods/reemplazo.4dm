If (([ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55#0) | ([ACT_Documentos_de_Pago:176]id_reemplazador:63#0) | ([ACT_Documentos_de_Pago:176]id_reemplazado:62#0))
	C_LONGINT:C283($vl_recNum)
	C_BOOLEAN:C305($vb_readOnly)
	
	$vl_recNum:=Record number:C243([ACT_Documentos_de_Pago:176])
	$vb_readOnly:=Read only state:C362([ACT_Documentos_de_Pago:176])
	
	WDW_OpenPopupWindow (Self:C308;->[ACT_Documentos_de_Pago:176];"HIstorialReemplazo";2)
	DIALOG:C40([ACT_Documentos_de_Pago:176];"HIstorialReemplazo")
	CLOSE WINDOW:C154
	
	KRL_ResetPreviousRWMode (->[ACT_Documentos_de_Pago:176];$vb_readOnly)
	GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$vl_recNum)
	
End if 