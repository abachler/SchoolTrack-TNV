$line:=AL_GetLine (xALP_Sections)
If ($line>0)
	
	  //validar si aún quedan cupos de candidatos, para el grupo al que pertenece el candidato
	For ($i;1;Size of array:C274(atPST_GroupName))
		If (atPST_GroupName{$i}=[ADT_Candidatos:49]Grupo:21)
			  //ver si hay cupos para el grupo
			If (aiPST_Cupos{$i}>0)
				  //si aún quedan cupos
				KRL_ReloadInReadWriteMode (->[ADT_Candidatos:49])
				[ADT_Candidatos:49]ID_Exam:29:=aLPST_SelEXmID{$line}
				SAVE RECORD:C53([ADT_Candidatos:49])
				ACCEPT:C269
			Else 
				CD_Dlog (1;__ ("No quedan cupos disponibles para el Grupo ")+[ADT_Candidatos:49]Grupo:21+__ (". Aumente la cantidad máxima de candidatos para el grupo en la configuración si desea asignarle una fecha de exámen al candidato."))
				ACCEPT:C269
			End if 
		End if 
	End for 
	
End if 