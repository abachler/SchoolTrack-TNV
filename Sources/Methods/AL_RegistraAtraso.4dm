//%attributes = {}
  //AL_RegistraAtraso

C_LONGINT:C283($i;$modoRegistroAsistencia;$numero_de_bloque;$rn_inasistencia;$l_idAsignatura)  //MONO 180505
C_BOOLEAN:C305($locked;$displayAlert;$b_esIntersesion)  //MONO 180505
C_TEXT:C284($msj_inasistencia;$msg_log)
C_OBJECT:C1216($ob_atraso)  //MONO 180505
$displayAlert:=False:C215

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
		$method:=PREF_fGet (<>lUSR_CurrentUserID;"Atrasos")
		If (($method="") | (IT_AltKeyIsDown ))
			$m:="Puede ingresar los atrasos de dos maneras: "+"\r"
			$m:=$m+"   - seleccionando a los alumnos en la lista"+"\r"
			$m:=$m+"   - ingresando los números de lista de curso"+"\r"
			$m:=$m+"¿ Que método desea utilizar ?"+"\r\r"
			$m:=$m+"(si más tarde desea cambiar esta opción presione la tecla Alt"+" cuando haga clic en el botón de registro de atrasos)"
			$r:=CD_Dlog (0;$m;__ ("");__ ("Nº de Lista");__ ("Selección");__ ("Cancelar"))
			Case of 
				: ($r=1)
					PREF_Set (<>lUSR_CurrentUserID;"Atrasos";"Numeros")
					$method:="Numeros"
				: ($r=2)
					PREF_Set (<>lUSR_CurrentUserID;"Atrasos";"Selección")
					$method:="Selección"
				: ($r=3)
					$method:=""
			End case 
		End if 
		
		If (vLocation="Browser")
			$err:=AL_GetSelect (xALP_Browser;abrSelect)
		End if 
		
		
		Case of 
			: (($method="Numeros") & (vLocation="Browser"))
				ARRAY TEXT:C222(<>aExAbs1;0)
				ARRAY LONGINT:C221(<>aExAbs2;0)
				WDW_OpenDialogInDrawer (->[Alumnos_Conducta:8];"LateExpress")
				AT_Initialize (-><>aExAbs1;-><>aExAbs2;-><>aExAbs3)  //EMA 05/10/06
				
			: (($method="Selección") | (vLocation="Input"))
				$displayAlert:=False:C215
				READ ONLY:C145([Alumnos:2])
				If (Size of array:C274(abrSelect)>0)
					If (vLocation="Browser")
						GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{1}})
					End if 
					  //PERIODOS_LoadData ([Alumnos]Nivel_Número)
				Else 
					  //PERIODOS_LoadData (0;-1)
				End if 
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				WDW_OpenDialogInDrawer (->[Alumnos_Atrasos:55];"Input")
				If ((ok=1) & (dFrom#!00-00-00!))
					$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Lates_Mode:16)
					$b_esIntersesion:=(cb_AtrasoInterhora=1)  //MONO 180505
					$b_justificarAtraso:=(cb_justificarAtraso=1)  //MONO 180505
					
					If ((Size of array:C274(abrSelect)>1) & (vLocation="Browser"))
						
						C_BOOLEAN:C305($vb_ValidDate4All)
						ARRAY LONGINT:C221($al_num_niv;0)
						ARRAY LONGINT:C221($al_IdConfigPeriodo;0)
						For ($i;1;Size of array:C274(aBrSelect))
							KRL_GotoRecord (->[Alumnos:2];alBWR_recordNumber{aBrSelect{$i}})
							APPEND TO ARRAY:C911($al_num_niv;[Alumnos:2]nivel_numero:29)
						End for 
						AT_DistinctsArrayValues (->$al_num_niv)
						$vb_ValidDate4All:=True:C214
						
						READ ONLY:C145([xxSTR_Niveles:6])
						QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;$al_num_niv)
						AT_DistinctsFieldValues (->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;->$al_IdConfigPeriodo)
						
						If (Size of array:C274($al_IdConfigPeriodo)>1)
							For ($i;1;Size of array:C274($al_IdConfigPeriodo))
								If ($vb_ValidDate4All)
									$vb_ValidDate4All:=DateIsValid (dFrom;0;$al_IdConfigPeriodo{$i})
								End if 
							End for 
						End if 
						If ($vb_ValidDate4All)
							For ($i;1;Size of array:C274(aBrSelect))
								READ ONLY:C145([Alumnos:2])
								GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{$i}})
								$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
								
								If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
									
									If ($modoRegistroAtrasos=1)
										
										$vb_registrar_atraso:=AL_AtrasoValidacion (dFrom;[Alumnos:2]numero:1;(cb_AtrasoInterhora=1);True:C214)
										If ($vb_registrar_atraso)
											
											Case of 
												: ($modoRegistroAsistencia=2)  //hora detallada
													  //$vb_permiso:=((USR_checkRights ("D";->[Asignaturas_Inasistencias])) & (<>viSTR_NoModificarNotas=0) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
													$vb_permiso:=((USR_checkRights ("D";->[Asignaturas_Inasistencias:125])) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
													$vb_registrar_atraso:=AL_Atraso_CheckInasistenciaPHD ([Alumnos:2]numero:1;dFrom;vhora_atraso;->$numero_de_bloque;$vb_permiso;$b_esIntersesion;->$l_idAsignatura;True:C214)  //MONO 180505
													
												: ($modoRegistroAsistencia=1)  //diaria
													  //$vb_permiso:=((USR_checkRights ("D";->[Alumnos_Inasistencias])) & (<>viSTR_NoModificarNotas=0) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
													$vb_permiso:=((USR_checkRights ("D";->[Alumnos_Inasistencias:10])) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
													$vb_registrar_atraso:=AL_Atraso_CheckInasistenciaDia ([Alumnos:2]numero:1;dFrom;$vb_permiso;True:C214)
													
											End case 
											
											If ($vb_registrar_atraso)
												$ob_atraso:=OB_Create   //MONO 180505
												OB_SET ($ob_atraso;->dFrom;"fecha")  //MONO 180505
												OB_SET ($ob_atraso;->[Alumnos:2]numero:1;"idAlumno")  //MONO 180505
												OB_SET ($ob_atraso;->vt_observaciones;"observacion")  //MONO 180505
												OB_SET ($ob_atraso;->$b_esIntersesion;"esIntersesion")  //MONO 180505
												OB_SET ($ob_atraso;->vi_TiempoAtraso;"minutosAtraso")  //MONO 180505
												OB_SET ($ob_atraso;->$numero_de_bloque;"numeroHora")  //MONO 180505
												OB_SET ($ob_atraso;->vhora_atraso;"horaAtraso")  //MONO 180505
												OB_SET ($ob_atraso;->$l_idAsignatura;"idAsignatura")  //MONO 180505
												OB_SET ($ob_atraso;->$b_justificarAtraso;"justificar")  //MONO 180505
												OB_SET ($ob_atraso;->vIdJustificacion;"idJustificacion")  //MONO 180505
												AL_AlumnoAtrasoCreateRecord ($ob_atraso)  //MONO 180505
											End if 
										End if 
										
									Else 
										$displayALERT:=True:C214
									End if 
								End if 
							End for 
							
							If ($displayAlert)
								CD_Dlog (0;__ ("Algunos alumnos cursan su enseñanza en niveles que no han sido configurados para el registro de retardos diario.\r\rNo se registraron los retardos para esos alumnos."))
							End if 
							
						Else 
							CD_Dlog (0;__ ("La fecha: ")+String:C10(dFrom)+__ (" no es válida para las distintas configuraciones de peridos de los alumnos seleccionados. Revise las configuraciones o ingrese de manera separada los atrasos."))
						End if 
						
					Else 
						
						If ($modoRegistroAtrasos=1)
							If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
								$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
								
								$vb_registrar_atraso:=AL_AtrasoValidacion (dFrom;[Alumnos:2]numero:1;(cb_AtrasoInterhora=1);True:C214)
								If ($vb_registrar_atraso)
									
									Case of 
										: ($modoRegistroAsistencia=2)  //hora detallada
											  //$vb_permiso:=((USR_checkRights ("D";->[Asignaturas_Inasistencias])) & (<>viSTR_NoModificarNotas=0) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
											$vb_permiso:=((USR_checkRights ("D";->[Asignaturas_Inasistencias:125])) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
											$vb_registrar_atraso:=AL_Atraso_CheckInasistenciaPHD ([Alumnos:2]numero:1;dFrom;vhora_atraso;->$numero_de_bloque;$vb_permiso;$b_esIntersesion;->$l_idAsignatura;True:C214)  //MONO 180505
											
										: ($modoRegistroAsistencia=1)  //diaria
											  //$vb_permiso:=((USR_checkRights ("D";->[Alumnos_Inasistencias])) & (<>viSTR_NoModificarNotas=0) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
											$vb_permiso:=((USR_checkRights ("D";->[Alumnos_Inasistencias:10])) & (<>viSTR_CambiaInasistenciaxAtraso=1))  //verificamos el permiso del usuario para ofrecer la eliminación del registro de inasistencia,
											$vb_registrar_atraso:=AL_Atraso_CheckInasistenciaDia ([Alumnos:2]numero:1;dFrom;$vb_permiso;True:C214)
											$l_idAsignatura:=aIdAsignaturasAlumnos{aAsignaturasAlumno}  //MONO 180505
									End case 
									
									If ($vb_registrar_atraso)
										$ob_atraso:=OB_Create   //MONO 180505
										OB_SET ($ob_atraso;->dFrom;"fecha")  //MONO 180505
										OB_SET ($ob_atraso;->[Alumnos:2]numero:1;"idAlumno")  //MONO 180505
										OB_SET ($ob_atraso;->vt_observaciones;"observacion")  //MONO 180505
										OB_SET ($ob_atraso;->$b_esIntersesion;"esIntersesion")  //MONO 180505
										OB_SET ($ob_atraso;->vi_TiempoAtraso;"minutosAtraso")  //MONO 180505
										OB_SET ($ob_atraso;->$numero_de_bloque;"numeroHora")  //MONO 180505
										OB_SET ($ob_atraso;->vhora_atraso;"horaAtraso")  //MONO 180505
										OB_SET ($ob_atraso;->$l_idAsignatura;"idAsignatura")  //MONO 180505
										OB_SET ($ob_atraso;->$b_justificarAtraso;"justificar")  //MONO 180505
										OB_SET ($ob_atraso;->vIdJustificacion;"idJustificacion")  //MONO 180505
										
										AL_AlumnoAtrasoCreateRecord ($ob_atraso)  //MONO 180505
									End if 
								End if 
								
							End if 
							
						Else 
							CD_Dlog (0;__ ("Este alumno cursa sus asignaturas en un nivel que no ha sido configurado para el registro de retardos diario.\r\rNo se registró el retardo."))
						End if 
						
					End if 
				End if 
				
		End case 
	Else 
		USR_ALERT_UserHasNoRights (4)
	End if 
End if 