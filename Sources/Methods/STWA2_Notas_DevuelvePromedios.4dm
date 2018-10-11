//%attributes = {}

C_TEXT:C284($t_refJson)

$modifiedAvegares:=$1
$periodo:=$2
$y_json:=$3

$extraProm:=""
$extraAsig:=""

Case of 
	: (Count parameters:C259=4)
		$extraProm:=$4
	: (Count parameters:C259=5)
		$extraProm:=$4
		$extraAsig:=$5
End case 

$rn_Asignatura:=Record number:C243([Asignaturas:18])
C_OBJECT:C1216($ob_examenes)
$ob_examenes:=OB_Create 
  //$ob_raiz:=OB_JsonToObject ($t_refJson->)

  //$t_nodoExamenes:=JSON Append node ($t_refJson;"examenes")
If (iEvaluationMode=Simbolos)
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_Calificaciones:208]ExamenAnual_Real:16);"exreal")
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_Calificaciones:208]ExamenExtra_Real:21);"exxreal")
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26);"freal")
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95);"exrecreal")
Else 
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_Calificaciones:208]ExamenAnual_Literal:20);"exliteral")
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_Calificaciones:208]ExamenExtra_Literal:25);"exxliteral")
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30);"fliteral")
	OB_SET_Text ($ob_examenes;String:C10([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99);"exrecliteral")
End if 
OB_SET ($y_json->;->$ob_examenes;"examenes")
OB_SET_Text ($y_json->;String:C10($rn_Asignatura);"rn")

C_OBJECT:C1216($ob_promedios)
$ob_promedios:=OB_Create 
  //$t_refNodoPromedios:=JSON Append node ($t_refJson;"promedios")
If (Count parameters:C259>3)
	OB_SET ($ob_promedios;->$extraProm;"extraProm")
End if 
If ($modifiedAvegares)
	If (Not:C34([Asignaturas:18]Resultado_no_calculado:47))
		$of:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
		$ppRealPtr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Final_Real")
		$ppNotaPtr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Final_Nota")
		$ppPuntosPtr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Final_Puntos")
		$ppLiteralPtr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Final_Literal")
		Case of 
			: ((iViewMode=Notas) & (iPrintMode#iViewMode))
				If ($ppRealPtr->>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPP>0)
						$pp:=String:C10($ppNotaPtr->;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPP))
					Else 
						$pp:=String:C10($ppNotaPtr->)
					End if 
				End if 
				If ([Alumnos_Calificaciones:208]Anual_Real:11>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPF>0)
						$pf:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPF))
					Else 
						$pf:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12)
					End if 
				Else 
					$pf:=[Alumnos_Calificaciones:208]Anual_Literal:15
				End if 
				If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPF>0)
						$f:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPF))
					Else 
						$f:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
					End if 
				Else 
					$f:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
				End if 
				
				If ([Alumnos_Calificaciones:208]PTC_Real:535>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPF>0)
						$pte:=String:C10([Alumnos_Calificaciones:208]PTC_Nota:536;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPF))
					Else 
						$pte:=String:C10([Alumnos_Calificaciones:208]PTC_Nota:536)
					End if 
				Else 
					$pte:=[Alumnos_Calificaciones:208]PTC_Literal:539
				End if 
				
			: ((iViewMode=Puntos) & (iPrintMode#iViewMode))
				If ($ppRealPtr->>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPP>0)
						$pp:=String:C10($ppPuntosPtr->;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPP))
					Else 
						$pp:=String:C10($ppPuntosPtr->)
					End if 
				End if 
				If ([Alumnos_Calificaciones:208]Anual_Real:11>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPF>0)
						$pf:=String:C10([Alumnos_Calificaciones:208]Anual_Puntos:13;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPF))
					Else 
						$pf:=String:C10([Alumnos_Calificaciones:208]Anual_Puntos:13)
					End if 
				Else 
					$pf:=[Alumnos_Calificaciones:208]Anual_Literal:15
				End if 
				If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPF>0)
						$f:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecNF))
					Else 
						$f:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28)
					End if 
				Else 
					$f:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
				End if 
				
				If ([Alumnos_Calificaciones:208]PTC_Real:535>=vrNTA_MinimoEscalaReferencia)
					If (iGradesDecPF>0)
						$pte:=String:C10([Alumnos_Calificaciones:208]PTC_Puntos:537;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPF))
					Else 
						$pte:=String:C10([Alumnos_Calificaciones:208]PTC_Puntos:537)
					End if 
				Else 
					$pte:=[Alumnos_Calificaciones:208]PTC_Literal:539
				End if 
				
			Else 
				If (iViewMode=iPrintMode)
					$pp:=$ppLiteralPtr->
					$pf:=[Alumnos_Calificaciones:208]Anual_Literal:15
					$f:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
					$pte:=[Alumnos_Calificaciones:208]PTC_Literal:539
				Else 
					$pp:=EV2_Real_a_Literal ($ppRealPtr->;iViewMode;vlNTA_DecimalesPP)
					$pf:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iViewMode;vlNTA_DecimalesPF)
					$f:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;iViewMode;vlNTA_DecimalesNF)
					$pte:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]PTC_Real:535;iViewMode;vlNTA_DecimalesNF)
				End if 
		End case 
		
		If (Not:C34(OB Is defined:C1231($ob_promedios)))
			C_OBJECT:C1216($ob_promedios)
			$ob_promedios:=OB_Create 
		End if 
		OB_SET ($ob_promedios;->$pp;"periodo")
		OB_SET ($ob_promedios;->$pf;"pf")
		OB_SET ($ob_promedios;->$f;"f")
		OB_SET ($ob_promedios;->$of;"of")
		OB_SET ($ob_promedios;->$pte;"PTE")
		OB_SET ($ob_promedios;->[Alumnos_Calificaciones:208]Reprobada:9;"reprobada")
		
		
		C_OBJECT:C1216($ob_asignatura)
		$ob_asignatura:=OB_Create 
		OB_SET ($ob_asignatura;->$extraAsig;"extraAsig")
		OB_SET ($ob_asignatura;->[Asignaturas:18]PromedioFinal_texto:53;"f")
		OB_SET ($ob_asignatura;->[Asignaturas:18]PromedioFinalOficial_texto:67;"of")
		OB_SET_Text ($ob_asignatura;String:C10($rn_Asignatura);"rn")
		OB_SET_Text ($ob_asignatura;String:C10([Asignaturas:18]PorcentajeAprobados:103;"|Pct_2Dec");"porcAprob")
		OB_SET ($ob_promedios;->$ob_asignatura;"asignatura")
		OB_SET ($y_json->;->$ob_promedios;"promedios")
	End if 
End if 
$0:=OB_Object2Json ($y_json->)
