If (Form event:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	IT_SetButtonState ((($text#"") & (vlACT_id_modo_pago#0) & (vlACT_ImportadorID#0));->bCont)
End if 