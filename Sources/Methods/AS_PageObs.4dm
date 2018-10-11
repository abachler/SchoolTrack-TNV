//%attributes = {}
  // AS_PageObs()
  //
  //
  // creado por: Alberto Bachler Klein: 28-12-15, 14:04:12
  // -----------------------------------------------------------
C_LONGINT:C283($l_alternateColor)
C_TEXT:C284($t_formulaNotas;$t_formulaObservaciones)


vlSTR_PeriodoObservaciones:=vlSTR_PeriodoSeleccionado  //20170623 RCH Retorno de observaciones
EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1;<>gYear;0;True:C214)


$l_alternateColor:=(245 << 16) | (245 << 8) | 245
OBJECT SET RGB COLORS:C628(*;"lb_observaciones";0x0000;0x00FFFFFF;$l_alternateColor)

$t_formulaObservaciones:=Choose:C955(vlSTR_PeriodoSeleccionado;"[Alumnos_ComplementoEvaluacion]Final_ObservacionesAcademicas";\
"[Alumnos_ComplementoEvaluacion]P01_Obs_Academicas";\
"[Alumnos_ComplementoEvaluacion]P02_Obs_Academicas";\
"[Alumnos_ComplementoEvaluacion]P03_Obs_Academicas";\
"[Alumnos_ComplementoEvaluacion]P04_Obs_Academicas";\
"[Alumnos_ComplementoEvaluacion]P05_Obs_Academicas")

$t_formulaNotas:=Choose:C955(vlSTR_PeriodoSeleccionado;"[Alumnos_Calificaciones]EvaluacionFinal_Literal";\
"[Alumnos_Calificaciones]P01_Final_Literal";\
"[Alumnos_Calificaciones]P02_Final_Literal";\
"[Alumnos_Calificaciones]P03_Final_Literal";\
"[Alumnos_Calificaciones]P04_Final_Literal";\
"[Alumnos_Calificaciones]P05_Final_Literal")

LISTBOX SET COLUMN FORMULA:C1203(*;"observaciones.observacion";$t_formulaObservaciones;Is text:K8:3)
LISTBOX SET COLUMN FORMULA:C1203(*;"observaciones.nota";$t_formulaNotas;Is alpha field:K8:1)

GET AUTOMATIC RELATIONS:C899($b_uno;$b_muchos)

SET FIELD RELATION:C919([Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;Automatic:K51:4;Structure configuration:K51:2)
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)


FORM GOTO PAGE:C247(4)


