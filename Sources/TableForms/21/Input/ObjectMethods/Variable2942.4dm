If (Self:C308->>0)
	[Alumnos_EventosOrientacion:21]Tipo_evento:11:=Self:C308->{Self:C308->}
	SET WINDOW TITLE:C213(__ ("Registro de ")+[Alumnos_EventosOrientacion:21]Tipo_evento:11+__ (" para ")+[Alumnos:2]apellidos_y_nombres:40)
End if 
