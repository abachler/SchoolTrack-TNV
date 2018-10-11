//%attributes = {}
$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Alumnos_Inasistencias:10])
READ ONLY:C145([Asignaturas_Inasistencias:125])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_profuuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_profesor")
$t_uuidinasistencia:=NV_GetValueFromPairedArrays ($y_names;$y_data;"uuid_inasistencia")
$l_modo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"modoasistencia"))
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_useruuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	  //If (STWA2_Priv_GetMethodAccess ("AL_EliminaInasistencia";$idUser))
	If (True:C214)  //si fuera necesario verificar algun permiso
		If (<>vb_BloquearModifSituacionFinal)
			$0:=SERwa_GeneraRespuesta ("-2";"El registro de información conductual está bloqueado para el ciclo escolar actual a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
		Else 
			Case of 
				: ($l_modo=1)
					TRACE:C157
					If (KRL_FindAndLoadRecordByIndex (->[Alumnos_Inasistencias:10]Auto_UUID:14;->$t_uuidinasistencia;True:C214)>-1)
						$idAlumno:=[Alumnos_Inasistencias:10]Alumno_Numero:4
						$d_fecha:=[Alumnos_Inasistencias:10]Fecha:1
						$t_nombreAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]apellidos_y_nombres:40)
						$t_cursoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]curso:20)
						$t_actividad:="Eliminación de inasistencia diaria: "+$t_nombreAlumno+", "+$t_cursoAlumno+" para el "+String:C10($d_fecha;System date abbreviated:K1:2)
						LOG_RegisterEvt ($t_actividad;0;0;$idUser;"TeacherTrack")
						DELETE RECORD:C58([Alumnos_Inasistencias:10])
						READ ONLY:C145([Alumnos_Inasistencias:10])
						vb_AsignaSituacionfinal:=True:C214
						AL_CalculaSituacionFinal ($idAlumno)
						vb_AsignaSituacionfinal:=False:C215
						$l_registroEliminado:=1
						$0:=SERwa_GeneraRespuesta ("0";"Registro eliminado con exito.")
					Else 
						$0:=SERwa_GeneraRespuesta ("-3";"Registro de inasistencia inexistente.")
					End if 
				: ($l_modo=2)
					If (KRL_FindAndLoadRecordByIndex (->[Asignaturas_Inasistencias:125]Auto_UUID:13;->$t_uuidinasistencia;True:C214)>-1)
						$idAlumno:=[Asignaturas_Inasistencias:125]ID_Alumno:2
						$d_fecha:=[Asignaturas_Inasistencias:125]dateSesion:4
						$l_sesion:=[Asignaturas_Inasistencias:125]ID_Sesión:1
						$t_nombreAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40)
						$t_cursoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]curso:20)
						$l_hora:=[Asignaturas_Inasistencias:125]Hora:8
						KRL_DeleteRecord (->[Asignaturas_Inasistencias:125])
						$t_actividad:="Eliminación de inasistencia por hora: "+$t_nombreAlumno+", "+$t_cursoAlumno+" para el "+String:C10($d_fecha;System date abbreviated:K1:2)+", hora "+String:C10($l_hora)
						LOG_RegisterEvt ($t_actividad;0;0;$idUser;"TeacherTrack")
						AL_InasistenciaDiariaPorHoras ($idAlumno;$d_fecha)
						KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_sesion;True:C214)
						If ([Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18=False:C215)
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName (USR_GetUserID )
							SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
						End if 
						KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
						$0:=SERwa_GeneraRespuesta ("0";"Registro eliminado con exito.")
					Else 
						$0:=SERwa_GeneraRespuesta ("-3";"Registro de inasistencia inexistente.")
					End if 
			End case 
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 