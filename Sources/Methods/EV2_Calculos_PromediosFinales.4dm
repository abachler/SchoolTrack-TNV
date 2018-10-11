//%attributes = {}
  // MÉTODO: EV2_Calculos_PromediosFinales
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 20:47:40
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_Calculos_PromediosFinales()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($1;$l_recNum)
C_REAL:C285(vrEVS_PonderacionB1;vrEVS_PonderacionB2;vrEVS_PonderacionB3;vrEVS_PonderacionB4;vrEVS_PonderacionB5)
C_REAL:C285(vrEVS_PonderacionT1;vrEVS_PonderacionT2;vrEVS_PonderacionT3)
C_REAL:C285(vrEVS_PonderacionS1;vrEVS_PonderacionS2;$ponderacion)
C_BOOLEAN:C305(vb_RecalcularTodo;$b_calificacionesModificadas)

$l_recNum:=$1


  // CODIGO PRINCIPAL

If ($l_recNum>=0)
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNum;True:C214)
	$estiloActual:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
	
	RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
	RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
	
	If ([Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7>!00-00-00!)
		[Alumnos_Calificaciones:208]Anual_Real:11:=-3
		[Alumnos_Calificaciones:208]Anual_Literal:15:="X"
		[Alumnos_Calificaciones:208]Anual_Nota:12:=-3
		[Alumnos_Calificaciones:208]Anual_Puntos:13:=-3
		[Alumnos_Calificaciones:208]Anual_Simbolo:14:="X"
		[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=-3
		[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:="X"
		[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=-3
		[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=-3
		[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:="X"
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-3
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="EX"
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-3
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-3
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="EX"
		[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
		
	Else 
		AS_PropEval_Lectura   //agregado ASM ticket 126102
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		  //If ([Asignaturas]Resultado_no_calculado=False)
		PERIODOS_LoadData ([Alumnos_Calificaciones:208]NIvel_Numero:4)
		$b_Conversion_a_notas:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
		Case of 
			: ($b_Conversion_a_notas)
				  //AS_LeeOpcionesExamenes 
				EV2_Examenes_LeeConfigExamenes 
				EV2_Calculos_PromedioAnual 
				
				If (vi_ConsolidaExamenFinal=1)
					EV2_Calculos_ConsolidaExamen ($l_recNum)
					EV2_Calculos_ConsolidaExExtra ($l_recNum)
				End if 
				EV2_Calculos_Final 
				EV2_Calculos_Oficial (iPrintActa)
				
				
				
				
			: (AS_PromediosSonCalculados )
				  //AS_LeeOpcionesExamenes 
				EV2_Examenes_LeeConfigExamenes 
				
				If ((vi_ConsolidaNotasFinales=1) & ([Asignaturas:18]Consolidacion_EsConsolidante:35))
					EV2_Calculos_ConsolidaAnual ($l_recNum)
					If (vi_ConsolidaExamenFinal=1)
						EV2_Calculos_ConsolidaExamen ($l_recNum)
						EV2_Calculos_ConsolidaExExtra ($l_recNum)
					End if 
					EV2_Calculos_ConsolidaFinal ($l_recNum)
					EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
					EV2_Calculos_Oficial (iPrintActa)
					
				Else 
					
					EV2_Calculos_PromedioAnual 
					If (vi_ConsolidaExamenFinal=1)
						EV2_Calculos_ConsolidaExamen ($l_recNum)
						EV2_Calculos_ConsolidaExExtra ($l_recNum)
					End if 
					EV2_Calculos_Final 
					EV2_Calculos_Oficial (iPrintActa)
				End if 
				
				
			Else 
				
				EV2_Calculos_Oficial (iPrintActa)
		End case 
	End if 
	
	
	
	
	  // nos aseguramos que el registro sea almacenado si alguna calificación ha sido modificada
	  // sin importar cambios en los promedios
	$b_calificacionesModificadas:=EV2_CalificacionesModificadas  | vb_RecalcularTodo
	$b_calificacionesModificadas:=$b_calificacionesModificadas | EV2_AprobacionReprobacion 
	If ($b_calificacionesModificadas | vb_RecalcularTodo)
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End if 
	EVS_ReadStyleData ($estiloActual)
	
	
	$0:=$b_calificacionesModificadas
End if 
