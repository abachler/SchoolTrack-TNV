//%attributes = {}
  // MƒTODO: EV2_Calculos_PromedioPeriodo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 20:59:20
  // ----------------------------------------------------
  // DESCRIPCION
  //
  //
  // PARÁMETROS
  // EV2_Calculos_PromedioPeriodo()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_conEximiciones;$b_conPonderaciones;$b_finalModificado;$b_pondera;$b_promedioPeriodoModificado)
C_LONGINT:C283($i;$l_indiceParcial;$l_indicePrimerParcial;$l_indiceUltimoParcial;$l_itemEncontrado;$l_ItemEsfuerzo;$l_numeroEvaluaciones;$l_periodo;$l_recNumAsignatura;$l_recNumCalificaciones)
C_POINTER:C301($y_BonificacionLiteral;$y_BonificacionNota;$y_BonificacionPuntos;$y_BonificacionReal;$y_BonificacionSimbolo;$y_Control_Literal;$y_Control_Nota;$y_Control_Puntos;$y_Control_Real;$y_Control_Simbolo)
C_POINTER:C301($y_Esfuerzo;$y_Final_Literal;$y_Final_Nota;$y_Final_Puntos;$y_Final_Real;$y_Final_Simbolo;$y_FinalNoAproximado;$y_Presentacion_Literal;$y_Presentacion_Nota;$y_Presentacion_Puntos)
C_POINTER:C301($y_Presentacion_Real;$y_Presentacion_Simbolo)
C_REAL:C285($r_BonificacionEsfuerzo;$r_bonificacionReal;$r_coeficiente;$r_controlPeriodo;$r_divisor;$r_evaluacionParcial;$r_evaluacionPonderada;$r_factorEsfuerzo;$r_finalPeriodo;$r_Nota)
C_REAL:C285($r_ponderacion;$r_ponderacionBonificacion;$r_ponderacionControl;$r_ponderacionesAcumuladas;$r_ponderacionPeriodo;$r_ponderacionPresentacion;$r_presentacionReal;$r_promedioPeriodo;$r_PromedioPresentacion;$r_puntos)
C_REAL:C285($r_suma)
C_TEXT:C284($t_motivoParaNoCalcular;$t_simbolo)



If (False:C215)
	C_BOOLEAN:C305(EV2_Calculos_PromedioPeriodo ;$0)
	C_LONGINT:C283(EV2_Calculos_PromedioPeriodo ;$1)
	C_LONGINT:C283(EV2_Calculos_PromedioPeriodo ;$2)
	C_BOOLEAN:C305(EV2_Calculos_PromedioPeriodo ;$3)
End if 

C_BOOLEAN:C305(vb_RecalcularTodo)




  // CODIGO PRINCIPAL
$l_recNumCalificaciones:=$1
$l_periodo:=$2


OK:=1
  //asignaci—n de campos a punteros segœn per’odos
Case of 
	: ($l_periodo=1)
		$y_Presentacion_Real:=->[Alumnos_Calificaciones:208]P01_Presentacion_Real:102
		$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103
		$y_Presentacion_Puntos:=->[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104
		$y_Presentacion_Simbolo:=->[Alumnos_Calificaciones:208]P01_Presentacion_Simbolo:105
		$y_Presentacion_Literal:=->[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106
		$y_Final_Real:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
		$y_Final_Nota:=->[Alumnos_Calificaciones:208]P01_Final_Nota:113
		$y_Final_Puntos:=->[Alumnos_Calificaciones:208]P01_Final_Puntos:114
		$y_Final_Simbolo:=->[Alumnos_Calificaciones:208]P01_Final_Simbolo:115
		$y_Final_Literal:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
		$y_Control_Real:=->[Alumnos_Calificaciones:208]P01_Control_Real:107
		$y_Control_Nota:=->[Alumnos_Calificaciones:208]P01_Control_Nota:108
		$y_Control_Puntos:=->[Alumnos_Calificaciones:208]P01_Control_Puntos:109
		$y_Control_Simbolo:=->[Alumnos_Calificaciones:208]P01_Control_Simbolo:110
		$y_Control_Literal:=->[Alumnos_Calificaciones:208]P01_Control_Literal:111
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Real:510
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Nota:511
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Puntos:512
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Simbolo:513
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
		$l_indicePrimerParcial:=42
		$l_indiceUltimoParcial:=97
		
	: ($l_periodo=2)
		$y_Presentacion_Real:=->[Alumnos_Calificaciones:208]P02_Presentacion_Real:177
		$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178
		$y_Presentacion_Puntos:=->[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179
		$y_Presentacion_Simbolo:=->[Alumnos_Calificaciones:208]P02_Presentacion_Simbolo:180
		$y_Presentacion_Literal:=->[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181
		$y_Final_Real:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
		$y_Final_Nota:=->[Alumnos_Calificaciones:208]P02_Final_Nota:188
		$y_Final_Puntos:=->[Alumnos_Calificaciones:208]P02_Final_Puntos:189
		$y_Final_Simbolo:=->[Alumnos_Calificaciones:208]P02_Final_Simbolo:190
		$y_Final_Literal:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
		$y_Control_Real:=->[Alumnos_Calificaciones:208]P02_Control_Real:182
		$y_Control_Nota:=->[Alumnos_Calificaciones:208]P02_Control_Nota:183
		$y_Control_Puntos:=->[Alumnos_Calificaciones:208]P02_Control_Puntos:184
		$y_Control_Simbolo:=->[Alumnos_Calificaciones:208]P02_Control_Simbolo:185
		$y_Control_Literal:=->[Alumnos_Calificaciones:208]P02_Control_Literal:186
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Real:515
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Nota:516
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Puntos:517
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Simbolo:518
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
		$l_indicePrimerParcial:=117
		$l_indiceUltimoParcial:=172
		
	: ($l_periodo=3)
		$y_Presentacion_Real:=->[Alumnos_Calificaciones:208]P03_Presentacion_Real:252
		$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253
		$y_Presentacion_Puntos:=->[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254
		$y_Presentacion_Simbolo:=->[Alumnos_Calificaciones:208]P03_Presentacion_Simbolo:255
		$y_Presentacion_Literal:=->[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256
		$y_Final_Real:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
		$y_Final_Nota:=->[Alumnos_Calificaciones:208]P03_Final_Nota:263
		$y_Final_Puntos:=->[Alumnos_Calificaciones:208]P03_Final_Puntos:264
		$y_Final_Simbolo:=->[Alumnos_Calificaciones:208]P03_Final_Simbolo:265
		$y_Final_Literal:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
		$y_Control_Real:=->[Alumnos_Calificaciones:208]P03_Control_Real:257
		$y_Control_Nota:=->[Alumnos_Calificaciones:208]P03_Control_Nota:258
		$y_Control_Puntos:=->[Alumnos_Calificaciones:208]P03_Control_Puntos:259
		$y_Control_Simbolo:=->[Alumnos_Calificaciones:208]P03_Control_Simbolo:260
		$y_Control_Literal:=->[Alumnos_Calificaciones:208]P03_Control_Literal:261
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Real:520
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Nota:521
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Puntos:522
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Simbolo:523
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
		$l_indicePrimerParcial:=192
		$l_indiceUltimoParcial:=247
		
	: ($l_periodo=4)
		$y_Presentacion_Real:=->[Alumnos_Calificaciones:208]P04_Presentacion_Real:327
		$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328
		$y_Presentacion_Puntos:=->[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329
		$y_Presentacion_Simbolo:=->[Alumnos_Calificaciones:208]P04_Presentacion_Simbolo:330
		$y_Presentacion_Literal:=->[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331
		$y_Final_Real:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
		$y_Final_Nota:=->[Alumnos_Calificaciones:208]P04_Final_Nota:338
		$y_Final_Puntos:=->[Alumnos_Calificaciones:208]P04_Final_Puntos:339
		$y_Final_Simbolo:=->[Alumnos_Calificaciones:208]P04_Final_Simbolo:340
		$y_Final_Literal:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
		$y_Control_Real:=->[Alumnos_Calificaciones:208]P04_Control_Real:332
		$y_Control_Nota:=->[Alumnos_Calificaciones:208]P04_Control_Nota:333
		$y_Control_Puntos:=->[Alumnos_Calificaciones:208]P04_Control_Puntos:334
		$y_Control_Simbolo:=->[Alumnos_Calificaciones:208]P04_Control_Simbolo:335
		$y_Control_Literal:=->[Alumnos_Calificaciones:208]P04_Control_Literal:336
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Real:525
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Nota:526
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Puntos:527
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Simbolo:528
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
		$l_indicePrimerParcial:=267
		$l_indiceUltimoParcial:=322
		
	: ($l_periodo=5)
		$y_Presentacion_Real:=->[Alumnos_Calificaciones:208]P05_Presentacion_Real:402
		$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403
		$y_Presentacion_Puntos:=->[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404
		$y_Presentacion_Simbolo:=->[Alumnos_Calificaciones:208]P05_Presentacion_Simbolo:405
		$y_Presentacion_Literal:=->[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406
		$y_Final_Real:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
		$y_Final_Nota:=->[Alumnos_Calificaciones:208]P05_Final_Nota:413
		$y_Final_Puntos:=->[Alumnos_Calificaciones:208]P05_Final_Puntos:414
		$y_Final_Simbolo:=->[Alumnos_Calificaciones:208]P05_Final_Simbolo:415
		$y_Final_Literal:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
		$y_Control_Real:=->[Alumnos_Calificaciones:208]P05_Control_Real:407
		$y_Control_Nota:=->[Alumnos_Calificaciones:208]P05_Control_Nota:408
		$y_Control_Puntos:=->[Alumnos_Calificaciones:208]P05_Control_Puntos:409
		$y_Control_Simbolo:=->[Alumnos_Calificaciones:208]P05_Control_Simbolo:410
		$y_Control_Literal:=->[Alumnos_Calificaciones:208]P05_Control_Literal:411
		$y_BonificacionReal:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Real:530
		$y_BonificacionNota:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Nota:531
		$y_BonificacionPuntos:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Puntos:532
		$y_BonificacionSimbolo:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Simbolo:533
		$y_BonificacionLiteral:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534
		$y_FinalNoAproximado:=->[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500
		$y_Esfuerzo:=->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
		$l_indicePrimerParcial:=342
		$l_indiceUltimoParcial:=397
		
End case 

If (OK=1)
	READ WRITE:C146([Alumnos_Calificaciones:208])
	RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
	If ([Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8#0)
		If (($y_Final_Real->#-3) | ($y_Final_Nota->#-3) | ($y_Final_Puntos->#-3) | ($y_Final_Simbolo->#"X") | ($y_Final_Literal->#"X"))
			$b_promedioPeriodoModificado:=True:C214
		End if 
		$y_FinalNoAproximado->:=-3
		$y_Presentacion_Real->:=-3
		$y_Presentacion_Nota->:=-3
		$y_Presentacion_Puntos->:=-3
		$y_Presentacion_Simbolo->:="X"
		$y_Presentacion_Literal->:="X"
		$y_Final_Real->:=-3
		$y_Final_Nota->:=-3
		$y_Final_Puntos->:=-3
		$y_Final_Simbolo->:="X"
		$y_Final_Literal->:="X"
	Else 
		
		  // //si la asignatura es distinta de la cargada se carga y se leen las propiedades de evaluacion
		  //If (([Alumnos_Calificaciones]ID_Asignatura#[Asignaturas]Numero)Ê|Ê($l_periodo#viSTR_PeriodoActual_Numero))
		If ([Alumnos_Calificaciones:208]ID_Asignatura:5#[Asignaturas:18]Numero:1)
			$l_recNumAsignatura:=Find in field:C653([Asignaturas:18]Numero:1;[Alumnos_Calificaciones:208]ID_Asignatura:5)
			KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura)
			If (OK=1)
				AS_PropEval_Lectura ("";$l_periodo)
			Else 
				TRACE:C157
				  //error, la asignatura no existe
			End if 
		End if 
		
		If (Not:C34([Asignaturas:18]Consolidacion_EsConsolidante:35))
			$b_conPonderaciones:=(AT_GetSumArray (->arAS_EvalPropPercent)>0)
			If ($b_conPonderaciones)
				$r_ponderacionesAcumuladas:=0
				$r_suma:=0
				$l_numeroEvaluaciones:=0
				$t_motivoParaNoCalcular:=""
				$b_conEximiciones:=False:C215
				$l_indiceParcial:=0
				For ($i;$l_indicePrimerParcial;$l_indiceUltimoParcial;5)
					$l_indiceParcial:=$l_indiceParcial+1
					$r_evaluacionParcial:=Field:C253(208;$i)->
					Case of 
						: ($r_evaluacionParcial=-4)
							  //ignorar
						: ($r_evaluacionParcial=-2)
							$t_motivoParaNoCalcular:="Pendiente"
							$i:=$l_indiceUltimoParcial  //salimos de la bucle
						: ($r_evaluacionParcial=-1)
							  //ignorar
						: ($r_evaluacionParcial=-3)
							$b_conEximiciones:=True:C214
							If ([Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8#0)
								$t_motivoParaNoCalcular:="Eximido"
								$i:=$l_indiceUltimoParcial  //salimos de la bucle
							End if 
							
						: ($r_evaluacionParcial>=vrNTA_MinimoEscalaReferencia)
							$l_numeroEvaluaciones:=$l_numeroEvaluaciones+1
							$l_itemEncontrado:=Find in array:C230(aiAS_EvalPropColumnIndex;$l_indiceParcial)
							If (($l_itemEncontrado>0) & (arAS_EvalPropPercent{$l_itemEncontrado}>0))
								$r_ponderacion:=arAS_EvalPropPercent{$l_itemEncontrado}
								$r_ponderacionesAcumuladas:=$r_ponderacionesAcumuladas+$r_ponderacion
								$r_evaluacionPonderada:=EV2_PonderaEvaluacion ($r_evaluacionParcial;$r_ponderacion)
								If ($r_evaluacionPonderada>=0)  //20180502 ASM Ticket 204996
									$r_suma:=Round:C94($r_suma+$r_evaluacionPonderada;11)
								End if 
							End if 
					End case 
				End for 
				If (($l_numeroEvaluaciones>0) & ($r_ponderacionesAcumuladas>0))
					$r_suma:=Round:C94($r_suma/$r_ponderacionesAcumuladas*100;11)
					If (($r_suma<vrNTA_MinimoEscalaReferencia) & ($r_ponderacionesAcumuladas>0))
						$r_suma:=vrNTA_MinimoEscalaReferencia
					End if 
				End if 
				
			Else 
				  // // Calculo de promedios sin ponderaciones
				$r_divisor:=0
				$r_suma:=0
				$l_numeroEvaluaciones:=0
				$t_motivoParaNoCalcular:=""
				$b_conEximiciones:=False:C215
				$l_indiceParcial:=0
				For ($i;$l_indicePrimerParcial;$l_indiceUltimoParcial;5)
					$l_indiceParcial:=$l_indiceParcial+1
					$r_evaluacionParcial:=Round:C94(Field:C253(208;$i)->;11)
					Case of 
						: ($r_evaluacionParcial=-4)
							  //ignorar
						: ($r_evaluacionParcial=-2)
							$t_motivoParaNoCalcular:="Pendiente"
							$i:=$l_indiceUltimoParcial  //salimos de la bucle
						: ($r_evaluacionParcial=-1)
							  //ignorar
						: ($r_evaluacionParcial=-3)
							$b_conEximiciones:=True:C214
							If ([Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8#0)
								$t_motivoParaNoCalcular:="Eximido"
								$i:=$l_indiceUltimoParcial  //salimos de la bucle
							End if 
							
						: ($r_evaluacionParcial>=vrNTA_MinimoEscalaReferencia)
							$l_numeroEvaluaciones:=$l_numeroEvaluaciones+1
							$l_itemEncontrado:=Find in array:C230(aiAS_EvalPropColumnIndex;$l_indiceParcial)
							If (($l_itemEncontrado>0) & ($l_itemEncontrado<=Size of array:C274(arAS_EvalPropCoefficient)))
								$r_coeficiente:=arAS_EvalPropCoefficient{$l_itemEncontrado}
							Else 
								$r_coeficiente:=1
							End if 
							If ($r_evaluacionParcial>=vrNTA_MinimoEscalaReferencia)
								$r_suma:=Round:C94($r_suma+Round:C94($r_evaluacionParcial*$r_coeficiente;11);11)
								$r_divisor:=$r_divisor+(1*$r_coeficiente)
							End if 
					End case 
				End for 
			End if 
			
			  //inicializaci—n a valor nulo (-10)
			$y_FinalNoAproximado->:=-10
			$y_Presentacion_Real->:=-10
			$y_Presentacion_Nota->:=-10
			$y_Presentacion_Puntos->:=-10
			$y_Presentacion_Simbolo->:=""
			$y_Presentacion_Literal->:=""
			$y_Final_Real->:=-10
			$y_Final_Nota->:=-10
			$y_Final_Puntos->:=-10
			$y_Final_Simbolo->:=""
			$y_Final_Literal->:=""
			
			Case of 
				: ($t_motivoParaNoCalcular="Pendiente")
					$y_FinalNoAproximado->:=-2
					$y_Presentacion_Real->:=-2
					$y_Presentacion_Nota->:=-2
					$y_Presentacion_Puntos->:=-2
					$y_Presentacion_Simbolo->:="P"
					$y_Presentacion_Literal->:="P"
					$y_Final_Real->:=-2
					$y_Final_Nota->:=-2
					$y_Final_Puntos->:=-2
					$y_Final_Simbolo->:="P"
					$y_Final_Literal->:="P"
					
				: (($t_motivoParaNoCalcular="Eximido") | (($b_conEximiciones) & ($l_numeroEvaluaciones=0)))
					$y_FinalNoAproximado->:=-10
					$y_Presentacion_Real->:=-3
					$y_Presentacion_Nota->:=-3
					$y_Presentacion_Puntos->:=-3
					$y_Presentacion_Simbolo->:="X"
					$y_Presentacion_Literal->:="X"
					$y_Final_Real->:=-3
					$y_Final_Nota->:=-3
					$y_Final_Puntos->:=-3
					$y_Final_Simbolo->:="X"
					$y_Final_Literal->:="X"
					
				: ((($t_motivoParaNoCalcular="") & ($l_numeroEvaluaciones>0)) | (($t_motivoParaNoCalcular="") & ($y_Control_Real->>=vrNTA_MinimoEscalaReferencia)))
					  //calculo del PROMEDIO DE PRESENTACION al EXAMEN DE FIN DE PERIODO
					
					Case of 
						: ($l_numeroEvaluaciones=0)
							$y_Presentacion_Real->:=-10
							
						: ($r_ponderacionesAcumuladas>0)
							$y_Presentacion_Real->:=Choose:C955($r_suma<=100;$r_suma;100)
							
						: ((iResults=1) & ($r_suma>=vrNTA_MinimoEscalaReferencia))  // presentacion examen calculado con promedio
							If ($r_divisor>0)
								$y_Presentacion_Real->:=Round:C94($r_suma/$r_divisor;11)
							Else 
								$y_Presentacion_Real->:=$r_suma
							End if 
						: ((iResults=2) & ($r_suma>=vrNTA_MinimoEscalaReferencia) & ($r_suma<=100))  //presentacion examen calculado con suma de calificaciones
							$y_Presentacion_Real->:=$r_suma
							
						: ((iResults=2) & ($r_suma>=vrNTA_MinimoEscalaReferencia) & ($r_suma>100))  //presentacion examen calculado con suma de calificaciones. Si la suma es superior a 100 el resultado es 100, no puede superior al 100% de la escala)
							$y_Presentacion_Real->:=100
							
					End case 
					
					$y_Presentacion_Real->:=Choose:C955($y_Presentacion_Real->>100;100;$y_Presentacion_Real->)
			End case 
			
			EV2_Calculos_FinalPeriodo ($l_periodo)
			
			
			$b_promedioPeriodoModificado:=EV2_PromediosModificados ($l_periodo)
			$b_promedioPeriodoModificado:=$b_promedioPeriodoModificado | vb_RecalcularTodo
			
		Else 
			$b_promedioPeriodoModificado:=EV2_Calculos_ConsolidaPeriodo ($l_recNumCalificaciones;$l_periodo;False:C215)
			$b_promedioPeriodoModificado:=$b_promedioPeriodoModificado | vb_RecalcularTodo
			
		End if 
		
	End if 
	
	$0:=$b_promedioPeriodoModificado
	
	
Else 
	TRACE:C157
	  //error, registro de evaluaciones inexistente
End if 

