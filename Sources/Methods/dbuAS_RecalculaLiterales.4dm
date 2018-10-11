//%attributes = {}
  //dbuAS_RecalculaLiterales

READ ONLY:C145([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
ARRAY LONGINT:C221($aRNASignaturas;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRNASignaturas;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando calificaciones literales..."))
For ($i;1;Size of array:C274($aRNASignaturas))
	GOTO RECORD:C242([Asignaturas:18];$aRNASignaturas{$i})
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")
	For ($iEvaluaciones;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Alumnos_Calificaciones:208])
		GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$iEvaluaciones})
		For ($iFields;11;26;5)
			$realValue:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields)->
			$fieldNota:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+1)
			$fieldNota->:=EV2_Real_a_Nota ($realValue)
			$fieldPuntos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+2)
			$fieldPuntos->:=EV2_Real_a_Puntos ($realValue)
			$fieldSimbolos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+3)
			$fieldSimbolos->:=EV2_Real_a_Simbolo ($realValue)
			$fieldLiteralInterno:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+4)
			$fieldLiteralInterno->:=NTA_PercentValue2StringValue ($realValue;iPrintMode)
		End for 
		For ($iFields;42;412;5)
			$realValue:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields)->
			$fieldNota:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+1)
			$fieldNota->:=EV2_Real_a_Nota ($realValue)
			$fieldPuntos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+2)
			$fieldPuntos->:=EV2_Real_a_Puntos ($realValue)
			$fieldSimbolos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+3)
			$fieldSimbolos->:=EV2_Real_a_Simbolo ($realValue)
			$fieldLiteralInterno:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+4)
			$fieldLiteralInterno->:=NTA_PercentValue2StringValue ($realValue;iPrintMode)
		End for 
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRNASignaturas))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])