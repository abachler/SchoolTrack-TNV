//%attributes = {}
  //CU_GuardaCambiosSitSinal

For ($i;1;Size of array:C274(al_RecordNumber))
	KRL_GotoRecord (->[Alumnos:2];al_RecordNumber{$i};True:C214)
	If (ST_ExactlyEqual (at_Comentarios{$i};[Alumnos:2]Comentario_Situacion_Final:31)=0)
		[Alumnos:2]Comentario_Situacion_Final:31:=at_Comentarios{$i}
		SAVE RECORD:C53([Alumnos:2])
	End if 
	If (ST_ExactlyEqual (at_ObservacionesActas{$i};[Alumnos:2]Observaciones_en_Acta:58)=0)
		[Alumnos:2]Observaciones_en_Acta:58:=at_ObservacionesActas{$i}
		SAVE RECORD:C53([Alumnos:2])
	End if 
End for 
KRL_UnloadReadOnly (->[Alumnos:2])