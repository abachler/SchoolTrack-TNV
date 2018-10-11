//%attributes = {}
  // Método: EV2_CalculoALT_PromedioFinal
  //
  //
  // por Alberto Bachler Klein
  // creación 13/07/17, 13:23:58
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($b_pondera)
C_LONGINT:C283($el;$l_decimales;$l_modoAlternativo)
C_POINTER:C301($y_campoALT_Anual;$y_campoALT_Examen;$y_campoALT_ExamenRecup;$y_campoALT_ExamenX;$y_campoALT_Final;$y_campoALT_FinalNoAprox;$y_campoALTAnual)
C_REAL:C285($r_examen;$r_Minimo;$r_MinimoEscalaReferencia;$r_NotaAnual;$r_NotaExamen;$r_NotaExamenExtra;$r_ponderacionExamen;$r_ponderacionPromedio;$r_PromedioAnual;$r_promedioPresentacion)
C_REAL:C285($r_PuntosAnual;$r_PuntosExamen;$r_PuntosExamenExtra;$r_PuntosExamenExtraamenExtra;$r_RealFinal)
C_TEXT:C284($t_simbolo)


Case of 
	: (iEvaluationMode=Notas)
		$l_modoAlternativo:=Puntos
		$l_decimales:=iPointsDecNF
		$y_campoALT_Anual:=->[Alumnos_Calificaciones:208]Anual_Puntos:13
		$y_campoALT_Final:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
		$y_campoALT_Examen:=->[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18
		$y_campoALT_ExamenX:=->[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23
		$y_campoALT_ExamenRecup:=->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97
		$y_arregloModoEvaluacion:=->arEVS_ConvPoints
		$r_Minimo:=rPointsMinimum
		$r_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;11)
		
	: (iEvaluationMode=Puntos)
		$l_modoAlternativo:=Notas
		$l_decimales:=iGradesDecNF
		$y_campoALT_Anual:=->[Alumnos_Calificaciones:208]Anual_Nota:12
		$y_campoALT_Final:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
		$y_campoALT_Examen:=->[Alumnos_Calificaciones:208]ExamenAnual_Nota:17
		$y_campoALT_ExamenX:=->[Alumnos_Calificaciones:208]ExamenExtra_Nota:22
		$y_campoALT_ExamenRecup:=->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96
		$y_arregloModoEvaluacion:=->arEVS_ConvGrades
		$r_Minimo:=rGradesMinimum
		$r_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;11)
End case 

EV2_Examenes_LeeConfigExamenes 

$y_campoALT_Final->:=$y_campoALT_Anual->



  // EXAMEN ANUAL NORMAL
$b_pondera:=False:C215
If ((vi_UsarExamenes=1) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))
	Case of 
		: ($y_campoALT_Examen-><$r_MinimoEscalaReferencia)
			  // nada
			
		: (e1_PonderacionConstante=1)
			$r_ponderacionExamen:=vr_EX_PonderacionConstante/100
			$r_ponderacionPromedio:=(100-vr_EX_PonderacionConstante)/100
			$b_pondera:=True:C214
		: (e2_PonderacionVariable=1)
			Case of 
				: ((f1_EX_INF_Ponderado=1) & (vr_EX_INF_Ponderacion>0) & ($y_campoALT_Examen-><$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // ponderación si examen inferior a Promedio final
					$r_ponderacionExamen:=vr_EX_INF_Ponderacion/100
					$r_ponderacionPromedio:=(100-vr_EX_INF_Ponderacion)/100
					$b_pondera:=True:C214
				: ((g1_EX_SUP_Ponderado=1) & (vr_EX_SUP_Ponderacion>0) & ($y_campoALT_Examen->>$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // ponderación si examen superior a Promedio final
					$r_ponderacionExamen:=vr_EX_SUP_Ponderacion/100
					$r_ponderacionPromedio:=(100-vr_EX_SUP_Ponderacion)/100
					$b_pondera:=True:C214
				: ((f3_EX_INF_Presentacion=1) & ($y_campoALT_Examen-><$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // si examen inferior a Promedio final, Nota final=Promedio
					$y_campoALT_Final->:=$y_campoALT_Anual->
				: ((f2_EX_INF_Control=1) & ($y_campoALT_Examen-><$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // si examen inferior a Promedio final, Nota final=Examen
					$y_campoALT_Final->:=$y_campoALT_Examen->
				: ((f4_EX_INF_Especifico=1) & ($y_campoALT_Examen-><$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // si examen inferior a Promedio final, Nota final=Valor Prefijado
					$y_campoALT_Final->:=vr_EX_INF_Especifico
				: ((g3_EX_SUP_Presentacion=1) & ($y_campoALT_Examen->>=$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // si examen superior a Promedio final, Nota final=Promedio
					$y_campoALT_Final->:=$y_campoALT_Anual->
				: ((g2_EX_SUP_Control=1) & ($y_campoALT_Examen->>=$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // si examen superior a Promedio final, Nota final=Examen
					$y_campoALT_Final->:=$y_campoALT_Examen->
				: ((g4_EX_SUP_Especifico=1) & ($y_campoALT_Examen->>=$y_campoALT_Anual->) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))  // si examen superior a Promedio final, Nota final=Valor Prefijado
					$y_campoALT_Final->:=vr_EX_SUP_Especifico
			End case 
		: (e3_ResultadoFijo=1)
			Case of 
				: ($y_campoALT_Examen->>=vr_CalificacionEX)
					Case of 
						: (a1_NF_igualEX_SUP=1)
							$y_campoALT_Final->:=$y_campoALT_Examen->
						: (a2_NF_igualValorFijoSUP=1)
							$y_campoALT_Final->:=vr_NF_igual_EX_SUP
					End case 
				: ($y_campoALT_Examen-><vr_CalificacionEX)
					Case of 
						: (c1_NF_igualEX_INF=1)
							$y_campoALT_Final->:=$y_campoALT_Examen->
						: (c2_NF_igualValorFijoINF=1)
							$y_campoALT_Final->:=vr_NF_igual_EX_INF
					End case 
			End case 
	End case 
	
	If ((vi_EX_Reprobacion=1) & ($y_campoALT_Examen-><rPctMinimum) & ($y_campoALT_Examen->>=$r_MinimoEscalaReferencia))
		$y_campoALT_Final->:=$y_campoALT_Examen->
		$b_pondera:=False:C215
	End if 
	
	If ($b_pondera)
		$r_promedioPresentacion:=$y_campoALT_Anual->
		Case of 
			: (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
				$y_campoALT_Final->:=$r_promedioPresentacion
			: ($r_promedioPresentacion>=$r_MinimoEscalaReferencia)
				$r_examen:=Round:C94($y_campoALT_Examen->*$r_ponderacionExamen;11)
				$r_promedioPresentacion:=Round:C94($r_promedioPresentacion*$r_ponderacionPromedio;11)
				$r_RealFinal:=$r_promedioPresentacion+$r_examen
				$y_campoALT_Final->:=$r_RealFinal
			Else 
				$y_campoALT_Final->:=$y_campoALT_Examen->
		End case 
		
		If (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
			$y_campoALT_Final->:=$r_promedioPresentacion
		Else 
			If (vi_gTrEXNF=1)
				$r_PromedioAnual:=$y_campoALT_Anual->
				$r_Examen:=$y_campoALT_Examen->
				
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
						$y_campoALT_Final->:=EV2_Nota_a_Real ($r_RealFinal)
						
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
						$y_campoALT_Final->:=EV2_Puntos_a_Real ($r_RealFinal)
						
					: (iEvaluationMode=Porcentaje)
						Case of 
							: (vi_ModoCalculoNF=0)
								$r_RealFinal:=($r_Examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
							: (vi_ModoCalculoNF=1)
								$r_RealFinal:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;1)+Round:C94($r_Examen*$r_ponderacionExamen;1)
							: (vi_ModoCalculoNF=2)
								$r_RealFinal:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;1)+Trunc:C95($r_Examen*$r_ponderacionExamen;1)
						End case 
						$y_campoALT_Final->:=$r_RealFinal
						
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
						$y_campoALT_Final->:=$r_RealFinal
						
				End case 
			End if 
			
			
		End if 
		
	End if 
End if 

If (vi_gTroncarNotaFinal=1)
	$y_campoALT_Final->:=Trunc:C95($y_campoALT_Final->;$l_decimales)
Else 
	$y_campoALT_Final->:=Round:C94($y_campoALT_Final->;$l_decimales)
End if 

If ((vi_CorreccionNF_EX=1) & ($y_campoALT_Final->>=$r_MinimoEscalaReferencia))
	$y_campoALT_Final->:=Choose:C955($y_campoALT_Final-><vr_CorreccionNFEX_minimo;-10;$y_campoALT_Final->)
End if 



  // EXAMEN EXTRAORDINARIO
$b_pondera:=False:C215
If ((vi_UsarExamenExtra=1) & ($y_campoALT_ExamenX->>=$r_MinimoEscalaReferencia))
	Case of 
		: (x1_PonderacionConstante=1)
			$r_ponderacionExamen:=vr_EXX_PonderacionConstante/100
			$r_ponderacionPromedio:=(100-vr_EXX_PonderacionConstante)/100
			$b_pondera:=True:C214
			
		: (x2_PonderacionVariable=1)
			Case of 
				: ((y1_EXX_INF_Ponderado=1) & (vr_EXX_INF_Ponderacion>0) & ($y_campoALT_ExamenX-><$y_campoALT_Anual->))  // ponderación si examen inferior a Promedio final
					$r_ponderacionExamen:=vr_EXX_INF_Ponderacion/100
					$r_ponderacionPromedio:=(100-vr_EXX_INF_Ponderacion)/100
					$b_pondera:=True:C214
				: ((z1_EXX_SUP_Ponderado=1) & (vr_EXX_SUP_Ponderacion>0) & ($y_campoALT_ExamenX->>$y_campoALT_Anual->))  // ponderación si examen superior a Promedio final
					$r_ponderacionExamen:=vr_EXX_SUP_Ponderacion/100
					$r_ponderacionPromedio:=(100-vr_EXX_SUP_Ponderacion)/100
					$b_pondera:=True:C214
				: ((y3_EXX_INF_Presentacion=1) & ($y_campoALT_ExamenX-><$y_campoALT_Anual->))  // si examen inferior a Promedio final, Nota final=Promedio
					$y_campoALT_Final->:=$y_campoALT_Anual->
				: ((y2_EXX_INF_Control=1) & ($y_campoALT_ExamenX-><$y_campoALT_Anual->))  // si examen inferior a Promedio final, Nota final=Examen
					$y_campoALT_Final->:=$y_campoALT_ExamenX->
				: ((y4_EXX_INF_Especifico=1) & ($y_campoALT_ExamenX-><$y_campoALT_Anual->))  // si examen inferior a Promedio final, Nota final=Valor Prefijado
					$y_campoALT_Final->:=vr_EXX_INF_Especifico
				: ((z3_EXX_SUP_Presentacion=1) & ($y_campoALT_ExamenX->>=$y_campoALT_Anual->))  // si examen superior a Promedio final, Nota final=Promedio
					$y_campoALT_Final->:=$y_campoALT_Anual->
				: ((z2_EXX_SUP_Control=1) & ($y_campoALT_ExamenX->>=$y_campoALT_Anual->))  // si examen superior a Promedio final, Nota final=Examen
					$y_campoALT_Final->:=$y_campoALT_ExamenX->
				: ((z4_EXX_SUP_Especifico=1) & ($y_campoALT_ExamenX->>=$y_campoALT_Anual->))  // si examen superior a Promedio final, Nota final=Valor Prefijado
					$y_campoALT_Final->:=vr_EXX_SUP_Especifico
			End case 
			
		: (x3_ResultadoFijo=1)
			Case of 
				: ($y_campoALT_ExamenX->>=vr_CalificacionEXX)
					Case of 
						: (m1_NF_igualEXX_SUP=1)
							$y_campoALT_Final->:=$y_campoALT_ExamenX->
						: (m2_NF_igualValorFijoSUP=1)
							$y_campoALT_Final->:=vr_NF_igual_EXX_SUP
					End case 
				: ($y_campoALT_ExamenX-><vr_CalificacionEXX)
					Case of 
						: (n1_NF_igualEXX_INF=1)
							$y_campoALT_Final->:=$y_campoALT_ExamenX->
						: (n2_NF_igualValorFijoINF=1)
							$y_campoALT_Final->:=vr_NF_igual_EXX_INF
					End case 
			End case 
	End case 
	
	If ((vi_EXX_Reprobacion=1) & ($y_campoALT_ExamenX-><rPctMinimum))
		$y_campoALT_Final->:=$y_campoALT_ExamenX->
		If (vi_gTroncarNotaFinal=1)
			$y_campoALT_Final->:=Trunc:C95($y_campoALT_Final->;$l_decimales)
			$b_pondera:=False:C215
		Else 
			$y_campoALT_Final->:=Round:C94($y_campoALT_Final->;$l_decimales)
		End if 
		
		If ($b_pondera)
			$r_promedioPresentacion:=$y_campoALT_Anual->
			Case of 
				: (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
					$y_campoALT_Final->:=$r_promedioPresentacion
				: ($r_promedioPresentacion>=$r_MinimoEscalaReferencia)
					$r_examen:=Round:C94($y_campoALT_ExamenX->*$r_ponderacionExamen;11)
					$r_promedioPresentacion:=Round:C94($r_promedioPresentacion*$r_ponderacionPromedio;11)
					$r_RealFinal:=$r_promedioPresentacion+$r_examen
					$y_campoALT_Final->:=$r_RealFinal
				Else 
					$y_campoALT_Final->:=$y_campoALT_ExamenX->
			End case 
			
			If (($r_promedioPresentacion=-2) | ($r_promedioPresentacion=-3))
				$y_campoALT_Final->:=$r_promedioPresentacion
			Else 
				If (vi_gTrEXNF=1)
					$r_PromedioAnual:=$y_campoALT_Anual->
					$r_Examen:=$y_campoALT_ExamenX->
					Case of 
						: (vi_ModoCalculoNF=0)
							$r_RealFinal:=($r_examen*$r_ponderacionExamen)+($r_PromedioAnual*$r_ponderacionPromedio)
						: (vi_ModoCalculoNF=1)
							$r_RealFinal:=Round:C94($r_PromedioAnual*$r_ponderacionPromedio;$l_decimales)+Round:C94($r_examen*$r_ponderacionExamen;$l_decimales)
						: (vi_ModoCalculoNF=2)
							$r_RealFinal:=Trunc:C95($r_PromedioAnual*$r_ponderacionPromedio;$l_decimales)+Trunc:C95($r_examen*$r_ponderacionExamen;$l_decimales)
					End case 
					
					
				Else 
				End if 
			End if 
			
			
			If (vi_gTroncarNotaFinal=14)
				$y_campoALT_Final->:=Trunc:C95($y_campoALT_Final->;$l_decimales)
				$b_pondera:=False:C215
			Else 
				$y_campoALT_Final->:=Round:C94($y_campoALT_Final->;$l_decimales)
			End if 
		End if 
		
		If ((vi_CorreccionNF_EXX=1) & ($y_campoALT_Final->>=$r_MinimoEscalaReferencia))
			$y_campoALT_Final->:=Choose:C955($y_campoALT_Final-><vr_CorreccionNFEXX_minimo;vr_CorreccionNFEXX_resultado;$y_campoALT_Final->)
		End if 
		
		
		RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
		Case of 
			: (($y_campoALT_Examen->=-10) | ($y_campoALT_ExamenX->=-10))
				KRL_ReloadInReadWriteMode (->[Alumnos_ComplementoEvaluacion:209])
				$y_campoALT_ExamenRecup->:=-10
				SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
				KRL_ReloadAsReadOnly (->[Alumnos_ComplementoEvaluacion:209])
		End case 
		
		If ($y_campoALT_ExamenRecup->>=rGradesFrom)
			$y_campoALT_Final->:=$y_campoALT_ExamenRecup->
		End if 
		
		
		  // ajuste final
		If ((vi_TruncarInferiorRequerido=1) & ($y_campoALT_Final-><rPctMinimum))
			$y_campoALT_Final->:=Trunc:C95($y_campoALT_Final->;$l_decimales)
		End if 
		
		If (vi_BonificarNotaFinalInterna=1)
			$el:=Find in array:C230($y_arregloModoEvaluacion->;$y_campoALTAnual->)
			If ($el>0)
				$y_campoALT_Final->:=$y_campoALT_Final->+arEVS_ConvGradesOfficial{$el}
			End if 
		End if 
		
	Else 
		
	End if 
End if 

