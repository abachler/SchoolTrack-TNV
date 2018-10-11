$fEvent:=Form event:C388
Case of 
	: ($fEvent=On Load:K2:1)
		XS_SetInterface 
		For ($i;1;Size of array:C274(atPST_GroupName))
			Case of 
				: (atPST_GroupName{$i}=[ADT_Candidatos:49]Grupo:21)
					AL_SetRowColor (Self:C308->;$i;"";0;"";161)
					AL_SetRowStyle (Self:C308->;$i;1;"Tahoma")
				Else 
					AL_SetRowColor (Self:C308->;$i;"";7;"";161)
					AL_SetRowStyle (Self:C308->;$i;0;"Tahoma")
			End case 
		End for 
		AL_SetLine (Self:C308->;0)
		AL_SetSort (Self:C308->;8;1)
	: (alProEvt=2)
		  //validar que queden cupos para el grupo al que deseo modificar al postulante
		$line:=AL_GetLine (Self:C308->)
		For ($i;1;Size of array:C274(atPST_GroupName))
			If (atPST_GroupName{$i}=atPST_GroupName{$line})
				  //ver si hay cupos para el grupo
				If (aiPST_Cupos{$i}>0)
					
					
					  //quitar un cupo al grupo asigando
					aiPST_Cupos{$i}:=aiPST_Cupos{$i}-1
					
					  //liberar cupo al grupo desasignado
					For ($j;1;Size of array:C274(atPST_GroupName))
						If (atPST_GroupName{$j}=[ADT_Candidatos:49]Grupo:21)
							aiPST_Cupos{$j}:=aiPST_Cupos{$j}+1
						End if 
					End for 
					
					[ADT_Candidatos:49]Grupo:21:=atPST_GroupName{$line}
					SAVE RECORD:C53([ADT_Candidatos:49])
					ACCEPT:C269
				Else 
					CD_Dlog (1;__ ("No quedan cupos disponibles para el Grupo ")+atPST_GroupName{$line}+__ (". Aumente la cantidad máxima de candidatos si desea cambiar el candidato al Grupo ")+atPST_GroupName{$line}+__ ("."))
				End if 
			End if 
		End for 
End case 



