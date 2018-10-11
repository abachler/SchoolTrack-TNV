Case of 
	: (alProEvt=2)
		$line:=AL_GetLine (Self:C308->)
		C_LONGINT:C283($idJornadaVisita)
		
		Case of 
			: ([Alumnos:2]Sexo:49="")
				CD_Dlog (1;__ ("Debe definir el sexo del candidato, antes de asignar una jornada de visita"))
			: ([ADT_Candidatos:49]ID_JornadaVisita:57=0)  //no tiene jornada de visita asignada
				
				QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=aiPST_IDJornada{$line})
				
				If ([ADT_JornadasVisita:144]Total:8<viPST_MaxPerJornadaVisita)  //verificar si para dicha jornada quedan cupos disponibles
					
					READ WRITE:C146([ADT_Candidatos:49])
					[ADT_Candidatos:49]ID_JornadaVisita:57:=aiPST_IDJornada{$line}
					SAVE RECORD:C53([ADT_Candidatos:49])
					AL_SetRowStyle (Self:C308->;$line;1;"Tahoma")
					AL_UpdateArrays (Self:C308->;-2)
					
					  //dejar el registro de la visita en seleccion
					READ WRITE:C146([ADT_JornadasVisita:144])
					QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=aiPST_IDJornada{$line})
					
					Case of 
						: ([Alumnos:2]Sexo:49="F")
							[ADT_JornadasVisita:144]Girls:6:=[ADT_JornadasVisita:144]Girls:6+1
							[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8+1
						: ([Alumnos:2]Sexo:49="M")
							[ADT_JornadasVisita:144]Boys:7:=[ADT_JornadasVisita:144]Boys:7+1
							[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8+1
					End case 
					
					SAVE RECORD:C53([ADT_JornadasVisita:144])
					ACCEPT:C269
				Else 
					CD_Dlog (1;__ ("No quedan cupos disponibles para la Sección seleccionada."))
					ACCEPT:C269
				End if 
				
			: ([ADT_Candidatos:49]ID_JornadaVisita:57#0)  //tiene jornada asignada, se le resta a una y suma a otra
				
				QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=aiPST_IDJornada{$line})
				
				If ([ADT_JornadasVisita:144]Total:8<viPST_MaxPerJornadaVisita)
					
					$idJornadaVisita:=[ADT_Candidatos:49]ID_JornadaVisita:57
					READ WRITE:C146([ADT_JornadasVisita:144])
					QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaVisita)
					
					Case of 
						: ([Alumnos:2]Sexo:49="F")
							[ADT_JornadasVisita:144]Girls:6:=[ADT_JornadasVisita:144]Girls:6-1
							[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8-1
						: ([Alumnos:2]Sexo:49="M")
							[ADT_JornadasVisita:144]Boys:7:=[ADT_JornadasVisita:144]Boys:7-1
							[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8-1
					End case 
					SAVE RECORD:C53([ADT_JornadasVisita:144])
					
					READ WRITE:C146([ADT_Candidatos:49])
					[ADT_Candidatos:49]ID_JornadaVisita:57:=aiPST_IDJornada{$line}
					SAVE RECORD:C53([ADT_Candidatos:49])
					AL_SetRowStyle (Self:C308->;$line;1;"Tahoma")
					AL_UpdateArrays (Self:C308->;-2)
					
					  //dejar el registro de la visita en seleccion
					READ WRITE:C146([ADT_JornadasVisita:144])
					QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=aiPST_IDJornada{$line})
					
					Case of 
						: ([Alumnos:2]Sexo:49="F")
							[ADT_JornadasVisita:144]Girls:6:=[ADT_JornadasVisita:144]Girls:6+1
							[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8+1
						: ([Alumnos:2]Sexo:49="M")
							[ADT_JornadasVisita:144]Boys:7:=[ADT_JornadasVisita:144]Boys:7+1
							[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8+1
					End case 
					
					SAVE RECORD:C53([ADT_JornadasVisita:144])
					ACCEPT:C269
				Else 
					CD_Dlog (1;__ ("No quedan cupos disponibles para la Sección seleccionada."))
					ACCEPT:C269
				End if 
		End case 
End case 