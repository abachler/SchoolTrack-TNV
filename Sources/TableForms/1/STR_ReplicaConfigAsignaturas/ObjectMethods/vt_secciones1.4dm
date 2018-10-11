
vt_secciones:=Replace string:C233(vt_secciones;" ";"")
vt_secciones:=ST_ClearSpaces (vt_secciones)
AT_Text2Array (->at_Secciones;vt_secciones;",")

For ($i;Size of array:C274(at_Secciones);1;-1)
	If (at_Secciones{$i}="")
		DELETE FROM ARRAY:C228(at_Secciones;$i)
	Else 
		at_Secciones{$i}:=Uppercase:C13(at_Secciones{$i})
	End if 
End for 
AT_DistinctsArrayValues (->at_Secciones)

  //For ($i;1;Size of array(at_CursosDestino))
  //$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
  //If (Find in array(at_Secciones;$letra)<0)
  //APPEND TO ARRAY(at_Secciones;$letra)
  //End if 
  //End for 
  //SORT ARRAY(at_Secciones;>)
  //vt_secciones:=AT_array2text (->at_Secciones;", ")


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
