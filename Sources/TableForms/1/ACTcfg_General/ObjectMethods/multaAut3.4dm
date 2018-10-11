  //$choice:=IT_PopUpMenu (->at_GlosasItems;->vtACTcfg_SelectedItemAut)
$choice:=ACTit_MuestraPopUpMenu (->at_GlosasItems;"Seleccione un ítem de cargo")  //20121105 ASM para solucionar el problema del popup.
If ($choice>0)
	at_GlosasItems:=$choice
	vtACTcfg_SelectedItemAut:=at_GlosasItems{$choice}
	vlACTcfg_SelectedItemAut:=al_IdsItems{$choice}
	If (KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemAut;->[xxACT_Items:179]Imputacion_Unica:24))
		CD_Dlog (0;__ ("El ítem de cargo seleccionado está marcado como imputación única. Si ya existe un cargo para el mes, no se generará el recargo. Elija otro ítem de cargo o desmarque la propiedad Ítem de imputación única del ítem de cargo seleccionado."))
	End if 
	
	ACTcfg_OpcionesRecargosAut ("LimpiaPrimerRecargoAlCambioItem")
	
End if 
