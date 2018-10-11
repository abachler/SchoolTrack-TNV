//%attributes = {}
  //TRACE
$y_Names:=$1
$y_Data:=$2

READ ONLY:C145(*)

C_OBJECT:C1216($inasistencia;$data;$bloqueo;$fechas)

PERIODOS_Init 
C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid;$foto)
C_BLOB:C604($blob)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_uuidprof:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_profesor")
$t_uuidasignatura:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_asignatura")
$l_hora:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"hora"))
$t_fecha:=NV_GetValueFromPairedArrays ($y_names;$y_data;"fecha")
$d_fecha:=Date:C102(DT_FechaISO_a_FechaHora ($t_fecha))
$l_dia:=DT_GetDayNumber_ISO8601 ($d_fecha)
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_useruuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (True:C214)  //si fuera necesario verificar algun permiso
		If (KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura)>-1)
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			$modoasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora)
			If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
				AS_CreaSesionesAsignatura ([Asignaturas:18]Numero:1;$d_fecha)
				QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora)
			End if 
			$idAsignatura:=KRL_GetNumericFieldData (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura;->[Asignaturas:18]Numero:1)
			KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura;False:C215)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$idAsignatura)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
			ARRAY TEXT:C222($aT_curso;0)
			ARRAY TEXT:C222($aT_apellidosnombres;0)
			ARRAY INTEGER:C220($aI_nolista;0)
			ARRAY TEXT:C222($aT_sexo;0)
			ARRAY LONGINT:C221($al_recnumalumnos;0)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;$aI_nolista;[Alumnos:2];$al_recnumalumnos;[Alumnos:2]curso:20;$aT_curso;[Alumnos:2]apellidos_y_nombres:40;$aT_apellidosnombres;[Alumnos:2]Sexo:49;$aT_sexo)
			  // 20181008 Patricio Aliaga Ticket N° 204363
			C_OBJECT:C1216($o_obj;$o_in)
			OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
			$o_obj:=STR_ordenNominas ("query";$o_in)
			Case of 
				: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
					Case of 
						: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
							If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
								AT_MultiLevelSort ("<> ";->$aT_sexo;->$aI_nolista;->$al_recnumalumnos)
							Else 
								AT_MultiLevelSort (">> ";->$aT_sexo;->$aI_nolista;->$al_recnumalumnos)
							End if 
						: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
							If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
								If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
									AT_MultiLevelSort ("<>> ";->$aT_sexo;->$aT_curso;->$aT_apellidosnombres;->$al_recnumalumnos)
								Else 
									AT_MultiLevelSort ("<> ";->$aT_sexo;->$aT_apellidosnombres;->$al_recnumalumnos)
								End if 
							Else 
								If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
									AT_MultiLevelSort (">>> ";->$aT_sexo;->$aT_curso;->$aT_apellidosnombres;->$al_recnumalumnos)
								Else 
									AT_MultiLevelSort (">> ";->$aT_sexo;->$aT_apellidosnombres;->$al_recnumalumnos)
								End if 
							End if 
						: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
							If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
								AT_MultiLevelSort ("<> ";->$aT_sexo;->$aT_apellidosnombres;->$al_recnumalumnos)
							Else 
								AT_MultiLevelSort (">> ";->$aT_sexo;->$aT_apellidosnombres;->$al_recnumalumnos)
							End if 
					End case 
				: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
					AT_MultiLevelSort ("> ";->$aI_nolista;->$al_recnumalumnos)
				: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AT_MultiLevelSort (">> ";->$aT_curso;->$aT_apellidosnombres;->$al_recnumalumnos)
					Else 
						AT_MultiLevelSort ("> ";->$aT_apellidosnombres;->$al_recnumalumnos)
					End if 
				: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
					AT_MultiLevelSort ("> ";->$aT_apellidosnombres;->$al_recnumalumnos)
			End case 
			  //If (<>viSTR_AgruparPorSexo=0)
			  //Case of 
			  //: (<>gOrdenNta=0)
			  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
			  //AT_MultiLevelSort (">>";->$aT_curso;->$aT_apellidosnombres;->$al_recnumalumnos)
			  //Else 
			  //SORT ARRAY($aT_apellidosnombres;$al_recnumalumnos)
			  //End if 
			  //: (<>gOrdenNta=1)
			  //SORT ARRAY($aI_nolista;$al_recnumalumnos)
			  //: (<>gOrdenNta=2)
			  //SORT ARRAY($aT_apellidosnombres;$al_recnumalumnos)
			  //End case 
			  //Else 
			  //Case of 
			  //: (<>gOrdenNta=0)
			  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
			  //AT_MultiLevelSort (">>>";->$aT_sexo;->$aT_curso;->$aT_apellidosnombres;->$al_recnumalumnos)
			  //Else 
			  //AT_MultiLevelSort (">>";->$aT_sexo;->$aT_apellidosnombres;->$al_recnumalumnos)
			  //End if 
			  //: (<>gOrdenNta=1)
			  //AT_MultiLevelSort (">>";->$aT_sexo;->$aI_nolista;->$al_recnumalumnos)
			  //: (<>gOrdenNta=2)
			  //AT_MultiLevelSort (">>";->$aT_sexo;->$aT_apellidosnombres;->$al_recnumalumnos)
			  //End case 
			  //End if 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			$data:=OB_Create 
			If (DateIsValid ($d_fecha))
				ARRAY OBJECT:C1221($aO_alumnos;Size of array:C274($al_recnumalumnos))
				For ($i;1;Size of array:C274($al_recnumalumnos))
					KRL_GotoRecord (->[Alumnos:2];$al_recnumalumnos{$i};False:C215)
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_Asignatura:5=$idAsignatura)
					OB SET:C1220($aO_alumnos{$i};"uuid_alumno";Util_MakeUUIDCanonical ([Alumnos:2]auto_uuid:72))
					OB SET:C1220($aO_alumnos{$i};"nombres";[Alumnos:2]Nombres:2)
					OB SET:C1220($aO_alumnos{$i};"apellido1";[Alumnos:2]Apellido_paterno:3)
					OB SET:C1220($aO_alumnos{$i};"apellido2";[Alumnos:2]Apellido_materno:4)
					OB SET:C1220($aO_alumnos{$i};"nombre_comun";[Alumnos:2]Nombre_Común:30)
					OB SET:C1220($aO_alumnos{$i};"numero_lista";[Alumnos_Calificaciones:208]NoDeLista:10)
					OB SET:C1220($aO_alumnos{$i};"status";[Alumnos:2]Status:50)
					OB SET:C1220($aO_alumnos{$i};"fecha_retiro";SN3_MakeDateInmune2LocalFormat2 ([Alumnos:2]Fecha_de_retiro:42))
					OB SET:C1220($aO_alumnos{$i};"genero";[Alumnos:2]Sexo:49)
					OB SET:C1220($aO_alumnos{$i};"curso";[Alumnos:2]curso:20)
					SET BLOB SIZE:C606($blob;0)
					PICTURE TO BLOB:C692([Alumnos:2]Fotografía:78;$blob;".jpg")
					BASE64 ENCODE:C895($blob;$foto)
					OB SET:C1220($aO_alumnos{$i};"fotografia";$foto)
					Case of 
						: ($modoasistencia=1)
							QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
							QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$d_fecha)
							If (Records in selection:C76([Alumnos_Inasistencias:10])=1)
								OB SET:C1220($aO_alumnos{$i};"presente";False:C215)
								$inasistencia:=OB_Create 
								OB SET:C1220($inasistencia;"uuid_inasistencia";Util_MakeUUIDCanonical ([Alumnos_Inasistencias:10]Auto_UUID:14))
								OB SET:C1220($inasistencia;"justificado";([Alumnos_Inasistencias:10]Justificación:2#""))
								OB SET:C1220($inasistencia;"motivo";[Alumnos_Inasistencias:10]Justificación:2)
								OB SET:C1220($inasistencia;"observacion";[Alumnos_Inasistencias:10]Observaciones:3)
								OB SET:C1220($aO_alumnos{$i};"ausente";$inasistencia)
							Else 
								OB SET:C1220($aO_alumnos{$i};"presente";True:C214)
								OB SET:C1220($aO_alumnos{$i};"ausente";False:C215)
							End if 
						: ($modoasistencia=2)
							QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
							QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas:18]Numero:1;*)
							QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$d_fecha;*)
							QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Hora:8=$l_hora)
							If (Records in selection:C76([Asignaturas_Inasistencias:125])=1)
								OB SET:C1220($aO_alumnos{$i};"presente";False:C215)
								$inasistencia:=OB_Create 
								OB SET:C1220($inasistencia;"uuid_inasistencia";Util_MakeUUIDCanonical ([Asignaturas_Inasistencias:125]Auto_UUID:13))
								OB SET:C1220($inasistencia;"justificada";([Asignaturas_Inasistencias:125]Justificacion:3#""))
								OB SET:C1220($inasistencia;"motivo";[Asignaturas_Inasistencias:125]Justificacion:3)
								OB SET:C1220($inasistencia;"observacion";[Asignaturas_Inasistencias:125]Observaciones:5)
								OB SET:C1220($aO_alumnos{$i};"ausente";$inasistencia)
							Else 
								OB SET:C1220($aO_alumnos{$i};"presente";True:C214)
								OB SET:C1220($aO_alumnos{$i};"ausente";False:C215)
							End if 
					End case 
					QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fecha;*)
					Case of 
						: ($modoasistencia=1)
							QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
						: ($modoasistencia=2)
							QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=$l_hora)
					End case 
					If (Records in selection:C76([Alumnos_Atrasos:55])=1)
						OB SET:C1220($aO_alumnos{$i};"presente";True:C214)
						$atraso:=OB_Create 
						OB SET:C1220($atraso;"uuid_atraso";Util_MakeUUIDCanonical ([Alumnos_Atrasos:55]Auto_UUID:10))
						OB SET:C1220($atraso;"minutos";[Alumnos_Atrasos:55]MinutosAtraso:5)
						$uuidAsig:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Atrasos:55]ID_Asignatura:15;->[Asignaturas:18]auto_uuid:12)
						If (Util_isValidUUID ($uuidAsig))
							OB SET:C1220($atraso;"uuid_asignatura";Util_MakeUUIDCanonical ($uuidAsig))
						Else 
							OB SET NULL:C1233($atraso;"uuid_asignatura")
						End if 
						OB SET:C1220($atraso;"motivo";[Alumnos_Atrasos:55]id_justificacion:13)
						OB SET:C1220($atraso;"intersesion";[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)
						OB SET:C1220($atraso;"justificado";[Alumnos_Atrasos:55]justificado:14)
						OB SET:C1220($atraso;"observaciones";[Alumnos_Atrasos:55]Observaciones:3)
						OB SET:C1220($atraso;"numerohora";[Alumnos_Atrasos:55]NumeroHora:11)
						OB SET:C1220($atraso;"minutos";[Alumnos_Atrasos:55]MinutosAtraso:5)
						OB SET:C1220($aO_alumnos{$i};"atrasado";$atraso)
					Else 
						OB SET:C1220($aO_alumnos{$i};"atrasado";False:C215)
					End if 
				End for 
				OB SET NULL:C1233($data;"error")
				OB SET ARRAY:C1227($data;"alumnos";$aO_alumnos)
				Case of 
					: ($modoasistencia=1)
						OB SET:C1220($data;"registrada";True:C214)
						OB SET:C1220($data;"impartida";True:C214)
					: ($modoasistencia=2)
						OB SET:C1220($data;"registrada";[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18)
						OB SET:C1220($data;"impartida";[Asignaturas_RegistroSesiones:168]Impartida:5)
					Else 
						OB SET:C1220($data;"registrada";True:C214)
						OB SET:C1220($data;"impartida";True:C214)
				End case 
			Else 
				OB SET:C1220($data;"error";"-3")
				OB SET:C1220($data;"mensaje";"Fecha invalida")
			End if 
			$bloqueo:=OB_Create 
			OB SET:C1220($bloqueo;"bloqueositfinal";<>vb_BloquearModifSituacionFinal)
			OB SET:C1220($bloqueo;"bloqueodesde";SN3_MakeDateInmune2LocalFormat2 (<>vd_FechaBloqueoSchoolTrack))
			OB SET:C1220($data;"bloqueositfinal";$bloqueo)
			
			$fechas:=OB_Create 
			ARRAY TEXT:C222($aT_feriados;Size of array:C274(adSTR_Calendario_Feriados))
			For ($i;1;Size of array:C274(adSTR_Calendario_Feriados))
				$aT_feriados{$i}:=SN3_MakeDateInmune2LocalFormat2 (adSTR_Calendario_Feriados{$i})
			End for 
			OB SET ARRAY:C1227($fechas;"feriados";$aT_feriados)
			ARRAY OBJECT:C1221($aO_periodos;Size of array:C274(adSTR_Periodos_Desde))
			For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
				$periodo:=OB_Create 
				OB SET:C1220($periodo;"numero";aiSTR_Periodos_Numero{$i})
				OB SET:C1220($periodo;"nombre";atSTR_Periodos_Nombre{$i})
				OB SET:C1220($periodo;"desde";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Desde{$i}))
				OB SET:C1220($periodo;"hasta";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Hasta{$i}))
				$aO_periodos{$i}:=$periodo
			End for 
			OB SET ARRAY:C1227($fechas;"periodos";$aO_periodos)
			OB SET:C1220($data;"fechas";$fechas)
			
			ST_JustificacionAtrasos ("cargaVariables")
			STR_LeePreferenciasAtrasos2 
			$paramsAtrasos:=OB_Create 
			ARRAY OBJECT:C1221($aO_motivosatrasos;Size of array:C274(al_JustificacionID))
			For ($i;1;Size of array:C274(al_JustificacionID))
				$motivo:=OB_Create 
				OB SET:C1220($motivo;"id";al_JustificacionID{$i})
				OB SET:C1220($motivo;"motivo";at_JustificacionNombre{$i})
				$aO_motivosatrasos{$i}:=$motivo
			End for 
			OB SET ARRAY:C1227($paramsAtrasos;"motivos";$aO_motivosatrasos)
			OB SET:C1220($paramsAtrasos;"registrarminutos";vi_RegistrarMinutosEnAtrasos)
			OB SET:C1220($paramsAtrasos;"intervalos";vt_intervalos)
			$0:=OB_Object2Json ($data)
		Else 
			$0:=SERwa_GeneraRespuesta ("-2";"Asignatura inexistente.")
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 