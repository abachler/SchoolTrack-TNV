//%attributes = {}
  // MÉTODO: UD_v20120102_CalificacionesEval
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 02/01/12, 13:06:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // UD_v20120102_CalificacionesEval()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL

<>vb_ImportHistoricos_STX:=True:C214
$p:=IT_UThermometer (1;0;"Actualizando registros de calificaciones.\rEsta operación puede tomar tiempo, por favor espere a que finalice.")
READ WRITE:C146([Alumnos_Calificaciones:208])
ALL RECORDS:C47([Alumnos_Calificaciones:208])
APPLY TO SELECTION:C70([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503:=EV2_RegistroHaSidoEvaluado )
READ ONLY:C145([Alumnos_Calificaciones:208])
$p:=IT_UThermometer (-2;$p)

$p:=IT_UThermometer (1;0;"Actualizando registros de evalualación de aprendizajes.\rEsta operación puede tomar tiempo, por favor espere a que finalice.")
READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
ALL RECORDS:C47([Alumnos_EvaluacionAprendizajes:203])
APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=MPA_PeriodosEvaluados )
READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
$p:=IT_UThermometer (-2;$p)
<>vb_ImportHistoricos_STX:=False:C215

