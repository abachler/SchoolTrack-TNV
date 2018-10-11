EVLG_xALP_Aprendizajes (Self:C308->)
  //MONO 207220
For ($i;1;5)
	$t_nombreCampoLiteral:="[Alumnos_Calificaciones]P"+String:C10($i;"00")+"_Final_Literal"
	$t_nombreCampoReal:="[Alumnos_Calificaciones]P"+String:C10($i;"00")+"_Final_Real"
	$y_campoReal:=KRL_GetFieldPointerByName ($t_nombreCampoReal)
	$y_campoLiteral:=KRL_GetFieldPointerByName ($t_nombreCampoLiteral)
	Case of 
		: ($y_campoReal->=-1)
			OBJECT SET COLOR:C271($y_campoLiteral->;-239)
		: ($y_campoReal->=-2)
			OBJECT SET COLOR:C271($y_campoLiteral->;-9)
		: ($y_campoReal->=-4)
			OBJECT SET COLOR:C271($y_campoLiteral->;-16)
		: ($y_campoReal-><rPctMinimum)
			OBJECT SET COLOR:C271($y_campoLiteral->;-3)
		Else 
			OBJECT SET COLOR:C271($y_campoLiteral->;-6)
	End case 
End for 

Case of 
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-1)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-239)
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-2)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-9)
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-4)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-16)
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<rPctMinimum)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-3)
	Else 
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-6)
End case 

Case of 
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-1)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-239)
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-2)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-9)
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-4)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-16)
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-3)
	Else 
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-6)
End case 

$l_IdEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_de_alumnos:49;->[xxSTR_Niveles:6]EvStyle_oficial:23)
Case of 
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-1)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-239)
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-2)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-9)
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-4)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-16)
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<rPctMinimum)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-3)
	Else 
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-6)
End case 