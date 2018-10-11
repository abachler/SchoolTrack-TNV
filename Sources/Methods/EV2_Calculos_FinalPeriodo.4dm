//%attributes = {}
  // EV2_Calculos_FinalPeriodo()
  //
  //
  // creado por: Alberto Bachler Klein: 26-11-16, 11:03:10
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_Periodo)
C_POINTER:C301($y_BonificacionLiteral;$y_BonificacionNota;$y_BonificacionPuntos;$y_BonificacionReal;$y_BonificacionSimbolo;$y_ControlLiteral;$y_ControlNota;$y_ControlPuntos;$y_ControlReal;$y_ControlSimbolo)
C_POINTER:C301($y_Esfuerzo;$y_FinalLiteral;$y_FinalNoAproximado;$y_FinalNota;$y_FinalPuntos;$y_FinalReal;$y_FinalSimbolo;$y_PresentacionLiteral;$y_PresentacionNota;$y_PresentacionPuntos)
C_POINTER:C301($y_PresentacionReal;$y_PresentacionSimbolo)


If (False:C215)
	C_LONGINT:C283(EV2_Calculos_FinalPeriodo ;$1)
End if 

$l_periodo:=$1

  //asignacion de campos a punteros segœn periodos
Case of 
	: ($l_periodo=1)
		$y_PresentacionReal:=->[Alumnos_Calificaciones:208]P01_Presentacion_Real:102
		$y_PresentacionNota:=->[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103
		$y_PresentacionPuntos:=->[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104
		$y_PresentacionSimbolo:=->[Alumnos_Calificaciones:208]P01_Presentacion_Simbolo:105
		$y_PresentacionLiteral:=->[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106
		$y_FinalReal:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
		$y_FinalNota:=->[Alumnos_Calificaciones:208]P01_Final_Nota:113
		$y_FinalPuntos:=->[Alumnos_Calificaciones:208]P01_Final_Puntos:114
		$y_FinalSimbolo:=->[Alumnos_Calificaciones:208]P01_Final_Simbolo:115
		$y_FinalLiteral:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
		$y_ControlReal:=->[Alumnos_Calificaciones:208]P01_Control_Real:107
		$y_ControlNota:=->[Alumnos_Calificaciones:208]P01_Control_Nota:108
		$y_ControlPuntos:=->[Alumnos_Calificaciones:208]P01_Control_Puntos:109
		$y_ControlSimbolo:=->[Alumnos_Calificaciones:208]P01_Control_Simbolo:110
		$y_ControlLiteral:=->[Alumnos_Calificaciones:208]P01_Control_Literal:111
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Real:510
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Nota:511
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Puntos:512
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Simbolo:513
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
		
	: ($l_periodo=2)
		$y_PresentacionReal:=->[Alumnos_Calificaciones:208]P02_Presentacion_Real:177
		$y_PresentacionNota:=->[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178
		$y_PresentacionPuntos:=->[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179
		$y_PresentacionSimbolo:=->[Alumnos_Calificaciones:208]P02_Presentacion_Simbolo:180
		$y_PresentacionLiteral:=->[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181
		$y_FinalReal:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
		$y_FinalNota:=->[Alumnos_Calificaciones:208]P02_Final_Nota:188
		$y_FinalPuntos:=->[Alumnos_Calificaciones:208]P02_Final_Puntos:189
		$y_FinalSimbolo:=->[Alumnos_Calificaciones:208]P02_Final_Simbolo:190
		$y_FinalLiteral:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
		$y_ControlReal:=->[Alumnos_Calificaciones:208]P02_Control_Real:182
		$y_ControlNota:=->[Alumnos_Calificaciones:208]P02_Control_Nota:183
		$y_ControlPuntos:=->[Alumnos_Calificaciones:208]P02_Control_Puntos:184
		$y_ControlSimbolo:=->[Alumnos_Calificaciones:208]P02_Control_Simbolo:185
		$y_ControlLiteral:=->[Alumnos_Calificaciones:208]P02_Control_Literal:186
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Real:515
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Nota:516
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Puntos:517
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Simbolo:518
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
		
	: ($l_periodo=3)
		$y_PresentacionReal:=->[Alumnos_Calificaciones:208]P03_Presentacion_Real:252
		$y_PresentacionNota:=->[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253
		$y_PresentacionPuntos:=->[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254
		$y_PresentacionSimbolo:=->[Alumnos_Calificaciones:208]P03_Presentacion_Simbolo:255
		$y_PresentacionLiteral:=->[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256
		$y_FinalReal:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
		$y_FinalNota:=->[Alumnos_Calificaciones:208]P03_Final_Nota:263
		$y_FinalPuntos:=->[Alumnos_Calificaciones:208]P03_Final_Puntos:264
		$y_FinalSimbolo:=->[Alumnos_Calificaciones:208]P03_Final_Simbolo:265
		$y_FinalLiteral:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
		$y_ControlReal:=->[Alumnos_Calificaciones:208]P03_Control_Real:257
		$y_ControlNota:=->[Alumnos_Calificaciones:208]P03_Control_Nota:258
		$y_ControlPuntos:=->[Alumnos_Calificaciones:208]P03_Control_Puntos:259
		$y_ControlSimbolo:=->[Alumnos_Calificaciones:208]P03_Control_Simbolo:260
		$y_ControlLiteral:=->[Alumnos_Calificaciones:208]P03_Control_Literal:261
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Real:520
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Nota:521
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Puntos:522
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Simbolo:523
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
		
	: ($l_periodo=4)
		$y_PresentacionReal:=->[Alumnos_Calificaciones:208]P04_Presentacion_Real:327
		$y_PresentacionNota:=->[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328
		$y_PresentacionPuntos:=->[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329
		$y_PresentacionSimbolo:=->[Alumnos_Calificaciones:208]P04_Presentacion_Simbolo:330
		$y_PresentacionLiteral:=->[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331
		$y_FinalReal:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
		$y_FinalNota:=->[Alumnos_Calificaciones:208]P04_Final_Nota:338
		$y_FinalPuntos:=->[Alumnos_Calificaciones:208]P04_Final_Puntos:339
		$y_FinalSimbolo:=->[Alumnos_Calificaciones:208]P04_Final_Simbolo:340
		$y_FinalLiteral:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
		$y_ControlReal:=->[Alumnos_Calificaciones:208]P04_Control_Real:332
		$y_ControlNota:=->[Alumnos_Calificaciones:208]P04_Control_Nota:333
		$y_ControlPuntos:=->[Alumnos_Calificaciones:208]P04_Control_Puntos:334
		$y_ControlSimbolo:=->[Alumnos_Calificaciones:208]P04_Control_Simbolo:335
		$y_ControlLiteral:=->[Alumnos_Calificaciones:208]P04_Control_Literal:336
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Real:525
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Nota:526
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Puntos:527
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Simbolo:528
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
		
	: ($l_periodo=5)
		$y_PresentacionReal:=->[Alumnos_Calificaciones:208]P05_Presentacion_Real:402
		$y_PresentacionNota:=->[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403
		$y_PresentacionPuntos:=->[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404
		$y_PresentacionSimbolo:=->[Alumnos_Calificaciones:208]P05_Presentacion_Simbolo:405
		$y_PresentacionLiteral:=->[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406
		$y_FinalReal:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
		$y_FinalNota:=->[Alumnos_Calificaciones:208]P05_Final_Nota:413
		$y_FinalPuntos:=->[Alumnos_Calificaciones:208]P05_Final_Puntos:414
		$y_FinalSimbolo:=->[Alumnos_Calificaciones:208]P05_Final_Simbolo:415
		$y_FinalLiteral:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
		$y_ControlReal:=->[Alumnos_Calificaciones:208]P05_Control_Real:407
		$y_ControlNota:=->[Alumnos_Calificaciones:208]P05_Control_Nota:408
		$y_ControlPuntos:=->[Alumnos_Calificaciones:208]P05_Control_Puntos:409
		$y_ControlSimbolo:=->[Alumnos_Calificaciones:208]P05_Control_Simbolo:410
		$y_ControlLiteral:=->[Alumnos_Calificaciones:208]P05_Control_Literal:411
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Real:530
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Nota:531
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Puntos:532
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Simbolo:533
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
		
End case 

  // leo la configuración de control de fin de período, examenes y bonificaciones extra-acedemicas
EV2_Examenes_LeeConfigExamenes ($l_Periodo)


$y_PresentacionReal->:=Choose:C955((vi_UsarControlesFinPeriodo=1) & ($y_ControlReal->=-2);$y_ControlReal->;$y_PresentacionReal->)
$y_FinalNoAproximado->:=$y_PresentacionReal->
Case of 
	: ($y_PresentacionReal->=-2)
		$y_FinalNota->:=-2
		$y_FinalPuntos->:=-2
		$y_FinalSimbolo->:="P"
		$y_FinalLiteral->:="P"
		$y_FinalReal->:=-2
	: ($y_PresentacionReal->=-3)
		$y_FinalNota->:=-3
		$y_FinalPuntos->:=-3
		$y_FinalSimbolo->:="X"
		$y_FinalLiteral->:="X"
		$y_FinalReal->:=-3
	Else 
		
		EV2_Calculos_AjustePresentacion ($y_PresentacionReal;$y_PresentacionNota;$y_PresentacionPuntos;$y_PresentacionSimbolo;$y_PresentacionLiteral;$y_FinalNoAproximado)
		
		
		  // calculo de la bonificación de fin de período,  solo si la opción de aplicación de bonificación antes de la integración del control de fin de período ESTA ACTIVADA
		If ((vi_UsarBonificacion=1) & (vi_bonificarAntesControl=1) & ($y_BonificacionReal->>0) & (vr_BonificacionPeriodo>0))
			$y_FinalNoAproximado->:=EV2_Calculos_PromedioBonificado ($y_FinalNoAproximado->;$y_BonificacionReal->)
		End if 
		
		  //calculo del PROMEDIO FINAL DEL PERIODO
		If ((vi_UsarControlesFinPeriodo=1) & (($y_ControlReal->>=vrNTA_MinimoEscalaReferencia) | ($y_PresentacionReal->>=vrNTA_MinimoEscalaReferencia)))
			$y_FinalNoAproximado->:=EV2_Calculos_PromedioConControl ($y_FinalNoAproximado->;$y_ControlReal->)
		End if 
		
		  // calculo de la bonificación de fin de período, solo si la opción de aplicación de bonificación antes de la integración del control de fin de período NO ESTA ACTIVADA
		If ((vi_UsarBonificacion=1) & (vi_bonificarAntesControl=0) & ($y_BonificacionReal->>0) & (vr_BonificacionPeriodo>0))
			$y_FinalNoAproximado->:=EV2_Calculos_PromedioBonificado ($y_FinalNoAproximado->;$y_BonificacionReal->)
		End if 
		
		
		If (([Asignaturas:18]Ingresa_Esfuerzo:40) & ($y_FinalNoAproximado->>=vrNTA_MinimoEscalaReferencia))
			$y_FinalNoAproximado->:=EV2_Calculos_IntegraEsfuerzo ($y_FinalNoAproximado->;$y_Esfuerzo->)
		End if 
		
		
		EV2_Calculos_AjusteFinalPeriodo ($y_FinalNoAproximado;$y_FinalReal;$y_FinalNota;$y_FinalPuntos;$y_FinalSimbolo;$y_FinalLiteral)
		
End case 