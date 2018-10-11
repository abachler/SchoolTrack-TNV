//%attributes = {}
  //dhQRY_BusquedasPorAgnos
C_POINTER:C301($baseKey)
$searchKey:=$1
$baseKey:=$2

$founded:=-1
$añoEspecificadoEnConsulta:=dhQRY_esBusquedaPorAgno 
If ((vb_ConsultaMultiAño=True:C214) | ($añoEspecificadoEnConsulta))
	Case of 
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_Anotaciones:11])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_Anotaciones:11]Alumno_Numero:6)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Alumno_Numero:6;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_Atrasos:55])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_Atrasos:55]Alumno_numero:1)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Alumno_numero:1;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_Castigos:9])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_Castigos:9]Alumno_Numero:8)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_Castigos:9]Alumno_Numero:8;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_Inasistencias:10])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_Inasistencias:10]Alumno_Numero:4)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Alumno_Numero:4;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_Suspensiones:12])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_Suspensiones:12]Alumno_Numero:7)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12]Alumno_Numero:7;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_Licencias:73])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_Licencias:73]Alumno_numero:1)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Alumno_numero:1;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_EvaluacionAprendizajes:203])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_SintesisAnual:210])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_SintesisAnual:210]ID_Alumno:4)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Asignaturas_SintesisAnual:202])) & (Field:C253($baseKey)=Field:C253(->[Asignaturas_SintesisAnual:202]ID_Asignatura:2)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Asignaturas_SintesisAnual:202]ID_Asignatura:2;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_Calificaciones:208])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_Calificaciones:208]ID_Alumno:6)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_ComplementoEvaluacion:209])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Alumnos_ComplementoEvaluacion:209])) & (Field:C253($baseKey)=Field:C253(->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)))
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644($searchKey->;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((Table:C252($baseKey)=Table:C252(->[Cursos_SintesisAnual:63])) & (Field:C253($baseKey)=Field:C253(->[Cursos_SintesisAnual:63]Curso:5)))
			ARRAY TEXT:C222($aCurso;0)
			SELECTION TO ARRAY:C260([Cursos_SintesisAnual:63]Curso:5;$aCurso)
			AT_ABSNumericArray (->$aCurso)
			QUERY WITH ARRAY:C644($searchKey->;$aCurso)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		: ((KRL_isSameField ($baseKey;->[Alumnos_SintesisAnual:210]LlavePrincipal:5)) & (Table:C252($searchKey)=Table:C252(->[Alumnos:2])))  //20140404 RCH Soluciona consultas repitentes año anterior
			ARRAY LONGINT:C221($aIds;0)
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIds)
			AT_ABSNumericArray (->$aIds)
			QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$aIds)
			$founded:=Records in selection:C76(vyQRY_TablePointer->)
			
		Else 
			$founded:=-1
	End case 
End if 

$0:=$founded
