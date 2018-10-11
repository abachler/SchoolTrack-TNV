//%attributes = {}
  //ACT_FiltroListadoDetalladoPagos

If (USR_GetMethodAcces (Current method name:C684))
	vi_TipoInforme:=5
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;__ ("Selección de los informes y período de generación"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
	CLOSE WINDOW:C154
	If (ok=1)
		ACTpgs_GeneraListaDetCargos 
	End if 
End if 