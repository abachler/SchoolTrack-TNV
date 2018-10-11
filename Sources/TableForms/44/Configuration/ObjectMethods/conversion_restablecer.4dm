  // [xxSTR_EstilosEvaluacion].Configuration.Botón1()
  // 
  //
  // creado por: Alberto Bachler Klein: 13-06-16, 11:49:56
  // -----------------------------------------------------------

Case of 
	: (iEvaluationMode=Notas)
		rPctMinimum:=rGradesMinimum/rGradesTo*100
	: (iEvaluationMode=Puntos)
		rPctMinimum:=rPointsMinimum/rPointsTo*100
	: (iEvaluationMode=Porcentaje)
		rPctMinimum:=50
	: (iEvaluationMode=Simbolos)
		
End case 