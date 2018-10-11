//%attributes = {}
  //PST_AsignarJornadaVisita

PST_ReadParameters 
If (([ADT_Candidatos:49]ID_JornadaVisita:57=0) & (viPST_AutoAsigJornadas=1))
	
	READ ONLY:C145([ADT_JornadasVisita:144])
	QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Total:8<viPST_MaxPerJornadaVisita)
	
	If (Records in selection:C76([ADT_JornadasVisita:144])>0)
		
		C_LONGINT:C283($min)
		ARRAY LONGINT:C221($atIDJornadas;0)
		READ WRITE:C146([ADT_JornadasVisita:144])
		
		ALL RECORDS:C47([ADT_JornadasVisita:144])
		$min:=Min:C4([ADT_JornadasVisita:144]Total:8)
		
		QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Total:8=$min)
		SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]ID:1;$atIDJornadas)
		
		QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$atIDJornadas{1})
		
		  //buscar el registro de alumno del candidato
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
		
		Case of 
			: ([Alumnos:2]Sexo:49="F")
				[ADT_JornadasVisita:144]Girls:6:=[ADT_JornadasVisita:144]Girls:6+1
				[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8+1
				[ADT_Candidatos:49]ID_JornadaVisita:57:=[ADT_JornadasVisita:144]ID:1
				SAVE RECORD:C53([ADT_JornadasVisita:144])
			: ([Alumnos:2]Sexo:49="M")
				[ADT_JornadasVisita:144]Boys:7:=[ADT_JornadasVisita:144]Boys:7+1
				[ADT_JornadasVisita:144]Total:8:=[ADT_JornadasVisita:144]Total:8+1
				[ADT_Candidatos:49]ID_JornadaVisita:57:=[ADT_JornadasVisita:144]ID:1
				SAVE RECORD:C53([ADT_JornadasVisita:144])
			Else 
				CD_Dlog (1;__ ("Debe definir el sexo del candidato, antes de asignar una jornada de visita."))
				KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
		End case 
		
		  //SAVE RECORD([ADT_Candidatos])
		  //KRL_UnloadReadOnly (->[ADT_JornadasVisita])
	Else 
		CD_Dlog (1;__ ("No quedan secciones con cupos disponibles para las Jornadas de Visita"))
	End if 
End if 



