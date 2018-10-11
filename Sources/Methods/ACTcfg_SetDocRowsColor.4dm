//%attributes = {}
  //ACTcfg_SetDocRowsColor

For ($i;1;Size of array:C274(atACT_Cats))
	  //If (ACTcfg_DocTribComplete ($i))
	If (ACTcfg_DocTribComplete ($i;aiACT_Tipo{$i}))  //20140708 RCH para quitar el color rojo de los documentos digitales
		abACT_DocComplete{$i}:=True:C214
		AL_SetRowColor (ALP_TiposdeDoc;$i;"Black";0;"";0)
	Else 
		abACT_DocComplete{$i}:=False:C215
		AL_SetRowColor (ALP_TiposdeDoc;$i;"";4;"";0)
	End if 
End for 
AL_UpdateArrays (ALP_TiposdeDoc;-1)
For ($j;1;Size of array:C274(atACT_Categorias))
	$ok:=ACTcfg_SearchCatDocs (alACT_IDsCats{$j})
	If ($ok)
		AL_SetRowColor (xALP_CatsDT;$j;"Black";0;"";0)
	Else 
		AL_SetRowColor (xALP_CatsDT;$j;"";4;"";0)
	End if 
End for 
AL_UpdateArrays (xALP_CatsDT;-1)