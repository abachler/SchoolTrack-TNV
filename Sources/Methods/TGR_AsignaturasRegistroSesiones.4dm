//%attributes = {}
  // // TGR_AsignaturasRegistroSesiones()
  //
  //
If (False:C215)
	  // Alberto Bachler: 09/01/13, 23:26:55
	  // Normalización, declaración de variables
	  // ---------------------------------------------
End if 
C_BOOLEAN:C305($b_devolverPeriodoMasCercano;$b_registroSoloLectura;$b_restarHoras;$b_sumarHoras)
C_LONGINT:C283($i_Alumnos;$l_numeroPeriodo)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_llaveSintesisAnual)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_Nivel;0)


C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		If ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2) | (Trigger event:C369=On Deleting Record Event:K3:3))
			If (KRL_FieldChanges (->[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3))
				[Asignaturas_RegistroSesiones:168]NumeroDia:15:=DT_GetDayNumber_ISO8601 ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
			End if 
			
			$t_llaveAsigHistorica:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas_RegistroSesiones:168]ID_Asignatura:2))  //MONO 184433
			$l_rnAsigHist:=Find in field:C653([Asignaturas_Historico:84]LlavePrimaria:9;$t_llaveAsigHistorica)  //MONO 184433
			
			If (([Asignaturas_RegistroSesiones:168]Año:13<<>gYear) | ($l_rnAsigHist>=0))  //MONO 184433
				[Asignaturas_RegistroSesiones:168]ID_Asignatura:2:=-Abs:C99([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			Else 
				[Asignaturas_RegistroSesiones:168]ID_Asignatura:2:=Abs:C99([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				
				$b_devolverPeriodoMasCercano:=False:C215
				$l_numeroPeriodo:=PERIODOS_PeriodosActuales ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$b_devolverPeriodoMasCercano)
				
				If ($l_numeroPeriodo>0)
					Case of 
						: (Trigger event:C369=On Saving New Record Event:K3:1)
							$b_registroSoloLectura:=KRL_ReadWrite (->[Asignaturas:18])
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
							If (Not:C34(Locked:C147([Asignaturas:18])))
								[Asignaturas:18]Horas_de_clases_efectivas:52:=[Asignaturas:18]Horas_de_clases_efectivas:52+1
								SAVE RECORD:C53([Asignaturas:18])
								If ([Asignaturas:18]Incide_en_Asistencia:45)
									$b_sumarHoras:=True:C214
								End if 
								KRL_ResetPreviousRWMode (->[Asignaturas:18];$b_registroSoloLectura)
							Else 
								$0:=BM_CreateRequest ("Cuenta horas de clase";String:C10([Asignaturas:18]Numero:1);String:C10([Asignaturas:18]Numero:1))
							End if 
							UNLOAD RECORD:C212([Asignaturas:18])
							
						: (Trigger event:C369=On Saving Existing Record Event:K3:2)  //disabled
							If (([Asignaturas_RegistroSesiones:168]Actividades:7#"") | ([Asignaturas_RegistroSesiones:168]Contenidos:6#"") | ([Asignaturas_RegistroSesiones:168]Observacion:12#""))
								[Asignaturas_RegistroSesiones:168]hasData:8:=True:C214
							Else 
								[Asignaturas_RegistroSesiones:168]hasData:8:=False:C215
							End if 
							Case of 
								: (([Asignaturas_RegistroSesiones:168]Impartida:5=True:C214) & (Old:C35([Asignaturas_RegistroSesiones:168]Impartida:5)=False:C215))
									$b_registroSoloLectura:=KRL_ReadWrite (->[Asignaturas:18])
									QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
									If (Not:C34(Locked:C147([Asignaturas:18])))
										[Asignaturas:18]Horas_de_clases_efectivas:52:=[Asignaturas:18]Horas_de_clases_efectivas:52+1
										SAVE RECORD:C53([Asignaturas:18])
										KRL_ResetPreviousRWMode (->[Asignaturas:18];$b_registroSoloLectura)
										If ([Asignaturas:18]Incide_en_Asistencia:45)
											$b_sumarHoras:=True:C214
										End if 
									Else 
										$0:=BM_CreateRequest ("Cuenta horas de clase";String:C10([Asignaturas:18]Numero:1);String:C10([Asignaturas:18]Numero:1))
									End if 
									UNLOAD RECORD:C212([Asignaturas:18])
									
								: (([Asignaturas_RegistroSesiones:168]Impartida:5=False:C215) & (Old:C35([Asignaturas_RegistroSesiones:168]Impartida:5)=True:C214))
									$b_registroSoloLectura:=KRL_ReadWrite (->[Asignaturas:18])
									  //RELATE ONE([Asignaturas_RegistroSesiones]ID_Asignatura)
									QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
									If (Not:C34(Locked:C147([Asignaturas:18])))
										[Asignaturas:18]Horas_de_clases_efectivas:52:=[Asignaturas:18]Horas_de_clases_efectivas:52-1
										SAVE RECORD:C53([Asignaturas:18])
										KRL_ResetPreviousRWMode (->[Asignaturas:18];$b_registroSoloLectura)
										If ([Asignaturas:18]Incide_en_Asistencia:45)
											$b_restarHoras:=True:C214
										End if 
									Else 
										$0:=BM_CreateRequest ("Cuenta horas de clase";String:C10([Asignaturas:18]Numero:1);String:C10([Asignaturas:18]Numero:1))
									End if 
									UNLOAD RECORD:C212([Asignaturas:18])
							End case 
							
						: (Trigger event:C369=On Deleting Record Event:K3:3)
							$b_registroSoloLectura:=KRL_ReadWrite (->[Asignaturas:18])
							If (Old:C35([Asignaturas_RegistroSesiones:168]Impartida:5)=True:C214)
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
								If (Not:C34(Locked:C147([Asignaturas:18])))
									[Asignaturas:18]Horas_de_clases_efectivas:52:=[Asignaturas:18]Horas_de_clases_efectivas:52-1
									SAVE RECORD:C53([Asignaturas:18])
									KRL_ResetPreviousRWMode (->[Asignaturas:18];$b_registroSoloLectura)
									If ([Asignaturas:18]Incide_en_Asistencia:45)
										$b_restarHoras:=True:C214
									End if 
								Else 
									$0:=BM_CreateRequest ("Cuenta horas de clase";String:C10([Asignaturas:18]Numero:1))
								End if 
								UNLOAD RECORD:C212([Asignaturas:18])
							End if 
					End case 
				End if 
				
				If ($b_sumarHoras | $b_restarHoras)
					EV2_RegistrosDeLaAsignatura ([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@";*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50#"Promovido anticipadamente";*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Fecha_de_retiro:42=!00-00-00!)
					
					SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_IdAlumnos;[Alumnos:2]nivel_numero:29;$al_Nivel)
					For ($i_Alumnos;1;Size of array:C274($al_IdAlumnos))
						
						$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($al_Nivel{$i_Alumnos})+"."+String:C10($al_IdAlumnos{$i_Alumnos})
						KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;True:C214)
						If (OK=1)
							
							Case of 
								: ($l_numeroPeriodo=1)
									$y_campo:=->[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99
								: ($l_numeroPeriodo=2)
									$y_campo:=->[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128
								: ($l_numeroPeriodo=3)
									$y_campo:=->[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157
								: ($l_numeroPeriodo=4)
									$y_campo:=->[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186
								: ($l_numeroPeriodo=5)
									$y_campo:=->[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215
							End case 
							Case of 
								: ($b_sumarHoras)
									$y_campo->:=$y_campo->+1
									
								: ($b_restarHoras)
									$y_campo->:=$y_campo->-1
							End case 
							SAVE RECORD:C53([Alumnos_SintesisAnual:210])
							UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
							READ ONLY:C145([Alumnos_SintesisAnual:210])
							
						Else 
							$0:=BM_CreateRequest ("Totaliza Horas Inasistencia";String:C10($al_IdAlumnos{$i_Alumnos}))
						End if 
					End for 
				End if 
			End if 
		End if 
		
		SN3_MarcarRegistros (100022)  //sesiones//MONO 22-05-14: pub sesiones
	End if 
End if 
