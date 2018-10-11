Case of 
	: ((alProEvt=1) | (alProEvt=2))
		ARRAY INTEGER:C220(aLines;0)
		$err:=AL_GetSelect (Self:C308->;aLines)
	: (alProEvt=-5)
		AL_GetDrgArea (Self:C308->;$area)
		Case of 
			: ($area=xALP_Alumnos)
				ARRAY INTEGER:C220(aLines;0)
				$err:=AL_GetSelect (Self:C308->;aLines)
				AL_GetDrgArea (Self:C308->;$area;$pId)
				READ WRITE:C146([Alumnos:2])
				For ($i;1;Size of array:C274(aLines))
					GOTO RECORD:C242([Alumnos:2];aPupilosID{aLines{$i}})
					If (Not:C34(KRL_IsRecordLocked (->[Alumnos:2])))
						[Alumnos:2]Tutor_numero:36:=0
						[Alumnos:2]Tutor_Nombre:38:=""
						$class:=[Alumnos:2]curso:20
						SAVE RECORD:C53([Alumnos:2])
						UNLOAD RECORD:C212([Alumnos:2])
					End if 
				End for 
				$el:=Find in array:C230(aCursos;$class)
				If ($el>0)
					AL_SetLine (xALP_CursosTutorias;$el)
					$line:=AL_GetLine (xALP_CursosTutorias)
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
			: ($area=xALP_Profesores)
				AL_GetDrgDstRow (xALP_Profesores;$ProfLine)
				
				If ($profLine>0)
					AL_SetLine (xALP_Profesores;$profLine)
					$profID:=aProfesoresID{$ProfLine}
					$ProfName:=aProfesores{$ProfLine}
					ARRAY INTEGER:C220(aLines;0)
					$err:=AL_GetSelect (Self:C308->;aLines)
					AL_GetDrgArea (Self:C308->;$area;$pId)
					READ WRITE:C146([Alumnos:2])
					For ($i;1;Size of array:C274(aLines))
						GOTO RECORD:C242([Alumnos:2];aPupilosID{aLines{$i}})
						If (Not:C34(KRL_IsRecordLocked (->[Alumnos:2])))
							[Alumnos:2]Tutor_numero:36:=$profID
							[Alumnos:2]Tutor_Nombre:38:=$ProfName
							SAVE RECORD:C53([Alumnos:2])
							UNLOAD RECORD:C212([Alumnos:2])
						End if 
					End for 
				End if 
		End case 
		
		$line:=AL_GetLine (xALP_Profesores)
		If ($line>0)
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=aProfesoresID{$line})
			SELECTION TO ARRAY:C260([Alumnos:2];aPupilosID;[Alumnos:2]apellidos_y_nombres:40;aPupilos)
			AL_UpdateArrays (xALP_Tutoria;-2)
			AL_SetSort (xALP_Tutoria;1)
			AL_SetLine (xALP_Tutoria;0)
		End if 
End case 
