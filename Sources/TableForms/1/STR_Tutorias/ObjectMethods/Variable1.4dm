If (alProEvt=1)
	$line:=AL_GetLine (Self:C308->)
	If ($line>0)
		$curso:=aCursos{$line}
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Tutor_numero:36=0)
		SELECTION TO ARRAY:C260([Alumnos:2];aAlumnosID;[Alumnos:2]apellidos_y_nombres:40;aAlumnos)
		AL_UpdateArrays (xALP_Alumnos;-2)
		AL_SetSort (xALP_Alumnos;1)
		ARRAY INTEGER:C220(aLines;0)
		AL_SetSelect (xALP_Alumnos;aLines)
	End if 
End if 