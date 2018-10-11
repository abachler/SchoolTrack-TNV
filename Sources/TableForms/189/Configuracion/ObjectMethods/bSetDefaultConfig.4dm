  //$selectedItem:=Selected list items(hl_configuraciones)
  //GET LIST ITEM(hl_configuraciones;$selectedItem;$recNum;$itemText)
KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];vlMPA_RecNumMatrizDefecto;False:C215)



$recNumAsignatura:=Record number:C243([Asignaturas:18])
If (vlMPA_IDMatrizActual#[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2=[Asignaturas:18]EVAPR_IdMatriz:91;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"aprendizajes")
	QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
	Case of 
		: (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
			$event:=__ ("La matriz de evaluación fue reemplazada en ^0 por la matriz por omisión y las evaluaciones existentes eliminadas previa confirmación del usuario.")
			$event:=Replace string:C233($event;"^0";[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
			OK:=CD_Dlog (0;__ ("En esta asignatura ya se han registrado evaluaciones.\r\rSi usted asigna la matriz de evaluación de aprendizajes por omisión esas evaluaciones serán eliminadas.\r\r¿Desea asignar la matriz por omisión de todas maneras?");__ ("");__ ("No");__ ("Si. Cambiar matriz."))
		: (Records in set:C195("aprendizajes")>0)
			$event:=__ ("La matriz de evaluación fue reemplazada en ^0 por la matriz por omisión previa confirmación del usuario.")
			$event:=Replace string:C233($event;"^0";[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
			OK:=CD_Dlog (0;__ ("Los Aprendizajes definidos en la matriz de evaluación utilizada por la asignatura actualmente serán reemplazados por los de la matriz por omisión.\r\r¿Desea reemplazar la matriz actual por la matriz por omisión?");__ ("");__ ("No");__ ("Si. Cambiar matriz."))
		Else 
			OK:=2
			$event:=__ ("La matriz de evaluación por omisión fue asignada a ^0")
			$event:=Replace string:C233($event;"^0";[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
			OK:=CD_Dlog (0;__ ("Los Aprendizajes definidos en la matriz de evaluación utilizada por la asignatura actualmente serán reemplazados por los de la matriz por omisión.\r\r¿Desea reemplazar la matriz actual por la matriz por omisión?");__ ("");__ ("No");__ ("Si. Cambiar matriz."))
	End case 
	
	If (OK=2)
		USE SET:C118("aprendizajes")
		START TRANSACTION:C239
		OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
		If (OK=1)
			KRL_GotoRecord (->[Asignaturas:18];$recNumAsignatura;True:C214)
			If (OK=1)
				[Asignaturas:18]EVAPR_IdMatriz:91:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
				SAVE RECORD:C53([Asignaturas:18])
				vlMPA_IDMatrizActual:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
				vtMPA_MatrizActual:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
				vlMPA_RecNumMatrizActual:=Record number:C243([MPA_AsignaturasMatrices:189])
				
				
				KRL_ReloadAsReadOnly (->[Asignaturas:18])
				LOG_RegisterEvt ($event)
				VALIDATE TRANSACTION:C240
				
				AL_UpdateArrays (xALP_LogrosAsignaturas;0)
				MPAmtx_LeeConfiguracion (vlMPA_RecNumMatrizActual;$refPeriodo;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
				AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
				
				POST KEY:C465(Character code:C91("=");256)
				AL_SetLine (xALP_Configs;1)
			Else 
				
				CANCEL TRANSACTION:C241
				CD_Dlog (0;__ ("No fue posible realizar el cambio de matriz de evaluación para esta asignatura.\r\rPor favor inténtelo nuevamente más tarde."))
			End if 
		Else 
			CANCEL TRANSACTION:C241
			CD_Dlog (0;__ ("No fue posible realizar el cambio de matriz de evaluación para esta asignatura.\r\rPor favor inténtelo nuevamente más tarde."))
		End if 
	End if 
End if 



