//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 02-03-18, 11:16:27
  // ----------------------------------------------------
  // Método: NIV_promoverNiveles
  // Descripción //MONO 184433
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_POINTER:C301($1;$y_niveles)
ARRAY LONGINT:C221($al_niveles;0)
ARRAY LONGINT:C221($al_idAlumnosPromovidos;0)
ARRAY LONGINT:C221($al_nivelesPromovidos;0)

C_LONGINT:C283(vl_UltimoAño;$l_idTermometro)
C_TEXT:C284(vt_NombreUltimoAñoEscolar)
C_BOOLEAN:C305($b_ok)
STR_ReadGlobals 
vl_UltimoAño:=<>gyear
vt_NombreUltimoAñoEscolar:=<>gNombreAgnoEscolar
  //variables de la promoción
bColacion:=0
bFotografia:=0
cbDeleteArchive:=0
cb_InscribeEnAsignaturas:=1
r2InitPropEvaluacion:=0

COPY ARRAY:C226($1->;$al_niveles)
$l_idTermometro:=IT_Progress (1;0;0;"Promoviendo Nivel ...")

CREATE EMPTY SET:C140([Alumnos:2];"$AlumnosPromovidos")

For ($i_nivel;1;Size of array:C274($al_niveles))
	$fia:=Find in array:C230(<>al_NumeroNivelesActivos;$al_niveles{$i_nivel})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_nivel/Size of array:C274($al_niveles);"Promoviendo Nivel: "+<>at_NombreNivelesActivos{$fia})
	
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$al_niveles{$i_nivel})
	CREATE SET:C116([Alumnos:2];"$AlumnosNivel")
	UNION:C120("$AlumnosPromovidos";"$AlumnosNivel";"$AlumnosPromovidos")
	CLEAR SET:C117("$AlumnosNivel")
	
	PERIODOS_LoadData ($al_niveles{$i_nivel})
	
	CAE_CreaHistoricoAlumnos (<>gyear;$al_niveles{$i_nivel})
	CAE_CreaHistoricoAsignaturas (<>gyear;$al_niveles{$i_nivel})
	CAE_PromueveAlumnos (<>gyear;$al_niveles{$i_nivel})
	CAE_ArchivaAprendizajes (<>gyear;$al_niveles{$i_nivel})
	
	READ ONLY:C145([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$al_niveles{$i_nivel})
	C_BLOB:C604($blob;0)
	SET BLOB SIZE:C606($blob;0)
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	KRL_RelateSelection (->[xxSTR_Subasignaturas:83]ID_Mother:6;->[Asignaturas:18]Numero:1;"")
	APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Data:4:=$blob)
	KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
	
	ARRAY LONGINT:C221($aIds;0)
	
	$pId:=IT_UThermometer (1;0;__ ("Cerrando registros de [Asignaturas_SintesisAnual] del año ")+vt_NombreUltimoAñoEscolar)
	  //fuerzo la ejecución del trigger en los registros del año anterior y pasarlos los Ids a negativo (en el trigger) impidiendo así que los registros de años anteriores se cargen al activar la relación
	READ WRITE:C146([Asignaturas_SintesisAnual:202])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$al_niveles{$i_nivel})
	KRL_RelateSelection (->[Asignaturas_SintesisAnual:202]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
	QUERY SELECTION:C341([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]Año:3=<>gyear)
	ARRAY TO SELECTION:C261($aIds;[Asignaturas_SintesisAnual:202]ID_Asignatura:2)
	SELECTION TO ARRAY:C260([Asignaturas_SintesisAnual:202]ID_Asignatura:2;$aIds)
	UNLOAD RECORD:C212([Asignaturas_SintesisAnual:202])
	READ ONLY:C145([Asignaturas_SintesisAnual:202])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_SintesisAnual] del año ")+vt_NombreUltimoAñoEscolar)
	READ WRITE:C146([Alumnos_SintesisAnual:210])
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=<>gyear;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]ID_Alumno:4>0)
	SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_SintesisAnual:210]ID_Alumno:4)
	UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
	READ ONLY:C145([Alumnos_SintesisAnual:210])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Cursos_SintesisAnual] del año ")+vt_NombreUltimoAñoEscolar)
	READ WRITE:C146([Cursos_SintesisAnual:63])
	QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]NumeroNivel:3=$al_niveles{$i_nivel};*)
	QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=<>gyear)
	SELECTION TO ARRAY:C260([Cursos_SintesisAnual:63]ID_Curso:52;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Cursos_SintesisAnual:63]ID_Curso:52)
	UNLOAD RECORD:C212([Cursos_SintesisAnual:63])
	READ ONLY:C145([Cursos_SintesisAnual:63])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_ComplementoEvaluacion]"))
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6>0;*)
	QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]Año:3=<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
	UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
	READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Calificaciones]"))
	READ WRITE:C146([Alumnos_Calificaciones:208])
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NIvel_Numero:4=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_Alumno:6>0;*)
	QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_Calificaciones:208]ID_Alumno:6)
	UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
	READ ONLY:C145([Alumnos_Calificaciones:208])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_EvaluacionesEspeciales]"))
	READ WRITE:C146([Alumnos_EvaluacionesEspeciales:211])
	QUERY:C277([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]Año:3;=;<>gyear;*)
	QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4>0)
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4)
	UNLOAD RECORD:C212([Alumnos_EvaluacionesEspeciales:211])
	READ ONLY:C145([Alumnos_EvaluacionesEspeciales:211])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Anotaciones]"))
	READ WRITE:C146([Alumnos_Anotaciones:11])
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6>0;*)
	QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Nivel_Numero:13;=;$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11;=;<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Alumno_Numero:6;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_Anotaciones:11]Alumno_Numero:6)
	UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
	READ ONLY:C145([Alumnos_Anotaciones:11])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Inasistencias]"))
	READ WRITE:C146([Alumnos_Inasistencias:10])
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4>0;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Nivel_Numero:9=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8;=;<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Alumno_Numero:4;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_Inasistencias:10]Alumno_Numero:4)
	UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
	READ ONLY:C145([Alumnos_Inasistencias:10])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Atrasos]"))
	READ WRITE:C146([Alumnos_Atrasos:55])
	QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1>0;*)
	QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Nivel_Numero:8=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Año:6;=;<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Alumno_numero:1;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_Atrasos:55]Alumno_numero:1)
	UNLOAD RECORD:C212([Alumnos_Atrasos:55])
	READ ONLY:C145([Alumnos_Atrasos:55])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Castigos]"))
	READ WRITE:C146([Alumnos_Castigos:9])
	QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8>0;*)
	QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Nivel_Numero:11=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Año:5;=;<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Castigos:9]Alumno_Numero:8;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_Castigos:9]Alumno_Numero:8)
	UNLOAD RECORD:C212([Alumnos_Castigos:9])
	READ ONLY:C145([Alumnos_Castigos:9])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Suspensiones]"))
	READ WRITE:C146([Alumnos_Suspensiones:12])
	QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7>0;*)
	QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Nivel_Numero:10=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Año:1;=;<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12]Alumno_Numero:7;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_Suspensiones:12]Alumno_Numero:7)
	UNLOAD RECORD:C212([Alumnos_Suspensiones:12])
	READ ONLY:C145([Alumnos_Suspensiones:12])
	
	$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Licencias]"))
	READ WRITE:C146([Alumnos_Licencias:73])
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1>0;*)
	QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Nivel_Numero:10=$al_niveles{$i_nivel};*)
	QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Año:9;=;<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Alumno_numero:1;$aIds)
	ARRAY TO SELECTION:C261($aIds;[Alumnos_Licencias:73]Alumno_numero:1)
	UNLOAD RECORD:C212([Alumnos_Licencias:73])
	READ ONLY:C145([Alumnos_Licencias:73])
	$pId:=IT_UThermometer (-2;$pId)
	
	CAE_InicializacionAsignaturas ($al_niveles{$i_nivel})
	CAE_InicializacionCursos ($al_niveles{$i_nivel})
	
	If (Find in array:C230(<>al_NumeroNivelesActivos;$al_niveles{$i_nivel}+1)>0)
		APPEND TO ARRAY:C911($al_nivelesPromovidos;$al_niveles{$i_nivel}+1)
	End if 
	
End for 

USE SET:C118("$AlumnosPromovidos")
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_idAlumnosPromovidos)
CLEAR SET:C117("$AlumnosPromovidos")

CAE_InicializacionAlumnos (->$al_idAlumnosPromovidos)

For ($i_nivel;1;Size of array:C274($al_nivelesPromovidos))
	dbu_CountSubjectStudents ($al_nivelesPromovidos{$i_nivel})
	CAE_AsignaNumerosLista ($al_nivelesPromovidos{$i_nivel})
	PCSrun_AS_AsignaNumerosDeLista (2;$al_nivelesPromovidos{$i_nivel})
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)