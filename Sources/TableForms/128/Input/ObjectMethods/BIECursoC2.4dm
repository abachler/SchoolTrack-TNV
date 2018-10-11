If (Self:C308->>0)
	If (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
		[Cursos_Eventos:128]Categoría:3:=Self:C308->{Self:C308->}
		SET WINDOW TITLE:C213(__ ("Detalle de Evento ")+[Cursos_Eventos:128]Categoría:3+__ (" para ")+[Cursos:3]Curso:1+__ (", año ")+String:C10(Year of:C25([Cursos_Eventos:128]Fecha_Observación:2)))
	End if 
End if 