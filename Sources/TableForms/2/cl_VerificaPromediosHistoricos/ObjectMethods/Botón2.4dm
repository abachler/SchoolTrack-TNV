$result:=CD_Dlog (0;"Por favor confirme que desea modificar el promedio general actualmente registrado"+" en esta asignatura";"";"Cancelar";"Confirmo corrección propuesta")
If ($result>0)
	KRL_ReloadInReadWriteMode (->[Alumnos_Calificaciones:208])
	[Alumnos_Calificaciones:208]Anual_Nota:12:=vr_promedioAnual
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=vr_promedioOficial
	SAVE RECORD:C53([Alumnos_Calificaciones:208])
	KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
	OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Nota:12;-6)
End if 