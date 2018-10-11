
If (Form event:C388=On Printing Detail:K2:18)
	  //TRACE
	$err:=PL_SetArraysNam (xPL_Matricula;1;3;"aMovimientos0";"aMovimientospk";"aMovimientosTPK")
	PL_SetWidths (xPL_Matricula;1;3;60;60;60)
	PL_SetStyle (xPL_Matricula;0;"Times";8;0)
	PL_SetStyle (xPL_Matricula;1;"Times";8;1)
	PL_SetStyle (xPL_Matricula;10;"Times";8;1)
	PL_SetDividers (xPL_Matricula;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_Matricula;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFormat (xPL_Matricula;1;"";2)
	PL_SetFormat (xPL_Matricula;2;"";2)
	PL_SetFormat (xPL_Matricula;3;"";2)
	
	
	$err:=PL_SetArraysNam (xPL_Asistencia;1;3;"aAsistencia0";"aAsistenciapk";"aAsistenciaTpk")
	PL_SetWidths (xPL_Asistencia;1;3;60;60;60)
	PL_SetStyle (xPL_Asistencia;0;"Times";7;0)
	PL_SetStyle (xPL_Asistencia;1;"Times";7;1)
	PL_SetStyle (xPL_Asistencia;10;"Times";7;1)
	PL_SetDividers (xPL_Asistencia;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_Asistencia;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFormat (xPL_Asistencia;1;"";2)
	PL_SetFormat (xPL_Asistencia;2;"";2)
	PL_SetFormat (xPL_Asistencia;3;"";2)
	
End if 
