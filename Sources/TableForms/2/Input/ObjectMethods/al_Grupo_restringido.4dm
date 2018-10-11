If (Self:C308->>0)
	If (<>gGroupAL)
		[Alumnos:2]Grupo:11:=Self:C308->{Self:C308->}
	Else 
		CD_Dlog (0;__ ("El grupo debe ser asignado a la familia y no al alumno."))
	End if 
End if 
