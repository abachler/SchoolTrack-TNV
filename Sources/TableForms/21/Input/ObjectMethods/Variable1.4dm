
If (at_Profesores_Nombres>0)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=al_Profesores_ID{at_Profesores_Nombres})
	$el:=Find in array:C230(al_Profesores_ID;[Profesores:4]Numero:1)
	[Alumnos_EventosOrientacion:21]Registrada_por:8:=at_Profesores_Nombres{$el}
End if 
