Case of 
	: (_O_During:C30)
		If (<>aDepto>0)
			[Profesores:4]Departamento:14:=<>aDepto{<>aDepto}
		Else 
			[Profesores:4]Departamento:14:=Old:C35([Profesores:4]Departamento:14)
		End if 
End case 