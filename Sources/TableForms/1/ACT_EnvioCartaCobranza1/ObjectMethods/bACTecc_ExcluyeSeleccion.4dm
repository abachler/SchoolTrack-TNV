
For ($l_indice;Size of array:C274(atACTecc_ApoderadoNombre);1;-1)
	If (lb_ACTecc_Apoderados{$l_indice})
		AT_Delete ($l_indice;1;->atACTecc_ApoderadoNombre;->atACTecc_ApoderadoModoPago;->arACTecc_ApoderadoMontoVencido;->alACTecc_ApoderadoID;->alACTecc_Colores;->abACTecc_Enviar)
	End if 
End for 
