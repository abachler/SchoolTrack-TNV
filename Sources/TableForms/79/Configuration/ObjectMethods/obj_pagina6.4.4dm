If (String:C10(casillaMostrar)="1")
	  //muestro la fila de tags que esta oculta
	$err:=ALP_DefaultColSettings (xALP_MetaDef;3;"atADT_DefTypeTxt";__ ("Tipo");160)
	$err:=ALP_DefaultColSettings (xALP_MetaDef;4;"atADT_DefHTMLTags";__ ("Etiqueta HTML");120;"";0;0;1)
	AL_SetColOpts (xALP_MetaDef;1;1;1;5;0)
	If (Selected list items:C379(vl_TabMetaDatos)#1)
		AL_SetEnterable (xALP_MetaDef;3;2;atADT_TypesTxt)
	End if 
	AL_UpdateArrays (xALP_MetaDef;-2)
Else 
	  //escondo la columna de tags
	$err:=ALP_DefaultColSettings (xALP_MetaDef;3;"atADT_DefTypeTxt";__ ("Tipo");280)
	$err:=ALP_DefaultColSettings (xALP_MetaDef;4;"atADT_DefHTMLTags";__ ("Etiqueta HTML");0;"";0;0;1)
	AL_SetColOpts (xALP_MetaDef;1;1;1;6;0)
	If (Selected list items:C379(vl_TabMetaDatos)#1)
		AL_SetEnterable (xALP_MetaDef;3;2;atADT_TypesTxt)
	End if 
	AL_UpdateArrays (xALP_MetaDef;-2)
End if 
