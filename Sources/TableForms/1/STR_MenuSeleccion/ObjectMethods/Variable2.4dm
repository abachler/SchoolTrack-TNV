For ($i;1;Size of array:C274(lb_contenido))
	If (lb_contenido{$i})
		APPEND TO ARRAY:C911(y_resultado->;$i)
	End if 
End for 
CANCEL:C270