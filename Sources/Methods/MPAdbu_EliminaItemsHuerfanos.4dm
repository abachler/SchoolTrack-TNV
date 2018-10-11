//%attributes = {}
  // MÉTODO: MPAdbu_EliminaItemsHuerfanos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/12, 10:17:12
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPAdbu_EliminaItemsHuerfanos()
  // ----------------------------------------------------
C_LONGINT:C283($l_IdProcesoUTherm)

ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_recNumAlumnos;0)
C_LONGINT:C283($i)




  // CODIGO PRINCIPAL
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5#0)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
dbu_FindUnrelatedRecords (->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[MPA_DefinicionEjes:185]ID:1)
KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6#0)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
dbu_FindUnrelatedRecords (->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[MPA_DefinicionDimensiones:188]ID:1)
KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7#0)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
dbu_FindUnrelatedRecords (->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;->[MPA_DefinicionCompetencias:187]ID:1)
KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])

QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3#0)
dbu_FindUnrelatedRecords (->[MPA_ObjetosMatriz:204]ID_Eje:3;->[MPA_DefinicionEjes:185]ID:1)
KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])

QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4#0)
dbu_FindUnrelatedRecords (->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]ID:1)
KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])

QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5#0)
dbu_FindUnrelatedRecords (->[MPA_ObjetosMatriz:204]ID_Competencia:5;->[MPA_DefinicionCompetencias:187]ID:1)
KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])

$l_IdProcesoUTherm:=IT_UThermometer (1;0;__ ("Compactando registro de evaluación de competencias."))
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2#0)
dbu_FindUnrelatedRecords (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
  //QUERY SELECTION([Alumnos_EvaluacionAprendizajes];[Alumnos_EvaluacionAprendizajes]PeriodosEvaluados_bitField=False)//20130530 ASM 
  //QUERY SELECTION([Alumnos_EvaluacionAprendizajes];[Alumnos_EvaluacionAprendizajes]PeriodosEvaluados_bitField>0)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63=0)
KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Calificaciones:208])
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)


LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNumAlumnos;"")
CREATE EMPTY SET:C140([Alumnos_EvaluacionAprendizajes:203];"Competencias_Malas")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando registros de evaluación de aprendizajes"))
For ($i;1;Size of array:C274($al_recNumAlumnos))
	GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturas)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=[Alumnos:2]numero:1)
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"Competencias_Alumno")
	QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->$al_IdAsignaturas;True:C214)
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"Competencias_OK")
	DIFFERENCE:C122("Competencias_Alumno";"Competencias_OK";"malitas")
	UNION:C120("Competencias_Malas";"malitas";"Competencias_Malas")
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumAlumnos))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
USE SET:C118("Competencias_Malas")

KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])

SET_ClearSets ("Competencias_Malas";"Competencias_Alumno";"Competencias_OK";"malitas")
IT_UThermometer (-2;$l_IdProcesoUTherm)

