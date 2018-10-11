//%attributes = {}


  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 22-05-17, 17:22:42
  // ----------------------------------------------------
  // Método: STWA2_MO_CargaAlumnosxHora
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($t_foto;$t_intervalo;$t_Sesion;$t_mostrar_curso;$t_mensajeFecha;$t_antesInicioPeriodo)
C_OBJECT:C1216($ob_alumno;$ob_atrasos;$ob_justificacion;$o_resultado)
C_BLOB:C604($xblob)
C_BOOLEAN:C305($b_salir;$b_antesInicioPeriodo)
ARRAY OBJECT:C1221($aob_alumnos;0)
ARRAY TEXT:C222($at_intervalos;0)
ARRAY LONGINT:C221($al_sesion;0)
ARRAY LONGINT:C221($al_idAlumno;0)
ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY TEXT:C222($aNombres;0)
ARRAY TEXT:C222($aStatuses;0)
ARRAY INTEGER:C220($aNoLista;0)
ARRAY TEXT:C222($aSexo;0)
ARRAY PICTURE:C279($ap_fotografia;0)
ARRAY TEXT:C222($at_statusAlumno;0)
ARRAY TEXT:C222($at_Curso;0)
ARRAY INTEGER:C220($ai_hora;0)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)
$d_fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"fecha"))
$isAdmin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
$t_Sesion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idSesion")
$t_curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
$t_mostrar_curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mostrar_curso")
PREF_Set (0;"Muestra_Curso"+String:C10($userID);$t_mostrar_curso)

AT_Text2Array (->$al_sesion;$t_Sesion;"_")

If ($d_fecha=!00-00-00!)
	$d_fecha:=Current date:C33(*)
End if 

SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Automatic:K51:4)
SET FIELD RELATION:C919([Alumnos:2]numero:1;Automatic:K51:4;Automatic:K51:4)

QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_sesion)
SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Hora:4;$ai_hora)
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;"")  //agregado
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]ocultoEnNominas:89=False:C215)

SET FIELD RELATION:C919([Alumnos:2]numero:1;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)

SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_idAlumnoCalificaciones;[Alumnos_Calificaciones:208]NoDeLista:10;$al_noListaCalificaciones)

For ($l_indice;1;Size of array:C274($al_idAlumnoCalificaciones))
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_idAlumnoCalificaciones{$l_indice})
	APPEND TO ARRAY:C911($al_idAlumno;[Alumnos:2]numero:1)
	APPEND TO ARRAY:C911($al_recNumAlumnos;Record number:C243([Alumnos:2]))
	APPEND TO ARRAY:C911($aNombres;[Alumnos:2]apellidos_y_nombres:40)
	APPEND TO ARRAY:C911($aStatuses;[Alumnos:2]Status:50)
	APPEND TO ARRAY:C911($aNoLista;[Alumnos:2]no_de_lista:53)
	APPEND TO ARRAY:C911($aSexo;[Alumnos:2]Sexo:49)
	APPEND TO ARRAY:C911($ap_fotografia;[Alumnos:2]Fotografía:78)
	APPEND TO ARRAY:C911($at_statusAlumno;[Alumnos:2]Status:50)
	APPEND TO ARRAY:C911($at_Curso;[Alumnos:2]curso:20)
End for 

  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					MULTI SORT ARRAY:C718($aSexo;<;$al_noListaCalificaciones;>;$aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
				Else 
					MULTI SORT ARRAY:C718($aSexo;>;$al_noListaCalificaciones;>;$aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						MULTI SORT ARRAY:C718($aSexo;<;$at_Curso;>;$aNombres;>;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
					Else 
						MULTI SORT ARRAY:C718($aSexo;<;$aNombres;>;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						MULTI SORT ARRAY:C718($aSexo;>;$at_Curso;>;$aNombres;>;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
					Else 
						MULTI SORT ARRAY:C718($aSexo;>;$aNombres;>;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
					End if 
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					MULTI SORT ARRAY:C718($aSexo;<;$aNombres;>;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
				Else 
					MULTI SORT ARRAY:C718($aSexo;>;$aNombres;>;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		SORT ARRAY:C229($al_noListaCalificaciones;$aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno;>)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			MULTI SORT ARRAY:C718($at_Curso;>;$aNombres;>;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno)
		Else 
			SORT ARRAY:C229($aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno;>)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		SORT ARRAY:C229($aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno;>)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //MULTI SORT ARRAY($at_Curso;>;$aNombres;>;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno)
  //Else 
  //SORT ARRAY($aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno;>)
  //End if 
  //: (<>gOrdenNta=1)
  //SORT ARRAY($al_noListaCalificaciones;$aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno;>)
  //: (<>gOrdenNta=2)
  //SORT ARRAY($aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$aSexo;$ap_fotografia;$at_statusAlumno;>)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //MULTI SORT ARRAY($aSexo;<;$at_Curso;>;$aNombres;>;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
  //Else 
  //MULTI SORT ARRAY($aSexo;<;$aNombres;>;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
  //End if 
  //: (<>gOrdenNta=1)
  //MULTI SORT ARRAY($aSexo;<;$al_noListaCalificaciones;>;$aNombres;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
  //: (<>gOrdenNta=2)
  //MULTI SORT ARRAY($aSexo;<;$aNombres;>;$at_Curso;$al_idAlumno;$al_recNumAlumnos;$aStatuses;$aNoLista;$ap_fotografia;$at_statusAlumno)
  //End case 
  //End if 

$o_resultado:=STWA2_ValidaFechaPeriodo ([Asignaturas:18]Numero_del_Nivel:6;$d_fecha;2)
$b_antesInicioPeriodo:=OB Get:C1224($o_resultado;"antesInicioPeriodo")
$t_antesInicioPeriodo:=OB Get:C1224($o_resultado;"antesInicioPeriodoMsj")
$t_mensajeFecha:=OB Get:C1224($o_resultado;"mensajeFecha")


$ob_raiz:=OB_Create 

For ($i;1;Size of array:C274($al_recNumAlumnos))
	GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
	
	  //cargo la fotografía
	$t_foto:=STWA2_CreaImagenAlumnosEnDisco ("creaUrlImagenAlumno";[Alumnos:2]auto_uuid:72)  //20180616 ASM Ticket 206719
	
	  //cargo inasistencia para la sesión
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$al_idAlumno{$i})
	QUERY SELECTION WITH ARRAY:C1050([Asignaturas_Inasistencias:125]ID_Sesión:1;$al_sesion)
	$l_recNumInasistencia:=Record number:C243([Asignaturas_Inasistencias:125])
	
	  //verifico si la inasistencia se encuentra justificada
	$b_justificada:=([Asignaturas_Inasistencias:125]Justificacion:3#"")
	$t_motivo:=[Asignaturas_Inasistencias:125]Justificacion:3
	$t_observacion:=[Asignaturas_Inasistencias:125]Observaciones:5
	$b_esLicencia:=[Asignaturas_Inasistencias:125]ID_Licencia:9#0
	$ob_justificacion:=OB_Create 
	
	OB_SET ($ob_justificacion;->$t_motivo;"motivo")
	OB_SET ($ob_justificacion;->$t_observacion;"observacion")
	OB_SET ($ob_justificacion;->$b_esLicencia;"esLicencia")
	
	  //cargo el atraso si es que existe para el día
	QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$al_idAlumno{$i};*)
	QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fecha)
	QRY_QueryWithArray (->[Alumnos_Atrasos:55]NumeroHora:11;->$ai_hora;True:C214)
	
	$l_atrasoID:=[Alumnos_Atrasos:55]ID:7
	$t_intervalo:=""
	If ($l_atrasoID#0)
		STR_LeePreferenciasAtrasos2 
		AT_Text2Array (->$at_intervalos;vt_intervalos;",")
		$choice:=Find in array:C230(ATSTRAL_FALTACONV;[Alumnos_Atrasos:55]MinutosAtraso:5)
		If ($choice#-1)
			If (Size of array:C274($at_intervalos)>0)
				$t_intervalo:=$at_intervalos{$choice}
			End if 
		End if 
	End if 
	
	$ob_atrasos:=OB_Create 
	OB_SET ($ob_atrasos;->$l_atrasoID;"atrasoID")
	OB_SET ($ob_atrasos;->[Alumnos_Atrasos:55]justificado:14;"justificado")
	OB_SET ($ob_atrasos;->[Alumnos_Atrasos:55]Observaciones:3;"observacion")
	OB_SET ($ob_atrasos;->[Alumnos_Atrasos:55]id_justificacion:13;"motivojustificacion")
	OB_SET ($ob_atrasos;->[Alumnos_Atrasos:55]MinutosAtraso:5;"minutos")
	OB_SET ($ob_atrasos;->[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4;"inter")
	OB_SET ($ob_atrasos;->$t_intervalo;"intervalo_actual")
	
	$ob_alumno:=OB_Create 
	OB_SET ($ob_alumno;->$al_recNumAlumnos{$i};"alumnosRN")
	OB_SET ($ob_alumno;->$al_idAlumno{$i};"idAlumno")
	OB_SET ($ob_alumno;->$aNombres{$i};"alumnosNombres")
	OB_SET ($ob_alumno;->$aStatuses{$i};"status")
	OB_SET ($ob_alumno;->$aNoLista{$i};"alumnosnoLista")
	OB_SET ($ob_alumno;->$l_recNumInasistencia;"inasistencia")
	OB_SET ($ob_alumno;->$b_justificada;"justificada")
	OB_SET ($ob_alumno;->$al_sesion;"idSesion")
	OB_SET ($ob_alumno;->$t_foto;"fotografia")
	OB_SET ($ob_alumno;->$ob_justificacion;"justificacion")
	OB_SET ($ob_alumno;->$ob_atrasos;"atraso")
	
	APPEND TO ARRAY:C911($aob_alumnos;$ob_alumno)
	
End for 
OB_SET ($ob_raiz;->$aob_alumnos;"alumnos")
OB_SET ($ob_raiz;->$b_antesInicioPeriodo;"fechaAnteriorAInicioAño")
OB_SET ($ob_raiz;->$t_antesInicioPeriodo;"mensaje")

QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_sesion)
OB_SET ($ob_raiz;->[Asignaturas_RegistroSesiones:168]Impartida:5;"checked")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json
