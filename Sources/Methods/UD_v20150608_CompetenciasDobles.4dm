//%attributes = {}
  // UD_v20150608_CompetenciasDobles()
  // Por: Alberto Bachler K.: 08-06-15, 13:26:25
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283($proc)
$proc:=IT_UThermometer (1;0;__ ("Verificando Mapas de Aprendizaje ..."))
READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63=0)
KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])

READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63#0) & ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>!00-00-00!) & (Year of:C25([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)<<>gYear))
KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
IT_UThermometer (-2;$proc)

MPAdbu_VerificaRegistrosEval 