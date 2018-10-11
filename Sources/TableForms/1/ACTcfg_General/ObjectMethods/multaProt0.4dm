IT_Clairvoyance (Self:C308;->at_GlosasItems;"";False:C215)
If (Self:C308->#"")
	$item:=Find in array:C230(at_GlosasItems;Self:C308->)
	If ($item#-1)
		at_GlosasItems:=$item
		vtACTcfg_SelectedItemName:=at_GlosasItems{$item}
		vlACTcfg_SelectedItemId:=al_IdsItems{$item}
		If (Form event:C388=On Data Change:K2:15)
			If (KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemId;->[xxACT_Items:179]Imputacion_Unica:24))
				CD_Dlog (0;__ ("El ítem de cargo seleccionado está marcado como imputación única. Si ya existe un cargo para el mes, no se generará el recargo. Elija otro ítem de cargo o desmarque la propiedad Ítem de imputación única del ítem de cargo seleccionado."))
			End if 
		End if 
	End if 
End if 