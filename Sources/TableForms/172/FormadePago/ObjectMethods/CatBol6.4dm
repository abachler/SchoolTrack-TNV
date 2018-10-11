Case of 
	: ((Form event:C388=On Getting Focus:K2:7) | (Form event:C388=On After Keystroke:K2:26))
		IT_Clairvoyance (Self:C308;->atACT_Categorias;"Categorías")
		
	: (Form event:C388=On Losing Focus:K2:8)
		$pos:=Find in array:C230(atACT_Categorias;Self:C308->)
		If ($pos#-1)
			[ACT_Terceros:138]id_CatDocTrib:55:=alACT_IDsCats{$pos}
		End if 
		
End case 