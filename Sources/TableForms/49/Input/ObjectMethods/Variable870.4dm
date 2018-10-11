  //PST_SelectExam 

If (viPST_AsigExamLibres=1)
	  //asignar examenes de manera libre
	$fecha:=DT_PopCalendar 
	[ADT_Candidatos:49]Fecha_de_examen:7:=$fecha
	If (ok=1)
		OBJECT SET ENTERABLE:C238([ADT_Candidatos:49]Hora_de_examen:19;True:C214)
		OBJECT SET FILTER:C235([ADT_Candidatos:49]Hora_de_examen:19;"!0&9##:##")
		GOTO OBJECT:C206([ADT_Candidatos:49]Hora_de_examen:19)
	End if 
	
	
Else 
	If (([ADT_Candidatos:49]Fecha_de_examen:7#!00-00-00!) | ([ADT_Candidatos:49]Hora_de_examen:19#?00:00:00?))
		PST_SelectExam 
	Else 
		  //validar si quedan cupos
		For ($i;1;Size of array:C274(atPST_GroupName))
			If (atPST_GroupName{$i}=[ADT_Candidatos:49]Grupo:21)
				  //ver si hay cupos para el grupo
				If (aiPST_Cupos{$i}>0)
					PST_SelectExam 
				Else 
					CD_Dlog (1;__ ("No quedan cupos disponibles para el Grupo ")+[ADT_Candidatos:49]Grupo:21+__ (". Aumente la cantidad máxima de candidatos para el grupo en la configuración si desea asignar el candidato."))
				End if 
			End if 
		End for 
	End if 
End if 