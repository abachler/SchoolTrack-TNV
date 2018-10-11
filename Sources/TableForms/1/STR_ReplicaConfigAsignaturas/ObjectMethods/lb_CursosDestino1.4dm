
For ($i;1;Size of array:C274(lb_CursosDestino))
	If (lb_CursosDestino{$i}=True:C214)
		$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
		If (Find in array:C230(at_Secciones;$letra)<0)
			APPEND TO ARRAY:C911(at_Secciones;$letra)
		End if 
	Else 
		$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
		$el:=Find in array:C230(at_Secciones;$letra)
		If ($el>0)
			DELETE FROM ARRAY:C228(at_Secciones;$el)
		End if 
	End if 
End for 
SORT ARRAY:C229(at_Secciones;>)
$letraCursoOrigen:=ST_ClearSpaces (ST_GetWord (at_CursoOrigen{at_CursoOrigen};2;"-"))
$el:=Find in array:C230(at_Secciones;$letraCursoOrigen)
If ($el>0)
	DELETE FROM ARRAY:C228(at_Secciones;$el)
End if 
vt_secciones:=AT_array2text (->at_Secciones;", ")