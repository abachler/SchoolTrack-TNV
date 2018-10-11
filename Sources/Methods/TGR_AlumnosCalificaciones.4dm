//%attributes = {}
  // MÉTODO: TGR_AlumnosCalificaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/03/12, 17:12:05
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // TGR_AlumnosCalificaciones()
  // ----------------------------------------------------
C_LONGINT:C283($i;$l_IdAlumno;$l_IdAsignatura;$l_IdAsignaturaAnterior;$l_recNumComplementoEval;$l_registroEliminado)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)



  // CODIGO PRINCIPAL
If (Not:C34(<>vb_ImportHistoricos_STX))
	$l_IdAlumno:=Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
	$l_IdAsignatura:=Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([Alumnos_Calificaciones:208]ID:506=0)
				[Alumnos_Calificaciones:208]ID:506:=SQ_SeqNumber (->[Alumnos_Calificaciones:208]ID:506)
			End if 
			If (([Alumnos_Calificaciones:208]Año:3=<>gYear) & ([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493=0))  //MONO TICKET 184433
				[Alumnos_Calificaciones:208]ID_Asignatura:5:=Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
				[Alumnos_Calificaciones:208]ID_Alumno:6:=Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
			Else 
				[Alumnos_Calificaciones:208]ID_Asignatura:5:=-Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
				[Alumnos_Calificaciones:208]ID_Alumno:6:=-Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
			End if 
			
			[Alumnos_Calificaciones:208]Llave_principal:1:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			[Alumnos_Calificaciones:208]Llave_Asignatura:494:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))
			[Alumnos_Calificaciones:208]Llave_Alumno:495:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			
			If ([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493#0)
				[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493))+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			End if 
			
			  //creación del registro asociado [Alumnos_ComplementoEvaluacion]
			If (([Alumnos_Calificaciones:208]Año:3<<>gYear) | ([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493#0))
				$l_recNumComplementoEval:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_RegistroHistorico:87;->[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504)
			Else 
				$l_recNumComplementoEval:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1)
			End if 
			If ($l_recNumComplementoEval<0)
				CREATE RECORD:C68([Alumnos_ComplementoEvaluacion:209])
				[Alumnos_ComplementoEvaluacion:209]ID_Institucion:2:=[Alumnos_Calificaciones:208]ID_institucion:2
				[Alumnos_ComplementoEvaluacion:209]Año:3:=[Alumnos_Calificaciones:208]Año:3
				[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=[Alumnos_Calificaciones:208]ID_Alumno:6
				[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
				[Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48:=[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493
				[Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4:=[Alumnos_Calificaciones:208]NIvel_Numero:4
				SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
				KRL_ReloadAsReadOnly (->[Alumnos_ComplementoEvaluacion:209])
			End if 
			
			  //inicialización de campos para soportar nulos, representados por -10
			For ($i;11;26;5)
				Field:C253(208;$i)->:=-10
				Field:C253(208;$i+1)->:=-10
				Field:C253(208;$i+2)->:=-10
				Field:C253(208;$i+3)->:=""
				Field:C253(208;$i+4)->:=""
			End for 
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-10
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-10
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=""
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""
			For ($i;42;412;5)
				Field:C253(208;$i)->:=-10
				Field:C253(208;$i+1)->:=-10
				Field:C253(208;$i+2)->:=-10
				Field:C253(208;$i+3)->:=""
				Field:C253(208;$i+4)->:=""
			End for 
			For ($i;417;487;5)
				Field:C253(208;$i)->:=-10
				Field:C253(208;$i+1)->:=-10
				Field:C253(208;$i+2)->:=-10
				Field:C253(208;$i+3)->:=""
				Field:C253(208;$i+4)->:=""
			End for 
			  // bonificaciones de fin de período
			For ($i;510;534;5)
				Field:C253(208;$i)->:=-10
				Field:C253(208;$i+1)->:=-10
				Field:C253(208;$i+2)->:=-10
				Field:C253(208;$i+3)->:=""
				Field:C253(208;$i+4)->:=""
			End for 
			
			If ((<>gYear=[Alumnos_Calificaciones:208]Año:3) & ([Alumnos_Calificaciones:208]NoDeLista:10=0))
				READ WRITE:C146([Asignaturas:18])
				RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
				[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49+1
				[Asignaturas:18]LastNumber:54:=[Asignaturas:18]LastNumber:54+1
				SAVE RECORD:C53([Asignaturas:18])
				KRL_ReloadAsReadOnly (->[Asignaturas:18])
				[Alumnos_Calificaciones:208]NoDeLista:10:=[Asignaturas:18]LastNumber:54
			End if 
			
			Case of 
				: (<>vs_AppDecimalSeparator=",")
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=Replace string:C233([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;".";<>vs_AppDecimalSeparator)
				: (<>vs_AppDecimalSeparator=".")
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=Replace string:C233([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;",";<>vs_AppDecimalSeparator)
			End case 
			[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503:=EV2_RegistroHaSidoEvaluado 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If (([Alumnos_Calificaciones:208]Año:3=<>gYear) & ([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493=0))  //MONO TICKET 184433
				[Alumnos_Calificaciones:208]ID_Asignatura:5:=Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
				[Alumnos_Calificaciones:208]ID_Alumno:6:=Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
			Else 
				[Alumnos_Calificaciones:208]ID_Asignatura:5:=-Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
				[Alumnos_Calificaciones:208]ID_Alumno:6:=-Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
			End if 
			[Alumnos_Calificaciones:208]Llave_principal:1:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			[Alumnos_Calificaciones:208]Llave_Asignatura:494:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))
			[Alumnos_Calificaciones:208]Llave_Alumno:495:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			
			If ([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493#0)
				[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493))+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			End if 
			
			If ([Alumnos_Calificaciones:208]Año:3=<>gYear)
				If ([Alumnos_Calificaciones:208]ID_Asignatura:5#Old:C35([Alumnos_Calificaciones:208]ID_Asignatura:5))
					READ WRITE:C146([Asignaturas:18])
					$l_IdAsignaturaAnterior:=Old:C35([Alumnos_Calificaciones:208]ID_Asignatura:5)
					KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignaturaAnterior;True:C214)
					[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49-1
					SAVE RECORD:C53([Asignaturas:18])
					KRL_ReloadAsReadOnly (->[Asignaturas:18])
					
					READ WRITE:C146([Asignaturas:18])
					RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
					[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49+1
					[Asignaturas:18]LastNumber:54:=[Asignaturas:18]LastNumber:54+1
					SAVE RECORD:C53([Asignaturas:18])
					KRL_ReloadAsReadOnly (->[Asignaturas:18])
					[Alumnos_Calificaciones:208]NoDeLista:10:=[Asignaturas:18]LastNumber:54
				End if 
				
				If ([Alumnos_Calificaciones:208]ID_Asignatura:5#[Asignaturas:18]Numero:1)
					READ ONLY:C145([Asignaturas:18])
					RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
				End if 
				
				
				  // Inicialización de los campos de promedios anuales
				$l_refTablaCalificaciones:=208
				For ($i;11;26;5)
					Case of 
						: ((Field:C253($l_refTablaCalificaciones;$i)->=-10) | (Field:C253($l_refTablaCalificaciones;$i+4)->=""))  // sin evaluación
							Field:C253($l_refTablaCalificaciones;$i+1)->:=-10
							Field:C253($l_refTablaCalificaciones;$i+2)->:=-10
							Field:C253($l_refTablaCalificaciones;$i+3)->:=""
							Field:C253($l_refTablaCalificaciones;$i+4)->:=""
							
						: ((Field:C253($l_refTablaCalificaciones;$i)->=-3) | (Field:C253($l_refTablaCalificaciones;$i+4)->="X"))  // eximido
							Field:C253($l_refTablaCalificaciones;$i)->:=-3
							Field:C253($l_refTablaCalificaciones;$i+1)->:=-3
							Field:C253($l_refTablaCalificaciones;$i+2)->:=-3
							Field:C253($l_refTablaCalificaciones;$i+3)->:="X"
							
						: ((Field:C253($l_refTablaCalificaciones;$i)->=-2) | (Field:C253($l_refTablaCalificaciones;$i+4)->="P"))  // pendiente
							Field:C253($l_refTablaCalificaciones;$i)->:=-2
							Field:C253($l_refTablaCalificaciones;$i+1)->:=-2
							Field:C253($l_refTablaCalificaciones;$i+2)->:=-2
							Field:C253($l_refTablaCalificaciones;$i+3)->:="P"
							
						: ((Field:C253($l_refTablaCalificaciones;$i)->=-4) | (Field:C253($l_refTablaCalificaciones;$i+4)->="*"))  // no contabiliza en calculos
							Field:C253($l_refTablaCalificaciones;$i)->:=-4
							Field:C253($l_refTablaCalificaciones;$i+1)->:=-4
							Field:C253($l_refTablaCalificaciones;$i+2)->:=-4
							Field:C253($l_refTablaCalificaciones;$i+3)->:="*"
							
					End case 
				End for 
				
				
				
				
				Case of 
					: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="")
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-10
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-10
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""
					: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="P")
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-2
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-2
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-2
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="P"
					: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="X")
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="EX"
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-3
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-3
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-3
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="EX"
					: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="EX")
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-3
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-3
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-3
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="EX"
					: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="*")
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-4
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-4
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-4
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""
				End case 
				
				
				For ($i;42;412;5)
					Case of 
						: (Field:C253($l_refTablaCalificaciones;$i)->=-10)
							Field:C253($l_refTablaCalificaciones;$i+1)->:=-10
							Field:C253($l_refTablaCalificaciones;$i+2)->:=-10
							Field:C253($l_refTablaCalificaciones;$i+3)->:=""
							Field:C253($l_refTablaCalificaciones;$i+4)->:=""
							
						: (Field:C253($l_refTablaCalificaciones;$i)->=-3)
							Field:C253($l_refTablaCalificaciones;$i+4)->:="X"
							
						: (Field:C253($l_refTablaCalificaciones;$i)->=-2)
							Field:C253($l_refTablaCalificaciones;$i+4)->:="P"
							
						: (Field:C253($l_refTablaCalificaciones;$i)->=-4)
							Field:C253($l_refTablaCalificaciones;$i+4)->:="*"
							
					End case 
				End for 
				
				For ($i;510;534;5)
					Case of 
						: (Field:C253($l_refTablaCalificaciones;$i)->=-10)
							Field:C253($l_refTablaCalificaciones;$i+1)->:=-10
							Field:C253($l_refTablaCalificaciones;$i+2)->:=-10
							Field:C253($l_refTablaCalificaciones;$i+3)->:=""
							Field:C253($l_refTablaCalificaciones;$i+4)->:=""
							
						: (Field:C253($l_refTablaCalificaciones;$i)->=-3)
							Field:C253($l_refTablaCalificaciones;$i+4)->:="X"
							
						: (Field:C253($l_refTablaCalificaciones;$i)->=-2)
							Field:C253($l_refTablaCalificaciones;$i+4)->:="P"
							
						: (Field:C253($l_refTablaCalificaciones;$i)->=-4)
							Field:C253($l_refTablaCalificaciones;$i+4)->:="*"
					End case 
				End for 
				
				
				[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503:=EV2_RegistroHaSidoEvaluado 
				
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			If (Not:C34(<>vb_ImportHistoricos_STX))
				$l_recNumComplementoEval:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
				If ($l_recNumComplementoEval>=0)
					$l_registroEliminado:=KRL_DeleteRecord (->[Alumnos_ComplementoEvaluacion:209];$l_recNumComplementoEval)
					READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
					If ($l_registroEliminado=0)
						$0:=-15010
					End if 
				End if 
				
				If (<>gYear=[Alumnos_Calificaciones:208]Año:3)
					READ WRITE:C146([Asignaturas:18])
					RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
					[Asignaturas:18]Numero_de_alumnos:49:=[Asignaturas:18]Numero_de_alumnos:49-1
					SAVE RECORD:C53([Asignaturas:18])
					UNLOAD RECORD:C212([Asignaturas:18])
					KRL_ReloadAsReadOnly (->[Asignaturas:18])
				End if 
			End if 
	End case 
	
	CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Alumnos_Calificaciones:208])
	SN3_MarcarRegistros (SN3_DTi_Calificaciones)
End if 