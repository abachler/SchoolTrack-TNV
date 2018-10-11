//%attributes = {}
  // AL_RegistraInasistencia()
  // Por: Alberto Bachler: 21/10/13, 13:41:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_mostrarAviso)
C_DATE:C307($d_fechaInasistencia;$d_ultimaFechaInasistencia)
_O_C_INTEGER:C282($i_alumnos;$i_fechas)
C_LONGINT:C283($l_elemento;$l_error;$l_idLicencia;$l_modoRegistroAsistencia;$l_opcionUsuario)
C_TEXT:C284($t_mensaje;$t_metodoRegistroInasistencia)

ARRAY DATE:C224($ad_licenciaDesde;0)
ARRAY DATE:C224($ad_licenciaHasta;0)
ARRAY TEXT:C222($at_TipoLicencia;0)
ARRAY LONGINT:C221($al_idLicencia;0)
If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	$b_mostrarAviso:=False:C215
	If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
		$t_metodoRegistroInasistencia:=PREF_fGet (<>lUSR_CurrentUserID;"Inasistencias")
		If (($t_metodoRegistroInasistencia="") | (IT_AltKeyIsDown ))
			$t_mensaje:="Puede ingresar las inasistencias de dos maneras: "+"\r"
			$t_mensaje:=$t_mensaje+"   - seleccionando a los alumnos en la lista"+"\r"
			$t_mensaje:=$t_mensaje+"   - ingresando los números de lista de curso"+"\r"
			$t_mensaje:=$t_mensaje+"¿ Que método desea utilizar ?"+"\r\r"
			$t_mensaje:=$t_mensaje+"Si más tarde desea cambiar esta opción presione la tecla Alt"+" cuando haga clic en el botón de registro de atrasos."
			$l_opcionUsuario:=CD_Dlog (0;$t_mensaje;__ ("");__ ("Número de Lista");__ ("Selección");__ ("Cancelar"))
			Case of 
				: ($l_opcionUsuario=1)
					PREF_Set (<>lUSR_CurrentUserID;"Inasistencias";"Numeros")
					$t_metodoRegistroInasistencia:="Numeros"
				: ($l_opcionUsuario=2)
					PREF_Set (<>lUSR_CurrentUserID;"Inasistencias";"Selección")
					$t_metodoRegistroInasistencia:="Selección"
				: ($l_opcionUsuario=3)
					$t_metodoRegistroInasistencia:=""
			End case 
		End if 
		
		If (vLocation="Browser")
			$l_error:=AL_GetSelect (xALP_Browser;abrSelect)
		End if 
		
		Case of 
			: (($t_metodoRegistroInasistencia="Numeros") & (vLocation="Browser"))
				WDW_OpenDialogInDrawer (->[Alumnos_Conducta:8];"ABSExpress")
				ARRAY TEXT:C222(atABS_Alumnos;0)
				ARRAY LONGINT:C221(alABS_AlumnosID;0)
				
			: (($t_metodoRegistroInasistencia="Selección") | (vLocation="Input"))
				READ ONLY:C145([Alumnos_Licencias:73])
				READ ONLY:C145([Alumnos:2])
				If (Size of array:C274(abrSelect)>0)
					If (vLocation="Browser")
						GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{1}})
					End if 
				End if 
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				WDW_OpenDialogInDrawer (->[Alumnos_Inasistencias:10];"Input")
				If (ok=1)
					vb_AsignaSituacionfinal:=True:C214
					$b_mostrarAviso:=False:C215
					$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
					If ((Size of array:C274(abrSelect)>1) & (vLocation="Browser"))
						For ($i_alumnos;1;Size of array:C274(abrSelect))
							READ ONLY:C145([Alumnos:2])
							GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{$i_alumnos}})
							PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
							
							If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
								If ($l_modoRegistroAsistencia=1)
									QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
									SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_licenciaDesde;[Alumnos_Licencias:73]Hasta:3;$ad_licenciaHasta;[Alumnos_Licencias:73]ID:6;$al_idLicencia;[Alumnos_Licencias:73]Tipo_licencia:4;$at_TipoLicencia)
									$d_fechaInasistencia:=dFrom
									$d_ultimaFechaInasistencia:=dTo
									Repeat 
										READ ONLY:C145([Alumnos:2])
										GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{$i_alumnos}})
										QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
										QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$d_fechaInasistencia)
										If ((Records in selection:C76([Alumnos_Inasistencias:10])=0) & (Find in array:C230(adSTR_Calendario_Feriados;$d_fechaInasistencia)=-1) & (DateIsValid ($d_fechaInasistencia;0) & ([Alumnos:2]Fecha_de_Ingreso:41<=$d_fechaInasistencia)))
											CREATE RECORD:C68([Alumnos_Inasistencias:10])
											[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
											[Alumnos_Inasistencias:10]Observaciones:3:=vt_observaciones
											[Alumnos_Inasistencias:10]Fecha:1:=$d_fechaInasistencia
											[Alumnos_Inasistencias:10]RegistradaEl:11:=Current date:C33(*)
											[Alumnos_Inasistencias:10]RegistradaPor:10:=<>tUSR_CurrentUser
											[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29  //ASM 20130806 No se estaba guardando el nivel del alumno.
											For ($i_fechas;1;Size of array:C274($ad_licenciaDesde))
												$l_elemento:=Find in array:C230(<>aLicencias;$at_TipoLicencia{$i_fechas})
												If (($d_fechaInasistencia>=$ad_licenciaDesde{$i_fechas}) & ($d_fechaInasistencia<=$ad_licenciaHasta{$i_fechas}) & (($l_elemento=1) | ($l_elemento=2)))
													[Alumnos_Inasistencias:10]Licencia:5:=$al_idLicencia{$i_fechas}
													[Alumnos_Inasistencias:10]Justificación:2:=$at_TipoLicencia{$i_fechas}+" Nº "+String:C10($al_idLicencia{$i_fechas})
													[Alumnos_Inasistencias:10]Observaciones:3:=vt_observaciones
													$i_fechas:=Size of array:C274($ad_licenciaDesde)
												End if 
											End for 
											LOG_RegisterEvt ("Conducta - Registro de inasistencia diaria: Entre los días "+String:C10(dFrom)+" - "+String:C10(dTo)+","+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
											SAVE RECORD:C53([Alumnos_Inasistencias:10])
											UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
											vb_AsignaSituacionfinal:=True:C214
											AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
											vb_AsignaSituacionfinal:=False:C215
											
										End if 
										$d_fechaInasistencia:=$d_fechaInasistencia+1
									Until ($d_fechaInasistencia>$d_ultimaFechaInasistencia)
								Else 
									$b_mostrarAviso:=True:C214
								End if 
							End if 
						End for 
						If ($b_mostrarAviso)
							CD_Dlog (0;__ ("Algunos alumnos cursan su enseñanza en niveles que no han sido configurados para el registro de asistencia diaria.\r\rNo se registraron las inasistencia para esos alumnos."))
						End if 
						
					Else 
						If ($l_modoRegistroAsistencia=1)
							If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
								PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
								QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
								SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_licenciaDesde;[Alumnos_Licencias:73]Hasta:3;$ad_licenciaHasta;[Alumnos_Licencias:73]ID:6;$al_idLicencia;[Alumnos_Licencias:73]Tipo_licencia:4;$at_TipoLicencia)
								$d_fechaInasistencia:=dFrom
								$d_ultimaFechaInasistencia:=dTo
								Repeat 
									QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
									QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=dFrom)
									If ((Records in selection:C76([Alumnos_Inasistencias:10])=0) & (Find in array:C230(adSTR_Calendario_Feriados;dFrom)=-1) & (DateIsValid (dFrom;0)))
										If (([Alumnos:2]Fecha_de_Ingreso:41=!00-00-00!) | ([Alumnos:2]Fecha_de_Ingreso:41<=dFrom))
											CREATE RECORD:C68([Alumnos_Inasistencias:10])
											[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
											[Alumnos_Inasistencias:10]Observaciones:3:=vt_observaciones
											[Alumnos_Inasistencias:10]Fecha:1:=dFrom
											[Alumnos_Inasistencias:10]RegistradaEl:11:=Current date:C33(*)
											[Alumnos_Inasistencias:10]RegistradaPor:10:=<>tUSR_CurrentUser
											[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29  //ASM 20130806 No se estaba guardando el nivel del alumno.
											For ($i_fechas;1;Size of array:C274($ad_licenciaDesde))
												$l_elemento:=Find in array:C230(<>aLicencias;$at_TipoLicencia{$i_fechas})
												If (($d_fechaInasistencia>=$ad_licenciaDesde{$i_fechas}) & ($d_fechaInasistencia<=$ad_licenciaHasta{$i_fechas}) & (($l_elemento=1) | ($l_elemento=2)))
													[Alumnos_Inasistencias:10]Licencia:5:=$al_idLicencia{$i_fechas}
													[Alumnos_Inasistencias:10]Justificación:2:=$at_TipoLicencia{$i_fechas}+" Nº "+String:C10($al_idLicencia{$i_fechas})
													[Alumnos_Inasistencias:10]Observaciones:3:=vt_observaciones
													$i_fechas:=Size of array:C274($ad_licenciaDesde)
												End if 
											End for 
											SAVE RECORD:C53([Alumnos_Inasistencias:10])
											LOG_RegisterEvt ("Conducta - Registro de inasistencia diaria: "+String:C10([Alumnos_Inasistencias:10]Fecha:1;7)+" - "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
											UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
											vb_AsignaSituacionfinal:=True:C214
											AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
											vb_AsignaSituacionfinal:=False:C215
										End if 
									End if 
									dFrom:=dFrom+1
								Until (dFrom>dTo)
							End if 
						Else 
							CD_Dlog (0;__ ("Este alumno cursa sus asignaturas en un nivel que no ha sido configurado para el registro de asistencia diaria.\r\rNo se registró la inasistencia."))
						End if 
					End if 
					vb_AsignaSituacionfinal:=False:C215
				End if 
		End case 
	Else 
		USR_ALERT_UserHasNoRights (4)
	End if 
End if 