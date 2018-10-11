//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 22-05-17, 17:22:33
  // ----------------------------------------------------
  // Método: STWA2_MO_CargaAlumnosAsignatura
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------




C_BLOB:C604($xblob)
C_DATE:C307($d_fecha)
C_LONGINT:C283($i;$l_rnAlumno)
C_POINTER:C301($y_ParameterNames;$y_ParameterValues)
C_TEXT:C284($curso;$json;$t_foto;$uuid;$t_mensajeFecha)
C_OBJECT:C1216($ob_alumno;$ob_atrasos;$o_resultado;$ob_raiz)
C_TEXT:C284($t_intervalo;$t_mostrar_curso)


C_BOOLEAN:C305($b_antesInicioPeriodo)  //20180126 RCH Ticket 197811
C_TEXT:C284($t_antesInicioPeriodo)

ARRAY BOOLEAN:C223($ab_fechaInasistencia;0)
ARRAY INTEGER:C220($aNoLista;0)
ARRAY LONGINT:C221($al_recNumAlumno;0)
ARRAY LONGINT:C221($alumnos;0)
ARRAY LONGINT:C221($aRNAlumnos;0)
ARRAY PICTURE:C279($ap_fotografia;0)
ARRAY TEXT:C222($aNombres;0)
ARRAY TEXT:C222($aSexo;0)
ARRAY TEXT:C222($aStatuses;0)
ARRAY TEXT:C222($at_fotografia;0)
ARRAY TEXT:C222($at_observaciones;0)
ARRAY TEXT:C222($at_statusAlumno;0)
ARRAY TEXT:C222($at_intervalos;0)
ARRAY TEXT:C222($at_Curso;0)
ARRAY OBJECT:C1221($aob_alumnos;0)
ARRAY LONGINT:C221($al_alumnosRNOrden;0)
ARRAY LONGINT:C221($al_alumnosCalificaciones;0)
ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY LONGINT:C221($al_idAlumno;0)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$userID:=STWA2_Session_GetUserSTID ($uuid)
$l_rnAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsignatura"))
$d_fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"fecha"))
$t_curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
$t_mostrar_curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mostrar_curso")
PREF_Set (0;"Muestra_Curso"+String:C10($userID);$t_mostrar_curso)

If ($d_fecha=!00-00-00!)
	$d_fecha:=Current date:C33
End if 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Asignaturas:18])

If ($l_rnAsignatura=-1)
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_curso)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
Else 
	GOTO RECORD:C242([Asignaturas:18];$l_rnAsignatura)
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
End if 

SET FIELD RELATION:C919([Alumnos:2]numero:1;Automatic:K51:4;Automatic:K51:4)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]ocultoEnNominas:89=False:C215)
SET FIELD RELATION:C919([Alumnos:2]numero:1;Structure configuration:K51:2;Structure configuration:K51:2)

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

  //20180126 RCH Ticket 197811
$o_resultado:=STWA2_ValidaFechaPeriodo ([Asignaturas:18]Numero_del_Nivel:6;$d_fecha;2)
$b_antesInicioPeriodo:=OB Get:C1224($o_resultado;"antesInicioPeriodo")
$t_antesInicioPeriodo:=OB Get:C1224($o_resultado;"antesInicioPeriodoMsj")
$t_mensajeFecha:=OB Get:C1224($o_resultado;"mensajeFecha")


For ($i;1;Size of array:C274($al_recNumAlumnos))
	GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
	
	  //cargo la fotografía
	$t_foto:=STWA2_CreaImagenAlumnosEnDisco ("creaUrlImagenAlumno";[Alumnos:2]auto_uuid:72)  //20180616 ASM Ticket 206719
	
	  //cargo inasistencia del alumno para la fecha
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$d_fecha)
	$l_recNumInasistencia:=Record number:C243([Alumnos_Inasistencias:10])
	$t_observacionInasistencia:=[Alumnos_Inasistencias:10]Observaciones:3
	
	  //cargo el atraso si es que existe para el día
	QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$d_fecha;*)
	QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
	$l_atrasoID:=[Alumnos_Atrasos:55]ID:7
	
	If ($l_atrasoID#0)
		STR_LeePreferenciasAtrasos2 
		AT_Text2Array (->$at_intervalos;vt_intervalos;",")
		$choice:=Find in array:C230(ATSTRAL_FALTACONV;Num:C11([Alumnos_Atrasos:55]MinutosAtraso:5))
		If ($choice#-1)
			If (Size of array:C274($at_intervalos)>0)
				$t_intervalo:=$at_intervalos{$choice}
			End if 
		End if 
	End if 
	
	
	OB SET:C1220($ob_atrasos;"atrasoID";$l_atrasoID)
	OB SET:C1220($ob_atrasos;"justificado";[Alumnos_Atrasos:55]justificado:14)
	OB SET:C1220($ob_atrasos;"observacion";[Alumnos_Atrasos:55]Observaciones:3)
	OB SET:C1220($ob_atrasos;"motivojustificacion";[Alumnos_Atrasos:55]id_justificacion:13)
	OB SET:C1220($ob_atrasos;"minutos";[Alumnos_Atrasos:55]MinutosAtraso:5)
	OB SET:C1220($ob_atrasos;"inter";[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)
	OB SET:C1220($ob_atrasos;"intervalo_actual";$t_intervalo)
	
	$l_rnAlumno:=$al_recNumAlumnos{$i}
	OB SET:C1220($ob_alumno;"alumnosRN";$l_rnAlumno)
	OB SET:C1220($ob_alumno;"idAlumno";[Alumnos:2]numero:1)
	OB SET:C1220($ob_alumno;"alumnosNombres";[Alumnos:2]apellidos_y_nombres:40)
	OB SET:C1220($ob_alumno;"status";[Alumnos:2]Status:50)
	OB SET:C1220($ob_alumno;"alumnosnoLista";[Alumnos:2]no_de_lista:53)
	OB SET:C1220($ob_alumno;"alumnosRNIna";$l_recNumInasistencia)
	OB SET:C1220($ob_alumno;"obs";[Alumnos_Inasistencias:10]Observaciones:3)
	OB SET:C1220($ob_alumno;"fotografia";$t_foto)
	OB SET:C1220($ob_alumno;"atraso";$ob_atrasos)
	OB SET:C1220($ob_alumno;"observacion";$t_observacionInasistencia)
	
	APPEND TO ARRAY:C911($aob_alumnos;$ob_alumno)
	
	CLEAR VARIABLE:C89($ob_atrasos)
	CLEAR VARIABLE:C89($ob_alumno)
	
End for 
OB SET ARRAY:C1227($ob_raiz;"alumnos";$aob_alumnos)
OB SET:C1220($ob_raiz;"rnAsignatura";$l_rnAsignatura)  //MONO Ticket 180505
OB SET:C1220($ob_raiz;"fechaAnteriorAInicioAño";$b_antesInicioPeriodo)  //20180126 RCH Ticket 197811
OB SET:C1220($ob_raiz;"mensaje";$t_antesInicioPeriodo)  //20180126 RCH Ticket 197811

$json:=JSON Stringify:C1217($ob_raiz)
  //SET TEXT TO PASTEBOARD($json)
$0:=$json


