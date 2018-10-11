
For ($l_indice;Size of array:C274(atACTdte_Nombre);1;-1)
	If (lb_ACTdte_Apoderados{$l_indice})
		AT_Delete ($l_indice;1;->atACTdte_Nombre;->atACTdte_Tipo;->alACTdte_Folio;->alACTdte_ID;->alACTdte_Colores;->abACTdte_Enviar)
	End if 
End for 
