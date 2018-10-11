//%attributes = {}
  //TRACE

$y_Names:=$1
$y_Data:=$2

PERIODOS_Init 

C_OBJECT:C1216($data;$obj)
ARRAY INTEGER:C220($aL_NoLista;0)
ARRAY TEXT:C222($aT_apellidoP;0)
ARRAY TEXT:C222($aT_apellidoM;0)
ARRAY TEXT:C222($aT_nombres;0)
ARRAY TEXT:C222($aT_uuid;0)
ARRAY TEXT:C222($aT_curso;0)
ARRAY OBJECT:C1221($aO_alumnos;0)

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid;$t_uuid;$t_paraquien)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_paraquien:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"paraquien")
$t_uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid")
$t_uuidbloque:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidbloque")
$t_fecha:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha")
$d_fecha:=Date:C102(DT_FechaISO_a_FechaHora ($t_fecha))
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	If (True:C214)  //permiso para ver horario
		If (KRL_FindAndLoadRecordByIndex (->[TMT_Horario:166]Auto_UUID:17;->$t_uuidbloque;False:C215)>-1)
			$idProfAsig:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]profesor_numero:4)
			$profAsig:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$idProfAsig;->[Profesores:4]Apellidos_y_nombres:28)
			$numAlumnos:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero_de_alumnos:49)
			$modoAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]AttendanceMode:3)
			$grupal:=KRL_GetBooleanFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Seleccion:17)
			OB SET:C1220($data;"curso";[TMT_Horario:166]Curso:11)
			OB SET:C1220($data;"profesorasig";$profAsig)
			OB SET:C1220($data;"numeroalumnosinscritos";$numAlumnos)
			Case of 
				: ($modoAsistencia=1)
					SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[TMT_Horario:166]ID_Asignatura:5)
					KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
					QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$d_fecha)
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Inasistencias:10]Alumno_Numero:4;"")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[TMT_Horario:166]ID_Asignatura:5;*)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos:2]Status:50#"Ret@")
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;$aL_NoLista;[Alumnos:2]curso:20;$aT_curso;[Alumnos:2]Apellido_paterno:3;$aT_apellidoP;[Alumnos:2]Apellido_materno:4;$aT_apellidoM;[Alumnos:2]Nombres:2;$aT_nombres;[Alumnos:2]auto_uuid:72;$aT_uuid)
					SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
					For ($i;1;Size of array:C274($aL_NoLista))
						$obj:=OB_Create 
						OB SET:C1220($obj;"num_lista";$aL_NoLista{$i})
						OB SET:C1220($obj;"apellido1";$aT_apellidoP{$i})
						OB SET:C1220($obj;"apellido2";$aT_apellidoM{$i})
						OB SET:C1220($obj;"nombres";$aT_nombres{$i})
						OB SET:C1220($obj;"uuid";Util_MakeUUIDCanonical ($aT_uuid{$i}))
						If ($grupal)
							OB SET:C1220($obj;"curso";$aT_curso{$i})
						Else 
							OB SET NULL:C1233($obj;"curso")
						End if 
						APPEND TO ARRAY:C911($aO_alumnos;$obj)
					End for 
					OB SET ARRAY:C1227($data;"ausentes";$aO_alumnos)
				: ($modoAsistencia=2)
					QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=[TMT_Horario:166]ID_Asignatura:5;*)
					QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$d_fecha)
					SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Asignaturas_Inasistencias:125]ID_Alumno:2;"")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[TMT_Horario:166]ID_Asignatura:5;*)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos:2]Status:50#"Ret@")
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;$aL_NoLista;[Alumnos:2]curso:20;$aT_curso;[Alumnos:2]Apellido_paterno:3;$aT_apellidoP;[Alumnos:2]Apellido_materno:4;$aT_apellidoM;[Alumnos:2]Nombres:2;$aT_nombres;[Alumnos:2]auto_uuid:72;$aT_uuid)
					SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
					For ($i;1;Size of array:C274($aL_NoLista))
						$obj:=OB_Create 
						OB SET:C1220($obj;"num_lista";$aL_NoLista{$i})
						OB SET:C1220($obj;"apellido1";$aT_apellidoP{$i})
						OB SET:C1220($obj;"apellido2";$aT_apellidoM{$i})
						OB SET:C1220($obj;"nombres";$aT_nombres{$i})
						OB SET:C1220($obj;"uuid";Util_MakeUUIDCanonical ($aT_uuid{$i}))
						If ($grupal)
							OB SET:C1220($obj;"curso";$aT_curso{$i})
						Else 
							OB SET NULL:C1233($obj;"curso")
						End if 
						APPEND TO ARRAY:C911($aO_alumnos;$obj)
					End for 
					OB SET ARRAY:C1227($data;"ausentes";$aO_alumnos)
				Else 
					OB SET NULL:C1233($data;"ausentes")
			End case 
			$0:=OB_Object2Json ($data)
		Else 
			$0:=SERwa_GeneraRespuesta ("-2";"Bloque inexistente.")
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 