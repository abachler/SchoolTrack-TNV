GOTO OBJECT:C206(lb_CursosDestino)
POST KEY:C465(Character code:C91("A");256)

For ($i;1;Size of array:C274(at_CursosDestino))
	$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
	If (Find in array:C230(at_Secciones;$letra)<0)
		APPEND TO ARRAY:C911(at_Secciones;$letra)
	End if 
End for 
SORT ARRAY:C229(at_Secciones;>)
vt_secciones:=AT_array2text (->at_Secciones;", ")