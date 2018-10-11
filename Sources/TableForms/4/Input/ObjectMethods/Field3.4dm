Self:C308->:=ST_Format (Self:C308)
If (([Profesores:4]Nombre_comun:21="") & ([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
	[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3
End if 