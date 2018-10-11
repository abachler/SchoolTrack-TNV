//%attributes = {}
  // Método: EV2_CalculoALT_PromedioPeriodo
  // 
  // 
  // por Alberto Bachler Klein
  // creación 11/07/17, 16:50:54
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



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
	C_BOOLEAN:C305(EV2_CalculoALT_PromedioPeriodo ;$0)
	C_LONGINT:C283(EV2_CalculoALT_PromedioPeriodo ;$1)
	C_LONGINT:C283(EV2_CalculoALT_PromedioPeriodo ;$2)
	C_BOOLEAN:C305(EV2_CalculoALT_PromedioPeriodo ;$3)
End if 

C_BOOLEAN:C305(vb_RecalcularTodo)


Case of 
	: (iEvaluationMode=Notas)
		$l_modoAlternativo:=Puntos
		$l_decimales:=iPointsDecPP
	: (iEvaluationMode=Puntos)
		$l_modoAlternativo:=Notas
		$l_decimales:=iGradesDecPP
End case 


  // CODIGO PRINCIPAL
$l_recNumCalificaciones:=$1
$l_periodo:=$2


OK:=1
  //asignación de campos a punteros segœn períodos
Case of 
	: ($l_modoAlternativo=Notas)
		Case of 
			: ($l_periodo=1)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P01_Final_Nota:113
				$l_indicePrimerParcial:=43
				$l_indiceUltimoParcial:=98
				
			: ($l_periodo=2)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P02_Final_Nota:188
				$l_indicePrimerParcial:=118
				$l_indiceUltimoParcial:=173
				
			: ($l_periodo=3)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P03_Final_Nota:263
				$l_indicePrimerParcial:=193
				$l_indiceUltimoParcial:=248
				
			: ($l_periodo=4)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P04_Final_Nota:338
				$l_indicePrimerParcial:=268
				$l_indiceUltimoParcial:=323
				
			: ($l_periodo=5)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P05_Final_Nota:413
				$l_indicePrimerParcial:=343
				$l_indiceUltimoParcial:=398
		End case 
		
	: ($l_modoAlternativo=Puntos)
		Case of 
			: ($l_periodo=1)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P01_Final_Nota:113
				$l_indicePrimerParcial:=44
				$l_indiceUltimoParcial:=99
				
			: ($l_periodo=2)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P02_Final_Nota:188
				$l_indicePrimerParcial:=119
				$l_indiceUltimoParcial:=174
				
			: ($l_periodo=3)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P03_Final_Nota:263
				$l_indicePrimerParcial:=194
				$l_indiceUltimoParcial:=249
				
			: ($l_periodo=4)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P04_Final_Nota:338
				$l_indicePrimerParcial:=269
				$l_indiceUltimoParcial:=324
				
			: ($l_periodo=5)
				$y_Presentacion_Nota:=->[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403
				$y_Final_Nota:=->[Alumnos_Calificaciones:208]P05_Final_Nota:413
				$l_indicePrimerParcial:=344
				$l_indiceUltimoParcial:=399
		End case 
		
End case 



If (OK=1)
	READ WRITE:C146([Alumnos_Calificaciones:208])
	RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
	If ([Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8#0)
		If ($y_Final_Nota->#-3)
			$b_promedioPeriodoModificado:=True:C214
		End if 
		$y_Final_Nota->:=-3
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
		
		  //If (Not([Asignaturas]Consolidacion_EsConsolidante))
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
							$r_suma:=Round:C94($r_suma+$r_evaluacionPonderada;11)
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
		$y_Presentacion_Nota->:=-10
		Case of 
			: ($t_motivoParaNoCalcular="Pendiente")
				$y_Presentacion_Nota->:=-2
				$y_Final_Nota->:=-2
				
				
			: (($t_motivoParaNoCalcular="Eximido") | (($b_conEximiciones) & ($l_numeroEvaluaciones=0)))
				$y_Presentacion_Nota->:=-3
				$y_Final_Nota->:=-3
				
				
			: (($t_motivoParaNoCalcular="") & ($l_numeroEvaluaciones>0)) | (($t_motivoParaNoCalcular=""))
				  //calculo del PROMEDIO DE PRESENTACION al EXAMEN DE FIN DE PERIODO
				
				Case of 
					: ($l_numeroEvaluaciones=0)
						$y_Presentacion_Nota->:=-10
						
					: ($r_ponderacionesAcumuladas>0)
						$y_Presentacion_Nota->:=Choose:C955($r_suma<=100;$r_suma;100)
						
					: ((iResults=1) & ($r_suma>=vrNTA_MinimoEscalaReferencia))  // presentacion examen calculado con promedio
						If ($r_divisor>0)
							$y_Presentacion_Nota->:=Round:C94($r_suma/$r_divisor;11)
						Else 
							$y_Presentacion_Nota->:=$r_suma
						End if 
					: ((iResults=2) & ($r_suma>=vrNTA_MinimoEscalaReferencia) & ($r_suma<100))  //presentacion examen calculado con suma de calificaciones
						$y_Presentacion_Nota->:=$r_suma
						
					: ((iResults=2) & ($r_suma>=vrNTA_MinimoEscalaReferencia) & ($r_suma>100))  //presentacion examen calculado con suma de calificaciones. Si la suma es superior a 100 el resultado es 100, no puede superior al 100% de la escala)
						$y_Presentacion_Nota->:=100
						
				End case 
				$y_Presentacion_Nota->:=Choose:C955($y_Presentacion_Nota->>100;100;$y_Presentacion_Nota->)
				
		End case 
		
		EV2_CalculoALT_FinalPeriodo ($l_periodo)
		$b_promedioPeriodoModificado:=EV2_PromediosModificados ($l_periodo)
		$b_promedioPeriodoModificado:=$b_promedioPeriodoModificado | vb_RecalcularTodo
		
		  //Else 
		  //$b_promedioPeriodoModificado:=EV2_Calculos_ConsolidaPeriodo ($l_recNumCalificaciones;$l_periodo;False)
		  //$b_promedioPeriodoModificado:=$b_promedioPeriodoModificado | vb_RecalcularTodo
		  //
		  //End if 
		
	End if 
	
	$0:=$b_promedioPeriodoModificado
	
	
Else 
	TRACE:C157
	  //error, registro de evaluaciones inexistente
End if 

