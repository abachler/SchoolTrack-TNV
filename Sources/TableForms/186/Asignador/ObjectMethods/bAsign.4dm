For ($i;Size of array:C274(lb_asignaturasArea);1;-1)
	If (Not:C34(lb_asignaturasArea{$i}))
		DELETE FROM ARRAY:C228(atMPA_AsignaturasArea;$i)
	End if 
End for 