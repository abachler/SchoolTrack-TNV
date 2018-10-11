//%attributes = {}
  // MÉTODO: EV2_Calculos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 16/01/12, 16:41:11
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2stwa_Calculos()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_calcularPromedioFinal;$b_EsAsignaturaMadre;$b_finalModificado;$b_promediosModificados)
C_LONGINT:C283($l_EstiloEvaluacion;$l_NumeroNivel;$l_Periodo;$l_recordNumber;$l_asignaturasHijas)

If (False:C215)
	C_BOOLEAN:C305(EV2_Calculos ;$0)
	C_LONGINT:C283(EV2_Calculos ;$1)
	C_LONGINT:C283(EV2_Calculos ;$2)
End if 

  //BMK_LocalExecutionTimer (True)

$l_recordNumber:=$1
$l_Periodo:=$2

KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recordNumber;True:C214)

If (Not:C34(EV2_EsAlumnoEximido ))
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)  // cargo el registro de asignaturas para leer sus propiedades
	$l_NumeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
	$l_EstiloEvaluacion:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
	$b_EsAsignaturaMadre:=(Find in field:C653([Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;[Asignaturas:18]Numero:1)>No current record:K29:2)
	If (($b_EsAsignaturaMadre) & ([Asignaturas:18]Consolidacion_EsConsolidante:35=False:C215))
		KRL_ReloadInReadWriteMode (->[Asignaturas:18])
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=True:C214
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	$b_EsAsignaturaMadre:=[Asignaturas:18]Consolidacion_EsConsolidante:35 | [Asignaturas:18]Consolidacion_ConSubasignaturas:31
	
	PERIODOS_LoadData ($l_NumeroNivel)
	EVS_ReadStyleData ($l_EstiloEvaluacion)
	AS_PropEval_Lectura ("";$l_Periodo)
	
	
	If (AS_PromediosSonCalculados )
		
		  // si el número de período pasado en $2 es superior a 0 se calculan los promedios del período
		If ($l_Periodo>0)
			If (Not:C34($b_EsAsignaturaMadre))
				$b_promediosModificados:=EV2_Calculos_PromedioPeriodo ($l_recordNumber;$l_Periodo)
				If ($b_promediosModificados)
					$b_calcularPromedioFinal:=True:C214
				End if 
			Else 
				$b_promediosModificados:=EV2_Calculos_ConsolidaPeriodo ($l_recordNumber;$l_Periodo;False:C215)
				If ($b_promediosModificados)
					$b_calcularPromedioFinal:=True:C214
				End if 
			End if 
			
			Case of 
				: (Old:C35([Alumnos_Calificaciones:208]ExamenAnual_Real:16)#([Alumnos_Calificaciones:208]ExamenAnual_Real:16))
					$b_calcularPromedioFinal:=True:C214
				: (Old:C35([Alumnos_Calificaciones:208]ExamenExtra_Real:21)#([Alumnos_Calificaciones:208]ExamenExtra_Real:21))
					$b_calcularPromedioFinal:=True:C214
			End case 
			
		Else 
			$b_calcularPromedioFinal:=True:C214
		End if 
		
		$b_finalModificado:=EV2_Calculos_PromediosFinales ($l_recordNumber)
		$b_aprobacionModificada:=EV2_AprobacionReprobacion 
		$b_finalModificado:=$b_finalModificado | EV2_Calcula_PTC 
		
		  // nos aseguramos de almacenar el registro si hubo cambios en la aprobación o cambios en calificaciones aunque no hayan cambios en los promedios
		If ($b_aprobacionModificada | $b_finalModificado | EV2_CalificacionesModificadas )
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
		End if 
		
		  // si la asignatura es una asignatura hija
		If (([Asignaturas:18]nivel_jerarquico:107>0) & ($b_finalModificado | $b_promediosModificados))
			EV2_LanzaProcesoConsolidacion ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;$l_Periodo)
		End if 
		
		
		
		$0:=($b_finalModificado | $b_promediosModificados)
		
	End if 
End if 
  //BMK_LocalExecutionTimer (False)
