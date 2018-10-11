If (Self:C308->>0)
	[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50:=Self:C308->{Self:C308->}
	[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88:=String:C10(Year of:C25(Current date:C33(*));"0000")+" "+String:C10(Month of:C24(Current date:C33(*));"00")+" "+String:C10(Day of:C23(Current date:C33(*));"00")+" - "+<>tUSR_CurrentUser+" - "+API Get Virtual Field Name (Table:C252(->[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50);Field:C253(->[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50))+": "+Old:C35([Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50)+" -> "+[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50+"\r"+[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88
	LOG_RegisterEvt ("Modificación en el campo "+API Get Virtual Field Name (Table:C252(->[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50);Field:C253(->[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50))+", del registro histórico del alumno "+[Alumnos:2]apellidos_y_nombres:40+".")
	SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
End if 
