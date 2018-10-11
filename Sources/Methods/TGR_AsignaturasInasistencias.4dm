//%attributes = {}
  // TGR_AsignaturasInasistencias()
  //
  //
C_BOOLEAN:C305($b_devolverPeriodoMasCercano;$b_restaHoras;$b_sumaHoras)
C_LONGINT:C283($l_eventoDataBase;$l_idAlumno;$l_periodo)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_llaveSintesisAnual)

If (False:C215)  // historial del método
	  //  ---------------------------------------------
	  // Alberto Bachler: 10/01/13, 15:55:37
	  // Normalización, declaración de variables
	  // ---------------------------------------------
End if 

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		$l_eventoDataBase:=Trigger event:C369
		READ ONLY:C145([Asignaturas:18])
		RELATE ONE:C42([Asignaturas_Inasistencias:125]ID_Asignatura:6)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		$b_devolverPeriodoMasCercano:=False:C215
		$l_periodo:=PERIODOS_PeriodosActuales ([Asignaturas_Inasistencias:125]dateSesion:4;$b_devolverPeriodoMasCercano)
		
		$b_sumaHoras:=False:C215
		$b_restaHoras:=False:C215
		
		$id_alu:=Abs:C99([Asignaturas_Inasistencias:125]ID_Alumno:2)  //MONO 184433
		$id_asig:=Abs:C99([Asignaturas_Inasistencias:125]ID_Asignatura:6)  //MONO 184433
		$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
		$l_nivelAsig:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$id_asig;->[Asignaturas:18]Numero_del_Nivel:6)  //MONO 184433
		
		Case of 
			: ($l_eventoDataBase=On Saving New Record Event:K3:1)
				[Asignaturas_Inasistencias:125]ID:10:=SQ_SeqNumber (->[Asignaturas_Inasistencias:125]ID:10)
				If ([Asignaturas:18]Incide_en_Asistencia:45)
					$b_sumaHoras:=True:C214
				End if 
				
				If (([Asignaturas_Inasistencias:125]Año:11=<>gYear) & ($l_nivelAsig=$l_nivelAlu))  //MONO 184433
					[Asignaturas_Inasistencias:125]ID_Alumno:2:=Abs:C99([Asignaturas_Inasistencias:125]ID_Alumno:2)
					[Asignaturas_Inasistencias:125]ID_Asignatura:6:=Abs:C99([Asignaturas_Inasistencias:125]ID_Asignatura:6)
				Else 
					[Asignaturas_Inasistencias:125]ID_Alumno:2:=-Abs:C99([Asignaturas_Inasistencias:125]ID_Alumno:2)
					[Asignaturas_Inasistencias:125]ID_Asignatura:6:=-Abs:C99([Asignaturas_Inasistencias:125]ID_Asignatura:6)
				End if 
				
			: ($l_eventoDataBase=On Saving Existing Record Event:K3:2)
				
				
				If (([Asignaturas_Inasistencias:125]Año:11=<>gYear) & ($l_nivelAsig=$l_nivelAlu))  //MONO 184433
					[Asignaturas_Inasistencias:125]ID_Alumno:2:=Abs:C99([Asignaturas_Inasistencias:125]ID_Alumno:2)
					[Asignaturas_Inasistencias:125]ID_Asignatura:6:=Abs:C99([Asignaturas_Inasistencias:125]ID_Asignatura:6)
				Else 
					[Asignaturas_Inasistencias:125]ID_Alumno:2:=-Abs:C99([Asignaturas_Inasistencias:125]ID_Alumno:2)
					[Asignaturas_Inasistencias:125]ID_Asignatura:6:=-Abs:C99([Asignaturas_Inasistencias:125]ID_Asignatura:6)
				End if 
				
			: ($l_eventoDataBase=On Deleting Record Event:K3:3)
				If ([Asignaturas:18]Incide_en_Asistencia:45)
					$b_restaHoras:=True:C214
				End if 
				
		End case 
		
		If ($l_periodo>0)
			
			$l_idAlumno:=[Asignaturas_Inasistencias:125]ID_Alumno:2
			$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10($l_idAlumno)
			KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;True:C214)
			If (OK=1)
				
				Case of 
					: ($l_periodo=1)
						$y_campo:=->[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
					: ($l_periodo=2)
						$y_campo:=->[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
					: ($l_periodo=3)
						$y_campo:=->[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
					: ($l_periodo=4)
						$y_campo:=->[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
					: ($l_periodo=5)
						$y_campo:=->[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
				End case 
				Case of 
					: ($b_sumaHoras)
						$y_campo->:=$y_campo->+1
						
					: ($b_restaHoras)
						$y_campo->:=$y_campo->-1
				End case 
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
				READ ONLY:C145([Alumnos_SintesisAnual:210])
				
			Else 
				$0:=BM_CreateRequest ("Totaliza Horas Inasistencia";String:C10($l_idAlumno))
			End if 
			
		End if 
	End if 
	SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_InasistHoraDetalle)
End if 