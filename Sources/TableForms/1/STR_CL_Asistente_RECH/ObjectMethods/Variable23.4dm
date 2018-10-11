For ($i;Size of array:C274(al_NivelesRech);1;-1)
	If (lb_niveles{$i}=False:C215)
		DELETE FROM ARRAY:C228(al_NivelesRech;$i)
	End if 
End for 