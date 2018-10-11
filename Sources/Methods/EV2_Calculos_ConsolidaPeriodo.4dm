//%attributes = {}
  // EV2_Calculos_ConsolidaPeriodo()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachlerassev
  // Fecha: 06/12/12, 11:40:18
  // ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_calcularPromedioFinal;$b_conCoeficientes;$b_conEximiciones;$b_conPonderaciones;$b_finalesModificados;$b_NotaPresentacionCalculada;$b_pondera;$b_promedioPeriodoModificado;$terminarCalculo)
C_LONGINT:C283($estiloEvaluacion;$i;$i_parcial;$i_parcialSubAsignatura;$l_año;$l_divAsignatura;$l_IdAlumno;$l_IdAsignaturaConsolidante;$l_IdInstitucion;$l_ItemEncontrado)
C_LONGINT:C283($l_ItemEsfuerzo;$l_MetodoConsolidacion;$l_nivelNumero;$l_numeroCampoCalificacion;$l_numeroEvaluaciones;$l_Periodo;$l_primerParcial;$l_recNumAsignatura;$l_recNumCalificaciones;$l_recNumCalificacionesHija)
C_LONGINT:C283($l_recNumSubasignatura;$l_ultimoParcial)
C_POINTER:C301($y_BonificacionLiteral;$y_BonificacionNota;$y_BonificacionPuntos;$y_BonificacionReal;$y_BonificacionSimbolo;$y_campoLiteral;$y_campoNota;$y_campoPuntos;$y_campoSimbolo;$y_Control_Literal)
C_POINTER:C301($y_Control_Nota;$y_Control_Puntos;$y_Control_Real;$y_Control_Simbolo;$y_Esfuerzo;$y_Final_Literal;$y_Final_Nota;$y_Final_Puntos;$y_Final_Real;$y_Final_Simbolo)
C_POINTER:C301($y_FinalNoAproximado;$y_Presentacion_Literal;$y_Presentacion_Nota;$y_Presentacion_Puntos;$y_Presentacion_Real;$y_Presentacion_Simbolo)
C_REAL:C285($r_BonificacionEsfuerzo;$r_bonificacionReal;$r_coeficiente;$r_controlPeriodo;$r_divisor;$r_evaluacion;$r_evaluacionPonderada;$r_factorEsfuerzo;$r_finalPeriodo;$r_nota)
C_REAL:C285($r_Ponderacion;$r_ponderacionBonificacion;$r_ponderacionControl;$r_ponderacionesAcumuladas;$r_ponderacionPeriodo;$r_PonderacionPresentacion;$r_presentacionReal;$r_PromedioPeriodo;$r_Puntos;$r_sumaCalificaciones)
C_REAL:C285($r_sumaCoeficientes;$r_sumaPonderaciones;$r_sumAsignatura)
C_TEXT:C284($t_IdInstitucion;$t_llaveAsignaturaHija;$t_motivoParaNoCalcular;$t_simbolo)

ARRAY LONGINT:C221($alAS_EvalPropSourceID;0)
ARRAY REAL:C219($arAS_EvalPropCoefficient;0)
ARRAY REAL:C219($arAS_EvalPropPercent;0)

If (False:C215)
	C_BOOLEAN:C305(EV2_Calculos_ConsolidaPeriodo ;$0)
	C_LONGINT:C283(EV2_Calculos_ConsolidaPeriodo ;$1)
	C_LONGINT:C283(EV2_Calculos_ConsolidaPeriodo ;$2)
	C_BOOLEAN:C305(EV2_Calculos_ConsolidaPeriodo ;$3)
End if 

C_BOOLEAN:C305(vb_RecalcularTodo)

C_LONGINT:C283(vlEVS_CurrentEvStyleID;vlSTR_Periodos_CurrentRef)

$l_recNumCalificaciones:=$1
$l_Periodo:=$2
$b_calcularPromedioFinal:=True:C214


  // CODIGO PRINCIPAL
KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones;True:C214)

If (OK=1)
	$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
	$b_calcularPromedioFinal:=AS_PromediosSonCalculados ([Alumnos_Calificaciones:208]ID_Asignatura:5)
	$l_IdInstitucion:=[Alumnos_Calificaciones:208]ID_institucion:2
	$l_año:=[Alumnos_Calificaciones:208]Año:3
	$l_IdAsignaturaConsolidante:=[Alumnos_Calificaciones:208]ID_Asignatura:5
	$l_IdAlumno:=[Alumnos_Calificaciones:208]ID_Alumno:6
	$l_nivelNumero:=[Alumnos_Calificaciones:208]NIvel_Numero:4
	$b_conEximiciones:=False:C215
	$l_numeroEvaluaciones:=0
	
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
			
	End case 
	
	If ((vlSTR_Periodos_CurrentRef=0) | (Type:C295(vlSTR_Periodos_CurrentRef)=Is undefined:K8:13))
		PERIODOS_Init   //si el método se ejecuta en un nuevo proceso inicializo el componente de períodos
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	End if 
	
	  // // si el estilo de evaluación no esta cargado se lee el numero de estilo en la Asignatura y se carga
	$estiloEvaluacion:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
	If ((vlEVS_CurrentEvStyleID=0) | (Type:C295(vlEVS_CurrentEvStyleID)=Is undefined:K8:13))
		EVS_LoadStyles   //si el m?todo se ejecuta en un nuevo proceso inicializo variables y arreglos para estilos de evaluaciÑn
	End if 
	EVS_ReadStyleData ($estiloEvaluacion)
	  // //
	
	OK:=1
	If (OK=1)
		READ WRITE:C146([Alumnos_Calificaciones:208])
		RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
		If ([Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8#0)
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
			AS_PropEval_Lectura ("";$l_Periodo)
			  // Copio arreglos y variables de las propiedades de evaluaciÑn de la asignatura madre que son necesarios para los calculos,
			  // conservando sus valores cuando se necesario leer las propiedades de asignaturas hijas
			COPY ARRAY:C226(alAS_EvalPropSourceID;$alAS_EvalPropSourceID)
			COPY ARRAY:C226(arAS_EvalPropPercent;$arAS_EvalPropPercent)
			COPY ARRAY:C226(arAS_EvalPropCoefficient;$arAS_EvalPropCoefficient)
			$l_MetodoConsolidacion:=[Asignaturas:18]Consolidacion_Metodo:55
			$r_sumaPonderaciones:=AT_GetSumArray (->arAS_EvalPropPercent)
			$b_conPonderaciones:=($r_sumaPonderaciones>0)
			$r_sumaCoeficientes:=AT_GetSumArray (->arAS_EvalPropCoefficient)
			If (($r_sumaCoeficientes#12) & ($r_sumaCoeficientes>0))
				$b_conCoeficientes:=True:C214
			End if 
			  //
			
			$r_sumaCalificaciones:=0
			$r_divisor:=0
			$r_ponderacionesAcumuladas:=0
			
			Case of 
				: ($l_Periodo=1)
					$l_numeroCampoCalificacion:=42
				: ($l_Periodo=2)
					$l_numeroCampoCalificacion:=117
				: ($l_Periodo=3)
					$l_numeroCampoCalificacion:=192
				: ($l_Periodo=4)
					$l_numeroCampoCalificacion:=267
				: ($l_Periodo=5)
					$l_numeroCampoCalificacion:=342
			End case 
			
			ARRAY REAL:C219($ar_ParcialesActuales;12)
			For ($i_parcial;1;Size of array:C274($ar_ParcialesActuales))
				$ar_ParcialesActuales{$i_parcial}:=Field:C253(208;$l_numeroCampoCalificacion)->
				$l_numeroCampoCalificacion:=$l_numeroCampoCalificacion+5
			End for 
			
			
			
			Case of 
				: (($l_MetodoConsolidacion=1) | ($l_MetodoConsolidacion=0))  //recalculo de promedios sin aproximaciÑn ni troncatura
					Case of 
						: ($l_Periodo=1)
							$l_numeroCampoCalificacion:=42
						: ($l_Periodo=2)
							$l_numeroCampoCalificacion:=117
						: ($l_Periodo=3)
							$l_numeroCampoCalificacion:=192
						: ($l_Periodo=4)
							$l_numeroCampoCalificacion:=267
						: ($l_Periodo=5)
							$l_numeroCampoCalificacion:=342
					End case 
					
					$terminarCalculo:=False:C215
					For ($i_parcial;1;Size of array:C274($alAS_EvalPropSourceID))
						$r_coeficiente:=1
						$r_evaluacion:=-10
						Case of 
							: ($b_conPonderaciones)
								$r_Ponderacion:=$arAS_EvalPropPercent{$i_parcial}
							: ($b_conCoeficientes)
								$r_coeficiente:=$arAS_EvalPropCoefficient{$i_parcial}
							Else 
								$r_Ponderacion:=0
								$r_coeficiente:=0
						End case 
						
						Case of 
							: ($alAS_EvalPropSourceID{$i_parcial}>0)  //asignaturas hijas
								$t_llaveAsignaturaHija:=String:C10($l_IdInstitucion)+"."+String:C10($l_año)+"."+String:C10($l_nivelNumero)+"."+String:C10($alAS_EvalPropSourceID{$i_parcial})+"."+String:C10($l_IdAlumno)
								
								$l_recNumCalificacionesHija:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveAsignaturaHija)
								If (OK=1)
									If ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? $l_Periodo)  //solo calculo si hay evaluaciones en el perÕodo
										RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
										EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
										Case of 
											: ($l_MetodoConsolidacion=2)
												$r_evaluacion:=$y_Final_Real->
											: ($l_MetodoConsolidacion=1)
												$r_evaluacion:=$y_FinalNoAproximado->
											: ($l_MetodoConsolidacion=0)
												$r_evaluacion:=$y_Final_Real->
										End case 
										Case of 
											: ($r_evaluacion=-3)
												$B_conEximiciones:=True:C214
											: ($r_evaluacion=-2)  //$terminarCalculo:=Trueææ`hay evaluaciones pendientes, se aborta el calculo
												$r_sumaCalificaciones:=-2
												
											: ($r_evaluacion>=vrNTA_MinimoEscalaReferencia)
												$l_numeroEvaluaciones:=$l_numeroEvaluaciones+1
												Case of 
													: ($b_conPonderaciones)
														$r_evaluacionPonderada:=EV2_PonderaEvaluacion ($r_evaluacion;$r_Ponderacion)
														If ($r_evaluacionPonderada>=0)
															$r_sumaCalificaciones:=$r_sumaCalificaciones+$r_evaluacionPonderada
														End if 
														$r_ponderacionesAcumuladas:=$r_ponderacionesAcumuladas+$r_Ponderacion
													: ($b_conCoeficientes)
														$r_sumaCalificaciones:=$r_sumaCalificaciones+Round:C94($r_evaluacion*$r_coeficiente;11)
														$r_divisor:=$r_divisor+$r_coeficiente
													Else 
														$r_sumaCalificaciones:=Round:C94($r_sumaCalificaciones+$r_evaluacion;11)
														$r_divisor:=$r_divisor+1
												End case 
											Else 
												  //si no hay calificaciones o el alumno està eximido de la asignatura se ignoran los valores
										End case 
									End if 
								End if 
								$ar_ParcialesActuales{$i_parcial}:=$r_evaluacion
								
							: ($alAS_EvalPropSourceID{$i_parcial}<0)  //subasignaturas
								$r_evaluacionEnMadre:=$ar_ParcialesActuales{$i_parcial}
								EVS_ReadStyleData ($estiloEvaluacion)
								$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ($l_IdAsignaturaConsolidante;$l_Periodo;$i_parcial;False:C215)
								$r_evaluacion:=-10
								If ($l_recNumSubasignatura>=0)
									$l_ItemEncontrado:=Find in array:C230(aSubEvalID;$l_IdAlumno)
									If ($l_ItemEncontrado>0)
										AT_Initialize (->aSubEvalP1;->aSubEvalPresentacion)
										ARRAY TEXT:C222(aSubEvalP1;Size of array:C274(aSubEvalID))
										ARRAY TEXT:C222(aSubEvalPresentacion;Size of array:C274(aSubEvalID))
										If ((aRealSubEvalP1{$l_ItemEncontrado}=-10) & ($r_evaluacionEnMadre#aRealSubEvalP1{$l_ItemEncontrado}))
											aRealSubEvalP1{$l_ItemEncontrado}:=$r_evaluacionEnMadre
											aRealSubEval1{$l_ItemEncontrado}:=$r_evaluacionEnMadre
										End if 
										$r_promedioAntesRecalculo:=Round:C94(aRealSubEvalP1{$l_ItemEncontrado};11)
										ASsev_Average ($l_ItemEncontrado)
										$r_evaluacion:=Round:C94(aRealSubEvalP1{$l_ItemEncontrado};11)
										ASsev_GuardaNomina ($l_recNumSubasignatura)
										$ar_ParcialesActuales{$i_parcial}:=$r_evaluacion
									End if 
								End if 
								If (($r_evaluacion=-10) & ($r_evaluacionEnMadre#$r_evaluacion))
									$r_evaluacion:=$r_evaluacionEnMadre
									$ar_ParcialesActuales{$i_parcial}:=$r_evaluacionEnMadre
								End if 
								
								
								Case of 
									: ($r_evaluacion=-3)
										$B_conEximiciones:=True:C214
										
									: ($r_evaluacion=-2)
										  //$terminarCalculo:=Trueææ`hay evaluaciones pendientes, se aborta el calculo
										$r_sumaCalificaciones:=-2
										
									: ($r_evaluacion>=vrNTA_MinimoEscalaReferencia)
										$l_numeroEvaluaciones:=$l_numeroEvaluaciones+1
										Case of 
											: ($b_conPonderaciones)
												$r_evaluacionPonderada:=EV2_PonderaEvaluacion ($r_evaluacion;$r_Ponderacion)
												If ($r_evaluacionPonderada>=0)
													$r_sumaCalificaciones:=$r_sumaCalificaciones+$r_evaluacionPonderada
												End if 
												$r_ponderacionesAcumuladas:=$r_ponderacionesAcumuladas+$r_Ponderacion
												
											: ($b_conCoeficientes)
												$r_sumaCalificaciones:=$r_sumaCalificaciones+Round:C94($r_evaluacion*$r_coeficiente;11)
												$r_divisor:=$r_divisor+$r_coeficiente
											Else 
												$r_sumaCalificaciones:=Round:C94($r_sumaCalificaciones+$r_evaluacion;11)
												$r_divisor:=$r_divisor+1
												
										End case 
									Else 
										  //si no hay calificaciones o el alumno està eximido de la asignatura se ignoran los valores
								End case 
								
								
							: ($alAS_EvalPropSourceID{$i_parcial}=0)  //evaluaciÑn directa en la asignatura madre
								EVS_ReadStyleData ($estiloEvaluacion)
								$r_evaluacion:=$ar_ParcialesActuales{$i_parcial}
								Case of 
									: ($r_evaluacion=-3)
										$B_conEximiciones:=True:C214
										
									: ($r_evaluacion=-2)
										  //$terminarCalculo:=Trueææ`hay evaluaciones pendientes, se aborta el calculo
										$r_sumaCalificaciones:=-2
										
									: ($r_evaluacion>=vrNTA_MinimoEscalaReferencia)
										$l_numeroEvaluaciones:=$l_numeroEvaluaciones+1
										Case of 
											: ($b_conPonderaciones)
												$r_evaluacionPonderada:=EV2_PonderaEvaluacion ($r_evaluacion;$r_Ponderacion)
												If ($r_evaluacionPonderada>=0)
													$r_sumaCalificaciones:=$r_sumaCalificaciones+$r_evaluacionPonderada
												End if 
												$r_ponderacionesAcumuladas:=$r_ponderacionesAcumuladas+$r_Ponderacion
												
											: ($b_conCoeficientes)
												$r_sumaCalificaciones:=$r_sumaCalificaciones+Round:C94($r_evaluacion*$r_coeficiente;11)
												$r_divisor:=$r_divisor+$r_coeficiente
											Else 
												$r_sumaCalificaciones:=Round:C94($r_sumaCalificaciones+$r_evaluacion;11)
												$r_divisor:=$r_divisor+1
										End case 
										
									Else 
										  //si no hay calificaciones o el alumno està eximido de la asignatura se ignoran los valores
								End case 
								
						End case 
						$l_numeroCampoCalificacion:=$l_numeroCampoCalificacion+5
						If ($terminarCalculo)
							$i_parcial:=Size of array:C274($alAS_EvalPropSourceID)+1
						End if 
					End for 
					
				: ($l_MetodoConsolidacion=2)  //consolidación utilizando todas las parciales
					AT_Initialize (->$ar_ParcialesActuales)
					EV2_ConsolidaTodasLasParciales ($l_periodo)
					$b_NotaPresentacionCalculada:=True:C214
					
			End case 
			
			
			
			EVS_ReadStyleData ($estiloEvaluacion)
			KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones;True:C214)
			RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
			
			If (Size of array:C274($ar_ParcialesActuales)>0)
				For ($i_parcial;1;Size of array:C274($ar_ParcialesActuales))
					$y_campoNota:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Nota")
					$y_campoPuntos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Puntos")
					$y_campoSimbolo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Simbolo")
					$y_campoLiteral:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Literal")
					$y_campoReal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Real")
					$y_campoReal->:=$ar_ParcialesActuales{$i_parcial}
					$y_campoNota->:=Choose:C955($y_campoReal->>=vrNTA_MinimoEscalaReferencia;EV2_Real_a_Nota ($y_campoReal->;0;iGradesDec);$y_campoReal->)
					$y_campoPuntos->:=Choose:C955($y_campoReal->>=vrNTA_MinimoEscalaReferencia;EV2_Real_a_Puntos ($y_campoReal->;0;iPointsDec);$y_campoReal->)
					$y_campoSimbolo->:=EV2_Real_a_Simbolo ($y_campoReal->)
					$y_campoLiteral->:=EV2_Real_a_Literal ($y_campoReal->;iPrintMode;vlNTA_DecimalesParciales)
				End for 
			End if 
			
			
			
			If (AS_PromediosSonCalculados ([Alumnos_Calificaciones:208]ID_Asignatura:5))
				  //inicialización a valor nulo (-10)
				If (Not:C34($b_NotaPresentacionCalculada))
					$y_Presentacion_Real->:=-10
					$y_Presentacion_Nota->:=-10
					$y_Presentacion_Puntos->:=-10
					$y_Presentacion_Simbolo->:=""
					$y_Presentacion_Literal->:=""
					$y_FinalNoAproximado->:=-10
					$y_Final_Real->:=-10
					$y_Final_Nota->:=-10
					$y_Final_Puntos->:=-10
					$y_Final_Simbolo->:=""
					$y_Final_Literal->:=""
					
					Case of 
						: (($B_conEximiciones) & ($l_numeroEvaluaciones=0))
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
							
						: ($r_sumaCalificaciones=-2)
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
							
						: ($l_numeroEvaluaciones=0)
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
							
						: (Find in array:C230($ar_ParcialesActuales;-2)>0)
							$y_Presentacion_Real->:=-2
							
						: ((iResults=2) & ($r_sumaCalificaciones>=vrNTA_MinimoEscalaReferencia) & ($r_sumaCalificaciones<=100) & ($l_numeroEvaluaciones>0))  //presentacion examen calculado con suma de calificaciones
							  //$y_Presentacion_Real->:=Choose($r_sumaCalificaciones>0;Round(MATH_Divide ($r_sumaCalificaciones;$r_ponderacionesAcumuladas)*100;11);Round($r_sumaCalificaciones;11))
							$y_Presentacion_Real->:=$r_sumaCalificaciones
						: ((iResults=2) & ($r_sumaCalificaciones>=vrNTA_MinimoEscalaReferencia) & ($r_sumaCalificaciones>100))  //presentacion examen calculado con suma de calificaciones. Si la suma es superior a 100 el resultado es 100, no puede superior al 100% de la escala)
							$y_Presentacion_Real->:=100
							
						: (($b_conPonderaciones) & ($l_numeroEvaluaciones>0))
							$y_Presentacion_Real->:=Choose:C955($r_ponderacionesAcumuladas>0;Round:C94(MATH_Divide ($r_sumaCalificaciones;$r_ponderacionesAcumuladas)*100;11);-10)
							
							
						: (($b_conCoeficientes) & ($l_numeroEvaluaciones>0))
							$y_Presentacion_Real->:=Round:C94(MATH_Divide ($r_sumaCalificaciones;$r_divisor);11)
							
							
						: (($l_numeroEvaluaciones>0) | ($y_Control_Real->>=vrNTA_MinimoEscalaReferencia))
							$y_Presentacion_Real->:=Round:C94(MATH_Divide ($r_sumaCalificaciones;$r_divisor);11)
							
							
						: ($l_numeroEvaluaciones=0)
							$y_Presentacion_Real->:=-10
							
					End case 
					$y_Presentacion_Real->:=Choose:C955($y_Presentacion_Real->>100;100;$y_Presentacion_Real->)
					
				End if 
				
				EV2_Calculos_FinalPeriodo ($l_periodo)
				
			End if 
		End if 
		
		
		
		$b_promedioPeriodoModificado:=EV2_PromediosModificados ($l_periodo)
		$b_promedioPeriodoModificado:=$b_promedioPeriodoModificado | vb_RecalcularTodo
		
		If ($b_promedioPeriodoModificado | EV2_CalificacionesModificadas )
			SAVE RECORD:C53([Alumnos_Calificaciones:208])  //MONO TICKET 193265 (Perdiamos parte de la consolidación en la madre (parcial a la que corresponde y promedio de periodo))
			$b_finalesModificados:=EV2_Calculos_PromediosFinales ($l_recNumCalificaciones)
		End if 
		
	Else 
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End if 
	
	If ($b_promedioPeriodoModificado | $b_finalesModificados | (Not:C34(AS_PromediosSonCalculados )))
		If ([Asignaturas:18]nivel_jerarquico:107>0)
			EV2_LanzaProcesoConsolidacion ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;$l_Periodo)
		End if 
	End if 
	
	$0:=($b_promedioPeriodoModificado | $b_finalesModificados | vb_RecalcularTodo)
	
End if 

