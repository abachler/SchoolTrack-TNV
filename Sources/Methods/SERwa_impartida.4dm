//%attributes = {}
  //TRACE
$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos_Atrasos:55])

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)

$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_profuuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_profesor")
$t_uuidasignatura:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_asignatura")
$t_fecha:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha")
$l_hora:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"hora"))
$t_impartida:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"impartida")
$t_motivo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"motivo")
$d_fecha:=Date:C102(DT_FechaISO_a_FechaHora ($t_fecha))
$b_impartida:=($t_impartida="true")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_profuuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (True:C214)  //si fuera necesario verificar algun permiso
		If (KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura)>-1)
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			READ WRITE:C146([Asignaturas_RegistroSesiones:168])
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora)
			If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
				AS_CreaSesionesAsignatura ([Asignaturas:18]Numero:1;$d_fecha)
				READ WRITE:C146([Asignaturas_RegistroSesiones:168])
				QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora)
			End if 
			If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
				$l_idSesion:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
				$d_fechaSesion:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
				$l_IdAsignatura:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
				$t_nombreAsignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]denominacion_interna:16)
				Case of 
					: (([Asignaturas_RegistroSesiones:168]Impartida:5=False:C215) & ($b_impartida=True:C214))
						$l_resultado:=1
						START TRANSACTION:C239
						[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16:=""
						[Asignaturas_RegistroSesiones:168]Impartida:5:=True:C214
						SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
						KRL_ReloadAsReadOnly (->[Asignaturas_RegistroSesiones:168])
						READ ONLY:C145([Alumnos_Calificaciones:208])
						QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_IdAsignatura)
						If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
							SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
							For ($i_alumnos;1;Size of array:C274($al_IdAlumnos))
								$l_resultado:=AL_InasistenciaDiariaPorHoras ($al_IdAlumnos{$i_alumnos};$d_fechaSesion)
								If ($l_resultado=0)
									$i_alumnos:=Size of array:C274($al_IdAlumnos)
								End if 
							End for 
							KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
						End if 
						If ($l_resultado=1)
							VALIDATE TRANSACTION:C240
							$t_actividad:="Sesión marcada como impartida: "+$t_nombreAsignatura+", hora "+String:C10($l_hora)+", el "+String:C10($d_fechaSesion;System date abbreviated:K1:2)
							LOG_RegisterEvt ($t_actividad;0;0;$idUser;"TeacherTrack")
							$0:=SERwa_GeneraRespuesta ("0";"Registro modificado con exito.")
						Else 
							CANCEL TRANSACTION:C241
							$0:=SERwa_GeneraRespuesta ("-4";"Registro no pudo ser modificado.")
						End if 
						
					: (([Asignaturas_RegistroSesiones:168]Impartida:5=False:C215) & ($b_impartida=False:C215))
						If ($t_motivo#"")
							[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16:=$t_motivo
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=""
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=""
							SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
							KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
							$0:=SERwa_GeneraRespuesta ("0";"Registro modificado con exito.")
						Else 
							$0:=SERwa_GeneraRespuesta ("-3";"Debe ingresar un motivo para no impartir.")
						End if 
					: (([Asignaturas_RegistroSesiones:168]Impartida:5=True:C214) & ($b_impartida=False:C215))
						If ($t_motivo#"")
							START TRANSACTION:C239
							[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16:=$t_motivo
							[Asignaturas_RegistroSesiones:168]Impartida:5:=False:C215
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=""
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=""
							SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
							KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
							QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_idSesion)
							$l_resultado:=1
							If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
								SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnosAusentesSesion)
								$l_resultado:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
							End if 
							If ($l_resultado=1)
								READ ONLY:C145([Alumnos_Calificaciones:208])
								READ WRITE:C146([Alumnos_Atrasos:55])
								QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_IdAsignatura)
								If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
									SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
									For ($i_alumnos;1;Size of array:C274($al_IdAlumnos))
										QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$al_IdAlumnos{$i_alumnos};*)
										QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fechaSesion;*)
										QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=$l_hora)
										DELETE RECORD:C58([Alumnos_Atrasos:55])
										$l_resultado:=AL_InasistenciaDiariaPorHoras ($al_IdAlumnos{$i_alumnos};$d_fechaSesion)
										If ($l_resultado=0)
											$i_alumnos:=Size of array:C274($al_IdAlumnos)
										End if 
									End for 
									KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
								End if 
							End if 
							If ($l_resultado=1)
								VALIDATE TRANSACTION:C240
								$t_actividad:="Sesión marcada como no impartida: "+$t_nombreAsignatura+", hora "+String:C10($l_hora)+", el "+String:C10($d_fechaSesion;System date abbreviated:K1:2)
								LOG_RegisterEvt ($t_actividad;0;0;$idUser;"TeacherTrack")
								$0:=SERwa_GeneraRespuesta ("0";"Registro modificado con exito.")
							Else 
								CANCEL TRANSACTION:C241
								$0:=SERwa_GeneraRespuesta ("-4";"Registro no pudo ser modificado.")
							End if 
						Else 
							$0:=SERwa_GeneraRespuesta ("-3";"Debe ingresar un motivo para no impartir.")
						End if 
				End case 
			Else 
				$0:=SERwa_GeneraRespuesta ("-5";"Sesión no encontrada.")
			End if 
		Else 
			$0:=SERwa_GeneraRespuesta ("-2";"Asignatura inexistente.")
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 