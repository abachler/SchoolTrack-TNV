//%attributes = {}
  // Método: EV2_CalculoALT_FinalPeriodo
  //
  // 
  // por Alberto Bachler Klein
  // creación 11/07/17, 16:11:50
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_LONGINT:C283($1)

C_LONGINT:C283($l_Periodo)
C_POINTER:C301($y_BonificacionLiteral;$y_Bonificacion;$y_BonificacionPuntos;$y_BonificacionReal;$y_BonificacionSimbolo;$y_ControlLiteral;$y_Control;$y_ControlPuntos;$y_Control;$y_ControlSimbolo)
C_POINTER:C301($y_Esfuerzo;$y_FinalLiteral;$y_FinalNoAproximado;$y_FinalNota;$y_FinalPuntos;$y_FinalReal;$y_FinalSimbolo;$y_PresentacionLiteral;$y_Presentacion;$y_PresentacionPuntos)
C_POINTER:C301($y_PresentacionReal;$y_PresentacionSimbolo)


If (False:C215)
	C_LONGINT:C283(EV2_CalculoALT_FinalPeriodo ;$1)
End if 

$l_periodo:=$1

Case of 
	: (iEvaluationMode=Notas)
		$l_modoAlternativo:=Puntos
		$r_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;11)
		$l_decimales:=iPointsDecPP
	: (iEvaluationMode=Puntos)
		$l_modoAlternativo:=Notas
		$r_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;11)
		$l_decimales:=iGradesDecPP
End case 


  //asignacion de campos a punteros según periodos
Case of 
	: ($l_modoAlternativo=Notas)
		Case of 
			: ($l_periodo=1)
				$y_promedio:=->[Alumnos_Calificaciones:208]P01_Final_Nota:113
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103
				$y_Control:=->[Alumnos_Calificaciones:208]P01_Control_Nota:108
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Nota:511
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
				
			: ($l_periodo=2)
				$y_promedio:=->[Alumnos_Calificaciones:208]P02_Final_Nota:188
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178
				$y_Control:=->[Alumnos_Calificaciones:208]P02_Control_Nota:183
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Nota:516
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
				
			: ($l_periodo=3)
				$y_promedio:=->[Alumnos_Calificaciones:208]P03_Final_Nota:263
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253
				$y_Control:=->[Alumnos_Calificaciones:208]P03_Control_Nota:258
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Nota:521
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
				
			: ($l_periodo=4)
				$y_promedio:=->[Alumnos_Calificaciones:208]P04_Final_Nota:338
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328
				$y_Control:=->[Alumnos_Calificaciones:208]P04_Control_Nota:333
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Nota:526
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
				
			: ($l_periodo=5)
				$y_promedio:=->[Alumnos_Calificaciones:208]P05_Final_Nota:413
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403
				$y_Control:=->[Alumnos_Calificaciones:208]P05_Control_Nota:408
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Nota:531
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
		End case 
		
	: ($l_modoAlternativo=Puntos)
		Case of 
			: ($l_periodo=1)
				$y_promedio:=->[Alumnos_Calificaciones:208]P01_Final_Puntos:114
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104
				$y_Control:=->[Alumnos_Calificaciones:208]P01_Control_Puntos:109
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Puntos:512
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
				
			: ($l_periodo=2)
				$y_promedio:=->[Alumnos_Calificaciones:208]P02_Final_Puntos:189
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179
				$y_Control:=->[Alumnos_Calificaciones:208]P02_Control_Puntos:184
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Puntos:517
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
				
			: ($l_periodo=3)
				$y_promedio:=->[Alumnos_Calificaciones:208]P03_Final_Puntos:264
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254
				$y_Control:=->[Alumnos_Calificaciones:208]P03_Control_Puntos:259
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Puntos:522
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
				
			: ($l_periodo=4)
				$y_promedio:=->[Alumnos_Calificaciones:208]P04_Final_Puntos:339
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329
				$y_Control:=->[Alumnos_Calificaciones:208]P04_Control_Puntos:334
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Puntos:527
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
				
			: ($l_periodo=5)
				$y_promedio:=->[Alumnos_Calificaciones:208]P05_Final_Puntos:414
				$y_Presentacion:=->[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404
				$y_Control:=->[Alumnos_Calificaciones:208]P05_Control_Puntos:409
				$y_Bonificacion:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Puntos:532
				$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
		End case 
End case 

  // leo la configuración de control de fin de período, examenes y bonificaciones extra-acedemicas
EV2_Examenes_LeeConfigExamenes ($l_Periodo)


$y_Presentacion->:=Choose:C955((vi_UsarControlesFinPeriodo=1) & ($y_Control->=-2);$y_Control->;$y_Presentacion->)
$y_promedio->:=$y_Presentacion->
Case of 
	: ($y_promedio->=-2)
		$y_presentacion->:=-2
	Else 
		
		  //calculo del PROMEDIO FINAL DEL PERIODO
		If ((vi_UsarControlesFinPeriodo=1) & (($y_Control->>-1) | ($y_Presentacion->>-1)))
			$y_promedio->:=EV2_CalculoALT_PP_conControl ($y_Presentacion->;$y_Control->)
		End if 
		
		  // calculo de la bonificación de fin de período
		If ((vi_UsarBonificacion=1) & ($y_Bonificacion->>=0) & (vr_BonificacionPeriodo>0) & ($y_promedio->>=vrNTA_MinimoEscalaReferencia))
			$y_promedio->:=EV2_CalculoALT_AgregaBonif ($y_promedio->;$y_Bonificacion->;$l_modoAlternativo)
		End if 
		
		
		
		If (([Asignaturas:18]Ingresa_Esfuerzo:40) & ($y_promedio->>=vrNTA_MinimoEscalaReferencia))
			$y_promedio->:=EV2_CalculoALT_IntegraEsfuerzo ($y_promedio->;$y_Esfuerzo->;$l_modoAlternativo)
		End if 
		
		If (vi_gTrPAvg=1)
			$y_promedio->:=Trunc:C95($y_promedio->;$l_decimales)
		Else 
			$y_promedio->:=Round:C94($y_promedio->;$l_decimales)
		End if 
		
		
End case 