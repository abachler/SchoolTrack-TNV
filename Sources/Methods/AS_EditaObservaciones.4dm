//%attributes = {}
  // AS_EditaObservaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 28-12-15, 14:00:42
  // -----------------------------------------------------------
C_LONGINT:C283($l_columna;$l_fila)

LISTBOX GET CELL POSITION:C971(*;"lb_observaciones";$l_columna;$l_fila)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
KRL_GotoSelectedRecord (->[Alumnos_ComplementoEvaluacion:209];$l_fila;True:C214)
KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;False:C215)
WDW_OpenFormWindow (->[Alumnos_ComplementoEvaluacion:209];"Observaciones";0;8;__ ("Observaciones"))
KRL_ModifyRecord (->[Alumnos_ComplementoEvaluacion:209];"Observaciones")
CLOSE WINDOW:C154


