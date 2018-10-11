//%attributes = {}
  //TRACE
$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Alumnos_Atrasos:55])
READ ONLY:C145([Alumnos_Inasistencias:10])


C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
C_LONGINT:C283($idUser;$idAsignatura)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_profuuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_profesor")
$t_uuidalumno:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_alumno")
$t_fecha:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha")
$l_modo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"modoasistencia"))
$t_uuidasignatura:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_asignatura")
$l_hora:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"hora"))
$d_fecha:=Date:C102(DT_FechaISO_a_FechaHora ($t_fecha))
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	If (<>vb_BloquearModifSituacionFinal)
		$0:=SERwa_GeneraRespuesta ("-2";"El registro de información conductual está bloqueado para el ciclo escolar actual a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
	Else 
		PERIODOS_Init 
		$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_profuuid;->[Profesores:4]Numero:1)
		$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
		If (True:C214)  //si fuera necesario verificar algun permiso
			$idAlumno:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$t_uuidalumno;->[Alumnos:2]numero:1)
			If ($l_modo=1)
				ARRAY LONGINT:C221(alABS_AlumnosID;1)
				alABS_AlumnosID{1}:=$idAlumno
				dDate:=$d_fecha
				<>tUSR_CurrentUser:=USR_GetUserName ($idUser)
				AL_GuardaInasistenciaDiaria 
				READ WRITE:C146([Alumnos_Atrasos:55])
				QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$idAlumno;*)
				QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fecha)
				DELETE SELECTION:C66([Alumnos_Atrasos:55])
				KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$idAlumno;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=dDate)
				C_OBJECT:C1216($obj)
				OB SET:C1220($obj;"uuid_inasistencia";Util_MakeUUIDCanonical ([Alumnos_Inasistencias:10]Auto_UUID:14))
				KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
				$0:=OB_Object2Json ($obj)
			Else 
				$idAsignatura:=KRL_GetNumericFieldData (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura;->[Asignaturas:18]Numero:1)
				$idNivel:=KRL_GetNumericFieldData (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura;->[Asignaturas:18]Numero_del_Nivel:6)
				PERIODOS_LoadData ($idNivel)
				QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$idAsignatura;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha)
				If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
					AS_CreaSesionesAsignatura ($idAsignatura;$d_fecha)
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$idAsignatura;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha)
				End if 
				If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
					If ([Asignaturas_RegistroSesiones:168]Impartida:5)
						$idSesion:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
						ASrs_RegistraInasistencia ($idSesion;$idAlumno)
						READ WRITE:C146([Alumnos_Atrasos:55])
						QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$idAlumno;*)
						QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fecha;*)
						QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=$l_hora)
						DELETE RECORD:C58([Alumnos_Atrasos:55])
						KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
						QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$idSesion;*)
						QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2=$idAlumno)
						C_OBJECT:C1216($obj)
						OB SET:C1220($obj;"uuid_inasistencia";Util_MakeUUIDCanonical ([Asignaturas_Inasistencias:125]Auto_UUID:13))
						KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
						$0:=OB_Object2Json ($obj)
					Else 
						$0:=SERwa_GeneraRespuesta ("-3";"Sesión no impartida. No se puede registrar asistencia.")
					End if 
				Else 
					$0:=SERwa_GeneraRespuesta ("-3";"Sesión no encontrada. No se puede registrar asistencia.")
				End if 
			End if 
		Else 
			$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
		End if 
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 