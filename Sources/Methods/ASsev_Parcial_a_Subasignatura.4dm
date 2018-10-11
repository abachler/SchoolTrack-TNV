//%attributes = {}
  // ASsev_Parcial_a_Subasignatura()
  // 
  //
  // creado por: Alberto Bachler Klein: 29-11-16, 12:08:52
  // -----------------------------------------------------------
C_LONGINT:C283($i_periodo;$l_recNumSubasignatura;$i_columna)
C_REAL:C285($r_evaluacionEnMadre)
C_TEXT:C284($t_evaluacionEnMadre)
C_POINTER:C301($y_campoLiteral;$y_campoReal)

ARRAY REAL:C219($ar_EvaluacionReal;0)
ARRAY TEXT:C222($at_evaluacionLiteral;0)



PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)


For ($i_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
	AS_PropEval_Lectura ("";$i_periodo)
	For ($i_columna;1;Size of array:C274(alAS_EvalPropSourceID))
		If (alAS_EvalPropSourceID{$i_columna}<0)
			$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$i_periodo;$i_columna)
			If ($l_recNumSubasignatura>No current record:K29:2)
				
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				$y_campoReal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Eval"+String:C10($i_columna;"00")+"_Real")
				$y_campoLiteral:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Eval"+String:C10($i_columna;"00")+"_Literal")
				SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]Status:50;aNtaStatus;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;aNtaRegEximicion;$y_campoReal->;$ar_EvaluacionReal;$y_campoLiteral->;$at_evaluacionLiteral)
				SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
				
				EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				
				ASsev_UpdateList (Record number:C243([xxSTR_Subasignaturas:83]))
				
				  // si no hay notas en la sub-asignatura a causa del traslado del alumno desde otra asignatura madre copio la evaluación de la columna parcial en la madre a la subasignatura
				  // eliminando así la inconsistencia que podíá producirse en el calculo de promedio
				For ($i;1;Size of array:C274(aNtaIDAlumno))
					$l_posicion:=Find in array:C230(aSubEvalID;aNtaIDAlumno{$i})
					
					$r_evaluacionEnMadre:=$ar_EvaluacionReal{$i}
					$t_evaluacionEnMadre:=$at_evaluacionLiteral{$i}
					If ($l_posicion>0)
						If ((aRealSubEvalP1{$l_posicion}=-10) & ($r_evaluacionEnMadre#aRealSubEvalP1{$l_posicion}))
							aRealSubEvalP1{$l_posicion}:=$r_evaluacionEnMadre
							aRealSubEval1{$l_posicion}:=$r_evaluacionEnMadre
							aSubEval1{$l_posicion}:=$t_evaluacionEnMadre
							ASsev_Average ($l_posicion)
						End if 
					End if 
				End for 
			End if 
			ASsev_GuardaNomina ($l_recNumSubasignatura)
		End if 
	End for 
End for 