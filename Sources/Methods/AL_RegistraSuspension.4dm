//%attributes = {}
  //AL_RegistraSuspension

$recnum_Alu_susp:=-1

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
		ARRAY LONGINT:C221($al_recNumAlumnos;0)
		$err:=AL_GetSelect (xALP_Browser;abrSelect)
		Case of 
			: ((vLocation="Browser") & (Size of array:C274(abrSelect)=0))
				REDUCE SELECTION:C351([Alumnos:2];0)
				
			: ((vLocation="Browser") & (Size of array:C274(abrSelect)>0))
				For ($i;1;Size of array:C274(aBrSelect))
					APPEND TO ARRAY:C911($al_recNumAlumnos;alBWR_recordNumber{aBrSelect{$i}})
				End for 
				If (Size of array:C274($al_recNumAlumnos)>0)
					KRL_GotoRecord (->[Alumnos:2];$al_recNumAlumnos{1})
					PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				End if 
			Else 
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				APPEND TO ARRAY:C911($al_recNumAlumnos;Record number:C243([Alumnos:2]))
		End case 
		
		WDW_OpenFormWindow (->[Alumnos_Suspensiones:12];"Input";-1;Movable form dialog box:K39:8;__ ("Registro de suspensión"))
		DIALOG:C40([Alumnos_Suspensiones:12];"Input")
		CLOSE WINDOW:C154
		
		If (ok=1)
			If ((vLocation="Browser") & (Size of array:C274(abrSelect)=0) & (Record number:C243([Alumnos:2])>No current record:K29:2))
				APPEND TO ARRAY:C911($al_recNumAlumnos;Record number:C243([Alumnos:2]))
			End if 
			
			QUERY:C277([xShell_Feriados:71];[xShell_Feriados:71]Fecha:1>=dFrom;*)
			QUERY:C277([xShell_Feriados:71]; & [xShell_Feriados:71]Fecha:1<=dTo)
			iDays:=dTo-dFrom+1-Records in selection:C76([xShell_Feriados:71])
			
			For ($i_alumno;1;Size of array:C274($al_recNumAlumnos))
				READ ONLY:C145([Alumnos:2])
				GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i_alumno})
				If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
					PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
					$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
					CREATE RECORD:C68([Alumnos_Suspensiones:12])
					[Alumnos_Suspensiones:12]Desde:5:=dfrom
					[Alumnos_Suspensiones:12]Hasta:6:=dTo
					[Alumnos_Suspensiones:12]Alumno_Numero:7:=[Alumnos:2]numero:1
					[Alumnos_Suspensiones:12]Nivel_Numero:10:=[Alumnos:2]nivel_numero:29
					[Alumnos_Suspensiones:12]Motivo:2:=sMotivo
					[Alumnos_Suspensiones:12]Días_de_suspensión:3:=iDays
					[Alumnos_Suspensiones:12]Profesor_Numero:4:=iProfID
					[Alumnos_Suspensiones:12]Observaciones:8:=vt_observaciones
					SAVE RECORD:C53([Alumnos_Suspensiones:12])
					
					
					If (((viSTR_CrearInasistencias=1) | (viSTR_CrearInasistenciasFuturas=1)) & ($modoRegistroAsistencia=1))
						$date:=dFrom
						Repeat 
							READ WRITE:C146([Alumnos_Inasistencias:10])
							QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_Suspensiones:12]Alumno_Numero:7;*)
							QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$date)
							If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
								If ((Find in array:C230(adSTR_Calendario_Feriados;$date)=-1) & (DateIsValid ($date;0)))
									If (($date>Current date:C33(*)) & (viSTR_CrearInasistenciasFuturas=0))
										$date:=dTo+1
									Else 
										If (($date<=Current date:C33(*)) | (viSTR_CrearInasistenciasFuturas=1))
											CREATE RECORD:C68([Alumnos_Inasistencias:10])
											[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
											[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29
											[Alumnos_Inasistencias:10]Fecha:1:=$date
											[Alumnos_Inasistencias:10]Observaciones:3:="Suspendido por "+sMotivo
											SAVE RECORD:C53([Alumnos_Inasistencias:10])
											UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
										End if 
									End if 
								End if 
							End if 
							$date:=$date+1
						Until ($date>dTo)
					End if 
					
					
					If ($modoRegistroAsistencia=2)
						  // agrego una referencia a la suspensión en las obeservaciones del registro de inasistencia a clases
						QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos_Suspensiones:12]Alumno_Numero:7;*)
						QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=[Alumnos_Suspensiones:12]Desde:5;*)
						QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4<=[Alumnos_Suspensiones:12]Hasta:6)
						If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
							For ($i;1;Records in selection:C76([Asignaturas_Inasistencias:125]))
								$isReadWrite:=KRL_LoadRecordLoop (->[Asignaturas_Inasistencias:125];5)
								If ($isReadWrite)
									If ([Asignaturas_Inasistencias:125]Observaciones:5#"")
										[Asignaturas_Inasistencias:125]Observaciones:5:=[Alumnos_Inasistencias:10]Observaciones:3+"\r"+"Suspendido por "+sMotivo
									Else 
										[Alumnos_Inasistencias:10]Observaciones:3:="Suspendido por "+sMotivo
									End if 
									SAVE RECORD:C53([Asignaturas_Inasistencias:125])
									AL_InasistenciaDiariaPorHoras ([Alumnos_Suspensiones:12]Alumno_Numero:7;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
									UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
									NEXT RECORD:C51([Asignaturas_Inasistencias:125])
								End if 
							End for 
						End if 
						
						  // creo las inasistencias a clases en los días en que hay sesiones de clases si la opción de creación está activada
						If (viSTR_CrearInasistencias=1)
							  //20160725 ASM Ticket 164838 
							KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Suspensiones:12]Alumno_Numero:7)
							CREATE SET:C116([Alumnos_Calificaciones:208];"calificaciones")
							SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IDAsignatura)
							$d_FechaDesde:=[Alumnos_Suspensiones:12]Desde:5
							$d_fechaFinal:=[Alumnos_Suspensiones:12]Hasta:6
							While ($d_FechaDesde<=$d_fechaFinal)
								$dayNumber:=DT_GetDayNumber_ISO8601 ($d_FechaDesde)
								QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$dayNumber)
								QRY_QueryWithArray (->[TMT_Horario:166]ID_Asignatura:5;->$al_IDAsignatura;True:C214)
								SELECTION TO ARRAY:C260([TMT_Horario:166]ID_Asignatura:5;$aIdAsignatura;[TMT_Horario:166]NumeroHora:2;$aNumeroHora;[TMT_Horario:166]SesionesHasta:13;$aDateTo;[TMT_Horario:166]No_Ciclo:14;$aNumeroCiclo)
								For ($i;1;Size of array:C274($aIdAsignatura))
									QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$aIdAsignatura{$i};*)
									QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_FechaDesde)
									If ((Records in selection:C76([Asignaturas_RegistroSesiones:168])=0) & (DateIsValid ($d_FechaDesde;0)))
										ASrs_CreaRegistro ($aIdAsignatura{$i};$aNumeroHora{$i};$aNumeroCiclo{$i};$d_FechaDesde)
									End if 
								End for 
								$d_FechaDesde:=$d_FechaDesde+1
							End while 
							
							
							USE SET:C118("calificaciones")
							KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
							QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=[Alumnos_Suspensiones:12]Desde:5)
							QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;[Alumnos_Suspensiones:12]Hasta:6)
							
							ARRAY LONGINT:C221($al_RecNums;0)
							LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNums;"")
							For ($i_registros;1;Size of array:C274($al_RecNums))
								GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_RecNums{$i_registros})
								QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos_Suspensiones:12]Alumno_Numero:7;*)
								QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
								If (Records in selection:C76([Asignaturas_Inasistencias:125])=0)
									CREATE RECORD:C68([Asignaturas_Inasistencias:125])
									[Asignaturas_Inasistencias:125]Año:11:=<>gYear
									[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
									[Asignaturas_Inasistencias:125]Dia:7:=[Asignaturas_RegistroSesiones:168]NumeroDia:15
									[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
									[Asignaturas_Inasistencias:125]ID:10:=SQ_SeqNumber (->[Asignaturas_Inasistencias:125]ID:10)
									[Asignaturas_Inasistencias:125]ID_Alumno:2:=[Alumnos_Suspensiones:12]Alumno_Numero:7
									[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
									[Asignaturas_Inasistencias:125]ID_Sesión:1:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
									[Asignaturas_Inasistencias:125]Observaciones:5:="Suspendido por "+sMotivo
									SAVE RECORD:C53([Asignaturas_Inasistencias:125])
									UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
								End if 
								AL_InasistenciaDiariaPorHoras ([Alumnos_Suspensiones:12]Alumno_Numero:7;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
							End for 
							$success:=AL_TotalizaInasistencias ([Alumnos_Suspensiones:12]Alumno_Numero:7;[Alumnos:2]nivel_numero:29)
							SET_ClearSets ("calificaciones")
						End if 
						
					End if 
				End if 
				
			End for 
		End if 
	Else 
		USR_ALERT_UserHasNoRights (2)
	End if 
End if 


