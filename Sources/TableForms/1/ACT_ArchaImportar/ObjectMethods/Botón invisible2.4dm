$text:=AT_array2text (->atACT_ABArchivoNombre)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vImportador:=atACT_ABArchivoNombre{$choice}
	vlACT_ImportadorID:=alACT_ABArchivoID{$choice}
	
	vb_fechaPago:=False:C215
	
End if 
IT_SetButtonState (((vt_ruta#"") & (vlACT_id_modo_pago#0) & (vlACT_ImportadorID#0));->bCont)