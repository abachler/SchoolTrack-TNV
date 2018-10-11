//%attributes = {}
  //TRACE

$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Alumnos_Inasistencias:10])
READ ONLY:C145([Alumnos_Atrasos:55])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Asignaturas_Inasistencias:125])

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
PERIODOS_Init 
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	If (<>vb_BloquearModifSituacionFinal)
		$0:=SERwa_GeneraRespuesta ("-2";"El registro de información conductual está bloqueado para el ciclo escolar actual a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
	Else 
		$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_profuuid;->[Profesores:4]Numero:1)
		$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
		$idAlumno:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$t_uuidalumno;->[Alumnos:2]numero:1)
		$idNivel:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$t_uuidalumno;->[Alumnos:2]nivel_numero:29)
		$t_nombreAlumno:=KRL_GetTextFieldData (->[Alumnos:2]auto_uuid:72;->$t_uuidalumno;->[Alumnos:2]apellidos_y_nombres:40)
		$t_cursoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]auto_uuid:72;->$t_uuidalumno;->[Alumnos:2]curso:20)
		$idAsignatura:=KRL_GetNumericFieldData (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura;->[Asignaturas:18]Numero:1)
		$t_nombreAsignatura:=KRL_GetTextFieldData (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura;->[Asignaturas:18]denominacion_interna:16)
		If (True:C214)  //si fuera necesario verificar algun permiso
			Case of 
				: ($l_modo=1)
					READ WRITE:C146([Alumnos_Inasistencias:10])
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$idAlumno;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$d_fecha)
					DELETE SELECTION:C66([Alumnos_Inasistencias:10])
					KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
					CREATE RECORD:C68([Alumnos_Atrasos:55])
					[Alumnos_Atrasos:55]Fecha:2:=$d_fecha
					[Alumnos_Atrasos:55]Alumno_numero:1:=$idAlumno
					[Alumnos_Atrasos:55]Observaciones:3:=""
					[Alumnos_Atrasos:55]Nivel_Numero:8:=$idNivel
					[Alumnos_Atrasos:55]ID_Asignatura:15:=$idAsignatura
					SAVE RECORD:C53([Alumnos_Atrasos:55])
					C_OBJECT:C1216($obj)
					OB SET:C1220($obj;"uuid_atraso";Util_MakeUUIDCanonical ([Alumnos_Atrasos:55]Auto_UUID:10))
					KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
					$t_actividad:="Registro de atraso: "+$t_nombreAlumno+", "+$t_cursoAlumno+" para el "+String:C10($d_fecha;System date abbreviated:K1:2)
					$t_actividad:=$t_actividad+Choose:C955(($t_nombreAsignatura#"");", "+$t_nombreAsignatura;"")
					LOG_RegisterEvt ($t_actividad;0;0;$idUser;"TeacherTrack")
					$0:=OB_Object2Json ($obj)
				: ($l_modo=2)
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$idAsignatura;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha)
					If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
						AS_CreaSesionesAsignatura ($idAsignatura;$d_fecha)
						QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$idAsignatura;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha)
					End if 
					If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=1)
						If ([Asignaturas_RegistroSesiones:168]Impartida:5)
							READ WRITE:C146([Asignaturas_Inasistencias:125])
							QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$idAlumno;*)
							QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$d_fecha;*)
							QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Hora:8=$l_hora)
							DELETE SELECTION:C66([Asignaturas_Inasistencias:125])
							KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
							PERIODOS_LoadData ($idNivel)
							STR_LeePreferenciasAtrasos2 
							QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$idAlumno;*)
							QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fecha;*)
							QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=$l_hora)
							If (Records in selection:C76([Alumnos_Atrasos:55])=0)
								$l_posicionHora:=Find in array:C230(aiSTR_Horario_HoraNo;$l_hora)
								CREATE RECORD:C68([Alumnos_Atrasos:55])
								[Alumnos_Atrasos:55]Fecha:2:=$d_fecha
								[Alumnos_Atrasos:55]Alumno_numero:1:=$idAlumno
								[Alumnos_Atrasos:55]Observaciones:3:=""
								[Alumnos_Atrasos:55]MinutosAtraso:5:=ATSTRAL_FALTACONV{1}
								[Alumnos_Atrasos:55]Nivel_Numero:8:=$idNivel
								[Alumnos_Atrasos:55]id_justificacion:13:=0
								[Alumnos_Atrasos:55]justificado:14:=False:C215
								[Alumnos_Atrasos:55]NumeroHora:11:=$l_hora
								[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=True:C214
								[Alumnos_Atrasos:55]HoradeAtraso:12:=alSTR_Horario_Desde{$l_posicionHora}+(ATSTRAL_FALTACONV{1}*60)
								[Alumnos_Atrasos:55]ID_Asignatura:15:=$idAsignatura
								SAVE RECORD:C53([Alumnos_Atrasos:55])
								C_OBJECT:C1216($obj)
								OB SET:C1220($obj;"uuid_atraso";Util_MakeUUIDCanonical ([Alumnos_Atrasos:55]Auto_UUID:10))
								KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
								$t_actividad:="Registro de atraso: "+$t_nombreAlumno+", "+$t_cursoAlumno+" para el "+String:C10($d_fecha;System date abbreviated:K1:2)
								$t_actividad:=$t_actividad+Choose:C955(($t_nombreAsignatura#"");", "+$t_nombreAsignatura;"")
								LOG_RegisterEvt ($t_actividad;0;0;$idUser;"TeacherTrack")
								KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
								$0:=OB_Object2Json ($obj)
							Else 
								$0:=SERwa_GeneraRespuesta ("-3";"Alumno ya registra atraso en esta hora.")
							End if 
						Else 
							$0:=SERwa_GeneraRespuesta ("-4";"Sesión no impartida. No se puede registrar atraso.")
						End if 
					Else 
						$0:=SERwa_GeneraRespuesta ("-5";"Sesión no encontrada. No se puede registrar atraso.")
					End if 
			End case 
		Else 
			$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
		End if 
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 