If (Form event:C388=On Clicked:K2:4)
	vlACT_id_modo_pago:=alACT_FormasdePagoID{atACT_formas_de_pago}
	$vb_importador:=False:C215
	$vb_retorno:=ACTac_OpcionesGenerales ("BuscaExportadoArchivoTransferencia";->$vb_importador;->vlACT_id_modo_pago;->vExportador;->vlACT_Exportador)
	If ($vb_retorno)
		_O_ENABLE BUTTON:C192(bNext)
	Else 
		_O_DISABLE BUTTON:C193(bNext)
	End if 
End if 