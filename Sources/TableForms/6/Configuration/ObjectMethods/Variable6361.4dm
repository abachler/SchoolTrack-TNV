If (Self:C308->>0)
	[xxSTR_Niveles:6]EvStyle_oficial:23:=aEvStyleId{Self:C308->}
	READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
	GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{Self:C308->})
	EVS_ReadStyleData 
	Case of 
		: (iEValuationMode=Notas)
			rMin:=rGradesFrom
		: (iEValuationMode=Puntos)
			rMin:=rPointsFrom
		: (iEValuationMode=Porcentaje)
			rMin:=1
		: (iEValuationMode=Simbolos)
			rMin:=1
	End case 
	Case of 
		: (iEvaluationMode=Notas)
			vs_minimo0:=String:C10(EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_0:25;0;iGradesDec))
			vs_minimo1:=String:C10(EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_1:26;0;iGradesDec))
			vs_minimo2:=String:C10(EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_2:27;0;iGradesDec))
			vs_minimo3:=String:C10(EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_3:31;0;iGradesDec))
		: (iEvaluationMode=Puntos)
			vs_minimo0:=String:C10(EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_0:25;0;iPointsDec))
			vs_minimo1:=String:C10(EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_1:26;0;iPointsDec))
			vs_minimo2:=String:C10(EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_2:27;0;iPointsDec))
			vs_minimo3:=String:C10(EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_3:31;0;iPointsDec))
		: (iEvaluationMode=Porcentaje)
			vs_minimo0:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_0:25;1))
			vs_minimo1:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_1:26;1))
			vs_minimo2:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_2:27;1))
			vs_minimo3:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_3:31;1))
		: (iEvaluationMode=Simbolos)
			vs_minimo0:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_0:25)
			vs_minimo1:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_1:26)
			vs_minimo2:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_2:27)
			vs_minimo3:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_3:31)
	End case 
End if 