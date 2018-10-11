//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 04-01-18, 11:54:08
  // ----------------------------------------------------
  // Método: STWA2_MO_BuildCargaAlumnoConduc
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($idAsignatura)
C_LONGINT:C283($alumnoClickID)
C_OBJECT:C1216($ob_temporal;$ob_json;$ob_alumnos;$o_licencias)
C_BLOB:C604($xblob)
ARRAY LONGINT:C221($al_IdAlumno;0)
ARRAY TEXT:C222($at_fechaDesde;0)
ARRAY TEXT:C222($at_fechaHasta;0)
ARRAY TEXT:C222($at_obsAcademicas;0)
ARRAY TEXT:C222($at_obsConductual;0)
ARRAY TEXT:C222($t_fotoAlumnos;0)
ARRAY TEXT:C222($at_fechaAnotaciones;0)
ARRAY TEXT:C222($at_fechaCastigos;0)
ARRAY INTEGER:C220($al_yearFiltro;0)
ARRAY OBJECT:C1221($ao_anotaciones;0)
ARRAY OBJECT:C1221($ao_castigos;0)
ARRAY OBJECT:C1221($ao_suspensiones;0)
ARRAY OBJECT:C1221($ao_licencias;0)

ARRAY TEXT:C222($at_nombreAlumnos;0)
ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY PICTURE:C279($ap_fotografia;0)
ARRAY TEXT:C222($at_sexo;0)
ARRAY TEXT:C222($at_Curso;0)
ARRAY TEXT:C222($at_statusAlumnos;0)  //20180607 ASM Ticket 208541

$ob_json:=$1
$y_raiz:=$2


$idAsignatura:=Num:C11(OB Get:C1224($ob_json;"idAsignatura"))
$alumnoClickID:=Num:C11(OB Get:C1224($ob_json;"alumnoClickID"))
OB GET ARRAY:C1229($ob_json;"alumnoClickIDArray";$al_IdAlumno)

If ($idAsignatura#0)
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$idAsignatura)
End if 



If (($alumnoClickID=0) & (Size of array:C274($al_IdAlumno)=0) & ($idAsignatura#0))
	  //cargo los alumnos de la asignatura
	SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
	SET FIELD RELATION:C919([Alumnos:2]numero:1;Automatic:K51:4;Structure configuration:K51:2)
	
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$idAsignatura)
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]ocultoEnNominas:89=False:C215)
	
	If (Records in selection:C76([Alumnos_Calificaciones:208])=0)
		KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$idAsignatura)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]ocultoEnNominas:89=False:C215)
	End if 
	
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;$al_noListaCalificaciones;[Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnoCalificaciones)
	
	SET FIELD RELATION:C919([Alumnos:2]numero:1;Structure configuration:K51:2;Structure configuration:K51:2)
	SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
Else 
	If ($alumnoClickID=0)
		QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumno)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
	Else 
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$alumnoClickID)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
	End if 
	SELECTION TO ARRAY:C260([Alumnos:2]no_de_lista:53;$al_noListaCalificaciones;[Alumnos:2]numero:1;$al_IdAlumnoCalificaciones)
End if 

ARRAY LONGINT:C221($al_IdAlumno;0)  //MONO TICKET 214783


For ($l_indice;1;Size of array:C274($al_noListaCalificaciones))
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_IdAlumnoCalificaciones{$l_indice})
	APPEND TO ARRAY:C911($al_IdAlumno;[Alumnos:2]numero:1)
	APPEND TO ARRAY:C911($at_nombreAlumnos;[Alumnos:2]apellidos_y_nombres:40)
	APPEND TO ARRAY:C911($al_recNumAlumnos;Record number:C243([Alumnos:2]))
	APPEND TO ARRAY:C911($ap_fotografia;[Alumnos:2]Fotografía:78)
	APPEND TO ARRAY:C911($at_sexo;[Alumnos:2]Sexo:49)
	APPEND TO ARRAY:C911($at_Curso;[Alumnos:2]curso:20)
	APPEND TO ARRAY:C911($at_statusAlumnos;[Alumnos:2]Status:50)
End for 

  //SELECTION TO ARRAY([Alumnos]Número;$al_IdAlumno;[Alumnos]Apellidos_y_Nombres;$at_nombreAlumnos;[Alumnos];$al_recNumAlumnos;[Alumnos]Fotografía;$ap_fotografia)
  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Alumnos:2]nivel_numero:29)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					MULTI SORT ARRAY:C718($at_sexo;<;$al_noListaCalificaciones;>;$at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
				Else 
					MULTI SORT ARRAY:C718($at_sexo;>;$al_noListaCalificaciones;>;$at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						MULTI SORT ARRAY:C718($at_sexo;<;$at_Curso;>;$at_nombreAlumnos;>;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
					Else 
						MULTI SORT ARRAY:C718($at_sexo;<;$at_nombreAlumnos;>;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						MULTI SORT ARRAY:C718($at_sexo;>;$at_Curso;>;$at_nombreAlumnos;>;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
					Else 
						MULTI SORT ARRAY:C718($at_sexo;>;$at_nombreAlumnos;>;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
					End if 
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					MULTI SORT ARRAY:C718($at_sexo;<;$at_nombreAlumnos;>;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
				Else 
					MULTI SORT ARRAY:C718($at_sexo;>;$at_nombreAlumnos;>;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		SORT ARRAY:C229($al_noListaCalificaciones;$at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos;>)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			MULTI SORT ARRAY:C718($at_Curso;>;$at_nombreAlumnos;>;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos)
		Else 
			SORT ARRAY:C229($at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos;>)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		SORT ARRAY:C229($at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos;>)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //MULTI SORT ARRAY($at_Curso;>;$at_nombreAlumnos;>;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos)
  //Else 
  //SORT ARRAY($at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos;>)
  //End if 
  //: (<>gOrdenNta=1)
  //SORT ARRAY($al_noListaCalificaciones;$at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos;>)
  //: (<>gOrdenNta=2)
  //SORT ARRAY($at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$at_sexo;$al_IdAlumno;$at_statusAlumnos;>)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //MULTI SORT ARRAY($at_sexo;<;$at_Curso;>;$at_nombreAlumnos;>;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
  //Else 
  //MULTI SORT ARRAY($at_sexo;<;$at_nombreAlumnos;>;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
  //End if 
  //: (<>gOrdenNta=1)
  //MULTI SORT ARRAY($at_sexo;<;$al_noListaCalificaciones;>;$at_nombreAlumnos;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
  //: (<>gOrdenNta=2)
  //MULTI SORT ARRAY($at_sexo;<;$at_nombreAlumnos;>;$at_Curso;$al_recNumAlumnos;$ap_fotografia;$al_IdAlumno;$at_statusAlumnos)
  //End case 
  //End if 

AT_Initialize (->$at_obsAcademicas;->$at_obsConductual;->$t_fotoAlumnos;->$ao_anotaciones;->$ao_castigos;->$ao_suspensiones;->$ao_licencias)
AT_RedimArrays (Size of array:C274($al_IdAlumno);->$at_obsAcademicas;->$at_obsConductual;->$t_fotoAlumnos;->$ao_anotaciones;->$ao_castigos;->$ao_suspensiones;->$ao_licencias)
For ($i;1;Size of array:C274($al_recNumAlumnos))
	GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
	QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5=$idAsignatura;*)
	QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=$al_IdAlumno{$i})
	$at_obsAcademicas{$i}:=[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Academicas:44
	$at_obsConductual{$i}:=[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Conductuales:45
	
	  //cargo las fotografías de los alumnos
	CLEAR VARIABLE:C89($xblob)
	$t_foto:=""
	  //PICTURE TO BLOB($ap_fotografia{$i};$xblob;".jpg")
	  //BASE64 ENCODE($xblob;$t_foto)
	$t_foto:=STWA2_CreaImagenAlumnosEnDisco ("creaUrlImagenAlumno";[Alumnos:2]auto_uuid:72)  //20180616 ASM Ticket 206719
	$t_fotoAlumnos{$i}:=$t_foto
	
	  //cargo las anotaciones, castigos y suspensiones del alumno.
	C_OBJECT:C1216($o_anotacionesAlumno)
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=$al_IdAlumno{$i};*)
	QUERY:C277([Alumnos_Anotaciones:11]; | ;[Alumnos_Anotaciones:11]Alumno_Numero:6=-$al_IdAlumno{$i})
	ORDER BY:C49([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11;<;[Alumnos_Anotaciones:11]Fecha:1;<)
	SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Auto_UUID:15;$at_uuidAnotaciones;[Alumnos_Anotaciones:11]Fecha:1;$ad_fechaAnotaciones;*)
	SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Motivo:3;$at_motivoAnotaciones;[Alumnos_Anotaciones:11]Año:11;$al_year;*)
	SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Signo:7;$at_signo;*)
	SELECTION TO ARRAY:C260
	COPY ARRAY:C226($al_year;$al_yearFiltro)
	AT_DistinctsArrayValues (->$al_yearFiltro)
	SORT ARRAY:C229($al_yearFiltro;<)
	
	AT_Initialize (->$at_fechaAnotaciones)
	For ($xx;1;Size of array:C274($ad_fechaAnotaciones))
		APPEND TO ARRAY:C911($at_fechaAnotaciones;String:C10($ad_fechaAnotaciones{$xx}))
	End for 
	
	OB SET ARRAY:C1227($o_anotacionesAlumno;"uuid";$at_uuidAnotaciones)
	OB SET ARRAY:C1227($o_anotacionesAlumno;"fecha";$at_fechaAnotaciones)
	OB SET ARRAY:C1227($o_anotacionesAlumno;"motivo";$at_motivoAnotaciones)
	OB SET ARRAY:C1227($o_anotacionesAlumno;"year";$al_year)
	OB SET ARRAY:C1227($o_anotacionesAlumno;"yearfiltro";$al_yearFiltro)
	OB SET ARRAY:C1227($o_anotacionesAlumno;"signo";$at_signo)
	$ao_anotaciones{$i}:=$o_anotacionesAlumno
	
	CLEAR VARIABLE:C89($o_anotacionesAlumno)
	
	
	C_OBJECT:C1216($o_castigosAlumno)
	QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=$al_IdAlumno{$i};*)
	QUERY:C277([Alumnos_Castigos:9]; | ;[Alumnos_Castigos:9]Alumno_Numero:8=-$al_IdAlumno{$i})
	ORDER BY:C49([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5;<;[Alumnos_Castigos:9]Fecha:9;<)
	SELECTION TO ARRAY:C260([Alumnos_Castigos:9]Auto_UUID:12;$at_uuidCastigos;[Alumnos_Castigos:9]Fecha:9;$ad_fechaCastigos;*)
	SELECTION TO ARRAY:C260([Alumnos_Castigos:9]Motivo:2;$at_motivoCastigos;[Alumnos_Castigos:9]Año:5;$al_yearCastigos;*)
	SELECTION TO ARRAY:C260([Alumnos_Castigos:9]Castigo_cumplido:4;$ab_cumplido;*)
	SELECTION TO ARRAY:C260
	COPY ARRAY:C226($al_yearCastigos;$al_yearFiltro)
	AT_DistinctsArrayValues (->$al_yearFiltro)
	SORT ARRAY:C229($al_yearFiltro;<)
	
	AT_Initialize (->$at_fechaCastigos)
	For ($xx;1;Size of array:C274($ad_fechaCastigos))
		APPEND TO ARRAY:C911($at_fechaCastigos;String:C10($ad_fechaCastigos{$xx}))
	End for 
	
	
	OB SET ARRAY:C1227($o_castigosAlumno;"uuid";$at_uuidCastigos)
	OB SET ARRAY:C1227($o_castigosAlumno;"fecha";$at_fechaCastigos)
	OB SET ARRAY:C1227($o_castigosAlumno;"motivo";$at_motivoCastigos)
	OB SET ARRAY:C1227($o_castigosAlumno;"year";$al_yearCastigos)
	OB SET ARRAY:C1227($o_castigosAlumno;"yearfiltro";$al_yearFiltro)
	OB SET ARRAY:C1227($o_castigosAlumno;"cumplido";$ab_cumplido)
	$ao_castigos{$i}:=$o_castigosAlumno
	CLEAR VARIABLE:C89($o_castigosAlumno)
	
	
	C_OBJECT:C1216($o_suspensiones)
	QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=$al_IdAlumno{$i};*)
	QUERY:C277([Alumnos_Suspensiones:12]; | ;[Alumnos_Suspensiones:12]Alumno_Numero:7=-$al_IdAlumno{$i})
	ORDER BY:C49([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1;<;[Alumnos_Suspensiones:12]Desde:5;<)
	SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12]Auto_UUID:12;$at_uuidSuspensiones;[Alumnos_Suspensiones:12]Desde:5;$ad_fechaDesde;[Alumnos_Suspensiones:12]Hasta:6;$ad_fechaHasta;*)
	SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12]Motivo:2;$at_motivoSuspensiones;[Alumnos_Suspensiones:12]Año:1;$al_yearSuspensiones;*)
	SELECTION TO ARRAY:C260
	COPY ARRAY:C226($al_yearSuspensiones;$al_yearFiltro)
	AT_DistinctsArrayValues (->$al_yearFiltro)
	SORT ARRAY:C229($al_yearFiltro;<)
	
	AT_Initialize (->$at_fechaDesde;->$at_fechaHasta)
	For ($xx;1;Size of array:C274($ad_fechaDesde))
		APPEND TO ARRAY:C911($at_fechaDesde;String:C10($ad_fechaDesde{$xx}))
		APPEND TO ARRAY:C911($at_fechaHasta;String:C10($ad_fechaHasta{$xx}))
	End for 
	
	OB SET ARRAY:C1227($o_suspensiones;"uuid";$at_uuidSuspensiones)
	OB SET ARRAY:C1227($o_suspensiones;"fecha_desde";$at_fechaDesde)
	OB SET ARRAY:C1227($o_suspensiones;"fecha_hasta";$at_fechaHasta)
	OB SET ARRAY:C1227($o_suspensiones;"motivo";$at_motivoSuspensiones)
	OB SET ARRAY:C1227($o_suspensiones;"year";$al_yearSuspensiones)
	OB SET ARRAY:C1227($o_suspensiones;"yearfiltro";$al_yearFiltro)
	$ao_suspensiones{$i}:=$o_suspensiones
	CLEAR VARIABLE:C89($o_suspensiones)
	
	
	C_OBJECT:C1216($o_licencias)
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=$al_IdAlumno{$i};*)
	QUERY:C277([Alumnos_Licencias:73]; | ;[Alumnos_Licencias:73]Alumno_numero:1=-$al_IdAlumno{$i})
	ORDER BY:C49([Alumnos_Licencias:73];[Alumnos_Licencias:73]Año:9;<;[Alumnos_Licencias:73]Desde:2;<)
	SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Auto_UUID:12;$at_uuidLicencias;[Alumnos_Licencias:73]Desde:2;$ad_fechaDesde;[Alumnos_Licencias:73]Hasta:3;$ad_fechaHasta;*)
	SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Tipo_licencia:4;$at_motivoLicencias;[Alumnos_Licencias:73]Año:9;$al_yearLicencias;*)
	SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Motivo_especial:13;$at_motivoEspecial;*)
	SELECTION TO ARRAY:C260
	COPY ARRAY:C226($al_yearLicencias;$al_yearFiltro)
	AT_DistinctsArrayValues (->$al_yearFiltro)
	SORT ARRAY:C229($al_yearFiltro;<)
	
	AT_Initialize (->$at_fechaDesde;->$at_fechaHasta)
	For ($xx;1;Size of array:C274($ad_fechaDesde))
		APPEND TO ARRAY:C911($at_fechaDesde;String:C10($ad_fechaDesde{$xx}))
		APPEND TO ARRAY:C911($at_fechaHasta;String:C10($ad_fechaHasta{$xx}))
	End for 
	
	OB SET ARRAY:C1227($o_licencias;"uuid";$at_uuidLicencias)
	OB SET ARRAY:C1227($o_licencias;"fecha_desde";$at_fechaDesde)
	OB SET ARRAY:C1227($o_licencias;"fecha_hasta";$at_fechaHasta)
	OB SET ARRAY:C1227($o_licencias;"motivo";$at_motivoLicencias)
	OB SET ARRAY:C1227($o_licencias;"motivoespecial";$at_motivoEspecial)
	OB SET ARRAY:C1227($o_licencias;"year";$al_yearLicencias)
	OB SET ARRAY:C1227($o_licencias;"yearfiltro";$al_yearFiltro)
	$ao_licencias{$i}:=$o_licencias
	CLEAR VARIABLE:C89($o_licencias)
	
	
End for 

OB SET ARRAY:C1227($ob_alumnos;"id";$al_IdAlumno)
OB SET ARRAY:C1227($ob_alumnos;"nombres";$at_nombreAlumnos)
OB SET ARRAY:C1227($ob_alumnos;"foto";$t_fotoAlumnos)
OB SET ARRAY:C1227($ob_alumnos;"academicas";$at_obsAcademicas)
OB SET ARRAY:C1227($ob_alumnos;"conductual";$at_obsConductual)
OB SET ARRAY:C1227($ob_alumnos;"anotaciones";$ao_anotaciones)
OB SET ARRAY:C1227($ob_alumnos;"castigos";$ao_castigos)
OB SET ARRAY:C1227($ob_alumnos;"suspensiones";$ao_suspensiones)
OB SET ARRAY:C1227($ob_alumnos;"licencias";$ao_licencias)
OB SET ARRAY:C1227($ob_alumnos;"status";$at_statusAlumnos)
OB SET:C1220($ob_alumnos;"alumnosclick";$alumnoClickID)


OB SET:C1220($y_raiz->;"alumnos";$ob_alumnos)