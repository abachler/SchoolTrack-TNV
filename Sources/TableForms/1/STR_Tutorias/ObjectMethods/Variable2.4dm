Case of 
	: ((alProEvt=1) | (alProEvt=2))
		ARRAY INTEGER:C220(aLines;0)
		$err:=AL_GetSelect (Self:C308->;aLines)
	: (alProEvt=-5)
		$ProfLine:=AL_GetLine (xALP_Profesores)
		If ($profLine>0)
			$profID:=aProfesoresID{$ProfLine}
			$ProfName:=aProfesores{$ProfLine}
			
			ARRAY INTEGER:C220(aLines;0)
			$err:=AL_GetSelect (Self:C308->;aLines)
			AL_GetDrgSrcRow (Self:C308->;$oldNo)
			AL_GetDrgArea (Self:C308->;$area;$pId)
			If ($area=xALP_Tutoria)
				
				READ WRITE:C146([Alumnos:2])
				For ($i;1;Size of array:C274(aLines))
					GOTO RECORD:C242([Alumnos:2];aAlumnosID{aLines{$i}})
					If (Not:C34(KRL_IsRecordLocked (->[Alumnos:2])))
						[Alumnos:2]Tutor_numero:36:=$profID
						[Alumnos:2]Tutor_Nombre:38:=$ProfName
						SAVE RECORD:C53([Alumnos:2])
						UNLOAD RECORD:C212([Alumnos:2])
					End if 
				End for 
				
				
				$line:=AL_GetLine (xALP_CursosTutorias)
				$curso:=aCursos{$line}
				READ ONLY:C145([Alumnos:2])
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso;*)
				QUERY:C277([Alumnos:2]; & [Alumnos:2]Tutor_numero:36=0)
				SELECTION TO ARRAY:C260([Alumnos:2];aAlumnosID;[Alumnos:2]apellidos_y_nombres:40;aAlumnos)
				AL_UpdateArrays (xALP_Alumnos;-2)
				AL_SetSort (xALP_Alumnos;1)
				ARRAY INTEGER:C220(aLines;0)
				AL_SetSelect (xALP_Alumnos;aLines)
				
				QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=$profID)
				SELECTION TO ARRAY:C260([Alumnos:2];aPupilosID;[Alumnos:2]apellidos_y_nombres:40;aPupilos)
				AL_UpdateArrays (xALP_Tutoria;-2)
				AL_SetSort (xALP_Tutoria;1)
				AL_SetLine (xALP_Tutoria;0)
			Else 
				BEEP:C151
			End if 
		Else 
			BEEP:C151
		End if 
End case 