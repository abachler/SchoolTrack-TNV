//%attributes = {}
$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Alumnos_Atrasos:55])

C_OBJECT:C1216($inasistencia;$data;$bloqueo;$fechas)

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid;$foto)
C_BLOB:C604($blob)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_uuidprof:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_profesor")
$t_uuidatraso:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_atraso")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	If (<>vb_BloquearModifSituacionFinal)
		$0:=SERwa_GeneraRespuesta ("-2";"El registro de información conductual está bloqueado para el ciclo escolar actual a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
	Else 
		$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_uuidprof;->[Profesores:4]Numero:1)
		$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
		If (True:C214)  //si fuera necesario verificar algun permiso
			If (KRL_FindAndLoadRecordByIndex (->[Alumnos_Atrasos:55]Auto_UUID:10;->$t_uuidatraso;True:C214)>-1)
				$d_fecha:=[Alumnos_Atrasos:55]Fecha:2
				$t_nombreAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]apellidos_y_nombres:40)
				$t_cursoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]curso:20)
				$t_nombreAsignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Atrasos:55]ID_Asignatura:15;->[Asignaturas:18]denominacion_interna:16)
				DELETE RECORD:C58([Alumnos_Atrasos:55])
				$t_actividad:="Eliminación de atraso: "+$t_nombreAlumno+", "+$t_cursoAlumno+" para el "+String:C10($d_fecha;System date abbreviated:K1:2)
				$t_actividad:=$t_actividad+Choose:C955(($t_nombreAsignatura#"");", "+$t_nombreAsignatura;"")
				LOG_RegisterEvt ($t_actividad;0;0;$idUser;"TeacherTrack")
				KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
				$0:=SERwa_GeneraRespuesta ("0";"Registro eliminado con exito.")
			Else 
				$0:=SERwa_GeneraRespuesta ("-3";"Registro de atraso inexistente.")
			End if 
		Else 
			$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
		End if 
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 