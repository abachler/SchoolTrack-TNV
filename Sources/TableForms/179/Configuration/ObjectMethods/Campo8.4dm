If (Self:C308->)
	Case of 
		: ([xxACT_Items:179]ID:1=vlACTcfg_SelectedItemIdCaja)
			CD_Dlog (0;"Este ítem de cargo se utiliza en los recargos de Pagos manuales. Si se marca como de imputación única, las multas no se generarán si ya existe otra multa generada para el mismo mes.")
			
		: ([xxACT_Items:179]ID:1=vlACTcfg_SelectedItemId)
			CD_Dlog (0;"Este ítem de cargo se utiliza en los recargos de Protesto de documentos. Si se marca como de imputación única, las multas no se generarán si ya existe otra multa generada para el mismo mes.")
			
		: ([xxACT_Items:179]ID:1=vlACTcfg_SelectedItemAut)
			CD_Dlog (0;"Este ítem de cargo se utiliza en los Recargos automáticos. Si se marca como de imputación única, las multas no se generarán si ya existe otra multa generada para el mismo mes.")
			
	End case 
End if 