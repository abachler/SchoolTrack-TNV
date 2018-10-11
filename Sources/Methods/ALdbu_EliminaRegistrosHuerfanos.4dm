//%attributes = {}
  //ALdbu_EliminaRegistrosHuerfanos

ALL RECORDS:C47([Alumnos:2])

SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdAlumnos)


ARRAY POINTER:C280($aIDFieldPointers;0)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Actividades:28]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Anotaciones:11]Alumno_Numero:6)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Atrasos:55]Alumno_numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Calificaciones:208]ID_Alumno:6)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Conducta:8]Número_de_Alumno:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_ControlesMedicos:99]Numero_Alumno:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_EvaluacionValorica:23]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_EventosOrientacion:21]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_EventosPersonales:16]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_EventosPostEgreso:135]ID_Alumno:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_FichaMedica:13]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Historico:25]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Inasistencias:10]Alumno_Numero:4)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Licencias:73]Alumno_numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_ObsOrientacion:127]Alumno_Numero:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_ResultadosEgreso:130]ID_Alumno:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_SintesisAnual:210]ID_Alumno:4)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Suspensiones:12]Alumno_Numero:7)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Alumnos_Vacunas:101]Numero_Alumno:1)
APPEND TO ARRAY:C911($aIDFieldPointers;->[Asignaturas_Inasistencias:125]ID_Alumno:2)

$p:=IT_UThermometer (1;0;__ ("Compactando registros de datos de alumnos"))
For ($i;1;Size of array:C274($aIDFieldPointers))
	$fieldPointer:=$aIDFieldPointers{$i}
	$tablePointer:=Table:C252(Table:C252($fieldPointer))
	
	ALL RECORDS:C47($tablePointer->)
	CREATE SET:C116($tablePointer->;"todos")
	AL_RelateSelection ($fieldPointer;->$aIdAlumnos)
	CREATE SET:C116($tablePointer->;"relacionados")
	DIFFERENCE:C122("todos";"relacionados";"huerfanos")
	USE SET:C118("huerfanos")
	KRL_DeleteSelection ($tablePointer)
	
End for 
IT_UThermometer (-2;$p)


SET_ClearSets ("todos";"relacionados";"huerfanos")