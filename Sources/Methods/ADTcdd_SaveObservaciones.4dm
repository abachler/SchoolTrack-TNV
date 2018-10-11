//%attributes = {}
C_LONGINT:C283($i)

If (Size of array:C274(aiIDObservacion)=0)
	READ WRITE:C146([ADT_Candidatos_Observaciones:154])
	QUERY:C277([ADT_Candidatos_Observaciones:154];[ADT_Candidatos_Observaciones:154]IDAlumno:5=[Alumnos:2]numero:1)
	DELETE SELECTION:C66([ADT_Candidatos_Observaciones:154])
	SAVE RECORD:C53([ADT_Candidatos_Observaciones:154])
	KRL_UnloadReadOnly (->[ADT_Candidatos_Observaciones:154])
End if 

For ($i;1;Size of array:C274(aiIDObservacion))
	If (aiIDObservacion{$i}=-1)  //`tiene observaciones ingresadas recientemente, hay que guardarlas
		
		READ WRITE:C146([ADT_Candidatos_Observaciones:154])
		CREATE RECORD:C68([ADT_Candidatos_Observaciones:154])
		
		[ADT_Candidatos_Observaciones:154]ID_Observacion:1:=SQ_SeqNumber (->[ADT_Candidatos_Observaciones:154]ID_Observacion:1)
		[ADT_Candidatos_Observaciones:154]IDAlumno:5:=[Alumnos:2]numero:1
		[ADT_Candidatos_Observaciones:154]FechaIngreso:3:=adFechaObservacion{$i}
		[ADT_Candidatos_Observaciones:154]IngresadaPor:4:=atUsuarioObservacion{$i}
		[ADT_Candidatos_Observaciones:154]Observaciones:2:=atTextoObservacion{$i}
		aiIDObservacion{$i}:=[ADT_Candidatos_Observaciones:154]ID_Observacion:1
		SAVE RECORD:C53([ADT_Candidatos_Observaciones:154])
		
		KRL_UnloadReadOnly (->[ADT_Candidatos_Observaciones:154])
	Else 
		READ ONLY:C145([ADT_Candidatos_Observaciones:154])
		QUERY:C277([ADT_Candidatos_Observaciones:154];[ADT_Candidatos_Observaciones:154]IDAlumno:5=[Alumnos:2]numero:1)
		SELECTION TO ARRAY:C260([ADT_Candidatos_Observaciones:154]ID_Observacion:1;$IDObservacion)
		For ($j;1;Size of array:C274($IDObservacion))
			If (Find in array:C230(aiIDObservacion;$IDObservacion{$j})=-1)
				  //`borrar la observación
				READ WRITE:C146([ADT_Candidatos_Observaciones:154])
				QUERY:C277([ADT_Candidatos_Observaciones:154];[ADT_Candidatos_Observaciones:154]ID_Observacion:1=$IDObservacion{$j})
				DELETE SELECTION:C66([ADT_Candidatos_Observaciones:154])
				SAVE RECORD:C53([ADT_Candidatos_Observaciones:154])
				KRL_UnloadReadOnly (->[ADT_Candidatos_Observaciones:154])
			End if 
		End for 
	End if 
End for 
