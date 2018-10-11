C_POINTER:C301($lasObject)
_O_C_STRING:C293(80;$varName)
C_LONGINT:C283($table;$field)

$lastObject:=Focus object:C278
RESOLVE POINTER:C394($lastObject;$varName;$table;$field)

Case of 
	: ($varName="xAL_tutoria")
		$line:=AL_GetLine (xALP_Tutoria)
		If ($line>0)
			$ProfLine:=AL_GetLine (xALP_Profesores)
			If ($profLine>0)
				$profID:=aProfesoresID{$ProfLine}
				$ProfName:=aProfesores{$ProfLine}
				GOTO RECORD:C242([Alumnos:2];aPupilosID{$line})
				  //$msg:=Replace string(RP_GetIdxString (21113;5);"^0";[Alumnos]Apellidos_y_Nombres)
				  //$msg:=Replace string($msg;"^1";$ProfName)
				$r:=CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("¿Desea realmente retirar a ^0 de la tutoria de ^1?");__ ("^0");[Alumnos:2]apellidos_y_nombres:40);__ ("^1");$ProfName);__ ("");__ ("No");__ ("Sí"))
				If ($r=2)
					If (Not:C34(KRL_IsRecordLocked (->[Alumnos:2])))
						[Alumnos:2]Tutor_numero:36:=0
						[Alumnos:2]Tutor_Nombre:38:=""
						SAVE RECORD:C53([Alumnos:2])
						UNLOAD RECORD:C212([Alumnos:2])
						READ ONLY:C145([Alumnos:2])
						
						$line:=AL_GetLine (xALP_CursosTutorias)
						If ($line>0)
							$curso:=aCursos{$line}
							READ ONLY:C145([Alumnos:2])
							QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso;*)
							QUERY:C277([Alumnos:2]; & [Alumnos:2]Tutor_numero:36=0)
						Else 
							REDUCE SELECTION:C351([Alumnos:2];0)
						End if 
						SELECTION TO ARRAY:C260([Alumnos:2];aAlumnosID;[Alumnos:2]apellidos_y_nombres:40;aAlumnos)
						AL_UpdateArrays (xALP_Alumnos;-2)
						AL_SetSort (xALP_Alumnos;1)
						ARRAY INTEGER:C220(aLines;0)
						AL_SetSelect (xALP_Alumnos;aLines)
						
						READ ONLY:C145([Alumnos:2])
						QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=$profID)
						SELECTION TO ARRAY:C260([Alumnos:2];aPupilosID;[Alumnos:2]apellidos_y_nombres:40;aPupilos)
						AL_UpdateArrays (xALP_Tutoria;-2)
						AL_SetSort (xALP_Tutoria;1)
						AL_SetLine (xALP_Tutoria;0)
					End if 
				End if 
			Else 
				BEEP:C151
			End if 
		Else 
			BEEP:C151
		End if 
End case 