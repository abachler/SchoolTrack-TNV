  //20130412 RCH Habia problema con el indice porque habia un elemento vacio
ARRAY TEXT:C222($atACT_RegimenPagares;0)
For ($l_indiceArray;1;Size of array:C274(atACT_RegimenPagares))
	If (atACT_RegimenPagares{$l_indiceArray}#"")
		APPEND TO ARRAY:C911($atACT_RegimenPagares;atACT_RegimenPagares{$l_indiceArray})
	End if 
End for 
$choice:=IT_PopUpMenu (->$atACT_RegimenPagares;->vtACT_RegimenCargo)
vtACT_RegimenCargo:=$atACT_RegimenPagares{$choice}

  //$choice:=IT_PopUpMenu (->atACT_RegimenPagares;->vtACT_RegimenCargo)
  //vtACT_RegimenCargo:=atACT_RegimenPagares{$choice}