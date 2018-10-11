//%attributes = {}
  //SRal_NotasAsigConsolidables


C_LONGINT:C283($tableNumber;$nextField;$estiloPropioEnHijas;$4)
$id:=$1
$periodo:=$2
$Line:=$3

If (Count parameters:C259=4)
	$estiloPropioEnHijas:=$4
End if 

If (vrNTA_MinimoEscalaReferencia>0)
	$vs_GradesFormat:=vs_GradesFormat+";;"
	$vs_PointsFormat:=vs_PointsFormat+";;"
Else 
	$formatoNotaCero:="0"+<>tXS_RS_DecimalSeparator+("0"*iGradesDec)
	$formatoPuntosCero:="0"+<>tXS_RS_DecimalSeparator+("0"*iPointsDec)
	$vs_GradesFormat:=vs_GradesFormat+";;"+$formatoNotaCero
	$vs_PointsFormat:=vs_PointsFormat+";;"+$formatoPuntosCero
End if 


$selectedRecordNum:=Selected record number:C246([Alumnos_Calificaciones:208])
CUT NAMED SELECTION:C334([Alumnos_Calificaciones:208];"madres")



QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$id;*)
QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
RELATE ONE:C42([Alumnos_Calificaciones:208])
EV2_ObtieneDatosPeriodoActual 

If (Records in selection:C76([Alumnos_Calificaciones:208])#0)
	
	$tableNumber:=Table:C252(->[Alumnos_Calificaciones:208])
	$nextField:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Real:417)
	For ($i;1;12)
		$pct:=Field:C253($tableNumber;$nextField)->
		aSRpSub_EvalPointers{$i}->{$line}:=Field:C253($tableNumber;$nextField+4)->
		aSRpSub_NotasPointers{$i}->{$line}:=String:C10(Field:C253($tableNumber;$nextField+1)->;$vs_GradesFormat)
		aSRpSub_PuntosPointers{$i}->{$line}:=String:C10(Field:C253($tableNumber;$nextField+2)->;$vs_PointsFormat)
		aSRpSub_PorcentajesPointers{$i}->{$line}:=String:C10(Round:C94($pct;1);vs_PercentFormat)
		aSRpSub_SimbolosPointers{$i}->{$line}:=Field:C253($tableNumber;$nextField+3)->
		aSRpSub_IndicadoresPointers{$i}->{$line}:=_Evaluacion_a_Indicador ($pct)
		If ($pct<rPctMinimum)
			aSRpSub_EvalColorPointers{$i}->{$line}:="Red"
		Else 
			aSRpSub_EvalColorPointers{$i}->{$line}:="Blue"
		End if 
		$nextField:=$nextField+5
	End for 
	$pct:=[Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487
	atSRal_SubEvalPeriodo_Eval{$line}:=[Alumnos_Calificaciones:208]PeriodoActual_Final_Literal:491
	atSRal_SubEvalPeriodo_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Final_Nota:488;$vs_GradesFormat)
	atSRal_SubEvalPeriodo_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Final_Puntos:489;$vs_PointsFormat)
	atSRal_SubEvalPeriodo_Simbolos{$line}:=[Alumnos_Calificaciones:208]PeriodoActual_Final_Simbolo:490
	atSRal_SubEvalPeriodo_Indicador{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalPeriodo_Porcentaj{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalPeriodo_Color{$line}:="Red"
	Else 
		atSRal_SubEvalPeriodo_Color{$line}:="Blue"
	End if 
	
	$pct:=[Alumnos_Calificaciones:208]P01_Final_Real:112
	atSRal_SubEvalP1_Eval{$line}:=[Alumnos_Calificaciones:208]P01_Final_Literal:116
	atSRal_SubEvalP1_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]P01_Final_Nota:113;$vs_GradesFormat)
	atSRal_SubEvalP1_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$vs_PointsFormat)
	atSRal_SubEvalP1_Simbolos{$line}:=[Alumnos_Calificaciones:208]P01_Final_Simbolo:115
	atSRal_SubEvalP1_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalP1_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalP1_Color{$line}:="Red"
	Else 
		atSRal_SubEvalP1_Color{$line}:="Blue"
	End if 
	
	$pct:=[Alumnos_Calificaciones:208]P02_Final_Real:187
	atSRal_SubEvalP2_Eval{$line}:=[Alumnos_Calificaciones:208]P02_Final_Literal:191
	atSRal_SubEvalP2_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]P02_Final_Nota:188;$vs_GradesFormat)
	atSRal_SubEvalP2_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]P02_Final_Puntos:189;$vs_PointsFormat)
	atSRal_SubEvalP2_Simbolos{$line}:=[Alumnos_Calificaciones:208]P02_Final_Simbolo:190
	atSRal_SubEvalP2_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalP2_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalP2_Color{$line}:="Red"
	Else 
		atSRal_SubEvalP2_Color{$line}:="Blue"
	End if 
	
	$pct:=[Alumnos_Calificaciones:208]P03_Final_Real:262
	atSRal_SubEvalP3_Eval{$line}:=[Alumnos_Calificaciones:208]P03_Final_Literal:266
	atSRal_SubEvalP3_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]P03_Final_Nota:263;$vs_GradesFormat)
	atSRal_SubEvalP3_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]P03_Final_Puntos:264;$vs_PointsFormat)
	atSRal_SubEvalP3_Simbolos{$line}:=[Alumnos_Calificaciones:208]P03_Final_Simbolo:265
	atSRal_SubEvalP3_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalP3_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalP3_Color{$line}:="Red"
	Else 
		atSRal_SubEvalP3_Color{$line}:="Blue"
	End if 
	
	$pct:=[Alumnos_Calificaciones:208]P04_Final_Real:337
	atSRal_SubEvalP4_Eval{$line}:=[Alumnos_Calificaciones:208]P04_Final_Literal:341
	atSRal_SubEvalP4_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]P04_Final_Nota:338;$vs_GradesFormat)
	atSRal_SubEvalP4_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]P04_Final_Puntos:339;$vs_PointsFormat)
	atSRal_SubEvalP4_Simbolos{$line}:=[Alumnos_Calificaciones:208]P04_Final_Simbolo:340
	atSRal_SubEvalP4_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalP4_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalP4_Color{$line}:="Red"
	Else 
		atSRal_SubEvalP4_Color{$line}:="Blue"
	End if 
	
	
	$pct:=[Alumnos_Calificaciones:208]P05_Final_Real:412
	atSRal_SubEvalP5_Eval{$line}:=[Alumnos_Calificaciones:208]P05_Final_Literal:416
	atSRal_SubEvalP5_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]P05_Final_Nota:413;$vs_GradesFormat)
	atSRal_SubEvalP5_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]P05_Final_Puntos:414;$vs_PointsFormat)
	atSRal_SubEvalP5_Simbolos{$line}:=[Alumnos_Calificaciones:208]P05_Final_Simbolo:415
	atSRal_SubEvalP5_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalP5_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalP5_Color{$line}:="Red"
	Else 
		atSRal_SubEvalP5_Color{$line}:="Blue"
	End if 
	
	
	
	$pct:=[Alumnos_Calificaciones:208]Anual_Real:11
	atSRal_SubEvalPF_Eval{$line}:=[Alumnos_Calificaciones:208]Anual_Literal:15
	atSRal_SubEvalPF_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12;$vs_GradesFormat)
	atSRal_SubEvalPF_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]Anual_Puntos:13;$vs_PointsFormat)
	atSRal_SubEvalPF_Simbolos{$line}:=[Alumnos_Calificaciones:208]Anual_Simbolo:14
	atSRal_SubEvalPF_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalPF_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalPF_Color{$line}:="Red"
	Else 
		atSRal_SubEvalPF_Color{$line}:="Blue"
	End if 
	
	$pct:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
	atSRal_SubEvalF_Eval{$line}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
	atSRal_SubEvalF_Nota{$line}:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$vs_GradesFormat)
	atSRal_SubEvalF_Puntos{$line}:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$vs_PointsFormat)
	atSRal_SubEvalF_Simbolos{$line}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
	atSRal_SubEvalF_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
	atSRal_SubEvalF_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
	If ($pct<rPctMinimum)
		atSRal_SubEvalF_Color{$line}:="Red"
	Else 
		atSRal_SubEvalF_Color{$line}:="Blue"
	End if 
	
	$0:=1
Else 
	$0:=0
End if 


USE NAMED SELECTION:C332("madres")
GOTO SELECTED RECORD:C245([Alumnos_Calificaciones:208];$selectedRecordNum)
RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)

