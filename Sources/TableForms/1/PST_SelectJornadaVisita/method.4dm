Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		READ ONLY:C145([ADT_JornadasVisita:144])
		ALL RECORDS:C47([ADT_JornadasVisita:144])
		ORDER BY:C49([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Section:5;>)
		SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Section:5;atPST_SeccionJornada;[ADT_JornadasVisita:144]Date_Jornada:2;adPST_DateJornada;[ADT_JornadasVisita:144]Hora_Jornada:3;aiPST_HoraJornada)
		SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Total:8;aiPST_AsistentesJornada;[ADT_JornadasVisita:144]Place:4;atPST_LugarJornada;[ADT_JornadasVisita:144]ID:1;aiPST_IDJornada)
		SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Boys:7;aiPST_SelJornadaBoys;[ADT_JornadasVisita:144]Girls:6;aiPST_SelJornadaGirls;[ADT_JornadasVisita:144]Total:8;aiPST_SelJornadaTotal)
		
		xALSet_ADT_SeleccionJVisita 
		
		For ($i;1;Size of array:C274(aiPST_IDJornada))
			If (aiPST_IDJornada{$i}=[ADT_Candidatos:49]ID_JornadaVisita:57)
				AL_SetRowStyle (xALP_SelJornadaVisita;$i;1;"Tahoma")
			Else 
				AL_SetRowStyle (xALP_SelJornadaVisita;$i;0;"Tahoma")
			End if 
			AL_SetRowColor (xALP_SelJornadaVisita;$i;"";7;"";161)
		End for 
		AL_UpdateArrays (xALP_SelJornadaVisita;-2)
		AL_SetLine (xALP_SelJornadaVisita;0)
	: (Form event:C388=On Close Box:K2:21)
		ADTcdd_OnRecordLoad 
		ACCEPT:C269
End case 
