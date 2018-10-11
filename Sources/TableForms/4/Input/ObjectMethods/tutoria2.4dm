If ((USR_checkRights ("A";->[Alumnos_EventosPersonales:16])) | ([Profesores:4]Numero:1=[Alumnos:2]Tutor_numero:36))
	If (alProEvt=2)
		$line:=AL_GetLine (xALP_Tutoria2)
		GOTO RECORD:C242([Alumnos_EventosPersonales:16];aInterviewRecNo{$line})
		  //WDW_Open (501;175;0;palette form Window;"Entrevistas")
		WDW_OpenFormWindow (->[Alumnos_EventosPersonales:16];"Input";0;Palette form window:K39:9;__ ("Entrevistas"))
		KRL_ModifyRecord (->[Alumnos_EventosPersonales:16];"Input")
		  //QUERY([Alumnos_EventosPersonales];[Alumnos_EventosPersonales]Alumno_Numero=[Alumnos]Número)
		  //QUERY SELECTION([Alumnos_EventosPersonales];[Alumnos_EventosPersonales]ID_Owner=-1;*)  `◊ST_v5004
		  //QUERY SELECTION([Alumnos_EventosPersonales]; | [Alumnos_EventosPersonales]ID_Owner=<>lUSR_RelatedTableUserID)  `◊ST_v5004
		
		  //25-04-2011 AS  se modifica el codigo que muestra las entrevistas
		QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=[Alumnos:2]numero:1)
		QUERY SELECTION:C341([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]ID_Owner:2=-1;*)  //◊ST_v5004
		QUERY SELECTION:C341([Alumnos_EventosPersonales:16]; | [Alumnos_EventosPersonales:16]ID_Owner:2=<>lUSR_RelatedTableUserID)
		CREATE SET:C116([Alumnos_EventosPersonales:16];"Privadas")
		
		QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=[Alumnos:2]numero:1)
		QUERY SELECTION:C341([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]ID_Autor:11=-1;*)  //◊ST_v5004
		QUERY SELECTION:C341([Alumnos_EventosPersonales:16]; | [Alumnos_EventosPersonales:16]ID_Autor:11=<>lUSR_RelatedTableUserID)
		CREATE SET:C116([Alumnos_EventosPersonales:16];"NoPrivadas")
		
		UNION:C120("Privadas";"NoPrivadas";"Entrevistas")
		USE SET:C118("Entrevistas")
		
		
		SELECTION TO ARRAY:C260([Alumnos_EventosPersonales:16];aInterviewRecNo;[Alumnos_EventosPersonales:16]Fecha:3;aInterviewDate;[Alumnos_EventosPersonales:16]Interlocutor:10;aInterViewPerson)
		QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=[Alumnos:2]numero:1)
		ORDER BY:C49([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Fecha:3;<)
		
		SET_ClearSets ("Privadas";"NoPrivadas";"Entrevistas")
		
		AL_UpdateArrays (xALP_Tutoria2;-2)
		If ($line<=Size of array:C274(aInterviewRecNo))
			AL_SetLine (xALP_Tutoria2;$line)
		Else 
			AL_SetLine (xALP_Tutoria2;0)
		End if 
	End if 
End if 