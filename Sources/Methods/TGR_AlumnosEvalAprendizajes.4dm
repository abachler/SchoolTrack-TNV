//%attributes = {}
  // MÉTODO: TGR_AlumnosEvalAprendizajes
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/03/12, 17:23:15
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // TGR_AlumnosEvalAprendizajes()
  // ----------------------------------------------------
C_LONGINT:C283($l_IdAsignatura;$l_recNumAsignatura;$id_alu;$l_nivelAlu)  //MONO 184433
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)



  // CODIGO PRINCIPAL
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_EvaluacionAprendizajes:203]ID:90:=SQ_SeqNumber (->[Alumnos_EvaluacionAprendizajes:203]ID:90)
			
			If ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91=0)
				If (<>gYear=[Alumnos_EvaluacionAprendizajes:203]Año:77)
					$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
					If ($l_recNumAsignatura<0)
						$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Alumnos:2]nivel_numero:29
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Asignaturas:18]Numero_del_Nivel:6
					End if 
				Else 
					$l_IdAsignatura:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
					$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]ID_AsignaturaOriginal:30;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
					If ($l_recNumAsignatura<0)
						$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Historico:25]Alumno_Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Alumnos_Historico:25]Nivel:11
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Asignaturas_Historico:84]Nivel:4
					End if 
				End if 
			End if 
			
			  //MONO en la creación de registros nuevos siempre vienen con nivel 0 así que esta validación va despues de esto.
			$id_alu:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			If (([Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear) & ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91=$l_nivelAlu))  //MONO 184433
				[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
				[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
				[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
				[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
				[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
			Else 
				[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
				[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
				[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
				[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
				[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
			End if 
			
			[Alumnos_EvaluacionAprendizajes:203]Key:8:=String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
			[Alumnos_EvaluacionAprendizajes:203]LLaveCalificaciones:76:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
			[Alumnos_EvaluacionAprendizajes:203]LlaveAlumno:92:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))
			[Alumnos_EvaluacionAprendizajes:203]LlaveAsignatura:93:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
			
			If (Not:C34(<>vb_AvoidTriggerExecution))
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=-10*(Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13=""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=-10*(Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25=""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=-10*(Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37=""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=-10*(Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49=""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=-10*(Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66=""))
				[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=-10*(Num:C11([Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61=""))
			End if 
			[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=MPA_PeriodosEvaluados 
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			If ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91=0)
				If (<>gYear=[Alumnos_EvaluacionAprendizajes:203]Año:77)
					$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
					If ($l_recNumAsignatura<0)
						$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Alumnos:2]nivel_numero:29
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Asignaturas:18]Numero_del_Nivel:6
					End if 
				Else 
					$l_IdAsignatura:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
					$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]ID_AsignaturaOriginal:30;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
					If ($l_recNumAsignatura<0)
						$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Historico:25]Alumno_Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Alumnos_Historico:25]Nivel:11
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=[Asignaturas_Historico:84]Nivel:4
					End if 
				End if 
			End if 
			  //MONO: también cambio esto acá por si al modificar un registro queda con nivel 0
			$id_alu:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			If (([Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear) & ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91=$l_nivelAlu))  //MONO 184433
				[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
				[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
				[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
				[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
				[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
			Else 
				[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
				[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
				[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
				[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
				[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
			End if 
			
			[Alumnos_EvaluacionAprendizajes:203]Key:8:=String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
			[Alumnos_EvaluacionAprendizajes:203]LLaveCalificaciones:76:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
			[Alumnos_EvaluacionAprendizajes:203]LlaveAlumno:92:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))
			[Alumnos_EvaluacionAprendizajes:203]LlaveAsignatura:93:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
			[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=MPA_PeriodosEvaluados 
			
			If ([Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
				MPA_DatacionRegistroAdquisicion 
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	
	
	
	SN3_MarcarRegistros (SN3_DTi_CalificacionesMPA)
End if 