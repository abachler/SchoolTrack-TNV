//%attributes = {}
  // MÉTODO: EV2_Calculos_Final
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 17:30:08
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2_Calculos_Final()
  // ----------------------------------------------------

  // DECLARACIONES E INICIALIZACIONES
C_BOOLEAN:C305($b_pondera)
C_REAL:C285($r_examen;$r_NotaAnual;$r_NotaExamen;$r_NotaExamenExtra;$r_ponderacionExamen;$r_ponderacionPromedio;$r_PromedioAnual;$r_promedioPresentacion;$r_PuntosAnual;$r_PuntosExamen)
C_REAL:C285($r_PuntosExamenExtra;$r_PuntosExamenExtraamenExtra;$r_RealFinal)
C_TEXT:C284($t_simbolo)


  // CODIGO PRINCIPAL

[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501
[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]Anual_Real:11
If (([Alumnos_Calificaciones:208]Anual_Real:11#0) & ([Alumnos_Calificaciones:208]Anual_Real:11<vrNTA_MinimoEscalaReferencia))
	[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
	[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
	[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
	[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
Else 
	
	EV2_Examenes_LeeConfigExamenes 
	[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501
	[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]Anual_Real:11
	
	  // EXAMEN ANUAL NORMAL
	$b_pondera:=False:C215
	If ((vi_UsarExamenes=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))
		Case of 
			: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<vrNTA_MinimoEscalaReferencia)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]Anual_Real:11
			: (e1_PonderacionConstante=1)
				$r_ponderacionExamen:=vr_EX_PonderacionConstante/100
				$r_ponderacionPromedio:=(100-vr_EX_PonderacionConstante)/100
				$b_pondera:=True:C214
			: (e2_PonderacionVariable=1)
				Case of 
					: ((f1_EX_INF_Ponderado=1) & (vr_EX_INF_Ponderacion>0) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // ponderación si examen inferior a Promedio final
						$r_ponderacionExamen:=vr_EX_INF_Ponderacion/100
						$r_ponderacionPromedio:=(100-vr_EX_INF_Ponderacion)/100
						$b_pondera:=True:C214
					: ((g1_EX_SUP_Ponderado=1) & (vr_EX_SUP_Ponderacion>0) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // ponderación si examen superior a Promedio final
						$r_ponderacionExamen:=vr_EX_SUP_Ponderacion/100
						$r_ponderacionPromedio:=(100-vr_EX_SUP_Ponderacion)/100
						$b_pondera:=True:C214
					: ((f3_EX_INF_Presentacion=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // si examen inferior a Promedio final, Nota final=Promedio
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]Anual_Real:11
					: ((f2_EX_INF_Control=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // si examen inferior a Promedio final, Nota final=Examen
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
					: ((f4_EX_INF_Especifico=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // si examen inferior a Promedio final, Nota final=Valor Prefijado
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_EX_INF_Especifico
					: ((g3_EX_SUP_Presentacion=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // si examen superior a Promedio final, Nota final=Promedio
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]Anual_Real:11
					: ((g2_EX_SUP_Control=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // si examen superior a Promedio final, Nota final=Examen
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
					: ((g4_EX_SUP_Especifico=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=[Alumnos_Calificaciones:208]Anual_Real:11) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))  // si examen superior a Promedio final, Nota final=Valor Prefijado
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_EX_SUP_Especifico
				End case 
			: (e3_ResultadoFijo=1)
				Case of 
					: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vr_CalificacionEX)
						Case of 
							: (a1_NF_igualEX_SUP=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
							: (a2_NF_igualValorFijoSUP=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_NF_igual_EX_SUP
						End case 
					: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<vr_CalificacionEX)
						Case of 
							: (c1_NF_igualEX_INF=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
							: (c2_NF_igualValorFijoINF=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_NF_igual_EX_INF
						End case 
				End case 
		End case 
		
		If ((vi_EX_Reprobacion=1) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<rPctMinimum) & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>=vrNTA_MinimoEscalaReferencia))
			[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
			
			Case of 
				: (iEvaluationMode=Notas)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesDecNF)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
					
				: (iEvaluationMode=Puntos)
					[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
					[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]Anual_Puntos:13)
					
				: (iEvaluationMode=Simbolos)
					If (vi_ConvertSymbolicAverage=1)
						$t_simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
						[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Simbolo_a_Real ($t_simbolo)
					End if 
					
				: (iEvaluationMode=Porcentaje)
					If (vi_gTroncarNotaFinal=1)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Trunc:C95([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
					Else 
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
					End if 
			End case 
			$b_pondera:=False:C215
		End if 
		
		If ($b_pondera)
			$r_promedioPresentacion:=[Alumnos_Calificaciones:208]Anual_Real:11
			Case of 
				: (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_promedioPresentacion
					[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=$r_promedioPresentacion
				: ($r_promedioPresentacion>=vrNTA_MinimoEscalaReferencia)
					$r_examen:=Round:C94([Alumnos_Calificaciones:208]ExamenAnual_Real:16*$r_ponderacionExamen;11)
					$r_promedioPresentacion:=Round:C94($r_promedioPresentacion*$r_ponderacionPromedio;11)
					$r_RealFinal:=$r_promedioPresentacion+$r_examen
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_RealFinal
					[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=$r_RealFinal
				Else 
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
					[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
			End case 
			
			If (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_promedioPresentacion
				[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=$r_promedioPresentacion
			Else 
				If (vi_gTrEXNF=1)
					$r_PromedioAnual:=[Alumnos_Calificaciones:208]Anual_Real:11
					$r_Examen:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
					Case of 
						: (vi_ModoCalculoNF=0)
							[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=($r_Examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
						: (vi_ModoCalculoNF=1)
							[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;iGradesDec)+Round:C94($r_Examen*$r_ponderacionExamen;iGradesDec)
						: (vi_ModoCalculoNF=2)
							[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;iGradesDec)+Trunc:C95($r_Examen*$r_ponderacionExamen;iGradesDec)
					End case 
					
					Case of 
						: (iEvaluationMode=Notas)
							$r_NotaAnual:=EV2_Real_a_Nota ($r_PromedioAnual;0;iGradesDecPF)
							$r_NotaExamen:=EV2_Real_a_Nota ($r_Examen;0;iGradesDecPF)
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_NotaExamen*$r_ponderacionExamen)+($r_NotaAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_NotaAnual*$r_ponderacionPromedio;iGradesDec)+Round:C94($r_NotaExamen*$r_ponderacionExamen;iGradesDec)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_NotaAnual*$r_ponderacionPromedio;iGradesDec)+Trunc:C95($r_NotaExamen*$r_ponderacionExamen;iGradesDec)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_RealFinal)
							
						: (iEvaluationMode=Puntos)
							$r_PuntosAnual:=EV2_Real_a_Puntos ($r_PromedioAnual;0)
							$r_PuntosExamen:=EV2_Real_a_Puntos ($r_Examen;0)
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_PuntosExamen*$r_ponderacionExamen)+($r_PuntosAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_PuntosAnual*$r_ponderacionPromedio;iPointsDec)+Round:C94($r_PuntosExamen*$r_ponderacionExamen;iPointsDec)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_PuntosAnual*$r_ponderacionPromedio;iPointsDec)+Trunc:C95($r_PuntosExamen*$r_ponderacionExamen;iPointsDec)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_RealFinal)
							
						: (iEvaluationMode=Porcentaje)
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_Examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;1)+Round:C94($r_Examen*$r_ponderacionExamen;1)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;1)+Trunc:C95($r_Examen*$r_ponderacionExamen;1)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_RealFinal
							
						: (iEvaluationMode=Simbolos)
							$r_NotaAnual:=$r_PromedioAnual
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_Examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;1)+Round:C94($r_Examen*$r_ponderacionExamen;1)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;1)+Trunc:C95($r_Examen*$r_ponderacionExamen;1)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_RealFinal
							
					End case 
				End if 
				
				
			End if 
			
		End if 
	End if 
	
	If (vi_gTroncarNotaFinal=1)
		Case of 
			: (iEvaluationMode=Notas)
				$r_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesDecNF)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_Nota)
			: (iEvaluationMode=Puntos)
				$r_Puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_Puntos)  //MONO ticket 214665
		End case 
	End if 
	
	If ((vi_CorreccionNF_EX=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia))
		[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Choose:C955([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<vr_CorreccionNFEX_minimo;-10;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
		[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
	End if 
	
	
	
	  // EXAMEN EXTRAORDINARIO
	$b_pondera:=False:C215
	If ((vi_UsarExamenExtra=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=vrNTA_MinimoEscalaReferencia))
		Case of 
			: (x1_PonderacionConstante=1)
				$r_ponderacionExamen:=vr_EXX_PonderacionConstante/100
				$r_ponderacionPromedio:=(100-vr_EXX_PonderacionConstante)/100
				$b_pondera:=True:C214
				
			: (x2_PonderacionVariable=1)
				Case of 
					: ((y1_EXX_INF_Ponderado=1) & (vr_EXX_INF_Ponderacion>0) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21<[Alumnos_Calificaciones:208]Anual_Real:11))  // ponderación si examen inferior a Promedio final
						$r_ponderacionExamen:=vr_EXX_INF_Ponderacion/100
						$r_ponderacionPromedio:=(100-vr_EXX_INF_Ponderacion)/100
						$b_pondera:=True:C214
					: ((z1_EXX_SUP_Ponderado=1) & (vr_EXX_SUP_Ponderacion>0) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>[Alumnos_Calificaciones:208]Anual_Real:11))  // ponderación si examen superior a Promedio final
						$r_ponderacionExamen:=vr_EXX_SUP_Ponderacion/100
						$r_ponderacionPromedio:=(100-vr_EXX_SUP_Ponderacion)/100
						$b_pondera:=True:C214
					: ((y3_EXX_INF_Presentacion=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21<[Alumnos_Calificaciones:208]Anual_Real:11))  // si examen inferior a Promedio final, Nota final=Promedio
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]Anual_Real:11
					: ((y2_EXX_INF_Control=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21<[Alumnos_Calificaciones:208]Anual_Real:11))  // si examen inferior a Promedio final, Nota final=Examen
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
					: ((y4_EXX_INF_Especifico=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21<[Alumnos_Calificaciones:208]Anual_Real:11))  // si examen inferior a Promedio final, Nota final=Valor Prefijado
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_EXX_INF_Especifico
					: ((z3_EXX_SUP_Presentacion=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=[Alumnos_Calificaciones:208]Anual_Real:11))  // si examen superior a Promedio final, Nota final=Promedio
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]Anual_Real:11
					: ((z2_EXX_SUP_Control=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=[Alumnos_Calificaciones:208]Anual_Real:11))  // si examen superior a Promedio final, Nota final=Examen
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
					: ((z4_EXX_SUP_Especifico=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=[Alumnos_Calificaciones:208]Anual_Real:11))  // si examen superior a Promedio final, Nota final=Valor Prefijado
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_EXX_SUP_Especifico
				End case 
				
			: (x3_ResultadoFijo=1)
				Case of 
					: ([Alumnos_Calificaciones:208]ExamenExtra_Real:21>=vr_CalificacionEXX)
						Case of 
							: (m1_NF_igualEXX_SUP=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
							: (m2_NF_igualValorFijoSUP=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_NF_igual_EXX_SUP
						End case 
					: ([Alumnos_Calificaciones:208]ExamenExtra_Real:21<vr_CalificacionEXX)
						Case of 
							: (n1_NF_igualEXX_INF=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
							: (n2_NF_igualValorFijoINF=1)
								[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=vr_NF_igual_EXX_INF
						End case 
				End case 
		End case 
		
		If ((vi_EXX_Reprobacion=1) & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21<rPctMinimum))
			[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
			Case of 
				: (iEvaluationMode=Notas)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesdecNF)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
					
				: (iEvaluationMode=Puntos)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsdecNF)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28)
					
				: (iEvaluationMode=Simbolos)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
					If (vi_ConvertSymbolicAverage=1)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Simbolo_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29)
					End if 
					[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesdecNF)
					[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsdecNF)
					
				: (iEvaluationMode=Porcentaje)
					If (vi_gTroncarNotaFinal=1)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Trunc:C95([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
					Else 
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
					End if 
					[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesdecNF)
			End case 
			$b_pondera:=False:C215
		End if 
		
		If ($b_pondera)
			$r_promedioPresentacion:=[Alumnos_Calificaciones:208]Anual_Real:11
			Case of 
				: (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_promedioPresentacion
					[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=$r_promedioPresentacion
				: ($r_promedioPresentacion>=vrNTA_MinimoEscalaReferencia)
					$r_examen:=Round:C94([Alumnos_Calificaciones:208]ExamenExtra_Real:21*$r_ponderacionExamen;11)
					$r_promedioPresentacion:=Round:C94($r_promedioPresentacion*$r_ponderacionPromedio;11)
					$r_RealFinal:=$r_promedioPresentacion+$r_examen
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_RealFinal
					[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=$r_RealFinal
				Else 
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
					[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
			End case 
			
			If (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_promedioPresentacion
				[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=$r_promedioPresentacion
			Else 
				If (vi_gTrEXNF=1)
					$r_PromedioAnual:=[Alumnos_Calificaciones:208]Anual_Real:11
					$r_Examen:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
					Case of 
						: (vi_ModoCalculoNF=0)
							[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=($r_Examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
						: (vi_ModoCalculoNF=1)
							[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;iGradesDec)+Round:C94($r_Examen*$r_ponderacionExamen;iGradesDec)
						: (vi_ModoCalculoNF=2)
							[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;iGradesDec)+Trunc:C95($r_Examen*$r_ponderacionExamen;iGradesDec)
					End case 
					
					Case of 
						: (iEvaluationMode=Notas)
							$r_NotaAnual:=EV2_Real_a_Nota ($r_PromedioAnual;0)
							$r_NotaExamenExtra:=EV2_Real_a_Nota ($r_Examen;0)
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_NotaExamenExtra*$r_ponderacionExamen)+($r_NotaAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_NotaAnual*$r_ponderacionPromedio;iGradesDec)+Round:C94($r_NotaExamenExtra*$r_ponderacionExamen;iGradesDec)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_NotaAnual*$r_ponderacionPromedio;iGradesDec)+Trunc:C95($r_NotaExamenExtra*$r_ponderacionExamen;iGradesDec)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_RealFinal)
							
						: (iEvaluationMode=Puntos)
							$r_PuntosAnual:=EV2_Real_a_Puntos ($r_PromedioAnual;0)
							$r_PuntosExamenExtra:=EV2_Real_a_Puntos ($r_Examen;0)
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_PuntosExamenExtra*$r_ponderacionExamen)+($r_PuntosAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_PuntosAnual*$r_ponderacionPromedio;iPointsDec)+Round:C94($r_PuntosExamenExtra*$r_ponderacionExamen;iPointsDec)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_PuntosAnual*$r_ponderacionPromedio;iPointsDec)+Trunc:C95($r_PuntosExamenExtra*$r_ponderacionExamen;iPointsDec)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_RealFinal)
							
						: (iEvaluationMode=Porcentaje)
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_Examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;1)+Round:C94($r_Examen*$r_ponderacionExamen;1)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;1)+Trunc:C95($r_Examen*$r_ponderacionExamen;1)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_RealFinal
							
						: (iEvaluationMode=Simbolos)
							$r_NotaAnual:=$r_PromedioAnual
							$r_NotaExamenExtra:=$r_Examen
							Case of 
								: (vi_ModoCalculoNF=0)
									$r_RealFinal:=($r_Examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
								: (vi_ModoCalculoNF=1)
									$r_RealFinal:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;1)+Round:C94($r_Examen*$r_ponderacionExamen;1)
								: (vi_ModoCalculoNF=2)
									$r_RealFinal:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;1)+Trunc:C95($r_Examen*$r_ponderacionExamen;1)
							End case 
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_RealFinal
							
					End case 
					
				Else 
				End if 
			End if 
			
			If (vi_gTroncarNotaFinal=1)
				Case of 
					: (iEvaluationMode=Notas)
						$r_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_Nota)
					: (iEvaluationMode=Puntos)
						$r_Puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_Puntos)  //MONO ticket 214665
				End case 
			End if 
			
			If ((vi_CorreccionNF_EXX=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Choose:C955([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<vr_CorreccionNFEXX_minimo;vr_CorreccionNFEXX_resultado;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
			End if 
			
		Else 
			
		End if 
	End if 
	
	EV2_Calculos_AjusteFinal 
End if 