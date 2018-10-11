//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-09-16, 12:29:38
  // ----------------------------------------------------
  // Método: STWA2_OWC_Diap
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($uuid;$t_accion)
C_POINTER:C301($y_ParameterNames;$y_ParameterValues)
C_LONGINT:C283($l_idUsuario)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)
$t_accion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")
If (Count parameters:C259=4)
	$t_accion:=$4
End if 
Case of 
	: ($t_accion="verificapermisodiap")
		C_OBJECT:C1216($ob_raiz)
		C_BOOLEAN:C305($b_valido)
		If (<>viSTR_ColegioUsaDiap=1)
			$b_valido:=Not:C34(STWA2_OWC_verificaProcesoAutori ($l_idUsuario;"DIAP_AbrePanel"))
		Else 
			$b_valido:=True:C214
		End if 
		$ob_raiz:=OB_Create 
		OB_SET_Boolean ($ob_raiz;$b_valido;"error")
		$t_resultado:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="loadDiap")
		  //cargo cursos 
		ARRAY TEXT:C222($at_curso;0)
		ARRAY LONGINT:C221($al_alumnosRN;0)
		ARRAY TEXT:C222($at_alumnosNombre;0)
		ARRAY TEXT:C222($at_AlumnosCurso;0)
		ARRAY TEXT:C222($at_DIAP_CursoUUID;0)
		ARRAY BOOLEAN:C223($ab_DIAP_CursoDisponible;0)
		C_BLOB:C604($xBlob)
		ARRAY LONGINT:C221($al_recNumAsig;0)
		C_LONGINT:C283($i)
		
		$xBlob:=PREF_fGetBlob (0;"DIAP_Cursos_"+String:C10(<>gyear))
		BLOB_Blob2Vars (->$xBlob;0;->$at_DIAP_CursoUUID;->$ab_DIAP_CursoDisponible)
		
		For ($i;1;Size of array:C274($ab_DIAP_CursoDisponible))
			If ($ab_DIAP_CursoDisponible{$i})
				QUERY:C277([Cursos:3];[Cursos:3]Auto_UUID:47=$at_DIAP_CursoUUID{$i})
				APPEND TO ARRAY:C911($at_curso;[Cursos:3]Curso:1)
			End if 
		End for 
		
		QUERY WITH ARRAY:C644([Alumnos:2]curso:20;$at_curso)
		
		  //MONO TICKET 197234 revisamos que las asignaturas inscritas en DIAP tengan las evaluaciones especiales activas.
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([DIAP_AlumnosAsignaturas:225])
		KRL_RelateSelection (->[DIAP_AlumnosAsignaturas:225]ID_Alumno:2;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]Año:7=<>gyear)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3;"")
		QUERY SELECTION BY ATTRIBUTE:C1424([Asignaturas:18];[Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales";=;False:C215)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsig;"")
		For ($i;1;Size of array:C274($al_recNumAsig))
			READ WRITE:C146([Asignaturas:18])
			GOTO RECORD:C242([Asignaturas:18];$al_recNumAsig{$i})
			$llaveAsig:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas:18]Numero:1))
			AS_creaRegistrosAluEvaEspecial ($llaveAsig)
			OB SET:C1220([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales";True:C214)
			SAVE RECORD:C53([Asignaturas:18])
			KRL_UnloadReadOnly (->[Asignaturas:18])
		End for 
		
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]no_de_lista:53;>)
		SELECTION TO ARRAY:C260([Alumnos:2];$al_alumnosRN;[Alumnos:2]apellidos_y_nombres:40;$at_alumnosNombre;[Alumnos:2]curso:20;$at_AlumnosCurso)
		
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$at_curso;"curso")
		OB_SET ($ob_raiz;->$al_alumnosRN;"alumnosRN")
		OB_SET ($ob_raiz;->$at_alumnosNombre;"alumnosNombre")
		OB_SET ($ob_raiz;->$at_AlumnosCurso;"alumnosCurso")
		$t_resultado:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="alumnoscurso")
		C_TEXT:C284($t_curso)
		
		$t_curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_curso)
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_curso)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]no_de_lista:53;>)
		SELECTION TO ARRAY:C260([Alumnos:2];$al_alumnosRN;[Alumnos:2]apellidos_y_nombres:40;$at_alumnosNombre;[Alumnos:2]curso:20;$at_AlumnosCurso)
		
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$al_alumnosRN;"alumnosRN")
		OB_SET ($ob_raiz;->$at_alumnosNombre;"alumnosNombre")
		OB_SET ($ob_raiz;->$at_AlumnosCurso;"alumnosCurso")
		$t_resultado:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="cargaArea")
		  //acá va el código para cargar las areas y todos los datos del DIAP
		ARRAY LONGINT:C221($al_IDtipoExamen;0)
		ARRAY TEXT:C222($at_tipoExamen;0)
		ARRAY TEXT:C222(a_LB_Materia;0)
		ARRAY TEXT:C222(a_LB_UUID_Materia;0)
		ARRAY BOOLEAN:C223(a_LB_MateriaDisponible;0)
		ARRAY LONGINT:C221(a_LB_MateriaEstilo;0)
		ARRAY LONGINT:C221($al_AsignaturasID;0)
		C_TEXT:C284(t_UUID_MAteriaObligatoria)
		C_BOOLEAN:C305($b_escrito;$b_creado)
		
		DIAP_ConfigCargaTipoExamen (->$al_IDtipoExamen;->$at_tipoExamen)
		
		CREATE EMPTY SET:C140([Asignaturas:18];"inscritas")
		DIAP_ConfigCargaSubsectores (->a_LB_Materia;->a_LB_UUID_Materia;->a_LB_MateriaDisponible;->t_UUID_MAteriaObligatoria)
		For ($i;1;Size of array:C274(a_LB_UUID_Materia))
			If (a_LB_MateriaDisponible{$i})
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Materia_UUID:46=a_LB_UUID_Materia{$i})
				CREATE SET:C116([Asignaturas:18];"temporal")
				UNION:C120("inscritas";"temporal";"inscritas")
			End if 
		End for 
		USE SET:C118("inscritas")
		AT_DistinctsFieldValues (->[Asignaturas:18]Numero:1;->$al_AsignaturasID)
		SET_ClearSets ("inscritas";"temporal")
		
		ARRAY TEXT:C222($at_area;0)
		$l_rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"alumnoRN"))
		GOTO RECORD:C242([Alumnos:2];$l_rnAlumno)
		  //MONO Ticket 168851 verificamos que el alumno por lo menos tenga la inscripción de la obligatoria
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & ;[Asignaturas:18]Materia_UUID:46=t_UUID_MAteriaObligatoria)
		If (Records in selection:C76([Alumnos_Calificaciones:208])=1)
			$b_creado:=DIAP_InscribeAsignatura ([Alumnos_Calificaciones:208]ID_Alumno:6;[Alumnos_Calificaciones:208]ID_Asignatura:5;1;1;1)
		End if 
		
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
		QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$al_AsignaturasID;True:C214)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
		AT_DistinctsFieldValues (->[Asignaturas:18]GrupoEstadistico:89;->$at_area)
		SORT ARRAY:C229($at_area;<)
		  //SORT ARRAY($at_area;>)
		CREATE SET:C116([Asignaturas:18];"asignaturas")
		
		C_OBJECT:C1216($ob_raiz;$ob_area;$ob_asignatura)
		$ob_raiz:=OB_Create 
		
		For ($l_indiceArea;1;Size of array:C274($at_area))
			ARRAY TEXT:C222($at_asignaturas;0)
			ARRAY LONGINT:C221($al_RecNumAsignatura;0)
			
			USE SET:C118("asignaturas")
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]GrupoEstadistico:89=$at_area{$l_indiceArea})
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumAsignatura;"")
			$l_rowspan:=Records in selection:C76([Asignaturas:18])
			
			$at_area{$l_indiceArea}:=ST_GetCleanString ($at_area{$l_indiceArea})
			If ($at_area{$l_indiceArea}="")
				$at_area{$l_indiceArea}:="Área sin nombre verificar grupo estadístico de las asignaturas del alumno"
			End if 
			
			$ob_area:=OB_Create 
			OB_SET ($ob_area;->$at_area{$l_indiceArea};"area")
			OB_SET ($ob_area;->$l_rowspan;"rowspan")
			
			
			For ($i;1;Size of array:C274($al_RecNumAsignatura))
				
				GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsignatura{$i})
				EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				
				QUERY:C277([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3=[Asignaturas:18]Numero:1;*)
				QUERY:C277([DIAP_AlumnosAsignaturas:225]; & ;[DIAP_AlumnosAsignaturas:225]ID_Alumno:2=[Alumnos:2]numero:1)
				$b_tomada:=(Records in selection:C76([DIAP_AlumnosAsignaturas:225])>0)
				$l_pos:=Find in array:C230($al_IDtipoExamen;[DIAP_AlumnosAsignaturas:225]ID_TipoExamen:6)
				If ($l_pos#-1)
					$b_escrito:=Choose:C955($at_tipoExamen{$l_pos}="escrito";True:C214;False:C215)
				End if 
				
				$ob_asignatura:=OB_Create 
				
				  //cargo exámen y evaluaciones
				QUERY:C277([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				$t_evaluacionExamen:=[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Literal:12
				$t_evaluacionExamenExtra:=[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Literal:92  //MONO DIAP: Extra exámen
				$t_evaluacioneval3:=[Alumnos_EvaluacionesEspeciales:211]P01_Eval01_Literal:17
				$t_evaluacioneval4:=[Alumnos_EvaluacionesEspeciales:211]P02_Eval01_Literal:32
				
				  //cargo evaluaciones año anterior
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NIvel_Numero:4=([Alumnos:2]nivel_numero:29-1);*)
				QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_Alumno:6=-[Alumnos:2]numero:1)
				
				KRL_RelateSelection (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;"")
				QUERY SELECTION:C341([Asignaturas_Historico:84];[Asignaturas_Historico:84]Materia_UUID:45=[Asignaturas:18]Materia_UUID:46)
				
				QUERY:C277([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6=[Asignaturas_Historico:84]ID_RegistroHistorico:1;*)
				QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4=-[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]Año:3=[Asignaturas_Historico:84]Año:5)
				$t_evaluacioneval1:=[Alumnos_EvaluacionesEspeciales:211]P01_Eval01_Literal:17
				$t_evaluacioneval2:=[Alumnos_EvaluacionesEspeciales:211]P02_Eval01_Literal:32
				
				  //agrego nodo con las calificaciones de los años anteriores
				ARRAY TEXT:C222($at_calificaciones;0)
				APPEND TO ARRAY:C911($at_calificaciones;$t_evaluacioneval1)
				APPEND TO ARRAY:C911($at_calificaciones;$t_evaluacioneval2)
				APPEND TO ARRAY:C911($at_calificaciones;$t_evaluacioneval3)
				APPEND TO ARRAY:C911($at_calificaciones;$t_evaluacioneval4)
				
				$l_recnum:=Record number:C243([Asignaturas:18])
				OB_SET ($ob_asignatura;->$at_calificaciones;"calificaciones")
				OB_SET ($ob_asignatura;->[Asignaturas:18]Asignatura:3;"asignatura")
				OB_SET ($ob_asignatura;->$t_evaluacionExamen;"NotaExamen")
				OB_SET ($ob_asignatura;->$t_evaluacionExamenExtra;"NotaExamenExtra")  //MONO DIAP: Extra exámen
				OB_SET ($ob_asignatura;->$l_recnum;"recNumAsignatura")
				OB_SET ($ob_asignatura;->$b_tomada;"tomada")
				OB_SET ($ob_asignatura;->$b_escrito;"escrito")
				OB_SET ($ob_asignatura;->[DIAP_AlumnosAsignaturas:225]usaExtraExamen:9;"usaExtraExamen")  //MONO DIAP: Extra exámen
				OB_SET ($ob_asignatura;->[DIAP_AlumnosAsignaturas:225]Auto_UUID:1;"UUID_DiapAluAsig")  //MONO DIAP: Extra exámen
				
				  //realizo validaciones del estilo de evaluación de la asignatura
				Case of 
					: (iEvaluationMode=Notas)
						$r_minimo:=rGradesFrom
						$r_maximo:=rGradesTo
						$t_evaluacion:="Notas"
					: (iEvaluationMode=Puntos)
						$r_minimo:=rPointsFrom
						$r_maximo:=rPointsTo
						$t_evaluacion:="Puntos"
					: (iEvaluationMode=Simbolos)
						$r_minimo:=0
						$r_maximo:=100
						$t_evaluacion:="Simbolos"
				End case 
				
				C_OBJECT:C1216($ob_estilo)
				$ob_estilo:=OB_Create 
				
				OB_SET ($ob_estilo;-><>vs_AppDecimalSeparator;"separador")
				OB_SET ($ob_estilo;->$r_minimo;"minimo")
				OB_SET ($ob_estilo;->$r_maximo;"maximo")
				OB_SET ($ob_estilo;->aSymbol;"simbolos")
				OB_SET ($ob_estilo;->$t_evaluacion;"EvaluationMode")
				OB_SET ($ob_estilo;->iGradesDec;"iGradesDec")
				OB_SET ($ob_asignatura;->$ob_estilo;"estilo")
				OB_SET ($ob_area;->$ob_asignatura;String:C10($i))
				
			End for 
			
			OB SET:C1220($ob_raiz;$at_area{$l_indiceArea};$ob_area)  //MONO: al utilizar el componente no agrega correctamente el nodo del area al raiz sumando nodos vacios que lo envuelven. 
			
		End for 
		
		  //Cargo las observaciones
		ARRAY TEXT:C222($at_observaciones;0)
		ARRAY TEXT:C222($at_observaciones;2)
		QUERY:C277([DIAP_Observaciones:207];[DIAP_Observaciones:207]ID_alumno:2=[Alumnos:2]numero:1;*)
		QUERY:C277([DIAP_Observaciones:207]; & ;[DIAP_Observaciones:207]Año:3=<>gyear)
		$at_observaciones{1}:=[DIAP_Observaciones:207]Observacion_Aleman:5
		$at_observaciones{2}:=[DIAP_Observaciones:207]Observacion_Español:4
		
		OB_SET ($ob_raiz;->$at_observaciones;"obsAlumno")
		$t_resultado:=OB_Object2Json ($ob_raiz)
End case 

$0:=$t_resultado