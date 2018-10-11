Case of 
	: (Self:C308-><0)
		CD_Dlog (0;__ ("El mínimo requerido no puede ser inferior al mínimo de la escala."))
		Self:C308->:=0
		GOTO OBJECT:C206(Self:C308->)
		
	: (Self:C308->>100)
		CD_Dlog (0;__ ("El mínimo requerido no puede ser superior al máximo de la escala."))
		Self:C308->:=0
		GOTO OBJECT:C206(Self:C308->)
		
	Else 
		Self:C308->:=Round:C94(Self:C308->;11)
		If (iEvaluationMode=Porcentaje) | ((iEvaluationMode=Simbolos) & (iPrintMode=Simbolos) & (iPrintActa=Simbolos))
			rAprobatorioPorcentaje:=Round:C94(rPctMinimum;1)
			rPctMinimum:=Round:C94(rPctMinimum;1)
			rPointsMinimum:=Round:C94(rPointsTo*rPctMinimum/100;iPointsDec)
			rGradesMinimum:=Round:C94(rGradesTo*rPctMinimum/100;iGradesDec)
			sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
		End if 
		EVS_SetModified 
End case 