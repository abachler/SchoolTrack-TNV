//%attributes = {}
  //TGR_AlumnosInasistencias

C_LONGINT:C283($periodo;$old_Periodo)
C_BOOLEAN:C305($executeTrigger)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_Inasistencias:10]ID:12:=SQ_SeqNumber (->[Alumnos_Inasistencias:10]ID:12)
			If ([Alumnos_Inasistencias:10]Año:8=0)
				[Alumnos_Inasistencias:10]Año:8:=<>gYear
			End if 
			If ([Alumnos_Inasistencias:10]Año:8=<>gYear)
				$executeTrigger:=True:C214
				[Alumnos_Inasistencias:10]Alumno_Numero:4:=Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4)
			Else 
				$executeTrigger:=False:C215
				[Alumnos_Inasistencias:10]Alumno_Numero:4:=-Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4)
			End if 
			[Alumnos_Inasistencias:10]LlavePrimaria:13:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Inasistencias:10]Año:8)+"."+String:C10([Alumnos_Inasistencias:10]Nivel_Numero:9)+"."+String:C10(Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4))
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If ([Alumnos_Inasistencias:10]Año:8=<>gYear)
				[Alumnos_Inasistencias:10]Alumno_Numero:4:=Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4)
			Else 
				[Alumnos_Inasistencias:10]Alumno_Numero:4:=-Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4)
			End if 
			[Alumnos_Inasistencias:10]LlavePrimaria:13:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Inasistencias:10]Año:8)+"."+String:C10([Alumnos_Inasistencias:10]Nivel_Numero:9)+"."+String:C10(Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4))
			
			
			If (([Alumnos_Inasistencias:10]Fecha:1#Old:C35([Alumnos_Inasistencias:10]Fecha:1)) | ([Alumnos_Inasistencias:10]Justificación:2#Old:C35([Alumnos_Inasistencias:10]Justificación:2)) | (Modified:C32([Alumnos_Inasistencias:10]Observaciones:3)))
				$executeTrigger:=True:C214
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			$executeTrigger:=True:C214
	End case 
	
	
	$crearTareaBatch:=False:C215
	
	If ((Not:C34(<>vb_AvoidTriggerExecution)) & ($executeTrigger))
		RELATE ONE:C42([Alumnos_Inasistencias:10]Alumno_Numero:4)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		If (([Alumnos_Inasistencias:10]Fecha:1>=vdSTR_Periodos_InicioEjercicio) & ([Alumnos_Inasistencias:10]Fecha:1<=vdSTR_Periodos_FinEjercicio))
			$devolverPeriodoMasCercano:=False:C215
			$old_Periodo:=PERIODOS_PeriodosActuales (Old:C35([Alumnos_Inasistencias:10]Fecha:1);$devolverPeriodoMasCercano)
			$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos_Inasistencias:10]Alumno_Numero:4)
			KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
			
			If (OK=1)
				  //si la inasistencia estaba registrada previamente se decrementan los totales en los registros de sintesis
				If ($old_Periodo>0)
					  //actualización del registro del período
					If (Old:C35([Alumnos_Inasistencias:10]Justificación:2)#"")
						Case of 
							: ($old_Periodo=1)
								[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116:=[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116-1
							: ($old_Periodo=2)
								[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145:=[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145-1
							: ($old_Periodo=3)
								[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174:=[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174-1
							: ($old_Periodo=4)
								[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203:=[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203-1
							: ($old_Periodo=5)
								[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232:=[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232-1
						End case 
					Else 
						Case of 
							: ($old_Periodo=1)
								[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117:=[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117-1
							: ($old_Periodo=2)
								[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146:=[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146-1
							: ($old_Periodo=3)
								[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175:=[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175-1
							: ($old_Periodo=4)
								[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204:=[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204-1
							: ($old_Periodo=5)
								[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233:=[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233-1
						End case 
						
					End if 
					[Alumnos_SintesisAnual:210]Inasistencias_Dias:30:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-1
				End if 
				
				
				
				If ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
					  //se incrementan los valores de los totales en los registros de sintesis
					$devolverPeriodoMasCercano:=False:C215
					$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Inasistencias:10]Fecha:1;$devolverPeriodoMasCercano)
					If ($periodo>0)
						
						If (OK=1)
							If ([Alumnos_Inasistencias:10]Justificación:2#"")
								Case of 
									: ($periodo=1)
										[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116:=[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116+1
									: ($periodo=2)
										[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145:=[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145+1
									: ($periodo=3)
										[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174:=[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174+1
									: ($periodo=4)
										[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203:=[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203+1
									: ($periodo=5)
										[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232:=[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232+1
								End case 
							Else 
								Case of 
									: ($periodo=1)
										[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117:=[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117+1
									: ($periodo=2)
										[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146:=[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146+1
									: ($periodo=3)
										[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175:=[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175+1
									: ($periodo=4)
										[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204:=[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204+1
									: ($periodo=5)
										[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233:=[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233+1
								End case 
							End if 
						End if 
					End if 
				End if 
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
				
			Else 
				$0:=BM_CreateRequest ("Cuenta inasistencias";String:C10([Alumnos_Inasistencias:10]Alumno_Numero:4);String:C10([Alumnos_Inasistencias:10]Alumno_Numero:4))
			End if 
			
			
		End if 
	End if 
	SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_InasistDiaria)
	  //LIMPIEZA
End if 