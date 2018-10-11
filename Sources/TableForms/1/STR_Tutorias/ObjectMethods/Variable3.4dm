If (alProEvt=1)
	$line:=AL_GetLine (Self:C308->)
	If ($line>0)
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=aProfesoresID{$line})
		SELECTION TO ARRAY:C260([Alumnos:2];aPupilosID;[Alumnos:2]apellidos_y_nombres:40;aPupilos)
		AL_UpdateArrays (xALP_Tutoria;-2)
		AL_SetSort (xALP_Tutoria;1)
		AL_SetLine (xALP_Tutoria;0)
	End if 
End if 