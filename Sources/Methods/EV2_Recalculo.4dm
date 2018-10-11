//%attributes = {"executedOnServer":true}
  // EV2_Recalculo()
  // 
  //
  // creado por: Alberto Bachler Klein: 03-12-16, 11:56:57
  // -----------------------------------------------------------

C_BOOLEAN:C305($0;$5)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305(vb_RecalcularTodo)

C_BOOLEAN:C305($b_finalModificado;$b_promediosModificados;$b_forzarRecalculo)
C_LONGINT:C283($iPeriodos;$l_EstiloEvaluacion;$l_NumeroNivel;$l_NumeroPeriodos;$l_recNumCalificaciones)
If (False:C215)
	C_BOOLEAN:C305(EV2_Recalculo ;$0)
	C_LONGINT:C283(EV2_Recalculo ;$1)
	C_LONGINT:C283(EV2_Recalculo ;$2)
	C_LONGINT:C283(EV2_Recalculo ;$3)
	C_BOOLEAN:C305(EV2_Recalculo ;$4)
	C_BOOLEAN:C305(EV2_Recalculo ;$5)
End if 

  //C_LONGINT(vlEV2_IDAsignaturaActual)

$l_recNumCalificaciones:=$1
$b_calcularPromedioFinal:=False:C215
Case of 
	: (Count parameters:C259=4)
		$l_NumeroNivel:=$2
		$l_EstiloEvaluacion:=$3
		$b_EsAsignaturaMadre:=$4
	: (Count parameters:C259=5)
		$l_NumeroNivel:=$2
		$l_EstiloEvaluacion:=$3
		$b_EsAsignaturaMadre:=$4
		  //$b_forzarRecalculo:=$5  //20120712 ASM Se recibe parámetro para forzar el recalculo.
		vb_RecalcularTodo:=$5  //MONO la variable $b_EsAsignaturaMadre no está siendo utilizada pero esta de proceso si y en cliente servidor perdemos el valorde esta debido a que este método se ejecuta en el servidor.
End case 



If ($l_recNumCalificaciones=-1)  // si $l_recNumCalificaciones es inferior a 0 fue llamado para inicializar objetos necesarios en el calculo
	EVS_initialize 
	PERIODOS_Init 
	  //vlEV2_IDAsignaturaActual:=0
Else 
	
	
	
	READ ONLY:C145([Asignaturas:18])
	
	
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones;True:C214)
	
	If (EV2_EsAlumnoEximido )
		$0:=EV2_CalificacionesModificadas 
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		
	Else 
		If ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
			KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)  // cargo el registro de asignaturas para leer sus propiedades
			EVS_ReadStyleData ($l_EstiloEvaluacion)
			PERIODOS_LoadData ($l_NumeroNivel)
			
			If (AS_PromediosSonCalculados ([Asignaturas:18]Numero:1))
				$b_calcularPromedioFinal:=False:C215
				For ($iPeriodos;1;viSTR_Periodos_NumeroPeriodos)
					AS_PropEval_Lectura ("";$iPeriodos)
					If (Not:C34($b_EsAsignaturaMadre))
						If ([Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503 ?? $iPeriodos)
							$b_promediosModificados:=EV2_Calculos_PromedioPeriodo ($l_recNumCalificaciones;$iPeriodos)
							If ($b_promediosModificados)
								$b_calcularPromedioFinal:=True:C214
							End if 
						End if 
					Else 
						$b_promediosModificados:=EV2_Calculos_ConsolidaPeriodo ($l_recNumCalificaciones;$iPeriodos;False:C215)
						If ($b_promediosModificados)
							$b_calcularPromedioFinal:=True:C214
						End if 
					End if 
				End for 
				
				If ($b_calcularPromedioFinal | vb_RecalcularTodo)
					$b_finalModificado:=EV2_Calculos_PromediosFinales ($l_recNumCalificaciones)
				End if 
				
			End if 
			
			$b_finalModificado:=EV2_Calcula_PTC 
			
			
			  // nos aseguramos que el resultado sea almacenado si hubo cambios en las calificaciones 
			  // pero sin modificaciones en promedios
			If ((EV2_CalificacionesModificadas ) | (vb_RecalcularTodo))
				SAVE RECORD:C53([Alumnos_Calificaciones:208])
				KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
			End if 
			
			If ([Asignaturas:18]nivel_jerarquico:107>0)
				EV2_LanzaProcesoConsolidacion ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;0)
			End if 
			
			
		End if 
		
		EV2_AprobacionReprobacion 
		
		
		$0:=($b_finalModificado | $b_promediosModificados)
	End if 
End if 

