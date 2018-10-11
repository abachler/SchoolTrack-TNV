  //IT_Clairvoyance (Self;->atACTvd_GlosasItems;"";False)



Case of 
	: (Form event:C388=On Load:K2:1)
		
	: (Form event:C388=On After Keystroke:K2:26)
		IT_Clairvoyance (Self:C308;->atACTvd_GlosasItems;"";False:C215)
		If (vtACTpgs_SelectedItem="")
			vlACTpgs_SelectedItemId:=0
		End if 
		
		  //: ((Form event=On Losing Focus) | (Form event=On Data Change))
	: ((Form event:C388=On Data Change:K2:15))
		
		IT_clairvoyanceOnFields2 (Self:C308;->[xxACT_Items:179]Codigo_interno:48)
		If (Self:C308->#"")
			$item:=Find in array:C230(atACTvd_GlosasItems;[xxACT_Items:179]Glosa:2)
			If ($item#-1)
				atACTvd_GlosasItems:=$item
				vtACTpgs_SelectedItem:=atACTvd_GlosasItems{$item}
				vlACTpgs_SelectedItemId:=alACTvd_IdsItems{$item}
				ACTpgs_OpcionesVR ("CargaMontoMoneda";->vlACTpgs_SelectedItemId)
				POST KEY:C465(Character code:C91("+");256)
				vtACTpgs_SelectedItem:=""
				HIGHLIGHT TEXT:C210(vtACTpgs_SelectedItem;0;0)
				
			End if 
		Else 
			CD_Dlog (0;"No hay ítems con el código interno ingresado")
			vtACTpgs_SelectedItem:=""
			HIGHLIGHT TEXT:C210(vtACTpgs_SelectedItem;0;0)
		End if 
		
	: (Form event:C388=On Before Keystroke:K2:6)
		
	: (Form event:C388=On Losing Focus:K2:8)
		
		
End case 